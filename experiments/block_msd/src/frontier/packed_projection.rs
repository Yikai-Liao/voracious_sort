//! Highest-varying-bit coordinates with a conservative original-key remainder.
use super::{Classifier, NativeKey};
use std::marker::PhantomData;

pub(super) struct Selection<U> {
    mask: U,
    pub bits: usize,
    pub remaining: usize,
}

impl<U: NativeKey> Selection<U> {
    pub(super) fn new(variation: U, cap: usize, budget: usize) -> Option<Self> {
        let variation = variation & U::mask(cap);
        let q = variation.count_ones() as usize;
        let width = U::BITS - variation.leading_zeros() as usize;
        // Dense coordinates cannot remove a hole or improve the frontier.
        if q == 0 || q == width {
            return None;
        }
        let bits = q.min(budget).min(32);
        if bits == 0 {
            return None;
        }
        let raw = variation.to_u128();
        let mut selected = 0u128;
        let mut count = 0;
        for bit in (0..width).rev() {
            if raw & (1u128 << bit) != 0 {
                selected |= 1u128 << bit;
                count += 1;
                if count == bits {
                    break;
                }
            }
        }
        let active_bytes = (0..U::BITS / 8)
            .filter(|&byte| (selected >> (8 * byte)) & 255 != 0)
            .count();
        if active_bytes <= (bits + 7) / 8 {
            return None;
        }
        Some(Self {
            mask: U::from_u128(selected),
            bits,
            remaining: if bits == q {
                0
            } else {
                selected.trailing_zeros() as usize
            },
        })
    }
}

pub(super) struct Packed<U, L> {
    mask: U,
    moves: [U; 7],
    segments: usize,
    shifts: [usize; 2],
    masks: [u32; 2],
    lower_bits: u32,
    bits: usize,
    remaining: usize,
    _label: PhantomData<L>,
}

impl<U: NativeKey, L: NativeKey> Packed<U, L> {
    pub(super) fn new(selection: Selection<U>) -> Self {
        assert!(selection.bits <= L::BITS && selection.bits <= 32);
        // Precompute a portable parallel bit gather. A move of distance 2^i
        // packs the selected bits over the corresponding holes. All u128 work
        // is node setup; per-record arithmetic retains the original key width.
        let raw = selection.mask.to_u128();
        let mut mask = raw;
        let mut holes = (!mask) << 1;
        let mut moves = [U::from_u128(0); 7];
        for (stage, movement) in moves.iter_mut().enumerate() {
            let mut prefix = holes ^ (holes << 1);
            for shift in [2, 4, 8, 16, 32, 64] {
                prefix ^= prefix << shift;
            }
            let moving = prefix & mask;
            *movement = U::from_u128(moving);
            mask = (mask ^ moving) | (moving >> (1 << stage));
            holes &= !prefix;
        }
        let mut source = 0;
        let mut rank = 0;
        let mut segments = 0;
        let mut shifts = [0; 2];
        let mut masks = [0; 2];
        while source < U::BITS {
            if raw & (1u128 << source) == 0 {
                source += 1;
                continue;
            }
            let start = source;
            while source < U::BITS && raw & (1u128 << source) != 0 {
                source += 1;
            }
            let length = source - start;
            if segments < 2 {
                shifts[segments] = start - rank;
                masks[segments] = (((1u64 << length) - 1) << rank) as u32;
            }
            segments += 1;
            rank += length;
        }
        Self {
            segments,
            shifts,
            masks,
            mask: selection.mask,
            moves,
            lower_bits: (raw as u64).count_ones(),
            bits: selection.bits,
            remaining: selection.remaining,
            _label: PhantomData,
        }
    }

    #[inline]
    fn gather(&self, key: U) -> u32 {
        if let Some(label) = key.extract_packed(self.mask, self.lower_bits) {
            return label;
        }
        // Contiguous fields and two-field keys need fewer operations than a
        // full portable parallel gather. The other path has fixed shifts.
        if self.segments <= 2 {
            let first = (key >> self.shifts[0]).to_u32() & self.masks[0];
            return if self.segments <= 1 {
                first
            } else {
                first | ((key >> self.shifts[1]).to_u32() & self.masks[1])
            };
        }
        let mut packed = key & self.mask;
        macro_rules! gather {
            ($stage:literal, $distance:literal) => {
                if $distance < U::BITS {
                    let moving = packed & self.moves[$stage];
                    packed = packed ^ moving;
                    packed |= moving >> $distance;
                }
            };
        }
        gather!(0, 1);
        gather!(1, 2);
        gather!(2, 4);
        gather!(3, 8);
        gather!(4, 16);
        gather!(5, 32);
        gather!(6, 64);
        packed.to_u32()
    }

    pub(super) fn variation(&self) -> L {
        L::from_u128((1u128 << self.bits) - 1)
    }
}

impl<U: NativeKey, L: NativeKey> Classifier<U> for Packed<U, L> {
    type Label = L;
    const PACKED: bool = true;
    #[inline]
    fn label(&self, key: U) -> L {
        L::from_u128(self.gather(key) as u128)
    }
    fn remaining(&self, _: U) -> usize {
        self.remaining
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn full_and_partial_projection_follow_original_key_coordinates() {
        let mut state = 42u128;
        for q in [
            1usize, 7, 8, 9, 15, 16, 17, 23, 24, 25, 31, 32, 33, 63, 64, 65,
            127, 128,
        ] {
            let positions: Vec<_> = (0..q)
                .map(|j| if q == 1 { 127 } else { j * 127 / (q - 1) })
                .collect();
            let mask = positions.iter().fold(0, |mask, &p| mask | (1u128 << p));
            for budget in [8usize, 16, 24, 32] {
                let Some(selection) = Selection::new(mask, 128, budget) else {
                    continue;
                };
                let chosen = &positions[q - selection.bits..];
                assert_eq!(
                    selection.remaining,
                    if selection.bits == q { 0 } else { chosen[0] }
                );
                let projection = Packed::<_, u32>::new(selection);
                let mut keys = Vec::new();
                for _ in 0..1024 {
                    state =
                        state.wrapping_mul(6364136223846793005).wrapping_add(1);
                    let key = state & mask;
                    let expected =
                        chosen.iter().enumerate().fold(0, |x, (j, &p)| {
                            x | ((((key >> p) & 1) as u32) << j)
                        });
                    assert_eq!(
                        projection.label(key),
                        expected,
                        "q={q} budget={budget}"
                    );
                    assert_eq!(projection.label(key | !mask), expected);
                    keys.push(key);
                }
                keys.sort();
                for pair in keys.windows(2) {
                    assert!(
                        projection.label(pair[0]) <= projection.label(pair[1])
                    );
                    if projection.label(pair[0]) == projection.label(pair[1]) {
                        assert_eq!(
                            pair[0] >> projection.remaining,
                            pair[1] >> projection.remaining
                        );
                    }
                }
            }
        }
    }

    #[test]
    fn portable_narrow_gather_and_exhaustive_byte_subsets() {
        for mask in 0u16..=u16::MAX {
            if mask.count_ones() > 8 {
                continue;
            }
            let projection = Packed::<_, u8>::new(Selection {
                mask,
                bits: mask.count_ones() as usize,
                remaining: 0,
            });
            let positions: Vec<_> =
                (0..16).filter(|bit| mask & (1 << bit) != 0).collect();
            for label in 0..1usize << positions.len() {
                let key =
                    positions.iter().enumerate().fold(0u16, |key, (j, &p)| {
                        key | ((((label >> j) & 1) as u16) << p)
                    });
                assert_eq!(projection.label(key), label as u8);
            }
        }
    }
}

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
        if q == 0 || q == width || budget == 0 {
            return None;
        }
        let raw = variation.to_u128();
        let low = width.saturating_sub(budget);
        let prefix = if low == 0 { raw } else { raw & !((1u128 << low) - 1) };
        let active_bytes = |mask: u128| {
            (0..U::BITS / 8)
                .filter(|&byte| (mask >> (byte * 8)) & 255 != 0)
                .count()
        };
        // A complete tag must not add a whole-record pass over the ordinary
        // first node. Otherwise already-ordered children could make the extra
        // passes pure regression.
        let complete =
            q <= budget && q <= 32 && (q + 7) / 8 <= active_bytes(prefix);
        // Partial compression keeps exactly the ordinary prefix's partition.
        // Spending holes on lower bits changes fanout and can turn ordered
        // large runs into tens of thousands of costly small leaves.
        let selected = if complete { raw } else { prefix };
        let bits = selected.count_ones() as usize;
        if bits == 0 || bits > 32 || active_bytes(selected) <= (bits + 7) / 8 {
            return None;
        }
        if !U::HAS_PACKED_INSTRUCTION {
            let field = selected >> selected.trailing_zeros();
            let contiguous = field == (1u128 << bits) - 1;
            // A single field needs only a shift. Arbitrary software gathers
            // failed to amortize against scalar classifiers or when merely
            // replacing a partial prefix. Full multiword completion retains
            // the measured benefit of removing wide-key child processing.
            if !contiguous
                && (U::BITS <= usize::BITS as usize || selected != raw)
            {
                return None;
            }
        }
        Some(Self {
            mask: U::from_u128(selected),
            bits,
            remaining: if selected == raw {
                0
            } else {
                selected.trailing_zeros() as usize
            },
        })
    }

    // Diagnostic only: preserve the earlier cohort's information-budget
    // policy so work counters can reproduce its observed tiny-leaf regression.
    pub(super) fn aggressive(
        variation: U,
        cap: usize,
        budget: usize,
    ) -> Option<Self> {
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
    const USE_COMPACT_RADIX: bool = true;
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

#[cfg(test)]
mod bounded_tests {
    use super::*;
    #[test]
    fn software_gather_preserves_scalar_and_partial_prefix_routes() {
        let scalar = Selection::<u32>::new((1 << 18) | 1, 32, 24);
        assert_eq!(
            scalar.is_some(),
            <u32 as NativeKey>::HAS_PACKED_INSTRUCTION
        );
        let mask = (0..32).fold(0u128, |v, j| v | (1u128 << (j * 127 / 31)));
        let partial = Selection::new(mask, 128, 24);
        assert_eq!(
            partial.is_some(),
            <u128 as NativeKey>::HAS_PACKED_INSTRUCTION
        );
        if let Some(partial) = partial {
            assert!(partial.remaining > 0);
        }
        let wide = [0, 18, 36, 54, 72, 90, 108, 126]
            .iter()
            .fold(0u128, |mask, bit| mask | (1u128 << bit));
        let full = Selection::new(wide, 128, 24).unwrap();
        assert_eq!(full.remaining, 0);
        assert_eq!(full.bits, 8);
        let field = Selection::new(0xffu128 << 60, 128, 24).unwrap();
        assert_eq!(field.bits, 8);
        assert_eq!(field.remaining, 0);
    }
    #[test]
    fn partial_tags_keep_the_old_partition_and_never_add_a_root_pass() {
        assert!(Selection::<u32>::aggressive(0xff01ffff, 32, 24).is_some());
        assert!(Selection::<u32>::new(0xff01ffff, 32, 24).is_none());
        // A complete three-byte tag must not replace a one-byte root whose
        // already-ordered suffix could otherwise return without moving again.
        assert!(Selection::<u128>::new(
            (0xfu128 << 124) | ((1 << 20) - 1),
            128,
            24
        )
        .is_none());
        let mut state = 42u128;
        for budget in [8usize, 16, 24, 32] {
            for _ in 0..10000 {
                state = state.wrapping_mul(0xda942042e4dd58b5).wrapping_add(1);
                let variation = state ^ (state >> 17);
                let Some(s) = Selection::<u128>::new(variation, 128, budget)
                else {
                    continue;
                };
                let width = 128 - variation.leading_zeros() as usize;
                let low = width.saturating_sub(budget);
                let prefix = if low == 0 {
                    variation
                } else {
                    variation & !((1u128 << low) - 1)
                };
                let passes =
                    (0..16).filter(|&b| (prefix >> (8 * b)) & 255 != 0).count();
                assert!((s.bits + 7) / 8 <= passes);
                if s.remaining > 0 {
                    assert_eq!(s.mask, prefix);
                } else {
                    assert_eq!(s.mask, variation);
                }
            }
        }
    }
}

//! A sampled small alphabet with exact membership and a majority certificate.
//! A byte fingerprint accelerates lookup; every hit compares the full key.
use super::{
    work, Classifier, Converted, NativeKey, RadixKey, Radixable, Work,
};

pub(super) struct KeySet<U, const CAPACITY: usize, const FINGERPRINT: bool> {
    keys: [U; CAPACITY],
    len: usize,
    mask: U,
    remaining: usize,
    shift: usize,
    ranks: [u8; 256],
}

impl<U: NativeKey, const N: usize, const F: bool> KeySet<U, N, F> {
    fn new(
        keys: [U; N],
        len: usize,
        mask: U,
        remaining: usize,
    ) -> Option<Self> {
        assert!(N > 1 && N <= 127 && len <= N);
        let mut set =
            Self { keys, len, mask, remaining, shift: 0, ranks: [0; 256] };
        if F {
            // A single contiguous byte is cheap on every supported key width.
            // Reject this cost gate if no byte window separates the candidates.
            for shift in (0..=U::BITS - 8).rev() {
                set.ranks.fill(0);
                let mut unique = true;
                for (rank, &key) in set.keys[..len].iter().enumerate() {
                    let digit = ((key >> shift).to_u32() & 255) as usize;
                    if set.ranks[digit] != 0 {
                        unique = false;
                        break;
                    }
                    set.ranks[digit] = (rank + 1) as u8;
                }
                if unique {
                    set.shift = shift;
                    return Some(set);
                }
            }
            None
        } else {
            Some(set)
        }
    }

    #[inline]
    fn lookup_masked(&self, key: U) -> Option<usize> {
        if F {
            let slot =
                self.ranks[((key >> self.shift).to_u32() & 255) as usize];
            if slot != 0 {
                let rank = (slot - 1) as usize;
                // Fingerprints can collide with unseen keys, never with the
                // selected dictionary. Full equality owns membership proof.
                if self.keys[rank] == key {
                    return Some(rank);
                }
            }
            None
        } else {
            self.keys[..self.len].binary_search(&key).ok()
        }
    }

    pub(super) fn approve<T: Radixable<K>, K: RadixKey>(
        self,
        arr: &[T],
        stats: &mut Work,
    ) -> Option<(Self, usize)>
    where
        <T as Radixable<K>>::Key: RadixKey<Key = U>,
    {
        let mut covered = 0;
        for item in arr {
            covered += usize::from(
                self.lookup_masked(item.into_key_type() & self.mask).is_some(),
            );
        }
        work! {stats.candidate_records+=arr.len();}
        if covered > arr.len() / 2 {
            Some((self, covered))
        } else {
            None
        }
    }

    pub(super) fn variation(&self) -> u8 {
        u8::MAX >> ((2 * self.len) as u8).leading_zeros()
    }
}

impl<U: NativeKey, const N: usize, const F: bool> Classifier<U>
    for KeySet<U, N, F>
{
    type Label = u8;
    const USE_COMPACT_RADIX: bool = true;
    #[inline]
    fn label(&self, key: U) -> u8 {
        let key = key & self.mask;
        if F {
            if let Some(rank) = self.lookup_masked(key) {
                return (2 * rank + 1) as u8;
            }
            (2 * self.keys[..self.len].partition_point(|&pivot| pivot < key))
                as u8
        } else {
            match self.keys[..self.len].binary_search(&key) {
                Ok(rank) => (2 * rank + 1) as u8,
                Err(gap) => (2 * gap) as u8,
            }
        }
    }
    fn remaining(&self, key: U) -> usize {
        if self.lookup_masked(key & self.mask).is_some() {
            0
        } else {
            self.remaining
        }
    }
}

#[inline(never)]
pub(super) fn sample<
    T: Radixable<K>,
    K: RadixKey,
    const N: usize,
    const F: bool,
>(
    arr: &[T],
    cap: usize,
    stats: &mut Work,
) -> Option<KeySet<Converted<T, K>, N, F>>
where
    Converted<T, K>: NativeKey,
{
    let zero = Converted::<T, K>::from_u128(0);
    let mask = Converted::<T, K>::mask(cap);
    let mut samples = [zero; 64];
    let span = arr.len() - 1;
    for (i, slot) in samples.iter_mut().enumerate() {
        *slot =
            arr[i * (span / 63) + i * (span % 63) / 63].into_key_type() & mask;
    }
    work! {stats.probe_records+=64;}
    samples.sort_unstable();
    let distinct = 1 + samples.windows(2).filter(|p| p[0] != p[1]).count();
    let minimum = if distinct <= N { 1 } else { 3 };
    let mut keys = [zero; N];
    let mut len = 0;
    let mut support = 0;
    let mut start = 0;
    while start < samples.len() {
        let mut end = start + 1;
        while end < samples.len() && samples[end] == samples[start] {
            end += 1;
        }
        let count = end - start;
        if count >= minimum {
            if len == N {
                return None;
            }
            keys[len] = samples[start];
            len += 1;
            support += count;
        }
        start = end;
    }
    // A separate exact coverage scan needs a stronger signal than scan-fused
    // PrefixBand. This gate estimates cost; it never supplies correctness.
    if len < 2 || support < 48 {
        return None;
    }
    KeySet::new(keys, len, mask, cap)
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn dictionary_and_every_gap_follow_full_key_order_for_both_lookups() {
        for bits in 2usize..=8 {
            let limit = 1u16 << bits;
            for step in 1..=limit / 2 {
                let mut keys = [0u16; 32];
                let len = (((limit - 1) / step) as usize).min(keys.len());
                if len < 2 {
                    continue;
                }
                for (i, key) in keys[..len].iter_mut().enumerate() {
                    *key = (i as u16 + 1) * step;
                }
                let plain =
                    KeySet::<_, 32, false>::new(keys, len, limit - 1, bits)
                        .unwrap();
                let fast =
                    KeySet::<_, 32, true>::new(keys, len, limit - 1, bits)
                        .unwrap();
                let mut previous = 0;
                for key in 0..limit {
                    let label = fast.label(key | 0x8000);
                    assert!(label >= previous);
                    assert_eq!(label, plain.label(key));
                    assert_eq!(label & !fast.variation(), 0);
                    assert_eq!(label % 2 == 1, keys[..len].contains(&key));
                    assert_eq!(
                        fast.remaining(key),
                        if label % 2 == 1 { 0 } else { bits }
                    );
                    previous = label;
                }
            }
        }
    }
    #[test]
    fn collisions_with_unseen_keys_never_create_false_exact_hits() {
        let mut keys = [0u128; 8];
        keys[..3].copy_from_slice(&[0x12340000, 0x45670000, 0x789a0000]);
        let set = KeySet::<_, 8, true>::new(keys, 3, u128::MAX, 128).unwrap();
        for pivot in &keys[..3] {
            let unseen = *pivot | 1;
            assert_eq!(set.lookup_masked(unseen), None);
            assert_eq!(set.label(unseen) % 2, 0);
            assert_eq!(set.remaining(unseen), 128);
        }
        // No byte window can separate this set. Rejection preserves the old
        // sorter rather than adding a slower generic hash/gather path.
        let mut spread = [0u128; 32];
        for (i, key) in spread[..17].iter_mut().enumerate().skip(1) {
            *key = 1u128 << ((i - 1) * 8);
        }
        assert!(
            KeySet::<_, 32, true>::new(spread, 17, u128::MAX, 128).is_none()
        );
    }
    #[test]
    fn exact_coverage_requires_strict_majority_even_after_a_strong_sample() {
        let make = || {
            let mut keys = [0u16; 8];
            keys[..2].copy_from_slice(&[3, 5]);
            KeySet::<_, 8, true>::new(keys, 2, u16::MAX, 16).unwrap()
        };
        for n in [129, 257, 1025] {
            for covered in [n / 2, n / 2 + 1, n] {
                let input: Vec<_> = (0..n)
                    .map(|i| {
                        if i < covered {
                            if i % 2 == 0 {
                                3u16
                            } else {
                                5
                            }
                        } else {
                            1000 + i as u16
                        }
                    })
                    .collect();
                let approved =
                    make().approve::<_, u16>(&input, &mut Work::default());
                assert_eq!(approved.is_some(), covered > n / 2);
                if let Some((set, count)) = approved {
                    assert_eq!(count, covered);
                    let mut gaps = [0usize; 17];
                    for key in input {
                        if set.remaining(key) > 0 {
                            gaps[set.label(key) as usize] += 1;
                        }
                    }
                    assert!(gaps.iter().all(|&size| size <= n / 2));
                }
            }
        }
        let input: Vec<u16> = (0..1025).collect();
        assert!(sample::<_, u16, 32, true>(&input, 16, &mut Work::default())
            .is_none());
    }
}

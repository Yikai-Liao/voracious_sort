//! Stable completion of a bounded leaf with one converted key per record.
//! Sorting compact original indices avoids repeatedly copying full records.
use super::{Converted, NativeKey};
use std::mem::MaybeUninit;
use voracious_radix_sort::{RadixKey, Radixable};

pub(super) fn sort<T: Radixable<K>, K: RadixKey>(arr: &mut [T])
where
    Converted<T, K>: NativeKey,
{
    assert!(arr.len() <= 128);
    if arr.len() < 2 {
        return;
    }
    if arr.len() == 2 {
        if arr[0].into_key_type() > arr[1].into_key_type() {
            arr.swap(0, 1);
        }
        return;
    }
    let mut keys = [MaybeUninit::<Converted<T, K>>::uninit(); 128];
    let mut order = [MaybeUninit::<u8>::uninit(); 128];
    for (index, record) in arr.iter().enumerate() {
        keys[index].write(record.into_key_type());
        order[index].write(index as u8);
    }
    // SAFETY: every cell in these exact prefixes was initialized above. The
    // arrays are disjoint and remain alive through comparison and permutation.
    let keys = unsafe {
        std::slice::from_raw_parts(
            keys.as_ptr().cast::<Converted<T, K>>(),
            arr.len(),
        )
    };
    let order = unsafe {
        std::slice::from_raw_parts_mut(
            order.as_mut_ptr().cast::<u8>(),
            arr.len(),
        )
    };
    // Original position breaks ties, making this index order stable even though
    // the small index sorter itself has no stability guarantee.
    order.sort_unstable_by(|left, right| {
        keys[usize::from(*left)]
            .cmp(&keys[usize::from(*right)])
            .then_with(|| left.cmp(right))
    });
    // order[destination] identifies an original source. Each disjoint cycle
    // retains its first value until the last write and marks visited positions
    // as fixed points. No record is read after its original value is overwritten.
    for start in 0..arr.len() {
        if usize::from(order[start]) == start {
            continue;
        }
        let saved = arr[start];
        let mut destination = start;
        loop {
            let source = usize::from(order[destination]);
            order[destination] = destination as u8;
            if source == start {
                arr[destination] = saved;
                break;
            }
            arr[destination] = arr[source];
            destination = source;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::cmp::Ordering;

    #[derive(Clone, Copy, Debug)]
    struct Record {
        key: u128,
        id: usize,
        payload: [u64; 12],
    }
    impl PartialEq for Record {
        fn eq(&self, other: &Self) -> bool {
            self.key == other.key
        }
    }
    impl PartialOrd for Record {
        fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
            self.key.partial_cmp(&other.key)
        }
    }
    impl Radixable<u128> for Record {
        type Key = u128;
        fn key(&self) -> u128 {
            self.key
        }
    }

    #[test]
    fn every_leaf_length_and_duplicate_pattern_keeps_full_stable_records() {
        let mut state = 42u128;
        for length in 0..=128 {
            for case in 0..6 {
                let mut actual: Vec<_> = (0..length)
                    .map(|id| {
                        state = state
                            .wrapping_mul(6364136223846793005)
                            .wrapping_add(1);
                        let key = match case {
                            0 => state,
                            1 => state % 3,
                            2 => id as u128 / 3,
                            3 => (length - id) as u128 / 3,
                            4 => 1,
                            _ => state & (1u128 << 127 | 1u128 << 64 | 1),
                        };
                        Record { key, id, payload: [!(id as u64); 12] }
                    })
                    .collect();
                let mut expected = actual.clone();
                expected.sort_by_key(|record| record.key);
                sort::<_, u128>(&mut actual);
                assert!(
                    actual.iter().zip(&expected).all(|(a, b)| a.key == b.key
                        && a.id == b.id
                        && a.payload == b.payload),
                    "n={length} case={case}"
                );
            }
        }
    }
}

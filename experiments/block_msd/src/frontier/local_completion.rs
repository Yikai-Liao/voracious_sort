//! Stable MSD splits followed by bounded local LSD completion.
//!
//! The classifier stays fixed throughout this operation. Exact high-byte counts
//! supply child boundaries, so no record scan is needed to rediscover them.
//! Each block sorter is dropped before a child allocates its own workspace.
use super::labeler::Labeler;
use super::local_distribution::{block_bytes, dense_fits};
use super::{dense, work, NativeKey, Work};

/// `variation` covers every nonconstant label bit in this partition. It may
/// conservatively include constant bits; omitted bits must be constant.
pub(super) fn distribute<T: Copy, U: NativeKey, F: Labeler<T, U>>(
    arr: &mut [T],
    label: &F,
    variation: U,
    block_size: usize,
    stats: &mut Work,
) -> usize {
    let budget = 512usize
        .checked_mul(block_size)
        .and_then(|n| n.checked_mul(std::mem::size_of::<T>()))
        .expect("budget overflow");
    complete(arr, label, variation, block_size, budget, stats)
}

fn complete<T: Copy, U: NativeKey, F: Labeler<T, U>>(
    arr: &mut [T],
    label: &F,
    variation: U,
    block_size: usize,
    budget: usize,
    stats: &mut Work,
) -> usize {
    let levels = (U::BITS - variation.leading_zeros() as usize + 7) / 8;
    if arr.len() < 2 || levels == 0 {
        return 0;
    }
    let passes = (0..levels).filter(|&i| variation.byte(i) != 0).count();
    if dense_fits::<T>(arr.len(), levels, budget) {
        work! {
            stats.dense_nodes += 1;
            stats.passes += passes;
            stats.scatter_records += passes * arr.len();
        }
        dense(arr, label, levels, variation, stats);
        return passes;
    }

    let high_byte = levels - 1;
    let low_variation = variation & U::mask(high_byte * 8);
    let high_variation = variation ^ low_variation;
    let mut lengths = [0usize; 256];
    if low_variation != U::from_u128(0) {
        label.in_context(|| {
            for item in arr.iter() {
                lengths[label.classify(item).byte(high_byte)] += 1;
            }
        });
        work! { stats.label_records += arr.len(); }
        // A parent's conservative mask may include a constant byte here.
        // Skip it without moving records or consuming another workspace.
        if lengths.iter().any(|&length| length == arr.len()) {
            return complete(
                arr,
                label,
                low_variation,
                block_size,
                budget,
                stats,
            );
        }
    }
    work! {
        stats.block_nodes += 1;
        stats.passes += 1;
        stats.scatter_records += arr.len();
    }
    block_bytes::<T, U, F, true>(
        arr,
        label,
        levels,
        high_variation,
        block_size,
        true,
        stats,
    );
    if low_variation == U::from_u128(0) {
        return 1;
    }

    let mut start = 0;
    let mut child_path = 0;
    for length in lengths {
        let end = start + length;
        if length > 1 {
            child_path = child_path.max(complete(
                &mut arr[start..end],
                label,
                low_variation,
                block_size,
                budget,
                stats,
            ));
        }
        start = end;
    }
    debug_assert_eq!(start, arr.len());
    1 + child_path
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::cell::Cell;

    #[derive(Clone, Copy, Debug, PartialEq, Eq)]
    struct Record {
        key: u32,
        id: u32,
        payload: [u64; 2],
    }

    #[test]
    fn stable_completion_keeps_records_across_budget_and_digit_boundaries() {
        for block in [3, 17, 64, 512] {
            for length in [0, 1, 129, 4097] {
                for mask in [0, 0xff, 0x8100_8101, u32::MAX] {
                    let mut state = 42u32;
                    let input: Vec<_> = (0..length)
                        .map(|id| {
                            state ^= state << 13;
                            state ^= state >> 17;
                            state ^= state << 5;
                            Record {
                                key: (state & mask) | (!mask & 0x4400_4400),
                                id,
                                payload: [u64::from(id), !u64::from(id)],
                            }
                        })
                        .collect();
                    let mut expected = input.clone();
                    expected.sort_by_key(|record| record.key);
                    let mut actual = input;
                    distribute(
                        &mut actual,
                        &|record: &Record| record.key,
                        mask,
                        block,
                        &mut Work::default(),
                    );
                    assert_eq!(actual, expected, "B{block} n{length} {mask:x}");
                }
            }
        }
    }

    struct Guarded(Cell<bool>);
    impl Labeler<Record, u32> for Guarded {
        fn classify(&self, record: &Record) -> u32 {
            assert!(self.0.get(), "classifier escaped its execution context");
            record.key
        }
        fn in_context<R>(&self, kernel: impl FnOnce() -> R) -> R {
            let previous = self.0.replace(true);
            let result = kernel();
            self.0.set(previous);
            result
        }
    }

    #[test]
    fn skewed_children_skip_constant_bytes_and_retain_classifier_context() {
        let mut actual: Vec<_> = (0..8193u32)
            .map(|id| Record {
                // A mostly shared high byte forces a second MSD split. Every
                // child then has a conservative constant middle byte.
                key: if id % 10 == 0 {
                    (id % 255 + 1) << 24 | id << 8
                } else {
                    id % 128
                },
                id,
                payload: [u64::from(id), !u64::from(id)],
            })
            .collect();
        let mut expected = actual.clone();
        expected.sort_by_key(|record| record.key);
        let label = Guarded(Cell::new(false));
        let mut stats = Work::default();
        distribute(&mut actual, &label, u32::MAX, 3, &mut stats);
        assert_eq!(actual, expected);
        assert!(!label.0.get());
        #[cfg(feature = "frontier_work")]
        {
            assert!(stats.block_nodes >= 2);
            assert!(stats.dense_nodes > 0);
            assert!(stats.scatter_records < 4 * actual.len());
        }
    }
}

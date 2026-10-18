//! Finish a nearly complete key using counts produced by a stable block pass.
//! Every parent workspace is dropped before a child obtains its own scratch.
use super::labeler::Labeler;
use super::{block, dense, work, NativeKey, Work};

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
    let passes = (0..levels).filter(|&b| variation.byte(b) != 0).count();
    let dense_bytes =
        arr.len().checked_mul(std::mem::size_of::<T>()).and_then(|n| {
            n.checked_add((levels + 2) * 256 * std::mem::size_of::<usize>())
        });
    if dense_bytes.map_or(false, |n| n <= budget) {
        work! {
            stats.dense_nodes += 1;
            stats.passes += passes;
            stats.scatter_records += passes * arr.len();
        }
        dense(arr, label, levels, variation, stats);
        return passes;
    }
    let byte = levels - 1;
    let lengths = {
        let mut sorter = block::Sorter::new(arr, 256, block_size);
        let bit = (variation.byte(byte) as u8)
            .is_power_of_two()
            .then_some(variation.byte(byte) as u8);
        let lengths = sorter.step_with_lengths(label, byte, bit);
        sorter.compact();
        work! {
            stats.block_nodes += 1;
            stats.passes += 1;
            stats.scatter_records += lengths.iter().sum::<usize>();
            stats.compact_records += sorter.compact_records;
            stats.tail_records += sorter.tail_records;
        }
        lengths
    };
    let low_variation = variation & U::mask(byte * 8);
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
        id: usize,
        payload: [u64; 2],
    }
    fn input(length: usize, mask: u32) -> Vec<Record> {
        let mut state = 42u32;
        (0..length)
            .map(|id| {
                state ^= state << 13;
                state ^= state >> 17;
                state ^= state << 5;
                Record {
                    key: (state & mask) | (0x4400_4400 & !mask),
                    id,
                    payload: [id as u64, !(id as u64)],
                }
            })
            .collect()
    }
    #[test]
    fn block_lengths_match_empty_buckets_tails_and_stable_digit_order() {
        for block in [3, 17, 64, 512] {
            for length in [0, 1, block - 1, block, block + 1, 4097] {
                for byte in 0..4 {
                    let mut actual = input(length, 0x00ff_00ff);
                    let mut expected = actual.clone();
                    expected.sort_by_key(|record| record.key.byte(byte));
                    let mut histogram = [0; 256];
                    for record in &actual {
                        histogram[record.key.byte(byte)] += 1;
                    }
                    let evaluations = Cell::new(0);
                    let label = |record: &Record| {
                        evaluations.set(evaluations.get() + 1);
                        record.key
                    };
                    {
                        let mut sorter =
                            block::Sorter::new(&mut actual, 256, block);
                        assert_eq!(
                            sorter.step_with_lengths(&label, byte, None),
                            histogram
                        );
                        // Returning boundaries must not classify a second time.
                        assert_eq!(evaluations.get(), length);
                        sorter.compact();
                    }
                    assert_eq!(
                        actual, expected,
                        "B{block} n{length} byte{byte}"
                    );
                }
            }
        }
    }
    #[test]
    fn counted_completion_preserves_full_records_across_workspace_boundaries() {
        for block in [3, 17, 64, 512] {
            for length in [0, 1, 129, 4097] {
                for mask in [0, 0xff, 0x8100_8101, u32::MAX] {
                    let mut actual = input(length, mask);
                    let mut expected = actual.clone();
                    expected.sort_by_key(|record| record.key);
                    distribute(
                        &mut actual,
                        &|record: &Record| record.key,
                        mask,
                        block,
                        &mut Work::default(),
                    );
                    assert_eq!(
                        actual, expected,
                        "B{block} n{length} mask{mask:x}"
                    );
                }
            }
        }
    }
}

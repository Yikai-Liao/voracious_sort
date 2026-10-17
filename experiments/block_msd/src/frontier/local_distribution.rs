//! Complete the same fixed label after first grouping its highest active byte.
//!
//! This changes physical execution within one classifier partition. Every
//! originally active byte is still scattered once per record; local runs use
//! the existing dense budget and oversized runs retain the block backend.

use super::{block, dense, work, NativeKey, Work};

pub(super) fn distribute_local<T: Copy, U: NativeKey, F: Fn(&T) -> U>(
    arr: &mut [T],
    label: &F,
    block_size: usize,
    stats: &mut Work,
) -> usize {
    if arr.len() < 2 {
        return 0;
    }
    let first = label(&arr[0]);
    let mut variation = U::from_u128(0);
    for item in arr.iter() {
        variation |= label(item) ^ first;
    }
    work! { stats.label_records += arr.len(); }
    let levels = (U::BITS - variation.leading_zeros() as usize + 7) / 8;
    if levels == 0 {
        return 0;
    }
    let passes = (0..levels).filter(|&i| variation.byte(i) != 0).count();
    let budget = 512usize
        .checked_mul(block_size)
        .and_then(|n| n.checked_mul(std::mem::size_of::<T>()))
        .expect("budget overflow");
    if passes == 1 || dense_fits::<T>(arr.len(), levels, budget) {
        return finish_label(
            arr, label, levels, variation, block_size, budget, stats,
        );
    }

    let high_byte = levels - 1;
    work! {
        stats.block_nodes += 1;
        stats.passes += 1;
        stats.scatter_records += arr.len();
    }
    {
        let mut sorter = block::Sorter::new(arr, 256, block_size);
        sorter.step(label, high_byte);
        sorter.compact();
        work! {
            stats.compact_records += sorter.compact_records;
            stats.tail_records += sorter.tail_records;
        }
    }
    // The root workspace has been released. Only one run's dense or block
    // workspace can be live while completing the remaining label bytes.
    let low_variation = variation & U::mask(high_byte * 8);
    let mut start = 0;
    while start < arr.len() {
        let high = label(&arr[start]).byte(high_byte);
        work! { stats.label_records += 1; }
        let mut end = start + 1;
        while end < arr.len() {
            let next_high = label(&arr[end]).byte(high_byte);
            work! { stats.label_records += 1; }
            if next_high != high {
                break;
            }
            end += 1;
        }
        finish_label(
            &mut arr[start..end],
            label,
            high_byte,
            low_variation,
            block_size,
            budget,
            stats,
        );
        start = end;
    }
    // Even singleton runs execute all originally active lower bytes. Thus each
    // record consumes the same pass count as the existing distribution path,
    // and callers can keep their current per-path pass accounting.
    passes
}

fn dense_fits<T>(length: usize, levels: usize, budget: usize) -> bool {
    length
        .checked_mul(std::mem::size_of::<T>())
        .and_then(|bytes| {
            bytes.checked_add((levels + 2) * 256 * std::mem::size_of::<usize>())
        })
        .map_or(false, |bytes| bytes <= budget)
}

/// Complete the indicated low bytes without changing the fixed label or
/// introducing another physical split. The supplied variation is from the
/// whole classifier partition, so this remains a same-scatter-work experiment.
fn finish_label<T: Copy, U: NativeKey, F: Fn(&T) -> U>(
    arr: &mut [T],
    label: &F,
    levels: usize,
    variation: U,
    block_size: usize,
    budget: usize,
    stats: &mut Work,
) -> usize {
    let passes = (0..levels).filter(|&i| variation.byte(i) != 0).count();
    work! {
        stats.passes += passes;
        stats.scatter_records += passes * arr.len();
    }
    if dense_fits::<T>(arr.len(), levels, budget) {
        work! { stats.dense_nodes += 1; }
        dense(arr, label, levels, variation, stats);
    } else {
        work! { stats.block_nodes += 1; }
        let mut sorter = block::Sorter::new(arr, 256, block_size);
        for byte in 0..levels {
            if variation.byte(byte) != 0 {
                sorter.step(label, byte);
            }
        }
        sorter.compact();
        work! {
            stats.compact_records += sorter.compact_records;
            stats.tail_records += sorter.tail_records;
        }
    }
    passes
}

#[cfg(all(test, feature = "frontier_work"))]
mod tests {
    use super::super::{distribute, Work};
    use super::{dense_fits, distribute_local};

    #[derive(Clone, Copy, Debug, PartialEq, Eq)]
    struct Record {
        key: u32,
        id: u32,
        payload: [u8; 120],
    }

    #[test]
    fn local_label_completion_preserves_stability_and_scatter_work() {
        const N: usize = 16_385;
        const HEAVY: usize = 12_288;
        const BLOCK: usize = 17;
        let mut input: Vec<Record> = (0..N)
            .map(|id| {
                let (high, low) = if id < HEAVY {
                    (0x20, (id % 17) as u32)
                } else if id == N - 1 {
                    (0xfe, 0x91)
                } else {
                    (0x40 + (id % 8) as u32, (id % 31) as u32)
                };
                let mut payload = [0; 120];
                for (offset, byte) in payload.iter_mut().enumerate() {
                    *byte =
                        (id.wrapping_mul(31) ^ offset.wrapping_mul(17)) as u8;
                }
                Record {
                    // Bytes 0 and 2 vary; byte 1 is deliberately constant.
                    key: (high << 16) | 0x5a00 | low,
                    id: id as u32,
                    payload,
                }
            })
            .collect();
        let mut state = 42u64;
        for end in (1..input.len()).rev() {
            state = state.wrapping_mul(6364136223846793005).wrapping_add(1);
            input.swap(end, (state % (end as u64 + 1)) as usize);
        }
        let mut expected = input.clone();
        expected.sort_by_key(|record| record.key);
        assert!(expected.windows(2).any(|pair| pair[0].key == pair[1].key));
        assert_eq!(input.iter().filter(|r| r.key >> 16 == 0xfe).count(), 1);

        let budget = 512 * BLOCK * std::mem::size_of::<Record>();
        assert!(!dense_fits::<Record>(N, 3, budget));
        assert!(!dense_fits::<Record>(HEAVY, 2, budget));
        assert!(dense_fits::<Record>(512, 2, budget));

        let label = |record: &Record| record.key;
        let mut reference = input.clone();
        let mut local = input;
        let mut reference_work = Work::default();
        let mut local_work = Work::default();
        let reference_passes =
            distribute(&mut reference, &label, BLOCK, &mut reference_work);
        let local_passes =
            distribute_local(&mut local, &label, BLOCK, &mut local_work);

        // Full-record equality checks stable duplicate identities and every
        // payload byte, including the single-record high-byte run.
        for (position, ((reference, local), expected)) in
            reference.iter().zip(&local).zip(&expected).enumerate()
        {
            assert_eq!(reference, expected, "reference record {position}");
            assert_eq!(local, expected, "local record {position}");
        }
        assert_eq!(reference_passes, 2);
        assert_eq!(local_passes, reference_passes);
        assert_eq!(reference_work.scatter_records, 2 * N);
        assert_eq!(local_work.scatter_records, reference_work.scatter_records);
        assert_eq!(reference_work.block_nodes, 1);
        assert_eq!(reference_work.dense_nodes, 0);
        // One top-byte block distribution and one oversized low-byte run.
        // Eight small runs plus the singleton use separate dense completions.
        assert_eq!(local_work.block_nodes, 2);
        assert_eq!(local_work.dense_nodes, 9);
        assert_eq!(local_work.passes, 11);
    }
}

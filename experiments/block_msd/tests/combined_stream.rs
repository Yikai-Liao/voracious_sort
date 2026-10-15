use block_msd_research::{
    carried_boundaries, combined_stream as leaf_batch, count_first_full_scan,
    leaf_batch as leaf_only, Stats,
};
use std::cmp::Ordering;
use voracious_radix_sort::{RadixKey, Radixable};

#[derive(Clone, Copy, Debug, PartialEq)]
struct Record {
    key: u128,
    ordinal: usize,
    payload: [u64; 3],
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
fn random(state: &mut u64) -> u64 {
    *state ^= *state << 13;
    *state ^= *state >> 7;
    *state ^= *state << 17;
    *state
}
fn check<T: Radixable<K> + std::fmt::Debug + PartialEq, K: RadixKey>(
    source: &[T],
    radix: usize,
    block: usize,
    leaf_limit: usize,
) {
    let mut expected = source.to_vec();
    expected.sort_by_key(|value| value.into_key_type());
    let mut baseline = source.to_vec();
    let old = count_first_full_scan::block_msd_stable_radixsort_body(
        &mut baseline,
        radix,
        block,
        leaf_limit,
    );
    let mut actual = source.to_vec();
    let (new, batch) = leaf_batch::sort_with_batch_stats(
        &mut actual,
        radix,
        block,
        leaf_limit,
    );
    let mut carried = source.to_vec();
    let carried_stats = carried_boundaries::block_msd_stable_radixsort_body(
        &mut carried,
        radix,
        block,
        leaf_limit,
    );
    let mut leaves = source.to_vec();
    let (leaf_stats, leaf_batch_stats) =
        leaf_only::sort_with_batch_stats(&mut leaves, radix, block, leaf_limit);
    assert_eq!(carried, expected);
    assert_eq!(leaves, expected);
    same_work(&old, &carried_stats);
    same_work(&leaf_stats, &new);
    assert_eq!(leaf_stats.peak_live_blocks, new.peak_live_blocks);
    macro_rules! batch_work {
        ($stats:expr) => {
            [
                $stats.leaf_sort_calls,
                $stats.gather_calls,
                $stats.writer_calls,
                $stats.leaf_records,
                $stats.multi_leaf_batches,
                $stats.batched_leaves,
                $stats.max_batch_records,
            ]
        };
    }
    assert_eq!(batch_work!(batch), batch_work!(leaf_batch_stats));
    assert_eq!(baseline, expected);
    assert_eq!(
        actual, expected,
        "radix={} block={} limit={}",
        radix, block, leaf_limit
    );
    assert_eq!(old.nodes, new.nodes);
    assert_eq!(old.dense_scattered_elements, new.dense_scattered_elements);
    assert_eq!(old.scratch_elements, new.scratch_elements);
    assert!(batch.max_batch_records <= 128);
    if leaf_limit == 0 {
        assert_eq!(batch, leaf_batch::BatchStats::default());
    }
    #[cfg(feature = "cf_phases")]
    {
        assert_eq!(old.phases.union_records, new.phases.union_records);
        assert_eq!(old.phases.histogram_records, new.phases.histogram_records);
        assert_eq!(old.phases.scatter_records, new.phases.scatter_records);
        assert_eq!(old.phases.gather_records, new.phases.gather_records);
        assert_eq!(old.phases.writer_records, new.phases.writer_records);
        assert_eq!(old.phases.leaf_lengths, new.phases.leaf_lengths);
    }
    // Exercise the uninstrumented monomorphization as used for timing.
    let mut uninstrumented = source.to_vec();
    leaf_batch::block_msd_stable_radixsort_body(
        &mut uninstrumented,
        radix,
        block,
        leaf_limit,
    );
    assert_eq!(uninstrumented, expected);
}

fn same_work(a: &Stats, b: &Stats) {
    assert_eq!(a.nodes, b.nodes);
    assert_eq!(a.dense_nodes, b.dense_nodes);
    assert_eq!(a.dense_scattered_elements, b.dense_scattered_elements);
    assert_eq!(a.scratch_elements, b.scratch_elements);
    #[cfg(feature = "cf_phases")]
    {
        assert_eq!(a.phases.union_records, b.phases.union_records);
        assert_eq!(a.phases.histogram_records, b.phases.histogram_records);
        assert_eq!(a.phases.scatter_records, b.phases.scatter_records);
        assert_eq!(a.phases.gather_records, b.phases.gather_records);
        assert_eq!(a.phases.writer_records, b.phases.writer_records);
        assert_eq!(
            a.phases.full_permutation_records,
            b.phases.full_permutation_records
        );
        assert_eq!(a.phases.leaf_lengths, b.phases.leaf_lengths);
    }
}

#[test]
fn stable_identity_across_radices_and_partial_blocks() {
    for radix in [1, 3, 5, 8] {
        for block in [1, 2, 7, 31, 64, 129] {
            for n in [0, 1, 2, 127, 128, 129, 257, 1025, 4097] {
                let mut seed = 928371 + n as u64;
                let values: Vec<_> = (0..n)
                    .map(|ordinal| {
                        let key = random(&mut seed) as u128 % 101;
                        Record { key, ordinal, payload: [ordinal as u64; 3] }
                    })
                    .collect();
                check(&values, radix, block, 128);
                if n == 257 {
                    check(&values, radix, block, 0);
                    check(&values, radix, block, 17);
                }
            }
        }
    }
}

fn prescribed_leaves(lengths: &[usize]) -> Vec<Record> {
    let mut values = Vec::new();
    for (bucket, &length) in lengths.iter().enumerate() {
        for i in 0..length {
            let ordinal = values.len();
            // The final >128 bucket is constant and terminates without sorting.
            let low = if length > 128 { 0 } else { (length - i) % 7 };
            values.push(Record {
                key: ((bucket as u128 * 2) << 120) | low as u128,
                ordinal,
                payload: [ordinal as u64; 3],
            });
        }
    }
    let mut seed = 372191;
    for i in (1..values.len()).rev() {
        values.swap(i, random(&mut seed) as usize % (i + 1));
    }
    // Identity tracks shuffled input order, not construction order.
    for (ordinal, value) in values.iter_mut().enumerate() {
        value.ordinal = ordinal;
    }
    values
}

#[test]
#[cfg(not(feature = "cf_span_leaf"))]
fn four_leaves_keep_four_sort_calls_but_one_gather_and_write() {
    for block in [1, 7, 31, 64, 129] {
        let mut values = prescribed_leaves(&[12, 18, 9, 21, 200]);
        let mut expected = values.clone();
        expected.sort_by_key(|value| value.key);
        let (_, stats) =
            leaf_batch::sort_with_batch_stats(&mut values, 8, block, 128);
        assert_eq!(values, expected);
        assert_eq!(stats.leaf_sort_calls, 4);
        assert_eq!(stats.gather_calls, 1);
        assert_eq!(stats.writer_calls, 1);
        assert_eq!(stats.leaf_records, 60);
        assert_eq!(stats.multi_leaf_batches, 1);
        assert_eq!(stats.batched_leaves, 4);
        assert_eq!(stats.max_batch_records, 60);
    }
}

#[test]
#[cfg(not(feature = "cf_span_leaf"))]
fn exact_capacity_and_overflow_start_a_new_batch() {
    for (lengths, sorts, gathers, records) in [
        (vec![12, 18, 9, 21, 68, 200], 5, 1, 128),
        (vec![70, 58, 1, 200], 3, 2, 129),
        (vec![127, 2, 200], 2, 2, 129),
    ] {
        let mut values = prescribed_leaves(&lengths);
        let (_, stats) =
            leaf_batch::sort_with_batch_stats(&mut values, 8, 7, 128);
        assert_eq!(stats.leaf_sort_calls, sorts);
        assert_eq!(stats.gather_calls, gathers);
        assert_eq!(stats.writer_calls, gathers);
        assert_eq!(stats.leaf_records, records);
        assert!(stats.max_batch_records <= 128);
    }
}

#[repr(u8)]
#[derive(Clone, Copy, Debug, PartialEq)]
enum State {
    A = 17,
    B = 93,
}
#[derive(Clone, Copy, Debug, PartialEq)]
struct Restricted {
    key: std::num::NonZeroU32,
    state: State,
    payload: &'static str,
    ordinal: usize,
}
impl PartialOrd for Restricted {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        self.key.partial_cmp(&other.key)
    }
}
impl Radixable<u32> for Restricted {
    type Key = u32;
    fn key(&self) -> u32 {
        self.key.get()
    }
}
#[test]
fn restricted_values_remain_initialized_and_stable() {
    let values: Vec<_> = (0..4097)
        .map(|ordinal| Restricted {
            key: std::num::NonZeroU32::new(((ordinal * 6181) % 257 + 1) as u32)
                .unwrap(),
            state: if ordinal % 2 == 0 { State::A } else { State::B },
            payload: if ordinal % 3 == 0 { "a" } else { "payload-b" },
            ordinal,
        })
        .collect();
    for radix in [3, 8] {
        for block in [1, 7, 64, 512] {
            check(&values, radix, block, 128);
        }
    }
    let descending: Vec<_> = values.into_iter().rev().collect();
    check(&descending, 8, 7, 128);
}

#[derive(Clone, Copy, Debug, PartialEq)]
struct TaggedFloat {
    bits: u64,
    ordinal: usize,
}
impl PartialOrd for TaggedFloat {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        f64::from_bits(self.bits).partial_cmp(&f64::from_bits(other.bits))
    }
}
impl Radixable<f64> for TaggedFloat {
    type Key = f64;
    fn key(&self) -> f64 {
        f64::from_bits(self.bits)
    }
}
#[test]
fn nan_payload_and_signed_zero_identity_follow_converted_keys() {
    let bits = [
        0,
        1,
        0x8000_0000_0000_0000,
        0x8000_0000_0000_0001,
        0x7ff0_0000_0000_0000,
        0xfff0_0000_0000_0000,
        0x7ff0_0000_0000_0001,
        0x7ff8_0000_0000_0001,
        0xfff0_0000_0000_0001,
        0xfff8_0000_0000_0001,
        0x3ff0_0000_0000_0000,
        0xbff0_0000_0000_0000,
    ];
    let mut seed = 978317;
    let values: Vec<_> = (0..3001)
        .map(|ordinal| TaggedFloat {
            bits: bits[random(&mut seed) as usize % bits.len()],
            ordinal,
        })
        .collect();
    for radix in [3, 7, 8] {
        for block in [1, 7, 64] {
            check(&values, radix, block, 128);
        }
    }
}

#[test]
fn mixed_recursive_nodes_and_small_leaf_limits() {
    let mut seed = 638217;
    let values: Vec<_> = (0..8193)
        .map(|ordinal| {
            let high = random(&mut seed);
            let low = random(&mut seed);
            let key = if ordinal % 5 == 0 {
                (high % 11) as u128
            } else {
                ((high as u128) << 64) | low as u128
            };
            Record { key, ordinal, payload: [ordinal as u64; 3] }
        })
        .collect();
    for radix in [3, 8] {
        for block in [3, 64, 129] {
            for limit in [0, 1, 17, 128] {
                check(&values, radix, block, limit);
            }
        }
    }
}

#[test]
fn exhaustive_binary_identity_with_small_leaf_limits() {
    for n in 2..=9 {
        for word in 0usize..(1 << n) {
            let values: Vec<_> = (0..n)
                .map(|ordinal| Record {
                    key: ((word >> ordinal) & 1) as u128,
                    ordinal,
                    payload: [ordinal as u64; 3],
                })
                .collect();
            for block in [1, 3, 7] {
                for limit in [0, 1, 2] {
                    check(&values, 1, block, limit);
                }
            }
        }
    }
}

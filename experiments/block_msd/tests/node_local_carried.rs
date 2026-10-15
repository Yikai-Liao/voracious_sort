use block_msd_research::node_local::{self, LocalStats, Placement};
use std::cmp::Ordering;
use voracious_radix_sort::Radixable;
#[derive(Clone, Copy, Debug)]
struct Record {
    key: u128,
    ordinal: usize,
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
fn records(n: usize, pattern: usize) -> Vec<Record> {
    (0..n)
        .map(|i| Record {
            ordinal: i,
            key: match pattern {
                0 => {
                    ((i.wrapping_mul(61789) % 4093) as u128) << 97
                        | (i % 17) as u128
                },
                1 => (i % 3) as u128,
                2 => (0xabcdefu128 << 96) | ((i * 61789) % 4093) as u128,
                3 => ((n - i) / 3) as u128,
                4 => {
                    if i % 97 == 0 {
                        i as u128
                    } else {
                        1u128 << 127
                    }
                },
                _ => ((i * 61789) % 4093) as u128,
            },
        })
        .collect()
}
fn identity(actual: &[Record], expected: &[Record]) {
    assert!(actual
        .iter()
        .zip(expected)
        .all(|(a, b)| a.key == b.key && a.ordinal == b.ordinal));
}

fn stat_values(s: &LocalStats) -> [usize; 12] {
    [
        s.block_nodes,
        s.cache_entries,
        s.cache_radix_nodes,
        s.leaf_sorts,
        s.variation_records,
        s.block_scatter_records,
        s.cache_scatter_records,
        s.permutation_writes,
        s.prefix_writeback_records,
        s.peak_scratch_records,
        s.peak_directory_entries,
        s.max_cache_records,
    ]
}

#[test]
fn carried_node_local_keeps_identity_and_every_record_work_counter() {
    for n in [0, 1, 128, 129, 257, 1025, 4099] {
        for pattern in 0..6 {
            let source = records(n, pattern);
            let mut expected = source.clone();
            expected.sort_by_key(|r| r.key);
            for radix in [1, 3, 8] {
                for block in [7, 64, 129] {
                    for budget in [0, node_local::CACHE_BUDGET] {
                        let mut old = source.clone();
                        let mut carried = source.clone();
                        let a = node_local::sort_with_placement(
                            &mut old,
                            radix,
                            block,
                            budget,
                            Placement::FreeList,
                        );
                        let b = node_local::sort_with_placement(
                            &mut carried,
                            radix,
                            block,
                            budget,
                            Placement::CarriedFreeList,
                        );
                        identity(&old, &expected);
                        identity(&carried, &expected);
                        assert_eq!(stat_values(&a), stat_values(&b));
                        assert_eq!(b.prefix_writeback_records, 0);
                    }
                }
            }
        }
    }
}

#[test]
fn default_cache_budget_uses_carried_parent_and_contiguous_children() {
    let n = 65537;
    let source: Vec<_> = (0..n)
        .map(|i| Record {
            key: (i as u128).wrapping_mul(0x9e3779b97f4a7c15d1b54a32d192ed03),
            ordinal: i,
        })
        .collect();
    let mut expected = source.clone();
    expected.sort_by_key(|r| r.key);
    let mut old = source.clone();
    let mut carried = source;
    let a = node_local::sort_with_placement(
        &mut old,
        8,
        64,
        node_local::CACHE_BUDGET,
        Placement::FreeList,
    );
    let b = node_local::sort_with_placement(
        &mut carried,
        8,
        64,
        node_local::CACHE_BUDGET,
        Placement::CarriedFreeList,
    );
    identity(&old, &expected);
    identity(&carried, &expected);
    assert_eq!(stat_values(&a), stat_values(&b));
    assert_eq!(b.block_nodes, 1);
    assert_eq!(b.block_scatter_records, n);
    assert!(b.cache_entries > 0 && b.cache_scatter_records > 0);
}

thread_local! {
    static CALLS: std::cell::Cell<usize> = const { std::cell::Cell::new(0) };
    static MODE: std::cell::Cell<usize> = const { std::cell::Cell::new(0) };
}
#[derive(Clone, Copy, Debug, PartialEq, PartialOrd)]
struct Changing(u32);
impl Radixable<u32> for Changing {
    type Key = u32;
    fn key(&self) -> u32 {
        self.0
    }
    fn extract(&self, _mask: u32, _shift: usize) -> usize {
        MODE.with(|mode| {
            CALLS.with(|calls| {
                let n = calls.get();
                calls.set(n + 1);
                if mode.get() == 0 {
                    usize::from(n >= 1000)
                } else {
                    usize::from(n >= 3 && n < 1000)
                }
            })
        })
    }
}
#[test]
fn changing_extractors_panic_before_uninitialized_stream_reads() {
    let source: Vec<_> = (0..1000).map(|i| Changing((i * 73) % 1000)).collect();
    for mode in 0..2 {
        CALLS.with(|calls| calls.set(0));
        MODE.with(|state| state.set(mode));
        let mut actual = source.clone();
        assert!(std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
            node_local::sort_with_placement(
                &mut actual,
                8,
                64,
                0,
                Placement::CarriedFreeList,
            );
        }))
        .is_err());
        assert_eq!(actual, source);
    }
}

#[derive(Clone, Copy, Debug, PartialEq)]
#[repr(u8)]
enum Tag {
    A = 1,
    B = 7,
}
#[derive(Clone, Copy, Debug)]
struct Restricted<'a> {
    key: std::num::NonZeroU32,
    ordinal: usize,
    tag: Tag,
    reference: &'a u64,
}
impl PartialEq for Restricted<'_> {
    fn eq(&self, b: &Self) -> bool {
        self.key == b.key
    }
}
impl PartialOrd for Restricted<'_> {
    fn partial_cmp(&self, b: &Self) -> Option<Ordering> {
        self.key.partial_cmp(&b.key)
    }
}
impl Radixable<u32> for Restricted<'_> {
    type Key = u32;
    fn key(&self) -> u32 {
        self.key.get()
    }
}
#[test]
fn carried_blocks_preserve_restricted_values_and_references() {
    let payload: Vec<_> = (0..2051).map(|i| i as u64 * 97).collect();
    let source: Vec<_> = payload
        .iter()
        .enumerate()
        .map(|(ordinal, reference)| Restricted {
            key: std::num::NonZeroU32::new((ordinal * 691 % 4093 + 1) as u32)
                .unwrap(),
            ordinal,
            tag: if ordinal % 2 == 0 { Tag::A } else { Tag::B },
            reference,
        })
        .collect();
    let mut expected = source.clone();
    expected.sort_by_key(|r| r.key);
    for radix in [1, 3, 8] {
        for block in [1, 7, 64, 129] {
            let mut actual = source.clone();
            node_local::sort_with_placement(
                &mut actual,
                radix,
                block,
                0,
                Placement::CarriedFreeList,
            );
            assert!(actual.iter().zip(&expected).all(|(a, b)| a.key == b.key
                && a.ordinal == b.ordinal
                && a.tag == b.tag
                && std::ptr::eq(a.reference, b.reference)));
        }
    }
}

use block_msd_research::node_local;
use std::{
    cmp::Ordering,
    sync::atomic::{AtomicUsize, Ordering as AtomicOrdering},
};
use voracious_radix_sort::Radixable;
#[derive(Clone, Copy, Debug)]
struct Record {
    key: u128,
    ordinal: usize,
}
impl PartialEq for Record {
    fn eq(&self, b: &Self) -> bool {
        self.key == b.key
    }
}
impl PartialOrd for Record {
    fn partial_cmp(&self, b: &Self) -> Option<Ordering> {
        self.key.partial_cmp(&b.key)
    }
}
impl Radixable<u128> for Record {
    type Key = u128;
    fn key(&self) -> u128 {
        self.key
    }
}
fn identical(a: &[Record], b: &[Record]) {
    assert!(a
        .iter()
        .zip(b)
        .all(|(a, b)| a.key == b.key && a.ordinal == b.ordinal));
}
#[test]
fn forced_block_levels_partial_boundaries_and_cached_children() {
    for n in [129, 257, 1025, 4099] {
        for pattern in 0..4 {
            let source: Vec<_> = (0..n)
                .map(|i| Record {
                    key: match pattern {
                        0 => ((i * 61789) % 4093) as u128,
                        1 => {
                            if i % 17 == 0 {
                                1u128 << ((i / 17) % 128)
                            } else {
                                0
                            }
                        },
                        2 => (0xabcdu128 << 112) | ((i * 691) % 4093) as u128,
                        _ => ((n - i) / 3) as u128,
                    },
                    ordinal: i,
                })
                .collect();
            let mut expected = source.clone();
            expected.sort_by_key(|v| v.key);
            for radix in [1, 3, 8] {
                for block in [1, 7, 64, 129] {
                    for budget in [0, 16 * 1024, node_local::CACHE_BUDGET] {
                        let mut actual = source.clone();
                        node_local::sort_with_budget(
                            &mut actual,
                            radix,
                            block,
                            budget,
                        );
                        identical(&actual, &expected);
                        let mut prefix = source.clone();
                        node_local::sort_with_placement(
                            &mut prefix,
                            radix,
                            block,
                            budget,
                            node_local::Placement::PrefixWriteback,
                        );
                        identical(&prefix, &expected);
                    }
                }
            }
        }
    }
}
#[test]
fn large_partition_ends_before_contiguous_cache_sorting() {
    let n = 65536;
    let source: Vec<_> = (0..n)
        .map(|i| Record {
            key: (i as u128).wrapping_mul(0x9e3779b97f4a7c15d1b54a32d192ed03),
            ordinal: i,
        })
        .collect();
    let mut expected = source.clone();
    expected.sort_by_key(|v| v.key);
    let mut actual = source;
    let stats = node_local::block_msd_stable_radixsort(&mut actual, 8, 64);
    identical(&actual, &expected);
    assert_eq!(stats.block_nodes, 1);
    assert_eq!(stats.block_scatter_records, n);
    assert!(stats.cache_entries > 0 && stats.cache_scatter_records > 0);
    assert!(stats.max_cache_records < n);
    assert_eq!(stats.peak_scratch_records, (512 + 8) * 64);
}
static CALLS: AtomicUsize = AtomicUsize::new(0);
#[derive(Clone, Copy, PartialEq, PartialOrd)]
struct Changing(u32);
impl Radixable<u32> for Changing {
    type Key = u32;
    fn key(&self) -> u32 {
        self.0
    }
    fn extract(&self, _mask: u32, _shift: usize) -> usize {
        if CALLS.fetch_add(1, AtomicOrdering::Relaxed) < 257 {
            self.0 as usize & 1
        } else {
            1
        }
    }
}
#[test]
fn changing_extractor_is_checked_before_reading_incomplete_output() {
    for budget in [0, node_local::CACHE_BUDGET] {
        for placement in [
            node_local::Placement::FreeList,
            node_local::Placement::PrefixWriteback,
        ] {
            CALLS.store(0, AtomicOrdering::Relaxed);
            let mut source: Vec<_> =
                (0..257).map(|i| Changing((i * 61789) % 4093)).collect();
            assert!(std::panic::catch_unwind(std::panic::AssertUnwindSafe(
                || node_local::sort_with_placement(
                    &mut source,
                    8,
                    7,
                    budget,
                    placement
                )
            ))
            .is_err());
        }
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
fn prefix_blocks_preserve_restricted_values_and_references() {
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
                node_local::Placement::PrefixWriteback,
            );
            assert!(actual.iter().zip(&expected).all(|(a, b)| a.key == b.key
                && a.ordinal == b.ordinal
                && a.tag == b.tag
                && std::ptr::eq(a.reference, b.reference)));
        }
    }
}

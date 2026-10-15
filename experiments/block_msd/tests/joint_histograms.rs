use block_msd_research::{count_first_full_scan, joint_histograms};
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

#[test]
fn joint_tables_keep_complete_identity_with_zero_small_and_full_budgets() {
    for n in [0, 1, 128, 129, 257, 2051] {
        for pattern in 0..6 {
            let source = records(n, pattern);
            let mut expected = source.clone();
            expected.sort_by_key(|r| r.key);
            for radix in [1, 3, 5, 8] {
                for block in [1, 7, 64, 129] {
                    let mut old = source.clone();
                    let a = count_first_full_scan::block_msd_stable_radixsort(
                        &mut old, radix, block,
                    );
                    identity(&old, &expected);
                    for budget in [0, 4096, 512 * 1024] {
                        let mut new = source.clone();
                        let (b, j) = joint_histograms::sort_with_budget(
                            &mut new, radix, block, budget,
                        );
                        identity(&new, &expected);
                        assert!(j.peak_bytes <= budget);
                        assert!(j.hist_reused_records <= j.joint_updates);
                        assert_eq!(
                            j.hist_reused_records + j.hist_scanned_records,
                            b.dense_scattered_elements
                        );
                        if budget == 0 {
                            assert_eq!(
                                (
                                    j.peak_bytes,
                                    j.joint_updates,
                                    j.hist_reused_records
                                ),
                                (0, 0, 0)
                            );
                        }
                        assert_eq!(
                            (
                                a.nodes,
                                a.dense_scattered_elements,
                                a.scratch_elements,
                                a.peak_live_blocks
                            ),
                            (
                                b.nodes,
                                b.dense_scattered_elements,
                                b.scratch_elements,
                                b.peak_live_blocks
                            )
                        );
                        #[cfg(feature = "cf_phases")]
                        {
                            assert_eq!(
                                a.phases.union_records,
                                b.phases.union_records
                            );
                            assert_eq!(
                                b.phases.histogram_records,
                                j.hist_scanned_records
                            );
                            assert_eq!(
                                a.phases.scatter_records,
                                b.phases.scatter_records
                            );
                            assert_eq!(
                                a.phases.full_permutation_records,
                                b.phases.full_permutation_records
                            );
                            assert_eq!(
                                a.phases.leaf_lengths,
                                b.phases.leaf_lengths
                            );
                        }
                    }
                }
            }
        }
    }
}

#[test]
fn parents_and_unvisited_sibling_rows_remain_charged_during_descendants() {
    let n = 8192;
    let source: Vec<_> = (0..n)
        .map(|i| Record {
            ordinal: i,
            key: (((i % 2) << 24)
                | (((i / 2) % 2) << 16)
                | (((i / 4) % 2) << 8)
                | ((i / 8) % 31)) as u128,
        })
        .collect();
    let mut expected = source.clone();
    expected.sort_by_key(|r| r.key);
    let table_bytes = 256 * 256 * std::mem::size_of::<usize>();
    for table_limit in 1..=3 {
        let mut actual = source.clone();
        let (_, stats) = joint_histograms::sort_with_budget(
            &mut actual,
            8,
            64,
            table_limit * table_bytes,
        );
        identity(&actual, &expected);
        assert_eq!(stats.peak_tables, table_limit);
        assert_eq!(stats.peak_bytes, table_limit * table_bytes);
        if table_limit < 3 {
            assert!(stats.tables_denied > 0);
        }
        assert!(stats.hist_reused_records >= n);
    }
}

#[test]
fn constant_next_digit_uses_fresh_counts_after_union_scan_skips_it() {
    let n = 4097;
    let source: Vec<_> = (0..n)
        .map(|i| Record {
            ordinal: i,
            key: (((i % 3) << 24)
                | (0x55 << 16)
                | (((i * 691) % 4093) & 0xffff)) as u128,
        })
        .collect();
    let mut expected = source.clone();
    expected.sort_by_key(|r| r.key);
    let mut actual = source;
    let (_, stats) =
        joint_histograms::sort_with_budget(&mut actual, 8, 64, 512 * 1024);
    identity(&actual, &expected);
    assert_eq!(stats.prepared_rejected_records, n);
    assert_eq!(stats.hist_reused_records, 0);
    assert_eq!(stats.joint_updates, n);
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
    fn extract(&self, _mask: u32, shift: usize) -> usize {
        MODE.with(|mode| {
            if mode.get() == 2 {
                if shift == 0 {
                    256
                } else {
                    (self.0 >> shift) as usize & 255
                }
            } else {
                CALLS.with(|calls| {
                    let n = calls.get();
                    calls.set(n + 1);
                    if mode.get() == 0 {
                        usize::from(n >= 1000)
                    } else {
                        usize::from(n >= 3 && n < 1000)
                    }
                })
            }
        })
    }
}
#[test]
fn changing_extractors_panic_before_uninitialized_stream_reads() {
    let source: Vec<_> = (0..1000).map(|i| Changing((i * 73) % 1000)).collect();
    for mode in 0..3 {
        CALLS.with(|calls| calls.set(0));
        MODE.with(|state| state.set(mode));
        let mut actual = source.clone();
        assert!(std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
            joint_histograms::block_msd_stable_radixsort(&mut actual, 8, 64);
        }))
        .is_err());
        assert_eq!(actual, source);
    }
}

use block_msd_research::{carried_boundaries, count_first_full_scan};
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
fn carried_setup_keeps_complete_stable_output_and_block_statistics() {
    for n in [0, 1, 128, 129, 257, 2051] {
        for pattern in 0..6 {
            let source = records(n, pattern);
            let mut expected = source.clone();
            expected.sort_by_key(|r| r.key);
            for radix in [1, 3, 5, 8] {
                for block in [1, 7, 64, 129] {
                    let mut old = source.clone();
                    let mut new = source.clone();
                    let a = count_first_full_scan::block_msd_stable_radixsort(
                        &mut old, radix, block,
                    );
                    let b = carried_boundaries::block_msd_stable_radixsort(
                        &mut new, radix, block,
                    );
                    identity(&old, &expected);
                    identity(&new, &expected);
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
                            a.phases.histogram_records,
                            b.phases.histogram_records
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
    for mode in 0..2 {
        CALLS.with(|calls| calls.set(0));
        MODE.with(|state| state.set(mode));
        let mut actual = source.clone();
        assert!(std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
            carried_boundaries::block_msd_stable_radixsort(&mut actual, 8, 64);
        }))
        .is_err());
        assert_eq!(actual, source);
    }
}

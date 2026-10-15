use block_msd_research::{count_first, count_first_full_scan, stable_baseline};
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
fn identity(a: &[Record], b: &[Record]) {
    assert_eq!(a.len(), b.len());
    assert!(a
        .iter()
        .zip(b)
        .all(|(a, b)| a.key == b.key && a.ordinal == b.ordinal));
}
fn records(keys: impl Iterator<Item = u128>) -> Vec<Record> {
    keys.enumerate().map(|(ordinal, key)| Record { key, ordinal }).collect()
}

#[test]
#[cfg(feature = "cf_early_scan")]
fn scan_preserves_splits_with_early_late_and_constant_high_digits() {
    for pattern in 0..4 {
        let source = records((0..2051).map(|i| {
            let low = ((i * 61789) % 4093) as u128;
            match pattern {
                0 => ((i % 7) as u128) << 125 | low,
                1 => {
                    if i == 2050 {
                        (1u128 << 127) | low
                    } else {
                        low
                    }
                },
                2 => (0xabcdu128 << 112) | low,
                _ => (i % 3) as u128,
            }
        }));
        let mut expected = source.clone();
        expected.sort_by_key(|r| r.key);
        for radix in [1, 3, 5, 8] {
            for block in [1, 7, 64, 129] {
                let mut old = source.clone();
                let mut new = source.clone();
                let a = count_first_full_scan::block_msd_stable_radixsort(
                    &mut old, radix, block,
                );
                let b = count_first::block_msd_stable_radixsort(
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
                    assert!(b.phases.union_records <= a.phases.union_records);
                    assert_eq!(
                        a.phases.histogram_records,
                        b.phases.histogram_records
                    );
                    assert_eq!(
                        a.phases.scatter_records,
                        b.phases.scatter_records
                    );
                    assert_eq!(a.phases.leaf_lengths, b.phases.leaf_lengths);
                    if pattern == 0 {
                        assert!(
                            b.phases.union_records < a.phases.union_records
                        );
                    }
                }
            }
        }
    }
}

#[test]
fn corrected_stable_msd_keeps_ties_across_descending_and_merged_runs() {
    for n in [129, 257, 1024, 4097] {
        for pattern in 0..5 {
            let source = records((0..n).map(|i| match pattern {
                0 => ((n - i) / 2) as u128,
                1 => ((i * 61789) % 31) as u128,
                2 => {
                    if i % 97 == 0 {
                        i as u128
                    } else {
                        0
                    }
                },
                3 => {
                    let j = i % 129;
                    (if (i / 129) % 2 == 0 { j / 3 } else { (129 - j) / 3 })
                        as u128
                },
                _ => ((i * 691) % 4093) as u128 | (1u128 << 127),
            }));
            let mut expected = source.clone();
            expected.sort_by_key(|r| r.key);
            for radix in [1, 3, 8] {
                let mut actual = source.clone();
                stable_baseline::msd_stable_radixsort(&mut actual, radix);
                identity(&actual, &expected);
            }
        }
    }
    // Enumerate small run patterns above the upstream 128-record fallback.
    for word in 0..3usize.pow(7) {
        let source = records(
            (0..129).map(|i| ((word / 3usize.pow((i % 7) as u32)) % 3) as u128),
        );
        let mut expected = source.clone();
        expected.sort_by_key(|r| r.key);
        let mut actual = source;
        stable_baseline::msd_stable_radixsort(&mut actual, 8);
        identity(&actual, &expected);
    }
}

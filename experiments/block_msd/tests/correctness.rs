use block_msd_research::block_msd_stable_radixsort;
use std::cmp::Ordering;
use voracious_radix_sort::{RadixKey, Radixable};
#[derive(Clone, Copy, Debug, PartialEq)]
struct Record {
    key: i128,
    ordinal: usize,
    payload: [u64; 3],
}
impl PartialOrd for Record {
    fn partial_cmp(&self, b: &Self) -> Option<Ordering> {
        self.key.partial_cmp(&b.key)
    }
}
impl Radixable<i128> for Record {
    type Key = i128;
    fn key(&self) -> i128 {
        self.key
    }
}
fn random(state: &mut u64) -> u64 {
    *state ^= *state << 13;
    *state ^= *state >> 7;
    *state ^= *state << 17;
    *state
}
fn source_for_count_first<T: Copy>(values: &[T]) -> Vec<T> {
    let mut values = values.to_vec();
    let mut seed = 73157;
    for i in (1..values.len()).rev() {
        let j = random(&mut seed) as usize % (i + 1);
        values.swap(i, j);
    }
    values
}
fn check<T: Radixable<K> + std::fmt::Debug + PartialEq, K: RadixKey>(
    source: Vec<T>,
    r: usize,
    b: usize,
) {
    let mut expected = source.clone();
    expected.sort_by_key(|x| x.into_key_type());
    let mut pure = source.clone();
    let mut actual = source;
    let mut dense = actual.clone();
    block_msd_research::count_first::block_msd_stable_radixsort(
        &mut dense, r, b,
    );
    assert_eq!(dense, expected, "count-first r={} b={}", r, b);
    assert!(dense
        .iter()
        .zip(&expected)
        .all(|(a, b)| a.into_key_type() == b.into_key_type()));
    block_msd_stable_radixsort(&mut actual, r, b);
    let pure_expected = expected.clone();
    block_msd_research::block_msd_stable_radixsort_body(&mut pure, r, b, 0);
    let mut dense = source_for_count_first(&expected);
    let mut dense_expected = dense.clone();
    dense_expected.sort_by_key(|x| x.into_key_type());
    block_msd_research::count_first::block_msd_stable_radixsort_body(
        &mut dense, r, b, 0,
    );
    assert_eq!(dense, dense_expected, "pure count-first r={} b={}", r, b);
    assert_eq!(pure, pure_expected, "pure block r={} b={}", r, b);
    assert!(pure
        .iter()
        .zip(&pure_expected)
        .all(|(a, b)| a.into_key_type() == b.into_key_type()));
    assert!(actual
        .iter()
        .zip(&expected)
        .all(|(a, b)| a.into_key_type() == b.into_key_type()));
    if actual != expected {
        let mismatch =
            actual.iter().zip(&expected).position(|(a, b)| a != b).unwrap();
        panic!(
            "n={} r={} b={} mismatch={} actual={:?} expected={:?}",
            actual.len(),
            r,
            b,
            mismatch,
            actual[mismatch],
            expected[mismatch]
        );
    }
}
#[test]
fn boundaries_and_stability() {
    for r in [1, 2, 3, 5, 8].iter().copied() {
        for b in [1, 2, 3, 7, 16, 31, 64, 129].iter().copied() {
            for n in [
                0,
                1,
                2,
                b - 1,
                b,
                b + 1,
                2 * b - 1,
                2 * b,
                2 * b + 1,
                257,
                1025,
            ]
            .iter()
            .copied()
            {
                let mut seed = 123 + n as u64;
                check(
                    (0..n)
                        .map(|i| Record {
                            key: ((random(&mut seed) % 17) as i128) - 8,
                            ordinal: i,
                            payload: [i as u64; 3],
                        })
                        .collect(),
                    r,
                    b,
                );
            }
        }
    }
}
#[test]
fn wide_signed_and_skewed() {
    for r in [3, 7, 8].iter().copied() {
        for b in [1, 5, 32, 512].iter().copied() {
            let mut seed = 89543;
            let raw: Vec<u128> = (0..3000)
                .map(|_| {
                    ((random(&mut seed) as u128) << 64)
                        | random(&mut seed) as u128
                })
                .collect();
            check(raw.clone(), r, b);
            check(raw.iter().map(|&v| v as i128).collect(), r, b);
            check(raw.iter().map(|&v| v as i64).collect(), r, b);
            check(raw.iter().map(|&v| v as u32).collect(), r, b);
            check(
                (0..3000)
                    .map(|i| if i % 97 == 0 { i as u64 } else { u64::MAX })
                    .collect(),
                r,
                b,
            );
            check(vec![i128::MIN, i128::MAX, 0, -1, 1, i128::MIN], r, b);
        }
    }
}
#[test]
fn exhaustive_binary_words() {
    for n in 2..=10 {
        for word in 0usize..(1 << n) {
            for b in [1, 3, 7].iter().copied() {
                check(
                    (0..n)
                        .map(|i| Record {
                            key: ((word >> i) & 1) as i128,
                            ordinal: i,
                            payload: [0; 3],
                        })
                        .collect(),
                    1,
                    b,
                );
            }
        }
    }
}
#[test]
fn floats_order_by_converted_key() {
    let vals = vec![f64::NEG_INFINITY, -4., -0., 0., 2., f64::INFINITY];
    for b in [1, 3, 16].iter().copied() {
        check(vals.clone(), 7, b);
    }
}

#[test]
fn many_seed_dense_frontiers() {
    for trial in 1..=20 {
        let mut seed = trial * 61789;
        for radix in [1, 3, 8].iter().copied() {
            let b = [1, 3, 11, 128][trial as usize % 4];
            let values: Vec<u128> = (0..2000)
                .map(|i| {
                    let x = ((random(&mut seed) as u128) << 64)
                        | random(&mut seed) as u128;
                    if i % 7 == 0 {
                        0
                    } else {
                        x
                    }
                })
                .collect();
            check(values, radix, b);
        }
    }
}

#[derive(Clone, Copy, Debug, PartialEq, PartialOrd)]
struct Zst;
impl Radixable<u32> for Zst {
    type Key = u32;
    fn key(&self) -> u32 {
        0
    }
}
#[test]
fn parameter_contracts_and_zst() {
    for r in [0, 9].iter().copied() {
        assert!(std::panic::catch_unwind(|| {
            let mut a = [1u32, 0];
            block_msd_stable_radixsort(&mut a, r, 4);
        })
        .is_err());
    }
    assert!(std::panic::catch_unwind(|| {
        let mut a = [1u32, 0];
        block_msd_stable_radixsort(&mut a, 8, 0);
    })
    .is_err());
    let mut a = [Zst; 100];
    block_msd_stable_radixsort(&mut a, 8, 1);
    assert_eq!(a, [Zst; 100]);
}

#[derive(Clone, Copy, Debug, PartialEq)]
struct Restricted {
    key: std::num::NonZeroU32,
    state: ValidState,
    payload: &'static str,
    ordinal: usize,
}
#[repr(u8)]
#[derive(Clone, Copy, Debug, PartialEq)]
enum ValidState {
    A = 17,
    B = 93,
}
impl PartialOrd for Restricted {
    fn partial_cmp(&self, b: &Self) -> Option<Ordering> {
        self.key.partial_cmp(&b.key)
    }
}
impl Radixable<u32> for Restricted {
    type Key = u32;
    fn key(&self) -> u32 {
        self.key.get()
    }
}
#[test]
fn restricted_values_and_descending_duplicate_groups() {
    for b in [1, 3, 16, 64, 512].iter().copied() {
        let values: Vec<Restricted> = (0..5000)
            .map(|i| Restricted {
                key: std::num::NonZeroU32::new(((i * 6181) % 97 + 1) as u32)
                    .unwrap(),
                state: if i % 2 == 0 { ValidState::A } else { ValidState::B },
                payload: if i % 3 == 0 { "payload-a" } else { "payload-b" },
                ordinal: i,
            })
            .collect();
        check(values, 8, b);
        check(
            (0..5000)
                .rev()
                .map(|i| Record {
                    key: (i / 7) as i128,
                    ordinal: i,
                    payload: [i as u64; 3],
                })
                .collect(),
            8,
            b,
        );
    }
}

thread_local! {static EXTRACT_CALLS:std::cell::Cell<usize>=const {std::cell::Cell::new(0)};}
#[derive(Clone, Copy, PartialEq, PartialOrd)]
struct ChangingExtractor(u32);
impl Radixable<u32> for ChangingExtractor {
    type Key = u32;
    fn key(&self) -> u32 {
        self.0
    }
    fn extract(&self, _mask: u32, _shift: usize) -> usize {
        EXTRACT_CALLS.with(|calls| {
            let n = calls.get();
            calls.set(n + 1);
            if n < 1000 {
                0
            } else {
                1
            }
        })
    }
}
#[test]
fn changing_safe_extractor_panics_before_uninitialized_output_read() {
    EXTRACT_CALLS.with(|calls| calls.set(0));
    let source: Vec<ChangingExtractor> =
        (0..1000).map(|i| ChangingExtractor((i * 73) % 1000)).collect();
    let mut values = source.clone();
    assert!(std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
        block_msd_stable_radixsort(&mut values, 8, 64);
    }))
    .is_err());
    assert!(values.iter().zip(&source).all(|(a, b)| a.0 == b.0));
    EXTRACT_CALLS.with(|calls| calls.set(0));
    let mut dense = source.clone();
    assert!(std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
        block_msd_research::count_first::block_msd_stable_radixsort(
            &mut dense, 8, 64,
        );
    }))
    .is_err());
    assert!(dense.iter().zip(&source).all(|(a, b)| a.0 == b.0));
}

#[test]
fn count_first_unbounded_boundary_heads_and_deep_siblings() {
    for b in [1, 3, 7, 64, 257].iter().copied() {
        // At b257 all 256 nonaligned ends require distinct boundaries.
        // Shuffling pressures private partial heads while input remains live.
        let mut keys = Vec::new();
        for digit in 0u128..256 {
            let count = b * 2 + 1;
            for i in 0..count {
                keys.push((digit << 120) | ((i * 619) % 257) as u128);
            }
        }
        let keys = source_for_count_first(&keys);
        let source: Vec<Record> = keys
            .iter()
            .enumerate()
            .map(|(i, &key)| Record {
                key: key as i128,
                ordinal: i,
                payload: [i as u64; 3],
            })
            .collect();
        check(source, 8, b);
    }
    // A continuing left branch pauses right siblings at many digit depths.
    let mut keys = vec![0u128; 1024];
    for bit in 0..128 {
        for _ in 0..17 {
            keys.push(1u128 << bit);
        }
    }
    let keys = source_for_count_first(&keys);
    for b in [1, 3, 11, 64].iter().copied() {
        check(keys.clone(), 1, b);
    }
}

#[derive(Clone, Copy, Debug, PartialEq, PartialOrd)]
struct ChangingShortSegment(u32);
impl Radixable<u32> for ChangingShortSegment {
    type Key = u32;
    fn key(&self) -> u32 {
        self.0
    }
    fn extract(&self, _mask: u32, _shift: usize) -> usize {
        EXTRACT_CALLS.with(|calls| {
            let n = calls.get();
            calls.set(n + 1);
            if n < 3 || n >= 1000 {
                0
            } else {
                1
            }
        })
    }
}
#[test]
fn changing_extractor_cannot_overrun_shared_boundary_subinterval() {
    let source: Vec<ChangingShortSegment> =
        (0..1000).map(|i| ChangingShortSegment((i * 73) % 1000)).collect();
    for backend in 0..2 {
        EXTRACT_CALLS.with(|calls| calls.set(0));
        let mut values = source.clone();
        assert!(std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
            if backend == 0 {
                block_msd_stable_radixsort(&mut values, 8, 64);
            } else {
                block_msd_research::count_first::block_msd_stable_radixsort(
                    &mut values,
                    8,
                    64,
                );
            }
        }))
        .is_err());
        assert_eq!(values, source);
    }
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
fn tagged_nan_payloads_follow_converted_keys_stably() {
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
    let source: Vec<TaggedFloat> = (0..3000)
        .map(|ordinal| TaggedFloat {
            bits: bits[random(&mut seed) as usize % bits.len()],
            ordinal,
        })
        .collect();
    for radix in [3, 7, 8].iter().copied() {
        for b in [1, 7, 64].iter().copied() {
            check(source.clone(), radix, b);
        }
    }
}

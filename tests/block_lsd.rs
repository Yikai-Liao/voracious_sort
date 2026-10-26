use voracious_radix_sort::{block_lsd_stable_radixsort, Radixable};

#[repr(C)]
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
struct Record<const N: usize> {
    key: u64,
    position: usize,
    payload: [u64; N],
}

impl<const N: usize> Radixable<u64> for Record<N> {
    type Key = u64;
    fn key(&self) -> u64 { self.key }
}

fn check_records<const N: usize>() {
    for n in [0, 1, 2, 127, 128, 129, 1023, 1024, 1025, 16_385] {
        for pattern in 0..6 {
            let input: Vec<_> = (0..n)
                .map(|position| {
                    let mixed =
                        (position as u64).wrapping_mul(0x9e3779b97f4a7c15);
                    let key = match pattern {
                        0 => mixed,
                        1 => mixed % 7,
                        2 => (u64::MAX & !65535) | (mixed & 65535),
                        3 => ((n - position) / 4) as u64,
                        4 => 42,
                        _ => {
                            if position + 1 == n {
                                43
                            } else {
                                42
                            }
                        },
                    };
                    Record { key, position, payload: [mixed; N] }
                })
                .collect();
            let mut expected = input.clone();
            expected.sort_by_key(|item| item.key);
            for radix in 1..=8 {
                let mut actual = input.clone();
                block_lsd_stable_radixsort(&mut actual, radix);
                assert_eq!(
                    actual, expected,
                    "n={}, pattern={}, radix={}",
                    n, pattern, radix
                );
            }
        }
    }
}

#[test]
fn test_sort_block_lsd_stable_radixsort_records() {
    check_records::<0>();
    check_records::<2>();
    check_records::<14>();
}

#[test]
fn test_sort_block_lsd_stable_radixsort_integer_keys() {
    for radix in 1..=8 {
        macro_rules! check {
            ($($t:ty),*) => {$({
                let input = [<$t>::MAX, 0, 1, <$t>::MIN, 0, <$t>::MAX, 2];
                let mut actual: Vec<$t> = input.iter().copied().cycle().take(1025).collect();
                let mut expected = actual.clone();
                expected.sort();
                block_lsd_stable_radixsort(&mut actual, radix);
                assert_eq!(actual, expected);
            })*};
        }
        check!(u8, u16, u32, u64, u128, usize, i8, i16, i32, i64, i128, isize);
    }
}

#[test]
fn test_sort_block_lsd_stable_radixsort_float_keys() {
    for radix in 1..=8 {
        macro_rules! check {
            ($t:ty, $positive_nan:expr, $negative_nan:expr) => {{
                let input = [
                    <$t>::NEG_INFINITY,
                    -3.0,
                    -0.0,
                    0.0,
                    2.5,
                    <$t>::INFINITY,
                    $positive_nan,
                    $negative_nan,
                ];
                for n in [input.len(), 128, 129, 1025] {
                    let mut actual: Vec<$t> =
                        input.iter().copied().cycle().take(n).collect();
                    let mut expected = actual.clone();
                    expected.sort_by_key(|item| item.into_key_type());
                    block_lsd_stable_radixsort(&mut actual, radix);
                    assert!(actual
                        .iter()
                        .zip(&expected)
                        .all(|(a, b)| a.to_bits() == b.to_bits()));
                }
            }};
        }
        check!(f32, f32::from_bits(0x7fc00001), f32::from_bits(0xffc00002));
        check!(
            f64,
            f64::from_bits(0x7ff8000000000001),
            f64::from_bits(0xfff8000000000002)
        );
    }
}

#[test]
fn test_sort_block_lsd_stable_radixsort_zero_sized_records() {
    #[derive(Clone, Copy, PartialEq, PartialOrd)]
    struct Empty;
    impl Radixable<u32> for Empty {
        type Key = u32;
        fn key(&self) -> u32 { 0 }
    }
    let mut actual = [Empty; 1025];
    block_lsd_stable_radixsort(&mut actual, 8);
}

#[test]
fn test_sort_block_lsd_stable_radixsort_invalid_radix() {
    for radix in [0, 9, usize::MAX] {
        for n in [0, 1, 128, 129] {
            let mut actual: Vec<u32> = (0..n).rev().collect();
            let expected = actual.clone();
            let result =
                std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
                    block_lsd_stable_radixsort(&mut actual, radix);
                }));
            assert!(result.is_err());
            assert_eq!(actual, expected);
        }
    }
}

#[test]
fn test_sort_block_lsd_stable_radixsort_varying_bits() {
    #[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
    struct WideRecord {
        key: u128,
        position: usize,
    }
    impl Radixable<u128> for WideRecord {
        type Key = u128;
        fn key(&self) -> u128 { self.key }
    }
    for n in [127, 128, 129, 2051, 262_144, 262_145, 400_385] {
        for pattern in 0..4 {
            let input: Vec<_> = (0..n)
                .map(|position| {
                    let key = ((position * 73) % 997) as u128;
                    let key = match pattern {
                        0 => key | (u128::MAX << 13),
                        1 => key | (((position % 256) as u128) << 120),
                        2 if position + 1 == n => key | (1 << 127),
                        _ => key,
                    };
                    WideRecord { key, position: n - position }
                })
                .collect();
            let mut expected = input.clone();
            expected.sort_by_key(|item| item.key);
            for radix in 1..=8 {
                let mut actual = input.clone();
                block_lsd_stable_radixsort(&mut actual, radix);
                assert_eq!(
                    actual, expected,
                    "n={}, pattern={}, radix={}",
                    n, pattern, radix
                );
            }
        }
    }
}

#[cfg(not(feature = "voracious_multithread"))]
#[test]
fn test_sort_block_lsd_stable_radixsort_local_records() {
    #[derive(Clone, Copy, PartialEq, PartialOrd)]
    struct Local<'a> {
        key: u32,
        payload: &'a std::rc::Rc<()>,
    }
    impl Radixable<u32> for Local<'_> {
        type Key = u32;
        fn key(&self) -> u32 { self.key }
    }
    let payload = std::rc::Rc::new(());
    for n in [2, 129, 262_145] {
        let mut actual: Vec<_> = (0..n)
            .map(|i| Local { key: ((i * 73) % 997) as u32, payload: &payload })
            .collect();
        block_lsd_stable_radixsort(&mut actual, 8);
        assert!(actual.windows(2).all(|pair| pair[0].key <= pair[1].key));
        assert!(actual.iter().all(|item| std::ptr::eq(item.payload, &payload)));
    }
}

#[test]
fn test_sort_block_lsd_stable_radixsort_invalid_extraction() {
    #[derive(Clone, Copy, PartialEq, PartialOrd)]
    struct Invalid {
        key: u32,
        bucket: usize,
    }
    impl Radixable<u32> for Invalid {
        type Key = u32;
        fn key(&self) -> u32 { self.key }
        fn extract(&self, _mask: u32, _shift: usize) -> usize { self.bucket }
    }
    for (n, bucket) in [(129, usize::MAX), (129, 256), (262_145, usize::MAX)] {
        let mut actual: Vec<_> = (0..n)
            .map(|i| Invalid { key: ((i * 73) % 997) as u32, bucket })
            .collect();
        let result =
            std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
                block_lsd_stable_radixsort(&mut actual, 8);
            }));
        assert!(result.is_err());
    }
}

#[test]
fn test_sort_block_lsd_stable_radixsort_scratch_payloads() {
    #[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
    struct NonzeroRecord<'a> {
        key: u64,
        nonzero: std::num::NonZeroU32,
        reference: &'a u64,
        payload: bool,
        position: usize,
    }
    impl Radixable<u64> for NonzeroRecord<'_> {
        type Key = u64;
        fn key(&self) -> u64 { self.key }
    }
    let referent = 17;
    for n in [128, 129, 4099, 262_145] {
        let input: Vec<_> = (0..n)
            .map(|position| NonzeroRecord {
                key: ((position * 73) % 997) as u64,
                nonzero: std::num::NonZeroU32::new(position as u32 + 1)
                    .unwrap(),
                reference: &referent,
                payload: position % 2 == 0,
                position,
            })
            .collect();
        let mut expected = input.clone();
        expected.sort_by_key(|item| item.key);
        for radix in [1, 4, 7, 8] {
            let mut actual = input.clone();
            block_lsd_stable_radixsort(&mut actual, radix);
            assert_eq!(actual, expected, "n={}, radix={}", n, radix);
        }
    }
}

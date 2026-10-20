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
    fn key(&self) -> u64 {
        self.key
    }
}

fn check_records<const N: usize>() {
    for n in [0, 1, 128, 129, 1025, 16_385] {
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
fn test_adaptive_records() {
    check_records::<2>();
    check_records::<14>();
}

#[test]
fn test_adaptive_integer_keys() {
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
fn test_adaptive_float_keys() {
    for radix in 1..=8 {
        macro_rules! check {
            ($t:ty, $nan:expr) => {{
                let input = [
                    <$t>::NEG_INFINITY,
                    -3.0,
                    -0.0,
                    0.0,
                    2.5,
                    <$t>::INFINITY,
                    $nan,
                ];
                let mut actual: Vec<$t> =
                    input.iter().copied().cycle().take(1025).collect();
                let mut expected = actual.clone();
                expected.sort_by_key(|item| item.into_key_type());
                block_lsd_stable_radixsort(&mut actual, radix);
                assert!(actual
                    .iter()
                    .zip(&expected)
                    .all(|(a, b)| a.to_bits() == b.to_bits()));
            }};
        }
        check!(f32, f32::from_bits(0xffc00002));
        check!(f64, f64::from_bits(0x7ff8000000000001));
    }
}

#[test]
fn test_adaptive_zero_sized_records() {
    #[derive(Clone, Copy, PartialEq, PartialOrd)]
    struct Empty;
    impl Radixable<u32> for Empty {
        type Key = u32;
        fn key(&self) -> u32 {
            0
        }
    }
    let mut actual = [Empty; 1025];
    block_lsd_stable_radixsort(&mut actual, 8);
}

#[test]
fn test_adaptive_invalid_radix() {
    for radix in [0, 9, usize::MAX] {
        for n in [0, 1, 129] {
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

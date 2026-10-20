use voracious_radix_sort::{block_lsd_stable_radixsort, RadixKey, Radixable};

fn check_keys<T: Radixable<K>, K: RadixKey>(
    input: &[T],
    radix: usize,
    block_size: usize,
) {
    for n in [input.len(), 515] {
        let mut arr: Vec<T> = input.iter().copied().cycle().take(n).collect();
        let mut expected = arr.clone();
        expected.sort_by_key(|v| v.into_key_type());
        block_lsd_stable_radixsort(&mut arr, radix, block_size);
        assert!(arr
            .iter()
            .zip(&expected)
            .all(|(a, b)| a.into_key_type() == b.into_key_type()));
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
struct Record {
    key: u128,
    position: usize,
}
impl Radixable<u128> for Record {
    type Key = u128;
    fn key(&self) -> u128 {
        self.key
    }
}

fn check_records<T: Radixable<K> + std::fmt::Debug + PartialEq, K: RadixKey>(
    input: &[T],
    radix: usize,
    block_size: usize,
) {
    let mut arr = input.to_vec();
    let mut expected = arr.clone();
    expected.sort_by_key(|item| item.into_key_type());
    block_lsd_stable_radixsort(&mut arr, radix, block_size);
    assert_eq!(arr, expected, "radix={}, block_size={}", radix, block_size);
}

#[test]
fn test_sort_block_lsd_equal_prefix_order_checks() {
    // The first change can fall inside a four-key chunk or its tail. Skipping
    // the known prefix must still preserve its equal-key payload order when
    // reversing, and must not skip a later violation of the chosen direction.
    for first_change in [1, 2, 3, 4, 5, 127, 128, 255, 256, 511, 512] {
        for pattern in 0..4 {
            let mut input: Vec<_> = (0..513)
                .map(|position| Record {
                    key: if position < first_change {
                        42
                    } else if pattern % 2 == 0 {
                        43
                    } else {
                        41
                    },
                    position,
                })
                .collect();
            if pattern >= 2 {
                input.last_mut().unwrap().key = if pattern == 2 { 41 } else { 43 };
            }
            for radix in [1, 4, 8] {
                for block_size in [1, 31, 512] {
                    check_records(&input, radix, block_size);
                }
            }
        }
    }
}

#[test]
fn test_sort_block_lsd_records() {
    let mut state = 0x123456789abcdefu128;
    for radix in 1..=8 {
        for block_size in [1, 2, 3, 7, 31, 512] {
            for n in [
                0,
                1,
                2,
                block_size - 1,
                block_size,
                block_size + 1,
                2 * block_size,
                2 * block_size + 1,
                4099,
            ] {
                for pattern in 0..6 {
                    let arr: Vec<_> = (0..n)
                        .map(|i| {
                            state ^= state << 13;
                            state ^= state >> 7;
                            state ^= state << 17;
                            let key = match pattern {
                                0 => state,
                                1 => state % 7,
                                2 => i as u128,
                                3 => ((n - i) / 7) as u128,
                                4 => ((i % 17) as u128) << 120,
                                _ => u128::MAX,
                            };
                            Record { key, position: n - i }
                        })
                        .collect();
                    check_records(&arr, radix, block_size);
                }
            }
        }
    }
}

#[test]
fn test_sort_block_lsd_varying_bits() {
    for pattern in 0..3 {
        let mut arr: Vec<_> = (0..2051)
            .map(|position| Record {
                key: ((position * 31) % 257) as u128,
                position,
            })
            .collect();
        match pattern {
            0 => arr.iter_mut().for_each(|item| item.key |= u128::MAX << 13),
            1 => {
                arr[0].key = 0;
                arr[1].key = u128::MAX;
            },
            _ => arr.last_mut().unwrap().key |= 1 << 127,
        }
        for radix in 1..=8 {
            for block_size in [1, 31, 512] {
                check_records(&arr, radix, block_size);
            }
        }
    }
}

#[test]
fn test_sort_block_lsd_key_conversions() {
    for radix in 1..=8 {
        macro_rules! integers {
            ($($t:ty),*) => {$({
                let input = [<$t>::MAX, 0, 1, <$t>::MIN, 0, <$t>::MAX, 2];
                check_keys(&input, radix, 3);
            })*};
        }
        integers!(
            u8, u16, u32, u64, u128, usize, i8, i16, i32, i64, i128, isize
        );
        check_keys(&[true, false, true, false], radix, 1);
        check_keys(&['🦀', 'a', '\0', '中', 'a', '\u{10ffff}'], radix, 2);
        check_keys(
            &[
                f32::NEG_INFINITY,
                -3.0,
                -0.0,
                0.0,
                2.5,
                f32::INFINITY,
                f32::from_bits(0x7fc00001),
                f32::from_bits(0xffc00002),
            ],
            radix,
            3,
        );
        check_keys(
            &[
                f64::NEG_INFINITY,
                -3.0,
                -0.0,
                0.0,
                2.5,
                f64::INFINITY,
                f64::from_bits(0x7ff8000000000001),
                f64::from_bits(0xfff8000000000002),
            ],
            radix,
            3,
        );
    }
}

#[test]
fn test_sort_block_lsd_invalid_parameters() {
    for (radix, block_size) in
        [(0, 512), (9, 512), (usize::MAX, 512), (8, 0), (8, usize::MAX)]
    {
        let mut arr = [3u32, 1, 2];
        let result =
            std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
                block_lsd_stable_radixsort(&mut arr, radix, block_size);
            }));
        assert!(result.is_err());
        assert_eq!(arr, [3, 1, 2]);
    }
}

#[cfg(not(feature = "voracious_multithread"))]
#[test]
fn test_sort_block_lsd_local_records() {
    #[derive(Clone, Copy, PartialEq, PartialOrd)]
    struct Local<'a> {
        key: u32,
        payload: &'a std::rc::Rc<()>,
    }
    impl Radixable<u32> for Local<'_> {
        type Key = u32;
        fn key(&self) -> u32 {
            self.key
        }
    }
    let payload = std::rc::Rc::new(());
    let mut arr = [
        Local { key: 3, payload: &payload },
        Local { key: 1, payload: &payload },
    ];
    block_lsd_stable_radixsort(&mut arr, 8, 1);
    assert_eq!(arr[0].key, 1);
    assert!(std::ptr::eq(arr[0].payload, &payload));
}

#[test]
fn test_sort_block_lsd_block_tails() {
    for n in [262_144, 262_145, 400_385] {
        let arr: Vec<_> = (0..n)
            .map(|i| Record {
                // Repeated keys exercise stability while all 256 buckets get
                // partial blocks, including exact multiples of the block size.
                key: ((i as u128 * 73) % 997) | (((i % 256) as u128) << 120),
                position: n - i,
            })
            .collect();
        check_records(&arr, 8, 512);
    }
}

#[test]
fn test_sort_block_lsd_zero_sized_records() {
    #[derive(Clone, Copy, PartialEq, PartialOrd)]
    struct Empty;
    impl Radixable<u32> for Empty {
        type Key = u32;
        fn key(&self) -> u32 {
            0
        }
    }
    let mut arr = [Empty; 5];
    block_lsd_stable_radixsort(&mut arr, 8, 512);
    assert_eq!(arr.len(), 5);
}

#[test]
fn test_sort_block_lsd_invalid_extraction() {
    #[derive(Clone, Copy, PartialEq, PartialOrd)]
    struct Invalid {
        key: u32,
        bucket: usize,
    }
    impl Radixable<u32> for Invalid {
        type Key = u32;
        fn key(&self) -> u32 {
            self.key
        }
        fn extract(&self, _mask: u32, _shift: usize) -> usize {
            self.bucket
        }
    }
    for (bucket, block_size) in [(usize::MAX, 1), (usize::MAX, 512), (0, 512)] {
        let mut arr: Vec<_> =
            (0..129).map(|i| Invalid { key: (i * 73) % 129, bucket }).collect();
        let result =
            std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
                block_lsd_stable_radixsort(&mut arr, 8, block_size);
            }));
        assert!(result.is_err());
    }
}

#[test]
fn test_sort_block_lsd_scratch_payloads() {
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
        fn key(&self) -> u64 {
            self.key
        }
    }
    let referent = 17;
    let input: Vec<_> = (0..4099)
        .map(|position| NonzeroRecord {
            key: ((position * 73) % 997) as u64,
            nonzero: std::num::NonZeroU32::new(position as u32 + 1).unwrap(),
            reference: &referent,
            payload: position % 2 == 0,
            position,
        })
        .collect();
    for radix in [1, 4, 7, 8] {
        for block_size in [1, 3, 31, 512] {
            check_records(&input, radix, block_size);
        }
    }
}

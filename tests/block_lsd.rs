use std::cmp::Ordering;
use voracious_radix_sort::{block_lsd_stable_radixsort, RadixKey, Radixable};

fn check<T: Radixable<K>, K: RadixKey>(
    input: &[T],
    radix: usize,
    block: usize,
) {
    let mut arr = input.to_vec();
    let mut expected = input.to_vec();
    expected.sort_by_key(|v| v.into_key_type());
    block_lsd_stable_radixsort(&mut arr, radix, block);
    assert!(arr
        .iter()
        .zip(&expected)
        .all(|(a, b)| a.into_key_type() == b.into_key_type()));
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
struct Record {
    key: u128,
    position: usize,
}
impl PartialOrd for Record {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        (self.key, self.position).partial_cmp(&(other.key, other.position))
    }
}
impl Radixable<u128> for Record {
    type Key = u128;
    fn key(&self) -> u128 {
        self.key
    }
}

#[test]
fn stable_records_across_radices_blocks_and_distributions() {
    let mut state = 0x123456789abcdefu128;
    for radix in 1..=8 {
        for block in [1, 2, 3, 7, 31, 512] {
            for n in [
                0,
                1,
                2,
                block - 1,
                block,
                block + 1,
                2 * block,
                2 * block + 1,
                4099,
            ] {
                for pattern in 0..6 {
                    let mut arr: Vec<_> = (0..n)
                        .map(|i| {
                            state ^= state << 13;
                            state ^= state >> 7;
                            state ^= state << 17;
                            let key = match pattern {
                                0 => state,
                                1 => state % 7,
                                2 => i as u128,
                                3 => (n - i) as u128,
                                4 => ((i % 17) as u128) << 120,
                                _ => u128::MAX,
                            };
                            Record { key, position: n - i }
                        })
                        .collect();
                    let mut expected = arr.clone();
                    expected.sort_by_key(|r| r.key);
                    block_lsd_stable_radixsort(&mut arr, radix, block);
                    assert_eq!(
                        arr, expected,
                        "radix={}, block={}, n={}, pattern={}",
                        radix, block, n, pattern
                    );
                }
            }
        }
    }
}

#[test]
fn narrow_varying_bits_under_a_nonzero_wide_prefix() {
    for radix in 1..=8 {
        for block in [1, 31, 512] {
            let mut records: Vec<_> = (0..2051)
                .map(|position| Record {
                    key: (u128::MAX << 13) | ((position * 31 % 257) as u128),
                    position,
                })
                .collect();
            let mut expected = records.clone();
            expected.sort_by_key(|record| record.key);
            block_lsd_stable_radixsort(&mut records, radix, block);
            assert_eq!(records, expected, "radix={radix}, block={block}");
        }
    }
}

#[test]
fn primitive_key_conversions_and_partial_digits() {
    for radix in 1..=8 {
        macro_rules! integers {
            ($($t:ty),*) => {$({
                let input = [<$t>::MAX, 0, 1, <$t>::MIN, 0, <$t>::MAX, 2];
                check(&input, radix, 3);
            })*};
        }
        integers!(
            u8, u16, u32, u64, u128, usize, i8, i16, i32, i64, i128, isize
        );
        check(&[true, false, true, false], radix, 1);
        check(&['🦀', 'a', '\0', '中', 'a', '\u{10ffff}'], radix, 2);
        check(
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
        check(
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
fn rejects_invalid_parameters_before_mutation() {
    for (radix, block) in
        [(0, 512), (9, 512), (usize::MAX, 512), (8, 0), (8, usize::MAX)]
    {
        let mut arr = [3u32, 1, 2];
        let result =
            std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
                block_lsd_stable_radixsort(&mut arr, radix, block);
            }));
        assert!(result.is_err());
        assert_eq!(arr, [3, 1, 2]);
    }
}

#[cfg(not(feature = "voracious_multithread"))]
#[test]
fn single_thread_records_need_neither_default_nor_send_sync() {
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
fn default_parameters_large_blocks_and_all_bucket_tails() {
    for n in [262_144, 262_145, 400_385] {
        let mut arr: Vec<_> = (0..n)
            .map(|i| Record {
                // Repeated keys exercise stability while all 256 buckets get
                // partial blocks, including exact multiples of the block size.
                key: ((i as u128 * 73) % 997) | (((i % 256) as u128) << 120),
                position: n - i,
            })
            .collect();
        let mut expected = arr.clone();
        expected.sort_by_key(|r| r.key);
        block_lsd_stable_radixsort(&mut arr, 8, 512);
        assert_eq!(arr, expected);
    }
}

#[test]
fn zero_sized_records_do_not_use_pointer_differences() {
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
fn invalid_custom_bucket_panics_without_an_unchecked_pointer_access() {
    #[derive(Clone, Copy, PartialEq, PartialOrd)]
    struct Invalid(u32);
    impl Radixable<u32> for Invalid {
        type Key = u32;
        fn key(&self) -> u32 {
            self.0
        }
        fn extract(&self, _mask: u32, _shift: usize) -> usize {
            usize::MAX
        }
    }
    let mut arr: Vec<_> = (0..129).map(|i| Invalid((i * 73) % 129)).collect();
    for block in [1, 512] {
        let result =
            std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
                block_lsd_stable_radixsort(&mut arr, 8, block);
            }));
        assert!(result.is_err());
    }
}

#[test]
fn scratch_padding_never_becomes_a_typed_value() {
    #[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
    enum Payload {
        A = 1,
        B = 7,
    }
    #[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
    struct NonzeroRecord<'a> {
        key: u64,
        nonzero: std::num::NonZeroU32,
        reference: &'a u64,
        payload: Payload,
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
            payload: if position % 2 == 0 { Payload::A } else { Payload::B },
            position,
        })
        .collect();
    let mut expected = input.clone();
    expected.sort_by_key(|record| record.key);
    for radix in [1, 4, 7, 8] {
        for block in [1, 3, 31, 512] {
            let mut arr = input.clone();
            block_lsd_stable_radixsort(&mut arr, radix, block);
            assert_eq!(arr, expected);
        }
    }
}

#[test]
fn descending_groups_keep_their_original_payload_order() {
    let input: Vec<_> = (0..1000)
        .map(|i| Record { key: ((999 - i) / 7) as u128, position: i })
        .collect();
    let mut expected = input.clone();
    expected.sort_by_key(|item| item.key);
    for radix in [1, 4, 8] {
        let mut arr = input.clone();
        block_lsd_stable_radixsort(&mut arr, radix, 31);
        assert_eq!(arr, expected);
    }
}

#[test]
fn inconsistent_extract_cannot_read_an_unfilled_scatter_slot() {
    #[derive(Clone, Copy, PartialEq, PartialOrd)]
    struct Inconsistent(u32);
    impl Radixable<u32> for Inconsistent {
        type Key = u32;
        fn key(&self) -> u32 {
            self.0
        }
        fn extract(&self, _mask: u32, _shift: usize) -> usize {
            0
        }
    }
    let mut arr: Vec<_> =
        (0..129).map(|i| Inconsistent((i * 73) % 129)).collect();
    let result = std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
        block_lsd_stable_radixsort(&mut arr, 8, 512);
    }));
    assert!(result.is_err());
}

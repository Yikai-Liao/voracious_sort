#![cfg(feature = "voracious_multithread")]

use rayon::ThreadPoolBuilder;
use std::{cmp::Ordering, num::NonZeroU32};
use voracious_radix_sort::{
    block_lsd_stable_mt_radixsort, block_lsd_stable_mt_radixsort_in_pool,
    Radixable,
};

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
struct Tagged {
    key: u128,
    ordinal: usize,
    payload: NonZeroU32,
    reference: &'static u32,
}
// Radix order must come from the key, independent of record PartialOrd.
impl PartialOrd for Tagged {
    fn partial_cmp(&self, _: &Self) -> Option<Ordering> {
        Some(Ordering::Equal)
    }
}
impl Radixable<u128> for Tagged {
    type Key = u128;
    fn key(&self) -> u128 {
        self.key
    }
}
static VALUE: u32 = 41;
fn record(key: u128, ordinal: usize) -> Tagged {
    Tagged {
        key,
        ordinal,
        payload: NonZeroU32::new((ordinal % 1000 + 1) as u32).unwrap(),
        reference: &VALUE,
    }
}
fn random(state: &mut u128) -> u128 {
    *state ^= *state << 13;
    *state ^= *state >> 7;
    *state ^= *state << 17;
    *state
}

#[test]
fn stable_across_pools_radices_blocks_and_partial_heavy_passes() {
    let mut seed = 0xa129523193a8b49u128;
    for threads in [1, 2, 3, 8] {
        let pool =
            ThreadPoolBuilder::new().num_threads(threads).build().unwrap();
        for radix in 1..=8 {
            for block in [1, 3, 17, 512] {
                for n in [0, 1, 129, 257, block * 3 + 1] {
                    // Common nonzero high prefix, duplicate keys, and full-width
                    // keys exercise different sequences of partial block layouts.
                    for pattern in 0..3 {
                        let mut arr: Vec<_> = (0..n)
                            .map(|i| {
                                let x = random(&mut seed);
                                let key = match pattern {
                                    0 => x,
                                    1 => (u128::MAX << 16) | (x & 0xffff),
                                    _ => x % 19,
                                };
                                record(key, i)
                            })
                            .collect();
                        let mut expected = arr.clone();
                        expected.sort_by_key(|x| x.key);
                        block_lsd_stable_mt_radixsort_in_pool(
                            &mut arr, radix, block, &pool,
                        );
                        assert_eq!(arr, expected, "threads={threads} radix={radix} block={block} n={n} pattern={pattern}");
                    }
                }
            }
        }
    }
}

#[test]
fn parallel_large_records_and_thread_boundary_tails() {
    let pool = ThreadPoolBuilder::new().num_threads(8).build().unwrap();
    let mut seed = 1729u128;
    for n in [262_144, 262_145, 262_657] {
        let mut arr: Vec<_> =
            (0..n).map(|i| record(random(&mut seed) % 100_003, i)).collect();
        let mut expected = arr.clone();
        expected.sort_by_key(|x| x.key);
        block_lsd_stable_mt_radixsort_in_pool(&mut arr, 8, 512, &pool);
        assert_eq!(arr, expected);
    }
}

#[test]
fn descending_duplicate_groups_remain_stable() {
    let mut arr: Vec<_> =
        (0..1027).map(|i| record(((1027 - i) / 7) as u128, i)).collect();
    let mut expected = arr.clone();
    expected.sort_by_key(|x| x.key);
    block_lsd_stable_mt_radixsort(&mut arr, 8, 3, 4);
    assert_eq!(arr, expected);
}

#[test]
fn signed_and_float_converted_key_order() {
    let pool = ThreadPoolBuilder::new().num_threads(4).build().unwrap();
    let mut ints: Vec<_> =
        (0..4099).map(|i| [i128::MIN, -1, 0, 1, i128::MAX][i % 5]).collect();
    let mut expected = ints.clone();
    expected.sort();
    block_lsd_stable_mt_radixsort_in_pool(&mut ints, 7, 13, &pool);
    assert_eq!(ints, expected);
    let mut floats: Vec<_> = (0..4099)
        .map(|i| {
            f64::from_bits(
                [
                    0xfff0000000000000,
                    0x8000000000000000,
                    0,
                    0x7ff0000000000000,
                    0x7ff8000000000001,
                    0xfff8000000000001,
                ][i % 6],
            )
        })
        .collect();
    let mut expected = floats.clone();
    expected.sort_by_key(|x| x.into_key_type());
    block_lsd_stable_mt_radixsort_in_pool(&mut floats, 8, 7, &pool);
    assert!(floats
        .iter()
        .zip(&expected)
        .all(|(a, b)| a.to_bits() == b.to_bits()));
}

#[derive(Clone, Copy, PartialEq, PartialOrd)]
struct Bad(u32);
impl Radixable<u32> for Bad {
    type Key = u32;
    fn key(&self) -> u32 {
        self.0
    }
    fn extract(&self, _: u32, _: usize) -> usize {
        256
    }
}
#[test]
fn invalid_extractor_panics_inside_join_without_unchecked_access() {
    let pool = ThreadPoolBuilder::new().num_threads(4).build().unwrap();
    let mut arr: Vec<_> =
        (0..4099).map(|i| Bad((i * 7919 % 4099) as u32)).collect();
    assert!(std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
        block_lsd_stable_mt_radixsort_in_pool(&mut arr, 8, 17, &pool);
    }))
    .is_err());
    // The same pool remains usable after worker panic and join.
    let mut good = [3u32, 1, 2];
    block_lsd_stable_mt_radixsort_in_pool(&mut good, 8, 17, &pool);
    assert_eq!(good, [1, 2, 3]);
}

#[test]
fn invalid_parameters_are_rejected_before_mutation() {
    for (radix, block, threads) in
        [(0, 512, 2), (9, 512, 2), (8, 0, 2), (8, 512, 0)]
    {
        let mut arr = [2u32, 1];
        assert!(std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| {
            block_lsd_stable_mt_radixsort(&mut arr, radix, block, threads);
        }))
        .is_err());
        assert_eq!(arr, [2, 1]);
    }
}

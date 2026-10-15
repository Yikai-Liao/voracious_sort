use block_msd_research::skew_paths::{self, Mode};
use std::{cmp::Ordering, num::NonZeroU32};
use voracious_radix_sort::Radixable;

#[derive(Clone, Copy, Debug)]
struct Record {
    key: u128,
    identity: usize,
    payload: [usize; 4],
}
impl PartialEq for Record {
    fn eq(&self, rhs: &Self) -> bool {
        self.key == rhs.key
    }
}
impl PartialOrd for Record {
    fn partial_cmp(&self, rhs: &Self) -> Option<Ordering> {
        self.key.partial_cmp(&rhs.key)
    }
}
impl Radixable<u128> for Record {
    type Key = u128;
    fn key(&self) -> u128 {
        self.key
    }
}
fn record(key: u128, identity: usize) -> Record {
    Record {
        key,
        identity,
        payload: [identity, !identity, identity.rotate_left(7), identity * 3],
    }
}
fn identical(actual: &[Record], expected: &[Record]) {
    assert_eq!(actual.len(), expected.len());
    for (a, b) in actual.iter().zip(expected) {
        assert_eq!(
            (a.key, a.identity, a.payload),
            (b.key, b.identity, b.payload)
        );
    }
}
fn compare(
    source: &[Record],
    radix: usize,
    budget: usize,
    mode: Mode,
) -> skew_paths::SkewStats {
    let mut expected = source.to_vec();
    expected.sort_by_key(|r| r.key);
    let mut actual = source.to_vec();
    let stats =
        skew_paths::sort_with_budget(&mut actual, radix, 7, budget, mode);
    identical(&actual, &expected);
    assert!(stats.peak_workspace_bytes <= budget);
    stats
}
#[test]
fn identities_radices_tail_sizes_and_budget_rejection() {
    for length in [0, 1, 2, 127, 128, 129, 257, 1025] {
        for pattern in 0..5 {
            let input: Vec<_> = (0..length)
                .map(|i| {
                    record(
                        match pattern {
                            0 => ((i * 61789) % 4093) as u128,
                            1 => {
                                if i % 71 == 0 {
                                    1u128 << ((i / 71) % 128)
                                } else {
                                    0
                                }
                            },
                            2 => {
                                if i % 71 == 0 {
                                    u128::MAX - (1u128 << ((i / 71) % 128))
                                } else {
                                    u128::MAX
                                }
                            },
                            3 => {
                                (0xabcdu128 << 112) | ((length - i) / 3) as u128
                            },
                            _ => 19,
                        },
                        i,
                    )
                })
                .collect();
            for radix in 1..=8 {
                for mode in [Mode::SingleLayer, Mode::DeferredChain] {
                    for budget in [0, 8192, skew_paths::WORKSPACE_BUDGET] {
                        compare(&input, radix, budget, mode);
                    }
                }
            }
        }
    }
}
#[test]
fn deferred_chain_moves_survivors_once_and_flushes_whole_entry() {
    let input: Vec<_> = (0..4096)
        .map(|i| {
            record(if i % 97 == 0 { 1u128 << ((i / 97) % 120) } else { 0 }, i)
        })
        .collect();
    let single = compare(&input, 8, 16 * 1024, Mode::SingleLayer);
    let deferred = compare(&input, 8, 16 * 1024, Mode::DeferredChain);
    assert!(single.special_nodes > 2);
    assert!(deferred.max_deferred_levels > 2);
    assert_eq!(deferred.flushes, 1);
    assert!(deferred.major_records_moved < single.major_records_moved);
    // The metadata plus twenty fully budgeted minority slots admit several
    // levels, then reject before extracting another level.
    let limited = compare(
        &input,
        8,
        4096 + 2
            * (std::mem::size_of::<Record>() + std::mem::size_of::<usize>())
            * 20,
        Mode::DeferredChain,
    );
    assert!(limited.max_deferred_levels > 1);
    assert_eq!(limited.budget_flushes, 1);
    assert_eq!(limited.flushes, 1);
    assert!(limited.fallback_calls > 0);
}
#[test]
fn minority_siblings_on_both_sides_are_sorted_with_full_identity() {
    let input: Vec<_> = (0..4099)
        .map(|i| {
            record(
                if i % 37 == 0 {
                    0x7000_0000_0000_0000_0000_0000_0000_0000 | (i % 11) as u128
                } else if i % 41 == 0 {
                    0x9000_0000_0000_0000_0000_0000_0000_0000 | (i % 7) as u128
                } else {
                    0x8000_0000_0000_0000_0000_0000_0000_0000
                        | ((i * 13) % 1000) as u128
                },
                i,
            )
        })
        .collect();
    for mode in [Mode::SingleLayer, Mode::DeferredChain] {
        compare(&input, 8, 32 * 1024, mode);
    }
}
#[derive(Clone, Copy, Debug, PartialEq, PartialOrd)]
enum Choice {
    One,
    Two,
    Three,
}
#[derive(Clone, Copy, Debug, PartialEq, PartialOrd)]
struct Valid<'a> {
    key: u32,
    nz: NonZeroU32,
    choice: Choice,
    reference: &'a usize,
}
impl<'a> Radixable<u32> for Valid<'a> {
    type Key = u32;
    fn key(&self) -> u32 {
        self.key
    }
}
#[test]
fn valid_nonzero_enum_and_reference_payloads() {
    let storage: Vec<_> = (0..1025).collect();
    let input: Vec<_> = storage
        .iter()
        .enumerate()
        .map(|(i, r)| Valid {
            key: if i % 97 == 0 { 1u32 << (i % 32) } else { 0 },
            nz: NonZeroU32::new(i as u32 + 1).unwrap(),
            choice: [Choice::One, Choice::Two, Choice::Three][i % 3],
            reference: r,
        })
        .collect();
    let mut expected = input.clone();
    expected.sort_by_key(|r| r.key);
    for mode in [Mode::SingleLayer, Mode::DeferredChain] {
        let mut actual = input.clone();
        skew_paths::sort_with_budget(&mut actual, 8, 13, 32 * 1024, mode);
        assert_eq!(actual, expected);
        for (a, b) in actual.iter().zip(&expected) {
            assert!(std::ptr::eq(a.reference, b.reference));
        }
    }
}
#[derive(Clone, Copy, Debug, PartialEq, PartialOrd)]
struct Float {
    key: f32,
    identity: usize,
}
impl Radixable<f32> for Float {
    type Key = f32;
    fn key(&self) -> f32 {
        self.key
    }
}
#[test]
fn float_nan_payloads_follow_converted_keys() {
    let bits = [
        0xffc00001, 0xff800000, 0x80000000, 0, 0x7f800000, 0x7fc00001,
        0x7fc00002, 0x3f800000,
    ];
    let input: Vec<_> = (0..1025)
        .map(|i| Float {
            key: f32::from_bits(
                bits[if i % 97 == 0 { i % bits.len() } else { 3 }],
            ),
            identity: i,
        })
        .collect();
    let mut expected = input.clone();
    expected.sort_by_key(|v| v.into_key_type());
    for mode in [Mode::SingleLayer, Mode::DeferredChain] {
        let mut actual = input.clone();
        skew_paths::sort_with_budget(&mut actual, 8, 3, 32 * 1024, mode);
        assert!(actual
            .iter()
            .zip(&expected)
            .all(|(a, b)| a.key.to_bits() == b.key.to_bits()
                && a.identity == b.identity));
    }
}

#![cfg(feature = "frontier_work")]

use block_msd_research::frontier::{sort_pa_with_threshold, PaExperiment};
use voracious_radix_sort::Radixable;

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
struct Record {
    key: u128,
    identity: u64,
    payload: u64,
}

impl PartialOrd for Record {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.key.cmp(&other.key))
    }
}

impl Radixable<u128> for Record {
    type Key = u128;
    fn key(&self) -> u128 {
        self.key
    }
}

fn input(length: usize, positions: &[usize]) -> Vec<Record> {
    let mut state = 42u64;
    (0..length)
        .map(|identity| {
            state ^= state << 13;
            state ^= state >> 7;
            state ^= state << 17;
            let logical = if identity < positions.len() {
                1u64 << identity
            } else if identity == positions.len() {
                0
            } else {
                state
            };
            let key = positions.iter().enumerate().fold(0, |key, (i, bit)| {
                key | (u128::from((logical >> i) & 1) << bit)
            });
            Record { key, identity: identity as u64, payload: !identity as u64 }
        })
        .collect()
}

#[cfg(all(target_arch = "x86_64", not(feature = "projection_portable")))]
#[test]
fn partial_packing_requires_two_saved_prefix_passes() {
    if !std::is_x86_feature_detected!("avx2")
        || !std::is_x86_feature_detected!("bmi2")
    {
        eprintln!("partial packing probe requires the measured x86 hardware");
        return;
    }
    for admit in [false, true] {
        // q=25 exceeds the root's 24-bit budget. Three high-prefix bytes
        // compress to one; two high-prefix bytes save only one physical pass.
        let positions: Vec<_> = if admit {
            (0..22).chain([111, 119, 127]).collect()
        } else {
            (0..23).chain([119, 127]).collect()
        };
        let original = input(65537, &positions);
        let mut expected = original.clone();
        expected.sort_by_key(|record| record.key);
        let mut baseline = original.clone();
        let base = sort_pa_with_threshold::<_, u128>(
            &mut baseline,
            PaExperiment::UnifiedGroups,
            64,
            16 * 1024 * 1024,
        );
        let mut prior = original.clone();
        let prior_work = sort_pa_with_threshold::<_, u128>(
            &mut prior,
            PaExperiment::UnifiedPackedContext,
            64,
            16 * 1024 * 1024,
        );
        let mut strict = original;
        let work = sort_pa_with_threshold::<_, u128>(
            &mut strict,
            PaExperiment::UnifiedStrict,
            64,
            16 * 1024 * 1024,
        );
        assert_eq!(baseline, expected);
        assert_eq!(prior, expected);
        assert_eq!(strict, expected);
        assert!(prior_work.projection_nodes > 0);
        if admit {
            assert!(work.projection_nodes > 0);
            assert!(work.projection_records >= strict.len());
            assert!(work.max_depth >= 1);
        } else {
            assert_eq!(work.projection_nodes, 0);
            assert_eq!(work, base);
        }
    }
    eprintln!("verified partial admission and one-pass rejection");
}

#[cfg(feature = "projection_portable")]
#[test]
fn disabled_hardware_preserves_the_entire_strict_route() {
    for q in [8, 9, 16, 24, 32] {
        let positions: Vec<_> = (0..q).map(|j| j * 127 / (q - 1)).collect();
        let original = input(16385, &positions);
        let mut expected = original.clone();
        expected.sort_by_key(|record| record.key);
        let mut baseline = original.clone();
        let base = sort_pa_with_threshold::<_, u128>(
            &mut baseline,
            PaExperiment::UnifiedGroups,
            64,
            16 * 1024 * 1024,
        );
        let mut strict = original;
        let work = sort_pa_with_threshold::<_, u128>(
            &mut strict,
            PaExperiment::UnifiedStrict,
            64,
            16 * 1024 * 1024,
        );
        assert_eq!(baseline, expected);
        assert_eq!(strict, expected);
        assert_eq!(work, base, "q{q}");
        assert_eq!(work.projection_nodes, 0);
    }
}

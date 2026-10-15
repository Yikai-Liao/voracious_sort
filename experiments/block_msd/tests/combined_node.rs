use block_msd_research::{
    materialization_gate::{sort_with_options, Gate},
    node_local,
};
use std::cmp::Ordering;
use std::sync::atomic::{AtomicUsize, Ordering as AtomicOrdering};
use std::sync::Mutex;
use voracious_radix_sort::Radixable;
static TEST_LOCK: Mutex<()> = Mutex::new(());
static TOP_EXTRACTS: AtomicUsize = AtomicUsize::new(0);
#[derive(Clone, Copy, Debug, PartialEq)]
struct R {
    key: u128,
    ordinal: usize,
    payload: [u64; 1],
}
impl PartialOrd for R {
    fn partial_cmp(&self, b: &Self) -> Option<Ordering> {
        self.key.partial_cmp(&b.key)
    }
}
impl Radixable<u128> for R {
    type Key = u128;
    fn key(&self) -> u128 {
        self.key
    }
    fn extract(&self, mask: u128, shift: usize) -> usize {
        if shift == 120 {
            TOP_EXTRACTS.fetch_add(1, AtomicOrdering::Relaxed);
        }
        ((self.key & mask) >> shift) as usize
    }
}
fn source(n: usize, pattern: usize) -> Vec<R> {
    (0..n)
        .map(|i| {
            let mut group = i * 256 / n;
            if pattern == 1 && i + 1 == n {
                group = 0;
            }
            if pattern == 2 && i == 0 {
                group = 1;
            }
            if pattern == 2 && i == 1 {
                group = 0;
            }
            let low = (i as u128)
                .wrapping_mul(0x9e3779b97f4a7c15d1b54a32d192ed03)
                & ((1u128 << 120) - 1);
            R {
                key: ((group as u128) << 120) | low,
                ordinal: i,
                payload: [i as u64],
            }
        })
        .collect()
}
#[test]
fn current_digit_skip_and_late_rejection_preserve_identity_and_extract_contract(
) {
    let _guard = TEST_LOCK.lock().unwrap();
    let n = 65539;
    for pattern in 0..3 {
        let input = source(n, pattern);
        let mut expected = input.clone();
        expected.sort_by_key(|r| r.key);
        let mut actual = input.clone();
        TOP_EXTRACTS.store(0, AtomicOrdering::Relaxed);
        let s = sort_with_options(
            &mut actual,
            8,
            64,
            node_local::CACHE_BUDGET,
            Gate::DyadicPotential,
            true,
            true,
        );
        assert_eq!(actual, expected);
        let check_records = if pattern == 2 { 2 } else { n };
        assert_eq!(s.monotone_records, check_records);
        assert_eq!(
            TOP_EXTRACTS.load(AtomicOrdering::Relaxed),
            n + check_records + usize::from(pattern != 0) * n
        );
        assert_eq!(s.monotone_nodes, usize::from(pattern == 0));
        assert_eq!(s.skipped_scatter_records, if pattern == 0 { n } else { 0 });
        assert_eq!(s.local.block_nodes, usize::from(pattern != 0));
        assert_eq!(s.fallback_nodes, 0);
    }
}
#[test]
fn combined_gates_stay_stable_and_obey_their_separate_work_bounds() {
    let _guard = TEST_LOCK.lock().unwrap();
    for n in [129, 2051, 16387] {
        for pattern in 0..3 {
            for radix in [1, 3, 8] {
                for block in [7, 64, 129] {
                    for budget in [0, node_local::CACHE_BUDGET] {
                        for gate in [Gate::Retired, Gate::DyadicPotential] {
                            let mut input = source(n, pattern);
                            let mut expected = input.clone();
                            expected.sort_by_key(|r| r.key);
                            let s = sort_with_options(
                                &mut input, radix, block, budget, gate, true,
                                true,
                            );
                            assert_eq!(input, expected);
                            match gate {
                                Gate::Retired => {
                                    assert!(
                                        s.accepted_records
                                            <= 4 * s.retired_records
                                    );
                                    assert!(s.retired_records <= n);
                                },
                                Gate::DyadicPotential => assert!(
                                    s.accepted_records as u128
                                        <= 4 * s.potential_drop
                                ),
                            }
                        }
                    }
                }
            }
        }
    }
}

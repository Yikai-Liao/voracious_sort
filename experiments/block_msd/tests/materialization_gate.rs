use block_msd_research::{
    materialization_gate::{sort_with_gate, Gate},
    node_local,
};
use std::cmp::Ordering;
use voracious_radix_sort::Radixable;
#[derive(Clone, Copy, Debug)]
struct R {
    key: u128,
    id: usize,
}
impl PartialEq for R {
    fn eq(&self, b: &Self) -> bool {
        self.key == b.key
    }
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
}
#[test]
fn gates_sort_stably_and_bound_charged_work() {
    for n in [129, 1025, 16384, 65536] {
        for pattern in 0..3 {
            let source: Vec<_> = (0..n)
                .map(|i| R {
                    key: match pattern {
                        0 => (i as u128)
                            .wrapping_mul(0x9e3779b97f4a7c15d1b54a32d192ed03),
                        1 => {
                            if i % 97 == 0 {
                                1u128 << ((i / 97) % 128)
                            } else {
                                0
                            }
                        },
                        _ => (0xabcdu128 << 112) | ((i * 691) % 4093) as u128,
                    },
                    id: i,
                })
                .collect();
            let mut expected = source.clone();
            expected.sort_by_key(|r| r.key);
            for radix in [1, 3, 8] {
                for block in [7, 64, 129] {
                    for budget in [0, node_local::CACHE_BUDGET] {
                        for gate in [Gate::Retired, Gate::DyadicPotential] {
                            let mut actual = source.clone();
                            let s = sort_with_gate(
                                &mut actual,
                                radix,
                                block,
                                budget,
                                gate,
                            );
                            assert!(actual
                                .iter()
                                .zip(&expected)
                                .all(|(a, b)| a.key == b.key && a.id == b.id));
                            match gate {
                                Gate::Retired => {
                                    assert!(
                                        s.accepted_records
                                            <= 4 * s.retired_records
                                    );
                                    assert!(s.retired_records <= n)
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
#[test]
fn whole_node_rejection_precedes_materialization() {
    let mut a: Vec<_> = (0..65536)
        .map(|i| R {
            key: if i % 97 == 0 { 1u128 << ((i / 97) % 128) } else { 0 },
            id: i,
        })
        .collect();
    let s = sort_with_gate(&mut a, 8, 64, 0, Gate::Retired);
    assert_eq!(s.accepted_nodes, 0);
    assert_eq!(s.fallback_nodes, 1);
    assert_eq!(s.fallback_records, a.len());
    assert_eq!(s.local.block_nodes, 0);
}

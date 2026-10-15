//! Independent admission gates over the frozen node-local free-list backend.
//! Rejection sorts the whole contiguous node with the original stream backend.
use crate::{count_first_full_scan, node_local};
use std::mem::{size_of, MaybeUninit};
use voracious_radix_sort::{RadixKey, Radixable};
#[derive(Clone, Copy, Debug)]
pub enum Gate {
    Retired,
    DyadicPotential,
}
#[derive(Default, Debug)]
pub struct GateStats {
    pub local: node_local::LocalStats,
    pub accepted_records: usize,
    pub retired_records: usize,
    pub accepted_nodes: usize,
    pub fallback_records: usize,
    pub fallback_nodes: usize,
    pub potential_drop: u128,
}
const K: u128 = 4;
const LEAF: usize = 128;
// Exact integer potential; this is a dyadic analogue, not the logarithmic formula.
fn potential(n: usize) -> u128 {
    if n <= LEAF {
        return 0;
    }
    let q = (n - 1) / LEAF + 1;
    let levels = usize::BITS - (q - 1).leading_zeros();
    (n as u128) * (1 + levels as u128)
}
pub fn sort_with_gate<T: Radixable<Ky>, Ky: RadixKey>(
    a: &mut [T],
    radix: usize,
    block: usize,
    budget: usize,
    gate: Gate,
) -> GateStats {
    assert!((1..=8).contains(&radix) && block > 0);
    let mut stats = GateStats::default();
    if a.len() < 2 || size_of::<T>() == 0 {
        return stats;
    }
    if a.len() <= LEAF {
        a.sort_by_key(|v| v.into_key_type());
        stats.local.leaf_sorts += 1;
        return stats;
    }
    if node_local::ordered::<T, Ky>(a) {
        return stats;
    }
    recurse(a, a[0].type_size(), radix, block, budget, gate, &mut stats);
    stats
}
fn recurse<T: Radixable<Ky>, Ky: RadixKey>(
    a: &mut [T],
    mut bits: usize,
    radix: usize,
    block: usize,
    budget: usize,
    gate: Gate,
    stats: &mut GateStats,
) {
    if a.len() < 2 || bits == 0 {
        return;
    }
    if a.len() <= LEAF {
        a.sort_by_key(|v| v.into_key_type());
        stats.local.leaf_sorts += 1;
        return;
    }
    let dummy = a[0];
    let mut union = dummy.default_key();
    let mut intersection = dummy.into_key_type();
    for value in a.iter() {
        let key = value.into_key_type();
        union |= key;
        intersection = intersection & key;
    }
    stats.local.variation_records += a.len();
    while bits > 0 {
        let width = radix.min(bits);
        let shift = bits - width;
        let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
        if union & mask != intersection & mask {
            break;
        }
        bits = shift;
    }
    if bits == 0 {
        return;
    }
    if node_local::cache_fits::<T>(a.len(), bits, radix, budget) {
        stats.local.cache_entries += 1;
        stats.local.max_cache_records =
            stats.local.max_cache_records.max(a.len());
        let mut scratch = vec![MaybeUninit::uninit(); a.len()];
        node_local::cached_msd(a, &mut scratch, bits, radix, &mut stats.local);
        return;
    }
    let width = radix.min(bits);
    let shift = bits - width;
    let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
    let mut counts = vec![0usize; 1usize << width];
    for value in a.iter() {
        counts[value.extract(mask, shift)] += 1;
    }
    let complete = |n| {
        shift == 0
            || n <= LEAF
            || node_local::cache_fits::<T>(n, shift, radix, budget)
    };
    let retired: usize = counts.iter().copied().filter(|&n| complete(n)).sum();
    let child_potential: u128 =
        counts.iter().copied().filter(|&n| !complete(n)).map(potential).sum();
    let potential_drop = potential(a.len()).saturating_sub(child_potential);
    let accepted = match gate {
        Gate::Retired => a.len() as u128 <= K * retired as u128,
        Gate::DyadicPotential => a.len() as u128 <= K * potential_drop,
    };
    if !accepted {
        stats.fallback_nodes += 1;
        stats.fallback_records += a.len();
        drop(counts);
        count_first_full_scan::block_msd_stable_radixsort(a, radix, block);
        return;
    }
    stats.accepted_nodes += 1;
    stats.accepted_records += a.len();
    stats.retired_records += retired;
    stats.potential_drop += potential_drop;
    node_local::partition(a, &counts, mask, shift, block, &mut stats.local);
    let mut rest = a;
    for count in counts {
        let (child, suffix) = rest.split_at_mut(count);
        rest = suffix;
        recurse(child, shift, radix, block, budget, gate, stats);
    }
}

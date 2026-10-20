//! Controlled root-statistic and monotone-evidence reductions over 749ca4d hybrid.
//! The potential gate, carried partition and cache admission are unchanged.
#[cfg(not(feature = "cf_work"))]
use crate::node_local;
#[cfg(feature = "cf_work")]
use crate::reduction_node as node_local;
use crate::reduction_stream;
use std::mem::{size_of, MaybeUninit};
use voracious_radix_sort::{RadixKey, Radixable};
#[derive(Default, Debug)]
pub struct GateStats {
    pub local: node_local::LocalStats,
    pub fallback: reduction_stream::Stats,
    pub accepted_records: usize,
    pub retired_records: usize,
    pub accepted_nodes: usize,
    pub fallback_records: usize,
    pub fallback_nodes: usize,
    pub potential_drop: u128,
    pub monotone_records: usize,
    pub monotone_nodes: usize,
    pub skipped_scatter_records: usize,
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
/// Potential-gated carried materialization, with carried+batched stream fallback.
pub fn sort_hybrid<T: Radixable<Ky>, Ky: RadixKey>(
    a: &mut [T],
    radix: usize,
    block: usize,
    budget: usize,
    skip_monotone: bool,
) -> GateStats {
    sort_impl(a, radix, block, budget, skip_monotone, false, false)
}

pub fn sort_reduced<T: Radixable<Ky>, Ky: RadixKey>(
    a: &mut [T],
    radix: usize,
    block: usize,
    budget: usize,
    prepared: bool,
    fused: bool,
) -> GateStats {
    sort_impl(a, radix, block, budget, fused, prepared, fused)
}

fn sort_impl<T: Radixable<Ky>, Ky: RadixKey>(
    a: &mut [T],
    radix: usize,
    block: usize,
    budget: usize,
    skip_monotone: bool,
    prepared: bool,
    fused: bool,
) -> GateStats {
    assert!((1..=8).contains(&radix) && block > 0);
    let mut stats = GateStats::default();
    if a.len() < 2 || size_of::<T>() == 0 {
        return stats;
    }
    if a.len() <= LEAF {
        #[cfg(feature = "cf_work")]
        {
            stats.local.work.leaf_records += a.len();
            stats.local.work.leaf_lengths[a.len()] += 1;
        }
        #[cfg(feature = "cf_work")]
        let leaf_start = std::time::Instant::now();
        a.sort_by_key(|v| v.into_key_type());
        #[cfg(feature = "cf_work")]
        {
            stats.local.work.leaf_ns += leaf_start.elapsed().as_nanos();
        }

        stats.local.leaf_sorts += 1;
        return stats;
    }
    #[cfg(feature = "cf_work")]
    let ordered_start = std::time::Instant::now();
    let is_ordered = node_local::ordered::<T, Ky>(
        a,
        #[cfg(feature = "cf_work")]
        &mut stats.local.work,
    );
    #[cfg(feature = "cf_work")]
    {
        stats.local.work.ordered_ns += ordered_start.elapsed().as_nanos();
    }
    if is_ordered {
        return stats;
    }
    recurse(
        a,
        a[0].type_size(),
        radix,
        block,
        budget,
        skip_monotone,
        prepared,
        fused,
        true,
        &mut stats,
    );
    stats
}
fn recurse<T: Radixable<Ky>, Ky: RadixKey>(
    a: &mut [T],
    mut bits: usize,
    radix: usize,
    block: usize,
    budget: usize,
    skip_monotone: bool,
    prepared: bool,
    fused: bool,
    root: bool,
    stats: &mut GateStats,
) {
    if a.len() < 2 || bits == 0 {
        return;
    }
    if a.len() <= LEAF {
        #[cfg(feature = "cf_work")]
        {
            stats.local.work.leaf_records += a.len();
            stats.local.work.leaf_lengths[a.len()] += 1;
        }
        #[cfg(feature = "cf_work")]
        let leaf_start = std::time::Instant::now();
        a.sort_by_key(|v| v.into_key_type());
        #[cfg(feature = "cf_work")]
        {
            stats.local.work.leaf_ns += leaf_start.elapsed().as_nanos();
        }

        stats.local.leaf_sorts += 1;
        return;
    }
    let dummy = a[0];
    #[cfg(feature = "cf_work")]
    let variation_start = std::time::Instant::now();
    let mut union = dummy.default_key();
    let mut intersection = dummy.into_key_type();
    for value in a.iter() {
        let key = value.into_key_type();
        union |= key;
        intersection = intersection & key;
    }
    stats.local.variation_records += a.len();
    #[cfg(feature = "cf_work")]
    {
        stats.local.work.variation_records += a.len();
    }
    while bits > 0 {
        let width = radix.min(bits);
        let shift = bits - width;
        let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
        if union & mask != intersection & mask {
            break;
        }
        bits = shift;
    }
    #[cfg(feature = "cf_work")]
    {
        stats.local.work.variation_ns += variation_start.elapsed().as_nanos();
    }
    if bits == 0 {
        return;
    }
    if node_local::cache_fits::<T>(a.len(), bits, radix, budget) {
        stats.local.cache_entries += 1;
        stats.local.max_cache_records =
            stats.local.max_cache_records.max(a.len());
        let mut scratch = vec![MaybeUninit::uninit(); a.len()];
        node_local::cached_msd(
            a,
            &mut scratch,
            bits,
            radix,
            &mut stats.local,
            #[cfg(feature = "cf_work")]
            0,
        );
        return;
    }
    let width = radix.min(bits);
    let shift = bits - width;
    let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
    #[cfg(feature = "cf_work")]
    {
        stats.local.work.histogram_records += a.len();
        stats.local.work.histogram_slots += 1usize << width;
        stats.local.work.metadata_allocations += 1;
        stats.local.work.metadata_bytes +=
            (1usize << width) * size_of::<usize>();
    }
    #[cfg(feature = "cf_work")]
    let histogram_start = std::time::Instant::now();
    let mut counts = vec![0usize; 1usize << width];
    let mut monotone = fused;
    if fused {
        let mut previous = None;
        for value in a.iter() {
            let digit = value.extract(mask, shift);
            counts[digit] += 1;
            if monotone {
                if previous.map_or(false, |last| digit < last) {
                    monotone = false;
                }
                previous = Some(digit);
                stats.monotone_records += 1;
            }
        }
    } else {
        for value in a.iter() {
            counts[value.extract(mask, shift)] += 1;
        }
    }
    #[cfg(feature = "cf_work")]
    {
        stats.local.work.histogram_ns += histogram_start.elapsed().as_nanos();
    }
    #[cfg(feature = "cf_work")]
    let monotone_start = std::time::Instant::now();
    #[cfg(feature = "cf_work")]
    let previous_checks = stats.monotone_records;
    if skip_monotone && !fused {
        monotone = true;
        let mut previous = a[0].extract(mask, shift);
        stats.monotone_records += 1;
        for value in &a[1..] {
            let digit = value.extract(mask, shift);
            stats.monotone_records += 1;
            if digit < previous {
                monotone = false;
                break;
            }
            previous = digit;
        }
    }
    #[cfg(feature = "cf_work")]
    {
        stats.local.work.extra_monotone_records +=
            stats.monotone_records - previous_checks;
        if skip_monotone && !fused {
            stats.local.work.monotone_ns += monotone_start.elapsed().as_nanos();
        }
    }
    if monotone {
        // A stable digit partition is the identity on this current slice.
        // Counts locate its already contiguous children; no block state exists.
        stats.monotone_nodes += 1;
        stats.skipped_scatter_records += a.len();
    } else {
        let complete = |n| {
            shift == 0
                || n <= LEAF
                || node_local::cache_fits::<T>(n, shift, radix, budget)
        };
        let retired: usize =
            counts.iter().copied().filter(|&n| complete(n)).sum();
        let child_potential: u128 = counts
            .iter()
            .copied()
            .filter(|&n| !complete(n))
            .map(potential)
            .sum();
        let potential_drop = potential(a.len()).saturating_sub(child_potential);
        let accepted = a.len() as u128 <= K * potential_drop;
        if !accepted {
            stats.fallback_nodes += 1;
            stats.fallback_records += a.len();
            let fallback = if prepared {
                reduction_stream::sort_prepared(
                    a, radix, block, bits, counts, root,
                )
            } else {
                drop(counts);
                reduction_stream::block_msd_stable_radixsort(a, radix, block)
            };
            stats.fallback.merge(fallback);
            return;
        }
        stats.accepted_nodes += 1;
        stats.accepted_records += a.len();
        stats.retired_records += retired;
        stats.potential_drop += potential_drop;
        node_local::partition_carried(
            a,
            &counts,
            mask,
            shift,
            block,
            &mut stats.local,
        );
    }
    let mut rest = a;
    for count in counts {
        let (child, suffix) = rest.split_at_mut(count);
        rest = suffix;
        recurse(
            child,
            shift,
            radix,
            block,
            budget,
            skip_monotone,
            prepared,
            fused,
            false,
            stats,
        );
    }
}

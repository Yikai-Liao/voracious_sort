//! Independent two-array admission experiment. The 256 KiB contract remains
//! a cache working-set estimate, not a whole-sort auxiliary-memory limit.
use crate::reduction_node as node;
use std::mem::{size_of, MaybeUninit};
use voracious_radix_sort::{RadixKey, Radixable};

#[derive(Default, Debug)]
pub struct AdmissionStats {
    pub local: node::LocalStats,
    pub peak_retained_histogram_bytes: usize,
    pub max_cache_working_set: usize,
    pub root_cached: bool,
}

/// Input + one record scratch + retained ancestor rows + the maximum live
/// two-array/leaf stage. This uses the inspected toolchain's <=128-record
/// library-owned leaf scratch bound; user extractor allocations are excluded.
pub fn cache_working_set<T>(
    length: usize,
    mut bits: usize,
    radix: usize,
    retained: usize,
) -> Option<usize> {
    assert!((1..=8).contains(&radix));
    let mut rows = 0usize;
    let mut peak = 0usize;
    while bits > 0 {
        let width = radix.min(bits);
        let row = (1usize << width).checked_mul(size_of::<usize>())?;
        rows = rows.checked_add(row)?;
        peak = peak.max(rows.checked_add(row)?);
        bits -= width;
    }
    peak = peak.max(rows.checked_add(128usize.checked_mul(size_of::<T>())?)?);
    length
        .checked_mul(2)?
        .checked_mul(size_of::<T>())?
        .checked_add(retained)?
        .checked_add(peak)
}

pub fn sort_with_lifetimes<T: Radixable<K>, K: RadixKey>(
    a: &mut [T],
    radix: usize,
    block: usize,
    budget: usize,
    live: bool,
) -> AdmissionStats {
    assert!((1..=8).contains(&radix) && block > 0);
    let mut stats = AdmissionStats::default();
    if a.len() < 2 || size_of::<T>() == 0 {
        return stats;
    }
    if a.len() <= 128 {
        leaf(a, &mut stats.local);
        return stats;
    }
    #[cfg(feature = "cf_work")]
    let start = std::time::Instant::now();
    let ordered = node::ordered::<T, K>(
        a,
        #[cfg(feature = "cf_work")]
        &mut stats.local.work,
    );
    #[cfg(feature = "cf_work")]
    {
        stats.local.work.ordered_ns += start.elapsed().as_nanos();
    }
    if ordered {
        return stats;
    }
    recurse(a, a[0].type_size(), radix, block, budget, live, 0, &mut stats);
    stats
}

fn leaf<T: Radixable<K>, K: RadixKey>(
    a: &mut [T],
    stats: &mut node::LocalStats,
) {
    #[cfg(feature = "cf_work")]
    {
        stats.work.leaf_records += a.len();
        stats.work.leaf_lengths[a.len()] += 1;
    }
    #[cfg(feature = "cf_work")]
    let start = std::time::Instant::now();
    a.sort_by_key(|v| v.into_key_type());
    stats.leaf_sorts += 1;
    #[cfg(feature = "cf_work")]
    {
        stats.work.leaf_ns += start.elapsed().as_nanos();
    }
}

fn recurse<T: Radixable<K>, K: RadixKey>(
    a: &mut [T],
    mut bits: usize,
    radix: usize,
    block: usize,
    budget: usize,
    live: bool,
    retained: usize,
    stats: &mut AdmissionStats,
) {
    if a.len() < 2 || bits == 0 {
        return;
    }
    stats.peak_retained_histogram_bytes =
        stats.peak_retained_histogram_bytes.max(retained);
    if a.len() <= 128 {
        leaf(a, &mut stats.local);
        return;
    }
    #[cfg(feature = "cf_work")]
    let start = std::time::Instant::now();
    let dummy = a[0];
    let mut union = dummy.default_key();
    let mut intersection = dummy.into_key_type();
    for v in a.iter() {
        let key = v.into_key_type();
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
        stats.local.work.variation_ns += start.elapsed().as_nanos();
    }
    if bits == 0 {
        return;
    }
    let estimate = cache_working_set::<T>(a.len(), bits, radix, retained);
    let fits = if live {
        estimate.map_or(false, |bytes| bytes <= budget)
    } else {
        node::cache_fits::<T>(a.len(), bits, radix, budget)
    };
    if fits {
        stats.local.cache_entries += 1;
        stats.local.max_cache_records =
            stats.local.max_cache_records.max(a.len());
        stats.max_cache_working_set =
            stats.max_cache_working_set.max(estimate.unwrap_or(usize::MAX));
        stats.root_cached |= retained == 0;
        let mut scratch = vec![MaybeUninit::uninit(); a.len()];
        node::cached_two_arrays(
            a,
            &mut scratch,
            bits,
            radix,
            &mut stats.local,
            0,
        );
        return;
    }
    let width = radix.min(bits);
    let shift = bits - width;
    let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
    #[cfg(feature = "cf_work")]
    let start = std::time::Instant::now();
    let mut counts = vec![0usize; 1usize << width];
    for v in a.iter() {
        counts[v.extract(mask, shift)] += 1;
    }
    #[cfg(feature = "cf_work")]
    {
        stats.local.work.histogram_records += a.len();
        stats.local.work.histogram_slots += counts.len();
        stats.local.work.metadata_allocations += 1;
        stats.local.work.metadata_bytes +=
            counts.capacity() * size_of::<usize>();
        stats.local.work.histogram_ns += start.elapsed().as_nanos();
    }
    let next_retained =
        retained.checked_add(counts.capacity() * size_of::<usize>()).unwrap();
    stats.peak_retained_histogram_bytes =
        stats.peak_retained_histogram_bytes.max(next_retained);
    node::partition(a, &counts, mask, shift, block, &mut stats.local);
    let mut rest = a;
    for count in counts {
        let (child, suffix) = rest.split_at_mut(count);
        rest = suffix;
        if count > 1 {
            recurse(
                child,
                shift,
                radix,
                block,
                budget,
                live,
                next_retained,
                stats,
            );
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn partial_rows_and_leaf_stage_use_the_maximum_simultaneous_storage() {
        assert_eq!(
            cache_working_set::<u32>(1000, 9, 8, 123),
            Some(8000 + 123 + 4096)
        );
        assert_eq!(
            cache_working_set::<u128>(1000, 128, 8, 0),
            Some(32000 + 34816)
        );
        assert_eq!(
            cache_working_set::<[u8; 32]>(1000, 128, 8, 0),
            Some(64000 + 36864)
        );
        assert_eq!(
            cache_working_set::<[u8; 128]>(1000, 32, 8, 0),
            Some(256000 + 24576)
        );
        assert_eq!(cache_working_set::<u128>(usize::MAX, 128, 8, 0), None);
    }
    #[test]
    fn retained_parent_rows_affect_admission_and_root_cutoffs_are_exact() {
        let budget = node::CACHE_BUDGET;
        assert_eq!(cache_working_set::<u32>(31488, 32, 8, 0), Some(budget));
        assert!(cache_working_set::<u32>(31488, 32, 8, 8).unwrap() > budget);
        assert!(cache_working_set::<u32>(31489, 32, 8, 0).unwrap() > budget);
        for n in [28607, 28608, 28609, 31487, 31488, 31489] {
            let source: Vec<_> =
                (0..n).map(|i| (i as u32).wrapping_mul(2654435761)).collect();
            let mut a = source.clone();
            let mut b = source.clone();
            let mut c = source;
            let old = sort_with_lifetimes(&mut a, 8, 64, budget, false);
            let new = sort_with_lifetimes(&mut b, 8, 64, budget, true);
            node::sort_reduced(
                &mut c,
                8,
                64,
                budget,
                node::Placement::FreeList,
                true,
            );
            assert_eq!(a, b);
            assert_eq!(a, c);
            assert_eq!(old.root_cached, n <= 28608);
            assert_eq!(new.root_cached, n <= 31488);
            assert!(new.max_cache_working_set <= budget);
        }
    }
}

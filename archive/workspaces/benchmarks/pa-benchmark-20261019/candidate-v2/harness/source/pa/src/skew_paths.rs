//! Two bounded minority-buffer experiments. Rejected nodes use the unchanged
//! low-space backend; their workspace is separate from the budget here.
use std::{mem::size_of, ptr};
use voracious_radix_sort::{RadixKey, Radixable};

pub const WORKSPACE_BUDGET: usize = 256 * 1024;

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Mode {
    SingleLayer,
    DeferredChain,
}

#[derive(Default, Debug)]
pub struct SkewStats {
    pub fallback_calls: usize,
    pub special_nodes: usize,
    pub deferred_levels: usize,
    pub major_records_moved: usize,
    pub minor_records: usize,
    pub peak_workspace_bytes: usize,
    pub variation_records: usize,
    pub histogram_records: usize,
    pub flushes: usize,
    pub budget_flushes: usize,
    pub max_deferred_levels: usize,
}

type Key<T, K> = <<T as Radixable<K>>::Key as RadixKey>::Key;

pub fn block_msd_stable_radixsort<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
    mode: Mode,
) -> SkewStats {
    sort_with_budget(arr, radix, block_size, WORKSPACE_BUDGET, mode)
}

/// `budget` limits allocated payload capacity owned by this experiment,
/// including deferred sorting scratch and both hole directories. The unchanged
/// fallback backend has its own low-space workspace; record buffers and hole
/// directories are dropped before fallback. Single-layer minor fallbacks retain
/// the current histogram (at most 256 machine words). Fixed stack values and allocator headers are excluded.
pub fn sort_with_budget<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
    budget: usize,
    mode: Mode,
) -> SkewStats {
    assert!((1..=8).contains(&radix));
    assert!(block_size > 0);
    let mut stats = SkewStats::default();
    if arr.len() < 2 || size_of::<T>() == 0 {
        return stats;
    }
    match mode {
        Mode::SingleLayer => single(arr, radix, block_size, budget, &mut stats),
        Mode::DeferredChain => {
            deferred(arr, radix, block_size, budget, &mut stats)
        },
    }
    stats
}

fn fallback<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
    stats: &mut SkewStats,
) {
    if arr.len() > 1 {
        stats.fallback_calls += 1;
        crate::count_first_full_scan::block_msd_stable_radixsort(
            arr, radix, block_size,
        );
    }
}

fn digit<T: Radixable<K>, K: RadixKey>(
    value: T,
    mask: Key<T, K>,
    shift: usize,
) -> usize {
    value.keytype_to_usize(
        (value.into_key_type() & mask) >> value.usize_to_keytype(shift),
    )
}

// Holes are positions in the initial array, never a bitset proportional to n.
fn visit_active<T: Copy, F: FnMut(T)>(
    arr: &[T],
    holes: &[usize],
    mut visit: F,
) {
    let mut start = 0;
    for &hole in holes {
        for &value in &arr[start..hole] {
            visit(value);
        }
        start = hole + 1;
    }
    for &value in &arr[start..] {
        visit(value);
    }
}

fn varied_digit<T: Radixable<K>, K: RadixKey>(
    arr: &[T],
    holes: &[usize],
    mut bits: usize,
    radix: usize,
    stats: &mut SkewStats,
) -> Option<(Key<T, K>, usize, usize)> {
    let dummy = arr[0];
    let mut union = dummy.default_key();
    let mut intersection = None;
    visit_active(arr, holes, |value| {
        let key = value.into_key_type();
        union |= key;
        intersection = Some(intersection.map_or(key, |old| old & key));
    });
    stats.variation_records += arr.len() - holes.len();
    let intersection = intersection?;
    while bits > 0 {
        let width = radix.min(bits);
        let shift = bits - width;
        let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
        if union & mask != intersection & mask {
            return Some((mask, shift, 1 << width));
        }
        bits = shift;
    }
    None
}

fn histogram<T: Radixable<K>, K: RadixKey>(
    arr: &[T],
    holes: &[usize],
    mask: Key<T, K>,
    shift: usize,
    sigma: usize,
    stats: &mut SkewStats,
) -> Vec<usize> {
    let mut counts = vec![0; sigma];
    visit_active(arr, holes, |value| {
        counts[digit::<T, K>(value, mask, shift)] += 1
    });
    stats.histogram_records += arr.len() - holes.len();
    counts
}

fn major_bucket(counts: &[usize]) -> usize {
    counts.iter().enumerate().max_by_key(|&(_, n)| n).unwrap().0
}

fn single<T: Radixable<K>, K: RadixKey>(
    mut arr: &mut [T],
    radix: usize,
    block_size: usize,
    budget: usize,
    stats: &mut SkewStats,
) {
    let mut bits = arr[0].type_size();
    loop {
        if arr.len() <= 128 {
            fallback(arr, radix, block_size, stats);
            return;
        }
        let (mask, shift, sigma) =
            match varied_digit(arr, &[], bits, radix, stats) {
                Some(value) => value,
                None => return,
            };
        // Check before allocating the histogram, then actual capacities below.
        if sigma * 2 * size_of::<usize>() > budget {
            fallback(arr, radix, block_size, stats);
            return;
        }
        let counts = histogram(arr, &[], mask, shift, sigma, stats);
        stats.peak_workspace_bytes = stats
            .peak_workspace_bytes
            .max(counts.capacity() * size_of::<usize>());
        let major = major_bucket(&counts);
        let minor_count = arr.len() - counts[major];
        let required = minor_count
            .checked_mul(size_of::<T>() + size_of::<usize>())
            .and_then(|n| n.checked_add(2 * sigma * size_of::<usize>()));
        if required.map_or(true, |n| n > budget) {
            drop(counts);
            fallback(arr, radix, block_size, stats);
            return;
        }
        let left: usize = counts[..major].iter().sum();
        let major_count = counts[major];
        let mut minor = vec![arr[0]; minor_count];
        let mut holes = Vec::with_capacity(minor_count);
        let mut cursors = vec![0usize; sigma];
        let mut offset = 0;
        for bucket in 0..sigma {
            cursors[bucket] = offset;
            if bucket != major {
                offset += counts[bucket];
            }
        }
        let bytes = minor.capacity() * size_of::<T>()
            + (holes.capacity() + cursors.capacity() + counts.capacity())
                * size_of::<usize>();
        if bytes > budget {
            drop((minor, holes, cursors, counts));
            fallback(arr, radix, block_size, stats);
            return;
        }
        stats.peak_workspace_bytes = stats.peak_workspace_bytes.max(bytes);
        for (position, &value) in arr.iter().enumerate() {
            let bucket = digit::<T, K>(value, mask, shift);
            if bucket != major {
                // Safe initialized storage also makes an inconsistent custom
                // key harmless to memory safety. Deterministic keys are required.
                minor[cursors[bucket]] = value;
                cursors[bucket] += 1;
                holes.push(position);
            }
        }
        assert_eq!(holes.len(), minor_count, "key changed between scans");
        stats.major_records_moved += compact_major(arr, &holes, left);
        arr[..left].copy_from_slice(&minor[..left]);
        arr[left + major_count..].copy_from_slice(&minor[left..]);
        stats.special_nodes += 1;
        stats.minor_records += minor_count;
        drop((minor, holes, cursors));
        let mut offset = 0;
        for (bucket, &count) in counts.iter().enumerate() {
            if bucket != major {
                fallback(
                    &mut arr[offset..offset + count],
                    radix,
                    block_size,
                    stats,
                );
            }
            offset += count;
        }
        drop(counts);
        arr = &mut arr[left..left + major_count];
        bits = shift;
        if bits == 0 || arr.len() < 2 {
            return;
        }
    }
}

/// Each gap between holes contains consecutive major records. With h holes
/// before it, its displacement is left-h. Positive gaps are copied from right
/// to left, negative gaps from left to right; zero gaps stay untouched. These
/// gap families cannot overwrite each other's unread source ranges.
fn compact_major<T: Copy>(
    arr: &mut [T],
    holes: &[usize],
    left: usize,
) -> usize {
    assert!(left <= holes.len());
    let mut moved = 0;
    for h in (0..=holes.len()).rev() {
        if h >= left {
            continue;
        }
        let start = if h == 0 { 0 } else { holes[h - 1] + 1 };
        let end = holes.get(h).copied().unwrap_or(arr.len());
        let length = end - start;
        if length > 0 {
            unsafe {
                ptr::copy(
                    arr.as_ptr().add(start),
                    arr.as_mut_ptr().add(start + left - h),
                    length,
                );
            }
            moved += length;
        }
    }
    for h in 0..=holes.len() {
        if h <= left {
            continue;
        }
        let start = if h == 0 { 0 } else { holes[h - 1] + 1 };
        let end = holes.get(h).copied().unwrap_or(arr.len());
        let length = end - start;
        if length > 0 {
            unsafe {
                ptr::copy(
                    arr.as_ptr().add(start),
                    arr.as_mut_ptr().add(start - (h - left)),
                    length,
                );
            }
            moved += length;
        }
    }
    moved
}

fn deferred<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
    budget: usize,
    stats: &mut SkewStats,
) {
    let metadata = (1usize << radix) * 2 * size_of::<usize>();
    // Reserve both minority merge storage and a second hole directory. The
    // latter is rebuilt in original-position order during each extraction.
    let capacity = budget.saturating_sub(metadata)
        / (2 * size_of::<T>() + 2 * size_of::<usize>());
    let capacity = capacity.min(arr.len());
    if capacity == 0 {
        fallback(arr, radix, block_size, stats);
        return;
    }
    let mut minor = Vec::with_capacity(capacity);
    let mut merge = Vec::with_capacity(capacity);
    let mut holes = Vec::with_capacity(capacity);
    let mut next_holes = Vec::with_capacity(capacity);
    let buffers = (minor.capacity() + merge.capacity()) * size_of::<T>()
        + (holes.capacity() + next_holes.capacity()) * size_of::<usize>();
    if buffers.checked_add(metadata).map_or(true, |n| n > budget) {
        drop((minor, merge, holes, next_holes));
        fallback(arr, radix, block_size, stats);
        return;
    }
    stats.peak_workspace_bytes = stats.peak_workspace_bytes.max(buffers);
    let mut bits = arr[0].type_size();
    let mut left = 0;
    let mut levels = 0;
    let mut exhausted = false;
    loop {
        let active = arr.len() - holes.len();
        if active <= 128 {
            break;
        }
        let (mask, shift, sigma) =
            match varied_digit(arr, &holes, bits, radix, stats) {
                Some(value) => value,
                None => {
                    exhausted = true;
                    break;
                },
            };
        let counts = histogram(arr, &holes, mask, shift, sigma, stats);
        let bytes = buffers + counts.capacity() * size_of::<usize>();
        assert!(bytes <= budget);
        stats.peak_workspace_bytes = stats.peak_workspace_bytes.max(bytes);
        let major = major_bucket(&counts);
        let extra = active - counts[major];
        if extra > capacity - minor.len() {
            if levels > 0 {
                stats.budget_flushes += 1;
            }
            break;
        }
        left += counts[..major].iter().sum::<usize>();
        let expected = minor.len() + extra;
        let mut hole_index = 0;
        next_holes.clear();
        for (position, &value) in arr.iter().enumerate() {
            if holes.get(hole_index) == Some(&position) {
                next_holes.push(position);
                hole_index += 1;
            } else if digit::<T, K>(value, mask, shift) != major {
                // Budget rejection happens before any extraction. Capacity is
                // checked before push even for an inconsistent custom key.
                assert!(minor.len() < capacity, "key changed between scans");
                minor.push(value);
                next_holes.push(position);
            }
        }
        assert_eq!(minor.len(), expected, "key changed between scans");
        std::mem::swap(&mut holes, &mut next_holes);
        stats.special_nodes += 1;
        stats.deferred_levels += 1;
        stats.minor_records += extra;
        levels += 1;
        bits = shift;
        if bits == 0 {
            exhausted = true;
            break;
        }
    }
    stats.max_deferred_levels = stats.max_deferred_levels.max(levels);
    if levels == 0 {
        drop((minor, merge, holes, next_holes));
        fallback(arr, radix, block_size, stats);
        return;
    }
    stable_merge_sort::<T, K>(&mut minor, &mut merge);
    let major_count = arr.len() - holes.len();
    stats.major_records_moved += compact_major(arr, &holes, left);
    arr[..left].copy_from_slice(&minor[..left]);
    arr[left + major_count..].copy_from_slice(&minor[left..]);
    stats.flushes += 1;
    drop((minor, merge, holes, next_holes));
    if !exhausted {
        // The rejected digit has not been consumed. Sorting the complete
        // restored major slice from its full key includes it automatically.
        fallback(&mut arr[left..left + major_count], radix, block_size, stats);
    }
}

// Stable bottom-up merge sort with explicitly owned, budgeted auxiliary space.
// Equal converted keys cannot be extracted at different chain levels: a
// separated sibling differs at that level's prefix. Appending per level thus
// preserves original identity order for all equal-key records.
fn stable_merge_sort<T: Radixable<K>, K: RadixKey>(
    values: &mut [T],
    scratch: &mut Vec<T>,
) {
    let mut width = 1;
    while width < values.len() {
        scratch.clear();
        let mut start = 0;
        while start < values.len() {
            let middle = (start + width).min(values.len());
            let end = (middle + width).min(values.len());
            let (mut a, mut b) = (start, middle);
            while a < middle && b < end {
                if values[a].into_key_type() <= values[b].into_key_type() {
                    scratch.push(values[a]);
                    a += 1;
                } else {
                    scratch.push(values[b]);
                    b += 1;
                }
            }
            scratch.extend_from_slice(&values[a..middle]);
            scratch.extend_from_slice(&values[b..end]);
            start = end;
        }
        values.copy_from_slice(scratch);
        width = width.saturating_mul(2);
    }
}

#[cfg(test)]
mod tests {
    use super::compact_major;
    #[test]
    fn every_small_hole_pattern_preserves_major_payload_and_exact_move_count() {
        for length in 1..=12 {
            for mask in 0usize..1 << length {
                let holes: Vec<_> =
                    (0..length).filter(|&i| mask & (1 << i) != 0).collect();
                let major: Vec<_> =
                    (0..length).filter(|i| !holes.contains(i)).collect();
                for left in 0..=holes.len() {
                    let mut values: Vec<_> = (0..length).collect();
                    let moved = compact_major(&mut values, &holes, left);
                    assert_eq!(&values[left..left + major.len()], major);
                    let expected = major
                        .iter()
                        .enumerate()
                        .filter(|&(j, &p)| p != left + j)
                        .count();
                    assert_eq!(moved, expected);
                }
            }
        }
    }
}

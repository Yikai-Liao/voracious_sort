//! Work-reduction experiments copied from node_local.rs at 749ca4d.
//! Controls retain the old cache admission; candidates change arrays or placement.
//! The allocator and shared-boundary scatter are inherited from endpoint_v1.
//! Related construction: Karkkainen, Sanders & Burkhardt, Linear Work Suffix
//! Array Construction, Appendix B, Theorem 5 (printed p.22):
//! https://www.cs.helsinki.fi/u/tpkarkka/publications/jacm05-revised.pdf
//! Every large node is permuted and its workspace dropped before child recursion.
use super::{work_reduction::Work, Stats};
use std::{
    marker::PhantomData,
    mem::{size_of, MaybeUninit},
    ptr,
};
use voracious_radix_sort::{RadixKey, Radixable};

pub const CACHE_BUDGET: usize = 256 * 1024;
#[derive(Clone, Copy, Debug)]
pub enum Placement {
    FreeList,
    CarriedFreeList,
    CycleFreeList,
    ScratchPathCycles,
}
#[derive(Default, Debug)]
pub struct LocalStats {
    #[cfg(feature = "cf_work")]
    pub work: Work,
    pub block_nodes: usize,
    pub cache_entries: usize,
    pub cache_radix_nodes: usize,
    pub leaf_sorts: usize,
    pub variation_records: usize,
    pub block_scatter_records: usize,
    pub cache_scatter_records: usize,
    pub permutation_writes: usize,
    pub prefix_writeback_records: usize,
    pub peak_scratch_records: usize,
    pub peak_directory_entries: usize,
    pub max_cache_records: usize,
}
const NONE: usize = usize::MAX;

struct Arena<'a, T> {
    input: *mut T,
    scratch: Vec<MaybeUninit<T>>,
    scratch_blocks: usize,
    b: usize,
    next: Vec<usize>,
    free: Vec<usize>,
    live: Vec<bool>,
    stats: Stats,
    _borrow: PhantomData<&'a mut [T]>,
}
impl<'a, T: Copy> Arena<'a, T> {
    fn block(&mut self, id: usize) -> *mut T {
        debug_assert!(id < self.next.len());
        unsafe {
            if id < self.scratch_blocks {
                self.scratch.as_mut_ptr().add(id * self.b).cast::<T>()
            } else {
                self.input.add((id - self.scratch_blocks) * self.b)
            }
        }
    }
    fn allocate(&mut self) -> usize {
        let id = self.free.pop().expect("count-first block supply exhausted");
        assert!(!self.live[id]);
        self.live[id] = true;
        self.next[id] = NONE;
        self.stats.peak_live_blocks =
            self.stats.peak_live_blocks.max(self.live.len() - self.free.len());
        id
    }
    fn release(&mut self, id: usize) {
        assert!(self.live[id]);
        self.live[id] = false;
        self.free.push(id);
    }
}

// Every remaining physical block is in this queue. No per-frame m/b ID Vec.
// Removing a prefix retains at most a partial head and original partial tail.
struct Stream {
    head: usize,
    tail: usize,
    offset: usize,
    last_length: usize,
    remaining: usize,
}
impl Stream {
    fn span<T: Copy>(&self, arena: &Arena<T>) -> (usize, usize, usize) {
        debug_assert!(self.remaining > 0);
        let end =
            if self.head == self.tail { self.last_length } else { arena.b };
        (self.head, self.offset, end - self.offset)
    }
    fn consume<T: Copy>(&mut self, arena: &mut Arena<T>, count: usize) {
        debug_assert!(
            count > 0 && count <= self.span(arena).2 && count <= self.remaining
        );
        self.offset += count;
        self.remaining -= count;
        let end =
            if self.head == self.tail { self.last_length } else { arena.b };
        if self.offset == end {
            let source = self.head;
            self.head = arena.next[source];
            self.offset = 0;
            arena.release(source);
        }
        debug_assert!(self.remaining > 0 || self.head == NONE);
    }
}

struct Chain {
    first: usize,
    last: usize,
    blocks: usize,
}
impl Chain {
    fn new() -> Self {
        Self { first: NONE, last: NONE, blocks: 0 }
    }
    fn append<T: Copy>(&mut self, arena: &mut Arena<T>, id: usize) {
        // Adjacent buckets can share this same logical boundary block.
        if self.last == id {
            return;
        }
        if self.last == NONE {
            self.first = id;
        } else {
            arena.next[self.last] = id;
        }
        self.last = id;
        arena.next[id] = NONE;
        self.blocks += 1;
    }
    fn join<T: Copy>(&mut self, arena: &mut Arena<T>, other: Chain) {
        if other.first == NONE {
            return;
        }
        if self.last == NONE {
            self.first = other.first;
        } else {
            arena.next[self.last] = other.first;
        }
        self.last = other.last;
        self.blocks += other.blocks;
        arena.next[self.last] = NONE;
    }
}
struct Cursor<T> {
    next: *mut T,
    end: *mut T,
}
struct Bucket {
    prefix: usize,
    suffix: usize,
    full_pending: usize,
    suffix_pending: usize,
    interior: Chain,
}

pub fn block_msd_stable_radixsort<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
) -> LocalStats {
    sort_with_budget(arr, radix, block_size, CACHE_BUDGET)
}

pub fn sort_with_budget<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
    cache_budget: usize,
) -> LocalStats {
    sort_with_placement(
        arr,
        radix,
        block_size,
        cache_budget,
        Placement::FreeList,
    )
}

pub fn sort_with_placement<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
    cache_budget: usize,
    placement: Placement,
) -> LocalStats {
    sort_reduced(arr, radix, block_size, cache_budget, placement, false)
}

pub fn sort_reduced<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
    cache_budget: usize,
    placement: Placement,
    two_arrays: bool,
) -> LocalStats {
    assert!((1..=8).contains(&radix));
    assert!(block_size > 0);
    let mut stats = LocalStats::default();
    if arr.len() < 2 || size_of::<T>() == 0 {
        return stats;
    }
    if arr.len() <= 128 {
        #[cfg(feature = "cf_work")]
        {
            stats.work.leaf_records += arr.len();
            stats.work.leaf_lengths[arr.len()] += 1;
        }
        #[cfg(feature = "cf_work")]
        let leaf_start = std::time::Instant::now();
        arr.sort_by_key(|v| v.into_key_type());
        #[cfg(feature = "cf_work")]
        {
            stats.work.leaf_ns += leaf_start.elapsed().as_nanos();
        }

        stats.leaf_sorts += 1;
        return stats;
    }
    #[cfg(feature = "cf_work")]
    let ordered_start = std::time::Instant::now();
    let is_ordered = ordered::<T, K>(
        arr,
        #[cfg(feature = "cf_work")]
        &mut stats.work,
    );
    #[cfg(feature = "cf_work")]
    {
        stats.work.ordered_ns += ordered_start.elapsed().as_nanos();
    }
    if is_ordered {
        return stats;
    }
    let bits = arr[0].type_size();
    recurse(
        arr,
        bits,
        radix,
        block_size,
        cache_budget,
        placement,
        two_arrays,
        &mut stats,
    );
    stats
}

pub(crate) fn cache_fits<T>(
    length: usize,
    bits: usize,
    radix: usize,
    budget: usize,
) -> bool {
    let depth = (bits + radix - 1) / radix;
    // Both input and auxiliary records, three count/cursor arrays per level,
    // and a conservative allowance for the bounded stable-sort leaf workspace.
    let records = length
        .checked_mul(2)
        .and_then(|n| n.checked_add(128))
        .and_then(|n| n.checked_mul(size_of::<T>()));
    let metadata = (1usize << radix)
        .checked_mul(3 * size_of::<usize>())
        .and_then(|n| n.checked_mul(depth));
    records
        .zip(metadata)
        .and_then(|(records, metadata)| records.checked_add(metadata))
        .and_then(|bytes| bytes.checked_add(8192))
        .map_or(false, |bytes| bytes <= budget)
}

fn recurse<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    mut bits: usize,
    radix: usize,
    block_size: usize,
    cache_budget: usize,
    placement: Placement,
    two_arrays: bool,
    stats: &mut LocalStats,
) {
    if arr.len() < 2 || bits == 0 {
        return;
    }
    if arr.len() <= 128 {
        #[cfg(feature = "cf_work")]
        {
            stats.work.leaf_records += arr.len();
            stats.work.leaf_lengths[arr.len()] += 1;
        }
        #[cfg(feature = "cf_work")]
        let leaf_start = std::time::Instant::now();
        arr.sort_by_key(|v| v.into_key_type());
        #[cfg(feature = "cf_work")]
        {
            stats.work.leaf_ns += leaf_start.elapsed().as_nanos();
        }

        stats.leaf_sorts += 1;
        return;
    }
    let dummy = arr[0];
    #[cfg(feature = "cf_work")]
    let variation_start = std::time::Instant::now();
    let mut union = dummy.default_key();
    let mut intersection = arr[0].into_key_type();
    for value in arr.iter() {
        let key = value.into_key_type();
        union |= key;
        intersection = intersection & key;
    }
    stats.variation_records += arr.len();
    #[cfg(feature = "cf_work")]
    {
        stats.work.variation_records += arr.len();
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
        stats.work.variation_ns += variation_start.elapsed().as_nanos();
    }
    if bits == 0 {
        return;
    }
    if cache_fits::<T>(arr.len(), bits, radix, cache_budget) {
        stats.cache_entries += 1;
        stats.max_cache_records = stats.max_cache_records.max(arr.len());
        let mut scratch = vec![MaybeUninit::<T>::uninit(); arr.len()];
        if two_arrays {
            cached_two_arrays(arr, &mut scratch, bits, radix, stats, 0);
        } else {
            cached_msd(arr, &mut scratch, bits, radix, stats, 0);
        }
        return;
    }
    let width = radix.min(bits);
    let shift = bits - width;
    let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
    #[cfg(feature = "cf_work")]
    {
        stats.work.histogram_records += arr.len();
        stats.work.histogram_slots += 1usize << width;
        stats.work.metadata_allocations += 1;
        stats.work.metadata_bytes += (1usize << width) * size_of::<usize>();
    }
    #[cfg(feature = "cf_work")]
    let histogram_start = std::time::Instant::now();
    let mut counts = vec![0usize; 1usize << width];
    for value in arr.iter() {
        counts[value.extract(mask, shift)] += 1;
    }
    #[cfg(feature = "cf_work")]
    {
        stats.work.histogram_ns += histogram_start.elapsed().as_nanos();
    }
    // partition finishes the permutation and destroys every block workspace.
    // Only this O(sigma) histogram survives while a child is being sorted.
    match placement {
        Placement::FreeList => {
            partition(arr, &counts, mask, shift, block_size, stats)
        },
        Placement::CarriedFreeList => {
            partition_carried(arr, &counts, mask, shift, block_size, stats)
        },
        Placement::CycleFreeList => partition_impl(
            arr, &counts, mask, shift, block_size, stats, false, 1,
        ),
        Placement::ScratchPathCycles => partition_impl(
            arr, &counts, mask, shift, block_size, stats, false, 2,
        ),
    }
    let mut rest = arr;
    for count in counts {
        let (child, suffix) = rest.split_at_mut(count);
        rest = suffix;
        if count > 1 {
            recurse(
                child,
                shift,
                radix,
                block_size,
                cache_budget,
                placement,
                two_arrays,
                stats,
            );
        }
    }
}

pub(crate) fn partition<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    counts: &[usize],
    mask: <<T as Radixable<K>>::Key as RadixKey>::Key,
    shift: usize,
    block_size: usize,
    stats: &mut LocalStats,
) {
    partition_impl(arr, counts, mask, shift, block_size, stats, false, 0);
}

pub(crate) fn partition_carried<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    counts: &[usize],
    mask: <<T as Radixable<K>>::Key as RadixKey>::Key,
    shift: usize,
    block_size: usize,
    stats: &mut LocalStats,
) {
    partition_impl(arr, counts, mask, shift, block_size, stats, true, 0);
}

fn partition_impl<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    counts: &[usize],
    mask: <<T as Radixable<K>>::Key as RadixKey>::Key,
    shift: usize,
    block_size: usize,
    stats: &mut LocalStats,
    carry_boundary: bool,
    cycle_mode: u8,
) {
    let length = arr.len();
    let size = length;
    let sigma = counts.len();
    let full = length / block_size;
    let tail = length % block_size;
    // Boundary blocks + at most one partial private interior head per bucket.
    // They are also distinct output blocks, so their sum is <= ceil(n/b).
    let rounded = full + usize::from(tail != 0);
    let active = (2 * sigma).min(rounded);
    let scratch_blocks = active.checked_add(8).unwrap();
    let total = full.checked_add(scratch_blocks).unwrap();
    let scratch_elements = scratch_blocks.checked_mul(block_size).unwrap();
    let mut arena = Arena {
        input: arr.as_mut_ptr(),
        scratch: vec![MaybeUninit::uninit(); scratch_elements],
        scratch_blocks,
        b: block_size,
        next: vec![NONE; total],
        free: (0..scratch_blocks).collect(),
        live: vec![false; total],
        stats: Stats { scratch_elements, ..Stats::default() },
        _borrow: PhantomData,
    };
    for id in scratch_blocks..total {
        arena.live[id] = true;
        if id + 1 < total {
            arena.next[id] = id + 1;
        }
    }
    let mut tail_id = if full > 0 { total - 1 } else { NONE };
    let mut head = if full > 0 { scratch_blocks } else { NONE };
    if tail > 0 {
        #[cfg(feature = "cf_work")]
        {
            stats.work.tail_save_records += tail;
        }
        let id = arena.allocate();
        unsafe {
            ptr::copy_nonoverlapping(
                arr.as_ptr().add(full * block_size),
                arena.block(id),
                tail,
            )
        };
        if tail_id != NONE {
            arena.next[tail_id] = id;
        } else {
            head = id;
        }
        tail_id = id;
    }
    let mut input = Stream {
        head,
        tail: tail_id,
        offset: 0,
        last_length: if tail > 0 { tail } else { block_size },
        remaining: length,
    };
    #[cfg(feature = "cf_work")]
    let setup_start = std::time::Instant::now();
    let (mut buckets, mut cursors, boundaries) = if carry_boundary {
        let (buckets, cursors) = setup_carried(&mut arena, counts, size);
        (buckets, cursors, Vec::new())
    } else {
        setup_boundaries(&mut arena, counts, size)
    };
    #[cfg(feature = "cf_work")]
    {
        stats.work.setup_ns += setup_start.elapsed().as_nanos();
    }
    #[cfg(feature = "cf_work")]
    let scatter_start = std::time::Instant::now();
    let mut remaining = size;
    while remaining > 0 {
        let (id, offset, available) = input.span(&arena);
        let take = remaining.min(available);
        let source = unsafe { arena.block(id).add(offset) };
        for i in 0..take {
            let source = unsafe { source.add(i) };
            let digit = unsafe { (*source).extract(mask, shift) };
            let cursor = &mut cursors[digit];
            if cursor.next == cursor.end {
                let bucket = &mut buckets[digit];
                let (physical, length) = if bucket.full_pending > 0 {
                    bucket.full_pending -= 1;
                    let physical = arena.allocate();
                    bucket.interior.append(&mut arena, physical);
                    (physical, arena.b)
                } else if bucket.suffix_pending > 0 {
                    let length = bucket.suffix_pending;
                    bucket.suffix_pending = 0;
                    (bucket.suffix, length)
                } else {
                    panic!("extract changed bucket counts");
                };
                cursor.next = arena.block(physical);
                cursor.end = unsafe { cursor.next.add(length) };
            }
            unsafe {
                ptr::copy_nonoverlapping(source, cursor.next, 1);
                cursor.next = cursor.next.add(1);
            }
        }
        input.consume(&mut arena, take);
        remaining -= take;
    }
    for (cursor, bucket) in cursors.iter().zip(&buckets) {
        assert_eq!(cursor.next, cursor.end, "extract changed bucket counts");
        assert_eq!(bucket.full_pending, 0, "extract changed bucket counts");
        assert_eq!(bucket.suffix_pending, 0, "extract changed bucket counts");
    }
    #[cfg(feature = "cf_work")]
    {
        stats.work.scatter_ns += scatter_start.elapsed().as_nanos();
    }
    drop(cursors);
    let mut chain = Chain::new();
    for bucket in buckets {
        if bucket.prefix != NONE {
            chain.append(&mut arena, bucket.prefix);
        }
        chain.join(&mut arena, bucket.interior);
        if bucket.suffix != NONE {
            chain.append(&mut arena, bucket.suffix);
        }
    }
    assert_eq!(
        chain.blocks,
        size / arena.b + usize::from(size % arena.b != 0),
        "dense output directory"
    );
    drop(boundaries);
    let mut blocks = Vec::with_capacity(rounded);
    let mut id = chain.first;
    while id != NONE {
        blocks.push(id);
        id = arena.next[id];
    }
    assert_eq!(blocks.len(), rounded);
    stats.block_nodes += 1;
    stats.block_scatter_records += length;
    #[cfg(feature = "cf_work")]
    {
        stats.work.scatter_records += length;
    }
    stats.peak_scratch_records =
        stats.peak_scratch_records.max(scratch_elements);
    stats.peak_directory_entries = stats.peak_directory_entries.max(total);
    #[cfg(feature = "cf_work")]
    let placement_start = std::time::Instant::now();
    if cycle_mode != 0 {
        finalize_cycles(&mut arena, blocks, length, stats, cycle_mode == 2);
    } else {
        finalize(&mut arena, blocks, length, stats);
    }
    #[cfg(feature = "cf_work")]
    {
        stats.work.placement_ns += placement_start.elapsed().as_nanos();
    }
    // `arena` and all its directories are dropped here, before recursion.
}

// Retaining this directory until assembly preserves the original partition's
// allocation lifetime. Only the carried setup below avoids the allocation.
fn setup_boundaries<T: Copy>(
    arena: &mut Arena<T>,
    counts: &[usize],
    size: usize,
) -> (Vec<Bucket>, Vec<Cursor<T>>, Vec<(usize, usize)>) {
    let mut boundaries = Vec::<(usize, usize)>::new();
    let mut end = 0;
    for &count in counts.iter() {
        end += count;
        if end % arena.b != 0 {
            let index = end / arena.b;
            if boundaries
                .last()
                .map_or(true, |&(previous, _)| previous != index)
            {
                boundaries.push((index, arena.allocate()));
            }
        }
    }
    debug_assert!(boundaries.len() <= counts.len());
    assert_eq!(end, size);
    let boundary = |index: usize| -> usize {
        boundaries[boundaries
            .binary_search_by_key(&index, |&(i, _)| i)
            .expect("missing shared boundary")]
        .1
    };
    let mut buckets = Vec::with_capacity(counts.len());
    let mut cursors: Vec<Cursor<T>> = Vec::with_capacity(counts.len());
    let mut start = 0;
    for &count in counts.iter() {
        let end = start + count;
        let prefix = if count > 0 && start % arena.b != 0 {
            boundary(start / arena.b)
        } else {
            NONE
        };
        let suffix = if count > 0 && end % arena.b != 0 {
            boundary(end / arena.b)
        } else {
            NONE
        };
        let offset = start % arena.b;
        let (next, cursor_end) = if prefix == NONE {
            (ptr::null_mut(), ptr::null_mut())
        } else {
            let base = arena.block(prefix);
            let take = count.min(arena.b - offset);
            unsafe { (base.add(offset), base.add(offset + take)) }
        };
        cursors.push(Cursor { next, end: cursor_end });
        buckets.push(Bucket {
            prefix,
            suffix,
            full_pending: (end / arena.b)
                .saturating_sub(start / arena.b + usize::from(offset != 0)),
            suffix_pending: if suffix != prefix { end % arena.b } else { 0 },
            interior: Chain::new(),
        });
        start = end;
    }
    (buckets, cursors, boundaries)
}

// Bucket intervals arrive in logical order. A partial end is exactly the next
// nonempty bucket's partial start, so one carried ID replaces the boundary map.
fn setup_carried<T: Copy>(
    arena: &mut Arena<T>,
    counts: &[usize],
    size: usize,
) -> (Vec<Bucket>, Vec<Cursor<T>>) {
    let mut buckets = Vec::with_capacity(counts.len());
    let mut cursors = Vec::with_capacity(counts.len());
    let mut start = 0;
    let mut shared_tail = NONE;
    for &count in counts {
        let end = start + count;
        let offset = start % arena.b;
        let prefix = if count > 0 && offset != 0 { shared_tail } else { NONE };
        debug_assert!(count == 0 || offset == 0 || prefix != NONE);
        let suffix = if count == 0 || end % arena.b == 0 {
            NONE
        } else if start / arena.b == end / arena.b && prefix != NONE {
            prefix
        } else {
            arena.allocate()
        };
        // Empty buckets carry no segments and must preserve the shared ID.
        if count != 0 {
            shared_tail = suffix;
        }
        let (next, cursor_end) = if prefix == NONE {
            (ptr::null_mut(), ptr::null_mut())
        } else {
            let base = arena.block(prefix);
            let take = count.min(arena.b - offset);
            unsafe { (base.add(offset), base.add(offset + take)) }
        };
        cursors.push(Cursor { next, end: cursor_end });
        buckets.push(Bucket {
            prefix,
            suffix,
            full_pending: (end / arena.b)
                .saturating_sub(start / arena.b + usize::from(offset != 0)),
            suffix_pending: if suffix != prefix { end % arena.b } else { 0 },
            interior: Chain::new(),
        });
        start = end;
    }
    assert_eq!(start, size);
    (buckets, cursors)
}

pub(crate) fn cached_msd<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    scratch: &mut [MaybeUninit<T>],
    mut bits: usize,
    radix: usize,
    stats: &mut LocalStats,
    depth: usize,
) {
    if arr.len() < 2 || bits == 0 {
        return;
    }
    if arr.len() <= 128 {
        #[cfg(feature = "cf_work")]
        {
            stats.work.leaf_records += arr.len();
            stats.work.leaf_lengths[arr.len()] += 1;
        }
        #[cfg(feature = "cf_work")]
        let leaf_start = std::time::Instant::now();
        arr.sort_by_key(|v| v.into_key_type());
        #[cfg(feature = "cf_work")]
        {
            stats.work.leaf_ns += leaf_start.elapsed().as_nanos();
        }

        stats.leaf_sorts += 1;
        return;
    }
    let dummy = arr[0];
    loop {
        let width = radix.min(bits);
        let shift = bits - width;
        let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
        #[cfg(feature = "cf_work")]
        {
            stats.work.histogram_records += arr.len();
            stats.work.histogram_slots += 1usize << width;
            stats.work.metadata_allocations += 1;
            stats.work.metadata_bytes += (1usize << width) * size_of::<usize>();
        }
        #[cfg(feature = "cf_work")]
        let histogram_start = std::time::Instant::now();
        let mut counts = vec![0usize; 1usize << width];
        for value in arr.iter() {
            counts[value.extract(mask, shift)] += 1;
        }
        #[cfg(feature = "cf_work")]
        {
            stats.work.histogram_ns += histogram_start.elapsed().as_nanos();
        }
        if counts.iter().any(|&n| n == arr.len()) {
            bits = shift;
            if bits == 0 {
                return;
            }
            continue;
        }
        #[cfg(feature = "cf_work")]
        let setup_start = std::time::Instant::now();
        let mut end = 0;
        #[cfg(feature = "cf_work")]
        {
            stats.work.metadata_allocations += 2;
            stats.work.metadata_bytes += 2 * counts.len() * size_of::<usize>();
        }
        let mut heads = Vec::with_capacity(counts.len());
        let mut ends = Vec::with_capacity(counts.len());
        for &count in counts.iter() {
            heads.push(end);
            end += count;
            ends.push(end);
        }
        #[cfg(feature = "cf_work")]
        {
            stats.work.setup_ns += setup_start.elapsed().as_nanos();
        }
        #[cfg(feature = "cf_work")]
        let scatter_start = std::time::Instant::now();
        for value in arr.iter() {
            let digit = value.extract(mask, shift);
            let position = heads[digit];
            assert!(position < ends[digit], "extract changed bucket counts");
            unsafe {
                ptr::copy_nonoverlapping(
                    value,
                    scratch.as_mut_ptr().add(position).cast::<T>(),
                    1,
                );
            }
            heads[digit] += 1;
        }
        assert_eq!(heads, ends, "extract changed bucket counts");
        #[cfg(feature = "cf_work")]
        {
            stats.work.scatter_ns += scatter_start.elapsed().as_nanos();
        }
        #[cfg(feature = "cf_work")]
        let copyback_start = std::time::Instant::now();
        unsafe {
            ptr::copy_nonoverlapping(
                scratch.as_ptr().cast::<T>(),
                arr.as_mut_ptr(),
                arr.len(),
            );
        }
        #[cfg(feature = "cf_work")]
        {
            stats.work.scatter_records += arr.len();
            stats.work.copyback_records += arr.len();
            stats.work.cached_depth_records[depth.min(16)] += arr.len();
        }
        #[cfg(feature = "cf_work")]
        {
            stats.work.copyback_ns += copyback_start.elapsed().as_nanos();
        }
        stats.cache_radix_nodes += 1;
        stats.cache_scatter_records += arr.len();
        drop(heads);
        drop(ends);
        if shift > 0 {
            let mut rest = arr;
            for count in counts {
                let (child, suffix) = rest.split_at_mut(count);
                rest = suffix;
                if count > 1 {
                    cached_msd(child, scratch, shift, radix, stats, depth + 1);
                }
            }
        }
        return;
    }
}

pub(crate) fn cached_two_arrays<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    scratch: &mut [MaybeUninit<T>],
    mut bits: usize,
    radix: usize,
    stats: &mut LocalStats,
    depth: usize,
) {
    if arr.len() < 2 || bits == 0 {
        return;
    }
    if arr.len() <= 128 {
        #[cfg(feature = "cf_work")]
        {
            stats.work.leaf_records += arr.len();
            stats.work.leaf_lengths[arr.len()] += 1;
        }
        #[cfg(feature = "cf_work")]
        let leaf_start = std::time::Instant::now();
        arr.sort_by_key(|v| v.into_key_type());
        #[cfg(feature = "cf_work")]
        {
            stats.work.leaf_ns += leaf_start.elapsed().as_nanos();
        }

        stats.leaf_sorts += 1;
        return;
    }
    let dummy = arr[0];
    loop {
        let width = radix.min(bits);
        let shift = bits - width;
        let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
        #[cfg(feature = "cf_work")]
        {
            stats.work.histogram_records += arr.len();
            stats.work.histogram_slots += 1usize << width;
            stats.work.metadata_allocations += 1;
            stats.work.metadata_bytes += (1usize << width) * size_of::<usize>();
        }
        #[cfg(feature = "cf_work")]
        let histogram_start = std::time::Instant::now();
        let mut counts = vec![0usize; 1usize << width];
        for value in arr.iter() {
            counts[value.extract(mask, shift)] += 1;
        }
        #[cfg(feature = "cf_work")]
        {
            stats.work.histogram_ns += histogram_start.elapsed().as_nanos();
        }
        if counts.iter().any(|&n| n == arr.len()) {
            bits = shift;
            if bits == 0 {
                return;
            }
            continue;
        }
        #[cfg(feature = "cf_work")]
        let setup_start = std::time::Instant::now();
        let mut end = 0;
        #[cfg(feature = "cf_work")]
        {
            stats.work.metadata_allocations += 1;
            stats.work.metadata_bytes += 1 * counts.len() * size_of::<usize>();
        }
        let mut heads = Vec::with_capacity(counts.len());
        for count in &mut counts {
            heads.push(end);
            end += *count;
            *count = end;
        }
        #[cfg(feature = "cf_work")]
        {
            stats.work.setup_ns += setup_start.elapsed().as_nanos();
        }
        #[cfg(feature = "cf_work")]
        let scatter_start = std::time::Instant::now();
        for value in arr.iter() {
            let digit = value.extract(mask, shift);
            let position = heads[digit];
            assert!(position < counts[digit], "extract changed bucket counts");
            unsafe {
                ptr::copy_nonoverlapping(
                    value,
                    scratch.as_mut_ptr().add(position).cast::<T>(),
                    1,
                );
            }
            heads[digit] += 1;
        }
        assert_eq!(heads, counts, "extract changed bucket counts");
        #[cfg(feature = "cf_work")]
        {
            stats.work.scatter_ns += scatter_start.elapsed().as_nanos();
        }
        #[cfg(feature = "cf_work")]
        let copyback_start = std::time::Instant::now();
        unsafe {
            ptr::copy_nonoverlapping(
                scratch.as_ptr().cast::<T>(),
                arr.as_mut_ptr(),
                arr.len(),
            );
        }
        #[cfg(feature = "cf_work")]
        {
            stats.work.scatter_records += arr.len();
            stats.work.copyback_records += arr.len();
            stats.work.cached_depth_records[depth.min(16)] += arr.len();
        }
        #[cfg(feature = "cf_work")]
        {
            stats.work.copyback_ns += copyback_start.elapsed().as_nanos();
        }
        stats.cache_radix_nodes += 1;
        stats.cache_scatter_records += arr.len();
        drop(heads);
        if shift > 0 {
            let mut rest = arr;
            let mut start = 0;
            for end in counts {
                let count = end - start;
                start = end;
                let (child, suffix) = rest.split_at_mut(count);
                rest = suffix;
                if count > 1 {
                    cached_two_arrays(
                        child,
                        scratch,
                        shift,
                        radix,
                        stats,
                        depth + 1,
                    );
                }
            }
        }
        return;
    }
}

pub(crate) fn ordered<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    #[cfg(feature = "cf_work")] work: &mut Work,
) -> bool {
    #[cfg(feature = "cf_work")]
    {
        work.ordered_records += 1;
    }
    let first = arr[0].into_key_type();
    let mut different = 1;
    while different < arr.len() && {
        #[cfg(feature = "cf_work")]
        {
            work.ordered_records += 1;
        }
        arr[different].into_key_type() == first
    } {
        different += 1;
    }
    if different == arr.len() {
        return true;
    }
    #[cfg(feature = "cf_work")]
    {
        work.ordered_records += 2;
    }
    let ascending = first < arr[different].into_key_type();
    let mut previous = arr[different].into_key_type();
    let mut equal = different > 1;
    for value in &arr[different + 1..] {
        #[cfg(feature = "cf_work")]
        {
            work.ordered_records += 1;
        }
        let key = value.into_key_type();
        if ascending {
            if previous > key {
                return false;
            }
        } else {
            if previous < key {
                return false;
            }
            equal |= previous == key;
        }
        previous = key;
    }
    if !ascending {
        #[cfg(feature = "cf_work")]
        {
            work.ordered_writes += 2 * (arr.len() / 2);
        }
        arr.reverse();
        if equal {
            let mut start = 0;
            #[cfg(feature = "cf_work")]
            {
                work.ordered_records += 1;
            }
            let mut previous = arr[0].into_key_type();
            for i in 1..arr.len() {
                #[cfg(feature = "cf_work")]
                {
                    work.ordered_records += 1;
                }
                let key = arr[i].into_key_type();
                if key != previous {
                    if i - start > 1 {
                        #[cfg(feature = "cf_work")]
                        {
                            work.ordered_writes += 2 * ((i - start) / 2);
                        }
                        arr[start..i].reverse();
                    }
                    start = i;
                }
                previous = key;
            }
            if arr.len() - start > 1 {
                #[cfg(feature = "cf_work")]
                {
                    work.ordered_writes += 2 * ((arr.len() - start) / 2);
                }
                arr[start..].reverse();
            }
        }
    }
    true
}

fn finalize<T: Copy>(
    arena: &mut Arena<T>,
    mut blocks: Vec<usize>,
    length: usize,
    stats: &mut LocalStats,
) {
    let full = length / arena.b;
    let mut inverse = vec![NONE; arena.next.len()];
    for (i, &id) in blocks.iter().enumerate() {
        inverse[id] = i;
    }
    for i in 0..full {
        let source = blocks[i];
        let destination = arena.scratch_blocks + i;
        if source == destination {
            continue;
        }
        let other = inverse[destination];
        unsafe {
            if other != NONE && other > i {
                stats.permutation_writes += 2 * arena.b;
                for j in 0..arena.b {
                    ptr::swap(
                        arena
                            .block(destination)
                            .add(j)
                            .cast::<MaybeUninit<T>>(),
                        arena.block(source).add(j).cast::<MaybeUninit<T>>(),
                    );
                }
                blocks[other] = source;
                inverse[source] = other;
            } else {
                stats.permutation_writes += arena.b;
                ptr::copy_nonoverlapping(
                    arena.block(source),
                    arena.block(destination),
                    arena.b,
                );
                inverse[source] = NONE;
            }
        }
        blocks[i] = destination;
        inverse[destination] = i;
    }
    if length % arena.b != 0 {
        stats.permutation_writes += length % arena.b;
        unsafe {
            ptr::copy(
                arena.block(blocks[full]),
                arena.input.add(full * arena.b),
                length % arena.b,
            );
        }
    }
}

// The dense assembly is an injective source-to-target block mapping. Save the
// partial tail first, drain paths into empty targets, then rotate closed cycles.
fn finalize_cycles<T: Copy>(
    arena: &mut Arena<T>,
    mut blocks: Vec<usize>,
    length: usize,
    stats: &mut LocalStats,
    scratch_paths: bool,
) {
    let full = length / arena.b;
    let tail = length % arena.b;
    let mut inverse = vec![NONE; arena.next.len()];
    for (logical, &physical) in blocks.iter().enumerate() {
        assert!(
            physical < inverse.len() && inverse[physical] == NONE,
            "duplicate physical output block"
        );
        inverse[physical] = logical;
    }
    if tail != 0 {
        let source = blocks[full];
        unsafe {
            ptr::copy_nonoverlapping(
                arena.block(source),
                arena.input.add(full * arena.b),
                tail,
            );
        }
        stats.permutation_writes += tail;
        inverse[source] = NONE;
    }
    // Every non-cycle path has a unique source outside the input target set.
    // Starting there avoids probing every target in nearly fixed partitions.
    if scratch_paths {
        for source in 0..arena.scratch_blocks {
            if inverse[source] == NONE {
                continue;
            }
            let mut next = source;
            let hole = loop {
                let logical = inverse[next];
                assert!(logical < full);
                let target = arena.scratch_blocks + logical;
                if inverse[target] == NONE {
                    break target;
                }
                next = target;
            };
            drain_path(arena, &mut blocks, &mut inverse, hole, stats);
        }
    } else {
        for target in 0..full {
            let hole = arena.scratch_blocks + target;
            if inverse[hole] == NONE {
                drain_path(arena, &mut blocks, &mut inverse, hole, stats);
            }
        }
    }
    // No live full scratch source remains after paths; scratch block zero is
    // available as a temporary without another payload allocation.
    assert!(inverse[..arena.scratch_blocks].iter().all(|&x| x == NONE));
    for target in 0..full {
        let destination = arena.scratch_blocks + target;
        let source = blocks[target];
        if source == destination {
            continue;
        }
        let owner = inverse[destination];
        assert!(owner < full);
        if source == arena.scratch_blocks + owner {
            // A two-cycle costs exactly two block writes with a swap.
            unsafe {
                for offset in 0..arena.b {
                    ptr::swap(
                        arena.block(source).add(offset),
                        arena.block(destination).add(offset),
                    );
                }
            }
            stats.permutation_writes += 2 * arena.b;
            blocks[owner] = source;
            inverse[source] = owner;
            blocks[target] = destination;
            inverse[destination] = target;
            continue;
        }
        unsafe {
            ptr::copy_nonoverlapping(
                arena.block(destination),
                arena.block(0),
                arena.b,
            );
        }
        stats.permutation_writes += arena.b;
        let mut hole = destination;
        loop {
            let logical = hole - arena.scratch_blocks;
            let source = blocks[logical];
            let from = if source == destination { 0 } else { source };
            unsafe {
                ptr::copy_nonoverlapping(
                    arena.block(from),
                    arena.block(hole),
                    arena.b,
                );
            }
            stats.permutation_writes += arena.b;
            blocks[logical] = hole;
            inverse[hole] = logical;
            if source == destination {
                break;
            }
            hole = source;
        }
    }
}

fn drain_path<T: Copy>(
    arena: &mut Arena<T>,
    blocks: &mut [usize],
    inverse: &mut [usize],
    mut hole: usize,
    stats: &mut LocalStats,
) {
    loop {
        let logical = hole - arena.scratch_blocks;
        let source = blocks[logical];
        if source == hole {
            break;
        }
        unsafe {
            ptr::copy_nonoverlapping(
                arena.block(source),
                arena.block(hole),
                arena.b,
            );
        }
        stats.permutation_writes += arena.b;
        blocks[logical] = hole;
        inverse[hole] = logical;
        inverse[source] = NONE;
        if source < arena.scratch_blocks {
            break;
        }
        hole = source;
    }
}

#[cfg(test)]
mod reduction_tests {
    use super::*;
    fn mapped_case(
        full: usize,
        scratch: usize,
        tail: usize,
        map: &[usize],
        cycles: bool,
        scratch_paths: bool,
    ) -> (Vec<u64>, usize) {
        let b = 4;
        let mut input = vec![999u64; full * b + tail];
        let total = full + scratch;
        let mut arena = Arena {
            input: input.as_mut_ptr(),
            scratch: vec![MaybeUninit::uninit(); scratch * b],
            scratch_blocks: scratch,
            b,
            next: vec![NONE; total],
            free: Vec::new(),
            live: vec![false; total],
            stats: Stats::default(),
            _borrow: PhantomData,
        };
        for (logical, &physical) in map.iter().enumerate() {
            let len = if logical == full { tail } else { b };
            for offset in 0..len {
                unsafe {
                    arena
                        .block(physical)
                        .add(offset)
                        .write((logical * b + offset) as u64);
                }
            }
        }
        let mut stats = LocalStats::default();
        if cycles {
            finalize_cycles(
                &mut arena,
                map.to_vec(),
                full * b + tail,
                &mut stats,
                scratch_paths,
            );
        } else {
            finalize(&mut arena, map.to_vec(), full * b + tail, &mut stats);
        }
        drop(arena);
        (input, stats.permutation_writes)
    }
    fn enumerate(
        full: usize,
        scratch: usize,
        tail: usize,
        map: &mut Vec<usize>,
        cases: &mut usize,
    ) {
        if map.len() == full + usize::from(tail != 0) {
            let (old, old_writes) =
                mapped_case(full, scratch, tail, map, false, false);
            let (new, new_writes) =
                mapped_case(full, scratch, tail, map, true, false);
            let (optimized, optimized_writes) =
                mapped_case(full, scratch, tail, map, true, true);
            assert_eq!(optimized, new);
            assert_eq!(optimized_writes, new_writes);
            let expected: Vec<_> =
                (0..full * 4 + tail).map(|x| x as u64).collect();
            assert_eq!(
                new, expected,
                "full={} scratch={} tail={} map={:?}",
                full, scratch, tail, map
            );
            assert_eq!(new, old);
            assert!(
                new_writes <= old_writes,
                "{} > {} map={:?}",
                new_writes,
                old_writes,
                map
            );
            *cases += 1;
            return;
        }
        for physical in 0..full + scratch {
            if !map.contains(&physical) {
                map.push(physical);
                enumerate(full, scratch, tail, map, cases);
                map.pop();
            }
        }
    }
    #[test]
    fn all_small_injections_preserve_identity_and_never_add_writes() {
        let mut cases = 0;
        for full in 0..=5 {
            for scratch in 1..=2 {
                for tail in [0, 1, 3] {
                    enumerate(full, scratch, tail, &mut Vec::new(), &mut cases);
                }
            }
        }
        println!("checked {} concrete Rust injection mappings", cases);
        assert_eq!(cases, 17399);
    }
    #[test]
    fn cycle_write_formula_and_mixed_components() {
        for k in 2..=9 {
            let map: Vec<_> = (0..k).map(|i| 1 + (i + 1) % k).collect();
            let (_, writes) = mapped_case(k, 1, 0, &map, true, false);
            assert_eq!(writes, if k == 2 { 8 } else { (k + 1) * 4 });
        }
        for tail in [0, 1, 3] {
            let mut map = vec![2, 3, 1, 5, 0, 6];
            if tail != 0 {
                map.push(7);
            }
            let (new, w) = mapped_case(6, 2, tail, &map, true, false);
            let (old, ow) = mapped_case(6, 2, tail, &map, false, false);
            assert_eq!(new, old);
            assert!(w <= ow);
        }
    }
}

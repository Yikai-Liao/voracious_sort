//! Node-local block partition followed by bounded contiguous stable MSD.
//! The allocator and shared-boundary scatter are inherited from endpoint_v1.
//! Related construction: Karkkainen, Sanders & Burkhardt, Linear Work Suffix
//! Array Construction, Appendix B, Theorem 5 (printed p.22):
//! https://www.cs.helsinki.fi/u/tpkarkka/publications/jacm05-revised.pdf
//! Every large node is permuted and its workspace dropped before child recursion.
use super::Stats;
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
    PrefixWriteback,
}
#[derive(Default, Debug)]
pub struct LocalStats {
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
    assert!((1..=8).contains(&radix));
    assert!(block_size > 0);
    let mut stats = LocalStats::default();
    if arr.len() < 2 || size_of::<T>() == 0 {
        return stats;
    }
    if arr.len() <= 128 {
        arr.sort_by_key(|v| v.into_key_type());
        stats.leaf_sorts += 1;
        return stats;
    }
    if ordered::<T, K>(arr) {
        return stats;
    }
    let bits = arr[0].type_size();
    recurse(arr, bits, radix, block_size, cache_budget, placement, &mut stats);
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
    stats: &mut LocalStats,
) {
    if arr.len() < 2 || bits == 0 {
        return;
    }
    if arr.len() <= 128 {
        arr.sort_by_key(|v| v.into_key_type());
        stats.leaf_sorts += 1;
        return;
    }
    let dummy = arr[0];
    let mut union = dummy.default_key();
    let mut intersection = arr[0].into_key_type();
    for value in arr.iter() {
        let key = value.into_key_type();
        union |= key;
        intersection = intersection & key;
    }
    stats.variation_records += arr.len();
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
    if cache_fits::<T>(arr.len(), bits, radix, cache_budget) {
        stats.cache_entries += 1;
        stats.max_cache_records = stats.max_cache_records.max(arr.len());
        let mut scratch = vec![MaybeUninit::<T>::uninit(); arr.len()];
        cached_msd(arr, &mut scratch, bits, radix, stats);
        return;
    }
    let width = radix.min(bits);
    let shift = bits - width;
    let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
    let mut counts = vec![0usize; 1usize << width];
    for value in arr.iter() {
        counts[value.extract(mask, shift)] += 1;
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
        Placement::PrefixWriteback => {
            partition_prefix(arr, &counts, mask, shift, block_size, stats)
        },
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
    partition_impl(arr, counts, mask, shift, block_size, stats, false);
}

pub(crate) fn partition_carried<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    counts: &[usize],
    mask: <<T as Radixable<K>>::Key as RadixKey>::Key,
    shift: usize,
    block_size: usize,
    stats: &mut LocalStats,
) {
    partition_impl(arr, counts, mask, shift, block_size, stats, true);
}

fn partition_impl<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    counts: &[usize],
    mask: <<T as Radixable<K>>::Key as RadixKey>::Key,
    shift: usize,
    block_size: usize,
    stats: &mut LocalStats,
    carry_boundary: bool,
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
    let (mut buckets, mut cursors, boundaries) = if carry_boundary {
        let (buckets, cursors) = setup_carried(&mut arena, counts, size);
        (buckets, cursors, Vec::new())
    } else {
        setup_boundaries(&mut arena, counts, size)
    };
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
    stats.peak_scratch_records =
        stats.peak_scratch_records.max(scratch_elements);
    stats.peak_directory_entries = stats.peak_directory_entries.max(total);
    finalize(&mut arena, blocks, length, stats);
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

struct PrefixCursor<T> {
    next: *mut T,
    end: *mut T,
    slot: usize,
    logical: usize,
}
struct PrefixBucket {
    full_pending: usize,
    suffix_pending: usize,
    interior_slot: usize,
    suffix_slot: usize,
    next_logical: usize,
}

fn partition_prefix<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    counts: &[usize],
    mask: <<T as Radixable<K>>::Key as RadixKey>::Key,
    shift: usize,
    block: usize,
    stats: &mut LocalStats,
) {
    let length = arr.len();
    let full = length / block;
    let tail = length % block;
    // Keep the boundary-table policy identical in this placement experiment.
    // Removing that table is a separate setup simplification.
    let mut boundaries = Vec::new();
    let mut end = 0;
    for &count in counts {
        end += count;
        if end % block != 0 {
            let logical = end / block;
            if boundaries
                .last()
                .map_or(true, |&(previous, _)| previous != logical)
            {
                boundaries.push((logical, boundaries.len()));
            }
        }
    }
    assert_eq!(end, length);
    let boundary = |logical| -> usize {
        boundaries[boundaries
            .binary_search_by_key(&logical, |&(index, _)| index)
            .unwrap()]
        .1
    };
    let boundary_slots = boundaries.len();
    let mut slots = boundary_slots;
    let mut buckets = Vec::with_capacity(counts.len());
    let mut prefixes = Vec::with_capacity(counts.len());
    let mut start = 0;
    for &count in counts {
        let end = start + count;
        let prefix = if count > 0 && start % block != 0 {
            boundary(start / block)
        } else {
            NONE
        };
        let suffix = if count > 0 && end % block != 0 {
            boundary(end / block)
        } else {
            NONE
        };
        let full_pending = (end / block)
            .saturating_sub(start / block + usize::from(start % block != 0));
        let interior_slot = if full_pending > 0 {
            let id = slots;
            slots += 1;
            id
        } else {
            NONE
        };
        buckets.push(PrefixBucket {
            full_pending,
            suffix_pending: if suffix != prefix { end % block } else { 0 },
            interior_slot,
            suffix_slot: suffix,
            next_logical: start / block + usize::from(prefix != NONE),
        });
        prefixes.push((prefix, start % block, count, start / block));
        start = end;
    }
    assert!(slots <= (2 * counts.len()).min(full + usize::from(tail != 0)));
    let scratch_records = slots.checked_mul(block).unwrap();
    let mut scratch = vec![MaybeUninit::<T>::uninit(); scratch_records];
    let base = scratch.as_mut_ptr().cast::<T>();
    let mut cursors = Vec::with_capacity(counts.len());
    for (slot, offset, count, logical) in prefixes {
        let (next, end) = if slot == NONE {
            (ptr::null_mut(), ptr::null_mut())
        } else {
            let next = unsafe { base.add(slot * block + offset) };
            (next, unsafe { next.add(count.min(block - offset)) })
        };
        cursors.push(PrefixCursor { next, end, slot, logical });
    }
    let mut filled = vec![0usize; slots];
    let mut mapping = vec![NONE; full];
    let mut completed = 0usize;
    for input in 0..length {
        let source = unsafe { arr.as_ptr().add(input) };
        let digit = unsafe { (*source).extract(mask, shift) };
        let cursor = &mut cursors[digit];
        if cursor.next == cursor.end {
            let bucket = &mut buckets[digit];
            let (slot, take) = if bucket.full_pending > 0 {
                bucket.full_pending -= 1;
                (bucket.interior_slot, block)
            } else if bucket.suffix_pending > 0 {
                let take = bucket.suffix_pending;
                bucket.suffix_pending = 0;
                (bucket.suffix_slot, take)
            } else {
                panic!("extract changed bucket counts")
            };
            cursor.slot = slot;
            cursor.logical = bucket.next_logical;
            bucket.next_logical += 1;
            cursor.next = unsafe { base.add(slot * block) };
            cursor.end = unsafe { cursor.next.add(take) };
        }
        assert!(filled[cursor.slot] < block, "completed scratch block reused");
        // Consume this record into scratch before any writeback to its prefix.
        unsafe {
            ptr::copy_nonoverlapping(source, cursor.next, 1);
            cursor.next = cursor.next.add(1);
        }
        filled[cursor.slot] += 1;
        if filled[cursor.slot] == block {
            assert!(cursor.logical < full && mapping[cursor.logical] == NONE);
            let written = (completed + 1).checked_mul(block).unwrap();
            assert!(
                written <= input + 1,
                "writeback would overwrite unread input"
            );
            unsafe {
                ptr::copy_nonoverlapping(
                    base.add(cursor.slot * block),
                    arr.as_mut_ptr().add(completed * block),
                    block,
                )
            };
            mapping[cursor.logical] = completed;
            completed += 1;
            if cursor.slot >= boundary_slots {
                filled[cursor.slot] = 0;
            }
        }
    }
    for (cursor, bucket) in cursors.iter().zip(&buckets) {
        assert_eq!(cursor.next, cursor.end, "extract changed bucket counts");
        assert_eq!(bucket.full_pending, 0, "extract changed bucket counts");
        assert_eq!(bucket.suffix_pending, 0, "extract changed bucket counts");
    }
    assert_eq!(completed, full);
    if tail != 0 {
        let slot = boundary(full);
        assert_eq!(filled[slot], tail);
        unsafe {
            ptr::copy_nonoverlapping(
                base.add(slot * block),
                arr.as_mut_ptr().add(full * block),
                tail,
            )
        };
    }
    stats.block_nodes += 1;
    stats.block_scatter_records += length;
    stats.prefix_writeback_records += length;
    stats.peak_scratch_records =
        stats.peak_scratch_records.max(scratch_records);
    stats.peak_directory_entries = stats.peak_directory_entries.max(full);
    drop(cursors);
    drop(buckets);
    drop(filled);
    drop(scratch);
    drop(boundaries);
    // Every full physical prefix block now owns exactly one complete logical block.
    let mut inverse = vec![NONE; full];
    for (logical, &physical) in mapping.iter().enumerate() {
        assert!(physical < full && inverse[physical] == NONE);
        inverse[physical] = logical;
    }
    for logical in 0..full {
        let source = mapping[logical];
        if source == logical {
            continue;
        }
        let other = inverse[logical];
        unsafe {
            for offset in 0..block {
                ptr::swap(
                    arr.as_mut_ptr().add(source * block + offset),
                    arr.as_mut_ptr().add(logical * block + offset),
                );
            }
        }
        stats.permutation_writes += 2 * block;
        mapping[other] = source;
        inverse[source] = other;
        mapping[logical] = logical;
        inverse[logical] = logical;
    }
}

pub(crate) fn cached_msd<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    scratch: &mut [MaybeUninit<T>],
    mut bits: usize,
    radix: usize,
    stats: &mut LocalStats,
) {
    if arr.len() < 2 || bits == 0 {
        return;
    }
    if arr.len() <= 128 {
        arr.sort_by_key(|v| v.into_key_type());
        stats.leaf_sorts += 1;
        return;
    }
    let dummy = arr[0];
    loop {
        let width = radix.min(bits);
        let shift = bits - width;
        let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
        let mut counts = vec![0usize; 1usize << width];
        for value in arr.iter() {
            counts[value.extract(mask, shift)] += 1;
        }
        if counts.iter().any(|&n| n == arr.len()) {
            bits = shift;
            if bits == 0 {
                return;
            }
            continue;
        }
        let mut end = 0;
        let mut heads = Vec::with_capacity(counts.len());
        let mut ends = Vec::with_capacity(counts.len());
        for &count in counts.iter() {
            heads.push(end);
            end += count;
            ends.push(end);
        }
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
        unsafe {
            ptr::copy_nonoverlapping(
                scratch.as_ptr().cast::<T>(),
                arr.as_mut_ptr(),
                arr.len(),
            );
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
                    cached_msd(child, scratch, shift, radix, stats);
                }
            }
        }
        return;
    }
}

pub(crate) fn ordered<T: Radixable<K>, K: RadixKey>(arr: &mut [T]) -> bool {
    let first = arr[0].into_key_type();
    let mut different = 1;
    while different < arr.len() && arr[different].into_key_type() == first {
        different += 1;
    }
    if different == arr.len() {
        return true;
    }
    let ascending = first < arr[different].into_key_type();
    let mut previous = arr[different].into_key_type();
    let mut equal = different > 1;
    for value in &arr[different + 1..] {
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
        arr.reverse();
        if equal {
            let mut start = 0;
            let mut previous = arr[0].into_key_type();
            for i in 1..arr.len() {
                let key = arr[i].into_key_type();
                if key != previous {
                    if i - start > 1 {
                        arr[start..i].reverse();
                    }
                    start = i;
                }
                previous = key;
            }
            if arr.len() - start > 1 {
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

#[cfg(test)]
mod carried_setup_tests {
    use super::*;
    fn arena(b: usize, sigma: usize) -> Arena<'static, u64> {
        let blocks = sigma + 8;
        Arena {
            input: ptr::null_mut(),
            scratch: vec![MaybeUninit::uninit(); blocks * b],
            scratch_blocks: blocks,
            b,
            next: vec![NONE; blocks],
            free: (0..blocks).collect(),
            live: vec![false; blocks],
            stats: Stats::default(),
            _borrow: PhantomData,
        }
    }

    fn cursor_offsets(
        arena: &Arena<u64>,
        cursor: &Cursor<u64>,
    ) -> (usize, usize) {
        if cursor.next.is_null() {
            assert!(cursor.end.is_null());
            return (NONE, NONE);
        }
        let base = arena.scratch.as_ptr() as usize;
        ((cursor.next as usize - base) / 8, (cursor.end as usize - base) / 8)
    }

    fn compare(counts: &[usize], b: usize) {
        let mut old = arena(b, counts.len());
        let mut new = arena(b, counts.len());
        let size = counts.iter().sum();
        let (old_buckets, old_cursors, boundaries) =
            setup_boundaries(&mut old, counts, size);
        let (new_buckets, new_cursors) = setup_carried(&mut new, counts, size);
        for (a, b) in old_buckets.iter().zip(&new_buckets) {
            assert_eq!(
                (a.prefix, a.suffix, a.full_pending, a.suffix_pending),
                (b.prefix, b.suffix, b.full_pending, b.suffix_pending),
                "counts={:?}, block={}",
                counts,
                old.b
            );
            assert_eq!(
                (a.interior.first, a.interior.last, a.interior.blocks),
                (b.interior.first, b.interior.last, b.interior.blocks)
            );
        }
        for (a, b) in old_cursors.iter().zip(&new_cursors) {
            assert_eq!(cursor_offsets(&old, a), cursor_offsets(&new, b));
        }
        drop(boundaries);
        // Same free-stack suffix and allocated IDs imply the same allocation
        // order; next/live and peak also cover the real Arena side effects.
        assert_eq!(old.free, new.free);
        assert_eq!(old.next, new.next);
        assert_eq!(old.live, new.live);
        assert_eq!(old.stats.peak_live_blocks, new.stats.peak_live_blocks);
    }

    #[test]
    fn carried_tail_matches_boundary_map_for_exhaustive_small_counts() {
        for sigma in 1..=6 {
            for word in 0..5usize.pow(sigma as u32) {
                let counts: Vec<_> = (0..sigma)
                    .map(|i| (word / 5usize.pow(i as u32)) % 5)
                    .collect();
                for b in 1..=7 {
                    compare(&counts, b);
                }
            }
        }
    }

    #[test]
    fn carried_tail_matches_boundary_map_with_sparse_256_buckets() {
        let mut seed = 0x6a09e667f3bcc909u64;
        for trial in 0..1024 {
            let mut counts = vec![0; 256];
            for count in &mut counts {
                seed ^= seed << 13;
                seed ^= seed >> 7;
                seed ^= seed << 17;
                *count =
                    if seed & 3 == 0 { 0 } else { (seed as usize >> 8) % 513 };
            }
            compare(&counts, [1, 2, 7, 64, 129, 257][trial % 6]);
        }
    }
}

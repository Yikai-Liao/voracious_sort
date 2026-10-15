//! Count-first stable MSD with dense logical output at every node.
//! Shared boundary blocks and lazy private interior heads use a global block directory.
use super::{insertion_sort_key, Stats};
use std::{marker::PhantomData, mem::MaybeUninit, ptr};
use voracious_radix_sort::{RadixKey, Radixable};
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
    fn visit<T: Copy, F: FnMut(T)>(
        &self,
        arena: &mut Arena<T>,
        mut count: usize,
        visit: &mut F,
    ) {
        debug_assert!(count <= self.remaining);
        let mut id = self.head;
        let mut offset = self.offset;
        while count > 0 {
            let end = if id == self.tail { self.last_length } else { arena.b };
            let take = count.min(end - offset);
            let source = unsafe { arena.block(id).add(offset) };
            for i in 0..take {
                visit(unsafe { source.add(i).read() });
            }
            count -= take;
            id = arena.next[id];
            offset = 0;
        }
    }
    unsafe fn read_into<T: Copy>(
        &mut self,
        arena: &mut Arena<T>,
        mut target: *mut T,
        mut count: usize,
    ) {
        while count > 0 {
            let (id, offset, available) = self.span(arena);
            let take = count.min(available);
            ptr::copy_nonoverlapping(arena.block(id).add(offset), target, take);
            self.consume(arena, take);
            target = target.add(take);
            count -= take;
        }
    }
    fn transfer<T: Copy>(
        &mut self,
        arena: &mut Arena<T>,
        output: &mut Writer,
        mut count: usize,
    ) {
        while count > 0 {
            let (id, offset, available) = self.span(arena);
            let take = count.min(available);
            let source = unsafe { arena.block(id).add(offset) };
            unsafe { output.extend(arena, source, take) };
            self.consume(arena, take);
            count -= take;
        }
    }
}
struct Writer {
    blocks: Vec<usize>,
    used: usize,
    length: usize,
}
impl Writer {
    fn new() -> Self {
        Self { blocks: Vec::new(), used: usize::MAX, length: 0 }
    }
    unsafe fn extend<T: Copy>(
        &mut self,
        arena: &mut Arena<T>,
        mut source: *const T,
        mut count: usize,
    ) {
        while count > 0 {
            if self.used >= arena.b {
                self.blocks.push(arena.allocate());
                self.used = 0;
            }
            let take = count.min(arena.b - self.used);
            ptr::copy_nonoverlapping(
                source,
                arena.block(*self.blocks.last().unwrap()).add(self.used),
                take,
            );
            self.used += take;
            self.length += take;
            source = source.add(take);
            count -= take;
        }
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
) -> Stats {
    block_msd_stable_radixsort_body(arr, radix, block_size, 128)
}
pub fn block_msd_stable_radixsort_body<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
    leaf_limit: usize,
) -> Stats {
    assert!((1..=8).contains(&radix));
    assert!(block_size > 0);
    assert!(leaf_limit <= 128);
    if arr.len() < 2 || std::mem::size_of::<T>() == 0 {
        return Stats::default();
    }
    if arr.len() <= leaf_limit {
        arr.sort_by_key(|value| value.into_key_type());
        return Stats::default();
    }
    if ordered::<T, K>(arr) {
        return Stats::default();
    }
    let dummy = arr[0];
    let length = arr.len();
    let bits = dummy.type_size();
    let depth = bits / radix + usize::from(bits % radix != 0);
    let sigma = 1usize << radix;
    let full = length / block_size;
    let tail = length % block_size;
    // Boundary blocks + at most one partial private interior head per bucket.
    // They are also distinct output blocks, so their sum is <= ceil(n/b).
    let rounded = full + usize::from(tail != 0);
    let active = (2 * sigma).min(rounded);
    let scratch_blocks = depth
        .checked_mul(2)
        .unwrap()
        .checked_add(active)
        .unwrap()
        .checked_add(8)
        .unwrap();
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
    let mut output = Writer::new();
    recurse::<T, K>(
        &mut arena,
        &mut input,
        length,
        bits,
        radix,
        leaf_limit,
        dummy,
        &mut output,
    );
    assert_eq!(input.remaining, 0);
    finalize(&mut arena, output, length);
    arena.stats
}

fn ordered<T: Radixable<K>, K: RadixKey>(arr: &mut [T]) -> bool {
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

fn recurse<T: Radixable<K>, K: RadixKey>(
    arena: &mut Arena<T>,
    input: &mut Stream,
    size: usize,
    mut bits: usize,
    radix: usize,
    leaf_limit: usize,
    dummy: T,
    output: &mut Writer,
) {
    if size <= leaf_limit {
        #[cfg(feature = "cf_span_leaf")]
        {
            let (id, offset, available) = input.span(arena);
            if size <= available {
                let values = unsafe {
                    std::slice::from_raw_parts_mut(
                        arena.block(id).add(offset),
                        size,
                    )
                };
                sort_leaf::<T, K>(values);
                input.transfer(arena, output, size);
                return;
            }
        }
        leaf::<T, K>(arena, input, size, output);
        return;
    }
    if bits > 0 && size > 1 {
        let mut union = dummy.default_key();
        let mut intersection = None;
        input.visit(arena, size, &mut |value: T| {
            let key = value.into_key_type();
            union |= key;
            intersection = Some(intersection.map_or(key, |old| old & key));
        });
        let intersection = intersection.unwrap();
        while bits > 0 {
            let width = radix.min(bits);
            let shift = bits - width;
            let mask =
                dummy.default_mask(width) << dummy.usize_to_keytype(shift);
            if union & mask != intersection & mask {
                break;
            }
            bits = shift;
        }
    }
    if bits == 0 || size <= 1 {
        input.transfer(arena, output, size);
        return;
    }
    arena.stats.nodes += 1;
    arena.stats.dense_nodes += 1;
    arena.stats.dense_scattered_elements += size;
    let width = radix.min(bits);
    let shift = bits - width;
    let sigma = 1usize << width;
    let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
    let mut counts = vec![0usize; sigma];
    input.visit(arena, size, &mut |value: T| {
        counts[value.extract(mask, shift)] += 1
    });
    let mut boundaries = Vec::<(usize, usize)>::new();
    let mut end = 0;
    for &count in &counts {
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
    debug_assert!(boundaries.len() <= sigma);
    assert_eq!(end, size);
    let boundary = |index: usize| -> usize {
        boundaries[boundaries
            .binary_search_by_key(&index, |&(i, _)| i)
            .expect("missing shared boundary")]
        .1
    };
    let mut buckets = Vec::with_capacity(sigma);
    let mut cursors: Vec<Cursor<T>> = Vec::with_capacity(sigma);
    let mut start = 0;
    for &count in &counts {
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
    let mut remaining = size;
    while remaining > 0 {
        let (id, offset, available) = input.span(arena);
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
                    bucket.interior.append(arena, physical);
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
        input.consume(arena, take);
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
            chain.append(arena, bucket.prefix);
        }
        chain.join(arena, bucket.interior);
        if bucket.suffix != NONE {
            chain.append(arena, bucket.suffix);
        }
    }
    assert_eq!(
        chain.blocks,
        size / arena.b + usize::from(size % arena.b != 0),
        "dense output directory"
    );
    drop(boundaries);
    let mut stream = Stream {
        head: chain.first,
        tail: chain.last,
        offset: 0,
        last_length: (size - 1) % arena.b + 1,
        remaining: size,
    };
    for count in counts {
        if count > 0 {
            recurse::<T, K>(
                arena,
                &mut stream,
                count,
                shift,
                radix,
                leaf_limit,
                dummy,
                output,
            );
        }
    }
    assert_eq!(stream.remaining, 0);
}
#[inline(never)]
fn leaf<T: Radixable<K>, K: RadixKey>(
    arena: &mut Arena<T>,
    input: &mut Stream,
    size: usize,
    output: &mut Writer,
) {
    let mut storage = [MaybeUninit::<T>::uninit(); 128];
    unsafe { input.read_into(arena, storage.as_mut_ptr().cast::<T>(), size) };
    let values = unsafe {
        std::slice::from_raw_parts_mut(storage.as_mut_ptr().cast::<T>(), size)
    };
    sort_leaf::<T, K>(values);
    unsafe { output.extend(arena, values.as_ptr(), size) };
}
fn sort_leaf<T: Radixable<K>, K: RadixKey>(values: &mut [T]) {
    #[cfg(feature = "cf_std_leaf")]
    values.sort_by_key(|value| value.into_key_type());
    #[cfg(not(feature = "cf_std_leaf"))]
    insertion_sort_key::<T, K>(values);
}
fn finalize<T: Copy>(arena: &mut Arena<T>, mut output: Writer, length: usize) {
    assert_eq!(output.length, length);
    let full = length / arena.b;
    let mut inverse = vec![NONE; arena.next.len()];
    for (i, &id) in output.blocks.iter().enumerate() {
        inverse[id] = i;
    }
    for i in 0..full {
        let source = output.blocks[i];
        let destination = arena.scratch_blocks + i;
        if source == destination {
            continue;
        }
        let other = inverse[destination];
        unsafe {
            if other != NONE && other > i {
                for j in 0..arena.b {
                    ptr::swap(
                        arena
                            .block(destination)
                            .add(j)
                            .cast::<MaybeUninit<T>>(),
                        arena.block(source).add(j).cast::<MaybeUninit<T>>(),
                    );
                }
                output.blocks[other] = source;
                inverse[source] = other;
            } else {
                ptr::copy_nonoverlapping(
                    arena.block(source),
                    arena.block(destination),
                    arena.b,
                );
                inverse[source] = NONE;
            }
        }
        output.blocks[i] = destination;
        inverse[destination] = i;
    }
    if length % arena.b != 0 {
        unsafe {
            ptr::copy(
                arena.block(output.blocks[full]),
                arena.input.add(full * arena.b),
                length % arena.b,
            );
        }
    }
}

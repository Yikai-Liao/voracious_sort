//! Experimental dense-tail stable block MSD. See REPORT.md for its space model.
use std::{marker::PhantomData, mem::MaybeUninit, ptr};
use voracious_radix_sort::{RadixKey, Radixable};
#[cfg_attr(not(feature = "cf_early_scan"), path = "../scan_experiment/full_scan.rs")]
pub mod count_first;
#[path = "../scan_experiment/full_scan.rs"]
pub mod count_first_full_scan;
pub mod stable_baseline;
pub mod node_local;

#[derive(Default, Debug)]
pub struct Stats {
    pub nodes: usize,
    pub dense_nodes: usize,
    pub dense_scattered_elements: usize,
    pub packed_tail_elements: usize,
    pub relocated_tail_elements: usize,
    pub tail_relocations: usize,
    pub peak_live_blocks: usize,
    pub scratch_elements: usize,
    #[cfg(feature = "cf_phases")]
    pub phases: Box<PhaseStats>,
}

#[cfg(feature = "cf_phases")]
#[derive(Default, Debug)]
pub struct PhaseStats {
    pub workspace_ns: u128,
    pub union_ns: u128,
    pub histogram_ns: u128,
    pub setup_ns: u128,
    pub scatter_ns: u128,
    pub assemble_ns: u128,
    pub leaf_gather_ns: u128,
    pub leaf_sort_ns: u128,
    pub leaf_write_ns: u128,
    pub terminal_ns: u128,
    pub finalize_ns: u128,
    pub union_records: usize,
    pub histogram_records: usize,
    pub scatter_records: usize,
    pub setup_entries: usize,
    pub gather_records: usize,
    pub writer_records: usize,
    pub buffer_clone_records: usize,
    pub full_permutation_records: usize,
    pub leaf_lengths: Vec<usize>,
}

// Full block IDs followed by a segment of the parent's dense tail stream.
#[derive(Default)]
struct Bucket {
    full: Vec<usize>,
    tail: usize,
}
#[derive(Default)]
struct Stream {
    blocks: Vec<usize>,
    length: usize,
    cursor: usize,
    head: usize,
    head_offset: usize,
    relocated: Option<Relocated>,
}
#[derive(Clone, Copy)]
struct Relocated {
    offset: usize,
    end: usize,
}
struct Writer {
    blocks: Vec<usize>,
    length: usize,
    used: usize,
}
impl Writer {
    fn new() -> Self {
        Self { blocks: Vec::new(), length: 0, used: usize::MAX }
    }
    fn push<T: Copy>(&mut self, arena: &mut Arena<T>, value: T) {
        if self.used >= arena.b {
            self.blocks.push(arena.allocate());
            self.used = 0;
        }
        arena.write(*self.blocks.last().unwrap(), self.used, value);
        self.used += 1;
        self.length += 1;
    }
    unsafe fn extend<T: Copy>(
        &mut self,
        arena: &mut Arena<T>,
        mut source: *const T,
        mut length: usize,
    ) {
        while length > 0 {
            if self.used >= arena.b {
                self.blocks.push(arena.allocate());
                self.used = 0;
            }
            let count = length.min(arena.b - self.used);
            ptr::copy_nonoverlapping(
                source,
                arena.block(*self.blocks.last().unwrap()).add(self.used),
                count,
            );
            self.used += count;
            self.length += count;
            source = source.add(count);
            length -= count;
        }
    }
    fn stream(self) -> Stream {
        Stream { blocks: self.blocks, length: self.length, ..Stream::default() }
    }
}
impl Stream {
    fn tail_length(&self, b: usize) -> usize {
        if self.length == 0 {
            0
        } else {
            (self.length - 1) % b + 1
        }
    }
    // The logical suffix is relocated-head, regular full blocks, original tail.
    // Physical ordering differs, so all callers (including key scans) use peek.
    fn peek<T: Copy>(&self, arena: &mut Arena<T>, mut ahead: usize) -> T {
        assert!(self.cursor + ahead < self.length);
        let last = self.blocks.len() - 1;
        if let Some(segment) = self.relocated {
            let available = segment.end - segment.offset;
            if ahead < available {
                return arena.read(self.blocks[last], segment.offset + ahead);
            }
            ahead -= available;
        }
        let regular = if self.head < last {
            (last - self.head) * arena.b - self.head_offset
        } else {
            0
        };
        if ahead < regular {
            let pos = self.head_offset + ahead;
            return arena
                .read(self.blocks[self.head + pos / arena.b], pos % arena.b);
        }
        ahead -= regular;
        let offset = if self.head == last { self.head_offset } else { 0 };
        arena.read(self.blocks[last], offset + ahead)
    }
    fn visit<T: Copy, F: FnMut(T)>(
        &self,
        arena: &mut Arena<T>,
        length: usize,
        visit: &mut F,
    ) {
        debug_assert!(length <= self.length - self.cursor);
        if length == 0 {
            return;
        }
        let mut done = 0;
        let last = self.blocks.len() - 1;
        let mut range =
            |id: usize, offset: usize, count: usize, arena: &mut Arena<T>| {
                let source = unsafe { arena.block(id).add(offset) };
                for i in 0..count {
                    visit(unsafe { source.add(i).read() });
                }
            };
        if let Some(segment) = self.relocated {
            let count = (segment.end - segment.offset).min(length - done);
            range(self.blocks[last], segment.offset, count, arena);
            done += count;
            if done == length {
                return;
            }
        }
        for i in self.head..last {
            let offset = if i == self.head { self.head_offset } else { 0 };
            let count = (arena.b - offset).min(length - done);
            range(self.blocks[i], offset, count, arena);
            done += count;
            if done == length {
                return;
            }
        }
        let offset = if self.head == last { self.head_offset } else { 0 };
        range(self.blocks[last], offset, length - done, arena);
    }
    fn span(&self, b: usize) -> (usize, usize, usize) {
        debug_assert!(self.cursor < self.length);
        if cfg!(feature = "simple_stream") {
            let last = self.blocks.len() - 1;
            let end = if self.head == last { self.tail_length(b) } else { b };
            return (
                self.blocks[self.head],
                self.head_offset,
                end - self.head_offset,
            );
        }
        if let Some(segment) = self.relocated {
            return (
                *self.blocks.last().unwrap(),
                segment.offset,
                segment.end - segment.offset,
            );
        }
        (
            self.blocks[self.head],
            self.head_offset,
            self.tail_length(b) - self.head_offset,
        )
    }
    fn bulk_span(&self, b: usize, length: usize) -> (usize, usize, usize) {
        if length >= b
            && self.relocated.is_none()
            && self.head_offset == 0
            && (self.head + 1 < self.blocks.len() || self.tail_length(b) == b)
        {
            return (self.blocks[self.head], 0, b);
        }
        self.span(b)
    }
    fn bulk_consume<T: Copy>(&mut self, arena: &mut Arena<T>, count: usize) {
        if count == arena.b && self.relocated.is_none() && self.head_offset == 0
        {
            arena.release(self.blocks[self.head]);
            self.head += 1;
            self.cursor += count;
            debug_assert!(self.cursor <= self.length);
            return;
        }
        self.consume(arena, count);
    }
    fn consume<T: Copy>(&mut self, arena: &mut Arena<T>, count: usize) {
        debug_assert!(count > 0 && count <= self.span(arena.b).2);
        self.cursor += count;
        if let Some(mut segment) = self.relocated {
            segment.offset += count;
            self.relocated = if segment.offset == segment.end {
                None
            } else {
                Some(segment)
            };
        } else {
            let last = self.blocks.len() - 1;
            self.head_offset += count;
            if self.head == last {
                if self.cursor == self.length {
                    arena.release(self.blocks[last]);
                    self.head += 1;
                    self.head_offset = 0;
                }
            } else if self.head_offset == arena.b {
                arena.release(self.blocks[self.head]);
                self.head += 1;
                self.head_offset = 0;
            } else {
                let tail = self.tail_length(arena.b);
                if !cfg!(feature = "simple_stream") && self.head_offset >= tail
                {
                    let length = arena.b - self.head_offset;
                    let source = self.blocks[self.head];
                    let destination = self.blocks[last];
                    debug_assert_ne!(source, destination);
                    debug_assert!(tail + length <= arena.b);
                    unsafe {
                        ptr::copy_nonoverlapping(
                            arena.block(source).add(self.head_offset),
                            arena.block(destination).add(tail),
                            length,
                        );
                    }
                    self.relocated =
                        Some(Relocated { offset: tail, end: tail + length });
                    arena.stats.relocated_tail_elements += length;
                    arena.stats.tail_relocations += 1;
                    arena.release(source);
                    self.head += 1;
                    self.head_offset = 0;
                }
            }
        }
        if cfg!(feature = "simple_stream") {
            debug_assert!(
                (self.blocks.len() - self.head) * arena.b
                    - (self.length - self.cursor)
                    < 2 * arena.b
            );
        } else {
            debug_assert_eq!(
                self.blocks.len() - self.head,
                (self.length - self.cursor + arena.b - 1) / arena.b
            );
        }
    }
    fn read<T: Copy>(&mut self, arena: &mut Arena<T>) -> T {
        let (id, offset, _) = self.span(arena.b);
        let value = arena.read(id, offset);
        self.consume(arena, 1);
        value
    }
    unsafe fn read_into<T: Copy>(
        &mut self,
        arena: &mut Arena<T>,
        mut destination: *mut T,
        mut length: usize,
    ) {
        while length > 0 {
            let (id, offset, available) = self.bulk_span(arena.b, length);
            let count = length.min(available);
            ptr::copy_nonoverlapping(
                arena.block(id).add(offset),
                destination,
                count,
            );
            self.bulk_consume(arena, count);
            destination = destination.add(count);
            length -= count;
        }
    }
    fn transfer<T: Copy>(
        &mut self,
        arena: &mut Arena<T>,
        output: &mut Writer,
        mut length: usize,
    ) {
        while length > 0 {
            let (id, offset, available) = self.bulk_span(arena.b, length);
            let count = length.min(available);
            let source = unsafe { arena.block(id).add(offset) };
            unsafe { output.extend(arena, source, count) };
            self.bulk_consume(arena, count);
            length -= count;
        }
    }
}
struct Arena<'a, T> {
    input: *mut T,
    scratch: Vec<MaybeUninit<T>>,
    scratch_blocks: usize,
    b: usize,
    free: Vec<usize>,
    live: Vec<bool>,
    stats: Stats,
    _borrow: PhantomData<&'a mut [T]>,
}
impl<'a, T: Copy> Arena<'a, T> {
    fn block(&mut self, id: usize) -> *mut T {
        debug_assert!(id < self.live.len());
        // Both regions never resize; IDs address full storage blocks. Scratch padding
        // can be uninitialized. Typed reads require a caller-proven live value.
        // Finalization may address dead storage as a destination;
        // read/write separately require live IDs while scattering and streaming.
        unsafe {
            if id < self.scratch_blocks {
                self.scratch.as_mut_ptr().add(id * self.b).cast::<T>()
            } else {
                self.input.add((id - self.scratch_blocks) * self.b)
            }
        }
    }
    fn read(&mut self, id: usize, offset: usize) -> T {
        debug_assert!(offset < self.b);
        debug_assert!(self.live[id]);
        unsafe { self.block(id).add(offset).read() }
    }
    fn write(&mut self, id: usize, offset: usize, value: T) {
        debug_assert!(offset < self.b);
        debug_assert!(self.live[id]);
        unsafe {
            self.block(id).add(offset).write(value);
        }
    }
    fn allocate(&mut self) -> usize {
        let id = self.free.pop().expect("dense-tail space bound violated");
        assert!(!self.live[id]);
        self.live[id] = true;
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

/// Research-only API with the repository's existing key contract and naming.
/// Uses bounded stable insertion leaves, no O(n) element buffer, and no load-specific parameter table.
pub fn block_msd_stable_radixsort<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
) -> Stats {
    block_msd_stable_radixsort_body(arr, radix, block_size, 128)
}

/// Experimental control for testing the pure block path (leaf_limit = 0).
pub fn block_msd_stable_radixsort_body<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
    leaf_limit: usize,
) -> Stats {
    assert!(leaf_limit <= 128);
    assert!((1..=8).contains(&radix));
    assert!(block_size > 0);
    if arr.len() < 2 || std::mem::size_of::<T>() == 0 {
        return Stats::default();
    }
    if arr.len() <= leaf_limit {
        arr.sort_by_key(|value| value.into_key_type());
        return Stats::default();
    }
    let first = arr[0].into_key_type();
    let mut different = 1;
    while different < arr.len() && arr[different].into_key_type() == first {
        different += 1;
    }
    if different == arr.len() {
        return Stats::default();
    }
    let ascending = first < arr[different].into_key_type();
    let mut previous = arr[different].into_key_type();
    let mut ordered = true;
    let mut equal = different > 1;
    for value in &arr[different + 1..] {
        let key = value.into_key_type();
        if ascending {
            if previous > key {
                ordered = false;
                break;
            }
        } else {
            if previous < key {
                ordered = false;
                break;
            }
            equal |= previous == key;
        }
        previous = key;
    }
    if ordered {
        if !ascending {
            arr.reverse();
            if equal {
                let mut start = 0;
                let mut previous = arr[0].into_key_type();
                for i in 1..arr.len() {
                    let key = arr[i].into_key_type();
                    if previous != key {
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
        return Stats::default();
    }
    let dummy = arr[0];
    let depth = (dummy.type_size() + radix - 1) / radix;
    let sigma = 1usize << radix;
    let scratch_blocks = sigma
        + if cfg!(feature = "simple_stream") { 2 * depth } else { depth }
        + 4;
    let full = arr.len() / block_size;
    let tail = arr.len() % block_size;
    let scratch_len = scratch_blocks.checked_mul(block_size).unwrap();
    let mut arena = Arena {
        input: arr.as_mut_ptr(),
        scratch: vec![MaybeUninit::uninit(); scratch_len],
        scratch_blocks,
        b: block_size,
        free: (0..scratch_blocks).collect(),
        live: vec![false; scratch_blocks + full],
        stats: Stats { scratch_elements: scratch_len, ..Stats::default() },
        _borrow: PhantomData,
    };
    let mut root = Bucket::default();
    for id in scratch_blocks..scratch_blocks + full {
        arena.live[id] = true;
        root.full.push(id);
    }
    root.tail = tail;
    let mut initial = Writer::new();
    for &value in &arr[full * block_size..] {
        initial.push(&mut arena, value);
    }
    let mut initial = initial.stream();
    let mut final_output = Writer::new();
    recurse::<T, K>(
        &mut arena,
        root,
        &mut initial,
        dummy.type_size(),
        radix,
        &mut final_output,
        dummy,
        leaf_limit,
    );
    finalize(&mut arena, final_output, arr.len());
    arena.stats
}

fn recurse<T: Radixable<K>, K: RadixKey>(
    arena: &mut Arena<T>,
    input: Bucket,
    parent_tail: &mut Stream,
    mut bits: usize,
    radix: usize,
    output: &mut Writer,
    dummy: T,
    leaf_limit: usize,
) {
    let size = input.full.len() * arena.b + input.tail;
    // A fixed, bounded leaf buffer avoids sigma-way setup for tiny buckets.
    // Stable insertion compares converted keys; it does not depend on PartialOrd.
    if size <= leaf_limit {
        leaf_sort::<T, K>(arena, input, parent_tail, output, dummy, size);
        return;
    }
    if bits > 0 && size > 1 {
        let mut union = dummy.default_key();
        let mut intersection = None;
        let mut include = |value: T| {
            let key = value.into_key_type();
            union |= key;
            intersection = Some(intersection.map_or(key, |old| old & key));
        };
        for &id in &input.full {
            for j in 0..arena.b {
                include(arena.read(id, j));
            }
        }
        parent_tail.visit(arena, input.tail, &mut include);
        let intersection = intersection.unwrap();
        // Drop constant prefixes using converted keys, without workload tables.
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
        for id in input.full {
            let source = arena.block(id);
            unsafe {
                let b = arena.b;
                output.extend(arena, source, b)
            };
            arena.release(id);
        }
        parent_tail.transfer(arena, output, input.tail);
        return;
    }
    arena.stats.nodes += 1;
    let width = radix.min(bits);
    let shift = bits - width;
    let sigma = 1usize << width;
    let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
    if size <= sigma * arena.b
        && (size + arena.b - 1) / arena.b <= arena.free.len()
    {
        dense_scatter::<T, K>(
            arena,
            input,
            parent_tail,
            shift,
            radix,
            output,
            dummy,
            leaf_limit,
            mask,
            sigma,
            size,
        );
        return;
    }
    let mut buckets: Vec<Bucket> =
        (0..sigma).map(|_| Bucket::default()).collect();
    // Reserve output heads before reading input; at most sigma active heads exist.
    let mut heads: Vec<usize> = (0..sigma).map(|_| arena.allocate()).collect();
    let scatter = |source: *const T,
                   arena: &mut Arena<T>,
                   buckets: &mut Vec<Bucket>,
                   heads: &mut Vec<usize>| {
        let digit = unsafe { (*source).extract(mask, shift) };
        let bucket = &mut buckets[digit];
        unsafe {
            ptr::copy_nonoverlapping(
                source,
                arena.block(heads[digit]).add(bucket.tail),
                1,
            )
        };
        bucket.tail += 1;
        if bucket.tail == arena.b {
            bucket.full.push(heads[digit]);
            heads[digit] = arena.allocate();
            bucket.tail = 0;
        }
    };
    for id in input.full {
        let source = arena.block(id);
        for j in 0..arena.b {
            scatter(unsafe { source.add(j) }, arena, &mut buckets, &mut heads);
        }
        arena.release(id);
    }
    let mut remaining = input.tail;
    while remaining > 0 {
        let (id, offset, available) = parent_tail.bulk_span(arena.b, remaining);
        let count = remaining.min(available);
        let source = unsafe { arena.block(id).add(offset) };
        for j in 0..count {
            scatter(unsafe { source.add(j) }, arena, &mut buckets, &mut heads);
        }
        parent_tail.bulk_consume(arena, count);
        remaining -= count;
    }
    let mut tails = Writer::new();
    for (bucket, head) in buckets.iter().zip(heads) {
        let source = arena.block(head);
        unsafe { tails.extend(arena, source, bucket.tail) };
        arena.stats.packed_tail_elements += bucket.tail;
        arena.release(head);
    }
    let mut tails = tails.stream();
    for bucket in buckets {
        if !bucket.full.is_empty() || bucket.tail > 0 {
            recurse::<T, K>(
                arena, bucket, &mut tails, shift, radix, output, dummy,
                leaf_limit,
            );
        }
    }
    assert_eq!(tails.cursor, tails.length);
}

#[inline(never)]
fn leaf_sort<T: Radixable<K>, K: RadixKey>(
    arena: &mut Arena<T>,
    input: Bucket,
    parent_tail: &mut Stream,
    output: &mut Writer,
    _dummy: T,
    size: usize,
) {
    // Separate stack frame keeps the 128T buffer out of all ancestor frames.
    let mut storage = [MaybeUninit::<T>::uninit(); 128];
    let mut used = 0;
    for id in input.full {
        unsafe {
            ptr::copy_nonoverlapping(
                arena.block(id),
                storage.as_mut_ptr().add(used).cast::<T>(),
                arena.b,
            )
        };
        used += arena.b;
        arena.release(id);
    }
    unsafe {
        parent_tail.read_into(
            arena,
            storage.as_mut_ptr().add(used).cast::<T>(),
            input.tail,
        )
    };
    used += input.tail;
    debug_assert_eq!(used, size);
    let leaf = unsafe {
        std::slice::from_raw_parts_mut(storage.as_mut_ptr().cast::<T>(), size)
    };
    insertion_sort_key::<T, K>(leaf);
    unsafe { output.extend(arena, leaf.as_ptr(), size) };
}

fn insertion_sort_key<T: Radixable<K>, K: RadixKey>(leaf: &mut [T]) {
    let size = leaf.len();
    for i in 1..size {
        let key = leaf[i].into_key_type();
        if leaf[i - 1].into_key_type() <= key {
            continue;
        }
        let mut lo = 0;
        let mut hi = i;
        while lo < hi {
            let mid = (lo + hi) / 2;
            if leaf[mid].into_key_type() <= key {
                lo = mid + 1;
            } else {
                hi = mid;
            }
        }
        let mut temporary = MaybeUninit::<T>::uninit();
        unsafe {
            let base = leaf.as_mut_ptr();
            ptr::copy_nonoverlapping(base.add(i), temporary.as_mut_ptr(), 1);
            ptr::copy(base.add(lo), base.add(lo + 1), i - lo);
            ptr::copy_nonoverlapping(temporary.as_ptr(), base.add(lo), 1);
        }
    }
}
#[inline(never)]
fn sort_dense_segment<T: Radixable<K>, K: RadixKey>(
    arena: &mut Arena<T>,
    blocks: &[usize],
    start: usize,
    size: usize,
) {
    debug_assert!(size <= 128);
    let mut storage = [MaybeUninit::<T>::uninit(); 128];
    let mut done = 0;
    while done < size {
        let position = start + done;
        let offset = position % arena.b;
        let count = (size - done).min(arena.b - offset);
        unsafe {
            ptr::copy_nonoverlapping(
                arena.block(blocks[position / arena.b]).add(offset),
                storage.as_mut_ptr().add(done).cast::<T>(),
                count,
            )
        };
        done += count;
    }
    let leaf = unsafe {
        std::slice::from_raw_parts_mut(storage.as_mut_ptr().cast::<T>(), size)
    };
    insertion_sort_key::<T, K>(leaf);
    done = 0;
    while done < size {
        let position = start + done;
        let offset = position % arena.b;
        let count = (size - done).min(arena.b - offset);
        unsafe {
            ptr::copy_nonoverlapping(
                leaf.as_ptr().add(done),
                arena.block(blocks[position / arena.b]).add(offset),
                count,
            )
        };
        done += count;
    }
}

#[derive(Clone, Copy)]
struct DenseCursor<T> {
    next: *mut T,
    end: *mut T,
    index: usize,
    position: usize,
}
fn dense_scatter<T: Radixable<K>, K: RadixKey>(
    arena: &mut Arena<T>,
    input: Bucket,
    parent: &mut Stream,
    shift: usize,
    radix: usize,
    output: &mut Writer,
    dummy: T,
    leaf_limit: usize,
    mask: <<T as Radixable<K>>::Key as RadixKey>::Key,
    sigma: usize,
    size: usize,
) {
    arena.stats.dense_nodes += 1;
    arena.stats.dense_scattered_elements += size;
    let mut counts = vec![0usize; sigma];
    let mut count = |value: T| {
        counts[value.extract(mask, shift)] += 1;
    };
    for &id in &input.full {
        let source = arena.block(id);
        for j in 0..arena.b {
            count(unsafe { source.add(j).read() });
        }
    }
    parent.visit(arena, input.tail, &mut count);
    let blocks: Vec<usize> =
        (0..(size + arena.b - 1) / arena.b).map(|_| arena.allocate()).collect();
    let mut cursors = vec![
        DenseCursor {
            next: ptr::null_mut(),
            end: ptr::null_mut(),
            index: 0,
            position: size
        };
        sigma
    ];
    let mut start = 0;
    for (digit, &count) in counts.iter().enumerate() {
        if count > 0 {
            let index = start / arena.b;
            let base = arena.block(blocks[index]);
            cursors[digit] = DenseCursor {
                next: unsafe { base.add(start % arena.b) },
                end: unsafe { base.add(arena.b) },
                index,
                position: start,
            };
        }
        start += count;
    }
    let scatter = |source: *const T,
                   arena: &mut Arena<T>,
                   cursors: &mut Vec<DenseCursor<T>>| {
        let cursor = &mut cursors[unsafe { (*source).extract(mask, shift) }];
        assert!(cursor.position < size, "extract changed bucket counts");
        unsafe {
            ptr::copy_nonoverlapping(source, cursor.next, 1);
            cursor.next = cursor.next.add(1);
        }
        cursor.position += 1;
        if cursor.next == cursor.end {
            cursor.index += 1;
            if cursor.index < blocks.len() {
                let base = arena.block(blocks[cursor.index]);
                cursor.next = base;
                cursor.end = unsafe { base.add(arena.b) };
            }
        }
    };
    for id in input.full {
        let source = arena.block(id);
        for j in 0..arena.b {
            scatter(unsafe { source.add(j) }, arena, &mut cursors);
        }
        arena.release(id);
    }
    let mut remaining = input.tail;
    while remaining > 0 {
        let (id, offset, available) = parent.bulk_span(arena.b, remaining);
        let count = remaining.min(available);
        let source = unsafe { arena.block(id).add(offset) };
        for j in 0..count {
            scatter(unsafe { source.add(j) }, arena, &mut cursors);
        }
        parent.bulk_consume(arena, count);
        remaining -= count;
    }
    let mut expected = 0;
    for (digit, &count) in counts.iter().enumerate() {
        expected += count;
        if count > 0 {
            assert_eq!(
                cursors[digit].position, expected,
                "extract changed bucket counts"
            );
        }
    }
    drop(cursors);
    let mut stream = Stream { blocks, length: size, ..Stream::default() };
    if cfg!(feature = "terminal_fusion")
        && leaf_limit > 0
        && counts.iter().all(|&count| count <= leaf_limit)
    {
        let mut start = 0;
        for &length in &counts {
            if length > 1 {
                sort_dense_segment::<T, K>(
                    arena,
                    &stream.blocks,
                    start,
                    length,
                );
            }
            start += length;
        }
        stream.transfer(arena, output, size);
        debug_assert_eq!(stream.cursor, size);
        return;
    }
    // Child segments can now exceed b; the stream owns and reclaims shared blocks.
    for length in counts {
        if length > 0 {
            recurse::<T, K>(
                arena,
                Bucket { full: Vec::new(), tail: length },
                &mut stream,
                shift,
                radix,
                output,
                dummy,
                leaf_limit,
            );
        }
    }
    assert_eq!(stream.cursor, stream.length);
}

fn finalize<T: Copy>(arena: &mut Arena<T>, mut output: Writer, length: usize) {
    assert_eq!(output.length, length);
    let full = length / arena.b;
    let mut inverse = vec![usize::MAX; arena.live.len()];
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
        // Swap if destination still holds a later output; otherwise overwrite dead storage.
        unsafe {
            if other != usize::MAX && other > i {
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
                inverse[source] = usize::MAX;
            }
        }
        output.blocks[i] = destination;
        inverse[destination] = i;
    }
    if length % arena.b != 0 {
        let source = output.blocks[full];
        unsafe {
            ptr::copy(
                arena.block(source),
                arena.input.add(full * arena.b),
                length % arena.b,
            );
        }
    }
}

#[cfg(test)]
mod stream_tests {
    use super::*;
    #[test]
    fn all_tail_gaps_peeks_and_recycled_head_ids() {
        // Exhaust every possible tail length and trigger position for small b.
        // Recycle each freed head immediately to expose stale physical addressing.
        for b in 1usize..=17 {
            for length in 0..=5 * b + 5 {
                let count = (length + b - 1) / b + 2;
                let mut arena = Arena {
                    input: ptr::null_mut(),
                    scratch: vec![MaybeUninit::uninit(); count * b],
                    scratch_blocks: count,
                    b,
                    free: (0..count).collect(),
                    live: vec![false; count],
                    stats: Stats::default(),
                    _borrow: PhantomData,
                };
                let mut writer = Writer::new();
                for i in 0..length {
                    writer.push(&mut arena, i as u32);
                }
                let mut stream = writer.stream();
                for cursor in 0..length {
                    for ahead in 0..length - cursor {
                        assert_eq!(
                            stream.peek(&mut arena, ahead),
                            (cursor + ahead) as u32
                        );
                    }
                    assert_eq!(stream.read(&mut arena), cursor as u32);
                    let remaining = length - cursor - 1;
                    let used = arena.live.iter().filter(|&&live| live).count();
                    if cfg!(feature = "simple_stream") {
                        assert!(used * b - remaining < 2 * b);
                    } else {
                        assert_eq!(used, (remaining + b - 1) / b);
                    }
                    let external = arena.allocate();
                    for j in 0..b {
                        arena.write(external, j, u32::MAX);
                    }
                    arena.release(external);
                }
                assert_eq!(arena.free.len(), count);
            }
        }
    }
}

pub mod leaf_batch;

pub mod carried_boundaries;

pub mod joint_histograms;

pub mod skew_paths;

pub mod materialization_gate;

pub mod combined_stream;

pub mod submitted_lsd;

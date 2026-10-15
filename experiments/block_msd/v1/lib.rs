//! Experimental dense-tail stable block MSD. See REPORT.md for its space model.
use std::{marker::PhantomData, ptr};
use voracious_radix_sort::{RadixKey, Radixable};

#[derive(Default, Debug)]
pub struct Stats {
    pub nodes: usize,
    pub packed_tail_elements: usize,
    pub peak_live_blocks: usize,
    pub scratch_elements: usize,
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
}
struct Writer {
    blocks: Vec<usize>,
    length: usize,
}
impl Writer {
    fn new() -> Self {
        Self { blocks: Vec::new(), length: 0 }
    }
    fn push<T: Copy>(&mut self, arena: &mut Arena<T>, value: T) {
        if self.length % arena.b == 0 {
            self.blocks.push(arena.allocate());
        }
        arena.write(*self.blocks.last().unwrap(), self.length % arena.b, value);
        self.length += 1;
    }
    fn stream(self) -> Stream {
        Stream { blocks: self.blocks, length: self.length, cursor: 0 }
    }
}
impl Stream {
    fn read<T: Copy>(&mut self, arena: &mut Arena<T>) -> T {
        assert!(self.cursor < self.length);
        let block = self.blocks[self.cursor / arena.b];
        let value = arena.read(block, self.cursor % arena.b);
        self.cursor += 1;
        // A partial last block becomes free too once its entire live prefix is read.
        if self.cursor % arena.b == 0 || self.cursor == self.length {
            arena.release(block);
        }
        value
    }
}
struct Arena<'a, T> {
    input: *mut T,
    scratch: Vec<T>,
    scratch_blocks: usize,
    b: usize,
    free: Vec<usize>,
    live: Vec<bool>,
    stats: Stats,
    _borrow: PhantomData<&'a mut [T]>,
}
impl<'a, T: Copy> Arena<'a, T> {
    fn block(&mut self, id: usize) -> *mut T {
        assert!(id < self.live.len());
        // Both regions are initialized and never resized; IDs address only full blocks.
        // Finalization may address dead initialized storage as a destination;
        // read/write separately require live IDs while scattering and streaming.
        unsafe {
            if id < self.scratch_blocks {
                self.scratch.as_mut_ptr().add(id * self.b)
            } else {
                self.input.add((id - self.scratch_blocks) * self.b)
            }
        }
    }
    fn read(&mut self, id: usize, offset: usize) -> T {
        assert!(offset < self.b);
        assert!(self.live[id]);
        unsafe { self.block(id).add(offset).read() }
    }
    fn write(&mut self, id: usize, offset: usize, value: T) {
        assert!(offset < self.b);
        assert!(self.live[id]);
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
    block_msd_stable_radixsort_body(arr, radix, block_size, 32)
}

/// Experimental control for testing the pure block path (leaf_limit = 0).
pub fn block_msd_stable_radixsort_body<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
    leaf_limit: usize,
) -> Stats {
    assert!(leaf_limit <= 32);
    assert!((1..=8).contains(&radix));
    assert!(block_size > 0);
    if arr.len() < 2 || std::mem::size_of::<T>() == 0 {
        return Stats::default();
    }
    let dummy = arr[0];
    let depth = (dummy.type_size() + radix - 1) / radix;
    let sigma = 1usize << radix;
    let scratch_blocks = sigma + 2 * depth + 4;
    let full = arr.len() / block_size;
    let tail = arr.len() % block_size;
    let scratch_len = scratch_blocks.checked_mul(block_size).unwrap();
    let mut arena = Arena {
        input: arr.as_mut_ptr(),
        scratch: vec![dummy; scratch_len],
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
        let mut leaf = Vec::with_capacity(size);
        for id in input.full {
            for j in 0..arena.b {
                leaf.push(arena.read(id, j));
            }
            arena.release(id);
        }
        for _ in 0..input.tail {
            leaf.push(parent_tail.read(arena));
        }
        for i in 1..leaf.len() {
            let value = leaf[i];
            let key = value.into_key_type();
            let mut j = i;
            while j > 0 && leaf[j - 1].into_key_type() > key {
                leaf[j] = leaf[j - 1];
                j -= 1;
            }
            leaf[j] = value;
        }
        for value in leaf {
            output.push(arena, value);
        }
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
        for i in 0..input.tail {
            let pos = parent_tail.cursor + i;
            include(
                arena.read(parent_tail.blocks[pos / arena.b], pos % arena.b),
            );
        }
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
            for j in 0..arena.b {
                let v = arena.read(id, j);
                output.push(arena, v);
            }
            arena.release(id);
        }
        for _ in 0..input.tail {
            let v = parent_tail.read(arena);
            output.push(arena, v);
        }
        return;
    }
    arena.stats.nodes += 1;
    let width = radix.min(bits);
    let shift = bits - width;
    let sigma = 1usize << width;
    let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
    let mut buckets: Vec<Bucket> =
        (0..sigma).map(|_| Bucket::default()).collect();
    // Reserve output heads before reading input; at most sigma active heads exist.
    let mut heads: Vec<usize> = (0..sigma).map(|_| arena.allocate()).collect();
    let scatter = |value: T,
                   arena: &mut Arena<T>,
                   buckets: &mut Vec<Bucket>,
                   heads: &mut Vec<usize>| {
        let digit = value.extract(mask, shift);
        let bucket = &mut buckets[digit];
        arena.write(heads[digit], bucket.tail, value);
        bucket.tail += 1;
        if bucket.tail == arena.b {
            bucket.full.push(heads[digit]);
            heads[digit] = arena.allocate();
            bucket.tail = 0;
        }
    };
    for id in input.full {
        for j in 0..arena.b {
            scatter(arena.read(id, j), arena, &mut buckets, &mut heads);
        }
        arena.release(id);
    }
    for _ in 0..input.tail {
        let value = parent_tail.read(arena);
        scatter(value, arena, &mut buckets, &mut heads);
    }
    let mut tails = Writer::new();
    for (bucket, head) in buckets.iter().zip(heads) {
        for j in 0..bucket.tail {
            let value = arena.read(head, j);
            tails.push(arena, value);
        }
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
                        arena.block(destination).add(j),
                        arena.block(source).add(j),
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

// SPDX-License-Identifier: BSD-2-Clause
// Adapted from Robert Clausecker's radixsort_parallel.c (2025, 2026).
// The complete BSD notice is in the parent module and LICENSE-BSD-2-Clause.

use super::{first_different_key, monotone, Bucket, Partial, Sorter};
use crate::{block_lsd_stable_radixsort, RadixKey, Radixable};
use rayon::{prelude::*, ThreadPool, ThreadPoolBuilder};
use std::{marker::PhantomData, mem::MaybeUninit, ptr};

/// Stable parallel block LSD sort, using a Rayon pool with `thread_n` workers.
/// Requires the `voracious_multithread` feature. `radix` is in 1..=8 and
/// `block_size` is a positive number of records per block.
///
/// This follows the paper's parallel C implementation: scatter is parallel;
/// block redistribution, directory fixup and final compaction are sequential.
/// With p active input segments and sigma = 2^radix, extra storage is
/// O(size_of::<T>() * p * sigma * block_size + n / block_size + p * sigma).
/// Thus fixed p, radix and record size permit O(sqrt(n)) extra space with
/// block_size proportional to sqrt(n). Equal converted radix keys remain stable.
///
/// A pool is created for each call. Repeated callers can avoid this cost using
/// [`block_lsd_stable_mt_radixsort_in_pool`]. Panics on invalid parameters,
/// unrepresentable allocation/block counts, or failure to build the pool.
pub fn block_lsd_stable_mt_radixsort<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
    thread_n: usize,
) {
    assert!((1..=8).contains(&radix), "radix must be in 1..=8");
    assert!(block_size > 0, "block_size must be positive");
    assert!(thread_n > 0, "thread_n must be positive");
    let pool = ThreadPoolBuilder::new()
        .num_threads(thread_n)
        .build()
        .expect("could not build Rayon pool");
    block_lsd_stable_mt_radixsort_in_pool(arr, radix, block_size, &pool);
}

/// Stable parallel block LSD sort using an existing Rayon pool.
///
/// Sorting uses at most pool.current_num_threads() logical input segments,
/// capped by ceil(n / block_size) to avoid more segments than input blocks.
/// Rayon may schedule a segment on any worker; stability follows segment order,
/// independently of scheduling. The pool is reusable and is not modified.
/// See [`block_lsd_stable_mt_radixsort`] for the space bound and parameters.
pub fn block_lsd_stable_mt_radixsort_in_pool<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
    pool: &ThreadPool,
) {
    assert!((1..=8).contains(&radix), "radix must be in 1..=8");
    assert!(block_size > 0, "block_size must be positive");
    pool.install(|| sort::<T, K>(arr, radix, block_size));
}

fn sort<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
) {
    if arr.len() <= 128 || std::mem::size_of::<T>() == 0 {
        block_lsd_stable_radixsort(arr, radix, block_size);
        return;
    }
    let range = 1usize << radix;
    let input_blocks =
        arr.len() / block_size + usize::from(arr.len() % block_size != 0);
    let segments = rayon::current_num_threads().min(input_blocks);
    let scratch_blocks = 2usize
        .checked_mul(range)
        .and_then(|x| x.checked_mul(segments))
        .expect("scratch block count overflow");
    let scratch_len =
        scratch_blocks.checked_mul(block_size).expect("scratch size overflow");
    assert!(
        scratch_len
            .checked_mul(std::mem::size_of::<T>())
            .map_or(false, |bytes| bytes <= isize::MAX as usize),
        "scratch allocation too large"
    );
    let dummy = arr[0];
    let first = dummy.into_key_type();
    let different = match first_different_key::<T, K>(&arr[1..], first) {
        Some(key) => key,
        None => return,
    };
    let descending = different < first;
    let (ordered, equal) = if descending {
        monotone::<T, K, true>(arr)
    } else {
        monotone::<T, K, false>(arr)
    };
    if ordered {
        if descending {
            arr.reverse();
            if equal {
                let mut start = 0;
                while start < arr.len() {
                    let key = arr[start].into_key_type();
                    let mut end = start + 1;
                    while end < arr.len() && arr[end].into_key_type() == key {
                        end += 1;
                    }
                    arr[start..end].reverse();
                    start = end;
                }
            }
        }
        return;
    }
    let (union, intersection) = arr
        .par_iter()
        .map(|item| {
            let key = item.into_key_type();
            (key, key)
        })
        .reduce_with(|(mut a, b), (c, d)| {
            a |= c;
            (a, b & d)
        })
        .unwrap();
    let bits = dummy.type_size();
    let levels = super::compute_max_level(bits, 0, radix);
    let mut sorter =
        new_sorter(arr, range, block_size, scratch_blocks, scratch_len);
    for level in 0..levels {
        let shift = level * radix;
        let mask = dummy.default_mask(radix.min(bits - shift))
            << dummy.usize_to_keytype(shift);
        if union & mask != intersection & mask {
            parallel_step::<T, K>(&mut sorter, segments, mask, shift);
        }
    }
    // Parallel fixup stores allocated logical blocks at index zero.
    sorter.compact(0);
}

fn new_sorter<T: Copy>(
    arr: &mut [T],
    range: usize,
    block_size: usize,
    scratch_blocks: usize,
    scratch_len: usize,
) -> Sorter<'_, T> {
    let full = arr.len() / block_size;
    let blocks =
        full.checked_add(scratch_blocks).expect("block count overflow");
    assert!(blocks <= u32::MAX as usize, "block indices exceed u32");
    let tail = arr.len() % block_size;
    let fill = full + usize::from(tail != 0);
    let mut scratch = vec![MaybeUninit::<T>::uninit(); scratch_len];
    let mut perm = Vec::with_capacity(blocks);
    perm.extend((0..full).map(|i| (scratch_blocks + i) as u32));
    if tail != 0 {
        // SAFETY: both ranges contain tail initialized/input or scratch slots,
        // allocations are distinct, and tail is less than one block.
        unsafe {
            ptr::copy_nonoverlapping(
                arr.as_ptr().add(full * block_size),
                scratch.as_mut_ptr().cast::<T>(),
                tail,
            );
        }
        perm.push(0);
    }
    perm.extend((usize::from(tail != 0)..scratch_blocks).map(|i| i as u32));
    let partials = vec![Partial {
        index: fill - 1,
        length: if tail == 0 { block_size } else { tail },
    }];
    let scratch_base = scratch.as_mut_ptr().cast();
    Sorter {
        block_size,
        radix_range: range,
        scratch_blocks,
        length: arr.len(),
        records: arr.as_mut_ptr(),
        _borrow: PhantomData,
        _scratch: scratch,
        scratch_base,
        perm,
        perm2: vec![0; blocks],
        usage: vec![0; blocks],
        partials,
        fill,
    }
}

#[derive(Clone, Copy)]
struct Arena<T> {
    records: *mut T,
    scratch: *mut T,
    scratch_blocks: usize,
    blocks: usize,
    block_size: usize,
}
impl<T> Arena<T> {
    fn block(&self, physical: usize) -> *mut T {
        assert!(physical < self.blocks);
        // SAFETY: each ID is a full allocated scratch or input block. The
        // owner holds the mutable input borrow and allocations never resize.
        unsafe {
            if physical < self.scratch_blocks {
                self.scratch.add(physical * self.block_size)
            } else {
                self.records
                    .add((physical - self.scratch_blocks) * self.block_size)
            }
        }
    }
}

struct Worker<'a, T> {
    arena: Arena<T>,
    permutation: &'a [u32],
    usage: &'a mut [u8],
    partials: &'a [Partial],
    start: usize,
    input_end: usize,
    output_end: usize,
    buckets: Vec<Bucket<T>>,
    counts: Vec<usize>,
}
// SAFETY: distribute_work partitions a bijective physical-block permutation.
// Each worker exclusively owns every physical ID in its slice, including free
// head-start blocks. Recycling stays within that slice and never writes unread
// input. Only that worker accesses its bucket pointers. Input T values may move
// between threads (T: Send), and the borrowed input outlives the Rayon join.
// Raw arena addresses are not themselves permission to access another slice.
unsafe impl<T: Send> Send for Worker<'_, T> {}

impl<T: Copy> Worker<'_, T> {
    fn scatter<K: RadixKey>(
        &mut self,
        mask: <<T as Radixable<K>>::Key as RadixKey>::Key,
        shift: usize,
    ) where
        T: Radixable<K>,
    {
        macro_rules! at { ($($s:literal),*) => { match shift {
            $($s => self.scatter_at::<K, $s>(mask, shift),)*
            _ => self.scatter_at::<K, {usize::MAX}>(mask, shift),
        } } }
        at!(0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120);
    }
    fn scatter_at<K: RadixKey, const SHIFT: usize>(
        &mut self,
        mask: <<T as Radixable<K>>::Key as RadixKey>::Key,
        shift: usize,
    ) where
        T: Radixable<K>,
    {
        let range = self.buckets.len();
        for b in 0..range {
            let base = self.arena.block(self.permutation[b] as usize);
            // SAFETY: the exclusively owned head-start block has block_size slots.
            self.buckets[b] = Bucket {
                next: base,
                end: unsafe { base.add(self.arena.block_size) },
            };
            self.usage[b] = b as u8;
        }
        let mut output = range;
        let mut partial = 0;
        for input in range..self.input_end {
            let source = self.arena.block(self.permutation[input] as usize);
            let length = if self
                .partials
                .get(partial)
                .map_or(false, |p| p.index == self.start + input)
            {
                let len = self.partials[partial].length;
                partial += 1;
                len
            } else {
                self.arena.block_size
            };
            for j in 0..length {
                // SAFETY: only the initialized source prefix is read.
                let value = unsafe { source.add(j).read() };
                let b = value.extract(
                    mask,
                    if SHIFT == usize::MAX { shift } else { SHIFT },
                );
                let bucket = &mut self.buckets[b]; // checked safe-trait bucket
                let next = bucket.next;
                let end = bucket.end;
                // SAFETY: initial blocks are free. Each rollover reserves at
                // most floor(processed / block_size) recycled input blocks.
                // Equality output==input occurs only after its final read; the
                // newly reserved block is written on the next record.
                let next = unsafe {
                    ptr::copy(source.add(j), next, 1);
                    next.add(1)
                };
                bucket.next = next;
                if next == end {
                    assert!(output <= input, "cannot recycle unread input");
                    let base =
                        self.arena.block(self.permutation[output] as usize);
                    *bucket = Bucket {
                        next: base,
                        end: unsafe { base.add(self.arena.block_size) },
                    };
                    self.usage[output] = b as u8;
                    self.counts[b] += 1;
                    output += 1;
                }
            }
        }
        self.output_end = output;
    }
}

fn parallel_step<T: Radixable<K>, K: RadixKey>(
    sorter: &mut Sorter<'_, T>,
    segments: usize,
    mask: <<T as Radixable<K>>::Key as RadixKey>::Key,
    shift: usize,
) {
    let range = sorter.radix_range;
    let blocks = sorter.perm.len();
    assert!(blocks - sorter.fill >= range * segments);
    // Redistribute whole blocks in logical input order. Quotas count live
    // records, so partial-heavy/skewed passes retain approximately equal work.
    let mut plans = Vec::with_capacity(segments);
    let (mut input, mut output, mut partial, mut processed) = (0, 0, 0, 0);
    for t in 0..segments {
        let start = output;
        let partial_start = partial;
        sorter.perm2[output..output + range].copy_from_slice(
            &sorter.perm
                [sorter.fill + t * range..sorter.fill + (t + 1) * range],
        );
        output += range;
        let quota = (t + 1) * (sorter.length / segments)
            + (t + 1).min(sorter.length % segments);
        while input < sorter.fill && (t == segments - 1 || processed < quota) {
            let len = if partial < sorter.partials.len()
                && sorter.partials[partial].index == input
            {
                sorter.partials[partial].index = output;
                let len = sorter.partials[partial].length;
                partial += 1;
                len
            } else {
                sorter.block_size
            };
            processed += len;
            sorter.perm2[output] = sorter.perm[input];
            output += 1;
            input += 1;
        }
        plans.push((start, output, partial_start, partial));
    }
    assert_eq!(processed, sorter.length);
    assert_eq!(input, sorter.fill);
    assert_eq!(partial, sorter.partials.len());
    sorter.perm2[output..].copy_from_slice(&sorter.perm[output..]);
    let arena = Arena {
        records: sorter.records,
        scratch: sorter.scratch_base,
        scratch_blocks: sorter.scratch_blocks,
        blocks,
        block_size: sorter.block_size,
    };
    let mut workers = Vec::with_capacity(segments);
    let mut usage = &mut sorter.usage[..];
    for t in 0..segments {
        let (start, end, first_partial, last_partial) = plans[t];
        let limit = if t + 1 < segments { plans[t + 1].0 } else { blocks };
        let (local_usage, rest) = usage.split_at_mut(limit - start);
        usage = rest;
        workers.push(Worker {
            arena,
            permutation: &sorter.perm2[start..limit],
            usage: local_usage,
            partials: &sorter.partials[first_partial..last_partial],
            start,
            input_end: end - start,
            output_end: 0,
            buckets: vec![
                Bucket { next: ptr::null_mut(), end: ptr::null_mut() };
                range
            ],
            counts: vec![1; range],
        });
    }
    workers.par_iter_mut().for_each(|worker| worker.scatter::<K>(mask, shift));
    // Rayon joins before any physical block can transfer to a new worker.
    // Concatenate equal-digit output in original segment order for stability.
    let mut starts = vec![0; range];
    let mut fill = 0;
    for b in 0..range {
        starts[b] = fill;
        fill += workers.iter().map(|worker| worker.counts[b]).sum::<usize>();
    }
    let mut free = fill;
    let mut partials =
        vec![Partial { index: usize::MAX, length: 0 }; range * segments];
    for (t, worker) in workers.iter().enumerate() {
        for j in 0..worker.output_end {
            let b = worker.usage[j] as usize;
            let index = starts[b];
            starts[b] += 1;
            let physical = worker.permutation[j];
            sorter.perm[index] = physical;
            let base = arena.block(physical as usize);
            // SAFETY: the cursor and base refer to one full, exclusively owned block.
            if unsafe { base.add(sorter.block_size) } == worker.buckets[b].end {
                partials[b * segments + t] = Partial {
                    index,
                    length: unsafe {
                        worker.buckets[b].next.offset_from(base) as usize
                    },
                };
            }
        }
        let unused = &worker.permutation[worker.output_end..];
        sorter.perm[free..free + unused.len()].copy_from_slice(unused);
        free += unused.len();
    }
    assert_eq!(free, blocks);
    assert!(blocks - fill >= range * segments);
    drop(workers);
    partials.retain(|p| p.index != usize::MAX);
    sorter.partials = partials;
    sorter.fill = fill;
    #[cfg(debug_assertions)]
    {
        let mut seen = vec![false; blocks];
        for &physical in &sorter.perm {
            assert!(!seen[physical as usize]);
            seen[physical as usize] = true;
        }
        assert!(sorter.partials.windows(2).all(|p| p[0].index < p[1].index));
        assert_eq!(
            sorter.fill * sorter.block_size
                - sorter
                    .partials
                    .iter()
                    .map(|p| sorter.block_size - p.length)
                    .sum::<usize>(),
            sorter.length
        );
    }
}

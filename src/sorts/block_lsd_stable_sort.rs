// SPDX-License-Identifier: BSD-2-Clause
// Copyright (c) 2025, 2026 Robert Clausecker <clausecker@zib.de>
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
// IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
// TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
// LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

//! Stable block LSD radix sort adapted from Robert Clausecker's
//! BSD-2-Clause C implementation, `radixsort_permuted.c`.
//! Reference revision: f69e816c3cd79d312cd67aea5b9cf1c338c1b371.
//! <https://github.com/clausecker/radsort/blob/f69e816c3cd79d312cd67aea5b9cf1c338c1b371/radixsort_permuted.c>
//! <https://arxiv.org/abs/2607.05302>

use super::super::{RadixKey, Radixable};
use super::utils::compute_max_level;
use std::{marker::PhantomData, mem::MaybeUninit, ptr};

type SortKey<T, K> = <<T as Radixable<K>>::Key as RadixKey>::Key;

/// # Block LSD stable sort
///
/// Sort by converted radix key, preserving the order of equal keys.
/// `radix` is the number of bits per digit (1..=8). The block size is chosen
/// from the input length and element size; 8 bits per digit is recommended.
///
/// For n elements of s bytes and R = 2^radix buckets, the block size in elements
/// is `max(1, ceil(4 * sqrt(9*n / (2*R*s))), floor(1024/s))`. This balances the
/// block scratch and descriptor storage with an approximately 1 KiB block
/// floor. The coefficient is tuned for radix 8, not proven optimal.
///
/// This single-threaded sort uses O(sqrt(n)) auxiliary space for fixed radix
/// and record size. Inputs of at most 128 elements use stable comparison
/// sorting. Larger nonconstant inputs use the block backend; constant digits
/// are skipped.
///
/// # Panics
///
/// Panics on invalid parameters or unrepresentable allocation sizes or block
/// indices. Custom key extraction must produce a bucket within the digit range.
///
/// # Example
///
/// ```
/// use voracious_radix_sort::block_lsd_stable_radixsort;
/// let mut arr = [42u32, 7, 42, 0, u32::MAX];
/// block_lsd_stable_radixsort(&mut arr, 8);
/// assert_eq!(arr, [0, 7, 42, 42, u32::MAX]);
/// ```
pub fn block_lsd_stable_radixsort<T, K>(arr: &mut [T], radix: usize)
where
    T: Radixable<K>,
    K: RadixKey,
{
    assert!((1..=8).contains(&radix), "radix must be in 1..=8");
    let record_bytes = std::mem::size_of::<T>();
    if arr.len() < 2 || record_bytes == 0 {
        return;
    }
    if arr.len() <= 128 {
        arr.sort_by_key(|item| item.into_key_type());
        return;
    }
    let range = 1usize << radix;
    // With b elements per block, scratch costs 2*R*b*s bytes. The two u32
    // permutation tables and u8 bucket IDs cost about 9*n/b bytes. Their sum
    // is minimized at b = sqrt(9*n / (2*R*s)). Convert before multiplying to
    // avoid overflowing usize on large slices.
    let descriptor_bytes = 9.0 * arr.len() as f64;
    let scratch_bytes_per_element = 2.0 * range as f64 * record_bytes as f64;
    let balanced = (descriptor_bytes / scratch_bytes_per_element).sqrt();
    // The factor 4 trades more scratch for fewer descriptors; it was tuned at
    // radix 8. The approximately 1 KiB floor limits rollover on small inputs;
    // records larger than that still need at least one element per block.
    let scaled = (4.0 * balanced).ceil() as usize;
    let block_size = scaled.max(1024 / record_bytes).max(1);
    block_lsd_stable_radixsort_aux(arr, radix, block_size);
}

fn block_lsd_stable_radixsort_aux<T, K>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
) where
    T: Radixable<K>,
    K: RadixKey,
{
    let (union, intersection) = varying_key_bits::<T, K>(arr);
    if union == intersection {
        return;
    }
    let dummy = arr[0];
    let bits = dummy.type_size();
    let range = 1usize << radix;
    let levels = compute_max_level(bits, 0, radix);
    let mut sorter = Sorter::new(arr, range, block_size);
    for level in 0..levels {
        let shift = level * radix;
        let width = radix.min(bits - shift);
        let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
        if union & mask != intersection & mask {
            sorter.step::<K>(mask, shift);
        }
    }
    sorter.compact();
}

fn varying_key_bits<T: Radixable<K>, K: RadixKey>(
    arr: &[T],
) -> (SortKey<T, K>, SortKey<T, K>) {
    let dummy = arr[0];
    // A bit varies iff the union and intersection of all converted keys differ
    // at that bit. This uses the existing key operations without adding a
    // BitXor bound to RadixKey, and skips constant digits without histograms.
    let mut union = dummy.into_key_type();
    let mut intersection = union;
    let bits = dummy.type_size();
    let zero = dummy.default_key();
    let mut full_mask = zero;
    // Build the complete key mask in bytes, including keys wider than usize.
    for shift in (0..bits).step_by(8) {
        full_mask |= dummy.default_mask(8.min(bits - shift))
            << dummy.usize_to_keytype(shift);
    }
    // Check a bounded prefix first. Saturation proves the remaining keys cannot
    // change a digit; otherwise keep one uninterrupted, vectorizable scan.
    let boundary = arr.len().min(1025);
    for item in &arr[1..boundary] {
        let key = item.into_key_type();
        union |= key;
        intersection = intersection & key;
    }
    if union != full_mask || intersection != zero {
        for item in &arr[boundary..] {
            let key = item.into_key_type();
            union |= key;
            intersection = intersection & key;
        }
    }
    (union, intersection)
}

#[derive(Clone, Copy)]
struct PartialBlock {
    order_index: usize,
    // Only this prefix contains initialized records.
    len: usize,
}

#[derive(Clone, Copy)]
struct BucketWriter<T> {
    next: *mut T,
    end: *mut T,
}

// Owns scratch and retains the exclusive input borrow. Physical block IDs name
// scratch first, then full input blocks. Allocations stay fixed during sorting.
struct BlockStorage<'a, T> {
    input: *mut T,
    input_len: usize,
    block_size: usize,
    scratch_blocks: usize,
    block_count: usize,
    scratch: Vec<MaybeUninit<T>>,
    input_borrow: PhantomData<&'a mut [T]>,
}

impl<'a, T: Copy> BlockStorage<'a, T> {
    fn new(input: &'a mut [T], bucket_count: usize, block_size: usize) -> Self {
        let scratch_blocks = 2 * bucket_count;
        let full_blocks = input.len() / block_size;
        let block_count = full_blocks
            .checked_add(scratch_blocks)
            .expect("block count overflow");
        assert!(block_count <= u32::MAX as usize);
        let scratch_len = scratch_blocks
            .checked_mul(block_size)
            .expect("scratch size overflow");
        let mut scratch = vec![MaybeUninit::<T>::uninit(); scratch_len];
        // The input tail has no full physical block. Start it in scratch;
        // the first bucket_count scratch blocks remain free for output.
        let tail_len = input.len() % block_size;
        // SAFETY: the source has tail_len initialized records and the disjoint
        // scratch destination has room for at least that many records.
        unsafe {
            ptr::copy_nonoverlapping(
                input.as_ptr().add(full_blocks * block_size),
                scratch.as_mut_ptr().cast::<T>().add(bucket_count * block_size),
                tail_len,
            );
        }
        Self {
            input: input.as_mut_ptr(),
            input_len: input.len(),
            block_size,
            scratch_blocks,
            block_count,
            scratch,
            input_borrow: PhantomData,
        }
    }

    fn block_ptr(&mut self, physical: usize) -> *mut T {
        assert!(physical < self.block_count);
        // SAFETY: the bounds check selects a full block in one of the two
        // allocations, which stay alive and are never resized during sorting.
        unsafe {
            if physical < self.scratch_blocks {
                self.scratch
                    .as_mut_ptr()
                    .cast::<T>()
                    .add(physical * self.block_size)
            } else {
                self.input
                    .add((physical - self.scratch_blocks) * self.block_size)
            }
        }
    }
}

// At pass boundaries, block_order maps logical order to physical storage.
// Its bucket_count..active_blocks_end range holds the current record sequence;
// the prefix and suffix are free blocks. partial_blocks records short prefixes.
struct Sorter<'a, T> {
    blocks: BlockStorage<'a, T>,
    bucket_count: usize,
    block_order: Vec<u32>,
    next_block_order: Vec<u32>,
    // Bucket IDs for output blocks, used to build next_block_order after scatter.
    bucket_ids: Vec<u8>,
    partial_blocks: Vec<PartialBlock>,
    active_blocks_end: usize,
}

impl<'a, T: Copy> Sorter<'a, T> {
    fn new(input: &'a mut [T], bucket_count: usize, block_size: usize) -> Self {
        let full_blocks = input.len() / block_size;
        let tail_len = input.len() % block_size;
        let blocks = BlockStorage::new(input, bucket_count, block_size);
        let active_blocks_end = bucket_count + full_blocks + 1;
        let mut block_order = vec![0; blocks.block_count];
        for (i, block) in block_order.iter_mut().enumerate() {
            *block = if i < bucket_count {
                i
            } else if i < active_blocks_end - 1 {
                i + bucket_count
            } else {
                i - (active_blocks_end - 1) + bucket_count
            } as u32;
        }
        let mut partial_blocks =
            vec![
                PartialBlock { order_index: blocks.block_count, len: 0 };
                bucket_count
            ];
        partial_blocks[0] =
            PartialBlock { order_index: active_blocks_end - 1, len: tail_len };
        let block_count = blocks.block_count;
        Self {
            blocks,
            bucket_count,
            block_order,
            next_block_order: vec![0; block_count],
            bucket_ids: vec![0; block_count],
            partial_blocks,
            active_blocks_end,
        }
    }

    fn next_block_len(&self, logical: usize, partial: &mut usize) -> usize {
        if *partial < self.partial_blocks.len()
            && self.partial_blocks[*partial].order_index == logical
        {
            let length = self.partial_blocks[*partial].len;
            *partial += 1;
            length
        } else {
            self.blocks.block_size
        }
    }

    #[cfg(debug_assertions)]
    fn validate(&self) {
        let mut seen = vec![false; self.block_order.len()];
        for &physical in &self.block_order {
            assert!(!seen[physical as usize]);
            seen[physical as usize] = true;
        }
        assert!(self.active_blocks_end <= self.block_order.len());
        assert!(self
            .partial_blocks
            .windows(2)
            .all(|p| p[0].order_index < p[1].order_index));
        assert!(self
            .partial_blocks
            .iter()
            .all(|p| p.order_index >= self.bucket_count
                && p.order_index < self.active_blocks_end
                && p.len < self.blocks.block_size));
        let mut partial = 0;
        let total: usize = (self.bucket_count..self.active_blocks_end)
            .map(|i| self.next_block_len(i, &mut partial))
            .sum();
        assert_eq!(total, self.blocks.input_len);
    }

    fn step<K: RadixKey>(&mut self, mask: SortKey<T, K>, shift: usize)
    where
        T: Radixable<K>,
    {
        let mut buckets = vec![
            BucketWriter::<T> {
                next: ptr::null_mut(),
                end: ptr::null_mut()
            };
            self.bucket_count
        ];
        let mut counts = vec![1_usize; self.bucket_count];
        for (i, bucket) in buckets.iter_mut().enumerate() {
            let out = self.blocks.block_ptr(self.block_order[i] as usize);
            // SAFETY: block_ptr() returns storage for block_size elements.
            *bucket = BucketWriter {
                next: out,
                end: unsafe { out.add(self.blocks.block_size) },
            };
            self.bucket_ids[i] = i as u8;
        }
        let output = self.scatter::<K>(mask, shift, &mut buckets, &mut counts);
        self.active_blocks_end = output;
        // Scatter no longer needs the counts. Convert the same allocation
        // into bucket starts, then advance these cursors while ordering blocks.
        let mut starts = counts;
        let mut start = self.bucket_count;
        for count in &mut starts {
            let next = start + *count;
            *count = start;
            start = next;
        }
        for i in 0..self.active_blocks_end {
            let b = self.bucket_ids[i] as usize;
            let j = starts[b];
            starts[b] += 1;
            self.next_block_order[j] = self.block_order[i];
            let base = self.blocks.block_ptr(self.block_order[i] as usize);
            // SAFETY: next/end belong to the same block-sized allocation.
            if unsafe { base.add(self.blocks.block_size) } == buckets[b].end {
                self.partial_blocks[b] = PartialBlock {
                    order_index: j,
                    len: unsafe { buckets[b].next.offset_from(base) as usize },
                };
            }
        }
        assert!(
            self.active_blocks_end + self.bucket_count
                <= self.block_order.len()
        );
        self.next_block_order[..self.bucket_count].copy_from_slice(
            &self.block_order[self.active_blocks_end
                ..self.active_blocks_end + self.bucket_count],
        );
        self.next_block_order[self.active_blocks_end + self.bucket_count..]
            .copy_from_slice(
                &self.block_order[self.active_blocks_end + self.bucket_count..],
            );
        self.active_blocks_end += self.bucket_count;
        std::mem::swap(&mut self.block_order, &mut self.next_block_order);
        #[cfg(debug_assertions)]
        self.validate();
    }

    // Keep this loop separate from pass setup and block reordering. Inlining
    // their combined state spills digit masks and bucket pointers in the hot loop.
    #[inline(never)]
    fn scatter<K: RadixKey>(
        &mut self,
        mask: SortKey<T, K>,
        shift: usize,
        buckets: &mut [BucketWriter<T>],
        counts: &mut [usize],
    ) -> usize
    where
        T: Radixable<K>,
    {
        let mut output = self.bucket_count;
        let mut partial = 0;
        for input in self.bucket_count..self.active_blocks_end {
            let source =
                self.blocks.block_ptr(self.block_order[input] as usize);
            let length = self.next_block_len(input, &mut partial);
            let mut write = |offset: usize| {
                // SAFETY: the grouped and remainder loops visit exactly the
                // initialized prefix. Recycling cannot overwrite an
                // unread cell.
                let value = unsafe { source.add(offset).read() };
                let b = value.extract(mask, shift);
                // SAFETY: next points to an unused cell in the output block.
                // The bucket index is bounds-checked before the pointer write.
                // An output block is recycled only after its input is consumed:
                // after J reads, at most floor(J / block_size) new blocks have
                // been reserved. Equality output == input requires consuming a
                // full input block, and the reserved block is written only on
                // the next element. See Lemma 1 of the paper.
                let bucket = &mut buckets[b];
                // Keep the destination cursor in a local: raw record stores
                // can otherwise force a reload of the bucket cursor.
                let next = bucket.next;
                let end = bucket.end;
                let next = unsafe {
                    ptr::copy(source.add(offset), next, 1);
                    next.add(1)
                };
                bucket.next = next;
                if next == end {
                    debug_assert!(output <= input);
                    let out = self
                        .blocks
                        .block_ptr(self.block_order[output] as usize);
                    *bucket = BucketWriter {
                        next: out,
                        end: unsafe { out.add(self.blocks.block_size) },
                    };
                    self.bucket_ids[output] = b as u8;
                    counts[b] += 1;
                    output += 1;
                }
            };
            // Bound expansion by copy volume: at most four records and four
            // machine words. The group size is constant after monomorphization.
            let group = (4 * std::mem::size_of::<usize>()
                / std::mem::size_of::<T>().max(1))
            .clamp(1, 4);
            let complete = length - length % group;
            for start in (0..complete).step_by(group) {
                for offset in 0..group {
                    write(start + offset);
                }
            }
            for offset in complete..length {
                write(offset);
            }
        }
        output
    }

    fn compact(mut self) {
        // Sorting is finished. Reuse the output buffer as the inverse map:
        // physical block ID -> position in block_order.
        let mut block_positions = std::mem::take(&mut self.next_block_order);
        for i in 0..self.block_order.len() {
            block_positions[self.block_order[i] as usize] = i as u32;
        }
        let mut start = 0;
        let mut partial = 0;
        let mut free_logical = 0;
        let mut free_physical = self.block_order[free_logical] as usize;
        for destination in self.blocks.scratch_blocks..self.block_order.len() {
            let input = destination - self.bucket_count;
            let mut output = block_positions[destination] as usize;
            let source = self.block_order[input] as usize;
            if output > input && output < self.active_blocks_end {
                debug_assert!(
                    free_logical < self.bucket_count
                        || free_logical >= self.active_blocks_end
                );
                let from = self.blocks.block_ptr(destination);
                let to = self.blocks.block_ptr(free_physical);
                // SAFETY: both physical IDs are valid full blocks. Free block
                // receives live output which would otherwise be overwritten.
                // ptr::copy preserves uninitialized padding without reading it
                // as T; later element reads use only the live prefix.
                unsafe {
                    ptr::copy(from, to, self.blocks.block_size);
                }
                self.block_order[free_logical] = destination as u32;
                self.block_order[output] = free_physical as u32;
                block_positions[free_physical] = output as u32;
                block_positions[destination] = free_logical as u32;
                free_logical = output;
                output = block_positions[destination] as usize;
            }
            let length = self.next_block_len(input, &mut partial);
            let from = self.blocks.block_ptr(source);
            assert!(start + length <= self.blocks.input_len);
            // Completed partials can only shorten preceding output: start <=
            // (destination - scratch_blocks) * block_size, and
            // start + length never exceeds this destination block's end.
            // Any still-live destination block was evacuated above; earlier
            // physical destinations are already consumed.
            // SAFETY: length valid source elements are moved into the next
            // logical output interval. ptr::copy permits overlap as memmove.
            unsafe {
                ptr::copy(from, self.blocks.input.add(start), length);
            }
            self.block_order[input] = destination as u32;
            self.block_order[output] = source as u32;
            block_positions[source] = output as u32;
            block_positions[destination] = input as u32;
            start += length;
            if input != output {
                free_physical = source;
                free_logical = output;
            }
        }
        for input in
            self.block_order.len() - self.bucket_count..self.active_blocks_end
        {
            let source = self.block_order[input] as usize;
            assert!(source < self.blocks.scratch_blocks);
            let length = self.next_block_len(input, &mut partial);
            let from = self.blocks.block_ptr(source);
            assert!(start + length <= self.blocks.input_len);
            unsafe {
                ptr::copy(from, self.blocks.input.add(start), length);
            }
            start += length;
        }
        assert_eq!(start, self.blocks.input_len);
    }
}

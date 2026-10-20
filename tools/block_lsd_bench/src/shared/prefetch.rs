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

//! Stable block LSD radix sort adapted from Clausecker's `radixsort_permuted.c`.
//! Reference revision: f69e816c3cd79d312cd67aea5b9cf1c338c1b371.
//! <https://github.com/clausecker/radsort>
//! <https://arxiv.org/abs/2607.05302>

use super::super::{RadixKey, Radixable};
use super::utils::{compute_max_level, get_full_histograms, Params};
use std::{marker::PhantomData, mem::MaybeUninit, ptr};

/// Sort an array stably by its converted radix key using block LSD radix sort.
/// Equal converted keys retain their incoming order.
///
/// `radix` is the number of bits per digit (1 through 8); `block_size` is
/// the number of elements per block and must be positive. For example, 8 and
/// 512 match the parameters of the original C implementation. All key bits
/// are sorted using the same key conversion as the other radix sorts. Constant
/// digits are skipped; an array of identical converted keys needs no scratch.
///
/// This is a single-threaded sort. It uses `2 * 2^radix * block_size` elements
/// of scratch storage and nine bytes per block (including scratch blocks),
/// plus O(2^radix) bookkeeping. A full scatter buffer is used only when its
/// total requested heap fits in the block scratch budget. Arrays up to 128
/// elements use stable converted-key comparison sorting. With fixed
/// radix, choosing block_size proportional to sqrt(n) gives O(sqrt(n)) extra
/// space; a fixed block size gives O(n / block_size) metadata instead.
///
/// # Panics
///
/// Panics if radix is outside 1..=8, block_size is zero, or the required block
/// indices or allocation sizes cannot be represented. As with the other radix
/// sorts, custom key extraction must produce a bucket within the digit range.
///
/// # Example
///
/// ```
/// use voracious_radix_sort::block_lsd_stable_radixsort;
/// let mut arr = [42u32, 7, 42, 0, u32::MAX];
/// block_lsd_stable_radixsort(&mut arr, 8, 512);
/// assert_eq!(arr, [0, 7, 42, 42, u32::MAX]);
/// ```
pub fn block_lsd_stable_radixsort<T, K, const PREFETCH: usize>(
    arr: &mut [T],
    radix: usize,
    block_size: usize,
) where
    T: Radixable<K>,
    K: RadixKey,
{
    assert!((1..=8).contains(&radix), "radix must be in 1..=8");
    assert!(block_size > 0, "block_size must be positive");
    // Zero-sized elements have no distinguishable stored values. Avoid pointer
    // differences on them, which are undefined for zero-sized types.
    if arr.len() < 2 || std::mem::size_of::<T>() == 0 {
        return;
    }
    let range = 1usize << radix;
    let scratch_len = range
        .checked_mul(2)
        .and_then(|blocks| blocks.checked_mul(block_size))
        .expect("scratch size overflow");
    let scratch_bytes = scratch_len
        .checked_mul(std::mem::size_of::<T>())
        .expect("scratch allocation size overflow");
    assert!(
        scratch_bytes <= isize::MAX as usize,
        "scratch allocation too large"
    );
    // A fixed small leaf uses the same converted-key order as every radix pass.
    // Stable comparison sorting avoids setting up hundreds of empty buckets.
    if arr.len() <= 128 {
        arr.sort_by_key(|item| item.into_key_type());
        return;
    }
    let first_key = arr[0].into_key_type();
    let first_different =
        match first_different_key::<T, K>(&arr[1..], first_key) {
            Some(key) => key,
            None => return,
        };
    let descending = first_different < first_key;
    let (ordered, has_equal_keys) = if descending {
        monotone::<T, K, true>(arr)
    } else {
        monotone::<T, K, false>(arr)
    };
    if ordered && !descending {
        return;
    }
    if ordered {
        // Reversal also reverses each equal-key group. Reverse those groups
        // again to retain their original payload order.
        arr.reverse();
        if !has_equal_keys {
            return;
        }
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
        return;
    }
    let dummy = arr[0];
    // A bit varies iff the union and intersection of all converted keys differ
    // at that bit. This uses the existing key operations without adding a
    // BitXor bound to RadixKey, and skips constant digits without histograms.
    let mut union = dummy.into_key_type();
    let mut intersection = union;
    for item in &arr[1..] {
        let key = item.into_key_type();
        union |= key;
        intersection = intersection & key;
    }
    if union == intersection {
        return;
    }
    let bits = dummy.type_size();
    let mut levels = compute_max_level(bits, 0, radix);
    // Constant high digits cannot affect the result. Trim them before sizing
    // and building the fused histogram, even for a nonzero common prefix.
    while levels > 0 {
        let shift = (levels - 1) * radix;
        let width = radix.min(bits - shift);
        let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
        if union & mask != intersection & mask {
            break;
        }
        levels -= 1;
    }
    if levels == 0 {
        return;
    }
    // The ordinary scatter path is admissible only when its complete requested
    // heap fits within the block scratch budget. This inequality preserves the
    // block algorithm's space bound and uses no type or workload tuning table.
    // get_full_histograms grows its outer Vec geometrically. Reserve the
    // final capacity and a conservative allowance for a realloc's old storage.
    let histogram_bytes = levels
        .checked_mul(range * std::mem::size_of::<usize>())
        .and_then(|bytes| {
            bytes.checked_add(
                levels
                    .max(4)
                    .checked_next_power_of_two()?
                    .checked_mul(3 * std::mem::size_of::<Vec<usize>>())?,
            )
        });
    let scatter_bytes = arr
        .len()
        .checked_mul(std::mem::size_of::<T>())
        .and_then(|bytes| bytes.checked_add(histogram_bytes?))
        .and_then(|bytes| {
            bytes.checked_add(2 * range * std::mem::size_of::<usize>())
        });
    // The repository's fused histogram kernel supports at most 16 digits.
    if levels <= 16
        && scatter_bytes.map_or(false, |bytes| bytes <= scratch_bytes)
    {
        bounded_scatter::<T, K>(arr, radix, levels, union, intersection);
        return;
    }
    let mut sorter = Sorter::new(arr, range, block_size);
    for level in 0..levels {
        let shift = level * radix;
        let width = radix.min(bits - shift);
        let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
        if union & mask != intersection & mask {
            sorter.step::<K, PREFETCH>(mask, shift);
        }
    }
    sorter.compact();
}

fn first_different_key<T: Radixable<K>, K: RadixKey>(
    arr: &[T],
    first: <<T as Radixable<K>>::Key as RadixKey>::Key,
) -> Option<<<T as Radixable<K>>::Key as RadixKey>::Key> {
    let mut chunks = arr.chunks_exact(4);
    for chunk in &mut chunks {
        let mut equal = true;
        for offset in 0..4 {
            equal &= chunk[offset].into_key_type() == first;
        }
        if !equal {
            return chunk
                .iter()
                .map(|item| item.into_key_type())
                .find(|&key| key != first);
        }
    }
    chunks
        .remainder()
        .iter()
        .map(|item| item.into_key_type())
        .find(|&key| key != first)
}

// Check independent adjacent pairs in fixed groups. This avoids a serial
// previous-key dependency, and needs equality tracking only for descending runs.
fn monotone<T: Radixable<K>, K: RadixKey, const DESCENDING: bool>(
    arr: &[T],
) -> (bool, bool) {
    let pairs = arr.len() - 1;
    let complete = pairs - pairs % 4;
    let mut left_chunks = arr[..pairs].chunks_exact(4);
    let right_chunks = arr[1..].chunks_exact(4);
    let mut has_equal_keys = false;
    for (left, right) in left_chunks.by_ref().zip(right_chunks) {
        let mut ordered = true;
        for offset in 0..4 {
            let left = left[offset].into_key_type();
            let right = right[offset].into_key_type();
            ordered &= if DESCENDING { left >= right } else { left <= right };
            if DESCENDING {
                has_equal_keys |= left == right;
            }
        }
        if !ordered {
            return (false, false);
        }
    }
    for pair in arr[complete..].windows(2) {
        let left = pair[0].into_key_type();
        let right = pair[1].into_key_type();
        if if DESCENDING { left < right } else { left > right } {
            return (false, false);
        }
        if DESCENDING {
            has_equal_keys |= left == right;
        }
    }
    (true, has_equal_keys)
}

// Stable ping-pong scatter. Every raw write stays within the allocation;
// completed cursors are validated before its output can become a source.
// Even inconsistent custom extraction cannot expose an uninitialized T.
fn bounded_scatter<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
    levels: usize,
    union: <<T as Radixable<K>>::Key as RadixKey>::Key,
    intersection: <<T as Radixable<K>>::Key as RadixKey>::Key,
) {
    let dummy = arr[0];
    let range = 1usize << radix;
    let histograms =
        get_full_histograms::<T, K>(arr, &Params::new(0, radix, 0, levels));
    let mut heads = vec![0usize; range];
    let mut ends = vec![0usize; range];
    let mut scratch = vec![MaybeUninit::<T>::uninit(); arr.len()];
    let input = arr.as_mut_ptr();
    let buffer = scratch.as_mut_ptr().cast::<T>();
    let mut in_buffer = false;
    for level in 0..levels {
        let shift = level * radix;
        let width = radix.min(dummy.type_size() - shift);
        let mask = dummy.default_mask(width) << dummy.usize_to_keytype(shift);
        if union & mask == intersection & mask {
            continue;
        }
        let mut offset = 0usize;
        for (bucket, &count) in
            histograms[levels - level - 1].iter().enumerate()
        {
            heads[bucket] = offset;
            offset += count;
            ends[bucket] = offset;
        }
        assert_eq!(offset, arr.len());
        let (source, destination) =
            if in_buffer { (buffer, input) } else { (input, buffer) };
        // SAFETY: input is initialized. The buffer becomes a source only
        // after a complete scatter has filled every bucket interval.
        let source = unsafe { std::slice::from_raw_parts(source, arr.len()) };
        let mut write = |value: &T| {
            let bucket = value.extract(mask, shift);
            let head = &mut heads[bucket];
            let position = *head;
            assert!(position < arr.len(), "inconsistent radix extraction");
            // SAFETY: the source is initialized and the destination is an
            // in-bounds slot in a disjoint allocation. It is not read yet.
            unsafe {
                ptr::copy_nonoverlapping(value, destination.add(position), 1);
            }
            *head = position + 1;
        };
        let mut chunks = source.chunks_exact(4);
        for chunk in &mut chunks {
            // The fixed range lets the compiler expand this small loop while
            // keeping one expression for checked bucket/cursor handling.
            for offset in 0..4 {
                write(&chunk[offset]);
            }
        }
        for value in chunks.remainder() {
            write(value);
        }
        // Each cursor started at its bucket prefix and advanced monotonically.
        // Matching every end proves exactly one write to every disjoint slot,
        // even if a custom extract is inconsistent between counting/scattering.
        assert_eq!(heads, ends, "inconsistent radix extraction");
        in_buffer = !in_buffer;
    }
    if in_buffer {
        // SAFETY: the last completed pass initialized every buffer element.
        unsafe {
            ptr::copy_nonoverlapping(buffer, input, arr.len());
        }
    }
}

#[derive(Clone, Copy)]
struct Partial {
    index: usize,
    length: usize,
}
#[derive(Clone, Copy)]
struct Bucket<T> {
    next: *mut T,
    end: *mut T,
}
struct Sorter<'a, T> {
    block_size: usize,
    radix_range: usize,
    scratch_blocks: usize,
    records: *mut T,
    length: usize,
    _borrow: PhantomData<&'a mut [T]>,
    _scratch: Vec<MaybeUninit<T>>,
    scratch_base: *mut T,
    perm: Vec<u32>,
    perm2: Vec<u32>,
    usage: Vec<u8>,
    partials: Vec<Partial>,
    fill: usize,
}
impl<'a, T: Copy> Sorter<'a, T> {
    fn new(
        records: &'a mut [T],
        radix_range: usize,
        block_size: usize,
    ) -> Self {
        let scratch_blocks = 2 * radix_range;
        let full = records.len() / block_size;
        let blocks =
            full.checked_add(scratch_blocks).expect("block count overflow");
        assert!(blocks <= u32::MAX as usize);
        let fill = radix_range + full + 1;
        let mut perm = vec![0; blocks];
        for (i, p) in perm.iter_mut().enumerate() {
            *p = if i < radix_range {
                i
            } else if i < fill - 1 {
                i + radix_range
            } else {
                i - (fill - 1) + radix_range
            } as u32;
        }
        let scratch_len = scratch_blocks
            .checked_mul(block_size)
            .expect("scratch size overflow");
        // Only live block prefixes hold T values. Padding is copied as raw
        // storage during evacuation, and is never read as an element.
        let mut scratch = vec![MaybeUninit::<T>::uninit(); scratch_len];
        let tail = records.len() % block_size;
        // SAFETY: the initialized input tail fits in this scratch block.
        // Every subsequent typed read is restricted to its live prefix.
        unsafe {
            ptr::copy_nonoverlapping(
                records.as_ptr().add(full * block_size),
                scratch.as_mut_ptr().cast::<T>().add(radix_range * block_size),
                tail,
            );
        }
        let mut partials =
            vec![Partial { index: blocks, length: 0 }; radix_range];
        partials[0] = Partial { index: fill - 1, length: tail };
        let length = records.len();
        let records = records.as_mut_ptr();
        let scratch_base = scratch.as_mut_ptr().cast::<T>();
        Self {
            block_size,
            radix_range,
            scratch_blocks,
            records,
            length,
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
    fn block(&mut self, physical: usize) -> *mut T {
        assert!(physical < self.perm.len());
        // SAFETY: physical IDs below scratch_blocks identify full scratch blocks.
        // Other IDs identify exactly floor(n / block_size) full input blocks.
        // Vec allocations are never resized while these pointers are in use.
        unsafe {
            if physical < self.scratch_blocks {
                self.scratch_base.add(physical * self.block_size)
            } else {
                self.records
                    .add((physical - self.scratch_blocks) * self.block_size)
            }
        }
    }
    fn length(&self, logical: usize, partial: &mut usize) -> usize {
        if *partial < self.radix_range
            && self.partials[*partial].index == logical
        {
            let length = self.partials[*partial].length;
            *partial += 1;
            length
        } else {
            self.block_size
        }
    }
    #[cfg(debug_assertions)]
    fn validate(&self) {
        let mut seen = vec![false; self.perm.len()];
        for &physical in &self.perm {
            assert!(!seen[physical as usize]);
            seen[physical as usize] = true;
        }
        assert!(self.fill <= self.perm.len());
        assert!(self.partials.windows(2).all(|p| p[0].index < p[1].index));
        assert!(self.partials.iter().all(|p| p.index >= self.radix_range
            && p.index < self.fill
            && p.length < self.block_size));
        let mut partial = 0;
        let total: usize = (self.radix_range..self.fill)
            .map(|i| self.length(i, &mut partial))
            .sum();
        assert_eq!(total, self.length);
    }
    fn step<K: RadixKey, const PREFETCH: usize>(
        &mut self,
        mask: <<T as Radixable<K>>::Key as RadixKey>::Key,
        shift: usize,
    ) where
        T: Radixable<K>,
    {
        let mut buckets =
            vec![
                Bucket::<T> { next: ptr::null_mut(), end: ptr::null_mut() };
                self.radix_range
            ];
        let mut counts = vec![1_usize; self.radix_range];
        for (i, bucket) in buckets.iter_mut().enumerate() {
            let out = self.block(self.perm[i] as usize);
            // SAFETY: block() returns storage for block_size elements.
            *bucket =
                Bucket { next: out, end: unsafe { out.add(self.block_size) } };
            self.usage[i] = i as u8;
        }
        // Constant byte shifts avoid double-word variable shifts for wide keys.
        // Other digit widths retain the generic path.
        let output = match shift {
            0 => self.scatter::<K, PREFETCH, 0>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            8 => self.scatter::<K, PREFETCH, 8>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            16 => self.scatter::<K, PREFETCH, 16>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            24 => self.scatter::<K, PREFETCH, 24>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            32 => self.scatter::<K, PREFETCH, 32>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            40 => self.scatter::<K, PREFETCH, 40>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            48 => self.scatter::<K, PREFETCH, 48>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            56 => self.scatter::<K, PREFETCH, 56>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            64 => self.scatter::<K, PREFETCH, 64>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            72 => self.scatter::<K, PREFETCH, 72>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            80 => self.scatter::<K, PREFETCH, 80>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            88 => self.scatter::<K, PREFETCH, 88>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            96 => self.scatter::<K, PREFETCH, 96>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            104 => self.scatter::<K, PREFETCH, 104>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            112 => self.scatter::<K, PREFETCH, 112>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            120 => self.scatter::<K, PREFETCH, 120>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
            _ => self.scatter::<K, PREFETCH, { usize::MAX }>(
                mask,
                shift,
                &mut buckets,
                &mut counts,
            ),
        };
        self.fill = output;
        let mut starts = vec![self.radix_range; self.radix_range];
        for b in 1..self.radix_range {
            starts[b] = starts[b - 1] + counts[b - 1];
        }
        for i in 0..self.fill {
            let b = self.usage[i] as usize;
            let j = starts[b];
            starts[b] += 1;
            self.perm2[j] = self.perm[i];
            let base = self.block(self.perm[i] as usize);
            // SAFETY: next/end belong to the same block-sized allocation.
            if unsafe { base.add(self.block_size) } == buckets[b].end {
                self.partials[b] = Partial {
                    index: j,
                    length: unsafe {
                        buckets[b].next.offset_from(base) as usize
                    },
                };
            }
        }
        assert!(self.fill + self.radix_range <= self.perm.len());
        self.perm2[..self.radix_range].copy_from_slice(
            &self.perm[self.fill..self.fill + self.radix_range],
        );
        self.perm2[self.fill + self.radix_range..]
            .copy_from_slice(&self.perm[self.fill + self.radix_range..]);
        self.fill += self.radix_range;
        std::mem::swap(&mut self.perm, &mut self.perm2);
        #[cfg(debug_assertions)]
        self.validate();
    }
    fn scatter<K: RadixKey, const PREFETCH: usize, const SHIFT: usize>(
        &mut self,
        mask: <<T as Radixable<K>>::Key as RadixKey>::Key,
        shift: usize,
        buckets: &mut [Bucket<T>],
        counts: &mut [usize],
    ) -> usize
    where
        T: Radixable<K>,
    {
        let mut output = self.radix_range;
        let mut partial = 0;
        for input in self.radix_range..self.fill {
            let source = self.block(self.perm[input] as usize);
            let length = self.length(input, &mut partial);
            for j in 0..length {
                // SAFETY: source is a valid block, length <= block_size. The stable
                // logical input traversal consumes each element exactly once.
                let value = unsafe { source.add(j).read() };
                let b = value.extract(
                    mask,
                    if SHIFT == usize::MAX { shift } else { SHIFT },
                );
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
                    ptr::copy(source.add(j), next, 1);
                    next.add(1)
                };
                // Experimental fixed-byte destination prefetch. wrapping_add
                // can form an address outside the allocation; PREFETCHT0 is a
                // nonfaulting hint and never reads a T through that address.
                #[cfg(target_arch = "x86_64")]
                unsafe {
                    std::arch::x86_64::_mm_prefetch(
                        next.cast::<i8>().wrapping_add(PREFETCH),
                        std::arch::x86_64::_MM_HINT_T0,
                    );
                }
                bucket.next = next;
                if next == end {
                    debug_assert!(output <= input);
                    let out = self.block(self.perm[output] as usize);
                    *bucket = Bucket {
                        next: out,
                        end: unsafe { out.add(self.block_size) },
                    };
                    self.usage[output] = b as u8;
                    counts[b] += 1;
                    output += 1;
                }
            }
        }
        output
    }
    fn compact(&mut self) {
        for i in 0..self.perm.len() {
            self.perm2[self.perm[i] as usize] = i as u32;
        }
        let mut start = 0;
        let mut partial = 0;
        let mut free_logical = 0;
        let mut free_physical = self.perm[0] as usize;
        for destination in self.scratch_blocks..self.perm.len() {
            let input = destination - self.radix_range;
            let mut output = self.perm2[destination] as usize;
            let source = self.perm[input] as usize;
            if output > input && output < self.fill {
                debug_assert!(
                    free_logical < self.radix_range
                        || free_logical >= self.fill
                );
                let from = self.block(destination);
                let to = self.block(free_physical);
                // SAFETY: both physical IDs are valid full blocks. Free block
                // receives live output which would otherwise be overwritten.
                // ptr::copy preserves uninitialized padding without reading it
                // as T; later element reads use only the live prefix.
                unsafe {
                    ptr::copy(from, to, self.block_size);
                }
                self.perm[free_logical] = destination as u32;
                self.perm[output] = free_physical as u32;
                self.perm2[free_physical] = output as u32;
                self.perm2[destination] = free_logical as u32;
                free_logical = output;
                output = self.perm2[destination] as usize;
            }
            let length = self.length(input, &mut partial);
            let from = self.block(source);
            assert!(start + length <= self.length);
            // Completed partials can only shorten preceding output: start <=
            // (destination - self.scratch_blocks) * self.block_size, and start + length never exceeds
            // this destination block's end. Any still-live destination block was
            // evacuated above; earlier physical destinations are already consumed.
            // SAFETY: length valid source elements are moved into the next
            // logical output interval. ptr::copy permits overlap as memmove.
            unsafe {
                ptr::copy(from, self.records.add(start), length);
            }
            self.perm[input] = destination as u32;
            self.perm[output] = source as u32;
            self.perm2[source] = output as u32;
            self.perm2[destination] = input as u32;
            start += length;
            if input != output {
                free_physical = source;
                free_logical = output;
            }
        }
        for input in self.perm.len() - self.radix_range..self.fill {
            let source = self.perm[input] as usize;
            assert!(source < self.scratch_blocks);
            let length = self.length(input, &mut partial);
            let from = self.block(source);
            assert!(start + length <= self.length);
            unsafe {
                ptr::copy(from, self.records.add(start), length);
            }
            start += length;
        }
        assert_eq!(start, self.length);
    }
}

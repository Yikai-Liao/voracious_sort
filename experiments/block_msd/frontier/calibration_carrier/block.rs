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

//! Experiment copy of submitted_lsd::Sorter. Only digit extraction is generalized;
//! the allocation, scatter, fixup and compact protocol is retained.
use std::{marker::PhantomData, mem::MaybeUninit, ptr};
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
pub(super) struct Sorter<'a, T> {
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
    pub(super) compact_records: usize,
    pub(super) tail_records: usize,
}
impl<'a, T: Copy> Sorter<'a, T> {
    pub(super) fn new(
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
            compact_records: 0,
            tail_records: tail,
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
        if *partial < self.partials.len()
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
    pub(super) fn step<F: Fn(&T) -> usize>(&mut self, digit: &F) {
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
        let output = self.scatter(digit, &mut buckets, &mut counts);
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
    fn scatter<F: Fn(&T) -> usize>(
        &mut self,
        digit: &F,
        buckets: &mut [Bucket<T>],
        counts: &mut [usize],
    ) -> usize {
        let mut output = self.radix_range;
        let mut partial = 0;
        for input in self.radix_range..self.fill {
            let source = self.block(self.perm[input] as usize);
            let length = self.length(input, &mut partial);
            let mut write = |offset: usize| {
                // SAFETY: the grouped and remainder loops visit exactly the
                // initialized prefix. Recycling cannot overwrite an unread cell.
                let value = unsafe { source.add(offset).read() };
                let b = digit(&value);
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
                    let out = self.block(self.perm[output] as usize);
                    *bucket = Bucket {
                        next: out,
                        end: unsafe { out.add(self.block_size) },
                    };
                    self.usage[output] = b as u8;
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
    pub(super) fn compact(&mut self) {
        for i in 0..self.perm.len() {
            self.perm2[self.perm[i] as usize] = i as u32;
        }
        let mut start = 0;
        let mut partial = 0;
        let mut free_logical = 0;
        let mut free_physical = self.perm[free_logical] as usize;
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
                    super::work! { self.compact_records += self.block_size; }
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
                super::work! { self.compact_records += length; }
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
                super::work! { self.compact_records += length; }
            }
            start += length;
        }
        assert_eq!(start, self.length);
    }
}

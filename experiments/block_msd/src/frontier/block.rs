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
#[derive(Clone, Copy)]
enum BinaryGroup {
    Single,
    Arithmetic,
    Lookup,
}

// For each four-bit bucket pattern, pack the selected-bucket offsets of
// records 1, 2 and 3 into three bytes, followed by the total high-bucket count.
// Record 0 always has offset zero. This is 64 bytes of immutable static data.
const BINARY_GROUP_POSITIONS: [u32; 16] = {
    let mut positions = [0; 16];
    let mut pattern = 0;
    while pattern < 16 {
        let mut highs = 0;
        let mut record = 0;
        let mut packed = 0;
        while record < 4 {
            let high = (pattern >> record) & 1;
            let offset = if high != 0 { highs } else { record - highs };
            if record != 0 {
                packed |= (offset as u32) << ((record - 1) * 8);
            }
            highs += high;
            record += 1;
        }
        positions[pattern] = packed | ((highs as u32) << 24);
        pattern += 1;
    }
    positions
};
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
    #[cfg_attr(not(feature = "frontier_work"), allow(dead_code))]
    pub(super) compact_records: usize,
    #[cfg_attr(not(feature = "frontier_work"), allow(dead_code))]
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
    pub(super) fn step<U: super::NativeKey, F: Fn(&T) -> U>(
        &mut self,
        label: &F,
        byte: usize,
    ) {
        self.step_impl(label, byte, 0, BinaryGroup::Single);
    }
    /// All varying digit bits are covered by this one-bit mask. Other digit
    /// bits must be constant; the ordinary bucket table and workspace remain.
    pub(super) fn step_binary<U: super::NativeKey, F: Fn(&T) -> U>(
        &mut self,
        label: &F,
        byte: usize,
        varying_bit: u8,
    ) {
        assert!(varying_bit.is_power_of_two());
        self.step_impl(label, byte, varying_bit, BinaryGroup::Single);
    }
    pub(super) fn step_binary_batched<U: super::NativeKey, F: Fn(&T) -> U>(
        &mut self,
        label: &F,
        byte: usize,
        varying_bit: u8,
    ) {
        assert!(varying_bit.is_power_of_two() && byte < 16);
        self.step_impl(label, byte, varying_bit, BinaryGroup::Arithmetic);
    }
    pub(super) fn step_binary_lookup<U: super::NativeKey, F: Fn(&T) -> U>(
        &mut self,
        label: &F,
        byte: usize,
        varying_bit: u8,
    ) {
        assert!(varying_bit.is_power_of_two() && byte < 16);
        self.step_impl(label, byte, varying_bit, BinaryGroup::Lookup);
    }
    fn step_impl<U: super::NativeKey, F: Fn(&T) -> U>(
        &mut self,
        label: &F,
        byte: usize,
        varying_bit: u8,
        group: BinaryGroup,
    ) {
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
        // Match the submitted backend's constant-byte extraction for wide keys.
        // The classifier is fixed across every byte in this macro node.
        macro_rules! pass {
            ($i:literal) => {
                if varying_bit != 0
                    && std::mem::size_of::<T>() <= std::mem::size_of::<usize>()
                {
                    self.scatter_binary::<U, F, $i>(
                        label,
                        varying_bit,
                        &mut buckets,
                        &mut counts,
                    )
                } else {
                    self.scatter::<U, F, $i>(label, &mut buckets, &mut counts)
                }
            };
        }
        let output = if !matches!(group, BinaryGroup::Single)
            && std::mem::size_of::<T>() <= std::mem::size_of::<usize>()
        {
            match group {
                BinaryGroup::Arithmetic => self
                    .scatter_binary_batched::<U, F, false>(
                        label,
                        byte,
                        varying_bit,
                        &mut buckets,
                        &mut counts,
                    ),
                BinaryGroup::Lookup => self
                    .scatter_binary_batched::<U, F, true>(
                        label,
                        byte,
                        varying_bit,
                        &mut buckets,
                        &mut counts,
                    ),
                BinaryGroup::Single => unreachable!(),
            }
        } else {
            match byte {
                0 => pass!(0),
                1 => pass!(1),
                2 => pass!(2),
                3 => pass!(3),
                4 => pass!(4),
                5 => pass!(5),
                6 => pass!(6),
                7 => pass!(7),
                8 => pass!(8),
                9 => pass!(9),
                10 => pass!(10),
                11 => pass!(11),
                12 => pass!(12),
                13 => pass!(13),
                14 => pass!(14),
                15 => pass!(15),
                _ => unreachable!("key wider than 128 bits"),
            }
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
    fn scatter<U: super::NativeKey, F: Fn(&T) -> U, const BYTE: usize>(
        &mut self,
        label: &F,
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
                let b = label(&value).byte(BYTE);
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
    // Compile the additional loop separately from the constant-byte dispatch.
    #[inline(never)]
    fn scatter_binary<
        U: super::NativeKey,
        F: Fn(&T) -> U,
        const BYTE: usize,
    >(
        &mut self,
        label: &F,
        varying_bit: u8,
        buckets: &mut [Bucket<T>],
        counts: &mut [usize],
    ) -> usize {
        let mut first_digit = None;
        let mut partial = 0;
        for input in self.radix_range..self.fill {
            if self.length(input, &mut partial) != 0 {
                let source = self.block(self.perm[input] as usize);
                // SAFETY: this logical block has an initialized first cell.
                first_digit = Some(label(unsafe { &*source }).byte(BYTE));
                break;
            }
        }
        let Some(first_digit) = first_digit else {
            return self.radix_range;
        };
        let bit = usize::from(varying_bit);
        let low = first_digit & !bit;
        let high = low | bit;
        let Bucket { next: mut next_low, end: mut end_low } = buckets[low];
        let Bucket { next: mut next_high, end: mut end_high } = buckets[high];
        let mut output = self.radix_range;
        let mut partial = 0;
        for input in self.radix_range..self.fill {
            let source = self.block(self.perm[input] as usize);
            let length = self.length(input, &mut partial);
            let mut write = |offset: usize| {
                // SAFETY: the loops visit only initialized input cells. Cursor
                // reservations and recycling retain the original record order
                // and destinations, so scatter's overwrite bound still holds.
                let value = unsafe { source.add(offset).read() };
                let is_high = label(&value).byte(BYTE) & bit != 0;
                let destination = if is_high { next_high } else { next_low };
                let end = if is_high { end_high } else { end_low };
                // SAFETY: each cursor is advanced and refilled immediately;
                // destination points to one unused cell of its output block.
                let next = unsafe {
                    destination.write(value);
                    destination.add(1)
                };
                next_low = if is_high { next_low } else { next };
                next_high = if is_high { next } else { next_high };
                if next == end {
                    debug_assert!(output <= input);
                    let out = self.block(self.perm[output] as usize);
                    let end = unsafe { out.add(self.block_size) };
                    let b = if is_high { high } else { low };
                    if is_high {
                        next_high = out;
                        end_high = end;
                    } else {
                        next_low = out;
                        end_low = end;
                    }
                    self.usage[output] = b as u8;
                    counts[b] += 1;
                    output += 1;
                }
            };
            let complete = length - length % 4;
            for start in (0..complete).step_by(4) {
                write(start);
                write(start + 1);
                write(start + 2);
                write(start + 3);
            }
            for offset in complete..length {
                write(offset);
            }
        }
        // Step's fixup reads these final cursors to identify the partial blocks.
        buckets[low] = Bucket { next: next_low, end: end_low };
        buckets[high] = Bucket { next: next_high, end: end_high };
        output
    }
    // The native-key bit mask is prepared once. This loop needs no const-byte
    // specialization. Only the arithmetic and lookup group calculations differ.
    #[inline(never)]
    fn scatter_binary_batched<
        U: super::NativeKey,
        F: Fn(&T) -> U,
        const LOOKUP: bool,
    >(
        &mut self,
        label: &F,
        byte: usize,
        varying_bit: u8,
        buckets: &mut [Bucket<T>],
        counts: &mut [usize],
    ) -> usize {
        let mut first_digit = None;
        let mut partial = 0;
        for input in self.radix_range..self.fill {
            if self.length(input, &mut partial) != 0 {
                let source = self.block(self.perm[input] as usize);
                // SAFETY: the selected logical block has a live first cell.
                first_digit = Some(label(unsafe { &*source }).byte(byte));
                break;
            }
        }
        let Some(first_digit) = first_digit else {
            return self.radix_range;
        };
        let bit = usize::from(varying_bit);
        let key_bit = U::from_u128(u128::from(varying_bit) << (byte * 8));
        let zero = U::from_u128(0);
        let low = first_digit & !bit;
        let high = low | bit;
        let mut next_low = buckets[low].next;
        let mut next_high = buckets[high].next;
        // Step initializes every bucket to a fresh full-sized output block.
        let mut left_low = self.block_size;
        let mut left_high = self.block_size;
        let mut output = self.radix_range;
        let mut partial = 0;
        for input in self.radix_range..self.fill {
            let source = self.block(self.perm[input] as usize);
            let length = self.length(input, &mut partial);
            macro_rules! scalar {
                ($offset:expr) => {{
                    let offset = $offset;
                    // SAFETY: only the initialized prefix is visited, with the
                    // original record order and immediate per-record refill.
                    let value = unsafe { source.add(offset).read() };
                    let is_high = label(&value) & key_bit != zero;
                    let destination =
                        if is_high { next_high } else { next_low };
                    let left = if is_high { left_high } else { left_low } - 1;
                    let next = unsafe {
                        destination.write(value);
                        destination.add(1)
                    };
                    next_low = if is_high { next_low } else { next };
                    next_high = if is_high { next } else { next_high };
                    left_low = if is_high { left_low } else { left };
                    left_high = if is_high { left } else { left_high };
                    if left == 0 {
                        debug_assert!(output <= input);
                        let out = self.block(self.perm[output] as usize);
                        let b = if is_high { high } else { low };
                        if is_high {
                            next_high = out;
                            left_high = self.block_size;
                        } else {
                            next_low = out;
                            left_low = self.block_size;
                        }
                        self.usage[output] = b as u8;
                        counts[b] += 1;
                        output += 1;
                    }
                }};
            }
            let complete = length - length % 4;
            for start in (0..complete).step_by(4) {
                if left_low > 4 && left_high > 4 {
                    // SAFETY: all four source cells are live. Both outputs have
                    // room beyond this group, so no block can be recycled here.
                    let [h0, h1, h2, h3] = unsafe {
                        [
                            label(&*source.add(start)) & key_bit != zero,
                            label(&*source.add(start + 1)) & key_bit != zero,
                            label(&*source.add(start + 2)) & key_bit != zero,
                            label(&*source.add(start + 3)) & key_bit != zero,
                        ]
                    };
                    let highs = if LOOKUP {
                        let pattern = usize::from(h0)
                            | (usize::from(h1) << 1)
                            | (usize::from(h2) << 2)
                            | (usize::from(h3) << 3);
                        let packed = BINARY_GROUP_POSITIONS[pattern];
                        macro_rules! copy_position {
                            ($i:literal, $is_high:expr, $offset:expr) => {{
                                let base = if $is_high { next_high } else { next_low };
                                // SAFETY: the table stores precisely the selected
                                // bucket's preceding-record count. As in the
                                // arithmetic control, destinations match scalar
                                // writes with no refill and preserve unread input.
                                unsafe {
                                    ptr::copy(source.add(start + $i), base.add($offset), 1);
                                }
                            }};
                        }
                        copy_position!(0, h0, 0);
                        copy_position!(1, h1, (packed & 255) as usize);
                        copy_position!(2, h2, ((packed >> 8) & 255) as usize);
                        copy_position!(3, h3, ((packed >> 16) & 255) as usize);
                        (packed >> 24) as usize
                    } else {
                        let mut highs = 0;
                        macro_rules! copy {
                        ($i:literal, $is_high:expr) => {{
                            let is_high = $is_high;
                            let base = if is_high { next_high } else { next_low };
                            let offset = if is_high { highs } else { $i - highs };
                            // SAFETY: prefix counts reserve distinct cells in
                            // original order within each bucket. These are the
                            // same addresses as four scalar writes with no refill;
                            // the original overwrite bound preserves later input.
                            unsafe {
                                ptr::copy(source.add(start + $i), base.add(offset), 1);
                            }
                            highs += usize::from(is_high);
                        }};
                        }
                        copy!(0, h0);
                        copy!(1, h1);
                        copy!(2, h2);
                        copy!(3, h3);
                        highs
                    };
                    let lows = 4 - highs;
                    // SAFETY: both remaining capacities were strictly above 4.
                    unsafe {
                        next_low = next_low.add(lows);
                        next_high = next_high.add(highs);
                    }
                    left_low -= lows;
                    left_high -= highs;
                } else {
                    scalar!(start);
                    scalar!(start + 1);
                    scalar!(start + 2);
                    scalar!(start + 3);
                }
            }
            for offset in complete..length {
                scalar!(offset);
            }
        }
        // SAFETY: remaining capacity ends at the current physical block's end.
        buckets[low] =
            Bucket { next: next_low, end: unsafe { next_low.add(left_low) } };
        buckets[high] = Bucket {
            next: next_high,
            end: unsafe { next_high.add(left_high) },
        };
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

#[cfg(test)]
mod tests {
    use super::Sorter;
    use crate::frontier::NativeKey;
    use std::{cell::RefCell, fmt::Debug};

    #[derive(Clone, Copy, Debug, PartialEq, Eq)]
    #[repr(C)]
    struct Record8 {
        key: u16,
        payload: u16,
        id: u32,
    }

    #[derive(Clone, Copy, Debug, PartialEq, Eq)]
    struct WideRecord {
        key: u16,
        id: u32,
        payload: [u8; 24],
    }

    fn check_variants<T: Copy + Debug + Eq, U: NativeKey, F: Fn(&T) -> U>(
        input: &[T],
        label: F,
        bytes: &[usize],
        radix: usize,
        block: usize,
    ) {
        let mut expected = input.to_vec();
        expected.sort_by_key(&label);
        let mut original_work = None;
        for variant in 0..4 {
            let mut actual = input.to_vec();
            let trace = RefCell::new(Vec::new());
            let counted_label = |record: &T| {
                trace.borrow_mut().push(*record);
                label(record)
            };
            let mut logical_order = input.to_vec();
            let mut sorter = Sorter::new(&mut actual, radix, block);
            for &byte in bytes {
                trace.borrow_mut().clear();
                let variation = logical_order.first().map_or(0, |first| {
                    logical_order
                        .iter()
                        .fold(U::from_u128(0), |mut mask, item| {
                            mask |= label(item) ^ label(first);
                            mask
                        })
                        .byte(byte)
                });
                // A conservative one-bit mask also covers a constant digit.
                let varying_bit = if variation == 0 { 1 } else { variation };
                let binary = variant != 0 && varying_bit.is_power_of_two();
                let mut expected_trace = Vec::new();
                if binary
                    && std::mem::size_of::<T>() <= std::mem::size_of::<usize>()
                {
                    expected_trace.extend(logical_order.first().copied());
                }
                expected_trace.extend_from_slice(&logical_order);
                if binary && variant == 3 {
                    sorter.step_binary_lookup(
                        &counted_label,
                        byte,
                        varying_bit as u8,
                    );
                } else if binary && variant == 2 {
                    sorter.step_binary_batched(
                        &counted_label,
                        byte,
                        varying_bit as u8,
                    );
                } else if binary {
                    sorter.step_binary(&counted_label, byte, varying_bit as u8);
                } else {
                    sorter.step(&counted_label, byte);
                }
                // The binary loop probes the first live record once, then visits
                // all live records in the same logical order as the original.
                assert_eq!(
                    *trace.borrow(), expected_trace,
                    "label order: variant {variant}, radix {radix}, block {block}, byte {byte}"
                );
                logical_order.sort_by_key(|record| label(record).byte(byte));
            }
            sorter.compact();
            let work = (sorter.compact_records, sorter.tail_records);
            assert_eq!(sorter.tail_records, input.len() % block);
            drop(sorter);
            assert_eq!(
                actual, expected,
                "stable records: variant {variant}, radix {radix}, block {block}"
            );
            if let Some(original) = original_work {
                assert_eq!(
                    work, original,
                    "compact/tail work: variant {variant}, radix {radix}, block {block}"
                );
            } else {
                original_work = Some(work);
            }
        }
    }

    fn key(id: usize, radix: usize) -> u16 {
        // Irregular labels exercise all four-record prefix counts and refill
        // positions; the benchmark uses its separately seeded shuffled input.
        let mut x = (id as u64).wrapping_add(0x9e3779b97f4a7c15);
        x = (x ^ (x >> 30)).wrapping_mul(0xbf58476d1ce4e5b9);
        x = (x ^ (x >> 27)).wrapping_mul(0x94d049bb133111eb);
        x ^= x >> 31;
        let y = x >> 17;
        if radix == 2 {
            (x as u16 & 1) | ((y as u16 & 1) << 8)
        } else {
            // Nonzero constant bits and a different varying bit in each byte.
            (0x42 | ((x as u16 & 1) << 3))
                | ((0xa0 | ((y as u16 & 1) << 1)) << 8)
        }
    }

    #[test]
    fn binary_scatter_preserves_narrow_records_and_work() {
        assert_eq!(std::mem::size_of::<Record8>(), 8);
        for block in [3usize, 17, 64] {
            let mut lengths = vec![0, 1, 2, 3, 4, 63, 64, 65, 257, 4097];
            lengths.extend([block - 1, block, block + 1]);
            lengths.sort_unstable();
            lengths.dedup();
            for radix in [2, 256] {
                for &length in &lengths {
                    let keys: Vec<u16> =
                        (0..length).rev().map(|id| key(id, radix)).collect();
                    let bytes: Vec<u8> =
                        keys.iter().map(|&key| key as u8).collect();
                    check_variants(&bytes, |&key| key, &[0], radix, block);
                    check_variants(&keys, |&key| key, &[0, 1], radix, block);
                    let records: Vec<Record8> = keys
                        .iter()
                        .enumerate()
                        .map(|(id, &key)| Record8 {
                            key,
                            payload: (id as u16).wrapping_mul(31337),
                            id: id as u32,
                        })
                        .collect();
                    check_variants(
                        &records,
                        |record| record.key,
                        &[0, 1],
                        radix,
                        block,
                    );
                }
            }
            // The lookup backend prepares a native bit mask outside the loop;
            // cover the highest u64 bit as well as low-byte binary labels.
            let keys: Vec<u64> = (0..4097)
                .map(|id| {
                    let bits = key(id, 2);
                    0x4222_2222_2222_2242
                        | (u64::from(bits & 1) << 63)
                        | (u64::from((bits >> 8) & 1) << 3)
                })
                .collect();
            check_variants(&keys, |&key| key, &[0, 7], 256, block);
        }
    }

    #[test]
    fn binary_scatter_preserves_constant_buckets_all_tails_and_wide_payloads() {
        for block in [3usize, 17, 64] {
            for radix in [2, 256] {
                for tail in 0..block {
                    let records: Vec<Record8> = (0..2 * block + tail)
                        .rev()
                        .map(|id| Record8 {
                            key: 0x0101,
                            payload: (id as u16).wrapping_mul(31337),
                            id: id as u32,
                        })
                        .collect();
                    check_variants(
                        &records,
                        |record| record.key,
                        &[0, 1],
                        radix,
                        block,
                    );
                }
                let wide: Vec<WideRecord> = (0..257usize)
                    .rev()
                    .map(|id| WideRecord {
                        key: key(id, radix),
                        id: id as u32,
                        payload: std::array::from_fn(|offset| {
                            (id.wrapping_mul(31) ^ offset.wrapping_mul(17))
                                as u8
                        }),
                    })
                    .collect();
                check_variants(
                    &wide,
                    |record| record.key,
                    &[0, 1],
                    radix,
                    block,
                );
            }
        }
    }
}

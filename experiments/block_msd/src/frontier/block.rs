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
        self.step_impl(label, byte, false);
    }
    pub(super) fn step_reserved<U: super::NativeKey, F: Fn(&T) -> U>(
        &mut self,
        label: &F,
        byte: usize,
    ) {
        self.step_impl(label, byte, true);
    }
    fn step_impl<U: super::NativeKey, F: Fn(&T) -> U>(
        &mut self,
        label: &F,
        byte: usize,
        reserved: bool,
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
                if reserved
                    && std::mem::size_of::<T>() <= std::mem::size_of::<usize>()
                {
                    self.scatter_reserved::<U, F, $i>(
                        label,
                        &mut buckets,
                        &mut counts,
                    )
                } else {
                    self.scatter::<U, F, $i>(label, &mut buckets, &mut counts)
                }
            };
        }
        let output = match byte {
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
    // Keep this independent experiment out of the 16-way constant-byte caller.
    #[inline(never)]
    fn scatter_reserved<
        U: super::NativeKey,
        F: Fn(&T) -> U,
        const BYTE: usize,
    >(
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
            macro_rules! reserve {
                ($b:expr) => {{
                    let b = $b;
                    let bucket = &mut buckets[b];
                    let destination = bucket.next;
                    // SAFETY: the cursor has one unused cell. Reservation uses
                    // the original record order and identical block accounting.
                    bucket.next = unsafe { destination.add(1) };
                    if bucket.next == bucket.end {
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
                    destination
                }};
            }
            let complete = length - length % 4;
            for start in (0..complete).step_by(4) {
                // SAFETY: these four initialized input cells remain live while
                // only bucket/permutation metadata is updated. Delaying the
                // stores preserves the original reservation order and addresses.
                // Its recycling bound (see scatter) prevents any earlier store
                // from overwriting a later source cell, including within a group.
                let [b0, b1, b2, b3] = unsafe {
                    [
                        label(&*source.add(start)).byte(BYTE),
                        label(&*source.add(start + 1)).byte(BYTE),
                        label(&*source.add(start + 2)).byte(BYTE),
                        label(&*source.add(start + 3)).byte(BYTE),
                    ]
                };
                let d0 = reserve!(b0);
                let d1 = reserve!(b1);
                let d2 = reserve!(b2);
                let d3 = reserve!(b3);
                // SAFETY: reservations retain the original destinations and
                // store order; the source cells remain live until these copies.
                unsafe {
                    ptr::copy(source.add(start), d0, 1);
                    ptr::copy(source.add(start + 1), d1, 1);
                    ptr::copy(source.add(start + 2), d2, 1);
                    ptr::copy(source.add(start + 3), d3, 1);
                }
            }
            for offset in complete..length {
                // SAFETY: offset visits the remaining initialized prefix.
                let b = label(unsafe { &*source.add(offset) }).byte(BYTE);
                let destination = reserve!(b);
                unsafe { ptr::copy(source.add(offset), destination, 1) };
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
        for variant in 0..2 {
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
                match variant {
                    0 => sorter.step(&counted_label, byte),
                    1 => sorter.step_reserved(&counted_label, byte),
                    _ => unreachable!(),
                }
                // Every live record is visited once, in the same logical order,
                // including duplicate identities and partial-block payloads.
                assert_eq!(
                    *trace.borrow(),
                    logical_order,
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
        let digits: &[u16] =
            if radix == 2 { &[0, 1] } else { &[0, 1, 127, 255] };
        let low = digits[(id.wrapping_mul(5) ^ (id / 3)) % digits.len()];
        let high = digits[(id.wrapping_mul(7) ^ (id / 11)) % digits.len()];
        low | (high << 8)
    }

    #[test]
    fn reserved_scatter_preserves_narrow_records_and_work() {
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
        }
    }

    #[test]
    fn reserved_scatter_preserves_constant_buckets_all_tails_and_wide_payloads()
    {
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

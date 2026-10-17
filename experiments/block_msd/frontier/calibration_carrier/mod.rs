//! Serial L/H/P/F screen. No production entry point changes.
//! Each node releases its distribution workspace before visiting children.
#![cfg_attr(
    not(feature = "frontier_work"),
    allow(unused_variables, unused_mut)
)]
use std::{mem::MaybeUninit, ptr};
use voracious_radix_sort::{RadixKey, Radixable};
mod block;
#[cfg(test)]
mod tests;

type Converted<T, K> = <<T as Radixable<K>>::Key as RadixKey>::Key;

#[derive(Clone, Copy, Debug)]
pub enum Mode {
    L,
    H,
    P,
    F,
}

#[derive(Clone, Copy, Debug)]
pub struct Config {
    pub mode: Mode,
    /// Zero selects ceil(log256(node length)); otherwise fixed byte budget.
    pub bytes: usize,
    /// For same-coarse-prefix comparisons; zero uses the label-byte rule.
    pub coarse_bits: usize,
    pub block: usize,
}

#[derive(Debug)]
pub struct Work {
    pub nodes: usize,
    pub node_records: usize,
    pub prepare_records: usize,
    pub candidate_records: usize,
    pub label_records: usize,
    pub label_evals: usize,
    pub scatter_records: usize,
    pub dense_nodes: usize,
    pub block_nodes: usize,
    pub passes: usize,
    pub compact_records: usize,
    pub tail_records: usize,
    pub runs_records: usize,
    pub unresolved_records: usize,
    pub leaves: usize,
    pub leaf_records: usize,
    pub max_depth: usize,
    pub max_path_passes: usize,
    pub leaf_lengths: [usize; 129],
}

impl Default for Work {
    fn default() -> Self {
        Self {
            nodes: 0,
            node_records: 0,
            prepare_records: 0,
            candidate_records: 0,
            label_records: 0,
            label_evals: 0,
            scatter_records: 0,
            dense_nodes: 0,
            block_nodes: 0,
            passes: 0,
            compact_records: 0,
            tail_records: 0,
            runs_records: 0,
            unresolved_records: 0,
            leaves: 0,
            leaf_records: 0,
            max_depth: 0,
            max_path_passes: 0,
            leaf_lengths: [0; 129],
        }
    }
}

// Compile out all diagnostic updates from timed binaries.
macro_rules! work { ($($body:tt)*) => { #[cfg(feature="frontier_work")] { $($body)* } }; }
pub(crate) use work;

#[inline]
fn mask(bits: usize) -> u128 {
    if bits == 128 {
        u128::MAX
    } else {
        (1u128 << bits) - 1
    }
}

trait Classifier {
    fn label(&self, key: u128) -> u128;
    fn remaining(&self, key: u128) -> usize;
}

#[derive(Clone, Copy)]
struct Prefix {
    low: usize,
    width: usize,
}
impl Classifier for Prefix {
    #[inline]
    fn label(&self, key: u128) -> u128 {
        (key >> self.low) & mask(self.width)
    }
    fn remaining(&self, _: u128) -> usize {
        self.low
    }
}

struct Frontier {
    local_mask: u128,
    pivot: u128,
    low: usize,
    high: u128,
    equal: u128,
    exits: [u8; 128],
}
impl Frontier {
    fn new(pivot: u128, width: usize, coarse: usize) -> Self {
        let low = width - coarse;
        let pivot = pivot & mask(width);
        let high = pivot >> low;
        let suffix = pivot & mask(low);
        let mut exits = [0; 128];
        for b in 0..low {
            let above = (suffix >> (b + 1)).count_ones() as usize;
            exits[b] =
                (above + if (pivot >> b) & 1 == 0 { b + 1 } else { 0 }) as u8;
        }
        Self {
            local_mask: mask(width),
            pivot,
            low,
            high,
            equal: high + suffix.count_ones() as u128,
            exits,
        }
    }
}
impl Classifier for Frontier {
    #[inline]
    fn label(&self, key: u128) -> u128 {
        let key = key & self.local_mask;
        let high = key >> self.low;
        if high < self.high {
            return high;
        }
        if high > self.high {
            return high + self.low as u128;
        }
        let diff = key ^ self.pivot;
        if diff == 0 {
            self.equal
        } else {
            self.high + self.exits[127 - diff.leading_zeros() as usize] as u128
        }
    }
    fn remaining(&self, key: u128) -> usize {
        let key = key & self.local_mask;
        if key >> self.low != self.high {
            return self.low;
        }
        let diff = key ^ self.pivot;
        if diff == 0 {
            0
        } else {
            127 - diff.leading_zeros() as usize
        }
    }
}

pub fn sort<T: Radixable<K>, K: RadixKey>(arr: &mut [T], config: Config) -> Work
where
    Converted<T, K>: Into<u128>,
{
    assert!(
        config.block > 0 && config.bytes <= 16 && config.coarse_bits <= 128
    );
    let mut stats = Work::default();
    if arr.len() < 2 || std::mem::size_of::<T>() == 0 {
        return stats;
    }
    match config.mode {
        Mode::L => {
            node::<T, K, 0>(arr, arr[0].type_size(), config, &mut stats, 0, 0)
        },
        Mode::H => {
            node::<T, K, 1>(arr, arr[0].type_size(), config, &mut stats, 0, 0)
        },
        Mode::P => {
            node::<T, K, 2>(arr, arr[0].type_size(), config, &mut stats, 0, 0)
        },
        Mode::F => {
            node::<T, K, 3>(arr, arr[0].type_size(), config, &mut stats, 0, 0)
        },
    }
    stats
}

fn node<T: Radixable<K>, K: RadixKey, const MODE: u8>(
    arr: &mut [T],
    cap: usize,
    config: Config,
    stats: &mut Work,
    depth: usize,
    path: usize,
) where
    Converted<T, K>: Into<u128>,
{
    if arr.len() < 2 || cap == 0 {
        return;
    }
    work! { stats.max_depth = stats.max_depth.max(depth); }
    if arr.len() <= 128 {
        work! { stats.leaves += 1; stats.leaf_records += arr.len(); stats.leaf_lengths[arr.len()] += 1; }
        super::insertion_sort_key::<T, K>(arr);
        return;
    }
    let first: u128 = arr[0].into_key_type().into();
    let (mut union, mut intersection, mut previous, mut pivot) =
        (first, first, first, first);
    let (mut ascending, mut descending, mut votes) = (true, true, 0usize);
    // Candidate selection is fused into the same full variation/order scan.
    for item in arr.iter() {
        let key: u128 = item.into_key_type().into();
        union |= key;
        intersection &= key;
        ascending &= previous <= key;
        descending &= previous >= key;
        previous = key;
        if MODE == 3 {
            if votes == 0 {
                pivot = key;
                votes = 1;
            } else if key == pivot {
                votes += 1;
            } else {
                votes -= 1;
            }
        }
    }
    work! { stats.prepare_records += arr.len(); if MODE == 3 { stats.candidate_records += arr.len(); } }
    if ascending {
        return;
    }
    if descending {
        arr.reverse();
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
    let width =
        (128 - (union ^ intersection).leading_zeros() as usize).min(cap);
    if width == 0 {
        return;
    }
    let bytes = if config.bytes == 0 {
        ((usize::BITS as usize - (arr.len() - 1).leading_zeros() as usize) + 7)
            / 8
    } else {
        config.bytes
    };
    let coarse = if MODE == 0 {
        width
    } else if config.coarse_bits != 0 {
        width.min(config.coarse_bits)
    } else if MODE == 3 && width > 8 * bytes {
        8 * bytes - 1
    } else {
        width.min(8 * bytes)
    };
    work! { stats.nodes += 1; stats.node_records += arr.len(); }
    if MODE == 3 {
        let classifier = Frontier::new(pivot, width, coarse);
        distribute_children::<T, K, _, MODE>(
            arr,
            &classifier,
            config,
            stats,
            depth,
            path,
        );
    } else {
        let classifier = Prefix { low: width - coarse, width: coarse };
        distribute_children::<T, K, _, MODE>(
            arr,
            &classifier,
            config,
            stats,
            depth,
            path,
        );
    }
}

fn distribute_children<
    T: Radixable<K>,
    K: RadixKey,
    C: Classifier,
    const MODE: u8,
>(
    arr: &mut [T],
    classifier: &C,
    config: Config,
    stats: &mut Work,
    depth: usize,
    path: usize,
) where
    Converted<T, K>: Into<u128>,
{
    #[cfg(feature = "frontier_work")]
    let label_evals = std::cell::Cell::new(0usize);
    let label = |item: &T| {
        work! { label_evals.set(label_evals.get()+1); }
        classifier.label(item.into_key_type().into())
    };
    let passes = distribute(arr, &label, config.block, stats);
    work! { stats.max_path_passes = stats.max_path_passes.max(path+passes); }
    if MODE == 0 {
        work! { stats.label_evals += label_evals.get(); }
        return;
    }
    // distribute() owns all scratch. None survives into a recursive call.
    let mut start = 0;
    while start < arr.len() {
        let current = label(&arr[start]);
        let remaining = classifier.remaining(arr[start].into_key_type().into());
        let mut end = start + 1;
        while end < arr.len() && label(&arr[end]) == current {
            end += 1;
        }
        work! { stats.runs_records += end-start; }
        if end - start > 1 && remaining > 0 {
            work! { stats.unresolved_records += end-start; }
            if MODE == 1 {
                node::<T, K, 0>(
                    &mut arr[start..end],
                    remaining,
                    config,
                    stats,
                    depth + 1,
                    path + passes,
                );
            } else {
                node::<T, K, MODE>(
                    &mut arr[start..end],
                    remaining,
                    config,
                    stats,
                    depth + 1,
                    path + passes,
                );
            }
        }
        start = end;
    }
    work! { stats.label_evals += label_evals.get(); }
}

fn distribute<T: Copy, F: Fn(&T) -> u128>(
    arr: &mut [T],
    label: &F,
    block: usize,
    stats: &mut Work,
) -> usize {
    let first = label(&arr[0]);
    let mut variation = 0;
    for item in arr.iter() {
        variation |= label(item) ^ first;
    }
    work! { stats.label_records += arr.len(); }
    let levels = (128 - variation.leading_zeros() as usize + 7) / 8;
    if levels == 0 {
        return 0;
    }
    let passes =
        (0..levels).filter(|&i| (variation >> (8 * i)) & 255 != 0).count();
    work! { stats.passes += passes; stats.scatter_records += passes*arr.len(); }
    // Identical budget for L/H/P/F, including dense histograms and cursors.
    let dense_bytes =
        arr.len().checked_mul(std::mem::size_of::<T>()).and_then(|b| {
            b.checked_add((levels + 2) * 256 * std::mem::size_of::<usize>())
        });
    let budget = 512usize
        .checked_mul(block)
        .and_then(|n| n.checked_mul(std::mem::size_of::<T>()))
        .expect("budget overflow");
    if dense_bytes.map_or(false, |bytes| bytes <= budget) {
        work! { stats.dense_nodes += 1; }
        dense(arr, label, levels, variation, stats);
    } else {
        work! { stats.block_nodes += 1; }
        let mut sorter = block::Sorter::new(arr, 256, block);
        for i in 0..levels {
            if (variation >> (8 * i)) & 255 != 0 {
                sorter.step(&|item| ((label(item) >> (8 * i)) & 255) as usize);
            }
        }
        sorter.compact();
        work! { stats.compact_records += sorter.compact_records; stats.tail_records += sorter.tail_records; }
    }
    passes
}

fn dense<T: Copy, F: Fn(&T) -> u128>(
    arr: &mut [T],
    label: &F,
    levels: usize,
    variation: u128,
    stats: &mut Work,
) {
    let mut hist = vec![[0usize; 256]; levels];
    for item in arr.iter() {
        let key = label(item);
        for i in 0..levels {
            hist[i][((key >> (8 * i)) & 255) as usize] += 1;
        }
    }
    work! { stats.label_records += arr.len(); }
    let mut scratch = vec![MaybeUninit::<T>::uninit(); arr.len()];
    let input = arr.as_mut_ptr();
    let buffer = scratch.as_mut_ptr().cast::<T>();
    let mut in_buffer = false;
    for i in 0..levels {
        if (variation >> (8 * i)) & 255 == 0 {
            continue;
        }
        let mut heads = [0usize; 256];
        let mut ends = [0usize; 256];
        let mut offset = 0;
        for b in 0..256 {
            heads[b] = offset;
            offset += hist[i][b];
            ends[b] = offset;
        }
        let (source, destination) =
            if in_buffer { (buffer, input) } else { (input, buffer) };
        // SAFETY: the source is initialized after the preceding complete pass;
        // allocations are disjoint, every cursor stays inside its own bucket.
        for j in 0..arr.len() {
            let item = unsafe { &*source.add(j) };
            let b = ((label(item) >> (8 * i)) & 255) as usize;
            assert!(heads[b] < ends[b], "key changed during distribution");
            unsafe {
                ptr::copy_nonoverlapping(item, destination.add(heads[b]), 1);
            }
            heads[b] += 1;
        }
        assert_eq!(heads, ends, "key changed during distribution");
        in_buffer = !in_buffer;
    }
    if in_buffer {
        unsafe {
            ptr::copy_nonoverlapping(buffer, input, arr.len());
        }
        work! { stats.compact_records += arr.len(); }
    }
}

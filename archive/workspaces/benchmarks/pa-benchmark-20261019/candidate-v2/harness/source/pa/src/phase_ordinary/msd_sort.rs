use super::super::algo::k_way_merge::k_way_merge;
use super::super::algo::verge_sort_heuristic::verge_sort_preprocessing;
use super::super::{RadixKey, Radixable};
use super::utils::{get_histogram, prefix_sums, Params};

use super::phases;
use std::time::Instant;
const UNROLL_SIZE: usize = 4;

#[inline]
pub fn copy_by_histogram<T, K>(
    size: usize,
    source: &mut [T],
    destination: &mut [T],
    heads: &mut Vec<usize>,
    mask: <<T as Radixable<K>>::Key as RadixKey>::Key,
    shift: usize,
) where
    T: Radixable<K>,
    K: RadixKey,
{
    let source = &mut source[0..size];
    let remainder = size % UNROLL_SIZE;
    let (source_fst, source_snd) = source.split_at_mut(size - remainder);

    source_fst.chunks_exact(UNROLL_SIZE).for_each(|chunk| unsafe {
        let b0 = chunk.get_unchecked(0).extract(mask, shift);
        let b1 = chunk.get_unchecked(1).extract(mask, shift);
        let b2 = chunk.get_unchecked(2).extract(mask, shift);
        let b3 = chunk.get_unchecked(3).extract(mask, shift);

        let d0 = *heads.get_unchecked(b0);
        heads[b0] += 1;
        let d1 = *heads.get_unchecked(b1);
        heads[b1] += 1;
        let d2 = *heads.get_unchecked(b2);
        heads[b2] += 1;
        let d3 = *heads.get_unchecked(b3);
        heads[b3] += 1;

        destination[d0] = *chunk.get_unchecked(0);
        destination[d1] = *chunk.get_unchecked(1);
        destination[d2] = *chunk.get_unchecked(2);
        destination[d3] = *chunk.get_unchecked(3);
    });

    for item in source_snd.iter() {
        let target_bucket = item.extract(mask, shift);
        destination[heads[target_bucket]] = *item;
        heads[target_bucket] += 1;
    }
}

pub fn msd_radixsort_rec<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    p: Params,
) {
    if arr.len() <= 128 {
        phases::with(|phase| phase.leaf_lengths[arr.len()] += 1);
        let phase_start = Instant::now();
        arr.sort_unstable_by(|a, b| a.partial_cmp(b).unwrap());
        phases::with(|phase| {
            phase.leaf_sort_ns += phase_start.elapsed().as_nanos()
        });
        return;
    }

    let dummy = arr[0];
    // Exact trait mask formula with this module's copied private Params type.
    let mask = dummy.default_mask(p.radix);
    let bits = dummy.type_size();
    let (mask, shift) = if bits < p.offset + p.radix * (p.level + 1) {
        let r_shift = p.offset + p.radix * (p.level + 1) - bits;
        (mask >> dummy.usize_to_keytype(r_shift), 0)
    } else {
        (mask, bits - p.offset - p.radix * (p.level + 1))
    };
    let mask = mask << dummy.usize_to_keytype(shift);
    let phase_start = Instant::now();
    let histogram = get_histogram(arr, &p, mask, shift);
    let elapsed = phase_start.elapsed().as_nanos();
    phases::with(|phase| {
        phase.histogram_ns += elapsed;
        phase.histogram_records += arr.len();
    });
    let phase_start = Instant::now();
    let (p_sums, mut heads, _) = prefix_sums(&histogram);
    let elapsed = phase_start.elapsed().as_nanos();
    phases::with(|phase| {
        phase.setup_ns += elapsed;
        phase.setup_entries += p.radix_range;
    });
    let phase_start = Instant::now();
    let mut buffer = arr.to_vec();
    let elapsed = phase_start.elapsed().as_nanos();
    phases::with(|phase| {
        phase.workspace_ns += elapsed;
        phase.buffer_clone_records += arr.len();
    });
    let phase_start = Instant::now();
    copy_by_histogram(arr.len(), &mut buffer, arr, &mut heads, mask, shift);
    let elapsed = phase_start.elapsed().as_nanos();
    phases::with(|phase| {
        phase.scatter_ns += elapsed;
        phase.scatter_records += arr.len();
    });

    let mut rest = arr;
    if p.level < p.max_level - 1 {
        for i in 0..(p.radix_range) {
            let bucket_end = p_sums[i + 1] - p_sums[i];
            let (first_part, second_part) = rest.split_at_mut(bucket_end);
            rest = second_part;
            if histogram[i] > 1 {
                if first_part.len() <= 128 {
                    phases::with(|phase| {
                        phase.leaf_lengths[first_part.len()] += 1
                    });
                    let phase_start = Instant::now();
                    first_part
                        .sort_unstable_by(|a, b| a.partial_cmp(b).unwrap());
                    let elapsed = phase_start.elapsed().as_nanos();
                    phases::with(|phase| phase.leaf_sort_ns += elapsed);
                } else {
                    let new_params = p.new_level(p.level + 1);
                    msd_radixsort_rec(first_part, new_params);
                }
            }
        }
    }
}

fn msd_radixsort_aux<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
) {
    if arr.len() <= 128 {
        phases::with(|phase| phase.leaf_lengths[arr.len()] += 1);
        let phase_start = Instant::now();
        arr.sort_unstable_by(|a, b| a.partial_cmp(b).unwrap());
        phases::with(|phase| {
            phase.leaf_sort_ns += phase_start.elapsed().as_nanos()
        });
        return;
    }

    let dummy = arr[0];
    let phase_start = Instant::now();
    let (_, raw_offset) = dummy.compute_offset(arr, radix);
    let max_level = dummy.compute_max_level(raw_offset, radix);
    let elapsed = phase_start.elapsed().as_nanos();
    phases::with(|phase| {
        phase.union_ns += elapsed;
        phase.union_records += arr.len();
    });

    if max_level == 0 {
        return;
    }

    let params = Params::new(0, radix, raw_offset, max_level);

    msd_radixsort_rec(arr, params);
}

/// # MSD sort
///
/// An implementation of the
/// [MSD sort](https://en.wikipedia.org/wiki/Radix_sort)
/// algorithm.
///
/// Implementation has been deeply optimized:
/// - Small preliminary check to skip prefix zero bits.
/// - Use vectorization.
///
/// We choose to use an out of place implementation to have a fast radix sort
/// for small input. This sort is used as a fallback for other radix sort from
/// this crate.
///
/// The Verge sort pre-processing heuristic is also added.
///
/// This MSD sort is an out of place unstable radix sort.
pub fn msd_radixsort<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    radix: usize,
) {
    if arr.len() <= 128 {
        phases::with(|phase| phase.leaf_lengths[arr.len()] += 1);
        let phase_start = Instant::now();
        arr.sort_unstable_by(|a, b| a.partial_cmp(b).unwrap());
        phases::with(|phase| {
            phase.leaf_sort_ns += phase_start.elapsed().as_nanos()
        });
        return;
    }

    let mut separators =
        verge_sort_preprocessing(arr, radix, &msd_radixsort_aux);
    k_way_merge(arr, &mut separators);
}

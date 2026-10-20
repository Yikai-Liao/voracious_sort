// MIT-licensed benchmark copy of src/sorts/lsd_sort.rs::lsd_radixsort_body
// and src/sorts/msd_sort.rs::copy_by_histogram. The only adaptations are the
// local Params/histogram module and the equivalent default mask expression.
// The benchmark Record types use the default Radixable implementations.
use super::super::{RadixKey, Radixable};
use crunchy::unroll;
use super::utils::{
    copy_nonoverlapping, get_full_histograms, only_one_bucket_filled,
    prefix_sums, Params,
};
const UNROLL_SIZE: usize = 4;

#[inline]
pub fn copy_by_histogram<T, K, const STYLE: usize>(
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
    if STYLE == 1 {
        for item in source.iter().take(size) {
            let bucket = item.extract(mask, shift);
            let position = heads[bucket];
            heads[bucket] = position + 1;
            destination[position] = *item;
        }
        return;
    }
    if STYLE == 2 {
        let (chunks, remainder) = source[..size].as_chunks::<4>();
        for chunk in chunks {
            for item in chunk {
                let bucket = item.extract(mask, shift);
                let position = heads[bucket];
                heads[bucket] = position + 1;
                destination[position] = *item;
            }
        }
        for item in remainder {
            let bucket = item.extract(mask, shift);
            let position = heads[bucket];
            heads[bucket] = position + 1;
            destination[position] = *item;
        }
        return;
    }
    if STYLE == 3 || STYLE == 4 {
        let (chunks, remainder) = source[..size].as_chunks::<4>();
        for chunk in chunks {
            if STYLE == 3 {
                // seq preserves the old three phases with one source template
                // per phase: extract all digits, assign cursors, then store.
                seq_macro::seq!(N in 0..4 {
                    #( let bucket~N = chunk[N].extract(mask, shift); )*
                    #(
                        let position~N = heads[bucket~N];
                        heads[bucket~N] = position~N + 1;
                    )*
                    #( destination[position~N] = chunk[N]; )*
                });
            } else {
                let mut buckets = [0usize; 4];
                let mut positions = [0usize; 4];
                unroll! {
                    for i in 0..4 { buckets[i] = chunk[i].extract(mask, shift); }
                }
                unroll! {
                    for i in 0..4 {
                        positions[i] = heads[buckets[i]];
                        heads[buckets[i]] = positions[i] + 1;
                    }
                }
                unroll! {
                    for i in 0..4 { destination[positions[i]] = chunk[i]; }
                }
            }
        }
        for item in remainder {
            let bucket = item.extract(mask, shift);
            let position = heads[bucket];
            heads[bucket] = position + 1;
            destination[position] = *item;
        }
        return;
    }
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

pub fn lsd_radixsort_body<T, K, const STYLE: usize>(arr: &mut [T], p: Params)
where
    T: Radixable<K>,
    K: RadixKey,
{
    if arr.len() <= 128 {
        arr.sort_unstable_by(|a, b| a.partial_cmp(b).unwrap());
        return;
    }

    let size = arr.len();
    let dummy = arr[0];
    let mut buffer: Vec<T> = vec![arr[0]; size];
    let mut index = 0;

    let histograms = get_full_histograms(arr, &p);

    let mut t1 = arr;
    let t2 = &mut buffer;
    let mut t2 = t2.as_mut_slice();

    for level in (p.level..p.max_level).rev() {
        if only_one_bucket_filled(&histograms[level]) {
            continue;
        }

        let (mut source, mut destination) =
            if index == 0 { (t1, t2) } else { (t2, t1) };
        let shift = p.radix * (p.max_level - level - 1);
        let mask = dummy.default_mask(p.radix) << dummy.usize_to_keytype(shift);
        let (_, mut heads, _) = prefix_sums(&histograms[level]);

        copy_by_histogram::<T, K, STYLE>(
            source.len(),
            &mut source,
            &mut destination,
            &mut heads,
            mask,
            shift,
        );

        index = 1 - index;

        if index == 1 {
            t1 = source;
            t2 = destination;
        } else {
            t2 = source;
            t1 = destination;
        }
    }

    if index == 1 {
        copy_nonoverlapping(t2, t1, size);
    }
}

// Offset detection is included, as it is in the public ordinary LSD path.
pub fn sort<T: Radixable<K>, K: RadixKey, const STYLE: usize>(arr: &mut [T]) {
    if arr.len() <= 128 {
        arr.sort_unstable_by(|a, b| a.partial_cmp(b).unwrap());
        return;
    }
    let dummy = arr[0];
    let (offset, _) = dummy.compute_offset(arr, 8);
    let levels = dummy.compute_max_level(offset, 8);
    if levels != 0 {
        lsd_radixsort_body::<T, K, STYLE>(
            arr,
            Params::new(0, 8, offset, levels),
        );
    }
}

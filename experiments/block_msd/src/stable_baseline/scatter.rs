use super::super::{RadixKey, Radixable};
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

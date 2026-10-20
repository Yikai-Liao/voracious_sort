//! Complete a narrow numeric interval without treating carries as key entropy.
use super::*;

// The ordinary PA remains a fixed-policy call. Speculation cannot enlarge its
// recursive Policy/Prepared values or add branches to its record loops.
#[inline(never)]
pub fn sort_pa_interval<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    block: usize,
    workspace_threshold: usize,
) -> Work
where
    Converted<T, K>: NativeKey,
{
    assert!(block > 0);
    if arr.len() <= 128 || std::mem::size_of::<T>() == 0 {
        return pa::sort_pa_with_threshold::<T, K>(
            arr,
            PaExperiment::UnifiedGroups,
            block,
            workspace_threshold,
        );
    }
    let bytes =
        (usize::BITS as usize - (arr.len() - 1).leading_zeros() as usize + 7)
            / 8;
    if !sample::<T, K>(arr, bytes * 8) {
        return pa::sort_pa_with_threshold::<T, K>(
            arr,
            PaExperiment::UnifiedGroups,
            block,
            workspace_threshold,
        );
    }
    let mut stats = Work::default();
    if pa::ordered::<T, K>(arr, &mut stats) {
        return stats;
    }
    if let Some((translation, mask)) =
        select::<T, K>(arr, bytes * 8, &mut stats)
    {
        let label = labeler::Classified::<T, K, _> {
            classifier: &translation,
            marker: std::marker::PhantomData,
            #[cfg(feature = "frontier_work")]
            evaluations: &std::cell::Cell::new(0),
        };
        let passes = local_distribution::distribute_prepared_grouped(
            arr,
            &label,
            block,
            workspace_threshold,
            mask,
            &mut stats,
        );
        work! {
            stats.nodes += 1;
            stats.node_records += arr.len();
            stats.max_path_passes = passes;
            stats.label_evals += label.evaluations.get();
        }
        return stats;
    }
    let mut fallback = pa::sort_pa_with_threshold::<T, K>(
        arr,
        PaExperiment::UnifiedGroups,
        block,
        workspace_threshold,
    );
    work! {
        fallback.order_records += stats.order_records;
        fallback.prepare_records += stats.prepare_records;
    }
    fallback
}

pub(super) struct Translation<U> {
    base: U,
}

impl<U: NativeKey> Classifier<U> for Translation<U> {
    type Label = U;
    #[inline]
    fn label(&self, key: U) -> U {
        key - self.base
    }
    fn remaining(&self, _: U) -> usize {
        0
    }
}

// The sample admits an exact bound proof only for a possible carry crossing.
// Rejection uses bounded work and allocates no per-record state.
pub(super) fn sample<T: Radixable<K>, K: RadixKey>(
    arr: &[T],
    coarse: usize,
) -> bool
where
    Converted<T, K>: NativeKey,
{
    if coarse >= Converted::<T, K>::BITS {
        return false;
    }
    let limit = Converted::<T, K>::mask(coarse);
    let mut minimum = arr[0].into_key_type();
    let mut maximum = minimum;
    let span = arr.len() - 1;
    for i in 1..64 {
        let index = i * (span / 63) + i * (span % 63) / 63;
        let key = arr[index].into_key_type();
        minimum = minimum.min(key);
        maximum = maximum.max(key);
    }
    maximum - minimum <= limit && (minimum ^ maximum) > limit
}

pub(super) fn select_bounds<U: NativeKey>(
    minimum: U,
    maximum: U,
    variation: U,
    width: usize,
    coarse: usize,
) -> Option<(Translation<U>, U)> {
    if maximum - minimum > U::mask(coarse) {
        return None;
    }
    let bits = U::BITS - (maximum - minimum).leading_zeros() as usize;
    let prefix = variation >> (width - coarse);
    let prefix_passes =
        (0..(coarse + 7) / 8).filter(|&i| prefix.byte(i) != 0).count();
    // Completion must use no more scatter passes than the original first
    // partition. The exact range proof makes subtraction nonwrapping for all
    // labels; converted signed/float order is preserved without type branches.
    if (bits + 7) / 8 > prefix_passes {
        return None;
    }
    Some((Translation { base: minimum }, U::mask(bits)))
}

// The caller admits this exact scan with sample(). Keeping these bounds
// local avoids enlarging every ordinary PA node and its preparation result.
pub(super) fn select<T: Radixable<K>, K: RadixKey>(
    arr: &[T],
    coarse: usize,
    stats: &mut Work,
) -> Option<(Translation<Converted<T, K>>, Converted<T, K>)>
where
    Converted<T, K>: NativeKey,
{
    let first = arr[0].into_key_type();
    let (mut minimum, mut maximum, mut union, mut intersection) =
        (first, first, first, first);
    for value in arr {
        let key = value.into_key_type();
        minimum = minimum.min(key);
        maximum = maximum.max(key);
        union |= key;
        intersection &= key;
    }
    work! { stats.prepare_records += arr.len(); }
    let variation = union ^ intersection;
    let width = Converted::<T, K>::BITS - variation.leading_zeros() as usize;
    if width <= coarse {
        return None;
    }
    select_bounds(minimum, maximum, variation, width, coarse)
}

#[cfg(test)]
mod tests {
    use super::*;

    fn check<U: RadixKey + Radixable<U, Key = U>>(values: &[U], coarse: usize)
    where
        <U as RadixKey>::Key: NativeKey,
    {
        let (label, mask) =
            select::<U, U>(values, coarse, &mut Work::default()).unwrap();
        let mut expected = values.to_vec();
        expected.sort_by_key(|v| v.into_key_type());
        let mut actual = values.to_vec();
        actual.sort_by_key(|v| label.label(v.into_key_type()));
        assert!(actual
            .iter()
            .zip(expected)
            .all(|(a, b)| a.into_key_type() == b.into_key_type()));
        for item in values {
            assert!(label.label(item.into_key_type()) <= mask);
        }
    }

    #[test]
    fn translation_handles_carries_at_native_and_wide_boundaries() {
        for bit in [16, 24, 31] {
            let base = 1u32 << bit;
            let a: Vec<_> =
                (0..1024).map(|i| base - 1024 + (i * 7919 % 2048)).collect();
            check(&a, 16);
        }
        for bit in [32, 64, 100, 127] {
            let base = 1u128 << bit;
            let a: Vec<_> =
                (0..1024).map(|i| base - 1024 + (i * 7919 % 2048)).collect();
            check(&a, 16);
        }
        let signed: Vec<i32> =
            (0..1024).map(|i| (i * 7919 % 2048) - 1024).collect();
        check(&signed, 16);
    }

    #[test]
    fn exact_range_rejects_an_unsampled_outlier_without_mutation() {
        let mut values: Vec<u32> =
            (0..1024).map(|i| (1 << 30) - 512 + i).collect();
        values[500] = u32::MAX;
        let before = values.clone();
        assert!(select::<u32, u32>(&values, 16, &mut Work::default()).is_none());
        assert_eq!(values, before);
        assert!(select::<u32, u32>(&vec![0; 1024], 16, &mut Work::default())
            .is_none());
    }
}

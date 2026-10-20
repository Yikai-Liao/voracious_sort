//! Native-width interval completion using PA's existing radix distributor.
use super::*;

#[inline(never)]
pub fn sort_pa_radix_completion<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    block: usize,
    workspace_threshold: usize,
) -> Work
where
    Converted<T, K>: NativeKey,
{
    assert!(block > 0);
    // In-budget frontiers already fit PA's local distribution workspace.
    // Admit a speculative scan only beyond that existing resource boundary.
    if arr.len() <= 128
        || arr.len() <= block.saturating_mul(512)
        || std::mem::size_of::<T>() == 0
    {
        return ordinary::<T, K>(arr, block, workspace_threshold);
    }
    let bytes =
        (usize::BITS as usize - (arr.len() - 1).leading_zeros() as usize + 7)
            / 8;
    if !sample::<T, K>(arr, bytes * 8) {
        return ordinary::<T, K>(arr, block, workspace_threshold);
    }
    let mut stats = Work::default();
    if ordered_tiled::ordered::<T, K>(arr, &mut stats) {
        return stats;
    }
    if let Some((translation, mask)) =
        translated_interval::select::<T, K>(arr, bytes * 8, &mut stats)
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
    let mut fallback =
        pa::sort_pa_after_order::<T, K>(arr, block, workspace_threshold);
    work! {
        fallback.order_records += stats.order_records;
        fallback.prepare_records += stats.prepare_records;
    }
    fallback
}

fn sample<T: Radixable<K>, K: RadixKey>(arr: &[T], coarse: usize) -> bool
where
    Converted<T, K>: NativeKey,
{
    if coarse >= Converted::<T, K>::BITS {
        return false;
    }
    let first = arr[0].into_key_type();
    let (mut minimum, mut maximum) = (first, first);
    let samples = (arr.len() / 128).clamp(2, 64);
    let denominator = samples - 1;
    let step = (arr.len() - 1) / denominator;
    let remainder = (arr.len() - 1) % denominator;
    let (mut index, mut error) = (0, 0);
    for _ in 1..samples {
        index += step;
        error += remainder;
        if error >= denominator {
            index += 1;
            error -= denominator;
        }
        let key = arr[index].into_key_type();
        minimum = minimum.min(key);
        maximum = maximum.max(key);
    }
    maximum - minimum <= Converted::<T, K>::mask(coarse)
        && minimum ^ maximum > Converted::<T, K>::mask(coarse)
}

// Preserve the fixed ordinary policy across this compilation boundary.
#[inline(never)]
fn ordinary<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    block: usize,
    workspace_threshold: usize,
) -> Work
where
    Converted<T, K>: NativeKey,
{
    pa::sort_pa_with_threshold::<T, K>(
        arr,
        PaExperiment::UnifiedGroups,
        block,
        workspace_threshold,
    )
}

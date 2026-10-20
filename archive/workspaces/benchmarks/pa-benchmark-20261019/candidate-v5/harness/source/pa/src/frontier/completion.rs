//! Speculative root completion; the ordinary PA engine retains its policy.
use super::*;

#[derive(Clone, Copy, PartialEq)]
pub enum PaCompletion {
    Interval,
    Runs,
    Both,
}

#[inline(never)]
pub fn sort_pa_completion<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    completion: PaCompletion,
    block: usize,
    workspace_threshold: usize,
) -> Work
where
    Converted<T, K>: NativeKey,
{
    assert!(block > 0);
    let bytes = if arr.len() > 1 {
        (usize::BITS as usize - (arr.len() - 1).leading_zeros() as usize + 7)
            / 8
    } else {
        0
    };
    let runs = completion != PaCompletion::Interval;
    let eligible = arr.len() > 128 && std::mem::size_of::<T>() != 0;
    let interval = eligible
        && completion != PaCompletion::Runs
        && translated_interval::sample::<T, K>(arr, bytes * 8);
    if !eligible || (!runs && !interval) {
        return pa::sort_pa_with_threshold::<T, K>(
            arr,
            PaExperiment::UnifiedGroups,
            block,
            workspace_threshold,
        );
    }
    let mut stats = Work::default();
    // Unified PA uses the tiled proof, including its vectorizable equal-prefix
    // reduction. Reuse that exact proof rather than the scalar ablation.
    if ordered_tiled::ordered::<T, K>(arr, &mut stats) {
        return stats;
    }
    if runs && natural_runs::complete::<T, K>(arr, block) {
        return stats;
    }
    if interval {
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

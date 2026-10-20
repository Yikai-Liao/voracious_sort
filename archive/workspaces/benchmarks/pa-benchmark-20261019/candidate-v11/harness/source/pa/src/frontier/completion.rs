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
    if arr.len() <= 128 || std::mem::size_of::<T>() == 0 {
        return ordinary::<T, K>(arr, block, workspace_threshold);
    }
    let bytes = if arr.len() > 1 {
        (usize::BITS as usize - (arr.len() - 1).leading_zeros() as usize + 7)
            / 8
    } else {
        0
    };
    let probe = probe::<T, K>(arr, bytes * 8);
    let run_budget = if completion != PaCompletion::Interval {
        probe.run_budget
    } else {
        0
    };
    let interval = completion != PaCompletion::Runs
        && probe.interval;
    if run_budget == 0 && !interval {
        return ordinary::<T, K>(arr, block, workspace_threshold);
    }
    let mut stats = Work::default();
    // Unified PA uses the tiled proof, including its vectorizable equal-prefix
    // reduction. Reuse that exact proof rather than the scalar ablation.
    if ordered_tiled::ordered::<T, K>(arr, &mut stats) {
        return stats;
    }
    // A monotone synopsis can hide short displaced fragments. Let the
    // existing stable comparison leaf finish those frontiers when its whole
    // temporary buffer fits the same record budget as PA's distribution.
    if run_budget > 0 && probe.monotone && arr.len() <= block.saturating_mul(512) {
        comparison::<T, K>(arr);
        work! {
            stats.leaves += 1;
            stats.leaf_records += arr.len();
        }
        return stats;
    }
    // A failed full-order proof already excludes a single natural run.
    if run_budget >= 2
        && natural_runs::complete::<T, K>(arr, block, run_budget)
    {
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
    let mut fallback = pa::sort_pa_after_order::<T, K>(
        arr, block, workspace_threshold,
    );
    work! {
        fallback.order_records += stats.order_records;
        fallback.prepare_records += stats.prepare_records;
    }
    fallback
}

struct Probe {
    interval: bool,
    run_budget: usize,
    monotone: bool,
}

// Share one bounded synopsis between both completion choices. Each balanced
// merge level visits the frontier; budget its levels against the sampled
// byte passes in PA's first partition. This is a cost hint, not a proof that
// a merge and a scatter have equal cost. Full run discovery still enforces
// the budget before mutation, and interval selection proves exact bounds.
fn probe<T: Radixable<K>, K: RadixKey>(arr: &[T], coarse: usize) -> Probe
where
    Converted<T, K>: NativeKey,
{
    let first = arr[0].into_key_type();
    let (mut minimum, mut maximum, mut previous) = (first, first, first);
    let (mut runs, mut direction) = (1usize, 0i8);
    // Amortize each sample over one existing PA leaf, up to 64 samples.
    // An incremental remainder keeps variable sample counts division-free
    // inside the loop, with both endpoints included exactly.
    let samples = (arr.len() / 128).clamp(2, 64);
    let span = arr.len() - 1;
    let denominator = samples - 1;
    let step = span / denominator;
    let remainder = span % denominator;
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
        if direction == 0 {
            direction = if key < previous { -1 } else { 1 };
        } else if (direction < 0 && key >= previous)
            || (direction > 0 && key < previous)
        {
            runs += 1;
            direction = 0;
        }
        previous = key;
    }
    let variation = minimum ^ maximum;
    let width = Converted::<T, K>::BITS - variation.leading_zeros() as usize;
    let prefix_bits = width.min(coarse);
    let prefix = variation >> (width - prefix_bits);
    let passes = (0..(prefix_bits + 7) / 8)
        .filter(|&i| prefix.byte(i) != 0)
        .count();
    let run_budget = 1usize << passes;
    Probe {
        interval: coarse < Converted::<T, K>::BITS
            && maximum - minimum <= Converted::<T, K>::mask(coarse)
            && variation > Converted::<T, K>::mask(coarse),
        run_budget: if runs <= run_budget { run_budget } else { 0 },
        monotone: runs == 1,
    }
}

#[inline(never)]
fn comparison<T: Radixable<K>, K: RadixKey>(arr: &mut [T])
where
    Converted<T, K>: NativeKey,
{
    arr.sort_by_key(|item| item.into_key_type());
}

// Keep the fixed ordinary policy in its own compilation boundary. Speculative
// completion must not turn the legacy engine's policy constants into state
// carried through a larger caller.
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

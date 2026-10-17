//! Independent Pa ablations. Policies change node preparation or its classifier;
//! all policies use the same distribution workspace and recursive ownership.
use super::*;

#[derive(Clone, Copy, Debug)]
pub enum PaExperiment {
    Reference,
    Terminal,
    Ordered,
    Lean,
    Skew,
    SkewThreeWay,
    Both,
    BothThreeWay,
}

#[derive(Clone, Copy)]
struct Policy {
    terminal: bool,
    ordered: bool,
    skew: bool,
    three_way: bool,
    block: usize,
}

pub fn sort_pa_experiment<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    experiment: PaExperiment,
    block: usize,
) -> Work
where
    Converted<T, K>: NativeKey,
{
    assert!(block > 0);
    let policy = Policy {
        terminal: matches!(
            experiment,
            PaExperiment::Terminal
                | PaExperiment::Lean
                | PaExperiment::Both
                | PaExperiment::BothThreeWay
        ),
        ordered: matches!(
            experiment,
            PaExperiment::Ordered
                | PaExperiment::Lean
                | PaExperiment::Both
                | PaExperiment::BothThreeWay
        ),
        skew: matches!(
            experiment,
            PaExperiment::Skew
                | PaExperiment::Both
                | PaExperiment::SkewThreeWay
                | PaExperiment::BothThreeWay
        ),
        three_way: matches!(
            experiment,
            PaExperiment::SkewThreeWay | PaExperiment::BothThreeWay
        ),
        block,
    };
    let mut stats = Work::default();
    if arr.len() > 1 && std::mem::size_of::<T>() > 0 {
        visit::<T, K>(arr, arr[0].type_size(), policy, false, &mut stats, 0, 0);
    }
    stats
}

struct Prepared<U> {
    union: U,
    intersection: U,
    ascending: bool,
    descending: bool,
    pivot: U,
    votes: usize,
}

// Specialize scans outside the record loop. Ordinary nodes do not pay the
// candidate comparison/branch; ordered ablation removes order reductions here.
fn prepare<T: Radixable<K>, K: RadixKey, const ORDER: bool, const CANDIDATE: bool>(
    arr: &[T],
) -> Prepared<Converted<T, K>>
where
    Converted<T, K>: NativeKey,
{
    let first = arr[0].into_key_type();
    let mut p = Prepared {
        union: first,
        intersection: first,
        ascending: true,
        descending: true,
        pivot: first,
        votes: 0,
    };
    let mut previous = first;
    for item in arr {
        let key = item.into_key_type();
        p.union |= key;
        p.intersection &= key;
        if ORDER {
            p.ascending &= previous <= key;
            p.descending &= previous >= key;
            previous = key;
        }
        if CANDIDATE {
            if p.votes == 0 {
                p.pivot = key;
                p.votes = 1;
            } else if p.pivot == key {
                p.votes += 1;
            } else {
                p.votes -= 1;
            }
        }
    }
    p
}

// Return as soon as an order violation is seen. Reverse only after validating
// the whole range, and restore equal-key groups only when any equality exists.
fn ordered<T: Radixable<K>, K: RadixKey>(arr: &mut [T], stats: &mut Work) -> bool
where
    Converted<T, K>: NativeKey,
{
    work! { stats.order_records += 1; }
    let first = arr[0].into_key_type();
    let mut different = 1;
    while different < arr.len() && {
        work! { stats.order_records += 1; }
        arr[different].into_key_type() == first
    } {
        different += 1;
    }
    if different == arr.len() {
        return true;
    }
    work! { stats.order_records += 1; }
    let mut previous = arr[different].into_key_type();
    let ascending = first < previous;
    let mut equal = different > 1;
    for item in &arr[different + 1..] {
        work! { stats.order_records += 1; }
        let key = item.into_key_type();
        if (ascending && previous > key) || (!ascending && previous < key) {
            return false;
        }
        equal |= previous == key;
        previous = key;
    }
    if !ascending {
        arr.reverse();
        if equal {
            restore_equal_groups::<T, K>(arr, stats);
        }
    }
    true
}

fn restore_equal_groups<T: Radixable<K>, K: RadixKey>(arr: &mut [T], stats: &mut Work)
where
    Converted<T, K>: NativeKey,
{
    let mut start = 0;
    while start < arr.len() {
        work! { stats.order_records += 1; }
        let key = arr[start].into_key_type();
        let mut end = start + 1;
        while end < arr.len() && {
            work! { stats.order_records += 1; }
            arr[end].into_key_type() == key
        } {
            end += 1;
        }
        arr[start..end].reverse();
        start = end;
    }
}

fn visit<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    cap: usize,
    policy: Policy,
    heavy: bool,
    stats: &mut Work,
    depth: usize,
    path: usize,
) where
    Converted<T, K>: NativeKey,
{
    if arr.len() < 2 || cap == 0 {
        return;
    }
    work! { stats.max_depth = stats.max_depth.max(depth); }
    if arr.len() <= 128 {
        work! { stats.leaves += 1; stats.leaf_records += arr.len(); stats.leaf_lengths[arr.len()] += 1; }
        super::super::insertion_sort_key::<T, K>(arr);
        return;
    }
    if policy.ordered && ordered::<T, K>(arr, stats) {
        return;
    }
    let candidate = policy.skew && heavy && cap > 8;
    let p = match (policy.ordered, candidate) {
        (false, false) => prepare::<T, K, true, false>(arr),
        (false, true) => prepare::<T, K, true, true>(arr),
        (true, false) => prepare::<T, K, false, false>(arr),
        (true, true) => prepare::<T, K, false, true>(arr),
    };
    work! { stats.prepare_records += arr.len(); if !policy.ordered { stats.order_records += arr.len(); } if candidate { stats.candidate_records += arr.len(); } }
    if !policy.ordered {
        if p.ascending {
            return;
        }
        if p.descending {
            arr.reverse();
            restore_equal_groups::<T, K>(arr, stats);
            return;
        }
    }
    let width =
        (Converted::<T, K>::BITS - (p.union ^ p.intersection).leading_zeros() as usize).min(cap);
    if width == 0 {
        return;
    }
    let bytes = (usize::BITS as usize - (arr.len() - 1).leading_zeros() as usize + 7) / 8;
    let coarse = width.min(8 * bytes);
    work! { stats.nodes += 1; stats.node_records += arr.len(); }
    if policy.terminal && coarse == width {
        partition::<T, K, _>(arr, &Identity, policy, true, stats, depth, path);
    } else if candidate && p.votes > arr.len() / 2 && width > 8 {
        // Each surviving BM vote is an occurrence of the final candidate.
        // votes > m/2 certifies a complete-key majority without a verify pass.
        // It deliberately misses some weaker majorities; correctness of the
        // ordered classifier does not depend on the majority certificate.
        if policy.three_way {
            work! { stats.equal_nodes += 1; }
            let classifier = EqualSplit {
                pivot: p.pivot & Converted::<T, K>::mask(width),
                mask: Converted::<T, K>::mask(width),
                width,
            };
            partition::<T, K, _>(arr, &classifier, policy, false, stats, depth, path);
        } else {
            work! { stats.frontier_nodes += 1; }
            let classifier = Frontier::new(p.pivot, width, 7);
            partition::<T, K, _>(arr, &classifier, policy, false, stats, depth, path);
        }
    } else {
        let classifier = Prefix {
            low: width - coarse,
            mask: Converted::<T, K>::mask(coarse),
        };
        partition::<T, K, _>(arr, &classifier, policy, false, stats, depth, path);
    }
}

// A majority certificate guarantees each unresolved side is smaller than half
// this node. Side intervals need not share a new binary prefix, so preserve the
// conservative bit cap; the equal group is complete and never recursed into.
struct EqualSplit<U> {
    pivot: U,
    mask: U,
    width: usize,
}
impl<U: NativeKey> Classifier<U> for EqualSplit<U> {
    fn label(&self, key: U) -> U {
        U::from_u128(match (key & self.mask).cmp(&self.pivot) {
            std::cmp::Ordering::Less => 0,
            std::cmp::Ordering::Equal => 1,
            std::cmp::Ordering::Greater => 2,
        })
    }
    fn remaining(&self, key: U) -> usize {
        if key & self.mask == self.pivot {
            0
        } else {
            self.width
        }
    }
}

fn partition<T: Radixable<K>, K: RadixKey, C: Classifier<Converted<T, K>>>(
    arr: &mut [T],
    classifier: &C,
    policy: Policy,
    terminal: bool,
    stats: &mut Work,
    depth: usize,
    path: usize,
) where
    Converted<T, K>: NativeKey,
{
    #[cfg(feature = "frontier_work")]
    let label_evals = std::cell::Cell::new(0usize);
    let label = |item: &T| {
        work! { label_evals.set(label_evals.get() + 1); }
        classifier.label(item.into_key_type())
    };
    // distribute owns and releases all scratch before the first recursive call.
    let passes = distribute(arr, &label, policy.block, stats);
    work! { stats.max_path_passes = stats.max_path_passes.max(path + passes); }
    if !terminal {
        let parent_len = arr.len();
        let mut start = 0;
        while start < arr.len() {
            let current = label(&arr[start]);
            let remaining = classifier.remaining(arr[start].into_key_type());
            let mut end = start + 1;
            while end < arr.len() && label(&arr[end]) == current {
                end += 1;
            }
            work! { stats.runs_records += end - start; }
            if end - start > 1 && remaining > 0 {
                work! { stats.unresolved_records += end - start; }
                visit::<T, K>(
                    &mut arr[start..end],
                    remaining,
                    policy,
                    end - start > parent_len / 2,
                    stats,
                    depth + 1,
                    path + passes,
                );
            }
            start = end;
        }
    }
    work! { stats.label_evals += label_evals.get(); }
}

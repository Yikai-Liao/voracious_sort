//! Independently measured work reductions over the 749ca4d controls.
#[derive(Debug)]
pub struct Work {
    pub ordered_writes: usize,
    pub extra_monotone_records: usize,
    pub monotone_ns: u128,
    pub writer_ns: u128,
    pub gather_ns: u128,
    pub leaf_ns: u128,
    pub placement_ns: u128,
    pub copyback_ns: u128,
    pub scatter_ns: u128,
    pub setup_ns: u128,
    pub histogram_ns: u128,
    pub variation_ns: u128,
    pub ordered_ns: u128,
    pub ordered_records: usize,
    pub variation_records: usize,
    pub histogram_records: usize,
    pub monotone_records: usize,
    pub histogram_slots: usize,
    pub metadata_allocations: usize,
    pub metadata_bytes: usize,
    pub scatter_records: usize,
    pub tail_save_records: usize,
    pub placement_writes: usize,
    pub copyback_records: usize,
    pub gather_records: usize,
    pub writer_records: usize,
    pub leaf_records: usize,
    pub leaf_lengths: [usize; 129],
    pub cached_depth_records: [usize; 17],
}

impl Default for Work {
    fn default() -> Self {
        Self {
            ordered_writes: 0,
            extra_monotone_records: 0,
            monotone_ns: 0,
            writer_ns: 0,
            gather_ns: 0,
            leaf_ns: 0,
            placement_ns: 0,
            copyback_ns: 0,
            scatter_ns: 0,
            setup_ns: 0,
            histogram_ns: 0,
            variation_ns: 0,
            ordered_ns: 0,
            ordered_records: 0,
            variation_records: 0,
            histogram_records: 0,
            monotone_records: 0,
            histogram_slots: 0,
            metadata_allocations: 0,
            metadata_bytes: 0,
            scatter_records: 0,
            tail_save_records: 0,
            placement_writes: 0,
            copyback_records: 0,
            gather_records: 0,
            writer_records: 0,
            leaf_records: 0,
            leaf_lengths: [0; 129],
            cached_depth_records: [0; 17],
        }
    }
}
impl Work {
    pub fn merge(&mut self, other: Work) {
        self.ordered_writes += other.ordered_writes;
        self.extra_monotone_records += other.extra_monotone_records;
        self.monotone_ns += other.monotone_ns;
        self.writer_ns += other.writer_ns;
        self.gather_ns += other.gather_ns;
        self.leaf_ns += other.leaf_ns;
        self.placement_ns += other.placement_ns;
        self.copyback_ns += other.copyback_ns;
        self.scatter_ns += other.scatter_ns;
        self.setup_ns += other.setup_ns;
        self.histogram_ns += other.histogram_ns;
        self.variation_ns += other.variation_ns;
        self.ordered_ns += other.ordered_ns;
        self.ordered_records += other.ordered_records;
        self.variation_records += other.variation_records;
        self.histogram_records += other.histogram_records;
        self.monotone_records += other.monotone_records;
        self.histogram_slots += other.histogram_slots;
        self.metadata_allocations += other.metadata_allocations;
        self.metadata_bytes += other.metadata_bytes;
        self.scatter_records += other.scatter_records;
        self.tail_save_records += other.tail_save_records;
        self.placement_writes += other.placement_writes;
        self.copyback_records += other.copyback_records;
        self.gather_records += other.gather_records;
        self.writer_records += other.writer_records;
        self.leaf_records += other.leaf_records;
        for (a, b) in
            self.leaf_lengths.iter_mut().zip(other.leaf_lengths.iter())
        {
            *a += b;
        }
        for (a, b) in self
            .cached_depth_records
            .iter_mut()
            .zip(other.cached_depth_records.iter())
        {
            *a += b;
        }
    }
}
#[cfg(test)]
mod tests {
    use crate::{node_local, reduction_gate as gate, reduction_node as node};
    use std::cmp::Ordering;
    use voracious_radix_sort::Radixable;
    #[derive(Copy, Clone, Debug, PartialEq, Eq)]
    struct Record {
        key: u128,
        id: usize,
        payload: [u64; 3],
    }
    impl PartialOrd for Record {
        fn partial_cmp(&self, b: &Self) -> Option<Ordering> {
            self.key.partial_cmp(&b.key)
        }
    }
    impl Radixable<u128> for Record {
        type Key = u128;
        fn key(&self) -> u128 {
            self.key
        }
    }
    fn run_case(source: &[Record], radix: usize, block: usize, budget: usize) {
        let mut expected = source.to_vec();
        expected.sort_by_key(|x| x.key);
        for (two, cycle) in
            [(false, false), (true, false), (false, true), (true, true)]
        {
            let mut a = source.to_vec();
            let stats = node::sort_reduced(
                &mut a,
                radix,
                block,
                budget,
                if cycle {
                    node::Placement::CycleFreeList
                } else {
                    node::Placement::FreeList
                },
                two,
            );
            assert_eq!(
                a, expected,
                "two={} cycle={} r={} b={} budget={}",
                two, cycle, radix, block, budget
            );
            let mut control = source.to_vec();
            let old = node_local::sort_with_budget(
                &mut control,
                radix,
                block,
                budget,
            );
            assert_eq!(stats.block_scatter_records, old.block_scatter_records);
            assert_eq!(stats.cache_scatter_records, old.cache_scatter_records);
            assert_eq!(stats.leaf_sorts, old.leaf_sorts);
            assert!(stats.permutation_writes <= old.permutation_writes);
        }
        for prepared in [false, true] {
            for fused in [false, true] {
                let mut a = source.to_vec();
                gate::sort_reduced(
                    &mut a, radix, block, budget, prepared, fused,
                );
                assert_eq!(
                    a, expected,
                    "prepared={} fused={} r={} b={}",
                    prepared, fused, radix, block
                );
            }
        }
    }
    #[test]
    fn reductions_preserve_stability_at_block_leaf_and_digit_boundaries() {
        for n in [
            0, 1, 2, 63, 64, 65, 127, 128, 129, 255, 256, 257, 511, 512, 513,
            1025,
        ] {
            for load in 0..6 {
                let mut seed = 0x123456789abcdefu128;
                let mut a: Vec<_> = (0..n)
                    .map(|id| {
                        seed ^= seed << 13;
                        seed ^= seed >> 7;
                        seed ^= seed << 17;
                        let key = match load {
                            0 => seed,
                            1 => {
                                if id % 97 == 0 {
                                    1u128 << ((id / 97) % 128)
                                } else {
                                    0
                                }
                            },
                            2 => {
                                (id as u128 * 256 / n.max(1) as u128) << 120
                                    | seed & ((1 << 120) - 1)
                            },
                            3 => (seed & 0xffff) << 53,
                            4 => 0,
                            _ => (n - id) as u128 / 3,
                        };
                        Record { key, id, payload: [id as u64; 3] }
                    })
                    .collect();
                if load == 2 && n > 2 {
                    a[n - 1].key &= (1 << 120) - 1;
                }
                for radix in [3, 8] {
                    for block in [1, 7, 64] {
                        for budget in [0, 256 * 1024] {
                            run_case(&a, radix, block, budget);
                        }
                    }
                }
            }
        }
    }
    #[test]
    fn cached_multiple_levels_and_large_partitions() {
        for n in [16385, 65537] {
            let a: Vec<_> = (0..n)
                .map(|id| Record {
                    key: ((id as u128 * 7919) % 65537) << 72 | (id % 7) as u128,
                    id,
                    payload: [id as u64; 3],
                })
                .collect();
            run_case(&a, 8, 64, 256 * 1024);
            run_case(&a, 3, 17, 8 * 1024 * 1024);
        }
    }
}

// Frozen reference loop, exercised only with built-in u32 digits in 0..256.
mod baseline_scatter {
    include!("stable_baseline/scatter.rs");
}

/// Internal u32 comparison with preallocated record workspace. This omits
/// ordered/variation checks and whole-sort workspace allocation deliberately.
/// Both paths perform the same digit tree and stable leaf calls on the fixtures.
pub fn kernel_u32(
    a: &mut [u32],
    scratch: &mut [u32],
    bits: usize,
    mode: usize,
) -> (usize, usize, usize) {
    assert!(scratch.len() >= a.len());
    assert!(mode < 4);
    assert!((1..=32).contains(&bits));
    if mode < 2 {
        // All scratch values are initialized u32; weakening their view to
        // MaybeUninit is safe, and the cached kernel writes only valid u32.
        let scratch = unsafe {
            std::slice::from_raw_parts_mut(
                scratch.as_mut_ptr().cast::<std::mem::MaybeUninit<u32>>(),
                scratch.len(),
            )
        };
        let mut stats = crate::reduction_node::LocalStats::default();
        if mode == 0 {
            crate::reduction_node::cached_msd(
                a, scratch, bits, 8, &mut stats, 0,
            );
        } else {
            crate::reduction_node::cached_two_arrays(
                a, scratch, bits, 8, &mut stats, 0,
            );
        }
        return (
            stats.cache_radix_nodes,
            stats.cache_scatter_records,
            stats.leaf_sorts,
        );
    }
    fn recurse(
        a: &mut [u32],
        scratch: &mut [u32],
        bits: usize,
        partial: bool,
        stats: &mut (usize, usize, usize),
    ) {
        if a.len() < 2 || bits == 0 {
            return;
        }
        if a.len() <= 128 {
            if partial {
                a.sort_by(|a, b| a.partial_cmp(b).unwrap());
            } else {
                a.sort_by_key(|x| *x);
            }
            stats.2 += 1;
            return;
        }
        let mut bits = bits;
        loop {
            let width = 8.min(bits);
            let shift = bits - width;
            let mask = ((1u32 << width) - 1) << shift;
            let mut counts = vec![0usize; 1 << width];
            for &v in a.iter() {
                counts[((v & mask) >> shift) as usize] += 1;
            }
            if counts.iter().any(|&n| n == a.len()) {
                bits = shift;
                if bits == 0 {
                    return;
                }
                continue;
            }
            let mut end = 0;
            let mut heads = Vec::with_capacity(counts.len());
            let mut ends = Vec::with_capacity(counts.len());
            for &count in &counts {
                heads.push(end);
                end += count;
                ends.push(end);
            }
            scratch[..a.len()].copy_from_slice(a);
            baseline_scatter::copy_by_histogram::<u32, u32>(
                a.len(),
                scratch,
                a,
                &mut heads,
                mask,
                shift,
            );
            assert_eq!(heads, ends);
            stats.0 += 1;
            stats.1 += a.len();
            drop(heads);
            drop(ends);
            if shift > 0 {
                let mut rest = a;
                for count in counts {
                    let (child, suffix) = rest.split_at_mut(count);
                    rest = suffix;
                    if count > 1 {
                        recurse(child, scratch, shift, partial, stats);
                    }
                }
            }
            return;
        }
    }
    let mut stats = (0, 0, 0);
    recurse(a, scratch, bits, mode == 3, &mut stats);
    stats
}

#[cfg(all(test, feature = "cf_work"))]
mod ledger_tests {
    use crate::{reduction_gate as gate, reduction_node as node};
    #[test]
    fn cached_array_reduction_has_identical_tree_and_exact_allocation_delta() {
        let source: Vec<u32> =
            (0..65537).map(|i| (i as u32).wrapping_mul(2654435761)).collect();
        let mut a = source.clone();
        let mut b = source;
        let old = node::sort_reduced(
            &mut a,
            8,
            64,
            8 * 1024 * 1024,
            node::Placement::FreeList,
            false,
        );
        let new = node::sort_reduced(
            &mut b,
            8,
            64,
            8 * 1024 * 1024,
            node::Placement::FreeList,
            true,
        );
        assert_eq!(a, b);
        assert_eq!(old.work.histogram_records, new.work.histogram_records);
        assert_eq!(old.work.scatter_records, new.work.scatter_records);
        assert_eq!(old.work.copyback_records, new.work.copyback_records);
        assert_eq!(old.work.leaf_lengths, new.work.leaf_lengths);
        assert_eq!(
            old.work.cached_depth_records,
            new.work.cached_depth_records
        );
        assert_eq!(
            old.work.metadata_allocations - new.work.metadata_allocations,
            new.cache_radix_nodes
        );
        assert_eq!(
            old.work.metadata_bytes - new.work.metadata_bytes,
            new.cache_radix_nodes * 256 * std::mem::size_of::<usize>()
        );
        assert_eq!(
            new.work.cached_depth_records.iter().sum::<usize>(),
            new.cache_scatter_records
        );
    }
    #[test]
    fn prepared_fallback_removes_exactly_one_root_variation_and_histogram() {
        let source: Vec<u128> = (0..100000)
            .map(|i| if i % 97 == 0 { 1u128 << ((i / 97) % 128) } else { 0 })
            .collect();
        let mut a = source.clone();
        let mut b = source;
        let old = gate::sort_reduced(&mut a, 8, 64, 0, false, false);
        let new = gate::sort_reduced(&mut b, 8, 64, 0, true, false);
        assert_eq!(a, b);
        assert_eq!(old.accepted_nodes, 0);
        assert_eq!(new.accepted_nodes, 0);
        assert_eq!(old.fallback_nodes, 1);
        assert_eq!(new.fallback_nodes, 1);
        assert_eq!(
            old.fallback.work.variation_records
                - new.fallback.work.variation_records,
            100000
        );
        assert_eq!(
            old.fallback.work.histogram_records
                - new.fallback.work.histogram_records,
            100000
        );
        assert_eq!(
            old.fallback.dense_scattered_elements,
            new.fallback.dense_scattered_elements
        );
        assert_eq!(
            old.fallback.work.placement_writes,
            new.fallback.work.placement_writes
        );
        assert_eq!(
            old.fallback.work.leaf_lengths,
            new.fallback.work.leaf_lengths
        );
        assert_eq!(
            old.fallback.scratch_elements,
            new.fallback.scratch_elements
        );
        assert!(new.fallback.work.placement_writes > 0);
        assert!(new.fallback.work.gather_records > 0);
        assert!(new.fallback.work.writer_records > 0);
    }
    #[test]
    fn prepared_descendant_retains_a_successful_ordered_fast_path() {
        let left: Vec<u128> = std::iter::repeat(0)
            .take(9879)
            .chain((0..121).map(|bit| 1u128 << bit))
            .collect();
        let source: Vec<u128> =
            left.into_iter().flat_map(|x| [x, 1u128 << 127]).collect();
        let mut a = source.clone();
        let mut b = source;
        let old = gate::sort_reduced(&mut a, 8, 64, 0, false, false);
        let new = gate::sort_reduced(&mut b, 8, 64, 0, true, false);
        assert_eq!(a, b);
        assert!(a.windows(2).all(|p| p[0] <= p[1]));
        assert_eq!(old.fallback_nodes, 1);
        assert_eq!(new.fallback_nodes, 1);
        assert_eq!(old.fallback_records, 9999);
        assert_eq!(new.fallback_records, 9999);
        assert_eq!(old.fallback.dense_nodes, 0);
        assert_eq!(new.fallback.dense_nodes, 0);
        assert_eq!(new.fallback.work.histogram_records, 0);
        assert_eq!(new.fallback.work.variation_records, 0);
        assert!(new.fallback.work.ordered_records >= 9999);
    }
}

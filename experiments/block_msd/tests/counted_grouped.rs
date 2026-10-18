#![cfg(feature = "frontier_work")]

use block_msd_research::frontier::{sort_pa_with_threshold, PaExperiment};
use voracious_radix_sort::Radixable;

#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
struct Record {
    key: u32,
    identity: u32,
}

impl Radixable<u32> for Record {
    type Key = u32;

    fn key(&self) -> u32 {
        self.key
    }
}

#[test]
fn grouped_counted_completion_preserves_empty_buckets_and_stable_records() {
    // Eight-byte records use grouped scatter. The highest varying byte has
    // one bit, while nonzero constant bits leave many empty digit buckets.
    // At these lengths the root exceeds even B512's dense-workspace budget.
    for (length, block) in [(65537, 3), (65537, 17), (65537, 64), (262145, 512)] {
        let mut state = 0x9e37_79b9u32;
        let mut actual: Vec<_> = (0..length)
            .map(|identity| {
                state ^= state << 13;
                state ^= state >> 17;
                state ^= state << 5;
                Record {
                    key: (state & 0x0101_0101) | 0x4400_4400,
                    identity: identity as u32,
                }
            })
            .collect();
        let mut expected = actual.clone();
        expected.sort_by_key(|record| record.key);
        let stats = sort_pa_with_threshold::<_, u32>(
            &mut actual,
            PaExperiment::UnifiedCountedKey,
            block,
            16 * 1024 * 1024,
        );
        assert_eq!(actual, expected, "n{length}/B{block}");
        assert!(stats.block_nodes > 0);
        assert!(stats.max_path_passes >= 2);
        assert_eq!(stats.nodes, 1);
        assert_eq!(stats.prepare_records, length);
        assert_eq!(stats.runs_records, 0);
        assert_eq!(stats.leaves, 0);
        assert_eq!(stats.projection_nodes, 0);
    }
}

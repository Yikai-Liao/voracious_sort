# Work and requested heap

The frozen work runner completed 200 oracle rows (50 cells) and the time runner
completed 372 separately instrumented allocation rows (62 cells). All logical
traversal, pass, leaf and record-work fields match Prepared. Eligible block
passes add one label probe each; the observed total probe delta is 0..10 per
sort. Cross-bucket physical block assignment changes, so compaction copy deltas
are measured rather than required to equal zero: -256..+128 records.

All 62 cells have exactly the same peak requested heap and allocation count as
Prepared. These measurements include workspace allocation and stable-library
leaf allocations inside the sort, and exclude input restoration and oracle
storage outside the sort. They do not measure stack space, RSS, or allocator
resident memory.

| n / B / layout / case | Groups peak bytes | Prepared | original Pa | Stable MSD |
| --- | ---: | ---: | ---: | ---: |
| 1048576 / 64 / u16 / sparse | 229888 | 229888 | 229888 | 2105360 |
| 1048576 / 512 / large128 / uniform | 33589760 | 33589760 | 33589760 | 134784664 |
| 1048576 / 512 / large128 / majority_prefix | 33589760 | 33589760 | 33589760 | 376387624 |
| 1048576 / 64 / wide32 / deep_unique98 | 1212928 | 1212928 | 1212928 | 414966888 |

The grouped kernel uses one machine-word mask for at most usize::BITS live
offsets, with two local bucket cursors; it adds no input-sized record staging
buffer. The fixed 16 MiB policy and existing Block workspace envelope are
unchanged. Full per-cell evidence is in review-work.csv and review-heap.csv;
raw allocation and counter rows are separate from timing rows.

The initial review script wrongly treated all sparse layouts as two distinct
keys and one pass. The frozen generator instead selects independent bits at
0,18,...,126 and truncates to the key width. The corrected review checks one
probe per eligible block pass. See validation/resources-review-initial-failure.log;
the input, binaries and original measurements were preserved.

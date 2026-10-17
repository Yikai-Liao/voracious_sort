# Arithmetic batched-cursor experiment: rejected

Source 4e4ff7a and the immutable time ELF recorded in binary-sha256.txt. UnifiedBatch combines the proven one-bit gate with group-local per-bucket prefix positions and one update per cursor/capacity per four records. Prepared and scalar Binary are same-ELF controls. Bucket count, scratch budget, physical block recycling, classifier/recursion and final compaction remain.

All 30 frontier tests passed in 84.06s, including original/scalar/batched full-payload stable equality, exact label-probe/record traces, all tails, irregular binary labels and matching compact/tail work. The generator test passed (1 test), and all-target/all-feature checking passed. Debug info was disabled while assertions and overflow checks remained on. The optimized narrow-screen build used native CPU, incremental=1, 16 codegen units, jobs=6, and completed in 1m51s. Optimized incremental cache was preserved; only completed unreferenced test artifacts were reclaimed.

The initial 224-row screen has wide A/A variation. Its apparent 42.6% u8-uniform regression could not be resolved from four pairs. Before further timing or source edits, CONFIRMATION.md fixed one 28-repeat, seven-slot confirmation of the same eight cells, same seed42/CPU2/ELF, preceded by a 128-repeat Pa CPU warmup. Twenty-eight repetitions cover two complete method rotations with adjacent reverse pairs. The warmup output is diagnostic, kept under profile/, and excluded from the 1,792 formal rows.

Both formal files passed their full stable oracles and source/binary, completion, slot/rep pairing, fixed-address restoration and empty-stderr validation. No compiler/test process ran during timing. Independent raw recomputation matched all eight medians and 32 candidate/reference paired medians in each file. The confirmation took 17.10s and did not replace or merge the first screen.

| Confirmation cell | Batch median ms | Batch/Prepared | Batch/scalar Binary | Batch/Stable |
|---|---:|---:|---:|---:|
| u16 sparse | 3.619 | 1.004 | 1.026 | 1.133 |
| u16 uniform | 5.650 | 1.007 | 0.991 | 0.879 |
| u16_id8 sparse | 5.238 | 1.057 | 0.899 | 0.775 |
| u16_id8 uniform | 9.573 | 1.051 | 1.029 | 0.695 |
| u8 sparse | 3.535 | 0.993 | 1.042 | 1.107 |
| u8 uniform | 3.047 | 1.003 | 1.003 | 0.723 |
| u8_id8 sparse | 5.334 | 1.047 | 1.022 | 0.763 |
| u8_id8 uniform | 4.802 | 1.031 | 1.005 | 0.510 |

The confirmation removes the initial apparent uniform regression: Batch/Prepared is 1.003 for u8 uniform and 1.007 for u16 uniform. It does not fix the target sparse gaps. u16 sparse is 1.133 × Stable by paired median, slower in 25/28 pairs; ratio p10/p90 is 0.983/1.258 and Pa A/A is 0.930/1.159. u8 sparse is 1.107 × Stable, slower in 24/28 pairs; ratio p10/p90 is 0.920/1.204 and Pa A/A is 0.941/1.033. Relative to Prepared, sparse medians are 1.004 and 0.993, so batching establishes no useful improvement. Per-pair CPU timing and payload-layout results remain in review-confirm.csv. Sample quantiles are not confidence intervals.

Static machine code shows the intended two cursor updates per group, with per-record bucket-table writes removed on that path. It also retains substantial boolean/prefix arithmetic and register spills; this observation does not quantify their contribution to elapsed time.

One unit-test comment in the frozen prototype incorrectly calls the benchmark sparse input alternating. The generator constructs its sparse key multiset from indices and then applies the existing seeded Fisher-Yates shuffle. All benchmark inputs in this report therefore use the original shuffled generator; no input was changed. Correct the comment in the next source revision rather than rewriting the frozen source snapshot.

No full-layout time build, ASan, release-work/heap campaign, extended matrix or held-out-seed run was performed. Seed 20261018 remains unseen. This candidate is rejected and the active goal remains incomplete; its arithmetic loop is retained only if needed as the explicit control for a further isolated experiment.

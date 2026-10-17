# Lookup group positions: rejected

Source e7c5e15; final immutable time ELF is recorded in binary-sha256.txt. UnifiedLookup replaces only arithmetic group-local prefix positions with a 64-byte constant table. Prepared and arithmetic Batch are same-ELF controls. The original Block radix range, heap protocol, recycling, fixup and compaction remain.

All 30 frontier tests passed in 88.06 s, including all four backends, exact label trace, full stable records, compact/tail work, odd blocks, all tails, wide fallback and the highest u64 bit. The generator and new all-registered-method full-record test passed (2 tests, 0.66 s); all-target/all-feature checking passed. Assertions and overflow checks were enabled.

The first optimized narrow build took 2 m 00 s, but its screen exited 101 before generation/sorting because the new method had not been added to three runner registration sites. The original failure files, ELF/source ledgers and profile are preserved under validation/rejected-harness/. Only the runner was corrected, and a registry execution/oracle test was added; the sorting library did not change after its 30-test run. The final incremental rebuild took 49.39 s. Native CPU, CGU 16, jobs 6 and the existing optimized cache were used.

The real screen was fixed before outcomes: 14 repeats, seven slots and eight cells, covering one complete method rotation with reverse pairs. All 784 rows passed the complete stable oracle and source/ELF, pairing, allocation-address, completion and empty-stderr validation. No compiler/test jobs ran during timing. Independent raw analysis matched all 8 medians and 32 paired-ratio fields. The run took 9.12 s.

| Cell | Lookup ms | /Prepared | /Arithmetic Batch | /Stable |
|---|---:|---:|---:|---:|
| u16 sparse | 4.347 | 1.080 | 1.048 | 1.201 |
| u16 uniform | 5.701 | 1.026 | 1.006 | 0.892 |
| u16_id8 sparse | 4.558 | 1.043 | 0.954 | 0.766 |
| u16_id8 uniform | 8.238 | 1.013 | 0.997 | 0.561 |
| u8 sparse | 3.374 | 0.981 | 0.961 | 1.061 |
| u8 uniform | 3.179 | 1.033 | 1.009 | 0.734 |
| u8_id8 sparse | 4.656 | 0.965 | 0.862 | 0.732 |
| u8_id8 uniform | 5.967 | 1.039 | 1.011 | 0.547 |

u16 sparse remains 1.201 times Stable by paired median, slower in 11/14 pairs; its p10/p90 is 0.982/1.388, with Pa A/A 0.922/1.085. Against Prepared it is 1.080, slower in 12/14; against arithmetic Batch it is 1.048, slower in 9/14. u8 sparse is 1.061 times Stable, slower in 9/14, with broad variation. Other cells and CPU ratios remain in review-screen.csv. These quantiles describe samples, not confidence intervals. No useful narrow-guard improvement is established; isolated payload wins do not satisfy acceptance.

Static assembly confirms the table load and original-order stores, but also retains substantial moves/stack accesses. Shorter arithmetic alone did not establish a useful elapsed-time improvement. The candidate is rejected. No full-layout build, extended matrix, work/heap campaign, ASan or held-out seed was run. Seed 20261018 remains unseen; the active goal remains incomplete.

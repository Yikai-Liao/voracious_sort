# Grouped binary writes: narrow screen passed provisionally

Source a088915 and the copied narrow time ELF are frozen in source/binary ledgers. This candidate groups payload writes within the current logical input block, retaining each bucket's source order. The fixed one-bit gate and Prepared policy flags remain. No heap allocation, full-record staging, independent sorter or outer key-width routing is added. DESIGN.md gives the recycling proof. Cross-bucket physical allocation order and compact copy counts can change.

Three direct tests passed in 0.70s, including every short binary label pattern, stable full payload, label-call trace, odd/small blocks, all tails, multiple word-mask chunks, u64 high bits and wide fallback. The complete 31-test frontier suite passed in 86.10s, the two runner tests in 0.44s, and all-target/all-feature checking passed. Debug assertions/overflow checks and frontier_work were enabled. The optimized native narrow build used incremental cache, CGU16 and jobs6, completing in 1m30s.

The initial fixed screen contains 576 rows (12 reps, six slots, eight cells). It showed primitive sparse gains but possible roughly 7% payload sparse regressions. CONFIRMATION.md fixed one unchanged-ELF 24-repeat confirmation of all eight cells before more outcomes. A separate 128-repeat Pa warmup is retained under profile/ and excluded from formal rows. The confirmation contains 1,152 rows and took 13.33s; the first screen took 7.53s. The two files remain separate.

All 1,728 formal rows passed the complete stable oracle, source/ELF, slot/repetition, fixed-allocation, completion and empty-stderr checks. No compiler/test jobs ran during timing. Independent raw analysis matched all 16 candidate medians and 64 paired median ratios across the two files.

| Confirmation cell | Groups ms | /Prepared | /Stable |
|---|---:|---:|---:|
| u16 sparse | 2.893 | 0.768 | 0.876 |
| u16 uniform | 5.920 | 1.004 | 0.867 |
| u16_id8 sparse | 4.694 | 0.994 | 0.752 |
| u16_id8 uniform | 9.909 | 1.006 | 0.664 |
| u8 sparse | 2.762 | 0.736 | 0.879 |
| u8 uniform | 3.246 | 1.003 | 0.773 |
| u8_id8 sparse | 4.922 | 1.037 | 0.768 |
| u8_id8 uniform | 4.908 | 0.981 | 0.497 |

u16 sparse /Prepared is 0.768 (p10/p90 0.705/0.805, 1/24 slower) and /Stable 0.876 (0.769/1.110, 3/24 slower); Pa A/A is 0.810/1.087. u8 sparse /Prepared is 0.736 (0.707/0.779, 0/24 slower) and /Stable 0.879 (0.821/0.925, 0/24 slower); A/A is 0.963/1.222. The first screen's unusually large u8 /Stable gain did not recur; retain the confirmation and original file as distinct evidence.

The initial payload sparse regressions are not confirmed: u16_id8 /Prepared is 0.994; u8_id8 is 1.037, slower in 15/24, with p10/p90 0.866/1.118 and A/A 0.896/1.130. The latter remains a final-matrix watch item. Uniform cells use the ordinary scatter fallback; their near-one /Prepared differences do not measure grouped writes. CPU ratios and full sample variation are retained. Quantiles are not confidence intervals.

Static u16/Identity code confirms vectorized mask formation followed by separate selected-record copy loops; it does not independently time those phases. This is sufficient to advance to full-layout, work/heap and ASan validation. Those checks and the fixed final matrix are not yet complete, and the active goal is not achieved. Seed 20261018 remains unseen.

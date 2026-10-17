# Reservation screen: rejected

Source commit: `24aa489`. The sole new method was `Pa_unified_reserved_t16777216`, compared with Prepared and the other controls from the same immutable narrow-screen ELF. The general reservation protocol was correct, and the intended store scheduling appeared in machine code. The screen did not meet the active goal's regression conditions.

All 192 raw time rows (8 cells × 4 repeats × 6 fixed slots) completed their full stable oracle. The runner alternates execution direction across repetitions, retains two Pa slots for A/A, pins CPU 2 and restores the same input allocation. No compiler or test process was running during these timings. Source/binary hashes, row pairing, completion and empty measurement stderr were validated. Independent raw recomputation matched all eight candidate medians and 24 paired candidate/reference medians.

| Cell | Reserved median ms | Reserved/Prepared paired median | Reserved/Stable paired median |
|---|---:|---:|---:|
| u8 uniform | 3.498 | 1.074 | 0.815 |
| u8 sparse | 3.344 | 0.836 | 1.097 |
| u16 uniform | 6.084 | 1.062 | 0.945 |
| u16 sparse | 3.603 | 0.889 | 1.026 |
| u8_id8 uniform | 4.593 | 1.033 | 0.487 |
| u8_id8 sparse | 5.073 | 1.015 | 0.787 |
| u16_id8 uniform | 8.235 | 0.995 | 0.579 |
| u16_id8 sparse | 4.905 | 0.968 | 0.816 |

In u16 uniform, Reserved was slower than Prepared in all four pairs: 1.071, 1.226, 1.054, 1.034. The Pa A/A p10/p90 was 0.977/1.040. In u8 sparse, Reserved remained slower than Stable in all four pairs: 1.076, 1.118, 1.058, 1.129; Pa A/A p10/p90 was 0.957/1.023. Wall/thread-CPU paired ratios agree on these directions. Some other cells have much wider A/A noise, so the table does not establish every small difference. Quantiles describe four samples and are not confidence intervals.

The two direct Block tests cover exact record visitation order, duplicate-ID stability and full payload equality; sizes through 4097, B=3/17/64, radix 2/256, all tails, and the wide-record fallback. Compact and tail work matched the original. All 30 frontier debug tests passed in 80.48 seconds, the workload test passed (1 test), and all-target/all-feature checking passed. One initial generator filter selected zero tests; that log is retained and the unfiltered one-test run supplies validation.

The first debug and release attempts exhausted the local disk. A second debug attempt also failed while linking. These are build failures, not sorting failures. Retained logs explain the incomplete original debug log and scoped removal of unreferenced Cargo test artifacts. Final debug tests used debug=0 while retaining debug assertions and overflow checks. Release retained native CPU optimization, incremental=1 and 16 codegen units; its successful retry took 1m53s. This is not a controlled comparison of build-cache speed.

No full-layout time build, release-work build, heap campaign, ASan run, extended matrix or held-out-seed run was performed for this rejected candidate. Seed 20261018 remains unseen. The active goal is not complete. The source prototype is archived by commit and removed from the active implementation after this report.

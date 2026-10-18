# `Pa_kernel` generic-target validation

Status at this checkpoint: **generic screen passed its original-PA material-regression gate, with one small repeatable loss in an added cell**. All results below are for the immutable generic ELF only. Native, holdout, frozen-control, memory and Work were pending at this stage; their subsequent results for the same source are in [VALIDATION_INLINE_FINAL.md](VALIDATION_INLINE_FINAL.md).

## Source, binary, machine, and oracle

Measured source commit: `6fceaaad3c20a5b5ebed3c485e41489e45829133`. Source SHA-256: `eca6b3cf68617eaec8de46fadb300e38cdcdc836fdd29700c62338daa07b7636`. Generic ELF `inline_generic` SHA-256: `8abff2f8ccd0ae44bbc9f1bd77f28fe3b21bfa790d04a819daa3419bbd917bf6`. Timed runs used CPU 2 in serial; no compile or test overlapped them.

The host exposed six vCPUs on a KVM guest with an Intel Xeon Gold 6140 at 2.30 GHz. It was not exclusive bare metal. All paired ratios and p10/p90 values are descriptive quantiles, not confidence intervals. No cross-machine or other-microarchitecture performance was measured.

Every timed process completed with return code 0 and empty per-run stderr. Audits verified the rows, slots, method order, one input address per cell, single source/ELF cohort, and complete runner output. The runner checks each warmup and each timed result against a stable `sort_by_key` oracle outside the timed interval; it compares every record's key and serial identity, including equal-key order. `Rollercoaster` has its separate key-order plus complete-record-multiset oracle.

Read-only inspection of the exact generic ELF is in `validation/inline-generic-codegen.json`. The checked u128/u16 masked scatter bodies contain direct PEXT instructions and no per-record extraction helper calls. This verifies the intended code-generation boundary for those inspected bodies; it does not predict whole-sort timings.

## Independent q64 confirmation

The initial 8-cell smoke screen had 14 repetitions and seven method slots (784 rows). It flagged `wide32/project64_spaced`, n=262,144, B512: `Pa_kernel`/original-PA median 1.0688, p10 1.0337, p90 1.1449; 14/14 repetitions were slower. The candidate duplicate-slot A/A ratio was median 1.0653, p10 0.9690, p90 1.2995, so this warranted a repeat.

The independent 16-repetition, four-slot confirmation covered that cell and the original u128/q64/B64 smoke case (128 rows total). Results were:

| Cell | Candidate / original PA median | p10 | p90 | Slower reps | Candidate A/A median (p10–p90) |
|---|---:|---:|---:|---:|---:|
| wide32, q64, B512 | 1.0315 | 0.9611 | 1.0817 | 12/16 | 1.0033 (0.9598–1.0435) |
| u128, q64, B64 | 0.7740 | 0.7669 | 0.8802 | 0/16 | 1.0059 (0.9888–1.0255) |

Neither confirmation crosses the material threshold of candidate/original-PA median above 1.05 and p10 above 1. The initial B512 signal did not repeat at its original magnitude; the independent result is a small median loss with p10 below 1. This confirms no material original-PA signal in these two q64 controls, while preserving the first run and its A/A variation in the record.

An additional generic executable ABBA control compared the previous frozen source from commit `9bba819` (ELF SHA-256 `26eeac6512119e0f8a4581cbd0cb883ccaa76e1ad6ef2813a127adcf94b147d6`) with this `6fceaaa` source. Both binaries used ordinary generic target flags. The order was old/new/new/old; each of eight process invocations used eight repetitions and four slots. All eight commands returned zero, stderr files were empty, and the script recorded each CSV hash and checked 32 rows per process. The control is a separate-executable descriptive comparison; arrays are not same-allocation pairs.

| Cell | New baseline / old baseline | New candidate / old baseline | Old candidate / old baseline | New candidate / old candidate |
|---|---:|---:|---:|---:|
| u128 q64, B64 | 0.9954 (0.8842–1.0449) | 0.8765 (0.8070–0.9380) | 1.5024 (1.3749–1.5748) | 0.5808 (0.5384–0.6504) |
| wide32 q64, B512 | 1.0034 (0.9315–1.0614) | 1.0528 (0.9759–1.1536) | 1.0576 (1.0049–1.1625) | 1.0007 (0.8848–1.0740) |

Each parenthesized range is p10–p90. In the u128/B64 cell, the previous context implementation had a confirmed slowdown versus the unchanged baseline, while the new macro version is faster than both the old baseline and old candidate; the baseline executable ratio remained near 1. In wide32/B512, the old and new candidates had effectively the same median, and the new/old baseline ratio stayed near 1. This attributes the earlier large screen signal to run variation or the pre-existing behavior, not a regression introduced by the macro change. The ABBA process resource record shows zero major faults, maximum RSS 62,960 KiB, global `pswpin` delta 30 pages and `pswpout` delta zero; the swap counts are machine-wide.

## Generic 46-cell screen

The guard cohort covers four layouts by uniform/sparse at B64 and B512 (16 cells). The information cohort covers three layouts by ten spaced/cross cases (30 cells). Together they contain 46 cells and 3,312 rows at 12 repetitions and six slots. The analyzer and independent audit used `--exclude inline-generic-extra-` so the later additions remain a separate cohort.

| Reference | Median wins | p90 wins | p10 losses |
|---|---:|---:|---:|
| Original `Pa_unified_groups_t16777216` | 40/46 | 31/46 | 0/46 |
| `Rollercoaster` | 43/46 | 37/46 | 1/46 |
| `L_frozen` (Block LSD) | 36/46 | 34/46 | 7/46 |

There were no material regression signals against original PA. These counts do not say the candidate won every cell: it lost the median comparison against original PA in six cells. `stable_msd` (Stable MSD) was not included in this generic screen; it is a separate implementation from `L_frozen` (Block LSD).

Across the 46 cells, the distribution of cell-specific duplicate-candidate A/A medians had median 0.9977, p10 0.9728, and p90 1.0251. The corresponding original-PA A/A distribution was 0.9919, 0.9603, and 1.0080. These summaries describe slot variation on this shared host.

## Seven-cell generic addition

This separate cohort contains three `large128` B512 cells at n=1,048,576 (uniform, sparse, `deep_unique90`) and four q8/q16 skew cells (`u128,wide32`, B64, n=262,144). It has 7 cells and 504 rows at 12 repetitions and six slots, using the same source and ELF.

| Reference | Median wins | p90 wins | p10 losses |
|---|---:|---:|---:|
| Original `Pa_unified_groups_t16777216` | 5/7 | 5/7 | 1/7 |
| `Rollercoaster` | 6/7 | 6/7 | 1/7 |
| `L_frozen` (Block LSD) | 7/7 | 7/7 | 0/7 |

There were no material regression signals against original PA. The `large128/deep_unique90` addition was slower than original PA in 11/12 repetitions, but its median was 1.0148, p10 1.0021, below the 1.05 material threshold. This is a small repeated loss and is why this evidence does not support a claim of no regressions.

Across these seven cells, cell-specific candidate A/A medians had median 1.0035, p10 0.9939, and p90 1.0192. Original-PA A/A was 0.9995, 0.9876, and 1.0070.

The added cells also show where comparisons to other implementations reflect existing baseline behavior. Ratios below are per-cell paired medians; lower is faster.

| Cell | Pa_kernel / original PA | Original PA / Rollercoaster | Pa_kernel / Rollercoaster | Original PA / Block LSD | Pa_kernel / Block LSD |
|---|---:|---:|---:|---:|---:|
| large128 uniform, B512 | 1.0049 | 1.1621 | 1.1689 | 0.7137 | 0.7220 |
| large128 sparse, B512 | 0.7107 | 0.6492 | 0.4671 | 1.0118 | 0.7219 |
| large128 deep_unique90, B512 | 1.0148 | 0.9132 | 0.9356 | 0.7570 | 0.7709 |
| u128 q8 spaced-skew | 0.5384 | 0.3405 | 0.1839 | 1.0322 | 0.5540 |
| u128 q16 spaced-skew | 0.5922 | 0.2428 | 0.1433 | 0.5233 | 0.3087 |
| wide32 q8 spaced-skew | 0.6184 | 0.3684 | 0.2227 | 0.8720 | 0.5684 |
| wide32 q16 spaced-skew | 0.6104 | 0.2638 | 0.1585 | 0.5063 | 0.3185 |

In this seven-cell addition, the only cell where the candidate materially lost to `Rollercoaster` was large128 uniform B512 (1.1689); original PA was also slower than Rollercoaster at 1.1621. The candidate/PA ratio was 1.0049, so this is not a new material loss against the original PA. The added cohort beat Block LSD in all seven cells, though the 46-cell information screen had seven p10 losses against Block LSD.

## Resources and evidence files

All nine run processes across smoke, confirmation, 46-cell screen, and seven-cell addition recorded zero process major faults. `ru_maxrss` ranged from 61,864 KiB to 684,284 KiB. Global `/proc/vmstat` `pswpin` rose by 6,774 pages from the first smoke snapshot through the last extra run, while `pswpout` did not change. These counters are machine-wide and cannot attribute swap activity to this benchmark. The guest had active zram swap.

Raw CSV, metadata, and stderr are preserved under `measurements/inline-smoke-q64-*`, `inline-confirm-q64-*`, `inline-generic-*`, `inline-generic-extra-*`, and `inline-nested-control-*`. The ABBA aggregate is `inline-nested-control.json`. Audits and summaries are `inline-smoke-q64-audit.json`, `inline-confirm-q64-audit.json`, `inline-generic-audit.json`, and `inline-generic-extra-audit.json`, with matching summary CSVs. The generic 46-cell audit explicitly excludes the extra prefix; the seven-cell audit includes only that prefix.

No native matrix, native information/target screen, holdout, frozen-ELF control, memory matrix, or work-counter comparison was run in this generic stage. The later integer report covers those separate cohorts. Other-machine performance remains unverified.

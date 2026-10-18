# `Pa_kernel` final-source validation

Status: **not accepted**. The ordinary-target 46-cell screen found a material slowdown in one information-boundary cell, and an independent 16-repetition confirmation reproduced it. The conditional native validation and descriptive extensions were stopped at that gate. No source or Cargo files were changed during this validation.

## Frozen source and execution

All measured rows came from commit `9bba819ca7c80733b60a9dc90cefd39a3a4f7e83`, source SHA-256 `5f73d56ca7db369432308cef48c39ea0467eb7aefde712070501ee681ae745dd`. The generic release ELF was `kernel_final_generic`, SHA-256 `26eeac6512119e0f8a4581cbd0cb883ccaa76e1ad6ef2813a127adcf94b147d6`; its metadata records an ordinary target build with runtime ISA detection. Each run checked its frozen source and executable hashes. Runs were serial on CPU 2, and no compilation or tests overlapped the measurements.

The host exposed six vCPUs on a KVM guest with an Intel Xeon Gold 6140 at 2.30 GHz. This was not exclusive bare metal. Ratios and p10/p90 are descriptive paired-repetition quantiles, not confidence intervals. No other CPU or microarchitecture was validated.

Before the failure gate, the generic screen completed three CSV cohorts: B64 guards (8 cells), B512 guards (8 cells), and information boundaries (30 cells), totaling 46 unique cells and 3,312 rows at 12 repetitions and six method slots. `audit.py kernel-generic- --candidate Pa_kernel --cells 46` verified the cells, row/slot order, common input address within each cell, one ELF hash, zero failed process return codes, and empty stderr. The runner's stability oracle passed for every warmup and timed method invocation. A generic confirmation cohort then measured the flagged cell with 16 repetitions and four slots, totaling 64 rows; its audit also passed.

For methods other than the explicitly unstable `Rollercoaster` and `Reverse_only` controls, the runner compares every output record's key and serial identity with Rust's stable `sort_by_key` oracle. This checks both key order and the stable order of equal-key records. The candidate uses the exact-record oracle.

## Generic 46-cell screen

| Reference | Median wins | p90 wins | p10 losses |
|---|---:|---:|---:|
| Frozen `Pa_unified_groups_t16777216` | 41/46 | 30/46 | 1/46 |
| `Rollercoaster` | 39/46 | 36/46 | 3/46 |
| `L_frozen` | 34/46 | 33/46 | 10/46 |

The cellwise duplicate-slot A/A median ratios for `Pa_kernel` had median 1.0032, p10 0.9760, and p90 1.0262 over 46 cells. The baseline's corresponding values were 0.9904, 0.9663, and 1.0137. These values describe slot variation in this shared guest; they are not confidence intervals. The generic screen did not include `stable_msd`, so no LSD comparison is claimed.

One cell crossed the pre-set material-regression threshold (candidate/baseline median above 1.05 and p10 above 1): `u128`, `project64_spaced`, `n=262,144`, block 64, seed 42. In the 12-repetition screen, `Pa_kernel` was 1.5565x the frozen PA median, with p10 1.5134 and p90 1.5913; it was slower in all 12 paired repetitions. Candidate A/A in that cell was median 0.9863, p10 0.9708, and p90 1.0008.

## Independent confirmation and disposition

A fresh prefix measured the same input using the same frozen generic ELF, 16 repetitions, and candidate/baseline/baseline/candidate slots. The audit verified one cell and 64 rows. `Pa_kernel` remained 1.5493x the frozen PA median, with p10 1.4671 and p90 1.6119, and was slower in all 16 paired repetitions. Candidate A/A median was 0.9876, with p10 0.8768 and p90 1.0062. The independent result confirms the material candidate-specific slowdown; this source is rejected at the generic gate.

Read-only code-generation inspection for this exact source found zero direct PEXT instructions and five extraction-helper calls in the generic u32 scalar scatter, compared with five direct PEXT instructions and zero extraction-helper calls in the context scatter. The u32 scalar/context dense paths had zero/two direct instructions and two/zero extraction-helper calls respectively. The u32 context path therefore fixes that boundary; this observation alone does not establish u128 code generation. Exact excerpts and counts are in `validation/kernel-final-generic-codegen.json`.

Subsequent u128/u16-label inspection found that the context scatter calls an outlined per-record write closure. That closure is shared with the ordinary scalar instantiation and contains two PEXT helper calls and software popcount. The outer context alone has not kept this nested kernel in the intended instruction context. This is a concrete code-generation defect to investigate; its contribution to the measured slowdown is not yet isolated. The u128 dense and boundary loops do contain direct PEXT instructions. Excerpts are in `validation/kernel-q64-u128-*.txt` and their JSON index.

## Resources, evidence, and unrun scope

All four measurement processes reported zero process major faults. `ru_maxrss` ranged from 61,720 KiB to 207,132 KiB. Global `/proc/vmstat` `pswpin` increased by 274 pages from the first screen's initial snapshot through confirmation; `pswpout` did not change. These are shared-host counters and cannot attribute swap activity to this task. The guest had active zram swap during the runs.

Raw rows, per-process metadata, and stderr files are in `measurements/kernel-generic-*.csv`, `.json`, and `.stderr`, plus `measurements/kernel-generic-confirm-u128-q64.*`. Derived summaries and audits are `kernel-generic-summary.csv`, `kernel-generic-audit.json`, `kernel-generic-confirm-summary.csv`, and `kernel-generic-confirm-audit.json`.

The following requested scopes were not run after the confirmed material regression: the seven-cell generic extras (large128 B512 uniform/sparse/deep_unique90 and u128/wide32 q8/q16 skew), native original 103-cell matrix, native 46-cell screen, seed-20261020 holdout (30 cells), frozen-executable ABBA control (17 cells), native memory matrix (32 rows), and work-count comparisons. Therefore there are no final-source native wins against `Rollercoaster`, LSD, or original PA to report, and no memory/work conclusion. The generic 46-cell ratios above are the only completed final-source performance scope. Native and other-CPU performance remain unverified.

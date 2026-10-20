# Experimental PA: pure radix repair

The current candidate contains two radix mechanisms: translated-interval completion and exact constant-tail completion. It adds no stable-comparison fallback or natural-run merge completion. The earlier hybrid results are archived and do not count as PA radix-core gains.

Latest frozen stage: `radix-v16-diagnostic`; 14 cells, 168 timings, all nine benchmark types. Full original 1045-cell schedule completed: **False**. Default adoption: **NOT ACCEPTED**. There are 7 cells with median historical candidate/PA ratio above 1.10. The complete per-cell record, A/A ranges and all slower observations are in `acceptance-cells.csv`; no aggregate speedup overrides a per-cell loss.

## Original PA weaknesses from saved data

The saved 1045-cell matrix shows a carry-width problem: at 1M records PA takes 25.49 ms on u32 uniform_numeric versus Block LSD's 8.54 ms (2.99x), and 32.01 ms on u64 versus 11.13 ms (2.88x). i32 normal is 2.76x slower than Block LSD. A narrow numeric interval that crosses a binary carry appears wide to the original prefix selection.

The low-tail case also pays unnecessary completion work: f32 low_bits_constant is 9.94 ms versus Block LSD's 4.97 ms. The exact prepared variation mask can prove that omitted low bits are constant, making a complete prefix distribution sufficient.

Run-shaped input remains a distinct weakness: f32 push_middle is 7.31x slower than saved LSD, record32 push_middle 8.81x slower than saved Timsort. Natural-run merging improved these cases but is a hybrid strategy. Those gains are excluded from the current radix-core claim, and the current mechanisms do not claim to repair all run-shaped inputs.

## Two current mechanisms

1. A bounded sample admits a possible carry-crossing interval only above the existing `512*block` workspace boundary. An exact min/max/variation proof then checks every key, preserving converted native widths. Subtract the proved minimum and use the existing grouped radix distributor only when completing the translated full key needs no more byte passes than the old first prefix. An unsampled outlier rejects the proof.
2. The existing union/intersection mask proves whether every low bit omitted by the selected prefix is constant. If so, sorting labels finishes complete keys. A separate complete-prefix classifier specializes the terminal distributor; ordinary prefix partition keeps its original constant `false` argument. This adds no record buffer, input scan, or runtime policy field. One varying low-bit outlier prevents completion.

Both paths preserve key order, stable equal-key identities and payloads. PA's original <=128-record comparison leaf, c=4/minimum-1KiB block policy and existing workspace threshold are retained. The original recursion signatures are unchanged. Rejected interval proofs call the fixed UnifiedGroups entry; this can repeat a failed order scan. The production Block LSD PR is untouched.

## Latest target results

| Type | Distribution | n | Saved PA ms | Candidate ms | Ratio | Observed ratio range |
|---|---|---:|---:|---:|---:|---:|
| record128 | high_only | 1048576 | 91.28158 | 72.30292 | 0.793 | 0.741–0.823 |
| f32 | low_bits_constant | 1048576 | 9.94474 | 6.71403 | 0.634 | 0.502–0.850 |
| u32 | low_bits_constant | 1048576 | 8.64767 | 5.41339 | 0.635 | 0.440–0.921 |
| i32 | normal | 1048576 | 25.03449 | 6.67836 | 0.266 | 0.233–0.359 |
| u32 | normal | 1048576 | 24.31434 | 8.04514 | 0.332 | 0.273–0.502 |

Ratios are medians of matched per-input candidate/saved-PA ratios and need not equal quotients of displayed timing medians. These are historical comparisons, not same-process paired causal estimates.

## Earlier 26-cell pure-radix target screen (revision 13)

This is a different frozen executable and is not pooled with revision 16. No target median lost over 10 percent. The 14 translated-interval targets had candidate/PA ratios 0.254–0.739; three low-constant-bit targets had ratios 0.546–0.615. These results identify useful mechanisms, while the broad gates prevent default adoption.

| Type | Distribution | Ratio |
|---|---|---:|
| f32 | high_only | 0.778 |
| f64 | high_only | 1.021 |
| i32 | high_only | 0.843 |
| i64 | high_only | 0.722 |
| record128 | high_only | 0.780 |
| record32 | high_only | 0.820 |
| u128 | high_only | 0.722 |
| u32 | high_only | 0.957 |
| u64 | high_only | 0.817 |
| f32 | low_bits_constant | 0.601 |
| i32 | low_bits_constant | 0.615 |
| u32 | low_bits_constant | 0.546 |
| i32 | normal | 0.254 |
| i64 | normal | 0.488 |
| record128 | normal | 0.739 |
| record32 | normal | 0.574 |
| u128 | normal | 0.499 |
| u32 | normal | 0.268 |
| u64 | normal | 0.380 |
| i32 | uniform_numeric | 0.307 |
| i64 | uniform_numeric | 0.475 |
| record128 | uniform_numeric | 0.676 |
| record32 | uniform_numeric | 0.535 |
| u128 | uniform_numeric | 0.465 |
| u32 | uniform_numeric | 0.296 |
| u64 | uniform_numeric | 0.311 |

## Losses above 10 percent

| Type | Distribution | n | Saved PA ms | Candidate ms | Ratio | Observed ratio range |
|---|---|---:|---:|---:|---:|---:|
| f64 | uniform | 1048576 | 15.54102 | 24.52957 | 1.479 | 1.182–2.083 |
| u64 | nearly_sorted | 1024 | 0.00569 | 0.00773 | 1.340 | 1.216–1.989 |
| u128 | common_prefix | 1048576 | 15.97508 | 19.70828 | 1.208 | 1.070–1.971 |
| u32 | nearly_sorted | 1024 | 0.00531 | 0.00624 | 1.175 | 1.022–1.245 |
| record32 | uniform | 1024 | 0.02021 | 0.02187 | 1.163 | 0.910–1.317 |
| f32 | uniform | 1048576 | 12.24645 | 13.93482 | 1.160 | 0.840–1.800 |
| u64 | few_unique | 1048576 | 3.61350 | 4.13294 | 1.128 | 0.738–1.290 |

The A/A fields describe observed variation, not a statistical no-regression guarantee. Repeated slow cells remain unresolved and prevent adoption. No old algorithm was rerun to normalize these results.

## Validation and measurement limits

The revision-14 library passed all 64 tests with `frontier_work`. The final classifier specialization reran the constant-tail proof test, including stable full records, nonzero constant low bits and a single varying low-bit outlier. The translated-interval tests cover carry boundaries and an unsampled outlier; every timed batch additionally passes the full order/identity/payload oracle outside timing.

The final executable retains the original PA/strict dispatch arms as compiler context, but its measurement manifest schedules only `pa_radix`. Two identical candidate slots, three seeds and two observation orders yield 12 timings from six input/ordering conditions; slots do not add independent seeds. Input digests, key widths, block and radix match saved PA. XOR output digests are compared only when repeated-batch parity matches, while every stable oracle must pass.

No compiler or correctness job overlaps timing. Native opt3/codegen1/thin-LTO, CPU 2 pinning and the existing runner/oracle are retained. All frozen stage files are hash-audited. Audit status: **PASS**; 6864 candidate-only rows across 34 completed stages, successful processes and zero process VmSwap. `validation-followup.json` records exact source/executable checks. Cross-process compiler layout and host variability remain limits; A/A cannot remove them.

Only new candidates were timed after the workflow correction. The earlier unnecessary full PA rerun is retained in `auto-baseline` and was never repeated after the correction. Other algorithms reuse sources listed in `reuse-sources.json`. `PLAN.md`, `run_auto.py`, and frozen reference files remain unchanged.

## Preserved experiments

Revisions 1–12 explored interval and hybrid run/comparison completion. Revision 11's added comparison completion failed its paired near-sorted screen; this path was removed. Revision 13 first combined both pure radix mechanisms. Revision 14 restored original recursive signatures but failed the broad gate. Revision 15 retained unmeasured original dispatch arms; its diagnostic still showed losses. Revision 16 isolates terminal-prefix specialization to preserve the ordinary partition's compile-time contract. Its 14-cell diagnostic still failed: seven median losses above 10 percent, including u64 near-sorted n=1024 at 1.340 and f64 uniform n=1M at 1.479. No full candidate matrix was started. This specialization did not resolve the broad regressions. Static evidence is stored in `leaf-disassembly-evidence.json`, `kernel-frame-evidence.json` and `wrapper-disassembly-v15.json`; changed code generation alone is not a measured causal explanation for every slow cell.

`REPORT-v3.md` and `REPORT-v6.md` preserve earlier conclusions. Every failed and noisy timing remains in its immutable stage.

| Stage | Cells | Timing rows | Runtime seconds |
|---|---:|---:|---:|
| adaptive-v10-final-gate | 76 | 912 | 98.05 |
| adaptive-v10-frontier-stress | 20 | 120 | 19.82 |
| adaptive-v10-screen | 54 | 324 | 39.64 |
| adaptive-v10-small-aa | 8 | 96 | 0.48 |
| adaptive-v10-small-ablation | 8 | 96 | 0.45 |
| adaptive-v11-small-ablation | 36 | 432 | 2.43 |
| adaptive-v5-screen | 42 | 252 | 35.35 |
| adaptive-v6-screen | 42 | 252 | 35.29 |
| adaptive-v6-small-ablation | 10 | 120 | 0.70 |
| adaptive-v7-frontier-stress | 20 | 120 | 21.36 |
| adaptive-v7-screen | 42 | 252 | 36.00 |
| adaptive-v8-frontier-stress | 20 | 120 | 19.95 |
| adaptive-v8-screen | 42 | 252 | 35.08 |
| adaptive-v9-frontier-stress | 20 | 120 | 19.72 |
| adaptive-v9-screen | 42 | 252 | 35.18 |
| adaptive-v9-small-ablation | 20 | 240 | 1.47 |
| interval-broad | 33 | 198 | 27.07 |
| interval-target | 6 | 36 | 3.33 |
| interval-v2-broad | 33 | 198 | 26.76 |
| interval-v2-target | 6 | 36 | 3.11 |
| interval-v3-broad | 23 | 138 | 21.83 |
| interval-v3-target | 4 | 24 | 2.13 |
| interval-v4-broad | 23 | 138 | 21.52 |
| interval-v4-recheck1 | 5 | 30 | 1.48 |
| interval-v4-recheck2 | 5 | 30 | 1.46 |
| interval-v4-target | 4 | 24 | 2.03 |
| radix-v13-broad | 42 | 504 | 42.59 |
| radix-v13-target | 26 | 156 | 27.66 |
| radix-v14-gate | 67 | 804 | 87.04 |
| radix-v15-diagnostic | 14 | 168 | 12.55 |
| radix-v16-diagnostic | 14 | 168 | 12.83 |
| runs-v5-broad | 23 | 138 | 21.52 |
| runs-v5-recheck | 4 | 24 | 1.54 |
| runs-v5-target | 15 | 90 | 11.88 |

Source: `/root/code/voracious_sort-workspaces/block-pa-benchmark-20261019/experiments/block_msd/src/frontier/`; branch `research/pa-benchmark-20261019`.

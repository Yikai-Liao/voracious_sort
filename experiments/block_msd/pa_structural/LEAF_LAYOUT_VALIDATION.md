# PA cached-leaf and caller-capacity screen

Status: **combined candidate rejected; cached-leaf experiment removed next**. Source `518c6f2`, fingerprint `14aaf833d7cbc3ffa0efa22587db21dee5f5265a81ef1e1262f317675516d279`. The existing Block LSD kernel is unchanged. This cohort measures PA completion and caller-side capacity choices.

The predeclared [LEAF_LAYOUT_PLAN.md](LEAF_LAYOUT_PLAN.md) follows the rejected local-completion cohort. Native instrumented library61 and float6 tests pass, including every leaf length0..128, full stable records, special float bit patterns, all three variants and exact cached-leaf/original-kernel Work equality. The native float executable is frozen at SHA-256 `491f60d1490d92a2c6c50953a427dd665533295eef5ad881ea7e214dfd8944d6`; metadata records all source, harness and plan hashes.

Eight cells use n1,048,576, B512, seed42, CPU2. Twenty repetitions rotate ten slots in both directions, with A/A for combined, original PA and prior kernel: 1,600 timed rows. Audits check one ELF, exact row order and common allocation. Complete-record oracles pass. Four reversed four-slot sixteen-repetition confirmations add256 rows. No compiler, test or other benchmark overlaps.

| Layout / case | Cached leaf / original PA | Odd capacity / original PA | Combined / original PA |
|---|---:|---:|---:|
| f32 / uniform | 1.3674 | 0.9896 | 1.3254 |
| f32 / sparse16 | 0.9196 | 0.7911 | 0.7880 |
| f64 / uniform | 1.0930 | 0.9838 | 1.0831 |
| f64 / sparse16 | 0.2186 | 0.1918 | 0.1901 |
| f32_id16 / uniform | 1.3250 | 0.9729 | 1.3543 |
| f32_id16 / sparse16 | 1.0910 | 1.0718 | 1.0793 |
| f64_id32 / uniform | 0.9779 | 0.9979 | 0.9706 |
| f64_id32 / sparse16 | 0.5313 | 0.5144 | 0.5214 |

| Combined independent confirmation | Median | p10 | p90 | Slower repetitions |
|---|---:|---:|---:|---:|
| f32 / uniform | 1.3228 | 1.2314 | 1.4039 | 16/16 |
| f32_id16 / sparse16 | 1.0688 | 0.9790 | 1.1262 | 13/16 |
| f32_id16 / uniform | 1.3549 | 1.3071 | 1.4102 | 16/16 |
| f64 / uniform | 1.0826 | 1.0438 | 1.1415 | 16/16 |

Three uniform cells repeat material regressions in all16 repetitions. The sparse16/f32_id16 signal does not repeat at the gate. The combined route is rejected and the remaining matrices stop. The isolated cached-leaf control triggers three initial material signals; sorting cached indices and then permuting records does not reduce cost in these small scalar leaves despite converting each key once. Work equality establishes unchanged distribution/geometry, not reduced instruction cost.

The isolated odd-capacity control wins paired medians against original PA in7/8 cells and against the previous kernel in8/8, with no initial material signal. Its f32_id16/sparse16 median is still1.072, with p10 below1. This is exploratory evidence only; no standalone candidate is accepted from this cohort. A separate candidate would need an independent screen on a fresh seed, a clean implementation and the full required matrices. Cache-set conflicts remain a hypothesis without hardware counters. A successful capacity change would apply to PA calling the unchanged kernel.

Native finite/special full matrices, ordinary-ISA performance, heldout inputs, frozen-original ABBA, memory and separate executable Work are not run for this rejected combination. Earlier source cohorts do not validate this source. Other machines remain unmeasured.

## Resources and integrity

- `leaf-confirm-combined-f32-uniform`: 64 rows, RSS41500KiB, major faults0, host swap-in0 pages, swap-out0.
- `leaf-confirm-combined-f32id16-sparse16`: 64 rows, RSS64904KiB, major faults0, host swap-in0 pages, swap-out0.
- `leaf-confirm-combined-f32id16-uniform`: 64 rows, RSS64644KiB, major faults0, host swap-in0 pages, swap-out0.
- `leaf-confirm-combined-f64-uniform`: 64 rows, RSS41564KiB, major faults0, host swap-in0 pages, swap-out0.
- `leaf-layout-native-float-first-b512`: 1600 rows, RSS197784KiB, major faults0, host swap-in118 pages, swap-out0.

Host swap counters include unrelated processes and cannot be attributed to the benchmark. Raw CSV, empty stderr, individual resources and immutable binary metadata are preserved. [leaf-layout-rejected-integrity.json](leaf-layout-rejected-integrity.json) records selected file hashes.

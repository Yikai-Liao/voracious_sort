# PA value-owned plan validation

Status: **rejected**. Source `a34545b`, fingerprint `00cc7987003d5b6a6b615d6a1f1fb44f71b501f03ea94ddba2ffd21f46653b3a`, native ELF `f7ea3e4f7fd1fbf879abc5288a41453541927f21e3ee53e556b2844b9f867e2c`. [PA_PLAN_PLAN.md](PA_PLAN_PLAN.md) predeclares the gates. Caller-capacity changes are removed; the current candidate changes packed classifier ownership and normalization only. Root library and frozen Block LSD source are unchanged.

Native Work library59 and float6 tests pass. The full Work structure and leaf-length arrays match scalar/context/owned variants. Saved disassembly in validation/ confirms register-mask PEXT in the owned Float32Record byte-zero specialization versus a memory-mask PEXT in the borrowed specialization. This is an instruction difference, not a measured total-speed benefit.

The original seed42 boundary, f32_id16/sparse16/B512/n1,048,576, is tested before a larger screen. Each independent run uses16 repetitions, reversed four-slot candidate/original-PA order and64 rows on CPU2. Both full record oracles and row-order audits pass.

| Run | Owned / original PA median | p10 | p90 | Slower |
|---|---:|---:|---:|---:|
| pa-plan-original-boundary-f32id16 | 1.1375 | 1.0321 | 1.1868 | 15/16 |
| pa-plan-confirm-boundary-f32id16 | 1.1382 | 1.0449 | 1.2522 | 15/16 |

The independent repeat confirms a material regression. The eight-cell fresh-seed screen and all larger ordinary/native matrices stop.

## Same-executable causal comparison

Two additional diagnostic cells use the same ELF, six rotated slots (duplicate original PA, prior packed kernel and owned candidate),16 repetitions per seed,96 rows each. They assess the adapter itself after overall rejection; they are not acceptance data.

| Seed | Owned / original PA | Owned / borrowed kernel | Borrowed kernel / original PA |
|---|---:|---:|---:|
| 42 | 1.1427 | 0.9884 | 1.1406 |
| 20261025 | 1.1676 | 1.0123 | 1.1312 |

The owned/borrowed ratios have p10 below1 and p90 above1 in both cells. Register masking does not establish a consistent whole-sort gain. Both packed routes remain slower than original PA in this boundary. Do not attribute cross-ELF differences to the adapter or retain it as an accepted speedup. No current-source generic, holdout, allocation or executable Work cohort is run. Prior-source data do not fill these gaps.

## Resources and integrity

- `pa-plan-causal-seed20261025`: 96 rows, RSS64552KiB, major faults0, host swap-in5 pages, swap-out0.
- `pa-plan-causal-seed42`: 96 rows, RSS64348KiB, major faults0, host swap-in7 pages, swap-out0.
- `pa-plan-confirm-boundary-f32id16`: 64 rows, RSS64712KiB, major faults0, host swap-in4 pages, swap-out0.
- `pa-plan-original-boundary-f32id16`: 64 rows, RSS65148KiB, major faults0, host swap-in3 pages, swap-out0.

All four serial processes return0 with empty stderr; no test or compiler overlaps timing. Host swap counters include unrelated processes and cannot be assigned to the benchmark. [Integrity hashes](pa-plan-rejected-integrity.json) preserve the selected raw, audit, assembly, build and validation evidence. Other machines remain unmeasured.

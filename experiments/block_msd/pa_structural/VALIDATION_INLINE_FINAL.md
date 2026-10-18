# Final integer validation of `Pa_kernel`

The `6fceaaa` algorithm passed the single-machine integer acceptance matrix, its generic-target screen, independent boundary repeats, fresh-seed holdout, frozen-original control, memory measurements and Work comparison. Floating-point validation is recorded separately; no integer result is used as floating-point performance evidence. Other machines and microarchitectures remain unmeasured.

## Frozen source and measurement contract

Algorithm source SHA-256 is `eca6b3cf68617eaec8de46fadb300e38cdcdc836fdd29700c62338daa07b7636`. The native release executable `inline_native` has SHA-256 `11135523958183881d54701403660ee533c2c30f8359f0f3230f115f6ad45af1`; its compiler flag is `-C target-cpu=native`. The generic release executable and its separate 46+7 cells are documented in [VALIDATION_INLINE_GENERIC.md](VALIDATION_INLINE_GENERIC.md). Metadata records the complete source fingerprint, compiler, flags, features, profile and incremental setting. No algorithm or Cargo source changed between these cohorts.

All timed processes ran serially on CPU 2, with no build or test overlap. Within a cell, methods reuse one allocation, restore the same frozen input outside timing, rotate and reverse execution order, and include repeated candidate and original-PA slots for A/A. Ratios are calculated from paired per-repetition times, averaging a method's duplicate slots. Median, p10 and p90 refer to those ratios; they are descriptive quantiles, not confidence intervals or latency guarantees. A material original-PA signal is a median above 1.05 with p10 above 1, assessed with A/A and an independent repeat. Ambiguous medians above 1.05 also receive a repeat.

Each warmup and timed result is checked outside timing against stable converted-key sorting. The oracle compares keys, identity, payload and equal-key order. The original `Rollercoaster` remains the primary comparison; it receives a key-order and full-record-multiset oracle because its original order handling is unstable. Its repaired version is a separate diagnostic, not the reported primary result. `L_frozen` is frozen Block LSD; `stable_msd` is a distinct Stable MSD implementation.

## Original 103 cells

The original input matrix contains 103 cells and 13,184 rows: 16 repetitions and eight method slots across 11 processes. [inline-final-audit.json](inline-final-audit.json) independently checks equality with the historical 103-cell input set, row order, rotations, allocation addresses, source and single-ELF identity.

| Reference | Candidate median wins | Candidate p90 wins | Candidate p10 losses |
|---|---:|---:|---:|
| Original PA | 62/103 | 19/103 | 0/103 |
| Original Rollercoaster | 85/103 | 73/103 | 12/103 |
| Frozen Block LSD | 100/103 | 89/103 | 0/103 |
| Stable MSD | 101/103 | 95/103 | 0/103 |
| `Fa` | 103/103 | 102/103 | 0/103 |

Original PA in the same executable wins the median comparison against Rollercoaster in 82/103 cells, and the p90 comparison in 70/103. The candidate expands that majority and improves the sparse-key gap to Block LSD. These are cell counts, not a weighted aggregate throughput claim. There are no material original-PA regression signals.

Selected sparse-key results at n=1,048,576, seed 42 show the requested Block LSD improvement. Lower ratios are faster.

| Layout | Block | Candidate ms | Candidate / original PA median | Candidate / Block LSD median | Candidate / Block LSD p90 |
|---|---:|---:|---:|---:|---:|
| u128 | 64 | 9.911 | 0.1204 | 0.1849 | 0.2292 |
| wide32 | 64 | 22.859 | 0.2090 | 0.2825 | 0.3142 |
| u128 | 512 | 13.392 | 0.1420 | 0.3973 | 0.4262 |
| wide32 | 512 | 27.276 | 0.2486 | 0.4774 | 0.4965 |

## Independent controls and fresh inputs

The native information/boundary screen is a separate 46-cell, 3,312-row cohort at 12 repetitions and six slots. Its prefix is `inline-native-screen-`; the script's historical name `portable-screen.py` does not change the native executable's flags. The fresh-seed holdout has 30 cells and 2,160 rows, seed 20261020, also at 12 repetitions and six slots.

| Cohort | Original PA median / p90 wins | Rollercoaster median / p90 wins | Block LSD median / p90 wins | Original-PA material signals |
|---|---:|---:|---:|---:|
| Native screen, 46 cells | 42 / 30 | 36 / 34 | 41 / 34 | 0 |
| Fresh holdout, 30 cells | 29 / 26 | 27 / 27 | 27 / 24 | 0 |

The screen has six p10 losses against Rollercoaster and three against Block LSD; the holdout has zero and two respectively. They are retained in their audit files. Neither cohort supports a claim of universal superiority.

The main matrix's `wide32/deep_unique90/B512` median ratio to original PA was 1.0544, p10 0.9910, p90 1.0979. A fresh 16-repetition, four-slot reverse-order confirmation produced 0.9959 (p10 0.9571, p90 1.0355); candidate A/A was 0.9933 (0.9201–1.0772). The first signal did not reproduce.

Two independent q64/B512 controls used 16 repetitions and four slots each. u128 was 0.9715 (0.8486–1.0544); wide32 was 1.0285 (0.9964–1.0843). The small wide32 loss is preserved. The generic-target addition also has a small repeated 1.0148 large128/deep_unique90 loss; see its separate report. Passing the material gate does not mean every cell is faster.

The frozen-original ABBA control uses original PA from source `06331aa`, executable SHA-256 `ef8dd60c19eedf6246fa62595bba3814b71c7e24a509988a6896bbc0b3c68c43`, in old/new/new/old process order. It covers 17 cells in 12 commands, with eight repetitions per process. Every command returns zero, has empty stderr, and passes the stored CSV checksum. New candidate / old original PA has 11/17 median wins and 5/17 p90 wins, with no material signals; new original PA / old original PA has 8/17 median wins and no material signals. This is a separate-executable control, so it does not have same-allocation pairing across executables. Full per-cell values are in [inline-frozen.json](inline-frozen.json).

## Work and space

The separately compiled debug Work executable is `inline_work`, SHA-256 `53b94a9626373043eb9f57639164aabb7bbbc52d7f8ef0348fdaaaccfa5b1897`, feature `frontier_work`, native flag, incremental disabled. Its timing values are not performance evidence.

Its 21 cells/63 rows cover q7/8/9/16/24/32 for u128/wide32 at n65,537 B64, q33/q64 at n262,144 B64 and B512, and large128/deep_unique90 at n1,048,576 B512. `Pa_packed` and `Pa_kernel` match on all 27 Work counters and the complete leaf-length distribution in every cell. Thus the execution-context change preserves the measured sorting work. In the deep-unique cell, original PA, packed and kernel all have 4,089,701 scattered records, 4,833 leaves and 9,848 leaf records. The earlier aggressive-projection failure remains a historical rejected cohort.

Memory runs contain 16 cells/32 rows: u32, u128, wide32 and large128, uniform/sparse, B64/B512, n1,048,576, original PA and candidate. Every candidate peak heap allocation is at or below original PA. Uniform peaks are equal. Sparse large128 peaks decrease from 4,351,825 to 206,425 bytes at B64 and from 33,588,905 to 542,129 bytes at B512. Sparse u128/wide32 peaks are equal but allocations decrease from 631 to 8 at B64, and from 499 to 8 at B512. These heap figures measure sort workspace; process RSS also includes input, oracle and runtime state.

Successful memory evidence uses `inline-memory2-b64` and `inline-memory2-b512`. A prior `inline-memory-b64` invocation supplied the unsupported alias `BASE`, returned a panic and zero measurement rows; it is preserved and excluded from all successful cohorts.

Static ownership review confirms fixed-size node-local projection state, no per-record label array, and distribution scratch released before recursion. Exact masks and the admission rules preserve original prefix geometry for partial projections. Runtime memory rows complement these invariants; they do not prove a space bound for arbitrary inputs by themselves.

## Correctness, code generation and resources

The final algorithm passes native 59 library tests; hardware-admission-disabled 59 library tests plus four runner tests; and four native runner tests. AArch64 and RISC-V library checks finish successfully. The exact generic executable has 178 inspected packed context bodies, 645 direct PEXT instructions and zero direct extraction-wrapper calls in those bodies, including the previously failing u32/u8 and u128/u16 scatter paths. Inspection scope and historical failed code generation are documented in the generic report. Cross-compilation and disassembly do not replace whole-sort measurements on real target machines.

This is a six-vCPU KVM guest exposing Xeon Gold 6140, with other services and active zram swap. No process major faults occurred in these successful native timing, memory or Work runs. Native 103-cell process maximum RSS ranges from 60,964 to 932,512 KiB; the 46-cell screen ranges from 60,924 to 207,144 KiB; holdout ranges from 60,940 to 198,440 KiB. Global swap-in deltas sum to 1,794, 265 and 48 pages within their respective processes; swap-out stays zero. The q64 controls observe 11 swap-in pages, the deep-unique confirmation one, frozen ABBA 76, memory one and Work 380. These counters are machine-wide and cannot attribute swap activity to the benchmark. The CPU and host are not an exclusive or frequency-controlled environment.

[inline-final-integrity.json](inline-final-integrity.json) records selected raw file checksums, process resources, source identity, successful/excluded memory cohorts, frozen-control checks and exact Work fields. Raw CSV, stderr and metadata remain under `measurements/inline-*`; reports and independent audits select prefixes explicitly. Other-machine performance remains unverified.

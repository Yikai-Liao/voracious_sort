# Single-path hardware checkpoint validation

Status: **not accepted**. The frozen native executable completed the original 103-cell matrix without a material regression against the frozen PA baseline, but the ordinary-target executable reproduced a large regression on `u32 sparse`. This hardware implementation therefore does not meet the cross-target acceptance bar. No Rust or Cargo file was changed for this validation.

## Frozen inputs and execution

All timings used immutable executables built from source commit `5f6d211d1e295b1dcb1204be95cf8826f0a7274d` (source SHA-256 `11cc76cf079e83b14d8f33671f516da611a4e0d845bf82db020f4fd28a9a7c3a`). The baseline was `Pa_unified_groups_t16777216`. Each runner checked the executable and source hashes, used CPU 2, and wrote a separate CSV, stderr, and JSON metadata file. Timed runs were serial; no compilation ran during timing.

The host was a six-vCPU KVM guest exposing an Intel Xeon Gold 6140 at 2.30 GHz. The native release executable used `-C target-cpu=native` and had SHA-256 `2c859d2183a832313b14398bd0adde3519763c2a4b99180fae1278c6a7b8d562`. The ordinary-target release executable had SHA-256 `51fffcb9e6816588c821a648aeb6eecc22db7a97802039cbe6e8e9fb8a4d0fc4` and used runtime ISA detection. Both belong to the same frozen source cohort; results were audited separately and not pooled across executable hashes.

The host is shared rather than an exclusive bare-metal machine. Ratios and p10/p90 values below are descriptive summaries of paired repetitions, not confidence intervals. Cross-machine and other-microarchitecture performance remains unverified.

## Native original matrix

`matrix.py --candidate Pa_packed --binary hw_single_native --prefix single-final --reps 16` completed all 11 groups. Independent analysis and `audit.py single-final- --cells 103` verified the exact original input set, all 103 unique cells, all 13,184 timed rows, complete slot/repetition order, common input addresses within cells, one ELF hash, zero runner return codes indicating failure, and empty stderr files. The runner's full correctness oracle passed for every process.

Against the frozen PA baseline, `Pa_packed` had a lower paired median in 64/103 cells, p90 below 1 in 19/103, and no p10-loss cells. The audit found zero material regression signals, where a signal is candidate/baseline median above 1.05 and p10 above 1. These results mean the native matrix did not expose a material regression against this baseline; they do not override the ordinary-target failure below.

Against `Rollercoaster`, `Pa_packed` had a lower median in 81/103 cells and p90 below 1 in 72/103. Against `L_frozen`, it won 98/103 median cells and 91/103 p90 cells; against `stable_msd`, it won 100/103 median cells and 96/103 p90 cells. The baseline itself beat `Rollercoaster` in 79/103 median cells and 66/103 p90 cells in this same executable and input matrix. Thus the candidate's broad wins over `Rollercoaster` include substantial pre-existing baseline advantage. These comparisons are descriptive context; acceptance is gated by the generic-target result as well.

The paired ratio summaries below use candidate/reference wall time, with p10 and p90 across the 16 repetitions within each cell. Rows are the full-size (`n=1,048,576`) sparse cells that include both a 64-bit and 512-bit block size.

| Layout | Block | Pa_packed / frozen PA | Frozen PA / Rollercoaster | Pa_packed / Rollercoaster |
|---|---:|---:|---:|---:|
| u64 | 64 | 0.432 (0.397–0.485) | 0.701 (0.620–0.776) | 0.303 (0.249–0.368) |
| u64 | 512 | 0.411 (0.393–0.453) | 0.568 (0.518–0.618) | 0.237 (0.220–0.254) |
| u128 | 64 | 0.197 (0.180–0.209) | 0.986 (0.862–1.155) | 0.189 (0.172–0.233) |
| u128 | 512 | 0.221 (0.197–0.244) | 1.177 (1.028–1.344) | 0.255 (0.233–0.312) |
| wide32 | 64 | 0.200 (0.193–0.226) | 1.022 (0.926–1.081) | 0.204 (0.188–0.231) |
| wide32 | 512 | 0.224 (0.207–0.250) | 1.120 (1.023–1.207) | 0.246 (0.235–0.267) |
| large128 | 64 | 0.805 (0.785–0.835) | 0.700 (0.686–0.727) | 0.564 (0.550–0.585) |
| large128 | 512 | 0.746 (0.702–0.790) | 0.675 (0.657–0.732) | 0.510 (0.491–0.534) |

Duplicate candidate slots provide an A/A timing check: their per-cell paired-ratio median was 1.009, with p10 0.987 and p90 1.033 across 103 cells. The duplicate baseline slots had median 1.000, p10 0.979, and p90 1.026. These are descriptive slot checks, not confidence intervals.

Per-run process major faults were zero in all 11 native groups. `ru_maxrss` ranged from 53,060 KiB to 932,536 KiB across runner processes. Global `/proc/vmstat` `pswpin` increased by 1,786 pages over the full sequence, while `pswpout` did not change; these are shared-host counters and cannot attribute swap activity to this workload. The guest had active zram swap before the run.

Raw native evidence is in `measurements/single-final-*.csv`, with matching `.json` and `.stderr` files. Derived summaries are `single-final-summary.csv` and `single-final-audit.json`.

## Ordinary-target `u32 sparse` regression

The original independent screen contained two cells (B64 and B512), each with 16 repetitions and four candidate/baseline slots: 128 rows total. Both showed the candidate slower in all 16 paired repetitions. A separate confirmation used the ordinary-target executable, 16 repetitions and two candidate/baseline slots per cell (64 rows total). The independent audit confirmed both cells and a single ELF hash.

| Block | Initial candidate/baseline median | Confirmation median | Confirmation p10 | Confirmation p90 | Slower paired reps |
|---:|---:|---:|---:|---:|---:|
| 64 | 2.062x | 2.025x | 1.609x | 2.116x | 16/16 |
| 512 | 2.483x | 2.498x | 2.425x | 2.603x | 16/16 |

The paired baseline A/A median in the initial screen was 0.993x for B64 and 1.007x for B512, with descriptive p10/p90 ranges spanning 1. This supports a candidate-specific regression rather than an obvious slot-order drift. The candidate's median time was 6.48 ms at B64 and 4.80 ms at B512 in the confirmation.

Read-only code-generation inspection provides a plausible mechanism, not a speed attribution: the native `u32` scatter function contains direct PEXT instructions, while the generic-target function contains no PEXT and calls `hakmem::x86::bmi2::pext_u32` from the hot loop. The disassembly evidence is archived in `validation/hw_single_{native,generic}-u32-scatter-assembly.txt` and summarized in `validation/single-path-codegen.json`. This is consistent with a per-record outlined helper call on the generic target. No source change or build was made to test that hypothesis.

Raw generic evidence is in `measurements/single-generic-u32-*.csv` and the independent confirmation is in `measurements/single-generic-repeat-*.csv`, each with metadata and stderr files. Their summaries and audits remain separate from native data.

## Scope and disposition

The native 103-cell audit is complete, but this checkpoint is rejected as a general implementation because the ordinary-target `u32 sparse` regression is large and repeated. Native-only wins cannot establish overall acceptance. The planned native information-boundary, new-seed holdout, frozen-ELF control, disabled-target, and resource/work extensions were not run after this failure was independently reproduced. No claim is made about those scopes or other CPUs.

The Rust/Cargo source and frozen executables were not modified during validation. The hardware behavior remains enabled in the tested candidate, and the software compression fallback remains disabled as described in `HARDWARE_CHECKPOINT.md`.

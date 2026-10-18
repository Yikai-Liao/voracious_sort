# PA counted completion and conservative packing: pending validation

Current source is `1e30227`, algorithm fingerprint `47e2bc518ed9101674df2d44a27c33efaf9de59937a5771f5c938e6fb4f9399e`. Native float ELF `pa_counted_float_native` is `e413b34874b23b7177a129fbcea520f2d9ab1430be8dd7a39ccdd1fd5d57fe52`. This source has not passed the full acceptance matrix. No older candidate result is transferred.

`COUNTED_PLAN.md` declares three independent methods, exact gates and later checks. The original PA and earlier packed kernel remain same-program controls. The root library and frozen Block LSD source are unchanged. The new `step_with_lengths` interface reads final bucket metadata after the existing pass; scatter/fixup/compact are unchanged.

Native instrumented correctness passed:62 library tests and6 float-harness tests. The new tests cover exact bucket lengths without an extra classification pass, stable full-record ordering across workspace boundaries, and conservative packing admission. The float harness includes IEEE special bits, identities and payloads at B3/64/512. Native release float build passed. Current-source disabled-hardware, cross-target, generic, integer-release, full matrices, held-out, frozen-old executable, allocation and Work checks remain pending.

## Previously failing boundary

The explicit f32_id16/sparse16/n1048576/B512/seed42 gate completed16 repetitions of12 rotated slots,192 rows. All three method audits passed; return0, empty stderr. Ratios below use within-repetition method means, then report the paired distribution against original PA.

| Candidate | Median | p10 | p90 | Median versus raw Rollercoaster |
|---|---:|---:|---:|---:|
| Pa_strict_counted | 1.0039 | 0.9105 | 1.1805 | 0.6828 |
| Pa_strict | 0.9934 | 0.8845 | 1.0451 | 0.6826 |
| Pa_counted_key | 1.0167 | 0.8922 | 1.0752 | 0.6895 |

No candidate crossed the original-PA median1.05 flag, so this boundary did not require confirmation. Baseline A/A was noisy (median0.9275,p10 0.8487,p90 1.3689); this is a screen pass and no demonstrated speedup. Peak RSS97,272KiB, process major faults0, host swap-in increased6pages and swap-out0; host swap cannot be attributed to this process.

## Initial8 and extension16 native float screen

The initial8 cells at seed20261026 completed1536rows, followed by16 extension cells (B64 equivalents, normal12 and subnormal) with3072rows. Every candidate was audited separately. None of the72 candidate/original-PA cell medians crossed1.05, including the ambiguous-p10 check; no confirmation was therefore triggered. These are representative gates, not full acceptance.

| Candidate | BASE median wins, first8 | BASE median wins, more16 | Raw Rollercoaster median wins, first8 | Raw Rollercoaster median wins, more16 |
|---|---:|---:|---:|---:|
| Pa_strict_counted | 6/8 | 11/16 | 6/8 | 7/16 |
| Pa_strict | 6/8 | 9/16 | 4/8 | 3/16 |
| Pa_counted_key | 6/8 | 14/16 | 6/8 | 8/16 |

Combined f32/uniform/B512 median ratio to originalPA was0.568 (p10/p90 .534/.660); f32_id16/uniform was0.720 (.664/.748). f64/uniform remains weak versus raw Rollercoaster:2.020 on this B512 screen, and f64_id32/uniform1.436. This result does not establish majority wins for float layouts as a group.

The initial8 process RSS197,856KiB; extension group RSS197,828 /57,760 /57,932KiB. Every process had0major faults and0host swap-out; host swap-in increased31 /42 /41 /16pages respectively. These are host-wide events, not process attribution. All raw groups returned0 with empty stderr.

Current-source AArch64 and RISC-V library checks passed (3.35s /3.19s); they establish cross compilation only. Disabled-hardware correctness passed62 library tests and4 runner tests; native runner4 tests also passed. Both Work executables built. A separate public-API probe in tests/counted_grouped.rs passed natively and with hardware disabled:8-byte records, one varying high-byte bit, nonzero constants, hole masks, empty buckets, tails, four block capacities and recursive counted completion. Its recorded rustc --test command links the current library artifacts directly; it is not a timing sample. Native integer release completed8m32s, generic integer9m00s, and generic float3m15s. Six immutable executables now share algorithm fingerprint47e2bc. Generic code-generation inspection checked185 packed context bodies with667 direct PEXT instructions and0outlined extraction-helper calls, including u32/u8 and u128/u16 scatter guards. This static evidence does not replace runtime checks. The26-cell native integer screen is now running. Full matrices, holds, frozen-old executable controls, allocations and Work are still pending.

Frozen executable metadata: `pa-counted-native-binary.json`, `pa-counted-generic-binary.json`, `pa-counted-float-native-binary.json`, `pa-counted-float-generic-binary.json`, `pa-counted-work-binary.json`, `pa-counted-float-work-binary.json`. Timed results are kept separate by executable hash; instrumented Work wall times are excluded.

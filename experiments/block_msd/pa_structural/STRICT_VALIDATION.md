# Final PA conservative packing cohort: pending performance validation

The user requested finishing this final attempt and then stopping. No further candidate or threshold revision follows this cohort. `STRICT_PLAN.md` declares the fixed workload and retention rules.

The algorithm is fe0afc1, source fingerprint df56e3c5a709a3d81b332ac792ca8686bda20c8b8fd2988cd6b6bd600ff2add6. Count-derived completion and its bucket-length API are removed; its confirmed rejection is archived at67925bf. The experimental block kernel is byte-identical to6fceaaa. Root library and frozen Block LSD remain unchanged.

Current-source native and hardware-disabled correctness each passed60 library tests,4 runner tests and6 float-harness tests. Full identities, payloads, stable ties and special IEEE bit patterns are checked. The native public-API probe passed actual partial packing with two saved prefix passes and fallback on a one-pass saving. The hardware-disabled probe passed all Work-field and full-record equality to original PA for five dispersed masks. Source, exact rustc commands, RLIB hashes, executable hashes and logs are in tests/strict_projection.rs and validation/strict-probes.json. AArch64/RISC-V checks passed in2.78s/2.52s; they establish cross compilation only.

Native integer release built in5m47s, generic integer4m31s, native float2m55s and generic float2m14s. Six frozen executables share this source fingerprint; features/flags and20 additional source hashes are recorded in pa-strict-*-binary.json. Generic code-generation inspection found185 packed context bodies,667 direct PEXT instructions and0outlined extraction-helper calls, including both scatter guards. This static inspection is not performance evidence.

All compilation, correctness and disassembly work finished before timing. Boundary and initial8 native float cells passed their screening gates; integer and generic screens are still pending. Full acceptance remains pending. Older accepted or rejected cohort measurements are not transferred.

## Boundary and first8 native float cells

The former failing f32_id16/sparse16/B512/n1048576/seed42 boundary has128 rows (16 repetitions,8 rotated/reversed slots). Candidate/originalPA paired median1.0284, p10/p90 .9166/1.1504; originalPA A/A median1.0218 (.8880/1.1962). No median>1.05 was flagged. This is no demonstrated speedup.

The fresh seed20261027 eight-cell native float screen has1,024 rows, with no candidate/originalPA median>1.05. Candidate median wins were6/8 against originalPA and4/8 against raw Rollercoaster; p90 wins2/8 and4/8. The four uniform layouts remain slower than Rollercoaster (ratios1.546,1.823,1.230,1.457 for f32,f64,f32_id16,f64_id32). Sparse16 ratios to originalPA were .987,.218,1.020,.545; to Rollercoaster .664,.234,.731,.448. These representative data do not establish majority wins in the full float matrix.

# Final PA conservative packing cohort: pending performance validation

The user requested finishing this final attempt and then stopping. No further candidate or threshold revision follows this cohort. `STRICT_PLAN.md` declares the fixed workload and retention rules.

The algorithm is fe0afc1, source fingerprint df56e3c5a709a3d81b332ac792ca8686bda20c8b8fd2988cd6b6bd600ff2add6. Count-derived completion and its bucket-length API are removed; its confirmed rejection is archived at67925bf. The experimental block kernel is byte-identical to6fceaaa. Root library and frozen Block LSD remain unchanged.

Current-source native and hardware-disabled correctness each passed60 library tests,4 runner tests and6 float-harness tests. Full identities, payloads, stable ties and special IEEE bit patterns are checked. The native public-API probe passed actual partial packing with two saved prefix passes and fallback on a one-pass saving. The hardware-disabled probe passed all Work-field and full-record equality to original PA for five dispersed masks. Source, exact rustc commands, RLIB hashes, executable hashes and logs are in tests/strict_projection.rs and validation/strict-probes.json. AArch64/RISC-V checks passed in2.78s/2.52s; they establish cross compilation only.

Native float release built in2m55s; current-source native/generic integer and generic float releases are pending. No performance conclusion is available for this final source. Older accepted or rejected cohort measurements are not transferred.

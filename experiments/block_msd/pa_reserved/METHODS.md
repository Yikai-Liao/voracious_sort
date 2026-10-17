# Destination reservation screen

The only new Pa policy is `UnifiedReserved`, inheriting every `UnifiedPrepared` flag and its fixed 16 MiB offline workspace threshold. Inside Block, records no larger than one machine word use four label reads, four destination reservations in original order, then four original-order raw record copies. Wide records use the existing scatter. The original scatter remains the same-ELF control.

No heap buffers, radix-range changes, additional passes or changes to recursion are introduced. The reservation loop is separately compiled with `inline(never)`; no new whole-step const boolean is added.

The first screen intentionally instantiates only u8, u16, u8_id8 and u16_id8 in the harness. This feature does not change the library. Build: `CARGO_INCREMENTAL=1 RUSTFLAGS='-C target-cpu=native' cargo build --release --jobs 6 --bin frontier_experiment --features frontier_narrow_screen`. Existing release profile uses incremental=true, codegen-units=16, debug=true. All measurements use one immutable copied ELF on CPU 2, with no compilation running.

Each cell has four repetitions with alternating execution direction and six fixed method slots: Pa, Prepared, Reserved, frozen LSD, Stable MSD, Pa. Every row checks a full stable oracle. Compare Reserved/Prepared and Reserved/Stable per repetition, together with Pa A/A. The screen comprises 192 rows, all n=1048576, B=64, seed=42. It cannot establish wide-layout or final-matrix acceptance.

Correctness checks use `CARGO_INCREMENTAL=1 CARGO_PROFILE_DEV_DEBUG=0 CARGO_TARGET_DIR=target/pa-guard-debug`, `--jobs 6` and `frontier_work`. Debug assertions and overflow checks remain enabled; only debug information is omitted to fit the local disk. Builds are sequenced after an initial disk-space failure.

# Two active bucket cursors

`UnifiedBinary` inherits every `UnifiedPrepared` policy flag and the fixed 16 MiB offline workspace threshold. Only Block bytes with a proven one-bit variation mask can use the new loop. Records wider than one machine word retain the original scatter.

For an eligible byte, one probe of the first live logical record determines constant digit bits. The low/high cursor and end pointers remain local through the pass; record stores update these locals, and bucket table state is published after the pass for ordinary fixup. Refills retain original input order, physical block reservation, usage tags and counts. The original radix range, scratch blocks, perm arrays, pass count, compaction and recursive classifier remain. No input-sized buffer is added. The diagnostic label_evals counter includes the one extra actual probe per eligible nonempty pass; other record traffic is unchanged.

The first experiment uses the narrow harness feature: u8/u16/u8_id8/u16_id8 × uniform/sparse, n=1048576, B=64, seed=42. Six fixed method slots are Pa, Prepared, Binary, frozen LSD, Stable MSD, Pa, with four repetitions and alternating execution direction, CPU 2. Full stable oracle, fixed input restoration/address, raw wall/thread-CPU and Pa A/A are required. This screen cannot establish wide-layout acceptance.

Optimized build: CARGO_INCREMENTAL=1, RUSTFLAGS=-C target-cpu=native, --release --jobs 6 --bin frontier_experiment --features frontier_narrow_screen. Release profile: incremental=true, codegen-units=16, debug=true. Correctness: CARGO_INCREMENTAL=1 CARGO_PROFILE_DEV_DEBUG=0 CARGO_TARGET_DIR=target/pa-guard-debug, --jobs 6, frontier_work. Debug assertions and overflow checks remain enabled. Builds finish before timing begins; the time ELF is copied and hashed.

# Batched two-cursor screen

UnifiedBatch shares all UnifiedPrepared policy flags and the offline 16 MiB threshold. It uses the same one-varying-bit proof as UnifiedBinary, for records up to one machine word. Original Block bucket count, scratch, perm, usage, counts, pass work, fixup and compaction remain. Prepared and scalar Binary are independent same-ELF controls.

The new loop retains two next pointers and remaining capacities. When both capacities are above four, it reads four labels, uses per-bucket prefix counts to assign the exact original destinations, and updates each cursor/capacity once for the group. No refill can occur in such a group. Near a full block, for tails and for B<=4, scalar writes retain immediate original-order refill. Final next/end bucket state is reconstructed for the ordinary fixup. One first-live-record probe per eligible pass is included in label_evals.

The native-key bit mask is computed once per pass. The batched helper is inline(never) and has no const BYTE parameter; byte-dependent shifts occur outside the record loops. This adds one helper instance per label/record type, rather than 16 const-byte bodies. Scalar Binary retains its previous const-byte loop as a separate control.

Initial screen: four repetitions, n=1048576, B=64, seed42, four narrow layouts and uniform/sparse, 224 rows. Seven method slots: Pa, Prepared, scalar Binary, Batch, frozen LSD, Stable MSD, Pa. CPU2, alternating execution direction, fixed restored input allocation, full stable oracle and Pa A/A. Full-layout and held-out acceptance are deferred until this screen passes.

Build: CARGO_INCREMENTAL=1 RUSTFLAGS='-C target-cpu=native' cargo build --release --jobs 6 --bin frontier_experiment --features frontier_narrow_screen. Profile: incremental=true, codegen-units=16, debug=true. Correctness: CARGO_INCREMENTAL=1 CARGO_PROFILE_DEV_DEBUG=0 CARGO_TARGET_DIR=target/pa-guard-debug, --jobs6, frontier_work; assertions/overflow checks enabled. Keep the optimized incremental cache. Reclaim only completed, unreferenced test artifacts as necessary for local disk capacity. No compiler/test jobs during formal timing.

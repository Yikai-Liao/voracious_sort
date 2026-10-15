# Carried boundary ID experiment

This candidate starts from `scan_experiment/full_scan.rs` at archived commit
`7233177`; it does not enable the early union-scan exit, joint histograms,
node-local finalization, or terminal batching. Its implementation is
`src/carried_boundaries.rs` and its entry point is
`carried_boundaries::block_msd_stable_radixsort(arr, radix, block_size)`.

The original setup first allocates a distinct shared boundary block for each
nonaligned logical bucket end, stores `(logical block index, physical ID)` in a
Vec, and binary-searches that Vec for every bucket prefix and suffix. The
candidate carries the previous nonempty bucket's partial suffix ID. A partial
start reuses that ID, an end in the same logical block retains it, and an end
in a later partial block allocates the next ID. Aligned ends clear the carried
ID; empty buckets preserve it.

The candidate removes the boundary Vec and its searches. It preserves the
allocation order and physical IDs, the cursor subintervals, lazy interior block
allocation, scatter loop, stream chain, global Writer, and final permutation.
Its total asymptotic space remains the archived count-first bound; only this
per-node boundary-directory allocation is removed.

The test-only old setup is retained as a local oracle. Both helpers operate on
real `Arena` instances. Tests compare every bucket's prefix/suffix IDs,
`full_pending`, `suffix_pending`, interior-chain state, cursor offsets and
ranges, free-stack contents, next/live directories, and peak-live count. Counts
0 through 4 are exhaustively combined for 1 through 6 buckets and block sizes
1 through 7 (136,710 setups), with another 1,024 sparse 256-bucket cases.
Allocation IDs are compared in logical allocation order via bucket suffix IDs,
including repeated shared IDs.

The separate integration suite checks full `(key, ordinal)` identity against a
stable oracle for six input sizes, six distributions, four radix widths and
four block sizes. It compares node/scatter/workspace/peak-block totals against
`count_first_full_scan`; with `cf_phases`, union/histogram/scatter/permutation
record counts and leaf lengths must match. Changing safe extractors exercise
both an entirely missing destination bucket and an exhausted shared boundary
subinterval; each must panic before reading an uninitialized output stream.

Validation completed: debug, release, `cf_phases`, all features together,
and AddressSanitizer integration tests all passed. The carried-boundary helper
oracle tests also passed in debug and release. No performance timing was run.

Reproduction commands (run from the repository root):

```sh
cargo test --manifest-path experiments/block_msd/Cargo.toml --lib carried
cargo test --manifest-path experiments/block_msd/Cargo.toml --test carried_boundaries
cargo test --manifest-path experiments/block_msd/Cargo.toml --features cf_phases --test carried_boundaries
cargo test --manifest-path experiments/block_msd/Cargo.toml --all-features --test carried_boundaries
cargo test --release --manifest-path experiments/block_msd/Cargo.toml --test carried_boundaries
RUSTC_BOOTSTRAP=1 RUSTFLAGS='-Zsanitizer=address' cargo test --manifest-path experiments/block_msd/Cargo.toml --target x86_64-unknown-linux-gnu --test carried_boundaries
```

Performance has not been measured in this candidate's implementation task.
Removing searches and an allocation proves less setup work, but no wall-time
speedup is claimed. The experiment coordinator runs A/B timing separately.

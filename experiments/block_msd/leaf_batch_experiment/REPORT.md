# Fixed-capacity leaf batches

This candidate changes only the scheduling of adjacent small leaves in the
count-first backend. It was derived from the frozen complete-variation-scan
source at `scan_experiment/full_scan.rs` (SHA-256
`2f5b083d2a2fa3ea5c9b49350eb8391d99a2f6b1447b864e8a37a4ecb6f4b2ce`).
The implementation is `src/leaf_batch.rs`; it leaves histogram construction,
shared boundaries, free blocks, scatter, recursion and final permutation in
place. It does not incorporate early scanning, carried boundaries, node-local
placement, joint histograms or v5 terminal fusion.

## Operation and invariants

At the child traversal of a scattered node, consecutive nonempty children with
`count <= leaf_limit` are collected while their combined length is at most 128.
Empty buckets can be skipped because they contain no intervening records. A
larger child or a capacity overflow ends the batch. Batches contain at least two
original leaves; single leaves retain the baseline path. Batches do not cross a
parent's child list.

One `Stream::read_into` call gathers the batch into a single fixed 128-record
`MaybeUninit<T>` array. Each original nonempty child's exact slice is passed to
`sort_leaf` once. One `Writer::extend` call emits the complete buffer. Stable
sorting of the original disjoint slices preserves both each leaf's equal-key
identity order and the already established order of the child buckets.

There is one gather and one write per record in this path, exactly as in the
baseline leaf path. The batch is never copied back to its source blocks. The
same 128-record capacity replaces each individual leaf's existing 128-record
buffer; there is no second record buffer. Original source blocks are released
only after their span has been copied into the batch buffer. Writer allocations
may therefore reuse any consumed source blocks without overlapping the live
stack buffer or unread input.

For `leaf_limit=0`, no leaf qualifies, so the pure radix traversal and terminal
transfer path are unchanged. Terminals larger than the leaf limit also retain
the original transfer path. The optional `cf_span_leaf` feature disables
batching, preserving that separate feature's no-gather path. The optional
`cf_std_leaf` feature still chooses the same per-leaf stable standard-library
sort; its internal workspace is not added or removed by batching.

## Interfaces and counters

- `block_msd_stable_radixsort(arr, radix, block_size) -> Stats` uses limit 128.
- `block_msd_stable_radixsort_body(arr, radix, block_size, leaf_limit) -> Stats`
  supports the baseline's limit range, including zero.
- `sort_with_batch_stats(arr, radix, block_size, leaf_limit) -> (Stats, BatchStats)`
  records leaf sort calls, high-level gather/write calls, leaf records, number
  of multi-leaf batches, number of leaves in those batches and maximum batch
  size. These counters cover the gather-based leaf paths, rather than the root
  fast path or optional span leaves.

The ordinary timing entry points instantiate `COLLECT=false`; extra diagnostic
counter increments are compiled out. The diagnostic path instantiates the same
control flow with `COLLECT=true`. The arena has a fixed-size `BatchStats` field;
there is no dynamically allocated statistics collection. Existing `cf_phases`
counters preserve the original per-leaf length histogram and record counts.

The deterministic 12/18/9/21 leaf example, alongside a separate 200-record
constant terminal to keep the root on the block path, produces four original
sort calls, one gather, one Writer call and 60 leaf records. Exact-capacity and
overflow tests exercise 128-record batches and the start of the next batch.

## Validation

`tests/leaf_batch.rs` compares complete output records and equal-key identities
against both stable `sort_by_key` using converted radix keys and the frozen
count-first source. It also compares node count, scatter work and scratch record
capacity. With `cf_phases`, it checks exact equality of union, histogram,
scatter, gather and Writer record counts and the original leaf-length histogram.

Coverage includes partial physical blocks, block sizes from 1 to 512, radices
1/3/5/7/8, zero and small leaf limits, recursive mixtures of large and small
children, exhaustive binary words of lengths 2 through 9, restricted Rust values
(`NonZeroU32`, a sparse enum and references), NaN payloads and signed zeros under
converted-key order, and full identity preservation for equal keys.

Validation logs and exact commands:

```sh
cargo test --manifest-path experiments/block_msd/Cargo.toml --test leaf_batch
cargo test --manifest-path experiments/block_msd/Cargo.toml --test leaf_batch \
  --release --features cf_std_leaf,cf_phases
RUSTC_BOOTSTRAP=1 RUSTFLAGS='-Zsanitizer=address' cargo test \
  --manifest-path experiments/block_msd/Cargo.toml \
  --target x86_64-unknown-linux-gnu --test leaf_batch \
  --features cf_std_leaf,cf_phases
cargo test --manifest-path experiments/block_msd/Cargo.toml --test leaf_batch \
  --all-features
```

- `debug.log`: 7 debug tests passed.
- `release-phases.log`: 7 release tests passed with standard stable leaves and phase counters.
- `asan.log`: 7 AddressSanitizer tests passed with phase counters and standard stable leaves.
- `all-features.log`: 5 compatibility tests passed; the two batching-count tests
  are disabled because `cf_span_leaf` preserves its own separate baseline path.

No timing measurements were run by this candidate's author. Reduced high-level
call counts alone do not establish a speedup. Scatter and final permutation
work remain, and gathering a whole batch before writing changes physical block
allocation order even though logical order and record-copy counts are retained.

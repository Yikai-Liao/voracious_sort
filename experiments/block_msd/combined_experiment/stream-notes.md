# Combined stream candidate: carried boundaries and leaf batching

`src/combined_stream.rs` composes the two independent stream candidates. Its
starting point is `src/leaf_batch.rs` (SHA-256
`e70a3613e95ab7dcb0f6f26bc4e35e358b5a534d65a3bdc6d75e3b028ecd81b3`).
The `setup_buckets` function is copied from `src/carried_boundaries.rs` (SHA-256
`13280c9644712bd75d755c58c0d0513aad6d749915148cbc4d7fdc359ca7c72f`).

The composition replaces the boundary array and its binary searches with the
same carried partial-tail block ID. It also retains the fixed 128-record leaf
batch: one gather, separate stable sorts of the exact original leaf slices,
and one Writer call. The former stream boundary-array lifetime has been removed.
The variation scan remains the complete scan used by both individual candidates.
No change has been made to scatter, block ownership, global Writer or final block
permutation. No node-local materialization policy or joint histogram is included.

The two changes act at different stages. Carried boundaries preserve the setup's
physical ID allocation order, including partial blocks separated by empty buckets.
Leaf batching preserves each leaf's comparison problem and stable order, while
combining only high-level gather/write calls. Batching can change subsequent
physical allocation order relative to the unbatched baseline, but the combination
must match the leaf-only candidate's allocation order and final permutation work.
The combination retains the same block scratch capacity and the same single
fixed 128-record leaf buffer.

## Entry points

- `combined_stream::block_msd_stable_radixsort(arr, radix, block_size) -> Stats`.
- `combined_stream::block_msd_stable_radixsort_body(arr, radix, block_size, leaf_limit) -> Stats`.
- `combined_stream::sort_with_batch_stats(arr, radix, block_size, leaf_limit) -> (Stats, BatchStats)`.

The timing entry points keep `COLLECT=false`; the additional `BatchStats`
increments are compiled out. The diagnostic entry point instantiates
`COLLECT=true` as in the leaf-only candidate. Both variants retain existing
optional phase instrumentation. `leaf_limit=0` preserves the pure-radix path.
`cf_span_leaf` retains its separate no-gather leaf behavior and disables batching.

## Verification

`tests/combined_stream.rs` sorts each tested input with the frozen full-scan
backend, carried boundaries alone, leaf batching alone and the combination.
Each result must equal a stable reference by converted radix key, including all
record identity/payload fields. Node counts, scatter record work and scratch
capacity must agree. The combination's seven batch counters and peak live block
count must match leaf-only. With `cf_phases`, the tests also compare union,
histogram, scatter, gather and Writer record counts, original leaf-length
histograms, and final permutation record work for the relevant pairings.

The integration cases retain the leaf candidate's exact-capacity and overflow
examples, 12/18/9/21 four-leaf example, partial physical blocks, mixed recursive
children, zero and small leaf limits, exhaustive binary words of lengths 2..9,
restricted-validity Rust values, NaN payloads and signed-zero converted-key order.
The copied internal setup oracle additionally compares all bucket IDs, pending
lengths, cursor offsets, free-stack state, links and live bits against the legacy
boundary array for exhaustive small counts and sparse 256-bucket cases.

No performance measurements are performed in this subtask. Performance results
must come from the root's common serial benchmark after compilation has stopped.

Commands and logs:

```sh
cargo test --manifest-path experiments/block_msd/Cargo.toml \
  --test combined_stream
cargo test --manifest-path experiments/block_msd/Cargo.toml \
  --lib combined_stream::setup_tests
cargo test --manifest-path experiments/block_msd/Cargo.toml \
  --test combined_stream --release --features cf_std_leaf,cf_phases
RUSTC_BOOTSTRAP=1 RUSTFLAGS='-Zsanitizer=address' cargo test \
  --manifest-path experiments/block_msd/Cargo.toml \
  --target x86_64-unknown-linux-gnu --test combined_stream \
  --features cf_std_leaf,cf_phases
```

- `stream-debug.log`: 7 debug integration tests passed.
- `stream-setup.log`: 2 internal setup oracle tests passed.
- `stream-release-phases.log`: 7 optimized integration tests passed with standard
  stable leaves and phase counters.
- `stream-asan.log`: 7 AddressSanitizer integration tests passed with the same features.

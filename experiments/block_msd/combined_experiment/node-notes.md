# Node-local finalization with carried boundary IDs

The combined candidate is `node_local::Placement::CarriedFreeList`, selected
through `sort_with_placement(arr, radix, block, cache_budget, placement)`.
`Placement::FreeList` remains available as the paired baseline;
`Placement::PrefixWriteback` remains an independent placement experiment.

`partition` and the new crate-visible `partition_carried` use one shared
`partition_impl`. Their only branch occurs before scatter, where the setup
helper chooses either the original boundary Vec plus binary searches or the
previously validated carried suffix ID. There is no new per-record scatter
branch. The original setup helper returns its boundary Vec to the caller so
that its allocation stays live through assembly, preserving the baseline's
allocation lifetime.

Both versions use the same free-list, source-block reclamation, dense bucket
assembly, per-node final permutation, cache-admission calculation, contiguous
stable MSD, and recursive child order. The carried version keeps the same
physical boundary allocation order and IDs while removing the boundary lookup
Vec. Parent block workspace is still destroyed before child recursion. Neither
terminal batching nor joint histograms nor prefix writeback is included here.
The original standalone `carried_boundaries` candidate remains unchanged.

`node_local::carried_setup_tests` compares the two production setup helpers on
real Arena instances: exhaustive 0..4 bucket counts for 1..6 buckets and blocks
1..7 (136,710 cases), plus 1,024 sparse 256-bucket cases. Comparisons include
prefix/suffix IDs, interior state, cursor offsets, pending full/suffix records,
free/live/next directories and peak-live count.

`tests/node_local_carried.rs` checks complete stable `(key, ordinal)` identity
against a stable oracle, and equality of every LocalStats field against
`Placement::FreeList`. Its matrix covers empty/singleton/leaf inputs and
129/257/1025/4099 records, six distributions, radices 1/3/8, blocks 7/64/129,
and cache budgets zero/default 256 KiB. A 65,537-record case requires exactly
one large block node followed by contiguous cache sorting. Restricted record
values (`NonZeroU32`, enum tags and references) and changing safe extractors
exercise unsafe copy/permutation and panic guards.

Validation: the two setup-oracle tests passed in debug and release. Both the
existing node-local suite and the new carried suite (four tests each) passed
in debug, release and AddressSanitizer. All builds are complete, and no
performance process was started by this implementation task.

Validation commands from the repository root:

```sh
cargo test --manifest-path experiments/block_msd/Cargo.toml --lib node_local::carried_setup_tests
cargo test --manifest-path experiments/block_msd/Cargo.toml --test node_local_carried --test node_local
cargo test --release --manifest-path experiments/block_msd/Cargo.toml --test node_local_carried --test node_local
RUSTC_BOOTSTRAP=1 RUSTFLAGS='-Zsanitizer=address' cargo test --manifest-path experiments/block_msd/Cargo.toml --target x86_64-unknown-linux-gnu --test node_local_carried --test node_local
```

No performance measurement was run during this implementation task. The
experiment coordinator performs the paired timing with the same cache policy.

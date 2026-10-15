# Budgeted next-digit histogram experiment

This independent candidate starts from `scan_experiment/full_scan.rs` at
archived commit `7233177`. It retains the original shared-boundary lookup,
complete variation scan, stream chains, leaf sorting, Writer and final
permutation. It does not incorporate the carried-boundary candidate.

`src/joint_histograms.rs` exposes:

- `block_msd_stable_radixsort(arr, radix, block_size) -> Stats`, with a fixed
  512 KiB additional statistics budget;
- `sort_with_budget(arr, radix, block_size, statistics_budget_bytes) ->
  (Stats, JointStats)`, including zero-budget fallback.

After the current digit's ordinary histogram is available, a joint table is
admitted only if there is another digit and at least one child exceeds the
unchanged 128-record leaf limit. The existing scatter still writes only
`2^width` output buckets. It additionally counts `(current digit, next digit)`
for each input record into a flat `usize` table. Next-digit indices are checked
against the row width before updating the table.

A child receives a borrowed row and its exact mask/shift. The child's complete
variation scan still runs. If that scan skips constant digits and selects a
different mask or shift, the row is rejected and the child scans its records
normally for counts. A matching row is copied into the child's usual ordinary
histogram Vec; that Vec already exists in the baseline. Leaves and all-equal
terminals do not need their prepared row. No extra scatter digit is introduced.

One `JointBudget` account covers the full serial DFS. Each allocation reserves
its entire Vec capacity in bytes. The parent's whole table remains charged
while all descendants and unvisited sibling rows remain live. A new table is
refused when its capacity would exceed the remaining budget; the affected
node follows the normal histogram path. The Vec is dropped before its charge
is released, and the account is asserted empty at return. Consequently the
additional joint-table storage is at most the caller's fixed byte cap,
independent of input length. Ordinary per-depth `O(sigma*d)` histograms and
metadata remain part of the archived backend's space usage; allocator metadata
and fixed Vec headers are not table payload bytes.

`JointStats` records `peak_bytes`, `peak_tables`, `tables_built`,
`tables_denied`, `hist_scanned_records`, `hist_reused_records`,
`prepared_rejected_records` and `joint_updates`. The accounting explicitly
keeps the moved count operations: preparing a row costs updates even when the
row is later discarded or belongs to a terminal child. Tests require
`hist_scanned_records + hist_reused_records == dense_scattered_elements` and
`hist_reused_records <= joint_updates`. Under `cf_phases`, histogram record
visits count only actual histogram scans, while union/scatter visits and leaf
sizes must remain equal to the archived backend.

Integration tests cover complete stable `(key, ordinal)` identity for six
sizes, six distributions, four radix widths, four block sizes and budgets
0 / 4 KiB / 512 KiB. Dedicated tests keep 1 / 2 / 3 full 256×256 tables live
at once, verify the cap and denied descendants, and verify fallback when a
constant prepared digit is skipped. Safe extractors that change their counts,
overrun a short shared interval, or return an invalid next digit must panic
before any uninitialized output stream read.

Validation completed: debug, release, `cf_phases`, all features together,
and AddressSanitizer each passed all four integration tests. No performance
timing was run.

Reproduction commands (run from the repository root):

```sh
cargo test --manifest-path experiments/block_msd/Cargo.toml --test joint_histograms
cargo test --manifest-path experiments/block_msd/Cargo.toml --features cf_phases --test joint_histograms
cargo test --manifest-path experiments/block_msd/Cargo.toml --all-features --test joint_histograms
cargo test --release --manifest-path experiments/block_msd/Cargo.toml --test joint_histograms
RUSTC_BOOTSTRAP=1 RUSTFLAGS='-Zsanitizer=address' cargo test --manifest-path experiments/block_msd/Cargo.toml --target x86_64-unknown-linux-gnu --test joint_histograms
```

No timing result is claimed here. This candidate removes some independent
histogram record reads but retains the complete variation scan, adds random
joint-table writes, zero-initialization and per-record next-digit extraction,
and can prepare unused rows. Its wall-time tradeoff requires the coordinator's
separate A/B experiment.

# Bounded minority-buffer candidates

`src/skew_paths.rs` implements two separate candidates. Neither changes the
production sorter or the default count-first path. Performance remains to be
measured with the common runner.

`Mode::SingleLayer` counts the highest varying digit and selects its largest
bucket. If the other records, their original positions, the histogram and the
minority scatter cursors fit the budget, it scatters only the minority records
to their stable bucket positions in scratch. The majority is moved directly to
its final interval. Minority subbuckets use the unchanged correct low-space
backend; the largest continuous subbucket repeats the experiment. Temporary
record and hole buffers are dropped before any subbucket is sorted. The small
histogram remains live during minority fallback calls and is dropped before
the majority loop continues. This choice tests the proposed skew-chain path;
it does not recursively enable the special path in minority siblings.

`Mode::DeferredChain` retains the majority in the initial array. Each layer
counts only records outside a sorted directory of original hole positions.
Minority records are appended to one bounded record buffer; a second bounded
hole directory is rebuilt in original position order and swapped in after
extraction. Budget admission happens before extracting the next layer. If it
fails, all prior holes and buffered siblings are flushed relative to the
original entry slice. The rejected digit is still included by the subsequent
full-key backend call on the restored majority interval.

At flush, a stable bottom-up merge sort orders buffered minorities by the full
converted key using an explicitly allocated bounded record scratch. Equal
keys cannot have been extracted at different chain levels: separated siblings
differ at the first separating digit. Thus append order preserves original
order within each equal-key group. Each separated sibling is entirely less
than or entirely greater than the surviving majority by the fixed prefix.
Summing counts of preceding siblings therefore gives its final left offset;
the sorted minority buffer can be split exactly at that offset.

Both candidates share `compact_major`. In a gap preceded by h holes, the
majority's displacement is L-h, where L is the final number of minority records
before the majority. Positive-displacement gaps are copied in reverse gap
order with overlap-safe `ptr::copy`; negative gaps are copied in forward order;
zero-displacement gaps are untouched. The displacement is monotone with gap
order, so the two copied regions cannot overwrite one another's unread source.
The original array contains valid `Copy` records throughout. No zeroed or
uninitialized value of a generic record type is exposed.

`major_records_moved` counts actual majority records in nonzero-displacement
gaps. For a single accepted node, each such record is copied once. For one
deferred chain, each surviving majority record is copied at most once at the
single flush. This excludes fallback movement and movements of records peeled
as minorities at an earlier layer. It does not prove an O(n) global movement
bound across later backend work.

The default experiment-owned workspace payload budget is 256 KiB. All admitted
allocations are charged by `Vec::capacity`, including histogram/cursors and
record/position buffers. The deferred candidate reserves two record arrays
(minorities and merge scratch), two position arrays (current and rebuilt hole
directories), and room for two maximum-width histograms before computing its
fixed minority capacity. It actually uses one histogram at a time. The single
candidate allocates exact-size buffers for each accepted layer. Both release
record and position buffers before fallback. Small fixed stack values,
`Vec` headers and allocator headers are excluded, and the unchanged fallback's
own low-space workspace is separate; the algorithm as a whole is not claimed
to have a fixed 256 KiB bound. The reported `peak_workspace_bytes` measures
experiment-owned payload capacity, including preallocated unused capacity.

Rejected nodes still incur the variation/histogram decision scans. Deferred
mode preallocates its bounded buffers before finding out whether any layer is
accepted. These are prototype tradeoffs included in timing, not hidden costs.
Key conversion must be deterministic, as in the existing sorters. This module
uses the converted-key digit directly and never synthesizes payload values from
keys.

Validation includes an exhaustive model integrated as a Rust unit test: every
hole subset for lengths 1 through 12, every possible L, payload order, and exact
movement count against the original-position oracle. Integration cases cover
all radix widths 1 through 8, tiny and tail lengths, repeated-key identities,
minorities on both sides, multi-level chains, later-level budget rejection,
`NonZero`/enum/reference payloads, and float NaN bit patterns ordered by
converted key. Native debug/release and sanitizer results are recorded by the
common validation run.

The following native commands passed on 2026-10-15: all five skew integration
cases and the exhaustive compact-major unit test passed in debug, release,
and AddressSanitizer builds. The `--lib` runs also passed the three other
currently integrated library tests. Existing dependency warnings remain.

```sh
cargo test --manifest-path experiments/block_msd/Cargo.toml --test skew_paths --lib
cargo test --release --manifest-path experiments/block_msd/Cargo.toml --test skew_paths --lib
RUSTC_BOOTSTRAP=1 RUSTFLAGS='-Zsanitizer=address' cargo test --manifest-path experiments/block_msd/Cargo.toml --target x86_64-unknown-linux-gnu --test skew_paths --lib
```

No performance measurements were run by this implementation task. The common
runner must include all decision scans, preallocation, merge sorting, flushes
and fallback work in the measured interval.

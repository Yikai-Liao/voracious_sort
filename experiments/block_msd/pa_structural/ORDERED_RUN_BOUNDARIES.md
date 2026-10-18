# Ordered run boundaries: independent structural candidate

Status: design only. No Rust source changed and no candidate wall time measured.
The frozen checkpoint validation proceeds independently.

## Existing Rust implementation, checked after the user's pointer

Prefer evaluating `slice-group-by = 0.3.1` before maintaining a local search.
It exposes `GroupByMut::exponential_group_by_key_mut` and
`exponential_search_by`. The former returns disjoint mutable groups and fits
child recursion directly. The latter can search with a captured current label
and return the first different-label index by returning only Less/Greater.

Read the actual implementation rather than assuming identical probe counts.
The grouped-by-key iterator evaluates the first key again inside its comparison
closure. Its exponential search brackets using offsets 1, 2, 4, ... and then
calls standard binary search on an interval that includes known probe positions.
These are valid semantics, but the small-run classification count differs from
the uncompiled local sketch below. The independent screen must measure actual
calls and whole-sort behavior; library reuse alone does not establish a gain.
Do not alter Cargo or the frozen source hash while checkpoint validation runs.

Primary sources inspected:

- https://docs.rs/slice-group-by/0.3.1/slice_group_by/
- https://docs.rs/slice-group-by/latest/src/slice_group_by/exponential_group/exponential_group_by_key.rs.html
- https://docs.rs/slice-group-by/latest/src/slice_group_by/lib.rs.html
- https://doc.rust-lang.org/std/primitive.slice.html#method.partition_point

Standard `slice::partition_point` supplies the binary-search part, but it does
not perform a doubling search from the start of the run.

## Work to remove

After `partition` stably sorts a node by its fixed classifier, `pa.rs` walks
every record again to find equal-label child runs. The `local_distribution`
high-byte split performs another full walk for the same purpose. Both
sequences are known to be monotone in the label being examined. Searching an
ordered run's end can exploit that fact instead of evaluating every label.

This direction needs neither bit compression nor an instruction-set library.
It also preserves today's classifier, node fanout, leaf sizes and workspace
budget. It is distinct from the rejected experiment that merely carried the
next run's first label across recursion: that experiment retained the full scan.

## Boundary algorithm

For a run beginning at `start`, evaluate its current label once. Probe relative
positions 1, 2, 4, 8, ... until a different label or the slice end is found.
The last matching probe and the first different probe bracket the boundary.
Binary-search only the unexamined interior of that bracket. A known different
probe is excluded from the binary search, so it is not evaluated twice.

The predicate `label(arr[i]) == current` is true for a prefix and then false
through the remainder of the slice. This follows from sorted labels; it is not
a property inferred from an input sample. The result is the same first index
that today's linear walk returns.

For singleton runs, the calls are the current record and the next record,
exactly as in the old loop (one call for the last singleton). Two-record runs
also require the same number of calls. Intermediate short lengths can require
an extra call. Long runs need logarithmically many label evaluations instead
of one per record. These counts do not imply a wall-time gain: probe arithmetic,
branches and less sequential access may dominate for short runs.

Implement bounds in relative coordinates. Double a probe only while it is less
than the remaining slice length and cap it at that length; do not allow index
or step overflow. The helper must never classify the one-past-end position.

## Ownership and stability

The search only reads initialized records and retains no references across
recursion. Find one complete boundary, release the shared borrow, and visit
that child exactly as before. A child can permute its own records because
every one of its records has the same parent label. Later parent labels and
unprocessed positions therefore remain valid for subsequent searches.

This changes no distribution, scatter, compaction or block recycling operation.
It adds no n-dependent storage and no facts for a child that could become
stale. Terminal partitions continue to skip boundary discovery entirely.

The high-byte local-distribution use is valid for the same reason: its first
split sorts by exactly that high byte before lower bytes are completed within
each run. Do not apply the helper to an unsorted classifier sequence.

## Independent screen

Start as a separate policy with only PA run-boundary discovery changed. Keep
the original linear policy in the same executable. Compare against frozen
checkpoint code, not a reference silently changed by a shared helper.

Correctness should cover every boundary of constructed sorted label sequences,
singletons, empty/last brackets, awkward tails, all-equal runs and child
recursion. Full key/ID/payload oracles must match. Work counters must show equal
partition geometry, scatter and leaf work, with reduced boundary label calls
on long-run controls. Increased calls on small runs must remain visible.

The first timing screen needs uniform u32/u64/u128 (many small runs), sparse
and few-key data (long runs), deep prefix data, both block sizes, and wide
payloads. The existing large128 regression cell is a required control. If it
passes, test the local high-byte use as a separate addition. Do not initially
stack this with the proposed CPU kernel-context change: one removes calls
algorithmically and the other changes their generated execution cost.

Keep it only if paired end-to-end results support the gain without material
regressions. No record-count admission threshold is proposed here; an
unconditional algorithmic replacement must earn its place on the mixed screen.

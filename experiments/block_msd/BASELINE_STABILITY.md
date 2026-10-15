# Existing stable MSD baseline regression

`cargo run --bin baseline_probe` reproduces a failure with **129 records**, the first length above the library's128 fallback:

`source[i] = { key: (129-i)/2, ordinal: i }`, i=0..128.

PartialEq and PartialOrd both compare only key. The oracle is stable `sort_by_key(key)` and separately compares every key/ordinal identity. At output index1 the expected record is `(key1,ordinal126)`, but `msd_stable_radixsort(...,8)` returns `(key1,ordinal127)`.

The snapshot `baseline_verge.rs` is copied directly from the repository's `src/algo/verge_sort_heuristic.rs`; the probe calls this preprocessing with a stable std fallback. It produces separators `[0,129]`, keys correctly sorted, but the same identity mismatch **before MSD radix recursion or k-way merge**. A separately coded conventional stable histogram/prefix MSD body without Verge passes the entire identity oracle. That comparison body is not a call to the repository's private helper.

The source cause is non-strict descending run exploration followed by `.reverse()` at the DescOnly/descending branches. Reversing a run containing equal keys reverses the equal-key records as well. Fix options for a separate change: require strictly descending runs, or reverse each equal-key group when normalizing a non-increasing run. Shared preprocessing feeds stable and unstable algorithms, so the stable caller's contract must be preserved. No production fix is mixed into this experiment or the LSD PR.

The geometric benchmark now marks failed existing-MSD rows `status=unstable_baseline` and records the first mismatch, instead of treating that time as a valid stable-sort comparison or aborting the remaining grid. Experimental/LSD identity failures still abort. The original partial v4-262144 CSV predates status reporting and stopped on large128 descending; it is incomplete and should not be used as a complete grid.

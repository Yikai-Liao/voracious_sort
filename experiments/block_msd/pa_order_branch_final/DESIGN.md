# Unified Pa with local comparison and scatter kernels

One Pa node/partition/recursive scheduler and Block backend serves all key
widths. The node-size prefix budget, heavy-child shared-prefix classifier and
bounded local distribution operate within that same mechanism. All final
flags remain those of UnifiedGroups at `2513fa5`; the 16 MiB cache gate is unchanged.
There is no external dispatch to another LSD/MSD sorter.

The allocation budget remains 512 * block_size * size_of(T). The offline
16 MiB parameter is a cache-footprint gate on that budget, not a heap cap.
The uncached Unified control groups the high label byte unconditionally;
cache-aware paths can finish the full label directly when that grouping is
unhelpful. Sampling is a cost gate for the physical schedule, while the full
variation mask remains the correctness source. Prepared distribution reuses
that existing mask rather than scanning labels again. Scratch dies before
recursive children; local dense runs must fit the same Block budget.

The established grouped-scatter stability/recycling proof remains
[the original design](../pa_groups/DESIGN.md). Original and grouped pointer
loops are unchanged. Scalar scatter has one inline(never) boundary, allowing
its record-write statements to inline in an outlined byte-pass function. The
failed Direct macro copy and its policy have been removed.

Order proof owns all new state. first_different accumulates OR(key XOR first)
per128-record tile; zero is equivalent to equality for every native key bit.
A failing tile is searched in source order for its exact first different key;
remainder handling is unchanged. Key evaluation order and count are preserved.

Monotone proof retains the existing adjacent-pair tile reduction for keys up
to native word width. Software-wide keys exit within that same loop on their
first violating pair, which prevents scalar comparison predicates from being
packed into full-tile masks. This compile-time comparison-capacity choice stays
inside the private order proof; it does not choose a sorting algorithm or add
a policy flag. Successful proofs read the same pairs; failed wide proofs read
fewer pairs, explicitly recorded as order_records. Failure performs no writes.

Descending completion reverses the range and restores original duplicate
order through the existing equal-group repair. Outlier tests cover every
u128 bit at tile/tail positions, primitive and ID/payload records; unchanged
regressions cover equality, ordered runs, inversions, duplicates and block tails.

Native full regression suite33/33 is fresh. ASan at `8bf14e0` covers the identical
pointer/scatter kernels (32 optimized tests and 170 pure boundary oracle rows).
The latest diff adds only safe integer/branch operations; that prior-source
coverage is not presented as a fresh sanitizer run for `49db9f8`.

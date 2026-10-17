# Outlined scalar scatter: full validation, remaining wide-order gap

Source 8bf14e0 is frozen. The 91-cell seen matrix completed all 6552 timed
oracle rows. Together with the 576-row grouping ablation and 572 Work/heap rows,
7700 formal rows passed source/binary/metadata/slot/rotation/address validation.
No build or test overlapped formal timing. Deterministic Work/heap runs overlap
an ASan build, and their timing fields are excluded from all speed claims.

Safety passed: 32 native release Work tests, two runner tests, 32 optimized
ASan Work tests, and 170 pure optimized ASan full-oracle probes spanning all ten
layouts and B3/17/64/129/512. Four native/sanitizer ELFs are frozen. Native time
and Work builds used the full ten layouts, native CPU, CGU16, incremental cache,
line-table debug and six Cargo jobs. Both native and sanitizer builds use locked,
offline dependencies. All formal sorting uses CPU2, one worker, restored inputs
on the same allocation, and sort scratch allocation/release inside timing.

The scalar outline closes the prior Small8 random-input failure. Group/Stable
is 0.569 at B64 and 0.592 at B512, with 0/12 slower in both. All 20 B64 ordinary/
sparse cell medians are below Stable (largest ratio 0.879). All 24 shared-prefix
cells at B64/B512 have Group/Stable medians in approximately 0.080..0.510, with
no slower repetition; duplicate and fully distinct-key families are both tested.
B512 128-byte records also remain below Stable. Resources are detailed in
RESOURCES.md: all 572 Work/allocation rows exactly match pre-outline Group,
all 62 Group requested peaks are no larger than Block LSD, and at most 25.4%
of Stable MSD's peak in this matrix.

The overall goal is **not achieved**. Wide-key order/equality still has measured
cost. Representative remaining cells, without pooling files or selecting a
favorable repetition:

| n | layout | case | Group/Stable | p10 | p90 | slower /12 | thread CPU ratio | Pa A/A p10..p90 |
|---:|---|---|---:|---:|---:|---:|---:|---|
| 1048576 | u128 | equal | 1.094 | 0.985 | 1.142 | 9 | 1.094 | 0.954..1.022 |
| 1048576 | wide32 | equal | 1.064 | 1.005 | 1.119 | 11 | 1.067 | 0.904..1.018 |
| 1048576 | wide32 | sorted | 1.050 | 0.979 | 1.196 | 8 | 1.050 | 0.884..1.062 |
| 16384 | u128 | equal | 1.334 | 1.326 | 1.360 | 12 | 1.304 | 0.994..1.002 |
| 16384 | u128 | sorted | 1.050 | 1.045 | 1.062 | 12 | 1.049 | 0.998..1.001 |
| 16384 | wide32 | equal | 1.091 | 1.075 | 1.127 | 11 | 1.082 | 0.995..1.013 |
| 16384 | wide32 | sorted | 1.087 | 1.037 | 1.204 | 12 | 1.079 | 0.981..1.213 |

Small u128/equal is a clear failure: 33.4% slower, 12/12 slower, ratio p10=1.326,
CPU ratio=1.304, while Pa A/A is about 0.994..1.002. It must not be dismissed as
noise or offset by large prefix wins. Some other order cells remain noisy;
review-matrix.csv retains every cell and reference. No case-level average is an
acceptance decision. Independent audit reproduced all 3168 numeric fields from
the 8-cell ablation plus 91-cell matrix. Every summary/noise file covers one
raw file, and quantiles are sample descriptions rather than confidence intervals.

A subsequent diagnostic profile (excluded from formal timings) pinpoints the
all-equal tile loop: 1089/1107 ordered-function samples fall in scalar u128
comparisons and KMOV/KSHIFT predicate packing. See profile/u128-equal for the
raw software-event profile, exact symbol offsets, asm, frozen source and 32768
oracle rows. These are whole-process samples including restore/oracle/formatting,
not timed-phase percentages. Next evaluate an exact native XOR/OR equality
reduction, retaining tile size, key-call order and all existing sort policies.
No benefit from that unimplemented change is claimed here.

Because the seen matrix failed, the planned 2336-row mechanism sweep, 256-row
old/new process pairing and 864-row held-out campaign were not executed. The
held-out seed20261018 remains unseen. Their scripts retain the conditional plan;
they are not evidence of completed work. Keep the positive scalar outline and
grouping, fix the remaining detector, and rerun representative full validation.
The original worktree/default production sorter is unchanged; no remote push.

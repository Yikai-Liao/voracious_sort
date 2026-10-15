# Combined MSD candidates, reverse input, and standard-library/LSD references

This follow-up uses one native binary to compare the node-local MSD
baseline, three combinations, Rust's stable `slice::sort_by_key`, and the exact
submitted serial Block LSD source. The earlier 13-method measurements remain
unchanged in [strategy_experiment/](../strategy_experiment/REPORT.md), at commit
`04e850a`. This run has new source/binary hashes; absolute times from the two
binaries must not be spliced into a paired comparison.

## Combinations and what is orthogonal

| Method | Node placement | Admission | Rejected-node backend | Digit-monotone check |
| --- | --- | --- | --- | --- |
| stream_carry_leaf | Original global Stream; carried boundaries and 128-record leaf batching | Original | Original | No |
| hybrid | Node-local free-list with carried boundaries | Exact dyadic potential, K=4 | stream_carry_leaf on the whole node | No |
| hybrid_mono | Same | Same | stream_carry_leaf on the whole node | Yes |

Boundary lookup is independent of the partition's allocation/assembly strategy:
carried setup preserves the exact physical IDs and allocation order. In global
Stream recursion, leaf batching separately reduces gather/Writer calls without
changing any original leaf's sorting input. Node-local cache/leaf sorting already
uses contiguous slices, so it has no analogous Stream leaf call to batch; the
hybrids apply batching only in their global fallback.

The potential gate controls whether an expensive node-local materialization is
admitted. The monotone check can establish that no such materialization is needed
at all: after the unchanged branch-free histogram, it scans **current digit
values** using `extract(mask, shift)` and stops at the first inversion. With
nondecreasing digits, counts delimit already contiguous child slices; it recurses
without scatter or permutation. The checker runs only at non-cache block nodes;
the bounded contiguous backend remains unchanged. It does not fuse a branch into
the counting loop and does not change the key/extract contract. Histograms and
checks still cost their record visits. A last-pair inversion pays a whole extra
scan and still partitions, which is explicitly measured.

This criterion is source-supported by data.table's fixed
[`forder.c` revision](https://github.com/Rdatatable/data.table/blob/df59dd637403e65d7fa90d48bb0dfec2764d6744/src/forder.c#L1051):
its <=65535 counting path performs branch-free counts, then checks byte order,
and omits reordering when the byte is already grouped in sorted order.
The adaptation here uses current records without materializing linear key/index
arrays. The independent subtract-min/range-compression proposal is not included;
it requires a separate built-in-integer extraction contract and scan accounting.

Prefix writeback and free-list placement are alternative partition mechanisms,
not independent switches to add together. R4 and the potential are alternative
admission rules. Joint tables and minority buffering remain separate controls:
the prior run did not justify including them in every combined path. No
layout/distribution lookup table, learned selection policy, padding sweep or
extra unrolling is added.

## References and inputs

`std_stable` calls `a.sort_by_key(|value| value.into_key_type())` on the same
records and converted key order as the stable candidates. It does not use
`sort_unstable` or the extra key/index materialization of `sort_by_cached_key`.
Its requested heap and full elapsed sort are measured by the same harness.

`src/submitted_lsd/sort.rs` is a byte-for-byte copy of the submitted serial
Block LSD at commit `d6f6b70497ae25f3600b5f458b316a4cedfcb470`. Its utils file
is reused from `src/frozen_lsd/utils.rs`, which is byte-identical to that
submission's `src/sorts/utils.rs`. Hashes and provenance are saved separately.
`block_lsd` uses the common block size 64; `block_lsd512` uses 512, the submitted
usage setting. Both use radix 8. Raw `block` identifies the common MSD case,
while `method_block` records the actual block size (zero for non-block controls).
The memory difference between these LSD settings is included in the comparison.
This is the submitted algorithm, including its existing ordered/constant-digit
fast paths and bounded-scatter admission, without a new LSD optimization.

The timed set is exactly nine methods: local_free, stream_carry_leaf, hybrid,
hybrid_mono, block_lsd, block_lsd512, ordinary, stable_fixed and std_stable.
The original eleven independent MSD ablations are not rerun. Intermediate
carry/gate combinations exist for structural tests but are not timed here.

All original five record layouts and seven distributions remain. The existing
`descending` sorts random keys then reverses the complete record array; it can
contain equal keys. The new `reverse_unique` starts with keys 0..n-1 and reverses
all records, yielding exactly n-1..0. The harness asserts strict decreasing
converted keys outside timing. Both descending fixtures are retained: equal-key
payload stability remains relevant to the original one.

Two additional fixtures isolate the new monotone criterion. `digit_grouped`
sets each key's highest byte to floor(256*i/n), with deterministic random lower
bits. The byte is repeated at bit offsets 24/56/88/120 so every tested key width
has the same top-digit grouping. Full keys within groups remain unsorted.
`digit_tail_inversion` changes only the final top digit to zero. The harness
asserts the first top-digit inversion is absent or exactly the last adjacent
pair respectively. Existing uniform, deep skew, almost-sorted and reverse cases
provide controls without this property.

The complete matrix is four sizes x five layouts x ten loads = 200 cases. Each
method receives nine rotating samples. Before timing, the primary comparison
scope is fixed to the 105 nonordered cases with n >=16384 (the original five
nonordered loads plus the two digit fixtures). `original75` separately preserves
the previous large-case workload mix, and `digit_targets30` isolates the new
property. Sorted, descending and strict reverse results remain explicit scopes;
they are not discarded or folded into a claim about partition work. Among the
three combinations, the lowest geometric mean on `primary105` is the aggregate
candidate; per-case losses and heap are reported alongside it. This is not a
claim that one candidate wins every input.

The nine rotating samples cycle all nine starting positions in each full-matrix
case. No old eleven-method ablation set is rerun in this follow-up.

## Validation and measurement

All stable methods must match complete key/ordinal/payload identity against a
stable oracle. Ordinary MSD instead checks sorted keys and complete identity
permutation. Input generation, fixture assertions, reset and oracle checks are
outside timing; workspace allocation/destruction is inside. One input allocation
is reused and method order rotates. Heap peaks come from separate untimed probes
and include candidate plus fallback allocations, excluding the existing input
and oracle. Stack, allocator bookkeeping and RSS remain unmeasured.

Debug, release+cf_phases and AddressSanitizer each passed 58 tests; an
all-target/all-feature check also passed. Logs are under `validation/`.
Combination tests cover exact carried setup identities, equal original leaf
sizes and batch statistics, accepted-work bounds, initialized restricted values,
NaN payloads, reference payloads and custom extraction. The monotone test verifies
successful skip, inversion in the first pair, and inversion in the last pair;
its custom extractor counts actual calls from histogram, checker and scatter.
The potential remains the exact dyadic implementation documented in the prior
report, with the same 256 KiB cache admission and K=4. Skipping a partition does
not charge it as accepted materialization or claim the descendant sort is free.

One CPU-0-pinned native timing process runs after all compilers, tests and ASan
finish. Flags are `--release --features cf_std_leaf` and
`-C target-cpu=native`; cf_phases and cf_early_scan are disabled. The host remains
unisolated. No hardware-cache or code-alignment causal claim is made.

## Full matrix and combination choice

All 16,200 timed matrix sorts (200 cases × 9 methods × 9 samples) passed their
oracles. The preceding smoke run added 216 timed sorts over 24 cases. The
analyzer checked all observed potential charges and budget counters. Raw data
is under [measurements/](measurements/), medians/quartiles and whole-sort heap
under [comparison.csv](comparison.csv), and aggregate scopes under
[summary.csv](summary.csv).

Ratios below compare each method with node-local free-list in this same binary.
Lower is faster. The primary scope includes the two new digit fixtures and their
last-inversion cost; original75 retains only the prior workload mix. These are
unweighted geometric means, not arithmetic totals or significance tests.

| Method | Primary 105 ratio | Original 75 ratio | Primary >5% faster / within 5% / >5% slower |
| --- | ---: | ---: | ---: |
| stream_carry_leaf | 1.1232 | 1.1195 | 9 / 14 / 82 |
| hybrid | 1.0016 | 1.0177 | 23 / 63 / 19 |
| hybrid_mono | 0.9806 | 1.0052 | 37 / 46 / 22 |
| block_lsd | 1.0273 | 0.9435 | 50 / 10 / 45 |
| block_lsd512 | 0.9795 | 0.8991 | 55 / 7 / 43 |
| ordinary | 1.3779 | 1.5925 | 58 / 4 / 43 |
| stable_fixed | 1.4459 | 1.6316 | 51 / 11 / 43 |
| std_stable | 1.1034 | 0.9227 | 25 / 4 / 76 |

`hybrid_mono` is the fastest of the three tested combinations on the predeclared
primary scope, 1.94% below node-local free-list. On original75 it is 0.52% slower;
there is no broad throughput improvement on that original mix. The two other
combinations do not beat that baseline in aggregate. Their independently useful
mechanisms do not produce additive percentage savings when composed.

Block LSD at 512 is close to hybrid_mono in the primary aggregate, while the
per-layout times differ greatly. The Rust standard-library reference is faster
than local_free in the original75 geometric aggregate despite losing more
individual cases; its few large low-cardinality wins strongly affect that mean.
A global scalar ranking hides those cases, so neither aggregate determines a
universal dispatch rule. Sorted, random-descending and strict-reverse scopes are
retained separately in the summary and every case remains in the CSV.

The monotone property's materialization saving is exact in the counter trace:
on the million-record digit_grouped fixture it avoids n root scatter records
and 2,097,088 root permutation record writes. U32 has no further block partition,
with heap 557,768 → 24,576 bytes compared with hybrid. Wide32 has heap
1,489,608 → 171,784 bytes; large128 has 4,684,488 → 614,152 bytes. Those latter
layouts still partition the random lower digits. All variation and histogram
reads remain; they are not counted as avoided. On digit_tail_inversion the
root check visits n records, rejects, and its scatter/permutation work and heap
are unchanged. This is the measured worst case of the extra decision scan.

## Focused million-record report

The same binary, unchanged throughout timing, completed another 3,825 timed sorts: 17 cases × nine
methods × 25 samples. All passed. The matrix, smoke and confirmation total
20,241 timed sorts. Only the nine core methods were executed. Medians below are
milliseconds; quartiles, work counters and heap are in
[focused-comparison.csv](focused-comparison.csv).

### Uniform random keys

| Method | u32 | wide32 | large128 |
| --- | ---: | ---: | ---: |
| local_free | 10.020 | 23.492 | 66.521 |
| stream_carry_leaf | 11.620 | 27.224 | 77.623 |
| hybrid | 10.028 | 22.601 | 65.788 |
| hybrid_mono | 10.031 | 22.672 | 65.902 |
| block_lsd | 4.318 | 92.849 | 78.642 |
| block_lsd512 | 3.348 | 77.519 | 91.732 |
| ordinary | 8.275 | 28.807 | 108.271 |
| stable_fixed | 8.705 | 29.090 | 109.137 |
| std_stable | 14.596 | 42.064 | 164.785 |

Block LSD 512 wins uniform u32: 3.348 ms versus hybrid_mono 10.031 ms and Rust
stable 14.596 ms. Wide32 and large128 favor the MSD combination over both LSD
settings and Rust stable in these samples. Uniform-u32 hybrid_mono and local_free
have the same partition/cache tree; their 0.01 ms difference is not a work saving.

### Strict reverse, unique keys n-1..0

All nine methods completed every strict-reverse case. Block MSD and both LSD
settings requested zero heap workspace. Rust stable did allocate workspace on
this fixture, as shown below; input/oracle storage is excluded from these peaks.
Ordinary and corrected stable MSD each requested 32 bytes.

| Layout | local_free ms | hybrid_mono ms | LSD 64 ms | LSD 512 ms | Rust stable ms | Rust stable heap bytes |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| u32 | 0.293 | 0.294 | 0.324 | 0.321 | 0.274 | 4194304 |
| u64 | 0.392 | 0.386 | 0.412 | 0.414 | 0.561 | 8000000 |
| u128 | 1.015 | 0.998 | 0.906 | 0.913 | 0.808 | 8388608 |
| wide32 | 1.815 | 1.810 | 1.761 | 1.766 | 1.766 | 16777216 |
| large128 | 9.977 | 9.968 | 8.924 | 8.932 | 10.449 | 67108864 |

### Deep skew

| Method | u32 | wide32 | large128 |
| --- | ---: | ---: | ---: |
| local_free | 6.049 | 85.118 | 111.513 |
| stream_carry_leaf | 7.769 | 60.563 | 97.462 |
| hybrid | 8.244 | 62.066 | 108.351 |
| hybrid_mono | 8.271 | 62.346 | 107.738 |
| block_lsd | 3.353 | 33.265 | 49.912 |
| block_lsd512 | 2.729 | 46.428 | 48.567 |
| ordinary | 4.220 | 269.657 | 277.551 |
| stable_fixed | 4.195 | 278.877 | 281.132 |
| std_stable | 10.572 | 12.182 | 84.511 |

Potential admission avoids the sixteen-level wide32 repeated-permutation cost
(85.118 → 62.346 ms), but still loses to Block LSD and Rust stable there. The
shorter u32 chain regresses (6.049 → 8.271 ms), and large128 remains slower than
the references. These cases are retained without a distribution-specific policy.

### Current digit monotone and its late-inversion cost

| Layout | Grouped: hybrid | Grouped: hybrid_mono | Last inversion: hybrid | Last inversion: hybrid_mono |
| --- | ---: | ---: | ---: | ---: |
| u32 | 9.436 | 8.866 | 9.438 | 9.822 |
| wide32 | 18.021 | 16.247 | 18.787 | 19.718 |
| large128 | 52.879 | 45.664 | 55.715 | 61.067 |

For large128, success saves 7.215 ms (13.6%) against hybrid, while a last-pair
inversion adds 5.352 ms (9.6%) without saving scatter. The work/heap saving is
real, and the additional scan has a real rejection cost.

## Selected experimental entry and limits

The fastest of the three tested combinations on primary105 is:

```rust
block_msd_research::materialization_gate::sort_hybrid(
    &mut values, 8, 64,
    block_msd_research::node_local::CACHE_BUDGET,
    true, // skip a proven monotone current digit
);
```

This combines carried node-local free-list partition, bounded contiguous stable
MSD, exact potential admission, carried+batched global fallback and the separate
digit check. Parameters are global; there is no layout/distribution lookup table.
It remains experimental: its 1.94% primary aggregate gain is small, original75
is 0.52% slower, and no measured algorithm wins every layout and load. No default
production dispatcher was changed. Subtract-min compression is outside this run.

The submitted LSD source remains byte-identical to d6f6b70. Its example imports
the original library namespace; the frozen reference module is therefore excluded
from this experiment's rustdoc. After timing only that doc cfg was added; no
sorting body or timing harness changed. `timed_lib.rs` and
`measured-source-sha256.txt` retain the measured crate root and source manifest.
The native executable text section was verified byte-identical after this
packaging adjustment. `measured-binary-sha256.txt` retains the original timed ELF checksum.
`binary-sha256.txt` identifies the inspected copy after objcopy repacked ELF
metadata; its executable text is identical. All timing preceded that inspection.

## Reproduction and diagnostics

Run `combined_experiment/run.sh` from this crate. It defaults to all four sizes,
ten loads, five layouts and nine samples; MSD_REPEATS, MSD_LOADS, MSD_TYPES,
MSD_CPU, MSD_BLOCK, MSD_COMBINED_TARGET and MSD_COMBINED_OUT override these.
Fresh output goes to `combined_experiment/rerun/`.

Work1..8 retain the method-specific meanings in the
[previous report](../strategy_experiment/REPORT.md#reproduction-and-raw-diagnostics).
`stream_carry_leaf` follows the global-stream columns, local_free retains its
original columns, and the two hybrids follow gate_potential4. Work9..11
are monotone checker records visited, nodes skipped, and block-scatter records
avoided. All three are zero when the checker is disabled. The LSD and standard
library references use zero diagnostic work columns; their times and allocator
peaks are measured normally. Direct child/cache copies are not included in
"block-scatter records avoided". See [stream notes](stream-notes.md) and
[node notes](node-notes.md) for their focused equivalence checks.

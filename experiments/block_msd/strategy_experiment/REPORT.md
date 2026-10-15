# Independent block-MSD strategy comparison

This experiment compares the proposed mechanisms separately. The original
full-scan Stream/Writer implementation remains the default research entry;
none of these candidates is installed in the production dispatcher.

The stable shared-boundary block construction has prior art; see
[COUNT_FIRST.md](../COUNT_FIRST.md#prior-art) and Kärkkäinen, Sanders and
Burkhardt, *Linear Work Suffix Array Construction*, Appendix B, Theorem 5.
This report measures implementation choices around that construction.

## Candidates and controls

All methods use radix 8 and block size 64. Budget parameters are global and
fixed before timing, without type/distribution dispatch or parameter fitting.

| Name | Independent change | Relevant control |
| --- | --- | --- |
| full_scan | Archived complete variation scan, global Stream/Writer, one final permutation | Frozen baseline |
| local_free | Finish each block partition and destroy its workspace before child recursion; bounded contiguous stable MSD at 256 KiB working-set admission | full_scan |
| local_prefix | Same recursion/cache admission as local_free; completed scratch blocks go to the consumed input prefix in completion order, followed by block permutation | local_free |
| carried | Carry the preceding nonempty bucket's tail slot, replacing boundary Vec/binary searches; identical physical IDs and allocation order | full_scan |
| leaf_batch | Gather adjacent terminal leaves totaling at most 128, sort each original subrange separately, emit once | full_scan |
| joint0 / joint512 | Prepare next-digit counts while scattering current digit; zero / 512 KiB total table budget across ancestors and siblings | full_scan and joint0 |
| gate_R4 | Before free-list scatter, accept only if m <= 4R; otherwise sort the whole current slice with full_scan | local_free and full_scan |
| gate_potential4 | Separate exact integer potential admission, also before scatter with whole-slice fallback | local_free and gate_R4 |
| minority_single | Buffer bounded minority records/holes, move majority gaps once, sort minor children with full_scan; continue only the major child | full_scan |
| deferred_chain | Keep the major child in its entry array and skip holes; buffer multiple chain levels, then flush the whole entry once | minority_single and full_scan |
| ordinary | Upstream unstable MSD; key-order and complete identity-permutation oracle | Speed reference |
| stable_fixed | Frozen upstream stable MSD with equal-key-safe descending reversal and explicit integer mask parameters | Correct stable speed reference |

The node-local cache budget admits **input plus auxiliary records**, per-depth
histogram/cursor arrays and a conservative leaf allowance. It is a working-set
model, not a cap on the whole sort's heap. The prefix version retains the same
boundary Vec lookup as local_free, so its comparison does not incorporate carry.
A completed output block may overwrite input only after the triggering record
has been copied into scratch and `(completed+1)*b <= consumed`. The partial tail
is written only after the entire input has been read. Extra scratch-to-prefix
writes are counted explicitly; this mechanism does not promise fewer copies.

The R gate retires only children with no remaining bits, at most 128 records,
or guaranteed admission to the fixed contiguous backend. Retired sets are
disjoint across accepted block nodes, giving `sum(m_accepted) <= 4*sum(R) <= 4n`.
This bounds accepted materialization, not the scans or full_scan fallback work.

The potential experiment fixes L=128 and uses
`psi(m)=0` for `m<=L`, otherwise
`m*(1+ceil(log2(ceil(m/L))))`. Completed children contribute zero. It accepts
when `m <= 4*(psi(parent)-sum(psi(active children)))`. All arithmetic for the
potential is exact u128; its telescoping bound is `4*psi(root)`, which is
O(n(1+log(n/L))). This is a dyadic implementation, not an evaluation of the
suggested natural-log formula, and it does not inherit the R gate's linear bound.
K=4 is the only value tested; no parameter sweep or production default is claimed.

Minority workspace charges allocated capacities, including positions, counts
and cursors; deferred mode also charges record-sort auxiliary storage and the
second holes directory before extracting a new layer. These buffers are dropped
before fallback. Fallback has its own original low-space workspace; a retained
single-layer histogram can add at most 256 words. Reported special-path moves
exclude fallback moves. The deferred majority is compacted at most once per
entry chain, without a global O(n) movement claim. See the
[skew report](../skew_experiment/REPORT.md) for stability and gap-copy arguments.
The per-node block directory is O(m/b) machine words; scratch is O(sigma*b)
records. Parent block directories are destroyed before recursion; retained
count arrays contribute O(sigma*d) words. With fixed b this directory is not
an O(sqrt(n)) claim. `minor_records` counts extracted records, not every
initialization, sort or flush write.

Joint-table capacity includes entire parent tables and all unvisited rows; it
is an additional cap, separate from original block workspace. Tables rejected
by a child's skipped constant digit remain paid preparation work.

## Measurement and validation

The common `src/bin/strategy_experiment.rs` creates each source and stable oracle
outside timing. Every stable candidate must match key, ordinal and payload;
ordinary must preserve the complete identity permutation and sorted keys.
Within each case, methods share one input allocation, reset outside timing,
rotate method order every sample, and include workspace allocation/destruction
inside elapsed time. Heap peak is measured in a separate untimed call using
requested allocator bytes, including all candidate and fallback heap allocations;
input/oracle/reset storage is excluded. Stack, allocator bookkeeping and RSS
are not measured by this heap peak. Phase-instrumented builds are never timed.
Counters that are part of the candidates' normal implementation remain enabled.
Leaf batch's additional diagnostic counters compile out in its normal entry.

Native builds use `--release --features cf_std_leaf`, `-C target-cpu=native`,
without cf_phases or cf_early_scan. A single taskset-pinned process runs at a
time after all compilers and sanitizers finish. The host is not isolated;
variation and code-layout effects remain possible. This is serial software
measurement without hardware cache counters.

Validation logs in [validation/](validation/) contain 41 passing tests each in debug,
release+cf_phases and AddressSanitizer, plus an all-target/all-feature check. Each
mechanism also has dedicated assertions: exact setup-ID equivalence, original
leaf sizes and record work, table-budget lifetime, gate charge inequalities,
restricted initialized values and all small holes/gap layouts. Passing these
checks supports the covered cases; it is not a proof for every unsafe execution.

The standard fixture matrix has four sizes (1,024; 16,384; 262,144; 1,048,576),
five layouts (u32/u64/u128/wide32/large128) and seven loads (uniform, deep_skew,
skew95, shared_prefix, sorted, descending, almost_sorted): 140 cases. The deep
skew generator uses `i%97==0 ? 1u128<<((i/97)%128) : 0`; narrower key types
truncate it. Comparisons use case medians, with the 25th and 75th percentiles
retained in comparison CSVs. Aggregates are unweighted geometric means of
case ratios; +/-5% counts are descriptive, not significance tests.

## Full matrix results

All 16,380 timed sorts (140 cases × 13 methods × 9 samples) passed their
oracles. The preceding smoke run covered 36 cases and 468 timed sorts. Raw
samples are in [measurements/](measurements/), per-case medians and quartiles
in [comparison.csv](comparison.csv), and scope aggregates in
[summary.csv](summary.csv). The analyzer verifies all measured gate charges
and workspace byte caps.

The table below uses the 75 nonordered cases with n >= 16,384, excluding the
explicit sorted/descending preflight paths. Ratios are candidate/control
geometric means; lower is faster. Every other case, including all negative
fast-path results, remains in the CSVs and the all140 aggregate.

| Candidate | Control | Geometric ratio | >5% faster / within 5% / >5% slower |
| --- | --- | ---: | ---: |
| local_free | full_scan | 0.831 | 60 / 6 / 9 |
| local_prefix | local_free | 1.115 | 7 / 14 / 54 |
| carried | full_scan | 0.954 | 28 / 47 / 0 |
| leaf_batch | full_scan | 0.953 | 30 / 37 / 8 |
| joint0 | full_scan | 1.030 | 4 / 47 / 24 |
| joint512 | joint0 | 1.013 | 11 / 55 / 9 |
| gate_R4 | local_free | 1.073 | 9 / 37 / 29 |
| gate_potential4 | local_free | 1.006 | 15 / 40 / 20 |
| minority_single | full_scan | 0.937 | 21 / 20 / 34 |
| deferred_chain | minority_single | 1.072 | 5 / 49 / 21 |

These results favor node-local materialization and the smaller setup/leaf
changes in this fixture set. Prefix writeback trades extra writes for lower
heap use and is slower in most large cases. The strict R gate is too
conservative when none of the immediate children fits the contiguous backend;
it gives up the useful first partition on uniform wide32/large128. The integer
potential admits those two-level trees and rejects a long majority chain, but
its overall time is close to unguarded local_free and it has remaining regressions.
Single-layer minority handling has narrow wins and much smaller memory on some
skew cases; deferred-chain buffering is not a general speed improvement under
the tested byte cap.

Across all 140 cases, local_free/full_scan is 0.821, prefix/local_free 1.053,
carry/full_scan 0.973, leaf/full_scan 0.970, joint512/joint0 1.028,
R4/local_free 1.035, potential/local_free 0.993, minority/full_scan 1.305 and
deferred/minority 1.168. Aggregates span very different contracts and data
shapes; the case-level results should drive interpretation. In particular,
ordinary/stable MSD has very large deep-skew allocation and runtime costs,
so a global speed ranking would conceal the uniform-key gap.

The full matrix includes ~2× sorted-u32 differences for carried and leaf_batch
although their changed setup/leaf paths never run: node counts and heap are
zero. These rows cannot be attributed to boundary deletion or leaf batching.
Code generation/layout and host effects are possible explanations; this run
does not isolate their cause. Minority candidates have actual preflight
regressions because they begin with variation/histogram work rather than the
baseline's ordered check. All such measurements are retained, and no candidate
is promoted as a universal replacement.

## Focused million-record confirmation

The same binary then completed 1,950 additional timed sorts: six cases × 13
methods × 25 samples. No method was changed after the matrix. Medians below are
milliseconds; all quartiles, whole-sort heap peaks and work counters are in
[focused-comparison.csv](focused-comparison.csv).

| Method | Uniform u32 | Uniform wide32 | Uniform large128 | Deep u32 | Deep wide32 | Deep large128 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| full_scan | 13.428 | 30.021 | 78.231 | 6.923 | 60.540 | 93.435 |
| local_free | 10.162 | 23.935 | 66.997 | 6.353 | 84.778 | 112.862 |
| local_prefix | 11.313 | 27.932 | 76.738 | 9.990 | 74.916 | 89.376 |
| carried | 12.265 | 28.630 | 78.057 | 7.228 | 59.458 | 94.055 |
| leaf_batch | 12.344 | 28.628 | 78.584 | 7.442 | 59.807 | 92.386 |
| joint0 | 13.786 | 30.035 | 79.724 | 8.119 | 62.666 | 94.532 |
| joint512 | 14.345 | 31.053 | 79.598 | 8.377 | 62.493 | 88.837 |
| gate_R4 | 10.050 | 31.307 | 89.094 | 7.403 | 62.671 | 103.906 |
| gate_potential4 | 10.030 | 23.702 | 66.473 | 7.397 | 62.436 | 104.449 |
| minority_single | 13.834 | 31.475 | 89.259 | 3.785 | 67.286 | 89.037 |
| deferred_chain | 13.835 | 31.442 | 89.143 | 4.581 | 62.027 | 106.729 |
| ordinary | 8.585 | 31.393 | 111.343 | 4.403 | 272.573 | 284.793 |
| stable_fixed | 8.785 | 31.634 | 111.993 | 4.186 | 275.932 | 283.680 |

The uniform-u32 gap narrows from 13.428 ms to 10.162 ms with local_free;
stable_fixed is 8.785 ms. The potential candidate is 10.030 ms, still 1.142×
the stable reference. Its accepted partition tree and work are identical to
local_free here, so the small difference between those two implementations is
not evidence that admission itself saved work. Uniform wide32/large128 improve
with materialization, while R4 rejects at the root because R=0. Potential
admission accepts 2n materialization records over 257 nodes in these cases.

For deep wide32, local_free is 84.778 ms versus the original 60.540 ms;
potential rejects before the first scatter and returns to 62.436 ms. It avoids
that repeated-permutation cost but still pays variation/counting before the
fallback. Deep large128 similarly improves from local_free's 112.862 ms to
104.449 ms, remaining slower than the original 93.435 ms. Thus the gate corrects
the intended structural failure without making fallback free.

Prefix has a real space/time tradeoff. Uniform-u32 requested heap peak falls
from 557,768 to 289,232 bytes (48.1%), but time rises from 10.162 to 11.313 ms.
It adds 1,048,576 scratch-to-prefix record writes, with permutation writes
2,095,872 versus 2,078,528. On deep large128 its exact sparse scratch needs
and directory removal reduce whole-sort heap from 4,689,840 to 269,824 bytes;
time also improves from 112.862 to 89.376 ms. That favorable exception does
not offset its 54 regressions among the 75 larger nonordered cases.

Carry and leaf batching each reduce uniform-u32 time by about 8%, but neither
changes the number of histogram/scatter records. For carry, exact setup-ID
oracle checks ensure the change is confined to boundary lookup. For leaf batch,
phase tests preserve every original leaf length and sort-call count; the
four-leaf example changes gather/Writer calls from four to one while retaining
four sorts and 60 records read/written. No broader reduction in copied bytes
is claimed.

On uniform u32, joint512 reuses 1,048,576 prepared histogram records and scans
only 1,048,576, instead of joint0's 2,097,152 scans. It also performs 1,048,576
joint-table updates and holds a full 524,288-byte table. Whole-sort heap rises
from 557,968 to 971,536 bytes, and time is 14.345 versus joint0's 13.786 ms.
This measured read reduction does not translate into a speed win. Deep large128
is a local counterexample: 88.837 versus joint0's 94.532 ms; the table remains
an independent selective tradeoff, not a universally faster path.

The minority methods validate the distinction between moves and time. On deep
u32, single-layer moves 4,182,848 majority records across four layers and runs
in 3.785 ms; deferred moves 1,045,856 once and runs in 4.581 ms. The chain
variant achieves the requested majority-move reduction but is slower. On deep
wide32, the 256 KiB budget admits four of sixteen layers, then flushes and
falls back; its 62.027 ms is close to full_scan, while single-layer is 67.286 ms.
For large128, only one layer fits before flush: deferred's 106.729 ms loses to
single-layer's 89.037 ms. Workspace is the limiting mechanism here, and
unmeasured fallback moves must not be added to the special-path move claim.

## Decision

Keep these as independent research candidates. Node-local free-list is the main
throughput improvement in the tested broad matrix. Carry and leaf batching are
small promising changes for a subsequent combined experiment, whose performance
has not been measured here. Prefix is useful evidence of a lower-heap alternative;
the fixed-budget joint table and minority chain have targeted benefits and clear
negative cases. The exact integer potential is less conservative than R4 and
avoids its uniform-wide rejection, but it still incurs preparation/fallback
cost and remaining regressions. None meets the original goal of consistently
matching ordinary and correct stable MSD across all tested layouts and loads.
No hybrid, type-specific policy, extra inlining or padding sweep was added.

## Reproduction and raw diagnostics

Run `strategy_experiment/run.sh` from this directory, optionally setting
MSD_REPEATS, MSD_BLOCK, MSD_CPU, MSD_LOADS, MSD_TYPES, MSD_STRATEGY_OUT and
MSD_STRATEGY_TARGET. Its default output goes to `rerun/`, preserving this run.

Raw samples use eight work columns with method-specific meanings:

| Methods | work1 ... work8 |
| --- | --- |
| full_scan / carried / leaf_batch | nodes, dense_nodes, dense_scattered_elements, scratch_elements, then four zeros |
| local_free / local_prefix | block_nodes, cache_entries, variation_records, block_scatter_records, cache_scatter_records, permutation_writes, prefix_writeback_records, peak_scratch_records |
| joint0 / joint512 | hist_reused_records, hist_scanned_records, joint_updates, peak_bytes, peak_tables, tables_built, tables_denied, prepared_rejected_records |
| gate_R4 / gate_potential4 | accepted_records, retired_records, accepted_nodes, fallback_records, fallback_nodes, potential_drop, permutation_writes, cache_entries |
| minority_single / deferred_chain | special_nodes, deferred_levels, major_records_moved, minor_records, peak_workspace_bytes, flushes, budget_flushes, fallback_calls |
| ordinary / stable_fixed | eight zeros |

`analyze.py` checks stable diagnostic counts across samples, whole-sort heap
consistency, R and potential charges and byte caps while generating summaries.
Detailed mechanism reports are [carry](../boundary_experiment/REPORT.md),
[leaf batch](../leaf_batch_experiment/REPORT.md),
[joint tables](../joint_histogram_experiment/REPORT.md), and
[minority paths](../skew_experiment/REPORT.md). Their original validation
statements precede this coordinated timing run; timing conclusions belong here.

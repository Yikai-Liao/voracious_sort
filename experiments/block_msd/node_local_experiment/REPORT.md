# Materialize each large node before recursion

This experiment changes when a bucketed stream becomes a contiguous array. The
large-node backend retains the existing free list, shared boundary blocks, lazy
interior heads and stable scatter. It materializes that one node, destroys its
block workspace, then recurses on disjoint array slices. It has no global Writer.
The first-stage source is frozen in `v1_free_list.rs`.

Prior-art attribution for the stable distribution primitive is in
[COUNT_FIRST.md](../COUNT_FIRST.md#prior-art). The research question here is when
to materialize within MSD, not whether that primitive is a new invention.

## Cache route and lifetime

Every non-small node still performs a complete variation scan; scan early
termination and joint child histograms are not enabled. If the remaining node
fits a fixed working-set model, it uses ordinary contiguous stable histogram/
scatter MSD with a single auxiliary record workspace reused through its
recursion. Standard stable converted-key sorting handles leaves of at most128.

The fixed budget is256KiB for every type and load. Admission estimates
`(2*m+128)*s + 3*sigma*w*ceil(bits/radix) +8192 <= budget`: input plus auxiliary
records, a bounded leaf allowance, remaining recursive histogram/cursor metadata,
and a fixed margin. Parent block histograms remain separately live in O(sigma*d)
space. This is a working-set policy, not proof that every access hits a physical
cache. No record-type or distribution lookup is used. Passing budget0 forces
block partitioning down to the bounded leaves for correctness testing.

The block workspace lives entirely inside `partition`. Its scratch payload,
free list, chains, cursors and inverse directory are gone before child recursion.
Only the parent's O(sigma) histogram survives. With sigma=2^radix, b records per
block, s record bytes, w word bytes and d digit depth, extra space is
`O(s*(sigma*b+128) + w*(n/b+sigma*d) + C)`.
The fixed128 leaf term can be absorbed into the payload term. Fixed b=64 leaves
an asymptotically linear directory term; square-root overhead requires scaling b
with n (and fixed sigma,d,s), not merely a small measured heap percentage.

The per-node free-list scratch allocation is
`(min(2*sigma,ceil(m/b))+8)*b` records. Ancestor partial streams no longer survive,
so it does not retain the original2*d scratch allowance. The construction remains
experimental: identity tests and ASan do not replace a complete unsafe proof.

## Work and comparison

The driver compares frozen full-scan count-first, node-local free list, ordinary
MSD and the corrected stable MSD from the scan experiment. All are in one native
binary with rotating method order and one reused input address per case. Input
reset, generation, reference construction and full identity/permutation checks
are outside timing; workspace allocation is inside. Requested-heap peaks are
measured separately and exclude stack, allocator headers and RSS.

The matrix has four sizes1024/16384/262144/1048576, five layouts and seven loads,
including a new `deep_skew` fixture: one large nonconstant zero-prefix child can
survive at every digit level. All count-first comparisons retain the complete
variation scan. The fixed block size is64 and radix8. See `environment.txt` and
`source-hashes.txt` for the measured binary and compiler provenance.

Counters distinguish block scatter, cached scatter and physical writes in block
permutation (a swap counts two destination blocks). Cached scatter also incurs
one copy back to the array per counted record. These are algorithmic counts,
not hardware memory traffic. Standard leaf-sort moves are not counted. There
is no Writer gather/write stage; this does not imply fewer total copies for
every input. Repeated node permutation can cost O(n*d) record work.

## Results

The first-stage9-sample matrix verified all5,040 timed results (140 cases).
Geometric mean node-local/full-scan time is0.8248. Of140 cases,87 improve by more
than5%,34 are within±5%, and19 regress by more than5%. The worst ordered-preflight
cases remain affected by binary/code-layout variation and are reported rather
than assigned to the new partition algorithm.

| Million uniform records | Full scan | Node local | Corrected stable MSD | Local/full |
| --- | ---: | ---: | ---: | ---: |
| u32 | 13.312 ms | 10.293 ms | 8.277 ms | 0.773 |
| u64 | 13.760 ms | 10.497 ms | 9.048 ms | 0.763 |
| u128 | 21.579 ms | 16.065 ms | 15.251 ms | 0.744 |
| wide32 | 30.000 ms | 24.433 ms | 33.476 ms | 0.814 |
| large128 | 78.481 ms | 67.644 ms | 114.164 ms | 0.862 |

For million uniform u32/u64/u128, there is one block partition and256 contiguous
cache entries. Variation visits remain2*n. Wide32/large128 do not fit the fixed
cache policy at those child sizes: they have257 block nodes and no cache entries.
Their improvement therefore also reflects removing the persistent Writer/
stream path, not just entering the cache routine. Uniform u32 requested heap is
557,768 bytes versus557,968 for the old backend; large128 is4,684,488 versus
4,748,176. Parent-workspace retention is not hidden in the heap comparison.

The deep-skew risk is real. Million-record wide32 takes88.398ms versus61.881ms
full scan (1.429x); large128 takes115.480ms versus94.339ms (1.224x). Wide32 visits
16 block nodes and writes18,531,523 record destinations in block permutation.
It still beats the much larger-buffer stable baseline in that fixture, but it
regresses against the existing low-space backend. No universal speed claim or
production-default change follows from this experiment.

Separate focused samples are in `focused-comparison.csv`; they are not merged
with the matrix medians. They test uniform u32 at25 samples and the million-record
wide32/large128 deep-skew cases at17 samples.

## Next independent experiments

The next backend comparison holds this node-local/cache policy fixed and changes
only block placement to monotonic completed-block prefix writeback. It must count
the additional scratch-to-array copy explicitly. The shared-boundary carry
simplification is independently testable against the original physical IDs.

Two other proposals remain separate: a fixed128-record buffer can batch adjacent
leaves while sorting each original subslice independently before one Writer call;
fixed-budget joint digit statistics can precompute child histograms without
creating sigma-squared output buffers. Neither is implemented in this stage.

## Reproduce

```sh
cargo test --manifest-path experiments/block_msd/Cargo.toml --release \
  --features cf_std_leaf --lib --test correctness --test node_local
experiments/block_msd/node_local_experiment/run.sh
```

The default count-first entry point is unchanged. Call `node_local` explicitly.
The runner writes to a new `rerun/` directory, preserving the committed samples.


The focused25-sample u32 results are0.131929→0.104797ms at16,384,
4.131260→2.255908ms at262,144, and13.307281→10.249873ms at1,048,576.
Corrected stable MSD takes0.095280/1.904628/8.265767ms respectively.
The separate17-sample deep-skew rerun also confirms regression: wide32 is
59.896946→89.752779ms (1.498x), large128 is95.089594→114.630303ms (1.205x).
The difference between focused and matrix ratios illustrates host/fixture timing
variation; the qualitative skew risk is reproduced in both.

## Validation

Debug and release each pass one library test, eleven original correctness tests
extended to call this candidate, and three node-local tests. ASan passes the same
fifteen tests. Coverage includes converted floats/NaNs, restricted-value payloads,
partial boundaries, radices1/3/8, blocks1/7/64/129, forced zero cache budget,
16KiB/default budgets, deep skew and checked changing-extractor failures.
All targets/features compile. Logs are under `validation/`.

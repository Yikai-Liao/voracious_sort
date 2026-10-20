# Rayon block LSD: implementation and scaling evidence

The repository already has `voracious_mt_sort(thread_n)`, backed by Rayon
comparison-sort fallbacks and Peeka (a parallel MSD algorithm). These existing
entry points are unstable. The new stable block LSD entry points are:

```rust
block_lsd_stable_mt_radixsort(arr, radix, block_size, thread_n);
block_lsd_stable_mt_radixsort_in_pool(arr, radix, block_size, &pool);
```

[Implementation](../../../src/sorts/block_lsd_stable_sort/parallel.rs).
They require `voracious_multithread`. The one-shot wrapper constructs a Rayon
pool; the in-pool function reuses a caller's pool. The primary benchmark times
the in-pool function, including its sorting allocations, directory work and
compaction, while excluding pool startup, fixture generation, input cloning,
reference sorting and validation. Cold one-shot timings are not measured.

## Correspondence with the original C algorithm

Reference: [radixsort_parallel.c at f69e816](https://github.com/clausecker/radsort/blob/f69e816c3cd79d312cd67aea5b9cf1c338c1b371/radixsort_parallel.c),
and the paper's Parallel Operation subsection. Each digit pass redistributes
logical input blocks into contiguous segments, balancing live record counts.
Each segment gets sigma free head-start blocks and owns its physical blocks.
Rayon scatters these segments concurrently. After joining, sequential fixup
concatenates output by digit, then original segment order. Final compaction is
sequential, using the same push/pull permutation machinery as serial block LSD.

Rust-specific differences are generic converted keys, uninitialized scratch,
checked extraction indices, constant byte-shift kernels, ordered-input shortcuts,
and skipping globally constant digits. Small inputs up to 128 records use the
existing stable converted-key fallback. Active segments are capped by the
number of input blocks; every measured case has enough blocks for all requested
threads. Original C is compiled unchanged and compared only on its supported
8-byte u32/key-ordinal layout.

For stability, segment order follows the incoming logical order. Each local
scatter preserves order within a digit; stable block concatenation therefore
preserves equal-digit record order globally. Repeating these passes in increasing
digit order gives stable LSD ordering. Scheduling order has no effect on this
logical concatenation.

## Ownership and space argument

The working permutation is a bijection, partitioned into disjoint worker slices.
A worker reads/writes only the physical IDs in its slice. Source prefixes are
bounded by initialized lengths, and output blocks are recycled only after input
consumption. After J records, at most floor(J/b) full buckets can have triggered
new block reservations. Equality between a recycled block and the current source
requires its last read; the reservation is first written on a subsequent record.
Workers join before any ID changes ownership. This is the basis of the private
`unsafe impl Send for Worker`; raw arena addresses alone grant no cross-slice
access. Debug checks verify the global permutation and live-record total after
each pass. Safe custom extraction is bounds-checked before pointer writes.

Let p be active segments, sigma=2^radix, b records/block, s record bytes and
n record count. Across all workers, allocated blocks are at most
`p*sigma + floor(n/b)`, including empty tails. The physical arena has
`2*p*sigma + floor(n/b)` blocks, leaving at least p*sigma free blocks for the
next head start. Scratch payload is exactly `2*p*sigma*b*s` bytes. Directory
storage is 9 bytes per physical block; other per-pass arrays are O(p*sigma) words.
On this 64-bit target, an upper bound for requested array storage on the block
path is:

```
2*p*sigma*b*s
+ 9*(floor(n/b) + 2*p*sigma)
+ 56*p*sigma + 8*sigma + 192*p
```

This includes both simultaneously live partial arrays, worker buckets/counts,
starts, worker objects and segment plans. It excludes the provided Rayon pool,
runtime task storage, stack, allocator rounding/headers and debug-only checks.
Small comparison leaves have separately bounded storage. No heap/RSS measurement
is claimed by this benchmark. The asymptotic bound is
`O(s*p*sigma*b + w*(n/b+p*sigma))`; fixed p, sigma and record size allow
O(sqrt(n)) overhead with b proportional to sqrt(n). Increasing threads increases
workspace; it is not a thread-independent O(sqrt(n)) byte guarantee.

## Measurement definitions and provenance

Ryzen 7 8845H, 8 physical cores / 16 SMT threads, Rust 1.99, GCC 16.2.1,
Rayon 1.12.0, native release flags. All layouts use radix 8 and a fixed 4 KiB
block byte size: 512/256/128/32 records for 8/16/32/128-byte layouts. Original C
uses 512-record blocks, matching u32. No measured type/workload configuration
lookup is installed. The benchmark's Cargo.lock is retained.

`S_p = median(T_1)/median(T_p)` uses the same parallel implementation at 1 thread.
`E_p = S_p/p`. Separate CSV columns also compare against serial block LSD,
ordinary stable LSD and C permuted LSD.16 threads use SMT; efficiency divides
by16 hardware threads and is not a 16-physical-core measurement.

Workers are pinned, physical cores first, then SMT siblings. Actual OpenMP and
Rayon CPU placement is checked and logged. OpenMP uses
`OMP_WAIT_POLICY=PASSIVE`, `GOMP_SPINCOUNT=0`; the default permits active waiting,
which can affect mixed-runtime measurements. See the official
[waiting policy](https://gcc.gnu.org/onlinedocs/libgomp/OMP_005fWAIT_005fPOLICY.html)
and [spin-count documentation](https://gcc.gnu.org/onlinedocs/libgomp/GOMP_005fSPINCOUNT.html).

The complete mixed-method matrix has 666 groups / 3,330 checked timing rows:
4 layouts, 3 sizes(65,536/1,048,576/4,194,304), 3 loads(uniform,256-key duplicates,
95%-zero skew), 5 thread counts(1/2/4/8/16), 5 samples per group. Algorithm order
rotates. Stable outputs match complete converted-key/payload identity; existing
`repo_mt` is checked for sorted keys and exact permutation without claiming
stability. The existing dispatcher has global-pool fallbacks; in this run both
Rayon thread-count environment overrides were unset and its first initialization
occurs under the requested p-CPU affinity mask. Its pool creation is included
where the existing API creates a private pool.

Raw mixed-method files and `comparison.csv` retain all methods, medians and
min/max. `scaling.md` renders the uniform subset. `pilot-default-wait/` preserves
the earlier default-wait pilot and is excluded from the main summary. Differences
between these rounds cannot all be attributed to wait policy: they occurred at
different times on an active development machine.

## External interference and focused comparisons

The separate `isolated-primary/` and `isolated-c/` runs time only one target
algorithm per process at 4,194,304 uniform records. Startup still verifies both
runtimes, but the unused runtime has no recurring calls during measured sorts.
These runs remove method interleaving and the repository global-pool baseline.
While investigating their deterioration, two unrelated VS Code file scanners
were observed consuming approximately 15 logical CPUs, with system load around 25.
The cgroup ancestry had no CPU quota/throttling. This is material external
contention; the earlier noisy results cannot characterize uncontended hardware
parallel efficiency. No causal attribution of every timing difference is made.

A final bounded focused run temporarily pauses only those two read-only scans,
then restores them in a finally block, with an independent timeout watchdog.
`quiesced-environment.txt` records restoration. `quiesced-primary/` and
`quiesced-c/` retain its raw samples. These focused measurements are the primary
comparison; the machine remains otherwise unisolated and sample ranges matter.
They cover largest uniform inputs only and do not supersede the complete
mixed-method matrix's size/distribution coverage.

## Validation and limitations

Debug integration: 6 new threaded tests passed. Full release: 90 existing tests,
10 serial block tests, 6 threaded tests and 4 doctests passed(one legacy ignored).
ASan: 10 serial block and 6 threaded tests passed. Without the feature, all 11
serial integration tests also passed after sharing the compaction routine.
Tests cover 1/2/3/8-worker pools, all radices 1..8, block sizes 1/3/17/512, partial-heavy
passes, large tails, full stable identity, opaque PartialOrd, borrowed/nonzero
payloads, signed extrema, NaN/zero converted keys, invalid parameters and worker
panic with subsequent pool reuse.

TSan with the repository's locked Rayon 1.7 / Crossbeam epoch 0.9.14 completes the
six functional tests but reports 5 scheduler/epoch-queue warnings and exits 66;
it is not a clean TSan result. A separate validation with Rayon 1.12 / current
Crossbeam, rebuilt standard library and its sanitizer fence configuration passes
all 6 tests with no TSan warnings. `validation-modern-Cargo.lock` and both logs
preserve these distinct configurations. This is not a claim of a clean old-lock
TSan run, Miri validation or a complete formal pointer proof.

[Reproduction](../../../tools/block_lsd_parallel_bench/README.md),
`source-hashes.txt`, `environment.txt` and saved validation logs accompany the
raw data. The implementation is available for review; no all-scenario speed win
or replacement of Peeka is claimed.

## Primary focused results

The two file scanners were restored after a 38.6-second bounded run. All 125
focused samples passed full stable identity checks. Times below are medians of
five verified sorts of 4,194,304 uniform records, with reused runtimes. These
are observations on this machine, not universal throughput guarantees.

| Layout / implementation | T1 ms | T8 ms | S8 | E8 | T16 ms |
|---|---:|---:|---:|---:|---:|
| u32 / 8 B, Rust Rayon | 28.602 | 17.620 | 1.62 | 20.3% | 26.624 |
| u32 / 8 B, original C OpenMP | 23.680 | 14.790 | 1.60 | 20.0% | 21.776 |
| u64 / 16 B, Rust Rayon | 89.071 | 47.595 | 1.87 | 23.4% | 60.612 |
| u128 / 32 B, Rust Rayon | 337.625 | 170.365 | 1.98 | 24.8% | 195.751 |
| u32 key / 128 B, Rust Rayon | 360.827 | 246.178 | 1.47 | 18.3% | 268.920 |

The 128-byte case is fastest at four threads in this focused round: 232.662 ms,
1.55x speedup and 38.8% thread efficiency. None of these layouts improves from
eight to 16 SMT threads. Rust u32 has a similar self-speedup to C, while its
absolute eight-thread time remains about 19% slower. Full per-thread values and
sample ranges are in [the focused comparison](quiesced-primary/scaling.md)
and [CSV](quiesced-primary/comparison.csv).

The implementation retains sequential redistribution/fixup and final compaction,
so it does not expose all work to parallel execution. Per-thread scratch and
bucket setup also grow with p. These structural costs limit scaling; the data
do not separately identify bandwidth, page faults, scheduling or cache pressure
as a single dominant cause. No further optimization or extrapolated speed claim
is made from these runs.

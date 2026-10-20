# Stable block LSD: local validation and experiments

These measurements validate the initial generic `block_lsd_stable_radixsort`
implementation, before the subsequent perf/MCA and size-range optimizations.
Current results and implementation decisions are recorded in the
[optimization report](optimization/README.md). The initial experiments investigate
parameter tradeoffs. They are experimental records, not lookup
tables used by the library. The dispatcher and its thresholds are unchanged.

## Reproduction and environment

See [benchmark instructions](../../tools/block_lsd_bench/README.md) and its optional
standalone Cargo project. C is called through Rust FFI in the same process; its
sorting source is included unchanged from upstream commit
`f69e816c3cd79d312cd67aea5b9cf1c338c1b371`. The C comparison is limited to its original
u32 key + u32 payload layout (8 bytes); both block sorts use radix 8, block size 512
for that comparison. Rust additionally skips constant digits, so repeated-key
results compare final algorithms rather than identical numbers of passes.

Local machine: AMD Ryzen 7 8845H (16 logical CPUs); Linux x86_64; pinned CPU 0.
Rust: `rustc 1.99.0 (b940084d7 2026-09-28)`. C: GCC 16.2.1 20260810.
Rust uses Cargo release + `-C target-cpu=native`; C uses
`-O3 -march=native -DNDEBUG`, no LTO. Turbo/frequency scaling and sibling threads
were not disabled; this is a local warm-cache microbenchmark, not an isolated-host
performance guarantee. Raw samples preserve variability.

Input generation, input cloning and reference validation are outside timing.
Timing includes internal allocations, initialization, all passes and compaction.
Every measured output is checked against a standard stable sort including all
payload words. Measurement order rotates across samples.

Rust memory is separately measured peak *extra requested heap bytes*, excluding
caller input, reference output and cloning. It is not RSS, stack usage or allocator
metadata. C heap size is computed exactly from its own struct and allocation
expressions via a wrapper; it bypasses Rust's allocator. Memory tracking is disabled
during timing. CSV records the measurement kind.

## Experiment inventory

| File | Experiment | Configurations | Samples each |
| --- | --- | ---: | ---: |
| [workloads.csv](workloads.csv) | Six record layouts, six distributions, n=1024/262144/1000000; C, block, existing stable LSD/MSD and standard stable | 540 | 7 |
| [tuning.csv](tuning.csv) | Four layouts, three distributions, n=1000000; radix 4/6/7/8 × block bytes 512..65536 | 384 | 5 |
| [confirmation.csv](confirmation.csv) | Four layouts, three distributions, n=1000000/4000000; radix 8, block bytes 1/2/4/8/16/64 KiB | 144 | 5 |
| [payload.csv](payload.csv) | Fixed u32 key, record sizes 8/16/32/64/128/256 bytes; three distributions, n=1000000 | 90 | 5 |

All 6,870 timed samples passed complete stable-output checks. Distribution names:
uniform is deterministic pseudorandom input; duplicates uses 256 keys; skewed is
95% zero and 5% pseudorandom; other distributions are sorted, reverse and constant.
Comparisons use consistent key-only PartialEq and PartialOrd; identity checking is
separate, so payload equality cannot hide instability.

Full median/range/heap reports: [workloads.md](workloads.md), [payload.md](payload.md).
The CSV algorithm labels `rust_block_lsd` and `rust_block_lsd_4k` refer to the initial
stable public function, using respectively 512 elements and approximately 4 KiB per block.
For 8-byte records these configurations coincide and the duplicate run is omitted.

## Results against other algorithms

Median milliseconds, n=1,000,000 uniform input. Block here uses approximately
4 KiB per block; the C reference uses its original 512-element block.

| Layout | C permuted | Block stable | Existing LSD stable | Existing MSD stable | Standard stable |
| --- | ---: | ---: | ---: | ---: | ---: |
| u32 key + payload, 8 B | 6.235 | 6.250 | 8.381 | 11.903 | 20.770 |
| u64 key + payload, 16 B | — | 21.756 | 17.324 | 14.454 | 34.121 |
| u128 key + payload, 32 B | — | 82.194 | 96.644 | 24.039 | 48.772 |
| i64 key + payload, 16 B | — | 21.323 | 23.270 | 15.447 | 34.419 |
| f64 key + payload, 16 B | — | 24.229 | 23.955 | 29.616 | 46.152 |
| u32 key + large payload, 128 B | — | 118.702 | 184.439 | 148.744 | 202.818 |

Extra requested heap MiB for the same block configurations is respectively about
2.033/2.050/2.083/2.050/2.050/2.284; existing LSD uses about
7.647/15.284/30.559/15.284/15.284/122.088 MiB.

Block sorting is not uniformly fastest. Wide random keys favor the existing MSD
in several cases. Standard stable sort can win strongly on skewed keys, and the
existing preprocessing wins on sorted/constant inputs. Tiny inputs can make fixed
block scratch more expensive than a full scatter buffer. These observations do
not justify switching the entire dispatcher to block sorting.

## Is the apparent advantage U-shaped?

Changing from u32 to u128 and then to a large-payload u32 record changes both key
width and record size. That comparison cannot establish a one-dimensional curve.
The fixed-u32 control removes key-width changes. Uniform-input medians:

| Record B | Block 512 elements ms | Block ~4 KiB ms | Existing LSD ms | Existing MSD ms |
| ---: | ---: | ---: | ---: | ---: |
| 8 | 5.34 | 5.34 | 6.75 | 10.33 |
| 16 | 12.73 | 15.09 | 12.91 | 16.95 |
| 32 | 35.23 | 33.47 | 24.60 | 22.03 |
| 64 | 57.59 | 53.13 | 75.30 | 61.59 |
| 128 | 150.58 | 113.78 | 154.27 | 131.98 |
| 256 | 285.82 | 206.22 | 308.31 | 228.12 |

The 32-byte layout still favors existing LSD/MSD even with key width fixed. Thus
key-pass count alone does not explain the non-monotonic relative advantage.
Copy code generation, alignment, cache working set and block-management costs
are plausible contributors, but no hardware-counter study was performed to
separate their causal effects. We do not claim a universal U-shaped law.

## Parameter control without a premeasured lookup policy

Let s be record bytes, n element count, b elements per block, sigma=2^radix,
L=b*s block bytes, and N=n*s input bytes. The main extra-space terms are

`2*sigma*b*s + 9*n/b = 2*sigma*L + 9*N/L`.

For the release implementation's own heap buffers, when at least one digit varies,
the exact requested bytes are

`2*sigma*b*s + 9*(floor(n/b)+2*sigma) + 6*sigma*sizeof(usize)`.

The final term accounts for partial descriptors, bucket pointers, counts and
starts. This excludes stack/allocator metadata and allocations inside custom key
callbacks. Equal converted keys return without these allocations. Debug validation
also temporarily allocates a seen array.

The model's space minimum is at `L = sqrt(9*N/(2*sigma))`; it does not imply the
fastest configuration. An extra-space budget constrains the feasible range of L,
including metadata as well as scratch. Merely limiting scratch omits the `9*N/L`
term, which matters for small blocks and large input.

The paper's cache argument involves roughly `sigma*L` bytes consumed before reuse.
A cache-workset budget therefore depends jointly on radix and block bytes. At
fixed radix, expressing control as block bytes or scratch bytes is only a change
of units. At varying radix, fixing either one does not fix the other, nor the pass
count. Source conversion also changes which digits actually vary.

The parameter sweep found workload- and size-dependent tradeoffs. Confirmation at
four million elements shifted several preferred block sizes. A single record-size
constant, a single fastest sample, or a workload-specific precomputed table is
therefore not a general default policy. The implementation exposes the precise
radix/block_size controls and contains no type/distribution classification or
lookup-based automatic selection. Future automatic policy should be derived from
explicit resource constraints and observable input properties, then validated.

Optional figures can be generated from the CSV data with:

```sh
uv run --with matplotlib python tools/block_lsd_bench/plot.py results/block_lsd
```

## Implementation and tests

The implementation adapts the C block permutation, stable per-digit allocation,
partial tracking and push/pull compaction. It uses existing Radixable/RadixKey
conversions and extract/default_mask helpers, plus compute_max_level. It avoids a
new record trait, u64-only keys, Default requirements and an unrestricted O(n)
scatter fallback. The later optimization adds a budget-bounded scatter path.
The shifted final partial digit is masked to the actual key width. Constant digits
are detected by union/intersection using existing trait operations, without adding
BitXor to the public contract. Compaction keeps overlap-safe ptr::copy.

Tests cover radix 1..8, small and non-power-of-two blocks, exact block/tail boundaries,
random/sorted/reverse/repeated/high-bit keys, opaque payload stability, full u128,
signed/float conversions, all primitive supported types, zero-sized records,
invalid parameters and hostile extraction bounds. Single-thread builds also test
non-Default, non-Send/Sync records. New integration tests run independently of the
repository's existing feature-gated test module.

Validation: seven single-thread integration tests; six with voracious_multithread;
90 existing release tests; four doctests pass with one existing ignored example.
AddressSanitizer passed the seven integration tests. No Miri run was available.
Clippy retains existing repository warnings; the new sorting/test files introduce
no diagnostics. BSD notices are retained, with packaged LICENSE-BSD-2-Clause and
combined MIT AND BSD-2-Clause Cargo metadata.

The existing Vec::voracious_stable_sort forwarding problem is separate and is not
changed by this standalone-function PR. Stable block MSD has a separate [dense-tail research prototype](../../experiments/block_msd/REPORT.md),
including design-level space reasoning, tests and local measurements. It is not
exported by this implementation.

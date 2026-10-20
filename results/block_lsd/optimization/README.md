# Generic block LSD optimization experiments

This directory continues the initial C/Rust comparison in [the parent report](../README.md).
The goal is to beat ordinary LSD in some cases and remain close across scales and
distributions, with a subsequent goal of competing with ordinary MSD. Results
below do not establish either goal for every scenario. Block MSD is a separate,
research [experiment](../../../experiments/block_msd/REPORT.md).

## Method and provenance

Measurements use the same Ryzen 7 8845H, CPU0, Rust 1.99, native release code,
original C revision, deterministic inputs and requested-heap tracker as the
parent report. Each timed sort is checked for complete record identity. Input
generation, clones, stable reference sorting and validation are outside timing.
Small arrays are timed in batches, with clones prepared before the timer.
Samples rotate algorithm order. The host is not isolated and frequency changes
remain a source of variation. Medians compare algorithms within one run; separate
runs are useful for replication but cannot precisely isolate a small speedup.

`scale-trim-chunks.csv` contains five samples for 4 layouts, 6 distributions and
11 sizes from 16 through 4,194,304, with original C, block LSD (512 elements and
4 KiB blocks), ordinary LSD, stable LSD and stable MSD. The equivalent 4 KiB/512
configuration is omitted for the u32 pair. All 6,600 samples passed their output
oracle. Its exact source is [versions/trim_chunks.rs](versions/trim_chunks.rs),
with source/binary hashes in `scale-trim-chunks-hashes.txt`. This version used a
serial combined monotonicity check. **Do not use its 4M timings as acceptance
evidence:** a subsequent compilation overlapped the end of that size's run.
Smaller sizes completed before that compilation. Other files retain their
individual experimental stage; they are not measurements of the final source.

There is no type/workload configuration lookup table. Configurations are fixed
for a comparison, and all implementation choices depend on representation limits,
actual varying key bits, fixed small bounds, or a workspace inequality.

At 1,048,576 uniform records in the uncontended part of that run:

| Layout | 4 KiB block ms | Ordinary LSD ms | Stable LSD ms | MSD ms |
|---|---:|---:|---:|---:|
| u32 pair, 8 B | 6.211 | 8.543 | 8.416 | 12.637 |
| u64 pair, 16 B | 21.693 | 20.630 | 21.727 | 17.916 |
| u128 pair, 32 B | 91.124 | 165.894 | 158.518 | 44.345 |
| u32 payload, 128 B | 112.772 | 189.576 | 195.257 | 153.872 |

These are gains over LSD for several layouts, while wide-key MSD still has a
large lead. The u64 512-element configuration takes 18.585 ms in that case,
compared with 21.693 ms for fixed 4 KiB blocks; no measured per-type switch is
installed. The fixed 512-element configuration on 128-byte records uses much
more scratch than 4 KiB blocks. Parameter choice must retain its memory meaning.

## Changes under evaluation

* `MaybeUninit<T>` scratch removes whole-workspace initialization. Only live
  records are read as T. Full-block evacuation uses untyped pointer copies,
  including padding; partial lengths prevent padding from being read as T.
* Local bucket cursors and raw record copies avoid repeated cursor loads and
  large-record stack spills in the hot loop. Bucket indexing remains checked.
* Constant byte-shift specializations simplify u128 digit extraction. Other
  shifts use the same generic implementation. Pass metadata is shared.
* A conventional stable scatter buffer is permitted only if its **entire**
  estimated requested heap fits inside the block scratch budget. This preserves
  the asymptotic block space bound. The histogram, its Vec capacity/reallocation
  allowance and both cursor arrays count toward this budget.
* Constant high digits are trimmed before fused histogram construction. A
  nonzero common high prefix is handled correctly. Other constant digits skip
  scatter passes. For 256 repeated u128 keys at n=32,768, `trim.csv` records
  0.442 ms for block versus 0.459 ms ordinary LSD and 0.480 ms stable LSD. The
  previous `copy-kernels.csv` block result was 1.324 ms because it built sixteen
  histogram rows for a one-pass result. These are separate runs, not a claim
  that frequency/system state was identical.
* Bounded scatter uses a native fixed-range inner `for` in groups of four and
  retains one checked write expression. It does not require a macro dependency.
* Ordered input handling compares converted keys, preserving the public radix
  order even if the record's PartialOrd differs. Descending equal-key groups
  are reversed again after whole-array reversal. Unique descending keys need
  no equal-group scan. A subsequent ordered-input candidate replaces the serial
  comparison dependency with independent adjacent-pair groups; `ordered.csv`
  records that candidate separately.

## Why an eager branchless rollover was rejected

The candidate eagerly prepares a successor block and updates its metadata for
every record, selecting pointers/indices with masks. This lowers branch misses
but increases instruction and memory work. It is retained only in the benchmark
copy for an ablation. `ablation.csv` compares it with the other stages.

`perf_profile.py` enables counters through perf control FIFOs immediately around
each sort and waits for acknowledgments before proceeding. Cloning, generation
and oracle work are excluded. Each table cell below uses 12 sorts of 1M uniform
records. Hardware counters count user code, including the sort's allocation and
compaction. They were collected sequentially without concurrent benchmarks.

| Record | Kernel | Cycles/element | Instructions/element | Branch misses/element |
|---|---|---:|---:|---:|
| u32 pair, 8 B | constant-shift block | 26.85 | 73.13 | 0.029 |
| u32 pair, 8 B | eager branchless | 74.59 | 238.09 | 0.011 |
| u64 pair, 16 B | constant-shift block | 89.58 | 141.06 | 0.076 |
| u64 pair, 16 B | eager branchless | 180.08 | 485.78 | 0.037 |
| u128 pair, 32 B | constant-shift block | 336.42 | 315.32 | 0.317 |
| u128 pair, 32 B | eager branchless | 533.65 | 1095.19 | 0.016 |
| u32 payload, 128 B | constant-shift block | 472.04 | 105.45 | 0.212 |
| u32 payload, 128 B | eager branchless | 547.95 | 281.35 | 0.006 |

Digit-indexed scatter has no pivot-comparison branch. Its rollover branch occurs
once per filled block. Removing that branch adds work to every element. This
experiment therefore does not justify importing pdqsort's branchless partition
strategy into block rollover. Generic cache counters and sampled instruction
addresses alone do not prove a particular L1/LLC or store-buffer bottleneck.

The real u128 steady-state assembly snippets are preserved in `mca-*.s` and their
LLVM 23.1.1 `llvm-mca -mcpu=znver4 -iterations=1000` output in `mca-*.txt`.
The original kernel has 30 instructions / 34 uops per iteration and estimated
block throughput 5.7 cycles; the cursor/raw-copy kernel has 23 / 27 and 4.5;
eager branchless has 67 / 71 and 11.8. MCA assumes cache hits and predicted
control flow for the supplied region. It excludes occasional rollover,
histograms, metadata repair and compaction and is not a whole-sort prediction.

## Native loops versus seq-macro and crunchy

The benchmark copies the ordinary LSD core and changes only scatter-loop style:
the original hand-written four-way body, scalar `for`, `as_chunks::<4>()` plus
native `for`, seq-macro, and crunchy. Histogram construction is held constant.
The macros retain the original three phases (four extractions, four cursor
updates, four stores); the simple native loop performs those phases per record.
The styles therefore differ in scheduling as well as surface syntax.

`loop-correctness.csv` validates sizes 129/131/1023 and six distributions;
`loop-styles.csv` has seven samples for 2048/32768/1M and three distributions.
All 360 correctness rows and all 1,260 timed rows passed. Native
`as_chunks` is used only by the experimental harness, requiring Rust 1.88;
seq-macro/crunchy dependencies are also confined to that harness.

| 1M uniform records | Hand-written 4 | Scalar for | Array 4 + for | seq | crunchy |
|---|---:|---:|---:|---:|---:|
| u32 pair | 8.794 ms | 10.954 ms | 9.287 ms | 9.238 ms | 10.635 ms |
| u64 pair | 25.856 ms | 26.304 ms | 25.825 ms | 25.718 ms | 27.090 ms |
| u128 pair | 101.967 ms | 111.454 ms | 109.147 ms | 112.274 ms | 107.697 ms |
| u32 payload 128 B | 165.085 ms | 164.236 ms | 156.442 ms | 166.161 ms | 163.418 ms |

In the saved u64 disassembly, the native array loop expands to four extraction,
cursor-update and copy operations, followed by one 64-byte source increment.
There is no remaining inner four-iteration loop. seq and crunchy both have
0x8d3-byte functions and their 517-instruction streams are identical after
normalizing branch/call addresses and PC-relative relocations. Their timing
differences demonstrate measurement variation, not different generated kernels.
No style is a universal speed winner in these results. Compiler expansion is
verified for this build; it is not a guarantee for every compiler or type.

## Reproduction and comparison

Build as described in [the harness README](../../../tools/block_lsd_bench/README.md).
Select a fixed set of algorithms to keep experiments manageable:

```sh
BLOCK_LSD_ALGORITHMS=c_permuted,rust_block_lsd,rust_block_lsd_4k,rust_lsd,rust_lsd_stable,rust_msd_stable \
  taskset -c 0 tools/block_lsd_bench/target/release/block_lsd_bench \
  --scale 5 16 64 128 512 2048 8192 32768 131072 524288 1048576 4194304 > scale.csv
python tools/block_lsd_bench/compare.py scale.csv --csv comparison.csv > comparison.md
python tools/block_lsd_bench/perf_profile.py --perf /path/to/perf \
  --type u128 --algorithm 5 --n 1000000 --repeats 12 --output perf.csv
```

No Miri validation or formal verification is claimed. Native correctness tests,
sanitizer results and mathematical ownership arguments each have separate scope.
The independent MSD experiment also reports an existing stable-MSD equal-key
regression; timing rows that fail the stable identity oracle cannot qualify as
stable-baseline speedups.

## Final scope and validation

The production source retains the tested scratch, cursor, byte-shift, bounded
scatter, constant-digit and ordered-input changes. Software prefetch remains an
experimental harness variant: its measured gains and regressions vary by layout
and distribution, so it is not enabled in the library. Further phase/histogram
controls that had not been built or run were removed rather than treated as
evidence. No all-scenario speed objective is claimed as achieved.

The final library source passed 90 existing release tests, 10 feature-enabled
block LSD integration tests, and 4 doctests (one legacy doctest ignored). The
AddressSanitizer run passed all 11 single-threaded integration tests, including
non-Default/non-Send records, nonzero/reference/enum payloads, partial digits,
stability, and invalid/inconsistent custom extractors. Saved logs are
`validation-release.txt` and `validation-asan.txt`.

## Key-width evidence and its limits

The earlier uniform 1M sort-only PMU comparison in
`perf-width-summary.csv` shows the following per-record counts:

| Layout | Block cycles | Ordinary LSD cycles | Block instructions | Ordinary LSD instructions | Block CPI | Ordinary LSD CPI |
|---|---:|---:|---:|---:|---:|---:|
| u32 / 8 B | 26.85 | 34.61 | 73.13 | 89.48 | 0.367 | 0.387 |
| u64 / 16 B | 89.58 | 97.15 | 141.06 | 192.18 | 0.635 | 0.505 |
| u128 / 32 B | 336.42 | 496.97 | 315.32 | 546.55 | 1.067 | 0.909 |

For u64, about 27% fewer instructions are partly offset by about 26% higher
cycles per instruction; the cycle gain is only about 8%. For u128, the larger
instruction reduction (about 42%) outweighs its higher CPI, giving about 32%
fewer cycles. Constant byte shifts simplify multiword u128 extraction in the
saved assembly; u64 extraction already fits native machine-word operations.
This explains the measured accounting, but does not isolate every cause of CPI.

These layouts also vary record size and pass count (4/8/16 at radix 8), so they
do not establish key width as the sole cause. Ordinary fused histogram matrices
occupy 8/16/32 KiB respectively with usize counters; the machine's L1D is 32 KiB.
Capacity pressure is a hypothesis, not a measured attribution. On this AMD PMU,
the generic cache-reference/cache-miss events map to L2 requests and L2 misses
(including instruction misses), not LLC events; see `cache-event-mapping.txt`.
The previously recorded fixed-u32 payload controls also show that block LSD is
not universally faster for wider records.

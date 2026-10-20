# Block LSD benchmark

This standalone Rust tool calls generic `block_lsd_stable_radixsort`, the unchanged
original C `permuted_sort` through FFI, the crate's `lsd_stable_radixsort` and
`msd_stable_radixsort`, ordinary `lsd_radixsort`, and standard stable sort in the same process. It does not
add C compilation or dependencies to the library's normal build.

The direct block comparison uses radix 8 and block size 512. The direct C comparison
uses an eight-byte record containing a u32 key and u32 payload. The C implementation
sorts the first u32 in four passes. Other workloads compare the Rust algorithms:
u64/i64/f64 key plus payload (16-byte records), u128 plus payload (32 bytes), and
u32 with a large payload (128 bytes). A second Rust block configuration uses
`max(1, 4096 / size_of::<Record>())` elements per block, keeping block bytes near
4 KiB across types. It is omitted for the eight-byte pair because both settings
are identical. Floating-point inputs are finite. The public
sorting implementation remains generic; a u32 result cannot stand for all layouts.

Fetch the fixed upstream reference and build with Rust, a C compiler and ar:

```sh
git clone https://github.com/clausecker/radsort /tmp/radsort
git -C /tmp/radsort checkout f69e816c3cd79d312cd67aea5b9cf1c338c1b371
RADSORT_SOURCE=/tmp/radsort RUSTFLAGS='-C target-cpu=native' \
  cargo build --release --manifest-path tools/block_lsd_bench/Cargo.toml
mkdir -p tools/block_lsd_bench/results
taskset -c 0 tools/block_lsd_bench/target/release/block_lsd_bench \
  7 1024 262144 1000000 > tools/block_lsd_bench/results/workloads.csv
python3 tools/block_lsd_bench/summarize.py \
  tools/block_lsd_bench/results/workloads.csv > tools/block_lsd_bench/results/summary.md
```

Choose an allowed, otherwise idle CPU for taskset, or omit it on unsupported
platforms. Positional arguments are sample count followed by input sizes. Without
arguments, sample count is 9 and sizes are 1024, 100000, 1000000. `CC` optionally
selects the compiler. C flags are `-O3 -march=native -DNDEBUG`; Rust uses Cargo
release settings and `-C target-cpu=native`. No cross-language LTO is enabled.

The deterministic distributions are uniform, 256 repeated keys, sorted, reverse,
constant, and skewed (95% zero, 5% uniform). Key comparisons agree between
PartialEq and PartialOrd. Full record identity, including every payload word,
is checked independently against standard stable sort. This matters because the
existing Verge heuristic uses both comparison traits.

The ordinary LSD comparison has an unstable public contract. Its result is
checked for converted-key order and complete payload permutation; the block and
stable comparisons additionally require equal-key identity order. Experimental
copies are excluded by default and selected with `BLOCK_LSD_ALGORITHMS`.

Each algorithm has a warmup/memory run, then execution order rotates across timing
samples. Generation, cloning and full stable-output checks are outside timing.
Timing includes each sort's own allocations, initialization, passes and compaction.
The current block implementation allocates `MaybeUninit<T>` scratch and only
initializes live records; the original Rust baseline initialized every slot.
C uses uninitialized malloc scratch. A failed warmup is recorded as
panic/incorrect and excluded from timing;
any later validation failure terminates the benchmark.

Extra heap bytes are measured separately from timing using a Rust System allocator
wrapper. The reported peak excludes input, expected output and cloning, and counts
requested allocation sizes, not allocator metadata, stack storage or RSS. Tracking
is disabled during timing. C allocations bypass Rust's allocator, so its exact
requested heap size is calculated from the original C struct and allocation
expressions in a small wrapper that includes the source unchanged; CSV identifies
this as `c_requested_heap_formula`. It does not instrument the timed C function.

The CSV preserves individual samples, status, record size and memory measurement
kind. The summary reports medians, min–max range and heap peaks. Record CPU,
compiler versions, upstream revision, flags and system load alongside the data.
This is a warm-cache microbenchmark, not a cold-cache test or allocator-independent
scatter measurement. Host scheduling and frequency scaling can affect results.

## Parameter sweeps

The tuning mode scans radix 4/6/7/8 and target block bytes from 512 through 65536
(powers of two). It uses u32/u64/u128 and large u32 payloads, with uniform,
duplicate and skewed inputs. Output reports actual block bytes and elements.

```sh
taskset -c 0 tools/block_lsd_bench/target/release/block_lsd_bench \
  --tune 5 1000000 > tools/block_lsd_bench/results/tuning.csv
BLOCK_LSD_TUNE_CONFIGS='8:1024,8:2048,8:4096,8:8192,8:16384,8:65536' \
  taskset -c 0 tools/block_lsd_bench/target/release/block_lsd_bench \
  --tune 5 1000000 4000000 > tools/block_lsd_bench/results/confirmation.csv
```

`BLOCK_LSD_TUNE_CONFIGS` overrides the grid with comma-separated radix:block_bytes
pairs. Each configuration gets a memory/warmup run and rotating timed samples.
Select medians and validate a candidate on other sizes; a single fastest sample
is not a default-selection rule.

To separate key width from record size, payload mode holds the key at u32 while
varying total record bytes through 8/16/32/64/128/256. The comparison algorithms,
stable validation and memory measurement remain the same.

```sh
BLOCK_LSD_DISTRIBUTIONS='uniform,duplicates,skewed' \
  taskset -c 0 tools/block_lsd_bench/target/release/block_lsd_bench \
  --payload 5 1000000 > tools/block_lsd_bench/results/payload.csv
```

`BLOCK_LSD_DISTRIBUTIONS` optionally restricts the normal/payload comparison to
named distributions; the tuning mode always uses uniform, duplicates and skewed.

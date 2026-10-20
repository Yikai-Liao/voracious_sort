# Parallel block LSD scaling benchmark

This standalone harness compares the Rayon implementation with the original
OpenMP C implementation from radsort revision
`f69e816c3cd79d312cd67aea5b9cf1c338c1b371`. It compiles
`radixsort_parallel.c` and `radixsort_permuted.c` unchanged with
`-O3 -march=native -DNDEBUG -fopenmp`. The eight-byte u32/key-ordinal record is
ABI-compatible with the original uint32pair. Other record layouts use the
Rust generic implementation only.

```sh
RADSORT_SOURCE=/path/to/radsort RUSTFLAGS='-C target-cpu=native' \
  cargo build --release --manifest-path tools/block_lsd_parallel_bench/Cargo.toml
python tools/block_lsd_parallel_bench/run.py \
  --samples 5 --output results/block_lsd/parallel
python tools/block_lsd_parallel_bench/summarize.py \
  results/block_lsd/parallel --csv results/block_lsd/parallel/comparison.csv \
  > results/block_lsd/parallel/scaling.md
```

The default CPU list is specific to the tested Ryzen 7 8845H: physical cores
0,2,4,6,8,10,12,14 first, then their SMT siblings. Use `--cpus` for another
machine. Rayon workers are pinned individually. OpenMP places are supplied in
the subprocess environment, before libgomp initialization. Both runtimes'
actual worker CPUs are checked before sorting and recorded in the run log.
OpenMP uses `OMP_WAIT_POLICY=PASSIVE` and `GOMP_SPINCOUNT=0`, so its idle
workers sleep while another method is measured. The repository's existing `voracious_mt_sort` creates its own pool; its workers
inherit a mask containing the requested first p CPUs rather than a single CPU.
That baseline includes its pool construction cost. `rayon_block`, `rayon_stable`
and original OpenMP use warmed, reused runtimes. One-shot pool creation is not
included in the primary scaling measurement.

All layouts use radix 8 and 4 KiB blocks, giving 512/256/128/32 records per block
for u32/u64/u128/128-byte layouts. This is a fixed configuration, not an empirical
workload lookup policy. C uses its original 512-record blocks, matching u32.
Defaults cover 65,536/1,048,576/4,194,304 records, 1/2/4/8/16 threads, uniform,
256-key duplicates and 95%-zero skew. Options select loads, types, sizes and
methods. Runs execute sequentially; do not compile or benchmark concurrently.

Fixture generation, input clones, reference sorting, affinity setup and complete
output validation are outside timing. Algorithm order rotates within samples.
Each stable algorithm must match full key and payload identity against a stable
converted-key oracle. Existing `repo_mt` is unstable and is checked for sorted
keys plus exact identity/permutation, without claiming stability. Samples use
medians; raw min/max are retained in comparison.csv. The host is not isolated,
and frequency/memory pressure can affect measurements. No RSS or allocator-peak
measurement is made in this harness.

Speedup is `S_p = median(T_1) / median(T_p)` for the same parallel implementation,
and parallel efficiency is `E_p = S_p / p`. The summary also includes separate
ratios against serial block LSD, ordinary stable LSD and original C permuted LSD.
The 16-thread configuration uses SMT on eight physical cores; its thread
efficiency divides by 16 and is not a 16-physical-core result.

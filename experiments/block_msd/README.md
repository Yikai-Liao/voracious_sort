# Block MSD research archive

This directory collects the serial stable block-MSD prototypes, their measurements,
and the reasoning behind the experiments. Each stage records its own correctness,
space accounting and performance limits. The active [work-reduction study](work_reduction/REPORT.md)
implements the follow-up plan at 749ca4d, including independent reductions,
compatible combinations and explicit negative cases. These remain research code.

The branch starts from upstream commit `3dbdd7f`; all additions are under this
directory. The current crate uses the upstream radix traits and existing MSD
implementations through a local dependency. Historical LSD controls are frozen in `src/frozen_lsd/`; the current comparison
uses the exact submitted source in `src/submitted_lsd/`. Both build independently
of the separate `block-lsd` branch.

The follow-up [scan experiment](scan_experiment/REPORT.md) compares early
termination of the variation scan with the exact archived full-scan source and
adds a corrected stable-MSD comparison. Its measurements are separate from the
historical matrices below. Feature `cf_early_scan` selects the candidate in
`src/count_first.rs`; the default retains the archived full scan.

The count-first distribution ingredients are attributed to the prior construction
in [COUNT_FIRST.md](COUNT_FIRST.md#prior-art).

The [node-local materialization experiment](node_local_experiment/REPORT.md)
independently tests per-node permutation and bounded contiguous stable MSD.

The previous [combined-candidate follow-up](combined_experiment/REPORT.md), frozen
at 749ca4d, compares three MSD combinations, the node-local baseline, submitted Block LSD
at two block sizes, and ordinary/stable MSD plus Rust's stable sort. It adds
strict reverse input and separate successful/last-inversion digit fixtures.

The [independent strategy comparison](strategy_experiment/REPORT.md) implements
and measures prefix writeback, carried boundaries, leaf batching, budgeted joint
counts, two admission gates and the single-layer/deferred minority paths.

## Iterating on the unified Pa experiment

The release profile reuses incremental artifacts with 16 codegen units. Keep the
same target directory and flags between edits; use `--jobs 6` on this six-vCPU
host. `frontier_narrow_screen` compiles only the u8/u16 primitive and ID layouts
in the benchmark harness, while retaining the same generic sorting code and full
stable oracle:

```sh
RUSTFLAGS='-C target-cpu=native' cargo build \
  --manifest-path experiments/block_msd/Cargo.toml --release --jobs 6 \
  --bin frontier_experiment --features frontier_narrow_screen
```

Use that build for the first known-negative screen. A passing mechanism still
needs a build without this feature, the full layout matrix, and the independent
work, heap and safety checks. Freeze the source, build flags and copied ELF before
timing. Historical stage manifests retain their own build settings, including
older non-incremental builds; do not overwrite their ELF files or combine their
measurements with new binaries. The failed scatter variants are archived in
[pa_scatter](pa_scatter/REPORT.md) and removed from the active implementation.

## Reading the results

- [Latest work-reduction report](work_reduction/REPORT.md): two-array cached kernel,
  path/cycle placement, prepared fallback, fused evidence, combinations,
  lifetime-aware admission and matched native/heap/work measurements.
- [Reproduce the latest study](work_reduction/REPRODUCE.md) and
  [space contract](work_reduction/SPACE.md).

- [EXPERIMENT_PLAN.md](EXPERIMENT_PLAN.md): experiment order, controls, budgets,
  correctness gates and stopping criteria for the follow-up proposals.

- [REPORT.md](REPORT.md): progression, correctness coverage, space accounting,
  performance results and remaining gaps.
- [COUNT_FIRST.md](COUNT_FIRST.md): arbitrary-size dense-node construction,
  global block directory, shared boundaries and ownership argument.
- [PHASE_DIAGNOSIS.md](PHASE_DIAGNOSIS.md): final focused native timing,
  intrusive phase probes and sampling profiles.
- [BASELINE_STABILITY.md](BASELINE_STABILITY.md): the existing stable-MSD
  baseline's equal-key reversal failure and its isolated reproducer.
- [reference_model/COMPARISON.md](reference_model/COMPARISON.md): correspondence
  with the supplied mathematical models, independently rerun cases and limits.

## Source and data map

Paths in this table are relative to this directory. Versioned sources and reports
are historical snapshots; their references to "current" or "active" describe
that stage. The active work-reduction report describes the latest stage; the top-level report
is retained for the earlier progression.

| Stage | Preserved source | Measurement and validation records |
| --- | --- | --- |
| v1: shared arena and DFS streams | `v1/lib.rs`, `v1/REPORT.md` | `v1/bench-*.csv`, top-level `bench-{100k,1m}.csv`, `test-{debug,release,asan}.txt` |
| v2: one-gap stream | `v2/lib.rs`, `v2/REPORT.md` | `v2/bench-v2-*.csv`, top-level `bench-v2-*.csv` |
| v3: bounded dense-node scatter | `v3/lib.rs` | `v3/bench-v3-*.csv`, top-level `bench-v3-*.csv` |
| v4: uninitialized scratch and bounded leaves | `v4/{lib,main}.rs` | `bench-v4-*.csv`, `v4-source-hashes.txt`, `v4-lsd-baseline.rs` |
| v5: span consumption, simple-stream and terminal-fusion variants | `v5/{lib,main}.rs`, `v5/REPORT.md`; bounded backend remains in `src/lib.rs` | `test-v5-*.txt`; v5 comparison rows in later full matrices |
| First complete count-first backend | `count_first_v1/` | `bench-count-first-N.csv`, `comparison-count-first*.csv`, `test-count-first-*.txt`, `count-first-source-hashes.txt`, `count-first-lsd-baseline.rs` |
| Endpoint cursors and leaf ablations | `endpoint_v1/`; active `src/count_first.rs` | `ablation-endpoint-*-N.csv`, `test-endpoint-*.txt`, `endpoint-source-hashes.txt` |
| Endpoint with standard stable leaves | active crate, feature `cf_std_leaf` | `bench-endpoint-std-N.csv`, `comparison-endpoint-std.csv` |
| Focused normal timing and phase diagnosis | `profile_normal_v1/`, `src/bin/profile_count_first.rs`, `src/phase_{algo,ordinary}/` | `focused-normal-*.csv`, `phases-*.csv`, `profile-*.{csv,log,txt}`, `profile-normal-hashes.txt` |
| Compact remaining-count draft | `count_first_compact_draft/` | Uncompiled draft; no measurement or correctness claim |
| Node-local materialization | `node_local_experiment/v1_free_list.rs`, active `src/node_local.rs` | [first-stage report](node_local_experiment/REPORT.md), `node_local_experiment/measurements/` |
| Independent strategy comparison | `src/{node_local,carried_boundaries,leaf_batch,joint_histograms,materialization_gate,skew_paths}.rs`, `src/bin/strategy_experiment.rs` | [unified report](strategy_experiment/REPORT.md), raw samples, hashes and validation under `strategy_experiment/` |
| Scan early-termination follow-up | `scan_experiment/full_scan.rs`, `src/count_first.rs` with `cf_early_scan`, `src/stable_baseline/` | [scan experiment report](scan_experiment/REPORT.md), `scan_experiment/measurements/`, comparison/counter summaries |
| Work-reduction follow-up at 749ca4d | `src/reduction_{node,gate,stream,admission}.rs`, `src/work_reduction.rs`, `src/bin/work_reduction_experiment.rs` | [latest report](work_reduction/REPORT.md), paired first/second-stage matrices, diagnostics, boundary and kernel data under `work_reduction/` |

Some early CSVs are retained both at the top level and beside their source
snapshot. They are copies of the same observations, not independent trials.
Historical snapshots do not include every old manifest, harness and executable;
their original hashes identify provenance but do not guarantee exact replay of
every old binary. Some historical drivers import the then-current root block-LSD
module. Use the active crate for builds on this branch, and pair each old dataset
with its recorded version rather than substituting the active source.

The v4 run at 262,144 records is partial: it stopped at a stable-baseline identity
failure. There is no v4 1,048,576-record dataset from that run. The complete
count-first and endpoint-std matrices each cover nine sizes, five record layouts
and six distributions (270 cases, 1,350 algorithm rows). Rows marked
`unstable_baseline` do not qualify as stable-sort comparisons. Ordinary MSD has
an unstable contract and is reported separately.

## Build and reproduce

Run these commands from the repository root. The headline endpoint matrix used
`cf_std_leaf`; the default build keeps the experimental insertion-sort leaves.
The crate has no additional third-party dependencies. The profiling driver and
shell scripts use Linux facilities (`taskset`, optional `perf` descriptors).

```sh
cargo test --manifest-path experiments/block_msd/Cargo.toml --lib --test correctness
cargo test --manifest-path experiments/block_msd/Cargo.toml --release \
  --features cf_std_leaf --lib --test correctness
cargo build --manifest-path experiments/block_msd/Cargo.toml --release \
  --features cf_std_leaf --bins
```

The matrix runner tests, builds, and writes CSVs into this directory. Choose an
idle allowed CPU. The example uses a new output suffix to preserve archived data;
omit the trailing sizes to run all nine sizes. `MSD_BLOCK` defaults to 64.

```sh
MSD_FEATURES=cf_std_leaf MSD_VARIANT=endpoint-std-rerun MSD_CPU=0 \
  experiments/block_msd/run.sh 16 1024
```

To summarize the archived endpoint matrix without rerunning it:

```sh
MSD_PRIMARY=count_first_msd_endpoint_std_leaf python3 experiments/block_msd/analyze.py \
  experiments/block_msd/bench-endpoint-std-*.csv
```

A focused normal run writes results to standard output. Enable `cf_phases` in
addition to `cf_std_leaf` for the intrusive diagnostic path described in
[PHASE_DIAGNOSIS.md](PHASE_DIAGNOSIS.md).

```sh
taskset -c 0 experiments/block_msd/target/release/profile_count_first \
  u32 16384 20 uniform endpoint
```

`run-asan.sh` runs the library and correctness tests using rustc's AddressSanitizer
support for `x86_64-unknown-linux-gnu`. For the std-leaf configuration:

```sh
MSD_FEATURES=cf_std_leaf experiments/block_msd/run-asan.sh
```

Archive validation on 2026-10-15 passed the default debug tests and std-leaf
release/ASan tests, each with one unit test and eleven integration tests. All
targets/features passed `cargo check`, and all std-leaf release binaries built.
A 1,024-record matrix smoke run verified 150 rows; the existing stable-MSD
129-record regression reproduced as documented. Regenerating the archived
endpoint summary matched all 270 cases. Build, test and regression logs are in
`validation/archive-*.txt`; this validation does not replace the historical
performance runs. CSV line endings and profiling/test output are preserved.

## Interpretation limits

Measurements belong to their recorded fixture, source, compiler and machine.
Generation, cloning and verification were outside the matrix sort timers;
requested-heap measurements were separate and exclude stack, allocator headers
and RSS. Phase probes add material timing overhead and their saved stage values
must not be summed into a claimed median partition.

The native implementation still writes terminal records through a dense writer
and performs a final block permutation. C+E retention, parallel root/worker
scheduling and batch evacuation were not implemented. Supplied Python models
and their finite reruns are abstract checks, not native concurrent execution or
space measurements. Production integration, complete raw-pointer proof and Miri
validation remain unfinished.

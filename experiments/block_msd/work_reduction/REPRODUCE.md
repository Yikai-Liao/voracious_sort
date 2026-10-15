# Reproduce without overwriting published measurements

The source/binary and data ledgers identify the two measured stages. Use the first-stage commit `0669c11e09f07b06c21a70fafc6291b49410677d` for the first-stage data. The current source contains the second-stage candidates. Keep their absolute times in separate batches and compare each candidate to its same-batch control.

## Current stage

From the repository root:

```sh
export MSD_REDUCTION_OUT=/tmp/block-msd-reduction-rerun
experiments/block_msd/work_reduction/run.sh combined
python3 experiments/block_msd/work_reduction/run.py focused
python3 experiments/block_msd/work_reduction/run.py phase2_diagnostics
python3 experiments/block_msd/work_reduction/run.py phase2_boundaries
python3 experiments/block_msd/work_reduction/analyze.py \
  --output "$MSD_REDUCTION_OUT/phase2" "$MSD_REDUCTION_OUT"/combined-*.csv
python3 experiments/block_msd/work_reduction/analyze.py \
  --output "$MSD_REDUCTION_OUT/focused" "$MSD_REDUCTION_OUT/focused-1048576.csv"
python3 experiments/block_msd/work_reduction/validate_stage2.py
```

`run.sh` builds native and diagnostic binaries before starting measurements. Its default output is `work_reduction/rerun`, rather than the committed data directory. `MSD_CPU` defaults to CPU 0; select an available isolated CPU on a different machine. The native binary has `cf_std_leaf` only. The diagnostic binary additionally has `cf_work,cf_phases`; its phase times and heap are not native performance observations.

The second-stage matrix rotates 14 methods over 14 samples. The focused matrix rotates 10 methods over 20 samples. Do not run compilers, tests, other matrices or diagnostics concurrently with native timing.

## Frozen first stage

Create a separate detached checkout/worktree at 0669c11. In that checkout, build its native and diagnostic binaries as its `run.sh` specifies, then run `full`, `diagnostics`, `boundaries` and `kernels` sequentially. That snapshot's runner predates the output-directory option, so use a disposable checkout and keep its generated data separate from the second stage. Its source hashes include the root path dependency as well as the experimental crate.

The frozen first-stage native ELF copies are recorded in `stage1-preserved-binary-sha256.txt`; the original measured paths remain in `stage1-binary-sha256.txt`. The second-stage build reused those original target paths only after preserving the first-stage binaries unchanged.

## Validation commands

```sh
cargo test --manifest-path experiments/block_msd/Cargo.toml \
  --release --features cf_std_leaf
cargo test --manifest-path experiments/block_msd/Cargo.toml \
  --features cf_std_leaf,cf_work,cf_phases --lib --test correctness
cargo check --manifest-path experiments/block_msd/Cargo.toml \
  --all-targets --all-features
python3 experiments/block_msd/work_reduction/block_model.py
```

The recorded ASAN runs use `RUSTC_BOOTSTRAP=1`, `RUSTFLAGS=-Zsanitizer=address`, target `x86_64-unknown-linux-gnu`, and a separate Cargo target directory. Both `cf_std_leaf` and `cf_std_leaf,cf_work,cf_phases` algorithm configurations are covered. The finite graph model and ASAN serve different purposes; neither alone establishes correctness for arbitrary custom extractors.

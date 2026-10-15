#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
export RUSTFLAGS="${RUSTFLAGS:--C target-cpu=native}"
CARGO_TARGET_DIR=/tmp/block-msd-reduction-native cargo build --release --features cf_std_leaf --bin work_reduction_experiment --bin work_kernel_experiment
CARGO_TARGET_DIR=/tmp/block-msd-reduction-diagnostic cargo build --release --features cf_std_leaf,cf_work,cf_phases --bin work_reduction_experiment
python3 work_reduction/run.py "${1:-full}"

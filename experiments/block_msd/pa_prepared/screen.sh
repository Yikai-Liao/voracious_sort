#!/usr/bin/env bash
set -euo pipefail
p=experiments/block_msd/pa_prepared
python3 "$p/run.py" screen-narrow-b64-s42 --n 1048576 --reps 4 --seed 42 --layouts u8,u16,u8_id8,u16_id8 --cases uniform,sparse
python3 "$p/run.py" screen-large-b512-s42 --n 1048576 --block 512 --reps 4 --seed 42 --layouts large128 --cases uniform,majority_prefix,deep_unique90
python3 "$p/run.py" screen-medium-b64-s42 --n 262144 --reps 4 --seed 42 --layouts u64,u128,wide32 --cases uniform,majority_prefix,deep_unique90
python3 "$p/run.py" screen-known-skew-b64-s42 --n 1048576 --reps 4 --seed 42 --layouts u64 --cases deep_unique90

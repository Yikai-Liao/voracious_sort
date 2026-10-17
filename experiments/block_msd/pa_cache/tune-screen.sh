#!/usr/bin/env bash
set -euo pipefail
methods=Pa,Pa_band,Pa_unified_cache_t0,Pa_unified_cache_t262144,Pa_unified_cache_t1048576,Pa_unified_cache_t4194304,Pa_unified_cache_t16777216,Pa_unified_cache_toff,stable_msd,Pa
python3 experiments/block_msd/pa_cache/run.py tune-262144-block64-seed42 --n 262144 --reps 4 --seed 42 --layouts u64,u128,wide32,large128 --cases uniform,majority_prefix,deep_unique90 --methods "$methods"
python3 experiments/block_msd/pa_cache/run.py tune-1048576-block512-seed42 --n 1048576 --reps 4 --seed 42 --block 512 --layouts u64,u128,wide32,large128 --cases uniform,majority_prefix,deep_unique90 --methods "$methods"

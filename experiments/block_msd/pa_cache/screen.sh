#!/usr/bin/env bash
set -euo pipefail
python3 experiments/block_msd/pa_cache/run.py cache-screen-262144 --n 262144 --reps 4 --seed 42 --layouts u64,u128,wide32 --cases uniform,majority_prefix,deep_unique90,deep_unique98 --methods Pa,Pa_band,Pa_band_cache,Pa_band_nested,Pa_band_sortleaf,Pa_unified_cache,stable_msd,Pa
python3 experiments/block_msd/pa_cache/run.py cache-critical-1048576-block512 --n 1048576 --reps 6 --seed 42 --block 512 --layouts u32,u64,wide32,large128 --cases uniform,majority_prefix --methods Pa,Pa_band,Pa_band_cache,Pa_unified,Pa_unified_cache,stable_msd,Pa
python3 experiments/block_msd/pa_cache/run.py skew-critical-1048576 --n 1048576 --reps 6 --seed 42 --layouts u64 --cases deep_unique90 --methods Pa,Pa_band,Pa_band_nested,Pa_band_sortleaf,Pa_unified_cache,stable_msd,Pa

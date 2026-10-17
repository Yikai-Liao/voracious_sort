#!/usr/bin/env bash
set -euo pipefail
python3 experiments/block_msd/pa_goal1/run.py shared-screen-262144 --n 262144 --reps 4 --seed 42 --layouts u64,u128,wide32 --cases uniform,deep_skew,majority_prefix,deep_unique90,deep_unique98
python3 experiments/block_msd/pa_goal1/run.py skew-regression-1048576 --n 1048576 --reps 4 --seed 42 --layouts u64 --cases deep_unique90 --methods Pa,Pa_terminal,Pa_band,Pa_band_sortleaf,Pa_band_nested,Pa_unified,stable_msd,Pa
python3 experiments/block_msd/pa_goal1/run.py ordered-screen-262144 --n 262144 --reps 6 --seed 42 --layouts u8,u16,u128,wide32 --cases equal,sorted,reverse,uniform --methods Pa,Pa_ordered,Pa_ordered_tiled,Pa_unified,L_frozen,stable_msd,Pa
python3 experiments/block_msd/pa_goal1/run.py local-screen-1048576-block512 --n 1048576 --reps 4 --seed 42 --block 512 --layouts u32,u64,wide32,large128 --cases uniform,deep_skew,majority_prefix --methods Pa,Pa_terminal,Pa_band,Pa_terminal_local,Pa_band_local,Pa_unified,stable_msd,Pa

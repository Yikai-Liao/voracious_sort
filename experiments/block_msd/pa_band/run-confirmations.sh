#!/usr/bin/env bash
set -euo pipefail
python3 experiments/block_msd/pa_band/run.py guards-1048576-seed42 --n 1048576 --reps 12 --seed 42 --layouts u8,u16,u32,u8_id8,u16_id8,small8,large128 --cases uniform,deep_skew,sparse --methods Pa,Pa_terminal,Pa_probe3,Pa_band,L_frozen,stable_msd,Pa
python3 experiments/block_msd/pa_band/run.py small-16384 --n 16384 --reps 12 --seed 42
python3 experiments/block_msd/pa_band/run.py shared-holdout-seed7 --n 1048576 --reps 12 --seed 7 --layouts u64,u128,wide32 --cases uniform,majority_prefix,deep_unique90,deep_unique98 --methods Pa,Pa_terminal,Pa_probe3,Pa_band,L_frozen,stable_msd,Pa
python3 experiments/block_msd/pa_band/run.py shared-block512 --n 1048576 --reps 12 --seed 42 --block 512 --layouts u64,u128,wide32 --cases uniform,deep_skew,majority_prefix,deep_unique90,deep_unique98 --methods Pa,Pa_terminal,Pa_probe3,Pa_band,L_frozen,stable_msd,Pa
python3 experiments/block_msd/pa_band/run.py large-block512 --n 1048576 --reps 12 --seed 42 --block 512 --layouts large128 --cases uniform,deep_skew,majority_prefix --methods Pa,Pa_terminal,Pa_probe3,Pa_band,L_frozen,stable_msd,Pa
python3 experiments/block_msd/pa_band/run.py work-confirm --n 1048576 --reps 1 --seed 42 --kind work --cases uniform,deep_skew,majority_prefix,sparse --methods Pa,Pa_terminal,Pa_probe3,Pa_band_child,Pa_band
python3 experiments/block_msd/pa_band/run.py work-distinct --n 1048576 --reps 1 --seed 42 --kind work --layouts u64,u128,wide32 --cases deep_unique90,deep_unique98 --methods Pa,Pa_terminal,Pa_probe3,Pa_band_child,Pa_band
python3 experiments/block_msd/pa_band/run.py memory-confirm --n 1048576 --reps 1 --seed 42 --kind memory --cases uniform,deep_skew,majority_prefix,sparse --methods Pa,Pa_terminal,Pa_probe3,Pa_band,L_frozen,stable_msd
python3 experiments/block_msd/pa_band/run.py memory-distinct --n 1048576 --reps 1 --seed 42 --kind memory --layouts u64,u128,wide32 --cases deep_unique90,deep_unique98 --methods Pa,Pa_terminal,Pa_probe3,Pa_band,L_frozen,stable_msd
python3 experiments/block_msd/pa_band/run.py memory-block512 --n 1048576 --reps 1 --seed 42 --block 512 --kind memory --layouts u64,u128,wide32,large128 --cases uniform,deep_skew,majority_prefix --methods Pa,Pa_terminal,Pa_probe3,Pa_band,L_frozen,stable_msd

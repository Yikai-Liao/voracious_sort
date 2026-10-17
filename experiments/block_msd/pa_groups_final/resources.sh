#!/usr/bin/env bash
set -euo pipefail
p=experiments/block_msd/pa_groups_final
work=Pa,Pa_band,Pa_unified_prepared_t16777216,Pa_unified_groups_t16777216
heap=Pa,Pa_band,Pa_unified_prepared_t16777216,Pa_unified_groups_t16777216,L_frozen,stable_msd
shared=deep_skew,majority_prefix,deep_unique90,deep_unique98
python3 "$p/run.py" work-guards-b64-s42 --kind work --reps 1 --seed 42 --methods "$work" --cases uniform,sparse
python3 "$p/run.py" work-prefix-b64-s42 --kind work --reps 1 --seed 42 --methods "$work" --layouts u64,u128,wide32 --cases "$shared"
python3 "$p/run.py" work-prefix-b512-s42 --kind work --reps 1 --seed 42 --block 512 --methods "$work" --layouts u64,u128,wide32 --cases "$shared"
python3 "$p/run.py" work-large-b512-s42 --kind work --reps 1 --seed 42 --block 512 --methods "$work" --layouts large128 --cases uniform,majority_prefix,deep_unique90
python3 "$p/run.py" work-medium-b64-s42 --kind work --reps 1 --seed 42 --n 262144 --methods "$work" --layouts u128 --cases uniform,majority_prefix,deep_unique90
python3 "$p/run.py" heap-guards-b64-s42 --kind memory --reps 1 --seed 42 --methods "$heap" --cases uniform,sparse
python3 "$p/run.py" heap-domain-b512-s42 --kind memory --reps 1 --seed 42 --block 512 --methods "$heap" --layouts u64,u128,u16_id8,small8,wide32,large128 --cases uniform,sparse
python3 "$p/run.py" heap-prefix-b64-s42 --kind memory --reps 1 --seed 42 --methods "$heap" --layouts u64,u128,wide32 --cases "$shared"
python3 "$p/run.py" heap-prefix-b512-s42 --kind memory --reps 1 --seed 42 --block 512 --methods "$heap" --layouts u64,u128,wide32 --cases "$shared"
python3 "$p/run.py" heap-large-b512-s42 --kind memory --reps 1 --seed 42 --block 512 --methods "$heap" --layouts large128 --cases uniform,majority_prefix,deep_unique90
python3 "$p/run.py" heap-medium-b64-s42 --kind memory --reps 1 --seed 42 --n 262144 --methods "$heap" --layouts u128 --cases uniform,majority_prefix,deep_unique90

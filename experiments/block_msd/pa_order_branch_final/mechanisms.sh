#!/usr/bin/env bash
set -euo pipefail
# Fixed before final timing; execute only if the primary seen-seed guards pass.
p=experiments/block_msd/pa_order_branch_final
distribution=Pa,Pa_unified,Pa_unified_cache_t16777216,Pa_unified_sample_t16777216,Pa_unified_reuse_t16777216,Pa_unified_prepared_t16777216,Pa_unified_groups_t16777216,Pa
python3 "$p/run.py" mechanism-distribution-large-b512-s42 --reps 16 --seed 42 --block 512 --methods "$distribution" --layouts large128 --cases uniform,majority_prefix,deep_unique90
python3 "$p/run.py" mechanism-distribution-medium-b64-s42 --reps 16 --seed 42 --n 262144 --methods "$distribution" --layouts u128 --cases uniform,majority_prefix,deep_unique90
order=Pa,Pa_ordered,Pa_ordered_tiled,Pa_unified,Pa_unified_groups_t16777216,stable_msd,Pa
python3 "$p/run.py" mechanism-order-small-b64-s42 --reps 14 --seed 42 --n 16384 --methods "$order" --layouts u8,u16,u128,wide32 --cases equal,sorted,reverse
band=Pa,Pa_band,Pa_band_nested,Pa_band_sortleaf,Pa_unified,Pa_unified_groups_t16777216,Pa
python3 "$p/run.py" mechanism-band-b64-s42 --reps 14 --seed 42 --methods "$band" --layouts u64,wide32 --cases majority_prefix,deep_unique90

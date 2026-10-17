#!/usr/bin/env bash
set -euo pipefail
p=experiments/block_msd/pa_order_count
methods=Pa,Pa_ordered_tiled,Pa_unified_groups_t16777216,L_frozen,stable_msd,Pa
for n in 16384 1048576; do
    python3 "$p/run.py" "screen-order-${n}-b64-s42" --n "$n" --reps 12 --seed 42 --methods "$methods" --layouts u8,u16,u128,wide32 --cases equal,sorted,reverse
done
python3 "$p/run.py" screen-uniform-b64-s42 --reps 12 --seed 42 --methods "$methods" --layouts small8,u64,u16_id8 --cases uniform
python3 "$p/run.py" screen-sparse-b64-s42 --reps 12 --seed 42 --methods "$methods" --layouts u8,u16 --cases sparse
python3 "$p/run.py" screen-large-b512-s42 --reps 12 --seed 42 --methods "$methods" --layouts small8,large128 --cases uniform --block 512

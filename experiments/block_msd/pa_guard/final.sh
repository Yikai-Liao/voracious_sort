#!/usr/bin/env bash
set -euo pipefail
p=experiments/block_msd/pa_guard
methods=Pa,Pa_band,Pa_unified_candidate_t16777216,L_frozen,stable_msd,Pa
shared=deep_skew,majority_prefix,deep_unique90,deep_unique98
python3 "$p/run.py" final-guards-b64-s42 --seed 42 --methods "$methods" --cases uniform,sparse
python3 "$p/run.py" final-prefix-b64-s42 --seed 42 --methods "$methods" --layouts u64,u128,wide32 --cases "$shared"
python3 "$p/run.py" final-seedflip-b64-s7 --seed 7 --methods "$methods" --layouts u64 --cases deep_unique90
python3 "$p/run.py" final-prefix-b512-s42 --seed 42 --block 512 --methods "$methods" --layouts u64,u128,wide32 --cases "$shared"
python3 "$p/run.py" final-cache-domain-b512-s42 --seed 42 --block 512 --methods "$methods" --layouts u64,u128,u16_id8,small8,wide32,large128 --cases uniform,sparse
python3 "$p/run.py" final-narrow-repeat-b64-s42 --seed 42 --methods "$methods" --layouts u8,u16,u8_id8,u16_id8 --cases deep_skew
python3 "$p/run.py" final-order-small-b64-s42 --seed 42 --n 16384 --methods "$methods" --layouts u8,u16,u128,wide32 --cases equal,sorted,reverse
python3 "$p/run.py" final-order-large-b64-s42 --seed 42 --methods "$methods" --layouts u8,u16,u128,wide32 --cases equal,sorted,reverse
python3 "$p/run.py" final-large-b512-s42 --seed 42 --block 512 --methods "$methods" --layouts large128 --cases deep_skew,majority_prefix,deep_unique90
python3 "$p/run.py" final-medium-b64-s42 --seed 42 --n 262144 --methods "$methods" --layouts u128 --cases uniform,majority_prefix,deep_unique90

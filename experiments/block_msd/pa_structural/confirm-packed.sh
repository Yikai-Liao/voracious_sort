#!/usr/bin/env bash
set -euo pipefail
p=experiments/block_msd/pa_structural
while [ ! -f "$p/final-summary.csv" ]; do sleep 2; done
base=Pa_unified_groups_t16777216
methods="$base,L_frozen,Rollercoaster,Pa_packed,Pa_packed,$base"
python3 "$p/run.py" confirm-b64 --binary narrow --reps 12 --methods "$methods" --layouts u32,u64,u128,u16_id8,small8,wide32,large128
python3 "$p/run.py" confirm-b512 --binary narrow --reps 12 --block 512 --methods "$methods" --layouts u32,u64,u128,u16_id8,small8,wide32,large128
python3 "$p/run.py" confirm-information-heldout --binary narrow --n 262144 --seed 20261019 --reps 12 --methods "$methods" --layouts u128,wide32 --cases project7_spaced,project8_spaced,project9_spaced,project16_spaced,project24_spaced,project32_spaced,project8_cross,project16_cross,project8_spaced_skew,project16_spaced_skew
python3 "$p/run.py" packed-heap-b64 --binary narrow --kind memory --reps 1 --methods "$base,Pa_packed,L_frozen,stable_msd" --layouts u8,u16,u32,u64,u128,u8_id8,u16_id8,small8,wide32,large128
python3 "$p/run.py" packed-heap-b512 --binary narrow --kind memory --reps 1 --block 512 --methods "$base,Pa_packed,L_frozen,stable_msd" --layouts u32,u64,u128,small8,wide32,large128
python3 "$p/analyze.py" confirm-

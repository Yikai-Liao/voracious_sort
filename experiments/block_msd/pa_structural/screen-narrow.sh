#!/usr/bin/env bash
set -euo pipefail
p=experiments/block_msd/pa_structural
base=Pa_unified_groups_t16777216
methods="$base,Pa_packed,Pa_narrow,Pa_packed_narrow,Pa_packed_narrow_runs,Rollercoaster,L_frozen,$base"
python3 "$p/run.py" narrow-b64 --binary narrow --reps 16 --methods "$methods"
python3 "$p/run.py" narrow-b512 --binary narrow --reps 16 --block 512 --methods "$methods"
python3 "$p/analyze.py" narrow-

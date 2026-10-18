#!/usr/bin/env bash
set -euo pipefail
p=experiments/block_msd/pa_structural
base=Pa_unified_groups_t16777216
methods="$base,Pa_packed,Pa_runs,Pa_packed_runs,Rollercoaster,L_frozen,$base"
python3 "$p/run.py" general-b64 --binary general --reps 14 --methods "$methods"
python3 "$p/run.py" general-b512 --binary general --reps 14 --block 512 --methods "$methods"
python3 "$p/analyze.py" general-

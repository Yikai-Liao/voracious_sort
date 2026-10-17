#!/usr/bin/env bash
set -euo pipefail
p=experiments/block_msd/pa_outline
python3 "$p/run.py" screen-word-b64-s42 --seed 42 --reps 12 --cases uniform,sparse
python3 "$p/run.py" screen-word-b512-s42 --seed 42 --reps 12 --block 512 --layouts small8,u64 --cases uniform,sparse

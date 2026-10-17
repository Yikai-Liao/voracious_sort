#!/usr/bin/env bash
set -euo pipefail
p=experiments/block_msd/pa_groups
python3 "$p/run.py" screen-narrow-b64-s42 --n 1048576 --reps 12 --seed 42 --layouts u8,u16,u8_id8,u16_id8 --cases uniform,sparse

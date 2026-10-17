#!/usr/bin/env bash
set -euo pipefail
p=experiments/block_msd/pa_groups_final
methods=Pa,Pa_unified_prepared_t16777216,Pa_unified_groups_t16777216,L_frozen,stable_msd,Pa
python3 "$p/run.py" ablation-narrow-full-b64-s42 --reps 12 --seed 42 --methods "$methods" --layouts u8,u16,u8_id8,u16_id8 --cases uniform,sparse

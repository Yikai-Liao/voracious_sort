#!/usr/bin/env bash
set -euo pipefail
p=experiments/block_msd/pa_order_branch_final/comparisons
methods=Pa_unified_groups_t16777216,Fa,Rollercoaster,L_frozen,stable_msd,Pa_unified_groups_t16777216
python3 "$p/run.py" final-prefix-heldout-b64-s20261018 --seed 20261018 --methods "$methods" --layouts u64,u128,wide32 --cases deep_skew,majority_prefix,deep_unique90,deep_unique98

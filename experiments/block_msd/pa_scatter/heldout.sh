#!/usr/bin/env bash
set -euo pipefail
# Only after the frozen candidate passes the seen-seed matrix and independent
# work/memory/ASan; keep this seed unseen during mechanism selection.
python3 experiments/block_msd/pa_scatter/run.py final-prefix-heldout-b64-s20261018 --seed 20261018 --methods Pa,Pa_band,Pa_unified_backend_t16777216,L_frozen,stable_msd,Pa --layouts u64,u128,wide32 --cases deep_skew,majority_prefix,deep_unique90,deep_unique98

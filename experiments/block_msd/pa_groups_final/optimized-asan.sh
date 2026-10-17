#!/usr/bin/env bash
set -euo pipefail
p=experiments/block_msd/pa_groups_final
mkdir -p "$p/validation/optimized-asan"
for block in 3 17 64 129 512; do
  dest="$p/validation/optimized-asan/sparse-b${block}.csv"
  test ! -e "$dest"
  ASAN_OPTIONS=detect_leaks=1 taskset -c 2 experiments/block_msd/target/pa-groups-final/asan-time 262145 1 Pa_unified_prepared_t16777216,Pa_unified_groups_t16777216 sparse u8,u16,u32,u64,u8_id8,u16_id8,small8 time "$block" 42 > "$dest" 2> "${dest%.csv}.stderr"
done

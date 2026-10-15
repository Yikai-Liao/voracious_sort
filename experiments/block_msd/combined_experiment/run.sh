#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
export CARGO_TARGET_DIR="${MSD_COMBINED_TARGET:-target/combined-experiment}"
export RUSTFLAGS="${RUSTFLAGS:--C target-cpu=native}"
cargo build --release --features cf_std_leaf --bin strategy_experiment
combined_out=${MSD_COMBINED_OUT:-combined_experiment/rerun}
mkdir -p "$combined_out"
if [ "$#" -eq 0 ]; then set -- 1024 16384 262144 1048576; fi
for combined_size do
 taskset -c "${MSD_CPU:-0}" "$CARGO_TARGET_DIR/release/strategy_experiment" \
  "$combined_size" "${MSD_REPEATS:-9}" "${MSD_BLOCK:-64}" \
  "${MSD_LOADS:-uniform,deep_skew,skew95,shared_prefix,sorted,descending,reverse_unique,digit_grouped,digit_tail_inversion,almost_sorted}" \
  "${MSD_TYPES:-u32,u64,u128,wide32,large128}" "${MSD_METHODS:-core}" > "$combined_out/normal-$combined_size.csv"
done
python3 combined_experiment/analyze.py "$combined_out"/normal-*.csv > "$combined_out/comparison.csv"
python3 combined_experiment/summarize.py "$combined_out/comparison.csv" > "$combined_out/summary.csv"

#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
export CARGO_TARGET_DIR="${MSD_STRATEGY_TARGET:-target/strategy-experiment}"
export RUSTFLAGS="${RUSTFLAGS:--C target-cpu=native}"
cargo build --release --features cf_std_leaf --bin strategy_experiment
strategy_out=${MSD_STRATEGY_OUT:-strategy_experiment/rerun}
mkdir -p "$strategy_out"
if [ "$#" -eq 0 ]; then set -- 1024 16384 262144 1048576; fi
for strategy_size do
 taskset -c "${MSD_CPU:-0}" "$CARGO_TARGET_DIR/release/strategy_experiment" \
  "$strategy_size" "${MSD_REPEATS:-9}" "${MSD_BLOCK:-64}" \
  "${MSD_LOADS:-uniform,deep_skew,skew95,shared_prefix,sorted,descending,almost_sorted}" \
  "${MSD_TYPES:-u32,u64,u128,wide32,large128}" > "$strategy_out/normal-$strategy_size.csv"
done
python3 strategy_experiment/analyze.py "$strategy_out"/normal-*.csv > "$strategy_out/comparison.csv"

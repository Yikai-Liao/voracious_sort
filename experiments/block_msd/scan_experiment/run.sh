#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
export CARGO_TARGET_DIR="${MSD_SCAN_TARGET:-target/scan-experiment}"
export RUSTFLAGS="${RUSTFLAGS:--C target-cpu=native}"
cargo build --release --features cf_std_leaf,cf_early_scan --bin scan_experiment
scan_out=${MSD_SCAN_OUT:-scan_experiment/rerun}
mkdir -p "$scan_out"
if [ "$#" -eq 0 ]; then set -- 1024 16384 262144 1048576; fi
for scan_size do
    taskset -c "${MSD_CPU:-0}" "$CARGO_TARGET_DIR/release/scan_experiment" \
        "$scan_size" "${MSD_REPEATS:-9}" "${MSD_BLOCK:-64}" \
        > "$scan_out/normal-$scan_size.csv"
done
python3 scan_experiment/analyze.py "$scan_out"/normal-*.csv \
    > "$scan_out/comparison.csv"

#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
export CARGO_TARGET_DIR="${MSD_NODE_TARGET:-target/node-local-experiment}"
export RUSTFLAGS="${RUSTFLAGS:--C target-cpu=native}"
cargo build --release --features cf_std_leaf --bin node_local_experiment
node_out=${MSD_NODE_OUT:-node_local_experiment/rerun}
mkdir -p "$node_out"
if [ "$#" -eq 0 ]; then set -- 1024 16384 262144 1048576; fi
for node_size do
    taskset -c "${MSD_CPU:-0}" "$CARGO_TARGET_DIR/release/node_local_experiment" \
        "$node_size" "${MSD_REPEATS:-9}" "${MSD_BLOCK:-64}" > "$node_out/normal-$node_size.csv"
done
python3 node_local_experiment/analyze.py "$node_out"/normal-*.csv > "$node_out/comparison.csv"

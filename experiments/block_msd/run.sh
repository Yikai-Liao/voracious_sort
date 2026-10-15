#!/bin/sh
set -eu
cd "$(dirname "$0")"
msd_features=${MSD_FEATURES:-}
msd_variant=${MSD_VARIANT:-endpoint}
cargo test --features "$msd_features" --lib --test correctness --quiet
cargo test --release --features "$msd_features" --lib --test correctness --quiet
cargo build --release --features "$msd_features" --bin block_msd_research --quiet
# Run only while other experiments are idle on this CPU.
if [ "$#" -eq 0 ]; then
    set -- 16 64 256 1024 4096 16384 65536 262144 1048576
fi
for msd_scale do
    if [ "$msd_scale" -le 65536 ]; then msd_repeats=5; else msd_repeats=3; fi
    taskset -c "${MSD_CPU:-0}" target/release/block_msd_research \
        "$msd_scale" "$msd_repeats" "${MSD_BLOCK:-64}" \
        > "bench-count-first-${msd_variant}-${msd_scale}.csv"
done

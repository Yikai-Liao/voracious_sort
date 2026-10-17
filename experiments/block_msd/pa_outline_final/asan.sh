#!/usr/bin/env bash
set -euo pipefail
p=experiments/block_msd/pa_outline_final
CARGO_INCREMENTAL=1 RUSTFLAGS='-Zsanitizer=address -C target-cpu=native' /root/.cargo/bin/cargo +nightly test --manifest-path experiments/block_msd/Cargo.toml --locked --offline --release --jobs 6 --features frontier_work --lib --no-run --target x86_64-unknown-linux-gnu --target-dir experiments/block_msd/target/pa-outline-asan --message-format json-render-diagnostics -v > "$p/validation/build-asan-tests.jsonl" 2> "$p/validation/build-asan-tests.log"
python3 "$p/archive_asan.py" "$p/validation/build-asan-tests.jsonl" asan-tests
ASAN_OPTIONS=detect_leaks=1 experiments/block_msd/target/pa-outline-final/asan-tests frontier > "$p/validation/asan-tests.log" 2>&1
CARGO_INCREMENTAL=1 RUSTFLAGS='-Zsanitizer=address -C target-cpu=native' /root/.cargo/bin/cargo +nightly build --manifest-path experiments/block_msd/Cargo.toml --locked --offline --release --jobs 6 --bin frontier_experiment --target x86_64-unknown-linux-gnu --target-dir experiments/block_msd/target/pa-outline-asan --message-format json-render-diagnostics -v > "$p/validation/build-asan-time.jsonl" 2> "$p/validation/build-asan-time.log"
python3 "$p/archive_asan.py" "$p/validation/build-asan-time.jsonl" asan-time
bash "$p/optimized-asan.sh"

#!/usr/bin/env bash
set -euo pipefail
supplement_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
bundle_dir=$(dirname -- "$supplement_dir")
cd "$bundle_dir"
env RUSTFLAGS='-C target-cpu=native' CARGO_BUILD_JOBS=1 CARGO_TARGET_DIR="$bundle_dir/target" \
  taskset -c 0 /root/.cargo/bin/cargo build --release --locked \
  --manifest-path "$supplement_dir/harness/Cargo.toml" --bin block-lsd-pr-benchmark \
  > "$supplement_dir/build-time.log" 2>&1
cp "$bundle_dir/target/release/block-lsd-pr-benchmark" "$supplement_dir/benchmark-time"
env RUSTFLAGS='-C target-cpu=native' CARGO_BUILD_JOBS=1 CARGO_TARGET_DIR="$bundle_dir/target" \
  taskset -c 0 /root/.cargo/bin/cargo build --release --locked --features track-alloc \
  --manifest-path "$supplement_dir/harness/Cargo.toml" --bin block-lsd-pr-benchmark \
  > "$supplement_dir/build-memory.log" 2>&1
cp "$bundle_dir/target/release/block-lsd-pr-benchmark" "$supplement_dir/benchmark-memory"
"$bundle_dir/.venv/bin/python" "$supplement_dir/run.py" freeze > "$supplement_dir/freeze.log" 2>&1
"$bundle_dir/.venv/bin/python" "$supplement_dir/run.py" preflight > "$supplement_dir/preflight.log" 2>&1
"$bundle_dir/.venv/bin/python" "$supplement_dir/run.py" time > "$supplement_dir/time.log" 2>&1
"$bundle_dir/.venv/bin/python" "$supplement_dir/run.py" memory > "$supplement_dir/memory.log" 2>&1
"$bundle_dir/.venv/bin/python" "$supplement_dir/analyze.py" > "$supplement_dir/analysis.log" 2>&1

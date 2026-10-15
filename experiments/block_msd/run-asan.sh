#!/bin/sh
set -eu
cd "$(dirname "$0")"
RUSTC_BOOTSTRAP=1 RUSTFLAGS='-Zsanitizer=address' cargo test \
    --target x86_64-unknown-linux-gnu --features "${MSD_FEATURES:-}" --lib --test correctness

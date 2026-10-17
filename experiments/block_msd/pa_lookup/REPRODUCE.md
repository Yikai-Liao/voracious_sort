# Reproduction

Use source-commit.txt and source-sha256.txt in a separate checkout. Frozen binary-sha256.txt identifies the measured ELF; validate.py checks source with git show even after later source edits.

From the repository root, build with CARGO_INCREMENTAL=1 RUSTFLAGS='-C target-cpu=native' cargo build --manifest-path experiments/block_msd/Cargo.toml --release --jobs 6 --bin frontier_experiment --features frontier_narrow_screen. Profile release has incremental=true, codegen-units=16, debug=true. Copy the executable to a new immutable path and record a new hash.

Correctness uses CARGO_INCREMENTAL=1 CARGO_PROFILE_DEV_DEBUG=0 CARGO_TARGET_DIR=target/pa-guard-debug, --jobs6: cargo test --features frontier_work --lib frontier::; cargo test --features frontier_work --bin frontier_experiment; cargo check --all-targets --all-features. Assertions and overflow checks remain enabled.

Run screen.sh from the repository root after all builds/tests finish. validate.py checks source/ELF hashes, row completion, repetitions/slots, allocation addresses and empty stderr. review_screen.py requires fourteen reps and seven fixed slots. Run analyze.py and noise.py on the explicit raw file without pooling other stages. Sample quantiles describe paired variation, not confidence intervals.

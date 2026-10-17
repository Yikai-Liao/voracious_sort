# Reproduction

Use source-commit.txt to create an isolated checkout. Preserve the source manifest and Cargo.lock. The archived time executable and hash are in binary-sha256.txt. validate.py verifies source via git show at that commit, independently of later edits.

Build from experiments/block_msd with CARGO_INCREMENTAL=1 RUSTFLAGS='-C target-cpu=native' cargo build --release --jobs 6 --bin frontier_experiment --features frontier_narrow_screen. Release profile is incremental=true, codegen-units=16, debug=true. A rebuilt ELF requires its own binary hash and new output files.

Run screen.sh from the repository root with no compiler/test job running. run.py refuses to overwrite measurements. Then run validate.py, analyze.py, noise.py and review_screen.py. The raw screen consists of four repetitions per cell with six method slots, alternating execution direction and two Pa A/A slots, CPU 2. The narrow harness feature supports only u8/u16/u8_id8/u16_id8 and does not establish full-layout acceptance.

Correctness uses CARGO_INCREMENTAL=1 CARGO_PROFILE_DEV_DEBUG=0 CARGO_TARGET_DIR=target/pa-guard-debug with --jobs 6: cargo test --features frontier_work --lib frontier::; cargo test --features frontier_work --bin frontier_experiment; cargo check --all-targets --all-features. Debug assertions and overflow checks stay enabled.

# Reproduction

Create a separate checkout at source-commit.txt and preserve its source-sha256 manifest and Cargo.lock. The original copied executable is in binary-sha256.txt. validate.py checks source using git show at that commit, independently of later source edits.

From experiments/block_msd: CARGO_INCREMENTAL=1 RUSTFLAGS='-C target-cpu=native' cargo build --release --jobs 6 --bin frontier_experiment --features frontier_narrow_screen. The release profile has incremental=true, codegen-units=16 and debug=true. Copy the new ELF to a new immutable location and record its hash; a rebuilt executable is distinct evidence.

Run screen.sh from the repository root with no compile/test jobs running. For confirmation, follow CONFIRMATION.md exactly: diagnostic warmup, then run.py confirm-narrow-b64-s42 --n 1048576 --reps 28 --seed 42 --layouts u8,u16,u8_id8,u16_id8 --cases uniform,sparse. Scripts refuse measurement replacement. validate.py checks both files; review_screen.py requires four reps and review_confirm.py 28, both seven slots. analyze.py and noise.py consume the explicit file being reviewed. Keep the first screen separate from confirmation.

Correctness commands use CARGO_INCREMENTAL=1 CARGO_PROFILE_DEV_DEBUG=0 CARGO_TARGET_DIR=target/pa-guard-debug with --jobs 6: cargo test --features frontier_work --lib frontier::; cargo test --features frontier_work --bin frontier_experiment; cargo check --all-targets --all-features. Debug assertions and overflow checking remain enabled. Wide library test coverage does not turn the narrow harness timings into a full-layout campaign.

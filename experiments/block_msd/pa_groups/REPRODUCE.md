# Reproduction

Use source-commit.txt and the 156-file source-sha256.txt in a separate checkout. binary-sha256.txt records the immutable measured ELF. Rebuilds are separate evidence.

From the repository root: CARGO_INCREMENTAL=1 RUSTFLAGS='-C target-cpu=native' cargo build --manifest-path experiments/block_msd/Cargo.toml --release --jobs 6 --bin frontier_experiment --features frontier_narrow_screen. Release profile is incremental=true, codegen-units=16 and debug=true. Copy the resulting ELF to a new immutable location and record its hash.

Correctness uses CARGO_INCREMENTAL=1 CARGO_PROFILE_DEV_DEBUG=0 CARGO_TARGET_DIR=target/pa-guard-debug, jobs6, frontier_work: cargo test --lib frontier::; cargo test --bin frontier_experiment; cargo check --all-targets --all-features. Assertions/overflow checking remain on. A targeted block test run precedes the complete matrix for this new recycling schedule.

After all builds/tests finish, run screen.sh. validate.py checks complete rows, source/ELF, allocation and pairing. review_screen.py requires 12 repeats and six exact slots; analyze.py and noise.py consume the explicit file. Pa A/A uses slot 5 / slot 0 and paired Pa denominators use their per-repetition mean. No historical pooling or cross-cell pass average is used.

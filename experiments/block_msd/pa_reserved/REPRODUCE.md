# Reproduction

Create a separate checkout at the source commit recorded in source-commit.txt. Preserve the original Cargo.lock and the recorded source hashes. Build from experiments/block_msd with:

```sh
CARGO_INCREMENTAL=1 RUSTFLAGS='-C target-cpu=native' cargo build --release --jobs 6 --bin frontier_experiment --features frontier_narrow_screen
```

The profile has incremental=true, codegen-units=16 and debug=true. Copy the resulting executable to target/pa-reserved/time, then regenerate a new binary ledger: a rebuilt ELF is not the archived executable. From the repository root, use screen.sh and the run/analyze/noise/review scripts in this directory. Measurement filenames are protected from replacement; use a fresh output directory or a new measurement name.

The archived time executable is exactly the file in binary-sha256.txt. Run validate.py from any directory; it checks source contents via git show at the archived source commit and checks that copied executable. Its source manifest is intentionally independent of later source rollback.

Correctness commands use CARGO_INCREMENTAL=1 CARGO_PROFILE_DEV_DEBUG=0 CARGO_TARGET_DIR=target/pa-guard-debug with --jobs 6: cargo test --features frontier_work --lib frontier::; cargo test --features frontier_work --bin frontier_experiment; cargo check --all-targets --all-features. The narrow-screen feature affects harness instantiation only, so these library tests still cover wide records and converted keys.

Timing comparisons require the same immutable ELF and no concurrent compile/test jobs. Raw CSV/JSON metadata, input addresses, wall/thread-CPU timing, allocation rows and A/A slots must be retained. This stage establishes rejection of this narrow-record mechanism only.

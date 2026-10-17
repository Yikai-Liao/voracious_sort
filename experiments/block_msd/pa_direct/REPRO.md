# Reproduction

Do not overwrite frozen executables or raw output names.

Source commit: source-commit.txt. Build settings: build-settings.json.
Build: CARGO_INCREMENTAL=1 RUSTFLAGS='-C target-cpu=native' cargo build
--manifest-path experiments/block_msd/Cargo.toml --locked --offline --release
--jobs 6 --features frontier_narrow_screen --bin frontier_experiment -v
--timings. The current Cargo profile supplies opt3, CGU16 and line-table debug.
Copy the resulting executable into a new archive, never target/pa-direct/time.

The original screen ran bash experiments/block_msd/pa_direct/screen.sh after
all builds/tests finished. Every child command and start/end/resource context
is stored in measurements/*.json; *.csv rows and zero-byte *.stderr are raw.
For a rerun choose a new output prefix and retain this screen unchanged.

python3 experiments/block_msd/pa_direct/validate.py
python3 experiments/block_msd/pa_direct/review_screen.py
python3 experiments/block_msd/pa_direct/audit_summaries.py

summary-*.csv and noise-*.csv each describe one raw file. Static nm/objdump
selection and interpretation are in profile/README.md and symbols.json.

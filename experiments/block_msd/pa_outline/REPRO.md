# Reproduction

Source source-commit.txt and source-sha256.txt freeze the implementation. Native
release flags and feature are in build-settings.json. Cargo reused the existing
release cache with CARGO_INCREMENTAL=1, RUSTFLAGS='-C target-cpu=native',
--locked --offline --release --jobs 6 --features frontier_narrow_screen
--bin frontier_experiment. Do not overwrite target/pa-outline/time.

The original screen ran bash experiments/block_msd/pa_outline/screen.sh after
all builds/checks completed. Exact child argv and process resource snapshots
are in measurements/*.json. Choose fresh output names for a rerun.

python3 experiments/block_msd/pa_outline/validate.py
python3 experiments/block_msd/pa_outline/review_screen.py
python3 experiments/block_msd/pa_outline/audit_summaries.py

summary-*.csv and noise-*.csv each describe one file; raw files are unchanged.

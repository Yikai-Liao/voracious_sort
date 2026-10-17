# Reproduction

Source/flags: source-commit.txt, source-sha256.txt, build-settings.json, env/.
Frozen executables: binary-sha256.txt. Never overwrite those targets or raw files.
Native full time/work builds omit frontier_narrow_screen. Use
CARGO_INCREMENTAL=1 RUSTFLAGS='-C target-cpu=native' cargo build with
--manifest-path experiments/block_msd/Cargo.toml --locked --offline --release
--jobs 6 --bin frontier_experiment; Work adds --features frontier_work.

The original sequence was native full builds/tests, isolated asan.sh, resource
counts, timing-barrier verification, ablation.sh, final.sh. Work/heap counts ran
in parallel with the ASan build; no formal timing overlapped build/test work.
Exact child argv/resource/time metadata is in measurements/*.json. A rerun must
choose fresh output names. Do not execute heldout.sh or mechanisms.sh for this
failed candidate and present them as completed acceptance.

Validation:
python3 experiments/block_msd/pa_outline_final/validate.py
python3 experiments/block_msd/pa_outline_final/validate_asan.py
python3 experiments/block_msd/pa_outline_final/review_resources.py
python3 experiments/block_msd/pa_outline_final/compare_resources.py
python3 experiments/block_msd/pa_outline_final/review_ablation.py
python3 experiments/block_msd/pa_outline_final/review_matrix.py
python3 experiments/block_msd/pa_outline_final/audit_summaries.py

The original scalar and grouped loop bodies are unchanged from 2513fa5. The
outline attribute is the sorting-code difference; the added multibit payload
probe and seven-layout feature affect tests/development harness only. The full
build uses all ten layouts. Cache reclamation records retain every frozen ELF
and the latest complete native time/work incremental sessions. Profile runs
are separate diagnostics after formal measurements, documented in profile/.

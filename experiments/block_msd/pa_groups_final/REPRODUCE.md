# Reproduce and inspect

The archived source reference is source-commit.txt (`2513fa5`); source-sha256.txt
covers 156 source/Cargo files. The four immutable executables remain under
experiments/block_msd/target/pa-groups-final and are listed in binary-sha256.txt.

From this worktree, inspect the existing evidence without rebuilding:

```sh
python3 experiments/block_msd/pa_groups_final/validate.py
python3 experiments/block_msd/pa_groups_final/audit_summaries.py
```

Resource and timing plans are resources.sh, ablation.sh and final.sh. run.py
pins CPU2, records the exact command and environment snapshots, and refuses to
replace existing output names. Formal data are under measurements; sanitizer
and perf diagnostics are separate. mechanisms.sh and heldout.sh are unexecuted
plans because the primary seen-seed matrix failed. Do not run the held-out seed
as part of replaying this failed candidate.

For an independent rebuild, use a fresh persistent worktree at the source
reference. The existing experiment Cargo.toml contains the final release
profile; the native build command is:

```sh
CARGO_INCREMENTAL=1 RUSTFLAGS='-C target-cpu=native' cargo build \
  --manifest-path experiments/block_msd/Cargo.toml --locked --offline \
  --release --jobs 6 --bin frontier_experiment
```

The work executable adds `--features frontier_work`. Neither formal build uses
frontier_narrow_screen. Build/check commands and compiler arguments are captured
in validation/build-time.log, build-work.log, release-work.log,
generator-registry.log and all-targets-all-features.log. Nightly sanitizer flags
and the two separate profiles are recorded in build-settings.json and their
verbose build/test logs. Rebuilt ELF hashes may differ with paths/toolchains;
record the actual artifact and compare controls within that artifact.

The small8 gap can be reproduced directly with the rebuilt full runner:

```sh
taskset -c 2 experiments/block_msd/target/release/frontier_experiment \
  1048576 12 Pa,Pa_band,Pa_unified_groups_t16777216,L_frozen,stable_msd,Pa \
  uniform small8 time 64 42
```

Finish all builds and tests before timing. Keep raw rows, Pa A/A and complete
stable-oracle checks; do not combine a new run with archived rows to select a
faster median. The diagnostic perf command, ELF identity and interpretation
boundary are recorded in profile/small8-uniform/status.json.

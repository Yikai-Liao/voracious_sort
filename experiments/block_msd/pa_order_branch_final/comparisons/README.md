# Pa, Fa, Rollercoaster, and radix baselines

This folder reruns the frozen `Pa_unified_groups_t16777216` candidate against
Fa, Rollercoaster, the submitted Block LSD, and Stable MSD in one release
executable. The 91 seen cells and 12 previously held-out shared-prefix cells
use the exact layouts, cases, seeds, block sizes, and 12-repetition paired
rotation from the parent report. Two candidate slots provide A/A checks.

Rollercoaster is unstable. Its output is accepted when keys are nondecreasing
and sorting by the record's unique input identity reproduces every original
key and payload. Equal-key record order is deliberately ignored. The other
methods retain the stable key-and-identity oracle. All oracle work runs after
the timer stops.

Run `seen.sh`, then `heldout.sh`; `review.py` refuses incomplete or mixed-source
files and writes per-cell paired medians, p10/p90 ratios, slower-repetition
counts, CPU ratios, and A/A variation. It does not pool scenario timings into a
single speed claim.

The frozen executable lives at `experiments/block_msd/target/pa-comparator/time`.
`source-commit.txt` and `binary-sha256.txt` identify the runner and executable.
Build and reproduce from the repository root with:

```sh
CARGO_INCREMENTAL=1 RUSTFLAGS='-C target-cpu=native' cargo build \
  --manifest-path experiments/block_msd/Cargo.toml --release \
  --locked --offline --jobs 6 --bin frontier_experiment
cp experiments/block_msd/target/release/frontier_experiment \
  experiments/block_msd/target/pa-comparator/time
sha256sum experiments/block_msd/target/pa-comparator/time | \
  awk '{print $1}' > experiments/block_msd/target/pa-comparator/time.sha256
sha256sum experiments/block_msd/target/pa-comparator/time > \
  experiments/block_msd/pa_order_branch_final/comparisons/binary-sha256.txt
bash experiments/block_msd/pa_order_branch_final/comparisons/seen.sh
bash experiments/block_msd/pa_order_branch_final/comparisons/heldout.sh
python3 experiments/block_msd/pa_order_branch_final/comparisons/review.py
python3 experiments/block_msd/pa_order_branch_final/comparisons/validate.py
```

After rebuilding, refresh the adjacent `.sha256` sidecar and
`binary-sha256.txt` before running, as described by `build-settings.json`.
The runner refuses to overwrite an existing measurement file, so reproduce in
an empty comparison artifact directory.
The parent report's old LSD comparison came from its original ELF; this folder
provides the direct five-way comparison in one binary.

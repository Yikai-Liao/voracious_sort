# `Pa_kernel` validation execution and audit checklist

This is an execution checklist for the frozen final-source candidate. It makes no performance claim and does not authorize timing before the owner gives an explicit GO. Use immutable ELFs only, CPU 2, and one timing process at a time. Keep every binary cohort under a distinct prefix; never pool rows across ELF or source hashes.

## Comparators and acceptance signal

- `Pa_unified_groups_t16777216` is the frozen original PA comparator.
- `L_frozen` is the frozen Block LSD implementation (`submitted_lsd::block_lsd_stable_radixsort`).
- `stable_msd` is the distinct Stable MSD implementation (`stable_baseline::msd_stable_radixsort`). Report them separately. Do not call `L_frozen` Stable MSD or treat the two names as aliases.
- Report median-win and p90-win cell counts separately for each comparator. A material regression is candidate/reference median `> 1.05` and p10 `> 1`; investigate and independently repeat such a cell with reversed slots and A/A. A repeated material regression fails acceptance even if the overall win count is high.
- `audit.py`'s `p10_losses` count is the number of cells whose candidate/reference p10 is above 1. Its `regression_signals` list uses the material-regression threshold above, against original PA.
- Duplicate slots produce a within-cell A/A ratio. Report the distribution across cell-specific A/A medians and label it descriptive; p10/p90 are not confidence intervals.

## Conditional serial sequence

Each next stage is conditional on no unresolved material regression in the preceding gate.

1. Run the generic 46-cell screen:

   `python3 pa_structural/portable-screen.py --candidate Pa_kernel --binary kernel_final_generic --prefix kernel-generic`

   Audit with `python3 pa_structural/audit.py kernel-generic- --candidate Pa_kernel --cells 46`. This is 16 guard cells (four layouts by two cases at each of B64 and B512) plus 30 information cells (three layouts by ten cases), 12 repetitions, six method slots, 3,312 rows. Compare with original PA, `Rollercoaster`, and `L_frozen` Block LSD. This script does not include `stable_msd`.

2. If the 46-cell screen passes, run the seven generic additions as a separate cohort and audit separately:

   - `large128`, B512, cases `uniform,sparse,deep_unique90`, n=1,048,576.
   - `u128,wide32`, B64, cases `project8_spaced_skew,project16_spaced_skew`, n=262,144.

   Use `run.py`, 12 repetitions, and methods `Pa_kernel,Pa_unified_groups_t16777216,Rollercoaster,L_frozen,Pa_unified_groups_t16777216,Pa_kernel`. This prefix must use only `kernel_final_generic`.

3. If generic screens pass, run the exact native 103-cell matrix:

   `python3 pa_structural/matrix.py --candidate Pa_kernel --binary kernel_final_native --prefix kernel-final --reps 16`

   Then `analyze.py kernel-final-` and `audit.py kernel-final- --candidate Pa_kernel --cells 103`. The matrix contains the original input set, 13,184 rows, duplicate candidate and baseline slots, `Rollercoaster`, `L_frozen` Block LSD, and `stable_msd` Stable MSD. The audit's historical input-set check must pass.

4. If the native 103-cell matrix has no unresolved material signal, run the native 46-cell guards/information screen with a new native-only prefix and audit `--cells 46`.

5. Run the seed-20261020 holdout with `holdout-final.py --candidate Pa_kernel --binary kernel_final_native --prefix kernel-heldout`, then audit `kernel-heldout- --candidate Pa_kernel --cells 30`. This includes six sparse target cells at B512/B64 and 24 information cells.

6. Run the 17-cell frozen executable ABBA control with `compare-frozen.py --candidate Pa_kernel --binary kernel_final_native --prefix kernel-frozen`. Verify the expected prior ELF hash, all 12 commands in `kernel-frozen.json`, the 17 expected cells per phase, each raw row count, the outer order old/new/new/old, and the aggregate process return status. The script's `subprocess.run(check=True)` aborts on failure, but per-command return codes and per-command stderr files are not persisted. Capture the script's exit status and stdout/stderr at invocation. Its JSON contains one overall before/after vmstat snapshot and aggregate child resource usage.

   For each cell/group, compare `new:Pa_unified_groups_t16777216 / old:Pa_unified_groups_t16777216` to identify executable/common-path drift. Also report `new:Pa_kernel / old:Pa_unified_groups_t16777216`; interpret it alongside the new-baseline ratio. The script uses four outer executable runs in ABBA order, with eight inner reps per run. It concatenates the two old and two new runs and computes descriptive ratios by position. Input addresses are not emitted in its JSON and ratios do not pair identical allocations across processes; do not call them same-address paired confidence intervals. The two duplicate baseline slots in each process can be checked from raw CSV as within-executable A/A controls.

7. Memory screen: run two separate native commands, one each for block 64 and 512, with `--kind memory --n 1048576 --reps 1 --layouts u32,u128,wide32,large128 --cases uniform,sparse --methods Pa_unified_groups_t16777216,Pa_kernel`. Expect 8 cells and 16 rows per block, 16 cells and 32 rows total. Preserve both CSVs and metadata; do not combine block sizes into one command because `run.py` accepts one block size per process.

8. Work screen: use only `kernel_final_work`, `--kind work`, methods `Pa_unified_groups_t16777216,Pa_packed,Pa_kernel`, and one repetition. Run the n=65,537 `u128,wide32` information cases `project7_spaced,project8_spaced,project9_spaced,project16_spaced,project24_spaced,project32_spaced` as one cohort (12 cells, 36 rows). Run `large128/deep_unique90`, n=1,048,576, B512 as another cohort (one cell, three rows). Compare every work counter and `leaf_lengths` between `Pa_packed` and `Pa_kernel`; those two methods should have exact work equality. `Pa_packed` is a diagnostic reference, not the original PA comparator. Do not interpret debug-work wall time or CPU time as performance evidence.

## Oracle and resource fields

Every time, memory, and work invocation runs the stable `sort_by_key` oracle outside the timed region and again after each measured execution. The candidate must match every key and record serial exactly, including equal-key stability. `Rollercoaster` has a separate oracle: keys must be ordered and the complete record multiset, including serial/payload, must be preserved.

For run.py cohorts, preserve CSV, `.stderr`, and `.json`; verify zero return code, empty stderr, frozen source/ELF hashes, row and slot counts, one input address per cell, and `audit.py` output. Report process `ru_majflt`, `ru_maxrss`, and global `/proc/vmstat` swap deltas separately. Swap counters are machine-wide and cannot attribute activity to the benchmark. For memory mode, `heap_peak` is the tracked peak live allocation inside `execute`, `allocs` is the tracked allocation count, and the code asserts no tracked workspace remains live when sorting returns. These exclude the prebuilt input and oracle vectors; report process RSS separately. `REQUESTED` is accumulated internally but is not emitted in the current CSV. Work mode records leaf-length counts and algorithmic counters; it is instrumentation, not a timing sample.

## Report limits

Report only scopes actually run. State the source and ELF hashes, exact cell/row counts, oracle outcome, comparator-specific median/p90 wins, A/A, material-signal confirmations, process major faults, RSS, and machine-wide swap caveat. Distinguish Block LSD (`L_frozen`) from Stable MSD (`stable_msd`). If a generic gate fails, stop before native extensions; if native full-matrix fails, stop before exploratory extensions. No cross-machine or other-microarchitecture conclusion follows from this host.

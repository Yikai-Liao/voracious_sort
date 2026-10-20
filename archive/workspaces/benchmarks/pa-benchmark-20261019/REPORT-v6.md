# PA completion experiments: promising gains, acceptance still pending

Two general mechanisms now improve all 19 targeted cells in the latest combined screen. The candidate is **not accepted as a default**: three of 23 broad cells have median ratios 1.105–1.129 against saved PA, all at n=1024. No full candidate matrix was started. Existing Block LSD and the ordinary PA engine remain unchanged.

The strongest direction is stable completion of a bounded natural-run frontier: it improves all 15 million-record targets across u32, u64, u128, f32 and 128-byte records. Translating an exactly bounded native-width key interval independently improves all four million-record integer targets. The final combined revision retains both effects, with matched median candidate/PA ratios 0.216–0.456 across all 19 targets.

## Latest results, revision 6

| Case | n | Saved PA ms | Candidate ms | Candidate / PA | Fastest saved comparator ms |
|---|---:|---:|---:|---:|---:|
| u32 uniform_numeric | 1048576 | 25.4879 | 6.5025 | 0.257 | Block LSD 8.5353 |
| u32 normal | 1048576 | 24.3143 | 6.9632 | 0.284 | Block LSD 9.4459 |
| u64 uniform_numeric | 1048576 | 32.0117 | 9.8441 | 0.313 | Block LSD 11.1268 |
| u64 normal | 1048576 | 29.2531 | 8.3693 | 0.298 | Block LSD 13.0067 |
| u64 push_middle | 1048576 | 11.7866 | 3.1368 | 0.270 | Timsort 1.9801 |
| f32 push_middle | 1048576 | 13.4441 | 3.4258 | 0.245 | LSD 2.4937 |
| record128 push_middle | 1048576 | 139.3334 | 29.1591 | 0.216 | Timsort 19.1707 |
| record128 organ_pipe | 1048576 | 214.2526 | 92.0313 | 0.430 | std 78.2955 |

Each ratio is the median of six matched per-input ratios, and need not equal the quotient of the displayed timing medians. Comparator times are reused from the frozen Block LSD policy data; no comparator was rerun. Improving PA does not imply beating the fastest comparator, as the run-shaped rows show.

The 23 broad cells span uniform full-width keys, u128 common prefixes, few-unique keys, low constant bits, floating numeric input, all-equal/reversed inputs, large records and n=128/1024. Their three median losses above 10 percent are:

| Case | n | Saved PA ms | Candidate ms | Candidate / PA |
|---|---:|---:|---:|---:|
| f32 uniform | 1024 | 0.0165 | 0.0187 | 1.120 |
| u64 uniform | 1024 | 0.0168 | 0.0174 | 1.105 |
| u128 uniform | 1024 | 0.0241 | 0.0279 | 1.129 |

Other broad medians are at most 1.090. Every broad row, including observed ranges and losses below 10 percent, is retained in `adaptive-v6-screen/comparison.csv`. These historical comparisons cannot prove that no scenario regresses. In particular, earlier runs showed large variability on small inputs and occasional floating-point slowdowns. The same revision-5 executable measured u32 n=128 at ratio 1.021 in run-only mode and 1.903 in combined mode, despite both bypassing speculative work and using the same fallback. That motivates caution about attribution, not deletion of slower observations. Revision 6 measures this cell at 1.028.

## Mechanisms and ownership

`sort_pa_completion` is a separate experimental root entry. Its modes isolate interval completion, natural-run completion and their combination. All modes use the existing UnifiedGroups fallback, c=4 and minimum 1 KiB block policy in the benchmark. No dispatch depends on type names or distribution names.

- **Translated interval:** a bounded 64-key sample admits an exact min/max/variation scan only for a possible carry-crossing interval. An unsampled outlier rejects the candidate. Subtract the exactly proved minimum in the converted native key width, preserving signed/float order. Complete only if the translated full key uses no more scatter passes than PA's original first prefix partition. This repairs carry-induced apparent width, not arbitrary sparse-bit entropy.
- **Natural-run frontier:** prove up to min(128,max(2,n/128)) monotone runs in a fixed stack frontier before modifying any record. Descending runs are strict, so reversal preserves ties. Merge adjacent runs stably with boundary trimming and reusable scratch of at most 512*block records; larger merges use binary cuts and rotations. Rejected discovery leaves the full input unchanged. This handles general run frontiers, rather than naming displaced-element or organ-pipe distributions.

The original `pa.rs` and its tests are byte-for-byte unchanged relative to the worktree HEAD. The root entry, interval proof and natural-run completion own their speculative state. Revision 6 gives natural-run completion and the fixed-policy ordinary fallback separate compilation boundaries. The new `Work` return is not a fully instrumented comparison/movement counter for natural merges; endpoint timing supplies the evidence in this report.

## What changed after the earlier rejection

The previous report is preserved as `REPORT-v3.md`. Its conclusion was too broad for selecting a promising direction: it described failed integrations, without completing natural-run screening.

Revision 1 enlarged shared preparation/policy state and regressed broad cases. Revisions 2/3 used PA's scalar order proof at the new root, while UnifiedGroups actually uses the tiled proof with vectorizable equal-prefix reductions. This concrete mismatch helps explain the all-equal failure and is fixed in the current root. It does not explain every earlier slow timing. The u32 leaf comparison in `leaf-disassembly-evidence.json` has 420 normalized instructions and identical constants in the saved and revision-3 executables; a slow leaf-only timing was not proof of extra leaf work.

Revision 4 restores the original core and uses a fixed UnifiedGroups fallback, retaining four integer target wins with much smaller broad signals. Two short candidate-only rechecks preserve noisy observations rather than selecting the best run. Revision 5 adds correctly tiled natural-run completion: all 15 targets improve. Its broad floating-point results remain mixed; combined screening is diagnostic, not an acceptance declaration. Revision 6 isolates compilation boundaries and recovers many of these signals, but three small broad cases still exceed 10 percent. The current candidate therefore remains experimental.

## Reused references and frozen measurement protocol

Only new candidates were measured after the workflow correction. PA references come from `auto-baseline/time.jsonl`; the unnecessary earlier PA rerun is retained and was not repeated. Other algorithms come from the existing benchmark data referenced in `reuse-sources.json`. Input generation, oracle, runner, CPU 2 pinning and native opt3/codegen1/thin-LTO profile are retained.

Each stage freezes source and executable hashes before timing. Three seeds and two observations produce six rows per case. Every timed sort is checked outside timing for converted-key order, stable equal-key identity order and full payload preservation. Type, distribution, size, seed, order, block, radix and input digest match the saved PA row. Output digests are compared when batch parity agrees, because the harness XORs the digest once per repeated sort. No digest mismatch is waived by accepting a failed stability oracle.

Cross-run timings are screening evidence, not paired same-process causal estimates. No older algorithm was retimed to normalize the new candidates. Trial directories are immutable and all observations, including failed screens, remain available.

## Screening ledger

| Stage | Cases | Timing rows | Runtime seconds |
|---|---:|---:|---:|
| interval-target | 6 | 36 | 3.33 |
| interval-broad | 33 | 198 | 27.07 |
| interval-v2-target | 6 | 36 | 3.11 |
| interval-v2-broad | 33 | 198 | 26.76 |
| interval-v3-target | 4 | 24 | 2.13 |
| interval-v3-broad | 23 | 138 | 21.83 |
| interval-v4-target | 4 | 24 | 2.03 |
| interval-v4-broad | 23 | 138 | 21.52 |
| interval-v4-recheck1 | 5 | 30 | 1.48 |
| interval-v4-recheck2 | 5 | 30 | 1.46 |
| runs-v5-target | 15 | 90 | 11.88 |
| runs-v5-broad | 23 | 138 | 21.52 |
| runs-v5-recheck | 4 | 24 | 1.54 |
| adaptive-v5-screen | 42 | 252 | 35.35 |
| adaptive-v6-screen | 42 | 252 | 35.29 |

Runtime excludes compilation. The 5-type revision-5/6 release builds each take about 2m30s; a short 42-cell combined timing takes about 35s.

## Correctness and limits

The initial library suite passed all 48 tests. Revision 6 reran both translation tests and both natural-run tests; all four passed, including carry boundaries, an unsampled outlier, stable ties/payloads, scratch limits and rejection without mutation. Every timed row in every current screen passes its full stable oracle. Process logs include return status, RSS, swap and VM counters; all timed processes exited successfully and reported zero process VmSwap.

Final artifact audit: all 15 candidate-stage manifests still match their frozen hashes, all 1,608 candidate-only timing rows pass the stable oracle, and current worktree source matches the frozen revision-6 package. `git diff --check` passes. The audit result is in `validation-followup.json`.

Revision-5/6 endpoint coverage is five representative types, not all nine benchmark types. Signed i32/i64, f64 and record32 were not remeasured in the latest combined screen. No full 1045-cell candidate matrix, allocation benchmark, full natural-run work instrumentation or default adoption is claimed. The remaining acceptance work is to remove or bound the small-input overhead, then pass the broad screen before paying for a full candidate-only run.

Source: `/root/code/voracious_sort-workspaces/block-pa-benchmark-20261019/experiments/block_msd/src/frontier/`. Branch: `research/pa-benchmark-20261019`. The latest frozen package is `candidate-v6/harness`; its executable, manifest, timing rows and comparison are in `adaptive-v6-screen/`.

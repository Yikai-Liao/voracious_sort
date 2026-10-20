# PA candidate screening result

Status: experimental interval completion is not accepted. No default implementation was replaced. No full candidate benchmark or natural-run timing was started because the broad screen did not pass. Source stays in `/root/code/voracious_sort-workspaces/block-pa-benchmark-20261019` on `research/pa-benchmark-20261019`.

## Data reuse and validation

All measurements after the workflow correction execute only `pa_interval`. Saved `auto-baseline/time.jsonl` supplies PA reference timings. Existing Block LSD/LSD/std/Timsort data are reused. The earlier unnecessary PA baseline rerun is retained as evidence, not repeated. Candidate builds use the saved native opt3/codegen1/thin-LTO configuration. Revision 3 reduces the driver to five representative types; its source and executable are frozen separately.

Inputs match saved PA by type/distribution/length/seed/block/radix and input digest. Every timed sort passes an independent stable key, identity and payload oracle outside timing. Output digests match where batch parity permits: the harness XORs repeated output digests. Cross-run timings identify screening signals; they do not isolate source-level causality or prove performance on unmeasured cells.

## Existing PA weaknesses at 1,048,576 records

| Case | Saved PA ms | Saved comparator ms | PA / comparator |
|---|---:|---:|---:|
| u32 uniform_numeric | 25.488 | Block LSD 8.535 | 2.99 |
| u64 uniform_numeric | 32.012 | Block LSD 11.127 | 2.88 |
| i32 normal | 25.034 | Block LSD 9.084 | 2.76 |
| f32 push_middle | 13.444 | LSD 1.839 | 7.31 |
| record32 push_middle | 50.521 | Timsort 5.734 | 8.81 |

Narrow integer intervals crossing binary carries inflate ordinary varying-bit width; interval translation removes that artifact. Long natural runs remain a separate weakness. Mixed-sign floating point numeric distributions are not necessarily narrow intervals in converted-key coordinates.

## Mechanism and iterations

Translate converted native-width keys by an exactly proved minimum. Admit only if the translated full key takes no more scatter passes than the original first prefix partition. No distribution-name or type-name dispatch is used. The block strategy is c=4 and minimum 1 KiB.

- Revision 1 fused bounds into the shared preparation state. Targets improved, but the broad screen showed f32 uniform at 1.51x and u32 uniform at 1.27x saved PA time. Rejected.
- Revision 2 restored original recursive state and preparation functions, moving speculative completion to a separate root helper. Targets improved, but f32/u64 all-equal measured 2.04x/1.72x saved PA time. Rejected.
- Revision 3 probes before invoking the additional root order proof. Five types are screened: u32/u64/u128/f32/record128. All four numeric targets improve, but remaining broad losses prevent acceptance.

## Screening runs

| Stage | Cases | New timing rows | Runtime seconds |
|---|---:|---:|---:|
| interval-target | 6 | 36 | 3.33 |
| interval-broad | 33 | 198 | 27.07 |
| interval-v2-target | 6 | 36 | 3.11 |
| interval-v2-broad | 33 | 198 | 26.76 |
| interval-v3-target | 4 | 24 | 2.13 |
| interval-v3-broad | 23 | 138 | 21.83 |

Runtime excludes compilation. Every row is a new-candidate measurement; no PA or other old algorithm was retimed in these runs.

## Latest target results

| Case, n=1,048,576 | Saved PA ms | Candidate ms | Median ratio to saved PA |
|---|---:|---:|---:|
| u32 normal | 24.3143 | 7.9981 | 0.331 |
| u32 uniform_numeric | 25.4879 | 7.4391 | 0.291 |
| u64 normal | 29.2531 | 10.9354 | 0.376 |
| u64 uniform_numeric | 32.0117 | 11.3903 | 0.366 |

Ratios are medians of matched per-input observations, so they need not equal the quotient of the two displayed timing medians.

## Latest broad signals above 10 percent

| Case | n | Saved PA ms | Candidate ms | Median ratio |
|---|---:|---:|---:|---:|
| u128 common_prefix | 1048576 | 15.97508 | 17.42816 | 1.106 |
| f32 uniform | 1048576 | 12.24645 | 14.68235 | 1.172 |
| u64 all_equal | 1048576 | 0.87235 | 0.98136 | 1.115 |
| record128 uniform | 1024 | 0.04517 | 0.06022 | 1.342 |
| u32 uniform | 128 | 0.00137 | 0.00207 | 1.537 |
| u128 uniform | 1024 | 0.02409 | 0.02670 | 1.107 |

The n=128 path bypasses the new mechanism entirely. Its six matched ratios are all 1.394–1.571, versus saved PA A/A 0.867–1.222. This points to integration/code-generation overhead or cross-run effects beyond the admitted interval work; it is not evidence of incorrect interval detection. The screen does not establish a single root cause.

## Correctness and remaining scope

Initial library tests: 48 passed, including carry-boundary/outlier and stable bounded-merge tests. Revision 2 rechecked two translation tests and the expanded converted floating-point order test (including special values); all passed. Revision 3 moves the admission gate and every measured batch again passes the full stable oracle. No dedicated revision 3 unit-test rerun was made.

All timed processes exited successfully and reported zero VmSwap; process-level resource/vmstat logs are retained beside timing rows. The only nonzero screening command was the first broad comparison postprocessor before its batch-digest parity fix; sorting measurements themselves completed and were reanalyzed without retiming.

The natural-run completion code exists as an isolated experiment, with stable tie handling and bounded scratch. It has no endpoint performance validation and is not counted as a successful remedy. No performance claim or default adoption applies to it.

Artifacts: each stage includes manifest/source/executable hashes, time.jsonl, time-processes.jsonl, completion metadata and comparison.csv. `quick_screen.py` implements candidate-only measurement and saved-data matching. `QUICK-SCREEN.md` records the revised workflow.

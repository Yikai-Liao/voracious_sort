# Speed comparison

The final unified candidate (`Pa_unified_groups_t16777216`) was measured in
one release executable against Fa, Rollercoaster, the submitted Block LSD
(`L_frozen`), and Stable MSD. The matrix contains 103 scenarios, 12 repetitions
per scenario, and 7,416 timed rows. Each scenario has two candidate slots for
an A/A check and one slot for each comparison method. The runner uses the same
input allocation and rotates and reverses method order across paired rounds.

Rollercoaster may reorder equal keys. Its per-run check therefore requires
nondecreasing keys and an exact input-record multiset by unique identity,
including every payload field, while allowing tie reordering. The other
methods are checked against the stable key-and-identity result. Checks run
after timing. All 7,416 rows passed the applicable check; the smoke run also
covered an 8-byte record and a 32-byte record.

Across the 103 scenarios, the candidate's paired median wall time was lower
than Fa in 102, Rollercoaster in 76, Block LSD in 91, and Stable MSD in 100.
These are scenario counts, not a pooled speedup. The candidate's p90 paired
ratio was below 1 in 102 scenarios against Fa, 63 against Rollercoaster, 83
against Block LSD, and 95 against Stable MSD. The p10 ratio was above 1 in
zero, 12, 7, and zero scenarios, respectively; the other scenarios overlap the
per-repetition variation band. A/A cell medians had cross-scenario p10/median/
p90 of 0.969/1.002/1.028.
The one Fa median above 1 is a near tie (wide32 deep-unique90, B512: 1.003,
with paired p10/p90 0.969/1.127). No Stable MSD cell has p10 above 1; its three
candidate medians above 1 all overlap 1 within their paired ranges.

All 12 held-out shared-prefix scenarios (seed 20261018, used here only after
the candidate was fixed) had lower candidate median time than all four
baselines. The candidate also clearly gives up ground to Rollercoaster on
reversed inputs; that difference is visible in the paired repetitions rather
than being a stability constraint.

| Scenario | Pa (ms) | Fa (ms) | Rollercoaster (ms) | Block LSD (ms) | Stable MSD (ms) |
|---|---:|---:|---:|---:|---:|
| 1M u32 uniform, B64 | 13.280 | 41.956 | 13.759 | 11.836 | 21.213 |
| 1M wide32 uniform, B64 | 59.550 | 88.129 | 50.922 | 193.763 | 75.715 |
| 1M u16 reverse, B64 | 1.720 | 5.498 | **0.477** | 2.593 | 4.270 |
| 1M wide32 deep skew, B64 | 36.756 | 54.144 | 189.578 | 111.198 | 473.924 |
| 1M large128 deep unique, B512 | 200.092 | 228.211 | 234.971 | 262.441 | 385.576 |
| 1M u128 sparse, B512 | 94.731 | 226.340 | 79.588 | **35.634** | 171.512 |
| 1M wide32 majority prefix, held-out seed | 83.209 | 123.448 | 103.078 | 174.561 | 280.210 |

Times are per-method medians. The CSV contains each per-repetition ratio, its
p10/p90, slower-repetition counts, CPU-time ratios, and candidate A/A spread.
For example, the held-out wide32 majority-prefix cell has candidate/Stable
paired median ratio 0.299. The u128 sparse B512 cell is a clear Block LSD loss
for this candidate (paired median ratio 2.694); the u16 reverse cell is a clear
Rollercoaster win (candidate/Rollercoaster ratio 3.587). These cases show why
the scenario-level table matters more than one cross-scenario average.

The existing [main report](../REPORT.md) covers the algorithm, correctness,
space use, and earlier Stable/LSD evidence. This comparison changes only the
benchmark harness and records; it does not change the sorter implementation.
Reproduction commands and the frozen executable identity are in this folder.

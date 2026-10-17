# Explicit scalar outline: positive narrow screen

Only inline(never) is added to the original scalar scatter relative to Group
2513fa5. The entire scalar body and grouped body are unchanged. The redundant
Direct copy, runtime flag, policy and registry entries were removed. Source
8bf14e0 was committed/frozen before build and timing. An added stable u32-key/
8-byte-record test and harness-only seven-layout feature have no sorting-path
semantics. The all-target/all-feature check passed before the 1m24s native
release build. Native code confirms per-record scalar writes are inlined.

All 1296 rows of the fixed 18-cell screen completed with the full stable oracle,
zero stderr, correct methods, rotation positions, addresses, source/ELF hashes.
n1048576, seed42, CPU2, twelve repetitions, Pa/Prepared/Group/L_frozen/Stable/Pa.
Each raw file remains separate, with per-file A/A and thread-CPU diagnostics.

| B | layout | case | Group ms | Group/Prepared | Group/Stable | slower than Stable /12 |
|---:|---|---|---:|---:|---:|---:|
| 512 | small8 | sparse | 5.493 | 0.994 | 0.341 | 0 |
| 512 | small8 | uniform | 17.356 | 1.004 | 0.596 | 0 |
| 512 | u64 | sparse | 11.947 | 0.852 | 0.348 | 0 |
| 512 | u64 | uniform | 16.862 | 0.949 | 0.643 | 0 |
| 64 | small8 | sparse | 7.309 | 0.896 | 0.441 | 0 |
| 64 | small8 | uniform | 17.388 | 1.030 | 0.621 | 2 |
| 64 | u16 | sparse | 2.915 | 0.794 | 0.887 | 1 |
| 64 | u16 | uniform | 5.421 | 1.038 | 0.840 | 1 |
| 64 | u16_id8 | sparse | 4.390 | 1.048 | 0.786 | 1 |
| 64 | u16_id8 | uniform | 7.429 | 1.005 | 0.613 | 0 |
| 64 | u32 | sparse | 4.791 | 0.771 | 0.421 | 0 |
| 64 | u32 | uniform | 14.223 | 0.979 | 0.642 | 0 |
| 64 | u64 | sparse | 14.058 | 0.848 | 0.428 | 0 |
| 64 | u64 | uniform | 16.408 | 1.023 | 0.620 | 0 |
| 64 | u8 | sparse | 2.730 | 0.804 | 0.818 | 2 |
| 64 | u8 | uniform | 2.909 | 0.996 | 0.660 | 0 |
| 64 | u8_id8 | sparse | 4.099 | 1.039 | 0.740 | 1 |
| 64 | u8_id8 | uniform | 4.233 | 0.940 | 0.496 | 0 |

Decision: advance this simpler source to full-layout validation. Both Small8
uniform block sizes now take roughly 60-62% of Stable wall time, with the
primitive binary sparse guard below Stable too. Some individual paired samples
remain noisy (notably Small8 B64 A/A p90=1.583); medians do not certify all future
cells. The Group/Prepared binary ablation retains a benefit on the primitive
sparse cells; uniform cases usually leave grouping inactive.

A separate parser independently reproduced all 18*32=576 numeric fields.
This screen has no newly completed release work/heap or ASan run; final source
validation uses pa_outline_final, a full ten-layout ELF without the narrow
feature, safety/resources, the unchanged 91-cell seen matrix and final held-out
prefix seed. No older/newer binary timings are pooled, and no overall completion
is claimed. Frozen prior Group and Direct archives remain unchanged.

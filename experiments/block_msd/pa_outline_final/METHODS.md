# Full validation of outlined scalar scatter

Source 8bf14e0 is frozen. Relative to Group 2513fa5, the sorting implementation
changes only an inline(never) annotation on the original scalar scatter. The
Direct duplicate and policy were removed after a same-ELF screen found no
stable extra gain. Existing scalar and grouped function bodies remain exact.

No frontier_narrow_screen feature in final time/work builds: ten layouts. Time
uses native CPU, release opt3, CGU16, line-table debug, incremental cache, six
Cargo jobs, locked/offline dependencies; Work adds only frontier_work. Native
build/test and optimized ASan must finish before any formal timing.

The finite validation matrix is retained from pa_groups_final: 50 Work cells
(200 rows), 62 heap cells (372 rows), 8-cell Prepared/Groups ablation (576 timing
rows), and the same 91 seen-seed cells (6552 timing rows). Each primary cell has
twelve reps and six fixed slots Pa/Band/Groups/L_frozen/Stable/Pa, including
paired reverse complete rotations and Pa A/A 5/0. See scripts for exact cases,
layouts, sizes and block sizes. Per-file reviews must retain failures and sample
quantiles; no cross-file pooling or averages can override a failed cell.

Required targeted checks include both Small8/uniform block sizes, primitive
u8/u16 sparse, ID layouts, u128 medium, B512 128-byte records, shared prefixes
with duplicates AND fully distinct keys, and wide-key ordered/equal cases.
An unchanged Group-vs-Prepared work/heap check accompanies the compiler change.
Additional frozen old/new Group process pairing can isolate the source change;
record addresses differ across processes and must be stated explicitly.

Only after safety/resources and the entire seen matrix pass, run the existing
bounded mechanism ablations and heldout.sh (12 prefix cells, seed20261018,
864 rows). That seed remains unseen during selection. The overall goal remains
active until representative validation meets its requirements.

# Final validation campaign

Candidate Pa_unified_groups_t16777216 retains the confirmed grouped algorithm and the fixed offline 16 MiB threshold. The complete algorithm and recycling proof are in ../pa_groups/DESIGN.md. This source only clarifies copied comments and uses an equivalent overflow-safe private byte guard; build settings are recorded separately. Full source and same-ELF controls are frozen before any final timing.

Build/check time and work runners, debug ASan tests, optimized work tests and all-target/all-feature checks first. Then collect independent work and requested-heap data, plus the full-ELF narrow ablation (Prepared vs Groups). Do not interpret instrumented wall time as timing evidence. All formal timing uses the time ELF, CPU2, restored input allocation, complete stable oracle, twelve repetitions covering one complete rotation with paired reverse directions, and Pa slots 0/5 A/A.

The finite seen-seed matrix is final.sh: 91 cells, 6 slots, 12 reps, 6,552 rows. All ten layouts are explicit. The original final acceptance remains in ACCEPTANCE.md, with the grouped candidate name. The u8_id8 sparse /Prepared watch is assessed separately by the frozen full-ELF narrow ablation; its initial signal was not established in the 24-repeat screen confirmation. That ablation has eight cells, six slots and twelve reps, 576 rows.

Only after safety/work/heap, the ablation and all seen cells meet acceptance, execute heldout.sh: seed20261018, three shared-prefix layouts and four duplicate/distinct skew cases, 12 cells and 864 rows. Keep this seed unseen during source/parameter selection. Do not pool independent files or use an average to override a failed cell. Sample quantiles are not confidence intervals. Main-library defaults remain isolated from this experiment.

Resource scripts are fixed before measurement: 50 work cells (200 rows) compare Pa/Band/Prepared/Groups; 62 requested-heap cells (372 rows) add frozen LSD/Stable. The guard, prefix/B512, large-payload and medium cases are explicit in resources.sh. Work equality is required for logical traversal/pass/leaf fields; label evaluations may add one probe per eligible pass and compaction copies may differ. Heap review compares Groups/Prepared exactly and reports Pa/Stable peaks without treating requested heap as stack or RSS.

The additional same-ELF mechanism plan is fixed in mechanisms.sh before final
timing. If the primary seen-seed guards pass, it records 768 distribution rows
(six cells, eight slots, sixteen reps), 1,176 small-order rows (twelve cells,
seven slots, fourteen reps), and 392 band rows (four cells, seven slots,
fourteen reps). Each file covers complete paired rotations and preserves Pa
A/A. Distribution comparisons isolate sample/cache, reuse/cache,
prepared/sample, prepared/reuse and groups/prepared; cache/unified also tests
the bounded cached distributor. The order and band tables preserve individual
variants and the combined candidate. Differences between combined variants
must not be attributed to a single flag. These diagnostics do not override a
failed main cell or justify changing the frozen candidate on the held-out seed.

The debug sanitizer run covers assertions, counters, stable payload and recycling. A separate optimized sanitizer runner with frontier_work disabled probes the vectorizable pure-label path: n262145, five block sizes (3/17/64/129/512), seven eligible layouts, sparse seed42, Prepared/Groups. Its 70 oracle rows stay under validation/optimized-asan/; they are sanitizer diagnostics, never timing evidence. No held-out input is involved.

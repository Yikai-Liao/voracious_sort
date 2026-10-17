# Scalar two-cursor screen: rejected

Source c7cc1ca. The new method Pa_unified_binary_t16777216 uses local cursors only for Block bytes covered by a one-bit variation mask and records no larger than a machine word. It preserves original bucket count, workspace, reservations, fixup, compact and classifiers. One first-live-record probe is added per eligible nonempty pass and is included by the actual label_evals counter.

The 192-row narrow screen completed all full stable oracles, with matching source/ELF hashes, valid pairing/address restoration and empty measurement stderr. All 30 frontier debug tests passed (86.70s), the single workload test passed, and all-target/all-feature checking passed. Debug assertions and overflow checks were enabled with debug info disabled. Release used the same incremental/native/16-codegen-unit profile as the preceding stage and completed in 2m04s. No concurrent compilation/testing ran during timing. Independent recomputation checked all eight candidate medians and 24 candidate/reference paired medians.

| Cell | Binary median ms | Binary/Prepared paired median | Binary/Stable paired median |
|---|---:|---:|---:|
| u16 sparse | 3.503 | 0.979 | 1.103 |
| u16 uniform | 5.947 | 1.045 | 0.892 |
| u16_id8 sparse | 5.160 | 1.100 | 0.867 |
| u16_id8 uniform | 8.891 | 1.038 | 0.724 |
| u8 sparse | 3.932 | 0.979 | 1.080 |
| u8 uniform | 3.674 | 1.069 | 0.814 |
| u8_id8 sparse | 4.511 | 0.867 | 0.787 |
| u8_id8 uniform | 4.497 | 0.985 | 0.477 |

u16 sparse remained 10.3% slower than Stable by paired median (3.503 ms candidate). u16_id8 sparse was 10.0% slower than Prepared in all four pairs; its ratio p10/p90 was 1.047/1.128, with Pa A/A p10/p90 0.926/1.087. Several other cells have broad A/A variation, so small changes there remain unresolved. These are four-sample quantiles, not confidence intervals. Thread-CPU timing and per-pair directions are retained in review-screen.csv.

The register-cursor target appeared in the actual machine code, without an established end-to-end win. This stage fails the known narrow regression conditions. No full-layout build, ASan, release-work/heap campaign, extended matrix or held-out seed was run; seed 20261018 remains unseen and the active goal remains incomplete.

The scalar loop may be retained only as the explicit same-ELF control for a separate batched-cursor experiment. It is not an accepted optimization.

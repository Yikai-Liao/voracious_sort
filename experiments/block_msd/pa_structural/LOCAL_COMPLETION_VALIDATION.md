# Stable local-completion validation

Status: correctness passed; first native eight-cell float screen running. No full performance acceptance yet. The original 103 integer, 88 finite float and ordinary-ISA results from source `6fceaaa` remain a separate rejected cohort.

## Implementation and contract

Implementation commit `e86ca7a` adds two independent methods. `Pa_local_prefix` keeps the existing `Pa_kernel` classifier and logical leaf geometry, changing physical distribution to exact-count MSD boundaries and bounded dense LSD completion. `Pa_local_key` additionally completes the full remaining converted key on an ordinary node with no approved band or packed classifier. The screen tests whether eliminating small-leaf recursion is worth its extra low-byte work, including on wide integer keys.

Both methods use the existing stable recycling Block LSD for an oversized high-byte split and the existing stable dense LSD for a complete label that fits the unchanged `512 * B * sizeof(T)` scratch/histogram budget. Dense completion allocates one bucket-sized temporary record array. Block workspace is dropped before child completion. Each recursive label byte retains a 256-entry count array; at most 16 levels add about 32 KiB of bounded count stack, separate from the heap budget. The original 16 MiB execution gate, packing admission, hardware token and converted-key contract are unchanged. Source and frozen Block LSD outside the experiment remain unchanged.

A follow-up test-only commit `baaa505` strengthens a skew fixture to force constant-byte skipping. It adds an independent Work checker for equality of all 20 logical counters/leaf-distribution fields between the original kernel and the local-prefix variant. Physical classification, passes, scatter, compaction and local dense/block counts can differ.

## Correctness and builds

The native instrumented library suite passes 61/61 tests. The hardware-disabled configuration passes 61/61 library and 4/4 integer runner tests. The float harness passes 6/6, including actual sorting of f32/f64 NaNs, infinities, signed zeros, identities, payloads and stable ties through both new methods at B3/B64/B512. After strengthening the test-only fixture, its two focused tests pass again natively and with hardware disabled. They verify budget/digit boundaries, masks with holes and constant bits, complete stable records, and classifier execution context across dense, block and skipped bytes. AArch64 and RISC-V library cross-checks pass; these are not measurements on those architectures.

All six executables were finally rebuilt against the same source fingerprint `f25c7179804be7a2b4cb85d3c93aeca3ab3cfc73c587c58e50c387b215966586`, commit `baaa505`. Release builds use 16 codegen units, line-table debug information and incremental enabled; debug Work disables incremental. No compiler, tests or other benchmark remains active when the first timing command is authorized.

| Frozen executable | Flags / features | SHA-256 |
|---|---|---|
| `local_native` | native / none | `0bfde410274e35e080e631ae81fcc091c1ca864576edf2fde982ed7908129910` |
| `local_generic` | empty / none | `d84be081736da64c6ed2c94f8021c8aae9b9812bbfc8ceb05b82ddb8539c5700` |
| `local_work` | native / frontier_work | `12983e81af18822233c00e5f20b2d707b3151ab60302be40736f1ccd3974d213` |
| `local_float_native` | native / none | `16e9b2f106712698cb35d33b06d2e82e42da6a2869957c751f23a8ef7c4bc5ee` |
| `local_float_generic` | empty / none | `6482148b83d8141831e16f7b45aa37d1f48fed5feccd6dce21da9248d24a39f2` |
| `local_float_work` | native / frontier_work | `eb8905febb55aaf8c8b1e6340d28176d5e1224ec49f2a16fbce4a0da1ae67f9f` |

The copied metadata `local-*-binary.json` records complete source/extra-harness/script hashes, compiler version and flags. The runtime wrapper verifies those hashes before every invocation. Test and build logs are in `validation/*local*`.

## Performance screen

The predeclared scope and reproduction commands are in [LOCAL_COMPLETION_PLAN.md](LOCAL_COMPLETION_PLAN.md) and `local-screen.py`. CPU 2, rotating/reversed paired slots, same-method A/A, restored inputs and complete-record oracles remain mandatory. Native and ordinary-ISA executables have separate cohorts. Independent reversed 16-repetition four-slot confirmations decide material original-PA signals. Work is collected separately, with no timing claims.

Pending: first native B512 finite-float eight cells, confirmations, remaining representative floats/integers, then any justified larger acceptance scope. Built or frozen executables with no measurements have no performance conclusions.

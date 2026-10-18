# Stable local-completion validation

Status: **both methods rejected by independently repeated float regressions**. The first native eight-cell screen completed, all eight method/cell signals repeated in independent confirmations, and two separate Work diagnostics completed. Remaining native/generic float and integer screens were stopped. Built executables for those stopped scopes have no performance conclusions.

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

The first native screen contains 8 cells and 800 timed rows at n1,048,576, B512, seed42. Audits independently check both candidates against the same single ELF, row rotations, A/A and allocation identity. Every complete-record oracle passes. No compiler, test or second benchmark overlaps timing.

| Layout / case | Local prefix / original PA | Local key / original PA |
|---|---:|---:|

| f32 / uniform | 1.1800 | 0.7733 |
| f32 / sparse16 | 1.5633 | 1.5548 |
| f64 / uniform | 1.1756 | 0.7924 |
| f64 / sparse16 | 0.2928 | 0.3004 |
| f32_id16 / uniform | 1.1547 | 0.8680 |
| f32_id16 / sparse16 | 1.2712 | 1.3281 |
| f64_id32 / uniform | 1.1139 | 0.9351 |
| f64_id32 / sparse16 | 0.5669 | 0.5713 |

These are paired median ratios. Local prefix triggers six material original-PA signals; local key triggers two. The reversed four-slot 16-repetition repeats confirm all eight, with all 16 paired repetitions slower in each case:

| Method / layout / case | Median | p10 | p90 |
|---|---:|---:|---:|
| Pa_local_key / f32 / sparse16 | 1.5543 | 1.4163 | 1.6115 |
| Pa_local_key / f32_id16 / sparse16 | 1.3045 | 1.1119 | 1.5190 |
| Pa_local_prefix / f32 / sparse16 | 1.5374 | 1.4175 | 1.6339 |
| Pa_local_prefix / f32 / uniform | 1.1773 | 1.1060 | 1.2386 |
| Pa_local_prefix / f32_id16 / sparse16 | 1.3591 | 1.2394 | 1.5526 |
| Pa_local_prefix / f32_id16 / uniform | 1.1301 | 1.0360 | 1.2127 |
| Pa_local_prefix / f64 / uniform | 1.1522 | 1.0714 | 1.2506 |
| Pa_local_prefix / f64_id32 / uniform | 1.1046 | 1.0405 | 1.1401 |

Local key makes the four uniform cells faster than original PA in this small screen, including ratios 0.773 for f32 and 0.792 for f64. It still loses on sparse16 and is rejected as a general route. There is no full-matrix or ordinary-ISA claim for either method.

## Separate Work and resources

Two Work cells verify unchanged local-prefix logical geometry and expose the added physical cost. For f32 uniform, kernel/local-prefix both retain 187,722 leaves and 953,847 leaf records. Label evaluations grow from 4,476,754 to 6,573,903; scatter remains about 3,145,728; compact records grow from 1,949,184 to 2,090,496. Local key eliminates these leaves but scatters 4,194,301 records and compacts 3,139,071.

For f32_id16 sparse16, the kernel scatters 2,097,152 records and compacts 1,847,808. Both new routes keep the same scatter count but double label evaluations to 4,194,304 and compact 3,079,168 records, with 256 dense child completions. Exact high-byte boundaries avoid a scan to rediscover those child boundaries, but the added histogram and dense-copy work more than offsets that saving in actual timing. Work wall times are excluded from performance conclusions. `heap_peak` and `allocs` are zero in Work mode because allocation tracking is disabled there; they are not memory-use measurements.

The primary screen peaks at 197,812 KiB RSS. Confirmation peaks range from 41,776 to 116,228 KiB; Work peaks at 95,900–95,976 KiB. All processes report zero major faults and zero host swap-out. Host-wide swap-in increments are 80 pages in the primary screen, 0–1,574 pages per confirmation and 8 pages per Work command; these counters include unrelated processes. [local-rejected-integrity.json](local-rejected-integrity.json) records individual resources and raw/metadata/report hashes. Other machines remain unmeasured.

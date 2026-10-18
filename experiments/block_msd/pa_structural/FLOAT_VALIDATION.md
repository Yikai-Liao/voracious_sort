# f32/f64 performance and bit-preservation validation

Status: **rejected overall by a repeated native float regression**. The native finite and special-value matrices completed; a reversed confirmation repeated a material slowdown. Generic, fresh-seed holdout and the planned sparse Work matrix were stopped before execution. Their executables were built and frozen, but have no performance results in this cohort. Integer acceptance of this same source remains documented in [VALIDATION_INLINE_FINAL.md](VALIDATION_INLINE_FINAL.md); it does not override the float failure.

## Source and executables

The algorithm source remains `6fceaaa`, SHA-256 `eca6b3cf68617eaec8de46fadb300e38cdcdc836fdd29700c62338daa07b7636`. The extra harness is committed at `6712845`; it includes the existing integer runner for method dispatch, timing, allocation tracking, rotating/reversed slots and the complete-record oracle. It adds float input generation and bitwise record checks without modifying algorithm or existing runner source. Each executable additionally records and verifies hashes of the four harness Cargo/Rust files, the predeclared [FLOAT_PLAN.md](FLOAT_PLAN.md), float invocation scripts and `run.py`.

| Executable | Profile / features | RUSTFLAGS | SHA-256 |
|---|---|---|---|
| `float_native` | release / none | `-C target-cpu=native` | `58fd68daeefcbf91ba99f136a525489d969c419910be923126eb96427619058b` |
| `float_generic` | release / none | empty | `d2a4b43a29e243693d7442b2557b0934494a2d08db94f5d6e1a87c6786b892ed` |
| `float_work` | debug / `frontier_work` | `-C target-cpu=native` | `d5d940f909c9c931023a86173913bb294bd141a5eb1fb3b9f70978fccbdba148` |

Release profiles use 16 codegen units, line-table debug information and incremental enabled; Work disables incremental. All three builds and the six harness tests completed before timing. The new tests check finite numeric/converted-key order agreement and actual sorting of NaN/zero/infinity/subnormal record bits, identities, payloads and ties at B3/B64/B512. Four inherited runner tests also pass.

## Inputs and interpretation

Layouts are scalar f32 (4 bytes), scalar f64 (8), f32 plus identity/payload (16), and f64 plus identity/payload (32). Every finite warmup and timed result is checked against stable converted-key sorting outside timing. The finite cohort excludes zeros, NaNs and infinities, so the numeric order used by comparison paths agrees with converted-key order. Native cases are uniform, approximate normal from a sum of twelve uniform samples, broad finite binary exponents, 16 values, 90% repeated value, dispersed 8/16 mantissa bits at a fixed positive exponent, mixed-sign sparse mantissas, nonzero subnormals, sorted and reverse inputs. Generic screening uses uniform, skew90 and positive sparse8/sparse16.

NaNs, infinities, both signed zeros and unrestricted IEEE bit patterns are a separate cohort. Its oracle uses the repository's converted-key order and checks exact bits and stable record identity. Original PA, candidate and frozen Block LSD participate. Rollercoaster and Stable MSD are excluded because their partial-order paths do not establish this total-key contract. These observations do not extend the root library's public nonfinite-value guarantees.

Runs are serial on CPU 2 on the same shared KVM Xeon guest as integer validation. No build or test overlaps timing. Each cell reuses one allocation, restores frozen input outside timing, rotates/reverses slots, and repeats candidate/original PA for A/A. Median, p10 and p90 are descriptive paired-ratio quantiles. The same predeclared original-PA material threshold and independent confirmation rule apply; no admission threshold is tuned for float inputs.

The native finite matrix has 88 cells at n1,048,576, seed42, 14 repetitions and seven slots (8,624 rows). The generic finite screen has 32 cells at the same sizes/slots (3,136 rows). Each special-value target has 16 cells, 10 repetitions and five slots (800 rows). The fresh-seed native holdout has 16 cells at n262,144, seed20261022, 12 repetitions and six slots (1,152 rows), with B512 before B64. The separate Work scope has 12 cells/36 rows at n65,537, B64, sparse8/sparse16/signed_sparse8. Native and generic results are never pooled.

## Results and resources

Native finite results contain 88 cells and 8,624 rows. Native special-value results contain 16 cells and 800 rows. All completed timed processes returned zero, stderr is empty, and the independent audits verify the single-ELF cohort, rows, slot rotations and allocation identity. Full-record oracles pass; the rejection is a performance failure.

| Native finite reference | Candidate median wins | Candidate p90 wins | Candidate p10 losses |
|---|---:|---:|---:|
| Original PA | 61/88 | 19/88 | 1/88 |
| Original Rollercoaster | 32/88 | 23/88 | 46/88 |
| Frozen Block LSD | 70/88 | 63/88 | 9/88 |
| Stable MSD | 77/88 | 73/88 | 4/88 |

The B64 half has 30/44 median wins against original PA and 15/44 against Rollercoaster, with no original-PA median above 1.05. The B512 half contains the repeated failure below. These floats do not show the majority advantage against Rollercoaster seen in the original integer matrix. For B64 scalar f32 uniform, candidate / Rollercoaster is 1.627; for sparse8 it is 0.316. Ordinary dense mantissas and sparse mantissas must remain separate conclusions.

| f32_id16 / sparse16, n1,048,576, B512, seed42 | Candidate / original PA median | p10 | p90 | Slower reps | Candidate A/A median (p10–p90) |
|---|---:|---:|---:|---:|---:|
| Initial 14-repetition seven-slot matrix | 1.1995 | 1.0768 | 1.2362 | 14/14 | 1.0387 (0.8227–1.2752) |
| Independent reversed 16-repetition four-slot confirmation | 1.1634 | 1.0681 | 1.2187 | 16/16 | 1.0212 (0.9630–1.0850) |

The confirmation uses `[original PA, candidate, candidate, original PA]`, retaining the ordinary rotate/reverse schedule. The repeat crosses the predeclared material gate and is larger than its same-method A/A median variation. This source cannot be accepted overall. The following structural work must use new source/executable identities and keep this failure intact.

The separate special-value matrix has 3/16 median wins and 0/16 p90 wins against original PA, with no p10 losses or material signals. Against Block LSD it has 13/16 median and p90 wins and no p10 losses. No comparison to Rollercoaster or Stable MSD is made for that cohort.

Raw successful timing files use `float-native-finite-*`, `float-native-special-*` and `float-confirm-native-f32id16-sparse16-b512*`. Audits and summaries use matching separate prefixes. A subsequent diagnostic Work addition (`float-causal-*`) investigates ordinary-float overhead and the rejected sparse16 case; its wall times are not performance evidence. The predeclared generic, holdout and 12-cell Work scopes have no runs for this rejected source. Global swap counters cannot be attributed to the benchmark process. Other machines remain unmeasured.

## Causal diagnostics and resource limits

A separate instrumented executable checks six scalar dense-float cells and the rejected sparse16 record cell. Original PA and the candidate have identical reported Work and leaf geometry on all six dense cells and select no projection. For f32 uniform at B64, both produce 187,722 leaves containing 953,847 records, with 4,476,754 label records and 3,145,728 scatter records. This identifies substantial shared small-leaf and classification work; it does not attribute an exact fraction of elapsed time to that work.

On the rejected f32_id16 sparse16 cell, original PA scatters 3,145,728 records over three physical passes; packing scatters 2,097,152 over two. The packed source nevertheless loses in actual timing. Reduced scatter work alone is therefore insufficient evidence of an improvement.

The native finite processes peak at 381,996–382,064 KiB RSS; special values at 131,676–131,720 KiB; the independent confirmation at 64,532 KiB. All report zero major faults. Host-wide swap-in increments are respectively 1,066/1,716 pages, 88/17 pages and 1 page, with zero swap-out. These counters include unrelated processes. The diagnostic Work processes peak at 94,308/94,344 KiB and have no performance claims. [float-rejected-integrity.json](float-rejected-integrity.json) records the complete raw/metadata hashes and per-process resources.

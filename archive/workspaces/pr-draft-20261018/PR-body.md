This adds a stable, single-threaded block LSD radix sort for generic `Radixable` records. It provides a lower-auxiliary-memory alternative to full-buffer LSD sorting while preserving the input order of equal converted keys.

The implementation is adapted from Robert Clausecker's BSD-2-Clause [`radixsort_permuted.c`](https://github.com/clausecker/radsort/blob/f69e816c3cd79d312cd67aea5b9cf1c338c1b371/radixsort_permuted.c). The original copyright, license and reference revision are retained in the source.

### API and implementation

```rust
use voracious_radix_sort::block_lsd_stable_radixsort;

let mut values = [42u32, 7, 42, 0, u32::MAX];
block_lsd_stable_radixsort(&mut values, 8);
assert_eq!(values, [0, 7, 42, 42, u32::MAX]);
```

`radix` accepts 1–8 bits per digit; 8 is recommended. The public entry point automatically selects the block size from the input length, element size and bucket count. The manual-block implementation stays private. The new entry point uses the existing key-conversion contract and supports custom records without adding trait bounds.

- Block staging, permutation and compaction avoid requiring a full-input scatter buffer. For fixed radix and element size, auxiliary space is O(b + n/b); choosing b proportional to sqrt(n) gives O(sqrt(n)) auxiliary space.
- Constant digits are skipped. Small slices use stable comparison sorting, and ordered/reversed inputs have fast paths that preserve equal-key order.
- A conventional scatter path is used only when its complete requested heap fits the block scratch budget. Parameter and allocation-size checks precede the affected operations.

Existing sort dispatch and other algorithms are unchanged. No dependencies are added.

### Performance and auxiliary memory

The public wrapper uses a space-balanced square-root block policy with coefficient 4 and an approximately 1 KiB block floor. With `radix=8`, this is:

```text
b = max(1, ceil(4 * sqrt(9*n / (512*s))), floor(1024/s))
```

Here n is the number of elements and s is the element size in bytes. For other supported radices the denominator is `2 * 2^radix * s`. The coefficient was selected from measurements at radix 8, not proven universally optimal. The plots measure the unchanged sorting core at the selected parameters; they exclude the wrapper's block-size calculation.

The main comparison covers 1,048,576 elements, nine representations (`u32/u64/u128/i32/i64/f32/f64` and 32/128-byte records), and 23 distributions. Inputs include full-width random keys, skew/Zipf, low cardinality, sparse wide keys, shared prefixes, ordered and partially ordered patterns. The float performance inputs are finite; special floating-point values are checked separately for correctness.

Comparators include the library's LSD stable API, ordinary LSD, its pure core and counting heuristic, DLSD, Thiel, and the type-specific `lsd_u32`/`lsd_f32`, together with Driftsort (Rust 1.98.1 `slice::sort_by_key`) and gfx TimSort v3.0.1. [Rust documents its stable implementation as Driftsort](https://doc.rust-lang.org/std/primitive.slice.html#method.sort_by_key). `[U]` in the figures denotes an unstable interface or fallback; those timings provide performance context and do not imply equivalent stability guarantees.

For one larger example, sorting 16,777,216 uniform `u64` values:

| Implementation | Sort time (ms) | Peak extra heap (MiB) |
| --- | ---: | ---: |
| Block LSD, policy above | 659.21 | 3.204 |
| LSD stable | 1212.70 | 128.026 |
| Driftsort | 890.45 | 64.000 |
| TimSort | 2983.00 | 96.000 |

These are measurements on an Intel Xeon Gold 6140 KVM VPS, pinned to one CPU. Rust uses optimized native code with thin LTO; the C++ TimSort comparator uses GCC 14.2 with `-O3 -march=native`. Timings include allocation and deallocation inside the sort, excluding input preparation and output checks. Heap is peak live requested auxiliary allocation, excluding the input and allocator metadata; it is not RSS. Each method has three seeded forward/reverse measurement orders, with warmup. Small timing differences should not be treated as established gains.

Block LSD does not win on every input. In particular, organ-pipe and single-displacement inputs can favor run-adaptive sorts; the detailed plots retain these losses. TimSort also uses auxiliary merge storage, so the benefit here is reduced auxiliary memory rather than replacing an O(1)-space algorithm.

**Figure 1. Speed and auxiliary-memory tradeoff.** Panel a shows the large `u64` example above; whiskers are the observed timing/allocation ranges, not confidence intervals. Panel b counts lower/equal/higher heap use across the applicable 1M cases. Panel c is the empirical distribution of per-case time ratios: variation between input cases is not timing uncertainty. LSD stable has 205 comparable cases; Driftsort and TimSort have 207. Two reversed-record LSD stable outputs differ from the stable oracle and are excluded from same-semantics comparisons.

<!-- Upload figures/01b-efficiency-overview.png here. -->

**Figure 2. Comparison with the library's LSD variants.** Each panel fixes one type; each row fixes one of the 23 distributions. Points show comparator median time divided by Block median time, with values above 1 indicating faster Block sorting. The three comparators are ordinary LSD, the pure LSD core without Verge or counting heuristics, and LSD with its counting heuristic (`min_cs2=100000`). Unsupported record/heuristic combinations have no point. All supported cells are retained, including outputs that differ from the stable oracle under an unstable contract.

<!-- Upload figures/03-native-lsd-variants.png here. -->

**Figure 3. Comparison with DLSD, Thiel and dedicated radix kernels.** The axes, distributions and block policy match Figure 2. Thiel has no `u128` implementation; the dedicated kernel is available only for `u32` and `f32`. These comparators have unstable interfaces or fallbacks, marked `[U]`.

<!-- Upload figures/04-native-radix-variants.png here. -->

<details>
<summary>Per-type detail against LSD stable, Driftsort and TimSort</summary>

Each panel fixes one type, with all 23 distributions shown separately. Speedup is the reciprocal of the median of six paired Block/comparator time ratios. Values above 1 indicate faster Block sorting. There is no range aggregated across types and no confidence-interval claim. The two reversed-record LSD stable oracle failures are omitted.

<!-- Upload figures/01-algorithm-comparison.png here. -->

</details>

### Validation

`cargo test --release` and `cargo test --release --all-features` both pass. The latter includes 98 unit tests, 5 integration tests and 4 passing doctests (one pre-existing ignored example).

- The original manual-block coverage is retained as private-module tests (9 tests in the default configuration; 8 with `voracious_multithread`, where the local non-Send record test is intentionally excluded). Five integration tests cover the public adaptive API, including complete stable record output at multiple element sizes, all integer widths, floating-point bit patterns, zero-sized records and invalid radices.
- Coverage includes radices 1–8, block sizes and incomplete tails, repeated-key record stability, wide/common-prefix keys, primitive key conversions, zero-sized records, invalid parameters/extraction, and scratch payloads containing references and nonzero values.
- Benchmark Block outputs are checked against a complete stable converted-key oracle, including record IDs/payloads. Native-comparator plots also verify matching input seed/digests, key order and preservation fingerprints; differences from the stable oracle remain recorded.
- The benchmark, raw observations and plotting code are kept separately from the library changes.

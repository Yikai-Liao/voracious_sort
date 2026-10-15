# Stable block MSD with one block of tail slack per level

Current research prototype: **v2**. It implements dense partial streams plus boundary relocation so that each persistent stream has **exactly ceil(remaining elements / b) live blocks**, reducing tail slack from less than 2b to less than b per level. The old two-boundary-gap implementation, report and measurements are preserved under [v1/](v1/REPORT.md). `bench-100k.csv` and `bench-1m.csv` at this directory's root are also the original v1 data; **only `bench-v2-*.csv` describe the current implementation**. The v2 benchmark runs both algorithms in the same executable to compare versions.

This is an independent experimental Cargo project, with no production API or dispatcher changes. It advances the idea in [Clausecker / Schintke 2026 §7](https://arxiv.org/html/2607.05302v1). The author's fixed C repository revision is `f69e816c3cd79d312cd67aea5b9cf1c338c1b371`; its `paper/paper.tex` lines 916–934 propose dense partial data for MSD but do not implement it. The one-boundary packing mechanism here follows a concrete candidate supplied during our design review. These are design-level proofs and finite experiments, not an independently reviewed correctness theorem or a completed parallel algorithm.

## Model and interface

Single-threaded RAM model; n fixed-size Copy records, s bytes per record, W-bit converted radix key, r bits per digit (1..=8), σ=2^r, maximum digit depth d=ceil(W/r), block size b>0. Order is ascending `Radixable<K>::into_key_type()`; equal converted keys preserve input order. Existing `Radixable` and `RadixKey` traits, signed/float conversions and mask operations are reused. Custom extract must agree with converted-key digits and return a valid index. No new trait or Default bound.

`block_msd_stable_radixsort(arr,radix,block_size)` returns experimental Stats. `block_msd_stable_radixsort_body(...,leaf_limit)` allows 0..=32; default32 uses a bounded stable insertion leaf, pure0 forces all block recursion. The leaf compares converted keys, never PartialOrd. Stats and this leaf control are experimental interfaces, not proposed public production contracts.

## Shared arena and DFS

The input's floor(n/b) physical full blocks and **σ+d+4 scratch blocks** form a single fixed arena. Input trailing n mod b values are copied into a root stream and restored after finalization; the trailing input storage is never treated as a reusable full block. Each physical ID is uniquely owned by a live input/output block, a head, a stream or final output; a free ID contains no logically live values and can be reused. All cells are initialized; scratch Vec never resizes. During sorting, read/write require live IDs; finalization may write into dead but initialized storage.

A Bucket holds ordered full-block IDs and a tail length in the next segment of its parent's stream. At a branching node, sequential scatter uses one head per digit; full heads become the corresponding child's ordered full-block list. Input full blocks are released only after their last value is read. On scatter completion, the remaining partial heads are packed into one stream in bucket order, with tail lengths retained as child boundaries; heads are all released before recursion. DFS children consume their tail segments in increasing digit order.

Terminal output is appended to a global dense writer. At completion, one full-block permutation using an inverse map places these blocks physically in the input, swapping any destination that still holds future output. The last partial output restores the input tail. There is no n-record scatter buffer or compaction of every node to contiguous input slices.

## One-boundary stream representation

A Stream retains its original ID Vec, total length and consumed cursor, plus queue head index/offset and an optional relocated-head segment. Let its original final block hold an initial prefix of t values, where 1≤t≤b; t=b means no original trailing gap. Empty streams have no block or read operation. The final block's original `[0,t)` is always logically last and is never overwritten while live.

The remaining logical sequence is:

1. the optional relocated suffix in the final block;
2. the remaining ordinary full-block queue, starting at its head offset;
3. the original final-block prefix `[0,t)` (or its remaining suffix once reached).

`peek(ahead)` uses that sequence, not original cursor/b addressing. Key union/intersection scans therefore remain correct when physical and logical order differ. Child bucket boundaries may cut anywhere in a relocated segment or ordinary block; child boundaries do not reset stream state or ownership.

When an ordinary head block has consumed h values, its unused prefix has size h. The final block has gap g=b−t after any previous relocated suffix is exhausted. The first moment h+g≥b is **h=t**. If the head and final block differ and t<b, copy its remaining suffix `[t,b)` into the final block's currently empty `[t,b)`; release the head immediately; increment the ordinary queue index; and expose the copied suffix as the optional relocated head. It is logically read before the next ordinary block, while the original final prefix stays logically last. Consuming a relocated segment does **not** release the final block. The final block is released only after its original prefix is consumed at stream exhaustion.

Special cases: a one-block stream reads directly; t=b releases ordinary blocks at h=b with no relocation; a zero-length stream performs no read; there is no t=0 live final block because exact multiples of b use t=b. A relocation always uses distinct live blocks and disjoint source/destination allocations, and it ends before any caller can recurse or allocate.

## Stream packing proof

Initially q=ceil(length/b) blocks hold the stream and slack is b−t<b. With no active relocated segment and an ordinary head at offset h<t, slack is `(b−t)+h<b`. Reading one value either keeps h<t or first reaches h=t. In the latter case slack would equal b; moving the suffix and releasing the head immediately reduces allocated storage by exactly b and leaves slack zero.

Reading j values from a relocated suffix produces slack j; its length b−t<b, so slack stays below b. When the segment is exhausted, the final block again has gap b−t and the next ordinary head starts at offset0. The same argument repeats. With only the original final prefix left, allocated storage is b and remaining length is t−h>0, hence slack b−t+h<b; at exhaustion the block is released and slack becomes0. For t=b, ordinary head consumption has slack h<b and releases the block at h=b.

Therefore after **every completed read** the live stream blocks equal ceil(R/b), where R is the remaining element count. The relocation briefly duplicates at most b−t values within already allocated blocks; it allocates no block and releases its source before returning, so the allocator's capacity argument is unaffected. That transient duplicate is counted separately in work and transient values; it is not a persistent extra block per ancestor.

Each ordinary source block can be relocated at most once because the queue head index strictly increases. The relocated values are then read before any next relocation can overwrite them. The original final prefix is never relocated. Total relocation work per stream is at most its original length; repeated copying into the same final gap cannot create quadratic work.

## Stable sorting proof

The root's full list and tail reproduce original input order. Assuming a prefix bucket's full list plus parent tail segment is its stable sequence, sequential scatter produces each digit subsequence in stable order. Packing its partial heads preserves each tail subsequence, and logical stream reading restores the exact child full+tail sequence even after relocation. Thus the recursion invariant holds.

DFS digit order gives lexicographic converted-key order. Union/intersection skips only constant digit prefixes; equal converted keys remain together and retain original order at each scatter. The bounded insertion leaf moves only strictly greater keys. Final writer order is therefore stable sorted order; the final physical permutation changes storage only.

The stream proof establishes value preservation/order and exact persistent block count. The arena supply proof below uses this invariant. Neither substitutes for independent Rust raw-pointer alias analysis; Miri is not yet run.

## Complete auxiliary space

At most d nonempty ancestor tail streams coexist. They hold pending input values plus less than b slack each. Current σ scatter heads contribute at most σb slack; a current input full block can retain at most b already-consumed values until release (including the just-consumed final value before the loop releases its ID); the global final writer contributes less than b trailing slack. Tail packing can briefly duplicate one head prefix (<b) and has a fresh writer trailing gap (<b). The current original input tail cannot simultaneously add another unaccounted stream: it is consumed before root output tails are built. The physical arena is `floor(n/b)b + (σ+d+4)b` elements; its extra4 accounts conservatively for active input/final/packing windows and the missing n mod b capacity. Relocation adds no allocation inside these windows. Outside the arena, insertion has at most32 values plus O(1) scalar copies.

Thus exact allocated scratch payload is `s(σ+d+4)b` bytes, and total payload overhead is `O(s[σb+bd+32])`. This reaches one-block-per-level **persistent tail slack**, not one block for the whole sorter.

Full-block descriptors on the DFS frontier plus final output have total length O(n/b); during one scatter the input ID Vec/IntoIter can coexist with new output IDs, adding at most another O(n/b). That input allocation is dropped before descending. Parent IntoIter allocations retain σ Bucket objects and deferred siblings whose full IDs belong to the frontier, rather than a root-sized input Vec at every depth. Vec capacity growth changes constants, with minimum capacities charged to O(σd). Each layer also retains its dense stream's already-consumed ID entries until the stream Vec drops: at most σ IDs because its initial tails total less than σb. Explicitly count O(σd) for these IDs, tail lengths, Bucket objects and relocated segment/queue state. Global free/live arrays and final inverse cost O(n/b+σ+d); free capacity can temporarily grow past initial scratch size when leaf input blocks are released, by at most ceil(32/b), still within this bound. Stack adds O(d) frames.

**Complete byte bound:**

`M = O(s[σb + bd + 32] + w[n/b + σd])`.

For fixed s,σ,d, b=Θ(√n) gives O(√n) extra space. Fixed b retains O(n/b) metadata growth. Balancing the main terms suggests `b≈sqrt(κ*w*n / [s(σ+d+4)])`, with κ the descriptor-capacity constant. Metadata is not free, and this expression is not a measured speed optimum. The old v1 bound contains2bd and its exact scratch allocation uses σ+2d+4 blocks.

## Work and parameter policy

Union/intersection scans and scatter cost O(nd) record visits. Tail packing and relocation each move at most the node/stream input size, so both contribute O(nd). Final writer/permutation cost O(n). Fixed32 insertion costs O(32n). If N is the branching-node count, σ-way initialization costs O(σN); skipping constant prefixes ensures each internal node branches to at least two nonempty children and N≤n−1. Full work is `O(nd+σN+n)`; treating σ as variable requires keeping this term.

Use an explicit workspace model or budget rather than a measured type/workload table. With a conservative model `A*b+C/b+D`, A=s(σ+d+4), C=κwn and D accounting for depth bookkeeping/leaf buffer, a budget Q yields a feasible interval only when Q−D≥2√(AC). Its endpoints solve the quadratic. A cache constraint on current head working set σbs can further restrict that interval. This prototype has not turned the O-bound/κ into an exact certified allocator budget; that requires explicitly bounded/reserved descriptor capacities. Memory-minimizing b and fastest b remain different objectives.

## Verification and reproducibility

`run.sh` runs debug/release tests and same-process v2/v1/LSD/stable-MSD benchmarks. `run-asan.sh` runs the full suite under AddressSanitizer with RUSTC_BOOTSTRAP and `-Zsanitizer=address`. Default32 and pure0 block paths both use stable converted-key oracles, including tagged whole-record equality. Float tests separately compare converted keys so ±0 PartialEq cannot hide order errors. Tests cover radix/block boundaries, signed extrema, u128/i128/i64/u32, skew, binary words of length2..10, invalid radix/block0 and ZST.

New private stream test exhausts b=1..17 and length0..5b+5. Before each read it checks every remaining logical peek; after each read it checks exact live-block count ceil(R/b); it immediately allocates/reuses a freed head ID and overwrites all its cells. This attacks stale queue addressing, relocated/original final segments, repeated relocation and release timing. Sorting tests exercise nested streams with cross-bucket boundaries. All debug/release/ASan tests passed for v2 (one library test plus six integration tests).

Not tested: float NaN payload cases, custom extract panic/exception safety, extreme usize/allocator failures, Miri, independent proof review or parallel execution. Arithmetic beyond scratch checked_mul still requires production checked bounds. ASan cannot establish all Rust aliasing properties.

## Benchmark method

AMD Ryzen 7 8845H, Linux x86_64, rustc1.99.0 (b940084d7 2026-09-28), release default target, no native target-cpu, CPU0 affinity. Clone/generation/oracle/whole-record checks are outside timing. Three runs per configuration, median; an independent additional sort enables allocator tracking for requested-byte extra peak, including all ancestor buffers/Vec capacities, excluding input/reference/clone, allocator headers, stack and RSS. Timed runs disable counting but still have the allocation wrapper's light atomic flag branch. Order fixed v2→v1→block LSD→existing stable MSD. Measurements are local samples, not broad confidence intervals.

n=100k and1m; r=8, b16/64/256; u32, u128, u128-key32B record, u32-key128B record; uniform, 95%zero+5%random, and common-high-prefix with only low24 variable bits. For u32 the common-high64 prefix is truncated away, leaving a24bit active key. No result table is compiled into the library. V1 original CSV and report stay preserved; new CSV labels each algorithm version explicitly.

## V2 measurements and conclusion

All **288** new configuration results passed the whole-record stable oracle (144 for each scale). They compare the current one-gap v2 and preserved two-gap v1 in the same process; the original 216 results remain explicitly v1. The following table is n=1m, r=8, b=64; each cell is milliseconds / extra peak MiB.

|Type|Load|v2 one-gap MSD|v1 two-gap MSD|block LSD|Existing stable MSD|
|---|---|---:|---:|---:|---:|
|u32|uniform|36.22 / 0.341|38.02 / 0.342|8.78 / 0.275|11.24 / 3.846|
|u32|skew95|22.93 / 0.358|17.58 / 0.359|5.20 / 0.275|6.16 / 14.719|
|u32|shared_prefix|45.75 / 0.341|33.87 / 0.342|3.94 / 0.275|9.09 / 3.846|
|u128|uniform|48.75 / 0.547|42.64 / 0.562|104.83 / 0.650|16.15 / 15.337|
|u128|skew95|33.21 / 0.571|31.28 / 0.587|44.65 / 0.650|164.66 / 232.825|
|u128|shared_prefix|56.82 / 0.547|50.74 / 0.562|12.06 / 0.650|170.56 / 213.802|
|wide32|uniform|66.30 / 0.816|58.66 / 0.847|125.69 / 1.150|31.76 / 30.659|
|wide32|skew95|43.15 / 0.841|39.46 / 0.872|62.48 / 1.150|321.48 / 465.525|
|wide32|shared_prefix|59.95 / 0.816|66.54 / 0.847|23.97 / 1.150|362.63 / 427.487|
|large128|uniform|144.26 / 2.339|159.41 / 2.371|134.49 / 4.150|141.60 / 122.592|
|large128|skew95|82.79 / 2.356|73.92 / 2.387|66.12 / 4.150|297.03 / 470.029|
|large128|shared_prefix|156.79 / 2.339|147.56 / 2.371|95.08 / 4.150|140.20 / 122.586|

At b64, v2 saves 1,060 bytes for u32, 16,528 bytes for u128, 32,912 bytes for wide32, and 32,804 bytes for large128 against the simultaneously measured v1. These values equal **d*b*s + 9d** in these samples: d fewer scratch blocks plus the final inverse/live table differences. That exact measured relationship is not asserted across Vec-capacity transitions. Stream state grew on the stack, excluded from requested heap measurements but included in the O(d) stack analysis. With σ=256 the head-start scratch dominates d=4/16, so the byte improvement is modest; lower radix/deeper recursion can make the theoretical relative saving larger, but is not performance-benchmarked here.

The new v2 relocates about 0.49–0.51m records for the uniform n1m/b64 streams, versus about24k on skew95. This extra data movement and logical-peek state have real cost: wide32 uniform takes66.30ms versus58.66ms for v1; wide32 skew95 takes43.15ms versus39.46ms. Some samples reverse this relationship (e.g. large128 uniform), so the three-run local medians do not establish a universal slowdown or speedup. **The one-block bound improves capacity guarantees; it does not guarantee improved speed.**

Against the existing MSD, wide32 skew95 still reduces approximately465.525MiB to0.841MiB and321.48ms to43.15ms in this run. Against block LSD, wide32 uniform takes66.30ms versus125.69ms, while u32 uniform takes36.22ms versus8.78ms. These results again show that u32 cannot characterize generic record/key performance, and that the MSD prototype has no universal advantage.

## Remaining work

The specific per-level persistent tail packing question now has an implemented algorithm, a design proof and direct adversarial validation; it is no longer an untried suggestion. It still requires independent proof and raw-pointer review. Parallel block MSD, span/ownership synchronization, exact production workspace budgets, allocation failure/overflow contracts and broad performance optimization remain open. The current experimental Stats-returning APIs and extra source module for side-by-side benchmark should stay outside production src/. This research should not expand the stable block LSD PR without a separate design and review.

# Block MSD research — complete count-first dense-node experiment

**The all-scenario objective—independently make block MSD competitive with ordinary MSD—has not been achieved.** This archived research remains experimental, outside production src/, dispatcher and public API. No C+E or parallel implementation has been added. [README.md](README.md) maps the preserved sources to their datasets and provides build and replay instructions.

The benchmark primary is now the complete **count-first** backend in `src/count_first.rs`, with the preserved bounded v5 backend as a direct comparison. It applies dense scatter to arbitrary node size, uses shared boundary blocks and lazily allocated private interior heads, and uses a global intrusive block directory instead of per-frame m/b ID vectors. Its full construction, ownership and space argument are in [COUNT_FIRST.md](COUNT_FIRST.md). V1–v5 source/data are preserved under version directories. Source/data must not be mixed: the first complete-backend performance data are `bench-count-first-N.csv`; these correspond to the preserved `count_first_v1/` source, not future edits. In particular, `bench-v2-*.csv` describe v2, `bench-v3-*.csv` describe v3 and `bench-v4-*.csv` describe v4, not current code. Detailed v2 one-gap proof and simultaneous v1/v2 performance results remain in [v2/REPORT.md](v2/REPORT.md).

The measurements in this report describe the archived full-scan implementation.
The later [scan experiment](scan_experiment/REPORT.md) preserves that exact source
and records the isolated early-termination change and corrected stable baseline
separately. Historical timing claims below are not assigned to the changed code.

## New backend validation and scope

The preserved first complete backend passes the full stable identity oracle on ordinary/pure paths, including arbitrary nodes larger than σb, all 256 staggered bucket ends and simultaneously partial private heads, and a continuing left branch with deferred siblings across 128 key-bit depths. The pure-path test setup was corrected to actually scatter unsorted inputs; previously reversing an already sorted result mostly exercised descending preflight. Other coverage includes tagged restricted-value records, signed extrema, converted-key floats, radix/block boundaries, skew, seed sweeps and a changing safe extractor.

For the preserved first backend, debug and release each pass one library plus nine integration tests; AddressSanitizer also passes one library plus nine integration tests (`test-count-first-{debug,release,asan}.txt`). The complete backend uses `K=min(2σ,ceil(n/b))+2d+8` scratch blocks, plus bounded leaf storage and all global/depth metadata. It does not claim the previous σb budget or a new C+E/parallel result. The first complete-backend geometry has now finished and is reported below. Its all-scenario speed objective remains open.

The following v5 descriptions and measurements are historical context; their space arguments and performance claims do not transfer automatically to count-first.

## What changed and what is proved

The generic prototype uses the repository's existing `Radixable<K>` and `RadixKey`, converted-key ordering and stable equal-key identity. No new public trait, Default requirement, type-specific threshold or measured workload table. The experimental functions return diagnostics; that signature is not proposed as production API.

Shared full-block arena, DFS stable digit partitioning and per-parent dense streams remain the foundation. Each Bucket has ordered full IDs plus an arbitrary-length contiguous segment of its parent's logical stream. Arbitrary segment length is needed by the bounded whole-node scatter added in v3; it does not reset stream cursor or ownership. Final output is still a **single dense writer**, followed by one physical block permutation. It does not yet retain terminal full blocks separately as C+E.

V2's one-gap stream folds an ordinary head suffix into the original final block's unused `[t,b)` region when h=t, keeping that final block's original `[0,t)` logically last. It has exactly ceil(remaining/b) live blocks after a read/consume completes. V5 exposes logical spans and consumes whole valid ordinary blocks when possible, avoiding needless folding while preserving the same packing invariant. A relocation only duplicates a suffix transiently inside existing blocks; each ordinary source suffix moves at most once per stream.

`simple_stream` disables folding/alias roles, consumes ordinary queue blocks directly, and permits less than2b head+tail slack per paused level. It uses `(σ+2d+4)b` arena scratch rather than one-gap `(σ+d+4)b`. This is a deliberate capacity/complexity tradeoff, not a claim that one-gap is impossible. The upload's §13 explicitly recommends measuring whether the saved boundary block justifies the state complexity.

The bounded dense scatter route is admitted only if `node size<=σ*b` **and** `ceil(size/b)<=arena.free.len()`. It allocates the entire output from the existing arena, counts a histogram, scatters stably to bucket prefix positions, then makes that output one dense stream. Its per-frame output ID directory has at most σ entries, so it retains O(σd) depth metadata, not a new d*n/b or d² term. The σb active-output payload budget already covers this route. It is not the unbounded shared-boundary whole-node candidate in upload §16, which requires a different ~2σ head/boundary argument.

V5's dense cursor checks each write's global position<node size and validates all final bucket positions against histogram ends before permitting typed output reads. A safe custom extractor changing buckets between count and scatter therefore panics instead of accessing a null/uninitialized cursor. Buckets produced by the ordinary head path remain bounds-checked before writing.

## V4/V5 engineering changes

- Scratch is `Vec<MaybeUninit<T>>`, avoiding dummy-record initialization of unused head/slack capacity. Typed reads occur only on proven initialized prefixes; final swaps use MaybeUninit<T>, and raw copies preserve padding initialization state. No invalid T slice is formed for scratch padding.
- The universal bounded leaf limit is128, matching the repository's existing MSD fallback threshold. Root arrays≤128 use stable converted-key sorting before arena allocation. Packed leaves gather into a separate no-inline128T stack frame, so ancestor frames do not each reserve128T. Unused stack cells are MaybeUninit.
- Writer tracks its current fill rather than dividing/modding its length per record. V5 extends/reads contiguous spans in bulk, replaces full-record scatter temporaries with raw record copies, and uses binary insertion plus one overlapping memmove per leaf insertion. These improve implementation cost; they do not erase mathematical data movement.
- Exact ascending/descending detection uses converted keys. Descending normalization reverses equal-key groups as well as the whole array, preserving identity. Random inputs exit the preflight after conflicting directions; there is no workload-classification lookup.
- `terminal_fusion` applies only when a dense-scatter node's actual child counts all fit the128 leaf limit. It gathers/sorts/writes each child interval back into the same output stream without consuming/freeing its shared blocks, then transfers the whole node in bulk. It currently still transfers to the original dense result writer. Full-block C+E retention and a different evacuation finalizer are **not** implemented or counted as benefits.

## Complete space and work accounting

Let n be records, s record bytes, r digit bits1..=8, σ=2^r, d=ceil(converted-key bits/r), b records/block and w bytes/machine word. Fixed-width key extraction/operations are assumed constant-cost and allocation-free; arbitrary user callback work is outside these bounds.

One-gap complete overhead remains:

`O(s[σb+bd+128] + w[n/b+σd]) bytes`.

Simple-stream overhead replaces bd by2bd in the payload constant:

`O(s[σb+2bd+128] + w[n/b+σd]) bytes`.

Exact arena scratch allocations are respectively `(σ+d+4)b` and `(σ+2d+4)b` MaybeUninit slots. Include current source/packing duplicate windows, final writer's partial block and alignment slack; a bulk source batch can retain up to one block of copied-but-not-yet-consumed values. The128T leaf frame and one scalar insertion temporary are additional bounded storage. Root small stable-sort implementation scratch is bounded by the fixed128 limit rather than unbounded nT.

Metadata includes free/live, full ID directories, input IntoIter capacity retained until its scatter ends, deferred siblings, Bucket/count/cursor allocations, already-consumed stream IDs retained until Vec drop, final writer IDs and final inverse. Frontier full IDs and current duplicated input directory total O(n/b); parent Bucket/count/stream allocations cost O(σd). A dense path's cursor Vec is dropped before child recursion. Vec minimum capacity and doubling count toward constants, not zero. The stack has O(d) frames plus the separate128T leaf frame. Fixed b leaves n/b metadata growth; b=Θ(√n) yields square-root overhead only with σ,d,s fixed.

Digit scans/scatter cost O(nd); node setup O(σN) where N branching nodes≤n−1 after constant-prefix skipping; packing/relocation at most O(nd); leaf comparison/memmove cost is bounded by the fixed128 limit, and final dense writer/permutation O(n) record work. Stable leaf binary search reduces comparison count but total moved records can still be quadratic in leaf length, bounded by128 here. Small-node extra histogram, leaf gathering, writer copies and tail movement still require payment; fewer radix levels are not a speed theorem.

Production checked arithmetic/exception contracts, independent raw-pointer proof and Miri remain unfinished. No parallel root/worker/batch-finalizer implementation or exact certified workspace budget.

## Correctness and uploaded reference evidence

Current tests cover default/pure paths, stable tagged identities, signed extrema and i128/u128, skew, all binary key words length2..10, varied radix/block sizes, floats including converted-key ±0, invalid parameters and ZST. Added NonZeroU32, nonzero-discriminant enum and reference payload tests target MaybeUninit errors; descending duplicate groups target stability; a changing safe extractor targets scatter initialization safety. Direct stream tests exhaust b1..17/length0..5b+5, every logical peek, block occupancy, immediate freed-ID reuse and overwrite.

Before the final cached ordered-scan edit, v5 default and simple+fusion debug configurations passed one unit plus eight integration tests. Four-configuration(onegap/simple × fused/unfused) release and AddressSanitizer reruns completed successfully, each with one unit and eight integration tests; logs are `test-v5-*-{release,asan}.txt`. **No v5 speed acceptance claim.**

Uploaded math/model comparison and independently rerun results are documented in [reference_model/COMPARISON.md](reference_model/COMPARISON.md). The relevant Python source was inspected before execution. Endpoint normalization:72,285 cases passed; edge checks:base/retained/normalized320 each, with overlapping inputs; two intentionally broken batch protocols reproduced predicted corruption. These are finite abstract state checks, not native performance, low-space Python implementations or real concurrent execution. Other uploaded large model totals are supplied historical records, not claimed reruns.

## Existing baseline stability failure

[BASELINE_STABILITY.md](BASELINE_STABILITY.md) and `baseline_probe` isolate a129-record failure: key=(129-i)/2 and ordinal=i, Eq/Ord both by key. Existing `msd_stable_radixsort` reverses equal-key ordinals. Repository Verge preprocessing alone produces sorted keys but wrong identities with separators `[0,129]`; an independent conventional MSD body without Verge passes the full oracle. The cause is non-strict descending exploration followed by plain reverse. No production fix is mixed into this experiment.

The harness now labels failed existing-MSD rows `unstable_baseline` and their mismatch index; those times do not qualify as stable-sort speedups. Experimental or block-LSD identity failure still aborts. `bench-v4-262144.csv` predates that status support and is incomplete: it stopped on large128 descending after v4/v3/LSD passed. No v4-1048576 dataset was produced in that run.

## Performance evidence so far

V3 added bounded dense scatter and removed small leaf heap allocation, improving v2, but did not meet the requested across-scale closeness. V4's MaybeUninit/128 leaf further helped, but geometric uniform samples still show roughly2–3x or larger gaps to the existing stable MSD on some small/middle u32/u128 cases. Examples at b64: v4 u32 n1024 0.0179ms versus0.0056ms; n16384 0.462ms versus0.153ms. There are favorable wide-payload samples, but no all-scenario superiority claim.

Geometric v4 completed16/64/256/1024/4096/16384/65536 across six loads and four types;262144 is partial as above. Earlier v3 and v2 datasets reach1m and are version-specific. V5 one-gap is now timed as a comparison in the complete count-first matrices below; independent simple/fusion geometry was not completed. Old version data are not proof for later code.

V4 timing used CPU0, clone/oracle/generation outside timing, median5 at small scales and3 larger, with independent requested-heap peak runs. Loads include uniform,95%zero+5%random,shared high prefix,actual per-type sorted/descending and one swap per100 positions. For truncated u32, load preparation sorts its actual key before constructing sorted scenarios. Timing excludes allocator counts but retains the wrapper's light flag branch; heap excludes input/reference/clone, allocator headers, stack and RSS. `v4-source-hashes.txt` and `v4-lsd-baseline.rs` preserve the contemporaneous root LSD reference; subsequent root LSD work is not retroactively reflected in these numbers.


## Complete count-first first native results

The first complete-backend geometry finished all nine sizes16/64/256/1024/4096/16384/65536/262144/1048576, five types and six loads, with all five algorithm rows per case:1,350 rows/270 cases. Every count-first and v5 result passed full identity checks. Two existing stable-MSD rows failed equal-key identity and are marked `unstable_baseline`; they are excluded from qualified stable ratios. `comparison-count-first.csv` contains per-case ratios and requested-heap peaks. `count_first_v1/` preserves the exact experimental sources and tests. `count-first-lsd-baseline.rs` and `count-first-source-hashes.txt` record the linked root LSD and binary provenance. CPU0 was exclusive among these experiments; median5 at≤65536 and3 above; b64 throughout. Inputs/oracles/clones are outside timers and the allocation run is separate.

The complete route is correct under these checks but not yet close to ordinary MSD across scenarios. At n1024 uniform, u32/u64 ratios to ordinary MSD are3.51/3.43. At n16384, uniform ratios are u32=3.79,u64=2.45,u128=1.89,wide32=1.91,large128=1.19. At n1048576 they are2.52,2.41,1.55,1.09,0.70 respectively. Wide payload and95%equal-key cases can be favorable, but they do not erase the primitive gaps. Current generic leaf gathering/binary-insertion and per-node bucket-directory setup are the next measured targets.

At n1024 large128, the dynamic min allocation gives287,664 extra requested-heap bytes versus2,175,576 for v5. At n1048576 large128, the new2σ budget gives4,748,176 bytes versus2,475,336 v5 and134,781,080 ordinary MSD. Count-first takes101.35ms versus100.51ms v5 and144.78ms ordinary MSD in that case. This trades a modest sublinear workspace constant for avoiding full record buffers; it is not universally faster than v5. All allocator peaks exclude stack, allocator headers and RSS; the128T leaf frame is explicitly additional. No general throughput acceptance claim has been made.


## Endpoint and leaf ablations

The next complete backend splits16-byte hot cursor state from cold per-bucket segment plans. Exact prefix/suffix ends and lazy full-block plans replace per-record remaining counters. Every source span is read then consumed in a batch; each record only performs its checked digit lookup, segment-end check, raw copy and cursor increment. Segment exhaustion and final whole-node checks still protect safe changing extractors. `endpoint_v1/` preserves the source. Four independent variants(base, direct-span leaf, standard stable leaf, both) each pass debug/release/AddressSanitizer, one library plus eleven integration tests. New cases cover a three-record shared-boundary interval overrun and full NaN-bit/ordinal converted-key stability.

Four scales1024/16384/262144/1048576 across five types and four nonsorted loads produced320 correctly verified primary-only ablation cases (`ablation-endpoint-*-N.csv`). At n16384 uniform u32, changing gathered binary insertion to standard stable leaf sort reduced345.5µs to137.1µs within that round; at n1048576 it reduced24.66ms to17.84ms. Direct-span sorting is not a universal improvement: combining it with std sorting helps1m u32 in that round but regresses16k wide32/large128. No payload-specific branch or lookup was chosen from these observations.

The std-only candidate then completed270 cases/1,350 rows over the full nine-scale matrix (`bench-endpoint-std-N.csv`, `comparison-endpoint-std.csv`), using a fixed copy of the validated root LSD `ordered.rs` and its utilities under `src/frozen_lsd/`; later production-source edits cannot change this baseline. All experimental identity checks passed. At n1048576 uniform, ratios to ordinary MSD are u32=2.73,u64=1.23,u128=1.13,wide32=1.03,large128=0.85. Primitive small scales and u32 remain clear gaps. The primary-only and full-matrix u32 timings also vary materially(17.8ms versus23.9ms), so improvements are not accepted from one favorable sample. Requested heap remains essentially the first complete backend's payload/global-directory bound. The focused native profile below was completed. C+E retention was not implemented.


## Final focused diagnosis and closure

[PHASE_DIAGNOSIS.md](PHASE_DIAGNOSIS.md) records the completed u32 uniform diagnosis, its raw files and its limits. A normal, uninstrumented std-leaf binary ran 100 verified repetitions per algorithm at n16384/262144/1048576. Median count-first versus ordinary MSD times were 175.46/86.96µs, 5.842/2.412ms and 18.372/11.326ms (ratios 2.02/2.42/1.62). These focused observations do not supersede the full matrix or establish cross-scenario parity.

The phase probe confirms that both algorithms branch at the same two digit levels for the larger cases and process equal scatter/histogram record totals. Count-first pays a repeated prefix scan, shared boundary/directory setup, gather/write stream handling and final permutation; ordinary MSD pays full record-buffer clones. At n1m, phase observations show roughly equal leaf-sort cost (7.80 versus7.38ms) while scan/setup/scatter and stream/finalization work account for additional count-first time. There is no measured single remaining leaf tweak that closes the gap. C+E could remove terminal copying, but was not built and has no validated speed claim.

Phase timers are intrusive: an empty timer costs about20ns and a two-level tree can contain65,536 leaves. The saved phase lines are the final verified iteration, whereas the headline sort time is the median of20; their sum is neither the median nor an exact partition of total time. The uninstrumented100-repeat comparisons are the qualified focused timing evidence. Sampling profiles also cover only this u32 uniform fixture. No cache-miss or instruction counter evidence was collected to attribute all extra cost to physical fragmentation.

All experimental work remains under this directory. The validated endpoint algorithm is preserved in `endpoint_v1/`; base/span/std/span+std each passed debug/release/ASan (1 library +11 integration tests). Later `cf_phases` adds an optional diagnostic path; it compiled and all six20-repeat focused runs passed their oracle, but that instrumentation was not given the full sanitizer matrix. The intermediate compact draft was not compiled or timed. No background block-MSD process remains. This round ends with correct native prototypes, finite model evidence and a measured performance gap; Miri/full unsafe proof, production integration, parallel/batch evacuation and all-scenario throughput acceptance remain unfinished.

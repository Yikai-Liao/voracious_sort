# Block MSD research — v5 stage checkpoint

**Active objective: independently make block MSD competitive with ordinary MSD across scenarios; the user clarified that LSD-first milestones do not pause this MSD research.** This project remains experimental, outside production src/, dispatcher and public API. No C+E or parallel implementation has been added.

Current source is **v5**, with independently selectable `simple_stream` and `terminal_fusion` experiments. V1–v4 source/data are preserved under version directories. Source/data must not be mixed: v5 has not yet been performance-benchmarked. In particular, `bench-v2-*.csv` describe v2, `bench-v3-*.csv` describe v3 and `bench-v4-*.csv` describe v4, not current code. Detailed v2 one-gap proof and simultaneous v1/v2 performance results remain in [v2/REPORT.md](v2/REPORT.md).

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

Geometric v4 completed16/64/256/1024/4096/16384/65536 across six loads and four types;262144 is partial as above. Earlier v3 and v2 datasets reach1m and are version-specific. V5 bulk/simple/fusion have **not** been timed. Further v5 geometric experiments are active after the user clarified the independent MSD milestone; old data are not proof for current code.

V4 timing used CPU0, clone/oracle/generation outside timing, median5 at small scales and3 larger, with independent requested-heap peak runs. Loads include uniform,95%zero+5%random,shared high prefix,actual per-type sorted/descending and one swap per100 positions. For truncated u32, load preparation sorts its actual key before constructing sorted scenarios. Timing excludes allocator counts but retains the wrapper's light flag branch; heap excludes input/reference/clone, allocator headers, stack and RSS. `v4-source-hashes.txt` and `v4-lsd-baseline.rs` preserve the contemporaneous root LSD reference; subsequent root LSD work is not retroactively reflected in these numbers.

# Complete count-first dense-node experiment

`src/count_first.rs` is a separate, generic, stable MSD backend implementing the uploaded proof's §16 route for arbitrary node size. It does not require `m<=σb`, allocate all `ceil(m/b)` output blocks in advance, or return to the old tail-packing path when a node is large. It uses existing Radixable/RadixKey contracts and converted-key order. V5 remains preserved as the benchmark comparison.

Each branching node counts its current digit and knows every bucket interval in the dense logical output. Every nonaligned bucket end reserves its physical boundary block; adjacent small buckets share a boundary when their intervals intersect the same logical block. There are at most σ such blocks, including the node's final partial block. A bucket writes its prefix/suffix into those reservations. Its complete interior blocks are allocated lazily, at the first record written to each block. A full interior block becomes sealed; no empty successor is allocated. Stable input scan order therefore becomes stable order within every bucket.

When scatter finishes, all input records of the node have been consumed and every bucket remaining count is checked to be zero. Bucket chains are linked in digit order, shared boundaries are deduplicated, and the resulting stream has exactly ceil(m/b) blocks. Every block except its final block is fully initialized. There is no subsequent tail pack. Children consume prefixes of this stream in DFS order.

## Directory and ownership

The physical arena overlays complete input blocks and allocates scratch in MaybeUninit slots. One global `next[physical_block_id]` table holds all chain links. A stream retains only head/tail IDs, head offset, final-block length and remaining length. A parent's stream is not copied into a new m/b ID array when a child runs. When its head is consumed, the successor link is cached before the old physical block is released and may be reused. No live input block may be allocated as output. The allocator asserts live/free ownership at every allocation/release in release builds too.

Current-node bucket/boundary cursor arrays are dropped before entering children. Ancestors retain their counts and constant-size stream state, with O(σd) metadata over the whole stack. Global next/free/live storage, one final writer's block IDs and one final permutation inverse use O(n/b+σ+d) words. Directory capacity and retained Vec capacities are counted; an empty Vec's implementation minimum capacity does not become zero cost.

## Payload bound

Let n be record count, s record bytes, σ=2^r for r in 1..=8, d=ceil(converted-key bits/r), b records per block and w machine-word bytes. Fixed-width key operations are assumed constant-time and allocation-free. The allocated scratch block count is

`K = min(2σ, ceil(n/b)) + 2d + 8`.

During active scatter, B shared boundary blocks and H current partial private interior heads account for its output holes. B<=σ and H<=σ. These blocks are distinct logical output blocks, so B+H<=ceil(m/b)<=ceil(n/b). Full sealed interior blocks are charged to their written records. Thus active holes need at most min(2σ,ceil(n/b))*b slots.

Every paused dense stream has at most one partial head and one partial tail, with fewer than 2b holes. There are at most d paused levels, and one active source stream; skipped constant digits do not add branching frames. The final dense writer has fewer than b holes. The scatter/copy loop retains a source span of at most b copied but not yet consumed records; its source block is released only after that span is copied. Rounding total n records from floor(n/b) input arena blocks to ceil(n/b) may cost one extra block. Counting these separately gives the conservative scratch margin `2d+8`; it covers the active source's two endpoints, final writer endpoint, one source batch, rounding and unused constants. Leaf gathering frees consumed input records into a separate fixed 128T stack frame; this frame and an insertion temporary are additional bounded storage.

The complete asymptotic overhead is therefore

`O(s[(2σ+2d+8)b+128] + w[n/b+σd]) bytes`.

The dynamic min only reduces allocation. The 2σ payload coefficient is essential: this route is not justified by the previous σb budget. Fixed b still gives n/b metadata. A square-root overhead specialization requires b=Θ(√n) with σ,d,s fixed; there is no universally sublinear byte claim when key width or record size grows.

## Work and implementation limits

Constant-prefix OR/AND scan, histogram scan and stable scatter take O(m) work at each branching level. Setup is O(σ) per branching node, giving O(nd+σN) work where N is the number of branching nodes. Generic record copies pay their size. The fixed 128 leaf insertion limit bounds local comparison/move cost; ordinary binary insertion can still move quadratically many records within that fixed limit. Final dense writer transfer and permutation add O(n) record work. The theoretical route currently still has a final dense writer and does not retain terminal full blocks as the independent C+E route.

Release assertions reject a changed safe extractor's histogram/scatter counts before typed reads of its output. Input/source queues and shared boundary ownership are single threaded. This is not a parallel or batch-evacuation implementation. AddressSanitizer and identity checks test the native implementation, but do not replace a complete raw-pointer proof or Miri.


## Endpoint cursor and leaf ablations

The next native iteration keeps the same arbitrary-node route and space argument, but separates a hot16-byte Cursor(next,end) array from cold bucket plans/chains. Setup places the prefix cursor at its real initialized output subinterval and records pending full interior blocks and the suffix length. Rollover consumes one complete-block plan or the suffix plan; once both plans are exhausted, any further write panics. The hot record loop only checks next==end, copies the record and increments next; there is no per-record remaining-count update or Stream ownership action. Final cursor==end and exhausted-plan assertions precede every typed child read. Empty buckets and short shared-boundary subintervals use the same check.

The intermediate remaining-count compact draft is preserved under `count_first_compact_draft/` but was not compiled or timed. It would have kept a per-record remaining decrement; endpoint plans eliminate that update altogether. Endpoint base/span/std/span+std each pass debug, release and AddressSanitizer: one library test plus eleven integration tests per configuration. Added tests cover overrunning a short shared-boundary subinterval and stable NaN-bit/ordinal converted-key sorting. Sources are preserved under `endpoint_v1/`; they have separate data from count-first v1.

`cf_span_leaf` sorts a leaf directly in its current initialized physical span when the complete child fits that span. It then transfers/consumes that span in bulk, retaining the existing ownership protocol. A fragmented leaf retains the bounded gather path. `cf_std_leaf` separately replaces bounded binary insertion with standard stable converted-key sorting for both gathered and direct spans. These are independent ablations; they are not payload-type/workload classifiers. Standard stable leaf sorting may use bounded implementation scratch, and it must be counted in measured heap/stack constants. The default remains binary insertion for this comparison. The std-only variant has completed its full nine-scale/five-type/six-load matrix; performance remains under the stated all-scenario objective.


The terminal cursor proof uses a simple interval decomposition. A nonaligned prefix contributes min(count,b-start%b) slots; complete interior blocks lie strictly between that prefix and the possible suffix; a suffix already covered by the prefix contributes no second segment. These capacities sum to the histogram count. Each segment cursor stops at its actual interval end, not merely the physical block end. An excessive safe extractor call exhausts all segment plans and panics before writing; missing writes leave next<end or a nonzero pending plan, and validation rejects the node before any typed child read. The hot/cold split changes metadata constants, not the payload accounting.

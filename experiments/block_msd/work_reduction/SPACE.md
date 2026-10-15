# Space contract and lifetime audit

The baseline is `749ca4d`. The first-stage candidates retain the frozen 256 KiB `cache_fits` decision. That number is a **local cache working-set heuristic**, including input records. It is not a whole-sort auxiliary heap limit.

The native driver measures successful allocation/reallocation calls, the sum of requested allocation sizes (a reallocation contributes its new requested size), and peak simultaneously live requested heap bytes during the sort. Input, reference, reset and identity-oracle storage are outside this scope. Stack frames, allocator headers, allocator rounding and RSS are not counted. Diagnostic-build heap includes profiling objects and is not substituted for the native measurements.

## Contiguous subtree

Let `M` be the cache-entry length, `e = size_of::<T>()`, `u = size_of::<usize>()`, and `H` the bytes in ancestor histogram backing allocations still live outside this cache entry. Let `s_i` be each active cached histogram's actual capacity in slots. There is one `M e` record scratch allocation for the entire cached subtree.

In the three-array kernel, an active scatter at level `j` holds:

```
H + M e + u sum(i <= j, s_i) + 2 u s_j
```

The sum accounts for ancestor counts and current counts; the other two current arrays are heads and ends. Heads and ends are dropped before child traversal. Consuming counts into `Vec::IntoIter` retains its backing allocation while children are visited.

In the two-array kernel, counts becomes cumulative ends in place. The same stage holds:

```
H + M e + u sum(i <= j, s_i) + u s_j
```

The current heads is the only additional array. Its capacity equals that of its three-array counterpart. Recursion reconstructs each child length from successive cumulative ends. The arrays have the same retirement points as the control: this is a lifetime comparison, not a comparison between two loose upper bounds. It removes exactly one allocation per actual cached scatter node, without changing the digit tree, histogram attempts, leaf intervals or payload scratch.

A leaf stage holds:

```
H + M e + u sum(active ancestors, s_i) + W_leaf_heap
```

Do not add mutually exclusive scatter and leaf stages together. For fixed full-width rows of `s` slots, the three-array scatter envelope is `(d+2)s u`; the two-array envelope is `(d+1)s u`. Partial rows can make the exact maximum occur before the deepest level. These envelopes omit `H`, payload scratch and leaf workspace until those terms are added explicitly.

## Standard-library leaves in the measured toolchain

The installed Rust source was inspected along with `rustc -vV`; its hashes are recorded in `stdlib-source-sha256.txt`. These are implementation facts for this toolchain, not a stable Rust API guarantee.

For the measured 64-bit build, zero-sized values and lengths below two return immediately, and lengths at most 20 use insertion sort. The other stable-sort path declares a 4096-byte, `T`-aligned stack scratch buffer. Its scratch length in records is `floor(4096/e)`. The requested record capacity is:

```
max(ceil(l/2), min(l, floor(8_000_000/e)), 48)
```

If this fits the stack scratch, no scratch heap is requested. Otherwise the stable sort allocates that capacity on the heap. For `21 <= l <= 128`, this is at most 128 records. Thus `128 e` bounds this library-owned leaf scratch request in the measured implementation. For the five benchmark layouts, leaves of width at most 32 bytes fit the stack scratch through length 128. A 128-byte record can require heap scratch; this must be included in actual heap measurements.

The 4096-byte buffer is not a measurement or bound for the complete call stack. Sorting frames, alignment padding, recursive MSD frames and leaf internals have their own stack costs. No whole-stack or RSS limit is claimed.

## Block materialization and cyclic placement

At each node, all block workspaces are destroyed before child recursion. Histograms retained by the caller remain live. The cycle candidate uses the same arena, scratch reservation, output block vector and inverse vector as the control; it allocates no payload buffer, visited table or cycle vector.

The final valid tail is copied into the original array's tail before full-block placement. Its source owner is removed, exposing a hole when appropriate. Draining paths leaves no live complete scratch source; one already allocated scratch block can then temporarily hold a full cycle block. Only valid tail prefixes are copied. The directory and source uniqueness checks precede these moves.

For a two-cycle, both algorithms write `2b` records. For a cycle of length `k >= 3`, the control writes `2(k-1)b`; rotation writes `(k+1)b`, including the temporary copy. The concrete Rust mapping tests and independent Python model cover partial tail owners as well as full-block paths and cycles. Neither finite model replaces the pointer and initialization checks in the Rust implementation.

## Prepared fallback

The rejected node's count vector moves into the Stream root. The Stream retains the frozen full-key scratch reservation. Its first scatter uses that vector, then ordinary descendant recursion computes its own statistics. The count allocation survives through exactly the same descendant traversal as a normally prepared Stream root.

Only an unchanged initial root reuses the fact that its ordered check failed. A descendant still performs the Stream ordered check; if it succeeds, the prepared vector is dropped without allocating the arena. The ledger test covers that case. Saved scans are therefore counted from actual work, not assumed to be `2n` on every fallback.

Fallback work and peak allocation are included in the native measurement. The diagnostic aggregate now includes its complete stream work; it does not add a second copy of the same scatter or placement count.

## Consequences for future admission changes

With fixed block length, the `O(n/b)` directories remain linear in `n`. A square-root-space claim would require an explicit growing-block policy and a simultaneous account of the opposing `O(sigma b e)` scratch term. No such policy is introduced here.

A future admission rule may use the lifetime formulas to estimate a working set more accurately. If it depends on ancestor occupancy, a gate's prediction that a child will complete in cache must use the child's future occupancy, including the current retained row. A promise made under the parent's smaller occupancy is insufficient for the materialization bound.

A whole-sort hard budget would additionally require an explicit contract and a bound for every fallback, directory and simultaneously live allocation. The existing 256 KiB heuristic does not provide that contract. Allocations or arbitrary work performed inside user-supplied key/extractor code also cannot be bounded from the generic trait alone.

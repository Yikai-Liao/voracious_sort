# Integer monotone count rejected

Source aee9c8e retains cb10efb equality reduction and counts violating pairs
in u8 (bounded by TILE=128), preserving key order, tile boundaries and counters.
This safe-only first screen intentionally defers broad unit/ASan/Work/heap
validation until a positive performance result. Every timed sort still uses
the full stable key/ID/payload oracle. No new unsafe or allocation operations.

All 31 fixed screen cells / 2232 oracle rows pass frozen source/ELF, exact
paired reversed rotations, input-address and completion checks. Independent
reconstruction matches all 992 review fields.

Reject: wide32 sorted/n1M Groups/Stable median 1.0588, p10/p90 1.032/1.077,
12/12 slower. n16384 wide32 sorted is 1.2651, p10/p90 1.104/1.359, 11/12
slower. u128 sorted is near parity/noisy. Frozen ASM still packs scalar
predicates into K masks before a vector byte sum; the representation did not
remove the problematic wide comparison lowering. No fresh sampling needed.

Next bounded candidate restores boolean tiles and adds early failure within
the same loop for converted keys wider than a native machine word. This
prevents full-tile vectorization of software-wide comparisons while retaining
hardware-width vectorized scans. It changes only the private order proof,
not the Pa partition/recursion/backend or external sorter selection.
Same 31-cell first screen; no held-out seed or extended matrix was consumed.

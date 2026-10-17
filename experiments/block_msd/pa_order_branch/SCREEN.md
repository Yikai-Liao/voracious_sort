# Wide monotone early-failure screen

Frozen before outcomes: current source source; full ten-layout native executable,
no frontier_work or frontier_narrow_screen. Release native CPU / opt3 /
16 codegen units / line tables / incremental / six build jobs / locked offline.

Retain equal-tile OR(key XOR first) and original boolean monotone tiles.
For Converted key widths above usize::BITS, exit at the first violating pair
in the same loop. Narrow keys retain complete-tile reduction. Successful
proofs have identical key reads; failing wide proofs read fewer pairs.
The threshold is native comparison capacity, inside the order proof; Pa
partition, recursion, classifier and backend do not select another sorter. Per-record evaluation order, TILE=128, first-different-key search,
remainder, monotonicity test and input writes are unchanged. The equality accumulator uses the existing Converted native type. No allocation, policy or sorter added.

31 cells, each 12 reps and six method slots (2232 rows): Pa,
Pa_ordered_tiled, Pa_unified_groups_t16777216, L_frozen, stable_msd, Pa.
Every cell has complete paired forward/reverse rotations. Full stable oracle
checks key, ID and payload after every sort; same allocation within each cell.
The old frozen ELF is retained for subsequent independent one-change pairs.

24 ordered cells: n=16384 and 1048576, B64, equal/sorted/reverse,
u8/u16/u128/wide32. Seven retained-gain guards: B64 Small8/u64/u16_id8
uniform and u8/u16 sparse; B512 Small8 and large128 uniform. Seed42.

Advance only if wide equality gaps close without a stable guard regression.
Any unresolved ordered gap requires a fresh profile rather than a tile grid.
This is a first screen; full Work/space/ASan, 91-cell seen matrix, mechanism
ablations, frozen old/new pairs and the still unseen seed remain conditional.

Native regression suite is deferred until a positive first screen; this safe
integer representation adds no unsafe operation. All 2232 timed rows include
the full stable oracle. Failed screens do not trigger broad validation.

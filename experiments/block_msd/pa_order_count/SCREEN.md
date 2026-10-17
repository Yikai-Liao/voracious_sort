# Bounded monotone violation count screen

Frozen before outcomes: current source source; full ten-layout native executable,
no frontier_work or frontier_narrow_screen. Release native CPU / opt3 /
16 codegen units / line tables / incremental / six build jobs / locked offline.

Retain equal-tile OR(key XOR first). Monotone tiles count violating pairs
in u8, bounded by TILE=128. The count is zero exactly when the tile is ordered. Per-record evaluation order/count, TILE=128, first-failing-tile search,
remainder, monotonicity test and input writes are unchanged. The local word
uses the existing Converted native type. No allocation, policy or sorter added.

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

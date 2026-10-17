# Remaining wide-equality cost

After all 91 seen cells finished, profile the same frozen full timing ELF on
u128/equal/n16384/B64/seed42, 32768 oracle-checked repetitions, pinned CPU2.
The diagnostic CSV is excluded from formal comparisons. cpu-clock:u/1999 Hz
recorded 4244 samples, zero lost. Flat/no-inline reports and offset scripts have
empty stderr; no source/inline addr2line report is used.

ordered_tiled::ordered<u128,u128> receives 1107 samples (26.08% of the entire
process, including restore/oracle/formatting). 1089 of those land at static
0x40c1c4..0x40c34a, the first_different all-equal tile reduction. The raw symbol
plus offset is retained, avoiding any inference from ASLR addresses alone.

ordered.asm shows the per-record u128 equality lowered to scalar XOR/OR/SETcc,
then KMOV/KSHIFT/KOR predicate packing and mask reductions. This is the actual
whole-tile path for this all-equal input. stable-entry.asm is retained for context.
Sampling percentages are not timed-phase percentages or independent speedups.

Next screen: keep the same scan order and tiles, represent the equality proof
as OR(key XOR first) in the native key type, compare once per tile. This is exact
for every key bit and uses constant local state. It removes per-record boolean
predicates in the source but has no measured benefit until a new frozen screen.

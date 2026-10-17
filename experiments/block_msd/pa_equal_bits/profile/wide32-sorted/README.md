# Remaining ascending-wide cost

After all 2232 formal screen rows completed, profile the frozen cb10efb full
native ELF, wide32/sorted/n1048576/B64/seed42, 512 full-oracle repetitions.
All diagnostic rows completed on one allocation. cpu-clock:u/1999Hz recorded
19491 samples and zero lost. Flat/no-inline and symbol-offset stderr are empty.

The wide ordered function receives 4800 whole-process samples;
4400 land in ascending tile inner loop 0xe57e0..0xe588d.
This process includes restoration, oracle and formatting; these are not phase
percentages. Raw symbols plus offsets map samples to the frozen static ASM.

The loop compares u128 pairs with CMP/SBB/SETcc, packs individual predicates
through KMOV/KSHIFT/KOR, and reduces K masks. The new first-equality reduction
is no longer the long-running path on ascending input. Top samples are loads,
so sampling alone does not attribute a speed ratio to mask instructions.

Next bounded candidate retains the exact key reads, work counts, tiles and
failure/write contract, and proves ascending order with OR(left XOR min(left,
right)) == 0 (descending uses max). This keeps the reduction in native key
words. Benefit is unmeasured until the next immutable screen.

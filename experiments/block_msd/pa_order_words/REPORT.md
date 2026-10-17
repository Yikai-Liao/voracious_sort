# Native monotone differences rejected

Source b654de7 retained the positive cb10efb equality proof and changed only
monotone tile representation to OR(left XOR min(left,right)); descending max.
The proof is exact and optimized frontier tests pass 33/33. Full native time
build 56.10s, no counters/narrow feature, same frozen release settings.

All 31 predeclared screen cells / 2232 full stable-oracle rows pass source/ELF,
slot/actual reversed rotation, address and completion checks. Independent
summary reconstruction matches all 992 numeric fields.

Performance rejects this representation: wide32 sorted/n1M Groups/Stable
median 1.205, p10/p90 1.179/1.259, 12/12 slower, CPU 1.205. At n16384,
u128 sorted 1.456 and wide32 sorted 1.461, both 12/12 slower. Native cmovs
and extra full-word XOR/OR appear in frozen ASM; static instructions alone
do not quantify individual costs. Narrow/retained scatter guards stay below
Stable in median, but cannot compensate for these ordered regressions.

Do not run full Work/heap/ASan, 91-cell acceptance, mechanisms or heldout on
this candidate. Revert this monotone change; retain the positive first-equal
XOR/OR proof. Next bounded screen replaces boolean monotone reduction with
a u8 count of violating pairs. With TILE=128 the maximum count is 128, so
zero means ordered without overflow. Reads/order/tile boundary stay exact.

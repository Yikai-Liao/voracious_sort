# Lookup group-position machine code

Source e7c5e15 and the immutable time ELF recorded in ../binary-sha256.txt. `nm -C -S` identifies u16/Identity arithmetic at 0x1309b0, size 0xb78, and lookup at 0x131530, size 0xb45. Neither helper has a const BYTE parameter; the final bool distinguishes the group-position calculations.

Lookup's roomy-group path is 0x131830..0x131923. Label bits form the table address; 0x1318bf loads the packed u32. Original-order stores are at 0x1318c3, 0x1318d6, 0x1318e5 and 0x131907. Two cursors/capacities update at 0x131917..0x131923. Capacity checks at 0x131942 and 0x13194d guard this path. Static code retains stack accesses and register moves. This confirms scheduling, not elapsed-time benefit. No perf sampling was run in this stage.

The earlier ELF/profile from the rejected method-registry invocation is retained under ../validation/rejected-harness/; it generated no timing rows.

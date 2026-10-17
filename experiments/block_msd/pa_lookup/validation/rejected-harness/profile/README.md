# Lookup group-position machine code

The immutable time ELF is recorded in ../binary-sha256.txt. nm -C -S identifies u16/Identity arithmetic at 0x130940, size0xb78, and lookup at0x1314c0, size0xb45. Neither helper has a const BYTE parameter; the final bool distinguishes the group-position calculations.

Lookup's roomy-group path is 0x1317c0..0x1318b3. Label bits form the table address, and0x13184f loads the packed u32. Stores retain the original input order at0x131853,866,875,897. The two cursors and capacities update at0x1318a7..b3. Capacity checks at0x1318d2 and0x1318dd guard this path. Static code also retains several stack accesses and register moves. This inspection confirms table use and scheduling, and does not establish elapsed-time benefit. No perf sampling was run at this point.

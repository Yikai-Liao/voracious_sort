# Final full-layout machine code

These disassemblies come from the frozen native `target/pa-groups-final/time`,
without `frontier_work` or `frontier_narrow_screen`. `nm -C -S` identifies the
complete generic types; the corresponding object ranges were extracted with
`objdump -d -C`. Binary hashes are recorded by the final campaign ledger.

For primitive u16 / Identity, the root grouped scatter starts at `0x275560`
(size `0x8be`); the local-distribution instance starts at `0x2722d0`
(size `0x89c`). The root instance contains vectorized mask construction
(`vptestmw`, `vpsllvq`) followed by the two selected-offset copy loops
(`tzcnt`, `blsr`). This confirms that the full-layout build retains the intended
schedule. Static instruction sequences do not establish the time spent in a
phase or the speedup of the complete sort.

# Machine-code check

Frozen narrow-screen ELF: see ../binary-sha256.txt. `nm -C -S` exposes the full Rust types and const byte arguments. The u16/Identity/BYTE=0 reserved scatter starts at 0x139d50, size 0x762 (1890 bytes), saved by objdump in u16-identity-byte0-reserved.txt.

The steady group begins with four byte label loads at 0x139f29, 0x139f38, 0x139f3e and 0x139f44. It reserves the four cursor positions before reaching the record-store sequence at 0x139ef1..0x139f15. The four 16-bit payload reloads and stores alternate there. The intended reservation/store separation is present, with four additional narrow label loads and a 0x98-byte explicit stack allocation plus six saved registers. No performance benefit follows from this inspection alone.

No sampling profiler was run for this stage. Correctness tests and oracle screen results are separate evidence.

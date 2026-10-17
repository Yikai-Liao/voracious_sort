# Batched-cursor machine code

Source 4e4ff7a, copied ELF in ../binary-sha256.txt. nm -C -S shows one u16/Identity scatter_binary_batched instance, with no const BYTE parameter: address 0x119920, size 0xb78 (2936 bytes). Its byte-dependent mask preparation precedes the record loop.

The group fast path at 0x119c00..0x119cd9 computes four binary labels, selected-bucket prefix offsets and four original-order record copies. Cursor updates occur once each at 0x119cc5 and 0x119ccc, and remaining capacities at 0x119cc9 and 0x119cd9. Capacity checks at 0x119cf8 and 0x119d01 select scalar fallback near block ends. There is no block reservation within the roomy group path. The source and static assembly support the intended scheduling, but do not establish a speedup.

The raw warmup-u16-sparse.csv is a separate 128-repeat Pa process for CPU warmup, immediately before the fixed 28-repeat confirmation. Command: taskset -c 2 target/pa-batch/time 1048576 128 Pa sparse u16 time 64 42. Its empty stderr is retained. It is excluded from formal CSV validation/summary and is not profiler sampling. No perf record campaign was run in this stage.

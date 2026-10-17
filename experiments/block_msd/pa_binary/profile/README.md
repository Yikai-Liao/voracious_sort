# Two-cursor code generation

Frozen source c7cc1ca and the ELF in ../binary-sha256.txt. nm-C-S.txt contains full type names. u16/Identity/BYTE=0 scatter_binary starts at 0x134640 and is 0x8d8 (2264) bytes.

The steady scalar record at 0x134934..0x13496e loads one u16, tests the varying bit, chooses a destination and end using cmov, stores the record, and updates both cursor values using cmov. The next pointers remain in r11/r13 and the end pointers in rsi/rdx across the hot record path. There are no record-by-record bucket-table loads or stores on that path; usage/counts and physical allocation checks occur on refill. Thus the local-cursor target was achieved, but the serial conditional cursor-update dependency remains.

This is a static machine-code observation. No sampling profiler or hardware counter campaign was run in this stage, and it does not establish which individual instruction caused the failed screen.

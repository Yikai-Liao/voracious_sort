# Grouped-write machine code

The narrow ELF is in ../binary-sha256.txt. u16/Identity grouped scatter starts at 0x130a80, size 0x8be, with no const BYTE parameter. The native-key bit mask is prepared before input iteration. Mask generation uses vector bit tests and shifts at 0x130ec0 onward; it is followed by separate low/high selected-offset loops using trailing-zero scans and local cursors. Raw nm/objdump evidence is retained. This confirms the intended schedule, not separate phase timing.

The warmup CSV is diagnostic: taskset -c 2 target/pa-groups/time 1048576 128 Pa sparse u16 time 64 42. It precedes the fixed 24-repeat confirmation, is not part of formal validation or performance summaries, and its empty stderr is retained. There was no perf sampling of this candidate; the prior original-scatter diagnosis is under ../pa_block_cost/.

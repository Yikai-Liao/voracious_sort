# Frozen small8 uniform diagnosis

After every formal run completed, the frozen full time runner executed Groups
on n1048576/B64/small8/uniform/seed42 for 64 repetitions, pinned to CPU2 under
cpu-clock:u sampling (1999 Hz, DWARF4096). Every diagnostic row and warmup
passed the complete stable oracle. These 64 rows are excluded from formal
timing summaries.

perf captured 6470 samples with no loss. perf-flat.txt is the authoritative
self-symbol report: three BYTE2/1/0 per-record scatter closures account for
1519/1493/1197 samples (4209 total; approximately 65.06% in the weighted flat
report). This is a whole-process user-space sample share, including generation,
restore and oracle, not a sort-phase percentage or hardware-cycle measurement.

symbols.json maps the sampled raw symbols through nm -S to nm -C -S full type
names and exact address ranges. small-scatter-0/1/2.asm show the three callees;
small-step-caller.asm shows explicit per-record calls in the unrolled and tail
loops. The callees push/pop registers and reload captured pointer/classifier
state on each call. Symbol aliases may name distribute_children because LLVM
shares identical instantiated code; the actual diagnostic command runs only
Groups. The attempted u64 comparison filter selected no functions, so no u64
assembly comparison or causal claim is made here.

The first two perf reports enabled source/inline resolution and triggered
addr2line sentinel errors. Their stderr and output remain preserved, but their
line/callchain interpretation is excluded. The subsequent report disables
inline and callgraph resolution, has empty stderr, and uses symbol-table ranges
independently verified by objdump. No perf annotate retries were used.

The next hypothesis is to keep the original closure path as a control and emit
the equivalent write body directly inside the record loop. That should remove
the observed per-record calls without changing destinations, reservation order,
labels or heap ownership; a same-ELF ablation must establish its actual benefit.
No such change or performance result is included in this campaign.

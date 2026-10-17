# Existing scalar function, explicitly outlined

Full-type nm and three selected Small/Prefix<u32> scalar functions confirm the
original record closure is inlined into the scalar pass, with no per-record
closure call. Each byte function is 1583/1603/1603 bytes. Its remaining calls
are bounds/panic cold paths after the hot record loops. The linker folded the
identical Pa partition function into the distribute_children symbol name;
symbol aliases alone do not identify which sorting policy ran. No perf sampling
was run for this stage. The seven-layout source and binary hashes are frozen.

The initial extraction parser expected every nm row to have four fields, then
expected the unmerged pa::partition symbol. Both assumptions were corrected
before any benchmark; neither failed extraction ran timing or changed the ELF.
The retained extraction uses the actual folded function name and size.

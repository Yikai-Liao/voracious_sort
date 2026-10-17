# Scalar-loop code generation audit

Binary: target/pa-direct/time, immutable hash in ../binary-sha256.txt.
Source: eaf0c09, native CPU, line-table debug, CGU16, incremental, no LTO.
No perf sampling was run for this stage. This is a static code audit.

nm-demangled.txt retains full v0 type names. The measured layout small8 is
frontier_experiment::Small (u32 key plus u32 serial); Small8 is the distinct
u8_id8 layout. symbols.json selects the Small/Prefix<u32>/pa::partition
classifier, both direct and original scalar functions for bytes 0..2.
Each corresponding asm file was extracted at its nm address and size.

Both the new macro function AND the unchanged original closure function have
inlined their per-record writes in this binary. Their remaining calls target
bounds/panic paths after the hot loops; neither has per-record write-closure
calls. The older full Group binary had such calls in the actual hot path
(see ../pa_groups_final/profile/small8-uniform). Symbol folding can give an
identical write closure a distribute_children name in that older profile.
Do not infer that name means the timed unified method took the old policy.

The same-ELF comparison therefore measures extra benefit of macro expansion
only after a collateral compiler outlining/inlining change. It cannot assign
the entire cross-build speedup to the macro. The evidence supports trying an
explicit outline boundary on the original scalar function, removing the
redundant macro implementation, then revalidating from that simpler source.

# Existing scalar scatter with explicit outline boundary

Source frozen at 8bf14e0 before release build and timing. Relative to the fully
validated Group source 2513fa5, sorting logic differs only by inline(never) on
block::Sorter::scatter (the entire existing function body is unchanged). A
multibit u32-key/8-byte payload regression probe is retained. The seven-layout
harness-only narrow feature remains; the final full build omits it.

The previous pa_direct screen closed the Small8 Stable gap but its unchanged
original scalar loop was also outlined and had inlined per-record writes. The
macro copy had no stable additional gain. This source removes the Direct policy,
macro copy, extra runtime flag and method registration; the old grouped kernel,
classifier, 16 MiB threshold, block representation and all work are unchanged.

The first screen is fixed before outcomes: n1048576/seed42, B64 all seven
native-word layouts x uniform/sparse, plus B512 small8/u64 x uniform/sparse.
Twelve reps, six slots Pa/Prepared/Groups/L_frozen/Stable/Pa; 18 cells, 1296
oracle rows. Pa A/A is 5/0; reverse paired rotations span the complete slots.
All files stay separate. Check actual outline/per-record inlining in full-type
nm/objdump and compare Group against same-ELF Prepared and Stable. Earlier full
Group and Direct archives are prior evidence, not pooled timings. Full safety,
work/heap and the entire seen matrix remain required after a positive screen;
held-out seed20261018 stays unseen until those pass.

# Independent frozen source pairs fixed before execution

Only after seen guards and work/space checks: run paired_sources.py outline,
equality, wide_order sequentially; then review_pairs.py. 14 cells / 896 child
oracle rows, 16 outer reps / four slots old,new,new-Stable,old, two complete
paired forward/reverse rotations. Each child also runs its normal warmup and
full stable oracle; timestamps isolate the sort call including allocations.

outline: source2513fa5 ->8bf14e0, unchanged original scalar body gains one
inline(never). Small8 uniform B64/B512, u64 uniform B64, u16 sparse B64, n1M.
equality: source8bf14e0 ->cb10efb, only first-equal native XOR/OR reduction
and its behavior test. u128/wide32 equal n16384 and n1M, B64.
wide_order: sourcecb10efb ->49db9f8, only private wide early-failure proof.
u128/wide32 sorted n16384 and n1M plus u8/u16 sorted n1M, B64.
All seed42. All full-layout native flags match; ELF SHA ledgers checked before
and after. ASLR allocations differ across processes, explicitly recorded.
These are separate comparisons from same-ELF policy ablations and not pooled.

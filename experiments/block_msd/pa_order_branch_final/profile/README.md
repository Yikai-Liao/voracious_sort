# Mechanism evidence and scope

Final source `49db9f8` uses the same full Time ELF as
[the fixed screen](../../pa_order_branch/profile/). Its nm ledger and u128/wide32
order-proof ASM are retained there. The wide monotone loop uses scalar
compare/branch; native-word keys retain vectorizable reductions. No new
whole-process perf sampling ran during the final formal timing campaign.

The scalar scatter source module is byte-identical to `8bf14e0`, whose
[actual Pa caller and folded scalar functions](../../pa_outline_final/profile/)
show outlined byte passes with inlined record writes. The original sampled
per-record closure problem is archived in
[pa_groups_final](../../pa_groups_final/profile/small8-uniform/).

The equality mask-packing diagnosis is archived at
[8bf14e0/u128-equal](../../pa_outline_final/profile/u128-equal/); the remaining
monotone comparison packing at
[cb10efb/wide32-sorted](../../pa_equal_bits/profile/wide32-sorted/). These flat
user CPU samples include restoration/oracle/formatting and are not percentages
of the measured sorting phase. Source, binary hash, raw symbol offsets, ASM,
lost-sample count and diagnostic oracle rows are retained in each stage.

The independent frozen source pairs in ../pairs isolate the three retained
source deltas. Their performance estimates stay separate from same-ELF policy
ablations and from the primary validation matrix. Static instruction patterns
and whole-process samples alone are not speedup measurements.

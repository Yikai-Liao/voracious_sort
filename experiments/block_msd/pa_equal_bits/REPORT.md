# Native equality reduction: partial improvement, ordered guard remains open

Source cb10efb changes only safe first_different reduction and one regression
test. Native optimized ordered tests 7/7 and all frontier tests 33/33 pass.
Full ten-layout time build: 54.27s. Timing starts after all build/test work.

The fixed screen completes 31 cells / 2232 full-stability-oracle rows; frozen
source/ELF, slots, actual forward/reverse rotations, shared input addresses and
completion all pass. An independent reconstruction matches 992 summary fields.

At n16384 u128 equal, Groups/Stable median is .852 (previous frozen full
campaign 1.334; separate campaigns, no pooled estimate). wide32 equal is .829.
At n1M u128 equal is .947; wide32 equal is 1.023 with ratios straddling one.
All seven retained-gain guard medians remain below Stable; large128/B512
uniform .885, Small8 uniform .588/B64 and .670/B512, u8/u16 sparse .837/.834.

Do not advance to the full acceptance matrix yet: wide32 sorted/n1M is
1.043 of Stable, p10 1.003 / p90 1.061, 11/12 slower, CPU ratio 1.043.
Small n16384 ascending u128/wide32 remain noisy or slower. All cells remain
in review-ablation.csv, with per-cell A/A and CPU ratios. No cross-file pooling.

The fresh wide32/sorted profile is diagnostic and follows formal timing.
It locates remaining cost in monotone's native u128 comparisons and packed
boolean reduction; see profile/wide32-sorted. Equality reduction is retained
as positive progress while the next isolated reduction screen addresses order.
ASan/full new Work/heap and held-out seed were not run for this partial stage.
Prior pointer kernels retain their archived ASan coverage; this change adds
no unsafe operations, allocation, policy or external type-based sorter route.

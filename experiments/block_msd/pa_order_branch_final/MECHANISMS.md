# Independent component comparisons

All 22 predeclared mechanism cells / 2336 full-oracle rows passed exact slot,
rep, actual reversed-rotation and frozen source/ELF checks. The table retains
every predeclared ingredient edge; ratios below one favor the numerator.
The full review also retains Groups against every control, paired CPU ratios
and per-cell Pa A/A. Sample quantiles are not confidence intervals.

| N | B | Layout | Case | Numerator / denominator | Median | p10 | p90 | Slower reps |
|---:|---:|---|---|---|---:|---:|---:|---:|
| 1048576 | 512 | large128 | deep_unique90 | sample / cache | 0.936 | 0.890 | 0.959 | 0/16 |
| 1048576 | 512 | large128 | deep_unique90 | reuse / cache | 0.947 | 0.875 | 0.992 | 1/16 |
| 1048576 | 512 | large128 | deep_unique90 | prepared / sample | 0.971 | 0.919 | 1.018 | 3/16 |
| 1048576 | 512 | large128 | deep_unique90 | prepared / reuse | 0.942 | 0.918 | 0.980 | 1/16 |
| 1048576 | 512 | large128 | majority_prefix | sample / cache | 0.945 | 0.917 | 0.979 | 0/16 |
| 1048576 | 512 | large128 | majority_prefix | reuse / cache | 0.945 | 0.920 | 0.970 | 0/16 |
| 1048576 | 512 | large128 | majority_prefix | prepared / sample | 0.949 | 0.909 | 0.960 | 0/16 |
| 1048576 | 512 | large128 | majority_prefix | prepared / reuse | 0.945 | 0.914 | 0.960 | 0/16 |
| 1048576 | 512 | large128 | uniform | sample / cache | 0.975 | 0.952 | 1.039 | 5/16 |
| 1048576 | 512 | large128 | uniform | reuse / cache | 0.946 | 0.901 | 0.990 | 1/16 |
| 1048576 | 512 | large128 | uniform | prepared / sample | 0.954 | 0.941 | 1.007 | 2/16 |
| 1048576 | 512 | large128 | uniform | prepared / reuse | 0.999 | 0.959 | 1.045 | 8/16 |
| 262144 | 64 | u128 | deep_unique90 | sample / cache | 1.011 | 0.936 | 1.081 | 10/16 |
| 262144 | 64 | u128 | deep_unique90 | reuse / cache | 0.856 | 0.772 | 0.933 | 1/16 |
| 262144 | 64 | u128 | deep_unique90 | prepared / sample | 0.837 | 0.762 | 1.128 | 3/16 |
| 262144 | 64 | u128 | deep_unique90 | prepared / reuse | 0.997 | 0.966 | 1.220 | 8/16 |
| 262144 | 64 | u128 | majority_prefix | sample / cache | 1.001 | 0.779 | 1.195 | 8/16 |
| 262144 | 64 | u128 | majority_prefix | reuse / cache | 0.915 | 0.742 | 1.087 | 3/16 |
| 262144 | 64 | u128 | majority_prefix | prepared / sample | 0.896 | 0.756 | 1.035 | 2/16 |
| 262144 | 64 | u128 | majority_prefix | prepared / reuse | 0.986 | 0.850 | 1.108 | 7/16 |
| 262144 | 64 | u128 | uniform | sample / cache | 1.007 | 0.943 | 1.093 | 8/16 |
| 262144 | 64 | u128 | uniform | reuse / cache | 0.985 | 0.895 | 1.117 | 6/16 |
| 262144 | 64 | u128 | uniform | prepared / sample | 0.971 | 0.898 | 1.422 | 7/16 |
| 262144 | 64 | u128 | uniform | prepared / reuse | 1.018 | 0.914 | 1.286 | 9/16 |
| 16384 | 64 | u128 | equal | Pa_ordered_tiled / Pa_ordered | 0.658 | 0.548 | 0.697 | 0/14 |
| 16384 | 64 | u128 | reverse | Pa_ordered_tiled / Pa_ordered | 0.963 | 0.957 | 0.979 | 1/14 |
| 16384 | 64 | u128 | sorted | Pa_ordered_tiled / Pa_ordered | 0.463 | 0.415 | 0.604 | 0/14 |
| 16384 | 64 | u16 | equal | Pa_ordered_tiled / Pa_ordered | 0.138 | 0.129 | 0.177 | 0/14 |
| 16384 | 64 | u16 | reverse | Pa_ordered_tiled / Pa_ordered | 0.834 | 0.634 | 1.006 | 2/14 |
| 16384 | 64 | u16 | sorted | Pa_ordered_tiled / Pa_ordered | 0.070 | 0.067 | 0.072 | 0/14 |
| 16384 | 64 | u8 | equal | Pa_ordered_tiled / Pa_ordered | 0.081 | 0.080 | 0.111 | 0/14 |
| 16384 | 64 | u8 | reverse | Pa_ordered_tiled / Pa_ordered | 0.484 | 0.382 | 0.785 | 1/14 |
| 16384 | 64 | u8 | sorted | Pa_ordered_tiled / Pa_ordered | 0.044 | 0.036 | 0.045 | 0/14 |
| 16384 | 64 | wide32 | equal | Pa_ordered_tiled / Pa_ordered | 0.724 | 0.535 | 1.093 | 2/14 |
| 16384 | 64 | wide32 | reverse | Pa_ordered_tiled / Pa_ordered | 0.964 | 0.698 | 0.970 | 0/14 |
| 16384 | 64 | wide32 | sorted | Pa_ordered_tiled / Pa_ordered | 0.720 | 0.455 | 1.243 | 3/14 |
| 1048576 | 64 | u64 | deep_unique90 | band_nested / Pa_band | 0.480 | 0.447 | 0.511 | 0/14 |
| 1048576 | 64 | u64 | deep_unique90 | band_sortleaf / Pa_band | 0.639 | 0.592 | 0.686 | 0/14 |
| 1048576 | 64 | u64 | majority_prefix | band_nested / Pa_band | 1.056 | 0.993 | 1.258 | 12/14 |
| 1048576 | 64 | u64 | majority_prefix | band_sortleaf / Pa_band | 1.015 | 0.938 | 1.464 | 7/14 |
| 1048576 | 64 | wide32 | deep_unique90 | band_nested / Pa_band | 1.008 | 0.960 | 1.097 | 7/14 |
| 1048576 | 64 | wide32 | deep_unique90 | band_sortleaf / Pa_band | 0.984 | 0.912 | 1.045 | 6/14 |
| 1048576 | 64 | wide32 | majority_prefix | band_nested / Pa_band | 1.029 | 0.985 | 1.076 | 11/14 |
| 1048576 | 64 | wide32 | majority_prefix | band_sortleaf / Pa_band | 1.008 | 0.959 | 1.060 | 8/14 |

Prepared reuses the existing variation mask; sampling and reuse are separate
controls against Cache. Sampling shows little stable added gain on medium
u128, while reuse improves its deep-unique case. On large128/B512, the two
ingredients each help the skew cases and Prepared retains both effects.
They do not improve every case independently.

Nested classification and stable leaves independently repair the known u64
deep-unique geometry (ratios about .480 and .639 of Band). Nested alone is
slower on majority-prefix controls; the combined candidate is evaluated in
the separate primary matrix rather than inferred by adding component gains.

Source-only outlining/equality/early-failure evidence is separate in
[review-pairs.csv](review-pairs.csv) and [PAIRS.md](PAIRS.md). Their fixed
source deltas keep all layouts/flags frozen and do not pool with this table.

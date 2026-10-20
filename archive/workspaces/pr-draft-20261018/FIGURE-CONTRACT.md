# PR figure contract

Python/matplotlib; exact reuse of the frozen comparison plots. Only the display name Rust stable changes to Driftsort, verified against the measured Rust 1.98.1 sources and official slice documentation. Data, cohort selection, parameters, ratios and geometry remain unchanged.

Claim: the unchanged block implementation offers a useful speed/auxiliary-memory tradeoff, with input-dependent losses. Overview panels show one large-input cost example, per-case heap counts, and the empirical distribution of paired time ratios. The nine-facet comparison preserves every type/distribution case and exposes the losses.

Quantitative grids; overview 183 x 230 mm, detailed comparison 183 x 280 mm. Editable PDF/SVG and 300 dpi PNG for GitHub; minimum 5 pt text. Timing ranges in overview panel a are observed ranges, not confidence intervals. Across-case curves are case heterogeneity, not timing uncertainty. Two reversed-record LSD outputs fail the stable oracle and are omitted from same-semantics comparisons (205 LSD cases; 207 for other comparators).

The displayed c=4 / approximately 1 KiB block floor is an external benchmark policy, not an automatic API already implemented in the PR. Parameter calculation is outside the timer. Only radix=8 was benchmarked for this policy.

Native comparisons: two additional nine-type facets use the same 23 distribution rows and absolute speedup axis (1/8 to 64), three methods per figure. No heatmap or global normalization. Ratio is comparator median time / candidate median time; no paired-statistic claim. All 1,012 supported method/type/distribution cells are retained, including unstable outputs that differ from the stable oracle. All input seed/digests match the reference and all key-order/fingerprint checks pass. No new timings.

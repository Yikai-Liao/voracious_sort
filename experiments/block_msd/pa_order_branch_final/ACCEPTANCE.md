# Fixed full validation

Source49db9f8 / same full ten-layout Time ELF as pa_order_branch; no rebuild,
feature change, threshold tuning or timing pooling. Retain all 91 seen cells
from the prior campaigns, 12 reps / six slots / complete paired rotations.
Same full stable oracle per sort and same allocation within each cell.

First measure native Work and requested heap: original 50+62 cells (572 rows).
All sort/scatter/label/compact/leaf/heap fields should equal frozen prior
resources. Only order_records can decrease for wide keys in Prepared/Groups,
by at most 254 reads per visited node; this is explicitly validated.

Safe equality/ordering reductions and the outlier test are the only source
changes from 8bf14e0. Original scalar/grouped pointer loops are byte-identical.
Run fresh optimized full frontier tests. Prior 8bf ASan 32 tests +170 boundary
oracle rows remain prior-source coverage; a redundant full sanitizer rebuild
is not required for safe integer-only changes. Do not claim fresh ASan.

Then narrow prepared/grouped ablation, seen91, fixed mechanism sweeps2336,
and independent frozen source pairs. Heldout20261018 last, only after these
checks. User target is close to or faster than Stable across former gaps,
with Block space benefits and robust duplicate/full-unique prefix behavior.
Near-parity watches remain wide32 equal/n1M and sorted/n16384 (screen ~3-4
percent median deficit, ratios cross parity, broad A/A). Report every ratio
and its variation; do not relabel this as universal faster-than-Stable.

# Fixed confirmation before outcomes

Same immutable 49db9f8 source and full native ELF, six existing method slots.
All twelve wide ordered cells: n16384 and n1048576, u128/wide32,
equal/sorted/reverse, B64/seed42. Increase to 24 reps, four complete paired
rotations. 1728 full-oracle rows, keep all cells and report separately from
the initial 12-rep screen. No pooling or fastest-run selection.

Resolve noisy small-wide ascending and large-wide equal guards before full
validation. Native-word early failure is confined to the private order proof;
no change in classifiers, radix backend, recursion, leaves or heap allocation.
If a stable gap remains, do not consume the heldout seed or run a broad matrix.

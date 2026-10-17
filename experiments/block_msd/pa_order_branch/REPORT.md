# Wide order proof advances to full validation

Source 49db9f8 retains the cb10efb equal-tile native XOR/OR proof and original
boolean monotone tile reduction. For converted keys wider than usize, the
same loop exits on the first violating pair. Native-word keys retain complete
tile reductions. This is a private comparison-kernel boundary, without another
sorter, classifier, radix backend, recursion or allocation path.

Initial fixed screen: 31 cells / 2232 full stable key/ID/payload oracle rows.
All source/ELF, actual forward/reverse rotation, input-address and completion
checks pass; 992 numeric summary fields independently reconstructed. All seven
retained-gain guard medians are below Stable (.603 to .933).

The 12 initially noisy wide ordered cells received a predeclared separate
24-rep confirmation, 1728 rows and 384 independently reconstructed fields.
No pooling: n16384 u128 equal/sorted/reverse ratios are .812/.957/.403;
wide32 .867/1.037/.446. n1M u128 .994/.983/.526; wide32 1.034/.995/.593.
The two remaining median deficits are 3.4/3.7 percent, with paired ratios
straddling parity and A/A variation reported per cell. This is near Stable,
not a claim that every case is faster; final matrix must retain these watches.

Frozen ASM shows scalar compare/branch for software-wide monotone proofs;
word-sized detector lowering remains the existing vectorizable reduction.
Full regression/Work/heap, original 91-cell seen matrix, mechanism ablations,
independent frozen pre/post pairs and the unseen seed are conditional next work.
The Goal remains active. Broad tests were deferred during this safe-only first
screen; no new unsafe operations or pointers are introduced. Prior source's
ASan pointer-kernel evidence remains archived and is not labeled as this source.

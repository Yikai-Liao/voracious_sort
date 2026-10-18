# Hardware-only admission screen

Source 9981220 removes production software compression. Its 16 guard cells pass all oracles, but u32 sparse regresses at B64/B512: paired medians 1.743/1.944, p10 1.691/1.932. The independent isolated B64 repeat is 1.744 (p10 1.562); work confirms 2N scatter/2N label evaluations become N/N, yet time worsens. This checkpoint is rejected. See hwonly-screen-audit.json and hwonly-u32-isolatedsummary.csv.

The information batch was interrupted after a confirmation was mistakenly started for 1.5 seconds on the same CPU before it had ended. Both overlapping outputs are retained only under validation/invalid-overlap-* and excluded from all summaries. B64/B512 guards and the subsequent isolated confirmation did not overlap.

Next experiment removes the continuous-field branch from the hardware classifier. It was introduced for software extraction, while the accepted hardware selection rejects complete or partial contiguous masks with no real byte-pass saving. This is a hypothesis about the observed cost, not a verified cause.

The single-path classifier at 31ff0d2 passes 57 library tests and fixes the isolated u32 sparse controls: B64/B512 new/old medians .849/.870, p90 .877/.901. This confirms a material implementation cost from the removed branch for this cohort; it is not a universal hardware speed guarantee. Final native/generic/disabled validation uses a subsequent source cleanup and its own frozen files.

# Pre-library extraction checkpoint (6fdea75)

The 46-cell forced-software cohort is complete: 3,312 timed rows, all full key/identity/payload/stability oracles passed. Its original 16 guard cells have no median > 1.05 and p10 > 1 signal. The expanded cohort has two signals requiring fresh confirmation: u64/project8_cross (1.644), u128/project8_cross (1.069). Neither is accepted as noise or a pass. All raw rows and A/A remain in software-validated-*.

The 17-cell old/new executable ABBA control completed. Neither the new executable's old PA nor candidate has a median > 1.05 and p10 > 1 slowdown against the original frozen PA executable. This tests common-path drift independently of same-executable pairing; it is not the required final 103-cell matrix.

New user requirement: delegate architecture-specific extraction, CPU detection and fallback to a third-party library wherever possible. The old local intrinsics backend and its performance evidence remain a historical checkpoint. The final 103 cells will be measured after the library backend is selected and source frozen again.

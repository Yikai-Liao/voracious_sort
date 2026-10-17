# Direct-loop scalar scatter screen

The frozen grouped campaign at ../pa_groups_final found small8/uniform slower
than Stable by 27% at B64 and 32% at B512, both 12/12 slower. Its subsequent
whole-process cpu-clock profile placed about 65% of samples in three per-record
write closures; objdump confirmed calls and capture reloads in the hot loop.

UnifiedDirect inherits every UnifiedGroups policy and the fixed offline 16 MiB
threshold. The grouped mask/copy kernel and original scalar closure function
remain byte-for-byte unchanged. A private direct scalar function emits the
same record statements as a local macro, preserving extraction, destination,
copy, refill, usage/count and reservation order. It is inline(never) outside the
sixteen-way byte dispatcher; no new whole-step const-mode flag is introduced.
Both candidates retain one-bit grouping on eligible native-word records.

BlockScatter owns Original/Grouped/Direct selection and is propagated through
root, low-run, fallback and final completion paths. Selection occurs per byte,
outside record loops. No classifier, radix, threshold, recursion, heap layout,
or external key-width sorter routing changes. The existing harness-only
frontier_narrow_screen feature now includes all seven native-word record
layouts; final validation still requires the full ten-layout build.

The source was committed/frozen as eaf0c09 before the release build. Debug
tests compare original, grouped, direct+grouped and direct scalar schedules:
stable payloads, exact label traces (including explicit probes), every tail and
matching compact/tail work for equivalent write orders. A new multibit u32-key,
8-byte record test covers the actual failed record shape. All previous policy
and converted-key matrices include UnifiedDirect; runner registration is tested.

The first timing plan is fixed in screen.sh before any timing: 14 B64 cells
(all seven layouts, uniform/sparse) and four B512 cells (small8/u64,
uniform/sparse), n1048576/seed42, twelve reps, six slots
Pa/Groups/Direct/FrozenLSD/Stable/Pa. Total: 18 cells, 1,296 oracle rows,
complete rotations with paired reverse directions and Pa slots 5/0 A/A.
Files remain separate. Confirm the actual machine-code call removal and inspect
the same-ELF Groups control; codegen changes alone must not be attributed to
the macro if the control no longer retains the slow call path.

The screen must close the small8 Stable gap at both block sizes and avoid
material recurring regressions in the other ordinary/sparse cells relative to
Groups and Stable. Evaluate paired ratios, CPU time and cell-specific A/A,
without averages overriding failed cells. If it fails, archive the evidence
before another mechanism. If it passes, proceed to full-layout safety,
work/heap and the fixed seen-seed matrix. ASan, full release work, full heap,
and held-out seed20261018 are not yet completed for this source. Keep the
held-out seed unseen until the complete seen-seed acceptance passes.

# PA structural experiments

Base: `745cea6ab21030710cb036f88fa757505ef1990b`. Worktree:
`/root/code/voracious_sort-pa-structural`, branch `block-pa-structural`.

Goal: broaden stable PA wins against Rollercoaster and close the wide sparse
loss against frozen Block LSD, preserving the existing workspace lifecycle.
The uploaded reference supplies hypotheses, not implementation requirements.

Independent screen policies inherit the frozen UnifiedGroups configuration:

- Pa_identity: after approved PrefixBand, q <= 8 across >= 2 bytes completes
  the original key in one node; same original byte passes.
- Pa_projected: same admission, exact complete projection to a genuine u8
  label; one radix pass, no per-record label array, portable segment extraction.
- Pa_local: same logical classifier; force the existing sampled/exact-checked
  local completion opportunity by setting the workspace gate to zero.
- Pa_projected_local: combination, evaluated separately after the ablations.

Order detection and approved PrefixBand precede sparse completion. Key
conversion and stable leaves stay unchanged. Sparse eligibility uses the exact
mask restricted to the parent cap; complete identity may sort all key bits
because it always preserves the total key order.

Before screening: a target improvement must exceed 5% paired median and have
p90 below 1 in a fresh reversed-order repetition. A material regression is a
paired median > 1.05 AND p10 > 1, beyond the same-cell A/A envelope. Ambiguous
cases get another paired run; no fastest-run selection. These are experiment
retention rules, not confidence intervals. Timing excludes oracle/restore and
includes workspace acquisition/release. Freeze each ELF and SHA; do not pool
results from different ELFs. No concurrent compilation during timing.

Final validation: original 103 cells with candidate A/A, original PA, Fa,
Rollercoaster, frozen LSD and Stable MSD; new bit embedding/frequency and
reverse identity controls. Separate work and allocation runs. No second
machine is available in this workspace; portability remains unverified until
an independent machine run is supplied.

# PA structural experiments

Current steering: use hakmem 0.2.0 and never fall back to software compression. Missing hardware retains ordinary PA. The sections below record successive experiment plans, including rejected cohorts; current dependency boundary is in LIBRARY.md and final acceptance belongs in REPORT.md.


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

## Second screen: decisions from the first measurements

The first 20-cell screen rejected forced local scheduling as a general change.
The one-byte portable segment prototype also failed: primitive u32 sparse
regressed by 2.28x (B64) / 2.60x (B512), and u128 sparse B512 remained 1.135x
slower than frozen LSD. Those raw results are retained at commit a4ac2cc.

The next independent hypotheses are:

1. `Pa_packed`: highest-varying-bit projection with the existing size-based bit
   budget (capped at 32 bits). Use actual u8/u16/u32 tags, finish complete tags,
   and recurse under the lowest selected original bit for partial tags. Admit
   when the selected coordinates occupy more original bytes than packed bytes;
   dense masks stay on their original route. Compact low-bit digits use the
   existing reduced-radix block implementation. A parallel portable gather is
   always available; BMI2 extraction is compiled only for a target guaranteeing
   BMI2. `projection_portable` forces portable extraction with all other native
   compiler flags unchanged.
2. `Pa_runs`: carry the already-observed first label of the next run and look
   up the remaining key range only for nonsingleton runs. This removes actual
   repeated classification work without changing scatter or compact work.
3. `Pa_packed_runs`: measure the combination explicitly.

The same retention thresholds apply. Each screen's metadata records its own
source/ELF; the first and second screen timings must never be pooled.

## Third screen: bound the label representation itself

`Pa_narrow` uses the exact covering label-variation mask to truncate constant
high label bits into u8/u16/u32, preserving the original classifier's remaining
key cap. The small label also uses the existing reduced-radix workspace. This
applies to ordinary prefixes and the bounded PrefixBand alphabet, even when
the original converted key is wide. It changes no information budget or
physical scheduling threshold. `Pa_packed_narrow` combines it with projection;
`Pa_packed_narrow_runs` additionally carries run-boundary labels. The first
screen's failed specialized byte projection and forced-local policies were
removed from the active implementation; their source and evidence remain at
a4ac2cc. Pa_identity remains a diagnostic control.

Seven-slot runs use 14 repetitions, eight-slot runs use 16, so each slot sees a
complete rotation in both directions. This changes repetition counts, not the
103 original input cells. Forced portable-gather timing retains the other
native compiler flags; it is not a claim that that entire ELF is portable.

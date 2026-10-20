# Candidate-only screening

Reuse auto-baseline/time.jsonl and the already-saved comparator results. No new measurements of PA, PA A/A, strict projection, or previous algorithms. Build candidates with the saved native opt3 / codegen1 / thin-LTO profile. Match every candidate output to saved PA by kind, distribution, length, seed and repetition; require identical input digests, block size and radix. Match output digests when batch parity permits (the harness XORs its batch digests); every sort independently passes the full stable oracle. Each new sorting run verifies stable full-key identity and payload against a reference outside timing.

Stage 1: interval completion, six 1M integer numeric/normal targets. Stop if target gains are absent.
Stage 2: interval completion on a small broad screen spanning all native widths, float, wide records, low entropy, monotone and short input cases. Reject substantial regressions before proceeding.
Stage 3: if interval passes, evaluate natural-run completion on push/organ-pipe targets and the same broad screen. Then measure their combination on the short cohort. Only surviving mechanisms warrant a full candidate-only benchmark.

Historical timings provide a quick comparison and do not establish a same-process no-regression guarantee. Any observed losses and uncertainties remain explicit. Source changes stay isolated in the named PA worktree; the Block LSD PR is unaffected.

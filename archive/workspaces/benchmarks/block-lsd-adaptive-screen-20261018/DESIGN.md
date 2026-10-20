> Historical candidate plan. All candidates were later withdrawn; see FINAL-DECISION.json and RESULTS.md.

# Adaptive Block LSD experiment

Original: `origin/archive/block-lsd-original-20261018`, commit `e649c6af49d6bfdde896ca40cad387235fce4bfa`.
Candidate worktree: `/root/code/voracious_sort-workspaces/block-lsd-adaptive`, branch `research/block-lsd-adaptive`.
Both algorithms receive radix 8 and exactly `max(1, floor(1024/s), ceil(4 sqrt(9n/(512s))))` records per block. No data-dependent policy tuning.

Each experiment freezes sources, binary hashes, schedule and candidate diff before sorting. The harness retains the original input generator, converted-key full-output stable oracle, batching, forward/reverse seed pairing and allocation meter. `block_before_aa` invokes the exact original function as `block_before`. Compilation and plotting must finish before timing starts.

1. **Prefix reuse.** Return the first changed key position from the already required equality scan. Start order checking at the final equal-prefix key. Preserve the fact that the skipped prefix contained ties before stable descending reversal. First screen: 18 conditions, five widths and ordinary/structured distributions.
2. **Single displaced record.** Reuse the first ascending inversion; removing a single record must remove one endpoint of that inversion. Check the bridge and full remaining order before modifying data. Binary insertion uses upper bound for a left move and lower bound for a right move. Rotation uses O(1) space. First screen: nine types on uniform/push-front/push-middle, plus five ordinary u64 controls (32 conditions). This includes the prefix change; its comparison is directly against the unchanged original.
3. **Two monotone runs (design candidate).** Verify the second run before mutation. Normalize descending runs without reversing the payload order of ties. Merge by converted key, buffering only a run that fits within the existing `512*b` record scratch allowance; otherwise partition, stably rotate adjacent middle sections and recurse with one reused bounded buffer. The candidate is now implemented with safe slice operations; it has no measured speed claim until its frozen 18-condition screen completes.

Acceptance requires complete stable output and the original auxiliary-heap bound. Inspect every case and same-case A/A; aggregate wins cannot excuse repeatable ordinary-case losses. Small timing differences alone do not establish improvement. Any surviving candidate needs an independent, broader paired comparison under the same fixed block curve before being called accepted. Original sealed plot/data archives remain unchanged.

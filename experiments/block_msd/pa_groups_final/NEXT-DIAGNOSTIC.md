# Remaining ordinary-record gap

The completed final-guards-b64-s42 cell n1048576/B64/small8/uniform has a
Groups/Stable paired wall median of 1.271674, p10/p90 1.183081/1.416826,
12/12 slower, and thread-CPU median 1.271505. Pa A/A p10/p90 is
0.914850/1.003298. Pa and Band have similar elapsed time to Groups. This is a
remaining ordinary-input gap and blocks completion independently of later
cells. Finish the fixed seen-seed campaign, preserve all evidence, and leave
seed20261018 unseen. No source or parameter changes during this campaign.

After all formal timing finishes, diagnose the actual frozen small8 uniform
path: software cpu-clock sampling of Groups, full-type symbol lookup and
disassembly of its u32/Small scatter, compared with the corresponding u64
primitive scatter. Distinguish the whole-process sampling boundary from sort
phase time. Keep profiling input/oracle time out of formal performance rows.

If the frozen profile indicates distribution rather than leaf cost, a bounded
same-ELF diagnostic may compare Pa_unified_cache_toff with
Pa_unified_cache_t0 on small8 and representative ordinary controls, plus the
fixed Groups/Stable controls. The two cache methods differ only in the offline
activation threshold. Fixed-prefix P2 may provide work/pass context; it is not
an independent ablation of the combined candidate. No new threshold grid or
key-width external sorter dispatch is justified by this single cell.

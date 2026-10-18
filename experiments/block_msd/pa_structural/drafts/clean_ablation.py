from pathlib import Path
import re
b=Path('experiments/block_msd/src/frontier')
removed=['UnifiedPackedNarrowRuns','UnifiedPackedNarrow','UnifiedPackedRuns','UnifiedNarrow','UnifiedRuns']
p=b/'pa.rs';s=p.read_text()
a=s.index('    let carry_runs =');z=s.index('    let policy = Policy {',a)
s=s[:a]+'''    let sparse = match experiment {
        PaExperiment::UnifiedPacked => SparseCompletion::Packed,
        PaExperiment::UnifiedPackedAggressive => SparseCompletion::PackedAggressive,
        PaExperiment::UnifiedIdentity => SparseCompletion::Identity,
        _ => SparseCompletion::Recursive,
    };
    // Independent ablations inherit the complete frozen UnifiedGroups policy.
    let experiment = match experiment {
        PaExperiment::UnifiedIdentity | PaExperiment::UnifiedPacked | PaExperiment::UnifiedPackedAggressive => PaExperiment::UnifiedGroups,
        other => other,
    };
'''+s[z:]
for name in removed:s=s.replace('    '+name+',\n','')
s=s.replace('    carry_runs: bool,\n','').replace('    narrow_labels: bool,\n','').replace('        carry_runs,\n','').replace('        narrow_labels,\n','')
a=s.index('// A variation mask proves');z=s.index('fn partition_impl<',a);s=s[:a]+s[z:];s=s.replace('fn partition_impl<','fn partition<',1)
a=s.index('        if policy.carry_runs {');z=s.index('            let parent_len = arr.len();',a);s=s[:a]+s[z:]
z=s.index('    work! { stats.label_evals += label_evals.get(); }',a);s=s[:z].rstrip().removesuffix('}').rstrip()+'\n'+s[z:]
a=s.index('// Carry the first label');s=s[:a];p.write_text(s)
p=b/'tests.rs';s=p.read_text();a=s.index('#[test]\n#[cfg(feature = "frontier_work")]\nfn carried_boundaries_');z=s.index('#[test]\n#[cfg(feature="frontier_work")]\nfn bounded_projection_',a);s=s[:a]+s[z:]
s=s.replace('PaExperiment::UnifiedPackedNarrowRuns,','PaExperiment::UnifiedPacked,')
for name in removed:s=re.sub(r'^\s*PaExperiment::'+name+r',\n','',s,flags=re.M)
p.write_text(s)
p=b/'mod.rs';s=p.read_text().replace('    pub narrow_nodes: usize,\n','').replace('            narrow_nodes: 0,\n','');p.write_text(s)
p=b/'local_distribution.rs';s=p.read_text().replace('            narrow_nodes,\n','');p.write_text(s)
p=Path('experiments/block_msd/src/bin/frontier_experiment.rs');s=p.read_text()
a=s.index('        "Pa_narrow"\n');z=s.index('        | "Pa_ref"\n',a)
s=s[:a]+'        "Pa_packed_aggressive" | "Pa_packed" | "Pa_identity"\n'+s[z:]
for name in ['Pa_packed_narrow_runs','Pa_packed_narrow','Pa_packed_runs','Pa_narrow','Pa_runs']:
 s=re.sub(r'^\s*"'+name+r'",\n','',s,flags=re.M)
 s=re.sub(r'^\s*\| "'+name+r'"\n','',s,flags=re.M)
 s=re.sub(r'^\s*"'+name+r'" => [^,]+,\n','',s,flags=re.M)
s=s.replace('                stats.narrow_nodes.to_string(),\n','').replace('allocs,narrow_nodes,','allocs,');p.write_text(s)
for p in [b/'mod.rs',b/'pa.rs',b/'packed_projection.rs']:
 s=p.read_text().replace('PACKED','USE_COMPACT_RADIX');p.write_text(s)

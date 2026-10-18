from pathlib import Path
b=Path('experiments/block_msd/src/frontier')
p=b/'key_set.rs';p.write_text(Path('experiments/block_msd/pa_structural/drafts/key_set.rs.txt').read_text())
p=b/'mod.rs';s=p.read_text().replace('mod block;','mod block;\nmod key_set;',1).replace('    pub projection_nodes: usize,','    pub keyset_nodes: usize,\n    pub keyset_hits: usize,\n    pub projection_nodes: usize,',1).replace('            projection_nodes: 0,','            keyset_nodes: 0,\n            keyset_hits: 0,\n            projection_nodes: 0,',1);p.write_text(s)
p=b/'pa.rs';s=p.read_text().replace('    UnifiedPackedAggressive,','    UnifiedPackedAggressive,\n    UnifiedPackedKeySet,\n    UnifiedPackedKeySet8,\n    UnifiedPackedKeySetBinary,',1)
s=s.replace('#[derive(Clone, Copy)]\nstruct Policy', '''#[derive(Clone, Copy, PartialEq)]
enum KeySetMode {None,Fingerprint8,Fingerprint32,Binary32}

#[derive(Clone, Copy)]
struct Policy''',1).replace('    sparse: SparseCompletion,','    sparse: SparseCompletion,\n    keyset: KeySetMode,',1)
s=s.replace('    let sparse = match experiment {','''    let keyset = match experiment {
        PaExperiment::UnifiedPackedKeySet => KeySetMode::Fingerprint32,
        PaExperiment::UnifiedPackedKeySet8 => KeySetMode::Fingerprint8,
        PaExperiment::UnifiedPackedKeySetBinary => KeySetMode::Binary32,
        _ => KeySetMode::None,
    };
    let sparse = match experiment {''',1)
s=s.replace('        PaExperiment::UnifiedPacked => SparseCompletion::Packed,','''        PaExperiment::UnifiedPacked | PaExperiment::UnifiedPackedKeySet
        | PaExperiment::UnifiedPackedKeySet8 | PaExperiment::UnifiedPackedKeySetBinary => SparseCompletion::Packed,''',1)
s=s.replace('        | PaExperiment::UnifiedPackedAggressive => PaExperiment::UnifiedGroups,','''        | PaExperiment::UnifiedPackedAggressive | PaExperiment::UnifiedPackedKeySet
        | PaExperiment::UnifiedPackedKeySet8 | PaExperiment::UnifiedPackedKeySetBinary => PaExperiment::UnifiedGroups,''',1)
s=s.replace('        sparse,','        sparse,\n        keyset,',1)
needle='    if let Some((band, population, terminal_band)) = approved_band {'
insert='''    // A tiny exact alphabet captures correlations that varying coordinates
    // cannot compress. Keep the existing approved band and complete one-byte
    // projection; their classification is already cheap.
    if policy.keyset != KeySetMode::None && approved_band.is_none()
        && (heavy || depth == 0) && width > coarse
        && !packing.as_ref().map_or(false, |s|s.remaining==0 && s.bits<=8)
    {
        let complete=match policy.keyset {
            KeySetMode::Fingerprint8=>try_partition_keyset::<T,K,8,true>(arr,cap,policy,stats,depth,path),
            KeySetMode::Fingerprint32=>try_partition_keyset::<T,K,32,true>(arr,cap,policy,stats,depth,path),
            KeySetMode::Binary32=>try_partition_keyset::<T,K,32,false>(arr,cap,policy,stats,depth,path),
            KeySetMode::None=>false,
        };
        if complete {return;}
    }
'''
s=s.replace(needle,insert+needle,1)
s+='''
// The fixed dictionary and fingerprint table stay out of the visit frame.
// Rejected samples/coverage proofs leave the input untouched.
#[inline(never)]
fn try_partition_keyset<T:Radixable<K>,K:RadixKey,const N:usize,const F:bool>(
    arr:&mut [T],cap:usize,policy:Policy,stats:&mut Work,depth:usize,path:usize,
)->bool where Converted<T,K>:NativeKey {
    let approved=super::key_set::sample::<T,K,N,F>(arr,cap,stats)
        .and_then(|set|set.approve::<T,K>(arr,stats));
    let Some((set,covered))=approved else {return false;};
    work!{stats.keyset_nodes+=1;stats.keyset_hits+=covered;}
    let terminal=covered==arr.len();
    partition::<T,K,_>(arr,&set,Some(set.variation()),policy,terminal,stats,depth,path);
    true
}
''';p.write_text(s)
p=b/'local_distribution.rs';s=p.read_text().replace('            projection_nodes,','            keyset_nodes,\n            keyset_hits,\n            projection_nodes,',1);p.write_text(s)
p=b/'tests.rs';s=p.read_text()
import re
s=re.sub(r'(?m)^([ \t]*)PaExperiment::UnifiedIdentity,',lambda m: ''.join(m[1]+'PaExperiment::'+name+',\n' for name in ['UnifiedPackedKeySet','UnifiedPackedKeySet8','UnifiedPackedKeySetBinary'])+m[0],s)
s+=Path('experiments/block_msd/pa_structural/drafts/keyset_tests.rs.txt').read_text();p.write_text(s)
p=Path('experiments/block_msd/src/bin/frontier_experiment.rs');s=p.read_text().replace('    "Pa_packed_aggressive",','    "Pa_packed_keyset",\n    "Pa_packed_keyset8",\n    "Pa_packed_keyset_binary",\n    "Pa_packed_aggressive",',1)
s=s.replace('        "Pa_packed_aggressive"\n','        "Pa_packed_keyset" | "Pa_packed_keyset8" | "Pa_packed_keyset_binary" | "Pa_packed_aggressive"\n',2)
s=s.replace('                "Pa_packed_aggressive" => UnifiedPackedAggressive,','''                "Pa_packed_keyset" => UnifiedPackedKeySet,
                "Pa_packed_keyset8" => UnifiedPackedKeySet8,
                "Pa_packed_keyset_binary" => UnifiedPackedKeySetBinary,
                "Pa_packed_aggressive" => UnifiedPackedAggressive,''',1)
s=s.replace('                stats.projection_nodes.to_string(),','                stats.keyset_nodes.to_string(),\n                stats.keyset_hits.to_string(),\n                stats.projection_nodes.to_string(),',1)
s=s.replace('allocs,projection_nodes,','allocs,keyset_nodes,keyset_hits,projection_nodes,',1)
s=s.replace('    "few",','''    "few",
    "alphabet2",
    "alphabet4",
    "alphabet8",
    "alphabet16",
    "alphabet32",
    "alphabet64",
    "alphabet4_noise",
    "alphabet4_noise50",
    "alphabet4_noise90",''',1)
s=s.replace('    let mut keys: Vec<u128> = (0..n)', '''    let mut alphabet_state=seed^0x5e72_7c3a_901b_d845;
    let mut alphabet=[0u128;64];
    if case.starts_with("alphabet") {
        for i in 0..alphabet.len() {
            loop {
                let key=(((random(&mut alphabet_state) as u128)<<64)|random(&mut alphabet_state) as u128)&mask;
                if !alphabet[..i].contains(&key) {alphabet[i]=key;break;}
            }
        }
    }
    let mut keys: Vec<u128> = (0..n)''',1)
s=s.replace('                "equal" => mask / 3,','''                _ if case.starts_with("alphabet") => {
                    let count:usize=case[8..].split('_').next().unwrap().parse().unwrap();
                    assert!(count>0 && count<=alphabet.len());
                    let noise=if case.ends_with("noise50") {5} else if case.ends_with("noise90") {9} else if case.ends_with("_noise") {1} else {0};
                    if i%10<noise {r} else {alphabet[if i<count {i} else {r as usize%count}]}
                },
                "equal" => mask / 3,''',1)
s=s.replace('    #[test]\n    fn progressive_skew_has_distinct_complete_keys()', '''    #[test]
    fn alphabet_fixtures_have_exact_declared_cardinality() {
        for bits in [32,64,128] {
            for count in [2,4,8,16,32,64] {
                let mut keys=make_keys(8193,bits,&format!("alphabet{}",count),42);
                keys.sort_unstable();keys.dedup();assert_eq!(keys.len(),count);
            }
        }
    }

    #[test]
    fn progressive_skew_has_distinct_complete_keys()''',1);p.write_text(s)

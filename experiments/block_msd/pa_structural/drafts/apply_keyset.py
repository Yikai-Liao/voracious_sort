from pathlib import Path
base=Path('experiments/block_msd')
b=base/'src/frontier'
p=b/'key_set.rs';p.write_text((base/'pa_structural/drafts/key_set.rs.txt').read_text().replace('gaps.into_iter().all(|size|size<=n/2)','gaps.iter().all(|&size|size<=n/2)'))
p=b/'mod.rs';s=p.read_text().replace('mod block;','mod block;\nmod key_set;',1).replace('    pub narrow_nodes: usize,','    pub keyset_nodes: usize,\n    pub keyset_hits: usize,\n    pub narrow_nodes: usize,',1).replace('            narrow_nodes: 0,','            keyset_nodes: 0,\n            keyset_hits: 0,\n            narrow_nodes: 0,',1);p.write_text(s)
p=b/'pa.rs';s=p.read_text().replace('    UnifiedIdentity,','    UnifiedKeySet,\n    UnifiedPackedKeySet,\n    UnifiedIdentity,',1).replace('    narrow_labels: bool,','    narrow_labels: bool,\n    keyset: bool,',1)
s=s.replace('        PaExperiment::UnifiedPacked\n', '        PaExperiment::UnifiedPackedKeySet\n        | PaExperiment::UnifiedPacked\n',1)
s=s.replace('    // Independent ablations inherit', '    let keyset = matches!(experiment, PaExperiment::UnifiedKeySet | PaExperiment::UnifiedPackedKeySet);\n    // Independent ablations inherit',1)
s=s.replace('        PaExperiment::UnifiedIdentity\n', '        PaExperiment::UnifiedKeySet\n        | PaExperiment::UnifiedPackedKeySet\n        | PaExperiment::UnifiedIdentity\n',1)
s=s.replace('        narrow_labels,','        narrow_labels,\n        keyset,',1)
needle='    if let Some((band, population, terminal_band)) = approved_band {'
insert='''    // An exact small alphabet captures correlated wide keys that cannot be
    // reduced to a few varying bit coordinates. A complete one-byte projection
    // already has cheaper classification and keeps its current path.
    let approved_set = if policy.keyset && approved_band.is_none()
        && (heavy || depth == 0) && width > coarse
        && !packing.as_ref().map_or(false, |s| s.remaining == 0 && s.bits <= 8)
    {
        super::key_set::sample::<T,K>(arr,cap,stats)
            .and_then(|set|set.approve::<T,K>(arr,stats))
    } else { None };
'''
s=s.replace(needle,insert+needle,1)
s=s.replace('    } else if let Some(selection) = packing {','''    } else if let Some((set, covered)) = approved_set {
        work! { stats.keyset_nodes += 1; stats.keyset_hits += covered; }
        let terminal = covered == arr.len();
        partition::<T,K,_>(arr,&set,Some(set.variation()),policy,terminal,stats,depth,path);
    } else if let Some(selection) = packing {''',1);p.write_text(s)
p=b/'tests.rs';s=p.read_text().replace('PaExperiment::UnifiedPackedRuns,','PaExperiment::UnifiedPackedRuns,\n            PaExperiment::UnifiedKeySet,\n            PaExperiment::UnifiedPackedKeySet,');p.write_text(s)
p=b/'local_distribution.rs';s=p.read_text().replace('            narrow_nodes,','            keyset_nodes,\n            keyset_hits,\n            narrow_nodes,',1);p.write_text(s)
p=base/'src/bin/frontier_experiment.rs';s=p.read_text().replace('    "Pa_narrow",','    "Pa_keyset",\n    "Pa_packed_keyset",\n    "Pa_narrow",',1)
s=s.replace('        "Pa_identity"\n','        "Pa_keyset" | "Pa_packed_keyset" | "Pa_identity"\n',1)
s=s.replace('        "Pa_narrow"\n','        "Pa_keyset" | "Pa_packed_keyset" | "Pa_narrow"\n',1)
s=s.replace('                "Pa_narrow" => UnifiedNarrow,','                "Pa_keyset" => UnifiedKeySet,\n                "Pa_packed_keyset" => UnifiedPackedKeySet,\n                "Pa_narrow" => UnifiedNarrow,',1)
s=s.replace('                stats.narrow_nodes.to_string(),','                stats.keyset_nodes.to_string(),\n                stats.keyset_hits.to_string(),\n                stats.narrow_nodes.to_string(),',1)
s=s.replace('allocs,narrow_nodes,','allocs,keyset_nodes,keyset_hits,narrow_nodes,',1)
s=s.replace('    "few",','    "few",\n    "alphabet4",\n    "alphabet8",\n    "alphabet4_noise",\n    "alphabet4_noise50",\n    "alphabet4_noise90",',1)
s=s.replace('    let mut keys: Vec<u128> = (0..n)', '''    let mut alphabet_state = seed ^ 0x5e72_7c3a_901b_d845;
    let mut alphabet = [0u128;8];
    for key in &mut alphabet { *key = (((random(&mut alphabet_state) as u128)<<64) | random(&mut alphabet_state) as u128) & mask; }
    let mut keys: Vec<u128> = (0..n)''',1)
s=s.replace('                "equal" => mask / 3,','''                "alphabet4" | "alphabet8" | "alphabet4_noise" | "alphabet4_noise50" | "alphabet4_noise90" => {
                    let count=if case=="alphabet8" {8} else {4};
                    let noise=if case.ends_with("noise50") {5} else if case.ends_with("noise90") {9} else if case.ends_with("_noise") {1} else {0};
                    if i%10<noise { r }
                    else { alphabet[if i<count {i} else {r as usize % count}] }
                },
                "equal" => mask / 3,''',1)
p.write_text(s)

for p in [b/'mod.rs',b/'pa.rs',b/'packed_projection.rs',b/'key_set.rs']:
 s=p.read_text().replace('PACKED','USE_COMPACT_RADIX');p.write_text(s)
p=b/'tests.rs'
with p.open('a') as out:
 out.write('''
#[test]
fn bounded_key_sets_sort_correlated_wide_keys_and_outlier_gaps_stably() {
    let palette=[0u128,u128::MAX/9,u128::MAX/3,u128::MAX/2,u128::MAX*2/3,u128::MAX-1,u128::MAX];
    for count in [2usize,4,7] {
        for noise in [false,true] {
            let mut state=42;
            let input:Vec<Item>=(0..4097).map(|id| {
                let raw=((random(&mut state) as u128)<<64)|random(&mut state) as u128;
                let key=if noise && id%10==0 {raw} else {palette[id%count]};
                Item {key,id,payload:[id as u64,!id as u64,(id as u64).wrapping_mul(123456789)]}
            }).collect();
            let mut expected=input.clone();expected.sort_by_key(|x|x.key);
            for policy in [PaExperiment::UnifiedKeySet,PaExperiment::UnifiedPackedKeySet] {
                for block in [3,64,512] {
                    let mut actual=input.clone();
                    sort_pa_with_threshold::<_,u128>(&mut actual,policy,block,16*1024*1024);
                    assert!(actual.iter().zip(&expected).all(|(a,b)|a.key==b.key&&a.id==b.id&&a.payload==b.payload));
                }
            }
        }
    }
}

#[test]
#[cfg(feature="frontier_work")]
fn complete_key_set_consumes_correlated_information_without_recursion() {
    let palette=[0x1234567890abcdef_0123456789abcdefu128,0x87654321fedcba98_76543210abcdef01,0xdeadbeef98765432_1000200030004000,0x1111222233334444_9999aaaabbbbcccc];
    let n=65537;
    let mut state=42;
    let input:Vec<Item>=(0..n).map(|id|Item {key:palette[random(&mut state) as usize%4],id,payload:[id as u64;3]}).collect();
    let mut expected=input.clone();expected.sort_by_key(|x|x.key);
    for block in [3,64,512] {
        let mut actual=input.clone();
        let work=sort_pa_with_threshold::<_,u128>(&mut actual,PaExperiment::UnifiedPackedKeySet,block,16*1024*1024);
        assert_eq!(work.keyset_nodes,1);assert_eq!(work.keyset_hits,n);
        assert_eq!(work.scatter_records,n);assert_eq!(work.runs_records,0);assert_eq!(work.max_depth,0);
        assert!(actual.iter().zip(&expected).all(|(a,b)|a.key==b.key&&a.id==b.id&&a.payload==b.payload));
    }
}
'''.replace('u128::MAX*2/3','(u128::MAX/3)*2'))

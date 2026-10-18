from pathlib import Path
b=Path('experiments/block_msd/src/frontier')
p=b/'packed_projection.rs';s=p.read_text();a=s.index('    pub(super) fn new(variation:');z=s.index('\n}\n\npub(super) struct Packed',a)
legacy=s[a:z].replace('fn new(','fn aggressive(',1)
new='''    pub(super) fn new(variation: U, cap: usize, budget: usize) -> Option<Self> {
        let variation = variation & U::mask(cap);
        let q = variation.count_ones() as usize;
        let width = U::BITS - variation.leading_zeros() as usize;
        if q == 0 || q == width || budget == 0 { return None; }
        let raw = variation.to_u128();
        let low = width.saturating_sub(budget);
        let prefix = if low == 0 { raw } else { raw & !((1u128 << low)-1) };
        let active_bytes = |mask:u128| (0..U::BITS/8)
            .filter(|&byte|(mask>>(byte*8))&255!=0).count();
        // A complete tag must not add a whole-record pass over the ordinary
        // first node. Otherwise already-ordered children could make the extra
        // passes pure regression.
        let complete = q <= budget && q <= 32 && (q+7)/8 <= active_bytes(prefix);
        // Partial compression keeps exactly the ordinary prefix's partition.
        // Spending holes on lower bits changes fanout and can turn ordered
        // large runs into tens of thousands of costly small leaves.
        let selected = if complete { raw } else { prefix };
        let bits = selected.count_ones() as usize;
        if bits == 0 || bits > 32 || active_bytes(selected) <= (bits+7)/8 {
            return None;
        }
        Some(Self {
            mask:U::from_u128(selected), bits,
            remaining: if selected == raw { 0 } else { selected.trailing_zeros() as usize },
        })
    }

    // Diagnostic only: preserve the earlier cohort's information-budget
    // policy so work counters can reproduce its observed tiny-leaf regression.
'''
s=s[:a]+new+legacy+s[z:];p.write_text(s)
p=b/'pa.rs';s=p.read_text().replace('    UnifiedPacked,','    UnifiedPacked,\n    UnifiedPackedAggressive,',1).replace('    Packed,','    Packed,\n    PackedAggressive,',1)
s=s.replace('        PaExperiment::UnifiedIdentity => SparseCompletion::Identity,','        PaExperiment::UnifiedPackedAggressive => SparseCompletion::PackedAggressive,\n        PaExperiment::UnifiedIdentity => SparseCompletion::Identity,',1)
s=s.replace('        PaExperiment::UnifiedIdentity\n','        PaExperiment::UnifiedPackedAggressive\n        | PaExperiment::UnifiedIdentity\n',1)
s=s.replace('let packing = if policy.sparse == SparseCompletion::Packed','let packing = if matches!(policy.sparse, SparseCompletion::Packed | SparseCompletion::PackedAggressive)',1)
a=s.index('        super::packed_projection::Selection::new(');z=s.index('\n    } else {\n        None\n    };',a)
s=s[:a]+'''        if policy.sparse == SparseCompletion::PackedAggressive {
            super::packed_projection::Selection::aggressive(p.union ^ p.intersection,cap,8*bytes)
        } else {
            super::packed_projection::Selection::new(p.union ^ p.intersection,cap,8*bytes)
        }'''+s[z:];p.write_text(s)
p=Path('experiments/block_msd/src/bin/frontier_experiment.rs');s=p.read_text().replace('    "Pa_packed",','    "Pa_packed_aggressive",\n    "Pa_packed",',1).replace('        "Pa_identity"\n','        "Pa_packed_aggressive" | "Pa_identity"\n',1).replace('        | "Pa_packed"\n','        | "Pa_packed_aggressive" | "Pa_packed"\n',1).replace('                "Pa_packed" => UnifiedPacked,','                "Pa_packed_aggressive" => UnifiedPackedAggressive,\n                "Pa_packed" => UnifiedPacked,',1);p.write_text(s)
p=b/'packed_projection.rs'
with p.open('a') as out:out.write('''
#[cfg(test)]
mod bounded_tests {
    use super::*;
    #[test]
    fn partial_tags_keep_the_old_partition_and_never_add_a_root_pass() {
        assert!(Selection::<u32>::aggressive(0xff01ffff,32,24).is_some());
        assert!(Selection::<u32>::new(0xff01ffff,32,24).is_none());
        // A complete three-byte tag must not replace a one-byte root whose
        // already-ordered suffix could otherwise return without moving again.
        assert!(Selection::<u128>::new((0xfu128<<124)|((1<<20)-1),128,24).is_none());
        let mut state=42u128;
        for budget in [8usize,16,24,32] {
            for _ in 0..10000 {
                state=state.wrapping_mul(0xda942042e4dd58b5).wrapping_add(1);
                let variation=state ^ (state>>17);
                let Some(s)=Selection::<u128>::new(variation,128,budget) else {continue;};
                let width=128-variation.leading_zeros() as usize;
                let low=width.saturating_sub(budget);
                let prefix=if low==0 {variation} else {variation & !((1u128<<low)-1)};
                let passes=(0..16).filter(|&b|(prefix>>(8*b))&255!=0).count();
                assert!((s.bits+7)/8<=passes);
                if s.remaining>0 {assert_eq!(s.mask,prefix);}
                else {assert_eq!(s.mask,variation);}
            }
        }
    }
}
''')
p=b/'tests.rs'
with p.open('a') as out:out.write('''
#[test]
#[cfg(feature="frontier_work")]
fn bounded_projection_preserves_already_ordered_suffix_run_geometry() {
    let mut state=42;
    let input:Vec<Item>=(0..65537).map(|id| {
        let high=if id%10==0 {(random(&mut state)&255) as u128} else {0};
        Item {key:(high<<24)|id as u128,id,payload:[id as u64;3]}
    }).collect();
    let mut expected=input.clone();expected.sort_by_key(|x|x.key);
    for block in [64,512] {
        let mut old=input.clone();let mut bounded=input.clone();let mut aggressive=input.clone();
        let a=sort_pa_with_threshold::<_,u128>(&mut old,PaExperiment::UnifiedGroups,block,16*1024*1024);
        let b=sort_pa_with_threshold::<_,u128>(&mut bounded,PaExperiment::UnifiedPacked,block,16*1024*1024);
        let c=sort_pa_with_threshold::<_,u128>(&mut aggressive,PaExperiment::UnifiedPackedAggressive,block,16*1024*1024);
        assert_eq!(b.projection_nodes,0);
        assert_eq!(a.scatter_records,b.scatter_records);
        assert_eq!(a.prepare_records,b.prepare_records);
        assert_eq!(a.leaves,b.leaves);
        assert_eq!(a.leaf_lengths,b.leaf_lengths);
        assert!(c.leaves>a.leaves+1000);
        for actual in [old,bounded,aggressive] {assert!(actual.iter().zip(&expected).all(|(x,y)|x.key==y.key&&x.id==y.id&&x.payload==y.payload));}
    }
}
''')

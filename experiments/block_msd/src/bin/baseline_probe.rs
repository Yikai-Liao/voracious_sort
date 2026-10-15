pub use voracious_radix_sort::{RadixKey, Radixable};
mod algo {
    pub mod verge {
        include!("../../baseline_verge.rs");
    }
}
use std::cmp::Ordering;
#[derive(Clone, Copy, Debug)]
struct Record {
    key: u32,
    ordinal: u32,
}
impl PartialEq for Record {
    fn eq(&self, b: &Self) -> bool {
        self.key == b.key
    }
}
impl PartialOrd for Record {
    fn partial_cmp(&self, b: &Self) -> Option<Ordering> {
        self.key.partial_cmp(&b.key)
    }
}
impl Radixable<u32> for Record {
    type Key = u32;
    fn key(&self) -> u32 {
        self.key
    }
}
fn same(a: &[Record], b: &[Record]) -> bool {
    a.iter().zip(b).all(|(a, b)| a.key == b.key && a.ordinal == b.ordinal)
}
fn body_without_verge(a: &mut [Record], shift: usize) {
    if a.len() <= 128 {
        a.sort_by_key(|v| v.key);
        return;
    }
    let mut counts = [0usize; 256];
    for v in a.iter() {
        counts[((v.key >> shift) & 255) as usize] += 1;
    }
    let mut starts = [0usize; 256];
    for i in 1..256 {
        starts[i] = starts[i - 1] + counts[i - 1];
    }
    let mut heads = starts;
    let mut tmp = a.to_vec();
    for &v in a.iter() {
        let c = ((v.key >> shift) & 255) as usize;
        tmp[heads[c]] = v;
        heads[c] += 1;
    }
    a.copy_from_slice(&tmp);
    if shift > 0 {
        for c in 0..256 {
            if counts[c] > 1 {
                body_without_verge(
                    &mut a[starts[c]..starts[c] + counts[c]],
                    shift - 8,
                );
            }
        }
    }
}
fn main() {
    for n in 129..=4096 {
        let source: Vec<Record> = (0..n)
            .map(|i| Record { key: ((n - i) / 2) as u32, ordinal: i as u32 })
            .collect();
        let mut expected = source.clone();
        expected.sort_by_key(|v| v.key);
        let mut actual = source.clone();
        voracious_radix_sort::msd_stable_radixsort(&mut actual, 8);
        if !same(&actual, &expected) {
            let mut preprocess = source.clone();
            let separators = algo::verge::verge_sort_preprocessing(
                &mut preprocess,
                8,
                &|part: &mut [Record], _| part.sort_by_key(|v| v.key),
            );
            let mut direct = source.clone();
            body_without_verge(&mut direct, 24);
            assert!(same(&direct, &expected));
            let index = actual
                .iter()
                .zip(&expected)
                .position(|(a, b)| a.key != b.key || a.ordinal != b.ordinal)
                .unwrap();
            println!("first_failure_n={} mismatch={} actual={:?} expected={:?} separators={:?} preprocess_keys_sorted={} preprocess_identity_matches={} direct_body_matches=true",n,index,actual[index],expected[index],separators,preprocess.iter().zip(&expected).all(|(a,b)|a.key==b.key),same(&preprocess,&expected));
            return;
        }
    }
    println!("no failure within129..4096");
}

use std::{hint::black_box, time::{Duration, Instant}};
use voracious_radix_sort::{Radixable, RadixKey};
#[inline(never)]
fn old<T: Radixable<K>, K: RadixKey>(
    arr: &[T],
    first: <<T as Radixable<K>>::Key as RadixKey>::Key,
) -> Option<<<T as Radixable<K>>::Key as RadixKey>::Key> {
    let mut chunks = arr.chunks_exact(4);
    for chunk in &mut chunks {
        let mut equal = true;
        for offset in 0..4 {
            equal &= chunk[offset].into_key_type() == first;
        }
        if !equal {
            return chunk
                .iter()
                .map(|item| item.into_key_type())
                .find(|&key| key != first);
        }
    }
    chunks
        .remainder()
        .iter()
        .map(|item| item.into_key_type())
        .find(|&key| key != first)
}
#[inline(never)]
fn new<T: Radixable<K>, K: RadixKey>(
    arr: &[T],
    first: <<T as Radixable<K>>::Key as RadixKey>::Key,
) -> Option<<<T as Radixable<K>>::Key as RadixKey>::Key> {
    let mut chunks = arr.chunks_exact(4);
    for chunk in &mut chunks {
        let mut equal = true;
        for item in chunk {
            equal &= item.into_key_type() == first;
        }
        if !equal {
            return chunk
                .iter()
                .map(|item| item.into_key_type())
                .find(|&key| key != first);
        }
    }
    chunks
        .remainder()
        .iter()
        .map(|item| item.into_key_type())
        .find(|&key| key != first)
}
fn bench<T: Radixable<K>, K: RadixKey>(name: &str, input: &[T]) {
    let first = input[0].into_key_type();
    assert!(old::<T,K>(input, first) == new::<T,K>(input, first));
    for pair in 0..6 {
        for choice in if pair % 2 == 0 { [0,1] } else { [1,0] } {
            let start = Instant::now();
            let mut iterations=0;
            while start.elapsed() < Duration::from_millis(180) {
                if choice == 0 { black_box(old::<T,K>(black_box(input),black_box(first))); }
                else { black_box(new::<T,K>(black_box(input),black_box(first))); }
                iterations += 1;
            }
            println!("{{\"type\":\"{}\",\"pair\":{},\"variant\":{},\"ns\":{}}}", name,pair,choice,start.elapsed().as_nanos() as f64 / iterations as f64);
        }
    }
}
fn main() {
    bench::<u8,u8>("u8", &vec![42u8;1<<20]);
    bench::<u32,u32>("u32", &vec![42u32;1<<20]);
    bench::<u128,u128>("u128", &vec![42u128;1<<20]);
}

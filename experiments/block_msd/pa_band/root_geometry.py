#!/usr/bin/env python3
"""Explain root sample geometry; never used as a performance measurement."""
import argparse
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[2]

def function(source, name):
    start = source.index("fn " + name + "(")
    body = source.index("{", start)
    depth = 1
    end = body + 1
    while depth:
        depth += (source[end] == "{") - (source[end] == "}")
        end += 1
    return source[start:end]

def main():
    parser = argparse.ArgumentParser(__doc__)
    parser.add_argument("--out", default="root-geometry.csv")
    args = parser.parse_args()
    dest = ROOT / args.out
    if dest.exists():
        raise SystemExit(f"refusing to replace {dest}")
    ref = (ROOT / "source-commit.txt").read_text().strip()
    source = subprocess.check_output(["git", "show", f"{ref}:experiments/block_msd/src/bin/frontier_experiment.rs"], cwd=REPO, text=True)
    rust = "// Diagnostic only. Generator functions extracted verbatim from " + ref + ".\n"
    rust += function(source, "random") + "\n" + function(source, "make_keys") + "\n"
    rust += r'''fn main() {
    println!("n,bits,seed,case,width,ordinary_bits,band_low,skipped_bits,population,population_fraction,approved");
    for n in [262144usize, 1048576] {
        for bits in [64usize, 128] {
            for seed in [42u64, 7] {
                for case in ["deep_skew", "majority_prefix", "deep_unique90", "deep_unique98"] {
                    let arr = make_keys(n, bits, case, seed);
                    if case.starts_with("deep_unique") {
                        let reserved = ((usize::BITS as usize - (n - 1).leading_zeros() as usize + 7) / 8) * 8;
                        let mut seen = vec![false; n];
                        for key in &arr {
                            let id = (key & ((1u128 << reserved) - 1)) as usize;
                            assert!(id < n && !seen[id]);
                            seen[id] = true;
                        }
                    }
                    let mut sample = [0u128; 64];
                    let last = n - 1;
                    let mut ascending = true;
                    let mut descending = true;
                    let mut previous = arr[0];
                    for i in 0..64 {
                        let key = arr[i * (last / 63) + i * (last % 63) / 63];
                        ascending &= previous <= key;
                        descending &= previous >= key;
                        previous = key;
                        sample[i] = key;
                    }
                    let union = arr.iter().fold(0u128, |a, b| a | b);
                    let intersection = arr.iter().fold(u128::MAX, |a, b| a & b);
                    let width = 128 - (union ^ intersection).leading_zeros() as usize;
                    let coarse = ((usize::BITS as usize - (n - 1).leading_zeros() as usize + 7) / 8) * 8;
                    let pivot = *sample.select_nth_unstable(32).1;
                    for key in &mut sample { *key ^= pivot; }
                    let distance = *sample.select_nth_unstable(39).1;
                    let low = 128 - distance.leading_zeros() as usize;
                    let prefix = pivot >> low;
                    let population = arr.iter().filter(|key| **key >> low == prefix).count();
                    let sample_has_exit = sample.iter().any(|d| *d >> low != 0);
                    let approved = !ascending && !descending && bits - low > coarse && sample_has_exit && width.saturating_sub(low) > coarse.min(width) && population > n / 2;
                    println!("{n},{bits},{seed},{case},{width},{coarse},{low},{},{population},{:.9},{approved}", width.saturating_sub(low), population as f64 / n as f64);
                }
            }
        }
    }
}
'''
    source_path = ROOT / "root-geometry.rs"
    source_path.write_text(rust)
    executable = REPO / "experiments/block_msd/target/pa-band/root-geometry"
    subprocess.run(["/root/.cargo/bin/rustc", "--edition=2021", "-O", str(source_path), "-o", str(executable)], cwd=REPO, check=True)
    with dest.open("w") as out:
        subprocess.run([str(executable)], stdout=out, check=True)
    print(dest)

if __name__ == "__main__":
    main()

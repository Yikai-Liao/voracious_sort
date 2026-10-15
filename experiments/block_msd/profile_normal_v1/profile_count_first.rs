//! Focused native profile driver; fixture work is outside each sort timer.
use block_msd_research::count_first::block_msd_stable_radixsort;
use std::{
    cmp::Ordering,
    fs::File,
    io::{BufRead, BufReader, Write},
    os::fd::FromRawFd,
    time::Instant,
};
use voracious_radix_sort::{RadixKey, Radixable};

trait Identity {
    fn id(&self) -> Option<usize> {
        None
    }
    fn same(&self, other: &Self) -> bool;
}
impl Identity for u32 {
    fn same(&self, other: &Self) -> bool {
        self == other
    }
}
impl Identity for u64 {
    fn same(&self, other: &Self) -> bool {
        self == other
    }
}
impl Identity for u128 {
    fn same(&self, other: &Self) -> bool {
        self == other
    }
}
#[derive(Clone, Copy, Debug)]
struct Wide {
    key: u128,
    serial: u64,
    payload: [u64; 1],
}
impl PartialEq for Wide {
    fn eq(&self, other: &Self) -> bool {
        self.key == other.key
    }
}
impl PartialOrd for Wide {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        self.key.partial_cmp(&other.key)
    }
}
impl Radixable<u128> for Wide {
    type Key = u128;
    fn key(&self) -> u128 {
        self.key
    }
}
impl Identity for Wide {
    fn id(&self) -> Option<usize> {
        Some(self.serial as usize)
    }
    fn same(&self, other: &Self) -> bool {
        self.key == other.key
            && self.serial == other.serial
            && self.payload == other.payload
    }
}
#[derive(Clone, Copy, Debug)]
struct Large {
    key: u32,
    serial: u32,
    payload: [u64; 15],
}
impl PartialEq for Large {
    fn eq(&self, other: &Self) -> bool {
        self.key == other.key
    }
}
impl PartialOrd for Large {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        self.key.partial_cmp(&other.key)
    }
}
impl Radixable<u32> for Large {
    type Key = u32;
    fn key(&self) -> u32 {
        self.key
    }
}
impl Identity for Large {
    fn id(&self) -> Option<usize> {
        Some(self.serial as usize)
    }
    fn same(&self, other: &Self) -> bool {
        self.key == other.key
            && self.serial == other.serial
            && self.payload == other.payload
    }
}
// Optional perf control descriptors are inherited from the launching shell.
// Acknowledgements keep fixtures and verification outside recorded events.
struct PerfControl {
    control: File,
    acknowledgement: BufReader<File>,
}
impl PerfControl {
    fn from_env() -> Option<Self> {
        let control: i32 =
            std::env::var("MSD_PERF_CTL_FD").ok()?.parse().unwrap();
        let acknowledgement: i32 =
            std::env::var("MSD_PERF_ACK_FD").unwrap().parse().unwrap();
        assert!(
            control >= 3 && acknowledgement >= 3 && control != acknowledgement
        );
        Some(unsafe {
            Self {
                control: File::from_raw_fd(control),
                acknowledgement: BufReader::new(File::from_raw_fd(
                    acknowledgement,
                )),
            }
        })
    }
    fn command(&mut self, command: &[u8]) {
        self.control.write_all(command).unwrap();
        let mut line = String::new();
        self.acknowledgement.read_line(&mut line).unwrap();
        assert_eq!(
            line.trim_matches(|c: char| c == '\0' || c.is_ascii_whitespace()),
            "ack"
        );
    }
}
fn random(state: &mut u64) -> u64 {
    *state ^= *state << 13;
    *state ^= *state >> 7;
    *state ^= *state << 17;
    *state
}
fn run<T: Radixable<K> + Identity, K: RadixKey>(
    input: Vec<T>,
    name: &str,
    load: &str,
    repeats: usize,
    method: &str,
) {
    let mut expected = input.clone();
    expected.sort_by_key(|value| value.into_key_type());
    let mut times = Vec::with_capacity(repeats);
    let mut last = Default::default();
    let mut control = PerfControl::from_env();
    for _ in 0..repeats {
        let mut actual = input.clone();
        if let Some(control) = &mut control {
            control.command(b"enable\n");
        }
        let start = Instant::now();
        if method == "ordinary" {
            voracious_radix_sort::msd_radixsort(&mut actual, 8);
        } else {
            last = block_msd_stable_radixsort(&mut actual, 8, 64);
        }
        times.push(start.elapsed().as_nanos());
        if let Some(control) = &mut control {
            control.command(b"disable\n");
        }
        if method == "ordinary"
            && input.first().and_then(Identity::id).is_some()
        {
            let mut seen = vec![false; input.len()];
            for value in &actual {
                let id = value.id().unwrap();
                assert!(
                    id < input.len() && !seen[id] && value.same(&input[id])
                );
                seen[id] = true;
            }
        } else {
            assert!(actual.iter().zip(&expected).all(|(a, b)| a.same(b)));
        }
        assert!(actual
            .iter()
            .zip(&expected)
            .all(|(a, b)| a.into_key_type() == b.into_key_type()));
        std::hint::black_box(&actual);
    }
    times.sort_unstable();
    println!("method,type,load,n,repeats,median_sort_ns,nodes,peak_live_blocks,scratch_elements");
    println!(
        "{},{},{},{},{},{},{},{},{}",
        method,
        name,
        load,
        input.len(),
        repeats,
        times[times.len() / 2],
        last.nodes,
        last.peak_live_blocks,
        last.scratch_elements
    );
}
fn main() {
    let args: Vec<String> = std::env::args().collect();
    let name = args.get(1).map(String::as_str).unwrap_or("u32");
    let n: usize =
        args.get(2).map(|arg| arg.parse().unwrap()).unwrap_or(1048576);
    let repeats: usize =
        args.get(3).map(|arg| arg.parse().unwrap()).unwrap_or(20);
    let load = args.get(4).map(String::as_str).unwrap_or("uniform");
    let method = args.get(5).map(String::as_str).unwrap_or("endpoint");
    assert!(method == "endpoint" || method == "ordinary");
    assert!(n > 0 && n <= u32::MAX as usize && repeats > 0);
    let mut seed = 61789;
    let raw: Vec<u128> = (0..n)
        .map(|i| {
            let key =
                ((random(&mut seed) as u128) << 64) | random(&mut seed) as u128;
            match load {
                "uniform" => key,
                "skew95" => {
                    if i % 20 == 0 {
                        key
                    } else {
                        0
                    }
                },
                "shared_prefix" => {
                    (0xabcdef1234567890u128 << 64) | (key & 0xffffff)
                },
                _ => panic!("unknown load"),
            }
        })
        .collect();
    match name {
        "u32" => run::<u32, u32>(
            raw.iter().map(|&key| key as u32).collect(),
            name,
            load,
            repeats,
            method,
        ),
        "u64" => run::<u64, u64>(
            raw.iter().map(|&key| key as u64).collect(),
            name,
            load,
            repeats,
            method,
        ),
        "u128" => run::<u128, u128>(raw, name, load, repeats, method),
        "wide32" => run::<Wide, u128>(
            raw.iter()
                .enumerate()
                .map(|(i, &key)| Wide {
                    key,
                    serial: i as u64,
                    payload: [i as u64],
                })
                .collect(),
            name,
            load,
            repeats,
            method,
        ),
        "large128" => run::<Large, u32>(
            raw.iter()
                .enumerate()
                .map(|(i, &key)| Large {
                    key: key as u32,
                    serial: i as u32,
                    payload: [i as u64; 15],
                })
                .collect(),
            name,
            load,
            repeats,
            method,
        ),
        _ => panic!("unknown type"),
    }
}

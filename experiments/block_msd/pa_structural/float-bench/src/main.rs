// Reuse the frozen integer harness's method dispatch, timing boundary, A/A
// rotation, allocator and complete-record oracle. Its integer main is unused.
#[allow(dead_code)]
mod measured {
    include!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../../src/bin/frontier_experiment.rs"
    ));
    include!("floats.rs");
}

fn main() {
    measured::floats_main();
}

use std::{env, path::PathBuf, process::Command};
fn main() {
    let out = PathBuf::from(env::var_os("OUT_DIR").unwrap());
    let object = out.join("timsort_bridge.o");
    let archive = out.join("libpr_timsort.a");
    let mut cpp = Command::new("g++");
    cpp.args([
        "-O3",
        "-march=native",
        "-std=c++20",
        "-DNDEBUG",
        "-fPIC",
        "-Isource/cpp-timsort",
        "-c",
        "timsort_bridge.cpp",
        "-o",
    ])
    .arg(&object);
    if env::var_os("CARGO_FEATURE_TRACK_ALLOC").is_some() {
        cpp.arg("-DTRACK_ALLOC");
    }
    assert!(cpp.status().unwrap().success());
    assert!(Command::new("ar")
        .arg("crs")
        .arg(&archive)
        .arg(&object)
        .status()
        .unwrap()
        .success());
    println!("cargo:rustc-link-search=native={}", out.display());
    println!("cargo:rustc-link-lib=static=pr_timsort");
    println!("cargo:rustc-link-lib=dylib=stdc++");
    println!("cargo:rerun-if-changed=timsort_bridge.cpp");
    println!("cargo:rerun-if-changed=source/cpp-timsort/gfx/timsort.hpp");
}

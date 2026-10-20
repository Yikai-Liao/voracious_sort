use std::{env, path::PathBuf, process::Command};
fn main() {
    println!("cargo:rerun-if-env-changed=RADSORT_SOURCE");
    println!("cargo:rerun-if-env-changed=CC");
    let source = PathBuf::from(env::var_os("RADSORT_SOURCE").expect(
        "set RADSORT_SOURCE to the pinned clausecker/radsort checkout",
    ));
    let out = PathBuf::from(env::var_os("OUT_DIR").unwrap());
    let cc = env::var("CC").unwrap_or_else(|_| "cc".into());
    // Include the original source unchanged; expose its exact requested heap
    // size for the memory comparison without instrumenting the timed C sort.
    let original = source.join("radixsort_permuted.c").canonicalize().unwrap();
    let original_path =
        original.to_str().unwrap().replace('\\', "\\\\").replace('"', "\\\"");
    let wrapper = out.join("original.c");
    std::fs::write(&wrapper, format!(
        "#include \"{}\"\nsize_t benchmark_c_heap_bytes(size_t n) {{\nreturn n ? sizeof(struct sorter) + NPERM(n) * (2*sizeof(unsigned) + sizeof(unsigned char)) : 0;\n}}\n",
        original_path)).unwrap();
    println!("cargo:rerun-if-changed={}", original.display());
    for (name, file) in
        [("original", wrapper), ("stub", PathBuf::from("stub.c"))]
    {
        println!("cargo:rerun-if-changed={}", file.display());
        let status = Command::new(&cc)
            .args(["-O3", "-march=native", "-DNDEBUG", "-c"])
            .arg(file)
            .arg("-o")
            .arg(out.join(format!("{}.o", name)))
            .status()
            .unwrap();
        assert!(status.success(), "C compiler failed");
    }
    let status = Command::new("ar")
        .arg("crs")
        .arg(out.join("libradsort.a"))
        .arg(out.join("original.o"))
        .arg(out.join("stub.o"))
        .status()
        .unwrap();
    assert!(status.success());
    println!("cargo:rustc-link-search=native={}", out.display());
    println!("cargo:rustc-link-lib=static=radsort");
}

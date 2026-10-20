use std::{env, path::PathBuf, process::Command};
fn main() {
    println!("cargo:rerun-if-env-changed=RADSORT_SOURCE");
    let source = PathBuf::from(
        env::var_os("RADSORT_SOURCE")
            .expect("set RADSORT_SOURCE to the pinned radsort checkout"),
    );
    let out = PathBuf::from(env::var_os("OUT_DIR").unwrap());
    for (name, source_file) in [
        ("parallel", "radixsort_parallel.c"),
        ("permuted", "radixsort_permuted.c"),
    ] {
        let path = source.join(source_file).canonicalize().unwrap();
        println!("cargo:rerun-if-changed={}", path.display());
        let status = Command::new("cc")
            .args(["-O3", "-march=native", "-DNDEBUG", "-fopenmp", "-c"])
            .arg(path)
            .arg("-o")
            .arg(out.join(format!("{}.o", name)))
            .status()
            .unwrap();
        assert!(status.success());
    }
    let stub = out.join("stub.c");
    std::fs::write(&stub, "#define _GNU_SOURCE\n#include <sched.h>\n#include <omp.h>\nint always_supported(void) { return 1; }\nvoid benchmark_omp_cpus(int *cpus) {\n#pragma omp parallel\n { cpus[omp_get_thread_num()] = sched_getcpu(); }\n}\n")
        .unwrap();
    assert!(Command::new("cc")
        .args(["-fopenmp", "-c"])
        .arg(&stub)
        .arg("-o")
        .arg(out.join("stub.o"))
        .status()
        .unwrap()
        .success());
    assert!(Command::new("ar")
        .arg("crs")
        .arg(out.join("libradsort.a"))
        .args([
            out.join("parallel.o"),
            out.join("permuted.o"),
            out.join("stub.o")
        ])
        .status()
        .unwrap()
        .success());
    println!("cargo:rustc-link-search=native={}", out.display());
    println!("cargo:rustc-link-lib=static=radsort");
    println!("cargo:rustc-link-lib=gomp");
}

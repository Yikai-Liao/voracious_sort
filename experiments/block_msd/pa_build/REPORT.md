# 开发构建缓存与布局约束

源码e9e8004撤回了失败的fixed/preload/combined三个散射变体。release在同一target目录启用增量并固定16个codegen units；命令明确`--jobs 6`。`frontier_narrow_screen`只限制benchmark harness编译u8/u16原生与ID四个布局，排序库保持统一路径。完整验收仍需不带该feature的全布局构建。

首次建立该配置的缓存用时1m37s；同一源码、feature、target和flags原样重建0.04s，日志标记两个crate为Fresh。0.04s仅证明无改动产物缓存命中，不表示编辑热循环后的增量耗时。首次构建与上一轮全布局/三候选的10m56s同时改变了源码和布局，不能把全部差值归因于缓存。日志含实际`-C incremental`及codegen-units=16。

24条n513/B17/seed42、四布局×uniform/sparse×Pa/prepared/Stable的完整oracle冒烟通过；拒绝wide32参数的101是harness显式断言预期结果。生成器1项测试及all-targets/all-features检查通过。oracle-smoke.csv属于诊断输出，不纳入Goal时间矩阵。未运行新的性能候选、work/heap或ASan。

源码清单及source-commit.txt固定来源；build-evidence.json记录当时ELF hash而不冻结可变的Cargo输出路径。历史正式time ELF均未覆盖。只删除一份已被新harness取代、且逐字节hash等于pa_scatter冻结ELF的旧Cargo可执行副本，保留增量缓存及冻结ELF。

复核时读取两份build日志、build-evidence.json和两个check/test日志。复用缓存的命令：

```sh
CARGO_INCREMENTAL=1 RUSTFLAGS='-C target-cpu=native' cargo build \
  --manifest-path experiments/block_msd/Cargo.toml --release --jobs 6 \
  --bin frontier_experiment --features frontier_narrow_screen --timings -v
```

当前工作树后续有真实编辑时该命令会重编必要部分。不得用旧日志替代新的构建耗时，也不在正式排序计时期间构建。

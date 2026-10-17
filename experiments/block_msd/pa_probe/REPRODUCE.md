# 复现

工作树：`/root/code/voracious_sort-pa-unified`，分支 `block-pa-unified`。
本轮冻结时间／工作量 ELF 在 `experiments/block_msd/target/pa-probe/`，未跟踪构建产物。
源码、Cargo 文件和两个 ELF 分别列于 `source-sha256.txt` 与 `binary-sha256.txt`。
第一轮独立改动属于提交 `333bce8`，它的 source ledger 应在该提交验证。
不要用第二轮源码去验证第一轮源码快照。源码提交只含Rust变更，下面从当前证据工作树复制脚本和报告到新工作树。

在新工作树构建本轮源码（避免覆盖已测 ELF）：

```bash
git worktree add --detach /root/code/voracious_sort-pa-reproduce c13f5d3079a5034ac3eb37f1c3ed421da542cf33
cp -a /root/code/voracious_sort-pa-unified/experiments/block_msd/pa_probe /root/code/voracious_sort-pa-reproduce/experiments/block_msd/
cd /root/code/voracious_sort-pa-reproduce
mkdir -p experiments/block_msd/target/pa-probe
RUSTFLAGS='-C target-cpu=native' /root/.cargo/bin/cargo build \
  --manifest-path experiments/block_msd/Cargo.toml --release --bin frontier_experiment
cp experiments/block_msd/target/release/frontier_experiment experiments/block_msd/target/pa-probe/time
RUSTFLAGS='-C target-cpu=native' /root/.cargo/bin/cargo build \
  --manifest-path experiments/block_msd/Cargo.toml --release --bin frontier_experiment --features frontier_work
cp experiments/block_msd/target/release/frontier_experiment experiments/block_msd/target/pa-probe/work
```

Rust 1.98.1；release opt-level=3、debug=true、无 LTO。构建和测试全部完成后再计时。
`run.py` 不覆盖同名测量；新运行必须使用新名字。示例：

```bash
python3 experiments/block_msd/pa_probe/run.py rerun-seed42 \
  --n 1048576 --reps 12 --seed 42 \
  --methods Pa,Pa_terminal,Pa_core3,Pa_probe3,L_frozen,stable_msd,Pa \
  --layouts u8,u16,u32,u64,u128,u8_id8,u16_id8,small8,wide32,large128 \
  --cases uniform,deep_skew,majority_prefix,sparse,sorted,equal,reverse
python3 experiments/block_msd/pa_probe/analyze.py \
  experiments/block_msd/pa_probe/measurements/rerun-seed42.csv --out rerun-summary.csv
python3 experiments/block_msd/pa_probe/noise.py \
  experiments/block_msd/pa_probe/measurements/rerun-seed42.csv
```

`--kind work` 使用独立插桩 ELF，`--kind memory` 使用时间版 ELF 的分配测量模式，
均与正式计时分开运行。`--block 512` 改变空间配置，应单独汇总。
每个正式 CSV 的 JSON 保存实际命令、时刻、load／memory 前后快照和 child rusage。
不要合并具有相同 seed/n/B/rep 的独立运行后按键配对；本报告逐文件汇总。

已有本轮 ELF 和原始文件可用时，运行 `python3 experiments/block_msd/pa_probe/validate.py`
验证 source／binary hash、完成状态、所有 slot／rep、输入地址复用及叶子直方图。
新工作树重新构建的 ELF 路径／调试信息可能不同，先为新实验记录自己的 hash；
不要改写已测快照的 ledger。测量文件和脚本／报告另有 evidence ledger。

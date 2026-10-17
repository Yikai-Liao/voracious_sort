# 复现前缀区间实验

工作树 `/root/code/voracious_sort-pa-unified`，分支 `block-pa-unified`。本轮源码提交由 `source-commit.txt` 固定，源码及 Cargo 文件见 `source-sha256.txt`。已测 ELF 在 `experiments/block_msd/target/pa-band/{time,work}`，不跟踪构建产物，hash 见 `binary-sha256.txt`。上一轮 `pa_probe` 使用 c13f5d3 的源码和自己的 ELF；不要覆盖旧实验。

在新工作树构建，避免覆盖测过的二进制：

```bash
band_source=$(cat experiments/block_msd/pa_band/source-commit.txt)
git worktree add --detach /root/code/voracious_sort-pa-band-reproduce "$band_source"
cp -a /root/code/voracious_sort-pa-unified/experiments/block_msd/pa_band /root/code/voracious_sort-pa-band-reproduce/experiments/block_msd/
cd /root/code/voracious_sort-pa-band-reproduce
mkdir -p experiments/block_msd/target/pa-band
RUSTFLAGS='-C target-cpu=native' /root/.cargo/bin/cargo build \
  --manifest-path experiments/block_msd/Cargo.toml --release --bin frontier_experiment
cp experiments/block_msd/target/release/frontier_experiment experiments/block_msd/target/pa-band/time
RUSTFLAGS='-C target-cpu=native' /root/.cargo/bin/cargo build \
  --manifest-path experiments/block_msd/Cargo.toml --release --bin frontier_experiment --features frontier_work
cp experiments/block_msd/target/release/frontier_experiment experiments/block_msd/target/pa-band/work
```

Rust 1.98.1，release opt-level=3、debug=true、无 LTO。新工作树 ELF 的路径／调试信息可能不同，应记录新的 hash，不改旧 ledger。源码提交只包含 Rust 改动；测量脚本及报告在后续证据提交中，可从本实验目录复制到新工作树。

验证命令（先完成全部构建／测试，再计时）：

```bash
RUSTFLAGS='-C target-cpu=native' /root/.cargo/bin/cargo test \
  --manifest-path experiments/block_msd/Cargo.toml --lib --features frontier_work frontier::
RUSTFLAGS='-C target-cpu=native' /root/.cargo/bin/cargo test \
  --manifest-path experiments/block_msd/Cargo.toml --release --lib --features frontier_work frontier::
RUSTFLAGS='-C target-cpu=native' /root/.cargo/bin/cargo test \
  --manifest-path experiments/block_msd/Cargo.toml --bin frontier_experiment workload_tests
RUSTFLAGS='-Zsanitizer=address -C target-cpu=native' \
  CARGO_TARGET_DIR=experiments/block_msd/target/pa-asan /root/.cargo/bin/cargo +nightly test \
  --manifest-path experiments/block_msd/Cargo.toml --target x86_64-unknown-linux-gnu \
  --lib --features frontier_work frontier::
/root/.cargo/bin/cargo check --manifest-path experiments/block_msd/Cargo.toml --all-targets --all-features
```

正式执行的精确命令都在每个测量文件同名 JSON 中。以下示例不会覆盖现有记录，`run.py` 拒绝同名输出：

```bash
python3 experiments/block_msd/pa_band/run.py rerun-shared \
  --n 1048576 --reps 12 --seed 42 --layouts u64,u128,wide32 \
  --cases uniform,deep_skew,majority_prefix,deep_unique90,deep_unique98
python3 experiments/block_msd/pa_band/analyze.py \
  experiments/block_msd/pa_band/measurements/rerun-shared.csv --out rerun-summary.csv
python3 experiments/block_msd/pa_band/noise.py \
  experiments/block_msd/pa_band/measurements/rerun-shared.csv
```

`--kind work --reps 1` 使用独立计数 ELF；`--kind memory --reps 1` 使用时间 ELF 的请求堆计量模式，均单独运行。`--block 512` 单独汇总。除新 `deep_unique90/98` 外，默认包含旧 12 种输入。全异输入应显式选用容量足够的键宽，百万条不能配 u8/u16。

原始 CSV 每行排序后都通过稳定 oracle，包含完整键、身份与 payload。输入恢复、生成与 oracle 排除在计时外；工作区分配释放包含在内。Pa 固定首尾重复，其他方法轮转并反向；`noise.py` 按固定 slot 计算 A/A，`analyze.py` 同 rep 的两个 Pa 均值为分母。不要把 seed/n/B/rep 相同的独立文件合并后配对。

`python3 experiments/block_msd/pa_band/validate.py` 核验 frozen source／binary、完成状态、行数、slot/rep、地址复用、叶子直方图。全部证据文件另以 `evidence-sha256.txt` 固定，从仓库根运行 `sha256sum -c experiments/block_msd/pa_band/evidence-sha256.txt`。分位数不是置信区间；宿主非独占，环境快照与所有离群值保留。

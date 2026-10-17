# u16 覆盖补测与 Pa 后续基线

父实验提交 `7d91e8c`。本补测只在 runner 增加纯 u16 和 u16 key＋u32 身份
（8-byte record），排序算法没有改动。六种原布局已经包含 u64；本次补齐 u16，
并用同一新 ELF 对四种原生 key 宽度做 seed=42 复核。
原实验完整报告见 [前缀／前沿第一轮](../frontier/REPORT.md)。

## 百万条 u16

B=64、12 次重复、墙钟中位数，单位 ms。

| 布局 / 输入 | Pa | Fa | 冻结 Block LSD | Stable MSD |
|---|---:|---:|---:|---:|
| u16 / uniform | 9.414 | 25.782 | 6.176 | 6.976 |
| u16 / deep_skew | 9.078 | 36.122 | 7.229 | 8.587 |
| u16 / majority_prefix | 9.778 | 44.464 | 7.470 | 7.875 |
| u16 / sparse | 6.468 | 38.827 | 4.323 | 3.747 |
| u16 / sorted | 0.157 | 5.193 | 0.262 | 0.755 |
| u16 / equal | 0.142 | 3.470 | 0.698 | 0.538 |
| u16_id8 / uniform | 14.329 | 30.368 | 11.223 | 15.811 |
| u16_id8 / deep_skew | 10.817 | 32.044 | 8.707 | 13.486 |
| u16_id8 / majority_prefix | 14.060 | 42.871 | 10.353 | 15.349 |
| u16_id8 / sparse | 7.025 | 37.110 | 4.784 | 6.029 |
| u16_id8 / sorted | 0.845 | 3.910 | 1.893 | 1.287 |
| u16_id8 / equal | 0.884 | 3.888 | 1.019 | 1.103 |

Pa 在纯 u16 的随机输入上约比 Stable MSD 慢 35%；带身份的 8B 记录则约快 9%，
后者仍需结合噪声解释。故原“36/36 中位数低于 Stable MSD”仅描述先前百万条、
B=64 的六布局主矩阵，补齐 u16 后不能再扩展为所有 key 宽度均领先。

当前 Pa 在完整 key 已消费完时仍走前缀编号和分组区间扫描；L 可直接终结。
这是消除额外开销的明确候选，尚无分阶段时间归因，不将全部差额都归给它。
Fa 在这些 u16 组合上没有显示出收益。

## 同 ELF、新种子的宽度复核

百万条、B=64、seed=42、12 次重复。纯 key 的均匀输入如下，单位 ms。

| key | Pa | Fa | 冻结 Block LSD | Stable MSD |
|---|---:|---:|---:|---:|
| u16 | 9.947 | 31.932 | 6.481 | 7.343 |
| u32 | 15.951 | 48.369 | 13.734 | 22.561 |
| u64 | 25.552 | 61.263 | 55.414 | 27.825 |
| u128 | 45.741 | 89.042 | 144.470 | 52.133 |

完整结果也包括 deep_skew、majority_prefix 和 sparse；没有仅保留有利输入。
Pa 仍应保留为强候选。其两个后续方向分别是消除准备／编号／终结开销，以及改善
重桶上的重复分布和 compact；[后续设计边界](NEXT.md) 记录未实现的偏斜思路。

## 空间与口径

百万条均匀输入的 requested heap peak：

| 布局 | Pa / Fa / 冻结 LSD bytes | Stable MSD bytes |
|---|---:|---:|
| u16 | 229888 | 2122122 |
| u16_id8 | 426496 | 8439264 |

空间测量不含输入、参考与恢复副本、栈、allocator 保留量和 RSS。分配次数也在原始 CSV。
本次没有为提高速度放宽 Pa 工作区准入预算。

u16 的两种布局各覆盖 12 种原输入，n=16,384 / 262,144 / 1,048,576，
每档 12 次重复。方法表为 L、冻结 LSD、Pa、Fa、F1、Stable MSD、L；两次 L 提供 A/A。
每次 warmup 和计时样本都核对完整 oracle；u16_id8 对每条记录的稳定身份逐项比较。
原新增实验的 debug、release+计数、ASan 各 7 项专项测试仍见父实验；
本次只增加 runner 布局，没有新增排序逻辑。

全部计时在 release 构建完成后开始，固定 guest CPU 2、单 worker，
Rust 1.98.1、`-C target-cpu=native`。仍是相同 KVM 机器；不能保证宿主独占或固定频率。
本次各 child rusage 的 major fault 为零，但 A/A 仍有明显波动：

| 组 | A/A 中位比 | p10–p90 |
|---|---:|---:|
| u16-16384 | 1.003 | 0.806–1.227 |
| u16-262144 | 1.006 | 0.916–1.193 |
| u16-1048576 | 1.010 | 0.817–1.301 |
| widths-seed42 | 0.995 | 0.859–1.161 |

这是跨输入的描述性范围；分输入分位数和配对比保存在 noise / summary CSV，不能把该范围
当作单项置信区间，也不能把小幅中位数领先当成已证明的稳定收益。

## 复现

此处 source / binary ledger 对应增加 u16 布局后的 ELF；父实验 ledger 对应父提交，
可在 `/root/code/voracious_sort-prefix-frontier` 独立验证，原始记录没有覆盖。

```bash
RUSTFLAGS='-C target-cpu=native' /root/.cargo/bin/cargo build --release \
  --manifest-path experiments/block_msd/Cargo.toml --bin frontier_experiment
mkdir -p experiments/block_msd/target/frontier
cp experiments/block_msd/target/release/frontier_experiment experiments/block_msd/target/frontier/time
python3 experiments/block_msd/u16/run.py replay-u16 --n 1048576 --reps 12
python3 experiments/block_msd/u16/analyze.py \
  experiments/block_msd/u16/measurements/replay-u16.csv --out summary-replay.csv
python3 experiments/block_msd/u16/validate.py
```

run.py 拒绝覆盖已有名字；measurements/*.json 记录每次完整命令、资源快照及 child rusage。
[validation/ledger.log](validation/ledger.log) 核对全部 7,560 行、方法 slot、输入地址和摘要。

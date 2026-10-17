# 串行 Block MSD/LSD 前缀与前沿：第一轮 native 筛选

本轮把修订方案的 L/H/P/F 做成了隔离的 Rust 原型，并加入冻结 Block LSD、
Stable MSD 和既有 Block MSD 参照。结果支持保留两个有明确边界的方向：
宽 key 均匀输入上的直接前缀，以及存在完整多数 key 时的长路径出口编号。
百万条、B=64 主矩阵中，Pa 的 36 项中位数全部低于 Stable MSD；Fa 为 16/36 项。
Pa 在小规模有序／全等／逆序宽 key，以及 B=512 的部分场景仍有回退，
因此跨规模和配置的全面领先尚未成立。没有把组合选择器加入主库。

实验基点为 `34080cf0fb95355411e029046e026b5aa65fb68c`，工作分支
`block-prefix-frontier`。主库排序入口、冻结参照均未改动。
[实现与契约](IMPLEMENTATION.md)、[原始方案](PLAN.md)、[运行环境](environment.json)
分别记录算法、来源和机器条件。

## 百万条主矩阵

以下为 1,048,576 条、B=64、8 次重复的墙钟中位数，单位 ms，越小越好。
`wide32` 是 **128-bit key、32-byte record**；`large128` 是
**u32 key、128-byte record**。这里的“深偏斜”有约 90% 的完整 key 等于零；
“多数前缀”仅让约 90% 的 key 共享高半部，保留不同完整 key。

| 布局 / 输入 | 冻结 Block LSD | Stable MSD | 既有 Block MSD | Pa | Fa | F1 |
|---|---:|---:|---:|---:|---:|---:|
| u32 / 均匀 | 13.63 | 20.34 | 26.50 | 18.56 | 43.61 | 97.20 |
| u32 / 深偏斜 | 13.08 | 18.76 | 24.34 | 16.23 | 43.79 | 21.53 |
| wide32 / 均匀 | 182.86 | 72.47 | 60.82 | 65.93 | 94.42 | 154.56 |
| wide32 / 深偏斜 | 107.85 | 464.39 | 366.26 | 244.87 | 58.64 | 41.39 |
| wide32 / 多数前缀 | 175.41 | 280.42 | 127.38 | 105.32 | 146.75 | 160.57 |
| wide32 / 稀疏位 | 88.64 | 245.42 | 121.10 | 145.19 | 243.23 | 221.55 |
| wide32 / 公共高位 | 44.37 | 452.99 | 56.12 | 66.72 | 97.05 | 145.29 |
| wide32 / 多重群 | 42.22 | 378.63 | 58.19 | 63.95 | 120.80 | 130.11 |
| large128 / 均匀 | 177.79 | 220.21 | 136.97 | 169.66 | 181.86 | 250.14 |
| large128 / 深偏斜 | 117.62 | 471.13 | 245.22 | 196.07 | 135.22 | 100.16 |
| large128 / 多数前缀 | 151.99 | 371.64 | 227.16 | 171.47 | 201.46 | 236.64 |

完整 36 个布局／输入组合及其他配置见 [summary-main.csv](summary-main.csv)。
Pa 在宽 key 均匀输入上明显胜过 Block LSD，但没有超过既有 Block MSD；
与 Stable MSD 的约 9% 差距也需结合噪声看待。F1 在宽 key 深偏斜上约为
Block LSD 的 0.38 倍耗时，且明显快于两个 MSD 参照。其余输入中，尤其窄 key，
F 的准备与分类成本经常抵消少做 scatter 的收益。

这里的 Stable MSD 是仓库 `stable_baseline` 的稳定版本，包含既有的降序等值组修复；
既有 Block MSD 是 `two_arrays_scratch_paths`。它们分别回答常规稳定 MSD 和已有低空间
MSD 的比较问题。Stable MSD 的递归 buffer 开销另列，不能把它当作等空间配置。

## 新种子与 B=512 复核

新 seed=42（B=64）和原 seed 的 B=512 各做 12 次重复，未修改源码或调参。
其中 deep_skew 的新 seed 改变输入排列，完整 key 多重集不变。以下仍为 ms 中位数。

| 复核 / 布局 / 输入 | 冻结 LSD | Stable MSD | Pa | Fa | F1 |
|---|---:|---:|---:|---:|---:|
| 新 seed / u32 / uniform | 12.92 | 21.06 | 16.66 | 47.50 | 93.47 |
| 新 seed / wide32 / uniform | 197.99 | 73.99 | 67.02 | 91.43 | 157.05 |
| 新 seed / wide32 / deep_skew | 113.70 | 460.65 | 240.22 | 60.94 | 39.89 |
| 新 seed / wide32 / majority_prefix | 167.68 | 277.05 | 138.32 | 131.04 | 157.24 |
| 新 seed / large128 / uniform | 176.65 | 217.75 | 176.07 | 192.70 | 251.19 |
| B=512 / u32 / uniform | 13.14 | 21.50 | 14.56 | 43.60 | 92.94 |
| B=512 / wide32 / uniform | 256.52 | 73.43 | 70.26 | 95.02 | 158.64 |
| B=512 / wide32 / deep_skew | 106.18 | 457.54 | 225.51 | 55.81 | 38.77 |
| B=512 / wide32 / majority_prefix | 193.96 | 273.61 | 115.70 | 142.19 | 167.80 |
| B=512 / large128 / uniform | 280.74 | 221.37 | 255.72 | 266.62 | 283.80 |

新 seed 保留宽 key 均匀／完整多数 key 的主要趋势，但多数前缀的 Pa/Fa 排名反转。
B=512 的 large128 均匀输入上，Pa/Fa 都慢于 Stable MSD，不能用 B=64 的结果外推。
B=512 同时改变 scratch 和普通 LSD 准入预算；它是另一组空间配置，不作为等峰值配对。
其独立堆测量见 [memory-block512.csv](measurements/memory-block512.csv)。


## 少做了什么，额外支付了什么

以下工作量来自独立插桩 ELF，未混入上述计时。n=1,048,576，wide32，B=64。
scatter 仅统计 radix 写入；compact 包含记录槽位整理，比较叶子的移动未计入 scatter。
“未解决”是所有节点待递归记录数之和，同一条记录可能重复计数。

| 输入 / 方法 | scatter / n | compact / n | label 调用 / n | 未解决 / n | 比较叶子记录 / n |
|---|---:|---:|---:|---:|---:|
| 均匀 / L | 16.000 | 1.938 | 17.000 | 0 | 0 |
| 均匀 / H1 | 16.000 | 2.992 | 20.000 | 1.000 | 0 |
| 均匀 / Pa=P3 | 3.000 | 1.937 | 5.970 | 0.060 | 0.060 |
| 均匀 / Fa | 3.000 | 1.958 | 5.940 | 0.118 | 0.118 |
| 均匀 / F1 | 2.000 | 2.996 | 7.017 | 2.000 | 1.000 |
| 深偏斜 / L | 16.000 | 1.959 | 17.000 | 0 | 0 |
| 深偏斜 / Pa | 15.344 | 11.013 | 26.781 | 4.813 | 0 |
| 深偏斜 / F1 | 1.000 | 1.997 | 3.000 | 0.098 | 0 |
| 深偏斜 / Fa | 3.000 | 1.966 | 5.000 | 0.098 | 0 |

Pa 在百万均匀输入选择三个字节，和固定 P3 一样；31,305 个非单例叶子、63,269 条
叶子记录符合 24-bit 前缀碰撞规模。Fa 采用 23-bit 粗前缀并编码路径出口，
仍有 60,495 个叶子、123,504 条叶子记录。不能把 P3 的约 6% 剩余量当成 Fa 的结果。
F1 虽只有约 2n scatter，却几乎把全部记录交给比较叶子，因此并不更快。

深偏斜中，P 的重桶跨多个宏节点，累积了约 11n compact；F1 则把完整多数 key
直接隔离。剩余约 0.098n 记录所在组经扫描等值终结，没有比较叶子。
这是长路径编号相对普通前缀的独立价值。Fa 同样能做到，但本例多支付两个 label pass。

同粗前缀的 Fsame 配置也真实计费：均匀输入下，Fsame1/2/3 scatter 分别约
4n/3n/4n，对应 P1/2/3 的 2n/2n/3n。额外 label 字节没有免费隐藏。

H1 在 wide32 均匀输入约 138 ms，L 为约 190 ms，冻结 LSD 约 183 ms；
H1 与 L 同为 16n scatter，却多了 compact 和扫描。它说明改变局部完成方式可以改善
时间，但这轮没有最终版本的 ROI 硬件计数，不能断言具体 cache miss／带宽贡献。
其他 H 配置会把大量小桶交给比较叶子，应连同叶子成本一起解读。

## 原稀疏反例保留且复现

32,768 条 128-bit key，在 0、18、36、54、72、90、108、126 位变化，
256 个 key 等频；wide32 原生实现的独立工作账本如下。

| 方法 | scatter 记录 | compact 槽位 | 最大路径 pass |
|---|---:|---:|---:|
| L | 262,144 | 63,232 | 8 |
| Pa | 262,144 | 294,720 | 8 |
| Fa | 278,528 | 80,960 | 15 |
| F1 | 147,456 | 179,968 | 8 |

Fa 的 scatter 比 L 多 **6.25%**，重现方案保留的负例。F1 的 scatter 更少，
但 compact 更多，不能据此宣布总搬运更少。百万档 sparse 也保留在主矩阵：
wide32 的 Pa/Fa/F1 都比冻结 LSD 慢。不同 n 会改变自动字节预算与递归形状，
因此不能用百万档的 scatter 比例替代这个指定的 32,768 档反例。

## 空间与生命周期

下表为 B=64、百万条的 **requested heap peak**，单位 MiB。
输入、恢复副本、参考结果在测量前已分配并排除。Pa、Fa、F1 的根节点峰值在这些
输入上相同，分配次数不同；分配次数和全部输入结果保存在 memory CSV。

| 布局 / 输入 | 冻结 LSD | Pa / Fa / F1 | 既有 Block MSD | Stable MSD |
|---|---:|---:|---:|---:|
| u32 / 均匀 | 0.282 | 0.282 | 0.532 | 4.032 |
| u32 / 深偏斜 | 0.282 | 0.282 | 0.532 | 15.431 |
| wide32 / 均匀 | 1.157 | 1.157 | 1.421 | 32.145 |
| wide32 / 深偏斜 | 1.157 | 1.157 | 1.421 | 488.125 |
| large128 / 均匀 | 4.157 | 4.157 | 4.468 | 128.545 |
| large128 / 深偏斜 | 4.157 | 4.157 | 4.468 | 492.831 |

Stable MSD 的大峰值来自本仓库这个递归实现，不能推广为所有 stable MSD 的固有成本。
P/F 的分布工作区由单个节点拥有，在访问子节点前释放；普通 LSD scratch 只在
包含直方图和游标的预算内启用。固定 B 的块目录为 O(n/B)，不声称固定 B 实测配置
已经实现严格 O(√n) 总辅助空间。heap peak 不含递归栈、allocator 保留量或 RSS。
本轮没有完整进程辅助空间的实测上界。

## 覆盖、噪声与实现限制

正式计时使用同一套冻结源码／ELF，Rust 1.98.1 release、`-C target-cpu=native`，
单 worker 固定 guest CPU 2。机器是 KVM 下的 Xeon Gold 6140，6 vCPU、约 15.6 GiB RAM；
不能保证宿主独占和固定频率。每次排序前恢复同一输入分配，顺序轮换且交替反转；
workspace 分配／释放在计时内，恢复与稳定 oracle 核对在计时外。

| 档位 | 布局数 | 输入数 | 方法表长度 | 重复 |
|---|---:|---:|---:|---:|
| 16,384 | 6 | 12 | 19（含两次 L） | 8 |
| 262,144 | 6 | 12 | 19 | 6 |
| 1,048,576 主矩阵 | 6 | 6 | 19 | 8 |
| 新 seed / B=512 各一组 | 3 | 3 | 8（含两次 L） | 12 |

u64 已纳入六种布局；u16 本轮仅做正确性测试，性能覆盖待补。
两档小矩阵包含均匀、有序、逆序、全等、少 distinct、公共高位、深偏斜、多重群、
多数前缀、首元素离群、稀疏位和 comb。最大计时规模是百万；方案中的更大规模和
精确 cache 边界扫描尚未做，不能视为整个研究计划完成。

按固定 slot 计算第二个 L / 第一个 L；这是相同算法的 A/A，而非候选收益。

| 计时组 | A/A 配对数 | 中位比 | p10–p90 | 墙钟 / 线程 CPU 中位比 |
|---|---:|---:|---:|---:|
| screen-16384 | 576 | 1.005 | 0.877–1.283 | 0.9952 |
| screen-262144 | 432 | 1.003 | 0.890–1.158 | 0.9993 |
| main-1048576 | 288 | 0.994 | 0.891–1.131 | 1.0002 |
| holdout-42 | 108 | 1.003 | 0.884–1.118 | 1.0005 |
| block512 | 108 | 1.000 | 0.927–1.102 | 1.0004 |

这些分位数是跨场景的描述性范围，不是单个场景的置信区间。分场景完整数据见
[noise.csv](noise.csv)。主矩阵 wide32 均匀的 A/A p10–p90 为 0.936–1.021，
深偏斜为 0.955–1.037；窄 key 和短运行的波动更大。小幅领先不能仅凭中位数证明，
全部离群值仍保留。墙钟与 CPU 接近不代表没有频率、cache 或宿主干扰。


每个 benchmark warmup 和正式样本均核对全部 key；有身份／payload 的布局逐项核对
完整记录的稳定 oracle。专项测试还覆盖 128-bit 映射穷举／边界、非零公共高位、
递归稳定性、signed/float 保序转换、u8/u16/u32/u64/u128、奇数 B 和 B=512。
debug、release+工作计数、AddressSanitizer 各 **7 项通过**；
`cargo check --all-targets --all-features` 通过，保留既有 cfg／dead-code warnings。
这些是新增实验的定向验证，没有宣称整个仓库测试全绿。

这仍是要求纯 key 提取器的 Copy 原型，未完成自定义 `extract` 覆盖及异常安全的生产 API。
F 的 Boyer–Moore 与 variation／顺序扫描融合，在有序或全宽退化时仍支付候选开销；
分类中的比较、分支与 label 重算也可能昂贵。最终计时没有把这些阶段逐项定位，
因此它们是待做的局部消融，不能据此承诺优化后的速度。
早期 u128 carrier、动态位移原型及 perf 诊断保留在 calibration 文件中，
有并发构建负载，全部排除于正式性能结论。

## 候选去留

- 保留 P/Pa 作为宽 key 的结构候选；继续研究的门槛是和已有 Block MSD 比较，
  不能只靠击败 16-pass LSD。固定 24-bit 和按规模取字节都没有被证明是统一最优规则。
- 保留 F 的完整多数 key 路径压缩。F1 的成功说明较小 label 预算值得关注；
  Fa 的规模公式本身无法选择合适的结构，也无法避免多数前缀／稀疏反例。
- H 留作局部完成方式的对照；本轮证据不足以替换默认路径。
- 暂停把 Fa 或 Pa 当作统一默认值。窄 key 与多重群／公共高位的回退是明确的。

Pa 与 F 可共享节点调度、分布后端和叶子；Fa 已经采用节点规模预算。
下一步组合真正要解决的是“何时付候选与出口编号的成本”。完整 key 重复程度、
剩余有效宽度和 record 大小可以作为信号，但信号获取成本必须计入。
本轮没有实现按分布名派发的选择器，也没有把未测的组合写成已交付结果。

## 复现与证据

正式源码与二进制摘要分别在 [source-sha256.txt](source-sha256.txt) 和
[binary-sha256.txt](binary-sha256.txt)。ELF 位于 ignored 的
`experiments/block_msd/target/frontier/{time,work}`，本机保留；跨机需按下列命令重建，
重建后的 ELF 摘要可能受工具链／路径影响，应生成新的 ledger，保留原 ledger。

```bash
# 在此 worktree 根目录；新机器可用不同 CARGO_TARGET_DIR，避免覆盖冻结 ELF。
RUSTFLAGS='-C target-cpu=native' /root/.cargo/bin/cargo build --release \
  --manifest-path experiments/block_msd/Cargo.toml --bin frontier_experiment
mkdir -p experiments/block_msd/target/frontier
cp experiments/block_msd/target/release/frontier_experiment experiments/block_msd/target/frontier/time
RUSTFLAGS='-C target-cpu=native' /root/.cargo/bin/cargo build --release \
  --manifest-path experiments/block_msd/Cargo.toml --bin frontier_experiment --features frontier_work
cp experiments/block_msd/target/release/frontier_experiment experiments/block_msd/target/frontier/work

# run.py 拒绝覆盖已有名字；每份 measurements/*.json 保留该次完整命令。
python3 experiments/block_msd/frontier/run.py replay-main --n 1048576 --reps 8 \
  --cases uniform,deep_skew,majority_prefix,sparse,common_high,multi_heavy
python3 experiments/block_msd/frontier/analyze.py \
  experiments/block_msd/frontier/measurements/replay-main.csv --out summary-replay.csv
python3 experiments/block_msd/frontier/validate.py
```

[measurements](measurements/) 保存原始 CSV、执行命令、起止时间、内存／负载快照和 stderr；
后期 run 还记录 child rusage。输入为固定种子的生成器，恢复副本固定，未使用外部语料。
[noise.py](noise.py) 按固定方法表 slot 比较两个 L；[analyze.py](analyze.py) 按同 seed／rep
配对，以两个 L 的均值作为受控基线，并另外列冻结 LSD 和 Stable MSD 的配对比。
原始记录仍保留所有离群值，没有按最快样本筛选。

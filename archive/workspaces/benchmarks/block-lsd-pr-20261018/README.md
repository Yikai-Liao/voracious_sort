# Block LSD PR benchmark

本目录保留两个分别冻结的 campaign：初始完整矩阵，以及按用户修正扩大系数、增加块字节归一化的补测。两批时间分别汇总，各自使用同批对照，不混合计算加速比。

全部完成：共 128,520 次正式时间观测、64,260 次正式内存观测。结论见 [REPORT.md](REPORT.md)，最终图见 [figures/](figures/)，逐面板验收见 [qa/README.md](qa/README.md)。原始数据保留在 `data/`，预检单独保存。

`SHA256SUMS` 覆盖成品、数据、源码、二进制、日志和依赖记录，`seal.py --verify` 可重新核对。便携归档保存在 `../../archives/block-lsd-pr-benchmark-20261018.tar.zst`，并附外部归档校验清单；归档排除可再生的 `.venv`、Cargo `target` 和 Python 缓存。

冻结候选为 `e649c6af49d6bfdde896ca40cad387235fce4bfa`，上游为 `3dbdd7f46006d4395626f18fda9c135b4ecd9bbb`。测量和绘图全部放在此目录，未向 PR 添加 benchmark 依赖或实验代码。结果见 [REPORT.md](REPORT.md)，完整观测见 [data/](data/)。

## 测量范围

主矩阵为 9 种类型 × 23 种分布 × 5 种长度，共 1,035 个输入条件；另有 10 个 `u64/uniform` 长度，用于观察增长趋势，最大 16,777,216 个元素。类型为 `u32/u64/u128/i32/i64/f32/f64` 以及带 key、原始位置和 payload 的 32/128 字节记录。主长度为 128、1,024、16,384、262,144、1,048,576。

每个条件测量 3 个确定性种子，每个种子采用正序及其完全反序的方法顺序，共 6 次时间观测。种子间旋转方法起点；输入条件顺序也固定随机打乱。时间包括整个排序函数中的分配、释放，不包括造数、输入复制、oracle 检查和 block 参数计算。每次观测先单独预热，再对独立输入副本进行批量计时，目标 3 ms，副本总量不超过 64 MiB、数量不超过 2,048。这是预热后的排序测量，不代表冷缓存延迟。

计时边界也包含共同 harness 的函数调用、方法分派与批循环开销。它们在很短输入上可能占明显比例，不能把这种差异直接解释为核心 radix 循环的性能。

有序、全相等、交替等确定性构造在不同种子下可能产生相同内容；此时重复观测主要反映执行顺序和运行环境。六次时间观测不是六个独立随机数据集，不用于显著性推断。

内存用单独编译、带分配计数的可执行文件，每条件 3 次。指标是排序过程中同时存活的**请求堆字节数峰值**，Rust 和 C++ 使用同一计数器；不包括输入、harness、RSS、分配器元数据及 realloc 内部可能短暂并存的新旧存储。每次排序结束要求计数器归零。计数版不参与时间比较。

单进程、单线程，固定 guest CPU 2。机器、编译器、构建参数、起始内存、二进制与源文件摘要保存在 [manifest.json](manifest.json)。KVM、共享宿主和系统后台进程会影响结果；A/A 对照用于量化此次运行中的波动。

## Block 参数

所有主测量采用 `radix=8`，九组参数使用同一个未修改的排序实现：

| 系列 | 参数 | 原始算法名 |
| --- | --- | --- |
| 固定元素数 | 128 / 512 / 1,024 | `block_count_128` / `block_lsd` / `block_count_1024` |
| 固定块内存 | 1 / 4 / 8 KiB，除以元素大小得到块长 | `block_bytes_1024` / `block_bytes` / `block_bytes_8192` |
| 随长度平方根增长 | 系数 0.5 / 1 / 2 | `block_sqrt_half` / `block_sqrt` / `block_sqrt_double` |

令元素字节数为 `s`、桶数为 `R=256`、块长为 `b`。本实现块路径的请求堆字节上界为 `2*R*b*s + 9*floor(n/b) + 66*R`。平方根策略采用 `b=max(1,ceil(c*sqrt(9*n/(2*R*s))))`，平衡两个主项，得到额外空间 `O(sqrt(n))`（固定 `s,R`）。它平衡的是空间，不保证速度最优。固定块内存只固定 scratch 部分，描述符仍随 `n/b` 增长；固定元素数也不是总空间常数。

复杂度背景见 [Parallel O(sqrt(n)) Overhead LSD Radix Sort](https://arxiv.org/abs/2607.05302)。上述系数来自当前 Rust 实现的分配布局，不直接套用论文中的某个实验参数。

主图预先指定展示 512 元素、4 KiB、平方根系数 1；初始九组数据全部保留；最终敏感性图使用下述扩展补测的四类参数，未按测量结果挑选最好参数。部分短输入或低熵分布会走已有快速路径，实际分配可能低于块路径上界。

对 `u64`，512 元素与 4 KiB 恰好是相同参数，因此对应曲线可能重合；重复测量仍分别保留。其他类型也有参数偶合的点，不能将这些点当成不同算法的独立证据。

## 扩大平方根系数与块字节归一化补测

初始空间平衡公式将元素大小 `s` 放在根号内，块长随 `sqrt(n/s)` 增长。它平衡的是两项空间，并未让不同类型拥有相同的单块字节预算。初始 0.5/1/2 的系数范围也偏小，不能用其耗时推断所有随长度增长策略的表现。用户指出这两点后，单独冻结以下补测：

| 家族 | 公式与范围 |
| --- | --- |
| 固定元素数 | `b=128/512/1024` |
| 固定块字节数 | `b=max(1,floor(B/s))`，`B=1/4/8 KiB` |
| 空间平衡平方根 | `b=max(1,ceil(c*sqrt(9*n/(512*s))))`，`c=1/2/4/8/16/32/64` |
| 块字节归一化平方根 | `b=max(1,floor(k*sqrt(n)/s))`，`k=1/2/4/8/16/32/64/128` 字节 |

最后一项先给出共同的块字节预算 `B(n)=k*sqrt(n)`，再除以元素大小。实际字节数受整数块长量化；预算小于单个元素时至少取一个元素。对于百万元素主长度，归一化组在所有类型上均覆盖 1–128 KiB，包含 4 KiB 两侧；两种平方根家族的元素块长也均覆盖 512 两侧。审计分别验证字节和元素范围，范围随平方根增长移动：例如最大长度 16,777,216 处，归一化组为 4–512 KiB；并不要求每个测量长度都跨过这些基准。固定 512 元素与固定 4 KiB 作为两个不同对照保留，仅对 8 字节元素等价。这些范围已包含在当前补测中，未因标注修正增加实验。

补测共 109 个条件：九种类型 × 五种主长度的均匀输入，十个额外 `u64/uniform` 长度，以及九种类型 × 六种压力分布（`skew95/common_prefix/nearly_sorted/normal/organ_pipe/push_front`）在 1,048,576 元素处的测量。它是参数与归一化研究，不将新参数描述成已跑过初始全部 23 分布。每条件重跑 25 个方法，包括原 LSD、Rust stable、TimSort 和 LSD A/A；三种子正反序共六次时间、三次内存观测，其他计时/校验协议与初始矩阵相同。

补测仅对 harness 增加逗号分隔的 `algorithm:block` 参数解析，放在计时边界之前；排序实现不变。[ADAPTER.diff](supplemental-sqrt/ADAPTER.diff)、独立源码、二进制和 manifest 全部保留。百万元素时，归一化 `k=s/2` 正好给出 `b=512`，可与固定 512 做同函数同参数检查。`k=1/4/8` 也分别等于固定 1/4/8 KiB；这些相同参数点不算独立算法证据。

大系数可能使现有有界 full-scatter 路径在部分长度上成立，使用接近整个输入大小的额外缓冲区。因此最终图报告实际峰值，而不将所有有限长度点都当成已进入平方根渐近区间。参数计算均在排序计时之外，此处没有测自动选参器的开销。

补测文件为 `data/supplemental-sqrt-{time,memory}.jsonl`、相应进程/顺序记录、CSV、`supplemental-sqrt-summary.csv` 和 `supplemental-sqrt-audit.json`。补测的重画使用同一个 `plot.py`；复核汇总用 `supplemental-sqrt/analyze.py`。补测协议和源码在 [supplemental-sqrt/](supplemental-sqrt/)；重跑应复制到新目录，保留当前证据。

## 对照与语义

包括库内 `lsd_stable_radixsort`、`lsd_radixsort`、`lsd_radixsort_aux`、`lsd_radixsort_heu`、DLSD、Thiel，以及适用的 `lsd_u32/lsd_f32`。`aux` 测量不启用 Verge 和 counting-sort heuristic，`heu` 的 `min_cs2=100000`。Thiel 不支持 `u128`；带 counting 转换的 heuristic 不适用于不透明记录，均保留 N/A。

稳定比较排序同时包含 Rust `slice::sort_by_key` 和实际的 [gfx::timsort v3.0.1](https://github.com/timsort/cpp-TimSort/tree/v3.0.1)。TimSort 使用未修改的上游头文件、GCC 14.2 `-O3 -march=native`，通过一次整次排序的 FFI 调用进入，比较器按与 Rust 相同的转换 key 排序。小输入包含 FFI 固定开销；跨语言与编译器差异也是结果的适用边界。Rust 标准库的当前稳定排序不称为 TimSort。

`lsd_aa` 与 `lsd` 调用完全相同的函数，是波动对照，不是额外算法。图中 `[U]` 表示不稳定接口或含不稳定 fallback。全部输出都检查转换 key 次序、值/位模式和记录 payload；Block、Rust stable、TimSort 必须逐项等于稳定 oracle。记录中的原始位置用于识别 equal-key 次序变化。原有算法即使违反稳定 oracle，仍保留时间与原始输出检查结果；图中叉号明确标注，不能据此声称同语义加速。原始值相同的基本类型无法单独揭示等键稳定性，记录用例补足此检查。

浮点主矩阵使用有限值；按秩构造的分布使用数值浮点，而非把小整数解释为次正规数。均匀数值和正态分布使用实际浮点数值。特殊 IEEE 值（正负 NaN、无穷、零、次正规数）的转换 key 位序另由 [float-contract.jsonl](data/float-contract.jsonl) 检查，不混入主性能结果；本测量不把转换 key 顺序替换为 `partial_cmp`。

## 分布定义

精确定义以冻结的 [src/main.rs](src/main.rs) 中 `input()` 及类型适配为准：

| 名称 | 构造 |
| --- | --- |
| `uniform` | SplitMix64 全宽熵；浮点映射为有限位模式，负零归一化 |
| `uniform_numeric` | 浮点在 [-1,1) 数值均匀；整数使用对应有界线性数值映射 |
| `uniform_narrow` | 不超过 1e9 的随机非负数值秩 |
| `skew95` | 95% 为零，其余全宽随机 |
| `few_unique` | 16 个等概率键 |
| `sqrt_keys` | ceil(sqrt(n)) 个等概率键 |
| `common_prefix` | 固定非零高位、低 16 位变化；浮点在 +1 附近 |
| `low_bits_constant` | 清零低位，并限制浮点为有限值 |
| `high_only` | 只变化高字节的 7 位，浮点保留非零尾数 |
| `sorted` / `reversed` | 每个键重复四次，按转换 key 升序 / 降序 |
| `nearly_sorted` / `reverse_nearly_sorted` | 上述有序 / 逆序输入执行 n/100 次随机交换 |
| `almost_sorted` | 有序输入执行 ceil(log2(n)) 次交换 |
| `all_equal` / `late_difference` | 全相同 / 仅最后一个键不同 |
| `alternating` | 零与全宽极值交替，经类型映射 |
| `organ_pipe` / `sawtooth` | 三角形秩 / 周期约 n/16 的锯齿秩 |
| `zipf` | 1,024 个秩、指数 1.2 的离散 Zipf |
| `normal` | Box–Muller 标准正态；整数平移/缩放后转换 |
| `push_front` / `push_middle` | 有序输入将末元素移到开头 / 中点 |

## 保留数据与重新绘图

- `data/primary.jsonl`：逐次时间观测，包括种子、方法顺序、输入摘要、批大小、总时间、每次均摊时间及检查结果。
- `data/memory.jsonl`：独立内存观测，包括 peak/total requested bytes、分配次数及检查结果。
- `data/supplemental-sqrt-time.jsonl` / `supplemental-sqrt-memory.jsonl`：扩展系数补测的逐次时间/内存观测；对应的 `supplemental-sqrt-summary.csv` 与 `supplemental-sqrt-audit.json` 分别提供汇总和审计，不与初始 campaign 混合。
- `data/*-processes.jsonl`：每个子进程命令、起止时间、退出码、资源输出、结束时的进程 VmSwap 以及运行期间系统 swap/major-fault/OOM 增量。
- `data/*-schedule.json`：完整运行顺序；`timing.csv` / `memory.csv` 为 JSONL 的平面导出。
- `data/summary.csv`：每条件中位数、最小/最大值、同种子同顺序的配对时间比、语义有效标志。配对比的中位数不是两个时间中位数之比。
- `data/validation-failures.csv` / `audit.json`：原算法与稳定 oracle 的差异、A/A 波动、空间上界、完整性和 swap 审计。
- `source/`、`Cargo.lock`、二进制、Python 锁文件和最终 SHA-256 清单：保留实现和依赖依据；预检文件单独存放，不进入正式汇总。

`preflight-v1/` 是较早的小矩阵准备记录；`preflight-rust-timsort/` 保留曾考察后弃用的 Rust `timsort 0.1.3` 原型（源码仍标 WIP，并发现 merge-collapse 条件问题）。正式对比统一使用冻结的 C++ gfx::timsort，勿将旧原型混入结果。`preflight-v2*` 是最终 harness 的全类型/分布正确性预检，仍与正式计时数据分开。

种子与摘要包含 64 位整数。后续分析应使用能精确保留这些整数的读取方式；若经电子表格中转，需将相应列作为文本导入。原始 JSONL 始终保留。

现有 `.venv` 可直接使用。复制目录后可用 Python 3.14 建立环境并从 `python-requirements.lock` 安装。仅重做汇总和绘图：

```sh
.venv/bin/python analyze.py
.venv/bin/python supplemental-sqrt/analyze.py
.venv/bin/python plot.py
.venv/bin/python create_report.py
```

`plot.py --matrix-n 16384` 可从相同 CSV 生成另一个已测长度的完整矩阵，默认是 1,048,576；不调用排序程序。建议用独立输出目录保留本次冻结图：

```sh
.venv/bin/python plot.py --matrix-n 16384 --output-dir ../block-lsd-replot-16384
.venv/bin/python audit_figures.py --output-dir ../block-lsd-replot-16384
```

新目录中包含 `figures/`、`qa/` 与绘图输入/源码摘要，仍从原始目录读取 CSV。原始 JSONL 不需要修改。PDF/SVG 是正式矢量图，PNG 只是 300 dpi 预览；本任务不是期刊投稿，未生成 TIFF。

重新测量应复制 harness 到新目录，清除新目录中旧的正式结果、重新冻结 manifest，并保留新批次的环境记录。`run.py` 会拒绝向已有正式观测文件追加重复批次。不要在此冻结目录直接覆盖正式数据。

## 图与不确定性

`overview` 为增长趋势、类型宽度和分布细节；`block-policy-sensitivity` 为补测全部类型的四类参数；`sqrt-policy-scaling` 分开展示空间平衡和块字节归一化的增长；`algorithm-comparison-1048576.pdf` 按类型分为九页，保留全部 23 种分布和全部适用方法。主图保留最初选择的八种分布，并在 415 条件的中途检查发现结构化输入退化后，追加 `organ_pipe` 与 `push_front` 两种压力条件。这是展示上的探索性补充，未更换参数或删减原矩阵。完整长度矩阵保存在 CSV，可随时重画。

主图和完整算法矩阵来自初始 campaign；扩展参数与平方根增长图来自补测。两批图均在各自同批数据内比较。

点为六次时间观测的中位数，误差线/阴影为最小到最大值；内存为三次观测。它们不是置信区间，不做显著性检验。矩阵为六次配对比中位数，颜色在 1/8 和 8 截断，原始数值不截断；密集矩阵不单独显示每格区间，完整区间保存在 CSV。固定硬件、单次 campaign 的结果不外推为所有机器上的结论。

对数内存轴不画零分配点；这些观测仍保留在 CSV。对于同一参数在不同输入条件走不同快速路径的情况，不用连线推断未测长度的精确分配量。

绘图源、可编辑 SVG/PDF、300 dpi PNG 预览和 `qa/` 中的对齐、字形、碰撞及人工验收记录一起保留。

# Pa：复用节点已准备的变化位

**Goal 未通过。** prepared组合改善了若干大记录和偏斜输入，但u16稀疏输入仍比Stable MSD慢约12.6%。普通输入的采样增量没有得到稳定证据；其他新增回退信号与首屏噪声一起保留。本阶段没有替换主库默认入口，也没有继续运行正式大矩阵。

源码固定为 `609e8c0cde4812d18d2cec2701a035f13d1dffca`，156项源码/Cargo文件与time ELF由清单固定。四份CSV共672行、21个cell，均为seed42、每项4次：窄键256行、大记录96行、中等规模288行、百万条u64已知偏斜32行。方法先warmup，正式执行旋转/相邻反向；Pa双slot提供逐cell A/A，每次恢复同一输入分配并核对完整稳定oracle。首屏包含Pa_band和Stable MSD，未包含Frozen LSD。

## 独立机制与结果

阈值继续固定16MiB。cache保留精确直方图成本门，sample只增加64点成本拒绝，reuse只复用节点准备阶段已证明的label变化位，prepared同时启用采样和复用。上一阶段的dynamic radix没有启用。mask契约、保守覆盖范围及预算见[METHODS](METHODS.md)。

下表为墙钟中位数，单位ms。配对比在同文件、n/B/seed/layout/case、同rep内相除，再取中位数；不能用表中两列中位数相除替代。

| 场景 | cache | sample | reuse | prepared | Stable MSD |
|---|---:|---:|---:|---:|---:|
| 1,048,576/B512/large128/均匀随机 | 215.153 | 213.104 | 205.583 | 202.479 | 219.838 |
| 1,048,576/B512/large128/多数前缀 | 235.002 | 206.743 | 218.190 | 202.517 | 387.575 |
| 1,048,576/B512/large128/全异逐层90% | 231.194 | 207.100 | 211.044 | 204.946 | 323.037 |
| 262,144/B64/u128/全异逐层90% | 21.680 | 20.585 | 17.931 | 17.983 | 44.299 |
| 1,048,576/B64/u64/全异逐层90% | 27.887 | 27.727 | 25.172 | 26.475 | 51.514 |
| 1,048,576/B64/u16/稀疏 | 3.746 | 3.689 | 3.632 | 3.648 | 3.240 |

大记录多数前缀prepared/cache为0.848，p10/p90为0.830/0.926，4/4更快；prepared/reuse为0.931，0.909/0.954，4/4更快。全异逐层90%分别为0.887、0.954，也均4/4更快。对应Pa A/A的p10/p90为0.970/1.043和0.905/1.042。中等规模u128全异逐层90%的prepared/cache为0.822，0.775/0.847，支持继续保留复用变化位的方向；这些正例不能抵消尚未修复的负例。

u16稀疏prepared/Stable为**1.126**，p10/p90为1.080/1.168，4/4更慢；thread-CPU配对比为1.126。该cell的Pa A/A为0.969/1.016，差距不能只归于off-CPU等待。prepared/cache为0.982，仍未解决验收要求。

另外保留两个新增成本信号：u8稀疏prepared/cache为1.067，1.012/1.140，3/4更慢；prepared/reuse为1.038，1.015/1.139，4/4更慢。该cell Pa A/A为0.863/1.020，不能把首屏的7%中位数直接写成已确认的稳定回退。u8_id8均匀随机prepared/Pa_band为1.050，0.931/1.060，3/4更慢，Pa A/A为0.952/1.020。百万条u64全异逐层90%的prepared/reuse为1.052，0.998/1.061，3/4更慢，而该cell A/A为0.920/1.011，也仍需独立复核。

## 普通输入的采样成本

本轮B64布局的`512*B*sizeof(T)`均低于16MiB，代码在64点采样之前已由门槛返回。这些方法间的时间差不能解释为实际执行采样的成本。唯一可启用采样的均匀随机cell是B512/large128：sample/cache为0.996，p10/p90为0.940/1.021，2/4更慢；prepared/reuse为0.987，0.921/1.045，2/4更慢。尚未发现稳定采样增量。

中等规模u64均匀随机的sample和cache中位数为4.555、3.795ms，看似相差约20%，同rep配对中位数却仅1.008，p10/p90为0.990/1.269。wide32均匀随机sample/cache为1.114，0.936/1.207，但对应Pa A/A已有1.062/1.224的明显slot漂移，无法分离出稳定机制成本。不同文件、阶段ELF及n/B的中位数不直接拼接归因。

四份`summary-*.csv`和`noise-*.csv`保留所有cell；[独立复算日志](validation/report-check.log)给出逐rep方法/对照统计。全部离群值保留，p10/p90是描述性样本分位数，不是置信区间。

## u16稀疏诊断采样

为定位剩余成本，用冻结ELF对同一u16稀疏输入执行128次prepared，采集软件事件`cpu-clock:u`，频率997Hz。原始[perf数据](profile/u16-sparse.data)保留5,509,014字节，共649个样本、无丢样；[符号报告](profile/perf-symbols.txt)中`Sorter::step`占53.00%、`compact`占7.09%、`visit`占2.31%。

这些是包含输入生成、warmup、恢复及完整oracle的**整个进程用户态采样份额**，不是排序phase百分比，也不是硬件cycles或IPC测量。`profile/u16-sparse.csv`受perf开销影响，不进入672行正式时间或其摘要。结果仅用于下一步定位，未产生新的优化交付。

两次`perf annotate`均由工具自身触发SIGSEGV，退出139；两个`perf-step*.txt`为零字节。排序器没有在这些命令中崩溃。停止重试后采用已保存的`perf report`和ELF `objdump`。旧汇编及行号只对照[冻结源码快照](profile/block-source.rs)，不读取后续变动的当前block.rs；[profile说明](profile/README.md)和[状态记录](profile/status.json)保存命令及边界。

## 验证边界

28项debug针对性测试通过，运行95.08秒；runner的1项工作负载测试及全部目标/feature编译检查通过。[最终证据核验](validation/evidence-final.log)检查四份测量的672行、slot/rep、输入地址、冻结源码/ELF及profile快照。runner的workload测试不等于独立release-work计数实验。

**本阶段未完成ASan、release工作量及requested-heap实测。** mask复用减少标签扫描的设计预期尚不能替代工作量证据；稳定库叶子的heap也仍需实测，requested heap不能等同RSS或stack。12次正式矩阵、Frozen LSD保护、新seed20261018均未执行。`final.sh`、`heldout.sh`和只做过语法检查的`review_matrix.py`保留为预案，不构成已完成验收。

环境为共享KVM Xeon Gold6140、单worker固定guest CPU2，不能保证宿主独占或频率固定。[复现说明](REPRODUCE.md)、[环境](environment.json)、[固定验收范围](ACCEPTANCE.md)、[原始测量](measurements/)及`evidence-sha256.txt`固定本阶段证据。u16稀疏负例已经足以阻止本轮宣告Goal通过。

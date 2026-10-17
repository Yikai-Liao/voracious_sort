# 串行前缀／前沿实验的实现边界

研究起点固定为 `34080cf0fb95355411e029046e026b5aa65fb68c`。实现只在
`experiments/block_msd`；主库入口和冻结的 LSD/MSD 参照均未修改。

## 比较对象

| 标识 | 实现 |
|---|---|
| L_frozen | `submitted_lsd` 中保留的 `d6f6b704` Block LSD |
| stable_msd | `stable_baseline`：上游 stable MSD 的实验副本，修复降序等值组被反转的问题 |
| best_msd | 既有 `two_arrays_scratch_paths` 实验，仅作参照 |
| L | 当前实验后端，完整 key LSD；与候选共用终结和空间准入 |
| H1/H2/H3 | 一／二／三个高位字节分桶，桶内 LSD 完成剩余有效位 |
| P1/P2/P3 | 固定一／二／三个前缀字节，未解决区间继续递归 |
| Pa | 每个节点按 `ceil(log256(m))` 个字节取前缀 |
| F1/F2/F3/Fa | 同样的 label 字节预算；非完整 key 情形取 `k=8t−1`，另编码 pivot 路径出口 |
| Fsame1/2/3 | 与 P1/2/3 使用同样粗前缀深度；额外 label 字节真实计入 |

每个节点去掉已证明相同的高位，并受父区间剩余位数限制。P3 取
`min(24,w)`，不是生产默认值；Pa 在每个节点重新根据长度选择。F 仅用
Boyer–Moore 的完整 key 候选，没有按位多数的减半保证。候选、映射在整个宏节点固定。

## 工作区和稳定性

1. 小于等于 128 条记录用仓库原有的稳定 binary insertion 叶子。
2. 扫描 variation／顺序；F 同时做 Boyer–Moore。全等／有序终结；降序先反转全区间，
   再反转各等 key 组，保留身份顺序。
3. 固定 classifier，扫描 **label** 的变化字节。
4. 普通 LSD 的输入长度 scratch、边际直方图及游标合计不超过
   `512 × B × size_of(record)` 时用普通 LSD；其余使用分块后端。
5. 宏节点所有 label 字节结束后只 compact 一次；函数返回即释放 scratch／目录，
   然后扫描等 label 区间并递归。没有线性 label 数组，也不保留祖先的分布工作区。

`frontier/block.rs` 从冻结的 submitted sorter 复制，保留 BSD 许可证、块分配、
scatter、fixup 和 compact 协议，只将 digit 提取改成固定 classifier 的 label 字节，
并加入可编译移除的写入计数。保留原内核的常量字节位移分派。转换后的
u8/u16/u32/u64/u128 key 保留原生宽度；signed/float 使用仓库既有保序转换。

所有算法按稳定 oracle 逐条核对 key、身份和 payload。自定义 key 必须在排序期间稳定、
无分配且保持纯函数语义；此原型从 converted key 计算 label，不遵循自定义 `extract`
覆盖。它不是已完成泛型 API／异常安全承诺的生产实现。Copy 约束排除析构责任，
scratch 为 `MaybeUninit<T>`；typed read 只读取已初始化的 block prefix。普通 scatter
在写入前检查各桶终点、整轮后检查全部游标，之后才将 buffer 当作输入。

## 测量口径

`time` 和 `work` 是两个独立冻结的 release ELF。`frontier_work` 将计数从计时版本
编译移除。辅助空间和分配次数在第三种独立运行模式记录；计时数据不带活跃的分配计数。

同一进程、同一可写输入分配内轮换方法，并交替反转方法顺序。每轮计时前恢复同样的输入，
完整 oracle 验证移出计时；算法内部的 workspace 获取／释放和排序终结保留在计时中。
正式矩阵把 L 重复放在方法表两处，以观察 A/A 波动。报告墙钟和线程 CPU 时间。

固定 B 在同一类型／规模组内比较；B=64 和 B=512 分开报告。普通 LSD 的准入预算相同，
分块 scratch／目录常数也相同；实际 requested heap peak 仍单独测量。该值包含排序期间
同时存活的堆分配，排除已分配输入、参考结果和恢复副本；不包括 allocator 保留量、
RSS 和递归栈。递归深度在工作账本另列，因此不把 heap peak 写成完整辅助空间实测值。
固定 B 的目录是 O(n/B)，不声称整个实现严格 O(√n)。Stable MSD 的堆内存独立列出。

工作账本的 `scatter_records` 只计 radix scatter，不含比较叶子中的移动。
`compact_records` 计记录大小的槽位写入，含整块 evacuation 的 padding 槽位；
`tail_records` 计初始尾部复制。`node_records` 为 Σm_v；`label_evals` 包含真实 label
调用次数，包括边界探测和失败的组尾探测；`prepare_records`／`candidate_records`
为相应整轮扫描。`passes` 是宏节点 pass 数之和，`max_path_passes` 才是某条路径的
最大 pass 数。前沿的原自动规则有 ceil(W/7) 上界；Fsame 配置不直接继承该字节预算证明。

H 的加速若未由单独硬件计数定位，归因只到“改变局部完成方式”；不会仅从时间断言
缓存 miss 降低。已有 calibration 的 perf 采样只用来发现原型开销，不当作最终阶段占比。

## 数据和校准

输入生成器、种子、布局和全部配置在 runner／原始 CSV 中明确记录。`small8` 为
u32 key＋u32 身份；`wide32` 为 128-bit key＋身份／payload、共 32 bytes；
`large128` 为 u32 key＋身份／payload、共 128 bytes。同宽 key 的配对布局可拆分搬运成本。
稀疏反例保留 0、18、36、54、72、90、108、126 位变化；32,768 档使用全部 256 个
宽 key 等频。u32 的同名分布只保留落在其位宽内的变化位，不冒充 128-bit 原反例。

前两版 calibration 原型分别把所有 key 放入 u128、以及仍使用动态字节位移，给窄 key
带来了额外开销；源码副本和原始记录保留在 calibration 目录。之后保留原生宽度、
常量字节位移和 L 的 identity classifier。Calibration 时有并发构建／验证负载，
与正式计时分开；正式结论只使用 source／binary ledger 对应的冻结版本。

## 后续组合的门槛

Pa 和 Fa 可以在同一个节点调度中选择，复用同一后端、工作区生命周期和叶子。
但 Fa 已经使用按节点规模选择字节预算的规则；将二者结合的新增内容是 **何时选择路径出口
编号**，不是再次加一个规模公式。完整 key 重复程度、剩余有效宽度、记录大小是候选信号；
若为选择 Fa 而让所有 Pa 节点额外支付 Boyer–Moore 或一轮扫描，需计入真实成本。
只有简单规则在未参与调参的输入上稳定有效，才值得实现组合；本轮不按分布名称派发。

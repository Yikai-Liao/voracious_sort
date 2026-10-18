# PA 优化交付报告

当前排序库源码为 `6fceaaa`，完整源文件指纹为 `eca6b3cf68617eaec8de46fadb300e38cdcdc836fdd29700c62338daa07b7636`，候选方法为 `Pa_kernel`。**整数验收已完成，整体候选被新增浮点复测拒绝**：f32 带身份/payload 的 sparse16/B512 场景独立复测仍慢 16.3%。整数证据包括当前源码的 native 原 103 场景、46 场景扩展、30 场景留出集、普通目标 46+7 场景、冻结旧 ELF 控制、内存与完整 Work 比较。整数成绩不能覆盖浮点失败。后续按用户要求移植 Rollercoaster 的局部完成与统计复用机制，使用新的源码与 ELF cohort。

所有改动均在独立 worktree `/root/code/voracious_sort-pa-execution`，分支 `block-pa-execution`，限定于 `experiments/block_msd`。仓库根目录生产实现和 frozen Block LSD 源码未修改。

## 保留的实现

精确变化掩码决定哪些键位可以压成 u8/u16/u32 标签。部分投影保留原 PA 前缀的完整分区，只在确实减少字节分发轮数时使用；完整投影不得增加首节点搬运轮数。原键转换、稳定叶子和递归 cap 保持原契约。相对原 PA 的缓存 gate 仍为 16 MiB，没有新增输入尺寸阈值。

压紧由固定版本 `hakmem = 0.2.0` 提供。只有库的安全硬件 token 可用时才启用压紧；其余情况沿原 PA 路径。软件压紧回退、本地 intrinsic 与本地软件提取计划均已删除。库负责检测、指令调用和 u128 拼装；本地只保留 token API 所需的保守目标适配。

分类器通过 `Labeler`、`Masked` 向全量分类内核传递执行上下文，避免普通编译目标中逐记录调用外置提取包装。block 写操作直接展开在同一上下文中，修复嵌套闭包被单独编译后丢失上下文的问题。分类计划为节点内固定大小状态，没有逐记录标签数组；分发 scratch 在递归前释放。

不变量和代码生成原因见 [DESIGN.md](DESIGN.md)，库边界见 [LIBRARY.md](LIBRARY.md)。`Pa_packed` 保留未传播内核上下文的诊断路线，`Pa_packed_aggressive` 只用来重现旧的过度细分退化。

## 当前证据

当前源码的 native 原矩阵为 103 cells、13,184 行，独立审计确认输入集合、轮换与单一 ELF。候选对原始 Rollercoaster 的配对中位数胜出 85/103（同 ELF 原 PA 为 82/103），p90 胜出 73/103；对 frozen Block LSD 中位数胜出 100/103、p90 胜出 89/103；对 Stable MSD 对应为 101/103、95/103。没有达到预设门槛的原 PA 实质退化信号。

native 46 场景扩展中，对原 PA 的中位数胜出 42/46；新种子的 30 场景留出集胜出 29/30，两者均无实质退化信号。17 场景的冻结旧 ELF ABBA 控制也未触发门槛。21 个独立 Work 场景中，`Pa_packed` 与 `Pa_kernel` 的全部计数及叶长分布一致；16 个内存场景、32 行测量中，候选峰值堆分配均未高于原 PA。完整整数证据与资源边界见 [VALIDATION_INLINE_FINAL.md](VALIDATION_INLINE_FINAL.md)。

主矩阵中，u128 / wide32 稀疏键对 Block LSD 的中位耗时比分别为 B64 的 0.185 / 0.282，B512 的 0.397 / 0.477，四项 p90 均小于 1。B512 wide32/deep_unique90 首轮中位数慢约 5.4%，p10 小于 1；独立复测变为 0.996，没有重现。额外 q64/B512 控制中的 wide32 中位数仍慢约 2.8%，不支持“所有场景无回退”的表述。

普通目标的冻结 ELF 为 `inline_generic`，无 native 编译标志。46 场景中，相对原 PA 的配对中位数胜出 40/46，相对原始 Rollercoaster 胜出 43/46，相对 frozen Block LSD 胜出 36/46；新增七场景对应为 5/7、6/7、7/7。没有达到预设门槛的原 PA 实质退化信号，但 large128/deep_unique90 有约 1.5% 的小幅重复损失。q64 独立复测与两个源码的 ABBA 控制也单独保存。完整数据、资源与不确定性见 [VALIDATION_INLINE_GENERIC.md](VALIDATION_INLINE_GENERIC.md)。

最终源码已通过 native 59 项库测试、禁用硬件准入的 59 项库测试，两个配置各 4 项 runner 测试，以及 AArch64 / RISC-V 的库编译检查。跨编译不代表实际机器性能验证。

所有计时固定 CPU 2，串行运行，编译与测试不与计时重叠。每个 cell 采用相同数组分配、轮换和反向方法顺序，保留候选和原 PA 的 A/A 槽。配对中位数与 p10/p90 是描述性分位数。实质退化门槛预先设为候选/原 PA 中位数大于 1.05 且 p10 大于 1，并结合 A/A、独立复测判断。完整记录、身份、payload 和稳定性检查在计时外执行；原始 Rollercoaster 使用键序与完整记录多重集检查，仍是主要对照。修复稳定性的 Rollercoaster 只作独立诊断。

本机为六 vCPU 的 KVM Xeon Gold 6140，存在其他服务和 zram swap；每次运行的资源快照均保存。其他机器与微架构的性能尚未验证。

浮点扩展方案见 [FLOAT_PLAN.md](FLOAT_PLAN.md)，完成与停止范围见 [FLOAT_VALIDATION.md](FLOAT_VALIDATION.md)。native 有限值 88 场景对原 PA 中位数胜出 61/88，对 Rollercoaster 为 32/88，未形成多数优势；特殊位模式另有 16 场景。整体拒绝后，普通目标、留出集和原计划的 Work 矩阵未运行。独立 harness 直接包含现有 runner；不把 NaN/无穷诊断扩展为公共 API 保证。

## 失败实验与历史边界

早期强制 local 调度、普通标签缩窄、carried boundary、集合多数与库分组边界均没有通过独立筛选，已从当前活动源码移除。过度消费更低变化位的首版投影曾令 large128/deep_unique90 退化约 36%，即使总搬运减少仍不能接受。旧软件回退和两版不完整执行上下文也有重复的大幅退化，均已明确标记为拒绝。

各阶段的源码、ELF、原始 CSV 与处置见 [COHORTS.md](COHORTS.md)，旧机制泛化审计见 [GENERALIZATION.md](GENERALIZATION.md)。文件名带 `final` 的历史结果不表示最终通过，所有 cohort 按各自的源码和 ELF 指纹区分。

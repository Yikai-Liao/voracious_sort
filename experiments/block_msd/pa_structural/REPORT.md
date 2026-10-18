Current continuation: kernel-context source `9bba819` is **rejected** by its generic 46-cell screen and independent u128 q64 confirmation (1.55x old PA). The native full matrix and further extensions were stopped. See [VALIDATION_KERNEL_FINAL.md](VALIDATION_KERNEL_FINAL.md) for this exact cohort. Historical results below remain attached to their own source and executables.

# PA 优化当前交付状态

当前硬件单路径检查点已完成本机 native 原 103 场景，但普通编译目标仍有重复的大幅退化，整体不接受。完整结果见 [VALIDATION_SINGLE_PATH.md](VALIDATION_SINGLE_PATH.md)；此前局部修正的范围见 [HARDWARE_CHECKPOINT.md](HARDWARE_CHECKPOINT.md)。

硬件压紧由 pinned hakmem 0.2.0 提供；生产 PA 不选择软件压紧，没有可用硬件 token 时使用原 PA。31ff0d2 删除连续字段分支后，百万条 u32 sparse 在 B64/B512 的新/旧 PA 配对中位数为 0.849/0.870，p90 均小于 1。这里硬件压紧仍启用，不能解释成阈值避开了压紧。清理后源码 5f6d211 的两组完整库测试各 57 项、runner 4 项和两个交叉检查均通过；其独立 work 记录确认硬件投影节点实际执行。

5f6d211 的 native 原矩阵已通过全部正确性检查，共 103 cells、13,184 计时行。同 ELF 中候选对 Rollercoaster 的配对中位数胜出 81/103（原 PA 为 79/103），对 frozen Block LSD 胜出 98/103，未出现对原 PA 的实质退化信号。然而普通目标的 u32 sparse 在 B64/B512 独立复测仍为原 PA 的 2.025/2.498 倍，不能接受为通用实现。汇编显示普通目标每条记录调用外置 PEXT 包装，而 native 内联硬件指令；这只是待实验验证的原因，不能当作修复已完成。

全部正负结果分 ELF 保存。信息量扩展、留出种子、冻结 ELF 控制及最终资源矩阵未在失败后继续执行。后续候选在独立 worktree 中测试整个分类内核的执行上下文与现成库的分组边界定位；不靠新阈值规避本次退化。

历史实验与失败证据的边界在 [COHORTS.md](COHORTS.md)，不能因文件名含 final 或总体胜出数较多就视为接受。旧机制泛化的独立审计与被否决的集合多数实验在 [GENERALIZATION.md](GENERALIZATION.md)；位投影的不变量在 [DESIGN.md](DESIGN.md)；第三方库边界在 [LIBRARY.md](LIBRARY.md)。

所有修改位于独立 worktree /root/code/voracious_sort-pa-structural 的 experiments/block_msd；原 master 工作区和 frozen Block LSD 实现保持原状。

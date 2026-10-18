# PA 优化当前交付状态

当前保存的是硬件分类器的局部修正检查点，尚未完成整体性能验收。详见 [HARDWARE_CHECKPOINT.md](HARDWARE_CHECKPOINT.md)。

硬件压紧由 pinned hakmem 0.2.0 提供；生产 PA 不选择软件压紧，没有可用硬件 token 时使用原 PA。31ff0d2 删除连续字段分支后，百万条 u32 sparse 在 B64/B512 的新/旧 PA 配对中位数为 0.849/0.870，p90 均小于 1。这里硬件压紧仍启用，不能解释成阈值避开了压紧。清理后源码 5f6d211 的两组完整库测试各 57 项、runner 4 项和两个交叉检查均通过；其独立 work 记录确认硬件投影节点实际执行。

这两个 cell 的局部成功不能支持“全部场景无退化”。最终源码的原 103 场景及普通编译目标性能仍待验证。当前按用户要求停止准入阈值方向，保留此检查点，重新审视能够同时减少各类输入重复工作的统一路线。

历史实验与失败证据的边界在 [COHORTS.md](COHORTS.md)，不能因文件名含 final 或总体胜出数较多就视为接受。旧机制泛化的独立审计与被否决的集合多数实验在 [GENERALIZATION.md](GENERALIZATION.md)；位投影的不变量在 [DESIGN.md](DESIGN.md)；第三方库边界在 [LIBRARY.md](LIBRARY.md)。

所有修改位于独立 worktree /root/code/voracious_sort-pa-structural 的 experiments/block_msd；原 master 工作区和 frozen Block LSD 实现保持原状。

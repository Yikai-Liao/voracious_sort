# 散射循环首屏：两个机制均未通过保护例

本轮没有达到持续Goal。桶表长度证明、四条小记录预读及其组合均未修复`u16 sparse`落后Stable MSD的问题；活动实现将撤掉这三个变体。冻结源码提交`8fc91c0`、time ELF及全部负结果继续保留，不运行本轮的final/heldout预案。新seed20261018仍未使用。

本轮沿用统一Pa的节点协议、prepared变化位复用、64点成本拒绝、16MiB离线阈值和稳定叶子，仅改变同一Block scatter。没有外部键宽路由、额外整数组buffer或unsafe索引。各机制与静态汇编目标见[METHODS](METHODS.md)和[profile说明](profile/README.md)。反汇编证实两个预期改动确实生成；源码意图和机器码变化都不足以证明实际收益。

## 主要负结果

时间单位ms，均为同一冻结ELF的4次首屏中位数；最后三列为逐rep候选/prepared比值的中位数，不是两个时间中位数相除。

|n/B/layout/case|prepared|fixed|preload|combined|Stable|fixed/prepared|preload/prepared|combined/prepared|
|---|---:|---:|---:|---:|---:|---:|---:|---:|
|1m/64/u16/sparse|3.536|3.858|3.617|3.825|3.224|1.090|1.017|1.081|
|1m/64/u8/sparse|3.584|3.709|3.902|3.736|3.347|1.035|1.092|1.033|
|1m/64/u16_id8/sparse|4.245|4.153|4.973|5.071|5.905|0.978|1.183|1.219|
|1m/64/u8_id8/sparse|4.934|4.403|5.663|5.373|6.516|0.909|1.156|1.095|
|1m/512/large128/uniform|190.567|191.377|192.429|196.590|218.837|1.015|1.010|1.027|
|1m/512/large128/majority_prefix|197.479|202.249|239.481|216.481|400.697|1.043|1.177|1.115|

`u16 sparse`的fixed/prepared四个比值为1.123、1.034、1.111、1.069，组合为1.108、1.171、1.054、1.007，均未改善；preload为1.073、1.009、1.026、0.977。该cell的Pa固定slot7/0 A/A p10/p90为0.943/1.021。preload比Stable仍慢，配对中位数1.103；不能把约2%的preload/prepared差异说成稳定回退，也不能称其修好了已知差距。

`u16_id8 sparse`的preload/prepared四个比值为1.280、1.348、1.086、1.011，组合为1.262、1.589、1.177、1.047，提示明显新增成本。fixed在部分ID布局较快，同时原生u16较慢；不能据此按类型挑选独立排序器。

宽记录preload走原复制fallback；其相对prepared的墙钟差异不能归因于直接预读收益或开销。B512大记录多数前缀等差异仍须作为整个候选ELF的观测保留，并考虑代码生成、执行顺序和宿主波动。其他cell的A/A有较大偏移，例如medium u128 uniform p90约1.795；不据小样本均值或跨场景平均选择赢家。完整逐cell结果见review-screen.csv、4份summary与noise。

## 编译成本与后续边界

Debug/feature检查通过后，release构建用时10m56s；上一阶段构建3m47s。本轮ELF为125,784,184字节。两个const bool与每个T/分类器/常量BYTE交叉实例化，并且FULL=true在step_impl内内联了常量字节循环；u16 fixed/combined的整个step_impl分别为0x5ae4/0x5eaf字节。这个表达造成可见的编译与代码体积膨胀，且首屏没有给出保留机制的理由。

历史构建显式使用`CARGO_INCREMENTAL=0`；依赖/整crate的Cargo产物缓存仍存在，但crate内部增量关闭。该命令与本轮历史证据保持不变。后续开发筛选启用增量、复用同一target、使用明确的6个Cargo jobs，先只实例化待修负例的四个窄布局；完整确认仍固定构建参数、源码和ELF。窄范围筛选是构建harness约束，不改变排序器对外的统一机制。未开始的新profile/缓存设置不算本轮已完成验证。

## 完成范围

四份时间文件依次256、96、288、32行，共672行/21个完整cell。每行warmup与计时后均通过完整稳定oracle；时间内含排序自身工作区申请/释放，输入恢复、生成和oracle在时间外。同一实际分配复用；方法旋转及反向顺序、固定CPU2、Pa双slot。未与历史ELF或不同n/B/seed合并重复。

30项针对性库测试、1项工作负载测试和all-targets/all-features检查通过。库测试包含转换浮点顺序、稳定完整payload、R2/256、奇数B、全部短尾和宽记录fallback，新增scatter work检查使用frontier_work。正式时间ELF未启用计数器。156项源码及ELF hash、672行slot/rep/地址/参数完整性已核对。未运行本轮ASan、release-work、独立work或heap测量；首屏失败后停止扩展。final.sh、heldout.sh和review_matrix.py均为未执行预案，不代表通过验收。

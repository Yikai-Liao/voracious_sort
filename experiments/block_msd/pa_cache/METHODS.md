# Goal 第二轮：有成本门槛的局部完成

沿用[独立首屏](../pa_goal1/REPORT.md)中的四种机制和全部旧控制。新增 `Pa_band_cache` 只给旧Band启用以下分发门槛；`Pa_unified_cache` 将内层终止前缀、稳定库叶子、分块顺序证明与此门槛组合。旧always-local和原组合保留为负对照。

只对多活跃字节、且整段不能用Dense的节点评估局部完成。先要求原workspace预算 `512*B*sizeof(T)` 大于显式的 `workspace_threshold`，再完整扫描最高活跃标签字节，使用256项栈直方图；只有全部实际高位桶都符合原低字节Dense准入才执行高位Block+局部Dense。拒绝时直接使用已有variation完成原整段Block，不重扫变异、不提前搬动记录。完整计入新增直方图扫描。

`workspace_threshold` 是离线调参超参数，算法不查询或推断实际 L2。1MiB仅为初始参考值；首屏固定比较0、256KiB、1MiB、4MiB、16MiB和关闭局部完成六项，保留负结果，再以未见seed复核一个选定值。它不改变分配预算，也不是按键宽外部选择LSD/MSD。实验入口 `sort_pa_with_threshold` 显式接收该值，runner方法名 `_t<字节数>` 将每行参数保存在原始证据中。直方图给出实际人口而非采样估计，避免大高位组再次走Block而多付compact。

分发的分类、稳定性、每记录活跃字节数、工作区释放后再递归的所有权均不变。空间公式和计数解释沿用[首轮方法](../pa_goal1/METHODS.md)，实际heap必须独立测量。`terminal_band_nodes`记录真正获准的内层区间。默认主库入口不变。

持续Goal仍未完成；首屏通过后才安排百万条12次、反向配对、新seed、B512、小规模与全部native宽度保护检查。除速度外，要求完整稳定oracle、A/A波动、ASan和独立工作/内存账本。

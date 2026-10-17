# 复用已准备的标签变化位

阈值固定16MiB，为已完成离线筛测的超参数，不查询硬件。本轮目标是省去节点准备之后、分发之前重复的一遍标签扫描。分发协议新增可选的label mask：None保持原扫描；Some(mask)必须覆盖当前标签所有变异位，Some(0)表示已经证明标签常量。该mask可包含额外位，不能遗漏实际变化位。它不是按键宽选择独立排序器。

Prefix的精确mask由((union ^ intersection) >> low) & prefix_mask得到，Identity为union ^ intersection。三路区间标签仅为0/1/2，mask=3完整覆盖；Frontier等非线性映射保留None。在物理分发结束后，递归边界与remaining继续使用原分类器。纯Prefix/Identity减少每节点n次label_records和n+1次label_evals，其他分发工作应不变；三路保守mask最多激活相同的一个字节。选定候选不启用上一轮未通过窄键负例的dynamic radix。

|方法|基于同一统一节点的新增项|
|---|---|
|Pa_unified_cache_t16777216|旧精确直方图成本门|
|Pa_unified_sample_t16777216|旧变化位扫描+64点采样拒绝|
|Pa_unified_reuse_t16777216|复用变化位，不加64点拒绝|
|Pa_unified_prepared_t16777216|复用变化位+64点拒绝|

64点拒绝是成本预测，放行仍需精确人口直方图批准。采样误拒只损失性能机会；接受与拒绝都执行完整稳定排序。Block/Dense预算、workspace释放后递归、既有叶子上限保持同一协议。统一候选的stable库叶子新增heap仍需实测，requested heap不能等同RSS或stack。

先完成小型正负屏；失败机制保留原始证据并停止该方向，不能用部分收益宣告Goal完成。通过后按固定ACCEPTANCE.md完成见过种子、work/heap/ASan，最后才运行新seed20261018，不按该seed调机制。

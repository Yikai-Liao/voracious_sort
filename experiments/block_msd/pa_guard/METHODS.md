# 统一节点：采样成本门与缩小桶数

本轮基于已冻结的 pa_cache（source-commit.txt）。workspace_threshold 固定为离线首屏选出的 16 MiB，排序器不查询缓存或硬件；原始方法后缀、JSON命令均保留此数值。此参数只决定是否考虑局部完成，不改变原来的 Block/Dense 分配预算。

三项独立方法共享 terminal、嵌套多数前缀、稳定叶子及分块有序证明：

|方法|相对 Pa_unified_cache_t16777216 的新增机制|
|---|---|
|Pa_unified_sample_t16777216|全量高字节直方图前的64点成本拒绝|
|Pa_unified_radix_t16777216|Block按实际字节变化范围缩小桶数|
|Pa_unified_candidate_t16777216|前两项组合|

采样覆盖首尾、等间距64个不同索引。样本最大桶计数 k 预测 ceil(n*k/64)；该预测不满足既有低位Dense预算时，立即执行原整段分发。放行仍需全量精确直方图批准。样本只影响成本选择，排序正确性不依赖代表性；它可能误拒有利的局部分发。索引和人口预测用商余分解避免乘法溢出，新增计数64次label_records，无新增heap。

缩桶复用既有 variation：对实际处理的每个字节 d，所有label_d都等于(label_d & variation_d)再加上共同常量位。因此去掉常量位保持该字节的顺序和相等关系；最大归一化digit不超过variation_d。取这些字节的最大值r，只有r<255才用normalized label及R=r+1。当前可达路径R在2..256；R可非二次幂且可有空桶。普通r=255和Dense保留原提取。high-only首轮的证明仅针对高字节，不要求被忽略的低位为常量。

所有原活跃字节仍分别散射，终端和子区间边界使用原分类器。根scratch在子区间前释放。缩桶Block峰值可下降，但后续Dense可能大于缩桶后的根scratch；组合不能据此宣称等峰值。仍按原全256桶预算包络验收，并独立测requested heap（不能等同RSS/stack）。

首屏先检查已知负例及正对照，不碰新seed。通过后再完成 ACCEPTANCE.md 的有限矩阵及独立work/heap/ASan。Frozen LSD和Stable MSD保持对照，部分场景加速不满足Goal。

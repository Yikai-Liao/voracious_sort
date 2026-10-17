# 固定验收范围

此表在阈值调参和新seed计时前固定。Goal包含已知退化的修复，不能只以部分提速或跨场景平均通过。所有正式时间12次、旋转/相邻反向；Pa双slot提供逐场景A/A。当前共享宿主环境对小差距的分辨率有限，范围内持平只能按证据表达。

pa_cache已完成六值离线阈值首屏，本轮固定16MiB。首屏候选为fixed-table、preload及组合三个独立对照；主表候选将在相同参数首屏后选定，当前脚本中的Pa_unified_backend_t16777216仅为预案占位。先通过已见种子保护与work/heap/ASan，再用新seed `20261018` 验证；不按新seed调参。seed7历史已见过，仅作旧种子复核。

|验收组|范围|
|---|---|
|全异/重复偏斜|1m/B64；u64,u128,wide32；deep_skew,majority_prefix,deep_unique90,deep_unique98；seed42及20261018|
|已知种子翻转|1m/B64/u64/deep_unique90/seed7|
|B512结构复核|1m/seed42；u64,u128,wide32；上述四种偏斜|
|普通与稀疏保护|1m/B64/seed42；全部10布局；uniform,sparse|
|局部门槛可生效域|1m/B512/seed42；u64,u128,u16_id8,small8,wide32,large128；uniform,sparse；按选定阈值说明实际启用情况|
|窄键旧多数负例|1m/B64；u8,u16,u8_id8,u16_id8；deep_skew|
|顺序/全等|16384及1m/B64；u8,u16,u128,wide32；equal,sorted,reverse|
|大payload旧负例|1m/B512/large128；uniform,deep_skew,majority_prefix|
|局部完成旧负例|262144/B64/u128；uniform,majority_prefix,deep_unique90|

主表使用Pa、旧Pa_band、选定参数的统一候选、Frozen LSD、Stable MSD、Pa。独立机制表额外保留Pa_band_nested、Pa_band_sortleaf、Pa_ordered_tiled、相同参数fixed/preload/backend及prepared对照；不在全矩阵重复所有失败候选。

独立work覆盖u64全异90 seed42两种B、wide32共享/全异98、B512large均匀和多数前缀；heap覆盖全部布局B64均匀、可启用域B512均匀/稀疏及前述关键偏斜，计入稳定库叶子。完整稳定oracle、转换键矩阵、阈值/人口边界、内层拒绝回外层、debug/release-work/ASan、最终源码与ELF hash均必需。

如果u8/u16 sparse、wide32小规模ordered/equal/reverse、u64新seed/B512、大payload多数共享前缀或普通输入仍存在明显稳定差距/新增回退，Goal继续。辅助空间应保留Block优势；不以新增与n成比例的整记录buffer换速。主库默认路径保持隔离，实测requested heap不能等同stack/RSS。

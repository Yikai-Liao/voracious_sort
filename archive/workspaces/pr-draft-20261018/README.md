# PR 提交材料

- 标题：`PR-title.txt`。
- 正文：`PR-body.md`，英文，可直接粘贴；对应本地新增自适应封装：公开两参数入口，手动块长内核私有。
- 当前接口说明：`API.md`。

GitHub 选择 base 仓库 `lakwet/voracious_sort` 的 `master`，head 仓库 `Yikai-Liao/voracious_sort` 的 `block-lsd`。提交前核对远端 head 包含本地准备提交的最终代码；本材料不会创建或发布 PR。

先粘贴正文，然后在四个 HTML 注释位置依次拖入对应 PNG，使用 GitHub 自动生成的图片链接替换注释。PNG 用于页面阅读，PDF/SVG 用于放大查看和后续编辑。

| 顺序 | 图片 | 用途 |
| --- | --- | --- |
| 1 | `figures/01b-efficiency-overview.png` | 正文总览：时间与额外堆、内存条件计数、整体性能分布 |
| 2 | `figures/03-native-lsd-variants.png` | 库内普通 LSD、纯 core、counting heuristic，逐类型、逐分布比较 |
| 3 | `figures/04-native-radix-variants.png` | DLSD、Thiel、专用 u32/f32 内核，逐类型、逐分布比较 |
| 4 | `figures/01-algorithm-comparison.png` | 放入折叠详情：LSD stable、Driftsort、TimSort |

全部图采用已有实测数据；原始冻结包保持不变。内核保持原版，新增公开封装选择相同实参；图中时间不包含封装的选参开销。没有热力图或全局 min-max 归一化。每个详细面板固定一种类型，23 个分布逐行显示，1 为明确的等速线，范围 1/8–64；慢点和极端值均保留。未支持的类型不伪造数据。

图 1 的跨工况曲线与误差线分别表示输入差异、观测范围；图 2/3 直接使用比较器与候选各自的时间中位数之比，图 4 使用已有同条件配对比的中位数倒数。图注分别定义，不将这些统计量混用。

性能图统一写 Driftsort。工具链是实测 Rust 1.98.1；本机对应标准库源码与官方 `slice::sort_by_key` 文档均确认该实现。原始 `std` 数据标签保持不变。

复现绘图：在安装 matplotlib/numpy 的 Python 中运行 `plot_story.py`。`data/` 含绘图所需 CSV、native 观察值与候选实际实参观察值；`prepare_native.py` 为从冻结包重新生成这些表的来源脚本，不运行任何排序计时。`qa/` 保留数据摘要校验、面板对齐、字体、碰撞和人工验收记录。

当前自动封装验证：默认 release 10 个单元测试、5 个集成测试和 4 个文档测试通过；全部 feature release 98 个单元测试、5 个集成测试和 4 个文档测试通过，各有 1 个原有忽略示例。格式检查与 diff 检查通过。代码尚未提交/推送；原版内核保留分支不变。`source/CHANGE.diff` 和源码快照可用于复核本地改动，`qa/adaptive-validation.json` 记录源码摘要与验证结果。

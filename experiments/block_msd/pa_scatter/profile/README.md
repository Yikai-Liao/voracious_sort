# 冻结 ELF 的静态循环核对

ELF与源码见上级hash清单及提交8fc91c0；本目录不含动态profile时间或新增perf采样。`u16-symbols-demangled.txt`由`nm -C -S --defined-only`筛出u16/Identity的具体单态化符号，`u16-identity-dwarf.txt`由extract_dwarf.py读取同一ELF的DWARF声明。u16-symbols.json将DWARF linkage与nm地址连接，FULL变体存在被内联/合并的条目，其None不是“无该路径”。最终具体FULL地址以demangled符号表为准。

原byte0在0x37ec58读取一条u16，0x37ec61/64逐记录比较桶表长度；fixed step的byte0在0x3d1d03读取后直接由低8位索引桶（0x3d1d09..20），该桶索引检查已消除，perm、usage及块满检查仍保留。FULL长度证明位于该loop之前。

preload byte0于0x37f2ad、c3、c9、cf读取四条u16，首个记录store在0x37f2e8；combined于0x3cbea3、a9、af、b5读取四条，首store在0x3cbed0。两个目标确实生成，未据此宣称墙钟收益。所有反汇编文件使用对应符号的起始地址与nm size作为半开区间导出。

本次构建存在编译膨胀：FULL=true的step_impl中包含内联的常量字节分支（fixed函数size 0x5ae4，combined 0x5eaf），原byte0 scatter函数size仅0x627；两个const bool与各T/分类器/BYTE实例交叉后release用时10m56s。该证据用于后续收窄实例化与内联边界，不把当前编译成本隐藏在性能结果后。


experiments/block_msd/target/pa-groups-final/time:     file format elf64-x86-64


Disassembly of section .text:

00000000002fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>:
  2fe800:	41 57                	push   %r15
  2fe802:	41 56                	push   %r14
  2fe804:	53                   	push   %rbx
  2fe805:	48 8b 07             	mov    (%rdi),%rax
  2fe808:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  2fe80c:	4c 8b 00             	mov    (%rax),%r8
  2fe80f:	48 8b 01             	mov    (%rcx),%rax
  2fe812:	48 8b 00             	mov    (%rax),%rax
  2fe815:	48 8b 00             	mov    (%rax),%rax
  2fe818:	0f b6 08             	movzbl (%rax),%ecx
  2fe81b:	c4 c2 73 f7 14 f0    	shrx   %ecx,(%r8,%rsi,8),%edx
  2fe821:	23 50 08             	and    0x8(%rax),%edx
  2fe824:	c1 ea 10             	shr    $0x10,%edx
  2fe827:	0f b6 c2             	movzbl %dl,%eax
  2fe82a:	4c 8b 4f 10          	mov    0x10(%rdi),%r9
  2fe82e:	49 8b 49 08          	mov    0x8(%r9),%rcx
  2fe832:	48 39 c1             	cmp    %rax,%rcx
  2fe835:	0f 86 dd 00 00 00    	jbe    2fe918 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}+0x118>
  2fe83b:	4d 8b 09             	mov    (%r9),%r9
  2fe83e:	89 c3                	mov    %eax,%ebx
  2fe840:	c1 e3 04             	shl    $0x4,%ebx
  2fe843:	49 8b 0c 19          	mov    (%r9,%rbx,1),%rcx
  2fe847:	49 8b 34 f0          	mov    (%r8,%rsi,8),%rsi
  2fe84b:	4c 8d 41 08          	lea    0x8(%rcx),%r8
  2fe84f:	4d 3b 44 19 08       	cmp    0x8(%r9,%rbx,1),%r8
  2fe854:	48 89 31             	mov    %rsi,(%rcx)
  2fe857:	4d 89 04 19          	mov    %r8,(%r9,%rbx,1)
  2fe85b:	74 06                	je     2fe863 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}+0x63>
  2fe85d:	5b                   	pop    %rbx
  2fe85e:	41 5e                	pop    %r14
  2fe860:	41 5f                	pop    %r15
  2fe862:	c3                   	ret
  2fe863:	4c 8b 47 18          	mov    0x18(%rdi),%r8
  2fe867:	4c 8b 57 28          	mov    0x28(%rdi),%r10
  2fe86b:	4d 8b 1a             	mov    (%r10),%r11
  2fe86e:	49 8b 08             	mov    (%r8),%rcx
  2fe871:	49 8b 73 28          	mov    0x28(%r11),%rsi
  2fe875:	48 39 f1             	cmp    %rsi,%rcx
  2fe878:	0f 83 ad 00 00 00    	jae    2fe92b <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}+0x12b>
  2fe87e:	4d 8b 73 20          	mov    0x20(%r11),%r14
  2fe882:	41 8b 0c 8e          	mov    (%r14,%rcx,4),%ecx
  2fe886:	48 39 ce             	cmp    %rcx,%rsi
  2fe889:	76 74                	jbe    2fe8ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}+0xff>
  2fe88b:	49 01 d9             	add    %rbx,%r9
  2fe88e:	49 8b 73 78          	mov    0x78(%r11),%rsi
  2fe892:	49 8b 9b 88 00 00 00 	mov    0x88(%r11),%rbx
  2fe899:	45 31 f6             	xor    %r14d,%r14d
  2fe89c:	45 31 ff             	xor    %r15d,%r15d
  2fe89f:	48 39 cb             	cmp    %rcx,%rbx
  2fe8a2:	41 0f 97 c7          	seta   %r15b
  2fe8a6:	4c 0f 46 f3          	cmovbe %rbx,%r14
  2fe8aa:	4c 29 f1             	sub    %r14,%rcx
  2fe8ad:	41 c1 e7 04          	shl    $0x4,%r15d
  2fe8b1:	48 0f af ce          	imul   %rsi,%rcx
  2fe8b5:	48 c1 e1 03          	shl    $0x3,%rcx
  2fe8b9:	4b 03 8c 1f 90 00 00 	add    0x90(%r15,%r11,1),%rcx
  2fe8c0:	00 
  2fe8c1:	48 8d 34 f1          	lea    (%rcx,%rsi,8),%rsi
  2fe8c5:	49 89 09             	mov    %rcx,(%r9)
  2fe8c8:	49 89 71 08          	mov    %rsi,0x8(%r9)
  2fe8cc:	4d 8b 0a             	mov    (%r10),%r9
  2fe8cf:	49 8b 08             	mov    (%r8),%rcx
  2fe8d2:	49 8b 71 58          	mov    0x58(%r9),%rsi
  2fe8d6:	48 39 f1             	cmp    %rsi,%rcx
  2fe8d9:	73 60                	jae    2fe93b <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}+0x13b>
  2fe8db:	49 8b 71 50          	mov    0x50(%r9),%rsi
  2fe8df:	88 14 0e             	mov    %dl,(%rsi,%rcx,1)
  2fe8e2:	48 8b 4f 30          	mov    0x30(%rdi),%rcx
  2fe8e6:	48 8b 71 08          	mov    0x8(%rcx),%rsi
  2fe8ea:	48 39 c6             	cmp    %rax,%rsi
  2fe8ed:	76 5c                	jbe    2fe94b <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}+0x14b>
  2fe8ef:	48 8b 09             	mov    (%rcx),%rcx
  2fe8f2:	48 ff 04 c1          	incq   (%rcx,%rax,8)
  2fe8f6:	49 ff 00             	incq   (%r8)
  2fe8f9:	5b                   	pop    %rbx
  2fe8fa:	41 5e                	pop    %r14
  2fe8fc:	41 5f                	pop    %r15
  2fe8fe:	c3                   	ret
  2fe8ff:	48 8d 3d 2d 78 d1 ff 	lea    -0x2e87d3(%rip),%rdi        # 16133 <anon.8f17df2f0ddc4723825c0f55871536dc.0.llvm.6863592281246770637+0xf3>
  2fe906:	48 8d 15 4b 8d 2c 00 	lea    0x2c8d4b(%rip),%rdx        # 5c7658 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x370>
  2fe90d:	be 2c 00 00 00       	mov    $0x2c,%esi
  2fe912:	ff 15 98 3f 2d 00    	call   *0x2d3f98(%rip)        # 5d28b0 <_DYNAMIC+0x290>
  2fe918:	48 8d 15 61 8c 2c 00 	lea    0x2c8c61(%rip),%rdx        # 5c7580 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x298>
  2fe91f:	48 89 c7             	mov    %rax,%rdi
  2fe922:	48 89 ce             	mov    %rcx,%rsi
  2fe925:	ff 15 9d 3f 2d 00    	call   *0x2d3f9d(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  2fe92b:	48 8d 15 66 8c 2c 00 	lea    0x2c8c66(%rip),%rdx        # 5c7598 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x2b0>
  2fe932:	48 89 cf             	mov    %rcx,%rdi
  2fe935:	ff 15 8d 3f 2d 00    	call   *0x2d3f8d(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  2fe93b:	48 8d 15 6e 8c 2c 00 	lea    0x2c8c6e(%rip),%rdx        # 5c75b0 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x2c8>
  2fe942:	48 89 cf             	mov    %rcx,%rdi
  2fe945:	ff 15 7d 3f 2d 00    	call   *0x2d3f7d(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  2fe94b:	48 8d 15 76 8c 2c 00 	lea    0x2c8c76(%rip),%rdx        # 5c75c8 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x2e0>
  2fe952:	48 89 c7             	mov    %rax,%rdi
  2fe955:	ff 15 6d 3f 2d 00    	call   *0x2d3f6d(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>


experiments/block_msd/target/pa-groups-final/time:     file format elf64-x86-64


Disassembly of section .text:

00000000002fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>:
  2fe6a0:	41 57                	push   %r15
  2fe6a2:	41 56                	push   %r14
  2fe6a4:	53                   	push   %rbx
  2fe6a5:	48 8b 07             	mov    (%rdi),%rax
  2fe6a8:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  2fe6ac:	4c 8b 00             	mov    (%rax),%r8
  2fe6af:	48 8b 01             	mov    (%rcx),%rax
  2fe6b2:	48 8b 00             	mov    (%rax),%rax
  2fe6b5:	48 8b 00             	mov    (%rax),%rax
  2fe6b8:	0f b6 08             	movzbl (%rax),%ecx
  2fe6bb:	c4 c2 73 f7 14 f0    	shrx   %ecx,(%r8,%rsi,8),%edx
  2fe6c1:	23 50 08             	and    0x8(%rax),%edx
  2fe6c4:	c1 ea 08             	shr    $0x8,%edx
  2fe6c7:	0f b6 c2             	movzbl %dl,%eax
  2fe6ca:	4c 8b 4f 10          	mov    0x10(%rdi),%r9
  2fe6ce:	49 8b 49 08          	mov    0x8(%r9),%rcx
  2fe6d2:	48 39 c1             	cmp    %rax,%rcx
  2fe6d5:	0f 86 dd 00 00 00    	jbe    2fe7b8 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}+0x118>
  2fe6db:	4d 8b 09             	mov    (%r9),%r9
  2fe6de:	89 c3                	mov    %eax,%ebx
  2fe6e0:	c1 e3 04             	shl    $0x4,%ebx
  2fe6e3:	49 8b 0c 19          	mov    (%r9,%rbx,1),%rcx
  2fe6e7:	49 8b 34 f0          	mov    (%r8,%rsi,8),%rsi
  2fe6eb:	4c 8d 41 08          	lea    0x8(%rcx),%r8
  2fe6ef:	4d 3b 44 19 08       	cmp    0x8(%r9,%rbx,1),%r8
  2fe6f4:	48 89 31             	mov    %rsi,(%rcx)
  2fe6f7:	4d 89 04 19          	mov    %r8,(%r9,%rbx,1)
  2fe6fb:	74 06                	je     2fe703 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}+0x63>
  2fe6fd:	5b                   	pop    %rbx
  2fe6fe:	41 5e                	pop    %r14
  2fe700:	41 5f                	pop    %r15
  2fe702:	c3                   	ret
  2fe703:	4c 8b 47 18          	mov    0x18(%rdi),%r8
  2fe707:	4c 8b 57 28          	mov    0x28(%rdi),%r10
  2fe70b:	4d 8b 1a             	mov    (%r10),%r11
  2fe70e:	49 8b 08             	mov    (%r8),%rcx
  2fe711:	49 8b 73 28          	mov    0x28(%r11),%rsi
  2fe715:	48 39 f1             	cmp    %rsi,%rcx
  2fe718:	0f 83 ad 00 00 00    	jae    2fe7cb <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}+0x12b>
  2fe71e:	4d 8b 73 20          	mov    0x20(%r11),%r14
  2fe722:	41 8b 0c 8e          	mov    (%r14,%rcx,4),%ecx
  2fe726:	48 39 ce             	cmp    %rcx,%rsi
  2fe729:	76 74                	jbe    2fe79f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}+0xff>
  2fe72b:	49 01 d9             	add    %rbx,%r9
  2fe72e:	49 8b 73 78          	mov    0x78(%r11),%rsi
  2fe732:	49 8b 9b 88 00 00 00 	mov    0x88(%r11),%rbx
  2fe739:	45 31 f6             	xor    %r14d,%r14d
  2fe73c:	45 31 ff             	xor    %r15d,%r15d
  2fe73f:	48 39 cb             	cmp    %rcx,%rbx
  2fe742:	41 0f 97 c7          	seta   %r15b
  2fe746:	4c 0f 46 f3          	cmovbe %rbx,%r14
  2fe74a:	4c 29 f1             	sub    %r14,%rcx
  2fe74d:	41 c1 e7 04          	shl    $0x4,%r15d
  2fe751:	48 0f af ce          	imul   %rsi,%rcx
  2fe755:	48 c1 e1 03          	shl    $0x3,%rcx
  2fe759:	4b 03 8c 1f 90 00 00 	add    0x90(%r15,%r11,1),%rcx
  2fe760:	00 
  2fe761:	48 8d 34 f1          	lea    (%rcx,%rsi,8),%rsi
  2fe765:	49 89 09             	mov    %rcx,(%r9)
  2fe768:	49 89 71 08          	mov    %rsi,0x8(%r9)
  2fe76c:	4d 8b 0a             	mov    (%r10),%r9
  2fe76f:	49 8b 08             	mov    (%r8),%rcx
  2fe772:	49 8b 71 58          	mov    0x58(%r9),%rsi
  2fe776:	48 39 f1             	cmp    %rsi,%rcx
  2fe779:	73 60                	jae    2fe7db <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}+0x13b>
  2fe77b:	49 8b 71 50          	mov    0x50(%r9),%rsi
  2fe77f:	88 14 0e             	mov    %dl,(%rsi,%rcx,1)
  2fe782:	48 8b 4f 30          	mov    0x30(%rdi),%rcx
  2fe786:	48 8b 71 08          	mov    0x8(%rcx),%rsi
  2fe78a:	48 39 c6             	cmp    %rax,%rsi
  2fe78d:	76 5c                	jbe    2fe7eb <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}+0x14b>
  2fe78f:	48 8b 09             	mov    (%rcx),%rcx
  2fe792:	48 ff 04 c1          	incq   (%rcx,%rax,8)
  2fe796:	49 ff 00             	incq   (%r8)
  2fe799:	5b                   	pop    %rbx
  2fe79a:	41 5e                	pop    %r14
  2fe79c:	41 5f                	pop    %r15
  2fe79e:	c3                   	ret
  2fe79f:	48 8d 3d 8d 79 d1 ff 	lea    -0x2e8673(%rip),%rdi        # 16133 <anon.8f17df2f0ddc4723825c0f55871536dc.0.llvm.6863592281246770637+0xf3>
  2fe7a6:	48 8d 15 ab 8e 2c 00 	lea    0x2c8eab(%rip),%rdx        # 5c7658 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x370>
  2fe7ad:	be 2c 00 00 00       	mov    $0x2c,%esi
  2fe7b2:	ff 15 f8 40 2d 00    	call   *0x2d40f8(%rip)        # 5d28b0 <_DYNAMIC+0x290>
  2fe7b8:	48 8d 15 c1 8d 2c 00 	lea    0x2c8dc1(%rip),%rdx        # 5c7580 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x298>
  2fe7bf:	48 89 c7             	mov    %rax,%rdi
  2fe7c2:	48 89 ce             	mov    %rcx,%rsi
  2fe7c5:	ff 15 fd 40 2d 00    	call   *0x2d40fd(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  2fe7cb:	48 8d 15 c6 8d 2c 00 	lea    0x2c8dc6(%rip),%rdx        # 5c7598 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x2b0>
  2fe7d2:	48 89 cf             	mov    %rcx,%rdi
  2fe7d5:	ff 15 ed 40 2d 00    	call   *0x2d40ed(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  2fe7db:	48 8d 15 ce 8d 2c 00 	lea    0x2c8dce(%rip),%rdx        # 5c75b0 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x2c8>
  2fe7e2:	48 89 cf             	mov    %rcx,%rdi
  2fe7e5:	ff 15 dd 40 2d 00    	call   *0x2d40dd(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  2fe7eb:	48 8d 15 d6 8d 2c 00 	lea    0x2c8dd6(%rip),%rdx        # 5c75c8 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x2e0>
  2fe7f2:	48 89 c7             	mov    %rax,%rdi
  2fe7f5:	ff 15 cd 40 2d 00    	call   *0x2d40cd(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>

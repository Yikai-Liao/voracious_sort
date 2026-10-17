
experiments/block_msd/target/pa-groups-final/time:     file format elf64-x86-64


Disassembly of section .text:

00000000002fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>:
  2fe540:	41 57                	push   %r15
  2fe542:	41 56                	push   %r14
  2fe544:	53                   	push   %rbx
  2fe545:	48 89 f8             	mov    %rdi,%rax
  2fe548:	48 8b 0f             	mov    (%rdi),%rcx
  2fe54b:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2fe54f:	4c 8b 01             	mov    (%rcx),%r8
  2fe552:	48 8b 0a             	mov    (%rdx),%rcx
  2fe555:	48 8b 09             	mov    (%rcx),%rcx
  2fe558:	48 8b 09             	mov    (%rcx),%rcx
  2fe55b:	0f b6 11             	movzbl (%rcx),%edx
  2fe55e:	c4 c2 6b f7 14 f0    	shrx   %edx,(%r8,%rsi,8),%edx
  2fe564:	23 51 08             	and    0x8(%rcx),%edx
  2fe567:	0f b6 fa             	movzbl %dl,%edi
  2fe56a:	4c 8b 48 10          	mov    0x10(%rax),%r9
  2fe56e:	49 8b 49 08          	mov    0x8(%r9),%rcx
  2fe572:	48 39 f9             	cmp    %rdi,%rcx
  2fe575:	0f 86 dd 00 00 00    	jbe    2fe658 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}+0x118>
  2fe57b:	4d 8b 09             	mov    (%r9),%r9
  2fe57e:	89 fb                	mov    %edi,%ebx
  2fe580:	c1 e3 04             	shl    $0x4,%ebx
  2fe583:	49 8b 0c 19          	mov    (%r9,%rbx,1),%rcx
  2fe587:	49 8b 34 f0          	mov    (%r8,%rsi,8),%rsi
  2fe58b:	4c 8d 41 08          	lea    0x8(%rcx),%r8
  2fe58f:	4d 3b 44 19 08       	cmp    0x8(%r9,%rbx,1),%r8
  2fe594:	48 89 31             	mov    %rsi,(%rcx)
  2fe597:	4d 89 04 19          	mov    %r8,(%r9,%rbx,1)
  2fe59b:	74 06                	je     2fe5a3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}+0x63>
  2fe59d:	5b                   	pop    %rbx
  2fe59e:	41 5e                	pop    %r14
  2fe5a0:	41 5f                	pop    %r15
  2fe5a2:	c3                   	ret
  2fe5a3:	4c 8b 40 18          	mov    0x18(%rax),%r8
  2fe5a7:	4c 8b 50 28          	mov    0x28(%rax),%r10
  2fe5ab:	4d 8b 1a             	mov    (%r10),%r11
  2fe5ae:	49 8b 08             	mov    (%r8),%rcx
  2fe5b1:	49 8b 73 28          	mov    0x28(%r11),%rsi
  2fe5b5:	48 39 f1             	cmp    %rsi,%rcx
  2fe5b8:	0f 83 aa 00 00 00    	jae    2fe668 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}+0x128>
  2fe5be:	4d 8b 73 20          	mov    0x20(%r11),%r14
  2fe5c2:	41 8b 0c 8e          	mov    (%r14,%rcx,4),%ecx
  2fe5c6:	48 39 ce             	cmp    %rcx,%rsi
  2fe5c9:	76 74                	jbe    2fe63f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}+0xff>
  2fe5cb:	49 01 d9             	add    %rbx,%r9
  2fe5ce:	49 8b 73 78          	mov    0x78(%r11),%rsi
  2fe5d2:	49 8b 9b 88 00 00 00 	mov    0x88(%r11),%rbx
  2fe5d9:	45 31 f6             	xor    %r14d,%r14d
  2fe5dc:	45 31 ff             	xor    %r15d,%r15d
  2fe5df:	48 39 cb             	cmp    %rcx,%rbx
  2fe5e2:	41 0f 97 c7          	seta   %r15b
  2fe5e6:	4c 0f 46 f3          	cmovbe %rbx,%r14
  2fe5ea:	4c 29 f1             	sub    %r14,%rcx
  2fe5ed:	41 c1 e7 04          	shl    $0x4,%r15d
  2fe5f1:	48 0f af ce          	imul   %rsi,%rcx
  2fe5f5:	48 c1 e1 03          	shl    $0x3,%rcx
  2fe5f9:	4b 03 8c 1f 90 00 00 	add    0x90(%r15,%r11,1),%rcx
  2fe600:	00 
  2fe601:	48 8d 34 f1          	lea    (%rcx,%rsi,8),%rsi
  2fe605:	49 89 09             	mov    %rcx,(%r9)
  2fe608:	49 89 71 08          	mov    %rsi,0x8(%r9)
  2fe60c:	4d 8b 0a             	mov    (%r10),%r9
  2fe60f:	49 8b 08             	mov    (%r8),%rcx
  2fe612:	49 8b 71 58          	mov    0x58(%r9),%rsi
  2fe616:	48 39 f1             	cmp    %rsi,%rcx
  2fe619:	73 5d                	jae    2fe678 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}+0x138>
  2fe61b:	49 8b 71 50          	mov    0x50(%r9),%rsi
  2fe61f:	88 14 0e             	mov    %dl,(%rsi,%rcx,1)
  2fe622:	48 8b 40 30          	mov    0x30(%rax),%rax
  2fe626:	48 8b 70 08          	mov    0x8(%rax),%rsi
  2fe62a:	48 39 fe             	cmp    %rdi,%rsi
  2fe62d:	76 59                	jbe    2fe688 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}+0x148>
  2fe62f:	48 8b 00             	mov    (%rax),%rax
  2fe632:	48 ff 04 f8          	incq   (%rax,%rdi,8)
  2fe636:	49 ff 00             	incq   (%r8)
  2fe639:	5b                   	pop    %rbx
  2fe63a:	41 5e                	pop    %r14
  2fe63c:	41 5f                	pop    %r15
  2fe63e:	c3                   	ret
  2fe63f:	48 8d 3d ed 7a d1 ff 	lea    -0x2e8513(%rip),%rdi        # 16133 <anon.8f17df2f0ddc4723825c0f55871536dc.0.llvm.6863592281246770637+0xf3>
  2fe646:	48 8d 15 0b 90 2c 00 	lea    0x2c900b(%rip),%rdx        # 5c7658 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x370>
  2fe64d:	be 2c 00 00 00       	mov    $0x2c,%esi
  2fe652:	ff 15 58 42 2d 00    	call   *0x2d4258(%rip)        # 5d28b0 <_DYNAMIC+0x290>
  2fe658:	48 8d 15 21 8f 2c 00 	lea    0x2c8f21(%rip),%rdx        # 5c7580 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x298>
  2fe65f:	48 89 ce             	mov    %rcx,%rsi
  2fe662:	ff 15 60 42 2d 00    	call   *0x2d4260(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  2fe668:	48 8d 15 29 8f 2c 00 	lea    0x2c8f29(%rip),%rdx        # 5c7598 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x2b0>
  2fe66f:	48 89 cf             	mov    %rcx,%rdi
  2fe672:	ff 15 50 42 2d 00    	call   *0x2d4250(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  2fe678:	48 8d 15 31 8f 2c 00 	lea    0x2c8f31(%rip),%rdx        # 5c75b0 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x2c8>
  2fe67f:	48 89 cf             	mov    %rcx,%rdi
  2fe682:	ff 15 40 42 2d 00    	call   *0x2d4240(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  2fe688:	48 8d 15 39 8f 2c 00 	lea    0x2c8f39(%rip),%rdx        # 5c75c8 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x2e0>
  2fe68f:	ff 15 33 42 2d 00    	call   *0x2d4233(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>

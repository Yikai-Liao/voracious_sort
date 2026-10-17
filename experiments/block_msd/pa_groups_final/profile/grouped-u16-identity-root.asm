
experiments/block_msd/target/pa-groups-final/time:     file format elf64-x86-64


Disassembly of section .text:

0000000000275560 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>>:
  275560:	55                   	push   %rbp
  275561:	41 57                	push   %r15
  275563:	41 56                	push   %r14
  275565:	41 55                	push   %r13
  275567:	41 54                	push   %r12
  275569:	53                   	push   %rbx
  27556a:	48 81 ec c8 00 00 00 	sub    $0xc8,%rsp
  275571:	4c 89 8c 24 80 00 00 	mov    %r9,0x80(%rsp)
  275578:	00 
  275579:	4d 89 c5             	mov    %r8,%r13
  27557c:	49 89 f2             	mov    %rsi,%r10
  27557f:	48 8b 87 80 00 00 00 	mov    0x80(%rdi),%rax
  275586:	48 8b b7 a8 00 00 00 	mov    0xa8(%rdi),%rsi
  27558d:	4c 8b 7f 68          	mov    0x68(%rdi),%r15
  275591:	4c 8b 67 70          	mov    0x70(%rdi),%r12
  275595:	4c 8d 5f 78          	lea    0x78(%rdi),%r11
  275599:	48 39 f0             	cmp    %rsi,%rax
  27559c:	48 89 74 24 60       	mov    %rsi,0x60(%rsp)
  2755a1:	48 0f 47 f0          	cmova  %rax,%rsi
  2755a5:	45 31 c0             	xor    %r8d,%r8d
  2755a8:	49 89 c6             	mov    %rax,%r14
  2755ab:	eb 0f                	jmp    2755bc <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x5c>
  2755ad:	0f 1f 00             	nopl   (%rax)
  2755b0:	4d 89 d9             	mov    %r11,%r9
  2755b3:	49 ff c6             	inc    %r14
  2755b6:	49 83 39 00          	cmpq   $0x0,(%r9)
  2755ba:	75 2e                	jne    2755ea <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x8a>
  2755bc:	4c 39 f6             	cmp    %r14,%rsi
  2755bf:	0f 84 4e 07 00 00    	je     275d13 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x7b3>
  2755c5:	4d 39 e0             	cmp    %r12,%r8
  2755c8:	73 e6                	jae    2755b0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x50>
  2755ca:	4d 89 c1             	mov    %r8,%r9
  2755cd:	49 c1 e1 04          	shl    $0x4,%r9
  2755d1:	4f 3b 34 0f          	cmp    (%r15,%r9,1),%r14
  2755d5:	75 d9                	jne    2755b0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x50>
  2755d7:	4d 01 f9             	add    %r15,%r9
  2755da:	49 83 c1 08          	add    $0x8,%r9
  2755de:	49 ff c0             	inc    %r8
  2755e1:	49 ff c6             	inc    %r14
  2755e4:	49 83 39 00          	cmpq   $0x0,(%r9)
  2755e8:	74 d2                	je     2755bc <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x5c>
  2755ea:	48 8b 5f 28          	mov    0x28(%rdi),%rbx
  2755ee:	4d 8d 5e ff          	lea    -0x1(%r14),%r11
  2755f2:	49 39 db             	cmp    %rbx,%r11
  2755f5:	0f 83 eb 07 00 00    	jae    275de6 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x886>
  2755fb:	48 8b 77 20          	mov    0x20(%rdi),%rsi
  2755ff:	48 89 74 24 50       	mov    %rsi,0x50(%rsp)
  275604:	42 8b 74 b6 fc       	mov    -0x4(%rsi,%r14,4),%esi
  275609:	48 39 f3             	cmp    %rsi,%rbx
  27560c:	0f 86 16 07 00 00    	jbe    275d28 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x7c8>
  275612:	48 8b 6f 78          	mov    0x78(%rdi),%rbp
  275616:	4c 8b b7 88 00 00 00 	mov    0x88(%rdi),%r14
  27561d:	45 31 c9             	xor    %r9d,%r9d
  275620:	49 39 f6             	cmp    %rsi,%r14
  275623:	4c 8b 9f a0 00 00 00 	mov    0xa0(%rdi),%r11
  27562a:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
  27562f:	4c 8b 87 90 00 00 00 	mov    0x90(%rdi),%r8
  275636:	4c 89 f7             	mov    %r14,%rdi
  275639:	49 0f 47 f9          	cmova  %r9,%rdi
  27563d:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
  275642:	4c 89 5c 24 48       	mov    %r11,0x48(%rsp)
  275647:	4d 0f 47 c3          	cmova  %r11,%r8
  27564b:	48 29 fe             	sub    %rdi,%rsi
  27564e:	48 0f af f5          	imul   %rbp,%rsi
  275652:	41 0f b7 34 70       	movzwl (%r8,%rsi,2),%esi
  275657:	41 c1 e2 03          	shl    $0x3,%r10d
  27565b:	44 89 d7             	mov    %r10d,%edi
  27565e:	40 80 e7 08          	and    $0x8,%dil
  275662:	c4 e2 c3 f7 f6       	shrx   %rdi,%rsi,%rsi
  275667:	40 0f b6 fe          	movzbl %sil,%edi
  27566b:	0f b6 f2             	movzbl %dl,%esi
  27566e:	c4 62 48 f2 c7       	andn   %edi,%esi,%r8d
  275673:	c4 62 a9 f7 de       	shlx   %r10,%rsi,%r11
  275678:	41 f6 c2 40          	test   $0x40,%r10b
  27567c:	4d 0f 45 d9          	cmovne %r9,%r11
  275680:	4c 89 5c 24 20       	mov    %r11,0x20(%rsp)
  275685:	4c 89 44 24 30       	mov    %r8,0x30(%rsp)
  27568a:	4d 39 e8             	cmp    %r13,%r8
  27568d:	0f 83 66 07 00 00    	jae    275df9 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x899>
  275693:	4c 89 a4 24 a0 00 00 	mov    %r12,0xa0(%rsp)
  27569a:	00 
  27569b:	4c 89 7c 24 58       	mov    %r15,0x58(%rsp)
  2756a0:	48 09 f7             	or     %rsi,%rdi
  2756a3:	4c 39 ef             	cmp    %r13,%rdi
  2756a6:	0f 83 62 07 00 00    	jae    275e0e <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x8ae>
  2756ac:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
  2756b1:	c1 e2 04             	shl    $0x4,%edx
  2756b4:	48 01 ca             	add    %rcx,%rdx
  2756b7:	4c 8b 22             	mov    (%rdx),%r12
  2756ba:	48 89 94 24 90 00 00 	mov    %rdx,0x90(%rsp)
  2756c1:	00 
  2756c2:	48 8b 52 08          	mov    0x8(%rdx),%rdx
  2756c6:	41 89 f8             	mov    %edi,%r8d
  2756c9:	41 c1 e0 04          	shl    $0x4,%r8d
  2756cd:	4a 8b 34 01          	mov    (%rcx,%r8,1),%rsi
  2756d1:	48 89 8c 24 98 00 00 	mov    %rcx,0x98(%rsp)
  2756d8:	00 
  2756d9:	4c 89 84 24 88 00 00 	mov    %r8,0x88(%rsp)
  2756e0:	00 
  2756e1:	4e 8b 6c 01 08       	mov    0x8(%rcx,%r8,1),%r13
  2756e6:	48 3b 44 24 60       	cmp    0x60(%rsp),%rax
  2756eb:	0f 83 fc 05 00 00    	jae    275ced <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x78d>
  2756f1:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
  2756f6:	4c 8b 41 50          	mov    0x50(%rcx),%r8
  2756fa:	4c 89 44 24 78       	mov    %r8,0x78(%rsp)
  2756ff:	48 8b 49 58          	mov    0x58(%rcx),%rcx
  275703:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
  275708:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
  27570d:	62 d2 7d 08 7b c1    	vpbroadcastw %r9d,%xmm0
  275713:	45 31 ff             	xor    %r15d,%r15d
  275716:	c5 fd 6f 0d c2 ae d9 	vmovdqa -0x26513e(%rip),%ymm1        # 105e0 <__abi_tag+0x102e4>
  27571d:	ff 
  27571e:	c4 e2 7d 59 15 61 ac 	vpbroadcastq -0x26539f(%rip),%ymm2        # 10388 <__abi_tag+0x1008c>
  275725:	d9 ff 
  275727:	c5 fd 6f 1d b1 ae d9 	vmovdqa -0x26514f(%rip),%ymm3        # 105e0 <__abi_tag+0x102e4>
  27572e:	ff 
  27572f:	c4 e2 7d 59 25 88 ab 	vpbroadcastq -0x265478(%rip),%ymm4        # 102c0 <__abi_tag+0xffc4>
  275736:	d9 ff 
  275738:	c4 e2 7d 59 2d 9f ab 	vpbroadcastq -0x265461(%rip),%ymm5        # 102e0 <__abi_tag+0xffe4>
  27573f:	d9 ff 
  275741:	c4 e2 7d 59 35 46 ac 	vpbroadcastq -0x2653ba(%rip),%ymm6        # 10390 <__abi_tag+0x10094>
  275748:	d9 ff 
  27574a:	49 89 c0             	mov    %rax,%r8
  27574d:	48 89 7c 24 38       	mov    %rdi,0x38(%rsp)
  275752:	eb 1f                	jmp    275773 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x213>
  275754:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  27575b:	00 00 00 00 00 
  275760:	4c 8b 44 24 68       	mov    0x68(%rsp),%r8
  275765:	49 ff c0             	inc    %r8
  275768:	4c 3b 44 24 60       	cmp    0x60(%rsp),%r8
  27576d:	0f 84 7a 05 00 00    	je     275ced <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x78d>
  275773:	49 39 d8             	cmp    %rbx,%r8
  275776:	0f 84 54 06 00 00    	je     275dd0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x870>
  27577c:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
  275781:	42 8b 0c 81          	mov    (%rcx,%r8,4),%ecx
  275785:	48 39 cb             	cmp    %rcx,%rbx
  275788:	0f 86 9a 05 00 00    	jbe    275d28 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x7c8>
  27578e:	4c 89 44 24 68       	mov    %r8,0x68(%rsp)
  275793:	49 39 ce             	cmp    %rcx,%r14
  275796:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  27579c:	4d 0f 46 c6          	cmovbe %r14,%r8
  2757a0:	4c 8b 5c 24 40       	mov    0x40(%rsp),%r11
  2757a5:	4c 0f 47 5c 24 48    	cmova  0x48(%rsp),%r11
  2757ab:	4c 3b bc 24 a0 00 00 	cmp    0xa0(%rsp),%r15
  2757b2:	00 
  2757b3:	73 3b                	jae    2757f0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x290>
  2757b5:	4c 89 1c 24          	mov    %r11,(%rsp)
  2757b9:	4d 89 f9             	mov    %r15,%r9
  2757bc:	49 c1 e1 04          	shl    $0x4,%r9
  2757c0:	4c 8b 54 24 68       	mov    0x68(%rsp),%r10
  2757c5:	4c 8b 5c 24 58       	mov    0x58(%rsp),%r11
  2757ca:	4f 39 14 0b          	cmp    %r10,(%r11,%r9,1)
  2757ce:	4c 8b 54 24 58       	mov    0x58(%rsp),%r10
  2757d3:	75 2b                	jne    275800 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x2a0>
  2757d5:	4d 01 d1             	add    %r10,%r9
  2757d8:	4d 8b 51 08          	mov    0x8(%r9),%r10
  2757dc:	49 ff c7             	inc    %r15
  2757df:	4c 8b 1c 24          	mov    (%rsp),%r11
  2757e3:	4d 85 d2             	test   %r10,%r10
  2757e6:	75 28                	jne    275810 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x2b0>
  2757e8:	e9 73 ff ff ff       	jmp    275760 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x200>
  2757ed:	0f 1f 00             	nopl   (%rax)
  2757f0:	49 89 ea             	mov    %rbp,%r10
  2757f3:	4d 85 d2             	test   %r10,%r10
  2757f6:	75 18                	jne    275810 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x2b0>
  2757f8:	e9 63 ff ff ff       	jmp    275760 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x200>
  2757fd:	0f 1f 00             	nopl   (%rax)
  275800:	49 89 ea             	mov    %rbp,%r10
  275803:	4c 8b 1c 24          	mov    (%rsp),%r11
  275807:	4d 85 d2             	test   %r10,%r10
  27580a:	0f 84 50 ff ff ff    	je     275760 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x200>
  275810:	4c 29 c1             	sub    %r8,%rcx
  275813:	4c 8d 04 6d 00 00 00 	lea    0x0(,%rbp,2),%r8
  27581a:	00 
  27581b:	4c 0f af c1          	imul   %rcx,%r8
  27581f:	48 0f af cd          	imul   %rbp,%rcx
  275823:	49 8d 0c 4b          	lea    (%r11,%rcx,2),%rcx
  275827:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
  27582c:	4d 89 d1             	mov    %r10,%r9
  27582f:	49 c1 ea 06          	shr    $0x6,%r10
  275833:	44 89 c9             	mov    %r9d,%ecx
  275836:	83 e1 3f             	and    $0x3f,%ecx
  275839:	48 83 f9 01          	cmp    $0x1,%rcx
  27583d:	49 83 da ff          	sbb    $0xffffffffffffffff,%r10
  275841:	4b 8d 0c 03          	lea    (%r11,%r8,1),%rcx
  275845:	48 83 c1 18          	add    $0x18,%rcx
  275849:	48 89 0c 24          	mov    %rcx,(%rsp)
  27584d:	4d 89 d0             	mov    %r10,%r8
  275850:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
  275855:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
  27585a:	4c 89 c9             	mov    %r9,%rcx
  27585d:	4d 89 cb             	mov    %r9,%r11
  275860:	45 31 c9             	xor    %r9d,%r9d
  275863:	4c 89 bc 24 b8 00 00 	mov    %r15,0xb8(%rsp)
  27586a:	00 
  27586b:	48 89 8c 24 b0 00 00 	mov    %rcx,0xb0(%rsp)
  275872:	00 
  275873:	eb 52                	jmp    2758c7 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x367>
  275875:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  27587c:	00 00 00 00 
  275880:	4c 8b 44 24 70       	mov    0x70(%rsp),%r8
  275885:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
  27588a:	49 83 c1 40          	add    $0x40,%r9
  27588e:	49 ff c8             	dec    %r8
  275891:	4c 8b 9c 24 c0 00 00 	mov    0xc0(%rsp),%r11
  275898:	00 
  275899:	49 83 c3 c0          	add    $0xffffffffffffffc0,%r11
  27589d:	49 83 ea 80          	sub    $0xffffffffffffff80,%r10
  2758a1:	4c 89 14 24          	mov    %r10,(%rsp)
  2758a5:	48 83 e9 80          	sub    $0xffffffffffffff80,%rcx
  2758a9:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
  2758ae:	4d 85 c0             	test   %r8,%r8
  2758b1:	4c 8b bc 24 b8 00 00 	mov    0xb8(%rsp),%r15
  2758b8:	00 
  2758b9:	48 8b 8c 24 b0 00 00 	mov    0xb0(%rsp),%rcx
  2758c0:	00 
  2758c1:	0f 84 99 fe ff ff    	je     275760 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x200>
  2758c7:	49 83 fb 01          	cmp    $0x1,%r11
  2758cb:	4d 89 cf             	mov    %r9,%r15
  2758ce:	4d 89 d9             	mov    %r11,%r9
  2758d1:	49 83 d1 00          	adc    $0x0,%r9
  2758d5:	49 83 f9 40          	cmp    $0x40,%r9
  2758d9:	bf 40 00 00 00       	mov    $0x40,%edi
  2758de:	4c 0f 43 cf          	cmovae %rdi,%r9
  2758e2:	49 89 ca             	mov    %rcx,%r10
  2758e5:	4d 29 fa             	sub    %r15,%r10
  2758e8:	49 83 fa 40          	cmp    $0x40,%r10
  2758ec:	4c 0f 43 d7          	cmovae %rdi,%r10
  2758f0:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
  2758f5:	4c 39 f9             	cmp    %r15,%rcx
  2758f8:	4c 89 44 24 70       	mov    %r8,0x70(%rsp)
  2758fd:	4c 89 9c 24 c0 00 00 	mov    %r11,0xc0(%rsp)
  275904:	00 
  275905:	75 19                	jne    275920 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x3c0>
  275907:	41 f6 da             	neg    %r10b
  27590a:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
  275911:	c4 62 ab f7 cf       	shrx   %r10,%rdi,%r9
  275916:	45 31 ff             	xor    %r15d,%r15d
  275919:	e9 f2 01 00 00       	jmp    275b10 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x5b0>
  27591e:	66 90                	xchg   %ax,%ax
  275920:	4c 89 94 24 a8 00 00 	mov    %r10,0xa8(%rsp)
  275927:	00 
  275928:	49 83 fb 04          	cmp    $0x4,%r11
  27592c:	4c 8b 14 24          	mov    (%rsp),%r10
  275930:	73 1e                	jae    275950 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x3f0>
  275932:	45 31 ff             	xor    %r15d,%r15d
  275935:	45 31 c0             	xor    %r8d,%r8d
  275938:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
  27593d:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  275942:	e9 a9 02 00 00       	jmp    275bf0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x690>
  275947:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  27594e:	00 00 
  275950:	49 83 fb 10          	cmp    $0x10,%r11
  275954:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  275959:	73 10                	jae    27596b <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x40b>
  27595b:	45 31 c0             	xor    %r8d,%r8d
  27595e:	45 31 ff             	xor    %r15d,%r15d
  275961:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
  275966:	e9 18 01 00 00       	jmp    275a83 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x523>
  27596b:	45 89 cf             	mov    %r9d,%r15d
  27596e:	41 83 e7 70          	and    $0x70,%r15d
  275972:	45 89 c8             	mov    %r9d,%r8d
  275975:	41 83 e0 70          	and    $0x70,%r8d
  275979:	c5 c1 ef ff          	vpxor  %xmm7,%xmm7,%xmm7
  27597d:	31 ff                	xor    %edi,%edi
  27597f:	c4 41 39 ef c0       	vpxor  %xmm8,%xmm8,%xmm8
  275984:	c4 41 29 ef d2       	vpxor  %xmm10,%xmm10,%xmm10
  275989:	c4 41 31 ef c9       	vpxor  %xmm9,%xmm9,%xmm9
  27598e:	c5 7d 6f db          	vmovdqa %ymm3,%ymm11
  275992:	4c 8b 5c 24 20       	mov    0x20(%rsp),%r11
  275997:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  27599e:	00 00 
  2759a0:	c5 25 d4 e2          	vpaddq %ymm2,%ymm11,%ymm12
  2759a4:	c5 25 d4 ec          	vpaddq %ymm4,%ymm11,%ymm13
  2759a8:	c4 41 7a 7e 74 7a e8 	vmovq  -0x18(%r10,%rdi,2),%xmm14
  2759af:	c4 41 7a 7e 7c 7a f0 	vmovq  -0x10(%r10,%rdi,2),%xmm15
  2759b6:	62 c1 fe 08 7e 44 7a 	vmovq  -0x8(%r10,%rdi,2),%xmm16
  2759bd:	ff 
  2759be:	62 c1 fe 08 7e 0c 7a 	vmovq  (%r10,%rdi,2),%xmm17
  2759c5:	62 e1 a5 28 d4 d5    	vpaddq %ymm5,%ymm11,%ymm18
  2759cb:	62 f2 8d 08 26 c0    	vptestmw %xmm0,%xmm14,%k0
  2759d1:	62 f2 85 08 26 c8    	vptestmw %xmm0,%xmm15,%k1
  2759d7:	62 f2 fd 00 26 d0    	vptestmw %xmm0,%xmm16,%k2
  2759dd:	62 f2 f5 00 26 d8    	vptestmw %xmm0,%xmm17,%k3
  2759e3:	62 72 fe 28 38 f0    	vpmovm2q %k0,%ymm14
  2759e9:	c4 c1 0d 73 d6 3f    	vpsrlq $0x3f,%ymm14,%ymm14
  2759ef:	62 72 fe 28 38 f9    	vpmovm2q %k1,%ymm15
  2759f5:	c4 c1 05 73 d7 3f    	vpsrlq $0x3f,%ymm15,%ymm15
  2759fb:	c4 42 85 47 e4       	vpsllvq %ymm12,%ymm15,%ymm12
  275a00:	c4 41 1d eb d2       	vpor   %ymm10,%ymm12,%ymm10
  275a05:	62 72 fe 28 38 e2    	vpmovm2q %k2,%ymm12
  275a0b:	c4 c1 1d 73 d4 3f    	vpsrlq $0x3f,%ymm12,%ymm12
  275a11:	c4 42 9d 47 e5       	vpsllvq %ymm13,%ymm12,%ymm12
  275a16:	c4 41 1d eb c9       	vpor   %ymm9,%ymm12,%ymm9
  275a1b:	62 72 fe 28 38 e3    	vpmovm2q %k3,%ymm12
  275a21:	c4 c1 1d 73 d4 3f    	vpsrlq $0x3f,%ymm12,%ymm12
  275a27:	62 32 9d 28 47 e2    	vpsllvq %ymm18,%ymm12,%ymm12
  275a2d:	c5 9d eb ff          	vpor   %ymm7,%ymm12,%ymm7
  275a31:	c4 42 8d 47 e3       	vpsllvq %ymm11,%ymm14,%ymm12
  275a36:	c4 41 1d eb c0       	vpor   %ymm8,%ymm12,%ymm8
  275a3b:	48 83 c7 10          	add    $0x10,%rdi
  275a3f:	c5 25 d4 de          	vpaddq %ymm6,%ymm11,%ymm11
  275a43:	49 39 ff             	cmp    %rdi,%r15
  275a46:	0f 85 54 ff ff ff    	jne    2759a0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x440>
  275a4c:	c4 41 2d eb c0       	vpor   %ymm8,%ymm10,%ymm8
  275a51:	62 d3 b5 28 25 f8 fe 	vpternlogq $0xfe,%ymm8,%ymm9,%ymm7
  275a58:	c4 c3 7d 39 f8 01    	vextracti128 $0x1,%ymm7,%xmm8
  275a5e:	c5 b9 eb ff          	vpor   %xmm7,%xmm8,%xmm7
  275a62:	c5 79 70 c7 ee       	vpshufd $0xee,%xmm7,%xmm8
  275a67:	c5 b9 eb ff          	vpor   %xmm7,%xmm8,%xmm7
  275a6b:	c4 c1 f9 7e ff       	vmovq  %xmm7,%r15
  275a70:	4d 39 c1             	cmp    %r8,%r9
  275a73:	0f 84 92 01 00 00    	je     275c0b <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x6ab>
  275a79:	41 f6 c1 0c          	test   $0xc,%r9b
  275a7d:	0f 84 6d 01 00 00    	je     275bf0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x690>
  275a83:	4c 89 c7             	mov    %r8,%rdi
  275a86:	45 89 ca             	mov    %r9d,%r10d
  275a89:	41 83 e2 7c          	and    $0x7c,%r10d
  275a8d:	45 89 c8             	mov    %r9d,%r8d
  275a90:	41 83 e0 7c          	and    $0x7c,%r8d
  275a94:	c4 c1 f9 6e ff       	vmovq  %r15,%xmm7
  275a99:	62 72 fd 28 7c c7    	vpbroadcastq %rdi,%ymm8
  275a9f:	c5 3d eb c1          	vpor   %ymm1,%ymm8,%ymm8
  275aa3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  275aaa:	84 00 00 00 00 00 
  275ab0:	c5 7a 7e 0c 79       	vmovq  (%rcx,%rdi,2),%xmm9
  275ab5:	62 f2 b5 08 26 c0    	vptestmw %xmm0,%xmm9,%k0
  275abb:	62 72 fe 28 38 c8    	vpmovm2q %k0,%ymm9
  275ac1:	c4 c1 35 73 d1 3f    	vpsrlq $0x3f,%ymm9,%ymm9
  275ac7:	c4 42 b5 47 c8       	vpsllvq %ymm8,%ymm9,%ymm9
  275acc:	c5 b5 eb ff          	vpor   %ymm7,%ymm9,%ymm7
  275ad0:	48 83 c7 04          	add    $0x4,%rdi
  275ad4:	c5 3d d4 c2          	vpaddq %ymm2,%ymm8,%ymm8
  275ad8:	49 39 fa             	cmp    %rdi,%r10
  275adb:	75 d3                	jne    275ab0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x550>
  275add:	c4 c3 7d 39 f8 01    	vextracti128 $0x1,%ymm7,%xmm8
  275ae3:	c5 b9 eb ff          	vpor   %xmm7,%xmm8,%xmm7
  275ae7:	c5 79 70 c7 ee       	vpshufd $0xee,%xmm7,%xmm8
  275aec:	c5 b9 eb ff          	vpor   %xmm7,%xmm8,%xmm7
  275af0:	c4 c1 f9 7e ff       	vmovq  %xmm7,%r15
  275af5:	e9 0c 01 00 00       	jmp    275c06 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x6a6>
  275afa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  275b00:	4c 8b 44 24 70       	mov    0x70(%rsp),%r8
  275b05:	4c 8b 14 24          	mov    (%rsp),%r10
  275b09:	e9 77 fd ff ff       	jmp    275885 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x325>
  275b0e:	66 90                	xchg   %ax,%ax
  275b10:	4d 31 f9             	xor    %r15,%r9
  275b13:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
  275b18:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
  275b1d:	4e 8d 04 47          	lea    (%rdi,%r8,2),%r8
  275b21:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
  275b26:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  275b2b:	eb 2d                	jmp    275b5a <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x5fa>
  275b2d:	0f 1f 00             	nopl   (%rax)
  275b30:	4c 29 da             	sub    %r11,%rdx
  275b33:	48 0f af d5          	imul   %rbp,%rdx
  275b37:	4d 8d 24 52          	lea    (%r10,%rdx,2),%r12
  275b3b:	49 8d 14 6c          	lea    (%r12,%rbp,2),%rdx
  275b3f:	4c 8b 94 24 80 00 00 	mov    0x80(%rsp),%r10
  275b46:	00 
  275b47:	49 ff 04 fa          	incq   (%r10,%rdi,8)
  275b4b:	48 ff c0             	inc    %rax
  275b4e:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
  275b53:	c4 c2 b0 f3 c9       	blsr   %r9,%r9
  275b58:	74 76                	je     275bd0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x670>
  275b5a:	f3 4d 0f bc d1       	tzcnt  %r9,%r10
  275b5f:	47 0f b7 14 50       	movzwl (%r8,%r10,2),%r10d
  275b64:	66 45 89 14 24       	mov    %r10w,(%r12)
  275b69:	49 83 c4 02          	add    $0x2,%r12
  275b6d:	49 39 d4             	cmp    %rdx,%r12
  275b70:	75 e1                	jne    275b53 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x5f3>
  275b72:	48 39 d8             	cmp    %rbx,%rax
  275b75:	0f 83 c9 01 00 00    	jae    275d44 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x7e4>
  275b7b:	48 8b 54 24 50       	mov    0x50(%rsp),%rdx
  275b80:	8b 14 82             	mov    (%rdx,%rax,4),%edx
  275b83:	48 39 d3             	cmp    %rdx,%rbx
  275b86:	0f 86 9c 01 00 00    	jbe    275d28 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x7c8>
  275b8c:	49 39 d6             	cmp    %rdx,%r14
  275b8f:	41 bb 00 00 00 00    	mov    $0x0,%r11d
  275b95:	4d 0f 46 de          	cmovbe %r14,%r11
  275b99:	4c 8b 54 24 40       	mov    0x40(%rsp),%r10
  275b9e:	4c 0f 47 54 24 48    	cmova  0x48(%rsp),%r10
  275ba4:	48 3b 44 24 08       	cmp    0x8(%rsp),%rax
  275ba9:	0f 83 ab 01 00 00    	jae    275d5a <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x7fa>
  275baf:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
  275bb4:	4c 8b 64 24 78       	mov    0x78(%rsp),%r12
  275bb9:	41 88 3c 04          	mov    %dil,(%r12,%rax,1)
  275bbd:	48 3b bc 24 00 01 00 	cmp    0x100(%rsp),%rdi
  275bc4:	00 
  275bc5:	0f 82 65 ff ff ff    	jb     275b30 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x5d0>
  275bcb:	e9 a2 01 00 00       	jmp    275d72 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x812>
  275bd0:	4d 85 ff             	test   %r15,%r15
  275bd3:	0f 84 27 ff ff ff    	je     275b00 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x5a0>
  275bd9:	4c 8b 14 24          	mov    (%rsp),%r10
  275bdd:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
  275be2:	eb 59                	jmp    275c3d <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x6dd>
  275be4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  275beb:	00 00 00 00 00 
  275bf0:	31 ff                	xor    %edi,%edi
  275bf2:	66 46 85 1c 41       	test   %r11w,(%rcx,%r8,2)
  275bf7:	40 0f 95 c7          	setne  %dil
  275bfb:	c4 e2 b9 f7 ff       	shlx   %r8,%rdi,%rdi
  275c00:	49 ff c0             	inc    %r8
  275c03:	49 09 ff             	or     %rdi,%r15
  275c06:	4d 39 c1             	cmp    %r8,%r9
  275c09:	75 e5                	jne    275bf0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x690>
  275c0b:	48 8b 8c 24 a8 00 00 	mov    0xa8(%rsp),%rcx
  275c12:	00 
  275c13:	f6 d9                	neg    %cl
  275c15:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
  275c1c:	c4 62 f3 f7 cf       	shrx   %rcx,%rdi,%r9
  275c21:	4d 39 cf             	cmp    %r9,%r15
  275c24:	0f 85 e6 fe ff ff    	jne    275b10 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x5b0>
  275c2a:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
  275c2f:	4c 8b 14 24          	mov    (%rsp),%r10
  275c33:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
  275c38:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  275c3d:	4c 8b 44 24 28       	mov    0x28(%rsp),%r8
  275c42:	4f 8d 0c 48          	lea    (%r8,%r9,2),%r9
  275c46:	eb 13                	jmp    275c5b <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x6fb>
  275c48:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  275c4f:	00 
  275c50:	c4 c2 80 f3 cf       	blsr   %r15,%r15
  275c55:	0f 84 25 fc ff ff    	je     275880 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x320>
  275c5b:	f3 4d 0f bc c7       	tzcnt  %r15,%r8
  275c60:	47 0f b7 04 41       	movzwl (%r9,%r8,2),%r8d
  275c65:	66 44 89 06          	mov    %r8w,(%rsi)
  275c69:	48 83 c6 02          	add    $0x2,%rsi
  275c6d:	4c 39 ee             	cmp    %r13,%rsi
  275c70:	75 de                	jne    275c50 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x6f0>
  275c72:	48 39 d8             	cmp    %rbx,%rax
  275c75:	0f 83 0f 01 00 00    	jae    275d8a <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x82a>
  275c7b:	48 8b 74 24 50       	mov    0x50(%rsp),%rsi
  275c80:	8b 34 86             	mov    (%rsi,%rax,4),%esi
  275c83:	48 39 f3             	cmp    %rsi,%rbx
  275c86:	0f 86 9c 00 00 00    	jbe    275d28 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x7c8>
  275c8c:	49 39 f6             	cmp    %rsi,%r14
  275c8f:	41 ba 00 00 00 00    	mov    $0x0,%r10d
  275c95:	4d 0f 46 d6          	cmovbe %r14,%r10
  275c99:	4c 8b 44 24 40       	mov    0x40(%rsp),%r8
  275c9e:	4c 0f 47 44 24 48    	cmova  0x48(%rsp),%r8
  275ca4:	48 3b 44 24 08       	cmp    0x8(%rsp),%rax
  275ca9:	0f 83 f1 00 00 00    	jae    275da0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x840>
  275caf:	4c 8b 5c 24 78       	mov    0x78(%rsp),%r11
  275cb4:	41 88 3c 03          	mov    %dil,(%r11,%rax,1)
  275cb8:	48 3b bc 24 00 01 00 	cmp    0x100(%rsp),%rdi
  275cbf:	00 
  275cc0:	0f 83 f2 00 00 00    	jae    275db8 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x858>
  275cc6:	4c 29 d6             	sub    %r10,%rsi
  275cc9:	48 0f af f5          	imul   %rbp,%rsi
  275ccd:	49 8d 34 70          	lea    (%r8,%rsi,2),%rsi
  275cd1:	4c 8d 2c 6e          	lea    (%rsi,%rbp,2),%r13
  275cd5:	4c 8b 84 24 80 00 00 	mov    0x80(%rsp),%r8
  275cdc:	00 
  275cdd:	49 ff 04 f8          	incq   (%r8,%rdi,8)
  275ce1:	48 ff c0             	inc    %rax
  275ce4:	4c 8b 14 24          	mov    (%rsp),%r10
  275ce8:	e9 63 ff ff ff       	jmp    275c50 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}>+0x6f0>
  275ced:	48 8b 8c 24 98 00 00 	mov    0x98(%rsp),%rcx
  275cf4:	00 
  275cf5:	48 03 8c 24 88 00 00 	add    0x88(%rsp),%rcx
  275cfc:	00 
  275cfd:	48 8b bc 24 90 00 00 	mov    0x90(%rsp),%rdi
  275d04:	00 
  275d05:	4c 89 27             	mov    %r12,(%rdi)
  275d08:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  275d0c:	48 89 31             	mov    %rsi,(%rcx)
  275d0f:	4c 89 69 08          	mov    %r13,0x8(%rcx)
  275d13:	48 81 c4 c8 00 00 00 	add    $0xc8,%rsp
  275d1a:	5b                   	pop    %rbx
  275d1b:	41 5c                	pop    %r12
  275d1d:	41 5d                	pop    %r13
  275d1f:	41 5e                	pop    %r14
  275d21:	41 5f                	pop    %r15
  275d23:	5d                   	pop    %rbp
  275d24:	c5 f8 77             	vzeroupper
  275d27:	c3                   	ret
  275d28:	48 8d 3d 04 04 da ff 	lea    -0x25fbfc(%rip),%rdi        # 16133 <anon.8f17df2f0ddc4723825c0f55871536dc.0.llvm.6863592281246770637+0xf3>
  275d2f:	48 8d 15 22 19 35 00 	lea    0x351922(%rip),%rdx        # 5c7658 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x370>
  275d36:	be 2c 00 00 00       	mov    $0x2c,%esi
  275d3b:	c5 f8 77             	vzeroupper
  275d3e:	ff 15 6c cb 35 00    	call   *0x35cb6c(%rip)        # 5d28b0 <_DYNAMIC+0x290>
  275d44:	48 8d 15 2d 16 35 00 	lea    0x35162d(%rip),%rdx        # 5c7378 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x90>
  275d4b:	48 89 c7             	mov    %rax,%rdi
  275d4e:	48 89 de             	mov    %rbx,%rsi
  275d51:	c5 f8 77             	vzeroupper
  275d54:	ff 15 6e cb 35 00    	call   *0x35cb6e(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  275d5a:	48 8d 15 17 16 35 00 	lea    0x351617(%rip),%rdx        # 5c7378 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x90>
  275d61:	48 89 c7             	mov    %rax,%rdi
  275d64:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  275d69:	c5 f8 77             	vzeroupper
  275d6c:	ff 15 56 cb 35 00    	call   *0x35cb56(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  275d72:	48 8d 15 ff 15 35 00 	lea    0x3515ff(%rip),%rdx        # 5c7378 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x90>
  275d79:	48 8b b4 24 00 01 00 	mov    0x100(%rsp),%rsi
  275d80:	00 
  275d81:	c5 f8 77             	vzeroupper
  275d84:	ff 15 3e cb 35 00    	call   *0x35cb3e(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  275d8a:	48 8d 15 cf 15 35 00 	lea    0x3515cf(%rip),%rdx        # 5c7360 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x78>
  275d91:	48 89 c7             	mov    %rax,%rdi
  275d94:	48 89 de             	mov    %rbx,%rsi
  275d97:	c5 f8 77             	vzeroupper
  275d9a:	ff 15 28 cb 35 00    	call   *0x35cb28(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  275da0:	48 8d 15 b9 15 35 00 	lea    0x3515b9(%rip),%rdx        # 5c7360 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x78>
  275da7:	48 89 c7             	mov    %rax,%rdi
  275daa:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  275daf:	c5 f8 77             	vzeroupper
  275db2:	ff 15 10 cb 35 00    	call   *0x35cb10(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  275db8:	48 8d 15 a1 15 35 00 	lea    0x3515a1(%rip),%rdx        # 5c7360 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x78>
  275dbf:	48 8b b4 24 00 01 00 	mov    0x100(%rsp),%rsi
  275dc6:	00 
  275dc7:	c5 f8 77             	vzeroupper
  275dca:	ff 15 f8 ca 35 00    	call   *0x35caf8(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  275dd0:	48 8d 15 71 15 35 00 	lea    0x351571(%rip),%rdx        # 5c7348 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x60>
  275dd7:	48 89 df             	mov    %rbx,%rdi
  275dda:	48 89 de             	mov    %rbx,%rsi
  275ddd:	c5 f8 77             	vzeroupper
  275de0:	ff 15 e2 ca 35 00    	call   *0x35cae2(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  275de6:	48 8d 15 13 15 35 00 	lea    0x351513(%rip),%rdx        # 5c7300 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x18>
  275ded:	4c 89 df             	mov    %r11,%rdi
  275df0:	48 89 de             	mov    %rbx,%rsi
  275df3:	ff 15 cf ca 35 00    	call   *0x35cacf(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  275df9:	48 8d 15 18 15 35 00 	lea    0x351518(%rip),%rdx        # 5c7318 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x30>
  275e00:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
  275e05:	4c 89 ee             	mov    %r13,%rsi
  275e08:	ff 15 ba ca 35 00    	call   *0x35caba(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  275e0e:	48 8d 15 1b 15 35 00 	lea    0x35151b(%rip),%rdx        # 5c7330 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x48>
  275e15:	4c 89 ee             	mov    %r13,%rsi
  275e18:	ff 15 aa ca 35 00    	call   *0x35caaa(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>

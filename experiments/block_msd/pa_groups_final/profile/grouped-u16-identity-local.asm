
experiments/block_msd/target/pa-groups-final/time:     file format elf64-x86-64


Disassembly of section .text:

00000000002722d0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>>:
  2722d0:	55                   	push   %rbp
  2722d1:	41 57                	push   %r15
  2722d3:	41 56                	push   %r14
  2722d5:	41 55                	push   %r13
  2722d7:	41 54                	push   %r12
  2722d9:	53                   	push   %rbx
  2722da:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
  2722e1:	48 89 74 24 68       	mov    %rsi,0x68(%rsp)
  2722e6:	48 8b 87 80 00 00 00 	mov    0x80(%rdi),%rax
  2722ed:	48 8b 9f a8 00 00 00 	mov    0xa8(%rdi),%rbx
  2722f4:	4c 8b 6f 68          	mov    0x68(%rdi),%r13
  2722f8:	48 8b 6f 70          	mov    0x70(%rdi),%rbp
  2722fc:	48 8d 77 78          	lea    0x78(%rdi),%rsi
  272300:	48 39 d8             	cmp    %rbx,%rax
  272303:	48 89 5c 24 58       	mov    %rbx,0x58(%rsp)
  272308:	48 0f 47 d8          	cmova  %rax,%rbx
  27230c:	45 31 f6             	xor    %r14d,%r14d
  27230f:	49 89 c3             	mov    %rax,%r11
  272312:	eb 18                	jmp    27232c <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x5c>
  272314:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  27231b:	00 00 00 00 00 
  272320:	49 89 f2             	mov    %rsi,%r10
  272323:	49 ff c3             	inc    %r11
  272326:	49 83 3a 00          	cmpq   $0x0,(%r10)
  27232a:	75 2f                	jne    27235b <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x8b>
  27232c:	4c 39 db             	cmp    %r11,%rbx
  27232f:	0f 84 2e 07 00 00    	je     272a63 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x793>
  272335:	49 39 ee             	cmp    %rbp,%r14
  272338:	73 e6                	jae    272320 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x50>
  27233a:	4d 89 f2             	mov    %r14,%r10
  27233d:	49 c1 e2 04          	shl    $0x4,%r10
  272341:	4f 3b 5c 15 00       	cmp    0x0(%r13,%r10,1),%r11
  272346:	75 d8                	jne    272320 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x50>
  272348:	4d 01 ea             	add    %r13,%r10
  27234b:	49 83 c2 08          	add    $0x8,%r10
  27234f:	49 ff c6             	inc    %r14
  272352:	49 ff c3             	inc    %r11
  272355:	49 83 3a 00          	cmpq   $0x0,(%r10)
  272359:	74 d1                	je     27232c <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x5c>
  27235b:	48 8b 77 28          	mov    0x28(%rdi),%rsi
  27235f:	4d 8d 53 ff          	lea    -0x1(%r11),%r10
  272363:	49 39 f2             	cmp    %rsi,%r10
  272366:	0f 83 cd 07 00 00    	jae    272b39 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x869>
  27236c:	4c 8b 57 20          	mov    0x20(%rdi),%r10
  272370:	4c 89 54 24 48       	mov    %r10,0x48(%rsp)
  272375:	47 8b 54 9a fc       	mov    -0x4(%r10,%r11,4),%r10d
  27237a:	4c 39 d6             	cmp    %r10,%rsi
  27237d:	0f 86 f5 06 00 00    	jbe    272a78 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x7a8>
  272383:	4c 89 44 24 50       	mov    %r8,0x50(%rsp)
  272388:	4c 8b b7 88 00 00 00 	mov    0x88(%rdi),%r14
  27238f:	31 db                	xor    %ebx,%ebx
  272391:	4d 39 d6             	cmp    %r10,%r14
  272394:	4c 8b 87 a0 00 00 00 	mov    0xa0(%rdi),%r8
  27239b:	4d 89 cb             	mov    %r9,%r11
  27239e:	4c 8b bf 90 00 00 00 	mov    0x90(%rdi),%r15
  2723a5:	4d 89 f4             	mov    %r14,%r12
  2723a8:	4c 0f 47 e3          	cmova  %rbx,%r12
  2723ac:	bb 00 00 00 00       	mov    $0x0,%ebx
  2723b1:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
  2723b6:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
  2723bb:	4d 0f 47 f8          	cmova  %r8,%r15
  2723bf:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
  2723c4:	4c 8b 4f 78          	mov    0x78(%rdi),%r9
  2723c8:	4d 29 e2             	sub    %r12,%r10
  2723cb:	4d 0f af d1          	imul   %r9,%r10
  2723cf:	48 8b 7c 24 68       	mov    0x68(%rsp),%rdi
  2723d4:	0f b7 3f             	movzwl (%rdi),%edi
  2723d7:	66 43 23 3c 57       	and    (%r15,%r10,2),%di
  2723dc:	4d 89 df             	mov    %r11,%r15
  2723df:	0f b7 ff             	movzwl %di,%edi
  2723e2:	c1 e2 03             	shl    $0x3,%edx
  2723e5:	41 89 d2             	mov    %edx,%r10d
  2723e8:	41 80 e2 08          	and    $0x8,%r10b
  2723ec:	c4 e2 2b f7 ff       	shrx   %r10d,%edi,%edi
  2723f1:	44 0f b6 e7          	movzbl %dil,%r12d
  2723f5:	44 0f b6 d1          	movzbl %cl,%r10d
  2723f9:	c4 c2 28 f2 fc       	andn   %r12d,%r10d,%edi
  2723fe:	c4 42 e9 f7 da       	shlx   %rdx,%r10,%r11
  272403:	f6 c2 40             	test   $0x40,%dl
  272406:	4c 0f 45 db          	cmovne %rbx,%r11
  27240a:	4c 89 9c 24 b0 00 00 	mov    %r11,0xb0(%rsp)
  272411:	00 
  272412:	4c 39 ff             	cmp    %r15,%rdi
  272415:	0f 83 2e 07 00 00    	jae    272b49 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x879>
  27241b:	48 89 ac 24 a8 00 00 	mov    %rbp,0xa8(%rsp)
  272422:	00 
  272423:	4c 89 ac 24 a0 00 00 	mov    %r13,0xa0(%rsp)
  27242a:	00 
  27242b:	4d 09 d4             	or     %r10,%r12
  27242e:	4d 39 fc             	cmp    %r15,%r12
  272431:	0f 83 22 07 00 00    	jae    272b59 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x889>
  272437:	48 89 bc 24 d0 00 00 	mov    %rdi,0xd0(%rsp)
  27243e:	00 
  27243f:	c1 e7 04             	shl    $0x4,%edi
  272442:	4c 8b 44 24 50       	mov    0x50(%rsp),%r8
  272447:	4c 01 c7             	add    %r8,%rdi
  27244a:	4c 8b 2f             	mov    (%rdi),%r13
  27244d:	48 89 bc 24 98 00 00 	mov    %rdi,0x98(%rsp)
  272454:	00 
  272455:	48 8b 6f 08          	mov    0x8(%rdi),%rbp
  272459:	44 89 e2             	mov    %r12d,%edx
  27245c:	c1 e2 04             	shl    $0x4,%edx
  27245f:	4d 8b 3c 10          	mov    (%r8,%rdx,1),%r15
  272463:	48 89 94 24 90 00 00 	mov    %rdx,0x90(%rsp)
  27246a:	00 
  27246b:	49 8b 54 10 08       	mov    0x8(%r8,%rdx,1),%rdx
  272470:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
  272475:	48 3b 44 24 58       	cmp    0x58(%rsp),%rax
  27247a:	0f 83 bb 05 00 00    	jae    272a3b <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x76b>
  272480:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  272485:	48 8b 51 50          	mov    0x50(%rcx),%rdx
  272489:	48 89 94 24 88 00 00 	mov    %rdx,0x88(%rsp)
  272490:	00 
  272491:	48 8b 49 58          	mov    0x58(%rcx),%rcx
  272495:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
  27249a:	31 d2                	xor    %edx,%edx
  27249c:	c5 fd 6f 05 3c e1 d9 	vmovdqa -0x261ec4(%rip),%ymm0        # 105e0 <__abi_tag+0x102e4>
  2724a3:	ff 
  2724a4:	c4 e2 7d 59 0d db de 	vpbroadcastq -0x262125(%rip),%ymm1        # 10388 <__abi_tag+0x1008c>
  2724ab:	d9 ff 
  2724ad:	c5 fd 6f 15 2b e1 d9 	vmovdqa -0x261ed5(%rip),%ymm2        # 105e0 <__abi_tag+0x102e4>
  2724b4:	ff 
  2724b5:	c4 e2 7d 59 1d 02 de 	vpbroadcastq -0x2621fe(%rip),%ymm3        # 102c0 <__abi_tag+0xffc4>
  2724bc:	d9 ff 
  2724be:	c4 e2 7d 59 25 19 de 	vpbroadcastq -0x2621e7(%rip),%ymm4        # 102e0 <__abi_tag+0xffe4>
  2724c5:	d9 ff 
  2724c7:	c4 e2 7d 59 2d c0 de 	vpbroadcastq -0x262140(%rip),%ymm5        # 10390 <__abi_tag+0x10094>
  2724ce:	d9 ff 
  2724d0:	48 89 c7             	mov    %rax,%rdi
  2724d3:	4c 89 64 24 30       	mov    %r12,0x30(%rsp)
  2724d8:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
  2724dd:	eb 28                	jmp    272507 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x237>
  2724df:	90                   	nop
  2724e0:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  2724e5:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  2724ea:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
  2724ef:	48 ff c7             	inc    %rdi
  2724f2:	48 3b 7c 24 58       	cmp    0x58(%rsp),%rdi
  2724f7:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
  2724fc:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
  272501:	0f 84 34 05 00 00    	je     272a3b <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x76b>
  272507:	48 39 f7             	cmp    %rsi,%rdi
  27250a:	0f 84 16 06 00 00    	je     272b26 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x856>
  272510:	48 8b 4c 24 48       	mov    0x48(%rsp),%rcx
  272515:	8b 0c b9             	mov    (%rcx,%rdi,4),%ecx
  272518:	48 39 ce             	cmp    %rcx,%rsi
  27251b:	0f 86 57 05 00 00    	jbe    272a78 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x7a8>
  272521:	48 89 7c 24 60       	mov    %rdi,0x60(%rsp)
  272526:	49 39 ce             	cmp    %rcx,%r14
  272529:	49 89 d3             	mov    %rdx,%r11
  27252c:	bf 00 00 00 00       	mov    $0x0,%edi
  272531:	49 0f 46 fe          	cmovbe %r14,%rdi
  272535:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
  27253a:	48 0f 47 54 24 40    	cmova  0x40(%rsp),%rdx
  272540:	4c 3b 9c 24 a8 00 00 	cmp    0xa8(%rsp),%r11
  272547:	00 
  272548:	73 36                	jae    272580 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x2b0>
  27254a:	4d 89 da             	mov    %r11,%r10
  27254d:	49 c1 e2 04          	shl    $0x4,%r10
  272551:	48 8b 9c 24 a0 00 00 	mov    0xa0(%rsp),%rbx
  272558:	00 
  272559:	4c 8b 44 24 60       	mov    0x60(%rsp),%r8
  27255e:	4e 39 04 13          	cmp    %r8,(%rbx,%r10,1)
  272562:	75 1c                	jne    272580 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x2b0>
  272564:	49 01 da             	add    %rbx,%r10
  272567:	49 8b 5a 08          	mov    0x8(%r10),%rbx
  27256b:	49 ff c3             	inc    %r11
  27256e:	4c 89 5c 24 20       	mov    %r11,0x20(%rsp)
  272573:	48 85 db             	test   %rbx,%rbx
  272576:	75 19                	jne    272591 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x2c1>
  272578:	e9 63 ff ff ff       	jmp    2724e0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x210>
  27257d:	0f 1f 00             	nopl   (%rax)
  272580:	4c 89 5c 24 20       	mov    %r11,0x20(%rsp)
  272585:	4c 89 cb             	mov    %r9,%rbx
  272588:	48 85 db             	test   %rbx,%rbx
  27258b:	0f 84 4f ff ff ff    	je     2724e0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x210>
  272591:	48 29 f9             	sub    %rdi,%rcx
  272594:	4b 8d 3c 09          	lea    (%r9,%r9,1),%rdi
  272598:	48 0f af f9          	imul   %rcx,%rdi
  27259c:	49 0f af c9          	imul   %r9,%rcx
  2725a0:	4c 8d 14 4a          	lea    (%rdx,%rcx,2),%r10
  2725a4:	49 89 db             	mov    %rbx,%r11
  2725a7:	49 c1 eb 06          	shr    $0x6,%r11
  2725ab:	89 d9                	mov    %ebx,%ecx
  2725ad:	83 e1 3f             	and    $0x3f,%ecx
  2725b0:	48 83 f9 01          	cmp    $0x1,%rcx
  2725b4:	4c 89 d9             	mov    %r11,%rcx
  2725b7:	48 83 d9 ff          	sbb    $0xffffffffffffffff,%rcx
  2725bb:	48 01 fa             	add    %rdi,%rdx
  2725be:	48 83 c2 18          	add    $0x18,%rdx
  2725c2:	4c 89 54 24 70       	mov    %r10,0x70(%rsp)
  2725c7:	4c 89 54 24 18       	mov    %r10,0x18(%rsp)
  2725cc:	49 89 db             	mov    %rbx,%r11
  2725cf:	31 ff                	xor    %edi,%edi
  2725d1:	48 89 9c 24 c0 00 00 	mov    %rbx,0xc0(%rsp)
  2725d8:	00 
  2725d9:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  2725de:	eb 40                	jmp    272620 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x350>
  2725e0:	48 8b 4c 24 78       	mov    0x78(%rsp),%rcx
  2725e5:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  2725ea:	48 83 c7 40          	add    $0x40,%rdi
  2725ee:	48 ff c9             	dec    %rcx
  2725f1:	4c 8b 9c 24 c8 00 00 	mov    0xc8(%rsp),%r11
  2725f8:	00 
  2725f9:	49 83 c3 c0          	add    $0xffffffffffffffc0,%r11
  2725fd:	48 8b 94 24 80 00 00 	mov    0x80(%rsp),%rdx
  272604:	00 
  272605:	48 83 ea 80          	sub    $0xffffffffffffff80,%rdx
  272609:	48 83 6c 24 18 80    	subq   $0xffffffffffffff80,0x18(%rsp)
  27260f:	48 85 c9             	test   %rcx,%rcx
  272612:	48 8b 9c 24 c0 00 00 	mov    0xc0(%rsp),%rbx
  272619:	00 
  27261a:	0f 84 c5 fe ff ff    	je     2724e5 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x215>
  272620:	48 89 4c 24 78       	mov    %rcx,0x78(%rsp)
  272625:	49 83 fb 01          	cmp    $0x1,%r11
  272629:	49 89 fa             	mov    %rdi,%r10
  27262c:	4c 89 df             	mov    %r11,%rdi
  27262f:	48 83 d7 00          	adc    $0x0,%rdi
  272633:	48 83 ff 40          	cmp    $0x40,%rdi
  272637:	b9 40 00 00 00       	mov    $0x40,%ecx
  27263c:	48 0f 43 f9          	cmovae %rcx,%rdi
  272640:	49 89 d8             	mov    %rbx,%r8
  272643:	4d 29 d0             	sub    %r10,%r8
  272646:	49 83 f8 40          	cmp    $0x40,%r8
  27264a:	4c 0f 43 c1          	cmovae %rcx,%r8
  27264e:	4c 89 54 24 08       	mov    %r10,0x8(%rsp)
  272653:	4c 39 d3             	cmp    %r10,%rbx
  272656:	48 89 94 24 80 00 00 	mov    %rdx,0x80(%rsp)
  27265d:	00 
  27265e:	4c 89 9c 24 c8 00 00 	mov    %r11,0xc8(%rsp)
  272665:	00 
  272666:	75 28                	jne    272690 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x3c0>
  272668:	41 f6 d8             	neg    %r8b
  27266b:	48 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%rcx
  272672:	c4 e2 bb f7 d1       	shrx   %r8,%rcx,%rdx
  272677:	31 c9                	xor    %ecx,%ecx
  272679:	48 8b 5c 24 28       	mov    0x28(%rsp),%rbx
  27267e:	e9 39 02 00 00       	jmp    2728bc <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x5ec>
  272683:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  27268a:	84 00 00 00 00 00 
  272690:	4c 89 84 24 b8 00 00 	mov    %r8,0xb8(%rsp)
  272697:	00 
  272698:	48 8b 4c 24 68       	mov    0x68(%rsp),%rcx
  27269d:	44 0f b7 11          	movzwl (%rcx),%r10d
  2726a1:	66 44 23 94 24 b0 00 	and    0xb0(%rsp),%r10w
  2726a8:	00 00 
  2726aa:	49 83 fb 04          	cmp    $0x4,%r11
  2726ae:	48 8b 5c 24 28       	mov    0x28(%rsp),%rbx
  2726b3:	73 1b                	jae    2726d0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x400>
  2726b5:	31 c9                	xor    %ecx,%ecx
  2726b7:	31 d2                	xor    %edx,%edx
  2726b9:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
  2726be:	e9 bd 01 00 00       	jmp    272880 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x5b0>
  2726c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2726ca:	84 00 00 00 00 00 
  2726d0:	49 83 fb 10          	cmp    $0x10,%r11
  2726d4:	73 0e                	jae    2726e4 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x414>
  2726d6:	31 d2                	xor    %edx,%edx
  2726d8:	31 c9                	xor    %ecx,%ecx
  2726da:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
  2726df:	e9 25 01 00 00       	jmp    272809 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x539>
  2726e4:	89 f9                	mov    %edi,%ecx
  2726e6:	83 e1 70             	and    $0x70,%ecx
  2726e9:	89 fa                	mov    %edi,%edx
  2726eb:	83 e2 70             	and    $0x70,%edx
  2726ee:	62 d2 7d 08 7b fa    	vpbroadcastw %r10d,%xmm7
  2726f4:	c5 c9 ef f6          	vpxor  %xmm6,%xmm6,%xmm6
  2726f8:	45 31 e4             	xor    %r12d,%r12d
  2726fb:	c4 41 39 ef c0       	vpxor  %xmm8,%xmm8,%xmm8
  272700:	c4 41 29 ef d2       	vpxor  %xmm10,%xmm10,%xmm10
  272705:	c4 41 31 ef c9       	vpxor  %xmm9,%xmm9,%xmm9
  27270a:	c5 7d 6f da          	vmovdqa %ymm2,%ymm11
  27270e:	4c 8b 84 24 80 00 00 	mov    0x80(%rsp),%r8
  272715:	00 
  272716:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  27271d:	00 00 00 
  272720:	c5 25 d4 e1          	vpaddq %ymm1,%ymm11,%ymm12
  272724:	c5 25 d4 eb          	vpaddq %ymm3,%ymm11,%ymm13
  272728:	c4 01 7a 7e 74 60 e8 	vmovq  -0x18(%r8,%r12,2),%xmm14
  27272f:	c4 01 7a 7e 7c 60 f0 	vmovq  -0x10(%r8,%r12,2),%xmm15
  272736:	62 81 fe 08 7e 44 60 	vmovq  -0x8(%r8,%r12,2),%xmm16
  27273d:	ff 
  27273e:	62 81 fe 08 7e 0c 60 	vmovq  (%r8,%r12,2),%xmm17
  272745:	62 e1 a5 28 d4 d4    	vpaddq %ymm4,%ymm11,%ymm18
  27274b:	62 d2 c5 08 26 c6    	vptestmw %xmm14,%xmm7,%k0
  272751:	62 d2 c5 08 26 cf    	vptestmw %xmm15,%xmm7,%k1
  272757:	62 b2 c5 08 26 d0    	vptestmw %xmm16,%xmm7,%k2
  27275d:	62 b2 c5 08 26 d9    	vptestmw %xmm17,%xmm7,%k3
  272763:	62 72 fe 28 38 f0    	vpmovm2q %k0,%ymm14
  272769:	c4 c1 0d 73 d6 3f    	vpsrlq $0x3f,%ymm14,%ymm14
  27276f:	62 72 fe 28 38 f9    	vpmovm2q %k1,%ymm15
  272775:	c4 c1 05 73 d7 3f    	vpsrlq $0x3f,%ymm15,%ymm15
  27277b:	c4 42 85 47 e4       	vpsllvq %ymm12,%ymm15,%ymm12
  272780:	c4 41 1d eb d2       	vpor   %ymm10,%ymm12,%ymm10
  272785:	62 72 fe 28 38 e2    	vpmovm2q %k2,%ymm12
  27278b:	c4 c1 1d 73 d4 3f    	vpsrlq $0x3f,%ymm12,%ymm12
  272791:	c4 42 9d 47 e5       	vpsllvq %ymm13,%ymm12,%ymm12
  272796:	c4 41 1d eb c9       	vpor   %ymm9,%ymm12,%ymm9
  27279b:	62 72 fe 28 38 e3    	vpmovm2q %k3,%ymm12
  2727a1:	c4 c1 1d 73 d4 3f    	vpsrlq $0x3f,%ymm12,%ymm12
  2727a7:	62 32 9d 28 47 e2    	vpsllvq %ymm18,%ymm12,%ymm12
  2727ad:	c5 9d eb f6          	vpor   %ymm6,%ymm12,%ymm6
  2727b1:	c4 42 8d 47 e3       	vpsllvq %ymm11,%ymm14,%ymm12
  2727b6:	c4 41 1d eb c0       	vpor   %ymm8,%ymm12,%ymm8
  2727bb:	49 83 c4 10          	add    $0x10,%r12
  2727bf:	c5 25 d4 dd          	vpaddq %ymm5,%ymm11,%ymm11
  2727c3:	4c 39 e1             	cmp    %r12,%rcx
  2727c6:	0f 85 54 ff ff ff    	jne    272720 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x450>
  2727cc:	c4 c1 2d eb f8       	vpor   %ymm8,%ymm10,%ymm7
  2727d1:	62 f3 b5 28 25 f7 fe 	vpternlogq $0xfe,%ymm7,%ymm9,%ymm6
  2727d8:	c4 e3 7d 39 f7 01    	vextracti128 $0x1,%ymm6,%xmm7
  2727de:	c5 c9 eb f7          	vpor   %xmm7,%xmm6,%xmm6
  2727e2:	c5 f9 70 fe ee       	vpshufd $0xee,%xmm6,%xmm7
  2727e7:	c5 c9 eb f7          	vpor   %xmm7,%xmm6,%xmm6
  2727eb:	c4 e1 f9 7e f1       	vmovq  %xmm6,%rcx
  2727f0:	48 39 d7             	cmp    %rdx,%rdi
  2727f3:	4c 8b 64 24 30       	mov    0x30(%rsp),%r12
  2727f8:	0f 84 9e 00 00 00    	je     27289c <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x5cc>
  2727fe:	40 f6 c7 0c          	test   $0xc,%dil
  272802:	4c 8b 44 24 18       	mov    0x18(%rsp),%r8
  272807:	74 77                	je     272880 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x5b0>
  272809:	49 89 d4             	mov    %rdx,%r12
  27280c:	41 89 fb             	mov    %edi,%r11d
  27280f:	41 83 e3 7c          	and    $0x7c,%r11d
  272813:	89 fa                	mov    %edi,%edx
  272815:	83 e2 7c             	and    $0x7c,%edx
  272818:	c4 e1 f9 6e f1       	vmovq  %rcx,%xmm6
  27281d:	62 d2 7d 08 7b fa    	vpbroadcastw %r10d,%xmm7
  272823:	62 52 fd 28 7c c4    	vpbroadcastq %r12,%ymm8
  272829:	c5 3d eb c0          	vpor   %ymm0,%ymm8,%ymm8
  27282d:	0f 1f 00             	nopl   (%rax)
  272830:	c4 01 7a 7e 0c 60    	vmovq  (%r8,%r12,2),%xmm9
  272836:	62 d2 c5 08 26 c1    	vptestmw %xmm9,%xmm7,%k0
  27283c:	62 72 fe 28 38 c8    	vpmovm2q %k0,%ymm9
  272842:	c4 c1 35 73 d1 3f    	vpsrlq $0x3f,%ymm9,%ymm9
  272848:	c4 42 b5 47 c8       	vpsllvq %ymm8,%ymm9,%ymm9
  27284d:	c5 b5 eb f6          	vpor   %ymm6,%ymm9,%ymm6
  272851:	49 83 c4 04          	add    $0x4,%r12
  272855:	c5 3d d4 c1          	vpaddq %ymm1,%ymm8,%ymm8
  272859:	4d 39 e3             	cmp    %r12,%r11
  27285c:	75 d2                	jne    272830 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x560>
  27285e:	c4 e3 7d 39 f7 01    	vextracti128 $0x1,%ymm6,%xmm7
  272864:	c5 c9 eb f7          	vpor   %xmm7,%xmm6,%xmm6
  272868:	c5 f9 70 fe ee       	vpshufd $0xee,%xmm6,%xmm7
  27286d:	c5 c9 eb f7          	vpor   %xmm7,%xmm6,%xmm6
  272871:	c4 e1 f9 7e f1       	vmovq  %xmm6,%rcx
  272876:	48 39 d7             	cmp    %rdx,%rdi
  272879:	4c 8b 64 24 30       	mov    0x30(%rsp),%r12
  27287e:	74 1c                	je     27289c <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x5cc>
  272880:	45 31 db             	xor    %r11d,%r11d
  272883:	66 45 85 14 50       	test   %r10w,(%r8,%rdx,2)
  272888:	41 0f 95 c3          	setne  %r11b
  27288c:	c4 42 e9 f7 db       	shlx   %rdx,%r11,%r11
  272891:	48 ff c2             	inc    %rdx
  272894:	4c 09 d9             	or     %r11,%rcx
  272897:	48 39 d7             	cmp    %rdx,%rdi
  27289a:	75 e4                	jne    272880 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x5b0>
  27289c:	48 8b bc 24 b8 00 00 	mov    0xb8(%rsp),%rdi
  2728a3:	00 
  2728a4:	40 f6 df             	neg    %dil
  2728a7:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
  2728ae:	c4 e2 c3 f7 d2       	shrx   %rdi,%rdx,%rdx
  2728b3:	48 39 d1             	cmp    %rdx,%rcx
  2728b6:	0f 84 cd 00 00 00    	je     272989 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x6b9>
  2728bc:	48 31 ca             	xor    %rcx,%rdx
  2728bf:	48 8b 7c 24 70       	mov    0x70(%rsp),%rdi
  2728c4:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
  2728c9:	4e 8d 14 47          	lea    (%rdi,%r8,2),%r10
  2728cd:	eb 32                	jmp    272901 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x631>
  2728cf:	90                   	nop
  2728d0:	4c 29 e7             	sub    %r12,%rdi
  2728d3:	49 0f af f9          	imul   %r9,%rdi
  2728d7:	4d 8d 2c 7b          	lea    (%r11,%rdi,2),%r13
  2728db:	4a 8d 2c 4d 00 00 00 	lea    0x0(,%r9,2),%rbp
  2728e2:	00 
  2728e3:	4c 01 ed             	add    %r13,%rbp
  2728e6:	48 8b bc 24 10 01 00 	mov    0x110(%rsp),%rdi
  2728ed:	00 
  2728ee:	4a ff 04 c7          	incq   (%rdi,%r8,8)
  2728f2:	48 ff c0             	inc    %rax
  2728f5:	4c 8b 64 24 30       	mov    0x30(%rsp),%r12
  2728fa:	c4 e2 e8 f3 ca       	blsr   %rdx,%rdx
  2728ff:	74 7f                	je     272980 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x6b0>
  272901:	f3 48 0f bc fa       	tzcnt  %rdx,%rdi
  272906:	41 0f b7 3c 7a       	movzwl (%r10,%rdi,2),%edi
  27290b:	66 41 89 7d 00       	mov    %di,0x0(%r13)
  272910:	49 83 c5 02          	add    $0x2,%r13
  272914:	49 39 ed             	cmp    %rbp,%r13
  272917:	75 e1                	jne    2728fa <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x62a>
  272919:	48 39 d8             	cmp    %rbx,%rax
  27291c:	0f 83 72 01 00 00    	jae    272a94 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x7c4>
  272922:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  272927:	8b 3c 87             	mov    (%rdi,%rax,4),%edi
  27292a:	48 39 fb             	cmp    %rdi,%rbx
  27292d:	0f 86 45 01 00 00    	jbe    272a78 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x7a8>
  272933:	49 39 fe             	cmp    %rdi,%r14
  272936:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  27293c:	4d 0f 46 e6          	cmovbe %r14,%r12
  272940:	4c 8b 5c 24 38       	mov    0x38(%rsp),%r11
  272945:	4c 0f 47 5c 24 40    	cmova  0x40(%rsp),%r11
  27294b:	48 3b 44 24 10       	cmp    0x10(%rsp),%rax
  272950:	0f 83 54 01 00 00    	jae    272aaa <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x7da>
  272956:	4c 8b 84 24 d0 00 00 	mov    0xd0(%rsp),%r8
  27295d:	00 
  27295e:	4c 8b ac 24 88 00 00 	mov    0x88(%rsp),%r13
  272965:	00 
  272966:	45 88 44 05 00       	mov    %r8b,0x0(%r13,%rax,1)
  27296b:	4c 3b 84 24 18 01 00 	cmp    0x118(%rsp),%r8
  272972:	00 
  272973:	0f 82 57 ff ff ff    	jb     2728d0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x600>
  272979:	e9 44 01 00 00       	jmp    272ac2 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x7f2>
  27297e:	66 90                	xchg   %ax,%ax
  272980:	48 85 c9             	test   %rcx,%rcx
  272983:	0f 84 57 fc ff ff    	je     2725e0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x310>
  272989:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  27298e:	48 8b 54 24 70       	mov    0x70(%rsp),%rdx
  272993:	48 8d 14 7a          	lea    (%rdx,%rdi,2),%rdx
  272997:	eb 12                	jmp    2729ab <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x6db>
  272999:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  2729a0:	c4 e2 f0 f3 c9       	blsr   %rcx,%rcx
  2729a5:	0f 84 35 fc ff ff    	je     2725e0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x310>
  2729ab:	f3 48 0f bc f9       	tzcnt  %rcx,%rdi
  2729b0:	0f b7 3c 7a          	movzwl (%rdx,%rdi,2),%edi
  2729b4:	66 41 89 3f          	mov    %di,(%r15)
  2729b8:	49 83 c7 02          	add    $0x2,%r15
  2729bc:	49 39 f7             	cmp    %rsi,%r15
  2729bf:	75 df                	jne    2729a0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x6d0>
  2729c1:	48 39 d8             	cmp    %rbx,%rax
  2729c4:	0f 83 13 01 00 00    	jae    272add <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x80d>
  2729ca:	48 8b 74 24 48       	mov    0x48(%rsp),%rsi
  2729cf:	8b 34 86             	mov    (%rsi,%rax,4),%esi
  2729d2:	48 39 f3             	cmp    %rsi,%rbx
  2729d5:	0f 86 9d 00 00 00    	jbe    272a78 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x7a8>
  2729db:	49 39 f6             	cmp    %rsi,%r14
  2729de:	41 ba 00 00 00 00    	mov    $0x0,%r10d
  2729e4:	4d 0f 46 d6          	cmovbe %r14,%r10
  2729e8:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
  2729ed:	48 0f 47 7c 24 40    	cmova  0x40(%rsp),%rdi
  2729f3:	48 3b 44 24 10       	cmp    0x10(%rsp),%rax
  2729f8:	0f 83 f5 00 00 00    	jae    272af3 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x823>
  2729fe:	4c 8b 84 24 88 00 00 	mov    0x88(%rsp),%r8
  272a05:	00 
  272a06:	45 88 24 00          	mov    %r12b,(%r8,%rax,1)
  272a0a:	4c 3b a4 24 18 01 00 	cmp    0x118(%rsp),%r12
  272a11:	00 
  272a12:	0f 83 f3 00 00 00    	jae    272b0b <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x83b>
  272a18:	4c 29 d6             	sub    %r10,%rsi
  272a1b:	49 0f af f1          	imul   %r9,%rsi
  272a1f:	4c 8d 3c 77          	lea    (%rdi,%rsi,2),%r15
  272a23:	4b 8d 34 4f          	lea    (%r15,%r9,2),%rsi
  272a27:	48 8b bc 24 10 01 00 	mov    0x110(%rsp),%rdi
  272a2e:	00 
  272a2f:	4a ff 04 e7          	incq   (%rdi,%r12,8)
  272a33:	48 ff c0             	inc    %rax
  272a36:	e9 65 ff ff ff       	jmp    2729a0 <<block_msd_research::frontier::block::Sorter<u16>>::scatter_grouped::<u16, block_msd_research::frontier::local_distribution::block_bytes<u16, u16, block_msd_research::frontier::pa::partition<u16, u16, block_msd_research::frontier::Identity>::{closure#0}, true>::{closure#1}>+0x6d0>
  272a3b:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
  272a40:	48 03 8c 24 90 00 00 	add    0x90(%rsp),%rcx
  272a47:	00 
  272a48:	48 8b 94 24 98 00 00 	mov    0x98(%rsp),%rdx
  272a4f:	00 
  272a50:	4c 89 2a             	mov    %r13,(%rdx)
  272a53:	48 89 6a 08          	mov    %rbp,0x8(%rdx)
  272a57:	4c 89 39             	mov    %r15,(%rcx)
  272a5a:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
  272a5f:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  272a63:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
  272a6a:	5b                   	pop    %rbx
  272a6b:	41 5c                	pop    %r12
  272a6d:	41 5d                	pop    %r13
  272a6f:	41 5e                	pop    %r14
  272a71:	41 5f                	pop    %r15
  272a73:	5d                   	pop    %rbp
  272a74:	c5 f8 77             	vzeroupper
  272a77:	c3                   	ret
  272a78:	48 8d 3d b4 36 da ff 	lea    -0x25c94c(%rip),%rdi        # 16133 <anon.8f17df2f0ddc4723825c0f55871536dc.0.llvm.6863592281246770637+0xf3>
  272a7f:	48 8d 15 d2 4b 35 00 	lea    0x354bd2(%rip),%rdx        # 5c7658 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x370>
  272a86:	be 2c 00 00 00       	mov    $0x2c,%esi
  272a8b:	c5 f8 77             	vzeroupper
  272a8e:	ff 15 1c fe 35 00    	call   *0x35fe1c(%rip)        # 5d28b0 <_DYNAMIC+0x290>
  272a94:	48 8d 15 dd 48 35 00 	lea    0x3548dd(%rip),%rdx        # 5c7378 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x90>
  272a9b:	48 89 c7             	mov    %rax,%rdi
  272a9e:	48 89 de             	mov    %rbx,%rsi
  272aa1:	c5 f8 77             	vzeroupper
  272aa4:	ff 15 1e fe 35 00    	call   *0x35fe1e(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  272aaa:	48 8d 15 c7 48 35 00 	lea    0x3548c7(%rip),%rdx        # 5c7378 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x90>
  272ab1:	48 89 c7             	mov    %rax,%rdi
  272ab4:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
  272ab9:	c5 f8 77             	vzeroupper
  272abc:	ff 15 06 fe 35 00    	call   *0x35fe06(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  272ac2:	48 8d 15 af 48 35 00 	lea    0x3548af(%rip),%rdx        # 5c7378 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x90>
  272ac9:	4c 89 c7             	mov    %r8,%rdi
  272acc:	48 8b b4 24 18 01 00 	mov    0x118(%rsp),%rsi
  272ad3:	00 
  272ad4:	c5 f8 77             	vzeroupper
  272ad7:	ff 15 eb fd 35 00    	call   *0x35fdeb(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  272add:	48 8d 15 7c 48 35 00 	lea    0x35487c(%rip),%rdx        # 5c7360 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x78>
  272ae4:	48 89 c7             	mov    %rax,%rdi
  272ae7:	48 89 de             	mov    %rbx,%rsi
  272aea:	c5 f8 77             	vzeroupper
  272aed:	ff 15 d5 fd 35 00    	call   *0x35fdd5(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  272af3:	48 8d 15 66 48 35 00 	lea    0x354866(%rip),%rdx        # 5c7360 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x78>
  272afa:	48 89 c7             	mov    %rax,%rdi
  272afd:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
  272b02:	c5 f8 77             	vzeroupper
  272b05:	ff 15 bd fd 35 00    	call   *0x35fdbd(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  272b0b:	48 8d 15 4e 48 35 00 	lea    0x35484e(%rip),%rdx        # 5c7360 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x78>
  272b12:	4c 89 e7             	mov    %r12,%rdi
  272b15:	48 8b b4 24 18 01 00 	mov    0x118(%rsp),%rsi
  272b1c:	00 
  272b1d:	c5 f8 77             	vzeroupper
  272b20:	ff 15 a2 fd 35 00    	call   *0x35fda2(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  272b26:	48 8d 15 1b 48 35 00 	lea    0x35481b(%rip),%rdx        # 5c7348 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x60>
  272b2d:	48 89 f7             	mov    %rsi,%rdi
  272b30:	c5 f8 77             	vzeroupper
  272b33:	ff 15 8f fd 35 00    	call   *0x35fd8f(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  272b39:	48 8d 15 c0 47 35 00 	lea    0x3547c0(%rip),%rdx        # 5c7300 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x18>
  272b40:	4c 89 d7             	mov    %r10,%rdi
  272b43:	ff 15 7f fd 35 00    	call   *0x35fd7f(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  272b49:	48 8d 15 c8 47 35 00 	lea    0x3547c8(%rip),%rdx        # 5c7318 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x30>
  272b50:	4c 89 fe             	mov    %r15,%rsi
  272b53:	ff 15 6f fd 35 00    	call   *0x35fd6f(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  272b59:	48 8d 15 d0 47 35 00 	lea    0x3547d0(%rip),%rdx        # 5c7330 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x48>
  272b60:	4c 89 e7             	mov    %r12,%rdi
  272b63:	4c 89 fe             	mov    %r15,%rsi
  272b66:	ff 15 5c fd 35 00    	call   *0x35fd5c(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>

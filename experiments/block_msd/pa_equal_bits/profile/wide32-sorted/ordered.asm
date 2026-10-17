
experiments/block_msd/target/pa-equal-bits/time:     file format elf64-x86-64


Disassembly of section .text:

00000000000e51d0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>>:
   e51d0:	push   %rbp
   e51d1:	push   %r15
   e51d3:	push   %r14
   e51d5:	push   %r13
   e51d7:	push   %r12
   e51d9:	push   %rbx
   e51da:	sub    $0x68,%rsp
   e51de:	cmp    $0x2,%rsi
   e51e2:	jae    e51f8 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x28>
   e51e4:	mov    $0x1,%al
   e51e6:	add    $0x68,%rsp
   e51ea:	pop    %rbx
   e51eb:	pop    %r12
   e51ed:	pop    %r13
   e51ef:	pop    %r14
   e51f1:	pop    %r15
   e51f3:	pop    %rbp
   e51f4:	vzeroupper
   e51f7:	ret
   e51f8:	mov    (%rdi),%rcx
   e51fb:	mov    0x8(%rdi),%rax
   e51ff:	mov    %rsi,0x8(%rsp)
   e5204:	lea    -0x1(%rsi),%r13
   e5208:	movabs $0x3ffffffffffff80,%rsi
   e5212:	and    %r13,%rsi
   e5215:	mov    %rdi,0x10(%rsp)
   e521a:	je     e53b5 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x1e5>
   e5220:	lea    0x20(%rdi),%r10
   e5224:	lea    -0x80(%rsi),%r11
   e5228:	shr    $0x7,%r11
   e522c:	xor    %edx,%edx
   e522e:	jmp    e5249 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x79>
   e5230:	add    $0x1000,%r10
   e5237:	cmp    %r11,%rdx
   e523a:	lea    0x1(%rdx),%rdx
   e523e:	mov    0x10(%rsp),%rdi
   e5243:	je     e53b5 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x1e5>
   e5249:	xor    %r9d,%r9d
   e524c:	xor    %edi,%edi
   e524e:	xor    %ebx,%ebx
   e5250:	mov    (%r10,%rbx,1),%r8
   e5254:	xor    %rcx,%r8
   e5257:	or     %r9,%r8
   e525a:	mov    0x8(%r10,%rbx,1),%r9
   e525f:	xor    %rax,%r9
   e5262:	or     %rdi,%r9
   e5265:	mov    0x28(%r10,%rbx,1),%r14
   e526a:	xor    %rax,%r14
   e526d:	mov    0x20(%r10,%rbx,1),%r15
   e5272:	xor    %rcx,%r15
   e5275:	mov    0x40(%r10,%rbx,1),%rdi
   e527a:	xor    %rcx,%rdi
   e527d:	or     %r15,%rdi
   e5280:	or     %r8,%rdi
   e5283:	mov    0x48(%r10,%rbx,1),%r15
   e5288:	xor    %rax,%r15
   e528b:	or     %r14,%r15
   e528e:	or     %r9,%r15
   e5291:	mov    0x68(%r10,%rbx,1),%r8
   e5296:	xor    %rax,%r8
   e5299:	mov    0x60(%r10,%rbx,1),%r9
   e529e:	xor    %rcx,%r9
   e52a1:	mov    0x80(%r10,%rbx,1),%r12
   e52a9:	xor    %rcx,%r12
   e52ac:	or     %r9,%r12
   e52af:	mov    0x88(%r10,%rbx,1),%r9
   e52b7:	xor    %rax,%r9
   e52ba:	or     %r8,%r9
   e52bd:	mov    0xa8(%r10,%rbx,1),%r8
   e52c5:	xor    %rax,%r8
   e52c8:	or     %r9,%r8
   e52cb:	or     %r15,%r8
   e52ce:	mov    0xa0(%r10,%rbx,1),%r14
   e52d6:	xor    %rcx,%r14
   e52d9:	or     %r12,%r14
   e52dc:	or     %rdi,%r14
   e52df:	mov    0xc0(%r10,%rbx,1),%r15
   e52e7:	xor    %rcx,%r15
   e52ea:	mov    0xc8(%r10,%rbx,1),%r12
   e52f2:	xor    %rax,%r12
   e52f5:	mov    0xe8(%r10,%rbx,1),%rdi
   e52fd:	mov    0xe0(%r10,%rbx,1),%r9
   e5305:	add    $0x100,%rbx
   e530c:	xor    %rax,%rdi
   e530f:	or     %r12,%rdi
   e5312:	or     %r8,%rdi
   e5315:	xor    %rcx,%r9
   e5318:	or     %r15,%r9
   e531b:	or     %r14,%r9
   e531e:	cmp    $0x1000,%rbx
   e5325:	jne    e5250 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x80>
   e532b:	or     %rdi,%r9
   e532e:	je     e5230 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x60>
   e5334:	xor    %r8d,%r8d
   e5337:	xor    %edi,%edi
   e5339:	nopl   0x0(%rax)
   e5340:	mov    (%r10,%r8,1),%rbx
   e5344:	mov    0x8(%r10,%r8,1),%r14
   e5349:	mov    %r14,%r9
   e534c:	xor    %rax,%r9
   e534f:	mov    %rbx,%r15
   e5352:	xor    %rcx,%r15
   e5355:	or     %r9,%r15
   e5358:	jne    e5740 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x570>
   e535e:	mov    0x20(%r10,%r8,1),%rbx
   e5363:	mov    0x28(%r10,%r8,1),%r14
   e5368:	mov    %r14,%r9
   e536b:	xor    %rax,%r9
   e536e:	mov    %rbx,%r15
   e5371:	xor    %rcx,%r15
   e5374:	or     %r9,%r15
   e5377:	jne    e573d <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x56d>
   e537d:	cmp    $0xfc0,%r8
   e5384:	je     e5230 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x60>
   e538a:	mov    0x40(%r10,%r8,1),%rbx
   e538f:	mov    0x48(%r10,%r8,1),%r14
   e5394:	add    $0x60,%r8
   e5398:	add    $0x3,%rdi
   e539c:	mov    %r14,%r9
   e539f:	xor    %rax,%r9
   e53a2:	mov    %rbx,%r15
   e53a5:	xor    %rcx,%r15
   e53a8:	or     %r9,%r15
   e53ab:	je     e5340 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x170>
   e53ad:	dec    %rdi
   e53b0:	jmp    e5740 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x570>
   e53b5:	shl    $0x5,%rsi
   e53b9:	lea    (%rdi,%rsi,1),%rdx
   e53bd:	add    $0x20,%rdx
   e53c1:	and    $0x7f,%r13d
   e53c5:	mov    %r13d,%esi
   e53c8:	shl    $0x5,%esi
   e53cb:	not    %r13
   e53ce:	add    0x8(%rsp),%r13
   e53d3:	xor    %edi,%edi
   e53d5:	data16 cs nopw 0x0(%rax,%rax,1)
   e53e0:	cmp    %rdi,%rsi
   e53e3:	je     e51e4 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x14>
   e53e9:	mov    (%rdx,%rdi,1),%rbx
   e53ed:	mov    0x8(%rdx,%rdi,1),%r14
   e53f2:	mov    %r14,%r8
   e53f5:	xor    %rax,%r8
   e53f8:	mov    %rbx,%r9
   e53fb:	xor    %rcx,%r9
   e53fe:	add    $0x20,%rdi
   e5402:	inc    %r13
   e5405:	or     %r8,%r9
   e5408:	je     e53e0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x210>
   e540a:	cmp    %rcx,%rbx
   e540d:	sbb    %rax,%r14
   e5410:	jae    e5757 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x587>
   e5416:	mov    0x8(%rsp),%rdx
   e541b:	mov    %rdx,%rax
   e541e:	sub    %r13,%rax
   e5421:	jb     e5d96 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xbc6>
   e5427:	lea    -0x1(%rax),%rsi
   e542b:	sub    %r13,%rdx
   e542e:	mov    0x10(%rsp),%rax
   e5433:	je     e5d85 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xbb5>
   e5439:	mov    %r13,0x20(%rsp)
   e543e:	shl    $0x5,%r13
   e5442:	mov    %r13,0x40(%rsp)
   e5447:	lea    (%rax,%r13,1),%rbp
   e544b:	mov    %rsi,%rax
   e544e:	and    $0xffffffffffffff80,%rax
   e5452:	mov    %rax,0x50(%rsp)
   e5457:	mov    %rdx,0x58(%rsp)
   e545c:	mov    %rdx,0x38(%rsp)
   e5461:	lea    0x20(%rbp),%rax
   e5465:	mov    %rax,0x60(%rsp)
   e546a:	shr    $0x7,%rsi
   e546e:	mov    $0x33,%al
   e5470:	mov    %rsi,0x48(%rsp)
   e5475:	bzhi   %rax,%rsi,%rax
   e547a:	mov    %rax,0x28(%rsp)
   e547f:	xor    %edi,%edi
   e5481:	mov    %rbp,0x30(%rsp)
   e5486:	xor    %ebx,%ebx
   e5488:	nopl   0x0(%rax,%rax,1)
   e5490:	cmp    0x28(%rsp),%rdi
   e5495:	je     e5943 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x773>
   e549b:	mov    %rdi,0x18(%rsp)
   e54a0:	mov    %rdi,%r13
   e54a3:	shl    $0xc,%r13
   e54a7:	mov    0x30(%rsp),%rax
   e54ac:	lea    (%rax,%r13,1),%rdx
   e54b0:	add    0x60(%rsp),%r13
   e54b5:	kmovd  %ebx,%k0
   e54b9:	kshiftlb $0x7,%k0,%k0
   e54bf:	kshiftrb $0x7,%k0,%k2
   e54c5:	kxnorw %k0,%k0,%k0
   e54c9:	kxorw  %k0,%k0,%k3
   e54cd:	mov    $0x60,%eax
   e54d2:	kxnorw %k0,%k0,%k1
   e54d6:	cs nopw 0x0(%rax,%rax,1)
   e54e0:	mov    -0x60(%rbp,%rax,1),%r12
   e54e5:	mov    -0x58(%rbp,%rax,1),%r8
   e54ea:	mov    -0x20(%rbp,%rax,1),%rbx
   e54ef:	mov    -0x18(%rbp,%rax,1),%r10
   e54f4:	mov    -0x38(%rbp,%rax,1),%r11
   e54f9:	mov    -0x40(%rbp,%rax,1),%r9
   e54fe:	mov    0x28(%rbp,%rax,1),%r14
   e5503:	mov    0x8(%rbp,%rax,1),%r15
   e5508:	mov    0x20(%rbp,%rax,1),%rdi
   e550d:	mov    0x0(%rbp,%rax,1),%rsi
   e5512:	cmp    %rbx,%r9
   e5515:	mov    %r11,%rcx
   e5518:	sbb    %r10,%rcx
   e551b:	setae  %cl
   e551e:	kmovd  %ecx,%k4
   e5522:	kshiftlb $0x1,%k4,%k4
   e5528:	cmp    %r9,%r12
   e552b:	mov    %r8,%rcx
   e552e:	sbb    %r11,%rcx
   e5531:	setae  %cl
   e5534:	kmovd  %ecx,%k5
   e5538:	kshiftlb $0x7,%k5,%k5
   e553e:	kshiftrb $0x7,%k5,%k5
   e5544:	korw   %k4,%k5,%k4
   e5548:	cmp    %rdi,%rsi
   e554b:	mov    %r15,%rcx
   e554e:	sbb    %r14,%rcx
   e5551:	setae  %cl
   e5554:	kmovd  %ecx,%k5
   e5558:	kshiftlb $0x1,%k5,%k5
   e555e:	cmp    %rsi,%rbx
   e5561:	mov    %r10,%rcx
   e5564:	sbb    %r15,%rcx
   e5567:	setae  %cl
   e556a:	kmovd  %ecx,%k6
   e556e:	kshiftlb $0x7,%k6,%k6
   e5574:	kshiftrb $0x7,%k6,%k6
   e557a:	korw   %k5,%k6,%k5
   e557e:	kandw  %k4,%k0,%k0
   e5582:	kandw  %k5,%k1,%k1
   e5586:	xor    %r11,%r8
   e5589:	xor    %r10,%r11
   e558c:	xor    %r9,%r12
   e558f:	xor    %rbx,%r9
   e5592:	or     %r11,%r9
   e5595:	sete   %cl
   e5598:	kmovd  %ecx,%k4
   e559c:	kshiftlb $0x1,%k4,%k4
   e55a2:	or     %r8,%r12
   e55a5:	sete   %cl
   e55a8:	kmovd  %ecx,%k5
   e55ac:	kshiftlb $0x7,%k5,%k5
   e55b2:	kshiftrb $0x7,%k5,%k5
   e55b8:	korw   %k4,%k5,%k4
   e55bc:	xor    %r15,%r14
   e55bf:	xor    %rsi,%rdi
   e55c2:	or     %r14,%rdi
   e55c5:	sete   %cl
   e55c8:	kmovd  %ecx,%k5
   e55cc:	kshiftlb $0x1,%k5,%k5
   e55d2:	xor    %r15,%r10
   e55d5:	xor    %rsi,%rbx
   e55d8:	or     %r10,%rbx
   e55db:	sete   %cl
   e55de:	kmovd  %ecx,%k6
   e55e2:	kshiftlb $0x7,%k6,%k6
   e55e8:	kshiftrb $0x7,%k6,%k6
   e55ee:	korw   %k5,%k6,%k5
   e55f2:	korw   %k4,%k2,%k2
   e55f6:	korw   %k5,%k3,%k3
   e55fa:	sub    $0xffffffffffffff80,%rax
   e55fe:	cmp    $0xfe0,%rax
   e5604:	jne    e54e0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x310>
   e560a:	korw   %k2,%k3,%k2
   e560e:	kmovd  %k2,%eax
   e5612:	test   $0x3,%al
   e5614:	setne  %sil
   e5618:	vmovdqa 0xf80(%rdx),%xmm0
   e5620:	kandw  %k0,%k1,%k0
   e5624:	vpxor  0xf80(%r13),%xmm0,%xmm0
   e562d:	vptest %xmm0,%xmm0
   e5632:	sete   %bl
   e5635:	vmovdqa 0xfa0(%rdx),%xmm0
   e563d:	vpxor  0xfa0(%r13),%xmm0,%xmm0
   e5646:	vptest %xmm0,%xmm0
   e564b:	knotw  %k0,%k0
   e564f:	kmovd  %k0,%r9d
   e5653:	sete   %cl
   e5656:	vmovdqa 0xfc0(%rdx),%xmm0
   e565e:	vpxor  0xfc0(%r13),%xmm0,%xmm0
   e5667:	vptest %xmm0,%xmm0
   e566c:	vmovdqa 0xfe0(%rdx),%xmm0
   e5674:	vpxor  0xfe0(%r13),%xmm0,%xmm0
   e567d:	sete   %dil
   e5681:	vptest %xmm0,%xmm0
   e5686:	sete   %r8b
   e568a:	xor    %eax,%eax
   e568c:	test   $0x3,%r9b
   e5690:	jne    e51e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x16>
   e5696:	mov    0xf88(%rdx),%r9
   e569d:	mov    0xf80(%r13),%r10
   e56a4:	cmp    %r10,0xf80(%rdx)
   e56ab:	sbb    0xf88(%r13),%r9
   e56b2:	jb     e51e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x16>
   e56b8:	mov    0xfa8(%rdx),%r9
   e56bf:	mov    0xfa0(%r13),%r10
   e56c6:	cmp    %r10,0xfa0(%rdx)
   e56cd:	sbb    0xfa8(%r13),%r9
   e56d4:	jb     e51e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x16>
   e56da:	mov    0xfc8(%rdx),%r9
   e56e1:	mov    0xfc0(%r13),%r10
   e56e8:	cmp    %r10,0xfc0(%rdx)
   e56ef:	sbb    0xfc8(%r13),%r9
   e56f6:	jb     e51e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x16>
   e56fc:	or     %cl,%bl
   e56fe:	or     %dil,%bl
   e5701:	or     %r8b,%bl
   e5704:	or     %sil,%bl
   e5707:	mov    0x18(%rsp),%rdi
   e570c:	inc    %rdi
   e570f:	add    $0x1000,%rbp
   e5716:	mov    0xfe8(%rdx),%rcx
   e571d:	mov    0xfe0(%r13),%rsi
   e5724:	cmp    %rsi,0xfe0(%rdx)
   e572b:	sbb    0xfe8(%r13),%rcx
   e5732:	jae    e5490 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x2c0>
   e5738:	jmp    e51e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x16>
   e573d:	inc    %rdi
   e5740:	shl    $0x7,%rdx
   e5744:	lea    (%rdi,%rdx,1),%r13
   e5748:	inc    %r13
   e574b:	cmp    %rcx,%rbx
   e574e:	sbb    %rax,%r14
   e5751:	jb     e5416 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x246>
   e5757:	mov    0x8(%rsp),%rdx
   e575c:	mov    %rdx,%rax
   e575f:	sub    %r13,%rax
   e5762:	jb     e5da9 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xbd9>
   e5768:	lea    -0x1(%rax),%rsi
   e576c:	sub    %r13,%rdx
   e576f:	mov    %rdx,0x8(%rsp)
   e5774:	mov    0x10(%rsp),%rax
   e5779:	je     e5d85 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xbb5>
   e577f:	shl    $0x5,%r13
   e5783:	mov    %r13,0x20(%rsp)
   e5788:	lea    (%rax,%r13,1),%rcx
   e578c:	mov    %rsi,%rax
   e578f:	and    $0xffffffffffffff80,%rax
   e5793:	mov    %rax,0x18(%rsp)
   e5798:	shr    $0x7,%rsi
   e579c:	mov    $0x33,%al
   e579e:	mov    %rsi,0x28(%rsp)
   e57a3:	bzhi   %rax,%rsi,%r11
   e57a8:	xor    %ebx,%ebx
   e57aa:	mov    %rcx,%r14
   e57ad:	nopl   (%rax)
   e57b0:	cmp    %r11,%rbx
   e57b3:	je     e5a0b <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x83b>
   e57b9:	mov    %rbx,%r12
   e57bc:	shl    $0xc,%r12
   e57c0:	lea    (%rcx,%r12,1),%r15
   e57c4:	lea    0x20(%rcx),%rax
   e57c8:	add    %rax,%r12
   e57cb:	kxnorw %k0,%k0,%k0
   e57cf:	mov    $0x60,%eax
   e57d4:	kxnorw %k0,%k0,%k1
   e57d8:	nopl   0x0(%rax,%rax,1)
   e57e0:	mov    -0x20(%r14,%rax,1),%rdi
   e57e5:	mov    -0x18(%r14,%rax,1),%r8
   e57ea:	mov    -0x40(%r14,%rax,1),%r9
   e57ef:	mov    -0x38(%r14,%rax,1),%r10
   e57f4:	mov    0x28(%r14,%rax,1),%rbp
   e57f9:	mov    0x8(%r14,%rax,1),%rdx
   e57fe:	cmp    -0x60(%r14,%rax,1),%r9
   e5803:	mov    %r10,%r13
   e5806:	sbb    -0x58(%r14,%rax,1),%r13
   e580b:	mov    (%r14,%rax,1),%r13
   e580f:	setae  %sil
   e5813:	cmp    %r9,%rdi
   e5816:	mov    %r8,%r9
   e5819:	sbb    %r10,%r9
   e581c:	setae  %r9b
   e5820:	kmovd  %r9d,%k2
   e5825:	kshiftlb $0x1,%k2,%k2
   e582b:	kmovd  %esi,%k3
   e582f:	kshiftlb $0x7,%k3,%k3
   e5835:	kshiftrb $0x7,%k3,%k3
   e583b:	korw   %k2,%k3,%k2
   e583f:	cmp    %rdi,%r13
   e5842:	mov    %rdx,%rsi
   e5845:	sbb    %r8,%rsi
   e5848:	setae  %sil
   e584c:	cmp    %r13,0x20(%r14,%rax,1)
   e5851:	sbb    %rdx,%rbp
   e5854:	setae  %dl
   e5857:	kmovd  %edx,%k3
   e585b:	kshiftlb $0x1,%k3,%k3
   e5861:	kmovd  %esi,%k4
   e5865:	kshiftlb $0x7,%k4,%k4
   e586b:	kshiftrb $0x7,%k4,%k4
   e5871:	korw   %k3,%k4,%k3
   e5875:	kandw  %k2,%k0,%k0
   e5879:	kandw  %k3,%k1,%k1
   e587d:	sub    $0xffffffffffffff80,%rax
   e5881:	cmp    $0xfe0,%rax
   e5887:	jne    e57e0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x610>
   e588d:	kandw  %k0,%k1,%k0
   e5891:	knotw  %k0,%k0
   e5895:	kmovd  %k0,%edx
   e5899:	xor    %eax,%eax
   e589b:	test   $0x3,%dl
   e589e:	jne    e51e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x16>
   e58a4:	mov    0xf80(%r15),%rdx
   e58ab:	mov    0xf88(%r12),%rsi
   e58b3:	cmp    %rdx,0xf80(%r12)
   e58bb:	sbb    0xf88(%r15),%rsi
   e58c2:	jb     e51e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x16>
   e58c8:	mov    0xfa0(%r15),%rdx
   e58cf:	mov    0xfa8(%r12),%rsi
   e58d7:	cmp    %rdx,0xfa0(%r12)
   e58df:	sbb    0xfa8(%r15),%rsi
   e58e6:	jb     e51e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x16>
   e58ec:	mov    0xfc0(%r15),%rdx
   e58f3:	mov    0xfc8(%r12),%rsi
   e58fb:	cmp    %rdx,0xfc0(%r12)
   e5903:	sbb    0xfc8(%r15),%rsi
   e590a:	jb     e51e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x16>
   e5910:	inc    %rbx
   e5913:	add    $0x1000,%r14
   e591a:	mov    0xfe0(%r15),%rdx
   e5921:	mov    0xfe8(%r12),%rsi
   e5929:	cmp    %rdx,0xfe0(%r12)
   e5931:	sbb    0xfe8(%r15),%rsi
   e5938:	jae    e57b0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x5e0>
   e593e:	jmp    e51e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x16>
   e5943:	mov    0x58(%rsp),%r9
   e5948:	mov    0x50(%rsp),%rdi
   e594d:	sub    %rdi,%r9
   e5950:	mov    0x10(%rsp),%r14
   e5955:	jb     e5dbc <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xbec>
   e595b:	cmp    $0x2,%r9
   e595f:	mov    0x20(%rsp),%r12
   e5964:	jb     e59c7 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x7f7>
   e5966:	shl    $0x5,%rdi
   e596a:	mov    0x30(%rsp),%rax
   e596f:	mov    (%rax,%rdi,1),%rcx
   e5973:	mov    0x8(%rax,%rdi,1),%rdx
   e5978:	inc    %r9
   e597b:	mov    0x48(%rsp),%rax
   e5980:	shl    $0xc,%rax
   e5984:	add    0x40(%rsp),%rax
   e5989:	add    %r14,%rax
   e598c:	add    $0x20,%rax
   e5990:	mov    (%rax),%rsi
   e5993:	mov    0x8(%rax),%rdi
   e5997:	cmp    %rsi,%rcx
   e599a:	mov    %rdx,%r8
   e599d:	sbb    %rdi,%r8
   e59a0:	jb     e5d66 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xb96>
   e59a6:	xor    %rsi,%rcx
   e59a9:	xor    %rdi,%rdx
   e59ac:	or     %rcx,%rdx
   e59af:	sete   %cl
   e59b2:	or     %cl,%bl
   e59b4:	dec    %r9
   e59b7:	add    $0x20,%rax
   e59bb:	mov    %rsi,%rcx
   e59be:	mov    %rdi,%rdx
   e59c1:	cmp    $0x3,%r9
   e59c5:	jae    e5990 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x7c0>
   e59c7:	mov    0x8(%rsp),%rsi
   e59cc:	mov    %rsi,%rdi
   e59cf:	shr    $1,%rdi
   e59d2:	shl    $0x5,%rsi
   e59d6:	lea    -0x1(%rdi),%r8
   e59da:	mov    %edi,%eax
   e59dc:	and    $0x3,%eax
   e59df:	movabs $0x7fffffffffffffe,%rcx
   e59e9:	movabs $0x7fffffffffffffd,%rdx
   e59f3:	movabs $0x7fffffffffffffc,%r10
   e59fd:	cmp    $0x3,%r8
   e5a01:	jae    e5a7a <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x8aa>
   e5a03:	xor    %r8d,%r8d
   e5a06:	jmp    e5b39 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x969>
   e5a0b:	mov    0x8(%rsp),%rdx
   e5a10:	mov    0x18(%rsp),%rdi
   e5a15:	cmp    %rdx,%rdi
   e5a18:	mov    0x20(%rsp),%rax
   e5a1d:	ja     e5dd1 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xc01>
   e5a23:	mov    0x28(%rsp),%rcx
   e5a28:	shl    $0xc,%rcx
   e5a2c:	add    %rax,%rcx
   e5a2f:	mov    0x10(%rsp),%rax
   e5a34:	add    %rax,%rcx
   e5a37:	add    $0x20,%rcx
   e5a3b:	sub    %rdi,%rdx
   e5a3e:	inc    %rdx
   e5a41:	mov    %rdx,%rdi
   e5a44:	data16 data16 cs nopw 0x0(%rax,%rax,1)
   e5a50:	dec    %rdi
   e5a53:	cmp    $0x2,%rdi
   e5a57:	setb   %al
   e5a5a:	jb     e51e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x16>
   e5a60:	mov    (%rcx),%rdx
   e5a63:	mov    0x8(%rcx),%rsi
   e5a67:	cmp    -0x20(%rcx),%rdx
   e5a6b:	sbb    -0x18(%rcx),%rsi
   e5a6f:	lea    0x20(%rcx),%rcx
   e5a73:	jae    e5a50 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x880>
   e5a75:	jmp    e51e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x16>
   e5a7a:	lea    (%r14,%rsi,1),%r9
   e5a7e:	movabs $0x1fffffffffffffc,%r8
   e5a88:	and    %r8,%rdi
   e5a8b:	lea    0x60(%r14),%r11
   e5a8f:	add    %rsi,%r14
   e5a92:	add    $0xffffffffffffffe0,%r14
   e5a96:	xor    %r8d,%r8d
   e5a99:	nopl   0x0(%rax)
   e5aa0:	vmovups -0x60(%r11),%ymm0
   e5aa6:	vmovups (%r14),%ymm1
   e5aab:	vmovups %ymm1,-0x60(%r11)
   e5ab1:	vmovups %ymm0,(%r14)
   e5ab6:	mov    %r8,%r15
   e5ab9:	xor    %rcx,%r15
   e5abc:	shl    $0x5,%r15
   e5ac0:	vmovups -0x40(%r11),%ymm0
   e5ac6:	vmovups (%r9,%r15,1),%ymm1
   e5acc:	vmovups %ymm1,-0x40(%r11)
   e5ad2:	vmovups %ymm0,(%r9,%r15,1)
   e5ad8:	mov    %r8,%r15
   e5adb:	xor    %rdx,%r15
   e5ade:	shl    $0x5,%r15
   e5ae2:	vmovups -0x20(%r11),%ymm0
   e5ae8:	vmovups (%r9,%r15,1),%ymm1
   e5aee:	vmovups %ymm1,-0x20(%r11)
   e5af4:	vmovups %ymm0,(%r9,%r15,1)
   e5afa:	mov    %r8,%r15
   e5afd:	xor    %r10,%r15
   e5b00:	shl    $0x5,%r15
   e5b04:	vmovdqu (%r11),%ymm0
   e5b09:	vmovups (%r9,%r15,1),%ymm1
   e5b0f:	vmovups %ymm1,(%r11)
   e5b14:	vmovdqu %ymm0,(%r9,%r15,1)
   e5b1a:	add    $0x4,%r8
   e5b1e:	sub    $0xffffffffffffff80,%r11
   e5b22:	add    $0xffffffffffffff80,%r14
   e5b26:	cmp    %r8,%rdi
   e5b29:	jne    e5aa0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x8d0>
   e5b2f:	test   %rax,%rax
   e5b32:	mov    0x10(%rsp),%r14
   e5b37:	je     e5b81 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9b1>
   e5b39:	shl    $0x5,%r8
   e5b3d:	lea    (%r14,%r8,1),%rdi
   e5b41:	sub    %r8,%rsi
   e5b44:	add    %r14,%rsi
   e5b47:	add    $0xffffffffffffffe0,%rsi
   e5b4b:	shl    $0x5,%eax
   e5b4e:	xor    %r8d,%r8d
   e5b51:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   e5b60:	vmovdqu (%rdi,%r8,1),%ymm0
   e5b66:	vmovups (%rsi),%ymm1
   e5b6a:	vmovups %ymm1,(%rdi,%r8,1)
   e5b70:	vmovdqu %ymm0,(%rsi)
   e5b74:	add    $0x20,%r8
   e5b78:	add    $0xffffffffffffffe0,%rsi
   e5b7c:	cmp    %r8,%rax
   e5b7f:	jne    e5b60 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x990>
   e5b81:	cmp    $0x2,%r12
   e5b85:	setae  %al
   e5b88:	or     %bl,%al
   e5b8a:	test   $0x1,%al
   e5b8c:	je     e51e4 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x14>
   e5b92:	lea    0x20(%r14),%r9
   e5b96:	lea    0x60(%r14),%rax
   e5b9a:	mov    %rax,0x18(%rsp)
   e5b9f:	lea    -0x20(%r14),%rbx
   e5ba3:	xor    %esi,%esi
   e5ba5:	mov    0x8(%rsp),%r11
   e5baa:	jmp    e5bbe <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9ee>
   e5bac:	nopl   0x0(%rax)
   e5bb0:	mov    0x8(%rsp),%r11
   e5bb5:	cmp    %r11,%rsi
   e5bb8:	jae    e51e4 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x14>
   e5bbe:	mov    %rsi,%rax
   e5bc1:	mov    %rsi,%r14
   e5bc4:	shl    $0x5,%r14
   e5bc8:	mov    0x10(%rsp),%r8
   e5bcd:	mov    (%r8,%r14,1),%rdi
   e5bd1:	mov    0x8(%r8,%r14,1),%r15
   e5bd6:	lea    0x1(%rsi),%r8
   e5bda:	cmp    %r8,%r11
   e5bdd:	cmova  %r11,%r8
   e5be1:	lea    -0x1(%r8),%r12
   e5be5:	lea    (%r9,%r14,1),%r13
   e5be9:	nopl   0x0(%rax)
   e5bf0:	cmp    %rsi,%r12
   e5bf3:	je     e5c20 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xa50>
   e5bf5:	inc    %rsi
   e5bf8:	mov    0x0(%r13),%rbp
   e5bfc:	xor    %rdi,%rbp
   e5bff:	mov    0x8(%r13),%r11
   e5c03:	xor    %r15,%r11
   e5c06:	add    $0x20,%r13
   e5c0a:	or     %rbp,%r11
   e5c0d:	je     e5bf0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xa20>
   e5c0f:	jmp    e5c23 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xa53>
   e5c11:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   e5c20:	mov    %r8,%rsi
   e5c23:	mov    %rsi,%r8
   e5c26:	sub    %rax,%r8
   e5c29:	jb     e5d6d <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xb9d>
   e5c2f:	mov    %r8,%rdi
   e5c32:	shr    $1,%rdi
   e5c35:	je     e5bb0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9e0>
   e5c3b:	mov    %rsi,%rax
   e5c3e:	shl    $0x5,%rax
   e5c42:	mov    %edi,%r15d
   e5c45:	and    $0x3,%r15d
   e5c49:	cmp    $0x8,%r8
   e5c4d:	jae    e5c60 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xa90>
   e5c4f:	xor    %r8d,%r8d
   e5c52:	jmp    e5d1a <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xb4a>
   e5c57:	nopw   0x0(%rax,%rax,1)
   e5c60:	mov    0x10(%rsp),%r8
   e5c65:	lea    (%r8,%rax,1),%r12
   e5c69:	and    $0xfffffffffffffffc,%rdi
   e5c6d:	mov    0x18(%rsp),%r8
   e5c72:	lea    (%r8,%r14,1),%r13
   e5c76:	lea    (%rbx,%rax,1),%rbp
   e5c7a:	xor    %r8d,%r8d
   e5c7d:	nopl   (%rax)
   e5c80:	vmovups -0x60(%r13),%ymm0
   e5c86:	vmovups 0x0(%rbp),%ymm1
   e5c8b:	vmovups %ymm1,-0x60(%r13)
   e5c91:	vmovups %ymm0,0x0(%rbp)
   e5c96:	mov    %r8,%r11
   e5c99:	xor    %rcx,%r11
   e5c9c:	shl    $0x5,%r11
   e5ca0:	vmovups -0x40(%r13),%ymm0
   e5ca6:	vmovups (%r12,%r11,1),%ymm1
   e5cac:	vmovups %ymm1,-0x40(%r13)
   e5cb2:	vmovups %ymm0,(%r12,%r11,1)
   e5cb8:	mov    %r8,%r11
   e5cbb:	xor    %rdx,%r11
   e5cbe:	shl    $0x5,%r11
   e5cc2:	vmovups -0x20(%r13),%ymm0
   e5cc8:	vmovups (%r12,%r11,1),%ymm1
   e5cce:	vmovups %ymm1,-0x20(%r13)
   e5cd4:	vmovups %ymm0,(%r12,%r11,1)
   e5cda:	mov    %r8,%r11
   e5cdd:	xor    %r10,%r11
   e5ce0:	shl    $0x5,%r11
   e5ce4:	vmovdqu 0x0(%r13),%ymm0
   e5cea:	vmovups (%r12,%r11,1),%ymm1
   e5cf0:	vmovups %ymm1,0x0(%r13)
   e5cf6:	vmovdqu %ymm0,(%r12,%r11,1)
   e5cfc:	add    $0x4,%r8
   e5d00:	sub    $0xffffffffffffff80,%r13
   e5d04:	add    $0xffffffffffffff80,%rbp
   e5d08:	cmp    %r8,%rdi
   e5d0b:	jne    e5c80 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xab0>
   e5d11:	test   %r15,%r15
   e5d14:	je     e5bb0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9e0>
   e5d1a:	shl    $0x5,%r8
   e5d1e:	add    0x10(%rsp),%r14
   e5d23:	add    %r8,%r14
   e5d26:	sub    %r8,%rax
   e5d29:	add    %rbx,%rax
   e5d2c:	shl    $0x5,%r15d
   e5d30:	xor    %edi,%edi
   e5d32:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   e5d40:	vmovdqu (%r14,%rdi,1),%ymm0
   e5d46:	vmovups (%rax),%ymm1
   e5d4a:	vmovups %ymm1,(%r14,%rdi,1)
   e5d50:	vmovdqu %ymm0,(%rax)
   e5d54:	add    $0x20,%rdi
   e5d58:	add    $0xffffffffffffffe0,%rax
   e5d5c:	cmp    %rdi,%r15
   e5d5f:	jne    e5d40 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xb70>
   e5d61:	jmp    e5bb0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9e0>
   e5d66:	xor    %eax,%eax
   e5d68:	jmp    e51e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x16>
   e5d6d:	lea    0x3d269c(%rip),%rcx        # 4b8410 <anon.005357b6259aec7dbb5efeaf9c6c1e46.1.llvm.5840278210049151275>
   e5d74:	mov    %rax,%rdi
   e5d77:	mov    0x8(%rsp),%rdx
   e5d7c:	vzeroupper
   e5d7f:	call   *0x3d52f3(%rip)        # 4bb078 <_DYNAMIC+0x298>
   e5d85:	lea    0x3c9504(%rip),%rcx        # 4af290 <anon.3d84203c20d4cfb8601923c71fa1d189.0.llvm.9770386453263282830+0x60>
   e5d8c:	xor    %edi,%edi
   e5d8e:	xor    %edx,%edx
   e5d90:	call   *0x3d52e2(%rip)        # 4bb078 <_DYNAMIC+0x298>
   e5d96:	lea    0x3c94db(%rip),%rcx        # 4af278 <anon.3d84203c20d4cfb8601923c71fa1d189.0.llvm.9770386453263282830+0x48>
   e5d9d:	mov    %r13,%rdi
   e5da0:	mov    %rdx,%rsi
   e5da3:	call   *0x3d52cf(%rip)        # 4bb078 <_DYNAMIC+0x298>
   e5da9:	lea    0x3c94b0(%rip),%rcx        # 4af260 <anon.3d84203c20d4cfb8601923c71fa1d189.0.llvm.9770386453263282830+0x30>
   e5db0:	mov    %r13,%rdi
   e5db3:	mov    %rdx,%rsi
   e5db6:	call   *0x3d52bc(%rip)        # 4bb078 <_DYNAMIC+0x298>
   e5dbc:	lea    0x3c94e5(%rip),%rcx        # 4af2a8 <anon.3d84203c20d4cfb8601923c71fa1d189.0.llvm.9770386453263282830+0x78>
   e5dc3:	mov    0x38(%rsp),%rdx
   e5dc8:	mov    %rdx,%rsi
   e5dcb:	call   *0x3d52a7(%rip)        # 4bb078 <_DYNAMIC+0x298>
   e5dd1:	lea    0x3c94d0(%rip),%rcx        # 4af2a8 <anon.3d84203c20d4cfb8601923c71fa1d189.0.llvm.9770386453263282830+0x78>
   e5dd8:	mov    %rdx,%rsi
   e5ddb:	call   *0x3d5297(%rip)        # 4bb078 <_DYNAMIC+0x298>

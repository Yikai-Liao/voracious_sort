
experiments/block_msd/target/pa-outline-final/time:     file format elf64-x86-64


Disassembly of section .text:

000000000040c150 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>>:
  40c150:	push   %rbp
  40c151:	push   %r15
  40c153:	push   %r14
  40c155:	push   %r13
  40c157:	push   %r12
  40c159:	push   %rbx
  40c15a:	sub    $0x48,%rsp
  40c15e:	mov    $0x1,%r8b
  40c161:	cmp    $0x2,%rsi
  40c165:	jb     40cc49 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xaf9>
  40c16b:	mov    (%rdi),%rdx
  40c16e:	mov    %rdi,(%rsp)
  40c172:	mov    0x8(%rdi),%rcx
  40c176:	lea    -0x1(%rsi),%r9
  40c17a:	movabs $0x7ffffffffffff80,%r10
  40c184:	and    %r9,%r10
  40c187:	je     40c3d4 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x284>
  40c18d:	mov    (%rsp),%rax
  40c191:	lea    0x10(%rax),%r11
  40c195:	lea    -0x80(%r10),%rbx
  40c199:	shr    $0x7,%rbx
  40c19d:	xor    %r8d,%r8d
  40c1a0:	jmp    40c1c4 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x74>
  40c1a2:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  40c1b0:	add    $0x800,%r11
  40c1b7:	cmp    %rbx,%r8
  40c1ba:	lea    0x1(%r8),%r8
  40c1be:	je     40c3d4 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x284>
  40c1c4:	kxnorw %k0,%k0,%k0
  40c1c8:	xor    %r14d,%r14d
  40c1cb:	kxnorw %k0,%k0,%k3
  40c1cf:	kxnorw %k0,%k0,%k2
  40c1d3:	kxnorw %k0,%k0,%k1
  40c1d7:	nopw   0x0(%rax,%rax,1)
  40c1e0:	mov    (%r11,%r14,1),%rax
  40c1e4:	xor    %rdx,%rax
  40c1e7:	mov    0x8(%r11,%r14,1),%rdi
  40c1ec:	xor    %rcx,%rdi
  40c1ef:	or     %rax,%rdi
  40c1f2:	sete   %al
  40c1f5:	kmovd  %eax,%k4
  40c1f9:	kshiftlb $0x7,%k4,%k4
  40c1ff:	kshiftrb $0x7,%k4,%k4
  40c205:	mov    0x10(%r11,%r14,1),%rax
  40c20a:	xor    %rdx,%rax
  40c20d:	mov    0x18(%r11,%r14,1),%rdi
  40c212:	xor    %rcx,%rdi
  40c215:	or     %rax,%rdi
  40c218:	sete   %al
  40c21b:	kmovd  %eax,%k5
  40c21f:	kshiftlb $0x1,%k5,%k5
  40c225:	korw   %k5,%k4,%k4
  40c229:	kmovw  %k4,0x8(%rsp)
  40c22f:	mov    0x20(%r11,%r14,1),%rax
  40c234:	xor    %rdx,%rax
  40c237:	mov    0x28(%r11,%r14,1),%rdi
  40c23c:	xor    %rcx,%rdi
  40c23f:	or     %rax,%rdi
  40c242:	sete   %al
  40c245:	kmovd  %eax,%k5
  40c249:	kshiftlb $0x7,%k5,%k5
  40c24f:	kshiftrb $0x7,%k5,%k5
  40c255:	mov    0x30(%r11,%r14,1),%rax
  40c25a:	xor    %rdx,%rax
  40c25d:	mov    0x38(%r11,%r14,1),%rdi
  40c262:	xor    %rcx,%rdi
  40c265:	or     %rax,%rdi
  40c268:	sete   %al
  40c26b:	kmovd  %eax,%k6
  40c26f:	kshiftlb $0x1,%k6,%k6
  40c275:	korw   %k6,%k5,%k5
  40c279:	mov    0x40(%r11,%r14,1),%rax
  40c27e:	xor    %rdx,%rax
  40c281:	mov    0x48(%r11,%r14,1),%rdi
  40c286:	xor    %rcx,%rdi
  40c289:	or     %rax,%rdi
  40c28c:	sete   %al
  40c28f:	kmovd  %eax,%k6
  40c293:	kshiftlb $0x7,%k6,%k6
  40c299:	kshiftrb $0x7,%k6,%k6
  40c29f:	mov    0x50(%r11,%r14,1),%rax
  40c2a4:	xor    %rdx,%rax
  40c2a7:	mov    0x58(%r11,%r14,1),%rdi
  40c2ac:	xor    %rcx,%rdi
  40c2af:	or     %rax,%rdi
  40c2b2:	sete   %al
  40c2b5:	kmovd  %eax,%k7
  40c2b9:	kshiftlb $0x1,%k7,%k7
  40c2bf:	korw   %k7,%k6,%k6
  40c2c3:	mov    0x60(%r11,%r14,1),%rax
  40c2c8:	xor    %rdx,%rax
  40c2cb:	mov    0x68(%r11,%r14,1),%rdi
  40c2d0:	xor    %rcx,%rdi
  40c2d3:	or     %rax,%rdi
  40c2d6:	sete   %al
  40c2d9:	kmovd  %eax,%k7
  40c2dd:	kshiftlb $0x7,%k7,%k7
  40c2e3:	kshiftrb $0x7,%k7,%k7
  40c2e9:	mov    0x70(%r11,%r14,1),%rax
  40c2ee:	xor    %rdx,%rax
  40c2f1:	mov    0x78(%r11,%r14,1),%rdi
  40c2f6:	xor    %rcx,%rdi
  40c2f9:	or     %rax,%rdi
  40c2fc:	sete   %al
  40c2ff:	kmovd  %eax,%k4
  40c303:	kshiftlb $0x1,%k4,%k4
  40c309:	korw   %k4,%k7,%k4
  40c30d:	kmovw  0x8(%rsp),%k7
  40c313:	kandw  %k7,%k0,%k0
  40c317:	kandw  %k5,%k3,%k3
  40c31b:	kandw  %k6,%k2,%k2
  40c31f:	kandw  %k4,%k1,%k1
  40c323:	sub    $0xffffffffffffff80,%r14
  40c327:	cmp    $0x800,%r14
  40c32e:	jne    40c1e0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x90>
  40c334:	kandw  %k0,%k3,%k0
  40c338:	kandw  %k0,%k2,%k0
  40c33c:	kandw  %k0,%k1,%k0
  40c340:	knotw  %k0,%k0
  40c344:	kmovd  %k0,%eax
  40c348:	test   $0x3,%al
  40c34a:	je     40c1b0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x60>
  40c350:	xor    %eax,%eax
  40c352:	xor    %r12d,%r12d
  40c355:	data16 cs nopw 0x0(%rax,%rax,1)
  40c360:	mov    (%r11,%rax,1),%r14
  40c364:	mov    0x8(%r11,%rax,1),%r15
  40c369:	mov    %r15,%rdi
  40c36c:	xor    %rcx,%rdi
  40c36f:	mov    %r14,%r13
  40c372:	xor    %rdx,%r13
  40c375:	or     %rdi,%r13
  40c378:	jne    40c642 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x4f2>
  40c37e:	mov    0x10(%r11,%rax,1),%r14
  40c383:	mov    0x18(%r11,%rax,1),%r15
  40c388:	mov    %r15,%rdi
  40c38b:	xor    %rcx,%rdi
  40c38e:	mov    %r14,%r13
  40c391:	xor    %rdx,%r13
  40c394:	or     %rdi,%r13
  40c397:	jne    40c63f <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x4ef>
  40c39d:	cmp    $0x7e0,%rax
  40c3a3:	je     40c1b0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x60>
  40c3a9:	mov    0x20(%r11,%rax,1),%r14
  40c3ae:	mov    0x28(%r11,%rax,1),%r15
  40c3b3:	add    $0x30,%rax
  40c3b7:	add    $0x3,%r12
  40c3bb:	mov    %r15,%rdi
  40c3be:	xor    %rcx,%rdi
  40c3c1:	mov    %r14,%r13
  40c3c4:	xor    %rdx,%r13
  40c3c7:	or     %rdi,%r13
  40c3ca:	je     40c360 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x210>
  40c3cc:	dec    %r12
  40c3cf:	jmp    40c642 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x4f2>
  40c3d4:	shl    $0x4,%r10
  40c3d8:	mov    (%rsp),%rax
  40c3dc:	add    %r10,%rax
  40c3df:	add    $0x10,%rax
  40c3e3:	and    $0x7f,%r9d
  40c3e7:	mov    %r9d,%edi
  40c3ea:	shl    $0x4,%edi
  40c3ed:	not    %r9
  40c3f0:	add    %rsi,%r9
  40c3f3:	xor    %r8d,%r8d
  40c3f6:	cs nopw 0x0(%rax,%rax,1)
  40c400:	cmp    %r8,%rdi
  40c403:	je     40cc46 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xaf6>
  40c409:	mov    (%rax,%r8,1),%r14
  40c40d:	mov    0x8(%rax,%r8,1),%r15
  40c412:	mov    %r15,%r10
  40c415:	xor    %rcx,%r10
  40c418:	mov    %r14,%r11
  40c41b:	xor    %rdx,%r11
  40c41e:	add    $0x10,%r8
  40c422:	inc    %r9
  40c425:	or     %r10,%r11
  40c428:	je     40c400 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x2b0>
  40c42a:	cmp    %rdx,%r14
  40c42d:	mov    %rsi,%rax
  40c430:	sbb    %rcx,%r15
  40c433:	jae    40c65c <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x50c>
  40c439:	sub    %r9,%rax
  40c43c:	jb     40cc6e <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xb1e>
  40c442:	mov    %rsi,%rcx
  40c445:	lea    -0x1(%rax),%rsi
  40c449:	mov    %rcx,0x10(%rsp)
  40c44e:	mov    %rcx,%rax
  40c451:	sub    %r9,%rax
  40c454:	je     40cc94 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xb44>
  40c45a:	mov    %r9,%rdx
  40c45d:	shl    $0x4,%rdx
  40c461:	mov    (%rsp),%rcx
  40c465:	lea    (%rcx,%rdx,1),%rdi
  40c469:	mov    %rdi,0x28(%rsp)
  40c46e:	mov    %rsi,%rdi
  40c471:	and    $0xffffffffffffff80,%rdi
  40c475:	mov    %rdi,0x40(%rsp)
  40c47a:	mov    %rax,0x18(%rsp)
  40c47f:	mov    %rax,0x20(%rsp)
  40c484:	shr    $0x7,%rsi
  40c488:	mov    $0x34,%al
  40c48a:	mov    %rsi,0x38(%rsp)
  40c48f:	bzhi   %rax,%rsi,%rax
  40c494:	mov    %rax,0x8(%rsp)
  40c499:	mov    %rdx,0x30(%rsp)
  40c49e:	lea    (%rdx,%rcx,1),%r12
  40c4a2:	add    $0x30,%r12
  40c4a6:	xor    %r13d,%r13d
  40c4a9:	xor    %ebx,%ebx
  40c4ab:	nopl   0x0(%rax,%rax,1)
  40c4b0:	cmp    0x8(%rsp),%r13
  40c4b5:	je     40c837 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x6e7>
  40c4bb:	kmovd  %ebx,%k0
  40c4bf:	kshiftlb $0x7,%k0,%k0
  40c4c5:	kshiftrb $0x7,%k0,%k0
  40c4cb:	kxnorw %k0,%k0,%k2
  40c4cf:	kxorw  %k0,%k0,%k1
  40c4d3:	xor    %ebx,%ebx
  40c4d5:	kxnorw %k0,%k0,%k3
  40c4d9:	nopl   0x0(%rax)
  40c4e0:	mov    -0x30(%r12,%rbx,1),%r15
  40c4e5:	mov    -0x28(%r12,%rbx,1),%rsi
  40c4ea:	mov    -0x10(%r12,%rbx,1),%rbp
  40c4ef:	mov    -0x8(%r12,%rbx,1),%r14
  40c4f4:	mov    -0x18(%r12,%rbx,1),%rcx
  40c4f9:	mov    -0x20(%r12,%rbx,1),%rax
  40c4fe:	mov    0x18(%r12,%rbx,1),%r8
  40c503:	mov    0x8(%r12,%rbx,1),%r10
  40c508:	mov    0x10(%r12,%rbx,1),%r11
  40c50d:	mov    (%r12,%rbx,1),%rdx
  40c511:	cmp    %rbp,%rax
  40c514:	mov    %rcx,%rdi
  40c517:	sbb    %r14,%rdi
  40c51a:	setae  %dil
  40c51e:	kmovd  %edi,%k4
  40c522:	kshiftlb $0x1,%k4,%k4
  40c528:	cmp    %rax,%r15
  40c52b:	mov    %rsi,%rdi
  40c52e:	sbb    %rcx,%rdi
  40c531:	setae  %dil
  40c535:	kmovd  %edi,%k5
  40c539:	kshiftlb $0x7,%k5,%k5
  40c53f:	kshiftrb $0x7,%k5,%k5
  40c545:	korw   %k4,%k5,%k4
  40c549:	cmp    %r11,%rdx
  40c54c:	mov    %r10,%rdi
  40c54f:	sbb    %r8,%rdi
  40c552:	setae  %dil
  40c556:	kmovd  %edi,%k5
  40c55a:	kshiftlb $0x1,%k5,%k5
  40c560:	cmp    %rdx,%rbp
  40c563:	mov    %r14,%rdi
  40c566:	sbb    %r10,%rdi
  40c569:	setae  %dil
  40c56d:	kmovd  %edi,%k6
  40c571:	kshiftlb $0x7,%k6,%k6
  40c577:	kshiftrb $0x7,%k6,%k6
  40c57d:	korw   %k5,%k6,%k5
  40c581:	kandw  %k4,%k2,%k2
  40c585:	kandw  %k5,%k3,%k3
  40c589:	xor    %rcx,%rsi
  40c58c:	xor    %r14,%rcx
  40c58f:	xor    %rax,%r15
  40c592:	xor    %rbp,%rax
  40c595:	or     %rcx,%rax
  40c598:	sete   %al
  40c59b:	kmovd  %eax,%k4
  40c59f:	kshiftlb $0x1,%k4,%k4
  40c5a5:	or     %rsi,%r15
  40c5a8:	sete   %al
  40c5ab:	kmovd  %eax,%k5
  40c5af:	kshiftlb $0x7,%k5,%k5
  40c5b5:	kshiftrb $0x7,%k5,%k5
  40c5bb:	korw   %k4,%k5,%k4
  40c5bf:	xor    %r10,%r8
  40c5c2:	xor    %rdx,%r11
  40c5c5:	or     %r8,%r11
  40c5c8:	sete   %al
  40c5cb:	kmovd  %eax,%k5
  40c5cf:	kshiftlb $0x1,%k5,%k5
  40c5d5:	xor    %r10,%r14
  40c5d8:	xor    %rdx,%rbp
  40c5db:	or     %r14,%rbp
  40c5de:	sete   %al
  40c5e1:	kmovd  %eax,%k6
  40c5e5:	kshiftlb $0x7,%k6,%k6
  40c5eb:	kshiftrb $0x7,%k6,%k6
  40c5f1:	korw   %k5,%k6,%k5
  40c5f5:	korw   %k4,%k0,%k0
  40c5f9:	korw   %k5,%k1,%k1
  40c5fd:	add    $0x40,%rbx
  40c601:	cmp    $0x800,%rbx
  40c608:	jne    40c4e0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x390>
  40c60e:	kandw  %k2,%k3,%k2
  40c612:	knotw  %k2,%k2
  40c616:	kmovd  %k2,%eax
  40c61a:	korw   %k0,%k1,%k0
  40c61e:	kmovd  %k0,%ecx
  40c622:	test   $0x3,%cl
  40c625:	setne  %bl
  40c628:	inc    %r13
  40c62b:	add    $0x800,%r12
  40c632:	test   $0x3,%al
  40c634:	je     40c4b0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x360>
  40c63a:	jmp    40c82f <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x6df>
  40c63f:	inc    %r12
  40c642:	shl    $0x7,%r8
  40c646:	lea    (%r12,%r8,1),%r9
  40c64a:	inc    %r9
  40c64d:	cmp    %rdx,%r14
  40c650:	mov    %rsi,%rax
  40c653:	sbb    %rcx,%r15
  40c656:	jb     40c439 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x2e9>
  40c65c:	sub    %r9,%rax
  40c65f:	jb     40cc81 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xb31>
  40c665:	dec    %rax
  40c668:	sub    %r9,%rsi
  40c66b:	je     40cca5 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xb55>
  40c671:	mov    %rax,%rcx
  40c674:	and    $0xffffffffffffff80,%rcx
  40c678:	mov    %rcx,0x10(%rsp)
  40c67d:	shr    $0x7,%rax
  40c681:	mov    $0x34,%cl
  40c683:	mov    %rax,0x18(%rsp)
  40c688:	bzhi   %rcx,%rax,%rax
  40c68d:	mov    %rax,0x8(%rsp)
  40c692:	shl    $0x4,%r9
  40c696:	mov    (%rsp),%rax
  40c69a:	lea    (%r9,%rax,1),%r8
  40c69e:	add    $0x70,%r8
  40c6a2:	xor    %r10d,%r10d
  40c6a5:	data16 cs nopw 0x0(%rax,%rax,1)
  40c6b0:	cmp    0x8(%rsp),%r10
  40c6b5:	je     40c85a <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x70a>
  40c6bb:	kxnorw %k0,%k0,%k0
  40c6bf:	xor    %r11d,%r11d
  40c6c2:	kxnorw %k0,%k0,%k1
  40c6c6:	cs nopw 0x0(%rax,%rax,1)
  40c6d0:	mov    -0x50(%r8,%r11,1),%r15
  40c6d5:	mov    -0x48(%r8,%r11,1),%r14
  40c6da:	mov    -0x60(%r8,%r11,1),%rdi
  40c6df:	mov    -0x58(%r8,%r11,1),%rbx
  40c6e4:	mov    -0x38(%r8,%r11,1),%r12
  40c6e9:	mov    -0x40(%r8,%r11,1),%r13
  40c6ee:	cmp    %rdi,%r15
  40c6f1:	mov    %r14,%rbp
  40c6f4:	sbb    %rbx,%rbp
  40c6f7:	setae  %bpl
  40c6fb:	kmovd  %ebp,%k2
  40c6ff:	kshiftlb $0x1,%k2,%k2
  40c705:	cmp    -0x70(%r8,%r11,1),%rdi
  40c70a:	sbb    -0x68(%r8,%r11,1),%rbx
  40c70f:	setae  %dil
  40c713:	kmovd  %edi,%k3
  40c717:	kshiftlb $0x7,%k3,%k3
  40c71d:	kshiftrb $0x7,%k3,%k3
  40c723:	korw   %k2,%k3,%k2
  40c727:	mov    -0x30(%r8,%r11,1),%rdi
  40c72c:	cmp    %r13,%rdi
  40c72f:	mov    -0x28(%r8,%r11,1),%rbx
  40c734:	mov    %rbx,%rbp
  40c737:	sbb    %r12,%rbp
  40c73a:	setae  %bpl
  40c73e:	kmovd  %ebp,%k3
  40c742:	kshiftlb $0x1,%k3,%k3
  40c748:	cmp    %r15,%r13
  40c74b:	sbb    %r14,%r12
  40c74e:	setae  %bpl
  40c752:	kmovd  %ebp,%k4
  40c756:	kshiftlb $0x7,%k4,%k4
  40c75c:	kshiftrb $0x7,%k4,%k4
  40c762:	korw   %k3,%k4,%k3
  40c766:	kandw  %k2,%k0,%k0
  40c76a:	kandw  %k3,%k1,%k1
  40c76e:	mov    -0x10(%r8,%r11,1),%r14
  40c773:	mov    -0x18(%r8,%r11,1),%r13
  40c778:	mov    -0x8(%r8,%r11,1),%rcx
  40c77d:	mov    -0x20(%r8,%r11,1),%rbp
  40c782:	mov    0x8(%r8,%r11,1),%r12
  40c787:	mov    0x18(%r8,%r11,1),%rdx
  40c78c:	mov    (%r8,%r11,1),%rax
  40c790:	cmp    %rbp,%r14
  40c793:	mov    %rcx,%r15
  40c796:	sbb    %r13,%r15
  40c799:	setae  %r15b
  40c79d:	kmovd  %r15d,%k2
  40c7a2:	kshiftlb $0x1,%k2,%k2
  40c7a8:	cmp    %rdi,%rbp
  40c7ab:	sbb    %rbx,%r13
  40c7ae:	setae  %dil
  40c7b2:	kmovd  %edi,%k3
  40c7b6:	kshiftlb $0x7,%k3,%k3
  40c7bc:	kshiftrb $0x7,%k3,%k3
  40c7c2:	korw   %k2,%k3,%k2
  40c7c6:	cmp    %rax,0x10(%r8,%r11,1)
  40c7cb:	sbb    %r12,%rdx
  40c7ce:	setae  %dl
  40c7d1:	kmovd  %edx,%k3
  40c7d5:	kshiftlb $0x1,%k3,%k3
  40c7db:	cmp    %r14,%rax
  40c7de:	sbb    %rcx,%r12
  40c7e1:	setae  %al
  40c7e4:	kmovd  %eax,%k4
  40c7e8:	kshiftlb $0x7,%k4,%k4
  40c7ee:	kshiftrb $0x7,%k4,%k4
  40c7f4:	korw   %k3,%k4,%k3
  40c7f8:	kandw  %k2,%k0,%k0
  40c7fc:	kandw  %k3,%k1,%k1
  40c800:	sub    $0xffffffffffffff80,%r11
  40c804:	cmp    $0x800,%r11
  40c80b:	jne    40c6d0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x580>
  40c811:	kandw  %k0,%k1,%k0
  40c815:	knotw  %k0,%k0
  40c819:	kmovd  %k0,%eax
  40c81d:	inc    %r10
  40c820:	add    $0x800,%r8
  40c827:	test   $0x3,%al
  40c829:	je     40c6b0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x560>
  40c82f:	xor    %r8d,%r8d
  40c832:	jmp    40cc49 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xaf9>
  40c837:	mov    0x18(%rsp),%r11
  40c83c:	mov    0x40(%rsp),%rdi
  40c841:	sub    %rdi,%r11
  40c844:	jb     40ccb9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xb69>
  40c84a:	cmp    $0x2,%r11
  40c84e:	jae    40c8bb <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x76b>
  40c850:	mov    0x10(%rsp),%r8
  40c855:	jmp    40c927 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x7d7>
  40c85a:	mov    0x10(%rsp),%rdi
  40c85f:	cmp    %rsi,%rdi
  40c862:	ja     40ccce <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xb7e>
  40c868:	mov    0x18(%rsp),%rcx
  40c86d:	shl    $0xb,%rcx
  40c871:	add    %r9,%rcx
  40c874:	mov    (%rsp),%rax
  40c878:	add    %rcx,%rax
  40c87b:	add    $0x10,%rax
  40c87f:	sub    %rdi,%rsi
  40c882:	inc    %rsi
  40c885:	data16 cs nopw 0x0(%rax,%rax,1)
  40c890:	dec    %rsi
  40c893:	cmp    $0x2,%rsi
  40c897:	setb   %r8b
  40c89b:	jb     40cc49 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xaf9>
  40c8a1:	mov    (%rax),%rcx
  40c8a4:	mov    0x8(%rax),%rdx
  40c8a8:	cmp    -0x10(%rax),%rcx
  40c8ac:	sbb    -0x8(%rax),%rdx
  40c8b0:	lea    0x10(%rax),%rax
  40c8b4:	jae    40c890 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x740>
  40c8b6:	jmp    40cc49 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xaf9>
  40c8bb:	shl    $0x4,%rdi
  40c8bf:	mov    0x28(%rsp),%rax
  40c8c4:	mov    (%rax,%rdi,1),%rdx
  40c8c8:	mov    0x8(%rax,%rdi,1),%rsi
  40c8cd:	inc    %r11
  40c8d0:	mov    0x38(%rsp),%rcx
  40c8d5:	shl    $0xb,%rcx
  40c8d9:	add    0x30(%rsp),%rcx
  40c8de:	mov    (%rsp),%rax
  40c8e2:	add    %rcx,%rax
  40c8e5:	add    $0x10,%rax
  40c8e9:	mov    0x10(%rsp),%r8
  40c8ee:	xchg   %ax,%ax
  40c8f0:	mov    (%rax),%rdi
  40c8f3:	mov    0x8(%rax),%r10
  40c8f7:	cmp    %rdi,%rdx
  40c8fa:	mov    %rsi,%rcx
  40c8fd:	sbb    %r10,%rcx
  40c900:	jb     40c82f <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x6df>
  40c906:	xor    %rdi,%rdx
  40c909:	xor    %r10,%rsi
  40c90c:	or     %rdx,%rsi
  40c90f:	sete   %cl
  40c912:	or     %cl,%bl
  40c914:	dec    %r11
  40c917:	add    $0x10,%rax
  40c91b:	mov    %rdi,%rdx
  40c91e:	mov    %r10,%rsi
  40c921:	cmp    $0x3,%r11
  40c925:	jae    40c8f0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x7a0>
  40c927:	mov    %r8,%rsi
  40c92a:	shr    $1,%rsi
  40c92d:	mov    %r8,%rdx
  40c930:	shl    $0x4,%rdx
  40c934:	lea    -0x1(%rsi),%rax
  40c938:	mov    %esi,%ecx
  40c93a:	and    $0x3,%ecx
  40c93d:	cmp    $0x3,%rax
  40c941:	jae    40c94a <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x7fa>
  40c943:	xor    %edi,%edi
  40c945:	jmp    40ca1c <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8cc>
  40c94a:	mov    (%rsp),%rdi
  40c94e:	lea    (%rdi,%rdx,1),%r10
  40c952:	movabs $0x3fffffffffffffc,%rax
  40c95c:	and    %rax,%rsi
  40c95f:	lea    0x30(%rdi),%rax
  40c963:	lea    (%rdx,%rdi,1),%r11
  40c967:	add    $0xfffffffffffffff0,%r11
  40c96b:	xor    %edi,%edi
  40c96d:	movabs $0xffffffffffffffe,%r14
  40c977:	movabs $0xffffffffffffffd,%r15
  40c981:	movabs $0xffffffffffffffc,%r12
  40c98b:	nopl   0x0(%rax,%rax,1)
  40c990:	vmovaps -0x30(%rax),%xmm0
  40c995:	vmovaps (%r11),%xmm1
  40c99a:	vmovaps %xmm1,-0x30(%rax)
  40c99f:	vmovaps %xmm0,(%r11)
  40c9a4:	mov    %rdi,%r13
  40c9a7:	xor    %r14,%r13
  40c9aa:	shl    $0x4,%r13
  40c9ae:	vmovaps -0x20(%rax),%xmm0
  40c9b3:	vmovaps (%r10,%r13,1),%xmm1
  40c9b9:	vmovaps %xmm1,-0x20(%rax)
  40c9be:	vmovaps %xmm0,(%r10,%r13,1)
  40c9c4:	mov    %rdi,%r13
  40c9c7:	xor    %r15,%r13
  40c9ca:	shl    $0x4,%r13
  40c9ce:	vmovaps -0x10(%rax),%xmm0
  40c9d3:	vmovaps (%r10,%r13,1),%xmm1
  40c9d9:	vmovaps %xmm1,-0x10(%rax)
  40c9de:	vmovaps %xmm0,(%r10,%r13,1)
  40c9e4:	mov    %rdi,%r13
  40c9e7:	xor    %r12,%r13
  40c9ea:	shl    $0x4,%r13
  40c9ee:	vmovaps (%rax),%xmm0
  40c9f2:	vmovaps (%r10,%r13,1),%xmm1
  40c9f8:	vmovaps %xmm1,(%rax)
  40c9fc:	vmovaps %xmm0,(%r10,%r13,1)
  40ca02:	add    $0x4,%rdi
  40ca06:	add    $0x40,%rax
  40ca0a:	add    $0xffffffffffffffc0,%r11
  40ca0e:	cmp    %rdi,%rsi
  40ca11:	jne    40c990 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x840>
  40ca17:	test   %rcx,%rcx
  40ca1a:	je     40ca5f <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x90f>
  40ca1c:	shl    $0x4,%rdi
  40ca20:	mov    (%rsp),%rsi
  40ca24:	lea    (%rsi,%rdi,1),%rax
  40ca28:	sub    %rdi,%rdx
  40ca2b:	add    %rsi,%rdx
  40ca2e:	add    $0xfffffffffffffff0,%rdx
  40ca32:	shl    $0x4,%ecx
  40ca35:	xor    %esi,%esi
  40ca37:	nopw   0x0(%rax,%rax,1)
  40ca40:	vmovaps (%rax,%rsi,1),%xmm0
  40ca45:	vmovaps (%rdx),%xmm1
  40ca49:	vmovaps %xmm1,(%rax,%rsi,1)
  40ca4e:	vmovaps %xmm0,(%rdx)
  40ca52:	add    $0x10,%rsi
  40ca56:	add    $0xfffffffffffffff0,%rdx
  40ca5a:	cmp    %rsi,%rcx
  40ca5d:	jne    40ca40 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8f0>
  40ca5f:	cmp    $0x2,%r9
  40ca63:	setae  %al
  40ca66:	or     %bl,%al
  40ca68:	test   $0x1,%al
  40ca6a:	je     40cc46 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xaf6>
  40ca70:	mov    (%rsp),%r9
  40ca74:	lea    0x10(%r9),%rcx
  40ca78:	lea    0x30(%r9),%rax
  40ca7c:	mov    %rax,0x10(%rsp)
  40ca81:	lea    -0x10(%r9),%rax
  40ca85:	mov    %rax,0x8(%rsp)
  40ca8a:	xor    %esi,%esi
  40ca8c:	movabs $0xffffffffffffffe,%r11
  40ca96:	movabs $0xffffffffffffffd,%rbx
  40caa0:	movabs $0xffffffffffffffc,%r14
  40caaa:	jmp    40cab9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x969>
  40caac:	nopl   0x0(%rax)
  40cab0:	cmp    %r8,%rsi
  40cab3:	jae    40cc46 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xaf6>
  40cab9:	mov    %rsi,%rdx
  40cabc:	mov    %rsi,%r15
  40cabf:	shl    $0x4,%r15
  40cac3:	mov    (%r9,%r15,1),%rax
  40cac7:	mov    0x8(%r9,%r15,1),%r9
  40cacc:	lea    0x1(%rsi),%rdi
  40cad0:	cmp    %rdi,%r8
  40cad3:	cmova  %r8,%rdi
  40cad7:	lea    -0x1(%rdi),%r12
  40cadb:	lea    (%rcx,%r15,1),%r13
  40cadf:	nop
  40cae0:	cmp    %rsi,%r12
  40cae3:	je     40cb10 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x9c0>
  40cae5:	inc    %rsi
  40cae8:	mov    0x0(%r13),%rbp
  40caec:	xor    %rax,%rbp
  40caef:	mov    0x8(%r13),%r10
  40caf3:	xor    %r9,%r10
  40caf6:	add    $0x10,%r13
  40cafa:	or     %rbp,%r10
  40cafd:	je     40cae0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x990>
  40caff:	jmp    40cb13 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x9c3>
  40cb01:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  40cb10:	mov    %rdi,%rsi
  40cb13:	mov    %rsi,%rax
  40cb16:	sub    %rdx,%rax
  40cb19:	jb     40cc5b <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xb0b>
  40cb1f:	mov    %rax,%rdi
  40cb22:	shr    $1,%rdi
  40cb25:	mov    (%rsp),%r9
  40cb29:	je     40cab0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x960>
  40cb2b:	mov    %rsi,%rdx
  40cb2e:	shl    $0x4,%rdx
  40cb32:	mov    %edi,%r12d
  40cb35:	and    $0x3,%r12d
  40cb39:	cmp    $0x8,%rax
  40cb3d:	jae    40cb50 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa00>
  40cb3f:	xor    %r13d,%r13d
  40cb42:	jmp    40cc06 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xab6>
  40cb47:	nopw   0x0(%rax,%rax,1)
  40cb50:	lea    (%r9,%rdx,1),%rax
  40cb54:	and    $0xfffffffffffffffc,%rdi
  40cb58:	mov    0x10(%rsp),%r9
  40cb5d:	lea    (%r9,%r15,1),%rbp
  40cb61:	mov    0x8(%rsp),%r9
  40cb66:	add    %rdx,%r9
  40cb69:	xor    %r13d,%r13d
  40cb6c:	nopl   0x0(%rax)
  40cb70:	vmovaps -0x30(%rbp),%xmm0
  40cb75:	vmovaps (%r9),%xmm1
  40cb7a:	vmovaps %xmm1,-0x30(%rbp)
  40cb7f:	vmovaps %xmm0,(%r9)
  40cb84:	mov    %r13,%r10
  40cb87:	xor    %r11,%r10
  40cb8a:	shl    $0x4,%r10
  40cb8e:	vmovaps -0x20(%rbp),%xmm0
  40cb93:	vmovaps (%rax,%r10,1),%xmm1
  40cb99:	vmovaps %xmm1,-0x20(%rbp)
  40cb9e:	vmovaps %xmm0,(%rax,%r10,1)
  40cba4:	mov    %r13,%r10
  40cba7:	xor    %rbx,%r10
  40cbaa:	shl    $0x4,%r10
  40cbae:	vmovaps -0x10(%rbp),%xmm0
  40cbb3:	vmovaps (%rax,%r10,1),%xmm1
  40cbb9:	vmovaps %xmm1,-0x10(%rbp)
  40cbbe:	vmovaps %xmm0,(%rax,%r10,1)
  40cbc4:	mov    %r13,%r10
  40cbc7:	xor    %r14,%r10
  40cbca:	shl    $0x4,%r10
  40cbce:	vmovaps 0x0(%rbp),%xmm0
  40cbd3:	vmovaps (%rax,%r10,1),%xmm1
  40cbd9:	vmovaps %xmm1,0x0(%rbp)
  40cbde:	vmovaps %xmm0,(%rax,%r10,1)
  40cbe4:	add    $0x4,%r13
  40cbe8:	add    $0x40,%rbp
  40cbec:	add    $0xffffffffffffffc0,%r9
  40cbf0:	cmp    %r13,%rdi
  40cbf3:	jne    40cb70 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa20>
  40cbf9:	test   %r12,%r12
  40cbfc:	mov    (%rsp),%r9
  40cc00:	je     40cab0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x960>
  40cc06:	shl    $0x4,%r13
  40cc0a:	add    %r9,%r15
  40cc0d:	add    %r13,%r15
  40cc10:	sub    %r13,%rdx
  40cc13:	add    0x8(%rsp),%rdx
  40cc18:	shl    $0x4,%r12d
  40cc1c:	xor    %eax,%eax
  40cc1e:	xchg   %ax,%ax
  40cc20:	vmovaps (%r15,%rax,1),%xmm0
  40cc26:	vmovaps (%rdx),%xmm1
  40cc2a:	vmovaps %xmm1,(%r15,%rax,1)
  40cc30:	vmovaps %xmm0,(%rdx)
  40cc34:	add    $0x10,%rax
  40cc38:	add    $0xfffffffffffffff0,%rdx
  40cc3c:	cmp    %rax,%r12
  40cc3f:	jne    40cc20 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xad0>
  40cc41:	jmp    40cab0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x960>
  40cc46:	mov    $0x1,%r8b
  40cc49:	mov    %r8d,%eax
  40cc4c:	add    $0x48,%rsp
  40cc50:	pop    %rbx
  40cc51:	pop    %r12
  40cc53:	pop    %r13
  40cc55:	pop    %r14
  40cc57:	pop    %r15
  40cc59:	pop    %rbp
  40cc5a:	ret
  40cc5b:	lea    0xabbae(%rip),%rcx        # 4b8810 <anon.005357b6259aec7dbb5efeaf9c6c1e46.1.llvm.5840278210049151275>
  40cc62:	mov    %rdx,%rdi
  40cc65:	mov    %r8,%rdx
  40cc68:	call   *0xae51a(%rip)        # 4bb188 <_DYNAMIC+0x298>
  40cc6e:	lea    0xabe1b(%rip),%rcx        # 4b8a90 <anon.558be735be6fe57aa18aeb617ea02290.7.llvm.4314743697531362127+0x1d8>
  40cc75:	mov    %r9,%rdi
  40cc78:	mov    %rsi,%rdx
  40cc7b:	call   *0xae507(%rip)        # 4bb188 <_DYNAMIC+0x298>
  40cc81:	lea    0xabdf0(%rip),%rcx        # 4b8a78 <anon.558be735be6fe57aa18aeb617ea02290.7.llvm.4314743697531362127+0x1c0>
  40cc88:	mov    %r9,%rdi
  40cc8b:	mov    %rsi,%rdx
  40cc8e:	call   *0xae4f4(%rip)        # 4bb188 <_DYNAMIC+0x298>
  40cc94:	lea    0xabe0d(%rip),%rcx        # 4b8aa8 <anon.558be735be6fe57aa18aeb617ea02290.7.llvm.4314743697531362127+0x1f0>
  40cc9b:	xor    %edi,%edi
  40cc9d:	xor    %edx,%edx
  40cc9f:	call   *0xae4e3(%rip)        # 4bb188 <_DYNAMIC+0x298>
  40cca5:	lea    0xabdfc(%rip),%rcx        # 4b8aa8 <anon.558be735be6fe57aa18aeb617ea02290.7.llvm.4314743697531362127+0x1f0>
  40ccac:	xor    %edi,%edi
  40ccae:	mov    %rax,%rsi
  40ccb1:	xor    %edx,%edx
  40ccb3:	call   *0xae4cf(%rip)        # 4bb188 <_DYNAMIC+0x298>
  40ccb9:	lea    0xabe00(%rip),%rcx        # 4b8ac0 <anon.558be735be6fe57aa18aeb617ea02290.7.llvm.4314743697531362127+0x208>
  40ccc0:	mov    0x20(%rsp),%rdx
  40ccc5:	mov    %rdx,%rsi
  40ccc8:	call   *0xae4ba(%rip)        # 4bb188 <_DYNAMIC+0x298>
  40ccce:	lea    0xabdeb(%rip),%rcx        # 4b8ac0 <anon.558be735be6fe57aa18aeb617ea02290.7.llvm.4314743697531362127+0x208>
  40ccd5:	mov    %rsi,%rdx
  40ccd8:	call   *0xae4aa(%rip)        # 4bb188 <_DYNAMIC+0x298>

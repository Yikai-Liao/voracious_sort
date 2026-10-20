
tools/block_lsd_bench/target/release/block_lsd_bench:	file format elf64-x86-64

Disassembly of section .text:

000000000020a3d0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_>:
  20a3d0:      	pushq	%rbp
  20a3d1:      	pushq	%r15
  20a3d3:      	pushq	%r14
  20a3d5:      	pushq	%r13
  20a3d7:      	pushq	%r12
  20a3d9:      	pushq	%rbx
  20a3da:      	subq	$0xe8, %rsp
  20a3e1:      	movq	%rsi, %r14
  20a3e4:      	movq	%rdi, %r12
  20a3e7:      	cmpq	$0x81, %rsi
  20a3ee:      	jae	0x20a428 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x58>
  20a3f0:      	leaq	0xf(%rsp), %rax
  20a3f5:      	movq	%rax, 0x78(%rsp)
  20a3fa:      	cmpq	$0x2, %r14
  20a3fe:      	jb	0x20aba4 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7d4>
  20a404:      	cmpq	$0x15, %r14
  20a408:      	jae	0x20ac21 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x851>
  20a40e:      	leaq	0x78(%rsp), %rcx
  20a413:      	movl	$0x1, %edx
  20a418:      	movq	%r12, %rdi
  20a41b:      	movq	%r14, %rsi
  20a41e:      	callq	0x1c16a0 <_RINvNtNtNtNtCs3sPX1WnuliO_4core5slice4sort6shared9smallsort25insertion_sort_shift_leftINtCs9j6qJjDxNX3_15block_lsd_bench6RecordyKj2_ENCINvMB8_SB1m_16sort_unstable_byNCINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts8lsd_sort17lsd_radixsort_auxB1m_yE0E0EB1p_>
  20a423:      	jmp	0x20aba4 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7d4>
  20a428:      	vpbroadcastq	(%r12), %zmm0
  20a42f:      	vmovdqa64	-0x1e4479(%rip), %zmm1 # 0x25fc0 <anon.d1e91ee184a9d34e3fc049130aa707f2.36.llvm.13573234348233770204+0x137b>
  20a439:      	movabsq	$0xfffffffffffffff, %rsi # imm = 0xFFFFFFFFFFFFFFF
  20a443:      	movb	$0x3c, %al
  20a445:      	movl	$0x20, %edx
  20a44a:      	leaq	0x190(%r12), %rdi
  20a452:      	addq	%r14, %rsi
  20a455:      	bzhiq	%rax, %rsi, %rax
  20a45a:      	movl	%esi, %ecx
  20a45c:      	andl	$0x1f, %ecx
  20a45f:      	cmovneq	%rcx, %rdx
  20a463:      	movq	%rax, %rcx
  20a466:      	movq	%rax, %r8
  20a469:      	subq	%rdx, %rcx
  20a46c:      	vmovdqa64	%zmm0, %zmm2
  20a472:      	vmovdqa64	%zmm0, %zmm3
  20a478:      	vmovdqa64	%zmm0, %zmm4
  20a47e:      	nop
  20a480:      	vmovdqu64	-0x180(%rdi), %zmm5
  20a487:      	vmovdqu64	-0x100(%rdi), %zmm6
  20a48e:      	vmovdqu64	-0x80(%rdi), %zmm7
  20a495:      	vmovdqu64	(%rdi), %zmm8
  20a49b:      	addq	$-0x20, %r8
  20a49f:      	vpermt2q	-0x140(%rdi), %zmm1, %zmm5
  20a4a6:      	vpermt2q	-0xc0(%rdi), %zmm1, %zmm6
  20a4ad:      	vpermt2q	-0x40(%rdi), %zmm1, %zmm7
  20a4b4:      	vpermt2q	0x40(%rdi), %zmm1, %zmm8
  20a4bb:      	addq	$0x200, %rdi            # imm = 0x200
  20a4c2:      	vpmaxuq	%zmm5, %zmm0, %zmm0
  20a4c8:      	vpmaxuq	%zmm6, %zmm2, %zmm2
  20a4ce:      	vpmaxuq	%zmm7, %zmm3, %zmm3
  20a4d4:      	vpmaxuq	%zmm8, %zmm4, %zmm4
  20a4da:      	cmpq	%r8, %rdx
  20a4dd:      	jne	0x20a480 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0xb0>
  20a4df:      	vpmaxuq	%zmm2, %zmm0, %zmm0
  20a4e5:      	vpmaxuq	%zmm4, %zmm3, %zmm1
  20a4eb:      	vpmaxuq	%zmm1, %zmm0, %zmm0
  20a4f1:      	vextracti64x4	$0x1, %zmm0, %ymm1
  20a4f8:      	vpmaxuq	%ymm1, %ymm0, %ymm0
  20a4fe:      	vextracti128	$0x1, %ymm0, %xmm1
  20a504:      	vpmaxuq	%xmm1, %xmm0, %xmm0
  20a50a:      	vpshufd	$0xee, %xmm0, %xmm1     # xmm1 = xmm0[2,3,2,3]
  20a50f:      	vpmaxuq	%xmm1, %xmm0, %xmm0
  20a515:      	vmovq	%xmm0, %rdi
  20a51a:      	cmpl	$0x5, %edx
  20a51d:      	jb	0x20a58b <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x1bb>
  20a51f:      	andl	$0x3, %esi
  20a522:      	movl	$0x4, %r8d
  20a528:      	vpbroadcastq	%rdi, %ymm0
  20a52e:      	movq	%rax, %rdi
  20a531:      	movq	%rax, %rcx
  20a534:      	cmovneq	%rsi, %r8
  20a538:      	movq	%rdx, %rsi
  20a53b:      	shlq	$0x4, %rdi
  20a53f:      	shll	$0x4, %edx
  20a542:      	subq	%rdx, %rdi
  20a545:      	subq	%r8, %rcx
  20a548:      	subq	%r8, %rsi
  20a54b:      	leaq	0x10(%rdi,%r12), %rdx
  20a550:      	vmovdqu	(%rdx), %ymm1
  20a554:      	vpunpcklqdq	0x20(%rdx), %ymm1, %ymm1 # ymm1 = ymm1[0],mem[0],ymm1[2],mem[2]
  20a559:      	addq	$0x40, %rdx
  20a55d:      	addq	$-0x4, %rsi
  20a561:      	vpermq	$0xd8, %ymm1, %ymm1     # ymm1 = ymm1[0,2,1,3]
  20a567:      	vpmaxuq	%ymm1, %ymm0, %ymm0
  20a56d:      	jne	0x20a550 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x180>
  20a56f:      	vextracti128	$0x1, %ymm0, %xmm1
  20a575:      	vpmaxuq	%xmm1, %xmm0, %xmm0
  20a57b:      	vpshufd	$0xee, %xmm0, %xmm1     # xmm1 = xmm0[2,3,2,3]
  20a580:      	vpmaxuq	%xmm1, %xmm0, %xmm0
  20a586:      	vmovq	%xmm0, %rdi
  20a58b:      	subq	%rcx, %rax
  20a58e:      	shlq	$0x4, %rcx
  20a592:      	leaq	0x10(%rcx,%r12), %rcx
  20a597:      	nopw	(%rax,%rax)
  20a5a0:      	movq	%rdi, %rdx
  20a5a3:      	movq	(%rcx), %rdi
  20a5a6:      	cmpq	%rdi, %rdx
  20a5a9:      	cmovaq	%rdx, %rdi
  20a5ad:      	addq	$0x10, %rcx
  20a5b1:      	decq	%rax
  20a5b4:      	jne	0x20a5a0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x1d0>
  20a5b6:      	lzcntq	%rdi, %rbx
  20a5bb:      	movl	$0x40, %ecx
  20a5c0:      	movl	$0x40, %eax
  20a5c5:      	subq	%rbx, %rcx
  20a5c8:      	testb	$0x7, %cl
  20a5cb:      	je	0x20a5dd <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x20d>
  20a5cd:      	andl	$-0x8, %ecx
  20a5d0:      	xorl	%ebx, %ebx
  20a5d2:      	addq	$0x8, %rcx
  20a5d6:      	subq	%rcx, %rax
  20a5d9:      	cmovaeq	%rax, %rbx
  20a5dd:      	movl	$0x40, %edi
  20a5e2:      	movl	$0x8, %edx
  20a5e7:      	movq	%rbx, %rsi
  20a5ea:      	vzeroupper
  20a5ed:      	callq	*0x1c4925(%rip)         # 0x3cef18 <writev+0x3cef18>
  20a5f3:      	testq	%rax, %rax
  20a5f6:      	je	0x20aba4 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7d4>
  20a5fc:      	movq	$0x0, 0xc0(%rsp)
  20a608:      	movq	$0x8, 0xc8(%rsp)
  20a614:      	movq	%rbx, 0xd0(%rsp)
  20a61c:      	movq	%r14, %rbx
  20a61f:      	movq	%rax, 0xd8(%rsp)
  20a627:      	movq	%rax, 0x18(%rsp)
  20a62c:      	movq	$0x100, 0xe0(%rsp)      # imm = 0x100
  20a638:      	shlq	$0x4, %rbx
  20a63c:      	callq	*0x1c4866(%rip)         # 0x3ceea8 <writev+0x3ceea8>
  20a642:      	movq	%rbx, %rdi
  20a645:      	movq	%rbx, 0x10(%rsp)
  20a64a:      	callq	*0x1c4888(%rip)         # 0x3ceed8 <writev+0x3ceed8>
  20a650:      	movq	%rax, (%rsp)
  20a654:      	testq	%rax, %rax
  20a657:      	je	0x20ac11 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x841>
  20a65d:      	movzbl	0x1c6c74(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20a664:      	testb	%al, %al
  20a666:      	je	0x20a6a5 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x2d5>
  20a668:      	movq	0x10(%rsp), %rax
  20a66d:      	movq	%rax, %rcx
  20a670:      	lock
  20a671:      	xaddq	%rcx, 0x1c6c4f(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20a679:      	addq	%rax, %rcx
  20a67c:      	movq	0x1c6c4d(%rip), %rax    # 0x3d12d0 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4PEAK.llvm.13354737551727885710>
  20a683:      	nopw	%cs:(%rax,%rax)
  20a690:      	cmpq	%rcx, %rax
  20a693:      	movq	%rcx, %rdx
  20a696:      	cmovaq	%rax, %rdx
  20a69a:      	lock
  20a69b:      	cmpxchgq	%rdx, 0x1c6c2d(%rip)    # 0x3d12d0 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4PEAK.llvm.13354737551727885710>
  20a6a3:      	jne	0x20a690 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x2c0>
  20a6a5:      	vmovdqu	(%r12), %xmm0
  20a6ab:      	movq	(%rsp), %rax
  20a6af:      	leaq	-0x1(%r14), %rcx
  20a6b3:      	movl	$0x1, %esi
  20a6b8:      	cmpq	$0x4, %rcx
  20a6bc:      	jb	0x20a795 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x3c5>
  20a6c2:      	cmpq	$0x20, %rcx
  20a6c6:      	jae	0x20a6cf <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x2ff>
  20a6c8:      	xorl	%edx, %edx
  20a6ca:      	jmp	0x20a74e <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x37e>
  20a6cf:      	movq	(%rsp), %rdi
  20a6d3:      	movq	%rcx, %rdx
  20a6d6:      	andq	$-0x20, %rdx
  20a6da:      	vshufi64x2	$0x0, %zmm0, %zmm0, %zmm1 # zmm1 = zmm0[0,1,0,1,0,1,0,1]
  20a6e1:      	movq	%rdx, %rax
  20a6e4:      	shlq	$0x4, %rax
  20a6e8:      	leaq	0x1(%rdx), %rsi
  20a6ec:      	movq	%rdx, %r8
  20a6ef:      	addq	%rdi, %rax
  20a6f2:      	addq	$0x180, %rdi            # imm = 0x180
  20a6f9:      	nopl	(%rax)
  20a700:      	vmovdqu64	%zmm1, -0x180(%rdi)
  20a707:      	vmovdqu64	%zmm1, -0x140(%rdi)
  20a70e:      	vmovdqu64	%zmm1, -0x100(%rdi)
  20a715:      	vmovdqu64	%zmm1, -0xc0(%rdi)
  20a71c:      	vmovdqu64	%zmm1, -0x80(%rdi)
  20a723:      	vmovdqu64	%zmm1, -0x40(%rdi)
  20a72a:      	vmovdqu64	%zmm1, (%rdi)
  20a730:      	vmovdqu64	%zmm1, 0x40(%rdi)
  20a737:      	addq	$0x200, %rdi            # imm = 0x200
  20a73e:      	addq	$-0x20, %r8
  20a742:      	jne	0x20a700 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x330>
  20a744:      	cmpq	%rdx, %rcx
  20a747:      	je	0x20a7ad <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x3dd>
  20a749:      	testb	$0x1c, %cl
  20a74c:      	je	0x20a795 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x3c5>
  20a74e:      	movq	(%rsp), %r9
  20a752:      	movq	%rcx, %rdi
  20a755:      	andq	$-0x4, %rdi
  20a759:      	movq	%rdx, %r8
  20a75c:      	shlq	$0x4, %rdx
  20a760:      	vshufi64x2	$0x0, %zmm0, %zmm0, %zmm1 # zmm1 = zmm0[0,1,0,1,0,1,0,1]
  20a767:      	movq	%rdi, %rax
  20a76a:      	shlq	$0x4, %rax
  20a76e:      	leaq	0x1(%rdi), %rsi
  20a772:      	subq	%rdi, %r8
  20a775:      	addq	%r9, %rax
  20a778:      	addq	%r9, %rdx
  20a77b:      	nopl	(%rax,%rax)
  20a780:      	vmovdqu64	%zmm1, (%rdx)
  20a786:      	addq	$0x40, %rdx
  20a78a:      	addq	$0x4, %r8
  20a78e:      	jne	0x20a780 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x3b0>
  20a790:      	cmpq	%rdi, %rcx
  20a793:      	je	0x20a7ad <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x3dd>
  20a795:      	movq	%r14, %rcx
  20a798:      	subq	%rsi, %rcx
  20a79b:      	nopl	(%rax,%rax)
  20a7a0:      	vmovdqu	%xmm0, (%rax)
  20a7a4:      	addq	$0x10, %rax
  20a7a8:      	decq	%rcx
  20a7ab:      	jne	0x20a7a0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x3d0>
  20a7ad:      	vmovdqu	(%r12), %xmm0
  20a7b3:      	vmovdqu	%xmm0, (%rax)
  20a7b7:      	leaq	0x60(%rsp), %rdi
  20a7bc:      	leaq	0xc0(%rsp), %rcx
  20a7c4:      	movq	%r12, %rsi
  20a7c7:      	movq	%r14, %rdx
  20a7ca:      	vzeroupper
  20a7cd:      	callq	0x19f080 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared5utils19get_full_histogramsINtB6_6RecordyKj2_EyEB6_>
  20a7d2:      	movq	0x10(%rsp), %rax
  20a7d7:      	movq	0x68(%rsp), %r15
  20a7dc:      	movq	0x70(%rsp), %r13
  20a7e1:      	movq	0x18(%rsp), %r11
  20a7e6:      	movabsq	$0x7fffffffffffffc0, %rcx # imm = 0x7FFFFFFFFFFFFFC0
  20a7f0:      	xorl	%ebx, %ebx
  20a7f2:      	movq	%r12, 0x30(%rsp)
  20a7f7:      	movl	%eax, %ebp
  20a7f9:      	andq	%rax, %rcx
  20a7fc:      	andl	$0x30, %ebp
  20a7ff:      	movq	%r15, 0x28(%rsp)
  20a804:      	movq	%r13, 0x38(%rsp)
  20a809:      	movq	%rcx, 0x48(%rsp)
  20a80e:      	movq	%rbp, 0x40(%rsp)
  20a813:      	jmp	0x20a83f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x46f>
  20a815:      	nopw	%cs:(%rax,%rax)
  20a820:      	movq	%r12, %rdi
  20a823:      	callq	*0x1c466f(%rip)         # 0x3cee98 <writev+0x3cee98>
  20a829:      	movq	0x50(%rsp), %r11
  20a82e:      	movq	0x30(%rsp), %r12
  20a833:      	xorl	$0x1, %ebx
  20a836:      	testq	%r11, %r11
  20a839:      	je	0x20aafb <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x72b>
  20a83f:      	leaq	-0x1(%r11), %rax
  20a843:      	jmp	0x20a859 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x489>
  20a845:      	nopw	%cs:(%rax,%rax)
  20a850:      	testq	%r11, %r11
  20a853:      	je	0x20aafb <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x72b>
  20a859:      	movq	%r11, %rbp
  20a85c:      	decq	%r11
  20a85f:      	cmpq	%r13, %rax
  20a862:      	jae	0x20abfc <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x82c>
  20a868:      	leaq	(%r11,%r11,2), %rcx
  20a86c:      	movq	0x10(%r15,%rcx,8), %rdx
  20a871:      	testq	%rdx, %rdx
  20a874:      	je	0x20a850 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x480>
  20a876:      	movq	0x8(%r15,%rcx,8), %rsi
  20a87b:      	leaq	(,%rdx,8), %rcx
  20a883:      	xorl	%edi, %edi
  20a885:      	xorl	%r8d, %r8d
  20a888:      	nopl	(%rax,%rax)
  20a890:      	cmpq	$0x1, (%rsi,%r8)
  20a895:      	sbbl	$-0x1, %edi
  20a898:      	cmpl	$0x1, %edi
  20a89b:      	ja	0x20a8b0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x4e0>
  20a89d:      	addq	$0x8, %r8
  20a8a1:      	cmpq	%r8, %rcx
  20a8a4:      	jne	0x20a890 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x4c0>
  20a8a6:      	jmp	0x20a850 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x480>
  20a8a8:      	nopl	(%rax,%rax)
  20a8b0:      	movq	(%rsp), %r13
  20a8b4:      	testl	%ebx, %ebx
  20a8b6:      	movq	%r12, %r15
  20a8b9:      	movq	%r11, 0x50(%rsp)
  20a8be:      	movq	%rbx, 0x58(%rsp)
  20a8c3:      	cmoveq	%r13, %r15
  20a8c7:      	cmoveq	%r12, %r13
  20a8cb:      	leaq	0x78(%rsp), %rdi
  20a8d0:      	callq	0x1b0810 <_RNvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared5utils11prefix_sums>
  20a8d5:      	movq	0x90(%rsp), %rcx
  20a8dd:      	movq	0x78(%rsp), %rax
  20a8e2:      	movq	0x98(%rsp), %r12
  20a8ea:      	movq	0xa0(%rsp), %rbx
  20a8f2:      	leaq	-0x1(%rbp), %r11
  20a8f6:      	movq	%rcx, 0x20(%rsp)
  20a8fb:      	testq	%rax, %rax
  20a8fe:      	je	0x20a929 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x559>
  20a900:      	movq	0x80(%rsp), %rdi
  20a908:      	movzbl	0x1c69c9(%rip), %ecx    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20a90f:      	testb	%cl, %cl
  20a911:      	je	0x20a91f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x54f>
  20a913:      	shlq	$0x3, %rax
  20a917:      	lock
  20a918:      	subq	%rax, 0x1c69a9(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20a91f:      	callq	*0x1c4573(%rip)         # 0x3cee98 <writev+0x3cee98>
  20a925:      	leaq	-0x1(%rbp), %r11
  20a929:      	movq	0xa8(%rsp), %rax
  20a931:      	testq	%rax, %rax
  20a934:      	je	0x20a95f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x58f>
  20a936:      	movq	0xb0(%rsp), %rdi
  20a93e:      	movzbl	0x1c6993(%rip), %ecx    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20a945:      	testb	%cl, %cl
  20a947:      	je	0x20a955 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x585>
  20a949:      	shlq	$0x3, %rax
  20a94d:      	lock
  20a94e:      	subq	%rax, 0x1c6973(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20a955:      	callq	*0x1c453d(%rip)         # 0x3cee98 <writev+0x3cee98>
  20a95b:      	leaq	-0x1(%rbp), %r11
  20a95f:      	movq	0x48(%rsp), %rcx
  20a964:      	movq	0x18(%rsp), %rax
  20a969:      	subl	%ebp, %eax
  20a96b:      	movq	0x40(%rsp), %rbp
  20a970:      	shll	$0x3, %eax
  20a973:      	andl	$0x38, %eax
  20a976:      	addq	%r13, %rcx
  20a979:      	nopl	(%rax)
  20a980:      	shrxq	%rax, (%r13), %rdx
  20a986:      	movzbl	%dl, %edi
  20a989:      	cmpq	%rbx, %rdi
  20a98c:      	jae	0x20abb9 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7e9>
  20a992:      	shrxq	%rax, 0x10(%r13), %rdx
  20a998:      	shrxq	%rax, 0x20(%r13), %rsi
  20a99e:      	shrxq	%rax, 0x30(%r13), %r8
  20a9a4:      	movzbl	%dl, %r9d
  20a9a8:      	movq	(%r12,%rdi,8), %rdx
  20a9ac:      	leaq	0x1(%rdx), %r10
  20a9b0:      	movq	%r10, (%r12,%rdi,8)
  20a9b4:      	cmpq	%rbx, %r9
  20a9b7:      	jae	0x20abb6 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7e6>
  20a9bd:      	movzbl	%sil, %edi
  20a9c1:      	movq	(%r12,%r9,8), %rsi
  20a9c5:      	leaq	0x1(%rsi), %r10
  20a9c9:      	movq	%r10, (%r12,%r9,8)
  20a9cd:      	cmpq	%rbx, %rdi
  20a9d0:      	jae	0x20abb9 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7e9>
  20a9d6:      	movzbl	%r8b, %r9d
  20a9da:      	movq	(%r12,%rdi,8), %r8
  20a9de:      	leaq	0x1(%r8), %r10
  20a9e2:      	movq	%r10, (%r12,%rdi,8)
  20a9e6:      	cmpq	%rbx, %r9
  20a9e9:      	jae	0x20abb6 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7e6>
  20a9ef:      	movq	(%r12,%r9,8), %rdi
  20a9f3:      	leaq	0x1(%rdi), %r10
  20a9f7:      	movq	%r10, (%r12,%r9,8)
  20a9fb:      	cmpq	%r14, %rdx
  20a9fe:      	jae	0x20abcc <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7fc>
  20aa04:      	vmovdqu	(%r13), %xmm0
  20aa0a:      	shlq	$0x4, %rdx
  20aa0e:      	vmovdqu	%xmm0, (%r15,%rdx)
  20aa14:      	cmpq	%r14, %rsi
  20aa17:      	jae	0x20abc7 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7f7>
  20aa1d:      	vmovdqu	0x10(%r13), %xmm0
  20aa23:      	shlq	$0x4, %rsi
  20aa27:      	vmovdqu	%xmm0, (%r15,%rsi)
  20aa2d:      	cmpq	%r14, %r8
  20aa30:      	jae	0x20abc2 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7f2>
  20aa36:      	vmovdqu	0x20(%r13), %xmm0
  20aa3c:      	shlq	$0x4, %r8
  20aa40:      	vmovdqu	%xmm0, (%r15,%r8)
  20aa46:      	cmpq	%r14, %rdi
  20aa49:      	jae	0x20abcf <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7ff>
  20aa4f:      	vmovdqu	0x30(%r13), %xmm0
  20aa55:      	shlq	$0x4, %rdi
  20aa59:      	addq	$0x40, %r13
  20aa5d:      	vmovdqu	%xmm0, (%r15,%rdi)
  20aa63:      	cmpq	%rcx, %r13
  20aa66:      	jne	0x20a980 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x5b0>
  20aa6c:      	movq	0x38(%rsp), %r13
  20aa71:      	testq	%rbp, %rbp
  20aa74:      	je	0x20aac3 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x6f3>
  20aa76:      	xorl	%edx, %edx
  20aa78:      	nopl	(%rax,%rax)
  20aa80:      	shrxq	%rax, (%rcx,%rdx), %rsi
  20aa86:      	movzbl	%sil, %edi
  20aa8a:      	cmpq	%rbx, %rdi
  20aa8d:      	jae	0x20abf3 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x823>
  20aa93:      	movq	(%r12,%rdi,8), %rsi
  20aa97:      	leaq	0x1(%rsi), %r8
  20aa9b:      	movq	%r8, (%r12,%rdi,8)
  20aa9f:      	cmpq	%r14, %rsi
  20aaa2:      	jae	0x20abe4 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x814>
  20aaa8:      	leaq	(%rcx,%rdx), %rdi
  20aaac:      	shlq	$0x4, %rsi
  20aab0:      	addq	$0x10, %rdx
  20aab4:      	vmovdqu	(%rdi), %xmm0
  20aab8:      	vmovdqu	%xmm0, (%r15,%rsi)
  20aabe:      	cmpq	%rdx, %rbp
  20aac1:      	jne	0x20aa80 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x6b0>
  20aac3:      	movq	0x20(%rsp), %rcx
  20aac8:      	movq	0x28(%rsp), %r15
  20aacd:      	movq	0x58(%rsp), %rbx
  20aad2:      	testq	%rcx, %rcx
  20aad5:      	je	0x20a82e <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x45e>
  20aadb:      	movzbl	0x1c67f6(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20aae2:      	testb	%al, %al
  20aae4:      	je	0x20a820 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x450>
  20aaea:      	shlq	$0x3, %rcx
  20aaee:      	lock
  20aaef:      	subq	%rcx, 0x1c67d2(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20aaf6:      	jmp	0x20a820 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x450>
  20aafb:      	testl	%ebx, %ebx
  20aafd:      	je	0x20ab11 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x741>
  20aaff:      	movq	(%rsp), %rsi
  20ab03:      	movq	0x10(%rsp), %rdx
  20ab08:      	movq	%r12, %rdi
  20ab0b:      	callq	*0x1c43d7(%rip)         # 0x3ceee8 <writev+0x3ceee8>
  20ab11:      	leaq	0x8(%r15), %rbx
  20ab15:      	jmp	0x20ab2f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x75f>
  20ab17:      	nopw	(%rax,%rax)
  20ab20:      	callq	*0x1c4372(%rip)         # 0x3cee98 <writev+0x3cee98>
  20ab26:      	addq	$0x18, %rbx
  20ab2a:      	decq	%r13
  20ab2d:      	je	0x20ab54 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x784>
  20ab2f:      	movq	-0x8(%rbx), %rax
  20ab33:      	testq	%rax, %rax
  20ab36:      	je	0x20ab26 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x756>
  20ab38:      	movq	(%rbx), %rdi
  20ab3b:      	movzbl	0x1c6796(%rip), %ecx    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20ab42:      	testb	%cl, %cl
  20ab44:      	je	0x20ab20 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x750>
  20ab46:      	shlq	$0x3, %rax
  20ab4a:      	lock
  20ab4b:      	subq	%rax, 0x1c6776(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20ab52:      	jmp	0x20ab20 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x750>
  20ab54:      	movq	0x60(%rsp), %rax
  20ab59:      	testq	%rax, %rax
  20ab5c:      	je	0x20ab82 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7b2>
  20ab5e:      	movzbl	0x1c6773(%rip), %ecx    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20ab65:      	testb	%cl, %cl
  20ab67:      	je	0x20ab79 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7a9>
  20ab69:      	shlq	$0x3, %rax
  20ab6d:      	leaq	(%rax,%rax,2), %rax
  20ab71:      	lock
  20ab72:      	subq	%rax, 0x1c674f(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20ab79:      	movq	%r15, %rdi
  20ab7c:      	callq	*0x1c4316(%rip)         # 0x3cee98 <writev+0x3cee98>
  20ab82:      	movzbl	0x1c674f(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20ab89:      	testb	%al, %al
  20ab8b:      	je	0x20ab9a <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7ca>
  20ab8d:      	movq	0x10(%rsp), %rax
  20ab92:      	lock
  20ab93:      	subq	%rax, 0x1c672e(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20ab9a:      	movq	(%rsp), %rdi
  20ab9e:      	callq	*0x1c42f4(%rip)         # 0x3cee98 <writev+0x3cee98>
  20aba4:      	addq	$0xe8, %rsp
  20abab:      	popq	%rbx
  20abac:      	popq	%r12
  20abae:      	popq	%r13
  20abb0:      	popq	%r14
  20abb2:      	popq	%r15
  20abb4:      	popq	%rbp
  20abb5:      	retq
  20abb6:      	movq	%r9, %rdi
  20abb9:      	leaq	0x1bfa20(%rip), %rdx    # 0x3ca5e0 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0x90>
  20abc0:      	jmp	0x20abd9 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x809>
  20abc2:      	movq	%r8, %rdi
  20abc5:      	jmp	0x20abcf <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7ff>
  20abc7:      	movq	%rsi, %rdi
  20abca:      	jmp	0x20abcf <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7ff>
  20abcc:      	movq	%rdx, %rdi
  20abcf:      	movq	%r14, %rbx
  20abd2:      	leaq	0x1bfa1f(%rip), %rdx    # 0x3ca5f8 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0xa8>
  20abd9:      	movq	%rbx, %rsi
  20abdc:      	callq	*0x1c42d6(%rip)         # 0x3ceeb8 <writev+0x3ceeb8>
  20abe2:      	jmp	0x20ac0f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x83f>
  20abe4:      	movq	%rsi, %rdi
  20abe7:      	movq	%r14, %rbx
  20abea:      	leaq	0x1bfa67(%rip), %rdx    # 0x3ca658 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0x108>
  20abf1:      	jmp	0x20abd9 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x809>
  20abf3:      	leaq	0x1bfa46(%rip), %rdx    # 0x3ca640 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0xf0>
  20abfa:      	jmp	0x20abd9 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x809>
  20abfc:      	leaq	0x1bfafd(%rip), %rdx    # 0x3ca700 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0x1b0>
  20ac03:      	movq	%r11, %rdi
  20ac06:      	movq	%r13, %rsi
  20ac09:      	callq	*0x1c42a9(%rip)         # 0x3ceeb8 <writev+0x3ceeb8>
  20ac0f:      	ud2
  20ac11:      	movq	0x10(%rsp), %rsi
  20ac16:      	movl	$0x8, %edi
  20ac1b:      	callq	*0x1c427f(%rip)         # 0x3ceea0 <writev+0x3ceea0>
  20ac21:      	leaq	0x78(%rsp), %rdx
  20ac26:      	movq	%r12, %rdi
  20ac29:      	movq	%r14, %rsi
  20ac2c:      	callq	0x32cd00 <_RINvNtNtNtCs3sPX1WnuliO_4core5slice4sort8unstable7ipnsortINtCs9j6qJjDxNX3_15block_lsd_bench6RecordyKj2_ENCINvMB6_SBT_16sort_unstable_byNCINvNtNtBW_6shared4core4sortBT_yKj4_E0E0EBW_>
  20ac31:      	jmp	0x20aba4 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x7d4>
  20ac36:      	movq	%rax, %rbx
  20ac39:      	jmp	0x20ac79 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x8a9>
  20ac3b:      	jmp	0x20ac3d <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x86d>
  20ac3d:      	movq	%rax, %rbx
  20ac40:      	jmp	0x20ac6f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x89f>
  20ac42:      	movq	0x20(%rsp), %rcx
  20ac47:      	movq	%rax, %rbx
  20ac4a:      	testq	%rcx, %rcx
  20ac4d:      	je	0x20ac6f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x89f>
  20ac4f:      	movzbl	0x1c6682(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20ac56:      	testb	%al, %al
  20ac58:      	je	0x20ac66 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x896>
  20ac5a:      	shlq	$0x3, %rcx
  20ac5e:      	lock
  20ac5f:      	subq	%rcx, 0x1c6662(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20ac66:      	movq	%r12, %rdi
  20ac69:      	callq	*0x1c4229(%rip)         # 0x3cee98 <writev+0x3cee98>
  20ac6f:      	leaq	0x60(%rsp), %rdi
  20ac74:      	callq	0x1ec8a0 <_RINvNtCs3sPX1WnuliO_4core3ptr9drop_glueINtNtCs5xahNnzoIEW_5alloc3vec3VecIBC_jEEECs9j6qJjDxNX3_15block_lsd_bench>
  20ac79:      	movzbl	0x1c6658(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20ac80:      	testb	%al, %al
  20ac82:      	je	0x20ac91 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj4_EB6_+0x8c1>
  20ac84:      	movq	0x10(%rsp), %rax
  20ac89:      	lock
  20ac8a:      	subq	%rax, 0x1c6637(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20ac91:      	movq	(%rsp), %rdi
  20ac95:      	callq	*0x1c41fd(%rip)         # 0x3cee98 <writev+0x3cee98>
  20ac9b:      	movq	%rbx, %rdi
  20ac9e:      	callq	0x3b9430 <_Unwind_Resume@plt>

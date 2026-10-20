
tools/block_lsd_bench/target/release/block_lsd_bench:	file format elf64-x86-64

Disassembly of section .text:

00000000002c47c0 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_>:
  2c47c0:      	pushq	%rbp
  2c47c1:      	pushq	%r15
  2c47c3:      	pushq	%r14
  2c47c5:      	pushq	%r13
  2c47c7:      	pushq	%r12
  2c47c9:      	pushq	%rbx
  2c47ca:      	subq	$0xf8, %rsp
  2c47d1:      	leaq	0xd0(%rsp), %r15
  2c47d9:      	movq	%rcx, %rbx
  2c47dc:      	movq	%r8, 0x50(%rsp)
  2c47e1:      	movq	%rdx, %rbp
  2c47e4:      	movl	%ebp, %r13d
  2c47e7:      	movq	%rsi, %r12
  2c47ea:      	movq	%rdi, %r14
  2c47ed:      	movq	%r9, 0x40(%rsp)
  2c47f2:      	andl	$0x3f, %r13d
  2c47f6:      	movq	$0x0, 0x8(%rsp)
  2c47ff:      	xorl	%esi, %esi
  2c4801:      	xorl	%ecx, %ecx
  2c4803:      	movq	%rbx, %r8
  2c4806:      	movq	%r15, %rdi
  2c4809:      	callq	*0x10c8c1(%rip)         # 0x3d10d0 <writev+0x3d10d0>
  2c480f:      	leaq	0x98(%rsp), %rdi
  2c4817:      	movq	%r14, %rsi
  2c481a:      	movq	%r12, %rdx
  2c481d:      	movq	%r15, %rcx
  2c4820:      	callq	0xcc2d0 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts5utils19get_full_histogramsINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1g_>
  2c4825:      	movl	$0x8, %eax
  2c482a:      	cmpq	$0x3d, %r13
  2c482e:      	movabsq	$0x7ffffffffffffff8, %rcx # imm = 0x7FFFFFFFFFFFFFF8
  2c4838:      	shlxq	%r13, %rax, %rsi
  2c483d:      	setae	%al
  2c4840:      	cmpq	%rcx, %rsi
  2c4843:      	seta	%cl
  2c4846:      	orb	%al, %cl
  2c4848:      	je	0x2c485a <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x9a>
  2c484a:      	movq	0x8(%rsp), %rdi
  2c484f:      	callq	*0x10c7ab(%rip)         # 0x3d1000 <writev+0x3d1000>
  2c4855:      	jmp	0x2c5073 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x8b3>
  2c485a:      	movq	%r14, %r15
  2c485d:      	movq	%r12, 0x8(%rsp)
  2c4862:      	movq	%rbx, 0x48(%rsp)
  2c4867:      	movq	%rsi, %r14
  2c486a:      	callq	*0x10c798(%rip)         # 0x3d1008 <writev+0x3d1008>
  2c4870:      	movl	$0x1, %esi
  2c4875:      	movq	%r14, %rdi
  2c4878:      	movq	%r14, 0x10(%rsp)
  2c487d:      	callq	*0x10c78d(%rip)         # 0x3d1010 <writev+0x3d1010>
  2c4883:      	testq	%rax, %rax
  2c4886:      	je	0x2c503f <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x87f>
  2c488c:      	movzbl	0x10eba5(%rip), %ecx    # 0x3d3438 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  2c4893:      	movq	%rax, %r14
  2c4896:      	movl	$0x1, %eax
  2c489b:      	shlxq	%r13, %rax, %r13
  2c48a0:      	testb	%cl, %cl
  2c48a2:      	je	0x2c48d5 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x115>
  2c48a4:      	movq	0x10(%rsp), %rax
  2c48a9:      	movq	%rax, %rcx
  2c48ac:      	lock
  2c48ad:      	xaddq	%rcx, 0x10eb73(%rip)    # 0x3d3428 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  2c48b5:      	addq	%rax, %rcx
  2c48b8:      	movq	0x10eb71(%rip), %rax    # 0x3d3430 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4PEAK.llvm.13354737551727885710>
  2c48bf:      	nop
  2c48c0:      	cmpq	%rcx, %rax
  2c48c3:      	movq	%rcx, %rdx
  2c48c6:      	cmovaq	%rax, %rdx
  2c48ca:      	lock
  2c48cb:      	cmpxchgq	%rdx, 0x10eb5d(%rip)    # 0x3d3430 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4PEAK.llvm.13354737551727885710>
  2c48d3:      	jne	0x2c48c0 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x100>
  2c48d5:      	movq	%r13, 0xb8(%rsp)
  2c48dd:      	movq	%r14, 0xc0(%rsp)
  2c48e5:      	movq	%r13, 0xc8(%rsp)
  2c48ed:      	callq	*0x10c715(%rip)         # 0x3d1008 <writev+0x3d1008>
  2c48f3:      	movq	0x10(%rsp), %rdi
  2c48f8:      	movl	$0x1, %esi
  2c48fd:      	callq	*0x10c70d(%rip)         # 0x3d1010 <writev+0x3d1010>
  2c4903:      	movq	%rax, 0x18(%rsp)
  2c4908:      	testq	%rax, %rax
  2c490b:      	je	0x2c5053 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x893>
  2c4911:      	movq	%r15, 0x60(%rsp)
  2c4916:      	movzbl	0x10eb1b(%rip), %eax    # 0x3d3438 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  2c491d:      	testb	%al, %al
  2c491f:      	je	0x2c4955 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x195>
  2c4921:      	movq	0x10(%rsp), %rax
  2c4926:      	movq	%rax, %rcx
  2c4929:      	lock
  2c492a:      	xaddq	%rcx, 0x10eaf6(%rip)    # 0x3d3428 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  2c4932:      	addq	%rax, %rcx
  2c4935:      	movq	0x10eaf4(%rip), %rax    # 0x3d3430 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4PEAK.llvm.13354737551727885710>
  2c493c:      	nopl	(%rax)
  2c4940:      	cmpq	%rcx, %rax
  2c4943:      	movq	%rcx, %rdx
  2c4946:      	cmovaq	%rax, %rdx
  2c494a:      	lock
  2c494b:      	cmpxchgq	%rdx, 0x10eadd(%rip)    # 0x3d3430 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4PEAK.llvm.13354737551727885710>
  2c4953:      	jne	0x2c4940 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x180>
  2c4955:      	movq	0x8(%rsp), %r12
  2c495a:      	movq	0x18(%rsp), %rax
  2c495f:      	movq	%r13, 0xd0(%rsp)
  2c4967:      	movq	%rax, 0xd8(%rsp)
  2c496f:      	movq	%r13, 0xe0(%rsp)
  2c4977:      	shlq	$0x5, %r12
  2c497b:      	callq	*0x10c687(%rip)         # 0x3d1008 <writev+0x3d1008>
  2c4981:      	movq	%r12, %rdi
  2c4984:      	callq	*0x10c6ae(%rip)         # 0x3d1038 <writev+0x3d1038>
  2c498a:      	movq	%rax, 0x30(%rsp)
  2c498f:      	testq	%rax, %rax
  2c4992:      	je	0x2c5065 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x8a5>
  2c4998:      	movq	0x138(%rsp), %rax
  2c49a0:      	movq	%rax, 0x80(%rsp)
  2c49a8:      	movq	0x130(%rsp), %rax
  2c49b0:      	movq	%rax, 0x78(%rsp)
  2c49b5:      	movzbl	0x10ea7c(%rip), %eax    # 0x3d3438 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  2c49bc:      	movq	0x48(%rsp), %rsi
  2c49c1:      	movq	0x40(%rsp), %r15
  2c49c6:      	movq	0x50(%rsp), %rdi
  2c49cb:      	testb	%al, %al
  2c49cd:      	je	0x2c4a05 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x245>
  2c49cf:      	movq	%r12, %rcx
  2c49d2:      	lock
  2c49d3:      	xaddq	%rcx, 0x10ea4d(%rip)    # 0x3d3428 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  2c49db:      	movq	0x10ea4e(%rip), %rax    # 0x3d3430 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4PEAK.llvm.13354737551727885710>
  2c49e2:      	addq	%r12, %rcx
  2c49e5:      	nopw	%cs:(%rax,%rax)
  2c49f0:      	cmpq	%rcx, %rax
  2c49f3:      	movq	%rcx, %rdx
  2c49f6:      	cmovaq	%rax, %rdx
  2c49fa:      	lock
  2c49fb:      	cmpxchgq	%rdx, 0x10ea2d(%rip)    # 0x3d3430 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4PEAK.llvm.13354737551727885710>
  2c4a03:      	jne	0x2c49f0 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x230>
  2c4a05:      	movq	0x8(%rsp), %rax
  2c4a0a:      	xorq	%rdi, 0x78(%rsp)
  2c4a0f:      	movq	0xa0(%rsp), %r9
  2c4a17:      	movq	0xa8(%rsp), %rdi
  2c4a1f:      	xorq	%r15, 0x80(%rsp)
  2c4a27:      	movabsq	$0x3fffffffffffffc, %rdx # imm = 0x3FFFFFFFFFFFFFC
  2c4a31:      	movl	%r12d, %ecx
  2c4a34:      	andl	$0x60, %ecx
  2c4a37:      	xorl	%r8d, %r8d
  2c4a3a:      	movq	$0x0, 0x38(%rsp)
  2c4a43:      	movq	%rcx, 0x40(%rsp)
  2c4a48:      	andq	%rax, %rdx
  2c4a4b:      	shrq	$0x2, %rax
  2c4a4f:      	movq	%r9, 0x68(%rsp)
  2c4a54:      	movq	%rdi, 0x28(%rsp)
  2c4a59:      	shlq	$0x7, %rax
  2c4a5d:      	shlq	$0x5, %rdx
  2c4a61:      	movq	%rax, 0x50(%rsp)
  2c4a66:      	leaq	0x108603(%rip), %rax    # 0x3cd070 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14653853073152682216+0xa20>
  2c4a6d:      	movq	%rdx, 0xb0(%rsp)
  2c4a75:      	movq	%rax, 0x58(%rsp)
  2c4a7a:      	movq	%rbp, %rax
  2c4a7d:      	imulq	%r8, %rax
  2c4a81:      	movl	$0x80, %r9d
  2c4a87:      	xorl	%r10d, %r10d
  2c4a8a:      	movq	%r8, %rdi
  2c4a8d:      	subq	%rax, %r9
  2c4a90:      	cmpq	%r9, %rbp
  2c4a93:      	leaq	(%r8,%r10), %rcx
  2c4a97:      	movq	%r9, %rax
  2c4a9a:      	movl	$0x80, %r11d
  2c4aa0:      	movl	$0x80, %edx
  2c4aa5:      	cmovbq	%rbp, %rax
  2c4aa9:      	imulq	%rbp, %rcx
  2c4aad:      	subq	%rcx, %r11
  2c4ab0:      	movq	%rdi, %rcx
  2c4ab3:      	cmpq	%r11, %rbp
  2c4ab6:      	cmovbq	%rbp, %r11
  2c4aba:      	imulq	%rbp, %rcx
  2c4abe:      	subq	%rcx, %rdx
  2c4ac1:      	cmpq	%rbp, %rdx
  2c4ac4:      	cmovaeq	%rbp, %rdx
  2c4ac8:      	testq	%rdx, %rdx
  2c4acb:      	je	0x2c4ae0 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x320>
  2c4acd:      	leaq	-0x1(%r11), %rdx
  2c4ad1:      	cmpq	$0x7, %rdx
  2c4ad5:      	jae	0x2c4af0 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x330>
  2c4ad7:      	xorl	%edx, %edx
  2c4ad9:      	jmp	0x2c4b17 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x357>
  2c4adb:      	nopl	(%rax,%rax)
  2c4ae0:      	xorl	%edx, %edx
  2c4ae2:      	jmp	0x2c4b2a <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x36a>
  2c4ae4:      	nopw	%cs:(%rax,%rax)
  2c4af0:      	movq	%rax, %rbx
  2c4af3:      	andq	$-0x8, %rbx
  2c4af7:      	xorl	%edx, %edx
  2c4af9:      	nopl	(%rax)
  2c4b00:      	shlq	$0x8, %rdx
  2c4b04:      	orq	$0xff, %rdx
  2c4b0b:      	addq	$-0x8, %rbx
  2c4b0f:      	jne	0x2c4b00 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x340>
  2c4b11:      	testb	$0x7, %r11b
  2c4b15:      	je	0x2c4b2a <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x36a>
  2c4b17:      	andl	$0x7, %eax
  2c4b1a:      	negq	%rax
  2c4b1d:      	nopl	(%rax)
  2c4b20:      	leaq	0x1(%rdx,%rdx), %rdx
  2c4b25:      	incq	%rax
  2c4b28:      	jne	0x2c4b20 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x360>
  2c4b2a:      	andl	$0x7f, %ecx
  2c4b2d:      	xorl	%eax, %eax
  2c4b2f:      	movl	$0x0, %r11d
  2c4b35:      	leaq	0x1(%rdi), %r15
  2c4b39:      	shldq	%cl, %rdx, %rax
  2c4b3d:      	shlxq	%rcx, %rdx, %rdx
  2c4b42:      	testb	$0x40, %cl
  2c4b45:      	cmovneq	%rdx, %rax
  2c4b49:      	cmovneq	%r11, %rdx
  2c4b4d:      	movq	%rax, %r11
  2c4b50:      	movq	%rdx, %rbx
  2c4b53:      	andq	0x80(%rsp), %r11
  2c4b5b:      	andq	0x78(%rsp), %rbx
  2c4b60:      	orq	%r11, %rbx
  2c4b63:      	jne	0x2c4b80 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x3c0>
  2c4b65:      	incq	%r10
  2c4b68:      	subq	%rbp, %r9
  2c4b6b:      	movq	%r15, %rdi
  2c4b6e:      	cmpq	%rsi, %r15
  2c4b71:      	jne	0x2c4a90 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x2d0>
  2c4b77:      	jmp	0x2c4e65 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x6a5>
  2c4b7c:      	nopl	(%rax)
  2c4b80:      	notq	%rdi
  2c4b83:      	addq	0x48(%rsp), %rdi
  2c4b88:      	movq	$0x0, 0x88(%rsp)
  2c4b94:      	cmpq	0x28(%rsp), %rdi
  2c4b99:      	jae	0x2c502d <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x86d>
  2c4b9f:      	movq	0x68(%rsp), %r8
  2c4ba4:      	leaq	(%rdi,%rdi,2), %rdi
  2c4ba8:      	movq	0x10(%r8,%rdi,8), %rsi
  2c4bad:      	testq	%rsi, %rsi
  2c4bb0:      	je	0x2c4f9a <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x7da>
  2c4bb6:      	movq	0x8(%r8,%rdi,8), %rdi
  2c4bbb:      	shlq	$0x3, %rsi
  2c4bbf:      	xorl	%r10d, %r10d
  2c4bc2:      	xorl	%r8d, %r8d
  2c4bc5:      	nopw	%cs:(%rax,%rax)
  2c4bd0:      	cmpq	%r8, %r13
  2c4bd3:      	je	0x2c5019 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x859>
  2c4bd9:      	movq	(%rdi,%r8,8), %r9
  2c4bdd:      	movq	0x18(%rsp), %r11
  2c4be2:      	movq	%r10, (%r14,%r8,8)
  2c4be6:      	addq	%r10, %r9
  2c4be9:      	addq	$-0x8, %rsi
  2c4bed:      	movq	%r9, (%r11,%r8,8)
  2c4bf1:      	leaq	0x1(%r8), %r8
  2c4bf5:      	movq	%r9, %r10
  2c4bf8:      	movq	%r9, 0x88(%rsp)
  2c4c00:      	jne	0x2c4bd0 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x410>
  2c4c02:      	movq	0x8(%rsp), %rsi
  2c4c07:      	movq	%rsi, 0x90(%rsp)
  2c4c0f:      	cmpq	%rsi, %r9
  2c4c12:      	jne	0x2c4fa7 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x7e7>
  2c4c18:      	movq	0x60(%rsp), %rdi
  2c4c1d:      	testb	$0x1, 0x38(%rsp)
  2c4c22:      	movq	0x30(%rsp), %rsi
  2c4c27:      	movq	%r12, 0x20(%rsp)
  2c4c2c:      	movq	0x8(%rsp), %r12
  2c4c31:      	movq	%rdi, %r9
  2c4c34:      	cmovneq	%rsi, %r9
  2c4c38:      	cmovneq	%rdi, %rsi
  2c4c3c:      	movq	0xb0(%rsp), %rdi
  2c4c44:      	xorl	%r10d, %r10d
  2c4c47:      	addq	%r9, %rdi
  2c4c4a:      	movq	%rdi, 0x70(%rsp)
  2c4c4f:      	nop
  2c4c50:      	movq	(%r9,%r10), %r11
  2c4c54:      	movq	0x8(%r9,%r10), %rdi
  2c4c59:      	andq	%rdx, %r11
  2c4c5c:      	andq	%rax, %rdi
  2c4c5f:      	shrdq	%cl, %rdi, %r11
  2c4c63:      	shrxq	%rcx, %rdi, %rdi
  2c4c68:      	testb	$0x40, %cl
  2c4c6b:      	cmoveq	%r11, %rdi
  2c4c6f:      	cmpq	%rdi, %r13
  2c4c72:      	jbe	0x2c4fff <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x83f>
  2c4c78:      	movq	(%r14,%rdi,8), %rbx
  2c4c7c:      	cmpq	%r12, %rbx
  2c4c7f:      	jae	0x2c4f74 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x7b4>
  2c4c85:      	leaq	(%r9,%r10), %r11
  2c4c89:      	movq	%rbx, %r12
  2c4c8c:      	shlq	$0x5, %r12
  2c4c90:      	incq	%rbx
  2c4c93:      	vmovups	(%r11), %ymm0
  2c4c98:      	movq	%rbx, (%r14,%rdi,8)
  2c4c9c:      	vmovups	%ymm0, (%rsi,%r12)
  2c4ca2:      	movq	0x28(%r11), %r12
  2c4ca6:      	movq	0x20(%r11), %r8
  2c4caa:      	andq	%rax, %r12
  2c4cad:      	andq	%rdx, %r8
  2c4cb0:      	shrdq	%cl, %r12, %r8
  2c4cb4:      	shrxq	%rcx, %r12, %rdi
  2c4cb9:      	testb	$0x40, %cl
  2c4cbc:      	cmoveq	%r8, %rdi
  2c4cc0:      	cmpq	%rdi, %r13
  2c4cc3:      	jbe	0x2c4fff <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x83f>
  2c4cc9:      	movq	(%r14,%rdi,8), %rbx
  2c4ccd:      	cmpq	0x8(%rsp), %rbx
  2c4cd2:      	jae	0x2c4f74 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x7b4>
  2c4cd8:      	vmovups	0x20(%r11), %ymm0
  2c4cde:      	movq	%rbx, %r8
  2c4ce1:      	shlq	$0x5, %r8
  2c4ce5:      	incq	%rbx
  2c4ce8:      	movq	%rbx, (%r14,%rdi,8)
  2c4cec:      	vmovups	%ymm0, (%rsi,%r8)
  2c4cf2:      	movq	0x48(%r11), %r8
  2c4cf6:      	movq	0x40(%r11), %r12
  2c4cfa:      	andq	%rax, %r8
  2c4cfd:      	andq	%rdx, %r12
  2c4d00:      	shrdq	%cl, %r8, %r12
  2c4d04:      	shrxq	%rcx, %r8, %rdi
  2c4d09:      	testb	$0x40, %cl
  2c4d0c:      	cmoveq	%r12, %rdi
  2c4d10:      	cmpq	%rdi, %r13
  2c4d13:      	jbe	0x2c4fff <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x83f>
  2c4d19:      	movq	(%r14,%rdi,8), %rbx
  2c4d1d:      	cmpq	0x8(%rsp), %rbx
  2c4d22:      	jae	0x2c4f74 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x7b4>
  2c4d28:      	vmovups	0x40(%r11), %ymm0
  2c4d2e:      	movq	%rbx, %r8
  2c4d31:      	shlq	$0x5, %r8
  2c4d35:      	incq	%rbx
  2c4d38:      	movq	%rbx, (%r14,%rdi,8)
  2c4d3c:      	vmovups	%ymm0, (%rsi,%r8)
  2c4d42:      	movq	0x68(%r11), %r8
  2c4d46:      	movq	0x60(%r11), %r12
  2c4d4a:      	andq	%rax, %r8
  2c4d4d:      	andq	%rdx, %r12
  2c4d50:      	shrdq	%cl, %r8, %r12
  2c4d54:      	shrxq	%rcx, %r8, %rdi
  2c4d59:      	testb	$0x40, %cl
  2c4d5c:      	cmoveq	%r12, %rdi
  2c4d60:      	cmpq	%rdi, %r13
  2c4d63:      	jbe	0x2c4fff <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x83f>
  2c4d69:      	movq	(%r14,%rdi,8), %rbx
  2c4d6d:      	movq	0x8(%rsp), %r12
  2c4d72:      	cmpq	%r12, %rbx
  2c4d75:      	jae	0x2c4f74 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x7b4>
  2c4d7b:      	vmovups	0x60(%r11), %ymm0
  2c4d81:      	movq	%rbx, %r8
  2c4d84:      	shlq	$0x5, %r8
  2c4d88:      	incq	%rbx
  2c4d8b:      	subq	$-0x80, %r10
  2c4d8f:      	movq	%rbx, (%r14,%rdi,8)
  2c4d93:      	vmovups	%ymm0, (%rsi,%r8)
  2c4d99:      	cmpq	%r10, 0x50(%rsp)
  2c4d9e:      	jne	0x2c4c50 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x490>
  2c4da4:      	cmpq	$0x0, 0x40(%rsp)
  2c4daa:      	movq	0x70(%rsp), %r8
  2c4daf:      	je	0x2c4e21 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x661>
  2c4db1:      	xorl	%r9d, %r9d
  2c4db4:      	nopw	%cs:(%rax,%rax)
  2c4dc0:      	movq	(%r8,%r9), %r10
  2c4dc4:      	movq	0x8(%r8,%r9), %rdi
  2c4dc9:      	andq	%rdx, %r10
  2c4dcc:      	andq	%rax, %rdi
  2c4dcf:      	shrdq	%cl, %rdi, %r10
  2c4dd3:      	shrxq	%rcx, %rdi, %rdi
  2c4dd8:      	testb	$0x40, %cl
  2c4ddb:      	cmoveq	%r10, %rdi
  2c4ddf:      	cmpq	%rdi, %r13
  2c4de2:      	jbe	0x2c4fff <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x83f>
  2c4de8:      	movq	(%r14,%rdi,8), %r10
  2c4dec:      	cmpq	%r12, %r10
  2c4def:      	jae	0x2c4f74 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x7b4>
  2c4df5:      	movq	0x70(%rsp), %r8
  2c4dfa:      	movq	%r10, %rbx
  2c4dfd:      	incq	%r10
  2c4e00:      	shlq	$0x5, %rbx
  2c4e04:      	movq	%r10, (%r14,%rdi,8)
  2c4e08:      	leaq	(%r8,%r9), %r11
  2c4e0c:      	addq	$0x20, %r9
  2c4e10:      	vmovups	(%r11), %ymm0
  2c4e15:      	vmovups	%ymm0, (%rsi,%rbx)
  2c4e1a:      	cmpq	%r9, 0x40(%rsp)
  2c4e1f:      	jne	0x2c4dc0 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x600>
  2c4e21:      	movq	0x18(%rsp), %rsi
  2c4e26:      	movq	0x10(%rsp), %rdx
  2c4e2b:      	movq	%r14, %rdi
  2c4e2e:      	vzeroupper
  2c4e31:      	callq	*0x10c261(%rip)         # 0x3d1098 <writev+0x3d1098>
  2c4e37:      	testl	%eax, %eax
  2c4e39:      	jne	0x2c4fcd <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x80d>
  2c4e3f:      	movq	0x38(%rsp), %rax
  2c4e44:      	movq	0x48(%rsp), %rsi
  2c4e49:      	movq	0x20(%rsp), %r12
  2c4e4e:      	movq	%r15, %r8
  2c4e51:      	xorb	$0x1, %al
  2c4e53:      	movq	%rax, 0x38(%rsp)
  2c4e58:      	cmpq	%rsi, %r15
  2c4e5b:      	cmovaq	%r15, %rsi
  2c4e5f:      	jb	0x2c4a7a <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x2ba>
  2c4e65:      	testb	$0x1, 0x38(%rsp)
  2c4e6a:      	je	0x2c4e7f <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x6bf>
  2c4e6c:      	movq	0x60(%rsp), %rdi
  2c4e71:      	movq	0x30(%rsp), %rsi
  2c4e76:      	movq	%r12, %rdx
  2c4e79:      	callq	*0x10c1c9(%rip)         # 0x3d1048 <writev+0x3d1048>
  2c4e7f:      	movzbl	0x10e5b2(%rip), %eax    # 0x3d3438 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  2c4e86:      	movq	0x28(%rsp), %r13
  2c4e8b:      	testb	%al, %al
  2c4e8d:      	je	0x2c4e97 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x6d7>
  2c4e8f:      	lock
  2c4e90:      	subq	%r12, 0x10e591(%rip)    # 0x3d3428 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  2c4e97:      	movq	0x30(%rsp), %rdi
  2c4e9c:      	callq	*0x10c156(%rip)         # 0x3d0ff8 <writev+0x3d0ff8>
  2c4ea2:      	movzbl	0x10e58f(%rip), %eax    # 0x3d3438 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  2c4ea9:      	testb	%al, %al
  2c4eab:      	je	0x2c4eba <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x6fa>
  2c4ead:      	movq	0x10(%rsp), %rax
  2c4eb2:      	lock
  2c4eb3:      	subq	%rax, 0x10e56e(%rip)    # 0x3d3428 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  2c4eba:      	movq	0x18(%rsp), %rdi
  2c4ebf:      	callq	*0x10c133(%rip)         # 0x3d0ff8 <writev+0x3d0ff8>
  2c4ec5:      	movzbl	0x10e56c(%rip), %eax    # 0x3d3438 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  2c4ecc:      	movq	0x68(%rsp), %rbx
  2c4ed1:      	testb	%al, %al
  2c4ed3:      	je	0x2c4ee2 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x722>
  2c4ed5:      	movq	0x10(%rsp), %rax
  2c4eda:      	lock
  2c4edb:      	subq	%rax, 0x10e546(%rip)    # 0x3d3428 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  2c4ee2:      	movq	%r14, %rdi
  2c4ee5:      	callq	*0x10c10d(%rip)         # 0x3d0ff8 <writev+0x3d0ff8>
  2c4eeb:      	testq	%r13, %r13
  2c4eee:      	je	0x2c4f31 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x771>
  2c4ef0:      	movq	0x10c101(%rip), %r15    # 0x3d0ff8 <writev+0x3d0ff8>
  2c4ef7:      	leaq	0x8(%rbx), %r14
  2c4efb:      	jmp	0x2c4f0c <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x74c>
  2c4efd:      	nopl	(%rax)
  2c4f00:      	callq	*%r15
  2c4f03:      	addq	$0x18, %r14
  2c4f07:      	decq	%r13
  2c4f0a:      	je	0x2c4f31 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x771>
  2c4f0c:      	movq	-0x8(%r14), %rax
  2c4f10:      	testq	%rax, %rax
  2c4f13:      	je	0x2c4f03 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x743>
  2c4f15:      	movq	(%r14), %rdi
  2c4f18:      	movzbl	0x10e519(%rip), %ecx    # 0x3d3438 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  2c4f1f:      	testb	%cl, %cl
  2c4f21:      	je	0x2c4f00 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x740>
  2c4f23:      	shlq	$0x3, %rax
  2c4f27:      	lock
  2c4f28:      	subq	%rax, 0x10e4f9(%rip)    # 0x3d3428 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  2c4f2f:      	jmp	0x2c4f00 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x740>
  2c4f31:      	movq	0x98(%rsp), %rax
  2c4f39:      	testq	%rax, %rax
  2c4f3c:      	je	0x2c4f62 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x7a2>
  2c4f3e:      	movzbl	0x10e4f3(%rip), %ecx    # 0x3d3438 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  2c4f45:      	testb	%cl, %cl
  2c4f47:      	je	0x2c4f59 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x799>
  2c4f49:      	shlq	$0x3, %rax
  2c4f4d:      	leaq	(%rax,%rax,2), %rax
  2c4f51:      	lock
  2c4f52:      	subq	%rax, 0x10e4cf(%rip)    # 0x3d3428 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  2c4f59:      	movq	%rbx, %rdi
  2c4f5c:      	callq	*0x10c096(%rip)         # 0x3d0ff8 <writev+0x3d0ff8>
  2c4f62:      	addq	$0xf8, %rsp
  2c4f69:      	popq	%rbx
  2c4f6a:      	popq	%r12
  2c4f6c:      	popq	%r13
  2c4f6e:      	popq	%r14
  2c4f70:      	popq	%r15
  2c4f72:      	popq	%rbp
  2c4f73:      	retq
  2c4f74:      	movq	0x20(%rsp), %r12
  2c4f79:      	leaq	-0x29b557(%rip), %rdi   # 0x29a29 <anon.c5862773a544a98ebfd42667029cfcec.1522.llvm.17443555614370274988+0x38a9>
  2c4f80:      	leaq	0x1081f1(%rip), %rdx    # 0x3cd178 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14653853073152682216+0xb28>
  2c4f87:      	movl	$0x1d, %esi
  2c4f8c:      	vzeroupper
  2c4f8f:      	callq	*0x10c09b(%rip)         # 0x3d1030 <writev+0x3d1030>
  2c4f95:      	jmp	0x2c5073 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x8b3>
  2c4f9a:      	movq	0x8(%rsp), %rax
  2c4f9f:      	movq	%rax, 0x90(%rsp)
  2c4fa7:      	leaq	0x1080da(%rip), %r9     # 0x3cd088 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14653853073152682216+0xa38>
  2c4fae:      	leaq	0x88(%rsp), %rsi
  2c4fb6:      	leaq	0x90(%rsp), %rdx
  2c4fbe:      	xorl	%edi, %edi
  2c4fc0:      	xorl	%ecx, %ecx
  2c4fc2:      	callq	*0x10c0d8(%rip)         # 0x3d10a0 <writev+0x3d10a0>
  2c4fc8:      	jmp	0x2c5073 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x8b3>
  2c4fcd:      	movq	0x20(%rsp), %r12
  2c4fd2:      	leaq	-0x29b5b0(%rip), %rcx   # 0x29a29 <anon.c5862773a544a98ebfd42667029cfcec.1522.llvm.17443555614370274988+0x38a9>
  2c4fd9:      	leaq	0x1080c0(%rip), %r9     # 0x3cd0a0 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14653853073152682216+0xa50>
  2c4fe0:      	leaq	0xb8(%rsp), %rsi
  2c4fe8:      	leaq	0xd0(%rsp), %rdx
  2c4ff0:      	movl	$0x3b, %r8d
  2c4ff6:      	xorl	%edi, %edi
  2c4ff8:      	callq	0x35c576 <_RINvNtCs3sPX1WnuliO_4core9panicking13assert_failedINtNtCs5xahNnzoIEW_5alloc3vec3VecjEBM_ECs9j6qJjDxNX3_15block_lsd_bench>
  2c4ffd:      	jmp	0x2c5073 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x8b3>
  2c4fff:      	movq	0x20(%rsp), %r12
  2c5004:      	leaq	0x108155(%rip), %rdx    # 0x3cd160 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14653853073152682216+0xb10>
  2c500b:      	movq	%r13, %rsi
  2c500e:      	vzeroupper
  2c5011:      	callq	*0x10c001(%rip)         # 0x3d1018 <writev+0x3d1018>
  2c5017:      	jmp	0x2c5073 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x8b3>
  2c5019:      	leaq	0x108098(%rip), %rax    # 0x3cd0b8 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14653853073152682216+0xa68>
  2c5020:      	movq	%r13, %rdi
  2c5023:      	movq	%r13, 0x28(%rsp)
  2c5028:      	movq	%rax, 0x58(%rsp)
  2c502d:      	movq	0x28(%rsp), %rsi
  2c5032:      	movq	0x58(%rsp), %rdx
  2c5037:      	callq	*0x10bfdb(%rip)         # 0x3d1018 <writev+0x3d1018>
  2c503d:      	jmp	0x2c5073 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x8b3>
  2c503f:      	movq	0x10(%rsp), %rsi
  2c5044:      	movl	$0x8, %eax
  2c5049:      	movq	%rax, 0x8(%rsp)
  2c504e:      	jmp	0x2c484a <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x8a>
  2c5053:      	movq	0x10(%rsp), %rsi
  2c5058:      	movl	$0x8, %edi
  2c505d:      	callq	*0x10bf9d(%rip)         # 0x3d1000 <writev+0x3d1000>
  2c5063:      	jmp	0x2c5073 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x8b3>
  2c5065:      	movl	$0x10, %edi
  2c506a:      	movq	%r12, %rsi
  2c506d:      	callq	*0x10bf8d(%rip)         # 0x3d1000 <writev+0x3d1000>
  2c5073:      	ud2
  2c5075:      	movq	%rax, %rbx
  2c5078:      	jmp	0x2c50a0 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x8e0>
  2c507a:      	movq	%rax, %rbx
  2c507d:      	jmp	0x2c50c3 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x903>
  2c507f:      	movzbl	0x10e3b2(%rip), %ecx    # 0x3d3438 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  2c5086:      	movq	%rax, %rbx
  2c5089:      	testb	%cl, %cl
  2c508b:      	je	0x2c5095 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x8d5>
  2c508d:      	lock
  2c508e:      	subq	%r12, 0x10e393(%rip)    # 0x3d3428 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  2c5095:      	movq	0x30(%rsp), %rdi
  2c509a:      	callq	*0x10bf58(%rip)         # 0x3d0ff8 <writev+0x3d0ff8>
  2c50a0:      	movzbl	0x10e391(%rip), %eax    # 0x3d3438 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  2c50a7:      	testb	%al, %al
  2c50a9:      	je	0x2c50b8 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x8f8>
  2c50ab:      	movq	0x10(%rsp), %rax
  2c50b0:      	lock
  2c50b1:      	subq	%rax, 0x10e370(%rip)    # 0x3d3428 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  2c50b8:      	movq	0x18(%rsp), %rdi
  2c50bd:      	callq	*0x10bf35(%rip)         # 0x3d0ff8 <writev+0x3d0ff8>
  2c50c3:      	movzbl	0x10e36e(%rip), %eax    # 0x3d3438 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  2c50ca:      	testb	%al, %al
  2c50cc:      	movq	0x10(%rsp), %rax
  2c50d1:      	je	0x2c50db <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x91b>
  2c50d3:      	lock
  2c50d4:      	subq	%rax, 0x10e34d(%rip)    # 0x3d3428 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  2c50db:      	movq	%r14, %rdi
  2c50de:      	callq	*0x10bf14(%rip)         # 0x3d0ff8 <writev+0x3d0ff8>
  2c50e4:      	jmp	0x2c50e9 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x929>
  2c50e6:      	movq	%rax, %rbx
  2c50e9:      	movq	0xa0(%rsp), %r14
  2c50f1:      	movq	0xa8(%rsp), %r15
  2c50f9:      	testq	%r15, %r15
  2c50fc:      	jne	0x2c5137 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x977>
  2c50fe:      	movq	0x98(%rsp), %rax
  2c5106:      	testq	%rax, %rax
  2c5109:      	je	0x2c512f <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x96f>
  2c510b:      	movzbl	0x10e326(%rip), %ecx    # 0x3d3438 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  2c5112:      	testb	%cl, %cl
  2c5114:      	je	0x2c5126 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x966>
  2c5116:      	shlq	$0x3, %rax
  2c511a:      	leaq	(%rax,%rax,2), %rax
  2c511e:      	lock
  2c511f:      	subq	%rax, 0x10e302(%rip)    # 0x3d3428 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  2c5126:      	movq	%r14, %rdi
  2c5129:      	callq	*0x10bec9(%rip)         # 0x3d0ff8 <writev+0x3d0ff8>
  2c512f:      	movq	%rbx, %rdi
  2c5132:      	callq	0x3bb530 <_Unwind_Resume@plt>
  2c5137:      	movq	0x10beba(%rip), %r13    # 0x3d0ff8 <writev+0x3d0ff8>
  2c513e:      	leaq	0x8(%r14), %r12
  2c5142:      	jmp	0x2c515c <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x99c>
  2c5144:      	nopw	%cs:(%rax,%rax)
  2c5150:      	callq	*%r13
  2c5153:      	addq	$0x18, %r12
  2c5157:      	decq	%r15
  2c515a:      	je	0x2c50fe <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x93e>
  2c515c:      	movq	-0x8(%r12), %rax
  2c5161:      	testq	%rax, %rax
  2c5164:      	je	0x2c5153 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x993>
  2c5166:      	movq	(%r12), %rdi
  2c516a:      	movzbl	0x10e2c7(%rip), %ecx    # 0x3d3438 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  2c5171:      	testb	%cl, %cl
  2c5173:      	je	0x2c5150 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x990>
  2c5175:      	shlq	$0x3, %rax
  2c5179:      	lock
  2c517a:      	subq	%rax, 0x10e2a7(%rip)    # 0x3d3428 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  2c5181:      	jmp	0x2c5150 <_RINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts21block_lsd_stable_sort15bounded_scatterINtCs9j6qJjDxNX3_15block_lsd_bench6RecordoKj4_EoEB1t_+0x990>

# Extracted steady-state path: no block rollover; cache hits assumed.
# LLVM-MCA-BEGIN scatter
loop:
movq	-0x10(%rsi), %r9
movq	-0x8(%rsi), %r10
movl	%r15d, %ecx
movq	%r9, %r11
andq	0x20(%rsp), %r11
movq	%r10, %r8
andq	%rax, %r8
shrdq	%cl, %r8, %r11
shrxq	%r15, %r8, %rcx
testb	$0x40, %r15b
cmoveq	%r11, %rcx
cmpq	%rcx, %rdx
jbe loop
vmovaps	(%rsi), %xmm0
movq	%rcx, %r8
shlq	$0x4, %r8
movq	(%r14,%r8), %r11
vmovaps	%xmm0, 0xc0(%rsp)
movq	%r10, 0x8(%r11)
movq	%r9, (%r11)
vmovdqa	0xc0(%rsp), %xmm0
vmovdqa	%xmm0, 0x10(%r11)
movq	(%r14,%r8), %r9
addq	$0x20, %r9
movq	%r9, (%r14,%r8)
cmpq	0x8(%r14,%r8), %r9
jne loop
addq $32, %rsi
decq %rbp
jne loop
# LLVM-MCA-END scatter

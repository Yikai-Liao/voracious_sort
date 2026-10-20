# LLVM-MCA-BEGIN scatter
loop:
movq	(%rax), %r8
movq	0x8(%rax), %r9
movl	%ebx, %ecx
andq	%r12, %r8
andq	%r13, %r9
shrdq	%cl, %r9, %r8
shrxq	%rbx, %r9, %rcx
testb	$0x40, %bl
cmoveq	%r8, %rcx
cmpq	%rcx, %rdx
jbe loop
vmovdqu	(%rax), %ymm0
movq	%rcx, %r8
shlq	$0x4, %r8
movq	(%r14,%r8), %r9
leaq	0x20(%r9), %r10
cmpq	0x8(%r14,%r8), %r10
vmovdqu	%ymm0, (%r9)
movq	%r10, (%r14,%r8)
jne loop
addq $32, %rax
decq %rsi
jne loop
# LLVM-MCA-END scatter

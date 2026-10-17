
experiments/block_msd/target/pa-order-count/time:     file format elf64-x86-64


Disassembly of section .text:

0000000000325ae0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>>:
  325ae0:	push   %rbp
  325ae1:	push   %r15
  325ae3:	push   %r14
  325ae5:	push   %r13
  325ae7:	push   %r12
  325ae9:	push   %rbx
  325aea:	sub    $0x68,%rsp
  325aee:	mov    $0x1,%r8b
  325af1:	cmp    $0x2,%rsi
  325af5:	jb     326679 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xb99>
  325afb:	mov    (%rdi),%rdx
  325afe:	mov    0x8(%rdi),%rcx
  325b02:	lea    -0x1(%rsi),%rbp
  325b06:	movabs $0x3ffffffffffff80,%r10
  325b10:	and    %rbp,%r10
  325b13:	mov    %rdi,0x8(%rsp)
  325b18:	je     325cc4 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x1e4>
  325b1e:	lea    0x20(%rdi),%r11
  325b22:	lea    -0x80(%r10),%rbx
  325b26:	shr    $0x7,%rbx
  325b2a:	xor    %r8d,%r8d
  325b2d:	jmp    325b49 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x69>
  325b2f:	nop
  325b30:	add    $0x1000,%r11
  325b37:	cmp    %rbx,%r8
  325b3a:	lea    0x1(%r8),%r8
  325b3e:	mov    0x8(%rsp),%rdi
  325b43:	je     325cc4 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x1e4>
  325b49:	xor    %r9d,%r9d
  325b4c:	xor    %eax,%eax
  325b4e:	xor    %r14d,%r14d
  325b51:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  325b60:	mov    (%r11,%r14,1),%rdi
  325b64:	xor    %rdx,%rdi
  325b67:	or     %r9,%rdi
  325b6a:	mov    0x8(%r11,%r14,1),%r9
  325b6f:	xor    %rcx,%r9
  325b72:	or     %rax,%r9
  325b75:	mov    0x28(%r11,%r14,1),%r15
  325b7a:	xor    %rcx,%r15
  325b7d:	mov    0x20(%r11,%r14,1),%r12
  325b82:	xor    %rdx,%r12
  325b85:	mov    0x40(%r11,%r14,1),%rax
  325b8a:	xor    %rdx,%rax
  325b8d:	or     %r12,%rax
  325b90:	or     %rdi,%rax
  325b93:	mov    0x48(%r11,%r14,1),%r12
  325b98:	xor    %rcx,%r12
  325b9b:	or     %r15,%r12
  325b9e:	or     %r9,%r12
  325ba1:	mov    0x68(%r11,%r14,1),%rdi
  325ba6:	xor    %rcx,%rdi
  325ba9:	mov    0x60(%r11,%r14,1),%r9
  325bae:	xor    %rdx,%r9
  325bb1:	mov    0x80(%r11,%r14,1),%r13
  325bb9:	xor    %rdx,%r13
  325bbc:	or     %r9,%r13
  325bbf:	mov    0x88(%r11,%r14,1),%r9
  325bc7:	xor    %rcx,%r9
  325bca:	or     %rdi,%r9
  325bcd:	mov    0xa8(%r11,%r14,1),%rdi
  325bd5:	xor    %rcx,%rdi
  325bd8:	or     %r9,%rdi
  325bdb:	or     %r12,%rdi
  325bde:	mov    0xa0(%r11,%r14,1),%r15
  325be6:	xor    %rdx,%r15
  325be9:	or     %r13,%r15
  325bec:	or     %rax,%r15
  325bef:	mov    0xc0(%r11,%r14,1),%r12
  325bf7:	xor    %rdx,%r12
  325bfa:	mov    0xc8(%r11,%r14,1),%r13
  325c02:	xor    %rcx,%r13
  325c05:	mov    0xe8(%r11,%r14,1),%rax
  325c0d:	mov    0xe0(%r11,%r14,1),%r9
  325c15:	add    $0x100,%r14
  325c1c:	xor    %rcx,%rax
  325c1f:	or     %r13,%rax
  325c22:	or     %rdi,%rax
  325c25:	xor    %rdx,%r9
  325c28:	or     %r12,%r9
  325c2b:	or     %r15,%r9
  325c2e:	cmp    $0x1000,%r14
  325c35:	jne    325b60 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x80>
  325c3b:	or     %rax,%r9
  325c3e:	je     325b30 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x50>
  325c44:	xor    %eax,%eax
  325c46:	xor    %r12d,%r12d
  325c49:	nopl   0x0(%rax)
  325c50:	mov    (%r11,%rax,1),%r14
  325c54:	mov    0x8(%r11,%rax,1),%r15
  325c59:	mov    %r15,%rdi
  325c5c:	xor    %rcx,%rdi
  325c5f:	mov    %r14,%r9
  325c62:	xor    %rdx,%r9
  325c65:	or     %rdi,%r9
  325c68:	jne    32604d <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x56d>
  325c6e:	mov    0x20(%r11,%rax,1),%r14
  325c73:	mov    0x28(%r11,%rax,1),%r15
  325c78:	mov    %r15,%rdi
  325c7b:	xor    %rcx,%rdi
  325c7e:	mov    %r14,%r9
  325c81:	xor    %rdx,%r9
  325c84:	or     %rdi,%r9
  325c87:	jne    32604a <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x56a>
  325c8d:	cmp    $0xfc0,%rax
  325c93:	je     325b30 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x50>
  325c99:	mov    0x40(%r11,%rax,1),%r14
  325c9e:	mov    0x48(%r11,%rax,1),%r15
  325ca3:	add    $0x60,%rax
  325ca7:	add    $0x3,%r12
  325cab:	mov    %r15,%rdi
  325cae:	xor    %rcx,%rdi
  325cb1:	mov    %r14,%r9
  325cb4:	xor    %rdx,%r9
  325cb7:	or     %rdi,%r9
  325cba:	je     325c50 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x170>
  325cbc:	dec    %r12
  325cbf:	jmp    32604d <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x56d>
  325cc4:	shl    $0x5,%r10
  325cc8:	lea    (%rdi,%r10,1),%rax
  325ccc:	add    $0x20,%rax
  325cd0:	and    $0x7f,%ebp
  325cd3:	mov    %ebp,%edi
  325cd5:	shl    $0x5,%edi
  325cd8:	not    %rbp
  325cdb:	add    %rsi,%rbp
  325cde:	xor    %r8d,%r8d
  325ce1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  325cf0:	cmp    %r8,%rdi
  325cf3:	je     326676 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xb96>
  325cf9:	mov    (%rax,%r8,1),%r14
  325cfd:	mov    0x8(%rax,%r8,1),%r15
  325d02:	mov    %r15,%r9
  325d05:	xor    %rcx,%r9
  325d08:	mov    %r14,%r10
  325d0b:	xor    %rdx,%r10
  325d0e:	add    $0x20,%r8
  325d12:	inc    %rbp
  325d15:	or     %r9,%r10
  325d18:	je     325cf0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x210>
  325d1a:	cmp    %rdx,%r14
  325d1d:	mov    %rsi,%rax
  325d20:	sbb    %rcx,%r15
  325d23:	jae    326067 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x587>
  325d29:	sub    %rbp,%rax
  325d2c:	jb     3266b8 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xbd8>
  325d32:	lea    -0x1(%rax),%rdx
  325d36:	mov    %rsi,0x20(%rsp)
  325d3b:	sub    %rbp,%rsi
  325d3e:	je     3266a4 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xbc4>
  325d44:	mov    %rbp,0x50(%rsp)
  325d49:	shl    $0x5,%rbp
  325d4d:	mov    0x8(%rsp),%rax
  325d52:	mov    %rbp,0x40(%rsp)
  325d57:	lea    (%rax,%rbp,1),%r13
  325d5b:	mov    %rdx,%rax
  325d5e:	and    $0xffffffffffffff80,%rax
  325d62:	mov    %rax,0x58(%rsp)
  325d67:	mov    %rsi,0x60(%rsp)
  325d6c:	mov    %rsi,0x38(%rsp)
  325d71:	lea    0x20(%r13),%rax
  325d75:	mov    %rax,0x30(%rsp)
  325d7a:	shr    $0x7,%rdx
  325d7e:	mov    $0x33,%al
  325d80:	mov    %rdx,0x48(%rsp)
  325d85:	bzhi   %rax,%rdx,%rax
  325d8a:	mov    %rax,0x18(%rsp)
  325d8f:	xor    %r12d,%r12d
  325d92:	mov    %r13,0x28(%rsp)
  325d97:	xor    %ebp,%ebp
  325d99:	nopl   0x0(%rax)
  325da0:	cmp    0x18(%rsp),%r12
  325da5:	je     326254 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x774>
  325dab:	mov    %r12,0x10(%rsp)
  325db0:	shl    $0xc,%r12
  325db4:	mov    0x28(%rsp),%rax
  325db9:	lea    (%rax,%r12,1),%rdx
  325dbd:	add    0x30(%rsp),%r12
  325dc2:	kmovd  %ebp,%k0
  325dc6:	kshiftlb $0x7,%k0,%k0
  325dcc:	kshiftrb $0x7,%k0,%k0
  325dd2:	kxorw  %k0,%k0,%k1
  325dd6:	vpxor  %xmm0,%xmm0,%xmm0
  325dda:	mov    $0x60,%ebp
  325ddf:	vpxor  %xmm1,%xmm1,%xmm1
  325de3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  325df0:	mov    -0x60(%r13,%rbp,1),%r15
  325df5:	mov    -0x58(%r13,%rbp,1),%rcx
  325dfa:	mov    -0x20(%r13,%rbp,1),%r11
  325dff:	mov    -0x18(%r13,%rbp,1),%r8
  325e04:	mov    -0x38(%r13,%rbp,1),%r10
  325e09:	mov    -0x40(%r13,%rbp,1),%r9
  325e0e:	mov    0x28(%r13,%rbp,1),%rdi
  325e13:	mov    0x8(%r13,%rbp,1),%r14
  325e18:	mov    0x20(%r13,%rbp,1),%rbx
  325e1d:	mov    0x0(%r13,%rbp,1),%rsi
  325e22:	cmp    %r11,%r9
  325e25:	mov    %r10,%rax
  325e28:	sbb    %r8,%rax
  325e2b:	mov    $0x0,%eax
  325e30:	sbb    %rax,%rax
  325e33:	vmovq  %rax,%xmm2
  325e38:	cmp    %r9,%r15
  325e3b:	mov    %rcx,%rax
  325e3e:	sbb    %r10,%rax
  325e41:	mov    $0x0,%eax
  325e46:	sbb    %rax,%rax
  325e49:	vmovq  %rax,%xmm3
  325e4e:	vpunpcklbw %xmm2,%xmm3,%xmm2
  325e52:	vpsubb %xmm2,%xmm0,%xmm0
  325e56:	cmp    %rbx,%rsi
  325e59:	mov    %r14,%rax
  325e5c:	sbb    %rdi,%rax
  325e5f:	mov    $0x0,%eax
  325e64:	sbb    %rax,%rax
  325e67:	vmovq  %rax,%xmm2
  325e6c:	cmp    %rsi,%r11
  325e6f:	mov    %r8,%rax
  325e72:	sbb    %r14,%rax
  325e75:	mov    $0x0,%eax
  325e7a:	sbb    %rax,%rax
  325e7d:	vmovq  %rax,%xmm3
  325e82:	vpunpcklbw %xmm2,%xmm3,%xmm2
  325e86:	vpsubb %xmm2,%xmm1,%xmm1
  325e8a:	xor    %r10,%rcx
  325e8d:	xor    %r8,%r10
  325e90:	xor    %r9,%r15
  325e93:	xor    %r11,%r9
  325e96:	or     %r10,%r9
  325e99:	sete   %al
  325e9c:	kmovd  %eax,%k2
  325ea0:	kshiftlb $0x1,%k2,%k2
  325ea6:	or     %rcx,%r15
  325ea9:	sete   %al
  325eac:	kmovd  %eax,%k3
  325eb0:	kshiftlb $0x7,%k3,%k3
  325eb6:	kshiftrb $0x7,%k3,%k3
  325ebc:	korw   %k2,%k3,%k2
  325ec0:	xor    %r14,%rdi
  325ec3:	xor    %rsi,%rbx
  325ec6:	or     %rdi,%rbx
  325ec9:	sete   %al
  325ecc:	kmovd  %eax,%k3
  325ed0:	kshiftlb $0x1,%k3,%k3
  325ed6:	xor    %r14,%r8
  325ed9:	xor    %rsi,%r11
  325edc:	or     %r8,%r11
  325edf:	sete   %al
  325ee2:	kmovd  %eax,%k4
  325ee6:	kshiftlb $0x7,%k4,%k4
  325eec:	kshiftrb $0x7,%k4,%k4
  325ef2:	korw   %k3,%k4,%k3
  325ef6:	korw   %k2,%k0,%k0
  325efa:	korw   %k3,%k1,%k1
  325efe:	sub    $0xffffffffffffff80,%rbp
  325f02:	cmp    $0xfe0,%rbp
  325f09:	jne    325df0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x310>
  325f0f:	korw   %k0,%k1,%k0
  325f13:	kmovd  %k0,%eax
  325f17:	test   $0x3,%al
  325f19:	setne  %sil
  325f1d:	vpaddb %xmm0,%xmm1,%xmm0
  325f21:	vpsrlw $0x8,%xmm0,%xmm1
  325f26:	vpaddb %xmm1,%xmm0,%xmm0
  325f2a:	vmovd  %xmm0,%ecx
  325f2e:	vmovdqa 0xf80(%rdx),%xmm0
  325f36:	mov    0xf80(%rdx),%rax
  325f3d:	mov    0xf88(%rdx),%rdi
  325f44:	cmp    0xf80(%r12),%rax
  325f4c:	sbb    0xf88(%r12),%rdi
  325f54:	vpxor  0xf80(%r12),%xmm0,%xmm0
  325f5e:	adc    $0x0,%cl
  325f61:	vptest %xmm0,%xmm0
  325f66:	sete   %al
  325f69:	vmovdqa 0xfa0(%rdx),%xmm0
  325f71:	vpxor  0xfa0(%r12),%xmm0,%xmm0
  325f7b:	vptest %xmm0,%xmm0
  325f80:	sete   %dil
  325f84:	or     %al,%dil
  325f87:	mov    0xfa8(%rdx),%rax
  325f8e:	mov    0xfa0(%rdx),%r8
  325f95:	cmp    0xfa0(%r12),%r8
  325f9d:	sbb    0xfa8(%r12),%rax
  325fa5:	setb   %al
  325fa8:	vmovdqa 0xfc0(%rdx),%xmm0
  325fb0:	mov    0xfc0(%rdx),%r8
  325fb7:	cmp    0xfc0(%r12),%r8
  325fbf:	mov    0xfc8(%rdx),%r8
  325fc6:	sbb    0xfc8(%r12),%r8
  325fce:	adc    %cl,%al
  325fd0:	vpxor  0xfc0(%r12),%xmm0,%xmm0
  325fda:	vptest %xmm0,%xmm0
  325fdf:	sete   %cl
  325fe2:	or     %dil,%cl
  325fe5:	vmovdqa 0xfe0(%rdx),%xmm0
  325fed:	mov    0xfe8(%rdx),%rdi
  325ff4:	mov    0xfe0(%rdx),%rdx
  325ffb:	cmp    0xfe0(%r12),%rdx
  326003:	sbb    0xfe8(%r12),%rdi
  32600b:	mov    $0x0,%edx
  326010:	sbb    %edx,%edx
  326012:	vpxor  0xfe0(%r12),%xmm0,%xmm0
  32601c:	vptest %xmm0,%xmm0
  326021:	sete   %bpl
  326025:	or     %cl,%bpl
  326028:	or     %sil,%bpl
  32602b:	mov    0x10(%rsp),%r12
  326030:	inc    %r12
  326033:	add    $0x1000,%r13
  32603a:	cmp    %dl,%al
  32603c:	je     325da0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x2c0>
  326042:	xor    %r8d,%r8d
  326045:	jmp    326679 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xb99>
  32604a:	inc    %r12
  32604d:	shl    $0x7,%r8
  326051:	lea    (%r12,%r8,1),%rbp
  326055:	inc    %rbp
  326058:	cmp    %rdx,%r14
  32605b:	mov    %rsi,%rax
  32605e:	sbb    %rcx,%r15
  326061:	jb     325d29 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x249>
  326067:	sub    %rbp,%rax
  32606a:	jb     3266cb <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xbeb>
  326070:	lea    -0x1(%rax),%rdx
  326074:	sub    %rbp,%rsi
  326077:	je     3266a4 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xbc4>
  32607d:	shl    $0x5,%rbp
  326081:	mov    0x8(%rsp),%rax
  326086:	lea    (%rax,%rbp,1),%r14
  32608a:	mov    %rdx,%rax
  32608d:	and    $0xffffffffffffff80,%rax
  326091:	mov    %rax,0x30(%rsp)
  326096:	lea    0x20(%r14),%rax
  32609a:	mov    %rax,0x28(%rsp)
  32609f:	shr    $0x7,%rdx
  3260a3:	mov    $0x33,%al
  3260a5:	mov    %rdx,0x20(%rsp)
  3260aa:	bzhi   %rax,%rdx,%rax
  3260af:	mov    %rax,0x10(%rsp)
  3260b4:	xor    %ebx,%ebx
  3260b6:	mov    %r14,0x18(%rsp)
  3260bb:	nopl   0x0(%rax,%rax,1)
  3260c0:	cmp    0x10(%rsp),%rbx
  3260c5:	je     32627c <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x79c>
  3260cb:	mov    %rbp,%r11
  3260ce:	mov    %rbx,%rax
  3260d1:	shl    $0xc,%rax
  3260d5:	mov    0x18(%rsp),%rcx
  3260da:	lea    (%rcx,%rax,1),%r15
  3260de:	add    0x28(%rsp),%rax
  3260e3:	vpxor  %xmm0,%xmm0,%xmm0
  3260e7:	mov    $0x60,%edi
  3260ec:	vpxor  %xmm1,%xmm1,%xmm1
  3260f0:	mov    -0x20(%r14,%rdi,1),%r9
  3260f5:	mov    -0x18(%r14,%rdi,1),%r12
  3260fa:	mov    -0x40(%r14,%rdi,1),%r13
  3260ff:	mov    -0x38(%r14,%rdi,1),%rcx
  326104:	mov    0x28(%r14,%rdi,1),%r8
  326109:	mov    0x8(%r14,%rdi,1),%rdx
  32610e:	mov    (%r14,%rdi,1),%r10
  326112:	cmp    -0x60(%r14,%rdi,1),%r13
  326117:	mov    %rcx,%rbp
  32611a:	sbb    -0x58(%r14,%rdi,1),%rbp
  32611f:	setb   %bpl
  326123:	kmovd  %ebp,%k0
  326127:	cmp    %r13,%r9
  32612a:	mov    %r12,%r13
  32612d:	sbb    %rcx,%r13
  326130:	setb   %cl
  326133:	kmovd  %ecx,%k2
  326137:	cmp    %r9,%r10
  32613a:	mov    %rdx,%rcx
  32613d:	sbb    %r12,%rcx
  326140:	setb   %cl
  326143:	kmovd  %ecx,%k1
  326147:	cmp    %r10,0x20(%r14,%rdi,1)
  32614c:	sbb    %rdx,%r8
  32614f:	setb   %cl
  326152:	kmovd  %ecx,%k3
  326156:	kshiftlb $0x1,%k2,%k2
  32615c:	kshiftlb $0x7,%k0,%k0
  326162:	kshiftrb $0x7,%k0,%k0
  326168:	korw   %k2,%k0,%k0
  32616c:	vpmovm2b %k0,%xmm2
  326172:	vpsubb %xmm2,%xmm0,%xmm0
  326176:	kshiftlb $0x1,%k3,%k0
  32617c:	kshiftlb $0x7,%k1,%k1
  326182:	kshiftrb $0x7,%k1,%k1
  326188:	korw   %k0,%k1,%k0
  32618c:	vpmovm2b %k0,%xmm2
  326192:	vpsubb %xmm2,%xmm1,%xmm1
  326196:	sub    $0xffffffffffffff80,%rdi
  32619a:	cmp    $0xfe0,%rdi
  3261a1:	jne    3260f0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x610>
  3261a7:	vpaddb %xmm0,%xmm1,%xmm0
  3261ab:	vpsrlw $0x8,%xmm0,%xmm1
  3261b0:	vpaddb %xmm1,%xmm0,%xmm0
  3261b4:	vmovd  %xmm0,%ecx
  3261b8:	mov    0xf80(%rax),%rdx
  3261bf:	mov    0xf88(%rax),%rdi
  3261c6:	cmp    0xf80(%r15),%rdx
  3261cd:	sbb    0xf88(%r15),%rdi
  3261d4:	adc    $0x0,%cl
  3261d7:	mov    0xfa0(%rax),%rdx
  3261de:	cmp    0xfa0(%r15),%rdx
  3261e5:	mov    0xfa8(%rax),%rdx
  3261ec:	sbb    0xfa8(%r15),%rdx
  3261f3:	setb   %dl
  3261f6:	mov    0xfc8(%rax),%rdi
  3261fd:	mov    0xfc0(%rax),%r8
  326204:	cmp    0xfc0(%r15),%r8
  32620b:	sbb    0xfc8(%r15),%rdi
  326212:	adc    %cl,%dl
  326214:	mov    0xfe8(%rax),%rcx
  32621b:	mov    0xfe0(%rax),%rax
  326222:	xor    %r8d,%r8d
  326225:	cmp    0xfe0(%r15),%rax
  32622c:	sbb    0xfe8(%r15),%rcx
  326233:	mov    $0x0,%eax
  326238:	sbb    %eax,%eax
  32623a:	inc    %rbx
  32623d:	add    $0x1000,%r14
  326244:	cmp    %al,%dl
  326246:	mov    %r11,%rbp
  326249:	je     3260c0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x5e0>
  32624f:	jmp    326679 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xb99>
  326254:	mov    0x60(%rsp),%r10
  326259:	mov    0x58(%rsp),%rdi
  32625e:	sub    %rdi,%r10
  326261:	mov    0x8(%rsp),%rax
  326266:	jb     3266de <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xbfe>
  32626c:	cmp    $0x2,%r10
  326270:	jae    3262db <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x7fb>
  326272:	mov    0x20(%rsp),%r8
  326277:	jmp    326348 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x868>
  32627c:	mov    0x30(%rsp),%rdi
  326281:	cmp    %rsi,%rdi
  326284:	ja     3266f3 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xc13>
  32628a:	mov    0x20(%rsp),%rcx
  32628f:	shl    $0xc,%rcx
  326293:	add    %rbp,%rcx
  326296:	mov    0x8(%rsp),%rax
  32629b:	add    %rcx,%rax
  32629e:	add    $0x20,%rax
  3262a2:	sub    %rdi,%rsi
  3262a5:	inc    %rsi
  3262a8:	nopl   0x0(%rax,%rax,1)
  3262b0:	dec    %rsi
  3262b3:	cmp    $0x2,%rsi
  3262b7:	setb   %r8b
  3262bb:	jb     326679 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xb99>
  3262c1:	mov    (%rax),%rcx
  3262c4:	mov    0x8(%rax),%rdx
  3262c8:	cmp    -0x20(%rax),%rcx
  3262cc:	sbb    -0x18(%rax),%rdx
  3262d0:	lea    0x20(%rax),%rax
  3262d4:	jae    3262b0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x7d0>
  3262d6:	jmp    326679 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xb99>
  3262db:	shl    $0x5,%rdi
  3262df:	mov    0x28(%rsp),%rdx
  3262e4:	mov    (%rdx,%rdi,1),%rcx
  3262e8:	mov    0x8(%rdx,%rdi,1),%rdx
  3262ed:	inc    %r10
  3262f0:	mov    0x48(%rsp),%rsi
  3262f5:	shl    $0xc,%rsi
  3262f9:	add    0x40(%rsp),%rsi
  3262fe:	add    %rsi,%rax
  326301:	add    $0x20,%rax
  326305:	mov    0x20(%rsp),%r8
  32630a:	nopw   0x0(%rax,%rax,1)
  326310:	mov    (%rax),%rsi
  326313:	mov    0x8(%rax),%rdi
  326317:	cmp    %rsi,%rcx
  32631a:	mov    %rdx,%r9
  32631d:	sbb    %rdi,%r9
  326320:	jb     326042 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x562>
  326326:	xor    %rsi,%rcx
  326329:	xor    %rdi,%rdx
  32632c:	or     %rcx,%rdx
  32632f:	sete   %cl
  326332:	or     %cl,%bpl
  326335:	dec    %r10
  326338:	add    $0x20,%rax
  32633c:	mov    %rsi,%rcx
  32633f:	mov    %rdi,%rdx
  326342:	cmp    $0x3,%r10
  326346:	jae    326310 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x830>
  326348:	mov    %r8,%rsi
  32634b:	shr    $1,%rsi
  32634e:	mov    %r8,%rdx
  326351:	shl    $0x5,%rdx
  326355:	lea    -0x1(%rsi),%rax
  326359:	mov    %esi,%ecx
  32635b:	and    $0x3,%ecx
  32635e:	cmp    $0x3,%rax
  326362:	jae    32636b <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x88b>
  326364:	xor    %edi,%edi
  326366:	jmp    32643c <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x95c>
  32636b:	mov    0x8(%rsp),%rdi
  326370:	lea    (%rdi,%rdx,1),%r10
  326374:	movabs $0x1fffffffffffffc,%rax
  32637e:	and    %rax,%rsi
  326381:	lea    0x60(%rdi),%rax
  326385:	lea    (%rdx,%rdi,1),%r11
  326389:	add    $0xffffffffffffffe0,%r11
  32638d:	xor    %edi,%edi
  32638f:	movabs $0x7fffffffffffffe,%rbx
  326399:	movabs $0x7fffffffffffffd,%r14
  3263a3:	movabs $0x7fffffffffffffc,%r15
  3263ad:	nopl   (%rax)
  3263b0:	vmovups -0x60(%rax),%ymm0
  3263b5:	vmovups (%r11),%ymm1
  3263ba:	vmovups %ymm1,-0x60(%rax)
  3263bf:	vmovups %ymm0,(%r11)
  3263c4:	mov    %rdi,%r9
  3263c7:	xor    %rbx,%r9
  3263ca:	shl    $0x5,%r9
  3263ce:	vmovups -0x40(%rax),%ymm0
  3263d3:	vmovups (%r10,%r9,1),%ymm1
  3263d9:	vmovups %ymm1,-0x40(%rax)
  3263de:	vmovups %ymm0,(%r10,%r9,1)
  3263e4:	mov    %rdi,%r9
  3263e7:	xor    %r14,%r9
  3263ea:	shl    $0x5,%r9
  3263ee:	vmovups -0x20(%rax),%ymm0
  3263f3:	vmovups (%r10,%r9,1),%ymm1
  3263f9:	vmovups %ymm1,-0x20(%rax)
  3263fe:	vmovups %ymm0,(%r10,%r9,1)
  326404:	mov    %rdi,%r9
  326407:	xor    %r15,%r9
  32640a:	shl    $0x5,%r9
  32640e:	vmovdqu (%rax),%ymm0
  326412:	vmovdqu (%r10,%r9,1),%ymm1
  326418:	vmovdqu %ymm1,(%rax)
  32641c:	vmovdqu %ymm0,(%r10,%r9,1)
  326422:	add    $0x4,%rdi
  326426:	sub    $0xffffffffffffff80,%rax
  32642a:	add    $0xffffffffffffff80,%r11
  32642e:	cmp    %rdi,%rsi
  326431:	jne    3263b0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x8d0>
  326437:	test   %rcx,%rcx
  32643a:	je     32647f <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x99f>
  32643c:	shl    $0x5,%rdi
  326440:	mov    0x8(%rsp),%rsi
  326445:	lea    (%rsi,%rdi,1),%rax
  326449:	sub    %rdi,%rdx
  32644c:	add    %rsi,%rdx
  32644f:	add    $0xffffffffffffffe0,%rdx
  326453:	shl    $0x5,%ecx
  326456:	xor    %esi,%esi
  326458:	nopl   0x0(%rax,%rax,1)
  326460:	vmovdqu (%rax,%rsi,1),%ymm0
  326465:	vmovdqu (%rdx),%ymm1
  326469:	vmovdqu %ymm1,(%rax,%rsi,1)
  32646e:	vmovdqu %ymm0,(%rdx)
  326472:	add    $0x20,%rsi
  326476:	add    $0xffffffffffffffe0,%rdx
  32647a:	cmp    %rsi,%rcx
  32647d:	jne    326460 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x980>
  32647f:	cmpq   $0x2,0x50(%rsp)
  326485:	setae  %al
  326488:	or     %bpl,%al
  32648b:	test   $0x1,%al
  32648d:	je     326676 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xb96>
  326493:	mov    0x8(%rsp),%rax
  326498:	lea    0x20(%rax),%rcx
  32649c:	lea    0x60(%rax),%rdx
  3264a0:	mov    %rdx,0x18(%rsp)
  3264a5:	lea    -0x20(%rax),%rdx
  3264a9:	mov    %rdx,0x10(%rsp)
  3264ae:	xor    %esi,%esi
  3264b0:	movabs $0x7fffffffffffffe,%r11
  3264ba:	movabs $0x7fffffffffffffd,%rbx
  3264c4:	movabs $0x7fffffffffffffc,%r14
  3264ce:	jmp    3264de <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9fe>
  3264d0:	cmp    %r8,%rsi
  3264d3:	mov    0x8(%rsp),%rax
  3264d8:	jae    326676 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xb96>
  3264de:	mov    %rsi,%rdx
  3264e1:	mov    %rsi,%r15
  3264e4:	shl    $0x5,%r15
  3264e8:	mov    %rax,%rdi
  3264eb:	mov    (%rax,%r15,1),%rax
  3264ef:	mov    0x8(%rdi,%r15,1),%r9
  3264f4:	lea    0x1(%rsi),%rdi
  3264f8:	cmp    %rdi,%r8
  3264fb:	cmova  %r8,%rdi
  3264ff:	lea    -0x1(%rdi),%r12
  326503:	lea    (%rcx,%r15,1),%r13
  326507:	nopw   0x0(%rax,%rax,1)
  326510:	cmp    %rsi,%r12
  326513:	je     326540 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xa60>
  326515:	inc    %rsi
  326518:	mov    0x0(%r13),%rbp
  32651c:	xor    %rax,%rbp
  32651f:	mov    0x8(%r13),%r10
  326523:	xor    %r9,%r10
  326526:	add    $0x20,%r13
  32652a:	or     %rbp,%r10
  32652d:	je     326510 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xa30>
  32652f:	jmp    326543 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xa63>
  326531:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  326540:	mov    %rdi,%rsi
  326543:	mov    %rsi,%rax
  326546:	sub    %rdx,%rax
  326549:	jb     32668e <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xbae>
  32654f:	mov    %rax,%rdi
  326552:	shr    $1,%rdi
  326555:	je     3264d0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9f0>
  32655b:	mov    %rsi,%rdx
  32655e:	shl    $0x5,%rdx
  326562:	mov    %edi,%r12d
  326565:	and    $0x3,%r12d
  326569:	cmp    $0x8,%rax
  32656d:	jae    326580 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xaa0>
  32656f:	xor    %r13d,%r13d
  326572:	jmp    326632 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xb52>
  326577:	nopw   0x0(%rax,%rax,1)
  326580:	mov    0x8(%rsp),%rax
  326585:	add    %rdx,%rax
  326588:	and    $0xfffffffffffffffc,%rdi
  32658c:	mov    0x18(%rsp),%r9
  326591:	lea    (%r9,%r15,1),%rbp
  326595:	mov    0x10(%rsp),%r9
  32659a:	add    %rdx,%r9
  32659d:	xor    %r13d,%r13d
  3265a0:	vmovups -0x60(%rbp),%ymm0
  3265a5:	vmovups (%r9),%ymm1
  3265aa:	vmovups %ymm1,-0x60(%rbp)
  3265af:	vmovups %ymm0,(%r9)
  3265b4:	mov    %r13,%r10
  3265b7:	xor    %r11,%r10
  3265ba:	shl    $0x5,%r10
  3265be:	vmovups -0x40(%rbp),%ymm0
  3265c3:	vmovups (%rax,%r10,1),%ymm1
  3265c9:	vmovups %ymm1,-0x40(%rbp)
  3265ce:	vmovups %ymm0,(%rax,%r10,1)
  3265d4:	mov    %r13,%r10
  3265d7:	xor    %rbx,%r10
  3265da:	shl    $0x5,%r10
  3265de:	vmovups -0x20(%rbp),%ymm0
  3265e3:	vmovups (%rax,%r10,1),%ymm1
  3265e9:	vmovups %ymm1,-0x20(%rbp)
  3265ee:	vmovups %ymm0,(%rax,%r10,1)
  3265f4:	mov    %r13,%r10
  3265f7:	xor    %r14,%r10
  3265fa:	shl    $0x5,%r10
  3265fe:	vmovdqu 0x0(%rbp),%ymm0
  326603:	vmovdqu (%rax,%r10,1),%ymm1
  326609:	vmovdqu %ymm1,0x0(%rbp)
  32660e:	vmovdqu %ymm0,(%rax,%r10,1)
  326614:	add    $0x4,%r13
  326618:	sub    $0xffffffffffffff80,%rbp
  32661c:	add    $0xffffffffffffff80,%r9
  326620:	cmp    %r13,%rdi
  326623:	jne    3265a0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xac0>
  326629:	test   %r12,%r12
  32662c:	je     3264d0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9f0>
  326632:	shl    $0x5,%r13
  326636:	add    0x8(%rsp),%r15
  32663b:	add    %r13,%r15
  32663e:	sub    %r13,%rdx
  326641:	add    0x10(%rsp),%rdx
  326646:	shl    $0x5,%r12d
  32664a:	xor    %eax,%eax
  32664c:	nopl   0x0(%rax)
  326650:	vmovdqu (%r15,%rax,1),%ymm0
  326656:	vmovdqu (%rdx),%ymm1
  32665a:	vmovdqu %ymm1,(%r15,%rax,1)
  326660:	vmovdqu %ymm0,(%rdx)
  326664:	add    $0x20,%rax
  326668:	add    $0xffffffffffffffe0,%rdx
  32666c:	cmp    %rax,%r12
  32666f:	jne    326650 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xb70>
  326671:	jmp    3264d0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9f0>
  326676:	mov    $0x1,%r8b
  326679:	mov    %r8d,%eax
  32667c:	add    $0x68,%rsp
  326680:	pop    %rbx
  326681:	pop    %r12
  326683:	pop    %r13
  326685:	pop    %r14
  326687:	pop    %r15
  326689:	pop    %rbp
  32668a:	vzeroupper
  32668d:	ret
  32668e:	lea    0x19265b(%rip),%rcx        # 4b8cf0 <anon.005357b6259aec7dbb5efeaf9c6c1e46.1.llvm.5840278210049151275>
  326695:	mov    %rdx,%rdi
  326698:	mov    %r8,%rdx
  32669b:	vzeroupper
  32669e:	call   *0x194bc4(%rip)        # 4bb268 <_DYNAMIC+0x298>
  3266a4:	lea    0x18a455(%rip),%rcx        # 4b0b00 <anon.c4e4e2de90ac69d0128ebb4ed2cca3d4.1.llvm.2928595367199889299+0x60>
  3266ab:	xor    %edi,%edi
  3266ad:	mov    %rdx,%rsi
  3266b0:	xor    %edx,%edx
  3266b2:	call   *0x194bb0(%rip)        # 4bb268 <_DYNAMIC+0x298>
  3266b8:	lea    0x18a429(%rip),%rcx        # 4b0ae8 <anon.c4e4e2de90ac69d0128ebb4ed2cca3d4.1.llvm.2928595367199889299+0x48>
  3266bf:	mov    %rbp,%rdi
  3266c2:	mov    %rsi,%rdx
  3266c5:	call   *0x194b9d(%rip)        # 4bb268 <_DYNAMIC+0x298>
  3266cb:	lea    0x18a3fe(%rip),%rcx        # 4b0ad0 <anon.c4e4e2de90ac69d0128ebb4ed2cca3d4.1.llvm.2928595367199889299+0x30>
  3266d2:	mov    %rbp,%rdi
  3266d5:	mov    %rsi,%rdx
  3266d8:	call   *0x194b8a(%rip)        # 4bb268 <_DYNAMIC+0x298>
  3266de:	lea    0x18a433(%rip),%rcx        # 4b0b18 <anon.c4e4e2de90ac69d0128ebb4ed2cca3d4.1.llvm.2928595367199889299+0x78>
  3266e5:	mov    0x38(%rsp),%rdx
  3266ea:	mov    %rdx,%rsi
  3266ed:	call   *0x194b75(%rip)        # 4bb268 <_DYNAMIC+0x298>
  3266f3:	lea    0x18a41e(%rip),%rcx        # 4b0b18 <anon.c4e4e2de90ac69d0128ebb4ed2cca3d4.1.llvm.2928595367199889299+0x78>
  3266fa:	mov    %rsi,%rdx
  3266fd:	call   *0x194b65(%rip)        # 4bb268 <_DYNAMIC+0x298>


experiments/block_msd/target/pa-order-words/time:     file format elf64-x86-64


Disassembly of section .text:

000000000045d8f0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>>:
  45d8f0:	push   %rbp
  45d8f1:	push   %r15
  45d8f3:	push   %r14
  45d8f5:	push   %r13
  45d8f7:	push   %r12
  45d8f9:	push   %rbx
  45d8fa:	sub    $0x78,%rsp
  45d8fe:	mov    $0x1,%r8b
  45d901:	cmp    $0x2,%rsi
  45d905:	jb     45e2e9 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9f9>
  45d90b:	mov    (%rdi),%rdx
  45d90e:	mov    0x8(%rdi),%rcx
  45d912:	lea    -0x1(%rsi),%rax
  45d916:	movabs $0x3ffffffffffff80,%r10
  45d920:	mov    %rax,%rbp
  45d923:	and    %rax,%r10
  45d926:	mov    %rdi,(%rsp)
  45d92a:	je     45dad4 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x1e4>
  45d930:	lea    0x20(%rdi),%r11
  45d934:	lea    -0x80(%r10),%rbx
  45d938:	shr    $0x7,%rbx
  45d93c:	xor    %r8d,%r8d
  45d93f:	jmp    45d968 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x78>
  45d941:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  45d950:	add    $0x1000,%r11
  45d957:	cmp    %rbx,%r8
  45d95a:	lea    0x1(%r8),%r8
  45d95e:	mov    (%rsp),%rdi
  45d962:	je     45dad4 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x1e4>
  45d968:	xor    %r14d,%r14d
  45d96b:	xor    %eax,%eax
  45d96d:	xor    %edi,%edi
  45d96f:	nop
  45d970:	mov    (%r11,%rdi,1),%r9
  45d974:	xor    %rdx,%r9
  45d977:	or     %r14,%r9
  45d97a:	mov    0x8(%r11,%rdi,1),%r14
  45d97f:	xor    %rcx,%r14
  45d982:	or     %rax,%r14
  45d985:	mov    0x28(%r11,%rdi,1),%r15
  45d98a:	xor    %rcx,%r15
  45d98d:	mov    0x20(%r11,%rdi,1),%r12
  45d992:	xor    %rdx,%r12
  45d995:	mov    0x40(%r11,%rdi,1),%rax
  45d99a:	xor    %rdx,%rax
  45d99d:	or     %r12,%rax
  45d9a0:	or     %r9,%rax
  45d9a3:	mov    0x48(%r11,%rdi,1),%r12
  45d9a8:	xor    %rcx,%r12
  45d9ab:	or     %r15,%r12
  45d9ae:	or     %r14,%r12
  45d9b1:	mov    0x68(%r11,%rdi,1),%r9
  45d9b6:	xor    %rcx,%r9
  45d9b9:	mov    0x60(%r11,%rdi,1),%r14
  45d9be:	xor    %rdx,%r14
  45d9c1:	mov    0x80(%r11,%rdi,1),%r13
  45d9c9:	xor    %rdx,%r13
  45d9cc:	or     %r14,%r13
  45d9cf:	mov    0x88(%r11,%rdi,1),%r14
  45d9d7:	xor    %rcx,%r14
  45d9da:	or     %r9,%r14
  45d9dd:	mov    0xa8(%r11,%rdi,1),%r9
  45d9e5:	xor    %rcx,%r9
  45d9e8:	or     %r14,%r9
  45d9eb:	or     %r12,%r9
  45d9ee:	mov    0xa0(%r11,%rdi,1),%r15
  45d9f6:	xor    %rdx,%r15
  45d9f9:	or     %r13,%r15
  45d9fc:	or     %rax,%r15
  45d9ff:	mov    0xc0(%r11,%rdi,1),%r12
  45da07:	xor    %rdx,%r12
  45da0a:	mov    0xc8(%r11,%rdi,1),%r13
  45da12:	xor    %rcx,%r13
  45da15:	mov    0xe8(%r11,%rdi,1),%rax
  45da1d:	mov    0xe0(%r11,%rdi,1),%r14
  45da25:	add    $0x100,%rdi
  45da2c:	xor    %rcx,%rax
  45da2f:	or     %r13,%rax
  45da32:	or     %r9,%rax
  45da35:	xor    %rdx,%r14
  45da38:	or     %r12,%r14
  45da3b:	or     %r15,%r14
  45da3e:	cmp    $0x1000,%rdi
  45da45:	jne    45d970 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x80>
  45da4b:	or     %rax,%r14
  45da4e:	je     45d950 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x60>
  45da54:	xor    %eax,%eax
  45da56:	xor    %r15d,%r15d
  45da59:	nopl   0x0(%rax)
  45da60:	mov    (%r11,%rax,1),%rdi
  45da64:	mov    0x8(%r11,%rax,1),%r14
  45da69:	mov    %r14,%r9
  45da6c:	xor    %rcx,%r9
  45da6f:	mov    %rdi,%r12
  45da72:	xor    %rdx,%r12
  45da75:	or     %r9,%r12
  45da78:	jne    45ddbb <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x4cb>
  45da7e:	mov    0x20(%r11,%rax,1),%rdi
  45da83:	mov    0x28(%r11,%rax,1),%r14
  45da88:	mov    %r14,%r9
  45da8b:	xor    %rcx,%r9
  45da8e:	mov    %rdi,%r12
  45da91:	xor    %rdx,%r12
  45da94:	or     %r9,%r12
  45da97:	jne    45ddb8 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x4c8>
  45da9d:	cmp    $0xfc0,%rax
  45daa3:	je     45d950 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x60>
  45daa9:	mov    0x40(%r11,%rax,1),%rdi
  45daae:	mov    0x48(%r11,%rax,1),%r14
  45dab3:	add    $0x60,%rax
  45dab7:	add    $0x3,%r15
  45dabb:	mov    %r14,%r9
  45dabe:	xor    %rcx,%r9
  45dac1:	mov    %rdi,%r12
  45dac4:	xor    %rdx,%r12
  45dac7:	or     %r9,%r12
  45daca:	je     45da60 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x170>
  45dacc:	dec    %r15
  45dacf:	jmp    45ddbb <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x4cb>
  45dad4:	shl    $0x5,%r10
  45dad8:	lea    (%rdi,%r10,1),%rax
  45dadc:	add    $0x20,%rax
  45dae0:	mov    %rbp,%rdi
  45dae3:	and    $0x7f,%edi
  45dae6:	mov    %edi,%r8d
  45dae9:	shl    $0x5,%r8d
  45daed:	not    %rdi
  45daf0:	add    %rsi,%rdi
  45daf3:	mov    %rdi,0x8(%rsp)
  45daf8:	xor    %r9d,%r9d
  45dafb:	nopl   0x0(%rax,%rax,1)
  45db00:	cmp    %r9,%r8
  45db03:	je     45e2e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9f6>
  45db09:	mov    (%rax,%r9,1),%rdi
  45db0d:	mov    0x8(%rax,%r9,1),%r14
  45db12:	mov    %r14,%r10
  45db15:	xor    %rcx,%r10
  45db18:	mov    %rdi,%r11
  45db1b:	xor    %rdx,%r11
  45db1e:	add    $0x20,%r9
  45db22:	incq   0x8(%rsp)
  45db27:	or     %r10,%r11
  45db2a:	je     45db00 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x210>
  45db2c:	cmp    %rdx,%rdi
  45db2f:	mov    %rsi,%rax
  45db32:	sbb    %rcx,%r14
  45db35:	jae    45ddda <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x4ea>
  45db3b:	mov    0x8(%rsp),%rdi
  45db40:	sub    %rdi,%rax
  45db43:	jb     45e314 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xa24>
  45db49:	lea    -0x1(%rax),%rdx
  45db4d:	mov    %rsi,0x20(%rsp)
  45db52:	sub    %rdi,%rsi
  45db55:	je     45e337 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xa47>
  45db5b:	shl    $0x5,%rdi
  45db5f:	mov    (%rsp),%rax
  45db63:	mov    %rdi,0x38(%rsp)
  45db68:	lea    (%rax,%rdi,1),%r14
  45db6c:	mov    %rdx,%rax
  45db6f:	and    $0xffffffffffffff80,%rax
  45db73:	mov    %rax,0x48(%rsp)
  45db78:	mov    %rsi,0x50(%rsp)
  45db7d:	mov    %rsi,0x30(%rsp)
  45db82:	lea    0x20(%r14),%rax
  45db86:	mov    %rax,0x58(%rsp)
  45db8b:	shr    $0x7,%rdx
  45db8f:	mov    $0x33,%al
  45db91:	mov    %rdx,0x40(%rsp)
  45db96:	bzhi   %rax,%rdx,%rax
  45db9b:	mov    %rax,0x60(%rsp)
  45dba0:	xor    %eax,%eax
  45dba2:	mov    %r14,0x28(%rsp)
  45dba7:	xor    %r10d,%r10d
  45dbaa:	nopw   0x0(%rax,%rax,1)
  45dbb0:	cmp    0x60(%rsp),%rax
  45dbb5:	je     45dec5 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x5d5>
  45dbbb:	mov    %rax,0x18(%rsp)
  45dbc0:	mov    %rax,%rcx
  45dbc3:	shl    $0xc,%rcx
  45dbc7:	mov    0x28(%rsp),%rax
  45dbcc:	add    %rcx,%rax
  45dbcf:	mov    %rax,0x68(%rsp)
  45dbd4:	add    0x58(%rsp),%rcx
  45dbd9:	mov    %rcx,0x70(%rsp)
  45dbde:	kmovd  %r10d,%k0
  45dbe3:	kshiftlb $0x7,%k0,%k0
  45dbe9:	kshiftrb $0x7,%k0,%k0
  45dbef:	mov    $0x20,%r15d
  45dbf5:	movq   $0x0,0x10(%rsp)
  45dbfe:	xor    %edi,%edi
  45dc00:	xor    %r10d,%r10d
  45dc03:	xor    %esi,%esi
  45dc05:	data16 cs nopw 0x0(%rax,%rax,1)
  45dc10:	mov    -0x20(%r14,%r15,1),%rbp
  45dc15:	mov    -0x18(%r14,%r15,1),%r13
  45dc1a:	mov    0x28(%r14,%r15,1),%rcx
  45dc1f:	mov    0x8(%r14,%r15,1),%rdx
  45dc24:	mov    0x20(%r14,%r15,1),%r9
  45dc29:	mov    (%r14,%r15,1),%r8
  45dc2d:	cmp    %r9,%r8
  45dc30:	mov    %rdx,%rax
  45dc33:	sbb    %rcx,%rax
  45dc36:	mov    %rdx,%rax
  45dc39:	cmovb  %rcx,%rax
  45dc3d:	mov    %r8,%r12
  45dc40:	cmovb  %r9,%r12
  45dc44:	cmp    %r8,%rbp
  45dc47:	mov    %r14,%r11
  45dc4a:	mov    %r13,%r14
  45dc4d:	sbb    %rdx,%r14
  45dc50:	mov    %r13,%r14
  45dc53:	cmovb  %rdx,%r14
  45dc57:	mov    %rdi,%rbx
  45dc5a:	mov    %rbp,%rdi
  45dc5d:	cmovb  %r8,%rdi
  45dc61:	xor    %rbp,%rdi
  45dc64:	or     %rdi,0x10(%rsp)
  45dc69:	mov    %rbx,%rdi
  45dc6c:	xor    %r13,%r14
  45dc6f:	or     %r14,%rdi
  45dc72:	mov    %r11,%r14
  45dc75:	xor    %r8,%r12
  45dc78:	or     %r12,%r10
  45dc7b:	xor    %rdx,%rax
  45dc7e:	or     %rax,%rsi
  45dc81:	xor    %rdx,%rcx
  45dc84:	xor    %r8,%r9
  45dc87:	or     %rcx,%r9
  45dc8a:	sete   %al
  45dc8d:	xor    %rdx,%r13
  45dc90:	xor    %r8,%rbp
  45dc93:	or     %r13,%rbp
  45dc96:	kmovd  %eax,%k1
  45dc9a:	sete   %al
  45dc9d:	kmovd  %eax,%k2
  45dca1:	kshiftlb $0x1,%k1,%k1
  45dca7:	kshiftlb $0x7,%k2,%k2
  45dcad:	kshiftrb $0x7,%k2,%k2
  45dcb3:	korw   %k1,%k2,%k1
  45dcb7:	korw   %k1,%k0,%k0
  45dcbb:	add    $0x40,%r15
  45dcbf:	cmp    $0xfe0,%r15
  45dcc6:	jne    45dc10 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x320>
  45dccc:	kmovd  %k0,%eax
  45dcd0:	test   $0x3,%al
  45dcd2:	setne  %r15b
  45dcd6:	or     %rsi,%rdi
  45dcd9:	mov    0x68(%rsp),%r9
  45dcde:	vmovdqa 0xfc0(%r9),%xmm0
  45dce7:	mov    0x10(%rsp),%rbx
  45dcec:	or     %r10,%rbx
  45dcef:	mov    0xfc0(%r9),%rdx
  45dcf6:	mov    0xfc8(%r9),%rsi
  45dcfd:	mov    0x70(%rsp),%r8
  45dd02:	mov    0xfc0(%r8),%rcx
  45dd09:	mov    0xfc8(%r8),%rax
  45dd10:	cmp    %rcx,%rdx
  45dd13:	mov    %rdi,%r11
  45dd16:	mov    %rsi,%rdi
  45dd19:	sbb    %rax,%rdi
  45dd1c:	cmovae %rdx,%rcx
  45dd20:	cmovae %rsi,%rax
  45dd24:	xor    %rsi,%rax
  45dd27:	vpxor  0xfc0(%r8),%xmm0,%xmm0
  45dd30:	xor    %rdx,%rcx
  45dd33:	vptest %xmm0,%xmm0
  45dd38:	sete   %dl
  45dd3b:	vmovdqa 0xfe0(%r9),%xmm0
  45dd44:	vpxor  0xfe0(%r8),%xmm0,%xmm0
  45dd4d:	vptest %xmm0,%xmm0
  45dd52:	sete   %r10b
  45dd56:	or     %dl,%r10b
  45dd59:	mov    0xfe8(%r9),%rdx
  45dd60:	mov    0xfe0(%r9),%rsi
  45dd67:	mov    0xfe8(%r8),%rdi
  45dd6e:	mov    0xfe0(%r8),%r8
  45dd75:	cmp    %r8,%rsi
  45dd78:	mov    %rdx,%r9
  45dd7b:	sbb    %rdi,%r9
  45dd7e:	cmovae %rdx,%rdi
  45dd82:	cmovae %rsi,%r8
  45dd86:	xor    %rsi,%r8
  45dd89:	or     %rcx,%r8
  45dd8c:	or     %rbx,%r8
  45dd8f:	xor    %rdx,%rdi
  45dd92:	or     %rax,%rdi
  45dd95:	or     %r11,%rdi
  45dd98:	or     %r15b,%r10b
  45dd9b:	mov    0x18(%rsp),%rax
  45dda0:	inc    %rax
  45dda3:	add    $0x1000,%r14
  45ddaa:	or     %r8,%rdi
  45ddad:	je     45dbb0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x2c0>
  45ddb3:	jmp    45debd <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x5cd>
  45ddb8:	inc    %r15
  45ddbb:	shl    $0x7,%r8
  45ddbf:	lea    (%r15,%r8,1),%rax
  45ddc3:	inc    %rax
  45ddc6:	mov    %rax,0x8(%rsp)
  45ddcb:	cmp    %rdx,%rdi
  45ddce:	mov    %rsi,%rax
  45ddd1:	sbb    %rcx,%r14
  45ddd4:	jb     45db3b <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x24b>
  45ddda:	mov    0x8(%rsp),%r8
  45dddf:	sub    %r8,%rax
  45dde2:	jb     45e324 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xa34>
  45dde8:	dec    %rax
  45ddeb:	sub    %r8,%rsi
  45ddee:	je     45e34b <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xa5b>
  45ddf4:	mov    %rax,%rdx
  45ddf7:	and    $0xffffffffffffff80,%rdx
  45ddfb:	shr    $0x7,%rax
  45ddff:	mov    $0x33,%cl
  45de01:	bzhi   %rcx,%rax,%rcx
  45de06:	shl    $0x5,%r8
  45de0a:	mov    (%rsp),%rdi
  45de0e:	mov    %r8,0x8(%rsp)
  45de13:	add    %r8,%rdi
  45de16:	add    $0x40,%rdi
  45de1a:	xor    %r8d,%r8d
  45de1d:	nopl   (%rax)
  45de20:	cmp    %rcx,%r8
  45de23:	je     45deec <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x5fc>
  45de29:	xor    %r11d,%r11d
  45de2c:	xor    %r10d,%r10d
  45de2f:	xor    %ebx,%ebx
  45de31:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  45de40:	mov    -0x40(%rdi,%r11,1),%r14
  45de45:	mov    -0x38(%rdi,%r11,1),%r15
  45de4a:	mov    -0x18(%rdi,%r11,1),%r9
  45de4f:	mov    -0x20(%rdi,%r11,1),%r12
  45de54:	cmp    %r14,%r12
  45de57:	mov    %r9,%r13
  45de5a:	sbb    %r15,%r13
  45de5d:	mov    %r14,%r13
  45de60:	cmovb  %r12,%r13
  45de64:	mov    %r15,%rbp
  45de67:	cmovb  %r9,%rbp
  45de6b:	xor    %r15,%rbp
  45de6e:	or     %rbx,%rbp
  45de71:	xor    %r14,%r13
  45de74:	or     %r10,%r13
  45de77:	mov    0x8(%rdi,%r11,1),%rbx
  45de7c:	mov    (%rdi,%r11,1),%r10
  45de80:	cmp    %r12,%r10
  45de83:	mov    %rbx,%r14
  45de86:	sbb    %r9,%r14
  45de89:	cmovae %r9,%rbx
  45de8d:	cmovae %r12,%r10
  45de91:	xor    %r12,%r10
  45de94:	or     %r13,%r10
  45de97:	xor    %r9,%rbx
  45de9a:	or     %rbp,%rbx
  45de9d:	add    $0x40,%r11
  45dea1:	cmp    $0x1000,%r11
  45dea8:	jne    45de40 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x550>
  45deaa:	inc    %r8
  45dead:	add    $0x1000,%rdi
  45deb4:	or     %rbx,%r10
  45deb7:	je     45de20 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x530>
  45debd:	xor    %r8d,%r8d
  45dec0:	jmp    45e2e9 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9f9>
  45dec5:	mov    0x50(%rsp),%r11
  45deca:	mov    0x48(%rsp),%rdi
  45decf:	sub    %rdi,%r11
  45ded2:	mov    (%rsp),%rax
  45ded6:	jb     45e35f <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xa6f>
  45dedc:	cmp    $0x2,%r11
  45dee0:	jae    45df3b <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x64b>
  45dee2:	mov    0x20(%rsp),%r8
  45dee7:	jmp    45dfae <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x6be>
  45deec:	cmp    %rsi,%rdx
  45deef:	ja     45e374 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xa84>
  45def5:	shl    $0xc,%rax
  45def9:	add    0x8(%rsp),%rax
  45defe:	mov    (%rsp),%rcx
  45df02:	add    %rcx,%rax
  45df05:	add    $0x20,%rax
  45df09:	sub    %rdx,%rsi
  45df0c:	inc    %rsi
  45df0f:	nop
  45df10:	dec    %rsi
  45df13:	cmp    $0x2,%rsi
  45df17:	setb   %r8b
  45df1b:	jb     45e2e9 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9f9>
  45df21:	mov    (%rax),%rcx
  45df24:	mov    0x8(%rax),%rdx
  45df28:	cmp    -0x20(%rax),%rcx
  45df2c:	sbb    -0x18(%rax),%rdx
  45df30:	lea    0x20(%rax),%rax
  45df34:	jae    45df10 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x620>
  45df36:	jmp    45e2e9 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9f9>
  45df3b:	shl    $0x5,%rdi
  45df3f:	mov    0x28(%rsp),%rdx
  45df44:	mov    (%rdx,%rdi,1),%rcx
  45df48:	mov    0x8(%rdx,%rdi,1),%rdx
  45df4d:	inc    %r11
  45df50:	mov    0x40(%rsp),%rsi
  45df55:	shl    $0xc,%rsi
  45df59:	add    0x38(%rsp),%rsi
  45df5e:	add    %rsi,%rax
  45df61:	add    $0x20,%rax
  45df65:	mov    0x20(%rsp),%r8
  45df6a:	nopw   0x0(%rax,%rax,1)
  45df70:	mov    (%rax),%rsi
  45df73:	mov    0x8(%rax),%rdi
  45df77:	cmp    %rsi,%rcx
  45df7a:	mov    %rdx,%r9
  45df7d:	sbb    %rdi,%r9
  45df80:	jb     45debd <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x5cd>
  45df86:	xor    %rsi,%rcx
  45df89:	xor    %rdi,%rdx
  45df8c:	or     %rcx,%rdx
  45df8f:	sete   %cl
  45df92:	or     %cl,%r10b
  45df95:	mov    %r11,%r9
  45df98:	dec    %r9
  45df9b:	add    $0x20,%rax
  45df9f:	mov    %rsi,%rcx
  45dfa2:	mov    %rdi,%rdx
  45dfa5:	mov    %r9,%r11
  45dfa8:	cmp    $0x3,%r9
  45dfac:	jae    45df70 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x680>
  45dfae:	mov    %r8,%rsi
  45dfb1:	shr    $1,%rsi
  45dfb4:	mov    %r8,%rdx
  45dfb7:	shl    $0x5,%rdx
  45dfbb:	lea    -0x1(%rsi),%rax
  45dfbf:	mov    %esi,%ecx
  45dfc1:	and    $0x3,%ecx
  45dfc4:	cmp    $0x3,%rax
  45dfc8:	jae    45dfd1 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x6e1>
  45dfca:	xor    %edi,%edi
  45dfcc:	jmp    45e0ac <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x7bc>
  45dfd1:	mov    (%rsp),%rdi
  45dfd5:	lea    (%rdi,%rdx,1),%r11
  45dfd9:	movabs $0x1fffffffffffffc,%rax
  45dfe3:	and    %rax,%rsi
  45dfe6:	lea    0x60(%rdi),%rbx
  45dfea:	lea    (%rdx,%rdi,1),%r14
  45dfee:	add    $0xffffffffffffffe0,%r14
  45dff2:	xor    %edi,%edi
  45dff4:	movabs $0x7fffffffffffffe,%rax
  45dffe:	movabs $0x7fffffffffffffd,%r15
  45e008:	movabs $0x7fffffffffffffc,%r12
  45e012:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  45e020:	vmovups -0x60(%rbx),%ymm0
  45e025:	vmovups (%r14),%ymm1
  45e02a:	vmovups %ymm1,-0x60(%rbx)
  45e02f:	vmovups %ymm0,(%r14)
  45e034:	mov    %rdi,%r9
  45e037:	xor    %rax,%r9
  45e03a:	shl    $0x5,%r9
  45e03e:	vmovups -0x40(%rbx),%ymm0
  45e043:	vmovups (%r11,%r9,1),%ymm1
  45e049:	vmovups %ymm1,-0x40(%rbx)
  45e04e:	vmovups %ymm0,(%r11,%r9,1)
  45e054:	mov    %rdi,%r9
  45e057:	xor    %r15,%r9
  45e05a:	shl    $0x5,%r9
  45e05e:	vmovups -0x20(%rbx),%ymm0
  45e063:	vmovups (%r11,%r9,1),%ymm1
  45e069:	vmovups %ymm1,-0x20(%rbx)
  45e06e:	vmovups %ymm0,(%r11,%r9,1)
  45e074:	mov    %rdi,%r9
  45e077:	xor    %r12,%r9
  45e07a:	shl    $0x5,%r9
  45e07e:	vmovdqu (%rbx),%ymm0
  45e082:	vmovups (%r11,%r9,1),%ymm1
  45e088:	vmovups %ymm1,(%rbx)
  45e08c:	vmovdqu %ymm0,(%r11,%r9,1)
  45e092:	add    $0x4,%rdi
  45e096:	sub    $0xffffffffffffff80,%rbx
  45e09a:	add    $0xffffffffffffff80,%r14
  45e09e:	cmp    %rdi,%rsi
  45e0a1:	jne    45e020 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x730>
  45e0a7:	test   %rcx,%rcx
  45e0aa:	je     45e0ef <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x7ff>
  45e0ac:	shl    $0x5,%rdi
  45e0b0:	mov    (%rsp),%rsi
  45e0b4:	lea    (%rsi,%rdi,1),%rax
  45e0b8:	sub    %rdi,%rdx
  45e0bb:	add    %rsi,%rdx
  45e0be:	add    $0xffffffffffffffe0,%rdx
  45e0c2:	shl    $0x5,%ecx
  45e0c5:	xor    %esi,%esi
  45e0c7:	nopw   0x0(%rax,%rax,1)
  45e0d0:	vmovdqu (%rax,%rsi,1),%ymm0
  45e0d5:	vmovups (%rdx),%ymm1
  45e0d9:	vmovups %ymm1,(%rax,%rsi,1)
  45e0de:	vmovdqu %ymm0,(%rdx)
  45e0e2:	add    $0x20,%rsi
  45e0e6:	add    $0xffffffffffffffe0,%rdx
  45e0ea:	cmp    %rsi,%rcx
  45e0ed:	jne    45e0d0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x7e0>
  45e0ef:	cmpq   $0x2,0x8(%rsp)
  45e0f5:	setae  %al
  45e0f8:	or     %r10b,%al
  45e0fb:	test   $0x1,%al
  45e0fd:	je     45e2e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9f6>
  45e103:	mov    (%rsp),%rax
  45e107:	lea    0x20(%rax),%rcx
  45e10b:	lea    0x60(%rax),%rdx
  45e10f:	mov    %rdx,0x18(%rsp)
  45e114:	lea    -0x20(%rax),%rdx
  45e118:	mov    %rdx,0x10(%rsp)
  45e11d:	xor    %esi,%esi
  45e11f:	movabs $0x7fffffffffffffe,%r11
  45e129:	movabs $0x7fffffffffffffd,%rbx
  45e133:	movabs $0x7fffffffffffffc,%r14
  45e13d:	jmp    45e14d <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x85d>
  45e13f:	nop
  45e140:	cmp    %r8,%rsi
  45e143:	mov    (%rsp),%rax
  45e147:	jae    45e2e6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9f6>
  45e14d:	mov    %rsi,%rdx
  45e150:	mov    %rsi,%r15
  45e153:	shl    $0x5,%r15
  45e157:	mov    %rax,%rdi
  45e15a:	mov    (%rax,%r15,1),%rax
  45e15e:	mov    0x8(%rdi,%r15,1),%r9
  45e163:	lea    0x1(%rsi),%rdi
  45e167:	cmp    %rdi,%r8
  45e16a:	cmova  %r8,%rdi
  45e16e:	lea    -0x1(%rdi),%r12
  45e172:	lea    (%rcx,%r15,1),%r13
  45e176:	cs nopw 0x0(%rax,%rax,1)
  45e180:	cmp    %rsi,%r12
  45e183:	je     45e1b0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x8c0>
  45e185:	inc    %rsi
  45e188:	mov    0x0(%r13),%rbp
  45e18c:	xor    %rax,%rbp
  45e18f:	mov    0x8(%r13),%r10
  45e193:	xor    %r9,%r10
  45e196:	add    $0x20,%r13
  45e19a:	or     %rbp,%r10
  45e19d:	je     45e180 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x890>
  45e19f:	jmp    45e1b3 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x8c3>
  45e1a1:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  45e1b0:	mov    %rdi,%rsi
  45e1b3:	mov    %rsi,%rax
  45e1b6:	sub    %rdx,%rax
  45e1b9:	jb     45e2fe <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0xa0e>
  45e1bf:	mov    %rax,%rdi
  45e1c2:	shr    $1,%rdi
  45e1c5:	je     45e140 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x850>
  45e1cb:	mov    %rsi,%rdx
  45e1ce:	shl    $0x5,%rdx
  45e1d2:	mov    %edi,%r12d
  45e1d5:	and    $0x3,%r12d
  45e1d9:	cmp    $0x8,%rax
  45e1dd:	jae    45e1f0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x900>
  45e1df:	xor    %r13d,%r13d
  45e1e2:	jmp    45e2a6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9b6>
  45e1e7:	nopw   0x0(%rax,%rax,1)
  45e1f0:	mov    (%rsp),%rax
  45e1f4:	lea    (%rax,%rdx,1),%rbp
  45e1f8:	and    $0xfffffffffffffffc,%rdi
  45e1fc:	mov    0x18(%rsp),%rax
  45e201:	add    %r15,%rax
  45e204:	mov    0x10(%rsp),%r9
  45e209:	add    %rdx,%r9
  45e20c:	xor    %r13d,%r13d
  45e20f:	nop
  45e210:	vmovups -0x60(%rax),%ymm0
  45e215:	vmovups (%r9),%ymm1
  45e21a:	vmovups %ymm1,-0x60(%rax)
  45e21f:	vmovups %ymm0,(%r9)
  45e224:	mov    %r13,%r10
  45e227:	xor    %r11,%r10
  45e22a:	shl    $0x5,%r10
  45e22e:	vmovups -0x40(%rax),%ymm0
  45e233:	vmovups 0x0(%rbp,%r10,1),%ymm1
  45e23a:	vmovups %ymm1,-0x40(%rax)
  45e23f:	vmovups %ymm0,0x0(%rbp,%r10,1)
  45e246:	mov    %r13,%r10
  45e249:	xor    %rbx,%r10
  45e24c:	shl    $0x5,%r10
  45e250:	vmovups -0x20(%rax),%ymm0
  45e255:	vmovups 0x0(%rbp,%r10,1),%ymm1
  45e25c:	vmovups %ymm1,-0x20(%rax)
  45e261:	vmovups %ymm0,0x0(%rbp,%r10,1)
  45e268:	mov    %r13,%r10
  45e26b:	xor    %r14,%r10
  45e26e:	shl    $0x5,%r10
  45e272:	vmovdqu (%rax),%ymm0
  45e276:	vmovups 0x0(%rbp,%r10,1),%ymm1
  45e27d:	vmovups %ymm1,(%rax)
  45e281:	vmovdqu %ymm0,0x0(%rbp,%r10,1)
  45e288:	add    $0x4,%r13
  45e28c:	sub    $0xffffffffffffff80,%rax
  45e290:	add    $0xffffffffffffff80,%r9
  45e294:	cmp    %r13,%rdi
  45e297:	jne    45e210 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x920>
  45e29d:	test   %r12,%r12
  45e2a0:	je     45e140 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x850>
  45e2a6:	shl    $0x5,%r13
  45e2aa:	add    (%rsp),%r15
  45e2ae:	add    %r13,%r15
  45e2b1:	sub    %r13,%rdx
  45e2b4:	add    0x10(%rsp),%rdx
  45e2b9:	shl    $0x5,%r12d
  45e2bd:	xor    %eax,%eax
  45e2bf:	nop
  45e2c0:	vmovdqu (%r15,%rax,1),%ymm0
  45e2c6:	vmovups (%rdx),%ymm1
  45e2ca:	vmovups %ymm1,(%r15,%rax,1)
  45e2d0:	vmovdqu %ymm0,(%rdx)
  45e2d4:	add    $0x20,%rax
  45e2d8:	add    $0xffffffffffffffe0,%rdx
  45e2dc:	cmp    %rax,%r12
  45e2df:	jne    45e2c0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x9d0>
  45e2e1:	jmp    45e140 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x850>
  45e2e6:	mov    $0x1,%r8b
  45e2e9:	mov    %r8d,%eax
  45e2ec:	add    $0x78,%rsp
  45e2f0:	pop    %rbx
  45e2f1:	pop    %r12
  45e2f3:	pop    %r13
  45e2f5:	pop    %r14
  45e2f7:	pop    %r15
  45e2f9:	pop    %rbp
  45e2fa:	vzeroupper
  45e2fd:	ret
  45e2fe:	lea    0x5a5a3(%rip),%rcx        # 4b88a8 <anon.005357b6259aec7dbb5efeaf9c6c1e46.1.llvm.5840278210049151275>
  45e305:	mov    %rdx,%rdi
  45e308:	mov    %r8,%rdx
  45e30b:	vzeroupper
  45e30e:	call   *0x5ce44(%rip)        # 4bb158 <_DYNAMIC+0x260>
  45e314:	lea    0x5a885(%rip),%rcx        # 4b8ba0 <anon.fc147e135d8089a06b86996a95238ad4.1.llvm.1002553242461103667+0x190>
  45e31b:	mov    %rsi,%rdx
  45e31e:	call   *0x5ce34(%rip)        # 4bb158 <_DYNAMIC+0x260>
  45e324:	lea    0x5a85d(%rip),%rcx        # 4b8b88 <anon.fc147e135d8089a06b86996a95238ad4.1.llvm.1002553242461103667+0x178>
  45e32b:	mov    %r8,%rdi
  45e32e:	mov    %rsi,%rdx
  45e331:	call   *0x5ce21(%rip)        # 4bb158 <_DYNAMIC+0x260>
  45e337:	lea    0x5a87a(%rip),%rcx        # 4b8bb8 <anon.fc147e135d8089a06b86996a95238ad4.1.llvm.1002553242461103667+0x1a8>
  45e33e:	xor    %edi,%edi
  45e340:	mov    %rdx,%rsi
  45e343:	xor    %edx,%edx
  45e345:	call   *0x5ce0d(%rip)        # 4bb158 <_DYNAMIC+0x260>
  45e34b:	lea    0x5a866(%rip),%rcx        # 4b8bb8 <anon.fc147e135d8089a06b86996a95238ad4.1.llvm.1002553242461103667+0x1a8>
  45e352:	xor    %edi,%edi
  45e354:	mov    %rax,%rsi
  45e357:	xor    %edx,%edx
  45e359:	call   *0x5cdf9(%rip)        # 4bb158 <_DYNAMIC+0x260>
  45e35f:	lea    0x5a86a(%rip),%rcx        # 4b8bd0 <anon.fc147e135d8089a06b86996a95238ad4.1.llvm.1002553242461103667+0x1c0>
  45e366:	mov    0x30(%rsp),%rdx
  45e36b:	mov    %rdx,%rsi
  45e36e:	call   *0x5cde4(%rip)        # 4bb158 <_DYNAMIC+0x260>
  45e374:	lea    0x5a855(%rip),%rcx        # 4b8bd0 <anon.fc147e135d8089a06b86996a95238ad4.1.llvm.1002553242461103667+0x1c0>
  45e37b:	mov    %rdx,%rdi
  45e37e:	mov    %rsi,%rdx
  45e381:	call   *0x5cdd1(%rip)        # 4bb158 <_DYNAMIC+0x260>

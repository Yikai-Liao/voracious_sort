
experiments/block_msd/target/pa-order-count/time:     file format elf64-x86-64


Disassembly of section .text:

000000000032cbc0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>>:
  32cbc0:	push   %rbp
  32cbc1:	push   %r15
  32cbc3:	push   %r14
  32cbc5:	push   %r13
  32cbc7:	push   %r12
  32cbc9:	push   %rbx
  32cbca:	sub    $0x48,%rsp
  32cbce:	mov    $0x1,%r8b
  32cbd1:	cmp    $0x2,%rsi
  32cbd5:	jb     32d5c9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa09>
  32cbdb:	mov    (%rdi),%rdx
  32cbde:	mov    %rdi,(%rsp)
  32cbe2:	mov    0x8(%rdi),%rcx
  32cbe6:	lea    -0x1(%rsi),%r9
  32cbea:	movabs $0x7ffffffffffff80,%r10
  32cbf4:	and    %r9,%r10
  32cbf7:	je     32cd94 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x1d4>
  32cbfd:	mov    (%rsp),%rax
  32cc01:	lea    0x10(%rax),%r11
  32cc05:	lea    -0x80(%r10),%rbx
  32cc09:	shr    $0x7,%rbx
  32cc0d:	xor    %r8d,%r8d
  32cc10:	jmp    32cc34 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x74>
  32cc12:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  32cc20:	add    $0x800,%r11
  32cc27:	cmp    %rbx,%r8
  32cc2a:	lea    0x1(%r8),%r8
  32cc2e:	je     32cd94 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x1d4>
  32cc34:	xor    %r15d,%r15d
  32cc37:	xor    %eax,%eax
  32cc39:	xor    %r14d,%r14d
  32cc3c:	nopl   0x0(%rax)
  32cc40:	mov    (%r11,%r14,1),%rdi
  32cc44:	xor    %rdx,%rdi
  32cc47:	or     %r15,%rdi
  32cc4a:	mov    0x8(%r11,%r14,1),%r15
  32cc4f:	xor    %rcx,%r15
  32cc52:	or     %rax,%r15
  32cc55:	mov    0x18(%r11,%r14,1),%r12
  32cc5a:	xor    %rcx,%r12
  32cc5d:	mov    0x10(%r11,%r14,1),%r13
  32cc62:	xor    %rdx,%r13
  32cc65:	mov    0x20(%r11,%r14,1),%rax
  32cc6a:	xor    %rdx,%rax
  32cc6d:	or     %r13,%rax
  32cc70:	or     %rdi,%rax
  32cc73:	mov    0x28(%r11,%r14,1),%r13
  32cc78:	xor    %rcx,%r13
  32cc7b:	or     %r12,%r13
  32cc7e:	or     %r15,%r13
  32cc81:	mov    0x38(%r11,%r14,1),%rdi
  32cc86:	xor    %rcx,%rdi
  32cc89:	mov    0x30(%r11,%r14,1),%r15
  32cc8e:	xor    %rdx,%r15
  32cc91:	mov    0x40(%r11,%r14,1),%rbp
  32cc96:	xor    %rdx,%rbp
  32cc99:	or     %r15,%rbp
  32cc9c:	mov    0x48(%r11,%r14,1),%r15
  32cca1:	xor    %rcx,%r15
  32cca4:	or     %rdi,%r15
  32cca7:	mov    0x58(%r11,%r14,1),%rdi
  32ccac:	xor    %rcx,%rdi
  32ccaf:	or     %r15,%rdi
  32ccb2:	or     %r13,%rdi
  32ccb5:	mov    0x50(%r11,%r14,1),%r12
  32ccba:	xor    %rdx,%r12
  32ccbd:	or     %rbp,%r12
  32ccc0:	or     %rax,%r12
  32ccc3:	mov    0x60(%r11,%r14,1),%r13
  32ccc8:	xor    %rdx,%r13
  32cccb:	mov    0x68(%r11,%r14,1),%rbp
  32ccd0:	xor    %rcx,%rbp
  32ccd3:	mov    0x78(%r11,%r14,1),%rax
  32ccd8:	mov    0x70(%r11,%r14,1),%r15
  32ccdd:	add    $0x80,%r14
  32cce4:	xor    %rcx,%rax
  32cce7:	or     %rbp,%rax
  32ccea:	or     %rdi,%rax
  32cced:	xor    %rdx,%r15
  32ccf0:	or     %r13,%r15
  32ccf3:	or     %r12,%r15
  32ccf6:	cmp    $0x800,%r14
  32ccfd:	jne    32cc40 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x80>
  32cd03:	or     %rax,%r15
  32cd06:	je     32cc20 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x60>
  32cd0c:	xor    %eax,%eax
  32cd0e:	xor    %r12d,%r12d
  32cd11:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  32cd20:	mov    (%r11,%rax,1),%r14
  32cd24:	mov    0x8(%r11,%rax,1),%r15
  32cd29:	mov    %r15,%rdi
  32cd2c:	xor    %rcx,%rdi
  32cd2f:	mov    %r14,%r13
  32cd32:	xor    %rdx,%r13
  32cd35:	or     %rdi,%r13
  32cd38:	jne    32cff8 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x438>
  32cd3e:	mov    0x10(%r11,%rax,1),%r14
  32cd43:	mov    0x18(%r11,%rax,1),%r15
  32cd48:	mov    %r15,%rdi
  32cd4b:	xor    %rcx,%rdi
  32cd4e:	mov    %r14,%r13
  32cd51:	xor    %rdx,%r13
  32cd54:	or     %rdi,%r13
  32cd57:	jne    32cff5 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x435>
  32cd5d:	cmp    $0x7e0,%rax
  32cd63:	je     32cc20 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x60>
  32cd69:	mov    0x20(%r11,%rax,1),%r14
  32cd6e:	mov    0x28(%r11,%rax,1),%r15
  32cd73:	add    $0x30,%rax
  32cd77:	add    $0x3,%r12
  32cd7b:	mov    %r15,%rdi
  32cd7e:	xor    %rcx,%rdi
  32cd81:	mov    %r14,%r13
  32cd84:	xor    %rdx,%r13
  32cd87:	or     %rdi,%r13
  32cd8a:	je     32cd20 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x160>
  32cd8c:	dec    %r12
  32cd8f:	jmp    32cff8 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x438>
  32cd94:	shl    $0x4,%r10
  32cd98:	mov    (%rsp),%rax
  32cd9c:	add    %r10,%rax
  32cd9f:	add    $0x10,%rax
  32cda3:	and    $0x7f,%r9d
  32cda7:	mov    %r9d,%edi
  32cdaa:	shl    $0x4,%edi
  32cdad:	not    %r9
  32cdb0:	add    %rsi,%r9
  32cdb3:	xor    %r8d,%r8d
  32cdb6:	cs nopw 0x0(%rax,%rax,1)
  32cdc0:	cmp    %r8,%rdi
  32cdc3:	je     32d5c6 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa06>
  32cdc9:	mov    (%rax,%r8,1),%r14
  32cdcd:	mov    0x8(%rax,%r8,1),%r15
  32cdd2:	mov    %r15,%r10
  32cdd5:	xor    %rcx,%r10
  32cdd8:	mov    %r14,%r11
  32cddb:	xor    %rdx,%r11
  32cdde:	add    $0x10,%r8
  32cde2:	inc    %r9
  32cde5:	or     %r10,%r11
  32cde8:	je     32cdc0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x200>
  32cdea:	cmp    %rdx,%r14
  32cded:	mov    %rsi,%rax
  32cdf0:	sbb    %rcx,%r15
  32cdf3:	jae    32d012 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x452>
  32cdf9:	sub    %r9,%rax
  32cdfc:	jb     32d5ee <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa2e>
  32ce02:	mov    %rsi,%rcx
  32ce05:	lea    -0x1(%rax),%rsi
  32ce09:	mov    %rcx,0x8(%rsp)
  32ce0e:	mov    %rcx,%rax
  32ce11:	sub    %r9,%rax
  32ce14:	je     32d614 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa54>
  32ce1a:	mov    %r9,%rdx
  32ce1d:	shl    $0x4,%rdx
  32ce21:	mov    (%rsp),%rcx
  32ce25:	lea    (%rcx,%rdx,1),%rdi
  32ce29:	mov    %rdi,0x28(%rsp)
  32ce2e:	mov    %rsi,%rdi
  32ce31:	and    $0xffffffffffffff80,%rdi
  32ce35:	mov    %rdi,0x40(%rsp)
  32ce3a:	mov    %rax,0x18(%rsp)
  32ce3f:	mov    %rax,0x20(%rsp)
  32ce44:	shr    $0x7,%rsi
  32ce48:	mov    $0x34,%al
  32ce4a:	mov    %rsi,0x38(%rsp)
  32ce4f:	bzhi   %rax,%rsi,%rax
  32ce54:	mov    %rax,0x10(%rsp)
  32ce59:	mov    %rdx,0x30(%rsp)
  32ce5e:	lea    (%rdx,%rcx,1),%r12
  32ce62:	add    $0x30,%r12
  32ce66:	xor    %r13d,%r13d
  32ce69:	xor    %r10d,%r10d
  32ce6c:	nopl   0x0(%rax)
  32ce70:	cmp    0x10(%rsp),%r13
  32ce75:	je     32d1cf <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x60f>
  32ce7b:	kmovd  %r10d,%k0
  32ce80:	kshiftlb $0x7,%k0,%k0
  32ce86:	kshiftrb $0x7,%k0,%k0
  32ce8c:	kxorw  %k0,%k0,%k1
  32ce90:	vpxor  %xmm0,%xmm0,%xmm0
  32ce94:	xor    %r10d,%r10d
  32ce97:	vpxor  %xmm1,%xmm1,%xmm1
  32ce9b:	nopl   0x0(%rax,%rax,1)
  32cea0:	mov    -0x30(%r12,%r10,1),%r15
  32cea5:	mov    -0x28(%r12,%r10,1),%rsi
  32ceaa:	mov    -0x10(%r12,%r10,1),%rbp
  32ceaf:	mov    -0x8(%r12,%r10,1),%r14
  32ceb4:	mov    -0x18(%r12,%r10,1),%rcx
  32ceb9:	mov    -0x20(%r12,%r10,1),%rax
  32cebe:	mov    0x18(%r12,%r10,1),%r8
  32cec3:	mov    0x8(%r12,%r10,1),%r11
  32cec8:	mov    0x10(%r12,%r10,1),%rbx
  32cecd:	mov    (%r12,%r10,1),%rdx
  32ced1:	cmp    %rbp,%rax
  32ced4:	mov    %rcx,%rdi
  32ced7:	sbb    %r14,%rdi
  32ceda:	mov    $0x0,%edi
  32cedf:	sbb    %rdi,%rdi
  32cee2:	vmovq  %rdi,%xmm2
  32cee7:	cmp    %rax,%r15
  32ceea:	mov    %rsi,%rdi
  32ceed:	sbb    %rcx,%rdi
  32cef0:	mov    $0x0,%edi
  32cef5:	sbb    %rdi,%rdi
  32cef8:	vmovq  %rdi,%xmm3
  32cefd:	vpunpcklbw %xmm2,%xmm3,%xmm2
  32cf01:	vpsubb %xmm2,%xmm0,%xmm0
  32cf05:	cmp    %rbx,%rdx
  32cf08:	mov    %r11,%rdi
  32cf0b:	sbb    %r8,%rdi
  32cf0e:	mov    $0x0,%edi
  32cf13:	sbb    %rdi,%rdi
  32cf16:	vmovq  %rdi,%xmm2
  32cf1b:	cmp    %rdx,%rbp
  32cf1e:	mov    %r14,%rdi
  32cf21:	sbb    %r11,%rdi
  32cf24:	mov    $0x0,%edi
  32cf29:	sbb    %rdi,%rdi
  32cf2c:	vmovq  %rdi,%xmm3
  32cf31:	vpunpcklbw %xmm2,%xmm3,%xmm2
  32cf35:	vpsubb %xmm2,%xmm1,%xmm1
  32cf39:	xor    %rcx,%rsi
  32cf3c:	xor    %r14,%rcx
  32cf3f:	xor    %rax,%r15
  32cf42:	xor    %rbp,%rax
  32cf45:	or     %rcx,%rax
  32cf48:	sete   %al
  32cf4b:	kmovd  %eax,%k2
  32cf4f:	kshiftlb $0x1,%k2,%k2
  32cf55:	or     %rsi,%r15
  32cf58:	sete   %al
  32cf5b:	kmovd  %eax,%k3
  32cf5f:	kshiftlb $0x7,%k3,%k3
  32cf65:	kshiftrb $0x7,%k3,%k3
  32cf6b:	korw   %k2,%k3,%k2
  32cf6f:	xor    %r11,%r8
  32cf72:	xor    %rdx,%rbx
  32cf75:	or     %r8,%rbx
  32cf78:	sete   %al
  32cf7b:	kmovd  %eax,%k3
  32cf7f:	kshiftlb $0x1,%k3,%k3
  32cf85:	xor    %r11,%r14
  32cf88:	xor    %rdx,%rbp
  32cf8b:	or     %r14,%rbp
  32cf8e:	sete   %al
  32cf91:	kmovd  %eax,%k4
  32cf95:	kshiftlb $0x7,%k4,%k4
  32cf9b:	kshiftrb $0x7,%k4,%k4
  32cfa1:	korw   %k3,%k4,%k3
  32cfa5:	korw   %k2,%k0,%k0
  32cfa9:	korw   %k3,%k1,%k1
  32cfad:	add    $0x40,%r10
  32cfb1:	cmp    $0x800,%r10
  32cfb8:	jne    32cea0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x2e0>
  32cfbe:	vpaddb %xmm0,%xmm1,%xmm0
  32cfc2:	vpsrlw $0x8,%xmm0,%xmm1
  32cfc7:	vpaddb %xmm1,%xmm0,%xmm0
  32cfcb:	vmovd  %xmm0,%eax
  32cfcf:	korw   %k0,%k1,%k0
  32cfd3:	kmovd  %k0,%ecx
  32cfd7:	test   $0x3,%cl
  32cfda:	setne  %r10b
  32cfde:	inc    %r13
  32cfe1:	add    $0x800,%r12
  32cfe8:	test   %al,%al
  32cfea:	je     32ce70 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x2b0>
  32cff0:	jmp    32d1c7 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x607>
  32cff5:	inc    %r12
  32cff8:	shl    $0x7,%r8
  32cffc:	lea    (%r12,%r8,1),%r9
  32d000:	inc    %r9
  32d003:	cmp    %rdx,%r14
  32d006:	mov    %rsi,%rax
  32d009:	sbb    %rcx,%r15
  32d00c:	jb     32cdf9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x239>
  32d012:	sub    %r9,%rax
  32d015:	jb     32d601 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa41>
  32d01b:	dec    %rax
  32d01e:	sub    %r9,%rsi
  32d021:	je     32d625 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa65>
  32d027:	mov    %rax,%rcx
  32d02a:	and    $0xffffffffffffff80,%rcx
  32d02e:	mov    %rcx,0x8(%rsp)
  32d033:	shr    $0x7,%rax
  32d037:	mov    $0x34,%cl
  32d039:	mov    %rax,0x18(%rsp)
  32d03e:	bzhi   %rcx,%rax,%rax
  32d043:	mov    %rax,0x10(%rsp)
  32d048:	shl    $0x4,%r9
  32d04c:	mov    (%rsp),%rax
  32d050:	lea    (%r9,%rax,1),%r8
  32d054:	add    $0x70,%r8
  32d058:	xor    %r10d,%r10d
  32d05b:	nopl   0x0(%rax,%rax,1)
  32d060:	cmp    0x10(%rsp),%r10
  32d065:	je     32d1f2 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x632>
  32d06b:	vpxor  %xmm0,%xmm0,%xmm0
  32d06f:	xor    %r11d,%r11d
  32d072:	vpxor  %xmm1,%xmm1,%xmm1
  32d076:	cs nopw 0x0(%rax,%rax,1)
  32d080:	mov    -0x50(%r8,%r11,1),%rbx
  32d085:	mov    -0x48(%r8,%r11,1),%rdi
  32d08a:	mov    -0x60(%r8,%r11,1),%r14
  32d08f:	mov    -0x58(%r8,%r11,1),%r15
  32d094:	mov    -0x38(%r8,%r11,1),%r12
  32d099:	mov    -0x40(%r8,%r11,1),%r13
  32d09e:	cmp    %r14,%rbx
  32d0a1:	mov    %rdi,%rbp
  32d0a4:	sbb    %r15,%rbp
  32d0a7:	mov    $0x0,%ebp
  32d0ac:	sbb    %rbp,%rbp
  32d0af:	cmp    -0x70(%r8,%r11,1),%r14
  32d0b4:	sbb    -0x68(%r8,%r11,1),%r15
  32d0b9:	vmovq  %rbp,%xmm2
  32d0be:	mov    $0x0,%r14d
  32d0c4:	sbb    %r14,%r14
  32d0c7:	vmovq  %r14,%xmm3
  32d0cc:	vpunpcklbw %xmm2,%xmm3,%xmm2
  32d0d0:	vpsubb %xmm2,%xmm0,%xmm0
  32d0d4:	mov    -0x30(%r8,%r11,1),%r14
  32d0d9:	cmp    %r13,%r14
  32d0dc:	mov    -0x28(%r8,%r11,1),%r15
  32d0e1:	mov    %r15,%rbp
  32d0e4:	sbb    %r12,%rbp
  32d0e7:	mov    $0x0,%ebp
  32d0ec:	sbb    %rbp,%rbp
  32d0ef:	vmovq  %rbp,%xmm2
  32d0f4:	cmp    %rbx,%r13
  32d0f7:	sbb    %rdi,%r12
  32d0fa:	mov    $0x0,%edi
  32d0ff:	sbb    %rdi,%rdi
  32d102:	vmovq  %rdi,%xmm3
  32d107:	vpunpcklbw %xmm2,%xmm3,%xmm2
  32d10b:	vpsubb %xmm2,%xmm1,%xmm1
  32d10f:	mov    -0x10(%r8,%r11,1),%rdi
  32d114:	mov    -0x18(%r8,%r11,1),%rbx
  32d119:	mov    -0x8(%r8,%r11,1),%rcx
  32d11e:	mov    -0x20(%r8,%r11,1),%r13
  32d123:	mov    0x8(%r8,%r11,1),%rbp
  32d128:	mov    0x18(%r8,%r11,1),%rdx
  32d12d:	mov    (%r8,%r11,1),%rax
  32d131:	cmp    %r13,%rdi
  32d134:	mov    %rcx,%r12
  32d137:	sbb    %rbx,%r12
  32d13a:	mov    $0x0,%r12d
  32d140:	sbb    %r12,%r12
  32d143:	vmovq  %r12,%xmm2
  32d148:	cmp    %r14,%r13
  32d14b:	sbb    %r15,%rbx
  32d14e:	mov    $0x0,%ebx
  32d153:	sbb    %rbx,%rbx
  32d156:	vmovq  %rbx,%xmm3
  32d15b:	vpunpcklbw %xmm2,%xmm3,%xmm2
  32d15f:	vpsubb %xmm2,%xmm0,%xmm0
  32d163:	cmp    %rax,0x10(%r8,%r11,1)
  32d168:	sbb    %rbp,%rdx
  32d16b:	mov    $0x0,%edx
  32d170:	sbb    %rdx,%rdx
  32d173:	vmovq  %rdx,%xmm2
  32d178:	cmp    %rdi,%rax
  32d17b:	sbb    %rcx,%rbp
  32d17e:	mov    $0x0,%eax
  32d183:	sbb    %rax,%rax
  32d186:	vmovq  %rax,%xmm3
  32d18b:	vpunpcklbw %xmm2,%xmm3,%xmm2
  32d18f:	vpsubb %xmm2,%xmm1,%xmm1
  32d193:	sub    $0xffffffffffffff80,%r11
  32d197:	cmp    $0x800,%r11
  32d19e:	jne    32d080 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x4c0>
  32d1a4:	vpaddb %xmm0,%xmm1,%xmm0
  32d1a8:	vpsrlw $0x8,%xmm0,%xmm1
  32d1ad:	vpaddb %xmm1,%xmm0,%xmm0
  32d1b1:	vmovd  %xmm0,%eax
  32d1b5:	inc    %r10
  32d1b8:	add    $0x800,%r8
  32d1bf:	test   %al,%al
  32d1c1:	je     32d060 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x4a0>
  32d1c7:	xor    %r8d,%r8d
  32d1ca:	jmp    32d5c9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa09>
  32d1cf:	mov    0x18(%rsp),%rbx
  32d1d4:	mov    0x40(%rsp),%rdi
  32d1d9:	sub    %rdi,%rbx
  32d1dc:	jb     32d639 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa79>
  32d1e2:	cmp    $0x2,%rbx
  32d1e6:	jae    32d24b <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x68b>
  32d1e8:	mov    0x8(%rsp),%r8
  32d1ed:	jmp    32d2b8 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x6f8>
  32d1f2:	mov    0x8(%rsp),%rdi
  32d1f7:	cmp    %rsi,%rdi
  32d1fa:	ja     32d64e <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa8e>
  32d200:	mov    0x18(%rsp),%rcx
  32d205:	shl    $0xb,%rcx
  32d209:	add    %r9,%rcx
  32d20c:	mov    (%rsp),%rax
  32d210:	add    %rcx,%rax
  32d213:	add    $0x10,%rax
  32d217:	sub    %rdi,%rsi
  32d21a:	inc    %rsi
  32d21d:	nopl   (%rax)
  32d220:	dec    %rsi
  32d223:	cmp    $0x2,%rsi
  32d227:	setb   %r8b
  32d22b:	jb     32d5c9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa09>
  32d231:	mov    (%rax),%rcx
  32d234:	mov    0x8(%rax),%rdx
  32d238:	cmp    -0x10(%rax),%rcx
  32d23c:	sbb    -0x8(%rax),%rdx
  32d240:	lea    0x10(%rax),%rax
  32d244:	jae    32d220 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x660>
  32d246:	jmp    32d5c9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa09>
  32d24b:	shl    $0x4,%rdi
  32d24f:	mov    0x28(%rsp),%rax
  32d254:	mov    (%rax,%rdi,1),%rdx
  32d258:	mov    0x8(%rax,%rdi,1),%rsi
  32d25d:	inc    %rbx
  32d260:	mov    0x38(%rsp),%rcx
  32d265:	shl    $0xb,%rcx
  32d269:	add    0x30(%rsp),%rcx
  32d26e:	mov    (%rsp),%rax
  32d272:	add    %rcx,%rax
  32d275:	add    $0x10,%rax
  32d279:	mov    0x8(%rsp),%r8
  32d27e:	xchg   %ax,%ax
  32d280:	mov    (%rax),%rdi
  32d283:	mov    0x8(%rax),%r11
  32d287:	cmp    %rdi,%rdx
  32d28a:	mov    %rsi,%rcx
  32d28d:	sbb    %r11,%rcx
  32d290:	jb     32d1c7 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x607>
  32d296:	xor    %rdi,%rdx
  32d299:	xor    %r11,%rsi
  32d29c:	or     %rdx,%rsi
  32d29f:	sete   %cl
  32d2a2:	or     %cl,%r10b
  32d2a5:	dec    %rbx
  32d2a8:	add    $0x10,%rax
  32d2ac:	mov    %rdi,%rdx
  32d2af:	mov    %r11,%rsi
  32d2b2:	cmp    $0x3,%rbx
  32d2b6:	jae    32d280 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x6c0>
  32d2b8:	mov    %r8,%rsi
  32d2bb:	shr    $1,%rsi
  32d2be:	mov    %r8,%rdx
  32d2c1:	shl    $0x4,%rdx
  32d2c5:	lea    -0x1(%rsi),%rax
  32d2c9:	mov    %esi,%ecx
  32d2cb:	and    $0x3,%ecx
  32d2ce:	cmp    $0x3,%rax
  32d2d2:	jae    32d2dc <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x71c>
  32d2d4:	xor    %r11d,%r11d
  32d2d7:	jmp    32d3a2 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x7e2>
  32d2dc:	mov    (%rsp),%r11
  32d2e0:	lea    (%r11,%rdx,1),%rbx
  32d2e4:	movabs $0x3fffffffffffffc,%rax
  32d2ee:	and    %rax,%rsi
  32d2f1:	lea    0x30(%r11),%rdi
  32d2f5:	lea    (%rdx,%r11,1),%r14
  32d2f9:	add    $0xfffffffffffffff0,%r14
  32d2fd:	xor    %r11d,%r11d
  32d300:	movabs $0xffffffffffffffe,%r15
  32d30a:	movabs $0xffffffffffffffd,%r12
  32d314:	movabs $0xffffffffffffffc,%r13
  32d31e:	xchg   %ax,%ax
  32d320:	vmovaps -0x30(%rdi),%xmm0
  32d325:	vmovaps (%r14),%xmm1
  32d32a:	vmovaps %xmm1,-0x30(%rdi)
  32d32f:	vmovaps %xmm0,(%r14)
  32d334:	mov    %r11,%rax
  32d337:	xor    %r15,%rax
  32d33a:	shl    $0x4,%rax
  32d33e:	vmovaps -0x20(%rdi),%xmm0
  32d343:	vmovaps (%rbx,%rax,1),%xmm1
  32d348:	vmovaps %xmm1,-0x20(%rdi)
  32d34d:	vmovaps %xmm0,(%rbx,%rax,1)
  32d352:	mov    %r11,%rax
  32d355:	xor    %r12,%rax
  32d358:	shl    $0x4,%rax
  32d35c:	vmovaps -0x10(%rdi),%xmm0
  32d361:	vmovaps (%rbx,%rax,1),%xmm1
  32d366:	vmovaps %xmm1,-0x10(%rdi)
  32d36b:	vmovaps %xmm0,(%rbx,%rax,1)
  32d370:	mov    %r11,%rax
  32d373:	xor    %r13,%rax
  32d376:	shl    $0x4,%rax
  32d37a:	vmovdqa (%rdi),%xmm0
  32d37e:	vmovdqa (%rbx,%rax,1),%xmm1
  32d383:	vmovdqa %xmm1,(%rdi)
  32d387:	vmovdqa %xmm0,(%rbx,%rax,1)
  32d38c:	add    $0x4,%r11
  32d390:	add    $0x40,%rdi
  32d394:	add    $0xffffffffffffffc0,%r14
  32d398:	cmp    %r11,%rsi
  32d39b:	jne    32d320 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x760>
  32d39d:	test   %rcx,%rcx
  32d3a0:	je     32d3df <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x81f>
  32d3a2:	shl    $0x4,%r11
  32d3a6:	mov    (%rsp),%rsi
  32d3aa:	lea    (%rsi,%r11,1),%rax
  32d3ae:	sub    %r11,%rdx
  32d3b1:	add    %rsi,%rdx
  32d3b4:	add    $0xfffffffffffffff0,%rdx
  32d3b8:	shl    $0x4,%ecx
  32d3bb:	xor    %esi,%esi
  32d3bd:	nopl   (%rax)
  32d3c0:	vmovdqa (%rax,%rsi,1),%xmm0
  32d3c5:	vmovdqa (%rdx),%xmm1
  32d3c9:	vmovdqa %xmm1,(%rax,%rsi,1)
  32d3ce:	vmovdqa %xmm0,(%rdx)
  32d3d2:	add    $0x10,%rsi
  32d3d6:	add    $0xfffffffffffffff0,%rdx
  32d3da:	cmp    %rsi,%rcx
  32d3dd:	jne    32d3c0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x800>
  32d3df:	cmp    $0x2,%r9
  32d3e3:	setae  %al
  32d3e6:	or     %r10b,%al
  32d3e9:	test   $0x1,%al
  32d3eb:	je     32d5c6 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa06>
  32d3f1:	mov    (%rsp),%rdi
  32d3f5:	lea    0x10(%rdi),%rcx
  32d3f9:	lea    0x30(%rdi),%rax
  32d3fd:	mov    %rax,0x8(%rsp)
  32d402:	lea    -0x10(%rdi),%rax
  32d406:	mov    %rax,0x10(%rsp)
  32d40b:	xor    %esi,%esi
  32d40d:	movabs $0xffffffffffffffe,%r11
  32d417:	movabs $0xffffffffffffffd,%rbx
  32d421:	movabs $0xffffffffffffffc,%r14
  32d42b:	jmp    32d439 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x879>
  32d42d:	nopl   (%rax)
  32d430:	cmp    %r8,%rsi
  32d433:	jae    32d5c6 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa06>
  32d439:	mov    %rsi,%rdx
  32d43c:	mov    %rsi,%r15
  32d43f:	shl    $0x4,%r15
  32d443:	mov    (%rdi,%r15,1),%rax
  32d447:	mov    0x8(%rdi,%r15,1),%r9
  32d44c:	lea    0x1(%rsi),%rdi
  32d450:	cmp    %rdi,%r8
  32d453:	cmova  %r8,%rdi
  32d457:	lea    -0x1(%rdi),%r10
  32d45b:	lea    (%rcx,%r15,1),%r12
  32d45f:	nop
  32d460:	cmp    %rsi,%r10
  32d463:	je     32d490 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8d0>
  32d465:	inc    %rsi
  32d468:	mov    (%r12),%r13
  32d46c:	xor    %rax,%r13
  32d46f:	mov    0x8(%r12),%rbp
  32d474:	xor    %r9,%rbp
  32d477:	add    $0x10,%r12
  32d47b:	or     %r13,%rbp
  32d47e:	je     32d460 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8a0>
  32d480:	jmp    32d493 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8d3>
  32d482:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  32d490:	mov    %rdi,%rsi
  32d493:	mov    %rsi,%rax
  32d496:	sub    %rdx,%rax
  32d499:	jb     32d5db <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa1b>
  32d49f:	mov    %rax,%r13
  32d4a2:	shr    $1,%r13
  32d4a5:	mov    (%rsp),%rdi
  32d4a9:	je     32d430 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x870>
  32d4ab:	mov    %rsi,%rdx
  32d4ae:	shl    $0x4,%rdx
  32d4b2:	mov    %r13d,%r12d
  32d4b5:	and    $0x3,%r12d
  32d4b9:	cmp    $0x8,%rax
  32d4bd:	jae    32d4d0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x910>
  32d4bf:	xor    %ebp,%ebp
  32d4c1:	jmp    32d586 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x9c6>
  32d4c6:	cs nopw 0x0(%rax,%rax,1)
  32d4d0:	add    %rdx,%rdi
  32d4d3:	and    $0xfffffffffffffffc,%r13
  32d4d7:	mov    0x8(%rsp),%rax
  32d4dc:	lea    (%rax,%r15,1),%r9
  32d4e0:	mov    0x10(%rsp),%rax
  32d4e5:	lea    (%rax,%rdx,1),%r10
  32d4e9:	xor    %ebp,%ebp
  32d4eb:	nopl   0x0(%rax,%rax,1)
  32d4f0:	vmovaps -0x30(%r9),%xmm0
  32d4f6:	vmovaps (%r10),%xmm1
  32d4fb:	vmovaps %xmm1,-0x30(%r9)
  32d501:	vmovaps %xmm0,(%r10)
  32d506:	mov    %rbp,%rax
  32d509:	xor    %r11,%rax
  32d50c:	shl    $0x4,%rax
  32d510:	vmovaps -0x20(%r9),%xmm0
  32d516:	vmovaps (%rdi,%rax,1),%xmm1
  32d51b:	vmovaps %xmm1,-0x20(%r9)
  32d521:	vmovaps %xmm0,(%rdi,%rax,1)
  32d526:	mov    %rbp,%rax
  32d529:	xor    %rbx,%rax
  32d52c:	shl    $0x4,%rax
  32d530:	vmovaps -0x10(%r9),%xmm0
  32d536:	vmovaps (%rdi,%rax,1),%xmm1
  32d53b:	vmovaps %xmm1,-0x10(%r9)
  32d541:	vmovaps %xmm0,(%rdi,%rax,1)
  32d546:	mov    %rbp,%rax
  32d549:	xor    %r14,%rax
  32d54c:	shl    $0x4,%rax
  32d550:	vmovdqa (%r9),%xmm0
  32d555:	vmovdqa (%rdi,%rax,1),%xmm1
  32d55a:	vmovdqa %xmm1,(%r9)
  32d55f:	vmovdqa %xmm0,(%rdi,%rax,1)
  32d564:	add    $0x4,%rbp
  32d568:	add    $0x40,%r9
  32d56c:	add    $0xffffffffffffffc0,%r10
  32d570:	cmp    %rbp,%r13
  32d573:	jne    32d4f0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x930>
  32d579:	test   %r12,%r12
  32d57c:	mov    (%rsp),%rdi
  32d580:	je     32d430 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x870>
  32d586:	shl    $0x4,%rbp
  32d58a:	add    %rdi,%r15
  32d58d:	add    %rbp,%r15
  32d590:	sub    %rbp,%rdx
  32d593:	add    0x10(%rsp),%rdx
  32d598:	shl    $0x4,%r12d
  32d59c:	xor    %eax,%eax
  32d59e:	xchg   %ax,%ax
  32d5a0:	vmovdqa (%r15,%rax,1),%xmm0
  32d5a6:	vmovdqa (%rdx),%xmm1
  32d5aa:	vmovdqa %xmm1,(%r15,%rax,1)
  32d5b0:	vmovdqa %xmm0,(%rdx)
  32d5b4:	add    $0x10,%rax
  32d5b8:	add    $0xfffffffffffffff0,%rdx
  32d5bc:	cmp    %rax,%r12
  32d5bf:	jne    32d5a0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x9e0>
  32d5c1:	jmp    32d430 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x870>
  32d5c6:	mov    $0x1,%r8b
  32d5c9:	mov    %r8d,%eax
  32d5cc:	add    $0x48,%rsp
  32d5d0:	pop    %rbx
  32d5d1:	pop    %r12
  32d5d3:	pop    %r13
  32d5d5:	pop    %r14
  32d5d7:	pop    %r15
  32d5d9:	pop    %rbp
  32d5da:	ret
  32d5db:	lea    0x18b70e(%rip),%rcx        # 4b8cf0 <anon.005357b6259aec7dbb5efeaf9c6c1e46.1.llvm.5840278210049151275>
  32d5e2:	mov    %rdx,%rdi
  32d5e5:	mov    %r8,%rdx
  32d5e8:	call   *0x18dc7a(%rip)        # 4bb268 <_DYNAMIC+0x298>
  32d5ee:	lea    0x1834f3(%rip),%rcx        # 4b0ae8 <anon.c4e4e2de90ac69d0128ebb4ed2cca3d4.1.llvm.2928595367199889299+0x48>
  32d5f5:	mov    %r9,%rdi
  32d5f8:	mov    %rsi,%rdx
  32d5fb:	call   *0x18dc67(%rip)        # 4bb268 <_DYNAMIC+0x298>
  32d601:	lea    0x1834c8(%rip),%rcx        # 4b0ad0 <anon.c4e4e2de90ac69d0128ebb4ed2cca3d4.1.llvm.2928595367199889299+0x30>
  32d608:	mov    %r9,%rdi
  32d60b:	mov    %rsi,%rdx
  32d60e:	call   *0x18dc54(%rip)        # 4bb268 <_DYNAMIC+0x298>
  32d614:	lea    0x1834e5(%rip),%rcx        # 4b0b00 <anon.c4e4e2de90ac69d0128ebb4ed2cca3d4.1.llvm.2928595367199889299+0x60>
  32d61b:	xor    %edi,%edi
  32d61d:	xor    %edx,%edx
  32d61f:	call   *0x18dc43(%rip)        # 4bb268 <_DYNAMIC+0x298>
  32d625:	lea    0x1834d4(%rip),%rcx        # 4b0b00 <anon.c4e4e2de90ac69d0128ebb4ed2cca3d4.1.llvm.2928595367199889299+0x60>
  32d62c:	xor    %edi,%edi
  32d62e:	mov    %rax,%rsi
  32d631:	xor    %edx,%edx
  32d633:	call   *0x18dc2f(%rip)        # 4bb268 <_DYNAMIC+0x298>
  32d639:	lea    0x1834d8(%rip),%rcx        # 4b0b18 <anon.c4e4e2de90ac69d0128ebb4ed2cca3d4.1.llvm.2928595367199889299+0x78>
  32d640:	mov    0x20(%rsp),%rdx
  32d645:	mov    %rdx,%rsi
  32d648:	call   *0x18dc1a(%rip)        # 4bb268 <_DYNAMIC+0x298>
  32d64e:	lea    0x1834c3(%rip),%rcx        # 4b0b18 <anon.c4e4e2de90ac69d0128ebb4ed2cca3d4.1.llvm.2928595367199889299+0x78>
  32d655:	mov    %rsi,%rdx
  32d658:	call   *0x18dc0a(%rip)        # 4bb268 <_DYNAMIC+0x298>

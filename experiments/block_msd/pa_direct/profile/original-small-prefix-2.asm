
experiments/block_msd/target/pa-direct/time:     file format elf64-x86-64


Disassembly of section .text:

000000000021bb80 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>>:
  21bb80:	push   %rbp
  21bb81:	push   %r15
  21bb83:	push   %r14
  21bb85:	push   %r13
  21bb87:	push   %r12
  21bb89:	push   %rbx
  21bb8a:	sub    $0x88,%rsp
  21bb91:	mov    %r9,0x10(%rsp)
  21bb96:	mov    %r8,0x38(%rsp)
  21bb9b:	mov    %rsi,%r10
  21bb9e:	mov    0x80(%rdi),%rax
  21bba5:	mov    0xa8(%rdi),%rsi
  21bbac:	mov    %rsi,0x78(%rsp)
  21bbb1:	cmp    %rsi,%rax
  21bbb4:	jae    21c12c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5ac>
  21bbba:	mov    0x20(%rdi),%rsi
  21bbbe:	mov    %rsi,0x28(%rsp)
  21bbc3:	mov    0x28(%rdi),%rsi
  21bbc7:	mov    0x88(%rdi),%r15
  21bbce:	mov    0xa0(%rdi),%r8
  21bbd5:	mov    %r8,0x20(%rsp)
  21bbda:	mov    0x90(%rdi),%r8
  21bbe1:	mov    %r8,0x18(%rsp)
  21bbe6:	mov    0x78(%rdi),%rbp
  21bbea:	mov    0x70(%rdi),%r8
  21bbee:	mov    %r8,0x70(%rsp)
  21bbf3:	mov    0x68(%rdi),%r9
  21bbf7:	mov    (%r10),%rbx
  21bbfa:	mov    0x58(%rdi),%r8
  21bbfe:	mov    %r8,0x8(%rsp)
  21bc03:	mov    0x50(%rdi),%rdi
  21bc07:	mov    %rdi,0x30(%rsp)
  21bc0c:	cmp    %rsi,%rax
  21bc0f:	mov    %rsi,%rdi
  21bc12:	cmova  %rax,%rdi
  21bc16:	mov    %rdi,0x48(%rsp)
  21bc1b:	xor    %r10d,%r10d
  21bc1e:	mov    %rax,%r8
  21bc21:	mov    %r9,0x68(%rsp)
  21bc26:	jmp    21bc4d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0xcd>
  21bc28:	nopl   0x0(%rax,%rax,1)
  21bc30:	mov    0x58(%rsp),%r8
  21bc35:	inc    %r8
  21bc38:	cmp    0x78(%rsp),%r8
  21bc3d:	mov    0x68(%rsp),%r9
  21bc42:	mov    0x40(%rsp),%r10
  21bc47:	je     21c12c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5ac>
  21bc4d:	cmp    0x48(%rsp),%r8
  21bc52:	je     21c1b1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x631>
  21bc58:	mov    0x28(%rsp),%rdi
  21bc5d:	mov    (%rdi,%r8,4),%edi
  21bc61:	cmp    %rdi,%rsi
  21bc64:	jbe    21c13e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5be>
  21bc6a:	mov    %r8,0x58(%rsp)
  21bc6f:	mov    %rdi,%r14
  21bc72:	cmp    %rdi,%r15
  21bc75:	mov    $0x0,%edi
  21bc7a:	cmovbe %r15,%rdi
  21bc7e:	mov    0x18(%rsp),%r8
  21bc83:	cmova  0x20(%rsp),%r8
  21bc89:	mov    %r8,0x50(%rsp)
  21bc8e:	cmp    0x70(%rsp),%r10
  21bc93:	jae    21bcc0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x140>
  21bc95:	mov    %r10,%r8
  21bc98:	shl    $0x4,%r8
  21bc9c:	mov    0x58(%rsp),%r11
  21bca1:	cmp    %r11,(%r9,%r8,1)
  21bca5:	jne    21bcc0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x140>
  21bca7:	add    %r9,%r8
  21bcaa:	mov    0x8(%r8),%r8
  21bcae:	inc    %r10
  21bcb1:	mov    %r10,0x40(%rsp)
  21bcb6:	jmp    21bcc8 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x148>
  21bcb8:	nopl   0x0(%rax,%rax,1)
  21bcc0:	mov    %r10,0x40(%rsp)
  21bcc5:	mov    %rbp,%r8
  21bcc8:	sub    %rdi,%r14
  21bccb:	mov    %r8,0x60(%rsp)
  21bcd0:	shr    $0x2,%r8
  21bcd4:	mov    %r14,0x80(%rsp)
  21bcdc:	je     21c020 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x4a0>
  21bce2:	lea    0x0(,%rbp,8),%rdi
  21bcea:	imul   %r14,%rdi
  21bcee:	mov    0x50(%rsp),%r9
  21bcf3:	add    %rdi,%r9
  21bcf6:	add    $0x18,%r9
  21bcfa:	jmp    21bd19 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x199>
  21bcfc:	nopl   0x0(%rax)
  21bd00:	mov    0x38(%rsp),%rdi
  21bd05:	incq   (%rdi,%r11,8)
  21bd09:	inc    %rax
  21bd0c:	add    $0x20,%r9
  21bd10:	dec    %r8
  21bd13:	je     21c020 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x4a0>
  21bd19:	mov    (%rbx),%rdi
  21bd1c:	movzbl (%rdi),%r10d
  21bd20:	shrx   %r10d,-0x18(%r9),%r10d
  21bd26:	and    0x8(%rdi),%r10d
  21bd2a:	shr    $0x10,%r10d
  21bd2e:	movzbl %r10b,%edi
  21bd32:	cmp    %rdi,%rcx
  21bd35:	jbe    21c18f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x60f>
  21bd3b:	mov    %edi,%r11d
  21bd3e:	shl    $0x4,%r11d
  21bd42:	mov    (%rdx,%r11,1),%r14
  21bd46:	mov    -0x18(%r9),%r12
  21bd4a:	lea    0x8(%r14),%r13
  21bd4e:	cmp    0x8(%rdx,%r11,1),%r13
  21bd53:	mov    %r12,(%r14)
  21bd56:	mov    %r13,(%rdx,%r11,1)
  21bd5a:	jne    21bdda <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x25a>
  21bd5c:	cmp    %rsi,%rax
  21bd5f:	jae    21c16a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5ea>
  21bd65:	mov    0x28(%rsp),%r14
  21bd6a:	mov    (%r14,%rax,4),%r14d
  21bd6e:	cmp    %r14,%rsi
  21bd71:	jbe    21c13e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5be>
  21bd77:	add    %rdx,%r11
  21bd7a:	cmp    %r14,%r15
  21bd7d:	mov    $0x0,%r12d
  21bd83:	cmovbe %r15,%r12
  21bd87:	mov    0x18(%rsp),%r13
  21bd8c:	cmova  0x20(%rsp),%r13
  21bd92:	sub    %r12,%r14
  21bd95:	imul   %rbp,%r14
  21bd99:	lea    0x0(,%r14,8),%r14
  21bda1:	add    %r13,%r14
  21bda4:	lea    (%r14,%rbp,8),%r12
  21bda8:	mov    %r14,(%r11)
  21bdab:	mov    %r12,0x8(%r11)
  21bdaf:	cmp    0x8(%rsp),%rax
  21bdb4:	jae    21c17a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5fa>
  21bdba:	mov    0x30(%rsp),%r11
  21bdbf:	mov    %r10b,(%r11,%rax,1)
  21bdc3:	cmp    %rdi,0x10(%rsp)
  21bdc8:	jbe    21c19f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x61f>
  21bdce:	mov    0x38(%rsp),%r10
  21bdd3:	incq   (%r10,%rdi,8)
  21bdd7:	inc    %rax
  21bdda:	mov    (%rbx),%rdi
  21bddd:	movzbl (%rdi),%r10d
  21bde1:	shrx   %r10d,-0x10(%r9),%r10d
  21bde7:	and    0x8(%rdi),%r10d
  21bdeb:	shr    $0x10,%r10d
  21bdef:	movzbl %r10b,%r11d
  21bdf3:	cmp    %r11,%rcx
  21bdf6:	jbe    21c157 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5d7>
  21bdfc:	mov    %r11d,%edi
  21bdff:	shl    $0x4,%edi
  21be02:	mov    (%rdx,%rdi,1),%r14
  21be06:	mov    -0x10(%r9),%r12
  21be0a:	lea    0x8(%r14),%r13
  21be0e:	cmp    0x8(%rdx,%rdi,1),%r13
  21be13:	mov    %r12,(%r14)
  21be16:	mov    %r13,(%rdx,%rdi,1)
  21be1a:	jne    21be9a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x31a>
  21be1c:	cmp    %rsi,%rax
  21be1f:	jae    21c16a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5ea>
  21be25:	mov    0x28(%rsp),%r14
  21be2a:	mov    (%r14,%rax,4),%r14d
  21be2e:	cmp    %r14,%rsi
  21be31:	jbe    21c13e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5be>
  21be37:	add    %rdx,%rdi
  21be3a:	cmp    %r14,%r15
  21be3d:	mov    $0x0,%r12d
  21be43:	cmovbe %r15,%r12
  21be47:	mov    0x18(%rsp),%r13
  21be4c:	cmova  0x20(%rsp),%r13
  21be52:	sub    %r12,%r14
  21be55:	imul   %rbp,%r14
  21be59:	lea    0x0(,%r14,8),%r14
  21be61:	add    %r13,%r14
  21be64:	lea    (%r14,%rbp,8),%r12
  21be68:	mov    %r14,(%rdi)
  21be6b:	mov    %r12,0x8(%rdi)
  21be6f:	cmp    0x8(%rsp),%rax
  21be74:	jae    21c17a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5fa>
  21be7a:	mov    0x30(%rsp),%rdi
  21be7f:	mov    %r10b,(%rdi,%rax,1)
  21be83:	cmp    %r11,0x10(%rsp)
  21be88:	jbe    21c117 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x597>
  21be8e:	mov    0x38(%rsp),%rdi
  21be93:	incq   (%rdi,%r11,8)
  21be97:	inc    %rax
  21be9a:	mov    (%rbx),%rdi
  21be9d:	movzbl (%rdi),%r10d
  21bea1:	shrx   %r10d,-0x8(%r9),%r10d
  21bea7:	and    0x8(%rdi),%r10d
  21beab:	shr    $0x10,%r10d
  21beaf:	movzbl %r10b,%r11d
  21beb3:	cmp    %r11,%rcx
  21beb6:	jbe    21c157 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5d7>
  21bebc:	mov    %r11d,%edi
  21bebf:	shl    $0x4,%edi
  21bec2:	mov    (%rdx,%rdi,1),%r14
  21bec6:	mov    -0x8(%r9),%r12
  21beca:	lea    0x8(%r14),%r13
  21bece:	cmp    0x8(%rdx,%rdi,1),%r13
  21bed3:	mov    %r12,(%r14)
  21bed6:	mov    %r13,(%rdx,%rdi,1)
  21beda:	jne    21bf5a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x3da>
  21bedc:	cmp    %rsi,%rax
  21bedf:	jae    21c16a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5ea>
  21bee5:	mov    0x28(%rsp),%r14
  21beea:	mov    (%r14,%rax,4),%r14d
  21beee:	cmp    %r14,%rsi
  21bef1:	jbe    21c13e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5be>
  21bef7:	add    %rdx,%rdi
  21befa:	cmp    %r14,%r15
  21befd:	mov    $0x0,%r12d
  21bf03:	cmovbe %r15,%r12
  21bf07:	mov    0x18(%rsp),%r13
  21bf0c:	cmova  0x20(%rsp),%r13
  21bf12:	sub    %r12,%r14
  21bf15:	imul   %rbp,%r14
  21bf19:	lea    0x0(,%r14,8),%r14
  21bf21:	add    %r13,%r14
  21bf24:	lea    (%r14,%rbp,8),%r12
  21bf28:	mov    %r14,(%rdi)
  21bf2b:	mov    %r12,0x8(%rdi)
  21bf2f:	cmp    0x8(%rsp),%rax
  21bf34:	jae    21c17a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5fa>
  21bf3a:	mov    0x30(%rsp),%rdi
  21bf3f:	mov    %r10b,(%rdi,%rax,1)
  21bf43:	cmp    %r11,0x10(%rsp)
  21bf48:	jbe    21c117 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x597>
  21bf4e:	mov    0x38(%rsp),%rdi
  21bf53:	incq   (%rdi,%r11,8)
  21bf57:	inc    %rax
  21bf5a:	mov    (%rbx),%rdi
  21bf5d:	movzbl (%rdi),%r10d
  21bf61:	shrx   %r10d,(%r9),%r10d
  21bf66:	and    0x8(%rdi),%r10d
  21bf6a:	shr    $0x10,%r10d
  21bf6e:	movzbl %r10b,%r11d
  21bf72:	cmp    %r11,%rcx
  21bf75:	jbe    21c157 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5d7>
  21bf7b:	mov    %r11d,%edi
  21bf7e:	shl    $0x4,%edi
  21bf81:	mov    (%rdx,%rdi,1),%r14
  21bf85:	mov    (%r9),%r12
  21bf88:	lea    0x8(%r14),%r13
  21bf8c:	cmp    0x8(%rdx,%rdi,1),%r13
  21bf91:	mov    %r12,(%r14)
  21bf94:	mov    %r13,(%rdx,%rdi,1)
  21bf98:	jne    21bd0c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x18c>
  21bf9e:	cmp    %rsi,%rax
  21bfa1:	jae    21c16a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5ea>
  21bfa7:	mov    0x28(%rsp),%r14
  21bfac:	mov    (%r14,%rax,4),%r14d
  21bfb0:	cmp    %r14,%rsi
  21bfb3:	jbe    21c13e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5be>
  21bfb9:	add    %rdx,%rdi
  21bfbc:	cmp    %r14,%r15
  21bfbf:	mov    $0x0,%r12d
  21bfc5:	cmovbe %r15,%r12
  21bfc9:	mov    0x18(%rsp),%r13
  21bfce:	cmova  0x20(%rsp),%r13
  21bfd4:	sub    %r12,%r14
  21bfd7:	imul   %rbp,%r14
  21bfdb:	lea    0x0(,%r14,8),%r14
  21bfe3:	add    %r13,%r14
  21bfe6:	lea    (%r14,%rbp,8),%r12
  21bfea:	mov    %r14,(%rdi)
  21bfed:	mov    %r12,0x8(%rdi)
  21bff1:	cmp    0x8(%rsp),%rax
  21bff6:	jae    21c17a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5fa>
  21bffc:	mov    0x30(%rsp),%rdi
  21c001:	mov    %r10b,(%rdi,%rax,1)
  21c005:	cmp    %r11,0x10(%rsp)
  21c00a:	ja     21bd00 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x180>
  21c010:	jmp    21c117 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x597>
  21c015:	data16 cs nopw 0x0(%rax,%rax,1)
  21c020:	mov    0x60(%rsp),%r8
  21c025:	mov    %r8,%rdi
  21c028:	and    $0xfffffffffffffffc,%rdi
  21c02c:	cmp    %r8,%rdi
  21c02f:	je     21bc30 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0xb0>
  21c035:	mov    0x80(%rsp),%r8
  21c03d:	imul   %rbp,%r8
  21c041:	mov    0x50(%rsp),%r9
  21c046:	lea    (%r9,%r8,8),%r9
  21c04a:	jmp    21c06a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x4ea>
  21c04c:	nopl   0x0(%rax)
  21c050:	mov    0x38(%rsp),%r8
  21c055:	incq   (%r8,%r11,8)
  21c059:	inc    %rax
  21c05c:	inc    %rdi
  21c05f:	cmp    0x60(%rsp),%rdi
  21c064:	jae    21bc30 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0xb0>
  21c06a:	mov    (%rbx),%r8
  21c06d:	movzbl (%r8),%r10d
  21c071:	shrx   %r10d,(%r9,%rdi,8),%r10d
  21c077:	and    0x8(%r8),%r10d
  21c07b:	shr    $0x10,%r10d
  21c07f:	movzbl %r10b,%r11d
  21c083:	cmp    %r11,%rcx
  21c086:	jbe    21c157 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5d7>
  21c08c:	mov    %r11d,%r8d
  21c08f:	shl    $0x4,%r8d
  21c093:	mov    (%rdx,%r8,1),%r14
  21c097:	mov    (%r9,%rdi,8),%r12
  21c09b:	lea    0x8(%r14),%r13
  21c09f:	cmp    0x8(%rdx,%r8,1),%r13
  21c0a4:	mov    %r12,(%r14)
  21c0a7:	mov    %r13,(%rdx,%r8,1)
  21c0ab:	jne    21c05c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x4dc>
  21c0ad:	cmp    %rsi,%rax
  21c0b0:	jae    21c16a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5ea>
  21c0b6:	mov    0x28(%rsp),%r14
  21c0bb:	mov    (%r14,%rax,4),%r14d
  21c0bf:	cmp    %r14,%rsi
  21c0c2:	jbe    21c13e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5be>
  21c0c4:	add    %rdx,%r8
  21c0c7:	cmp    %r14,%r15
  21c0ca:	mov    $0x0,%r12d
  21c0d0:	cmovbe %r15,%r12
  21c0d4:	mov    0x18(%rsp),%r13
  21c0d9:	cmova  0x20(%rsp),%r13
  21c0df:	sub    %r12,%r14
  21c0e2:	imul   %rbp,%r14
  21c0e6:	lea    0x0(,%r14,8),%r14
  21c0ee:	add    %r13,%r14
  21c0f1:	lea    (%r14,%rbp,8),%r12
  21c0f5:	mov    %r14,(%r8)
  21c0f8:	mov    %r12,0x8(%r8)
  21c0fc:	cmp    0x8(%rsp),%rax
  21c101:	jae    21c17a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5fa>
  21c103:	mov    0x30(%rsp),%r8
  21c108:	mov    %r10b,(%r8,%rax,1)
  21c10c:	cmp    %r11,0x10(%rsp)
  21c111:	ja     21c050 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x4d0>
  21c117:	lea    0x1c25fa(%rip),%rdx        # 3de718 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x328>
  21c11e:	mov    %r11,%rdi
  21c121:	mov    0x10(%rsp),%rsi
  21c126:	call   *0x1c53ec(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21c12c:	add    $0x88,%rsp
  21c133:	pop    %rbx
  21c134:	pop    %r12
  21c136:	pop    %r13
  21c138:	pop    %r14
  21c13a:	pop    %r15
  21c13c:	pop    %rbp
  21c13d:	ret
  21c13e:	lea    -0x206115(%rip),%rdi        # 16030 <anon.7fa33eb33931318ee6b6568b4abff869.3.llvm.17153750559840045314+0xf3>
  21c145:	lea    0x1c265c(%rip),%rdx        # 3de7a8 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x3b8>
  21c14c:	mov    $0x2c,%esi
  21c151:	call   *0x1c5431(%rip)        # 3e1588 <_DYNAMIC+0x2f0>
  21c157:	lea    0x1c2572(%rip),%rdx        # 3de6d0 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x2e0>
  21c15e:	mov    %r11,%rdi
  21c161:	mov    %rcx,%rsi
  21c164:	call   *0x1c53ae(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21c16a:	lea    0x1c2577(%rip),%rdx        # 3de6e8 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x2f8>
  21c171:	mov    %rax,%rdi
  21c174:	call   *0x1c539e(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21c17a:	lea    0x1c257f(%rip),%rdx        # 3de700 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x310>
  21c181:	mov    %rax,%rdi
  21c184:	mov    0x8(%rsp),%rsi
  21c189:	call   *0x1c5389(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21c18f:	lea    0x1c253a(%rip),%rdx        # 3de6d0 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x2e0>
  21c196:	mov    %rcx,%rsi
  21c199:	call   *0x1c5379(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21c19f:	lea    0x1c2572(%rip),%rdx        # 3de718 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x328>
  21c1a6:	mov    0x10(%rsp),%rsi
  21c1ab:	call   *0x1c5367(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21c1b1:	lea    0x1c2328(%rip),%rdx        # 3de4e0 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0xf0>
  21c1b8:	mov    0x48(%rsp),%rdi
  21c1bd:	call   *0x1c5355(%rip)        # 3e1518 <_DYNAMIC+0x280>

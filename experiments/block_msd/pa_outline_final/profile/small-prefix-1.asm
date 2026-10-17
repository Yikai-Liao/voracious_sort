
experiments/block_msd/target/pa-outline-final/time:     file format elf64-x86-64


Disassembly of section .text:

0000000000141db0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>>:
  141db0:	push   %rbp
  141db1:	push   %r15
  141db3:	push   %r14
  141db5:	push   %r13
  141db7:	push   %r12
  141db9:	push   %rbx
  141dba:	sub    $0x88,%rsp
  141dc1:	mov    %r9,0x10(%rsp)
  141dc6:	mov    %r8,0x38(%rsp)
  141dcb:	mov    %rsi,%r10
  141dce:	mov    0x80(%rdi),%rax
  141dd5:	mov    0xa8(%rdi),%rsi
  141ddc:	mov    %rsi,0x78(%rsp)
  141de1:	cmp    %rsi,%rax
  141de4:	jae    14235c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5ac>
  141dea:	mov    0x20(%rdi),%rsi
  141dee:	mov    %rsi,0x28(%rsp)
  141df3:	mov    0x28(%rdi),%rsi
  141df7:	mov    0x88(%rdi),%r15
  141dfe:	mov    0xa0(%rdi),%r8
  141e05:	mov    %r8,0x20(%rsp)
  141e0a:	mov    0x90(%rdi),%r8
  141e11:	mov    %r8,0x18(%rsp)
  141e16:	mov    0x78(%rdi),%rbp
  141e1a:	mov    0x70(%rdi),%r8
  141e1e:	mov    %r8,0x70(%rsp)
  141e23:	mov    0x68(%rdi),%r9
  141e27:	mov    (%r10),%rbx
  141e2a:	mov    0x58(%rdi),%r8
  141e2e:	mov    %r8,0x8(%rsp)
  141e33:	mov    0x50(%rdi),%rdi
  141e37:	mov    %rdi,0x30(%rsp)
  141e3c:	cmp    %rsi,%rax
  141e3f:	mov    %rsi,%rdi
  141e42:	cmova  %rax,%rdi
  141e46:	mov    %rdi,0x48(%rsp)
  141e4b:	xor    %r10d,%r10d
  141e4e:	mov    %rax,%r8
  141e51:	mov    %r9,0x68(%rsp)
  141e56:	jmp    141e7d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0xcd>
  141e58:	nopl   0x0(%rax,%rax,1)
  141e60:	mov    0x58(%rsp),%r8
  141e65:	inc    %r8
  141e68:	cmp    0x78(%rsp),%r8
  141e6d:	mov    0x68(%rsp),%r9
  141e72:	mov    0x40(%rsp),%r10
  141e77:	je     14235c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5ac>
  141e7d:	cmp    0x48(%rsp),%r8
  141e82:	je     1423e1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x631>
  141e88:	mov    0x28(%rsp),%rdi
  141e8d:	mov    (%rdi,%r8,4),%edi
  141e91:	cmp    %rdi,%rsi
  141e94:	jbe    14236e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5be>
  141e9a:	mov    %r8,0x58(%rsp)
  141e9f:	mov    %rdi,%r14
  141ea2:	cmp    %rdi,%r15
  141ea5:	mov    $0x0,%edi
  141eaa:	cmovbe %r15,%rdi
  141eae:	mov    0x18(%rsp),%r8
  141eb3:	cmova  0x20(%rsp),%r8
  141eb9:	mov    %r8,0x50(%rsp)
  141ebe:	cmp    0x70(%rsp),%r10
  141ec3:	jae    141ef0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x140>
  141ec5:	mov    %r10,%r8
  141ec8:	shl    $0x4,%r8
  141ecc:	mov    0x58(%rsp),%r11
  141ed1:	cmp    %r11,(%r9,%r8,1)
  141ed5:	jne    141ef0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x140>
  141ed7:	add    %r9,%r8
  141eda:	mov    0x8(%r8),%r8
  141ede:	inc    %r10
  141ee1:	mov    %r10,0x40(%rsp)
  141ee6:	jmp    141ef8 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x148>
  141ee8:	nopl   0x0(%rax,%rax,1)
  141ef0:	mov    %r10,0x40(%rsp)
  141ef5:	mov    %rbp,%r8
  141ef8:	sub    %rdi,%r14
  141efb:	mov    %r8,0x60(%rsp)
  141f00:	shr    $0x2,%r8
  141f04:	mov    %r14,0x80(%rsp)
  141f0c:	je     142250 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x4a0>
  141f12:	lea    0x0(,%rbp,8),%rdi
  141f1a:	imul   %r14,%rdi
  141f1e:	mov    0x50(%rsp),%r9
  141f23:	add    %rdi,%r9
  141f26:	add    $0x18,%r9
  141f2a:	jmp    141f49 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x199>
  141f2c:	nopl   0x0(%rax)
  141f30:	mov    0x38(%rsp),%rdi
  141f35:	incq   (%rdi,%r11,8)
  141f39:	inc    %rax
  141f3c:	add    $0x20,%r9
  141f40:	dec    %r8
  141f43:	je     142250 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x4a0>
  141f49:	mov    (%rbx),%rdi
  141f4c:	movzbl (%rdi),%r10d
  141f50:	shrx   %r10d,-0x18(%r9),%r10d
  141f56:	and    0x8(%rdi),%r10d
  141f5a:	shr    $0x8,%r10d
  141f5e:	movzbl %r10b,%edi
  141f62:	cmp    %rdi,%rcx
  141f65:	jbe    1423bf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x60f>
  141f6b:	mov    %edi,%r11d
  141f6e:	shl    $0x4,%r11d
  141f72:	mov    (%rdx,%r11,1),%r14
  141f76:	mov    -0x18(%r9),%r12
  141f7a:	lea    0x8(%r14),%r13
  141f7e:	cmp    0x8(%rdx,%r11,1),%r13
  141f83:	mov    %r12,(%r14)
  141f86:	mov    %r13,(%rdx,%r11,1)
  141f8a:	jne    14200a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x25a>
  141f8c:	cmp    %rsi,%rax
  141f8f:	jae    14239a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5ea>
  141f95:	mov    0x28(%rsp),%r14
  141f9a:	mov    (%r14,%rax,4),%r14d
  141f9e:	cmp    %r14,%rsi
  141fa1:	jbe    14236e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5be>
  141fa7:	add    %rdx,%r11
  141faa:	cmp    %r14,%r15
  141fad:	mov    $0x0,%r12d
  141fb3:	cmovbe %r15,%r12
  141fb7:	mov    0x18(%rsp),%r13
  141fbc:	cmova  0x20(%rsp),%r13
  141fc2:	sub    %r12,%r14
  141fc5:	imul   %rbp,%r14
  141fc9:	lea    0x0(,%r14,8),%r14
  141fd1:	add    %r13,%r14
  141fd4:	lea    (%r14,%rbp,8),%r12
  141fd8:	mov    %r14,(%r11)
  141fdb:	mov    %r12,0x8(%r11)
  141fdf:	cmp    0x8(%rsp),%rax
  141fe4:	jae    1423aa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5fa>
  141fea:	mov    0x30(%rsp),%r11
  141fef:	mov    %r10b,(%r11,%rax,1)
  141ff3:	cmp    %rdi,0x10(%rsp)
  141ff8:	jbe    1423cf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x61f>
  141ffe:	mov    0x38(%rsp),%r10
  142003:	incq   (%r10,%rdi,8)
  142007:	inc    %rax
  14200a:	mov    (%rbx),%rdi
  14200d:	movzbl (%rdi),%r10d
  142011:	shrx   %r10d,-0x10(%r9),%r10d
  142017:	and    0x8(%rdi),%r10d
  14201b:	shr    $0x8,%r10d
  14201f:	movzbl %r10b,%r11d
  142023:	cmp    %r11,%rcx
  142026:	jbe    142387 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5d7>
  14202c:	mov    %r11d,%edi
  14202f:	shl    $0x4,%edi
  142032:	mov    (%rdx,%rdi,1),%r14
  142036:	mov    -0x10(%r9),%r12
  14203a:	lea    0x8(%r14),%r13
  14203e:	cmp    0x8(%rdx,%rdi,1),%r13
  142043:	mov    %r12,(%r14)
  142046:	mov    %r13,(%rdx,%rdi,1)
  14204a:	jne    1420ca <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x31a>
  14204c:	cmp    %rsi,%rax
  14204f:	jae    14239a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5ea>
  142055:	mov    0x28(%rsp),%r14
  14205a:	mov    (%r14,%rax,4),%r14d
  14205e:	cmp    %r14,%rsi
  142061:	jbe    14236e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5be>
  142067:	add    %rdx,%rdi
  14206a:	cmp    %r14,%r15
  14206d:	mov    $0x0,%r12d
  142073:	cmovbe %r15,%r12
  142077:	mov    0x18(%rsp),%r13
  14207c:	cmova  0x20(%rsp),%r13
  142082:	sub    %r12,%r14
  142085:	imul   %rbp,%r14
  142089:	lea    0x0(,%r14,8),%r14
  142091:	add    %r13,%r14
  142094:	lea    (%r14,%rbp,8),%r12
  142098:	mov    %r14,(%rdi)
  14209b:	mov    %r12,0x8(%rdi)
  14209f:	cmp    0x8(%rsp),%rax
  1420a4:	jae    1423aa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5fa>
  1420aa:	mov    0x30(%rsp),%rdi
  1420af:	mov    %r10b,(%rdi,%rax,1)
  1420b3:	cmp    %r11,0x10(%rsp)
  1420b8:	jbe    142347 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x597>
  1420be:	mov    0x38(%rsp),%rdi
  1420c3:	incq   (%rdi,%r11,8)
  1420c7:	inc    %rax
  1420ca:	mov    (%rbx),%rdi
  1420cd:	movzbl (%rdi),%r10d
  1420d1:	shrx   %r10d,-0x8(%r9),%r10d
  1420d7:	and    0x8(%rdi),%r10d
  1420db:	shr    $0x8,%r10d
  1420df:	movzbl %r10b,%r11d
  1420e3:	cmp    %r11,%rcx
  1420e6:	jbe    142387 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5d7>
  1420ec:	mov    %r11d,%edi
  1420ef:	shl    $0x4,%edi
  1420f2:	mov    (%rdx,%rdi,1),%r14
  1420f6:	mov    -0x8(%r9),%r12
  1420fa:	lea    0x8(%r14),%r13
  1420fe:	cmp    0x8(%rdx,%rdi,1),%r13
  142103:	mov    %r12,(%r14)
  142106:	mov    %r13,(%rdx,%rdi,1)
  14210a:	jne    14218a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x3da>
  14210c:	cmp    %rsi,%rax
  14210f:	jae    14239a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5ea>
  142115:	mov    0x28(%rsp),%r14
  14211a:	mov    (%r14,%rax,4),%r14d
  14211e:	cmp    %r14,%rsi
  142121:	jbe    14236e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5be>
  142127:	add    %rdx,%rdi
  14212a:	cmp    %r14,%r15
  14212d:	mov    $0x0,%r12d
  142133:	cmovbe %r15,%r12
  142137:	mov    0x18(%rsp),%r13
  14213c:	cmova  0x20(%rsp),%r13
  142142:	sub    %r12,%r14
  142145:	imul   %rbp,%r14
  142149:	lea    0x0(,%r14,8),%r14
  142151:	add    %r13,%r14
  142154:	lea    (%r14,%rbp,8),%r12
  142158:	mov    %r14,(%rdi)
  14215b:	mov    %r12,0x8(%rdi)
  14215f:	cmp    0x8(%rsp),%rax
  142164:	jae    1423aa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5fa>
  14216a:	mov    0x30(%rsp),%rdi
  14216f:	mov    %r10b,(%rdi,%rax,1)
  142173:	cmp    %r11,0x10(%rsp)
  142178:	jbe    142347 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x597>
  14217e:	mov    0x38(%rsp),%rdi
  142183:	incq   (%rdi,%r11,8)
  142187:	inc    %rax
  14218a:	mov    (%rbx),%rdi
  14218d:	movzbl (%rdi),%r10d
  142191:	shrx   %r10d,(%r9),%r10d
  142196:	and    0x8(%rdi),%r10d
  14219a:	shr    $0x8,%r10d
  14219e:	movzbl %r10b,%r11d
  1421a2:	cmp    %r11,%rcx
  1421a5:	jbe    142387 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5d7>
  1421ab:	mov    %r11d,%edi
  1421ae:	shl    $0x4,%edi
  1421b1:	mov    (%rdx,%rdi,1),%r14
  1421b5:	mov    (%r9),%r12
  1421b8:	lea    0x8(%r14),%r13
  1421bc:	cmp    0x8(%rdx,%rdi,1),%r13
  1421c1:	mov    %r12,(%r14)
  1421c4:	mov    %r13,(%rdx,%rdi,1)
  1421c8:	jne    141f3c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x18c>
  1421ce:	cmp    %rsi,%rax
  1421d1:	jae    14239a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5ea>
  1421d7:	mov    0x28(%rsp),%r14
  1421dc:	mov    (%r14,%rax,4),%r14d
  1421e0:	cmp    %r14,%rsi
  1421e3:	jbe    14236e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5be>
  1421e9:	add    %rdx,%rdi
  1421ec:	cmp    %r14,%r15
  1421ef:	mov    $0x0,%r12d
  1421f5:	cmovbe %r15,%r12
  1421f9:	mov    0x18(%rsp),%r13
  1421fe:	cmova  0x20(%rsp),%r13
  142204:	sub    %r12,%r14
  142207:	imul   %rbp,%r14
  14220b:	lea    0x0(,%r14,8),%r14
  142213:	add    %r13,%r14
  142216:	lea    (%r14,%rbp,8),%r12
  14221a:	mov    %r14,(%rdi)
  14221d:	mov    %r12,0x8(%rdi)
  142221:	cmp    0x8(%rsp),%rax
  142226:	jae    1423aa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5fa>
  14222c:	mov    0x30(%rsp),%rdi
  142231:	mov    %r10b,(%rdi,%rax,1)
  142235:	cmp    %r11,0x10(%rsp)
  14223a:	ja     141f30 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x180>
  142240:	jmp    142347 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x597>
  142245:	data16 cs nopw 0x0(%rax,%rax,1)
  142250:	mov    0x60(%rsp),%r8
  142255:	mov    %r8,%rdi
  142258:	and    $0xfffffffffffffffc,%rdi
  14225c:	cmp    %r8,%rdi
  14225f:	je     141e60 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0xb0>
  142265:	mov    0x80(%rsp),%r8
  14226d:	imul   %rbp,%r8
  142271:	mov    0x50(%rsp),%r9
  142276:	lea    (%r9,%r8,8),%r9
  14227a:	jmp    14229a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x4ea>
  14227c:	nopl   0x0(%rax)
  142280:	mov    0x38(%rsp),%r8
  142285:	incq   (%r8,%r11,8)
  142289:	inc    %rax
  14228c:	inc    %rdi
  14228f:	cmp    0x60(%rsp),%rdi
  142294:	jae    141e60 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0xb0>
  14229a:	mov    (%rbx),%r8
  14229d:	movzbl (%r8),%r10d
  1422a1:	shrx   %r10d,(%r9,%rdi,8),%r10d
  1422a7:	and    0x8(%r8),%r10d
  1422ab:	shr    $0x8,%r10d
  1422af:	movzbl %r10b,%r11d
  1422b3:	cmp    %r11,%rcx
  1422b6:	jbe    142387 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5d7>
  1422bc:	mov    %r11d,%r8d
  1422bf:	shl    $0x4,%r8d
  1422c3:	mov    (%rdx,%r8,1),%r14
  1422c7:	mov    (%r9,%rdi,8),%r12
  1422cb:	lea    0x8(%r14),%r13
  1422cf:	cmp    0x8(%rdx,%r8,1),%r13
  1422d4:	mov    %r12,(%r14)
  1422d7:	mov    %r13,(%rdx,%r8,1)
  1422db:	jne    14228c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x4dc>
  1422dd:	cmp    %rsi,%rax
  1422e0:	jae    14239a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5ea>
  1422e6:	mov    0x28(%rsp),%r14
  1422eb:	mov    (%r14,%rax,4),%r14d
  1422ef:	cmp    %r14,%rsi
  1422f2:	jbe    14236e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5be>
  1422f4:	add    %rdx,%r8
  1422f7:	cmp    %r14,%r15
  1422fa:	mov    $0x0,%r12d
  142300:	cmovbe %r15,%r12
  142304:	mov    0x18(%rsp),%r13
  142309:	cmova  0x20(%rsp),%r13
  14230f:	sub    %r12,%r14
  142312:	imul   %rbp,%r14
  142316:	lea    0x0(,%r14,8),%r14
  14231e:	add    %r13,%r14
  142321:	lea    (%r14,%rbp,8),%r12
  142325:	mov    %r14,(%r8)
  142328:	mov    %r12,0x8(%r8)
  14232c:	cmp    0x8(%rsp),%rax
  142331:	jae    1423aa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5fa>
  142333:	mov    0x30(%rsp),%r8
  142338:	mov    %r10b,(%r8,%rax,1)
  14233c:	cmp    %r11,0x10(%rsp)
  142341:	ja     142280 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x4d0>
  142347:	lea    0x36db4a(%rip),%rdx        # 4afe98 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x2e0>
  14234e:	mov    %r11,%rdi
  142351:	mov    0x10(%rsp),%rsi
  142356:	call   *0x378e3c(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  14235c:	add    $0x88,%rsp
  142363:	pop    %rbx
  142364:	pop    %r12
  142366:	pop    %r13
  142368:	pop    %r14
  14236a:	pop    %r15
  14236c:	pop    %rbp
  14236d:	ret
  14236e:	lea    -0x12c202(%rip),%rdi        # 16173 <anon.8f17df2f0ddc4723825c0f55871536dc.0.llvm.4211023910758936617+0xf3>
  142375:	lea    0x36dbac(%rip),%rdx        # 4aff28 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x370>
  14237c:	mov    $0x2c,%esi
  142381:	call   *0x378df9(%rip)        # 4bb180 <_DYNAMIC+0x290>
  142387:	lea    0x36dac2(%rip),%rdx        # 4afe50 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x298>
  14238e:	mov    %r11,%rdi
  142391:	mov    %rcx,%rsi
  142394:	call   *0x378dfe(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  14239a:	lea    0x36dac7(%rip),%rdx        # 4afe68 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x2b0>
  1423a1:	mov    %rax,%rdi
  1423a4:	call   *0x378dee(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  1423aa:	lea    0x36dacf(%rip),%rdx        # 4afe80 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x2c8>
  1423b1:	mov    %rax,%rdi
  1423b4:	mov    0x8(%rsp),%rsi
  1423b9:	call   *0x378dd9(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  1423bf:	lea    0x36da8a(%rip),%rdx        # 4afe50 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x298>
  1423c6:	mov    %rcx,%rsi
  1423c9:	call   *0x378dc9(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  1423cf:	lea    0x36dac2(%rip),%rdx        # 4afe98 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x2e0>
  1423d6:	mov    0x10(%rsp),%rsi
  1423db:	call   *0x378db7(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  1423e1:	lea    0x36d878(%rip),%rdx        # 4afc60 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0xa8>
  1423e8:	mov    0x48(%rsp),%rdi
  1423ed:	call   *0x378da5(%rip)        # 4bb198 <_DYNAMIC+0x2a8>

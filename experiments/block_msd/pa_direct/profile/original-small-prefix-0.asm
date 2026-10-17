
experiments/block_msd/target/pa-direct/time:     file format elf64-x86-64


Disassembly of section .text:

000000000021af00 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>>:
  21af00:	push   %rbp
  21af01:	push   %r15
  21af03:	push   %r14
  21af05:	push   %r13
  21af07:	push   %r12
  21af09:	push   %rbx
  21af0a:	sub    $0x88,%rsp
  21af11:	mov    %r9,0x10(%rsp)
  21af16:	mov    %r8,0x38(%rsp)
  21af1b:	mov    %rsi,%r10
  21af1e:	mov    0x80(%rdi),%rax
  21af25:	mov    0xa8(%rdi),%rsi
  21af2c:	mov    %rsi,0x78(%rsp)
  21af31:	cmp    %rsi,%rax
  21af34:	jae    21b498 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x598>
  21af3a:	mov    0x20(%rdi),%rsi
  21af3e:	mov    %rsi,0x28(%rsp)
  21af43:	mov    0x28(%rdi),%rsi
  21af47:	mov    0x88(%rdi),%r15
  21af4e:	mov    0xa0(%rdi),%r8
  21af55:	mov    %r8,0x20(%rsp)
  21af5a:	mov    0x90(%rdi),%r8
  21af61:	mov    %r8,0x18(%rsp)
  21af66:	mov    0x78(%rdi),%rbp
  21af6a:	mov    0x70(%rdi),%r8
  21af6e:	mov    %r8,0x70(%rsp)
  21af73:	mov    0x68(%rdi),%r9
  21af77:	mov    (%r10),%rbx
  21af7a:	mov    0x58(%rdi),%r8
  21af7e:	mov    %r8,0x8(%rsp)
  21af83:	mov    0x50(%rdi),%rdi
  21af87:	mov    %rdi,0x30(%rsp)
  21af8c:	cmp    %rsi,%rax
  21af8f:	mov    %rsi,%rdi
  21af92:	cmova  %rax,%rdi
  21af96:	mov    %rdi,0x48(%rsp)
  21af9b:	xor    %r10d,%r10d
  21af9e:	mov    %rax,%r8
  21afa1:	mov    %r9,0x68(%rsp)
  21afa6:	jmp    21afcd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0xcd>
  21afa8:	nopl   0x0(%rax,%rax,1)
  21afb0:	mov    0x58(%rsp),%r8
  21afb5:	inc    %r8
  21afb8:	cmp    0x78(%rsp),%r8
  21afbd:	mov    0x68(%rsp),%r9
  21afc2:	mov    0x40(%rsp),%r10
  21afc7:	je     21b498 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x598>
  21afcd:	cmp    0x48(%rsp),%r8
  21afd2:	je     21b51d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x61d>
  21afd8:	mov    0x28(%rsp),%rdi
  21afdd:	mov    (%rdi,%r8,4),%edi
  21afe1:	cmp    %rdi,%rsi
  21afe4:	jbe    21b4aa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5aa>
  21afea:	mov    %r8,0x58(%rsp)
  21afef:	mov    %rdi,%r14
  21aff2:	cmp    %rdi,%r15
  21aff5:	mov    $0x0,%edi
  21affa:	cmovbe %r15,%rdi
  21affe:	mov    0x18(%rsp),%r8
  21b003:	cmova  0x20(%rsp),%r8
  21b009:	mov    %r8,0x50(%rsp)
  21b00e:	cmp    0x70(%rsp),%r10
  21b013:	jae    21b040 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x140>
  21b015:	mov    %r10,%r8
  21b018:	shl    $0x4,%r8
  21b01c:	mov    0x58(%rsp),%r11
  21b021:	cmp    %r11,(%r9,%r8,1)
  21b025:	jne    21b040 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x140>
  21b027:	add    %r9,%r8
  21b02a:	mov    0x8(%r8),%r8
  21b02e:	inc    %r10
  21b031:	mov    %r10,0x40(%rsp)
  21b036:	jmp    21b048 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x148>
  21b038:	nopl   0x0(%rax,%rax,1)
  21b040:	mov    %r10,0x40(%rsp)
  21b045:	mov    %rbp,%r8
  21b048:	sub    %rdi,%r14
  21b04b:	mov    %r8,0x60(%rsp)
  21b050:	shr    $0x2,%r8
  21b054:	mov    %r14,0x80(%rsp)
  21b05c:	je     21b390 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x490>
  21b062:	lea    0x0(,%rbp,8),%rdi
  21b06a:	imul   %r14,%rdi
  21b06e:	mov    0x50(%rsp),%r9
  21b073:	add    %rdi,%r9
  21b076:	add    $0x18,%r9
  21b07a:	jmp    21b099 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x199>
  21b07c:	nopl   0x0(%rax)
  21b080:	mov    0x38(%rsp),%rdi
  21b085:	incq   (%rdi,%r11,8)
  21b089:	inc    %rax
  21b08c:	add    $0x20,%r9
  21b090:	dec    %r8
  21b093:	je     21b390 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x490>
  21b099:	mov    (%rbx),%rdi
  21b09c:	movzbl (%rdi),%r10d
  21b0a0:	shrx   %r10d,-0x18(%r9),%r10d
  21b0a6:	and    0x8(%rdi),%r10d
  21b0aa:	movzbl %r10b,%edi
  21b0ae:	cmp    %rdi,%rcx
  21b0b1:	jbe    21b4fb <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5fb>
  21b0b7:	mov    %edi,%r11d
  21b0ba:	shl    $0x4,%r11d
  21b0be:	mov    (%rdx,%r11,1),%r14
  21b0c2:	mov    -0x18(%r9),%r12
  21b0c6:	lea    0x8(%r14),%r13
  21b0ca:	cmp    0x8(%rdx,%r11,1),%r13
  21b0cf:	mov    %r12,(%r14)
  21b0d2:	mov    %r13,(%rdx,%r11,1)
  21b0d6:	jne    21b156 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x256>
  21b0d8:	cmp    %rsi,%rax
  21b0db:	jae    21b4d6 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5d6>
  21b0e1:	mov    0x28(%rsp),%r14
  21b0e6:	mov    (%r14,%rax,4),%r14d
  21b0ea:	cmp    %r14,%rsi
  21b0ed:	jbe    21b4aa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5aa>
  21b0f3:	add    %rdx,%r11
  21b0f6:	cmp    %r14,%r15
  21b0f9:	mov    $0x0,%r12d
  21b0ff:	cmovbe %r15,%r12
  21b103:	mov    0x18(%rsp),%r13
  21b108:	cmova  0x20(%rsp),%r13
  21b10e:	sub    %r12,%r14
  21b111:	imul   %rbp,%r14
  21b115:	lea    0x0(,%r14,8),%r14
  21b11d:	add    %r13,%r14
  21b120:	lea    (%r14,%rbp,8),%r12
  21b124:	mov    %r14,(%r11)
  21b127:	mov    %r12,0x8(%r11)
  21b12b:	cmp    0x8(%rsp),%rax
  21b130:	jae    21b4e6 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5e6>
  21b136:	mov    0x30(%rsp),%r11
  21b13b:	mov    %r10b,(%r11,%rax,1)
  21b13f:	cmp    %rdi,0x10(%rsp)
  21b144:	jbe    21b50b <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x60b>
  21b14a:	mov    0x38(%rsp),%r10
  21b14f:	incq   (%r10,%rdi,8)
  21b153:	inc    %rax
  21b156:	mov    (%rbx),%rdi
  21b159:	movzbl (%rdi),%r10d
  21b15d:	shrx   %r10d,-0x10(%r9),%r10d
  21b163:	and    0x8(%rdi),%r10d
  21b167:	movzbl %r10b,%r11d
  21b16b:	cmp    %r11,%rcx
  21b16e:	jbe    21b4c3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5c3>
  21b174:	mov    %r11d,%edi
  21b177:	shl    $0x4,%edi
  21b17a:	mov    (%rdx,%rdi,1),%r14
  21b17e:	mov    -0x10(%r9),%r12
  21b182:	lea    0x8(%r14),%r13
  21b186:	cmp    0x8(%rdx,%rdi,1),%r13
  21b18b:	mov    %r12,(%r14)
  21b18e:	mov    %r13,(%rdx,%rdi,1)
  21b192:	jne    21b212 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x312>
  21b194:	cmp    %rsi,%rax
  21b197:	jae    21b4d6 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5d6>
  21b19d:	mov    0x28(%rsp),%r14
  21b1a2:	mov    (%r14,%rax,4),%r14d
  21b1a6:	cmp    %r14,%rsi
  21b1a9:	jbe    21b4aa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5aa>
  21b1af:	add    %rdx,%rdi
  21b1b2:	cmp    %r14,%r15
  21b1b5:	mov    $0x0,%r12d
  21b1bb:	cmovbe %r15,%r12
  21b1bf:	mov    0x18(%rsp),%r13
  21b1c4:	cmova  0x20(%rsp),%r13
  21b1ca:	sub    %r12,%r14
  21b1cd:	imul   %rbp,%r14
  21b1d1:	lea    0x0(,%r14,8),%r14
  21b1d9:	add    %r13,%r14
  21b1dc:	lea    (%r14,%rbp,8),%r12
  21b1e0:	mov    %r14,(%rdi)
  21b1e3:	mov    %r12,0x8(%rdi)
  21b1e7:	cmp    0x8(%rsp),%rax
  21b1ec:	jae    21b4e6 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5e6>
  21b1f2:	mov    0x30(%rsp),%rdi
  21b1f7:	mov    %r10b,(%rdi,%rax,1)
  21b1fb:	cmp    %r11,0x10(%rsp)
  21b200:	jbe    21b483 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x583>
  21b206:	mov    0x38(%rsp),%rdi
  21b20b:	incq   (%rdi,%r11,8)
  21b20f:	inc    %rax
  21b212:	mov    (%rbx),%rdi
  21b215:	movzbl (%rdi),%r10d
  21b219:	shrx   %r10d,-0x8(%r9),%r10d
  21b21f:	and    0x8(%rdi),%r10d
  21b223:	movzbl %r10b,%r11d
  21b227:	cmp    %r11,%rcx
  21b22a:	jbe    21b4c3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5c3>
  21b230:	mov    %r11d,%edi
  21b233:	shl    $0x4,%edi
  21b236:	mov    (%rdx,%rdi,1),%r14
  21b23a:	mov    -0x8(%r9),%r12
  21b23e:	lea    0x8(%r14),%r13
  21b242:	cmp    0x8(%rdx,%rdi,1),%r13
  21b247:	mov    %r12,(%r14)
  21b24a:	mov    %r13,(%rdx,%rdi,1)
  21b24e:	jne    21b2ce <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x3ce>
  21b250:	cmp    %rsi,%rax
  21b253:	jae    21b4d6 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5d6>
  21b259:	mov    0x28(%rsp),%r14
  21b25e:	mov    (%r14,%rax,4),%r14d
  21b262:	cmp    %r14,%rsi
  21b265:	jbe    21b4aa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5aa>
  21b26b:	add    %rdx,%rdi
  21b26e:	cmp    %r14,%r15
  21b271:	mov    $0x0,%r12d
  21b277:	cmovbe %r15,%r12
  21b27b:	mov    0x18(%rsp),%r13
  21b280:	cmova  0x20(%rsp),%r13
  21b286:	sub    %r12,%r14
  21b289:	imul   %rbp,%r14
  21b28d:	lea    0x0(,%r14,8),%r14
  21b295:	add    %r13,%r14
  21b298:	lea    (%r14,%rbp,8),%r12
  21b29c:	mov    %r14,(%rdi)
  21b29f:	mov    %r12,0x8(%rdi)
  21b2a3:	cmp    0x8(%rsp),%rax
  21b2a8:	jae    21b4e6 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5e6>
  21b2ae:	mov    0x30(%rsp),%rdi
  21b2b3:	mov    %r10b,(%rdi,%rax,1)
  21b2b7:	cmp    %r11,0x10(%rsp)
  21b2bc:	jbe    21b483 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x583>
  21b2c2:	mov    0x38(%rsp),%rdi
  21b2c7:	incq   (%rdi,%r11,8)
  21b2cb:	inc    %rax
  21b2ce:	mov    (%rbx),%rdi
  21b2d1:	movzbl (%rdi),%r10d
  21b2d5:	shrx   %r10d,(%r9),%r10d
  21b2da:	and    0x8(%rdi),%r10d
  21b2de:	movzbl %r10b,%r11d
  21b2e2:	cmp    %r11,%rcx
  21b2e5:	jbe    21b4c3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5c3>
  21b2eb:	mov    %r11d,%edi
  21b2ee:	shl    $0x4,%edi
  21b2f1:	mov    (%rdx,%rdi,1),%r14
  21b2f5:	mov    (%r9),%r12
  21b2f8:	lea    0x8(%r14),%r13
  21b2fc:	cmp    0x8(%rdx,%rdi,1),%r13
  21b301:	mov    %r12,(%r14)
  21b304:	mov    %r13,(%rdx,%rdi,1)
  21b308:	jne    21b08c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x18c>
  21b30e:	cmp    %rsi,%rax
  21b311:	jae    21b4d6 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5d6>
  21b317:	mov    0x28(%rsp),%r14
  21b31c:	mov    (%r14,%rax,4),%r14d
  21b320:	cmp    %r14,%rsi
  21b323:	jbe    21b4aa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5aa>
  21b329:	add    %rdx,%rdi
  21b32c:	cmp    %r14,%r15
  21b32f:	mov    $0x0,%r12d
  21b335:	cmovbe %r15,%r12
  21b339:	mov    0x18(%rsp),%r13
  21b33e:	cmova  0x20(%rsp),%r13
  21b344:	sub    %r12,%r14
  21b347:	imul   %rbp,%r14
  21b34b:	lea    0x0(,%r14,8),%r14
  21b353:	add    %r13,%r14
  21b356:	lea    (%r14,%rbp,8),%r12
  21b35a:	mov    %r14,(%rdi)
  21b35d:	mov    %r12,0x8(%rdi)
  21b361:	cmp    0x8(%rsp),%rax
  21b366:	jae    21b4e6 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5e6>
  21b36c:	mov    0x30(%rsp),%rdi
  21b371:	mov    %r10b,(%rdi,%rax,1)
  21b375:	cmp    %r11,0x10(%rsp)
  21b37a:	ja     21b080 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x180>
  21b380:	jmp    21b483 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x583>
  21b385:	data16 cs nopw 0x0(%rax,%rax,1)
  21b390:	mov    0x60(%rsp),%r8
  21b395:	mov    %r8,%rdi
  21b398:	and    $0xfffffffffffffffc,%rdi
  21b39c:	cmp    %r8,%rdi
  21b39f:	je     21afb0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0xb0>
  21b3a5:	mov    0x80(%rsp),%r8
  21b3ad:	imul   %rbp,%r8
  21b3b1:	mov    0x50(%rsp),%r9
  21b3b6:	lea    (%r9,%r8,8),%r9
  21b3ba:	jmp    21b3da <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x4da>
  21b3bc:	nopl   0x0(%rax)
  21b3c0:	mov    0x38(%rsp),%r8
  21b3c5:	incq   (%r8,%r11,8)
  21b3c9:	inc    %rax
  21b3cc:	inc    %rdi
  21b3cf:	cmp    0x60(%rsp),%rdi
  21b3d4:	jae    21afb0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0xb0>
  21b3da:	mov    (%rbx),%r8
  21b3dd:	movzbl (%r8),%r10d
  21b3e1:	shrx   %r10d,(%r9,%rdi,8),%r10d
  21b3e7:	and    0x8(%r8),%r10d
  21b3eb:	movzbl %r10b,%r11d
  21b3ef:	cmp    %r11,%rcx
  21b3f2:	jbe    21b4c3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5c3>
  21b3f8:	mov    %r11d,%r8d
  21b3fb:	shl    $0x4,%r8d
  21b3ff:	mov    (%rdx,%r8,1),%r14
  21b403:	mov    (%r9,%rdi,8),%r12
  21b407:	lea    0x8(%r14),%r13
  21b40b:	cmp    0x8(%rdx,%r8,1),%r13
  21b410:	mov    %r12,(%r14)
  21b413:	mov    %r13,(%rdx,%r8,1)
  21b417:	jne    21b3cc <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x4cc>
  21b419:	cmp    %rsi,%rax
  21b41c:	jae    21b4d6 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5d6>
  21b422:	mov    0x28(%rsp),%r14
  21b427:	mov    (%r14,%rax,4),%r14d
  21b42b:	cmp    %r14,%rsi
  21b42e:	jbe    21b4aa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5aa>
  21b430:	add    %rdx,%r8
  21b433:	cmp    %r14,%r15
  21b436:	mov    $0x0,%r12d
  21b43c:	cmovbe %r15,%r12
  21b440:	mov    0x18(%rsp),%r13
  21b445:	cmova  0x20(%rsp),%r13
  21b44b:	sub    %r12,%r14
  21b44e:	imul   %rbp,%r14
  21b452:	lea    0x0(,%r14,8),%r14
  21b45a:	add    %r13,%r14
  21b45d:	lea    (%r14,%rbp,8),%r12
  21b461:	mov    %r14,(%r8)
  21b464:	mov    %r12,0x8(%r8)
  21b468:	cmp    0x8(%rsp),%rax
  21b46d:	jae    21b4e6 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5e6>
  21b46f:	mov    0x30(%rsp),%r8
  21b474:	mov    %r10b,(%r8,%rax,1)
  21b478:	cmp    %r11,0x10(%rsp)
  21b47d:	ja     21b3c0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x4c0>
  21b483:	lea    0x1c328e(%rip),%rdx        # 3de718 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x328>
  21b48a:	mov    %r11,%rdi
  21b48d:	mov    0x10(%rsp),%rsi
  21b492:	call   *0x1c6080(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21b498:	add    $0x88,%rsp
  21b49f:	pop    %rbx
  21b4a0:	pop    %r12
  21b4a2:	pop    %r13
  21b4a4:	pop    %r14
  21b4a6:	pop    %r15
  21b4a8:	pop    %rbp
  21b4a9:	ret
  21b4aa:	lea    -0x205481(%rip),%rdi        # 16030 <anon.7fa33eb33931318ee6b6568b4abff869.3.llvm.17153750559840045314+0xf3>
  21b4b1:	lea    0x1c32f0(%rip),%rdx        # 3de7a8 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x3b8>
  21b4b8:	mov    $0x2c,%esi
  21b4bd:	call   *0x1c60c5(%rip)        # 3e1588 <_DYNAMIC+0x2f0>
  21b4c3:	lea    0x1c3206(%rip),%rdx        # 3de6d0 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x2e0>
  21b4ca:	mov    %r11,%rdi
  21b4cd:	mov    %rcx,%rsi
  21b4d0:	call   *0x1c6042(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21b4d6:	lea    0x1c320b(%rip),%rdx        # 3de6e8 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x2f8>
  21b4dd:	mov    %rax,%rdi
  21b4e0:	call   *0x1c6032(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21b4e6:	lea    0x1c3213(%rip),%rdx        # 3de700 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x310>
  21b4ed:	mov    %rax,%rdi
  21b4f0:	mov    0x8(%rsp),%rsi
  21b4f5:	call   *0x1c601d(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21b4fb:	lea    0x1c31ce(%rip),%rdx        # 3de6d0 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x2e0>
  21b502:	mov    %rcx,%rsi
  21b505:	call   *0x1c600d(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21b50b:	lea    0x1c3206(%rip),%rdx        # 3de718 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x328>
  21b512:	mov    0x10(%rsp),%rsi
  21b517:	call   *0x1c5ffb(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21b51d:	lea    0x1c2fbc(%rip),%rdx        # 3de4e0 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0xf0>
  21b524:	mov    0x48(%rsp),%rdi
  21b529:	call   *0x1c5fe9(%rip)        # 3e1518 <_DYNAMIC+0x280>

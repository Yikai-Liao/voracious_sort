
experiments/block_msd/target/pa-outline-final/time:     file format elf64-x86-64


Disassembly of section .text:

000000000014fed0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>>:
  14fed0:	push   %rbp
  14fed1:	push   %r15
  14fed3:	push   %r14
  14fed5:	push   %r13
  14fed7:	push   %r12
  14fed9:	push   %rbx
  14feda:	sub    $0x88,%rsp
  14fee1:	mov    %rsi,%r13
  14fee4:	mov    0x80(%rdi),%r14
  14feeb:	mov    %r14,%r12
  14feee:	shl    $0x4,%r12
  14fef2:	mov    %r14,%rax
  14fef5:	shr    $0x3c,%rax
  14fef9:	setne  %al
  14fefc:	movabs $0x7ffffffffffffff8,%rsi
  14ff06:	cmp    %rsi,%r12
  14ff09:	seta   %sil
  14ff0d:	or     %al,%sil
  14ff10:	je     14ff1d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x4d>
  14ff12:	xor    %edi,%edi
  14ff14:	mov    %r12,%rsi
  14ff17:	call   *0x36b233(%rip)        # 4bb150 <_DYNAMIC+0x260>
  14ff1d:	mov    %rdi,%r15
  14ff20:	mov    %rdx,0x40(%rsp)
  14ff25:	test   %r12,%r12
  14ff28:	je     14ffa1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xd1>
  14ff2a:	mov    %ecx,%ebp
  14ff2c:	mov    %r8d,%ebx
  14ff2f:	call   *0x36b223(%rip)        # 4bb158 <_DYNAMIC+0x268>
  14ff35:	mov    %r12,%rdi
  14ff38:	call   *0x36b222(%rip)        # 4bb160 <malloc@GLIBC_2.2.5>
  14ff3e:	mov    %rax,0x8(%rsp)
  14ff43:	test   %rax,%rax
  14ff46:	je     150933 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa63>
  14ff4c:	movzbl 0x36d565(%rip),%eax        # 4bd4b8 <frontier_experiment::TRACK>
  14ff53:	test   %al,%al
  14ff55:	je     14ff95 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xc5>
  14ff57:	lock incq 0x36d561(%rip)        # 4bd4c0 <frontier_experiment::ALLOCS>
  14ff5f:	lock add %r12,0x36d561(%rip)        # 4bd4c8 <frontier_experiment::REQUESTED>
  14ff67:	mov    %r12,%rcx
  14ff6a:	lock xadd %rcx,0x36d535(%rip)        # 4bd4a8 <frontier_experiment::LIVE>
  14ff73:	add    %r12,%rcx
  14ff76:	mov    0x36d533(%rip),%rax        # 4bd4b0 <frontier_experiment::PEAK>
  14ff7d:	nopl   (%rax)
  14ff80:	cmp    %rcx,%rax
  14ff83:	mov    %rcx,%rdx
  14ff86:	cmova  %rax,%rdx
  14ff8a:	lock cmpxchg %rdx,0x36d51d(%rip)        # 4bd4b0 <frontier_experiment::PEAK>
  14ff93:	jne    14ff80 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xb0>
  14ff95:	mov    %r14,0x28(%rsp)
  14ff9a:	mov    %ebx,%r8d
  14ff9d:	mov    %ebp,%ecx
  14ff9f:	jmp    14ffb4 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xe4>
  14ffa1:	mov    $0x8,%eax
  14ffa6:	mov    %rax,0x8(%rsp)
  14ffab:	movq   $0x0,0x28(%rsp)
  14ffb4:	cmp    $0x2,%r14
  14ffb8:	mov    %r15,0x30(%rsp)
  14ffbd:	mov    %r14,0x20(%rsp)
  14ffc2:	mov    %r8d,0x48(%rsp)
  14ffc7:	mov    %ecx,0x50(%rsp)
  14ffcb:	jb     14ffec <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x11c>
  14ffcd:	lea    -0x10(%r12),%rdx
  14ffd2:	mov    0x8(%rsp),%rbx
  14ffd7:	mov    %rbx,%rdi
  14ffda:	xor    %esi,%esi
  14ffdc:	call   *0x36b186(%rip)        # 4bb168 <memset@GLIBC_2.2.5>
  14ffe2:	lea    (%rbx,%r12,1),%rax
  14ffe6:	add    $0xfffffffffffffff0,%rax
  14ffea:	jmp    14fffa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x12a>
  14ffec:	mov    0x8(%rsp),%rax
  14fff1:	test   %r14,%r14
  14fff4:	je     1505a4 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x6d4>
  14fffa:	lea    0x0(,%r14,8),%rbx
  150002:	vxorps %xmm0,%xmm0,%xmm0
  150006:	vmovups %xmm0,(%rax)
  15000a:	call   *0x36b148(%rip)        # 4bb158 <_DYNAMIC+0x268>
  150010:	mov    %rbx,%rdi
  150013:	call   *0x36b147(%rip)        # 4bb160 <malloc@GLIBC_2.2.5>
  150019:	test   %rax,%rax
  15001c:	je     150923 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa53>
  150022:	mov    %rax,%r8
  150025:	movzbl 0x36d48c(%rip),%eax        # 4bd4b8 <frontier_experiment::TRACK>
  15002c:	test   %al,%al
  15002e:	je     150075 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1a5>
  150030:	lock incq 0x36d488(%rip)        # 4bd4c0 <frontier_experiment::ALLOCS>
  150038:	lock add %rbx,0x36d488(%rip)        # 4bd4c8 <frontier_experiment::REQUESTED>
  150040:	mov    %rbx,%rcx
  150043:	lock xadd %rcx,0x36d45c(%rip)        # 4bd4a8 <frontier_experiment::LIVE>
  15004c:	add    %rbx,%rcx
  15004f:	mov    0x36d45a(%rip),%rax        # 4bd4b0 <frontier_experiment::PEAK>
  150056:	cs nopw 0x0(%rax,%rax,1)
  150060:	cmp    %rcx,%rax
  150063:	mov    %rcx,%rdx
  150066:	cmova  %rax,%rdx
  15006a:	lock cmpxchg %rdx,0x36d43d(%rip)        # 4bd4b0 <frontier_experiment::PEAK>
  150073:	jne    150060 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x190>
  150075:	mov    %r13,0x38(%rsp)
  15007a:	mov    $0x1,%eax
  15007f:	mov    %rax,0x18(%rsp)
  150084:	mov    %r8,%rax
  150087:	cmp    $0x2,%r14
  15008b:	jb     150108 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x238>
  15008d:	lea    -0x1(%r14),%rdx
  150091:	mov    $0x1,%ecx
  150096:	mov    %r8,%rax
  150099:	cmp    $0x10,%rdx
  15009d:	jb     1500f0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x220>
  15009f:	mov    %rdx,%rsi
  1500a2:	and    $0xfffffffffffffff0,%rsi
  1500a6:	lea    (%r8,%rsi,8),%rax
  1500aa:	lea    0x1(%rsi),%rcx
  1500ae:	xor    %edi,%edi
  1500b0:	vbroadcastsd -0x13fd99(%rip),%ymm0        # 10320 <__abi_tag+0x10024>
  1500b9:	nopl   0x0(%rax)
  1500c0:	vmovups %ymm0,(%r8,%rdi,8)
  1500c6:	vmovups %ymm0,0x20(%r8,%rdi,8)
  1500cd:	vmovups %ymm0,0x40(%r8,%rdi,8)
  1500d4:	vmovups %ymm0,0x60(%r8,%rdi,8)
  1500db:	add    $0x10,%rdi
  1500df:	cmp    %rdi,%rsi
  1500e2:	jne    1500c0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1f0>
  1500e4:	mov    %r14,0x18(%rsp)
  1500e9:	cmp    %rsi,%rdx
  1500ec:	je     150108 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x238>
  1500ee:	xchg   %ax,%ax
  1500f0:	inc    %rcx
  1500f3:	movq   $0x1,(%rax)
  1500fa:	add    $0x8,%rax
  1500fe:	cmp    %rcx,%r14
  150101:	jne    1500f0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x220>
  150103:	mov    %r14,0x18(%rsp)
  150108:	mov    %r8,0x10(%rsp)
  15010d:	movq   $0x1,(%rax)
  150114:	mov    0x8(%rsp),%r15
  150119:	add    %r15,%r12
  15011c:	mov    0x30(%rsp),%rdx
  150121:	mov    0x20(%rdx),%rax
  150125:	mov    0x28(%rdx),%rdi
  150129:	mov    0x88(%rdx),%rcx
  150130:	mov    0xa0(%rdx),%rsi
  150137:	mov    0x90(%rdx),%r13
  15013e:	mov    0x78(%rdx),%r10
  150142:	mov    0x58(%rdx),%r9
  150146:	mov    0x50(%rdx),%r11
  15014a:	xor    %ebx,%ebx
  15014c:	lea    0x35fccd(%rip),%rdx        # 4afe20 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x268>
  150153:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  150160:	cmp    %rbx,%rdi
  150163:	je     15089e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x9ce>
  150169:	mov    (%rax,%rbx,4),%ebp
  15016c:	cmp    %rbp,%rdi
  15016f:	jbe    1507ec <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x91c>
  150175:	cmp    %rbp,%rcx
  150178:	mov    $0x0,%r14d
  15017e:	cmovbe %rcx,%r14
  150182:	mov    %r13,%r8
  150185:	cmova  %rsi,%r8
  150189:	sub    %r14,%rbp
  15018c:	imul   %r10,%rbp
  150190:	lea    (%r8,%rbp,8),%r8
  150194:	lea    (%r8,%r10,8),%r14
  150198:	mov    %r8,(%r15)
  15019b:	mov    %r14,0x8(%r15)
  15019f:	cmp    %rbx,%r9
  1501a2:	je     150894 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x9c4>
  1501a8:	mov    %bl,(%r11,%rbx,1)
  1501ac:	add    $0x10,%r15
  1501b0:	inc    %rbx
  1501b3:	cmp    %r12,%r15
  1501b6:	jne    150160 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x290>
  1501b8:	mov    0x10(%rsp),%rbx
  1501bd:	mov    0x30(%rsp),%r15
  1501c2:	mov    0x20(%rsp),%r14
  1501c7:	mov    0x38(%rsp),%r13
  1501cc:	cmpb   $0x0,0x50(%rsp)
  1501d1:	mov    0x40(%rsp),%rdx
  1501d6:	je     1505c2 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x6f2>
  1501dc:	mov    0x0(%r13),%rsi
  1501e0:	movzbl 0x48(%rsp),%ecx
  1501e5:	mov    %r15,%rdi
  1501e8:	mov    0x8(%rsp),%r8
  1501ed:	mov    %r14,%r9
  1501f0:	push   %r14
  1501f2:	push   %rbx
  1501f3:	vzeroupper
  1501f6:	call   13d150 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_grouped::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>>
  1501fb:	add    $0x10,%rsp
  1501ff:	mov    %rax,0x40(%rsp)
  150204:	mov    %rax,0xa8(%r15)
  15020b:	lea    0x60(%rsp),%rdi
  150210:	mov    %r14,%rsi
  150213:	mov    %r14,%rdx
  150216:	call   b4410 <alloc::vec::from_elem::<usize>>
  15021b:	cmp    $0x2,%r14
  15021f:	mov    %rbx,0x10(%rsp)
  150224:	jb     1502a3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x3d3>
  150226:	mov    0x68(%rsp),%rax
  15022b:	mov    0x70(%rsp),%rsi
  150230:	cmp    $0x1,%rsi
  150234:	mov    %rsi,%rcx
  150237:	adc    $0x0,%rcx
  15023b:	lea    -0x1(%rcx),%rdi
  15023f:	lea    -0x1(%r14),%r8
  150243:	mov    $0x1,%r13d
  150249:	xor    %r12d,%r12d
  15024c:	lea    0x35fb5d(%rip),%rdx        # 4afdb0 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x1f8>
  150253:	lea    0x35fb6e(%rip),%r9        # 4afdc8 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x210>
  15025a:	lea    0x35fb7f(%rip),%r10        # 4afde0 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x228>
  150261:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  150270:	cmp    %r12,%rsi
  150273:	je     150905 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa35>
  150279:	cmp    %r12,%r14
  15027c:	je     15090d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa3d>
  150282:	cmp    %r12,%rdi
  150285:	je     1508fd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa2d>
  15028b:	mov    (%rax,%r12,8),%r11
  15028f:	add    (%rbx,%r12,8),%r11
  150293:	mov    %r11,0x8(%rax,%r12,8)
  150298:	inc    %r12
  15029b:	inc    %r13
  15029e:	cmp    %r12,%r8
  1502a1:	jne    150270 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x3a0>
  1502a3:	mov    0x40(%rsp),%rdi
  1502a8:	test   %rdi,%rdi
  1502ab:	je     15055b <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x68b>
  1502b1:	mov    0x58(%r15),%r12
  1502b5:	mov    0x50(%r15),%rax
  1502b9:	mov    %rax,0x50(%rsp)
  1502be:	mov    0x68(%rsp),%rcx
  1502c3:	mov    0x70(%rsp),%rsi
  1502c8:	mov    0x20(%r15),%rax
  1502cc:	mov    %rax,0x48(%rsp)
  1502d1:	mov    0x28(%r15),%rbp
  1502d5:	mov    0x40(%r15),%rax
  1502d9:	mov    %rax,0x38(%rsp)
  1502de:	mov    0x38(%r15),%rax
  1502e2:	mov    %rax,0x80(%rsp)
  1502ea:	mov    0x88(%r15),%r11
  1502f1:	mov    0xa0(%r15),%r9
  1502f8:	mov    0x90(%r15),%rdx
  1502ff:	mov    %r15,%rax
  150302:	mov    0x78(%r15),%r15
  150306:	mov    0x70(%rax),%rdi
  15030a:	mov    %rdi,0x58(%rsp)
  15030f:	mov    0x68(%rax),%rax
  150313:	mov    %rax,0x78(%rsp)
  150318:	xor    %r13d,%r13d
  15031b:	mov    0x8(%rsp),%r10
  150320:	jmp    150362 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x492>
  150322:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  150330:	add    0x8(%rsp),%rdi
  150335:	mov    (%rdi),%rdi
  150338:	sub    %rax,%rdi
  15033b:	sar    $0x3,%rdi
  15033f:	shl    $0x4,%r14d
  150343:	mov    0x78(%rsp),%rax
  150348:	mov    %rbx,(%rax,%r14,1)
  15034c:	mov    %rdi,0x8(%rax,%r14,1)
  150351:	inc    %r13
  150354:	mov    0x40(%rsp),%rdi
  150359:	cmp    %r13,%rdi
  15035c:	je     150419 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x549>
  150362:	cmp    %r13,%r12
  150365:	je     1508d1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa01>
  15036b:	mov    0x50(%rsp),%rax
  150370:	movzbl (%rax,%r13,1),%r14d
  150375:	cmp    %r14,%rsi
  150378:	jbe    1508c5 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x9f5>
  15037e:	mov    (%rcx,%r14,8),%rbx
  150382:	lea    0x1(%rbx),%rax
  150386:	mov    %rax,(%rcx,%r14,8)
  15038a:	cmp    %r13,%rbp
  15038d:	je     1508dd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa0d>
  150393:	cmp    0x38(%rsp),%rbx
  150398:	jae    1508b4 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x9e4>
  15039e:	mov    0x48(%rsp),%rax
  1503a3:	mov    (%rax,%r13,4),%eax
  1503a7:	mov    0x80(%rsp),%rdi
  1503af:	mov    %eax,(%rdi,%rbx,4)
  1503b2:	cmp    %rax,%rbp
  1503b5:	jbe    150812 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x942>
  1503bb:	cmp    %rax,%r11
  1503be:	mov    $0x0,%r8d
  1503c4:	cmovbe %r11,%r8
  1503c8:	mov    %rdx,%rdi
  1503cb:	cmova  %r9,%rdi
  1503cf:	cmp    %r14,0x20(%rsp)
  1503d4:	jbe    1508ec <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa1c>
  1503da:	sub    %r8,%rax
  1503dd:	imul   %r15,%rax
  1503e1:	lea    (%rdi,%rax,8),%rax
  1503e5:	lea    (%rax,%r15,8),%r8
  1503e9:	mov    %r14d,%edi
  1503ec:	shl    $0x4,%edi
  1503ef:	cmp    0x8(%r10,%rdi,1),%r8
  1503f4:	jne    150351 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x481>
  1503fa:	cmp    %r14,0x58(%rsp)
  1503ff:	ja     150330 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x460>
  150405:	mov    %r14,%r12
  150408:	mov    0x58(%rsp),%rsi
  15040d:	lea    0x35f984(%rip),%rdx        # 4afd98 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x1e0>
  150414:	jmp    150913 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  150419:	mov    0x30(%rsp),%r15
  15041e:	mov    0x20(%rsp),%r14
  150423:	lea    (%r14,%rdi,1),%r13
  150427:	mov    %rbp,%rbx
  15042a:	sub    %r13,%rbx
  15042d:	jb     15056f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x69f>
  150433:	mov    %r14,%rax
  150436:	mov    0x40(%r15),%r14
  15043a:	cmp    %r14,%rax
  15043d:	ja     150844 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x974>
  150443:	cmp    %rdi,%r13
  150446:	jb     150835 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x965>
  15044c:	mov    %r15,%rax
  15044f:	mov    0x38(%r15),%r15
  150453:	mov    0x20(%rax),%r12
  150457:	lea    (%r12,%rdi,4),%rsi
  15045b:	mov    0x20(%rsp),%rdx
  150460:	shl    $0x2,%rdx
  150464:	mov    %r15,%rdi
  150467:	call   *0x36ad03(%rip)        # 4bb170 <memcpy@GLIBC_2.14>
  15046d:	mov    %r14,%rdx
  150470:	sub    %r13,%rdx
  150473:	jb     150854 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x984>
  150479:	cmp    %rbp,%r14
  15047c:	jne    150874 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x9a4>
  150482:	lea    (%r12,%r13,4),%rsi
  150486:	lea    (%r15,%r13,4),%rdi
  15048a:	shl    $0x2,%rdx
  15048e:	call   *0x36acdc(%rip)        # 4bb170 <memcpy@GLIBC_2.14>
  150494:	mov    0x30(%rsp),%rdx
  150499:	mov    %r13,0xa8(%rdx)
  1504a0:	mov    0x18(%rdx),%rax
  1504a4:	mov    0x30(%rdx),%rcx
  1504a8:	mov    %rcx,0x18(%rdx)
  1504ac:	mov    %rax,0x30(%rdx)
  1504b0:	mov    %r15,0x20(%rdx)
  1504b4:	mov    %r12,0x38(%rdx)
  1504b8:	mov    %rbp,0x28(%rdx)
  1504bc:	mov    %rbp,0x40(%rdx)
  1504c0:	mov    0x60(%rsp),%rax
  1504c5:	test   %rax,%rax
  1504c8:	je     1504ec <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x61c>
  1504ca:	mov    0x68(%rsp),%rdi
  1504cf:	movzbl 0x36cfe2(%rip),%ecx        # 4bd4b8 <frontier_experiment::TRACK>
  1504d6:	test   %cl,%cl
  1504d8:	je     1504e6 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x616>
  1504da:	shl    $0x3,%rax
  1504de:	lock sub %rax,0x36cfc2(%rip)        # 4bd4a8 <frontier_experiment::LIVE>
  1504e6:	call   *0x36ac8c(%rip)        # 4bb178 <free@GLIBC_2.2.5>
  1504ec:	cmpq   $0x0,0x18(%rsp)
  1504f2:	mov    0x10(%rsp),%rdi
  1504f7:	je     15051b <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x64b>
  1504f9:	movzbl 0x36cfb8(%rip),%eax        # 4bd4b8 <frontier_experiment::TRACK>
  150500:	test   %al,%al
  150502:	je     150515 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x645>
  150504:	mov    0x18(%rsp),%rax
  150509:	shl    $0x3,%rax
  15050d:	lock sub %rax,0x36cf93(%rip)        # 4bd4a8 <frontier_experiment::LIVE>
  150515:	call   *0x36ac5d(%rip)        # 4bb178 <free@GLIBC_2.2.5>
  15051b:	cmpq   $0x0,0x28(%rsp)
  150521:	je     150592 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x6c2>
  150523:	movzbl 0x36cf8e(%rip),%eax        # 4bd4b8 <frontier_experiment::TRACK>
  15052a:	test   %al,%al
  15052c:	je     15053f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x66f>
  15052e:	mov    0x28(%rsp),%rax
  150533:	shl    $0x4,%rax
  150537:	lock sub %rax,0x36cf69(%rip)        # 4bd4a8 <frontier_experiment::LIVE>
  15053f:	mov    0x8(%rsp),%rdi
  150544:	add    $0x88,%rsp
  15054b:	pop    %rbx
  15054c:	pop    %r12
  15054e:	pop    %r13
  150550:	pop    %r14
  150552:	pop    %r15
  150554:	pop    %rbp
  150555:	jmp    *0x36ac1d(%rip)        # 4bb178 <free@GLIBC_2.2.5>
  15055b:	mov    0x28(%r15),%rbp
  15055f:	lea    (%r14,%rdi,1),%r13
  150563:	mov    %rbp,%rbx
  150566:	sub    %r13,%rbx
  150569:	jae    150433 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x563>
  15056f:	lea    -0x13a4b1(%rip),%rdi        # 160c5 <anon.8f17df2f0ddc4723825c0f55871536dc.0.llvm.4211023910758936617+0x45>
  150576:	lea    0x35f6fb(%rip),%rdx        # 4afc78 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0xc0>
  15057d:	mov    $0x41,%esi
  150582:	mov    0x10(%rsp),%rbx
  150587:	call   *0x36abf3(%rip)        # 4bb180 <_DYNAMIC+0x290>
  15058d:	jmp    150949 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  150592:	add    $0x88,%rsp
  150599:	pop    %rbx
  15059a:	pop    %r12
  15059c:	pop    %r13
  15059e:	pop    %r14
  1505a0:	pop    %r15
  1505a2:	pop    %rbp
  1505a3:	ret
  1505a4:	mov    $0x8,%ebx
  1505a9:	movq   $0x0,0x18(%rsp)
  1505b2:	cmpb   $0x0,0x50(%rsp)
  1505b7:	mov    0x40(%rsp),%rdx
  1505bc:	jne    1501dc <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x30c>
  1505c2:	cmp    $0xf,%rdx
  1505c6:	ja     150941 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa71>
  1505cc:	lea    -0x13bf37(%rip),%rax        # 1469c <anon.1b06fbe60509ae926a49330b91708f0a.11.llvm.11709953318905502329+0x17b0>
  1505d3:	movslq (%rax,%rdx,4),%rcx
  1505d7:	add    %rax,%rcx
  1505da:	jmp    *%rcx
  1505dc:	mov    %r15,%rdi
  1505df:	mov    %r13,%rsi
  1505e2:	mov    0x8(%rsp),%rdx
  1505e7:	mov    %r14,%rcx
  1505ea:	mov    %rbx,%r8
  1505ed:	mov    %r14,%r9
  1505f0:	vzeroupper
  1505f3:	call   141780 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>>
  1505f8:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1505fd:	mov    %r15,%rdi
  150600:	mov    %r13,%rsi
  150603:	mov    0x8(%rsp),%rdx
  150608:	mov    %r14,%rcx
  15060b:	mov    %rbx,%r8
  15060e:	mov    %r14,%r9
  150611:	vzeroupper
  150614:	call   142400 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>>
  150619:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  15061e:	mov    %r15,%rdi
  150621:	mov    %r13,%rsi
  150624:	mov    0x8(%rsp),%rdx
  150629:	mov    %r14,%rcx
  15062c:	mov    %rbx,%r8
  15062f:	mov    %r14,%r9
  150632:	vzeroupper
  150635:	call   142a50 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>>
  15063a:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  15063f:	mov    %r15,%rdi
  150642:	mov    %r13,%rsi
  150645:	mov    0x8(%rsp),%rdx
  15064a:	mov    %r14,%rcx
  15064d:	mov    %rbx,%r8
  150650:	mov    %r14,%r9
  150653:	vzeroupper
  150656:	call   141780 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>>
  15065b:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  150660:	mov    %r15,%rdi
  150663:	mov    %r13,%rsi
  150666:	mov    0x8(%rsp),%rdx
  15066b:	mov    %r14,%rcx
  15066e:	mov    %rbx,%r8
  150671:	mov    %r14,%r9
  150674:	vzeroupper
  150677:	call   141780 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>>
  15067c:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  150681:	mov    %r15,%rdi
  150684:	mov    %r13,%rsi
  150687:	mov    0x8(%rsp),%rdx
  15068c:	mov    %r14,%rcx
  15068f:	mov    %rbx,%r8
  150692:	mov    %r14,%r9
  150695:	vzeroupper
  150698:	call   141db0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>>
  15069d:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1506a2:	mov    %r15,%rdi
  1506a5:	mov    %r13,%rsi
  1506a8:	mov    0x8(%rsp),%rdx
  1506ad:	mov    %r14,%rcx
  1506b0:	mov    %rbx,%r8
  1506b3:	mov    %r14,%r9
  1506b6:	vzeroupper
  1506b9:	call   142400 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>>
  1506be:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1506c3:	mov    %r15,%rdi
  1506c6:	mov    %r13,%rsi
  1506c9:	mov    0x8(%rsp),%rdx
  1506ce:	mov    %r14,%rcx
  1506d1:	mov    %rbx,%r8
  1506d4:	mov    %r14,%r9
  1506d7:	vzeroupper
  1506da:	call   142a50 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>>
  1506df:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1506e4:	mov    %r15,%rdi
  1506e7:	mov    %r13,%rsi
  1506ea:	mov    0x8(%rsp),%rdx
  1506ef:	mov    %r14,%rcx
  1506f2:	mov    %rbx,%r8
  1506f5:	mov    %r14,%r9
  1506f8:	vzeroupper
  1506fb:	call   142a50 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>>
  150700:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  150705:	mov    %r15,%rdi
  150708:	mov    %r13,%rsi
  15070b:	mov    0x8(%rsp),%rdx
  150710:	mov    %r14,%rcx
  150713:	mov    %rbx,%r8
  150716:	mov    %r14,%r9
  150719:	vzeroupper
  15071c:	call   142a50 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>>
  150721:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  150726:	mov    %r15,%rdi
  150729:	mov    %r13,%rsi
  15072c:	mov    0x8(%rsp),%rdx
  150731:	mov    %r14,%rcx
  150734:	mov    %rbx,%r8
  150737:	mov    %r14,%r9
  15073a:	vzeroupper
  15073d:	call   141db0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>>
  150742:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  150747:	mov    %r15,%rdi
  15074a:	mov    %r13,%rsi
  15074d:	mov    0x8(%rsp),%rdx
  150752:	mov    %r14,%rcx
  150755:	mov    %rbx,%r8
  150758:	mov    %r14,%r9
  15075b:	vzeroupper
  15075e:	call   141db0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>>
  150763:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  150768:	mov    %r15,%rdi
  15076b:	mov    %r13,%rsi
  15076e:	mov    0x8(%rsp),%rdx
  150773:	mov    %r14,%rcx
  150776:	mov    %rbx,%r8
  150779:	mov    %r14,%r9
  15077c:	vzeroupper
  15077f:	call   141db0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>>
  150784:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  150789:	mov    %r15,%rdi
  15078c:	mov    %r13,%rsi
  15078f:	mov    0x8(%rsp),%rdx
  150794:	mov    %r14,%rcx
  150797:	mov    %rbx,%r8
  15079a:	mov    %r14,%r9
  15079d:	vzeroupper
  1507a0:	call   142400 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>>
  1507a5:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1507aa:	mov    %r15,%rdi
  1507ad:	mov    %r13,%rsi
  1507b0:	mov    0x8(%rsp),%rdx
  1507b5:	mov    %r14,%rcx
  1507b8:	mov    %rbx,%r8
  1507bb:	mov    %r14,%r9
  1507be:	vzeroupper
  1507c1:	call   142400 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>>
  1507c6:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1507cb:	mov    %r15,%rdi
  1507ce:	mov    %r13,%rsi
  1507d1:	mov    0x8(%rsp),%rdx
  1507d6:	mov    %r14,%rcx
  1507d9:	mov    %rbx,%r8
  1507dc:	mov    %r14,%r9
  1507df:	vzeroupper
  1507e2:	call   141780 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>>
  1507e7:	jmp    1501ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1507ec:	lea    -0x13a680(%rip),%rdi        # 16173 <anon.8f17df2f0ddc4723825c0f55871536dc.0.llvm.4211023910758936617+0xf3>
  1507f3:	lea    0x35f72e(%rip),%rdx        # 4aff28 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x370>
  1507fa:	mov    $0x2c,%esi
  1507ff:	mov    0x10(%rsp),%rbx
  150804:	vzeroupper
  150807:	call   *0x36a973(%rip)        # 4bb180 <_DYNAMIC+0x290>
  15080d:	jmp    150949 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  150812:	lea    -0x13a6a6(%rip),%rdi        # 16173 <anon.8f17df2f0ddc4723825c0f55871536dc.0.llvm.4211023910758936617+0xf3>
  150819:	lea    0x35f708(%rip),%rdx        # 4aff28 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x370>
  150820:	mov    $0x2c,%esi
  150825:	mov    0x10(%rsp),%rbx
  15082a:	call   *0x36a950(%rip)        # 4bb180 <_DYNAMIC+0x290>
  150830:	jmp    150949 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  150835:	lea    0x35f46c(%rip),%rcx        # 4afca8 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0xf0>
  15083c:	mov    %r13,%rsi
  15083f:	mov    %rbp,%r14
  150842:	jmp    150861 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x991>
  150844:	lea    0x35f445(%rip),%rcx        # 4afc90 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0xd8>
  15084b:	xor    %edi,%edi
  15084d:	mov    0x20(%rsp),%rsi
  150852:	jmp    150861 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x991>
  150854:	lea    0x35f465(%rip),%rcx        # 4afcc0 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x108>
  15085b:	mov    %r13,%rdi
  15085e:	mov    %r14,%rsi
  150861:	mov    %r14,%rdx
  150864:	mov    0x10(%rsp),%rbx
  150869:	call   *0x36a919(%rip)        # 4bb188 <_DYNAMIC+0x298>
  15086f:	jmp    150949 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  150874:	lea    0x35f475(%rip),%rax        # 4afcf0 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x138>
  15087b:	mov    %rdx,%rdi
  15087e:	mov    %rbx,%rsi
  150881:	mov    %rax,%rdx
  150884:	mov    0x10(%rsp),%rbx
  150889:	call   *0x36a901(%rip)        # 4bb190 <_DYNAMIC+0x2a0>
  15088f:	jmp    150949 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  150894:	mov    %r9,%rdi
  150897:	lea    0x35f59a(%rip),%rdx        # 4afe38 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x280>
  15089e:	mov    %rdi,%rsi
  1508a1:	mov    0x10(%rsp),%rbx
  1508a6:	vzeroupper
  1508a9:	call   *0x36a8e9(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  1508af:	jmp    150949 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  1508b4:	mov    %rbx,%r12
  1508b7:	mov    0x38(%rsp),%rsi
  1508bc:	lea    0x35f48d(%rip),%rdx        # 4afd50 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x198>
  1508c3:	jmp    150913 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  1508c5:	mov    %r14,%r12
  1508c8:	lea    0x35f451(%rip),%rdx        # 4afd20 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x168>
  1508cf:	jmp    150913 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  1508d1:	mov    %r12,%rsi
  1508d4:	lea    0x35f42d(%rip),%rdx        # 4afd08 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x150>
  1508db:	jmp    150913 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  1508dd:	mov    %rbp,%r12
  1508e0:	mov    %rbp,%rsi
  1508e3:	lea    0x35f44e(%rip),%rdx        # 4afd38 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x180>
  1508ea:	jmp    150913 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  1508ec:	mov    %r14,%r12
  1508ef:	mov    0x20(%rsp),%rsi
  1508f4:	lea    0x35f485(%rip),%rdx        # 4afd80 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x1c8>
  1508fb:	jmp    150913 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  1508fd:	mov    %rcx,%r12
  150900:	mov    %r10,%rdx
  150903:	jmp    150913 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  150905:	dec    %r13
  150908:	mov    %r13,%r12
  15090b:	jmp    150913 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  15090d:	mov    %r14,%rsi
  150910:	mov    %r9,%rdx
  150913:	mov    %r12,%rdi
  150916:	mov    0x10(%rsp),%rbx
  15091b:	call   *0x36a877(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  150921:	jmp    150949 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  150923:	mov    $0x8,%edi
  150928:	mov    %rbx,%rsi
  15092b:	call   *0x36a81f(%rip)        # 4bb150 <_DYNAMIC+0x260>
  150931:	jmp    150949 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  150933:	mov    $0x8,%edi
  150938:	mov    %r12,%rsi
  15093b:	call   *0x36a80f(%rip)        # 4bb150 <_DYNAMIC+0x260>
  150941:	vzeroupper
  150944:	call   1e9b60 <core::panicking::unreachable_display::<&str>>
  150949:	ud2
  15094b:	mov    %rax,%r15
  15094e:	jmp    1509b1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xae1>
  150950:	mov    %rax,%r15
  150953:	mov    0x60(%rsp),%rax
  150958:	test   %rax,%rax
  15095b:	je     150984 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xab4>
  15095d:	mov    0x68(%rsp),%rdi
  150962:	movzbl 0x36cb4f(%rip),%ecx        # 4bd4b8 <frontier_experiment::TRACK>
  150969:	test   %cl,%cl
  15096b:	je     150979 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xaa9>
  15096d:	shl    $0x3,%rax
  150971:	lock sub %rax,0x36cb2f(%rip)        # 4bd4a8 <frontier_experiment::LIVE>
  150979:	call   *0x36a7f9(%rip)        # 4bb178 <free@GLIBC_2.2.5>
  15097f:	jmp    150984 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xab4>
  150981:	mov    %rax,%r15
  150984:	cmpq   $0x0,0x18(%rsp)
  15098a:	je     1509b1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xae1>
  15098c:	movzbl 0x36cb25(%rip),%eax        # 4bd4b8 <frontier_experiment::TRACK>
  150993:	test   %al,%al
  150995:	je     1509a8 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xad8>
  150997:	mov    0x18(%rsp),%rax
  15099c:	shl    $0x3,%rax
  1509a0:	lock sub %rax,0x36cb00(%rip)        # 4bd4a8 <frontier_experiment::LIVE>
  1509a8:	mov    %rbx,%rdi
  1509ab:	call   *0x36a7c7(%rip)        # 4bb178 <free@GLIBC_2.2.5>
  1509b1:	cmpq   $0x0,0x28(%rsp)
  1509b7:	je     1509e0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xb10>
  1509b9:	movzbl 0x36caf8(%rip),%eax        # 4bd4b8 <frontier_experiment::TRACK>
  1509c0:	test   %al,%al
  1509c2:	je     1509d5 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xb05>
  1509c4:	mov    0x28(%rsp),%rax
  1509c9:	shl    $0x4,%rax
  1509cd:	lock sub %rax,0x36cad3(%rip)        # 4bd4a8 <frontier_experiment::LIVE>
  1509d5:	mov    0x8(%rsp),%rdi
  1509da:	call   *0x36a798(%rip)        # 4bb178 <free@GLIBC_2.2.5>
  1509e0:	mov    %r15,%rdi
  1509e3:	call   4ad720 <_Unwind_Resume@plt>

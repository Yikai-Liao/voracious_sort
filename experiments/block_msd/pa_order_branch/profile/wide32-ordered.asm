
experiments/block_msd/target/pa-order-branch/time:     file format elf64-x86-64


Disassembly of section .text:

000000000010cdd0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>>:
  10cdd0:	push   %rbp
  10cdd1:	push   %r15
  10cdd3:	push   %r14
  10cdd5:	push   %r13
  10cdd7:	push   %r12
  10cdd9:	push   %rbx
  10cdda:	sub    $0x38,%rsp
  10cdde:	mov    $0x1,%r8b
  10cde1:	cmp    $0x2,%rsi
  10cde5:	jb     10d649 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x879>
  10cdeb:	mov    (%rdi),%r9
  10cdee:	mov    0x8(%rdi),%rcx
  10cdf2:	mov    %rsi,0x8(%rsp)
  10cdf7:	lea    -0x1(%rsi),%rax
  10cdfb:	movabs $0x3ffffffffffff80,%r10
  10ce05:	mov    %rax,%rbp
  10ce08:	and    %rax,%r10
  10ce0b:	mov    %rdi,(%rsp)
  10ce0f:	je     10cfb5 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x1e5>
  10ce15:	lea    0x20(%rdi),%r11
  10ce19:	lea    -0x80(%r10),%rbx
  10ce1d:	shr    $0x7,%rbx
  10ce21:	xor    %esi,%esi
  10ce23:	jmp    10ce44 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x74>
  10ce25:	data16 cs nopw 0x0(%rax,%rax,1)
  10ce30:	add    $0x1000,%r11
  10ce37:	cmp    %rbx,%rsi
  10ce3a:	lea    0x1(%rsi),%rsi
  10ce3e:	je     10cfb5 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x1e5>
  10ce44:	xor    %edx,%edx
  10ce46:	xor    %r15d,%r15d
  10ce49:	xor    %r14d,%r14d
  10ce4c:	nopl   0x0(%rax)
  10ce50:	mov    (%r11,%r14,1),%rax
  10ce54:	xor    %r9,%rax
  10ce57:	or     %rdx,%rax
  10ce5a:	mov    0x8(%r11,%r14,1),%rdx
  10ce5f:	xor    %rcx,%rdx
  10ce62:	or     %r15,%rdx
  10ce65:	mov    0x28(%r11,%r14,1),%r8
  10ce6a:	xor    %rcx,%r8
  10ce6d:	mov    0x20(%r11,%r14,1),%r12
  10ce72:	xor    %r9,%r12
  10ce75:	mov    0x40(%r11,%r14,1),%r15
  10ce7a:	xor    %r9,%r15
  10ce7d:	or     %r12,%r15
  10ce80:	or     %rax,%r15
  10ce83:	mov    0x48(%r11,%r14,1),%r12
  10ce88:	xor    %rcx,%r12
  10ce8b:	or     %r8,%r12
  10ce8e:	or     %rdx,%r12
  10ce91:	mov    0x68(%r11,%r14,1),%rax
  10ce96:	xor    %rcx,%rax
  10ce99:	mov    0x60(%r11,%r14,1),%rdx
  10ce9e:	xor    %r9,%rdx
  10cea1:	mov    0x80(%r11,%r14,1),%r13
  10cea9:	xor    %r9,%r13
  10ceac:	or     %rdx,%r13
  10ceaf:	mov    0x88(%r11,%r14,1),%rdx
  10ceb7:	xor    %rcx,%rdx
  10ceba:	or     %rax,%rdx
  10cebd:	mov    0xa8(%r11,%r14,1),%rax
  10cec5:	xor    %rcx,%rax
  10cec8:	or     %rdx,%rax
  10cecb:	or     %r12,%rax
  10cece:	mov    0xa0(%r11,%r14,1),%r8
  10ced6:	xor    %r9,%r8
  10ced9:	or     %r13,%r8
  10cedc:	or     %r15,%r8
  10cedf:	mov    0xc0(%r11,%r14,1),%r12
  10cee7:	xor    %r9,%r12
  10ceea:	mov    0xc8(%r11,%r14,1),%r13
  10cef2:	xor    %rcx,%r13
  10cef5:	mov    0xe8(%r11,%r14,1),%r15
  10cefd:	mov    0xe0(%r11,%r14,1),%rdx
  10cf05:	add    $0x100,%r14
  10cf0c:	xor    %rcx,%r15
  10cf0f:	or     %r13,%r15
  10cf12:	or     %rax,%r15
  10cf15:	xor    %r9,%rdx
  10cf18:	or     %r12,%rdx
  10cf1b:	or     %r8,%rdx
  10cf1e:	cmp    $0x1000,%r14
  10cf25:	jne    10ce50 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x80>
  10cf2b:	or     %r15,%rdx
  10cf2e:	je     10ce30 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x60>
  10cf34:	xor    %r13d,%r13d
  10cf37:	xor    %r12d,%r12d
  10cf3a:	nopw   0x0(%rax,%rax,1)
  10cf40:	mov    (%r11,%r13,1),%r14
  10cf44:	mov    0x8(%r11,%r13,1),%r15
  10cf49:	mov    %r15,%rax
  10cf4c:	xor    %rcx,%rax
  10cf4f:	mov    %r14,%rdx
  10cf52:	xor    %r9,%rdx
  10cf55:	or     %rax,%rdx
  10cf58:	jne    10d17c <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x3ac>
  10cf5e:	mov    0x20(%r11,%r13,1),%r14
  10cf63:	mov    0x28(%r11,%r13,1),%r15
  10cf68:	mov    %r15,%rax
  10cf6b:	xor    %rcx,%rax
  10cf6e:	mov    %r14,%rdx
  10cf71:	xor    %r9,%rdx
  10cf74:	or     %rax,%rdx
  10cf77:	jne    10d179 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x3a9>
  10cf7d:	cmp    $0xfc0,%r13
  10cf84:	je     10ce30 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x60>
  10cf8a:	mov    0x40(%r11,%r13,1),%r14
  10cf8f:	mov    0x48(%r11,%r13,1),%r15
  10cf94:	add    $0x60,%r13
  10cf98:	add    $0x3,%r12
  10cf9c:	mov    %r15,%rax
  10cf9f:	xor    %rcx,%rax
  10cfa2:	mov    %r14,%rdx
  10cfa5:	xor    %r9,%rdx
  10cfa8:	or     %rax,%rdx
  10cfab:	je     10cf40 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x170>
  10cfad:	dec    %r12
  10cfb0:	jmp    10d17c <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x3ac>
  10cfb5:	shl    $0x5,%r10
  10cfb9:	lea    (%rdi,%r10,1),%rsi
  10cfbd:	add    $0x20,%rsi
  10cfc1:	mov    %rbp,%rdi
  10cfc4:	and    $0x7f,%edi
  10cfc7:	mov    %edi,%r8d
  10cfca:	shl    $0x5,%r8d
  10cfce:	not    %rdi
  10cfd1:	mov    0x8(%rsp),%rdx
  10cfd6:	add    %rdx,%rdi
  10cfd9:	xor    %eax,%eax
  10cfdb:	nopl   0x0(%rax,%rax,1)
  10cfe0:	cmp    %rax,%r8
  10cfe3:	je     10d646 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x876>
  10cfe9:	mov    (%rsi,%rax,1),%r14
  10cfed:	mov    0x8(%rsi,%rax,1),%r15
  10cff2:	mov    %r15,%r11
  10cff5:	xor    %rcx,%r11
  10cff8:	mov    %r14,%r10
  10cffb:	xor    %r9,%r10
  10cffe:	add    $0x20,%rax
  10d002:	inc    %rdi
  10d005:	or     %r11,%r10
  10d008:	je     10cfe0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x210>
  10d00a:	cmp    %r9,%r14
  10d00d:	mov    %rdx,%rax
  10d010:	sbb    %rcx,%r15
  10d013:	jae    10d19b <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x3cb>
  10d019:	sub    %rdi,%rax
  10d01c:	jb     10d67f <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x8af>
  10d022:	lea    -0x1(%rax),%rsi
  10d026:	mov    %rdx,%r8
  10d029:	sub    %rdi,%r8
  10d02c:	je     10d66e <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x89e>
  10d032:	mov    %rdi,%r10
  10d035:	shl    $0x5,%r10
  10d039:	mov    %rsi,%rax
  10d03c:	shr    $0x7,%rax
  10d040:	movabs $0x7ffffffffffff,%r9
  10d04a:	and    %rax,%r9
  10d04d:	je     10d29b <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x4cb>
  10d053:	mov    (%rsp),%rax
  10d057:	lea    (%r10,%rax,1),%rbx
  10d05b:	add    $0x80,%rbx
  10d062:	xor    %eax,%eax
  10d064:	xor    %ecx,%ecx
  10d066:	mov    %rdi,0x10(%rsp)
  10d06b:	mov    %r10,0x18(%rsp)
  10d070:	mov    %r8,0x30(%rsp)
  10d075:	mov    %r9,0x28(%rsp)
  10d07a:	inc    %rax
  10d07d:	mov    %rax,0x20(%rsp)
  10d082:	xor    %r15d,%r15d
  10d085:	data16 cs nopw 0x0(%rax,%rax,1)
  10d090:	mov    -0x80(%rbx,%r15,1),%rdi
  10d095:	mov    -0x78(%rbx,%r15,1),%rax
  10d09a:	mov    -0x58(%rbx,%r15,1),%r13
  10d09f:	mov    -0x60(%rbx,%r15,1),%rdx
  10d0a4:	cmp    %rdx,%rdi
  10d0a7:	mov    %rax,%r8
  10d0aa:	sbb    %r13,%r8
  10d0ad:	jb     10d359 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x589>
  10d0b3:	mov    -0x40(%rbx,%r15,1),%rbp
  10d0b8:	mov    -0x38(%rbx,%r15,1),%r11
  10d0bd:	cmp    %rbp,%rdx
  10d0c0:	mov    %r13,%r8
  10d0c3:	sbb    %r11,%r8
  10d0c6:	jb     10d359 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x589>
  10d0cc:	mov    -0x20(%rbx,%r15,1),%r14
  10d0d1:	mov    -0x18(%rbx,%r15,1),%r9
  10d0d6:	cmp    %r14,%rbp
  10d0d9:	mov    %r11,%r8
  10d0dc:	sbb    %r9,%r8
  10d0df:	jb     10d359 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x589>
  10d0e5:	mov    (%rbx,%r15,1),%r10
  10d0e9:	mov    0x8(%rbx,%r15,1),%r8
  10d0ee:	cmp    %r10,%r14
  10d0f1:	mov    %r9,%r12
  10d0f4:	sbb    %r8,%r12
  10d0f7:	jb     10d359 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x589>
  10d0fd:	xor    %rdx,%rdi
  10d100:	xor    %r13,%rax
  10d103:	or     %rdi,%rax
  10d106:	sete   %al
  10d109:	or     %al,%cl
  10d10b:	xor    %rbp,%rdx
  10d10e:	xor    %r11,%r13
  10d111:	or     %rdx,%r13
  10d114:	sete   %al
  10d117:	xor    %r14,%rbp
  10d11a:	xor    %r9,%r11
  10d11d:	or     %rbp,%r11
  10d120:	sete   %dl
  10d123:	or     %al,%dl
  10d125:	or     %cl,%dl
  10d127:	xor    %r14,%r10
  10d12a:	xor    %r9,%r8
  10d12d:	or     %r10,%r8
  10d130:	sete   %cl
  10d133:	or     %dl,%cl
  10d135:	sub    $0xffffffffffffff80,%r15
  10d139:	cmp    $0x1000,%r15
  10d140:	jne    10d090 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x2c0>
  10d146:	add    $0x1000,%rbx
  10d14d:	mov    0x28(%rsp),%r9
  10d152:	mov    0x20(%rsp),%rax
  10d157:	cmp    %r9,%rax
  10d15a:	mov    0x8(%rsp),%rdx
  10d15f:	mov    0x10(%rsp),%rdi
  10d164:	mov    0x18(%rsp),%r10
  10d169:	mov    0x30(%rsp),%r8
  10d16e:	jne    10d07a <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x2aa>
  10d174:	jmp    10d29d <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x4cd>
  10d179:	inc    %r12
  10d17c:	shl    $0x7,%rsi
  10d180:	lea    (%r12,%rsi,1),%rdi
  10d184:	inc    %rdi
  10d187:	mov    0x8(%rsp),%rdx
  10d18c:	cmp    %r9,%r14
  10d18f:	mov    %rdx,%rax
  10d192:	sbb    %rcx,%r15
  10d195:	jb     10d019 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x249>
  10d19b:	sub    %rdi,%rax
  10d19e:	jb     10d68f <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x8bf>
  10d1a4:	lea    -0x1(%rax),%rsi
  10d1a8:	sub    %rdi,%rdx
  10d1ab:	je     10d66e <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x89e>
  10d1b1:	shl    $0x5,%rdi
  10d1b5:	mov    %rsi,%rax
  10d1b8:	shr    $0x7,%rax
  10d1bc:	movabs $0x7ffffffffffff,%r14
  10d1c6:	and    %rax,%r14
  10d1c9:	je     10d245 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x475>
  10d1cb:	mov    (%rsp),%rax
  10d1cf:	lea    (%rax,%rdi,1),%rcx
  10d1d3:	xor    %r9d,%r9d
  10d1d6:	inc    %r9
  10d1d9:	mov    $0x60,%eax
  10d1de:	xchg   %ax,%ax
  10d1e0:	mov    -0x40(%rcx,%rax,1),%rbx
  10d1e5:	mov    -0x38(%rcx,%rax,1),%r11
  10d1ea:	cmp    -0x60(%rcx,%rax,1),%rbx
  10d1ef:	mov    %r11,%r8
  10d1f2:	sbb    -0x58(%rcx,%rax,1),%r8
  10d1f7:	jb     10d359 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x589>
  10d1fd:	mov    -0x20(%rcx,%rax,1),%r10
  10d202:	mov    -0x18(%rcx,%rax,1),%r8
  10d207:	cmp    %rbx,%r10
  10d20a:	mov    %r8,%rbx
  10d20d:	sbb    %r11,%rbx
  10d210:	jb     10d359 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x589>
  10d216:	lea    0x60(%rax),%r11
  10d21a:	cmp    $0x1080,%r11
  10d221:	je     10d239 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x469>
  10d223:	mov    0x8(%rcx,%rax,1),%rbx
  10d228:	cmp    %r10,(%rcx,%rax,1)
  10d22c:	sbb    %r8,%rbx
  10d22f:	mov    %r11,%rax
  10d232:	jae    10d1e0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x410>
  10d234:	jmp    10d359 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x589>
  10d239:	add    $0x1000,%rcx
  10d240:	cmp    %r14,%r9
  10d243:	jne    10d1d6 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x406>
  10d245:	and    $0xffffffffffffff80,%rsi
  10d249:	cmp    %rdx,%rsi
  10d24c:	ja     10d69f <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x8cf>
  10d252:	sub    %rsi,%rdx
  10d255:	shl    $0x5,%rsi
  10d259:	add    %rdi,%rsi
  10d25c:	mov    (%rsp),%rax
  10d260:	add    %rsi,%rax
  10d263:	add    $0x20,%rax
  10d267:	inc    %rdx
  10d26a:	nopw   0x0(%rax,%rax,1)
  10d270:	dec    %rdx
  10d273:	cmp    $0x2,%rdx
  10d277:	setb   %r8b
  10d27b:	jb     10d649 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x879>
  10d281:	mov    (%rax),%rcx
  10d284:	mov    0x8(%rax),%rsi
  10d288:	cmp    -0x20(%rax),%rcx
  10d28c:	sbb    -0x18(%rax),%rsi
  10d290:	lea    0x20(%rax),%rax
  10d294:	jae    10d270 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x4a0>
  10d296:	jmp    10d649 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x879>
  10d29b:	xor    %ecx,%ecx
  10d29d:	and    $0xffffffffffffff80,%rsi
  10d2a1:	mov    %r8,%r11
  10d2a4:	sub    %rsi,%r11
  10d2a7:	jb     10d6b2 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x8e2>
  10d2ad:	cmp    $0x2,%r11
  10d2b1:	jb     10d315 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x545>
  10d2b3:	mov    (%rsp),%r9
  10d2b7:	lea    (%r9,%r10,1),%rax
  10d2bb:	shl    $0x5,%rsi
  10d2bf:	mov    (%rax,%rsi,1),%r8
  10d2c3:	mov    0x8(%rax,%rsi,1),%rbx
  10d2c8:	inc    %r11
  10d2cb:	add    %r10,%rsi
  10d2ce:	add    %rsi,%r9
  10d2d1:	add    $0x20,%r9
  10d2d5:	data16 cs nopw 0x0(%rax,%rax,1)
  10d2e0:	mov    (%r9),%rax
  10d2e3:	mov    0x8(%r9),%rsi
  10d2e7:	cmp    %rax,%r8
  10d2ea:	mov    %rbx,%r10
  10d2ed:	sbb    %rsi,%r10
  10d2f0:	jb     10d359 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x589>
  10d2f2:	xor    %rax,%r8
  10d2f5:	xor    %rsi,%rbx
  10d2f8:	or     %r8,%rbx
  10d2fb:	sete   %r8b
  10d2ff:	or     %r8b,%cl
  10d302:	dec    %r11
  10d305:	add    $0x20,%r9
  10d309:	mov    %rax,%r8
  10d30c:	mov    %rsi,%rbx
  10d30f:	cmp    $0x3,%r11
  10d313:	jae    10d2e0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x510>
  10d315:	mov    %rdx,%r14
  10d318:	shr    $1,%r14
  10d31b:	mov    %rdx,%rsi
  10d31e:	shl    $0x5,%rsi
  10d322:	lea    -0x1(%r14),%rax
  10d326:	mov    %r14d,%r8d
  10d329:	and    $0x3,%r8d
  10d32d:	movabs $0x7fffffffffffffe,%r10
  10d337:	movabs $0x7fffffffffffffd,%r11
  10d341:	movabs $0x7fffffffffffffc,%rbx
  10d34b:	cmp    $0x3,%rax
  10d34f:	jae    10d361 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x591>
  10d351:	xor    %r15d,%r15d
  10d354:	jmp    10d42b <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x65b>
  10d359:	xor    %r8d,%r8d
  10d35c:	jmp    10d649 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x879>
  10d361:	mov    (%rsp),%rdx
  10d365:	lea    (%rdx,%rsi,1),%r12
  10d369:	movabs $0x1fffffffffffffc,%rax
  10d373:	and    %rax,%r14
  10d376:	lea    0x60(%rdx),%r13
  10d37a:	lea    (%rsi,%rdx,1),%rbp
  10d37e:	add    $0xffffffffffffffe0,%rbp
  10d382:	xor    %r15d,%r15d
  10d385:	data16 cs nopw 0x0(%rax,%rax,1)
  10d390:	vmovups -0x60(%r13),%ymm0
  10d396:	vmovups 0x0(%rbp),%ymm1
  10d39b:	vmovups %ymm1,-0x60(%r13)
  10d3a1:	vmovups %ymm0,0x0(%rbp)
  10d3a6:	mov    %r15,%rax
  10d3a9:	xor    %r10,%rax
  10d3ac:	shl    $0x5,%rax
  10d3b0:	vmovups -0x40(%r13),%ymm0
  10d3b6:	vmovups (%r12,%rax,1),%ymm1
  10d3bc:	vmovups %ymm1,-0x40(%r13)
  10d3c2:	vmovups %ymm0,(%r12,%rax,1)
  10d3c8:	mov    %r15,%rax
  10d3cb:	xor    %r11,%rax
  10d3ce:	shl    $0x5,%rax
  10d3d2:	vmovups -0x20(%r13),%ymm0
  10d3d8:	vmovups (%r12,%rax,1),%ymm1
  10d3de:	vmovups %ymm1,-0x20(%r13)
  10d3e4:	vmovups %ymm0,(%r12,%rax,1)
  10d3ea:	mov    %r15,%rax
  10d3ed:	xor    %rbx,%rax
  10d3f0:	shl    $0x5,%rax
  10d3f4:	vmovups 0x0(%r13),%ymm0
  10d3fa:	vmovups (%r12,%rax,1),%ymm1
  10d400:	vmovups %ymm1,0x0(%r13)
  10d406:	vmovups %ymm0,(%r12,%rax,1)
  10d40c:	add    $0x4,%r15
  10d410:	sub    $0xffffffffffffff80,%r13
  10d414:	add    $0xffffffffffffff80,%rbp
  10d418:	cmp    %r15,%r14
  10d41b:	jne    10d390 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x5c0>
  10d421:	test   %r8,%r8
  10d424:	mov    0x8(%rsp),%rdx
  10d429:	je     10d471 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x6a1>
  10d42b:	shl    $0x5,%r15
  10d42f:	mov    (%rsp),%r9
  10d433:	lea    (%r9,%r15,1),%rax
  10d437:	sub    %r15,%rsi
  10d43a:	add    %r9,%rsi
  10d43d:	add    $0xffffffffffffffe0,%rsi
  10d441:	shl    $0x5,%r8d
  10d445:	xor    %r9d,%r9d
  10d448:	nopl   0x0(%rax,%rax,1)
  10d450:	vmovups (%rax,%r9,1),%ymm0
  10d456:	vmovups (%rsi),%ymm1
  10d45a:	vmovups %ymm1,(%rax,%r9,1)
  10d460:	vmovups %ymm0,(%rsi)
  10d464:	add    $0x20,%r9
  10d468:	add    $0xffffffffffffffe0,%rsi
  10d46c:	cmp    %r9,%r8
  10d46f:	jne    10d450 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x680>
  10d471:	cmp    $0x2,%rdi
  10d475:	setae  %al
  10d478:	or     %cl,%al
  10d47a:	test   $0x1,%al
  10d47c:	je     10d646 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x876>
  10d482:	mov    (%rsp),%rax
  10d486:	lea    0x20(%rax),%rcx
  10d48a:	mov    %rcx,0x20(%rsp)
  10d48f:	lea    0x60(%rax),%rcx
  10d493:	mov    %rcx,0x18(%rsp)
  10d498:	add    $0xffffffffffffffe0,%rax
  10d49c:	mov    %rax,0x10(%rsp)
  10d4a1:	xor    %esi,%esi
  10d4a3:	jmp    10d4be <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x6ee>
  10d4a5:	data16 cs nopw 0x0(%rax,%rax,1)
  10d4b0:	mov    0x8(%rsp),%rdx
  10d4b5:	cmp    %rdx,%rsi
  10d4b8:	jae    10d646 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x876>
  10d4be:	mov    %rsi,%rdi
  10d4c1:	mov    %rsi,%r15
  10d4c4:	shl    $0x5,%r15
  10d4c8:	mov    (%rsp),%rcx
  10d4cc:	mov    (%rcx,%r15,1),%rax
  10d4d0:	mov    0x8(%rcx,%r15,1),%r13
  10d4d5:	lea    0x1(%rsi),%rcx
  10d4d9:	cmp    %rcx,%rdx
  10d4dc:	cmova  %rdx,%rcx
  10d4e0:	lea    -0x1(%rcx),%r8
  10d4e4:	mov    0x20(%rsp),%r9
  10d4e9:	add    %r15,%r9
  10d4ec:	nopl   0x0(%rax)
  10d4f0:	cmp    %rsi,%r8
  10d4f3:	je     10d510 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x740>
  10d4f5:	inc    %rsi
  10d4f8:	mov    (%r9),%r14
  10d4fb:	xor    %rax,%r14
  10d4fe:	mov    0x8(%r9),%r12
  10d502:	xor    %r13,%r12
  10d505:	add    $0x20,%r9
  10d509:	or     %r14,%r12
  10d50c:	je     10d4f0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x720>
  10d50e:	jmp    10d513 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x743>
  10d510:	mov    %rcx,%rsi
  10d513:	mov    %rsi,%rax
  10d516:	sub    %rdi,%rax
  10d519:	jb     10d65e <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x88e>
  10d51f:	mov    %rax,%r13
  10d522:	shr    $1,%r13
  10d525:	je     10d4b0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x6e0>
  10d527:	mov    %rsi,%rdx
  10d52a:	shl    $0x5,%rdx
  10d52e:	mov    %r13d,%r12d
  10d531:	and    $0x3,%r12d
  10d535:	cmp    $0x8,%rax
  10d539:	jae    10d550 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x780>
  10d53b:	xor    %ebp,%ebp
  10d53d:	jmp    10d606 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x836>
  10d542:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  10d550:	mov    (%rsp),%rax
  10d554:	lea    (%rax,%rdx,1),%r9
  10d558:	and    $0xfffffffffffffffc,%r13
  10d55c:	mov    0x18(%rsp),%rax
  10d561:	lea    (%rax,%r15,1),%r14
  10d565:	mov    0x10(%rsp),%rax
  10d56a:	lea    (%rax,%rdx,1),%rcx
  10d56e:	xor    %ebp,%ebp
  10d570:	vmovups -0x60(%r14),%ymm0
  10d576:	vmovups (%rcx),%ymm1
  10d57a:	vmovups %ymm1,-0x60(%r14)
  10d580:	vmovups %ymm0,(%rcx)
  10d584:	mov    %rbp,%rax
  10d587:	xor    %r10,%rax
  10d58a:	shl    $0x5,%rax
  10d58e:	vmovups -0x40(%r14),%ymm0
  10d594:	vmovups (%r9,%rax,1),%ymm1
  10d59a:	vmovups %ymm1,-0x40(%r14)
  10d5a0:	vmovups %ymm0,(%r9,%rax,1)
  10d5a6:	mov    %rbp,%rax
  10d5a9:	xor    %r11,%rax
  10d5ac:	shl    $0x5,%rax
  10d5b0:	vmovups -0x20(%r14),%ymm0
  10d5b6:	vmovups (%r9,%rax,1),%ymm1
  10d5bc:	vmovups %ymm1,-0x20(%r14)
  10d5c2:	vmovups %ymm0,(%r9,%rax,1)
  10d5c8:	mov    %rbp,%rax
  10d5cb:	xor    %rbx,%rax
  10d5ce:	shl    $0x5,%rax
  10d5d2:	vmovups (%r14),%ymm0
  10d5d7:	vmovups (%r9,%rax,1),%ymm1
  10d5dd:	vmovups %ymm1,(%r14)
  10d5e2:	vmovups %ymm0,(%r9,%rax,1)
  10d5e8:	add    $0x4,%rbp
  10d5ec:	sub    $0xffffffffffffff80,%r14
  10d5f0:	add    $0xffffffffffffff80,%rcx
  10d5f4:	cmp    %rbp,%r13
  10d5f7:	jne    10d570 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x7a0>
  10d5fd:	test   %r12,%r12
  10d600:	je     10d4b0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x6e0>
  10d606:	shl    $0x5,%rbp
  10d60a:	add    (%rsp),%r15
  10d60e:	add    %rbp,%r15
  10d611:	sub    %rbp,%rdx
  10d614:	add    0x10(%rsp),%rdx
  10d619:	shl    $0x5,%r12d
  10d61d:	xor    %eax,%eax
  10d61f:	nop
  10d620:	vmovups (%r15,%rax,1),%ymm0
  10d626:	vmovups (%rdx),%ymm1
  10d62a:	vmovups %ymm1,(%r15,%rax,1)
  10d630:	vmovups %ymm0,(%rdx)
  10d634:	add    $0x20,%rax
  10d638:	add    $0xffffffffffffffe0,%rdx
  10d63c:	cmp    %rax,%r12
  10d63f:	jne    10d620 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x850>
  10d641:	jmp    10d4b0 <block_msd_research::frontier::ordered_tiled::ordered::<frontier_experiment::Wide, u128>+0x6e0>
  10d646:	mov    $0x1,%r8b
  10d649:	mov    %r8d,%eax
  10d64c:	add    $0x38,%rsp
  10d650:	pop    %rbx
  10d651:	pop    %r12
  10d653:	pop    %r13
  10d655:	pop    %r14
  10d657:	pop    %r15
  10d659:	pop    %rbp
  10d65a:	vzeroupper
  10d65d:	ret
  10d65e:	lea    0x3aafcb(%rip),%rcx        # 4b8630 <anon.005357b6259aec7dbb5efeaf9c6c1e46.1.llvm.5840278210049151275>
  10d665:	vzeroupper
  10d668:	call   *0x3ad53a(%rip)        # 4baba8 <_DYNAMIC+0x298>
  10d66e:	lea    0x3a20f3(%rip),%rcx        # 4af768 <anon.4f09dbc27bc51892750e1edd1fc396d9.1.llvm.4484181053944774123+0x60>
  10d675:	xor    %edi,%edi
  10d677:	xor    %edx,%edx
  10d679:	call   *0x3ad529(%rip)        # 4baba8 <_DYNAMIC+0x298>
  10d67f:	lea    0x3a20ca(%rip),%rcx        # 4af750 <anon.4f09dbc27bc51892750e1edd1fc396d9.1.llvm.4484181053944774123+0x48>
  10d686:	mov    %rdx,%rsi
  10d689:	call   *0x3ad519(%rip)        # 4baba8 <_DYNAMIC+0x298>
  10d68f:	lea    0x3a20a2(%rip),%rcx        # 4af738 <anon.4f09dbc27bc51892750e1edd1fc396d9.1.llvm.4484181053944774123+0x30>
  10d696:	mov    %rdx,%rsi
  10d699:	call   *0x3ad509(%rip)        # 4baba8 <_DYNAMIC+0x298>
  10d69f:	lea    0x3a20da(%rip),%rcx        # 4af780 <anon.4f09dbc27bc51892750e1edd1fc396d9.1.llvm.4484181053944774123+0x78>
  10d6a6:	mov    %rsi,%rdi
  10d6a9:	mov    %rdx,%rsi
  10d6ac:	call   *0x3ad4f6(%rip)        # 4baba8 <_DYNAMIC+0x298>
  10d6b2:	lea    0x3a20c7(%rip),%rcx        # 4af780 <anon.4f09dbc27bc51892750e1edd1fc396d9.1.llvm.4484181053944774123+0x78>
  10d6b9:	mov    %rsi,%rdi
  10d6bc:	mov    %r8,%rsi
  10d6bf:	mov    %r8,%rdx
  10d6c2:	call   *0x3ad4e0(%rip)        # 4baba8 <_DYNAMIC+0x298>

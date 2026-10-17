
experiments/block_msd/target/pa-outline-final/time:     file format elf64-x86-64


Disassembly of section .text:

00000000000e9d30 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>>:
   e9d30:	push   %rbp
   e9d31:	push   %r15
   e9d33:	push   %r14
   e9d35:	push   %r13
   e9d37:	push   %r12
   e9d39:	push   %rbx
   e9d3a:	sub    $0x68,%rsp
   e9d3e:	mov    %rsi,%r14
   e9d41:	mov    %rdi,%r13
   e9d44:	cmp    $0x81,%rsi
   e9d4b:	jae    e9d85 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x55>
   e9d4d:	lea    0x17(%rsp),%rax
   e9d52:	mov    %rax,0x18(%rsp)
   e9d57:	cmp    $0x2,%r14
   e9d5b:	jb     e9fad <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x27d>
   e9d61:	cmp    $0x15,%r14
   e9d65:	jae    ea002 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x2d2>
   e9d6b:	lea    0x18(%rsp),%rcx
   e9d70:	mov    $0x1,%edx
   e9d75:	mov    %r13,%rdi
   e9d78:	mov    %r14,%rsi
   e9d7b:	call   3f7d20 <core::slice::sort::shared::smallsort::insertion_sort_shift_left::<u128, <[u128]>::sort_by_key<u128, frontier_experiment::run<u128, u128>::{closure#0}>::{closure#0}>>
   e9d80:	jmp    e9fad <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x27d>
   e9d85:	mov    %rdx,%rcx
   e9d88:	lea    0x3c5991(%rip),%r9        # 4af720 <anon.3eb41e8f5c5edcc6f3a74d45dc55b3a8.5.llvm.12184228331515507479+0x390>
   e9d8f:	lea    0x38(%rsp),%rdi
   e9d94:	mov    $0x1,%r8d
   e9d9a:	mov    %r13,%rsi
   e9d9d:	mov    %r14,%rdx
   e9da0:	call   fe540 <block_msd_research::stable_baseline::algo::verge_sort_heuristic::verge_sort_preprocessing::<u128, u128>>
   e9da5:	mov    0x48(%rsp),%r12
   e9daa:	cmp    $0x3,%r12
   e9dae:	jb     e9f81 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x251>
   e9db4:	jne    e9e3a <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x10a>
   e9dba:	mov    0x40(%rsp),%rbx
   e9dbf:	mov    0x8(%rbx),%rax
   e9dc3:	mov    0x10(%rbx),%rcx
   e9dc7:	sub    %rax,%rcx
   e9dca:	sub    (%rbx),%rax
   e9dcd:	cmp    %rcx,%rax
   e9dd0:	cmovb  %rax,%rcx
   e9dd4:	mov    0x0(%r13),%rsi
   e9dd8:	mov    0x8(%r13),%rdx
   e9ddc:	lea    0x18(%rsp),%rdi
   e9de1:	call   b4880 <alloc::vec::from_elem::<u128>>
   e9de6:	mov    0x20(%rsp),%r15
   e9deb:	mov    0x28(%rsp),%rcx
   e9df0:	mov    (%rbx),%r8
   e9df3:	mov    0x8(%rbx),%r9
   e9df7:	mov    0x10(%rbx),%rax
   e9dfb:	mov    %rax,(%rsp)
   e9dff:	mov    %r13,%rdi
   e9e02:	mov    %r14,%rsi
   e9e05:	mov    %r15,%rdx
   e9e08:	call   e6630 <block_msd_research::stable_baseline::algo::k_way_merge::merge2::<u128>>
   e9e0d:	mov    0x18(%rsp),%rax
   e9e12:	test   %rax,%rax
   e9e15:	je     e9f81 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x251>
   e9e1b:	movzbl 0x3d3696(%rip),%ecx        # 4bd4b8 <frontier_experiment::TRACK>
   e9e22:	test   %cl,%cl
   e9e24:	je     e9e32 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x102>
   e9e26:	shl    $0x4,%rax
   e9e2a:	lock sub %rax,0x3d3676(%rip)        # 4bd4a8 <frontier_experiment::LIVE>
   e9e32:	mov    %r15,%rdi
   e9e35:	jmp    e9f7b <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x24b>
   e9e3a:	mov    0x0(%r13),%rsi
   e9e3e:	mov    0x8(%r13),%rdx
   e9e42:	mov    %r14,%rcx
   e9e45:	shr    $1,%rcx
   e9e48:	add    $0x2,%rcx
   e9e4c:	lea    0x18(%rsp),%rdi
   e9e51:	call   b4880 <alloc::vec::from_elem::<u128>>
   e9e56:	mov    %r13,0x58(%rsp)
   e9e5b:	mov    %r14,0x60(%rsp)
   e9e60:	mov    0x20(%rsp),%rax
   e9e65:	mov    %rax,0x30(%rsp)
   e9e6a:	mov    0x28(%rsp),%rax
   e9e6f:	mov    %rax,0x50(%rsp)
   e9e74:	mov    0x40(%rsp),%rbx
   e9e79:	lea    0x10(%rbx),%r14
   e9e7d:	nopl   (%rax)
   e9e80:	lea    -0x1(%r12),%r15
   e9e85:	shr    $1,%r15
   e9e88:	lea    0x1(%r15),%r13
   e9e8c:	mov    $0x1,%eax
   e9e91:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   e9ea0:	dec    %r13
   e9ea3:	je     e9f00 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x1d0>
   e9ea5:	lea    -0x1(%rax),%rdi
   e9ea9:	cmp    %r12,%rdi
   e9eac:	jae    e9feb <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x2bb>
   e9eb2:	cmp    %r12,%rax
   e9eb5:	jae    e9fdf <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x2af>
   e9ebb:	lea    0x1(%rax),%rdi
   e9ebf:	cmp    %r12,%rdi
   e9ec2:	jae    e9fd6 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x2a6>
   e9ec8:	lea    0x2(%rax),%rbp
   e9ecc:	mov    -0x18(%rbx,%rbp,8),%r8
   e9ed1:	mov    (%rbx,%rax,8),%r9
   e9ed5:	mov    -0x8(%rbx,%rbp,8),%rax
   e9eda:	mov    %rax,(%rsp)
   e9ede:	mov    0x58(%rsp),%rdi
   e9ee3:	mov    0x60(%rsp),%rsi
   e9ee8:	mov    0x30(%rsp),%rdx
   e9eed:	mov    0x50(%rsp),%rcx
   e9ef2:	call   e6630 <block_msd_research::stable_baseline::algo::k_way_merge::merge2::<u128>>
   e9ef7:	mov    %rbp,%rax
   e9efa:	jmp    e9ea0 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x170>
   e9efc:	nopl   0x0(%rax)
   e9f00:	lea    -0x10(,%r12,8),%r13
   e9f08:	xor    %edi,%edi
   e9f0a:	nopw   0x0(%rax,%rax,1)
   e9f10:	lea    0x1(%rdi),%rbp
   e9f14:	cmp    %r12,%rbp
   e9f17:	jae    e9fbc <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x28c>
   e9f1d:	lea    (%r14,%rdi,8),%rsi
   e9f21:	lea    (%r14,%rdi,8),%rdi
   e9f25:	add    $0xfffffffffffffff8,%rdi
   e9f29:	mov    %r13,%rdx
   e9f2c:	call   *0x3d12ae(%rip)        # 4bb1e0 <memmove@GLIBC_2.2.5>
   e9f32:	dec    %r12
   e9f35:	add    $0xfffffffffffffff0,%r13
   e9f39:	mov    %rbp,%rdi
   e9f3c:	cmp    %rbp,%r15
   e9f3f:	jne    e9f10 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x1e0>
   e9f41:	lea    0x1(%r12),%rax
   e9f46:	cmp    $0x3,%rax
   e9f4a:	ja     e9e80 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x150>
   e9f50:	mov    %r12,0x48(%rsp)
   e9f55:	mov    0x18(%rsp),%rax
   e9f5a:	test   %rax,%rax
   e9f5d:	je     e9f81 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x251>
   e9f5f:	movzbl 0x3d3552(%rip),%ecx        # 4bd4b8 <frontier_experiment::TRACK>
   e9f66:	test   %cl,%cl
   e9f68:	je     e9f76 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x246>
   e9f6a:	shl    $0x4,%rax
   e9f6e:	lock sub %rax,0x3d3532(%rip)        # 4bd4a8 <frontier_experiment::LIVE>
   e9f76:	mov    0x30(%rsp),%rdi
   e9f7b:	call   *0x3d11f7(%rip)        # 4bb178 <free@GLIBC_2.2.5>
   e9f81:	mov    0x38(%rsp),%rax
   e9f86:	test   %rax,%rax
   e9f89:	je     e9fad <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x27d>
   e9f8b:	mov    0x40(%rsp),%rdi
   e9f90:	movzbl 0x3d3521(%rip),%ecx        # 4bd4b8 <frontier_experiment::TRACK>
   e9f97:	test   %cl,%cl
   e9f99:	je     e9fa7 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x277>
   e9f9b:	shl    $0x3,%rax
   e9f9f:	lock sub %rax,0x3d3501(%rip)        # 4bd4a8 <frontier_experiment::LIVE>
   e9fa7:	call   *0x3d11cb(%rip)        # 4bb178 <free@GLIBC_2.2.5>
   e9fad:	add    $0x68,%rsp
   e9fb1:	pop    %rbx
   e9fb2:	pop    %r12
   e9fb4:	pop    %r13
   e9fb6:	pop    %r14
   e9fb8:	pop    %r15
   e9fba:	pop    %rbp
   e9fbb:	ret
   e9fbc:	mov    %r12,0x48(%rsp)
   e9fc1:	inc    %rdi
   e9fc4:	lea    0x3c53f5(%rip),%rdx        # 4af3c0 <anon.3eb41e8f5c5edcc6f3a74d45dc55b3a8.5.llvm.12184228331515507479+0x30>
   e9fcb:	mov    %r12,%rsi
   e9fce:	call   *0x3d12a4(%rip)        # 4bb278 <_DYNAMIC+0x388>
   e9fd4:	jmp    ea000 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x2d0>
   e9fd6:	lea    0x3c542b(%rip),%rdx        # 4af408 <anon.3eb41e8f5c5edcc6f3a74d45dc55b3a8.5.llvm.12184228331515507479+0x78>
   e9fdd:	jmp    e9ff2 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x2c2>
   e9fdf:	mov    %rax,%rdi
   e9fe2:	lea    0x3c5407(%rip),%rdx        # 4af3f0 <anon.3eb41e8f5c5edcc6f3a74d45dc55b3a8.5.llvm.12184228331515507479+0x60>
   e9fe9:	jmp    e9ff2 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x2c2>
   e9feb:	lea    0x3c53e6(%rip),%rdx        # 4af3d8 <anon.3eb41e8f5c5edcc6f3a74d45dc55b3a8.5.llvm.12184228331515507479+0x48>
   e9ff2:	mov    %r12,0x48(%rsp)
   e9ff7:	mov    %r12,%rsi
   e9ffa:	call   *0x3d1198(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
   ea000:	ud2
   ea002:	lea    0x18(%rsp),%rdx
   ea007:	mov    %r13,%rdi
   ea00a:	mov    %r14,%rsi
   ea00d:	call   1092e0 <core::slice::sort::stable::driftsort_main::<u128, <[u128]>::sort_by<block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort<u128, u128>::{closure#0}>::{closure#0}, alloc::vec::Vec<u128>>>
   ea012:	jmp    e9fad <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x27d>
   ea014:	mov    %rax,%rbx
   ea017:	mov    0x18(%rsp),%rax
   ea01c:	test   %rax,%rax
   ea01f:	je     ea07d <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x34d>
   ea021:	movzbl 0x3d3490(%rip),%ecx        # 4bd4b8 <frontier_experiment::TRACK>
   ea028:	test   %cl,%cl
   ea02a:	je     ea038 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x308>
   ea02c:	shl    $0x4,%rax
   ea030:	lock sub %rax,0x3d3470(%rip)        # 4bd4a8 <frontier_experiment::LIVE>
   ea038:	mov    %r15,%rdi
   ea03b:	jmp    ea077 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x347>
   ea03d:	mov    %rax,%rbx
   ea040:	jmp    ea07d <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x34d>
   ea042:	mov    %rax,%rbx
   ea045:	mov    %r12,0x48(%rsp)
   ea04a:	jmp    ea051 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x321>
   ea04c:	jmp    ea04e <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x31e>
   ea04e:	mov    %rax,%rbx
   ea051:	mov    0x18(%rsp),%rax
   ea056:	test   %rax,%rax
   ea059:	je     ea07d <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x34d>
   ea05b:	movzbl 0x3d3456(%rip),%ecx        # 4bd4b8 <frontier_experiment::TRACK>
   ea062:	test   %cl,%cl
   ea064:	je     ea072 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x342>
   ea066:	shl    $0x4,%rax
   ea06a:	lock sub %rax,0x3d3436(%rip)        # 4bd4a8 <frontier_experiment::LIVE>
   ea072:	mov    0x30(%rsp),%rdi
   ea077:	call   *0x3d10fb(%rip)        # 4bb178 <free@GLIBC_2.2.5>
   ea07d:	mov    0x38(%rsp),%rax
   ea082:	test   %rax,%rax
   ea085:	je     ea0a9 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x379>
   ea087:	mov    0x40(%rsp),%rdi
   ea08c:	movzbl 0x3d3425(%rip),%ecx        # 4bd4b8 <frontier_experiment::TRACK>
   ea093:	test   %cl,%cl
   ea095:	je     ea0a3 <block_msd_research::stable_baseline::sorts::msd_stable_sort::msd_stable_radixsort::<u128, u128>+0x373>
   ea097:	shl    $0x3,%rax
   ea09b:	lock sub %rax,0x3d3405(%rip)        # 4bd4a8 <frontier_experiment::LIVE>
   ea0a3:	call   *0x3d10cf(%rip)        # 4bb178 <free@GLIBC_2.2.5>
   ea0a9:	mov    %rbx,%rdi
   ea0ac:	call   4ad720 <_Unwind_Resume@plt>

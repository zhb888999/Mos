	.file	"Main.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"pg_dir:%p\n"
.LC1:
	.string	"pg0:%p\n"
.LC2:
	.string	"pg1:%p\n"
.LC3:
	.string	"pg2:%p\n"
.LC4:
	.string	"pg3:%p\n"
.LC5:
	.string	"gdt:%p\n"
.LC6:
	.string	"idt:%p\n"
.LC7:
	.string	"init_stack:%p\n"
.LC8:
	.string	"mem_size:%d\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB9:
	.text
.LHOTB9:
	.p2align 4,,15
	.globl	Main
	.type	Main, @function
Main:
.LFB0:
	.cfi_startproc
	subl	$20, %esp
	.cfi_def_cfa_offset 24
	movzwl	589824, %edx
	movzwl	589826, %eax
	shrw	$10, %dx
	shrw	$4, %ax
	movzwl	%dx, %edx
	movzwl	%ax, %eax
	leal	1(%edx,%eax), %eax
	movl	$67, %edx
	movl	%eax, mem_size
	movl	$54, %eax
#APP
# 18 "init/Main.c" 1
	outb %al,%dx
	
# 0 "" 2
#NO_APP
	movl	$64, %edx
	movl	$154, %eax
#APP
# 19 "init/Main.c" 1
	outb %al,%dx
	
# 0 "" 2
#NO_APP
	movl	$46, %eax
#APP
# 20 "init/Main.c" 1
	outb %al,%dx
	
# 0 "" 2
#NO_APP
	pushl	$pg_dir
	.cfi_def_cfa_offset 28
	pushl	$.LC0
	.cfi_def_cfa_offset 32
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$pg0
	.cfi_def_cfa_offset 28
	pushl	$.LC1
	.cfi_def_cfa_offset 32
	call	printk
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$pg1
	.cfi_def_cfa_offset 28
	pushl	$.LC2
	.cfi_def_cfa_offset 32
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$pg2
	.cfi_def_cfa_offset 28
	pushl	$.LC3
	.cfi_def_cfa_offset 32
	call	printk
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$pg3
	.cfi_def_cfa_offset 28
	pushl	$.LC4
	.cfi_def_cfa_offset 32
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$gdt
	.cfi_def_cfa_offset 28
	pushl	$.LC5
	.cfi_def_cfa_offset 32
	call	printk
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$idt
	.cfi_def_cfa_offset 28
	pushl	$.LC6
	.cfi_def_cfa_offset 32
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$init_stack
	.cfi_def_cfa_offset 28
	pushl	$.LC7
	.cfi_def_cfa_offset 32
	call	printk
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	mem_size
	.cfi_def_cfa_offset 28
	pushl	$.LC8
	.cfi_def_cfa_offset 32
	call	printk
#APP
# 30 "init/Main.c" 1
	int $0x18
# 0 "" 2
# 31 "init/Main.c" 1
	sti
# 0 "" 2
#NO_APP
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	.p2align 4,,10
	.p2align 3
.L2:
#APP
# 33 "init/Main.c" 1
	hlt
# 0 "" 2
#NO_APP
	jmp	.L2
	.cfi_endproc
.LFE0:
	.size	Main, .-Main
	.section	.text.unlikely
.LCOLDE9:
	.text
.LHOTE9:
	.comm	mem_size,4,4
	.globl	init_stack
	.data
	.align 4
	.type	init_stack, @object
	.size	init_stack, 8
init_stack:
	.long	651264
	.long	16
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits

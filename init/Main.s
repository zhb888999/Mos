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
	.string	"mem_low_size:%d\n"
.LC9:
	.string	"mem_hi_size:%d\n"
.LC10:
	.string	"mem_size:%d\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB11:
	.text
.LHOTB11:
	.p2align 4,,15
	.globl	Main
	.type	Main, @function
Main:
.LFB0:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$16, %esp
	.cfi_def_cfa_offset 24
	movzwl	589824, %edx
	movzwl	589826, %eax
	pushl	$_pg_dir
	.cfi_def_cfa_offset 28
	pushl	$.LC0
	.cfi_def_cfa_offset 32
	shrw	$10, %dx
	shrw	$4, %ax
	movzwl	%dx, %edx
	movzwl	%ax, %eax
	leal	1(%edx,%eax), %ebx
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
	pushl	$_gdt
	.cfi_def_cfa_offset 28
	pushl	$.LC5
	.cfi_def_cfa_offset 32
	call	printk
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$_idt
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
	movzwl	589824, %eax
	pushl	%eax
	.cfi_def_cfa_offset 28
	pushl	$.LC8
	.cfi_def_cfa_offset 32
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	movzwl	589826, %eax
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	%eax
	.cfi_def_cfa_offset 28
	pushl	$.LC9
	.cfi_def_cfa_offset 32
	call	printk
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	%ebx
	.cfi_def_cfa_offset 28
	pushl	$.LC10
	.cfi_def_cfa_offset 32
	call	printk
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	.p2align 4,,10
	.p2align 3
.L2:
#APP
# 34 "init/Main.c" 1
	hlt
# 0 "" 2
#NO_APP
	jmp	.L2
	.cfi_endproc
.LFE0:
	.size	Main, .-Main
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
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

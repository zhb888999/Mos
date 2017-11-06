	.file	"Main.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"time:%d\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	int_time
	.type	int_time, @function
int_time:
.LFB1:
	.cfi_startproc
	subl	$20, %esp
	.cfi_def_cfa_offset 24
	movl	time, %eax
	movl	$32, %edx
	leal	1(%eax), %ecx
	movl	$32, %eax
	movl	%ecx, time
#APP
# 38 "init/Main.c" 1
	outb %al,%dx
# 0 "" 2
#NO_APP
	pushl	%ecx
	.cfi_def_cfa_offset 28
	pushl	$.LC0
	.cfi_def_cfa_offset 32
	call	printk
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE1:
	.size	int_time, .-int_time
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.rodata.str1.1
.LC2:
	.string	"pg_dir:%p\n"
.LC3:
	.string	"pg0:%p\n"
.LC4:
	.string	"pg1:%p\n"
.LC5:
	.string	"pg2:%p\n"
.LC6:
	.string	"pg3:%p\n"
.LC7:
	.string	"gdt:%p\n"
.LC8:
	.string	"idt:%p\n"
.LC9:
	.string	"init_stack:%p\n"
.LC10:
	.string	"mem_size:%d\n"
	.section	.text.unlikely
.LCOLDB11:
	.text
.LHOTB11:
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
# 19 "init/Main.c" 1
	outb %al,%dx
	jmp 1f
1:	jmp 1f
1:
# 0 "" 2
#NO_APP
	movl	$64, %edx
	movl	$155, %eax
#APP
# 20 "init/Main.c" 1
	outb %al,%dx
	jmp 1f
1:	jmp 1f
1:
# 0 "" 2
#NO_APP
	movl	$46, %eax
#APP
# 21 "init/Main.c" 1
	outb %al,%dx
	jmp 1f
1:	jmp 1f
1:
# 0 "" 2
#NO_APP
	movl	$524288, %eax
	movl	$int_time, %edx
#APP
# 22 "init/Main.c" 1
	movw %dx,%ax
	movw $-29184,%dx
	movl %eax,idt+256
	movl %edx,idt+260
# 0 "" 2
# 23 "init/Main.c" 1
	sti
# 0 "" 2
#NO_APP
	movl	$33, %edx
#APP
# 24 "init/Main.c" 1
	inb %dx,%al
	jmp 1f
1:	jmp 1f
1:
# 0 "" 2
#NO_APP
	andl	$254, %eax
#APP
# 24 "init/Main.c" 1
	outb %al,%dx
# 0 "" 2
#NO_APP
	pushl	$pg_dir
	.cfi_def_cfa_offset 28
	pushl	$.LC2
	.cfi_def_cfa_offset 32
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$pg0
	.cfi_def_cfa_offset 28
	pushl	$.LC3
	.cfi_def_cfa_offset 32
	call	printk
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$pg1
	.cfi_def_cfa_offset 28
	pushl	$.LC4
	.cfi_def_cfa_offset 32
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$pg2
	.cfi_def_cfa_offset 28
	pushl	$.LC5
	.cfi_def_cfa_offset 32
	call	printk
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$pg3
	.cfi_def_cfa_offset 28
	pushl	$.LC6
	.cfi_def_cfa_offset 32
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$gdt
	.cfi_def_cfa_offset 28
	pushl	$.LC7
	.cfi_def_cfa_offset 32
	call	printk
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$idt
	.cfi_def_cfa_offset 28
	pushl	$.LC8
	.cfi_def_cfa_offset 32
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$init_stack
	.cfi_def_cfa_offset 28
	pushl	$.LC9
	.cfi_def_cfa_offset 32
	call	printk
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	mem_size
	.cfi_def_cfa_offset 28
	pushl	$.LC10
	.cfi_def_cfa_offset 32
	call	printk
	addl	$16, %esp
	.cfi_def_cfa_offset 16
.L4:
	jmp	.L4
	.cfi_endproc
.LFE0:
	.size	Main, .-Main
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
	.comm	mem_size,4,4
	.globl	time
	.bss
	.align 4
	.type	time, @object
	.size	time, 4
time:
	.zero	4
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

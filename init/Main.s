	.file	"Main.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"This is int_test_trap!\n"
.LC1:
	.string	"eflags:%x "
	.section	.text.unlikely,"ax",@progbits
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.globl	int_test_trap
	.type	int_test_trap, @function
int_test_trap:
.LFB1:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$20, %esp
	.cfi_def_cfa_offset 28
#APP
# 70 "init/Main.c" 1
	pushf
	pop	%eax
	
# 0 "" 2
#NO_APP
	pushl	$.LC0
	.cfi_def_cfa_offset 32
	movl	%eax, %ebx
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	%ebx
	.cfi_def_cfa_offset 28
	pushl	$.LC1
	.cfi_def_cfa_offset 32
	call	printk
	addl	$24, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE1:
	.size	int_test_trap, .-int_test_trap
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.rodata.str1.1
.LC3:
	.string	"This is int_test_intr!\n"
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
	.p2align 4,,15
	.globl	int_test_intr
	.type	int_test_intr, @function
int_test_intr:
.LFB2:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$20, %esp
	.cfi_def_cfa_offset 28
#APP
# 76 "init/Main.c" 1
	pushf
	pop	%eax
	
# 0 "" 2
#NO_APP
	pushl	$.LC3
	.cfi_def_cfa_offset 32
	movl	%eax, %ebx
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	%ebx
	.cfi_def_cfa_offset 28
	pushl	$.LC1
	.cfi_def_cfa_offset 32
	call	printk
	addl	$24, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE2:
	.size	int_test_intr, .-int_test_intr
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.rodata.str1.1
.LC5:
	.string	"This is int_test_system!\n"
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.p2align 4,,15
	.globl	int_test_system
	.type	int_test_system, @function
int_test_system:
.LFB3:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$20, %esp
	.cfi_def_cfa_offset 28
#APP
# 82 "init/Main.c" 1
	pushf
	pop	%eax
	
# 0 "" 2
#NO_APP
	pushl	$.LC5
	.cfi_def_cfa_offset 32
	movl	%eax, %ebx
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	%ebx
	.cfi_def_cfa_offset 28
	pushl	$.LC1
	.cfi_def_cfa_offset 32
	call	printk
	addl	$24, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE3:
	.size	int_test_system, .-int_test_system
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.rodata.str1.1
.LC7:
	.string	"pg_dir:%p\n"
.LC8:
	.string	"pg0:%p\n"
.LC9:
	.string	"pg1:%p\n"
.LC10:
	.string	"pg2:%p\n"
.LC11:
	.string	"pg3:%p\n"
.LC12:
	.string	"gdt:%p\n"
.LC13:
	.string	"idt:%p\n"
.LC14:
	.string	"init_stack:%p\n"
.LC15:
	.string	"mem_size:%d\n"
.LC16:
	.string	"Not open int eflags:%x\n"
.LC17:
	.string	"iret eflags:%x\n"
.LC18:
	.string	"Open int eflags:%x\n"
	.section	.text.unlikely
.LCOLDB19:
	.text
.LHOTB19:
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
# 24 "init/Main.c" 1
	outb %al,%dx
	
# 0 "" 2
#NO_APP
	movl	$64, %edx
	movl	$154, %eax
#APP
# 25 "init/Main.c" 1
	outb %al,%dx
	
# 0 "" 2
#NO_APP
	movl	$46, %eax
#APP
# 26 "init/Main.c" 1
	outb %al,%dx
	
# 0 "" 2
#NO_APP
	pushl	$pg_dir
	.cfi_def_cfa_offset 28
	pushl	$.LC7
	.cfi_def_cfa_offset 32
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$pg0
	.cfi_def_cfa_offset 28
	pushl	$.LC8
	.cfi_def_cfa_offset 32
	call	printk
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$pg1
	.cfi_def_cfa_offset 28
	pushl	$.LC9
	.cfi_def_cfa_offset 32
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$pg2
	.cfi_def_cfa_offset 28
	pushl	$.LC10
	.cfi_def_cfa_offset 32
	call	printk
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$pg3
	.cfi_def_cfa_offset 28
	pushl	$.LC11
	.cfi_def_cfa_offset 32
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$gdt
	.cfi_def_cfa_offset 28
	pushl	$.LC12
	.cfi_def_cfa_offset 32
	call	printk
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$idt
	.cfi_def_cfa_offset 28
	pushl	$.LC13
	.cfi_def_cfa_offset 32
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$init_stack
	.cfi_def_cfa_offset 28
	pushl	$.LC14
	.cfi_def_cfa_offset 32
	call	printk
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	mem_size
	.cfi_def_cfa_offset 28
	pushl	$.LC15
	.cfi_def_cfa_offset 32
	call	printk
#APP
# 36 "init/Main.c" 1
	cli
# 0 "" 2
# 37 "init/Main.c" 1
	int $50
# 0 "" 2
#NO_APP
	movl	$524288, %eax
	movl	$int_test_trap, %edx
#APP
# 39 "init/Main.c" 1
	movw %dx,%ax
	movw $-28928,%dx
	movl %eax,idt+400
	movl %edx,idt+404
# 0 "" 2
#NO_APP
	movl	$int_test_intr, %edx
#APP
# 40 "init/Main.c" 1
	movw %dx,%ax
	movw $-29184,%dx
	movl %eax,idt+408
	movl %edx,idt+412
# 0 "" 2
#NO_APP
	movl	$int_test_system, %edx
#APP
# 41 "init/Main.c" 1
	movw %dx,%ax
	movw $-4352,%dx
	movl %eax,idt+416
	movl %edx,idt+420
# 0 "" 2
# 42 "init/Main.c" 1
	pushf
	pop	%eax
	
# 0 "" 2
#NO_APP
	popl	%edx
	.cfi_def_cfa_offset 28
	popl	%ecx
	.cfi_def_cfa_offset 24
	pushl	%eax
	.cfi_def_cfa_offset 28
	pushl	$.LC16
	.cfi_def_cfa_offset 32
	call	printk
#APP
# 44 "init/Main.c" 1
	int $50
# 0 "" 2
# 45 "init/Main.c" 1
	pushf
	pop	%eax
	
# 0 "" 2
#NO_APP
	popl	%edx
	.cfi_def_cfa_offset 28
	popl	%ecx
	.cfi_def_cfa_offset 24
	pushl	%eax
	.cfi_def_cfa_offset 28
	pushl	$.LC17
	.cfi_def_cfa_offset 32
	call	printk
#APP
# 47 "init/Main.c" 1
	int $51
# 0 "" 2
# 48 "init/Main.c" 1
	pushf
	pop	%eax
	
# 0 "" 2
#NO_APP
	popl	%edx
	.cfi_def_cfa_offset 28
	popl	%ecx
	.cfi_def_cfa_offset 24
	pushl	%eax
	.cfi_def_cfa_offset 28
	pushl	$.LC17
	.cfi_def_cfa_offset 32
	call	printk
#APP
# 50 "init/Main.c" 1
	int $52
# 0 "" 2
# 51 "init/Main.c" 1
	pushf
	pop	%eax
	
# 0 "" 2
#NO_APP
	popl	%edx
	.cfi_def_cfa_offset 28
	popl	%ecx
	.cfi_def_cfa_offset 24
	pushl	%eax
	.cfi_def_cfa_offset 28
	pushl	$.LC17
	.cfi_def_cfa_offset 32
	call	printk
#APP
# 53 "init/Main.c" 1
	sti
# 0 "" 2
# 54 "init/Main.c" 1
	pushf
	pop	%eax
	
# 0 "" 2
#NO_APP
	popl	%edx
	.cfi_def_cfa_offset 28
	popl	%ecx
	.cfi_def_cfa_offset 24
	pushl	%eax
	.cfi_def_cfa_offset 28
	pushl	$.LC18
	.cfi_def_cfa_offset 32
	call	printk
#APP
# 56 "init/Main.c" 1
	int $50
# 0 "" 2
# 57 "init/Main.c" 1
	pushf
	pop	%eax
	
# 0 "" 2
#NO_APP
	popl	%edx
	.cfi_def_cfa_offset 28
	popl	%ecx
	.cfi_def_cfa_offset 24
	pushl	%eax
	.cfi_def_cfa_offset 28
	pushl	$.LC17
	.cfi_def_cfa_offset 32
	call	printk
#APP
# 59 "init/Main.c" 1
	int $51
# 0 "" 2
# 60 "init/Main.c" 1
	pushf
	pop	%eax
	
# 0 "" 2
#NO_APP
	popl	%edx
	.cfi_def_cfa_offset 28
	popl	%ecx
	.cfi_def_cfa_offset 24
	pushl	%eax
	.cfi_def_cfa_offset 28
	pushl	$.LC17
	.cfi_def_cfa_offset 32
	call	printk
#APP
# 62 "init/Main.c" 1
	int $52
# 0 "" 2
# 63 "init/Main.c" 1
	pushf
	pop	%eax
	
# 0 "" 2
#NO_APP
	popl	%edx
	.cfi_def_cfa_offset 28
	popl	%ecx
	.cfi_def_cfa_offset 24
	pushl	%eax
	.cfi_def_cfa_offset 28
	pushl	$.LC17
	.cfi_def_cfa_offset 32
	call	printk
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	.p2align 4,,10
	.p2align 3
.L8:
#APP
# 66 "init/Main.c" 1
	hlt
# 0 "" 2
#NO_APP
	jmp	.L8
	.cfi_endproc
.LFE0:
	.size	Main, .-Main
	.section	.text.unlikely
.LCOLDE19:
	.text
.LHOTE19:
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

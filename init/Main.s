	.file	"Main.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Hello,World!%d\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	Main
	.type	Main, @function
Main:
.LFB0:
	.cfi_startproc
	subl	$20, %esp
	.cfi_def_cfa_offset 24
	pushl	$4
	.cfi_def_cfa_offset 28
	pushl	$.LC0
	.cfi_def_cfa_offset 32
	call	printk
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$4
	.cfi_def_cfa_offset 28
	pushl	$.LC0
	.cfi_def_cfa_offset 32
	call	printk
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	.p2align 4,,10
	.p2align 3
.L2:
#APP
# 8 "init/Main.c" 1
	hlt
# 0 "" 2
#NO_APP
	jmp	.L2
	.cfi_endproc
.LFE0:
	.size	Main, .-Main
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits

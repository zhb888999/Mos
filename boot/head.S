.code32
.text
.globl _start,Main
_start:

	movl	$0x10,%eax
	mov		%ax,%ds
	mov		%ax,%es
	mov 	%ax,%fs
	mov 	%ax,%gs

	lss		init_stack,%esp
	movl	$0x90000,%esp
	pushl $0		# These are the parameters to main :-)
	pushl $0
	pushl $0
	pushl $L6		# return address for main, if it decides to.
	pushl $Main
	
	ret
L6: 
	jmp L6
init_stack:
		.long init_stack
		.word 0x10

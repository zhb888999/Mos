# 1 "boot/head.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "boot/head.S"

 .code32
.text
.globl _start,_idt,_gdt,_pg_dir,_tmp_floppy_area,pg0,pg1,pg2,pg3
_pg_dir:
_start:
 movl $0x10,%eax
 mov %ax,%ds
 mov %ax,%es
 mov %ax,%fs
 mov %ax,%gs
 lss init_stack,%esp
 call setup_idt
 call setup_gdt
 movl $0x10,%eax # reload all the segment registers
 mov %ax,%ds # after changing gdt. CS was already
 mov %ax,%es # reloaded in 'setup_gdt'
 mov %ax,%fs
 mov %ax,%gs
 lss init_stack,%esp
 xorl %eax,%eax
1: incl %eax # check that A20 really IS enabled
 movl %eax,0x000000 # loop forever if it isn't
 cmpl %eax,0x100000
 je 1b






 movl %cr0,%eax # check math chip
 andl $0x80000011,%eax # Save PG,PE,ET

 orl $2,%eax # set MP
 movl %eax,%cr0
 call check_x87
 jmp after_page_tables




check_x87:
 fninit
 fstsw %ax
 cmpb $0,%al
 je 1f
 movl %cr0,%eax
 xorl $6,%eax
 movl %eax,%cr0
 ret
.align 4
1: .byte 0xDB,0xE4
 ret
# 67 "boot/head.S"
setup_idt:
 lea ignore_int,%edx
 movl $0x00080000,%eax
 movw %dx,%ax
 movw $0x8E00,%dx

 lea _idt,%edi
 mov $256,%ecx
rp_sidt:
 movl %eax,(%edi)
 movl %edx,4(%edi)
 addl $8,%edi
 dec %ecx
 jne rp_sidt
 lidt idt_descr
 ret
# 94 "boot/head.S"
setup_gdt:
 lgdt gdt_descr
 ret






.org 0x1000
pg0:

.org 0x2000
pg1:

.org 0x3000
pg2:

.org 0x4000
pg3:

.org 0x5000





_tmp_floppy_area:
 .fill 1024,1,0

after_page_tables:
 pushl $0 # These are the parameters to main :-)
 pushl $0
 pushl $0
 pushl $L6 # return address for main, if it decides to.
 pushl $Main
 jmp setup_paging
L6:
 jmp L6 # main should never return here, but
    # just in case, we know what happens.


int_msg:
 .asciz "Unknown interrupt\n"
.align 4
ignore_int:
 pushl %eax
 pushl %ecx
 pushl %edx
 push %ds
 push %es
 push %fs
 movl $0x10,%eax
 mov %ax,%ds
 mov %ax,%es
 mov %ax,%fs
 pushl $int_msg
 call printk
 popl %eax
 pop %fs
 pop %es
 pop %ds
 popl %edx
 popl %ecx
 popl %eax
 iret
# 186 "boot/head.S"
.align 4
setup_paging:
 movl $1024*5,%ecx
 xorl %eax,%eax
 xorl %edi,%edi
 cld;rep;stosl
 movl $pg0+7,_pg_dir
 movl $pg1+7,_pg_dir+4
 movl $pg2+7,_pg_dir+8
 movl $pg3+7,_pg_dir+12
 movl $pg3+4092,%edi
 movl $0xfff007,%eax
 std
1: stosl
 subl $0x1000,%eax
 jge 1b
 xorl %eax,%eax
 movl %eax,%cr3
 movl %cr0,%eax
 orl $0x80000000,%eax
 movl %eax,%cr0
 ret

.align 4
.word 0
idt_descr:
 .word 256*8-1 # idt contains 256 entries
 .long _idt
.align 4
.word 0
gdt_descr:
 .word 256*8-1 # so does gdt (not that that's any
 .long _gdt # magic number, but it works for me :^)

 .align 8
_idt: .fill 256,8,0 # idt is uninitialized

_gdt: .quad 0x0000000000000000
 .quad 0x00c09a0000000fff
 .quad 0x00c0920000000fff
 .quad 0x0000000000000000
 .fill 252,8,0

# 1 "boot/setup.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "boot/setup.S"
# 1 "include/Mos/config.h" 1



DEF_INITSEG = 0x9000
DEF_SETUPSEG = 0x9020
DEF_SYSSEG = 0x1000
DEF_SYSTOPSEG = DEF_INITSEG
DEF_SETUPLEN = 3
DEF_SECTORS = 18
DEF_DRIVER_ID = 0
DEF_MAGNETIC_HEADS = 2
# 2 "boot/setup.S" 2

INITSEG = DEF_INITSEG
SYSSEG = DEF_SYSSEG
SETUPSEG = DEF_SETUPSEG
MESSEG = DEF_INITSEG
# 43 "boot/setup.S"
.code16
.text
.globl _start, begtext, begdata, begbss, endtext, enddata, endbss

.text
begtext:
.data
begdata:
.bss
begbss:
.text
_start:


 movw %cs,%ax
 movw %ax,%es
 movw $10,%cx
 movw $0x0300,%dx
 movw $0x000f,%bx
 movw $msg,%bp
 movw $0x1301,%ax
 int $0x10


 movw $MESSEG,%ax
 movw %ax,%es
 movw %ax,%ds
# 82 "boot/setup.S"
 movw $0xe801, %ax
 int $0x15
 movw %ax,%es:0
 movw %bx,%es:2
 movw %cx,%es:4
 movw %dx,%es:6






 movb $0x12,%ah
 movb $0x10,%bl
 int $0x10
 movw %bx,%es:8
 movw %cx,%es:10

 movw $0x5019,%ax
 movw %ax,%es:12





 movb $0x03,%ah
 xorb %bh,%bh
 int $0x10
 movw %dx,%es:14




 movb $0x0f,%ah
 int $0x10
 movw %bx,%es:16
 movw %ax,%es:18



 xorw %ax, %ax
 movw %ax, %ds
 ldsw (4 * 0x41), %si
 movw $MESSEG, %ax
 movw %ax, %es
 movw $0x0020, %di
 movw $0x10, %cx
 cld
 rep
  movsb

 xorw %ax, %ax
 movw %ax, %ds
 ldsw (4 * 0x46), %si
 movw $MESSEG, %ax
 movw %ax, %es
 movw $0x0030, %di
 movw $0x10, %cx
 cld
 rep
 movsb
# Check that there IS a hd1 :-)
 movw $MESSEG, %ax
 movb $0x81, %dl
 int $0x13
 jc no_disk1

 cmpb $3, %ah
 je is_disk1

no_disk1:
 movw $MESSEG, %ax
 movw %ax, %es
 movw $0x0030, %di
 movw $0x10, %cx
 xorw %ax, %ax
 cld
 rep
 stosb
is_disk1:
# 174 "boot/setup.S"
 movw $MESSEG, %ax
 movw %ax, %es
 xorw %bx,%bx
 movb $0x03,%ah
 movb $0x01,%al
 xorw %dx,%dx
 movb $0x00,%ch
 movb $0x03,%cl
 int $0x13







 movb $0x03,%al
 movb $0x00,%ah
 int $0x10

 cli
 movw $0x0000,%ax
 cld

do_move:
 movw %ax,%es
 addw $SYSSEG,%ax
 cmp $INITSEG,%ax
 jz end_move
 movw %ax,%ds
 subw %di,%di
 subw %si,%si
 movw $0x8000,%cx
 rep
 movsw
 jmp do_move
end_move:

 movw $SETUPSEG,%ax
 movw %ax,%ds
 movw %ax,%es
 lidt idt_48
 lgdt gdt_48

 call empty_8042

 movb $0xd1,%al
 outb %al,$0x64
 call empty_8042
 movb $0xdf,%al
 outb %al,$0x60
 call empty_8042

 movb $0x11,%al
 outb %al,$0x20
 .word 0x00eb,0x00eb
 outb %al,$0xA0
 .word 0x00eb,0x00eb
 movb $0x20,%al
 outb %al,$0x21
 .word 0x00eb,0x00eb
 movb $0x28,%al
 outb %al,$0xA1
 .word 0x00eb,0x00eb
 movb $0x04,%al
 outb %al,$0x21
 .word 0x00eb,0x00eb
 movb $0x02,%al
 outb %al,$0xA1
 .word 0x00eb,0x00eb
 movb $0x01,%al
 outb %al,$0x21
 .word 0x00eb,0x00eb
 outb %al,$0xA1
 .word 0x00eb,0x00eb
 movb $0xFF,%al
 outb %al,$0x21
 .word 0x00eb,0x00eb
 outb %al,$0xA1

 movw $1,%ax
 lmsw %ax
 jmp flush_instr

flush_instr:
    xorw %bx, %bx # Flag to indicate a boot
    xorl %esi, %esi # Pointer to real-mode code
    movw %cs, %si
    subw $0x0020, %si
    shll $4, %esi # Convert to 32-bit pointer
 .byte 0x66, 0xea # prefix + jmpi-opcode
code32:
 .long 0x000000 # will be set to 0x100000
    .word 0x0008

empty_8042:
 .word 0x00eb,0x00eb
 in $0x64,%al
 test $2,%al
 jnz empty_8042
 ret
.align 16
gdt:
 .word 0,0,0,0

 .word 0x07FF
 .word 0x0000
 .word 0x9A00
 .word 0x00C0

 .word 0x07FF
 .word 0x0000
 .word 0x9200
 .word 0x00C0

idt_48:
 .word 0
 .word 0,0

gdt_48:
 .word 0x800
 .word 512+gdt,0x9

msg:
 .ascii "This setup!"
.text
endtext:
.data
enddata:
.bss
endbss:

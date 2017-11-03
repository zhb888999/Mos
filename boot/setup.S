DEF_INITSEG = 0x9000
DEF_SYSSEG = 0x1000
DEF_MES = 0x9000
DEF_SETUPSEG = 0x9020
INITSEG = DEF_INITSEG
SETUPSEG = DEF_SETUPSEG
SYSSEG = DEF_SYSSEG
MESSEG = DEF_MES
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
/** 屏幕显示
*/
	movw	%cs,%ax
	movw	%ax,%es
	movw	$10,%cx
	movw	$0x0300,%dx
	movw	$0x000f,%bx
	movw	$msg,%bp
	movw	$0x1301,%ax
	int		$0x10
/**将es、ds段指向0x1000，保存读取的值
*/
	movw	$MESSEG,%ax
	movw	%ax,%es
	movw	%ax,%ds
/**读取内存大小,存储在0x1000段起始处的8个字节
* int 0x15 ax = 0xe801的使用简介
* 中断服务：0x15
* AX：  0xE801
* 输入： 无
* 输出： AX = 低于16M的扩展内存大小（单位1KB，最大0x3c00 = 15MB），或为0
* BX = 大于16M的扩展内存大小（单位64KB，最大4GB），或为0
* CX = 低于16M的扩展内存大小（单位1KB，最大0x3c00 = 15MB），或为0
* DX = 大于16M的扩展内存大小（单位64KB，最大4GB），或为0
* 返回：CF置位表示出错
* 其他：在一些BIOS上使用CX/DX替代AX/BX表示内存大小，这时候AX/BX被置0。
*/	
	movw	$0xe801, %ax
	int 	$0x15
	movw	%ax,%es:0
	movw	%bx,%es:2
	movw	%cx,%es:4
	movw	%dx,%es:6
/**检查显示方式（EGA/VGA)并取参数
* 调用BIOS中断0x10，功能号：ah=0x12,b1=0x10
* 返回：bh = 显示状态。0x00 - 彩色模式，I/O端口=0x3dX；0x01 -单色模式，I/O端口=0x3bX。
* bl = 安装的显示内存。0x00 - 64KB；0x01 - 128KB；0x03 = 256KB。
* cx = 显示卡特性参数。
*/
	movb	$0x12,%ah
	movb	$0x10,%bl
	int 	$0x10
	movw	%ax,%es:8
	movw	%bx,%es:10
	movw	%cx,%es:12
		
	movw	$0x5019,%ax	//预设屏幕默认行列值（ah = 80,al = 25)
	movw	%ax,%es:14
/**读取当前光标位置
* 调用BIOS中断0x10，功能号：ah = 0x03，读取光标位置
* 输入：bh = 页号
* 返回：ch = 扫描开始线；cl = 扫描结束线；bh = 行号(0x00顶端)；dl = 列号(0x00最左边)。
*/
	movb	$0x03,%ah
	xorb	%bh,%bh
	int 	$0x10
	movw	%dx,%es:16
/**读取显示卡模式
* 调用BIOS中断0x10，功能号：ah = 0x0f
* 返回：ah = 字符列数；al = 显示模式； bh = 当前显示页。
	movb	$0x0f,%ah
	int 	$0x10
	movw	%bx,%es:18
	movw	%ax,%es:20
/**取第一个硬盘的信息表（复制硬盘参数表）
* 
*/
	xorw	%ax, %ax
	movw	%ax, %ds
	ldsw	(4 * 0x41), %si
	movw	$MESSEG, %ax
	movw	%ax, %es
	movw	$0x0020, %di
	movw	$0x10, %cx
	cld
	rep
 	movsb
/* Get hd1 data... */
	xorw	%ax, %ax
	movw	%ax, %ds
	ldsw	(4 * 0x46), %si
	movw	$MESSEG, %ax
	movw	%ax, %es
	movw	$0x0030, %di
	movw	$0x10, %cx
	cld
	rep
	movsb
# Check that there IS a hd1 :-)
	movw	$MESSEG, %ax
	movb	$0x81, %dl
	int		$0x13
	jc		no_disk1
	
	cmpb	$3, %ah
	je		is_disk1

no_disk1:
	movw	$MESSEG, %ax
	movw	%ax, %es
	movw	$0x0030, %di
	movw	$0x10, %cx
	xorw	%ax, %ax
	cld
	rep
	stosb
is_disk1:
/**将MESSEG段开始的512字节读入到软盘A的第3个扇区
* (ah)=int 13h的功能号（3表示写扇区）
* (al)=写入的扇区数
* (ch)=磁道号
* (cl)=扇区号
* (dh)=磁头号（面）
* (dl)=驱动器号 
* 软驱从0开始，0：软驱A，1：软驱B；
* 硬盘从80h开始，80h：硬盘C，81h：硬盘D。
* es:bx指向将写入磁盘的数据
*
*/		
	movw	$MESSEG, %ax
	movw	%ax, %es
	xorw	%bx,%bx
	movb	$0x03,%ah	
	movb	$0x01,%al
	xorw	%dx,%dx
	movb	$0x00,%ch
	movb	$0x03,%cl
	int 	$0x13

/** VGA显卡，al = 0x03 ,设置显示模式（占用地址范围0xb8000~0xbc000)
* 偶字节存放字符代码，奇字节存放属性
* D7 D6 D5 D4 D3 D2 D1 D0
* BL R  G  B  I  R 	G  B
* 闪烁 背景色 高亮度 前景色
*/
	movb 	$0x03,%al
	movb	$0x00,%ah
	int		$0x10
	
	cli
	movw	$0x0000,%ax
	cld

do_move:
	movw	%ax,%es
	addw	$0x1000,%ax
	cmp		$0x9000,%ax
	jz		end_move
	movw	%ax,%ds
	subw	%di,%di
	subw	%si,%si
	movw	$0x8000,%cx
	rep
	movsw
	jmp		do_move
end_move:

	movw	$SETUPSEG,%ax
	movw	%ax,%ds
	movw	%ax,%es
	lidt	idt_48
	lgdt	gdt_48
	
	call	empty_8042
	
	movb	$0xd1,%al
	outb	%al,$0x64
	call	empty_8042
	movb	$0xdf,%al
	outb	%al,$0x60
	call	empty_8042
	
	movb	$0x11,%al		//initialization sequence
	outb	%al,$0x20		//send it to 8259A-1
	.word	0x00eb,0x00eb		//jmp $+2, jmp $+2
	outb	%al,$0xA0		//and to 8259A-2
	.word	0x00eb,0x00eb
	movb	$0x20,%al		//start of hardware int's (0x20)
	outb	%al,$0x21
	.word	0x00eb,0x00eb
	movb	$0x28,%al		//start of hardware int's 2 (0x28)
	outb	%al,$0xA1
	.word	0x00eb,0x00eb
	movb	$0x04,%al		//8259-1 is master
	outb	%al,$0x21
	.word	0x00eb,0x00eb
	movb	$0x02,%al		//8259-2 is slave
	outb	%al,$0xA1
	.word	0x00eb,0x00eb
	movb	$0x01,%al		//8086 mode for both
	outb	%al,$0x21
	.word	0x00eb,0x00eb
	outb	%al,$0xA1
	.word	0x00eb,0x00eb
	movb	$0xFF,%al		//mask off all interrupts for now
	outb	%al,$0x21
	.word	0x00eb,0x00eb
	outb	%al,$0xA1

	movw	$1,%ax
	lmsw	%ax
	jmp    flush_instr

flush_instr:
    xorw    %bx, %bx            # Flag to indicate a boot
    xorl    %esi, %esi            # Pointer to real-mode code
    movw    %cs, %si
    subw    $0x0020, %si
    shll    $4, %esi            # Convert to 32-bit pointer
	.byte 0x66, 0xea            # prefix + jmpi-opcode
code32:    
	.long    0x000000             # will be set to 0x100000
    .word    0x0008

empty_8042:
	.word	0x00eb,0x00eb
	in		$0x64,%al
	test	$2,%al
	jnz		empty_8042
	ret
.align 16	
gdt:
	.word	0,0,0,0		//dummy

	.word	0x07FF		//8Mb - limit=2047 (2048*4096=8Mb)
	.word	0x0000		//base address=0
	.word	0x9A00		//code read/exec
	.word	0x00C0		//granularity=4096, 386

	.word	0x07FF		//8Mb - limit=2047 (2048*4096=8Mb)
	.word	0x0000		//base address=0
	.word	0x9200		//data read/write
	.word	0x00C0		// granularity=4096, 386

idt_48:
	.word	0			//idt limit=0
	.word	0,0			//idt base=0L

gdt_48:
	.word	0x800		//gdt limit=2048, 256 GDT entries
	.word	512+gdt,0x9	//gdt base = 0X9xxxx
	
msg:
	.ascii "This setup!"
.text
endtext:
.data
enddata:
.bss
endbss:
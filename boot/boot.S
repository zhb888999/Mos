DEF_INITSEG = 0x9000
DEF_SETUPSEG = 0x9020
DEF_SYSSEG = 0x1000
DEF_SYSTOPSEG = DEF_INITSEG
DEF_SETUPLEN = 3
DEF_SECTORS = 18
DEF_TRACKS = 56
DEF_DRIVER_ID = 0
DEF_MAGNETIC_HEADS = 2

INITSEG = DEF_INITSEG
SETUPSEG = DEF_SETUPSEG
SYSSEG = DEF_SYSSEG
SYSTOPSEG = DEF_SYSTOPSEG
SETUPLEN = DEF_SETUPLEN
SECTORS = DEF_SECTORS
TRACKS = DEF_TRACKS
DRIVER_ID = DEF_DRIVER_ID
MAGNETIC_HEADS = DEF_MAGNETIC_HEADS
BOOTSEG = 0x07C0

.code16
.text
.globl _start
_start:
/**BOOT将256个字即512个字节从0x07C0移动到0x9000
*/
	movw	$BOOTSEG,%ax 
	movw	%ax,%ds
	movw	$INITSEG,%ax
	movw	%ax,%es
	movw	$256,%cx
	subw	%si,%si
	subw	%di,%di
	cld
	rep
	movsw
/**跳转到0x9000:go处执行
*/
	ljmp $INITSEG,$go
go:
	movw	%cs,%ax
	movw	$0xfef4,%dx
	
	movw	%ax,%ds
	movw	%ax,%es
	pushw	%ax
	movw	%ax,%ss
	movw	%dx,%sp
	
/** 清屏操作
*/
	movw $0x03,%ax
	int $0x10
/** 显示msg1
* dh行号，dl列号
*/	
	movw	%cs,%ax
	movw	%ax,%es
	movw	$18,%cx
	movw	$0x0000,%dx
	movw	$0x000f,%bx
	movw	$msg1,%bp
	movw	$0x1301,%ax
	int 	$0x10
/** 将磁盘数据加载到内存
*  将steup程序加载到0x9020:00处，加载512个字节
*  INT 0x13
*  ah = 0x02 读扇区到内存；al = 需要读取的扇区数量
*  ch = 磁道（柱面）号的低8位；cl = 开始扇区（位0—5），磁道号高2位（6-7）；
*  dh = 磁头号；	dl = 驱动器号；
*  es:bx 指向数据缓冲区：如果出错则CF标志置位，ah中是出错码
*/
load_setup:
	call 	reset_disk
	movb 	$DRIVER_ID,%dl
	movb	$0x00,%dh
	movb	$0x02, %cl				# sector 2, track 0
	movw	$0x0200, %bx			# address = 512, in INITSEG
	movb	$0x02, %ah				# service 2, "read sector(s)"
	movb	$SETUPLEN, %al					# (assume all on head 0, track 0)
	int		$0x13						# read it
	/*加载成功则直接跳转到ok_load_setup*/
	jnc	ok_load_setup		# ok - continue
	/*如果失败，屏幕显示出错信息，重新加载*/
	movw 	$16,%cx
	movw 	$0x0100,%dx
	movw 	$0x000f,%bx
	movw 	$msg2,%bp
	movw 	$0x1301,%ax
	int 	$0x10
	
	jmp	load_setup

ok_load_setup:
	movw	$18,%cx
	movw	$0x0100,%dx
	movw	$0x000f,%bx
	movw	$msg3,%bp
	movw	$0x1301,%ax
	int 	$0x10

/** 每次读取1个扇区的system，读到SYSSEG-512处，然后复制到相应的地址**/

	movb	$SETUPLEN+2,%cl 		#设置开始扇区
	movb	$0x00,%ch				#设置开始柱面
	movb	$0x00,%dh 				#设置开始磁头

	pushw   $SYSSEG-0x20			#将system起始地址的前512字节段地址入栈，之后每读取一个扇区则累加0x20
load_system:
	movw	$SYSSEG-0x20,%ax		#设置加载到的内存地址 es:bx
	movw	%ax,%es
	xorw	%bx,%bx 							
	movb	$0x01,%al 				#设置每次读取1个扇区数
	movb	$0x02,%ah				#设置int 0x13中断为读取扇区到内存
	movb	$DRIVER_ID,%dl 			#设置驱动器号

	call 	reset_disk
	int 	$0x13
	jnc		load_system_1 			#成功则跳转

	jmp		load_system
load_system_1:

	popw	%ax
	addw	$0x20,%ax
	movw 	%ax,%es
	pushw	%ax
	cmp		$SYSTOPSEG,%ax
	jae		ok_load_system

	pushw	%cx
	movw	$SYSSEG-0x20,%ax 
	movw	%ax,%ds
	movw	$256,%cx
	subw	%si,%si
	subw	%di,%di
	cld
	rep
	movsw
	popw	%cx


	addb	$0x01,%cl 			#开始扇区加1
	cmp		$SECTORS,%cl
	jbe		load_system 		#如果小于等于则跳转

	movb 	$0x01,%cl
	xorb 	$0x01,%dh 			#将dh取反
	cmp		$0x00,%dh
	jne		load_system
	addb	$0x01,%ch
	jmp		load_system
	
ok_load_system:

	movw	%cs,%ax
	movw	%ax,%es
	movw	$19,%cx 
	movw	$0x0200,%dx
	movw	$0x000f,%bx
	movw	$msg5,%bp
	movw	$0x1301,%ax
	int 	$0x10
	
	call	kill_motor
	ljmp	$SETUPSEG, $0

reset_disk:
	pushw 	%ax
	pushw	%dx
	xorw	%ax,%ax
	xorw	%dx,%dx
	int		$0x13
	popw		%dx
	popw		%ax
	ret
kill_motor:
	movw	$0x3f2, %dx
	xorb	%al, %al
	outb	%al, %dx
	ret

	
msg1:
	  .ascii "Lodaing System ..."
msg2:
	  .ascii "Loda Setup Error"
msg3:
	  .ascii "Loda Setup Success"
msg4:
	  .ascii "Loda System Error"
msg5:
	  .ascii "Loda System Success"
msg6:
	  .byte 13,10
	  .ascii "Test"
.org 510
      .word 0xAA55

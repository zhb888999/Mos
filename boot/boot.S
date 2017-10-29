DEF_INITSEG = 0x9000
DEF_SETUPSEG = 0x9020
DEF_SYSSEG = 0x1000
DEF_SYSTOPSEG = 0x9000
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
	int	$0x13						# read it
	/*加载成功则直接跳转到ok_load_setup*/
	jnc	ok_load_setup		# ok - continue
	/*如果失败，屏幕显示出错信息，重新加载*/
	movw $16,%cx
	movw $0x0100,%dx
	movw $0x000f,%bx
	movw $msg2,%bp
	movw $0x1301,%ax
	int $0x10
	
	jmp	load_setup

ok_load_setup:
	movw	$18,%cx
	movw	$0x0100,%dx
	movw	$0x000f,%bx
	movw	$msg3,%bp
	movw	$0x1301,%ax
	int 	$0x10
/** 读取system模块到0x1000段**/
load_system:
	movw	$SYSSEG,%ax		#设置加载到的内存地址
	movw	%ax,%es			
	xorw	%bx,%bx
	call 	reset_disk
	
	movb	$SECTORS - 1 -SETUPLEN,%al
	movb	$0x02,%ah
	movb	$SETUPLEN+2,%cl
	movb	$0,%ch
	movb 	$DRIVER_ID,%dl
	movb	$0,%dh
	int 	$0x13
	jnc		load_system_1	
	jmp		load_system
load_system_1:
	
	movw	%es,%ax
	addw	$0x020*(TRACKS - SETUPLEN - 1),%ax
	movw	%ax,%es
	addb	$1,%ch
	movb	$0x00,%dh
	xorw	%bx,%bx
	
load_system_2:

	movw	%es,%ax
	cmp		$SYSTOPSEG,%ax
	jae		ok_load_system
	
	cmp		$TRACKS,%ch
	jae		load_system_4
	
load_system_3:

	call reset_disk
	
	/*读取一个磁道的所有扇区*/
	movb	$SECTORS,%al		
	movb	$0x02,%ah
	movb 	$DRIVER_ID,%dl
	movb	$1,%cl
	xorw	%bx,%bx
	int		$0x13

	movw	%es,%ax
	addw	$0x0240,%ax
	movw	%ax,%es
	addb	$1,%ch
	
	jnc		load_system_2
	
	movw	%es,%ax
	xorw	$0x0240,%ax
	movw	%ax,% es
	xorb	$1,%ch
	
	jmp		load_system_2
	
load_system_4:

	addb	$1,%dh
	movb	$0,%ch
	cmpb	$MAGNETIC_HEADS,%dh
	jae		ok_load_system		
	jmp 	load_system_3
	
ok_load_system:

	movw	%cs,%ax
	movw	%ax,%es
	movw	$19,%cx
	movw	$0x0200,%dx
	movw	$0x000f,%bx
	movw	$msg5,%bp
	movw	$0x1301,%ax
	int 	$0x10
#loop1:	jmp loop1	
	call	kill_motor
	ljmp	$SETUPSEG, $0

reset_disk:
	pushw 	%ax
	pushw	%dx
	xorw	%ax,%ax
	xorw	%dx,%dx
	int		$0x13
	pop		%dx
	pop		%ax
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

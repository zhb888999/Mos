#ifndef _CONFIG_H
#define _CONFIG_H

DEF_INITSEG = 0x9000			//boot.s将自身复制到该地址后跳转继续执行
DEF_SETUPSEG = 0x9020			//boot.s加载setup模块的起始段地址
DEF_SYSSEG = 0x1000				//boot.s加载system模块的起始段地址
DEF_SYSTOPSEG = DEF_INITSEG		//boot.s加载system模块的结束段地址
DEF_SETUPLEN = 3				//setup模块所占扇区,要与Makefile文件dd命令对应，否则无法生成正确的img文件
DEF_SECTORS = 18				//默认的每个柱面扇区数量				
DEF_DRIVER_ID = 0				//默认驱动器号，默认为软盘
DEF_MAGNETIC_HEADS = 2			//默认的磁头数

#endif

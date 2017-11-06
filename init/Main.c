#include <Mos/kernel.h>
#include <asm/system.h>
//system模块最大32768行
#include <Mos/head.h>
struct {
	long *a;
	short int *b;
}init_stack = {0x9f000,0x10};
unsigned int time = 0;
unsigned int mem_size; //以Mb为单位
void int_time(void);
void Main(void)
{
	unsigned int a;
	unsigned short int *mem_low_szie = (int *)(0x90000);
	unsigned short int *mem_hi_szie  = (int *)(0x90002);
	mem_size = *mem_low_szie/1024 + *mem_hi_szie/16 + 1;
	unsigned short int LATCH = 11931;
	outb_p(0x36,0x43);
	outb_p(LATCH & 0xff,0x40);
	outb_p(LATCH >> 8,0x40);
	set_intr_gate(0x20,&int_time);
	sti();
	outb(inb_p(0x21)&~0x01,0x21);
	printk("pg_dir:%p\n",&pg_dir);
	printk("pg0:%p\n",&pg0);
	printk("pg1:%p\n",&pg1);
	printk("pg2:%p\n",&pg2);
	printk("pg3:%p\n",&pg3);
	printk("gdt:%p\n",&gdt);
	printk("idt:%p\n",&idt);
	printk("init_stack:%p\n",&init_stack);
	printk("mem_size:%d\n",mem_size);
	while(1);	
}
void int_time(void) {
	time++;
	outb(0x20,0x20);
	printk("time:%d\n",time);
	sti();
}
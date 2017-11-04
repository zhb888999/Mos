#include <Mos/kernel.h>
#include <asm/system.h>
//system模块最大32768行
extern char *_pg_dir;
extern char *pg0;
extern char *pg1;
extern char *pg2;
extern char *pg3;
extern char *_gdt;
extern char *_idt;
struct {
	long *a;
	short int *b;
}init_stack = {0x9f000,0x10};

unsigned int mem_size; //以Mb为单位

void Main(void)
{
	unsigned short int *mem_low_szie = (int *)(0x90000);
	unsigned short int *mem_hi_szie  = (int *)(0x90002);
	mem_size = *mem_low_szie/1024 + *mem_hi_szie/16 + 1;
	unsigned short int latch = 0x2e9a;
	outb(0x36,0x43);
	outb(0x9a,0x40);
	outb(0x2e,0x40);
	printk("pg_dir:%p\n",&_pg_dir);
	printk("pg0:%p\n",&pg0);
	printk("pg1:%p\n",&pg1);
	printk("pg2:%p\n",&pg2);
	printk("pg3:%p\n",&pg3);
	printk("gdt:%p\n",&_gdt);
	printk("idt:%p\n",&_idt);
	printk("init_stack:%p\n",&init_stack);
	printk("mem_size:%d\n",mem_size);
	asm("int $0x18"::);
	sti();
	for(;;)
		hlt();
}

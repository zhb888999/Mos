#include<Mos/kernel.h>
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

void Main(void)
{
	printk("pg_dir:%p\n",&_pg_dir);
	printk("pg0:%p\n",&pg0);
	printk("pg1:%p\n",&pg1);
	printk("pg2:%p\n",&pg2);
	printk("pg3:%p\n",&pg3);
	printk("gdt:%p\n",&_gdt);
	printk("idt:%p\n",&_idt);
	printk("init_stack:%p\n",&init_stack);
	for(;;)
		HLT();
}

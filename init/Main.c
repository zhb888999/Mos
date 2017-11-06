#include <Mos/kernel.h>
#include <asm/system.h>
//system模块最大32768行
#include <Mos/head.h>
struct {
	long *a;
	short int *b;
}init_stack = {0x9f000,0x10};

unsigned int mem_size; //以Mb为单位
void int_test_trap(void);
void int_test_intr(void);
void int_test_system(void);
void Main(void)
{
	int a = 1;
	int b = 0;
	int c;
	unsigned int eflags;
	unsigned short int *mem_low_szie = (int *)(0x90000);
	unsigned short int *mem_hi_szie  = (int *)(0x90002);
	mem_size = *mem_low_szie/1024 + *mem_hi_szie/16 + 1;
	unsigned short int latch = 0x2e9a;
	outb(0x36,0x43);
	outb(0x9a,0x40);
	outb(0x2e,0x40);
	printk("pg_dir:%p\n",&pg_dir);
	printk("pg0:%p\n",&pg0);
	printk("pg1:%p\n",&pg1);
	printk("pg2:%p\n",&pg2);
	printk("pg3:%p\n",&pg3);
	printk("gdt:%p\n",&gdt);
	printk("idt:%p\n",&idt);
	printk("init_stack:%p\n",&init_stack);
	printk("mem_size:%d\n",mem_size);
	cli();
	asm("int $50"::);
//	asm("movw $0x18,%%eax\n\t" "movw %%ax,%%es\n\t"::);
	set_trap_gate(50,&int_test_trap);
	set_intr_gate(51,&int_test_intr);
	set_system_gate(52,&int_test_system);
	store_eflags(eflags);
	printk("Not open int eflags:%x\n",eflags);
	asm("int $50"::);
	store_eflags(eflags);
	printk("iret eflags:%x\n",eflags);
	asm("int $51"::);
	store_eflags(eflags);
	printk("iret eflags:%x\n",eflags);
	asm("int $52"::);
	store_eflags(eflags);
	printk("iret eflags:%x\n",eflags);
	sti();
	store_eflags(eflags);
	printk("Open int eflags:%x\n",eflags);
	asm("int $50"::);
	store_eflags(eflags);
	printk("iret eflags:%x\n",eflags);
	asm("int $51"::);
	store_eflags(eflags);
	printk("iret eflags:%x\n",eflags);
	asm("int $52"::);
	store_eflags(eflags);
	printk("iret eflags:%x\n",eflags);
	for(;;)
		hlt();
}
void int_test_trap(void){
	unsigned int eflags;
	store_eflags(eflags);
	printk("This is int_test_trap!\n");
	printk("eflags:%x ",eflags);
}
void int_test_intr(void){
	unsigned int eflags;
	store_eflags(eflags);
	printk("This is int_test_intr!\n");
	printk("eflags:%x ",eflags);
}
void int_test_system(void){
	unsigned int eflags;
	store_eflags(eflags);
	printk("This is int_test_system!\n");
	printk("eflags:%x ",eflags);
}
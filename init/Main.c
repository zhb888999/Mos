#include<Mos/kernel.h>
void Main(void)
{
	char *p = "Hello,World\n";
	int i = 4;
	printk("Hello,World!%d\n",i);
	printk("Hello,World!%d\n",i);
	for(;;){HLT();}
	return;
}



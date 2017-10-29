#ifndef _IO_H
#define _IO_H
#define HLT() 								\
({  										\
	asm volatile("hlt":::); 				\
})
#define CLI() 								\
({  										\
	asm volatile("cli":::); 				\
})
#define OUTB(value,port) 					\
({											\
	asm volatile("outb %%al,%%dx\n\t" 		\
					: 						\
					:"al"(value),"dx"(port) \
					:						\
				); 							\
})
#define OUTW(value,port) 					\
({											\
	asm volatile("outw %%ax,%%dx\n\t" 		\
					: 						\
					:"ax"(value),"dx"(port) \
					: 						\
				);							\
})
#define OUTL(value,port) 					\
({											\
	asm volatile("outl %%eax,%%dx\n\t" 		\
					: 						\
					:"eax"(value),"dx"(port) \
					: 						\
					);						\
})
#define INB(port) 							\
({  										\
	unsigned char v; 						\
	asm volatile ("inb %%dx,%%al" 			\
					:"=a" (v) 				\
					:"dx" (port) 			\
					: 						\
				); 							\
	v; 										\
})
#define INW(port)						 	\
({ 											\
	unsigned short int v; 					\
	asm volatile ("inw %%dx,%%ax" 			\
					:"=a" (v) 				\
					:"dx" (port) 			\
					: 						\
				); 							\
	v;										\
})
#define INL(port) 							\
({ 											\
unsigned int v; 							\
	asm volatile ("inl %%dx,%%eax" 			\
					:"=a" (v) 				\
					:"dx" (port) 			\
					: 						\
				); 							\
	v; 										\
})
#define STORE_EFLAGS(eflags) 				\
({											\
	asm volatile("pushf\n\t" 				\
				 "pop	%%eax\n\t" 			\
					:"=a" (eflags) 			\
					: 						\
					: 						\
					); 						\
})
#define LOAD_EFLAGS(eflags)					\
({											\
	asm volatile("push	%%eax\n\t" 			\
				 "popf\n\t"					\
				 : 							\
				 :"a"(eflags) 				\
				 : 							\
				 ); 						\
})
#endif
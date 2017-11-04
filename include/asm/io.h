#ifndef _IO_H
#define _IO_H
#define hlt() 								\
({  										\
	asm volatile("hlt":::); 				\
})
#define cli() 								\
({  										\
	asm volatile("cli":::); 				\
})
#define sti() 								\
({  										\
	asm volatile("sti":::); 				\
})
#define outb(value,port) 					\
({											\
	asm volatile("outb %%al,%%dx\n\t" 		\
					: 						\
					:"al"(value),"dx"(port) \
					:						\
				); 							\
})
#define outw(value,port) 					\
({											\
	asm volatile("outw %%ax,%%dx\n\t" 		\
					: 						\
					:"ax"(value),"dx"(port) \
					: 						\
				);							\
})
#define outl(value,port) 					\
({											\
	asm volatile("outl %%eax,%%dx\n\t" 		\
					: 						\
					:"eax"(value),"dx"(port) \
					: 						\
					);						\
})
#define inb(port) 							\
({  										\
	unsigned char v; 						\
	asm volatile ("inb %%dx,%%al" 			\
					:"=a" (v) 				\
					:"dx" (port) 			\
					: 						\
				); 							\
	v; 										\
})
#define inw(port)						 	\
({ 											\
	unsigned short int v; 					\
	asm volatile ("inw %%dx,%%ax" 			\
					:"=a" (v) 				\
					:"dx" (port) 			\
					: 						\
				); 							\
	v;										\
})
#define inl(port) 							\
({ 											\
unsigned int v; 							\
	asm volatile ("inl %%dx,%%eax" 			\
					:"=a" (v) 				\
					:"dx" (port) 			\
					: 						\
				); 							\
	v; 										\
})
#define store_eflags(eflags) 				\
({											\
	asm volatile("pushf\n\t" 				\
				 "pop	%%eax\n\t" 			\
					:"=a" (eflags) 			\
					: 						\
					: 						\
					); 						\
})
#define load_eflags(eflags)					\
({											\
	asm volatile("push	%%eax\n\t" 			\
				 "popf\n\t"					\
				 : 							\
				 :"a"(eflags) 				\
				 : 							\
				 ); 						\
})
#endif
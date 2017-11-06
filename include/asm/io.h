#ifndef _IO_H
#define _IO_H


#define outw(value,port) asm volatile("outw %%ax,%%dx\n\t" ::"ax"(value),"dx"(port))
#define outl(value,port) asm volatile("outl %%eax,%%dx\n\t" ::"eax"(value),"dx"(port))
#define inw(port) \
({	\
	unsigned short int v; \
	asm volatile ("inw %%dx,%%ax" \
					:"=a" (v):"dx" (port) \
					:); \
	v; \
})
#define inl(port) \
({	\
unsigned int v; \
	asm volatile ("inl %%dx,%%eax" \
					:"=a" (v):"dx" (port) \
					:); \
v; \
})
#define outb(value,port) \
__asm__ ("outb %%al,%%dx"::"a" (value),"d" (port))


#define inb(port) ({ \
unsigned char _v; \
__asm__ volatile ("inb %%dx,%%al":"=a" (_v):"d" (port)); \
_v; \
})

#define outb_p(value,port) \
__asm__ ("outb %%al,%%dx\n" \
		"\tjmp 1f\n" \
		"1:\tjmp 1f\n" \
		"1:"::"a" (value),"d" (port))

#define inb_p(port) ({ \
unsigned char _v; \
__asm__ volatile ("inb %%dx,%%al\n" \
	"\tjmp 1f\n" \
	"1:\tjmp 1f\n" \
	"1:":"=a" (_v):"d" (port)); \
_v; \
})

#endif
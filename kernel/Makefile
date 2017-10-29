AR = ar
AS = as
LD = ld
LDFLAGS = -s -x
CC =gcc
CFLAGS	=-Wall -O -fstrength-reduce -fomit-frame-pointer -fno-stack-protector\
	-finline-functions -nostdinc -I../include
CPP	=gcc -E -nostdinc -I../include
.c.s:
	$(CC) $(CFLAGS) \
	-S -o $*.s $<
.s.o:
	$(AS) -c -o $*.o $<
.c.o:
	$(CC) $(CFLAGS) \
	-c -o $*.o $<
OBJS = printk.o vsprintf.o

kernel.o: $(OBJS)
	$(LD) -r -o kernel.o $(OBJS)
	sync
clean:
	rm -f *.o *.a *.s
	(cd chr_drv;make clean)
printk.s printk.o : printk.c ../include/stdarg.h ../include/stddef.h \
  ../include/Mos/kernel.h 
vsprintf.s vsprintf.o : vsprintf.c ../include/stdarg.h ../include/string.h

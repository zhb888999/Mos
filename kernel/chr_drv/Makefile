AR = ar
AS = as
LD = ld
LDFLAGS = -s -x
CC =gcc
CFLAGS	=-Wall -O -fstrength-reduce -fomit-frame-pointer \
	-finline-functions -nostdinc -I../../include
CPP	=gcc -E -nostdinc -I../../include
.c.s:
	$(CC) $(CFLAGS) \
	-S -o $*.s $<
.s.o:
	$(AS) -c -o $*.o $<
.c.o:
	$(CC) $(CFLAGS) \
	-c -o $*.o $<
OBJS = console.o
chr_drv.a: $(OBJS)
	$(AR) rcs chr_drv.a $(OBJS)
	sync

kernel.o: $(OBJS)
	$(LD) -r -o kernel.o $(OBJS)
	sync
clean:
	rm -f *.o *.a *.s
console.s console.o : console.c ../../include/Mos/kernel.h 

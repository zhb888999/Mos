AS = as
LD = ld
CC = gcc
CPP = $(CC) -E
ASFLAGS =
LDFLAGS =-s -x -M -Ttext 0x0 --oformat binary
CPPFLAGS = -nostdinc -Iinclude
CFLAGS = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-stack-protector

ARCHIVES=kernel/kernel.o
DRIVERS =kernel/chr_drv/chr_drv.a

.c.s:
	$(CC) $(CFLAGS) \
	-nostdinc -Iinclude -S -o $*.s $<
.s.o:
	$(AS) -c -o $*.o $<
.c.o:
	$(CC) $(CFLAGS) \
	-nostdinc -Iinclude -c -o $*.o $<
	
all: fd.img

fd.img: boot/boot boot/setup boot/system Makefile
	dd if=/dev/zero of=fd.img bs=512 count=2880
	dd if=boot/boot of=fd.img bs=512 count=1 conv=notrunc
	dd if=boot/setup of=fd.img bs=512 count=3 conv=notrunc seek=1
	dd if=boot/system of=fd.img bs=512 count=1022 conv=notrunc seek=4


boot/boot: boot/boot.S
	$(CPP) $(CPPFLAGS) -o boot/boot.s boot/boot.S
	$(AS) -o boot/boot.o boot/boot.s
	$(LD) $(LDFLAGS) -o boot/boot boot/boot.o
boot/setup: boot/setup.S
	$(CPP) $(CPPFLAGS) -o boot/setup.s boot/setup.S
	$(AS) -o boot/setup.o boot/setup.s
	$(LD) $(LDFLAGS) -o boot/setup boot/setup.o
boot/head.o: boot/head.S
	$(CPP) $(CPPFLAGS) -o boot/head.s boot/head.S
	$(AS) -o boot/head.o boot/head.s
init/Main.o: init/Main.c 
	$(CC) $(CPPFLAGS) $(CFLAGS) -S -o init/Main.s init/Main.c
	$(AS) -o init/Main.o init/Main.s
boot/system: boot/head.o init/Main.o \
				$(ARCHIVES) $(DRIVERS)
	$(LD) $(LDFLAGS)  boot/head.o init/Main.o \
			$(ARCHIVES) $(DRIVERS) \
			-o boot/system >System.map
	
kernel/chr_drv/chr_drv.a:
	(cd kernel/chr_drv; make)
kernel/kernel.o:
	(cd kernel; make)
	
clean:
	cd boot;rm -rf *.s *.o boot setup system
	cd init;rm -rf Main.s Main.o
	(cd kernel;make clean)
	
run:
	bochs -f bochs.src
git:
	git add .
	git commit
	git push origin master

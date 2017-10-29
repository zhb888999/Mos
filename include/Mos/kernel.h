#ifndef _KERNEL_H
#define _KERNEL_H

#include <asm/io.h>
#define BLACK 0x00
#define BLUE 0x01
#define GREEN 0x02
#define CYAN 0x03
#define RED 0x04
#define MAGENTA 0x05
#define BROWN 0x06
#define LIGHT_GREY 0x07
#define DARK_GREY 0x08
#define LIGHT_BLUE 0x09
#define LIGHT_GREEN 0x0a
#define LIGHT_CYAN 0x0b
#define LIGHT_RED 0x0c
#define LIGHT_MAGENTA 0x0d
#define YELLOW 0x0e
#define WHITE 0x0f

extern unsigned int fg_console;
extern unsigned char font_arrt;
void console_print(const char * str);
int printf(const char *fmt, ...);
int printk(const char *fmt, ...);

#endif
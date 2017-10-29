#include <Mos/kernel.h>
unsigned int fg_console = 0;
unsigned char font_arrt = 0x0f;
void console_print(const char * str) {
	int i;
	char *p = (char *)(0xb8000);
	for(i = 0;;i++) {
		if(str[i] == '\n') {
			fg_console = ((fg_console/79)+1)*79 + 1;
			continue;
		}
		if(str[i] == '\t') {
			fg_console = ((fg_console/4)+1)*4 + 1;
			continue;
		}
		if(str[i] == '\0') break;
		p[2*fg_console] = str[i];
		p[2*fg_console+1] = font_arrt;
		fg_console++;
	}
	if(fg_console == 2000) fg_console = 0;
		OUTW(14,0x3d4);
		OUTW(((fg_console+1)>>8)&0xff,0x3d5);
		OUTW(15,0x3d4);
		OUTW((fg_console+1)&0xff,0x3d5);
}

#include <Mos/kernel.h>
unsigned int fg_console = 0;
unsigned char font_arrt = 0x0f;
void consloe_set_cursor(void) {
	OUTW(14,0x3d4);
	OUTW(((fg_console)>>8)&0xff,0x3d5);
	OUTW(15,0x3d4);
	OUTW((fg_console)&0xff,0x3d5);
}
void consloe_clear(void) {
	char *p = (char *)(0xb8000);
	for(int i = 0; i < 2000;i++) {
		p[2*i] = ' ';
		p[2*i+1] = font_arrt;
	}
	fg_console = 0;
	consloe_set_cursor();
}
void console_print(const char * str) {
	int i;
	char *p = (char *)(0xb8000);
	for(i = 0;;i++) {
		if(str[i] == '\n') {
			fg_console = ((fg_console/80)+1)*80;
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
	if(fg_console >= 2000) {
		fg_console = 0;
		consloe_clear();
	}
	consloe_set_cursor();
}

#include <asm/io.h>
void init_palette(void);
void set_palette(int start, int end, unsigned char *rgb);
void init_palette(void)
{
	static unsigned char table_rgb[16*3] = {
		0x00, 0x00, 0x00,	/* 0:黑 */
		0xff, 0x00, 0x00,	/* 1:亮红 */
		0x00, 0xff, 0x00,	/* 2:亮绿 */
		0xff, 0xff, 0x00,	/* 3:亮黄 */
		0x00, 0x00, 0xff,	/* 4:亮蓝 */
		0xff, 0x00, 0xff,	/* 5:亮紫 */
		0x00, 0xff, 0xff,	/* 6:浅亮蓝 */
		0xff, 0xff, 0xff,	/* 7:白 */
		0xc6, 0xc6, 0xc6,	/* 8:亮灰 */
		0x84, 0x00, 0x00,	/* 9:暗红 */
		0x00, 0x84, 0x00,	/* 10:暗绿 */
		0x84, 0x84, 0x00,	/* 11:暗黄 */
		0x00, 0x00, 0x84,	/* 12:暗青 */
		0x84, 0x00, 0x84,	/* 13：暗紫 */
		0x00, 0x84, 0x84,	/* 14:浅暗蓝 */
		0x84, 0x84, 0x84	/* 15:暗灰 */
	};
	set_palette(0, 15, table_rgb);
	return;
}
void set_palette(int start, int end, unsigned char *rgb)
{
	int i,eflags;
	STORE_EFLAGS(eflags);
	CLI();
	OUTB(start, 0x03c8);
	for(i = start; i <= end; i++) {
		OUTB(rgb[0]/4, 0x03c9);
		OUTB(rgb[1]/4, 0x03c9);
		OUTB(rgb[2]/4, 0x03c9);
		rgb += 3;
	}
	LOAD_EFLAGS(eflags);
	return;
}

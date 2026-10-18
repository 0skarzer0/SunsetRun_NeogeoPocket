/* SUNSET RUN - the SCR1 overlay (stone bridges, START/FINISH gantry).
 *
 * The overlay is drawn in RAM (ovl_grid) and sent to the screen in VBlank,
 * together with the road and the sprites of the same frame: only the cells
 * that changed are written, so a moving bridge never shows half-drawn.
 */
#ifndef OVL_H
#define OVL_H
#include "ngpc_types.h"

#define OVL_R0   2u            /* first SCR1 row of the overlay */
#define OVL_ROWS 17u           /* rows 2 .. 18 */
#define OVL_W    20u
extern u16 ovl_grid[OVL_ROWS * OVL_W];
#define OVL_CELL(x, y) ovl_grid[(u16)((u8)((y) - OVL_R0)) * OVL_W + (x)]

void ovl_clear(u8 r0, u8 r1, u8 c0, u8 c1);     /* clear a box (rows r0..r1) */
void ovl_mark(u8 r0, u8 r1, u8 c0, u8 c1);      /* the box has changed */
void ovl_touch(u8 r0, u8 r1, u8 c0, u8 c1);     /* rewrite a box (text went over it) */
void ovl_commit(void);                          /* end of frame: send at VBlank */
void ovl_forget(void);                          /* new screen: the overlay is gone */
void ovl_vblank(void);                          /* from the VBlank interrupt */
#endif

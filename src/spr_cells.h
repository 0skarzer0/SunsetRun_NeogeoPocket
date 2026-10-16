/* SUNSET RUN - sprite cell writer (spr_cells_asm.asm). */
#ifndef SPR_CELLS_H
#define SPR_CELLS_H
#include "ngpc_types.h"
typedef struct {
    const u8  *cells;     /* {cx, cy, ch} triplets */
    const u16 *map;       /* ch -> tile, when hasmap */
    u16 base;             /* tile = base + ch otherwise */
    s16 x;                /* left edge of the cell grid */
    u8  y;                /* top of the cell grid */
    u8  n;                /* cells */
    u8  wm1;              /* grid width - 1 (mirroring) */
    u8  attr;             /* flip | priority bits */
    u8  pal;
    u8  spr;              /* next free sprite, updated */
    u8  end;              /* first sprite not to use */
    u8  flip;             /* mirror the columns */
    u8  hasmap;
    u8  pad;
} SprJob;
typedef char spr_job_is_22[(sizeof(SprJob) == 22u) ? 1 : -1];
extern void spr_cells_asm(SprJob *j);
#endif

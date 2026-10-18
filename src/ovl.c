/* SUNSET RUN - the SCR1 overlay, see ovl.h */
#include "ngpc_hw.h"
#include "ovl.h"

u16 ovl_grid[OVL_ROWS * OVL_W];          /* what the overlay wants */
static u16 ovl_prev[OVL_ROWS * OVL_W];   /* what it last put on screen */

typedef struct {
    u16 *grid;
    u16 *prev;
    volatile u16 *vram;
    u8 rows;
    u8 cols;
} OvlFlush;
typedef char ovl_flush_is_14[(sizeof(OvlFlush) == 14u) ? 1 : -1];
extern void ovl_flush_asm(OvlFlush *f);

static u8 m_r0 = 255u, m_r1, m_c0, m_c1;  /* changed box of the frame being built */
static OvlFlush fl;
static volatile u8 fl_ready;

void ovl_clear(u8 r0, u8 r1, u8 c0, u8 c1)
{
    u8 x, y;
    for (y = r0; y <= r1; y++) {
        u16 *p = &OVL_CELL(c0, y);
        for (x = c0; x <= c1; x++) *p++ = 0u;
    }
}

void ovl_mark(u8 r0, u8 r1, u8 c0, u8 c1)
{
    if (r0 < OVL_R0) r0 = OVL_R0;
    if (r1 > OVL_R0 + OVL_ROWS - 1u) r1 = (u8)(OVL_R0 + OVL_ROWS - 1u);
    if (c1 >= OVL_W) c1 = (u8)(OVL_W - 1u);
    if (r1 < r0 || c1 < c0) return;
    if (m_r0 == 255u) {
        m_r0 = r0; m_r1 = r1; m_c0 = c0; m_c1 = c1;
        return;
    }
    if (r0 < m_r0) m_r0 = r0;
    if (r1 > m_r1) m_r1 = r1;
    if (c0 < m_c0) m_c0 = c0;
    if (c1 > m_c1) m_c1 = c1;
}

/* text was printed over these cells: send them again */
void ovl_touch(u8 r0, u8 r1, u8 c0, u8 c1)
{
    u8 x, y;
    ovl_mark(r0, r1, c0, c1);
    if (r0 < OVL_R0) r0 = OVL_R0;
    if (r1 > OVL_R0 + OVL_ROWS - 1u) r1 = (u8)(OVL_R0 + OVL_ROWS - 1u);
    if (c1 >= OVL_W) c1 = (u8)(OVL_W - 1u);
    for (y = r0; y <= r1 && r1 >= r0; y++) {
        u16 *p = &ovl_prev[(u16)(y - OVL_R0) * OVL_W + c0];
        for (x = c0; x <= c1; x++) *p++ = 0xFFFFu;
    }
}

void ovl_commit(void)
{
    u16 o;
    if (m_r0 == 255u) return;
    o = (u16)((u16)(m_r0 - OVL_R0) * OVL_W + m_c0);
    fl.grid = &ovl_grid[o];
    fl.prev = &ovl_prev[o];
    fl.vram = &HW_SCR1_MAP[(u16)m_r0 * 32u + m_c0];
    fl.rows = (u8)(m_r1 - m_r0 + 1u);
    fl.cols = (u8)(m_c1 - m_c0 + 1u);
    m_r0 = 255u;
    fl_ready = 1u;
}

void ovl_vblank(void)
{
    if (fl_ready) {
        ovl_flush_asm(&fl);
        fl_ready = 0u;
    }
}

void ovl_forget(void)
{
    u16 i;
    fl_ready = 0u;
    m_r0 = 255u;
    for (i = 0u; i < OVL_ROWS * OVL_W; i++) {
        if (ovl_prev[i]) {
            HW_SCR1_MAP[(u16)(i / OVL_W + OVL_R0) * 32u + (i % OVL_W)] = 0u;
        }
        ovl_prev[i] = 0u;
        ovl_grid[i] = 0u;
    }
}

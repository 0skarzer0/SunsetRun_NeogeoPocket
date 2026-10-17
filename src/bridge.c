/* SUNSET RUN - old stone bridges over the road.
 *
 * Some scenes (gfx_themes[].bridges) have a row of up to four stone bridges
 * on their longest gentle stretch.  Like the START gantry they are drawn with
 * SCR1 characters (6 stone characters in unused font slots), placed with the
 * road's own perspective: a deck spanning the road and the verges, and two
 * pillars down to the ground.  Bridges are drawn far to near, so the nearer
 * one covers the farther ones.  Sprites beyond the nearest bridge are put
 * behind SCR1 (see bridge_line), and the pillars can be hit.
 */
#include "ngpc_hw.h"
#include "ngpc_gfx.h"
#include "game.h"
#include "id_road.h"
#include "id_player.h"
#include "../GraphX/gfx_extra.h"

#define T_CAP   64u          /* '@' */
#define T_DECK  91u          /* '[' */
#define T_DBOT  92u          /* '\' */
#define T_PIL   93u          /* ']' */
#define T_PILL  94u          /* '^' */
#define T_PILR  95u          /* '_' */
/* slender tiles for distant bridges (font slots no text uses) */
#define T_DTHIN 34u          /* '"' : 3 px deck */
#define T_DMED  39u          /* ''' : 5 px deck */
#define T_PTL   59u          /* ';' : 3 px pillar, left side of the road */
#define T_PTR   61u          /* '=' : 3 px pillar, right side */
#define T_PML   62u          /* '>' : 5 px pillar, left */
#define T_PMR   63u          /* '?' : 5 px pillar, right */
#define PAL_BRIDGE 11u       /* SCR1 */
#define BR_MAX  12u          /* a whole run of bridges; ~5 are on screen at once */
#define BR_GAP   260u        /* course units between bridges of a row */
#define BR_FAR   1450
#define FIRST_ROW 2u

static u16 br_at[BR_MAX];
static u8 br_n;
static u16 car_d;
u8 bridge_line;              /* foot line of the nearest bridge on screen, 0 = none */

/* last drawing: bounding box of the cells written, and its signature */
static u8 bb_r0 = 255u, bb_r1, bb_c0, bb_c1;
static u16 sig_prev = 0xFFFFu;

void bridge_init(void)
{
    u8 i;
    volatile u16 *d = (volatile u16 *)(0xA000u + (u32)T_CAP * 16u);
    for (i = 0u; i < 8u; i++) d[i] = gfx_bridge_tiles[i];
    d = (volatile u16 *)(0xA000u + (u32)T_DECK * 16u);
    for (i = 0u; i < 40u; i++) d[i] = gfx_bridge_tiles[8u + i];
    {
        static const u8 slim[6] = { T_DTHIN, T_DMED, T_PTL, T_PTR, T_PML, T_PMR };
        u8 k;
        for (k = 0u; k < 6u; k++) {
            d = (volatile u16 *)(0xA000u + (u32)slim[k] * 16u);
            for (i = 0u; i < 8u; i++) d[i] = gfx_bridge_tiles[(u16)(6u + k) * 8u + i];
        }
    }
    car_d = id_road_distance_at_line(ID_CAR_WHEEL);
}

static void clear_box(void)
{
    u8 x, y;
    if (bb_r0 == 255u) {
        return;
    }
    for (y = bb_r0; y <= bb_r1; y++) {
        volatile u16 *p = &HW_SCR1_MAP[(u16)y * 32u + bb_c0];
        for (x = bb_c0; x <= bb_c1; x++) *p++ = 0u;
    }
    bb_r0 = 255u;
}

void bridge_hide(void)
{
    clear_box();
    sig_prev = 0xFFFFu;
    bridge_line = 0u;
}

/* the bridge run of the leg (gen_course.py BRIDGE_RUN: straight, down, up,
 * curve) gets a row of bridges along its whole length */
void bridge_setup(void)
{
    u16 pos = 0u, run0 = 0u, len = 0u;
    u8 i, found = 0u;
    bridge_hide();
    ngpc_gfx_set_palette(GFX_SCR1, PAL_BRIDGE, 0u, 0x0322u, 0x0778u, 0x0BCCu);
    br_n = 0u;
    if (!gfx_themes[leg_theme[cur_leg]].bridges) {
        return;
    }
    for (i = 0u; i < track_len && pos < leg_len; i++) {
        const Segment *s = &track_seg[i];
        if (!found && s->span == (u16)LEG_BRIDGE_MARK) {
            u8 k;
            found = 1u;
            run0 = pos;
            for (k = 0u; k < LEG_BRIDGE_N && (u8)(i + k) < track_len; k++) {
                len = (u16)(len + track_seg[(u8)(i + k)].span);
            }
        }
        pos = (u16)(pos + s->span);
    }
    if (!found) {
        return;
    }
    for (pos = (u16)(run0 + 150u); pos + 100u < run0 + len && br_n < BR_MAX; pos = (u16)(pos + BR_GAP)) {
        br_at[br_n++] = pos;
    }
}

/* half width of the opening and of the pillars at road half width h */
#define OPEN(h)   ((s16)(h) + (s16)((h) / 6u) + 3)
#define PILLAR(h) ((s16)((h) / 3u))     /* also the deck thickness: grows with the size */

static u8 clamp_col(s16 x)
{
    if (x < 0) return 0u;
    if (x > 159) return 19u;
    return (u8)(x >> 3);
}

void bridge_draw(u16 course_pos)
{
    s8 i;
    u16 sig = 0u;
    u8 n = 0u;
    u8 r0s[BR_MAX], r1s[BR_MAX], fts[BR_MAX], l0s[BR_MAX], l1s[BR_MAX], q0s[BR_MAX], q1s[BR_MAX];
    u8 lv[BR_MAX], rv[BR_MAX], slim[BR_MAX];    /* 0 full stone, 1 = 5 px, 2 = 3 px */
    bridge_line = 0u;
    if (br_n == 0u) {
        return;
    }
    /* geometry of every bridge on screen, nearest first */
    for (i = 0; i < (s8)br_n; i++) {
        s16 d = (s16)(br_at[(u8)i] - course_pos);
        IdRoadSpriteSample g;
        u8 line;
        s16 h, w, p, top, bot, foot;
        if (d <= 0 || d > BR_FAR) {
            continue;
        }
        line = id_road_line_at_distance((u16)((u16)d + car_d));
        if (line == 255u) {
            continue;
        }
        id_road_sprite_sample(line, &g);
        h = (s16)g.half;
        w = OPEN(g.half);
        p = PILLAR(g.half);
        foot = g.foot;
        if (foot > 151) foot = 151;
        bot = (s16)(foot - h - (h >> 3));
        top = (s16)(bot - p);
        if (bot < (s16)(FIRST_ROW * 8u + 4u)) {
            continue;                  /* the deck has gone over the top */
        }
        if (bridge_line == 0u) {
            bridge_line = (u8)foot;
        }
        slim[n] = (u8)((p < 4) ? 2u : ((p < 8) ? 1u : 0u));
        if (slim[n]) {
            /* far away: one character row for the deck, one column per pillar */
            r1s[n] = (u8)((bot - 1) >> 3);
            r0s[n] = r1s[n];
            if (r1s[n] < FIRST_ROW) continue;
        } else {
            r0s[n] = (u8)((top < (s16)(FIRST_ROW * 8u)) ? FIRST_ROW : (u8)(top >> 3));
            r1s[n] = (u8)((bot - 1) >> 3);
            if (r1s[n] < r0s[n]) r1s[n] = r0s[n];
        }
        fts[n] = (u8)(foot >> 3);
        if (fts[n] > 18u) fts[n] = 18u;
        lv[n] = (u8)(g.centre - w - 1 >= 0);
        rv[n] = (u8)(g.centre + w <= 159);
        l1s[n] = clamp_col((s16)(g.centre - w - 1));
        q0s[n] = clamp_col((s16)(g.centre + w));
        l0s[n] = slim[n] ? l1s[n] : clamp_col((s16)(g.centre - w - p));
        q1s[n] = slim[n] ? q0s[n] : clamp_col((s16)(g.centre + w + p));
        sig = (u16)((sig * 31u) + r0s[n] + ((u16)r1s[n] << 5) + ((u16)l0s[n] << 9) + ((u16)q1s[n] << 3)
                    + fts[n] + l1s[n] + q0s[n] + ((u16)slim[n] << 12));
        n++;
    }
    if (n == 0u) {
        if (bb_r0 != 255u) bridge_hide();
        return;
    }
    sig = (u16)(sig + n);
    if (sig == sig_prev) {
        return;                        /* nothing moved by a whole character */
    }
    sig_prev = sig;
    clear_box();
    /* draw far to near */
    while (n > 0u) {
        u8 k = (u8)(n - 1u), x, y;
        n--;
        if (slim[k]) {
            /* a slender far bridge: thin deck, thin pillars on the road side */
            u16 td = (slim[k] == 2u) ? T_DTHIN : T_DMED;
            u16 tl = (slim[k] == 2u) ? T_PTL : T_PML;
            u16 tr = (slim[k] == 2u) ? T_PTR : T_PMR;
            volatile u16 *p = &HW_SCR1_MAP[(u16)r0s[k] * 32u + l0s[k]];
            for (x = l0s[k]; x <= q1s[k]; x++) *p++ = (u16)(td | ((u16)PAL_BRIDGE << 9));
            for (y = (u8)(r0s[k] + 1u); y <= fts[k]; y++) {
                if (lv[k]) HW_SCR1_MAP[(u16)y * 32u + l0s[k]] = (u16)(tl | ((u16)PAL_BRIDGE << 9));
                if (rv[k]) HW_SCR1_MAP[(u16)y * 32u + q1s[k]] = (u16)(tr | ((u16)PAL_BRIDGE << 9));
            }
        } else {
        for (y = r0s[k]; y <= r1s[k]; y++) {
            u16 t = (y == r1s[k] && r1s[k] > r0s[k]) ? T_DBOT : ((y == r0s[k]) ? T_CAP : T_DECK);
            volatile u16 *p = &HW_SCR1_MAP[(u16)y * 32u + l0s[k]];
            if (r1s[k] == r0s[k]) t = T_DBOT;
            for (x = l0s[k]; x <= q1s[k]; x++) *p++ = (u16)(t | ((u16)PAL_BRIDGE << 9));
        }
        for (y = (u8)(r1s[k] + 1u); y <= fts[k]; y++) {
            if (lv[k]) {
                for (x = l0s[k]; x <= l1s[k]; x++) {
                    u16 t = (x == l1s[k]) ? T_PILR : ((x == l0s[k] && l1s[k] > l0s[k]) ? T_PILL : T_PIL);
                    HW_SCR1_MAP[(u16)y * 32u + x] = (u16)(t | ((u16)PAL_BRIDGE << 9));
                }
            }
            if (rv[k]) {
                for (x = q0s[k]; x <= q1s[k]; x++) {
                    u16 t = (x == q0s[k]) ? T_PILL : ((x == q1s[k] && q1s[k] > q0s[k]) ? T_PILR : T_PIL);
                    HW_SCR1_MAP[(u16)y * 32u + x] = (u16)(t | ((u16)PAL_BRIDGE << 9));
                }
            }
        }
        }
        if (bb_r0 == 255u) {
            bb_r0 = r0s[k]; bb_r1 = fts[k]; bb_c0 = l0s[k]; bb_c1 = q1s[k];
        } else {
            if (r0s[k] < bb_r0) bb_r0 = r0s[k];
            if (fts[k] > bb_r1) bb_r1 = fts[k];
            if (l0s[k] < bb_c0) bb_c0 = l0s[k];
            if (q1s[k] > bb_c1) bb_c1 = q1s[k];
        }
    }
}

/* 1 if the car, crossing under a bridge between prev and pos, meets a pillar */
u8 bridge_hit(u16 prev, u16 pos, s16 lat_px)
{
    u8 i;
    u8 half = id_road_half_at(ID_CAR_WHEEL);
    s16 w = OPEN(half);
    if (lat_px < 0) lat_px = (s16)-lat_px;
    for (i = 0u; i < br_n; i++) {
        if (prev < br_at[i] && pos >= br_at[i] && lat_px + 14 > w) {
            return 1u;
        }
    }
    return 0u;
}

/* SUNSET RUN roadside scenery: the OVER REV projection and phase ladder,
 * drawing the current leg's object kinds (or fork signs / checkpoint flags). */

#include "ngpc_hw.h"
#include "ngpc_sys.h"
#include "ngpc_gfx.h"
#include "id_scenery.h"
#include "id_road.h"
#include "id_player.h"
#include "game.h"
#include "spr_cells.h"
#include "../GraphX/gfx_sprites.h"
#define SCN_COUNT       6u
#define SCN_GAP        43u      /* 256 / SCN_COUNT, rounded */
#define SCN_RATE      158u      /* per 1/2048 phase unit: 316/4096, i.e. 230 x WORLD_SPEED */
#define SCN_OFF_MIN     2u
#define SCN_MARGIN(half)  (u8)(1u + (u8)((half) / 9u))   /* just past the rumble strip */
#define CAR_HALF_HIT    12

static u8  scn_phase;
static u16 scn_frac;
static u8  scn_passed;
static u8  scn_mode;

u16 id_scenery_char_count(void)
{
    return 0u;
}

void id_scenery_init(u16 tile_base, u8 course)
{
    (void)tile_base;
    (void)course;
    scn_phase = 0u;
    scn_frac = 0u;
    scn_passed = 0u;
    scn_mode = SCN_MODE_NORMAL;
    id_spr_hide_range((u8)SPR_SCN_0, (u8)SPR_SCN_END);
}

void scenery_mode(u8 mode)
{
    scn_mode = mode;
}

u8 id_scenery_passed(void)
{
    return scn_passed;
}

static u8 kind_of(u8 right)
{
    if (scn_mode == SCN_MODE_CROWD) return OBJ_CROWD;
    if (scn_mode == SCN_MODE_FORK) return OBJ_FORK;
    if (scn_mode >= SCN_MODE_CURVE_L) return OBJ_ARROW;
    if (scn_mode == SCN_MODE_FLAGS) return OBJ_FLAG;
    return right ? theme_obj_kind_right() : theme_obj_kind_left();
}

/* SUNSET RUN: did an object that passed the car this tick touch it?
 * lat = car centre in px from the road centre at the wheel line. */
u8 id_scenery_hit(s16 lat, u8 wheel_line)
{
    u8 side;
    s16 half = (s16)id_road_half_at(wheel_line);
    s16 bord = (s16)(half + (s16)SCN_MARGIN((u8)half));
    for (side = 0u; side < 2u; side++) {
        const SprFrame *f;
        s16 w, lo, hi;
        if (!(scn_passed & (u8)(1u << side))) {
            continue;
        }
        f = &gfx_obj_frames[(u8)(kind_of(side) * GFX_RUNGS)];
        w = (s16)f->px_w;
        lo = (s16)(bord + (w >> 2));          /* solid core: middle half */
        hi = (s16)(bord + w - (w >> 2));
        if (side == 0u) {
            /* left object, mirrored */
            if (-lat + CAR_HALF_HIT >= lo && -lat - CAR_HALF_HIT <= hi) return 1u;
        } else {
            if (lat + CAR_HALF_HIT >= lo && lat - CAR_HALF_HIT <= hi) return 1u;
        }
    }
    return 0u;
}

static u8 obj_phase(u8 n)
{
    return (u8)(scn_phase + (u8)(n * SCN_GAP));
}

void id_scenery_advance(u8 speed)
{
    u16 step;
    step = (u16)((u16)scn_frac + (u16)speed * (u16)SCN_RATE);
    scn_frac = (u16)(step & 2047u);
    step >>= 11;
    {
        u8 avant = scn_phase;
        u8 k;
        scn_phase = (u8)(scn_phase + (u8)step);
        scn_passed = 0u;
        for (k = 0u; k < SCN_COUNT; k++) {
            u8 o = (u8)(k * SCN_GAP);
            if ((u8)(scn_phase + o) < (u8)(avant + o)) {
                scn_passed |= (u8)(((k & 1u) != 0u) ? 2u : 1u);
            }
        }
    }
}

void id_scenery_frame(u8 speed)
{
    id_scenery_advance(speed);
    id_scenery_draw();
}

void id_scenery_draw(void)
{
    u8 i, n0;
    u8 spr = SPR_SCN_0;
    u8 scn_end = (u8)(banner_active() ? SPR_BANNER_0 : SPR_SCN_END);
    u8 r_top = id_road_top();
    s16 r_bottom = (s16)id_road_bottom();
    s16 haut = (s16)id_road_visible_top();
    u16 off_near = (u16)(r_bottom - (s16)r_top);
    /* the nearest object has the largest phase; walk from it downwards */
    n0 = 0u;
    for (i = 1u; i < SCN_COUNT; i++) {
        if (obj_phase(i) > obj_phase(n0)) {
            n0 = i;
        }
    }
    for (i = 0u; i < SCN_COUNT; i++) {
        u8 j = (u8)((n0 + SCN_COUNT - i) % SCN_COUNT);
        u8 ph = obj_phase(j);
        u8 right, kind, pal, rung, line, draw, flip;
        u16 q, off;
        s16 x;
        IdRoadSpriteSample geometry;
        const SprFrame *f;
        q = (u16)(((u16)ph * (u16)ph) >> 8);
        off = (u16)(SCN_OFF_MIN + (u16)((q * (u16)(off_near - SCN_OFF_MIN)) >> 8));
        if (off > off_near) {
            off = off_near;
        }
        line = (u8)(r_top + off);
        if (off < 6u) {
            rung = 4u;
        } else if (off < 10u) {
            rung = 3u;
        } else if (off < 15u) {
            rung = 2u;
        } else if (off < 22u) {
            rung = 1u;
        } else {
            rung = 0u;
        }
        right = (u8)((j & 1u) != 0u);
        if (scn_mode == SCN_MODE_CROWD) {
            kind = OBJ_CROWD;
            pal = PAL_CROWD;
        } else if (scn_mode == SCN_MODE_FORK) {
            kind = OBJ_FORK;
            pal = PAL_OBJ_FORK;
        } else if (scn_mode >= SCN_MODE_CURVE_L) {
            kind = OBJ_ARROW;
            pal = PAL_OBJ_SIGN;
        } else if (scn_mode == SCN_MODE_FLAGS) {
            kind = OBJ_FLAG;
            pal = PAL_OBJ_FLAG;
        } else if (right) {
            kind = theme_obj_kind_right();
            pal = PAL_OBJ_R;
        } else {
            kind = theme_obj_kind_left();
            pal = PAL_OBJ_L;
        }
        /* signs and flags face the road: the right-hand one is mirrored */
        flip = (u8)((right && kind >= OBJ_ARROW) ? 1u : 0u);
        if (scn_mode == SCN_MODE_CROWD) {
            flip = (u8)(((g_vb_counter >> 3) + j) & 1u);   /* waving */
        } else if (scn_mode == SCN_MODE_CURVE_L) {
            flip = 0u;          /* arrow art points left */
        } else if (scn_mode == SCN_MODE_CURVE_R) {
            flip = 1u;
        }
        f = &gfx_obj_frames[(u8)(kind * GFX_RUNGS + rung)];
        {
            s16 sh;
            id_road_sprite_sample(line, &geometry);
            sh = geometry.foot;
            if (sh < haut) {
                continue;
            }
            if (sh > r_bottom) {
                sh = r_bottom;
            }
            draw = (u8)sh;
        }
        {
            u8 half = geometry.half;
            s16 centre = geometry.centre;
            s16 bord = (s16)half + (s16)SCN_MARGIN(half);
            if (right) {
                x = (s16)(centre + bord);
            } else {
                x = (s16)(centre - bord - (s16)f->px_w + 1);
            }
        }
        if (x < -32 || x > 168) {
            continue;
        }
        {
            SprJob jb;
            jb.cells = (const u8 *)&gfx_obj_cells[f->first];
            jb.map = theme_obj_map();
            jb.base = 0u;
            jb.x = x;
            jb.y = (u8)((u16)draw + 1u - (u16)f->h * 8u);
            jb.n = f->n;
            jb.wm1 = (u8)(f->w - 1u);
            jb.attr = (u8)((flip ? SPR_HFLIP : 0u) | id_spr_priority);
            jb.pal = pal;
            jb.spr = spr;
            jb.end = scn_end;
            jb.flip = flip;
            jb.hasmap = 1u;
            spr_cells_asm(&jb);
            spr = jb.spr;
        }
    }
    id_spr_hide_range(spr, scn_end);
}

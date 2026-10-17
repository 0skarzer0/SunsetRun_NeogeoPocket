/* SUNSET RUN - per-leg look: panorama, road colours, roadside objects. */
#include "ngpc_hw.h"
#include "ngpc_gfx.h"
#include "game.h"
#include "id_road.h"
#include "../GraphX/gfx_pano.h"
#include "../GraphX/gfx_sprites.h"

static u16 pano_base, obj_base, obj_end;
static u16 pano_end;          /* first character after the current panorama */
static u16 objmap[256];
static u8 kind_l, kind_r;
#define PANO_PALS 13u
static u16 cur_pals[PANO_PALS * 4u];  /* SCR2 palettes 8..15 and 2..6 as loaded */
/* the road only uses SCR2 palettes 0-1 and the HUD 7: the panorama gets the rest */
static const u8 pano_slot[PANO_PALS] = { 8u, 9u, 10u, 11u, 12u, 13u, 14u, 15u, 2u, 3u, 4u, 5u, 6u };
static u16 cur_backdrop;
static u16 cur_road[4];
static u16 cur_band[4];
static u16 cur_spr[6][4];         /* object sprite palettes L R SIGN FLAG FORK CROWD */

void theme_init_tiles(u16 pb, u16 ob, u16 oe)
{
    pano_base = pb;
    obj_base = ob;
    obj_end = oe;
}

const u16 *theme_obj_map(void)
{
    return objmap;
}

u16 theme_obj_tile(u8 pool_tile)
{
    return objmap[pool_tile];
}

u8 theme_obj_kind_left(void) { return kind_l; }
u8 theme_obj_kind_right(void) { return kind_r; }

static void load_tile(u16 slot, const u16 *src)
{
    volatile u16 *dst = (volatile u16 *)(0xA000u + (u32)slot * 16u);
    u8 w;
    for (w = 0u; w < 8u; w++) {
        dst[w] = src[w];
    }
}

static u16 next_slot;
/* character pools for the roadside objects, in order: 2..31, 101..127, the
 * free tail after the sprites (obj_base..obj_end), then whatever the current
 * panorama leaves unused of its reserved block */
static u16 alloc_slot(void)
{
    u16 s = next_slot;
    u16 pano_max = (u16)(pano_base + GFX_PANO_MAX_TILES);
    if (s >= TILE_OBJ_LOW_END && s < TILE_OBJ_LOW2) {
        s = TILE_OBJ_LOW2;
    } else if (s >= TILE_OBJ_LOW2_END && s < pano_base) {
        s = obj_base;
    }
    if (s >= obj_end) {
        s = pano_end;
    }
    if (s >= pano_max && s < obj_base) {
        return 0u;              /* out of characters: blank */
    }
    next_slot = (u16)(s + 1u);
    return s;
}

static void load_kind(u8 kind)
{
    u8 r;
    for (r = 0u; r < GFX_RUNGS; r++) {
        const SprFrame *f = &gfx_obj_frames[(u8)(kind * GFX_RUNGS + r)];
        u8 i;
        for (i = 0u; i < f->n; i++) {
            u8 t = gfx_obj_cells[(u16)(f->first + i)].ch;
            if (objmap[t] == 0xFFFFu) {
                u16 s = alloc_slot();
                objmap[t] = s;
                if (s != 0u) {
                    load_tile(s, &gfx_obj_tiles[(u16)t * 8u]);
                }
            }
        }
    }
}

static void set_spr_pal(u8 pal, u8 kind, u8 slot)
{
    const u16 *p = &gfx_obj_pals[(u16)kind * 4u];
    u8 i;
    for (i = 0u; i < 4u; i++) {
        cur_spr[slot][i] = p[i];
    }
    ngpc_gfx_set_palette((u8)GFX_SPR, pal, p[0], p[1], p[2], p[3]);
}

void theme_apply(u8 leg)
{
    const ThemeInfo *L = &gfx_themes[leg_theme[leg]];
    const PanoArt *P = &gfx_pano[L->pano];
    u16 i;
    u8 x, y;
    /* panorama characters, palettes, map rows 0..10 */
    for (i = 0u; i < P->count; i++) {
        load_tile((u16)(pano_base + i), &P->tiles[i * 8u]);
    }
    for (i = 0u; i < PANO_PALS * 4u; i++) {
        cur_pals[i] = P->pals[i];
    }
    for (y = 0u; y < GFX_PANO_ROWS; y++) {
        for (x = 0u; x < 32u; x++) {
            u16 k = (u16)((u16)y * 32u + x);
            HW_SCR2_MAP[k] = (u16)(pano_base + P->map[k] + ((u16)pano_slot[P->map_pal[k]] << 9));
        }
    }
    pano_end = (u16)(pano_base + P->count);
    cur_backdrop = P->backdrop;
    cur_road[0] = P->backdrop;
    cur_road[1] = L->asphalt;
    cur_road[2] = L->band[0];
    cur_road[3] = L->line;
    for (i = 0u; i < 4u; i++) {
        cur_band[i] = L->band[i];
    }
    /* roadside objects */
    for (i = 0u; i < 256u; i++) {
        objmap[i] = 0xFFFFu;
    }
    next_slot = TILE_OBJ_LOW;
    kind_l = L->obj_left;
    kind_r = L->obj_right;
    load_kind(kind_l);
    if (kind_r != kind_l) {
        load_kind(kind_r);
    }
    load_kind(OBJ_ARROW);
    if (leg < LEG_ID(GFX_STAGES - 1u, 0u)) {
        load_kind(OBJ_FORK);              /* the last stage has no fork */
    }
    load_kind(OBJ_FLAG);
    if (leg == 0u || leg >= LEG_ID(GFX_STAGES - 1u, 0u)) {
        load_kind(OBJ_CROWD);             /* fans at the start and the finish */
    }
    for (i = 0u; i < 256u; i++) {
        if (objmap[i] == 0xFFFFu) {
            objmap[i] = 0u;
        }
    }
    set_spr_pal(PAL_OBJ_L, kind_l, 0u);
    set_spr_pal(PAL_OBJ_R, kind_r, 1u);
    set_spr_pal(PAL_OBJ_SIGN, OBJ_ARROW, 2u);
    set_spr_pal(PAL_OBJ_FLAG, OBJ_FLAG, 3u);
    set_spr_pal(PAL_OBJ_FORK, OBJ_FORK, 4u);
    set_spr_pal(PAL_CROWD, OBJ_CROWD, 5u);
    theme_flash(0u);
}

static u16 to_white(u16 c, u8 level)
{
    u16 r = (u16)(c & 15u), g = (u16)((c >> 4) & 15u), b = (u16)((c >> 8) & 15u);
    if (level >= 4u) {
        return 0x0FFFu;
    }
    r = (u16)(r + (((15u - r) * level) >> 2));
    g = (u16)(g + (((15u - g) * level) >> 2));
    b = (u16)(b + (((15u - b) * level) >> 2));
    return (u16)(r | (g << 4) | (b << 8));
}

void theme_flash(u8 level)
{
    u8 p, i;
    u16 band[4];
    for (p = 0u; p < PANO_PALS; p++) {
        ngpc_gfx_set_palette(GFX_SCR2, pano_slot[p],
                             to_white(cur_pals[p * 4u], level), to_white(cur_pals[p * 4u + 1u], level),
                             to_white(cur_pals[p * 4u + 2u], level), to_white(cur_pals[p * 4u + 3u], level));
    }
    for (i = 0u; i < 4u; i++) {
        band[i] = to_white(cur_band[i], level);
    }
    id_road_set_colors(to_white(cur_backdrop, level), to_white(cur_road[1], level),
                       to_white(cur_road[3], level), band);
}

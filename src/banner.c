/* SUNSET RUN - START / FINISH gantry over the road.
 *
 * The gantry is drawn with SCR1 characters (a coloured band and two posts,
 * rebuilt whenever its size or position changes) and the word on it with
 * sprites using the font characters, so it costs only 5 new characters.
 * It is placed with the road's own perspective (the same look-ahead table as
 * the traffic) and grows and rises as the car approaches, disappearing over
 * the top of the screen when the car drives under it.
 */
#include "ngpc_hw.h"
#include "ngpc_gfx.h"
#include "game.h"
#include "id_road.h"
#include "id_player.h"
#include "ovl.h"
#include "../GraphX/gfx_extra.h"

#define T_TOP   (u16)'#'          /* font slots that no text uses */
#define T_MID   (u16)'$'
#define T_BOT   (u16)'%'
#define T_POST  (u16)'&'
#define T_CHECK (u16)'*'
#define PAL_BANNER   10u          /* SCR1 palette */
#define FIRST_ROW     2u          /* rows 0-1 belong to the HUD */

static u8 b_on, b_r0, b_r1, b_c0, b_c1, b_foot, b_spr;
static u16 car_d;

void banner_init(void)
{
    u8 i;
    volatile u16 *dst = (volatile u16 *)(0xA000u + (u32)T_TOP * 16u);
    for (i = 0u; i < (u8)(GFX_BANNER_TILES * 8u); i++) {
        dst[i] = gfx_banner_tiles[i];
    }
    banner_style(DIFF_HARD);
    car_d = id_road_distance_at_line(ID_CAR_WHEEL);
    b_on = 0u;
}

/* the gantry wears the colours of the difficulty:
 * EASY green / white letters, NORMAL white / red letters,
 * HARD red / white letters, FREE blue / white letters */
static const u16 b_edge[DIFF_COUNT] = { 0x0131u, 0x0444u, 0x0112u, 0x0410u };
static const u16 b_band[DIFF_COUNT] = { 0x03B3u, 0x0FFFu, 0x022Du, 0x0E52u };
static const u16 b_text[DIFF_COUNT] = { 0x0FFFu, 0x022Eu, 0x0FFFu, 0x0FFFu };
static const u16 b_shad[DIFF_COUNT] = { 0x0000u, 0x0006u, 0x0000u, 0x0000u };

void banner_style(u8 diff)
{
    if (diff >= DIFF_COUNT) diff = DIFF_EASY;
    ngpc_gfx_set_palette(GFX_SCR1, PAL_BANNER, 0u, b_edge[diff], b_band[diff], 0x0FFFu);
    ngpc_gfx_set_palette(GFX_SPR, PAL_LETTERS, 0u, b_shad[diff], 0x0AAAu, b_text[diff]);
}

static void erase(void)
{
    u8 x, y;
    if (!b_on) {
        return;
    }
    for (y = b_r0; y <= b_foot; y++) {
        for (x = b_c0; x <= b_c1; x++) {
            OVL_CELL(x, y) = 0u;
        }
    }
    ovl_mark(b_r0, b_foot, b_c0, b_c1);
    b_on = 0u;
}

void banner_hide(void)
{
    erase();
    if (b_spr) {                     /* the scenery owns these sprites otherwise */
        id_spr_hide_range((u8)SPR_BANNER_0, (u8)(SPR_BANNER_0 + 6u));
        b_spr = 0u;
    }
}

/* force a full redraw (after text was printed over the gantry) */
void banner_dirty(void)
{
    if (b_on) ovl_touch(b_r0, b_foot, b_c0, b_c1);
    b_r0 = 255u;
}

u8 banner_active(void)
{
    return b_on;
}

/* d: distance from the car to the line (course units); finish: chequered
 * trims; text: up to 6 letters */
void banner_show(s16 d, u8 finish, const char *text)
{
    IdRoadSpriteSample g;
    u8 line, r0, r1, c0, c1, foot, x, y, n, k;
    s16 top, bot, left, right, h;
    if (d < 0 || d > 1400) {
        banner_hide();
        return;
    }
    line = id_road_line_at_distance((u16)((u16)d + car_d));
    if (line == 255u) {
        banner_hide();
        return;
    }
    id_road_sprite_sample(line, &g);
    h = (s16)g.half;
    bot = (s16)(g.foot - h - (h >> 2));          /* gantry height ~ the road half width */
    top = (s16)(bot - 8 - (h >> 2));             /* band: one character, thicker when near */
    if (top < (s16)(FIRST_ROW * 8u) || bot > 151) {
        banner_hide();
        return;
    }
    left = (s16)(g.centre - h - 4);
    right = (s16)(g.centre + h + 4);
    r0 = (u8)(top >> 3);
    r1 = (u8)(bot >> 3);
    if (r1 < r0) r1 = r0;
    foot = (u8)(g.foot >> 3);
    if (foot > 18u) foot = 18u;
    c0 = (u8)((left < 0) ? 0 : ((left >> 3) > 19 ? 19 : (left >> 3)));
    c1 = (u8)((right < 0) ? 0 : ((right >> 3) > 19 ? 19 : (right >> 3)));
    if (!b_on || r0 != b_r0 || r1 != b_r1 || c0 != b_c0 || c1 != b_c1 || foot != b_foot) {
        erase();
        for (y = r0; y <= r1; y++) {
            for (x = c0; x <= c1; x++) {
                u16 t = T_MID;
                if (finish && (x == c0 || x == c1)) t = T_CHECK;
                else if (y == r0 && r1 > r0) t = T_TOP;
                else if (y == r1 && r1 > r0) t = T_BOT;
                OVL_CELL(x, y) = (u16)(t | ((u16)PAL_BANNER << 9));
            }
        }
        for (y = (u8)(r1 + 1u); y <= foot; y++) {
            if (left >= 0) OVL_CELL(c0, y) = (u16)(T_POST | ((u16)PAL_BANNER << 9));
            if (right < 160) OVL_CELL(c1, y) = (u16)(T_POST | ((u16)PAL_BANNER << 9));
        }
        ovl_mark(r0, foot, c0, c1);
        b_on = 1u;
        b_r0 = r0; b_r1 = r1; b_c0 = c0; b_c1 = c1; b_foot = foot;
    }
    /* the word, as sprites with the font characters, spread with the size */
    n = 0u;
    while (text[n] != 0 && n < 6u) n++;
    if ((s16)(2 * h + 8) < (s16)(n * 8u)) {
        n = 0u;                       /* too far away for the letters to fit */
    }
    {
        s16 step = (s16)(8 + (h >> 4));
        s16 x0 = (s16)(g.centre - (step * (s16)n) / 2 + (step - 8) / 2);
        u8 yy = (u8)((((u16)r0 + (u16)r1) * 8u + 8u) / 2u - 4u);
        for (k = 0u; k < n; k++) {
            s16 xx = (s16)(x0 + step * (s16)k);
            u8 spr = (u8)(SPR_BANNER_0 + k);
            if (xx < -7 || xx > 159) {
                id_spr_hide_range(spr, (u8)(spr + 1u));
                continue;
            }
            ID_SPR_PUT(spr, (u8)xx, yy, (u16)(u8)text[k], PAL_LETTERS, 0u);
        }
        id_spr_hide_range((u8)(SPR_BANNER_0 + n), (u8)(SPR_BANNER_0 + 6u));
        b_spr = 1u;
    }
}

/* SUNSET RUN - heads-up display on SCR1. */
#include "ngpc_hw.h"
#include "ngpc_gfx.h"
#include "ngpc_text.h"
#include "game.h"
#include "ovl.h"
#define GFX_FONT_DATA
#include "../GraphX/gfx_font.h"

#define HUD_PAL_WHITE  0u
#define HUD_PAL_YELLOW 1u
#define HUD_PAL_RED    2u
#define HUD_PAL_ORANGE 7u
#define HUD_PAL_GREEN  8u
#define HUD_PAL_CYAN   9u

static u8 h_time = 255u, h_kmh = 255u, h_gear = 255u, h_prog = 255u, h_stage = 255u;
static u8 h_score[7];
static u8 h_score_ok;
static u8 s_dig[7];          /* the score, as decimal digits (no 32-bit division per frame) */

void hud_score_reset(void)
{
    u8 i;
    for (i = 0u; i < 7u; i++) {
        s_dig[i] = 0u;
    }
}

void hud_score_add(u16 pts)
{
    u16 carry = pts;
    u8 i = 7u;
    while (carry != 0u && i > 0u) {
        u16 v;
        i--;
        v = (u16)(s_dig[i] + carry);
        s_dig[i] = (u8)(v % 10u);
        carry = (u16)(v / 10u);
    }
}

void hud_init(void)
{
    u16 i;
    volatile u16 *dst = (volatile u16 *)0xA200u;     /* character 32 */
    for (i = 0u; i < (GFX_FONT_GLYPHS + GFX_FONT_EXTRA) * 8u; i++) {
        dst[i] = gfx_font_tiles[i];
    }
    ngpc_gfx_set_palette(GFX_SCR1, HUD_PAL_WHITE, 0u, 0x0000u, 0x0888u, 0x0FFFu);
    ngpc_gfx_set_palette(GFX_SCR1, HUD_PAL_YELLOW, 0u, 0x0000u, 0x0088u, 0x08FFu);
    ngpc_gfx_set_palette(GFX_SCR1, HUD_PAL_RED, 0u, 0x0000u, 0x0008u, 0x055Fu);
    ngpc_gfx_set_palette(GFX_SCR1, 3u, 0u, 0x0000u, 0x0840u, 0x0FB4u);
    /* coloured labels, arcade style */
    ngpc_gfx_set_palette(GFX_SCR1, HUD_PAL_ORANGE, 0u, 0x0000u, 0x0028u, 0x05AFu);
    ngpc_gfx_set_palette(GFX_SCR1, HUD_PAL_GREEN, 0u, 0x0000u, 0x0151u, 0x06F6u);
    ngpc_gfx_set_palette(GFX_SCR1, HUD_PAL_CYAN, 0u, 0x0000u, 0x0841u, 0x0FE8u);
}

void hud_reset(void)
{
    h_time = h_kmh = h_gear = h_prog = h_stage = 255u;
    h_score_ok = 0u;
}

void hud_clear_top(void)
{
    u8 x, y;
    ovl_forget();
    for (y = 0u; y < 15u; y++) {
        for (x = 0u; x < 20u; x++) {
            HW_SCR1_MAP[(u16)y * 32u + x] = 0u;
        }
    }
}

void hud_message(u8 row, const char *text)
{
    u8 n = 0u;
    while (text[n] != 0) {
        n++;
    }
    hud_clear_message(row);
    ngpc_text_print(GFX_SCR1, HUD_PAL_YELLOW, (u8)((20u - n) / 2u), row, text);
}

void hud_clear_message(u8 row)
{
    u8 x;
    for (x = 0u; x < 20u; x++) {
        HW_SCR1_MAP[(u16)row * 32u + x] = 0u;
    }
}

static void put_digit(u8 x, u8 y, u8 d, u8 pal)
{
    ngpc_gfx_put_tile(GFX_SCR1, x, y, (u16)('0' + d), pal);
}

void hud_race(u8 time_left, u8 kmh, u8 gear, u16 progress, u8 stage)
{
    u8 i;
    /* row 0: TIME 64 | STAGE 1 [bar] ; row 1: 138 KM/H ......... LOW/HIGH */
    if (time_left != h_time) {
        if (h_time == 255u) {
            ngpc_text_print(GFX_SCR1, HUD_PAL_ORANGE, 0u, 0u, "TIME");
        }
        put_digit(5u, 0u, (u8)(time_left / 10u), time_left < 10u ? HUD_PAL_RED : HUD_PAL_YELLOW);
        put_digit(6u, 0u, (u8)(time_left % 10u), time_left < 10u ? HUD_PAL_RED : HUD_PAL_YELLOW);
        h_time = time_left;
    }
    if (stage != h_stage) {
        ngpc_text_print(GFX_SCR1, HUD_PAL_GREEN, 9u, 0u, "STAGE");
        put_digit(15u, 0u, (u8)(stage + 1u), HUD_PAL_YELLOW);
        h_stage = stage;
        h_prog = 255u;
    }
    {
        u8 p = (u8)((progress * 3u + 9u) / 10u);   /* 0..10 -> 0..3 cells */
        if (p != h_prog) {
            for (i = 0u; i < 3u; i++) {
                ngpc_gfx_put_tile(GFX_SCR1, (u8)(16u + i), 0u, (u16)(i < p ? 0x61u : 0x60u), HUD_PAL_WHITE);
            }
            ngpc_gfx_put_tile(GFX_SCR1, 19u, 0u, 0x64u, HUD_PAL_YELLOW);
            h_prog = p;
        }
    }
    if (kmh != h_kmh) {
        u16 k = (u16)kmh * 2u;          /* kmh is passed halved to fit a byte */
        if (h_kmh == 255u) {
            ngpc_text_print(GFX_SCR1, HUD_PAL_CYAN, 4u, 1u, "KM/H");
        }
        put_digit(0u, 1u, (u8)(k / 100u), HUD_PAL_YELLOW);
        put_digit(1u, 1u, (u8)((k / 10u) % 10u), HUD_PAL_YELLOW);
        put_digit(2u, 1u, (u8)(k % 10u), HUD_PAL_YELLOW);
        h_kmh = kmh;
    }
    if (gear != h_gear) {
        /* gear: 0 LOW, 1 HIGH, 2 LOW flashing red (time to shift up) */
        ngpc_text_print(GFX_SCR1, (gear == 1u) ? HUD_PAL_YELLOW : ((gear == 2u) ? HUD_PAL_RED : HUD_PAL_WHITE),
                        16u, 1u, (gear == 1u) ? "HIGH" : " LOW");
        h_gear = gear;
    }
}

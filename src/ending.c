/* SUNSET RUN - the five endings (goal A..E).
 *
 * Each goal has its own title, line of text, trophy colour and celebration:
 * fireworks, confetti, balloons or twinkling stars, drawn with 14 sprites on
 * the results screen (the scenery and traffic sprites are free there).
 */
#include "ngpc_hw.h"
#include "ngpc_sys.h"
#include "ngpc_gfx.h"
#include "game.h"
#include "id_player.h"
#include "../GraphX/gfx_extra.h"

#define FX_NONE      0u
#define FX_FIREWORKS 1u
#define FX_CONFETTI  2u
#define FX_BALLOONS  3u
#define FX_STARS     4u

#define P_COUNT    14u
#define P_SPR0     ((u8)(SPR_SCN_0 + 6u))     /* after the trophy's 6 sprites */
#define P_TILE     107u                       /* low object pool, after the trophy */

typedef struct {
    const char *title;
    const char *line;
    u16 cup[3];        /* trophy: shadow, main, highlight */
    u8 fx;
} Ending;

static const Ending endings[6] = {
    { "AUTOBAHN ACE",      "TOP SPEED, TOP RANK!", { 0x0444u, 0x0AAAu, 0x0FFFu }, FX_CONFETTI },
    { "CANYON CONQUEROR",  "NOTHING STOPS YOU!",   { 0x0024u, 0x037Bu, 0x08CFu }, FX_FIREWORKS },
    { "LAKESIDE DREAM",    "A PERFECT SUNSET RUN", { 0x0942u, 0x0FC7u, 0x0FFEu }, FX_BALLOONS },
    { "SEASIDE PARTY",     "THE TOWN CHEERS YOU!", { 0x0046u, 0x02BDu, 0x09FFu }, FX_STARS },
    { "LEGEND OF THE RUIN", "THE ANCIENT CUP!",    { 0x0104u, 0x033Du, 0x0AAFu }, FX_FIREWORKS },
    { "JOURNEY COMPLETE",  "A ROAD NOBODY KNEW",   { 0x0055u, 0x00CFu, 0x0AFFu }, FX_FIREWORKS },  /* FREE */
};

static s16 px[P_COUNT], py[P_COUNT], vx[P_COUNT], vy[P_COUNT];
static u8 life[P_COUNT], ptile[P_COUNT], ppal[P_COUNT];
static u8 fx, timer;
static u16 seed = 0x5A17u;

static u8 rnd(void)
{
    seed = (u16)(seed * 25173u + 13849u);
    return (u8)(seed >> 8);
}

static const s8 dir_x[8] = { 16, 11, 0, -11, -16, -11, 0, 11 };
static const s8 dir_y[8] = { 0, -11, -16, -11, 0, 11, 16, 11 };

void ending_start(u8 which)
{
    const Ending *e;
    u16 i;
    u8 k;
    if (which > 5u) which = 5u;
    e = &endings[which];
    for (i = 0u; i < 24u; i++) {
        ((volatile u16 *)(0xA000u + (u32)P_TILE * 16u))[i] = gfx_particle_tiles[i];
    }
    ngpc_gfx_set_palette((u8)GFX_SPR, (u8)PAL_TROPHY, 0u, e->cup[0], e->cup[1], e->cup[2]);
    ngpc_gfx_set_palette((u8)GFX_SPR, 1u, 0u, 0x0005u, 0x003Fu, 0x0AFFu);   /* red   */
    ngpc_gfx_set_palette((u8)GFX_SPR, 2u, 0u, 0x0055u, 0x00EFu, 0x0BFFu);   /* gold  */
    ngpc_gfx_set_palette((u8)GFX_SPR, 9u, 0u, 0x0500u, 0x0F84u, 0x0FFBu);   /* blue  */
    ngpc_gfx_set_palette((u8)GFX_SPR, 10u, 0u, 0x0050u, 0x04E4u, 0x0BFBu);  /* green */
    hud_clear_message(2u);
    hud_message(2u, e->title);
    hud_message(3u, e->line);
    fx = e->fx;
    timer = 0u;
    for (k = 0u; k < P_COUNT; k++) {
        life[k] = 0u;
        px[k] = (s16)((s16)(rnd() % 152u) * 16);
        py[k] = (s16)((s16)(rnd() % 140u) * 16);
    }
}

static u8 pal_of(u8 k)
{
    static const u8 pals[4] = { 1u, 2u, 9u, 10u };
    return pals[k & 3u];
}

void ending_tick(void)
{
    u8 k;
    timer++;
    if (fx == FX_FIREWORKS && (timer % 40u) == 1u) {
        /* a new burst somewhere in the sky */
        s16 cx = (s16)((s16)(24u + rnd() % 112u) * 16);
        s16 cy = (s16)((s16)(20u + rnd() % 40u) * 16);
        u8 pal = pal_of(rnd());
        for (k = 0u; k < P_COUNT; k++) {
            u8 d = (u8)(k & 7u);
            s16 sp = (k < 8u) ? 2 : 1;
            px[k] = cx;
            py[k] = cy;
            vx[k] = (s16)(dir_x[d] * sp);
            vy[k] = (s16)(dir_y[d] * sp);
            life[k] = 34u;
            ptile[k] = 0u;
            ppal[k] = pal;
        }
    }
    for (k = 0u; k < P_COUNT; k++) {
        u8 spr = (u8)(P_SPR0 + k);
        switch (fx) {
        case FX_FIREWORKS:
            if (life[k]) {
                life[k]--;
                px[k] = (s16)(px[k] + vx[k]);
                py[k] = (s16)(py[k] + vy[k]);
                vy[k] = (s16)(vy[k] + 1);          /* gravity */
            }
            break;
        case FX_CONFETTI:
            if (life[k] == 0u || py[k] > 150 * 16) {
                px[k] = (s16)((s16)(rnd() % 152u) * 16);
                py[k] = (s16)(-(s16)(rnd() & 63u) * 16);
                vy[k] = (s16)(12 + (rnd() & 15u));
                ppal[k] = pal_of(rnd());
                ptile[k] = 1u;
                life[k] = 1u;
            }
            py[k] = (s16)(py[k] + vy[k]);
            px[k] = (s16)(px[k] + (((timer + k * 9u) & 32u) ? 6 : -6));
            break;
        case FX_BALLOONS:
            if (life[k] == 0u || py[k] < -8 * 16) {
                px[k] = (s16)((s16)(8u + rnd() % 144u) * 16);
                py[k] = (s16)((s16)(152u + (rnd() & 63u)) * 16);
                vy[k] = (s16)(-(s16)(8 + (rnd() & 7u)));
                ppal[k] = pal_of(rnd());
                ptile[k] = 2u;
                life[k] = 1u;
            }
            py[k] = (s16)(py[k] + vy[k]);
            px[k] = (s16)(px[k] + (((timer + k * 13u) & 64u) ? 3 : -3));
            break;
        case FX_STARS:
            if (life[k] == 0u) {
                px[k] = (s16)((s16)(rnd() % 152u) * 16);
                py[k] = (s16)((s16)(rnd() % 100u) * 16);
                life[k] = (u8)(10u + (rnd() & 31u));
                ppal[k] = (u8)((k & 1u) ? 2u : 9u);
                ptile[k] = 0u;
            } else {
                life[k]--;
            }
            break;
        default:
            break;
        }
        if (life[k] == 0u || px[k] < -7 * 16 || px[k] > 159 * 16 || py[k] < -7 * 16 || py[k] > 151 * 16
            || (fx == FX_STARS && (life[k] & 4u))) {
            id_spr_hide_range(spr, (u8)(spr + 1u));
            continue;
        }
        ID_SPR_PUT(spr, (u8)(px[k] >> 4), (u8)(py[k] >> 4), (u16)(P_TILE + ptile[k]), ppal[k], 0u);
    }
}

void ending_stop(void)
{
    id_spr_hide_range(P_SPR0, (u8)(P_SPR0 + P_COUNT));
    fx = FX_NONE;
}

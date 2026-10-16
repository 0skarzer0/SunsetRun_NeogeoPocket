/* SUNSET RUN - an arcade road race for the Neo Geo Pocket Color.
 *
 * Built on the OVER REV racing engine template (NgpCraft, MIT): scanline
 * road, driving physics and the raster DMA are that engine's. The game
 * layer -- route map with forks, time limit and checkpoints, traffic, themes,
 * scoring and the front end -- is SUNSET RUN's own.
 */
#include "ngpc_hw.h"
#include "carthdr.h"
#include "ngpc_sys.h"
#include "ngpc_timing.h"
#include "ngpc_gfx.h"
#include "ngpc_sprite.h"
#include "ngpc_input.h"
#include "ngpc_text.h"
#include "id_road.h"
#include "id_player.h"
#include "id_fleet.h"
#include "id_scenery.h"
#include "id_cars.h"
#include "game.h"
#include "driving.inc"
#include "../GraphX/gfx_font.h"
#include "game_audio.h"
#include "audio/player.h"
#include "../GraphX/gfx_logo.h"
#include "../GraphX/gfx_extra.h"
#include "audio/music_data.h"

#ifndef AUTOPILOT
#define AUTOPILOT 0
#endif
#ifndef TEST_TIME
#define TEST_TIME 0
#endif

/* ---- tuning ----------------------------------------------------------- */
#define START_TIME       74u
#define TIME_MAX         99u
static const u8 extend_time[GFX_STAGES] = { 70u, 58u, 56u, 54u, 52u };
#define DECIDE_BEFORE   850u      /* fork choice is locked this far before the leg end */
#define START_LINE      120     /* the START gantry, this far ahead of the grid */
#define START_CROWD     900
#define CRASH_FRAMES     90u      /* updates (30 Hz): a crash costs ~2 s plus the restart */
#define CRASH_SPEED     110u

/* ---- game state ------------------------------------------------------- */
#define ST_TITLE   0u
#define ST_COUNT   1u
#define ST_RACE    2u
#define ST_TIMEUP  3u
#define ST_GOAL    4u
#define ST_RESULT  5u

static s16 road_bend[ID_ROAD_LINES_MAX];
static u16 course_pos, track_frac;
static u8 clock_prev, pace_prev, paused, cnt_timer;
static u8 state, state_timer, sec_acc;
static u8 time_left;
static u32 score;
static u8 crash_timer;
static u8 msg_timer;
static u8 flash_step;             /* checkpoint white-out: 1..12 */
static u8 station;
static const char *const station_name[MUSIC_RADIO] = { MUSIC_NAMES };
static u8 last_fork_zone;
static u8 goal_reached;
static u32 hiscore = 1000000ul;
u16 dbg_updates;
u8 dbg_crashes, dbg_scn, dbg_off;

/* Same bounded projection sampler as the full engine; no per-line division. */
static s8 grade_tab[13];
typedef struct {
    const u16     *ahead_end;
    s16           *bend_end;
    s8            *gl_end;
    const Segment *seg;
    const s8      *gtab;
    const Segment *sc;
    u16 into;
    u16 w;
    u8  k;
    u8  cursor;
    u8  len;
    u8  fkey;
    s8  fg;
    u8  nkey;
    u8  pkey;
    u8  pad;
    s16 ndb, ndp;
    s16 pdb, pdp;
} RoadAhead;

typedef char road_ahead_is_44[(sizeof(RoadAhead) == 44u) ? 1 : -1];
typedef char segment_is_6[(sizeof(Segment) == 6u) ? 1 : -1];

extern void id_road_ahead_asm(RoadAhead *a);

static void profile_ahead(void)
{
    RoadAhead a;
    u8 lines = id_road_lines();
    if (lines == 0u) {
        return;
    }
    a.ahead_end = id_road_ahead() + lines;
    a.bend_end = road_bend + lines;
    a.gl_end = id_road_grade_buf() + lines;
    a.seg = track_seg;
    a.gtab = &grade_tab[6u];
    a.sc = &track_seg[seg_index];
    a.into = seg_pos;
    a.k = lines;
    a.cursor = seg_index;
    a.len = track_len;
    a.fkey = 0xFFu;
    a.nkey = 0xFFu;
    a.pkey = 0xFFu;
    id_road_ahead_asm(&a);
}

static void panel(void)
{
    u8 x, y;
    u16 i;
    for (i = 0u; i < 8u; i++) ((volatile u16 *)0xA010u)[i] = 0x5555u;
    ngpc_gfx_set_palette(GFX_SCR2, 7u, 0u, 0x0311u, 0x0311u, 0x0311u);
    /* Road uses palettes 0-1; sky owns 8-15. Palette 7 is reserved for the HUD.
       The raster displays source rows 20..23 behind the stationary HUD. */
    for (y = 20u; y < 24u; y++) for (x = 0u; x < 32u; x++) HW_SCR2_MAP[y * 32u + x] = 1u + (7u << 9);
}

static void clear_hud_rows(u8 from, u8 to)
{
    u8 y;
    for (y = from; y <= to; y++) {
        hud_clear_message(y);
    }
}

static void reset_car(void)
{
    speed = gear = slip = offroad = finished = 0u;
    speed_acc = track_frac = recovery_frames = 0u;
    car_lat = hill_acc = heading_acc = bend_now = 0;
    car_lean = 0;
    on_throttle = steer_hold = oil_hold = 0u;
    skid = skid_t = 0u;
}

static void new_game(void)
{
    reset_car();
    seg_index = 0u;
    seg_pos = 0u;
    course_pos = 0u;
    racing = 1u;
    course_start();
#ifdef TEST_LEG
    course_debug_leg((u8)(TEST_LEG >> 4), (u8)(TEST_LEG & 15));
#endif
    theme_apply(cur_leg);
    traffic_clear();
    traffic_reset(gfx_legs[cur_leg].traffic_min, gfx_legs[cur_leg].traffic_max);
    id_scenery_init(0u, 0u);
    scenery_mode(SCN_MODE_CROWD);         /* fans at the start line */
    time_left = START_TIME;
    score = 0ul;
    hud_score_reset();
    sec_acc = 0u;
    crash_timer = 0u;
    msg_timer = 0u;
    flash_step = 0u;
    last_fork_zone = 0u;
    goal_reached = 0u;
    paused = 0u;
    hud_clear_top();
    clear_hud_rows(15u, 18u);
    hud_reset();
}

/* ------------------------------------------------------------- the road */
static u16 advance(void)
{
    u16 base = speed < 16u ? (u16)(((u16)speed * 3502u) >> 4) : 3502u;
    u16 inc = (u16)((u16)speed * 123u + base);
    u16 acc;
    u16 step;
    /* WORLD_SPEED 11/8: the world scrolls faster than the OVER REV template
       for an arcade feel (curves, stripes, scenery and traffic all scale). */
    inc = (u16)(inc + (inc >> 2) + (inc >> 3));
    acc = (u16)(track_frac + inc);
    if (speed == 0u) {
        acc = track_frac;
    }
    step = (u16)(acc >> 12);
    track_frac = (u16)(acc & 0x0FFFu);
    course_pos = (u16)(course_pos + step);
    seg_pos = (u16)(seg_pos + step);
    while (seg_pos >= track_seg[seg_index].span) {
        seg_pos = (u16)(seg_pos - track_seg[seg_index].span);
        seg_index++;
        if (seg_index >= track_len) seg_index = 0u;
    }
    {
        s16 target = bend_blended(seg_index, seg_pos);
        if (bend_now < target - 6) bend_now += 6;
        else if (bend_now > target + 6) bend_now -= 6;
        else bend_now = target;
    }
    return step;
}

static void render_road(void)
{
    profile_ahead();
    id_road_band_phase(course_pos);
    id_road_hill_ahead(id_road_grade_buf());
    id_road_pan(heading_acc, car_lat);
    id_road_frame_ahead((s16)(car_lat >> 4), road_bend, (s16)(heading_acc >> 4));
}

/* ------------------------------------------------------------- messages */
static void message(const char *a, const char *b, u8 frames)
{
    hud_clear_message(5u);
    hud_clear_message(7u);
    if (a) hud_message(5u, a);
    if (b) hud_message(7u, b);
    msg_timer = frames;
    banner_dirty();
}

/* countdown digits: below the START gantry */
static void count_message(const char *a, u8 frames)
{
    hud_clear_message(12u);
    if (a) hud_message(12u, a);
    cnt_timer = frames;
}

static void tick_message(void)
{
    if (msg_timer) {
        msg_timer--;
        if (msg_timer == 0u) {
            hud_clear_message(5u);
            hud_clear_message(7u);
            banner_dirty();
        }
    }
    if (cnt_timer) {
        cnt_timer--;
        if (cnt_timer == 0u) {
            hud_clear_message(12u);
        }
    }
}

/* ------------------------------------------------------------- legs */
static void leg_end(void)
{
    u8 shift;
    if (course_is_last_stage()) {
        state = ST_GOAL;
        state_timer = 0u;
        goal_reached = 1u;
        message("GOAL!", "CONGRATULATIONS", 0u);
        music_play(MUSIC_GOAL);
        hud_clear_message(3u);
        return;
    }
    course_pos = (u16)(course_pos - leg_len);
    shift = course_next_leg();
    seg_index = (u8)(seg_index - shift);
    {
        u16 t = (u16)time_left + extend_time[cur_stage];
        time_left = (u8)((t > TIME_MAX) ? TIME_MAX : t);
    }
    flash_step = 1u;
    message("CHECKPOINT!", "EXTENDED PLAY", 75u);
    sfx(SFX_CHECKPOINT);
    hud_clear_message(3u);
}

/* checkpoint transition: white-out, swap the scenery while white, fade in */
static void tick_flash(void)
{
    static const u8 lv[12] = { 1u, 2u, 3u, 4u, 4u, 4u, 4u, 3u, 3u, 2u, 1u, 0u };
    if (flash_step == 0u) {
        return;
    }
    if (flash_step == 5u) {
        theme_apply(cur_leg);
        traffic_reset(gfx_legs[cur_leg].traffic_min, gfx_legs[cur_leg].traffic_max);
    }
    theme_flash(lv[flash_step - 1u]);
    flash_step++;
    if (flash_step > 12u) {
        flash_step = 0u;
    }
}

/* ------------------------------------------------------------- autopilot (tests) */
#ifndef AP_GHOST
#define AP_GHOST 0
#endif
#ifndef AP_NOBRAKE
#define AP_NOBRAKE 0
#endif
#if AUTOPILOT
extern s16 traffic_ap_target(s16 car_lat, s16 want);
static u8 ap_turn;
static void autopilot(void)
{
    s16 want = 0;
    s16 lead;
    u8 held = PAD_A;
#if !AP_NOBRAKE
    {
        /* slow down for the sharpest bend within ~700 units */
        u8 i = seg_index, n, v = 15u;
        u16 dist = (u16)(track_seg[i].span - seg_pos);
        s16 b = track_seg[i].bend, m;
        m = (b < 0) ? (s16)-b : b;
        for (n = 0u; n < 4u && dist < 350u; n++) {
            i++;
            if (i >= track_len) i = 0u;
            b = track_seg[i].bend;
            if (b < 0) b = (s16)-b;
            if (b > m) m = b;
            dist = (u16)(dist + track_seg[i].span);
        }
        while (v > 6u && (s16)(v * v) * m > 6000) v--;
        if (speed > (u8)(v * 16u + 10u)) held = PAD_B;
        else if (speed > (u8)(v * 16u)) held = 0u;
    }
#endif
    if (course_fork_zone(course_pos)) {
        want = (ap_turn & 1u) ? 300 : -300;
    }
    want = traffic_ap_target(car_lat, want);
    /* steer against the drift the bend will add */
    lead = (s16)(car_lat + (s16)(bend_now * 5));
    if (lead < want - 40) held |= PAD_RIGHT;
    else if (lead > want + 40) held |= PAD_LEFT;
    if (gear == 0u && speed >= (u8)(LOW_TOP - 3)) held |= PAD_DOWN;
    else if (gear == 1u && speed < 110u) held |= PAD_UP;
    ngpc_pad_pressed = (u8)(held & (u8)~ngpc_pad_held);
    ngpc_pad_held = held;
}
#endif

/* ------------------------------------------------------------- front end */
static void print_score7(u8 x, u8 y, u32 s, u8 pal)
{
    u16 hi = (u16)(s / 10000ul);
    u16 lo = (u16)(s - (u32)hi * 10000ul);
    ngpc_text_print_dec(GFX_SCR1, pal, x, y, hi, 3u);
    ngpc_text_print_dec(GFX_SCR1, pal, (u8)(x + 3u), y, lo, 4u);
}

static void title_option(u8 row, const char *text)
{
    u8 n = 0u;
    while (text[n] != 0) n++;
    hud_clear_message(row);
    ngpc_gfx_put_tile(GFX_SCR1, 1u, row, 0x62u, 0u);
    ngpc_gfx_put_tile(GFX_SCR1, 18u, row, 0x63u, 0u);
    ngpc_text_print(GFX_SCR1, 1u, (u8)((20u - n) / 2u), row, text);
}

static void title_station_text(void)
{
    title_option(9u, station_name[station]);
}

static void title_gear_text(void)
{
    ngpc_text_print(GFX_SCR1, 0u, 2u, 10u, "UP:LOW  DOWN:HIGH");
}

static void title_screen(void)
{
    u16 i;
    u8 x, y;
    hud_clear_top();
    clear_hud_rows(15u, 18u);
    /* logo characters borrow the low object pool until the race starts */
    for (i = 0u; i < GFX_LOGO_TILES * 8u; i++) {
        ((volatile u16 *)(0xA000u + (u32)TILE_OBJ_LOW * 16u))[i] = gfx_logo_tiles[i];
    }
    ngpc_gfx_set_palette(GFX_SCR1, 4u, 0u, 0x0303u, 0x00FFu, 0x0FFFu);
    ngpc_gfx_set_palette(GFX_SCR1, 5u, 0u, 0x0303u, 0x008Fu, 0x00FFu);
    ngpc_gfx_set_palette(GFX_SCR1, 6u, 0u, 0x0303u, 0x084Fu, 0x008Fu);
    for (y = 0u; y < 3u; y++) {
        for (x = 0u; x < 20u; x++) {
            u8 t = gfx_logo_map[y * 20u + x];
            HW_SCR1_MAP[(u16)(y + 2u) * 32u + x] = t ? (u16)((TILE_OBJ_LOW + t) | ((u16)(4u + y) << 9)) : 0u;
        }
    }
    ngpc_text_print(GFX_SCR1, 3u, 2u, 5u, "ON THE ROAD AGAIN");
    title_station_text();
    title_gear_text();
    banner_hide();
    ngpc_text_print(GFX_SCR1, 0u, 4u, 11u, "HI");
    print_score7(7u, 11u, hiscore, 1u);
    id_spr_hide_range((u8)SPR_TRF_0, (u8)SPR_SCN_END);
}

static void title_blink(u8 t)
{
    if ((t & 31u) == 0u) {
        ngpc_text_print(GFX_SCR1, 1u, 2u, 13u, "PRESS A TO START");
    } else if ((t & 31u) == 20u) {
        hud_clear_message(13u);
    }
}

/* ------------------------------------------------------------- trophy */
#define TROPHY_TILE  101u          /* low object pool: free on the results screen */
static void trophy_load(void)
{
    u16 i;
    for (i = 0u; i < (u16)(GFX_TROPHY_TILES * 8u); i++) {
        ((volatile u16 *)(0xA000u + (u32)TROPHY_TILE * 16u))[i] = gfx_trophy_tiles[i];
    }
    ngpc_gfx_set_palette((u8)GFX_SPR, (u8)PAL_TROPHY, gfx_trophy_pal[0], gfx_trophy_pal[1],
                         gfx_trophy_pal[2], gfx_trophy_pal[3]);
}

static void trophy_draw(void)
{
    u8 i;
    u8 bob = (u8)(((g_vb_counter >> 3) & 3u) == 1u ? 1u : 0u);
    for (i = 0u; i < (u8)GFX_TROPHY_CELLS; i++) {
        const u8 *c = &gfx_trophy_cells[i * 3u];
        ID_SPR_PUT((u8)(SPR_SCN_0 + i), (u8)(72u + c[0] * 8u), (u8)(82u - bob + c[1] * 8u),
                   (u16)(TROPHY_TILE + c[2]), PAL_TROPHY, 0u);
    }
}

static void result_screen(void)
{
    u8 i;
    hud_clear_top();
    clear_hud_rows(15u, 18u);
    hud_message(2u, goal_reached ? "YOU MADE IT!" : "GAME OVER");
    ngpc_text_print(GFX_SCR1, 0u, 3u, 5u, "SCORE");
    print_score7(10u, 5u, score, 1u);
    ngpc_text_print(GFX_SCR1, 0u, 3u, 7u, "ROUTE");
    for (i = 0u; i <= cur_stage; i++) {
        /* letter of the branch taken at each stage: A = leftmost road */
        ngpc_gfx_put_tile(GFX_SCR1, (u8)(10u + i * 2u), 7u, (u16)('A' + route_hist[i]), 1u);
        if (i < cur_stage) {
            ngpc_gfx_put_tile(GFX_SCR1, (u8)(11u + i * 2u), 7u, (u16)'-', 0u);
        }
    }
    if (score > hiscore) {
        hiscore = score;
        hud_message(9u, "NEW HIGH SCORE!");
    }
    banner_hide();
    id_spr_hide_range((u8)SPR_TRF_0, (u8)SPR_SCN_END);
    if (goal_reached) {
        trophy_load();
        ending_start(route_hist[cur_stage]);   /* goal A..E: its own celebration */
    }
}

/* ------------------------------------------------------------- tyre smoke */
static const u16 smoke_tiles[32] = {   /* two 16x8 puffs, left + right halves */
    0x005A, 0x06AF, 0x1AFF, 0x6BFF, 0x6BFF, 0x1AFF, 0x05AA, 0x0055,
    0x9400, 0xE900, 0xFA40, 0xFE90, 0xFFA5, 0xFEA4, 0xAA50, 0x5500,
    0x0005, 0x016B, 0x06FF, 0x1BFF, 0x6FFF, 0x6BFF, 0x16AA, 0x0155,
    0x9400, 0xE500, 0xFA40, 0xFF90, 0xFF90, 0xFE95, 0xAA50, 0x5500
};
static const u8 smoke_slot[4] = { TILE_SMOKE_0, TILE_SMOKE_1, TILE_SMOKE_2, TILE_SMOKE_3 };
static u8 smoke_t;

static void smoke_init(void)
{
    u8 i, t;
    for (t = 0u; t < 4u; t++) {
        for (i = 0u; i < 8u; i++) {
            ((volatile u16 *)(0xA000u + (u32)smoke_slot[t] * 16u))[i] = smoke_tiles[(u8)(t * 8u + i)];
        }
    }
    ngpc_gfx_set_palette((u8)GFX_SPR, (u8)PAL_SMOKE, 0u, 0x0AAAu, 0x0DDDu, 0x0FFFu);
}

/* white clouds at the rear tyres while skidding, plus the screech */
static void smoke_draw(u8 on)
{
    s16 x;
    u8 y, f, k, h;
    if (!on) {
        id_spr_hide_range((u8)SPR_SMOKE_0, (u8)(SPR_SMOKE_0 + 4u));
        smoke_t = 0u;
        return;
    }
    if ((smoke_t & 7u) == 0u) {
        sfx(SFX_SKID);
    }
    smoke_t++;
    x = id_car_last_x();
    y = (u8)(id_car_last_top() + 14u + ((smoke_t >> 1) & 1u));
    for (k = 0u; k < 2u; k++) {
        /* each cloud is 16 px wide, centred on the outside of a rear tyre and
         * billowing outwards; the right one is mirrored */
        s16 px = (k == 0u) ? (s16)(x - 11 - (s16)((smoke_t >> 2) & 1u))
                           : (s16)(x + 27 + (s16)((smoke_t >> 2) & 1u));
        f = (u8)(((smoke_t >> 2) + k) & 1u);
        for (h = 0u; h < 2u; h++) {
            u8 spr = (u8)(SPR_SMOKE_0 + k * 2u + h);
            /* mirrored cloud: swap the halves */
            u8 half = (u8)(k ? (u8)(1u - h) : h);
            s16 hx = (s16)(px + (s16)(h * 8u));
            if (hx < -7 || hx > 159) {
                id_spr_hide_range(spr, (u8)(spr + 1u));
                continue;
            }
            ID_SPR_PUT(spr, (u8)hx, y, smoke_slot[(u8)(f * 2u + half)],
                       PAL_SMOKE, (u8)(k ? SPR_HFLIP : 0u));
        }
    }
}

/* ------------------------------------------------------------- engine note */
/* A low square wave whose pitch follows the revs of the current gear (about
 * 95 Hz idling to 200 Hz at the limiter), so shifting LOW -> HIGH drops the
 * note.  A small alternating detune gives it a rumble; off-road it shakes. */
static u8 eng_phase;
static void engine_sound(void)
{
    u16 top = (gear == 0u) ? (u16)LOW_TOP : (u16)HIGH_TOP;
    u16 r = (u16)(((u16)speed * 255u) / top);
    u16 f, div;
    u8 attn;
    if (r > 255u) r = 255u;
    if (crash_timer) r = 0u;
    f = (u16)(95u + ((r * 27u) >> 6));
    div = (u16)((48000u / f) * 2u);
    eng_phase++;
    if (eng_phase & 1u) {
        div = (u16)(div + (div >> ((offroad && speed > 20u) ? 3 : 5)));
    }
    attn = (u8)((ngpc_pad_held & PAD_A) ? 4u : 6u);
    if (state == ST_GOAL || state == ST_TIMEUP) attn = 9u;
    player_engine(div, attn);
}

/* Warning signs: +1 / -1 when a sharp left / right corner starts between
 * SIGN_NEAR and SIGN_FAR ahead (positive bend = left). */
#define SIGN_NEAR  150u
#define SIGN_FAR  1300u
static s8 sharp_ahead(void)
{
    u8 i = seg_index, n;
    u16 dist = (u16)(track_seg[i].span - seg_pos);
    s16 b = track_seg[i].bend;
    if (b >= LEG_SHARP_MIN || b <= -LEG_SHARP_MIN) {
        return 0;               /* already in it: normal roadside */
    }
    for (n = 0u; n < 6u && dist < SIGN_FAR; n++) {
        i++;
        if (i >= track_len) i = 0u;
        b = track_seg[i].bend;
        if (b >= LEG_SHARP_MIN || b <= -LEG_SHARP_MIN) {
            if (dist < SIGN_NEAR) return 0;
            return (s8)(b > 0 ? 1 : -1);
        }
        dist = (u16)(dist + track_seg[i].span);
    }
    return 0;
}

static void game_tick(u8 delta)
{
    if (state == ST_TITLE) {
#if AUTOPILOT
        ngpc_pad_pressed = PAD_A;
#endif
        title_blink(state_timer);
        state_timer++;
        if (ngpc_pad_pressed & (PAD_LEFT | PAD_RIGHT)) {
            if (ngpc_pad_pressed & PAD_RIGHT) {
                station = (u8)((station + 1u) % MUSIC_RADIO);
            } else {
                station = (u8)((station + MUSIC_RADIO - 1u) % MUSIC_RADIO);
            }
            title_station_text();
            music_play(station);
        }
        if (ngpc_pad_pressed & PAD_A) {
            new_game();
            state = ST_COUNT;
            state_timer = 0u;
        }
        ngpc_pad_held = 0u;
        ngpc_pad_pressed = 0u;
    } else if (state == ST_RESULT) {
        if ((ngpc_pad_pressed & PAD_A) && state_timer > 30u) {
            state = ST_TITLE;
            new_game();
            title_screen();
            music_play(station);
        }
        if (state_timer < 255u) state_timer++;
        if (state_timer > 30u) title_blink(state_timer);
        ngpc_pad_held = 0u;
        ngpc_pad_pressed = 0u;
    } else if (ngpc_pad_pressed & PAD_OPTION) {
        paused = (u8)!paused;
        if (paused) message("PAUSE", 0, 0u);
        else message(0, 0, 1u);
    }
    if (paused) {
        return;
    }

    if (state == ST_COUNT) {
        static const char *const cd[4] = { "3", "2", "1", "GO!" };
        u8 n = (u8)(state_timer / 30u);
        if (state_timer % 30u == 0u && n < 4u) {
            count_message(cd[n], 0u);
            sfx(SFX_BEEP);
        }
        state_timer++;
        if (state_timer >= 90u) {
            state = ST_RACE;
            count_message(cd[3], 30u);
            sfx(SFX_GO);
        }
        ngpc_pad_held = 0u;
        ngpc_pad_pressed = 0u;
    }
#if AUTOPILOT
    if (state == ST_RACE) autopilot();
#endif
    if (state == ST_RACE || state == ST_TIMEUP || state == ST_GOAL) {
        u8 fz;
        if (state != ST_RACE || crash_timer) {
            ngpc_pad_held = 0u;
            ngpc_pad_pressed = 0u;
        }
        drive();
        advance();
        /* score while racing */
        if (state == ST_RACE) {
            score += (u32)(speed >> 1);
            hud_score_add((u16)(speed >> 1));
            sec_acc = (u8)(sec_acc + delta);
            while (sec_acc >= 60u) {
                sec_acc = (u8)(sec_acc - 60u);
#if !TEST_TIME
                if (time_left) time_left--;
#endif
                if (time_left && time_left <= 10u) sfx(SFX_TICK);
            }
            if (time_left == 0u) {
                state = ST_TIMEUP;
                state_timer = 0u;
                message("TIME UP", 0, 0u);
                music_play(MUSIC_OVER);
                hud_clear_message(3u);
            }
        }
        /* fork run-out */
        fz = course_fork_zone(course_pos);
        if (fz && !course_is_last_stage()) {
            if (!last_fork_zone) {
                scenery_mode(SCN_MODE_FORK);
                ngpc_text_print(GFX_SCR1, 1u, 1u, 3u, CH_LEFT " LEFT    RIGHT " CH_RIGHT);
            }
            if (fork_choice == 0u && course_pos + DECIDE_BEFORE >= leg_len) {
                course_decide((u8)(car_lat > 0));
#if AUTOPILOT
                ap_turn++;
#endif
                hud_clear_message(3u);
                if (fork_choice == 2u) {
                    ngpc_text_print(GFX_SCR1, 1u, 12u, 3u, "RIGHT " CH_RIGHT);
                } else {
                    ngpc_text_print(GFX_SCR1, 1u, 1u, 3u, CH_LEFT " LEFT");
                }
            }
        } else if (fz && course_is_last_stage()) {
            if (!last_fork_zone) {
                ngpc_text_print(GFX_SCR1, 1u, 5u, 3u, "GOAL AHEAD");
            }
            scenery_mode(SCN_MODE_CROWD);
        } else if (cur_stage == 0u && course_pos < START_CROWD) {
            scenery_mode(SCN_MODE_CROWD);
        } else if (course_start_zone(course_pos)) {
            scenery_mode(SCN_MODE_FLAGS);
        } else {
            s8 w = sharp_ahead();
            scenery_mode(w > 0 ? SCN_MODE_CURVE_L : (w < 0 ? SCN_MODE_CURVE_R : SCN_MODE_NORMAL));
        }
        last_fork_zone = fz;
        if (!goal_reached && course_pos >= leg_len) {
            last_fork_zone = 0u;
            leg_end();
        }
        id_scenery_advance(speed);
        /* collisions */
        if (state == ST_RACE && crash_timer == 0u) {
#if AP_GHOST
            u8 hit = 0u;
#else
            u8 hit = traffic_collide(car_lat, speed);
#endif
            if (!hit) {
                if (id_scenery_hit((s16)(car_lat >> 4), ID_CAR_WHEEL)) {
                    if (speed > CRASH_SPEED) {
                        dbg_scn++;
                        hit = 1u;
                    } else {
                        u8 cost = POST_HIT, cap = (u8)(speed >> 1);
                        if (cost > cap) cost = cap;
                        speed = (speed > cost) ? (u8)(speed - cost) : 0u;
                        sfx(SFX_BUMP);
                    }
                }
            }
            if (hit) {
                if (speed > CRASH_SPEED) {
                    crash_timer = CRASH_FRAMES;
                    dbg_crashes++;
                    sfx(SFX_CRASH);
                } else {
                    speed = (u8)(speed >> 1);
                    sfx(SFX_BUMP);
                }
            }
        }
        if (crash_timer) {
            crash_timer--;
            speed = (speed > 12u) ? (u8)(speed - 12u) : 0u;
            if (crash_timer == 0u) {
                car_lat = (s16)(car_lat / 2);
                speed = 0u;
                gear = 0u;
            }
        }
        traffic_update(speed, (u8)(state == ST_RACE && !course_fork_zone(course_pos)));
        if (state == ST_TIMEUP) {
            state_timer++;
            if (speed == 0u && state_timer > 60u) {
                state = ST_RESULT;
                state_timer = 0u;
                result_screen();
            }
        } else if (state == ST_GOAL) {
            state_timer++;
            if (state_timer == 1u) {
                u8 k;
                score += (u32)time_left * 20000ul;
                for (k = 0u; k < time_left; k++) hud_score_add(20000u);
            }
            if (speed == 0u && state_timer > 60u) {
                state = ST_RESULT;
                state_timer = 0u;
                result_screen();
            }
        }
    }
}

/* ------------------------------------------------------------- main */
void main(void)
{
    u16 next;
    s16 g;
    u16 pano_base, obj_base;
    ngpc_init();
    audio_init();
    hud_init();
    ngpc_gfx_set_viewport(0u, 0u, 160u, 152u);
    ngpc_gfx_clear(GFX_SCR1);
    ngpc_gfx_clear(GFX_SCR2);
    ngpc_sprite_hide_all();
    id_road_init();
    id_road_dma_pause();
    next = (u16)(ID_TILE_BASE + id_road_char_count());
    pano_base = next;
    next = (u16)(next + GFX_PANO_MAX_TILES);
    id_car_select(0u);
    id_car_init(next, 0u);
    next = (u16)(next + id_car_char_count(0u));
    traffic_init(next);
    next = (u16)(next + gfx_traffic_tiles_count);
    obj_base = next;
    theme_init_tiles(pano_base, obj_base, 512u);
    smoke_init();
    banner_init();
    /* the rumble strip still counts as road */
    road_edge = (s16)(((s16)id_road_half_at(ID_CAR_WHEEL) + (s16)(id_road_half_at(ID_CAR_WHEEL) / 9u)) * 16);
    lat_limit = (s16)((s16)id_road_half_at(ID_CAR_WHEEL) * 16 + LAT_MARGIN * 16);
    for (g = -6; g <= 6; g++) {
        s16 room = g > 0 ? id_road_grade_hi() : -id_road_grade_lo();
        grade_tab[(u8)(g + 6)] = (s8)(g * room / 6);
    }
    traffic_set_car_line(ID_CAR_WHEEL);
    new_game();
    state = ST_TITLE;
    title_screen();
#ifdef TEST_ENDING
    goal_reached = 1u;
    cur_stage = 4u;
    route_hist[4] = (u8)TEST_ENDING;
    state = ST_RESULT;
    result_screen();
#endif
    id_road_dma_resume();
    music_play(station);
    clock_prev = pace_prev = g_vb_counter;
    for (;;) {
        u8 now, elapsed, owed, t;
        while ((u8)(g_vb_counter - pace_prev) < 2u) ngpc_vsync();
        /* REAL TIME, WHATEVER THE FRAME RATE: the game logic runs once per
           two VBlanks that have elapsed (up to 3 catch-up ticks), the picture
           is drawn once.  On a slower machine the motion is coarser, but the
           car, traffic and clock keep their true speed. */
        now = g_vb_counter;
        elapsed = (u8)(now - pace_prev);
        owed = (u8)(elapsed >> 1);
        if (owed > 3u) {
            owed = 3u;
            pace_prev = (u8)(now - (elapsed & 1u));
        } else {
            pace_prev = (u8)(pace_prev + (u8)(owed * 2u));
        }
        ngpc_input_update();
        audio_update();
        dbg_updates++;
        clock_prev = now;
        for (t = 0u; t < owed; t++) {
            game_tick(2u);
            if (t == 0u) {
                ngpc_pad_pressed = 0u;
            }
        }
        render_road();
        tick_flash();
        tick_message();
        if (state != ST_TITLE && state != ST_RESULT) {
            id_scenery_draw();
            traffic_draw();
        }
        if (state == ST_COUNT || (state == ST_RACE && cur_stage == 0u && course_pos < (u16)(START_LINE + 100))) {
            banner_show((s16)((s16)START_LINE - (s16)course_pos), 0u, "START");
        } else if ((state == ST_RACE || state == ST_GOAL || state == ST_TIMEUP) && course_is_last_stage()
                   && (s16)course_pos > (s16)leg_len - 1400) {
            banner_show((s16)((s16)leg_len - (s16)course_pos), 1u, "FINISH");
        } else {
            banner_hide();
        }
        if (state == ST_RESULT && goal_reached) {
            trophy_draw();
            ending_tick();
        }
        if (state == ST_RACE || state == ST_COUNT || state == ST_TIMEUP || state == ST_GOAL) {
            u16 prog = (u16)(course_pos / (u16)(leg_len / 10u + 1u));
            hud_race(time_left, (u8)(((u16)speed * 21u) >> 5),
                     (u8)((gear == 0u && speed >= (u8)(LOW_TOP - 14) && (g_vb_counter & 8u)) ? 2u : gear),
                     prog, cur_stage);
        }
        if (crash_timer && (crash_timer & 2u)) {
            id_car_draw((s16)(car_lat >> 4), (s8)((crash_timer & 4u) ? 1 : -1), 2u);
        } else {
            id_car_draw((s16)(car_lat >> 4), car_lean, (u8)((offroad && speed > 20u) ? 1u : 0u));
        }
        smoke_draw((u8)(skid && crash_timer == 0u && state == ST_RACE));
        if (offroad && state == ST_RACE) dbg_off++;
        if (state == ST_RACE || state == ST_COUNT || state == ST_TIMEUP || state == ST_GOAL) {
            engine_sound();
        } else {
            player_engine_off();
        }
    }
}

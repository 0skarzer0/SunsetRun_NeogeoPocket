/* SUNSET RUN - shared game declarations. */
#ifndef GAME_H
#define GAME_H
#include "ngpc_types.h"
#include "../GraphX/gfx_course.h"

/* ---- VRAM character layout ------------------------------------------ */
#define TILE_PANEL        1u      /* solid HUD panel character            */
#define TILE_OBJ_LOW      2u      /* 2..31 : roadside objects (low pool)  */
#define TILE_OBJ_LOW_END  32u
#define TILE_GLYPH        96u     /* 96..100 : custom glyphs (bar, arrows, flag) */
#define TILE_OBJ_LOW2    101u     /* 101..127 : roadside objects (second low pool) */
#define TILE_OBJ_LOW2_END 125u
#define TILE_SMOKE_0      1u     /* old HUD panel character */
#define TILE_SMOKE_1    125u
#define TILE_SMOKE_2    126u
#define TILE_SMOKE_3    127u
#define TILE_ROAD         128u

/* ---- sprite slots ------------------------------------------------------ */
/* player car : 0..11 (trim layer) and 12..23 (body layer), see id_player.h.
 * Lower sprite numbers are drawn in front. */
#define SPR_SMOKE_0   24u        /* 24..27 : tyre smoke clouds */
#define SPR_TRF_0     28u
#define SPR_TRF_END   50u        /* 22 sprites: a near truck takes 20 */
#define SPR_SCN_0     50u
#define SPR_SCN_END   64u

/* ---- sprite palettes ------------------------------------------------- */
/* 0 car body, 5 car trim, 1..2 objects, 3..4 traffic (+ 6..8 traffic) */
#define PAL_OBJ_L     1u
#define PAL_OBJ_R     2u
#define PAL_OBJ_SIGN  9u
#define PAL_OBJ_FLAG  10u
#define PAL_SMOKE      3u
#define PAL_OBJ_FORK   4u
#define PAL_CROWD      6u
#define PAL_LETTERS    7u
#define PAL_TROPHY     8u
#define SPR_BANNER_0  58u        /* 58..63 : letters on the START / FINISH gantry */
#define PAL_TRF_0     11u        /* 11..15 : five traffic colours */

/* ---- course / route (course.c) ------------------------------------- */
extern const Segment *track_seg;
extern u8 track_len;
extern u8 cur_stage, cur_branch, cur_leg;
extern u16 leg_len;               /* driving length of the current leg (incl. fork zone) */
extern u8 fork_choice;            /* 0 undecided, 1 left, 2 right */
extern u8 route_hist[GFX_STAGES]; /* branch taken per stage */
extern u8 leg_theme[GFX_LEG_COUNT];  /* scenery of each leg (shuffled in FREE) */
extern u16 next_leg_cost;         /* driving-time estimate of the leg loaded last */
#define DIFF_EASY   0u
#define DIFF_NORMAL 1u
#define DIFF_HARD   2u
#define DIFF_FREE   3u
#define DIFF_COUNT  4u
extern u8 difficulty;
extern u16 free_seed;
void course_start(void);
u8   course_fork_zone(u16 pos);   /* 1 while in the fork run-out */
u8   course_start_zone(u16 pos);  /* 1 right after a checkpoint */
void course_decide(u8 right);
u8   course_next_leg(void);       /* switch to the chosen next leg; 0 = it was the last (goal) */
u8   course_is_last_stage(void);
void course_debug_leg(u8 stage, u8 branch);

/* ---- theme (theme.c) ---------------------------------------------- */
void theme_init_tiles(u16 pano_base, u16 obj_base, u16 obj_end);
void theme_apply(u8 leg);         /* palettes, panorama, objects (heavy: use while hidden) */
void theme_flash(u8 level);       /* 0 = normal colours, 1..3 = towards white */
u16  theme_obj_tile(u8 pool_tile);
const u16 *theme_obj_map(void);
u8   theme_obj_kind_left(void);
u8   theme_obj_kind_right(void);

/* ---- traffic (traffic.c) ------------------------------------------- */
void traffic_init(u16 tile_base);
void traffic_reset(u8 density_min, u8 density_max);
void traffic_set_hard(u8 on);     /* HARD: denser, slower, lane-changing traffic */
void traffic_clear(void);
void traffic_update(u8 player_speed, u8 spawning);
void traffic_draw(void);
u8   traffic_collide(s16 car_lat, u8 speed);   /* 0, or 1/2: hit by a car on the left/right */
void traffic_set_car_line(u8 wheel_line);

/* ---- scenery (id_scenery.c) ---------------------------------------- */
#define SCN_MODE_NORMAL 0u
#define SCN_MODE_FORK   1u
#define SCN_MODE_FLAGS  2u
#define SCN_MODE_CURVE_L 3u    /* warning signs, both sides, pointing left  */
#define SCN_MODE_CURVE_R 4u    /* ... pointing right */
#define SCN_MODE_CROWD  5u      /* cheering fans at the start and the finish */
void scenery_mode(u8 mode);
void theme_crowd_colours(u8 on);
extern u8 trf_spr_end;            /* traffic sprites end here (balloons borrow the last ones) */

/* ---- start / finish gantry (banner.c) ------------------------------ */
void banner_init(void);
void banner_style(u8 diff);       /* colours of the gantry for the difficulty */
void banner_show(s16 d, u8 finish, const char *text);
void banner_hide(void);
void banner_dirty(void);
u8   banner_active(void);

/* ---- stone bridges (bridge.c) ------------------------------------ */
extern u8 bridge_line;            /* foot line of the nearest bridge on screen, 0 = none */
void bridge_init(void);
void bridge_setup(void);          /* place the bridges of the current leg */
void bridge_draw(u16 course_pos);
void bridge_hide(void);
u8   bridge_hit(u16 prev, u16 pos, s16 lat_px);

/* ---- endings (ending.c) ------------------------------------------- */
void ending_start(u8 which);
void ending_tick(void);
void ending_stop(void);

/* ---- hud (hud.c) ------------------------------------------------- */
void hud_init(void);
void hud_reset(void);
void hud_score_reset(void);
void hud_score_add(u16 pts);
void hud_race(u8 time_left, u8 kmh, u8 gear, u16 progress, u8 stage);
void hud_message(u8 row, const char *text);   /* centred on SCR1 row */
void hud_clear_message(u8 row);
void hud_clear_top(void);

#endif

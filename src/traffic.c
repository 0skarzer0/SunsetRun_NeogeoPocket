/* SUNSET RUN - traffic: slower cars sharing the road, drawn with the road's
 * own look-ahead table so they sit on bends and hills like the scenery. */
#include "ngpc_hw.h"
#include "ngpc_gfx.h"
#include "game.h"
#include "id_road.h"
#include "id_player.h"
#include "spr_cells.h"
#include "../GraphX/gfx_sprites.h"

#define TRF_MAX       7u         /* HARD; the other modes stop at 6 */
#define TRF_SPAWN_D   1450u      /* distance ahead where cars appear     */
#define TRF_FAR_D     1600u
#define HIT_FRONT     (14 * 16)  /* rel window for a hit, 1/16 units     */
#define HIT_BACK      (-6 * 16)

typedef struct {
    u8  active;
    u8  kind;
    u8  pal;
    u8  speed;
    s16 lat;          /* same units as car_lat: px*16 at the wheel line */
    s16 rel;          /* distance to the player's wheel line, units*16  */
    s16 acc;          /* sub-unit accumulator                            */
    s16 drift;        /* lane change target                              */
    s16 prev;         /* rel before the last update (collision sweep)    */
} TrafficCar;

static TrafficCar cars[TRF_MAX];
static u16 trf_tiles;
static u16 car_d;           /* look-ahead distance of the player's wheel line */
static u8  half_wheel;
static u8  dens_min, dens_max, target;
static u8  cooldown;
static u16 rng = 0x1D2Bu;
static u8 hard, trf_cap = 6u;

void traffic_set_hard(u8 on)
{
    hard = on;
    trf_cap = (u8)(on ? TRF_MAX : 6u);
}

static u8 rnd8(void)
{
    rng = (u16)(rng * 25173u + 13849u);
    return (u8)(rng >> 8);
}

void traffic_init(u16 tile_base)
{
    u16 i;
    trf_tiles = tile_base;
    for (i = 0u; i < gfx_traffic_tiles_count * 8u; i++) {
        ((volatile u16 *)(0xA000u + (u32)tile_base * 16u))[i] = gfx_traffic_tiles[i];
    }
    for (i = 0u; i < GFX_TRAFFIC_PALS; i++) {
        ngpc_gfx_set_palette((u8)GFX_SPR, (u8)(PAL_TRF_0 + i),
                             gfx_traffic_pals[i * 4u], gfx_traffic_pals[i * 4u + 1u],
                             gfx_traffic_pals[i * 4u + 2u], gfx_traffic_pals[i * 4u + 3u]);
    }
    traffic_clear();
}

void traffic_set_car_line(u8 wheel_line)
{
    car_d = id_road_distance_at_line(wheel_line);
    half_wheel = id_road_half_at(wheel_line);
    if (half_wheel == 0u) {
        half_wheel = 1u;
    }
}

void traffic_clear(void)
{
    u8 i;
    for (i = 0u; i < TRF_MAX; i++) {
        cars[i].active = 0u;
    }
    id_spr_hide_range((u8)SPR_TRF_0, (u8)SPR_TRF_END);
}

void traffic_reset(u8 dmin, u8 dmax)
{
    if (dmin > trf_cap) dmin = trf_cap;
    dens_min = dmin;
    dens_max = (dmax > trf_cap) ? trf_cap : dmax;
    target = dens_min;
    cooldown = 30u;
}

#define LANES 4u
static s16 lane_lat(u8 lane)
{
    /* four lanes: centres at -3/4, -1/4, +1/4, +3/4 of the half width */
    s16 q = (s16)(((s16)half_wheel * 16) / 4);
    return (s16)(q * (s16)(2 * (s16)lane - 3));
}

static u8 lane_of(s16 lat)
{
    s16 q = (s16)(((s16)half_wheel * 16) / 4);
    s16 l = (s16)((lat + 4 * q) / (2 * q));
    if (l < 0) l = 0;
    if (l > 3) l = 3;
    return (u8)l;
}

static void spawn(void)
{
    u8 i, lane, tries;
    TrafficCar *c = 0;
    for (i = 0u; i < TRF_MAX; i++) {
        if (!cars[i].active) {
            c = &cars[i];
            break;
        }
    }
    if (c == 0) {
        return;
    }
    for (tries = 0u; tries < 3u; tries++) {
        u8 clash = 0u;
        lane = (u8)(rnd8() % LANES);
        for (i = 0u; i < TRF_MAX; i++) {
            if (cars[i].active && cars[i].lat == lane_lat(lane)
                && cars[i].rel > (s16)(((s16)TRF_SPAWN_D - (s16)car_d - 400) * 16)) {
                clash = 1u;
            }
        }
        if (!clash) {
            break;
        }
    }
    if (tries == 3u) {
        return;
    }
    c->active = 1u;
    c->kind = (u8)(rnd8() % GFX_TRAFFIC_KINDS);
    c->pal = (u8)(PAL_TRF_0 + rnd8() % GFX_TRAFFIC_PALS);
    /* HARD: slower cars, so there are more of them to get through */
    c->speed = (u8)((hard ? 42u : 55u) + (rnd8() % 70u));
    if (c->kind == TRAFFIC_TRUCK) {
        c->speed = (u8)(c->speed - 15u);
    }
    c->lat = lane_lat(lane);
    c->drift = c->lat;
    c->rel = (s16)(((s16)TRF_SPAWN_D - (s16)car_d) * 16);
    c->prev = c->rel;
    c->acc = 0;
}

void traffic_update(u8 player_speed, u8 spawning)
{
    u8 i, n = 0u;
    for (i = 0u; i < TRF_MAX; i++) {
        TrafficCar *c = &cars[i];
        s16 d;
        if (!c->active) {
            continue;
        }
        /* relative motion: (car - player) * 123 * 11/8 / 256 in 1/16 units
         * (the world speed of advance() in main.c), doubled so that at top
         * speed the cars ahead are caught in a few seconds as in the arcade */
        c->prev = c->rel;
        c->acc = (s16)(c->acc + ((s16)c->speed - (s16)player_speed) * 85);
        d = (s16)(c->acc / 64);
        c->rel = (s16)(c->rel + d);
        c->acc = (s16)(c->acc - d * 64);
        /* occasional lane change */
        if (c->lat != c->drift) {
            if (c->lat < c->drift) {
                c->lat = (s16)(c->lat + 8);
                if (c->lat > c->drift) c->lat = c->drift;
            } else {
                c->lat = (s16)(c->lat - 8);
                if (c->lat < c->drift) c->lat = c->drift;
            }
        } else if (rnd8() < (u8)(hard ? 6u : 2u)) {
            u8 lane = lane_of(c->lat);
            if (lane == 0u) {
                lane = 1u;
            } else if (lane == 3u) {
                lane = 2u;
            } else {
                lane = (rnd8() & 1u) ? (u8)(lane + 1u) : (u8)(lane - 1u);
            }
            c->drift = lane_lat(lane);
        }
        if (c->rel < -(s16)car_d * 16 - 64 || c->rel > (s16)(((s16)TRF_FAR_D - (s16)car_d) * 16)) {
            c->active = 0u;
            continue;
        }
        n++;
    }
    if (cooldown) {
        cooldown--;
    }
    if (spawning && n < target && cooldown == 0u && player_speed > 50u) {
        spawn();
        cooldown = (u8)((hard ? 16u : 25u) + (rnd8() & 31u));
        if (dens_max > dens_min) {
            target = (u8)(dens_min + rnd8() % (u8)(dens_max - dens_min + 1u));
        }
    }
}

u8 traffic_collide(s16 car_lat, u8 speed)
{
    u8 i;
    (void)speed;
    for (i = 0u; i < TRF_MAX; i++) {
        TrafficCar *c = &cars[i];
        s16 dl;
        if (!c->active) {
            continue;
        }
        {
            /* sweep: the car may jump more than the hit window in one tick */
            s16 lo = (c->prev < c->rel) ? c->prev : c->rel;
            s16 hi = (c->prev < c->rel) ? c->rel : c->prev;
            if (lo > HIT_FRONT || hi < HIT_BACK) {
                continue;
            }
        }
        dl = (s16)(c->lat - car_lat);
        if (dl < 0) {
            dl = (s16)-dl;
        }
        if (dl < 26 * 16) {
            /* push the other car ahead so the hit happens once */
            c->rel = (s16)(c->rel + 60 * 16);
            c->prev = c->rel;
            c->speed = (u8)(c->speed + 30u);
            return 1u;
        }
    }
    return 0u;
}

void traffic_draw(void)
{
    u8 order[TRF_MAX];
    u8 n = 0u, i, j;
    u8 spr = SPR_TRF_0;
    s16 haut = (s16)id_road_visible_top();
    for (i = 0u; i < TRF_MAX; i++) {
        if (cars[i].active) {
            order[n++] = i;
        }
    }
    /* nearest first (smallest rel) -> lowest sprite numbers, drawn in front */
    for (i = 1u; i < n; i++) {
        u8 t = order[i];
        j = i;
        while (j > 0u && cars[order[(u8)(j - 1u)]].rel > cars[t].rel) {
            order[j] = order[(u8)(j - 1u)];
            j--;
        }
        order[j] = t;
    }
    for (i = 0u; i < n; i++) {
        TrafficCar *c = &cars[order[i]];
        s16 dd = (s16)((s16)car_d + c->rel / 16);
        u8 line, rung, w;
        IdRoadSpriteSample g;
        const SprFrame *f;
        const SprCell *cell;
        s16 x, cx;
        u8 top, k;
        if (dd < 0) {
            continue;
        }
        line = id_road_line_at_distance((u16)dd);
        if (line == 255u) {
            continue;
        }
        id_road_sprite_sample(line, &g);
        if (g.foot < haut) {
            continue;
        }
        w = (u8)(((u16)g.half * 32u) / half_wheel);
        if (w >= 28u) rung = 0u;
        else if (w >= 20u) rung = 1u;
        else if (w >= 13u) rung = 2u;
        else if (w >= 9u) rung = 3u;
        else rung = 4u;
        f = &gfx_traffic_frames[(u8)(c->kind * GFX_RUNGS + rung)];
        cx = (s16)(g.centre + (s16)(((s16)(c->lat >> 4) * (s16)g.half) / (s16)half_wheel));
        x = (s16)(cx - (s16)(f->px_w / 2u));
        if (g.foot > 151) {
            continue;
        }
        top = (u8)((u16)g.foot + 1u - (u16)f->h * 8u);
        {
            SprJob jb;
            jb.cells = (const u8 *)&gfx_traffic_cells[f->first];
            jb.map = 0;
            jb.base = trf_tiles;
            jb.x = x;
            jb.y = top;
            jb.n = f->n;
            jb.wm1 = 0u;
            jb.attr = (u8)((bridge_line != 0u && g.foot < (s16)bridge_line) ? SPR_MIDDLE : id_spr_priority);
            jb.pal = c->pal;
            jb.spr = spr;
            jb.end = SPR_TRF_END;
            jb.flip = 0u;
            jb.hasmap = 0u;
            spr_cells_asm(&jb);
            spr = jb.spr;
        }
    }
    id_spr_hide_range(spr, (u8)SPR_TRF_END);
}

/* Test autopilot helper: a lateral target that avoids the cars ahead. */
s16 traffic_ap_target(s16 car_lat, s16 want)
{
    u8 lane, i, best = 1u;
    s16 best_rel = -1;
    for (lane = 0u; lane < LANES; lane++) {
        s16 l = lane_lat(lane);
        s16 nearest = 32767;
        for (i = 0u; i < TRF_MAX; i++) {
            s16 dl;
            if (!cars[i].active || cars[i].rel < -16 * 16) continue;
            dl = (s16)(cars[i].lat - l);
            if (dl < 0) dl = (s16)-dl;
            if (dl < 30 * 16 && cars[i].rel < nearest) nearest = cars[i].rel;
        }
        /* prefer the wanted side on ties */
        if (nearest > best_rel || (nearest == best_rel && ((want < 0 && lane == 0u) || (want > 0 && lane == 3u)))) {
            best_rel = nearest;
            best = lane;
        }
    }
    (void)car_lat;
    if (best_rel > 900 * 16 && want != 0) return want;
    return lane_lat(best);
}

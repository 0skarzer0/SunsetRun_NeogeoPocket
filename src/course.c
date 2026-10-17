/* SUNSET RUN - route map: five stages, a fork at the end of every leg.
 *
 * The road renderer reads `track_seg[0 .. track_len-1]` and wraps at the end.
 * The buffer holds the current leg, then (once the player has picked a side
 * in the fork run-out) the next leg, then a long straight placeholder so the
 * look-ahead never wraps back onto the start of the current leg.
 *
 * FREE mode keeps the same pyramid of 15 legs, but shuffles which scenery
 * each leg has and builds every leg at run time from the seed, with the same
 * rules as tools/gen_course.py (make_leg).  The same seed always gives the
 * same journey.
 */
#include "game.h"

#define BUF_MAX 72u
static Segment buf[BUF_MAX];
const Segment *track_seg = buf;
u8 track_len;
u8 cur_stage, cur_branch, cur_leg;
u16 leg_len;
u8 fork_choice;
u8 route_hist[GFX_STAGES];
u8 difficulty;
u16 free_seed = 0x5EEDu;
u8 leg_theme[GFX_LEG_COUNT];
u16 next_leg_cost;                /* leg_cost/16 of the leg just loaded (FREE clock) */
static u8 n_cur, n_next;
#define FORK_TURN 50

/* ---------------------------------------------------------------- generator */
static u16 rs;
static u16 rnd16(void)
{
    rs ^= (u16)(rs << 7);
    rs ^= (u16)(rs >> 9);
    rs ^= (u16)(rs << 8);
    return rs;
}

static u16 rndn(u16 n)
{
    return (u16)(rnd16() % n);
}

static u8 stage_of(u8 lid)
{
    u8 s = 0u;
    while (s + 1u < GFX_STAGES && LEG_ID(s + 1u, 0u) <= lid) s++;
    return s;
}

static const u16 easy_bends[5] = { 20u, 26u, 32u, 40u, 46u };   /* + medium from stage 1 */
static const u16 sharp_bends[3] = { 56u, 62u, 70u };
static const u16 sp_sharp[3] = { 350u, 400u, 500u };
static const u16 sp_s[3] = { 300u, 350u, 400u };
static const u16 sp_gap[3] = { 0u, 100u, 150u };
static const u16 sp_straight[4] = { 400u, 500u, 600u, 800u };
static const u16 sp_bend[5] = { 400u, 500u, 600u, 700u, 800u };
static const s8 slopes[6] = { 0, -1, 1, 0, -2, 2 };   /* 0 = -hills, 3 = +hills */
static const Segment bridge_run[LEG_BRIDGE_N] = LEG_BRIDGE_RUN;

static Segment *gp;
static u8 gn;

static void put(u16 span, s16 bend, s8 slope)
{
    gp[gn].span = span;
    gp[gn].bend = bend;
    gp[gn].slope = slope;
    gn++;
}

static s8 slope_for(u8 hills)
{
    if (hills && rndn(100u) < (u16)(18u * hills)) {
        u8 k = (u8)rndn(6u);
        s8 sl = slopes[k];
        if (k == 0u) sl = (s8)-(s8)hills;
        if (k == 3u) sl = (s8)hills;
        if (sl < -4) sl = -4;
        if (sl > 3) sl = 3;
        return sl;
    }
    return 0;
}

static s16 sharp(u8 bs10)
{
    u16 b = (u16)(((u32)sharp_bends[rndn(3u)] * (u32)(850u + 15u * bs10) + 500ul) / 1000ul);
    if (b < LEG_SHARP_MIN) b = LEG_SHARP_MIN;
    if (b > 72u) b = 72u;
    return (s16)b;
}

/* builds leg `lid` at `out`, returns its segment count (<= 35) */
static u8 gen_leg(u8 lid, Segment *out)
{
    const ThemeInfo *T = &gfx_themes[leg_theme[lid]];
    u8 stage = stage_of(lid);
    u16 p_sharp = (u16)(160u + 60u * stage);         /* per mille */
    u16 p_s = (u16)(80u + 50u * stage);
    u16 total = LEG_START_LEN;
    u16 lead;
    s8 sl;
    s16 last = 1;
    gp = out;
    gn = 0u;
    rs = (u16)(free_seed ^ (u16)((u16)(lid + 1u) * 0x9E37u));
    if (rs == 0u) rs = 0xACE1u;
    rnd16();
    put(LEG_START_LEN, 0, 0);
    {
    u8 bridged = (u8)!T->bridges;
    while (total < (u16)LEG_LEN && gn <= (u8)LEG_MAX_PRE_FORK) {
        u16 r;
        if (!bridged && total >= (u16)LEG_BRIDGE_AT) {
            /* the bridge run: straight, down, up, a curve (as gen_course.py) */
            u8 k;
            bridged = 1u;
            for (k = 0u; k < LEG_BRIDGE_N; k++) {
                put(bridge_run[k].span, (s16)(bridge_run[k].bend * last), bridge_run[k].slope);
                total = (u16)(total + bridge_run[k].span);
            }
            continue;
        }
        r = rndn(1000u);
        s16 sgn = (rndn(1000u) < 600u) ? (s16)-last : last;
        if (r < p_s) {
            /* S bend: two sharp corners in opposite directions */
            s16 a = sharp(T->bscale10);
            s16 b = sharp(T->bscale10);
            u16 sp = sp_s[rndn(3u)];
            u16 gap = sp_gap[rndn(3u)];
            lead = (u16)(rndn(2u) ? 500u : 400u);     /* draws in a fixed order */
            sl = slope_for(T->hills);
            put(lead, 0, sl);
            put(sp, (s16)(sgn * a), 0);
            if (gap) put(gap, 0, 0);
            put(sp, (s16)(-sgn * b), 0);
            total = (u16)(total + 450u + 2u * sp + gap);
            last = (s16)-sgn;
        } else if (r < p_s + p_sharp) {
            u16 sp;
            lead = (u16)(rndn(2u) ? 500u : 400u);
            sl = slope_for(T->hills);
            put(lead, 0, sl);
            sp = sp_sharp[rndn(3u)];
            put(sp, (s16)(sgn * sharp(T->bscale10)), 0);
            total = (u16)(total + 450u + sp);
            last = sgn;
        } else if (rndn(100u) < T->pstraight) {
            u16 sp = sp_straight[rndn(4u)];
            put(sp, 0, slope_for(T->hills));
            total = (u16)(total + sp);
        } else {
            u16 sp = sp_bend[rndn(5u)];
            u16 b = easy_bends[rndn(stage >= 1u ? 5u : 3u)];
            b = (u16)((b * T->bscale10 + 5u) / 10u);
            if (b < 18u) b = 18u;
            if (b > 48u) b = 48u;
            put(sp, (s16)(sgn * (s16)b), slope_for(T->hills));
            total = (u16)(total + sp);
            last = sgn;
        }
    }
    }
    put(LEG_FORK_LEN, 0, 0);
    return gn;
}

/* driving-time estimate of n segments, /16 (same formula as gen_course.py) */
static u16 cost_of(const Segment *s, u8 n)
{
    u32 c = 0ul;
    u8 i;
    for (i = 0u; i < n; i++) {
        s16 m = s[i].bend;
        u16 v = 14u;
        if (m < 0) m = (s16)-m;
        while (v > 6u && (u16)(v * v) * (u16)m > 6000u) v--;
        c += ((u32)s[i].span * 14ul) / v;
    }
    return (u16)(c >> 4);
}

/* ---------------------------------------------------------------- buffer */
static void put_placeholder(u8 at)
{
    buf[at].span = 4000u;
    buf[at].bend = 0;
    buf[at].slope = 0;
}

static u8 copy_leg(u8 leg, u8 at)
{
    u8 i, n;
    if (difficulty == DIFF_FREE) {
        n = gen_leg(leg, &buf[at]);
    } else {
        const LegInfo *L = &gfx_legs[leg];
        n = L->count;
        if ((u16)at + n + 1u > BUF_MAX) {
            n = (u8)(BUF_MAX - 1u - at);
        }
        for (i = 0u; i < n; i++) {
            buf[(u8)(at + i)] = L->seg[i];
        }
    }
    next_leg_cost = cost_of(&buf[at], n);
    return n;
}

static void load_current(void)
{
    u8 i;
    n_cur = copy_leg(cur_leg, 0u);
    put_placeholder(n_cur);
    track_len = (u8)(n_cur + 1u);
    leg_len = 0u;
    for (i = 0u; i < n_cur; i++) {
        leg_len = (u16)(leg_len + buf[i].span);
    }
    fork_choice = 0u;
}

void course_start(void)
{
    u8 i;
    cur_stage = 0u;
    cur_branch = 0u;
    cur_leg = 0u;
    for (i = 0u; i < GFX_STAGES; i++) {
        route_hist[i] = 0u;
    }
    for (i = 0u; i < GFX_LEG_COUNT; i++) {
        leg_theme[i] = gfx_legs[i].theme;
    }
    if (difficulty == DIFF_FREE) {
        /* a different journey: shuffle the 15 sceneries over the pyramid */
        if (free_seed == 0u) free_seed = 0x5EEDu;
        rs = (u16)(free_seed ^ 0x3C5Au);
        if (rs == 0u) rs = 0xACE1u;
        for (i = (u8)(GFX_LEG_COUNT - 1u); i > 0u; i--) {
            u8 j = (u8)rndn((u16)(i + 1u));
            u8 t = leg_theme[i];
            leg_theme[i] = leg_theme[j];
            leg_theme[j] = t;
        }
    }
    load_current();
}

u8 course_is_last_stage(void)
{
    return (u8)(cur_stage + 1u >= GFX_STAGES);
}

u8 course_fork_zone(u16 pos)
{
    return (u8)(pos + (u16)LEG_FORK_LEN >= leg_len);
}

u8 course_start_zone(u16 pos)
{
    return (u8)(cur_stage != 0u && pos < (u16)LEG_START_LEN);
}

void course_decide(u8 right)
{
    u8 next, n;
    if (fork_choice != 0u || course_is_last_stage()) {
        return;
    }
    fork_choice = (u8)(right ? 2u : 1u);
    next = LEG_ID(cur_stage + 1u, cur_branch + (right ? 1u : 0u));
    n = copy_leg(next, n_cur);
    n_next = n;
    /* the next leg opens with a bend towards the chosen side, so taking the
     * fork feels like turning off onto that road (positive bend = left) */
    if (n != 0u) {
        buf[n_cur].bend = right ? (s16)-FORK_TURN : (s16)FORK_TURN;
    }
    put_placeholder((u8)(n_cur + n));
    track_len = (u8)(n_cur + n + 1u);
}

/* Called when the player crosses the end of the current leg.  The caller
 * subtracts the returned segment count from its segment cursor. */
u8 course_next_leg(void)
{
    u8 i, shift;
    if (course_is_last_stage()) {
        return 0u;
    }
    if (fork_choice == 0u) {
        course_decide(0u);
    }
    shift = n_cur;
    for (i = 0u; (u8)(i + shift) < track_len; i++) {
        buf[i] = buf[(u8)(i + shift)];
    }
    track_len = (u8)(track_len - shift);
    if (fork_choice == 2u) {
        cur_branch++;
    }
    cur_stage++;
    route_hist[cur_stage] = cur_branch;
    cur_leg = LEG_ID(cur_stage, cur_branch);
    n_cur = n_next;
    if (n_cur >= track_len) {
        n_cur = (u8)(track_len - 1u);
    }
    leg_len = 0u;
    for (i = 0u; i < n_cur; i++) {
        leg_len = (u16)(leg_len + buf[i].span);
    }
    fork_choice = 0u;
    return shift;
}

/* tests: start directly on a given leg */
void course_debug_leg(u8 stage, u8 branch)
{
    cur_stage = stage;
    cur_branch = branch;
    cur_leg = LEG_ID(stage, branch);
    route_hist[stage] = branch;
    load_current();
}

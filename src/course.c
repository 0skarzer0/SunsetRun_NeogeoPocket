/* SUNSET RUN - route map: five stages, a fork at the end of every leg.
 *
 * The road renderer reads `track_seg[0 .. track_len-1]` and wraps at the end.
 * The buffer holds the current leg, then (once the player has picked a side
 * in the fork run-out) the next leg, then a long straight placeholder so the
 * look-ahead never wraps back onto the start of the current leg.
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
static u8 n_cur;
#define FORK_TURN 50

static void put_placeholder(u8 at)
{
    buf[at].span = 4000u;
    buf[at].bend = 0;
    buf[at].slope = 0;
}

static u8 copy_leg(u8 leg, u8 at)
{
    const LegInfo *L = &gfx_legs[leg];
    u8 i;
    u8 n = L->count;
    if ((u16)at + n + 1u > BUF_MAX) {
        n = (u8)(BUF_MAX - 1u - at);
    }
    for (i = 0u; i < n; i++) {
        buf[(u8)(at + i)] = L->seg[i];
    }
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
    n_cur = gfx_legs[cur_leg].count;
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

#!/usr/bin/env python3
"""Generate the 15 legs of the SUNSET RUN route map (GraphX/gfx_course.c/h).

Stage s (0..4) has s+1 legs.  Leg id = s*(s+1)/2 + b.  At the end of a leg the
road forks: keep LEFT -> (s+1, b), keep RIGHT -> (s+1, b+1).
"""
import os, sys, random

OUT = sys.argv[1] if len(sys.argv) > 1 else 'GraphX'

# theme name -> (pano index name, object kinds left/right, road colours)
#   road: asphalt, white line, band gradient (4, dark->bright)
THEMES = {
    # light grey tarmac with white dashes, as on the classic coastal highway
    'beach':  ('BEACH',  ('PALM', 'PALM'),         ('99A', 'FFF', ['99A', 'AAB', 'CCD', 'FFF'])),
    'coast':  ('COAST',  ('ROCK', 'BUSH'),         ('889', 'FFF', ['889', '99A', 'BBC', 'FFF'])),
    'fields': ('FIELDS', ('TREE', 'WINDMILL'),     ('898', 'FFF', ['898', '9A9', 'BCB', 'FFF'])),
    'desert': ('DESERT', ('CACTUS', 'ROCK'),       ('A98', 'FFE', ['A98', 'BA9', 'DCB', 'FFE'])),
    'autumn': ('AUTUMN', ('TREE_AU', 'POPLAR_AU'), ('988', 'FFF', ['988', 'A99', 'CBB', 'FFF'])),
    'alps':   ('ALPS',   ('PINE', 'ROCK'),         ('89A', 'FFF', ['89A', '9AB', 'BCD', 'FFF'])),
    'city':   ('CITY',   ('COLUMN', 'COLUMN'),     ('869', 'FDA', ['869', '97A', 'B9B', 'FDB'])),
    'lake':   ('LAKE',   ('POPLAR', 'TREE'),       ('88A', 'EEF', ['88A', '99B', 'BBD', 'EEF'])),
    'canyon': ('CANYON', ('ROCK', 'ROCK'),         ('987', 'FFE', ['987', 'A98', 'CBA', 'FFE'])),
    'caves':  ('CAVES',  ('ROCK', 'BUSH'),         ('877', 'FFF', ['877', '988', 'BAA', 'FFF'])),
    'snow':   ('SNOW',   ('PINE', 'PINE'),         ('99B', 'FFF', ['99B', 'AAC', 'CCE', 'FFF'])),
    'farm':   ('FARM',   ('TREE', 'BUSH'),         ('998', 'FFF', ['998', 'AA9', 'CCB', 'FFF'])),
    'autobahn': ('AUTOBAHN', ('POPLAR', 'POPLAR'), ('778', 'FFF', ['778', '889', 'AAB', 'FFF'])),
    'seaside': ('SEASIDE', ('PALM', 'WINDMILL'),   ('99A', 'FFF', ['99A', 'AAB', 'CCD', 'FFF'])),
    'ruins':  ('RUINS',  ('COLUMN', 'BUSH'),       ('998', 'FFE', ['998', 'AA9', 'CCB', 'FFE'])),
}
LEGS = [   # 15 different scenes, 5 goals (A..E)
    ['beach'],
    ['coast', 'alps'],
    ['city', 'desert', 'fields'],
    ['autumn', 'caves', 'snow', 'farm'],
    ['autobahn', 'canyon', 'lake', 'seaside', 'ruins'],
]
# style per theme: (bend scale, hill amount, straight probability)
STYLE = {
    'beach': (0.7, 1, 0.35), 'coast': (1.0, 2, 0.25), 'fields': (0.6, 2, 0.35),
    'desert': (0.5, 1, 0.45), 'autumn': (0.9, 3, 0.2), 'alps': (1.1, 4, 0.15),
    'city': (0.8, 1, 0.3), 'lake': (0.9, 2, 0.25),
    'canyon': (1.1, 3, 0.15), 'caves': (1.0, 3, 0.2), 'snow': (1.0, 3, 0.2), 'farm': (0.7, 2, 0.35),
    'autobahn': (0.5, 1, 0.5), 'seaside': (0.9, 2, 0.25), 'ruins': (1.0, 2, 0.2),
}
LEG_LEN = 11700      # driving length before the fork zone
FORK_LEN = 2400       # straight, flat run-out holding the fork signs
START_LEN = 900       # straight at the beginning of each leg (checkpoint banner)
EASY_BENDS = [20, 26, 32]        # flat out
MEDIUM_BENDS = [40, 46]          # flat out with a good line
SHARP_BENDS = [56, 62, 70]       # lift off or brake (see driving.inc)
SHARP_MIN = 52                   # main.c shows curve warning signs from here
MAX_PRE_FORK = 30                # an element adds <= 4 segments: <= 35 per leg (course.c BUF_MAX)
BRIDGES = {'fields', 'autumn', 'farm', 'lake', 'ruins'}   # scenes with old stone bridges
THEME_ORDER = ['beach', 'coast', 'alps', 'city', 'desert', 'fields', 'autumn', 'caves', 'snow', 'farm',
               'autobahn', 'canyon', 'lake', 'seaside', 'ruins']

def leg_cost(segs):
    """rough driving time of a leg: span / the speed its bend allows (same
    integer formula as course.c, used to size the FREE mode clock)"""
    cost = 0
    for sp, bd, sl in segs:
        m, v = abs(bd), 14
        while v > 6 and v * v * m > 6000:
            v -= 1
        cost += sp * 14 // v
    return cost

def make_leg(theme, seed, stage):
    """A leg is a sequence of elements: straights, sweepers, sharp corners
    and S bends.  Later stages are twistier."""
    rnd = random.Random(seed)
    bscale, hills, pstraight = STYLE[theme]
    p_sharp = 0.16 + 0.06 * stage          # chance an element is a sharp corner
    p_s = 0.08 + 0.05 * stage              # chance of an S bend
    segs = [(START_LEN, 0, 0)]
    total = START_LEN
    last = 1

    def slope_for():
        if hills and rnd.random() < 0.18 * hills:
            sl = rnd.choice([-hills, -1, 1, hills, -2, 2])
            return max(-4, min(3, sl))
        return 0

    def sharp():
        return min(72, max(SHARP_MIN, int(rnd.choice(SHARP_BENDS) * (0.85 + 0.15 * bscale) + 0.5)))

    while total < LEG_LEN and len(segs) <= MAX_PRE_FORK:
        r = rnd.random()
        sgn = -last if rnd.random() < 0.6 else last
        if r < p_s:
            # S bend: two sharp corners in opposite directions, short gap
            a = sharp()
            b = sharp()
            sp = rnd.choice([300, 350, 400])
            gap = rnd.choice([0, 100, 150])
            # a straight before so the warning signs can be seen
            segs.append((rnd.choice([400, 500]), 0, slope_for()))
            segs.append((sp, sgn * a, 0))
            if gap:
                segs.append((gap, 0, 0))
            segs.append((sp, -sgn * b, 0))
            total += 450 + 2 * sp + gap
            last = -sgn
        elif r < p_s + p_sharp:
            segs.append((rnd.choice([400, 500]), 0, slope_for()))
            sp = rnd.choice([350, 400, 500])
            segs.append((sp, sgn * sharp(), 0))
            total += 450 + sp
            last = sgn
        elif rnd.random() < pstraight:
            sp = rnd.choice([400, 500, 600, 800])
            segs.append((sp, 0, slope_for()))
            total += sp
        else:
            sp = rnd.choice([400, 500, 600, 700, 800])
            pool = EASY_BENDS + (MEDIUM_BENDS if stage >= 1 else [])
            bnd = max(18, min(48, int(rnd.choice(pool) * bscale + 0.5)))
            segs.append((sp, sgn * bnd, slope_for()))
            total += sp
            last = sgn
    segs.append((FORK_LEN, 0, 0))
    return segs

def c12(x):
    r, g, bb = (int(ch, 16) for ch in x)
    return '0x%04X' % (r | (g << 4) | (bb << 8))

def main():
    os.makedirs(OUT, exist_ok=True)
    c = ['/* Generated by tools/gen_course.py -- do not edit. */', '#include "gfx_course.h"', '']
    table = []
    lid = 0
    costs = [[] for _ in LEGS]
    for s, row in enumerate(LEGS):
        for b, theme in enumerate(row):
            segs = make_leg(theme, 1000 + lid * 17, s)
            costs[s].append(leg_cost(segs))
            name = 'leg%d_seg' % lid
            c.append('static const Segment %s[%d] = {' % (name, len(segs)))
            for sp, bd, sl in segs:
                c.append('    { %d, %d, %d },' % (sp, bd, sl))
            c.append('};')
            table.append('    { %s, %d, %d },' % (name, len(segs), THEME_ORDER.index(theme)))
            lid += 1
    c.append('')
    c.append('const LegInfo gfx_legs[GFX_LEG_COUNT] = {')
    c += table
    c.append('};')
    c.append('')
    c.append('const ThemeInfo gfx_themes[GFX_THEME_COUNT] = {')
    for theme in THEME_ORDER:
        pano_name, objs, road = THEMES[theme]
        asphalt, line, band = road
        bs, hills, pst = STYLE[theme]
        c.append('    { PANO_%s, OBJ_%s, OBJ_%s, %s, %s, { %s }, %d, %d, %d, %d },' % (
            pano_name, objs[0], objs[1], c12(asphalt), c12(line), ', '.join(c12(x) for x in band),
            int(round(bs * 10)), hills, int(round(pst * 100)), 1 if theme in BRIDGES else 0))
    c.append('};')
    # mean cost of the fixed legs of each stage: the FREE clock scales by cost / this
    refs = [sum(v) // len(v) for v in costs]
    c.append('const u16 gfx_leg_ref_cost[GFX_STAGES] = { %s };' % ', '.join(str(r // 16) for r in refs))
    open(os.path.join(OUT, 'gfx_course.c'), 'w').write('\n'.join(c) + '\n')
    h = ['/* Generated by tools/gen_course.py -- do not edit. */', '#ifndef GFX_COURSE_H', '#define GFX_COURSE_H',
         '#include "ngpc_types.h"', '#include "gfx_pano.h"', '#include "gfx_sprites.h"',
         '#ifndef SEGMENT_DEFINED', '#define SEGMENT_DEFINED',
         'typedef struct { u16 span; s16 bend; s8 slope; } Segment;', '#endif',
         '#define GFX_LEG_COUNT %d' % lid, '#define GFX_STAGES 5', '#define GFX_THEME_COUNT %d' % len(THEME_ORDER),
         '#define LEG_FORK_LEN %d' % FORK_LEN, '#define LEG_START_LEN %d' % START_LEN,
         '#define LEG_SHARP_MIN %d' % SHARP_MIN, '#define LEG_LEN %d' % LEG_LEN,
         '#define LEG_MAX_PRE_FORK %d' % MAX_PRE_FORK,
         'typedef struct { const Segment *seg; u8 count; u8 theme; } LegInfo;',
         'typedef struct {',
         '    u8 pano; u8 obj_left; u8 obj_right;',
         '    u16 asphalt; u16 line; u16 band[4];',
         '    u8 bscale10; u8 hills; u8 pstraight;      /* road style (gen_course.py STYLE) */',
         '    u8 bridges;                               /* stone bridges over the road */',
         '} ThemeInfo;',
         'extern const LegInfo gfx_legs[GFX_LEG_COUNT];',
         'extern const ThemeInfo gfx_themes[GFX_THEME_COUNT];',
         'extern const u16 gfx_leg_ref_cost[GFX_STAGES];   /* mean leg_cost / 16 per stage */',
         '#define LEG_ID(stage, branch) ((u8)(((stage) * ((stage) + 1u)) / 2u + (branch)))',
         '#endif', '']
    open(os.path.join(OUT, 'gfx_course.h'), 'w').write('\n'.join(h))
    print('%d legs, reference costs %s' % (lid, refs))

main()

#!/usr/bin/env python3
"""Title screen art for SUNSET RUN (GraphX/gfx_title.c/h).

A blue screen with an oval emblem: a sunset over the sea, a road running
into it, a palm tree and the SUNSET RUN lettering.  Everything is drawn
here procedurally; the car on the road is the game's own sprite, drawn by
main.c.

Layers (the NGPC shows SCR1 in front of SCR2):
  * SCR2: the emblem background (oval, sky, sun, sea, beach, road)
  * SCR1: the palm tree and the lettering (transparent elsewhere)
The emblem is 144 x 88 pixels (18 x 11 characters) at screen x = 8.
"""
import math, os, random, sys
from PIL import Image

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pano
from conv import convert_plane
from ngpgfx import parse_c_array, pixels_to_words, to12

OUT = sys.argv[1] if len(sys.argv) > 1 else 'GraphX'
PREVIEW = os.environ.get('TITLE_PREVIEW')

BG = '25A'               # screen blue (also the sea, so sea pixels are free)
EW, EH = 144, 88         # emblem
CX, CY = 72.0, 44.0      # oval centre
RX, RY = 70.0, 43.5
HORIZON = 50


def c12(s):
    return tuple(int(ch, 16) * 17 for ch in s)


def inside(x, y, shrink=0.0):
    dx, dy = (x + 0.5 - CX) / (RX - shrink), (y + 0.5 - CY) / (RY - shrink)
    return dx * dx + dy * dy <= 1.0


def emblem():
    img = Image.new('RGB', (EW, EH), c12(BG))
    p = img.load()
    # sky: deep blue at the top to a peach glow at the horizon, dithered
    sky = [(0, '39E'), (10, '5AF'), (19, '7BF'), (27, '9CF'), (34, 'CCE'), (40, 'FCB'), (45, 'FB9')]
    def sky_col(x, y):
        col = sky[0][1]
        for i, (y0, c) in enumerate(sky):
            if y >= y0:
                col = c
                nxt = sky[i + 1] if i + 1 < len(sky) else None
                if nxt and nxt[0] - y <= 2 and (x + y) % 2 == 0:
                    col = nxt[1]
        return col
    for y in range(EH):
        for x in range(EW):
            if y < HORIZON:
                p[x, y] = c12(sky_col(x, y))
    # a few clouds, lit pink from below by the sunset
    scratch = Image.new('RGB', (256, 88), (1, 2, 3))
    pano.cloud_field(scratch, 5, [(26, 30, 22, 9), (112, 24, 26, 10), (70, 12, 16, 6)],
                     'FFF', 'FDE', 'DBD', 'DBD')
    sp = scratch.load()
    for y in range(HORIZON):
        for x in range(EW):
            if sp[x, y] != (1, 2, 3):
                p[x, y] = sp[x, y]
    # the setting sun, half under the horizon, with heat bands
    sx, sr = 72, 17
    for y in range(HORIZON - sr, HORIZON):
        for x in range(sx - sr, sx + sr + 1):
            d = math.hypot(x - sx, (y - HORIZON + 0.5) * 1.05)
            if d <= sr:
                band = (HORIZON - y) in (4, 5, 9, 10) if y > HORIZON - 12 else False
                col = 'FF8' if d < sr - 2.5 else 'FD5'
                if band:
                    col = 'FB9'
                p[x, y] = c12(col)
    # sea: the screen blue, with the sun's reflection and a few glints
    rnd = random.Random(7)
    for y in range(HORIZON, 62):
        for x in range(EW):
            p[x, y] = c12(BG)
        w = int(17 - (y - HORIZON) * 0.4)
        for x in range(sx - w, sx + w + 1):
            if (x // 2 + y) % 3 == 0 or (y - HORIZON) < 2:
                p[x, y] = c12('FD5' if abs(x - sx) < w - 4 else 'FB9')
        for k in range(5):
            gx = rnd.randrange(EW)
            if abs(gx - sx) > 22:
                for g in range(rnd.choice([2, 3, 4])):
                    if gx + g < EW:
                        p[gx + g, y] = c12('8CF')
    # beach
    for y in range(62, EH):
        for x in range(EW):
            col = 'FDA'
            if y < 64:
                col = 'FFF' if (x * 3 + y) % 7 < 3 else 'FDA'      # surf line
            p[x, y] = c12(col)
    # the road, from the bottom edge to the sun on the horizon
    for y in range(HORIZON, EH):
        t = (y - HORIZON) / float(EH - HORIZON)
        half = 1.5 + t * 44
        for x in range(int(sx - half - 1), int(sx + half + 2)):
            if not 0 <= x < EW:
                continue
            d = abs(x + 0.5 - sx)
            if d > half:
                continue
            col = '99A'
            if d > half - 1 - t * 2.5:
                col = 'FFF'                                          # kerb
            elif d < 0.6 + t * 1.2 and int(t * 22) % 2 == 0:
                col = 'FFF'                                          # centre dashes
            p[x, y] = c12(col)
    # oval: white rim with a thin light-blue inner line; outside = screen blue
    for y in range(EH):
        for x in range(EW):
            if not inside(x, y):
                p[x, y] = c12(BG)
            elif not inside(x, y, 2.6):
                p[x, y] = c12('FFF')
    return img


# ---------------------------------------------------------------- SCR1 layer
KEY = (255, 0, 255)       # transparent on SCR1


def palm(p):
    """a leaning palm on the left of the emblem (SCR1 coordinates)"""
    def put(x, y, col):
        x, y = int(round(x)), int(round(y))
        if 0 <= x < 160 and 0 <= y < 88:
            p[x, y] = c12(col)
    # trunk: a curve from the sand up and to the right
    base, top = (24.0, 86.0), (38.0, 20.0)
    ctrl = (14.0, 46.0)
    pts = []
    for i in range(160):
        t = i / 159.0
        x = (1 - t) ** 2 * base[0] + 2 * (1 - t) * t * ctrl[0] + t * t * top[0]
        y = (1 - t) ** 2 * base[1] + 2 * (1 - t) * t * ctrl[1] + t * t * top[1]
        pts.append((x, y, t))
    for x, y, t in pts:
        w = 3.4 - 1.4 * t
        ring = int(y) % 4 == 0
        for dx in range(-4, 5):
            if abs(dx) <= w:
                col = '963'
                if dx < -w + 1.5:
                    col = '421'
                elif dx > w - 1.2:
                    col = 'C96'
                elif ring:
                    col = '742'
                put(x + dx, y, col)
    # fronds: arcs from the crown, a dark spine and light leaflets
    cx, cy = top
    fr = [(-2.7, 30, 0.9), (-2.2, 28, 0.6), (-1.6, 24, 0.3), (-0.9, 20, 0.1),
          (-0.3, 22, 0.2), (0.25, 28, 0.55), (0.7, 30, 0.9), (1.2, 24, 1.1)]
    for ang, ln, droop in fr:
        for i in range(int(ln * 1.6)):
            s = i / (ln * 1.6)
            a = ang + droop * s * s * (1 if math.cos(ang) >= 0 else -1) * 1.0
            x = cx + math.cos(ang) * ln * s
            y = cy + math.sin(ang) * ln * s * 0.8 + droop * 16 * s * s
            put(x, y, '163')
            leaf = (1 - s) * 4 + 1
            for k in range(1, int(leaf) + 1):
                lx, ly = x - math.sin(ang) * k * 0.6, y + k
                put(lx, ly, '2A4' if k < leaf - 1 else '7D5')
                put(x + math.sin(ang) * k * 0.4, y - k * 0.5, '2A4')
    # coconuts
    for dx, dy in ((-2, 2), (1, 3), (3, 1)):
        put(cx + dx, cy + dy, '531')
        put(cx + dx + 1, cy + dy, '742')


def lettering(p):
    """SUNSET / RUN: the dash font at 2x, slanted, outlined, sunset fill"""
    s = open(os.path.join(OUT, 'font_overrev_dash', 'overrev_dash_font.h')).read()
    t = parse_c_array(s, 'overrev_dash_tiles')
    def glyph(ch):
        words = t[(ord(ch) - 32) * 8:(ord(ch) - 32) * 8 + 8]
        return [[(w >> (14 - 2 * x)) & 3 for x in range(8)] for w in words]
    mask = {}
    def text(word, x0, y0):
        for i, ch in enumerate(word):
            g = glyph(ch)
            for y in range(8):
                for x in range(8):
                    if g[y][x]:
                        for dy in range(2):
                            for dx in range(2):
                                Y = y0 + y * 2 + dy
                                X = x0 + i * 15 + x * 2 + dx + (16 - (y * 2 + dy)) // 3   # slant
                                mask[(X, Y)] = Y
    text('SUNSET', 44, 8)
    text('RUN', 76, 28)
    fill = [(0, 'FF7'), (12, 'FD4'), (16, 'FA3'), (20, 'F73'), (28, 'FF7'), (32, 'FD4'), (36, 'FA3'), (40, 'F73')]
    def fcol(y):
        c = fill[0][1]
        for y0, cc in fill:
            if y >= y0:
                c = cc
        return c
    # outline + drop shadow first
    for (X, Y) in list(mask):
        for dy in (-1, 0, 1, 2):
            for dx in (-1, 0, 1, 2):
                q = (X + dx, Y + dy)
                if q not in mask and 0 <= q[0] < 160 and 0 <= q[1] < 88:
                    p[q] = c12('013')
    for (X, Y), _ in mask.items():
        if 0 <= X < 160:
            col = fcol(Y)
            if (X, Y - 1) not in mask:
                col = 'FFF'
            p[X, Y] = c12(col)


def overlay():
    img = Image.new('RGB', (160, 88), KEY)
    p = img.load()
    palm(p)
    lettering(p)
    return img


def arrows():
    up = ["...3....", "..333...", ".33333..", "3333333.", "..333...", "..333...", "..111...", "........"]
    dn = ["..333...", "..333...", "3333333.", ".33333..", "..333...", "...3....", "...1....", "........"]
    return [pixels_to_words([[int(c) if c != '.' else 0 for c in r] for r in g]) for g in (up, dn)]


def carray(t, name, vals, per=16):
    out = ['const %s %s[%d] = {' % (t, name, len(vals))]
    for i in range(0, len(vals), per):
        out.append('    ' + ', '.join(('0x%04X' % v) if t == 'u16' else str(v) for v in vals[i:i + per]) + ',')
    out.append('};')
    return '\n'.join(out)


def main():
    em = emblem()
    ov = overlay()
    e = convert_plane(em, c12(BG), max_pals=13)
    o = convert_plane(ov, KEY, max_pals=8)
    # one character pool: emblem first, then the overlay, then two arrows
    tiles = [list(w) for w in e['tiles']]
    obase = len(tiles)
    tiles += [list(w) for w in o['tiles'] if any(w)] if False else [list(w) for w in o['tiles']]
    abase = len(tiles)
    tiles += [list(w) for w in arrows()]
    print('title: emblem %d tiles, overlay %d tiles, total %d' % (obase, abase - obase, len(tiles)))
    # tile 0 of each converted plane may be blank: map blank cells to 0xFFFF (= character 0)
    def blank(words):
        return not any(words)
    emap = [0xFFFF if blank(e['tiles'][m]) else m for m in e['map']]
    omap = [0xFFFF if blank(o['tiles'][m]) else obase + m for m in o['map']]
    h = ['/* Generated by tools/gen_title.py -- do not edit. */', '#ifndef GFX_TITLE_H', '#define GFX_TITLE_H',
         '#include "ngpc_types.h"',
         '#define GFX_TITLE_TILES %d' % len(tiles), '#define GFX_TITLE_ARROW_UP %d' % abase,
         '#define GFX_TITLE_ARROW_DN %d' % (abase + 1), '#define GFX_TITLE_BG 0x%04X' % to12(c12(BG)),
         '#define GFX_EMBLEM_W 18', '#define GFX_EMBLEM_H 11', '#define GFX_OVER_W 20', '#define GFX_OVER_H 11',
         'extern const u16 gfx_title_tiles[];', 'extern const u16 gfx_emblem_map[];', 'extern const u8 gfx_emblem_pal[];',
         'extern const u16 gfx_emblem_pals[];', 'extern const u16 gfx_over_map[];', 'extern const u8 gfx_over_pal[];',
         'extern const u16 gfx_over_pals[];', '#endif', '']
    c = ['/* Generated by tools/gen_title.py -- do not edit. */', '#include "gfx_title.h"',
         carray('u16', 'gfx_title_tiles', [w for tl in tiles for w in tl], 8),
         carray('u16', 'gfx_emblem_map', emap, 18), carray('u8', 'gfx_emblem_pal', e['map_pal'], 18),
         carray('u16', 'gfx_emblem_pals', [v for pl in e['palettes'] for v in pl], 4),
         carray('u16', 'gfx_over_map', omap, 20), carray('u8', 'gfx_over_pal', o['map_pal'], 20),
         carray('u16', 'gfx_over_pals', [v for pl in o['palettes'] for v in pl], 4), '']
    open(os.path.join(OUT, 'gfx_title.h'), 'w').write('\n'.join(h))
    open(os.path.join(OUT, 'gfx_title.c'), 'w').write('\n'.join(c))
    if PREVIEW:
        scr = Image.new('RGB', (160, 152), c12(BG))
        scr.paste(em, (8, 0))
        ovp = ov.load()
        sp = scr.load()
        for y in range(88):
            for x in range(160):
                if ovp[x, y] != KEY:
                    sp[x, y] = ovp[x, y]
        scr.resize((480, 456), Image.NEAREST).save(PREVIEW)


if __name__ == '__main__':
    main()

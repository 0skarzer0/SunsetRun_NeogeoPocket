#!/usr/bin/env python3
"""Course map screen for SUNSET RUN (GraphX/gfx_map.c/h).

Shown at the end of a race: the route pyramid seen from above on a sandy
coast, a thumbnail of each leg's scenery and a small red car driving the
route that was taken.  Stages run left to right; at the end of every leg the
road forks up (LEFT) or down (RIGHT).

  * SCR2: the map (sand, sea, roads, the goal flags A..E)
  * sprites: 15 scenery thumbnails (16x16, one palette each) and the car
The thumbnails are drawn from the panoramas, so they match the scenes; main.c
places them by leg, which follows the FREE mode shuffle too.
"""
import os, sys
from PIL import Image, ImageDraw

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pano
from conv import convert_plane
from ngpgfx import pixels_to_words, to12

OUT = sys.argv[1] if len(sys.argv) > 1 else 'GraphX'
PREVIEW = os.environ.get('MAP_PREVIEW')
THEME_ORDER = ['beach', 'coast', 'alps', 'city', 'desert', 'fields', 'autumn', 'caves', 'snow', 'farm',
               'autobahn', 'canyon', 'lake', 'seaside', 'ruins']   # = gen_course.py
SAND = 'EA6'

# geometry (shared with main.c through the header)
X0, DX, SEG = 6, 30, 16         # stage s: road from X0+s*DX to +SEG, then the fork
YC, DY = 86, 24                 # leg (s, b): y = YC + (b - s/2) * DY


def c12(s):
    return tuple(int(ch, 16) * 17 for ch in s)


def leg_xy(s, b):
    return X0 + s * DX, YC + (b * 2 - s) * DY // 2


def background():
    img = Image.new('RGB', (160, 152), c12(SAND))
    d = ImageDraw.Draw(img)
    p = img.load()
    # sea in the top-left corner, with surf
    for y in range(0, 60):
        for x in range(0, 70):
            edge = 58 - y * 0.9 - 6 * ((x // 6) % 2)
            if x < edge:
                col = '26C'
                if x > edge - 3:
                    col = 'FFF'
                elif x > edge - 5:
                    col = '8CF'
                elif (x * 3 + y * 7) % 23 == 0 or ((x + y * 2) % 19 == 0 and y % 5 == 0):
                    col = 'BEF'
                p[x, y] = c12(col)
    # a few dunes and shrubs on the sand
    for (x, y) in ((96, 22), (130, 18), (20, 140), (64, 146), (150, 140), (112, 146)):
        d.ellipse([x - 5, y - 2, x + 5, y + 2], fill=c12('DA5'))
        d.point([(x - 1, y - 3), (x + 2, y - 3)], fill=c12('6A3'))
    road, dash = c12('424'), c12('FFF')
    # roads: each leg, then the fork to the two legs of the next stage
    for s in range(5):
        for b in range(s + 1):
            x, y = leg_xy(s, b)
            d.rectangle([x - 2, y - 3, x + SEG + 2, y + 3], fill=road)
            if s < 4:
                for nb in (b, b + 1):
                    nx, ny = leg_xy(s + 1, nb)
                    d.line([x + SEG, y, nx, ny], fill=road, width=6)
            else:
                # run-out to the goal flag
                d.rectangle([x + SEG, y - 3, x + SEG + 6, y + 3], fill=road)
    for s in range(5):
        for b in range(s + 1):
            x, y = leg_xy(s, b)
            for k in range(x, x + SEG, 4):
                d.line([k, y, k + 1, y], fill=dash)
    # start: a short run-in from the left edge
    x, y = leg_xy(0, 0)
    d.rectangle([0, y - 3, x, y + 3], fill=road)
    for k in range(0, x, 4):
        d.line([k, y, k + 1, y], fill=dash)
    # goal flags A..E
    for b in range(5):
        x, y = leg_xy(4, b)
        gx = x + SEG + 7
        d.rectangle([gx, y - 7, gx + 10, y + 5], fill=c12('FFF'))
        d.rectangle([gx + 1, y - 6, gx + 9, y + 4], fill=c12('E37'))
        letter(p, gx + 2, y - 5, 'ABCDE'[b])
    return img


FONT = {   # 7x9 letters for the goal flags
    'A': ['.111.', '1...1', '1...1', '11111', '1...1', '1...1', '1...1'],
    'B': ['1111.', '1...1', '1111.', '1...1', '1...1', '1...1', '1111.'],
    'C': ['.1111', '1....', '1....', '1....', '1....', '1....', '.1111'],
    'D': ['1111.', '1...1', '1...1', '1...1', '1...1', '1...1', '1111.'],
    'E': ['11111', '1....', '1111.', '1....', '1....', '1....', '11111'],
}


def letter(p, x, y, ch):
    for j, row in enumerate(FONT[ch]):
        for i, c in enumerate(row):
            if c == '1':
                p[x + i + 1, y + j + 1] = c12('FFF')


def thumbnail(name):
    """16x16 vignette of a scene (3 colours): its panorama squeezed over its
    ground, framed with the darkest of the three"""
    img, bd = pano.THEMES[name]()
    img = pano.finish(img, bd)
    crop = img.crop((0, 26, 112, 88)).resize((14, 10), Image.BOX)
    t = Image.new('RGB', (14, 14), bd)
    t.paste(crop, (0, 0))
    q = t.quantize(colors=3, method=Image.MAXCOVERAGE, dither=Image.NONE).convert('RGB')
    q = Image.eval(q, lambda v: round(v / 17) * 17)
    cols = sorted(set(q.get_flattened_data() if hasattr(q, 'get_flattened_data') else q.getdata()),
                  key=lambda c: sum(c))
    out = Image.new('RGB', (16, 16), cols[0])
    out.paste(q, (1, 1))
    return out


def sprite_words(img, cols):
    """16x16 image -> 4 tiles (TL, TR, BL, BR) with the given 3 colours"""
    px = img.load()
    def idx(c):
        return min(range(3), key=lambda i: sum((a - b) ** 2 for a, b in zip(c, cols[i]))) + 1
    tiles = []
    for ty in range(2):
        for tx in range(2):
            tiles.append(pixels_to_words([[idx(px[tx * 8 + x, ty * 8 + y]) for x in range(8)] for y in range(8)]))
    return tiles


CAR = ['..11.....11.....',
       '.2222222222222..',
       '222333222233222.',
       '2223332222332222',
       '2223332222332222',
       '222333222233222.',
       '.2222222222222..',
       '..11.....11.....']


def carray(t, name, vals, per=16):
    out = ['const %s %s[%d] = {' % (t, name, len(vals))]
    for i in range(0, len(vals), per):
        out.append('    ' + ', '.join(('0x%04X' % v) if t == 'u16' else str(v) for v in vals[i:i + per]) + ',')
    out.append('};')
    return '\n'.join(out)


def main():
    bg = background()
    m = convert_plane(bg, c12(SAND), max_pals=8)
    thumbs, tw, tpal = [], [], []
    for name in THEME_ORDER:
        t = thumbnail(name)
        cols = sorted(set(t.get_flattened_data() if hasattr(t, 'get_flattened_data') else t.getdata()),
                      key=lambda c: sum(c))
        while len(cols) < 3:
            cols.append(cols[-1])
        tw += sprite_words(t, cols)
        tpal.append([0] + [to12(c) for c in cols])
        thumbs.append(t)
    car = [pixels_to_words([[int(c) if c != '.' else 0 for c in r[h * 8:h * 8 + 8]] for r in CAR]) for h in (0, 1)]
    tiles = [list(w) for w in m['tiles']]
    tbase = len(tiles)
    tiles += [list(w) for w in tw]
    cbase = len(tiles)
    tiles += [list(w) for w in car]
    print('map: %d background + %d thumbnail + 2 car tiles' % (tbase, len(tw)))
    bmap = [0xFFFF if not any(m['tiles'][v]) else v for v in m['map']]
    h = ['/* Generated by tools/gen_map.py -- do not edit. */', '#ifndef GFX_MAP_H', '#define GFX_MAP_H',
         '#include "ngpc_types.h"', '#define GFX_MAP_TILES %d' % len(tiles),
         '#define GFX_MAP_THUMB0 %d' % tbase, '#define GFX_MAP_CAR %d' % cbase,
         '#define GFX_MAP_BG 0x%04X' % to12(c12(SAND)),
         '#define MAP_X0 %d' % X0, '#define MAP_DX %d' % DX, '#define MAP_SEG %d' % SEG,
         '#define MAP_YC %d' % YC, '#define MAP_DY %d' % DY,
         'extern const u16 gfx_map_tiles[];', 'extern const u16 gfx_map_map[];', 'extern const u8 gfx_map_pal[];',
         'extern const u16 gfx_map_pals[];', 'extern const u16 gfx_map_thumb_pals[];',
         'extern const u16 gfx_map_car_pal[4];', '#endif', '']
    c = ['/* Generated by tools/gen_map.py -- do not edit. */', '#include "gfx_map.h"',
         carray('u16', 'gfx_map_tiles', [w for t in tiles for w in t], 8),
         carray('u16', 'gfx_map_map', bmap, 20), carray('u8', 'gfx_map_pal', m['map_pal'], 20),
         carray('u16', 'gfx_map_pals', [v for pl in m['palettes'] for v in pl], 4),
         carray('u16', 'gfx_map_thumb_pals', [v for pl in tpal for v in pl], 4),
         carray('u16', 'gfx_map_car_pal', [0, to12(c12('111')), to12(c12('E21')), to12(c12('BEF'))], 4), '']
    open(os.path.join(OUT, 'gfx_map.h'), 'w').write('\n'.join(h))
    open(os.path.join(OUT, 'gfx_map.c'), 'w').write('\n'.join(c))
    if PREVIEW:
        scr = bg.copy()
        k = 0
        for s in range(5):
            for b in range(s + 1):
                x, y = leg_xy(s, b)
                scr.paste(thumbs[k], (x, y - 8))
                k += 1
        scr.resize((480, 456), Image.NEAREST).save(PREVIEW)


if __name__ == '__main__':
    main()

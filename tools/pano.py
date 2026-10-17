"""Procedural panoramas (256 x 88, horizontally seamless) for SUNSET RUN.

Second art pass.  The look borrows the language of the mid-80s arcade road
movies: pastel skies with dithered gradients, a towering bank of cumulus on
the sea horizon, mountains drawn with vertical light/shade strokes, round
autumn canopies, lakes with green islets, a dusk sky over an old town.
Everything is generated here; no artwork is copied.

All detail repeats every PERIOD pixels so that identical 8x8 tiles can be
shared (the NGPC has 512 characters for everything on screen).

Every theme returns (image, backdrop colour).  The backdrop is the ground
colour seen beside the road; pixels of that colour become transparent.
The bottom row (y = 87) is the horizon: the road vanishes there.
"""
import math, random
from PIL import Image, ImageDraw

W, H = 256, 88
HORIZON = 88          # ground starts at the road plane, right below the art
PERIOD = 128


def c12(s):
    """'RGB' hex (4 bits each) -> 8-bit tuple"""
    return tuple(int(ch, 16) * 17 for ch in s)


def px(img, x, y, col):
    if 0 <= y < H:
        img.putpixel((x % W, y), c12(col))


def band_sky(img, cols, y0, y1):
    """vertical gradient through the colour list, checker-dithered seams"""
    n = len(cols)
    for y in range(y1, H):               # below the gradient: last colour
        for x in range(W):
            img.putpixel((x, y), c12(cols[-1]))
    hh = (y1 - y0) / float(n)
    for i, c in enumerate(cols):
        a, b = int(y0 + i * hh), int(y0 + (i + 1) * hh)
        for y in range(a, b):
            for x in range(W):
                img.putpixel((x, y), c12(c))
        if i + 1 < n:
            for y in (b - 3, b - 2, b - 1):
                step = 2 if y == b - 1 else 4
                for x in range(W):
                    if (x + (y & 1) * (step // 2)) % step == 0:
                        img.putpixel((x, y), c12(cols[i + 1]))


def wave(seed, base, amp, octaves=((128, 1.0), (64, 0.5), (32, 0.28), (16, 0.12))):
    """height field periodic in PERIOD (all octave periods divide it)"""
    rnd = random.Random(seed)
    ph = [(rnd.random() * 6.283, p, a) for p, a in octaves]
    return [base - amp * sum(a * math.sin(2 * math.pi * x / p + f) for f, p, a in ph) for x in range(W)]


def stroke_ridge(img, heights, dark, mid, light, bottom, snow=None, snow_depth=0, seed=0):
    """mountains with vertical light/shade strokes: slopes facing left are lit,
    slopes facing right are in shade, with streaks running down the faces"""
    rnd = random.Random(seed)
    streak = [rnd.random() for _ in range(32)]
    for x in range(W):
        top = int(round(heights[x]))
        slope = heights[(x + 1) % W] - heights[(x - 1) % W]
        s = streak[x % 32]
        for y in range(max(0, top), bottom):
            d = y - top
            if slope > 0.35:
                col = light if (d < 10 + s * 18 and (x + d // 3) % 3 != 0) else mid
            elif slope < -0.35:
                col = dark if (d < 6 + s * 14 or (x + d // 2) % 4 == 0) else mid
            else:
                col = light if d < 2 else (dark if s < 0.22 else mid)
            if snow and d < snow_depth + int(s * 4) and top < bottom - 18:
                col = snow if slope >= -0.35 or d < 2 else light
            img.putpixel((x, y), c12(col))


def cumulus(img, base, top, seed, white, shade, deep=None, count=14):
    """a bank of towering cumulus sitting on y = base, periodic in PERIOD:
    one silhouette (union of round puffs), lit from above, shaded below"""
    rnd = random.Random(seed)
    blobs = []
    for i in range(count):
        cx = rnd.randrange(PERIOD)
        r = rnd.randrange(7, 16)
        lift = (base - top - 2 * r) * (0.35 + 0.65 * math.sin(math.pi * cx / PERIOD) ** 2) * rnd.random()
        blobs.append((cx, base - r * 0.7 - lift, r))
    def inside(x, y):
        for cx, cy, r in blobs:
            dx = min((x - cx) % PERIOD, (cx - x) % PERIOD)
            if dx * dx + ((y - cy) * 1.15) ** 2 <= r * r:
                return True
        return False
    mask = [[inside(x, y) for x in range(PERIOD)] for y in range(H)]
    for y in range(top, base + 1):
        for u in range(PERIOD):
            if not mask[y][u]:
                continue
            up = mask[y - 2][u] if y >= 2 else False
            lower = (base - y) < 6
            col = white
            # shade the undersides of each puff and the flat base
            if lower or (not mask[min(H - 1, y + 3)][u]):
                col = shade
            if up and not mask[y - 1][(u + 2) % PERIOD]:
                col = shade
            if deep and (base - y) < 2:
                col = deep
            for rep in range(0, W, PERIOD):
                img.putpixel((u + rep, y), c12(col))


def cloud_field(img, seed, clouds, white, light, shade, deep):
    """separate cauliflower cumulus (periodic in PERIOD).
    clouds: list of (centre x, base y, width, height).  Each cloud is a dome
    of small round puffs: lit tops, a shaded rim under every puff (so the
    lobes read separately), a flat shadowed base and sky all around."""
    rnd = random.Random(seed)
    for cx0, base, w, h in clouds:
        puffs_ = []
        # dome outline: puffs along an arch, then a few inner ones
        n = max(4, w // 5)
        for i in range(n):
            t = i / (n - 1.0)
            r = rnd.uniform(3.2, 5.2) + 1.5 * math.sin(math.pi * t)
            top = base - 2 - (h - 2) * math.sin(math.pi * t) ** 0.7
            puffs_.append((cx0 - w / 2.0 + t * w, top + r, r))
        for i in range(n // 2):
            t = rnd.uniform(0.25, 0.75)
            r = rnd.uniform(4.0, 6.0)
            top = base - 2 - (h - 2) * math.sin(math.pi * t) ** 0.7
            puffs_.append((cx0 - w / 2.0 + t * w, top + r + rnd.uniform(2, 5), r))
        # fill under the arch so the cloud is solid down to its base
        def owner(x, y):
            if y > base:
                return -1
            best = -1
            for k, (pcx, pcy, r) in enumerate(puffs_):
                dx = x - pcx
                if dx * dx + (y - pcy) ** 2 <= r * r:
                    best = k
            if best < 0:
                # body: between the outer puffs and below their centres
                if cx0 - w / 2.0 <= x <= cx0 + w / 2.0:
                    t = (x - (cx0 - w / 2.0)) / float(w)
                    top = base - 2 - (h - 2) * math.sin(math.pi * t) ** 0.7
                    if y >= top + 4:
                        return len(puffs_)
            return best
        x0, x1 = int(cx0 - w / 2 - 8), int(cx0 + w / 2 + 8)
        for y in range(max(0, base - h - 2), base + 1):
            for x in range(x0, x1):
                k = owner(x, y)
                if k < 0:
                    continue
                if k == len(puffs_):
                    col = light
                else:
                    pcx, pcy, r = puffs_[k]
                    nx, ny = (x - pcx) / r, (y - pcy) / r
                    lum = -0.45 * nx - 0.9 * ny
                    col = white if lum > -0.1 else light
                    # rim: the lower edge of each puff over the one behind
                    kb = owner(x, y + 1)
                    if ny > 0.55 and kb != k:
                        col = shade
                if base - y < 3:
                    col = shade if base - y else deep
                elif base - y < 5 and (x + y) % 2 == 0:
                    col = shade
                px(img, x, y, col)
                if PERIOD < W:
                    px(img, x + PERIOD, y, col)


def puffs(img, seed, y0, y1, n, white, shade):
    """small fair-weather clouds (periodic)"""
    rnd = random.Random(seed)
    for i in range(n):
        cx, cy = rnd.randrange(PERIOD), rnd.randrange(y0, y1)
        w = rnd.randrange(10, 22)
        for x in range(cx - w, cx + w + 1):
            for y in range(cy - 6, cy + 3):
                k = (x - cx) / float(w)
                hgt = 5 * (1 - k * k) * (0.7 + 0.3 * math.cos(x * 0.9))
                if cy - hgt <= y <= cy + 1 and abs(k) <= 1:
                    col = shade if y >= cy else white
                    for rep in range(0, W, PERIOD):
                        px(img, x + rep, y, col)


def sea(img, y0, y1, col, glint, glint2=None):
    for y in range(y0, y1):
        for x in range(W):
            img.putpixel((x, y), c12(col))
            u = x % 16                          # tile-periodic sparkle
            if (u * 7 + y * 13) % 17 == 0 or (glint2 and (u * 5 + y * 3) % 23 == 0):
                img.putpixel((x, y), c12(glint if (x + y) % 2 else (glint2 or glint)))


def sail(img, x, base, h, col, mast):
    for i in range(h):
        for k in range(i // 2 + 1):
            px(img, x + k, base - h + i, col)
        px(img, x - 1, base - h + i, mast)


def islet(img, cx, base, w, h, col, light):
    for x in range(cx - w, cx + w + 1):
        k = (x - cx) / float(w)
        top = base - int(h * (1 - k * k) ** 0.7)
        for y in range(top, base):
            px(img, x, y, light if (y - top < 2 and k < 0.2) else col)


HUD_ROWS = 16         # behind the HUD: one flat sky colour


def finish(img, backdrop):
    """quantise to the 12-bit colour grid; the strip behind the HUD becomes
    the plain top sky colour (dithered into the art below it)"""
    from collections import Counter
    p = img.load()
    top = Counter(p[x, 0] for x in range(W)).most_common(1)[0][0]
    for y in range(HUD_ROWS + 2):
        for x in range(W):
            if y < HUD_ROWS or (x + y) % 2 == 0 and y == HUD_ROWS or (x + y) % 4 == 0:
                p[x, y] = top
    for y in range(H):
        for x in range(W):
            r, g, b = p[x, y]
            p[x, y] = (round(r / 17) * 17, round(g / 17) * 17, round(b / 17) * 17)
    return img

# ======================================================================= themes

def theme_beach():
    """azure sky, a towering cumulus bank on the sea, islets and sails"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['18E', '2AF', '4BF', '7CF'], 0, 80)
    # separate towering clouds over the sea, with sky between them
    cloud_field(img, 11, [(14, 79, 34, 30), (58, 79, 24, 19), (101, 79, 36, 40)],
                'FFF', 'DEF', 'ACE', '9BD')
    cloud_field(img, 13, [(40, 36, 22, 10), (80, 18, 18, 8), (124, 46, 14, 7)],
                'FFF', 'DEF', 'ACE', 'ACE')
    for rep in (0, PERIOD):
        islet(img, 36 + rep, 80, 13, 5, '2A5', '2A5')
        islet(img, 98 + rep, 80, 7, 3, '2A5', '2A5')
    sea(img, 80, 87, '07B', '4CF', 'FFF')
    for x, c in ((60, 'F4A'), (75, 'F4A'), (118, 'F4A')):
        for rep in (0, PERIOD):
            sail(img, x + rep, 85, 6, c, 'FFF')
    for x in range(W):
        img.putpixel((x, 87), c12('FDB'))
    return img, c12('FDB')


def theme_coast():
    """turquoise ranges under puffy clouds"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['27E', '39F', '5BF', '9DF'], 0, 70)
    puffs(img, 21, 10, 40, 6, 'FFF', 'BDF')
    stroke_ridge(img, wave(22, 58, 12, ((64, 1.0), (32, 0.4), (16, 0.15))), '088', '1BA', '7EE', 88, seed=2)
    hills = wave(23, 76, 4, ((64, 1), (32, .4)))
    for x in range(W):
        for y in range(int(hills[x]), 88):
            img.putpixel((x, y), c12('2A6' if (y - int(hills[x])) > 1 else '6D9'))
    return img, c12('9C6')


def theme_fields():
    """teal-to-pink sky, creamy clouds, green hills, windmills, wheat strips"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['3BD', '8DD', 'DDC', 'FCC'], 0, 74)
    puffs(img, 31, 14, 44, 6, 'FFE', 'EDA')
    stroke_ridge(img, wave(32, 70, 6, ((128, 1), (64, .5), (32, .2))), '483', '6A5', '9C7', 88, seed=4)
    d = ImageDraw.Draw(img)
    for base_x in (30, 92):
        for rep in (0, PERIOD):
            x = base_x + rep
            d.rectangle([x, 64, x + 3, 76], fill=c12('EEE'))
            d.polygon([(x - 1, 64), (x + 1, 60), (x + 4, 64)], fill=c12('864'))
            for a in (0.4, 2.0, 3.5, 5.1):
                for r in range(2, 9):
                    px(img, int(x + 1.5 + r * math.cos(a)), int(62 - r * math.sin(a)), 'FFF')
    for y in range(78, 88):
        for x in range(W):
            band = ((x // 16) + (y - 78) // 4) % 2
            img.putpixel((x, y), c12('ED8' if band else 'BC5'))
    return img, c12('AD7')


def theme_desert():
    """peach sky, tan mesas with mauve shading strokes"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['5AE', '9BD', 'ECB', 'FDA'], 0, 76)
    mesa = []
    for x in range(W):
        u = x % PERIOD
        if 10 <= u < 44:
            y = 52 + (0 if 14 <= u < 40 else 6)
        elif 64 <= u < 90:
            y = 60 + (0 if 68 <= u < 86 else 5)
        elif 100 <= u < 116:
            y = 66
        else:
            y = 74 + 2 * math.sin(u / 7.0)
        mesa.append(y)
    stroke_ridge(img, mesa, 'A68', 'DB8', 'FDB', 88, seed=5)
    stroke_ridge(img, wave(34, 80, 3), 'B87', 'DA7', 'EC9', 88, seed=6)
    return img, c12('ECA')


def theme_autumn():
    """lavender sky, golden ridges, a band of orange and yellow canopies"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['86D', 'A8E', 'CAE', 'EDD'], 0, 72)
    puffs(img, 41, 10, 34, 4, 'FEF', 'DCE')
    stroke_ridge(img, wave(42, 58, 9), 'A74', 'DA5', 'FD8', 88, seed=7)
    rnd = random.Random(43)
    for i in range(18):
        cx, r = rnd.randrange(PERIOD), rnd.randrange(4, 8)
        cy = 82 - r
        col, hi = rnd.choice([('D51', 'F93'), ('E82', 'FC4'), ('C62', 'FA4')])
        for x in range(cx - r, cx + r + 1):
            for y in range(cy - r, 88):
                if math.hypot(x - cx, (y - cy) * 1.2) <= r or y >= cy + r // 2:
                    lit = (x - cx) - (y - cy) > r * 0.4
                    for rep in range(0, W, PERIOD):
                        px(img, x + rep, y, hi if lit else col)
    return img, c12('CA6')


def theme_alps():
    """deep blue sky, icy peaks drawn with white and cyan strokes, pine belt"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['15C', '26D', '38E', '7BF'], 0, 70)
    puffs(img, 51, 6, 22, 3, 'FFF', 'CDF')
    peaks = []
    pk = [(12, 24), (40, 32), (58, 40)]
    for x in range(W):
        u = x % 64
        y = 88.0
        for p, hgt in pk:
            dx = min((u - p) % 64, (p - u) % 64)
            y = min(y, hgt + dx * 1.0)
        peaks.append(y)
    stroke_ridge(img, peaks, '59B', '9CE', 'FFF', 88, snow='FFF', snow_depth=12, seed=8)
    for x in range(W):
        u = x % 8
        top = 78 + abs(u - 4) // 1 - (2 if (x // 8) % 3 == 0 else 0)
        for y in range(top, 88):
            img.putpixel((x, y), c12('163' if (x + y) % 5 else '274'))
    return img, c12('9C8')


def theme_city():
    """dusk: violet to gold sky, low sun, an old town of domes and towers"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['53A', '85B', 'C7A', 'F98', 'FC8'], 0, 82)
    d = ImageDraw.Draw(img)
    for rep in (0, PERIOD):
        d.ellipse([rep + 52, 50, rep + 84, 82], fill=c12('FE9'))
        for y in range(62, 82, 4):
            d.rectangle([rep + 50, y, rep + 86, y + 1], fill=c12('F98'))
    rnd = random.Random(61)
    x = 0
    sil = '426'
    while x < PERIOD:
        kind = rnd.choice(['house', 'house', 'tower', 'dome', 'column'])
        w = {'house': rnd.randrange(8, 14), 'tower': 5, 'dome': 14, 'column': 3}[kind]
        for rep in (0, PERIOD):
            X = x + rep
            if kind == 'house':
                h = rnd.randrange(6, 12)
                d.rectangle([X, 87 - h, X + w - 1, 87], fill=c12(sil))
                d.polygon([(X - 1, 87 - h), (X + w // 2, 87 - h - 4), (X + w, 87 - h)], fill=c12(sil))
            elif kind == 'tower':
                d.rectangle([X, 64, X + w - 1, 87], fill=c12(sil))
                d.polygon([(X - 1, 64), (X + 2, 57), (X + w, 64)], fill=c12(sil))
            elif kind == 'dome':
                d.rectangle([X + 1, 76, X + w - 2, 87], fill=c12(sil))
                d.ellipse([X, 68, X + w - 1, 82], fill=c12(sil))
                d.rectangle([X + w // 2 - 1, 64, X + w // 2, 68], fill=c12(sil))
            else:
                d.rectangle([X, 70, X + w - 1, 87], fill=c12(sil))
        x += w + rnd.randrange(1, 5)
    for x in range(0, W, 3):
        for y in range(74, 86, 4):
            if img.getpixel((x, y)) == c12(sil) and (x * 7 + y) % 5 == 0:
                img.putpixel((x, y), c12('FD7'))
    return img, c12('B97')


def theme_lake():
    """lavender evening, a still lake with green islets and reflections"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['76D', '98E', 'BAE', 'DCE'], 0, 70)
    puffs(img, 71, 8, 30, 4, 'FEF', 'CBE')
    stroke_ridge(img, wave(72, 66, 6), '549', '87B', 'BAD', 74, seed=9)
    sea(img, 74, 88, '68B', 'ACE')
    for cx, w, h in ((24, 14, 6), (76, 9, 4), (108, 6, 3)):
        for rep in (0, PERIOD):
            islet(img, cx + rep, 80, w, h, '3A4', '8D6')
            for x in range(cx + rep - w + 2, cx + rep + w - 1, 2):
                px(img, x, 81, '485')
    return img, c12('AC8')



def fore_strip(img, seed, base, amp, col, light, period=64):
    """low foreground hills in front of the far layer (periodic)"""
    h = wave(seed, base, amp, ((period, 1.0), (period // 2, 0.4)))
    for x in range(W):
        top = int(round(h[x]))
        for y in range(top, 88):
            img.putpixel((x, y), c12(light if y - top < 1 else col))


def theme_canyon():
    """a deep canyon: tall striated grey-violet walls under a hot sky"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['E85', 'F96', 'FB8', 'FDA'], 0, 74)
    spires = []
    for x in range(W):
        u = x % 64
        y = 40 + 14 * abs(math.sin(u * math.pi / 64)) + (10 if (u // 8) % 3 == 1 else 0)
        spires.append(y)
    stroke_ridge(img, spires, '545', '878', 'BAA', 88, seed=11)
    fore_strip(img, 12, 80, 3, '966', 'B88')
    return img, c12('C97')


def theme_caves():
    """mountain pass at sunset: a purple-to-orange sky with streaky clouds, a
    far violet range, snow-capped peaks with a lit and a shaded face, pines,
    and rounded rock caves at the foot of the slopes"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['535', '748', 'A57', 'E75', 'F95'], 0, 60)
    # long thin clouds, violet lit orange from below
    for cx, cy, ln in ((74, 17, 22), (108, 27, 24), (56, 38, 16)):
        for k in range(3):
            w = ln - abs(k - 1) * 6
            for x in range(cx - w // 2, cx + w // 2):
                for rep in (0, PERIOD):
                    px(img, x + rep, cy + k, '748' if k < 2 else 'E75')
    p = img.load()
    def ridge(peaks, lit, shade, snow, snow_d, base=88):
        for x in range(W):
            u = x % PERIOD
            best, side = 999.0, 0
            for pk, hgt, sl in peaks:
                dx = (u - pk) % PERIOD
                if dx > PERIOD // 2:
                    dx -= PERIOD
                y = hgt + abs(dx) * sl
                if y < best:
                    best, side = y, dx
            top = int(best)
            for y in range(max(0, top), base):
                d = y - top
                col = lit if side < 0 else shade
                if snow and d < snow_d - abs(side) // 6 + (2 if (x // 8) % 2 else 0):
                    col = snow
                p[x, y] = c12(col)
    # far violet range, then the big peaks
    ridge(((10, 51, 0.8), (62, 49, 0.8), (122, 52, 0.8)), '86A', '86A', None, 0)
    ridge(((30, 16, 1.7), (96, 24, 1.6)), 'A87', '654', 'EEF', 13)
    # a few dark gullies on the shaded faces
    for x0, y0 in ((36, 30), (102, 40)):
        for k in range(14):
            for rep in (0, PERIOD):
                px(img, x0 + k // 4 + rep, y0 + k, '434')
    d = ImageDraw.Draw(img)
    # caves: rounded rock mounds with a dark grey mouth (no black holes)
    for cx in (46, 112):
        for rep in (0, PERIOD):
            X = cx + rep
            d.ellipse([X - 13, 68, X + 13, 98], fill=c12('A87'))
            d.ellipse([X - 6, 75, X + 6, 98], fill=c12('535'))
    # pines along the bottom (in front of the slopes, beside the caves)
    for x0 in range(2, PERIOD, 6):
        if any(abs(x0 - c) < 18 for c in (46, 112)):
            continue
        hgt = 8 + (x0 * 13) % 6
        for rep in (0, PERIOD):
            X = x0 + rep
            for k in range(hgt):
                w = (k * 3) // 5 + 1
                for x in range(X - w // 2, X + w // 2 + 1):
                    px(img, x, 88 - hgt + k, '153')
    return img, c12('8A5')


def theme_snow():
    """winter: pale sky, rounded snowfields, a belt of snowy firs"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['59D', '7BE', 'ADF', 'DEF'], 0, 72)
    puffs(img, 15, 8, 28, 4, 'FFF', 'CDF')
    stroke_ridge(img, wave(16, 54, 10), '9AC', 'DEF', 'FFF', 88, seed=15)
    for x in range(W):
        u = x % 8
        top = 76 + abs(u - 4) - (3 if (x // 8) % 2 == 0 else 0)
        for y in range(top, 88):
            col = 'FFF' if (y - top) < 1 or (y - top) % 4 == 0 and u in (3, 4) else '243'
            img.putpixel((x, y), c12(col))
    return img, c12('EEF')


def theme_farm():
    """golden wheat hills, red barns and haystacks"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['4AE', '7CE', 'BDD', 'FEC'], 0, 72)
    puffs(img, 17, 10, 34, 5, 'FFE', 'EDA')
    hills = wave(18, 70, 6, ((64, 1.0), (32, 0.3)))
    for x in range(W):
        top = int(round(hills[x]))
        for y in range(top, 88):
            band = ((y - top) // 3 + (x // 8)) % 2
            img.putpixel((x, y), c12('EC4' if band else 'CA3'))
    d = ImageDraw.Draw(img)
    for bx in (24,):
        for rep in range(0, W, 64):
            x = bx + rep
            base = int(hills[x % W]) + 4
            d.rectangle([x, base - 10, x + 11, base], fill=c12('B22'))
            d.polygon([(x - 1, base - 10), (x + 6, base - 16), (x + 12, base - 10)], fill=c12('711'))
            d.rectangle([x + 4, base - 6, x + 7, base], fill=c12('FFF'))
    for hx in (46, 54):
        for rep in range(0, W, 64):
            x = hx + rep
            base = int(hills[x % W]) + 6
            d.ellipse([x, base - 6, x + 7, base + 1], fill=c12('DA4'))
    return img, c12('BC6')


def theme_autobahn():
    """overcast plain: forest line, distant towers, pylons"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['679', '8AB', 'ABC', 'CDD'], 0, 76)
    puffs(img, 19, 6, 40, 7, 'EEF', 'BBC')
    d = ImageDraw.Draw(img)
    rnd = random.Random(20)
    x = 0
    while x < PERIOD:
        w, h = rnd.randrange(4, 9), rnd.randrange(8, 22)
        for rep in (0, PERIOD):
            d.rectangle([x + rep, 80 - h, x + rep + w - 1, 80], fill=c12('89A'))
        x += w + rnd.randrange(6, 16)
    for x in range(W):
        u = x % 8
        top = 74 + abs(u - 4) // 2 + (2 if (x // 8) % 2 else 0)
        for y in range(top, 88):
            img.putpixel((x, y), c12('253' if (x + y) % 6 else '364'))
    for px_ in (40, 104):
        for rep in (0, PERIOD):
            X = px_ + rep
            d.line([X, 50, X, 76], fill=c12('556'))
            d.line([X - 5, 54, X + 5, 54], fill=c12('556'))
            d.line([X - 4, 58, X + 4, 58], fill=c12('556'))
    return img, c12('6A5')


def theme_seaside():
    """a white town climbing the hills above a blue bay"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['29E', '4BF', '8DF', 'BEF'], 0, 70)
    puffs(img, 21, 8, 30, 4, 'FFF', 'BDF')
    hills = wave(22, 66, 8, ((128, 1.0), (64, 0.5)))
    for x in range(W):
        for y in range(int(hills[x]), 80):
            img.putpixel((x, y), c12('6A4'))
    d = ImageDraw.Draw(img)
    rnd = random.Random(23)
    for i in range(16):
        hx = rnd.randrange(PERIOD)
        base = int(hills[hx]) + rnd.randrange(3, 12)
        w = rnd.randrange(5, 9)
        for rep in (0, PERIOD):
            X = hx + rep
            d.rectangle([X, base - 5, X + w, min(79, base)], fill=c12('FFF'))
            d.rectangle([X, base - 6, X + w, base - 5], fill=c12('D63'))
            if w > 6:
                img.putpixel(((X + 2) % W, min(79, base - 2)), c12('48C'))
    sea(img, 80, 88, '17C', '6CF', 'FFF')
    return img, c12('DCA')


def theme_ruins():
    """jungle hills, stepped stone temples in the haze"""
    img = Image.new('RGB', (W, H))
    band_sky(img, ['2AA', '5CB', '9DC', 'CEC'], 0, 72)
    puffs(img, 24, 10, 34, 4, 'EFE', 'ACB')
    stroke_ridge(img, wave(25, 64, 7), '252', '394', '7C6', 88, seed=24)
    d = ImageDraw.Draw(img)
    for tx, steps in ((30, 5), (96, 4)):
        for rep in (0, PERIOD):
            X = tx + rep
            for k in range(steps):
                w = 26 - k * 5
                y0 = 82 - (k + 1) * 5
                d.rectangle([X - w // 2, y0, X + w // 2, y0 + 5], fill=c12('A97' if k % 2 else 'CB9'))
                d.line([X - w // 2, y0 + 5, X + w // 2, y0 + 5], fill=c12('765'))
            d.rectangle([X - 3, 82 - steps * 5 - 5, X + 3, 82 - steps * 5], fill=c12('987'))
            d.rectangle([X - 1, 82 - steps * 5 - 3, X + 1, 82 - steps * 5], fill=c12('432'))
    fore_strip(img, 26, 82, 2, '263', '4A5')
    return img, c12('7B5')

THEMES = {
    'beach': theme_beach, 'coast': theme_coast, 'desert': theme_desert, 'alps': theme_alps,
    'city': theme_city, 'fields': theme_fields, 'autumn': theme_autumn, 'lake': theme_lake,
    'canyon': theme_canyon, 'caves': theme_caves, 'snow': theme_snow, 'farm': theme_farm,
    'autobahn': theme_autobahn, 'seaside': theme_seaside, 'ruins': theme_ruins,
}

"""Image -> NGPC tiles/palettes conversion."""
from collections import Counter
from ngpgfx import to12, pixels_to_words

def col_dist(a, b):
    return sum((x - y) ** 2 for x, y in zip(a, b))

def convert_plane(img, backdrop, max_pals=8, tile_limit=None):
    """img: RGB (w,h multiples of 8). Returns dict with tiles (list of 8-word tuples, unique),
    map (tile idx), map_pal (palette idx), palettes (list of [c0..c3] 12-bit), errors."""
    w, h = img.size
    tw, th = w // 8, h // 8
    px = img.load()
    cells = []
    for ty in range(th):
        for tx in range(tw):
            block = [[px[tx * 8 + x, ty * 8 + y][:3] for x in range(8)] for y in range(8)]
            cnt = Counter(c for row in block for c in row if c != backdrop)
            cols = [c for c, _ in cnt.most_common()]
            if len(cols) > 3:
                keep = cols[:3]
                remap = {c: min(keep, key=lambda k: col_dist(k, c)) for c in cols[3:]}
                block = [[remap.get(c, c) for c in row] for row in block]
                cols = keep
            cells.append((block, set(cols)))
    # palette allocation: merge colour sets into <= max_pals groups of <= 3 colours
    weight = Counter()
    for block, cs in cells:
        for row in block:
            for c in row:
                if c != backdrop:
                    weight[c] += 1
    groups = []
    for block, cs in cells:
        fs = frozenset(cs)
        if not any(fs <= g for g in groups):
            groups = [g for g in groups if not g < fs]
            groups.append(fs)
    # greedy merge while union fits
    changed = True
    while changed:
        changed = False
        best = None
        for i in range(len(groups)):
            for j in range(i + 1, len(groups)):
                u = groups[i] | groups[j]
                if len(u) <= 3:
                    score = len(groups[i] & groups[j]) * 10 - len(u)
                    if best is None or score > best[0]:
                        best = (score, i, j)
        if best:
            _, i, j = best
            u = groups[i] | groups[j]
            groups = [g for k, g in enumerate(groups) if k not in (i, j)]
            groups = [g for g in groups if not g <= u]
            groups.append(u)
            changed = True
    def reduce3(cols):
        cols = list(cols)
        if len(cols) <= 3:
            return frozenset(cols)
        # keep 3 colours minimising weighted error
        import itertools
        bestk, beste = None, None
        for keep in itertools.combinations(cols, 3):
            e = sum(weight[c] * min(col_dist(c, k) for k in keep) for c in cols)
            if beste is None or e < beste:
                bestk, beste = keep, e
        return frozenset(bestk)
    while len(groups) > max_pals:
        best = None
        for i in range(len(groups)):
            for j in range(i + 1, len(groups)):
                u = groups[i] | groups[j]
                r = reduce3(u)
                e = sum(weight[c] * min(col_dist(c, k) for k in r) for c in u)
                if best is None or e < best[0]:
                    best = (e, i, j, r)
        _, i, j, r = best
        groups = [g for k, g in enumerate(groups) if k not in (i, j)]
        groups.append(r)
    pals = [set(g) for g in groups]
    assign = [None] * len(cells)
    for i, (block, s) in enumerate(cells):
        def err(p):
            return sum(min(col_dist(c, k) for k in p) * (1 + weight[c]) for c in s) if p else 0
        exact = [pi for pi, p in enumerate(pals) if s <= p]
        assign[i] = exact[0] if exact else min(range(len(pals)), key=lambda pi: err(pals[pi]))
    pal_lists = [sorted(p) for p in pals]
    tiles, tindex, mapv, mapp = [], {}, [], []
    for i, (block, s) in enumerate(cells):
        pl = pal_lists[assign[i]]
        def idx(c):
            if c == backdrop:
                return 0
            if c in pl:
                return pl.index(c) + 1
            return pl.index(min(pl, key=lambda k: col_dist(k, c))) + 1
        words = tuple(pixels_to_words([[idx(c) for c in row] for row in block]))
        if words not in tindex:
            tindex[words] = len(tiles); tiles.append(words)
        mapv.append(tindex[words]); mapp.append(assign[i])
    palettes = []
    for pl in pal_lists:
        palettes.append([to12(backdrop)] + [to12(c) for c in pl] + [0] * (3 - len(pl)))
    while len(palettes) < max_pals:
        palettes.append([to12(backdrop), 0, 0, 0])
    return dict(tiles=tiles, map=mapv, map_pal=mapp, palettes=palettes, w=tw, h=th)

def sprite_tiles(grid, slots):
    """grid: list of strings; slots: string of 3 chars mapped to indices 1..3.
    Returns (cells [(cx,cy,words)], w_cells, h_cells); empty cells skipped."""
    wmax = max(len(r) for r in grid)
    grid = [r.ljust(wmax, '.') for r in grid]
    h = len(grid)
    wc, hc = (wmax + 7) // 8, (h + 7) // 8
    cells = []
    for cy in range(hc):
        for cx in range(wc):
            px = []
            any_ = False
            for y in range(8):
                row = []
                for x in range(8):
                    X, Y = cx * 8 + x, cy * 8 + y
                    ch = grid[Y][X] if Y < h and X < wmax else '.'
                    v = slots.index(ch) + 1 if ch in slots else 0
                    any_ |= v != 0
                    row.append(v)
                px.append(row)
            if any_:
                cells.append((cx, cy, tuple(pixels_to_words(px))))
    return cells, wc, hc

def scale_grid(grid, nw, nh=None):
    """nearest-neighbour downscale of a char grid to width nw (keeps aspect)"""
    wmax = max(len(r) for r in grid)
    grid = [r.ljust(wmax, '.') for r in grid]
    h = len(grid)
    if nh is None:
        nh = max(1, round(h * nw / wmax))
    out = []
    for y in range(nh):
        sy = min(h - 1, int((y + 0.5) * h / nh))
        row = ''
        for x in range(nw):
            sx = min(wmax - 1, int((x + 0.5) * wmax / nw))
            row += grid[sy][sx]
        out.append(row)
    return out

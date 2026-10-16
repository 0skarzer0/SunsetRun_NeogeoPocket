"""NGPC graphics helpers: parse/emit 2bpp tiles, palettes; render maps to PNG."""
import re
from PIL import Image

def rgb12(c):
    """0x0BGR -> (r,g,b) 8-bit"""
    return ((c & 15) * 17, ((c >> 4) & 15) * 17, ((c >> 8) & 15) * 17)

def to12(rgb):
    r, g, b = rgb[:3]
    return (round(r / 17) & 15) | ((round(g / 17) & 15) << 4) | ((round(b / 17) & 15) << 8)

def tile_pixels(words):
    """8 u16 rows -> 8x8 list of indices"""
    out = []
    for w in words:
        out.append([(w >> (14 - 2 * x)) & 3 for x in range(8)])
    return out

def pixels_to_words(px):
    words = []
    for row in px:
        w = 0
        for x in range(8):
            w |= (row[x] & 3) << (14 - 2 * x)
        words.append(w)
    return words

def parse_c_array(text, name):
    m = re.search(name + r'\s*\[[^\]]*\]\s*=\s*\{(.*?)\};', text, re.S)
    return [int(x, 0) for x in re.findall(r'0x[0-9A-Fa-f]+|\b\d+\b', m.group(1))]

def render_map(tiles, mapv, palv, pals, w, h, bg=None):
    img = Image.new('RGB', (w * 8, h * 8))
    for ty in range(h):
        for tx in range(w):
            ch = mapv[ty * w + tx]
            p = palv[ty * w + tx]
            px = tile_pixels(tiles[ch * 8:ch * 8 + 8])
            for y in range(8):
                for x in range(8):
                    i = px[y][x]
                    c = pals[p * 4 + i] if (i or bg is None) else bg
                    img.putpixel((tx * 8 + x, ty * 8 + y), rgb12(c))
    return img

"""Chiptune arrangements of famous public-domain classics for the radio.

The scores are the public-domain piano editions of the Mutopia Project in
music/classical/ (see the LEEME there), read with tools/lyparse.py.  The radio
is Scott Joplin, the King of Ragtime: The Entertainer (1902), Maple Leaf Rag
(1899), Pine Apple Rag (1908) and Peacherine Rag (1901); his slow "Solace"
(1909) plays on the game over and results screens.

Each piano score becomes the console's four voices: the lead is the top line
of the right hand (a held note stays until something higher replaces it),
the bass is the lowest line of the left hand (the ragtime oom-pah comes out
of it), the harmony voice plays the tops of the left-hand chords (in a race
the engine note takes that channel), and the noise channel gets a polka /
march beat that follows the tempo.  Durations are in video frames, so a
tempo map (accelerando) is just a different onset -> frame function.
"""
import os
from fractions import Fraction as F
import lyparse

HERE = os.path.dirname(os.path.abspath(__file__))
SRC = os.path.join(HERE, '..', 'music', 'classical')
NOTE_OF = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
LO, HI = 43, 93                    # the driver's note table: G2 .. A6


def nm(m):
    return '%s%d' % (NOTE_OF[m % 12], m // 12 - 1)


def load(name, vars_):
    notes = []
    for v in vars_:
        notes += lyparse.read(os.path.join(SRC, name), v)
    return sorted(notes)


def line(notes, pick):
    """monophonic line: at each onset the highest (pick=max) or lowest note
    starting there, unless a note still sounding is higher (lower)"""
    by_on = {}
    for on, d, m in notes:
        by_on.setdefault(on, []).append((m, d))
    out = []                        # (onset, end, midi)
    cur = None
    for on in sorted(by_on):
        m, d = pick(by_on[on], key=lambda x: x[0])
        if cur is not None and cur[1] > on:
            better = (m > cur[2]) if pick is max else (m < cur[2])
            if not better:
                continue
            cur[1] = on            # cut the held note
        cur = [on, on + d, m]
        out.append(cur)
    # no overlaps
    for i in range(len(out) - 1):
        if out[i][1] > out[i + 1][0]:
            out[i][1] = out[i + 1][0]
    return [tuple(x) for x in out]


def fold(seq, lo, hi, shift):
    """move into the range by octaves"""
    res = []
    for on, end, m in seq:
        m += shift
        while m < lo:
            m += 12
        while m > hi:
            m -= 12
        res.append((on, end, m))
    return res


def best_shift(seq, lo, hi):
    ms = sorted(m for _, _, m in seq)
    med = ms[len(ms) // 2]
    target = (lo + hi) // 2 + 4
    return 12 * round((target - med) / 12.0)


class Tempo:
    """onset (whole notes) -> frame, quarter-note bpm varying linearly
    between (position, bpm) points"""
    def __init__(self, points):
        self.p = points

    def bpm(self, t):
        p = self.p
        if t <= p[0][0]:
            return p[0][1]
        for (a, ba), (b, bb) in zip(p, p[1:]):
            if a <= t <= b:
                return ba + (bb - ba) * float(t - a) / float(b - a)
        return p[-1][1]

    def frame(self, t, step=F(1, 64)):
        # integrate 60*60/bpm frames per quarter over t (in whole notes)
        f = 0.0
        x = F(0)
        while x < t:
            dx = min(step, t - x)
            f += float(dx) * 4 * 3600.0 / self.bpm(x + dx / 2)
            x += dx
        return f


def to_text(seq, end, tempo, base_frame, head, frames_of):
    toks = [head]
    t = F(0)
    for on, e, m in seq:
        if on > t:
            toks.append('r/%d' % max(1, frames_of(on) - frames_of(t)))
        n = max(1, frames_of(e) - frames_of(on))
        toks.append('%s/%d' % (nm(m), n))
        t = e
    if end > t:
        toks.append('r/%d' % max(1, frames_of(end) - frames_of(t)))
    return ' '.join(toks)


def drum_events(length, bar, style):
    ev = []
    t = F(0)
    k = 0
    while t < length:
        last = (k % 8) == 7
        if bar == F(1, 2):
            pat = [(0, 'k'), (F(1, 8), 'h'), (F(1, 4), 's'), (F(3, 8), 'h')]
            if style == 'rag':
                pat = [(0, 'k'), (F(1, 8), 'h'), (F(1, 4), 's'), (F(5, 16), 'h'), (F(3, 8), 'o')]
            elif style == 'tango':     # habanera: dotted eighth, sixteenth, two eighths
                pat = [(0, 'k'), (F(3, 16), 'h'), (F(1, 4), 'k'), (F(3, 8), 'h')]
            if last and style != 'tango':
                pat = [(0, 'k'), (F(1, 8), 's'), (F(1, 4), 's'), (F(5, 16), 's'), (F(3, 8), 's'), (F(7, 16), 's')]
        else:
            pat = [(0, 'k'), (F(1, 8), 'h'), (F(1, 4), 's'), (F(3, 8), 'h'),
                   (F(1, 2), 'k'), (F(5, 8), 'h'), (F(3, 4), 's'), (F(7, 8), 'h')]
            if last:
                pat = pat[:5] + [(F(5, 8), 's'), (F(3, 4), 's'), (F(13, 16), 's'), (F(7, 8), 's'), (F(15, 16), 's')]
        for o, n in pat:
            if t + o < length:
                ev.append((t + o, n))
        t += bar
        k += 1
    return ev


def drums_text(ev, end, frames_of):
    toks = []
    for i, (on, n) in enumerate(ev):
        nxt = ev[i + 1][0] if i + 1 < len(ev) else end
        toks.append('%s/%d' % (n, max(1, frames_of(nxt) - frames_of(on))))
    return ' '.join(toks)


def piece(file, rh, lh, bar, tempo, style, lead_shift=None, extra=0, lead_inst='@10 v5'):
    """-> dict of the four voice texts and the length in frames"""
    R = load(file, rh)
    L = load(file, lh)
    end = max(max(o + d for o, d, m in R), max(o + d for o, d, m in L))
    lead = line(R, max)
    bass = line(L, min)
    bass_on = {(o, m) for o, e, m in bass}
    harm = line([(o, d, m) for o, d, m in L if (o, m) not in bass_on], max)
    ls = best_shift(lead, 64, HI) if lead_shift is None else lead_shift
    lead = fold(lead, 57, HI, ls + extra)
    bass = fold(bass, LO, 64, best_shift(bass, LO, 60))
    harm = fold(harm, 55, 81, best_shift(harm, 55, 79))
    f0 = {}

    def frames_of(t):
        if t not in f0:
            f0[t] = int(round(tempo.frame(t)))
        return f0[t]
    return dict(
        lead=to_text(lead, end, tempo, 0, lead_inst, frames_of),
        bass=to_text(bass, end, tempo, 0, '@6 v6', frames_of),
        harm=to_text(harm, end, tempo, 0, '@6 v8', frames_of),
        drums=drums_text(drum_events(end, bar, style), end, frames_of),
        frames=frames_of(end))


def frames_in(text):
    return sum(int(t.split('/')[1]) for t in text.split() if '/' in t)


RADIO = [   # (title, score, right hand, left hand, quarter-note bpm)
    ('THE ENTERTAINER', 'joplin_entertainer.ly', ['top'], ['bottom'], 100),
    ('MAPLE LEAF RAG', 'joplin_maple_leaf.ly', ['top'], ['bottom'], 95),
    ('PINE APPLE RAG', 'joplin_pine_apple.ly', ['right'], ['left'], 96),
    ('PEACHERINE RAG', 'joplin_peacherine.ly', ['top'], ['bottom'], 96),
]


def assemble(name, parts):
    v = {k: ' '.join(x[k] for x in parts) for k in ('lead', 'bass', 'harm', 'drums')}
    n = {frames_in(v[k]) for k in v}
    assert len(n) == 1, (name, {k: frames_in(v[k]) for k in v})
    return (name, 1, v['lead'], v['bass'], v['harm'], v['drums'])


def songs():
    """-> the radio: [(name, f16, lead, bass, harm, drums)], durations in frames (f16 = 1)"""
    return [assemble(t, [piece(f, rh, lh, F(1, 2), Tempo([(F(0), bpm)]), 'rag')])
            for t, f, rh, lh, bpm in RADIO]


def solace():
    """Joplin's "Solace" (1909), the slow Mexican serenade: game over / results"""
    p = piece('joplin_solace.ly', ['solaceRH'], ['solaceLH'], F(1, 2), Tempo([(F(0), 74)]), 'tango',
              lead_inst='@13 v5')
    return assemble('SOLACE', [p])


if __name__ == '__main__':
    for name, f16, lead, bass, harm, dr in songs() + [solace()]:
        print(name, '%.0f s' % (frames_in(lead) / 60.0))

"""The three radio songs of SUNSET RUN (original music).

Each song is written as sections of 8 bars (verse, pre-chorus, a catchy
chorus hook, a bridge) and arranged into a full ~3.5-4 minute track:

  intro | A A' B C C' | riff | A B C C' | bridge | solo solo' | B C C' | outro

A' and C' are the same sections with a different ending; the riff is the
chorus hook played an octave down on another instrument; the two solos are
fast arpeggios over the chorus chords.  The track then loops.

Melodies use the notation of gen_music.py: C5/4 = C5 for 4 sixteenths,
r/2 = rest; one bar = 16 sixteenths, bars separated by |.
"""
import re

NOTE_OF = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
NAMES = {n: i for i, n in enumerate(NOTE_OF)}
LO, HI = 43, 93               # note table range (G2 .. A6)


def midi(n):
    return 12 * (int(n[-1]) + 1) + NAMES[n[:-1]]


def nm(m):
    return '%s%d' % (NOTE_OF[m % 12], m // 12 - 1)


def bars(text):
    """'..|..|..' -> list of bar strings, each checked to be 16 sixteenths"""
    out = [b.strip() for b in text.split('|') if b.strip()]
    for b in out:
        n = sum(int(t.split('/')[1]) for t in b.split() if '/' in t)
        assert n == 16, 'bar is %d sixteenths: %s' % (n, b)
    return out


def shift(bar, semis):
    def f(m):
        n = midi(m.group(1)) + semis
        assert LO <= n <= HI, 'note out of range after transposing'
        return nm(n) + '/'
    return re.sub(r'([A-G]#?\d)/', f, bar)


def solo(chords, chord_tab, seed):
    """fast arpeggio solo: one pattern per bar over the chord tones"""
    pats = [
        [(0, 1), (1, 1), (2, 1), (3, 1)] * 4,
        [(3, 2), (2, 2), (1, 2), (0, 2), (1, 2), (2, 2), (3, 4)],
        [(0, 3), (2, 3), (3, 2), (2, 4), (1, 4)],
        [(0, 1), (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (4, 1), (3, 1), (2, 8)],
        [(2, 2), (3, 2), ('r', 2), (3, 2), (4, 2), (3, 2), (2, 4)],
        [(4, 6), (3, 2), (2, 4), (0, 4)],
    ]
    out = []
    for i, ch in enumerate(chords):
        pcs = sorted(set(t % 12 for t in chord_tab[ch]))
        ladder, m = [], 67
        while len(ladder) < 6:
            m += 1
            if m % 12 in pcs:
                ladder.append(m)
        pat = pats[(i + seed) % len(pats)]
        toks = []
        for d, ln in pat:
            toks.append('r/%d' % ln if d == 'r' else '%s/%d' % (nm(ladder[d]), ln))
        out.append(' '.join(toks))
    return out


class Song:
    def __init__(self, name, f16, sections, styles):
        self.name, self.f16 = name, f16
        self.sec = sections            # name -> (chords[8], melody bars[8])
        self.styles = styles


def arrange(song, helpers):
    """-> (lead, bass, harmony, drums) token strings for the whole track"""
    bass_line, montuno, drums, chord_tab = helpers
    S = song.sec
    st = song.styles
    hook = S['C'][1]
    order = [
        ('intro', S['intro'][0], ['r/16'] * 3 + [S['intro'][1]], 'pulse', 'arp', 'soft', '@10 v5'),
        ('A', S['A'][0], S['A'][1], st['verse_bass'], 'stab', st['verse_drums'], '@10 v5'),
        ("A'", S['A'][0], S['A'][1][:6] + S["A'"], st['verse_bass'], 'stab', st['verse_drums'], '@10 v5'),
        ('B', S['B'][0], S['B'][1], st['pre_bass'], 'arp', 'groove', '@10 v5'),
        ('C', S['C'][0], hook, st['chorus_bass'], 'arp', st['chorus_drums'], '@11 v4'),
        ("C'", S['C'][0], hook[:6] + S["C'"], st['chorus_bass'], 'arp', st['chorus_drums'], '@11 v4'),
        ('riff', S['C'][0], [shift(b, -12) for b in hook[:4]] + hook[:4], st['chorus_bass'], 'stab', 'groove', '@4 v5'),
        ('A', S['A'][0], S['A'][1], st['verse_bass'], 'stab', st['verse_drums'], '@10 v5'),
        ('B', S['B'][0], S['B'][1], st['pre_bass'], 'arp', 'groove', '@10 v5'),
        ('C', S['C'][0], hook, st['chorus_bass'], 'arp', st['chorus_drums'], '@11 v4'),
        ("C'", S['C'][0], hook[:6] + S["C'"], st['chorus_bass'], 'arp', st['chorus_drums'], '@11 v4'),
        ('E', S['E'][0], S['E'][1], 'walk', 'pad', 'soft', '@10 v5'),
        ('solo', S['C'][0], solo(S['C'][0], chord_tab, 0), st['chorus_bass'], 'stab', st['chorus_drums'], '@4 v5'),
        ("solo'", S['A'][0], solo(S['A'][0], chord_tab, 3), st['verse_bass'], 'stab', st['chorus_drums'], '@4 v5'),
        ('B', S['B'][0], S['B'][1], st['pre_bass'], 'arp', 'groove', '@10 v5'),
        ('C', S['C'][0], hook, st['chorus_bass'], 'arp', st['chorus_drums'], '@11 v4'),
        ("C'", S['C'][0], hook[:6] + S["C'"], st['chorus_bass'], 'arp', st['chorus_drums'], '@11 v4'),
        ('outro', S['outro'][0], S['outro'][1], 'walk', 'pad', 'soft', '@10 v5'),
    ]
    lead, bass, harm, dr = [], [], [], []
    for name, chords, mel, bs, hs, ds, inst in order:
        assert len(chords) == len(mel), name
        lead.append(inst + ' ' + ' | '.join(mel) + ' |')
        bass.append('@6 v6 ' + bass_line(chords, st['bass_base'], bs))
        harm.append('@6 v8 ' + montuno(chords, st['harm_base'], hs))
        dr.append(drums(len(chords), ds, 8 if len(chords) == 8 else 4))
    return ' '.join(lead), ' '.join(bass), ' '.join(harm), ' '.join(dr)


SONGS = []

# ------------------------------------------------------------ 1. SUMMER OVERDRIVE
# D major, 150 bpm: bright, a "da-da DAA" chorus hook
SONGS.append(Song('SUMMER OVERDRIVE', 6, {
    'intro': (['D', 'A', 'G', 'A'], 'r/8 A5/2 B5/2 C#6/2 E6/2'),
    'A': (['D', 'A', 'Bm', 'G', 'D', 'A', 'G', 'A'], bars(
        'F#5/2 A5/2 r/2 A5/2 B5/2 A5/2 F#5/4 | E5/2 F#5/2 r/2 E5/2 C#5/4 A4/4 | '
        'D5/2 F#5/2 r/2 F#5/2 A5/2 B5/2 D6/4 | B5/6 A5/2 G5/4 r/4 | '
        'F#5/2 A5/2 r/2 A5/2 B5/2 A5/2 D6/4 | E6/2 D6/2 C#6/2 A5/2 r/2 A5/2 B5/4 | '
        'D6/3 B5/3 G5/2 B5/4 D6/4 | C#6/6 B5/2 A5/4 E5/4')),
    "A'": bars('D6/2 C#6/2 B5/2 G5/2 B5/2 D6/2 E6/4 | E6/8 r/4 A5/2 B5/2'),
    'B': (['Em', 'F#m', 'G', 'A', 'Em', 'F#m', 'G', 'A7'], bars(
        'G5/2 G5/2 B5/2 G5/2 E5/4 G5/4 | A5/2 A5/2 C#6/2 A5/2 F#5/4 A5/4 | '
        'B5/2 B5/2 D6/2 B5/2 G5/2 B5/2 D6/4 | C#6/4 E6/4 C#6/4 A5/4 | '
        'G5/2 B5/2 E6/2 B5/2 G5/2 B5/2 E6/4 | A5/2 C#6/2 F#6/2 C#6/2 A5/2 C#6/2 F#6/4 | '
        'G6/4 F#6/4 E6/4 D6/4 | C#6/2 E6/2 G6/2 E6/2 C#6/2 A5/2 r/4')),
    'C': (['D', 'A', 'Bm', 'F#m', 'G', 'D', 'Em', 'A'], bars(
        'A5/2 D6/2 r/2 D6/2 E6/2 F#6/4 D6/2 | E6/4 C#6/2 A5/6 r/4 | '
        'A5/2 D6/2 r/2 D6/2 E6/2 F#6/4 A6/2 | F#6/4 E6/2 C#6/6 r/4 | '
        'B5/2 D6/2 r/2 D6/2 G6/2 F#6/2 E6/2 D6/2 | F#6/4 E6/2 D6/2 A5/4 F#5/4 | '
        'G5/2 B5/2 E6/2 G6/2 F#6/2 E6/2 D6/2 E6/2 | E6/8 C#6/4 A5/4')),
    "C'": bars('G5/2 B5/2 E6/2 G6/2 F#6/4 E6/4 | D6/12 r/4'),
    'E': (['Bm', 'G', 'D', 'A', 'Bm', 'G', 'Em', 'A'], bars(
        'F#6/6 E6/2 D6/8 | B5/6 D6/2 G6/8 | F#6/4 E6/4 D6/4 A5/4 | C#6/8 E6/8 | '
        'D6/6 C#6/2 B5/8 | G5/4 B5/4 D6/4 G6/4 | G6/4 F#6/4 E6/4 D6/4 | E6/4 C#6/4 A5/4 E5/4')),
    'outro': (['D', 'A', 'G', 'A'], bars('D6/16 | C#6/16 | B5/16 | A5/8 r/8')),
}, dict(verse_bass='octave', pre_bass='pulse', chorus_bass='octave', verse_drums='rock',
        chorus_drums='rock', bass_base=38, harm_base=62)))

# ------------------------------------------------------------ 2. MIDNIGHT COAST
# A minor, 150 bpm: driving synth anthem
SONGS.append(Song('MIDNIGHT COAST', 6, {
    'intro': (['Am', 'F', 'G', 'E'], 'r/8 E5/2 G#5/2 B5/2 D6/2'),
    'A': (['Am', 'F', 'C', 'G', 'Am', 'F', 'G', 'E'], bars(
        'A5/2 r/2 A5/2 C6/2 E6/2 D6/2 C6/2 B5/2 | C6/4 A5/2 F5/6 r/4 | '
        'G5/2 r/2 G5/2 C6/2 E6/2 D6/2 C6/2 D6/2 | B5/4 G5/2 D5/6 r/4 | '
        'A5/2 r/2 A5/2 C6/2 E6/2 G6/2 E6/2 C6/2 | F6/4 E6/2 C6/6 A5/4 | '
        'D6/2 C6/2 B5/2 G5/2 B5/2 C6/2 D6/4 | B5/8 G#5/8')),
    "A'": bars('G6/2 F6/2 E6/2 D6/2 B5/2 G5/2 B5/2 D6/2 | E6/4 D6/4 B5/4 G#5/4'),
    'B': (['Dm', 'Am', 'F', 'G', 'Dm', 'Am', 'Bbmaj7', 'E'], bars(
        'F5/2 A5/2 D6/2 A5/2 F6/4 E6/4 | E6/2 C6/2 A5/2 C6/2 E6/4 r/4 | '
        'F5/2 A5/2 C6/2 F6/2 E6/2 C6/2 A5/4 | B5/2 D6/2 G6/4 F6/2 D6/2 B5/4 | '
        'D6/4 F6/4 A6/4 F6/4 | E6/4 A6/4 E6/4 C6/4 | D6/4 F6/4 A6/4 F6/4 | G#6/4 E6/4 B5/4 G#5/4')),
    'C': (['F', 'G', 'Am', 'Am', 'F', 'G', 'C', 'E'], bars(
        'C6/3 C6/3 A5/2 C6/4 F6/4 | E6/3 D6/3 B5/2 G5/4 D6/4 | '
        'C6/3 B5/3 A5/2 E6/8 | r/4 A5/2 B5/2 C6/2 D6/2 E6/4 | '
        'F6/3 E6/3 C6/2 A5/4 F6/4 | G6/3 F6/3 D6/2 B5/4 G6/4 | '
        'E6/4 G6/4 C6/4 E6/4 | D6/4 B5/4 G#5/4 B5/4')),
    "C'": bars('E6/2 F6/2 G6/2 E6/2 C6/4 G5/4 | G#5/4 B5/4 E6/8'),
    'E': (['Dm', 'Em', 'F', 'G', 'Dm', 'Em', 'F', 'E'], bars(
        'A5/8 D6/8 | B5/8 E6/8 | C6/4 F6/4 A6/8 | G6/6 F6/2 D6/8 | '
        'F6/6 E6/2 D6/8 | E6/6 D6/2 B5/8 | C6/4 A5/4 F5/4 A5/4 | B5/4 G#5/4 E5/8')),
    'outro': (['Am', 'F', 'G', 'E'], bars('A5/16 | C6/16 | D6/16 | B5/8 r/8')),
}, dict(verse_bass='pulse', pre_bass='octave', chorus_bass='gallop', verse_drums='rock',
        chorus_drums='rock', bass_base=45, harm_base=60)))

# ------------------------------------------------------------ 3. PALM BOULEVARD
# F major, 128 bpm: laid-back latin funk
SONGS.append(Song('PALM BOULEVARD', 7, {
    'intro': (['Fmaj7', 'Gm7', 'Bbmaj7', 'C7'], 'r/8 C6/2 D6/2 E6/2 G6/2'),
    'A': (['Fmaj7', 'Gm7', 'Am7', 'Gm7', 'Fmaj7', 'Gm7', 'Bbmaj7', 'C7'], bars(
        'C6/3 A5/3 C6/2 r/2 A5/2 G5/2 F5/2 | G5/3 A#5/3 D6/2 r/4 D6/2 C6/2 | '
        'A5/3 C6/3 E6/2 r/2 D6/2 C6/2 A5/2 | A#5/6 A5/2 G5/4 r/4 | '
        'C6/3 A5/3 C6/2 r/2 F6/2 E6/2 C6/2 | D6/3 A#5/3 G5/2 r/2 A#5/2 C6/2 D6/2 | '
        'F6/4 D6/4 A#5/4 A5/4 | G5/8 r/4 C6/2 D6/2')),
    "A'": bars('D6/2 F6/2 A6/4 G6/2 F6/2 D6/4 | E6/8 r/8'),
    'B': (['Dm7', 'Gm7', 'C7', 'Fmaj7', 'Dm7', 'Gm7', 'Bbmaj7', 'C7'], bars(
        'F6/2 E6/2 D6/2 A5/2 r/2 D6/2 F6/4 | G6/4 F6/2 D6/2 A#5/8 | '
        'E6/2 D6/2 C6/2 G5/2 r/2 C6/2 E6/4 | F6/4 E6/2 C6/2 A5/8 | '
        'A5/2 D6/2 F6/2 A6/2 G6/2 F6/2 D6/4 | A#5/2 D6/2 G6/2 F6/2 D6/2 A#5/2 G5/4 | '
        'A5/4 A#5/4 D6/4 F6/4 | E6/4 G6/4 E6/4 C6/4')),
    'C': (['Bbmaj7', 'C7', 'Am7', 'Dm7', 'Gm7', 'C7', 'Fmaj7', 'C7'], bars(
        'D6/2 F6/2 r/2 F6/2 G6/2 F6/2 D6/4 | E6/2 G6/2 r/2 G6/2 A6/2 G6/2 E6/4 | '
        'C6/4 E6/2 A6/6 G6/4 | F6/4 E6/2 D6/6 r/4 | '
        'D6/2 G6/2 r/2 G6/2 F6/2 D6/2 A#5/4 | C6/2 E6/2 r/2 G6/2 F6/2 E6/2 C6/4 | '
        'A5/4 C6/4 F6/4 E6/4 | D6/4 E6/4 G6/8')),
    "C'": bars('A6/4 G6/4 F6/4 C6/4 | F6/12 r/4'),
    'E': (['Dm7', 'Am7', 'Bbmaj7', 'Fmaj7', 'Gm7', 'Am7', 'Bbmaj7', 'C7'], bars(
        'D6/6 F6/2 A6/8 | G6/6 E6/2 C6/8 | D6/6 C6/2 A#5/8 | A5/4 C6/4 F6/8 | '
        'A#5/6 D6/2 G6/8 | A6/6 G6/2 E6/8 | F6/4 D6/4 A#5/4 D6/4 | E6/4 G6/4 C6/8')),
    'outro': (['Fmaj7', 'Gm7', 'Bbmaj7', 'C7'], bars('A5/16 | A#5/16 | D6/16 | E6/8 r/8')),
}, dict(verse_bass='tumbao', pre_bass='samba', chorus_bass='funk', verse_drums='latin',
        chorus_drums='groove', bass_base=41, harm_base=60)))

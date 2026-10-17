#!/usr/bin/env python3
"""Original music for SUNSET RUN -> NGPC driver streams (src/audio/music_data.c).

Notation (per voice): space separated tokens
  C4/4    note C4 for 4 sixteenths      (sharps: C#4, flats written as sharps)
  r/2     rest for 2 sixteenths
  @5      instrument 5                   v3   attenuation 3 (0 loud .. 15 silent)
  |       bar line (ignored)
Noise voice uses k (kick), s (snare), h (hat), o (open hat) instead of notes.
"""
import os, sys

OUT = sys.argv[1] if len(sys.argv) > 1 else 'src/audio'
CLOCK = 3072000
LOW = 43          # MIDI G2 = index 1
NAMES = {'C': 0, 'C#': 1, 'D': 2, 'D#': 3, 'E': 4, 'F': 5, 'F#': 6, 'G': 7, 'G#': 8, 'A': 9, 'A#': 10, 'B': 11}

def midi(n):
    name, octv = n[:-1], int(n[-1])
    return 12 * (octv + 1) + NAMES[name]

def note_table():
    t = []
    for i in range(51):
        m = LOW + i
        f = 440.0 * 2 ** ((m - 69) / 12.0)
        div = int(round(CLOCK / (32.0 * f)))
        div = max(1, min(1023, div))
        t += [div & 0x0F, (div >> 4) & 0x3F]
    return t

NOISE = {'k': 3, 's': 6, 'h': 5, 'o': 5}
NOISE_INST = {'k': 1, 's': 3, 'h': 2, 'o': 2}
NOISE_ATTN = {'k': 5, 's': 7, 'h': 12, 'o': 11}

def stream(text, frames16, noise=False):
    out = []
    cur_inst = None
    for tok in text.split():
        if tok == '|':
            continue
        if tok.startswith('@'):
            cur_inst = int(tok[1:])
            out += [0xF4, cur_inst]
            continue
        if tok.startswith('v'):
            out += [0xF0, int(tok[1:])]
            continue
        n, _, d = tok.partition('/')
        frames = int(d) * frames16
        while frames > 0:
            f = min(frames, 240)
            if n == 'r':
                out += [0xFF, f]
            elif noise:
                if NOISE_INST[n] != cur_inst:
                    cur_inst = NOISE_INST[n]
                    out += [0xF4, cur_inst, 0xF0, NOISE_ATTN[n]]
                out += [NOISE[n], f]
            else:
                idx = midi(n) - LOW + 1
                if not 1 <= idx <= 51:
                    raise SystemExit('note out of range: %s' % tok)
                out += [idx, f]
            frames -= f
            n = 'r' if not noise else n   # long notes: hold by resting the tail
            if noise:
                break
    return out

# ----------------------------------------------------------------- composition helpers
# Style study: mid-80s arcade "summer fusion" - 125-150 bpm, bright major and
# mixolydian keys, syncopated latin bass (tresillo / tumbao), montuno stabs,
# timbale-like fills.  All melodies and progressions below are original.
CHORDS = {
    'C': [0, 4, 7], 'Cmaj7': [0, 4, 7, 11], 'C7': [0, 4, 7, 10], 'Dm7': [2, 5, 9, 12], 'D': [2, 6, 9],
    'D7': [2, 6, 9, 12], 'Dmaj7': [2, 6, 9, 13], 'Em7': [4, 7, 11, 14], 'E7': [4, 8, 11, 14],
    'F': [5, 9, 12], 'Fmaj7': [5, 9, 12, 16], 'F#m7': [6, 9, 13, 16], 'G': [7, 11, 14],
    'Gmaj7': [7, 11, 14, 18], 'G7': [7, 11, 14, 17], 'Gm7': [7, 10, 14, 17], 'Am7': [9, 12, 16, 19],
    'A7': [9, 13, 16, 19], 'Bm7': [11, 14, 18, 21], 'Bbmaj7': [10, 14, 17, 21],
    'E': [4, 8, 11], 'B': [11, 15, 18], 'A': [9, 13, 16], 'C#m': [1, 4, 8], 'Am': [9, 12, 16],
    'Em': [4, 7, 11], 'Dm': [2, 5, 9], 'Bm': [11, 14, 18], 'F#m': [6, 9, 13],
}
NOTE_OF = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']

def nm(m):
    return '%s%d' % (NOTE_OF[m % 12], m // 12 - 1)

def root_of(ch, base):
    root = base + CHORDS[ch][0]
    if root > base + 6:
        root -= 12
    while root < LOW:
        root += 12
    return root

def bass_line(chords, base=40, style='tresillo'):
    out = []
    for ch in chords:
        r = root_of(ch, base)
        f = r + 7
        o = r + 12
        if style == 'tresillo':      # 3+3+2 | 3+3+2
            pat = [(r, 3), (r, 3), (f, 2), (o, 3), (f, 3), (r, 2)]
        elif style == 'tumbao':      # anticipated, rest on the one
            pat = [('r', 3), (f, 3), (o, 2), ('r', 3), (f, 3), (r, 2)]
        elif style == 'samba':
            pat = [(r, 3), (r, 1), (f - 12 if f - 12 >= LOW else f, 3), (f - 12 if f - 12 >= LOW else f, 1)] * 2
        elif style == 'octave':      # driving 8th-note octaves
            pat = [(r, 2), (o, 2)] * 4
        elif style == 'pulse':       # pumping root with a lift at the end
            pat = [(r, 2)] * 5 + [(f, 2), (o, 2), (r, 2)]
        elif style == 'gallop':
            pat = [(r, 2), (r, 1), (r, 1), (f, 2), (r, 1), (r, 1), (o, 2), (r, 1), (r, 1), (f, 2), (r, 2)]
        elif style == 'funk':
            pat = [(r, 3), (r, 1), ('r', 2), (o, 2), (r, 2), ('r', 2), (f, 2), (r + 10, 2)]
        else:                         # 'walk' for the ending
            t = r + CHORDS[ch][1] - CHORDS[ch][0]
            pat = [(r, 4), (t, 4), (f, 4), (o, 4)]
        out += ['r/%d' % d if n == 'r' else '%s/%d' % (nm(n), d) for n, d in pat]
        out.append('|')
    return ' '.join(out)

def montuno(chords, base=60, style='stab'):
    out = []
    for ch in chords:
        t = [x + base for x in CHORDS[ch]]
        if style == 'stab':           # off-beat chord stabs
            pat = [('r', 2), (t[1], 2), ('r', 2), (t[2], 2), ('r', 2), (t[1], 1), (t[0], 1), ('r', 2), (t[2], 2)]
        elif style == 'arp':
            pat = [(t[i % len(t)], 1) for i in (0, 1, 2, 3, 2, 1, 0, 1, 2, 3, 2, 1, 0, 2, 1, 3)]
        else:                         # 'pad': two long tones
            pat = [(t[1], 8), (t[2 if len(t) > 2 else 1], 8)]
        out += ['r/%d' % d if n == 'r' else '%s/%d' % (nm(n), d) for n, d in pat]
        out.append('|')
    return ' '.join(out)

DRUMS = {
    'latin':  'k/2 h/2 s/2 h/2 k/2 h/1 k/1 s/2 o/2',
    'samba':  'k/2 h/1 h/1 k/2 h/1 s/1 k/2 h/1 h/1 k/2 s/1 h/1',
    'groove': 'k/2 o/2 s/2 h/1 h/1 k/2 o/2 s/2 h/2',
    'soft':   'k/4 h/4 s/4 h/4',
    'rock':   'k/2 h/2 s/2 h/2 k/2 k/2 s/2 h/2',
}
FILL = 's/1 s/1 s/2 s/1 s/1 s/2 k/2 s/2 s/1 s/1 s/2'

def drums(bars, style, fill_every=8):
    out = []
    for b in range(bars):
        out += (FILL if (b + 1) % fill_every == 0 else DRUMS[style]).split()
        out.append('|')
    return ' '.join(out)

def bars_of(text):
    """total length in sixteenths (for the loop-sync check)"""
    n = 0
    for tok in text.split():
        if '/' in tok:
            n += int(tok.split('/')[1])
    return n

# ----------------------------------------------------------------- the radio
# Chiptune racing tunes: square-wave lead with a short hook repeated and
# answered, octave / pumping bass, fast arpeggios (heard on the menus; in a
# race the third channel plays the engine), noise drums.  Original music.
# The radio plays chiptune arrangements of famous public-domain classics
# (Strauss, Joplin, Grieg), read from the Mutopia scores in music/classical/:
# see tools/classical.py.  Durations there are in frames (f16 = 1).
import classical as _classical
SONGS = _classical.songs()

# 4. goal fanfare (results, looped) and game over jingle
prog4 = ['C', 'F', 'G', 'C', 'Am', 'F', 'G', 'C']
mel4 = ('@10 v4 G5/2 C6/2 E6/4 D6/2 C6/2 G5/4 | A5/2 C6/2 F6/4 E6/2 C6/2 A5/4 | '
        'B5/2 D6/2 G6/4 F6/2 D6/2 B5/4 | C6/8 G5/4 C6/4 | '
        'E6/2 C6/2 A5/4 C6/2 E6/2 A6/4 | F6/2 E6/2 D6/2 C6/2 A5/4 C6/4 | '
        'D6/2 B5/2 G5/2 B5/2 D6/4 F6/4 | E6/8 C6/8')
JINGLES = [
    ('GOAL', 7, mel4, '@6 v6 ' + bass_line(prog4, 36, 'octave'), '@6 v8 ' + montuno(prog4, 60, 'arp'),
     drums(len(prog4), 'rock', 8), 1),
    ('OVER', 8, '@10 v4 E5/4 D#5/4 D5/4 C#5/4 C5/16', '@6 v6 A2/16 A2/16', '@13 v8 C4/16 A3/16', 'k/16 r/16', 0),
]

for name, f16, mel, bass, harm, dr in SONGS:
    n = {bars_of(x) for x in (mel, bass, harm, dr)}
    assert len(n) == 1, (name, [bars_of(x) for x in (mel, bass, harm, dr)])
for name, f16, mel, bass, harm, dr, loop in JINGLES:
    if loop:
        assert len({bars_of(x) for x in (mel, bass, harm, dr)}) == 1, name

MIDI_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'music')

def main():
    import midi
    os.makedirs(OUT, exist_ok=True)
    c = ['/* Generated by tools/gen_music.py -- do not edit. */',
         '#include "music_data.h"', '']
    nt = note_table()
    c.append('const unsigned char NOTE_TABLE[%d] = { %s };' % (len(nt), ', '.join(str(x) for x in nt)))
    # songs as (name, [v0, v1, v2, vn] byte streams, loop)
    radio = [(n, [stream(m, f), stream(b, f), stream(h, f), stream(d, f, noise=True)], 1)
             for (n, f, m, b, h, d) in SONGS]
    jingles = [(n, [stream(m, f), stream(b, f), stream(h, f), stream(d, f, noise=True)], loop)
               for (n, f, m, b, h, d, loop) in JINGLES]
    mradio, mgoal = midi.load_folder(MIDI_DIR, NOISE, NOISE_INST, NOISE_ATTN)
    if mradio:
        radio = [(n, v, 1) for n, v in mradio]
    if mgoal:
        jingles[0] = (jingles[0][0], mgoal[1], 1)
    # last station: silence (only the engine and the effects are heard)
    radio.append(('SILENCIO', [[0xFF, 240], [0xFF, 240], [0xFF, 240], [0xFF, 240]], 1))
    allsongs = radio + jingles
    entries = []
    for i, (name, vs, loop) in enumerate(allsongs):
        # channel 0 lead, 1 bass, 2 harmony (the engine note takes it in a
        # race), noise drums
        for v, data in enumerate(vs):
            if not loop:
                data = data + [0xFF, 240] * 12      # jingles: hold silence instead of looping
            data = data + [0]
            c.append('static const unsigned char song%d_v%d[%d] = { %s };' % (i, v, len(data), ', '.join(str(x) for x in data)))
        entries.append('    { song%d_v0, song%d_v1, song%d_v2, song%d_v3, %d },' % (i, i, i, i, loop))
    c.append('const MusicSong music_songs[MUSIC_COUNT] = {\n%s\n};' % '\n'.join(entries))
    open(os.path.join(OUT, 'music_data.c'), 'w').write('\n'.join(c) + '\n')
    nr = len(radio)
    h = ['/* Generated by tools/gen_music.py */', '#ifndef MUSIC_DATA_H', '#define MUSIC_DATA_H', '#include "ngpc_types.h"',
         'typedef struct { const u8 *v0; const u8 *v1; const u8 *v2; const u8 *vn; u8 loop; } MusicSong;',
         '#define MUSIC_COUNT %d' % len(allsongs), '#define MUSIC_RADIO %d' % nr,
         '#define MUSIC_GOAL %d' % nr, '#define MUSIC_OVER %d' % (nr + 1),
         '#define MUSIC_NAMES %s' % ', '.join('"%s"' % r[0] for r in radio),
         'extern const unsigned char NOTE_TABLE[%d];' % len(nt),
         'extern const MusicSong music_songs[MUSIC_COUNT];', '#endif', '']
    open(os.path.join(OUT, 'music_data.h'), 'w').write('\n'.join(h))
    print('songs:', [s[0] for s in allsongs])

main()

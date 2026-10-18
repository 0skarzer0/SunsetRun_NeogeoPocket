#!/usr/bin/env python3
"""SUNSET RUN music -> NGPC driver streams (src/audio/music_data.c/h).

The radio is made of YOUR MIDI files: every music/*.mid becomes a station (in
file-name order, up to 8, see tools/midi.py), and the last station is always
SILENCIO (engine and effects only).  With no MIDI files the radio only has
SILENCIO.

Two short original jingles are built in, and a MIDI can replace each one:
  * GOAL  (the finish, looped)            <- music/goal*.mid
  * OVER  (game over / results, looped)   <- music/over*.mid

Jingle notation (per voice): space separated tokens
  C4/4    note C4 for 4 sixteenths      (sharps: C#4)
  r/2     rest for 2 sixteenths
  @5      instrument 5                   v3   attenuation 3 (0 loud .. 15 silent)
  |       bar line (ignored)
The noise voice uses k (kick), s (snare), h (hat), o (open hat).
"""
import os, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import midi

OUT = sys.argv[1] if len(sys.argv) > 1 else 'src/audio'
MIDI_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'music')
CLOCK = 3072000
LOW = 43          # MIDI G2 = stream note 1
NAMES = {'C': 0, 'C#': 1, 'D': 2, 'D#': 3, 'E': 4, 'F': 5, 'F#': 6, 'G': 7, 'G#': 8, 'A': 9, 'A#': 10, 'B': 11}
NOTE_OF = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
NOISE = {'k': 3, 's': 6, 'h': 5, 'o': 5}
NOISE_INST = {'k': 1, 's': 3, 'h': 2, 'o': 2}
NOISE_ATTN = {'k': 5, 's': 7, 'h': 12, 'o': 11}


def note_table():
    t = []
    for i in range(51):
        f = 440.0 * 2 ** ((LOW + i - 69) / 12.0)
        div = max(1, min(1023, int(round(CLOCK / (32.0 * f)))))
        t += [div & 0x0F, (div >> 4) & 0x3F]
    return t


def midi_of(n):
    return 12 * (int(n[-1]) + 1) + NAMES[n[:-1]]


def nm(m):
    return '%s%d' % (NOTE_OF[m % 12], m // 12 - 1)


def stream(text, f16, noise=False):
    out, cur_inst = [], None
    for tok in text.split():
        if tok == '|':
            continue
        if tok[0] == '@':
            cur_inst = int(tok[1:])
            out += [0xF4, cur_inst]
            continue
        if tok[0] == 'v':
            out += [0xF0, int(tok[1:])]
            continue
        n, _, d = tok.partition('/')
        frames = int(d) * f16
        while frames > 0:
            f = min(frames, 240)
            if n == 'r':
                out += [0xFF, f]
            elif noise:
                if NOISE_INST[n] != cur_inst:
                    cur_inst = NOISE_INST[n]
                    out += [0xF4, cur_inst, 0xF0, NOISE_ATTN[n]]
                out += [NOISE[n], f]
                break
            else:
                idx = midi_of(n) - LOW + 1
                if not 1 <= idx <= 51:
                    raise SystemExit('note out of range: %s' % tok)
                out += [idx, f]
                n = 'r'                      # a long note holds by resting its tail
            frames -= f
    return out


def length(text):
    return sum(int(t.split('/')[1]) for t in text.split() if '/' in t)


# ------------------------------------------------------------------ jingles
CHORDS = {'C': [0, 4, 7], 'F': [5, 9, 12], 'G': [7, 11, 14], 'Am': [9, 12, 16],
          'Dm': [2, 5, 9], 'Em': [4, 7, 11], 'E': [4, 8, 11]}


def bass(chords, base, pat):
    out = []
    for ch in chords:
        r = base + CHORDS[ch][0]
        while r < LOW:
            r += 12
        notes = {'r': r, 'f': r + 7, 'o': r + 12}
        out += ['%s/%d' % (nm(notes[k]), d) for k, d in pat] + ['|']
    return ' '.join(out)


def arp(chords, base, order, d):
    out = []
    for ch in chords:
        t = [x + base for x in CHORDS[ch]]
        out += ['%s/%d' % (nm(t[i % 3]), d) for i in order] + ['|']
    return ' '.join(out)


def drums(bars, bar, fill):
    return ' '.join((fill if (b + 1) % 8 == 0 else bar) for b in range(bars))


# GOAL: bright fanfare in C, 8 bars, looped on the results screen
prog = ['C', 'F', 'G', 'C', 'Am', 'F', 'G', 'C']
goal = ('@10 v4 G5/2 C6/2 E6/4 D6/2 C6/2 G5/4 | A5/2 C6/2 F6/4 E6/2 C6/2 A5/4 | '
        'B5/2 D6/2 G6/4 F6/2 D6/2 B5/4 | C6/8 G5/4 C6/4 | '
        'E6/2 C6/2 A5/4 C6/2 E6/2 A6/4 | F6/2 E6/2 D6/2 C6/2 A5/4 C6/4 | '
        'D6/2 B5/2 G5/2 B5/2 D6/4 F6/4 | E6/8 C6/8')
GOAL = (goal, '@6 v6 ' + bass(prog, 36, [('r', 2), ('o', 2)] * 4),
        '@6 v8 ' + arp(prog, 60, (0, 1, 2, 1) * 4, 1),
        drums(8, 'k/2 h/2 s/2 h/2 k/2 k/2 s/2 h/2', 's/1 s/1 s/2 s/1 s/1 s/2 k/2 s/2 s/1 s/1 s/2'))

# OVER: a slow, wistful tune in A minor, 8 bars, played at half speed (f16 = 2)
prog = ['Am', 'F', 'C', 'G', 'Am', 'Dm', 'E', 'Am']
over = ('@13 v5 E5/6 D5/2 C5/4 B4/4 | A4/6 C5/2 F5/8 | E5/6 D5/2 C5/4 E5/4 | D5/12 r/4 | '
        'C5/6 B4/2 A4/4 C5/4 | D5/6 F5/2 A5/8 | G#5/6 F5/2 E5/4 D5/4 | C5/4 B4/4 A4/8')
OVER = (over, '@6 v6 ' + bass(prog, 33, [('r', 6), ('f', 2), ('o', 4), ('f', 4)]),
        '@6 v9 ' + arp(prog, 57, (0, 1, 2, 1), 4),
        drums(8, 'k/6 h/2 s/4 h/4', 'k/6 h/2 s/2 s/2 s/2 s/2'))

for name, v in (('GOAL', GOAL), ('OVER', OVER)):
    assert len({length(x) for x in v}) == 1, (name, [length(x) for x in v])


def main():
    os.makedirs(OUT, exist_ok=True)
    radio, extra = midi.load_folder(MIDI_DIR, NOISE, NOISE_INST, NOISE_ATTN)
    jingles = [('GOAL', [stream(GOAL[0], 1), stream(GOAL[1], 1), stream(GOAL[2], 1), stream(GOAL[3], 1, True)]),
               ('OVER', [stream(OVER[0], 2), stream(OVER[1], 2), stream(OVER[2], 2), stream(OVER[3], 2, True)])]
    if 'goal' in extra:
        jingles[0] = ('GOAL', extra['goal'][1])
    if 'over' in extra:
        jingles[1] = ('OVER', extra['over'][1])
    # the last station: silence (only the engine and the effects are heard)
    radio = list(radio) + [('SILENCIO', [[0xFF, 240]] * 4)]
    allsongs = radio + jingles
    nt = note_table()
    c = ['/* Generated by tools/gen_music.py -- do not edit. */', '#include "music_data.h"', '',
         'const unsigned char NOTE_TABLE[%d] = { %s };' % (len(nt), ', '.join(str(x) for x in nt))]
    entries = []
    for i, (name, vs) in enumerate(allsongs):
        # voice 0 lead, 1 bass, 2 harmony (the engine note takes it in a race), 3 noise
        for v, data in enumerate(vs):
            data = list(data) + [0]
            c.append('static const unsigned char song%d_v%d[%d] = { %s };'
                     % (i, v, len(data), ', '.join(str(x) for x in data)))
        entries.append('    { song%d_v0, song%d_v1, song%d_v2, song%d_v3, 1 },' % (i, i, i, i))
    c.append('const MusicSong music_songs[MUSIC_COUNT] = {\n%s\n};' % '\n'.join(entries))
    open(os.path.join(OUT, 'music_data.c'), 'w').write('\n'.join(c) + '\n')
    nr = len(radio)
    h = ['/* Generated by tools/gen_music.py */', '#ifndef MUSIC_DATA_H', '#define MUSIC_DATA_H',
         '#include "ngpc_types.h"',
         'typedef struct { const u8 *v0; const u8 *v1; const u8 *v2; const u8 *vn; u8 loop; } MusicSong;',
         '#define MUSIC_COUNT %d' % len(allsongs), '#define MUSIC_RADIO %d' % nr,
         '#define MUSIC_GOAL %d' % nr, '#define MUSIC_OVER %d' % (nr + 1),
         '#define MUSIC_NAMES %s' % ', '.join('"%s"' % r[0] for r in radio),
         'extern const unsigned char NOTE_TABLE[%d];' % len(nt),
         'extern const MusicSong music_songs[MUSIC_COUNT];', '#endif', '']
    open(os.path.join(OUT, 'music_data.h'), 'w').write('\n'.join(h))
    print('songs:', [s[0] for s in allsongs])


main()

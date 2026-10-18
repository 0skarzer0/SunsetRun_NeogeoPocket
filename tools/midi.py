"""Standard MIDI file -> SUNSET RUN music streams.

Drop .mid files into the `music/` folder and run the build: each file becomes
one radio station (in file-name order, up to MAX_SONGS).  A file whose name
starts with "goal" replaces the finish theme, one starting with "over" the
game over / results theme.

How a MIDI file is mapped onto the NGPC sound chip (3 square-wave voices and
one noise channel):
  * channel 10 (GM drums)      -> noise voice  (kick, snare, hats)
  * the remaining parts are ranked by average pitch:
      highest busy part         -> voice 0 (lead)
      lowest part               -> voice 1 (bass)
      another part, if any      -> voice 2 (harmony; replaced by the engine
                                   note while racing)
    A track whose name contains "lead"/"melod", "bass" or "harm"/"chord"/"pad"
    is used for that role directly.
  * every voice is monophonic: chords keep their top note (bass: the lowest)
  * notes are moved by octaves into the chip's range (G2..A6)
  * timing follows the file's tempo map exactly, rounded to 1/60 s frames
No third-party modules are needed.
"""
import os, struct

MAX_SONGS = 8
LOW = 43            # MIDI note of stream note 1 (G2)
HIGH = LOW + 50     # A6
FPS = 60.0


# ------------------------------------------------------------------ parsing
def _vlq(data, i):
    v = 0
    while True:
        b = data[i]
        i += 1
        v = (v << 7) | (b & 0x7F)
        if not b & 0x80:
            return v, i


def parse(path):
    """returns (division, tracks); track = (name, [(tick, kind, ch, a, b)])
    kind: 'on', 'off', 'tempo' (a = microseconds per quarter)"""
    data = open(path, 'rb').read()
    if data[:4] != b'MThd':
        raise ValueError('%s: not a MIDI file' % path)
    hlen = struct.unpack('>I', data[4:8])[0]
    fmt, ntrk, division = struct.unpack('>HHH', data[8:14])
    if division & 0x8000:
        raise ValueError('%s: SMPTE timing is not supported' % path)
    i = 8 + hlen
    tracks = []
    while i + 8 <= len(data) and len(tracks) < ntrk:
        cid, clen = data[i:i + 4], struct.unpack('>I', data[i + 4:i + 8])[0]
        body = data[i + 8:i + 8 + clen]
        i += 8 + clen
        if cid != b'MTrk':
            continue
        ev, name, t, j, status = [], '', 0, 0, 0
        while j < len(body):
            dt, j = _vlq(body, j)
            t += dt
            b = body[j]
            if b == 0xFF:
                typ = body[j + 1]
                ln, j = _vlq(body, j + 2)
                payload = body[j:j + ln]
                j += ln
                if typ == 0x51 and ln == 3:
                    ev.append((t, 'tempo', 0, (payload[0] << 16) | (payload[1] << 8) | payload[2], 0))
                elif typ == 0x03 and not name:
                    name = payload.decode('latin-1', 'replace')
                elif typ == 0x2F:
                    break
                continue
            if b in (0xF0, 0xF7):
                ln, j = _vlq(body, j + 1)
                j += ln
                continue
            if b & 0x80:
                status = b
                j += 1
            hi, ch = status & 0xF0, status & 0x0F
            if hi in (0xC0, 0xD0):
                j += 1
                continue
            a, v = body[j], body[j + 1]
            j += 2
            if hi == 0x90 and v > 0:
                ev.append((t, 'on', ch, a, v))
            elif hi == 0x80 or (hi == 0x90 and v == 0):
                ev.append((t, 'off', ch, a, 0))
        tracks.append((name, ev))
    return division, tracks


# ------------------------------------------------------------------ timing
def tick_to_frames(division, tempos):
    """tempos: sorted [(tick, us_per_quarter)] -> function tick -> frame"""
    tempos = sorted(tempos) or [(0, 500000)]
    if tempos[0][0] != 0:
        tempos = [(0, 500000)] + tempos
    marks = []          # (tick, frames_at_tick, frames_per_tick)
    f = 0.0
    for k, (tk, us) in enumerate(tempos):
        if marks:
            ptk, pf, rate = marks[-1]
            f = pf + (tk - ptk) * rate
        marks.append((tk, f, us / 1e6 * FPS / division))
    def conv(t):
        lo = 0
        for k in range(len(marks)):
            if marks[k][0] <= t:
                lo = k
        tk, f0, rate = marks[lo]
        return f0 + (t - tk) * rate
    return conv


# ------------------------------------------------------------------ parts
def notes_of(events):
    """pair note-ons with note-offs -> [(start_tick, end_tick, note, vel, ch)]"""
    open_ = {}
    out = []
    for t, kind, ch, a, v in events:
        if kind == 'on':
            if (ch, a) in open_:
                s, vv = open_.pop((ch, a))
                out.append((s, t, a, vv, ch))
            open_[(ch, a)] = (t, v)
        elif kind == 'off' and (ch, a) in open_:
            s, vv = open_.pop((ch, a))
            out.append((s, t, a, vv, ch))
    return out


def mono(notes, top=True):
    """reduce to one note at a time (highest or lowest wins)"""
    notes = sorted(notes, key=lambda n: (n[0], -n[2] if top else n[2]))
    out = []
    for n in notes:
        if out and out[-1][0] == n[0]:
            continue                     # same start: keep the first (top/bottom)
        if out and out[-1][1] > n[0]:
            prev = out[-1]
            out[-1] = (prev[0], n[0], prev[2], prev[3], prev[4])
        out.append(n)
    return [n for n in out if n[1] > n[0]]


def fit(note):
    while note < LOW:
        note += 12
    while note > HIGH:
        note -= 12
    return note - LOW + 1


def tone_stream(notes, conv, inst, attn, end_frame):
    out = [0xF4, inst, 0xF0, attn]
    cur = 0
    for s, e, n, v, ch in notes:
        fs, fe = int(round(conv(s))), int(round(conv(e)))
        if fe <= fs:
            fe = fs + 1
        if fs < cur:
            fs = cur
            if fe <= fs:
                continue
        gap = fs - cur
        while gap > 0:
            k = min(gap, 240)
            out += [0xFF, k]
            gap -= k
        dur = fe - fs
        first = True
        while dur > 0:
            k = min(dur, 240)
            out += ([fit(n), k] if first else [0xFF, k])
            first = False
            dur -= k
        cur = fe
    gap = end_frame - cur
    while gap > 0:
        k = min(gap, 240)
        out += [0xFF, k]
        gap -= k
    return out


DRUM = {35: 'k', 36: 'k', 37: 's', 38: 's', 39: 's', 40: 's', 41: 's', 43: 's', 45: 's', 47: 's',
        48: 's', 50: 's', 42: 'h', 44: 'h', 46: 'o', 49: 'o', 51: 'h', 52: 'o', 53: 'h', 55: 'o',
        57: 'o', 59: 'h', 54: 'h', 56: 'h', 69: 'h', 70: 'h', 75: 'h', 76: 'h', 77: 'h'}


def noise_stream(notes, conv, end_frame, noise_ctl, noise_inst, noise_attn):
    hits = {}
    for s, e, n, v, ch in notes:
        d = DRUM.get(n)
        if d is None:
            continue
        f = int(round(conv(s)))
        # one hit per frame: kick > snare > open > hat
        rank = 'kso h'.index(d) if d in 'kso' else 4
        if f not in hits or rank < hits[f][1]:
            hits[f] = (d, rank)
    out = []
    cur = 0
    cur_inst = None
    frames = sorted(hits)
    for idx, f in enumerate(frames):
        if f > cur:
            gap = f - cur
            while gap > 0:
                k = min(gap, 240)
                out += [0xFF, k]
                gap -= k
        nxt = frames[idx + 1] if idx + 1 < len(frames) else end_frame
        dur = max(1, min(240, nxt - f))
        d = hits[f][0]
        if noise_inst[d] != cur_inst:
            cur_inst = noise_inst[d]
            out += [0xF4, cur_inst, 0xF0, noise_attn[d]]
        out += [noise_ctl[d], dur]
        cur = f + dur
    gap = end_frame - cur
    while gap > 0:
        k = min(gap, 240)
        out += [0xFF, k]
        gap -= k
    return out


def song_name(path):
    base = os.path.splitext(os.path.basename(path))[0]
    keep = ''.join(ch if (ch.isalnum() or ch == ' ') else ' ' for ch in base.replace('_', ' '))
    keep = ' '.join(keep.upper().split())
    parts = keep.split(' ', 1)
    if len(parts) == 2 and parts[0].isdigit():      # "01 My song" -> "MY SONG"
        keep = parts[1]
    return (keep or 'SONG')[:16]


def convert(path, noise_ctl, noise_inst, noise_attn):
    """-> (name, [v0, v1, v2, vn] byte streams, seconds)"""
    division, tracks = parse(path)
    tempos = [(t, a) for _, ev in tracks for t, k, c, a, b in ev if k == 'tempo']
    conv = tick_to_frames(division, tempos)
    drums, parts = [], []
    for name, ev in tracks:
        ns = notes_of(ev)
        dr = [n for n in ns if n[4] == 9]
        mel = [n for n in ns if n[4] != 9]
        drums += dr
        # split a track by channel so multi-channel type-0 files work too
        for ch in sorted({n[4] for n in mel}):
            part = [n for n in mel if n[4] == ch]
            if part:
                parts.append((name.lower(), part))
    if not parts and not drums:
        raise ValueError('%s: no notes' % path)
    end_tick = max([n[1] for _, p in parts for n in p] + [n[1] for n in drums] + [0])
    end_frame = int(round(conv(end_tick)))
    # quantise the loop to a whole beat so it repeats cleanly
    def avg(p):
        return sum(n[2] for n in p) / float(len(p))
    roles = {}
    for nm, p in parts:
        for key, words in (('lead', ('lead', 'melod', 'vocal', 'voice')), ('bass', ('bass',)),
                           ('harm', ('harm', 'chord', 'pad', 'piano', 'key', 'guitar'))):
            if key not in roles and any(w in nm for w in words):
                roles[key] = p
                break
    rest = [p for nm, p in parts if not any(p is r for r in roles.values())]
    if len(parts) == 1 and not roles:
        # a single (piano-style) part: top line = lead, bottom line = bass,
        # and the second-highest note of each chord = harmony
        p = parts[0][1]
        roles['lead'] = p
        roles['bass'] = p
        starts = {}
        for n in p:
            starts.setdefault(n[0], []).append(n)
        mid = []
        for t, group in starts.items():
            if len(group) >= 3:
                group.sort(key=lambda n: -n[2])
                mid.append(group[1])
        roles['harm'] = mid
        rest = []
    rest.sort(key=avg)
    if 'bass' not in roles and rest:
        roles['bass'] = rest.pop(0)
    if 'lead' not in roles and rest:
        rest.sort(key=lambda p: (avg(p) * min(1.0, len(p) / 40.0)))
        roles['lead'] = rest.pop()
    if 'harm' not in roles and rest:
        roles['harm'] = max(rest, key=len)
    v0 = tone_stream(mono(roles.get('lead', []), True), conv, 4, 1, end_frame)
    v1 = tone_stream(mono(roles.get('bass', []), False), conv, 7, 2, end_frame)
    v2 = tone_stream(mono(roles.get('harm', []), True), conv, 13, 6, end_frame)
    vn = noise_stream(drums, conv, end_frame, noise_ctl, noise_inst, noise_attn)
    return song_name(path), [v0, v1, v2, vn], end_frame / FPS


def load_folder(folder, noise_ctl, noise_inst, noise_attn):
    """-> (radio songs, {'goal'/'over': song}); each song = (name, streams)"""
    radio, extra = [], {}
    if not os.path.isdir(folder):
        return radio, extra
    files = sorted(f for f in os.listdir(folder) if f.lower().endswith(('.mid', '.midi')))
    for f in files:
        name, streams, secs = convert(os.path.join(folder, f), noise_ctl, noise_inst, noise_attn)
        print('  music/%s -> "%s" (%.0f s, %d bytes)' % (f, name, secs, sum(len(s) for s in streams)))
        low = f.lower()
        if low.startswith(('goal', 'over')):
            extra[low[:4]] = (name, streams)
        elif len(radio) < MAX_SONGS:
            radio.append((name, streams))
        else:
            print('  (only %d radio stations: %s is left out)' % (MAX_SONGS, f))
    return radio, extra

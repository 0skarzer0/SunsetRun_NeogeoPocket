"""A small LilyPond reader, enough for the public-domain piano scores in
music/classical/ (Mutopia Project).  It understands what those files use:
variables, \\relative, Dutch and English note names, chords <...>, ties,
dotted durations, \\times / \\tuplet, \\repeat volta|unfold with
\\alternative (unfolded), << {...} \\\\ {...} >> voices and grace notes
(skipped).  Markup, scheme and layout commands are ignored.

read(path, var) -> list of notes (onset, duration, midi) in whole notes
(fractions.Fraction), for the music variable `var`.
"""
import re
from fractions import Fraction as F

DUTCH = {'c': 0, 'd': 2, 'e': 4, 'f': 5, 'g': 7, 'a': 9, 'b': 11}

# commands followed by one argument word that must be skipped
ONE_ARG = {'clef', 'key', 'time', 'partial', 'mark', 'change', 'set', 'override', 'unset',
           'revert', 'once', 'tempo', 'include', 'version', 'bar', 'ottava', 'tweak', 'context'}
GRACE = {'grace', 'acciaccatura', 'appoggiatura', 'slashedGrace', 'afterGrace'}


def tokenize(text):
    text = re.sub(r'%\{.*?%\}', ' ', text, flags=re.S)
    text = re.sub(r'%[^\n]*', ' ', text)
    toks = []
    i, n = 0, len(text)
    while i < n:
        c = text[i]
        if c.isspace():
            i += 1
        elif c == '"':
            j = i + 1
            while j < n and text[j] != '"':
                j += 2 if text[j] == '\\' else 1
            toks.append(('str', text[i + 1:j]))
            i = j + 1
        elif c == '#':
            # scheme: #'(...) / #(...) / #word
            j = i + 1
            while j < n and text[j] in "'`":
                j += 1
            if j < n and text[j] == '(':
                depth = 0
                while j < n:
                    if text[j] == '(':
                        depth += 1
                    elif text[j] == ')':
                        depth -= 1
                        if depth == 0:
                            j += 1
                            break
                    j += 1
            else:
                while j < n and not text[j].isspace() and text[j] not in '{}<>':
                    j += 1
            toks.append(('scheme', text[i:j]))
            i = j
        elif text.startswith('<<', i) or text.startswith('>>', i) or text.startswith('\\\\', i):
            toks.append(('op', text[i:i + 2]))
            i += 2
        elif c in '{}<>|~':
            toks.append(('op', c))
            i += 1
        elif c == '\\':
            m = re.match(r'\\([A-Za-z][A-Za-z\-]*)', text[i:])
            if m:
                toks.append(('cmd', m.group(1)))
                i += m.end()
            else:
                # articulation like \! \< \> \(
                toks.append(('art', text[i:i + 2]))
                i += 2
        elif c in '-_^':
            # articulations / fingerings / scripts attached to a note
            j = i + 1
            if j < n and text[j] == '\\':
                m = re.match(r'\\[A-Za-z!<>]+', text[j:])
                j += m.end() if m else 1
            elif j < n and text[j] == '"':
                j += 1
                while j < n and text[j] != '"':
                    j += 1
                j += 1
            elif j < n:
                j += 1
            toks.append(('art', text[i:j]))
            i = j
        elif c in '()[]':
            i += 1
        else:
            m = re.match(r"[A-Za-z]+|[0-9]+\.*(\*[0-9/]+)?|[',!?.=/:*]|[^\s]", text[i:])
            toks.append(('word', m.group(0)))
            i += m.end()
    return toks


class Reader:
    def __init__(self, text):
        self.toks = tokenize(text)
        self.vars = {}
        self.english = 'english.ly' in text
        self.collect_vars()

    def collect_vars(self):
        t = self.toks
        i = 0
        while i < len(t) - 2:
            if t[i][0] == 'word' and re.match(r'^[A-Za-z]+$', t[i][1]) and t[i + 1] == ('word', '=') \
                    and (t[i + 2] == ('op', '{') or t[i + 2] == ('cmd', 'relative')):
                j = i + 2
                start = j
                # skip \relative pitch, or take a braced block
                while j < len(t) and t[j] != ('op', '{'):
                    if t[j][0] == 'op' and t[j][1] in ('<<',):
                        break
                    j += 1
                if j < len(t) and t[j] == ('op', '{'):
                    depth = 0
                    k = j
                    while k < len(t):
                        if t[k] == ('op', '{'):
                            depth += 1
                        elif t[k] == ('op', '}'):
                            depth -= 1
                            if depth == 0:
                                break
                        k += 1
                    self.vars[t[i][1]] = t[start:k + 1]
                    i = k + 1
                    continue
            i += 1

    # -------------------------------------------------------------- pitches
    def parse_pitch(self, w):
        """'fis' / 'fs' / 'bes' / 'bf' -> semitone class, or None"""
        if not w or w[0] not in DUTCH:
            return None
        base = DUTCH[w[0]]
        rest = w[1:]
        acc = 0
        if self.english:
            m = re.fullmatch(r'(s|f|ss|ff|sharp|flat|x)?', rest)
            if not m:
                return None
            acc = {'': 0, None: 0, 's': 1, 'f': -1, 'ss': 2, 'ff': -2, 'sharp': 1, 'flat': -1, 'x': 2}[m.group(1) or '']
        else:
            m = re.fullmatch(r'((?:is)*|(?:es)*|(?:s)?)', rest)
            if not m:
                return None
            if rest.startswith('is'):
                acc = len(rest) // 2
            elif rest.startswith('es'):
                acc = -(len(rest) // 2)
            elif rest == 's':           # as, es (Dutch a-flat, e-flat)
                acc = -1
        return base, acc

    def rel(self, step, acc, octs, ref):
        """relative mode: the note closest to ref (by note name), then octave marks"""
        ref_step, ref_oct = ref
        names = 'cdefgab'
        best = None
        for o in (ref_oct - 1, ref_oct, ref_oct + 1):
            d = (o * 7 + names.index(step)) - (ref_oct * 7 + names.index(ref_step))
            if -3 <= d <= 3:
                if best is None or abs(d) < abs(best[1]):
                    best = (o, d)
        o = best[0] + octs
        return o

    # -------------------------------------------------------------- music
    def music(self, var):
        self.out = []
        t = self.expand(self.vars[var])
        self.pos = 0
        self.t = t
        self.dur = F(1, 4)
        self.ref = None
        self.time = F(0)
        self.tie_from = {}
        self.seq(F(0))
        return sorted(self.out)

    def expand(self, toks, depth=0):
        """inline \\variable references"""
        out = []
        for tk in toks:
            if tk[0] == 'cmd' and tk[1] in self.vars and depth < 5:
                out += self.expand(self.vars[tk[1]], depth + 1)
            else:
                out.append(tk)
        return out

    def peek(self):
        return self.t[self.pos] if self.pos < len(self.t) else (None, None)

    def take(self):
        tk = self.peek()
        self.pos += 1
        return tk

    def block(self):
        """parse a { ... } or << ... >> block at self.pos; returns its length"""
        tk = self.peek()
        if tk == ('op', '{'):
            self.take()
            start = self.time
            self.seq_until('}')
            return self.time - start
        if tk == ('op', '<<'):
            self.take()
            start = self.time
            ref0, dur0 = self.ref, self.dur
            longest = F(0)
            while True:
                self.time = start
                self.ref, self.dur = (ref0, dur0)
                if self.peek() == ('op', '{'):
                    ln = self.block()
                else:
                    ln = self.seq_until_any(('\\\\', '>>'))
                longest = max(longest, ln)
                tk = self.peek()
                if tk == ('op', '\\\\'):
                    self.take()
                    continue
                if tk == ('op', '>>'):
                    self.take()
                    break
                if tk[0] is None:
                    break
            self.time = start + longest
            return longest
        # a single event
        start = self.time
        self.event()
        return self.time - start

    def seq(self, start):
        self.time = start
        if self.peek() == ('op', '{'):
            self.block()
        else:
            while self.peek()[0] is not None:
                self.event()

    def seq_until(self, close):
        while True:
            tk = self.peek()
            if tk[0] is None:
                return
            if tk == ('op', close):
                self.take()
                return
            self.event()

    def seq_until_any(self, closes):
        start = self.time
        while True:
            tk = self.peek()
            if tk[0] is None or (tk[0] == 'op' and tk[1] in closes):
                return self.time - start
            self.event()

    def duration(self):
        tk = self.peek()
        if tk[0] == 'word' and re.match(r'^[0-9]+\.*', tk[1]):
            self.take()
            m = re.match(r'^([0-9]+)(\.*)(\*([0-9]+)(/([0-9]+))?)?', tk[1])
            d = F(1, int(m.group(1)))
            add = d
            for _ in m.group(2):
                add /= 2
                d += add
            if m.group(3):
                d *= int(m.group(4))
                if m.group(6):
                    d /= int(m.group(6))
            self.dur = d
        return self.dur

    def octave_marks(self):
        o = 0
        while True:
            tk = self.peek()
            if tk == ('word', "'"):
                o += 1
                self.take()
            elif tk == ('word', ','):
                o -= 1
                self.take()
            elif tk in (('word', '!'), ('word', '?')):
                self.take()
            else:
                return o

    def note(self, w):
        p = self.parse_pitch(w)
        step = w[0]
        octs = self.octave_marks()
        if self.ref is None:
            o = 3 + octs              # absolute: c = C3
        else:
            o = self.rel(step, p[1], octs, self.ref)
        self.ref = (step, o)
        return 12 * (o + 1) + DUTCH[step] + p[1]

    def add(self, midi, dur, tied_in):
        if tied_in and midi in self.tie_from:
            k = self.tie_from[midi]
            on, d, m = self.out[k]
            self.out[k] = (on, d + dur, m)
        else:
            self.out.append((self.time, dur, midi))
        self.tie_from.pop(midi, None)

    def event(self):
        tk = self.take()
        kind, v = tk
        if kind == 'cmd':
            if v == 'relative':
                nxt = self.peek()
                if nxt[0] == 'word' and self.parse_pitch(nxt[1]) is not None:
                    self.take()
                    octs = self.octave_marks()
                    self.ref = (nxt[1][0], 3 + octs)
                else:
                    self.ref = ('f', 3)
                self.block()
                return
            if v in ('times', 'tuplet'):
                frac = self.take()[1]
                if self.peek() == ('word', '/'):
                    self.take()
                    frac = frac + '/' + self.take()[1]
                a, b = [int(x) for x in frac.split('/')]
                ratio = F(a, b) if v == 'times' else F(b, a)
                start = self.time
                saved = self.out
                self.out = []
                self.block()
                inner = self.out
                for on, d, m in inner:
                    saved.append((start + (on - start) * ratio, d * ratio, m))
                self.out = saved
                self.time = start + (self.time - start) * ratio
                return
            if v == 'repeat':
                kindw = self.take()[1]
                count = int(self.take()[1])
                body_start = self.pos
                self.block()
                body_end = self.pos
                alts = []
                if self.peek() == ('cmd', 'alternative'):
                    self.take()
                    assert self.take() == ('op', '{')
                    while self.peek() != ('op', '}'):
                        a0 = self.pos
                        self.skip_block()
                        alts.append((a0, self.pos))
                    self.take()
                after = self.pos
                # replay: body, alternative i, body, ...
                times = count if kindw in ('volta', 'unfold', 'percent', 'tremolo') else 1
                self.pos = body_end      # first pass already done
                for r in range(times):
                    if r > 0:
                        self.pos = body_start
                        self.block()
                    if alts:
                        a0, a1 = alts[min(r, len(alts) - 1)]
                        self.pos = a0
                        self.block()
                self.pos = after
                return
            if v in GRACE:
                start, saved = self.time, self.out
                self.out = []
                self.block()
                self.out, self.time = saved, start
                return
            if v in ('markup',):
                self.skip_markup()
                return
            if v in ONE_ARG:
                self.skip_args(v)
                return
            if v in ('new', 'context'):
                self.take()
                if self.peek() == ('word', '='):
                    self.take()
                    self.take()
                return
            if v == 'transpose':
                raise SystemExit('\\transpose not supported')
            return                      # \voiceOne, \stemUp, \break, ...
        if kind == 'op':
            if v in ('{', '<<'):
                self.pos -= 1
                self.block()
            elif v == '<':
                notes = []
                first_ref = None
                while self.peek() != ('op', '>'):
                    tk2 = self.take()
                    if tk2[0] == 'word' and self.parse_pitch(tk2[1]) is not None:
                        m = self.note(tk2[1])
                        if first_ref is None:
                            first_ref = self.ref
                        notes.append(m)
                    elif tk2[0] is None:
                        break
                self.take()
                d = self.duration()
                tied = self.peek() == ('op', '~')
                self.ref = first_ref or self.ref
                for m in notes:
                    self.add(m, d, m in self.tie_from)
                self.after_note(notes, d)
            return
        if kind == 'art':
            if 'markup' in v:
                self.skip_markup()
            return
        if kind == 'word':
            if v in ('r', 'R', 's'):
                d = self.duration()
                self.time += d
                self.tie_from = {}
                return
            if self.parse_pitch(v) is not None and re.fullmatch(r'[a-g][a-z]*', v):
                m = self.note(v)
                d = self.duration()
                self.add(m, d, m in self.tie_from)
                self.after_note([m], d)
                return
        return

    def after_note(self, notes, d):
        # a tie after the note: remember these pitches to extend the next ones
        k = self.pos
        while k < len(self.t) and self.t[k][0] == 'art':
            k += 1
        if k < len(self.t) and self.t[k] == ('op', '~'):
            for m in notes:
                for idx in range(len(self.out) - 1, -1, -1):
                    if self.out[idx][2] == m:
                        self.tie_from[m] = idx
                        break
        self.time += d

    def skip_block(self):
        tk = self.take()
        if tk == ('op', '{'):
            depth = 1
            while depth and self.peek()[0] is not None:
                t2 = self.take()
                if t2 == ('op', '{'):
                    depth += 1
                elif t2 == ('op', '}'):
                    depth -= 1

    def skip_markup(self):
        tk = self.peek()
        if tk == ('op', '{'):
            self.skip_block()
        elif tk[0] == 'cmd':
            self.take()
            # \markup \italic "x" / \markup \column { ... }
            while self.peek()[0] in ('cmd', 'scheme'):
                self.take()
            if self.peek() == ('op', '{'):
                self.skip_block()
            else:
                self.take()
        else:
            self.take()

    def skip_args(self, v):
        if v in ('key',):
            self.take()
            if self.peek()[0] == 'cmd':
                self.take()
        elif v == 'time':
            self.take()
            if self.peek() == ('word', '/'):
                self.take()
                self.take()
        elif v == 'tempo':
            # \tempo "text" 4=138  |  \tempo 4=138
            if self.peek()[0] == 'str':
                self.take()
            if self.peek()[0] == 'word' and self.peek()[1][0].isdigit():
                self.take()
                if self.peek() == ('word', '='):
                    self.take()
                    self.take()
        elif v == 'partial':
            keep = self.dur
            self.duration()
            self.dur = keep
        elif v == 'change':
            # \change Staff = "down"
            self.take()
            if self.peek() == ('word', '='):
                self.take()
                self.take()
        elif v in ('override', 'set', 'once', 'revert', 'unset', 'tweak'):
            # \override Score.X.Y = #value | \once \override ...
            if v == 'once':
                return
            while self.peek()[0] == 'word' and self.peek()[1] not in ('=',) and not re.match(r'^[0-9]', self.peek()[1]):
                self.take()
                if self.peek() == ('word', '.'):
                    self.take()
            if self.peek()[0] == 'scheme':
                self.take()
            if self.peek() == ('word', '='):
                self.take()
                tk = self.take()
                if tk == ('op', '{'):
                    self.pos -= 1
                    self.skip_block()
        elif v == 'mark':
            if self.peek()[0] == 'cmd' and self.peek()[1] == 'markup':
                self.take()
                self.skip_markup()
            else:
                self.take()
        else:
            self.take()


def read(path, var):
    return Reader(open(path, encoding='utf-8-sig').read()).music(var)

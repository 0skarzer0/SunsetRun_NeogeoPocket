"""cpp.py - a small C preprocessor in pure Python for the c900 compiler.

Used when gcc is not available (e.g. on Windows).  It implements what the
SUNSET RUN sources need: #include "..." / <...> with -I paths, object- and
function-like macros (with # stringising and ## pasting), #if / #elif / #ifdef
/ #ifndef / #else / #endif with defined(), #undef and #error.
Checked against `gcc -E` on every source file of the project (token for token).
"""
import os, re

TOKEN = re.compile(r'''
    (?P<ws>[ \t\r\f\v]+) |
    (?P<nl>\n) |
    (?P<id>[A-Za-z_]\w*) |
    (?P<num>\.?\d(?:[eEpP][+-]|[\w.])*) |
    (?P<str>"(?:\\.|[^"\\\n])*") |
    (?P<chr>'(?:\\.|[^'\\\n])*') |
    (?P<punct>\#\#|<<=|>>=|\.\.\.|->|\+\+|--|<<|>>|<=|>=|==|!=|&&|\|\||[-+*/%&|^=<>]=|[^\s])
''', re.X)


class CppError(Exception):
    pass


def tokenize(text):
    out = []
    for m in TOKEN.finditer(text):
        kind = m.lastgroup
        out.append((kind, m.group()))
    return out


def strip_comments(text):
    """remove comments (keeping newlines) and splice continued lines"""
    text = text.replace('\r\n', '\n').replace('\\\n', '')
    out, i, n = [], 0, len(text)
    while i < n:
        c = text[i]
        if c == '/' and i + 1 < n and text[i + 1] == '*':
            j = text.find('*/', i + 2)
            if j < 0:
                j = n - 2
            out.append(' ' + '\n' * text.count('\n', i, j))
            i = j + 2
        elif c == '/' and i + 1 < n and text[i + 1] == '/':
            j = text.find('\n', i)
            i = n if j < 0 else j
        elif c in '"\'':
            j = i + 1
            while j < n and text[j] != c and text[j] != '\n':
                j += 2 if text[j] == '\\' else 1
            out.append(text[i:j + 1])
            i = j + 1
        else:
            out.append(c)
            i += 1
    return ''.join(out)


class Macro(object):
    def __init__(self, name, params, body):
        self.name, self.params, self.body = name, params, body   # params None: object-like


class Preprocessor(object):
    def __init__(self, includes=(), defines=()):
        self.includes = list(includes)
        self.macros = {}
        for d in defines:
            name, _, val = d.partition('=')
            self.define_text('%s %s' % (name, val if _ else '1'))

    # ------------------------------------------------------------ macros
    def define_text(self, text):
        m = re.match(r'\s*([A-Za-z_]\w*)(\([^)]*\))?(.*)$', text, re.S)
        if not m:
            raise CppError('bad #define: %s' % text)
        name, params, body = m.group(1), m.group(2), m.group(3)
        if params is not None:
            params = [p.strip() for p in params[1:-1].split(',') if p.strip()]
        toks = [t for t in tokenize(body.strip()) if t[0] != 'nl']
        self.macros[name] = Macro(name, params, toks)

    def expand(self, toks, hide=frozenset()):
        out = []
        i, n = 0, len(toks)
        while i < n:
            kind, val = toks[i]
            mac = self.macros.get(val) if kind == 'id' and val not in hide else None
            if mac is None:
                out.append(toks[i])
                i += 1
                continue
            if mac.params is None:
                body = self.substitute(mac, {})
                out += self.expand(body, hide | {val})
                i += 1
                continue
            # function-like: needs '(' (skipping blanks)
            j = i + 1
            while j < n and toks[j][0] in ('ws', 'nl'):
                j += 1
            if j >= n or toks[j][1] != '(':
                out.append(toks[i])
                i += 1
                continue
            args, cur, depth = [], [], 0
            j += 1
            while j < n:
                t = toks[j]
                if t[1] == '(':
                    depth += 1
                elif t[1] == ')':
                    if depth == 0:
                        break
                    depth -= 1
                elif t[1] == ',' and depth == 0:
                    args.append(cur)
                    cur = []
                    j += 1
                    continue
                cur.append(t)
                j += 1
            if j >= n:
                raise CppError('unterminated call of macro %s' % val)
            args.append(cur)
            if len(mac.params) == 0 and len(args) == 1 and not [a for a in args[0] if a[0] not in ('ws', 'nl')]:
                args = []
            if len(args) != len(mac.params):
                raise CppError('macro %s expects %d arguments, got %d' % (val, len(mac.params), len(args)))
            amap = dict(zip(mac.params, [self.trim(a) for a in args]))
            body = self.substitute(mac, amap)
            out += self.expand(body, hide | {val})
            i = j + 1
        return out

    @staticmethod
    def trim(toks):
        toks = [('ws', ' ') if t[0] == 'nl' else t for t in toks]
        while toks and toks[0][0] == 'ws':
            toks = toks[1:]
        while toks and toks[-1][0] == 'ws':
            toks = toks[:-1]
        return toks

    def substitute(self, mac, amap):
        body = mac.body
        res = []
        i = 0
        while i < len(body):
            kind, val = body[i]
            if val == '#' and mac.params is not None:
                j = i + 1
                while j < len(body) and body[j][0] == 'ws':
                    j += 1
                if j < len(body) and body[j][1] in amap:
                    s = ''.join(' ' if t[0] == 'ws' else t[1] for t in amap[body[j][1]])
                    res.append(('str', '"%s"' % s.replace('\\', '\\\\').replace('"', '\\"')))
                    i = j + 1
                    continue
            if kind == 'id' and val in amap:
                # operands of ## are not macro-expanded
                prev = next((t for t in reversed(res) if t[0] != 'ws'), None)
                nxt = next((t for t in body[i + 1:] if t[0] != 'ws'), None)
                raw = (prev is not None and prev[1] == '##') or (nxt is not None and nxt[1] == '##')
                res += amap[val] if raw else self.expand(amap[val])
                i += 1
                continue
            res.append(body[i])
            i += 1
        # token pasting
        out = []
        i = 0
        while i < len(res):
            if res[i][1] == '##':
                while out and out[-1][0] == 'ws':
                    out.pop()
                j = i + 1
                while j < len(res) and res[j][0] == 'ws':
                    j += 1
                left = out.pop()[1] if out else ''
                right = res[j][1] if j < len(res) else ''
                pasted = tokenize(left + right)
                out += pasted
                i = j + 1
                continue
            out.append(res[i])
            i += 1
        return out

    # ------------------------------------------------------------ #if
    def eval_if(self, text, where):
        toks = tokenize(text)
        resolved = []
        i = 0
        while i < len(toks):
            kind, val = toks[i]
            if val == 'defined':
                j = i + 1
                while toks[j][0] == 'ws':
                    j += 1
                if toks[j][1] == '(':
                    j += 1
                    while toks[j][0] == 'ws':
                        j += 1
                    name = toks[j][1]
                    j += 1
                    while toks[j][1] != ')':
                        j += 1
                else:
                    name = toks[j][1]
                resolved.append(('num', '1' if name in self.macros else '0'))
                i = j + 1
                continue
            resolved.append(toks[i])
            i += 1
        expr = []
        for kind, val in self.expand(resolved):
            if kind == 'id':
                expr.append('0')
            elif kind == 'num':
                v = val.rstrip('uUlL')
                expr.append(str(int(v, 0)) if not v.startswith('0') or v == '0' or v[:2] in ('0x', '0X')
                            else str(int(v, 8)))
            elif val == '&&':
                expr.append(' and ')
            elif val == '||':
                expr.append(' or ')
            elif val == '!':
                expr.append(' not ')
            elif val == '/':
                expr.append('//')
            elif kind in ('ws', 'nl'):
                expr.append(' ')
            else:
                expr.append(val)
        try:
            return bool(eval(''.join(expr), {'__builtins__': {}}, {}))
        except Exception as e:
            raise CppError('%s: cannot evaluate #if %s (%s)' % (where, text.strip(), e))

    # ------------------------------------------------------------ files
    def find(self, name, cur_dir, angled):
        paths = ([] if angled else [cur_dir]) + self.includes
        for p in paths:
            f = os.path.join(p, name)
            if os.path.isfile(f):
                return f
        raise CppError('cannot find include file %s' % name)

    def process_file(self, path, out):
        text = strip_comments(open(path, encoding='latin-1').read())
        cur_dir = os.path.dirname(path)
        stack = []           # [active, taken, parent_active]
        active = True
        pending = []
        def flush():
            if pending:
                out.extend(self.expand(tokenize(''.join(pending))))
                del pending[:]
        lines = text.split('\n')
        for ln, line in enumerate(lines, 1):
            m = re.match(r'\s*#\s*(\w*)(.*)$', line)
            if not m:
                if active:
                    pending.append(line + '\n')
                continue
            flush()
            d, rest = m.group(1), m.group(2)
            where = '%s:%d' % (path, ln)
            if d in ('if', 'ifdef', 'ifndef'):
                if active:
                    if d == 'if':
                        cond = self.eval_if(rest, where)
                    else:
                        name = rest.split()[0]
                        cond = (name in self.macros) == (d == 'ifdef')
                else:
                    cond = False
                stack.append([cond, cond, active])
                active = active and cond
            elif d == 'elif':
                top = stack[-1]
                if top[2] and not top[1] and self.eval_if(rest, where):
                    top[0] = top[1] = True
                else:
                    top[0] = False
                active = top[0] and top[2]
            elif d == 'else':
                top = stack[-1]
                top[0] = top[2] and not top[1]
                top[1] = True
                active = top[0]
            elif d == 'endif':
                top = stack.pop()
                active = top[2]
            elif not active:
                continue
            elif d == 'define':
                self.define_text(rest)
            elif d == 'undef':
                self.macros.pop(rest.split()[0], None)
            elif d == 'include':
                inc = rest.strip()
                if not inc.startswith(('"', '<')):
                    inc = ''.join(t[1] for t in self.expand(tokenize(inc))).strip()
                angled = inc.startswith('<')
                f = self.find(inc[1:-1], cur_dir, angled)
                self.process_file(f, out)
            elif d == 'error':
                raise CppError('%s: #error %s' % (where, rest.strip()))
            elif d in ('pragma', 'line', ''):
                pass
            else:
                raise CppError('%s: unknown directive #%s' % (where, d))
        flush()
        if stack:
            raise CppError('%s: unterminated #if' % path)


def preprocess(path, includes=(), defines=()):
    pp = Preprocessor(includes, defines)
    out = []
    pp.process_file(path, out)
    return ''.join(v for k, v in out)

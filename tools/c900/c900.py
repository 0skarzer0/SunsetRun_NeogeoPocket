#!/usr/bin/env python3
"""c900 - a small C89 compiler for the Toshiba TLCS-900/H (Neo Geo Pocket Color).

Front end: gcc -E + pycparser.  Back end: TLCS-900 assembly in the syntax of
the open Macroassembler AS (asl, cpu 96c141, maxmode).

Data model matches Toshiba cc900 as used by NgpCraft (-Nb2):
  char 8 (plain char unsigned), short/int 16, long 32, pointers 32 (24-bit used).
  2-byte alignment for 16/32-bit objects, structs padded to their alignment.
Calling convention (compatible with the NgpCraft assembly modules):
  arguments pushed right to left, one 4-byte slot each, caller pops;
  first argument at (xsp+4) on entry; return value in XWA (A / WA / XWA);
  callee preserves XIZ only.
"""
import shutil, sys, os, re, subprocess
from pycparser import c_parser, c_ast

# ----------------------------------------------------------------- types
class Type:
    def __init__(self, kind, **kw):
        self.kind = kind          # void int ptr arr struct func
        self.size = 0
        self.align = 1
        self.signed = False
        self.base = None
        self.n = None
        self.fields = None        # list (name, type, offset)
        self.ret = None
        self.params = None
        self.varargs = False
        self.const = False
        self.name = None
        self.union = False
        self.complete = True
        for k, v in kw.items():
            setattr(self, k, v)

    def __repr__(self):
        if self.kind == 'int':
            return '%s%d' % ('s' if self.signed else 'u', self.size * 8)
        if self.kind == 'ptr':
            return '*' + repr(self.base)
        if self.kind == 'arr':
            return '%r[%s]' % (self.base, self.n)
        if self.kind == 'struct':
            return 'struct ' + str(self.name)
        if self.kind == 'func':
            return 'fn(%s)->%r' % (self.params, self.ret)
        return self.kind

def t_int(size, signed):
    return Type('int', size=size, align=min(size, 2), signed=signed)

VOID = Type('void', size=0)
U8, S8 = t_int(1, False), t_int(1, True)
U16, S16 = t_int(2, False), t_int(2, True)
U32, S32 = t_int(4, False), t_int(4, True)
INT, UINT, LONG, ULONG = S16, U16, S32, U32

def t_ptr(base):
    return Type('ptr', size=4, align=2, base=base)

def t_arr(base, n):
    t = Type('arr', base=base, n=n, align=base.align)
    t.size = base.size * n if n is not None else 0
    return t

def t_func(ret, params, varargs=False):
    return Type('func', ret=ret, params=params, varargs=varargs, size=4)

def is_int(t): return t.kind == 'int'
def is_ptr(t): return t.kind == 'ptr'
def is_scalar(t): return t.kind in ('int', 'ptr')

def decay(t):
    if t.kind == 'arr':
        return t_ptr(t.base)
    if t.kind == 'func':
        return t_ptr(t)
    return t

def promote(t):
    if t.kind == 'int' and t.size == 1:
        return INT
    return t

def arith_conv(a, b):
    a, b = promote(a), promote(b)
    if a.size == 4 or b.size == 4:
        if (a.size == 4 and not a.signed) or (b.size == 4 and not b.signed):
            return ULONG
        return LONG
    if not a.signed or not b.signed:
        return UINT
    return INT

class CompileError(Exception):
    pass

# ----------------------------------------------------------------- registers
REGS = ['xwa', 'xbc', 'xde', 'xhl']
SUB = {
    'xwa': {1: 'a', 2: 'wa', 4: 'xwa'}, 'xbc': {1: 'c', 2: 'bc', 4: 'xbc'},
    'xde': {1: 'e', 2: 'de', 4: 'xde'}, 'xhl': {1: 'l', 2: 'hl', 4: 'xhl'},
    'xix': {1: 'ixl', 2: 'ix', 4: 'xix'}, 'xiy': {1: 'iyl', 2: 'iy', 4: 'xiy'},
    'xiz': {1: 'izl', 2: 'iz', 4: 'xiz'},
}
VAR_REGS = ['xiz', 'xix', 'xiy']
Q = {'xwa': 'qwa', 'xbc': 'qbc', 'xde': 'qde', 'xhl': 'qhl'}
SFX = {1: 'b', 2: 'w', 4: 'l'}

def R(reg, size):
    return SUB[reg][size]

# operand: ('imm', value) | ('abs', expr_string) | ('sp', frame_offset)
#        | ('ind', basereg, disp)
class Op:
    def __init__(self, kind, a=None, b=0):
        self.kind, self.a, self.b = kind, a, b

# ----------------------------------------------------------------- constants
def wrap(v, t):
    if t.kind == 'ptr':
        return v & 0xFFFFFFFF
    bits = t.size * 8
    v &= (1 << bits) - 1
    if t.signed and v >= 1 << (bits - 1):
        v -= 1 << bits
    return v

def parse_int_const(s):
    s0 = s
    s = s.lower()
    suf = ''
    while s and s[-1] in 'ul':
        suf = s[-1] + suf
        s = s[:-1]
    if s.startswith('0x'):
        v = int(s, 16); dec = False
    elif s.startswith('0') and len(s) > 1:
        v = int(s, 8); dec = False
    else:
        v = int(s); dec = True
    u = 'u' in suf
    l = 'l' in suf
    if not u and not l:
        if v <= 0x7FFF: return v, INT
        if not dec and v <= 0xFFFF: return v, UINT
        if v <= 0x7FFFFFFF: return v, LONG
        return v, ULONG
    if u and not l:
        if v <= 0xFFFF: return v, UINT
        return v, ULONG
    if l and not u:
        if v <= 0x7FFFFFFF: return v, LONG
        return v, ULONG
    return v, ULONG

def parse_char_const(s):
    body = s[1:-1]
    v = unescape(body)
    return v[0] if v else 0

def unescape(body):
    out = []
    i = 0
    while i < len(body):
        c = body[i]
        if c == '\\':
            i += 1
            c = body[i]
            m = {'n': 10, 't': 9, 'r': 13, '0': 0, '\\': 92, "'": 39, '"': 34, 'a': 7, 'b': 8, 'f': 12, 'v': 11}
            if c == 'x':
                j = i + 1
                while j < len(body) and body[j] in '0123456789abcdefABCDEF':
                    j += 1
                out.append(int(body[i + 1:j], 16) & 255)
                i = j
                continue
            if c in '01234567':
                j = i
                while j < len(body) and j < i + 3 and body[j] in '01234567':
                    j += 1
                out.append(int(body[i:j], 8) & 255)
                i = j
                continue
            out.append(m.get(c, ord(c)))
            i += 1
        else:
            out.append(ord(c))
            i += 1
    return out

# ----------------------------------------------------------------- symbols
class Sym:
    def __init__(self, kind, name, type=None, label=None, **kw):
        self.kind = kind       # var func typedef enum local static
        self.name = name
        self.type = type
        self.label = label
        self.value = None
        self.offset = None
        self.storage = None
        self.defined = False
        self.interrupt = False
        for k, v in kw.items():
            setattr(self, k, v)

class GlobalObj:
    """A global object to lay out: section 'rom', 'data' or 'bss'."""
    def __init__(self, label, type, section, items=None, header=False):
        self.label = label
        self.type = type
        self.section = section
        self.items = items     # list of (size, value) ; value int or (label, off)
        self.header = header

# ----------------------------------------------------------------- compiler
class Compiler:
    label_counter = [0]

    def __init__(self, tuid, srcname):
        self.tuid = tuid
        self.src = srcname
        self.globals = {}          # name -> Sym
        self.tags = [{}]           # struct/union/enum tags scopes
        self.scopes = []           # local scopes: list of dict
        self.code = []             # asm lines (code)
        self.objs = []             # GlobalObj
        self.strings = {}
        self.typedefs_seen = {}
        self.isr_names = set()
        self.func = None
        self.case_labels = {}
        self.dry = False
        self.reg_plan = {}
        self.live_var_regs = set()
        self.ra_stats = {}
        self.ra_calls = 0
        self.ra_asm = False
        self.loop_depth = 0
        self.sym_seq = 0

    # ---------------- utilities
    def newlab(self):
        Compiler.label_counter[0] += 1
        return 'L%d' % Compiler.label_counter[0]

    def emit(self, s):
        self.code.append('\t' + s)

    def label(self, l):
        self.code.append(l + ':')

    def err(self, node, msg):
        coord = getattr(node, 'coord', None)
        raise CompileError('%s: %s: %s' % (self.src, coord, msg))

    # ---------------- type resolution
    def lookup(self, name):
        for sc in reversed(self.scopes):
            if name in sc:
                return sc[name]
        return self.globals.get(name)

    def lookup_tag(self, name):
        for sc in reversed(self.tags):
            if name in sc:
                return sc[name]
        return None

    def base_type(self, names):
        names = [n for n in names if n not in ('signed',)] if names != ['signed'] else ['int']
        signed_kw = None
        n = list(names)
        sign = True
        if 'unsigned' in n:
            sign = False
            n.remove('unsigned')
        if not n:
            n = ['int']
        if n == ['char']:
            return t_int(1, False if 'unsigned' in names else (('signed' in names) and True or False)) if False else (U8 if 'unsigned' in names else (S8 if 'signed' in names else U8))
        if 'char' in n:
            return U8 if not sign else S8
        if 'short' in n:
            return t_int(2, sign)
        if 'long' in n:
            return t_int(4, sign)
        if 'int' in n:
            return t_int(2, sign)
        if n == ['void']:
            return VOID
        if 'float' in n or 'double' in n:
            raise CompileError('floating point not supported')
        raise CompileError('unknown type %r' % names)

    def resolve(self, node):
        """Resolve a pycparser type node to Type."""
        if isinstance(node, c_ast.TypeDecl):
            t = self.resolve(node.type)
            if 'const' in (node.quals or []):
                t = self.qual_const(t)
            return t
        if isinstance(node, c_ast.IdentifierType):
            names = node.names
            if len(names) == 1:
                s = self.lookup(names[0])
                if s is not None and s.kind == 'typedef':
                    return s.type
            if 'signed' in names and 'char' in names:
                return S8
            return self.base_type(names)
        if isinstance(node, c_ast.PtrDecl):
            t = t_ptr(self.resolve(node.type))
            if 'const' in (node.quals or []):
                t = self.qual_const(t)
            return t
        if isinstance(node, c_ast.ArrayDecl):
            base = self.resolve(node.type)
            n = None
            if node.dim is not None:
                n = self.const_int(node.dim)
                if n < 0:
                    self.err(node, 'negative array size (static assertion failed)')
            return t_arr(base, n)
        if isinstance(node, c_ast.FuncDecl):
            ret = self.resolve(node.type)
            params = []
            varargs = False
            if node.args is not None:
                for p in node.args.params:
                    if isinstance(p, c_ast.EllipsisParam):
                        varargs = True
                        continue
                    if isinstance(p, c_ast.Typename) or isinstance(p, c_ast.Decl):
                        pt = self.resolve(p.type)
                        if pt.kind == 'void':
                            continue
                        params.append(decay(pt))
            else:
                params = None
            return t_func(ret, params, varargs)
        if isinstance(node, (c_ast.Struct, c_ast.Union)):
            return self.struct_type(node)
        if isinstance(node, c_ast.Enum):
            self.enum_type(node)
            return INT
        if isinstance(node, c_ast.Typename):
            return self.resolve(node.type)
        if isinstance(node, c_ast.Decl):
            return self.resolve(node.type)
        raise CompileError('cannot resolve type %s' % type(node).__name__)

    def qual_const(self, t):
        if t.const:
            return t
        c = Type(t.kind)
        c.__dict__.update(t.__dict__)
        c.const = True
        return c

    def struct_type(self, node):
        union = isinstance(node, c_ast.Union)
        name = node.name
        t = None
        if name is not None:
            t = self.lookup_tag(('u:' if union else 's:') + name)
            if node.decls is None:
                if t is None:
                    t = Type('struct', name=name, union=union, complete=False)
                    self.tags[-1][('u:' if union else 's:') + name] = t
                return t
            if t is None or (t.complete and t.fields is not None and len(self.tags) > 1):
                t = Type('struct', name=name, union=union, complete=False)
                self.tags[-1][('u:' if union else 's:') + name] = t
        else:
            t = Type('struct', name=None, union=union)
        if node.decls is None:
            return t
        fields = []
        off = 0
        align = 1
        size = 0
        for d in node.decls:
            if d.bitsize is not None:
                self.err(d, 'bitfields not supported')
            ft = self.resolve(d.type)
            a = ft.align
            align = max(align, a)
            if union:
                fields.append((d.name, ft, 0))
                size = max(size, ft.size)
            else:
                off = (off + a - 1) // a * a
                fields.append((d.name, ft, off))
                off += ft.size
                size = off
        size = (size + align - 1) // align * align
        t.fields = fields
        t.size = size
        t.align = align
        t.complete = True
        return t

    def enum_type(self, node):
        if node.values is None:
            return
        v = 0
        for e in node.values.enumerators:
            if e.value is not None:
                v = self.const_int(e.value)
            s = Sym('enum', e.name, INT)
            s.value = v
            if self.scopes:
                self.scopes[-1][e.name] = s
            else:
                self.globals[e.name] = s
            v += 1

    # ---------------- constant evaluation
    def const_int(self, node):
        r = self.const_eval(node)
        if r is None or not isinstance(r[0], int):
            self.err(node, 'integer constant expression expected')
        return r[0]

    def const_eval(self, node):
        """Return (value, type) where value is int or ('sym', label, off); None if not constant."""
        try:
            return self._ce(node)
        except _NotConst:
            return None

    def _ce(self, node):
        if isinstance(node, c_ast.Constant):
            if node.type in ('int', 'unsigned int', 'long int', 'unsigned long int', 'long', 'unsigned long'):
                v, t = parse_int_const(node.value)
                return wrap(v, t), t
            if node.type == 'char':
                return parse_char_const(node.value), INT
            if node.type == 'string':
                lab = self.string_label(node.value)
                return ('sym', lab, 0), t_ptr(U8)
            raise _NotConst()
        if isinstance(node, c_ast.ID):
            s = self.lookup(node.name)
            if s is None:
                raise _NotConst()
            if s.kind == 'enum':
                return s.value, INT
            if s.kind in ('var', 'static', 'func') and s.label:
                if s.type.kind in ('arr', 'func'):
                    return ('sym', s.label, 0), decay(s.type)
            raise _NotConst()
        if isinstance(node, c_ast.Cast):
            t = self.resolve(node.to_type)
            v, vt = self._ce(node.expr)
            if isinstance(v, int):
                if t.kind == 'int' or t.kind == 'ptr':
                    return wrap(v, t if t.kind == 'int' else U32), t
                raise _NotConst()
            return v, t
        if isinstance(node, c_ast.UnaryOp):
            if node.op == 'sizeof':
                return self.sizeof(node.expr), UINT
            if node.op == '&':
                return self.const_addr(node.expr)
            v, t = self._ce(node.expr)
            if not isinstance(v, int):
                raise _NotConst()
            t = promote(t)
            if node.op == '-': return wrap(-v, t), t
            if node.op == '+': return v, t
            if node.op == '~': return wrap(~v, t), t
            if node.op == '!': return (0 if v else 1), INT
            raise _NotConst()
        if isinstance(node, c_ast.BinaryOp):
            a, at = self._ce(node.left)
            b, bt = self._ce(node.right)
            op = node.op
            if not isinstance(a, int) or not isinstance(b, int):
                # address arithmetic
                if op in ('+', '-') and not isinstance(a, int) and isinstance(b, int):
                    sz = decay(at).base.size if is_ptr(decay(at)) else 1
                    off = a[2] + (b * sz if op == '+' else -b * sz)
                    return ('sym', a[1], off), at
                if op == '+' and isinstance(a, int) and not isinstance(b, int):
                    sz = decay(bt).base.size if is_ptr(decay(bt)) else 1
                    return ('sym', b[1], b[2] + a * sz), bt
                raise _NotConst()
            if op in ('&&', '||'):
                return (1 if (a and b if op == '&&' else a or b) else 0), INT
            if op in ('<<', '>>'):
                t = promote(at)
                if op == '<<': return wrap(a << b, t), t
                ua = a & ((1 << (t.size * 8)) - 1) if not t.signed else a
                return wrap(ua >> b, t), t
            if is_ptr(at) or is_ptr(bt):
                t = at if is_ptr(at) else bt
                if op == '+':
                    return wrap(a + b, U32), t
                if op == '-':
                    return wrap(a - b, U32), t
            t = arith_conv(at, bt)
            ua, ub = wrap(a, t), wrap(b, t)
            if op in ('==', '!=', '<', '>', '<=', '>='):
                r = {'==': ua == ub, '!=': ua != ub, '<': ua < ub, '>': ua > ub, '<=': ua <= ub, '>=': ua >= ub}[op]
                return (1 if r else 0), INT
            if op == '+': return wrap(ua + ub, t), t
            if op == '-': return wrap(ua - ub, t), t
            if op == '*': return wrap(ua * ub, t), t
            if op in ('/', '%'):
                if ub == 0:
                    raise _NotConst()
                q = abs(ua) // abs(ub)
                if (ua < 0) != (ub < 0):
                    q = -q
                if op == '/': return wrap(q, t), t
                return wrap(ua - q * ub, t), t
            if op == '&': return wrap(ua & ub, t), t
            if op == '|': return wrap(ua | ub, t), t
            if op == '^': return wrap(ua ^ ub, t), t
            raise _NotConst()
        if isinstance(node, c_ast.TernaryOp):
            c, _ = self._ce(node.cond)
            if not isinstance(c, int):
                raise _NotConst()
            return self._ce(node.iftrue if c else node.iffalse)
        raise _NotConst()

    def const_addr(self, node):
        if isinstance(node, c_ast.ID):
            s = self.lookup(node.name)
            if s is not None and s.kind in ('var', 'static', 'func') and s.label:
                return ('sym', s.label, 0), t_ptr(s.type)
            raise _NotConst()
        if isinstance(node, c_ast.ArrayRef):
            (b, bt) = self.const_addr(node.name) if not self.is_arr_expr_ptrconst(node.name) else self._ce(node.name)
            idx, _ = self._ce(node.subscript)
            if not isinstance(idx, int):
                raise _NotConst()
            et = bt.base
            if et.kind == 'arr' and isinstance(node.name, c_ast.ID):
                pass
            elem = self.ce_elem_type(node.name)
            return ('sym', b[1], b[2] + idx * elem.size), t_ptr(elem)
        if isinstance(node, c_ast.StructRef) and node.type == '.':
            (b, bt) = self.const_addr(node.name)
            st = bt.base
            for fname, ft, off in st.fields:
                if fname == node.field.name:
                    return ('sym', b[1], b[2] + off), t_ptr(ft)
            raise _NotConst()
        raise _NotConst()

    def is_arr_expr_ptrconst(self, node):
        return False

    def ce_elem_type(self, node):
        t = self.type_of(node)
        t = decay(t) if t.kind == 'arr' else t
        if t.kind == 'ptr':
            return t.base
        raise _NotConst()

    def sizeof(self, node):
        if isinstance(node, c_ast.Typename):
            return self.resolve(node.type).size
        return self.type_of(node).size

    def type_of(self, node):
        """Static type of an expression without generating code."""
        save_code = self.code
        self.code = []
        saved = self.save_state()
        try:
            t = self.expr_type(node)
        finally:
            self.code = save_code
            self.restore_state(saved)
        return t

    def save_state(self):
        return None

    def restore_state(self, s):
        pass

    def expr_type(self, node):
        if isinstance(node, c_ast.Constant):
            if node.type == 'string':
                return t_arr(U8, len(unescape(node.value[1:-1])) + 1)
            if node.type == 'char':
                return INT
            return parse_int_const(node.value)[1]
        if isinstance(node, c_ast.ID):
            if node.name in self.CREGS:
                return self.CREGS[node.name][1]
            s = self.lookup(node.name)
            if s is None:
                self.err(node, 'undeclared %s' % node.name)
            return s.type
        if isinstance(node, c_ast.Cast):
            return self.resolve(node.to_type)
        if isinstance(node, c_ast.ArrayRef):
            t = decay(self.expr_type(node.name))
            if not is_ptr(t):
                t = decay(self.expr_type(node.subscript))
            return t.base
        if isinstance(node, c_ast.StructRef):
            t = self.expr_type(node.name)
            if node.type == '->':
                t = decay(t).base
            return self.field(t, node.field.name, node)[0]
        if isinstance(node, c_ast.UnaryOp):
            if node.op == 'sizeof':
                return UINT
            if node.op == '&':
                return t_ptr(self.expr_type(node.expr))
            if node.op == '*':
                return decay(self.expr_type(node.expr)).base
            if node.op == '!':
                return INT
            if node.op in ('p++', 'p--', '++', '--'):
                return self.expr_type(node.expr)
            return promote(self.expr_type(node.expr))
        if isinstance(node, c_ast.BinaryOp):
            op = node.op
            if op in ('==', '!=', '<', '>', '<=', '>=', '&&', '||'):
                return INT
            lt = decay(self.expr_type(node.left))
            rt = decay(self.expr_type(node.right))
            if op in ('<<', '>>'):
                return promote(lt)
            if op == '-' and is_ptr(lt) and is_ptr(rt):
                return INT
            if is_ptr(lt):
                return lt
            if is_ptr(rt):
                return rt
            return arith_conv(lt, rt)
        if isinstance(node, c_ast.Assignment):
            return self.expr_type(node.lvalue)
        if isinstance(node, c_ast.TernaryOp):
            a = decay(self.expr_type(node.iftrue))
            b = decay(self.expr_type(node.iffalse))
            if is_ptr(a): return a
            if is_ptr(b): return b
            if a.kind == 'void': return a
            return arith_conv(a, b)
        if isinstance(node, c_ast.FuncCall):
            ft = decay(self.expr_type(node.name))
            if is_ptr(ft) and ft.base.kind == 'func':
                return ft.base.ret
            self.err(node, 'call of non-function')
        if isinstance(node, c_ast.ExprList):
            return self.expr_type(node.exprs[-1])
        self.err(node, 'cannot type %s' % type(node).__name__)

    def field(self, st, name, node):
        if st.kind != 'struct' or st.fields is None:
            self.err(node, 'not a struct')
        for fname, ft, off in st.fields:
            if fname == name:
                return ft, off
        self.err(node, 'no field %s' % name)

    # ---------------- strings
    def string_label(self, lit):
        data = unescape(lit[1:-1]) + [0]
        key = tuple(data)
        if key in self.strings:
            return self.strings[key]
        lab = '_S%d_%d' % (self.tuid, len(self.strings))
        self.strings[key] = lab
        self.objs.append(GlobalObj(lab, t_arr(U8, len(data)), 'rom', [(1, b) for b in data]))
        return lab

    # ---------------- top level
    def compile(self, ast):
        for ext in ast.ext:
            if isinstance(ext, c_ast.FuncDef):
                self.funcdef(ext)
            elif isinstance(ext, c_ast.Decl):
                self.global_decl(ext)
            elif isinstance(ext, c_ast.Typedef):
                self.typedef(ext, self.globals)
            elif isinstance(ext, c_ast.Pragma):
                pass
            else:
                self.err(ext, 'unsupported top-level %s' % type(ext).__name__)

    def typedef(self, td, scope):
        t = self.resolve(td.type)
        scope[td.name] = Sym('typedef', td.name, t)

    def mangle(self, name, static):
        if static:
            return '_%s__%d' % (name, self.tuid)
        return '_' + name

    def global_decl(self, d):
        if d.name is None:
            # struct/enum declaration only
            self.resolve(d.type)
            return
        t = self.resolve(d.type)
        static = 'static' in (d.storage or [])
        extern = 'extern' in (d.storage or [])
        prev = self.globals.get(d.name)
        if t.kind == 'func':
            if prev is None:
                s = Sym('func', d.name, t, self.mangle(d.name, static))
                s.static = static
                self.globals[d.name] = s
            else:
                if prev.type.params is None and t.params is not None:
                    prev.type = t
                if d.name in self.isr_names:
                    prev.interrupt = True
            if d.name in self.isr_names:
                self.globals[d.name].interrupt = True
            return
        if prev is not None and prev.kind == 'var':
            s = prev
            if t.kind == 'arr' and t.n is not None:
                s.type = t
        else:
            s = Sym('var', d.name, t, self.mangle(d.name, static))
            s.static = static
            self.globals[d.name] = s
        if extern and d.init is None:
            return
        if s.defined:
            if d.init is None:
                return
            self.err(d, 'redefinition of %s' % d.name)
        s.defined = True
        self.define_object(s, t, d.init, d)

    def define_object(self, s, t, init, node):
        if t.kind == 'arr' and t.n is None:
            if init is None:
                self.err(node, 'array without size')
            if isinstance(init, c_ast.Constant) and init.type == 'string':
                n = len(unescape(init.value[1:-1])) + 1
            else:
                leaves = self.init_leaves(t_arr(t.base, None), init, node)
                end = max([o + (lt.size if not isinstance(e, tuple) else len(e[1]) + 1) for o, lt, e in leaves] + [0])
                n = (end + t.base.size - 1) // t.base.size
            t = t_arr(t.base, n)
            s.type = t
        rom = t.const or (t.kind == 'arr' and self.elem_const(t))
        if init is None:
            if rom:
                items = [(1, 0)] * t.size
                self.objs.append(GlobalObj(s.label, t, 'rom', items))
            else:
                self.objs.append(GlobalObj(s.label, t, 'bss'))
            return
        items = []
        self.init_items(t, init, items, node)
        self.objs.append(GlobalObj(s.label, t, 'rom' if rom else 'data', items))

    def elem_const(self, t):
        while t.kind == 'arr':
            t = t.base
        return t.const

    def init_leaves(self, t, init, node):
        """Flatten an initializer: list of (offset, type, expr) ; strings for char
        arrays become ('str', bytes)."""
        out = []
        class It:
            def __init__(s, lst): s.l = list(lst); s.i = 0
            def peek(s): return s.l[s.i] if s.i < len(s.l) else None
            def next(s): s.i += 1; return s.l[s.i - 1]
        def is_str(e):
            return isinstance(e, c_ast.Constant) and e.type == 'string'
        def fill(t, it, off):
            # consume from iterator `it` for object of type t at offset off
            e = it.peek()
            if e is None:
                return
            if t.kind in ('arr', 'struct'):
                if isinstance(e, c_ast.InitList):
                    it.next()
                    sub = It(e.exprs)
                    agg(t, sub, off)
                    return
                if t.kind == 'arr' and t.base.size == 1 and is_str(e):
                    it.next()
                    out.append((off, t, ('str', unescape(e.value[1:-1]))))
                    return
                agg(t, it, off)
                return
            if isinstance(e, c_ast.InitList):
                it.next()
                sub = It(e.exprs)
                fill(t, sub, off)
                return
            it.next()
            out.append((off, t, e))
        def agg(t, it, off):
            if t.kind == 'arr':
                if t.base.size == 1 and is_str(it.peek()) and len(it.l) == 1:
                    e = it.next()
                    out.append((off, t, ('str', unescape(e.value[1:-1]))))
                    return
                i = 0
                while it.peek() is not None and (t.n is None or i < t.n):
                    fill(t.base, it, off + i * t.base.size)
                    i += 1
                return
            fields = t.fields if not t.union else t.fields[:1]
            for fname, ft, foff in fields:
                if it.peek() is None:
                    break
                fill(ft, it, off + foff)
        if isinstance(init, c_ast.InitList):
            if t.kind in ('arr', 'struct'):
                agg(t, It(init.exprs), 0)
            else:
                fill(t, It(init.exprs), 0)
        elif t.kind == 'arr' and is_str(init):
            out.append((0, t, ('str', unescape(init.value[1:-1]))))
        else:
            out.append((0, t, init))
        return out

    def init_items(self, t, init, items, node):
        leaves = self.init_leaves(t, init, node)
        buf = [0] * t.size
        syms = {}
        for off, lt, e in leaves:
            if isinstance(e, tuple):
                data = e[1]
                n = lt.n if lt.n is not None else len(data) + 1
                for i in range(n):
                    if off + i < len(buf):
                        buf[off + i] = data[i] if i < len(data) else 0
                continue
            r = self.const_eval(e)
            if r is None:
                self.err(e, 'initializer is not constant')
            v, vt = r
            if isinstance(v, int):
                v = wrap(v, lt) if lt.kind == 'int' else v & 0xFFFFFFFF
                v &= (1 << (8 * lt.size)) - 1
                for i in range(lt.size):
                    buf[off + i] = (v >> (8 * i)) & 255
            else:
                if lt.size != 4:
                    self.err(e, 'address in non-pointer initializer')
                syms[off] = (v[1], v[2])
        i = 0
        while i < len(buf):
            if i in syms:
                items.append((4, syms[i]))
                i += 4
            else:
                items.append((1, buf[i]))
                i += 1

    def zero_items(self, t, items):
        for i in range(t.size):
            items.append((1, 0))

    # ---------------- functions
    def funcdef(self, fd):
        decl = fd.decl
        ft = self.resolve(decl.type)
        static = 'static' in (decl.storage or [])
        prev = self.globals.get(decl.name)
        if prev is None:
            s = Sym('func', decl.name, ft, self.mangle(decl.name, static))
            self.globals[decl.name] = s
        else:
            s = prev
            s.type = ft
        if decl.name in self.isr_names:
            s.interrupt = True
        s.defined = True
        self.func = s
        # pass 1: collect local-variable statistics, pass 2: generate with
        # the most used scalars kept in XIZ / XIX / XIY
        self.reg_plan = {}
        self.live_var_regs = set()
        self.dry = True
        self.ra_stats = {}
        self.ra_calls = 0
        self.ra_asm = False
        saved_counter = Compiler.label_counter[0]
        body, params = self.gen_body(fd, decl)
        plan = {} if (s.interrupt or self.ra_asm) else self.plan_registers()
        self.reg_plan = plan
        self.live_var_regs = set(plan.values())
        self.dry = False
        body, params = self.gen_body(fd, decl)
        self.func_regs = sorted(set(plan.values()))
        # frame: locals occupy [0, frame_max); return address at frame_max (+saved)
        N = (self.frame_max + 1) // 2 * 2
        push_iz = (not s.interrupt) and 'xiz' in self.func_regs
        saved = 28 if s.interrupt else (4 if push_iz else 0)
        self.code.append('')
        self.code.append('; function %s' % decl.name)
        self.code.append(s.label + ':')
        if s.interrupt:
            for r in ('xwa', 'xbc', 'xde', 'xhl', 'xix', 'xiy', 'xiz'):
                self.emit('push ' + r)
        if push_iz:
            self.emit('push xiz')
        if N:
            self.emit('lda xsp,(xsp-%d)' % N)
        for ps in params:
            if ps.reg:
                src = '(xsp+%d)' % (N + saved + 4 + ps.param_index * 4)
                if ps.type.size == 1:
                    self.emit('ld a,' + src)
                    self.emit('ld %s,a' % R(ps.reg, 1))
                else:
                    self.emit('ld %s,%s' % (R(ps.reg, ps.type.size), src))
        # resolve frame placeholders
        for line in body:
            self.code.append(self.fix_frame(line, N, saved))
        self.label(self.retlab)
        if N:
            self.emit('lda xsp,(xsp+%d)' % N)
        if push_iz:
            self.emit('pop xiz')
        if s.interrupt:
            for r in ('xiz', 'xiy', 'xix', 'xhl', 'xde', 'xbc', 'xwa'):
                self.emit('pop ' + r)
            self.emit('reti')
        else:
            self.emit('ret')
        self.func = None

    def gen_body(self, fd, decl):
        self.frame = 0            # bytes of locals allocated so far
        self.frame_max = 0
        self.depth = 0            # extra bytes pushed below locals
        self.used = set()
        self.retlab = self.newlab()
        self.break_stack = []
        self.cont_stack = []
        self.goto_labels = {}
        self.loop_depth = 0
        self.sym_seq = 0
        self.scopes.append({})
        self.tags.append({})
        params = []
        fdecl = decl.type
        if fdecl.args is not None:
            for p in fdecl.args.params:
                if isinstance(p, c_ast.EllipsisParam):
                    continue
                pt = self.resolve(p.type)
                if pt.kind == 'void':
                    continue
                params.append((p.name, decay(pt)))
        self.param_syms = []
        for i, (name, pt) in enumerate(params):
            ps = Sym('local', name, pt)
            ps.param_index = i
            ps.offset = None
            self.new_local_sym(ps)
            self.param_syms.append(ps)
            if name:
                self.scopes[-1][name] = ps
        save = self.code
        self.code = []
        self.stmt(fd.body)
        body = self.code
        self.code = save
        self.scopes.pop()
        self.tags.pop()
        return body, self.param_syms

    def new_local_sym(self, sym):
        sym.seq = self.sym_seq
        self.sym_seq += 1
        sym.reg = self.reg_plan.get(sym.seq) if not self.dry else None
        if self.dry:
            self.ra_stats[sym.seq] = {'w': 0, 'taken': False, 'type': sym.type}

    def note_use(self, sym):
        if self.dry and hasattr(sym, 'seq') and sym.seq in self.ra_stats:
            self.ra_stats[sym.seq]['w'] += 1 + 6 * min(self.loop_depth, 3)
            self.ra_stats[sym.seq]['name'] = sym.name

    def note_taken(self, sym):
        if self.dry and hasattr(sym, 'seq') and sym.seq in self.ra_stats:
            self.ra_stats[sym.seq]['taken'] = True

    def plan_registers(self):
        cands = []
        for seq, st in self.ra_stats.items():
            t = st['type']
            if st['taken'] or t.kind not in ('int', 'ptr') or t.size not in (1, 2, 4):
                continue
            if st['w'] < 3:
                continue
            cands.append((st['w'], seq))
        cands.sort(reverse=True)
        if os.environ.get('C900_RA_DEBUG') and self.func.name == os.environ.get('C900_RA_DEBUG'):
            sys.stderr.write('%s calls=%d cands=%s\n' % (self.func.name, self.ra_calls, [(w, self.ra_stats[q].get('name')) for w, q in cands]))
        plan = {}
        regs = list(VAR_REGS)
        for w, seq in cands:
            if not regs:
                break
            r = regs[0]
            # caller-saved registers cost a push/pop around every call
            if r != 'xiz' and self.ra_calls * 2 >= w:
                break
            plan[seq] = r
            regs.pop(0)
        return plan

    FRAME_RE = re.compile(r'\{F([LP])(-?\d+)\+(\d+)\}')

    def fix_frame(self, line, N, saved):
        def rep(m):
            kind, off, depth = m.group(1), int(m.group(2)), int(m.group(3))
            if kind == 'L':
                v = off + depth
            else:
                v = N + saved + 4 + off * 4 + depth
            return str(v)
        return self.FRAME_RE.sub(rep, line)

    # ---------------- locals
    def alloc_local(self, t):
        a = t.align
        self.frame = (self.frame + a - 1) // a * a
        off = self.frame
        self.frame += t.size
        self.frame_max = max(self.frame_max, self.frame)
        return off

    def local_decl(self, d):
        if d.name is None:
            self.resolve(d.type)
            return
        t = self.resolve(d.type)
        storage = d.storage or []
        if t.kind == 'func' or 'extern' in storage:
            if t.kind == 'func':
                g = self.globals.get(d.name)
                if g is None:
                    g = Sym('func', d.name, t, self.mangle(d.name, False))
                    self.globals[d.name] = g
                self.scopes[-1][d.name] = g
            else:
                g = self.globals.get(d.name)
                if g is None:
                    g = Sym('var', d.name, t, self.mangle(d.name, False))
                    self.globals[d.name] = g
                self.scopes[-1][d.name] = g
            return
        if 'static' in storage:
            lab = '_%s__%d_%s' % (d.name, self.tuid, self.newlab())
            s = Sym('static', d.name, t, lab)
            self.scopes[-1][d.name] = s
            if self.dry:
                s.label = '_%s__%d_pending' % (d.name, self.tuid)
                return
            self.define_object(s, t, d.init, d)
            return
        if t.kind == 'arr' and t.n is None:
            if isinstance(d.init, c_ast.InitList):
                t = t_arr(t.base, len(d.init.exprs))
            elif isinstance(d.init, c_ast.Constant) and d.init.type == 'string':
                t = t_arr(t.base, len(unescape(d.init.value[1:-1])) + 1)
        s = Sym('local', d.name, t)
        s.offset = self.alloc_local(t)
        self.new_local_sym(s)
        self.scopes[-1][d.name] = s
        if d.init is not None:
            self.local_init(s, t, d.init, 0)

    def local_init(self, s, t, init, off):
        if t.kind == 'struct' and not isinstance(init, c_ast.InitList):
            self.assign_struct(Op('sp', s.offset + off), init, t)
            return
        if t.kind in ('arr', 'struct'):
            # zero then store leaves
            self.local_zero(s, t, off)
        for loff, lt, e in self.init_leaves(t, init, None):
            if isinstance(e, tuple):
                data = e[1]
                for i in range(lt.n):
                    self.emit('ldb (xsp+%s),%d' % (self.fl(s.offset + off + loff + i), data[i] if i < len(data) else 0))
                continue
            r, sp = self.alloc2()
            vt = self.gen(e, r)
            self.convert(r, vt, lt)
            self.store(self.local_op(s, off + loff), r, lt)
            self.release(r, sp)

    def local_op(self, s, off=0):
        if getattr(s, 'reg', None) and off == 0:
            return Op('reg', s.reg, s.type.size)
        return Op('sp', s.offset + off)

    def local_zero(self, s, t, off):
        for i in range(t.size):
            self.emit('ldb (xsp+%s),0' % self.fl(s.offset + off + i))

    def fl(self, off):
        """Frame-relative placeholder for a local at frame offset off."""
        return '{FL%d+%d}' % (off, self.depth)

    def fp(self, idx, extra=0):
        return '{FP%d+%d}' % (idx, self.depth + extra)

    # ---------------- register allocation
    def alloc(self, prefer=None):
        if prefer and prefer not in self.used:
            self.used.add(prefer)
            return prefer
        for r in REGS:
            if r not in self.used:
                self.used.add(r)
                return r
        return None

    def free(self, r):
        self.used.discard(r)

    def alloc2(self, exclude=()):
        for r in REGS:
            if r not in self.used:
                self.used.add(r)
                return r, False
        for r in reversed(REGS):
            if r not in exclude:
                self.push(r)
                return r, True
        raise CompileError('no register to spill')

    def release(self, r, spilled):
        if spilled:
            self.pop(r)
        else:
            self.free(r)

    def push(self, r):
        self.emit('push ' + r)
        self.depth += 4

    def pop(self, r):
        self.emit('pop ' + r)
        self.depth -= 4

    # ---------------- statements
    def stmt(self, node):
        if node is None:
            return
        m = getattr(self, 'st_' + type(node).__name__, None)
        if m is None:
            # expression statement
            self.expr_stmt(node)
            return
        m(node)

    def st_Compound(self, node):
        self.scopes.append({})
        self.tags.append({})
        saved_frame = self.frame
        for item in node.block_items or []:
            if isinstance(item, c_ast.Decl):
                self.local_decl(item)
            elif isinstance(item, c_ast.Typedef):
                self.typedef(item, self.scopes[-1])
            else:
                self.stmt(item)
        self.frame = saved_frame
        self.scopes.pop()
        self.tags.pop()

    def st_EmptyStatement(self, node):
        pass

    def st_DeclList(self, node):
        for d in node.decls:
            self.local_decl(d)

    def st_Decl(self, node):
        self.local_decl(node)

    def expr_stmt(self, node):
        if isinstance(node, c_ast.FuncCall) and isinstance(node.name, c_ast.ID) and node.name.name == '__asm_inline':
            self.inline_asm(node)
            return
        r = self.alloc()
        self.gen(node, r, discard=True)
        self.free(r)

    def inline_asm(self, node):
        arg = node.args.exprs[0]
        if not (isinstance(arg, c_ast.Constant) and arg.type == 'string'):
            self.err(node, '__asm needs a string')
        text = ''.join(chr(c) for c in unescape(arg.value[1:-1])).strip()
        self.ra_asm = True
        self.code.append('\t' + translate_asm900(text))

    def st_Return(self, node):
        if node.expr is not None:
            rt = self.func.type.ret
            if rt.kind == 'struct':
                self.err(node, 'struct return not supported')
            r = self.alloc('xwa')
            if r != 'xwa':
                self.err(node, 'internal: xwa busy at return')
            vt = self.gen(node.expr, 'xwa')
            self.convert('xwa', vt, rt)
            self.free('xwa')
        self.emit('jr ' + self.retlab)

    def st_If(self, node):
        lfalse = self.newlab()
        self.cond(node.cond, lfalse)
        self.stmt(node.iftrue)
        if node.iffalse is not None:
            lend = self.newlab()
            self.emit('jr ' + lend)
            self.label(lfalse)
            self.stmt(node.iffalse)
            self.label(lend)
        else:
            self.label(lfalse)

    def st_While(self, node):
        self.loop_depth += 1
        try:
            self._st_While(node)
        finally:
            self.loop_depth -= 1

    def _st_While(self, node):
        ltop, lend, lcont = self.newlab(), self.newlab(), self.newlab()
        self.emit('jr ' + lcont)
        self.label(ltop)
        self.break_stack.append(lend)
        self.cont_stack.append(lcont)
        self.stmt(node.stmt)
        self.break_stack.pop()
        self.cont_stack.pop()
        self.label(lcont)
        self.cond(node.cond, ltop, jump_if_true=True)
        self.label(lend)

    def st_DoWhile(self, node):
        self.loop_depth += 1
        try:
            self._st_DoWhile(node)
        finally:
            self.loop_depth -= 1

    def _st_DoWhile(self, node):
        ltop, lend, lcont = self.newlab(), self.newlab(), self.newlab()
        self.label(ltop)
        self.break_stack.append(lend)
        self.cont_stack.append(lcont)
        self.stmt(node.stmt)
        self.break_stack.pop()
        self.cont_stack.pop()
        self.label(lcont)
        self.cond(node.cond, ltop, jump_if_true=True)
        self.label(lend)

    def st_For(self, node):
        self.loop_depth += 1
        try:
            self._st_For(node)
        finally:
            self.loop_depth -= 1

    def _st_For(self, node):
        self.scopes.append({})
        saved_frame = self.frame
        if node.init is not None:
            if isinstance(node.init, c_ast.DeclList):
                for d in node.init.decls:
                    self.local_decl(d)
            else:
                self.expr_stmt(node.init)
        ltop, lend, lcont, lcond = self.newlab(), self.newlab(), self.newlab(), self.newlab()
        if node.cond is not None:
            self.emit('jr ' + lcond)
        self.label(ltop)
        self.break_stack.append(lend)
        self.cont_stack.append(lcont)
        self.stmt(node.stmt)
        self.break_stack.pop()
        self.cont_stack.pop()
        self.label(lcont)
        if node.next is not None:
            self.expr_stmt(node.next)
        self.label(lcond)
        if node.cond is not None:
            self.cond(node.cond, ltop, jump_if_true=True)
        else:
            self.emit('jr ' + ltop)
        self.label(lend)
        self.frame = saved_frame
        self.scopes.pop()

    def st_Break(self, node):
        self.emit('jr ' + self.break_stack[-1])

    def st_Continue(self, node):
        self.emit('jr ' + self.cont_stack[-1])

    def st_Goto(self, node):
        lab = self.goto_labels.setdefault(node.name, self.newlab())
        self.emit('jr ' + lab)

    def st_Label(self, node):
        lab = self.goto_labels.setdefault(node.name, self.newlab())
        self.label(lab)
        self.stmt(node.stmt)

    def st_Switch(self, node):
        lend = self.newlab()
        # collect cases (top-level in the switch body compound)
        cases = []
        default = [None]
        def collect(n):
            if isinstance(n, c_ast.Case):
                lab = self.newlab()
                self.case_labels[id(n)] = lab
                cases.append((self.const_int(n.expr), lab))
                for s in n.stmts or []:
                    collect(s)
            elif isinstance(n, c_ast.Default):
                lab = self.newlab()
                self.case_labels[id(n)] = lab
                default[0] = lab
                for s in n.stmts or []:
                    collect(s)
            elif isinstance(n, c_ast.Compound):
                for s in n.block_items or []:
                    collect(s)
            elif isinstance(n, (c_ast.If,)):
                collect(n.iftrue); collect(n.iffalse)
            elif isinstance(n, (c_ast.While, c_ast.DoWhile, c_ast.For)):
                pass
            elif isinstance(n, c_ast.Label):
                collect(n.stmt)
        collect(node.stmt)
        r, sp = self.alloc2()
        t0 = decay(self.gen(node.cond, r))
        vt = promote(t0)
        self.convert(r, t0, vt)
        sz = vt.size
        for v, lab in cases:
            self.emit('cp %s,%d' % (R(r, sz), wrap(v, vt) & ((1 << (sz * 8)) - 1)))
            self.emit('jr z,' + lab)
        self.release(r, sp)
        self.emit('jr ' + (default[0] or lend))
        self.break_stack.append(lend)
        self.stmt(node.stmt)
        self.break_stack.pop()
        self.label(lend)

    def st_Case(self, node):
        self.label(self.case_labels[id(node)])
        for s in node.stmts or []:
            self.stmt(s)

    def st_Default(self, node):
        self.label(self.case_labels[id(node)])
        for s in node.stmts or []:
            self.stmt(s)

    # ---------------- conditions
    REL = {'==': ('z', 'z'), '!=': ('nz', 'nz'), '<': ('lt', 'ult'), '>': ('gt', 'ugt'),
           '<=': ('le', 'ule'), '>=': ('ge', 'uge')}
    NEG = {'z': 'nz', 'nz': 'z', 'lt': 'ge', 'ge': 'lt', 'gt': 'le', 'le': 'gt',
           'ult': 'uge', 'uge': 'ult', 'ugt': 'ule', 'ule': 'ugt'}

    def cond(self, node, label, jump_if_true=False):
        """Jump to label if cond is false (or true when jump_if_true)."""
        c = self.const_eval(node)
        if c is not None and isinstance(c[0], int):
            if bool(c[0]) == jump_if_true:
                self.emit('jr ' + label)
            return
        if isinstance(node, c_ast.UnaryOp) and node.op == '!':
            return self.cond(node.expr, label, not jump_if_true)
        if isinstance(node, c_ast.BinaryOp) and node.op in ('&&', '||'):
            is_and = node.op == '&&'
            if is_and != jump_if_true:
                # (a && b) false -> jump ; (a || b) true -> jump
                self.cond(node.left, label, jump_if_true)
                self.cond(node.right, label, jump_if_true)
            else:
                skip = self.newlab()
                self.cond(node.left, skip, not jump_if_true)
                self.cond(node.right, label, jump_if_true)
                self.label(skip)
            return
        if isinstance(node, c_ast.BinaryOp) and node.op in self.REL:
            cc = self.compare(node)
            if not jump_if_true:
                cc = self.NEG[cc]
            self.emit('jr %s,%s' % (cc, label))
            return
        # generic: value != 0
        r, sp = self.alloc2()
        t = decay(self.gen(node, r))
        self.emit('cp %s,0' % R(r, t.size))
        self.release(r, sp)
        self.emit('jr %s,%s' % ('nz' if jump_if_true else 'z', label))

    def compare(self, node):
        """Emit a compare for a relational BinaryOp; return the 'true' condition code."""
        lt = decay(self.type_of(node.left))
        rt = decay(self.type_of(node.right))
        if is_ptr(lt) or is_ptr(rt):
            ct = U32
        else:
            ct = arith_conv(lt, rt)
        bt = self.byte_compare_type(node.left, node.right, lt, rt)
        if bt is not None:
            ct = bt
        signed_i = 0 if ct.signed else 1
        cc = self.REL[node.op][signed_i]
        r, sp = self.alloc2()
        t = self.gen(node.left, r)
        self.convert(r, t, ct)
        self.binop_operand('cp', r, node.right, ct)
        self.release(r, sp)
        return cc

    def byte_compare_type(self, ln, rn, lt, rt):
        """8-bit compare is exact when both sides are 8-bit of the same
        signedness, or one side is such a value and the other a constant in range."""
        def kind(n, t):
            c = self.const_eval(n)
            if c is not None and isinstance(c[0], int):
                return ('c', c[0])
            if t.kind == 'int' and t.size == 1:
                return ('v', t.signed)
            return None
        a, b = kind(ln, lt), kind(rn, rt)
        if a is None or b is None:
            return None
        if a[0] == 'c' and b[0] == 'c':
            return None
        if a[0] == 'v' and b[0] == 'v':
            if a[1] != b[1]:
                return None
            return S8 if a[1] else U8
        v, c = (a, b) if a[0] == 'v' else (b, a)
        if a[0] == 'c':
            return None          # keep the constant on the right only
        if v[1] and -128 <= c[1] <= 127:
            return S8
        if not v[1] and 0 <= c[1] <= 255:
            return U8
        return None

    # ---------------- 8-bit evaluation of truncated expressions
    NARROW_OPS = {'+': 'add', '-': 'sub', '&': 'and', '|': 'or', '^': 'xor'}

    def narrowable(self, node, depth=0):
        if depth > 6:
            return False
        c = self.const_eval(node)
        if c is not None:
            return isinstance(c[0], int)
        if isinstance(node, c_ast.Cast):
            t = self.resolve(node.to_type)
            it = decay(self.type_of(node.expr))
            return t.kind == 'int' and it.kind == 'int' and self.narrowable(node.expr, depth + 1)
        if isinstance(node, c_ast.BinaryOp):
            if node.op in self.NARROW_OPS:
                return self.narrowable(node.left, depth + 1) and self.narrowable(node.right, depth + 1)
            if node.op == '<<':
                c = self.const_eval(node.right)
                return c is not None and isinstance(c[0], int) and 0 <= c[0] < 8 and self.narrowable(node.left, depth + 1)
            return False
        if isinstance(node, c_ast.UnaryOp) and node.op in ('-', '~'):
            return self.narrowable(node.expr, depth + 1)
        t = decay(self.type_of(node))
        if t.kind != 'int':
            return False
        if t.size == 1:
            return isinstance(node, (c_ast.ID, c_ast.ArrayRef, c_ast.StructRef)) or (isinstance(node, c_ast.UnaryOp) and node.op == '*')
        # wider lvalue whose low byte can be read directly from memory
        return self.mem_operand(node, need_regs=False) is not None

    def gen8(self, node, r):
        """Evaluate node truncated to 8 bits into R(r,1).  Caller ensured narrowable()."""
        c = self.const_eval(node)
        if c is not None:
            self.emit('ld %s,%d' % (R(r, 1), c[0] & 255))
            return
        if isinstance(node, c_ast.Cast):
            return self.gen8(node.expr, r)
        if isinstance(node, c_ast.UnaryOp) and node.op in ('-', '~'):
            self.gen8(node.expr, r)
            self.emit('%s %s' % ('neg' if node.op == '-' else 'cpl', R(r, 1)))
            return
        if isinstance(node, c_ast.BinaryOp):
            self.gen8(node.left, r)
            if node.op == '<<':
                n = self.const_eval(node.right)[0]
                if n:
                    self.emit('sll %d,%s' % (n, R(r, 1)))
                return
            mn = self.NARROW_OPS[node.op]
            c = self.const_eval(node.right)
            if c is not None:
                self.emit('%s %s,%d' % (mn, R(r, 1), c[0] & 255))
                return
            mop = self.mem_operand(node.right, need_regs=False) if self.type_of(node.right).kind == 'int' else None
            if mop is not None and not isinstance(node.right, c_ast.Cast):
                self.emit('%s %s,%s' % (mn, R(r, 1), self.ostr_sz(mop, 1)))
                return
            r2, sp = self.alloc2((r,))
            self.gen8(node.right, r2)
            self.emit('%s %s,%s' % (mn, R(r, 1), R(r2, 1)))
            self.release(r2, sp)
            return
        t = decay(self.type_of(node))
        if t.size == 1:
            self.gen(node, r)
            return
        mop = self.mem_operand(node, need_regs=False)
        self.emit('ld %s,%s' % (R(r, 1), self.ostr_sz(mop, 1)))

    # ---------------- expressions
    def simple_operand(self, node, want_t):
        """Return an Op usable directly as the right operand of a size-want_t ALU op,
        or None.  Only when no conversion is needed."""
        c = self.const_eval(node)
        if c is not None and isinstance(c[0], int):
            return Op('imm', wrap(c[0], want_t) & ((1 << (want_t.size * 8)) - 1))
        if c is not None and want_t.size == 4:
            return Op('imm', self.symexpr(c[0]))
        t = self.type_of(node)
        if t.kind in ('int', 'ptr') and t.size == want_t.size:
            op = self.mem_operand(node, need_regs=False)
            if op is not None:
                return op
        return None

    def symexpr(self, v):
        lab, off = v[1], v[2]
        if off:
            return '%s%+d' % (lab, off)
        return lab

    def mem_operand(self, node, need_regs=True):
        """Return Op for an lvalue that can be addressed without code, else None."""
        if isinstance(node, c_ast.ID):
            s = self.lookup(node.name)
            if s is None:
                self.err(node, 'undeclared %s' % node.name)
            if s.kind == 'local':
                self.note_use(s)
                if getattr(s, 'reg', None):
                    return Op('reg', s.reg, s.type.size)
                if getattr(s, 'param_index', None) is not None:
                    return Op('param', s.param_index)
                return Op('sp', s.offset)
            if s.kind in ('var', 'static'):
                return Op('abs', s.label)
            return None
        if isinstance(node, c_ast.StructRef) and node.type == '->':
            rp = self.reg_ptr(node.name)
            if rp is not None:
                st = decay(self.type_of(node.name)).base
                ft, off = self.field(st, node.field.name, node)
                return Op('ind', rp, off)
            return None
        if isinstance(node, c_ast.StructRef) and node.type == '.':
            base = self.mem_operand(node.name, need_regs)
            if base is None:
                return None
            st = self.type_of(node.name)
            ft, off = self.field(st, node.field.name, node)
            return self.op_add(base, off)
        if isinstance(node, c_ast.ArrayRef):
            bt = self.type_of(node.name)
            rp = self.reg_ptr(node.name)
            if rp is not None:
                c = self.const_eval(node.subscript)
                if c is not None and isinstance(c[0], int) and -128 <= c[0] * bt.base.size <= 32767:
                    return Op('ind', rp, c[0] * bt.base.size)
                return None
            if bt.kind == 'arr':
                c = self.const_eval(node.subscript)
                if c is not None and isinstance(c[0], int):
                    base = self.mem_operand(node.name, need_regs)
                    if base is None:
                        return None
                    return self.op_add(base, c[0] * bt.base.size)
            return None
        if isinstance(node, c_ast.UnaryOp) and node.op == '*':
            rp = self.reg_ptr(node.expr)
            if rp is not None:
                return Op('ind', rp, 0)
            c = self.const_eval(node.expr)
            if c is not None and isinstance(c[0], int):
                return Op('abs', '0%Xh' % (c[0] & 0xFFFFFF))
            if c is not None:
                return Op('abs', self.symexpr(c[0]))
            return None
        return None

    def reg_ptr(self, node):
        """Register holding a pointer variable, if node is such a variable."""
        if isinstance(node, c_ast.ID):
            s = self.lookup(node.name)
            if s is not None and s.kind == 'local' and getattr(s, 'reg', None) and s.type.kind == 'ptr':
                self.note_use(s)
                return s.reg
        return None

    def op_add(self, op, off):
        if op.kind == 'abs':
            if off == 0:
                return op
            return Op('abs', '%s%+d' % (op.a, off))
        if op.kind == 'sp':
            return Op('sp', op.a + off)
        if op.kind == 'param':
            return Op('paramoff', op.a, off)
        if op.kind == 'paramoff':
            return Op('paramoff', op.a, op.b + off)
        if op.kind == 'ind':
            return Op('ind', op.a, op.b + off)
        raise CompileError('op_add')

    def ostr(self, op):
        if op.kind == 'imm':
            return str(op.a)
        if op.kind == 'abs':
            return '(%s)' % op.a
        if op.kind == 'sp':
            return '(xsp+%s)' % self.fl(op.a)
        if op.kind == 'param':
            return '(xsp+%s)' % self.fp(op.a)
        if op.kind == 'paramoff':
            return '(xsp+%s+%d)' % (self.fp(op.a), op.b)
        if op.kind == 'reg':
            return SUB[op.a][op.b]
        if op.kind == 'ind':
            if op.b == 0:
                return '(%s)' % op.a
            return '(%s%+d)' % (op.a, op.b)
        raise CompileError('ostr')

    def load(self, r, op, t):
        sz = t.size
        if op.kind == 'imm':
            self.emit('ld %s,%s' % (R(r, sz), op.a))
        else:
            self.emit('ld %s,%s' % (R(r, sz), self.ostr_sz(op, sz)))

    def store(self, op, r, t):
        self.emit('ld %s,%s' % (self.ostr_sz(op, t.size), R(r, t.size)))

    def convert(self, r, frm, to):
        frm = decay(frm)
        to = decay(to)
        if to.kind == 'void':
            return
        fs, ts = frm.size, to.size
        if ts <= fs:
            return
        sgn = frm.kind == 'int' and frm.signed
        if fs == 1:
            self.emit('%s %s' % ('exts' if sgn else 'extz', R(r, 2)))
            fs = 2
        if fs == 2 and ts == 4:
            self.emit('%s %s' % ('exts' if sgn else 'extz', R(r, 4)))

    def gen(self, node, r, discard=False):
        """Generate node into register r. Returns the (undecayed for arrays) type."""
        c = None
        if not isinstance(node, (c_ast.Assignment, c_ast.FuncCall)):
            c = self.const_eval(node)
        if c is not None:
            v, t = c
            t = decay(t) if t.kind in ('arr', 'func') else t
            if discard:
                return t
            if isinstance(v, int):
                sz = max(t.size, 1)
                self.emit('ld %s,%d' % (R(r, sz), v & ((1 << (sz * 8)) - 1)))
            else:
                self.emit('ld %s,%s' % (R(r, 4), self.symexpr(v)))
            return t
        m = getattr(self, 'ex_' + type(node).__name__, None)
        if m is None:
            self.err(node, 'unsupported expression %s' % type(node).__name__)
        return m(node, r, discard)

    CREGS = {'__DMAC%d' % i: ('dmac%d' % i, U16) for i in range(4)}
    CREGS.update({'__DMAS%d' % i: ('dmas%d' % i, U32) for i in range(4)})
    CREGS.update({'__DMAD%d' % i: ('dmad%d' % i, U32) for i in range(4)})
    CREGS.update({'__DMAM%d' % i: ('dmam%d' % i, U8) for i in range(4)})

    def ex_ID(self, node, r, discard):
        if node.name in self.CREGS:
            cr, t = self.CREGS[node.name]
            self.emit('ldc %s,%s' % (R(r, t.size), cr))
            return t
        s = self.lookup(node.name)
        if s is None:
            self.err(node, 'undeclared %s' % node.name)
        if s.kind == 'func':
            self.emit('ld %s,%s' % (r, s.label))
            return t_ptr(s.type)
        t = s.type
        op = self.mem_operand(node)
        if t.kind == 'arr':
            self.lea(r, op)
            return t_ptr(t.base)
        if t.kind == 'struct':
            self.lea(r, op)
            return t
        if not discard:
            self.load(r, op, t)
        return t

    def ostr_sz(self, op, size):
        if op.kind == 'reg':
            return SUB[op.a][size]
        return self.ostr(op)

    def msfx(self, op, size):
        return '' if op.kind == 'reg' else SFX[size]

    def lea(self, r, op):
        if op.kind == 'abs':
            self.emit('ld %s,%s' % (r, op.a))
        else:
            self.emit('lda %s,%s' % (r, self.ostr(op)))

    def ex_Constant(self, node, r, discard):
        self.err(node, 'constant not folded')

    def ex_Cast(self, node, r, discard):
        t = self.resolve(node.to_type)
        if t.kind == 'int' and t.size == 1 and not discard and self.narrowable(node):
            self.gen8(node, r)
            return t
        vt = self.gen(node.expr, r, discard)
        if t.kind == 'void':
            return VOID
        self.convert(r, vt, t)
        return t

    def addr(self, node, r):
        """Compute address of lvalue node. Returns (Op, type). May use register r
        (which is then busy holding the address)."""
        op = self.mem_operand(node)
        t = self.type_of(node)
        if op is not None:
            return op, t
        if isinstance(node, c_ast.UnaryOp) and node.op == '*':
            pt = decay(self.gen(node.expr, r))
            return Op('ind', r, 0), pt.base
        if isinstance(node, c_ast.StructRef):
            if node.type == '->':
                pt = decay(self.gen(node.name, r))
                st = pt.base
            else:
                bop, st = self.addr(node.name, r)
                if bop.kind != 'ind':
                    self.lea(r, bop)
                    bop = Op('ind', r, 0)
                ft, off = self.field(st, node.field.name, node)
                return Op('ind', r, bop.b + off), ft
            ft, off = self.field(st, node.field.name, node)
            return Op('ind', r, off), ft
        if isinstance(node, c_ast.ArrayRef):
            bt = decay(self.type_of(node.name))
            name, sub = node.name, node.subscript
            if not is_ptr(bt):
                name, sub = sub, name
                bt = decay(self.type_of(name))
            et = bt.base
            c = self.const_eval(sub)
            if c is not None and isinstance(c[0], int):
                pt = self.gen(name, r)
                return Op('ind', r, c[0] * et.size), et
            self.ptr_add(name, sub, r, et.size, '+')
            return Op('ind', r, 0), et
        if isinstance(node, c_ast.Cast):
            # cast of lvalue (non-standard) -- treat as the inner address
            op, t = self.addr(node.expr, r)
            return op, self.resolve(node.to_type)
        self.err(node, 'not an lvalue: %s' % type(node).__name__)

    def ptr_add(self, pnode, inode, r, esz, op):
        """r = pnode (+/-) inode*esz"""
        it = self.type_of(inode)
        self.gen(pnode, r)
        r2, sp = self.alloc2((r,))
        self.gen_index(inode, r2, esz, it)
        self.emit('%s %s,%s' % ('add' if op == '+' else 'sub', R(r, 4), R(r2, 4)))
        self.release(r2, sp)

    def gen_index(self, inode, r, esz, it=None):
        """r (32-bit) = (long)inode * esz"""
        if it is None:
            it = self.type_of(inode)
        it0 = decay(it)
        it = promote(it0)
        t = self.gen(inode, r)
        self.convert(r, t, it)
        if it.size == 4:
            if esz != 1:
                self.mul_const32(r, esz)
            return
        if esz == 1:
            self.emit('%s %s' % ('exts' if it.signed else 'extz', R(r, 4)))
        elif esz & (esz - 1) == 0:
            self.emit('%s %s' % ('exts' if it.signed else 'extz', R(r, 4)))
            self.emit('sll %d,%s' % (esz.bit_length() - 1, R(r, 4)))
        else:
            self.emit('%s %s,%d' % ('muls' if it.signed else 'mul', R(r, 4), esz))

    def mul_const32(self, r, k):
        if k & (k - 1) == 0:
            n = k.bit_length() - 1
            while n > 0:
                s = min(n, 15)
                self.emit('sll %d,%s' % (s, R(r, 4)))
                n -= s
        else:
            self.call_helper('__mul32k', r, k)

    def ex_ArrayRef(self, node, r, discard):
        op, t = self.addr(node, r)
        return self.load_lv(op, t, r, discard)

    def ex_StructRef(self, node, r, discard):
        op, t = self.addr(node, r)
        return self.load_lv(op, t, r, discard)

    def load_lv(self, op, t, r, discard):
        if t.kind == 'arr':
            self.lea(r, op)
            return t_ptr(t.base)
        if t.kind == 'struct':
            self.lea(r, op)
            return t
        if not discard or True:
            self.load(r, op, t)
        return t

    def ex_UnaryOp(self, node, r, discard):
        op = node.op
        if op == '*':
            o, t = self.addr(node, r)
            if t.kind == 'func':
                return t_ptr(t)
            return self.load_lv(o, t, r, discard)
        if op == '&':
            e = node.expr
            if isinstance(e, c_ast.ID):
                s = self.lookup(e.name)
                if s and s.kind == 'func':
                    self.emit('ld %s,%s' % (r, s.label))
                    return t_ptr(s.type)
            if isinstance(e, c_ast.ID):
                ls = self.lookup(e.name)
                if ls is not None and ls.kind == 'local':
                    self.note_taken(ls)
                    if getattr(ls, 'reg', None):
                        self.err(node, 'internal: address of register variable')
            o, t = self.addr(e, r)
            self.lea(r, o)
            return t_ptr(t)
        if op == 'sizeof':
            self.emit('ld %s,%d' % (R(r, 2), self.sizeof(node.expr)))
            return UINT
        if op in ('++', '--', 'p++', 'p--'):
            return self.incdec(node, r, discard)
        if op == '!':
            lf = self.newlab()
            self.cond(node.expr, lf, jump_if_true=True)
            # falls here when expr false -> result 1
            lend = self.newlab()
            self.emit('ld %s,1' % R(r, 2))
            self.emit('jr ' + lend)
            self.label(lf)
            self.emit('ld %s,0' % R(r, 2))
            self.label(lend)
            return INT
        t = promote(decay(self.gen(node.expr, r)))
        self.convert(r, self.type_of(node.expr), t)
        if op == '-':
            if t.size == 4:
                self.emit('xor %s,0ffffffffh' % R(r, 4))
                self.emit('inc 1,%s' % R(r, 4))
            else:
                self.emit('neg %s' % R(r, t.size))
        elif op == '~':
            if t.size == 4:
                self.emit('xor %s,0ffffffffh' % R(r, 4))
            else:
                self.emit('cpl %s' % R(r, t.size))
        elif op == '+':
            pass
        else:
            self.err(node, 'unary %s' % op)
        return t

    def incdec(self, node, r, discard):
        op = node.op
        inc = '++' in op
        post = op.startswith('p')
        lt = self.type_of(node.expr)
        step = lt.base.size if is_ptr(lt) else 1
        mop = self.mem_operand(node.expr)
        sz = lt.size
        if mop is not None and sz in (1, 2) and step <= 8:
            if not discard and post:
                self.load(r, mop, lt)
            self.emit('%s%s %d,%s' % ('inc' if inc else 'dec', self.msfx(mop, sz), step, self.ostr(mop)))
            if not discard and not post:
                self.load(r, mop, lt)
            return lt
        # general path
        r2, sp = self.alloc2((r,))
        o, t = self.addr(node.expr, r2)
        self.load(r, o, t)
        rr = R(r, sz)
        if step <= 8:
            self.emit('%s %d,%s' % ('inc' if inc else 'dec', step, rr))
        else:
            self.emit('%s %s,%d' % ('add' if inc else 'sub', rr, step))
        self.store(o, r, t)
        if post and not discard:
            if step <= 8:
                self.emit('%s %d,%s' % ('dec' if inc else 'inc', step, rr))
            else:
                self.emit('%s %s,%d' % ('sub' if inc else 'add', rr, step))
        self.release(r2, sp)
        return t

    def ex_ExprList(self, node, r, discard):
        t = VOID
        for i, e in enumerate(node.exprs):
            last = i == len(node.exprs) - 1
            t = self.gen(e, r, discard=(discard or not last))
        return t

    def ex_TernaryOp(self, node, r, discard):
        lf, lend = self.newlab(), self.newlab()
        rt = self.type_of(node)
        self.cond(node.cond, lf)
        t = self.gen(node.iftrue, r, discard)
        if rt.kind != 'void':
            self.convert(r, t, rt)
        self.emit('jr ' + lend)
        self.label(lf)
        t = self.gen(node.iffalse, r, discard)
        if rt.kind != 'void':
            self.convert(r, t, rt)
        self.label(lend)
        return rt

    # --- assignment
    def ex_Assignment(self, node, r, discard):
        if isinstance(node.lvalue, c_ast.ID) and node.lvalue.name in self.CREGS and node.op == '=':
            cr, t = self.CREGS[node.lvalue.name]
            vt = self.gen(node.rvalue, r)
            self.convert(r, vt, t)
            self.emit('ldc %s,%s' % (cr, R(r, t.size)))
            return t
        lt = self.type_of(node.lvalue)
        if node.op == '=':
            if lt.kind == 'struct':
                self.copy_struct(node.lvalue, node.rvalue, lt)
                return lt
            mop = self.mem_operand(node.lvalue)
            if mop is not None:
                # constant store
                c = self.const_eval(node.rvalue)
                if c is not None and isinstance(c[0], int) and lt.size in (1, 2) and discard:
                    self.emit('ld%s %s,%d' % (self.msfx(mop, lt.size), self.ostr(mop), wrap(c[0], lt) & ((1 << (lt.size * 8)) - 1)))
                    return lt
                if lt.kind == 'int' and lt.size == 1 and self.narrowable(node.rvalue):
                    self.gen8(node.rvalue, r)
                else:
                    vt = self.gen(node.rvalue, r)
                    self.convert(r, vt, lt)
                self.store(mop, r, lt)
                return lt
            if lt.kind == 'int' and lt.size == 1 and self.narrowable(node.rvalue):
                self.gen8(node.rvalue, r)
            else:
                vt = self.gen(node.rvalue, r)
                self.convert(r, vt, lt)
            r2, sp = self.alloc2((r,))
            o, t = self.addr(node.lvalue, r2)
            self.store(o, r, lt)
            self.release(r2, sp)
            return lt
        # compound
        bop = node.op[:-1]
        mop = self.mem_operand(node.lvalue)
        if mop is not None:
            return self.compound(node, bop, mop, lt, r, discard)
        r2, sp = self.alloc2((r,))
        o, t = self.addr(node.lvalue, r2)
        res = self.compound(node, bop, o, lt, r, discard)
        self.release(r2, sp)
        return res

    def compound(self, node, bop, o, lt, r, discard):
        # fast paths: add/sub/and/or/xor with constant or simple operand on 1/2-byte memory
        if bop in ('+', '-', '&', '|', '^') and lt.kind == 'int' and lt.size in (1, 2):
            c = self.const_eval(node.rvalue)
            if c is not None and isinstance(c[0], int):
                v = wrap(c[0], lt) & ((1 << (lt.size * 8)) - 1)
                mn = {'+': 'add', '-': 'sub', '&': 'and', '|': 'or', '^': 'xor'}[bop]
                if bop in ('+', '-') and 1 <= c[0] <= 8:
                    self.emit('%s%s %d,%s' % ('inc' if bop == '+' else 'dec', self.msfx(o, lt.size), c[0], self.ostr(o)))
                else:
                    self.emit('%s%s %s,%d' % (mn, self.msfx(o, lt.size), self.ostr(o), v))
                if not discard:
                    self.load(r, o, lt)
                return lt
        if is_ptr(lt) and bop in ('+', '-'):
            # p += n
            r2, sp = self.alloc2((r,) + ((o.a,) if o.kind == 'ind' else ()))
            self.gen_index(node.rvalue, r2, lt.base.size)
            self.load(r, o, lt)
            self.emit('%s %s,%s' % ('add' if bop == '+' else 'sub', R(r, 4), R(r2, 4)))
            self.release(r2, sp)
            self.store(o, r, lt)
            return lt
        # general: r = (promoted lv) op rvalue ; store
        rt = decay(self.type_of(node.rvalue))
        if bop in ('<<', '>>'):
            ct = promote(lt)
        else:
            ct = arith_conv(lt, rt)
        self.load(r, o, lt)
        self.convert(r, lt, ct)
        self.arith(bop, r, node.rvalue, ct, node)
        self.store(o, r, lt)
        return lt

    def copy_struct(self, lnode, rnode, t):
        live = [x for x in REGS if x in self.used]
        for x in live:
            self.push(x)
        save = set(self.used)
        self.used = {'xwa'}
        so, st = self.addr(rnode, 'xwa')
        self.lea('xwa', so) if not (so.kind == 'ind' and so.a == 'xwa' and so.b == 0) else None
        self.push('xwa')
        self.used = {'xwa'}
        do, dt = self.addr(lnode, 'xwa')
        self.lea('xwa', do) if not (do.kind == 'ind' and do.a == 'xwa' and do.b == 0) else None
        self.emit('ld xde,xwa')
        self.pop('xhl')
        self.emit('ld bc,%d' % t.size)
        self.emit('ldirb')
        self.used = save
        for x in reversed(live):
            self.pop(x)

    def assign_struct(self, dst_op, rnode, t):
        # memcpy via ldirb: XDE=dst, XHL=src, BC=count ; needs those registers free
        for need in ('xde', 'xhl', 'xbc'):
            if need in self.used:
                self.err(rnode, 'struct copy needs free registers')
        self.used.update(['xde', 'xhl', 'xbc'])
        so, st = self.addr(rnode, 'xhl')
        if not (so.kind == 'ind' and so.a == 'xhl' and so.b == 0):
            self.lea('xhl', so)
        self.lea('xde', dst_op)
        self.emit('ld bc,%d' % t.size)
        self.emit('ldirb')
        for need in ('xde', 'xhl', 'xbc'):
            self.free(need)

    # --- binary
    def ex_BinaryOp(self, node, r, discard):
        op = node.op
        if op in ('&&', '||') or op in self.REL:
            lf, lend = self.newlab(), self.newlab()
            self.cond(node, lf)
            self.emit('ld %s,1' % R(r, 2))
            self.emit('jr ' + lend)
            self.label(lf)
            self.emit('ld %s,0' % R(r, 2))
            self.label(lend)
            return INT
        lt = decay(self.type_of(node.left))
        rt = decay(self.type_of(node.right))
        if op in ('+', '-') and (is_ptr(lt) or is_ptr(rt)):
            if is_ptr(lt) and is_ptr(rt):
                # pointer difference
                t = self.gen(node.left, r)
                self.binop_operand('sub', r, node.right, U32)
                esz = lt.base.size
                if esz > 1:
                    if esz & (esz - 1) == 0:
                        self.emit('sra %d,%s' % (esz.bit_length() - 1, R(r, 4)))
                    else:
                        self.emit('divs %s,%d' % (R(r, 4), esz))
                return INT
            if is_ptr(lt):
                self.ptr_add(node.left, node.right, r, lt.base.size, op)
                return lt
            self.ptr_add(node.right, node.left, r, rt.base.size, '+')
            return rt
        if op in ('<<', '>>'):
            ct = promote(lt)
        else:
            ct = arith_conv(lt, rt)
        # 16x16 -> 32 multiply when both operands are narrow
        if op == '*' and ct.size == 4:
            if self.try_mul_wide(node, r, ct):
                return ct
        t = self.gen(node.left, r)
        self.convert(r, t, ct)
        self.arith(op, r, node.right, ct, node)
        return ct

    def narrow(self, node):
        """If node's value is (an extension of) a <=16-bit value, return its type."""
        c = self.const_eval(node)
        if c is not None and isinstance(c[0], int):
            v = c[0]
            if 0 <= v <= 0x7FFF:
                return 'both'
            if 0 <= v <= 0xFFFF:
                return U16
            if -0x8000 <= v < 0:
                return S16
            return None
        if isinstance(node, c_ast.Cast):
            t = self.resolve(node.to_type)
            if t.kind == 'int':
                it = decay(self.type_of(node.expr))
                if it.kind == 'int' and it.size <= 2 and it.size < t.size:
                    return promote(it) if it.size == 1 else it
                if it.kind == 'int' and t.size <= 2:
                    return promote(t) if t.size == 1 else t
        t = decay(self.type_of(node))
        if t.kind == 'int' and t.size <= 2:
            return promote(t) if t.size == 1 else t
        return None

    def try_mul_wide(self, node, r, ct):
        a, b = self.narrow(node.left), self.narrow(node.right)
        if a is None or b is None:
            return False
        sa = None if a == 'both' else a.signed
        sb = None if b == 'both' else b.signed
        if sa is None and sb is None:
            signed = False
        elif sa is None:
            signed = sb
        elif sb is None:
            signed = sa
        elif sa == sb:
            signed = sa
        else:
            return False
        # evaluate both as 16-bit values
        def gen16(n, reg):
            if isinstance(n, c_ast.Cast):
                it = decay(self.type_of(n.expr))
                if it.kind == 'int' and it.size <= 2:
                    t = self.gen(n.expr, reg)
                    self.convert(reg, t, S16 if it.signed else U16)
                    return
            t = self.gen(n, reg)
            self.convert(reg, t, S16 if (t.kind == 'int' and t.signed) else U16)
        gen16(node.left, r)
        c = self.const_eval(node.right)
        mn = 'muls' if signed else 'mul'
        if c is not None and isinstance(c[0], int):
            self.emit('%s %s,%d' % (mn, R(r, 4), c[0] & 0xFFFF))
            return True
        r2, sp = self.alloc2((r,))
        gen16(node.right, r2)
        self.emit('%s %s,%s' % (mn, R(r, 4), R(r2, 2)))
        self.release(r2, sp)
        return True

    ALU = {'+': 'add', '-': 'sub', '&': 'and', '|': 'or', '^': 'xor'}

    def arith(self, op, r, rnode, ct, node):
        """r (type ct) = r op rnode"""
        sz = ct.size
        rr = R(r, sz)
        if op in self.ALU:
            self.binop_operand(self.ALU[op], r, rnode, ct)
            return
        if op in ('<<', '>>'):
            c = self.const_eval(rnode)
            mn = 'sll' if op == '<<' else ('sra' if ct.signed else 'srl')
            if c is not None and isinstance(c[0], int):
                n = c[0]
                if n >= sz * 8:
                    self.emit('ld %s,0' % rr)
                    return
                while n > 0:
                    s = min(n, 15)
                    self.emit('%s %d,%s' % (mn, s, rr))
                    n -= s
                return
            # variable shift: count into a register, loop
            r2, sp = self.alloc2((r,))
            t = self.gen(rnode, r2)
            l1, l2 = self.newlab(), self.newlab()
            cr = R(r2, 1)
            self.emit('cp %s,0' % cr)
            self.emit('jr z,' + l2)
            self.label(l1)
            self.emit('%s 1,%s' % (mn, rr))
            self.emit('djnz %s,%s' % (cr, l1))
            self.label(l2)
            self.release(r2, sp)
            return
        if op == '*':
            if sz == 2:
                c = self.const_eval(rnode)
                if c is not None and isinstance(c[0], int):
                    v = c[0] & 0xFFFF
                    if v & (v - 1) == 0 and v:
                        if v > 1:
                            self.emit('sll %d,%s' % (v.bit_length() - 1, rr))
                        return
                    self.emit('mul %s,%d' % (R(r, 4), v))
                    return
                self.binop_operand('mul', r, rnode, ct, wide=True)
                return
            # 32-bit
            c = self.const_eval(rnode)
            if c is not None and isinstance(c[0], int):
                v = c[0] & 0xFFFFFFFF
                if v and v & (v - 1) == 0:
                    self.mul_const32(r, v)
                    return
            self.helper2('__mul32', r, rnode, ct)
            return
        if op in ('/', '%'):
            if sz == 2:
                c = self.const_eval(rnode)
                if c is not None and isinstance(c[0], int) and not ct.signed:
                    v = c[0] & 0xFFFF
                    if v and v & (v - 1) == 0:
                        if op == '/':
                            if v > 1:
                                self.emit('srl %d,%s' % (v.bit_length() - 1, rr))
                        else:
                            self.emit('and %s,%d' % (rr, v - 1))
                        return
                self.emit('%s %s' % ('exts' if ct.signed else 'extz', R(r, 4)))
                self.binop_operand('divs' if ct.signed else 'div', r, rnode, ct, wide=True)
                if op == '%':
                    self.emit('ld %s,%s' % (rr, Q[r]))
                return
            c = self.const_eval(rnode)
            if c is not None and isinstance(c[0], int) and not ct.signed:
                v = c[0] & 0xFFFFFFFF
                if v and v & (v - 1) == 0:
                    if op == '/':
                        n = v.bit_length() - 1
                        while n > 0:
                            s = min(n, 15)
                            self.emit('srl %d,%s' % (s, rr))
                            n -= s
                    else:
                        self.and32(r, v - 1)
                    return
            name = {('/', False): '__div32u', ('/', True): '__div32s', ('%', False): '__mod32u', ('%', True): '__mod32s'}[(op, ct.signed)]
            self.helper2(name, r, rnode, ct)
            return
        self.err(node, 'binary op %s' % op)

    def and32(self, r, mask):
        self.emit('and %s,%d' % (R(r, 4), mask))

    def binop_operand(self, mn, r, rnode, ct, wide=False):
        """emit 'mn r, <rnode converted to ct>'.  For wide ops (mul/div) the
        destination is the 32-bit register and the source is 16-bit."""
        sz = ct.size
        dst = R(r, 4) if wide else R(r, sz)
        so = self.simple_operand(rnode, ct)
        if so is not None:
            if so.kind == 'imm':
                v = so.a
                if mn == 'cp' and v == 0 and False:
                    pass
                self.emit('%s %s,%s' % (mn, dst, v))
            else:
                self.emit('%s %s,%s' % (mn, dst, self.ostr(so)))
            return
        r2, sp = self.alloc2((r,))
        t = self.gen(rnode, r2)
        self.convert(r2, t, ct)
        self.emit('%s %s,%s' % (mn, dst, R(r2, sz)))
        self.release(r2, sp)

    def helper2(self, name, r, rnode, ct):
        """32-bit helper: XWA = XWA op XBC.  r holds left operand."""
        self.call_helper_expr(name, r, rnode, ct)

    def call_saved(self):
        self.ra_calls += 1 + 6 * min(self.loop_depth, 3)
        return [x for x in ('xix', 'xiy') if x in getattr(self, 'live_var_regs', ())]

    def call_helper_expr(self, name, r, rnode, ct):
        # save other live registers
        live = [x for x in REGS if x in self.used and x != r] + self.call_saved()
        for x in live:
            self.push(x)
        self.push(r)                      # left
        save_used = set(self.used)
        self.used = set()
        self.used.add('xwa')
        t = self.gen(rnode, 'xwa')
        self.convert('xwa', t, ct)
        self.emit('ld xbc,xwa')
        self.pop('xwa')
        self.emit('call ' + name)
        self.used = save_used
        if r != 'xwa':
            self.emit('ld %s,xwa' % r)
        for x in reversed(live):
            self.pop(x)

    def call_helper(self, name, r, k):
        live = [x for x in REGS if x in self.used and x != r] + self.call_saved()
        for x in live:
            self.push(x)
        if r != 'xwa':
            self.emit('ld xwa,%s' % r)
        self.emit('ld xbc,%d' % k)
        self.emit('call __mul32')
        if r != 'xwa':
            self.emit('ld %s,xwa' % r)
        for x in reversed(live):
            self.pop(x)

    # --- calls
    def ex_FuncCall(self, node, r, discard):
        name = node.name
        if isinstance(name, c_ast.ID) and name.name == '__asm_inline':
            self.inline_asm(node)
            return VOID
        ft = decay(self.type_of(name))
        if not (is_ptr(ft) and ft.base.kind == 'func'):
            self.err(node, 'call of non-function')
        fn = ft.base
        args = list(node.args.exprs) if node.args else []
        if fn.params is not None and len(args) != len(fn.params) and not fn.varargs:
            self.err(node, 'wrong number of arguments (%d for %d)' % (len(args), len(fn.params)))
        live = [x for x in REGS if x in self.used and x != r] + self.call_saved()
        for x in live:
            self.push(x)
        save_used = set(self.used)
        self.used = set()
        # push args right to left
        for i in reversed(range(len(args))):
            a = args[i]
            pt = None
            if fn.params is not None and i < len(fn.params):
                pt = fn.params[i]
            at = decay(self.type_of(a))
            if at.kind == 'struct':
                self.err(a, 'struct argument not supported')
            self.used = {'xwa'}
            t = self.gen(a, 'xwa')
            t = decay(t)
            if pt is None:
                pt = promote(t)
            self.convert('xwa', t, pt)
            # widen to 32 for the slot (value semantics only in low bytes)
            self.emit('push xwa')
            self.depth += 4
        self.used = set()
        direct = None
        if isinstance(name, c_ast.ID):
            s = self.lookup(name.name)
            if s is not None and s.kind == 'func':
                direct = s.label
        if direct:
            self.emit('call ' + direct)
        else:
            self.used = {'xwa'}
            self.gen(name, 'xwa')
            self.emit('ld xhl,xwa')
            self.emit('call (xhl)')
        if args:
            self.emit('lda xsp,(xsp+%d)' % (4 * len(args)))
            self.depth -= 4 * len(args)
        self.used = save_used
        rt = fn.ret
        if r != 'xwa' and rt.kind != 'void':
            self.emit('ld %s,xwa' % r)
        for x in reversed(live):
            self.pop(x)
        return rt

class _NotConst(Exception):
    pass

# ----------------------------------------------------------------- asm900 -> asl
def translate_asm900(line):
    """Translate one line of Toshiba asm900 syntax to asl syntax."""
    code, sep, comment = line.partition(';')
    s = code
    s = re.sub(r'\bldc[bwl]\b', 'ldc', s, flags=re.I)
    s = re.sub(r'^(\s*)j(\s+)', r'\1jp\2', s, flags=re.I)
    s = re.sub(r'\(([a-z]{2,3})\+:([124])\)', r'(\1+)', s, flags=re.I)
    s = re.sub(r'\(([a-z]{2,3})-:([124])\)', r'(-\1)', s, flags=re.I)
    s = re.sub(r'\b(lda\s+\w+\s*,\s*)(xsp|xix|xiy|xiz|xwa|xbc|xde|xhl)\s*([+-])', r'\1(\2\3', s, flags=re.I)
    if re.match(r'\s*lda\s+\w+\s*,\s*\(\w+[+-][^)]*$', s, flags=re.I):
        s = s.rstrip() + ')'
    return s + (sep + comment if sep else '')

USE_PY_CPP = os.environ.get('C900_CPP', '') == 'py' or shutil.which('gcc') is None

def preprocess(path, includes, defines):
    if USE_PY_CPP:
        # pure Python preprocessor (no gcc needed, e.g. on Windows)
        import cpp
        try:
            return cpp.preprocess(path, includes, ['__C900PY__=1', '__far=', '__near='] + list(defines))
        except cpp.CppError as e:
            raise CompileError(str(e))
    cmd = ['gcc', '-E', '-std=c89', '-undef', '-nostdinc', '-x', 'c',
           '-D__C900PY__=1', '-D__far=', '-D__near=']
    for i in includes:
        cmd.append('-I' + i)
    for d in defines:
        cmd.append('-D' + d)
    cmd.append(path)
    out = subprocess.run(cmd, capture_output=True, text=True)
    if out.returncode:
        raise CompileError(out.stderr)
    return out.stdout

def prepare(text):
    """Handle cc900 extensions before parsing."""
    isr = set(re.findall(r'__interrupt\s+(\w+)\s*\(', text))
    text = re.sub(r'\b__interrupt\b', '', text)
    text = re.sub(r'\b__asm\s*\(', '__asm_inline(', text)
    return text, isr

def compile_file(path, tuid, includes, defines):
    text = preprocess(path, includes, defines)
    text, isr = prepare(text)
    parser = c_parser.CParser()
    try:
        ast = parser.parse(text, filename=path)
    except Exception as e:
        raise CompileError('%s: parse error: %s' % (path, e))
    c = Compiler(tuid, path)
    c.isr_names = isr
    c.globals['__asm_inline'] = Sym('func', '__asm_inline', t_func(VOID, None), '__asm_inline')
    c.compile(ast)
    return c

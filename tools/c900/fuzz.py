#!/usr/bin/env python3
"""Differential tester: random C code compiled by c900 (run in emulator) vs host gcc."""
import random, subprocess, sys, os, struct

TYPES = ['u8', 's8', 'u16', 's16', 'u32', 's32']
BITS = {'u8': 8, 's8': 8, 'u16': 16, 's16': 16, 'u32': 32, 's32': 32}
SIGNED = {t: t[0] == 's' for t in TYPES}
HERE = os.path.dirname(os.path.abspath(__file__))
EMU = '/root/emu/run'
CORE = '/root/emu/beetle-ngp-libretro/mednafen_ngp_libretro.so'
NTEST = 60

PRELUDE = r'''
typedef unsigned char u8; typedef signed char s8;
typedef unsigned short u16; typedef signed short s16;
#ifdef __C900PY__
typedef unsigned long u32; typedef signed long s32;
#else
typedef unsigned int u32; typedef signed int s32;
#endif
typedef struct { u8 a; s16 b; u32 c; s8 d; u16 e[3]; } St;
'''

def rconst(t):
    b = BITS[t]
    v = random.choice([0, 1, 2, 3, 7, 100, -1, -2, 255, 256, 32767, -32768, 65535, 0x7FFFFFFF,
                       random.randint(-(1 << (b - 1)), (1 << b) - 1), random.randint(0, 20)])
    v &= (1 << b) - 1
    if SIGNED[t] and v >= 1 << (b - 1):
        v -= 1 << b
    if b == 32:
        return '((%s)%dL)' % (t, v) if v >= -0x80000000 + 1 else '((%s)(-2147483647L-1))' % t
    return '((%s)%d)' % (t, v) if v != -32768 else '((%s)(-32767-1))' % t

class Gen:
    def __init__(self, locals_):
        self.locals = locals_

    def leaf(self, t):
        k = random.randint(0, 9)
        st = random.choice(TYPES)
        if k <= 2:
            return rconst(t)
        if k <= 4:
            return '((%s)g_%s[%d])' % (t, st, random.randint(0, 3))
        if k == 5:
            return '((%s)l_%s)' % (t, random.choice(self.locals))
        if k == 6:
            return '((%s)p_%s[%d])' % (t, st, random.randint(0, 3))
        if k == 7:
            f = random.choice(['a', 'b', 'c', 'd', 'e[1]', 'e[2]'])
            return '((%s)gs.%s)' % (t, f)
        if k == 8:
            f = random.choice(['a', 'b', 'c', 'd', 'e[0]'])
            return '((%s)ps->%s)' % (t, f)
        k2 = random.randint(0, 3)
        if k2 == 0: return '((%s)g_%s[idx])' % (t, st)
        if k2 == 1: return '((%s)p_%s[sidx])' % (t, st)
        if k2 == 2: return '((%s)*(p_%s + idx))' % (t, st)
        return '((%s)g_%s[idx & 3])' % (t, st)

    def expr(self, t, d):
        if d <= 0 or random.random() < 0.25:
            return self.leaf(t)
        k = random.random()
        if k < 0.65:
            op = random.choice(['+', '-', '*', '/', '%', '&', '|', '^', '<<', '>>', '==', '!=', '<', '>', '<=', '>=', '&&', '||'])
            a = self.expr(t, d - 1)
            b = self.expr(t, d - 1)
            if op in ('/', '%'):
                b = '((%s)((%s & 0x3F) | 1))' % (t, b)
            if op in ('<<', '>>'):
                b = '(%s & %d)' % (b, BITS[t] - 1 if BITS[t] > 8 else 15)
                a = '((%s)%s)' % ('u16' if t == 'u8' else ('s16' if t == 's8' else t), a)
            return '((%s)(%s %s %s))' % (t, a, op, b)
        if k < 0.8:
            op = random.choice(['-', '~', '!'])
            return '((%s)(%s%s))' % (t, op, self.expr(t, d - 1))
        if k < 0.9:
            return '((%s)(%s ? %s : %s))' % (t, self.expr(random.choice(TYPES), d - 1), self.expr(t, d - 1), self.expr(t, d - 1))
        return '((%s)%s)' % (t, self.expr(random.choice(TYPES), d - 1))

def make_program(seed):
    random.seed(seed)
    out = [PRELUDE]
    for t in TYPES:
        vals = [rconst(t) for _ in range(4)]
        out.append('%s g_%s[4] = {%s};' % (t, t, ', '.join(vals)))
    out.append('St gs = {200, -1234, 0x12345678L, -7, {1, 60000, 3}};')
    out.append('u8 idx = 2; s8 sidx = 1;')
    out.append('static s16 hf(s16 a, u8 b) { s16 t = a; u8 k; for (k = 0; k < b; k++) t = (s16)(t * 3 - k); return (s16)(t - b); }')
    funcs = []
    for i in range(NTEST):
        g = Gen(TYPES)
        rt = random.choice(TYPES)
        body = []
        body.append('static u32 t%d(St *ps, s16 pa, u8 pb) {' % i)
        for t in TYPES:
            body.append('    %s l_%s = %s;' % (t, t, rconst(t)))
        for t in TYPES:
            body.append('    %s *p_%s = g_%s;' % (t, t, t))
        body.append('    %s r;' % rt)
        kind = random.random()
        if kind < 0.15:
            body.append('    { u8 i; u16 acc = %d; const s16 *q = p_s16; u8 *w = p_u8; for (i = 0; i < 6; i++) { acc = (u16)(acc + (u16)hf((s16)(q[i & 1] + l_s8), i) + (u16)ps->e[i %% 3]); if (acc & 1) { l_u8++; w[1] = (u8)(w[1] + i); } q = (i & 1) ? q : p_s16 + 1; } r = (%s)(acc + l_u8 + w[1]); }' % (random.randint(0, 999), rt))
        elif kind < 0.6:
            body.append('    r = %s;' % g.expr(rt, 3))
        elif kind < 0.8:
            # compound assignment / inc-dec sequence
            body.append('    r = %s;' % g.expr(rt, 1))
            for _ in range(4):
                op = random.choice(['+=', '-=', '*=', '&=', '|=', '^=', '<<=', '>>=', '++', '--', 'p++', 'p--'])
                tgt = random.choice(['r', 'l_' + random.choice(TYPES), 'g_%s[%d]' % (random.choice(TYPES), random.randint(0, 3)), 'gs.b', 'ps->a', 'p_u16[1]'])
                if op in ('++', '--'):
                    body.append('    %s%s;' % (op, tgt))
                elif op in ('p++', 'p--'):
                    body.append('    %s%s;' % (tgt, op[1:]))
                elif op in ('<<=', '>>='):
                    body.append('    %s %s %d;' % (tgt, op, random.randint(0, 7)))
                else:
                    body.append('    %s %s %s;' % (tgt, op, g.expr(rt, 1)))
            body.append('    r = (%s)(r + %s);' % (rt, g.leaf(rt)))
        else:
            # loop / control flow
            body.append('    { u8 i; r = 0; for (i = 0; i < 5; i++) { if (%s) r = (%s)(r + %s); else r ^= (%s)i; if (i == 3) break; } }' % (g.expr('s16', 1), rt, g.expr(rt, 1), rt))
            body.append('    while (l_u8 > 3) { l_u8 >>= 1; r = (%s)(r * 3 + l_u8); }' % rt)
            body.append('    switch (l_u8 & 3) { case 0: r += 1; break; case 1: r += 10; case 2: r += 100; break; default: r -= 5; }')
            body.append('    switch (g_u8[%d]) { case 0: r += 3; break; case 1: r += 7; break; case 255: r ^= 9; break; default: r += 2; }' % random.randint(0, 3))
            body.append('    switch (g_s8[%d]) { case -1: r += 30; break; case 1: r += 70; break; case 127: r ^= 90; break; default: r += 20; }' % random.randint(0, 3))
            body.append('    { St tmp; tmp = *ps; tmp.b = (s16)(tmp.b + 1); gs = tmp; r += (%s)gs.b; }' % rt)
        body.append('    r = (%s)(r + (%s)pa + (%s)pb);' % (rt, rt, rt))
        body.append('    return (u32)r;')
        body.append('}')
        out += body
    out.append('void run_tests(volatile u32 *res) {')
    for i in range(NTEST):
        out.append('    res[%d] = t%d(&gs, (s16)%d, (u8)%d);' % (i, i, random.randint(-300, 300), random.randint(0, 255)))
    out.append('}')
    return '\n'.join(out) + '\n'

HOST_MAIN = r'''
#include <stdio.h>
void run_tests(volatile u32 *res);
int main(void) { static u32 r[%d]; int i; run_tests(r); for (i = 0; i < %d; i++) printf("%%lu\n", (unsigned long)(r[i] & 0xFFFFFFFFUL)); return 0; }
'''

TARGET_MAIN = r'''
typedef unsigned long u32;
typedef void (*FuncPtr)(void);
void main(void);
const char Licensed[28] = " LICENSED BY SNK CORPORATION";
const FuncPtr EntryPoint = main;
const short CartID = 0x0000;
const short CartSystem = 0x1000;
const char CartTitle[12] = "FUZZTEST    ";
const long CartReserved[4] = { 0, 0, 0, 0 };
extern const unsigned char _DataROM_START, _DataROM_END;
extern unsigned char _DataRAM_START, _Bss_START, _Bss_END;
void run_tests(volatile u32 *res);
void main(void) {
    const unsigned char *s = &_DataROM_START;
    unsigned char *d = &_DataRAM_START;
    unsigned char *b = &_Bss_START;
    while (s < &_DataROM_END) *d++ = *s++;
    while (b < &_Bss_END) *b++ = 0;
    *(volatile unsigned char *)0x6F = 0x4E;
    run_tests((volatile u32 *)0x6000);
    *(volatile u32 *)0x5FFC = 0xC0DEF00DUL;
    for (;;) { *(volatile unsigned char *)0x6F = 0x4E; }
}
'''

def run(seed, work):
    prog = make_program(seed)
    tf = os.path.join(work, 'tests.c')
    open(tf, 'w').write(prog)
    open(os.path.join(work, 'hmain.c'), 'w').write(PRELUDE + HOST_MAIN % (NTEST, NTEST))
    p = subprocess.run(['gcc', '-O0', '-fwrapv', '-w', '-o', os.path.join(work, 'host'), tf, os.path.join(work, 'hmain.c')], capture_output=True, text=True)
    if p.returncode:
        print(p.stderr[:2000]); return False
    exp = [int(x) for x in subprocess.run([os.path.join(work, 'host')], capture_output=True, text=True).stdout.split()]
    open(os.path.join(work, 'tmain.c'), 'w').write(TARGET_MAIN)
    p = subprocess.run([sys.executable, os.path.join(HERE, 'build900.py'), '-o', os.path.join(work, 'f.ngc'),
                        '--work', os.path.join(work, 'b'), os.path.join(work, 'tmain.c'), tf], capture_output=True, text=True)
    if p.returncode:
        print(p.stdout[-3000:], p.stderr[-3000:]); return False
    open(os.path.join(work, 's.txt'), 'w').write('')
    ram = os.path.join(work, 'ram.bin')
    subprocess.run([EMU, CORE, os.path.join(work, 'f.ngc'), '120', os.path.join(work, 's.txt'), os.path.join(work, 'x_'), ram], capture_output=True)
    data = open(ram, 'rb').read()
    if struct.unpack_from('<I', data, 0x1FFC)[0] != 0xC0DEF00D:
        print('seed %d: did not finish' % seed)
        return False
    got = struct.unpack_from('<%dI' % NTEST, data, 0x2000)
    bad = [i for i in range(NTEST) if got[i] != exp[i]]
    if bad:
        print('seed %d: %d mismatches: %s' % (seed, len(bad), [(i, hex(got[i]), hex(exp[i])) for i in bad[:6]]))
        return False
    return True

if __name__ == '__main__':
    work = '/root/fuzzwork'
    os.makedirs(work, exist_ok=True)
    a = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    b = int(sys.argv[2]) if len(sys.argv) > 2 else a + 1
    ok = 0
    for s in range(a, b):
        if run(s, work):
            ok += 1
        else:
            break
    print('%d/%d ok' % (ok, b - a))

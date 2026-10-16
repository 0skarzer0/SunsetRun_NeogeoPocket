#!/usr/bin/env python3
"""build900 - compile C (c900) + asm900/asl sources into a Neo Geo Pocket Color ROM.

usage: build900.py -o game.ngc [-I dir]... [-D name=val]... files...
  .c files are compiled with c900 (the first .c must hold the cartridge header),
  .asm files are Toshiba asm900 sources (converted), .s files are asl sources.
"""
import sys, os, re, subprocess, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import c900

HERE = os.path.dirname(os.path.abspath(__file__))
ASL = os.environ.get('ASL', '/root/asl/asl')
P2BIN = os.environ.get('P2BIN', '/root/asl/p2bin')
HEADER = ['_Licensed', '_EntryPoint', '_CartID', '_CartSystem', '_CartTitle', '_CartReserved']
RAM_BASE = 0x4000
RAM_END = 0x6C00
PAD_TO = 0

def convert_asm900(path):
    out = []
    for raw in open(path, encoding='latin-1').read().splitlines():
        line = raw.rstrip()
        code = line.split(';', 1)[0]
        st = code.strip()
        low = st.lower()
        if not st:
            out.append(line)
            continue
        if low.startswith('$'):
            continue
        w = low.split()
        if w[0] in ('module', 'public', 'extern', 'end') or (len(w) > 1 and w[1] == 'section'):
            continue
        out.append(c900.translate_asm900(line))
    return out

def items_lines(items):
    lines = []
    buf = []
    def flush():
        if buf:
            lines.append('\tdb ' + ','.join(str(b) for b in buf))
            del buf[:]
    for size, v in items:
        if isinstance(v, tuple):
            flush()
            lab, off = v
            lines.append('\tdd %s%s' % (lab, ('%+d' % off) if off else ''))
            continue
        v &= (1 << (8 * size)) - 1
        for i in range(size):
            buf.append((v >> (8 * i)) & 255)
            if len(buf) >= 16:
                flush()
    flush()
    return lines

def build(args):
    compilers = []
    code = []
    asm_extra = []
    tuid = 0
    for f in args.files:
        if f.endswith('.c'):
            c = c900.compile_file(f, tuid, args.I, args.D)
            tuid += 1
            compilers.append(c)
        elif f.endswith('.asm'):
            asm_extra.append('; ---- ' + f)
            asm_extra += convert_asm900(f)
        elif f.endswith('.s'):
            asm_extra.append('; ---- ' + f)
            asm_extra += open(f).read().splitlines()
    objs = {}
    order = []
    for c in compilers:
        code += c.code
        for o in c.objs:
            if o.label in objs:
                prev = objs[o.label]
                if prev.section == 'bss' and o.section != 'bss':
                    objs[o.label] = o
                continue
            objs[o.label] = o
            order.append(o.label)
    rom = [objs[l] for l in order if objs[l].section == 'rom']
    data = [objs[l] for l in order if objs[l].section == 'data']
    bss = [objs[l] for l in order if objs[l].section == 'bss']
    lines = ['\tcpu 96c141', '\tmaxmode on', '\tsupmode on', '\trelaxed on', '\tpage 0',
             '\torg 200000h']
    # cartridge header first
    hdr = [objs[l] for l in HEADER if l in objs]
    if len(hdr) != len(HEADER):
        raise SystemExit('cartridge header objects missing: %s' % [l for l in HEADER if l not in objs])
    for o in hdr:
        lines.append(o.label + ':')
        lines += items_lines(o.items)
    rom = [o for o in rom if o.label not in HEADER]
    lines.append('\talign 2')
    code_start = len(lines)
    lines += code
    code_end = len(lines)
    lines += open(os.path.join(HERE, 'runtime.asm')).read().splitlines()
    lines += asm_extra
    for o in rom:
        if o.type.align > 1:
            lines.append('\talign 2')
        lines.append(o.label + ':')
        lines += items_lines(o.items)
    # RAM layout: bss then data
    addr = RAM_BASE
    ram_syms = []
    for o in bss:
        if o.type.align > 1 and addr & 1:
            addr += 1
        ram_syms.append((o.label, addr))
        addr += max(o.type.size, 1)
    bss_end = addr
    if addr & 1:
        addr += 1
    data_start = addr
    lines.append('\talign 2')
    lines.append('__DataROM_START:')
    for o in data:
        if o.type.align > 1 and addr & 1:
            addr += 1
            lines.append('\tdb 0')
        ram_syms.append((o.label, addr))
        addr += o.type.size
        lines += items_lines(o.items)
    lines.append('__DataROM_END:')
    ram_end = addr
    lines.append('__Bss_START equ %05Xh' % RAM_BASE)
    lines.append('__Bss_END equ %05Xh' % bss_end)
    lines.append('__DataRAM_START equ %05Xh' % data_start)
    lines.append('__RAM_END equ %05Xh' % ram_end)
    for lab, a in ram_syms:
        lines.append('%s equ %05Xh' % (lab, a))
    print('RAM used: %d bytes (0x%04X-0x%04X), stack room %d bytes' % (ram_end - RAM_BASE, RAM_BASE, ram_end, RAM_END - ram_end - 0x100))
    if ram_end > RAM_END - 0x200:
        raise SystemExit('out of RAM')
    return lines, code_end

def run_asl(lines, base, workdir):
    open(base + '.asm', 'w').write('\n'.join(lines) + '\n')
    p = subprocess.run([ASL, '-U', '-q', '-L', '-olist', base + '.lst', base + '.asm'], capture_output=True, text=True, cwd=workdir)
    errs = p.stdout + p.stderr
    bad = [l for l in errs.splitlines() if 'error' in l.lower()]
    return bad, errs

LST_RE = re.compile(r'^\s*(\d+)/\s*([0-9A-F]+) :')

def assemble(lines, out, workdir, ncode):
    base = os.path.join(workdir, 'game')
    # pass 1: every compiler jump long
    cand = {}
    for i in range(ncode):
        m = re.match(r'^\tjr (?:(\w+),)?(\w+)$', lines[i])
        if m:
            cand[i] = (m.group(1), m.group(2))
            lines[i] = '\tjp ' + (m.group(1) + ',' if m.group(1) else '') + m.group(2)
    bad, errs = run_asl(lines, base, workdir)
    if bad:
        print('\n'.join(errs.splitlines()[:60]))
        raise SystemExit('assembly failed')
    for rnd in range(3):
        addr = {}
        for l in open(base + '.lst', encoding='latin-1'):
            m = LST_RE.match(l)
            if m:
                addr.setdefault(int(m.group(1)), int(m.group(2), 16))
        labaddr = {}
        for i, l in enumerate(lines):
            m = re.match(r'^(\w+):\s*$', l)
            if m and (i + 1) in addr:
                labaddr[m.group(1)] = addr[i + 1]
        changed = 0
        for i, (cc, lab) in list(cand.items()):
            if lab not in labaddr or (i + 1) not in addr:
                continue
            d = labaddr[lab] - (addr[i + 1] + 2)
            if -128 <= d <= 127:
                lines[i] = '\tjr ' + (cc + ',' if cc else '') + lab
                del cand[i]
                changed += 1
        if not changed:
            break
        bad, errs = run_asl(lines, base, workdir)
        for fix in range(20):
            far = [int(m.group(1)) for m in re.finditer(r'game\.asm\((\d+)\): error: (?:jump )?distance too big', errs)]
            other = [l for l in bad if 'distance too big' not in l]
            if other or not bad:
                break
            for n in far:
                lines[n - 1] = re.sub(r'\bjr\b', 'jp', lines[n - 1], count=1)
            bad, errs = run_asl(lines, base, workdir)
        if bad:
            print('\n'.join(errs.splitlines()[:60]))
            raise SystemExit('assembly failed after relaxation')
    p = subprocess.run([P2BIN, '-q', '-r', '$200000-$', base + '.p', out], capture_output=True, text=True)
    if p.returncode:
        print(p.stdout, p.stderr)
        raise SystemExit('p2bin failed')
    if PAD_TO:
        # pad with erased flash (0xFF): a 4 Mbit image, so the save blocks of
        # the cartridge (offset 0x78000-0x7BFFF) exist in emulators too
        data = open(out, 'rb').read()
        if len(data) > PAD_TO - 0x8000:
            raise SystemExit('ROM too big for the save area')
        open(out, 'wb').write(data + b'\xff' * (PAD_TO - len(data)))
    print('Built %s (%d bytes)' % (out, os.path.getsize(out)))

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('-o', required=True)
    ap.add_argument('-I', action='append', default=[])
    ap.add_argument('-D', action='append', default=[])
    ap.add_argument('--work', default=None)
    ap.add_argument('--pad', default='0x80000', help='pad the ROM to this size (0 = no padding)')
    ap.add_argument('files', nargs='+')
    a = ap.parse_args()
    global PAD_TO
    PAD_TO = int(a.pad, 0)
    work = os.path.abspath(a.work or os.path.join(os.path.dirname(os.path.abspath(a.o)), 'build900'))
    os.makedirs(work, exist_ok=True)
    try:
        lines, ncode = build(a)
    except c900.CompileError as e:
        raise SystemExit('error: %s' % e)
    assemble(lines, os.path.abspath(a.o), work, ncode)

if __name__ == '__main__':
    main()

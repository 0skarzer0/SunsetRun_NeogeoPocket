"""ramvar.py dump.bin game.asm name[:len[:type]] ... -> print values"""
import re, sys, struct
dump = open(sys.argv[1], 'rb').read()
asm = open(sys.argv[2]).read()
for spec in sys.argv[3:]:
    p = spec.split(':'); name = p[0]; n = int(p[1]) if len(p) > 1 else 1; t = p[2] if len(p) > 2 else 'B'
    m = re.search(r'^(_%s(?:__\d+)?) equ 0?([0-9A-F]+)h' % re.escape(name), asm, re.M)
    a = int(m.group(2), 16) - 0x4000
    sz = struct.calcsize('<' + t)
    print(name, [(lambda v: v[0] if len(v) == 1 else v)(struct.unpack_from('<' + t, dump, a + i * sz)) for i in range(n)])

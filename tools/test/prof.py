"""prof.py hist.bin game.lst [top]: cycles per function from the PC histogram"""
import sys, re, struct, bisect
h = struct.unpack('<%dI' % 0x20000, open(sys.argv[1], 'rb').read())
labels = []
for l in open(sys.argv[2], encoding='latin-1'):
    m = re.match(r'^\s*\d+/\s*([0-9A-F]+) :\s+(_[A-Za-z0-9_]+):', l)
    if m:
        labels.append((int(m.group(1), 16), m.group(2)))
labels.sort()
addrs = [a for a, _ in labels]
acc = {}
tot = 0
for i, c in enumerate(h):
    if not c: continue
    a = 0x200000 + i * 4
    k = bisect.bisect_right(addrs, a) - 1
    name = labels[k][1] if k >= 0 else '?'
    acc[name] = acc.get(name, 0) + c
    tot += c
for n, c in sorted(acc.items(), key=lambda x: -x[1])[:int(sys.argv[3]) if len(sys.argv) > 3 else 30]:
    print('%6.2f%%  %s' % (100.0 * c / tot, n))
print('total cycles', tot)

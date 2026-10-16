#!/usr/bin/env python3
"""Run a hand-written test file (defines run_tests(volatile u32*), N results) on host and target."""
import sys, os, subprocess, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fuzz
def main():
    src, n = sys.argv[1], int(sys.argv[2])
    work = '/root/unitwork'; os.makedirs(work, exist_ok=True)
    body = open(src).read()
    tf = os.path.join(work, 'tests.c'); open(tf, 'w').write(fuzz.PRELUDE + body)
    open(os.path.join(work, 'hmain.c'), 'w').write(fuzz.PRELUDE + fuzz.HOST_MAIN % (n, n))
    subprocess.run(['gcc', '-O0', '-fwrapv', '-w', '-o', work + '/host', tf, work + '/hmain.c'], check=True)
    exp = [int(x) for x in subprocess.run([work + '/host'], capture_output=True, text=True).stdout.split()]
    open(work + '/tmain.c', 'w').write(fuzz.TARGET_MAIN)
    p = subprocess.run([sys.executable, fuzz.HERE + '/build900.py', '-o', work + '/f.ngc', '--work', work + '/b', work + '/tmain.c', tf], capture_output=True, text=True)
    if p.returncode: print(p.stdout, p.stderr); return
    open(work + '/s.txt', 'w').write('')
    subprocess.run([fuzz.EMU, fuzz.CORE, work + '/f.ngc', '120', work + '/s.txt', work + '/x_', work + '/ram.bin'])
    data = open(work + '/ram.bin', 'rb').read()
    print('finished' if struct.unpack_from('<I', data, 0x1FFC)[0] == 0xC0DEF00D else 'NOT FINISHED')
    got = struct.unpack_from('<%dI' % n, data, 0x2000)
    for i in range(n):
        print(i, hex(got[i]), hex(exp[i]), '' if got[i] == exp[i] else '<<<<')
main()

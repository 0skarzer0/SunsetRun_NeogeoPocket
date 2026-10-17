#!/usr/bin/env python3
"""Build SUNSET RUN with the open toolchain on Windows, Linux or macOS.

    python tools/build.py                 -> bin/sunsetrun.ngc
    python tools/build.py -o test.ngc -D AUTOPILOT=1

Steps: graphics, course and music generators (music/*.mid are converted
here), then the c900 C compiler and the Macroassembler AS (asl + p2bin).

Needs Python 3.8+ with `pip install pycparser pillow`.  gcc is NOT needed (a
built-in Python preprocessor is used when gcc is missing).  asl/p2bin are
looked for in: the ASL / P2BIN environment variables, tools/win/ (any
sub-folder: just unzip the official Windows package there), then the PATH.
"""
import os, sys, glob, shutil, subprocess, argparse

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
FLAGS = ['NGP_ENABLE_SOUND=1', 'NGP_ENABLE_FLASH_SAVE=1', 'NGP_ENABLE_DEBUG=0', 'NGP_PROFILE_RELEASE=1',
         'NGP_ENABLE_DMA=1', 'NGP_ENABLE_SPRMUX=0', 'NGP_ENABLE_PROFILER=0', 'NGP_DMA_ALLOW_VBLANK_TRIGGER=0',
         'NGP_DMA_INSTALL_DONE_ISR=0', 'NGP_DMA_INSTALL_REARM_ISR=1', 'ID_PROBE=0', 'NGP_FAR=', 'NGP_NEAR=']
INCLUDES = ['src', 'src/core', 'src/gfx', 'src/fx', 'GraphX']
EXE = '.exe' if os.name == 'nt' else ''


def find_tool(name, env):
    if os.environ.get(env):
        return os.environ[env]
    for base in (os.path.join(ROOT, 'tools', 'win'), os.path.join(ROOT, 'tools', 'asl')):
        for dirpath, dirs, files in os.walk(base):
            for f in files:
                if f.lower() in (name + EXE, name):
                    return os.path.join(dirpath, f)
    p = shutil.which(name)
    if p:
        return p
    if os.path.isfile('/root/asl/' + name):
        return '/root/asl/' + name
    return None


def msg_path(asl):
    """folders holding the AS message files (*.msg), for AS_MSGPATH"""
    dirs = set()
    start = os.path.dirname(os.path.dirname(os.path.abspath(asl)))
    for dirpath, _, files in os.walk(start):
        if any(f.lower().endswith('.msg') for f in files):
            dirs.add(dirpath)
    return os.pathsep.join(sorted(dirs))


def run(cmd):
    print('>', ' '.join(os.path.relpath(c, ROOT) if os.path.isabs(c) else c for c in cmd))
    r = subprocess.run(cmd, cwd=ROOT)
    if r.returncode:
        raise SystemExit('build failed')


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('-o', default='sunsetrun.ngc', help='ROM file name inside bin/')
    ap.add_argument('-D', action='append', default=[], help='extra define, e.g. AUTOPILOT=1')
    a = ap.parse_args()
    try:
        import pycparser, PIL  # noqa
    except ImportError:
        raise SystemExit('Missing Python packages. Run:  python -m pip install pycparser pillow')
    asl, p2bin = find_tool('asl', 'ASL'), find_tool('p2bin', 'P2BIN')
    if not asl or not p2bin:
        raise SystemExit(
            'The assembler (asl and p2bin) was not found.\n'
            'Windows: download the AS package\n'
            '  http://john.ccac.rwth-aachen.de:8000/ftp/as/precompiled/i386-unknown-win32/aswcurr.zip\n'
            'and unzip it into the folder tools\\win\\ of this project, then run build.bat again.')
    env = dict(os.environ, ASL=asl, P2BIN=p2bin, PYTHONUTF8='1')
    mp = msg_path(asl)
    if mp:
        env['AS_MSGPATH'] = mp
    os.environ.update(env)
    py = sys.executable
    run([py, os.path.join('tools', 'gen_gfx.py'), 'GraphX'])
    run([py, os.path.join('tools', 'gen_course.py'), 'GraphX'])
    run([py, os.path.join('tools', 'gen_title.py'), 'GraphX'])
    run([py, os.path.join('tools', 'gen_map.py'), 'GraphX'])
    run([py, os.path.join('tools', 'gen_music.py'), os.path.join('src', 'audio')])
    files = [os.path.join('src', 'main.c')]
    for top in ('src', 'GraphX'):
        for dirpath, _, names in os.walk(os.path.join(ROOT, top)):
            for n in names:
                rel = os.path.relpath(os.path.join(dirpath, n), ROOT)
                if n.endswith('.c') and n not in ('main.c', 'ngpc_runtime.c'):
                    files.append(rel)
    c_files = [files[0]] + sorted(files[1:])
    asm_files = []
    for dirpath, _, names in os.walk(os.path.join(ROOT, 'src')):
        for n in names:
            if n.endswith('.asm') and n != 'ngpc_runtime_alias.asm':
                asm_files.append(os.path.relpath(os.path.join(dirpath, n), ROOT))
    os.makedirs(os.path.join(ROOT, 'bin'), exist_ok=True)
    cmd = [py, os.path.join('tools', 'c900', 'build900.py'), '-o', os.path.join('bin', a.o),
           '--work', os.path.join('build', 'open')]
    for d in FLAGS + a.D:
        cmd += ['-D', d]
    for i in INCLUDES:
        cmd += ['-I', i]
    run(cmd + c_files + sorted(asm_files))


if __name__ == '__main__':
    main()

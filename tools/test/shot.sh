#!/bin/sh
# shot.sh rom script frames outdir : runs the ROM headless with a scripted
# input and saves the requested frames as PPM + PNG (x3).
# Env: CPUSLOW=n (CPU n/16 slower), WAVOUT=f.wav, RAMDUMP=f.bin, PROF=f.bin PROFFROM=frame
HERE=$(cd "$(dirname "$0")" && pwd)
rom=$1; scr=$2; n=$3; out=$4
mkdir -p "$out"; rm -f "$out"/*.ppm "$out"/*.png
"$HERE/bin/run" "$HERE/bin/core.so" "$rom" "$n" "$scr" "$out/f_"
python3 -c "
import glob
from PIL import Image
for f in sorted(glob.glob('$out/f_*.ppm')):
    Image.open(f).resize((480,456),Image.NEAREST).save(f[:-4]+'.png')
"

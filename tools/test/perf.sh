#!/bin/sh
# perf.sh : frame pacing under CPU slowdown.
#   EXTRA="-D PERF=1" OUT=perf.ngc ./build_open.sh      (from the project root)
#   CS="0 6 10 12" tools/test/perf.sh bin/perf.ngc build/open/game.asm
# perf_hist[k] = frames shown for k VBlanks (2 = 30 fps; 3+ = a dropped frame)
# perf_done[k] = frames whose work ended k VBlanks after their start (0 = < 1 VBlank)
HERE=$(cd "$(dirname "$0")" && pwd)
TMP=${TMPDIR:-/tmp}
for c in ${CS:-0 4 6 8 10 12}; do
  CPUSLOW=$c RAMDUMP=$TMP/sr_ram.bin "$HERE/bin/run" "$HERE/bin/core.so" "$1" 3000 "$HERE/scripts/drive.txt" "$TMP/sr_x_" >/dev/null 2>&1
  echo "cpu+$c/16 $(python3 "$HERE/ramvar.py" $TMP/sr_ram.bin "$2" perf_hist:8:H perf_done:8:H)"
done

#!/bin/sh
# profile.sh rom lst [top] : cycles per function (release build, scripted drive)
#   tools/test/profile.sh bin/sunsetrun.ngc build/open/game.lst
HERE=$(cd "$(dirname "$0")" && pwd)
TMP=${TMPDIR:-/tmp}
PROFFROM=600 PROF=$TMP/sr_prof.bin "$HERE/bin/run" "$HERE/bin/core.so" "$1" 3000 "$HERE/scripts/drive.txt" "$TMP/sr_x_" >/dev/null 2>&1
python3 "$HERE/prof.py" $TMP/sr_prof.bin "$2" ${3:-30}

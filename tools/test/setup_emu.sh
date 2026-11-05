#!/bin/sh
# Builds the headless test emulator (Linux): Beetle NGP (libretro, GPL) at a
# fixed commit with tools/test/beetle-ngp.patch (CPUSLOW + PC profiler), and
# the small frontend run.c.  Result: tools/test/bin/core.so and tools/test/bin/run
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
OUT=$HERE/bin
SRC=${BEETLE_SRC:-$HERE/bin/beetle-ngp}
mkdir -p "$OUT"
if [ ! -d "$SRC/.git" ]; then
    git clone https://github.com/libretro/beetle-ngp-libretro "$SRC"
fi
cd "$SRC"
git checkout -q a50d5ac
git apply --check "$HERE/beetle-ngp.patch" 2>/dev/null && git apply "$HERE/beetle-ngp.patch" || echo "(patch already applied)"
make -j"$(nproc)"
cp mednafen_ngp_libretro.so "$OUT/core.so"
cc -O2 -o "$OUT/run" -I"$HERE" "$HERE/run.c" -ldl
echo "OK: $OUT/core.so  $OUT/run"

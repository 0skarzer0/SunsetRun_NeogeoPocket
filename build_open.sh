#!/bin/sh
# Build SUNSET RUN with the open toolchain (c900 + asl). See README.
set -e
cd "$(dirname "$0")"
TC=${TC:-tools/c900}
python3 tools/gen_gfx.py GraphX
python3 tools/gen_course.py GraphX
python3 tools/gen_title.py GraphX
python3 tools/gen_map.py GraphX
python3 tools/gen_music.py src/audio
F="-D NGP_ENABLE_SOUND=1 -D NGP_ENABLE_FLASH_SAVE=1 -D NGP_ENABLE_DEBUG=0 -D NGP_PROFILE_RELEASE=1 -D NGP_ENABLE_DMA=1 -D NGP_ENABLE_SPRMUX=0 -D NGP_ENABLE_PROFILER=0 -D NGP_DMA_ALLOW_VBLANK_TRIGGER=0 -D NGP_DMA_INSTALL_DONE_ISR=0 -D NGP_DMA_INSTALL_REARM_ISR=1 -D ID_PROBE=0 -D NGP_FAR= -D NGP_NEAR= $EXTRA"
INC="-I src -I src/core -I src/gfx -I src/fx -I GraphX"
FILES="src/main.c $(find src GraphX -name '*.c' ! -name main.c | sort) $(find src -name '*.asm' | sort)"
mkdir -p bin
python3 $TC/build900.py -o bin/${OUT:-sunsetrun.ngc} --work build/open $F $INC $FILES

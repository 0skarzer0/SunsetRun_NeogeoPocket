# Pruebas, perfilado y rendimiento

## Emulador sin pantalla

* **Montaje:** `tools/test/setup_emu.sh` (Linux; hace falta git, make y un
  compilador de C).
  * Clona Beetle NGP (libretro, GPL) en el commit `a50d5ac`.
  * Aplica `beetle-ngp.patch`, que añade `CPUSLOW` (la CPU va n/16 más lenta) y un
    histograma de PC para perfilar (`prof_*`).
  * Compila `run.c`, un frontend libretro mínimo.
  * Deja `tools/test/bin/core.so` y `tools/test/bin/run`.
* **Uso:** `run core.so rom.ngc FRAMES guion.txt prefijo`.
* **Guion** (`tools/test/scripts/`), una orden por línea:
  * `inicio fin BOTONES` mantiene pulsados los botones en esos fotogramas. Los
    botones son A, B, L, R, U, D y O (OPTION). En el juego, A es acelerar y B frenar.
  * `shot N` guarda una captura del fotograma N; `shot a b paso` guarda varias.
  * `drive.txt` es una conducción de ~3000 fotogramas que se usa para perfilar.
* **Variables de entorno:**
  * `CPUSLOW=n`.
  * `WAVOUT=f.wav` graba el audio (estéreo, 16 bits, sin cabecera).
  * `RAMDUMP=f.bin` vuelca la RAM al final; se lee con `ramvar.py` y
    `build/open/game.asm`.
  * `PROF=f.bin PROFFROM=600` perfila; se lee con `prof.py` y `build/open/game.lst`.
* **Capturas:** `tools/test/shot.sh rom guion N carpeta` las convierte a PNG ×3.
  Para revisarlas, se montan en un mosaico con PIL y se miran.

## Recetas

```sh
# capturas de una escena con puentes
EXTRA="-D AUTOPILOT=1 -D AP_GHOST=1 -D TEST_LEG=0x22" OUT=tb.ngc ./build_open.sh
tools/test/shot.sh bin/tb.ngc tools/test/scripts/bridges.txt 2700 /tmp/b

# carrera completa en FREE con semilla
EXTRA="-D AUTOPILOT=1 -D TEST_DIFF=3 -D TEST_SEED=0x1234" OUT=apf.ngc ./build_open.sh
tools/test/shot.sh bin/apf.ngc tools/test/scripts/full_race.txt 24000 /tmp/f

# ritmo de imagen con la CPU frenada
EXTRA="-D PERF=1" OUT=perf.ngc ./build_open.sh
CS="0 6 8 10 12" tools/test/perf.sh bin/perf.ngc build/open/game.asm

# perfil por funciones (ROM normal)
./build_open.sh && tools/test/profile.sh bin/sunsetrun.ngc build/open/game.lst 30

# Windows: el preprocesador en Python debe dar la misma ROM
C900_CPP=py python3 tools/build.py -o win.ngc && cmp bin/win.ngc bin/sunsetrun.ngc
```

* **Cuidado al comparar capturas:** la lógica va en tiempo real, así que si cambia
  la velocidad del código, la misma entrada puede dar fotogramas desfasados una
  imagen.
* **Para una equivalencia exacta:** compara dos versiones que cuesten lo mismo; por
  ejemplo asm contra C con `-D WIDE_C=1`.

## Cifras (18-oct-2026, conducción `drive.txt`, ROM normal)

Perfil (porcentaje del tiempo total):

| Función | % |
|---|---|
| `ngpc_vsync` (ocioso) | 47,8 |
| `id_road_walk_asm` | 8,0 |
| `spr_cells_asm` | 4,4 |
| `id_road_curve_asm` | 4,4 |
| `id_road_shear_asm` | 4,2 |
| `id_scenery_draw` (C) | 4,0 |
| `id_road_ahead_asm` (todas sus partes) | ~7 |
| `id_road_write` | 1,8 |
| `id_road_wide_asm` | 1,5 |
| `traffic_draw` | 0,9 |
| `player_update` (música) | 0,8 |

Ritmo (`perf_hist[2]` son las imágenes a 30 fps; 3 o más son imágenes perdidas):

* De CPUSLOW 0 a 10: todas a 2 VBlanks (unas pocas a 3 en 10).
* CPUSLOW 12: unas 35 de 1470 a 3 VBlanks.
* CPUSLOW 14: empieza a bajar de verdad.
* HARD (más tráfico): igual de estable hasta 10.

Antes de la fase 7 había un 39 % de tiempo ocioso, y los sprites y puentes se
escribían a mitad de imagen.

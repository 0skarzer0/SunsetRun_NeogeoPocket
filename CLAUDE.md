# SUNSET RUN — memoria del proyecto para Claude

Lee este archivo entero al empezar una sesión nueva. Con él y con `docs/` deberías
poder seguir exactamente donde se dejó. Más detalle:

* `docs/HISTORIAL.md`: qué pidió el usuario, en qué orden, qué se decidió y por qué.
* `docs/ARQUITECTURA.md`: cómo funciona el código (motor, imagen, memoria, formatos).
* `docs/PRUEBAS.md`: el emulador sin pantalla, los guiones de prueba, el perfilado y las cifras de rendimiento.
* `README.md`: la cara pública (cómo se juega, cómo se compila).

## Qué es

Un arcade de carreras al estilo OutRun para **Neo Geo Pocket Color (NGPC)**, hecho
sobre el motor **OVER REV** (Tixul / NgpCraft, licencia MIT). Incluye:

* 5 etapas en pirámide (15 tramos, 5 metas, cada meta con su final).
* Bifurcaciones izquierda/derecha y checkpoints con *EXTENDED PLAY*.
* Tráfico, cambio de dos marchas LOW/HIGH, choques con vuelco, puentes de piedra.
* Cuatro modos: EASY, NORMAL, HARD y FREE (FREE genera el recorrido con una semilla).
* Récords en la flash, un mapa del recorrido al acabar y una radio con los MIDI del usuario.

* Repositorio: https://github.com/0skarzer0/SunsetRun_NeogeoPocket (rama `main`).
* Usuario: Óscar (oscar.laguna.garcia@gmail.com). Escribe en **español**: responde en español.
* Compila en **Windows** con `build.bat`, y prueba en emulador y quizá en flashcart.

## Reglas que no se rompen

1. **Nada de SEGA:** ni el nombre OutRun en el juego, ni logotipos, ni gráficos,
   melodías o sonidos copiados de juegos comerciales. Todo el arte se genera por
   código en `tools/`. El usuario nos pasó capturas y MIDIs de OutRun solo como
   **inspiración**: nunca se copian a la ROM ni al repositorio.
2. **Es para uso personal**, gratuito, nunca se venderá; el código es libre (MIT).
3. **Música del usuario:**
   * La radio usa los MIDI que él ponga en `music/`.
   * Esos `.mid` (y los `.vgm`/`.vgz`) están en `.gitignore`: **no se suben nunca**.
     Solo acaban en la ROM que él compila.
   * La ROM que se publique en el repositorio se compila **sin** ellos.
   * Se rechazó meter en el proyecto entregado unos MIDIs de Camela (canciones con
     copyright, uno marcado "Copyright © 2000 by Luis Fernando Romero"). Él puede
     usarlos en su copia privada.
4. Antes se probaron temas originales y luego clásicos y Scott Joplin (dominio
   público). El usuario los descartó todos y **decidió usar sus propios MIDI**: no
   vuelvas a proponer música propia salvo que la pida.
5. **Fluidez por encima de todo:**
   * 30 fps fijos, sin parpadeos ni tearing (ver "La imagen" en `docs/ARQUITECTURA.md`).
   * Cualquier cambio en el bucle de dibujo se mide con `tools/test/perf.sh`.
   * 60 fps no es viable: solo la carretera ya ocupa casi un VBlank.

## Cómo trabajar con el usuario

* Le gusta ver resultados: manda capturas (mosaicos PNG del emulador) cuando cambie
  algo visual, y la ROM + zip del código al terminar.
* Da instrucciones concretas y numeradas ("1.- … 2.- …"). Hazlas todas y responde
  punto por punto.
* Le gustan los detalles de "recreativa": humo, sonidos con retardo, el coche que
  culea, globos, público.
* Revisión de fondos uno a uno: **en curso**. Se le enseñó el fondo 1 (playa) y
  falta su opinión. El siguiente es la costa. Orden: `THEME_ORDER` en
  `tools/gen_course.py` (beach, coast, alps, city, desert, fields, autumn, caves,
  snow, farm, autobahn, canyon, lake, seaside, ruins).

## Compilar

* **Windows:** `build.bat`. Instala `pycparser` y `pillow`, descarga el ensamblador
  AS (`asw.exe`, `p2bin.exe`) en `tools\win\` y llama a `tools/build.py`.
* **Linux:**
  * `./build_open.sh`, con `asl` y `p2bin` en el PATH (AS 1.42 Beta Bld 306).
  * Las opciones van en variables: `EXTRA="-D AUTOPILOT=1" OUT=test.ngc ./build_open.sh`.
  * `python3 tools/build.py [-o x.ngc] [-D X=1]` es lo mismo con el preprocesador en Python.
    Con `C900_CPP=py` se fuerza ese preprocesador. Debe dar una ROM **idéntica byte
    a byte**; compruébalo con `cmp` si tocas el compilador.
* **Salida:**
  * `bin/sunsetrun.ngc`, de 512 KB: la ROM se rellena con 0xFF para la zona de
    guardado flash.
  * `build/open/game.asm` y `game.lst`, el ensamblador y el listado; los usan
    `ramvar.py` y `prof.py`.
  * El informe da la RAM usada: unos 7,6 KB, con unos 3,4 KB libres para la pila.
* **Generadores**, que se ejecutan siempre en la compilación:
  * `gen_gfx`, `gen_course`, `gen_title` y `gen_map` escriben en `GraphX/`.
  * `gen_music` convierte `music/*.mid` y escribe en `src/audio/`.
  * Los `.c`/`.h` de `GraphX/` y `src/audio/music_data.*` son **generados**: no los
    edites a mano; cambia el script.

## Probar (detalles en docs/PRUEBAS.md)

* `tools/test/setup_emu.sh` compila el emulador sin pantalla. Hace falta git, make y
  cc, y sale en `tools/test/bin/`.
* `tools/test/shot.sh rom guion.txt N salida/` guarda capturas.
* Ganchos de prueba que se activan al compilar con `EXTRA="-D ..."`; sin ellos no
  cuestan nada:
  * `AUTOPILOT=1` conduce solo. `AP_GHOST=1` hace que no choque. `AP_WILD` conduce a lo loco.
  * `TEST_LEG=0xSB` empieza en la etapa S, rama B (0x22 = campos, con puentes).
  * `TEST_DIFF=0..3` fuerza el modo y `TEST_SEED=0x1234` la semilla.
  * `TEST_TIME=1` congela el reloj y `TEST_HI` fija los récords.
  * `TEST_ENDING=n` salta al final n y `TEST_MUSIC=n` pone la canción n.
  * `PERF=1` llena los histogramas de ritmo de imagen.
* Antes de entregar haz siempre esta regresión:
  * Carrera completa con AUTOPILOT en EASY, HARD y FREE.
  * El paso de resultados a título.
  * Una escena con puentes y la salida con la pancarta START.
  * La compilación con el preprocesador Python idéntica.

## Estado actual (noviembre de 2026)

Últimos cambios, de los más recientes a los más antiguos:

* **Optimización máxima y fuera lo innecesario:**
  * La radio ya solo sale de los MIDI del usuario, con SILENCIO siempre al final.
  * Vienen incluidos un jingle GOAL y otro OVER, originales y cortos, que se pueden
    sustituir con `music/goal*.mid` y `music/over*.mid`.
  * Se quitaron Joplin y LilyPond, las grabaciones de `media/`, el camino de
    compilación cc900 de Toshiba, la cola de VRAM y las herramientas del fuzzer.
* **Imagen sin tearing:**
  * Hay una copia en RAM de la tabla de sprites.
  * La capa SCR1 de puentes y pancartas va en `src/ovl.c`.
  * El ISR del VBlank lo copia todo junto con la tabla de raster de la carretera.
  * Cada imagen se publica en el segundo VBlank, nunca antes (`frame_commit()` en `main.c`).
* **Resultado:**
  * La CPU está ociosa ~48 % en carrera.
  * Aguanta 30 fps con la CPU un 60 % más lenta (CPUSLOW=10; a 12 empieza a
    perder alguna imagen).

## Pendiente / ideas abiertas

* **Revisión de fondos uno a uno:** esperar la opinión del usuario sobre la playa
  y seguir con la costa.
* **Formato VGM/VGZ:**
  * El usuario preguntó (5-nov-2026) si se acepta.
  * Respuesta: sí para los VGM de chip PSG (SN76489 / T6W28: Master System, Game
    Gear, la propia NGPC…), que se pueden convertir casi tal cual.
  * Los de FM (YM2612 de Mega Drive, YM2151…) no; como mucho su parte PSG o una
    reducción a tres voces.
  * Hace falta escribir `tools/vgm.py`: leer el VGM (gzip si es .vgz), volcar el
    estado de los registros PSG por fotograma (60 Hz) y añadir al reproductor un
    código de evento con divisor/atenuación en crudo (hoy solo hay notas de la
    tabla G2..A6).
  * Esperar a que el usuario mande un archivo de ejemplo para probarlo.
* **Mejoras de rendimiento que quedan**, si algún día hacen falta:
  * `id_scenery_draw` (~4 %) y `traffic_draw` (~1 %) siguen en C.
  * Lo demás de la lista de perfilado ya está en ensamblador.
* **Hardware real:** nunca se ha probado. El emulador Beetle NGP no emula el
  borrado de bloques de flash, así que allí el guardado dura unas 60 grabaciones.

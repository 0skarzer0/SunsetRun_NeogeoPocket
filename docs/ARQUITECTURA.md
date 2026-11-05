# Arquitectura de SUNSET RUN

## Hardware (lo que importa)

* **CPU:** TLCS-900/H a 6,144 MHz, unos 102 400 ciclos por VBlank (60 Hz). El
  VBlank dura las líneas 152 a 198, unos 24 000 ciclos.
* **Vídeo K2GE:**
  * 512 caracteres de 8×8 a 2 bpp.
  * 64 sprites: tabla en `0x8800` (4 bytes cada uno: tile, atributos, x, y) y
    paletas por sprite en `0x8C00`.
  * Planos SCR1 (mapa en `0x9000`, 32×32 celdas u16) y SCR2, con 16 paletas cada uno.
  * El color de fondo está en `0x8118` y la paleta en `0x83E0`.
  * Los sprites con prioridad `SPR_MIDDLE` quedan entre SCR2 y SCR1: así los objetos
    lejanos pasan por detrás de los puentes.
* **Sonido:** PSG T6W28 (3 tonos + ruido) movido por el Z80. Un programa Z80 diminuto
  de NgpCraft lee un buzón en `0x7003`/`0x7004`.
* **Flash:** la ROM se rellena a 512 KB con 0xFF; el guardado usa los últimos bloques.

## Bucle principal (`src/main.c`)

* **Estados:** `ST_TITLE`, `ST_COUNT`, `ST_RACE`, `ST_TIMEUP`, `ST_GOAL`,
  `ST_RESULT` y `ST_MAP` (el mapa va antes de los resultados).
* **Ritmo:**
  * La lógica avanza a 30 Hz fijos, con hasta 3 pasos de puesta al día si una imagen
    tarda.
  * Se dibuja una sola imagen por iteración.
  * La espera inicial es `while (g_vb_counter - pace_prev < 2) vsync` y después
    `while (spr_ready) vsync`.
* **Orden de dibujo:** `render_road` → `tick_flash`/`tick_message` → `bridge_draw` →
  `id_scenery_draw` → `traffic_draw` → `balloons_draw` → pancarta → HUD → coche,
  humo y motor → `frame_commit()`.
* **El título y el mapa** no dibujan carretera: hacen `frame_commit()` y `continue`.

## La imagen: sin tearing ni parpadeos (fase 7)

Todo lo que se mueve se prepara fuera de pantalla y se publica de golpe en el VBlank:

1. **Carretera:**
   * Las tablas de raster (`id_xy_a`/`id_xy_b`) tienen doble búfer.
   * `id_road_frame_ahead()` ya no publica la tabla: lo hace `id_road_ready()` desde
     `frame_commit()`.
   * El gancho del VBlank (`id_road_rearm`) rearma la MicroDMA con la tabla lista.
2. **Sprites:**
   * Todo se escribe en `spr_shadow[128]` (u16) y `spr_pal_shadow[32]`, en
     `id_player.c`.
   * También escriben ahí la macro `ID_SPR_PUT_PRIORITY` y `spr_cells_asm.asm`.
   * El ISR (`core/ngpc_sys.c`), si `spr_ready` está a 1, copia 128 + 32 palabras a
     `0x8800`/`0x8C00` con `ngpc_memcpy_w` (LDIRW, en `core/ngpc_memcpy_asm.asm`).
3. **Capa SCR1** (`src/ovl.c`):
   * Los puentes y las pancartas START/FINISH dibujan en `ovl_grid` (filas 2–18 ×
     20 columnas), en RAM.
   * `ovl_mark()` acumula la caja cambiada.
   * En el ISR, `ovl_flush_asm` (en `spr_cells_asm.asm`) escribe solo las celdas
     distintas de `ovl_prev`, después del rearme de la DMA.
   * El texto escrito encima, como los mensajes del HUD, no se toca salvo que la
     capa cambie esa celda.
   * `ovl_touch()` obliga a reescribir una zona y `ovl_forget()` vacía la capa al
     cambiar de pantalla (la llaman `hud_clear_top`, `title_screen` y `map_screen`).
4. **`frame_commit()`:**
   * Espera a que haya pasado al menos 1 VBlank desde el inicio de la imagen
     (`frame_vb`).
   * Luego llama a `ovl_commit()` e `id_road_ready()` y pone `spr_ready = 1`.
   * Así toda imagen sale en el **segundo** VBlank tras empezarla. Una imagen rápida
     que saliera un VBlank antes haría tirones (1, 3, 2… VBlanks).
5. **Choques:** el coche ya no parpadea; solo se balancea.

Lo que sigue escribiéndose a mitad de imagen: los dígitos del HUD, los mensajes y las
paletas al cambiar de tramo. Son cambios pequeños o puntuales.

## Motor de carretera (`src/id_road*.c`, `id_road_asm.asm`, `driving.inc`)

* **Origen:** OVER REV. Es una carretera por raster: cada línea elige fila y
  desplazamiento del mapa de la carretera mediante MicroDMA (`ngpc_dma_raster`).
* **Carretera más ancha que la pantalla:**
  * El mapa solo mide 256 px, así que las filas cercanas se guardan tres veces
    (centrada y desplazada ±96 px), y `wide_rows` elige cuál usar.
  * Ahora está en asm: `id_road_wide_asm`, con la estructura `RoadWide` de 12 bytes.
  * Hay una versión en C de referencia tras `-D WIDE_C=1` y deben dar imágenes
    idénticas.
* **Partes en asm:** `id_road_walk_asm`, `curve_asm`, `shear_asm` y `ahead_asm`.
* **Convención de llamada de c900** para el asm:
  * El primer argumento está en `(xsp+4)`.
  * XIZ lo guarda quien es llamado; XWA, XBC, XDE, XHL, XIX y XIY son libres.
  * Los `u8` también ocupan 4 bytes en la pila.
  * Las estructuras se pasan por puntero, con desplazamientos fijos (comprobados en C
    con `typedef char x[(sizeof(T)==N)?1:-1]`).
* **c900 genera código lento** (mucho movimiento de pila): los bucles calientes van
  a asm.

## Recorrido (`src/course.c`, `tools/gen_course.py`)

* **Búfer de segmentos:** `buf[BUF_MAX=72]` contiene el tramo actual, el siguiente
  (una vez elegida la bifurcación) y una recta de relleno.
* **Tramos fijos:** salen de `gen_course.py` (`gfx_legs`, `gfx_themes`). El modo FREE
  los genera en tiempo de ejecución con el mismo algoritmo, `gen_leg()`.
  * `LEG_ID(s,b)` = s(s+1)/2 + b.
  * Los temas siguen `THEME_ORDER`.
* **Temas con puentes:** fields, autumn, farm, lake y ruins. El tramo de puentes se
  inserta cuando el total pasa de `LEG_BRIDGE_AT` = 2/5 del tramo.
* **Coste de un tramo:** `cost_of()` es la misma fórmula que `leg_cost()` en Python.
  Sirve para el reloj de FREE: `leg_time()` escala por `next_leg_cost` /
  `gfx_leg_ref_cost`, suma +1 s y limita a 35..90 s.

## Puentes (`src/bridge.c`)

* **Colocación:**
  * `bridge_setup` busca el span `LEG_BRIDGE_MARK` (1010) y pone un puente cada
    `BR_GAP` 260 unidades; caben `BR_MAX` 12.
* **Geometría:**
  * Tamaño en perspectiva: `id_road_sprite_sample`.
  * Medidas: `OPEN(h) = h + h/6 + 3` y `PILLAR(h) = h/3`.
* **Grosor según la distancia:**
  * `slim` 2 (3 px) si p < 4, 1 (5 px) si p < 8, y piedra completa a partir de ahí.
  * Las tiles van en huecos de la fuente: `@[\]^_` para la piedra y `"';=>?` para los
    finos.
* **Interacción:**
  * `bridge_line` es la línea del pie del puente más cercano. Los sprites que hay
    más allá pasan a `SPR_MIDDLE`.
  * `bridge_hit` detecta el choque con los pilares.
  * Solo se redibuja si cambia la firma (`sig`).

## Sprites y paletas (`src/game.h`)

* **Sprites:** 0–23 coche y HUD; 24–27 humo; 28–49 tráfico (un camión cerca usa
  20); 50–63 objetos del arcén; 58–63 letras de la pancarta. Los 8 globos usan los
  últimos huecos del tráfico (`trf_spr_end`).
* **Paletas de sprite:**
  * 1/2 objetos; 3 humo; 4 bifurcación; 6 público; 7 letras; 8 trofeo; 9 señal;
    10 bandera; 11–15 los cinco colores del tráfico.
  * El público alterna `{PAL_CROWD, 8, PAL_OBJ_FLAG}` por j%3 (`theme_crowd_colours`).
* **Panorama:** 13 paletas de SCR2 (`pano_slot = {8..15, 2..6}`).

## Choques (`main.c`)

* **Contra el arcén:**
  * La gravedad es `max(speed, verge_spd)`.
  * Por encima de `CRASH_SPEED` 110 el coche trompea. Por encima de `ROLL_SPEED` 168
    vuelca de lado (`roll_kind` 0). Por encima de `FLIP_SPEED` 214 da la vuelta hacia
    delante (`roll_kind` 1).
  * Fotogramas en `gfx_roll_frames` (24, con offsets u16).
* **Contra el tráfico:** `traffic_collide` devuelve el lado. Luego empuje, humo,
  derrape retardado y culeo (ver fase 3 en `HISTORIAL.md`).

## Guardado (`main.c` save_*, `core/ngpc_flash*`)

* **Registro de 256 bytes:**
  * 0–3 la marca `CA FE 20 26`.
  * 4 la versión (1).
  * 5 la emisora.
  * 6 el modo.
  * 8–23 cuatro récords u32.
  * 24–25 la semilla.
* **Cuándo se escribe:** solo al cambiar de pantalla, con la DMA de la carretera en
  pausa.

## Música (`tools/gen_music.py`, `tools/midi.py`, `src/audio/player.c`)

* **Streams por voz** (lead, bajo, armonía, ruido):
  * `1..51 nota, duración` (notas G2..A6, vía `NOTE_TABLE`).
  * `0xFF silencio, dur`; `0xF0 n` atenuación; `0xF4 n` instrumento; `0x00` fin/bucle.
  * En la voz de ruido, el byte de nota es el control de ruido + 1.
* **El canal 2** lo coge el sonido del motor durante la carrera, así que la armonía
  solo suena fuera de ella.
* **El reproductor** se ejecuta 1 vez por iteración (30 Hz), con el tiempo
  transcurrido `e`. La envolvente es un contador (`add`/`acc`), sin divisiones.
  Gasta ~1 % de CPU.
* **`midi.py`:** convierte los MIDI a 4 voces (hasta 8 emisoras). Los ficheros
  `goal*`/`over*` sustituyen a los jingles.
* **Cabecera generada:** `MUSIC_RADIO` es el número de emisoras (incluye SILENCIO);
  luego vienen `MUSIC_GOAL` y `MUSIC_OVER`.

## Toolchain

* **`tools/c900/`:**
  * `c900.py` compila C89 a ensamblador de asl.
  * `build900.py` enlaza: coloca la RAM (alinea a 2 los tipos con `align > 1`),
    define los símbolos de arranque y rellena la ROM a 512 KB.
  * `cpp.py` es el preprocesador en Python, equivalente a `gcc -E`.
* **`tools/build.py`:** compilación en cualquier sistema (la usa `build.bat`).
  `build_open.sh` hace lo mismo en Linux.
* **Generadores de gráficos:**
  * `gen_gfx.py` (sprites, fuente, puentes, vuelcos) y `pano.py` (panoramas).
  * `gen_title.py`, `gen_map.py` y `objart.py`.
  * `conv.py` / `ngpgfx.py` convierten imagen a tiles.

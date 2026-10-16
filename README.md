# SUNSET RUN

Un arcade de carretera al estilo de **OutRun** para **Neo Geo Pocket Color**:
contrarreloj con checkpoints, cinco etapas con bifurcaciones (15 tramos y 5 metas),
tráfico, radio con tres temas originales y el clásico "elige izquierda o derecha".

Proyecto homebrew, gratuito y de código abierto. No está afiliado a SEGA; nombre,
gráficos y música son originales.

![gameplay](media/gameplay.gif)

## Jugar

Carga `bin/sunsetrun.ngc` en un emulador de NGPC (Mednafen, RACE, NeoPop…) o en una
flashcart.

| Botón | Carrera | Título |
|---|---|---|
| A | Acelerar | Empezar |
| B | Frenar | – |
| Izquierda / Derecha | Girar | Cambiar emisora de radio (la última, SILENCIO, deja solo el motor) |
| Arriba / Abajo | Marcha LOW / HIGH | – |
| OPTION | Pausa | – |

* Cambio de dos marchas, como el arcade: **LOW** acelera muy rápido hasta unos 180 km/h;
  **HIGH** llega a la velocidad máxima (~290 km/h) pero por debajo de 180 km/h acelera
  muy despacio. Sal en LOW y pasa a HIGH al acercarte a 180: el indicador LOW
  parpadea en rojo para recordártelo.
* Hay curvas suaves que se toman a fondo, curvas cerradas y curvas en S. Las cerradas
  se anuncian con señales de flecha en el arcén; si entras demasiado rápido las ruedas
  derrapan (humo blanco y chirrido) y la fuerza centrífuga te saca hacia el exterior,
  contra las palmeras, rocas o señales. Levanta el pie o frena.
* Al elegir bifurcación, el siguiente tramo empieza con una curva hacia ese lado.
* Empiezas con 74 s. Cada checkpoint suma tiempo (*EXTENDED PLAY*).
* Al final de cada tramo la carretera se bifurca: las señales y el aviso en
  pantalla marcan la elección. Mantente a la **izquierda o a la derecha** del carril central
  antes de llegar al final; la elección se fija unos metros antes del cruce.
* Chocar con el tráfico o con los objetos del arcén (palmeras, rocas, señales…) a alta
  velocidad te hace trompear; a poca velocidad solo te frena. La arena / hierba te frena.
* La puntuación sube con la velocidad; al llegar a la meta el tiempo sobrante da bonus.

## Mapa de rutas

15 escenarios distintos en pirámide y 5 metas, cada una con su final:

```
Etapa 1:                        PLAYA
Etapa 2:                  COSTA       ALPES
Etapa 3:            CIUDAD     DESIERTO     CAMPOS
Etapa 4:       OTOÑO      CUEVAS      NIEVE      GRANJA
Etapa 5:  AUTOPISTA   CAÑÓN       LAGO      PUEBLO COSTERO   RUINAS
             (A)       (B)        (C)            (D)          (E)
```

| Meta | Final | Trofeo | Celebración |
|---|---|---|---|
| A | AUTOBAHN ACE | plata | confeti |
| B | CANYON CONQUEROR | bronce | fuegos artificiales |
| C | LAKESIDE DREAM | cristal | globos |
| D | SEASIDE PARTY | oro | estrellas |
| E | LEGEND OF THE RUIN | rubí | fuegos artificiales |

## Compilar

### Windows (recomendado)

1. Instala **Python 3** desde https://www.python.org/downloads/ (marca la casilla
   *Add python.exe to PATH*).
2. Descarga el ensamblador **AS** para Windows
   (http://john.ccac.rwth-aachen.de:8000/ftp/as/precompiled/i386-unknown-win32/aswcurr.zip)
   y descomprímelo dentro de la carpeta `tools\win\`.
3. Haz doble clic en **`build.bat`**. La primera vez instala solo `pycparser` y
   `pillow`. La ROM queda en `bin\sunsetrun.ngc`.

No hace falta gcc ni nada más: el compilador de C (`tools/c900`) y su
preprocesador están escritos en Python.

### Linux / macOS

`python3 tools/build.py` (o `./build_open.sh`), con `asl` y `p2bin` en el PATH,
en `tools/asl/` o indicados con las variables `ASL` y `P2BIN`
(https://github.com/Macroassembler-AS/asl-releases).

### Detalles

`tools/c900/` es un compilador C89 → TLCS-900/H escrito para este proyecto (sobre
`pycparser`) que genera ensamblador para el Macroassembler AS. Se validó con miles
de expresiones aleatorias comparadas contra gcc (`tools/c900/fuzz.py`), ejecutando
el motor de OVER REV (idéntico al ROM oficial fotograma a fotograma) y el driver de
sonido. El preprocesador en Python (`tools/c900/cpp.py`) produce exactamente los
mismos tokens que `gcc -E` en todos los ficheros del juego, y la ROM sale idéntica
byte a byte. El camino oficial de Toshiba (cc900, `python build.py --thome ...`)
sigue disponible si tienes ese SDK.

## Estructura

| Ruta | Contenido |
|---|---|
| `src/main.c` | Bucle de juego, estados (título, cuenta atrás, carrera, meta, resultados) |
| `src/course.c` | Mapa de rutas, bifurcaciones y buffer de tramos |
| `src/traffic.c` | Tráfico: aparición, carriles, proyección y colisiones |
| `src/theme.c` | Panorama, colores de carretera y objetos de cada tramo |
| `src/id_scenery.c` | Objetos de arcén, señales de bifurcación y banderas |
| `src/hud.c` | Marcadores (tiempo, etapa, barra de progreso, velocidad y cambio, arriba) |
| `src/game_audio.c`, `src/audio/player.c` | Música y efectos (reproductor PSG ligero) |
| `src/spr_cells_asm.asm` | Escritura de sprites en ensamblador (coche, tráfico, objetos) |
| `src/id_road*`, `src/driving.inc`, `src/core`, `src/fx`, `src/gfx` | Motor de OVER REV / NgpCraft (MIT) |
| `tools/art.py`, `tools/pano.py` | Arte original (sprites como texto, panoramas procedurales) |
| `tools/gen_gfx.py` | PNG/arte → tiles, paletas y mapas NGPC (`GraphX/`) |
| `tools/gen_course.py` | Genera los 15 tramos (curvas, cuestas, tema, tráfico) |
| `tools/gen_music.py` | Partituras originales → streams del driver de sonido |
| `tools/objart.py` | Objetos del arcén dibujados por código (palmeras, molinos, árboles, columnas, señales) |
| `media/` | GIF de juego, grabaciones de las tres canciones y una carrera con el motor |

### Personalizar

* **Tramos**: `tools/gen_course.py` (longitud, estilo de curvas por tema, tráfico).
* **Tiempos**: `START_TIME` y `extend_time[]` en `src/main.c`.
* **Gráficos**: los sprites son rejillas de texto en `tools/art.py`; los fondos se
  dibujan en `tools/pano.py`. Si prefieres dibujar PNGs, `tools/conv.py`
  (`convert_plane`) convierte cualquier imagen 256×88 a tiles con ≤8 paletas.
* **Música**: copia archivos MIDI en `music/` y compila (instrucciones en
  `music/LEEME.txt`); sin MIDIs se usan los temas escritos en `tools/gen_music.py`
  (notación sencilla: `C5/4` = do5 negra). El conversor es `tools/midi.py`.

## Estado y límites conocidos

* La lógica del juego va en tiempo real aunque la máquina no llegue a 30 imágenes por
  segundo: si un fotograma tarda más, el coche, el tráfico y el reloj se ponen al día
  (hasta 3 pasos por imagen). En un emulador lento se verá menos fluido, pero no más lento.

* Probado en emulador (Mednafen/Beetle NGP) con un piloto automático de pruebas
  (`-D AUTOPILOT=1`) que recorre las cinco etapas hasta la meta. **No probado aún en
  hardware real.**
* La carretera es más ancha que la pantalla (como en el arcade). El mapa de fondo de la
  NGPC solo mide 256 px, así que las filas cercanas se guardan tres veces (centrada y
  desplazada a cada lado) y el raster elige cuál mostrar en cada línea (`wide_rows()` en
  `src/id_road.c`, generado por `tools/gen_gfx.py`).
* La bifurcación se representa con señales y el HUD; la carretera no se divide
  visualmente en dos.
* Sin guardado de récords (el récord dura hasta apagar).

## Arte y sonido

Segunda pasada de arte y sonido, inspirada en el estilo de las recreativas de
carreras de mediados de los 80 tras estudiar su paleta, sus composiciones y su
música (tempo, tonalidades, instrumentación). No contiene gráficos, melodías ni
sonidos de ningún juego comercial: todo se genera con los scripts de `tools/`.

* Fondos: cielos pastel con degradado tramado, un banco de cúmulos sobre el mar,
  montañas con trazos verticales de luz y sombra, molinos, copas otoñales, lago con
  islotes y un pueblo antiguo al atardecer.
* Carretera de 4 carriles en gris claro; el horizonte coincide con su punto de fuga.
* Coche con la zaga de lamas y pilotos, el chico castaño a la izquierda y la chica
  rubia a la derecha; tráfico en colores vivos (morado, amarillo, rosa, verde, celeste).
* Música: tres temas chiptune de carreras (TURBO SUNSET, NEON HIGHWAY, COASTLINE RUSH),
  una fanfarria en la meta y la emisora SILENCIO. La música va más baja que el motor.
* Salida con pancarta START y público animando; meta con pancarta FINISH, público y
  trofeo en la pantalla final.
* Motor: una nota grave en el canal 3 del PSG que sube con las revoluciones y baja
  al pasar a HIGH. Pitidos de salida, campana de checkpoint y chirrido de neumáticos.

## Créditos y licencias

* Motor de carretera, física y núcleo: OVER REV engine template / NgpCraft
  (Tixul, licencia MIT, ver `LICENSE`).
* Reproductor de música propio (`src/audio/player.c`); el pequeño programa Z80 que vuelca
  los comandos al PSG procede de NGPC_sound_driver_custom (NgpCraft, MIT).
* Fuente de texto: fuente "dash" de OVER REV (MIT), con sombra añadida.
* Juego, gráficos, música, toolchain abierta: este proyecto, MIT.
* Mecánicas inspiradas en OutRun (SEGA, 1986). Referencias de jugabilidad
  consultadas en Cannonball (djyt); no se ha copiado su código ni datos.

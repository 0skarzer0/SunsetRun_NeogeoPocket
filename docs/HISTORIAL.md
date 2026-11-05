# Historial del proyecto

Lo que pidió el usuario, en orden, con las decisiones tomadas. Las citas son
literales. Los commits llevan el mismo orden: `git log --reverse`.

## Fase 0 — base (commit `base`, hasta el 16-oct-2026)

* **Punto de partida:** la plantilla del motor OVER REV (Tixul/NgpCraft, MIT).
  Encima se construyó un juego al estilo OutRun, con nombre propio (SUNSET RUN).
* **Condición del usuario:** "La marca SEGA no la copies… el juego es para uso
  personal, nunca lo voy a vender, y código fuente será libre y abierto". Nos pasó
  material de OutRun (capturas, MIDIs) **solo como referencia**. Jugabilidad
  consultada en Cannonball (djyt), sin copiar ni código ni datos.
* **Contenido de esta fase:**
  * Contrarreloj con checkpoints y cinco etapas en pirámide (15 tramos, 5 metas
    A–E con su final, trofeo y celebración).
  * Bifurcaciones con señales y aviso; el tramo siguiente empieza girando hacia el
    lado elegido.
  * Cambio LOW/HIGH, como el arcade. Curvas suaves, cerradas (con señales de flecha)
    y en S; derrape con humo y fuerza centrífuga.
  * Tráfico de colores. Arte por código: sprites como texto en `tools/art.py`,
    panoramas procedurales en `tools/pano.py`, objetos en `tools/objart.py`.
  * 15 paisajes: playa, costa, alpes, ciudad, desierto, campos, otoño, cuevas,
    nieve, granja, autopista, cañón, lago, pueblo costero y ruinas.
  * HUD arriba (tiempo, etapa, barra de progreso, velocidad, marcha).
  * Reproductor de música propio y ligero (`src/audio/player.c`).
  * Toolchain abierta: el compilador `tools/c900` (C89 → TLCS-900/H, en Python con
    pycparser) y el Macroassembler AS.
  * Varios ajustes de jugabilidad a petición del usuario.

## Fase 1 — modos y título (commit `5e3076a`, 16-oct)

El usuario pidió:

* **Dificultad:**
  * "me parece bien el nivel normal que propones".
  * HARD: "pero que los choques no te paren más tiempo".
  * FREE: "con reloj calculado en modo de dificultad Normal, variando el orden de
    los paisajes, mostrando semilla".
* **Controles del título:** "arriba y abajo la dificultad e izquierda derecha la radio".
* **Récords:** "Si, record por dificultad".
* **Pancartas START/FINISH:** verde con letras blancas en EASY, blanca con letras
  rojas en NORMAL, roja con letras blancas en HARD, azul con letras blancas en FREE.
* **Pantalla de título:** sin carretera ni coche, azul, con un gráfico como el de su
  dibujo: emblema ovalado, puesta de sol, palmera y el coche del juego.
* **Nubes de la playa:** con más detalle y separadas.

Se hizo:

* **Tiempos:** `stage_time` EASY = 74 s de salida, luego +58/+56/+54/+52.
  NORMAL/HARD = 71, luego +55/+53/+51/+49.
* **HARD:** +2 coches, más lentos, cambian más de carril.
* **FREE:**
  * Generador en C (`course.c`) que es un port exacto de `make_leg` de
    `gen_course.py`, con xorshift16.
  * Ojo: el orden de los sorteos aleatorios tiene que ser explícito, porque C no
    fija el orden de evaluación de los argumentos. Ya dio un fallo por eso.
  * Los temas se barajan con la semilla; B en el título da una semilla nueva.
  * El reloj sale de lo que cuesta conducir el tramo, entre 35 y 90 s.
* **Guardado flash** (diario de dos bancos de NgpCraft): los récords de los 4 modos,
  la emisora, el modo y la semilla. Solo se escribe al cambiar de pantalla.

## Fase 2 — puentes, vuelco, mapa (commit `357ab94`, 17-oct)

El usuario: "1.- puentes de piedra… 2.- animación de volcar… 3.- minimapa con un
cochecito rojo… 4.- el pico de la montaña se separa… una única capa… la parte de
arriba, donde están los marcadores, color fijo".

Se hizo:

* **Puentes:** caracteres SCR1 en perspectiva (`src/bridge.c`). Sus pilares se pueden
  chocar, y los sprites que hay más allá del puente pasan por detrás (`SPR_MIDDLE`).
* **Vuelco:** fotogramas generados girando la vista trasera del coche.
* **Mapa del recorrido** al acabar (`tools/gen_map.py`), con miniaturas de cada
  paisaje y un coche rojo que recorre la ruta.
* **Panorama:** una sola capa, con una franja de cielo liso detrás del HUD.

## Fase 3 — choques con tráfico (commits `9054c60`, `8b847b7`, 17-oct)

El usuario:

* "el vuelco… solo debe ocurrir cuando te choques con los obstáculos del arcén,
  cuando te choques con otros coches solo te desplazan… y te hacen perder velocidad".
* "vuelco hacia adelante viendo la parte inferior del coche y las ruedas… a más
  velocidad aún".
* Luego: "desde unos 220 km/h el vuelco de lado… desde unos 280 km/h el de la
  vuelta para adelante".
* "Cuando te choques con los coches, que si vas más rápido te desplace más… se vea
  el humo del derrape, que suene el derrape un poco después del golpe, y que el
  coche culee un poco".
* Cuevas: no le gustaron dos versiones; "haz mejor montañas rocosas escarpadas".
* Playa: "en vez de 4 grandes, haz 2 grandotas".

Se hizo:

* **Vuelcos** (`main.c`): de lado con `ROLL_SPEED` 168 (≈220 km/h) y hacia delante
  con `FLIP_SPEED` 214 (≈280 km/h). La gravedad se mide con la velocidad al salir
  del asfalto (`verge_spd`).
* **Golpe con tráfico:**
  * Desplazamiento lateral de `push = (speed*15>>4)+6`, que se reduce ×7/8 cada paso.
  * Te quedas con 7/16 de la velocidad.
  * Dura `KNOCK_TICKS` 26, y el derrape suena en `KNOCK_SKID_AT` 5.
  * Humo, y el coche culea (inclinación ±1 y vaivén de ±2 px).
* **Paneles:** los panoramas pasan a 13 paletas.

## Fase 4 — público, globos, puentes largos (commit `1ac1ef4`, 17-oct)

El usuario: "globitos… que los suelten al aire la gente que está animando en la
salida, y ponles variedad de colores a su ropa"; choques que "reduzca un poco más tu
velocidad… y que te desplace más aún"; "Los puentes de piedra quiero que duren más
tiempo: un rato con la carretera recta, luego una bajada, luego una subida y por
último una curva".

Se hizo:

* **Globos:** 8 sprites, con las paletas del tráfico.
* **Público:** con ropa de colores, que va rotando entre paletas.
* **Tramo de puentes:** `BRIDGE_RUN = [(1010,0,0),(610,0,-3),(620,0,3),(730,26,0)]`,
  unos 10 s a tope, en los temas campos, otoño, granja, lago y ruinas. Lo marca el
  span 1010 (`LEG_BRIDGE_MARK`).

## Fase 5 — música (commits `8b847b7`, `1ac1ef4`, `fa34fd8`)

Intentos, todos descartados por el usuario:

1. Canciones originales de 3 minutos o más: "no me acaban de convencer".
2. Clásicos de dominio público.
3. Scott Joplin (The Entertainer, Maple Leaf, Pine Apple, Peacherine; Solace para el
   fin de partida), arreglados desde partituras de Mutopia con un lector de LilyPond
   propio.

El usuario preguntó qué formato preferíamos (mp3, wav, mid…). Se le dijo **MIDI**, y
mandó 4 MIDIs de Camela (zarpa, Corazón, enamorado, háblale). Se explicó que tienen
copyright y no se incluyen en lo que se entrega ni en el repositorio; él puede
usarlos en su copia privada.

Además: los puentes lejanos son más delgados y engordan al acercarse (tiles finos
de 3 y 5 px).

## Fase 6 — Windows (commit `a0051cb`, 18-oct)

El usuario: "The assembler (asl and p2bin) was not found… La compilación ha fallado".

Arreglo: `tools/build.py` acepta `asw.exe` (así se llama AS en Windows), y
`build.bat` descarga `aswcurr.zip` con PowerShell la primera vez.

## Fase 7 — optimización máxima (commits `5110904`, `b3c2c6a`, 18-oct)

El usuario: "definitivamente voy a usar mis propios midis. optimiza el src al
máximo… quita todo lo innecesario. optimiza el juego al máximo para arañar todos los
frames posibles, aunque tenga que bajar la calidad de la música. quiero máxima
fluidez y mínimos parpadeos."

Se hizo (detalle técnico en `ARQUITECTURA.md`):

* **Imagen completa en VBlank:**
  * Copia en RAM de los sprites.
  * Capa `ovl.c` para puentes y pancartas, que solo escribe las celdas cambiadas.
  * Tabla de raster publicada a la vez.
  * Fase fija de dos VBlanks por imagen.
* **Choques:** el coche ya no parpadea.
* **Ensamblador:** pasan a asm `wide_rows` (de 5 % a 1,4 %) e `id_spr_hide_range`.
  La escena se dibuja sin módulos ni productos, y la envolvente de la música sin
  divisiones.
* **Fuera:**
  * Joplin, LilyPond, `media/` (mp3 y gif), cc900/`ngpc.lcf` y la cola de VRAM.
  * Las herramientas `fuzz` y `unit`, `gfx_logo` y el runtime de cc900.
* **Radio:**
  * Solo los MIDI del usuario, con SILENCIO al final.
  * Jingles GOAL/OVER originales que se pueden sustituir con `goal*.mid` y `over*.mid`.
* **No hizo falta bajar la calidad de la música:** el reproductor gasta ~1 % de CPU.
* **Resultado:**
  * En carrera la CPU pasa del 39 % al 48 % de tiempo ocioso.
  * 30 fps estables hasta CPUSLOW=10 (+62 %).

## Fase 8 — GitHub (5-nov-2026)

El usuario pidió subirlo todo a https://github.com/0skarzer0/SunsetRun_NeogeoPocket
"de forma muy detallada, de tal forma que si abro una nueva sesión que acuerdes de
todo". Se subieron:

* `CLAUDE.md`, que una sesión nueva carga sola, y estos documentos.
* El emulador de pruebas (`tools/test/`) con su parche y los guiones.
* El historial completo de git.

También preguntó si se acepta música en **VGM/VGZ**; respuesta y plan en
`CLAUDE.md` → Pendiente.

/* Minimal headless libretro frontend: run a ROM with scripted input, dump frames.
   usage: run core.so rom.ngc frames script outprefix
   script: lines "start end buttons" where buttons letters: A B L R U D O(option)
   dumps frame N as PPM if listed in lines "shot N" */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>
#include <stdint.h>
#include <stdbool.h>
#include "libretro.h"

static unsigned fmt = RETRO_PIXEL_FORMAT_0RGB1555;
static int cur_frame;
static char held[65536][16];
static int shots[4096], nshots;
static const char *prefix;
static int want_shot;

static bool env(unsigned cmd, void *data) {
    switch (cmd) {
    case RETRO_ENVIRONMENT_SET_PIXEL_FORMAT: fmt = *(unsigned *)data; return true;
    case RETRO_ENVIRONMENT_GET_SYSTEM_DIRECTORY:
    case RETRO_ENVIRONMENT_GET_SAVE_DIRECTORY: *(const char **)data = "."; return true;
    case RETRO_ENVIRONMENT_GET_CAN_DUPE: *(bool *)data = true; return true;
    case RETRO_ENVIRONMENT_GET_VARIABLE: return false;
    case RETRO_ENVIRONMENT_GET_LOG_INTERFACE: return false;
    default: return false;
    }
}
static void video(const void *d, unsigned w, unsigned h, size_t pitch) {
    char name[512]; FILE *f; unsigned x, y;
    if (!want_shot || !d) return;
    snprintf(name, sizeof name, "%s%05d.ppm", prefix, cur_frame);
    f = fopen(name, "wb"); fprintf(f, "P6 %u %u 255\n", w, h);
    for (y = 0; y < h; y++) for (x = 0; x < w; x++) {
        unsigned char rgb[3];
        if (fmt == RETRO_PIXEL_FORMAT_XRGB8888) {
            uint32_t p = ((const uint32_t *)((const char *)d + y * pitch))[x];
            rgb[0] = p >> 16; rgb[1] = p >> 8; rgb[2] = p;
        } else {
            uint16_t p = ((const uint16_t *)((const char *)d + y * pitch))[x];
            if (fmt == RETRO_PIXEL_FORMAT_RGB565) { rgb[0] = (p >> 11) << 3; rgb[1] = ((p >> 5) & 63) << 2; rgb[2] = (p & 31) << 3; }
            else { rgb[0] = ((p >> 10) & 31) << 3; rgb[1] = ((p >> 5) & 31) << 3; rgb[2] = (p & 31) << 3; }
        }
        fwrite(rgb, 1, 3, f);
    }
    fclose(f);
}
static void audio(int16_t l, int16_t r) { (void)l; (void)r; }
static FILE *wav;
static size_t audiob(const int16_t *d, size_t n) { if (wav) fwrite(d, 4, n, wav); return n; }
static void poll(void) {}
static int16_t input(unsigned port, unsigned dev, unsigned idx, unsigned id) {
    const char *h = held[cur_frame < 65536 ? cur_frame : 65535];
    (void)dev; (void)idx;
    if (port) return 0;
    if (id == RETRO_DEVICE_ID_JOYPAD_MASK) {
        int m = 0;
        if (strchr(h, 'A')) m |= 1 << RETRO_DEVICE_ID_JOYPAD_B;
        if (strchr(h, 'B')) m |= 1 << RETRO_DEVICE_ID_JOYPAD_A;
        if (strchr(h, 'L')) m |= 1 << RETRO_DEVICE_ID_JOYPAD_LEFT;
        if (strchr(h, 'R')) m |= 1 << RETRO_DEVICE_ID_JOYPAD_RIGHT;
        if (strchr(h, 'U')) m |= 1 << RETRO_DEVICE_ID_JOYPAD_UP;
        if (strchr(h, 'D')) m |= 1 << RETRO_DEVICE_ID_JOYPAD_DOWN;
        if (strchr(h, 'O')) m |= 1 << RETRO_DEVICE_ID_JOYPAD_START;
        return m;
    }
    switch (id) {
    case RETRO_DEVICE_ID_JOYPAD_B: return strchr(h, 'A') != 0;
    case RETRO_DEVICE_ID_JOYPAD_A: return strchr(h, 'B') != 0;
    case RETRO_DEVICE_ID_JOYPAD_LEFT: return strchr(h, 'L') != 0;
    case RETRO_DEVICE_ID_JOYPAD_RIGHT: return strchr(h, 'R') != 0;
    case RETRO_DEVICE_ID_JOYPAD_UP: return strchr(h, 'U') != 0;
    case RETRO_DEVICE_ID_JOYPAD_DOWN: return strchr(h, 'D') != 0;
    case RETRO_DEVICE_ID_JOYPAD_START: return strchr(h, 'O') != 0;
    }
    return 0;
}
#define SYM(n) n = dlsym(lib, #n)
int main(int argc, char **argv) {
    void *lib; FILE *sf; char line[256]; int frames, i;
    void (*retro_set_environment)(retro_environment_t);
    void (*retro_set_video_refresh)(retro_video_refresh_t);
    void (*retro_set_audio_sample)(retro_audio_sample_t);
    void (*retro_set_audio_sample_batch)(retro_audio_sample_batch_t);
    void (*retro_set_input_poll)(retro_input_poll_t);
    void (*retro_set_input_state)(retro_input_state_t);
    void (*retro_init)(void); bool (*retro_load_game)(const struct retro_game_info *);
    void (*retro_run)(void);
    struct retro_game_info gi; FILE *rf; long sz; void *buf;
    if (argc < 6) return 1;
    lib = dlopen(argv[1], RTLD_NOW); if (!lib) { puts(dlerror()); return 1; }
    SYM(retro_set_environment); SYM(retro_set_video_refresh); SYM(retro_set_audio_sample);
    SYM(retro_set_audio_sample_batch); SYM(retro_set_input_poll); SYM(retro_set_input_state);
    SYM(retro_init); SYM(retro_load_game); SYM(retro_run);
    frames = atoi(argv[3]); prefix = argv[5];
    sf = fopen(argv[4], "r");
    while (sf && fgets(line, sizeof line, sf)) {
        int a, b; char btn[16] = "";
        if (sscanf(line, "shot %d %d %d", &a, &b, &i) == 3) { int k; for (k = a; k <= b; k += i) shots[nshots++] = k; continue; }
        if (sscanf(line, "shot %d", &a) == 1) { shots[nshots++] = a; continue; }
        if (sscanf(line, "%d %d %15s", &a, &b, btn) == 3) { int k; for (k = a; k <= b && k < 65536; k++) strcat(held[k], btn); }
    }
    retro_set_environment(env); retro_set_video_refresh(video); retro_set_audio_sample(audio);
    retro_set_audio_sample_batch(audiob); retro_set_input_poll(poll); retro_set_input_state(input);
    retro_init();
    if (getenv("WAVOUT")) wav = fopen(getenv("WAVOUT"), "wb");
    rf = fopen(argv[2], "rb"); fseek(rf, 0, SEEK_END); sz = ftell(rf); rewind(rf);
    buf = malloc(sz); fread(buf, 1, sz, rf); fclose(rf);
    memset(&gi, 0, sizeof gi); gi.path = argv[2]; gi.data = buf; gi.size = sz;
    if (!retro_load_game(&gi)) { puts("load failed"); return 1; }
    for (cur_frame = 0; cur_frame < frames; cur_frame++) {
        int k; want_shot = 0;
        for (k = 0; k < nshots; k++) if (shots[k] == cur_frame) want_shot = 1;
        if (getenv("PROFFROM") && cur_frame == atoi(getenv("PROFFROM"))) { void (*prof_reset)(void); SYM(prof_reset); if (prof_reset) prof_reset(); }
        retro_run();
    }
    { void *(*retro_get_memory_data)(unsigned); size_t (*retro_get_memory_size)(unsigned);
      const char *rd = getenv("RAMDUMP");
      SYM(retro_get_memory_data); SYM(retro_get_memory_size);
      if (rd && retro_get_memory_data) { FILE *o = fopen(rd, "wb");
        fwrite(retro_get_memory_data(RETRO_MEMORY_SYSTEM_RAM), 1, retro_get_memory_size(RETRO_MEMORY_SYSTEM_RAM), o); fclose(o); } }
    if (wav) fclose(wav);
    if (getenv("PROF")) { void (*prof_dump)(const char *); SYM(prof_dump); if (prof_dump) prof_dump(getenv("PROF")); }
    if (getenv("UNLOAD")) { void (*retro_unload_game)(void); SYM(retro_unload_game); retro_unload_game(); }
    return 0;
}

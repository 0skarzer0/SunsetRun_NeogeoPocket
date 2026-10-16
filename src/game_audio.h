#ifndef GAME_AUDIO_H
#define GAME_AUDIO_H
#include "ngpc_types.h"
#define SFX_BEEP        0u
#define SFX_GO          1u
#define SFX_CHECKPOINT  2u
#define SFX_CRASH       3u
#define SFX_BUMP        4u
#define SFX_TICK        5u
#define SFX_SELECT      6u
#define SFX_SKID        7u
void audio_init(void);
void audio_update(void);
void music_play(u8 song);
void music_stop(void);
void music_fade(void);
u8 music_current(void);
void sfx(u8 id);
#endif

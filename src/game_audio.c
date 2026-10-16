/* SUNSET RUN - music and sound effects (lean player, see audio/player.c). */
#include "ngpc_types.h"
#include "audio/player.h"
#include "game_audio.h"

static u8 cur_song = 255u;

void audio_init(void)
{
    player_init();
}

void audio_update(void)
{
    player_update();
}

void music_play(u8 song)
{
    const MusicSong *s;
    if (song >= MUSIC_COUNT) {
        music_stop();
        return;
    }
    s = &music_songs[song];
    cur_song = song;
    player_start(s->v0, s->v1, s->v2, s->vn);
}

void music_stop(void)
{
    player_stop();
    cur_song = 255u;
}

void music_fade(void)
{
    player_stop();
}

u8 music_current(void)
{
    return cur_song;
}

/* dividers: f = 3072000 / (32 * div) */
void sfx(u8 id)
{
    switch (id) {
    case SFX_BEEP:        /* countdown: short ~980 Hz signal */
        player_sfx_tone(1u, 98u, 0, 1u, 12u, 0u);
        break;
    case SFX_GO:          /* start: one octave up, held */
        player_sfx_tone(1u, 49u, 0, 0u, 45u, 6u);
        break;
    case SFX_CHECKPOINT:  /* bell: bright ding with a long ring */
        player_sfx_tone(1u, 98u, 0, 0u, 70u, 5u);
        player_sfx_tone(2u, 65u, 0, 3u, 50u, 4u);
        break;
    case SFX_CRASH:       /* white noise, long decay */
        player_sfx_noise(5u, 0u, 60u, 4u);
        break;
    case SFX_BUMP:
        player_sfx_noise(6u, 2u, 10u, 1u);
        break;
    case SFX_TICK:
        player_sfx_tone(1u, 140u, 0, 3u, 5u, 0u);
        break;
    case SFX_SKID:        /* tyre squeal, ~1 kHz warbling */
        player_sfx_tone(2u, 90u, 2, 2u, 8u, 0u);
        break;
    case SFX_SELECT:
        player_sfx_tone(1u, 160u, 0, 2u, 6u, 1u);
        break;
    default:
        break;
    }
}

#ifndef PLAYER_H
#define PLAYER_H
#include "ngpc_types.h"
#include "music_data.h"
void player_init(void);
void player_start(const u8 *v0, const u8 *v1, const u8 *v2, const u8 *vn);
void player_stop(void);
void player_update(void);
u16  note_div(u8 note);
void player_sfx_tone(u8 ch, u16 div, s8 step, u8 attn, u8 frames, u8 decay);
void player_sfx_noise(u8 ctrl, u8 attn, u8 frames, u8 decay);
void player_engine(u16 div, u8 attn);   /* engine drone on tone channel 2 */
void player_engine_off(void);
#endif

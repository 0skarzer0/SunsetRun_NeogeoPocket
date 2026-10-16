	cpu 96c141
	maxmode on
	supmode on
	relaxed on
	page 0
	org 200000h
_Licensed:
	db 32,76,73,67,69,78,83,69,68,32,66,89,32,83,78,75
	db 32,67,79,82,80,79,82,65,84,73,79,78
_EntryPoint:
	dd _main
_CartID:
	db 0,0
_CartSystem:
	db 0,16
_CartTitle:
	db 83,85,78,83,69,84,32,82,85,78,32,32
_CartReserved:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	align 2

; function bend_blended
_bend_blended__0:
	push xiz
	lda xsp,(xsp-10)
	ld a,(xsp+18)
	ld ixl,a
	ld iy,(xsp+22)
	ld xwa,(_track_seg)
	ld c,ixl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld wa,(xwa+2)
	ld (xsp+0),wa
	ld xwa,(_track_seg)
	ld c,ixl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld wa,(xwa)
	sub wa,iy
	ld (xsp+2),wa
	ld wa,(xsp+2)
	cp wa,iy
	jr ugt,L10
	ld wa,(xsp+2)
	cp wa,128
	jr uge,L10
	ld a,ixl
	add a,1
	ld izl,a
	ld a,izl
	cp a,(_track_len)
	jr ult,L11
	ld izl,0
L11:
	ld wa,128
	sub wa,(xsp+2)
	ld (xsp+8),wa
	jr L12
L10:
	ld wa,iy
	cp wa,128
	jr uge,L13
	ld c,ixl
	cp c,0
	jr z,L14
	ld a,ixl
	extz wa
	sub wa,1
	jr L15
L14:
	ld a,(_track_len)
	sub a,1
	extz wa
L15:
	ld izl,a
	ld wa,128
	sub wa,iy
	ld (xsp+8),wa
	jr L16
L13:
	ld wa,(xsp+0)
	jr L9
L16:
L12:
	ld xwa,(_track_seg)
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld wa,(xwa+2)
	sub wa,(xsp+0)
	ld (xsp+6),wa
	ld wa,(xsp+0)
	ld bc,(xsp+6)
	ld de,(xsp+8)
	mul xbc,de
	sra 8,bc
	add wa,bc
	jr L9
L9:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function slope_blended
_slope_blended__0:
	push xiz
	lda xsp,(xsp-10)
	ld a,(xsp+18)
	ld iyl,a
	ld xwa,(_track_seg)
	ld c,iyl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld a,(xwa+4)
	exts wa
	ld ix,wa
	ld xwa,(_track_seg)
	ld c,iyl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld wa,(xwa)
	sub wa,(xsp+22)
	ld (xsp+2),wa
	ld wa,(xsp+2)
	cp wa,(xsp+22)
	jr ugt,L26
	ld wa,(xsp+2)
	cp wa,128
	jr uge,L26
	ld a,iyl
	add a,1
	ld izl,a
	ld a,izl
	cp a,(_track_len)
	jr ult,L27
	ld izl,0
L27:
	ld wa,128
	sub wa,(xsp+2)
	ld (xsp+8),wa
	jr L28
L26:
	ld wa,(xsp+22)
	cp wa,128
	jr uge,L29
	ld c,iyl
	cp c,0
	jr z,L30
	ld a,iyl
	extz wa
	sub wa,1
	jr L31
L30:
	ld a,(_track_len)
	sub a,1
	extz wa
L31:
	ld izl,a
	ld wa,128
	sub wa,(xsp+22)
	ld (xsp+8),wa
	jr L32
L29:
	ld a,ixl
	jr L25
L32:
L28:
	ld xwa,(_track_seg)
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld a,(xwa+4)
	exts wa
	sub wa,ix
	ld (xsp+6),wa
	ld wa,ix
	ld bc,(xsp+6)
	ld de,(xsp+8)
	mul xbc,de
	sra 8,bc
	add wa,bc
	jr L25
L25:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function recover_stranded
_recover_stranded__0:
	push xiz
	lda xsp,(xsp-6)
	ld bc,(_car_lat__0)
	cp bc,0
	jr ge,L48
	ld wa,(_car_lat__0)
	neg wa
	jr L49
L48:
	ld wa,(_car_lat__0)
L49:
	ld (xsp+0),wa
	ld bc,(_recovery_lat__0)
	cp bc,0
	jr ge,L50
	ld wa,(_recovery_lat__0)
	neg wa
	jr L51
L50:
	ld wa,(_recovery_lat__0)
L51:
	ld (xsp+2),wa
	ld a,(_g_vb_counter)
	ld izl,a
	ld a,(_racing__0)
	cp a,0
	jr z,L53
	ld a,(_finished__0)
	cp a,0
	jr nz,L53
	ld a,(_offroad__0)
	cp a,0
	jr z,L53
	ld a,(_speed__0)
	cp a,8
	jr ugt,L53
	ld wa,(xsp+0)
	ld bc,(xsp+14)
	add bc,80
	cp wa,bc
	jr gt,L52
L53:
	ldw (_recovery_frames__0),0
	jp L47
L52:
	ld wa,(_recovery_frames__0)
	cp wa,0
	jr z,L55
	ld bc,(_car_lat__0)
	cp bc,0
	jr ge,L56
	ld wa,1
	jr L57
L56:
	ld wa,0
L57:
	ld de,(_recovery_lat__0)
	cp de,0
	jr ge,L58
	ld bc,1
	jr L59
L58:
	ld bc,0
L59:
	cp wa,bc
	jr nz,L55
	ld wa,(xsp+0)
	add wa,32
	cp wa,(xsp+2)
	jr gt,L54
L55:
	ldw (_recovery_frames__0),1
	ld wa,(_car_lat__0)
	ld (_recovery_lat__0),wa
	ld a,izl
	ld (_recovery_vblank__0),a
	jr L47
L54:
	ld wa,(_recovery_frames__0)
	ld c,izl
	sub c,(_recovery_vblank__0)
	extz bc
	add wa,bc
	ld (_recovery_frames__0),wa
	ld a,izl
	ld (_recovery_vblank__0),a
	ld wa,(_recovery_frames__0)
	cp wa,180
	jr uge,L60
	jr L47
L60:
	ldw (_car_lat__0),0
	ldb (_speed__0),0
	ldw (_speed_acc__0),0
	ldw (_hill_acc__0),0
	ldb (_gear__0),0
	ldb (_slip__0),0
	ldb (_car_lean__0),0
	ldb (_steer_hold__0),0
	ldb (_offroad__0),0
	ldw (_recovery_frames__0),0
L47:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function drive
_drive__0:
	push xiz
	lda xsp,(xsp-16)
	ld xwa,_car_tuned__0
	ld (xsp+6),xwa
	ld xwa,(xsp+6)
	ld a,(xwa+9)
	ld (xsp+10),a
	ld a,(_oil_hold__0)
	cp a,0
	jr z,L145
	ld a,(xsp+10)
	extz wa
	ld c,(xsp+10)
	extz bc
	sra 2,bc
	extz bc
	sub wa,bc
	ld (xsp+10),a
	ld a,(xsp+10)
	cp a,0
	jr nz,L146
	ldb (xsp+10),1
L146:
L145:
	ld c,(_ngpc_pad_held)
	extz bc
	and bc,16
	cp bc,0
	jr z,L147
	ld wa,1
	jr L148
L147:
	ld wa,0
L148:
	ld (_on_throttle__0),a
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,12
	cp wa,0
	jr nz,L150
	ld a,(_ngpc_pad_held)
	extz wa
	and wa,12
	cp wa,0
	jr nz,L149
L150:
	ldb (_steer_hold__0),0
	jr L151
L149:
	ld a,(_steer_hold__0)
	cp a,255
	jr uge,L152
	incb 1,(_steer_hold__0)
L152:
L151:
	ld wa,(_seg_pos__0)
	push xwa
	ld a,(_seg_index__0)
	push xwa
	call _slope_blended__0
	lda xsp,(xsp+8)
	ld (xsp+3),a
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,1
	cp wa,0
	jr z,L153
	ldb (_gear__0),0
	jr L154
L153:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,2
	cp wa,0
	jr z,L155
	ldb (_gear__0),1
L155:
L154:
	ld c,(_gear__0)
	cp c,0
	jr nz,L156
	ld wa,137
	jr L157
L156:
	ld wa,224
L157:
	ld c,(xsp+3)
	exts bc
	mul xbc,3
	sub wa,bc
	ld (xsp+12),wa
	ld wa,(xsp+12)
	cp wa,240
	jr le,L158
	ldw (xsp+12),240
	jr L159
L158:
	ld wa,(xsp+12)
	cp wa,40
	jr ge,L160
	ldw (xsp+12),40
L160:
L159:
	ld a,(xsp+12)
	ld (xsp+2),a
	ld a,(_ngpc_pad_held)
	extz wa
	and wa,16
	cp wa,0
	jp z,L161
	ld a,(_speed__0)
	cp a,(xsp+2)
	jr ule,L162
	ld c,(_speed__0)
	extz bc
	ld e,(xsp+2)
	extz de
	sub bc,de
	cp bc,2
	jr ule,L163
	ld a,(_speed__0)
	extz wa
	sub wa,2
	jr L164
L163:
	ld a,(xsp+2)
	extz wa
L164:
	ld (_speed__0),a
	jp L165
L162:
	ld a,(_gear__0)
	cp a,0
	jr nz,L166
	ld c,(_speed__0)
	cp c,100
	jr uge,L167
	ld wa,340
	jr L168
L167:
	ld wa,230
L168:
	ld (xsp+12),wa
	jr L169
L166:
	ld a,(_speed__0)
	cp a,137
	jr uge,L170
	ldw (xsp+12),90
	jr L171
L170:
	ld wa,40
	ld bc,224
	ld e,(_speed__0)
	extz de
	sub bc,de
	mul xbc,100
	srl 6,bc
	add wa,bc
	ld (xsp+12),wa
L171:
L169:
	ld wa,(_speed_acc__0)
	add wa,(xsp+12)
	ld (_speed_acc__0),wa
	ld wa,(_speed_acc__0)
	cp wa,256
	jr ult,L172
	ld wa,(_speed_acc__0)
	srl 8,wa
	ld (xsp+14),a
	ld wa,(_speed_acc__0)
	and wa,255
	ld (_speed_acc__0),wa
	ld a,(_speed__0)
	ld c,(xsp+2)
	sub c,(xsp+14)
	cp a,c
	jr ugt,L173
	ld a,(_speed__0)
	add a,(xsp+14)
	ld (_speed__0),a
	jr L174
L173:
	ld a,(xsp+2)
	ld (_speed__0),a
L174:
L172:
L165:
	jr L175
L161:
	ld a,(_ngpc_pad_held)
	extz wa
	and wa,32
	cp wa,0
	jr z,L176
	ld c,(_speed__0)
	ld xde,(xsp+6)
	ld e,(xde+7)
	cp c,e
	jr ule,L177
	ld a,(_speed__0)
	ld xbc,(xsp+6)
	ld c,(xbc+7)
	sub a,c
	extz wa
	jr L178
L177:
	ld wa,0
L178:
	ld (_speed__0),a
	jr L179
L176:
	ld a,(_speed__0)
	cp a,1
	jr ule,L180
	ld a,(_speed__0)
	sub a,1
	ld (_speed__0),a
	jr L181
L180:
	ldb (_speed__0),0
L181:
L179:
L175:
	ld wa,(_hill_acc__0)
	ld c,(xsp+3)
	exts bc
	mul xbc,6
	sub wa,bc
	ld (_hill_acc__0),wa
	jr L184
L182:
	ld wa,(_hill_acc__0)
	sub wa,256
	ld (_hill_acc__0),wa
	ld a,(_speed__0)
	extz wa
	cp wa,240
	jr ge,L185
	ld a,(_speed__0)
	cp a,255
	jr uge,L185
	incb 1,(_speed__0)
L185:
L184:
	ld wa,(_hill_acc__0)
	cp wa,256
	jr ge,L182
L183:
	jr L188
L186:
	ld wa,(_hill_acc__0)
	add wa,256
	ld (_hill_acc__0),wa
	ld a,(_speed__0)
	cp a,0
	jr ule,L189
	decb 1,(_speed__0)
L189:
L188:
	ld wa,(_hill_acc__0)
	cp wa,65280
	jr le,L186
L187:
	ld a,(_speed__0)
	extz wa
	sra 4,wa
	ld (xsp+4),a
	ld wa,(_bend_now__0)
	ld c,(xsp+4)
	extz bc
	mul xwa,bc
	ld c,(xsp+4)
	extz bc
	mul xwa,bc
	exts xwa
	ld c,(xsp+10)
	extz bc
	divs xwa,bc
	ld (xsp+0),wa
	ld wa,(xsp+0)
	add wa,(xsp+0)
	ld (xsp+0),wa
	ld bc,(xsp+0)
	cp bc,0
	jr ge,L190
	ld wa,(xsp+0)
	neg wa
	jr L191
L190:
	ld wa,(xsp+0)
L191:
	ld (xsp+12),wa
	ld bc,(xsp+12)
	cp bc,85
	jr lt,L192
	ld c,(_speed__0)
	cp c,100
	jr ult,L192
	ld c,(_offroad__0)
	cp c,0
	jr nz,L192
	ld wa,1
	jr L193
L192:
	ld wa,0
L193:
	ld (_skid__0),a
	ld a,(_skid__0)
	cp a,0
	jr z,L194
	incb 1,(_skid_t__0)
	ld a,(_skid_t__0)
	extz wa
	and wa,3
	cp wa,0
	jr nz,L195
	ld a,(_speed__0)
	cp a,0
	jr ule,L195
	decb 1,(_speed__0)
L195:
	jr L196
L194:
	ldb (_skid_t__0),0
L196:
	ld xwa,(xsp+6)
	ld a,(xwa+8)
	push xwa
	ld a,(_speed__0)
	push xwa
	call _id_cars_steering
	lda xsp,(xsp+8)
	extz wa
	ld iz,wa
	ld wa,iz
	ld bc,iz
	sra 1,bc
	add wa,bc
	ld bc,iz
	sra 2,bc
	add wa,bc
	ld iz,wa
	ld a,(_oil_hold__0)
	cp a,0
	jr z,L197
	ld wa,iz
	ld bc,iz
	sra 3,bc
	sub wa,bc
	ld iz,wa
L197:
	ld a,(_offroad__0)
	cp a,0
	jr z,L198
	ld wa,iz
	ld bc,iz
	sra 2,bc
	sub wa,bc
	ld iz,wa
L198:
	ld a,(_skid__0)
	cp a,0
	jr z,L199
	ld wa,iz
	ld bc,iz
	sra 3,bc
	sub wa,bc
	ld iz,wa
L199:
	ld a,(_ngpc_pad_held)
	extz wa
	and wa,4
	cp wa,0
	jr z,L200
	ld wa,(_car_lat__0)
	sub wa,iz
	ld (_car_lat__0),wa
	jr L201
L200:
	ld a,(_ngpc_pad_held)
	extz wa
	and wa,8
	cp wa,0
	jr z,L202
	ld wa,(_car_lat__0)
	add wa,iz
	ld (_car_lat__0),wa
	jr L203
L202:
	call _id_car_lean_share
	ld (xsp+14),a
	ld a,(xsp+14)
	cp a,0
	jr z,L204
	ld wa,(_car_lat__0)
	ld bc,iz
	ld e,(xsp+14)
	exts de
	mul xbc,de
	sra 4,bc
	add wa,bc
	ld (_car_lat__0),wa
L204:
L203:
L201:
	ld wa,(_car_lat__0)
	add wa,(xsp+0)
	ld (_car_lat__0),wa
	ld wa,(_heading_acc__0)
	ld bc,(_bend_now__0)
	ld e,(_speed__0)
	extz de
	sra 4,de
	mul xbc,de
	sra 7,bc
	add wa,bc
	ld (_heading_acc__0),wa
	ld a,(_ngpc_pad_held)
	extz wa
	and wa,4
	cp wa,0
	jr z,L205
	ldb (_car_lean__0),255
	jr L206
L205:
	ld a,(_ngpc_pad_held)
	extz wa
	and wa,8
	cp wa,0
	jr z,L207
	ldb (_car_lean__0),1
	jr L208
L207:
	ldb (_car_lean__0),0
L208:
L206:
	ld a,(_offroad__0)
	ld (xsp+11),a
	ld wa,(_road_edge__0)
	push xwa
	call _id_car_wheel_dx
	ld xbc,xwa
	pop xwa
	extz bc
	add bc,2
	sub bc,5
	sll 4,bc
	sub wa,bc
	ld (xsp+12),wa
	ld bc,(_car_lat__0)
	cp bc,(xsp+12)
	jr ge,L211
	ld bc,(_car_lat__0)
	ld de,(xsp+12)
	neg de
	cp bc,de
	jr gt,L209
L211:
	ld wa,1
	jr L210
L209:
	ld wa,0
L210:
	ld (_offroad__0),a
	ld bc,(_car_lat__0)
	ld de,(xsp+12)
	add de,80
	cp bc,de
	jr gt,L212
	ld bc,(_car_lat__0)
	ld de,(xsp+12)
	neg de
	sub de,80
	cp bc,de
	jr lt,L212
	ld wa,1
	jr L213
L212:
	ld wa,0
L213:
	ld (xsp+14),a
	ld a,(_offroad__0)
	cp a,0
	jr z,L214
	ld a,(xsp+11)
	cp a,0
	jr nz,L214
	ld c,(xsp+14)
	cp c,0
	jr z,L215
	ld a,12
	extz wa
	jr L216
L215:
	ld a,24
	extz wa
L216:
	ld (xsp+15),a
	ld c,(_speed__0)
	cp c,(xsp+15)
	jr ule,L217
	ld a,(_speed__0)
	sub a,(xsp+15)
	extz wa
	jr L218
L217:
	ld wa,0
L218:
	ld (_speed__0),a
L214:
	ld a,(_offroad__0)
	cp a,0
	jr z,L219
	ld a,(_speed__0)
	extz wa
	sra 5,wa
	ld (xsp+15),a
	ld a,(xsp+14)
	cp a,0
	jr z,L220
	ld a,(xsp+15)
	extz wa
	sra 1,wa
	ld (xsp+15),a
L220:
	ld a,(xsp+15)
	cp a,0
	jr uge,L221
	ldb (xsp+15),0
L221:
	ld c,(_speed__0)
	cp c,(xsp+15)
	jr ule,L222
	ld a,(_speed__0)
	sub a,(xsp+15)
	extz wa
	jr L223
L222:
	ld wa,0
L223:
	ld (_speed__0),a
L219:
	ld wa,(xsp+12)
	push xwa
	call _recover_stranded__0
	lda xsp,(xsp+4)
	ld wa,(_car_lat__0)
	cp wa,(_lat_limit__0)
	jr le,L224
	ld wa,(_lat_limit__0)
	ld (_car_lat__0),wa
	jr L225
L224:
	ld wa,(_car_lat__0)
	ld bc,(_lat_limit__0)
	neg bc
	cp wa,bc
	jr ge,L226
	ld wa,(_lat_limit__0)
	neg wa
	ld (_car_lat__0),wa
L226:
L225:
L144:
	lda xsp,(xsp+16)
	pop xiz
	ret

; function profile_ahead
_profile_ahead__0:
	push xiz
	lda xsp,(xsp-46)
	call _id_road_lines
	ld izl,a
	ld a,izl
	cp a,0
	jr nz,L230
	jp L229
L230:
	call _id_road_ahead
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+0),xwa
	ld xwa,_road_bend__0
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+4),xwa
	call _id_road_grade_buf
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld (xsp+8),xwa
	ld xwa,(_track_seg)
	ld (xsp+12),xwa
	ld xwa,_grade_tab__0+6
	ld (xsp+16),xwa
	ld xwa,(_track_seg)
	ld c,(_seg_index__0)
	extz bc
	muls xbc,6
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+20),xwa
	ld wa,(_seg_pos__0)
	ld (xsp+24),wa
	ld a,izl
	ld (xsp+28),a
	ld a,(_seg_index__0)
	ld (xsp+29),a
	ld a,(_track_len)
	ld (xsp+30),a
	ldb (xsp+31),255
	ldb (xsp+33),255
	ldb (xsp+34),255
	lda xwa,(xsp+0)
	push xwa
	call _id_road_ahead_asm
	lda xsp,(xsp+4)
L229:
	lda xsp,(xsp+46)
	pop xiz
	ret

; function panel
_panel__0:
	push xiz
	lda xsp,(xsp-4)
	ld iy,0
	jr L248
L245:
	ld wa,21845
	ld xbc,40976
	ld de,iy
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L247:
	inc 1,iy
L248:
	ld wa,iy
	cp wa,8
	jr ult,L245
L246:
	push xix
	push xiy
	ld wa,785
	push xwa
	ld wa,785
	push xwa
	ld wa,785
	push xwa
	ld wa,0
	push xwa
	ld wa,7
	push xwa
	ld wa,1
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xiy
	pop xix
	ld ixl,20
	jr L252
L249:
	ld izl,0
	jr L256
L253:
	ld wa,3585
	ld xbc,38912
	ld e,ixl
	extz de
	sll 5,de
	ld l,izl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L255:
	inc 1,izl
L256:
	ld a,izl
	cp a,32
	jr ult,L253
L254:
L251:
	inc 1,ixl
L252:
	ld a,ixl
	cp a,24
	jr ult,L249
L250:
L244:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function clear_hud_rows
_clear_hud_rows__0:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld izl,a
	jr L266
L263:
	ld a,izl
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
L265:
	inc 1,izl
L266:
	ld a,izl
	cp a,(xsp+14)
	jr ule,L263
L264:
L262:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function reset_car
_reset_car__0:
	ld a,0
	ld (_finished__0),a
	ld (_offroad__0),a
	ld (_slip__0),a
	ld (_gear__0),a
	ld (_speed__0),a
	ld wa,0
	ld (_recovery_frames__0),wa
	ld (_track_frac__0),wa
	ld (_speed_acc__0),wa
	ld wa,0
	ld (_bend_now__0),wa
	ld (_heading_acc__0),wa
	ld (_hill_acc__0),wa
	ld (_car_lat__0),wa
	ldb (_car_lean__0),0
	ld a,0
	ld (_oil_hold__0),a
	ld (_steer_hold__0),a
	ld (_on_throttle__0),a
	ld a,0
	ld (_skid_t__0),a
	ld (_skid__0),a
L268:
	ret

; function leg_time
_leg_time__0:
	push xiz
	lda xsp,(xsp-4)
	ld xwa,_stage_time__0
	ld e,(_difficulty)
	cp e,0
	jr nz,L276
	ld bc,0
	jr L277
L276:
	ld bc,1
L277:
	mul xbc,5
	add xwa,xbc
	lda xwa,(xwa)
	ld c,(_cur_stage)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	ld iz,wa
	ld a,(_difficulty)
	cp a,3
	jr nz,L278
	ld xwa,_gfx_leg_ref_cost
	ld c,(_cur_stage)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+2),wa
	ld wa,iz
	ld bc,(_next_leg_cost)
	mul xwa,bc
	ld bc,(xsp+2)
	srl 1,bc
	extz xbc
	add xwa,xbc
	push xwa
	ld wa,(xsp+6)
	extz xwa
	ld xbc,xwa
	pop xwa
	call __div32u
	add xwa,1
	ld iz,wa
	ld wa,iz
	cp wa,35
	jr uge,L279
	ld iz,35
L279:
	ld wa,iz
	cp wa,90
	jr ule,L280
	ld iz,90
L280:
L278:
	ld a,izl
	jr L275
L275:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function stage_traffic
_stage_traffic__0:
	lda xsp,(xsp-2)
	ld c,(_difficulty)
	cp c,2
	jr nz,L285
	ld wa,2
	jr L286
L285:
	ld wa,0
L286:
	ld (xsp+0),a
	ld a,3
	add a,(_cur_stage)
	add a,(xsp+0)
	push xwa
	ld a,2
	add a,(_cur_stage)
	add a,(xsp+4)
	push xwa
	call _traffic_reset
	lda xsp,(xsp+8)
L284:
	lda xsp,(xsp+2)
	ret

; function new_game
_new_game__0:
	call _reset_car__0
	ldb (_seg_index__0),0
	ldw (_seg_pos__0),0
	ldw (_course_pos__0),0
	ldb (_racing__0),1
	call _course_start
	ld a,(_cur_leg)
	push xwa
	call _theme_apply
	lda xsp,(xsp+4)
	call _traffic_clear
	ld c,(_difficulty)
	cp c,2
	jr nz,L291
	ld wa,1
	jr L292
L291:
	ld wa,0
L292:
	push xwa
	call _traffic_set_hard
	lda xsp,(xsp+4)
	call _stage_traffic__0
	ld a,(_difficulty)
	push xwa
	call _banner_style
	lda xsp,(xsp+4)
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	call _id_scenery_init
	lda xsp,(xsp+8)
	ld wa,5
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	call _leg_time__0
	ld (_time_left__0),a
	ld xwa,0
	ld (_score__0),xwa
	call _hud_score_reset
	ldb (_sec_acc__0),0
	ldb (_crash_timer__0),0
	ldb (_msg_timer__0),0
	ldb (_flash_step__0),0
	ldb (_last_fork_zone__0),0
	ldb (_goal_reached__0),0
	ldb (_paused__0),0
	call _hud_clear_top
	ld wa,18
	push xwa
	ld wa,15
	push xwa
	call _clear_hud_rows__0
	lda xsp,(xsp+8)
	call _hud_reset
L290:
	ret

; function advance
_advance__0:
	push xiz
	lda xsp,(xsp-10)
	ld c,(_speed__0)
	cp c,16
	jr uge,L306
	ld a,(_speed__0)
	extz wa
	mul xwa,3502
	srl 4,wa
	jr L307
L306:
	ld wa,3502
L307:
	ld (xsp+0),wa
	ld a,(_speed__0)
	extz wa
	mul xwa,123
	add wa,(xsp+0)
	ld iz,wa
	ld wa,iz
	ld bc,iz
	srl 2,bc
	add wa,bc
	ld bc,iz
	srl 3,bc
	add wa,bc
	ld iz,wa
	ld wa,(_track_frac__0)
	add wa,iz
	ld iy,wa
	ld a,(_speed__0)
	cp a,0
	jr nz,L308
	ld wa,(_track_frac__0)
	ld iy,wa
L308:
	ld wa,iy
	srl 12,wa
	ld ix,wa
	ld wa,iy
	and wa,4095
	ld (_track_frac__0),wa
	ld wa,(_course_pos__0)
	add wa,ix
	ld (_course_pos__0),wa
	ld wa,(_seg_pos__0)
	add wa,ix
	ld (_seg_pos__0),wa
	jr L311
L309:
	ld wa,(_seg_pos__0)
	ld xbc,(_track_seg)
	ld e,(_seg_index__0)
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	sub wa,bc
	ld (_seg_pos__0),wa
	incb 1,(_seg_index__0)
	ld a,(_seg_index__0)
	cp a,(_track_len)
	jr ult,L312
	ldb (_seg_index__0),0
L312:
L311:
	ld wa,(_seg_pos__0)
	ld xbc,(_track_seg)
	ld e,(_seg_index__0)
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr uge,L309
L310:
	push xix
	push xiy
	ld wa,(_seg_pos__0)
	push xwa
	ld a,(_seg_index__0)
	push xwa
	call _bend_blended__0
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	ld (xsp+8),wa
	ld wa,(_bend_now__0)
	ld bc,(xsp+8)
	sub bc,6
	cp wa,bc
	jr ge,L313
	incw 6,(_bend_now__0)
	jr L314
L313:
	ld wa,(_bend_now__0)
	ld bc,(xsp+8)
	add bc,6
	cp wa,bc
	jr le,L315
	decw 6,(_bend_now__0)
	jr L316
L315:
	ld wa,(xsp+8)
	ld (_bend_now__0),wa
L316:
L314:
	ld wa,ix
	jr L305
L305:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function render_road
_render_road__0:
	call _profile_ahead__0
	ld wa,(_course_pos__0)
	push xwa
	call _id_road_band_phase
	lda xsp,(xsp+4)
	call _id_road_grade_buf
	push xwa
	call _id_road_hill_ahead
	lda xsp,(xsp+4)
	ld wa,(_car_lat__0)
	push xwa
	ld wa,(_heading_acc__0)
	push xwa
	call _id_road_pan
	lda xsp,(xsp+8)
	ld wa,(_heading_acc__0)
	sra 4,wa
	push xwa
	ld xwa,_road_bend__0
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_road_frame_ahead
	lda xsp,(xsp+12)
L318:
	ret

; function message
_message__0:
	ld wa,5
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld wa,7
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld xwa,(xsp+4)
	cp xwa,0
	jr z,L323
	ld xwa,(xsp+4)
	push xwa
	ld wa,5
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L323:
	ld xwa,(xsp+8)
	cp xwa,0
	jr z,L324
	ld xwa,(xsp+8)
	push xwa
	ld wa,7
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L324:
	ld a,(xsp+12)
	ld (_msg_timer__0),a
	call _banner_dirty
L322:
	ret

; function count_message
_count_message__0:
	ld wa,12
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld xwa,(xsp+4)
	cp xwa,0
	jr z,L328
	ld xwa,(xsp+4)
	push xwa
	ld wa,12
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L328:
	ld a,(xsp+8)
	ld (_cnt_timer__0),a
L327:
	ret

; function tick_message
_tick_message__0:
	ld a,(_msg_timer__0)
	cp a,0
	jr z,L335
	decb 1,(_msg_timer__0)
	ld a,(_msg_timer__0)
	cp a,0
	jr nz,L336
	ld wa,5
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld wa,7
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	call _banner_dirty
L336:
L335:
	ld a,(_cnt_timer__0)
	cp a,0
	jr z,L337
	decb 1,(_cnt_timer__0)
	ld a,(_cnt_timer__0)
	cp a,0
	jr nz,L338
	ld wa,12
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
L338:
L337:
L334:
	ret

; function leg_end
_leg_end__0:
	lda xsp,(xsp-4)
	call _course_is_last_stage
	cp a,0
	jr z,L344
	ld a,(_time_left__0)
	ld xbc,_dbg_cp
	ld e,(_cur_stage)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ldb (_state__0),4
	ldb (_state_timer__0),0
	ldb (_goal_reached__0),1
	ld wa,0
	push xwa
	ld xwa,_S0_8
	push xwa
	ld xwa,_S0_9
	push xwa
	call _message__0
	lda xsp,(xsp+12)
	ld wa,4
	push xwa
	call _music_play
	lda xsp,(xsp+4)
	ld wa,3
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	jp L343
L344:
	ld a,(_time_left__0)
	ld xbc,_dbg_cp
	ld e,(_cur_stage)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(_course_pos__0)
	sub wa,(_leg_len)
	ld (_course_pos__0),wa
	call _course_next_leg
	ld (xsp+0),a
	ld a,(_seg_index__0)
	sub a,(xsp+0)
	ld (_seg_index__0),a
	ld a,(_time_left__0)
	extz wa
	push xwa
	call _leg_time__0
	ld xbc,xwa
	pop xwa
	extz bc
	add wa,bc
	ld (xsp+2),wa
	ld bc,(xsp+2)
	cp bc,99
	jr ule,L345
	ld wa,99
	jr L346
L345:
	ld wa,(xsp+2)
L346:
	ld (_time_left__0),a
	ldb (_flash_step__0),1
	ld wa,75
	push xwa
	ld xwa,_S0_10
	push xwa
	ld xwa,_S0_11
	push xwa
	call _message__0
	lda xsp,(xsp+12)
	ld wa,2
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	ld wa,3
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
L343:
	lda xsp,(xsp+4)
	ret

; function tick_flash
_tick_flash__0:
	ld a,(_flash_step__0)
	cp a,0
	jr nz,L354
	jr L352
L354:
	ld a,(_flash_step__0)
	cp a,5
	jr nz,L355
	ld a,(_cur_leg)
	push xwa
	call _theme_apply
	lda xsp,(xsp+4)
	call _stage_traffic__0
L355:
	ld xwa,_lv__0_L353
	ld c,(_flash_step__0)
	extz bc
	sub bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	call _theme_flash
	lda xsp,(xsp+4)
	incb 1,(_flash_step__0)
	ld a,(_flash_step__0)
	cp a,12
	jr ule,L356
	ldb (_flash_step__0),0
L356:
L352:
	ret

; function print_score7
_print_score7__0:
	lda xsp,(xsp-4)
	ld xwa,(xsp+16)
	push xwa
	ld xwa,10000
	ld xbc,xwa
	pop xwa
	call __div32u
	ld (xsp+0),wa
	ld xwa,(xsp+16)
	ld bc,(xsp+0)
	mul xbc,10000
	sub xwa,xbc
	ld (xsp+2),wa
	ld wa,3
	push xwa
	ld wa,(xsp+4)
	push xwa
	ld a,(xsp+20)
	push xwa
	ld a,(xsp+20)
	push xwa
	ld a,(xsp+36)
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print_dec
	lda xsp,(xsp+24)
	ld wa,4
	push xwa
	ld wa,(xsp+6)
	push xwa
	ld a,(xsp+20)
	push xwa
	ld a,(xsp+20)
	add a,3
	push xwa
	ld a,(xsp+36)
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print_dec
	lda xsp,(xsp+24)
L358:
	lda xsp,(xsp+4)
	ret

; function put32
_put32__0:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld iyl,a
	ld xix,(xsp+14)
	ld izl,0
	jr L370
L367:
	ld xwa,xix
	ld c,izl
	extz bc
	sll 3,bc
	cp c,0
	jr z,L372
L371:
	srl 1,xwa
	djnz c,L371
L372:
	ld xbc,_save_buf__0
	ld e,iyl
	add e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L369:
	inc 1,izl
L370:
	ld a,izl
	cp a,4
	jr ult,L367
L368:
L366:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function get32
_get32__0:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld xwa,_save_buf__0
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	extz xwa
	ld xbc,_save_buf__0
	ld e,izl
	add e,1
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	extz xbc
	sll 8,xbc
	or xwa,xbc
	ld xbc,_save_buf__0
	ld e,izl
	add e,2
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	extz xbc
	sll 15,xbc
	sll 1,xbc
	or xwa,xbc
	ld xbc,_save_buf__0
	ld e,izl
	add e,3
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	extz xbc
	sll 15,xbc
	sll 9,xbc
	or xwa,xbc
	jr L374
L374:
	pop xiz
	ret

; function save_load
_save_load__0:
	push xiz
	lda xsp,(xsp-6)
	push xix
	call _ngpc_flash_init
	pop xix
	push xix
	call _ngpc_flash_exists
	pop xix
	cp a,0
	jr nz,L386
	jp L385
L386:
	push xix
	ld xwa,_save_buf__0
	push xwa
	call _ngpc_flash_load
	lda xsp,(xsp+4)
	pop xix
	ld a,(_save_buf__0+4)
	cp a,1
	jr z,L387
	jp L385
L387:
	ld a,(_save_buf__0+5)
	cp a,4
	jr uge,L388
	ld a,(_save_buf__0+5)
	ld (_station__0),a
L388:
	ld a,(_save_buf__0+6)
	cp a,4
	jr uge,L389
	ld a,(_save_buf__0+6)
	ld (_difficulty),a
L389:
	ld izl,0
	jr L393
L390:
	push xix
	ld wa,8
	ld c,izl
	extz bc
	sll 2,bc
	add wa,bc
	push xwa
	call _get32__0
	lda xsp,(xsp+4)
	pop xix
	ld xix,xwa
	ld xwa,xix
	cp xwa,0
	jr z,L394
	ld xwa,xix
	cp xwa,10000000
	jr uge,L394
	ld xwa,xix
	ld xbc,_hiscore__0
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L394:
L392:
	inc 1,izl
L393:
	ld a,izl
	cp a,4
	jr ult,L390
L391:
	ld a,(_save_buf__0+24)
	extz wa
	ld c,(_save_buf__0+25)
	extz bc
	sll 8,bc
	or wa,bc
	ld (_free_seed),wa
L385:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function save_commit
_save_commit__0:
	push xiz
	lda xsp,(xsp-4)
	ld a,(_save_dirty__0)
	cp a,0
	jr nz,L407
	jp L406
L407:
	ld ix,0
	jr L411
L408:
	ld a,0
	ld xbc,_save_buf__0
	ld de,ix
	extz xde
	add xbc,xde
	ld (xbc),a
L410:
	inc 1,ix
L411:
	ld wa,ix
	cp wa,256
	jr ult,L408
L409:
	ldb (_save_buf__0),202
	ldb (_save_buf__0+1),254
	ldb (_save_buf__0+2),32
	ldb (_save_buf__0+3),38
	ldb (_save_buf__0+4),1
	ld a,(_station__0)
	ld (_save_buf__0+5),a
	ld a,(_difficulty)
	ld (_save_buf__0+6),a
	ld izl,0
	jr L415
L412:
	push xix
	ld xwa,_hiscore__0
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld wa,8
	ld c,izl
	extz bc
	sll 2,bc
	add wa,bc
	push xwa
	call _put32__0
	lda xsp,(xsp+8)
	pop xix
L414:
	inc 1,izl
L415:
	ld a,izl
	cp a,4
	jr ult,L412
L413:
	ld a,(_free_seed)
	ld (_save_buf__0+24),a
	ld wa,(_free_seed)
	srl 8,wa
	ld (_save_buf__0+25),a
	push xix
	ld xwa,_save_buf__0
	push xwa
	call _ngpc_flash_save
	lda xsp,(xsp+4)
	pop xix
	cp a,0
	jr z,L416
	ldb (_save_dirty__0),0
L416:
L406:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function title_slot
_title_slot__0:
	push xiz
	ld iz,(xsp+8)
	ld wa,iz
	cp wa,114
	jr uge,L422
	ld wa,(_pano_tiles_at__0)
	add wa,iz
	jr L421
L422:
	ld wa,iz
	sub wa,114
	ld iz,wa
	ld wa,iz
	cp wa,(_gfx_traffic_tiles_count)
	jr uge,L423
	ld wa,(_trf_tiles_at__0)
	add wa,iz
	jr L421
L423:
	ld wa,iz
	sub wa,(_gfx_traffic_tiles_count)
	ld iz,wa
	ld wa,iz
	cp wa,30
	jr uge,L424
	ld wa,2
	add wa,iz
	jr L421
L424:
	ld wa,iz
	sub wa,30
	ld iz,wa
	ld wa,101
	add wa,iz
	jr L421
L421:
	pop xiz
	ret

; function title_option
_title_option__0:
	push xiz
	lda xsp,(xsp-2)
	ld wa,0
	ld izl,a
	jr L433
L431:
	inc 1,izl
L433:
	ld xwa,(xsp+14)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L434
	ld a,izl
	cp a,16
	jr ult,L431
L434:
L432:
	ld wa,20
	ld c,izl
	extz bc
	sub wa,bc
	srl 1,wa
	ld (xsp+1),a
	ld a,(xsp+10)
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld wa,0
	push xwa
	ld wa,(xsp+26)
	push xwa
	ld a,(xsp+18)
	push xwa
	ld a,(xsp+13)
	sub a,2
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_put_tile
	lda xsp,(xsp+20)
	ld wa,0
	push xwa
	ld wa,(xsp+30)
	push xwa
	ld a,(xsp+18)
	push xwa
	ld a,(xsp+13)
	add a,izl
	add a,1
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_put_tile
	lda xsp,(xsp+20)
	ld xwa,(xsp+14)
	push xwa
	ld a,(xsp+14)
	push xwa
	ld a,(xsp+9)
	push xwa
	ld a,(xsp+30)
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
L430:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function hex4
_hex4__0:
	push xiz
	lda xsp,(xsp-2)
	ld xiy,(xsp+10)
	ld izl,0
	jr L448
L445:
	ld wa,(xsp+14)
	ld bc,12
	ld e,izl
	extz de
	sll 2,de
	sub bc,de
	cp c,0
	jr z,L450
L449:
	srl 1,wa
	djnz c,L449
L450:
	and wa,15
	ld ixl,a
	ld c,ixl
	cp c,10
	jr uge,L451
	ld wa,48
	ld c,ixl
	extz bc
	add wa,bc
	jr L452
L451:
	ld wa,65
	ld c,ixl
	extz bc
	add wa,bc
	sub wa,10
L452:
	ld xbc,xiy
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L447:
	inc 1,izl
L448:
	ld a,izl
	cp a,4
	jr ult,L445
L446:
	ldb (xiy+4),0
L444:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function title_texts
_title_texts__0:
	lda xsp,(xsp-16)
	ld wa,209
	push xwa
	call _title_slot__0
	lda xsp,(xsp+4)
	push xwa
	ld wa,208
	push xwa
	call _title_slot__0
	lda xsp,(xsp+4)
	push xwa
	ld xwa,_diff_pal__0
	ld c,(_difficulty)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,_diff_name__0
	ld c,(_difficulty)
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld wa,14
	push xwa
	call _title_option__0
	lda xsp,(xsp+20)
	ld wa,99
	push xwa
	ld wa,98
	push xwa
	ld wa,1
	push xwa
	ld xwa,_station_name__0
	ld c,(_station__0)
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld wa,15
	push xwa
	call _title_option__0
	lda xsp,(xsp+20)
	ld wa,16
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld wa,17
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld wa,18
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld xwa,_S0_12
	push xwa
	ld wa,17
	push xwa
	ld wa,5
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	ld wa,1
	push xwa
	ld xwa,_hiscore__0
	ld c,(_difficulty)
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld wa,17
	push xwa
	ld wa,8
	push xwa
	call _print_score7__0
	lda xsp,(xsp+16)
	ld a,(_difficulty)
	cp a,3
	jr nz,L456
	ldb (xsp+0),83
	ldb (xsp+1),69
	ldb (xsp+2),69
	ldb (xsp+3),68
	ldb (xsp+4),32
	ld wa,(_free_seed)
	push xwa
	lda xwa,(xsp+9)
	push xwa
	call _hex4__0
	lda xsp,(xsp+8)
	lda xwa,(xsp+0)
	push xwa
	ld wa,18
	push xwa
	ld wa,2
	push xwa
	ld wa,15
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	ld xwa,_S0_13
	push xwa
	ld wa,18
	push xwa
	ld wa,13
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
L456:
L455:
	lda xsp,(xsp+16)
	ret

; function new_seed
_new_seed__0:
	lda xsp,(xsp-2)
	ld wa,(_title_frames__0)
	mul xwa,25173
	add wa,13849
	ld c,(_g_vb_counter)
	extz bc
	sll 8,bc
	xor wa,bc
	ld (xsp+0),wa
	ld bc,(xsp+0)
	cp bc,0
	jr z,L461
	ld wa,(xsp+0)
	jr L462
L461:
	ld wa,24301
L462:
	ld (_free_seed),wa
L460:
	lda xsp,(xsp+2)
	ret

; function title_screen
_title_screen__0:
	push xiz
	lda xsp,(xsp-16)
	push xix
	call _id_road_dma_pause
	pop xix
	push xix
	call _save_commit__0
	pop xix
	push xix
	call _ending_stop
	pop xix
	push xix
	call _banner_hide
	pop xix
	push xix
	ld wa,64
	push xwa
	ld wa,0
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xix
	push xix
	call _hud_clear_top
	pop xix
	push xix
	ld wa,18
	push xwa
	ld wa,15
	push xwa
	call _clear_hud_rows__0
	lda xsp,(xsp+8)
	pop xix
	ldb (08034h),0
	ldb (08035h),0
	ldw (xsp+2),0
	jr L508
L505:
	ld wa,0
	ld xbc,38912
	ld de,(xsp+2)
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L507:
	incw 1,(xsp+2)
L508:
	ld wa,(xsp+2)
	cp wa,1024
	jr ult,L505
L506:
	push xix
	ld wa,2642
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
	pop xix
	ldw (xsp+0),0
	jr L512
L509:
	ld wa,40960
	extz xwa
	push xwa
	push xix
	ld wa,(xsp+8)
	push xwa
	call _title_slot__0
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xix
	pop xwa
	mul xbc,16
	add xwa,xbc
	ld (xsp+6),xwa
	ld xwa,_gfx_title_tiles
	ld bc,(xsp+0)
	sll 3,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+10),xwa
	ldb (xsp+14),0
	jr L516
L513:
	ld xwa,(xsp+10)
	ld c,(xsp+14)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(xsp+6)
	ld e,(xsp+14)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L515:
	incb 1,(xsp+14)
L516:
	ld a,(xsp+14)
	cp a,8
	jr ult,L513
L514:
L511:
	incw 1,(xsp+0)
L512:
	ld wa,(xsp+0)
	cp wa,210
	jr ult,L509
L510:
	ldw (xsp+0),0
	jr L520
L517:
	ld xwa,_gfx_emblem_pals
	ld bc,(xsp+0)
	sll 2,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+6),xwa
	push xix
	ld xwa,(xsp+10)
	ld wa,(xwa+6)
	push xwa
	ld xwa,(xsp+14)
	ld wa,(xwa+4)
	push xwa
	ld xwa,(xsp+18)
	ld wa,(xwa+2)
	push xwa
	ld wa,0
	push xwa
	ld xwa,_emblem_pal_slot__0
	ld bc,(xsp+20)
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld wa,1
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xix
L519:
	incw 1,(xsp+0)
L520:
	ld wa,(xsp+0)
	cp wa,13
	jr ult,L517
L518:
	ldw (xsp+0),0
	jr L524
L521:
	ld xwa,_gfx_over_pals
	ld bc,(xsp+0)
	sll 2,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+6),xwa
	push xix
	ld xwa,(xsp+10)
	ld wa,(xwa+6)
	push xwa
	ld xwa,(xsp+14)
	ld wa,(xwa+4)
	push xwa
	ld xwa,(xsp+18)
	ld wa,(xwa+2)
	push xwa
	ld wa,0
	push xwa
	ld xwa,_over_pal_slot__0
	ld bc,(xsp+20)
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xix
L523:
	incw 1,(xsp+0)
L524:
	ld wa,(xsp+0)
	cp wa,8
	jr ult,L521
L522:
	push xix
	ld wa,4039
	push xwa
	ld wa,2658
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,15
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xix
	ld ixl,0
	jp L528
L525:
	ld izl,0
	jp L532
L529:
	ld xwa,_gfx_emblem_map
	ld c,ixl
	extz bc
	mul xbc,18
	ld e,izl
	extz de
	add bc,de
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+6),wa
	ld bc,(xsp+6)
	cp bc,65535
	jr nz,L533
	ld wa,0
	jr L534
L533:
	push xix
	ld wa,(xsp+10)
	push xwa
	call _title_slot__0
	lda xsp,(xsp+4)
	pop xix
	ld xbc,_emblem_pal_slot__0
	ld xde,_gfx_emblem_pal
	ld l,ixl
	extz hl
	mul xhl,18
	push xde
	ld e,izl
	extz de
	add hl,de
	pop xde
	exts xhl
	add xde,xhl
	ld e,(xde)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	sll 9,bc
	or wa,bc
L534:
	ld xbc,38912
	ld e,ixl
	extz de
	sll 5,de
	ld l,izl
	extz hl
	add hl,1
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L531:
	inc 1,izl
L532:
	ld a,izl
	cp a,18
	jp ult,L529
L530:
L527:
	inc 1,ixl
L528:
	ld a,ixl
	cp a,11
	jp ult,L525
L526:
	ld ixl,0
	jp L538
L535:
	ld izl,0
	jp L542
L539:
	ld xwa,_gfx_over_map
	ld c,ixl
	extz bc
	mul xbc,20
	ld e,izl
	extz de
	add bc,de
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+6),wa
	ld bc,(xsp+6)
	cp bc,65535
	jr nz,L543
	ld wa,0
	jr L544
L543:
	push xix
	ld wa,(xsp+10)
	push xwa
	call _title_slot__0
	lda xsp,(xsp+4)
	pop xix
	ld xbc,_over_pal_slot__0
	ld xde,_gfx_over_pal
	ld l,ixl
	extz hl
	mul xhl,20
	push xde
	ld e,izl
	extz de
	add hl,de
	pop xde
	exts xhl
	add xde,xhl
	ld e,(xde)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	sll 9,bc
	or wa,bc
L544:
	ld xbc,36864
	ld e,ixl
	extz de
	sll 5,de
	ld l,izl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L541:
	inc 1,izl
L542:
	ld a,izl
	cp a,20
	jp ult,L539
L540:
L537:
	inc 1,ixl
L538:
	ld a,ixl
	cp a,11
	jp ult,L535
L536:
	push xix
	call _title_texts__0
	pop xix
L504:
	lda xsp,(xsp+16)
	pop xiz
	ret

; function title_leave
_title_leave__0:
	push xiz
	lda xsp,(xsp-2)
	call _save_commit__0
	call _hud_clear_top
	ld wa,18
	push xwa
	ld wa,15
	push xwa
	call _clear_hud_rows__0
	lda xsp,(xsp+8)
	ld wa,64
	push xwa
	ld wa,0
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	call _id_road_reload_maps
	ld iz,0
	jr L554
L551:
	ld xwa,_gfx_traffic_tiles
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld bc,40960
	extz xbc
	ld de,(_trf_tiles_at__0)
	mul xde,16
	add xbc,xde
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L553:
	inc 1,iz
L554:
	ld wa,iz
	ld bc,(_gfx_traffic_tiles_count)
	sll 3,bc
	cp wa,bc
	jr ult,L551
L552:
	call _id_road_dma_resume
L550:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function title_car
_title_car__0:
	push xiz
	lda xsp,(xsp-24)
	ld wa,87
	push xwa
	push xix
	push xiy
	call _id_car_height
	ld xbc,xwa
	pop xiy
	pop xix
	pop xwa
	extz bc
	sub wa,bc
	ld (xsp+0),a
	ld wa,64
	ld (xsp+2),wa
	ld a,(xsp+32)
	extz wa
	sra 2,wa
	and wa,1
	ld (xsp+5),a
	push xix
	push xiy
	ld a,(xsp+8)
	push xwa
	ld wa,(xsp+14)
	push xwa
	call _id_car_draw_at
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	ld ixl,0
	jp L578
L575:
	ld wa,24
	ld c,ixl
	extz bc
	sll 1,bc
	add wa,bc
	ld (xsp+6),a
	ld c,ixl
	cp c,0
	jr nz,L579
	ld wa,(xsp+2)
	sub wa,13
	ld c,(xsp+5)
	extz bc
	sub wa,bc
	jr L580
L579:
	ld wa,(xsp+2)
	add wa,29
	ld c,(xsp+5)
	extz bc
	add wa,bc
L580:
	ld (xsp+8),wa
	ld izl,0
	jp L584
L581:
	ld c,ixl
	cp c,0
	jr z,L586
	ld a,1
	sub a,izl
	extz wa
	jr L587
L586:
	ld a,izl
	extz wa
L587:
	ld (xsp+11),a
L588:
	ld a,(xsp+6)
	add a,izl
	ld (xsp+12),a
	ld wa,(xsp+8)
	ld c,izl
	extz bc
	sll 3,bc
	add wa,bc
	ld (xsp+13),a
	ld a,(xsp+0)
	add a,15
	sub a,(xsp+5)
	ld (xsp+14),a
	ld xwa,_tsm__0_L585
	ld c,(xsp+5)
	extz bc
	ld e,ixl
	extz de
	add bc,de
	and bc,1
	sll 1,bc
	ld e,(xsp+11)
	extz de
	add bc,de
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	ld (xsp+16),wa
	ld a,3
	ld (xsp+18),a
	ld c,ixl
	cp c,0
	jr z,L591
	ld wa,128
	jr L592
L591:
	ld wa,0
L592:
	ld (xsp+19),a
	ld wa,34816
	ld c,(xsp+12)
	extz bc
	sll 2,bc
	add wa,bc
	extz xwa
	ld xiy,xwa
	ld a,(xsp+16)
	and a,255
	ld (xiy),a
	ld a,(xsp+19)
	extz wa
	ld c,(_id_spr_priority)
	extz bc
	or wa,bc
	ld bc,(xsp+16)
	srl 8,bc
	and bc,1
	extz bc
	or wa,bc
	ld (xiy+1),a
	ld a,(xsp+13)
	ld (xiy+2),a
	ld a,(xsp+14)
	ld (xiy+3),a
	ld a,(xsp+18)
	and a,15
	ld bc,35840
	ld e,(xsp+12)
	extz de
	add bc,de
	extz xbc
	ld (xbc),a
L590:
L589:
L583:
	inc 1,izl
L584:
	ld a,izl
	cp a,2
	jp ult,L581
L582:
L577:
	inc 1,ixl
L578:
	ld a,ixl
	cp a,2
	jp ult,L575
L576:
L574:
	lda xsp,(xsp+24)
	pop xiz
	ret

; function title_blink
_title_blink__0:
	ld a,(xsp+4)
	extz wa
	and wa,31
	cp wa,0
	jr nz,L598
	ld xwa,_S0_14
	push xwa
	ld a,(xsp+12)
	push xwa
	ld wa,2
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	jr L599
L598:
	ld a,(xsp+4)
	extz wa
	and wa,31
	cp wa,20
	jr nz,L600
	ld a,(xsp+8)
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
L600:
L599:
L597:
	ret

; function trophy_load
_trophy_load__0:
	push xiz
	lda xsp,(xsp-2)
	ld iz,0
	jr L610
L607:
	ld xwa,_gfx_trophy_tiles
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,42576
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L609:
	inc 1,iz
L610:
	ld wa,iz
	cp wa,48
	jr ult,L607
L608:
	ld wa,(_gfx_trophy_pal+6)
	push xwa
	ld wa,(_gfx_trophy_pal+4)
	push xwa
	ld wa,(_gfx_trophy_pal+2)
	push xwa
	ld wa,(_gfx_trophy_pal)
	push xwa
	ld a,8
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
L606:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function trophy_draw
_trophy_draw__0:
	push xiz
	lda xsp,(xsp-18)
	ld c,(_g_vb_counter)
	extz bc
	sra 3,bc
	and bc,3
	cp bc,1
	jr nz,L622
	ld wa,1
	jr L623
L622:
	ld wa,0
L623:
	ld (xsp+1),a
	ld ixl,0
	jp L627
L624:
	ld xwa,_gfx_trophy_cells
	ld c,ixl
	extz bc
	mul xbc,3
	extz xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+2),xwa
L628:
	ld a,50
	add a,ixl
	ld (xsp+6),a
	ld wa,72
	ld xbc,(xsp+2)
	ld c,(xbc)
	extz bc
	sll 3,bc
	add wa,bc
	ld (xsp+7),a
	ld wa,82
	ld c,(xsp+1)
	extz bc
	sub wa,bc
	ld xbc,(xsp+2)
	ld c,(xbc+1)
	extz bc
	sll 3,bc
	add wa,bc
	ld (xsp+8),a
	ld wa,101
	ld xbc,(xsp+2)
	ld c,(xbc+2)
	extz bc
	add wa,bc
	ld iy,wa
	ld a,8
	ld (xsp+12),a
	ld a,0
	ld (xsp+13),a
	ld wa,34816
	ld c,(xsp+6)
	extz bc
	sll 2,bc
	add wa,bc
	extz xwa
	ld xiz,xwa
	ld a,iyl
	and a,255
	ld (xiz),a
	ld a,(xsp+13)
	extz wa
	ld c,(_id_spr_priority)
	extz bc
	or wa,bc
	ld bc,iy
	srl 8,bc
	and bc,1
	extz bc
	or wa,bc
	ld (xiz+1),a
	ld a,(xsp+7)
	ld (xiz+2),a
	ld a,(xsp+8)
	ld (xiz+3),a
	ld a,(xsp+12)
	and a,15
	ld bc,35840
	ld e,(xsp+6)
	extz de
	add bc,de
	extz xbc
	ld (xbc),a
L630:
L629:
L626:
	inc 1,ixl
L627:
	ld a,ixl
	cp a,6
	jp ult,L624
L625:
L621:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function result_screen
_result_screen__0:
	push xiz
	lda xsp,(xsp-20)
	call _hud_clear_top
	ld wa,18
	push xwa
	ld wa,15
	push xwa
	call _clear_hud_rows__0
	lda xsp,(xsp+8)
	ld c,(_goal_reached__0)
	cp c,0
	jr z,L651
	ld xwa,_S0_15
	jr L652
L651:
	ld xwa,_S0_16
L652:
	push xwa
	ld wa,2
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
	ld xwa,_diff_name__0
	ld c,(_difficulty)
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	ld (xsp+14),xwa
	ld wa,0
	ld (xsp+18),a
	jr L655
L653:
	ld xwa,(xsp+14)
	ld c,(xsp+18)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	lda xbc,(xsp+1)
	ld e,(xsp+18)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	incb 1,(xsp+18)
L655:
	ld xwa,(xsp+14)
	ld c,(xsp+18)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L653
L654:
	ld a,(_difficulty)
	cp a,3
	jr nz,L656
	ld a,32
	lda xbc,(xsp+1)
	ld e,(xsp+18)
	incb 1,(xsp+18)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(_free_seed)
	push xwa
	lda xwa,(xsp+5)
	ld c,(xsp+22)
	extz bc
	exts xbc
	add xwa,xbc
	lda xwa,(xwa)
	push xwa
	call _hex4__0
	lda xsp,(xsp+8)
	jr L657
L656:
	ld a,0
	lda xbc,(xsp+1)
	ld e,(xsp+18)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L657:
	lda xwa,(xsp+1)
	push xwa
	ld wa,4
	push xwa
	ld wa,20
	ld c,(xsp+26)
	extz bc
	ld l,(_difficulty)
	cp l,3
	jr nz,L658
	ld de,4
	jr L659
L658:
	ld de,0
L659:
	add bc,de
	sub wa,bc
	srl 1,wa
	push xwa
	ld xwa,_diff_pal__0
	ld c,(_difficulty)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	ld xwa,_S0_17
	push xwa
	ld wa,5
	push xwa
	ld wa,3
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	ld wa,1
	push xwa
	ld xwa,(_score__0)
	push xwa
	ld wa,5
	push xwa
	ld wa,10
	push xwa
	call _print_score7__0
	lda xsp,(xsp+16)
	ld xwa,_S0_18
	push xwa
	ld wa,7
	push xwa
	ld wa,3
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	ld izl,0
	jr L663
L660:
	ld wa,1
	push xwa
	ld wa,65
	ld xbc,_route_hist
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	push xwa
	ld wa,7
	push xwa
	ld wa,10
	ld c,izl
	extz bc
	sll 1,bc
	add wa,bc
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_put_tile
	lda xsp,(xsp+20)
	ld a,izl
	cp a,(_cur_stage)
	jr uge,L664
	ld wa,0
	push xwa
	ld wa,45
	push xwa
	ld wa,7
	push xwa
	ld wa,11
	ld c,izl
	extz bc
	sll 1,bc
	add wa,bc
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_put_tile
	lda xsp,(xsp+20)
L664:
L662:
	inc 1,izl
L663:
	ld a,izl
	cp a,(_cur_stage)
	jr ule,L660
L661:
	ld xwa,(_score__0)
	ld xbc,_hiscore__0
	ld e,(_difficulty)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld xbc,(xbc)
	cp xwa,xbc
	jr ule,L665
	ld xwa,(_score__0)
	ld xbc,_hiscore__0
	ld e,(_difficulty)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ldb (_save_dirty__0),1
	ld xwa,_S0_19
	push xwa
	ld wa,9
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L665:
	call _banner_hide
	ld a,64
	push xwa
	ld a,28
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	ld a,(_goal_reached__0)
	cp a,0
	jr z,L666
	call _trophy_load__0
	ld c,(_difficulty)
	cp c,3
	jr nz,L667
	ld wa,5
	jr L668
L667:
	ld xwa,_route_hist
	ld c,(_cur_stage)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
L668:
	push xwa
	call _ending_start
	lda xsp,(xsp+4)
L666:
L650:
	lda xsp,(xsp+20)
	pop xiz
	ret

; function smoke_init
_smoke_init__0:
	push xiz
	lda xsp,(xsp-2)
	ld ixl,0
	jr L682
L679:
	ld izl,0
	jr L686
L683:
	ld xwa,_smoke_tiles__0
	ld c,ixl
	extz bc
	sll 3,bc
	ld e,izl
	extz de
	add bc,de
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld bc,40960
	extz xbc
	ld xde,_smoke_slot__0
	ld l,ixl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	extz de
	muls xde,16
	add xbc,xde
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L685:
	inc 1,izl
L686:
	ld a,izl
	cp a,8
	jr ult,L683
L684:
L681:
	inc 1,ixl
L682:
	ld a,ixl
	cp a,4
	jr ult,L679
L680:
	push xix
	ld wa,4095
	push xwa
	ld wa,3549
	push xwa
	ld wa,2730
	push xwa
	ld wa,0
	push xwa
	ld a,3
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xix
L678:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function smoke_draw
_smoke_draw__0:
	push xiz
	lda xsp,(xsp-24)
	ld a,(xsp+32)
	cp a,0
	jr nz,L710
	push xix
	push xiy
	ld a,28
	push xwa
	ld a,24
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	ldb (_smoke_t__0),0
	jp L709
L710:
	ld a,(_smoke_t__0)
	extz wa
	and wa,7
	cp wa,0
	jr nz,L711
	push xix
	push xiy
	ld wa,7
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L711:
	incb 1,(_smoke_t__0)
	push xix
	push xiy
	call _id_car_last_x
	pop xiy
	pop xix
	ld (xsp+0),wa
	push xix
	push xiy
	call _id_car_last_top
	pop xiy
	pop xix
	extz wa
	add wa,14
	ld c,(_smoke_t__0)
	extz bc
	sra 1,bc
	and bc,1
	add wa,bc
	ld (xsp+2),a
	ld ixl,0
	jp L715
L712:
	ld c,ixl
	cp c,0
	jr nz,L716
	ld wa,(xsp+0)
	sub wa,11
	ld c,(_smoke_t__0)
	extz bc
	sra 2,bc
	and bc,1
	sub wa,bc
	jr L717
L716:
	ld wa,(xsp+0)
	add wa,27
	ld c,(_smoke_t__0)
	extz bc
	sra 2,bc
	and bc,1
	add wa,bc
L717:
	ld (xsp+6),wa
	ld a,(_smoke_t__0)
	extz wa
	sra 2,wa
	ld c,ixl
	extz bc
	add wa,bc
	and wa,1
	ld (xsp+3),a
	ld izl,0
	jp L721
L718:
	ld wa,24
	ld c,ixl
	extz bc
	sll 1,bc
	add wa,bc
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+8),a
	ld c,ixl
	cp c,0
	jr z,L722
	ld a,1
	sub a,izl
	extz wa
	jr L723
L722:
	ld a,izl
	extz wa
L723:
	ld (xsp+9),a
	ld wa,(xsp+6)
	ld c,izl
	extz bc
	sll 3,bc
	add wa,bc
	ld (xsp+10),wa
	ld wa,(xsp+10)
	cp wa,65529
	jr lt,L725
	ld wa,(xsp+10)
	cp wa,159
	jr le,L724
L725:
	push xix
	push xiy
	ld a,(xsp+16)
	add a,1
	push xwa
	ld a,(xsp+20)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	jp L720
L724:
L726:
	ld a,(xsp+8)
	ld (xsp+12),a
	ld a,(xsp+10)
	ld (xsp+13),a
	ld a,(xsp+2)
	ld (xsp+14),a
	ld xwa,_smoke_slot__0
	ld c,(xsp+3)
	extz bc
	sll 1,bc
	ld e,(xsp+9)
	extz de
	add bc,de
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	ld (xsp+16),wa
	ld a,3
	ld (xsp+18),a
	ld c,ixl
	cp c,0
	jr z,L729
	ld wa,128
	jr L730
L729:
	ld wa,0
L730:
	ld (xsp+19),a
	ld wa,34816
	ld c,(xsp+12)
	extz bc
	sll 2,bc
	add wa,bc
	extz xwa
	ld xiy,xwa
	ld a,(xsp+16)
	and a,255
	ld (xiy),a
	ld a,(xsp+19)
	extz wa
	ld c,(_id_spr_priority)
	extz bc
	or wa,bc
	ld bc,(xsp+16)
	srl 8,bc
	and bc,1
	extz bc
	or wa,bc
	ld (xiy+1),a
	ld a,(xsp+13)
	ld (xiy+2),a
	ld a,(xsp+14)
	ld (xiy+3),a
	ld a,(xsp+18)
	and a,15
	ld bc,35840
	ld e,(xsp+12)
	extz de
	add bc,de
	extz xbc
	ld (xbc),a
L728:
L727:
L720:
	inc 1,izl
L721:
	ld a,izl
	cp a,2
	jp ult,L718
L719:
L714:
	inc 1,ixl
L715:
	ld a,ixl
	cp a,2
	jp ult,L712
L713:
L709:
	lda xsp,(xsp+24)
	pop xiz
	ret

; function engine_sound
_engine_sound__0:
	push xiz
	lda xsp,(xsp-10)
	ld c,(_gear__0)
	cp c,0
	jr nz,L746
	ld wa,137
	jr L747
L746:
	ld wa,224
L747:
	ld (xsp+0),wa
	ld a,(_speed__0)
	extz wa
	mul xwa,255
	extz xwa
	div xwa,(xsp+0)
	ld ix,wa
	ld wa,ix
	cp wa,255
	jr ule,L748
	ld ix,255
L748:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L749
	ld ix,0
L749:
	ld wa,95
	ld bc,ix
	mul xbc,27
	srl 6,bc
	add wa,bc
	ld (xsp+4),wa
	ld wa,48000
	extz xwa
	div xwa,(xsp+4)
	sll 1,wa
	ld iz,wa
	incb 1,(_eng_phase__0)
	ld a,(_eng_phase__0)
	extz wa
	and wa,1
	cp wa,0
	jr z,L750
	ld wa,iz
	ld bc,iz
	ld l,(_offroad__0)
	cp l,0
	jr z,L751
	ld l,(_speed__0)
	cp l,20
	jr ule,L751
	ld de,3
	jr L752
L751:
	ld de,5
L752:
	cp e,0
	jr z,L754
L753:
	srl 1,bc
	djnz e,L753
L754:
	add wa,bc
	ld iz,wa
L750:
	ld c,(_ngpc_pad_held)
	extz bc
	and bc,16
	cp bc,0
	jr z,L755
	ld wa,4
	jr L756
L755:
	ld wa,6
L756:
	ld iyl,a
	ld a,(_state__0)
	cp a,4
	jr z,L758
	ld a,(_state__0)
	cp a,3
	jr nz,L757
L758:
	ld iyl,9
L757:
	push xix
	push xiy
	ld a,iyl
	push xwa
	ld wa,iz
	push xwa
	call _player_engine
	lda xsp,(xsp+8)
	pop xiy
	pop xix
L745:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function sharp_ahead
_sharp_ahead__0:
	push xiz
	lda xsp,(xsp-6)
	ld a,(_seg_index__0)
	ld izl,a
	ld xwa,(_track_seg)
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld wa,(xwa)
	sub wa,(_seg_pos__0)
	ld iy,wa
	ld xwa,(_track_seg)
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld wa,(xwa+2)
	ld ix,wa
	ld wa,ix
	cp wa,52
	jr ge,L775
	ld wa,ix
	cp wa,65484
	jr gt,L774
L775:
	ld wa,0
	jp L773
L774:
	ldb (xsp+1),0
	jr L779
L776:
	inc 1,izl
	ld a,izl
	cp a,(_track_len)
	jr ult,L780
	ld izl,0
L780:
	ld xwa,(_track_seg)
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld wa,(xwa+2)
	ld ix,wa
	ld wa,ix
	cp wa,52
	jr ge,L782
	ld wa,ix
	cp wa,65484
	jr gt,L781
L782:
	ld wa,iy
	cp wa,150
	jr uge,L783
	ld wa,0
	jr L773
L783:
	ld bc,ix
	cp bc,0
	jr le,L784
	ld wa,1
	jr L785
L784:
	ld wa,65535
L785:
	jr L773
L781:
	ld wa,iy
	ld xbc,(_track_seg)
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld iy,wa
L778:
	incb 1,(xsp+1)
L779:
	ld a,(xsp+1)
	cp a,6
	jr uge,L786
	ld wa,iy
	cp wa,1300
	jr ult,L776
L786:
L777:
	ld wa,0
	jr L773
L773:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function game_tick
_game_tick__0:
	push xiz
	lda xsp,(xsp-4)
	ld a,(_state__0)
	cp a,0
	jp nz,L873
	ld wa,12
	push xwa
	ld a,(_state_timer__0)
	push xwa
	call _title_blink__0
	lda xsp,(xsp+8)
	incb 1,(_state_timer__0)
	incw 1,(_title_frames__0)
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,12
	cp wa,0
	jr z,L874
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,8
	cp wa,0
	jr z,L875
	ld a,(_station__0)
	extz wa
	add wa,1
	and wa,3
	ld (_station__0),a
	jr L876
L875:
	ld a,(_station__0)
	extz wa
	add wa,4
	sub wa,1
	and wa,3
	ld (_station__0),a
L876:
	ldb (_save_dirty__0),1
	call _title_texts__0
	ld a,(_station__0)
	push xwa
	call _music_play
	lda xsp,(xsp+4)
L874:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,3
	cp wa,0
	jr z,L877
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,2
	cp wa,0
	jr z,L878
	ld a,(_difficulty)
	extz wa
	add wa,1
	and wa,3
	ld (_difficulty),a
	jr L879
L878:
	ld a,(_difficulty)
	extz wa
	add wa,4
	sub wa,1
	and wa,3
	ld (_difficulty),a
L879:
	ld a,(_difficulty)
	cp a,3
	jr nz,L880
	call _new_seed__0
L880:
	ldb (_save_dirty__0),1
	ld wa,0
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	call _title_texts__0
L877:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,32
	cp wa,0
	jr z,L881
	ld a,(_difficulty)
	cp a,3
	jr nz,L881
	call _new_seed__0
	ldb (_save_dirty__0),1
	ld wa,0
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	call _title_texts__0
L881:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,16
	cp wa,0
	jr z,L882
	call _title_leave__0
	call _new_game__0
	ldb (_state__0),1
	ldb (_state_timer__0),0
L882:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
	jp L883
L873:
	ld a,(_state__0)
	cp a,5
	jr nz,L884
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,16
	cp wa,0
	jr z,L885
	ld a,(_state_timer__0)
	cp a,30
	jr ule,L885
	ldb (_state__0),0
	ldb (_state_timer__0),0
	call _new_game__0
	call _title_screen__0
	ld a,(_station__0)
	push xwa
	call _music_play
	lda xsp,(xsp+4)
L885:
	ld a,(_state_timer__0)
	cp a,255
	jr uge,L886
	incb 1,(_state_timer__0)
L886:
	ld a,(_state_timer__0)
	cp a,30
	jr ule,L887
	ld wa,13
	push xwa
	ld a,(_state_timer__0)
	push xwa
	call _title_blink__0
	lda xsp,(xsp+8)
L887:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
	jr L888
L884:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,64
	cp wa,0
	jr z,L889
	ld c,(_paused__0)
	cp c,0
	jr nz,L890
	ld wa,1
	jr L891
L890:
	ld wa,0
L891:
	ld (_paused__0),a
	ld a,(_paused__0)
	cp a,0
	jr z,L892
	ld wa,0
	push xwa
	ld wa,0
	exts xwa
	push xwa
	ld xwa,_S0_20
	push xwa
	call _message__0
	lda xsp,(xsp+12)
	jr L893
L892:
	ld wa,1
	push xwa
	ld wa,0
	exts xwa
	push xwa
	ld wa,0
	exts xwa
	push xwa
	call _message__0
	lda xsp,(xsp+12)
L893:
L889:
L888:
L883:
	ld a,(_paused__0)
	cp a,0
	jr z,L894
	jp L872
L894:
	ld a,(_state__0)
	cp a,1
	jp nz,L895
	ld a,(_state_timer__0)
	extz wa
	extz xwa
	div xwa,30
	ld (xsp+0),a
	ld a,(_state_timer__0)
	extz wa
	extz xwa
	div xwa,30
	ld wa,qwa
	cp wa,0
	jr nz,L897
	ld a,(xsp+0)
	cp a,4
	jr uge,L897
	ld wa,0
	push xwa
	ld xwa,_cd__0_L896
	ld c,(xsp+4)
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _count_message__0
	lda xsp,(xsp+8)
	ld wa,0
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L897:
	incb 1,(_state_timer__0)
	ld a,(_state_timer__0)
	cp a,90
	jr ult,L898
	ldb (_state__0),2
	ld wa,30
	push xwa
	ld xwa,(_cd__0_L896+12)
	push xwa
	call _count_message__0
	lda xsp,(xsp+8)
	ld wa,1
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L898:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
L895:
	ld a,(_state__0)
	cp a,2
	jr z,L900
	ld a,(_state__0)
	cp a,3
	jr z,L900
	ld a,(_state__0)
	cp a,4
	jp nz,L899
L900:
	ld a,(_state__0)
	cp a,2
	jr nz,L902
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L901
L902:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
L901:
	call _drive__0
	call _advance__0
	ld a,(_state__0)
	cp a,2
	jp nz,L903
	ld xwa,(_score__0)
	ld c,(_speed__0)
	extz bc
	sra 1,bc
	exts xbc
	add xwa,xbc
	ld (_score__0),xwa
	ld a,(_speed__0)
	extz wa
	sra 1,wa
	push xwa
	call _hud_score_add
	lda xsp,(xsp+4)
	ld a,(_sec_acc__0)
	add a,(xsp+12)
	ld (_sec_acc__0),a
	jr L906
L904:
	ld a,(_sec_acc__0)
	sub a,60
	ld (_sec_acc__0),a
	ld a,(_time_left__0)
	cp a,0
	jr z,L907
	decb 1,(_time_left__0)
L907:
	ld a,(_time_left__0)
	cp a,0
	jr z,L908
	ld a,(_time_left__0)
	cp a,10
	jr ugt,L908
	ld wa,5
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L908:
L906:
	ld a,(_sec_acc__0)
	cp a,60
	jr uge,L904
L905:
	ld a,(_time_left__0)
	cp a,0
	jr nz,L909
	ldb (_state__0),3
	ldb (_state_timer__0),0
	ld wa,0
	push xwa
	ld wa,0
	exts xwa
	push xwa
	ld xwa,_S0_21
	push xwa
	call _message__0
	lda xsp,(xsp+12)
	ld wa,5
	push xwa
	call _music_play
	lda xsp,(xsp+4)
	ld wa,3
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
L909:
L903:
	ld wa,(_course_pos__0)
	push xwa
	call _course_fork_zone
	lda xsp,(xsp+4)
	ld (xsp+0),a
	ld a,(xsp+0)
	cp a,0
	jp z,L910
	call _course_is_last_stage
	cp a,0
	jp nz,L910
	ld a,(_last_fork_zone__0)
	cp a,0
	jr nz,L911
	ld wa,1
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	ld xwa,_S0_22
	push xwa
	ld wa,3
	push xwa
	ld wa,1
	push xwa
	ld wa,1
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
L911:
	ld a,(_fork_choice)
	cp a,0
	jr nz,L912
	ld wa,(_course_pos__0)
	add wa,850
	cp wa,(_leg_len)
	jr ult,L912
	ld bc,(_car_lat__0)
	cp bc,0
	jr le,L913
	ld wa,1
	jr L914
L913:
	ld wa,0
L914:
	push xwa
	call _course_decide
	lda xsp,(xsp+4)
	ld wa,3
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld a,(_fork_choice)
	cp a,2
	jr nz,L915
	ld xwa,_S0_23
	push xwa
	ld wa,3
	push xwa
	ld wa,12
	push xwa
	ld wa,1
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	jr L916
L915:
	ld xwa,_S0_24
	push xwa
	ld wa,3
	push xwa
	ld wa,1
	push xwa
	ld wa,1
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
L916:
L912:
	jp L917
L910:
	ld a,(xsp+0)
	cp a,0
	jr z,L918
	call _course_is_last_stage
	cp a,0
	jr z,L918
	ld a,(_last_fork_zone__0)
	cp a,0
	jr nz,L919
	ld xwa,_S0_25
	push xwa
	ld wa,3
	push xwa
	ld wa,5
	push xwa
	ld wa,1
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
L919:
	ld wa,5
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L920
L918:
	ld a,(_cur_stage)
	cp a,0
	jr nz,L921
	ld wa,(_course_pos__0)
	cp wa,900
	jr uge,L921
	ld wa,5
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L922
L921:
	ld wa,(_course_pos__0)
	push xwa
	call _course_start_zone
	lda xsp,(xsp+4)
	cp a,0
	jr z,L923
	ld wa,2
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L924
L923:
	call _sharp_ahead__0
	ld (xsp+1),a
	ld c,(xsp+1)
	cp c,0
	jr le,L925
	ld wa,3
	jr L926
L925:
	ld c,(xsp+1)
	cp c,0
	jr ge,L927
	ld wa,4
	jr L928
L927:
	ld wa,0
L928:
L926:
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
L924:
L922:
L920:
L917:
	ld a,(xsp+0)
	ld (_last_fork_zone__0),a
	ld a,(_goal_reached__0)
	cp a,0
	jr nz,L929
	ld wa,(_course_pos__0)
	cp wa,(_leg_len)
	jr ult,L929
	ldb (_last_fork_zone__0),0
	call _leg_end__0
L929:
	ld a,(_speed__0)
	push xwa
	call _id_scenery_advance
	lda xsp,(xsp+4)
	ld a,(_state__0)
	cp a,2
	jp nz,L930
	ld a,(_crash_timer__0)
	cp a,0
	jp nz,L930
	ld a,(_speed__0)
	push xwa
	ld wa,(_car_lat__0)
	push xwa
	call _traffic_collide
	lda xsp,(xsp+8)
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,0
	jr nz,L931
	ld wa,147
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_scenery_hit
	lda xsp,(xsp+8)
	cp a,0
	jr z,L932
	ld a,(_speed__0)
	cp a,110
	jr ule,L933
	incb 1,(_dbg_scn)
	ldb (xsp+1),1
	jr L934
L933:
	ld wa,48
	ld (xsp+2),a
	ld a,(_speed__0)
	extz wa
	sra 1,wa
	ld (xsp+3),a
	ld a,(xsp+2)
	cp a,(xsp+3)
	jr ule,L935
	ld a,(xsp+3)
	ld (xsp+2),a
L935:
	ld c,(_speed__0)
	cp c,(xsp+2)
	jr ule,L936
	ld a,(_speed__0)
	sub a,(xsp+2)
	extz wa
	jr L937
L936:
	ld wa,0
L937:
	ld (_speed__0),a
	ld wa,4
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L934:
L932:
L931:
	ld a,(xsp+1)
	cp a,0
	jr z,L938
	ld a,(_speed__0)
	cp a,110
	jr ule,L939
	ldb (_crash_timer__0),90
	incb 1,(_dbg_crashes)
	ld wa,3
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	jr L940
L939:
	ld a,(_speed__0)
	extz wa
	sra 1,wa
	ld (_speed__0),a
	ld wa,4
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L940:
L938:
L930:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L941
	decb 1,(_crash_timer__0)
	ld c,(_speed__0)
	cp c,12
	jr ule,L942
	ld a,(_speed__0)
	sub a,12
	extz wa
	jr L943
L942:
	ld wa,0
L943:
	ld (_speed__0),a
	ld a,(_crash_timer__0)
	cp a,0
	jr nz,L944
	ld wa,(_car_lat__0)
	exts xwa
	divs xwa,2
	ld (_car_lat__0),wa
	ldb (_speed__0),0
	ldb (_gear__0),0
L944:
L941:
	ld c,(_state__0)
	cp c,2
	jr nz,L945
	push xwa
	ld wa,(_course_pos__0)
	push xwa
	call _course_fork_zone
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp c,0
	jr nz,L945
	ld wa,1
	jr L946
L945:
	ld wa,0
L946:
	push xwa
	ld a,(_speed__0)
	push xwa
	call _traffic_update
	lda xsp,(xsp+8)
	ld a,(_state__0)
	cp a,3
	jr nz,L947
	incb 1,(_state_timer__0)
	ld a,(_speed__0)
	cp a,0
	jr nz,L948
	ld a,(_state_timer__0)
	cp a,60
	jr ule,L948
	ldb (_state__0),5
	ldb (_state_timer__0),0
	call _result_screen__0
L948:
	jr L949
L947:
	ld a,(_state__0)
	cp a,4
	jr nz,L950
	incb 1,(_state_timer__0)
	ld a,(_state_timer__0)
	cp a,1
	jr nz,L951
	ld xwa,(_score__0)
	ld c,(_time_left__0)
	extz bc
	muls xbc,20000
	add xwa,xbc
	ld (_score__0),xwa
	ld izl,0
	jr L955
L952:
	ld wa,20000
	push xwa
	call _hud_score_add
	lda xsp,(xsp+4)
L954:
	inc 1,izl
L955:
	ld a,izl
	cp a,(_time_left__0)
	jr ult,L952
L953:
L951:
	ld a,(_speed__0)
	cp a,0
	jr nz,L956
	ld a,(_state_timer__0)
	cp a,60
	jr ule,L956
	ldb (_state__0),5
	ldb (_state_timer__0),0
	call _result_screen__0
L956:
L950:
L949:
L899:
L872:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function main
_main:
	push xiz
	lda xsp,(xsp-14)
	call _ngpc_init
	call _audio_init
	call _hud_init
	ld wa,152
	push xwa
	ld wa,160
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_viewport
	lda xsp,(xsp+16)
	ld wa,0
	push xwa
	call _ngpc_gfx_clear
	lda xsp,(xsp+4)
	ld wa,1
	push xwa
	call _ngpc_gfx_clear
	lda xsp,(xsp+4)
	call _ngpc_sprite_hide_all
	call _id_road_init
	call _id_road_dma_pause
	ld wa,128
	push xwa
	call _id_road_char_count
	ld xbc,xwa
	pop xwa
	add wa,bc
	ld (xsp+0),wa
	ld wa,(xsp+0)
	ld (xsp+4),wa
	ld wa,(xsp+0)
	ld (_pano_tiles_at__0),wa
	ld wa,(xsp+0)
	add wa,114
	ld (xsp+0),wa
	ld wa,0
	push xwa
	call _id_car_select
	lda xsp,(xsp+4)
	ld wa,0
	push xwa
	ld wa,(xsp+4)
	push xwa
	call _id_car_init
	lda xsp,(xsp+8)
	ld wa,(xsp+0)
	push xwa
	ld wa,0
	push xwa
	call _id_car_char_count
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	add wa,bc
	ld (xsp+0),wa
	ld wa,(xsp+0)
	ld (_trf_tiles_at__0),wa
	ld wa,(xsp+0)
	push xwa
	call _traffic_init
	lda xsp,(xsp+4)
	ld wa,(xsp+0)
	add wa,(_gfx_traffic_tiles_count)
	ld (xsp+0),wa
	ld wa,(xsp+0)
	ld (xsp+6),wa
	ld wa,512
	push xwa
	ld wa,(xsp+10)
	push xwa
	ld wa,(xsp+12)
	push xwa
	call _theme_init_tiles
	lda xsp,(xsp+12)
	call _smoke_init__0
	call _banner_init
	ld wa,147
	push xwa
	call _id_road_half_at
	lda xsp,(xsp+4)
	extz wa
	push xwa
	ld wa,147
	push xwa
	call _id_road_half_at
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	extz bc
	extz xbc
	div xbc,9
	add wa,bc
	sll 4,wa
	ld (_road_edge__0),wa
	ld wa,147
	push xwa
	call _id_road_half_at
	lda xsp,(xsp+4)
	extz wa
	sll 4,wa
	add wa,384
	ld (_lat_limit__0),wa
	ldw (xsp+2),65530
	jr L1007
L1004:
	ld bc,(xsp+2)
	cp bc,0
	jr le,L1008
	call _id_road_grade_hi
	exts wa
	jr L1009
L1008:
	call _id_road_grade_lo
	exts wa
	neg wa
L1009:
	ld (xsp+8),wa
	ld wa,(xsp+2)
	mul xwa,(xsp+8)
	exts xwa
	divs xwa,6
	ld xbc,_grade_tab__0
	ld e,(xsp+2)
	add e,6
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1006:
	incw 1,(xsp+2)
L1007:
	ld wa,(xsp+2)
	cp wa,6
	jr le,L1004
L1005:
	ld wa,147
	push xwa
	call _traffic_set_car_line
	lda xsp,(xsp+4)
	call _save_load__0
	call _new_game__0
	ldb (_state__0),0
	call _title_screen__0
	call _id_road_dma_resume
	ld a,(_station__0)
	push xwa
	call _music_play
	lda xsp,(xsp+4)
	ld a,(_g_vb_counter)
	ld (_pace_prev__0),a
	ld (_clock_prev__0),a
L1010:
	jr L1016
L1014:
	call _ngpc_vsync
L1016:
	ld a,(_g_vb_counter)
	sub a,(_pace_prev__0)
	cp a,2
	jr ult,L1014
L1015:
	ld a,(_g_vb_counter)
	ld (xsp+8),a
	ld a,(xsp+8)
	sub a,(_pace_prev__0)
	ld (xsp+9),a
	ld a,(xsp+9)
	extz wa
	sra 1,wa
	ld (xsp+10),a
	ld a,(xsp+10)
	cp a,3
	jr ule,L1017
	ldb (xsp+10),3
	ld a,(xsp+8)
	ld c,(xsp+9)
	and c,1
	sub a,c
	ld (_pace_prev__0),a
	jr L1018
L1017:
	ld a,(_pace_prev__0)
	extz wa
	ld c,(xsp+10)
	extz bc
	sll 1,bc
	extz bc
	add wa,bc
	ld (_pace_prev__0),a
L1018:
	call _ngpc_input_update
	call _audio_update
	incw 1,(_dbg_updates)
	ld a,(xsp+8)
	ld (_clock_prev__0),a
	ld izl,0
	jr L1022
L1019:
	ld wa,2
	push xwa
	call _game_tick__0
	lda xsp,(xsp+4)
	ld a,izl
	cp a,0
	jr nz,L1023
	ldb (_ngpc_pad_pressed),0
L1023:
L1021:
	inc 1,izl
L1022:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L1019
L1020:
	ld a,(_state__0)
	cp a,0
	jr nz,L1024
	ld a,(_state_timer__0)
	push xwa
	call _title_car__0
	lda xsp,(xsp+4)
	call _player_engine_off
	jp L1012
L1024:
	call _render_road__0
	call _tick_flash__0
	call _tick_message__0
	ld a,(_state__0)
	cp a,0
	jr z,L1025
	ld a,(_state__0)
	cp a,5
	jr z,L1025
	call _id_scenery_draw
	call _traffic_draw
L1025:
	ld a,(_state__0)
	cp a,1
	jr z,L1027
	ld a,(_state__0)
	cp a,2
	jr nz,L1026
	ld a,(_cur_stage)
	cp a,0
	jr nz,L1026
	ld wa,(_course_pos__0)
	cp wa,220
	jr uge,L1026
L1027:
	ld xwa,_S0_30
	push xwa
	ld wa,0
	push xwa
	ld wa,120
	ld bc,(_course_pos__0)
	sub wa,bc
	push xwa
	call _banner_show
	lda xsp,(xsp+12)
	jr L1028
L1026:
	ld a,(_state__0)
	cp a,2
	jr z,L1030
	ld a,(_state__0)
	cp a,4
	jr z,L1030
	ld a,(_state__0)
	cp a,3
	jr nz,L1029
L1030:
	call _course_is_last_stage
	cp a,0
	jr z,L1029
	ld wa,(_course_pos__0)
	ld bc,(_leg_len)
	sub bc,1400
	cp wa,bc
	jr le,L1029
	ld xwa,_S0_31
	push xwa
	ld wa,1
	push xwa
	ld wa,(_leg_len)
	ld bc,(_course_pos__0)
	sub wa,bc
	push xwa
	call _banner_show
	lda xsp,(xsp+12)
	jr L1031
L1029:
	call _banner_hide
L1031:
L1028:
	ld a,(_state__0)
	cp a,5
	jr nz,L1032
	ld a,(_goal_reached__0)
	cp a,0
	jr z,L1032
	call _trophy_draw__0
	call _ending_tick
L1032:
	ld a,(_state__0)
	cp a,2
	jr z,L1034
	ld a,(_state__0)
	cp a,1
	jr z,L1034
	ld a,(_state__0)
	cp a,3
	jr z,L1034
	ld a,(_state__0)
	cp a,4
	jr nz,L1033
L1034:
	ld wa,(_course_pos__0)
	extz xwa
	ld bc,(_leg_len)
	extz xbc
	div xbc,10
	add bc,1
	div xwa,bc
	ld (xsp+12),wa
	ld a,(_cur_stage)
	push xwa
	ld wa,(xsp+16)
	push xwa
	ld c,(_gear__0)
	cp c,0
	jr nz,L1035
	ld c,(_speed__0)
	cp c,123
	jr ult,L1035
	ld c,(_g_vb_counter)
	extz bc
	and bc,8
	cp bc,0
	jr z,L1035
	ld wa,2
	jr L1036
L1035:
	ld a,(_gear__0)
	extz wa
L1036:
	push xwa
	ld a,(_speed__0)
	extz wa
	mul xwa,21
	srl 5,wa
	push xwa
	ld a,(_time_left__0)
	push xwa
	call _hud_race
	lda xsp,(xsp+20)
L1033:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L1037
	ld a,(_crash_timer__0)
	extz wa
	and wa,2
	cp wa,0
	jr z,L1037
	ld wa,2
	push xwa
	ld c,(_crash_timer__0)
	extz bc
	and bc,4
	cp bc,0
	jr z,L1038
	ld wa,1
	jr L1039
L1038:
	ld wa,65535
L1039:
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_car_draw
	lda xsp,(xsp+12)
	jr L1040
L1037:
	ld c,(_offroad__0)
	cp c,0
	jr z,L1041
	ld c,(_speed__0)
	cp c,20
	jr ule,L1041
	ld wa,1
	jr L1042
L1041:
	ld wa,0
L1042:
	push xwa
	ld a,(_car_lean__0)
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_car_draw
	lda xsp,(xsp+12)
L1040:
	ld c,(_skid__0)
	cp c,0
	jr z,L1043
	ld c,(_crash_timer__0)
	cp c,0
	jr nz,L1043
	ld c,(_state__0)
	cp c,2
	jr nz,L1043
	ld wa,1
	jr L1044
L1043:
	ld wa,0
L1044:
	push xwa
	call _smoke_draw__0
	lda xsp,(xsp+4)
	ld a,(_offroad__0)
	cp a,0
	jr z,L1045
	ld a,(_state__0)
	cp a,2
	jr nz,L1045
	incb 1,(_dbg_off)
L1045:
	ld a,(_state__0)
	cp a,2
	jr z,L1047
	ld a,(_state__0)
	cp a,1
	jr z,L1047
	ld a,(_state__0)
	cp a,3
	jr z,L1047
	ld a,(_state__0)
	cp a,4
	jr nz,L1046
L1047:
	call _engine_sound__0
	jr L1048
L1046:
	call _player_engine_off
L1048:
L1012:
L1013:
	jp L1010
L1011:
L1003:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function player_engine
_player_engine:
	ld wa,(xsp+4)
	ld (_eng_div__9),wa
	ld a,(xsp+8)
	ld (_eng_attn__9),a
	ldb (_eng_on__9),1
L1050:
	ret

; function player_engine_off
_player_engine_off:
	ldb (_eng_on__9),0
L1052:
	ret

; function player_init
_player_init:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,28672
	ld xix,xwa
	ldw (0B8h),43690
	ld izl,0
	jr L1066
L1063:
	ld xwa,_z80drv__9
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld xbc,xix
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1065:
	inc 1,izl
L1066:
	ld a,izl
	cp a,65
	jr ult,L1063
L1064:
	ldw (0B8h),21845
	ld izl,0
	jr L1070
L1067:
	ld wa,0
	ld xbc,_want_div__9
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,15
	ld xbc,_want_attn__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,65535
	ld xbc,_sent_div__9
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,255
	ld xbc,_sent_attn__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_sfx_frames__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_voice__9
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+15),a
L1069:
	inc 1,izl
L1070:
	ld a,izl
	cp a,4
	jr ult,L1067
L1068:
	ldb (_playing__9),0
	ld a,(_g_vb_counter)
	ld (_last_vbl__9),a
L1062:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function player_start
_player_start:
	push xiz
	lda xsp,(xsp-18)
	ld xwa,(xsp+26)
	ld (xsp+0),xwa
	ld xwa,(xsp+30)
	ld (xsp+4),xwa
	ld xwa,(xsp+34)
	ld (xsp+8),xwa
	ld xwa,(xsp+38)
	ld (xsp+12),xwa
	ld izl,0
	jp L1080
L1077:
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	ld xbc,_voice__9
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc),xwa
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	ld xbc,_voice__9
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+4),xwa
	ld wa,0
	ld xbc,_voice__9
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+8),wa
	ld a,2
	ld xbc,_voice__9
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+13),a
	ld a,0
	ld xbc,_voice__9
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+14),a
	ld a,0
	ld xbc,_voice__9
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+15),a
	ld a,0
	ld xbc,_voice__9
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+12),a
	ld a,0
	ld xbc,_voice__9
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+16),a
L1079:
	inc 1,izl
L1080:
	ld a,izl
	cp a,4
	jp ult,L1077
L1078:
	ldb (_playing__9),1
	ld a,(_g_vb_counter)
	ld (_last_vbl__9),a
L1076:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function player_stop
_player_stop:
	push xiz
	lda xsp,(xsp-2)
	ldb (_playing__9),0
	ld izl,0
	jr L1090
L1087:
	ld a,0
	ld xbc,_voice__9
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+15),a
L1089:
	inc 1,izl
L1090:
	ld a,izl
	cp a,4
	jr ult,L1087
L1088:
L1086:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function voice_events
_voice_events__9:
	push xiz
	lda xsp,(xsp-2)
	ld xiz,(xsp+10)
	ld wa,0
	ld (xsp+0),a
	jp L1107
L1105:
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld ixl,a
	incb 1,(xsp+0)
	ld a,ixl
	cp a,0
	jr nz,L1108
	ld xwa,(xiz+4)
	ld (xiz),xwa
	jp L1107
L1108:
	ld a,ixl
	cp a,240
	jr nz,L1109
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld (xiz+13),a
	jp L1107
L1109:
	ld a,ixl
	cp a,244
	jr nz,L1110
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld (xiz+14),a
	ld a,(xiz+14)
	cp a,17
	jr ule,L1111
	ldb (xiz+14),0
L1111:
	jr L1107
L1110:
	ld a,ixl
	cp a,255
	jr nz,L1112
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	extz wa
	ld (xiz+8),wa
	ldb (xiz+15),0
	jr L1107
L1112:
	ld a,ixl
	cp a,240
	jr ult,L1113
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	jr L1107
L1113:
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	extz wa
	ld (xiz+8),wa
	ldb (xiz+15),1
	ldb (xiz+12),0
	ld a,(xsp+14)
	cp a,3
	jr nz,L1114
	ld a,ixl
	extz wa
	sub wa,1
	and wa,7
	ld (xiz+10),wa
	ldb (xiz+16),1
	jr L1115
L1114:
	push xix
	ld a,ixl
	push xwa
	call _note_div
	lda xsp,(xsp+4)
	pop xix
	ld (xiz+10),wa
L1115:
L1107:
	ld wa,(xiz+8)
	cp wa,0
	jr nz,L1116
	ld a,(xsp+0)
	cp a,32
	jp ult,L1105
L1116:
L1106:
L1104:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function note_div
_note_div:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	sub a,1
	ld izl,a
	ld a,izl
	cp a,50
	jr ule,L1120
	ld izl,50
L1120:
	ld xwa,_NOTE_TABLE
	ld c,izl
	extz bc
	sll 1,bc
	add bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	and wa,63
	sll 4,wa
	ld xbc,_NOTE_TABLE
	ld e,izl
	extz de
	sll 1,de
	extz xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	and bc,15
	or wa,bc
	jr L1119
L1119:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function flush
_flush__9:
	push xiz
	lda xsp,(xsp-10)
	ld wa,0
	ld (xsp+0),a
	ld xwa,28676
	ld xiy,xwa
	ld a,(07003h)
	cp a,0
	jr z,L1137
	jp L1136
L1137:
	ld izl,0
	jp L1141
L1138:
	ld xwa,_want_div__9
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld ix,wa
	ld xwa,_want_attn__9
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+8),a
	ld a,izl
	cp a,3
	jr uge,L1142
	ld wa,ix
	ld xbc,_sent_div__9
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L1143
	ld a,(xsp+8)
	ld xbc,_sent_attn__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr nz,L1143
	jp L1140
L1143:
	ld a,128
	ld c,izl
	sll 5,c
	or a,c
	ld c,ixl
	and c,15
	or a,c
	ld (xiy),a
	ld wa,ix
	srl 4,wa
	and wa,63
	ld (xiy+1),a
	ld a,144
	ld c,izl
	sll 5,c
	or a,c
	ld c,(xsp+8)
	and c,15
	or a,c
	ld (xiy+2),a
	jr L1144
L1142:
	ld a,(_noise_trig__9)
	cp a,0
	jr nz,L1145
	ld wa,ix
	cp wa,(_sent_div__9+6)
	jr nz,L1145
	ld a,(xsp+8)
	cp a,(_sent_attn__9+3)
	jr nz,L1145
	jp L1140
L1145:
	ld a,(_noise_trig__9)
	cp a,0
	jr nz,L1147
	ld wa,ix
	cp wa,(_sent_div__9+6)
	jr z,L1146
L1147:
	ld a,224
	ld c,ixl
	and c,7
	or a,c
	ld (xiy),a
	ld a,224
	ld c,ixl
	and c,7
	or a,c
	ld (xiy+1),a
	jr L1148
L1146:
	ld a,240
	ld c,(xsp+8)
	and c,15
	or a,c
	ld (xiy),a
	ld a,240
	ld c,(xsp+8)
	and c,15
	or a,c
	ld (xiy+1),a
L1148:
	ld a,240
	ld c,(xsp+8)
	and c,15
	or a,c
	ld (xiy+2),a
	ldb (_noise_trig__9),0
L1144:
	ld wa,ix
	ld xbc,_sent_div__9
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+8)
	ld xbc,_sent_attn__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld bc,3
	exts xbc
	ld xwa,xiy
	add xwa,xbc
	ld xiy,xwa
	incb 1,(xsp+0)
L1140:
	inc 1,izl
L1141:
	ld a,izl
	cp a,4
	jr uge,L1149
	ld a,(xsp+0)
	cp a,5
	jp ult,L1138
L1149:
L1139:
	ld a,(xsp+0)
	cp a,0
	jr z,L1150
	ld a,(xsp+0)
	ld (07003h),a
L1150:
L1136:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function player_update
_player_update:
	push xiz
	lda xsp,(xsp-16)
	ld a,(_g_vb_counter)
	ld (xsp+0),a
	ld a,(xsp+0)
	sub a,(_last_vbl__9)
	ld iyl,a
	ld a,(xsp+0)
	ld (_last_vbl__9),a
	ld a,iyl
	cp a,8
	jr ule,L1173
	ld iyl,8
L1173:
	ld izl,0
	jp L1177
L1174:
	ld wa,15
	ld (xsp+3),a
	ld xwa,_want_div__9
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+4),wa
	ld a,(_playing__9)
	cp a,0
	jp z,L1178
	ld xwa,_voice__9
	ld c,izl
	extz bc
	muls xbc,18
	add xwa,xbc
	lda xwa,(xwa)
	ld xix,xwa
	ld wa,(xix+8)
	ld c,iyl
	extz bc
	cp wa,bc
	jr ule,L1179
	ld wa,(xix+8)
	ld c,iyl
	extz bc
	sub wa,bc
	ld (xix+8),wa
	jr L1180
L1179:
	ldw (xix+8),0
	push xix
	push xiy
	ld a,izl
	push xwa
	ld xwa,xix
	push xwa
	call _voice_events__9
	lda xsp,(xsp+8)
	pop xiy
	pop xix
L1180:
	ld a,(xix+12)
	cp a,250
	jr uge,L1181
	ld a,(xix+12)
	add a,iyl
	ld (xix+12),a
L1181:
	ld a,(xix+15)
	cp a,0
	jr z,L1182
	ld xwa,_inst_tab__9
	ld c,(xix+14)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+10),xwa
	ld a,(xix+12)
	extz wa
	exts xwa
	ld xbc,(xsp+10)
	ld c,(xbc)
	extz bc
	divs xwa,bc
	ld (xsp+14),a
	ld a,(xsp+14)
	ld xbc,(xsp+10)
	ld c,(xbc+1)
	cp a,c
	jr ule,L1183
	ld xwa,(xsp+10)
	ld a,(xwa+1)
	ld (xsp+14),a
L1183:
	ld a,(xix+13)
	add a,(xsp+14)
	ld (xsp+3),a
	ld a,(xsp+3)
	cp a,15
	jr ule,L1184
	ldb (xsp+3),15
L1184:
	ld wa,(xix+10)
	ld (xsp+4),wa
	ld a,izl
	cp a,3
	jr nz,L1185
	ld a,(xix+16)
	cp a,0
	jr z,L1185
	ldb (xix+16),0
	ldb (_noise_trig__9),1
L1185:
L1182:
L1178:
	ld a,izl
	cp a,2
	jr nz,L1186
	ld a,(_eng_on__9)
	cp a,0
	jr z,L1186
	ld wa,(_eng_div__9)
	ld (xsp+4),wa
	ld a,(_eng_attn__9)
	ld (xsp+3),a
L1186:
	ld xwa,_sfx_frames__9
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L1187
	ld xwa,_sfx_attn__9
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+6),a
	ld xwa,_sfx_decay__9
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L1188
	ld xwa,_sfx_age__9
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	exts xwa
	ld xbc,_sfx_decay__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	divs xwa,bc
	ld (xsp+7),a
	ld a,(xsp+6)
	add a,(xsp+7)
	ld (xsp+6),a
	ld a,(xsp+6)
	cp a,15
	jr ule,L1189
	ldb (xsp+6),15
L1189:
L1188:
	ld a,(xsp+6)
	ld (xsp+3),a
	ld xwa,_sfx_div__9
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+4),wa
	ld xwa,_sfx_div__9
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_sfx_step__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	exts bc
	ld e,iyl
	extz de
	mul xbc,de
	add wa,bc
	ld xbc,_sfx_div__9
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_sfx_age__9
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,250
	jr uge,L1190
	ld xwa,_sfx_age__9
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	add a,iyl
	ld xbc,_sfx_age__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1190:
	ld xbc,_sfx_frames__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp c,iyl
	jr ule,L1191
	ld xwa,_sfx_frames__9
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	sub a,iyl
	extz wa
	jr L1192
L1191:
	ld wa,0
L1192:
	ld xbc,_sfx_frames__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1187:
	ld wa,(xsp+4)
	ld xbc,_want_div__9
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+3)
	ld xbc,_want_attn__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1176:
	inc 1,izl
L1177:
	ld a,izl
	cp a,4
	jp ult,L1174
L1175:
	push xix
	push xiy
	call _flush__9
	pop xiy
	pop xix
L1172:
	lda xsp,(xsp+16)
	pop xiz
	ret

; function player_sfx_tone
_player_sfx_tone:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld wa,(xsp+12)
	ld xbc,_sfx_div__9
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+16)
	ld xbc,_sfx_step__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+20)
	ld xbc,_sfx_attn__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+24)
	ld xbc,_sfx_frames__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+28)
	ld xbc,_sfx_decay__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_sfx_age__9
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1194:
	pop xiz
	ret

; function player_sfx_noise
_player_sfx_noise:
	ld a,(xsp+4)
	extz wa
	ld (_sfx_div__9+6),wa
	ldb (_sfx_step__9+3),0
	ld a,(xsp+8)
	ld (_sfx_attn__9+3),a
	ld a,(xsp+12)
	ld (_sfx_frames__9+3),a
	ld a,(xsp+16)
	ld (_sfx_decay__9+3),a
	ldb (_sfx_age__9+3),0
	ldb (_noise_trig__9),1
L1196:
	ret

; function banner_init
_banner_init:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,41520
	ld xix,xwa
	ld izl,0
	jr L1206
L1203:
	ld xwa,_gfx_banner_tiles
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,xix
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1205:
	inc 1,izl
L1206:
	ld a,izl
	cp a,40
	jr ult,L1203
L1204:
	push xix
	ld wa,2
	push xwa
	call _banner_style
	lda xsp,(xsp+4)
	pop xix
	push xix
	ld wa,147
	push xwa
	call _id_road_distance_at_line
	lda xsp,(xsp+4)
	pop xix
	ld (_car_d__10),wa
	ldb (_b_on__10),0
L1202:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function banner_style
_banner_style:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,4
	jr ult,L1210
	ld izl,0
L1210:
	ld wa,4095
	push xwa
	ld xwa,_b_band__10
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_b_edge__10
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld wa,0
	push xwa
	ld wa,10
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ld xwa,_b_text__10
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld wa,2730
	push xwa
	ld xwa,_b_shad__10
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld wa,0
	push xwa
	ld wa,7
	push xwa
	ld wa,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
L1209:
	pop xiz
	ret

; function erase
_erase__10:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_b_on__10)
	cp a,0
	jr nz,L1222
	jr L1221
L1222:
	ld a,(_b_r0__10)
	ld ixl,a
	jr L1226
L1223:
	ld a,(_b_c0__10)
	ld izl,a
	jr L1230
L1227:
	ld wa,0
	ld xbc,36864
	ld e,ixl
	extz de
	sll 5,de
	ld l,izl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1229:
	inc 1,izl
L1230:
	ld a,izl
	cp a,(_b_c1__10)
	jr ule,L1227
L1228:
L1225:
	inc 1,ixl
L1226:
	ld a,ixl
	cp a,(_b_foot__10)
	jr ule,L1223
L1224:
	ldb (_b_on__10),0
L1221:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function banner_hide
_banner_hide:
	call _erase__10
	ld a,(_b_spr__10)
	cp a,0
	jr z,L1234
	ld a,64
	push xwa
	ld a,58
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	ldb (_b_spr__10),0
L1234:
L1233:
	ret

; function banner_dirty
_banner_dirty:
	ldb (_b_r0__10),255
L1236:
	ret

; function banner_active
_banner_active:
	ld a,(_b_on__10)
	jr L1238
L1238:
	ret

; function banner_show
_banner_show:
	push xiz
	lda xsp,(xsp-46)
	ld wa,(xsp+54)
	cp wa,0
	jr lt,L1293
	ld wa,(xsp+54)
	cp wa,1400
	jr le,L1292
L1293:
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1291
L1292:
	push xix
	push xiy
	ld wa,(xsp+62)
	add wa,(_car_d__10)
	push xwa
	call _id_road_line_at_distance
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (xsp+6),a
	ld a,(xsp+6)
	cp a,255
	jr nz,L1294
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1291
L1294:
	push xix
	push xiy
	lda xwa,(xsp+8)
	push xwa
	ld a,(xsp+18)
	push xwa
	call _id_road_sprite_sample
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	ld a,(xsp+4)
	extz wa
	ld (xsp+24),wa
	ld wa,(xsp+2)
	sub wa,(xsp+24)
	ld bc,(xsp+24)
	sra 2,bc
	sub wa,bc
	ld (xsp+18),wa
	ld wa,(xsp+18)
	sub wa,8
	ld bc,(xsp+24)
	sra 2,bc
	sub wa,bc
	ld (xsp+16),wa
	ld wa,(xsp+16)
	cp wa,16
	jr lt,L1296
	ld wa,(xsp+18)
	cp wa,151
	jr le,L1295
L1296:
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1291
L1295:
	ld wa,(xsp+0)
	sub wa,(xsp+24)
	sub wa,4
	ld (xsp+20),wa
	ld wa,(xsp+0)
	add wa,(xsp+24)
	add wa,4
	ld (xsp+22),wa
	ld wa,(xsp+16)
	sra 3,wa
	ld (xsp+7),a
	ld wa,(xsp+18)
	sra 3,wa
	ld iyl,a
	ld a,iyl
	cp a,(xsp+7)
	jr uge,L1297
	ld a,(xsp+7)
	ld iyl,a
L1297:
	ld wa,(xsp+2)
	sra 3,wa
	ld (xsp+11),a
	ld a,(xsp+11)
	cp a,18
	jr ule,L1298
	ldb (xsp+11),18
L1298:
	ld bc,(xsp+20)
	cp bc,0
	jr ge,L1299
	ld wa,0
	jr L1300
L1299:
	ld bc,(xsp+20)
	sra 3,bc
	cp bc,19
	jr le,L1301
	ld wa,19
	jr L1302
L1301:
	ld wa,(xsp+20)
	sra 3,wa
L1302:
L1300:
	ld (xsp+9),a
	ld bc,(xsp+22)
	cp bc,0
	jr ge,L1303
	ld wa,0
	jr L1304
L1303:
	ld bc,(xsp+22)
	sra 3,bc
	cp bc,19
	jr le,L1305
	ld wa,19
	jr L1306
L1305:
	ld wa,(xsp+22)
	sra 3,wa
L1306:
L1304:
	ld (xsp+10),a
	ld a,(_b_on__10)
	cp a,0
	jr z,L1308
	ld a,(xsp+7)
	cp a,(_b_r0__10)
	jr nz,L1308
	ld a,iyl
	cp a,(_b_r1__10)
	jr nz,L1308
	ld a,(xsp+9)
	cp a,(_b_c0__10)
	jr nz,L1308
	ld a,(xsp+10)
	cp a,(_b_c1__10)
	jr nz,L1308
	ld a,(xsp+11)
	cp a,(_b_foot__10)
	jp z,L1307
L1308:
	push xix
	push xiy
	call _erase__10
	pop xiy
	pop xix
	ld a,(xsp+7)
	ld izl,a
	jp L1312
L1309:
	ld a,(xsp+9)
	ld ixl,a
	jr L1316
L1313:
	ld wa,36
	ld (xsp+26),wa
	ld a,(xsp+58)
	cp a,0
	jr z,L1317
	ld a,ixl
	cp a,(xsp+9)
	jr z,L1318
	ld a,ixl
	cp a,(xsp+10)
	jr nz,L1317
L1318:
	ldw (xsp+26),42
	jr L1319
L1317:
	ld a,izl
	cp a,(xsp+7)
	jr nz,L1320
	ld a,iyl
	cp a,(xsp+7)
	jr ule,L1320
	ldw (xsp+26),35
	jr L1321
L1320:
	ld a,izl
	cp a,iyl
	jr nz,L1322
	ld a,iyl
	cp a,(xsp+7)
	jr ule,L1322
	ldw (xsp+26),37
L1322:
L1321:
L1319:
	ld wa,(xsp+26)
	or wa,5120
	ld xbc,36864
	ld e,izl
	extz de
	sll 5,de
	ld l,ixl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1315:
	inc 1,ixl
L1316:
	ld a,ixl
	cp a,(xsp+10)
	jr ule,L1313
L1314:
L1311:
	inc 1,izl
L1312:
	ld a,izl
	cp a,iyl
	jp ule,L1309
L1310:
	ld a,iyl
	add a,1
	ld izl,a
	jr L1326
L1323:
	ld wa,(xsp+20)
	cp wa,0
	jr lt,L1327
	ld wa,5158
	ld xbc,36864
	ld e,izl
	extz de
	sll 5,de
	ld l,(xsp+9)
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1327:
	ld wa,(xsp+22)
	cp wa,160
	jr ge,L1328
	ld wa,5158
	ld xbc,36864
	ld e,izl
	extz de
	sll 5,de
	ld l,(xsp+10)
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1328:
L1325:
	inc 1,izl
L1326:
	ld a,izl
	cp a,(xsp+11)
	jr ule,L1323
L1324:
	ldb (_b_on__10),1
	ld a,(xsp+7)
	ld (_b_r0__10),a
	ld a,iyl
	ld (_b_r1__10),a
	ld a,(xsp+9)
	ld (_b_c0__10),a
	ld a,(xsp+10)
	ld (_b_c1__10),a
	ld a,(xsp+11)
	ld (_b_foot__10),a
L1307:
	ldb (xsp+14),0
	jr L1331
L1329:
	incb 1,(xsp+14)
L1331:
	ld xwa,(xsp+62)
	ld c,(xsp+14)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L1332
	ld a,(xsp+14)
	cp a,6
	jr ult,L1329
L1332:
L1330:
	ld wa,2
	mul xwa,(xsp+24)
	add wa,8
	ld c,(xsp+14)
	extz bc
	sll 3,bc
	cp wa,bc
	jr ge,L1333
	ldb (xsp+14),0
L1333:
	ld wa,8
	ld bc,(xsp+24)
	sra 4,bc
	add wa,bc
	ld (xsp+26),wa
	ld wa,(xsp+0)
	ld bc,(xsp+26)
	ld e,(xsp+14)
	extz de
	mul xbc,de
	exts xbc
	divs xbc,2
	sub wa,bc
	ld bc,(xsp+26)
	sub bc,8
	exts xbc
	divs xbc,2
	add wa,bc
	ld (xsp+28),wa
	ld a,(xsp+7)
	extz wa
	ld c,iyl
	extz bc
	add wa,bc
	sll 3,wa
	add wa,8
	srl 1,wa
	sub wa,4
	ld (xsp+30),a
	ldb (xsp+15),0
	jp L1337
L1334:
	ld wa,(xsp+28)
	ld bc,(xsp+26)
	ld e,(xsp+15)
	extz de
	mul xbc,de
	add wa,bc
	ld (xsp+32),wa
	ld a,58
	add a,(xsp+15)
	ld (xsp+34),a
	ld wa,(xsp+32)
	cp wa,65529
	jr lt,L1339
	ld wa,(xsp+32)
	cp wa,159
	jr le,L1338
L1339:
	push xix
	push xiy
	ld a,(xsp+42)
	add a,1
	push xwa
	ld a,(xsp+46)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	jp L1336
L1338:
L1340:
	ld a,(xsp+34)
	ld (xsp+35),a
	ld a,(xsp+32)
	ld (xsp+36),a
	ld a,(xsp+30)
	ld (xsp+37),a
	ld xwa,(xsp+62)
	ld c,(xsp+15)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	ld (xsp+38),wa
	ld a,7
	ld (xsp+40),a
	ld a,0
	ld (xsp+41),a
	ld wa,34816
	ld c,(xsp+35)
	extz bc
	sll 2,bc
	add wa,bc
	extz xwa
	ld (xsp+42),xwa
	ld a,(xsp+38)
	and a,255
	ld xbc,(xsp+42)
	ld (xbc),a
	ld a,(xsp+41)
	extz wa
	ld c,(_id_spr_priority)
	extz bc
	or wa,bc
	ld bc,(xsp+38)
	srl 8,bc
	and bc,1
	extz bc
	or wa,bc
	ld xbc,(xsp+42)
	ld (xbc+1),a
	ld a,(xsp+36)
	ld xbc,(xsp+42)
	ld (xbc+2),a
	ld a,(xsp+37)
	ld xbc,(xsp+42)
	ld (xbc+3),a
	ld a,(xsp+40)
	and a,15
	ld bc,35840
	ld e,(xsp+35)
	extz de
	add bc,de
	extz xbc
	ld (xbc),a
L1342:
L1341:
L1336:
	incb 1,(xsp+15)
L1337:
	ld a,(xsp+15)
	cp a,(xsp+14)
	jp ult,L1334
L1335:
	push xix
	push xiy
	ld a,64
	push xwa
	ld a,58
	add a,(xsp+26)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	ldb (_b_spr__10),1
L1291:
	lda xsp,(xsp+46)
	pop xiz
	ret

; function slot_offset
_slot_offset__11:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	ld izl,a
	ld xwa,(_s_offset__11)
	ld (xsp+0),xwa
	ld a,izl
	cp a,32
	jr ult,L1346
	ld xwa,(xsp+0)
	sub xwa,8192
	ld (xsp+0),xwa
	ld a,izl
	sub a,32
	ld izl,a
L1346:
	ld xwa,(xsp+0)
	ld c,izl
	extz bc
	extz xbc
	sll 8,xbc
	add xwa,xbc
	jr L1345
L1345:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function slot_ptr
_slot_ptr__11:
	ld xwa,2097152
	push xwa
	ld a,(xsp+8)
	push xwa
	call _slot_offset__11
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	add xwa,xbc
	jr L1348
L1348:
	ret

; function crc_byte
_crc_byte__11:
	push xiz
	lda xsp,(xsp-2)
	ld iz,(xsp+10)
	ld wa,iz
	ld c,(xsp+14)
	extz bc
	sll 8,bc
	xor wa,bc
	ld iz,wa
	ld ixl,0
	jr L1360
L1357:
	ld bc,iz
	and bc,32768
	cp bc,0
	jr z,L1361
	ld wa,iz
	sll 1,wa
	xor wa,4129
	jr L1362
L1361:
	ld wa,iz
	sll 1,wa
L1362:
	ld iz,wa
L1359:
	inc 1,ixl
L1360:
	ld a,ixl
	cp a,8
	jr ult,L1357
L1358:
	ld wa,iz
	jr L1356
L1356:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function slot_erased
_slot_erased__11:
	push xiz
	lda xsp,(xsp-6)
	push xix
	ld a,(xsp+18)
	push xwa
	call _slot_ptr__11
	lda xsp,(xsp+4)
	pop xix
	ld xix,xwa
	ld iz,0
	jr L1373
L1370:
	ld xwa,xix
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,255
	jr z,L1374
	ld wa,0
	jr L1369
L1374:
L1372:
	inc 1,iz
L1373:
	ld wa,iz
	cp wa,256
	jr ult,L1370
L1371:
	ld wa,1
	jr L1369
L1369:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function slot_looks_valid
_slot_looks_valid__11:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	push xwa
	call _slot_ptr__11
	lda xsp,(xsp+4)
	ld xiz,xwa
	ld c,(xiz)
	cp c,202
	jr nz,L1379
	ld c,(xiz+1)
	cp c,254
	jr nz,L1379
	ld c,(xiz+2)
	cp c,32
	jr nz,L1379
	ld c,(xiz+3)
	cp c,38
	jr nz,L1379
	ld c,(xiz+254)
	cp c,74
	jr nz,L1379
	ld c,(xiz+255)
	cp c,0
	jr nz,L1379
	ld wa,1
	jr L1380
L1379:
	ld wa,0
L1380:
	jr L1378
L1378:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function slot_crc_ok
_slot_crc_ok__11:
	push xiz
	lda xsp,(xsp-8)
	push xix
	ld a,(xsp+20)
	push xwa
	call _slot_ptr__11
	lda xsp,(xsp+4)
	pop xix
	ld (xsp+0),xwa
	ld wa,65535
	ld ix,wa
	ld iz,0
	jr L1392
L1389:
	push xix
	ld xwa,(xsp+4)
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld wa,ix
	push xwa
	call _crc_byte__11
	lda xsp,(xsp+8)
	pop xix
	ld ix,wa
L1391:
	inc 1,iz
L1392:
	ld wa,iz
	cp wa,252
	jr ult,L1389
L1390:
	ld xbc,(xsp+0)
	ld c,(xbc+252)
	ld e,ixl
	cp c,e
	jr nz,L1393
	ld xbc,(xsp+0)
	ld c,(xbc+253)
	ld de,ix
	srl 8,de
	cp c,e
	jr nz,L1393
	ld wa,1
	jr L1394
L1393:
	ld wa,0
L1394:
	jr L1388
L1388:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function slot_sequence
_slot_sequence__11:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	push xwa
	call _slot_ptr__11
	lda xsp,(xsp+4)
	ld xiz,xwa
	ld a,(xiz+248)
	extz wa
	extz xwa
	ld c,(xiz+249)
	extz bc
	extz xbc
	sll 8,xbc
	or xwa,xbc
	ld c,(xiz+250)
	extz bc
	extz xbc
	sll 15,xbc
	sll 1,xbc
	or xwa,xbc
	ld c,(xiz+251)
	extz bc
	extz xbc
	sll 15,xbc
	sll 9,xbc
	or xwa,xbc
	jr L1396
L1396:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function bank_of
_bank_of__11:
	ld c,(xsp+4)
	cp c,32
	jr ult,L1401
	ld a,32
	extz wa
	jr L1402
L1401:
	ld wa,0
L1402:
	jr L1400
L1400:
	ret

; function ngpc_flash_init
_ngpc_flash_init:
	push xiz
	lda xsp,(xsp-10)
	ldb (_s_current__11),255
	ldb (_s_last_slot__11),255
	ld xwa,0
	ld (_s_sequence__11),xwa
	ld a,(06C58h)
	extz wa
	cp wa,1
	jr z,L1422
	cp wa,2
	jr z,L1423
	cp wa,3
	jr z,L1424
	jr L1425
L1422:
	ld xwa,499712
	ld (_s_offset__11),xwa
	jr L1421
L1423:
	ld xwa,1024000
	ld (_s_offset__11),xwa
	jr L1421
L1424:
	ld xwa,2072576
	ld (_s_offset__11),xwa
	jr L1421
L1425:
	ld xwa,0
	ld (_s_offset__11),xwa
	jr L1421
L1421:
	ld xwa,(_s_offset__11)
	cp xwa,0
	jr nz,L1426
	jp L1420
L1426:
	ld xwa,__DataROM_END
	ld xbc,2097152
	add xbc,(_s_offset__11)
	sub xbc,8192
	cp xwa,xbc
	jr ule,L1427
	ld xwa,0
	ld (_s_offset__11),xwa
	jr L1420
L1427:
	ld izl,0
	jr L1431
L1428:
	ld a,izl
	push xwa
	call _slot_looks_valid__11
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L1432
	jr L1430
L1432:
	ld a,izl
	push xwa
	call _slot_sequence__11
	lda xsp,(xsp+4)
	ld (xsp+2),xwa
	ld a,(_s_current__11)
	cp a,255
	jr z,L1433
	ld xwa,(xsp+2)
	sub xwa,(_s_sequence__11)
	ld (xsp+6),xwa
	ld xwa,(xsp+6)
	cp xwa,0
	jr z,L1435
	ld xwa,(xsp+6)
	cp xwa,2147483648
	jr ult,L1434
L1435:
	jr L1430
L1434:
L1433:
	ld a,izl
	push xwa
	call _slot_crc_ok__11
	lda xsp,(xsp+4)
	cp a,0
	jr z,L1436
	ld a,izl
	ld (_s_current__11),a
	ld xwa,(xsp+2)
	ld (_s_sequence__11),xwa
L1436:
L1430:
	inc 1,izl
L1431:
	ld a,izl
	cp a,64
	jr ult,L1428
L1429:
L1420:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_flash_ready
_ngpc_flash_ready:
	ld xbc,(_s_offset__11)
	cp xbc,0
	jr z,L1441
	ld wa,1
	jr L1442
L1441:
	ld wa,0
L1442:
	jr L1440
L1440:
	ret

; function ngpc_flash_cart_size
_ngpc_flash_cart_size:
	ld a,(06C58h)
	jr L1444
L1444:
	ret

; function ngpc_flash_exists
_ngpc_flash_exists:
	ld c,(_s_current__11)
	cp c,255
	jr z,L1449
	ld wa,1
	jr L1450
L1449:
	ld wa,0
L1450:
	jr L1448
L1448:
	ret

; function ngpc_flash_load
_ngpc_flash_load:
	push xiz
	lda xsp,(xsp-10)
	ld xwa,(xsp+18)
	ld xiy,xwa
	ld a,(_s_current__11)
	cp a,255
	jr nz,L1458
	jr L1457
L1458:
	push xix
	push xiy
	ld a,(_s_current__11)
	push xwa
	call _slot_ptr__11
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld xix,xwa
	ld iz,0
	jr L1462
L1459:
	ld xwa,xix
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld xbc,xiy
	ld de,iz
	extz xde
	add xbc,xde
	ld (xbc),a
L1461:
	inc 1,iz
L1462:
	ld wa,iz
	cp wa,256
	jr ult,L1459
L1460:
L1457:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_flash_load_legacy
_ngpc_flash_load_legacy:
	push xiz
	lda xsp,(xsp-12)
	ld xwa,(xsp+20)
	ld (xsp+0),xwa
	ld xwa,(_s_offset__11)
	cp xwa,0
	jr nz,L1476
	ld wa,0
	jp L1475
L1476:
	ldb (xsp+8),32
	jr L1479
L1477:
	push xix
	ld a,(xsp+12)
	push xwa
	call _slot_ptr__11
	lda xsp,(xsp+4)
	pop xix
	ld xix,xwa
	ld a,(xix)
	cp a,202
	jr nz,L1481
	ld a,(xix+1)
	cp a,254
	jr nz,L1481
	ld a,(xix+2)
	cp a,32
	jr nz,L1481
	ld a,(xix+3)
	cp a,38
	jr z,L1480
L1481:
	jr L1479
L1480:
	push xix
	ld a,(xsp+12)
	push xwa
	call _slot_looks_valid__11
	lda xsp,(xsp+4)
	pop xix
	cp a,0
	jr z,L1482
	push xix
	ld a,(xsp+12)
	push xwa
	call _slot_crc_ok__11
	lda xsp,(xsp+4)
	pop xix
	cp a,0
	jr z,L1482
	jr L1479
L1482:
	ld iz,0
	jr L1486
L1483:
	ld xwa,xix
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld xbc,(xsp+0)
	ld de,iz
	extz xde
	add xbc,xde
	ld (xbc),a
L1485:
	inc 1,iz
L1486:
	ld wa,iz
	cp wa,256
	jr ult,L1483
L1484:
	ld wa,1
	jr L1475
L1479:
	ld a,(xsp+8)
	decb 1,(xsp+8)
	cp a,0
	jp ugt,L1477
L1478:
	ld wa,0
	jr L1475
L1475:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function ngpc_flash_verify
_ngpc_flash_verify:
	push xiz
	lda xsp,(xsp-12)
	ld xwa,(xsp+20)
	ld (xsp+0),xwa
	ld wa,0
	ld ix,wa
	ld xwa,(_s_offset__11)
	cp xwa,0
	jr z,L1497
	ld a,(_s_last_slot__11)
	cp a,255
	jr nz,L1496
L1497:
	ld wa,65535
	jr L1495
L1496:
	push xix
	push xiy
	ld a,(_s_last_slot__11)
	push xwa
	call _slot_ptr__11
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld xiy,xwa
	ld iz,0
	jr L1501
L1498:
	ld xwa,xiy
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld xbc,(xsp+0)
	ld de,iz
	extz xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr z,L1502
	inc 1,ix
L1502:
L1500:
	inc 1,iz
L1501:
	ld wa,iz
	cp wa,256
	jr ult,L1498
L1499:
	ld wa,ix
	jr L1495
L1495:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function ngpc_flash_slots_used
_ngpc_flash_slots_used:
	push xiz
	lda xsp,(xsp-4)
	ld wa,0
	ld (xsp+1),a
	ld c,(_s_current__11)
	cp c,255
	jr nz,L1513
	ld wa,0
	jr L1514
L1513:
	ld a,(_s_current__11)
	push xwa
	call _bank_of__11
	lda xsp,(xsp+4)
	extz wa
L1514:
	ld (xsp+2),a
	ld xwa,(_s_offset__11)
	cp xwa,0
	jr nz,L1515
	ld wa,0
	jr L1512
L1515:
	ld a,(xsp+2)
	ld izl,a
	jr L1519
L1516:
	ld a,izl
	push xwa
	call _slot_erased__11
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L1520
	incb 1,(xsp+1)
L1520:
L1518:
	inc 1,izl
L1519:
	ld a,izl
	ld c,(xsp+2)
	add c,32
	cp a,c
	jr ult,L1516
L1517:
	ld a,(xsp+1)
	jr L1512
L1512:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function erase_bank
_erase_bank__11:
	push xiz
	lda xsp,(xsp-2)
	ld xwa,2097152
	push xwa
	ld a,(xsp+14)
	push xwa
	call _slot_offset__11
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	add xwa,xbc
	push xwa
	call _ngpc_flash_erase_asm
	lda xsp,(xsp+4)
	ld a,(xsp+10)
	ld izl,a
	jr L1531
L1528:
	ld a,izl
	push xwa
	call _slot_erased__11
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L1532
	ld wa,0
	jr L1527
L1532:
L1530:
	inc 1,izl
L1531:
	ld a,izl
	ld c,(xsp+10)
	add c,32
	cp a,c
	jr ult,L1528
L1529:
	ld wa,1
	jr L1527
L1527:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_flash_erase
_ngpc_flash_erase:
	ld xwa,(_s_offset__11)
	cp xwa,0
	jr nz,L1538
	ld wa,0
	jr L1537
L1538:
	ld wa,0
	push xwa
	call _erase_bank__11
	lda xsp,(xsp+4)
	cp a,0
	jr z,L1540
	ld a,32
	push xwa
	call _erase_bank__11
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L1539
L1540:
	call _ngpc_flash_init
	ld wa,0
	jr L1537
L1539:
	ldb (_s_current__11),255
	ldb (_s_last_slot__11),255
	ld xwa,0
	ld (_s_sequence__11),xwa
	ld wa,1
	jr L1537
L1537:
	ret

; function ngpc_flash_save
_ngpc_flash_save:
	push xiz
	lda xsp,(xsp-16)
	ld xwa,(xsp+24)
	ld (xsp+0),xwa
	ld wa,65535
	ld (xsp+10),wa
	ldb (_s_last_slot__11),255
	ld xwa,(_s_offset__11)
	cp xwa,0
	jr nz,L1572
	ld wa,0
	jp L1571
L1572:
	ld xwa,(xsp+0)
	ld a,(xwa)
	cp a,202
	jr nz,L1574
	ld xwa,(xsp+0)
	ld a,(xwa+1)
	cp a,254
	jr nz,L1574
	ld xwa,(xsp+0)
	ld a,(xwa+2)
	cp a,32
	jr nz,L1574
	ld xwa,(xsp+0)
	ld a,(xwa+3)
	cp a,38
	jr z,L1573
L1574:
	ld wa,0
	jp L1571
L1573:
	ld c,(_s_current__11)
	cp c,255
	jr nz,L1575
	ld wa,0
	jr L1576
L1575:
	ld a,(_s_current__11)
	push xwa
	call _bank_of__11
	lda xsp,(xsp+4)
	extz wa
L1576:
	ld (xsp+5),a
	ld c,(_s_current__11)
	cp c,255
	jr nz,L1577
	ld a,(xsp+5)
	extz wa
	jr L1578
L1577:
	ld a,(_s_current__11)
	add a,1
	extz wa
L1578:
	ld (xsp+4),a
	jr L1581
L1579:
	incb 1,(xsp+4)
L1581:
	ld a,(xsp+4)
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr uge,L1582
	ld a,(xsp+4)
	push xwa
	call _slot_erased__11
	lda xsp,(xsp+4)
	cp a,0
	jr z,L1579
L1582:
L1580:
	ld a,(xsp+4)
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr ult,L1583
	ld a,(xsp+5)
	xor a,32
	ld (xsp+5),a
	ld a,(xsp+5)
	ld izl,a
	jr L1587
L1584:
	ld a,izl
	push xwa
	call _slot_erased__11
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L1588
	jr L1585
L1588:
L1586:
	inc 1,izl
L1587:
	ld a,izl
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr ult,L1584
L1585:
	ld a,izl
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr z,L1589
	ld a,(xsp+5)
	push xwa
	call _erase_bank__11
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L1589
	ld wa,0
	jp L1571
L1589:
	ld a,(xsp+5)
	ld (xsp+4),a
L1583:
	ld xwa,(_s_sequence__11)
	add xwa,1
	ld (xsp+12),xwa
	ld izl,0
	jr L1593
L1590:
	ld xwa,(xsp+12)
	ld c,izl
	extz bc
	sll 3,bc
	cp c,0
	jr z,L1595
L1594:
	srl 1,xwa
	djnz c,L1594
L1595:
	ld xbc,(xsp+0)
	ld de,248
	ld l,izl
	extz hl
	add de,hl
	extz xde
	add xbc,xde
	ld (xbc),a
L1592:
	inc 1,izl
L1593:
	ld a,izl
	cp a,4
	jr ult,L1590
L1591:
	ldw (xsp+8),0
	jr L1599
L1596:
	ld xwa,(xsp+0)
	ld bc,(xsp+8)
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld wa,(xsp+14)
	push xwa
	call _crc_byte__11
	lda xsp,(xsp+8)
	ld (xsp+10),wa
L1598:
	incw 1,(xsp+8)
L1599:
	ld wa,(xsp+8)
	cp wa,252
	jr ult,L1596
L1597:
	ld a,(xsp+10)
	ld xbc,(xsp+0)
	ld (xbc+252),a
	ld wa,(xsp+10)
	srl 8,wa
	ld xbc,(xsp+0)
	ld (xbc+253),a
	ld a,74
	ld xbc,(xsp+0)
	ld (xbc+254),a
	ld a,0
	ld xbc,(xsp+0)
	ld (xbc+255),a
	ld a,(xsp+4)
	ld (_s_last_slot__11),a
	ld xwa,1
	push xwa
	ld a,(xsp+8)
	push xwa
	call _slot_offset__11
	lda xsp,(xsp+4)
	push xwa
	ld xwa,(xsp+8)
	push xwa
	call _ngpc_flash_write_bios
	lda xsp,(xsp+12)
	ld xwa,(xsp+0)
	push xwa
	call _ngpc_flash_verify
	lda xsp,(xsp+4)
	cp wa,0
	jr z,L1600
	ld wa,0
	jr L1571
L1600:
	ld a,(xsp+4)
	ld (_s_current__11),a
	ld xwa,(xsp+12)
	ld (_s_sequence__11),xwa
	ld wa,1
	jr L1571
L1571:
	lda xsp,(xsp+16)
	pop xiz
	ret

; function ngpc_input_vblank
_ngpc_input_vblank:
	lda xsp,(xsp-2)
	ld a,(06F82h)
	ld (xsp+0),a
	ld a,(_s_vbl_down__12)
	ld c,(xsp+0)
	ld e,(_s_vbl_prev__12)
	cpl e
	and c,e
	or a,c
	ld (_s_vbl_down__12),a
	ld a,(xsp+0)
	ld (_s_vbl_prev__12),a
L1602:
	lda xsp,(xsp+2)
	ret

; function ngpc_input_set_repeat
_ngpc_input_set_repeat:
	ld a,(xsp+4)
	ld (_s_repeat_delay__12),a
	ld a,(xsp+8)
	ld (_s_repeat_rate__12),a
L1604:
	ret

; function ngpc_input_update
_ngpc_input_update:
	lda xsp,(xsp-4)
	di
	ld a,(06F82h)
	ld (xsp+2),a
	ld a,(_s_vbl_down__12)
	ld (xsp+3),a
	ldb (_s_vbl_down__12),0
	ld a,(xsp+2)
	ld (_s_vbl_prev__12),a
	ei 0
	ld a,(xsp+2)
	ld (_ngpc_pad_held),a
	ld a,(xsp+2)
	ld c,(_s_pad_prev__12)
	cpl c
	and a,c
	or a,(xsp+3)
	ld (_ngpc_pad_pressed),a
	ld a,(xsp+2)
	cpl a
	and a,(_s_pad_prev__12)
	ld (_ngpc_pad_released),a
	ldb (_ngpc_pad_repeat),0
	ldb (xsp+1),1
	ldb (xsp+0),0
	jp L1620
L1617:
	ld a,(xsp+2)
	extz wa
	ld c,(xsp+1)
	extz bc
	and wa,bc
	cp wa,0
	jr z,L1621
	ld a,(_ngpc_pad_pressed)
	extz wa
	ld c,(xsp+1)
	extz bc
	and wa,bc
	cp wa,0
	jr z,L1622
	ld a,(_s_repeat_delay__12)
	ld xbc,_s_repeat_timer__12
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	jr L1623
L1622:
	ld xwa,_s_repeat_timer__12
	ld c,(xsp+0)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr ule,L1624
	ld xbc,_s_repeat_timer__12
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld a,(xbc)
	dec 1,a
	ld (xbc),a
	jr L1625
L1624:
	ld a,(_ngpc_pad_repeat)
	extz wa
	ld c,(xsp+1)
	extz bc
	or wa,bc
	ld (_ngpc_pad_repeat),a
	ld a,(_s_repeat_rate__12)
	ld xbc,_s_repeat_timer__12
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1625:
L1623:
	jr L1626
L1621:
	ld a,0
	ld xbc,_s_repeat_timer__12
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1626:
	ld a,(xsp+1)
	extz wa
	sll 1,wa
	ld (xsp+1),a
L1619:
	incb 1,(xsp+0)
L1620:
	ld a,(xsp+0)
	cp a,8
	jp ult,L1617
L1618:
	ld a,(xsp+2)
	ld (_s_pad_prev__12),a
L1616:
	lda xsp,(xsp+4)
	ret

; function runtime_bootstrap
_runtime_bootstrap__13:
	push xiz
	lda xsp,(xsp-20)
	ld xwa,__DataROM_START
	ld xix,xwa
	ld xwa,__DataROM_END
	ld (xsp+4),xwa
	ld xwa,__DataRAM_START
	ld xiy,xwa
	ld xwa,__Bss_START
	ld xiz,xwa
	ld xwa,__Bss_END
	ld (xsp+16),xwa
	jr L1637
L1635:
	ld xwa,xix
	inc 1,xwa
	ld xix,xwa
	dec 1,xwa
	ld a,(xwa)
	ld xbc,xiy
	inc 1,xbc
	ld xiy,xbc
	dec 1,xbc
	ld (xbc),a
L1637:
	ld xwa,xix
	cp xwa,(xsp+4)
	jr ult,L1635
L1636:
	jr L1640
L1638:
	ld a,0
	ld xbc,xiz
	inc 1,xbc
	ld xiz,xbc
	dec 1,xbc
	ld (xbc),a
L1640:
	ld xwa,xiz
	cp xwa,(xsp+16)
	jr ult,L1638
L1639:
L1634:
	lda xsp,(xsp+20)
	pop xiz
	ret

; function isr_dummy
_isr_dummy__13:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
L1642:
	pop xiz
	pop xiy
	pop xix
	pop xhl
	pop xde
	pop xbc
	pop xwa
	reti

; function ngpc_set_vblank_hook
_ngpc_set_vblank_hook:
	ld xwa,(xsp+4)
	ld (_g_vb_hook__13),xwa
L1644:
	ret

; function isr_vblank
_isr_vblank__13:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	ldb (06Fh),78
	ld xwa,(_g_vb_hook__13)
	cp xwa,0
	jr z,L1648
	ld xwa,(_g_vb_hook__13)
	ld xhl,xwa
	call (xhl)
L1648:
	call _ngpc_vramq_flush
	incb 1,(_g_vb_counter)
	call _ngpc_input_vblank
L1647:
	pop xiz
	pop xiy
	pop xix
	pop xhl
	pop xde
	pop xbc
	pop xwa
	reti

; function ngpc_init
_ngpc_init:
	lda xsp,(xsp-2)
	call _ngpc_sys_patch
	call _runtime_bootstrap__13
	ld c,(06F91h)
	cp c,0
	jr z,L1657
	ld wa,1
	jr L1658
L1657:
	ld wa,0
L1658:
	ld (_s_is_color__13),a
	ld a,(06F87h)
	ld (_s_language__13),a
	andb (06F86h),223
	orb (06F86h),64
	call _ngpc_vramq_init
	ld xwa,_isr_dummy__13
	ld (06FB8h),xwa
	ld xwa,_isr_dummy__13
	ld (06FBCh),xwa
	ld xwa,_isr_dummy__13
	ld (06FC0h),xwa
	ld xwa,_isr_dummy__13
	ld (06FC4h),xwa
	ld xwa,_isr_dummy__13
	ld (06FC8h),xwa
	ld xwa,_isr_vblank__13
	ld (06FCCh),xwa
	ld xwa,_isr_dummy__13
	ld (06FD0h),xwa
	ld xwa,_isr_dummy__13
	ld (06FD4h),xwa
	ld xwa,_isr_dummy__13
	ld (06FD8h),xwa
	ld xwa,_isr_dummy__13
	ld (06FDCh),xwa
	ld xwa,_isr_dummy__13
	ld (06FE0h),xwa
	ld xwa,_isr_dummy__13
	ld (06FE4h),xwa
	ld xwa,_isr_dummy__13
	ld (06FE8h),xwa
	ld xwa,_isr_dummy__13
	ld (06FF0h),xwa
	ld xwa,_isr_dummy__13
	ld (06FF4h),xwa
	ld xwa,_isr_dummy__13
	ld (06FF8h),xwa
	ld xwa,_isr_dummy__13
	ld (06FFCh),xwa
	ldb (08002h),0
	ldb (08003h),0
	ldb (08004h),160
	ldb (08005h),152
	ldb (08032h),0
	ldb (08033h),0
	ldb (08034h),0
	ldb (08035h),0
	andb (08030h),127
	ldb (08020h),0
	ldb (08021h),0
	andb (08012h),127
	ldb (xsp+0),0
	jr L1662
L1659:
	ld wa,0
	ld xbc,40960
	ld e,(xsp+0)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1661:
	incb 1,(xsp+0)
L1662:
	ld a,(xsp+0)
	cp a,8
	jr ult,L1659
L1660:
	ei
L1656:
	lda xsp,(xsp+2)
	ret

; function ngpc_is_color
_ngpc_is_color:
	ld a,(_s_is_color__13)
	jr L1664
L1664:
	ret

; function ngpc_get_language
_ngpc_get_language:
	ld a,(_s_language__13)
	jr L1666
L1666:
	ret

; function ngpc_shutdown_reason
_ngpc_shutdown_reason:
	push xiz
	lda xsp,(xsp-6)
	ld a,(xsp+14)
	extz wa
	and wa,32
	cp wa,0
	jr z,L1682
	ld iy,15
	jr L1683
L1682:
	ld a,(xsp+14)
	extz wa
	and wa,128
	cp wa,0
	jr z,L1684
	ld iy,4095
	jr L1685
L1684:
	ld a,(xsp+14)
	extz wa
	and wa,64
	cp wa,0
	jr z,L1686
	ld iy,240
	jr L1687
L1686:
	ld iy,3840
L1687:
L1685:
L1683:
	ld wa,iy
	ld xbc,33776
	ld (xbc),wa
	ld a,(08012h)
	and a,248
	ld (08012h),a
	ldb (08002h),0
	ldb (08003h),0
	ldb (08004h),0
	ldb (08005h),0
	ld iz,0
	jr L1691
L1688:
	ld a,(_g_vb_counter)
	ld ixl,a
	jr L1694
L1692:
L1694:
	ld a,(_g_vb_counter)
	cp a,ixl
	jr z,L1692
L1693:
L1690:
	inc 1,iz
L1691:
	ld wa,iz
	cp wa,180
	jr ult,L1688
L1689:
	push xix
	push xiy
	call _ngpc_shutdown
	pop xiy
	pop xix
L1681:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_shutdown
_ngpc_shutdown:
	ldb ra3, 3
	ldb rw3, 0
	swi 1
L1696:
	ret

; function ngpc_load_sysfont
_ngpc_load_sysfont:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,41472
	ld xix,xwa
	ld iz,0
	jr L1706
L1703:
	ld xwa,_overrev_dash_tiles__13
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,xix
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1705:
	inc 1,iz
L1706:
	ld wa,iz
	cp wa,768
	jr ult,L1703
L1704:
L1702:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_memcpy
_ngpc_memcpy:
	push xiz
	ld xix,(xsp+8)
	ld xiz,(xsp+12)
	ld iy,(xsp+16)
	jr L1714
L1712:
	ld xwa,xiz
	inc 1,xwa
	ld xiz,xwa
	dec 1,xwa
	ld a,(xwa)
	ld xbc,xix
	inc 1,xbc
	ld xix,xbc
	dec 1,xbc
	ld (xbc),a
L1714:
	ld wa,iy
	dec 1,iy
	cp wa,0
	jr nz,L1712
L1713:
L1711:
	pop xiz
	ret

; function ngpc_memset
_ngpc_memset:
	push xiz
	ld xiz,(xsp+8)
	ld a,(xsp+12)
	ld iyl,a
	ld ix,(xsp+16)
	jr L1722
L1720:
	ld a,iyl
	ld xbc,xiz
	inc 1,xbc
	ld xiz,xbc
	dec 1,xbc
	ld (xbc),a
L1722:
	ld wa,ix
	dec 1,ix
	cp wa,0
	jr nz,L1720
L1721:
L1719:
	pop xiz
	ret

; function ngpc_vsync
_ngpc_vsync:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_g_vb_counter)
	ld izl,a
	jr L1733
L1731:
L1733:
	ld a,(_g_vb_counter)
	cp a,izl
	jr z,L1731
L1732:
	ld a,(06F85h)
	cp a,0
	jr z,L1734
	ld a,(06F85h)
	push xwa
	call _ngpc_shutdown_reason
	lda xsp,(xsp+4)
L1734:
L1729:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_in_vblank
_ngpc_in_vblank:
	ld c,(08010h)
	extz bc
	and bc,64
	cp bc,0
	jr z,L1739
	ld wa,1
	jr L1740
L1739:
	ld wa,0
L1740:
	jr L1738
L1738:
	ret

; function ngpc_sleep
_ngpc_sleep:
	push xiz
	lda xsp,(xsp-2)
	ld wa,4
	push xwa
	call _ngpc_cpu_speed
	lda xsp,(xsp+4)
	ld izl,0
	jr L1750
L1747:
	call _ngpc_vsync
L1749:
	inc 1,izl
L1750:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L1747
L1748:
	ld wa,0
	push xwa
	call _ngpc_cpu_speed
	lda xsp,(xsp+4)
L1746:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_cpu_speed
_ngpc_cpu_speed:
	ld rw3, 1
	ld xde, (xsp+4)
	ld b, e
	ld c, 0
	ldf 3
	add w, w
	add w, w
	ld xix, 0xfffe00
	ld xix, (xix+w)
	call xix
L1752:
	ret

; function dst_range_ok
_dst_range_ok__15:
	push xiz
	lda xsp,(xsp-12)
	ld xwa,(xsp+20)
	cp xwa,0
	jr z,L1760
	ld wa,(xsp+24)
	cp wa,0
	jr nz,L1759
L1760:
	ld wa,0
	jr L1758
L1759:
	ld xwa,(xsp+20)
	extz xwa
	ld xiz,xwa
	ld wa,(xsp+24)
	extz xwa
	sll 1,xwa
	ld (xsp+4),xwa
	ld xwa,xiz
	add xwa,(xsp+4)
	sub xwa,1
	ld (xsp+8),xwa
	ld xwa,xiz
	cp xwa,32768
	jr uge,L1761
	ld wa,0
	jr L1758
L1761:
	ld xwa,(xsp+8)
	cp xwa,49151
	jr ule,L1762
	ld wa,0
	jr L1758
L1762:
	ld wa,1
	jr L1758
L1758:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function ngpc_vramq_init
_ngpc_vramq_init:
	ldb (_s_cmd_count__15),0
	ldb (_s_drop_count__15),0
	ldb (_s_lock__15),0
L1764:
	ret

; function ngpc_vramq_copy
_ngpc_vramq_copy:
	push xiz
	lda xsp,(xsp-2)
	ld xwa,(xsp+14)
	cp xwa,0
	jr z,L1771
	ld wa,(xsp+18)
	push xwa
	ld xwa,(xsp+14)
	push xwa
	call _dst_range_ok__15
	lda xsp,(xsp+8)
	cp a,0
	jr nz,L1770
L1771:
	ld wa,0
	jp L1769
L1770:
	ldb (_s_lock__15),1
	ld a,(_s_cmd_count__15)
	ld izl,a
	ld a,izl
	cp a,16
	jr ult,L1772
	incb 1,(_s_drop_count__15)
	ldb (_s_lock__15),0
	ld wa,0
	jr L1769
L1772:
	ld xwa,(xsp+10)
	ld xbc,_s_cmd_dst__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+18)
	ld xbc,_s_cmd_len__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,(xsp+14)
	ld xbc,_s_cmd_src__15
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,0
	ld xbc,_s_cmd_fill__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,1
	ld xbc,_s_cmd_type__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,izl
	add a,1
	ld (_s_cmd_count__15),a
	ldb (_s_lock__15),0
	ld wa,1
	jr L1769
L1769:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_vramq_fill
_ngpc_vramq_fill:
	push xiz
	lda xsp,(xsp-2)
	ld wa,(xsp+18)
	push xwa
	ld xwa,(xsp+14)
	push xwa
	call _dst_range_ok__15
	lda xsp,(xsp+8)
	cp a,0
	jr nz,L1777
	ld wa,0
	jp L1776
L1777:
	ldb (_s_lock__15),1
	ld a,(_s_cmd_count__15)
	ld izl,a
	ld a,izl
	cp a,16
	jr ult,L1778
	incb 1,(_s_drop_count__15)
	ldb (_s_lock__15),0
	ld wa,0
	jr L1776
L1778:
	ld xwa,(xsp+10)
	ld xbc,_s_cmd_dst__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+18)
	ld xbc,_s_cmd_len__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,0
	ld xbc,_s_cmd_src__15
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,(xsp+14)
	ld xbc,_s_cmd_fill__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,2
	ld xbc,_s_cmd_type__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,izl
	add a,1
	ld (_s_cmd_count__15),a
	ldb (_s_lock__15),0
	ld wa,1
	jr L1776
L1776:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_vramq_flush
_ngpc_vramq_flush:
	push xiz
	lda xsp,(xsp-10)
	ld a,(_s_lock__15)
	cp a,0
	jr z,L1793
	jp L1792
L1793:
	ld a,(_s_cmd_count__15)
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,0
	jr nz,L1794
	jp L1792
L1794:
	ldb (_s_lock__15),1
	ld izl,0
	jp L1798
L1795:
	ld xwa,_s_cmd_dst__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	extz xwa
	ld xix,xwa
	ld xwa,_s_cmd_len__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld iy,wa
	ld xwa,_s_cmd_type__15
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,1
	jr nz,L1799
	push xix
	push xiy
	ld wa,iy
	extz xwa
	push xwa
	ld xwa,_s_cmd_src__15
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_cmd_dst__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	extz xwa
	push xwa
	call _ngpc_memcpy_w
	lda xsp,(xsp+12)
	pop xiy
	pop xix
	jr L1800
L1799:
	ld xwa,_s_cmd_type__15
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,2
	jr nz,L1801
	ld xwa,_s_cmd_fill__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+8),wa
	jr L1804
L1802:
	ld wa,(xsp+8)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L1804:
	ld wa,iy
	dec 1,iy
	cp wa,0
	jr nz,L1802
L1803:
L1801:
L1800:
L1797:
	inc 1,izl
L1798:
	ld a,izl
	cp a,(xsp+1)
	jp ult,L1795
L1796:
	ldb (_s_cmd_count__15),0
	ldb (_s_lock__15),0
L1792:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_vramq_clear
_ngpc_vramq_clear:
	ld a,(_s_lock__15)
	cp a,0
	jr z,L1808
	jr L1807
L1808:
	ldb (_s_cmd_count__15),0
L1807:
	ret

; function ngpc_vramq_pending
_ngpc_vramq_pending:
	ld a,(_s_cmd_count__15)
	jr L1810
L1810:
	ret

; function ngpc_vramq_dropped
_ngpc_vramq_dropped:
	ld a,(_s_drop_count__15)
	jr L1812
L1812:
	ret

; function ngpc_vramq_clear_dropped
_ngpc_vramq_clear_dropped:
	ldb (_s_drop_count__15),0
L1814:
	ret

; function rnd16
_rnd16__16:
	ld wa,(_rs__16)
	ld bc,(_rs__16)
	sll 7,bc
	xor wa,bc
	ld (_rs__16),wa
	ld wa,(_rs__16)
	ld bc,(_rs__16)
	srl 9,bc
	xor wa,bc
	ld (_rs__16),wa
	ld wa,(_rs__16)
	ld bc,(_rs__16)
	sll 8,bc
	xor wa,bc
	ld (_rs__16),wa
	ld wa,(_rs__16)
	jr L1816
L1816:
	ret

; function rndn
_rndn__16:
	call _rnd16__16
	extz xwa
	div xwa,(xsp+4)
	ld wa,qwa
	jr L1818
L1818:
	ret

; function stage_of
_stage_of__16:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld ixl,a
	ld wa,0
	ld izl,a
	jr L1827
L1825:
	inc 1,izl
L1827:
	ld a,izl
	extz wa
	add wa,1
	cp wa,5
	jr uge,L1828
	ld a,izl
	extz wa
	add wa,1
	ld c,izl
	extz bc
	add bc,1
	add bc,1
	mul xwa,bc
	srl 1,wa
	add wa,0
	cp a,ixl
	jr ule,L1825
L1828:
L1826:
	ld a,izl
	jr L1824
L1824:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function put
_put__16:
	ld wa,(xsp+4)
	ld xbc,(_gp__16)
	ld e,(_gn__16)
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+8)
	ld xbc,(_gp__16)
	ld e,(_gn__16)
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+2),wa
	ld a,(xsp+12)
	ld xbc,(_gp__16)
	ld e,(_gn__16)
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+4),a
	incb 1,(_gn__16)
L1830:
	ret

; function slope_for
_slope_for__16:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	cp a,0
	jr z,L1838
	ld wa,100
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld bc,18
	ld e,(xsp+10)
	extz de
	mul xbc,de
	cp wa,bc
	jr uge,L1838
	ld wa,6
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld (xsp+0),a
	ld xwa,_slopes__16
	ld c,(xsp+0)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld izl,a
	ld a,(xsp+0)
	cp a,0
	jr nz,L1839
	ld a,(xsp+10)
	neg a
	ld izl,a
L1839:
	ld a,(xsp+0)
	cp a,3
	jr nz,L1840
	ld a,(xsp+10)
	ld izl,a
L1840:
	ld a,izl
	cp a,252
	jr ge,L1841
	ld izl,252
L1841:
	ld a,izl
	cp a,3
	jr le,L1842
	ld izl,3
L1842:
	ld a,izl
	jr L1837
L1838:
	ld wa,0
	jr L1837
L1837:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function sharp
_sharp__16:
	push xiz
	lda xsp,(xsp-2)
	ld xwa,_sharp_bends__16
	push xwa
	ld wa,3
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld bc,850
	ld de,15
	ld l,(xsp+10)
	extz hl
	mul xde,hl
	add bc,de
	mul xwa,bc
	add xwa,500
	push xwa
	ld xwa,1000
	ld xbc,xwa
	pop xwa
	call __div32u
	ld iz,wa
	ld wa,iz
	cp wa,52
	jr uge,L1847
	ld iz,52
L1847:
	ld wa,iz
	cp wa,72
	jr ule,L1848
	ld iz,72
L1848:
	ld wa,iz
	jr L1846
L1846:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function gen_leg
_gen_leg__16:
	push xiz
	lda xsp,(xsp-30)
	ld xwa,_gfx_themes
	ld xbc,_leg_theme
	ld e,(xsp+38)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	muls xbc,20
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+0),xwa
	ld a,(xsp+38)
	push xwa
	call _stage_of__16
	lda xsp,(xsp+4)
	ld (xsp+4),a
	ld wa,160
	ld bc,60
	ld e,(xsp+4)
	extz de
	mul xbc,de
	add wa,bc
	ld (xsp+6),wa
	ld wa,80
	ld bc,50
	ld e,(xsp+4)
	extz de
	mul xbc,de
	add wa,bc
	ld (xsp+8),wa
	ld wa,900
	ld iz,wa
	ld wa,1
	ld (xsp+16),wa
	ld xwa,(xsp+42)
	ld (_gp__16),xwa
	ldb (_gn__16),0
	ld wa,(_free_seed)
	ld c,(xsp+38)
	extz bc
	add bc,1
	mul xbc,40503
	xor wa,bc
	ld (_rs__16),wa
	ld wa,(_rs__16)
	cp wa,0
	jr nz,L1873
	ldw (_rs__16),44257
L1873:
	call _rnd16__16
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,900
	push xwa
	call _put__16
	lda xsp,(xsp+12)
	jp L1876
L1874:
	ld wa,1000
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld (xsp+18),wa
	push xwa
	ld wa,1000
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp bc,600
	jr uge,L1877
	ld wa,(xsp+16)
	neg wa
	jr L1878
L1877:
	ld wa,(xsp+16)
L1878:
	ld (xsp+20),wa
	ld wa,(xsp+18)
	cp wa,(xsp+8)
	jp uge,L1879
	ld xwa,(xsp+0)
	ld a,(xwa+16)
	push xwa
	call _sharp__16
	lda xsp,(xsp+4)
	ld (xsp+22),wa
	ld xwa,(xsp+0)
	ld a,(xwa+16)
	push xwa
	call _sharp__16
	lda xsp,(xsp+4)
	ld (xsp+24),wa
	ld xwa,_sp_s__16
	push xwa
	ld wa,3
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+26),wa
	ld xwa,_sp_gap__16
	push xwa
	ld wa,3
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+28),wa
	push xwa
	ld wa,2
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp bc,0
	jr z,L1880
	ld wa,500
	jr L1881
L1880:
	ld wa,400
L1881:
	ld (xsp+12),wa
	ld xwa,(xsp+0)
	ld a,(xwa+17)
	push xwa
	call _slope_for__16
	lda xsp,(xsp+4)
	ld (xsp+14),a
	ld a,(xsp+14)
	push xwa
	ld wa,0
	push xwa
	ld wa,(xsp+20)
	push xwa
	call _put__16
	lda xsp,(xsp+12)
	ld wa,0
	push xwa
	ld wa,(xsp+24)
	mul xwa,(xsp+26)
	push xwa
	ld wa,(xsp+34)
	push xwa
	call _put__16
	lda xsp,(xsp+12)
	ld wa,(xsp+28)
	cp wa,0
	jr z,L1882
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,(xsp+36)
	push xwa
	call _put__16
	lda xsp,(xsp+12)
L1882:
	ld wa,0
	push xwa
	ld wa,(xsp+24)
	neg wa
	mul xwa,(xsp+28)
	push xwa
	ld wa,(xsp+34)
	push xwa
	call _put__16
	lda xsp,(xsp+12)
	ld wa,iz
	add wa,450
	ld bc,2
	mul xbc,(xsp+26)
	add wa,bc
	add wa,(xsp+28)
	ld iz,wa
	ld wa,(xsp+20)
	neg wa
	ld (xsp+16),wa
	jp L1883
L1879:
	ld wa,(xsp+18)
	ld bc,(xsp+8)
	add bc,(xsp+6)
	cp wa,bc
	jp uge,L1884
	push xwa
	ld wa,2
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp bc,0
	jr z,L1885
	ld wa,500
	jr L1886
L1885:
	ld wa,400
L1886:
	ld (xsp+12),wa
	ld xwa,(xsp+0)
	ld a,(xwa+17)
	push xwa
	call _slope_for__16
	lda xsp,(xsp+4)
	ld (xsp+14),a
	ld a,(xsp+14)
	push xwa
	ld wa,0
	push xwa
	ld wa,(xsp+20)
	push xwa
	call _put__16
	lda xsp,(xsp+12)
	ld xwa,_sp_sharp__16
	push xwa
	ld wa,3
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+22),wa
	ld wa,0
	push xwa
	ld wa,(xsp+24)
	push xwa
	ld xwa,(xsp+8)
	ld a,(xwa+16)
	push xwa
	call _sharp__16
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	mul xwa,bc
	push xwa
	ld wa,(xsp+30)
	push xwa
	call _put__16
	lda xsp,(xsp+12)
	ld wa,iz
	add wa,450
	add wa,(xsp+22)
	ld iz,wa
	ld wa,(xsp+20)
	ld (xsp+16),wa
	jp L1887
L1884:
	ld wa,100
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld xbc,(xsp+0)
	ld c,(xbc+18)
	extz bc
	cp wa,bc
	jr uge,L1888
	ld xwa,_sp_straight__16
	push xwa
	ld wa,4
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+22),wa
	ld xwa,(xsp+0)
	ld a,(xwa+17)
	push xwa
	call _slope_for__16
	lda xsp,(xsp+4)
	push xwa
	ld wa,0
	push xwa
	ld wa,(xsp+30)
	push xwa
	call _put__16
	lda xsp,(xsp+12)
	ld wa,iz
	add wa,(xsp+22)
	ld iz,wa
	jp L1889
L1888:
	ld xwa,_sp_bend__16
	push xwa
	ld wa,5
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+22),wa
	ld xwa,_easy_bends__16
	push xwa
	ld c,(xsp+8)
	cp c,1
	jr ult,L1890
	ld wa,5
	jr L1891
L1890:
	ld wa,3
L1891:
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+24),wa
	ld wa,(xsp+24)
	ld xbc,(xsp+0)
	ld c,(xbc+16)
	extz bc
	mul xwa,bc
	add wa,5
	extz xwa
	div xwa,10
	ld (xsp+24),wa
	ld wa,(xsp+24)
	cp wa,18
	jr uge,L1892
	ldw (xsp+24),18
L1892:
	ld wa,(xsp+24)
	cp wa,48
	jr ule,L1893
	ldw (xsp+24),48
L1893:
	ld xwa,(xsp+0)
	ld a,(xwa+17)
	push xwa
	call _slope_for__16
	lda xsp,(xsp+4)
	push xwa
	ld wa,(xsp+24)
	ld bc,(xsp+28)
	mul xwa,bc
	push xwa
	ld wa,(xsp+30)
	push xwa
	call _put__16
	lda xsp,(xsp+12)
	ld wa,iz
	add wa,(xsp+22)
	ld iz,wa
	ld wa,(xsp+20)
	ld (xsp+16),wa
L1889:
L1887:
L1883:
L1876:
	ld wa,iz
	cp wa,11700
	jr uge,L1894
	ld a,(_gn__16)
	cp a,30
	jp ule,L1874
L1894:
L1875:
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,2400
	push xwa
	call _put__16
	lda xsp,(xsp+12)
	ld a,(_gn__16)
	jr L1872
L1872:
	lda xsp,(xsp+30)
	pop xiz
	ret

; function cost_of
_cost_of__16:
	push xiz
	lda xsp,(xsp-10)
	ld xwa,0
	ld (xsp+0),xwa
	ld ixl,0
	jr L1909
L1906:
	ld xwa,(xsp+18)
	ld c,ixl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld wa,(xwa+2)
	ld iy,wa
	ld wa,14
	ld iz,wa
	ld wa,iy
	cp wa,0
	jr ge,L1910
	ld wa,iy
	neg wa
	ld iy,wa
L1910:
	jr L1913
L1911:
	dec 1,iz
L1913:
	ld wa,iz
	cp wa,6
	jr ule,L1914
	ld wa,iz
	mul xwa,iz
	ld bc,iy
	mul xwa,bc
	cp wa,6000
	jr ugt,L1911
L1914:
L1912:
	ld xwa,(xsp+0)
	ld xbc,(xsp+18)
	ld e,ixl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	mul xbc,14
	push xwa
	push xix
	push xiy
	push xbc
	ld wa,iz
	extz xwa
	ld xbc,xwa
	pop xwa
	call __div32u
	ld xbc,xwa
	pop xiy
	pop xix
	pop xwa
	add xwa,xbc
	ld (xsp+0),xwa
L1908:
	inc 1,ixl
L1909:
	ld a,ixl
	cp a,(xsp+22)
	jr ult,L1906
L1907:
	ld xwa,(xsp+0)
	srl 4,xwa
	jr L1905
L1905:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function put_placeholder
_put_placeholder__16:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld wa,4000
	ld xbc,_buf__16
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc),wa
	ld wa,0
	ld xbc,_buf__16
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+2),wa
	ld a,0
	ld xbc,_buf__16
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+4),a
L1916:
	pop xiz
	ret

; function copy_leg
_copy_leg__16:
	push xiz
	lda xsp,(xsp-6)
	ld a,(xsp+18)
	ld iyl,a
	ld a,(_difficulty)
	cp a,3
	jr nz,L1926
	push xix
	push xiy
	ld xwa,_buf__16
	ld c,iyl
	extz bc
	muls xbc,6
	add xwa,xbc
	lda xwa,(xwa)
	push xwa
	ld a,(xsp+26)
	push xwa
	call _gen_leg__16
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	ld ixl,a
	jr L1927
L1926:
	ld xwa,_gfx_legs
	ld c,(xsp+14)
	extz bc
	muls xbc,6
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+2),xwa
	ld xwa,(xsp+2)
	ld a,(xwa+4)
	ld ixl,a
	ld a,iyl
	extz wa
	ld c,ixl
	extz bc
	add wa,bc
	add wa,1
	cp wa,72
	jr ule,L1928
	ld a,71
	sub a,iyl
	ld ixl,a
L1928:
	ld izl,0
	jr L1932
L1929:
	push xwa
	ld xwa,(xsp+6)
	ld xwa,(xwa)
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	push xwa
	ld xwa,_buf__16
	ld c,iyl
	add c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld xde,xwa
	pop xhl
	ld bc,6
	ldirb
	pop xwa
L1931:
	inc 1,izl
L1932:
	ld a,izl
	cp a,ixl
	jr ult,L1929
L1930:
L1927:
	push xix
	push xiy
	ld a,ixl
	push xwa
	ld xwa,_buf__16
	ld c,iyl
	extz bc
	muls xbc,6
	add xwa,xbc
	lda xwa,(xwa)
	push xwa
	call _cost_of__16
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	ld (_next_leg_cost),wa
	ld a,ixl
	jr L1925
L1925:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function load_current
_load_current__16:
	push xiz
	lda xsp,(xsp-2)
	ld wa,0
	push xwa
	ld a,(_cur_leg)
	push xwa
	call _copy_leg__16
	lda xsp,(xsp+8)
	ld (_n_cur__16),a
	ld a,(_n_cur__16)
	push xwa
	call _put_placeholder__16
	lda xsp,(xsp+4)
	ld a,(_n_cur__16)
	add a,1
	ld (_track_len),a
	ldw (_leg_len),0
	ld izl,0
	jr L1942
L1939:
	ld wa,(_leg_len)
	ld xbc,_buf__16
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld (_leg_len),wa
L1941:
	inc 1,izl
L1942:
	ld a,izl
	cp a,(_n_cur__16)
	jr ult,L1939
L1940:
	ldb (_fork_choice),0
L1938:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function course_start
_course_start:
	push xiz
	lda xsp,(xsp-4)
	ldb (_cur_stage),0
	ldb (_cur_branch),0
	ldb (_cur_leg),0
	ld izl,0
	jr L1963
L1960:
	ld a,0
	ld xbc,_route_hist
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1962:
	inc 1,izl
L1963:
	ld a,izl
	cp a,5
	jr ult,L1960
L1961:
	ld izl,0
	jr L1967
L1964:
	ld xwa,_gfx_legs
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld a,(xwa+5)
	ld xbc,_leg_theme
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1966:
	inc 1,izl
L1967:
	ld a,izl
	cp a,15
	jr ult,L1964
L1965:
	ld a,(_difficulty)
	cp a,3
	jp nz,L1968
	ld wa,(_free_seed)
	cp wa,0
	jr nz,L1969
	ldw (_free_seed),24301
L1969:
	ld wa,(_free_seed)
	xor wa,15450
	ld (_rs__16),wa
	ld wa,(_rs__16)
	cp wa,0
	jr nz,L1970
	ldw (_rs__16),44257
L1970:
	ld izl,14
	jr L1974
L1971:
	ld a,izl
	extz wa
	add wa,1
	push xwa
	call _rndn__16
	lda xsp,(xsp+4)
	ld (xsp+1),a
	ld xwa,_leg_theme
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+2),a
	ld xwa,_leg_theme
	ld c,(xsp+1)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld xbc,_leg_theme
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+2)
	ld xbc,_leg_theme
	ld e,(xsp+1)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1973:
	dec 1,izl
L1974:
	ld a,izl
	cp a,0
	jr ugt,L1971
L1972:
L1968:
	call _load_current__16
L1959:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function course_is_last_stage
_course_is_last_stage:
	ld c,(_cur_stage)
	extz bc
	add bc,1
	cp bc,5
	jr ult,L1979
	ld wa,1
	jr L1980
L1979:
	ld wa,0
L1980:
	jr L1978
L1978:
	ret

; function course_fork_zone
_course_fork_zone:
	ld bc,(xsp+4)
	add bc,2400
	cp bc,(_leg_len)
	jr ult,L1985
	ld wa,1
	jr L1986
L1985:
	ld wa,0
L1986:
	jr L1984
L1984:
	ret

; function course_start_zone
_course_start_zone:
	ld c,(_cur_stage)
	cp c,0
	jr z,L1991
	ld bc,(xsp+4)
	cp bc,900
	jr uge,L1991
	ld wa,1
	jr L1992
L1991:
	ld wa,0
L1992:
	jr L1990
L1990:
	ret

; function course_decide
_course_decide:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_fork_choice)
	cp a,0
	jr nz,L2005
	call _course_is_last_stage
	cp a,0
	jr z,L2004
L2005:
	jp L2003
L2004:
	ld c,(xsp+10)
	cp c,0
	jr z,L2006
	ld wa,2
	jr L2007
L2006:
	ld wa,1
L2007:
	ld (_fork_choice),a
	ld a,(_cur_stage)
	extz wa
	add wa,1
	ld c,(_cur_stage)
	extz bc
	add bc,1
	add bc,1
	mul xwa,bc
	srl 1,wa
	ld c,(_cur_branch)
	extz bc
	ld l,(xsp+10)
	cp l,0
	jr z,L2008
	ld de,1
	jr L2009
L2008:
	ld de,0
L2009:
	add bc,de
	add wa,bc
	ld (xsp+0),a
	ld a,(_n_cur__16)
	push xwa
	ld a,(xsp+4)
	push xwa
	call _copy_leg__16
	lda xsp,(xsp+8)
	ld izl,a
	ld a,izl
	ld (_n_next__16),a
	ld a,izl
	cp a,0
	jr z,L2010
	ld c,(xsp+10)
	cp c,0
	jr z,L2011
	ld wa,65486
	jr L2012
L2011:
	ld wa,50
L2012:
	ld xbc,_buf__16
	ld e,(_n_cur__16)
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+2),wa
L2010:
	ld a,(_n_cur__16)
	add a,izl
	push xwa
	call _put_placeholder__16
	lda xsp,(xsp+4)
	ld a,(_n_cur__16)
	add a,izl
	add a,1
	ld (_track_len),a
L2003:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function course_next_leg
_course_next_leg:
	push xiz
	lda xsp,(xsp-2)
	push xix
	call _course_is_last_stage
	pop xix
	cp a,0
	jr z,L2027
	ld wa,0
	jp L2026
L2027:
	ld a,(_fork_choice)
	cp a,0
	jr nz,L2028
	push xix
	ld wa,0
	push xwa
	call _course_decide
	lda xsp,(xsp+4)
	pop xix
L2028:
	ld a,(_n_cur__16)
	ld ixl,a
	ld izl,0
	jr L2032
L2029:
	push xwa
	ld xwa,_buf__16
	ld c,izl
	add c,ixl
	extz bc
	muls xbc,6
	add xwa,xbc
	push xwa
	ld xwa,_buf__16
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld xde,xwa
	pop xhl
	ld bc,6
	ldirb
	pop xwa
L2031:
	inc 1,izl
L2032:
	ld a,izl
	add a,ixl
	cp a,(_track_len)
	jr ult,L2029
L2030:
	ld a,(_track_len)
	sub a,ixl
	ld (_track_len),a
	ld a,(_fork_choice)
	cp a,2
	jr nz,L2033
	incb 1,(_cur_branch)
L2033:
	incb 1,(_cur_stage)
	ld a,(_cur_branch)
	ld xbc,_route_hist
	ld e,(_cur_stage)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(_cur_stage)
	extz wa
	ld c,(_cur_stage)
	extz bc
	add bc,1
	mul xwa,bc
	srl 1,wa
	ld c,(_cur_branch)
	extz bc
	add wa,bc
	ld (_cur_leg),a
	ld a,(_n_next__16)
	ld (_n_cur__16),a
	ld a,(_n_cur__16)
	cp a,(_track_len)
	jr ult,L2034
	ld a,(_track_len)
	sub a,1
	ld (_n_cur__16),a
L2034:
	ldw (_leg_len),0
	ld izl,0
	jr L2038
L2035:
	ld wa,(_leg_len)
	ld xbc,_buf__16
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld (_leg_len),wa
L2037:
	inc 1,izl
L2038:
	ld a,izl
	cp a,(_n_cur__16)
	jr ult,L2035
L2036:
	ldb (_fork_choice),0
	ld a,ixl
	jr L2026
L2026:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function course_debug_leg
_course_debug_leg:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,(xsp+12)
	ld ixl,a
	ld a,izl
	ld (_cur_stage),a
	ld a,ixl
	ld (_cur_branch),a
	ld a,izl
	extz wa
	ld c,izl
	extz bc
	add bc,1
	mul xwa,bc
	srl 1,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld (_cur_leg),a
	ld a,ixl
	ld xbc,_route_hist
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	push xix
	call _load_current__16
	pop xix
L2040:
	pop xiz
	ret

; function rnd
_rnd__17:
	ld wa,(_seed__17)
	mul xwa,25173
	add wa,13849
	ld (_seed__17),wa
	ld wa,(_seed__17)
	srl 8,wa
	jr L2042
L2042:
	ret

; function ending_start
_ending_start:
	push xiz
	lda xsp,(xsp-8)
	ld a,(xsp+16)
	cp a,5
	jr ule,L2054
	ldb (xsp+16),5
L2054:
	ld xwa,_endings__17
	ld c,(xsp+16)
	extz bc
	exts xbc
	sll 4,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+0),xwa
	ldw (xsp+4),0
	jr L2058
L2055:
	ld xwa,_gfx_particle_tiles
	ld bc,(xsp+4)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,42672
	ld de,(xsp+4)
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2057:
	incw 1,(xsp+4)
L2058:
	ld wa,(xsp+4)
	cp wa,24
	jr ult,L2055
L2056:
	ld xwa,(xsp+0)
	lda xwa,(xwa+8)
	ld wa,(xwa+4)
	push xwa
	ld xwa,(xsp+4)
	lda xwa,(xwa+8)
	ld wa,(xwa+2)
	push xwa
	ld xwa,(xsp+8)
	lda xwa,(xwa+8)
	ld wa,(xwa)
	push xwa
	ld wa,0
	push xwa
	ld a,8
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ld wa,2815
	push xwa
	ld wa,63
	push xwa
	ld wa,5
	push xwa
	ld wa,0
	push xwa
	ld wa,1
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ld wa,3071
	push xwa
	ld wa,239
	push xwa
	ld wa,85
	push xwa
	ld wa,0
	push xwa
	ld wa,2
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ld wa,4091
	push xwa
	ld wa,3972
	push xwa
	ld wa,1280
	push xwa
	ld wa,0
	push xwa
	ld wa,9
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ld wa,3067
	push xwa
	ld wa,1252
	push xwa
	ld wa,80
	push xwa
	ld wa,0
	push xwa
	ld wa,10
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ld wa,2
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld xwa,(xsp+0)
	ld xwa,(xwa)
	push xwa
	ld wa,2
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
	ld xwa,(xsp+0)
	ld xwa,(xwa+4)
	push xwa
	ld wa,3
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
	ld xwa,(xsp+0)
	ld a,(xwa+14)
	ld (_fx__17),a
	ldb (_timer__17),0
	ld izl,0
	jr L2062
L2059:
	ld a,0
	ld xbc,_life__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	call _rnd__17
	extz wa
	extz xwa
	div xwa,152
	ld wa,qwa
	sll 4,wa
	ld xbc,_px__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__17
	extz wa
	extz xwa
	div xwa,140
	ld wa,qwa
	sll 4,wa
	ld xbc,_py__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2061:
	inc 1,izl
L2062:
	ld a,izl
	cp a,14
	jr ult,L2059
L2060:
L2053:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function pal_of
_pal_of__17:
	ld xwa,_pals__17_L2066
	ld c,(xsp+4)
	extz bc
	and bc,3
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	jr L2065
L2065:
	ret

; function ending_tick
_ending_tick:
	push xiz
	lda xsp,(xsp-14)
	incb 1,(_timer__17)
	ld a,(_fx__17)
	cp a,1
	jp nz,L2104
	ld a,(_timer__17)
	extz wa
	extz xwa
	div xwa,40
	ld wa,qwa
	cp wa,1
	jp nz,L2104
	ld wa,24
	push xwa
	call _rnd__17
	ld xbc,xwa
	pop xwa
	extz bc
	extz xbc
	div xbc,112
	ld bc,qbc
	add wa,bc
	sll 4,wa
	ld (xsp+2),wa
	ld wa,20
	push xwa
	call _rnd__17
	ld xbc,xwa
	pop xwa
	extz bc
	extz xbc
	div xbc,40
	ld bc,qbc
	add wa,bc
	sll 4,wa
	ld (xsp+4),wa
	call _rnd__17
	push xwa
	call _pal_of__17
	lda xsp,(xsp+4)
	ld (xsp+6),a
	ld izl,0
	jp L2108
L2105:
	ld a,izl
	and a,7
	ld (xsp+7),a
	ld c,izl
	cp c,8
	jr uge,L2109
	ld wa,2
	jr L2110
L2109:
	ld wa,1
L2110:
	ld (xsp+8),wa
	ld wa,(xsp+2)
	ld xbc,_px__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+4)
	ld xbc,_py__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_dir_x__17
	ld c,(xsp+7)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	exts wa
	mul xwa,(xsp+8)
	ld xbc,_vx__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_dir_y__17
	ld c,(xsp+7)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	exts wa
	mul xwa,(xsp+8)
	ld xbc,_vy__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,34
	ld xbc,_life__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_ptile__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+6)
	ld xbc,_ppal__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2107:
	inc 1,izl
L2108:
	ld a,izl
	cp a,14
	jp ult,L2105
L2106:
L2104:
	ld izl,0
	jp L2114
L2111:
	ld a,56
	add a,izl
	ld (xsp+1),a
	ld a,(_fx__17)
	extz wa
	cp wa,1
	jr z,L2116
	cp wa,2
	jp z,L2117
	cp wa,3
	jp z,L2118
	cp wa,4
	jp z,L2119
	jp L2120
L2116:
	ld xwa,_life__17
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L2121
	ld xbc,_life__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld a,(xbc)
	dec 1,a
	ld (xbc),a
	ld xwa,_px__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_vx__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld xbc,_px__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_py__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_vy__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld xbc,_py__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_vy__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	add wa,1
	ld xbc,_vy__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2121:
	jp L2115
L2117:
	ld xwa,_life__17
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L2123
	ld xwa,_py__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2400
	jp le,L2122
L2123:
	call _rnd__17
	extz wa
	extz xwa
	div xwa,152
	ld wa,qwa
	sll 4,wa
	ld xbc,_px__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__17
	extz wa
	and wa,63
	neg wa
	sll 4,wa
	ld xbc,_py__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,12
	push xwa
	call _rnd__17
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,15
	add wa,bc
	ld xbc,_vy__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__17
	push xwa
	call _pal_of__17
	lda xsp,(xsp+4)
	ld xbc,_ppal__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,1
	ld xbc,_ptile__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,1
	ld xbc,_life__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2122:
	ld xwa,_py__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_vy__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld xbc,_py__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_px__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld e,(_timer__17)
	extz de
	ld l,izl
	extz hl
	mul xhl,9
	add de,hl
	and de,32
	cp de,0
	jr z,L2124
	ld bc,6
	jr L2125
L2124:
	ld bc,65530
L2125:
	add wa,bc
	ld xbc,_px__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jp L2115
L2118:
	ld xwa,_life__17
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L2127
	ld xwa,_py__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65408
	jp ge,L2126
L2127:
	ld wa,8
	push xwa
	call _rnd__17
	ld xbc,xwa
	pop xwa
	extz bc
	extz xbc
	div xbc,144
	ld bc,qbc
	add wa,bc
	sll 4,wa
	ld xbc,_px__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,152
	push xwa
	call _rnd__17
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,63
	add wa,bc
	sll 4,wa
	ld xbc,_py__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,8
	push xwa
	call _rnd__17
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,7
	add wa,bc
	neg wa
	ld xbc,_vy__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__17
	push xwa
	call _pal_of__17
	lda xsp,(xsp+4)
	ld xbc,_ppal__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,2
	ld xbc,_ptile__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,1
	ld xbc,_life__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2126:
	ld xwa,_py__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_vy__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld xbc,_py__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_px__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld e,(_timer__17)
	extz de
	ld l,izl
	extz hl
	mul xhl,13
	add de,hl
	and de,64
	cp de,0
	jr z,L2128
	ld bc,3
	jr L2129
L2128:
	ld bc,65533
L2129:
	add wa,bc
	ld xbc,_px__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jp L2115
L2119:
	ld xwa,_life__17
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp nz,L2130
	call _rnd__17
	extz wa
	extz xwa
	div xwa,152
	ld wa,qwa
	sll 4,wa
	ld xbc,_px__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__17
	extz wa
	extz xwa
	div xwa,100
	ld wa,qwa
	sll 4,wa
	ld xbc,_py__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,10
	push xwa
	call _rnd__17
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,31
	add wa,bc
	ld xbc,_life__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld c,izl
	extz bc
	and bc,1
	cp bc,0
	jr z,L2131
	ld wa,2
	jr L2132
L2131:
	ld wa,9
L2132:
	ld xbc,_ppal__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_ptile__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	jr L2133
L2130:
	ld xbc,_life__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld a,(xbc)
	dec 1,a
	ld (xbc),a
L2133:
	jr L2115
L2120:
	jr L2115
L2115:
	ld xwa,_life__17
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L2135
	ld xwa,_px__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65424
	jr lt,L2135
	ld xwa,_px__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2544
	jr gt,L2135
	ld xwa,_py__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65424
	jr lt,L2135
	ld xwa,_py__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2416
	jr gt,L2135
	ld a,(_fx__17)
	cp a,4
	jr nz,L2134
	ld xwa,_life__17
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	and wa,4
	cp wa,0
	jr z,L2134
L2135:
	ld a,(xsp+1)
	add a,1
	push xwa
	ld a,(xsp+5)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	jp L2113
L2134:
L2136:
	ld a,(xsp+1)
	ld (xsp+2),a
	ld xwa,_px__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	sra 4,wa
	ld (xsp+3),a
	ld xwa,_py__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	sra 4,wa
	ld (xsp+4),a
	ld wa,107
	ld xbc,_ptile__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	ld (xsp+6),wa
	ld xwa,_ppal__17
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+8),a
	ld a,0
	ld (xsp+9),a
	ld wa,34816
	ld c,(xsp+2)
	extz bc
	sll 2,bc
	add wa,bc
	extz xwa
	ld (xsp+10),xwa
	ld a,(xsp+6)
	and a,255
	ld xbc,(xsp+10)
	ld (xbc),a
	ld a,(xsp+9)
	extz wa
	ld c,(_id_spr_priority)
	extz bc
	or wa,bc
	ld bc,(xsp+6)
	srl 8,bc
	and bc,1
	extz bc
	or wa,bc
	ld xbc,(xsp+10)
	ld (xbc+1),a
	ld a,(xsp+3)
	ld xbc,(xsp+10)
	ld (xbc+2),a
	ld a,(xsp+4)
	ld xbc,(xsp+10)
	ld (xbc+3),a
	ld a,(xsp+8)
	and a,15
	ld bc,35840
	ld e,(xsp+2)
	extz de
	add bc,de
	extz xbc
	ld (xbc),a
L2138:
L2137:
L2113:
	inc 1,izl
L2114:
	ld a,izl
	cp a,14
	jp ult,L2111
L2112:
L2103:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function ending_stop
_ending_stop:
	ld a,70
	push xwa
	ld a,56
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	ldb (_fx__17),0
L2140:
	ret

; function dma0_program
_dma0_program__18:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma0_program_asm
	lda xsp,(xsp+12)
L2142:
	ret

; function dma1_program
_dma1_program__18:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma1_program_asm
	lda xsp,(xsp+12)
L2144:
	ret

; function dma2_program
_dma2_program__18:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma2_program_asm
	lda xsp,(xsp+12)
L2146:
	ret

; function dma3_program
_dma3_program__18:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma3_program_asm
	lda xsp,(xsp+12)
L2148:
	ret

; function dma0_program_u16
_dma0_program_u16__18:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma0_program_u16_asm
	lda xsp,(xsp+12)
L2150:
	ret

; function dma1_program_u16
_dma1_program_u16__18:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma1_program_u16_asm
	lda xsp,(xsp+12)
L2152:
	ret

; function dma2_program_u16
_dma2_program_u16__18:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma2_program_u16_asm
	lda xsp,(xsp+12)
L2154:
	ret

; function dma3_program_u16
_dma3_program_u16__18:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma3_program_u16_asm
	lda xsp,(xsp+12)
L2156:
	ret

; function dma0_program_u32
_dma0_program_u32__18:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma0_program_u32_asm
	lda xsp,(xsp+12)
L2158:
	ret

; function dma1_program_u32
_dma1_program_u32__18:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma1_program_u32_asm
	lda xsp,(xsp+12)
L2160:
	ret

; function dma2_program_u32
_dma2_program_u32__18:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma2_program_u32_asm
	lda xsp,(xsp+12)
L2162:
	ret

; function dma3_program_u32
_dma3_program_u32__18:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma3_program_u32_asm
	lda xsp,(xsp+12)
L2164:
	ret

; function dma0_clear
_dma0_clear__18:
	ld wa,0
	ldc dmac0,wa
	ld a,0
	ldc dmam0,a
L2166:
	ret

; function dma1_clear
_dma1_clear__18:
	ld wa,0
	ldc dmac1,wa
	ld a,0
	ldc dmam1,a
L2168:
	ret

; function dma2_clear
_dma2_clear__18:
	ld wa,0
	ldc dmac2,wa
	ld a,0
	ldc dmam2,a
L2170:
	ret

; function dma3_clear
_dma3_clear__18:
	ld wa,0
	ldc dmac3,wa
	ld a,0
	ldc dmam3,a
L2172:
	ret

; function dma_set_start_vector
_dma_set_start_vector__18:
	push xiz
	ld a,(xsp+12)
	ld izl,a
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2181
	cp wa,1
	jr z,L2182
	cp wa,2
	jr z,L2183
	cp wa,3
	jr z,L2184
	jr L2180
L2181:
	ld a,izl
	ld (07Ch),a
	jr L2180
L2182:
	ld a,izl
	ld (07Dh),a
	jr L2180
L2183:
	ld a,izl
	ld (07Eh),a
	jr L2180
L2184:
	ld a,izl
	ld (07Fh),a
	jr L2180
L2180:
L2179:
	pop xiz
	ret

; function dma_rearm_in_isr
_dma_rearm_in_isr__18:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	jr L2210
	jp L2209
L2210:
	ld a,izl
	cp a,3
	jr ule,L2211
	jp L2209
L2211:
	ld xwa,_s_rearm_enabled__18
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L2212
	jp L2209
L2212:
	ld wa,0
	push xwa
	ld a,izl
	push xwa
	call _dma_set_start_vector__18
	lda xsp,(xsp+8)
	ld xwa,_s_rearm_elem__18
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	cp wa,0
	jr z,L2215
	cp wa,1
	jp z,L2216
	cp wa,2
	jp z,L2217
	jr L2214
L2214:
L2215:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L2219
	cp wa,1
	jr z,L2220
	cp wa,2
	jp z,L2221
	cp wa,3
	jp z,L2222
	jp L2218
L2219:
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma0_program__18
	lda xsp,(xsp+12)
	jp L2218
L2220:
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma1_program__18
	lda xsp,(xsp+12)
	jp L2218
L2221:
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma2_program__18
	lda xsp,(xsp+12)
	jr L2218
L2222:
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma3_program__18
	lda xsp,(xsp+12)
	jr L2218
L2218:
	jp L2213
L2216:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L2224
	cp wa,1
	jr z,L2225
	cp wa,2
	jp z,L2226
	cp wa,3
	jp z,L2227
	jp L2223
L2224:
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma0_program_u16__18
	lda xsp,(xsp+12)
	jp L2223
L2225:
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma1_program_u16__18
	lda xsp,(xsp+12)
	jp L2223
L2226:
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma2_program_u16__18
	lda xsp,(xsp+12)
	jr L2223
L2227:
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma3_program_u16__18
	lda xsp,(xsp+12)
	jr L2223
L2223:
	jp L2213
L2217:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L2229
	cp wa,1
	jr z,L2230
	cp wa,2
	jp z,L2231
	cp wa,3
	jp z,L2232
	jp L2228
L2229:
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma0_program_u32__18
	lda xsp,(xsp+12)
	jp L2228
L2230:
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma1_program_u32__18
	lda xsp,(xsp+12)
	jp L2228
L2231:
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma2_program_u32__18
	lda xsp,(xsp+12)
	jr L2228
L2232:
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma3_program_u32__18
	lda xsp,(xsp+12)
	jr L2228
L2228:
	jr L2213
L2213:
	ld xwa,_s_rearm_vector__18
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld a,izl
	push xwa
	call _dma_set_start_vector__18
	lda xsp,(xsp+8)
L2209:
	pop xiz
	ret

; function isr_dma0_inttc
_isr_dma0_inttc__18:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	jr L2238
	ldb (_s_done_flag__18),1
L2238:
	ld wa,0
	push xwa
	call _dma_rearm_in_isr__18
	lda xsp,(xsp+4)
	jr L2239
	ld xwa,(_s_done_cb__18)
	cp xwa,0
	jr z,L2240
	ld xwa,(_s_done_cb__18)
	ld xhl,xwa
	call (xhl)
L2240:
L2239:
L2237:
	pop xiz
	pop xiy
	pop xix
	pop xhl
	pop xde
	pop xbc
	pop xwa
	reti

; function isr_dma1_inttc
_isr_dma1_inttc__18:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	jr L2246
	ldb (_s_done_flag__18+1),1
L2246:
	ld wa,1
	push xwa
	call _dma_rearm_in_isr__18
	lda xsp,(xsp+4)
	jr L2247
	ld xwa,(_s_done_cb__18+4)
	cp xwa,0
	jr z,L2248
	ld xwa,(_s_done_cb__18+4)
	ld xhl,xwa
	call (xhl)
L2248:
L2247:
L2245:
	pop xiz
	pop xiy
	pop xix
	pop xhl
	pop xde
	pop xbc
	pop xwa
	reti

; function isr_dma2_inttc
_isr_dma2_inttc__18:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	jr L2254
	ldb (_s_done_flag__18+2),1
L2254:
	ld wa,2
	push xwa
	call _dma_rearm_in_isr__18
	lda xsp,(xsp+4)
	jr L2255
	ld xwa,(_s_done_cb__18+8)
	cp xwa,0
	jr z,L2256
	ld xwa,(_s_done_cb__18+8)
	ld xhl,xwa
	call (xhl)
L2256:
L2255:
L2253:
	pop xiz
	pop xiy
	pop xix
	pop xhl
	pop xde
	pop xbc
	pop xwa
	reti

; function isr_dma3_inttc
_isr_dma3_inttc__18:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	jr L2262
	ldb (_s_done_flag__18+3),1
L2262:
	ld wa,3
	push xwa
	call _dma_rearm_in_isr__18
	lda xsp,(xsp+4)
	jr L2263
	ld xwa,(_s_done_cb__18+12)
	cp xwa,0
	jr z,L2264
	ld xwa,(_s_done_cb__18+12)
	ld xhl,xwa
	call (xhl)
L2264:
L2263:
L2261:
	pop xiz
	pop xiy
	pop xix
	pop xhl
	pop xde
	pop xbc
	pop xwa
	reti

; function dma_start_common
_dma_start_common__18:
	push xiz
	ld iz,(xsp+20)
	ld a,(xsp+8)
	cp a,3
	jr ule,L2291
	jp L2290
L2291:
	ld xwa,(xsp+12)
	cp xwa,0
	jr z,L2293
	ld xwa,(xsp+16)
	cp xwa,0
	jr nz,L2292
L2293:
	jp L2290
L2292:
	ld wa,iz
	cp wa,0
	jr nz,L2294
	jp L2290
L2294:
	ld a,(xsp+24)
	cp a,11
	jr nz,L2295
	jp L2290
L2295:
	ld a,0
	ld xbc,_s_done_flag__18
	ld e,(xsp+8)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,1
	ld xbc,_s_was_active__18
	ld e,(xsp+8)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,0
	push xwa
	ld a,(xsp+12)
	push xwa
	call _dma_set_start_vector__18
	lda xsp,(xsp+8)
	ld wa,(xsp+28)
	cp wa,0
	jr z,L2297
	cp wa,1
	jr z,L2298
	cp wa,2
	jp z,L2299
	jp L2296
L2297:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2301
	cp wa,1
	jr z,L2302
	cp wa,2
	jr z,L2303
	cp wa,3
	jr z,L2304
	jr L2300
L2301:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program__18
	lda xsp,(xsp+12)
	jr L2300
L2302:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program__18
	lda xsp,(xsp+12)
	jr L2300
L2303:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program__18
	lda xsp,(xsp+12)
	jr L2300
L2304:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program__18
	lda xsp,(xsp+12)
	jr L2300
L2300:
	jp L2296
L2298:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2306
	cp wa,1
	jr z,L2307
	cp wa,2
	jr z,L2308
	cp wa,3
	jr z,L2309
	jr L2305
L2306:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program_u16__18
	lda xsp,(xsp+12)
	jr L2305
L2307:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program_u16__18
	lda xsp,(xsp+12)
	jr L2305
L2308:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program_u16__18
	lda xsp,(xsp+12)
	jr L2305
L2309:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program_u16__18
	lda xsp,(xsp+12)
	jr L2305
L2305:
	jr L2296
L2299:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2311
	cp wa,1
	jr z,L2312
	cp wa,2
	jr z,L2313
	cp wa,3
	jr z,L2314
	jr L2310
L2311:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program_u32__18
	lda xsp,(xsp+12)
	jr L2310
L2312:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program_u32__18
	lda xsp,(xsp+12)
	jr L2310
L2313:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program_u32__18
	lda xsp,(xsp+12)
	jr L2310
L2314:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program_u32__18
	lda xsp,(xsp+12)
	jr L2310
L2310:
	jr L2296
L2296:
	ld a,(xsp+24)
	push xwa
	ld a,(xsp+12)
	push xwa
	call _dma_set_start_vector__18
	lda xsp,(xsp+8)
L2290:
	pop xiz
	ret

; function ngpc_dma_init
_ngpc_dma_init:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jp L2325
L2322:
	ld xwa,0
	ld xbc,_s_done_cb__18
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld a,0
	ld xbc,_s_done_flag__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_was_active__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_rearm_enabled__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_rearm_elem__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_rearm_vector__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,0
	ld xbc,_s_rearm_count__18
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,0
	ld xbc,_s_rearm_dst__18
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld xwa,0
	ld xbc,_s_rearm_src__18
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L2324:
	inc 1,izl
L2325:
	ld a,izl
	cp a,4
	jp ult,L2322
L2323:
	ld xwa,_isr_dma0_inttc__18
	ld (06FF0h),xwa
	ld xwa,_isr_dma1_inttc__18
	ld (06FF4h),xwa
	ld xwa,_isr_dma2_inttc__18
	ld (06FF8h),xwa
	ld xwa,_isr_dma3_inttc__18
	ld (06FFCh),xwa
	ldb (079h),153
	ldb (07Ah),153
L2326:
L2321:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_dma_start_table_u8
_ngpc_dma_start_table_u8:
	ld wa,0
	push xwa
	ld a,(xsp+24)
	push xwa
	ld wa,(xsp+24)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	ld a,(xsp+24)
	push xwa
	call _dma_start_common__18
	lda xsp,(xsp+24)
L2328:
	ret

; function ngpc_dma_start_table_u16
_ngpc_dma_start_table_u16:
	ld wa,1
	push xwa
	ld a,(xsp+24)
	push xwa
	ld wa,(xsp+24)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	ld a,(xsp+24)
	push xwa
	call _dma_start_common__18
	lda xsp,(xsp+24)
L2330:
	ret

; function ngpc_dma_start_table_u32
_ngpc_dma_start_table_u32:
	ld wa,2
	push xwa
	ld a,(xsp+24)
	push xwa
	ld wa,(xsp+24)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	ld a,(xsp+24)
	push xwa
	call _dma_start_common__18
	lda xsp,(xsp+24)
L2332:
	ret

; function ngpc_dma_link_hblank
_ngpc_dma_link_hblank:
	ld wa,16
	push xwa
	ld wa,(xsp+20)
	push xwa
	ld xwa,(xsp+20)
	push xwa
	ld xwa,(xsp+20)
	push xwa
	ld a,(xsp+20)
	push xwa
	call _ngpc_dma_start_table_u8
	lda xsp,(xsp+20)
L2334:
	ret

; function ngpc_dma_link_vblank
_ngpc_dma_link_vblank:
	ld wa,11
	push xwa
	ld wa,(xsp+20)
	push xwa
	ld xwa,(xsp+20)
	push xwa
	ld xwa,(xsp+20)
	push xwa
	ld a,(xsp+20)
	push xwa
	call _ngpc_dma_start_table_u8
	lda xsp,(xsp+20)
L2336:
	ret

; function ngpc_dma_link_hblank_u16
_ngpc_dma_link_hblank_u16:
	ld wa,16
	push xwa
	ld wa,(xsp+20)
	push xwa
	ld xwa,(xsp+20)
	push xwa
	ld xwa,(xsp+20)
	push xwa
	ld a,(xsp+20)
	push xwa
	call _ngpc_dma_start_table_u16
	lda xsp,(xsp+20)
L2338:
	ret

; function ngpc_dma_link_hblank_u32
_ngpc_dma_link_hblank_u32:
	ld wa,16
	push xwa
	ld wa,(xsp+20)
	push xwa
	ld xwa,(xsp+20)
	push xwa
	ld xwa,(xsp+20)
	push xwa
	ld a,(xsp+20)
	push xwa
	call _ngpc_dma_start_table_u32
	lda xsp,(xsp+20)
L2340:
	ret

; function ngpc_dma_timer0_hblank_enable
_ngpc_dma_timer0_hblank_enable:
	ld wa,1
	push xwa
	call _ngpc_dma_timer0_hblank_enable_treg0
	lda xsp,(xsp+4)
L2342:
	ret

; function ngpc_dma_timer0_hblank_enable_treg0
_ngpc_dma_timer0_hblank_enable_treg0:
	andb (024h),60
	ld a,(xsp+4)
	ld (022h),a
	orb (020h),1
L2344:
	ret

; function ngpc_dma_timer0_hblank_disable
_ngpc_dma_timer0_hblank_disable:
	andb (020h),254
L2346:
	ret

; function ngpc_dma_timer01_hblank_enable
_ngpc_dma_timer01_hblank_enable:
	andb (024h),48
	ldb (022h),1
	ldb (023h),1
	orb (020h),3
L2348:
	ret

; function ngpc_dma_timer01_hblank_disable
_ngpc_dma_timer01_hblank_disable:
	andb (020h),252
L2350:
	ret

; function ngpc_dma_timer1_from_timer0_enable
_ngpc_dma_timer1_from_timer0_enable:
	ld wa,1
	push xwa
	call _ngpc_dma_timer1_from_timer0_enable_treg1
	lda xsp,(xsp+4)
L2352:
	ret

; function ngpc_dma_timer1_from_timer0_enable_treg1
_ngpc_dma_timer1_from_timer0_enable_treg1:
	andb (024h),243
	ld a,(xsp+4)
	ld (023h),a
	orb (020h),2
L2354:
	ret

; function ngpc_dma_timer1_disable
_ngpc_dma_timer1_disable:
	andb (020h),253
L2356:
	ret

; function ngpc_dma_hblank_stream_begin
_ngpc_dma_hblank_stream_begin:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2360
	jr L2359
L2360:
	ld a,(xsp+12)
	ld (xiz),a
	ld xwa,(xsp+16)
	ld (xiz+2),xwa
	ld xwa,(xsp+20)
	ld (xiz+6),xwa
	ld wa,(xsp+24)
	ld (xiz+10),wa
L2359:
	pop xiz
	ret

; function ngpc_dma_hblank_stream_rearm
_ngpc_dma_hblank_stream_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2364
	jr L2363
L2364:
	ld wa,16
	push xwa
	ld wa,(xiz+10)
	push xwa
	ld xwa,(xiz+6)
	push xwa
	ld xwa,(xiz+2)
	push xwa
	ld a,(xiz)
	push xwa
	call _ngpc_dma_start_table_u8
	lda xsp,(xsp+20)
L2363:
	pop xiz
	ret

; function ngpc_dma_hblank_stream_end
_ngpc_dma_hblank_stream_end:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L2368
	jr L2367
L2368:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L2367:
	ret

; function ngpc_dma_stream_begin_u8
_ngpc_dma_stream_begin_u8:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2372
	jr L2371
L2372:
	ld a,(xsp+12)
	ld (xiz),a
	ld xwa,(xsp+16)
	ld (xiz+2),xwa
	ld xwa,(xsp+20)
	ld (xiz+6),xwa
	ld wa,(xsp+24)
	ld (xiz+10),wa
	ld a,(xsp+28)
	ld (xiz+12),a
L2371:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u8
_ngpc_dma_stream_rearm_u8:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2376
	jr L2375
L2376:
	ld a,(xiz+12)
	push xwa
	ld wa,(xiz+10)
	push xwa
	ld xwa,(xiz+6)
	push xwa
	ld xwa,(xiz+2)
	push xwa
	ld a,(xiz)
	push xwa
	call _ngpc_dma_start_table_u8
	lda xsp,(xsp+20)
L2375:
	pop xiz
	ret

; function ngpc_dma_stream_end_u8
_ngpc_dma_stream_end_u8:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L2380
	jr L2379
L2380:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L2379:
	ret

; function ngpc_dma_stream_begin_u16
_ngpc_dma_stream_begin_u16:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2384
	jr L2383
L2384:
	ld a,(xsp+12)
	ld (xiz),a
	ld xwa,(xsp+16)
	ld (xiz+2),xwa
	ld xwa,(xsp+20)
	ld (xiz+6),xwa
	ld wa,(xsp+24)
	ld (xiz+10),wa
	ld a,(xsp+28)
	ld (xiz+12),a
L2383:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u16
_ngpc_dma_stream_rearm_u16:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2388
	jr L2387
L2388:
	ld a,(xiz+12)
	push xwa
	ld wa,(xiz+10)
	push xwa
	ld xwa,(xiz+6)
	push xwa
	ld xwa,(xiz+2)
	push xwa
	ld a,(xiz)
	push xwa
	call _ngpc_dma_start_table_u16
	lda xsp,(xsp+20)
L2387:
	pop xiz
	ret

; function ngpc_dma_stream_end_u16
_ngpc_dma_stream_end_u16:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L2392
	jr L2391
L2392:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L2391:
	ret

; function ngpc_dma_stream_begin_u32
_ngpc_dma_stream_begin_u32:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2396
	jr L2395
L2396:
	ld a,(xsp+12)
	ld (xiz),a
	ld xwa,(xsp+16)
	ld (xiz+2),xwa
	ld xwa,(xsp+20)
	ld (xiz+6),xwa
	ld wa,(xsp+24)
	ld (xiz+10),wa
	ld a,(xsp+28)
	ld (xiz+12),a
L2395:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u32
_ngpc_dma_stream_rearm_u32:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2400
	jr L2399
L2400:
	ld a,(xiz+12)
	push xwa
	ld wa,(xiz+10)
	push xwa
	ld xwa,(xiz+6)
	push xwa
	ld xwa,(xiz+2)
	push xwa
	ld a,(xiz)
	push xwa
	call _ngpc_dma_start_table_u32
	lda xsp,(xsp+20)
L2399:
	pop xiz
	ret

; function ngpc_dma_stream_end_u32
_ngpc_dma_stream_end_u32:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L2404
	jr L2403
L2404:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L2403:
	ret

; function ngpc_dma_stop
_ngpc_dma_stop:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L2413
	jr L2412
L2413:
	ld wa,0
	push xwa
	ld a,izl
	push xwa
	call _dma_set_start_vector__18
	lda xsp,(xsp+8)
	ld a,0
	ld xbc,_s_was_active__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_done_flag__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,izl
	extz wa
	cp wa,0
	jr z,L2415
	cp wa,1
	jr z,L2416
	cp wa,2
	jr z,L2417
	cp wa,3
	jr z,L2418
	jr L2414
L2415:
	call _dma0_clear__18
	jr L2414
L2416:
	call _dma1_clear__18
	jr L2414
L2417:
	call _dma2_clear__18
	jr L2414
L2418:
	call _dma3_clear__18
	jr L2414
L2414:
L2412:
	pop xiz
	ret

; function ngpc_dma_remaining
_ngpc_dma_remaining:
	ld a,(xsp+4)
	extz wa
	cp wa,0
	jr z,L2428
	cp wa,1
	jr z,L2429
	cp wa,2
	jr z,L2430
	cp wa,3
	jr z,L2431
	jr L2432
L2428:
	ldc wa,dmac0
	jr L2426
L2429:
	ldc wa,dmac1
	jr L2426
L2430:
	ldc wa,dmac2
	jr L2426
L2431:
	ldc wa,dmac3
	jr L2426
L2432:
	ld wa,0
	jr L2426
L2427:
L2426:
	ret

; function ngpc_dma_active
_ngpc_dma_active:
	push xwa
	ld a,(xsp+8)
	push xwa
	call _ngpc_dma_remaining
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp bc,0
	jr z,L2437
	ld wa,1
	jr L2438
L2437:
	ld wa,0
L2438:
	jr L2436
L2436:
	ret

; function ngpc_dma_set_done_handler
_ngpc_dma_set_done_handler:
	ld a,(xsp+4)
	cp a,3
	jr ule,L2442
	jr L2441
L2442:
	ld xwa,(xsp+8)
	ld xbc,_s_done_cb__18
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L2441:
	ret

; function ngpc_dma_poll_done
_ngpc_dma_poll_done:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L2448
	ld wa,0
	jr L2447
L2448:
	ld xwa,_s_done_flag__18
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+0),a
	ld a,(xsp+0)
	cp a,0
	jr z,L2449
	ld a,0
	ld xbc,_s_done_flag__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_was_active__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,1
	jr L2447
L2449:
	ld xwa,_s_was_active__18
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L2450
	ld a,izl
	push xwa
	call _ngpc_dma_remaining
	lda xsp,(xsp+4)
	cp wa,0
	jr nz,L2450
	ld a,0
	ld xbc,_s_was_active__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,1
	jr L2447
L2450:
	ld wa,0
	jr L2447
L2447:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_dma_pp_init
_ngpc_dma_pp_init:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2454
	jr L2453
L2454:
	ld xwa,(xsp+12)
	ld (xiz),xwa
	ld wa,(xsp+16)
	ld (xiz+4),wa
	ldw (xiz+6),0
L2453:
	pop xiz
	ret

; function ngpc_dma_pp_front
_ngpc_dma_pp_front:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr z,L2460
	ld xwa,(xiz)
	cp xwa,0
	jr nz,L2459
L2460:
	ld xwa,0
	jr L2458
L2459:
	ld xwa,(xiz)
	ld bc,(xiz+6)
	extz xbc
	add xwa,xbc
	jr L2458
L2458:
	pop xiz
	ret

; function ngpc_dma_pp_back
_ngpc_dma_pp_back:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr z,L2466
	ld xwa,(xiz)
	cp xwa,0
	jr nz,L2465
L2466:
	ld xwa,0
	jr L2464
L2465:
	ld xwa,(xiz)
	ld bc,(xiz+6)
	xor bc,(xiz+4)
	extz xbc
	add xwa,xbc
	jr L2464
L2464:
	pop xiz
	ret

; function ngpc_dma_pp_swap
_ngpc_dma_pp_swap:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2470
	jr L2469
L2470:
	ld wa,(xiz+6)
	xor wa,(xiz+4)
	ld (xiz+6),wa
L2469:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u8
_ngpc_dma_autorearm_begin_u8:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L2474
	jr L2473
L2474:
	ld a,0
	ld xbc,_s_rearm_elem__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(xsp+12)
	ld xbc,_s_rearm_dst__18
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld xwa,(xsp+16)
	ld xbc,_s_rearm_src__18
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,(xsp+20)
	ld xbc,_s_rearm_count__18
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+24)
	ld xbc,_s_rearm_vector__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2473:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u16
_ngpc_dma_autorearm_begin_u16:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L2478
	jr L2477
L2478:
	ld a,1
	ld xbc,_s_rearm_elem__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(xsp+12)
	ld xbc,_s_rearm_dst__18
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld xwa,(xsp+16)
	ld xbc,_s_rearm_src__18
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,(xsp+20)
	ld xbc,_s_rearm_count__18
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+24)
	ld xbc,_s_rearm_vector__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2477:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u32
_ngpc_dma_autorearm_begin_u32:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L2482
	jr L2481
L2482:
	ld a,2
	ld xbc,_s_rearm_elem__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(xsp+12)
	ld xbc,_s_rearm_dst__18
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld xwa,(xsp+16)
	ld xbc,_s_rearm_src__18
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,(xsp+20)
	ld xbc,_s_rearm_count__18
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+24)
	ld xbc,_s_rearm_vector__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2481:
	pop xiz
	ret

; function ngpc_dma_autorearm_set_src_u8
_ngpc_dma_autorearm_set_src_u8:
	ld a,(xsp+4)
	cp a,3
	jr ule,L2486
	jr L2485
L2486:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__18
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L2485:
	ret

; function ngpc_dma_autorearm_set_src_u16
_ngpc_dma_autorearm_set_src_u16:
	ld a,(xsp+4)
	cp a,3
	jr ule,L2490
	jr L2489
L2490:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__18
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L2489:
	ret

; function ngpc_dma_autorearm_set_src_u32
_ngpc_dma_autorearm_set_src_u32:
	ld a,(xsp+4)
	cp a,3
	jr ule,L2494
	jr L2493
L2494:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__18
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L2493:
	ret

; function ngpc_dma_autorearm_enable
_ngpc_dma_autorearm_enable:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L2504
	jp L2503
L2504:
	jr L2505
	jp L2503
L2505:
	ld a,1
	ld xbc,_s_rearm_enabled__18
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,_s_rearm_elem__18
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	cp wa,0
	jr z,L2508
	cp wa,1
	jr z,L2509
	cp wa,2
	jp z,L2510
	jr L2507
L2507:
L2508:
	ld xwa,_s_rearm_vector__18
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld a,izl
	push xwa
	call _ngpc_dma_start_table_u8
	lda xsp,(xsp+20)
	jp L2506
L2509:
	ld xwa,_s_rearm_vector__18
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld a,izl
	push xwa
	call _ngpc_dma_start_table_u16
	lda xsp,(xsp+20)
	jr L2506
L2510:
	ld xwa,_s_rearm_vector__18
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,_s_rearm_count__18
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__18
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld a,izl
	push xwa
	call _ngpc_dma_start_table_u32
	lda xsp,(xsp+20)
	jr L2506
L2506:
L2503:
	pop xiz
	ret

; function ngpc_dma_autorearm_disable
_ngpc_dma_autorearm_disable:
	ld a,(xsp+4)
	cp a,3
	jr ule,L2514
	jr L2513
L2514:
	ld a,0
	ld xbc,_s_rearm_enabled__18
	ld e,(xsp+4)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2513:
	ret

; function plane_reg_x
_plane_reg_x__19:
	ld a,(xsp+4)
	cp a,1
	jr nz,L2518
	ld xwa,08034h
	jr L2517
L2518:
	ld xwa,08032h
	jr L2517
L2517:
	ret

; function plane_reg_y
_plane_reg_y__19:
	ld a,(xsp+4)
	cp a,1
	jr nz,L2522
	ld xwa,08035h
	jr L2521
L2522:
	ld xwa,08033h
	jr L2521
L2521:
	ret

; function ngpc_dma_raster_begin
_ngpc_dma_raster_begin:
	ld xwa,(xsp+16)
	push xwa
	ld wa,1
	push xwa
	ld xwa,(xsp+20)
	push xwa
	ld wa,0
	push xwa
	ld a,(xsp+24)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _ngpc_dma_raster_begin_ex
	lda xsp,(xsp+24)
L2524:
	ret

; function ngpc_dma_raster_begin_ex
_ngpc_dma_raster_begin_ex:
	push xiz
	lda xsp,(xsp-8)
	ld xiz,(xsp+16)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2534
	jp L2533
L2534:
	ld a,(xsp+20)
	ld (xiz),a
	ldb (xiz+1),0
	ld xwa,(xsp+28)
	ld (xiz+2),xwa
	ld xwa,(xsp+36)
	ld (xiz+6),xwa
	ld a,(xsp+20)
	push xwa
	call _plane_reg_x__19
	lda xsp,(xsp+4)
	ld (xsp+0),xwa
	ld a,(xsp+20)
	push xwa
	call _plane_reg_y__19
	lda xsp,(xsp+4)
	ld (xsp+4),xwa
	ld xwa,(xsp+28)
	cp xwa,0
	jr z,L2535
	ld wa,16
	push xwa
	ld wa,152
	push xwa
	ld xwa,(xsp+36)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld a,(xsp+40)
	push xwa
	lda xwa,(xiz+10)
	push xwa
	call _ngpc_dma_stream_begin_u8
	lda xsp,(xsp+24)
	jr L2536
L2535:
	ld xwa,(xsp+36)
	cp xwa,0
	jr z,L2537
	ld wa,16
	push xwa
	ld wa,152
	push xwa
	ld xwa,(xsp+44)
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld a,(xsp+40)
	push xwa
	lda xwa,(xiz+10)
	push xwa
	call _ngpc_dma_stream_begin_u8
	lda xsp,(xsp+24)
	jr L2538
L2537:
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld xwa,0
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld a,(xsp+40)
	push xwa
	lda xwa,(xiz+10)
	push xwa
	call _ngpc_dma_stream_begin_u8
	lda xsp,(xsp+24)
L2538:
L2536:
	ld xwa,(xsp+28)
	cp xwa,0
	jr z,L2539
	ld xwa,(xsp+36)
	cp xwa,0
	jr z,L2539
	ld wa,17
	push xwa
	ld wa,152
	push xwa
	ld xwa,(xsp+44)
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld a,(xsp+48)
	push xwa
	lda xwa,(xiz+24)
	push xwa
	call _ngpc_dma_stream_begin_u8
	lda xsp,(xsp+24)
	jr L2540
L2539:
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld xwa,0
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld a,(xsp+48)
	push xwa
	lda xwa,(xiz+24)
	push xwa
	call _ngpc_dma_stream_begin_u8
	lda xsp,(xsp+24)
L2540:
L2533:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function ngpc_dma_raster_enable
_ngpc_dma_raster_enable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2547
	jr L2546
L2547:
	ldb (xiz+1),0
	ld xwa,(xiz+2)
	cp xwa,0
	jr nz,L2548
	ld xwa,(xiz+6)
	cp xwa,0
	jr nz,L2548
	jr L2546
L2548:
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L2549
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L2549
	call _ngpc_dma_timer01_hblank_enable
	jr L2550
L2549:
	call _ngpc_dma_timer0_hblank_enable
L2550:
	ldb (xiz+1),1
L2546:
	pop xiz
	ret

; function ngpc_dma_raster_rearm
_ngpc_dma_raster_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2559
	jr L2558
L2559:
	ld a,(xiz+1)
	cp a,0
	jr nz,L2560
	jr L2558
L2560:
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L2561
	lda xwa,(xiz+10)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L2562
	lda xwa,(xiz+24)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
L2562:
	jr L2563
L2561:
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L2564
	lda xwa,(xiz+10)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
L2564:
L2563:
L2558:
	pop xiz
	ret

; function ngpc_dma_raster_disable
_ngpc_dma_raster_disable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2571
	jr L2570
L2571:
	ld a,(xiz+1)
	cp a,0
	jr z,L2572
	ld a,(xiz+10)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L2573
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L2573
	ld a,(xiz+24)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	call _ngpc_dma_timer01_hblank_disable
	jr L2574
L2573:
	call _ngpc_dma_timer0_hblank_disable
L2574:
L2572:
	ldb (xiz+1),0
L2570:
	pop xiz
	ret

; function ngpc_dma_raster_build_parallax_table
_ngpc_dma_raster_build_parallax_table:
	push xiz
	lda xsp,(xsp-6)
	ld xiy,(xsp+18)
	ld xwa,(xsp+14)
	cp xwa,0
	jr nz,L2594
	jp L2593
L2594:
	ld xwa,xiy
	cp xwa,0
	jr z,L2596
	ld a,(xsp+22)
	cp a,0
	jr nz,L2595
L2596:
	ld izl,0
	jr L2600
L2597:
	ld a,0
	ld xbc,(xsp+14)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2599:
	inc 1,izl
L2600:
	ld a,izl
	cp a,152
	jr ult,L2597
L2598:
	jp L2593
L2595:
	ld ixl,0
	jp L2604
L2601:
	ld xwa,xiy
	ld c,ixl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+2),a
	ld c,ixl
	extz bc
	add bc,1
	ld e,(xsp+22)
	extz de
	cp bc,de
	jr ge,L2605
	ld xwa,xiy
	ld c,ixl
	extz bc
	add bc,1
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L2606
L2605:
	ld a,152
	extz wa
L2606:
	ld (xsp+3),a
	ld wa,(xsp+26)
	ld xbc,xiy
	ld e,ixl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld bc,(xbc+2)
	mul xwa,bc
	srl 8,xwa
	ld (xsp+4),a
	ld a,(xsp+2)
	ld izl,a
	jr L2610
L2607:
	ld a,(xsp+4)
	ld xbc,(xsp+14)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2609:
	inc 1,izl
L2610:
	ld a,izl
	cp a,(xsp+3)
	jr ult,L2607
L2608:
L2603:
	inc 1,ixl
L2604:
	ld a,ixl
	cp a,(xsp+22)
	jp ult,L2601
L2602:
L2593:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_dma_raster_xy_begin
_ngpc_dma_raster_xy_begin:
	ld xwa,(xsp+12)
	push xwa
	ld wa,0
	push xwa
	ld a,(xsp+16)
	push xwa
	ld xwa,(xsp+16)
	push xwa
	call _ngpc_dma_raster_xy_begin_ex
	lda xsp,(xsp+16)
L2612:
	ret

; function ngpc_dma_raster_xy_begin_ex
_ngpc_dma_raster_xy_begin_ex:
	push xiz
	lda xsp,(xsp-4)
	ld xiz,(xsp+12)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2618
	jr L2617
L2618:
	ld a,(xsp+16)
	ld (xiz),a
	ldb (xiz+1),0
	ld xwa,(xsp+24)
	ld (xiz+2),xwa
	ld a,(xsp+16)
	push xwa
	call _plane_reg_x__19
	lda xsp,(xsp+4)
	ld (xsp+0),xwa
	ld xwa,(xsp+24)
	cp xwa,0
	jr z,L2619
	ld wa,16
	push xwa
	ld wa,152
	push xwa
	ld xwa,(xsp+32)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld a,(xsp+36)
	push xwa
	lda xwa,(xiz+6)
	push xwa
	call _ngpc_dma_stream_begin_u16
	lda xsp,(xsp+24)
	jr L2620
L2619:
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld xwa,0
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld a,(xsp+36)
	push xwa
	lda xwa,(xiz+6)
	push xwa
	call _ngpc_dma_stream_begin_u16
	lda xsp,(xsp+24)
L2620:
L2617:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function ngpc_dma_raster_xy_enable
_ngpc_dma_raster_xy_enable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2625
	jr L2624
L2625:
	ldb (xiz+1),0
	ld xwa,(xiz+2)
	cp xwa,0
	jr nz,L2626
	jr L2624
L2626:
	call _ngpc_dma_timer0_hblank_enable
	ldb (xiz+1),1
L2624:
	pop xiz
	ret

; function ngpc_dma_raster_xy_rearm
_ngpc_dma_raster_xy_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2631
	jr L2630
L2631:
	ld a,(xiz+1)
	cp a,0
	jr nz,L2632
	jr L2630
L2632:
	lda xwa,(xiz+6)
	push xwa
	call _ngpc_dma_stream_rearm_u16
	lda xsp,(xsp+4)
L2630:
	pop xiz
	ret

; function ngpc_dma_raster_xy_disable
_ngpc_dma_raster_xy_disable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2637
	jr L2636
L2637:
	ld a,(xiz+1)
	cp a,0
	jr z,L2638
	ld a,(xiz+6)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	call _ngpc_dma_timer0_hblank_disable
L2638:
	ldb (xiz+1),0
L2636:
	pop xiz
	ret

; function ngpc_dma_raster_build_parallax_table_xy
_ngpc_dma_raster_build_parallax_table_xy:
	push xiz
	lda xsp,(xsp-8)
	ld xiy,(xsp+20)
	ld xwa,(xsp+16)
	cp xwa,0
	jr nz,L2658
	jp L2657
L2658:
	ld xwa,xiy
	cp xwa,0
	jr z,L2660
	ld a,(xsp+24)
	cp a,0
	jr nz,L2659
L2660:
	ld izl,0
	jr L2664
L2661:
	ld a,(xsp+32)
	extz wa
	sll 8,wa
	or wa,0
	ld xbc,(xsp+16)
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2663:
	inc 1,izl
L2664:
	ld a,izl
	cp a,152
	jr ult,L2661
L2662:
	jp L2657
L2659:
	ld ixl,0
	jp L2668
L2665:
	ld xwa,xiy
	ld c,ixl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+2),a
	ld c,ixl
	extz bc
	add bc,1
	ld e,(xsp+24)
	extz de
	cp bc,de
	jr ge,L2669
	ld xwa,xiy
	ld c,ixl
	extz bc
	add bc,1
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L2670
L2669:
	ld a,152
	extz wa
L2670:
	ld (xsp+3),a
	ld wa,(xsp+28)
	ld xbc,xiy
	ld e,ixl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld bc,(xbc+2)
	mul xwa,bc
	srl 8,xwa
	ld (xsp+4),a
	ld a,(xsp+32)
	extz wa
	sll 8,wa
	ld c,(xsp+4)
	extz bc
	or wa,bc
	ld (xsp+6),wa
	ld a,(xsp+2)
	ld izl,a
	jr L2674
L2671:
	ld wa,(xsp+6)
	ld xbc,(xsp+16)
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2673:
	inc 1,izl
L2674:
	ld a,izl
	cp a,(xsp+3)
	jr ult,L2671
L2672:
L2667:
	inc 1,ixl
L2668:
	ld a,ixl
	cp a,(xsp+24)
	jp ult,L2665
L2666:
L2657:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function audio_init
_audio_init:
	call _player_init
L2676:
	ret

; function audio_update
_audio_update:
	call _player_update
L2678:
	ret

; function music_play
_music_play:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	cp a,6
	jr ult,L2682
	call _music_stop
	jr L2681
L2682:
	ld xwa,_music_songs
	ld c,(xsp+12)
	extz bc
	muls xbc,18
	add xwa,xbc
	lda xwa,(xwa)
	ld xiz,xwa
	ld a,(xsp+12)
	ld (_cur_song__20),a
	ld xwa,(xiz+12)
	push xwa
	ld xwa,(xiz+8)
	push xwa
	ld xwa,(xiz+4)
	push xwa
	ld xwa,(xiz)
	push xwa
	call _player_start
	lda xsp,(xsp+16)
L2681:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function music_stop
_music_stop:
	call _player_stop
	ldb (_cur_song__20),255
L2684:
	ret

; function music_fade
_music_fade:
	call _player_stop
L2686:
	ret

; function music_current
_music_current:
	ld a,(_cur_song__20)
	jr L2688
L2688:
	ret

; function sfx
_sfx:
	ld a,(xsp+4)
	extz wa
	cp wa,0
	jr z,L2702
	cp wa,1
	jr z,L2703
	cp wa,2
	jr z,L2704
	cp wa,3
	jp z,L2705
	cp wa,4
	jp z,L2706
	cp wa,5
	jp z,L2707
	cp wa,7
	jp z,L2708
	cp wa,6
	jp z,L2709
	jp L2710
L2702:
	ld wa,0
	push xwa
	ld wa,12
	push xwa
	ld wa,1
	push xwa
	ld wa,0
	push xwa
	ld wa,98
	push xwa
	ld wa,1
	push xwa
	call _player_sfx_tone
	lda xsp,(xsp+24)
	jp L2701
L2703:
	ld wa,6
	push xwa
	ld wa,45
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,49
	push xwa
	ld wa,1
	push xwa
	call _player_sfx_tone
	lda xsp,(xsp+24)
	jp L2701
L2704:
	ld wa,5
	push xwa
	ld wa,70
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,98
	push xwa
	ld wa,1
	push xwa
	call _player_sfx_tone
	lda xsp,(xsp+24)
	ld wa,4
	push xwa
	ld wa,50
	push xwa
	ld wa,3
	push xwa
	ld wa,0
	push xwa
	ld wa,65
	push xwa
	ld wa,2
	push xwa
	call _player_sfx_tone
	lda xsp,(xsp+24)
	jp L2701
L2705:
	ld wa,4
	push xwa
	ld wa,60
	push xwa
	ld wa,0
	push xwa
	ld wa,5
	push xwa
	call _player_sfx_noise
	lda xsp,(xsp+16)
	jr L2701
L2706:
	ld wa,1
	push xwa
	ld wa,10
	push xwa
	ld wa,2
	push xwa
	ld wa,6
	push xwa
	call _player_sfx_noise
	lda xsp,(xsp+16)
	jr L2701
L2707:
	ld wa,0
	push xwa
	ld wa,5
	push xwa
	ld wa,3
	push xwa
	ld wa,0
	push xwa
	ld wa,140
	push xwa
	ld wa,1
	push xwa
	call _player_sfx_tone
	lda xsp,(xsp+24)
	jr L2701
L2708:
	ld wa,0
	push xwa
	ld wa,8
	push xwa
	ld wa,2
	push xwa
	ld wa,2
	push xwa
	ld wa,90
	push xwa
	ld wa,2
	push xwa
	call _player_sfx_tone
	lda xsp,(xsp+24)
	jr L2701
L2709:
	ld wa,1
	push xwa
	ld wa,6
	push xwa
	ld wa,2
	push xwa
	ld wa,0
	push xwa
	ld wa,160
	push xwa
	ld wa,1
	push xwa
	call _player_sfx_tone
	lda xsp,(xsp+24)
	jr L2701
L2710:
	jr L2701
L2701:
L2700:
	ret

; function scr_map
_scr_map__21:
	ld c,(xsp+4)
	cp c,0
	jr nz,L2715
	ld xwa,36864
	jr L2716
L2715:
	ld xwa,38912
L2716:
	jr L2714
L2714:
	ret

; function pal_base
_pal_base__21:
	ld a,(xsp+4)
	cp a,2
	jr nz,L2721
	ld xwa,33280
	jr L2720
L2721:
	ld a,(xsp+4)
	cp a,0
	jr nz,L2722
	ld xwa,33408
	jr L2720
L2722:
	ld xwa,33536
	jr L2720
L2720:
	ret

; function ngpc_gfx_load_tiles
_ngpc_gfx_load_tiles:
	push xiz
	lda xsp,(xsp-8)
	ld xwa,40960
	ld xiy,xwa
	ld iz,0
	jr L2732
L2729:
	ld xwa,(xsp+16)
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld ix,wa
	ld a,ixl
	and a,255
	ld xbc,xiy
	ld de,iz
	sll 1,de
	add de,0
	extz xde
	add xbc,xde
	ld (xbc),a
	ld wa,ix
	srl 8,wa
	ld xbc,xiy
	ld de,iz
	sll 1,de
	add de,1
	extz xde
	add xbc,xde
	ld (xbc),a
L2731:
	inc 1,iz
L2732:
	ld wa,iz
	cp wa,(xsp+20)
	jr ult,L2729
L2730:
L2728:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function ngpc_gfx_load_tiles_at
_ngpc_gfx_load_tiles_at:
	push xiz
	lda xsp,(xsp-8)
	ld xwa,40960
	ld bc,(xsp+24)
	sll 3,bc
	sll 1,bc
	extz xbc
	add xwa,xbc
	ld xiy,xwa
	ld iz,0
	jr L2742
L2739:
	ld xwa,(xsp+16)
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld ix,wa
	ld a,ixl
	and a,255
	ld xbc,xiy
	ld de,iz
	sll 1,de
	add de,0
	extz xde
	add xbc,xde
	ld (xbc),a
	ld wa,ix
	srl 8,wa
	ld xbc,xiy
	ld de,iz
	sll 1,de
	add de,1
	extz xde
	add xbc,xde
	ld (xbc),a
L2741:
	inc 1,iz
L2742:
	ld wa,iz
	cp wa,(xsp+20)
	jr ult,L2739
L2740:
L2738:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function ngpc_gfx_load_tiles_u8
_ngpc_gfx_load_tiles_u8:
	push xiz
	lda xsp,(xsp-8)
	ld xwa,40960
	ld xiy,xwa
	ld wa,(xsp+20)
	sll 4,wa
	ld ix,wa
	ld iz,0
	jr L2752
L2749:
	ld xwa,(xsp+16)
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld xbc,xiy
	ld de,iz
	extz xde
	add xbc,xde
	ld (xbc),a
L2751:
	inc 1,iz
L2752:
	ld wa,iz
	cp wa,ix
	jr ult,L2749
L2750:
L2748:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function ngpc_gfx_load_tiles_u8_at
_ngpc_gfx_load_tiles_u8_at:
	push xiz
	lda xsp,(xsp-8)
	ld xwa,40960
	ld bc,(xsp+24)
	sll 4,bc
	extz xbc
	add xwa,xbc
	ld xiy,xwa
	ld wa,(xsp+20)
	sll 4,wa
	ld ix,wa
	ld iz,0
	jr L2762
L2759:
	ld xwa,(xsp+16)
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld xbc,xiy
	ld de,iz
	extz xde
	add xbc,xde
	ld (xbc),a
L2761:
	inc 1,iz
L2762:
	ld wa,iz
	cp wa,ix
	jr ult,L2759
L2760:
L2758:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function make_entry
_make_entry__21:
	ld wa,(xsp+4)
	and wa,255
	ld bc,(xsp+4)
	srl 8,bc
	and bc,1
	sll 8,bc
	or wa,bc
	ld c,(xsp+8)
	extz bc
	and bc,15
	sll 9,bc
	or wa,bc
	ld c,(xsp+12)
	extz bc
	and bc,1
	sll 15,bc
	or wa,bc
	ld c,(xsp+16)
	extz bc
	and bc,1
	sll 14,bc
	or wa,bc
	jr L2764
L2764:
	ret

; function ngpc_gfx_put_tile
_ngpc_gfx_put_tile:
	lda xsp,(xsp-4)
	ld a,(xsp+8)
	push xwa
	call _scr_map__21
	lda xsp,(xsp+4)
	ld (xsp+0),xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld a,(xsp+32)
	push xwa
	ld wa,(xsp+32)
	push xwa
	call _make_entry__21
	lda xsp,(xsp+16)
	ld xbc,(xsp+0)
	ld e,(xsp+16)
	extz de
	sll 5,de
	ld l,(xsp+12)
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2766:
	lda xsp,(xsp+4)
	ret

; function ngpc_gfx_put_tile_ex
_ngpc_gfx_put_tile_ex:
	lda xsp,(xsp-4)
	ld a,(xsp+8)
	push xwa
	call _scr_map__21
	lda xsp,(xsp+4)
	ld (xsp+0),xwa
	ld a,(xsp+32)
	push xwa
	ld a,(xsp+32)
	push xwa
	ld a,(xsp+32)
	push xwa
	ld wa,(xsp+32)
	push xwa
	call _make_entry__21
	lda xsp,(xsp+16)
	ld xbc,(xsp+0)
	ld e,(xsp+16)
	extz de
	sll 5,de
	ld l,(xsp+12)
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2768:
	lda xsp,(xsp+4)
	ret

; function ngpc_gfx_get_tile
_ngpc_gfx_get_tile:
	push xiz
	lda xsp,(xsp-6)
	ld a,(xsp+14)
	push xwa
	call _scr_map__21
	lda xsp,(xsp+4)
	ld (xsp+0),xwa
	ld xwa,(xsp+0)
	ld c,(xsp+22)
	extz bc
	sll 5,bc
	ld e,(xsp+18)
	extz de
	add bc,de
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld iz,wa
	ld wa,iz
	and wa,255
	ld bc,iz
	srl 8,bc
	and bc,1
	sll 8,bc
	or wa,bc
	ld xbc,(xsp+26)
	ld (xbc),wa
	ld wa,iz
	srl 9,wa
	and wa,15
	ld xbc,(xsp+30)
	ld (xbc),a
L2770:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_gfx_clear
_ngpc_gfx_clear:
	push xiz
	lda xsp,(xsp-6)
	push xix
	ld a,(xsp+18)
	push xwa
	call _scr_map__21
	lda xsp,(xsp+4)
	pop xix
	ld xix,xwa
	ld iz,0
	jr L2780
L2777:
	ld wa,0
	ld xbc,xix
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2779:
	inc 1,iz
L2780:
	ld wa,iz
	cp wa,1024
	jr ult,L2777
L2778:
L2776:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_gfx_fill
_ngpc_gfx_fill:
	push xiz
	lda xsp,(xsp-8)
	push xix
	push xiy
	ld a,(xsp+24)
	push xwa
	call _scr_map__21
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld xiy,xwa
	push xix
	push xiy
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld a,(xsp+40)
	push xwa
	ld wa,(xsp+40)
	push xwa
	call _make_entry__21
	lda xsp,(xsp+16)
	pop xiy
	pop xix
	ld ix,wa
	ld iz,0
	jr L2790
L2787:
	ld wa,ix
	ld xbc,xiy
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2789:
	inc 1,iz
L2790:
	ld wa,iz
	cp wa,1024
	jr ult,L2787
L2788:
L2786:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function ngpc_gfx_fill_rect
_ngpc_gfx_fill_rect:
	push xiz
	lda xsp,(xsp-12)
	push xix
	push xiy
	ld a,(xsp+28)
	push xwa
	call _scr_map__21
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (xsp+0),xwa
	push xix
	push xiy
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld a,(xsp+60)
	push xwa
	ld wa,(xsp+60)
	push xwa
	call _make_entry__21
	lda xsp,(xsp+16)
	pop xiy
	pop xix
	ld (xsp+4),wa
	ld ixl,0
	jr L2804
L2801:
	ld a,(xsp+28)
	add a,ixl
	and a,31
	ld (xsp+8),a
	ld a,(xsp+8)
	extz wa
	sll 5,wa
	ld (xsp+10),wa
	ld izl,0
	jr L2808
L2805:
	ld a,(xsp+24)
	add a,izl
	and a,31
	ld iyl,a
	ld wa,(xsp+4)
	ld xbc,(xsp+0)
	ld de,(xsp+10)
	ld l,iyl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2807:
	inc 1,izl
L2808:
	ld a,izl
	cp a,(xsp+32)
	jr ult,L2805
L2806:
L2803:
	inc 1,ixl
L2804:
	ld a,ixl
	cp a,(xsp+36)
	jr ult,L2801
L2802:
L2800:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function ngpc_gfx_set_rect_pal
_ngpc_gfx_set_rect_pal:
	push xiz
	lda xsp,(xsp-14)
	push xix
	push xiy
	ld a,(xsp+30)
	push xwa
	call _scr_map__21
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (xsp+0),xwa
	ld a,(xsp+42)
	extz wa
	and wa,15
	sll 9,wa
	ld (xsp+4),wa
	ldb (xsp+6),0
	jr L2822
L2819:
	ld a,(xsp+30)
	add a,(xsp+6)
	and a,31
	ld (xsp+8),a
	ld a,(xsp+8)
	extz wa
	sll 5,wa
	ld (xsp+10),wa
	ld ixl,0
	jr L2826
L2823:
	ld a,(xsp+26)
	add a,ixl
	and a,31
	ld iyl,a
	ld xwa,(xsp+0)
	ld bc,(xsp+10)
	ld e,iyl
	extz de
	add bc,de
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld iz,wa
	ld wa,iz
	and wa,57855
	or wa,(xsp+4)
	ld iz,wa
	ld wa,iz
	ld xbc,(xsp+0)
	ld de,(xsp+10)
	ld l,iyl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2825:
	inc 1,ixl
L2826:
	ld a,ixl
	cp a,(xsp+34)
	jr ult,L2823
L2824:
L2821:
	incb 1,(xsp+6)
L2822:
	ld a,(xsp+6)
	cp a,(xsp+38)
	jr ult,L2819
L2820:
L2818:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function ngpc_gfx_set_palette
_ngpc_gfx_set_palette:
	push xiz
	lda xsp,(xsp-6)
	push xix
	ld a,(xsp+18)
	push xwa
	call _pal_base__21
	lda xsp,(xsp+4)
	pop xix
	ld xix,xwa
	ld a,(xsp+18)
	extz wa
	sll 2,wa
	ld iz,wa
	ld wa,(xsp+22)
	ld xbc,xix
	ld de,iz
	add de,0
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+26)
	ld xbc,xix
	ld de,iz
	add de,1
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+30)
	ld xbc,xix
	ld de,iz
	add de,2
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+34)
	ld xbc,xix
	ld de,iz
	add de,3
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2828:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_gfx_set_bg_color
_ngpc_gfx_set_bg_color:
	ld wa,(xsp+4)
	ld xbc,33760
	ld (xbc),wa
	ldb (08118h),128
L2830:
	ret

; function ngpc_gfx_scroll
_ngpc_gfx_scroll:
	ld a,(xsp+4)
	cp a,0
	jr nz,L2835
	ld a,(xsp+8)
	ld (08032h),a
	ld a,(xsp+12)
	ld (08033h),a
	jr L2836
L2835:
	ld a,(xsp+8)
	ld (08034h),a
	ld a,(xsp+12)
	ld (08035h),a
L2836:
L2834:
	ret

; function ngpc_gfx_scroll_parallax
_ngpc_gfx_scroll_parallax:
	push xiz
	ld a,(xsp+16)
	ld ixl,a
	ld a,(xsp+20)
	ld izl,a
	ld a,ixl
	cp a,255
	jr nz,L2851
	ldb (08032h),0
	ldb (08033h),0
	jr L2852
L2851:
	ld a,(xsp+8)
	extz wa
	ld c,ixl
	cp c,0
	jr z,L2854
L2853:
	sra 1,wa
	djnz c,L2853
L2854:
	ld (08032h),a
	ld a,(xsp+12)
	extz wa
	ld c,ixl
	cp c,0
	jr z,L2856
L2855:
	sra 1,wa
	djnz c,L2855
L2856:
	ld (08033h),a
L2852:
	ld a,izl
	cp a,255
	jr nz,L2857
	ldb (08034h),0
	ldb (08035h),0
	jr L2858
L2857:
	ld a,(xsp+8)
	extz wa
	ld c,izl
	cp c,0
	jr z,L2860
L2859:
	sra 1,wa
	djnz c,L2859
L2860:
	ld (08034h),a
	ld a,(xsp+12)
	extz wa
	ld c,izl
	cp c,0
	jr z,L2862
L2861:
	sra 1,wa
	djnz c,L2861
L2862:
	ld (08035h),a
L2858:
L2850:
	pop xiz
	ret

; function ngpc_gfx_swap_planes
_ngpc_gfx_swap_planes:
	xorb (08030h),128
L2864:
	ret

; function ngpc_gfx_set_viewport
_ngpc_gfx_set_viewport:
	ld a,(xsp+4)
	ld (08002h),a
	ld a,(xsp+8)
	ld (08003h),a
	ld a,(xsp+12)
	ld (08004h),a
	ld a,(xsp+16)
	ld (08005h),a
L2866:
	ret

; function ngpc_gfx_sprite_offset
_ngpc_gfx_sprite_offset:
	ld a,(xsp+4)
	ld (08020h),a
	ld a,(xsp+8)
	ld (08021h),a
L2868:
	ret

; function ngpc_gfx_lcd_invert
_ngpc_gfx_lcd_invert:
	ld a,(xsp+4)
	cp a,0
	jr z,L2873
	orb (08012h),128
	jr L2874
L2873:
	andb (08012h),127
L2874:
L2872:
	ret

; function ngpc_gfx_set_outside_color
_ngpc_gfx_set_outside_color:
	ld a,(08012h)
	and a,248
	ld c,(xsp+4)
	and c,7
	or a,c
	ld (08012h),a
L2876:
	ret

; function ngpc_gfx_char_over
_ngpc_gfx_char_over:
	ld c,(08010h)
	extz bc
	and bc,128
	cp bc,0
	jr z,L2881
	ld wa,1
	jr L2882
L2881:
	ld wa,0
L2882:
	jr L2880
L2880:
	ret

; function ngpc_gfx_set_color_direct
_ngpc_gfx_set_color_direct:
	lda xsp,(xsp-4)
	ld a,(xsp+8)
	push xwa
	call _pal_base__21
	lda xsp,(xsp+4)
	ld (xsp+0),xwa
	ld wa,(xsp+20)
	ld xbc,(xsp+0)
	ld e,(xsp+12)
	extz de
	sll 2,de
	ld l,(xsp+16)
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2884:
	lda xsp,(xsp+4)
	ret

; function ngpc_tile_rotate90
_ngpc_tile_rotate90:
	push xiz
	lda xsp,(xsp-6)
	ld ixl,0
	jr L2902
L2899:
	ld iy,0
	ld izl,0
	jr L2906
L2903:
	ld xwa,(xsp+14)
	ld bc,7
	ld e,izl
	extz de
	sub bc,de
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld bc,14
	ld e,ixl
	extz de
	sll 1,de
	sub bc,de
	cp c,0
	jr z,L2908
L2907:
	srl 1,wa
	djnz c,L2907
L2908:
	and wa,3
	ld (xsp+4),a
	ld wa,iy
	ld c,(xsp+4)
	extz bc
	ld de,14
	ld l,izl
	extz hl
	sll 1,hl
	sub de,hl
	cp e,0
	jr z,L2910
L2909:
	sll 1,bc
	djnz e,L2909
L2910:
	or wa,bc
	ld iy,wa
L2905:
	inc 1,izl
L2906:
	ld a,izl
	cp a,8
	jr ult,L2903
L2904:
	ld wa,iy
	ld xbc,(xsp+18)
	ld e,ixl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2901:
	inc 1,ixl
L2902:
	ld a,ixl
	cp a,8
	jp ult,L2899
L2900:
L2898:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_tile_rotate270
_ngpc_tile_rotate270:
	push xiz
	lda xsp,(xsp-6)
	ld ixl,0
	jr L2928
L2925:
	ld iy,0
	ld izl,0
	jr L2932
L2929:
	ld xwa,(xsp+14)
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld bc,14
	ld de,7
	ld l,ixl
	extz hl
	sub de,hl
	sll 1,de
	sub bc,de
	cp c,0
	jr z,L2934
L2933:
	srl 1,wa
	djnz c,L2933
L2934:
	and wa,3
	ld (xsp+4),a
	ld wa,iy
	ld c,(xsp+4)
	extz bc
	ld de,14
	ld l,izl
	extz hl
	sll 1,hl
	sub de,hl
	cp e,0
	jr z,L2936
L2935:
	sll 1,bc
	djnz e,L2935
L2936:
	or wa,bc
	ld iy,wa
L2931:
	inc 1,izl
L2932:
	ld a,izl
	cp a,8
	jr ult,L2929
L2930:
	ld wa,iy
	ld xbc,(xsp+18)
	ld e,ixl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2927:
	inc 1,ixl
L2928:
	ld a,ixl
	cp a,8
	jp ult,L2925
L2926:
L2924:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_tile_rotate90_to
_ngpc_tile_rotate90_to:
	lda xsp,(xsp-16)
	lda xwa,(xsp+0)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _ngpc_tile_rotate90
	lda xsp,(xsp+8)
	ld wa,(xsp+24)
	push xwa
	ld wa,8
	push xwa
	lda xwa,(xsp+8)
	push xwa
	call _ngpc_gfx_load_tiles_at
	lda xsp,(xsp+12)
L2938:
	lda xsp,(xsp+16)
	ret

; function ngpc_tile_rotate270_to
_ngpc_tile_rotate270_to:
	lda xsp,(xsp-16)
	lda xwa,(xsp+0)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _ngpc_tile_rotate270
	lda xsp,(xsp+8)
	ld wa,(xsp+24)
	push xwa
	ld wa,8
	push xwa
	lda xwa,(xsp+8)
	push xwa
	call _ngpc_gfx_load_tiles_at
	lda xsp,(xsp+12)
L2940:
	lda xsp,(xsp+16)
	ret

; function ngpc_sprite_set
_ngpc_sprite_set:
	push xiz
	lda xsp,(xsp-4)
	ld ix,(xsp+24)
	ld xwa,34816
	ld c,(xsp+12)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
	ld xiz,xwa
	ld a,ixl
	and a,255
	ld (xiz),a
	ld a,(xsp+32)
	extz wa
	ld bc,ix
	srl 8,bc
	and bc,1
	extz bc
	or wa,bc
	ld (xiz+1),a
	ld a,(xsp+16)
	ld (xiz+2),a
	ld a,(xsp+20)
	ld (xiz+3),a
	ld a,(xsp+28)
	and a,15
	ld xbc,35840
	ld e,(xsp+12)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2942:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function ngpc_sprite_move
_ngpc_sprite_move:
	lda xsp,(xsp-4)
	ld xwa,34816
	ld c,(xsp+8)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
	ld (xsp+0),xwa
	ld a,(xsp+12)
	ld xbc,(xsp+0)
	ld (xbc+2),a
	ld a,(xsp+16)
	ld xbc,(xsp+0)
	ld (xbc+3),a
L2944:
	lda xsp,(xsp+4)
	ret

; function ngpc_sprite_hide
_ngpc_sprite_hide:
	lda xsp,(xsp-4)
	ld xwa,34816
	ld c,(xsp+8)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
	ld (xsp+0),xwa
	ld xbc,(xsp+0)
	andb (xbc+1),231
L2946:
	lda xsp,(xsp+4)
	ret

; function ngpc_sprite_hide_all
_ngpc_sprite_hide_all:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L2956
L2953:
	ld a,izl
	push xwa
	call _ngpc_sprite_hide
	lda xsp,(xsp+4)
L2955:
	inc 1,izl
L2956:
	ld a,izl
	cp a,64
	jr ult,L2953
L2954:
L2952:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_sprite_set_flags
_ngpc_sprite_set_flags:
	lda xsp,(xsp-4)
	ld xwa,34816
	ld c,(xsp+8)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
	ld (xsp+0),xwa
	ld xwa,(xsp+0)
	ld a,(xwa+1)
	and a,1
	or a,(xsp+12)
	ld xbc,(xsp+0)
	ld (xbc+1),a
L2958:
	lda xsp,(xsp+4)
	ret

; function ngpc_sprite_set_tile
_ngpc_sprite_set_tile:
	push xiz
	lda xsp,(xsp-4)
	ld ix,(xsp+16)
	ld xwa,34816
	ld c,(xsp+12)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
	ld xiz,xwa
	ld a,ixl
	and a,255
	ld (xiz),a
	ld a,(xiz+1)
	extz wa
	and wa,254
	ld bc,ix
	srl 8,bc
	and bc,1
	extz bc
	or wa,bc
	ld (xiz+1),a
L2960:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function ngpc_sprite_get_pal
_ngpc_sprite_get_pal:
	ld xwa,35840
	ld c,(xsp+4)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	and wa,15
	jr L2962
L2962:
	ret

; function ngpc_text_print
_ngpc_text_print:
	push xiz
	lda xsp,(xsp-2)
	ld xiz,(xsp+26)
	ld a,(xsp+18)
	ld iyl,a
	jr L2972
L2970:
	ld a,(xiz)
	ld ixl,a
	ld a,ixl
	cp a,32
	jr ult,L2973
	ld a,ixl
	cp a,128
	jr uge,L2973
	push xix
	push xiy
	ld a,(xsp+22)
	push xwa
	ld a,ixl
	extz wa
	push xwa
	ld a,(xsp+38)
	push xwa
	ld a,iyl
	push xwa
	ld a,(xsp+34)
	push xwa
	call _ngpc_gfx_put_tile
	lda xsp,(xsp+20)
	pop xiy
	pop xix
L2973:
	inc 1,iyl
	ld a,iyl
	cp a,20
	jr ult,L2974
	jr L2971
L2974:
	ld xwa,xiz
	inc 1,xwa
	ld xiz,xwa
L2972:
	ld a,(xiz)
	cp a,0
	jr nz,L2970
L2971:
L2969:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_text_print_dec
_ngpc_text_print_dec:
	push xiz
	lda xsp,(xsp-10)
	ld wa,(xsp+34)
	ld (xsp+6),wa
	ld izl,0
	jr L2988
L2985:
	ld wa,(xsp+6)
	extz xwa
	div xwa,10
	ld wa,qwa
	lda xbc,(xsp+0)
	ld de,4
	ld l,izl
	extz hl
	sub de,hl
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+6)
	extz xwa
	div xwa,10
	ld (xsp+6),wa
L2987:
	inc 1,izl
L2988:
	ld a,izl
	cp a,5
	jr ult,L2985
L2986:
	ld a,5
	sub a,(xsp+38)
	ld izl,a
	jr L2992
L2989:
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	add wa,48
	ld (xsp+8),wa
	ld a,(xsp+22)
	push xwa
	ld wa,(xsp+12)
	push xwa
	ld a,(xsp+38)
	push xwa
	ld a,(xsp+38)
	push xwa
	ld a,(xsp+34)
	push xwa
	call _ngpc_gfx_put_tile
	lda xsp,(xsp+20)
	incb 1,(xsp+26)
L2991:
	inc 1,izl
L2992:
	ld a,izl
	cp a,5
	jr ult,L2989
L2990:
L2984:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_text_print_hex
_ngpc_text_print_hex:
	push xiz
	lda xsp,(xsp-8)
	ld izl,0
	jr L3006
L3003:
	ld a,(xsp+36)
	extz wa
	sub wa,1
	ld c,izl
	extz bc
	sub wa,bc
	sll 2,wa
	ld (xsp+2),wa
	ld wa,(xsp+32)
	ld bc,(xsp+2)
	cp c,0
	jr z,L3008
L3007:
	srl 1,wa
	djnz c,L3007
L3008:
	and wa,15
	ld ixl,a
	ld a,ixl
	cp a,10
	jr uge,L3009
	ld a,ixl
	extz wa
	add wa,48
	ld iy,wa
	jr L3010
L3009:
	ld a,ixl
	extz wa
	sub wa,10
	add wa,65
	ld iy,wa
L3010:
	push xix
	push xiy
	ld a,(xsp+28)
	push xwa
	ld wa,iy
	push xwa
	ld a,(xsp+44)
	push xwa
	ld a,(xsp+44)
	extz wa
	ld c,izl
	extz bc
	add wa,bc
	push xwa
	ld a,(xsp+40)
	push xwa
	call _ngpc_gfx_put_tile
	lda xsp,(xsp+20)
	pop xiy
	pop xix
L3005:
	inc 1,izl
L3006:
	ld a,izl
	cp a,(xsp+36)
	jp ult,L3003
L3004:
L3002:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function ngpc_text_print_num
_ngpc_text_print_num:
	push xiz
	lda xsp,(xsp-12)
	ld wa,(xsp+36)
	ld (xsp+6),wa
	ld wa,1
	ld (xsp+8),a
	ld izl,0
	jr L3026
L3023:
	ld wa,(xsp+6)
	extz xwa
	div xwa,10
	ld wa,qwa
	lda xbc,(xsp+0)
	ld de,4
	ld l,izl
	extz hl
	sub de,hl
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+6)
	extz xwa
	div xwa,10
	ld (xsp+6),wa
L3025:
	inc 1,izl
L3026:
	ld a,izl
	cp a,5
	jr ult,L3023
L3024:
	ld a,5
	sub a,(xsp+40)
	ld izl,a
	jr L3030
L3027:
	ld a,(xsp+8)
	cp a,0
	jr z,L3031
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L3031
	ld a,izl
	cp a,4
	jr uge,L3031
	ld ix,32
	jr L3032
L3031:
	ldb (xsp+8),0
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	add wa,48
	ld ix,wa
L3032:
	push xix
	ld a,(xsp+28)
	push xwa
	ld wa,ix
	push xwa
	ld a,(xsp+44)
	push xwa
	ld a,(xsp+44)
	push xwa
	ld a,(xsp+40)
	push xwa
	call _ngpc_gfx_put_tile
	lda xsp,(xsp+20)
	pop xix
	incb 1,(xsp+28)
L3029:
	inc 1,izl
L3030:
	ld a,izl
	cp a,5
	jr ult,L3027
L3028:
L3022:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function ngpc_text_print_hex32
_ngpc_text_print_hex32:
	ld wa,4
	push xwa
	ld xwa,(xsp+24)
	srl 15,xwa
	srl 1,xwa
	push xwa
	ld a,(xsp+24)
	push xwa
	ld a,(xsp+24)
	push xwa
	ld a,(xsp+24)
	push xwa
	ld a,(xsp+24)
	push xwa
	call _ngpc_text_print_hex
	lda xsp,(xsp+24)
	ld wa,4
	push xwa
	ld xwa,(xsp+24)
	and xwa,65535
	push xwa
	ld a,(xsp+24)
	push xwa
	ld a,(xsp+24)
	extz wa
	add wa,4
	push xwa
	ld a,(xsp+24)
	push xwa
	ld a,(xsp+24)
	push xwa
	call _ngpc_text_print_hex
	lda xsp,(xsp+24)
L3034:
	ret

; function ngpc_text_tile_screen
_ngpc_text_tile_screen:
	push xiz
	lda xsp,(xsp-4)
	ld wa,0
	ld (xsp+2),wa
	ld ixl,0
	jr L3048
L3045:
	ld izl,0
	jr L3052
L3049:
	push xix
	ld a,(xsp+20)
	push xwa
	ld xwa,(xsp+28)
	ld bc,(xsp+10)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld a,ixl
	push xwa
	ld a,izl
	push xwa
	ld a,(xsp+32)
	push xwa
	call _ngpc_gfx_put_tile
	lda xsp,(xsp+20)
	pop xix
	incw 1,(xsp+2)
L3051:
	inc 1,izl
L3052:
	ld a,izl
	cp a,20
	jr ult,L3049
L3050:
L3047:
	inc 1,ixl
L3048:
	ld a,ixl
	cp a,19
	jr ult,L3045
L3046:
L3044:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function hud_score_reset
_hud_score_reset:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L3062
L3059:
	ld a,0
	ld xbc,_s_dig__24
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3061:
	inc 1,izl
L3062:
	ld a,izl
	cp a,7
	jr ult,L3059
L3060:
L3058:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function hud_score_add
_hud_score_add:
	push xiz
	lda xsp,(xsp-6)
	ld wa,(xsp+14)
	ld iy,wa
	ld wa,7
	ld izl,a
	jr L3071
L3069:
	dec 1,izl
	ld xwa,_s_dig__24
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	add wa,iy
	ld ix,wa
	ld wa,ix
	extz xwa
	div xwa,10
	ld wa,qwa
	ld xbc,_s_dig__24
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,ix
	extz xwa
	div xwa,10
	ld iy,wa
L3071:
	ld wa,iy
	cp wa,0
	jr z,L3072
	ld a,izl
	cp a,0
	jr ugt,L3069
L3072:
L3070:
L3068:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function hud_init
_hud_init:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,41472
	ld (xsp+2),xwa
	ld iz,0
	jr L3082
L3079:
	ld xwa,_gfx_font_tiles__24
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(xsp+2)
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3081:
	inc 1,iz
L3082:
	ld wa,iz
	cp wa,552
	jr ult,L3079
L3080:
	ld wa,4095
	push xwa
	ld wa,2184
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ld wa,2303
	push xwa
	ld wa,136
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,1
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ld wa,1375
	push xwa
	ld wa,8
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,2
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ld wa,4020
	push xwa
	ld wa,2112
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,3
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ld wa,1455
	push xwa
	ld wa,40
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,7
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ld wa,1782
	push xwa
	ld wa,337
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,8
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ld wa,4072
	push xwa
	ld wa,2113
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,9
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
L3078:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function hud_reset
_hud_reset:
	ld a,255
	ld (_h_stage__24),a
	ld (_h_prog__24),a
	ld (_h_gear__24),a
	ld (_h_kmh__24),a
	ld (_h_time__24),a
	ldb (_h_score_ok__24),0
L3084:
	ret

; function hud_clear_top
_hud_clear_top:
	push xiz
	lda xsp,(xsp-2)
	ld ixl,0
	jr L3098
L3095:
	ld izl,0
	jr L3102
L3099:
	ld wa,0
	ld xbc,36864
	ld e,ixl
	extz de
	sll 5,de
	ld l,izl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3101:
	inc 1,izl
L3102:
	ld a,izl
	cp a,20
	jr ult,L3099
L3100:
L3097:
	inc 1,ixl
L3098:
	ld a,ixl
	cp a,15
	jr ult,L3095
L3096:
L3094:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function hud_message
_hud_message:
	push xiz
	lda xsp,(xsp-2)
	ld xix,(xsp+14)
	ld wa,0
	ld izl,a
	jr L3110
L3108:
	inc 1,izl
L3110:
	ld xwa,xix
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L3108
L3109:
	push xix
	ld a,(xsp+14)
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	pop xix
	push xix
	ld xwa,xix
	push xwa
	ld a,(xsp+18)
	push xwa
	ld wa,20
	ld c,izl
	extz bc
	sub wa,bc
	srl 1,wa
	push xwa
	ld wa,1
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	pop xix
L3107:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function hud_clear_message
_hud_clear_message:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld ixl,a
	ld izl,0
	jr L3120
L3117:
	ld wa,0
	ld xbc,36864
	ld e,ixl
	extz de
	sll 5,de
	ld l,izl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3119:
	inc 1,izl
L3120:
	ld a,izl
	cp a,20
	jr ult,L3117
L3118:
L3116:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function put_digit
_put_digit__24:
	ld a,(xsp+16)
	push xwa
	ld wa,48
	ld c,(xsp+16)
	extz bc
	add wa,bc
	push xwa
	ld a,(xsp+16)
	push xwa
	ld a,(xsp+16)
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_put_tile
	lda xsp,(xsp+20)
L3122:
	ret

; function hud_race
_hud_race:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	cp a,(_h_time__24)
	jr z,L3148
	ld a,(_h_time__24)
	cp a,255
	jr nz,L3149
	ld xwa,_S24_0
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,7
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
L3149:
	ld c,(xsp+12)
	cp c,10
	jr uge,L3150
	ld wa,2
	jr L3151
L3150:
	ld wa,1
L3151:
	push xwa
	ld a,(xsp+16)
	extz wa
	extz xwa
	div xwa,10
	push xwa
	ld wa,0
	push xwa
	ld wa,5
	push xwa
	call _put_digit__24
	lda xsp,(xsp+16)
	ld c,(xsp+12)
	cp c,10
	jr uge,L3152
	ld wa,2
	jr L3153
L3152:
	ld wa,1
L3153:
	push xwa
	ld a,(xsp+16)
	extz wa
	extz xwa
	div xwa,10
	ld wa,qwa
	push xwa
	ld wa,0
	push xwa
	ld wa,6
	push xwa
	call _put_digit__24
	lda xsp,(xsp+16)
	ld a,(xsp+12)
	ld (_h_time__24),a
L3148:
	ld a,(xsp+28)
	cp a,(_h_stage__24)
	jr z,L3154
	ld xwa,_S24_1
	push xwa
	ld wa,0
	push xwa
	ld wa,9
	push xwa
	ld wa,8
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	ld wa,1
	push xwa
	ld a,(xsp+32)
	add a,1
	push xwa
	ld wa,0
	push xwa
	ld wa,15
	push xwa
	call _put_digit__24
	lda xsp,(xsp+16)
	ld a,(xsp+28)
	ld (_h_stage__24),a
	ldb (_h_prog__24),255
L3154:
	ld wa,(xsp+24)
	mul xwa,3
	add wa,9
	extz xwa
	div xwa,10
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,(_h_prog__24)
	jr z,L3155
	ld izl,0
	jr L3159
L3156:
	ld wa,0
	push xwa
	ld c,izl
	cp c,(xsp+5)
	jr uge,L3160
	ld wa,97
	jr L3161
L3160:
	ld wa,96
L3161:
	push xwa
	ld wa,0
	push xwa
	ld a,16
	add a,izl
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_put_tile
	lda xsp,(xsp+20)
L3158:
	inc 1,izl
L3159:
	ld a,izl
	cp a,3
	jr ult,L3156
L3157:
	ld wa,1
	push xwa
	ld wa,100
	push xwa
	ld wa,0
	push xwa
	ld wa,19
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_put_tile
	lda xsp,(xsp+20)
	ld a,(xsp+1)
	ld (_h_prog__24),a
L3155:
	ld a,(xsp+16)
	cp a,(_h_kmh__24)
	jp z,L3162
	ld a,(xsp+16)
	extz wa
	sll 1,wa
	ld (xsp+2),wa
	ld a,(_h_kmh__24)
	cp a,255
	jr nz,L3163
	ld xwa,_S24_2
	push xwa
	ld wa,1
	push xwa
	ld wa,4
	push xwa
	ld wa,9
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
L3163:
	ld wa,1
	push xwa
	ld wa,(xsp+6)
	extz xwa
	div xwa,100
	push xwa
	ld wa,1
	push xwa
	ld wa,0
	push xwa
	call _put_digit__24
	lda xsp,(xsp+16)
	ld wa,1
	push xwa
	ld wa,(xsp+6)
	extz xwa
	div xwa,10
	extz xwa
	div xwa,10
	ld wa,qwa
	push xwa
	ld wa,1
	push xwa
	ld wa,1
	push xwa
	call _put_digit__24
	lda xsp,(xsp+16)
	ld wa,1
	push xwa
	ld wa,(xsp+6)
	extz xwa
	div xwa,10
	ld wa,qwa
	push xwa
	ld wa,1
	push xwa
	ld wa,2
	push xwa
	call _put_digit__24
	lda xsp,(xsp+16)
	ld a,(xsp+16)
	ld (_h_kmh__24),a
L3162:
	ld a,(xsp+20)
	cp a,(_h_gear__24)
	jr z,L3164
	ld c,(xsp+20)
	cp c,1
	jr nz,L3165
	ld xwa,_S24_3
	jr L3166
L3165:
	ld xwa,_S24_4
L3166:
	push xwa
	ld wa,1
	push xwa
	ld wa,16
	push xwa
	ld c,(xsp+32)
	cp c,1
	jr nz,L3167
	ld wa,1
	jr L3168
L3167:
	ld c,(xsp+32)
	cp c,2
	jr nz,L3169
	ld wa,2
	jr L3170
L3169:
	ld wa,0
L3170:
L3168:
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	ld a,(xsp+20)
	ld (_h_gear__24),a
L3164:
L3147:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function id_cars_steering
_id_cars_steering:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld izl,a
	ld c,izl
	cp c,96
	jr uge,L3175
	ld a,izl
	extz wa
	mul xwa,7
	extz xwa
	div xwa,6
	jr L3176
L3175:
	ld wa,112
	ld c,izl
	extz bc
	sub bc,96
	srl 3,bc
	sub wa,bc
L3176:
	ld (xsp+0),wa
	ld a,(xsp+14)
	extz wa
	mul xwa,(xsp+0)
	srl 7,wa
	jr L3174
L3174:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_fleet_body
_id_fleet_body:
	push xiz
	ld xiz,(xsp+12)
	ld xwa,_id_carog_tiles
	ld (xiz),xwa
	ld wa,(_id_carog_tiles_count)
	ld (xiz+4),wa
	ldw (xiz+26),520
	ld xwa,_id_carog_palette
	ld (xiz+6),xwa
	ld xwa,_id_carog_pose_cells
	ld (xiz+10),xwa
	ld xwa,_id_carog_pose_first
	ld (xiz+14),xwa
	ld xwa,_id_carog_pose_w
	ld (xiz+18),xwa
	ld xwa,_id_carog_cells
	ld (xiz+22),xwa
	ldb (xiz+28),2
	ldb (xiz+29),3
	ldb (xiz+31),1
	ldb (xiz+30),24
L3178:
	pop xiz
	ret

; function id_spr_put
_id_spr_put:
	push xiz
	lda xsp,(xsp-4)
	ld ix,(xsp+24)
	ld wa,34816
	ld c,(xsp+12)
	extz bc
	sll 2,bc
	add wa,bc
	extz xwa
	ld xiz,xwa
	ld a,ixl
	and a,255
	ld (xiz),a
	ld a,(xsp+32)
	extz wa
	ld c,(_id_spr_priority)
	extz bc
	or wa,bc
	ld bc,ix
	srl 8,bc
	and bc,1
	extz bc
	or wa,bc
	ld (xiz+1),a
	ld a,(xsp+16)
	ld (xiz+2),a
	ld a,(xsp+20)
	ld (xiz+3),a
	ld a,(xsp+28)
	and a,15
	ld bc,35840
	ld e,(xsp+12)
	extz de
	add bc,de
	extz xbc
	ld (xbc),a
L3180:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function id_spr_hide_range
_id_spr_hide_range:
	push xiz
	lda xsp,(xsp-6)
	ld a,(xsp+14)
	ld iyl,a
	ld a,iyl
	cp a,(xsp+18)
	jr ult,L3187
	jr L3186
L3187:
	ld wa,34817
	ld c,iyl
	extz bc
	sll 2,bc
	add wa,bc
	extz xwa
	ld xiz,xwa
	ld a,(xsp+18)
	sub a,iyl
	ld ixl,a
L3188:
	ld a,(xiz)
	and a,231
	ld (xiz),a
	ld bc,4
	exts xbc
	ld xwa,xiz
	add xwa,xbc
	ld xiz,xwa
L3190:
	dec 1,ixl
	ld a,ixl
	cp a,0
	jr nz,L3188
L3189:
L3186:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function mesure_roues
_mesure_roues__27:
	push xiz
	lda xsp,(xsp-20)
	ld wa,0
	ld (xsp+2),a
	ld wa,0
	ld (xsp+3),a
	ld wa,255
	ld (xsp+4),a
	ld wa,0
	ld (xsp+5),a
	ldb (xsp+0),0
	jp L3222
L3219:
	ld a,(xsp+0)
	extz wa
	ld c,(_body__27+29)
	extz bc
	mul xwa,bc
	ld (xsp+6),a
	ld xwa,(_body__27+14)
	ld c,(xsp+6)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+7),a
	ld xwa,(_body__27+10)
	ld c,(xsp+6)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+8),a
	ldb (xsp+1),0
	jp L3226
L3223:
	ld xwa,(_body__27+22)
	ld c,(xsp+7)
	add c,(xsp+1)
	extz bc
	muls xbc,3
	add xwa,xbc
	ld a,(xwa)
	ld iyl,a
	ld xwa,(_body__27+22)
	ld c,(xsp+7)
	add c,(xsp+1)
	extz bc
	muls xbc,3
	add xwa,xbc
	ld a,(xwa+1)
	ld (xsp+10),a
	ld xwa,(_body__27+22)
	ld c,(xsp+7)
	add c,(xsp+1)
	extz bc
	muls xbc,3
	add xwa,xbc
	ld a,(xwa+2)
	extz wa
	ld (xsp+12),wa
	ld ixl,0
	jp L3230
L3227:
	ld xwa,(_body__27)
	ld bc,(xsp+12)
	sll 3,bc
	ld e,ixl
	extz de
	add bc,de
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+16),wa
	ld izl,0
	jp L3234
L3231:
	ld wa,(xsp+16)
	ld bc,14
	ld de,2
	ld l,izl
	extz hl
	mul xde,hl
	sub bc,de
	cp c,0
	jr z,L3237
L3236:
	srl 1,wa
	djnz c,L3236
L3237:
	and wa,3
	cp wa,0
	jr nz,L3235
	jp L3233
L3235:
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	cp a,(xsp+2)
	jr ule,L3238
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld (xsp+2),a
	ldb (xsp+5),0
L3238:
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	cp a,(xsp+2)
	jr nz,L3239
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+5)
	jr ule,L3239
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+5),a
L3239:
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+3)
	jr ule,L3240
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+3),a
L3240:
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+4)
	jr uge,L3241
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+4),a
L3241:
L3233:
	inc 1,izl
L3234:
	ld a,izl
	cp a,8
	jp ult,L3231
L3232:
L3229:
	inc 1,ixl
L3230:
	ld a,ixl
	cp a,8
	jp ult,L3227
L3228:
L3225:
	incb 1,(xsp+1)
L3226:
	ld a,(xsp+1)
	cp a,(xsp+8)
	jp ult,L3223
L3224:
L3221:
	incb 1,(xsp+0)
L3222:
	ld a,(xsp+0)
	cp a,(_body__27+28)
	jp ult,L3219
L3220:
	ld a,(xsp+4)
	cp a,(xsp+3)
	jr ule,L3242
	ld xwa,(_body__27+18)
	ld a,(xwa)
	extz wa
	sll 2,wa
	ld (_car_wheel_dx__27),a
	jr L3218
L3242:
	ld wa,2
	ld c,(xsp+5)
	extz bc
	sub bc,1
	mul xwa,bc
	ld (xsp+6),wa
	ld a,(xsp+4)
	extz wa
	ld c,(xsp+3)
	extz bc
	add wa,bc
	ld (xsp+8),wa
	ld bc,(xsp+6)
	cp bc,(xsp+8)
	jr ule,L3243
	ld wa,(xsp+6)
	sub wa,(xsp+8)
	srl 1,wa
	extz wa
	jr L3244
L3243:
	ld wa,0
L3244:
	ld (_car_wheel_dx__27),a
L3218:
	lda xsp,(xsp+20)
	pop xiz
	ret

; function id_car_select
_id_car_select:
	ld c,(xsp+4)
	cp c,1
	jr uge,L3249
	ld a,(xsp+4)
	extz wa
	jr L3250
L3249:
	ld a,0
	extz wa
L3250:
	ld (_car_variant__27),a
	ld xwa,_body__27
	push xwa
	ld a,(_car_variant__27)
	push xwa
	call _id_fleet_body
	lda xsp,(xsp+8)
	call _mesure_roues__27
L3248:
	ret

; function id_car_char_count
_id_car_char_count:
	ld c,(xsp+4)
	cp c,0
	jr z,L3255
	ld wa,(_body__27+4)
	jr L3256
L3255:
	ld wa,(_body__27+26)
L3256:
	srl 3,wa
	jr L3254
L3254:
	ret

; function id_car_half_width
_id_car_half_width:
	ld xwa,(_body__27+18)
	ld a,(xwa)
	extz wa
	sll 2,wa
	jr L3258
L3258:
	ret

; function id_car_wheel_dx
_id_car_wheel_dx:
	ld a,(_car_wheel_dx__27)
	jr L3260
L3260:
	ret

; function id_car_init
_id_car_init:
	push xiz
	lda xsp,(xsp-16)
	push xix
	push xiy
	ld a,(xsp+36)
	push xwa
	call _id_car_char_count
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (xsp+2),wa
	ld xwa,(_body__27)
	ld (xsp+4),xwa
	ld wa,(xsp+24)
	ld (_car_tile_base__27),wa
	ld ix,0
	jr L3276
L3273:
	ld wa,40960
	extz xwa
	ld bc,(xsp+24)
	add bc,ix
	mul xbc,16
	add xwa,xbc
	ld (xsp+8),xwa
	ld iz,0
	jr L3280
L3277:
	ld xwa,(xsp+4)
	ld bc,ix
	sll 3,bc
	add bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld iy,wa
	ld a,iyl
	and a,255
	ld xbc,(xsp+8)
	ld de,iz
	sll 1,de
	add de,0
	extz xde
	add xbc,xde
	ld (xbc),a
	ld wa,iy
	srl 8,wa
	ld xbc,(xsp+8)
	ld de,iz
	sll 1,de
	add de,1
	extz xde
	add xbc,xde
	ld (xbc),a
L3279:
	inc 1,iz
L3280:
	ld wa,iz
	cp wa,8
	jr ult,L3277
L3278:
L3275:
	inc 1,ix
L3276:
	ld wa,ix
	cp wa,(xsp+2)
	jr ult,L3273
L3274:
	push xix
	push xiy
	ld xwa,(_body__27+6)
	ld wa,(xwa+6)
	push xwa
	ld xwa,(_body__27+6)
	ld wa,(xwa+4)
	push xwa
	ld xwa,(_body__27+6)
	ld wa,(xwa+2)
	push xwa
	ld xwa,(_body__27+6)
	ld wa,(xwa)
	push xwa
	ld a,0
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xiy
	pop xix
	ld a,(_body__27+28)
	cp a,1
	jr ule,L3281
	push xix
	push xiy
	ld xwa,(_body__27+6)
	ld wa,(xwa+14)
	push xwa
	ld xwa,(_body__27+6)
	ld wa,(xwa+12)
	push xwa
	ld xwa,(_body__27+6)
	ld wa,(xwa+10)
	push xwa
	ld xwa,(_body__27+6)
	ld wa,(xwa+8)
	push xwa
	ld a,5
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xiy
	pop xix
	jr L3282
L3281:
	push xix
	push xiy
	ld xwa,(_body__27+6)
	ld wa,(xwa+6)
	push xwa
	ld xwa,(_body__27+6)
	ld wa,(xwa+4)
	push xwa
	ld xwa,(_body__27+6)
	ld wa,(xwa+2)
	push xwa
	ld xwa,(_body__27+6)
	ld wa,(xwa)
	push xwa
	ld a,5
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xiy
	pop xix
L3282:
	push xix
	push xiy
	ld a,24
	push xwa
	ld a,12
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xiy
	pop xix
L3272:
	lda xsp,(xsp+16)
	pop xiz
	ret

; function id_car_portrait_angle
_id_car_portrait_angle:
	push xiz
	lda xsp,(xsp-30)
	ld a,(xsp+46)
	ld (xsp+2),a
	ld wa,2
	ld c,(_body__27+29)
	extz bc
	mul xwa,bc
	sub wa,2
	ld (xsp+3),a
	ld a,(_body__27+29)
	cp a,2
	jr uge,L3315
	push xix
	push xiy
	ld a,(xsp+54)
	push xwa
	ld a,(xsp+54)
	push xwa
	ld a,(xsp+54)
	extz wa
	push xwa
	push xix
	push xiy
	call _id_car_half_width
	ld xbc,xwa
	pop xiy
	pop xix
	pop xwa
	extz bc
	sub wa,bc
	push xwa
	call _id_car_portrait
	lda xsp,(xsp+12)
	pop xiy
	pop xix
	jp L3314
L3315:
	ld a,(xsp+50)
	extz wa
	exts xwa
	ld c,(xsp+3)
	extz bc
	divs xwa,bc
	ld wa,qwa
	ld (xsp+50),a
	ld a,(xsp+50)
	cp a,(_body__27+29)
	jr uge,L3316
	ld a,(xsp+50)
	ld (xsp+4),a
	ldb (xsp+5),0
	jr L3317
L3316:
	ld a,(xsp+3)
	sub a,(xsp+50)
	ld (xsp+4),a
	ldb (xsp+5),1
L3317:
	ld xwa,(_body__27+14)
	ld c,(xsp+4)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+9),a
	ld xwa,(_body__27+10)
	ld c,(xsp+4)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+10),a
	ld xwa,(_body__27+18)
	ld c,(xsp+4)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+11),a
	ldb (xsp+6),255
	ldb (xsp+7),0
	ld izl,0
	jr L3321
L3318:
	ld xwa,(_body__27+22)
	ld c,(xsp+9)
	add c,izl
	extz bc
	muls xbc,3
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+12),a
	ld c,(xsp+5)
	cp c,0
	jr z,L3322
	ld a,(xsp+11)
	sub a,1
	sub a,(xsp+12)
	extz wa
	jr L3323
L3322:
	ld a,(xsp+12)
	extz wa
L3323:
	ld (xsp+13),a
	ld a,(xsp+13)
	cp a,(xsp+6)
	jr uge,L3324
	ld a,(xsp+13)
	ld (xsp+6),a
L3324:
	ld a,(xsp+13)
	cp a,(xsp+7)
	jr ule,L3325
	ld a,(xsp+13)
	ld (xsp+7),a
L3325:
L3320:
	inc 1,izl
L3321:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L3318
L3319:
	ld a,(xsp+6)
	cp a,(xsp+7)
	jr ule,L3326
	ldb (xsp+6),0
	ldb (xsp+7),0
L3326:
	ld a,(xsp+38)
	extz wa
	ld c,(xsp+7)
	extz bc
	ld e,(xsp+6)
	extz de
	sub bc,de
	add bc,1
	sll 3,bc
	srl 1,bc
	extz bc
	sub wa,bc
	ld c,(xsp+6)
	extz bc
	sll 3,bc
	extz bc
	sub wa,bc
	ld (xsp+8),a
	ldb (xsp+1),0
	jp L3330
L3327:
	ld a,(_body__27+28)
	sub a,1
	sub a,(xsp+1)
	ld (xsp+9),a
	ld xwa,(_body__27+14)
	ld c,(xsp+9)
	extz bc
	ld e,(_body__27+29)
	extz de
	mul xbc,de
	ld e,(xsp+4)
	extz de
	add bc,de
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+10),a
	ld xwa,(_body__27+10)
	ld c,(xsp+9)
	extz bc
	ld e,(_body__27+29)
	extz de
	mul xbc,de
	ld e,(xsp+4)
	extz de
	add bc,de
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+11),a
	ld xwa,(_body__27+18)
	ld c,(xsp+9)
	extz bc
	ld e,(_body__27+29)
	extz de
	mul xbc,de
	ld e,(xsp+4)
	extz de
	add bc,de
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+12),a
	ld c,(xsp+9)
	cp c,0
	jr nz,L3331
	ld wa,0
	jr L3332
L3331:
	ld wa,5
L3332:
	ld (xsp+13),a
	ld izl,0
	jp L3336
L3333:
	ld xwa,(_body__27+22)
	ld c,(xsp+10)
	add c,izl
	extz bc
	muls xbc,3
	add xwa,xbc
	lda xwa,(xwa)
	ld xiy,xwa
	ld c,(xsp+5)
	cp c,0
	jr z,L3337
	ld a,(xsp+12)
	sub a,1
	sub a,(xiy)
	extz wa
	jr L3338
L3337:
	ld a,(xiy)
	extz wa
L3338:
	ld (xsp+18),a
L3339:
	ld a,(xsp+2)
	ld (xsp+19),a
	ld a,(xsp+8)
	extz wa
	ld c,(xsp+18)
	extz bc
	sll 3,bc
	add wa,bc
	ld (xsp+20),a
	ld a,(xsp+42)
	extz wa
	ld c,(xiy+1)
	extz bc
	sll 3,bc
	add wa,bc
	ld (xsp+21),a
	ld wa,(_car_tile_base__27)
	ld c,(xiy+2)
	extz bc
	add wa,bc
	ld (xsp+22),wa
	ld a,(xsp+13)
	ld (xsp+24),a
	ld c,(xsp+5)
	cp c,0
	jr z,L3342
	ld wa,128
	jr L3343
L3342:
	ld wa,0
L3343:
	ld (xsp+25),a
	ld wa,34816
	ld c,(xsp+19)
	extz bc
	sll 2,bc
	add wa,bc
	extz xwa
	ld xix,xwa
	ld a,(xsp+22)
	and a,255
	ld (xix),a
	ld a,(xsp+25)
	extz wa
	ld c,(_id_spr_priority)
	extz bc
	or wa,bc
	ld bc,(xsp+22)
	srl 8,bc
	and bc,1
	extz bc
	or wa,bc
	ld (xix+1),a
	ld a,(xsp+20)
	ld (xix+2),a
	ld a,(xsp+21)
	ld (xix+3),a
	ld a,(xsp+24)
	and a,15
	ld bc,35840
	ld e,(xsp+19)
	extz de
	add bc,de
	extz xbc
	ld (xbc),a
L3341:
L3340:
	incb 1,(xsp+2)
L3335:
	inc 1,izl
L3336:
	ld a,izl
	cp a,(xsp+11)
	jr uge,L3344
	ld a,(xsp+2)
	cp a,64
	jp ult,L3333
L3344:
L3334:
L3329:
	incb 1,(xsp+1)
L3330:
	ld a,(xsp+1)
	cp a,(_body__27+28)
	jp ult,L3327
L3328:
	push xix
	push xiy
	ld a,64
	push xwa
	ld a,(xsp+14)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xiy
	pop xix
L3314:
	lda xsp,(xsp+30)
	pop xiz
	ret

; function id_car_portrait
_id_car_portrait:
	push xiz
	lda xsp,(xsp-24)
	ld a,(xsp+40)
	ld (xsp+2),a
	ldb (xsp+1),0
	jp L3364
L3361:
	ld a,(_body__27+28)
	sub a,1
	sub a,(xsp+1)
	ld (xsp+3),a
	ld xwa,(_body__27+14)
	ld c,(xsp+3)
	extz bc
	ld e,(_body__27+29)
	extz de
	mul xbc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+4),a
	ld xwa,(_body__27+10)
	ld c,(xsp+3)
	extz bc
	ld e,(_body__27+29)
	extz de
	mul xbc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+5),a
	ld c,(xsp+3)
	cp c,0
	jr nz,L3365
	ld wa,0
	jr L3366
L3365:
	ld wa,5
L3366:
	ld (xsp+6),a
	ldb (xsp+0),0
	jp L3370
L3367:
	ld xwa,(_body__27+22)
	ld c,(xsp+4)
	add c,(xsp+0)
	extz bc
	muls xbc,3
	add xwa,xbc
	lda xwa,(xwa)
	ld xiy,xwa
L3371:
	ld a,(xsp+2)
	ld (xsp+12),a
	ld a,(xsp+32)
	extz wa
	ld c,(xiy)
	extz bc
	sll 3,bc
	add wa,bc
	ld (xsp+13),a
	ld a,(xsp+36)
	extz wa
	ld c,(xiy+1)
	extz bc
	sll 3,bc
	add wa,bc
	ld (xsp+14),a
	ld wa,(_car_tile_base__27)
	ld c,(xiy+2)
	extz bc
	add wa,bc
	ld ix,wa
	ld a,(xsp+6)
	ld (xsp+18),a
	ld a,0
	ld (xsp+19),a
	ld wa,34816
	ld c,(xsp+12)
	extz bc
	sll 2,bc
	add wa,bc
	extz xwa
	ld xiz,xwa
	ld a,ixl
	and a,255
	ld (xiz),a
	ld a,(xsp+19)
	extz wa
	ld c,(_id_spr_priority)
	extz bc
	or wa,bc
	ld bc,ix
	srl 8,bc
	and bc,1
	extz bc
	or wa,bc
	ld (xiz+1),a
	ld a,(xsp+13)
	ld (xiz+2),a
	ld a,(xsp+14)
	ld (xiz+3),a
	ld a,(xsp+18)
	and a,15
	ld bc,35840
	ld e,(xsp+12)
	extz de
	add bc,de
	extz xbc
	ld (xbc),a
L3373:
L3372:
	incb 1,(xsp+2)
L3369:
	incb 1,(xsp+0)
L3370:
	ld a,(xsp+0)
	cp a,(xsp+5)
	jr uge,L3374
	ld a,(xsp+2)
	cp a,64
	jp ult,L3367
L3374:
L3368:
L3363:
	incb 1,(xsp+1)
L3364:
	ld a,(xsp+1)
	cp a,(_body__27+28)
	jp ult,L3361
L3362:
	push xix
	push xiy
	ld a,64
	push xwa
	ld a,(xsp+14)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xiy
	pop xix
L3360:
	lda xsp,(xsp+24)
	pop xiz
	ret

; function car_layer
_car_layer__27:
	lda xsp,(xsp-22)
	ld xwa,(xsp+26)
	ld c,(xsp+30)
	extz bc
	muls xbc,3
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+0),xwa
	ld wa,0
	exts xwa
	ld (xsp+4),xwa
	ld wa,(_car_tile_base__27)
	ld (xsp+8),wa
	ld a,(xsp+66)
	push xwa
	call _id_road_centre_at
	lda xsp,(xsp+4)
	ld c,(xsp+38)
	extz bc
	sll 2,bc
	sub wa,bc
	add wa,(xsp+46)
	ld (xsp+10),wa
	ld wa,(_car_at_x__27)
	cp wa,32767
	jr z,L3380
	ld wa,(_car_at_x__27)
	ld (xsp+10),wa
L3380:
	ld a,(xsp+62)
	sub a,(xsp+70)
	ld (xsp+12),a
	ld a,(xsp+34)
	ld (xsp+13),a
	ld a,(xsp+38)
	sub a,1
	ld (xsp+14),a
	ld c,(xsp+42)
	cp c,0
	jr z,L3381
	ld wa,128
	jr L3382
L3381:
	ld wa,0
L3382:
	ld c,(_id_spr_priority)
	extz bc
	or wa,bc
	ld (xsp+15),a
	ld a,(xsp+50)
	ld (xsp+16),a
	ld a,(xsp+54)
	ld (xsp+17),a
	ld a,(xsp+58)
	ld (xsp+18),a
	ld a,(xsp+42)
	ld (xsp+19),a
	ldb (xsp+20),0
	lda xwa,(xsp+0)
	push xwa
	call _spr_cells_asm
	lda xsp,(xsp+4)
	ld a,(xsp+58)
	push xwa
	ld a,(xsp+21)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L3379:
	lda xsp,(xsp+22)
	ret

; function lean_last
_lean_last__27:
	push xiz
	lda xsp,(xsp-2)
	ld c,(_body__27+29)
	cp c,0
	jr ule,L3388
	ld a,(_body__27+29)
	extz wa
	sub wa,1
	jr L3389
L3388:
	ld wa,0
L3389:
	ld izl,a
	ld a,izl
	cp a,2
	jr ule,L3390
	ld izl,2
L3390:
	ld a,izl
	jr L3387
L3387:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function lean_pose
_lean_pose__27:
	push xiz
	lda xsp,(xsp-2)
	call _lean_last__27
	ld (xsp+0),a
	ld a,(_lean_hold__27)
	cp a,0
	jr nz,L3400
	ld wa,0
	jr L3399
L3400:
	ld c,(_lean_hold__27)
	cp c,12
	jr ult,L3401
	ld wa,3
	jr L3402
L3401:
	ld c,(_lean_hold__27)
	cp c,5
	jr ult,L3403
	ld wa,2
	jr L3404
L3403:
	ld wa,1
L3404:
L3402:
	ld izl,a
	ld c,izl
	cp c,(xsp+0)
	jr ule,L3405
	ld a,(xsp+0)
	extz wa
	jr L3406
L3405:
	ld a,izl
	extz wa
L3406:
	jr L3399
L3399:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_car_lean_share
_id_car_lean_share:
	push xiz
	lda xsp,(xsp-4)
	call _lean_last__27
	ld (xsp+0),a
	call _lean_pose__27
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,0
	jr z,L3415
	ld a,(xsp+0)
	cp a,0
	jr nz,L3414
L3415:
	ld wa,0
	jr L3413
L3414:
	ld a,(xsp+1)
	extz wa
	sll 4,wa
	exts xwa
	ld c,(xsp+0)
	extz bc
	divs xwa,bc
	ld iz,wa
	ld wa,iz
	cp wa,16
	jr le,L3416
	ld iz,16
L3416:
	ld c,(_lean_side__27)
	cp c,0
	jr ge,L3417
	ld wa,iz
	neg wa
	jr L3418
L3417:
	ld wa,iz
L3418:
	jr L3413
L3413:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function id_car_last_x
_id_car_last_x:
	ld wa,(_car_last_x__27)
	jr L3420
L3420:
	ret

; function id_car_last_top
_id_car_last_top:
	ld a,(_car_last_top__27)
	jr L3422
L3422:
	ret

; function id_car_draw
_id_car_draw:
	push xiz
	lda xsp,(xsp-8)
	ld a,(xsp+20)
	cp a,0
	jr z,L3451
	ld a,(_lean_side__27)
	cp a,(xsp+20)
	jr z,L3452
	ld a,(xsp+20)
	ld (_lean_side__27),a
	ldb (_lean_hold__27),0
L3452:
	ld a,(_lean_hold__27)
	cp a,255
	jr uge,L3453
	incb 1,(_lean_hold__27)
L3453:
	ldb (_lean_wait__27),2
	jr L3454
L3451:
	ld a,(_lean_hold__27)
	cp a,0
	jr z,L3455
	ld a,(_lean_wait__27)
	cp a,0
	jr z,L3456
	decb 1,(_lean_wait__27)
	jr L3457
L3456:
	ldb (_lean_wait__27),2
	ld a,(_lean_hold__27)
	cp a,12
	jr ult,L3458
	ldb (_lean_hold__27),11
	jr L3459
L3458:
	ld a,(_lean_hold__27)
	cp a,5
	jr ult,L3460
	ldb (_lean_hold__27),4
	jr L3461
L3460:
	ldb (_lean_hold__27),0
L3461:
L3459:
L3457:
L3455:
L3454:
	ld a,(xsp+24)
	cp a,0
	jr nz,L3462
	ldb (_bump_phase__27),0
	ldb (xsp+2),0
	jr L3463
L3462:
	incb 1,(_bump_phase__27)
	ld c,(_bump_phase__27)
	extz bc
	and bc,2
	cp bc,0
	jr z,L3464
	ld a,(xsp+24)
	extz wa
	jr L3465
L3464:
	ld wa,0
L3465:
	ld (xsp+2),a
L3463:
	ld a,148
	ld c,(_body__27+30)
	sub a,c
	add a,(_body__27+30)
	sub a,1
	ld (xsp+4),a
	ld a,148
	ld c,(_body__27+30)
	sub a,c
	extz wa
	push xwa
	call _id_road_car_lift
	ld xbc,xwa
	pop xwa
	exts bc
	sub wa,bc
	ld (xsp+6),wa
	ld bc,(xsp+6)
	cp bc,0
	jr ge,L3466
	ld wa,0
	jr L3467
L3466:
	ld wa,(xsp+6)
L3467:
	ld (xsp+3),a
	ld a,(xsp+4)
	push xwa
	call _id_road_centre_at
	lda xsp,(xsp+4)
	ld xbc,(_body__27+18)
	ld c,(xbc)
	extz bc
	sll 2,bc
	sub wa,bc
	add wa,(xsp+16)
	ld (_car_last_x__27),wa
	ld a,(xsp+3)
	sub a,(xsp+2)
	ld (_car_last_top__27),a
	ld a,(_body__27+28)
	cp a,1
	jp ule,L3468
	call _lean_pose__27
	ld (xsp+0),a
	ldb (xsp+1),0
	ld c,(xsp+0)
	cp c,0
	jr nz,L3469
	ld wa,0
	jr L3470
L3469:
	ld c,(_lean_side__27)
	cp c,0
	jr ge,L3471
	ld wa,2
	jr L3472
L3471:
	ld wa,1
L3472:
L3470:
	ld izl,a
	ld a,(xsp+2)
	push xwa
	ld a,(xsp+8)
	push xwa
	ld a,(xsp+11)
	push xwa
	ld a,12
	push xwa
	ld a,0
	push xwa
	ld a,5
	push xwa
	ld wa,(xsp+40)
	push xwa
	ld wa,0
	push xwa
	ld xwa,(_body__27+18)
	ld c,(_body__27+29)
	extz bc
	ld e,izl
	extz de
	add bc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+10)
	ld c,(_body__27+29)
	extz bc
	ld e,izl
	extz de
	add bc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+14)
	ld c,(_body__27+29)
	extz bc
	ld e,izl
	extz de
	add bc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+22)
	push xwa
	call _car_layer__27
	lda xsp,(xsp+48)
	ld a,(xsp+2)
	push xwa
	ld a,(xsp+8)
	push xwa
	ld a,(xsp+11)
	push xwa
	ld a,24
	push xwa
	ld a,12
	push xwa
	ld a,0
	push xwa
	ld wa,(xsp+40)
	push xwa
	ld a,(xsp+29)
	push xwa
	ld xwa,(_body__27+18)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+10)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+14)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+22)
	push xwa
	call _car_layer__27
	lda xsp,(xsp+48)
	jp L3450
L3468:
	ld c,(_lean_hold__27)
	cp c,0
	jr nz,L3473
	ld wa,0
	jr L3474
L3473:
	ld wa,1
L3474:
	ld (xsp+0),a
	ld c,(_lean_side__27)
	cp c,0
	jr le,L3475
	ld wa,1
	jr L3476
L3475:
	ld wa,0
L3476:
	ld (xsp+1),a
	ld a,(xsp+2)
	push xwa
	ld a,(xsp+8)
	push xwa
	ld a,(xsp+11)
	push xwa
	ld a,12
	push xwa
	ld a,0
	push xwa
	ld a,0
	push xwa
	ld wa,(xsp+40)
	push xwa
	ld a,(xsp+29)
	push xwa
	ld xwa,(_body__27+18)
	ld c,(xsp+32)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+10)
	ld c,(xsp+36)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+14)
	ld c,(xsp+40)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+22)
	push xwa
	call _car_layer__27
	lda xsp,(xsp+48)
	ld a,24
	push xwa
	ld a,12
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L3450:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function id_car_draw_at
_id_car_draw_at:
	ld wa,(xsp+4)
	ld (_car_at_x__27),wa
	ld a,(_body__27+28)
	cp a,1
	jr ule,L3480
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld a,(xsp+16)
	push xwa
	ld a,12
	push xwa
	ld a,0
	push xwa
	ld a,5
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld xwa,(_body__27+18)
	ld c,(_body__27+29)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+10)
	ld c,(_body__27+29)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+14)
	ld c,(_body__27+29)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+22)
	push xwa
	call _car_layer__27
	lda xsp,(xsp+48)
L3480:
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld a,(xsp+16)
	push xwa
	ld a,24
	push xwa
	ld a,12
	push xwa
	ld a,0
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld xwa,(_body__27+18)
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+10)
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+14)
	ld a,(xwa)
	push xwa
	ld xwa,(_body__27+22)
	push xwa
	call _car_layer__27
	lda xsp,(xsp+48)
	ldw (_car_at_x__27),32767
L3479:
	ret

; function id_car_height
_id_car_height:
	ld a,(_body__27+30)
	jr L3482
L3482:
	ret

; function course_art
_course_art__28:
	push xiz
	ld xiz,(xsp+12)
	ld xwa,_id_route_tiles
	ld (xiz),xwa
	ld xwa,_id_route_map
	ld (xiz+4),xwa
	ld xwa,_id_route_map_pal
	ld (xiz+8),xwa
	ld xwa,_id_route_palettes
	ld (xiz+12),xwa
	ld xwa,_id_route_road_half
	ld (xiz+16),xwa
	ldb (xiz+20),32
	ldb (xiz+21),64
	ldb (xiz+22),151
L3484:
	pop xiz
	ret

; function uses_akina
_uses_akina__28:
	ld wa,0
	jr L3486
L3486:
	ret

; function id_road_horizon
_id_road_horizon:
	ld xwa,_course_horizon__28
	ld c,(_road_course__28)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	jr L3488
L3488:
	ret

; function sky_is_tall_course
_sky_is_tall_course__28:
	ld wa,0
	jr L3490
L3490:
	ret

; function road_is_tarmac
_road_is_tarmac__28:
	ld wa,1
	jr L3492
L3492:
	ret

; function id_build_weights
_id_build_weights__28:
	push xiz
	lda xsp,(xsp-14)
	ld a,(_road_lines__28)
	extz wa
	sub wa,1
	ld (xsp+2),wa
	ld a,(_road_lines__28)
	extz wa
	ld c,(_road_lines__28)
	extz bc
	add bc,1
	mul xwa,bc
	ld (xsp+4),wa
	ld wa,32768
	ld bc,(xsp+4)
	srl 1,bc
	add wa,bc
	extz xwa
	div xwa,(xsp+4)
	sll 2,wa
	ld (_id_curve_cm__28),wa
	ld izl,0
	jp L3527
L3524:
	push xix
	push xiy
	call _uses_akina__28
	pop xiy
	pop xix
	cp a,0
	jp nz,L3528
	ld a,(_art__28+22)
	extz wa
	srl 3,wa
	extz wa
	add wa,1
	sll 3,wa
	sub wa,1
	ld c,(_art__28+21)
	extz bc
	sub wa,bc
	ld (xsp+6),wa
	ld wa,(xsp+6)
	ld c,izl
	extz bc
	mul xwa,bc
	extz xwa
	ld bc,(xsp+2)
	div xwa,bc
	ld (xsp+8),wa
	ld wa,(xsp+8)
	cp wa,(xsp+6)
	jr ule,L3529
	ld wa,(xsp+6)
	ld (xsp+8),wa
L3529:
	ld a,(xsp+8)
	ld xbc,_id_src__28
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(_art__28+16)
	ld bc,(xsp+8)
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld xbc,_id_half__28
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+8)
	mul xwa,255
	extz xwa
	div xwa,(xsp+6)
	ld iy,wa
	jr L3530
L3528:
	ld a,izl
	ld xbc,_id_src__28
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(_art__28+16)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld xbc,_id_half__28
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,izl
	extz wa
	mul xwa,255
	extz xwa
	div xwa,(xsp+2)
	ld iy,wa
L3530:
	ld wa,255
	sub wa,iy
	ld (xsp+6),wa
	ld a,(_road_top__28)
	add a,izl
	ld xbc,_id_sl__28
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,iyl
	ld xbc,_id_w_lat__28
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+6)
	mul xwa,(xsp+6)
	srl 8,wa
	ld xbc,_id_w_curve__28
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,iy
	cp wa,0
	jr nz,L3531
	ld wa,1600
	ld xbc,_id_ahead__28
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jr L3532
L3531:
	ld wa,60
	mul xwa,(xsp+6)
	extz xwa
	div xwa,iy
	ld (xsp+8),wa
	ld bc,(xsp+8)
	cp bc,1600
	jr ule,L3533
	ld wa,1600
	jr L3534
L3533:
	ld wa,(xsp+8)
L3534:
	ld xbc,_id_ahead__28
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3532:
	ld a,izl
	extz wa
	mul xwa,47
	extz xwa
	ld c,(_road_lines__28)
	extz bc
	sub bc,1
	div xwa,bc
	ld (xsp+8),wa
	ld wa,47
	ld xbc,_id_ahead__28
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	mul xbc,47
	push xwa
	push xix
	push xiy
	push xbc
	ld xwa,1600
	ld xbc,xwa
	pop xwa
	call __div32u
	ld xbc,xwa
	pop xiy
	pop xix
	pop xwa
	sub wa,bc
	ld (xsp+10),wa
	ld wa,(xsp+8)
	add wa,(xsp+10)
	srl 1,wa
	ld (xsp+12),wa
	ld wa,(xsp+12)
	sll 1,wa
	extz xwa
	div xwa,48
	ld wa,qwa
	ld (xsp+12),wa
	ld bc,(xsp+12)
	cp bc,47
	jr ule,L3535
	ld wa,47
	jr L3536
L3535:
	ld wa,(xsp+12)
L3536:
	ld xbc,_id_sl__28+128
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3526:
	inc 1,izl
L3527:
	ld a,izl
	cp a,(_road_lines__28)
	jp ult,L3524
L3525:
	ld a,(_road_lines__28)
	sub a,1
	ld (_wide_k0__28),a
	jr L3539
L3537:
	decb 1,(_wide_k0__28)
L3539:
	ld a,(_wide_k0__28)
	cp a,0
	jr ule,L3540
	ld xwa,_id_src__28
	ld c,(_wide_k0__28)
	sub c,1
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,48
	jr uge,L3537
L3540:
L3538:
	ld a,(_road_top__28)
	sub a,8
	ld (_climb_room__28),a
	push xix
	push xiy
	call _uses_akina__28
	pop xiy
	pop xix
	cp a,0
	jr z,L3541
	ld a,(_road_lines__28)
	extz wa
	extz xwa
	div xwa,10
	ld (_descent_room__28),a
	jr L3542
L3541:
	ld a,(_road_lines__28)
	extz wa
	srl 1,wa
	ld (_descent_room__28),a
L3542:
	ldb (_grade_hi__28),0
	ldb (_grade_lo__28),0
	ld ix,1
	jr L3546
L3543:
	ld a,(_road_lines__28)
	extz wa
	ld xbc,_hill_rate__28
	ld de,20
	add de,ix
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	mul xwa,bc
	srl 7,wa
	ld (xsp+6),wa
	ld wa,(xsp+6)
	ld c,(_road_lines__28)
	extz bc
	ld e,(_climb_room__28)
	extz de
	add bc,de
	cp wa,bc
	jr ugt,L3547
	ld a,ixl
	ld (_grade_hi__28),a
L3547:
L3545:
	inc 1,ix
L3546:
	ld wa,ix
	cp wa,20
	jr le,L3543
L3544:
	ld ix,1
	jr L3551
L3548:
	ld a,(_road_lines__28)
	extz wa
	ld xbc,_hill_rate__28
	ld de,20
	sub de,ix
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	mul xwa,bc
	srl 7,wa
	ld (xsp+6),wa
	ld wa,(xsp+6)
	ld c,(_descent_room__28)
	extz bc
	add wa,bc
	ld c,(_road_lines__28)
	extz bc
	cp wa,bc
	jr ult,L3552
	ld a,ixl
	neg a
	ld (_grade_lo__28),a
L3552:
L3550:
	inc 1,ix
L3551:
	ld wa,ix
	cp wa,20
	jr le,L3548
L3549:
L3523:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function rally_scan
_rally_scan__28:
	push xiz
	lda xsp,(xsp-6)
	ld a,(_rally_scanned__28)
	cp a,0
	jr z,L3571
	jp L3570
L3571:
	ldw (xsp+0),0
	jr L3575
L3572:
	ld a,255
	ld xbc,_rally_of__28
	ld de,(xsp+0)
	extz xde
	add xbc,xde
	ld (xbc),a
L3574:
	incw 1,(xsp+0)
L3575:
	ld wa,(xsp+0)
	cp wa,512
	jr ult,L3572
L3573:
	ldb (_rally_used__28),0
	ld a,(_art__28+21)
	extz wa
	srl 3,wa
	ld iyl,a
	jp L3579
L3576:
	ld ixl,0
	jr L3583
L3580:
	ld xwa,(_art__28+4)
	ld c,iyl
	extz bc
	ld e,(_art__28+20)
	extz de
	mul xbc,de
	ld e,ixl
	extz de
	add bc,de
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld iz,wa
	ld wa,iz
	cp wa,512
	jr uge,L3585
	ld xwa,_rally_of__28
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,255
	jr z,L3584
L3585:
	jr L3582
L3584:
	ld a,(_rally_used__28)
	cp a,255
	jr ult,L3586
	jr L3582
L3586:
	ld a,(_rally_used__28)
	ld xbc,_rally_of__28
	ld de,iz
	extz xde
	add xbc,xde
	ld (xbc),a
	ld wa,iz
	ld xbc,_rally_src__28
	ld e,(_rally_used__28)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	incb 1,(_rally_used__28)
L3582:
	inc 1,ixl
L3583:
	ld a,ixl
	cp a,(_art__28+20)
	jp ult,L3580
L3581:
L3578:
	inc 1,iyl
L3579:
	ld a,iyl
	cp a,29
	jp ult,L3576
L3577:
	ldb (_rally_scanned__28),1
L3570:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function id_road_char_count
_id_road_char_count:
	call _rally_scan__28
	ld a,(_rally_used__28)
	extz wa
	jr L3588
L3588:
	ret

; function id_load_chars
_id_load_chars__28:
	push xiz
	lda xsp,(xsp-18)
	push xix
	push xiy
	call _id_road_char_count
	pop xiy
	pop xix
	ld (xsp+2),wa
	ld xwa,(_art__28)
	ld (xsp+4),xwa
	ld ix,0
	jp L3604
L3601:
	ld wa,40960
	extz xwa
	ld bc,128
	add bc,ix
	mul xbc,16
	add xwa,xbc
	ld (xsp+8),xwa
	push xwa
	push xix
	push xiy
	call _uses_akina__28
	ld xbc,xwa
	pop xiy
	pop xix
	pop xwa
	cp c,0
	jr nz,L3605
	ld xwa,_rally_src__28
	ld bc,ix
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L3606
L3605:
	ld wa,ix
L3606:
	ld (xsp+12),wa
	ld iz,0
	jr L3610
L3607:
	ld xwa,(xsp+4)
	ld bc,(xsp+12)
	sll 3,bc
	add bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld iy,wa
	ld a,iyl
	and a,255
	ld xbc,(xsp+8)
	ld de,iz
	sll 1,de
	add de,0
	extz xde
	add xbc,xde
	ld (xbc),a
	ld wa,iy
	srl 8,wa
	ld xbc,(xsp+8)
	ld de,iz
	sll 1,de
	add de,1
	extz xde
	add xbc,xde
	ld (xbc),a
L3609:
	inc 1,iz
L3610:
	ld wa,iz
	cp wa,8
	jr ult,L3607
L3608:
L3603:
	inc 1,ix
L3604:
	ld wa,ix
	cp wa,(xsp+2)
	jp ult,L3601
L3602:
L3600:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_load_palettes
_id_load_palettes__28:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L3620
L3617:
	ld xwa,(_art__28+12)
	ld c,izl
	extz bc
	sll 2,bc
	add bc,3
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,(_art__28+12)
	ld c,izl
	extz bc
	sll 2,bc
	add bc,2
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,(_art__28+12)
	ld c,izl
	extz bc
	sll 2,bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,(_art__28+12)
	ld c,izl
	extz bc
	sll 2,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld a,izl
	push xwa
	ld wa,1
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
L3619:
	inc 1,izl
L3620:
	ld a,izl
	cp a,8
	jp ult,L3617
L3618:
	ld wa,4095
	push xwa
	ld wa,1365
	push xwa
	ld wa,819
	push xwa
	ld wa,82
	push xwa
	ld wa,0
	push xwa
	ld wa,1
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ld xwa,(_art__28+12)
	ld wa,(xwa)
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
L3616:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_reload_backdrop
_id_road_reload_backdrop:
	ld xwa,(_art__28+12)
	ld wa,(xwa)
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
L3622:
	ret

; function id_road_set_colors
_id_road_set_colors:
	push xiz
	lda xsp,(xsp-2)
	ld xix,(xsp+22)
	push xix
	ld wa,(xsp+22)
	push xwa
	ld wa,(xix)
	push xwa
	ld wa,(xsp+26)
	push xwa
	ld wa,(xsp+26)
	push xwa
	ld wa,0
	push xwa
	ld wa,1
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xix
	push xix
	ld wa,(xsp+22)
	push xwa
	ld wa,(xix)
	push xwa
	ld wa,(xsp+26)
	push xwa
	ld wa,(xsp+26)
	push xwa
	ld wa,1
	push xwa
	ld wa,1
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xix
	push xix
	ld wa,(xsp+14)
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
	pop xix
	ld izl,0
	jr L3632
L3629:
	ld xwa,xix
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_band_col__28
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3631:
	inc 1,izl
L3632:
	ld a,izl
	cp a,4
	jr ult,L3629
L3630:
	ldw (_bc_rest__28),65535
	ldw (_bc_rest__28+2),65535
L3628:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_load_maps_rally
_id_load_maps_rally__28:
	push xiz
	lda xsp,(xsp-12)
	ld a,(_road_plane0__28)
	extz wa
	srl 3,wa
	exts wa
	ld c,(_art__28+21)
	extz bc
	srl 3,bc
	exts bc
	sub wa,bc
	ld (xsp+2),a
	push xix
	push xiy
	call _rally_scan__28
	pop xiy
	pop xix
	ld a,(_road_plane0__28)
	extz wa
	srl 3,wa
	ld iyl,a
	jp L3654
L3651:
	ld a,iyl
	ld c,(xsp+2)
	sub a,c
	ld (xsp+3),a
	ld a,(xsp+3)
	cp a,28
	jr ule,L3655
	ldb (xsp+3),28
L3655:
	ld izl,0
	jp L3659
L3656:
	ld wa,0
	ld (xsp+4),a
	ld a,(xsp+3)
	ld (xsp+5),a
	ld a,izl
	cp a,0
	jr uge,L3660
	ld a,(_art__28+21)
	extz wa
	srl 3,wa
	ld (xsp+5),a
	jr L3661
L3660:
	ld a,izl
	ld c,0
	add c,(_art__28+20)
	cp a,c
	jr ult,L3662
	ld a,(_art__28+20)
	sub a,1
	ld (xsp+4),a
	ld a,(_art__28+21)
	extz wa
	srl 3,wa
	ld (xsp+5),a
	jr L3663
L3662:
	ld a,izl
	sub a,0
	ld (xsp+4),a
L3663:
L3661:
	ld a,(xsp+5)
	extz wa
	ld c,(_art__28+20)
	extz bc
	mul xwa,bc
	ld c,(xsp+4)
	extz bc
	add wa,bc
	ld (xsp+6),wa
	ld xwa,(_art__28+4)
	ld bc,(xsp+6)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+8),wa
	ld bc,(xsp+8)
	cp bc,512
	jr uge,L3664
	ld xwa,_rally_of__28
	ld bc,(xsp+8)
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L3665
L3664:
	ld wa,255
L3665:
	ld ixl,a
	ld a,ixl
	cp a,255
	jr nz,L3666
	ld ixl,0
L3666:
	ld wa,128
	ld c,ixl
	extz bc
	add wa,bc
	ld xbc,(_art__28+8)
	ld de,(xsp+6)
	extz xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	and bc,7
	sll 9,bc
	add wa,bc
	ld xbc,38912
	ld e,iyl
	extz de
	sll 5,de
	ld l,izl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3658:
	inc 1,izl
L3659:
	ld a,izl
	cp a,32
	jp ult,L3656
L3657:
L3653:
	inc 1,iyl
L3654:
	ld a,iyl
	cp a,32
	jp ult,L3651
L3652:
L3650:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function id_load_maps
_id_load_maps__28:
	call _id_load_maps_rally__28
L3668:
	ret

; function id_road_reload_maps
_id_road_reload_maps:
	call _id_load_palettes__28
	call _id_load_maps_rally__28
L3670:
	ret

; function id_build_shear_limits
_id_build_shear_limits__28:
	push xiz
	lda xsp,(xsp-18)
	push xix
	push xiy
	call _uses_akina__28
	pop xiy
	pop xix
	cp a,0
	jp nz,L3702
	ld izl,0
	jr L3706
L3703:
	ld xwa,_id_src__28
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+1),a
	ld wa,144
	ld (xsp+2),wa
	ld a,(xsp+1)
	cp a,48
	jr uge,L3707
	ld xwa,_id_route_lim0
	ld c,(xsp+1)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	sub wa,3
	ld (xsp+4),wa
	ld wa,(xsp+4)
	cp wa,(xsp+2)
	jr ge,L3708
	ld wa,(xsp+4)
	ld (xsp+2),wa
L3708:
L3707:
	ld wa,(xsp+2)
	neg wa
	ld xbc,_id_dxc__28
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+2)
	ld xbc,_id_dxc__28+128
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3705:
	inc 1,izl
L3706:
	ld a,izl
	cp a,(_road_lines__28)
	jp ult,L3703
L3704:
	jp L3701
L3702:
	ld izl,0
	jp L3712
L3709:
	ld a,(_road_top__28)
	extz wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+2),wa
	ld wa,999
	ld (xsp+6),wa
	ld wa,0
	ld (xsp+8),wa
	ldb (xsp+4),0
	jr L3716
L3713:
	ld wa,0
	ld (xsp+10),wa
	ld wa,0
	ld (xsp+12),wa
	ld wa,(xsp+12)
	cp wa,0
	jr nz,L3717
	jr L3715
L3717:
	ld ixl,0
	jr L3721
L3718:
	ld wa,(xsp+12)
	ld bc,14
	ld de,2
	ld l,ixl
	extz hl
	mul xde,hl
	sub bc,de
	cp c,0
	jr z,L3724
L3723:
	srl 1,wa
	djnz c,L3723
L3724:
	and wa,3
	cp wa,0
	jr z,L3722
	ld a,(xsp+4)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld iy,wa
	ld wa,iy
	cp wa,(xsp+6)
	jr uge,L3725
	ld wa,iy
	ld (xsp+6),wa
L3725:
	ld wa,iy
	cp wa,(xsp+8)
	jr ule,L3726
	ld wa,iy
	ld (xsp+8),wa
L3726:
L3722:
L3720:
	inc 1,ixl
L3721:
	ld a,ixl
	cp a,8
	jr ult,L3718
L3719:
L3715:
	incb 1,(xsp+4)
L3716:
	ld a,(xsp+4)
	cp a,32
	jr ult,L3713
L3714:
	ld wa,(xsp+6)
	cp wa,(xsp+8)
	jr ule,L3727
	ld wa,65409
	ld xbc,_id_dxc__28
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,127
	ld xbc,_id_dxc__28+128
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jr L3728
L3727:
	ld wa,(xsp+8)
	sub wa,255
	sub wa,7
	ld xbc,_id_dxc__28
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+6)
	add wa,97
	sub wa,7
	ld xbc,_id_dxc__28+128
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3728:
	ld xwa,_id_dxc__28+128
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,88
	jr le,L3729
	ld wa,88
	ld xbc,_id_dxc__28+128
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3729:
	ld xwa,_id_dxc__28
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65448
	jr ge,L3730
	ld wa,65448
	ld xbc,_id_dxc__28
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3730:
L3711:
	inc 1,izl
L3712:
	ld a,izl
	cp a,(_road_lines__28)
	jp ult,L3709
L3710:
L3701:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_road_course
_id_road_course:
	ld a,(_road_course__28)
	jr L3732
L3732:
	ret

; function id_road_top
_id_road_top:
	ld a,(_road_top__28)
	jr L3734
L3734:
	ret

; function id_road_bottom
_id_road_bottom:
	ld a,(_road_bottom__28)
	jr L3736
L3736:
	ret

; function id_road_select
_id_road_select:
	push xiz
	lda xsp,(xsp-14)
	ld c,(xsp+22)
	cp c,1
	jr uge,L3776
	ld a,(xsp+22)
	extz wa
	jr L3777
L3776:
	ld wa,0
L3777:
	ld (_road_course__28),a
	push xix
	ld wa,0
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
	pop xix
	push xix
	call _uses_akina__28
	pop xix
	cp a,0
	jr nz,L3778
	push xix
	ld xwa,_art__28
	push xwa
	ld a,(_road_course__28)
	push xwa
	call _course_art__28
	lda xsp,(xsp+8)
	pop xix
	ldb (_rally_scanned__28),0
L3778:
	push xix
	call _uses_akina__28
	pop xix
	cp a,0
	jr nz,L3779
	ldb (_road_base_x__28),48
	ldb (_road_top__28),88
	push xwa
	push xix
	call _sky_is_tall_course__28
	ld xbc,xwa
	pop xix
	pop xwa
	cp c,0
	jr z,L3780
	ld a,88
	extz wa
	jr L3781
L3780:
	ld a,88
	extz wa
L3781:
	ld (_road_plane0__28),a
	ldb (_road_lines__28),64
	jr L3782
L3779:
	ldb (_road_base_x__28),7
	ldb (_road_top__28),72
	ldb (_road_plane0__28),72
	ldb (_road_lines__28),40
L3782:
	ld a,(_road_top__28)
	add a,(_road_lines__28)
	sub a,1
	ld (_road_bottom__28),a
	ld a,(_road_lines__28)
	extz wa
	extz xwa
	div xwa,6
	ld (_car_stand__28),a
	ld a,(_car_stand__28)
	cp a,(_road_lines__28)
	jr ult,L3783
	ld a,(_road_lines__28)
	sub a,1
	ld (_car_stand__28),a
L3783:
	push xix
	call _id_load_chars__28
	pop xix
	push xix
	call _id_load_palettes__28
	pop xix
	push xix
	call _uses_akina__28
	pop xix
	cp a,0
	jr nz,L3784
	push xix
	call _id_load_maps_rally__28
	pop xix
	jr L3785
L3784:
	push xix
	call _id_load_maps__28
	pop xix
L3785:
	ldb (xsp+0),0
	jr L3789
L3786:
	ld wa,0
	ld xbc,_id_shear__28
	ld e,(xsp+0)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3788:
	incb 1,(xsp+0)
L3789:
	ld a,(xsp+0)
	cp a,(_road_lines__28)
	jr ult,L3786
L3787:
	ldw (_band_top__28),65535
	ldw (_band_top__28+2),65535
	ldw (_band_mid__28),65535
	ldw (_band_mid__28+2),65535
	ldw (_band_tree__28),65535
	ldw (_band_tree__28+2),65535
	ldb (_band_bg_first__28),255
	ldb (_band_bg_first__28+1),255
	push xwa
	push xix
	call _uses_akina__28
	ld xbc,xwa
	pop xix
	pop xwa
	cp c,0
	jr z,L3790
	ld wa,3
	jr L3791
L3790:
	ld wa,0
L3791:
	ld (_road_band_pal__28),a
	ld xwa,33536
	ld c,(_road_band_pal__28)
	extz bc
	sll 2,bc
	add bc,2
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+2),wa
	ld izl,0
	jp L3795
L3792:
	ld wa,3
	ld c,izl
	extz bc
	sub wa,bc
	ld ix,wa
	ld wa,(xsp+2)
	srl 8,wa
	and wa,15
	ld (xsp+8),wa
	ld wa,(xsp+2)
	srl 4,wa
	and wa,15
	ld (xsp+10),wa
	ld wa,(xsp+2)
	and wa,15
	ld (xsp+12),wa
	ld bc,(xsp+8)
	cp bc,ix
	jr ule,L3796
	ld wa,(xsp+8)
	sub wa,ix
	jr L3797
L3796:
	ld wa,0
L3797:
	ld (xsp+8),wa
	ld bc,(xsp+10)
	cp bc,ix
	jr ule,L3798
	ld wa,(xsp+10)
	sub wa,ix
	jr L3799
L3798:
	ld wa,0
L3799:
	ld (xsp+10),wa
	ld bc,(xsp+12)
	cp bc,ix
	jr ule,L3800
	ld wa,(xsp+12)
	sub wa,ix
	jr L3801
L3800:
	ld wa,0
L3801:
	ld (xsp+12),wa
	ld wa,(xsp+8)
	sll 8,wa
	ld bc,(xsp+10)
	sll 4,bc
	or wa,bc
	or wa,(xsp+12)
	ld xbc,_band_col__28
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3794:
	inc 1,izl
L3795:
	ld a,izl
	cp a,4
	jp ult,L3792
L3793:
	push xix
	call _road_is_tarmac__28
	pop xix
	cp a,0
	jr z,L3802
	ld izl,0
	jr L3806
L3803:
	ld xwa,_course_sol__28
	ld c,(_road_course__28)
	extz bc
	muls xbc,18
	add xwa,xbc
	lda xwa,(xwa+10)
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_band_col__28
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3805:
	inc 1,izl
L3806:
	ld a,izl
	cp a,4
	jr ult,L3803
L3804:
	jr L3807
L3802:
	push xix
	call _uses_akina__28
	pop xix
	cp a,0
	jr nz,L3808
	ld izl,0
	jr L3812
L3809:
	ld wa,(xsp+2)
	ld xbc,_band_col__28
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3811:
	inc 1,izl
L3812:
	ld a,izl
	cp a,4
	jr ult,L3809
L3810:
L3808:
L3807:
	push xix
	call _id_build_weights__28
	pop xix
	push xix
	call _id_build_shear_limits__28
	pop xix
	push xix
	call _id_fill_hud_band__28
	pop xix
	push xix
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	call _id_road_frame
	lda xsp,(xsp+12)
	pop xix
L3775:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function id_road_dma_pause
_id_road_dma_pause:
	ld a,(_road_dma_depth__28)
	cp a,255
	jr uge,L3817
	incb 1,(_road_dma_depth__28)
L3817:
	ld a,(_road_dma_live__28)
	cp a,0
	jr z,L3818
	ld xwa,0
	push xwa
	call _ngpc_set_vblank_hook
	lda xsp,(xsp+4)
	ld xwa,_id_raster__28
	push xwa
	call _ngpc_dma_raster_xy_disable
	lda xsp,(xsp+4)
	ld xwa,_id_bandstream__28
	push xwa
	call _ngpc_dma_stream_end_u16
	lda xsp,(xsp+4)
	ldb (_road_dma_live__28),0
L3818:
L3816:
	ret

; function id_road_dma_resume
_id_road_dma_resume:
	ld a,(_road_dma_depth__28)
	cp a,0
	jr z,L3825
	decb 1,(_road_dma_depth__28)
L3825:
	ld a,(_road_dma_depth__28)
	cp a,0
	jr z,L3826
	jp L3824
L3826:
	ld a,(_road_dma_live__28)
	cp a,0
	jp nz,L3827
	ld xwa,(_id_xy_live__28)
	push xwa
	ld wa,1
	push xwa
	ld xwa,_id_raster__28
	push xwa
	call _ngpc_dma_raster_xy_begin
	lda xsp,(xsp+12)
	ld xwa,_id_raster__28
	push xwa
	call _ngpc_dma_raster_xy_enable
	lda xsp,(xsp+4)
	call _uses_akina__28
	cp a,0
	jr nz,L3828
	call _road_is_tarmac__28
	cp a,0
	jr nz,L3828
	ldw (_id_bandstream__28+10),0
	ldb (_road_dma_live__28),1
	ld xwa,_id_road_rearm
	push xwa
	call _ngpc_set_vblank_hook
	lda xsp,(xsp+4)
	jr L3824
L3828:
	call _ngpc_dma_timer01_hblank_enable
	ld wa,17
	push xwa
	ld wa,152
	push xwa
	ld xwa,(_id_bandcol__28)
	push xwa
	ld xwa,33536
	ld c,(_road_band_pal__28)
	extz bc
	sll 2,bc
	add bc,2
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	push xwa
	ld wa,1
	push xwa
	ld xwa,_id_bandstream__28
	push xwa
	call _ngpc_dma_stream_begin_u16
	lda xsp,(xsp+24)
	ld xwa,_id_bandstream__28
	push xwa
	call _ngpc_dma_stream_rearm_u16
	lda xsp,(xsp+4)
	ldb (_road_dma_live__28),1
	ld xwa,_id_road_rearm
	push xwa
	call _ngpc_set_vblank_hook
	lda xsp,(xsp+4)
L3827:
L3824:
	ret

; function id_road_init
_id_road_init:
	ld wa,0
	push xwa
	call _id_road_select
	lda xsp,(xsp+4)
	call _ngpc_dma_init
	call _id_road_dma_resume
L3830:
	ret

; function id_road_flat
_id_road_flat:
	push xiz
	lda xsp,(xsp-2)
	ld iz,0
	jr L3840
L3837:
	ld wa,0
	ld xbc,_id_xy_a__28
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,0
	ld xbc,_id_xy_b__28
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(_band_col__28+6)
	ld xbc,_id_bandcol_a__28
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(_band_col__28+6)
	ld xbc,_id_bandcol_b__28
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3839:
	inc 1,iz
L3840:
	ld wa,iz
	cp wa,152
	jr ult,L3837
L3838:
	ldw (_bc_rest__28),65535
	ldw (_bc_rest__28+2),65535
	ld wa,0
	exts xwa
	ld (_id_xy_done__28),xwa
	ld wa,0
	exts xwa
	ld (_id_bandcol_done__28),xwa
	ldw (_band_top__28),65535
	ldw (_band_top__28+2),65535
	ldw (_band_mid__28),65535
	ldw (_band_mid__28+2),65535
	ldw (_band_tree__28),65535
	ldw (_band_tree__28+2),65535
	ldb (08034h),0
	ldb (08035h),0
L3836:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_rearm
_id_road_rearm:
	ld xwa,(_id_xy_done__28)
	cp xwa,0
	jr z,L3845
	ld xwa,(_id_xy_done__28)
	ld (_id_xy_live__28),xwa
	ld xwa,(_id_xy_done__28)
	ld (_id_raster__28+2),xwa
	ld xwa,(_id_xy_done__28)
	ld (_id_raster__28+6+6),xwa
	ld xwa,(_id_bandcol_done__28)
	ld (_id_bandstream__28+6),xwa
	ld wa,0
	exts xwa
	ld (_id_xy_done__28),xwa
	ld wa,0
	exts xwa
	ld (_id_bandcol_done__28),xwa
L3845:
	ld xwa,_id_raster__28
	push xwa
	call _ngpc_dma_raster_xy_rearm
	lda xsp,(xsp+4)
	ld wa,(_id_bandstream__28+10)
	cp wa,0
	jr z,L3846
	ld xwa,_id_bandstream__28
	push xwa
	call _ngpc_dma_stream_rearm_u16
	lda xsp,(xsp+4)
L3846:
L3844:
	ret

; function id_road_dma_state
_id_road_dma_state:
	ld a,(_id_raster__28+1)
	extz wa
	ld xde,(_id_raster__28+2)
	cp xde,0
	jr z,L3851
	ld bc,2
	jr L3852
L3851:
	ld bc,0
L3852:
	or wa,bc
	jr L3850
L3850:
	ret

; function id_road_xy_at
_id_road_xy_at:
	ld xwa,(_id_xy__28)
	ld c,(xsp+4)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L3854
L3854:
	ret

; function id_road_restore_map
_id_road_restore_map:
	call _uses_akina__28
	cp a,0
	jr nz,L3859
	call _id_load_maps_rally__28
	jr L3860
L3859:
	call _id_load_maps__28
L3860:
L3858:
	ret

; function id_road_reload
_id_road_reload:
	call _id_fill_hud_band__28
	ld wa,0
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
	call _id_load_palettes__28
	call _uses_akina__28
	cp a,0
	jr nz,L3865
	call _id_load_maps_rally__28
	jr L3866
L3865:
	call _id_load_maps__28
L3866:
L3864:
	ret

; function wide_rows
_wide_rows__28:
	push xiz
	lda xsp,(xsp-12)
	ld a,(_road_bottom__28)
	ld ixl,a
L3886:
	ld xwa,(xsp+20)
	ld c,ixl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+2),wa
	ld wa,(xsp+2)
	srl 8,wa
	ld (xsp+4),a
	ld a,(xsp+2)
	ld (xsp+5),a
	ld a,(xsp+4)
	add a,ixl
	sub a,(xsp+28)
	ld (xsp+6),a
	ld a,(xsp+6)
	cp a,48
	jr ult,L3891
	ld a,(xsp+6)
	cp a,88
	jr ult,L3890
L3891:
	jp L3887
L3890:
	ld a,(xsp+5)
	sub a,(xsp+24)
	ld izl,a
	ld wa,(xsp+36)
	cp wa,0
	jr lt,L3892
	ld c,izl
	cp c,144
	jr ult,L3893
	ld a,izl
	extz wa
	sub wa,256
	jr L3894
L3893:
	ld a,izl
	extz wa
L3894:
	ld iy,wa
	jr L3895
L3892:
	ld c,izl
	cp c,112
	jr ule,L3896
	ld a,izl
	extz wa
	sub wa,256
	jr L3897
L3896:
	ld a,izl
	extz wa
L3897:
	ld iy,wa
L3895:
	ld xwa,_id_route_lim0
	ld c,(xsp+6)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+10),a
	ld wa,iy
	cp wa,0
	jr lt,L3898
	ld wa,iy
	ld c,(xsp+10)
	extz bc
	cp wa,bc
	jr ult,L3899
	ld a,(xsp+4)
	add a,40
	extz wa
	sll 8,wa
	ld c,(xsp+5)
	sub c,96
	extz bc
	or wa,bc
	ld xbc,(xsp+20)
	ld e,ixl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3899:
	jr L3900
L3898:
	ld wa,iy
	neg wa
	ld c,(xsp+10)
	extz bc
	cp wa,bc
	jr ult,L3901
	ld a,(xsp+4)
	add a,80
	extz wa
	sll 8,wa
	ld c,(xsp+5)
	add c,96
	extz bc
	or wa,bc
	ld xbc,(xsp+20)
	ld e,ixl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3901:
L3900:
	ld a,ixl
	extz wa
	ld bc,(xsp+32)
	add bc,1
	cp wa,bc
	jr gt,L3902
	jr L3887
L3902:
	dec 1,ixl
L3888:
L3889:
	jp L3886
L3887:
L3885:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function id_road_write
_id_road_write__28:
	push xiz
	lda xsp,(xsp-82)
	ld wa,0
	ld (xsp+12),a
	ld wa,(_band_col__28+6)
	ld (xsp+14),wa
	ld a,(_road_bottom__28)
	extz wa
	ld iz,wa
	ld a,(_road_top__28)
	extz wa
	ld c,(_climb_room__28)
	extz bc
	sub wa,bc
	ld (xsp+22),wa
	ld xwa,_band_lut__28
	ld bc,(_band_phase__28)
	srl 1,bc
	and bc,15
	mul xbc,48
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+28),xwa
	ld xwa,(_id_xy__28)
	ld (xsp+32),xwa
	ld xwa,(_id_bandcol__28)
	ld (xsp+36),xwa
	ld a,(_road_base_x__28)
	ld (xsp+40),a
	ld a,(_road_plane0__28)
	ld (xsp+41),a
	ld xwa,_id_src__28
	ld c,(_road_lines__28)
	extz bc
	sub bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	sll 8,wa
	ld (xsp+16),wa
	ld xwa,_id_src__28
	ld c,(_road_lines__28)
	extz bc
	sub bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	ld c,(_id_src__28)
	extz bc
	sub wa,bc
	sll 8,wa
	exts xwa
	ld c,(_road_lines__28)
	extz bc
	sub bc,1
	divs xwa,bc
	ld (xsp+18),wa
	ld a,(_road_lines__28)
	cp a,0
	jr z,L4003
	ld xwa,_id_w_lat__28
	ld (xsp+42),xwa
	ld xwa,_id_curve_dx__28
	ld (xsp+46),xwa
	ld xwa,_id_dxc__28+128
	ld (xsp+50),xwa
	ld xwa,_id_shear__28
	ld (xsp+54),xwa
	ld wa,(xsp+90)
	ld (xsp+58),wa
	ld a,(_road_lines__28)
	extz wa
	ld (xsp+60),wa
	push xix
	push xiy
	lda xwa,(xsp+50)
	push xwa
	call _id_road_shear_asm
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L4003:
	ld a,(_road_lines__28)
	cp a,0
	jp z,L4004
	ld wa,(xsp+22)
	cp wa,2
	jp lt,L4004
	ld wa,(xsp+22)
	cp wa,255
	jp gt,L4004
	ld a,(_road_lines__28)
	extz wa
	sub wa,1
	ld (xsp+24),wa
	ld wa,iz
	cp wa,(xsp+22)
	jp lt,L4005
	ld xwa,(xsp+32)
	ld bc,iz
	exts xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+42),xwa
	ld xwa,(xsp+36)
	ld bc,iz
	exts xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+46),xwa
	ld xwa,_id_sl__28
	ld c,(_road_lines__28)
	extz bc
	exts xbc
	add xwa,xbc
	ld (xsp+50),xwa
	ld xwa,_id_shear__28
	ld c,(_road_lines__28)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+54),xwa
	ld xwa,_hill_rate__28+20
	ld (xsp+58),xwa
	ld xwa,(xsp+28)
	ld (xsp+62),xwa
	ld xwa,_band_col__28
	ld (xsp+66),xwa
	ld wa,(xsp+16)
	ld (xsp+70),wa
	ld wa,(xsp+18)
	ld (xsp+72),wa
	ld wa,(xsp+18)
	srl 1,wa
	ld (xsp+74),wa
	ld a,(xsp+22)
	ld (xsp+76),a
	ld a,(xsp+41)
	ld (xsp+77),a
	ld a,(xsp+40)
	ld (xsp+78),a
	ld a,(_road_lines__28)
	ld (xsp+79),a
	ld a,izl
	ld (xsp+80),a
	push xix
	push xiy
	lda xwa,(xsp+50)
	push xwa
	call _id_road_walk_asm
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld a,(xsp+79)
	extz wa
	sub wa,1
	ld (xsp+24),wa
	ld a,(xsp+80)
	extz wa
	ld iz,wa
L4005:
	jp L4006
L4004:
	ld a,(_road_lines__28)
	extz wa
	sub wa,1
	ld (xsp+24),wa
	jp L4010
L4007:
	ld xwa,_hill_rate__28
	ld bc,20
	ld xde,_id_sl__28+64
	ld hl,(xsp+24)
	exts xhl
	add xde,xhl
	ld e,(xde)
	exts de
	add bc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+42),a
	ld a,(xsp+12)
	extz wa
	ld c,(xsp+42)
	extz bc
	add wa,bc
	ld c,(xsp+42)
	extz bc
	add wa,bc
	ld (xsp+44),wa
	ld wa,(xsp+44)
	srl 8,wa
	ld (xsp+43),a
	ld a,(xsp+44)
	ld (xsp+12),a
	ld xwa,_id_shear__28
	ld bc,(xsp+24)
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+46),wa
	ld bc,iz
	cp bc,(xsp+22)
	jr ge,L4011
	ld wa,(xsp+22)
	jr L4012
L4011:
	ld wa,iz
L4012:
	ld xbc,_id_sl__28
	ld de,(xsp+24)
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,_band_col__28
	ld xbc,(xsp+28)
	ld xde,_id_sl__28+128
	ld hl,(xsp+24)
	exts xhl
	add xde,xhl
	ld e,(xde)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+14),wa
	ld a,(xsp+43)
	cp a,1
	jr ult,L4013
	ld wa,iz
	cp wa,(xsp+22)
	jr lt,L4013
	ld a,izl
	ld (xsp+48),a
	ld wa,(xsp+16)
	srl 8,wa
	extz wa
	ld c,(xsp+48)
	sub c,(xsp+41)
	extz bc
	sub wa,bc
	extz wa
	sll 8,wa
	ld c,(xsp+40)
	add c,(xsp+46)
	extz bc
	or wa,bc
	ld xbc,(xsp+32)
	ld e,(xsp+48)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+14)
	ld xbc,(xsp+36)
	ld e,(xsp+48)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	dec 1,iz
L4013:
	ld a,(xsp+43)
	cp a,2
	jr nz,L4014
	ld wa,iz
	cp wa,(xsp+22)
	jr lt,L4014
	ld a,izl
	ld (xsp+48),a
	ld wa,(xsp+18)
	srl 1,wa
	ld (xsp+50),wa
	ld bc,(xsp+16)
	cp bc,(xsp+50)
	jr ule,L4015
	ld wa,(xsp+16)
	sub wa,(xsp+50)
	jr L4016
L4015:
	ld wa,(xsp+16)
L4016:
	ld (xsp+52),wa
	ld wa,(xsp+52)
	srl 8,wa
	extz wa
	ld c,(xsp+48)
	sub c,(xsp+41)
	extz bc
	sub wa,bc
	extz wa
	sll 8,wa
	ld c,(xsp+40)
	add c,(xsp+46)
	extz bc
	or wa,bc
	ld xbc,(xsp+32)
	ld e,(xsp+48)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+14)
	ld xbc,(xsp+36)
	ld e,(xsp+48)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	dec 1,iz
L4014:
	ld wa,(xsp+16)
	ld bc,(xsp+18)
	sub wa,bc
	ld (xsp+16),wa
	ld wa,iz
	cp wa,(xsp+22)
	jr ge,L4017
	jr L4008
L4017:
L4009:
	decw 1,(xsp+24)
L4010:
	ld wa,(xsp+24)
	cp wa,0
	jp ge,L4007
L4008:
L4006:
	ld xwa,_id_shear__28
	ld c,(_wide_k0__28)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+42),wa
	ld xwa,_id_shear__28
	ld c,(_road_lines__28)
	extz bc
	sub bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+44),wa
	ld wa,(xsp+42)
	cp wa,0
	jr ge,L4018
	ld wa,(xsp+42)
	neg wa
	ld (xsp+42),wa
L4018:
	ld wa,(xsp+44)
	cp wa,0
	jr ge,L4019
	ld wa,(xsp+44)
	neg wa
	ld (xsp+44),wa
L4019:
	ld wa,(xsp+42)
	cp wa,46
	jr ge,L4021
	ld wa,(xsp+44)
	cp wa,46
	jr lt,L4020
L4021:
	push xix
	push xiy
	ld wa,(xsp+98)
	push xwa
	ld wa,iz
	push xwa
	ld a,(xsp+57)
	push xwa
	ld a,(xsp+60)
	push xwa
	ld xwa,(xsp+56)
	push xwa
	call _wide_rows__28
	lda xsp,(xsp+20)
	pop xiy
	pop xix
L4020:
	ld bc,(xsp+24)
	cp bc,0
	jr ge,L4022
	ld wa,1
	jr L4023
L4022:
	ld wa,0
L4023:
	ld (xsp+26),a
	jr L4026
L4024:
	ld a,(xsp+22)
	ld xbc,_id_sl__28
	ld de,(xsp+24)
	exts xde
	add xbc,xde
	ld (xbc),a
	decw 1,(xsp+24)
L4026:
	ld wa,(xsp+24)
	cp wa,0
	jr ge,L4024
L4025:
	ld a,izl
	add a,1
	ld (_band_first__28),a
	ld a,(_band_first__28)
	cp a,(_band_held__28)
	jp ule,L4027
	ld a,(_band_first__28)
	sub a,(_band_held__28)
	cp a,2
	jr uge,L4029
	ld a,(_band_wait__28)
	cp a,16
	jr ult,L4028
L4029:
	ldb (_band_wait__28),0
	jr L4030
L4028:
	incb 1,(_band_wait__28)
	jr L4033
L4031:
	decb 1,(_band_first__28)
	ld xwa,(_id_xy__28)
	ld c,(_band_first__28)
	extz bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(_id_xy__28)
	ld e,(_band_first__28)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,(_id_bandcol__28)
	ld c,(_band_first__28)
	extz bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(_id_bandcol__28)
	ld e,(_band_first__28)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4033:
	ld a,(_band_first__28)
	cp a,(_band_held__28)
	jr ugt,L4031
L4032:
L4030:
	jr L4034
L4027:
	ldb (_band_wait__28),0
L4034:
	ld a,(_band_first__28)
	ld (_band_held__28),a
	ld a,(_road_top__28)
	extz wa
	ld c,(_band_first__28)
	extz bc
	sub wa,bc
	ld (xsp+42),wa
	ld wa,(_band_col__28+6)
	ld (xsp+46),wa
	push xix
	push xiy
	call _road_is_tarmac__28
	pop xiy
	pop xix
	cp a,0
	jp z,L4035
	ld wa,(_band_col__28)
	ld (xsp+56),wa
	ld wa,0
	ld bc,(_band_phase__28)
	srl 5,bc
	sub wa,bc
	ld (xsp+58),a
	ld a,(_road_top__28)
	extz wa
	ld (xsp+44),wa
	ld wa,(xsp+44)
	ld c,(_road_bottom__28)
	extz bc
	cp wa,bc
	jr ule,L4036
	ld a,(_road_bottom__28)
	extz wa
	ld (xsp+44),wa
L4036:
	ld xwa,(_id_bandcol__28)
	ld c,(_band_first__28)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+48),xwa
	ld xwa,(_id_bandcol__28)
	ld bc,(xsp+44)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+52),xwa
	jr L4039
L4037:
	ld c,(xsp+58)
	incb 1,(xsp+58)
	extz bc
	and bc,2
	cp bc,0
	jr z,L4040
	ld wa,(xsp+46)
	jr L4041
L4040:
	ld wa,(xsp+56)
L4041:
	ld xbc,(xsp+48)
	inc 2,xbc
	ld (xsp+48),xbc
	dec 2,xbc
	ld (xbc),wa
L4039:
	ld xwa,(xsp+48)
	cp xwa,(xsp+52)
	jr ult,L4037
L4038:
	jr L4042
L4035:
	ld wa,(xsp+42)
	cp wa,24
	jr le,L4043
	ldw (xsp+42),24
L4043:
	ld a,(_band_first__28)
	extz wa
	ld de,(xsp+42)
	cp de,0
	jr le,L4044
	ld bc,(xsp+42)
	jr L4045
L4044:
	ld bc,0
L4045:
	add wa,bc
	ld (xsp+44),wa
	ld wa,(xsp+44)
	ld c,(_road_bottom__28)
	extz bc
	cp wa,bc
	jr ule,L4046
	ld a,(_road_bottom__28)
	extz wa
	ld (xsp+44),wa
L4046:
	ld xwa,(_id_bandcol__28)
	ld c,(_band_first__28)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+48),xwa
	ld xwa,(_id_bandcol__28)
	ld bc,(xsp+44)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+52),xwa
	jr L4049
L4047:
	ld wa,(xsp+46)
	ld xbc,(xsp+48)
	inc 2,xbc
	ld (xsp+48),xbc
	dec 2,xbc
	ld (xbc),wa
L4049:
	ld xwa,(xsp+48)
	cp xwa,(xsp+52)
	jr ult,L4047
L4048:
L4042:
	ld a,(_band_first__28)
	extz wa
	ld c,(_road_top__28)
	extz bc
	sub wa,bc
	ld (_band_shift__28),wa
	ld a,(_road_bottom__28)
	ld c,(_band_first__28)
	sub a,c
	add a,1
	ld (_band_count__28),a
	ld wa,(_band_col__28+6)
	ld (xsp+12),wa
	ld a,(_id_buf__28)
	ld (xsp+14),a
	ld xwa,_bc_rest__28
	ld c,(xsp+14)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,(xsp+12)
	jr z,L4050
	ld wa,(xsp+12)
	ld xbc,_bc_rest__28
	ld e,(xsp+14)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,0
	ld xbc,_bc_top__28
	ld e,(xsp+14)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(_id_bandcol__28)
	ld bc,152
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+16),xwa
	ld xwa,(_id_bandcol__28)
	ld bc,152
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+20),xwa
	jr L4053
L4051:
	ld wa,(xsp+12)
	ld xbc,(xsp+16)
	inc 2,xbc
	ld (xsp+16),xbc
	dec 2,xbc
	ld (xbc),wa
L4053:
	ld xwa,(xsp+16)
	cp xwa,(xsp+20)
	jr ult,L4051
L4052:
L4050:
	ld xwa,_bc_top__28
	ld c,(xsp+14)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_band_first__28)
	jr uge,L4054
	ld xwa,(_id_bandcol__28)
	ld xbc,_bc_top__28
	ld e,(xsp+14)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+16),xwa
	ld xwa,(_id_bandcol__28)
	ld c,(_band_first__28)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+20),xwa
	jr L4057
L4055:
	ld wa,(xsp+12)
	ld xbc,(xsp+16)
	inc 2,xbc
	ld (xsp+16),xbc
	dec 2,xbc
	ld (xbc),wa
L4057:
	ld xwa,(xsp+16)
	cp xwa,(xsp+20)
	jr ult,L4055
L4056:
L4054:
	ld a,(_band_first__28)
	ld xbc,_bc_top__28
	ld e,(xsp+14)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(_id_xy__28)
	ld c,(_road_bottom__28)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(_id_xy__28)
	ld (xbc+304),wa
	ld xwa,(_id_bandcol__28)
	ld c,(_road_bottom__28)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(_id_bandcol__28)
	ld (xbc+304),wa
	ld bc,(_band_shift__28)
	cp bc,0
	jr le,L4058
	ld wa,(_band_shift__28)
	jr L4059
L4058:
	ld wa,0
L4059:
	ld (xsp+10),wa
	ldw (xsp+8),0
	ld wa,(xsp+94)
	sra 2,wa
	neg wa
	ld (xsp+2),wa
	ld wa,(xsp+94)
	sra 1,wa
	neg wa
	ld (xsp+4),wa
	ld wa,(xsp+94)
	neg wa
	ld bc,(xsp+90)
	sra 3,bc
	add wa,bc
	ld (xsp+6),wa
	push xix
	push xiy
	call _uses_akina__28
	pop xiy
	pop xix
	cp a,0
	jp nz,L4060
	ld a,(_road_base_x__28)
	extz wa
	ld e,(_pan_fine__28)
	cp e,0
	jr z,L4061
	ld bc,(_pan_head__28)
	exts xbc
	divs xbc,2
	neg bc
	exts xbc
	divs xbc,16
	jr L4062
L4061:
	ld bc,(xsp+94)
	sra 1,bc
	neg bc
	ld de,(xsp+90)
	sra 4,de
	add bc,de
L4062:
	add wa,bc
	extz wa
	ld (xsp+12),wa
	ld a,(_road_base_x__28)
	extz wa
	ld e,(_pan_fine__28)
	cp e,0
	jr z,L4063
	ld bc,(_pan_head__28)
	sll 1,bc
	neg bc
	exts xbc
	divs xbc,16
	jr L4064
L4063:
	ld bc,(xsp+94)
	sll 1,bc
	neg bc
	ld de,(xsp+90)
	sra 2,de
	add bc,de
L4064:
	add wa,bc
	extz wa
	ld (xsp+14),wa
	ld c,(_band_first__28)
	cp c,244
	jr uge,L4065
	ld a,(_band_first__28)
	extz wa
	add wa,0
	jr L4066
L4065:
	ld a,(_band_first__28)
	extz wa
L4066:
	ld (xsp+16),a
	ld c,(xsp+16)
	cp c,40
	jr ule,L4067
	ld a,(xsp+16)
	extz wa
	jr L4068
L4067:
	ld a,40
	extz wa
L4068:
	ld (xsp+17),a
	ld c,(_band_first__28)
	cp c,(xsp+17)
	jr uge,L4069
	ld a,(_band_first__28)
	extz wa
	jr L4070
L4069:
	ld a,(xsp+17)
	extz wa
L4070:
	ld (xsp+18),a
	ld a,(xsp+18)
	extz wa
	ld (xsp+20),wa
	ld wa,(xsp+12)
	ld xbc,_band_top__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L4072
	ld wa,(xsp+14)
	ld xbc,_band_mid__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L4072
	ld a,(xsp+17)
	ld xbc,_band_bg_end__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr nz,L4072
	ld wa,(xsp+10)
	ld xbc,_band_pitch__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	exts bc
	cp wa,bc
	jr nz,L4072
	ld a,(_band_first__28)
	ld xbc,_band_bg_first__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr z,L4071
L4072:
	ld wa,(xsp+12)
	ld xbc,_band_top__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+14)
	ld xbc,_band_mid__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+17)
	ld xbc,_band_bg_end__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(_band_first__28)
	ld xbc,_band_bg_first__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ldw (xsp+20),0
L4071:
	push xix
	push xiy
	call _sky_is_tall_course__28
	pop xiy
	pop xix
	ld (xsp+22),a
	ld xwa,(_id_xy__28)
	ld bc,(xsp+20)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld xix,xwa
	ld xwa,(_id_xy__28)
	ld c,(xsp+17)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+28),xwa
	ld a,(xsp+22)
	cp a,0
	jr z,L4073
	jr L4076
L4074:
	ld wa,(xsp+14)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L4076:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr ult,L4074
L4075:
	jp L4077
L4073:
	ld a,(xsp+10)
	neg a
	extz wa
	sll 8,wa
	ld (xsp+36),wa
	ld wa,(xsp+20)
	ld iy,wa
	jr L4080
L4078:
	ld bc,iy
	cp bc,40
	jr uge,L4081
	ld wa,(xsp+12)
	jr L4082
L4081:
	ld wa,(xsp+14)
L4082:
	ld c,iyl
	neg c
	extz bc
	sll 8,bc
	or wa,bc
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
	inc 1,iy
L4080:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr uge,L4083
	ld wa,iy
	cp wa,(xsp+10)
	jr lt,L4078
L4083:
L4079:
	ld xwa,(_id_xy__28)
	ld bc,40
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+32),xwa
	ld xwa,(xsp+32)
	cp xwa,(xsp+28)
	jr ule,L4084
	ld xwa,(xsp+28)
	ld (xsp+32),xwa
L4084:
	jr L4087
L4085:
	ld wa,(xsp+12)
	or wa,(xsp+36)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L4087:
	ld xwa,xix
	cp xwa,(xsp+32)
	jr ult,L4085
L4086:
	jr L4090
L4088:
	ld wa,(xsp+14)
	or wa,(xsp+36)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L4090:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr ult,L4088
L4089:
L4077:
	ld a,(xsp+10)
	ld xbc,_band_pitch__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+14)
	ld (xsp+8),wa
	jp L4091
L4060:
	ld a,(_road_base_x__28)
	add a,(xsp+2)
	extz wa
	ld (xsp+12),wa
	ld a,(_road_base_x__28)
	add a,(xsp+4)
	extz wa
	ld (xsp+14),wa
	ld a,(_road_base_x__28)
	add a,(xsp+6)
	extz wa
	ld (xsp+16),wa
	ld wa,(xsp+16)
	ld xbc,_band_tree__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L4093
	ld wa,(xsp+10)
	ld xbc,_band_pitch__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	exts bc
	cp wa,bc
	jr nz,L4093
	ld a,(_band_first__28)
	ld xbc,_band_bg_end__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp z,L4092
L4093:
	ld a,(xsp+10)
	ld xbc,_band_pitch__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(_band_first__28)
	ld xbc,_band_bg_end__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+16)
	ld xbc,_band_mid__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+16)
	ld xbc,_band_tree__28
	ld e,(_id_buf__28)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld iy,0
	jr L4097
L4094:
	push xwa
	push xix
	push xiy
	call _sky_is_tall_course__28
	ld xbc,xwa
	pop xiy
	pop xix
	pop xwa
	cp c,0
	jr z,L4098
	ld wa,0
	jr L4099
L4098:
	ld wa,(xsp+10)
	neg wa
L4099:
	ld (xsp+18),wa
	ld wa,iy
	add wa,(xsp+18)
	cp wa,0
	jr ge,L4100
	ld wa,iy
	neg wa
	ld (xsp+18),wa
L4100:
	ld wa,(xsp+16)
	ld c,(xsp+18)
	extz bc
	sll 8,bc
	or wa,bc
	ld xbc,(_id_xy__28)
	ld de,iy
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4096:
	inc 1,iy
L4097:
	ld wa,iy
	ld c,(_band_first__28)
	extz bc
	cp wa,bc
	jr ult,L4094
L4095:
L4092:
	ld wa,(xsp+16)
	ld (xsp+8),wa
L4091:
L4002:
	lda xsp,(xsp+82)
	pop xiz
	ret

; function id_road_ready
_id_road_ready:
	ld xwa,(_id_xy__28)
	ld (_id_xy_done__28),xwa
	ld xwa,(_id_bandcol__28)
	ld (_id_bandcol_done__28),xwa
L4102:
	ret

; function id_road_pan
_id_road_pan:
	ld wa,(xsp+4)
	ld (_pan_head__28),wa
	ld wa,(xsp+8)
	ld (_pan_lat__28),wa
	ldb (_pan_fine__28),1
L4104:
	ret

; function id_road_begin
_id_road_begin:
	ld xwa,(_id_xy_live__28)
	cp xwa,_id_xy_a__28
	jr nz,L4111
	ld xwa,_id_xy_b__28
	ld (_id_xy__28),xwa
	ld xwa,_id_bandcol_b__28
	ld (_id_bandcol__28),xwa
	jr L4112
L4111:
	ld xwa,_id_xy_a__28
	ld (_id_xy__28),xwa
	ld xwa,_id_bandcol_a__28
	ld (_id_bandcol__28),xwa
L4112:
	ld xbc,(_id_xy__28)
	cp xbc,_id_xy_a__28
	jr nz,L4113
	ld wa,0
	jr L4114
L4113:
	ld wa,1
L4114:
	ld (_id_buf__28),a
L4110:
	ret

; function id_road_frame
_id_road_frame:
	push xiz
	lda xsp,(xsp-2)
	ld ix,(xsp+14)
	push xix
	call _id_road_begin
	pop xix
	ld izl,0
	jr L4124
L4121:
	ld wa,ix
	ld xbc,_id_w_curve__28
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	mul xwa,bc
	sra 8,wa
	ld xbc,_id_curve_dx__28
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4123:
	inc 1,izl
L4124:
	ld a,izl
	cp a,(_road_lines__28)
	jr ult,L4121
L4122:
	push xix
	ld wa,(xsp+22)
	push xwa
	ld wa,(xsp+18)
	push xwa
	call _id_road_write__28
	lda xsp,(xsp+8)
	pop xix
	push xix
	call _id_road_ready
	pop xix
L4120:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_ahead
_id_road_ahead:
	ld xwa,_id_ahead__28
	jr L4126
L4126:
	ret

; function id_road_lines
_id_road_lines:
	ld a,(_road_lines__28)
	jr L4128
L4128:
	ret

; function id_road_frame_ahead
_id_road_frame_ahead:
	push xiz
	lda xsp,(xsp-18)
	ld a,(_road_lines__28)
	ld izl,a
	ld wa,0
	ld (xsp+2),wa
	ld wa,0
	ld (xsp+4),wa
	call _id_road_begin
	ld a,izl
	cp a,0
	jr z,L4132
	ld xwa,(xsp+30)
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+6),xwa
	ld xwa,_id_curve_dx__28
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+10),xwa
	ld wa,(_id_curve_cm__28)
	ld (xsp+14),wa
	ld a,izl
	extz wa
	ld (xsp+16),wa
	lda xwa,(xsp+6)
	push xwa
	call _id_road_curve_asm
	lda xsp,(xsp+4)
L4132:
	ld wa,(xsp+34)
	push xwa
	ld wa,(xsp+30)
	push xwa
	call _id_road_write__28
	lda xsp,(xsp+8)
	call _id_road_ready
L4131:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_fill_hud_band
_id_fill_hud_band__28:
	push xiz
	lda xsp,(xsp-2)
	ld iz,152
	jr L4142
L4139:
	ld wa,2048
	ld c,(_road_base_x__28)
	extz bc
	or wa,bc
	ld xbc,_id_xy_a__28
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_id_xy_a__28
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_id_xy_b__28
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4141:
	inc 1,iz
L4142:
	ld wa,iz
	cp wa,152
	jr ult,L4139
L4140:
L4138:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_sprite_sample
_id_road_sprite_sample:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld izl,a
	ld xiy,(xsp+14)
	ld a,izl
	cp a,(_road_top__28)
	jr uge,L4148
	ld a,(_road_top__28)
	ld izl,a
	jr L4149
L4148:
	ld a,izl
	cp a,(_road_bottom__28)
	jr ule,L4150
	ld a,(_road_bottom__28)
	ld izl,a
L4150:
L4149:
	ld a,izl
	sub a,(_road_top__28)
	ld ixl,a
	ld wa,80
	ld xbc,_id_shear__28
	ld e,ixl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	sub wa,bc
	ld (xiy),wa
	ld a,izl
	extz wa
	ld xbc,_id_sl__28
	ld e,ixl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	ld e,izl
	sub c,e
	exts bc
	add wa,bc
	ld (xiy+2),wa
	ld xwa,_id_half__28
	ld c,ixl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xiy+4),a
L4147:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_centre_at
_id_road_centre_at:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld izl,a
	ld a,izl
	cp a,(_road_top__28)
	jr uge,L4156
	ld a,(_road_top__28)
	ld izl,a
	jr L4157
L4156:
	ld a,izl
	cp a,(_road_bottom__28)
	jr ule,L4158
	ld a,(_road_bottom__28)
	ld izl,a
L4158:
L4157:
	ld a,izl
	sub a,(_road_top__28)
	ld (xsp+0),a
	ld wa,80
	ld xbc,_id_shear__28
	ld e,(xsp+0)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	sub wa,bc
	jr L4155
L4155:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_band_phase
_id_road_band_phase:
	ld wa,(xsp+4)
	ld (_band_phase__28),wa
L4160:
	ret

; function id_road_join
_id_road_join:
	ld c,(xsp+4)
	cp c,1
	jr uge,L4165
	ld a,(xsp+4)
	extz wa
	jr L4166
L4165:
	ld wa,0
L4166:
	ld (_road_course__28),a
	call _id_load_palettes__28
	ld wa,0
	push xwa
	call _id_road_join_white
	lda xsp,(xsp+4)
L4164:
	ret

; function id_road_join_white
_id_road_join_white:
	push xiz
	lda xsp,(xsp-10)
	ld izl,0
	jp L4176
L4173:
	ld xwa,_course_sol__28
	ld c,(_road_course__28)
	extz bc
	muls xbc,18
	add xwa,xbc
	lda xwa,(xwa+10)
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+2),wa
	ld wa,(xsp+2)
	srl 8,wa
	and wa,15
	ld (xsp+4),wa
	ld wa,(xsp+2)
	srl 4,wa
	and wa,15
	ld iy,wa
	ld wa,(xsp+2)
	and wa,15
	ld ix,wa
	ld wa,(xsp+4)
	ld bc,15
	sub bc,(xsp+4)
	ld e,(xsp+18)
	extz de
	mul xbc,de
	add bc,7
	extz xbc
	div xbc,15
	add wa,bc
	ld (xsp+4),wa
	ld wa,iy
	ld bc,15
	sub bc,iy
	ld e,(xsp+18)
	extz de
	mul xbc,de
	add bc,7
	extz xbc
	div xbc,15
	add wa,bc
	ld iy,wa
	ld wa,ix
	ld bc,15
	sub bc,ix
	ld e,(xsp+18)
	extz de
	mul xbc,de
	add bc,7
	extz xbc
	div xbc,15
	add wa,bc
	ld ix,wa
	ld wa,(xsp+4)
	sll 8,wa
	ld bc,iy
	sll 4,bc
	or wa,bc
	or wa,ix
	ld xbc,_band_col__28
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4175:
	inc 1,izl
L4176:
	ld a,izl
	cp a,4
	jp ult,L4173
L4174:
	ld wa,65535
	ld (_band_top__28+2),wa
	ld (_band_top__28),wa
	ld wa,65535
	ld (_band_mid__28+2),wa
	ld (_band_mid__28),wa
	ld wa,65535
	ld (_band_tree__28+2),wa
	ld (_band_tree__28),wa
L4172:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function id_road_hill_ahead
_id_road_hill_ahead:
	push xiz
	lda xsp,(xsp-12)
	ld xwa,(xsp+20)
	ld (xsp+0),xwa
	ld xwa,_id_sl__28+64
	ld xiy,xwa
	ld a,(_grade_hi__28)
	ld (xsp+8),a
	ld a,(_grade_lo__28)
	ld (xsp+9),a
	ld a,(_road_lines__28)
	ld ixl,a
	ld xwa,(xsp+0)
	cp xwa,xiy
	jr nz,L4186
	ld ixl,0
L4186:
	jr L4189
L4187:
	ld xwa,(xsp+0)
	inc 1,xwa
	ld (xsp+0),xwa
	dec 1,xwa
	ld a,(xwa)
	ld izl,a
	ld a,izl
	cp a,(xsp+8)
	jr le,L4190
	ld a,(xsp+8)
	ld izl,a
	jr L4191
L4190:
	ld a,izl
	cp a,(xsp+9)
	jr ge,L4192
	ld a,(xsp+9)
	ld izl,a
L4192:
L4191:
	ld a,izl
	ld xbc,xiy
	inc 1,xbc
	ld xiy,xbc
	dec 1,xbc
	ld (xbc),a
	dec 1,ixl
L4189:
	ld a,ixl
	cp a,0
	jr nz,L4187
L4188:
	ld xwa,_id_sl__28+64
	ld c,(_road_lines__28)
	extz bc
	sub bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_road_grade__28),a
L4185:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function id_road_grade_buf
_id_road_grade_buf:
	ld xwa,_id_sl__28+64
	jr L4194
L4194:
	ret

; function id_road_band_first
_id_road_band_first:
	ld a,(_band_first__28)
	jr L4196
L4196:
	ret

; function id_road_visible_top
_id_road_visible_top:
	push xiz
	lda xsp,(xsp-2)
	ld c,(_band_first__28)
	cp c,244
	jr uge,L4204
	ld a,(_band_first__28)
	add a,0
	extz wa
	jr L4205
L4204:
	ld a,(_band_first__28)
	extz wa
L4205:
	ld izl,a
	ld a,izl
	cp a,40
	jr uge,L4206
	ld izl,40
L4206:
	ld c,izl
	cp c,(_road_bottom__28)
	jr ule,L4207
	ld a,(_road_bottom__28)
	extz wa
	jr L4208
L4207:
	ld a,izl
	extz wa
L4208:
	jr L4203
L4203:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_grade_hi
_id_road_grade_hi:
	ld a,(_grade_hi__28)
	jr L4210
L4210:
	ret

; function id_road_grade_lo
_id_road_grade_lo:
	ld a,(_grade_lo__28)
	jr L4212
L4212:
	ret

; function id_road_set_hill
_id_road_set_hill:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld ixl,a
	ld a,ixl
	cp a,(_grade_hi__28)
	jr le,L4222
	ld a,(_grade_hi__28)
	ld ixl,a
	jr L4223
L4222:
	ld a,ixl
	cp a,(_grade_lo__28)
	jr ge,L4224
	ld a,(_grade_lo__28)
	ld ixl,a
L4224:
L4223:
	ld a,ixl
	ld (_road_grade__28),a
	ld izl,0
	jr L4228
L4225:
	ld a,ixl
	ld xbc,_id_sl__28+64
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L4227:
	inc 1,izl
L4228:
	ld a,izl
	cp a,(_road_lines__28)
	jr ult,L4225
L4226:
L4221:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_line_shift
_id_road_line_shift:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	ld ixl,a
	ld a,ixl
	cp a,(_road_top__28)
	jr ult,L4235
	ld a,ixl
	cp a,(_road_bottom__28)
	jr ule,L4234
L4235:
	ld wa,0
	jr L4233
L4234:
	ld a,ixl
	extz wa
	ld c,(_road_top__28)
	extz bc
	sub wa,bc
	ld iz,wa
	ld wa,iz
	ld c,(_road_lines__28)
	extz bc
	cp wa,bc
	jr lt,L4236
	ld a,(_road_lines__28)
	extz wa
	sub wa,1
	ld iz,wa
L4236:
	ld xwa,_id_sl__28
	ld bc,iz
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	ld iy,wa
	ld a,iyl
	ld c,ixl
	sub a,c
	jr L4233
L4233:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function id_road_car_lift
_id_road_car_lift:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_road_bottom__28)
	sub a,(_car_stand__28)
	push xwa
	call _id_road_line_shift
	lda xsp,(xsp+4)
	exts wa
	neg wa
	ld iz,wa
	ld wa,iz
	cp wa,8
	jr le,L4242
	ld iz,8
	jr L4243
L4242:
	ld wa,iz
	cp wa,65531
	jr ge,L4244
	ld iz,65531
L4244:
L4243:
	ld a,izl
	jr L4241
L4241:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_half_at
_id_road_half_at:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,(_road_top__28)
	jr uge,L4250
	ld a,(_road_top__28)
	ld izl,a
	jr L4251
L4250:
	ld a,izl
	cp a,(_road_bottom__28)
	jr ule,L4252
	ld a,(_road_bottom__28)
	ld izl,a
L4252:
L4251:
	ld xwa,_id_half__28
	ld c,izl
	sub c,(_road_top__28)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	jr L4249
L4249:
	pop xiz
	ret

; function id_road_line_at_distance
_id_road_line_at_distance:
	push xiz
	lda xsp,(xsp-4)
	ld wa,0
	ld izl,a
	ld a,(_road_lines__28)
	sub a,1
	ld iyl,a
	ld wa,(xsp+12)
	cp wa,(_id_ahead__28)
	jr ule,L4261
	ld wa,255
	jr L4260
L4261:
	jr L4264
L4262:
	ld a,izl
	extz wa
	ld c,iyl
	extz bc
	add wa,bc
	add wa,1
	srl 1,wa
	ld ixl,a
	ld xwa,_id_ahead__28
	ld c,ixl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,(xsp+12)
	jr ult,L4265
	ld a,ixl
	ld izl,a
	jr L4266
L4265:
	ld a,ixl
	sub a,1
	ld iyl,a
L4266:
L4264:
	ld a,izl
	cp a,iyl
	jr ult,L4262
L4263:
	ld a,(_road_top__28)
	add a,izl
	jr L4260
L4260:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function id_road_distance_at_line
_id_road_distance_at_line:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,(_road_top__28)
	jr uge,L4272
	ld a,(_road_top__28)
	ld izl,a
	jr L4273
L4272:
	ld a,izl
	cp a,(_road_bottom__28)
	jr ule,L4274
	ld a,(_road_bottom__28)
	ld izl,a
L4274:
L4273:
	ld xwa,_id_ahead__28
	ld c,izl
	sub c,(_road_top__28)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L4271
L4271:
	pop xiz
	ret

; function id_scenery_char_count
_id_scenery_char_count:
	ld wa,0
	jr L4276
L4276:
	ret

; function id_scenery_init
_id_scenery_init:
	ldb (_scn_phase__29),0
	ldw (_scn_frac__29),0
	ldb (_scn_passed__29),0
	ldb (_scn_mode__29),0
	ld a,64
	push xwa
	ld a,50
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L4278:
	ret

; function scenery_mode
_scenery_mode:
	ld a,(xsp+4)
	ld (_scn_mode__29),a
L4280:
	ret

; function id_scenery_passed
_id_scenery_passed:
	ld a,(_scn_passed__29)
	jr L4282
L4282:
	ret

; function kind_of
_kind_of__29:
	ld a,(_scn_mode__29)
	cp a,5
	jr nz,L4291
	ld wa,14
	jr L4290
L4291:
	ld a,(_scn_mode__29)
	cp a,1
	jr nz,L4292
	ld wa,12
	jr L4290
L4292:
	ld a,(_scn_mode__29)
	cp a,3
	jr ult,L4293
	ld wa,11
	jr L4290
L4293:
	ld a,(_scn_mode__29)
	cp a,2
	jr nz,L4294
	ld wa,13
	jr L4290
L4294:
	ld c,(xsp+4)
	cp c,0
	jr z,L4295
	call _theme_obj_kind_right
	extz wa
	jr L4296
L4295:
	call _theme_obj_kind_left
	extz wa
L4296:
	jr L4290
L4290:
	ret

; function id_scenery_hit
_id_scenery_hit:
	push xiz
	lda xsp,(xsp-16)
	ld iy,(xsp+24)
	push xix
	push xiy
	ld a,(xsp+36)
	push xwa
	call _id_road_half_at
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	extz wa
	ld (xsp+2),wa
	ld wa,(xsp+2)
	ld bc,1
	ld e,(xsp+2)
	extz de
	extz xde
	div xde,9
	extz de
	add bc,de
	extz bc
	add wa,bc
	ld (xsp+4),wa
	ld izl,0
	jp L4313
L4310:
	ld a,(_scn_passed__29)
	extz wa
	ld bc,1
	ld e,izl
	cp e,0
	jr z,L4316
L4315:
	sll 1,bc
	djnz e,L4315
L4316:
	extz bc
	and wa,bc
	cp wa,0
	jr nz,L4314
	jp L4312
L4314:
	ld xwa,_gfx_obj_frames
	push xwa
	push xix
	push xiy
	ld a,izl
	push xwa
	call _kind_of__29
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xiy
	pop xix
	pop xwa
	extz bc
	mul xbc,5
	extz bc
	exts xbc
	sll 3,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+6),xwa
	ld xwa,(xsp+6)
	ld a,(xwa+6)
	extz wa
	ld ix,wa
	ld wa,(xsp+4)
	ld bc,ix
	sra 2,bc
	add wa,bc
	ld (xsp+12),wa
	ld wa,(xsp+4)
	add wa,ix
	ld bc,ix
	sra 2,bc
	sub wa,bc
	ld (xsp+14),wa
	ld a,izl
	cp a,0
	jr nz,L4317
	ld wa,iy
	neg wa
	add wa,12
	cp wa,(xsp+12)
	jr lt,L4318
	ld wa,iy
	neg wa
	sub wa,12
	cp wa,(xsp+14)
	jr gt,L4318
	ld wa,1
	jr L4309
L4318:
	jr L4319
L4317:
	ld wa,iy
	add wa,12
	cp wa,(xsp+12)
	jr lt,L4320
	ld wa,iy
	sub wa,12
	cp wa,(xsp+14)
	jr gt,L4320
	ld wa,1
	jr L4309
L4320:
L4319:
L4312:
	inc 1,izl
L4313:
	ld a,izl
	cp a,2
	jp ult,L4310
L4311:
	ld wa,0
	jr L4309
L4309:
	lda xsp,(xsp+16)
	pop xiz
	ret

; function obj_phase
_obj_phase__29:
	ld a,(_scn_phase__29)
	extz wa
	ld c,(xsp+4)
	extz bc
	mul xbc,43
	extz bc
	add wa,bc
	jr L4322
L4322:
	ret

; function id_scenery_advance
_id_scenery_advance:
	push xiz
	lda xsp,(xsp-6)
	ld wa,(_scn_frac__29)
	ld c,(xsp+14)
	extz bc
	mul xbc,158
	add wa,bc
	ld (xsp+0),wa
	ld wa,(xsp+0)
	and wa,2047
	ld (_scn_frac__29),wa
	ld wa,(xsp+0)
	srl 11,wa
	ld (xsp+0),wa
	ld a,(_scn_phase__29)
	ld iyl,a
	ld a,(_scn_phase__29)
	ld c,(xsp+0)
	add a,c
	ld (_scn_phase__29),a
	ldb (_scn_passed__29),0
	ld izl,0
	jr L4335
L4332:
	ld a,izl
	extz wa
	mul xwa,43
	ld ixl,a
	ld a,(_scn_phase__29)
	add a,ixl
	ld c,iyl
	add c,ixl
	cp a,c
	jr uge,L4336
	ld a,(_scn_passed__29)
	extz wa
	ld e,izl
	extz de
	and de,1
	cp de,0
	jr z,L4337
	ld bc,2
	jr L4338
L4337:
	ld bc,1
L4338:
	extz bc
	or wa,bc
	ld (_scn_passed__29),a
L4336:
L4334:
	inc 1,izl
L4335:
	ld a,izl
	cp a,6
	jr ult,L4332
L4333:
L4331:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function id_scenery_frame
_id_scenery_frame:
	ld a,(xsp+4)
	push xwa
	call _id_scenery_advance
	lda xsp,(xsp+4)
	call _id_scenery_draw
L4340:
	ret

; function id_scenery_draw
_id_scenery_draw:
	push xiz
	lda xsp,(xsp-60)
	ld wa,50
	ld (xsp+2),a
	push xwa
	call _banner_active
	ld xbc,xwa
	pop xwa
	cp c,0
	jr z,L4390
	ld wa,58
	jr L4391
L4390:
	ld wa,64
L4391:
	ld (xsp+3),a
	call _id_road_top
	ld (xsp+4),a
	call _id_road_bottom
	extz wa
	ld (xsp+6),wa
	call _id_road_visible_top
	extz wa
	ld (xsp+8),wa
	ld wa,(xsp+6)
	ld c,(xsp+4)
	extz bc
	sub wa,bc
	ld (xsp+10),wa
	ldb (xsp+1),0
	ldb (xsp+0),1
	jr L4395
L4392:
	ld a,(xsp+0)
	push xwa
	call _obj_phase__29
	lda xsp,(xsp+4)
	push xwa
	ld a,(xsp+5)
	push xwa
	call _obj_phase__29
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp a,c
	jr ule,L4396
	ld a,(xsp+0)
	ld (xsp+1),a
L4396:
L4394:
	incb 1,(xsp+0)
L4395:
	ld a,(xsp+0)
	cp a,6
	jr ult,L4392
L4393:
	ldb (xsp+0),0
	jp L4400
L4397:
	ld a,(xsp+1)
	extz wa
	add wa,6
	ld c,(xsp+0)
	extz bc
	sub wa,bc
	extz xwa
	div xwa,6
	ld wa,qwa
	ld (xsp+12),a
	ld a,(xsp+12)
	push xwa
	call _obj_phase__29
	lda xsp,(xsp+4)
	ld (xsp+13),a
	ld a,(xsp+13)
	extz wa
	ld c,(xsp+13)
	extz bc
	mul xwa,bc
	srl 8,wa
	ld (xsp+22),wa
	ld wa,2
	ld bc,(xsp+22)
	ld de,(xsp+10)
	sub de,2
	mul xbc,de
	srl 8,bc
	add wa,bc
	ld iz,wa
	ld wa,iz
	cp wa,(xsp+10)
	jr ule,L4401
	ld wa,(xsp+10)
	ld iz,wa
L4401:
	ld a,(xsp+4)
	add a,izl
	ld (xsp+18),a
	ld wa,iz
	cp wa,6
	jr uge,L4402
	ldb (xsp+17),4
	jr L4403
L4402:
	ld wa,iz
	cp wa,10
	jr uge,L4404
	ldb (xsp+17),3
	jr L4405
L4404:
	ld wa,iz
	cp wa,15
	jr uge,L4406
	ldb (xsp+17),2
	jr L4407
L4406:
	ld wa,iz
	cp wa,22
	jr uge,L4408
	ldb (xsp+17),1
	jr L4409
L4408:
	ldb (xsp+17),0
L4409:
L4407:
L4405:
L4403:
	ld c,(xsp+12)
	extz bc
	and bc,1
	cp bc,0
	jr z,L4410
	ld wa,1
	jr L4411
L4410:
	ld wa,0
L4411:
	ld (xsp+14),a
	ld a,(_scn_mode__29)
	cp a,5
	jr nz,L4412
	ldb (xsp+15),14
	ldb (xsp+16),6
	jr L4413
L4412:
	ld a,(_scn_mode__29)
	cp a,1
	jr nz,L4414
	ldb (xsp+15),12
	ldb (xsp+16),4
	jr L4415
L4414:
	ld a,(_scn_mode__29)
	cp a,3
	jr ult,L4416
	ldb (xsp+15),11
	ldb (xsp+16),9
	jr L4417
L4416:
	ld a,(_scn_mode__29)
	cp a,2
	jr nz,L4418
	ldb (xsp+15),13
	ldb (xsp+16),10
	jr L4419
L4418:
	ld a,(xsp+14)
	cp a,0
	jr z,L4420
	call _theme_obj_kind_right
	ld (xsp+15),a
	ldb (xsp+16),2
	jr L4421
L4420:
	call _theme_obj_kind_left
	ld (xsp+15),a
	ldb (xsp+16),1
L4421:
L4419:
L4417:
L4415:
L4413:
	ld c,(xsp+14)
	cp c,0
	jr z,L4422
	ld c,(xsp+15)
	cp c,11
	jr ult,L4422
	ld wa,1
	jr L4423
L4422:
	ld wa,0
L4423:
	ld (xsp+20),a
	ld a,(_scn_mode__29)
	cp a,5
	jr nz,L4424
	ld a,(_g_vb_counter)
	extz wa
	sra 3,wa
	ld c,(xsp+12)
	extz bc
	add wa,bc
	and wa,1
	ld (xsp+20),a
	jr L4425
L4424:
	ld a,(_scn_mode__29)
	cp a,3
	jr nz,L4426
	ldb (xsp+20),0
	jr L4427
L4426:
	ld a,(_scn_mode__29)
	cp a,4
	jr nz,L4428
	ldb (xsp+20),1
L4428:
L4427:
L4425:
	ld xwa,_gfx_obj_frames
	ld c,(xsp+15)
	extz bc
	mul xbc,5
	ld e,(xsp+17)
	extz de
	add bc,de
	extz bc
	exts xbc
	sll 3,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+34),xwa
	lda xwa,(xsp+28)
	push xwa
	ld a,(xsp+22)
	push xwa
	call _id_road_sprite_sample
	lda xsp,(xsp+8)
	ld wa,(xsp+30)
	ld (xsp+38),wa
	ld wa,(xsp+38)
	cp wa,(xsp+8)
	jr ge,L4429
	jp L4399
L4429:
	ld wa,(xsp+38)
	cp wa,(xsp+6)
	jr le,L4430
	ld wa,(xsp+6)
	ld (xsp+38),wa
L4430:
	ld a,(xsp+38)
	ld (xsp+19),a
	ld a,(xsp+32)
	ld (xsp+38),a
	ld wa,(xsp+28)
	ld (xsp+40),wa
	ld a,(xsp+38)
	extz wa
	ld bc,1
	ld e,(xsp+38)
	extz de
	extz xde
	div xde,9
	extz de
	add bc,de
	extz bc
	add wa,bc
	ld (xsp+42),wa
	ld a,(xsp+14)
	cp a,0
	jr z,L4431
	ld wa,(xsp+40)
	add wa,(xsp+42)
	ld (xsp+26),wa
	jr L4432
L4431:
	ld wa,(xsp+40)
	sub wa,(xsp+42)
	ld xbc,(xsp+34)
	ld c,(xbc+6)
	extz bc
	sub wa,bc
	add wa,1
	ld (xsp+26),wa
L4432:
	ld wa,(xsp+26)
	cp wa,65504
	jr lt,L4434
	ld wa,(xsp+26)
	cp wa,168
	jr le,L4433
L4434:
	jp L4399
L4433:
	ld xwa,_gfx_obj_cells
	ld xbc,(xsp+34)
	ld bc,(xbc+4)
	mul xbc,3
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+38),xwa
	call _theme_obj_map
	ld (xsp+42),xwa
	ldw (xsp+46),0
	ld wa,(xsp+26)
	ld (xsp+48),wa
	ld a,(xsp+19)
	extz wa
	add wa,1
	ld xbc,(xsp+34)
	ld c,(xbc+1)
	extz bc
	sll 3,bc
	sub wa,bc
	ld (xsp+50),a
	ld xwa,(xsp+34)
	ld a,(xwa+2)
	ld (xsp+51),a
	ld xwa,(xsp+34)
	ld a,(xwa)
	sub a,1
	ld (xsp+52),a
	ld c,(xsp+20)
	cp c,0
	jr z,L4435
	ld wa,128
	jr L4436
L4435:
	ld wa,0
L4436:
	ld c,(_id_spr_priority)
	extz bc
	or wa,bc
	ld (xsp+53),a
	ld a,(xsp+16)
	ld (xsp+54),a
	ld a,(xsp+2)
	ld (xsp+55),a
	ld a,(xsp+3)
	ld (xsp+56),a
	ld a,(xsp+20)
	ld (xsp+57),a
	ldb (xsp+58),1
	lda xwa,(xsp+38)
	push xwa
	call _spr_cells_asm
	lda xsp,(xsp+4)
	ld a,(xsp+55)
	ld (xsp+2),a
L4399:
	incb 1,(xsp+0)
L4400:
	ld a,(xsp+0)
	cp a,6
	jp ult,L4397
L4398:
	ld a,(xsp+3)
	push xwa
	ld a,(xsp+6)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L4389:
	lda xsp,(xsp+60)
	pop xiz
	ret

; function theme_init_tiles
_theme_init_tiles:
	ld wa,(xsp+4)
	ld (_pano_base__30),wa
	ld wa,(xsp+8)
	ld (_obj_base__30),wa
	ld wa,(xsp+12)
	ld (_obj_end__30),wa
L4438:
	ret

; function theme_obj_map
_theme_obj_map:
	ld xwa,_objmap__30
	jr L4440
L4440:
	ret

; function theme_obj_tile
_theme_obj_tile:
	ld xwa,_objmap__30
	ld c,(xsp+4)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L4442
L4442:
	ret

; function theme_obj_kind_left
_theme_obj_kind_left:
	ld a,(_kind_l__30)
	jr L4444
L4444:
	ret

; function theme_obj_kind_right
_theme_obj_kind_right:
	ld a,(_kind_r__30)
	jr L4446
L4446:
	ret

; function load_tile
_load_tile__30:
	push xiz
	lda xsp,(xsp-6)
	ld xiy,(xsp+18)
	ld wa,40960
	extz xwa
	ld bc,(xsp+14)
	mul xbc,16
	add xwa,xbc
	ld xix,xwa
	ld izl,0
	jr L4456
L4453:
	ld xwa,xiy
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,xix
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4455:
	inc 1,izl
L4456:
	ld a,izl
	cp a,8
	jr ult,L4453
L4454:
L4452:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function alloc_slot
_alloc_slot__30:
	push xiz
	lda xsp,(xsp-4)
	ld wa,(_next_slot__30)
	ld iz,wa
	ld wa,(_pano_base__30)
	add wa,114
	ld (xsp+2),wa
	ld wa,iz
	cp wa,32
	jr ult,L4464
	ld wa,iz
	cp wa,101
	jr uge,L4464
	ld iz,101
	jr L4465
L4464:
	ld wa,iz
	cp wa,125
	jr ult,L4466
	ld wa,iz
	cp wa,(_pano_base__30)
	jr uge,L4466
	ld wa,(_obj_base__30)
	ld iz,wa
L4466:
L4465:
	ld wa,iz
	cp wa,(_obj_end__30)
	jr ult,L4467
	ld wa,(_pano_end__30)
	ld iz,wa
L4467:
	ld wa,iz
	cp wa,(xsp+2)
	jr ult,L4468
	ld wa,iz
	cp wa,(_obj_base__30)
	jr uge,L4468
	ld wa,0
	jr L4463
L4468:
	ld wa,iz
	add wa,1
	ld (_next_slot__30),wa
	ld wa,iz
	jr L4463
L4463:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function load_kind
_load_kind__30:
	push xiz
	lda xsp,(xsp-10)
	ldb (xsp+0),0
	jp L4484
L4481:
	ld xwa,_gfx_obj_frames
	ld c,(xsp+18)
	extz bc
	mul xbc,5
	ld e,(xsp+0)
	extz de
	add bc,de
	extz bc
	exts xbc
	sll 3,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+2),xwa
	ld izl,0
	jp L4488
L4485:
	ld xwa,_gfx_obj_cells
	ld xbc,(xsp+2)
	ld bc,(xbc+4)
	ld e,izl
	extz de
	add bc,de
	mul xbc,3
	add xwa,xbc
	ld a,(xwa+2)
	ld (xsp+7),a
	ld xwa,_objmap__30
	ld c,(xsp+7)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65535
	jr nz,L4489
	call _alloc_slot__30
	ld (xsp+8),wa
	ld wa,(xsp+8)
	ld xbc,_objmap__30
	ld e,(xsp+7)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+8)
	cp wa,0
	jr z,L4490
	ld xwa,_gfx_obj_tiles
	ld c,(xsp+7)
	extz bc
	sll 3,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	push xwa
	ld wa,(xsp+12)
	push xwa
	call _load_tile__30
	lda xsp,(xsp+8)
L4490:
L4489:
L4487:
	inc 1,izl
L4488:
	ld a,izl
	ld xbc,(xsp+2)
	ld c,(xbc+2)
	cp a,c
	jp ult,L4485
L4486:
L4483:
	incb 1,(xsp+0)
L4484:
	ld a,(xsp+0)
	cp a,5
	jp ult,L4481
L4482:
L4480:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function set_spr_pal
_set_spr_pal__30:
	push xiz
	lda xsp,(xsp-6)
	ld a,(xsp+22)
	ld iyl,a
	ld xwa,_gfx_obj_pals
	ld c,(xsp+18)
	extz bc
	sll 2,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld xix,xwa
	ld izl,0
	jr L4500
L4497:
	ld xwa,xix
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_cur_spr__30
	ld e,iyl
	extz de
	exts xde
	sll 3,xde
	add xbc,xde
	lda xbc,(xbc)
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4499:
	inc 1,izl
L4500:
	ld a,izl
	cp a,4
	jr ult,L4497
L4498:
	push xix
	push xiy
	ld wa,(xix+6)
	push xwa
	ld wa,(xix+4)
	push xwa
	ld wa,(xix+2)
	push xwa
	ld wa,(xix)
	push xwa
	ld a,(xsp+38)
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xiy
	pop xix
L4496:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function theme_apply
_theme_apply:
	push xiz
	lda xsp,(xsp-14)
	ld xwa,_gfx_themes
	ld xbc,_leg_theme
	ld e,(xsp+22)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	muls xbc,20
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+0),xwa
	ld xwa,_gfx_pano
	ld xbc,(xsp+0)
	ld c,(xbc)
	extz bc
	muls xbc,20
	add xwa,xbc
	lda xwa,(xwa)
	ld xiy,xwa
	ld iz,0
	jr L4539
L4536:
	push xix
	push xiy
	ld xwa,(xiy)
	ld bc,iz
	sll 3,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	push xwa
	ld wa,(_pano_base__30)
	add wa,iz
	push xwa
	call _load_tile__30
	lda xsp,(xsp+8)
	pop xiy
	pop xix
L4538:
	inc 1,iz
L4539:
	ld wa,iz
	cp wa,(xiy+4)
	jr ult,L4536
L4537:
	ld iz,0
	jr L4543
L4540:
	ld xwa,(xiy+14)
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_cur_pals__30
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4542:
	inc 1,iz
L4543:
	ld wa,iz
	cp wa,32
	jr ult,L4540
L4541:
	ldb (xsp+11),0
	jr L4547
L4544:
	ld ixl,0
	jr L4551
L4548:
	ld a,(xsp+11)
	extz wa
	sll 5,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld (xsp+12),wa
	ld wa,(_pano_base__30)
	ld xbc,(xiy+6)
	ld de,(xsp+12)
	extz xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	ld bc,8
	ld xde,(xiy+10)
	ld hl,(xsp+12)
	extz xhl
	add xde,xhl
	ld e,(xde)
	extz de
	add bc,de
	sll 9,bc
	add wa,bc
	ld xbc,38912
	ld de,(xsp+12)
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4550:
	inc 1,ixl
L4551:
	ld a,ixl
	cp a,32
	jr ult,L4548
L4549:
L4546:
	incb 1,(xsp+11)
L4547:
	ld a,(xsp+11)
	cp a,11
	jr ult,L4544
L4545:
	ld wa,(_pano_base__30)
	add wa,(xiy+4)
	ld (_pano_end__30),wa
	ld wa,(xiy+18)
	ld (_cur_backdrop__30),wa
	ld wa,(xiy+18)
	ld (_cur_road__30),wa
	ld xwa,(xsp+0)
	ld wa,(xwa+4)
	ld (_cur_road__30+2),wa
	ld xwa,(xsp+0)
	lda xwa,(xwa+8)
	ld wa,(xwa)
	ld (_cur_road__30+4),wa
	ld xwa,(xsp+0)
	ld wa,(xwa+6)
	ld (_cur_road__30+6),wa
	ld iz,0
	jr L4555
L4552:
	ld xwa,(xsp+0)
	lda xwa,(xwa+8)
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_cur_band__30
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4554:
	inc 1,iz
L4555:
	ld wa,iz
	cp wa,4
	jr ult,L4552
L4553:
	ld iz,0
	jr L4559
L4556:
	ld wa,65535
	ld xbc,_objmap__30
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4558:
	inc 1,iz
L4559:
	ld wa,iz
	cp wa,256
	jr ult,L4556
L4557:
	ldw (_next_slot__30),2
	ld xwa,(xsp+0)
	ld a,(xwa+1)
	ld (_kind_l__30),a
	ld xwa,(xsp+0)
	ld a,(xwa+2)
	ld (_kind_r__30),a
	push xix
	push xiy
	ld a,(_kind_l__30)
	push xwa
	call _load_kind__30
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld a,(_kind_r__30)
	cp a,(_kind_l__30)
	jr z,L4560
	push xix
	push xiy
	ld a,(_kind_r__30)
	push xwa
	call _load_kind__30
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L4560:
	push xix
	push xiy
	ld wa,11
	push xwa
	call _load_kind__30
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld a,(xsp+22)
	cp a,10
	jr uge,L4561
	push xix
	push xiy
	ld wa,12
	push xwa
	call _load_kind__30
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L4561:
	push xix
	push xiy
	ld wa,13
	push xwa
	call _load_kind__30
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld a,(xsp+22)
	cp a,0
	jr z,L4563
	ld a,(xsp+22)
	cp a,10
	jr ult,L4562
L4563:
	push xix
	push xiy
	ld wa,14
	push xwa
	call _load_kind__30
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L4562:
	ld iz,0
	jr L4567
L4564:
	ld xwa,_objmap__30
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65535
	jr nz,L4568
	ld wa,0
	ld xbc,_objmap__30
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4568:
L4566:
	inc 1,iz
L4567:
	ld wa,iz
	cp wa,256
	jr ult,L4564
L4565:
	push xix
	push xiy
	ld wa,0
	push xwa
	ld a,(_kind_l__30)
	push xwa
	ld wa,1
	push xwa
	call _set_spr_pal__30
	lda xsp,(xsp+12)
	pop xiy
	pop xix
	push xix
	push xiy
	ld wa,1
	push xwa
	ld a,(_kind_r__30)
	push xwa
	ld wa,2
	push xwa
	call _set_spr_pal__30
	lda xsp,(xsp+12)
	pop xiy
	pop xix
	push xix
	push xiy
	ld wa,2
	push xwa
	ld wa,11
	push xwa
	ld wa,9
	push xwa
	call _set_spr_pal__30
	lda xsp,(xsp+12)
	pop xiy
	pop xix
	push xix
	push xiy
	ld wa,3
	push xwa
	ld wa,13
	push xwa
	ld wa,10
	push xwa
	call _set_spr_pal__30
	lda xsp,(xsp+12)
	pop xiy
	pop xix
	push xix
	push xiy
	ld wa,4
	push xwa
	ld wa,12
	push xwa
	ld wa,4
	push xwa
	call _set_spr_pal__30
	lda xsp,(xsp+12)
	pop xiy
	pop xix
	push xix
	push xiy
	ld wa,5
	push xwa
	ld wa,14
	push xwa
	ld wa,6
	push xwa
	call _set_spr_pal__30
	lda xsp,(xsp+12)
	pop xiy
	pop xix
	push xix
	push xiy
	ld wa,0
	push xwa
	call _theme_flash
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L4535:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function to_white
_to_white__30:
	push xiz
	lda xsp,(xsp-6)
	ld wa,(xsp+14)
	and wa,15
	ld iy,wa
	ld wa,(xsp+14)
	srl 4,wa
	and wa,15
	ld ix,wa
	ld wa,(xsp+14)
	srl 8,wa
	and wa,15
	ld iz,wa
	ld a,(xsp+18)
	cp a,4
	jr ult,L4572
	ld wa,4095
	jr L4571
L4572:
	ld wa,iy
	ld bc,15
	sub bc,iy
	ld e,(xsp+18)
	extz de
	mul xbc,de
	srl 2,bc
	add wa,bc
	ld iy,wa
	ld wa,ix
	ld bc,15
	sub bc,ix
	ld e,(xsp+18)
	extz de
	mul xbc,de
	srl 2,bc
	add wa,bc
	ld ix,wa
	ld wa,iz
	ld bc,15
	sub bc,iz
	ld e,(xsp+18)
	extz de
	mul xbc,de
	srl 2,bc
	add wa,bc
	ld iz,wa
	ld wa,iy
	ld bc,ix
	sll 4,bc
	or wa,bc
	ld bc,iz
	sll 8,bc
	or wa,bc
	jr L4571
L4571:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function theme_flash
_theme_flash:
	push xiz
	lda xsp,(xsp-10)
	ld izl,0
	jp L4586
L4583:
	ld a,(xsp+18)
	push xwa
	ld xwa,_cur_pals__30
	ld c,izl
	extz bc
	sll 2,bc
	add bc,3
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__30
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+22)
	push xwa
	ld xwa,_cur_pals__30
	ld c,izl
	extz bc
	sll 2,bc
	add bc,2
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__30
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+26)
	push xwa
	ld xwa,_cur_pals__30
	ld c,izl
	extz bc
	sll 2,bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__30
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+30)
	push xwa
	ld xwa,_cur_pals__30
	ld c,izl
	extz bc
	sll 2,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__30
	lda xsp,(xsp+8)
	push xwa
	ld a,8
	add a,izl
	push xwa
	ld wa,1
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
L4585:
	inc 1,izl
L4586:
	ld a,izl
	cp a,8
	jp ult,L4583
L4584:
	ldb (xsp+1),0
	jr L4590
L4587:
	ld a,(xsp+18)
	push xwa
	ld xwa,_cur_band__30
	ld c,(xsp+5)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__30
	lda xsp,(xsp+8)
	lda xbc,(xsp+2)
	ld e,(xsp+1)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4589:
	incb 1,(xsp+1)
L4590:
	ld a,(xsp+1)
	cp a,4
	jr ult,L4587
L4588:
	lda xwa,(xsp+2)
	push xwa
	ld a,(xsp+22)
	push xwa
	ld wa,(_cur_road__30+6)
	push xwa
	call _to_white__30
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+26)
	push xwa
	ld wa,(_cur_road__30+2)
	push xwa
	call _to_white__30
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+30)
	push xwa
	ld wa,(_cur_backdrop__30)
	push xwa
	call _to_white__30
	lda xsp,(xsp+8)
	push xwa
	call _id_road_set_colors
	lda xsp,(xsp+16)
L4582:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function traffic_set_hard
_traffic_set_hard:
	ld a,(xsp+4)
	ld (_hard__31),a
	ld c,(xsp+4)
	cp c,0
	jr z,L4595
	ld wa,7
	jr L4596
L4595:
	ld wa,6
L4596:
	ld (_trf_cap__31),a
L4594:
	ret

; function rnd8
_rnd8__31:
	ld wa,(_rng__31)
	mul xwa,25173
	add wa,13849
	ld (_rng__31),wa
	ld wa,(_rng__31)
	srl 8,wa
	jr L4598
L4598:
	ret

; function traffic_init
_traffic_init:
	push xiz
	lda xsp,(xsp-2)
	ld wa,(xsp+10)
	ld (_trf_tiles__31),wa
	ld iz,0
	jr L4612
L4609:
	ld xwa,_gfx_traffic_tiles
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld bc,40960
	extz xbc
	ld de,(xsp+10)
	mul xde,16
	add xbc,xde
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4611:
	inc 1,iz
L4612:
	ld wa,iz
	ld bc,(_gfx_traffic_tiles_count)
	sll 3,bc
	cp wa,bc
	jr ult,L4609
L4610:
	ld iz,0
	jr L4616
L4613:
	ld xwa,_gfx_traffic_pals
	ld bc,iz
	sll 2,bc
	add bc,3
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_gfx_traffic_pals
	ld bc,iz
	sll 2,bc
	add bc,2
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_gfx_traffic_pals
	ld bc,iz
	sll 2,bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_gfx_traffic_pals
	ld bc,iz
	sll 2,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld a,11
	add a,izl
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
L4615:
	inc 1,iz
L4616:
	ld wa,iz
	cp wa,5
	jr ult,L4613
L4614:
	call _traffic_clear
L4608:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function traffic_set_car_line
_traffic_set_car_line:
	ld a,(xsp+4)
	push xwa
	call _id_road_distance_at_line
	lda xsp,(xsp+4)
	ld (_car_d__31),wa
	ld a,(xsp+4)
	push xwa
	call _id_road_half_at
	lda xsp,(xsp+4)
	ld (_half_wheel__31),a
	ld a,(_half_wheel__31)
	cp a,0
	jr nz,L4620
	ldb (_half_wheel__31),1
L4620:
L4619:
	ret

; function traffic_clear
_traffic_clear:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L4630
L4627:
	ld a,0
	ld xbc,_cars__31
	ld e,izl
	extz de
	muls xde,14
	add xbc,xde
	ld (xbc),a
L4629:
	inc 1,izl
L4630:
	ld a,izl
	cp a,7
	jr ult,L4627
L4628:
	ld a,50
	push xwa
	ld a,28
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L4626:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function traffic_reset
_traffic_reset:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,(_trf_cap__31)
	jr ule,L4636
	ld a,(_trf_cap__31)
	ld izl,a
L4636:
	ld a,izl
	ld (_dens_min__31),a
	ld c,(xsp+12)
	cp c,(_trf_cap__31)
	jr ule,L4637
	ld a,(_trf_cap__31)
	extz wa
	jr L4638
L4637:
	ld a,(xsp+12)
	extz wa
L4638:
	ld (_dens_max__31),a
	ld a,(_dens_min__31)
	ld (_target__31),a
	ldb (_cooldown__31),30
L4635:
	pop xiz
	ret

; function lane_lat
_lane_lat__31:
	lda xsp,(xsp-2)
	ld a,(_half_wheel__31)
	extz wa
	sll 4,wa
	exts xwa
	divs xwa,4
	ld (xsp+0),wa
	ld wa,(xsp+0)
	ld bc,2
	ld e,(xsp+6)
	extz de
	mul xbc,de
	sub bc,3
	mul xwa,bc
	jr L4640
L4640:
	lda xsp,(xsp+2)
	ret

; function lane_of
_lane_of__31:
	push xiz
	lda xsp,(xsp-4)
	ld a,(_half_wheel__31)
	extz wa
	sll 4,wa
	exts xwa
	divs xwa,4
	ld (xsp+0),wa
	ld wa,(xsp+12)
	ld bc,4
	mul xbc,(xsp+0)
	add wa,bc
	exts xwa
	ld bc,2
	mul xbc,(xsp+0)
	divs xwa,bc
	ld iz,wa
	ld wa,iz
	cp wa,0
	jr ge,L4645
	ld iz,0
L4645:
	ld wa,iz
	cp wa,3
	jr le,L4646
	ld iz,3
L4646:
	ld a,izl
	jr L4644
L4644:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function spawn
_spawn__31:
	push xiz
	lda xsp,(xsp-10)
	ld wa,0
	exts xwa
	ld (xsp+4),xwa
	ld izl,0
	jr L4672
L4669:
	ld xwa,_cars__31
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L4673
	ld xwa,_cars__31
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+4),xwa
	jr L4670
L4673:
L4671:
	inc 1,izl
L4672:
	ld a,izl
	cp a,7
	jr ult,L4669
L4670:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L4674
	jp L4668
L4674:
	ldb (xsp+2),0
	jp L4678
L4675:
	ld wa,0
	ld (xsp+8),a
	call _rnd8__31
	extz wa
	and wa,3
	ld (xsp+1),a
	ld izl,0
	jr L4682
L4679:
	ld xwa,_cars__31
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L4683
	ld xwa,_cars__31
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+4)
	push xwa
	ld a,(xsp+5)
	push xwa
	call _lane_lat__31
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp wa,bc
	jr nz,L4683
	ld xwa,_cars__31
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	ld bc,1450
	ld de,(_car_d__31)
	sub bc,de
	sub bc,400
	sll 4,bc
	cp wa,bc
	jr le,L4683
	ldb (xsp+8),1
L4683:
L4681:
	inc 1,izl
L4682:
	ld a,izl
	cp a,7
	jr ult,L4679
L4680:
	ld a,(xsp+8)
	cp a,0
	jr nz,L4684
	jr L4676
L4684:
L4677:
	incb 1,(xsp+2)
L4678:
	ld a,(xsp+2)
	cp a,3
	jp ult,L4675
L4676:
	ld a,(xsp+2)
	cp a,3
	jr nz,L4685
	jp L4668
L4685:
	ld a,1
	ld xbc,(xsp+4)
	ld (xbc),a
	call _rnd8__31
	extz wa
	exts xwa
	divs xwa,3
	ld wa,qwa
	ld xbc,(xsp+4)
	ld (xbc+1),a
	ld wa,11
	push xwa
	call _rnd8__31
	ld xbc,xwa
	pop xwa
	extz bc
	exts xbc
	divs xbc,5
	ld bc,qbc
	add wa,bc
	ld xbc,(xsp+4)
	ld (xbc+2),a
	ld c,(_hard__31)
	cp c,0
	jr z,L4686
	ld wa,42
	jr L4687
L4686:
	ld wa,55
L4687:
	push xwa
	call _rnd8__31
	ld xbc,xwa
	pop xwa
	extz bc
	extz xbc
	div xbc,70
	ld bc,qbc
	add wa,bc
	ld xbc,(xsp+4)
	ld (xbc+3),a
	ld xwa,(xsp+4)
	ld a,(xwa+1)
	cp a,2
	jr nz,L4688
	ld xwa,(xsp+4)
	ld a,(xwa+3)
	sub a,15
	ld xbc,(xsp+4)
	ld (xbc+3),a
L4688:
	ld a,(xsp+1)
	push xwa
	call _lane_lat__31
	lda xsp,(xsp+4)
	ld xbc,(xsp+4)
	ld (xbc+4),wa
	ld xwa,(xsp+4)
	ld wa,(xwa+4)
	ld xbc,(xsp+4)
	ld (xbc+10),wa
	ld wa,1450
	ld bc,(_car_d__31)
	sub wa,bc
	sll 4,wa
	ld xbc,(xsp+4)
	ld (xbc+6),wa
	ld xwa,(xsp+4)
	ld wa,(xwa+6)
	ld xbc,(xsp+4)
	ld (xbc+12),wa
	ld wa,0
	ld xbc,(xsp+4)
	ld (xbc+8),wa
L4668:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function traffic_update
_traffic_update:
	push xiz
	lda xsp,(xsp-10)
	ld wa,0
	ld (xsp+1),a
	ldb (xsp+0),0
	jp L4721
L4718:
	ld xwa,_cars__31
	ld c,(xsp+0)
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld xiz,xwa
	ld a,(xiz)
	cp a,0
	jr nz,L4722
	jp L4720
L4722:
	ld wa,(xiz+6)
	ld (xiz+12),wa
	ld wa,(xiz+8)
	ld c,(xiz+3)
	extz bc
	ld e,(xsp+18)
	extz de
	sub bc,de
	mul xbc,85
	add wa,bc
	ld (xiz+8),wa
	ld wa,(xiz+8)
	exts xwa
	divs xwa,64
	ld (xsp+6),wa
	ld wa,(xiz+6)
	add wa,(xsp+6)
	ld (xiz+6),wa
	ld wa,(xiz+8)
	ld bc,(xsp+6)
	sll 6,bc
	sub wa,bc
	ld (xiz+8),wa
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr z,L4723
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr ge,L4724
	ld wa,(xiz+4)
	add wa,8
	ld (xiz+4),wa
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr le,L4725
	ld wa,(xiz+10)
	ld (xiz+4),wa
L4725:
	jr L4726
L4724:
	ld wa,(xiz+4)
	sub wa,8
	ld (xiz+4),wa
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr ge,L4727
	ld wa,(xiz+10)
	ld (xiz+4),wa
L4727:
L4726:
	jr L4728
L4723:
	call _rnd8__31
	ld e,(_hard__31)
	cp e,0
	jr z,L4730
	ld bc,6
	jr L4731
L4730:
	ld bc,2
L4731:
	cp a,c
	jr uge,L4729
	ld wa,(xiz+4)
	push xwa
	call _lane_of__31
	lda xsp,(xsp+4)
	ld (xsp+8),a
	ld a,(xsp+8)
	cp a,0
	jr nz,L4732
	ldb (xsp+8),1
	jr L4733
L4732:
	ld a,(xsp+8)
	cp a,3
	jr nz,L4734
	ldb (xsp+8),2
	jr L4735
L4734:
	push xwa
	call _rnd8__31
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,1
	cp bc,0
	jr z,L4736
	ld a,(xsp+8)
	add a,1
	extz wa
	jr L4737
L4736:
	ld a,(xsp+8)
	sub a,1
	extz wa
L4737:
	ld (xsp+8),a
L4735:
L4733:
	ld a,(xsp+8)
	push xwa
	call _lane_lat__31
	lda xsp,(xsp+4)
	ld (xiz+10),wa
L4729:
L4728:
	ld wa,(xiz+6)
	ld bc,(_car_d__31)
	neg bc
	sll 4,bc
	sub bc,64
	cp wa,bc
	jr lt,L4739
	ld wa,(xiz+6)
	ld bc,1600
	ld de,(_car_d__31)
	sub bc,de
	sll 4,bc
	cp wa,bc
	jr le,L4738
L4739:
	ldb (xiz),0
	jr L4720
L4738:
	incb 1,(xsp+1)
L4720:
	incb 1,(xsp+0)
L4721:
	ld a,(xsp+0)
	cp a,7
	jp ult,L4718
L4719:
	ld a,(_cooldown__31)
	cp a,0
	jr z,L4740
	decb 1,(_cooldown__31)
L4740:
	ld a,(xsp+22)
	cp a,0
	jr z,L4741
	ld a,(xsp+1)
	cp a,(_target__31)
	jr uge,L4741
	ld a,(_cooldown__31)
	cp a,0
	jr nz,L4741
	ld a,(xsp+18)
	cp a,50
	jr ule,L4741
	call _spawn__31
	ld c,(_hard__31)
	cp c,0
	jr z,L4742
	ld wa,16
	jr L4743
L4742:
	ld wa,25
L4743:
	push xwa
	call _rnd8__31
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,31
	add wa,bc
	ld (_cooldown__31),a
	ld a,(_dens_max__31)
	cp a,(_dens_min__31)
	jr ule,L4744
	ld a,(_dens_min__31)
	extz wa
	push xwa
	call _rnd8__31
	ld xbc,xwa
	pop xwa
	extz bc
	exts xbc
	ld e,(_dens_max__31)
	sub e,(_dens_min__31)
	add e,1
	extz de
	divs xbc,de
	ld bc,qbc
	add wa,bc
	ld (_target__31),a
L4744:
L4741:
L4717:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function traffic_collide
_traffic_collide:
	push xiz
	lda xsp,(xsp-12)
	ld iyl,0
	jp L4763
L4760:
	ld xwa,_cars__31
	ld c,iyl
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld xiz,xwa
	ld a,(xiz)
	cp a,0
	jr nz,L4764
	jr L4762
L4764:
	ld bc,(xiz+12)
	cp bc,(xiz+6)
	jr ge,L4765
	ld wa,(xiz+12)
	jr L4766
L4765:
	ld wa,(xiz+6)
L4766:
	ld (xsp+8),wa
	ld bc,(xiz+12)
	cp bc,(xiz+6)
	jr ge,L4767
	ld wa,(xiz+6)
	jr L4768
L4767:
	ld wa,(xiz+12)
L4768:
	ld (xsp+10),wa
	ld wa,(xsp+8)
	cp wa,224
	jr gt,L4770
	ld wa,(xsp+10)
	cp wa,65440
	jr ge,L4769
L4770:
	jr L4762
L4769:
	ld wa,(xiz+4)
	sub wa,(xsp+20)
	ld ix,wa
	ld wa,ix
	cp wa,0
	jr ge,L4771
	ld wa,ix
	neg wa
	ld ix,wa
L4771:
	ld wa,ix
	cp wa,416
	jr ge,L4772
	ld wa,(xiz+6)
	add wa,960
	ld (xiz+6),wa
	ld wa,(xiz+6)
	ld (xiz+12),wa
	ld a,(xiz+3)
	add a,30
	ld (xiz+3),a
	ld wa,1
	jr L4759
L4772:
L4762:
	inc 1,iyl
L4763:
	ld a,iyl
	cp a,7
	jp ult,L4760
L4761:
	ld wa,0
	jr L4759
L4759:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function traffic_draw
_traffic_draw:
	push xiz
	lda xsp,(xsp-66)
	ld wa,0
	ld (xsp+7),a
	ld wa,28
	ld (xsp+10),a
	push xix
	call _id_road_visible_top
	pop xix
	extz wa
	ld (xsp+12),wa
	ld izl,0
	jr L4807
L4804:
	ld xwa,_cars__31
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L4808
	ld a,izl
	lda xbc,(xsp+0)
	ld e,(xsp+7)
	incb 1,(xsp+7)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L4808:
L4806:
	inc 1,izl
L4807:
	ld a,izl
	cp a,7
	jr ult,L4804
L4805:
	ld izl,1
	jp L4812
L4809:
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+14),a
	ld a,izl
	ld ixl,a
	jr L4815
L4813:
	lda xwa,(xsp+0)
	ld c,ixl
	sub c,1
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	lda xbc,(xsp+0)
	ld e,ixl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	dec 1,ixl
L4815:
	ld a,ixl
	cp a,0
	jr ule,L4816
	ld xwa,_cars__31
	lda xbc,(xsp+0)
	ld e,ixl
	sub e,1
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	ld xbc,_cars__31
	ld e,(xsp+14)
	extz de
	muls xde,14
	add xbc,xde
	ld bc,(xbc+6)
	cp wa,bc
	jr gt,L4813
L4816:
L4814:
	ld a,(xsp+14)
	lda xbc,(xsp+0)
	ld e,ixl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L4811:
	inc 1,izl
L4812:
	ld a,izl
	cp a,(xsp+7)
	jp ult,L4809
L4810:
	ld izl,0
	jp L4820
L4817:
	ld xwa,_cars__31
	lda xbc,(xsp+0)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+14),xwa
	ld wa,(_car_d__31)
	ld xbc,(xsp+14)
	ld bc,(xbc+6)
	exts xbc
	divs xbc,16
	add wa,bc
	ld (xsp+18),wa
	ld wa,(xsp+18)
	cp wa,0
	jr ge,L4821
	jp L4819
L4821:
	push xix
	ld wa,(xsp+22)
	push xwa
	call _id_road_line_at_distance
	lda xsp,(xsp+4)
	pop xix
	ld (xsp+20),a
	ld a,(xsp+20)
	cp a,255
	jr nz,L4822
	jp L4819
L4822:
	push xix
	lda xwa,(xsp+28)
	push xwa
	ld a,(xsp+28)
	push xwa
	call _id_road_sprite_sample
	lda xsp,(xsp+8)
	pop xix
	ld wa,(xsp+26)
	cp wa,(xsp+12)
	jr ge,L4823
	jp L4819
L4823:
	ld a,(xsp+28)
	extz wa
	sll 5,wa
	extz xwa
	ld c,(_half_wheel__31)
	extz bc
	div xwa,bc
	ld (xsp+22),a
	ld a,(xsp+22)
	cp a,28
	jr ult,L4824
	ldb (xsp+21),0
	jr L4825
L4824:
	ld a,(xsp+22)
	cp a,20
	jr ult,L4826
	ldb (xsp+21),1
	jr L4827
L4826:
	ld a,(xsp+22)
	cp a,13
	jr ult,L4828
	ldb (xsp+21),2
	jr L4829
L4828:
	ld a,(xsp+22)
	cp a,9
	jr ult,L4830
	ldb (xsp+21),3
	jr L4831
L4830:
	ldb (xsp+21),4
L4831:
L4829:
L4827:
L4825:
	ld xwa,_gfx_traffic_frames
	ld xbc,(xsp+14)
	ld c,(xbc+1)
	extz bc
	mul xbc,5
	ld e,(xsp+21)
	extz de
	add bc,de
	extz bc
	exts xbc
	sll 3,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+30),xwa
	ld wa,(xsp+24)
	ld xbc,(xsp+14)
	ld bc,(xbc+4)
	sra 4,bc
	ld e,(xsp+28)
	extz de
	mul xbc,de
	exts xbc
	ld e,(_half_wheel__31)
	extz de
	divs xbc,de
	add wa,bc
	ld (xsp+40),wa
	ld wa,(xsp+40)
	ld xbc,(xsp+30)
	ld c,(xbc+6)
	extz bc
	srl 1,bc
	sub wa,bc
	ld (xsp+38),wa
	ld wa,(xsp+26)
	cp wa,151
	jr le,L4832
	jp L4819
L4832:
	ld wa,(xsp+26)
	add wa,1
	ld xbc,(xsp+30)
	ld c,(xbc+1)
	extz bc
	sll 3,bc
	sub wa,bc
	ld (xsp+42),a
	ld xwa,_gfx_traffic_cells
	ld xbc,(xsp+30)
	ld bc,(xbc+4)
	mul xbc,3
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+44),xwa
	ld wa,0
	exts xwa
	ld (xsp+48),xwa
	ld wa,(_trf_tiles__31)
	ld (xsp+52),wa
	ld wa,(xsp+38)
	ld (xsp+54),wa
	ld a,(xsp+42)
	ld (xsp+56),a
	ld xwa,(xsp+30)
	ld a,(xwa+2)
	ld (xsp+57),a
	ldb (xsp+58),0
	ld a,(_id_spr_priority)
	ld (xsp+59),a
	ld xwa,(xsp+14)
	ld a,(xwa+2)
	ld (xsp+60),a
	ld a,(xsp+10)
	ld (xsp+61),a
	ldb (xsp+62),50
	ldb (xsp+63),0
	ldb (xsp+64),0
	push xix
	lda xwa,(xsp+48)
	push xwa
	call _spr_cells_asm
	lda xsp,(xsp+4)
	pop xix
	ld a,(xsp+61)
	ld (xsp+10),a
L4819:
	inc 1,izl
L4820:
	ld a,izl
	cp a,(xsp+7)
	jp ult,L4817
L4818:
	push xix
	ld a,50
	push xwa
	ld a,(xsp+18)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xix
L4803:
	lda xsp,(xsp+66)
	pop xiz
	ret

; function traffic_ap_target
_traffic_ap_target:
	push xiz
	lda xsp,(xsp-12)
	ld wa,1
	ld (xsp+2),a
	ld wa,65535
	ld (xsp+4),wa
	ld iyl,0
	jp L4855
L4852:
	push xix
	push xiy
	ld a,iyl
	push xwa
	call _lane_lat__31
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (xsp+6),wa
	ld wa,32767
	ld (xsp+8),wa
	ld izl,0
	jp L4859
L4856:
	ld xwa,_cars__31
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L4861
	ld xwa,_cars__31
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	cp wa,65280
	jr ge,L4860
L4861:
	jr L4858
L4860:
	ld xwa,_cars__31
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+4)
	sub wa,(xsp+6)
	ld ix,wa
	ld wa,ix
	cp wa,0
	jr ge,L4862
	ld wa,ix
	neg wa
	ld ix,wa
L4862:
	ld wa,ix
	cp wa,480
	jr ge,L4863
	ld xwa,_cars__31
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	cp wa,(xsp+8)
	jr ge,L4863
	ld xwa,_cars__31
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	ld (xsp+8),wa
L4863:
L4858:
	inc 1,izl
L4859:
	ld a,izl
	cp a,7
	jp ult,L4856
L4857:
	ld wa,(xsp+8)
	cp wa,(xsp+4)
	jr gt,L4865
	ld wa,(xsp+8)
	cp wa,(xsp+4)
	jr nz,L4864
	ld wa,(xsp+24)
	cp wa,0
	jr ge,L4867
	ld a,iyl
	cp a,0
	jr z,L4866
L4867:
	ld wa,(xsp+24)
	cp wa,0
	jr le,L4864
	ld a,iyl
	cp a,3
	jr nz,L4864
L4866:
L4865:
	ld wa,(xsp+8)
	ld (xsp+4),wa
	ld a,iyl
	ld (xsp+2),a
L4864:
L4854:
	inc 1,iyl
L4855:
	ld a,iyl
	cp a,4
	jp ult,L4852
L4853:
	ld wa,(xsp+4)
	cp wa,14400
	jr le,L4868
	ld wa,(xsp+24)
	cp wa,0
	jr z,L4868
	ld wa,(xsp+24)
	jr L4851
L4868:
	push xix
	push xiy
	ld a,(xsp+10)
	push xwa
	call _lane_lat__31
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	jr L4851
L4851:
	lda xsp,(xsp+12)
	pop xiz
	ret
; c900 runtime helpers (TLCS-900/H, asl syntax)
; Convention: operands in XWA (left) and XBC (right); result in XWA.
; May clobber XWA XBC XDE XHL XIX XIY.

__mul32:
        ld      xde,xwa
        ld      xhl,xbc
        mul     xwa,bc
        ld      ix,qde
        mul     xix,hl
        ld      iy,qhl
        mul     xiy,de
        add     xix,xiy
        sll     16,xix
        add     xwa,xix
        ret

; unsigned 32/32: quotient XWA, remainder XHL
__div32u:
        ld      xhl,0
        ld      e,32
__div32u_loop:
        sll     1,xwa
        rl      1,xhl
        cp      xhl,xbc
        jr      ult,__div32u_skip
        sub     xhl,xbc
        inc     1,xwa
__div32u_skip:
        djnz    e,__div32u_loop
        ret

__mod32u:
        call    __div32u
        ld      xwa,xhl
        ret

__div32s:
        call    __divmod32s
        ret

__mod32s:
        call    __divmod32s
        ld      xwa,xhl
        ret

; signed: quotient XWA, remainder XHL (sign of dividend)
__divmod32s:
        ld      d,0
        cp      xwa,0
        jr      ge,__dms_apos
        xor     xwa,0ffffffffh
        inc     1,xwa
        xor     d,3
__dms_apos:
        cp      xbc,0
        jr      ge,__dms_bpos
        xor     xbc,0ffffffffh
        inc     1,xbc
        xor     d,1
__dms_bpos:
        call    __div32u
        bit     0,d
        jr      z,__dms_q
        xor     xwa,0ffffffffh
        inc     1,xwa
__dms_q:
        bit     1,d
        jr      z,__dms_r
        xor     xhl,0ffffffffh
        inc     1,xhl
__dms_r:
        ret
; ---- src/core/ngpc_flash_asm.asm

;
; ngpc_flash_asm.asm - Flash erase/write primitives for ngpc_flash.c
;
; Part of NgpCraft_base_template (MIT License)
;
; Two entry points, both called ONLY by ngpc_flash.c (never from an ISR):
;
;   _ngpc_flash_erase_asm(u32 abs_block)
;       Erases one 8 KB block with the AMD erase stub extracted from StarGunner
;       (hardware-validated), copied to RAM 0x6E00 and run from there.
;       VECT_FLASHERS cannot erase blocks 32/33/34 (SysCall.txt p.299), so the
;       erase keeps the stub.
;
;   _ngpc_flash_write_bios(const void *src, u32 offset, u32 pages)
;       Programs pages x 256 bytes through the BIOS (VECT_FLASHWRITE, swi 1),
;       the path StarGunner uses on hardware. The watchdog is refreshed right
;       before and right after, as in the SDK save pattern.
;
; THE BLOCK IS A PARAMETER, NOT A CONSTANT. The save block sits 0x6000 below
; the top of the chip, so its address depends on the cartridge size:
; 0x27A000 on 4 Mbit, 0x2FA000 on 8 Mbit, 0x3FA000 on 16 Mbit. A hard-coded
; 0x3FA000 erases 8 KB ELSEWHERE on a smaller chip - possibly the game code.
; ngpc_flash.c reads the size the BIOS stores at 0x6C58 and refuses unknown ones.
;
; cc900 ABI (CALL pushes 4-byte XPC as return address):
;   (xsp+0)..(xsp+3)  = return address
;   (xsp+4)..(xsp+7)  = 1st parameter
;   (xsp+8)..(xsp+11) = 2nd parameter
;   (xsp+12)..(xsp+15)= 3rd parameter
;
; ===========================================================================
; INTERRUPTS ARE PROHIBITED FOR THE WHOLE SEQUENCE. On hardware that is not
; optional. A flash chip being programmed or erased answers reads with STATUS,
; not with its contents. The stub runs from RAM for that reason, but the
; interrupt handlers are still in the cartridge: an interrupt taken while the
; chip is busy fetches its handler from status bits. A game taking VBlank at
; 60 Hz cannot get through a 256-byte program or an 8 KB erase without one.
;
; AN EMULATOR WHOSE FLASH KEEPS SERVING ROM DURING THE WRITE NEVER SHOWS THIS.
; Toshiba: "all interrupts are prohibited during system calls related to flash
; memory management" (SysCall.txt). Hence `di` (encoded 06 07 = EI 7) on entry
; and `ei 0` (06 00) on exit: level 0 is what ngpc_init() runs the game at.
; ===========================================================================



FLASH_RAM       equ     0x6E00          ; RAM address for stub execution
FLASH_BUS_CTRL  equ     0x6E            ; I/O: flash /WE enable (0x14=on, 0xF0=off)
FLASH_WD        equ     0x6F            ; I/O: watchdog  (0xB1=extended, 0x4E=refresh)
CART_BASE       equ     0x200000        ; CS0 base address



; ===========================================================================
; _ngpc_flash_erase_asm
;   param 1 (xsp+4) : u32 abs_block -- ABSOLUTE address of the 8 KB block
; C prototype: void ngpc_flash_erase_asm(u32 abs_block);
; ===========================================================================
_ngpc_flash_erase_asm:

        di                              ; see the note at the top of the file
        ld      (FLASH_BUS_CTRL),0x14   ; enable /WE on cart bus
        ld      (FLASH_WD),0xB1         ; watchdog: extended mode

        ; Copy erase stub (98 bytes) from ROM to RAM at FLASH_RAM
        push    xbc                     ; preserve XBC across copy
        ld      xde,FLASH_RAM           ; destination: RAM
        ld      xhl,_erase_stub         ; source: stub bytes in ROM
        ld      bc,0x62                 ; BC = 98 bytes
        db      0x83,0x11               ; ldir (xde+),(xhl+) -- copy BC bytes
        pop     xbc                     ; restore XBC (stack back to entry)

        ; Set up registers for stub call
        ld      xix,CART_BASE           ; XIX = 0x200000 (AMD unlock base)
        ld      xiy,0x0                 ; XIY = 0 (erase stub uses as delay counter)
        ld      a,0x0                   ; A = 0 (erase stub state init)
        ld      xde,(xsp+4)             ; XDE = block, given by the caller

        call    FLASH_RAM               ; execute stub from RAM

        ld      (FLASH_BUS_CTRL),0xF0   ; restore watchdog mode first
        ld      (FLASH_WD),0x4E         ; then refresh the enabled watchdog
        ei      0                       ; the chip answers as memory again
        ret


; ===========================================================================
; _ngpc_flash_write_bios
;   param 1 (xsp+4)  : const void *src -- source buffer, in RAM
;   param 2 (xsp+8)  : u32 offset      -- offset INSIDE the cartridge
;                                         (e.g. 0x1FA000 + slot*SAVE_SIZE),
;                                         not the absolute address: XDE3 wants
;                                         the offset.
;   param 3 (xsp+12) : u32 pages       -- number of 256-byte units
; C prototype: void ngpc_flash_write_bios(const void *src, u32 offset, u32 pages);
;
; The BIOS holds the bus itself (no manual 0x6E write). The AMD write stub used
; before disabled the watchdog and wrote its refresh code while it was off.
; ===========================================================================
_ngpc_flash_write_bios:

        di                              ; see the note at the top of the file
        ld      xhl,(xsp+4)             ; 1st param: source
        ld      xde,(xsp+8)             ; 2nd param: cartridge offset
        ld      xbc,(xsp+12)            ; 3rd param: 256-byte pages
        ld      xhl3,xhl                ; bank 3: the BIOS reads its arguments there
        ld      xde3,xde
        ld      xbc3,xbc
        ld      ra3,0                   ; CS0
        ld      rw3,0x0006              ; VECT_FLASHWRITE
        ld      (FLASH_WD),0x4E         ; watchdog refreshed RIGHT BEFORE
        swi     1
        ld      (FLASH_WD),0x4E         ; and right after
        ei      0
        ret


; ===========================================================================
; Erase stub, extracted from StarGunner/bin/main.ngp (hardware-validated).
; 98 bytes, file offset 0x13733. Position-independent, uses XIX for AMD cycles.
;   AMD unlock -> reset -> unlock -> erase setup (0x80) -> unlock -> sector
;   erase (0x30) -> poll DQ7 -> final reset/unlock -> ret
;   Register interface: XIX=cart_base XDE=block_addr XIY=0 A=0
; ===========================================================================

_erase_stub:
        db      0xF3,0xF1,0x55,0x55,0x00,0xAA, 0xF3,0xF1,0xAA,0x2A,0x00,0x55
        db      0xF3,0xF1,0x55,0x55,0x00,0xF0, 0x00,0x00,0xF3,0xF1,0x55,0x55
        db      0x00,0xAA,0xF3,0xF1,0xAA,0x2A, 0x00,0x55,0xF3,0xF1,0x55,0x55
        db      0x00,0x80,0xF3,0xF1,0x55,0x55, 0x00,0xAA,0xF3,0xF1,0xAA,0x2A
        db      0x00,0x55,0xB2,0x00,0x30,0x82, 0x3F,0xFF,0x66,0x15,0xED,0x61
        db      0xED,0xCF,0xFF,0xFF,0x1F,0x00, 0x66,0x09,0xB2,0xCD,0x66,0xED
        db      0x82,0x3F,0xFF,0x66,0x02,0x21, 0xFF,0xF3,0xF1,0x55,0x55,0x00
        db      0xAA,0xF3,0xF1,0xAA,0x2A,0x00, 0x55,0xF3,0xF1,0x55,0x55,0x00
        db      0xF0,0x0E

; ---- src/core/ngpc_syspatch.asm

;
; ngpc_syspatch.asm - Power-off bug patch (SYS_PATCH equivalent)
;
; Part of NgpCraft_base_template (MIT License)
;
; Reverse-engineered from system.lib (SNK Corporation, 1998).
;
; The original SYS_PATCH routine fixes a bug in the initial production
; NEOGEO POCKET system program: rapid removal/reinsertion of batteries
; could prevent the power button from shutting down the console.
;
; Condition : OS_Version (0x6F91) == 0x00  [prototype firmware only]
; Effect    : res 3, (0x6F83)              [clear undocumented sys flag]
;             ldb (0x6DA0), 0x00           [clear undocumented power flag]
;
; On all retail hardware (OS_Version >= 0x01) this is a safe no-op.
; Must be called once at startup, before enabling interrupts.
;
; Reference: MANSysPro.txt "SYS_PATCH", SysLib.txt p.6
;




_ngpc_sys_patch:

        ; cp (0x6F91), 0x00  [C1 91 6F 3F 00]
        ; Compare OS_Version with 0. Z=1 if prototype firmware.
        db 0xC1, 0x91, 0x6F, 0x3F, 0x00

        ; jr NZ, +9  [6E 09]
        ; Retail hardware (OS_Version != 0): skip patch, fall through to ret.
        db 0x6E, 0x09

        ; res 3, (0x6F83)  [F1 83 6F B3]
        ; Clear bit 3 of undocumented system flag (between Sys_Lever and User_Boot).
        db 0xF1, 0x83, 0x6F, 0xB3

        ; ldb (0x6DA0), 0x00  [F1 A0 6D 00 00]
        ; Clear undocumented power state register in system RAM.
        db 0xF1, 0xA0, 0x6D, 0x00, 0x00

        ret


; ---- src/core/ngpc_vramq_asm.asm
; ngpc_vramq_asm.asm - VRAM queue ASM helpers (TLCS-900/H)
;
; Part of NgpCraft_base_template (MIT License)
;
; Provides ngpc_memcpy_w() -- word-level block copy via LDIRW.
; Used by ngpc_vramq.c CMD_COPY path instead of a byte-by-byte C loop.
; dst is a near VRAM address (0x8000-0xBFFF). src can be near RAM or far ROM.
;
; void ngpc_memcpy_w(u32 dst_addr, u32 src_addr, u32 words)
;
; cc900 calling convention -- args passed as u32 (4 bytes each, unambiguous):
;   (xsp+0)  return address (far)   4 bytes
;   (xsp+4)  dst_addr (u32)         4 bytes  <- near VRAM address (high 16 = 0)
;   (xsp+8)  src_addr (u32)         4 bytes  <- RAM/ROM address (near or far)
;   (xsp+12) words (u32)            4 bytes  <- word count (high 16 = 0)
;
; Using u32 args avoids ambiguity: cc900 may pad u16 args to 4 bytes on stack.
; u32 args are always exactly 4 bytes, matching LD XRR, (xsp+N) reads.
;
; LDIRW guard: BC=0 at entry copies 65536 words -- skip if words==0.
; OR A, C is safe here (ALU instruction; C is not ambiguous as condition code
; in this context -- ambiguity only occurs in LD (mem), c indirect store form).





; ================================================================
; void ngpc_memcpy_w(u32 dst_addr, u32 src_addr, u32 words)
;
; Block-copies 'words' 16-bit words from src_addr to dst_addr via LDIRW.
; Equivalent to: while (words--) *(u16*)dst++ = *(u16*)src++;
; but uses LDIRW hardware block transfer.
;
; Call site (ngpc_vramq.c) passes near u16 addresses widened to u32:
;   ngpc_memcpy_w((u32)dst_u16, (u32)src_u16, (u32)word_count)
; So upper 16 bits of XDE/XHL are guaranteed 0. LDIRW needs upper=0. OK
; ================================================================
_ngpc_memcpy_w:
        ; Load XDE = dst_addr (full 32-bit; upper 16 = 0 since near address)
        ld      xde, (xsp+4)

        ; Load XHL = src_addr (full 32-bit; may be near or far)
        ld      xhl, (xsp+8)

        ; Load BC = words (low 16 of u32; high 16 is 0 since words <= 65535)
        ld      bc, (xsp+12)

        ; BC=0 guard: if words==0, skip (LDIRW BC=0 copies 65536 words!)
        ; OR A, C: ALU instruction -- C is register, not condition code here.
        ld      a, b
        or      a, c
        jr      z, memcpy_w_done

        ldirw                       ; block copy: BC words from XHL -> XDE

memcpy_w_done:
        ret


; ---- src/fx/ngpc_dma_prog.asm



; C prototypes:
;   void dmaN_program_asm(const u8  __far *src, volatile u8 __far *dst, u16 count);
;   void dmaN_program_u16_asm(const u16 __far *src, volatile u8 __far *dst, u16 count);
;   void dmaN_program_u32_asm(const u32 __far *src, volatile u8 __far *dst, u16 count);
;
; Notes:
; - `count` is written to DMACn directly (i.e. number of DMA "steps"/transfers,
;   not necessarily a byte count when using word/dword modes).
;
; Stack layout on entry (TLCS-900/H cc900):
;   (xsp+0)  return address (far) 4 bytes
;   (xsp+4)  src (far pointer)   4 bytes
;   (xsp+8)  dst (far pointer)   4 bytes
;   (xsp+12) count (u16)         2 bytes
;
; DMA modes (see SDK `HDMA.H`; values here are the real hex values).
DMA_MODE_SINC1  equ 8   ; 0x08: byte,  src++
DMA_MODE_SINC2  equ 9   ; 0x09: word,  src++
DMA_MODE_SINC4  equ 10  ; 0x0A: dword, src++

_dma0_program_asm:
        ld      xwa,(xsp+4)
        ldc    dmas0,xwa
        ld      xwa,(xsp+8)
        ldc    dmad0,xwa
        ld      wa,(xsp+12)
        ldc    dmac0,wa
        ld      a,DMA_MODE_SINC1
        ldc    dmam0,a
        ret

_dma0_program_u16_asm:
        ld      xwa,(xsp+4)
        ldc    dmas0,xwa
        ld      xwa,(xsp+8)
        ldc    dmad0,xwa
        ld      wa,(xsp+12)
        ldc    dmac0,wa
        ld      a,DMA_MODE_SINC2
        ldc    dmam0,a
        ret

_dma0_program_u32_asm:
        ld      xwa,(xsp+4)
        ldc    dmas0,xwa
        ld      xwa,(xsp+8)
        ldc    dmad0,xwa
        ld      wa,(xsp+12)
        ldc    dmac0,wa
        ld      a,DMA_MODE_SINC4
        ldc    dmam0,a
        ret

_dma1_program_asm:
        ld      xwa,(xsp+4)
        ldc    dmas1,xwa
        ld      xwa,(xsp+8)
        ldc    dmad1,xwa
        ld      wa,(xsp+12)
        ldc    dmac1,wa
        ld      a,DMA_MODE_SINC1
        ldc    dmam1,a
        ret

_dma1_program_u16_asm:
        ld      xwa,(xsp+4)
        ldc    dmas1,xwa
        ld      xwa,(xsp+8)
        ldc    dmad1,xwa
        ld      wa,(xsp+12)
        ldc    dmac1,wa
        ld      a,DMA_MODE_SINC2
        ldc    dmam1,a
        ret

_dma1_program_u32_asm:
        ld      xwa,(xsp+4)
        ldc    dmas1,xwa
        ld      xwa,(xsp+8)
        ldc    dmad1,xwa
        ld      wa,(xsp+12)
        ldc    dmac1,wa
        ld      a,DMA_MODE_SINC4
        ldc    dmam1,a
        ret

_dma2_program_asm:
        ld      xwa,(xsp+4)
        ldc    dmas2,xwa
        ld      xwa,(xsp+8)
        ldc    dmad2,xwa
        ld      wa,(xsp+12)
        ldc    dmac2,wa
        ld      a,DMA_MODE_SINC1
        ldc    dmam2,a
        ret

_dma2_program_u16_asm:
        ld      xwa,(xsp+4)
        ldc    dmas2,xwa
        ld      xwa,(xsp+8)
        ldc    dmad2,xwa
        ld      wa,(xsp+12)
        ldc    dmac2,wa
        ld      a,DMA_MODE_SINC2
        ldc    dmam2,a
        ret

_dma2_program_u32_asm:
        ld      xwa,(xsp+4)
        ldc    dmas2,xwa
        ld      xwa,(xsp+8)
        ldc    dmad2,xwa
        ld      wa,(xsp+12)
        ldc    dmac2,wa
        ld      a,DMA_MODE_SINC4
        ldc    dmam2,a
        ret

_dma3_program_asm:
        ld      xwa,(xsp+4)
        ldc    dmas3,xwa
        ld      xwa,(xsp+8)
        ldc    dmad3,xwa
        ld      wa,(xsp+12)
        ldc    dmac3,wa
        ld      a,DMA_MODE_SINC1
        ldc    dmam3,a
        ret

_dma3_program_u16_asm:
        ld      xwa,(xsp+4)
        ldc    dmas3,xwa
        ld      xwa,(xsp+8)
        ldc    dmad3,xwa
        ld      wa,(xsp+12)
        ldc    dmac3,wa
        ld      a,DMA_MODE_SINC2
        ldc    dmam3,a
        ret

_dma3_program_u32_asm:
        ld      xwa,(xsp+4)
        ldc    dmas3,xwa
        ld      xwa,(xsp+8)
        ldc    dmad3,xwa
        ld      wa,(xsp+12)
        ldc    dmac3,wa
        ld      a,DMA_MODE_SINC4
        ldc    dmam3,a
        ret

; ---- src/id_road_asm.asm
; id_road_asm.asm - la marche par tranches de id_road_write(), en assembleur
;
; POURQUOI EN ASSEMBLEUR. Profil de la ROM livree (tools/profil_course.py,
; temporisation de la cartouche comprise) : cette boucle etait le plus gros
; poste du tour de course. cc900 n'y gardait pas ses valeurs en registres --
; tout allait sur la pile -- et relisait chaque adresse de table par une
; instruction de cinq octets, cinquante-six fois par trame. Sur cette machine
; chaque octet d'instruction se lit dans la cartouche.
;
; LE CALCUL EST CELUI DU C, A L'OCTET PRES : la version C est gardee dans
; id_road.c (ID_ROAD_WALK_C=1) et tools/equivalence.py compare, tour de boucle
; par tour de boucle, la RAM de cette ROM a celle de la ROM d'origine sur les
; dix circuits.
;
; !! SEULEMENT DES FORMES QUE cc900 EMET DEJA. Les pieges materiel connus de ce
; processeur (docs du projet, fiches) venaient d'encodages que Toshiba n'emet
; pas. `python tools/formes_asm.py` verifie chaque instruction de ce fichier
; contre le code que cc900 genere pour ce projet (build/prof_asm/*.asm).
;
; void id_road_walk_asm(RoadWalk *w);
;
;   (xsp+0) adresse de retour, 4 octets ; (xsp+4) w.
;   cc900 : seul XIZ doit etre preserve (ses fonctions le poussent quand elles
;   s'en servent) ; XWA XBC XDE XHL XIX XIY sont a l'appele.
;
; SECONDE ECRITURE (2026-09-19). La premiere relisait dans le bloc, a chaque
; tranche, sept pointeurs de table et l'accumulateur : 44 500 cycles par tour.
; Celle-ci tient toute la marche en registres :
;
;   XIX = &id_line_of[k]   (descend de 1)   la pente a +SL_GRADE, la bande a +SL_BANDI
;   XIY = &id_shear[k]     (descend de 2)
;   XHL = &xy[ligne]       (descend de 2 par ligne ecrite)
;   XDE = &bande[ligne]    (descend de 2 par ligne ecrite)
;   B   = l'accumulateur   C = la ligne courante (>= top : tient sur un octet)
;   XIZ = &hill_rate[20]   (la cadence, indice signe)
;
; Les valeurs fixes du bloc sont RECOPIEES sur la pile de la routine (F_*) et
; lues par (xsp+d) : c'est ce qui libere XIZ pour la table des cadences.
;
; LES DEUX RETENUES SANS SEIZE BITS. c = (acc + 2 rate) >> 8 et le nouvel
; accumulateur est l'octet bas : c'est exactement le nombre de retenues de deux
; additions de `rate` sur huit bits, et l'octet restant.
;
; LA LIGNE Y. (u8)((row >> 8) - (u8)(scr - plane0)) = (row >> 8) + plane0 - scr
; modulo 256 : les deux formes rendent le meme octet.
;
; LA COULEUR DE BANDE EN DEUX TEMPS. band_col[lut[id_bandi[k]]] demande deux
; pointeurs de table et la marche n'a plus de registre. Elle pose donc l'INDICE
; id_bandi[k] dans l'octet bas de l'entree du tampon de couleur, et une passe
; courte, apres elle, le convertit sur les seules lignes ecrites. Aucun octet de
; RAM de plus : la pile n'en a pas a donner (voir RoadSlices dans id_road.c).
;

; Le bloc RoadWalk (id_road.c ; sa TAILLE y est VERIFIEE a la compilation) :
V_XY      equ 0     ; u16 * &xy[road_bottom]
V_BAND    equ 4     ; u16 * &bandcol[road_bottom]
V_SL      equ 8     ; u8  * &id_line_of[lines]   (juste APRES la fin)
V_SH      equ 12    ; s16 * &id_shear[lines]     (juste APRES la fin)
V_RTAB    equ 16    ; u8  * &hill_rate[20]
V_LUT     equ 20    ; u8  * ligne de band_lut de cette trame
V_BCOL    equ 24    ; u16 * band_col
V_ROW     equ 28    ; u16  row_fx     (8.8)
V_STEP    equ 30    ; u16  step_fx
V_HALF    equ 32    ; u16  (u16)step_fx >> 1
V_TOP     equ 34    ; u8   top_limit        } recopies d'un mot
V_PLANE0  equ 35    ; u8   road_plane0      }
V_BASEX   equ 36    ; u8   road_base_x      } recopies d'un mot
V_N       equ 37    ; u8   entree : lines ; sortie : k + 1
V_LINE    equ 38    ; u8   entree : road_bottom ; sortie : la ligne a l'arret
; Les tableaux voisins de id_line_of (RoadSlices dans id_road.c) :
SL_GRADE  equ 64    ; id_grade[k] = id_line_of[k] + 64
SL_BANDI  equ 128   ; id_bandi[k] = id_line_of[k] + 128
; Le cadre de la routine, sous la sauvegarde de XIZ :
F_ROW     equ 0     ; u16  row_fx (modifie)
F_STEP    equ 2
F_HALF    equ 4
F_TOP     equ 6
F_PLANE0  equ 7
F_BASEX   equ 8
F_N       equ 9     ; le compteur de tranches
F_BOT     equ 10    ; road_bottom
F_SIZE    equ 12
F_W       equ 20    ; w : F_SIZE + XIZ (4) + adresse de retour (4)




_id_road_walk_asm:
        push    xiz
        ld      xwa,(xsp+0x8)           ; w
        lda     xsp,(xsp-F_SIZE)
        ld      bc,(xwa+V_ROW)
        ld      (xsp+F_ROW),bc
        ld      bc,(xwa+V_STEP)
        ld      (xsp+F_STEP),bc
        ld      bc,(xwa+V_HALF)
        ld      (xsp+F_HALF),bc
        ld      bc,(xwa+V_TOP)          ; top et plane0
        ld      (xsp+F_TOP),bc
        ld      bc,(xwa+V_BASEX)        ; base_x et le compteur
        ld      (xsp+F_BASEX),bc
        ld      c,(xwa+V_LINE)          ; la ligne : road_bottom, >= top (le C le verifie)
        ld      (xsp+F_BOT),c
        ld      xhl,(xwa+V_XY)
        ld      xde,(xwa+V_BAND)
        ld      xix,(xwa+V_SL)
        ld      xiy,(xwa+V_SH)
        ld      xiz,(xwa+V_RTAB)
        ld      b,0x0                   ; l'accumulateur part de zero, CHAQUE trame

vw_slice:
        dec     0x1,xix
        dec     0x2,xiy
        ; ou va la tranche : id_line_of[k] = max(ligne, top) = la ligne, puisque
        ; la marche s'arrete des qu'elle passe sous top
        ld      (xix),c
        ; ---- la cadence : hill_rate[20 + id_grade[k]]
        ld      a,(xix+SL_GRADE)
        exts    wa
        ld      a,(xiz+wa)
        ld      w,a
        ; ---- les deux retenues : A = acc + rate + rate, sur huit bits
        ld      a,b
        add     a,w
        jp       ult,vw_c1               ; premiere retenue
        add     a,w
        jp       ult,vw_one              ; une seule retenue : une ligne
        ld      b,a                     ; aucune : la tranche ne prend pas de ligne
        jp       vw_next
vw_c1:
        add     a,w
        jp       ult,vw_two              ; deux retenues : deux lignes
vw_one:
        ld      b,a
        ; ---- une ligne, a la rangee de la tranche
        ld      a,(xsp+F_ROW+1)         ; (u8)(row_fx >> 8)
        add     a,(xsp+F_PLANE0)
        sub     a,c
        ld      w,a
        ld      a,(xiy)                 ; (u8)dx
        add     a,(xsp+F_BASEX)
        ld      (xhl),wa
        ld      a,(xix+SL_BANDI)        ; l'indice de bande, converti plus bas
        ld      (xde),a
        dec     0x2,xhl
        dec     0x2,xde
        dec     0x1,c
        jp       vw_next

vw_two:
        ld      b,a
        ; ---- premiere ligne, a la rangee de la tranche
        ld      a,(xsp+F_ROW+1)
        add     a,(xsp+F_PLANE0)
        sub     a,c
        ld      w,a
        ld      a,(xiy)
        add     a,(xsp+F_BASEX)
        ld      (xhl),wa
        ld      a,(xix+SL_BANDI)
        ld      (xde),a
        dec     0x2,xhl
        dec     0x2,xde
        dec     0x1,c
        ; ---- seconde ligne, seulement si elle reste sur l'ecran, a mi-marche
        cp      c,(xsp+F_TOP)
        jp       ult,vw_next
        ld      wa,(xsp+F_ROW)
        cp      wa,(xsp+F_HALF)
        jp       ule,vw_mid              ; row_fx <= half : pas sous la rangee 0
        sub     wa,(xsp+F_HALF)
vw_mid:
        ld      a,w                     ; (u8)(mid >> 8)
        add     a,(xsp+F_PLANE0)
        sub     a,c
        ld      w,a
        ld      a,(xiy)
        add     a,(xsp+F_BASEX)
        ld      (xhl),wa
        ld      a,(xix+SL_BANDI)
        ld      (xde),a
        dec     0x2,xhl
        dec     0x2,xde
        dec     0x1,c

vw_next:
        ; TOUJOURS, meme pour une tranche qui n'a pris aucune ligne
        ld      wa,(xsp+F_STEP)
        sub     (xsp+F_ROW),wa
        cp      c,(xsp+F_TOP)
        jp       ult,vw_done             ; plus d'ecran : le compteur reste k + 1
        decb    0x1,(xsp+F_N)
        jp       ne,vw_slice             ; au bout : 0, soit k = -1

vw_done:
        ; ---- les indices de bande deviennent des couleurs, lignes C+1..bas.
        ; XDE pointe l'entree de la ligne C (la prochaine qu'on aurait ecrite).
        ld      a,(xsp+F_BOT)
        sub     a,c
        jp       eq,vw_conv_done         ; aucune ligne ecrite
        ld      b,a
        ld      xwa,(xsp+F_W)
        ld      xix,(xwa+V_LUT)
        ld      xiy,(xwa+V_BCOL)
vw_conv:
        inc     0x2,xde
        ld      a,(xde)
        extz    wa
        ld      a,(xix+wa)
        extz    wa
        add     wa,wa
        ld      wa,(xiy+wa)
        ld      (xde),wa
        dec     0x1,b                   ; huit bits : DEC pose les drapeaux
        jp       ne,vw_conv
vw_conv_done:
        ld      xwa,(xsp+F_W)
        ld      (xwa+V_LINE),c
        ; !! PAS PAR A : A est l'octet bas de XWA, qui tient le bloc. Une
        ; premiere version faisait `ld a,(xsp+F_N)` ici et ecrivait le
        ; compteur a 0x..00+37, dans la pile.
        ld      b,(xsp+F_N)
        ld      (xwa+V_N),b
        lda     xsp,(xsp+F_SIZE)
        pop     xiz
        ret

; ================================================================
; void id_road_ahead_asm(RoadAhead *a);
;
; build_road_ahead() de main.c : pour chaque tranche, du pare-chocs vers
; l'horizon, avancer sur le profil jusqu'a la distance que la tranche regarde,
; puis rendre le virage et la pente a cette distance, joints arrondis. La
; version C reste dans main.c (ID_ROAD_AHEAD_C=1) ; tools/equivalence.py prouve
; que les deux rendent la meme RAM, tour par tour, sur les dix circuits.
;
; Registres pendant la boucle :
;   XIX = &ahead[k]            (descend de 2)
;   XHL = &road_bend[k]        (descend de 2)
;   XBC = &id_grade[k]         (descend de 1 ; id_road_grade_buf)
;   XIY = sc, le segment courant
;   DE  = into, la position dans ce segment
;   XIZ = le bloc (ci-dessous)
;
; SECONDE ECRITURE (2026-09-19) : DEUX CACHES PAR SEGMENT, valables un appel.
; Profil par bloc : le fondu aux jonctions coutait 10 000 cycles par tour et la
; borne de pente + grade_tab 8 000, refaits a CHAQUE tranche alors qu'ils ne
; dependent que du SEGMENT tant qu'on y reste :
;   - la pente a plat d'un segment, bornee et convertie, est la meme pour
;     toutes ses tranches (cle A_FKEY) ;
;   - un fondu melange le segment courant et un voisin avec un poids w : les
;     deux ecarts (voisin - courant, virage et pente) ne dependent que du
;     segment et du cote (cles A_NKEY, A_PKEY). Il ne reste par tranche que les
;     deux multiplications, et la seconde saute quand les deux pentes sont
;     egales -- le cas de toute route plate.
; Les cles sont le numero du segment ; 0xFF = vide (track_len est un u8, un
; numero vaut au plus 254). Le C les vide avant chaque appel.
;
; Le bloc RoadAhead (main.c ; taille VERIFIEE a la compilation) :
A_AHEAD  equ 0      ; const u16 * &ahead[lines]            (juste APRES la fin)
A_BEND   equ 4      ; s16 *       &road_bend[lines]
A_GL     equ 8      ; s8 *        &id_grade[lines]
A_SEG    equ 12     ; const Segment * track_seg
A_GTAB   equ 16     ; const s8 *  &grade_tab[HILL_SLOPE_MAX]  (indice signe)
A_SC     equ 20     ; const Segment * &track_seg[seg_index]
A_INTO   equ 24     ; u16 seg_pos
A_W      equ 26     ; u16 want (temporaire, traversee de segments)
A_K      equ 28     ; u8  lignes (> 0)
A_CUR    equ 29     ; u8  seg_index
A_LEN    equ 30     ; u8  track_len
A_FKEY   equ 31     ; u8  segment de la pente a plat en cache (0xFF = vide)
A_FG     equ 32     ; s8  cette pente, bornee et convertie
A_NKEY   equ 33     ; u8  segment du fondu vers le SUIVANT en cache
A_PKEY   equ 34     ; u8  ... vers le PRECEDENT
A_NDB    equ 36     ; s16 suivant->bend - bend
A_NDP    equ 38     ; s16 suivant->slope - slope
A_PDB    equ 40     ; s16 precedent->bend - bend
A_PDP    equ 42     ; s16 precedent->slope - slope
; Segment : span u16 +0, bend s16 +2, slope s8 +4, six octets.


_id_road_ahead_asm:
        push    xiz
        ld      xiz,(xsp+0x8)
        ld      xix,(xiz+A_AHEAD)
        ld      xhl,(xiz+A_BEND)
        ld      xbc,(xiz+A_GL)
        ld      xiy,(xiz+A_SC)
        ld      de,(xiz+A_INTO)
        ; la PREMIERE tranche : walked vaut 0
        dec     0x2,xix
        dec     0x2,xhl
        dec     0x1,xbc
        ld      wa,(xix)
        jp       ah_want

_id_road_ahead_asm__L1:
ah_slice:
        dec     0x2,xix
        dec     0x2,xhl
        dec     0x1,xbc
        ; want = ahead[k] - walked, et walked est ahead[k+1] : la tranche
        ; d'avant, deux octets plus haut dans le meme tableau
        ld      wa,(xix)
        sub     wa,(xix+0x2)
_id_road_ahead_asm__L2:
ah_want:
        ; LE CAS COURANT SANS MEMOIRE : into += want, et si ca reste dans le
        ; segment, c'est fini. (u16)(into + want) >= span se lit sur DE lui-meme.
        add     de,wa
        cp      de,(xiy)
        jp       ult,ah_seg_ok
        sub     de,wa                   ; on defait, et on marche segment par segment
        ld      (xiz+A_W),wa
_id_road_ahead_asm__L3:
ah_seg:
        ld      wa,de
        add     wa,(xiz+A_W)
        cp      wa,(xiy)
        jp       ult,ah_seg_last
        ld      wa,(xiy)                ; want -= span - into
        sub     wa,de                   ; (formes emises par cc900 ; l'ancien
        sub     (xiz+A_W),wa            ;  `sub wa,(xiy)` n'en etait pas une)
        ld      a,(xiz+A_CUR)           ; le voisin SANS modulo
        inc     0x1,a
        cp      a,(xiz+A_LEN)
        jp       ult,ah_cur_ok
        ld      a,0x0
ah_cur_ok:
        ld      (xiz+A_CUR),a
        extz    wa
        muls    xwa,0x6
        ld      xiy,(xiz+A_SEG)
        lda     xiy,(xiy+wa)
        ld      de,0x0
        jp       ah_seg
ah_seg_last:
        add     de,(xiz+A_W)            ; into += want
_id_road_ahead_asm__L4:
ah_seg_ok:
        ; rem = span - into
        ld      wa,(xiy)
        sub     wa,de
        cp      wa,de
        jp       ugt,ah_prev             ; pas (rem <= into)
        cp      wa,0x80
        jp       uge,ah_prev             ; pas (rem < BEND_HALF)
        neg     wa                      ; w = BEND_HALF - rem
        add     wa,0x80
        push    xde
        ld      de,wa                   ; DE = w pendant le fondu
        ld      a,(xiz+A_CUR)
        cp      a,(xiz+A_NKEY)
        jp       eq,ah_nhit
        ; ---- les ecarts vers le SUIVANT, une fois par segment
        ld      (xiz+A_NKEY),a
        inc     0x1,a                   ; other = cursor + 1, sans modulo
        cp      a,(xiz+A_LEN)
        jp       ult,ah_nseg
        ld      a,0x0
ah_nseg:
        extz    wa
        muls    xwa,0x6
        push    xiy
        ld      xiy,(xiz+A_SEG)
        lda     xiy,(xiy+wa); XIY = sn
        ld      wa,(xiy+0x2)
        ld      (xiz+A_NDB),wa
        ld      a,(xiy+0x4)
        exts    wa
        ld      (xiz+A_NDP),wa
        pop     xiy                     ; XIY = sc
        ld      wa,(xiy+0x2)
        sub     (xiz+A_NDB),wa          ; (s16)(sn->bend - b)
        ld      a,(xiy+0x4)
        exts    wa
        sub     (xiz+A_NDP),wa          ; (s16)sn->slope - p
_id_road_ahead_asm__L5:
ah_nhit:
        ; road_bend[k] = b + (s16)(((s16)(sn->bend - b) * (s16)w) >> 8)
        ld      wa,(xiz+A_NDB)
        muls    xwa,de
        sra     0x8,wa
        add     wa,(xiy+0x2)
        ld      (xhl),wa
        ld      wa,(xiz+A_NDP)
        jp       ah_blend_slope

_id_road_ahead_asm__L6:
ah_prev:
        cp      de,0x80
        jp       uge,ah_flat             ; loin des deux joints : le cas courant
        ld      wa,de                   ; w = BEND_HALF - into
        neg     wa
        add     wa,0x80
        push    xde
        ld      de,wa                   ; DE = w pendant le fondu
        ld      a,(xiz+A_CUR)
        cp      a,(xiz+A_PKEY)
        jp       eq,ah_phit
        ; ---- les ecarts vers le PRECEDENT, une fois par segment
        ld      (xiz+A_PKEY),a
        cp      a,0x0                   ; other = cursor ? cursor - 1 : len - 1
        jp       ne,ah_prev_dec
        ld      a,(xiz+A_LEN)
ah_prev_dec:
        dec     0x1,a
        extz    wa
        muls    xwa,0x6
        push    xiy
        ld      xiy,(xiz+A_SEG)
        lda     xiy,(xiy+wa); XIY = sn
        ld      wa,(xiy+0x2)
        ld      (xiz+A_PDB),wa
        ld      a,(xiy+0x4)
        exts    wa
        ld      (xiz+A_PDP),wa
        pop     xiy                     ; XIY = sc
        ld      wa,(xiy+0x2)
        sub     (xiz+A_PDB),wa
        ld      a,(xiy+0x4)
        exts    wa
        sub     (xiz+A_PDP),wa
_id_road_ahead_asm__L7:
ah_phit:
        ld      wa,(xiz+A_PDB)
        muls    xwa,de
        sra     0x8,wa
        add     wa,(xiy+0x2)
        ld      (xhl),wa
        ld      wa,(xiz+A_PDP)
ah_blend_slope:
        ; sl = (s8)(p + (s16)(((s16)(sn->slope - p) * (s16)w) >> 8))
        cp      wa,0x0
        jp       eq,ah_blend_flat        ; meme pente des deux cotes : sl = p
        muls    xwa,de
        sra     0x8,wa
        add     a,(xiy+0x4)             ; (s8) : l'octet bas de la somme suffit
        pop     xde
        jp       ah_clamp
ah_blend_flat:
        pop     xde
        jp       ah_grade_flat

_id_road_ahead_asm__L8:
ah_flat:
        ld      wa,(xiy+0x2)            ; road_bend[k] = b
        ld      (xhl),wa
ah_grade_flat:
        ; la pente du segment, bornee et convertie UNE fois par segment
        ld      a,(xiz+A_CUR)
        cp      a,(xiz+A_FKEY)
        jp       ne,ah_fmiss
        ld      a,(xiz+A_FG)
        jp       ah_store
ah_fmiss:
        ld      (xiz+A_FKEY),a
        ld      a,(xiy+0x4)             ; sl = (s8)p
        cp      a,0x6
        jp       le,ah_fclamp_hi
        ld      a,0x6
ah_fclamp_hi:
        cp      a,0xfa
        jp       ge,ah_fclamp_lo
        ld      a,0xfa
ah_fclamp_lo:
        push    xiy
        ld      xiy,(xiz+A_GTAB)
        exts    wa
        ld      a,(xiy+wa)
        pop     xiy
        ld      (xiz+A_FG),a
        jp       ah_store

_id_road_ahead_asm__L9:
ah_clamp:
        ; la pente mise a l'echelle de la planche : grade_tab[clamp(sl) + 6]
        cp      a,0x6
        jp       le,ah_clamp_hi
        ld      a,0x6
ah_clamp_hi:
        cp      a,0xfa
        jp       ge,ah_clamp_lo
        ld      a,0xfa
ah_clamp_lo:
        push    xiy
        ld      xiy,(xiz+A_GTAB)
        exts    wa
        ld      a,(xiy+wa)
        pop     xiy
ah_store:
        ld      (xbc),a
        decb    0x1,(xiz+A_K)
        jp       ne,ah_slice
        pop     xiz
        ret

; ================================================================
; void id_road_shear_asm(RoadShearWalk *s);
;
; Le cisaillement de chaque tranche, en tete de id_road_write() :
;   dx = (s16)((lateral * w_lat[k]) >> 8) + curve_dx[k], borne a [min, max].
; Le C reste dans id_road.c (ID_ROAD_SHEAR_C=1). cc900 y relisait sur la pile,
; a chaque tranche, trois des cinq pointeurs et le deplacement lateral : 13 200
; cycles par tour, le plus gros bloc C restant (2026-09-19).
;
;   XIX = &id_w_lat[k]      (monte de 1)
;   XIY = &id_curve_dx[k]   (monte de 2)
;   XHL = &id_dx_max[k]     (monte de 2) ; id_dx_min[k] est a -128 (RoadClamp)
;   XBC = &id_shear[k]      (monte de 2)
;   IZ  = lateral           (xsp+0) = tranches restantes
S_W      equ 0      ; const u8  * id_w_lat
S_CV     equ 4      ; const s16 * id_curve_dx
S_MX     equ 8      ; const s16 * id_dx_max  (id_dx_min = id_dx_max - 128)
S_SH     equ 12     ; s16 *       id_shear
S_LAT    equ 16     ; s16  lateral
S_N      equ 18     ; u16  lignes (> 0, < 256)
RC_MIN   equ 0x80   ; id_dx_max - id_dx_min, en octets (RoadClamp)


_id_road_shear_asm:
        push    xiz
        ld      xwa,(xsp+0x8)
        ld      xix,(xwa+S_W)
        ld      xiy,(xwa+S_CV)
        ld      xhl,(xwa+S_MX)
        ld      xbc,(xwa+S_SH)
        ld      iz,(xwa+S_LAT)
        ld      de,(xwa+S_N)
        push    de                      ; le compteur, en (xsp)
sh_loop:
        ld      e,(xix+)
        extz    de
        muls    xde,iz
        sra     0x8,xde                 ; (lateral * w) >> 8 on 32 bits (SUNSET RUN: |lateral| > 128)
        ld      wa,(xiy+)
        add     wa,de
        cp      wa,(xhl)
        jp       gt,sh_hi                ; dx > max
        cp      wa,(xhl-RC_MIN)
        jp       ge,sh_st
        ld      wa,(xhl-RC_MIN)         ; dx < min
        jp       sh_st
sh_hi:
        ld      wa,(xhl)
sh_st:
        ld      (xbc+),wa
        inc     0x2,xhl
        decb    0x1,(xsp)
        jp       ne,sh_loop
        pop     de
        pop     xiz
        ret

; ================================================================
; void id_road_curve_asm(RoadCurve *c);
;
; La double integration de id_road_frame_ahead() : la courbure de chaque
; tranche, du pare-chocs vers l'horizon, sommee deux fois -- le cap, puis le
; deplacement lateral. Le C reste dans id_road.c (ID_ROAD_CURVE_C=1).
;
;   XIX = &bend[k] (descend de 2)   XIY = &id_curve_dx[k] (descend de 2)
;   DE  = id_curve_cm               BC  = slope      HL = acc      IZ = k
C_BEND   equ 0      ; const s16 * &bend[lines]
C_OUT    equ 4      ; s16 *       &id_curve_dx[lines]
C_CM     equ 8      ; u16 id_curve_cm
C_N      equ 10     ; u16 lignes (> 0)


_id_road_curve_asm:
        push    xiz
        ld      xiz,(xsp+0x8)
        ld      xix,(xiz+C_BEND)
        ld      xiy,(xiz+C_OUT)
        ld      de,(xiz+C_CM)
        ld      iz,(xiz+C_N)
        ld      bc,0x0
        ld      hl,0x0
        ; (Un cache "meme virage que la tranche d'avant, meme c" a ete essaye
        ; le 2026-09-19 : 71 a 76 % de tranches repetees, et ZERO cycle gagne
        ; mesure -- la comparaison en memoire et le saut pris coutent ce que la
        ; multiplication coutait. Retire.)
cv_loop:
        dec     0x2,xix
        ld      wa,(xix)                ; b
        cp      wa,0x0
        jp       ge,cv_pos
        neg     wa                      ; mag = -b
        mul     xwa,de                  ; (u16)mag * cm, 16 bits gardes
        add     wa,0x80
        srl     0x8,wa                  ; c
        neg     wa                      ; b < 0 : -c
        jp       cv_have
cv_pos:
        mul     xwa,de
        add     wa,0x80
        srl     0x8,wa
cv_have:
        add     bc,wa                   ; slope += c
        add     hl,bc                   ; acc += slope
        ld      wa,hl
        sra     0x8,wa
        dec     0x2,xiy
        ld      (xiy),wa                ; id_curve_dx[k] = acc >> 8
        sub     iz,0x1                  ; SUB pose les drapeaux (DEC 16 bits non)
        jp       ne,cv_loop
        pop     xiz
        ret

; ---- src/spr_cells_asm.asm
; spr_cells_asm.asm - write a list of 8x8 sprite cells to the K2GE sprite table
;
; SUNSET RUN.  The car, the traffic and the roadside objects are all drawn as
; lists of {cx, cy, ch} cells; this loop replaces three copies of the same C
; loop (the hottest code of a frame).  asm900 syntax, also assembled by the
; open toolchain.
;
; void spr_cells_asm(SprJob *j);
;   (xsp+0) return address, (xsp+4) j.  Preserves XIZ (cc900 convention).
;

J_CELLS  equ 0      ; const u8 *   cells, 3 bytes each: cx, cy, ch
J_MAP    equ 4      ; const u16 *  tile per ch (when J_HASMAP != 0)
J_BASE   equ 8      ; u16          tile = base + ch (when J_HASMAP == 0)
J_X      equ 10     ; s16          left edge of the cell grid
J_Y      equ 12     ; u8           top of the cell grid
J_N      equ 13     ; u8           number of cells
J_WM1    equ 14     ; u8           grid width - 1 (mirroring)
J_ATTR   equ 15     ; u8           flip bits | priority bits
J_PAL    equ 16     ; u8           palette
J_SPR    equ 17     ; u8           next free sprite (in/out)
J_END    equ 18     ; u8           first sprite NOT to use
J_FLIP   equ 19     ; u8           != 0 : mirror the cell columns
J_HASMAP equ 20     ; u8




_spr_cells_asm:
        push    xiz
        ld      xiz,(xsp+0x8)
        ld      xix,(xiz+J_CELLS)
        ld      c,(xiz+J_SPR)
        ld      b,(xiz+J_N)
        cp      b,0x0
        jp      z,sc_done
sc_loop:
        cp      c,(xiz+J_END)
        jp      nc,sc_done
        ld      a,(xix)                 ; cx
        cpb     (xiz+J_FLIP),0x0
        jr      z,sc_noflip
        ld      e,a
        ld      a,(xiz+J_WM1)
        sub     a,e
sc_noflip:
        extz    wa
        sll     0x3,wa
        add     wa,(xiz+J_X)            ; sx
        ld      de,wa
        add     de,0x8
        cp      de,0xb0                 ; -8 <= sx <= 167
        jr      nc,sc_next
        ; HL = 0x8800 + spr * 4
        ld      l,c
        extz    hl
        sll     0x2,hl
        add     hl,0x8800
        extz    xhl
        ld      (xhl+0x2),a             ; x (low byte of sx)
        ld      a,(xix+0x1)             ; cy * 8 + y
        sll     0x3,a
        add     a,(xiz+J_Y)
        ld      (xhl+0x3),a
        ld      e,(xix+0x2)             ; ch
        extz    de
        cpb     (xiz+J_HASMAP),0x0
        jr      z,sc_base
        add     de,de
        ld      xiy,(xiz+J_MAP)
        ld      de,(xiy+de)
        jr      sc_tile
sc_base:
        add     de,(xiz+J_BASE)
sc_tile:
        ld      (xhl),e                 ; tile, low 8 bits
        ld      a,d
        and     a,0x1
        or      a,(xiz+J_ATTR)
        ld      (xhl+0x1),a
        ; palette: 0x8C00 + spr
        ld      l,c
        extz    hl
        add     hl,0x8c00
        extz    xhl
        ld      a,(xiz+J_PAL)
        ld      (xhl),a
        inc     0x1,c
sc_next:
        inc     0x3,xix
        dec     0x1,b
        jp      nz,sc_loop
sc_done:
        ld      (xiz+J_SPR),c
        pop     xiz
        ret

	align 2
_gfx_logo_tiles__0:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,85,5,85,5,255,85,170,85,165,95,164,90,165,90
	db 0,0,84,85,84,85,244,255,164,170,84,85,0,0,64,85
	db 0,0,84,85,84,85,244,95,164,90,164,90,164,90,164,90
	db 0,0,84,85,84,85,245,95,165,90,175,90,170,90,170,90
	db 0,0,85,85,85,85,255,95,170,90,165,90,164,90,165,90
	db 0,0,85,85,85,85,255,95,170,90,90,85,90,0,90,0
	db 0,0,84,85,84,85,244,255,164,170,84,165,0,164,0,164
	db 0,0,64,85,64,85,84,255,84,170,244,90,164,90,164,90
	db 165,90,175,85,170,5,85,5,0,0,85,85,85,85,255,95
	db 64,85,84,255,84,170,244,90,164,90,164,90,164,90,84,250
	db 164,90,164,90,164,90,164,90,164,90,165,90,165,90,175,85
	db 164,90,164,90,164,90,164,90,164,90,164,90,164,90,84,250
	db 170,90,165,90,165,90,165,90,165,90,165,90,164,90,164,90
	db 164,90,164,250,164,170,164,170,164,170,164,90,164,90,164,90
	db 165,90,175,90,170,90,165,90,164,90,165,90,165,90,175,90
	db 64,85,64,255,64,170,64,85,0,0,84,85,84,85,244,255
	db 90,0,90,0,90,0,90,0,90,0,90,0,90,0,90,0
	db 0,164,0,164,0,164,0,164,0,164,0,164,0,164,0,164
	db 165,90,175,90,170,90,170,90,170,90,165,90,165,90,165,90
	db 164,90,84,250,64,170,64,165,64,165,84,175,84,170,244,90
	db 170,90,85,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 64,170,64,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 170,5,85,5,0,0,0,0,0,0,0,0,0,0,0,0
	db 164,90,84,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 164,170,84,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 90,0,85,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,164,0,84,0,0,0,0,0,0,0,0,0,0,0,0
_gfx_logo_map__0:
	db 1,2,3,3,4,3,1,2,5,2,6,7,0,0,5,8
	db 3,3,4,3,9,10,11,12,13,14,9,10,15,16,17,18
	db 0,0,19,20,11,12,13,14,21,22,23,22,24,24,21,22
	db 21,25,26,27,0,0,24,24,23,22,24,24
_stage_time__0:
	db 74,58,56,54,52,71,55,53,51,49
_S0_0:
	db 84,85,82,66,79,32,83,85,78,83,69,84,0
_S0_1:
	db 78,69,79,78,32,72,73,71,72,87,65,89,0
_S0_2:
	db 67,79,65,83,84,76,73,78,69,32,82,85,83,72,0
_S0_3:
	db 83,73,76,69,78,67,73,79,0
	align 2
_station_name__0:
	dd _S0_0
	dd _S0_1
	dd _S0_2
	dd _S0_3
_S0_4:
	db 69,65,83,89,0
_S0_5:
	db 78,79,82,77,65,76,0
_S0_6:
	db 72,65,82,68,0
_S0_7:
	db 70,82,69,69,0
	align 2
_diff_name__0:
	dd _S0_4
	dd _S0_5
	dd _S0_6
	dd _S0_7
_diff_pal__0:
	db 8,0,2,15
_S0_8:
	db 67,79,78,71,82,65,84,85,76,65,84,73,79,78,83,0
_S0_9:
	db 71,79,65,76,33,0
_S0_10:
	db 69,88,84,69,78,68,69,68,32,80,76,65,89,0
_S0_11:
	db 67,72,69,67,75,80,79,73,78,84,33,0
_lv__0_L353:
	db 1,2,3,4,4,4,4,3,3,2,1,0
_emblem_pal_slot__0:
	db 2,3,4,5,6,8,9,10,11,12,13,14,15
_over_pal_slot__0:
	db 4,5,6,10,11,12,13,14
_S0_12:
	db 72,73,0
_S0_13:
	db 66,58,78,69,87,0
_tsm__0_L585:
	db 1,125,126,127
_S0_14:
	db 80,82,69,83,83,32,65,32,84,79,32,83,84,65,82,84
	db 0
_S0_15:
	db 89,79,85,32,77,65,68,69,32,73,84,33,0
_S0_16:
	db 71,65,77,69,32,79,86,69,82,0
_S0_17:
	db 83,67,79,82,69,0
_S0_18:
	db 82,79,85,84,69,0
_S0_19:
	db 78,69,87,32,72,73,71,72,32,83,67,79,82,69,33,0
	align 2
_smoke_tiles__0:
	db 90,0,175,6,255,26,255,107,255,107,255,26,170,5,85,0
	db 0,148,0,233,64,250,144,254,165,255,164,254,80,170,0,85
	db 5,0,107,1,255,6,255,27,255,111,255,107,170,22,85,1
	db 0,148,0,229,64,250,144,255,144,255,149,254,80,170,0,85
_smoke_slot__0:
	db 1,125,126,127
_S0_20:
	db 80,65,85,83,69,0
_S0_21:
	db 84,73,77,69,32,85,80,0
_S0_22:
	db 98,32,76,69,70,84,32,32,32,32,82,73,71,72,84,32
	db 99,0
_S0_23:
	db 82,73,71,72,84,32,99,0
_S0_24:
	db 98,32,76,69,70,84,0
_S0_25:
	db 71,79,65,76,32,65,72,69,65,68,0
_S0_26:
	db 51,0
_S0_27:
	db 50,0
_S0_28:
	db 49,0
_S0_29:
	db 71,79,33,0
	align 2
_cd__0_L896:
	dd _S0_26
	dd _S0_27
	dd _S0_28
	dd _S0_29
_S0_30:
	db 83,84,65,82,84,0
_S0_31:
	db 70,73,78,73,83,72,0
	align 2
_leg0_seg__1:
	db 132,3,0,0,0,0,88,2,0,0,255,0,244,1,0,0
	db 0,0,244,1,238,255,0,0,32,3,0,0,0,0,244,1
	db 0,0,0,0,94,1,189,255,0,0,144,1,0,0,0,0
	db 144,1,203,255,0,0,144,1,0,0,0,0,94,1,189,255
	db 0,0,150,0,0,0,0,0,94,1,59,0,0,0,244,1
	db 238,255,0,0,32,3,0,0,0,0,144,1,18,0,2,0
	db 144,1,238,255,255,0,88,2,0,0,0,0,188,2,238,255
	db 0,0,188,2,18,0,254,0,32,3,238,255,0,0,144,1
	db 0,0,255,0,144,1,0,0,255,0,244,1,59,0,0,0
	db 96,9,0,0,0,0
	align 2
_leg1_seg__1:
	db 132,3,0,0,0,0,144,1,0,0,254,0,144,1,0,0
	db 0,0,144,1,70,0,0,0,88,2,46,0,0,0,188,2
	db 224,255,0,0,244,1,0,0,254,0,244,1,0,0,254,0
	db 244,1,62,0,0,0,144,1,0,0,0,0,244,1,200,255
	db 0,0,144,1,20,0,2,0,144,1,0,0,0,0,244,1
	db 56,0,0,0,88,2,32,0,0,0,188,2,46,0,0,0
	db 144,1,0,0,0,0,144,1,56,0,0,0,88,2,32,0
	db 0,0,188,2,26,0,0,0,144,1,216,255,0,0,144,1
	db 0,0,0,0,144,1,56,0,0,0,100,0,0,0,0,0
	db 144,1,186,255,0,0,96,9,0,0,0,0
	align 2
_leg2_seg__1:
	db 132,3,0,0,0,0,32,3,0,0,3,0,144,1,227,255
	db 254,0,244,1,22,0,2,0,244,1,0,0,2,0,94,1
	db 71,0,0,0,150,0,0,0,0,0,94,1,193,255,0,0
	db 88,2,234,255,255,0,244,1,208,255,0,0,244,1,0,0
	db 252,0,144,1,185,255,0,0,100,0,0,0,0,0,144,1
	db 63,0,0,0,32,3,212,255,0,0,244,1,0,0,0,0
	db 244,1,57,0,0,0,244,1,0,0,252,0,144,1,63,0
	db 0,0,144,1,193,255,0,0,144,1,208,255,1,0,144,1
	db 0,0,0,0,94,1,63,0,0,0,244,1,0,0,254,0
	db 144,1,199,255,0,0,32,3,35,0,0,0,96,9,0,0
	db 0,0
	align 2
_leg3_seg__1:
	db 132,3,0,0,0,0,244,1,0,0,2,0,44,1,196,255
	db 0,0,100,0,0,0,0,0,44,1,68,0,0,0,244,1
	db 224,255,0,0,32,3,32,0,0,0,144,1,0,0,0,0
	db 144,1,196,255,0,0,100,0,0,0,0,0,144,1,54,0
	db 0,0,32,3,0,0,0,0,144,1,26,0,0,0,188,2
	db 235,255,0,0,244,1,0,0,0,0,94,1,60,0,0,0
	db 144,1,0,0,0,0,94,1,60,0,0,0,94,1,202,255
	db 0,0,244,1,21,0,0,0,144,1,0,0,0,0,94,1
	db 188,255,0,0,100,0,0,0,0,0,94,1,60,0,0,0
	db 188,2,230,255,0,0,244,1,0,0,0,0,188,2,21,0
	db 255,0,96,9,0,0,0,0
	align 2
_leg4_seg__1:
	db 132,3,0,0,0,0,244,1,0,0,0,0,244,1,204,255
	db 0,0,244,1,0,0,0,0,144,1,204,255,0,0,144,1
	db 0,0,0,0,144,1,0,0,0,0,244,1,57,0,0,0
	db 144,1,23,0,0,0,144,1,0,0,0,0,144,1,65,0
	db 0,0,32,3,0,0,0,0,88,2,20,0,0,0,88,2
	db 238,255,0,0,88,2,18,0,0,0,244,1,18,0,0,0
	db 144,1,0,0,0,0,144,1,0,0,255,0,94,1,191,255
	db 0,0,244,1,0,0,0,0,44,1,65,0,0,0,44,1
	db 204,255,0,0,244,1,0,0,0,0,188,2,20,0,0,0
	db 96,9,0,0,0,0
	align 2
_leg5_seg__1:
	db 132,3,0,0,0,0,32,3,28,0,0,0,144,1,0,0
	db 1,0,144,1,0,0,2,0,244,1,190,255,0,0,144,1
	db 0,0,0,0,144,1,66,0,0,0,32,3,238,255,0,0
	db 144,1,232,255,0,0,244,1,0,0,0,0,94,1,198,255
	db 0,0,32,3,238,255,255,0,88,2,237,255,0,0,244,1
	db 18,0,0,0,188,2,232,255,0,0,144,1,0,0,254,0
	db 144,1,190,255,0,0,144,1,0,0,2,0,94,1,53,0
	db 0,0,150,0,0,0,0,0,94,1,190,255,0,0,244,1
	db 0,0,0,0,144,1,24,0,0,0,244,1,0,0,1,0
	db 96,9,0,0,0,0
	align 2
_leg6_seg__1:
	db 132,3,0,0,0,0,32,3,220,255,255,0,88,2,41,0
	db 2,0,244,1,0,0,0,0,144,1,187,255,0,0,144,1
	db 0,0,0,0,144,1,0,0,254,0,144,1,195,255,0,0
	db 32,3,23,0,253,0,144,1,41,0,0,0,244,1,23,0
	db 3,0,144,1,227,255,254,0,144,1,0,0,253,0,144,1
	db 55,0,0,0,88,2,238,255,1,0,244,1,0,0,3,0
	db 144,1,55,0,0,0,144,1,0,0,255,0,144,1,69,0
	db 0,0,144,1,0,0,0,0,44,1,187,255,0,0,150,0
	db 0,0,0,0,44,1,55,0,0,0,244,1,0,0,0,0
	db 94,1,187,255,0,0,150,0,0,0,0,0,94,1,69,0
	db 0,0,96,9,0,0,0,0
	align 2
_leg7_seg__1:
	db 132,3,0,0,0,0,244,1,0,0,0,0,44,1,56,0
	db 0,0,44,1,194,255,0,0,144,1,0,0,0,0,244,1
	db 0,0,1,0,94,1,62,0,0,0,94,1,186,255,0,0
	db 144,1,0,0,254,0,144,1,186,255,0,0,100,0,0,0
	db 0,0,144,1,56,0,0,0,144,1,0,0,0,0,244,1
	db 200,255,0,0,244,1,0,0,0,0,94,1,62,0,0,0
	db 32,3,236,255,0,0,244,1,0,0,1,0,94,1,56,0
	db 0,0,144,1,0,0,3,0,94,1,200,255,0,0,94,1
	db 62,0,0,0,144,1,230,255,0,0,144,1,0,0,2,0
	db 144,1,186,255,0,0,32,3,210,255,0,0,144,1,0,0
	db 255,0,44,1,62,0,0,0,100,0,0,0,0,0,44,1
	db 200,255,0,0,96,9,0,0,0,0
	align 2
_leg8_seg__1:
	db 132,3,0,0,0,0,144,1,0,0,0,0,94,1,194,255
	db 0,0,94,1,62,0,0,0,144,1,32,0,0,0,32,3
	db 216,255,0,0,144,1,0,0,1,0,94,1,62,0,0,0
	db 94,1,194,255,0,0,244,1,20,0,1,0,144,1,230,255
	db 2,0,32,3,216,255,0,0,144,1,0,0,0,0,144,1
	db 70,0,0,0,100,0,0,0,0,0,144,1,200,255,0,0
	db 32,3,0,0,1,0,88,2,40,0,0,0,244,1,224,255
	db 0,0,244,1,26,0,0,0,144,1,230,255,254,0,144,1
	db 46,0,0,0,144,1,0,0,0,0,144,1,56,0,0,0
	db 144,1,0,0,0,0,244,1,56,0,0,0,96,9,0,0
	db 0,0
	align 2
_leg9_seg__1:
	db 132,3,0,0,0,0,144,1,0,0,0,0,44,1,59,0
	db 0,0,100,0,0,0,0,0,44,1,189,255,0,0,88,2
	db 32,0,0,0,244,1,0,0,254,0,144,1,189,255,0,0
	db 88,2,0,0,0,0,144,1,234,255,0,0,244,1,0,0
	db 0,0,244,1,189,255,0,0,244,1,0,0,0,0,244,1
	db 53,0,0,0,144,1,0,0,0,0,144,1,197,255,0,0
	db 188,2,18,0,0,0,144,1,0,0,0,0,144,1,59,0
	db 0,0,32,3,22,0,1,0,244,1,0,0,2,0,244,1
	db 0,0,0,0,144,1,189,255,0,0,244,1,0,0,0,0
	db 94,1,197,255,0,0,100,0,0,0,0,0,94,1,67,0
	db 0,0,96,9,0,0,0,0
	align 2
_leg10_seg__1:
	db 132,3,0,0,0,0,244,1,0,0,0,0,94,1,199,255
	db 0,0,150,0,0,0,0,0,94,1,52,0,0,0,244,1
	db 0,0,0,0,94,1,199,255,0,0,150,0,0,0,0,0
	db 94,1,57,0,0,0,244,1,0,0,0,0,94,1,52,0
	db 0,0,144,1,0,0,0,0,188,2,20,0,255,0,88,2
	db 0,0,0,0,244,1,0,0,0,0,244,1,199,255,0,0
	db 88,2,238,255,0,0,188,2,238,255,0,0,244,1,0,0
	db 0,0,94,1,57,0,0,0,94,1,199,255,0,0,244,1
	db 0,0,0,0,44,1,204,255,0,0,150,0,0,0,0,0
	db 44,1,57,0,0,0,32,3,18,0,0,0,144,1,0,0
	db 0,0,144,1,57,0,0,0,100,0,0,0,0,0,144,1
	db 191,255,0,0,96,9,0,0,0,0
	align 2
_leg11_seg__1:
	db 132,3,0,0,0,0,32,3,35,0,254,0,244,1,0,0
	db 255,0,94,1,71,0,0,0,144,1,0,0,0,0,244,1
	db 193,255,0,0,144,1,0,0,1,0,144,1,63,0,0,0
	db 100,0,0,0,0,0,144,1,185,255,0,0,144,1,48,0
	db 0,0,144,1,0,0,254,0,44,1,193,255,0,0,100,0
	db 0,0,0,0,44,1,57,0,0,0,244,1,0,0,0,0
	db 94,1,57,0,0,0,244,1,0,0,0,0,94,1,185,255
	db 0,0,188,2,29,0,1,0,144,1,0,0,0,0,94,1
	db 193,255,0,0,32,3,0,0,1,0,144,1,0,0,255,0
	db 144,1,71,0,0,0,150,0,0,0,0,0,144,1,199,255
	db 0,0,244,1,0,0,2,0,44,1,185,255,0,0,150,0
	db 0,0,0,0,44,1,63,0,0,0,96,9,0,0,0,0
	align 2
_leg12_seg__1:
	db 132,3,0,0,0,0,244,1,0,0,0,0,144,1,201,255
	db 0,0,32,3,0,0,254,0,32,3,23,0,255,0,144,1
	db 0,0,2,0,44,1,69,0,0,0,100,0,0,0,0,0
	db 44,1,195,255,0,0,244,1,0,0,254,0,94,1,55,0
	db 0,0,144,1,0,0,255,0,94,1,69,0,0,0,94,1
	db 201,255,0,0,244,1,0,0,0,0,144,1,69,0,0,0
	db 144,1,0,0,0,0,244,1,195,255,0,0,188,2,18,0
	db 0,0,244,1,0,0,0,0,94,1,55,0,0,0,88,2
	db 215,255,0,0,188,2,215,255,0,0,144,1,0,0,2,0
	db 94,1,69,0,0,0,100,0,0,0,0,0,94,1,187,255
	db 0,0,96,9,0,0,0,0
	align 2
_leg13_seg__1:
	db 132,3,0,0,0,0,244,1,0,0,0,0,144,1,195,255
	db 0,0,144,1,69,0,0,0,244,1,0,0,254,0,94,1
	db 187,255,0,0,244,1,0,0,0,0,244,1,69,0,0,0
	db 244,1,0,0,0,0,144,1,187,255,0,0,100,0,0,0
	db 0,0,144,1,61,0,0,0,144,1,215,255,0,0,244,1
	db 0,0,0,0,244,1,201,255,0,0,144,1,0,0,2,0
	db 94,1,187,255,0,0,94,1,61,0,0,0,244,1,0,0
	db 0,0,94,1,187,255,0,0,144,1,0,0,0,0,44,1
	db 69,0,0,0,150,0,0,0,0,0,44,1,201,255,0,0
	db 144,1,0,0,0,0,94,1,69,0,0,0,144,1,0,0
	db 0,0,144,1,187,255,0,0,144,1,55,0,0,0,96,9
	db 0,0,0,0
	align 2
_leg14_seg__1:
	db 132,3,0,0,0,0,244,1,0,0,1,0,44,1,186,255
	db 0,0,150,0,0,0,0,0,44,1,62,0,0,0,244,1
	db 236,255,0,0,244,1,0,0,0,0,244,1,70,0,0,0
	db 244,1,0,0,0,0,244,1,62,0,0,0,144,1,0,0
	db 0,0,94,1,56,0,0,0,94,1,194,255,0,0,244,1
	db 0,0,0,0,144,1,70,0,0,0,244,1,0,0,0,0
	db 244,1,186,255,0,0,188,2,236,255,1,0,32,3,224,255
	db 254,0,244,1,0,0,0,0,244,1,186,255,0,0,144,1
	db 0,0,2,0,144,1,186,255,0,0,144,1,0,0,2,0
	db 244,1,194,255,0,0,96,9,0,0,0,0
	align 2
_gfx_legs:
	dd _leg0_seg__1
	db 25,0
	dd _leg1_seg__1
	db 26,1
	dd _leg2_seg__1
	db 27,2
	dd _leg3_seg__1
	db 28,3
	dd _leg4_seg__1
	db 25,4
	dd _leg5_seg__1
	db 25,5
	dd _leg6_seg__1
	db 28,6
	dd _leg7_seg__1
	db 31,7
	dd _leg8_seg__1
	db 27,8
	dd _leg9_seg__1
	db 28,9
	dd _leg10_seg__1
	db 31,10
	dd _leg11_seg__1
	db 32,11
	dd _leg12_seg__1
	db 28,12
	dd _leg13_seg__1
	db 30,13
	dd _leg14_seg__1
	db 26,14
	align 2
_gfx_themes:
	db 0,0,0,0,153,10,255,15,153,10,170,11,204,13,255,15
	db 7,1,35,0,1,3,5,0,136,9,255,15,136,9,153,10
	db 187,12,255,15,10,2,25,0,5,2,3,0,152,10,255,15
	db 152,10,169,11,203,13,255,15,11,4,15,0,6,4,4,0
	db 104,9,223,10,104,9,121,10,155,11,223,11,8,1,30,0
	db 3,1,3,0,154,8,255,14,154,8,171,9,205,11,255,14
	db 5,1,45,0,2,7,6,0,152,8,255,15,152,8,169,9
	db 203,11,255,15,6,2,35,0,4,8,10,0,137,8,255,15
	db 137,8,154,9,188,11,255,15,9,3,20,0,9,3,5,0
	db 120,7,255,15,120,7,137,8,171,10,255,15,10,3,20,0
	db 10,2,2,0,153,11,255,15,153,11,170,12,204,14,255,15
	db 10,3,20,0,11,7,5,0,153,8,255,15,153,8,170,9
	db 204,11,255,15,7,2,35,0,12,9,9,0,119,8,255,15
	db 119,8,136,9,170,11,255,15,5,1,50,0,8,3,3,0
	db 137,7,255,14,137,7,154,8,188,10,255,14,11,3,15,0
	db 7,9,7,0,136,10,238,15,136,10,153,11,187,13,238,15
	db 9,2,25,0,13,0,6,0,153,10,255,15,153,10,170,11
	db 204,13,255,15,9,2,25,0,14,4,5,0,153,8,255,14
	db 153,8,170,9,204,11,255,14,10,2,20,0
	align 2
_gfx_leg_ref_cost:
	db 212,3,30,4,211,3,27,4,52,4
	align 2
_gfx_banner_tiles:
	db 85,85,85,85,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,85,85,85,85
	db 208,7,208,7,208,7,208,7,208,7,208,7,208,7,208,7
	db 245,245,245,245,95,95,95,95,245,245,245,245,95,95,95,95
	align 2
_gfx_trophy_tiles:
	db 255,31,170,46,170,190,170,190,170,190,170,190,170,190,170,190
	db 244,255,148,170,149,170,149,170,149,170,149,170,149,170,149,170
	db 170,47,234,3,250,0,62,0,3,0,3,0,3,0,3,0
	db 84,170,64,169,0,165,0,148,0,64,0,64,0,64,0,64
	db 3,0,85,1,250,3,250,3,250,3,250,3,250,3,85,1
	db 0,64,64,85,128,170,128,170,128,170,128,170,128,170,64,85
_gfx_trophy_cells:
	db 0,0,0,1,0,1,0,1,2,1,1,3,0,2,4,1
	db 2,5
	align 2
_gfx_trophy_pal:
	db 0,0,70,0,189,2,255,9
	align 2
_gfx_particle_tiles:
	db 0,3,128,3,176,14,191,254,176,14,128,3,0,3,0,0
	db 0,0,0,0,192,15,160,10,160,2,0,0,0,0,0,0
	db 224,11,248,47,248,42,168,42,160,10,64,1,0,1,64,0
	align 2
_pano_beach_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,255,87,255,95,255,127,187,123,238,110
	db 85,85,85,85,85,85,245,127,253,255,255,255,187,187,238,238
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,213
	db 85,85,89,89,149,149,102,102,170,170,170,170,170,170,170,170
	db 87,85,127,89,255,149,102,102,170,170,170,170,170,170,170,170
	db 255,127,255,255,255,255,102,102,170,170,170,170,170,170,170,170
	db 255,255,255,255,255,255,102,102,170,170,170,170,170,170,170,170
	db 85,245,89,255,213,255,102,102,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,87,85
	db 85,85,85,85,85,85,245,87,255,127,255,255,255,255,255,255
	db 85,85,85,85,85,85,85,85,85,85,85,213,85,213,85,245
	db 85,85,85,85,85,85,85,85,85,85,89,89,149,149,102,102
	db 87,85,87,85,87,85,255,87,255,95,89,89,149,149,102,102
	db 187,187,238,238,170,170,170,170,170,170,85,85,85,85,85,85
	db 255,255,255,255,255,255,255,255,255,255,89,89,149,149,102,102
	db 85,245,85,245,85,247,245,255,253,255,89,89,149,149,102,102
	db 85,85,85,85,85,85,85,85,85,85,89,89,149,149,118,102
	db 85,213,85,253,85,187,85,238,149,170,165,170,169,170,85,85
	db 85,85,85,85,85,85,95,85,255,85,255,87,255,95,255,95
	db 255,95,255,127,255,127,255,255,255,255,255,255,255,255,255,255
	db 85,213,85,245,85,245,245,255,253,255,255,255,255,255,255,255
	db 85,85,95,85,123,85,110,85,170,85,170,86,170,218,85,213
	db 255,255,255,255,187,187,238,238,170,170,170,170,170,170,85,85
	db 85,85,85,85,85,85,85,85,95,85,95,85,127,85,127,85
	db 85,85,85,85,85,95,255,255,255,255,255,255,255,255,255,255
	db 170,170,170,170,170,190,234,255,250,255,254,255,254,255,254,255
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,95,85
	db 255,175,255,175,255,175,255,171,255,170,255,170,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,251,191
	db 170,250,170,250,170,250,170,234,170,234,170,234,170,254,234,255
	db 127,85,127,89,255,151,255,127,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,251,255,254,255,250,255,255,255,255,255
	db 254,255,255,255,255,255,255,255,255,255,235,175,191,250,255,255
	db 85,85,89,89,149,245,102,255,234,255,234,255,250,255,250,255
	db 85,85,89,89,149,149,102,102,170,170,170,170,255,170,255,171
	db 85,85,89,89,149,149,102,102,170,170,170,170,255,234,255,255
	db 85,85,89,89,149,149,102,102,170,170,170,170,170,234,170,250
	db 95,85,95,89,159,149,111,102,171,170,170,170,170,170,170,170
	db 235,255,254,255,255,255,255,255,191,255,255,170,255,255,255,255
	db 175,255,255,170,255,255,255,255,255,255,255,255,255,255,255,255
	db 175,234,255,255,255,255,255,255,255,255,255,255,251,255,254,255
	db 250,255,250,255,250,255,250,255,250,255,250,255,170,255,170,170
	db 85,85,89,89,149,149,102,102,170,170,171,170,171,170,171,170
	db 255,255,255,255,255,190,175,171,186,190,255,191,255,255,255,255
	db 255,255,255,255,255,254,255,251,255,175,255,255,255,255,255,255
	db 255,255,255,255,239,255,250,255,255,255,255,255,255,255,255,255
	db 250,255,234,255,170,255,170,170,170,255,170,255,234,255,234,255
	db 255,191,255,191,255,255,255,255,255,255,254,255,255,255,255,191
	db 255,255,255,255,255,255,255,255,255,255,235,255,175,170,255,255
	db 170,254,170,255,234,255,234,255,234,255,234,255,234,255,170,255
	db 171,170,171,170,171,170,175,170,175,170,175,170,191,170,191,170
	db 170,255,170,255,170,255,234,255,234,255,234,255,250,255,250,255
	db 171,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,255,255,255,255,255,238,238,187,187,170,170,170,170,170,170
	db 234,255,250,255,250,255,234,238,181,187,85,169,85,149,85,85
	db 170,170,170,170,170,170,106,170,85,85,85,85,85,85,85,85
	db 170,170,170,170,170,170,170,170,170,86,90,85,85,85,85,85
	db 255,175,255,186,170,191,238,238,187,187,170,170,170,170,170,170
	db 255,239,255,234,170,191,238,238,187,187,170,170,170,170,170,171
	db 170,254,170,235,170,191,234,238,170,187,170,170,170,170,170,170
	db 191,170,191,170,191,170,238,170,187,170,170,170,170,170,170,170
	db 255,255,255,255,255,255,238,238,187,187,170,170,165,170,85,170
	db 255,255,255,255,255,255,238,238,187,187,170,166,86,85,85,85
	db 250,255,250,255,250,255,238,238,186,187,170,170,170,170,186,170
	db 85,93,117,85,93,85,85,85,85,85,85,85,85,85,0,0
	db 85,85,85,85,85,213,85,87,93,85,85,85,85,85,0,0
	db 149,87,165,87,165,215,169,87,169,87,85,85,85,85,0,0
	db 85,94,149,94,149,222,165,94,173,94,85,85,85,85,0,0
	db 121,93,122,85,122,85,122,85,122,85,85,85,85,85,0,0
	db 85,85,85,85,85,213,85,151,93,149,85,85,85,85,0,0
_pano_beach_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,1,2,3,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,1,2,3,0,0,0,0
	db 4,4,4,4,4,4,4,4,5,6,7,8,4,4,4,4
	db 4,4,4,4,4,4,4,4,5,6,7,8,4,4,4,4
	db 9,9,9,10,11,11,12,9,9,9,9,9,9,9,9,9
	db 9,9,9,10,11,11,12,9,9,9,9,9,9,9,9,9
	db 13,13,13,14,15,16,17,13,13,13,13,13,18,13,13,13
	db 13,13,13,14,15,16,17,13,13,13,13,13,18,13,13,13
	db 19,9,9,9,9,9,9,9,9,9,9,20,21,22,23,24
	db 19,9,9,9,9,9,9,9,9,9,9,20,21,22,23,24
	db 25,26,27,9,9,9,9,9,9,9,28,29,30,31,32,9
	db 25,26,27,9,9,9,9,9,9,9,28,29,30,31,32,9
	db 33,34,35,36,4,4,37,38,39,4,40,41,42,43,44,45
	db 33,34,35,36,4,4,37,38,39,4,40,41,42,43,44,45
	db 46,47,48,49,9,9,50,51,52,9,53,30,30,30,54,55
	db 46,47,48,49,9,9,50,51,52,9,53,30,30,30,54,55
	db 56,56,56,57,58,59,60,61,62,9,63,64,65,56,66,9
	db 56,56,56,57,58,59,60,61,62,9,63,64,65,56,66,9
	db 67,68,67,68,67,68,67,69,67,70,67,68,67,68,71,72
	db 67,68,67,68,67,68,67,69,67,70,67,68,67,68,71,72
_pano_beach_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,7,7,7,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,7,7,7,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,0
	db 0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,4,1,1,1,1,1,1,1,5,1,1,1
	db 1,1,1,1,4,1,1,1,1,1,1,1,5,1,1,1
	db 2,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2
	db 2,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2
	db 2,2,5,1,1,1,1,1,1,1,2,5,4,4,5,1
	db 2,2,5,1,1,1,1,1,1,1,2,5,4,4,5,1
	db 6,4,4,6,6,6,6,6,6,6,6,4,4,4,6,6
	db 6,4,4,6,6,6,6,6,6,6,6,4,4,4,6,6
	db 4,4,4,6,6,6,6,4,6,6,6,4,4,4,6,6
	db 4,4,4,6,6,6,6,4,6,6,6,4,4,4,6,6
	db 4,4,4,4,7,7,4,4,6,6,6,4,4,4,6,6
	db 4,4,4,4,7,7,4,4,6,6,6,4,4,4,6,6
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	align 2
_pano_beach_pals:
	db 223,11,129,14,162,15,202,14,223,11,162,15,180,15,202,14
	db 223,11,180,15,202,14,255,15,223,11,112,11,79,10,255,15
	db 223,11,162,15,202,14,237,15,223,11,162,15,180,15,237,15
	db 223,11,180,15,199,15,237,15,223,11,129,14,199,15,237,15
	align 2
_pano_coast_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,85,85,149,149,89,89
	db 153,153,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 153,153,170,170,170,170,170,170,170,170,170,170,170,170,191,170
	db 170,170,170,170,170,170,170,170,170,170,254,171,255,175,255,255
	db 170,170,170,170,170,170,170,171,234,175,255,191,255,255,255,255
	db 153,153,170,170,170,170,170,191,171,255,255,255,255,255,255,255
	db 153,153,170,170,170,170,170,250,170,254,175,255,255,255,255,255
	db 170,170,170,170,170,170,170,170,170,170,170,250,170,254,255,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 191,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,255,170,170,255,170,255,170,170,170,170,170,170,170,170,170
	db 255,255,255,191,255,255,255,255,170,170,170,170,170,170,170,170
	db 255,255,255,255,255,255,255,255,170,170,170,170,170,170,170,170
	db 255,255,186,254,255,255,255,255,170,170,170,170,170,170,175,234
	db 170,170,170,170,170,234,170,234,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,191,170,191,170
	db 170,170,170,170,170,170,171,170,239,191,255,255,255,255,255,255
	db 170,170,170,170,171,254,175,254,255,255,255,255,255,255,255,255
	db 170,170,170,170,170,234,170,250,170,254,255,255,255,255,255,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,250,190,250
	db 170,170,250,235,255,255,255,255,255,255,255,255,170,170,170,170
	db 149,149,89,89,153,153,170,255,170,255,170,170,170,170,170,170
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 151,149,95,89,191,153,255,175,255,175,170,170,170,170,170,170
	db 191,250,255,255,255,255,255,255,255,255,170,170,170,170,170,170
	db 149,213,89,249,217,255,254,255,254,255,170,170,170,170,170,170
	db 149,149,89,89,153,153,171,170,171,170,170,170,170,170,170,170
	db 151,149,95,89,191,191,255,255,255,255,191,170,170,170,170,170
	db 191,250,255,254,255,255,255,255,255,255,255,255,170,170,170,170
	db 255,234,255,255,255,255,255,255,255,255,255,255,170,170,170,170
	db 170,170,159,174,95,234,87,185,87,253,87,245,87,245,85,213
	db 170,170,174,238,233,222,245,223,245,95,85,127,85,125,85,253
	db 255,255,239,215,239,87,111,86,127,86,126,86,126,86,126,86
	db 170,170,174,174,234,234,181,123,213,127,213,127,85,253,85,245
	db 170,170,174,174,234,234,187,255,255,255,191,175,191,175,191,174
	db 170,170,174,174,234,234,187,187,255,255,255,255,255,255,255,255
	db 170,170,159,174,95,234,87,185,85,253,85,245,85,245,87,213
	db 170,170,174,110,233,126,245,125,245,253,85,245,85,247,85,247
	db 255,255,255,215,254,87,126,86,126,86,123,86,123,86,107,86
	db 170,170,174,174,234,234,181,251,213,247,213,247,85,213,85,221
	db 170,170,174,174,234,234,187,255,255,254,255,174,255,170,255,171
	db 170,170,157,174,93,234,85,185,87,253,87,245,87,245,87,213
	db 170,170,174,238,233,246,245,247,245,247,85,223,85,223,85,95
	db 255,255,255,215,251,87,123,86,107,86,111,86,111,86,127,86
	db 170,170,174,174,234,234,181,219,213,223,213,223,85,125,85,125
	db 170,170,174,174,234,234,187,251,255,251,255,171,255,175,239,175
	db 90,213,90,85,91,85,91,86,91,90,91,89,91,89,91,90
	db 165,250,165,251,165,251,165,239,165,239,165,175,165,191,165,190
	db 123,86,123,86,107,86,111,86,111,86,111,86,110,86,110,90
	db 149,250,149,234,149,238,150,238,166,190,165,190,169,190,166,254
	db 255,93,255,85,255,87,253,87,245,95,213,95,87,95,95,87
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,253,255,253,255,245,255,245,255
	db 91,213,91,85,91,85,91,86,91,90,90,89,90,89,90,90
	db 165,239,165,239,165,175,165,191,165,190,165,254,165,250,165,251
	db 111,86,111,86,127,86,126,86,110,86,110,86,107,86,107,90
	db 149,238,149,190,149,190,150,190,166,254,165,250,169,250,166,234
	db 255,87,247,95,215,95,87,95,95,95,127,93,255,93,255,85
	db 91,213,91,85,90,85,90,86,90,90,91,89,91,89,91,90
	db 165,191,165,190,165,254,165,250,165,251,165,251,165,239,165,239
	db 126,86,126,86,126,86,123,86,107,86,107,86,111,86,111,90
	db 149,190,149,254,149,250,150,250,166,234,165,238,169,238,166,190
	db 95,95,95,95,127,93,255,93,255,85,255,87,253,87,245,87
	db 255,255,255,255,255,255,255,255,255,255,255,127,255,127,255,127
	db 90,90,90,86,106,86,106,90,170,90,170,89,170,89,154,90
	db 165,254,165,250,165,250,165,250,169,238,169,238,170,174,255,170
	db 110,90,107,106,106,106,106,106,110,106,106,102,106,166,106,218
	db 166,250,170,250,154,234,154,238,170,174,169,190,169,190,166,190
	db 127,85,255,85,255,85,255,85,253,85,245,85,213,85,87,85
	db 255,255,255,255,255,247,255,87,255,87,255,95,255,255,223,255
	db 245,255,213,255,213,255,85,255,86,253,86,253,85,245,85,213
	db 91,90,90,86,106,86,106,90,170,90,170,89,170,89,154,90
	db 165,250,165,238,165,238,165,174,169,190,169,190,170,190,255,170
	db 107,90,111,106,110,106,110,106,110,106,106,102,106,166,106,218
	db 166,238,170,238,154,190,154,190,170,190,169,190,169,186,166,186
	db 255,85,253,85,245,85,213,85,87,85,95,85,127,85,255,85
	db 255,95,255,95,255,95,255,255,255,255,255,255,127,255,127,253
	db 165,174,165,190,165,190,165,254,169,250,169,250,170,186,255,170
	db 111,90,110,106,110,106,110,106,106,106,106,102,106,166,106,218
	db 166,190,170,190,154,254,154,250,170,186,169,170,169,174,166,174
	db 213,85,87,85,95,85,127,85,255,85,255,85,255,85,253,85
	db 255,255,255,255,255,255,255,255,255,253,255,245,255,85,255,87
	db 101,165,87,169,191,169,254,149,234,159,170,127,170,250,170,234
	db 255,127,170,255,170,234,170,170,170,170,170,170,170,170,170,170
	db 245,255,255,191,175,170,170,170,170,170,170,170,170,170,170,170
	db 89,117,85,245,255,255,255,175,170,170,170,170,170,170,170,170
	db 95,85,127,85,255,255,255,255,191,170,170,170,170,170,170,170
	db 239,255,175,255,191,254,191,250,254,255,254,191,255,170,175,170
	db 253,255,213,191,213,191,85,170,85,234,85,234,85,234,85,254
	db 86,85,106,85,102,85,102,85,106,85,170,85,171,85,159,85
	db 89,85,85,245,255,255,255,175,170,170,170,170,170,170,170,170
	db 255,170,255,170,254,255,255,255,191,170,170,170,170,170,170,170
	db 127,245,253,85,253,87,245,223,247,255,247,127,255,85,95,85
	db 253,255,213,255,213,255,85,234,85,234,85,234,85,234,85,254
	db 245,85,213,85,215,255,255,255,191,170,170,170,170,170,170,170
	db 251,175,251,255,235,255,239,255,175,255,255,191,255,170,175,170
	db 253,255,213,255,213,255,85,234,85,170,85,170,85,170,85,254
	db 245,255,255,171,175,170,170,170,170,170,170,170,170,170,170,170
	db 254,87,250,255,170,254,170,170,170,170,170,170,170,170,170,170
_pano_coast_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 2,2,3,4,5,6,7,8,2,2,2,2,2,2,2,2
	db 2,2,3,4,5,6,7,8,2,2,2,2,2,2,2,2
	db 9,9,10,11,12,13,13,14,15,9,9,16,17,18,19,20
	db 9,9,10,11,12,13,13,14,15,9,9,16,17,18,19,20
	db 21,22,23,23,23,23,24,25,26,23,23,23,27,28,29,30
	db 21,22,23,23,23,23,24,25,26,23,23,23,27,28,29,30
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 31,32,33,34,35,36,36,36,37,38,39,40,41,36,36,36
	db 42,43,44,45,46,36,36,36,31,32,33,34,35,36,36,36
	db 47,48,49,50,51,52,52,53,54,55,56,57,58,52,52,53
	db 59,60,61,62,63,64,52,53,47,48,49,50,51,52,52,53
	db 65,66,67,68,69,70,52,71,72,73,74,75,76,77,52,71
	db 72,78,79,80,81,82,52,71,65,66,67,68,69,70,52,71
	db 83,84,85,86,87,88,89,90,83,84,85,91,92,93,94,90
	db 83,84,85,86,95,96,97,90,83,84,85,86,87,88,89,90
	db 9,9,9,9,9,9,98,99,9,9,9,9,9,9,98,99
	db 9,9,9,9,9,9,98,99,9,9,9,9,9,9,98,99
_pano_coast_map_pal:
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,2,7,1,1,1,1,1,1,2,7,1,1,1,1,1
	db 1,2,7,1,1,1,1,1,1,2,7,1,1,1,1,1
	db 7,7,7,7,2,1,1,1,7,7,7,7,2,1,1,1
	db 7,7,7,7,2,2,1,1,7,7,7,7,2,1,1,1
	db 3,7,7,7,6,2,1,3,7,7,7,7,6,2,1,3
	db 7,7,7,7,6,2,1,3,3,7,7,7,6,2,1,3
	db 6,6,6,6,6,6,7,7,6,6,6,6,6,6,7,7
	db 6,6,6,6,6,6,7,7,6,6,6,6,6,6,7,7
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	align 2
_pano_coast_pals:
	db 201,6,128,8,162,6,214,9,201,6,128,8,181,15,217,15
	db 201,6,177,10,181,15,217,15,201,6,128,8,177,10,217,15
	db 201,6,114,14,147,15,219,15,201,6,147,15,181,15,219,15
	db 201,6,177,10,162,6,231,14,201,6,128,8,177,10,231,14
	align 2
_pano_fields_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,85,85,87,85,95,89
	db 85,85,85,85,85,85,85,85,85,85,85,85,127,213,255,249
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,253,217
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,89,89
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,217,95
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,127,91,255
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,245,91,253
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,89,217
	db 191,170,255,175,255,255,255,255,170,170,170,170,170,170,170,170
	db 255,255,255,255,255,255,255,255,170,170,170,170,170,170,170,170
	db 254,255,255,255,255,255,255,255,170,170,170,170,170,170,170,170
	db 149,149,102,230,234,255,234,255,170,170,170,170,170,170,170,170
	db 149,149,102,102,170,170,170,170,170,170,170,170,170,170,170,170
	db 149,149,255,103,255,255,255,255,170,170,170,170,170,170,170,170
	db 251,191,255,255,255,255,255,255,170,170,170,170,170,170,170,170
	db 175,255,255,255,255,255,255,255,170,170,170,170,170,170,170,170
	db 149,245,102,254,255,255,255,255,170,170,170,170,170,170,170,170
	db 149,149,102,102,170,234,170,234,170,170,170,170,170,170,170,170
	db 170,170,175,250,191,254,255,255,255,255,255,255,255,255,170,170
	db 170,170,170,170,170,234,170,250,234,255,254,255,254,255,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,171,170,175,170,255,175,255,255,255,255,170,170
	db 170,170,170,170,234,234,174,174,238,238,255,255,255,255,255,255
	db 170,170,170,170,234,234,174,174,255,238,255,255,255,255,255,255
	db 170,170,234,175,250,239,255,191,255,255,255,255,255,255,255,255
	db 170,170,170,170,234,254,174,255,239,255,255,255,255,255,255,255
	db 171,170,171,170,239,234,255,191,255,255,255,255,255,255,255,255
	db 170,170,170,234,234,250,254,255,255,255,255,255,255,255,255,255
	db 170,170,170,170,170,170,170,170,234,234,174,174,238,238,255,255
	db 170,170,170,170,170,170,170,170,234,234,174,174,174,238,191,255
	db 170,170,170,170,170,170,170,170,234,234,174,174,238,234,255,251
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,170,106
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,159
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 239,255,239,255,239,255,251,255,249,255,253,255,229,255,181,250
	db 255,255,255,255,251,255,239,255,191,250,255,111,255,127,255,159
	db 255,254,255,254,255,254,191,255,159,255,214,255,87,254,89,171
	db 255,255,255,255,191,255,255,254,255,171,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,253,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,95
	db 255,127,106,89,106,89,106,89,106,89,106,89,106,89,106,89
	db 191,239,191,239,183,191,246,190,246,190,246,254,230,251,230,251
	db 255,255,170,170,170,170,85,85,85,85,85,85,85,85,85,85
	db 213,255,255,170,175,170,175,85,111,85,95,85,95,85,95,85
	db 255,215,255,255,255,255,255,245,87,253,85,253,85,245,85,245
	db 255,255,255,255,255,255,255,255,255,255,255,175,170,166,170,166
	db 255,255,255,255,255,255,255,255,255,255,85,255,85,169,85,169
	db 255,255,255,255,255,255,255,255,171,234,169,106,85,85,85,85
	db 255,255,255,255,255,255,255,255,255,255,255,167,191,166,155,166
	db 250,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 89,253,170,255,170,255,170,255,170,255,170,255,170,255,170,255
	db 255,127,255,255,255,255,255,255,255,191,255,191,255,255,255,255
	db 255,255,255,255,255,255,255,255,253,255,245,255,213,255,85,253
	db 213,255,85,253,85,245,85,85,85,85,85,85,85,85,85,85
	db 239,251,239,251,231,235,182,239,182,239,182,191,246,190,246,190
	db 213,255,255,170,175,170,175,85,111,85,111,85,111,85,111,85
	db 255,255,255,255,255,255,255,255,255,255,255,111,170,106,170,106
	db 255,255,255,255,255,255,255,255,171,234,170,106,86,85,86,85
	db 255,255,255,255,255,255,255,255,255,255,255,107,191,105,167,105
	db 106,89,106,153,106,153,106,153,106,153,106,153,255,255,255,255
	db 234,235,186,239,186,239,186,191,234,190,234,174,255,255,255,255
	db 85,85,85,85,85,85,85,85,85,85,85,85,170,170,170,170
	db 95,85,95,85,95,85,95,85,95,85,85,85,170,170,170,170
	db 251,254,251,251,239,251,239,251,239,255,191,239,255,255,255,255
	db 86,234,86,238,86,238,86,190,86,190,86,190,255,255,255,255
	db 239,239,175,239,191,239,190,191,254,190,250,190,255,255,255,255
	db 255,127,255,95,255,85,87,85,85,85,85,85,85,85,85,85
	db 255,255,255,255,255,255,255,255,255,95,85,85,170,170,170,170
	db 255,255,255,255,255,255,255,255,255,255,170,170,170,170,170,170
	db 255,255,255,255,255,255,255,255,255,255,85,85,85,85,85,85
	db 255,255,255,255,253,255,213,255,85,245,85,149,170,170,170,170
	db 85,245,85,213,85,85,85,85,85,85,85,85,170,170,170,170
	db 250,254,234,251,234,251,234,235,170,239,170,239,255,255,255,255
	db 190,255,190,254,250,254,251,254,251,251,239,251,255,255,255,255
	db 86,254,86,250,86,250,86,234,86,238,86,238,255,255,255,255
	db 251,250,251,251,239,251,239,239,175,239,191,239,255,255,255,255
	db 85,85,85,85,170,170,170,170,170,170,170,170,85,85,85,85
	db 170,170,170,170,85,85,85,85,85,85,85,85,170,170,170,170
_pano_fields_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,2,3,4,4,4,4,4,4,4,4,5,6,7,8,4
	db 1,2,3,4,4,4,4,4,4,4,4,5,6,7,8,4
	db 9,10,11,12,13,13,13,13,13,13,14,15,10,16,17,18
	db 9,10,11,12,13,13,13,13,13,13,14,15,10,16,17,18
	db 19,20,21,21,21,21,21,21,21,21,21,21,21,21,21,22
	db 19,20,21,21,21,21,21,21,21,21,21,21,21,21,21,22
	db 23,23,23,24,25,26,27,21,28,23,23,23,23,23,23,23
	db 23,23,23,24,25,26,27,21,28,23,23,23,23,23,23,23
	db 21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21
	db 21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21
	db 29,29,29,30,29,29,29,29,29,29,29,31,29,29,29,29
	db 29,29,29,30,29,29,29,29,29,29,29,31,29,29,29,29
	db 32,33,34,35,36,34,34,34,34,34,34,37,38,34,34,39
	db 32,40,34,35,36,34,34,34,34,34,34,37,38,34,34,39
	db 41,42,43,44,45,46,47,48,49,34,50,51,52,34,53,54
	db 41,55,43,56,45,57,47,58,59,34,50,51,52,34,53,54
	db 60,61,62,63,64,65,62,62,66,67,68,69,70,71,72,62
	db 60,73,62,63,74,75,62,62,76,67,68,69,70,71,72,62
	db 77,77,78,78,77,77,78,78,77,77,78,78,77,77,78,78
	db 77,77,78,78,77,77,78,78,77,77,78,78,77,77,78,78
_pano_fields_map_pal:
	db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	db 6,6,6,6,6,6,6,1,6,6,6,6,6,6,6,6
	db 6,6,6,6,6,6,6,1,6,6,6,6,6,6,6,6
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 4,5,0,1,1,0,0,0,0,0,0,1,1,0,0,0
	db 4,3,0,1,1,0,0,0,0,0,0,1,1,0,0,0
	db 2,2,5,5,3,5,4,5,5,0,1,1,1,0,0,5
	db 2,2,5,5,3,5,4,5,5,0,1,1,1,0,0,5
	db 2,2,7,7,2,2,7,7,2,3,3,0,3,4,0,7
	db 2,2,7,7,2,2,7,7,2,3,3,0,3,4,0,7
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	align 2
_pano_fields_pals:
	db 218,7,132,3,222,8,207,12,218,7,104,4,221,12,207,12
	db 218,7,132,3,166,5,203,5,218,7,203,5,222,8,207,12
	db 218,7,132,3,203,5,207,12,218,7,166,5,203,5,207,12
	db 218,7,179,13,216,13,221,12,218,7,166,5,222,8,207,12
	align 2
_pano_desert_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,174,174,234,234,187,187,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,234,234,174,174
	db 170,170,170,170,170,170,170,170,167,170,167,170,230,234,166,174
	db 170,170,170,170,170,170,170,170,255,255,255,255,153,90,153,90
	db 170,170,170,170,170,170,170,170,255,255,255,255,85,85,85,85
	db 170,170,170,170,170,170,170,170,253,255,253,255,85,85,87,85
	db 170,170,170,170,170,170,170,170,255,255,255,255,87,85,85,85
	db 238,238,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 246,255,246,255,214,247,214,247,150,245,150,245,150,245,150,245
	db 153,90,153,90,153,90,153,90,153,90,153,90,153,90,153,90
	db 90,150,90,150,90,150,90,150,90,150,90,150,90,150,90,150
	db 167,170,167,170,167,170,167,170,167,170,166,170,166,170,166,170
	db 255,255,255,255,255,255,255,255,255,215,255,215,255,215,255,215
	db 255,255,255,255,255,255,255,255,127,255,127,255,119,255,119,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,85,85,85,85
	db 255,255,255,255,255,255,255,255,255,255,255,255,127,85,127,85
	db 166,170,166,170,167,170,167,170,167,170,167,170,167,170,167,170
	db 255,255,255,255,255,125,255,125,255,85,255,215,255,215,255,215
	db 255,255,255,255,255,255,255,255,223,255,223,255,95,85,127,85
	db 150,245,150,245,154,245,154,245,170,245,170,245,170,245,170,245
	db 167,170,167,170,167,170,167,170,167,170,167,170,166,170,166,170
	db 255,85,255,85,255,85,255,215,255,215,255,215,255,215,255,213
	db 102,255,102,125,102,125,102,105,102,105,102,105,102,105,102,105
	db 170,169,170,169,170,169,170,169,170,169,170,169,170,169,170,169
	db 191,90,191,90,175,90,173,90,169,90,185,90,185,90,189,90
	db 255,255,255,255,255,255,255,127,255,95,255,95,255,95,255,127
	db 255,255,255,255,127,255,127,255,102,255,102,255,102,255,102,255
	db 255,255,255,255,255,255,255,255,85,85,85,85,85,85,85,85
	db 255,255,255,255,255,255,255,255,255,95,255,95,255,95,255,95
	db 166,170,166,170,166,170,167,170,167,170,167,170,167,170,166,170
	db 255,215,255,215,255,215,255,85,255,85,255,85,255,215,255,213
	db 191,90,191,90,191,90,189,90,189,90,173,90,173,90,169,90
	db 255,255,255,255,255,255,255,127,255,127,255,127,255,127,255,95
	db 255,255,255,255,255,127,255,125,247,125,247,253,213,247,221,247
	db 150,245,150,245,170,245,170,245,170,213,170,217,170,149,170,149
	db 166,170,166,170,166,170,166,170,166,170,166,170,166,170,166,170
	db 255,213,255,85,223,85,223,85,223,213,127,213,125,213,125,213
	db 255,255,255,255,255,255,255,127,255,127,255,127,85,253,85,245
	db 255,255,255,255,255,255,213,255,85,255,85,255,85,215,85,215
	db 119,125,119,125,119,125,119,125,119,125,119,125,247,125,251,125
	db 170,169,170,169,170,169,170,169,170,169,170,169,170,169,170,170
	db 169,90,169,90,169,90,169,90,169,90,169,90,170,90,170,90
	db 255,127,255,127,255,127,223,119,223,119,221,87,245,255,245,255
	db 119,255,119,255,119,255,127,255,175,254,170,170,170,170,170,170
	db 170,169,170,169,170,169,170,169,170,170,170,90,101,85,101,85
	db 170,90,170,90,153,90,153,90,153,90,153,170,169,170,170,170
	db 251,255,251,255,91,150,95,150,95,150,95,150,95,150,94,150
	db 255,255,255,255,255,223,127,223,127,223,127,127,253,125,245,125
	db 255,213,255,213,255,213,247,213,247,85,215,85,223,85,223,213
	db 255,255,255,255,255,255,255,223,255,223,255,223,85,125,85,125
	db 255,95,255,95,255,127,255,125,247,125,245,125,245,255,245,255
	db 170,169,170,169,170,169,170,169,154,170,154,90,85,85,101,85
	db 255,91,255,91,217,91,217,90,217,90,153,170,169,170,170,170
	db 255,255,254,255,94,150,90,150,91,150,91,150,95,150,95,150
	db 221,215,125,223,170,170,170,170,85,85,85,85,85,85,85,85
	db 150,153,150,153,170,153,170,170,170,106,85,85,85,85,85,85
	db 153,90,153,90,153,90,255,255,255,255,170,106,170,106,170,106
	db 95,215,95,215,95,215,94,215,250,255,250,255,170,191,170,191
	db 247,255,170,255,170,250,170,170,170,170,170,170,170,170,170,170
	db 255,255,255,255,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,255,255,255,171,106,171,106,171,106,171,106,170,106,170,106
	db 85,150,255,239,255,239,90,239,90,190,90,190,90,190,90,251
	db 171,254,171,170,171,170,171,170,171,170,171,170,171,170,235,170
	db 255,255,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,175,255,175,255,175,255,175,255,175,255,175,255,175,255,175
	db 170,191,170,191,170,191,170,191,170,191,170,191,170,191,170,191
	db 175,170,175,170,175,170,239,170,175,170,175,170,239,170,239,170
	db 186,170,186,170,170,170,170,170,170,170,186,170,186,170,186,170
	db 175,239,191,239,190,239,254,190,250,190,251,190,251,251,239,251
	db 90,106,154,105,166,169,166,165,165,166,153,166,153,154,89,154
	db 245,253,213,247,170,170,170,170,85,85,85,85,85,85,85,85
	db 254,255,254,255,170,106,171,106,171,106,171,106,171,106,171,106
	db 85,150,255,251,255,251,90,251,90,239,90,239,90,239,90,190
	db 186,170,186,170,186,170,186,170,186,170,170,170,170,170,170,170
	db 251,251,239,251,239,251,175,239,191,239,190,239,254,190,250,190
	db 95,153,95,154,106,90,106,106,169,105,165,169,165,165,165,166
_pano_desert_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 5,6,7,8,9,5,5,5,5,5,5,5,5,5,5,5
	db 5,6,7,8,10,5,5,5,5,5,5,5,5,5,5,5
	db 11,12,13,14,15,16,11,11,17,18,19,11,11,11,11,11
	db 11,12,13,14,20,21,11,11,17,18,22,11,11,11,11,11
	db 4,23,13,14,24,25,4,4,26,27,28,29,30,31,32,4
	db 4,23,13,14,33,34,4,4,26,27,35,36,30,31,32,4
	db 37,38,13,14,39,40,41,42,43,44,45,46,47,48,49,50
	db 51,38,13,14,39,52,53,42,43,44,45,54,47,55,56,57
	db 58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73
	db 74,59,60,61,62,63,75,76,66,67,68,69,70,77,78,79
_pano_desert_map_pal:
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 2,7,7,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,7,7,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,3,3,3,3,2,2,2,3,2,2,2,2,2,2,2
	db 2,3,3,3,3,2,2,2,3,2,2,2,2,2,2,2
	db 2,3,3,3,3,2,2,2,3,3,3,2,3,2,3,2
	db 2,3,3,3,3,2,2,2,3,3,3,2,3,2,3,2
	db 2,3,3,3,3,2,2,3,6,3,3,2,4,5,3,3
	db 2,3,3,3,3,2,2,3,6,3,3,2,4,5,3,3
	db 5,5,0,6,6,0,0,0,6,0,6,6,6,0,0,5
	db 5,5,0,6,6,0,0,0,6,0,6,6,6,0,0,5
	align 2
_pano_desert_pals:
	db 206,10,106,8,173,7,206,9,206,10,165,14,185,13,206,11
	db 206,10,189,8,206,11,223,10,206,10,106,8,189,8,223,10
	db 206,10,106,8,139,7,223,10,206,10,173,7,189,8,223,11
	db 206,10,106,8,139,7,189,8,206,10,106,8,206,11,223,10
	align 2
_pano_autumn_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,89,89
	db 149,149,102,102,170,170,170,170,170,170,170,170,170,170,170,170
	db 149,149,102,102,170,170,170,170,170,170,170,170,171,170,171,170
	db 149,149,102,102,170,170,170,170,250,170,255,171,255,255,255,255
	db 170,170,170,170,170,171,234,175,255,191,255,255,255,255,255,255
	db 170,170,170,170,170,191,171,255,255,255,255,255,255,255,255,255
	db 170,170,170,170,170,250,170,254,175,255,255,255,255,255,255,255
	db 149,149,102,102,170,170,170,170,170,234,170,250,250,255,250,255
	db 149,149,102,102,170,170,170,170,170,170,170,170,170,170,191,170
	db 149,149,102,102,170,170,170,170,170,170,170,170,170,170,250,170
	db 149,149,102,102,170,170,170,170,255,170,255,170,170,170,170,170
	db 170,170,234,175,251,191,255,255,255,255,255,255,170,170,170,170
	db 170,191,170,255,235,255,255,255,255,255,255,255,170,170,170,170
	db 149,149,102,246,170,254,170,255,254,255,254,255,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,175,170,191,170,255,175,255,175,170,170,170,170,170,170
	db 255,170,255,250,255,255,255,255,255,255,170,170,170,170,170,170
	db 254,171,255,255,255,255,255,255,255,255,170,170,170,170,170,170
	db 170,170,170,170,234,255,254,255,254,255,170,170,170,170,250,170
	db 170,170,170,170,170,170,170,170,170,170,170,171,234,175,251,191
	db 170,170,170,170,170,170,170,170,170,170,170,191,171,255,239,255
	db 170,170,170,170,170,170,170,170,170,170,170,250,170,254,175,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,234
	db 170,170,174,174,234,234,187,187,255,255,255,255,255,255,255,255
	db 170,170,175,174,235,234,187,187,255,255,255,255,255,255,255,255
	db 255,175,255,255,255,255,187,187,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,170,170,170,170,170,170,170,170,170,170
	db 170,250,254,255,250,255,187,187,255,255,255,255,255,255,255,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,218,159,223,95
	db 170,170,170,170,170,170,170,170,170,170,170,170,167,170,87,253
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,255,250,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,250,159,247,95
	db 170,170,170,170,170,170,174,174,234,234,187,187,255,255,255,255
	db 169,170,165,170,149,170,149,174,85,234,85,185,85,253,85,245
	db 170,89,170,89,170,89,170,89,170,89,170,89,170,89,170,105
	db 86,169,86,101,86,101,86,101,86,101,86,101,90,101,90,102
	db 190,175,190,174,254,174,251,174,251,171,235,171,239,171,239,175
	db 170,170,170,170,106,90,106,90,106,90,106,90,106,90,106,90
	db 85,85,85,149,85,165,93,169,213,169,119,170,191,170,191,170
	db 239,171,239,175,191,175,190,175,190,174,254,174,251,174,251,171
	db 255,255,255,255,255,255,255,255,255,255,255,170,191,170,171,170
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,246,255,86,255,85,245
	db 255,255,255,255,255,255,255,255,255,255,255,175,255,170,191,170
	db 255,255,255,255,253,255,245,255,213,255,85,253,85,213,85,85
	db 85,213,85,85,85,85,85,85,86,85,86,85,150,85,150,85
	db 170,105,170,105,170,169,170,169,170,153,170,153,170,169,170,105
	db 90,102,90,101,86,101,150,102,154,102,154,102,154,102,90,102
	db 191,175,190,175,174,174,238,174,235,174,235,171,235,171,239,171
	db 106,90,106,90,106,90,106,90,106,90,106,90,106,90,106,90
	db 175,170,175,170,171,170,170,170,170,170,170,170,170,170,170,170
	db 255,255,255,255,255,255,255,255,255,191,255,191,255,171,255,170
	db 255,255,255,255,255,255,255,255,255,255,245,255,213,255,85,255
	db 235,171,239,171,239,175,175,175,174,175,174,174,238,174,235,174
	db 170,154,170,154,170,154,170,154,170,154,170,154,170,154,170,154
	db 165,170,149,170,149,170,149,165,149,165,149,165,149,165,149,165
	db 170,170,170,170,154,170,154,170,154,170,154,170,154,170,150,169
	db 86,85,86,85,86,85,86,85,86,85,86,85,86,170,166,170
	db 191,191,190,190,254,190,254,190,251,187,251,187,170,170,170,170
	db 245,255,213,255,85,253,85,253,85,229,85,229,170,169,106,149
	db 85,85,85,85,85,85,85,85,101,85,101,85,102,165,102,170
	db 154,101,154,101,169,105,169,165,106,165,102,169,166,153,170,153
	db 170,105,170,169,170,169,170,169,170,153,170,153,170,169,170,105
	db 90,102,170,101,166,101,166,102,170,102,154,102,154,102,106,102
	db 238,174,174,174,174,174,174,170,238,170,234,170,234,170,234,170
	db 255,234,254,170,254,174,250,174,235,174,171,174,171,174,187,174
	db 190,175,190,191,190,254,251,254,251,250,251,251,106,251,90,165
	db 255,255,255,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,245,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 239,171,239,175,175,175,191,191,190,190,254,190,170,170,170,170
	db 245,255,213,255,85,189,85,189,85,165,85,229,170,169,106,149
	db 234,170,234,170,238,170,238,170,174,170,174,170,174,170,238,170
	db 175,239,191,174,255,170,255,170,254,170,254,174,250,174,235,174
	db 239,251,239,239,239,175,190,175,190,191,190,254,106,254,90,181
	db 250,239,234,239,170,239,170,239,170,254,170,255,170,191,170,174
	db 238,255,255,191,170,175,170,170,170,170,170,170,170,170,170,170
	db 255,235,255,170,191,170,175,170,171,170,170,170,170,170,170,170
	db 255,255,255,255,255,255,255,255,255,255,255,251,255,186,187,174
	db 175,170,171,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,255,255,255,255,255,255,191,255,175,255,171,255,170,191,170
	db 154,169,154,106,169,106,169,166,106,166,102,170,166,154,170,153
	db 255,125,255,253,255,253,255,253,175,222,171,222,170,250,170,126
	db 106,102,170,101,166,101,166,102,170,166,154,166,154,170,106,102
	db 238,170,238,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 127,95,126,95,106,95,170,95,170,95,170,94,170,95,170,94
	db 171,90,170,86,170,85,106,85,90,85,86,85,85,85,85,85
	db 171,234,171,234,170,234,170,234,170,250,170,234,170,234,170,186
	db 255,250,191,250,175,255,235,191,234,175,250,171,234,170,186,170
	db 85,213,215,245,215,253,223,253,171,255,170,189,170,174,170,171
	db 234,170,234,170,234,170,170,170,170,170,170,170,170,170,170,170
	db 170,171,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 174,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 167,170,175,170,175,170,175,170,173,170,173,170,175,170,167,170
	db 170,122,170,250,170,250,170,250,170,218,170,218,170,250,170,122
	db 127,175,255,169,247,169,247,171,255,171,223,171,223,171,127,171
	db 170,86,170,86,170,86,170,86,170,86,170,86,170,86,170,86
_pano_autumn_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 2,2,3,4,5,6,7,8,9,10,11,12,13,14,2,2
	db 2,2,3,4,5,6,7,8,9,10,11,12,13,14,2,2
	db 15,15,15,15,15,15,15,16,17,18,19,20,21,22,23,15
	db 15,15,15,15,15,15,15,16,17,18,19,20,21,22,23,15
	db 24,24,24,24,24,24,24,24,24,25,26,27,27,27,28,24
	db 24,24,24,24,24,24,24,24,24,25,26,27,27,27,28,24
	db 15,15,15,15,15,15,15,15,29,30,31,15,15,15,15,15
	db 15,15,15,15,15,15,15,15,32,30,31,15,15,15,15,15
	db 33,33,33,33,33,33,33,34,35,36,37,38,39,33,33,33
	db 33,33,33,33,33,33,33,34,35,36,40,38,39,33,33,33
	db 41,42,42,43,44,42,45,46,47,48,49,50,51,52,42,53
	db 41,42,42,43,44,42,45,46,47,48,54,50,51,52,42,53
	db 55,56,57,58,59,60,61,62,63,64,65,50,66,67,68,69
	db 55,56,57,58,70,71,61,62,63,64,72,50,73,74,68,69
	db 75,76,77,78,15,79,80,81,82,83,84,85,86,87,88,89
	db 75,76,77,78,15,79,80,81,82,83,90,85,86,87,88,89
	db 91,15,15,92,15,15,93,81,94,95,15,96,15,15,15,15
	db 91,15,15,92,15,15,93,81,94,95,15,96,15,15,15,15
_pano_autumn_map_pal:
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,0,0,0,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,0,0,0,4,4
	db 0,0,0,0,0,0,0,0,5,5,5,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,5,5,5,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,1,1,3,1,6,0,0,0
	db 0,0,0,0,0,0,0,0,1,1,3,1,6,0,0,0
	db 1,0,0,1,1,0,0,1,1,1,3,1,1,1,0,0
	db 1,0,0,1,1,0,0,1,1,1,3,1,1,1,0,0
	db 1,1,1,1,3,1,1,1,1,1,3,1,3,3,1,0
	db 1,1,1,1,3,1,1,1,1,1,3,1,3,3,1,0
	db 2,2,2,2,2,2,2,1,2,1,3,2,3,2,2,2
	db 2,2,2,2,2,2,2,1,2,1,3,2,3,2,2,2
	db 2,2,2,2,2,2,2,1,2,2,1,2,2,2,2,2
	db 2,2,2,2,2,2,2,1,2,2,1,2,2,2,2,2
	align 2
_pano_autumn_pals:
	db 172,6,122,4,172,14,222,13,172,6,122,4,173,5,222,13
	db 172,6,122,4,93,1,173,5,172,6,93,1,173,5,223,8
	db 172,6,104,13,138,14,172,14,172,6,122,4,172,14,173,5
	db 172,6,172,14,173,5,222,13,172,6,122,4,173,5,222,13
	align 2
_pano_alps_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,95,85
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,213
	db 85,85,85,85,85,85,85,85,85,85,85,85,213,149,253,255
	db 85,85,85,85,85,85,85,85,85,85,85,85,149,149,89,89
	db 85,85,85,85,85,85,85,85,85,85,87,85,255,151,255,91
	db 87,85,95,85,127,85,175,122,175,255,255,255,170,170,170,170
	db 127,245,255,253,255,255,191,250,255,255,255,255,170,170,170,170
	db 125,213,255,245,255,255,170,234,254,250,255,255,170,170,170,170
	db 85,85,85,85,85,213,85,255,85,255,85,85,149,255,89,255
	db 85,85,85,85,85,85,85,85,85,85,85,85,149,149,91,89
	db 85,85,85,85,85,85,85,85,87,85,87,85,159,253,255,255
	db 85,85,85,85,85,85,85,85,95,213,127,245,255,253,255,255
	db 85,85,85,85,85,85,85,85,125,213,255,213,255,247,255,255
	db 255,255,255,255,170,170,170,170,170,170,170,170,170,170,170,170
	db 153,249,170,250,170,170,170,170,170,170,170,170,170,170,170,170
	db 153,153,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,155,255,171,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,171,170,175,170,191,170
	db 234,170,250,171,254,175,255,191,255,255,255,255,255,255,255,255
	db 170,170,170,170,170,170,170,170,170,234,170,250,170,254,170,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,149,255,91,255,159,255,191,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,127,255,127,255,123,254,123,246
	db 213,255,249,255,253,255,255,255,255,255,255,255,255,255,255,255
	db 149,149,89,89,153,153,170,170,170,234,170,250,170,254,170,255
	db 149,149,91,89,159,153,191,170,255,170,255,171,255,175,255,191
	db 149,213,89,249,153,253,170,255,234,255,250,255,254,255,255,255
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 149,149,89,89,153,153,170,170,170,170,171,170,175,170,191,170
	db 255,255,255,255,255,255,255,255,127,255,127,255,123,254,122,246
	db 255,255,254,255,254,255,238,255,174,255,150,255,150,247,165,245
	db 107,234,107,218,106,90,122,169,122,105,122,106,122,166,122,166
	db 255,191,255,191,255,175,255,175,255,175,191,175,175,174,239,174
	db 234,255,251,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,254,255,254,255,238,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,175,255,175
	db 170,234,170,250,170,254,171,255,239,255,255,255,255,255,255,255
	db 255,174,255,191,255,255,255,255,255,255,255,255,255,255,255,255
	db 123,234,123,218,122,90,122,169,122,105,122,106,106,166,106,166
	db 255,191,255,191,255,191,255,191,255,175,255,171,239,171,235,171
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,191,255,191
	db 122,234,122,218,122,90,106,169,106,105,106,106,122,166,122,166
	db 255,191,255,191,255,191,255,187,255,171,239,175,239,175,175,175
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,191,255,187
	db 101,185,102,186,166,154,166,153,170,89,154,90,154,150,169,166
	db 122,170,106,154,106,154,106,169,106,105,106,106,106,166,106,166
	db 239,170,171,171,171,171,171,171,171,171,171,171,171,171,171,170
	db 255,191,255,191,255,191,255,187,255,171,255,175,255,175,169,187
	db 174,255,150,255,150,247,165,245,101,185,102,186,166,154,166,153
	db 191,191,191,191,187,190,186,190,186,170,186,171,186,170,170,170
	db 255,255,255,255,255,255,255,255,255,191,255,191,255,191,255,187
	db 255,255,255,255,255,255,245,255,249,255,154,251,154,187,169,154
	db 106,170,122,154,106,154,106,169,106,105,106,106,106,166,106,166
	db 235,171,171,171,171,171,171,171,171,170,170,170,170,170,170,171
	db 255,191,255,191,255,191,255,175,255,191,191,191,191,190,249,186
	db 255,190,255,186,187,187,187,171,171,175,171,171,170,170,186,170
	db 255,255,255,255,255,255,255,255,255,191,255,191,255,175,255,175
	db 122,170,122,154,106,154,106,169,106,105,106,106,106,166,106,166
	db 175,171,171,170,170,170,170,170,170,171,171,171,171,171,171,171
	db 255,191,255,191,255,191,255,191,255,191,255,186,255,187,249,171
	db 255,171,255,175,187,175,187,191,187,175,187,170,186,170,186,170
	db 255,255,255,255,255,255,255,255,255,191,255,191,255,191,255,191
	db 105,170,106,154,166,154,166,169,170,105,154,106,154,166,169,166
	db 106,170,106,154,106,154,106,169,106,105,106,106,106,166,106,166
	db 170,170,170,170,170,170,171,170,171,170,171,170,171,170,170,170
	db 185,187,186,186,186,186,185,170,185,171,186,170,170,170,170,170
	db 170,89,154,90,154,150,169,166,105,170,106,154,166,154,166,169
	db 170,170,170,170,186,170,186,170,186,170,186,170,170,170,170,170
	db 255,171,215,175,217,175,153,175,153,171,153,170,153,170,154,170
	db 105,154,106,170,166,106,166,106,170,170,154,170,154,170,169,154
	db 171,171,171,171,171,170,171,170,171,170,171,170,170,170,170,170
	db 249,186,186,187,186,171,169,171,169,171,170,170,186,170,186,170
	db 186,170,186,170,186,170,186,170,186,170,170,170,170,170,170,170
	db 255,175,151,175,153,174,217,174,217,170,153,171,153,171,154,171
	db 171,171,171,171,171,170,170,170,170,170,170,170,171,170,170,170
	db 233,171,170,171,170,187,185,171,185,170,186,170,186,170,186,170
	db 186,170,186,170,170,170,170,170,170,170,186,170,170,170,170,170
	db 255,175,215,171,217,171,217,171,217,171,153,171,153,171,154,171
	db 170,170,170,170,170,170,169,170,169,170,170,170,170,170,170,170
	db 170,105,154,106,154,166,169,166,105,170,106,154,166,154,166,169
	db 150,171,150,171,154,171,154,171,154,171,153,171,153,170,154,170
	db 150,171,150,171,154,171,154,170,154,170,153,170,153,170,154,170
	db 150,170,150,170,154,170,154,171,154,171,153,171,153,170,154,170
	db 190,255,191,239,251,239,251,254,127,190,95,189,87,245,85,213
	db 191,255,191,239,191,239,191,254,191,190,191,191,127,251,95,249
	db 255,255,255,255,255,255,255,255,255,255,255,255,127,255,111,253
	db 255,255,255,255,255,255,255,255,127,255,159,253,87,246,86,217
	db 255,190,239,191,239,251,254,251,190,255,191,239,123,239,91,253
	db 255,255,255,255,255,255,255,255,255,255,255,255,127,255,95,253
	db 235,255,235,255,239,255,239,255,111,255,94,253,86,245,85,213
	db 190,239,191,255,251,191,251,191,255,255,239,255,111,255,94,237
	db 190,255,191,239,251,239,251,254,255,190,239,191,111,251,94,249
	db 191,255,191,239,191,239,191,254,127,190,95,189,87,245,85,213
	db 255,255,255,255,255,255,254,255,254,255,255,255,127,255,95,253
	db 255,190,239,191,239,251,254,251,126,255,95,237,87,229,85,213
	db 235,255,235,255,239,255,239,255,239,255,238,255,110,255,95,253
	db 190,239,191,255,251,191,251,191,127,255,95,253,87,245,85,213
	db 255,255,255,255,255,255,255,255,127,255,111,253,151,245,85,214
	db 255,255,255,255,255,255,255,255,255,255,255,255,191,255,95,254
	db 255,255,255,255,255,255,254,255,126,255,95,253,87,245,85,213
	db 255,255,255,255,255,255,255,255,255,255,255,255,127,255,159,253
	db 101,149,149,85,85,86,86,89,89,101,101,149,149,85,85,86
	db 87,249,89,229,101,149,149,85,85,86,86,89,89,101,101,149
	db 151,245,85,214,86,89,89,101,101,149,149,85,85,86,86,89
	db 89,101,101,149,149,85,85,86,86,89,89,101,101,149,149,85
	db 87,246,86,217,89,101,101,149,149,85,85,86,86,89,89,101
	db 103,245,149,213,85,86,86,89,89,101,101,149,149,85,85,86
	db 86,89,89,101,101,149,149,85,85,86,86,89,89,101,101,149
	db 91,245,101,213,149,85,85,86,86,89,89,101,101,149,149,85
	db 85,86,86,89,89,101,101,149,149,85,85,86,86,89,89,101
	db 149,85,85,86,86,89,89,101,101,149,149,85,85,86,86,89
_pano_alps_map:
	db 0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0
	db 3,4,4,4,4,5,6,7,8,9,4,4,10,11,12,13
	db 3,4,4,4,4,5,6,7,8,9,4,4,10,11,12,13
	db 14,15,16,16,16,16,16,16,16,16,16,16,17,14,14,14
	db 14,15,16,16,16,16,16,16,16,16,16,16,17,14,14,14
	db 18,19,20,21,21,21,21,21,18,19,20,21,21,21,21,21
	db 18,19,20,21,21,21,21,21,18,19,20,21,21,21,21,21
	db 22,23,24,25,26,27,28,29,22,23,24,25,26,27,28,29
	db 22,30,24,25,26,27,28,29,22,23,24,25,26,27,28,29
	db 31,32,33,34,35,36,37,38,31,39,40,34,35,41,37,38
	db 31,42,43,34,35,44,37,38,31,32,33,34,35,36,37,38
	db 45,46,47,48,49,50,51,52,45,53,54,55,49,56,57,52
	db 45,58,59,60,49,61,62,52,45,46,47,48,49,50,51,52
	db 63,64,65,66,67,68,69,70,63,64,71,72,67,73,74,70
	db 63,64,75,76,67,77,78,70,63,64,65,66,67,68,69,70
	db 63,64,21,79,80,21,81,70,63,64,21,79,80,21,82,70
	db 63,64,21,79,80,21,83,70,63,64,21,79,80,21,81,70
	db 84,85,86,87,88,89,90,91,92,93,89,94,95,89,96,97
	db 92,85,87,94,88,98,96,91,84,85,99,100,88,101,90,91
	db 102,103,104,105,106,107,108,104,109,110,107,103,111,109,106,102
	db 103,104,105,106,107,108,104,109,110,107,103,111,109,106,102,103
_pano_alps_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,1,2,2,2,1,0,0,0,0,0,0
	db 0,0,0,0,0,1,2,2,2,1,0,0,0,0,0,0
	db 1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1
	db 1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 3,4,3,3,3,3,3,3,3,4,3,3,3,3,3,3
	db 3,4,3,3,3,3,3,3,3,4,3,3,3,3,3,3
	db 4,4,4,3,4,4,3,3,4,4,4,3,4,4,3,3
	db 4,4,4,3,4,4,3,3,4,4,4,3,4,4,3,3
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 7,7,5,5,7,5,7,7,7,7,5,7,7,5,7,7
	db 7,7,5,7,7,5,7,7,7,7,5,7,7,5,7,7
	db 5,5,5,5,6,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,6,5,5,5,5,5,5,5,6,5,5,5
	align 2
_pano_alps_pals:
	db 201,8,81,12,98,13,255,15,201,8,81,12,98,13,220,15
	db 201,8,81,12,220,15,255,15,201,8,98,13,131,14,255,15
	db 201,8,149,11,201,14,255,15,201,8,97,3,114,4,201,14
	db 201,8,97,3,114,4,149,11,201,8,97,3,149,11,201,14
	align 2
_pano_city_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,89,89,149,149,102,102
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,174,174,234,234,187,187
	db 85,85,85,85,85,85,85,85,85,85,85,85,149,149,89,89
	db 153,153,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 153,153,170,170,170,170,175,170,255,170,255,171,255,191,255,255
	db 153,153,170,170,255,191,255,255,255,255,255,255,255,255,255,255
	db 153,153,170,170,170,170,170,254,234,255,250,255,255,255,255,255
	db 153,153,170,170,170,170,170,170,170,170,170,170,170,170,170,234
	db 170,170,170,170,170,170,170,170,170,170,170,170,234,234,174,174
	db 170,170,170,170,170,170,170,170,170,170,170,170,234,234,173,174
	db 170,170,170,166,170,166,170,149,170,149,106,85,106,85,94,85
	db 85,85,87,85,95,85,95,85,127,85,127,85,85,149,85,85
	db 255,255,255,255,255,255,255,255,255,255,255,255,170,170,170,170
	db 170,234,170,250,170,254,170,254,170,255,170,255,170,170,170,170
	db 170,170,166,170,166,170,149,170,149,170,85,170,85,234,85,173
	db 170,170,170,170,170,170,170,170,170,170,170,106,234,106,174,94
	db 229,238,245,255,245,255,245,255,213,255,85,253,85,245,85,213
	db 237,238,255,255,255,255,255,255,255,127,255,87,255,85,127,85
	db 94,85,127,85,127,85,127,85,127,85,127,85,127,85,127,85
	db 238,238,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 238,238,255,255,255,255,255,255,255,255,253,255,245,255,213,255
	db 238,229,255,245,255,245,255,245,127,213,87,85,85,85,85,85
	db 255,153,255,170,85,165,85,165,255,170,255,170,85,165,85,101
	db 255,255,255,255,170,170,170,170,255,255,255,255,170,170,170,170
	db 217,255,234,255,86,85,86,85,234,255,234,255,86,85,86,85
	db 85,237,85,255,85,255,85,255,85,255,85,255,85,255,85,255
	db 238,94,255,127,255,127,255,127,255,127,255,127,87,127,87,127
	db 238,238,255,255,255,255,255,255,255,255,255,255,255,213,255,213
	db 238,238,255,255,255,255,255,255,255,127,255,87,255,85,127,85
	db 85,149,85,85,85,87,85,85,85,85,85,85,93,149,85,149
	db 127,85,95,85,95,85,95,85,95,85,95,85,127,85,127,85
	db 106,85,106,85,106,93,106,85,106,85,106,85,106,85,105,85
	db 255,255,255,255,255,255,223,255,87,255,85,245,85,213,85,85
	db 213,255,85,255,85,255,85,255,85,255,85,127,213,95,213,85
	db 255,127,255,95,169,218,165,90,85,95,213,95,149,122,149,122
	db 255,247,255,213,106,85,86,85,85,85,87,85,86,85,86,85
	db 255,255,255,255,170,170,170,170,255,255,223,255,86,170,85,165
	db 255,255,255,255,170,170,170,170,253,255,213,255,85,169,85,170
	db 255,255,255,255,171,166,107,85,95,85,85,85,85,117,85,85
	db 85,170,85,170,117,170,85,170,85,170,85,170,85,90,85,106
	db 86,106,86,106,86,106,86,106,86,106,86,106,86,234,86,106
	db 255,213,255,213,255,213,255,213,255,213,255,213,255,213,255,213
	db 85,213,85,85,85,85,85,85,85,85,85,85,85,213,85,213
	db 106,85,90,85,90,87,90,85,90,85,90,85,106,85,106,85
	db 106,85,90,85,90,93,90,85,90,85,90,85,106,85,106,85
	db 127,85,127,85,127,85,127,85,127,85,127,85,127,85,125,85
	db 170,170,170,170,170,170,154,170,86,170,85,165,213,149,85,85
	db 85,85,85,85,85,213,85,85,85,85,85,85,85,87,85,85
	db 255,127,255,95,170,90,170,90,255,95,255,95,170,122,169,122
	db 255,255,255,255,170,170,170,170,255,255,255,247,169,157,106,85
	db 255,255,255,255,154,170,86,170,85,245,85,213,85,85,85,85
	db 255,255,255,255,170,170,170,170,255,255,253,95,149,118,85,89
	db 255,255,255,255,171,170,171,166,127,85,95,85,85,85,85,85
	db 85,255,85,255,85,255,85,255,85,255,85,255,85,255,85,95
	db 86,106,86,106,214,106,86,106,86,106,86,106,86,106,86,106
	db 85,213,85,213,85,213,85,213,85,213,85,213,85,213,85,213
	db 106,85,106,85,106,117,106,85,106,85,106,85,106,85,106,85
	db 127,85,127,85,127,85,127,85,127,85,127,85,127,85,127,85
	db 85,85,85,85,85,213,85,85,85,85,85,85,85,85,85,85
	db 149,86,149,86,151,86,149,86,149,86,149,86,149,86,149,86
	db 149,106,149,106,157,106,149,106,149,106,149,106,149,106,149,106
	db 87,85,85,85,86,85,86,85,86,85,86,85,86,85,86,85
	db 85,213,85,85,101,85,85,85,85,85,85,85,85,85,85,85
	db 85,95,85,86,85,90,85,90,85,90,85,90,85,90,85,90
	db 85,85,85,85,213,85,85,85,85,85,85,85,85,85,85,85
	db 85,127,85,127,85,127,85,127,85,127,85,127,85,127,85,127
	db 87,127,87,127,87,127,87,127,87,127,87,127,87,127,87,127
	db 85,149,85,149,85,157,85,149,85,149,85,149,85,149,85,149
	db 85,149,85,149,85,181,85,149,85,149,85,149,85,149,85,149
	db 106,85,106,85,106,213,106,85,106,85,106,85,106,85,106,85
	db 85,85,85,85,87,85,85,85,85,85,85,85,85,85,85,85
	db 213,87,213,87,213,87,213,87,213,87,213,87,213,87,213,87
	db 85,85,85,85,93,85,85,85,85,85,85,85,85,85,85,85
	db 245,127,85,127,213,127,213,127,213,127,213,127,213,127,213,127
	db 87,85,85,85,102,85,86,85,86,85,86,85,86,85,86,85
	db 85,95,85,94,149,90,85,90,85,90,85,90,85,90,85,90
	db 170,149,170,149,170,157,170,149,170,149,170,149,170,149,170,149
_pano_city_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 5,5,5,5,5,5,5,6,7,8,9,5,5,5,5,5
	db 5,5,5,5,5,5,5,6,7,8,9,5,5,5,5,5
	db 10,11,12,10,10,10,13,14,14,14,15,16,17,10,10,10
	db 10,11,12,10,10,10,13,14,14,14,15,16,17,10,10,10
	db 18,19,20,21,22,23,24,25,25,25,26,27,28,29,18,30
	db 18,19,20,21,22,23,24,25,25,25,26,27,28,29,18,30
	db 31,32,33,34,35,0,36,37,38,39,40,41,42,43,44,45
	db 44,46,47,48,35,49,50,51,52,53,54,55,56,43,31,32
	db 57,58,59,60,61,0,62,63,64,65,66,67,68,43,69,59
	db 70,59,71,72,73,74,75,76,0,77,0,67,68,78,57,58
_pano_city_map_pal:
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,1,1,2,0,0,0,0,1,1,1,1,1
	db 1,1,1,1,1,1,2,0,0,0,0,1,1,1,1,1
	db 1,1,1,1,1,1,2,0,0,0,2,1,1,1,1,1
	db 1,1,1,1,1,1,2,0,0,0,2,1,1,1,1,1
	db 3,1,3,1,1,1,1,4,4,4,1,3,3,1,1,3
	db 1,3,1,3,1,3,1,4,4,4,1,1,3,1,3,1
	db 1,3,1,3,3,1,3,5,6,5,3,1,1,1,3,1
	db 3,1,3,3,1,3,1,5,1,5,1,1,1,3,1,3
	align 2
_pano_city_pals:
	db 155,7,124,10,159,8,239,9,155,7,36,6,159,8,207,8
	db 155,7,159,8,207,8,239,9,155,7,36,6,207,8,223,7
	db 155,7,36,6,159,8,239,9,155,7,36,6,207,8,239,9
	db 155,7,36,6,223,7,239,9,155,7,53,10,88,11,124,10
	align 2
_pano_lake_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,87,245,95,253,255,255,255,255
	db 85,85,85,85,85,85,85,85,85,85,85,213,149,245,89,253
	db 85,85,85,85,85,85,85,85,85,85,85,85,149,149,89,89
	db 85,85,85,85,85,85,85,85,85,85,85,85,151,151,255,95
	db 85,85,85,85,85,85,85,85,85,253,95,253,255,255,255,255
	db 85,85,85,85,85,85,85,85,87,85,87,85,159,191,255,255
	db 255,255,255,255,170,170,170,170,170,170,170,170,170,170,170,170
	db 253,255,254,255,170,170,170,170,170,170,170,170,170,170,170,170
	db 153,153,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,85,85,85,85,85,85,85,85,87,85,255,87
	db 170,170,170,170,85,85,85,85,85,253,95,253,255,255,255,255
	db 169,170,169,170,85,85,85,85,85,85,85,213,85,245,85,253
	db 153,153,170,170,170,170,170,170,170,170,170,170,191,170,255,170
	db 153,153,170,170,170,170,170,170,254,170,254,170,255,235,255,255
	db 153,153,170,170,170,170,170,170,250,171,250,175,254,255,255,255
	db 153,153,170,170,170,170,170,170,170,170,234,191,234,255,255,255
	db 153,153,170,170,170,170,170,170,170,170,170,170,170,170,170,254
	db 159,153,175,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,191,255,191,170,170,170,170,170,170,170,170,170,170,170,170
	db 251,255,251,255,170,170,170,170,170,170,170,170,170,170,170,170
	db 250,255,250,255,170,170,170,170,170,170,170,170,170,170,170,170
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 170,170,174,174,234,234,187,187,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,127,253,127,85
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,175,169,166
	db 255,255,255,255,255,255,245,255,85,255,85,253,85,213,85,85
	db 255,255,255,255,255,95,255,95,85,85,85,85,85,85,85,85
	db 255,255,255,255,191,170,155,170,154,85,90,85,106,85,105,85
	db 255,255,255,255,255,255,255,255,255,255,255,127,255,111,255,107
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,111,169,105
	db 255,255,255,255,191,170,167,170,166,85,166,85,154,85,154,85
	db 255,255,255,255,255,255,255,255,255,255,255,191,255,159,255,155
	db 245,255,245,127,101,102,101,102,101,102,101,102,101,102,101,102
	db 105,85,105,85,105,85,105,85,105,85,105,85,105,89,105,89
	db 253,251,233,235,169,239,169,239,169,191,233,190,233,190,233,254
	db 85,85,85,85,85,85,85,85,102,85,105,85,105,85,102,85
	db 105,86,105,86,105,86,105,86,105,86,105,86,105,102,105,166
	db 254,166,250,166,251,166,251,166,239,166,239,166,175,166,191,166
	db 255,169,191,169,175,165,167,166,166,150,150,154,154,90,90,106
	db 255,255,255,255,255,255,255,255,255,159,171,154,169,154,89,105
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,175,191,166
	db 255,255,255,255,255,255,255,255,255,255,255,255,245,255,213,255
	db 255,255,255,255,253,255,213,255,85,245,85,85,85,85,85,85
	db 126,255,126,213,106,85,107,85,107,85,107,85,107,85,107,85
	db 255,255,255,175,255,166,154,166,154,150,153,154,105,154,105,106
	db 255,255,213,255,85,253,85,213,85,213,85,85,85,85,85,85
	db 253,190,233,254,233,251,233,251,233,235,169,239,169,239,169,191
	db 175,166,191,166,190,166,254,166,250,166,251,166,251,166,239,166
	db 255,90,127,106,111,106,107,169,169,169,169,165,165,166,166,150
	db 255,255,255,255,255,255,255,255,255,175,171,166,170,166,90,149
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,111,191,105
	db 127,255,127,213,107,85,106,85,106,85,106,85,107,85,107,85
	db 255,255,255,111,255,105,166,105,166,169,165,166,153,166,153,150
	db 102,102,102,102,170,170,170,170,170,170,170,170,170,170,170,170
	db 190,174,190,174,255,255,255,255,253,255,213,255,85,255,85,253
	db 255,255,255,255,255,255,85,245,85,85,85,85,85,85,85,85
	db 255,255,255,255,255,127,87,85,85,85,85,85,85,85,85,85
	db 255,255,255,255,255,255,255,255,255,95,255,85,127,85,95,85
	db 190,170,254,170,170,170,170,170,170,170,170,174,186,170,170,170
	db 191,191,191,254,170,186,234,170,171,170,170,170,170,170,170,170
	db 170,190,171,190,170,170,170,170,170,170,170,174,186,170,170,170
	db 239,251,239,235,170,186,234,170,171,170,169,170,149,170,85,170
	db 255,255,251,255,170,170,170,170,106,170,85,85,85,85,85,85
	db 255,255,255,255,170,186,234,170,171,170,170,90,170,85,106,85
	db 85,255,85,253,170,170,170,170,170,170,170,174,186,170,170,170
	db 85,85,85,85,170,186,234,170,171,170,170,170,170,170,170,170
	db 191,174,191,174,255,255,255,255,255,255,127,255,85,213,85,85
	db 190,190,250,190,170,186,234,170,171,170,170,170,170,170,170,170
	db 85,85,101,85,170,170,170,170,170,170,170,174,186,170,170,170
	db 239,170,174,170,170,170,170,170,170,170,170,174,186,170,170,170
	db 235,239,239,175,170,186,234,170,171,170,170,170,170,170,170,170
	db 175,238,174,238,170,170,170,170,170,170,170,174,186,170,170,170
	db 251,190,251,254,170,186,234,170,171,170,169,170,149,170,85,170
	db 255,255,254,255,170,170,170,170,106,170,85,85,85,85,85,85
	db 238,239,190,239,170,186,234,170,171,170,170,170,170,170,170,170
	db 170,174,186,170,170,170,170,170,170,170,170,234,170,171,174,170
	db 170,170,102,170,170,234,170,171,174,170,170,170,170,170,170,170
	db 170,174,118,102,170,170,170,170,170,170,170,234,170,171,174,170
	db 170,170,102,102,170,234,170,171,174,170,170,170,170,170,170,170
	db 170,174,122,102,170,170,170,170,170,170,170,234,170,171,174,170
	db 170,170,170,170,170,234,170,171,174,170,170,170,170,170,170,170
	db 170,174,153,170,170,170,170,170,170,170,170,234,170,171,174,170
	db 170,170,153,153,170,234,170,171,174,170,170,170,170,170,170,170
	db 170,174,186,153,170,170,170,170,170,170,170,234,170,171,174,170
	db 170,174,186,106,170,170,170,170,170,170,170,234,170,171,174,170
_pano_lake_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,2,3,3,3,4,5,2,3,3,3,3,3,3,3,6
	db 1,2,3,3,3,4,5,2,3,3,3,3,3,3,3,6
	db 7,8,9,9,9,10,11,12,13,14,15,16,17,9,18,7
	db 7,8,9,9,9,10,11,12,13,14,15,16,17,9,18,7
	db 19,19,19,19,19,20,7,21,7,7,7,7,22,19,19,19
	db 19,19,19,19,19,20,7,21,7,7,7,7,22,19,19,19
	db 23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23
	db 23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23
	db 19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19
	db 19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19
	db 24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24
	db 24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24
	db 25,26,27,28,29,30,31,25,25,25,25,25,25,25,25,25
	db 25,26,32,28,29,33,34,25,25,25,25,25,25,25,25,25
	db 35,36,37,38,39,40,41,42,43,25,25,44,45,46,47,48
	db 35,36,49,38,39,50,51,52,53,25,25,44,45,54,55,48
	db 56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71
	db 56,57,58,59,60,72,73,74,75,76,66,67,68,69,77,71
	db 78,79,80,81,82,83,78,83,84,85,86,83,78,81,87,83
	db 78,79,80,81,82,83,78,83,84,85,86,83,78,81,87,83
_pano_lake_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,0,0,0,5,5,5,0,0,0,0,0,0,1,1
	db 1,1,0,0,0,5,5,5,0,0,0,0,0,0,1,1
	db 0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0
	db 0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,6,5,6,6,5,5,5,5,5,5,5,5,5,5,5
	db 5,6,5,6,6,5,5,5,5,5,5,5,5,5,5,5
	db 2,2,2,2,2,2,5,5,5,5,5,6,6,2,5,6
	db 2,2,2,2,2,2,5,5,5,5,5,6,6,2,5,6
	db 2,3,3,3,3,2,2,2,4,4,7,6,2,3,2,2
	db 2,3,3,3,3,2,2,2,4,4,7,6,2,3,2,2
	db 2,4,4,4,4,2,2,2,4,4,4,2,2,4,4,2
	db 2,4,4,4,4,2,2,2,4,4,4,2,2,4,4,2
	align 2
_pano_lake_pals:
	db 202,8,103,13,137,14,239,15,202,8,103,13,137,14,188,14
	db 202,8,69,9,134,11,171,13,202,8,163,4,69,9,134,11
	db 202,8,163,4,134,11,171,13,202,8,137,14,171,14,205,14
	db 202,8,69,9,134,11,205,14,202,8,163,4,134,11,205,14
	align 2
_pano_canyon_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,89,89
	db 149,149,102,102,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,234,234,174,174,238,238,255,255,255,255,255,255
	db 255,127,255,107,255,105,175,105,167,101,166,102,150,102,154,90
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,254,255,214,255
	db 255,127,255,103,255,102,159,102,155,90,154,90,106,90,106,106
	db 255,127,255,91,255,90,111,90,107,106,105,105,169,105,165,101
	db 239,111,191,111,191,127,190,126,254,126,250,186,251,187,235,187
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,191
	db 255,255,255,255,255,111,255,102,155,102,154,86,154,90,106,90
	db 255,255,255,255,255,255,255,255,255,255,255,171,170,170,170,170
	db 170,170,170,170,170,170,170,170,234,234,174,174,238,238,255,255
	db 255,255,255,255,253,255,213,255,85,245,85,85,85,85,85,85
	db 86,253,86,213,86,85,86,85,86,85,86,85,86,85,102,85
	db 255,255,255,255,255,255,245,255,213,255,85,253,85,245,85,213
	db 190,126,254,126,250,122,251,123,235,123,239,175,239,175,191,175
	db 170,170,170,170,170,170,170,170,234,234,174,174,238,238,255,127
	db 255,255,255,255,255,95,255,90,107,90,105,106,105,105,165,105
	db 255,255,255,255,255,255,245,255,213,255,85,253,85,245,85,85
	db 251,123,235,123,239,111,239,111,191,111,191,191,190,190,254,190
	db 255,255,255,255,255,111,255,105,167,105,166,105,166,102,154,102
	db 255,255,255,255,255,255,255,255,255,255,255,155,169,154,169,154
	db 239,111,239,111,187,175,187,191,186,190,250,190,250,170,187,170
	db 255,159,255,154,111,90,105,106,105,105,169,169,165,169,165,166
	db 190,127,190,126,250,126,251,126,251,123,239,123,239,107,239,111
	db 86,165,86,165,86,165,86,153,85,153,85,153,85,105,86,105
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,245,255
	db 85,85,86,85,86,85,86,85,85,89,85,89,150,89,150,89
	db 103,85,103,85,166,85,166,85,166,85,154,85,154,85,170,86
	db 85,213,85,213,85,149,85,149,85,149,85,217,85,217,85,217
	db 191,127,190,126,250,190,250,186,251,187,235,186,235,174,171,174
	db 255,111,255,105,175,169,165,169,165,166,149,166,153,150,153,154
	db 251,126,251,123,239,123,239,107,239,111,191,111,190,127,174,126
	db 86,153,85,153,85,153,85,105,86,105,86,105,86,165,86,165
	db 85,149,85,149,85,213,85,213,85,213,85,217,85,217,85,217
	db 250,122,251,123,235,187,235,175,235,175,187,174,187,174,186,174
	db 255,175,255,166,159,166,153,150,153,154,105,90,105,106,105,105
	db 239,107,239,111,191,111,190,127,190,126,250,126,251,126,235,123
	db 85,105,86,105,86,105,86,165,86,165,86,165,86,153,85,153
	db 102,85,102,85,166,85,166,85,166,85,154,85,154,85,170,86
	db 85,213,85,213,85,213,85,213,85,213,85,153,85,153,85,153
	db 171,106,170,110,170,174,170,174,170,170,170,170,170,170,170,170
	db 233,251,237,235,238,239,190,175,190,191,189,186,189,250,186,250
	db 175,111,174,127,174,126,170,126,170,126,170,123,174,187,174,171
	db 86,101,86,165,86,165,86,101,86,85,85,85,85,85,85,85
	db 245,255,245,255,165,234,165,170,165,170,165,170,165,234,165,234
	db 150,86,150,86,150,90,154,90,89,154,105,90,170,89,166,169
	db 106,86,106,90,170,89,166,89,166,90,154,102,154,166,170,154
	db 85,217,89,233,154,230,154,166,154,170,89,154,105,154,166,169
	db 171,110,170,110,170,174,170,174,170,170,170,170,170,170,170,170
	db 189,175,189,191,190,190,254,254,250,254,249,251,169,251,174,235
	db 234,126,170,126,170,123,174,123,174,107,174,111,174,175,174,191
	db 86,165,86,149,85,149,85,85,85,85,86,85,86,85,86,85
	db 245,191,245,191,165,170,165,234,165,234,165,234,165,234,165,234
	db 85,153,89,169,154,166,154,230,154,234,89,154,105,154,166,169
	db 170,110,170,106,170,170,170,170,170,170,170,170,170,170,170,170
	db 253,254,249,254,250,251,234,251,238,235,237,235,189,171,190,187
	db 239,123,174,107,174,111,174,111,174,127,174,126,170,190,170,190
	db 85,149,85,101,86,101,86,101,86,85,86,85,86,85,86,85
	db 245,255,245,255,165,234,165,234,165,234,165,234,165,170,165,170
	db 85,217,89,233,154,230,154,230,154,234,89,154,105,154,166,169
	db 170,106,170,106,170,170,170,170,170,170,170,170,170,170,170,170
	db 186,251,170,250,174,234,174,234,190,170,189,186,189,186,190,186
	db 170,175,170,170,170,122,170,122,170,186,170,186,170,170,170,170
	db 86,85,86,85,86,85,86,85,85,85,85,85,85,85,85,85
	db 169,234,169,234,169,234,165,234,165,170,170,170,170,170,171,234
	db 166,166,154,166,154,170,170,154,106,154,171,106,255,106,255,191
	db 106,154,106,170,170,105,166,105,170,170,254,255,255,255,255,255
	db 166,169,170,170,154,166,154,166,170,170,105,250,105,175,246,170
	db 174,235,190,170,190,186,190,186,190,250,185,186,185,186,170,186
	db 170,190,170,186,170,122,170,122,170,186,170,170,170,170,170,170
	db 86,85,86,85,86,85,85,85,85,85,85,85,85,85,85,85
	db 169,234,169,170,169,170,165,170,165,234,170,234,170,234,171,234
	db 190,186,190,250,186,250,186,250,170,250,173,170,173,170,190,170
	db 170,187,170,186,170,106,170,106,170,170,170,186,170,170,170,170
	db 85,85,85,85,85,85,86,85,85,85,85,85,85,85,85,85
	db 169,170,169,234,169,234,165,234,165,234,170,234,170,234,171,170
	db 170,234,170,170,170,254,255,255,255,255,255,255,255,255,255,255
	db 170,170,170,170,170,170,255,255,255,255,255,255,255,255,255,255
	db 171,170,255,170,255,255,255,255,255,255,255,255,255,255,255,255
	db 250,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
_pano_canyon_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 5,6,6,6,6,6,7,6,8,6,6,6,6,6,7,6
	db 9,6,6,6,6,6,7,6,5,6,6,6,6,6,7,6
	db 10,11,12,13,14,15,16,17,18,19,20,13,14,15,16,21
	db 22,11,23,24,14,15,16,17,10,11,12,13,14,15,16,17
	db 25,26,27,28,29,30,31,32,33,34,35,36,29,30,31,37
	db 38,39,40,41,29,30,42,43,25,26,27,28,29,30,31,32
	db 44,45,46,47,48,49,50,51,52,53,54,55,56,49,50,57
	db 58,59,60,61,62,49,50,63,44,45,46,47,48,49,50,51
	db 64,65,66,67,68,69,70,71,64,72,73,74,75,69,70,71
	db 64,76,77,78,79,69,70,71,64,65,66,67,68,69,70,71
	db 80,81,81,81,82,6,6,83,80,81,81,81,82,6,6,83
	db 80,81,81,81,82,6,6,83,80,81,81,81,82,6,6,83
_pano_canyon_map_pal:
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 6,0,0,0,0,0,7,0,6,0,0,0,0,0,7,0
	db 6,0,0,0,0,0,0,0,6,0,0,0,0,0,7,0
	db 4,6,6,6,1,0,7,0,4,1,6,6,1,0,7,0
	db 4,6,6,6,1,0,7,0,4,6,6,6,1,0,7,0
	db 4,2,4,2,0,0,4,4,4,2,4,2,0,0,4,4
	db 4,2,4,2,0,0,0,4,4,2,4,2,0,0,4,4
	db 4,4,4,2,4,0,0,4,4,4,4,2,4,0,0,4
	db 4,4,4,2,4,0,0,4,4,4,4,2,4,0,0,4
	db 0,4,4,2,4,5,5,4,0,4,4,2,4,5,5,4
	db 0,4,4,2,4,5,5,4,0,4,4,2,4,5,5,4
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	align 2
_pano_canyon_pals:
	db 156,7,69,5,120,8,191,8,156,7,120,8,191,8,223,10
	db 156,7,120,8,171,10,223,10,156,7,142,5,159,6,191,8
	db 156,7,69,5,120,8,171,10,156,7,69,5,120,8,105,6
	db 156,7,120,8,171,10,191,8,156,7,69,5,171,10,191,8
	align 2
_pano_caves_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,85,85,149,149,89,89
	db 85,85,85,85,85,85,85,85,85,85,85,85,245,151,253,95
	db 85,85,85,85,85,85,85,85,85,85,213,95,245,191,255,255
	db 85,85,85,85,85,85,85,85,85,85,85,127,151,255,255,255
	db 85,85,85,85,85,85,85,85,85,85,85,253,151,253,127,255
	db 85,85,85,85,85,85,85,85,85,85,85,85,149,245,95,253
	db 85,85,85,85,85,85,85,85,85,85,85,85,149,149,125,217
	db 153,153,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,170,255,191,255,191,170,170,170,170,170,170,170,170,170,170
	db 255,255,255,255,255,255,170,170,170,170,170,170,170,170,170,170
	db 255,255,255,255,255,255,175,170,175,170,170,170,170,170,170,170
	db 255,255,255,255,255,255,255,255,255,255,170,170,170,170,170,170
	db 255,234,255,255,255,255,255,255,255,255,170,170,170,170,170,170
	db 250,170,254,235,255,255,255,255,255,255,170,170,170,170,170,170
	db 153,153,170,170,170,255,254,255,254,255,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,170,250,171
	db 213,213,93,93,221,221,255,255,255,255,255,255,255,255,239,254
	db 170,170,170,170,170,170,170,170,169,170,165,170,165,170,149,170
	db 254,245,190,213,190,85,187,85,187,85,171,85,175,85,175,85
	db 85,85,85,213,85,245,85,251,213,251,237,235,239,239,175,175
	db 251,245,187,213,171,85,175,85,175,85,191,85,190,85,190,85
	db 85,85,85,213,85,229,85,239,149,175,189,191,190,190,254,254
	db 239,245,175,213,191,85,190,85,190,85,190,85,187,85,187,85
	db 85,85,85,149,85,181,85,190,213,254,249,254,251,251,251,251
	db 149,170,85,170,85,169,85,165,85,213,85,213,93,213,93,213
	db 191,86,190,101,190,101,190,102,187,102,187,102,171,106,175,90
	db 191,191,190,190,254,254,250,254,251,187,251,187,239,171,239,175
	db 170,234,170,250,170,250,170,254,170,254,170,254,170,255,170,255
	db 170,170,170,170,170,170,169,170,165,170,149,170,85,170,85,165
	db 85,85,85,85,149,175,181,175,190,171,254,170,254,170,251,170
	db 190,86,187,101,187,101,171,102,175,102,175,102,191,106,190,90
	db 250,254,251,251,251,251,239,235,239,175,175,175,191,191,190,190
	db 170,170,170,170,234,95,250,95,255,95,255,95,255,95,255,95
	db 171,86,175,101,175,101,191,102,190,102,190,102,190,106,187,90
	db 239,235,239,239,175,175,191,191,190,190,254,190,250,190,251,187
	db 90,149,102,149,102,149,170,149,170,149,154,149,153,149,169,149
	db 175,90,175,105,174,105,174,106,174,166,170,166,170,170,170,154
	db 175,171,191,171,190,170,254,170,250,170,251,171,251,171,239,171
	db 213,234,213,175,245,191,245,191,245,255,233,255,169,255,171,250
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,169,170
	db 170,170,165,170,85,170,85,169,85,165,85,149,85,85,85,85
	db 85,149,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 251,91,235,91,239,91,175,91,191,91,190,91,254,90,254,90
	db 190,90,174,105,171,105,171,106,171,166,174,166,174,170,174,154
	db 254,186,250,170,251,171,251,171,239,171,239,171,175,171,191,171
	db 213,191,213,255,229,255,165,255,165,250,189,234,253,234,255,175
	db 175,91,191,91,190,91,254,90,254,90,251,90,251,91,235,91
	db 187,90,171,105,175,105,175,106,175,166,174,166,174,170,174,154
	db 251,187,239,171,239,171,175,171,191,171,190,170,254,170,250,170
	db 149,255,149,250,181,234,245,234,245,175,253,191,253,191,254,255
	db 254,90,254,90,251,90,251,91,235,91,239,91,175,91,191,91
	db 170,149,102,149,102,149,170,153,170,169,154,169,153,170,169,166
	db 174,154,174,169,170,105,170,106,170,166,170,166,170,170,170,154
	db 239,171,175,171,191,171,190,170,254,170,186,170,170,170,170,170
	db 191,234,255,234,255,171,255,187,255,187,254,251,234,251,170,251
	db 165,170,149,234,85,218,85,223,85,95,85,125,85,125,85,253
	db 85,85,85,85,85,85,85,85,85,86,149,101,149,101,165,102
	db 85,153,85,89,85,105,85,165,86,165,85,169,89,153,106,153
	db 251,90,251,91,235,91,239,91,175,107,191,107,190,171,190,170
	db 190,170,254,170,250,170,251,171,251,171,175,170,170,170,170,170
	db 255,191,255,191,254,251,234,251,170,251,171,250,191,234,255,234
	db 165,170,149,106,85,122,85,127,85,255,85,253,85,245,85,245
	db 239,91,175,91,191,91,190,91,254,106,190,106,186,170,186,171
	db 170,154,170,169,170,105,170,106,170,166,170,166,170,170,170,154
	db 251,171,251,171,239,171,239,171,175,171,191,170,170,170,170,170
	db 234,255,170,255,171,250,191,234,255,234,255,171,255,187,255,187
	db 165,170,149,234,85,250,85,247,85,247,85,213,85,221,85,93
	db 190,91,254,90,254,90,251,90,251,107,171,107,174,171,174,171
	db 170,166,102,170,102,154,170,154,170,169,154,169,153,170,169,166
	db 213,223,85,253,85,117,85,117,85,213,85,213,85,213,85,85
	db 255,255,255,95,255,87,255,87,255,85,255,85,255,85,127,85
	db 171,250,191,234,255,234,191,171,191,171,191,171,190,171,170,171
	db 85,254,89,250,89,250,106,234,166,238,166,174,170,190,154,190
	db 149,170,85,169,85,165,85,165,85,149,85,149,85,149,85,85
	db 251,254,251,94,255,86,239,87,239,85,254,85,190,85,127,85
	db 190,154,186,154,186,107,170,107,170,170,170,170,170,170,170,170
	db 255,171,255,187,255,171,190,235,170,171,170,171,171,170,191,170
	db 85,234,89,238,89,174,106,190,166,190,166,254,170,254,154,250
	db 170,155,170,155,170,107,170,107,170,170,170,170,170,170,170,170
	db 254,251,234,251,170,235,171,234,191,170,191,170,191,171,191,171
	db 85,190,89,190,89,254,106,254,166,250,166,250,170,234,154,238
	db 190,155,186,155,186,106,170,106,170,170,170,170,170,170,170,170
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,213,85,213
	db 127,85,127,85,127,85,127,85,127,85,127,85,255,85,255,85
	db 154,190,169,190,105,186,106,186,166,170,166,174,170,174,154,190
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,149,85,149
	db 119,85,119,85,127,85,95,85,95,85,125,85,125,85,127,85
	db 170,154,170,154,170,106,170,106,170,170,170,170,170,170,170,170
	db 191,170,190,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 154,186,169,170,105,174,106,174,166,190,166,190,170,190,154,190
	db 154,174,169,190,105,190,106,190,166,190,166,186,170,186,154,170
_pano_caves_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,2,3,4,5,6,7,1,1,1,1,1,1,1
	db 1,1,1,2,3,4,5,6,7,1,1,1,1,1,1,1
	db 8,8,9,10,10,11,12,12,13,14,15,8,8,8,8,8
	db 8,8,9,10,10,11,12,12,13,14,15,8,8,8,8,8
	db 16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
	db 16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
	db 17,18,17,17,17,17,17,17,17,18,17,17,17,17,17,17
	db 17,19,17,17,17,17,17,17,17,18,17,17,17,17,17,17
	db 20,21,22,16,16,16,16,16,20,23,24,16,16,16,16,16
	db 20,25,26,16,16,16,16,16,20,21,22,16,16,16,16,16
	db 27,28,29,30,16,16,31,32,27,33,34,30,16,16,31,35
	db 27,36,37,30,16,16,31,35,27,28,29,30,16,16,31,32
	db 38,39,40,41,42,43,44,45,38,46,47,48,42,43,44,49
	db 38,50,51,52,42,43,44,53,38,39,40,41,42,43,44,45
	db 54,55,56,57,58,59,60,61,54,55,62,63,64,59,60,65
	db 54,66,67,68,69,59,60,70,54,55,56,57,58,59,60,61
	db 71,72,73,74,75,76,77,78,71,72,73,79,80,76,77,81
	db 71,72,73,82,83,76,77,84,71,72,73,74,75,76,77,78
	db 71,85,86,16,87,88,89,90,71,85,86,91,92,88,89,90
	db 71,85,86,91,93,88,89,90,71,85,86,16,87,88,89,90
_pano_caves_map_pal:
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,5,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 1,0,6,1,1,1,1,1,1,0,6,1,1,1,1,1
	db 1,0,6,1,1,1,1,1,1,0,6,1,1,1,1,1
	db 1,0,0,4,1,1,1,6,1,0,0,4,1,1,1,7
	db 1,0,0,4,1,1,1,7,1,0,0,4,1,1,1,6
	db 0,0,0,6,1,1,1,0,0,0,0,6,1,1,1,0
	db 0,0,0,6,1,1,1,0,0,0,0,6,1,1,1,0
	db 0,0,0,0,7,0,0,0,0,0,0,0,7,0,0,0
	db 0,0,0,0,7,0,0,0,0,0,0,0,7,0,0,0
	db 0,2,2,0,0,2,2,0,0,2,2,0,0,2,2,0
	db 0,2,2,0,0,2,2,0,0,2,2,0,0,2,2,0
	db 0,2,2,0,0,2,2,0,0,2,2,0,0,2,2,0
	db 0,2,2,0,0,2,2,0,0,2,2,0,0,2,2,0
	align 2
_pano_caves_pals:
	db 138,6,53,2,104,4,155,6,138,6,53,2,182,11,104,4
	db 138,6,0,0,53,2,104,4,138,6,97,8,130,10,201,12
	db 138,6,130,10,182,11,155,6,138,6,130,10,53,2,182,11
	db 138,6,182,11,104,4,155,6,138,6,53,2,182,11,155,6
	align 2
_pano_snow_tiles:
	db 85,85,85,85,85,85,85,85,85,85,95,245,127,253,255,255
	db 85,85,85,85,85,85,85,85,85,85,85,213,127,213,255,245
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,85,93,215,127,255,255
	db 85,85,85,85,85,85,85,85,87,253,95,253,255,255,255,255
	db 85,85,85,85,85,85,85,85,85,245,95,245,127,253,255,255
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,213,213,245
	db 85,85,85,85,85,85,85,85,85,85,87,85,87,125,95,255
	db 255,255,255,255,255,255,127,253,255,255,255,255,255,255,85,85
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,85,85
	db 245,255,255,255,255,255,85,213,213,255,253,255,253,255,85,85
	db 85,85,85,213,85,213,85,85,85,85,85,85,85,85,89,89
	db 255,87,255,87,85,85,85,85,85,85,85,85,85,85,213,95
	db 255,255,255,255,85,85,85,85,85,85,85,85,85,85,85,125
	db 255,255,255,255,85,85,85,85,85,85,85,85,85,85,89,89
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,89,89
	db 223,87,255,255,255,255,85,85,85,85,85,85,85,85,85,85
	db 255,255,255,255,255,255,85,85,87,85,255,85,255,85,85,85
	db 149,149,102,102,170,170,170,170,170,170,170,170,170,170,170,170
	db 149,149,254,102,255,171,255,255,255,255,170,170,170,170,170,170
	db 245,95,255,127,255,255,170,170,170,170,85,85,85,85,85,85
	db 85,255,213,255,255,255,170,170,170,170,85,85,85,85,85,85
	db 149,149,102,102,170,234,170,254,170,254,170,170,170,170,170,170
	db 85,85,93,93,213,213,119,119,255,255,255,255,255,255,255,255
	db 85,85,93,93,213,213,119,119,255,255,255,255,255,255,234,255
	db 85,85,89,89,149,149,102,102,170,170,170,170,170,127,234,127
	db 170,170,170,170,170,170,170,170,170,234,170,234,170,250,170,250
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,171,170,151,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,165,250,213,255
	db 254,255,234,255,170,254,170,250,170,234,170,170,170,170,170,170
	db 85,255,85,255,85,170,85,170,85,170,85,170,85,170,85,170
	db 250,90,250,91,251,91,235,91,239,91,175,91,191,91,191,90
	db 186,91,190,90,254,90,254,90,250,91,251,91,235,91,239,91
	db 170,254,170,255,170,255,238,255,250,255,251,255,255,255,255,255
	db 170,170,170,170,170,170,174,174,234,234,187,187,255,255,255,255
	db 170,170,170,170,170,170,174,174,234,234,187,187,253,255,253,255
	db 87,170,87,169,87,165,87,149,87,213,87,85,87,85,87,85
	db 213,159,149,153,149,153,149,153,149,153,149,153,149,153,165,153
	db 85,85,85,85,85,85,105,85,106,85,102,89,102,90,90,86
	db 85,170,89,170,89,170,85,170,86,170,90,170,90,170,106,170
	db 254,90,254,90,250,155,251,155,235,155,239,155,175,91,191,90
	db 175,91,191,91,191,154,254,154,254,154,250,155,251,91,235,90
	db 235,255,175,239,191,238,191,238,255,234,254,235,254,170,234,174
	db 170,238,170,239,190,175,190,191,254,190,250,254,251,250,251,251
	db 170,170,170,170,170,170,169,234,213,251,213,251,149,250,149,238
	db 170,170,234,170,250,149,187,85,187,85,175,85,175,85,175,85
	db 170,170,170,170,170,170,170,234,170,234,170,238,170,175,191,191
	db 170,170,170,170,170,170,170,170,151,170,87,169,86,149,86,85
	db 170,170,170,170,169,170,149,170,85,253,85,253,85,169,85,169
	db 170,171,190,151,190,86,254,86,250,86,251,86,251,86,239,86
	db 170,170,170,170,170,170,170,234,170,250,170,250,170,250,234,235
	db 170,170,170,170,170,170,170,170,170,170,169,170,149,170,85,169
	db 165,170,149,170,85,170,85,169,85,149,85,85,85,85,85,85
	db 86,85,86,85,86,85,86,101,86,101,86,102,150,102,154,102
	db 165,153,165,153,165,153,165,153,165,153,149,153,150,153,166,153
	db 90,86,106,90,105,90,105,90,170,89,166,89,166,90,154,86
	db 106,170,105,170,105,170,166,170,166,170,154,170,154,170,170,170
	db 191,154,254,154,254,154,250,154,186,154,170,154,174,90,170,90
	db 254,171,250,175,235,175,235,239,175,239,191,238,191,238,239,234
	db 170,250,234,251,238,251,239,239,175,239,191,175,190,191,254,190
	db 170,170,170,170,170,170,169,170,213,191,213,191,149,254,149,250
	db 170,170,234,170,254,149,190,85,190,85,186,85,187,85,187,85
	db 170,170,170,170,170,170,170,234,170,250,170,250,234,251,239,235
	db 234,171,238,151,239,86,175,86,191,86,190,86,254,86,250,86
	db 170,170,170,170,170,170,170,170,170,186,170,186,170,254,234,254
	db 239,154,175,154,191,154,191,154,190,154,190,154,186,90,186,90
	db 235,174,235,238,175,238,175,238,175,238,239,234,238,234,238,170
	db 239,251,239,239,175,239,191,175,190,191,254,190,250,254,251,250
	db 149,238,149,174,149,190,149,190,149,254,149,250,153,250,153,250
	db 191,85,190,85,190,101,186,101,187,101,187,101,175,102,175,166
	db 191,191,250,254,250,254,250,250,250,251,234,235,234,239,170,175
	db 86,85,86,85,86,85,86,85,86,85,86,85,106,85,106,85
	db 85,169,85,169,85,169,85,169,85,169,89,169,89,169,86,169
	db 239,86,175,102,191,102,190,102,254,102,250,102,251,166,251,154
	db 238,235,239,175,175,191,190,191,190,255,254,254,250,254,250,234
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,85,85,89,85,90,85,86,85,86,85,90,85,90,86
	db 90,106,90,154,154,154,166,169,166,169,154,106,154,102,170,166
	db 165,153,169,153,166,153,166,153,170,153,154,153,154,153,170,153
	db 154,166,170,170,105,154,105,154,170,169,166,105,166,106,154,166
	db 106,170,105,170,169,170,166,170,166,170,154,170,154,170,170,170
	db 186,154,186,154,186,154,170,154,170,154,170,154,170,90,170,90
	db 238,234,238,170,234,174,235,174,235,238,175,238,175,238,175,238
	db 250,254,251,250,251,251,239,251,239,239,175,239,191,175,190,187
	db 149,250,149,250,149,238,149,238,149,174,149,190,153,190,153,254
	db 175,85,175,85,175,101,191,101,190,101,190,101,186,102,187,166
	db 239,239,170,175,186,191,186,191,250,254,250,254,250,250,250,235
	db 251,86,251,102,239,102,239,102,175,102,191,102,190,166,254,154
	db 250,254,251,250,251,235,238,235,238,175,174,191,190,191,190,239
	db 170,154,170,154,170,154,170,154,170,154,170,154,170,90,170,90
	db 234,170,235,170,123,171,95,173,87,181,213,213,85,87,85,85
	db 251,251,235,251,234,234,170,234,234,170,122,187,94,189,87,245
	db 170,238,234,238,122,175,94,189,87,181,213,213,85,87,85,85
	db 175,170,191,170,190,170,190,170,250,170,122,171,94,173,87,181
	db 186,175,250,175,122,239,94,237,87,245,213,213,85,87,85,85
	db 187,174,187,175,175,171,175,171,255,175,127,175,95,173,87,181
	db 170,170,234,170,122,171,94,173,87,181,213,213,85,87,85,85
	db 239,170,239,170,175,170,191,170,254,170,126,171,94,173,87,181
	db 250,235,238,235,126,175,94,173,87,181,213,213,85,87,85,85
	db 190,170,191,170,187,174,187,175,239,171,127,171,95,173,87,181
	db 174,171,254,171,127,171,95,173,87,181,213,213,85,87,85,85
	db 191,255,191,239,255,239,251,254,251,254,127,191,95,189,87,245
	db 239,251,255,255,190,239,190,239,255,254,123,191,95,189,87,245
	db 255,239,255,239,255,239,255,239,255,239,127,239,95,173,87,181
	db 239,170,238,170,126,171,94,173,87,181,213,213,85,87,85,85
	db 254,186,250,250,234,250,234,250,234,250,122,235,94,237,87,181
	db 170,250,234,250,122,251,94,237,87,245,213,213,85,87,85,85
	db 187,170,175,170,175,170,175,170,255,170,126,171,94,173,87,181
	db 234,235,234,239,122,175,94,173,87,181,213,213,85,87,85,85
	db 250,170,251,170,251,170,239,170,238,170,126,171,94,173,87,181
	db 254,238,250,238,122,235,94,237,87,245,213,213,85,87,85,85
	db 85,85,213,85,85,87,85,85,85,85,213,85,85,87,85,85
	db 213,213,85,87,85,85,85,85,213,85,85,87,85,85,85,85
_pano_snow_map:
	db 0,1,2,2,2,3,4,5,6,2,2,2,2,2,2,7
	db 0,1,2,2,2,3,4,5,6,2,2,2,2,2,2,7
	db 8,9,10,11,12,13,14,14,14,15,15,15,15,15,16,17
	db 8,9,10,11,12,13,14,14,14,15,15,15,15,15,16,17
	db 18,18,18,19,20,21,22,18,18,18,18,18,18,18,18,18
	db 18,18,18,19,20,21,22,18,18,18,18,18,18,18,18,18
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 23,23,23,23,23,23,23,23,23,23,23,23,23,23,24,25
	db 23,23,23,23,23,23,23,23,23,23,23,23,23,23,24,25
	db 26,27,27,27,27,27,27,27,27,27,27,28,29,30,31,32
	db 26,27,27,27,27,27,27,27,27,27,27,28,29,30,31,33
	db 34,35,35,35,35,35,35,35,35,35,36,37,38,39,40,41
	db 34,35,35,35,35,35,35,35,35,35,36,37,38,39,40,42
	db 43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58
	db 59,60,61,62,63,48,49,64,65,52,53,54,55,56,57,66
	db 67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82
	db 83,84,85,86,87,72,73,88,89,76,77,78,79,80,81,90
	db 91,92,93,94,95,96,97,98,99,100,101,102,97,103,97,104
	db 105,106,107,108,109,96,97,110,111,100,101,102,97,103,97,104
	db 112,113,112,113,112,113,112,113,112,113,112,113,112,113,112,113
	db 112,113,112,113,112,113,112,113,112,113,112,113,112,113,112,113
_pano_snow_map_pal:
	db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	db 6,6,6,6,5,5,6,6,6,6,6,6,6,6,6,6
	db 6,6,6,6,5,5,6,6,6,6,6,6,6,6,6,6
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
	db 7,0,0,0,0,0,0,0,0,0,0,7,7,0,1,1
	db 7,0,0,0,0,0,0,0,0,0,0,7,7,0,1,1
	db 7,7,7,7,7,7,7,7,7,7,7,7,1,1,1,1
	db 7,7,7,7,7,7,7,7,7,7,7,7,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1
	db 2,2,2,2,2,3,2,2,2,3,4,3,2,3,2,3
	db 2,2,2,2,2,3,2,2,2,3,4,3,2,3,2,3
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	align 2
_pano_snow_pals:
	db 238,15,183,14,169,12,218,15,238,15,169,12,237,15,255,15
	db 238,15,66,3,237,15,255,15,238,15,66,3,169,12,237,15
	db 238,15,66,3,169,12,255,15,238,15,183,14,218,15,255,15
	db 238,15,149,13,183,14,255,15,238,15,169,12,218,15,237,15
	align 2
_pano_farm_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,89,89
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,127,89
	db 85,85,85,85,85,85,85,85,95,85,106,85,234,255,170,170
	db 85,85,127,85,255,85,255,213,255,255,170,170,170,170,170,170
	db 85,85,85,85,245,85,253,223,255,255,170,170,170,170,170,170
	db 85,85,85,85,85,85,85,85,245,87,245,175,255,175,170,170
	db 85,85,85,85,85,85,85,85,85,85,85,85,213,255,170,170
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,91,127
	db 85,85,85,85,85,85,85,85,85,85,85,85,87,253,95,253
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,213,89,249
	db 149,149,102,102,170,170,170,170,170,170,170,170,170,170,170,170
	db 149,149,102,102,170,170,170,170,170,170,171,170,255,175,255,175
	db 106,85,85,85,85,85,87,85,95,255,255,255,170,170,170,170
	db 170,170,85,85,95,213,127,245,255,253,255,255,170,170,170,170
	db 170,170,85,85,125,213,255,213,255,255,255,255,170,170,170,170
	db 170,170,85,85,85,85,85,85,253,215,255,255,170,170,170,170
	db 255,255,102,102,170,170,170,170,170,170,170,170,234,255,234,255
	db 170,170,247,87,170,106,170,106,170,86,85,85,85,85,85,85
	db 223,255,255,255,170,170,170,170,170,170,85,85,85,85,85,85
	db 255,255,255,255,170,170,170,170,170,170,85,85,85,85,85,85
	db 127,253,255,255,170,170,170,170,170,170,85,85,85,85,85,85
	db 149,149,102,246,250,255,250,255,170,250,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,89,89,149,149,102,102,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,174,174,234,234,187,187,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,247,255,213,255,85,255,85,253,85,213
	db 255,255,255,255,255,255,255,255,255,255,255,127,255,95,255,87
	db 255,255,253,255,85,85,85,85,86,85,170,170,170,170,169,170
	db 255,255,171,170,170,170,170,170,86,85,85,85,85,85,169,170
	db 255,255,253,255,255,95,255,85,127,85,87,165,85,170,149,170
	db 85,85,85,85,170,170,170,170,170,170,255,170,255,170,255,170
	db 255,85,127,85,255,170,255,170,255,170,255,170,255,170,255,170
	db 255,255,255,255,255,255,253,255,85,255,85,253,85,213,85,85
	db 255,255,255,255,170,254,170,85,106,85,85,85,85,85,85,85
	db 85,85,85,85,86,85,170,170,170,170,169,170,85,85,85,85
	db 170,170,170,170,86,85,85,85,85,85,169,170,170,170,170,170
	db 169,90,170,85,106,85,86,165,85,170,149,170,169,90,170,85
	db 255,85,255,85,255,85,255,85,170,170,170,170,170,170,170,170
	db 255,85,255,85,255,85,255,85,255,255,250,175,170,170,170,170
	db 250,255,233,255,165,255,165,250,149,234,85,170,89,165,106,149
	db 165,85,105,85,85,85,85,85,86,85,90,85,106,85,169,85
	db 90,85,106,85,170,85,85,169,85,85,85,85,170,86,170,170
	db 86,85,170,170,170,170,169,170,85,85,85,85,86,85,170,170
	db 86,85,85,85,85,85,169,170,170,170,170,170,86,85,85,85
	db 106,85,86,165,85,170,149,170,169,90,170,85,106,85,86,165
	db 149,106,165,90,170,86,106,149,90,165,85,169,149,106,165,90
	db 90,165,170,170,170,170,165,90,85,85,85,85,90,165,170,170
	db 170,85,165,90,149,106,85,170,90,165,106,149,170,85,165,90
	db 85,170,85,169,86,149,170,85,170,86,169,106,85,170,85,169
	db 170,170,85,169,85,85,85,85,170,86,170,170,170,170,85,169
_pano_farm_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,1,1,2,3,4,5,6,7,8,9,10,1
	db 1,1,1,1,1,1,2,3,4,5,6,7,8,9,10,1
	db 11,11,11,11,11,12,13,14,15,16,17,18,19,20,21,22
	db 11,11,11,11,11,12,13,14,15,16,17,18,19,20,21,22
	db 23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23
	db 23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23
	db 24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24
	db 24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24
	db 23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23
	db 23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23
	db 25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25
	db 25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25
	db 26,26,26,27,28,26,26,26,26,26,26,27,28,26,26,26
	db 26,26,26,27,28,26,26,26,26,26,26,27,28,26,26,26
	db 29,30,31,32,33,26,34,35,29,30,31,32,33,26,34,35
	db 29,30,31,32,33,26,34,35,29,30,31,32,33,26,34,35
	db 36,37,38,39,40,41,42,43,36,37,38,39,40,41,42,43
	db 36,37,38,39,40,41,42,43,36,37,38,39,40,41,42,43
	db 44,45,46,47,48,49,50,51,44,45,46,47,48,49,50,51
	db 44,45,46,47,48,49,50,51,44,45,46,47,48,49,50,51
_pano_farm_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,1,1,1,1,1,2,1,2,0
	db 0,0,0,0,0,0,0,1,1,1,1,1,2,1,2,0
	db 0,0,0,0,0,0,3,3,3,3,0,3,3,3,3,0
	db 0,0,0,0,0,0,3,3,3,3,0,3,3,3,3,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,6,6,4,4,4,4,4,4,6,6,4,4,4
	db 4,4,4,6,6,4,4,4,4,4,4,6,6,4,4,4
	db 5,5,5,6,6,4,5,5,5,5,5,6,6,4,5,5
	db 5,5,5,6,6,4,5,5,5,5,5,6,6,4,5,5
	db 5,5,5,7,7,5,5,5,5,5,5,7,7,5,5,5
	db 5,5,5,7,7,5,5,5,5,5,5,7,7,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	align 2
_pano_farm_pals:
	db 203,6,164,14,199,14,222,10,203,6,164,14,222,10,255,14
	db 203,6,164,14,199,14,255,14,203,6,199,14,222,10,255,14
	db 203,6,199,14,219,13,239,12,203,6,172,3,206,4,239,12
	db 203,6,23,1,43,2,239,12,203,6,43,2,172,3,239,12
	align 2
_pano_autobahn_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,85,85,95,85,127,245
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,213,85,213
	db 85,85,85,85,85,85,87,85,170,85,170,85,85,85,86,85
	db 95,85,95,85,127,245,255,255,170,170,170,170,255,85,170,170
	db 125,213,255,213,255,255,255,255,170,170,170,170,255,255,170,170
	db 85,85,85,85,213,215,253,255,170,170,170,170,255,255,170,170
	db 85,85,85,85,85,85,85,85,213,151,245,159,255,255,170,170
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,253,165,170
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,87,85
	db 255,255,255,255,170,170,170,170,85,85,85,85,85,85,85,85
	db 117,245,253,255,170,170,170,170,85,85,85,85,85,85,85,85
	db 149,149,89,89,153,153,170,170,170,170,170,170,186,170,254,170
	db 149,149,89,89,153,153,170,170,170,170,170,170,250,171,250,175
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,170,170,175
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 151,149,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 255,255,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 245,255,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,170,171,191
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,254,175,254
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,170,170,234
	db 151,149,127,89,255,159,255,175,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,87,85,106,85,106,85,85,85,85,85,85,85,85,85
	db 255,87,255,255,170,170,170,170,85,85,85,85,85,85,85,85
	db 253,255,255,255,170,170,170,170,85,85,85,85,85,85,85,85
	db 213,127,245,255,170,170,170,170,85,85,85,85,85,85,170,85
	db 85,85,85,85,85,165,85,165,87,95,215,127,255,255,170,170
	db 85,85,85,85,85,85,87,253,95,253,255,255,255,255,170,170
	db 85,85,85,85,85,85,85,213,85,245,93,253,255,255,170,170
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,213,85,169
	db 85,85,87,85,170,86,170,86,85,85,85,85,85,85,85,85
	db 223,255,255,255,170,170,170,170,85,85,85,85,85,85,85,85
	db 127,255,255,255,170,170,170,170,85,85,85,85,85,85,85,85
	db 85,245,85,253,170,170,170,170,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,91,89,159,149,127,102,255,175,170,170
	db 85,85,85,85,85,85,125,217,255,245,255,255,255,255,170,170
	db 85,85,85,85,85,85,89,89,149,149,102,166,170,170,170,170
	db 85,85,85,85,85,85,89,89,149,149,102,102,170,170,170,170
	db 170,85,85,85,85,85,89,89,149,149,102,102,170,170,170,170
	db 170,170,85,85,85,85,89,89,149,149,102,102,170,170,170,170
	db 85,169,85,85,85,85,89,89,149,149,102,102,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,234,234,174,174
	db 170,170,170,170,170,170,170,170,170,170,170,170,85,233,174,174
	db 170,170,170,170,170,106,170,106,170,106,170,106,90,85,174,110
	db 238,238,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 238,238,255,255,255,255,255,255,255,255,255,255,255,255,85,255
	db 238,238,255,255,255,255,255,255,255,255,255,255,255,255,255,95
	db 238,238,255,255,85,255,255,255,255,255,255,255,255,255,255,255
	db 238,110,255,127,127,85,255,127,255,127,255,127,255,127,255,127
	db 238,238,255,255,255,255,255,255,85,85,85,85,85,85,85,85
	db 255,255,255,255,255,255,255,255,127,85,127,85,127,85,127,85
	db 85,255,85,255,85,255,85,255,85,255,85,255,85,255,85,255
	db 255,95,255,95,255,95,255,95,255,95,255,95,255,95,255,95
	db 255,255,255,255,95,245,95,245,95,245,95,245,95,245,95,245
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,127,255,127,255,127,255,127,255,127,255,127,255,127,175,122
	db 255,255,245,255,245,255,245,255,245,255,245,255,245,255,245,255
	db 255,255,255,85,255,85,255,85,255,85,255,85,255,85,255,85
	db 255,255,255,255,85,253,85,253,85,253,85,253,85,253,85,253
	db 255,255,255,255,255,95,255,95,255,95,255,95,255,95,255,95
	db 255,255,255,255,255,255,85,253,85,253,85,253,85,253,85,253
	db 255,127,255,127,170,126,170,126,170,126,170,126,170,126,170,126
	db 255,255,255,255,255,127,255,127,255,127,255,127,255,127,255,127
	db 191,170,191,170,95,169,85,149,85,85,85,85,85,85,85,85
	db 170,255,170,255,170,255,170,255,90,253,85,213,85,85,85,85
	db 255,175,255,175,95,173,85,149,85,85,85,85,85,85,85,85
	db 175,250,175,250,175,250,175,250,95,249,85,213,85,85,85,85
	db 255,255,255,255,95,253,85,213,85,85,85,85,85,85,85,85
	db 175,122,175,122,175,122,175,122,95,121,85,213,85,85,85,85
	db 255,170,255,170,255,170,255,170,95,169,85,149,85,85,85,85
	db 170,254,170,254,170,254,170,254,90,253,85,213,85,85,85,85
	db 170,126,170,126,170,126,170,126,90,125,85,213,85,85,85,85
	db 170,170,170,170,170,170,170,170,90,169,85,149,85,85,85,85
_pano_autobahn_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,2,0,0,0,0,3,4,5,6,7,8,0,0,0,9
	db 1,2,0,0,0,0,3,4,5,6,7,8,0,0,0,9
	db 10,11,12,13,14,15,16,17,17,17,17,18,19,20,21,22
	db 10,11,12,13,14,15,16,17,17,17,17,18,19,20,21,22
	db 23,24,25,26,27,28,29,30,31,23,23,32,33,34,35,23
	db 23,24,25,26,27,28,29,30,31,23,23,32,33,34,35,23
	db 36,37,38,39,40,41,41,41,42,39,39,39,39,39,39,39
	db 36,37,38,39,40,41,41,41,42,39,39,39,39,39,39,39
	db 23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23
	db 23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23
	db 43,43,43,43,44,45,43,43,43,43,43,43,44,45,43,43
	db 43,43,43,43,44,45,43,43,43,43,43,43,44,45,43,43
	db 46,47,48,46,49,50,46,46,46,46,46,46,49,50,46,51
	db 46,47,48,46,49,50,46,46,46,46,46,46,49,50,46,51
	db 52,53,54,55,56,57,58,59,56,60,61,62,56,63,64,0
	db 52,53,54,55,56,57,58,59,56,60,61,62,56,63,64,0
	db 65,66,67,68,69,70,69,71,69,72,67,72,69,73,69,74
	db 65,66,69,68,69,70,69,71,69,72,67,72,69,73,69,74
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
_pano_autobahn_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 5,5,1,1,1,1,6,6,6,6,6,6,1,1,1,6
	db 5,5,1,1,1,1,6,6,6,6,6,6,1,1,1,6
	db 1,5,5,5,5,5,5,5,5,1,1,5,5,5,5,1
	db 1,5,5,5,5,5,5,5,5,1,1,5,5,5,5,1
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,3,3,2,2,2,2,2,2,2,2,2,2,2,2,3
	db 2,3,3,2,2,2,2,2,2,2,2,2,2,2,2,3
	db 3,3,3,3,2,4,3,3,2,3,3,3,2,4,3,3
	db 3,3,3,3,2,4,3,3,2,3,3,3,2,4,3,3
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	align 2
_pano_autobahn_pals:
	db 166,5,118,9,187,12,238,15,166,5,118,9,168,11,238,15
	db 166,5,85,6,186,12,220,13,166,5,152,10,186,12,220,13
	db 166,5,85,6,152,10,220,13,166,5,168,11,186,12,238,15
	db 166,5,118,9,168,11,186,12,166,5,82,3,152,10,220,13
	align 2
_pano_seaside_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,213,85,253,215,255,255,255,255,255,255
	db 85,85,85,85,85,85,85,85,85,85,85,85,149,255,89,255
	db 85,85,85,85,85,85,85,85,85,85,85,85,149,149,89,89
	db 85,85,85,85,85,85,85,85,87,85,95,85,255,127,255,127
	db 85,85,85,85,95,85,127,213,255,253,255,255,255,255,255,255
	db 85,85,85,85,125,213,255,213,255,255,255,255,255,255,255,255
	db 153,153,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 153,153,170,170,170,170,170,170,170,170,191,170,191,170,170,170
	db 85,85,85,85,85,85,253,87,255,95,170,170,170,170,85,85
	db 85,85,85,87,213,95,255,127,255,255,170,171,250,175,255,127
	db 153,153,170,191,171,255,255,255,255,255,255,255,255,255,255,255
	db 85,85,85,245,85,253,95,255,255,255,171,254,175,255,255,255
	db 85,85,85,85,85,85,85,245,85,253,170,234,170,250,117,253
	db 170,85,170,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 170,170,170,170,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,149,85,149,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,106,85,106,85,85,85,85,85
	db 85,85,87,85,223,127,255,255,170,170,170,170,85,85,85,85
	db 87,253,95,253,255,255,255,255,170,170,170,170,85,85,85,85
	db 85,213,85,245,85,253,255,255,170,170,170,170,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,165,85,165,85,85,85,85
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,174,174,234,234,187,187,255,255,255,255,255,255,255,255
	db 170,170,170,170,170,170,170,170,170,170,165,170,85,170,85,165
	db 170,170,170,170,170,170,85,170,85,85,85,85,255,127,255,127
	db 170,170,170,170,170,170,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,170,86,170,86,255,171,255,171,223,171,171,170
	db 170,170,170,170,170,85,170,85,170,255,86,255,85,255,85,255
	db 170,170,170,170,170,170,170,170,170,170,85,170,85,85,85,85
	db 85,85,85,85,85,85,170,90,170,90,255,175,255,175,255,175
	db 170,170,170,170,170,170,170,170,85,85,85,85,253,255,253,255
	db 170,170,170,170,170,170,170,170,170,90,90,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,170,90,170,90,255,175
	db 255,127,255,127,255,127,255,127,255,127,85,85,85,85,85,85
	db 171,106,253,127,253,127,253,127,253,127,253,127,85,85,85,85
	db 85,255,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,106,85,106,85,127,85,127,85,125,85,127,85
	db 255,95,255,95,151,170,151,170,215,255,213,255,213,255,213,255
	db 253,255,253,255,253,223,253,255,253,255,245,255,245,255,85,85
	db 85,85,170,85,170,85,255,85,255,85,255,85,255,85,255,85
	db 255,95,175,170,175,170,255,255,245,255,250,255,250,255,255,255
	db 85,85,85,85,85,85,85,149,85,169,169,170,169,170,253,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,255,171
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,250
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,165,170
	db 85,85,86,85,106,85,170,85,170,106,170,106,255,191,255,191
	db 85,85,85,85,85,85,85,85,85,165,85,165,85,245,85,245
	db 127,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 213,255,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 95,85,95,85,95,85,95,85,85,85,85,85,85,85,85,85
	db 253,255,253,127,253,255,253,255,85,85,85,85,85,85,85,85
	db 170,126,255,87,255,87,255,87,255,87,255,87,255,87,255,87
	db 170,90,170,250,170,250,170,250,170,250,85,245,85,245,85,245
	db 85,85,85,85,170,86,170,86,255,87,255,171,223,171,255,171
	db 106,85,170,90,170,170,255,175,255,255,255,255,255,255,255,255
	db 255,125,255,191,255,191,85,213,85,213,85,213,85,213,85,213
	db 85,245,85,245,85,245,85,85,85,85,85,85,85,85,85,85
	db 85,93,117,89,93,85,85,85,85,85,85,149,85,86,89,87
	db 85,85,85,85,85,213,85,91,93,85,85,85,85,85,85,85
_pano_seaside_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,2,3,3,3,3,3,3,3,3,3,3,3,4,5,6
	db 1,2,3,3,3,3,3,3,3,3,3,3,3,4,5,6
	db 7,7,8,9,10,11,12,13,7,7,7,7,7,7,7,7
	db 7,7,8,9,10,11,12,13,7,7,7,7,7,7,7,7
	db 0,0,0,14,15,15,15,15,16,0,0,17,18,19,20,21
	db 0,0,0,14,15,15,15,15,16,0,0,17,18,19,20,21
	db 22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22
	db 22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22
	db 23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23
	db 23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23
	db 24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24
	db 24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24
	db 25,26,27,28,29,30,31,32,33,34,23,23,23,23,23,23
	db 25,26,27,28,29,30,31,32,33,34,23,23,23,23,23,23
	db 0,35,0,36,37,38,39,40,41,42,43,44,45,23,46,47
	db 48,35,0,36,37,38,39,40,41,42,43,44,45,23,46,47
	db 0,0,0,0,0,49,50,0,0,51,52,53,54,55,56,57
	db 58,0,0,0,0,49,50,0,0,51,52,53,54,55,56,57
	db 59,60,59,60,59,60,59,60,59,60,59,60,59,60,59,60
	db 59,60,59,60,59,60,59,60,59,60,59,60,59,60,59,60
_pano_seaside_map_pal:
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,0,0,7,0,0,7,7,7,7,7,7,7,7
	db 7,7,7,0,0,7,0,0,7,7,7,7,7,7,7,7
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 1,1,1,2,6,1,2,1,1,2,1,1,1,1,1,1
	db 1,1,1,2,6,1,2,1,1,2,1,1,1,1,1,1
	db 1,3,1,3,3,3,3,3,3,3,2,1,1,1,1,2
	db 3,3,1,3,3,3,3,3,3,3,2,1,1,1,1,2
	db 1,1,1,1,1,3,3,1,1,3,3,3,6,2,2,3
	db 3,1,1,1,1,3,3,1,1,3,3,3,6,2,2,3
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
	align 2
_pano_seaside_pals:
	db 205,10,180,15,219,15,255,15,205,10,166,4,235,15,109,3
	db 205,10,235,15,109,3,255,15,205,10,166,4,109,3,255,15
	db 205,10,113,12,198,15,255,15,205,10,180,15,216,15,235,15
	db 205,10,166,4,235,15,255,15,205,10,146,14,180,15,255,15
	align 2
_pano_ruins_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,89,89
	db 85,85,85,85,85,85,85,85,85,85,87,85,95,85,170,90
	db 85,85,85,85,85,85,87,85,95,253,127,255,255,255,170,170
	db 85,85,85,85,85,85,85,245,95,245,127,253,255,255,170,170
	db 85,85,85,85,85,85,85,85,85,85,85,213,85,245,149,170
	db 149,149,102,102,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,159,102,102,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,255,102,102,170,170,170,170,170,170,170,170,170,170,170,170
	db 213,255,102,102,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,175,170,191,170
	db 170,170,170,170,170,170,170,170,254,170,255,170,255,235,255,255
	db 170,170,170,170,170,170,170,170,234,171,250,175,255,255,255,255
	db 170,170,170,170,170,170,170,171,234,175,251,191,255,255,170,186
	db 170,170,170,170,170,170,170,191,235,255,255,255,255,255,170,170
	db 170,170,170,170,170,170,170,250,170,254,175,255,255,255,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,250,170,254,170,170
	db 170,170,170,170,170,170,170,170,175,170,175,170,170,170,170,170
	db 170,170,234,171,251,175,255,191,170,170,170,170,170,170,170,170
	db 170,191,170,255,239,255,255,255,170,170,170,170,170,170,170,170
	db 170,170,170,250,170,254,170,255,170,170,170,170,170,170,170,170
	db 170,170,174,174,234,234,187,187,255,255,255,255,255,255,255,255
	db 255,171,255,175,234,234,187,187,255,255,255,255,255,255,255,255
	db 255,255,255,255,234,234,187,187,255,255,255,255,255,255,255,255
	db 255,255,174,255,234,234,187,187,255,255,255,255,255,255,255,255
	db 255,255,174,174,234,234,187,187,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 85,85,85,85,85,85,93,93,213,213,119,119,255,255,255,255
	db 85,85,85,85,85,85,93,93,170,214,170,118,170,254,170,254
	db 85,85,85,85,85,85,93,93,213,165,119,167,255,175,255,175
	db 255,255,255,255,255,255,255,255,249,255,169,86,165,86,85,85
	db 255,255,255,255,218,255,90,245,85,85,85,85,85,85,85,85
	db 255,255,255,255,255,191,255,175,255,166,191,166,159,150,155,154
	db 170,254,170,254,170,254,170,254,170,254,170,254,170,234,170,234
	db 255,175,255,175,255,175,255,175,255,175,255,175,255,170,255,170
	db 255,255,255,255,255,255,245,255,213,255,85,255,85,253,85,245
	db 255,255,255,255,127,106,107,106,105,86,169,85,165,85,166,85
	db 255,255,234,255,234,255,234,255,170,170,170,170,170,170,170,170
	db 255,255,255,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,255,250,255,106,165,105,165,105,101,105,101,105,101,105,101
	db 255,255,255,255,255,175,255,166,191,166,159,150,154,154,90,154
	db 255,255,255,255,255,255,255,255,255,255,255,255,245,255,85,106
	db 255,255,255,255,255,127,255,111,255,105,191,169,175,169,167,166
	db 255,255,255,255,191,106,155,106,154,86,90,86,106,86,105,86
	db 255,255,255,255,255,111,255,105,191,105,175,169,166,166,166,166
	db 255,255,255,255,255,255,255,255,255,255,255,255,245,255,85,154
	db 101,86,101,86,101,86,101,86,101,86,101,86,101,90,101,90
	db 89,85,89,85,89,85,89,85,89,85,89,85,89,149,89,149
	db 90,90,106,106,106,105,175,169,175,169,175,166,175,166,159,150
	db 255,255,255,191,255,191,170,234,255,255,255,255,255,255,255,255
	db 255,170,255,170,255,170,171,170,171,170,171,170,171,170,170,170
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,170,191
	db 255,255,255,255,253,255,245,255,85,255,85,253,85,213,85,85
	db 85,213,85,85,85,85,86,85,86,85,85,85,85,85,86,85
	db 251,107,239,107,239,107,175,107,191,107,190,107,254,106,250,106
	db 255,235,255,235,255,171,170,254,255,255,255,255,255,255,255,255
	db 250,255,250,255,250,255,175,170,255,255,255,255,255,255,255,255
	db 105,101,105,101,105,101,105,229,105,229,105,229,105,229,169,229
	db 191,191,190,190,254,190,254,254,251,251,251,251,235,235,239,239
	db 85,191,85,186,85,250,85,250,85,250,85,234,85,234,85,234
	db 166,166,150,150,154,154,95,90,111,106,111,105,175,169,175,169
	db 255,255,255,255,255,255,170,234,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,170,127
	db 254,106,250,106,251,106,251,107,239,107,239,107,175,107,187,107
	db 255,235,255,235,255,235,170,254,255,255,255,255,255,255,255,255
	db 235,235,239,239,175,239,191,191,190,190,254,190,254,254,251,251
	db 85,239,85,234,85,186,85,186,85,186,85,250,85,250,85,250
	db 101,90,101,86,101,86,101,90,101,90,102,90,101,90,101,170
	db 153,149,153,149,153,149,89,149,89,106,169,105,169,169,169,166
	db 170,170,170,170,170,170,170,170,170,170,170,191,255,191,255,191
	db 170,170,255,255,255,255,255,255,255,255,170,170,255,255,250,255
	db 171,170,255,255,255,255,255,255,255,255,170,170,255,255,191,170
	db 170,234,85,234,85,213,85,213,85,213,85,127,85,255,85,255
	db 255,111,255,105,175,105,166,169,166,166,150,166,154,150,154,154
	db 253,255,245,255,213,255,85,253,85,165,85,165,85,85,85,85
	db 85,85,85,85,85,85,89,85,89,85,89,85,153,85,149,89
	db 86,85,86,85,150,85,150,149,150,149,85,149,85,149,166,150
	db 255,170,255,171,175,171,175,171,175,170,255,171,255,171,255,171
	db 170,170,255,255,255,255,255,255,255,255,170,170,255,255,191,170
	db 170,254,170,254,170,254,170,254,170,254,250,255,250,255,250,255
	db 175,239,191,191,186,190,250,190,186,254,187,250,187,186,171,170
	db 85,186,85,186,85,186,101,250,101,234,149,234,149,234,101,234
	db 255,159,255,154,111,154,105,106,105,105,169,105,166,169,166,166
	db 191,171,255,170,191,170,191,170,191,170,255,171,255,171,255,171
	db 251,251,235,235,235,239,171,239,187,191,186,190,186,190,186,190
	db 85,234,85,234,85,234,101,186,101,170,149,170,149,234,101,234
	db 102,170,102,166,102,166,170,170,85,85,85,85,85,85,85,85
	db 153,166,153,170,169,154,170,170,85,85,85,85,85,85,85,85
	db 255,191,250,191,165,170,85,165,85,85,85,85,85,85,85,85
	db 165,250,85,165,85,85,85,85,85,85,85,85,85,85,85,85
	db 106,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 169,170,169,106,170,85,85,85,85,85,85,85,85,85,85,85
	db 191,239,190,191,190,190,190,170,106,85,85,85,85,85,85,85
	db 85,149,85,149,85,149,170,149,85,170,85,85,85,85,85,85
	db 149,89,153,89,153,85,170,170,85,85,85,85,85,85,85,85
	db 166,169,170,105,154,106,170,170,85,85,85,85,85,85,85,85
	db 255,171,250,171,165,106,85,165,85,85,85,85,85,85,85,85
	db 249,191,249,106,170,85,85,85,85,85,85,85,85,85,85,85
	db 171,174,171,174,187,190,186,170,106,85,85,85,85,85,85,85
	db 101,170,169,170,166,170,170,170,85,170,85,85,85,85,85,85
	db 235,251,239,235,239,239,191,170,106,85,85,85,85,85,85,85
	db 187,186,187,186,171,170,171,170,106,85,85,85,85,85,85,85
_pano_ruins_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,1,2,3,4,5,1,1,1,1,1,1,1
	db 1,1,1,1,1,2,3,4,5,1,1,1,1,1,1,1
	db 6,6,6,6,6,7,8,8,9,6,6,6,6,6,6,6
	db 6,6,6,6,6,7,8,8,9,6,6,6,6,6,6,6
	db 10,11,12,13,14,15,16,17,10,10,18,19,20,21,10,10
	db 10,11,12,13,14,15,16,17,10,10,18,19,20,21,10,10
	db 22,23,24,24,25,26,26,26,22,22,22,22,22,22,22,22
	db 22,23,24,24,25,26,26,26,22,22,22,22,22,22,22,22
	db 27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27
	db 27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27
	db 28,28,28,29,30,28,28,28,28,28,28,28,28,28,28,28
	db 28,28,28,29,30,28,28,28,28,28,28,28,28,28,28,28
	db 31,32,33,34,35,27,27,27,27,36,37,38,39,40,41,42
	db 31,32,43,34,35,27,27,27,27,36,44,38,39,40,45,46
	db 47,48,49,50,51,52,27,27,53,54,55,56,57,58,59,60
	db 47,48,61,62,51,63,27,27,53,54,64,65,57,58,66,67
	db 68,69,70,71,72,73,74,75,76,77,78,71,79,80,81,82
	db 68,69,70,71,72,73,83,75,76,77,84,71,79,80,85,86
	db 87,88,89,90,91,92,93,94,95,96,97,90,91,98,99,100
	db 87,88,89,90,91,92,101,94,95,96,97,90,91,98,102,100
_pano_ruins_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,6,6,6,6,0,0,0,0,0,0,0
	db 0,0,0,0,0,6,6,6,6,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,6,6,6,6,6,6,6,0,0,0,6,6,6,0,0
	db 0,6,6,6,6,6,6,6,0,0,0,6,6,6,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 3,3,7,5,5,1,1,1,1,3,7,3,3,1,7,3
	db 3,3,7,5,5,1,1,1,1,3,7,5,3,1,7,3
	db 1,1,7,4,5,3,1,1,3,1,2,4,4,4,2,2
	db 1,1,7,4,5,7,1,1,3,1,2,4,4,4,2,2
	db 1,1,3,4,4,7,7,3,1,1,4,4,4,4,2,2
	db 1,1,3,4,4,7,7,3,1,1,4,4,4,4,2,2
	db 1,1,4,4,1,1,2,1,1,1,4,4,1,4,2,1
	db 1,1,4,4,1,1,2,1,1,1,4,4,1,4,2,1
	align 2
_pano_ruins_pals:
	db 183,5,162,10,197,11,217,12,183,5,98,3,147,4,236,12
	db 183,5,98,3,147,4,199,6,183,5,82,2,199,6,236,12
	db 183,5,98,3,147,4,188,9,183,5,217,12,188,9,236,12
	db 183,5,162,10,197,11,254,14,183,5,147,4,199,6,236,12
	align 2
_gfx_pano:
	dd _pano_beach_tiles
	db 73,0
	dd _pano_beach_map
	dd _pano_beach_map_pal
	dd _pano_beach_pals
	db 223,11
	dd _pano_coast_tiles
	db 100,0
	dd _pano_coast_map
	dd _pano_coast_map_pal
	dd _pano_coast_pals
	db 201,6
	dd _pano_fields_tiles
	db 79,0
	dd _pano_fields_map
	dd _pano_fields_map_pal
	dd _pano_fields_pals
	db 218,7
	dd _pano_desert_tiles
	db 80,0
	dd _pano_desert_map
	dd _pano_desert_map_pal
	dd _pano_desert_pals
	db 206,10
	dd _pano_autumn_tiles
	db 97,0
	dd _pano_autumn_map
	dd _pano_autumn_map_pal
	dd _pano_autumn_pals
	db 172,6
	dd _pano_alps_tiles
	db 112,0
	dd _pano_alps_map
	dd _pano_alps_map_pal
	dd _pano_alps_pals
	db 201,8
	dd _pano_city_tiles
	db 79,0
	dd _pano_city_map
	dd _pano_city_map_pal
	dd _pano_city_pals
	db 155,7
	dd _pano_lake_tiles
	db 88,0
	dd _pano_lake_map
	dd _pano_lake_map_pal
	dd _pano_lake_pals
	db 202,8
	dd _pano_canyon_tiles
	db 84,0
	dd _pano_canyon_map
	dd _pano_canyon_map_pal
	dd _pano_canyon_pals
	db 156,7
	dd _pano_caves_tiles
	db 94,0
	dd _pano_caves_map
	dd _pano_caves_map_pal
	dd _pano_caves_pals
	db 138,6
	dd _pano_snow_tiles
	db 114,0
	dd _pano_snow_map
	dd _pano_snow_map_pal
	dd _pano_snow_pals
	db 238,15
	dd _pano_farm_tiles
	db 52,0
	dd _pano_farm_map
	dd _pano_farm_map_pal
	dd _pano_farm_pals
	db 203,6
	dd _pano_autobahn_tiles
	db 75,0
	dd _pano_autobahn_map
	dd _pano_autobahn_map_pal
	dd _pano_autobahn_pals
	db 166,5
	dd _pano_seaside_tiles
	db 61,0
	dd _pano_seaside_map
	dd _pano_seaside_map_pal
	dd _pano_seaside_pals
	db 205,10
	dd _pano_ruins_tiles
	db 103,0
	dd _pano_ruins_map
	dd _pano_ruins_map_pal
	dd _pano_ruins_pals
	db 183,5
	align 2
_gfx_traffic_tiles_count:
	db 70,0
	align 2
_gfx_traffic_tiles:
	db 0,0,0,0,0,0,0,0,1,0,6,0,85,5,170,6
	db 0,0,85,1,170,22,85,101,245,151,85,85,85,85,170,170
	db 0,0,64,85,148,170,89,85,86,85,85,85,85,85,170,170
	db 0,0,0,0,0,0,0,0,0,64,0,144,80,85,144,170
	db 170,26,219,27,219,27,170,26,85,21,170,26,84,21,84,21
	db 170,170,170,234,165,234,175,170,85,85,170,170,0,20,0,0
	db 170,170,171,170,171,90,170,234,85,85,170,170,20,0,0,0
	db 164,170,228,231,228,231,164,170,84,85,164,170,84,21,84,21
	db 0,0,0,0,0,0,0,0,0,0,1,0,5,0,25,0
	db 0,0,0,0,0,0,0,0,0,0,170,170,85,85,85,245
	db 0,0,0,0,0,0,0,0,0,0,0,64,0,144,0,100
	db 85,21,170,26,170,42,190,47,170,42,85,21,65,21,64,21
	db 85,85,170,170,170,170,106,165,234,175,85,85,0,0,0,0
	db 80,85,160,170,164,170,244,189,164,170,84,85,84,65,84,1
	db 21,0,149,0,85,2,170,42,170,119,171,106,170,106,0,84
	db 0,80,0,85,64,85,164,170,184,171,168,170,168,170,84,0
	db 0,0,0,0,84,0,213,5,85,21,170,126,85,85,1,81
	db 0,0,0,0,0,0,0,64,0,80,0,244,0,84,0,20
	db 0,0,0,0,0,0,0,0,128,10,84,85,168,169,20,80
	db 0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0
	db 0,0,85,0,170,5,170,26,85,106,117,105,85,169,170,170
	db 0,0,0,85,80,170,164,170,169,85,105,85,106,85,170,170
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,64
	db 6,0,22,0,107,0,111,0,106,0,85,0,21,0,21,0
	db 170,170,170,170,165,170,175,170,85,165,255,95,0,64,0,64
	db 170,170,170,170,170,90,170,250,90,85,245,255,1,0,1,0
	db 0,144,0,148,0,233,0,249,0,169,0,85,0,84,0,84
	db 0,0,0,0,0,0,0,0,0,0,1,0,2,0,6,0
	db 0,0,0,0,0,0,0,0,0,0,169,106,170,170,86,149
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,144
	db 26,0,26,0,106,0,186,1,250,1,169,1,84,0,84,0
	db 0,164,0,164,0,168,64,174,64,174,64,170,0,21,0,21
	db 5,0,106,0,157,0,170,1,170,6,171,11,127,5,0,5
	db 0,80,0,168,0,89,0,170,64,170,208,234,80,253,64,1
	db 0,0,0,0,84,0,86,2,86,6,170,10,85,25,0,4
	db 0,0,0,0,0,0,0,0,0,64,0,128,0,144,0,64
	db 0,0,0,0,0,0,0,0,64,6,64,5,160,41,16,16
	db 0,0,0,0,0,0,0,0,0,0,0,0,85,1,255,1
	db 0,0,0,0,0,0,0,0,0,0,0,0,85,85,255,255
	db 0,0,0,0,0,0,0,0,0,0,0,0,64,85,64,255
	db 186,1,186,1,186,1,186,1,186,1,186,1,186,1,186,1
	db 170,170,170,170,169,170,169,170,169,170,169,170,169,170,169,170
	db 170,170,170,170,170,106,170,106,170,106,170,106,170,106,170,106
	db 64,174,64,174,64,174,64,174,64,174,64,174,64,174,64,174
	db 169,170,169,170,169,170,169,170,169,170,169,170,169,170,169,170
	db 170,106,170,106,170,106,170,106,170,106,170,106,170,106,170,106
	db 186,1,186,1,170,1,85,1,213,7,85,5,85,1,85,1
	db 170,170,170,170,170,170,85,85,85,85,85,85,0,5,0,0
	db 170,170,170,170,170,170,85,85,85,85,85,85,5,0,5,0
	db 64,174,64,174,64,170,64,85,208,87,80,85,0,84,0,84
	db 0,0,0,0,0,0,0,0,0,0,0,0,85,5,255,7
	db 0,0,0,0,0,0,0,0,0,0,0,0,80,85,208,255
	db 170,6,170,6,170,6,170,6,170,6,170,6,170,6,170,6
	db 170,170,106,169,106,169,106,169,106,169,106,169,106,169,106,169
	db 144,171,144,171,144,171,144,171,144,171,144,171,144,171,144,171
	db 106,169,106,169,106,169,106,169,106,169,106,169,106,169,106,169
	db 170,6,170,6,170,6,170,6,85,5,85,31,81,5,80,5
	db 106,169,106,169,170,170,170,170,85,85,85,85,0,64,0,0
	db 144,171,144,171,144,171,144,170,80,85,240,85,0,85,0,85
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,31
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,240,255
	db 170,30,169,30,169,30,169,30,169,30,169,30,169,30,169,30
	db 160,170,160,170,160,170,160,170,160,170,160,170,160,170,160,170
	db 169,30,169,30,169,30,169,30,170,30,85,21,85,21,0,21
	db 160,170,160,170,160,170,160,170,160,170,80,85,84,85,64,1
	db 0,0,0,0,0,0,0,0,255,63,154,42,154,42,154,42
	db 0,0,0,0,0,0,0,0,0,240,0,160,0,160,0,160
	db 154,42,154,42,154,42,154,42,154,42,170,42,85,21,0,21
	db 0,160,0,160,0,160,0,160,0,160,0,160,0,80,0,64
	db 0,0,160,42,160,41,160,41,160,41,160,41,160,42,84,85
_gfx_traffic_cells:
	db 0,0,0,1,0,1,2,0,2,3,0,3,0,1,4,1
	db 1,5,2,1,6,3,1,7,0,0,8,1,0,9,2,0
	db 10,0,1,11,1,1,12,2,1,13,0,0,14,1,0,15
	db 0,0,16,1,0,17,0,0,18,0,0,19,1,0,20,2
	db 0,21,3,0,22,0,1,23,1,1,24,2,1,25,3,1
	db 26,0,0,27,1,0,28,2,0,29,0,1,30,1,1,12
	db 2,1,31,0,0,32,1,0,33,0,0,34,1,0,35,0
	db 0,36,0,0,37,1,0,38,2,0,38,3,0,39,0,1
	db 40,1,1,41,2,1,42,3,1,43,0,2,40,1,2,44
	db 2,2,45,3,2,43,0,3,40,1,3,44,2,3,45,3
	db 3,43,0,4,46,1,4,47,2,4,48,3,4,49,0,0
	db 50,1,0,38,2,0,51,0,1,52,1,1,53,2,1,54
	db 0,2,52,1,2,55,2,2,54,0,3,56,1,3,57,2
	db 3,58,0,0,59,1,0,60,0,1,61,1,1,62,0,2
	db 63,1,2,64,0,0,65,1,0,66,0,1,67,1,1,68
	db 0,0,69
	align 2
_gfx_traffic_frames:
	db 4,2,8,0,0,0,32,16,3,2,6,0,8,0,24,16
	db 2,1,2,0,14,0,16,8,2,1,2,0,16,0,11,8
	db 1,1,1,0,18,0,7,8,4,2,8,0,19,0,32,16
	db 3,2,6,0,27,0,24,16,2,1,2,0,33,0,16,8
	db 2,1,2,0,35,0,11,8,1,1,1,0,37,0,7,8
	db 4,5,20,0,38,0,32,40,3,4,12,0,58,0,24,32
	db 2,3,6,0,70,0,16,24,2,2,4,0,76,0,11,16
	db 1,1,1,0,80,0,7,8
	align 2
_gfx_obj_tiles_count:
	db 200,0
	align 2
_gfx_obj_tiles:
	db 0,0,0,0,0,0,168,0,254,10,170,47,150,186,1,169
	db 0,0,0,0,8,42,174,191,234,170,170,170,170,170,169,106
	db 0,0,0,0,0,0,0,42,160,191,248,170,174,150,106,64
	db 0,164,1,144,6,128,25,64,100,64,128,1,0,1,0,0
	db 233,107,218,167,198,147,192,3,192,7,192,7,192,7,192,5
	db 26,0,6,64,2,144,1,100,1,25,0,9,0,1,0,0
	db 192,7,240,1,240,1,112,1,124,1,124,0,124,0,95,0
	db 31,0,31,0,23,0,23,0,23,0,87,0,85,1,85,5
	db 0,0,0,0,0,192,0,192,0,192,0,240,0,252,0,85
	db 0,0,0,0,0,0,143,2,234,43,170,62,26,164,10,144
	db 0,0,0,0,0,0,160,172,250,234,175,170,6,169,1,232
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,128
	db 100,128,144,64,65,65,1,4,1,0,0,0,0,0,0,0
	db 64,198,128,193,80,192,16,192,0,192,0,240,0,240,0,124
	db 0,128,0,64,0,64,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0
	db 0,124,0,124,0,28,0,28,0,23,0,23,192,87,80,85
	db 0,0,250,8,170,186,169,145,182,65,48,5,48,16,16,0
	db 0,0,0,160,0,172,0,10,0,2,0,129,0,16,0,0
	db 28,0,28,0,12,0,7,0,7,0,7,0,7,0,21,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,192,0,80
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,2,170,170
	db 130,130,16,4,4,1,192,0,192,0,64,0,112,0,112,0
	db 0,0,0,0,0,8,64,76,0,12,0,4,0,0,0,7
	db 0,0,0,0,0,0,0,0,0,0,0,0,3,0,14,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,192,0,144
	db 14,0,14,0,14,15,78,58,78,58,78,58,170,58,170,14
	db 0,144,0,144,0,144,240,144,164,147,164,147,164,147,164,147
	db 14,0,14,0,14,0,14,0,14,0,14,0,14,0,62,0
	db 164,154,144,170,0,144,0,144,0,144,0,144,0,144,0,148
	db 0,0,0,0,60,0,232,0,232,0,232,60,232,41,232,41
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,48,0,228
	db 168,42,168,58,234,0,232,0,232,0,232,0,232,0,233,0
	db 0,228,0,228,0,164,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,2
	db 64,2,76,226,120,226,120,42,164,2,64,2,64,2,64,14
	db 0,0,0,0,0,8,0,8,64,219,64,10,0,8,0,8
	db 0,0,0,0,0,0,0,0,0,48,0,177,0,56,0,48
	db 0,0,0,0,3,0,14,0,14,0,58,0,234,0,14,0
	db 0,0,0,0,0,0,0,64,0,64,0,144,0,164,0,64
	db 58,0,234,0,170,3,58,0,234,0,170,3,170,14,170,58
	db 0,144,0,164,0,169,0,144,0,164,0,169,64,170,144,170
	db 170,3,170,14,170,58,170,234,86,85,2,0,2,0,6,0
	db 0,169,64,170,144,170,164,170,84,85,0,64,0,64,0,144
	db 48,0,228,0,168,0,169,3,168,0,169,3,170,14,169,3
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0
	db 170,14,170,42,170,14,170,58,170,234,101,85,36,0,104,0
	db 0,64,0,160,0,64,0,144,0,164,0,84,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,2,64,14,0,2
	db 128,10,64,14,144,58,164,234,160,42,168,170,0,2,64,2
	db 0,0,0,4,0,56,0,56,0,41,0,41,64,170,0,4
	db 0,0,0,0,0,48,0,48,0,32,0,232,0,168,0,0
	db 0,0,15,0,250,0,170,3,170,14,170,58,170,234,85,85
	db 0,255,208,170,164,170,165,170,165,170,149,170,85,170,85,85
	db 0,0,0,0,0,240,64,235,144,170,164,170,165,170,85,85
	db 0,0,0,0,15,0,170,3,170,14,170,58,170,234,85,85
	db 0,0,0,0,0,0,192,167,180,167,169,166,170,86,85,85
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,64
	db 0,0,0,0,0,0,0,0,164,3,169,58,165,234,85,85
	db 0,0,0,0,0,0,0,0,0,0,0,176,0,168,0,85
	db 0,0,0,0,0,0,0,0,0,0,64,14,168,42,105,170
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,43,128,166
	db 192,3,255,15,170,42,85,21,102,1,102,1,102,1,102,1
	db 0,48,240,255,168,170,84,85,64,158,64,158,64,158,64,158
	db 102,1,102,1,102,1,102,1,85,1,102,1,102,1,102,1
	db 64,158,64,158,64,158,64,158,64,85,64,158,64,158,64,158
	db 102,1,102,1,102,1,102,1,102,1,85,1,102,1,102,1
	db 64,158,64,158,64,158,64,158,64,158,64,85,64,158,64,158
	db 102,1,102,1,102,1,102,1,102,1,170,42,170,42,85,21
	db 64,158,64,158,64,158,64,158,64,158,168,170,168,170,84,85
	db 0,15,170,42,85,21,107,5,107,5,107,5,107,5,107,5
	db 0,0,0,168,0,84,0,144,0,144,0,144,0,144,0,144
	db 107,5,85,5,107,5,107,5,107,5,107,5,107,5,107,5
	db 0,144,0,80,0,144,0,144,0,144,0,144,0,144,0,144
	db 107,5,107,5,107,5,107,5,107,5,107,5,170,42,85,21
	db 0,144,0,144,0,144,0,144,0,144,0,144,0,168,0,84
	db 252,63,84,85,96,26,96,26,96,26,96,26,96,26,96,26
	db 96,26,96,26,80,21,96,26,96,26,96,26,168,170,84,85
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,63,0,26
	db 0,26,0,26,0,26,0,26,0,26,0,26,0,26,128,170
	db 0,170,0,28,0,28,0,28,0,28,0,28,0,28,0,170
	db 15,0,250,0,170,3,166,14,170,58,170,233,169,170,85,85
	db 0,192,0,188,192,171,176,170,172,154,107,170,169,170,85,85
	db 0,0,0,0,252,0,170,14,106,58,170,42,154,170,85,85
	db 0,0,0,0,0,0,0,240,0,160,0,172,0,169,0,85
	db 0,0,0,0,0,0,0,0,192,14,172,42,171,154,85,85
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,43,128,170
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,40,0,170
	db 0,0,13,0,15,0,11,0,12,0,2,0,3,0,0,0
	db 0,0,0,0,0,64,0,64,0,208,0,208,0,180,2,244
	db 0,0,0,0,0,0,0,0,0,0,188,3,244,56,80,239
	db 0,0,0,0,0,0,0,0,1,0,1,0,23,0,126,1
	db 99,177,104,5,101,21,106,85,106,85,159,90,159,250,183,234
	db 0,245,0,80,0,0,0,128,0,160,0,192,0,128,0,192
	db 203,7,176,15,0,0,0,0,0,0,0,0,1,0,1,0
	db 183,90,125,90,125,90,191,90,191,90,191,90,191,106,191,106
	db 0,176,0,224,0,204,0,120,0,124,0,220,0,240,0,240
	db 1,0,1,0,1,0,1,0,1,0,1,0,1,0,5,0
	db 191,106,191,106,95,106,95,106,95,106,95,106,95,106,191,170
	db 0,240,0,240,0,240,0,240,0,240,0,240,0,240,0,252
	db 0,0,0,0,240,0,176,0,196,0,61,0,13,0,1,0
	db 0,0,0,0,0,0,0,0,0,0,207,0,181,3,64,105
	db 5,0,5,0,22,0,126,0,182,31,6,62,6,0,6,0
	db 0,100,0,106,0,159,0,158,192,182,128,127,0,127,192,189
	db 6,0,26,0,26,0,26,0,26,0,26,0,26,0,90,0
	db 64,191,192,191,192,191,192,191,192,95,192,95,192,95,192,191
	db 0,1,0,3,64,2,194,0,24,0,90,0,103,1,175,30
	db 0,0,0,0,0,60,0,180,0,64,0,0,0,0,0,0
	db 109,60,111,0,111,0,175,1,175,1,167,1,167,1,175,1
	db 0,128,0,192,0,64,0,192,0,192,0,192,0,192,0,192
	db 0,0,0,0,0,0,0,0,0,0,0,4,0,0,60,1
	db 128,1,112,6,224,62,240,2,240,2,240,6,112,6,112,6
	db 0,0,0,48,192,48,0,6,0,122,0,9,0,27,0,23
	db 0,0,0,0,0,0,0,0,0,0,0,0,3,0,10,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,191
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,240,0,240
	db 14,0,26,0,6,0,245,0,189,2,167,10,165,10,169,26
	db 255,171,255,170,111,170,150,106,253,94,255,255,255,254,127,95
	db 0,252,0,252,0,252,192,255,240,191,252,171,252,250,175,250
	db 169,5,101,1,85,1,84,0,0,0,0,0,0,0,0,0
	db 103,85,85,213,85,101,102,89,90,85,106,85,84,5,64,1
	db 168,250,168,126,160,86,128,84,0,160,0,128,0,0,0,0
	db 64,1,64,1,64,1,64,1,64,1,80,5,80,5,80,5
	db 0,0,0,0,0,0,0,0,0,0,63,0,175,0,234,0
	db 0,0,0,0,0,0,0,0,0,0,192,255,192,255,192,255
	db 106,0,90,3,127,42,95,42,151,42,85,5,89,5,5,0
	db 192,111,252,151,191,254,239,255,234,127,234,85,106,85,128,90
	db 0,0,0,0,0,0,0,0,0,192,0,0,0,0,0,0
	db 5,0,1,0,0,0,0,0,0,0,0,0,1,0,1,0
	db 0,106,0,84,0,64,0,64,0,64,0,64,0,80,0,80
	db 0,0,0,0,0,0,255,2,175,6,166,13,255,43,127,105
	db 0,0,0,0,0,0,0,192,0,192,0,240,0,188,0,235
	db 85,25,90,4,90,0,16,0,16,0,16,0,20,0,20,0
	db 0,232,0,64,0,0,0,0,0,0,0,0,0,0,0,0
	db 240,10,124,54,251,39,88,21,160,1,0,0,0,0,64,1
	db 0,0,0,0,0,63,0,27,128,151,0,6,0,4,0,4
	db 28,0,107,0,103,0,107,1,91,5,171,5,107,5,169,21
	db 0,0,0,0,0,0,0,192,0,240,0,112,0,240,0,252
	db 170,21,166,21,170,21,154,21,170,21,106,21,169,21,171,21
	db 0,244,0,252,0,220,0,252,0,124,0,252,0,252,0,244
	db 167,21,171,5,155,5,107,1,107,1,105,0,44,0,20,0
	db 0,252,0,208,0,240,0,64,0,192,0,0,0,0,0,0
	db 28,0,28,0,20,0,20,0,20,0,20,0,20,0,20,0
	db 192,0,112,1,188,5,188,21,188,21,159,22,173,22,175,22
	db 175,22,167,22,159,22,189,22,127,22,188,22,180,5,188,5
	db 192,0,64,0,192,0,64,0,64,0,64,0,64,0,64,0
	db 0,11,0,27,192,27,192,89,192,90,192,86,192,90,192,91
	db 64,27,0,27,0,9,0,4,0,4,0,4,0,4,0,4
	db 0,0,0,0,0,0,0,0,0,0,0,28,0,28,0,103
	db 0,107,0,91,0,111,0,44,0,20,0,0,0,0,0,0
	db 0,16,0,96,0,108,0,108,0,96,0,48,0,16,0,16
	db 85,85,255,127,255,127,255,126,170,122,170,106,170,122,255,126
	db 85,85,253,255,253,255,253,255,253,170,253,170,189,170,189,250
	db 255,127,255,127,255,127,85,85,64,1,64,1,64,1,64,1
	db 189,250,189,250,253,255,85,85,64,1,64,1,64,1,64,1
	db 0,0,0,0,0,0,0,0,85,85,255,127,255,123,170,106
	db 0,0,0,0,0,0,0,0,0,85,0,253,0,253,0,189
	db 170,106,254,123,254,127,255,127,85,85,0,5,0,5,0,5
	db 0,173,0,173,0,173,0,253,0,85,0,80,0,80,0,80
	db 253,255,253,239,173,170,237,239,237,255,85,85,16,16,16,16
	db 0,0,0,0,0,0,192,255,192,234,192,254,64,85,0,17
	db 0,0,0,0,0,0,0,0,0,255,0,171,0,255,0,0
	db 255,255,170,234,170,239,234,239,250,234,190,234,171,234,171,234
	db 255,255,171,170,107,170,171,169,171,166,171,154,171,234,171,234
	db 171,234,171,234,170,234,255,255,1,0,1,0,1,0,1,0
	db 171,234,171,234,171,170,255,255,0,64,0,64,0,64,0,64
	db 0,0,0,0,0,0,0,0,255,255,170,254,170,255,169,235
	db 0,0,0,0,0,0,0,0,0,255,0,155,0,107,0,171
	db 190,234,190,234,190,234,170,234,255,255,20,0,20,0,20,0
	db 0,171,0,171,0,171,0,171,0,255,0,0,0,0,0,0
	db 171,170,155,186,107,174,171,171,171,171,255,255,0,1,0,1
	db 0,0,0,0,0,0,128,170,128,186,128,174,192,255,0,4
	db 0,0,0,0,0,0,0,0,0,234,0,170,0,170,0,0
	db 215,215,215,151,125,189,125,189,215,151,215,151,125,189,0,128
	db 208,215,208,215,112,125,112,125,208,215,208,215,112,125,0,0
	db 0,128,0,128,0,128,0,128,0,128,0,128,0,128,0,128
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,117,223
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,208
	db 223,181,223,181,117,159,223,181,0,128,0,128,0,128,0,128
	db 0,112,0,112,0,208,0,112,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,116,119,220,221,116,119,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,192,125
	db 192,125,64,215,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,212,0,0,0,0,0,0,0,0
	db 48,12,48,12,64,1,192,3,160,10,160,10,193,213,195,255
	db 12,195,12,195,1,20,3,60,10,170,10,170,213,80,255,243
	db 195,48,195,48,20,64,60,192,170,160,170,160,80,193,243,195
	db 195,255,194,234,14,42,14,42,2,42,2,42,1,17,1,17
	db 255,243,234,172,42,160,42,160,42,160,42,160,17,16,17,16
	db 243,195,172,194,160,14,160,14,160,2,160,2,16,1,16,1
	db 0,0,0,0,0,0,0,0,0,0,0,48,5,5,15,15
	db 0,0,0,0,0,0,0,0,0,0,204,12,1,1,3,3
	db 0,0,0,0,0,0,0,0,0,0,0,192,0,0,0,0
	db 10,42,20,215,60,255,43,235,232,40,40,40,40,40,20,4
	db 138,10,21,215,63,255,42,235,42,40,42,40,42,40,17,16
	db 0,128,0,0,0,192,0,0,0,0,0,0,0,0,0,0
	db 48,12,195,48,162,40,255,243,138,162,138,162,138,162,69,81
	db 0,195,0,12,0,138,0,63,0,40,0,40,0,40,0,20
	db 0,0,0,0,0,0,0,0,34,34,252,252,136,136,68,68
	db 0,0,0,0,0,0,0,0,0,0,64,1,192,255,128,160
_gfx_obj_cells:
	db 0,0,0,1,0,1,2,0,2,0,1,3,1,1,4,2
	db 1,5,1,2,6,1,3,7,2,3,8,0,0,9,1,0
	db 10,2,0,11,0,1,12,1,1,13,2,1,14,0,2,15
	db 1,2,16,0,0,17,1,0,18,0,1,19,1,1,20,0
	db 0,21,0,1,22,0,0,23,0,0,24,1,0,25,0,1
	db 26,1,1,27,0,2,28,1,2,29,0,0,30,1,0,31
	db 0,1,32,1,1,33,0,0,34,0,1,35,0,0,36,0
	db 0,37,0,0,38,1,0,39,0,1,40,1,1,41,0,2
	db 42,1,2,43,0,0,44,1,0,45,0,1,46,1,1,47
	db 0,0,48,0,1,49,0,0,50,0,0,51,0,0,52,1
	db 0,53,2,0,54,0,0,55,1,0,56,2,0,57,0,0
	db 58,1,0,59,0,0,60,0,0,61,0,0,62,1,0,63
	db 0,1,64,1,1,65,0,2,66,1,2,67,0,3,68,1
	db 3,69,0,0,70,1,0,71,0,1,72,1,1,73,0,2
	db 74,1,2,75,0,0,76,0,1,77,0,0,78,0,1,79
	db 0,0,80,0,0,81,1,0,82,0,0,83,1,0,84,0
	db 0,85,0,0,86,0,0,87,0,0,88,1,0,89,2,0
	db 90,0,1,91,1,1,92,2,1,93,0,2,94,1,2,95
	db 2,2,96,0,3,97,1,3,98,2,3,99,0,0,100,1
	db 0,101,0,1,102,1,1,103,0,2,104,1,2,105,0,0
	db 106,1,0,107,0,1,108,1,1,109,0,0,110,0,1,111
	db 0,0,112,0,0,113,1,0,114,2,0,115,0,1,116,1
	db 1,117,2,1,118,0,2,119,1,2,120,2,2,121,1,3
	db 122,0,0,123,1,0,124,0,1,125,1,1,126,2,1,127
	db 0,2,128,1,2,129,0,0,130,1,0,131,0,1,132,1
	db 1,133,0,1,134,0,0,135,0,0,113,1,0,114,2,0
	db 115,0,1,116,1,1,117,2,1,118,0,2,119,1,2,120
	db 2,2,121,1,3,122,0,0,123,1,0,124,0,1,125,1
	db 1,126,2,1,127,0,2,128,1,2,129,0,0,130,1,0
	db 131,0,1,132,1,1,133,0,1,134,0,0,135,0,0,136
	db 1,0,137,0,1,138,1,1,139,0,2,140,1,2,141,0
	db 3,142,0,0,143,0,1,144,0,2,145,0,0,146,0,1
	db 147,0,0,148,0,1,149,0,0,150,0,0,136,1,0,137
	db 0,1,138,1,1,139,0,2,140,1,2,141,0,3,142,0
	db 0,143,0,1,144,0,2,145,0,0,146,0,1,147,0,0
	db 148,0,1,149,0,0,150,0,0,151,1,0,152,0,1,153
	db 1,1,154,0,0,155,1,0,156,0,1,157,1,1,158,0
	db 0,159,0,0,160,0,0,161,0,0,162,1,0,163,0,1
	db 164,1,1,165,0,0,166,1,0,167,0,1,168,1,1,169
	db 0,0,170,0,0,171,0,0,172,0,0,173,1,0,174,0
	db 1,175,0,2,175,0,0,176,1,0,177,0,1,178,1,1
	db 179,0,2,175,0,0,180,0,0,181,0,1,182,0,0,183
	db 0,0,184,1,0,185,2,0,186,0,1,187,1,1,188,2
	db 1,189,0,0,190,1,0,191,2,0,192,0,1,193,1,1
	db 194,2,1,195,0,0,196,1,0,197,0,0,198,0,0,199
	align 2
_gfx_obj_frames:
	db 3,4,9,0,0,0,24,32,3,3,8,0,9,0,17,24
	db 2,2,4,0,17,0,12,16,1,2,2,0,21,0,8,16
	db 1,1,1,0,23,0,5,8,2,3,6,0,24,0,16,24
	db 2,2,4,0,30,0,12,16,1,2,2,0,34,0,8,16
	db 1,1,1,0,36,0,5,8,1,1,1,0,37,0,4,8
	db 2,3,6,0,38,0,16,24,2,2,4,0,44,0,12,16
	db 1,2,2,0,48,0,8,16,1,1,1,0,50,0,5,8
	db 1,1,1,0,51,0,4,8,3,1,3,0,52,0,24,8
	db 3,1,3,0,55,0,17,8,2,1,2,0,58,0,12,8
	db 1,1,1,0,60,0,8,8,1,1,1,0,61,0,5,8
	db 2,4,8,0,62,0,16,32,2,3,6,0,70,0,12,24
	db 1,2,2,0,76,0,8,16,1,2,2,0,78,0,5,16
	db 1,1,1,0,80,0,4,8,2,1,2,0,81,0,16,8
	db 2,1,2,0,83,0,12,8,1,1,1,0,85,0,8,8
	db 1,1,1,0,86,0,5,8,1,1,1,0,87,0,4,8
	db 3,4,12,0,88,0,24,32,3,3,6,0,100,0,17,24
	db 2,2,4,0,106,0,12,16,1,2,2,0,110,0,8,16
	db 1,1,1,0,112,0,5,8,3,4,10,0,113,0,24,32
	db 3,3,7,0,123,0,17,24,2,2,4,0,130,0,12,16
	db 1,2,1,0,134,0,8,16,1,1,1,0,135,0,5,8
	db 3,4,10,0,136,0,24,32,3,3,7,0,146,0,17,24
	db 2,2,4,0,153,0,12,16,1,2,1,0,157,0,8,16
	db 1,1,1,0,158,0,5,8,2,4,7,0,159,0,12,32
	db 2,3,3,0,166,0,9,24,1,2,2,0,169,0,6,16
	db 1,2,2,0,171,0,4,16,1,1,1,0,173,0,3,8
	db 2,4,7,0,174,0,12,32,2,3,3,0,181,0,9,24
	db 1,2,2,0,184,0,6,16,1,2,2,0,186,0,4,16
	db 1,1,1,0,188,0,3,8,2,2,4,0,189,0,16,16
	db 2,2,4,0,193,0,12,16,1,1,1,0,197,0,8,8
	db 1,1,1,0,198,0,5,8,1,1,1,0,199,0,4,8
	db 2,2,4,0,200,0,16,16,2,2,4,0,204,0,12,16
	db 1,1,1,0,208,0,8,8,1,1,1,0,209,0,5,8
	db 1,1,1,0,210,0,4,8,2,3,4,0,211,0,14,24
	db 2,3,5,0,215,0,10,24,1,2,1,0,220,0,7,16
	db 1,2,2,0,221,0,5,16,1,1,1,0,223,0,3,8
	db 3,2,6,0,224,0,24,16,3,2,6,0,230,0,17,16
	db 2,1,2,0,236,0,12,8,1,1,1,0,238,0,8,8
	db 1,1,1,0,239,0,5,8
	align 2
_gfx_traffic_pals:
	db 0,0,3,4,57,12,158,15,0,0,36,0,206,2,255,9
	db 0,0,4,3,94,10,191,14,0,0,48,1,179,5,250,11
	db 0,0,33,4,166,14,237,15
	align 2
_gfx_obj_pals:
	db 0,0,65,2,179,3,205,8,0,0,49,1,148,4,234,8
	db 0,0,33,1,98,2,166,5,0,0,53,4,138,8,222,12
	db 0,0,86,5,171,9,255,14,0,0,49,1,163,3,233,6
	db 0,0,69,4,204,12,255,15,0,0,50,1,164,2,218,5
	db 0,0,37,0,125,2,207,4,0,0,50,0,165,3,219,6
	db 0,0,53,0,173,2,239,7,0,0,17,1,30,1,255,15
	db 0,0,255,15,129,3,255,15,0,0,17,1,136,8,255,15
	db 0,0,36,1,78,3,207,10
	align 2
_gfx_title_tiles:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,3,0,63,0,255,15
	db 0,0,0,0,0,0,15,0,255,3,255,255,213,255,85,245
	db 0,0,0,0,255,3,255,255,253,255,85,213,85,85,85,85
	db 0,0,255,63,255,255,253,255,85,85,85,85,85,85,85,85
	db 0,0,255,255,255,255,85,85,85,85,85,85,85,85,255,127
	db 0,0,255,255,255,255,85,85,85,85,85,85,85,85,85,255
	db 0,0,252,255,255,255,255,127,85,85,85,85,85,85,85,85
	db 0,0,0,0,192,255,255,255,255,127,87,85,85,85,85,85
	db 0,0,0,0,0,0,0,240,192,255,255,255,255,87,95,85
	db 0,0,0,0,0,0,0,0,0,0,0,192,0,252,240,255
	db 0,0,0,0,0,0,0,0,0,0,15,0,63,0,255,3
	db 0,0,63,0,255,3,253,63,213,255,85,253,85,213,85,85
	db 253,255,85,255,85,213,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,86,85,90,85,170,85,170,86,85,85,85,85,85,85
	db 187,187,238,238,170,170,170,170,170,170,85,85,85,85,85,85
	db 149,187,213,238,169,170,170,170,170,170,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,149,85,165,85,85,85,85,85,85
	db 255,127,255,85,87,85,85,85,85,85,85,85,85,85,127,85
	db 0,0,0,252,192,255,252,127,255,87,127,85,87,85,85,255
	db 0,0,0,0,0,0,0,0,0,0,0,240,0,252,192,255
	db 0,0,0,0,3,0,15,0,63,0,255,0,253,3,245,15
	db 245,15,213,255,85,253,85,245,85,213,85,85,127,85,255,87
	db 85,85,85,85,85,85,85,85,85,85,85,85,255,213,255,255
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,245
	db 85,85,86,85,90,85,90,85,90,85,90,85,90,85,170,170
	db 255,255,255,255,255,255,255,255,187,187,238,238,170,170,170,170
	db 240,223,255,247,127,253,95,255,87,187,85,238,101,170,170,170
	db 0,0,0,0,0,192,0,240,0,252,0,255,192,127,240,95
	db 0,0,0,0,0,0,3,0,3,0,15,0,63,0,63,0
	db 213,63,85,63,85,253,85,245,85,245,85,213,85,85,85,85
	db 255,95,255,127,187,123,238,110,170,106,170,170,170,170,85,85
	db 255,255,255,255,187,187,238,238,170,170,170,170,170,170,85,85
	db 85,253,85,255,85,187,85,238,101,170,170,170,170,170,85,85
	db 85,85,102,102,153,153,170,170,170,170,170,234,170,250,170,170
	db 85,85,102,102,153,153,170,170,170,170,170,170,170,170,170,170
	db 87,85,102,102,153,153,170,170,170,170,170,170,170,170,170,170
	db 255,255,102,102,153,153,170,170,170,170,170,170,170,170,170,170
	db 252,87,252,85,127,85,95,85,95,85,87,85,85,85,85,85
	db 0,0,0,0,0,0,0,192,0,192,0,240,0,252,0,252
	db 253,0,253,0,245,0,245,3,245,3,213,3,217,3,230,15
	db 153,153,102,102,170,170,170,170,170,170,170,170,238,238,187,187
	db 153,153,102,102,170,170,170,170,171,170,175,170,191,170,255,170
	db 170,170,170,170,255,170,255,191,255,255,255,255,255,255,255,255
	db 170,170,170,170,234,255,255,255,255,255,255,255,255,255,255,255
	db 153,153,102,102,170,170,170,170,170,250,170,254,170,255,234,255
	db 0,127,0,127,0,95,192,95,192,95,192,87,192,155,240,103
	db 234,15,234,15,234,15,234,15,234,15,234,15,234,15,234,15
	db 170,170,170,170,170,170,153,153,102,102,85,85,85,85,85,85
	db 85,85,85,85,255,127,255,127,255,127,85,85,85,85,255,255
	db 85,85,85,85,255,255,255,255,255,255,85,85,85,85,255,255
	db 170,170,170,170,170,170,153,153,102,102,85,85,85,85,85,213
	db 240,171,240,171,240,171,240,171,240,171,240,171,240,171,240,171
	db 234,15,234,3,192,3,240,3,240,3,240,0,252,0,252,0
	db 170,170,170,170,80,0,5,20,1,0,84,1,0,0,1,0
	db 170,170,170,170,0,0,0,84,1,84,0,0,0,0,0,85
	db 170,170,170,170,0,0,0,0,1,84,0,0,0,85,0,0
	db 170,170,170,170,5,0,0,0,0,64,64,5,0,0,0,0
	db 170,170,170,170,0,64,0,0,0,0,0,0,5,0,0,0
	db 170,170,170,170,2,0,0,0,0,0,0,0,0,84,0,0
	db 255,255,255,255,255,85,127,85,0,5,15,16,80,0,0,5
	db 255,255,255,255,175,170,183,170,213,160,85,3,87,13,87,181
	db 255,255,255,255,170,250,170,222,160,87,192,85,122,213,92,213
	db 255,255,255,255,213,255,85,255,0,15,5,240,80,0,0,13
	db 85,213,85,213,0,80,0,64,0,64,0,0,0,0,0,0
	db 170,170,170,170,0,0,0,0,20,0,0,0,0,0,0,0
	db 170,170,170,170,0,0,1,0,80,0,64,1,0,0,0,0
	db 170,170,170,170,0,0,0,80,0,0,0,0,0,0,0,0
	db 170,170,170,170,0,0,0,0,0,0,0,0,0,0,1,0
	db 170,170,170,170,0,0,0,0,0,0,0,0,0,0,0,84
	db 240,171,192,171,192,23,192,15,192,15,0,15,0,63,0,127
	db 63,0,63,0,15,0,3,0,3,0,0,0,0,0,0,0
	db 0,0,0,0,0,192,0,240,0,240,0,252,235,63,238,63
	db 0,0,85,0,0,5,84,1,1,0,0,80,174,187,186,187
	db 0,0,0,0,0,0,0,0,0,80,0,0,187,238,235,238
	db 0,0,0,0,0,0,5,0,0,0,0,0,238,186,174,187
	db 0,0,5,0,64,5,0,64,0,0,0,0,187,235,187,238
	db 0,0,0,80,0,0,0,0,0,0,0,0,238,174,239,186
	db 10,0,175,0,61,2,245,0,213,3,85,13,85,181,85,213
	db 85,213,87,85,87,85,85,85,85,85,87,85,87,85,85,85
	db 87,85,85,213,85,213,85,85,85,85,85,213,85,213,85,85
	db 8,160,160,240,0,126,0,95,224,87,112,85,95,85,87,85
	db 0,0,0,0,0,0,0,0,0,0,0,0,238,186,174,251
	db 0,0,0,0,0,0,0,0,0,0,80,5,187,235,187,238
	db 0,0,0,0,0,0,64,1,0,0,0,0,238,174,238,186
	db 85,0,0,0,64,5,0,0,80,0,64,5,186,187,187,235
	db 0,84,0,0,0,0,0,0,65,21,0,0,235,238,238,174
	db 0,0,5,0,83,1,15,0,15,84,63,0,252,187,252,187
	db 0,252,0,252,0,240,0,192,0,192,0,0,0,0,0,0
	db 250,15,254,3,255,0,63,0,15,0,3,0,0,0,0,0
	db 170,170,170,170,170,170,170,234,170,250,170,254,234,255,250,15
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,171,170,175,170
	db 175,170,189,170,245,170,213,171,85,175,85,253,85,245,85,213
	db 87,85,87,85,85,85,85,85,87,85,85,85,85,85,87,85
	db 85,213,85,213,85,85,85,85,85,213,85,85,85,85,85,213
	db 170,250,170,126,170,95,234,87,250,85,127,85,95,85,87,85
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,234,170,250
	db 170,170,170,170,170,170,171,170,175,170,191,170,255,171,240,175
	db 240,175,192,191,0,255,0,252,0,240,0,192,0,0,0,0
	db 255,3,63,0,15,0,0,0,0,0,0,0,0,0,0,0
	db 170,170,170,234,170,254,234,255,254,63,255,3,63,0,0,0
	db 170,170,170,170,170,170,170,170,170,170,171,234,175,255,255,255
	db 189,170,245,170,213,171,85,175,85,253,85,245,85,213,85,85
	db 87,85,85,85,85,85,87,85,85,85,85,85,87,85,95,85
	db 85,213,85,85,85,85,85,213,85,85,85,85,85,213,85,245
	db 170,126,170,95,234,87,250,85,127,85,95,85,87,85,85,85
	db 170,170,170,170,170,170,170,170,170,170,171,234,255,250,255,255
	db 170,170,171,170,191,170,255,171,252,191,192,255,0,252,0,0
	db 192,255,0,252,0,240,0,0,0,0,0,0,0,0,0,0
	db 255,15,63,0,3,0,0,0,0,0,0,0,0,0,0,0
	db 85,245,213,255,255,255,255,3,15,0,0,0,0,0,0,0
	db 85,85,85,85,85,213,253,255,255,255,255,3,0,0,0,0
	db 85,85,85,85,85,85,85,85,253,255,255,255,255,63,0,0
	db 85,85,85,85,95,85,85,85,85,85,255,255,255,255,0,0
	db 85,85,85,85,85,245,85,85,85,85,255,255,255,255,0,0
	db 85,85,85,85,85,85,85,85,255,127,255,255,252,255,0,0
	db 85,85,85,85,87,85,255,127,255,255,192,255,0,0,0,0
	db 95,85,255,87,255,255,192,255,0,240,0,0,0,0,0,0
	db 240,255,0,252,0,192,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,16,0,16,0,24,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,85,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,85,85
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,85,21
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,84,85
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,85
	db 0,0,0,0,0,0,5,0,2,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,85,84,149,85,169,165,2,42,0
	db 24,0,24,0,84,0,86,0,22,0,22,0,85,80,85,84
	db 0,0,0,0,0,0,5,0,85,0,85,5,86,21,90,85
	db 127,0,106,21,229,95,165,90,165,90,149,122,191,86,170,86
	db 253,255,169,170,85,85,85,85,1,0,65,85,65,253,85,169
	db 245,95,245,95,213,127,213,127,149,106,85,234,85,170,85,170
	db 245,31,245,95,213,127,213,127,149,106,87,234,86,170,86,170
	db 212,127,213,127,245,255,245,255,165,170,151,170,126,169,106,169
	db 212,127,213,127,87,255,87,255,86,170,94,169,85,169,85,169
	db 255,31,170,90,85,249,85,169,64,169,85,165,255,175,170,170
	db 87,255,87,255,95,85,95,85,90,0,122,80,106,80,106,85
	db 255,255,170,170,85,165,85,165,0,165,85,149,253,191,169,170
	db 95,253,90,169,85,85,85,85,1,0,1,64,1,64,5,64
	db 255,255,255,255,213,127,213,127,148,106,84,234,84,170,80,170
	db 0,245,0,165,0,85,0,85,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,1,0,21,0,90,1
	db 0,0,0,0,85,0,85,21,85,85,106,89,128,170,0,0
	db 2,0,85,85,85,85,85,85,85,101,170,170,0,0,0,0
	db 85,85,85,165,85,105,85,86,149,85,85,149,85,165,85,26
	db 168,170,170,170,170,170,165,170,166,170,166,170,165,170,165,170
	db 85,5,85,85,85,85,87,85,254,255,170,170,85,85,85,85
	db 87,171,86,170,86,170,94,169,85,149,85,149,1,84,1,84
	db 86,169,86,169,86,169,90,165,170,170,170,170,85,85,85,85
	db 90,169,90,169,90,169,106,165,106,85,106,85,85,80,85,80
	db 170,165,170,165,90,165,106,149,106,149,106,148,85,84,85,84
	db 65,165,65,165,0,165,85,149,170,149,170,149,85,85,85,85
	db 106,85,106,85,106,1,170,85,165,170,165,170,85,85,85,85
	db 170,149,170,149,170,149,169,86,170,86,170,86,85,5,85,5
	db 85,85,85,85,0,80,85,85,253,255,169,170,85,85,85,85
	db 6,64,6,64,22,0,26,64,26,64,26,64,21,64,21,64
	db 80,169,80,169,64,169,64,165,64,165,0,165,0,85,0,85
	db 160,1,128,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,1,0,5,0,5,0,22,0,86,0,90,0
	db 149,87,149,86,149,127,37,127,37,252,9,112,2,240,2,192
	db 85,85,85,85,85,85,85,85,85,85,149,85,165,85,41,85
	db 80,85,84,85,85,149,149,101,37,90,10,84,0,84,0,84
	db 0,0,0,0,0,64,0,84,0,84,0,85,80,169,84,10
	db 0,0,0,0,0,0,85,5,255,7,170,22,165,30,165,26
	db 0,0,0,0,0,0,84,85,212,255,149,170,181,90,165,90
	db 0,0,0,0,0,0,85,21,245,31,165,90,149,122,149,106
	db 0,0,0,0,0,0,84,85,212,127,149,106,181,234,165,170
	db 0,0,0,0,0,0,84,85,212,127,148,106,84,234,84,170
	db 107,1,107,5,172,5,172,21,176,22,176,86,192,90,192,90
	db 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 9,85,2,149,64,149,64,149,64,37,64,5,64,9,80,9
	db 0,85,64,101,80,165,80,9,84,1,85,2,149,0,37,0
	db 165,0,9,0,2,0,0,0,0,0,0,0,0,0,0,64
	db 0,64,0,64,0,128,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,1,0,1,0,1,0,5,0,7,0
	db 245,95,213,127,255,127,255,127,170,234,170,170,90,170,122,169
	db 165,90,149,122,85,233,85,169,71,85,70,85,22,245,94,149
	db 213,127,85,255,85,255,85,255,87,169,86,169,86,169,94,165
	db 213,127,87,255,87,255,87,255,94,169,90,169,90,169,122,165
	db 245,255,215,255,127,253,127,253,234,165,170,165,90,165,122,149
	db 80,255,80,253,80,253,64,253,64,165,64,165,0,165,0,149
	db 1,0,1,0,5,0,6,0,6,0,6,0,26,0,26,0
	db 0,171,0,171,0,171,0,172,0,172,0,172,0,176,0,176
	db 80,9,80,1,80,2,80,2,16,2,144,0,144,0,148,0
	db 37,0,10,0,8,0,0,0,0,0,0,0,0,0,0,0
	db 0,64,0,64,0,144,0,148,0,36,0,37,0,9,64,2
	db 6,0,6,0,5,0,5,0,0,0,0,0,0,0,0,0
	db 86,169,86,169,69,85,69,85,0,0,0,0,0,0,0,0
	db 85,189,85,169,65,85,65,85,0,0,0,0,0,0,0,0
	db 250,175,170,170,85,85,85,85,0,0,0,0,0,0,0,0
	db 106,85,106,85,85,80,85,80,0,0,0,0,0,0,0,0
	db 106,149,106,148,85,84,85,84,0,0,0,0,0,0,0,0
	db 0,149,0,148,0,84,0,84,0,0,0,0,0,0,0,0
	db 26,0,26,0,106,0,106,0,106,0,106,0,106,0,106,0
	db 0,176,0,176,0,192,0,192,0,192,0,192,0,192,0,192
	db 20,0,36,0,4,0,36,0,37,0,9,0,4,0,8,0
	db 80,2,64,0,128,0,0,0,0,0,0,0,0,0,0,0
	db 106,1,171,1,171,1,171,1,171,1,171,1,171,1,171,1
	db 0,192,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 171,5,171,5,171,5,171,5,171,5,171,5,171,5,171,5
	db 0,192,0,192,0,192,0,192,0,192,0,192,0,192,0,192
	db 170,5,106,1,106,1,106,1,106,1,106,1,106,1,106,1
	db 0,240,0,240,0,240,0,240,0,176,0,176,0,176,0,188
	db 90,0,90,0,90,0,90,0,22,0,22,0,22,0,0,0
	db 0,172,0,172,0,172,0,172,0,171,0,171,0,171,0,0
	db 0,3,192,15,240,63,252,255,192,15,192,15,64,5,0,0
	db 192,15,192,15,252,255,240,63,192,15,0,3,0,1,0,0
	align 2
_gfx_emblem_map:
	db 255,255,255,255,255,255,255,255,1,0,2,0,3,0,4,0
	db 5,0,6,0,7,0,8,0,9,0,10,0,255,255,255,255
	db 255,255,255,255,255,255,255,255,11,0,12,0,13,0,14,0
	db 14,0,15,0,16,0,17,0,18,0,14,0,14,0,19,0
	db 20,0,21,0,255,255,255,255,255,255,22,0,23,0,24,0
	db 25,0,14,0,14,0,14,0,14,0,14,0,14,0,14,0
	db 26,0,27,0,27,0,28,0,29,0,255,255,30,0,31,0
	db 32,0,33,0,34,0,35,0,36,0,36,0,36,0,36,0
	db 36,0,37,0,38,0,38,0,38,0,38,0,39,0,40,0
	db 41,0,42,0,42,0,42,0,42,0,42,0,42,0,43,0
	db 44,0,45,0,46,0,42,0,42,0,42,0,42,0,42,0
	db 42,0,47,0,48,0,49,0,49,0,49,0,49,0,49,0
	db 49,0,50,0,51,0,51,0,51,0,52,0,49,0,49,0
	db 49,0,49,0,49,0,53,0,54,0,55,0,56,0,57,0
	db 58,0,59,0,60,0,61,0,62,0,63,0,64,0,65,0
	db 66,0,67,0,68,0,69,0,70,0,71,0,72,0,73,0
	db 74,0,75,0,76,0,77,0,78,0,79,0,80,0,81,0
	db 82,0,83,0,84,0,85,0,86,0,87,0,88,0,89,0
	db 255,255,90,0,91,0,92,0,92,0,93,0,94,0,14,0
	db 95,0,96,0,14,0,97,0,98,0,92,0,92,0,99,0
	db 100,0,255,255,255,255,255,255,101,0,102,0,103,0,104,0
	db 14,0,14,0,105,0,106,0,14,0,14,0,107,0,108,0
	db 109,0,110,0,255,255,255,255,255,255,255,255,255,255,255,255
	db 111,0,112,0,113,0,114,0,115,0,116,0,117,0,118,0
	db 119,0,120,0,255,255,255,255,255,255,255,255
_gfx_emblem_pal:
	db 0,0,0,0,0,8,8,8,8,8,8,8,8,0,0,0
	db 0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8
	db 8,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8
	db 8,0,0,0,0,0,0,5,1,1,1,2,2,2,2,2
	db 2,2,2,2,2,2,5,0,11,3,3,3,3,3,3,9
	db 9,9,9,3,3,3,3,3,3,11,6,10,10,10,10,10
	db 10,10,10,10,10,10,10,10,10,10,10,6,6,11,11,11
	db 11,11,11,10,4,4,10,10,11,11,11,11,11,11,0,5
	db 5,5,5,5,5,6,6,6,6,5,5,5,5,5,5,0
	db 0,5,5,5,5,5,7,4,6,6,4,7,5,5,5,5
	db 5,0,0,0,0,5,5,7,4,4,6,6,4,4,7,5
	db 5,0,0,0,0,0,0,0,0,6,6,6,6,6,6,6
	db 6,0,0,0,0,0
	align 2
_gfx_emblem_pals:
	db 82,10,183,15,189,13,255,15,82,10,201,15,189,13,255,15
	db 82,10,183,15,201,15,189,13,82,10,201,15,204,14,207,11
	db 82,10,153,10,223,5,255,8,82,10,200,15,223,10,255,15
	db 82,10,153,10,191,9,255,15,82,10,153,10,223,10,255,15
	db 82,10,165,15,189,13,255,15,82,10,201,15,204,14,255,8
	db 82,10,191,9,207,11,255,8,82,10,204,14,191,9,255,15
	db 82,10,165,15,189,13,255,15
	align 2
_gfx_over_map:
	db 255,255,255,255,255,255,255,255,122,0,255,255,123,0,124,0
	db 124,0,125,0,126,0,126,0,125,0,124,0,124,0,124,0
	db 124,0,127,0,255,255,255,255,255,255,255,255,128,0,129,0
	db 130,0,131,0,132,0,133,0,134,0,135,0,136,0,137,0
	db 138,0,139,0,140,0,141,0,142,0,143,0,255,255,255,255
	db 255,255,144,0,145,0,146,0,147,0,148,0,149,0,150,0
	db 151,0,152,0,153,0,154,0,155,0,156,0,157,0,158,0
	db 159,0,255,255,255,255,255,255,255,255,160,0,255,255,161,0
	db 162,0,163,0,164,0,165,0,255,255,255,255,166,0,167,0
	db 168,0,168,0,169,0,170,0,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,171,0,172,0,173,0,174,0,175,0
	db 176,0,177,0,178,0,179,0,180,0,181,0,182,0,183,0
	db 255,255,255,255,255,255,255,255,255,255,255,255,184,0,185,0
	db 255,255,186,0,187,0,188,0,255,255,189,0,190,0,191,0
	db 192,0,193,0,194,0,195,0,255,255,255,255,255,255,255,255
	db 255,255,255,255,196,0,197,0,255,255,198,0,255,255,199,0
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,200,0,201,0
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,202,0,203,0,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,204,0,205,0
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,206,0,207,0,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255
_gfx_over_pal:
	db 0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,3,3,3,3,0,1,2,2,2,2
	db 0,2,1,1,2,1,0,0,0,3,3,3,3,7,5,5
	db 5,5,5,5,5,5,5,5,5,0,0,0,0,3,0,4
	db 3,3,3,3,0,0,1,1,1,1,1,1,0,0,0,0
	db 0,0,0,4,3,3,3,3,3,0,6,0,6,6,6,6
	db 0,0,0,0,0,0,4,4,0,3,3,3,0,5,5,5
	db 5,5,5,5,0,0,0,0,0,0,4,4,0,3,0,3
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,3
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,4,3,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,4,4,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,4,4,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0
	align 2
_gfx_over_pals:
	db 15,15,16,3,223,4,255,15,15,15,16,3,255,7,255,15
	db 15,15,16,3,223,4,255,7,15,15,162,4,215,5,156,6
	db 15,15,36,1,105,3,156,6,15,15,16,3,175,3,255,15
	db 15,15,16,3,175,3,223,4,15,15,16,3,162,4,215,5
	align 2
_id_carog_tiles_count:
	db 8,2
	align 2
_id_carog_tiles:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,0
	db 0,0,64,5,80,21,80,21,80,21,64,5,0,0,170,170
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,170,170
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,144
	db 26,0,106,0,170,1,85,6,255,27,85,101,255,111,85,101
	db 153,169,153,169,170,170,85,85,170,234,0,85,0,170,0,85
	db 170,153,170,153,170,170,85,85,171,170,85,0,170,0,85,0
	db 0,164,0,169,64,170,144,85,228,255,89,85,249,255,89,85
	db 255,111,85,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,170,85,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 170,0,85,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 249,255,85,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0
	db 0,0,5,0,21,0,85,0,85,0,21,0,0,0,170,90
	db 0,0,0,64,0,80,0,64,0,64,0,0,0,0,170,170
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,170
	db 21,0,86,0,90,1,101,5,191,5,85,6,255,6,85,25
	db 153,170,153,170,170,170,85,85,170,254,80,85,160,250,64,85
	db 154,153,154,153,170,170,85,85,170,170,5,0,10,0,21,0
	db 64,170,144,170,164,170,89,85,254,191,85,85,255,175,86,85
	db 255,27,85,21,0,0,0,0,0,0,0,0,0,0,0,0
	db 128,234,85,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 42,0,85,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 254,191,85,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,5,0,21,0,5,0,5,0,1,0,0,0,170,1
	db 0,0,0,64,0,80,0,84,0,84,0,80,0,0,170,170
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,165,170
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64
	db 170,1,170,6,170,26,85,101,254,191,85,85,250,255,85,149
	db 102,166,102,166,170,170,85,85,170,170,0,80,0,160,0,84
	db 170,102,170,102,170,170,85,85,191,170,85,5,175,10,85,1
	db 0,84,0,149,64,165,80,89,80,254,144,85,144,255,100,85
	db 0,168,85,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 171,2,85,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 228,255,84,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,162,2,0,0
	db 0,0,0,0,0,0,0,0,0,0,16,16,90,149,0,0
	db 0,0,0,0,252,3,255,15,255,15,255,15,85,165,0,0
	db 0,0,0,0,0,0,0,192,0,240,0,252,128,186,0,0
	db 0,0,0,0,0,0,0,0,0,0,170,0,149,0,150,0
	db 0,0,0,0,0,0,0,0,0,0,0,170,0,86,0,86
	db 0,0,0,0,170,42,86,85,84,85,84,101,84,85,80,21
	db 170,0,0,0,170,170,170,170,0,40,0,0,0,0,0,0
	db 0,170,0,0,170,170,170,170,40,0,0,0,0,0,0,0
	db 0,0,0,0,168,170,85,149,85,21,89,21,85,21,84,5
	db 0,0,0,0,0,0,0,0,0,0,0,0,10,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,64,0,85,138,0,0
	db 0,0,0,0,3,0,63,0,63,0,63,64,149,106,0,0
	db 0,0,0,0,0,252,0,255,192,255,240,255,234,86,0,0
	db 0,0,0,0,0,0,0,0,0,0,10,0,9,0,37,0
	db 0,0,0,0,0,0,0,0,0,0,160,170,96,85,128,149
	db 0,0,0,0,170,10,85,21,84,85,84,101,84,85,80,21
	db 42,0,0,0,170,170,170,170,0,40,0,0,0,0,0,0
	db 128,170,0,0,170,170,170,170,40,0,0,0,0,0,0,0
	db 0,0,0,0,170,170,85,165,85,21,89,21,85,21,84,5
	db 0,0,0,0,0,0,0,0,0,0,4,0,165,170,0,0
	db 0,0,0,0,3,0,3,0,3,0,3,4,169,86,0,0
	db 0,0,0,0,0,252,240,255,252,255,255,255,110,85,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,160,0,0
	db 0,0,0,0,0,0,0,0,0,0,170,10,85,9,86,2
	db 0,0,0,0,0,0,0,0,0,0,0,160,0,96,0,88
	db 0,0,0,0,170,170,90,85,84,85,84,101,84,85,80,21
	db 170,2,0,0,170,170,170,170,0,40,0,0,0,0,0,0
	db 0,168,0,0,170,170,170,170,40,0,0,0,0,0,0,0
	db 0,0,0,0,160,170,84,85,85,21,89,21,85,21,84,5
	align 2
_id_carog_palette:
	db 0,0,39,0,46,1,127,3,0,0,17,1,204,13,223,6
_id_carog_pose_cells:
	db 12,12,12,10,10,10
_id_carog_pose_first:
	db 0,12,24,36,46,56
_id_carog_pose_w:
	db 4,4,4,4,4,4
_id_carog_cells:
	db 0,0,0,1,0,1,2,0,2,3,0,3,0,1,4,1
	db 1,5,2,1,6,3,1,7,0,2,8,1,2,9,2,2
	db 10,3,2,11,0,0,12,1,0,13,2,0,14,3,0,15
	db 0,1,16,1,1,17,2,1,18,3,1,19,0,2,20,1
	db 2,21,2,2,22,3,2,23,0,0,24,1,0,25,2,0
	db 26,3,0,27,0,1,28,1,1,29,2,1,30,3,1,31
	db 0,2,23,1,2,32,2,2,33,3,2,34,0,0,35,1
	db 0,36,2,0,37,3,0,38,1,1,39,2,1,40,0,2
	db 41,1,2,42,2,2,43,3,2,44,0,0,45,1,0,46
	db 2,0,47,3,0,48,1,1,49,2,1,50,0,2,51,1
	db 2,52,2,2,53,3,2,54,0,0,55,1,0,56,2,0
	db 57,3,0,58,1,1,59,2,1,60,0,2,61,1,2,62
	db 2,2,63,3,2,64
	align 2
_id_route_tiles_count:
	db 16,4
	align 2
_id_route_tiles:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,11,0,181,0,213,2
	db 10,0,186,0,234,2,166,45,150,181,86,86,86,89,86,105
	db 0,160,0,174,128,171,120,154,94,150,149,149,101,149,105,149
	db 0,0,0,0,0,0,0,0,0,0,0,224,0,94,128,87
	db 0,0,0,0,0,0,0,0,0,0,0,0,2,0,43,0
	db 0,0,0,0,11,0,181,2,213,10,85,173,85,181,85,85
	db 85,45,85,181,86,85,89,85,105,85,165,85,149,85,85,86
	db 86,165,86,149,86,85,86,85,86,85,86,85,86,85,86,85
	db 90,149,86,149,85,149,85,149,85,149,85,149,85,149,85,149
	db 120,85,94,85,85,149,85,101,85,105,85,90,85,86,149,85
	db 0,0,0,0,0,224,128,94,160,87,122,85,94,85,85,85
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,232
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0
	db 0,0,0,0,2,0,10,0,171,0,189,10,245,170,85,175
	db 181,10,245,42,85,175,85,189,85,213,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,86,85,89,85,105,85,165,85
	db 85,89,85,105,85,165,85,149,85,85,85,85,85,85,85,85
	db 86,85,86,85,86,85,86,85,86,85,86,85,86,85,86,85
	db 85,149,85,149,85,149,85,149,85,149,85,149,85,149,85,149
	db 101,85,105,85,90,85,86,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,149,85,101,85,105,85,90
	db 160,94,168,95,250,85,126,85,87,85,85,85,85,85,85,85
	db 0,0,0,0,0,128,0,160,0,234,160,126,170,95,250,85
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,160
	db 0,0,0,0,0,0,0,0,42,0,170,0,171,10,191,170
	db 42,0,171,2,191,42,253,170,213,175,85,191,85,245,85,85
	db 85,189,85,213,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,86,85,90,85,106,85
	db 149,85,85,86,85,89,85,105,85,165,85,165,85,149,85,85
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,86,149,85,101,85,105,85,90,85,90,85,86,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,85,149,85,165,85,169
	db 126,85,87,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 0,168,128,234,168,254,170,127,250,87,254,85,95,85,85,85
	db 0,0,0,0,0,0,0,0,0,168,0,170,160,234,170,254
	db 0,0,0,0,0,0,0,0,2,0,10,0,170,0,170,10
	db 2,0,170,0,170,2,171,42,191,170,255,170,245,175,213,191
	db 253,170,213,175,85,191,85,253,85,213,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,86,85
	db 105,85,165,85,165,86,149,90,85,106,85,105,85,165,85,165
	db 85,105,85,90,149,90,165,86,169,85,105,85,90,85,90,85
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,149
	db 170,127,250,87,254,85,127,85,87,85,85,85,85,85,85,85
	db 0,128,0,170,128,170,168,234,170,254,170,255,250,95,254,87
	db 0,0,0,0,0,0,0,0,0,128,0,160,0,170,160,170
	db 0,0,0,0,0,0,0,0,0,0,2,0,10,0,170,0
	db 0,0,10,0,42,0,170,2,170,10,171,170,175,170,255,170
	db 171,170,191,170,255,170,253,175,245,191,85,255,85,253,85,213
	db 85,253,85,213,85,85,85,85,85,85,85,85,85,85,85,85
	db 90,85,106,85,170,85,169,86,165,86,149,90,149,106,85,170
	db 85,149,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 86,85,90,85,90,85,90,85,90,85,90,85,90,85,90,85
	db 85,149,85,165,85,165,85,165,85,165,85,165,85,165,85,165
	db 86,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,165,85,169,85,170,149,106,149,90,165,86,169,86,170,85
	db 127,85,87,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 170,234,170,254,170,255,250,127,254,95,255,85,127,85,87,85
	db 0,0,0,160,0,168,128,170,160,170,170,234,170,250,170,255
	db 0,0,0,0,0,0,0,0,0,0,0,128,0,160,0,170
	db 0,0,0,0,10,0,42,0,170,2,170,42,170,170,171,170
	db 170,10,170,42,171,170,175,170,255,170,255,175,253,191,213,255
	db 253,175,245,191,85,255,85,253,85,245,85,85,85,85,85,85
	db 86,85,86,85,90,85,106,85,170,85,169,86,165,86,165,106
	db 85,169,85,165,85,149,85,149,85,85,85,85,85,85,85,85
	db 90,85,90,85,90,85,90,85,90,85,90,85,90,85,90,85
	db 85,165,85,165,85,165,85,165,85,165,85,165,85,165,85,165
	db 106,85,90,85,86,85,86,85,85,85,85,85,85,85,85,85
	db 85,149,85,149,85,165,85,169,85,170,149,106,149,90,169,90
	db 250,127,254,95,255,85,127,85,95,85,85,85,85,85,85,85
	db 160,170,168,170,170,234,170,250,170,255,250,255,254,127,255,87
	db 0,0,0,0,0,160,0,168,128,170,168,170,170,170,170,234
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0
	db 0,0,0,0,0,0,2,0,42,0,170,0,170,42,170,170
	db 170,0,170,10,170,170,170,170,171,170,175,170,255,170,255,175
	db 175,170,255,170,255,175,253,191,213,255,213,255,85,253,85,213
	db 85,255,85,245,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,86,85,90,85,106,85,106,85,170,85,169,86
	db 149,106,85,170,85,169,85,169,85,165,85,149,85,85,85,85
	db 169,86,170,85,106,85,106,85,90,85,86,85,85,85,85,85
	db 85,85,85,85,85,149,85,165,85,169,85,169,85,170,149,106
	db 255,85,95,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 170,250,170,255,250,255,254,127,255,87,255,87,127,85,87,85
	db 0,170,160,170,170,170,170,170,170,234,170,250,170,255,250,255
	db 0,0,0,0,0,0,0,128,0,168,0,170,168,170,170,170
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128
	db 0,0,0,0,0,0,0,0,10,0,42,0,170,2,170,10
	db 10,0,170,0,170,2,170,170,170,170,170,170,171,170,175,170
	db 170,170,171,170,175,170,255,170,255,175,255,191,253,255,245,255
	db 255,191,245,255,213,255,85,253,85,213,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,90,85,90,85,106,85,170,85
	db 169,90,165,106,149,106,85,170,85,170,85,169,85,165,85,165
	db 90,85,90,85,90,85,90,85,106,85,106,85,106,85,106,85
	db 85,165,85,165,85,165,85,165,85,169,85,169,85,169,85,169
	db 165,106,169,90,169,86,170,85,170,85,106,85,90,85,90,85
	db 85,85,85,85,85,85,85,85,85,165,85,165,85,169,85,170
	db 254,255,255,95,255,87,127,85,87,85,85,85,85,85,85,85
	db 170,170,170,234,170,250,170,255,250,255,254,255,255,127,255,95
	db 0,160,0,170,128,170,170,170,170,170,170,170,170,234,170,250
	db 0,0,0,0,0,0,0,0,0,160,0,168,128,170,160,170
	db 170,170,170,170,170,170,171,170,175,170,255,170,255,175,255,191
	db 255,170,255,175,255,191,253,255,245,255,85,255,85,253,85,245
	db 85,255,85,245,85,213,85,85,85,85,85,85,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,85,86,85,90,85,90,85
	db 170,86,170,90,169,90,165,106,165,170,149,170,85,170,85,169
	db 106,85,106,85,106,85,106,85,106,85,106,85,106,85,106,85
	db 85,169,85,169,85,169,85,169,85,169,85,169,85,169,85,169
	db 149,170,165,170,165,106,169,90,170,90,170,86,170,85,106,85
	db 85,85,85,85,85,85,85,85,85,85,85,149,85,165,85,165
	db 255,85,95,85,87,85,85,85,85,85,85,85,85,85,85,85
	db 170,255,250,255,254,255,255,127,255,95,255,85,127,85,95,85
	db 170,170,170,170,170,170,170,234,170,250,170,255,250,255,254,255
	db 255,255,253,255,213,255,85,253,85,245,85,85,85,85,85,85
	db 106,85,170,85,170,86,170,90,170,106,169,170,165,170,149,170
	db 85,165,85,165,85,149,85,85,85,85,85,85,85,85,85,85
	db 90,85,90,85,86,85,85,85,85,85,85,85,85,85,85,85
	db 85,169,85,170,149,170,165,170,169,170,170,106,170,90,170,86
	db 255,255,255,127,255,87,127,85,95,85,85,85,85,85,85,85
	db 0,0,0,168,0,170,160,170,168,170,170,170,170,170,170,170
	db 0,0,0,0,0,0,0,0,0,0,0,128,0,170,128,170
	db 170,234,170,250,170,255,250,255,254,255,255,255,255,127,255,95
	db 168,170,170,170,170,170,170,170,170,170,170,234,170,250,170,255
	db 0,0,0,0,0,160,0,170,160,170,170,170,170,170,170,170
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,168
	db 0,0,0,0,0,0,0,0,0,0,2,0,170,0,170,2
	db 0,0,42,0,170,0,170,10,170,42,170,170,170,170,170,170
	db 0,0,0,0,0,0,0,0,0,0,0,0,2,0,42,0
	db 0,0,0,0,10,0,170,0,170,10,170,170,170,170,170,170
	db 170,42,170,170,170,170,170,170,170,170,171,170,175,170,255,170
	db 171,170,175,170,255,170,255,175,255,191,255,255,253,255,245,255
_id_route_palette_count:
	db 16
	align 2
_id_route_palettes:
	db 82,0,51,3,85,5,255,15,82,0,51,3,85,5,255,15
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	align 2
_id_route_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,1,0,2,0
	db 3,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,5,0,6,0,7,0,8,0
	db 9,0,10,0,11,0,12,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,13,0,14,0,15,0,16,0,17,0,18,0
	db 19,0,20,0,21,0,22,0,23,0,24,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,25,0,26,0,27,0,28,0,29,0,30,0,18,0
	db 19,0,30,0,31,0,32,0,33,0,34,0,35,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,36,0
	db 37,0,38,0,30,0,39,0,40,0,30,0,30,0,18,0
	db 19,0,30,0,30,0,41,0,42,0,30,0,43,0,44,0
	db 45,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,46,0,47,0,48,0
	db 49,0,30,0,30,0,50,0,51,0,30,0,30,0,52,0
	db 53,0,30,0,30,0,54,0,55,0,30,0,30,0,56,0
	db 57,0,58,0,59,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,13,0,60,0,61,0,62,0,30,0
	db 30,0,30,0,63,0,64,0,30,0,30,0,30,0,65,0
	db 66,0,30,0,30,0,30,0,67,0,68,0,30,0,30,0
	db 30,0,69,0,70,0,71,0,24,0,0,0,0,0,0,0
	db 0,0,72,0,73,0,74,0,75,0,76,0,30,0,30,0
	db 30,0,77,0,78,0,30,0,30,0,30,0,30,0,65,0
	db 66,0,30,0,30,0,30,0,30,0,79,0,80,0,30,0
	db 30,0,30,0,81,0,82,0,83,0,84,0,85,0,0,0
	db 86,0,87,0,88,0,89,0,30,0,30,0,30,0,30,0
	db 90,0,91,0,30,0,30,0,30,0,30,0,30,0,92,0
	db 93,0,30,0,30,0,30,0,30,0,30,0,94,0,95,0
	db 30,0,30,0,30,0,30,0,96,0,97,0,98,0,99,0
	db 100,0,101,0,102,0,30,0,30,0,30,0,30,0,103,0
	db 104,0,51,0,30,0,30,0,30,0,30,0,30,0,105,0
	db 106,0,30,0,30,0,30,0,30,0,30,0,54,0,107,0
	db 108,0,30,0,30,0,30,0,30,0,109,0,110,0,111,0
	db 112,0,30,0,30,0,30,0,30,0,30,0,39,0,113,0
	db 114,0,30,0,30,0,30,0,30,0,30,0,30,0,105,0
	db 106,0,30,0,30,0,30,0,30,0,30,0,30,0,115,0
	db 116,0,42,0,30,0,30,0,30,0,30,0,30,0,117,0
	db 30,0,30,0,30,0,65,0,66,0,30,0,30,0,30,0
	db 67,0,68,0,30,0,30,0,30,0,69,0,70,0,71,0
	db 24,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 30,0,30,0,30,0,65,0,66,0,30,0,30,0,30,0
	db 30,0,79,0,80,0,30,0,30,0,30,0,81,0,82,0
	db 83,0,84,0,85,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 30,0,30,0,30,0,92,0,93,0,30,0,30,0,30,0
	db 30,0,30,0,94,0,95,0,30,0,30,0,30,0,30,0
	db 96,0,97,0,98,0,99,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 30,0,30,0,30,0,105,0,106,0,30,0,30,0,30,0
	db 30,0,30,0,54,0,107,0,108,0,30,0,30,0,30,0
	db 30,0,109,0,110,0,111,0,118,0,119,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 30,0,30,0,30,0,105,0,106,0,30,0,30,0,30,0
	db 30,0,30,0,30,0,115,0,116,0,42,0,30,0,30,0
	db 30,0,30,0,30,0,117,0,120,0,121,0,122,0,123,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,0
	db 60,0,61,0,62,0,30,0,30,0,30,0,63,0,64,0
	db 30,0,30,0,30,0,65,0,66,0,30,0,30,0,30,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,72,0,73,0,74,0
	db 75,0,76,0,30,0,30,0,30,0,77,0,78,0,30,0
	db 30,0,30,0,30,0,65,0,66,0,30,0,30,0,30,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,86,0,87,0,88,0,89,0
	db 30,0,30,0,30,0,30,0,90,0,91,0,30,0,30,0
	db 30,0,30,0,30,0,92,0,93,0,30,0,30,0,30,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,124,0,125,0,100,0,101,0,102,0,30,0
	db 30,0,30,0,30,0,103,0,104,0,51,0,30,0,30,0
	db 30,0,30,0,30,0,105,0,106,0,30,0,30,0,30,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 126,0,127,0,128,0,129,0,112,0,30,0,30,0,30,0
	db 30,0,30,0,39,0,113,0,114,0,30,0,30,0,30,0
	db 30,0,30,0,30,0,105,0,106,0,30,0,30,0,30,0
_id_route_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
_id_route_road_half:
	db 1,3,4,6,7,9,11,12,14,15,17,19,20,22,23,25
	db 27,28,30,31,33,35,36,38,39,41,43,44,46,47,49,51
	db 52,54,55,57,59,60,62,63,65,67,68,70,71,73,74,76
	db 78,79,81,82,84,86,87,89,90,92,94,95,97,98,100,102
	db 103,105,106,108,110,111,113,114,116,118,119,121,122,124,126,127
	db 129,130,132,134,135,137,138,140
_id_route_lim0:
	db 175,173,172,170,169,167,165,164,162,161,159,156,155,153,152,150
	db 147,146,144,143,141,139,137,135,134,132,130,129,126,125,123,121
	db 120,117,116,114,112,111,109,107,105,103,102,100,99,96,95,93
	db 91,90,87,86,84,82,81,79,77,75,73,72,70,69,66,64
	db 63,61,60,57,55,54,52,51,49,52,53,55,55,53,51,50
	db 50,51,53,52,51,49,50,51
_NOTE_TABLE:
	db 4,61,13,57,9,54,8,51,10,48,14,45,5,43,14,40
	db 9,38,6,36,6,34,7,32,10,30,14,28,4,27,12,25
	db 5,24,15,22,10,21,7,20,5,19,3,18,3,17,3,16
	db 5,15,7,14,10,13,14,12,2,12,7,11,13,10,3,10
	db 10,9,2,9,9,8,2,8,10,7,4,7,13,6,7,6
	db 1,6,12,5,7,5,2,5,13,4,9,4,5,4,1,4
	db 13,3,10,3,7,3
_song0_v0__8:
	db 244,10,240,5,29,12,34,12,38,12,41,12,255,12,41,12
	db 39,12,38,12,36,36,33,12,36,24,29,24,38,12,34,12
	db 31,12,34,12,255,12,38,12,39,12,41,12,43,36,41,12
	db 39,24,34,24,29,12,34,12,38,12,41,12,255,12,41,12
	db 43,12,41,12,45,36,43,12,41,24,36,24,34,12,38,12
	db 41,12,43,12,41,12,38,12,34,12,31,12,39,48,255,24
	db 34,12,36,12,39,12,43,12,46,24,43,12,39,12,41,24
	db 41,12,45,12,48,24,45,12,41,12,36,24,38,12,41,12
	db 46,24,45,12,41,12,38,24,34,24,38,24,43,48,43,18
	db 41,18,39,12,34,24,31,24,33,18,36,18,41,12,39,24
	db 36,24,34,12,38,12,41,12,46,12,45,12,41,12,38,12
	db 41,12,46,72,255,24,0
_song0_v1__8:
	db 244,6,240,6,2,12,14,12,2,12,14,12,2,12,14,12
	db 2,12,14,12,9,12,21,12,9,12,21,12,9,12,21,12
	db 9,12,21,12,11,12,23,12,11,12,23,12,11,12,23,12
	db 11,12,23,12,7,12,19,12,7,12,19,12,7,12,19,12
	db 7,12,19,12,2,12,14,12,2,12,14,12,2,12,14,12
	db 2,12,14,12,9,12,21,12,9,12,21,12,9,12,21,12
	db 9,12,21,12,11,12,23,12,11,12,23,12,11,12,23,12
	db 11,12,23,12,7,12,19,12,7,12,19,12,7,12,19,12
	db 7,12,19,12,7,12,19,12,7,12,19,12,7,12,19,12
	db 7,12,19,12,9,12,21,12,9,12,21,12,9,12,21,12
	db 9,12,21,12,2,12,14,12,2,12,14,12,2,12,14,12
	db 2,12,14,12,11,12,23,12,11,12,23,12,11,12,23,12
	db 11,12,23,12,7,12,19,12,7,12,19,12,7,12,19,12
	db 7,12,19,12,9,12,21,12,9,12,21,12,9,12,21,12
	db 9,12,21,12,2,12,14,12,2,12,14,12,2,12,14,12
	db 2,12,14,12,2,12,14,12,2,12,14,12,2,12,14,12
	db 2,12,14,12,0
_song0_v2__8:
	db 244,6,240,8,26,6,30,6,33,6,26,6,33,6,30,6
	db 26,6,30,6,33,6,26,6,33,6,30,6,26,6,33,6
	db 30,6,26,6,33,6,37,6,40,6,33,6,40,6,37,6
	db 33,6,37,6,40,6,33,6,40,6,37,6,33,6,40,6
	db 37,6,33,6,23,6,26,6,30,6,23,6,30,6,26,6
	db 23,6,26,6,30,6,23,6,30,6,26,6,23,6,30,6
	db 26,6,23,6,31,6,35,6,38,6,31,6,38,6,35,6
	db 31,6,35,6,38,6,31,6,38,6,35,6,31,6,38,6
	db 35,6,31,6,26,6,30,6,33,6,26,6,33,6,30,6
	db 26,6,30,6,33,6,26,6,33,6,30,6,26,6,33,6
	db 30,6,26,6,33,6,37,6,40,6,33,6,40,6,37,6
	db 33,6,37,6,40,6,33,6,40,6,37,6,33,6,40,6
	db 37,6,33,6,23,6,26,6,30,6,23,6,30,6,26,6
	db 23,6,26,6,30,6,23,6,30,6,26,6,23,6,30,6
	db 26,6,23,6,31,6,35,6,38,6,31,6,38,6,35,6
	db 31,6,35,6,38,6,31,6,38,6,35,6,31,6,38,6
	db 35,6,31,6,31,6,35,6,38,6,31,6,38,6,35,6
	db 31,6,35,6,38,6,31,6,38,6,35,6,31,6,38,6
	db 35,6,31,6,33,6,37,6,40,6,33,6,40,6,37,6
	db 33,6,37,6,40,6,33,6,40,6,37,6,33,6,40,6
	db 37,6,33,6,26,6,30,6,33,6,26,6,33,6,30,6
	db 26,6,30,6,33,6,26,6,33,6,30,6,26,6,33,6
	db 30,6,26,6,23,6,26,6,30,6,23,6,30,6,26,6
	db 23,6,26,6,30,6,23,6,30,6,26,6,23,6,30,6
	db 26,6,23,6,31,6,35,6,38,6,31,6,38,6,35,6
	db 31,6,35,6,38,6,31,6,38,6,35,6,31,6,38,6
	db 35,6,31,6,33,6,37,6,40,6,33,6,40,6,37,6
	db 33,6,37,6,40,6,33,6,40,6,37,6,33,6,40,6
	db 37,6,33,6,26,6,30,6,33,6,26,6,33,6,30,6
	db 26,6,30,6,33,6,26,6,33,6,30,6,26,6,33,6
	db 30,6,26,6,26,6,30,6,33,6,26,6,33,6,30,6
	db 26,6,30,6,33,6,26,6,33,6,30,6,26,6,33,6
	db 30,6,26,6,0
_song0_v3__8:
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,3,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,3,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,3,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,3,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,3,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,3,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,3,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,3,240,7,6,6,6,6,6,12,6,6
	db 6,6,6,12,244,1,240,5,3,12,244,3,240,7,6,12
	db 6,6,6,6,6,12,244,1,240,5,3,12,244,2,240,12
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,3,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,244,2,240,12,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 3,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,244,2,240,12,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,3,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,12,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,3,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,12
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,3,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,244,2,240,12,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 3,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,244,2,240,12,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,3,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,3,240,7,6,6
	db 6,6,6,12,6,6,6,6,6,12,244,1,240,5,3,12
	db 244,3,240,7,6,12,6,6,6,6,6,12,0
_song1_v0__8:
	db 244,10,240,5,39,18,39,18,42,12,46,24,44,12,42,12
	db 42,18,39,18,35,12,39,24,42,24,37,18,37,18,42,12
	db 46,24,44,12,42,12,44,36,41,12,37,24,255,24,39,18
	db 39,18,42,12,46,24,49,12,46,12,47,18,46,18,42,12
	db 39,24,42,24,46,12,44,12,42,12,37,12,46,12,44,12
	db 42,12,37,12,41,48,44,24,41,24,39,12,42,12,47,12
	db 42,12,39,12,42,12,47,24,41,12,44,12,49,12,44,12
	db 41,12,44,12,49,24,49,18,46,18,41,12,46,24,49,24
	db 51,48,46,24,42,24,47,18,46,18,44,12,42,24,39,24
	db 41,18,42,18,44,12,37,24,41,24,42,12,41,12,39,12
	db 34,12,39,12,42,12,46,24,38,24,41,24,46,24,44,24
	db 0
_song1_v1__8:
	db 244,6,240,6,12,12,12,12,12,12,12,12,12,12,19,12
	db 24,12,12,12,8,12,8,12,8,12,8,12,8,12,15,12
	db 20,12,8,12,3,12,3,12,3,12,3,12,3,12,10,12
	db 15,12,3,12,10,12,10,12,10,12,10,12,10,12,17,12
	db 22,12,10,12,12,12,12,12,12,12,12,12,12,12,19,12
	db 24,12,12,12,8,12,8,12,8,12,8,12,8,12,15,12
	db 20,12,8,12,3,12,3,12,3,12,3,12,3,12,10,12
	db 15,12,3,12,10,12,10,12,10,12,10,12,10,12,17,12
	db 22,12,10,12,8,12,8,12,8,12,8,12,8,12,15,12
	db 20,12,8,12,10,12,10,12,10,12,10,12,10,12,17,12
	db 22,12,10,12,7,12,7,12,7,12,7,12,7,12,14,12
	db 19,12,7,12,12,12,12,12,12,12,12,12,12,12,19,12
	db 24,12,12,12,8,12,8,12,8,12,8,12,8,12,15,12
	db 20,12,8,12,10,12,10,12,10,12,10,12,10,12,17,12
	db 22,12,10,12,12,12,12,12,12,12,12,12,12,12,19,12
	db 24,12,12,12,7,12,7,12,7,12,7,12,7,12,14,12
	db 19,12,7,12,0
_song1_v2__8:
	db 244,6,240,8,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,34,6
	db 30,6,27,6,23,6,27,6,30,6,23,6,30,6,27,6
	db 23,6,27,6,30,6,23,6,30,6,27,6,23,6,30,6
	db 27,6,23,6,18,6,22,6,25,6,18,6,25,6,22,6
	db 18,6,22,6,25,6,18,6,25,6,22,6,18,6,25,6
	db 22,6,18,6,25,6,29,6,32,6,25,6,32,6,29,6
	db 25,6,29,6,32,6,25,6,32,6,29,6,25,6,32,6
	db 29,6,25,6,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,34,6
	db 30,6,27,6,23,6,27,6,30,6,23,6,30,6,27,6
	db 23,6,27,6,30,6,23,6,30,6,27,6,23,6,30,6
	db 27,6,23,6,18,6,22,6,25,6,18,6,25,6,22,6
	db 18,6,22,6,25,6,18,6,25,6,22,6,18,6,25,6
	db 22,6,18,6,25,6,29,6,32,6,25,6,32,6,29,6
	db 25,6,29,6,32,6,25,6,32,6,29,6,25,6,32,6
	db 29,6,25,6,23,6,27,6,30,6,23,6,30,6,27,6
	db 23,6,27,6,30,6,23,6,30,6,27,6,23,6,30,6
	db 27,6,23,6,25,6,29,6,32,6,25,6,32,6,29,6
	db 25,6,29,6,32,6,25,6,32,6,29,6,25,6,32,6
	db 29,6,25,6,22,6,25,6,29,6,22,6,29,6,25,6
	db 22,6,25,6,29,6,22,6,29,6,25,6,22,6,29,6
	db 25,6,22,6,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,34,6
	db 30,6,27,6,23,6,27,6,30,6,23,6,30,6,27,6
	db 23,6,27,6,30,6,23,6,30,6,27,6,23,6,30,6
	db 27,6,23,6,25,6,29,6,32,6,25,6,32,6,29,6
	db 25,6,29,6,32,6,25,6,32,6,29,6,25,6,32,6
	db 29,6,25,6,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,34,6
	db 30,6,27,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,29,6
	db 26,6,22,6,0
_song1_v3__8:
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,3,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,3,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,3,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,3,240,7,6,6,6,6,6,12,6,6
	db 6,6,6,12,244,1,240,5,3,12,244,3,240,7,6,12
	db 6,6,6,6,6,12,244,1,240,5,3,12,244,2,240,12
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,3,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,244,2,240,12,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 3,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,244,2,240,12,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,3,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,3,240,7,6,6
	db 6,6,6,12,6,6,6,6,6,12,244,1,240,5,3,12
	db 244,3,240,7,6,12,6,6,6,6,6,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,3,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,3,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,3,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,3,240,7,6,6,6,6,6,12,6,6,6,6,6,12
	db 244,1,240,5,3,12,244,3,240,7,6,12,6,6,6,6
	db 6,12,244,1,240,5,3,12,244,2,240,12,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 3,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,244,2,240,12,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,3,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,12,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,3,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,3,240,7,6,6,6,6,6,12
	db 6,6,6,6,6,12,244,1,240,5,3,12,244,3,240,7
	db 6,12,6,6,6,6,6,12,0
_song2_v0__8:
	db 244,10,240,5,32,12,37,12,41,12,44,24,41,12,44,24
	db 42,12,39,12,36,12,39,24,32,12,36,24,41,12,37,12
	db 34,12,37,24,41,12,46,24,46,36,44,12,42,24,37,24
	db 32,12,37,12,41,12,44,24,46,12,44,24,48,36,46,12
	db 44,24,39,24,49,12,48,12,46,12,41,12,37,12,41,12
	db 46,24,44,48,255,24,44,12,44,12,46,18,46,18,44,12
	db 42,24,37,24,48,18,48,18,46,12,44,24,39,24,49,24
	db 44,24,41,24,37,24,46,36,44,12,41,24,37,24,42,12
	db 46,12,49,12,46,12,42,12,46,12,49,24,44,12,48,12
	db 51,12,48,12,44,12,48,12,51,24,49,18,48,18,46,12
	db 44,24,41,24,37,12,41,12,44,12,49,12,255,48,0
_song2_v1__8:
	db 244,6,240,6,8,12,8,6,8,6,15,12,8,6,8,6
	db 20,12,8,6,8,6,15,12,8,12,3,12,3,6,3,6
	db 10,12,3,6,3,6,15,12,3,6,3,6,10,12,3,12
	db 5,12,5,6,5,6,12,12,5,6,5,6,17,12,5,6
	db 5,6,12,12,5,12,1,12,1,6,1,6,8,12,1,6
	db 1,6,13,12,1,6,1,6,8,12,1,12,8,12,8,6
	db 8,6,15,12,8,6,8,6,20,12,8,6,8,6,15,12
	db 8,12,3,12,3,6,3,6,10,12,3,6,3,6,15,12
	db 3,6,3,6,10,12,3,12,5,12,5,6,5,6,12,12
	db 5,6,5,6,17,12,5,6,5,6,12,12,5,12,1,12
	db 1,6,1,6,8,12,1,6,1,6,13,12,1,6,1,6
	db 8,12,1,12,1,12,1,6,1,6,8,12,1,6,1,6
	db 13,12,1,6,1,6,8,12,1,12,3,12,3,6,3,6
	db 10,12,3,6,3,6,15,12,3,6,3,6,10,12,3,12
	db 8,12,8,6,8,6,15,12,8,6,8,6,20,12,8,6
	db 8,6,15,12,8,12,5,12,5,6,5,6,12,12,5,6
	db 5,6,17,12,5,6,5,6,12,12,5,12,1,12,1,6
	db 1,6,8,12,1,6,1,6,13,12,1,6,1,6,8,12
	db 1,12,3,12,3,6,3,6,10,12,3,6,3,6,15,12
	db 3,6,3,6,10,12,3,12,8,12,8,6,8,6,15,12
	db 8,6,8,6,20,12,8,6,8,6,15,12,8,12,8,12
	db 8,6,8,6,15,12,8,6,8,6,20,12,8,6,8,6
	db 15,12,8,12,0
_song2_v2__8:
	db 244,6,240,8,27,6,31,6,34,6,27,6,34,6,31,6
	db 27,6,31,6,34,6,27,6,34,6,31,6,27,6,34,6
	db 31,6,27,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,29,6
	db 26,6,22,6,24,6,27,6,31,6,24,6,31,6,27,6
	db 24,6,27,6,31,6,24,6,31,6,27,6,24,6,31,6
	db 27,6,24,6,20,6,24,6,27,6,20,6,27,6,24,6
	db 20,6,24,6,27,6,20,6,27,6,24,6,20,6,27,6
	db 24,6,20,6,27,6,31,6,34,6,27,6,34,6,31,6
	db 27,6,31,6,34,6,27,6,34,6,31,6,27,6,34,6
	db 31,6,27,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,29,6
	db 26,6,22,6,24,6,27,6,31,6,24,6,31,6,27,6
	db 24,6,27,6,31,6,24,6,31,6,27,6,24,6,31,6
	db 27,6,24,6,20,6,24,6,27,6,20,6,27,6,24,6
	db 20,6,24,6,27,6,20,6,27,6,24,6,20,6,27,6
	db 24,6,20,6,20,6,24,6,27,6,20,6,27,6,24,6
	db 20,6,24,6,27,6,20,6,27,6,24,6,20,6,27,6
	db 24,6,20,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,29,6
	db 26,6,22,6,27,6,31,6,34,6,27,6,34,6,31,6
	db 27,6,31,6,34,6,27,6,34,6,31,6,27,6,34,6
	db 31,6,27,6,24,6,27,6,31,6,24,6,31,6,27,6
	db 24,6,27,6,31,6,24,6,31,6,27,6,24,6,31,6
	db 27,6,24,6,20,6,24,6,27,6,20,6,27,6,24,6
	db 20,6,24,6,27,6,20,6,27,6,24,6,20,6,27,6
	db 24,6,20,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,29,6
	db 26,6,22,6,27,6,31,6,34,6,27,6,34,6,31,6
	db 27,6,31,6,34,6,27,6,34,6,31,6,27,6,34,6
	db 31,6,27,6,27,6,31,6,34,6,27,6,34,6,31,6
	db 27,6,31,6,34,6,27,6,34,6,31,6,27,6,34,6
	db 31,6,27,6,0
_song2_v3__8:
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,6,244,1,240,5,3,6,244,3,240,7,6,12
	db 244,2,240,11,5,12,244,1,240,5,3,12,244,2,240,12
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,244,2,240,12,5,6,244,1,240,5,3,6
	db 244,3,240,7,6,12,244,2,240,11,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,6
	db 244,1,240,5,3,6,244,3,240,7,6,12,244,2,240,11
	db 5,12,244,1,240,5,3,12,244,2,240,12,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,12,5,6,244,1,240,5,3,6,244,3,240,7
	db 6,12,244,2,240,11,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,6,244,1,240,5
	db 3,6,244,3,240,7,6,12,244,2,240,11,5,12,244,1
	db 240,5,3,12,244,2,240,12,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,12
	db 5,6,244,1,240,5,3,6,244,3,240,7,6,12,244,2
	db 240,11,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,6,244,1,240,5,3,6,244,3
	db 240,7,6,12,244,2,240,11,5,12,244,3,240,7,6,6
	db 6,6,6,12,6,6,6,6,6,12,244,1,240,5,3,12
	db 244,3,240,7,6,12,6,6,6,6,6,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,6
	db 244,1,240,5,3,6,244,3,240,7,6,12,244,2,240,11
	db 5,12,244,1,240,5,3,12,244,2,240,12,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,12,5,6,244,1,240,5,3,6,244,3,240,7
	db 6,12,244,2,240,11,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,6,244,1,240,5
	db 3,6,244,3,240,7,6,12,244,2,240,11,5,12,244,1
	db 240,5,3,12,244,2,240,12,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,12
	db 5,6,244,1,240,5,3,6,244,3,240,7,6,12,244,2
	db 240,11,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,6,244,1,240,5,3,6,244,3
	db 240,7,6,12,244,2,240,11,5,12,244,1,240,5,3,12
	db 244,2,240,12,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,244,2,240,12,5,6,244,1
	db 240,5,3,6,244,3,240,7,6,12,244,2,240,11,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,6,244,1,240,5,3,6,244,3,240,7,6,12
	db 244,2,240,11,5,12,244,3,240,7,6,6,6,6,6,12
	db 6,6,6,6,6,12,244,1,240,5,3,12,244,3,240,7
	db 6,12,6,6,6,6,6,12,0
_song3_v0__8:
	db 255,240,0
_song3_v1__8:
	db 255,240,0
_song3_v2__8:
	db 255,240,0
_song3_v3__8:
	db 255,240,0
_song4_v0__8:
	db 244,10,240,4,37,14,42,14,46,28,44,14,42,14,37,28
	db 39,14,42,14,47,28,46,14,42,14,39,28,41,14,44,14
	db 49,28,47,14,44,14,41,28,42,56,37,28,42,28,46,14
	db 42,14,39,28,42,14,46,14,51,28,47,14,46,14,44,14
	db 42,14,39,28,42,28,44,14,41,14,37,14,41,14,44,28
	db 47,28,46,56,42,56,0
_song4_v1__8:
	db 244,6,240,6,6,14,18,14,6,14,18,14,6,14,18,14
	db 6,14,18,14,11,14,23,14,11,14,23,14,11,14,23,14
	db 11,14,23,14,1,14,13,14,1,14,13,14,1,14,13,14
	db 1,14,13,14,6,14,18,14,6,14,18,14,6,14,18,14
	db 6,14,18,14,3,14,15,14,3,14,15,14,3,14,15,14
	db 3,14,15,14,11,14,23,14,11,14,23,14,11,14,23,14
	db 11,14,23,14,1,14,13,14,1,14,13,14,1,14,13,14
	db 1,14,13,14,6,14,18,14,6,14,18,14,6,14,18,14
	db 6,14,18,14,0
_song4_v2__8:
	db 244,6,240,8,18,7,22,7,25,7,18,7,25,7,22,7
	db 18,7,22,7,25,7,18,7,25,7,22,7,18,7,25,7
	db 22,7,18,7,23,7,27,7,30,7,23,7,30,7,27,7
	db 23,7,27,7,30,7,23,7,30,7,27,7,23,7,30,7
	db 27,7,23,7,25,7,29,7,32,7,25,7,32,7,29,7
	db 25,7,29,7,32,7,25,7,32,7,29,7,25,7,32,7
	db 29,7,25,7,18,7,22,7,25,7,18,7,25,7,22,7
	db 18,7,22,7,25,7,18,7,25,7,22,7,18,7,25,7
	db 22,7,18,7,27,7,30,7,34,7,27,7,34,7,30,7
	db 27,7,30,7,34,7,27,7,34,7,30,7,27,7,34,7
	db 30,7,27,7,23,7,27,7,30,7,23,7,30,7,27,7
	db 23,7,27,7,30,7,23,7,30,7,27,7,23,7,30,7
	db 27,7,23,7,25,7,29,7,32,7,25,7,32,7,29,7
	db 25,7,29,7,32,7,25,7,32,7,29,7,25,7,32,7
	db 29,7,25,7,18,7,22,7,25,7,18,7,25,7,22,7
	db 18,7,22,7,25,7,18,7,25,7,22,7,18,7,25,7
	db 22,7,18,7,0
_song4_v3__8:
	db 244,1,240,5,3,14,244,2,240,12,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,3,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,12,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,3,14,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,244,2
	db 240,12,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,3,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,12,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,3,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,244,2,240,12,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,3,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,12,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,3,14,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,244,2
	db 240,12,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,3,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,3,240,7,6,7,6,7,6,14,6,7
	db 6,7,6,14,244,1,240,5,3,14,244,3,240,7,6,14
	db 6,7,6,7,6,14,0
_song5_v0__8:
	db 244,10,240,4,34,32,33,32,32,32,31,32,30,128,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,240,0
_song5_v1__8:
	db 244,6,240,6,3,128,3,128,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,240,255,240
	db 0
_song5_v2__8:
	db 244,13,240,8,18,128,15,128,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,240,255,240
	db 0
_song5_v3__8:
	db 244,1,240,5,3,128,255,128,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,240,255,240
	db 0
	align 2
_music_songs:
	dd _song0_v0__8
	dd _song0_v1__8
	dd _song0_v2__8
	dd _song0_v3__8
	db 1,0
	dd _song1_v0__8
	dd _song1_v1__8
	dd _song1_v2__8
	dd _song1_v3__8
	db 1,0
	dd _song2_v0__8
	dd _song2_v1__8
	dd _song2_v2__8
	dd _song2_v3__8
	db 1,0
	dd _song3_v0__8
	dd _song3_v1__8
	dd _song3_v2__8
	dd _song3_v3__8
	db 1,0
	dd _song4_v0__8
	dd _song4_v1__8
	dd _song4_v2__8
	dd _song4_v3__8
	db 1,0
	dd _song5_v0__8
	dd _song5_v1__8
	dd _song5_v2__8
	dd _song5_v3__8
	db 0,0
_z80drv__9:
	db 195,19,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,243,49,0,16,58,3,0,183,40,250,71,33,4
	db 0,126,50,1,64,50,0,64,35,126,50,1,64,50,0,64
	db 35,126,50,1,64,50,0,64,35,16,230,175,50,3,0,24
	db 214
_inst_tab__9:
	db 6,4,1,15,1,15,2,15,7,3,5,3,2,9,6,4
	db 3,8,2,12,8,3,8,3,5,5,3,6,5,5,2,12
	db 2,12,6,4
	align 2
_b_edge__10:
	db 49,1,68,4,18,1,16,4
	align 2
_b_band__10:
	db 179,3,255,15,45,2,82,14
	align 2
_b_text__10:
	db 255,15,46,2,255,15,255,15
	align 2
_b_shad__10:
	db 0,0,6,0,0,0,0,0
	align 2
_overrev_dash_tiles__13:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 192,3,192,3,192,3,192,3,192,3,0,0,192,3,0,0
	db 60,15,60,15,48,12,0,0,0,0,0,0,0,0,0,0
	db 48,12,252,63,48,12,48,12,252,63,48,12,0,0,0,0
	db 192,3,252,15,192,51,240,15,204,3,240,63,192,3,0,0
	db 12,60,48,60,192,0,0,3,0,12,60,12,60,48,0,0
	db 192,15,240,60,192,15,12,63,240,60,60,60,204,15,0,0
	db 192,3,192,3,0,3,0,0,0,0,0,0,0,0,0,0
	db 240,0,192,3,0,15,0,15,0,15,192,3,240,0,0,0
	db 0,15,192,3,240,0,240,0,240,0,192,3,0,15,0,0
	db 0,0,12,48,48,12,252,63,48,12,12,48,0,0,0,0
	db 0,0,192,3,192,3,252,63,192,3,192,3,0,0,0,0
	db 0,0,0,0,0,0,0,0,192,3,192,3,0,3,0,0
	db 0,0,0,0,0,0,252,63,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,192,3,192,3,0,0
	db 12,0,60,0,240,0,192,3,0,15,0,60,0,48,0,0
	db 240,15,60,60,252,60,60,63,60,60,60,60,240,15,0,0
	db 192,3,192,15,192,3,192,3,192,3,192,3,240,15,0,0
	db 240,15,60,60,60,0,240,3,0,15,0,60,252,63,0,0
	db 240,63,60,0,60,0,240,15,60,0,60,0,240,63,0,0
	db 240,0,240,3,240,15,240,60,252,63,240,0,240,0,0,0
	db 252,63,0,60,0,60,240,63,60,0,60,0,240,63,0,0
	db 240,15,0,60,0,60,240,63,60,60,60,60,240,15,0,0
	db 252,63,60,0,240,0,192,3,0,15,0,15,0,15,0,0
	db 240,15,60,60,60,60,240,15,60,60,60,60,240,15,0,0
	db 240,15,60,60,60,60,252,15,60,0,60,0,240,15,0,0
	db 0,0,192,3,192,3,0,0,192,3,192,3,0,0,0,0
	db 0,0,192,3,192,3,0,0,192,3,192,3,0,3,0,0
	db 60,0,240,0,192,3,0,15,192,3,240,0,60,0,0,0
	db 0,0,0,0,252,63,0,0,252,63,0,0,0,0,0,0
	db 0,60,0,15,192,3,240,0,192,3,0,15,0,60,0,0
	db 240,15,60,60,60,0,240,0,192,3,0,0,192,3,0,0
	db 240,15,12,48,204,51,60,51,240,51,0,48,252,15,0,0
	db 240,15,60,60,60,60,252,63,60,60,60,60,60,60,0,0
	db 240,63,60,60,60,60,240,63,60,60,60,60,240,63,0,0
	db 252,15,0,60,0,60,0,60,0,60,0,60,252,15,0,0
	db 192,63,240,60,60,60,60,60,60,60,240,60,192,63,0,0
	db 252,63,0,60,0,60,240,63,0,60,0,60,252,63,0,0
	db 252,63,0,60,0,60,240,63,0,60,0,60,0,60,0,0
	db 252,15,0,60,0,60,252,60,60,60,60,60,240,15,0,0
	db 60,60,60,60,60,60,252,63,60,60,60,60,60,60,0,0
	db 240,15,192,3,192,3,192,3,192,3,192,3,240,15,0,0
	db 252,0,60,0,60,0,60,0,60,60,60,60,240,15,0,0
	db 60,60,240,60,192,63,0,63,192,63,240,60,60,60,0,0
	db 0,60,0,60,0,60,0,60,0,60,0,60,252,63,0,0
	db 60,60,252,63,252,63,60,60,60,60,60,60,60,60,0,0
	db 60,60,60,63,60,63,252,60,252,60,60,60,60,60,0,0
	db 240,15,60,60,60,60,60,60,60,60,60,60,240,15,0,0
	db 240,63,60,60,60,60,240,63,0,60,0,60,0,60,0,0
	db 240,15,60,60,60,60,60,60,252,60,240,60,204,15,0,0
	db 240,63,60,60,60,60,240,63,192,63,240,60,60,60,0,0
	db 252,15,0,60,0,60,240,15,60,0,60,0,240,63,0,0
	db 252,63,192,3,192,3,192,3,192,3,192,3,192,3,0,0
	db 60,60,60,60,60,60,60,60,60,60,60,60,240,15,0,0
	db 60,60,60,60,60,60,60,60,48,12,240,15,192,3,0,0
	db 60,60,60,60,60,60,60,60,252,63,252,63,48,12,0,0
	db 60,60,60,60,240,15,192,3,240,15,60,60,60,60,0,0
	db 60,60,60,60,240,15,192,3,192,3,192,3,192,3,0,0
	db 252,63,60,0,240,0,192,3,0,15,0,60,252,63,0,0
	db 240,15,0,15,0,15,0,15,0,15,0,15,240,15,0,0
	db 0,48,0,60,0,15,192,3,240,0,60,0,12,0,0,0
	db 240,15,240,0,240,0,240,0,240,0,240,0,240,15,0,0
	db 192,3,240,15,60,60,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,252,63,0,0
	db 0,15,192,3,192,0,0,0,0,0,0,0,0,0,0,0
	db 0,15,0,0,240,15,60,60,252,63,60,60,60,60,0,0
	db 240,0,0,0,240,15,60,60,252,63,60,60,60,60,0,0
	db 192,3,48,12,240,15,60,60,252,63,60,60,60,60,0,0
	db 12,15,240,48,240,15,60,60,252,63,60,60,60,60,0,0
	db 48,12,0,0,240,15,60,60,252,63,60,60,60,60,0,0
	db 252,15,0,60,0,60,0,60,252,15,192,0,192,3,0,0
	db 0,15,0,0,252,63,0,60,240,63,0,60,252,63,0,0
	db 240,0,0,0,252,63,0,60,240,63,0,60,252,63,0,0
	db 192,3,48,12,252,63,0,60,240,63,0,60,252,63,0,0
	db 48,12,0,0,252,63,0,60,240,63,0,60,252,63,0,0
	db 240,0,0,0,240,15,192,3,192,3,192,3,240,15,0,0
	db 192,3,48,12,240,15,192,3,192,3,192,3,240,15,0,0
	db 48,12,0,0,240,15,192,3,192,3,192,3,240,15,0,0
	db 12,15,240,48,60,60,60,63,252,60,60,60,60,60,0,0
	db 240,0,0,0,240,15,60,60,60,60,60,60,240,15,0,0
	db 192,3,48,12,240,15,60,60,60,60,60,60,240,15,0,0
	db 12,15,240,48,240,15,60,60,60,60,60,60,240,15,0,0
	db 48,12,0,0,240,15,60,60,60,60,60,60,240,15,0,0
	db 0,15,0,0,60,60,60,60,60,60,60,60,240,15,0,0
	db 240,0,0,0,60,60,60,60,60,60,60,60,240,15,0,0
	db 192,3,48,12,60,60,60,60,60,60,60,60,240,15,0,0
	db 48,12,0,0,60,60,60,60,60,60,60,60,240,15,0,0
	db 192,15,240,60,240,60,192,63,240,60,60,60,240,60,0,0
	db 192,3,0,0,192,3,0,15,0,60,60,60,240,15,0,0
	db 192,3,0,0,192,3,192,3,192,3,192,3,192,3,0,0
	db 252,15,192,60,192,60,252,60,192,60,192,60,252,15,0,0
	db 252,0,192,3,192,3,0,15,192,3,192,3,252,0,0,0
	db 192,3,192,3,192,3,192,3,192,3,192,3,192,3,0,0
	db 0,63,192,3,192,3,240,0,192,3,192,3,0,63,0,0
	db 0,0,0,0,12,15,240,48,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	align 2
_easy_bends__16:
	db 20,0,26,0,32,0,40,0,46,0
	align 2
_sharp_bends__16:
	db 56,0,62,0,70,0
	align 2
_sp_sharp__16:
	db 94,1,144,1,244,1
	align 2
_sp_s__16:
	db 44,1,94,1,144,1
	align 2
_sp_gap__16:
	db 0,0,100,0,150,0
	align 2
_sp_straight__16:
	db 144,1,244,1,88,2,32,3
	align 2
_sp_bend__16:
	db 144,1,244,1,88,2,188,2,32,3
_slopes__16:
	db 0,255,1,0,254,2
_S17_0:
	db 65,85,84,79,66,65,72,78,32,65,67,69,0
_S17_1:
	db 84,79,80,32,83,80,69,69,68,44,32,84,79,80,32,82
	db 65,78,75,33,0
_S17_2:
	db 67,65,78,89,79,78,32,67,79,78,81,85,69,82,79,82
	db 0
_S17_3:
	db 78,79,84,72,73,78,71,32,83,84,79,80,83,32,89,79
	db 85,33,0
_S17_4:
	db 76,65,75,69,83,73,68,69,32,68,82,69,65,77,0
_S17_5:
	db 65,32,80,69,82,70,69,67,84,32,83,85,78,83,69,84
	db 32,82,85,78,0
_S17_6:
	db 83,69,65,83,73,68,69,32,80,65,82,84,89,0
_S17_7:
	db 84,72,69,32,84,79,87,78,32,67,72,69,69,82,83,32
	db 89,79,85,33,0
_S17_8:
	db 76,69,71,69,78,68,32,79,70,32,84,72,69,32,82,85
	db 73,78,0
_S17_9:
	db 84,72,69,32,65,78,67,73,69,78,84,32,67,85,80,33
	db 0
_S17_10:
	db 74,79,85,82,78,69,89,32,67,79,77,80,76,69,84,69
	db 0
_S17_11:
	db 65,32,82,79,65,68,32,78,79,66,79,68,89,32,75,78
	db 69,87,0
	align 2
_endings__17:
	dd _S17_0
	dd _S17_1
	db 68,4,170,10,255,15,2,0
	dd _S17_2
	dd _S17_3
	db 36,0,123,3,207,8,1,0
	dd _S17_4
	dd _S17_5
	db 66,9,199,15,254,15,3,0
	dd _S17_6
	dd _S17_7
	db 70,0,189,2,255,9,4,0
	dd _S17_8
	dd _S17_9
	db 4,1,61,3,175,10,1,0
	dd _S17_10
	dd _S17_11
	db 85,0,207,0,255,10,1,0
_dir_x__17:
	db 16,11,0,245,240,245,0,11
_dir_y__17:
	db 0,245,240,245,0,11,16,11
_pals__17_L2066:
	db 1,2,9,10
	align 2
_gfx_font_tiles__24:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 208,3,208,3,208,3,208,3,208,3,80,1,208,3,80,1
	db 125,15,125,15,117,13,20,5,0,0,0,0,0,0,0,0
	db 52,13,253,63,117,29,52,13,253,63,117,29,20,5,0,0
	db 208,3,253,15,213,55,244,31,221,7,245,63,212,23,80,1
	db 13,61,53,61,212,21,80,3,64,13,61,13,61,53,21,20
	db 208,15,244,61,212,31,93,63,245,61,125,61,221,31,85,5
	db 208,3,208,3,80,3,64,1,0,0,0,0,0,0,0,0
	db 244,0,212,3,80,15,64,15,64,15,208,7,244,1,84,0
	db 64,15,208,7,244,1,244,0,244,0,212,3,80,15,64,5
	db 0,0,13,52,53,29,253,63,117,29,29,53,5,20,0,0
	db 0,0,208,3,208,3,253,63,213,23,208,3,80,1,0,0
	db 0,0,0,0,0,0,0,0,208,3,208,3,80,3,64,1
	db 0,0,0,0,0,0,253,63,85,21,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,208,3,208,3,80,1
	db 13,0,61,0,245,0,212,3,80,15,64,61,0,53,0,20
	db 244,15,125,61,253,61,125,63,125,61,61,61,245,31,84,5
	db 208,3,208,15,208,7,208,3,208,3,208,3,244,15,84,5
	db 244,15,125,61,61,21,245,3,84,15,64,61,253,63,85,21
	db 244,63,125,21,61,0,245,15,125,5,61,0,245,63,84,21
	db 244,0,244,3,244,15,244,61,253,63,245,21,244,0,84,0
	db 253,63,85,61,0,61,244,63,125,21,61,0,245,63,84,21
	db 244,15,84,61,0,61,244,63,125,61,61,61,245,31,84,5
	db 253,63,125,21,245,0,212,3,80,15,64,15,64,15,64,5
	db 244,15,125,61,61,61,245,31,125,61,61,61,245,31,84,5
	db 244,15,125,61,61,61,253,31,125,5,61,0,245,15,84,5
	db 0,0,208,3,208,3,80,1,208,3,208,3,80,1,0,0
	db 0,0,208,3,208,3,80,1,208,3,208,3,80,3,64,1
	db 61,0,245,0,212,3,80,15,208,7,244,1,125,0,21,0
	db 0,0,0,0,253,63,85,21,253,63,85,21,0,0,0,0
	db 0,61,64,31,208,7,244,1,212,3,80,15,64,61,0,21
	db 244,15,125,61,61,21,245,0,212,3,80,1,208,3,80,1
	db 244,15,93,53,221,55,125,55,245,55,84,53,253,31,85,5
	db 244,15,125,61,61,61,253,63,125,61,61,61,61,61,21,21
	db 244,63,125,61,61,61,245,63,125,61,61,61,245,63,84,21
	db 253,15,85,61,0,61,0,61,0,61,0,61,253,31,85,5
	db 208,63,244,61,125,61,61,61,61,61,245,61,212,63,80,21
	db 253,63,85,61,0,61,244,63,84,61,0,61,253,63,85,21
	db 253,63,85,61,0,61,244,63,84,61,0,61,0,61,0,21
	db 253,15,85,61,0,61,253,61,125,61,61,61,245,31,84,5
	db 61,61,61,61,61,61,253,63,125,61,61,61,61,61,21,21
	db 244,15,212,7,208,3,208,3,208,3,208,3,244,15,84,5
	db 253,0,125,0,61,0,61,0,61,61,61,61,245,31,84,5
	db 61,61,245,61,212,63,80,63,208,63,244,61,125,61,21,21
	db 0,61,0,61,0,61,0,61,0,61,0,61,253,63,85,21
	db 61,61,253,63,253,63,125,61,61,61,61,61,61,61,21,21
	db 61,61,125,63,125,63,253,61,253,61,125,61,61,61,21,21
	db 244,15,125,61,61,61,61,61,61,61,61,61,245,31,84,5
	db 244,63,125,61,61,61,245,63,84,61,0,61,0,61,0,21
	db 244,15,125,61,61,61,61,61,253,61,245,61,221,31,85,5
	db 244,63,125,61,61,61,245,63,212,63,244,61,125,61,21,21
	db 253,15,85,61,0,61,244,31,125,5,61,0,245,63,84,21
	db 253,63,213,23,208,3,208,3,208,3,208,3,208,3,80,1
	db 61,61,61,61,61,61,61,61,61,61,61,61,245,31,84,5
	db 61,61,61,61,61,61,61,61,53,29,244,15,212,7,80,1
	db 61,61,61,61,61,61,61,61,253,63,253,63,117,29,20,5
	db 61,61,61,61,245,31,212,7,244,15,125,61,61,61,21,21
	db 61,61,61,61,245,31,212,7,208,3,208,3,208,3,80,1
	db 253,63,125,21,245,0,212,3,80,15,64,61,253,63,85,21
	db 244,15,84,15,64,15,64,15,64,15,64,15,244,15,84,5
	db 0,52,0,61,64,31,208,7,244,1,125,0,29,0,5,0
	db 244,15,244,5,244,0,244,0,244,0,244,0,244,15,84,5
	db 208,3,244,15,125,61,21,21,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,253,63,85,21
	db 0,0,85,85,1,64,1,64,1,64,1,64,85,85,0,0
	db 0,0,85,85,253,127,253,127,253,127,253,127,85,85,0,0
	db 0,3,0,15,255,63,255,255,255,63,0,15,0,3,0,0
	db 192,0,240,0,252,255,255,255,252,255,240,0,192,0,0,0
	db 204,204,51,51,204,204,51,51,0,192,0,192,0,192,0,192
_S24_0:
	db 84,73,77,69,0
_S24_1:
	db 83,84,65,71,69,0
_S24_2:
	db 75,77,47,72,0
_S24_3:
	db 72,73,71,72,0
_S24_4:
	db 32,76,79,87,0
_hill_rate__28:
	db 64,65,67,69,71,73,75,77,80,82,85,88,91,94,98,102
	db 106,111,116,121,128,134,140,147,153,160,166,172,179,185,192,198
	db 204,211,217,224,230,236,243,249,255
	align 2
_course_sol__28:
	db 82,0,51,3,85,5,255,15,255,255,51,3,51,3,102,6
	db 153,9
_course_horizon__28:
	db 0
_band_lut__28:
	db 3,2,1,1,2,3,3,3,3,2,1,0,0,0,0,1
	db 2,3,3,3,3,3,3,3,3,2,1,0,0,0,0,0
	db 0,0,1,2,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,2,1,1,2,3,3,3,3,3,2,1,0,0,0,0
	db 1,2,3,3,3,3,3,3,3,3,2,1,0,0,0,0
	db 0,0,0,0,1,2,3,3,3,3,3,3,3,3,3,3
	db 3,3,2,1,1,2,3,3,3,3,3,2,1,0,0,0
	db 0,1,2,3,3,3,3,3,3,3,3,2,1,0,0,0
	db 0,0,0,0,0,1,2,3,3,3,3,3,3,3,3,3
	db 3,3,2,1,0,1,2,3,3,3,3,3,2,1,0,0
	db 0,0,1,2,3,3,3,3,3,3,3,3,2,1,0,0
	db 0,0,0,0,0,0,1,2,3,3,3,3,3,3,3,3
	db 0,3,3,2,1,0,1,2,3,3,3,3,3,2,1,0
	db 0,0,0,1,2,3,3,3,3,3,3,3,3,3,2,1
	db 0,0,0,0,0,0,0,0,1,2,3,3,3,3,3,3
	db 0,3,3,2,1,0,1,2,3,3,3,3,3,2,1,0
	db 0,0,0,0,1,2,3,3,3,3,3,3,3,3,3,2
	db 1,0,0,0,0,0,0,0,0,0,1,2,3,3,3,3
	db 0,3,3,2,1,0,0,1,2,3,3,3,3,3,2,1
	db 0,0,0,0,0,1,2,3,3,3,3,3,3,3,3,3
	db 2,1,0,0,0,0,0,0,0,0,0,1,2,3,3,3
	db 0,3,3,2,1,0,0,1,2,3,3,3,3,3,3,2
	db 1,0,0,0,0,0,1,2,3,3,3,3,3,3,3,3
	db 3,2,1,0,0,0,0,0,0,0,0,0,0,1,2,3
	db 1,2,3,3,2,1,0,0,1,2,3,3,3,3,3,3
	db 2,1,0,0,0,0,0,0,1,2,3,3,3,3,3,3
	db 3,3,3,2,1,0,0,0,0,0,0,0,0,0,0,0
	db 1,2,3,3,2,1,0,0,0,1,2,3,3,3,3,3
	db 3,2,1,0,0,0,0,0,0,1,2,3,3,3,3,3
	db 3,3,3,3,3,2,1,0,0,0,0,0,0,0,0,0
	db 0,1,2,3,3,2,1,0,0,0,1,2,3,3,3,3
	db 3,3,2,1,0,0,0,0,0,0,1,2,3,3,3,3
	db 3,3,3,3,3,3,2,1,0,0,0,0,0,0,0,0
	db 0,1,2,3,3,3,2,1,0,0,0,1,2,3,3,3
	db 3,3,3,2,1,0,0,0,0,0,0,1,2,3,3,3
	db 3,3,3,3,3,3,3,2,1,0,0,0,0,0,0,0
	db 3,0,1,2,3,3,3,2,1,0,0,0,1,2,3,3
	db 3,3,3,3,2,1,0,0,0,0,0,0,0,1,2,3
	db 3,3,3,3,3,3,3,3,3,2,1,0,0,0,0,0
	db 3,0,1,2,3,3,3,2,1,0,0,0,1,2,3,3
	db 3,3,3,3,3,2,1,0,0,0,0,0,0,0,1,2
	db 3,3,3,3,3,3,3,3,3,3,3,2,1,0,0,0
	db 3,0,1,2,3,3,3,3,2,1,0,0,0,1,2,3
	db 3,3,3,3,3,3,2,1,0,0,0,0,0,0,0,1
	db 2,3,3,3,3,3,3,3,3,3,3,3,2,1,0,0
	db 3,0,1,2,3,3,3,3,2,1,0,0,0,0,1,2
	db 3,3,3,3,3,3,3,2,1,0,0,0,0,0,0,0
	db 1,2,3,3,3,3,3,3,3,3,3,3,3,3,2,1
	align 2
__DataROM_START:
	db 46,92,119,159,224,2,0,6,80,130,0,0,0,0
	db 64,66,15,0,64,66,15,0,64,66,15,0,64,66,15,0
	db 15
	db 255
	db 255
	db 0
	db 0
	db 0
	db 0
	db 0
	db 15
	db 4
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	dd _buf__16
	db 237,94
	db 23,90
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 24
	db 0
	db 255,127
	db 6
	db 6
	db 250
	db 72
	db 40
	db 72,72
	db 72
	db 72
	db 111
	db 40
	db 7
	dd _id_xy_a__28
	dd _id_xy_b__28
	dd _id_bandcol_a__28
	db 2
	db 0
	db 255,255,255,255
	db 43,29
	db 6
__DataROM_END:
__Bss_START equ 04000h
__Bss_END equ 056AAh
__DataRAM_START equ 056AAh
__RAM_END equ 0570Bh
_road_edge__0 equ 04000h
_lat_limit__0 equ 04002h
_speed__0 equ 04004h
_gear__0 equ 04005h
_slip__0 equ 04006h
_on_throttle__0 equ 04007h
_steer_hold__0 equ 04008h
_offroad__0 equ 04009h
_racing__0 equ 0400Ah
_finished__0 equ 0400Bh
_speed_acc__0 equ 0400Ch
_seg_pos__0 equ 0400Eh
_course_pos__0 equ 04010h
_recovery_frames__0 equ 04012h
_hill_acc__0 equ 04014h
_car_lat__0 equ 04016h
_bend_now__0 equ 04018h
_heading_acc__0 equ 0401Ah
_recovery_lat__0 equ 0401Ch
_car_lean__0 equ 0401Eh
_seg_index__0 equ 0401Fh
_recovery_vblank__0 equ 04020h
_oil_hold__0 equ 04021h
_skid__0 equ 04022h
_skid_t__0 equ 04023h
_road_bend__0 equ 04024h
_track_frac__0 equ 040A4h
_clock_prev__0 equ 040A6h
_pace_prev__0 equ 040A7h
_paused__0 equ 040A8h
_cnt_timer__0 equ 040A9h
_state__0 equ 040AAh
_state_timer__0 equ 040ABh
_sec_acc__0 equ 040ACh
_time_left__0 equ 040ADh
_score__0 equ 040AEh
_crash_timer__0 equ 040B2h
_msg_timer__0 equ 040B3h
_flash_step__0 equ 040B4h
_station__0 equ 040B5h
_last_fork_zone__0 equ 040B6h
_goal_reached__0 equ 040B7h
_title_frames__0 equ 040B8h
_pano_tiles_at__0 equ 040BAh
_trf_tiles_at__0 equ 040BCh
_dbg_updates equ 040BEh
_dbg_cp equ 040C0h
_dbg_crashes equ 040C6h
_dbg_scn equ 040C7h
_dbg_off equ 040C8h
_grade_tab__0 equ 040C9h
_save_buf__0 equ 040D6h
_save_dirty__0 equ 041D6h
_smoke_t__0 equ 041D7h
_eng_phase__0 equ 041D8h
_voice__9 equ 041DAh
_playing__9 equ 04222h
_last_vbl__9 equ 04223h
_want_div__9 equ 04224h
_want_attn__9 equ 0422Ch
_sent_div__9 equ 04230h
_sent_attn__9 equ 04238h
_noise_trig__9 equ 0423Ch
_sfx_frames__9 equ 0423Dh
_sfx_div__9 equ 04242h
_sfx_step__9 equ 0424Ah
_sfx_attn__9 equ 0424Eh
_sfx_decay__9 equ 04252h
_sfx_age__9 equ 04256h
_eng_div__9 equ 0425Ah
_eng_on__9 equ 0425Ch
_b_on__10 equ 0425Dh
_b_r0__10 equ 0425Eh
_b_r1__10 equ 0425Fh
_b_c0__10 equ 04260h
_b_c1__10 equ 04261h
_b_foot__10 equ 04262h
_b_spr__10 equ 04263h
_car_d__10 equ 04264h
_s_offset__11 equ 04266h
_s_sequence__11 equ 0426Ah
_s_repeat_timer__12 equ 0426Eh
_g_vb_hook__13 equ 04276h
_s_cmd_type__15 equ 0427Ah
_s_cmd_dst__15 equ 0428Ah
_s_cmd_len__15 equ 042AAh
_s_cmd_src__15 equ 042CAh
_s_cmd_fill__15 equ 0430Ah
_s_cmd_count__15 equ 0432Ah
_s_drop_count__15 equ 0432Bh
_s_lock__15 equ 0432Ch
_buf__16 equ 0432Eh
_track_len equ 044DEh
_cur_stage equ 044DFh
_cur_branch equ 044E0h
_cur_leg equ 044E1h
_leg_len equ 044E2h
_fork_choice equ 044E4h
_route_hist equ 044E5h
_difficulty equ 044EAh
_leg_theme equ 044EBh
_next_leg_cost equ 044FAh
_n_cur__16 equ 044FCh
_n_next__16 equ 044FDh
_rs__16 equ 044FEh
_gp__16 equ 04500h
_gn__16 equ 04504h
_px__17 equ 04506h
_py__17 equ 04522h
_vx__17 equ 0453Eh
_vy__17 equ 0455Ah
_life__17 equ 04576h
_ptile__17 equ 04584h
_ppal__17 equ 04592h
_fx__17 equ 045A0h
_timer__17 equ 045A1h
_s_done_cb__18 equ 045A2h
_s_done_flag__18 equ 045B2h
_s_was_active__18 equ 045B6h
_s_rearm_enabled__18 equ 045BAh
_s_rearm_elem__18 equ 045BEh
_s_rearm_vector__18 equ 045C2h
_s_rearm_count__18 equ 045C6h
_s_rearm_dst__18 equ 045CEh
_s_rearm_src__18 equ 045DEh
_h_score__24 equ 045EEh
_h_score_ok__24 equ 045F5h
_s_dig__24 equ 045F6h
_body__27 equ 045FEh
_car_variant__27 equ 0461Eh
_car_wheel_dx__27 equ 0461Fh
_car_tile_base__27 equ 04620h
_lean_hold__27 equ 04622h
_lean_side__27 equ 04623h
_lean_wait__27 equ 04624h
_bump_phase__27 equ 04625h
_car_last_x__27 equ 04626h
_car_last_top__27 equ 04628h
_art__28 equ 0462Ah
_road_course__28 equ 04642h
_road_grade__28 equ 04643h
_band_pitch__28 equ 04644h
_climb_room__28 equ 04646h
_descent_room__28 equ 04647h
_band_shift__28 equ 04648h
_id_xy_a__28 equ 0464Ah
_id_xy_b__28 equ 0477Ch
_id_xy_done__28 equ 048AEh
_id_xy_last__28 equ 048B2h
_id_raster__28 equ 048B6h
_id_shear__28 equ 048CAh
_id_sl__28 equ 0494Ah
_id_bandcol_a__28 equ 04A0Ah
_id_bandcol_b__28 equ 04B3Ch
_bc_top__28 equ 04C6Eh
_id_bandcol_done__28 equ 04C70h
_id_bandstream__28 equ 04C74h
_band_phase__28 equ 04C82h
_id_dxc__28 equ 04C84h
_id_w_lat__28 equ 04D84h
_id_w_curve__28 equ 04DC4h
_id_half__28 equ 04E04h
_id_src__28 equ 04E44h
_band_top__28 equ 04E84h
_band_mid__28 equ 04E88h
_band_tree__28 equ 04E8Ch
_band_bg_first__28 equ 04E90h
_id_buf__28 equ 04E92h
_pan_head__28 equ 04E94h
_pan_lat__28 equ 04E96h
_pan_fine__28 equ 04E98h
_band_held__28 equ 04E99h
_band_wait__28 equ 04E9Ah
_id_ahead__28 equ 04E9Ch
_id_curve_cm__28 equ 04F1Ch
_wide_k0__28 equ 04F1Eh
_rally_of__28 equ 04F1Fh
_rally_src__28 equ 05120h
_rally_used__28 equ 0531Eh
_rally_scanned__28 equ 0531Fh
_band_col__28 equ 05320h
_road_dma_live__28 equ 05328h
_road_dma_depth__28 equ 05329h
_id_curve_dx__28 equ 0532Ah
_scn_phase__29 equ 053AAh
_scn_frac__29 equ 053ACh
_scn_passed__29 equ 053AEh
_scn_mode__29 equ 053AFh
_pano_base__30 equ 053B0h
_obj_base__30 equ 053B2h
_obj_end__30 equ 053B4h
_pano_end__30 equ 053B6h
_objmap__30 equ 053B8h
_kind_l__30 equ 055B8h
_kind_r__30 equ 055B9h
_cur_pals__30 equ 055BAh
_cur_backdrop__30 equ 055FAh
_cur_road__30 equ 055FCh
_cur_band__30 equ 05604h
_cur_spr__30 equ 0560Ch
_next_slot__30 equ 0563Ch
_cars__31 equ 0563Eh
_trf_tiles__31 equ 056A0h
_car_d__31 equ 056A2h
_half_wheel__31 equ 056A4h
_dens_min__31 equ 056A5h
_dens_max__31 equ 056A6h
_target__31 equ 056A7h
_cooldown__31 equ 056A8h
_hard__31 equ 056A9h
_car_tuned__0 equ 056AAh
_hiscore__0 equ 056B8h
_eng_attn__9 equ 056C8h
_s_current__11 equ 056C9h
_s_last_slot__11 equ 056CAh
_ngpc_pad_held equ 056CBh
_ngpc_pad_pressed equ 056CCh
_ngpc_pad_released equ 056CDh
_ngpc_pad_repeat equ 056CEh
_s_pad_prev__12 equ 056CFh
_s_repeat_delay__12 equ 056D0h
_s_repeat_rate__12 equ 056D1h
_s_vbl_down__12 equ 056D2h
_s_vbl_prev__12 equ 056D3h
_g_vb_counter equ 056D4h
_s_is_color__13 equ 056D5h
_s_language__13 equ 056D6h
_s_power_hold__14_L1730 equ 056D7h
_track_seg equ 056D8h
_free_seed equ 056DCh
_seed__17 equ 056DEh
_cur_song__20 equ 056E0h
_h_time__24 equ 056E1h
_h_kmh__24 equ 056E2h
_h_gear__24 equ 056E3h
_h_prog__24 equ 056E4h
_h_stage__24 equ 056E5h
_id_spr_priority equ 056E6h
_car_at_x__27 equ 056E8h
_car_stand__28 equ 056EAh
_grade_hi__28 equ 056EBh
_grade_lo__28 equ 056ECh
_band_first__28 equ 056EDh
_band_count__28 equ 056EEh
_band_bg_end__28 equ 056EFh
_road_top__28 equ 056F1h
_road_plane0__28 equ 056F2h
_road_bottom__28 equ 056F3h
_road_lines__28 equ 056F4h
_road_base_x__28 equ 056F5h
_id_xy__28 equ 056F6h
_id_xy_live__28 equ 056FAh
_id_bandcol__28 equ 056FEh
_road_band_pal__28 equ 05702h
_bc_rest__28 equ 05704h
_rng__31 equ 05708h
_trf_cap__31 equ 0570Ah

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
	jr nz,L292
	ld wa,1
	jr L293
L292:
	ld wa,0
L293:
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
	ld wa,1
	push xwa
	call _theme_crowd_colours
	lda xsp,(xsp+4)
	call _balloons_reset__0
	call _bridge_setup
	call _leg_time__0
	ld (_time_left__0),a
	ld xwa,0
	ld (_score__0),xwa
	call _hud_score_reset
	ldb (_sec_acc__0),0
	ldb (_crash_timer__0),0
	ldw (_knock_v__0),0
	ldb (_knock_t__0),0
	ld a,0
	ld (_was_offroad__0),a
	ld (_verge_spd__0),a
	ld a,(_roll_t__0)
	cp a,0
	jr z,L294
	ldb (_roll_t__0),0
	ldb (_roll_loaded__0),255
	call _id_car_restore
L294:
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
L291:
	ret

; function advance
_advance__0:
	push xiz
	lda xsp,(xsp-10)
	ld c,(_speed__0)
	cp c,16
	jr uge,L308
	ld a,(_speed__0)
	extz wa
	mul xwa,3502
	srl 4,wa
	jr L309
L308:
	ld wa,3502
L309:
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
	jr nz,L310
	ld wa,(_track_frac__0)
	ld iy,wa
L310:
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
	jr L313
L311:
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
	jr ult,L314
	ldb (_seg_index__0),0
L314:
L313:
	ld wa,(_seg_pos__0)
	ld xbc,(_track_seg)
	ld e,(_seg_index__0)
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr uge,L311
L312:
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
	jr ge,L315
	incw 6,(_bend_now__0)
	jr L316
L315:
	ld wa,(_bend_now__0)
	ld bc,(xsp+8)
	add bc,6
	cp wa,bc
	jr le,L317
	decw 6,(_bend_now__0)
	jr L318
L317:
	ld wa,(xsp+8)
	ld (_bend_now__0),wa
L318:
L316:
	ld wa,ix
	jr L307
L307:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function frame_commit
_frame_commit__0:
	jr L326
L324:
	call _ngpc_vsync
L326:
	ld a,(_g_vb_counter)
	sub a,(_frame_vb__0)
	cp a,1
	jr ult,L324
L325:
	call _ovl_commit
	call _id_road_ready
	ldb (_spr_ready),1
L323:
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
L328:
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
	jr z,L333
	ld xwa,(xsp+4)
	push xwa
	ld wa,5
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L333:
	ld xwa,(xsp+8)
	cp xwa,0
	jr z,L334
	ld xwa,(xsp+8)
	push xwa
	ld wa,7
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L334:
	ld a,(xsp+12)
	ld (_msg_timer__0),a
	call _banner_dirty
L332:
	ret

; function count_message
_count_message__0:
	ld wa,12
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld xwa,(xsp+4)
	cp xwa,0
	jr z,L338
	ld xwa,(xsp+4)
	push xwa
	ld wa,12
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L338:
	ld a,(xsp+8)
	ld (_cnt_timer__0),a
L337:
	ret

; function tick_message
_tick_message__0:
	ld a,(_msg_timer__0)
	cp a,0
	jr z,L345
	decb 1,(_msg_timer__0)
	ld a,(_msg_timer__0)
	cp a,0
	jr nz,L346
	ld wa,5
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld wa,7
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	call _banner_dirty
L346:
L345:
	ld a,(_cnt_timer__0)
	cp a,0
	jr z,L347
	decb 1,(_cnt_timer__0)
	ld a,(_cnt_timer__0)
	cp a,0
	jr nz,L348
	ld wa,12
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
L348:
L347:
L344:
	ret

; function leg_end
_leg_end__0:
	lda xsp,(xsp-4)
	call _course_is_last_stage
	cp a,0
	jr z,L354
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
	ld xwa,_S0_9
	push xwa
	ld xwa,_S0_10
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
	jp L353
L354:
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
	call _bridge_setup
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
	jr ule,L355
	ld wa,99
	jr L356
L355:
	ld wa,(xsp+2)
L356:
	ld (_time_left__0),a
	ldb (_flash_step__0),1
	ld wa,75
	push xwa
	ld xwa,_S0_11
	push xwa
	ld xwa,_S0_12
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
L353:
	lda xsp,(xsp+4)
	ret

; function tick_flash
_tick_flash__0:
	ld a,(_flash_step__0)
	cp a,0
	jr nz,L364
	jr L362
L364:
	ld a,(_flash_step__0)
	cp a,5
	jr nz,L365
	ld a,(_cur_leg)
	push xwa
	call _theme_apply
	lda xsp,(xsp+4)
	call _stage_traffic__0
L365:
	ld xwa,_lv__0_L363
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
	jr ule,L366
	ldb (_flash_step__0),0
L366:
L362:
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
L368:
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
	jr L380
L377:
	ld xwa,xix
	ld c,izl
	extz bc
	sll 3,bc
	cp c,0
	jr z,L382
L381:
	srl 1,xwa
	djnz c,L381
L382:
	ld xbc,_save_buf__0
	ld e,iyl
	add e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L379:
	inc 1,izl
L380:
	ld a,izl
	cp a,4
	jr ult,L377
L378:
L376:
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
	jr L384
L384:
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
	jr nz,L396
	jp L395
L396:
	push xix
	ld xwa,_save_buf__0
	push xwa
	call _ngpc_flash_load
	lda xsp,(xsp+4)
	pop xix
	ld a,(_save_buf__0+4)
	cp a,1
	jr z,L397
	jp L395
L397:
	ld a,(_save_buf__0+5)
	cp a,5
	jr uge,L398
	ld a,(_save_buf__0+5)
	ld (_station__0),a
L398:
	ld a,(_save_buf__0+6)
	cp a,4
	jr uge,L399
	ld a,(_save_buf__0+6)
	ld (_difficulty),a
L399:
	ld izl,0
	jr L403
L400:
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
	jr z,L404
	ld xwa,xix
	cp xwa,10000000
	jr uge,L404
	ld xwa,xix
	ld xbc,_hiscore__0
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L404:
L402:
	inc 1,izl
L403:
	ld a,izl
	cp a,4
	jr ult,L400
L401:
	ld a,(_save_buf__0+24)
	extz wa
	ld c,(_save_buf__0+25)
	extz bc
	sll 8,bc
	or wa,bc
	ld (_free_seed),wa
L395:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function save_commit
_save_commit__0:
	push xiz
	lda xsp,(xsp-4)
	ld a,(_save_dirty__0)
	cp a,0
	jr nz,L417
	jp L416
L417:
	ld ix,0
	jr L421
L418:
	ld a,0
	ld xbc,_save_buf__0
	ld de,ix
	extz xde
	add xbc,xde
	ld (xbc),a
L420:
	inc 1,ix
L421:
	ld wa,ix
	cp wa,256
	jr ult,L418
L419:
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
	jr L425
L422:
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
L424:
	inc 1,izl
L425:
	ld a,izl
	cp a,4
	jr ult,L422
L423:
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
	jr z,L426
	ldb (_save_dirty__0),0
L426:
L416:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function title_slot
_title_slot__0:
	push xiz
	ld iz,(xsp+8)
	ld wa,iz
	cp wa,111
	jr uge,L432
	ld wa,(_pano_tiles_at__0)
	add wa,iz
	jr L431
L432:
	ld wa,iz
	sub wa,111
	ld iz,wa
	ld wa,iz
	cp wa,(_gfx_traffic_tiles_count)
	jr uge,L433
	ld wa,(_trf_tiles_at__0)
	add wa,iz
	jr L431
L433:
	ld wa,iz
	sub wa,(_gfx_traffic_tiles_count)
	ld iz,wa
	ld wa,iz
	cp wa,30
	jr uge,L434
	ld wa,2
	add wa,iz
	jr L431
L434:
	ld wa,iz
	sub wa,30
	ld iz,wa
	ld wa,101
	add wa,iz
	jr L431
L431:
	pop xiz
	ret

; function title_option
_title_option__0:
	push xiz
	lda xsp,(xsp-2)
	ld wa,0
	ld izl,a
	jr L443
L441:
	inc 1,izl
L443:
	ld xwa,(xsp+14)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L444
	ld a,izl
	cp a,16
	jr ult,L441
L444:
L442:
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
L440:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function hex4
_hex4__0:
	push xiz
	lda xsp,(xsp-2)
	ld xiy,(xsp+10)
	ld izl,0
	jr L458
L455:
	ld wa,(xsp+14)
	ld bc,12
	ld e,izl
	extz de
	sll 2,de
	sub bc,de
	cp c,0
	jr z,L460
L459:
	srl 1,wa
	djnz c,L459
L460:
	and wa,15
	ld ixl,a
	ld c,ixl
	cp c,10
	jr uge,L461
	ld wa,48
	ld c,ixl
	extz bc
	add wa,bc
	jr L462
L461:
	ld wa,65
	ld c,ixl
	extz bc
	add wa,bc
	sub wa,10
L462:
	ld xbc,xiy
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L457:
	inc 1,izl
L458:
	ld a,izl
	cp a,4
	jr ult,L455
L456:
	ldb (xiy+4),0
L454:
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
	ld xwa,_S0_13
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
	jr nz,L466
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
	ld xwa,_S0_14
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
L466:
L465:
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
	jr z,L471
	ld wa,(xsp+0)
	jr L472
L471:
	ld wa,24301
L472:
	ld (_free_seed),wa
L470:
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
	call _ovl_forget
	pop xix
	push xix
	call _bridge_hide
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
	jr L518
L515:
	ld wa,0
	ld xbc,38912
	ld de,(xsp+2)
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L517:
	incw 1,(xsp+2)
L518:
	ld wa,(xsp+2)
	cp wa,1024
	jr ult,L515
L516:
	push xix
	ld wa,2642
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
	pop xix
	ldw (xsp+0),0
	jr L522
L519:
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
	jr L526
L523:
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
L525:
	incb 1,(xsp+14)
L526:
	ld a,(xsp+14)
	cp a,8
	jr ult,L523
L524:
L521:
	incw 1,(xsp+0)
L522:
	ld wa,(xsp+0)
	cp wa,210
	jr ult,L519
L520:
	ldw (xsp+0),0
	jr L530
L527:
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
L529:
	incw 1,(xsp+0)
L530:
	ld wa,(xsp+0)
	cp wa,13
	jr ult,L527
L528:
	ldw (xsp+0),0
	jr L534
L531:
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
L533:
	incw 1,(xsp+0)
L534:
	ld wa,(xsp+0)
	cp wa,8
	jr ult,L531
L532:
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
	jp L538
L535:
	ld izl,0
	jp L542
L539:
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
L544:
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
L541:
	inc 1,izl
L542:
	ld a,izl
	cp a,18
	jp ult,L539
L540:
L537:
	inc 1,ixl
L538:
	ld a,ixl
	cp a,11
	jp ult,L535
L536:
	ld ixl,0
	jp L548
L545:
	ld izl,0
	jp L552
L549:
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
	jr nz,L553
	ld wa,0
	jr L554
L553:
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
L554:
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
L551:
	inc 1,izl
L552:
	ld a,izl
	cp a,20
	jp ult,L549
L550:
L547:
	inc 1,ixl
L548:
	ld a,ixl
	cp a,11
	jp ult,L545
L546:
	push xix
	call _title_texts__0
	pop xix
L514:
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
	jr L564
L561:
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
L563:
	inc 1,iz
L564:
	ld wa,iz
	ld bc,(_gfx_traffic_tiles_count)
	sll 3,bc
	cp wa,bc
	jr ult,L561
L562:
	call _id_road_dma_resume
L560:
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
	jp L588
L585:
	ld wa,24
	ld c,ixl
	extz bc
	sll 1,bc
	add wa,bc
	ld (xsp+6),a
	ld c,ixl
	cp c,0
	jr nz,L589
	ld wa,(xsp+2)
	sub wa,13
	ld c,(xsp+5)
	extz bc
	sub wa,bc
	jr L590
L589:
	ld wa,(xsp+2)
	add wa,29
	ld c,(xsp+5)
	extz bc
	add wa,bc
L590:
	ld (xsp+8),wa
	ld izl,0
	jp L594
L591:
	ld c,ixl
	cp c,0
	jr z,L596
	ld a,1
	sub a,izl
	extz wa
	jr L597
L596:
	ld a,izl
	extz wa
L597:
	ld (xsp+11),a
L598:
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
	ld xwa,_tsm__0_L595
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
	jr z,L601
	ld wa,128
	jr L602
L601:
	ld wa,0
L602:
	ld (xsp+19),a
	ld xwa,_spr_shadow
	ld c,(xsp+12)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
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
	ld xbc,_spr_pal_shadow
	ld e,(xsp+12)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L600:
L599:
L593:
	inc 1,izl
L594:
	ld a,izl
	cp a,2
	jp ult,L591
L592:
L587:
	inc 1,ixl
L588:
	ld a,ixl
	cp a,2
	jp ult,L585
L586:
L584:
	lda xsp,(xsp+24)
	pop xiz
	ret

; function title_blink
_title_blink__0:
	ld a,(xsp+4)
	extz wa
	and wa,31
	cp wa,0
	jr nz,L608
	ld xwa,_S0_15
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
	jr L609
L608:
	ld a,(xsp+4)
	extz wa
	and wa,31
	cp wa,20
	jr nz,L610
	ld a,(xsp+8)
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
L610:
L609:
L607:
	ret

; function map_leg_xy
_map_leg_xy__0:
	ld wa,6
	ld c,(xsp+4)
	extz bc
	mul xbc,30
	add wa,bc
	ld xbc,(xsp+12)
	ld (xbc),a
	ld wa,86
	ld c,(xsp+8)
	extz bc
	sll 1,bc
	ld e,(xsp+4)
	extz de
	sub bc,de
	mul xbc,24
	exts xbc
	divs xbc,2
	add wa,bc
	ld xbc,(xsp+16)
	ld (xbc),a
L612:
	ret

; function map_screen
_map_screen__0:
	push xiz
	lda xsp,(xsp-26)
	call _id_road_dma_pause
	call _ovl_forget
	call _bridge_hide
	call _banner_hide
	ld wa,64
	push xwa
	ld wa,0
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	call _hud_clear_top
	ld wa,18
	push xwa
	ld wa,15
	push xwa
	call _clear_hud_rows__0
	lda xsp,(xsp+8)
	call _player_engine_off
	ldb (08034h),0
	ldb (08035h),0
	ld iz,0
	jr L670
L667:
	ld wa,0
	ld xbc,38912
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L669:
	inc 1,iz
L670:
	ld wa,iz
	cp wa,1024
	jr ult,L667
L668:
	ld wa,1710
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
	ldw (xsp+0),0
	jr L674
L671:
	ld wa,40960
	extz xwa
	push xwa
	ld wa,(xsp+4)
	push xwa
	call _title_slot__0
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	mul xbc,16
	add xwa,xbc
	ld (xsp+8),xwa
	ld xwa,_gfx_map_tiles
	ld bc,(xsp+0)
	sll 3,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+12),xwa
	ldb (xsp+16),0
	jr L678
L675:
	ld xwa,(xsp+12)
	ld c,(xsp+16)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(xsp+8)
	ld e,(xsp+16)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L677:
	incb 1,(xsp+16)
L678:
	ld a,(xsp+16)
	cp a,8
	jr ult,L675
L676:
L673:
	incw 1,(xsp+0)
L674:
	ld wa,(xsp+0)
	cp wa,171
	jr ult,L671
L672:
	ldw (xsp+0),0
	jr L682
L679:
	ld xwa,_gfx_map_pals
	ld bc,(xsp+0)
	sll 2,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+8),xwa
	ld xwa,(xsp+8)
	ld wa,(xwa+6)
	push xwa
	ld xwa,(xsp+12)
	ld wa,(xwa+4)
	push xwa
	ld xwa,(xsp+16)
	ld wa,(xwa+2)
	push xwa
	ld wa,0
	push xwa
	ld a,8
	add a,(xsp+16)
	push xwa
	ld wa,1
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
L681:
	incw 1,(xsp+0)
L682:
	ld wa,(xsp+0)
	cp wa,8
	jr ult,L679
L680:
	ldb (xsp+5),0
	jp L686
L683:
	ldb (xsp+4),0
	jp L690
L687:
	ld xwa,_gfx_map_map
	ld c,(xsp+5)
	extz bc
	mul xbc,20
	ld e,(xsp+4)
	extz de
	add bc,de
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+8),wa
	ld bc,(xsp+8)
	cp bc,65535
	jr nz,L691
	ld wa,0
	jr L692
L691:
	ld wa,(xsp+8)
	push xwa
	call _title_slot__0
	lda xsp,(xsp+4)
	ld bc,8
	ld xde,_gfx_map_pal
	ld l,(xsp+5)
	extz hl
	mul xhl,20
	push xde
	ld e,(xsp+8)
	extz de
	add hl,de
	pop xde
	extz xhl
	add xde,xhl
	ld e,(xde)
	extz de
	add bc,de
	sll 9,bc
	or wa,bc
L692:
	ld xbc,38912
	ld e,(xsp+5)
	extz de
	sll 5,de
	ld l,(xsp+4)
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L689:
	incb 1,(xsp+4)
L690:
	ld a,(xsp+4)
	cp a,20
	jp ult,L687
L688:
L685:
	incb 1,(xsp+5)
L686:
	ld a,(xsp+5)
	cp a,19
	jp ult,L683
L684:
	ld xwa,_S0_16
	push xwa
	ld wa,1
	push xwa
	ld wa,8
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	ld iz,0
	ldb (xsp+6),0
	jp L696
L693:
	ldb (xsp+7),0
	jp L700
L697:
	ld xwa,_leg_theme
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+8),a
	ld xwa,_gfx_map_thumb_pals
	ld c,(xsp+8)
	extz bc
	sll 2,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+10),xwa
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
	ld a,izl
	add a,1
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	lda xwa,(xsp+5)
	push xwa
	lda xwa,(xsp+8)
	push xwa
	ld a,(xsp+15)
	push xwa
	ld a,(xsp+18)
	push xwa
	call _map_leg_xy__0
	lda xsp,(xsp+16)
	ldb (xsp+14),0
	jp L704
L701:
L705:
	ld wa,2
	ld bc,iz
	sll 2,bc
	add wa,bc
	ld c,(xsp+14)
	extz bc
	add wa,bc
	ld (xsp+15),a
	ld a,(xsp+4)
	extz wa
	ld c,(xsp+14)
	extz bc
	and bc,1
	sll 3,bc
	add wa,bc
	ld (xsp+16),a
	ld a,(xsp+5)
	extz wa
	sub wa,8
	ld c,(xsp+14)
	extz bc
	sra 1,bc
	sll 3,bc
	add wa,bc
	ld (xsp+17),a
	ld wa,109
	ld c,(xsp+8)
	extz bc
	sll 2,bc
	add wa,bc
	ld c,(xsp+14)
	extz bc
	add wa,bc
	push xwa
	call _title_slot__0
	lda xsp,(xsp+4)
	ld (xsp+18),wa
	ld a,izl
	add a,1
	ld (xsp+20),a
	ld a,0
	ld (xsp+21),a
	ld xwa,_spr_shadow
	ld c,(xsp+15)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
	ld (xsp+22),xwa
	ld a,(xsp+18)
	and a,255
	ld xbc,(xsp+22)
	ld (xbc),a
	ld a,(xsp+21)
	extz wa
	or wa,24
	ld bc,(xsp+18)
	srl 8,bc
	and bc,1
	extz bc
	or wa,bc
	ld xbc,(xsp+22)
	ld (xbc+1),a
	ld a,(xsp+16)
	ld xbc,(xsp+22)
	ld (xbc+2),a
	ld a,(xsp+17)
	ld xbc,(xsp+22)
	ld (xbc+3),a
	ld a,(xsp+20)
	and a,15
	ld xbc,_spr_pal_shadow
	ld e,(xsp+15)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L707:
L706:
L703:
	incb 1,(xsp+14)
L704:
	ld a,(xsp+14)
	cp a,4
	jp ult,L701
L702:
	inc 1,iz
L699:
	incb 1,(xsp+7)
L700:
	ld a,(xsp+7)
	cp a,(xsp+6)
	jp ule,L697
L698:
L695:
	incb 1,(xsp+6)
L696:
	ld a,(xsp+6)
	cp a,5
	jp ult,L693
L694:
	ld wa,(_gfx_map_car_pal+6)
	push xwa
	ld wa,(_gfx_map_car_pal+4)
	push xwa
	ld wa,(_gfx_map_car_pal+2)
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ldb (_map_n__0),0
	lda xwa,(xsp+5)
	push xwa
	lda xwa,(xsp+8)
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	call _map_leg_xy__0
	lda xsp,(xsp+16)
	ld a,0
	ld xbc,_map_px__0
	ld e,(_map_n__0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+5)
	ld xbc,_map_py__0
	ld e,(_map_n__0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	incb 1,(_map_n__0)
	ldb (xsp+6),0
	jp L711
L708:
	lda xwa,(xsp+5)
	push xwa
	lda xwa,(xsp+8)
	push xwa
	ld xwa,_route_hist
	ld c,(xsp+14)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld a,(xsp+18)
	push xwa
	call _map_leg_xy__0
	lda xsp,(xsp+16)
	ld a,(xsp+4)
	ld xbc,_map_px__0
	ld e,(_map_n__0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+5)
	ld xbc,_map_py__0
	ld e,(_map_n__0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	incb 1,(_map_n__0)
	ld a,(xsp+6)
	cp a,(_cur_stage)
	jr ult,L713
	ld a,(_goal_reached__0)
	cp a,0
	jr z,L712
L713:
	ld a,(xsp+4)
	add a,16
	ld xbc,_map_px__0
	ld e,(_map_n__0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+5)
	ld xbc,_map_py__0
	ld e,(_map_n__0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	incb 1,(_map_n__0)
	jr L714
L712:
	ld wa,(_course_pos__0)
	mul xwa,16
	push xwa
	ld bc,(_leg_len)
	cp bc,0
	jr z,L715
	ld wa,(_leg_len)
	jr L716
L715:
	ld wa,1
L716:
	extz xwa
	ld xbc,xwa
	pop xwa
	call __div32u
	ld (xsp+8),wa
	ld wa,(xsp+8)
	cp wa,16
	jr ule,L717
	ldw (xsp+8),16
L717:
	ld a,(xsp+4)
	add a,(xsp+8)
	ld xbc,_map_px__0
	ld e,(_map_n__0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+5)
	ld xbc,_map_py__0
	ld e,(_map_n__0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	incb 1,(_map_n__0)
L714:
L710:
	incb 1,(xsp+6)
L711:
	ld a,(xsp+6)
	cp a,(_cur_stage)
	jp ule,L708
L709:
	ld a,(_goal_reached__0)
	cp a,0
	jr z,L718
	ld xwa,_map_px__0
	ld c,(_map_n__0)
	extz bc
	sub bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	add a,6
	ld xbc,_map_px__0
	ld e,(_map_n__0)
	extz de
	sub de,1
	extz xde
	add xbc,xde
	ld (xbc),a
L718:
	ldb (_map_seg__0),0
	ldw (_map_along__0),0
	ldw (_map_t__0),0
	ldw (_map_done__0),0
L666:
	lda xsp,(xsp+26)
	pop xiz
	ret

; function map_car
_map_car__0:
	push xiz
	lda xsp,(xsp-14)
	ld xwa,_map_px__0
	ld c,(_map_seg__0)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+0),a
	ld xwa,_map_py__0
	ld c,(_map_seg__0)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+1),a
	ld a,(_map_seg__0)
	extz wa
	add wa,1
	ld c,(_map_n__0)
	extz bc
	cp wa,bc
	jp uge,L740
	ld xwa,_map_px__0
	ld c,(_map_seg__0)
	extz bc
	add bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	ld c,(xsp+0)
	extz bc
	sub wa,bc
	ld (xsp+2),wa
	ld xwa,_map_py__0
	ld c,(_map_seg__0)
	extz bc
	add bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	ld c,(xsp+1)
	extz bc
	sub wa,bc
	ld (xsp+4),wa
	ld bc,(xsp+2)
	cp bc,0
	jr le,L741
	ld wa,(xsp+2)
	jr L742
L741:
	ld wa,(xsp+2)
	neg wa
L742:
	ld (xsp+6),wa
	ld bc,(xsp+4)
	cp bc,0
	jr le,L744
	ld wa,(xsp+4)
	jr L745
L744:
	ld wa,(xsp+4)
	neg wa
L745:
	cp wa,(xsp+6)
	jr le,L743
	ld bc,(xsp+4)
	cp bc,0
	jr le,L746
	ld wa,(xsp+4)
	jr L747
L746:
	ld wa,(xsp+4)
	neg wa
L747:
	ld (xsp+6),wa
L743:
	ld wa,(xsp+6)
	cp wa,0
	jr nz,L748
	ldw (xsp+6),1
L748:
	ld wa,(_map_along__0)
	cp wa,(xsp+6)
	jr lt,L749
	ldw (_map_along__0),0
	incb 1,(_map_seg__0)
	ld xwa,_map_px__0
	ld c,(_map_seg__0)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+0),a
	ld xwa,_map_py__0
	ld c,(_map_seg__0)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+1),a
	jr L750
L749:
	ld a,(xsp+0)
	extz wa
	ld bc,(xsp+2)
	ld de,(_map_along__0)
	mul xbc,de
	exts xbc
	divs xbc,(xsp+6)
	add wa,bc
	ld (xsp+0),a
	ld a,(xsp+1)
	extz wa
	ld bc,(xsp+4)
	ld de,(_map_along__0)
	mul xbc,de
	exts xbc
	divs xbc,(xsp+6)
	add wa,bc
	ld (xsp+1),a
L750:
	jr L751
L740:
	ld wa,(_map_done__0)
	cp wa,0
	jr nz,L752
	ld wa,(_map_t__0)
	ld (_map_done__0),wa
	ld wa,2
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L752:
L751:
L753:
	ld a,0
	ld (xsp+2),a
	ld a,(xsp+0)
	sub a,8
	ld (xsp+3),a
	ld a,(xsp+1)
	sub a,4
	ld (xsp+4),a
	ld wa,169
	push xwa
	call _title_slot__0
	lda xsp,(xsp+4)
	ld (xsp+6),wa
	ld a,0
	ld (xsp+8),a
	ld a,0
	ld (xsp+9),a
	ld xwa,_spr_shadow
	ld c,(xsp+2)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
	ld (xsp+10),xwa
	ld a,(xsp+6)
	and a,255
	ld xbc,(xsp+10)
	ld (xbc),a
	ld a,(xsp+9)
	extz wa
	or wa,24
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
	ld xbc,_spr_pal_shadow
	ld e,(xsp+2)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L755:
L754:
L756:
	ld a,1
	ld (xsp+2),a
	ld a,(xsp+0)
	ld (xsp+3),a
	ld a,(xsp+1)
	sub a,4
	ld (xsp+4),a
	ld wa,170
	push xwa
	call _title_slot__0
	lda xsp,(xsp+4)
	ld (xsp+6),wa
	ld a,0
	ld (xsp+8),a
	ld a,0
	ld (xsp+9),a
	ld xwa,_spr_shadow
	ld c,(xsp+2)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
	ld xiz,xwa
	ld a,(xsp+6)
	and a,255
	ld (xiz),a
	ld a,(xsp+9)
	extz wa
	or wa,24
	ld bc,(xsp+6)
	srl 8,bc
	and bc,1
	extz bc
	or wa,bc
	ld (xiz+1),a
	ld a,(xsp+3)
	ld (xiz+2),a
	ld a,(xsp+4)
	ld (xiz+3),a
	ld a,(xsp+8)
	and a,15
	ld xbc,_spr_pal_shadow
	ld e,(xsp+2)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L758:
L757:
L739:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function map_leave
_map_leave__0:
	ld wa,64
	push xwa
	ld wa,0
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	call _hud_clear_top
	call _id_road_reload_maps
	ld a,(_cur_leg)
	push xwa
	call _theme_apply
	lda xsp,(xsp+4)
	ld wa,(_trf_tiles_at__0)
	push xwa
	call _traffic_init
	lda xsp,(xsp+4)
	call _id_car_restore
	call _smoke_init__0
	ld a,(_difficulty)
	push xwa
	call _banner_style
	lda xsp,(xsp+4)
	call _id_road_dma_resume
L760:
	ret

; function trophy_load
_trophy_load__0:
	push xiz
	lda xsp,(xsp-2)
	ld iz,0
	jr L770
L767:
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
L769:
	inc 1,iz
L770:
	ld wa,iz
	cp wa,48
	jr ult,L767
L768:
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
L766:
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
	jr nz,L782
	ld wa,1
	jr L783
L782:
	ld wa,0
L783:
	ld (xsp+1),a
	ld ixl,0
	jp L787
L784:
	ld xwa,_gfx_trophy_cells
	ld c,ixl
	extz bc
	mul xbc,3
	extz xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+2),xwa
L788:
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
	ld xwa,_spr_shadow
	ld c,(xsp+6)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
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
	ld xbc,_spr_pal_shadow
	ld e,(xsp+6)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L790:
L789:
L786:
	inc 1,ixl
L787:
	ld a,ixl
	cp a,6
	jp ult,L784
L785:
L781:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function result_screen
_result_screen__0:
	push xiz
	lda xsp,(xsp-20)
	call _bridge_hide
	call _hud_clear_top
	ld wa,18
	push xwa
	ld wa,15
	push xwa
	call _clear_hud_rows__0
	lda xsp,(xsp+8)
	ld c,(_goal_reached__0)
	cp c,0
	jr z,L811
	ld xwa,_S0_17
	jr L812
L811:
	ld xwa,_S0_18
L812:
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
	jr L815
L813:
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
L815:
	ld xwa,(xsp+14)
	ld c,(xsp+18)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L813
L814:
	ld a,(_difficulty)
	cp a,3
	jr nz,L816
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
	jr L817
L816:
	ld a,0
	lda xbc,(xsp+1)
	ld e,(xsp+18)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L817:
	lda xwa,(xsp+1)
	push xwa
	ld wa,4
	push xwa
	ld wa,20
	ld c,(xsp+26)
	extz bc
	ld l,(_difficulty)
	cp l,3
	jr nz,L818
	ld de,4
	jr L819
L818:
	ld de,0
L819:
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
	ld xwa,_S0_19
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
	ld xwa,_S0_20
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
	jr L823
L820:
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
	jr uge,L824
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
L824:
L822:
	inc 1,izl
L823:
	ld a,izl
	cp a,(_cur_stage)
	jr ule,L820
L821:
	ld xwa,(_score__0)
	ld xbc,_hiscore__0
	ld e,(_difficulty)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld xbc,(xbc)
	cp xwa,xbc
	jr ule,L825
	ld xwa,(_score__0)
	ld xbc,_hiscore__0
	ld e,(_difficulty)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ldb (_save_dirty__0),1
	ld xwa,_S0_21
	push xwa
	ld wa,9
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L825:
	call _banner_hide
	ld a,64
	push xwa
	ld a,28
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	ld a,(_goal_reached__0)
	cp a,0
	jr z,L826
	call _trophy_load__0
	ld c,(_difficulty)
	cp c,3
	jr nz,L827
	ld wa,5
	jr L828
L827:
	ld xwa,_route_hist
	ld c,(_cur_stage)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
L828:
	push xwa
	call _ending_start
	lda xsp,(xsp+4)
L826:
L810:
	lda xsp,(xsp+20)
	pop xiz
	ret

; function balloons_init
_balloons_init__0:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,41920
	ld xix,xwa
	ld izl,0
	jr L838
L835:
	ld xwa,_gfx_particle_tiles
	ld bc,16
	ld e,izl
	extz de
	add bc,de
	extz xbc
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
L837:
	inc 1,izl
L838:
	ld a,izl
	cp a,8
	jr ult,L835
L836:
L834:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function balloons_reset
_balloons_reset__0:
	ldb (_bal_live__0),0
	ldb (_trf_spr_end),50
	ld a,50
	push xwa
	ld a,42
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L840:
	ret

; function balloons_launch
_balloons_launch__0:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jp L852
L849:
	ld a,(_g_vb_counter)
	extz wa
	mul xwa,37
	ld c,izl
	extz bc
	mul xbc,71
	add wa,bc
	ld ixl,a
	ld c,izl
	extz bc
	and bc,1
	cp bc,0
	jr z,L853
	ld wa,118
	ld c,ixl
	extz bc
	and bc,31
	add wa,bc
	jr L854
L853:
	ld wa,6
	ld c,ixl
	extz bc
	and bc,31
	add wa,bc
L854:
	ld xbc,_bal_x__0
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,112
	ld c,ixl
	extz bc
	and bc,15
	add wa,bc
	sll 2,wa
	ld xbc,_bal_y__0
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,4
	ld c,ixl
	extz bc
	and bc,3
	add wa,bc
	ld xbc,_bal_v__0
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,izl
	extz wa
	mul xwa,7
	ld xbc,_bal_wait__0
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L851:
	inc 1,izl
L852:
	ld a,izl
	cp a,8
	jp ult,L849
L850:
	ldb (_bal_live__0),1
	ldb (_trf_spr_end),42
L848:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function balloons_draw
_balloons_draw__0:
	push xiz
	lda xsp,(xsp-18)
	ld wa,0
	ld (xsp+1),a
	ld a,(_bal_live__0)
	cp a,0
	jr nz,L870
	jp L869
L870:
	ld izl,0
	jp L874
L871:
	ld a,42
	add a,izl
	ld iyl,a
	ld xwa,_bal_wait__0
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L875
	ld xbc,_bal_wait__0
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld a,(xbc)
	dec 1,a
	ld (xbc),a
	push xix
	push xiy
	ld a,iyl
	add a,1
	push xwa
	ld a,iyl
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	ldb (xsp+1),1
	jp L873
L875:
	ld xwa,_bal_y__0
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_bal_v__0
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	sub wa,bc
	ld xbc,_bal_y__0
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_bal_y__0
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65496
	jr ge,L876
	push xix
	push xiy
	ld a,iyl
	add a,1
	push xwa
	ld a,iyl
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	jp L873
L876:
	ldb (xsp+1),1
	ld xwa,_bal_x__0
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld e,(_g_vb_counter)
	extz de
	sra 3,de
	ld l,izl
	extz hl
	add de,hl
	and de,2
	cp de,0
	jr z,L877
	ld bc,1
	jr L878
L877:
	ld bc,0
L878:
	add wa,bc
	ld (xsp+4),wa
L879:
	ld a,iyl
	ld (xsp+6),a
	ld a,(xsp+4)
	ld (xsp+7),a
	ld xwa,_bal_y__0
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	sra 2,wa
	ld (xsp+8),a
	ld wa,60
	ld (xsp+10),wa
	ld wa,11
	ld c,izl
	extz bc
	extz xbc
	div xbc,5
	ld bc,qbc
	add wa,bc
	ld (xsp+12),a
	ld a,0
	ld (xsp+13),a
	ld xwa,_spr_shadow
	ld c,(xsp+6)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
	ld xix,xwa
	ld a,(xsp+10)
	and a,255
	ld (xix),a
	ld a,(xsp+13)
	extz wa
	ld c,(_id_spr_priority)
	extz bc
	or wa,bc
	ld bc,(xsp+10)
	srl 8,bc
	and bc,1
	extz bc
	or wa,bc
	ld (xix+1),a
	ld a,(xsp+7)
	ld (xix+2),a
	ld a,(xsp+8)
	ld (xix+3),a
	ld a,(xsp+12)
	and a,15
	ld xbc,_spr_pal_shadow
	ld e,(xsp+6)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L881:
L880:
L873:
	inc 1,izl
L874:
	ld a,izl
	cp a,8
	jp ult,L871
L872:
	ld a,(xsp+1)
	cp a,0
	jr nz,L882
	ldb (_bal_live__0),0
	ldb (_trf_spr_end),50
L882:
L869:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function smoke_init
_smoke_init__0:
	push xiz
	lda xsp,(xsp-2)
	ld ixl,0
	jr L896
L893:
	ld izl,0
	jr L900
L897:
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
L899:
	inc 1,izl
L900:
	ld a,izl
	cp a,8
	jr ult,L897
L898:
L895:
	inc 1,ixl
L896:
	ld a,ixl
	cp a,4
	jr ult,L893
L894:
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
L892:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function smoke_draw
_smoke_draw__0:
	push xiz
	lda xsp,(xsp-24)
	ld a,(xsp+32)
	cp a,0
	jr nz,L924
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
	jp L923
L924:
	ld a,(_smoke_t__0)
	extz wa
	and wa,7
	cp wa,0
	jr nz,L925
	ld a,(xsp+36)
	cp a,0
	jr nz,L925
	push xix
	push xiy
	ld wa,7
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L925:
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
	jp L929
L926:
	ld c,ixl
	cp c,0
	jr nz,L930
	ld wa,(xsp+0)
	sub wa,11
	ld c,(_smoke_t__0)
	extz bc
	sra 2,bc
	and bc,1
	sub wa,bc
	jr L931
L930:
	ld wa,(xsp+0)
	add wa,27
	ld c,(_smoke_t__0)
	extz bc
	sra 2,bc
	and bc,1
	add wa,bc
L931:
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
	jp L935
L932:
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
	jr z,L936
	ld a,1
	sub a,izl
	extz wa
	jr L937
L936:
	ld a,izl
	extz wa
L937:
	ld (xsp+9),a
	ld wa,(xsp+6)
	ld c,izl
	extz bc
	sll 3,bc
	add wa,bc
	ld (xsp+10),wa
	ld wa,(xsp+10)
	cp wa,65529
	jr lt,L939
	ld wa,(xsp+10)
	cp wa,159
	jr le,L938
L939:
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
	jp L934
L938:
L940:
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
	jr z,L943
	ld wa,128
	jr L944
L943:
	ld wa,0
L944:
	ld (xsp+19),a
	ld xwa,_spr_shadow
	ld c,(xsp+12)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
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
	ld xbc,_spr_pal_shadow
	ld e,(xsp+12)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L942:
L941:
L934:
	inc 1,izl
L935:
	ld a,izl
	cp a,2
	jp ult,L932
L933:
L928:
	inc 1,ixl
L929:
	ld a,ixl
	cp a,2
	jp ult,L926
L927:
L923:
	lda xsp,(xsp+24)
	pop xiz
	ret

; function engine_sound
_engine_sound__0:
	push xiz
	lda xsp,(xsp-10)
	ld c,(_gear__0)
	cp c,0
	jr nz,L960
	ld wa,137
	jr L961
L960:
	ld wa,224
L961:
	ld (xsp+0),wa
	ld a,(_speed__0)
	extz wa
	mul xwa,255
	extz xwa
	div xwa,(xsp+0)
	ld ix,wa
	ld wa,ix
	cp wa,255
	jr ule,L962
	ld ix,255
L962:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L963
	ld ix,0
L963:
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
	jr z,L964
	ld wa,iz
	ld bc,iz
	ld l,(_offroad__0)
	cp l,0
	jr z,L965
	ld l,(_speed__0)
	cp l,20
	jr ule,L965
	ld de,3
	jr L966
L965:
	ld de,5
L966:
	cp e,0
	jr z,L968
L967:
	srl 1,bc
	djnz e,L967
L968:
	add wa,bc
	ld iz,wa
L964:
	ld c,(_ngpc_pad_held)
	extz bc
	and bc,16
	cp bc,0
	jr z,L969
	ld wa,4
	jr L970
L969:
	ld wa,6
L970:
	ld iyl,a
	ld a,(_state__0)
	cp a,4
	jr z,L972
	ld a,(_state__0)
	cp a,3
	jr nz,L971
L972:
	ld iyl,9
L971:
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
L959:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function roll_draw
_roll_draw__0:
	push xiz
	lda xsp,(xsp-34)
	ld a,(_roll_t__0)
	extz wa
	sub wa,1
	mul xwa,12
	extz xwa
	div xwa,36
	ld (xsp+0),a
	push xix
	push xiy
	call _id_car_tile_base
	pop xiy
	pop xix
	ld (xsp+6),wa
	ld a,(xsp+0)
	cp a,12
	jr ult,L994
	ldb (xsp+0),11
L994:
	ld a,(_roll_kind__0)
	cp a,0
	jr z,L995
	ld a,(xsp+0)
	add a,12
	ld (xsp+0),a
	jr L996
L995:
	ld a,(_roll_dir__0)
	cp a,0
	jr nz,L997
	ld wa,12
	ld c,(xsp+0)
	extz bc
	sub wa,bc
	exts xwa
	divs xwa,12
	ld wa,qwa
	ld (xsp+0),a
L997:
L996:
	ld xwa,_gfx_roll_frames
	ld c,(xsp+0)
	extz bc
	exts xbc
	sll 3,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+2),xwa
	ld a,(xsp+0)
	cp a,(_roll_loaded__0)
	jp z,L998
	ld xwa,(xsp+2)
	ld a,(xwa+6)
	extz wa
	sll 3,wa
	ld (xsp+14),wa
	ld xwa,_gfx_roll_tiles
	ld xbc,(xsp+2)
	ld bc,(xbc+4)
	sll 3,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+18),xwa
	ld wa,40960
	extz xwa
	ld bc,(xsp+6)
	mul xbc,16
	add xwa,xbc
	ld (xsp+22),xwa
	ldw (xsp+16),0
	jr L1002
L999:
	ld xwa,(xsp+18)
	ld bc,(xsp+16)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(xsp+22)
	ld de,(xsp+16)
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1001:
	incw 1,(xsp+16)
L1002:
	ld wa,(xsp+16)
	cp wa,(xsp+14)
	jr ult,L999
L1000:
	push xix
	push xiy
	ld xwa,_gfx_roll_pal
	ld xbc,(xsp+10)
	ld c,(xbc+7)
	extz bc
	sll 2,bc
	add bc,3
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_gfx_roll_pal
	ld xbc,(xsp+14)
	ld c,(xbc+7)
	extz bc
	sll 2,bc
	add bc,2
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_gfx_roll_pal
	ld xbc,(xsp+18)
	ld c,(xbc+7)
	extz bc
	sll 2,bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xiy
	pop xix
	ld a,(xsp+0)
	ld (_roll_loaded__0),a
L998:
	push xix
	push xiy
	ld wa,147
	push xwa
	call _id_road_centre_at
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld bc,(_car_lat__0)
	sra 4,bc
	add wa,bc
	ld (xsp+8),wa
	ld xwa,_roll_lift__0
	ld c,(_roll_t__0)
	extz bc
	sll 4,bc
	extz xbc
	div xbc,36
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+1),a
	ld a,(_roll_kind__0)
	cp a,0
	jr z,L1003
	ld a,(xsp+1)
	extz wa
	ld c,(xsp+1)
	extz bc
	sra 1,bc
	add wa,bc
	ld (xsp+1),a
L1003:
	ld wa,136
	ld c,(xsp+1)
	extz bc
	sub wa,bc
	ld (xsp+10),wa
	ld izl,0
	jp L1007
L1004:
	ld xwa,_gfx_roll_cells
	ld xbc,(xsp+2)
	ld bc,(xbc)
	ld e,izl
	extz de
	add bc,de
	mul xbc,3
	extz xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+14),xwa
	ld wa,(xsp+8)
	ld xbc,(xsp+14)
	ld c,(xbc)
	exts bc
	add wa,bc
	ld (xsp+18),wa
	ld wa,(xsp+10)
	ld xbc,(xsp+14)
	ld c,(xbc+1)
	exts bc
	add wa,bc
	ld iy,wa
	ld wa,(xsp+18)
	cp wa,65529
	jr lt,L1009
	ld wa,(xsp+18)
	cp wa,159
	jr gt,L1009
	ld wa,iy
	cp wa,65529
	jr lt,L1009
	ld wa,iy
	cp wa,151
	jr le,L1008
L1009:
	push xix
	push xiy
	ld a,izl
	add a,1
	push xwa
	ld a,izl
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	jp L1006
L1008:
L1010:
	ld a,izl
	ld (xsp+22),a
	ld a,(xsp+18)
	ld (xsp+23),a
	ld a,iyl
	ld (xsp+24),a
	ld wa,(xsp+6)
	ld xbc,(xsp+14)
	ld c,(xbc+2)
	extz bc
	add wa,bc
	ld (xsp+26),wa
	ld a,0
	ld (xsp+28),a
	ld a,0
	ld (xsp+29),a
	ld xwa,_spr_shadow
	ld c,(xsp+22)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
	ld xix,xwa
	ld a,(xsp+26)
	and a,255
	ld (xix),a
	ld a,(xsp+29)
	extz wa
	ld c,(_id_spr_priority)
	extz bc
	or wa,bc
	ld bc,(xsp+26)
	srl 8,bc
	and bc,1
	extz bc
	or wa,bc
	ld (xix+1),a
	ld a,(xsp+23)
	ld (xix+2),a
	ld a,(xsp+24)
	ld (xix+3),a
	ld a,(xsp+28)
	and a,15
	ld xbc,_spr_pal_shadow
	ld e,(xsp+22)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1012:
L1011:
L1006:
	inc 1,izl
L1007:
	ld a,izl
	ld xbc,(xsp+2)
	ld c,(xbc+2)
	cp a,c
	jp ult,L1004
L1005:
	push xix
	push xiy
	ld wa,24
	push xwa
	ld a,izl
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xiy
	pop xix
L993:
	lda xsp,(xsp+34)
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
	jr ge,L1029
	ld wa,ix
	cp wa,65484
	jr gt,L1028
L1029:
	ld wa,0
	jp L1027
L1028:
	ldb (xsp+1),0
	jr L1033
L1030:
	inc 1,izl
	ld a,izl
	cp a,(_track_len)
	jr ult,L1034
	ld izl,0
L1034:
	ld xwa,(_track_seg)
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld wa,(xwa+2)
	ld ix,wa
	ld wa,ix
	cp wa,52
	jr ge,L1036
	ld wa,ix
	cp wa,65484
	jr gt,L1035
L1036:
	ld wa,iy
	cp wa,150
	jr uge,L1037
	ld wa,0
	jr L1027
L1037:
	ld bc,ix
	cp bc,0
	jr le,L1038
	ld wa,1
	jr L1039
L1038:
	ld wa,65535
L1039:
	jr L1027
L1035:
	ld wa,iy
	ld xbc,(_track_seg)
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld iy,wa
L1032:
	incb 1,(xsp+1)
L1033:
	ld a,(xsp+1)
	cp a,6
	jr uge,L1040
	ld wa,iy
	cp wa,1300
	jr ult,L1030
L1040:
L1031:
	ld wa,0
	jr L1027
L1027:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function game_tick
_game_tick__0:
	push xiz
	lda xsp,(xsp-8)
	ld a,(_state__0)
	cp a,0
	jp nz,L1161
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
	jr z,L1162
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,8
	cp wa,0
	jr z,L1163
	ld a,(_station__0)
	extz wa
	add wa,1
	extz xwa
	div xwa,5
	ld wa,qwa
	ld (_station__0),a
	jr L1164
L1163:
	ld a,(_station__0)
	extz wa
	add wa,5
	sub wa,1
	extz xwa
	div xwa,5
	ld wa,qwa
	ld (_station__0),a
L1164:
	ldb (_save_dirty__0),1
	call _title_texts__0
	ld a,(_station__0)
	push xwa
	call _music_play
	lda xsp,(xsp+4)
L1162:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,3
	cp wa,0
	jr z,L1165
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,2
	cp wa,0
	jr z,L1166
	ld a,(_difficulty)
	extz wa
	add wa,1
	and wa,3
	ld (_difficulty),a
	jr L1167
L1166:
	ld a,(_difficulty)
	extz wa
	add wa,4
	sub wa,1
	and wa,3
	ld (_difficulty),a
L1167:
	ld a,(_difficulty)
	cp a,3
	jr nz,L1168
	call _new_seed__0
L1168:
	ldb (_save_dirty__0),1
	ld wa,0
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	call _title_texts__0
L1165:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,32
	cp wa,0
	jr z,L1169
	ld a,(_difficulty)
	cp a,3
	jr nz,L1169
	call _new_seed__0
	ldb (_save_dirty__0),1
	ld wa,0
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	call _title_texts__0
L1169:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,16
	cp wa,0
	jr z,L1170
	call _title_leave__0
	call _new_game__0
	ldb (_state__0),1
	ldb (_state_timer__0),0
L1170:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
	jp L1171
L1161:
	ld a,(_state__0)
	cp a,6
	jr nz,L1172
	incw 1,(_map_t__0)
	ld wa,(_map_along__0)
	add wa,2
	ld (_map_along__0),wa
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,16
	cp wa,0
	jr z,L1175
	ld wa,(_map_t__0)
	cp wa,20
	jr ugt,L1174
L1175:
	ld wa,(_map_done__0)
	cp wa,0
	jr z,L1173
	ld wa,(_map_t__0)
	ld bc,(_map_done__0)
	add bc,75
	cp wa,bc
	jr ule,L1173
L1174:
	call _map_leave__0
	ldb (_state__0),5
	ldb (_state_timer__0),0
	call _result_screen__0
L1173:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
	jp L1176
L1172:
	ld a,(_state__0)
	cp a,5
	jr nz,L1177
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,16
	cp wa,0
	jr z,L1178
	ld a,(_state_timer__0)
	cp a,30
	jr ule,L1178
	ldb (_state__0),0
	ldb (_state_timer__0),0
	call _new_game__0
	call _title_screen__0
	ld a,(_station__0)
	push xwa
	call _music_play
	lda xsp,(xsp+4)
L1178:
	ld a,(_state_timer__0)
	cp a,255
	jr uge,L1179
	incb 1,(_state_timer__0)
L1179:
	ld a,(_state_timer__0)
	cp a,30
	jr ule,L1180
	ld wa,13
	push xwa
	ld a,(_state_timer__0)
	push xwa
	call _title_blink__0
	lda xsp,(xsp+8)
L1180:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
	jr L1181
L1177:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,64
	cp wa,0
	jr z,L1182
	ld c,(_paused__0)
	cp c,0
	jr nz,L1183
	ld wa,1
	jr L1184
L1183:
	ld wa,0
L1184:
	ld (_paused__0),a
	ld a,(_paused__0)
	cp a,0
	jr z,L1185
	ld wa,0
	push xwa
	ld wa,0
	exts xwa
	push xwa
	ld xwa,_S0_22
	push xwa
	call _message__0
	lda xsp,(xsp+12)
	jr L1186
L1185:
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
L1186:
L1182:
L1181:
L1176:
L1171:
	ld a,(_paused__0)
	cp a,0
	jr z,L1187
	jp L1160
L1187:
	ld a,(_state__0)
	cp a,1
	jp nz,L1188
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
	jr nz,L1190
	ld a,(xsp+0)
	cp a,4
	jr uge,L1190
	ld wa,0
	push xwa
	ld xwa,_cd__0_L1189
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
L1190:
	incb 1,(_state_timer__0)
	ld a,(_state_timer__0)
	cp a,90
	jr ult,L1191
	ldb (_state__0),2
	ld a,(_cur_stage)
	cp a,0
	jr nz,L1192
	call _balloons_launch__0
L1192:
	ld wa,30
	push xwa
	ld xwa,(_cd__0_L1189+12)
	push xwa
	call _count_message__0
	lda xsp,(xsp+8)
	ld wa,1
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L1191:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
L1188:
	ld a,(_state__0)
	cp a,2
	jr z,L1194
	ld a,(_state__0)
	cp a,3
	jr z,L1194
	ld a,(_state__0)
	cp a,4
	jp nz,L1193
L1194:
	ld a,(_state__0)
	cp a,2
	jr nz,L1196
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L1195
L1196:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
L1195:
	ld wa,(_course_pos__0)
	ld (xsp+2),wa
	ld a,(_speed__0)
	ld (xsp+4),a
	call _drive__0
	ld a,(_offroad__0)
	cp a,0
	jr z,L1197
	ld a,(_was_offroad__0)
	cp a,0
	jr nz,L1197
	ld a,(xsp+4)
	ld (_verge_spd__0),a
	jr L1198
L1197:
	ld a,(_offroad__0)
	cp a,0
	jr z,L1199
	ld c,(_verge_spd__0)
	cp c,4
	jr ule,L1200
	ld a,(_verge_spd__0)
	sub a,4
	extz wa
	jr L1201
L1200:
	ld wa,0
L1201:
	ld (_verge_spd__0),a
	jr L1202
L1199:
	ldb (_verge_spd__0),0
L1202:
L1198:
	ld a,(_offroad__0)
	ld (_was_offroad__0),a
	call _advance__0
	ld a,(_state__0)
	cp a,2
	jp nz,L1203
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
	add a,(xsp+16)
	ld (_sec_acc__0),a
	jr L1206
L1204:
	ld a,(_sec_acc__0)
	sub a,60
	ld (_sec_acc__0),a
	ld a,(_time_left__0)
	cp a,0
	jr z,L1207
	decb 1,(_time_left__0)
L1207:
	ld a,(_time_left__0)
	cp a,0
	jr z,L1208
	ld a,(_time_left__0)
	cp a,10
	jr ugt,L1208
	ld wa,5
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L1208:
L1206:
	ld a,(_sec_acc__0)
	cp a,60
	jr uge,L1204
L1205:
	ld a,(_time_left__0)
	cp a,0
	jr nz,L1209
	ldb (_state__0),3
	ldb (_state_timer__0),0
	ld wa,0
	push xwa
	ld wa,0
	exts xwa
	push xwa
	ld xwa,_S0_23
	push xwa
	call _message__0
	lda xsp,(xsp+12)
	ld wa,6
	push xwa
	call _music_play
	lda xsp,(xsp+4)
	ld wa,3
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
L1209:
L1203:
	ld wa,(_course_pos__0)
	push xwa
	call _course_fork_zone
	lda xsp,(xsp+4)
	ld (xsp+0),a
	ld a,(xsp+0)
	cp a,0
	jp z,L1210
	call _course_is_last_stage
	cp a,0
	jp nz,L1210
	ld a,(_last_fork_zone__0)
	cp a,0
	jr nz,L1211
	ld wa,1
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
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
L1211:
	ld a,(_fork_choice)
	cp a,0
	jr nz,L1212
	ld wa,(_course_pos__0)
	add wa,850
	cp wa,(_leg_len)
	jr ult,L1212
	ld bc,(_car_lat__0)
	cp bc,0
	jr le,L1213
	ld wa,1
	jr L1214
L1213:
	ld wa,0
L1214:
	push xwa
	call _course_decide
	lda xsp,(xsp+4)
	ld wa,3
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld a,(_fork_choice)
	cp a,2
	jr nz,L1215
	ld xwa,_S0_25
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
	jr L1216
L1215:
	ld xwa,_S0_26
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
L1216:
L1212:
	jp L1217
L1210:
	ld a,(xsp+0)
	cp a,0
	jr z,L1218
	call _course_is_last_stage
	cp a,0
	jr z,L1218
	ld a,(_last_fork_zone__0)
	cp a,0
	jr nz,L1219
	ld xwa,_S0_27
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
L1219:
	ld wa,5
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L1220
L1218:
	ld a,(_cur_stage)
	cp a,0
	jr nz,L1221
	ld wa,(_course_pos__0)
	cp wa,900
	jr uge,L1221
	ld wa,5
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L1222
L1221:
	ld wa,(_course_pos__0)
	push xwa
	call _course_start_zone
	lda xsp,(xsp+4)
	cp a,0
	jr z,L1223
	ld wa,2
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L1224
L1223:
	call _sharp_ahead__0
	ld (xsp+4),a
	ld c,(xsp+4)
	cp c,0
	jr le,L1225
	ld wa,3
	jr L1226
L1225:
	ld c,(xsp+4)
	cp c,0
	jr ge,L1227
	ld wa,4
	jr L1228
L1227:
	ld wa,0
L1228:
L1226:
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
L1224:
L1222:
L1220:
L1217:
	ld a,(xsp+0)
	ld (_last_fork_zone__0),a
	ld a,(_goal_reached__0)
	cp a,0
	jr nz,L1229
	ld wa,(_course_pos__0)
	cp wa,(_leg_len)
	jr ult,L1229
	ldb (_last_fork_zone__0),0
	call _leg_end__0
L1229:
	ld a,(_speed__0)
	push xwa
	call _id_scenery_advance
	lda xsp,(xsp+4)
	ld a,(_state__0)
	cp a,2
	jp nz,L1230
	ld a,(_crash_timer__0)
	cp a,0
	jp nz,L1230
	ld a,(_speed__0)
	push xwa
	ld wa,(_car_lat__0)
	push xwa
	call _traffic_collide
	lda xsp,(xsp+8)
	ld (xsp+4),a
	ld a,(xsp+4)
	cp a,0
	jr z,L1231
	ld a,(_speed__0)
	extz wa
	mul xwa,15
	srl 4,wa
	add wa,6
	ld (xsp+6),wa
	ld c,(xsp+4)
	cp c,1
	jr nz,L1232
	ld wa,(xsp+6)
	jr L1233
L1232:
	ld wa,(xsp+6)
	neg wa
L1233:
	ld (_knock_v__0),wa
	ldb (_knock_t__0),1
	ld wa,(_dbg_knock_at)
	cp wa,0
	jr nz,L1234
	ld a,(_speed__0)
	cp a,100
	jr ule,L1234
	ld wa,(_dbg_updates)
	ld (_dbg_knock_at),wa
L1234:
	ld a,(_speed__0)
	extz wa
	mul xwa,7
	srl 4,wa
	ld (_speed__0),a
	incb 1,(_dbg_bumps)
	ld wa,4
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	jp L1235
L1231:
	ld wa,147
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_scenery_hit
	lda xsp,(xsp+8)
	cp a,0
	jr nz,L1237
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	ld wa,(_course_pos__0)
	push xwa
	ld wa,(xsp+10)
	push xwa
	call _bridge_hit
	lda xsp,(xsp+12)
	cp a,0
	jp z,L1236
L1237:
	ld c,(_verge_spd__0)
	cp c,(_speed__0)
	jr ule,L1238
	ld a,(_verge_spd__0)
	extz wa
	jr L1239
L1238:
	ld a,(_speed__0)
	extz wa
L1239:
	ld (xsp+5),a
	ld a,(xsp+5)
	cp a,110
	jp ule,L1240
	ld a,(xsp+5)
	ld xbc,_dbg_cspd
	ld e,(_dbg_scn)
	extz de
	and de,15
	extz xde
	add xbc,xde
	ld (xbc),a
	incb 1,(_dbg_scn)
	ldb (_crash_timer__0),90
	ld a,(xsp+5)
	cp a,168
	jr ult,L1241
	ldb (_roll_t__0),1
	ld c,(xsp+5)
	cp c,214
	jr ult,L1242
	ld wa,1
	jr L1243
L1242:
	ld wa,0
L1243:
	ld (_roll_kind__0),a
	ld a,(_roll_kind__0)
	cp a,0
	jr z,L1244
	incb 1,(_dbg_flips)
	ld wa,(_dbg_flip_at)
	cp wa,0
	jr nz,L1245
	ld wa,(_dbg_updates)
	ld (_dbg_flip_at),wa
L1245:
	jr L1246
L1244:
	incb 1,(_dbg_rolls)
L1246:
	ld wa,(_dbg_roll_at)
	cp wa,0
	jr nz,L1247
	ld wa,(_dbg_updates)
	ld (_dbg_roll_at),wa
L1247:
	ld bc,(_car_lat__0)
	cp bc,0
	jr gt,L1250
	ld bc,(_car_lat__0)
	cp bc,0
	jr nz,L1248
	ld c,(_g_vb_counter)
	extz bc
	and bc,1
	cp bc,0
	jr z,L1248
L1250:
	ld wa,1
	jr L1249
L1248:
	ld wa,0
L1249:
	ld (_roll_dir__0),a
L1241:
	incb 1,(_dbg_crashes)
	ld wa,3
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	jr L1251
L1240:
	ld wa,48
	ld (xsp+6),a
	ld a,(_speed__0)
	extz wa
	sra 1,wa
	ld (xsp+7),a
	ld a,(xsp+6)
	cp a,(xsp+7)
	jr ule,L1252
	ld a,(xsp+7)
	ld (xsp+6),a
L1252:
	ld c,(_speed__0)
	cp c,(xsp+6)
	jr ule,L1253
	ld a,(_speed__0)
	sub a,(xsp+6)
	extz wa
	jr L1254
L1253:
	ld wa,0
L1254:
	ld (_speed__0),a
	ld wa,4
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L1251:
L1236:
L1235:
L1230:
	ld wa,(_knock_v__0)
	cp wa,0
	jr z,L1255
	ld wa,(_car_lat__0)
	add wa,(_knock_v__0)
	ld (_car_lat__0),wa
	ld wa,(_car_lat__0)
	cp wa,(_lat_limit__0)
	jr le,L1256
	ld wa,(_lat_limit__0)
	ld (_car_lat__0),wa
L1256:
	ld wa,(_car_lat__0)
	ld bc,(_lat_limit__0)
	neg bc
	cp wa,bc
	jr ge,L1257
	ld wa,(_lat_limit__0)
	neg wa
	ld (_car_lat__0),wa
L1257:
	ld wa,(_knock_v__0)
	mul xwa,7
	exts xwa
	divs xwa,8
	ld (_knock_v__0),wa
	ld wa,(_knock_v__0)
	cp wa,65524
	jr le,L1258
	ld wa,(_knock_v__0)
	cp wa,12
	jr ge,L1258
	ldw (_knock_v__0),0
L1258:
L1255:
	ld a,(_knock_t__0)
	cp a,0
	jr z,L1259
	incb 1,(_knock_t__0)
	ld a,(_knock_t__0)
	cp a,26
	jr ule,L1260
	ldb (_knock_t__0),0
L1260:
L1259:
	ld a,(_roll_t__0)
	cp a,0
	jr z,L1261
	incb 1,(_roll_t__0)
	ld a,(_roll_t__0)
	cp a,36
	jr ule,L1262
	ldb (_roll_t__0),0
	ldb (_roll_loaded__0),255
	call _id_car_restore
L1262:
L1261:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L1263
	decb 1,(_crash_timer__0)
	ld c,(_speed__0)
	cp c,12
	jr ule,L1264
	ld a,(_speed__0)
	sub a,12
	extz wa
	jr L1265
L1264:
	ld wa,0
L1265:
	ld (_speed__0),a
	ld a,(_crash_timer__0)
	cp a,0
	jr nz,L1266
	ld wa,(_car_lat__0)
	exts xwa
	divs xwa,2
	ld (_car_lat__0),wa
	ldb (_speed__0),0
	ldb (_gear__0),0
L1266:
L1263:
	ld c,(_state__0)
	cp c,2
	jr nz,L1267
	push xwa
	ld wa,(_course_pos__0)
	push xwa
	call _course_fork_zone
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp c,0
	jr nz,L1267
	ld wa,1
	jr L1268
L1267:
	ld wa,0
L1268:
	push xwa
	ld a,(_speed__0)
	push xwa
	call _traffic_update
	lda xsp,(xsp+8)
	ld a,(_state__0)
	cp a,3
	jr nz,L1269
	incb 1,(_state_timer__0)
	ld a,(_speed__0)
	cp a,0
	jr nz,L1270
	ld a,(_state_timer__0)
	cp a,60
	jr ule,L1270
	ldb (_state__0),6
	ldb (_state_timer__0),0
	call _map_screen__0
L1270:
	jr L1271
L1269:
	ld a,(_state__0)
	cp a,4
	jr nz,L1272
	incb 1,(_state_timer__0)
	ld a,(_state_timer__0)
	cp a,1
	jr nz,L1273
	ld xwa,(_score__0)
	ld c,(_time_left__0)
	extz bc
	muls xbc,20000
	add xwa,xbc
	ld (_score__0),xwa
	ld izl,0
	jr L1277
L1274:
	ld wa,20000
	push xwa
	call _hud_score_add
	lda xsp,(xsp+4)
L1276:
	inc 1,izl
L1277:
	ld a,izl
	cp a,(_time_left__0)
	jr ult,L1274
L1275:
L1273:
	ld a,(_speed__0)
	cp a,0
	jr nz,L1278
	ld a,(_state_timer__0)
	cp a,60
	jr ule,L1278
	ldb (_state__0),6
	ldb (_state_timer__0),0
	call _map_screen__0
L1278:
L1272:
L1271:
L1193:
L1160:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function main
_main:
	push xiz
	lda xsp,(xsp-16)
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
	add wa,111
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
	call _bridge_init
	call _balloons_init__0
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
	jr L1346
L1343:
	ld bc,(xsp+2)
	cp bc,0
	jr le,L1347
	call _id_road_grade_hi
	exts wa
	jr L1348
L1347:
	call _id_road_grade_lo
	exts wa
	neg wa
L1348:
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
L1345:
	incw 1,(xsp+2)
L1346:
	ld wa,(xsp+2)
	cp wa,6
	jr le,L1343
L1344:
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
L1349:
	jr L1355
L1353:
	call _ngpc_vsync
L1355:
	ld a,(_g_vb_counter)
	sub a,(_pace_prev__0)
	cp a,2
	jr ult,L1353
L1354:
	jr L1358
L1356:
	call _ngpc_vsync
L1358:
	ld a,(_spr_ready)
	cp a,0
	jr nz,L1356
L1357:
	ld a,(_g_vb_counter)
	ld (_frame_vb__0),a
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
	jr ule,L1359
	ldb (xsp+10),3
	ld a,(xsp+8)
	ld c,(xsp+9)
	and c,1
	sub a,c
	ld (_pace_prev__0),a
	jr L1360
L1359:
	ld a,(_pace_prev__0)
	extz wa
	ld c,(xsp+10)
	extz bc
	sll 1,bc
	extz bc
	add wa,bc
	ld (_pace_prev__0),a
L1360:
	call _ngpc_input_update
	call _audio_update
	incw 1,(_dbg_updates)
	ld a,(xsp+8)
	ld (_clock_prev__0),a
	ld izl,0
	jr L1364
L1361:
	ld wa,2
	push xwa
	call _game_tick__0
	lda xsp,(xsp+4)
	ld a,izl
	cp a,0
	jr nz,L1365
	ldb (_ngpc_pad_pressed),0
L1365:
L1363:
	inc 1,izl
L1364:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L1361
L1362:
	ld a,(_state__0)
	cp a,0
	jr nz,L1366
	ld a,(_state_timer__0)
	push xwa
	call _title_car__0
	lda xsp,(xsp+4)
	call _player_engine_off
	call _frame_commit__0
	jp L1351
L1366:
	ld a,(_state__0)
	cp a,6
	jr nz,L1367
	call _map_car__0
	call _player_engine_off
	call _frame_commit__0
	jp L1351
L1367:
	call _render_road__0
	call _tick_flash__0
	call _tick_message__0
	ld a,(_state__0)
	cp a,0
	jr z,L1368
	ld a,(_state__0)
	cp a,5
	jr z,L1368
	ld wa,(_course_pos__0)
	push xwa
	call _bridge_draw
	lda xsp,(xsp+4)
	call _id_scenery_draw
	call _traffic_draw
	call _balloons_draw__0
L1368:
	ld a,(_state__0)
	cp a,1
	jr z,L1370
	ld a,(_state__0)
	cp a,2
	jr nz,L1369
	ld a,(_cur_stage)
	cp a,0
	jr nz,L1369
	ld wa,(_course_pos__0)
	cp wa,220
	jr uge,L1369
L1370:
	ld xwa,_S0_32
	push xwa
	ld wa,0
	push xwa
	ld wa,120
	ld bc,(_course_pos__0)
	sub wa,bc
	push xwa
	call _banner_show
	lda xsp,(xsp+12)
	jr L1371
L1369:
	ld a,(_state__0)
	cp a,2
	jr z,L1373
	ld a,(_state__0)
	cp a,4
	jr z,L1373
	ld a,(_state__0)
	cp a,3
	jr nz,L1372
L1373:
	call _course_is_last_stage
	cp a,0
	jr z,L1372
	ld wa,(_course_pos__0)
	ld bc,(_leg_len)
	sub bc,1400
	cp wa,bc
	jr le,L1372
	ld xwa,_S0_33
	push xwa
	ld wa,1
	push xwa
	ld wa,(_leg_len)
	ld bc,(_course_pos__0)
	sub wa,bc
	push xwa
	call _banner_show
	lda xsp,(xsp+12)
	jr L1374
L1372:
	call _banner_hide
L1374:
L1371:
	ld a,(_state__0)
	cp a,5
	jr nz,L1375
	ld a,(_goal_reached__0)
	cp a,0
	jr z,L1375
	call _trophy_draw__0
	call _ending_tick
L1375:
	ld a,(_state__0)
	cp a,2
	jr z,L1377
	ld a,(_state__0)
	cp a,1
	jr z,L1377
	ld a,(_state__0)
	cp a,3
	jr z,L1377
	ld a,(_state__0)
	cp a,4
	jr nz,L1376
L1377:
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
	jr nz,L1378
	ld c,(_speed__0)
	cp c,123
	jr ult,L1378
	ld c,(_g_vb_counter)
	extz bc
	and bc,8
	cp bc,0
	jr z,L1378
	ld wa,2
	jr L1379
L1378:
	ld a,(_gear__0)
	extz wa
L1379:
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
L1376:
	ld a,(_roll_t__0)
	cp a,0
	jr z,L1380
	call _roll_draw__0
	jp L1381
L1380:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L1382
	ld wa,2
	push xwa
	ld c,(_crash_timer__0)
	extz bc
	and bc,4
	cp bc,0
	jr z,L1383
	ld wa,1
	jr L1384
L1383:
	ld wa,65535
L1384:
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_car_draw
	lda xsp,(xsp+12)
	jp L1385
L1382:
	ld a,(_knock_t__0)
	cp a,0
	jr z,L1386
	ld c,(_knock_t__0)
	extz bc
	sra 2,bc
	and bc,1
	cp bc,0
	jr z,L1387
	ld wa,1
	jr L1388
L1387:
	ld wa,65535
L1388:
	ld (xsp+12),a
	ld c,(_knock_t__0)
	cp c,18
	jr uge,L1389
	ld a,(xsp+12)
	exts wa
	sll 1,wa
	jr L1390
L1389:
	ld wa,0
L1390:
	ld (xsp+14),wa
	ld c,(_offroad__0)
	cp c,0
	jr z,L1391
	ld c,(_speed__0)
	cp c,20
	jr ule,L1391
	ld wa,1
	jr L1392
L1391:
	ld wa,0
L1392:
	push xwa
	ld a,(xsp+16)
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	add wa,(xsp+22)
	push xwa
	call _id_car_draw
	lda xsp,(xsp+12)
	jr L1393
L1386:
	ld c,(_offroad__0)
	cp c,0
	jr z,L1394
	ld c,(_speed__0)
	cp c,20
	jr ule,L1394
	ld wa,1
	jr L1395
L1394:
	ld wa,0
L1395:
	push xwa
	ld a,(_car_lean__0)
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_car_draw
	lda xsp,(xsp+12)
L1393:
L1385:
L1381:
	ld c,(_knock_t__0)
	cp c,0
	jr z,L1396
	ld c,(_knock_t__0)
	cp c,5
	jr uge,L1396
	ld wa,1
	jr L1397
L1396:
	ld wa,0
L1397:
	push xwa
	ld c,(_skid__0)
	cp c,0
	jr nz,L1400
	ld c,(_knock_t__0)
	cp c,0
	jr z,L1398
	ld c,(_knock_t__0)
	cp c,20
	jr uge,L1398
	ld c,(_speed__0)
	cp c,30
	jr ule,L1398
L1400:
	ld c,(_crash_timer__0)
	cp c,0
	jr nz,L1398
	ld c,(_state__0)
	cp c,2
	jr nz,L1398
	ld wa,1
	jr L1399
L1398:
	ld wa,0
L1399:
	push xwa
	call _smoke_draw__0
	lda xsp,(xsp+8)
	ld a,(_offroad__0)
	cp a,0
	jr z,L1401
	ld a,(_state__0)
	cp a,2
	jr nz,L1401
	incb 1,(_dbg_off)
L1401:
	ld a,(_state__0)
	cp a,2
	jr z,L1403
	ld a,(_state__0)
	cp a,1
	jr z,L1403
	ld a,(_state__0)
	cp a,3
	jr z,L1403
	ld a,(_state__0)
	cp a,4
	jr nz,L1402
L1403:
	call _engine_sound__0
	jr L1404
L1402:
	call _player_engine_off
L1404:
	call _frame_commit__0
L1351:
L1352:
	jp L1349
L1350:
L1342:
	lda xsp,(xsp+16)
	pop xiz
	ret

; function player_engine
_player_engine:
	ld wa,(xsp+4)
	ld (_eng_div__10),wa
	ld a,(xsp+8)
	ld (_eng_attn__10),a
	ldb (_eng_on__10),1
L1406:
	ret

; function player_engine_off
_player_engine_off:
	ldb (_eng_on__10),0
L1408:
	ret

; function player_init
_player_init:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,28672
	ld xix,xwa
	ldw (0B8h),43690
	ld izl,0
	jr L1422
L1419:
	ld xwa,_z80drv__10
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
L1421:
	inc 1,izl
L1422:
	ld a,izl
	cp a,65
	jr ult,L1419
L1420:
	ldw (0B8h),21845
	ld izl,0
	jr L1426
L1423:
	ld wa,0
	ld xbc,_want_div__10
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,15
	ld xbc,_want_attn__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,65535
	ld xbc,_sent_div__10
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,255
	ld xbc,_sent_attn__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_sfx_frames__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_voice__10
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+15),a
L1425:
	inc 1,izl
L1426:
	ld a,izl
	cp a,4
	jr ult,L1423
L1424:
	ldb (_playing__10),0
	ld a,(_g_vb_counter)
	ld (_last_vbl__10),a
L1418:
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
	jp L1436
L1433:
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	ld xbc,_voice__10
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
	ld xbc,_voice__10
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+4),xwa
	ld wa,0
	ld xbc,_voice__10
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+8),wa
	ld a,2
	ld xbc,_voice__10
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+13),a
	ld a,0
	ld xbc,_voice__10
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+14),a
	ld a,0
	ld xbc,_voice__10
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+15),a
	ld a,0
	ld xbc,_voice__10
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+12),a
	ld a,0
	ld xbc,_voice__10
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+16),a
L1435:
	inc 1,izl
L1436:
	ld a,izl
	cp a,4
	jp ult,L1433
L1434:
	ldb (_playing__10),1
	ld a,(_g_vb_counter)
	ld (_last_vbl__10),a
L1432:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function player_stop
_player_stop:
	push xiz
	lda xsp,(xsp-2)
	ldb (_playing__10),0
	ld izl,0
	jr L1446
L1443:
	ld a,0
	ld xbc,_voice__10
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+15),a
L1445:
	inc 1,izl
L1446:
	ld a,izl
	cp a,4
	jr ult,L1443
L1444:
L1442:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function voice_events
_voice_events__10:
	push xiz
	lda xsp,(xsp-2)
	ld xiz,(xsp+10)
	ld wa,0
	ld (xsp+0),a
	jp L1463
L1461:
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld ixl,a
	incb 1,(xsp+0)
	ld a,ixl
	cp a,0
	jr nz,L1464
	ld xwa,(xiz+4)
	ld (xiz),xwa
	jp L1463
L1464:
	ld a,ixl
	cp a,240
	jr nz,L1465
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld (xiz+13),a
	jp L1463
L1465:
	ld a,ixl
	cp a,244
	jr nz,L1466
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld (xiz+14),a
	ld a,(xiz+14)
	cp a,17
	jr ule,L1467
	ldb (xiz+14),0
L1467:
	jr L1463
L1466:
	ld a,ixl
	cp a,255
	jr nz,L1468
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	extz wa
	ld (xiz+8),wa
	ldb (xiz+15),0
	jr L1463
L1468:
	ld a,ixl
	cp a,240
	jr ult,L1469
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	jr L1463
L1469:
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
	jr nz,L1470
	ld a,ixl
	extz wa
	sub wa,1
	and wa,7
	ld (xiz+10),wa
	ldb (xiz+16),1
	jr L1471
L1470:
	push xix
	ld a,ixl
	push xwa
	call _note_div
	lda xsp,(xsp+4)
	pop xix
	ld (xiz+10),wa
L1471:
L1463:
	ld wa,(xiz+8)
	cp wa,0
	jr nz,L1472
	ld a,(xsp+0)
	cp a,32
	jp ult,L1461
L1472:
L1462:
L1460:
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
	jr ule,L1476
	ld izl,50
L1476:
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
	jr L1475
L1475:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function flush
_flush__10:
	push xiz
	lda xsp,(xsp-10)
	ld wa,0
	ld (xsp+0),a
	ld xwa,28676
	ld xiy,xwa
	ld a,(07003h)
	cp a,0
	jr z,L1493
	jp L1492
L1493:
	ld izl,0
	jp L1497
L1494:
	ld xwa,_want_div__10
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld ix,wa
	ld xwa,_want_attn__10
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+8),a
	ld a,izl
	cp a,3
	jr uge,L1498
	ld wa,ix
	ld xbc,_sent_div__10
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L1499
	ld a,(xsp+8)
	ld xbc,_sent_attn__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr nz,L1499
	jp L1496
L1499:
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
	jr L1500
L1498:
	ld a,(_noise_trig__10)
	cp a,0
	jr nz,L1501
	ld wa,ix
	cp wa,(_sent_div__10+6)
	jr nz,L1501
	ld a,(xsp+8)
	cp a,(_sent_attn__10+3)
	jr nz,L1501
	jp L1496
L1501:
	ld a,(_noise_trig__10)
	cp a,0
	jr nz,L1503
	ld wa,ix
	cp wa,(_sent_div__10+6)
	jr z,L1502
L1503:
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
	jr L1504
L1502:
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
L1504:
	ld a,240
	ld c,(xsp+8)
	and c,15
	or a,c
	ld (xiy+2),a
	ldb (_noise_trig__10),0
L1500:
	ld wa,ix
	ld xbc,_sent_div__10
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+8)
	ld xbc,_sent_attn__10
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
L1496:
	inc 1,izl
L1497:
	ld a,izl
	cp a,4
	jr uge,L1505
	ld a,(xsp+0)
	cp a,5
	jp ult,L1494
L1505:
L1495:
	ld a,(xsp+0)
	cp a,0
	jr z,L1506
	ld a,(xsp+0)
	ld (07003h),a
L1506:
L1492:
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
	sub a,(_last_vbl__10)
	ld iyl,a
	ld a,(xsp+0)
	ld (_last_vbl__10),a
	ld a,iyl
	cp a,8
	jr ule,L1529
	ld iyl,8
L1529:
	ld izl,0
	jp L1533
L1530:
	ld wa,15
	ld (xsp+3),a
	ld xwa,_want_div__10
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+4),wa
	ld a,(_playing__10)
	cp a,0
	jp z,L1534
	ld xwa,_voice__10
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
	jr ule,L1535
	ld wa,(xix+8)
	ld c,iyl
	extz bc
	sub wa,bc
	ld (xix+8),wa
	jr L1536
L1535:
	ldw (xix+8),0
	push xix
	push xiy
	ld a,izl
	push xwa
	ld xwa,xix
	push xwa
	call _voice_events__10
	lda xsp,(xsp+8)
	pop xiy
	pop xix
L1536:
	ld a,(xix+12)
	cp a,250
	jr uge,L1537
	ld a,(xix+12)
	add a,iyl
	ld (xix+12),a
L1537:
	ld a,(xix+15)
	cp a,0
	jr z,L1538
	ld xwa,_inst_tab__10
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
	jr ule,L1539
	ld xwa,(xsp+10)
	ld a,(xwa+1)
	ld (xsp+14),a
L1539:
	ld a,(xix+13)
	add a,(xsp+14)
	ld (xsp+3),a
	ld a,(xsp+3)
	cp a,15
	jr ule,L1540
	ldb (xsp+3),15
L1540:
	ld wa,(xix+10)
	ld (xsp+4),wa
	ld a,izl
	cp a,3
	jr nz,L1541
	ld a,(xix+16)
	cp a,0
	jr z,L1541
	ldb (xix+16),0
	ldb (_noise_trig__10),1
L1541:
L1538:
L1534:
	ld a,izl
	cp a,2
	jr nz,L1542
	ld a,(_eng_on__10)
	cp a,0
	jr z,L1542
	ld wa,(_eng_div__10)
	ld (xsp+4),wa
	ld a,(_eng_attn__10)
	ld (xsp+3),a
L1542:
	ld xwa,_sfx_frames__10
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L1543
	ld xwa,_sfx_attn__10
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+6),a
	ld xwa,_sfx_decay__10
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L1544
	ld xwa,_sfx_age__10
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	exts xwa
	ld xbc,_sfx_decay__10
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
	jr ule,L1545
	ldb (xsp+6),15
L1545:
L1544:
	ld a,(xsp+6)
	ld (xsp+3),a
	ld xwa,_sfx_div__10
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+4),wa
	ld xwa,_sfx_div__10
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_sfx_step__10
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
	ld xbc,_sfx_div__10
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_sfx_age__10
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,250
	jr uge,L1546
	ld xwa,_sfx_age__10
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	add a,iyl
	ld xbc,_sfx_age__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1546:
	ld xbc,_sfx_frames__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp c,iyl
	jr ule,L1547
	ld xwa,_sfx_frames__10
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	sub a,iyl
	extz wa
	jr L1548
L1547:
	ld wa,0
L1548:
	ld xbc,_sfx_frames__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1543:
	ld wa,(xsp+4)
	ld xbc,_want_div__10
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+3)
	ld xbc,_want_attn__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1532:
	inc 1,izl
L1533:
	ld a,izl
	cp a,4
	jp ult,L1530
L1531:
	push xix
	push xiy
	call _flush__10
	pop xiy
	pop xix
L1528:
	lda xsp,(xsp+16)
	pop xiz
	ret

; function player_sfx_tone
_player_sfx_tone:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld wa,(xsp+12)
	ld xbc,_sfx_div__10
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+16)
	ld xbc,_sfx_step__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+20)
	ld xbc,_sfx_attn__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+24)
	ld xbc,_sfx_frames__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+28)
	ld xbc,_sfx_decay__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_sfx_age__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1550:
	pop xiz
	ret

; function player_sfx_noise
_player_sfx_noise:
	ld a,(xsp+4)
	extz wa
	ld (_sfx_div__10+6),wa
	ldb (_sfx_step__10+3),0
	ld a,(xsp+8)
	ld (_sfx_attn__10+3),a
	ld a,(xsp+12)
	ld (_sfx_frames__10+3),a
	ld a,(xsp+16)
	ld (_sfx_decay__10+3),a
	ldb (_sfx_age__10+3),0
	ldb (_noise_trig__10),1
L1552:
	ret

; function banner_init
_banner_init:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,41520
	ld xix,xwa
	ld izl,0
	jr L1562
L1559:
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
L1561:
	inc 1,izl
L1562:
	ld a,izl
	cp a,40
	jr ult,L1559
L1560:
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
	ld (_car_d__11),wa
	ldb (_b_on__11),0
L1558:
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
	jr ult,L1566
	ld izl,0
L1566:
	ld wa,4095
	push xwa
	ld xwa,_b_band__11
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_b_edge__11
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
	ld xwa,_b_text__11
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld wa,2730
	push xwa
	ld xwa,_b_shad__11
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
L1565:
	pop xiz
	ret

; function erase
_erase__11:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_b_on__11)
	cp a,0
	jr nz,L1578
	jr L1577
L1578:
	ld a,(_b_r0__11)
	ld ixl,a
	jr L1582
L1579:
	ld a,(_b_c0__11)
	ld izl,a
	jr L1586
L1583:
	ld wa,0
	ld xbc,_ovl_grid
	ld e,ixl
	sub e,2
	extz de
	mul xde,20
	ld l,izl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1585:
	inc 1,izl
L1586:
	ld a,izl
	cp a,(_b_c1__11)
	jr ule,L1583
L1584:
L1581:
	inc 1,ixl
L1582:
	ld a,ixl
	cp a,(_b_foot__11)
	jr ule,L1579
L1580:
	push xix
	ld a,(_b_c1__11)
	push xwa
	ld a,(_b_c0__11)
	push xwa
	ld a,(_b_foot__11)
	push xwa
	ld a,(_b_r0__11)
	push xwa
	call _ovl_mark
	lda xsp,(xsp+16)
	pop xix
	ldb (_b_on__11),0
L1577:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function banner_hide
_banner_hide:
	call _erase__11
	ld a,(_b_spr__11)
	cp a,0
	jr z,L1590
	ld a,64
	push xwa
	ld a,58
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	ldb (_b_spr__11),0
L1590:
L1589:
	ret

; function banner_dirty
_banner_dirty:
	ld a,(_b_on__11)
	cp a,0
	jr z,L1594
	ld a,(_b_c1__11)
	push xwa
	ld a,(_b_c0__11)
	push xwa
	ld a,(_b_foot__11)
	push xwa
	ld a,(_b_r0__11)
	push xwa
	call _ovl_touch
	lda xsp,(xsp+16)
L1594:
	ldb (_b_r0__11),255
L1593:
	ret

; function banner_active
_banner_active:
	ld a,(_b_on__11)
	jr L1596
L1596:
	ret

; function banner_show
_banner_show:
	push xiz
	lda xsp,(xsp-46)
	ld wa,(xsp+54)
	cp wa,0
	jr lt,L1651
	ld wa,(xsp+54)
	cp wa,1400
	jr le,L1650
L1651:
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1649
L1650:
	push xix
	push xiy
	ld wa,(xsp+62)
	add wa,(_car_d__11)
	push xwa
	call _id_road_line_at_distance
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (xsp+6),a
	ld a,(xsp+6)
	cp a,255
	jr nz,L1652
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1649
L1652:
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
	jr lt,L1654
	ld wa,(xsp+18)
	cp wa,151
	jr le,L1653
L1654:
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1649
L1653:
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
	jr uge,L1655
	ld a,(xsp+7)
	ld iyl,a
L1655:
	ld wa,(xsp+2)
	sra 3,wa
	ld (xsp+11),a
	ld a,(xsp+11)
	cp a,18
	jr ule,L1656
	ldb (xsp+11),18
L1656:
	ld bc,(xsp+20)
	cp bc,0
	jr ge,L1657
	ld wa,0
	jr L1658
L1657:
	ld bc,(xsp+20)
	sra 3,bc
	cp bc,19
	jr le,L1659
	ld wa,19
	jr L1660
L1659:
	ld wa,(xsp+20)
	sra 3,wa
L1660:
L1658:
	ld (xsp+9),a
	ld bc,(xsp+22)
	cp bc,0
	jr ge,L1661
	ld wa,0
	jr L1662
L1661:
	ld bc,(xsp+22)
	sra 3,bc
	cp bc,19
	jr le,L1663
	ld wa,19
	jr L1664
L1663:
	ld wa,(xsp+22)
	sra 3,wa
L1664:
L1662:
	ld (xsp+10),a
	ld a,(_b_on__11)
	cp a,0
	jr z,L1666
	ld a,(xsp+7)
	cp a,(_b_r0__11)
	jr nz,L1666
	ld a,iyl
	cp a,(_b_r1__11)
	jr nz,L1666
	ld a,(xsp+9)
	cp a,(_b_c0__11)
	jr nz,L1666
	ld a,(xsp+10)
	cp a,(_b_c1__11)
	jr nz,L1666
	ld a,(xsp+11)
	cp a,(_b_foot__11)
	jp z,L1665
L1666:
	push xix
	push xiy
	call _erase__11
	pop xiy
	pop xix
	ld a,(xsp+7)
	ld izl,a
	jp L1670
L1667:
	ld a,(xsp+9)
	ld ixl,a
	jr L1674
L1671:
	ld wa,36
	ld (xsp+26),wa
	ld a,(xsp+58)
	cp a,0
	jr z,L1675
	ld a,ixl
	cp a,(xsp+9)
	jr z,L1676
	ld a,ixl
	cp a,(xsp+10)
	jr nz,L1675
L1676:
	ldw (xsp+26),42
	jr L1677
L1675:
	ld a,izl
	cp a,(xsp+7)
	jr nz,L1678
	ld a,iyl
	cp a,(xsp+7)
	jr ule,L1678
	ldw (xsp+26),35
	jr L1679
L1678:
	ld a,izl
	cp a,iyl
	jr nz,L1680
	ld a,iyl
	cp a,(xsp+7)
	jr ule,L1680
	ldw (xsp+26),37
L1680:
L1679:
L1677:
	ld wa,(xsp+26)
	or wa,5120
	ld xbc,_ovl_grid
	ld e,izl
	sub e,2
	extz de
	mul xde,20
	ld l,ixl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1673:
	inc 1,ixl
L1674:
	ld a,ixl
	cp a,(xsp+10)
	jp ule,L1671
L1672:
L1669:
	inc 1,izl
L1670:
	ld a,izl
	cp a,iyl
	jp ule,L1667
L1668:
	ld a,iyl
	add a,1
	ld izl,a
	jr L1684
L1681:
	ld wa,(xsp+20)
	cp wa,0
	jr lt,L1685
	ld wa,5158
	ld xbc,_ovl_grid
	ld e,izl
	sub e,2
	extz de
	mul xde,20
	ld l,(xsp+9)
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1685:
	ld wa,(xsp+22)
	cp wa,160
	jr ge,L1686
	ld wa,5158
	ld xbc,_ovl_grid
	ld e,izl
	sub e,2
	extz de
	mul xde,20
	ld l,(xsp+10)
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1686:
L1683:
	inc 1,izl
L1684:
	ld a,izl
	cp a,(xsp+11)
	jr ule,L1681
L1682:
	push xix
	push xiy
	ld a,(xsp+18)
	push xwa
	ld a,(xsp+21)
	push xwa
	ld a,(xsp+27)
	push xwa
	ld a,(xsp+27)
	push xwa
	call _ovl_mark
	lda xsp,(xsp+16)
	pop xiy
	pop xix
	ldb (_b_on__11),1
	ld a,(xsp+7)
	ld (_b_r0__11),a
	ld a,iyl
	ld (_b_r1__11),a
	ld a,(xsp+9)
	ld (_b_c0__11),a
	ld a,(xsp+10)
	ld (_b_c1__11),a
	ld a,(xsp+11)
	ld (_b_foot__11),a
L1665:
	ldb (xsp+14),0
	jr L1689
L1687:
	incb 1,(xsp+14)
L1689:
	ld xwa,(xsp+62)
	ld c,(xsp+14)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L1690
	ld a,(xsp+14)
	cp a,6
	jr ult,L1687
L1690:
L1688:
	ld wa,2
	mul xwa,(xsp+24)
	add wa,8
	ld c,(xsp+14)
	extz bc
	sll 3,bc
	cp wa,bc
	jr ge,L1691
	ldb (xsp+14),0
L1691:
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
	jp L1695
L1692:
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
	jr lt,L1697
	ld wa,(xsp+32)
	cp wa,159
	jr le,L1696
L1697:
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
	jp L1694
L1696:
L1698:
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
	ld xwa,_spr_shadow
	ld c,(xsp+35)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
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
	ld xbc,_spr_pal_shadow
	ld e,(xsp+35)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1700:
L1699:
L1694:
	incb 1,(xsp+15)
L1695:
	ld a,(xsp+15)
	cp a,(xsp+14)
	jp ult,L1692
L1693:
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
	ldb (_b_spr__11),1
L1649:
	lda xsp,(xsp+46)
	pop xiz
	ret

; function bridge_init
_bridge_init:
	push xiz
	lda xsp,(xsp-8)
	ld xwa,41984
	ld xiy,xwa
	ld izl,0
	jr L1723
L1720:
	ld xwa,_gfx_bridge_tiles
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,xiy
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1722:
	inc 1,izl
L1723:
	ld a,izl
	cp a,8
	jr ult,L1720
L1721:
	ld xwa,42416
	ld xiy,xwa
	ld izl,0
	jr L1727
L1724:
	ld xwa,_gfx_bridge_tiles
	ld bc,8
	ld e,izl
	extz de
	add bc,de
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,xiy
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1726:
	inc 1,izl
L1727:
	ld a,izl
	cp a,40
	jr ult,L1724
L1725:
	ld ixl,0
	jr L1732
L1729:
	ld wa,40960
	extz xwa
	ld xbc,_slim__12_L1728
	ld e,ixl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	muls xbc,16
	add xwa,xbc
	ld xiy,xwa
	ld izl,0
	jr L1736
L1733:
	ld xwa,_gfx_bridge_tiles
	ld bc,6
	ld e,ixl
	extz de
	add bc,de
	sll 3,bc
	ld e,izl
	extz de
	add bc,de
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,xiy
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1735:
	inc 1,izl
L1736:
	ld a,izl
	cp a,8
	jr ult,L1733
L1734:
L1731:
	inc 1,ixl
L1732:
	ld a,ixl
	cp a,6
	jr ult,L1729
L1730:
	push xix
	push xiy
	ld wa,147
	push xwa
	call _id_road_distance_at_line
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (_car_d__12),wa
L1719:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function clear_box
_clear_box__12:
	ld a,(_bb_r0__12)
	cp a,255
	jr nz,L1740
	jr L1739
L1740:
	ld a,(_bb_c1__12)
	push xwa
	ld a,(_bb_c0__12)
	push xwa
	ld a,(_bb_r1__12)
	push xwa
	ld a,(_bb_r0__12)
	push xwa
	call _ovl_clear
	lda xsp,(xsp+16)
	ld a,(_bb_c1__12)
	push xwa
	ld a,(_bb_c0__12)
	push xwa
	ld a,(_bb_r1__12)
	push xwa
	ld a,(_bb_r0__12)
	push xwa
	call _ovl_mark
	lda xsp,(xsp+16)
	ldb (_bb_r0__12),255
L1739:
	ret

; function bridge_hide
_bridge_hide:
	call _clear_box__12
	ldw (_sig_prev__12),65535
	ldb (_bridge_line),0
L1742:
	ret

; function bridge_setup
_bridge_setup:
	push xiz
	lda xsp,(xsp-14)
	ld wa,0
	ld ix,wa
	ld wa,0
	ld (xsp+2),wa
	ld wa,0
	ld (xsp+4),wa
	ld wa,0
	ld (xsp+7),a
	push xix
	push xiy
	call _bridge_hide
	pop xiy
	pop xix
	push xix
	push xiy
	ld wa,3020
	push xwa
	ld wa,1912
	push xwa
	ld wa,802
	push xwa
	ld wa,0
	push xwa
	ld wa,11
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xiy
	pop xix
	ldb (_br_n__12),0
	ld xwa,_gfx_themes
	ld xbc,_leg_theme
	ld e,(_cur_leg)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	muls xbc,20
	add xwa,xbc
	ld a,(xwa+19)
	cp a,0
	jr nz,L1763
	jp L1762
L1763:
	ld iyl,0
	jr L1767
L1764:
	ld xwa,(_track_seg)
	ld c,iyl
	extz bc
	muls xbc,6
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+8),xwa
	ld a,(xsp+7)
	cp a,0
	jr nz,L1768
	ld xwa,(xsp+8)
	ld wa,(xwa)
	cp wa,1010
	jr nz,L1768
	ldb (xsp+7),1
	ld wa,ix
	ld (xsp+2),wa
	ld izl,0
	jr L1772
L1769:
	ld wa,(xsp+4)
	ld xbc,(_track_seg)
	ld e,iyl
	add e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld (xsp+4),wa
L1771:
	inc 1,izl
L1772:
	ld a,izl
	cp a,4
	jr uge,L1773
	ld a,iyl
	add a,izl
	cp a,(_track_len)
	jr ult,L1769
L1773:
L1770:
L1768:
	ld wa,ix
	ld xbc,(xsp+8)
	ld bc,(xbc)
	add wa,bc
	ld ix,wa
L1766:
	inc 1,iyl
L1767:
	ld a,iyl
	cp a,(_track_len)
	jr uge,L1774
	ld wa,ix
	cp wa,(_leg_len)
	jp ult,L1764
L1774:
L1765:
	ld a,(xsp+7)
	cp a,0
	jr nz,L1775
	jr L1762
L1775:
	ld wa,(xsp+2)
	add wa,150
	ld ix,wa
	jr L1779
L1776:
	ld wa,ix
	ld xbc,_br_at__12
	ld e,(_br_n__12)
	incb 1,(_br_n__12)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1778:
	ld wa,ix
	add wa,260
	ld ix,wa
L1779:
	ld wa,ix
	add wa,100
	ld bc,(xsp+2)
	add bc,(xsp+4)
	cp wa,bc
	jr uge,L1780
	ld a,(_br_n__12)
	cp a,12
	jr ult,L1776
L1780:
L1777:
L1762:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function clamp_col
_clamp_col__12:
	push xiz
	ld iz,(xsp+8)
	ld wa,iz
	cp wa,0
	jr ge,L1785
	ld wa,0
	jr L1784
L1785:
	ld wa,iz
	cp wa,159
	jr le,L1786
	ld wa,19
	jr L1784
L1786:
	ld wa,iz
	sra 3,wa
	jr L1784
L1784:
	pop xiz
	ret

; function bridge_draw
_bridge_draw:
	push xiz
	lda xsp,(xsp-148)
	ld wa,0
	ld (xsp+2),wa
	ld wa,0
	ld iyl,a
	ldb (_bridge_line),0
	ld a,(_br_n__12)
	cp a,0
	jr nz,L1884
	jp L1883
L1884:
	ldb (xsp+0),0
	jp L1888
L1885:
	ld xwa,_br_at__12
	ld c,(xsp+0)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	sub wa,(xsp+156)
	ld (xsp+126),wa
	ld wa,(xsp+126)
	cp wa,0
	jr le,L1890
	ld wa,(xsp+126)
	cp wa,1450
	jr le,L1889
L1890:
	jp L1887
L1889:
	push xix
	push xiy
	ld wa,(xsp+134)
	add wa,(_car_d__12)
	push xwa
	call _id_road_line_at_distance
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (xsp+134),a
	ld a,(xsp+134)
	cp a,255
	jr nz,L1891
	jp L1887
L1891:
	push xix
	push xiy
	lda xwa,(xsp+136)
	push xwa
	ld a,(xsp+146)
	push xwa
	call _id_road_sprite_sample
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	ld a,(xsp+132)
	extz wa
	ld (xsp+136),wa
	ld a,(xsp+132)
	extz wa
	ld c,(xsp+132)
	extz bc
	extz xbc
	div xbc,6
	add wa,bc
	add wa,3
	ld (xsp+138),wa
	ld a,(xsp+132)
	extz wa
	extz xwa
	div xwa,3
	ld (xsp+140),wa
	ld wa,(xsp+130)
	ld (xsp+146),wa
	ld wa,(xsp+146)
	cp wa,151
	jr le,L1892
	ldw (xsp+146),151
L1892:
	ld wa,(xsp+146)
	sub wa,(xsp+136)
	ld bc,(xsp+136)
	sra 3,bc
	sub wa,bc
	ld (xsp+144),wa
	ld wa,(xsp+144)
	sub wa,(xsp+140)
	ld (xsp+142),wa
	ld wa,(xsp+144)
	cp wa,20
	jr ge,L1893
	jp L1887
L1893:
	ld a,(_bridge_line)
	cp a,0
	jr nz,L1894
	ld a,(xsp+146)
	ld (_bridge_line),a
L1894:
	ld bc,(xsp+140)
	cp bc,4
	jr ge,L1895
	ld wa,2
	jr L1896
L1895:
	ld bc,(xsp+140)
	cp bc,8
	jr ge,L1897
	ld wa,1
	jr L1898
L1897:
	ld wa,0
L1898:
L1896:
	lda xbc,(xsp+113)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	lda xwa,(xsp+113)
	ld c,iyl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L1899
	ld wa,(xsp+144)
	sub wa,1
	sra 3,wa
	lda xbc,(xsp+17)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	lda xwa,(xsp+17)
	ld c,iyl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	lda xbc,(xsp+5)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	lda xwa,(xsp+17)
	ld c,iyl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,2
	jr uge,L1900
	jp L1887
L1900:
	jr L1901
L1899:
	ld bc,(xsp+142)
	cp bc,16
	jr ge,L1902
	ld wa,2
	jr L1903
L1902:
	ld wa,(xsp+142)
	sra 3,wa
	extz wa
L1903:
	lda xbc,(xsp+5)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+144)
	sub wa,1
	sra 3,wa
	lda xbc,(xsp+17)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	lda xwa,(xsp+17)
	ld c,iyl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	lda xbc,(xsp+5)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr uge,L1904
	lda xwa,(xsp+5)
	ld c,iyl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	lda xbc,(xsp+17)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1904:
L1901:
	ld wa,(xsp+146)
	sra 3,wa
	lda xbc,(xsp+29)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	lda xwa,(xsp+29)
	ld c,iyl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,18
	jr ule,L1905
	ld a,18
	lda xbc,(xsp+29)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1905:
	ld bc,(xsp+128)
	sub bc,(xsp+138)
	sub bc,1
	cp bc,0
	jr lt,L1906
	ld wa,1
	jr L1907
L1906:
	ld wa,0
L1907:
	lda xbc,(xsp+89)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld bc,(xsp+128)
	add bc,(xsp+138)
	cp bc,159
	jr gt,L1908
	ld wa,1
	jr L1909
L1908:
	ld wa,0
L1909:
	lda xbc,(xsp+101)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	push xix
	push xiy
	ld wa,(xsp+136)
	sub wa,(xsp+146)
	sub wa,1
	push xwa
	call _clamp_col__12
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	lda xbc,(xsp+53)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	push xix
	push xiy
	ld wa,(xsp+136)
	add wa,(xsp+146)
	push xwa
	call _clamp_col__12
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	lda xbc,(xsp+65)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	lda xbc,(xsp+113)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp c,0
	jr z,L1910
	lda xwa,(xsp+53)
	ld c,iyl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L1911
L1910:
	push xix
	push xiy
	ld wa,(xsp+136)
	sub wa,(xsp+146)
	sub wa,(xsp+148)
	push xwa
	call _clamp_col__12
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	extz wa
L1911:
	lda xbc,(xsp+41)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	lda xbc,(xsp+113)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp c,0
	jr z,L1912
	lda xwa,(xsp+65)
	ld c,iyl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L1913
L1912:
	push xix
	push xiy
	ld wa,(xsp+136)
	add wa,(xsp+146)
	add wa,(xsp+148)
	push xwa
	call _clamp_col__12
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	extz wa
L1913:
	lda xbc,(xsp+77)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+2)
	mul xwa,31
	lda xbc,(xsp+5)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	lda xbc,(xsp+17)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	sll 5,bc
	add wa,bc
	lda xbc,(xsp+41)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	sll 9,bc
	add wa,bc
	lda xbc,(xsp+77)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	sll 3,bc
	add wa,bc
	lda xbc,(xsp+29)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	lda xbc,(xsp+53)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	lda xbc,(xsp+65)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	lda xbc,(xsp+113)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	sll 12,bc
	add wa,bc
	ld (xsp+2),wa
	inc 1,iyl
L1887:
	incb 1,(xsp+0)
L1888:
	ld a,(xsp+0)
	ld c,(_br_n__12)
	cp a,c
	jp lt,L1885
L1886:
	ld a,iyl
	cp a,0
	jr nz,L1914
	ld a,(_bb_r0__12)
	cp a,255
	jr z,L1915
	push xix
	push xiy
	call _bridge_hide
	pop xiy
	pop xix
L1915:
	jp L1883
L1914:
	ld wa,(xsp+2)
	ld c,iyl
	extz bc
	add wa,bc
	ld (xsp+2),wa
	ld wa,(xsp+2)
	cp wa,(_sig_prev__12)
	jr nz,L1916
	jp L1883
L1916:
	ld wa,(xsp+2)
	ld (_sig_prev__12),wa
	push xix
	push xiy
	call _clear_box__12
	pop xiy
	pop xix
	jp L1919
L1917:
	ld a,iyl
	sub a,1
	ld izl,a
	dec 1,iyl
	lda xwa,(xsp+113)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L1920
	lda xbc,(xsp+113)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp c,2
	jr nz,L1921
	ld wa,34
	jr L1922
L1921:
	ld wa,39
L1922:
	ld (xsp+128),wa
	lda xbc,(xsp+113)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp c,2
	jr nz,L1923
	ld wa,59
	jr L1924
L1923:
	ld wa,62
L1924:
	ld (xsp+130),wa
	lda xbc,(xsp+113)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp c,2
	jr nz,L1925
	ld wa,61
	jr L1926
L1925:
	ld wa,63
L1926:
	ld (xsp+132),wa
	ld xwa,_ovl_grid
	lda xbc,(xsp+5)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	sub c,2
	extz bc
	mul xbc,20
	lda xde,(xsp+41)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	extz de
	add bc,de
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+134),xwa
	lda xwa,(xsp+41)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld ixl,a
	jr L1930
L1927:
	ld wa,(xsp+128)
	or wa,5632
	ld xbc,(xsp+134)
	inc 2,xbc
	ld (xsp+134),xbc
	dec 2,xbc
	ld (xbc),wa
L1929:
	inc 1,ixl
L1930:
	ld a,ixl
	lda xbc,(xsp+77)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr ule,L1927
L1928:
	lda xwa,(xsp+5)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	add a,1
	ld (xsp+127),a
	jp L1934
L1931:
	lda xwa,(xsp+89)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L1935
	ld wa,(xsp+130)
	or wa,5632
	ld xbc,_ovl_grid
	ld e,(xsp+127)
	sub e,2
	extz de
	mul xde,20
	lda xhl,(xsp+41)
	push xde
	ld e,izl
	extz de
	exts xde
	add xhl,xde
	pop xde
	ld l,(xhl)
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1935:
	lda xwa,(xsp+101)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L1936
	ld wa,(xsp+132)
	or wa,5632
	ld xbc,_ovl_grid
	ld e,(xsp+127)
	sub e,2
	extz de
	mul xde,20
	lda xhl,(xsp+77)
	push xde
	ld e,izl
	extz de
	exts xde
	add xhl,xde
	pop xde
	ld l,(xhl)
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1936:
L1933:
	incb 1,(xsp+127)
L1934:
	ld a,(xsp+127)
	lda xbc,(xsp+29)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp ule,L1931
L1932:
	jp L1937
L1920:
	lda xwa,(xsp+5)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+127),a
	jp L1941
L1938:
	ld c,(xsp+127)
	lda xde,(xsp+17)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1942
	lda xbc,(xsp+17)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	lda xde,(xsp+5)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr ule,L1942
	ld wa,92
	jr L1943
L1942:
	ld c,(xsp+127)
	lda xde,(xsp+5)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1944
	ld wa,64
	jr L1945
L1944:
	ld wa,91
L1945:
L1943:
	ld (xsp+128),wa
	ld xwa,_ovl_grid
	ld c,(xsp+127)
	sub c,2
	extz bc
	mul xbc,20
	lda xde,(xsp+41)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	extz de
	add bc,de
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+130),xwa
	lda xwa,(xsp+17)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	lda xbc,(xsp+5)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr nz,L1946
	ldw (xsp+128),92
L1946:
	lda xwa,(xsp+41)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld ixl,a
	jr L1950
L1947:
	ld wa,(xsp+128)
	or wa,5632
	ld xbc,(xsp+130)
	inc 2,xbc
	ld (xsp+130),xbc
	dec 2,xbc
	ld (xbc),wa
L1949:
	inc 1,ixl
L1950:
	ld a,ixl
	lda xbc,(xsp+77)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr ule,L1947
L1948:
L1940:
	incb 1,(xsp+127)
L1941:
	ld a,(xsp+127)
	lda xbc,(xsp+17)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp ule,L1938
L1939:
	lda xwa,(xsp+17)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	add a,1
	ld (xsp+127),a
	jp L1954
L1951:
	lda xwa,(xsp+89)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L1955
	lda xwa,(xsp+41)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld ixl,a
	jp L1959
L1956:
	ld c,ixl
	lda xde,(xsp+53)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1960
	ld wa,95
	jr L1961
L1960:
	ld c,ixl
	lda xde,(xsp+41)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1962
	lda xbc,(xsp+53)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	lda xde,(xsp+41)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr ule,L1962
	ld wa,94
	jr L1963
L1962:
	ld wa,93
L1963:
L1961:
	ld (xsp+128),wa
	ld wa,(xsp+128)
	or wa,5632
	ld xbc,_ovl_grid
	ld e,(xsp+127)
	sub e,2
	extz de
	mul xde,20
	ld l,ixl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1958:
	inc 1,ixl
L1959:
	ld a,ixl
	lda xbc,(xsp+53)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp ule,L1956
L1957:
L1955:
	lda xwa,(xsp+101)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L1964
	lda xwa,(xsp+65)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld ixl,a
	jp L1968
L1965:
	ld c,ixl
	lda xde,(xsp+65)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1969
	ld wa,94
	jr L1970
L1969:
	ld c,ixl
	lda xde,(xsp+77)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1971
	lda xbc,(xsp+77)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	lda xde,(xsp+65)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr ule,L1971
	ld wa,95
	jr L1972
L1971:
	ld wa,93
L1972:
L1970:
	ld (xsp+128),wa
	ld wa,(xsp+128)
	or wa,5632
	ld xbc,_ovl_grid
	ld e,(xsp+127)
	sub e,2
	extz de
	mul xde,20
	ld l,ixl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1967:
	inc 1,ixl
L1968:
	ld a,ixl
	lda xbc,(xsp+77)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp ule,L1965
L1966:
L1964:
L1953:
	incb 1,(xsp+127)
L1954:
	ld a,(xsp+127)
	lda xbc,(xsp+29)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp ule,L1951
L1952:
L1937:
	ld a,(_bb_r0__12)
	cp a,255
	jr nz,L1973
	lda xwa,(xsp+5)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_r0__12),a
	lda xwa,(xsp+29)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_r1__12),a
	lda xwa,(xsp+41)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_c0__12),a
	lda xwa,(xsp+77)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_c1__12),a
	jp L1974
L1973:
	lda xwa,(xsp+5)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_bb_r0__12)
	jr uge,L1975
	lda xwa,(xsp+5)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_r0__12),a
L1975:
	lda xwa,(xsp+29)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_bb_r1__12)
	jr ule,L1976
	lda xwa,(xsp+29)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_r1__12),a
L1976:
	lda xwa,(xsp+41)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_bb_c0__12)
	jr uge,L1977
	lda xwa,(xsp+41)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_c0__12),a
L1977:
	lda xwa,(xsp+77)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_bb_c1__12)
	jr ule,L1978
	lda xwa,(xsp+77)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_c1__12),a
L1978:
L1974:
L1919:
	ld a,iyl
	cp a,0
	jp ugt,L1917
L1918:
	push xix
	push xiy
	ld a,(_bb_c1__12)
	push xwa
	ld a,(_bb_c0__12)
	push xwa
	ld a,(_bb_r1__12)
	push xwa
	ld a,(_bb_r0__12)
	push xwa
	call _ovl_mark
	lda xsp,(xsp+16)
	pop xiy
	pop xix
L1883:
	lda xsp,(xsp+148)
	pop xiz
	ret

; function bridge_hit
_bridge_hit:
	push xiz
	lda xsp,(xsp-4)
	ld ix,(xsp+20)
	push xix
	push xiy
	ld wa,147
	push xwa
	call _id_road_half_at
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (xsp+1),a
	ld a,(xsp+1)
	extz wa
	ld c,(xsp+1)
	extz bc
	extz xbc
	div xbc,6
	add wa,bc
	add wa,3
	ld iy,wa
	ld wa,ix
	cp wa,0
	jr ge,L1987
	ld wa,ix
	neg wa
	ld ix,wa
L1987:
	ld izl,0
	jr L1991
L1988:
	ld wa,(xsp+12)
	ld xbc,_br_at__12
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr uge,L1992
	ld wa,(xsp+16)
	ld xbc,_br_at__12
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr ult,L1992
	ld wa,ix
	add wa,14
	cp wa,iy
	jr le,L1992
	ld wa,1
	jr L1986
L1992:
L1990:
	inc 1,izl
L1991:
	ld a,izl
	cp a,(_br_n__12)
	jr ult,L1988
L1989:
	ld wa,0
	jr L1986
L1986:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function slot_offset
_slot_offset__13:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	ld izl,a
	ld xwa,(_s_offset__13)
	ld (xsp+0),xwa
	ld a,izl
	cp a,32
	jr ult,L1996
	ld xwa,(xsp+0)
	sub xwa,8192
	ld (xsp+0),xwa
	ld a,izl
	sub a,32
	ld izl,a
L1996:
	ld xwa,(xsp+0)
	ld c,izl
	extz bc
	extz xbc
	sll 8,xbc
	add xwa,xbc
	jr L1995
L1995:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function slot_ptr
_slot_ptr__13:
	ld xwa,2097152
	push xwa
	ld a,(xsp+8)
	push xwa
	call _slot_offset__13
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	add xwa,xbc
	jr L1998
L1998:
	ret

; function crc_byte
_crc_byte__13:
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
	jr L2010
L2007:
	ld bc,iz
	and bc,32768
	cp bc,0
	jr z,L2011
	ld wa,iz
	sll 1,wa
	xor wa,4129
	jr L2012
L2011:
	ld wa,iz
	sll 1,wa
L2012:
	ld iz,wa
L2009:
	inc 1,ixl
L2010:
	ld a,ixl
	cp a,8
	jr ult,L2007
L2008:
	ld wa,iz
	jr L2006
L2006:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function slot_erased
_slot_erased__13:
	push xiz
	lda xsp,(xsp-6)
	push xix
	ld a,(xsp+18)
	push xwa
	call _slot_ptr__13
	lda xsp,(xsp+4)
	pop xix
	ld xix,xwa
	ld iz,0
	jr L2023
L2020:
	ld xwa,xix
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,255
	jr z,L2024
	ld wa,0
	jr L2019
L2024:
L2022:
	inc 1,iz
L2023:
	ld wa,iz
	cp wa,256
	jr ult,L2020
L2021:
	ld wa,1
	jr L2019
L2019:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function slot_looks_valid
_slot_looks_valid__13:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	push xwa
	call _slot_ptr__13
	lda xsp,(xsp+4)
	ld xiz,xwa
	ld c,(xiz)
	cp c,202
	jr nz,L2029
	ld c,(xiz+1)
	cp c,254
	jr nz,L2029
	ld c,(xiz+2)
	cp c,32
	jr nz,L2029
	ld c,(xiz+3)
	cp c,38
	jr nz,L2029
	ld c,(xiz+254)
	cp c,74
	jr nz,L2029
	ld c,(xiz+255)
	cp c,0
	jr nz,L2029
	ld wa,1
	jr L2030
L2029:
	ld wa,0
L2030:
	jr L2028
L2028:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function slot_crc_ok
_slot_crc_ok__13:
	push xiz
	lda xsp,(xsp-8)
	push xix
	ld a,(xsp+20)
	push xwa
	call _slot_ptr__13
	lda xsp,(xsp+4)
	pop xix
	ld (xsp+0),xwa
	ld wa,65535
	ld ix,wa
	ld iz,0
	jr L2042
L2039:
	push xix
	ld xwa,(xsp+4)
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld wa,ix
	push xwa
	call _crc_byte__13
	lda xsp,(xsp+8)
	pop xix
	ld ix,wa
L2041:
	inc 1,iz
L2042:
	ld wa,iz
	cp wa,252
	jr ult,L2039
L2040:
	ld xbc,(xsp+0)
	ld c,(xbc+252)
	ld e,ixl
	cp c,e
	jr nz,L2043
	ld xbc,(xsp+0)
	ld c,(xbc+253)
	ld de,ix
	srl 8,de
	cp c,e
	jr nz,L2043
	ld wa,1
	jr L2044
L2043:
	ld wa,0
L2044:
	jr L2038
L2038:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function slot_sequence
_slot_sequence__13:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	push xwa
	call _slot_ptr__13
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
	jr L2046
L2046:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function bank_of
_bank_of__13:
	ld c,(xsp+4)
	cp c,32
	jr ult,L2051
	ld a,32
	extz wa
	jr L2052
L2051:
	ld wa,0
L2052:
	jr L2050
L2050:
	ret

; function ngpc_flash_init
_ngpc_flash_init:
	push xiz
	lda xsp,(xsp-10)
	ldb (_s_current__13),255
	ldb (_s_last_slot__13),255
	ld xwa,0
	ld (_s_sequence__13),xwa
	ld a,(06C58h)
	extz wa
	cp wa,1
	jr z,L2072
	cp wa,2
	jr z,L2073
	cp wa,3
	jr z,L2074
	jr L2075
L2072:
	ld xwa,499712
	ld (_s_offset__13),xwa
	jr L2071
L2073:
	ld xwa,1024000
	ld (_s_offset__13),xwa
	jr L2071
L2074:
	ld xwa,2072576
	ld (_s_offset__13),xwa
	jr L2071
L2075:
	ld xwa,0
	ld (_s_offset__13),xwa
	jr L2071
L2071:
	ld xwa,(_s_offset__13)
	cp xwa,0
	jr nz,L2076
	jp L2070
L2076:
	ld xwa,__DataROM_END
	ld xbc,2097152
	add xbc,(_s_offset__13)
	sub xbc,8192
	cp xwa,xbc
	jr ule,L2077
	ld xwa,0
	ld (_s_offset__13),xwa
	jr L2070
L2077:
	ld izl,0
	jr L2081
L2078:
	ld a,izl
	push xwa
	call _slot_looks_valid__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2082
	jr L2080
L2082:
	ld a,izl
	push xwa
	call _slot_sequence__13
	lda xsp,(xsp+4)
	ld (xsp+2),xwa
	ld a,(_s_current__13)
	cp a,255
	jr z,L2083
	ld xwa,(xsp+2)
	sub xwa,(_s_sequence__13)
	ld (xsp+6),xwa
	ld xwa,(xsp+6)
	cp xwa,0
	jr z,L2085
	ld xwa,(xsp+6)
	cp xwa,2147483648
	jr ult,L2084
L2085:
	jr L2080
L2084:
L2083:
	ld a,izl
	push xwa
	call _slot_crc_ok__13
	lda xsp,(xsp+4)
	cp a,0
	jr z,L2086
	ld a,izl
	ld (_s_current__13),a
	ld xwa,(xsp+2)
	ld (_s_sequence__13),xwa
L2086:
L2080:
	inc 1,izl
L2081:
	ld a,izl
	cp a,64
	jr ult,L2078
L2079:
L2070:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_flash_ready
_ngpc_flash_ready:
	ld xbc,(_s_offset__13)
	cp xbc,0
	jr z,L2091
	ld wa,1
	jr L2092
L2091:
	ld wa,0
L2092:
	jr L2090
L2090:
	ret

; function ngpc_flash_cart_size
_ngpc_flash_cart_size:
	ld a,(06C58h)
	jr L2094
L2094:
	ret

; function ngpc_flash_exists
_ngpc_flash_exists:
	ld c,(_s_current__13)
	cp c,255
	jr z,L2099
	ld wa,1
	jr L2100
L2099:
	ld wa,0
L2100:
	jr L2098
L2098:
	ret

; function ngpc_flash_load
_ngpc_flash_load:
	push xiz
	lda xsp,(xsp-10)
	ld xwa,(xsp+18)
	ld xiy,xwa
	ld a,(_s_current__13)
	cp a,255
	jr nz,L2108
	jr L2107
L2108:
	push xix
	push xiy
	ld a,(_s_current__13)
	push xwa
	call _slot_ptr__13
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld xix,xwa
	ld iz,0
	jr L2112
L2109:
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
L2111:
	inc 1,iz
L2112:
	ld wa,iz
	cp wa,256
	jr ult,L2109
L2110:
L2107:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_flash_load_legacy
_ngpc_flash_load_legacy:
	push xiz
	lda xsp,(xsp-12)
	ld xwa,(xsp+20)
	ld (xsp+0),xwa
	ld xwa,(_s_offset__13)
	cp xwa,0
	jr nz,L2126
	ld wa,0
	jp L2125
L2126:
	ldb (xsp+8),32
	jr L2129
L2127:
	push xix
	ld a,(xsp+12)
	push xwa
	call _slot_ptr__13
	lda xsp,(xsp+4)
	pop xix
	ld xix,xwa
	ld a,(xix)
	cp a,202
	jr nz,L2131
	ld a,(xix+1)
	cp a,254
	jr nz,L2131
	ld a,(xix+2)
	cp a,32
	jr nz,L2131
	ld a,(xix+3)
	cp a,38
	jr z,L2130
L2131:
	jr L2129
L2130:
	push xix
	ld a,(xsp+12)
	push xwa
	call _slot_looks_valid__13
	lda xsp,(xsp+4)
	pop xix
	cp a,0
	jr z,L2132
	push xix
	ld a,(xsp+12)
	push xwa
	call _slot_crc_ok__13
	lda xsp,(xsp+4)
	pop xix
	cp a,0
	jr z,L2132
	jr L2129
L2132:
	ld iz,0
	jr L2136
L2133:
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
L2135:
	inc 1,iz
L2136:
	ld wa,iz
	cp wa,256
	jr ult,L2133
L2134:
	ld wa,1
	jr L2125
L2129:
	ld a,(xsp+8)
	decb 1,(xsp+8)
	cp a,0
	jp ugt,L2127
L2128:
	ld wa,0
	jr L2125
L2125:
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
	ld xwa,(_s_offset__13)
	cp xwa,0
	jr z,L2147
	ld a,(_s_last_slot__13)
	cp a,255
	jr nz,L2146
L2147:
	ld wa,65535
	jr L2145
L2146:
	push xix
	push xiy
	ld a,(_s_last_slot__13)
	push xwa
	call _slot_ptr__13
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld xiy,xwa
	ld iz,0
	jr L2151
L2148:
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
	jr z,L2152
	inc 1,ix
L2152:
L2150:
	inc 1,iz
L2151:
	ld wa,iz
	cp wa,256
	jr ult,L2148
L2149:
	ld wa,ix
	jr L2145
L2145:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function ngpc_flash_slots_used
_ngpc_flash_slots_used:
	push xiz
	lda xsp,(xsp-4)
	ld wa,0
	ld (xsp+1),a
	ld c,(_s_current__13)
	cp c,255
	jr nz,L2163
	ld wa,0
	jr L2164
L2163:
	ld a,(_s_current__13)
	push xwa
	call _bank_of__13
	lda xsp,(xsp+4)
	extz wa
L2164:
	ld (xsp+2),a
	ld xwa,(_s_offset__13)
	cp xwa,0
	jr nz,L2165
	ld wa,0
	jr L2162
L2165:
	ld a,(xsp+2)
	ld izl,a
	jr L2169
L2166:
	ld a,izl
	push xwa
	call _slot_erased__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2170
	incb 1,(xsp+1)
L2170:
L2168:
	inc 1,izl
L2169:
	ld a,izl
	ld c,(xsp+2)
	add c,32
	cp a,c
	jr ult,L2166
L2167:
	ld a,(xsp+1)
	jr L2162
L2162:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function erase_bank
_erase_bank__13:
	push xiz
	lda xsp,(xsp-2)
	ld xwa,2097152
	push xwa
	ld a,(xsp+14)
	push xwa
	call _slot_offset__13
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	add xwa,xbc
	push xwa
	call _ngpc_flash_erase_asm
	lda xsp,(xsp+4)
	ld a,(xsp+10)
	ld izl,a
	jr L2181
L2178:
	ld a,izl
	push xwa
	call _slot_erased__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2182
	ld wa,0
	jr L2177
L2182:
L2180:
	inc 1,izl
L2181:
	ld a,izl
	ld c,(xsp+10)
	add c,32
	cp a,c
	jr ult,L2178
L2179:
	ld wa,1
	jr L2177
L2177:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_flash_erase
_ngpc_flash_erase:
	ld xwa,(_s_offset__13)
	cp xwa,0
	jr nz,L2188
	ld wa,0
	jr L2187
L2188:
	ld wa,0
	push xwa
	call _erase_bank__13
	lda xsp,(xsp+4)
	cp a,0
	jr z,L2190
	ld a,32
	push xwa
	call _erase_bank__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2189
L2190:
	call _ngpc_flash_init
	ld wa,0
	jr L2187
L2189:
	ldb (_s_current__13),255
	ldb (_s_last_slot__13),255
	ld xwa,0
	ld (_s_sequence__13),xwa
	ld wa,1
	jr L2187
L2187:
	ret

; function ngpc_flash_save
_ngpc_flash_save:
	push xiz
	lda xsp,(xsp-16)
	ld xwa,(xsp+24)
	ld (xsp+0),xwa
	ld wa,65535
	ld (xsp+10),wa
	ldb (_s_last_slot__13),255
	ld xwa,(_s_offset__13)
	cp xwa,0
	jr nz,L2222
	ld wa,0
	jp L2221
L2222:
	ld xwa,(xsp+0)
	ld a,(xwa)
	cp a,202
	jr nz,L2224
	ld xwa,(xsp+0)
	ld a,(xwa+1)
	cp a,254
	jr nz,L2224
	ld xwa,(xsp+0)
	ld a,(xwa+2)
	cp a,32
	jr nz,L2224
	ld xwa,(xsp+0)
	ld a,(xwa+3)
	cp a,38
	jr z,L2223
L2224:
	ld wa,0
	jp L2221
L2223:
	ld c,(_s_current__13)
	cp c,255
	jr nz,L2225
	ld wa,0
	jr L2226
L2225:
	ld a,(_s_current__13)
	push xwa
	call _bank_of__13
	lda xsp,(xsp+4)
	extz wa
L2226:
	ld (xsp+5),a
	ld c,(_s_current__13)
	cp c,255
	jr nz,L2227
	ld a,(xsp+5)
	extz wa
	jr L2228
L2227:
	ld a,(_s_current__13)
	add a,1
	extz wa
L2228:
	ld (xsp+4),a
	jr L2231
L2229:
	incb 1,(xsp+4)
L2231:
	ld a,(xsp+4)
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr uge,L2232
	ld a,(xsp+4)
	push xwa
	call _slot_erased__13
	lda xsp,(xsp+4)
	cp a,0
	jr z,L2229
L2232:
L2230:
	ld a,(xsp+4)
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr ult,L2233
	ld a,(xsp+5)
	xor a,32
	ld (xsp+5),a
	ld a,(xsp+5)
	ld izl,a
	jr L2237
L2234:
	ld a,izl
	push xwa
	call _slot_erased__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2238
	jr L2235
L2238:
L2236:
	inc 1,izl
L2237:
	ld a,izl
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr ult,L2234
L2235:
	ld a,izl
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr z,L2239
	ld a,(xsp+5)
	push xwa
	call _erase_bank__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2239
	ld wa,0
	jp L2221
L2239:
	ld a,(xsp+5)
	ld (xsp+4),a
L2233:
	ld xwa,(_s_sequence__13)
	add xwa,1
	ld (xsp+12),xwa
	ld izl,0
	jr L2243
L2240:
	ld xwa,(xsp+12)
	ld c,izl
	extz bc
	sll 3,bc
	cp c,0
	jr z,L2245
L2244:
	srl 1,xwa
	djnz c,L2244
L2245:
	ld xbc,(xsp+0)
	ld de,248
	ld l,izl
	extz hl
	add de,hl
	extz xde
	add xbc,xde
	ld (xbc),a
L2242:
	inc 1,izl
L2243:
	ld a,izl
	cp a,4
	jr ult,L2240
L2241:
	ldw (xsp+8),0
	jr L2249
L2246:
	ld xwa,(xsp+0)
	ld bc,(xsp+8)
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld wa,(xsp+14)
	push xwa
	call _crc_byte__13
	lda xsp,(xsp+8)
	ld (xsp+10),wa
L2248:
	incw 1,(xsp+8)
L2249:
	ld wa,(xsp+8)
	cp wa,252
	jr ult,L2246
L2247:
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
	ld (_s_last_slot__13),a
	ld xwa,1
	push xwa
	ld a,(xsp+8)
	push xwa
	call _slot_offset__13
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
	jr z,L2250
	ld wa,0
	jr L2221
L2250:
	ld a,(xsp+4)
	ld (_s_current__13),a
	ld xwa,(xsp+12)
	ld (_s_sequence__13),xwa
	ld wa,1
	jr L2221
L2221:
	lda xsp,(xsp+16)
	pop xiz
	ret

; function ngpc_input_vblank
_ngpc_input_vblank:
	lda xsp,(xsp-2)
	ld a,(06F82h)
	ld (xsp+0),a
	ld a,(_s_vbl_down__14)
	ld c,(xsp+0)
	ld e,(_s_vbl_prev__14)
	cpl e
	and c,e
	or a,c
	ld (_s_vbl_down__14),a
	ld a,(xsp+0)
	ld (_s_vbl_prev__14),a
L2252:
	lda xsp,(xsp+2)
	ret

; function ngpc_input_set_repeat
_ngpc_input_set_repeat:
	ld a,(xsp+4)
	ld (_s_repeat_delay__14),a
	ld a,(xsp+8)
	ld (_s_repeat_rate__14),a
L2254:
	ret

; function ngpc_input_update
_ngpc_input_update:
	lda xsp,(xsp-4)
	di
	ld a,(06F82h)
	ld (xsp+2),a
	ld a,(_s_vbl_down__14)
	ld (xsp+3),a
	ldb (_s_vbl_down__14),0
	ld a,(xsp+2)
	ld (_s_vbl_prev__14),a
	ei 0
	ld a,(xsp+2)
	ld (_ngpc_pad_held),a
	ld a,(xsp+2)
	ld c,(_s_pad_prev__14)
	cpl c
	and a,c
	or a,(xsp+3)
	ld (_ngpc_pad_pressed),a
	ld a,(xsp+2)
	cpl a
	and a,(_s_pad_prev__14)
	ld (_ngpc_pad_released),a
	ldb (_ngpc_pad_repeat),0
	ldb (xsp+1),1
	ldb (xsp+0),0
	jp L2270
L2267:
	ld a,(xsp+2)
	extz wa
	ld c,(xsp+1)
	extz bc
	and wa,bc
	cp wa,0
	jr z,L2271
	ld a,(_ngpc_pad_pressed)
	extz wa
	ld c,(xsp+1)
	extz bc
	and wa,bc
	cp wa,0
	jr z,L2272
	ld a,(_s_repeat_delay__14)
	ld xbc,_s_repeat_timer__14
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	jr L2273
L2272:
	ld xwa,_s_repeat_timer__14
	ld c,(xsp+0)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr ule,L2274
	ld xbc,_s_repeat_timer__14
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld a,(xbc)
	dec 1,a
	ld (xbc),a
	jr L2275
L2274:
	ld a,(_ngpc_pad_repeat)
	extz wa
	ld c,(xsp+1)
	extz bc
	or wa,bc
	ld (_ngpc_pad_repeat),a
	ld a,(_s_repeat_rate__14)
	ld xbc,_s_repeat_timer__14
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2275:
L2273:
	jr L2276
L2271:
	ld a,0
	ld xbc,_s_repeat_timer__14
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2276:
	ld a,(xsp+1)
	extz wa
	sll 1,wa
	ld (xsp+1),a
L2269:
	incb 1,(xsp+0)
L2270:
	ld a,(xsp+0)
	cp a,8
	jp ult,L2267
L2268:
	ld a,(xsp+2)
	ld (_s_pad_prev__14),a
L2266:
	lda xsp,(xsp+4)
	ret

; function runtime_bootstrap
_runtime_bootstrap__15:
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
	jr L2287
L2285:
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
L2287:
	ld xwa,xix
	cp xwa,(xsp+4)
	jr ult,L2285
L2286:
	jr L2290
L2288:
	ld a,0
	ld xbc,xiz
	inc 1,xbc
	ld xiz,xbc
	dec 1,xbc
	ld (xbc),a
L2290:
	ld xwa,xiz
	cp xwa,(xsp+16)
	jr ult,L2288
L2289:
L2284:
	lda xsp,(xsp+20)
	pop xiz
	ret

; function isr_dummy
_isr_dummy__15:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
L2292:
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
	ld (_g_vb_hook__15),xwa
L2294:
	ret

; function isr_vblank
_isr_vblank__15:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	ldb (06Fh),78
	ld a,(_spr_ready)
	cp a,0
	jr z,L2299
	ld xwa,128
	push xwa
	ld xwa,_spr_shadow
	push xwa
	ld xwa,34816
	push xwa
	call _ngpc_memcpy_w
	lda xsp,(xsp+12)
	ld xwa,32
	push xwa
	ld xwa,_spr_pal_shadow
	push xwa
	ld xwa,35840
	push xwa
	call _ngpc_memcpy_w
	lda xsp,(xsp+12)
	ldb (_spr_ready),0
L2299:
	ld xwa,(_g_vb_hook__15)
	cp xwa,0
	jr z,L2300
	ld xwa,(_g_vb_hook__15)
	ld xhl,xwa
	call (xhl)
L2300:
	call _ovl_vblank
	call _ngpc_vramq_flush
	incb 1,(_g_vb_counter)
	call _ngpc_input_vblank
L2298:
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
	call _runtime_bootstrap__15
	ld c,(06F91h)
	cp c,0
	jr z,L2309
	ld wa,1
	jr L2310
L2309:
	ld wa,0
L2310:
	ld (_s_is_color__15),a
	ld a,(06F87h)
	ld (_s_language__15),a
	andb (06F86h),223
	orb (06F86h),64
	call _ngpc_vramq_init
	ld xwa,_isr_dummy__15
	ld (06FB8h),xwa
	ld xwa,_isr_dummy__15
	ld (06FBCh),xwa
	ld xwa,_isr_dummy__15
	ld (06FC0h),xwa
	ld xwa,_isr_dummy__15
	ld (06FC4h),xwa
	ld xwa,_isr_dummy__15
	ld (06FC8h),xwa
	ld xwa,_isr_vblank__15
	ld (06FCCh),xwa
	ld xwa,_isr_dummy__15
	ld (06FD0h),xwa
	ld xwa,_isr_dummy__15
	ld (06FD4h),xwa
	ld xwa,_isr_dummy__15
	ld (06FD8h),xwa
	ld xwa,_isr_dummy__15
	ld (06FDCh),xwa
	ld xwa,_isr_dummy__15
	ld (06FE0h),xwa
	ld xwa,_isr_dummy__15
	ld (06FE4h),xwa
	ld xwa,_isr_dummy__15
	ld (06FE8h),xwa
	ld xwa,_isr_dummy__15
	ld (06FF0h),xwa
	ld xwa,_isr_dummy__15
	ld (06FF4h),xwa
	ld xwa,_isr_dummy__15
	ld (06FF8h),xwa
	ld xwa,_isr_dummy__15
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
	jr L2314
L2311:
	ld wa,0
	ld xbc,40960
	ld e,(xsp+0)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2313:
	incb 1,(xsp+0)
L2314:
	ld a,(xsp+0)
	cp a,8
	jr ult,L2311
L2312:
	ei
L2308:
	lda xsp,(xsp+2)
	ret

; function ngpc_is_color
_ngpc_is_color:
	ld a,(_s_is_color__15)
	jr L2316
L2316:
	ret

; function ngpc_get_language
_ngpc_get_language:
	ld a,(_s_language__15)
	jr L2318
L2318:
	ret

; function ngpc_shutdown_reason
_ngpc_shutdown_reason:
	push xiz
	lda xsp,(xsp-6)
	ld a,(xsp+14)
	extz wa
	and wa,32
	cp wa,0
	jr z,L2334
	ld iy,15
	jr L2335
L2334:
	ld a,(xsp+14)
	extz wa
	and wa,128
	cp wa,0
	jr z,L2336
	ld iy,4095
	jr L2337
L2336:
	ld a,(xsp+14)
	extz wa
	and wa,64
	cp wa,0
	jr z,L2338
	ld iy,240
	jr L2339
L2338:
	ld iy,3840
L2339:
L2337:
L2335:
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
	jr L2343
L2340:
	ld a,(_g_vb_counter)
	ld ixl,a
	jr L2346
L2344:
L2346:
	ld a,(_g_vb_counter)
	cp a,ixl
	jr z,L2344
L2345:
L2342:
	inc 1,iz
L2343:
	ld wa,iz
	cp wa,180
	jr ult,L2340
L2341:
	push xix
	push xiy
	call _ngpc_shutdown
	pop xiy
	pop xix
L2333:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_shutdown
_ngpc_shutdown:
	ldb ra3, 3
	ldb rw3, 0
	swi 1
L2348:
	ret

; function ngpc_load_sysfont
_ngpc_load_sysfont:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,41472
	ld xix,xwa
	ld iz,0
	jr L2358
L2355:
	ld xwa,_overrev_dash_tiles__15
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
L2357:
	inc 1,iz
L2358:
	ld wa,iz
	cp wa,768
	jr ult,L2355
L2356:
L2354:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_memcpy
_ngpc_memcpy:
	push xiz
	ld xix,(xsp+8)
	ld xiz,(xsp+12)
	ld iy,(xsp+16)
	jr L2366
L2364:
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
L2366:
	ld wa,iy
	dec 1,iy
	cp wa,0
	jr nz,L2364
L2365:
L2363:
	pop xiz
	ret

; function ngpc_memset
_ngpc_memset:
	push xiz
	ld xiz,(xsp+8)
	ld a,(xsp+12)
	ld iyl,a
	ld ix,(xsp+16)
	jr L2374
L2372:
	ld a,iyl
	ld xbc,xiz
	inc 1,xbc
	ld xiz,xbc
	dec 1,xbc
	ld (xbc),a
L2374:
	ld wa,ix
	dec 1,ix
	cp wa,0
	jr nz,L2372
L2373:
L2371:
	pop xiz
	ret

; function ngpc_vsync
_ngpc_vsync:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_g_vb_counter)
	ld izl,a
	jr L2385
L2383:
L2385:
	ld a,(_g_vb_counter)
	cp a,izl
	jr z,L2383
L2384:
	ld a,(06F85h)
	cp a,0
	jr z,L2386
	ld a,(06F85h)
	push xwa
	call _ngpc_shutdown_reason
	lda xsp,(xsp+4)
L2386:
L2381:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_in_vblank
_ngpc_in_vblank:
	ld c,(08010h)
	extz bc
	and bc,64
	cp bc,0
	jr z,L2391
	ld wa,1
	jr L2392
L2391:
	ld wa,0
L2392:
	jr L2390
L2390:
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
	jr L2402
L2399:
	call _ngpc_vsync
L2401:
	inc 1,izl
L2402:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L2399
L2400:
	ld wa,0
	push xwa
	call _ngpc_cpu_speed
	lda xsp,(xsp+4)
L2398:
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
L2404:
	ret

; function dst_range_ok
_dst_range_ok__17:
	push xiz
	lda xsp,(xsp-12)
	ld xwa,(xsp+20)
	cp xwa,0
	jr z,L2412
	ld wa,(xsp+24)
	cp wa,0
	jr nz,L2411
L2412:
	ld wa,0
	jr L2410
L2411:
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
	jr uge,L2413
	ld wa,0
	jr L2410
L2413:
	ld xwa,(xsp+8)
	cp xwa,49151
	jr ule,L2414
	ld wa,0
	jr L2410
L2414:
	ld wa,1
	jr L2410
L2410:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function ngpc_vramq_init
_ngpc_vramq_init:
	ldb (_s_cmd_count__17),0
	ldb (_s_drop_count__17),0
	ldb (_s_lock__17),0
L2416:
	ret

; function ngpc_vramq_copy
_ngpc_vramq_copy:
	push xiz
	lda xsp,(xsp-2)
	ld xwa,(xsp+14)
	cp xwa,0
	jr z,L2423
	ld wa,(xsp+18)
	push xwa
	ld xwa,(xsp+14)
	push xwa
	call _dst_range_ok__17
	lda xsp,(xsp+8)
	cp a,0
	jr nz,L2422
L2423:
	ld wa,0
	jp L2421
L2422:
	ldb (_s_lock__17),1
	ld a,(_s_cmd_count__17)
	ld izl,a
	ld a,izl
	cp a,16
	jr ult,L2424
	incb 1,(_s_drop_count__17)
	ldb (_s_lock__17),0
	ld wa,0
	jr L2421
L2424:
	ld xwa,(xsp+10)
	ld xbc,_s_cmd_dst__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+18)
	ld xbc,_s_cmd_len__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,(xsp+14)
	ld xbc,_s_cmd_src__17
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,0
	ld xbc,_s_cmd_fill__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,1
	ld xbc,_s_cmd_type__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,izl
	add a,1
	ld (_s_cmd_count__17),a
	ldb (_s_lock__17),0
	ld wa,1
	jr L2421
L2421:
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
	call _dst_range_ok__17
	lda xsp,(xsp+8)
	cp a,0
	jr nz,L2429
	ld wa,0
	jp L2428
L2429:
	ldb (_s_lock__17),1
	ld a,(_s_cmd_count__17)
	ld izl,a
	ld a,izl
	cp a,16
	jr ult,L2430
	incb 1,(_s_drop_count__17)
	ldb (_s_lock__17),0
	ld wa,0
	jr L2428
L2430:
	ld xwa,(xsp+10)
	ld xbc,_s_cmd_dst__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+18)
	ld xbc,_s_cmd_len__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,0
	ld xbc,_s_cmd_src__17
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,(xsp+14)
	ld xbc,_s_cmd_fill__17
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,2
	ld xbc,_s_cmd_type__17
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,izl
	add a,1
	ld (_s_cmd_count__17),a
	ldb (_s_lock__17),0
	ld wa,1
	jr L2428
L2428:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_vramq_flush
_ngpc_vramq_flush:
	push xiz
	lda xsp,(xsp-10)
	ld a,(_s_lock__17)
	cp a,0
	jr z,L2445
	jp L2444
L2445:
	ld a,(_s_cmd_count__17)
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,0
	jr nz,L2446
	jp L2444
L2446:
	ldb (_s_lock__17),1
	ld izl,0
	jp L2450
L2447:
	ld xwa,_s_cmd_dst__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	extz xwa
	ld xix,xwa
	ld xwa,_s_cmd_len__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld iy,wa
	ld xwa,_s_cmd_type__17
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,1
	jr nz,L2451
	push xix
	push xiy
	ld wa,iy
	extz xwa
	push xwa
	ld xwa,_s_cmd_src__17
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_cmd_dst__17
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
	jr L2452
L2451:
	ld xwa,_s_cmd_type__17
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,2
	jr nz,L2453
	ld xwa,_s_cmd_fill__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+8),wa
	jr L2456
L2454:
	ld wa,(xsp+8)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L2456:
	ld wa,iy
	dec 1,iy
	cp wa,0
	jr nz,L2454
L2455:
L2453:
L2452:
L2449:
	inc 1,izl
L2450:
	ld a,izl
	cp a,(xsp+1)
	jp ult,L2447
L2448:
	ldb (_s_cmd_count__17),0
	ldb (_s_lock__17),0
L2444:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_vramq_clear
_ngpc_vramq_clear:
	ld a,(_s_lock__17)
	cp a,0
	jr z,L2460
	jr L2459
L2460:
	ldb (_s_cmd_count__17),0
L2459:
	ret

; function ngpc_vramq_pending
_ngpc_vramq_pending:
	ld a,(_s_cmd_count__17)
	jr L2462
L2462:
	ret

; function ngpc_vramq_dropped
_ngpc_vramq_dropped:
	ld a,(_s_drop_count__17)
	jr L2464
L2464:
	ret

; function ngpc_vramq_clear_dropped
_ngpc_vramq_clear_dropped:
	ldb (_s_drop_count__17),0
L2466:
	ret

; function rnd16
_rnd16__18:
	ld wa,(_rs__18)
	ld bc,(_rs__18)
	sll 7,bc
	xor wa,bc
	ld (_rs__18),wa
	ld wa,(_rs__18)
	ld bc,(_rs__18)
	srl 9,bc
	xor wa,bc
	ld (_rs__18),wa
	ld wa,(_rs__18)
	ld bc,(_rs__18)
	sll 8,bc
	xor wa,bc
	ld (_rs__18),wa
	ld wa,(_rs__18)
	jr L2468
L2468:
	ret

; function rndn
_rndn__18:
	call _rnd16__18
	extz xwa
	div xwa,(xsp+4)
	ld wa,qwa
	jr L2470
L2470:
	ret

; function stage_of
_stage_of__18:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld ixl,a
	ld wa,0
	ld izl,a
	jr L2479
L2477:
	inc 1,izl
L2479:
	ld a,izl
	extz wa
	add wa,1
	cp wa,5
	jr uge,L2480
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
	jr ule,L2477
L2480:
L2478:
	ld a,izl
	jr L2476
L2476:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function put
_put__18:
	ld wa,(xsp+4)
	ld xbc,(_gp__18)
	ld e,(_gn__18)
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+8)
	ld xbc,(_gp__18)
	ld e,(_gn__18)
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+2),wa
	ld a,(xsp+12)
	ld xbc,(_gp__18)
	ld e,(_gn__18)
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+4),a
	incb 1,(_gn__18)
L2482:
	ret

; function slope_for
_slope_for__18:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	cp a,0
	jr z,L2490
	ld wa,100
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld bc,18
	ld e,(xsp+10)
	extz de
	mul xbc,de
	cp wa,bc
	jr uge,L2490
	ld wa,6
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld (xsp+0),a
	ld xwa,_slopes__18
	ld c,(xsp+0)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld izl,a
	ld a,(xsp+0)
	cp a,0
	jr nz,L2491
	ld a,(xsp+10)
	neg a
	ld izl,a
L2491:
	ld a,(xsp+0)
	cp a,3
	jr nz,L2492
	ld a,(xsp+10)
	ld izl,a
L2492:
	ld a,izl
	cp a,252
	jr ge,L2493
	ld izl,252
L2493:
	ld a,izl
	cp a,3
	jr le,L2494
	ld izl,3
L2494:
	ld a,izl
	jr L2489
L2490:
	ld wa,0
	jr L2489
L2489:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function sharp
_sharp__18:
	push xiz
	lda xsp,(xsp-2)
	ld xwa,_sharp_bends__18
	push xwa
	ld wa,3
	push xwa
	call _rndn__18
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
	jr uge,L2499
	ld iz,52
L2499:
	ld wa,iz
	cp wa,72
	jr ule,L2500
	ld iz,72
L2500:
	ld wa,iz
	jr L2498
L2498:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function gen_leg
_gen_leg__18:
	push xiz
	lda xsp,(xsp-32)
	ld xwa,_gfx_themes
	ld xbc,_leg_theme
	ld e,(xsp+40)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	muls xbc,20
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+0),xwa
	ld a,(xsp+40)
	push xwa
	call _stage_of__18
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
	ld xwa,(xsp+44)
	ld (_gp__18),xwa
	ldb (_gn__18),0
	ld wa,(_free_seed)
	ld c,(xsp+40)
	extz bc
	add bc,1
	mul xbc,40503
	xor wa,bc
	ld (_rs__18),wa
	ld wa,(_rs__18)
	cp wa,0
	jr nz,L2532
	ldw (_rs__18),44257
L2532:
	call _rnd16__18
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,900
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld xbc,(xsp+0)
	ld c,(xbc+19)
	cp c,0
	jr nz,L2533
	ld wa,1
	jr L2534
L2533:
	ld wa,0
L2534:
	ld (xsp+18),a
	jp L2537
L2535:
	ld a,(xsp+18)
	cp a,0
	jp nz,L2538
	ld wa,iz
	cp wa,4680
	jr ult,L2538
	ldb (xsp+18),1
	ldb (xsp+22),0
	jr L2542
L2539:
	ld xwa,_bridge_run__18
	ld c,(xsp+22)
	extz bc
	muls xbc,6
	add xwa,xbc
	ld a,(xwa+4)
	push xwa
	ld xwa,_bridge_run__18
	ld c,(xsp+26)
	extz bc
	muls xbc,6
	add xwa,xbc
	ld wa,(xwa+2)
	mul xwa,(xsp+20)
	push xwa
	ld xwa,_bridge_run__18
	ld c,(xsp+30)
	extz bc
	muls xbc,6
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld wa,iz
	ld xbc,_bridge_run__18
	ld e,(xsp+22)
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld iz,wa
L2541:
	incb 1,(xsp+22)
L2542:
	ld a,(xsp+22)
	cp a,4
	jr ult,L2539
L2540:
	jp L2537
L2538:
	ld wa,1000
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld (xsp+20),wa
	push xwa
	ld wa,1000
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp bc,600
	jr uge,L2543
	ld wa,(xsp+16)
	neg wa
	jr L2544
L2543:
	ld wa,(xsp+16)
L2544:
	ld (xsp+22),wa
	ld wa,(xsp+20)
	cp wa,(xsp+8)
	jp uge,L2545
	ld xwa,(xsp+0)
	ld a,(xwa+16)
	push xwa
	call _sharp__18
	lda xsp,(xsp+4)
	ld (xsp+24),wa
	ld xwa,(xsp+0)
	ld a,(xwa+16)
	push xwa
	call _sharp__18
	lda xsp,(xsp+4)
	ld (xsp+26),wa
	ld xwa,_sp_s__18
	push xwa
	ld wa,3
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+28),wa
	ld xwa,_sp_gap__18
	push xwa
	ld wa,3
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+30),wa
	push xwa
	ld wa,2
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp bc,0
	jr z,L2546
	ld wa,500
	jr L2547
L2546:
	ld wa,400
L2547:
	ld (xsp+12),wa
	ld xwa,(xsp+0)
	ld a,(xwa+17)
	push xwa
	call _slope_for__18
	lda xsp,(xsp+4)
	ld (xsp+14),a
	ld a,(xsp+14)
	push xwa
	ld wa,0
	push xwa
	ld wa,(xsp+20)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld wa,0
	push xwa
	ld wa,(xsp+26)
	mul xwa,(xsp+28)
	push xwa
	ld wa,(xsp+36)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld wa,(xsp+30)
	cp wa,0
	jr z,L2548
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,(xsp+38)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
L2548:
	ld wa,0
	push xwa
	ld wa,(xsp+26)
	neg wa
	mul xwa,(xsp+30)
	push xwa
	ld wa,(xsp+36)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld wa,iz
	add wa,450
	ld bc,2
	mul xbc,(xsp+28)
	add wa,bc
	add wa,(xsp+30)
	ld iz,wa
	ld wa,(xsp+22)
	neg wa
	ld (xsp+16),wa
	jp L2549
L2545:
	ld wa,(xsp+20)
	ld bc,(xsp+8)
	add bc,(xsp+6)
	cp wa,bc
	jp uge,L2550
	push xwa
	ld wa,2
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp bc,0
	jr z,L2551
	ld wa,500
	jr L2552
L2551:
	ld wa,400
L2552:
	ld (xsp+12),wa
	ld xwa,(xsp+0)
	ld a,(xwa+17)
	push xwa
	call _slope_for__18
	lda xsp,(xsp+4)
	ld (xsp+14),a
	ld a,(xsp+14)
	push xwa
	ld wa,0
	push xwa
	ld wa,(xsp+20)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld xwa,_sp_sharp__18
	push xwa
	ld wa,3
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+24),wa
	ld wa,0
	push xwa
	ld wa,(xsp+26)
	push xwa
	ld xwa,(xsp+8)
	ld a,(xwa+16)
	push xwa
	call _sharp__18
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	mul xwa,bc
	push xwa
	ld wa,(xsp+32)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld wa,iz
	add wa,450
	add wa,(xsp+24)
	ld iz,wa
	ld wa,(xsp+22)
	ld (xsp+16),wa
	jp L2553
L2550:
	ld wa,100
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,(xsp+0)
	ld c,(xbc+18)
	extz bc
	cp wa,bc
	jr uge,L2554
	ld xwa,_sp_straight__18
	push xwa
	ld wa,4
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+24),wa
	ld xwa,(xsp+0)
	ld a,(xwa+17)
	push xwa
	call _slope_for__18
	lda xsp,(xsp+4)
	push xwa
	ld wa,0
	push xwa
	ld wa,(xsp+32)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld wa,iz
	add wa,(xsp+24)
	ld iz,wa
	jp L2555
L2554:
	ld xwa,_sp_bend__18
	push xwa
	ld wa,5
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+24),wa
	ld xwa,_easy_bends__18
	push xwa
	ld c,(xsp+8)
	cp c,1
	jr ult,L2556
	ld wa,5
	jr L2557
L2556:
	ld wa,3
L2557:
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+26),wa
	ld wa,(xsp+26)
	ld xbc,(xsp+0)
	ld c,(xbc+16)
	extz bc
	mul xwa,bc
	add wa,5
	extz xwa
	div xwa,10
	ld (xsp+26),wa
	ld wa,(xsp+26)
	cp wa,18
	jr uge,L2558
	ldw (xsp+26),18
L2558:
	ld wa,(xsp+26)
	cp wa,48
	jr ule,L2559
	ldw (xsp+26),48
L2559:
	ld xwa,(xsp+0)
	ld a,(xwa+17)
	push xwa
	call _slope_for__18
	lda xsp,(xsp+4)
	push xwa
	ld wa,(xsp+26)
	ld bc,(xsp+30)
	mul xwa,bc
	push xwa
	ld wa,(xsp+32)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld wa,iz
	add wa,(xsp+24)
	ld iz,wa
	ld wa,(xsp+22)
	ld (xsp+16),wa
L2555:
L2553:
L2549:
L2537:
	ld wa,iz
	cp wa,11700
	jr uge,L2560
	ld a,(_gn__18)
	cp a,30
	jp ule,L2535
L2560:
L2536:
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,2400
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld a,(_gn__18)
	jr L2531
L2531:
	lda xsp,(xsp+32)
	pop xiz
	ret

; function cost_of
_cost_of__18:
	push xiz
	lda xsp,(xsp-10)
	ld xwa,0
	ld (xsp+0),xwa
	ld ixl,0
	jr L2575
L2572:
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
	jr ge,L2576
	ld wa,iy
	neg wa
	ld iy,wa
L2576:
	jr L2579
L2577:
	dec 1,iz
L2579:
	ld wa,iz
	cp wa,6
	jr ule,L2580
	ld wa,iz
	mul xwa,iz
	ld bc,iy
	mul xwa,bc
	cp wa,6000
	jr ugt,L2577
L2580:
L2578:
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
L2574:
	inc 1,ixl
L2575:
	ld a,ixl
	cp a,(xsp+22)
	jr ult,L2572
L2573:
	ld xwa,(xsp+0)
	srl 4,xwa
	jr L2571
L2571:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function put_placeholder
_put_placeholder__18:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld wa,4000
	ld xbc,_buf__18
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc),wa
	ld wa,0
	ld xbc,_buf__18
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+2),wa
	ld a,0
	ld xbc,_buf__18
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+4),a
L2582:
	pop xiz
	ret

; function copy_leg
_copy_leg__18:
	push xiz
	lda xsp,(xsp-6)
	ld a,(xsp+18)
	ld iyl,a
	ld a,(_difficulty)
	cp a,3
	jr nz,L2592
	push xix
	push xiy
	ld xwa,_buf__18
	ld c,iyl
	extz bc
	muls xbc,6
	add xwa,xbc
	lda xwa,(xwa)
	push xwa
	ld a,(xsp+26)
	push xwa
	call _gen_leg__18
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	ld ixl,a
	jr L2593
L2592:
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
	jr ule,L2594
	ld a,71
	sub a,iyl
	ld ixl,a
L2594:
	ld izl,0
	jr L2598
L2595:
	push xwa
	ld xwa,(xsp+6)
	ld xwa,(xwa)
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	push xwa
	ld xwa,_buf__18
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
L2597:
	inc 1,izl
L2598:
	ld a,izl
	cp a,ixl
	jr ult,L2595
L2596:
L2593:
	push xix
	push xiy
	ld a,ixl
	push xwa
	ld xwa,_buf__18
	ld c,iyl
	extz bc
	muls xbc,6
	add xwa,xbc
	lda xwa,(xwa)
	push xwa
	call _cost_of__18
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	ld (_next_leg_cost),wa
	ld a,ixl
	jr L2591
L2591:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function load_current
_load_current__18:
	push xiz
	lda xsp,(xsp-2)
	ld wa,0
	push xwa
	ld a,(_cur_leg)
	push xwa
	call _copy_leg__18
	lda xsp,(xsp+8)
	ld (_n_cur__18),a
	ld a,(_n_cur__18)
	push xwa
	call _put_placeholder__18
	lda xsp,(xsp+4)
	ld a,(_n_cur__18)
	add a,1
	ld (_track_len),a
	ldw (_leg_len),0
	ld izl,0
	jr L2608
L2605:
	ld wa,(_leg_len)
	ld xbc,_buf__18
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld (_leg_len),wa
L2607:
	inc 1,izl
L2608:
	ld a,izl
	cp a,(_n_cur__18)
	jr ult,L2605
L2606:
	ldb (_fork_choice),0
L2604:
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
	jr L2629
L2626:
	ld a,0
	ld xbc,_route_hist
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2628:
	inc 1,izl
L2629:
	ld a,izl
	cp a,5
	jr ult,L2626
L2627:
	ld izl,0
	jr L2633
L2630:
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
L2632:
	inc 1,izl
L2633:
	ld a,izl
	cp a,15
	jr ult,L2630
L2631:
	ld a,(_difficulty)
	cp a,3
	jp nz,L2634
	ld wa,(_free_seed)
	cp wa,0
	jr nz,L2635
	ldw (_free_seed),24301
L2635:
	ld wa,(_free_seed)
	xor wa,15450
	ld (_rs__18),wa
	ld wa,(_rs__18)
	cp wa,0
	jr nz,L2636
	ldw (_rs__18),44257
L2636:
	ld izl,14
	jr L2640
L2637:
	ld a,izl
	extz wa
	add wa,1
	push xwa
	call _rndn__18
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
L2639:
	dec 1,izl
L2640:
	ld a,izl
	cp a,0
	jr ugt,L2637
L2638:
L2634:
	call _load_current__18
L2625:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function course_is_last_stage
_course_is_last_stage:
	ld c,(_cur_stage)
	extz bc
	add bc,1
	cp bc,5
	jr ult,L2645
	ld wa,1
	jr L2646
L2645:
	ld wa,0
L2646:
	jr L2644
L2644:
	ret

; function course_fork_zone
_course_fork_zone:
	ld bc,(xsp+4)
	add bc,2400
	cp bc,(_leg_len)
	jr ult,L2651
	ld wa,1
	jr L2652
L2651:
	ld wa,0
L2652:
	jr L2650
L2650:
	ret

; function course_start_zone
_course_start_zone:
	ld c,(_cur_stage)
	cp c,0
	jr z,L2657
	ld bc,(xsp+4)
	cp bc,900
	jr uge,L2657
	ld wa,1
	jr L2658
L2657:
	ld wa,0
L2658:
	jr L2656
L2656:
	ret

; function course_decide
_course_decide:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_fork_choice)
	cp a,0
	jr nz,L2671
	call _course_is_last_stage
	cp a,0
	jr z,L2670
L2671:
	jp L2669
L2670:
	ld c,(xsp+10)
	cp c,0
	jr z,L2672
	ld wa,2
	jr L2673
L2672:
	ld wa,1
L2673:
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
	jr z,L2674
	ld de,1
	jr L2675
L2674:
	ld de,0
L2675:
	add bc,de
	add wa,bc
	ld (xsp+0),a
	ld a,(_n_cur__18)
	push xwa
	ld a,(xsp+4)
	push xwa
	call _copy_leg__18
	lda xsp,(xsp+8)
	ld izl,a
	ld a,izl
	ld (_n_next__18),a
	ld a,izl
	cp a,0
	jr z,L2676
	ld c,(xsp+10)
	cp c,0
	jr z,L2677
	ld wa,65486
	jr L2678
L2677:
	ld wa,50
L2678:
	ld xbc,_buf__18
	ld e,(_n_cur__18)
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+2),wa
L2676:
	ld a,(_n_cur__18)
	add a,izl
	push xwa
	call _put_placeholder__18
	lda xsp,(xsp+4)
	ld a,(_n_cur__18)
	add a,izl
	add a,1
	ld (_track_len),a
L2669:
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
	jr z,L2693
	ld wa,0
	jp L2692
L2693:
	ld a,(_fork_choice)
	cp a,0
	jr nz,L2694
	push xix
	ld wa,0
	push xwa
	call _course_decide
	lda xsp,(xsp+4)
	pop xix
L2694:
	ld a,(_n_cur__18)
	ld ixl,a
	ld izl,0
	jr L2698
L2695:
	push xwa
	ld xwa,_buf__18
	ld c,izl
	add c,ixl
	extz bc
	muls xbc,6
	add xwa,xbc
	push xwa
	ld xwa,_buf__18
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld xde,xwa
	pop xhl
	ld bc,6
	ldirb
	pop xwa
L2697:
	inc 1,izl
L2698:
	ld a,izl
	add a,ixl
	cp a,(_track_len)
	jr ult,L2695
L2696:
	ld a,(_track_len)
	sub a,ixl
	ld (_track_len),a
	ld a,(_fork_choice)
	cp a,2
	jr nz,L2699
	incb 1,(_cur_branch)
L2699:
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
	ld a,(_n_next__18)
	ld (_n_cur__18),a
	ld a,(_n_cur__18)
	cp a,(_track_len)
	jr ult,L2700
	ld a,(_track_len)
	sub a,1
	ld (_n_cur__18),a
L2700:
	ldw (_leg_len),0
	ld izl,0
	jr L2704
L2701:
	ld wa,(_leg_len)
	ld xbc,_buf__18
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld (_leg_len),wa
L2703:
	inc 1,izl
L2704:
	ld a,izl
	cp a,(_n_cur__18)
	jr ult,L2701
L2702:
	ldb (_fork_choice),0
	ld a,ixl
	jr L2692
L2692:
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
	call _load_current__18
	pop xix
L2706:
	pop xiz
	ret

; function rnd
_rnd__19:
	ld wa,(_seed__19)
	mul xwa,25173
	add wa,13849
	ld (_seed__19),wa
	ld wa,(_seed__19)
	srl 8,wa
	jr L2708
L2708:
	ret

; function ending_start
_ending_start:
	push xiz
	lda xsp,(xsp-8)
	ld a,(xsp+16)
	cp a,5
	jr ule,L2720
	ldb (xsp+16),5
L2720:
	ld xwa,_endings__19
	ld c,(xsp+16)
	extz bc
	exts xbc
	sll 4,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+0),xwa
	ldw (xsp+4),0
	jr L2724
L2721:
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
L2723:
	incw 1,(xsp+4)
L2724:
	ld wa,(xsp+4)
	cp wa,24
	jr ult,L2721
L2722:
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
	ld (_fx__19),a
	ldb (_timer__19),0
	ld izl,0
	jr L2728
L2725:
	ld a,0
	ld xbc,_life__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	call _rnd__19
	extz wa
	extz xwa
	div xwa,152
	ld wa,qwa
	sll 4,wa
	ld xbc,_px__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__19
	extz wa
	extz xwa
	div xwa,140
	ld wa,qwa
	sll 4,wa
	ld xbc,_py__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2727:
	inc 1,izl
L2728:
	ld a,izl
	cp a,14
	jr ult,L2725
L2726:
L2719:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function pal_of
_pal_of__19:
	ld xwa,_pals__19_L2732
	ld c,(xsp+4)
	extz bc
	and bc,3
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	jr L2731
L2731:
	ret

; function ending_tick
_ending_tick:
	push xiz
	lda xsp,(xsp-14)
	incb 1,(_timer__19)
	ld a,(_fx__19)
	cp a,1
	jp nz,L2770
	ld a,(_timer__19)
	extz wa
	extz xwa
	div xwa,40
	ld wa,qwa
	cp wa,1
	jp nz,L2770
	ld wa,24
	push xwa
	call _rnd__19
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
	call _rnd__19
	ld xbc,xwa
	pop xwa
	extz bc
	extz xbc
	div xbc,40
	ld bc,qbc
	add wa,bc
	sll 4,wa
	ld (xsp+4),wa
	call _rnd__19
	push xwa
	call _pal_of__19
	lda xsp,(xsp+4)
	ld (xsp+6),a
	ld izl,0
	jp L2774
L2771:
	ld a,izl
	and a,7
	ld (xsp+7),a
	ld c,izl
	cp c,8
	jr uge,L2775
	ld wa,2
	jr L2776
L2775:
	ld wa,1
L2776:
	ld (xsp+8),wa
	ld wa,(xsp+2)
	ld xbc,_px__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+4)
	ld xbc,_py__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_dir_x__19
	ld c,(xsp+7)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	exts wa
	mul xwa,(xsp+8)
	ld xbc,_vx__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_dir_y__19
	ld c,(xsp+7)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	exts wa
	mul xwa,(xsp+8)
	ld xbc,_vy__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,34
	ld xbc,_life__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_ptile__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+6)
	ld xbc,_ppal__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2773:
	inc 1,izl
L2774:
	ld a,izl
	cp a,14
	jp ult,L2771
L2772:
L2770:
	ld izl,0
	jp L2780
L2777:
	ld a,56
	add a,izl
	ld (xsp+1),a
	ld a,(_fx__19)
	extz wa
	cp wa,1
	jr z,L2782
	cp wa,2
	jp z,L2783
	cp wa,3
	jp z,L2784
	cp wa,4
	jp z,L2785
	jp L2786
L2782:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L2787
	ld xbc,_life__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld a,(xbc)
	dec 1,a
	ld (xbc),a
	ld xwa,_px__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_vx__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld xbc,_px__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_vy__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld xbc,_py__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_vy__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	add wa,1
	ld xbc,_vy__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2787:
	jp L2781
L2783:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L2789
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2400
	jp le,L2788
L2789:
	call _rnd__19
	extz wa
	extz xwa
	div xwa,152
	ld wa,qwa
	sll 4,wa
	ld xbc,_px__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__19
	extz wa
	and wa,63
	neg wa
	sll 4,wa
	ld xbc,_py__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,12
	push xwa
	call _rnd__19
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,15
	add wa,bc
	ld xbc,_vy__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__19
	push xwa
	call _pal_of__19
	lda xsp,(xsp+4)
	ld xbc,_ppal__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,1
	ld xbc,_ptile__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,1
	ld xbc,_life__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2788:
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_vy__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld xbc,_py__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_px__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld e,(_timer__19)
	extz de
	ld l,izl
	extz hl
	mul xhl,9
	add de,hl
	and de,32
	cp de,0
	jr z,L2790
	ld bc,6
	jr L2791
L2790:
	ld bc,65530
L2791:
	add wa,bc
	ld xbc,_px__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jp L2781
L2784:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L2793
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65408
	jp ge,L2792
L2793:
	ld wa,8
	push xwa
	call _rnd__19
	ld xbc,xwa
	pop xwa
	extz bc
	extz xbc
	div xbc,144
	ld bc,qbc
	add wa,bc
	sll 4,wa
	ld xbc,_px__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,152
	push xwa
	call _rnd__19
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,63
	add wa,bc
	sll 4,wa
	ld xbc,_py__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,8
	push xwa
	call _rnd__19
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,7
	add wa,bc
	neg wa
	ld xbc,_vy__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__19
	push xwa
	call _pal_of__19
	lda xsp,(xsp+4)
	ld xbc,_ppal__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,2
	ld xbc,_ptile__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,1
	ld xbc,_life__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2792:
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_vy__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld xbc,_py__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_px__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld e,(_timer__19)
	extz de
	ld l,izl
	extz hl
	mul xhl,13
	add de,hl
	and de,64
	cp de,0
	jr z,L2794
	ld bc,3
	jr L2795
L2794:
	ld bc,65533
L2795:
	add wa,bc
	ld xbc,_px__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jp L2781
L2785:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp nz,L2796
	call _rnd__19
	extz wa
	extz xwa
	div xwa,152
	ld wa,qwa
	sll 4,wa
	ld xbc,_px__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__19
	extz wa
	extz xwa
	div xwa,100
	ld wa,qwa
	sll 4,wa
	ld xbc,_py__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,10
	push xwa
	call _rnd__19
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,31
	add wa,bc
	ld xbc,_life__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld c,izl
	extz bc
	and bc,1
	cp bc,0
	jr z,L2797
	ld wa,2
	jr L2798
L2797:
	ld wa,9
L2798:
	ld xbc,_ppal__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_ptile__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	jr L2799
L2796:
	ld xbc,_life__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld a,(xbc)
	dec 1,a
	ld (xbc),a
L2799:
	jr L2781
L2786:
	jr L2781
L2781:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L2801
	ld xwa,_px__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65424
	jr lt,L2801
	ld xwa,_px__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2544
	jr gt,L2801
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65424
	jr lt,L2801
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2416
	jr gt,L2801
	ld a,(_fx__19)
	cp a,4
	jr nz,L2800
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	and wa,4
	cp wa,0
	jr z,L2800
L2801:
	ld a,(xsp+1)
	add a,1
	push xwa
	ld a,(xsp+5)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	jp L2779
L2800:
L2802:
	ld a,(xsp+1)
	ld (xsp+2),a
	ld xwa,_px__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	sra 4,wa
	ld (xsp+3),a
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	sra 4,wa
	ld (xsp+4),a
	ld wa,107
	ld xbc,_ptile__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	ld (xsp+6),wa
	ld xwa,_ppal__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+8),a
	ld a,0
	ld (xsp+9),a
	ld xwa,_spr_shadow
	ld c,(xsp+2)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
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
	ld xbc,_spr_pal_shadow
	ld e,(xsp+2)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2804:
L2803:
L2779:
	inc 1,izl
L2780:
	ld a,izl
	cp a,14
	jp ult,L2777
L2778:
L2769:
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
	ldb (_fx__19),0
L2806:
	ret

; function dma0_program
_dma0_program__20:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma0_program_asm
	lda xsp,(xsp+12)
L2808:
	ret

; function dma1_program
_dma1_program__20:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma1_program_asm
	lda xsp,(xsp+12)
L2810:
	ret

; function dma2_program
_dma2_program__20:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma2_program_asm
	lda xsp,(xsp+12)
L2812:
	ret

; function dma3_program
_dma3_program__20:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma3_program_asm
	lda xsp,(xsp+12)
L2814:
	ret

; function dma0_program_u16
_dma0_program_u16__20:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma0_program_u16_asm
	lda xsp,(xsp+12)
L2816:
	ret

; function dma1_program_u16
_dma1_program_u16__20:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma1_program_u16_asm
	lda xsp,(xsp+12)
L2818:
	ret

; function dma2_program_u16
_dma2_program_u16__20:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma2_program_u16_asm
	lda xsp,(xsp+12)
L2820:
	ret

; function dma3_program_u16
_dma3_program_u16__20:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma3_program_u16_asm
	lda xsp,(xsp+12)
L2822:
	ret

; function dma0_program_u32
_dma0_program_u32__20:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma0_program_u32_asm
	lda xsp,(xsp+12)
L2824:
	ret

; function dma1_program_u32
_dma1_program_u32__20:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma1_program_u32_asm
	lda xsp,(xsp+12)
L2826:
	ret

; function dma2_program_u32
_dma2_program_u32__20:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma2_program_u32_asm
	lda xsp,(xsp+12)
L2828:
	ret

; function dma3_program_u32
_dma3_program_u32__20:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma3_program_u32_asm
	lda xsp,(xsp+12)
L2830:
	ret

; function dma0_clear
_dma0_clear__20:
	ld wa,0
	ldc dmac0,wa
	ld a,0
	ldc dmam0,a
L2832:
	ret

; function dma1_clear
_dma1_clear__20:
	ld wa,0
	ldc dmac1,wa
	ld a,0
	ldc dmam1,a
L2834:
	ret

; function dma2_clear
_dma2_clear__20:
	ld wa,0
	ldc dmac2,wa
	ld a,0
	ldc dmam2,a
L2836:
	ret

; function dma3_clear
_dma3_clear__20:
	ld wa,0
	ldc dmac3,wa
	ld a,0
	ldc dmam3,a
L2838:
	ret

; function dma_set_start_vector
_dma_set_start_vector__20:
	push xiz
	ld a,(xsp+12)
	ld izl,a
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2847
	cp wa,1
	jr z,L2848
	cp wa,2
	jr z,L2849
	cp wa,3
	jr z,L2850
	jr L2846
L2847:
	ld a,izl
	ld (07Ch),a
	jr L2846
L2848:
	ld a,izl
	ld (07Dh),a
	jr L2846
L2849:
	ld a,izl
	ld (07Eh),a
	jr L2846
L2850:
	ld a,izl
	ld (07Fh),a
	jr L2846
L2846:
L2845:
	pop xiz
	ret

; function dma_rearm_in_isr
_dma_rearm_in_isr__20:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	jr L2876
	jp L2875
L2876:
	ld a,izl
	cp a,3
	jr ule,L2877
	jp L2875
L2877:
	ld xwa,_s_rearm_enabled__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L2878
	jp L2875
L2878:
	ld wa,0
	push xwa
	ld a,izl
	push xwa
	call _dma_set_start_vector__20
	lda xsp,(xsp+8)
	ld xwa,_s_rearm_elem__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	cp wa,0
	jr z,L2881
	cp wa,1
	jp z,L2882
	cp wa,2
	jp z,L2883
	jr L2880
L2880:
L2881:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L2885
	cp wa,1
	jr z,L2886
	cp wa,2
	jp z,L2887
	cp wa,3
	jp z,L2888
	jp L2884
L2885:
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma0_program__20
	lda xsp,(xsp+12)
	jp L2884
L2886:
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma1_program__20
	lda xsp,(xsp+12)
	jp L2884
L2887:
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma2_program__20
	lda xsp,(xsp+12)
	jr L2884
L2888:
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma3_program__20
	lda xsp,(xsp+12)
	jr L2884
L2884:
	jp L2879
L2882:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L2890
	cp wa,1
	jr z,L2891
	cp wa,2
	jp z,L2892
	cp wa,3
	jp z,L2893
	jp L2889
L2890:
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma0_program_u16__20
	lda xsp,(xsp+12)
	jp L2889
L2891:
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma1_program_u16__20
	lda xsp,(xsp+12)
	jp L2889
L2892:
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma2_program_u16__20
	lda xsp,(xsp+12)
	jr L2889
L2893:
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma3_program_u16__20
	lda xsp,(xsp+12)
	jr L2889
L2889:
	jp L2879
L2883:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L2895
	cp wa,1
	jr z,L2896
	cp wa,2
	jp z,L2897
	cp wa,3
	jp z,L2898
	jp L2894
L2895:
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma0_program_u32__20
	lda xsp,(xsp+12)
	jp L2894
L2896:
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma1_program_u32__20
	lda xsp,(xsp+12)
	jp L2894
L2897:
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma2_program_u32__20
	lda xsp,(xsp+12)
	jr L2894
L2898:
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma3_program_u32__20
	lda xsp,(xsp+12)
	jr L2894
L2894:
	jr L2879
L2879:
	ld xwa,_s_rearm_vector__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld a,izl
	push xwa
	call _dma_set_start_vector__20
	lda xsp,(xsp+8)
L2875:
	pop xiz
	ret

; function isr_dma0_inttc
_isr_dma0_inttc__20:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	jr L2904
	ldb (_s_done_flag__20),1
L2904:
	ld wa,0
	push xwa
	call _dma_rearm_in_isr__20
	lda xsp,(xsp+4)
	jr L2905
	ld xwa,(_s_done_cb__20)
	cp xwa,0
	jr z,L2906
	ld xwa,(_s_done_cb__20)
	ld xhl,xwa
	call (xhl)
L2906:
L2905:
L2903:
	pop xiz
	pop xiy
	pop xix
	pop xhl
	pop xde
	pop xbc
	pop xwa
	reti

; function isr_dma1_inttc
_isr_dma1_inttc__20:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	jr L2912
	ldb (_s_done_flag__20+1),1
L2912:
	ld wa,1
	push xwa
	call _dma_rearm_in_isr__20
	lda xsp,(xsp+4)
	jr L2913
	ld xwa,(_s_done_cb__20+4)
	cp xwa,0
	jr z,L2914
	ld xwa,(_s_done_cb__20+4)
	ld xhl,xwa
	call (xhl)
L2914:
L2913:
L2911:
	pop xiz
	pop xiy
	pop xix
	pop xhl
	pop xde
	pop xbc
	pop xwa
	reti

; function isr_dma2_inttc
_isr_dma2_inttc__20:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	jr L2920
	ldb (_s_done_flag__20+2),1
L2920:
	ld wa,2
	push xwa
	call _dma_rearm_in_isr__20
	lda xsp,(xsp+4)
	jr L2921
	ld xwa,(_s_done_cb__20+8)
	cp xwa,0
	jr z,L2922
	ld xwa,(_s_done_cb__20+8)
	ld xhl,xwa
	call (xhl)
L2922:
L2921:
L2919:
	pop xiz
	pop xiy
	pop xix
	pop xhl
	pop xde
	pop xbc
	pop xwa
	reti

; function isr_dma3_inttc
_isr_dma3_inttc__20:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	jr L2928
	ldb (_s_done_flag__20+3),1
L2928:
	ld wa,3
	push xwa
	call _dma_rearm_in_isr__20
	lda xsp,(xsp+4)
	jr L2929
	ld xwa,(_s_done_cb__20+12)
	cp xwa,0
	jr z,L2930
	ld xwa,(_s_done_cb__20+12)
	ld xhl,xwa
	call (xhl)
L2930:
L2929:
L2927:
	pop xiz
	pop xiy
	pop xix
	pop xhl
	pop xde
	pop xbc
	pop xwa
	reti

; function dma_start_common
_dma_start_common__20:
	push xiz
	ld iz,(xsp+20)
	ld a,(xsp+8)
	cp a,3
	jr ule,L2957
	jp L2956
L2957:
	ld xwa,(xsp+12)
	cp xwa,0
	jr z,L2959
	ld xwa,(xsp+16)
	cp xwa,0
	jr nz,L2958
L2959:
	jp L2956
L2958:
	ld wa,iz
	cp wa,0
	jr nz,L2960
	jp L2956
L2960:
	ld a,(xsp+24)
	cp a,11
	jr nz,L2961
	jp L2956
L2961:
	ld a,0
	ld xbc,_s_done_flag__20
	ld e,(xsp+8)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,1
	ld xbc,_s_was_active__20
	ld e,(xsp+8)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,0
	push xwa
	ld a,(xsp+12)
	push xwa
	call _dma_set_start_vector__20
	lda xsp,(xsp+8)
	ld wa,(xsp+28)
	cp wa,0
	jr z,L2963
	cp wa,1
	jr z,L2964
	cp wa,2
	jp z,L2965
	jp L2962
L2963:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2967
	cp wa,1
	jr z,L2968
	cp wa,2
	jr z,L2969
	cp wa,3
	jr z,L2970
	jr L2966
L2967:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program__20
	lda xsp,(xsp+12)
	jr L2966
L2968:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program__20
	lda xsp,(xsp+12)
	jr L2966
L2969:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program__20
	lda xsp,(xsp+12)
	jr L2966
L2970:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program__20
	lda xsp,(xsp+12)
	jr L2966
L2966:
	jp L2962
L2964:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2972
	cp wa,1
	jr z,L2973
	cp wa,2
	jr z,L2974
	cp wa,3
	jr z,L2975
	jr L2971
L2972:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program_u16__20
	lda xsp,(xsp+12)
	jr L2971
L2973:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program_u16__20
	lda xsp,(xsp+12)
	jr L2971
L2974:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program_u16__20
	lda xsp,(xsp+12)
	jr L2971
L2975:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program_u16__20
	lda xsp,(xsp+12)
	jr L2971
L2971:
	jr L2962
L2965:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2977
	cp wa,1
	jr z,L2978
	cp wa,2
	jr z,L2979
	cp wa,3
	jr z,L2980
	jr L2976
L2977:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program_u32__20
	lda xsp,(xsp+12)
	jr L2976
L2978:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program_u32__20
	lda xsp,(xsp+12)
	jr L2976
L2979:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program_u32__20
	lda xsp,(xsp+12)
	jr L2976
L2980:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program_u32__20
	lda xsp,(xsp+12)
	jr L2976
L2976:
	jr L2962
L2962:
	ld a,(xsp+24)
	push xwa
	ld a,(xsp+12)
	push xwa
	call _dma_set_start_vector__20
	lda xsp,(xsp+8)
L2956:
	pop xiz
	ret

; function ngpc_dma_init
_ngpc_dma_init:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jp L2991
L2988:
	ld xwa,0
	ld xbc,_s_done_cb__20
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld a,0
	ld xbc,_s_done_flag__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_was_active__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_rearm_enabled__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_rearm_elem__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_rearm_vector__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,0
	ld xbc,_s_rearm_count__20
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,0
	ld xbc,_s_rearm_dst__20
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld xwa,0
	ld xbc,_s_rearm_src__20
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L2990:
	inc 1,izl
L2991:
	ld a,izl
	cp a,4
	jp ult,L2988
L2989:
	ld xwa,_isr_dma0_inttc__20
	ld (06FF0h),xwa
	ld xwa,_isr_dma1_inttc__20
	ld (06FF4h),xwa
	ld xwa,_isr_dma2_inttc__20
	ld (06FF8h),xwa
	ld xwa,_isr_dma3_inttc__20
	ld (06FFCh),xwa
	ldb (079h),153
	ldb (07Ah),153
L2992:
L2987:
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
	call _dma_start_common__20
	lda xsp,(xsp+24)
L2994:
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
	call _dma_start_common__20
	lda xsp,(xsp+24)
L2996:
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
	call _dma_start_common__20
	lda xsp,(xsp+24)
L2998:
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
L3000:
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
L3002:
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
L3004:
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
L3006:
	ret

; function ngpc_dma_timer0_hblank_enable
_ngpc_dma_timer0_hblank_enable:
	ld wa,1
	push xwa
	call _ngpc_dma_timer0_hblank_enable_treg0
	lda xsp,(xsp+4)
L3008:
	ret

; function ngpc_dma_timer0_hblank_enable_treg0
_ngpc_dma_timer0_hblank_enable_treg0:
	andb (024h),60
	ld a,(xsp+4)
	ld (022h),a
	orb (020h),1
L3010:
	ret

; function ngpc_dma_timer0_hblank_disable
_ngpc_dma_timer0_hblank_disable:
	andb (020h),254
L3012:
	ret

; function ngpc_dma_timer01_hblank_enable
_ngpc_dma_timer01_hblank_enable:
	andb (024h),48
	ldb (022h),1
	ldb (023h),1
	orb (020h),3
L3014:
	ret

; function ngpc_dma_timer01_hblank_disable
_ngpc_dma_timer01_hblank_disable:
	andb (020h),252
L3016:
	ret

; function ngpc_dma_timer1_from_timer0_enable
_ngpc_dma_timer1_from_timer0_enable:
	ld wa,1
	push xwa
	call _ngpc_dma_timer1_from_timer0_enable_treg1
	lda xsp,(xsp+4)
L3018:
	ret

; function ngpc_dma_timer1_from_timer0_enable_treg1
_ngpc_dma_timer1_from_timer0_enable_treg1:
	andb (024h),243
	ld a,(xsp+4)
	ld (023h),a
	orb (020h),2
L3020:
	ret

; function ngpc_dma_timer1_disable
_ngpc_dma_timer1_disable:
	andb (020h),253
L3022:
	ret

; function ngpc_dma_hblank_stream_begin
_ngpc_dma_hblank_stream_begin:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3026
	jr L3025
L3026:
	ld a,(xsp+12)
	ld (xiz),a
	ld xwa,(xsp+16)
	ld (xiz+2),xwa
	ld xwa,(xsp+20)
	ld (xiz+6),xwa
	ld wa,(xsp+24)
	ld (xiz+10),wa
L3025:
	pop xiz
	ret

; function ngpc_dma_hblank_stream_rearm
_ngpc_dma_hblank_stream_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3030
	jr L3029
L3030:
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
L3029:
	pop xiz
	ret

; function ngpc_dma_hblank_stream_end
_ngpc_dma_hblank_stream_end:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L3034
	jr L3033
L3034:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L3033:
	ret

; function ngpc_dma_stream_begin_u8
_ngpc_dma_stream_begin_u8:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3038
	jr L3037
L3038:
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
L3037:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u8
_ngpc_dma_stream_rearm_u8:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3042
	jr L3041
L3042:
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
L3041:
	pop xiz
	ret

; function ngpc_dma_stream_end_u8
_ngpc_dma_stream_end_u8:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L3046
	jr L3045
L3046:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L3045:
	ret

; function ngpc_dma_stream_begin_u16
_ngpc_dma_stream_begin_u16:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3050
	jr L3049
L3050:
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
L3049:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u16
_ngpc_dma_stream_rearm_u16:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3054
	jr L3053
L3054:
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
L3053:
	pop xiz
	ret

; function ngpc_dma_stream_end_u16
_ngpc_dma_stream_end_u16:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L3058
	jr L3057
L3058:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L3057:
	ret

; function ngpc_dma_stream_begin_u32
_ngpc_dma_stream_begin_u32:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3062
	jr L3061
L3062:
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
L3061:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u32
_ngpc_dma_stream_rearm_u32:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3066
	jr L3065
L3066:
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
L3065:
	pop xiz
	ret

; function ngpc_dma_stream_end_u32
_ngpc_dma_stream_end_u32:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L3070
	jr L3069
L3070:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L3069:
	ret

; function ngpc_dma_stop
_ngpc_dma_stop:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L3079
	jr L3078
L3079:
	ld wa,0
	push xwa
	ld a,izl
	push xwa
	call _dma_set_start_vector__20
	lda xsp,(xsp+8)
	ld a,0
	ld xbc,_s_was_active__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_done_flag__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,izl
	extz wa
	cp wa,0
	jr z,L3081
	cp wa,1
	jr z,L3082
	cp wa,2
	jr z,L3083
	cp wa,3
	jr z,L3084
	jr L3080
L3081:
	call _dma0_clear__20
	jr L3080
L3082:
	call _dma1_clear__20
	jr L3080
L3083:
	call _dma2_clear__20
	jr L3080
L3084:
	call _dma3_clear__20
	jr L3080
L3080:
L3078:
	pop xiz
	ret

; function ngpc_dma_remaining
_ngpc_dma_remaining:
	ld a,(xsp+4)
	extz wa
	cp wa,0
	jr z,L3094
	cp wa,1
	jr z,L3095
	cp wa,2
	jr z,L3096
	cp wa,3
	jr z,L3097
	jr L3098
L3094:
	ldc wa,dmac0
	jr L3092
L3095:
	ldc wa,dmac1
	jr L3092
L3096:
	ldc wa,dmac2
	jr L3092
L3097:
	ldc wa,dmac3
	jr L3092
L3098:
	ld wa,0
	jr L3092
L3093:
L3092:
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
	jr z,L3103
	ld wa,1
	jr L3104
L3103:
	ld wa,0
L3104:
	jr L3102
L3102:
	ret

; function ngpc_dma_set_done_handler
_ngpc_dma_set_done_handler:
	ld a,(xsp+4)
	cp a,3
	jr ule,L3108
	jr L3107
L3108:
	ld xwa,(xsp+8)
	ld xbc,_s_done_cb__20
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L3107:
	ret

; function ngpc_dma_poll_done
_ngpc_dma_poll_done:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L3114
	ld wa,0
	jr L3113
L3114:
	ld xwa,_s_done_flag__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+0),a
	ld a,(xsp+0)
	cp a,0
	jr z,L3115
	ld a,0
	ld xbc,_s_done_flag__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_was_active__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,1
	jr L3113
L3115:
	ld xwa,_s_was_active__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L3116
	ld a,izl
	push xwa
	call _ngpc_dma_remaining
	lda xsp,(xsp+4)
	cp wa,0
	jr nz,L3116
	ld a,0
	ld xbc,_s_was_active__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,1
	jr L3113
L3116:
	ld wa,0
	jr L3113
L3113:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_dma_pp_init
_ngpc_dma_pp_init:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3120
	jr L3119
L3120:
	ld xwa,(xsp+12)
	ld (xiz),xwa
	ld wa,(xsp+16)
	ld (xiz+4),wa
	ldw (xiz+6),0
L3119:
	pop xiz
	ret

; function ngpc_dma_pp_front
_ngpc_dma_pp_front:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr z,L3126
	ld xwa,(xiz)
	cp xwa,0
	jr nz,L3125
L3126:
	ld xwa,0
	jr L3124
L3125:
	ld xwa,(xiz)
	ld bc,(xiz+6)
	extz xbc
	add xwa,xbc
	jr L3124
L3124:
	pop xiz
	ret

; function ngpc_dma_pp_back
_ngpc_dma_pp_back:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr z,L3132
	ld xwa,(xiz)
	cp xwa,0
	jr nz,L3131
L3132:
	ld xwa,0
	jr L3130
L3131:
	ld xwa,(xiz)
	ld bc,(xiz+6)
	xor bc,(xiz+4)
	extz xbc
	add xwa,xbc
	jr L3130
L3130:
	pop xiz
	ret

; function ngpc_dma_pp_swap
_ngpc_dma_pp_swap:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3136
	jr L3135
L3136:
	ld wa,(xiz+6)
	xor wa,(xiz+4)
	ld (xiz+6),wa
L3135:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u8
_ngpc_dma_autorearm_begin_u8:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L3140
	jr L3139
L3140:
	ld a,0
	ld xbc,_s_rearm_elem__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(xsp+12)
	ld xbc,_s_rearm_dst__20
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld xwa,(xsp+16)
	ld xbc,_s_rearm_src__20
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,(xsp+20)
	ld xbc,_s_rearm_count__20
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+24)
	ld xbc,_s_rearm_vector__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3139:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u16
_ngpc_dma_autorearm_begin_u16:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L3144
	jr L3143
L3144:
	ld a,1
	ld xbc,_s_rearm_elem__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(xsp+12)
	ld xbc,_s_rearm_dst__20
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld xwa,(xsp+16)
	ld xbc,_s_rearm_src__20
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,(xsp+20)
	ld xbc,_s_rearm_count__20
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+24)
	ld xbc,_s_rearm_vector__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3143:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u32
_ngpc_dma_autorearm_begin_u32:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L3148
	jr L3147
L3148:
	ld a,2
	ld xbc,_s_rearm_elem__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(xsp+12)
	ld xbc,_s_rearm_dst__20
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld xwa,(xsp+16)
	ld xbc,_s_rearm_src__20
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,(xsp+20)
	ld xbc,_s_rearm_count__20
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+24)
	ld xbc,_s_rearm_vector__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3147:
	pop xiz
	ret

; function ngpc_dma_autorearm_set_src_u8
_ngpc_dma_autorearm_set_src_u8:
	ld a,(xsp+4)
	cp a,3
	jr ule,L3152
	jr L3151
L3152:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__20
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L3151:
	ret

; function ngpc_dma_autorearm_set_src_u16
_ngpc_dma_autorearm_set_src_u16:
	ld a,(xsp+4)
	cp a,3
	jr ule,L3156
	jr L3155
L3156:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__20
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L3155:
	ret

; function ngpc_dma_autorearm_set_src_u32
_ngpc_dma_autorearm_set_src_u32:
	ld a,(xsp+4)
	cp a,3
	jr ule,L3160
	jr L3159
L3160:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__20
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L3159:
	ret

; function ngpc_dma_autorearm_enable
_ngpc_dma_autorearm_enable:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L3170
	jp L3169
L3170:
	jr L3171
	jp L3169
L3171:
	ld a,1
	ld xbc,_s_rearm_enabled__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,_s_rearm_elem__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	cp wa,0
	jr z,L3174
	cp wa,1
	jr z,L3175
	cp wa,2
	jp z,L3176
	jr L3173
L3173:
L3174:
	ld xwa,_s_rearm_vector__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
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
	jp L3172
L3175:
	ld xwa,_s_rearm_vector__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
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
	jr L3172
L3176:
	ld xwa,_s_rearm_vector__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,_s_rearm_count__20
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__20
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__20
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
	jr L3172
L3172:
L3169:
	pop xiz
	ret

; function ngpc_dma_autorearm_disable
_ngpc_dma_autorearm_disable:
	ld a,(xsp+4)
	cp a,3
	jr ule,L3180
	jr L3179
L3180:
	ld a,0
	ld xbc,_s_rearm_enabled__20
	ld e,(xsp+4)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3179:
	ret

; function plane_reg_x
_plane_reg_x__21:
	ld a,(xsp+4)
	cp a,1
	jr nz,L3184
	ld xwa,08034h
	jr L3183
L3184:
	ld xwa,08032h
	jr L3183
L3183:
	ret

; function plane_reg_y
_plane_reg_y__21:
	ld a,(xsp+4)
	cp a,1
	jr nz,L3188
	ld xwa,08035h
	jr L3187
L3188:
	ld xwa,08033h
	jr L3187
L3187:
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
L3190:
	ret

; function ngpc_dma_raster_begin_ex
_ngpc_dma_raster_begin_ex:
	push xiz
	lda xsp,(xsp-8)
	ld xiz,(xsp+16)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3200
	jp L3199
L3200:
	ld a,(xsp+20)
	ld (xiz),a
	ldb (xiz+1),0
	ld xwa,(xsp+28)
	ld (xiz+2),xwa
	ld xwa,(xsp+36)
	ld (xiz+6),xwa
	ld a,(xsp+20)
	push xwa
	call _plane_reg_x__21
	lda xsp,(xsp+4)
	ld (xsp+0),xwa
	ld a,(xsp+20)
	push xwa
	call _plane_reg_y__21
	lda xsp,(xsp+4)
	ld (xsp+4),xwa
	ld xwa,(xsp+28)
	cp xwa,0
	jr z,L3201
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
	jr L3202
L3201:
	ld xwa,(xsp+36)
	cp xwa,0
	jr z,L3203
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
	jr L3204
L3203:
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
L3204:
L3202:
	ld xwa,(xsp+28)
	cp xwa,0
	jr z,L3205
	ld xwa,(xsp+36)
	cp xwa,0
	jr z,L3205
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
	jr L3206
L3205:
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
L3206:
L3199:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function ngpc_dma_raster_enable
_ngpc_dma_raster_enable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3213
	jr L3212
L3213:
	ldb (xiz+1),0
	ld xwa,(xiz+2)
	cp xwa,0
	jr nz,L3214
	ld xwa,(xiz+6)
	cp xwa,0
	jr nz,L3214
	jr L3212
L3214:
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L3215
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L3215
	call _ngpc_dma_timer01_hblank_enable
	jr L3216
L3215:
	call _ngpc_dma_timer0_hblank_enable
L3216:
	ldb (xiz+1),1
L3212:
	pop xiz
	ret

; function ngpc_dma_raster_rearm
_ngpc_dma_raster_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3225
	jr L3224
L3225:
	ld a,(xiz+1)
	cp a,0
	jr nz,L3226
	jr L3224
L3226:
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L3227
	lda xwa,(xiz+10)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L3228
	lda xwa,(xiz+24)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
L3228:
	jr L3229
L3227:
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L3230
	lda xwa,(xiz+10)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
L3230:
L3229:
L3224:
	pop xiz
	ret

; function ngpc_dma_raster_disable
_ngpc_dma_raster_disable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3237
	jr L3236
L3237:
	ld a,(xiz+1)
	cp a,0
	jr z,L3238
	ld a,(xiz+10)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L3239
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L3239
	ld a,(xiz+24)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	call _ngpc_dma_timer01_hblank_disable
	jr L3240
L3239:
	call _ngpc_dma_timer0_hblank_disable
L3240:
L3238:
	ldb (xiz+1),0
L3236:
	pop xiz
	ret

; function ngpc_dma_raster_build_parallax_table
_ngpc_dma_raster_build_parallax_table:
	push xiz
	lda xsp,(xsp-6)
	ld xiy,(xsp+18)
	ld xwa,(xsp+14)
	cp xwa,0
	jr nz,L3260
	jp L3259
L3260:
	ld xwa,xiy
	cp xwa,0
	jr z,L3262
	ld a,(xsp+22)
	cp a,0
	jr nz,L3261
L3262:
	ld izl,0
	jr L3266
L3263:
	ld a,0
	ld xbc,(xsp+14)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3265:
	inc 1,izl
L3266:
	ld a,izl
	cp a,152
	jr ult,L3263
L3264:
	jp L3259
L3261:
	ld ixl,0
	jp L3270
L3267:
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
	jr ge,L3271
	ld xwa,xiy
	ld c,ixl
	extz bc
	add bc,1
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L3272
L3271:
	ld a,152
	extz wa
L3272:
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
	jr L3276
L3273:
	ld a,(xsp+4)
	ld xbc,(xsp+14)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3275:
	inc 1,izl
L3276:
	ld a,izl
	cp a,(xsp+3)
	jr ult,L3273
L3274:
L3269:
	inc 1,ixl
L3270:
	ld a,ixl
	cp a,(xsp+22)
	jp ult,L3267
L3268:
L3259:
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
L3278:
	ret

; function ngpc_dma_raster_xy_begin_ex
_ngpc_dma_raster_xy_begin_ex:
	push xiz
	lda xsp,(xsp-4)
	ld xiz,(xsp+12)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3284
	jr L3283
L3284:
	ld a,(xsp+16)
	ld (xiz),a
	ldb (xiz+1),0
	ld xwa,(xsp+24)
	ld (xiz+2),xwa
	ld a,(xsp+16)
	push xwa
	call _plane_reg_x__21
	lda xsp,(xsp+4)
	ld (xsp+0),xwa
	ld xwa,(xsp+24)
	cp xwa,0
	jr z,L3285
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
	jr L3286
L3285:
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
L3286:
L3283:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function ngpc_dma_raster_xy_enable
_ngpc_dma_raster_xy_enable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3291
	jr L3290
L3291:
	ldb (xiz+1),0
	ld xwa,(xiz+2)
	cp xwa,0
	jr nz,L3292
	jr L3290
L3292:
	call _ngpc_dma_timer0_hblank_enable
	ldb (xiz+1),1
L3290:
	pop xiz
	ret

; function ngpc_dma_raster_xy_rearm
_ngpc_dma_raster_xy_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3297
	jr L3296
L3297:
	ld a,(xiz+1)
	cp a,0
	jr nz,L3298
	jr L3296
L3298:
	lda xwa,(xiz+6)
	push xwa
	call _ngpc_dma_stream_rearm_u16
	lda xsp,(xsp+4)
L3296:
	pop xiz
	ret

; function ngpc_dma_raster_xy_disable
_ngpc_dma_raster_xy_disable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3303
	jr L3302
L3303:
	ld a,(xiz+1)
	cp a,0
	jr z,L3304
	ld a,(xiz+6)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	call _ngpc_dma_timer0_hblank_disable
L3304:
	ldb (xiz+1),0
L3302:
	pop xiz
	ret

; function ngpc_dma_raster_build_parallax_table_xy
_ngpc_dma_raster_build_parallax_table_xy:
	push xiz
	lda xsp,(xsp-8)
	ld xiy,(xsp+20)
	ld xwa,(xsp+16)
	cp xwa,0
	jr nz,L3324
	jp L3323
L3324:
	ld xwa,xiy
	cp xwa,0
	jr z,L3326
	ld a,(xsp+24)
	cp a,0
	jr nz,L3325
L3326:
	ld izl,0
	jr L3330
L3327:
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
L3329:
	inc 1,izl
L3330:
	ld a,izl
	cp a,152
	jr ult,L3327
L3328:
	jp L3323
L3325:
	ld ixl,0
	jp L3334
L3331:
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
	jr ge,L3335
	ld xwa,xiy
	ld c,ixl
	extz bc
	add bc,1
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L3336
L3335:
	ld a,152
	extz wa
L3336:
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
	jr L3340
L3337:
	ld wa,(xsp+6)
	ld xbc,(xsp+16)
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3339:
	inc 1,izl
L3340:
	ld a,izl
	cp a,(xsp+3)
	jr ult,L3337
L3338:
L3333:
	inc 1,ixl
L3334:
	ld a,ixl
	cp a,(xsp+24)
	jp ult,L3331
L3332:
L3323:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function audio_init
_audio_init:
	call _player_init
L3342:
	ret

; function audio_update
_audio_update:
	call _player_update
L3344:
	ret

; function music_play
_music_play:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	cp a,7
	jr ult,L3348
	call _music_stop
	jr L3347
L3348:
	ld xwa,_music_songs
	ld c,(xsp+12)
	extz bc
	muls xbc,18
	add xwa,xbc
	lda xwa,(xwa)
	ld xiz,xwa
	ld a,(xsp+12)
	ld (_cur_song__22),a
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
L3347:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function music_stop
_music_stop:
	call _player_stop
	ldb (_cur_song__22),255
L3350:
	ret

; function music_fade
_music_fade:
	call _player_stop
L3352:
	ret

; function music_current
_music_current:
	ld a,(_cur_song__22)
	jr L3354
L3354:
	ret

; function sfx
_sfx:
	ld a,(xsp+4)
	extz wa
	cp wa,0
	jr z,L3368
	cp wa,1
	jr z,L3369
	cp wa,2
	jr z,L3370
	cp wa,3
	jp z,L3371
	cp wa,4
	jp z,L3372
	cp wa,5
	jp z,L3373
	cp wa,7
	jp z,L3374
	cp wa,6
	jp z,L3375
	jp L3376
L3368:
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
	jp L3367
L3369:
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
	jp L3367
L3370:
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
	jp L3367
L3371:
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
	jr L3367
L3372:
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
	jr L3367
L3373:
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
	jr L3367
L3374:
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
	jr L3367
L3375:
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
	jr L3367
L3376:
	jr L3367
L3367:
L3366:
	ret

; function scr_map
_scr_map__23:
	ld c,(xsp+4)
	cp c,0
	jr nz,L3381
	ld xwa,36864
	jr L3382
L3381:
	ld xwa,38912
L3382:
	jr L3380
L3380:
	ret

; function pal_base
_pal_base__23:
	ld a,(xsp+4)
	cp a,2
	jr nz,L3387
	ld xwa,33280
	jr L3386
L3387:
	ld a,(xsp+4)
	cp a,0
	jr nz,L3388
	ld xwa,33408
	jr L3386
L3388:
	ld xwa,33536
	jr L3386
L3386:
	ret

; function ngpc_gfx_load_tiles
_ngpc_gfx_load_tiles:
	push xiz
	lda xsp,(xsp-8)
	ld xwa,40960
	ld xiy,xwa
	ld iz,0
	jr L3398
L3395:
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
L3397:
	inc 1,iz
L3398:
	ld wa,iz
	cp wa,(xsp+20)
	jr ult,L3395
L3396:
L3394:
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
	jr L3408
L3405:
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
L3407:
	inc 1,iz
L3408:
	ld wa,iz
	cp wa,(xsp+20)
	jr ult,L3405
L3406:
L3404:
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
	jr L3418
L3415:
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
L3417:
	inc 1,iz
L3418:
	ld wa,iz
	cp wa,ix
	jr ult,L3415
L3416:
L3414:
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
	jr L3428
L3425:
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
L3427:
	inc 1,iz
L3428:
	ld wa,iz
	cp wa,ix
	jr ult,L3425
L3426:
L3424:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function make_entry
_make_entry__23:
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
	jr L3430
L3430:
	ret

; function ngpc_gfx_put_tile
_ngpc_gfx_put_tile:
	lda xsp,(xsp-4)
	ld a,(xsp+8)
	push xwa
	call _scr_map__23
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
	call _make_entry__23
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
L3432:
	lda xsp,(xsp+4)
	ret

; function ngpc_gfx_put_tile_ex
_ngpc_gfx_put_tile_ex:
	lda xsp,(xsp-4)
	ld a,(xsp+8)
	push xwa
	call _scr_map__23
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
	call _make_entry__23
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
L3434:
	lda xsp,(xsp+4)
	ret

; function ngpc_gfx_get_tile
_ngpc_gfx_get_tile:
	push xiz
	lda xsp,(xsp-6)
	ld a,(xsp+14)
	push xwa
	call _scr_map__23
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
L3436:
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
	call _scr_map__23
	lda xsp,(xsp+4)
	pop xix
	ld xix,xwa
	ld iz,0
	jr L3446
L3443:
	ld wa,0
	ld xbc,xix
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3445:
	inc 1,iz
L3446:
	ld wa,iz
	cp wa,1024
	jr ult,L3443
L3444:
L3442:
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
	call _scr_map__23
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
	call _make_entry__23
	lda xsp,(xsp+16)
	pop xiy
	pop xix
	ld ix,wa
	ld iz,0
	jr L3456
L3453:
	ld wa,ix
	ld xbc,xiy
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3455:
	inc 1,iz
L3456:
	ld wa,iz
	cp wa,1024
	jr ult,L3453
L3454:
L3452:
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
	call _scr_map__23
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
	call _make_entry__23
	lda xsp,(xsp+16)
	pop xiy
	pop xix
	ld (xsp+4),wa
	ld ixl,0
	jr L3470
L3467:
	ld a,(xsp+28)
	add a,ixl
	and a,31
	ld (xsp+8),a
	ld a,(xsp+8)
	extz wa
	sll 5,wa
	ld (xsp+10),wa
	ld izl,0
	jr L3474
L3471:
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
L3473:
	inc 1,izl
L3474:
	ld a,izl
	cp a,(xsp+32)
	jr ult,L3471
L3472:
L3469:
	inc 1,ixl
L3470:
	ld a,ixl
	cp a,(xsp+36)
	jr ult,L3467
L3468:
L3466:
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
	call _scr_map__23
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
	jr L3488
L3485:
	ld a,(xsp+30)
	add a,(xsp+6)
	and a,31
	ld (xsp+8),a
	ld a,(xsp+8)
	extz wa
	sll 5,wa
	ld (xsp+10),wa
	ld ixl,0
	jr L3492
L3489:
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
L3491:
	inc 1,ixl
L3492:
	ld a,ixl
	cp a,(xsp+34)
	jr ult,L3489
L3490:
L3487:
	incb 1,(xsp+6)
L3488:
	ld a,(xsp+6)
	cp a,(xsp+38)
	jr ult,L3485
L3486:
L3484:
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
	call _pal_base__23
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
L3494:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_gfx_set_bg_color
_ngpc_gfx_set_bg_color:
	ld wa,(xsp+4)
	ld xbc,33760
	ld (xbc),wa
	ldb (08118h),128
L3496:
	ret

; function ngpc_gfx_scroll
_ngpc_gfx_scroll:
	ld a,(xsp+4)
	cp a,0
	jr nz,L3501
	ld a,(xsp+8)
	ld (08032h),a
	ld a,(xsp+12)
	ld (08033h),a
	jr L3502
L3501:
	ld a,(xsp+8)
	ld (08034h),a
	ld a,(xsp+12)
	ld (08035h),a
L3502:
L3500:
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
	jr nz,L3517
	ldb (08032h),0
	ldb (08033h),0
	jr L3518
L3517:
	ld a,(xsp+8)
	extz wa
	ld c,ixl
	cp c,0
	jr z,L3520
L3519:
	sra 1,wa
	djnz c,L3519
L3520:
	ld (08032h),a
	ld a,(xsp+12)
	extz wa
	ld c,ixl
	cp c,0
	jr z,L3522
L3521:
	sra 1,wa
	djnz c,L3521
L3522:
	ld (08033h),a
L3518:
	ld a,izl
	cp a,255
	jr nz,L3523
	ldb (08034h),0
	ldb (08035h),0
	jr L3524
L3523:
	ld a,(xsp+8)
	extz wa
	ld c,izl
	cp c,0
	jr z,L3526
L3525:
	sra 1,wa
	djnz c,L3525
L3526:
	ld (08034h),a
	ld a,(xsp+12)
	extz wa
	ld c,izl
	cp c,0
	jr z,L3528
L3527:
	sra 1,wa
	djnz c,L3527
L3528:
	ld (08035h),a
L3524:
L3516:
	pop xiz
	ret

; function ngpc_gfx_swap_planes
_ngpc_gfx_swap_planes:
	xorb (08030h),128
L3530:
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
L3532:
	ret

; function ngpc_gfx_sprite_offset
_ngpc_gfx_sprite_offset:
	ld a,(xsp+4)
	ld (08020h),a
	ld a,(xsp+8)
	ld (08021h),a
L3534:
	ret

; function ngpc_gfx_lcd_invert
_ngpc_gfx_lcd_invert:
	ld a,(xsp+4)
	cp a,0
	jr z,L3539
	orb (08012h),128
	jr L3540
L3539:
	andb (08012h),127
L3540:
L3538:
	ret

; function ngpc_gfx_set_outside_color
_ngpc_gfx_set_outside_color:
	ld a,(08012h)
	and a,248
	ld c,(xsp+4)
	and c,7
	or a,c
	ld (08012h),a
L3542:
	ret

; function ngpc_gfx_char_over
_ngpc_gfx_char_over:
	ld c,(08010h)
	extz bc
	and bc,128
	cp bc,0
	jr z,L3547
	ld wa,1
	jr L3548
L3547:
	ld wa,0
L3548:
	jr L3546
L3546:
	ret

; function ngpc_gfx_set_color_direct
_ngpc_gfx_set_color_direct:
	lda xsp,(xsp-4)
	ld a,(xsp+8)
	push xwa
	call _pal_base__23
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
L3550:
	lda xsp,(xsp+4)
	ret

; function ngpc_tile_rotate90
_ngpc_tile_rotate90:
	push xiz
	lda xsp,(xsp-6)
	ld ixl,0
	jr L3568
L3565:
	ld iy,0
	ld izl,0
	jr L3572
L3569:
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
	jr z,L3574
L3573:
	srl 1,wa
	djnz c,L3573
L3574:
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
	jr z,L3576
L3575:
	sll 1,bc
	djnz e,L3575
L3576:
	or wa,bc
	ld iy,wa
L3571:
	inc 1,izl
L3572:
	ld a,izl
	cp a,8
	jr ult,L3569
L3570:
	ld wa,iy
	ld xbc,(xsp+18)
	ld e,ixl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3567:
	inc 1,ixl
L3568:
	ld a,ixl
	cp a,8
	jp ult,L3565
L3566:
L3564:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_tile_rotate270
_ngpc_tile_rotate270:
	push xiz
	lda xsp,(xsp-6)
	ld ixl,0
	jr L3594
L3591:
	ld iy,0
	ld izl,0
	jr L3598
L3595:
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
	jr z,L3600
L3599:
	srl 1,wa
	djnz c,L3599
L3600:
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
	jr z,L3602
L3601:
	sll 1,bc
	djnz e,L3601
L3602:
	or wa,bc
	ld iy,wa
L3597:
	inc 1,izl
L3598:
	ld a,izl
	cp a,8
	jr ult,L3595
L3596:
	ld wa,iy
	ld xbc,(xsp+18)
	ld e,ixl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3593:
	inc 1,ixl
L3594:
	ld a,ixl
	cp a,8
	jp ult,L3591
L3592:
L3590:
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
L3604:
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
L3606:
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
L3608:
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
L3610:
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
L3612:
	lda xsp,(xsp+4)
	ret

; function ngpc_sprite_hide_all
_ngpc_sprite_hide_all:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L3622
L3619:
	ld a,izl
	push xwa
	call _ngpc_sprite_hide
	lda xsp,(xsp+4)
L3621:
	inc 1,izl
L3622:
	ld a,izl
	cp a,64
	jr ult,L3619
L3620:
L3618:
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
L3624:
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
L3626:
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
	jr L3628
L3628:
	ret

; function ngpc_text_print
_ngpc_text_print:
	push xiz
	lda xsp,(xsp-2)
	ld xiz,(xsp+26)
	ld a,(xsp+18)
	ld iyl,a
	jr L3638
L3636:
	ld a,(xiz)
	ld ixl,a
	ld a,ixl
	cp a,32
	jr ult,L3639
	ld a,ixl
	cp a,128
	jr uge,L3639
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
L3639:
	inc 1,iyl
	ld a,iyl
	cp a,20
	jr ult,L3640
	jr L3637
L3640:
	ld xwa,xiz
	inc 1,xwa
	ld xiz,xwa
L3638:
	ld a,(xiz)
	cp a,0
	jr nz,L3636
L3637:
L3635:
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
	jr L3654
L3651:
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
L3653:
	inc 1,izl
L3654:
	ld a,izl
	cp a,5
	jr ult,L3651
L3652:
	ld a,5
	sub a,(xsp+38)
	ld izl,a
	jr L3658
L3655:
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
L3657:
	inc 1,izl
L3658:
	ld a,izl
	cp a,5
	jr ult,L3655
L3656:
L3650:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_text_print_hex
_ngpc_text_print_hex:
	push xiz
	lda xsp,(xsp-8)
	ld izl,0
	jr L3672
L3669:
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
	jr z,L3674
L3673:
	srl 1,wa
	djnz c,L3673
L3674:
	and wa,15
	ld ixl,a
	ld a,ixl
	cp a,10
	jr uge,L3675
	ld a,ixl
	extz wa
	add wa,48
	ld iy,wa
	jr L3676
L3675:
	ld a,ixl
	extz wa
	sub wa,10
	add wa,65
	ld iy,wa
L3676:
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
L3671:
	inc 1,izl
L3672:
	ld a,izl
	cp a,(xsp+36)
	jp ult,L3669
L3670:
L3668:
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
	jr L3692
L3689:
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
L3691:
	inc 1,izl
L3692:
	ld a,izl
	cp a,5
	jr ult,L3689
L3690:
	ld a,5
	sub a,(xsp+40)
	ld izl,a
	jr L3696
L3693:
	ld a,(xsp+8)
	cp a,0
	jr z,L3697
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L3697
	ld a,izl
	cp a,4
	jr uge,L3697
	ld ix,32
	jr L3698
L3697:
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
L3698:
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
L3695:
	inc 1,izl
L3696:
	ld a,izl
	cp a,5
	jr ult,L3693
L3694:
L3688:
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
L3700:
	ret

; function ngpc_text_tile_screen
_ngpc_text_tile_screen:
	push xiz
	lda xsp,(xsp-4)
	ld wa,0
	ld (xsp+2),wa
	ld ixl,0
	jr L3714
L3711:
	ld izl,0
	jr L3718
L3715:
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
L3717:
	inc 1,izl
L3718:
	ld a,izl
	cp a,20
	jr ult,L3715
L3716:
L3713:
	inc 1,ixl
L3714:
	ld a,ixl
	cp a,19
	jr ult,L3711
L3712:
L3710:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function hud_score_reset
_hud_score_reset:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L3728
L3725:
	ld a,0
	ld xbc,_s_dig__26
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3727:
	inc 1,izl
L3728:
	ld a,izl
	cp a,7
	jr ult,L3725
L3726:
L3724:
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
	jr L3737
L3735:
	dec 1,izl
	ld xwa,_s_dig__26
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
	ld xbc,_s_dig__26
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,ix
	extz xwa
	div xwa,10
	ld iy,wa
L3737:
	ld wa,iy
	cp wa,0
	jr z,L3738
	ld a,izl
	cp a,0
	jr ugt,L3735
L3738:
L3736:
L3734:
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
	jr L3748
L3745:
	ld xwa,_gfx_font_tiles__26
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
L3747:
	inc 1,iz
L3748:
	ld wa,iz
	cp wa,552
	jr ult,L3745
L3746:
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
L3744:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function hud_reset
_hud_reset:
	ld a,255
	ld (_h_stage__26),a
	ld (_h_prog__26),a
	ld (_h_gear__26),a
	ld (_h_kmh__26),a
	ld (_h_time__26),a
	ldb (_h_score_ok__26),0
L3750:
	ret

; function hud_clear_top
_hud_clear_top:
	push xiz
	lda xsp,(xsp-2)
	push xix
	call _ovl_forget
	pop xix
	ld ixl,0
	jr L3764
L3761:
	ld izl,0
	jr L3768
L3765:
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
L3767:
	inc 1,izl
L3768:
	ld a,izl
	cp a,20
	jr ult,L3765
L3766:
L3763:
	inc 1,ixl
L3764:
	ld a,ixl
	cp a,15
	jr ult,L3761
L3762:
L3760:
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
	jr L3776
L3774:
	inc 1,izl
L3776:
	ld xwa,xix
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L3774
L3775:
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
L3773:
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
	jr L3786
L3783:
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
L3785:
	inc 1,izl
L3786:
	ld a,izl
	cp a,20
	jr ult,L3783
L3784:
L3782:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function put_digit
_put_digit__26:
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
L3788:
	ret

; function hud_race
_hud_race:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	cp a,(_h_time__26)
	jr z,L3814
	ld a,(_h_time__26)
	cp a,255
	jr nz,L3815
	ld xwa,_S26_0
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
L3815:
	ld c,(xsp+12)
	cp c,10
	jr uge,L3816
	ld wa,2
	jr L3817
L3816:
	ld wa,1
L3817:
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
	call _put_digit__26
	lda xsp,(xsp+16)
	ld c,(xsp+12)
	cp c,10
	jr uge,L3818
	ld wa,2
	jr L3819
L3818:
	ld wa,1
L3819:
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
	call _put_digit__26
	lda xsp,(xsp+16)
	ld a,(xsp+12)
	ld (_h_time__26),a
L3814:
	ld a,(xsp+28)
	cp a,(_h_stage__26)
	jr z,L3820
	ld xwa,_S26_1
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
	call _put_digit__26
	lda xsp,(xsp+16)
	ld a,(xsp+28)
	ld (_h_stage__26),a
	ldb (_h_prog__26),255
L3820:
	ld wa,(xsp+24)
	mul xwa,3
	add wa,9
	extz xwa
	div xwa,10
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,(_h_prog__26)
	jr z,L3821
	ld izl,0
	jr L3825
L3822:
	ld wa,0
	push xwa
	ld c,izl
	cp c,(xsp+5)
	jr uge,L3826
	ld wa,97
	jr L3827
L3826:
	ld wa,96
L3827:
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
L3824:
	inc 1,izl
L3825:
	ld a,izl
	cp a,3
	jr ult,L3822
L3823:
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
	ld (_h_prog__26),a
L3821:
	ld a,(xsp+16)
	cp a,(_h_kmh__26)
	jp z,L3828
	ld a,(xsp+16)
	extz wa
	sll 1,wa
	ld (xsp+2),wa
	ld a,(_h_kmh__26)
	cp a,255
	jr nz,L3829
	ld xwa,_S26_2
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
L3829:
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
	call _put_digit__26
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
	call _put_digit__26
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
	call _put_digit__26
	lda xsp,(xsp+16)
	ld a,(xsp+16)
	ld (_h_kmh__26),a
L3828:
	ld a,(xsp+20)
	cp a,(_h_gear__26)
	jr z,L3830
	ld c,(xsp+20)
	cp c,1
	jr nz,L3831
	ld xwa,_S26_3
	jr L3832
L3831:
	ld xwa,_S26_4
L3832:
	push xwa
	ld wa,1
	push xwa
	ld wa,16
	push xwa
	ld c,(xsp+32)
	cp c,1
	jr nz,L3833
	ld wa,1
	jr L3834
L3833:
	ld c,(xsp+32)
	cp c,2
	jr nz,L3835
	ld wa,2
	jr L3836
L3835:
	ld wa,0
L3836:
L3834:
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	ld a,(xsp+20)
	ld (_h_gear__26),a
L3830:
L3813:
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
	jr uge,L3841
	ld a,izl
	extz wa
	mul xwa,7
	extz xwa
	div xwa,6
	jr L3842
L3841:
	ld wa,112
	ld c,izl
	extz bc
	sub bc,96
	srl 3,bc
	sub wa,bc
L3842:
	ld (xsp+0),wa
	ld a,(xsp+14)
	extz wa
	mul xwa,(xsp+0)
	srl 7,wa
	jr L3840
L3840:
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
L3844:
	pop xiz
	ret

; function id_spr_put
_id_spr_put:
	push xiz
	lda xsp,(xsp-4)
	ld ix,(xsp+24)
	ld xwa,_spr_shadow
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
	ld xbc,_spr_pal_shadow
	ld e,(xsp+12)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3846:
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
	jr ult,L3853
	jr L3852
L3853:
	ld xwa,_spr_shadow+1
	ld c,iyl
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
	ld xiz,xwa
	ld a,(xsp+18)
	sub a,iyl
	ld ixl,a
L3854:
	ldb (xiz),0
	ld bc,4
	exts xbc
	ld xwa,xiz
	add xwa,xbc
	ld xiz,xwa
L3856:
	dec 1,ixl
	ld a,ixl
	cp a,0
	jr nz,L3854
L3855:
L3852:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function mesure_roues
_mesure_roues__29:
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
	jp L3888
L3885:
	ld a,(xsp+0)
	extz wa
	ld c,(_body__29+29)
	extz bc
	mul xwa,bc
	ld (xsp+6),a
	ld xwa,(_body__29+14)
	ld c,(xsp+6)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+7),a
	ld xwa,(_body__29+10)
	ld c,(xsp+6)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+8),a
	ldb (xsp+1),0
	jp L3892
L3889:
	ld xwa,(_body__29+22)
	ld c,(xsp+7)
	add c,(xsp+1)
	extz bc
	muls xbc,3
	add xwa,xbc
	ld a,(xwa)
	ld iyl,a
	ld xwa,(_body__29+22)
	ld c,(xsp+7)
	add c,(xsp+1)
	extz bc
	muls xbc,3
	add xwa,xbc
	ld a,(xwa+1)
	ld (xsp+10),a
	ld xwa,(_body__29+22)
	ld c,(xsp+7)
	add c,(xsp+1)
	extz bc
	muls xbc,3
	add xwa,xbc
	ld a,(xwa+2)
	extz wa
	ld (xsp+12),wa
	ld ixl,0
	jp L3896
L3893:
	ld xwa,(_body__29)
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
	jp L3900
L3897:
	ld wa,(xsp+16)
	ld bc,14
	ld de,2
	ld l,izl
	extz hl
	mul xde,hl
	sub bc,de
	cp c,0
	jr z,L3903
L3902:
	srl 1,wa
	djnz c,L3902
L3903:
	and wa,3
	cp wa,0
	jr nz,L3901
	jp L3899
L3901:
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	cp a,(xsp+2)
	jr ule,L3904
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld (xsp+2),a
	ldb (xsp+5),0
L3904:
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	cp a,(xsp+2)
	jr nz,L3905
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+5)
	jr ule,L3905
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+5),a
L3905:
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+3)
	jr ule,L3906
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+3),a
L3906:
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+4)
	jr uge,L3907
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+4),a
L3907:
L3899:
	inc 1,izl
L3900:
	ld a,izl
	cp a,8
	jp ult,L3897
L3898:
L3895:
	inc 1,ixl
L3896:
	ld a,ixl
	cp a,8
	jp ult,L3893
L3894:
L3891:
	incb 1,(xsp+1)
L3892:
	ld a,(xsp+1)
	cp a,(xsp+8)
	jp ult,L3889
L3890:
L3887:
	incb 1,(xsp+0)
L3888:
	ld a,(xsp+0)
	cp a,(_body__29+28)
	jp ult,L3885
L3886:
	ld a,(xsp+4)
	cp a,(xsp+3)
	jr ule,L3908
	ld xwa,(_body__29+18)
	ld a,(xwa)
	extz wa
	sll 2,wa
	ld (_car_wheel_dx__29),a
	jr L3884
L3908:
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
	jr ule,L3909
	ld wa,(xsp+6)
	sub wa,(xsp+8)
	srl 1,wa
	extz wa
	jr L3910
L3909:
	ld wa,0
L3910:
	ld (_car_wheel_dx__29),a
L3884:
	lda xsp,(xsp+20)
	pop xiz
	ret

; function id_car_select
_id_car_select:
	ld c,(xsp+4)
	cp c,1
	jr uge,L3915
	ld a,(xsp+4)
	extz wa
	jr L3916
L3915:
	ld a,0
	extz wa
L3916:
	ld (_car_variant__29),a
	ld xwa,_body__29
	push xwa
	ld a,(_car_variant__29)
	push xwa
	call _id_fleet_body
	lda xsp,(xsp+8)
	call _mesure_roues__29
L3914:
	ret

; function id_car_char_count
_id_car_char_count:
	ld c,(xsp+4)
	cp c,0
	jr z,L3921
	ld wa,(_body__29+4)
	jr L3922
L3921:
	ld wa,(_body__29+26)
L3922:
	srl 3,wa
	jr L3920
L3920:
	ret

; function id_car_half_width
_id_car_half_width:
	ld xwa,(_body__29+18)
	ld a,(xwa)
	extz wa
	sll 2,wa
	jr L3924
L3924:
	ret

; function id_car_wheel_dx
_id_car_wheel_dx:
	ld a,(_car_wheel_dx__29)
	jr L3926
L3926:
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
	ld xwa,(_body__29)
	ld (xsp+4),xwa
	ld wa,(xsp+24)
	ld (_car_tile_base__29),wa
	ld ix,0
	jr L3942
L3939:
	ld wa,40960
	extz xwa
	ld bc,(xsp+24)
	add bc,ix
	mul xbc,16
	add xwa,xbc
	ld (xsp+8),xwa
	ld iz,0
	jr L3946
L3943:
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
L3945:
	inc 1,iz
L3946:
	ld wa,iz
	cp wa,8
	jr ult,L3943
L3944:
L3941:
	inc 1,ix
L3942:
	ld wa,ix
	cp wa,(xsp+2)
	jr ult,L3939
L3940:
	push xix
	push xiy
	ld xwa,(_body__29+6)
	ld wa,(xwa+6)
	push xwa
	ld xwa,(_body__29+6)
	ld wa,(xwa+4)
	push xwa
	ld xwa,(_body__29+6)
	ld wa,(xwa+2)
	push xwa
	ld xwa,(_body__29+6)
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
	ld a,(_body__29+28)
	cp a,1
	jr ule,L3947
	push xix
	push xiy
	ld xwa,(_body__29+6)
	ld wa,(xwa+14)
	push xwa
	ld xwa,(_body__29+6)
	ld wa,(xwa+12)
	push xwa
	ld xwa,(_body__29+6)
	ld wa,(xwa+10)
	push xwa
	ld xwa,(_body__29+6)
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
	jr L3948
L3947:
	push xix
	push xiy
	ld xwa,(_body__29+6)
	ld wa,(xwa+6)
	push xwa
	ld xwa,(_body__29+6)
	ld wa,(xwa+4)
	push xwa
	ld xwa,(_body__29+6)
	ld wa,(xwa+2)
	push xwa
	ld xwa,(_body__29+6)
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
L3948:
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
L3938:
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
	ld c,(_body__29+29)
	extz bc
	mul xwa,bc
	sub wa,2
	ld (xsp+3),a
	ld a,(_body__29+29)
	cp a,2
	jr uge,L3981
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
	jp L3980
L3981:
	ld a,(xsp+50)
	extz wa
	exts xwa
	ld c,(xsp+3)
	extz bc
	divs xwa,bc
	ld wa,qwa
	ld (xsp+50),a
	ld a,(xsp+50)
	cp a,(_body__29+29)
	jr uge,L3982
	ld a,(xsp+50)
	ld (xsp+4),a
	ldb (xsp+5),0
	jr L3983
L3982:
	ld a,(xsp+3)
	sub a,(xsp+50)
	ld (xsp+4),a
	ldb (xsp+5),1
L3983:
	ld xwa,(_body__29+14)
	ld c,(xsp+4)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+9),a
	ld xwa,(_body__29+10)
	ld c,(xsp+4)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+10),a
	ld xwa,(_body__29+18)
	ld c,(xsp+4)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+11),a
	ldb (xsp+6),255
	ldb (xsp+7),0
	ld izl,0
	jr L3987
L3984:
	ld xwa,(_body__29+22)
	ld c,(xsp+9)
	add c,izl
	extz bc
	muls xbc,3
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+12),a
	ld c,(xsp+5)
	cp c,0
	jr z,L3988
	ld a,(xsp+11)
	sub a,1
	sub a,(xsp+12)
	extz wa
	jr L3989
L3988:
	ld a,(xsp+12)
	extz wa
L3989:
	ld (xsp+13),a
	ld a,(xsp+13)
	cp a,(xsp+6)
	jr uge,L3990
	ld a,(xsp+13)
	ld (xsp+6),a
L3990:
	ld a,(xsp+13)
	cp a,(xsp+7)
	jr ule,L3991
	ld a,(xsp+13)
	ld (xsp+7),a
L3991:
L3986:
	inc 1,izl
L3987:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L3984
L3985:
	ld a,(xsp+6)
	cp a,(xsp+7)
	jr ule,L3992
	ldb (xsp+6),0
	ldb (xsp+7),0
L3992:
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
	jp L3996
L3993:
	ld a,(_body__29+28)
	sub a,1
	sub a,(xsp+1)
	ld (xsp+9),a
	ld xwa,(_body__29+14)
	ld c,(xsp+9)
	extz bc
	ld e,(_body__29+29)
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
	ld xwa,(_body__29+10)
	ld c,(xsp+9)
	extz bc
	ld e,(_body__29+29)
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
	ld xwa,(_body__29+18)
	ld c,(xsp+9)
	extz bc
	ld e,(_body__29+29)
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
	jr nz,L3997
	ld wa,0
	jr L3998
L3997:
	ld wa,5
L3998:
	ld (xsp+13),a
	ld izl,0
	jp L4002
L3999:
	ld xwa,(_body__29+22)
	ld c,(xsp+10)
	add c,izl
	extz bc
	muls xbc,3
	add xwa,xbc
	lda xwa,(xwa)
	ld xiy,xwa
	ld c,(xsp+5)
	cp c,0
	jr z,L4003
	ld a,(xsp+12)
	sub a,1
	sub a,(xiy)
	extz wa
	jr L4004
L4003:
	ld a,(xiy)
	extz wa
L4004:
	ld (xsp+18),a
L4005:
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
	ld wa,(_car_tile_base__29)
	ld c,(xiy+2)
	extz bc
	add wa,bc
	ld (xsp+22),wa
	ld a,(xsp+13)
	ld (xsp+24),a
	ld c,(xsp+5)
	cp c,0
	jr z,L4008
	ld wa,128
	jr L4009
L4008:
	ld wa,0
L4009:
	ld (xsp+25),a
	ld xwa,_spr_shadow
	ld c,(xsp+19)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
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
	ld xbc,_spr_pal_shadow
	ld e,(xsp+19)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L4007:
L4006:
	incb 1,(xsp+2)
L4001:
	inc 1,izl
L4002:
	ld a,izl
	cp a,(xsp+11)
	jr uge,L4010
	ld a,(xsp+2)
	cp a,64
	jp ult,L3999
L4010:
L4000:
L3995:
	incb 1,(xsp+1)
L3996:
	ld a,(xsp+1)
	cp a,(_body__29+28)
	jp ult,L3993
L3994:
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
L3980:
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
	jp L4030
L4027:
	ld a,(_body__29+28)
	sub a,1
	sub a,(xsp+1)
	ld (xsp+3),a
	ld xwa,(_body__29+14)
	ld c,(xsp+3)
	extz bc
	ld e,(_body__29+29)
	extz de
	mul xbc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+4),a
	ld xwa,(_body__29+10)
	ld c,(xsp+3)
	extz bc
	ld e,(_body__29+29)
	extz de
	mul xbc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+5),a
	ld c,(xsp+3)
	cp c,0
	jr nz,L4031
	ld wa,0
	jr L4032
L4031:
	ld wa,5
L4032:
	ld (xsp+6),a
	ldb (xsp+0),0
	jp L4036
L4033:
	ld xwa,(_body__29+22)
	ld c,(xsp+4)
	add c,(xsp+0)
	extz bc
	muls xbc,3
	add xwa,xbc
	lda xwa,(xwa)
	ld xiy,xwa
L4037:
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
	ld wa,(_car_tile_base__29)
	ld c,(xiy+2)
	extz bc
	add wa,bc
	ld ix,wa
	ld a,(xsp+6)
	ld (xsp+18),a
	ld a,0
	ld (xsp+19),a
	ld xwa,_spr_shadow
	ld c,(xsp+12)
	extz bc
	sll 2,bc
	extz xbc
	add xwa,xbc
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
	ld xbc,_spr_pal_shadow
	ld e,(xsp+12)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L4039:
L4038:
	incb 1,(xsp+2)
L4035:
	incb 1,(xsp+0)
L4036:
	ld a,(xsp+0)
	cp a,(xsp+5)
	jr uge,L4040
	ld a,(xsp+2)
	cp a,64
	jp ult,L4033
L4040:
L4034:
L4029:
	incb 1,(xsp+1)
L4030:
	ld a,(xsp+1)
	cp a,(_body__29+28)
	jp ult,L4027
L4028:
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
L4026:
	lda xsp,(xsp+24)
	pop xiz
	ret

; function car_layer
_car_layer__29:
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
	ld wa,(_car_tile_base__29)
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
	ld wa,(_car_at_x__29)
	cp wa,32767
	jr z,L4046
	ld wa,(_car_at_x__29)
	ld (xsp+10),wa
L4046:
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
	jr z,L4047
	ld wa,128
	jr L4048
L4047:
	ld wa,0
L4048:
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
L4045:
	lda xsp,(xsp+22)
	ret

; function lean_last
_lean_last__29:
	push xiz
	lda xsp,(xsp-2)
	ld c,(_body__29+29)
	cp c,0
	jr ule,L4054
	ld a,(_body__29+29)
	extz wa
	sub wa,1
	jr L4055
L4054:
	ld wa,0
L4055:
	ld izl,a
	ld a,izl
	cp a,2
	jr ule,L4056
	ld izl,2
L4056:
	ld a,izl
	jr L4053
L4053:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function lean_pose
_lean_pose__29:
	push xiz
	lda xsp,(xsp-2)
	call _lean_last__29
	ld (xsp+0),a
	ld a,(_lean_hold__29)
	cp a,0
	jr nz,L4066
	ld wa,0
	jr L4065
L4066:
	ld c,(_lean_hold__29)
	cp c,12
	jr ult,L4067
	ld wa,3
	jr L4068
L4067:
	ld c,(_lean_hold__29)
	cp c,5
	jr ult,L4069
	ld wa,2
	jr L4070
L4069:
	ld wa,1
L4070:
L4068:
	ld izl,a
	ld c,izl
	cp c,(xsp+0)
	jr ule,L4071
	ld a,(xsp+0)
	extz wa
	jr L4072
L4071:
	ld a,izl
	extz wa
L4072:
	jr L4065
L4065:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_car_lean_share
_id_car_lean_share:
	push xiz
	lda xsp,(xsp-4)
	call _lean_last__29
	ld (xsp+0),a
	call _lean_pose__29
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,0
	jr z,L4081
	ld a,(xsp+0)
	cp a,0
	jr nz,L4080
L4081:
	ld wa,0
	jr L4079
L4080:
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
	jr le,L4082
	ld iz,16
L4082:
	ld c,(_lean_side__29)
	cp c,0
	jr ge,L4083
	ld wa,iz
	neg wa
	jr L4084
L4083:
	ld wa,iz
L4084:
	jr L4079
L4079:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function id_car_last_x
_id_car_last_x:
	ld wa,(_car_last_x__29)
	jr L4086
L4086:
	ret

; function id_car_last_top
_id_car_last_top:
	ld a,(_car_last_top__29)
	jr L4088
L4088:
	ret

; function id_car_draw
_id_car_draw:
	push xiz
	lda xsp,(xsp-8)
	ld a,(xsp+20)
	cp a,0
	jr z,L4117
	ld a,(_lean_side__29)
	cp a,(xsp+20)
	jr z,L4118
	ld a,(xsp+20)
	ld (_lean_side__29),a
	ldb (_lean_hold__29),0
L4118:
	ld a,(_lean_hold__29)
	cp a,255
	jr uge,L4119
	incb 1,(_lean_hold__29)
L4119:
	ldb (_lean_wait__29),2
	jr L4120
L4117:
	ld a,(_lean_hold__29)
	cp a,0
	jr z,L4121
	ld a,(_lean_wait__29)
	cp a,0
	jr z,L4122
	decb 1,(_lean_wait__29)
	jr L4123
L4122:
	ldb (_lean_wait__29),2
	ld a,(_lean_hold__29)
	cp a,12
	jr ult,L4124
	ldb (_lean_hold__29),11
	jr L4125
L4124:
	ld a,(_lean_hold__29)
	cp a,5
	jr ult,L4126
	ldb (_lean_hold__29),4
	jr L4127
L4126:
	ldb (_lean_hold__29),0
L4127:
L4125:
L4123:
L4121:
L4120:
	ld a,(xsp+24)
	cp a,0
	jr nz,L4128
	ldb (_bump_phase__29),0
	ldb (xsp+2),0
	jr L4129
L4128:
	incb 1,(_bump_phase__29)
	ld c,(_bump_phase__29)
	extz bc
	and bc,2
	cp bc,0
	jr z,L4130
	ld a,(xsp+24)
	extz wa
	jr L4131
L4130:
	ld wa,0
L4131:
	ld (xsp+2),a
L4129:
	ld a,148
	ld c,(_body__29+30)
	sub a,c
	add a,(_body__29+30)
	sub a,1
	ld (xsp+4),a
	ld a,148
	ld c,(_body__29+30)
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
	jr ge,L4132
	ld wa,0
	jr L4133
L4132:
	ld wa,(xsp+6)
L4133:
	ld (xsp+3),a
	ld a,(xsp+4)
	push xwa
	call _id_road_centre_at
	lda xsp,(xsp+4)
	ld xbc,(_body__29+18)
	ld c,(xbc)
	extz bc
	sll 2,bc
	sub wa,bc
	add wa,(xsp+16)
	ld (_car_last_x__29),wa
	ld a,(xsp+3)
	sub a,(xsp+2)
	ld (_car_last_top__29),a
	ld a,(_body__29+28)
	cp a,1
	jp ule,L4134
	call _lean_pose__29
	ld (xsp+0),a
	ldb (xsp+1),0
	ld c,(xsp+0)
	cp c,0
	jr nz,L4135
	ld wa,0
	jr L4136
L4135:
	ld c,(_lean_side__29)
	cp c,0
	jr ge,L4137
	ld wa,2
	jr L4138
L4137:
	ld wa,1
L4138:
L4136:
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
	ld xwa,(_body__29+18)
	ld c,(_body__29+29)
	extz bc
	ld e,izl
	extz de
	add bc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+10)
	ld c,(_body__29+29)
	extz bc
	ld e,izl
	extz de
	add bc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+14)
	ld c,(_body__29+29)
	extz bc
	ld e,izl
	extz de
	add bc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+22)
	push xwa
	call _car_layer__29
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
	ld xwa,(_body__29+18)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+10)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+14)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+22)
	push xwa
	call _car_layer__29
	lda xsp,(xsp+48)
	jp L4116
L4134:
	ld c,(_lean_hold__29)
	cp c,0
	jr nz,L4139
	ld wa,0
	jr L4140
L4139:
	ld wa,1
L4140:
	ld (xsp+0),a
	ld c,(_lean_side__29)
	cp c,0
	jr le,L4141
	ld wa,1
	jr L4142
L4141:
	ld wa,0
L4142:
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
	ld xwa,(_body__29+18)
	ld c,(xsp+32)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+10)
	ld c,(xsp+36)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+14)
	ld c,(xsp+40)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+22)
	push xwa
	call _car_layer__29
	lda xsp,(xsp+48)
	ld a,24
	push xwa
	ld a,12
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L4116:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function id_car_draw_at
_id_car_draw_at:
	ld wa,(xsp+4)
	ld (_car_at_x__29),wa
	ld a,(_body__29+28)
	cp a,1
	jr ule,L4146
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
	ld xwa,(_body__29+18)
	ld c,(_body__29+29)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+10)
	ld c,(_body__29+29)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+14)
	ld c,(_body__29+29)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+22)
	push xwa
	call _car_layer__29
	lda xsp,(xsp+48)
L4146:
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
	ld xwa,(_body__29+18)
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+10)
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+14)
	ld a,(xwa)
	push xwa
	ld xwa,(_body__29+22)
	push xwa
	call _car_layer__29
	lda xsp,(xsp+48)
	ldw (_car_at_x__29),32767
L4145:
	ret

; function id_car_height
_id_car_height:
	ld a,(_body__29+30)
	jr L4148
L4148:
	ret

; function id_car_tile_base
_id_car_tile_base:
	ld wa,(_car_tile_base__29)
	jr L4150
L4150:
	ret

; function id_car_restore
_id_car_restore:
	ld wa,0
	push xwa
	ld wa,(_car_tile_base__29)
	push xwa
	call _id_car_init
	lda xsp,(xsp+8)
L4152:
	ret

; function course_art
_course_art__30:
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
L4154:
	pop xiz
	ret

; function uses_akina
_uses_akina__30:
	ld wa,0
	jr L4156
L4156:
	ret

; function id_road_horizon
_id_road_horizon:
	ld xwa,_course_horizon__30
	ld c,(_road_course__30)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	jr L4158
L4158:
	ret

; function sky_is_tall_course
_sky_is_tall_course__30:
	ld wa,0
	jr L4160
L4160:
	ret

; function road_is_tarmac
_road_is_tarmac__30:
	ld wa,1
	jr L4162
L4162:
	ret

; function id_build_weights
_id_build_weights__30:
	push xiz
	lda xsp,(xsp-14)
	ld a,(_road_lines__30)
	extz wa
	sub wa,1
	ld (xsp+2),wa
	ld a,(_road_lines__30)
	extz wa
	ld c,(_road_lines__30)
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
	ld (_id_curve_cm__30),wa
	ld izl,0
	jp L4197
L4194:
	push xix
	push xiy
	call _uses_akina__30
	pop xiy
	pop xix
	cp a,0
	jp nz,L4198
	ld a,(_art__30+22)
	extz wa
	srl 3,wa
	extz wa
	add wa,1
	sll 3,wa
	sub wa,1
	ld c,(_art__30+21)
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
	jr ule,L4199
	ld wa,(xsp+6)
	ld (xsp+8),wa
L4199:
	ld a,(xsp+8)
	ld xbc,_id_src__30
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(_art__30+16)
	ld bc,(xsp+8)
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld xbc,_id_half__30
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
	jr L4200
L4198:
	ld a,izl
	ld xbc,_id_src__30
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(_art__30+16)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld xbc,_id_half__30
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
L4200:
	ld wa,255
	sub wa,iy
	ld (xsp+6),wa
	ld a,(_road_top__30)
	add a,izl
	ld xbc,_id_sl__30
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,iyl
	ld xbc,_id_w_lat__30
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+6)
	mul xwa,(xsp+6)
	srl 8,wa
	ld xbc,_id_w_curve__30
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,iy
	cp wa,0
	jr nz,L4201
	ld wa,1600
	ld xbc,_id_ahead__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jr L4202
L4201:
	ld wa,60
	mul xwa,(xsp+6)
	extz xwa
	div xwa,iy
	ld (xsp+8),wa
	ld bc,(xsp+8)
	cp bc,1600
	jr ule,L4203
	ld wa,1600
	jr L4204
L4203:
	ld wa,(xsp+8)
L4204:
	ld xbc,_id_ahead__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4202:
	ld a,izl
	extz wa
	mul xwa,47
	extz xwa
	ld c,(_road_lines__30)
	extz bc
	sub bc,1
	div xwa,bc
	ld (xsp+8),wa
	ld wa,47
	ld xbc,_id_ahead__30
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
	jr ule,L4205
	ld wa,47
	jr L4206
L4205:
	ld wa,(xsp+12)
L4206:
	ld xbc,_id_sl__30+128
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L4196:
	inc 1,izl
L4197:
	ld a,izl
	cp a,(_road_lines__30)
	jp ult,L4194
L4195:
	ld a,(_road_lines__30)
	sub a,1
	ld (_wide_k0__30),a
	jr L4209
L4207:
	decb 1,(_wide_k0__30)
L4209:
	ld a,(_wide_k0__30)
	cp a,0
	jr ule,L4210
	ld xwa,_id_src__30
	ld c,(_wide_k0__30)
	sub c,1
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,48
	jr uge,L4207
L4210:
L4208:
	ld a,(_road_top__30)
	sub a,8
	ld (_climb_room__30),a
	push xix
	push xiy
	call _uses_akina__30
	pop xiy
	pop xix
	cp a,0
	jr z,L4211
	ld a,(_road_lines__30)
	extz wa
	extz xwa
	div xwa,10
	ld (_descent_room__30),a
	jr L4212
L4211:
	ld a,(_road_lines__30)
	extz wa
	srl 1,wa
	ld (_descent_room__30),a
L4212:
	ldb (_grade_hi__30),0
	ldb (_grade_lo__30),0
	ld ix,1
	jr L4216
L4213:
	ld a,(_road_lines__30)
	extz wa
	ld xbc,_hill_rate__30
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
	ld c,(_road_lines__30)
	extz bc
	ld e,(_climb_room__30)
	extz de
	add bc,de
	cp wa,bc
	jr ugt,L4217
	ld a,ixl
	ld (_grade_hi__30),a
L4217:
L4215:
	inc 1,ix
L4216:
	ld wa,ix
	cp wa,20
	jr le,L4213
L4214:
	ld ix,1
	jr L4221
L4218:
	ld a,(_road_lines__30)
	extz wa
	ld xbc,_hill_rate__30
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
	ld c,(_descent_room__30)
	extz bc
	add wa,bc
	ld c,(_road_lines__30)
	extz bc
	cp wa,bc
	jr ult,L4222
	ld a,ixl
	neg a
	ld (_grade_lo__30),a
L4222:
L4220:
	inc 1,ix
L4221:
	ld wa,ix
	cp wa,20
	jr le,L4218
L4219:
L4193:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function rally_scan
_rally_scan__30:
	push xiz
	lda xsp,(xsp-6)
	ld a,(_rally_scanned__30)
	cp a,0
	jr z,L4241
	jp L4240
L4241:
	ldw (xsp+0),0
	jr L4245
L4242:
	ld a,255
	ld xbc,_rally_of__30
	ld de,(xsp+0)
	extz xde
	add xbc,xde
	ld (xbc),a
L4244:
	incw 1,(xsp+0)
L4245:
	ld wa,(xsp+0)
	cp wa,512
	jr ult,L4242
L4243:
	ldb (_rally_used__30),0
	ld a,(_art__30+21)
	extz wa
	srl 3,wa
	ld iyl,a
	jp L4249
L4246:
	ld ixl,0
	jr L4253
L4250:
	ld xwa,(_art__30+4)
	ld c,iyl
	extz bc
	ld e,(_art__30+20)
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
	jr uge,L4255
	ld xwa,_rally_of__30
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,255
	jr z,L4254
L4255:
	jr L4252
L4254:
	ld a,(_rally_used__30)
	cp a,255
	jr ult,L4256
	jr L4252
L4256:
	ld a,(_rally_used__30)
	ld xbc,_rally_of__30
	ld de,iz
	extz xde
	add xbc,xde
	ld (xbc),a
	ld wa,iz
	ld xbc,_rally_src__30
	ld e,(_rally_used__30)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	incb 1,(_rally_used__30)
L4252:
	inc 1,ixl
L4253:
	ld a,ixl
	cp a,(_art__30+20)
	jp ult,L4250
L4251:
L4248:
	inc 1,iyl
L4249:
	ld a,iyl
	cp a,29
	jp ult,L4246
L4247:
	ldb (_rally_scanned__30),1
L4240:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function id_road_char_count
_id_road_char_count:
	call _rally_scan__30
	ld a,(_rally_used__30)
	extz wa
	jr L4258
L4258:
	ret

; function id_load_chars
_id_load_chars__30:
	push xiz
	lda xsp,(xsp-18)
	push xix
	push xiy
	call _id_road_char_count
	pop xiy
	pop xix
	ld (xsp+2),wa
	ld xwa,(_art__30)
	ld (xsp+4),xwa
	ld ix,0
	jp L4274
L4271:
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
	call _uses_akina__30
	ld xbc,xwa
	pop xiy
	pop xix
	pop xwa
	cp c,0
	jr nz,L4275
	ld xwa,_rally_src__30
	ld bc,ix
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L4276
L4275:
	ld wa,ix
L4276:
	ld (xsp+12),wa
	ld iz,0
	jr L4280
L4277:
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
L4279:
	inc 1,iz
L4280:
	ld wa,iz
	cp wa,8
	jr ult,L4277
L4278:
L4273:
	inc 1,ix
L4274:
	ld wa,ix
	cp wa,(xsp+2)
	jp ult,L4271
L4272:
L4270:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_load_palettes
_id_load_palettes__30:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L4290
L4287:
	ld xwa,(_art__30+12)
	ld c,izl
	extz bc
	sll 2,bc
	add bc,3
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,(_art__30+12)
	ld c,izl
	extz bc
	sll 2,bc
	add bc,2
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,(_art__30+12)
	ld c,izl
	extz bc
	sll 2,bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,(_art__30+12)
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
L4289:
	inc 1,izl
L4290:
	ld a,izl
	cp a,8
	jp ult,L4287
L4288:
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
	ld xwa,(_art__30+12)
	ld wa,(xwa)
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
L4286:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_reload_backdrop
_id_road_reload_backdrop:
	ld xwa,(_art__30+12)
	ld wa,(xwa)
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
L4292:
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
	jr L4302
L4299:
	ld xwa,xix
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_band_col__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4301:
	inc 1,izl
L4302:
	ld a,izl
	cp a,4
	jr ult,L4299
L4300:
	ldw (_bc_rest__30),65535
	ldw (_bc_rest__30+2),65535
L4298:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_load_maps_rally
_id_load_maps_rally__30:
	push xiz
	lda xsp,(xsp-12)
	ld a,(_road_plane0__30)
	extz wa
	srl 3,wa
	exts wa
	ld c,(_art__30+21)
	extz bc
	srl 3,bc
	exts bc
	sub wa,bc
	ld (xsp+2),a
	push xix
	push xiy
	call _rally_scan__30
	pop xiy
	pop xix
	ld a,(_road_plane0__30)
	extz wa
	srl 3,wa
	ld iyl,a
	jp L4324
L4321:
	ld a,iyl
	ld c,(xsp+2)
	sub a,c
	ld (xsp+3),a
	ld a,(xsp+3)
	cp a,28
	jr ule,L4325
	ldb (xsp+3),28
L4325:
	ld izl,0
	jp L4329
L4326:
	ld wa,0
	ld (xsp+4),a
	ld a,(xsp+3)
	ld (xsp+5),a
	ld a,izl
	cp a,0
	jr uge,L4330
	ld a,(_art__30+21)
	extz wa
	srl 3,wa
	ld (xsp+5),a
	jr L4331
L4330:
	ld a,izl
	ld c,0
	add c,(_art__30+20)
	cp a,c
	jr ult,L4332
	ld a,(_art__30+20)
	sub a,1
	ld (xsp+4),a
	ld a,(_art__30+21)
	extz wa
	srl 3,wa
	ld (xsp+5),a
	jr L4333
L4332:
	ld a,izl
	sub a,0
	ld (xsp+4),a
L4333:
L4331:
	ld a,(xsp+5)
	extz wa
	ld c,(_art__30+20)
	extz bc
	mul xwa,bc
	ld c,(xsp+4)
	extz bc
	add wa,bc
	ld (xsp+6),wa
	ld xwa,(_art__30+4)
	ld bc,(xsp+6)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+8),wa
	ld bc,(xsp+8)
	cp bc,512
	jr uge,L4334
	ld xwa,_rally_of__30
	ld bc,(xsp+8)
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L4335
L4334:
	ld wa,255
L4335:
	ld ixl,a
	ld a,ixl
	cp a,255
	jr nz,L4336
	ld ixl,0
L4336:
	ld wa,128
	ld c,ixl
	extz bc
	add wa,bc
	ld xbc,(_art__30+8)
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
L4328:
	inc 1,izl
L4329:
	ld a,izl
	cp a,32
	jp ult,L4326
L4327:
L4323:
	inc 1,iyl
L4324:
	ld a,iyl
	cp a,32
	jp ult,L4321
L4322:
L4320:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function id_load_maps
_id_load_maps__30:
	call _id_load_maps_rally__30
L4338:
	ret

; function id_road_reload_maps
_id_road_reload_maps:
	call _id_load_palettes__30
	call _id_load_maps_rally__30
L4340:
	ret

; function id_build_shear_limits
_id_build_shear_limits__30:
	push xiz
	lda xsp,(xsp-18)
	push xix
	push xiy
	call _uses_akina__30
	pop xiy
	pop xix
	cp a,0
	jp nz,L4372
	ld izl,0
	jr L4376
L4373:
	ld xwa,_id_src__30
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
	jr uge,L4377
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
	jr ge,L4378
	ld wa,(xsp+4)
	ld (xsp+2),wa
L4378:
L4377:
	ld wa,(xsp+2)
	neg wa
	ld xbc,_id_dxc__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+2)
	ld xbc,_id_dxc__30+128
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4375:
	inc 1,izl
L4376:
	ld a,izl
	cp a,(_road_lines__30)
	jp ult,L4373
L4374:
	jp L4371
L4372:
	ld izl,0
	jp L4382
L4379:
	ld a,(_road_top__30)
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
	jr L4386
L4383:
	ld wa,0
	ld (xsp+10),wa
	ld wa,0
	ld (xsp+12),wa
	ld wa,(xsp+12)
	cp wa,0
	jr nz,L4387
	jr L4385
L4387:
	ld ixl,0
	jr L4391
L4388:
	ld wa,(xsp+12)
	ld bc,14
	ld de,2
	ld l,ixl
	extz hl
	mul xde,hl
	sub bc,de
	cp c,0
	jr z,L4394
L4393:
	srl 1,wa
	djnz c,L4393
L4394:
	and wa,3
	cp wa,0
	jr z,L4392
	ld a,(xsp+4)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld iy,wa
	ld wa,iy
	cp wa,(xsp+6)
	jr uge,L4395
	ld wa,iy
	ld (xsp+6),wa
L4395:
	ld wa,iy
	cp wa,(xsp+8)
	jr ule,L4396
	ld wa,iy
	ld (xsp+8),wa
L4396:
L4392:
L4390:
	inc 1,ixl
L4391:
	ld a,ixl
	cp a,8
	jr ult,L4388
L4389:
L4385:
	incb 1,(xsp+4)
L4386:
	ld a,(xsp+4)
	cp a,32
	jr ult,L4383
L4384:
	ld wa,(xsp+6)
	cp wa,(xsp+8)
	jr ule,L4397
	ld wa,65409
	ld xbc,_id_dxc__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,127
	ld xbc,_id_dxc__30+128
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jr L4398
L4397:
	ld wa,(xsp+8)
	sub wa,255
	sub wa,7
	ld xbc,_id_dxc__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+6)
	add wa,97
	sub wa,7
	ld xbc,_id_dxc__30+128
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4398:
	ld xwa,_id_dxc__30+128
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,88
	jr le,L4399
	ld wa,88
	ld xbc,_id_dxc__30+128
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4399:
	ld xwa,_id_dxc__30
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65448
	jr ge,L4400
	ld wa,65448
	ld xbc,_id_dxc__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4400:
L4381:
	inc 1,izl
L4382:
	ld a,izl
	cp a,(_road_lines__30)
	jp ult,L4379
L4380:
L4371:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_road_course
_id_road_course:
	ld a,(_road_course__30)
	jr L4402
L4402:
	ret

; function id_road_top
_id_road_top:
	ld a,(_road_top__30)
	jr L4404
L4404:
	ret

; function id_road_bottom
_id_road_bottom:
	ld a,(_road_bottom__30)
	jr L4406
L4406:
	ret

; function id_road_select
_id_road_select:
	push xiz
	lda xsp,(xsp-14)
	ld c,(xsp+22)
	cp c,1
	jr uge,L4446
	ld a,(xsp+22)
	extz wa
	jr L4447
L4446:
	ld wa,0
L4447:
	ld (_road_course__30),a
	push xix
	ld wa,0
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
	pop xix
	push xix
	call _uses_akina__30
	pop xix
	cp a,0
	jr nz,L4448
	push xix
	ld xwa,_art__30
	push xwa
	ld a,(_road_course__30)
	push xwa
	call _course_art__30
	lda xsp,(xsp+8)
	pop xix
	ldb (_rally_scanned__30),0
L4448:
	push xix
	call _uses_akina__30
	pop xix
	cp a,0
	jr nz,L4449
	ldb (_road_base_x__30),48
	ldb (_road_top__30),88
	push xwa
	push xix
	call _sky_is_tall_course__30
	ld xbc,xwa
	pop xix
	pop xwa
	cp c,0
	jr z,L4450
	ld a,88
	extz wa
	jr L4451
L4450:
	ld a,88
	extz wa
L4451:
	ld (_road_plane0__30),a
	ldb (_road_lines__30),64
	jr L4452
L4449:
	ldb (_road_base_x__30),7
	ldb (_road_top__30),72
	ldb (_road_plane0__30),72
	ldb (_road_lines__30),40
L4452:
	ld a,(_road_top__30)
	add a,(_road_lines__30)
	sub a,1
	ld (_road_bottom__30),a
	ld a,(_road_lines__30)
	extz wa
	extz xwa
	div xwa,6
	ld (_car_stand__30),a
	ld a,(_car_stand__30)
	cp a,(_road_lines__30)
	jr ult,L4453
	ld a,(_road_lines__30)
	sub a,1
	ld (_car_stand__30),a
L4453:
	push xix
	call _id_load_chars__30
	pop xix
	push xix
	call _id_load_palettes__30
	pop xix
	push xix
	call _uses_akina__30
	pop xix
	cp a,0
	jr nz,L4454
	push xix
	call _id_load_maps_rally__30
	pop xix
	jr L4455
L4454:
	push xix
	call _id_load_maps__30
	pop xix
L4455:
	ldb (xsp+0),0
	jr L4459
L4456:
	ld wa,0
	ld xbc,_id_shear__30
	ld e,(xsp+0)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4458:
	incb 1,(xsp+0)
L4459:
	ld a,(xsp+0)
	cp a,(_road_lines__30)
	jr ult,L4456
L4457:
	ldw (_band_top__30),65535
	ldw (_band_top__30+2),65535
	ldw (_band_mid__30),65535
	ldw (_band_mid__30+2),65535
	ldw (_band_tree__30),65535
	ldw (_band_tree__30+2),65535
	ldb (_band_bg_first__30),255
	ldb (_band_bg_first__30+1),255
	push xwa
	push xix
	call _uses_akina__30
	ld xbc,xwa
	pop xix
	pop xwa
	cp c,0
	jr z,L4460
	ld wa,3
	jr L4461
L4460:
	ld wa,0
L4461:
	ld (_road_band_pal__30),a
	ld xwa,33536
	ld c,(_road_band_pal__30)
	extz bc
	sll 2,bc
	add bc,2
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+2),wa
	ld izl,0
	jp L4465
L4462:
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
	jr ule,L4466
	ld wa,(xsp+8)
	sub wa,ix
	jr L4467
L4466:
	ld wa,0
L4467:
	ld (xsp+8),wa
	ld bc,(xsp+10)
	cp bc,ix
	jr ule,L4468
	ld wa,(xsp+10)
	sub wa,ix
	jr L4469
L4468:
	ld wa,0
L4469:
	ld (xsp+10),wa
	ld bc,(xsp+12)
	cp bc,ix
	jr ule,L4470
	ld wa,(xsp+12)
	sub wa,ix
	jr L4471
L4470:
	ld wa,0
L4471:
	ld (xsp+12),wa
	ld wa,(xsp+8)
	sll 8,wa
	ld bc,(xsp+10)
	sll 4,bc
	or wa,bc
	or wa,(xsp+12)
	ld xbc,_band_col__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4464:
	inc 1,izl
L4465:
	ld a,izl
	cp a,4
	jp ult,L4462
L4463:
	push xix
	call _road_is_tarmac__30
	pop xix
	cp a,0
	jr z,L4472
	ld izl,0
	jr L4476
L4473:
	ld xwa,_course_sol__30
	ld c,(_road_course__30)
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
	ld xbc,_band_col__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4475:
	inc 1,izl
L4476:
	ld a,izl
	cp a,4
	jr ult,L4473
L4474:
	jr L4477
L4472:
	push xix
	call _uses_akina__30
	pop xix
	cp a,0
	jr nz,L4478
	ld izl,0
	jr L4482
L4479:
	ld wa,(xsp+2)
	ld xbc,_band_col__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4481:
	inc 1,izl
L4482:
	ld a,izl
	cp a,4
	jr ult,L4479
L4480:
L4478:
L4477:
	push xix
	call _id_build_weights__30
	pop xix
	push xix
	call _id_build_shear_limits__30
	pop xix
	push xix
	call _id_fill_hud_band__30
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
L4445:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function id_road_dma_pause
_id_road_dma_pause:
	ld a,(_road_dma_depth__30)
	cp a,255
	jr uge,L4487
	incb 1,(_road_dma_depth__30)
L4487:
	ld a,(_road_dma_live__30)
	cp a,0
	jr z,L4488
	ld xwa,0
	push xwa
	call _ngpc_set_vblank_hook
	lda xsp,(xsp+4)
	ld xwa,_id_raster__30
	push xwa
	call _ngpc_dma_raster_xy_disable
	lda xsp,(xsp+4)
	ld xwa,_id_bandstream__30
	push xwa
	call _ngpc_dma_stream_end_u16
	lda xsp,(xsp+4)
	ldb (_road_dma_live__30),0
L4488:
L4486:
	ret

; function id_road_dma_resume
_id_road_dma_resume:
	ld a,(_road_dma_depth__30)
	cp a,0
	jr z,L4495
	decb 1,(_road_dma_depth__30)
L4495:
	ld a,(_road_dma_depth__30)
	cp a,0
	jr z,L4496
	jp L4494
L4496:
	ld a,(_road_dma_live__30)
	cp a,0
	jp nz,L4497
	ld xwa,(_id_xy_live__30)
	push xwa
	ld wa,1
	push xwa
	ld xwa,_id_raster__30
	push xwa
	call _ngpc_dma_raster_xy_begin
	lda xsp,(xsp+12)
	ld xwa,_id_raster__30
	push xwa
	call _ngpc_dma_raster_xy_enable
	lda xsp,(xsp+4)
	call _uses_akina__30
	cp a,0
	jr nz,L4498
	call _road_is_tarmac__30
	cp a,0
	jr nz,L4498
	ldw (_id_bandstream__30+10),0
	ldb (_road_dma_live__30),1
	ld xwa,_id_road_rearm
	push xwa
	call _ngpc_set_vblank_hook
	lda xsp,(xsp+4)
	jr L4494
L4498:
	call _ngpc_dma_timer01_hblank_enable
	ld wa,17
	push xwa
	ld wa,152
	push xwa
	ld xwa,(_id_bandcol__30)
	push xwa
	ld xwa,33536
	ld c,(_road_band_pal__30)
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
	ld xwa,_id_bandstream__30
	push xwa
	call _ngpc_dma_stream_begin_u16
	lda xsp,(xsp+24)
	ld xwa,_id_bandstream__30
	push xwa
	call _ngpc_dma_stream_rearm_u16
	lda xsp,(xsp+4)
	ldb (_road_dma_live__30),1
	ld xwa,_id_road_rearm
	push xwa
	call _ngpc_set_vblank_hook
	lda xsp,(xsp+4)
L4497:
L4494:
	ret

; function id_road_init
_id_road_init:
	ld wa,0
	push xwa
	call _id_road_select
	lda xsp,(xsp+4)
	call _ngpc_dma_init
	call _id_road_dma_resume
L4500:
	ret

; function id_road_flat
_id_road_flat:
	push xiz
	lda xsp,(xsp-2)
	ld iz,0
	jr L4510
L4507:
	ld wa,0
	ld xbc,_id_xy_a__30
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,0
	ld xbc,_id_xy_b__30
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(_band_col__30+6)
	ld xbc,_id_bandcol_a__30
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(_band_col__30+6)
	ld xbc,_id_bandcol_b__30
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4509:
	inc 1,iz
L4510:
	ld wa,iz
	cp wa,152
	jr ult,L4507
L4508:
	ldw (_bc_rest__30),65535
	ldw (_bc_rest__30+2),65535
	ld wa,0
	exts xwa
	ld (_id_xy_done__30),xwa
	ld wa,0
	exts xwa
	ld (_id_bandcol_done__30),xwa
	ldw (_band_top__30),65535
	ldw (_band_top__30+2),65535
	ldw (_band_mid__30),65535
	ldw (_band_mid__30+2),65535
	ldw (_band_tree__30),65535
	ldw (_band_tree__30+2),65535
	ldb (08034h),0
	ldb (08035h),0
L4506:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_rearm
_id_road_rearm:
	ld xwa,(_id_xy_done__30)
	cp xwa,0
	jr z,L4515
	ld xwa,(_id_xy_done__30)
	ld (_id_xy_live__30),xwa
	ld xwa,(_id_xy_done__30)
	ld (_id_raster__30+2),xwa
	ld xwa,(_id_xy_done__30)
	ld (_id_raster__30+6+6),xwa
	ld xwa,(_id_bandcol_done__30)
	ld (_id_bandstream__30+6),xwa
	ld wa,0
	exts xwa
	ld (_id_xy_done__30),xwa
	ld wa,0
	exts xwa
	ld (_id_bandcol_done__30),xwa
L4515:
	ld xwa,_id_raster__30
	push xwa
	call _ngpc_dma_raster_xy_rearm
	lda xsp,(xsp+4)
	ld wa,(_id_bandstream__30+10)
	cp wa,0
	jr z,L4516
	ld xwa,_id_bandstream__30
	push xwa
	call _ngpc_dma_stream_rearm_u16
	lda xsp,(xsp+4)
L4516:
L4514:
	ret

; function id_road_dma_state
_id_road_dma_state:
	ld a,(_id_raster__30+1)
	extz wa
	ld xde,(_id_raster__30+2)
	cp xde,0
	jr z,L4521
	ld bc,2
	jr L4522
L4521:
	ld bc,0
L4522:
	or wa,bc
	jr L4520
L4520:
	ret

; function id_road_xy_at
_id_road_xy_at:
	ld xwa,(_id_xy__30)
	ld c,(xsp+4)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L4524
L4524:
	ret

; function id_road_restore_map
_id_road_restore_map:
	call _uses_akina__30
	cp a,0
	jr nz,L4529
	call _id_load_maps_rally__30
	jr L4530
L4529:
	call _id_load_maps__30
L4530:
L4528:
	ret

; function id_road_reload
_id_road_reload:
	call _id_fill_hud_band__30
	ld wa,0
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
	call _id_load_palettes__30
	call _uses_akina__30
	cp a,0
	jr nz,L4535
	call _id_load_maps_rally__30
	jr L4536
L4535:
	call _id_load_maps__30
L4536:
L4534:
	ret

; function wide_rows
_wide_rows__30:
	push xiz
	lda xsp,(xsp-14)
	ld wa,(xsp+34)
	add wa,1
	ld iz,wa
	ld wa,iz
	cp wa,0
	jr ge,L4543
	ld iz,0
L4543:
	ld wa,iz
	ld c,(_road_bottom__30)
	extz bc
	cp wa,bc
	jr le,L4544
	ld a,(_road_bottom__30)
	extz wa
	ld iz,wa
L4544:
	ld xwa,(xsp+22)
	ld c,(_road_bottom__30)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+0),xwa
	ld xwa,_id_route_lim0
	ld (xsp+4),xwa
	ld a,(_road_bottom__30)
	sub a,(xsp+30)
	ld (xsp+8),a
	ld a,(_road_bottom__30)
	ld c,izl
	sub a,c
	add a,1
	ld (xsp+9),a
	ld bc,(xsp+38)
	cp bc,0
	jr lt,L4545
	ld wa,144
	jr L4546
L4545:
	ld wa,113
L4546:
	ld (xsp+10),a
	ld a,(xsp+26)
	ld (xsp+11),a
	lda xwa,(xsp+0)
	push xwa
	call _id_road_wide_asm
	lda xsp,(xsp+4)
L4542:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function id_road_write
_id_road_write__30:
	push xiz
	lda xsp,(xsp-82)
	ld wa,0
	ld (xsp+12),a
	ld wa,(_band_col__30+6)
	ld (xsp+14),wa
	ld a,(_road_bottom__30)
	extz wa
	ld iz,wa
	ld a,(_road_top__30)
	extz wa
	ld c,(_climb_room__30)
	extz bc
	sub wa,bc
	ld (xsp+22),wa
	ld xwa,_band_lut__30
	ld bc,(_band_phase__30)
	srl 1,bc
	and bc,15
	mul xbc,48
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+28),xwa
	ld xwa,(_id_xy__30)
	ld (xsp+32),xwa
	ld xwa,(_id_bandcol__30)
	ld (xsp+36),xwa
	ld a,(_road_base_x__30)
	ld (xsp+40),a
	ld a,(_road_plane0__30)
	ld (xsp+41),a
	ld xwa,_id_src__30
	ld c,(_road_lines__30)
	extz bc
	sub bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	sll 8,wa
	ld (xsp+16),wa
	ld xwa,_id_src__30
	ld c,(_road_lines__30)
	extz bc
	sub bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	ld c,(_id_src__30)
	extz bc
	sub wa,bc
	sll 8,wa
	exts xwa
	ld c,(_road_lines__30)
	extz bc
	sub bc,1
	divs xwa,bc
	ld (xsp+18),wa
	ld a,(_road_lines__30)
	cp a,0
	jr z,L4647
	ld xwa,_id_w_lat__30
	ld (xsp+42),xwa
	ld xwa,_id_curve_dx__30
	ld (xsp+46),xwa
	ld xwa,_id_dxc__30+128
	ld (xsp+50),xwa
	ld xwa,_id_shear__30
	ld (xsp+54),xwa
	ld wa,(xsp+90)
	ld (xsp+58),wa
	ld a,(_road_lines__30)
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
L4647:
	ld a,(_road_lines__30)
	cp a,0
	jp z,L4648
	ld wa,(xsp+22)
	cp wa,2
	jp lt,L4648
	ld wa,(xsp+22)
	cp wa,255
	jp gt,L4648
	ld a,(_road_lines__30)
	extz wa
	sub wa,1
	ld (xsp+24),wa
	ld wa,iz
	cp wa,(xsp+22)
	jp lt,L4649
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
	ld xwa,_id_sl__30
	ld c,(_road_lines__30)
	extz bc
	exts xbc
	add xwa,xbc
	ld (xsp+50),xwa
	ld xwa,_id_shear__30
	ld c,(_road_lines__30)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+54),xwa
	ld xwa,_hill_rate__30+20
	ld (xsp+58),xwa
	ld xwa,(xsp+28)
	ld (xsp+62),xwa
	ld xwa,_band_col__30
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
	ld a,(_road_lines__30)
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
L4649:
	jp L4650
L4648:
	ld a,(_road_lines__30)
	extz wa
	sub wa,1
	ld (xsp+24),wa
	jp L4654
L4651:
	ld xwa,_hill_rate__30
	ld bc,20
	ld xde,_id_sl__30+64
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
	ld xwa,_id_shear__30
	ld bc,(xsp+24)
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+46),wa
	ld bc,iz
	cp bc,(xsp+22)
	jr ge,L4655
	ld wa,(xsp+22)
	jr L4656
L4655:
	ld wa,iz
L4656:
	ld xbc,_id_sl__30
	ld de,(xsp+24)
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,_band_col__30
	ld xbc,(xsp+28)
	ld xde,_id_sl__30+128
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
	jr ult,L4657
	ld wa,iz
	cp wa,(xsp+22)
	jr lt,L4657
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
L4657:
	ld a,(xsp+43)
	cp a,2
	jr nz,L4658
	ld wa,iz
	cp wa,(xsp+22)
	jr lt,L4658
	ld a,izl
	ld (xsp+48),a
	ld wa,(xsp+18)
	srl 1,wa
	ld (xsp+50),wa
	ld bc,(xsp+16)
	cp bc,(xsp+50)
	jr ule,L4659
	ld wa,(xsp+16)
	sub wa,(xsp+50)
	jr L4660
L4659:
	ld wa,(xsp+16)
L4660:
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
L4658:
	ld wa,(xsp+16)
	ld bc,(xsp+18)
	sub wa,bc
	ld (xsp+16),wa
	ld wa,iz
	cp wa,(xsp+22)
	jr ge,L4661
	jr L4652
L4661:
L4653:
	decw 1,(xsp+24)
L4654:
	ld wa,(xsp+24)
	cp wa,0
	jp ge,L4651
L4652:
L4650:
	ld xwa,_id_shear__30
	ld c,(_wide_k0__30)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+42),wa
	ld xwa,_id_shear__30
	ld c,(_road_lines__30)
	extz bc
	sub bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+44),wa
	ld wa,(xsp+42)
	cp wa,0
	jr ge,L4662
	ld wa,(xsp+42)
	neg wa
	ld (xsp+42),wa
L4662:
	ld wa,(xsp+44)
	cp wa,0
	jr ge,L4663
	ld wa,(xsp+44)
	neg wa
	ld (xsp+44),wa
L4663:
	ld wa,(xsp+42)
	cp wa,46
	jr ge,L4665
	ld wa,(xsp+44)
	cp wa,46
	jr lt,L4664
L4665:
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
	call _wide_rows__30
	lda xsp,(xsp+20)
	pop xiy
	pop xix
L4664:
	ld bc,(xsp+24)
	cp bc,0
	jr ge,L4666
	ld wa,1
	jr L4667
L4666:
	ld wa,0
L4667:
	ld (xsp+26),a
	jr L4670
L4668:
	ld a,(xsp+22)
	ld xbc,_id_sl__30
	ld de,(xsp+24)
	exts xde
	add xbc,xde
	ld (xbc),a
	decw 1,(xsp+24)
L4670:
	ld wa,(xsp+24)
	cp wa,0
	jr ge,L4668
L4669:
	ld a,izl
	add a,1
	ld (_band_first__30),a
	ld a,(_band_first__30)
	cp a,(_band_held__30)
	jp ule,L4671
	ld a,(_band_first__30)
	sub a,(_band_held__30)
	cp a,2
	jr uge,L4673
	ld a,(_band_wait__30)
	cp a,16
	jr ult,L4672
L4673:
	ldb (_band_wait__30),0
	jr L4674
L4672:
	incb 1,(_band_wait__30)
	jr L4677
L4675:
	decb 1,(_band_first__30)
	ld xwa,(_id_xy__30)
	ld c,(_band_first__30)
	extz bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(_id_xy__30)
	ld e,(_band_first__30)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,(_id_bandcol__30)
	ld c,(_band_first__30)
	extz bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(_id_bandcol__30)
	ld e,(_band_first__30)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4677:
	ld a,(_band_first__30)
	cp a,(_band_held__30)
	jr ugt,L4675
L4676:
L4674:
	jr L4678
L4671:
	ldb (_band_wait__30),0
L4678:
	ld a,(_band_first__30)
	ld (_band_held__30),a
	ld a,(_road_top__30)
	extz wa
	ld c,(_band_first__30)
	extz bc
	sub wa,bc
	ld (xsp+42),wa
	ld wa,(_band_col__30+6)
	ld (xsp+46),wa
	push xix
	push xiy
	call _road_is_tarmac__30
	pop xiy
	pop xix
	cp a,0
	jp z,L4679
	ld wa,(_band_col__30)
	ld (xsp+56),wa
	ld wa,0
	ld bc,(_band_phase__30)
	srl 5,bc
	sub wa,bc
	ld (xsp+58),a
	ld a,(_road_top__30)
	extz wa
	ld (xsp+44),wa
	ld wa,(xsp+44)
	ld c,(_road_bottom__30)
	extz bc
	cp wa,bc
	jr ule,L4680
	ld a,(_road_bottom__30)
	extz wa
	ld (xsp+44),wa
L4680:
	ld xwa,(_id_bandcol__30)
	ld c,(_band_first__30)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+48),xwa
	ld xwa,(_id_bandcol__30)
	ld bc,(xsp+44)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+52),xwa
	jr L4683
L4681:
	ld c,(xsp+58)
	incb 1,(xsp+58)
	extz bc
	and bc,2
	cp bc,0
	jr z,L4684
	ld wa,(xsp+46)
	jr L4685
L4684:
	ld wa,(xsp+56)
L4685:
	ld xbc,(xsp+48)
	inc 2,xbc
	ld (xsp+48),xbc
	dec 2,xbc
	ld (xbc),wa
L4683:
	ld xwa,(xsp+48)
	cp xwa,(xsp+52)
	jr ult,L4681
L4682:
	jr L4686
L4679:
	ld wa,(xsp+42)
	cp wa,24
	jr le,L4687
	ldw (xsp+42),24
L4687:
	ld a,(_band_first__30)
	extz wa
	ld de,(xsp+42)
	cp de,0
	jr le,L4688
	ld bc,(xsp+42)
	jr L4689
L4688:
	ld bc,0
L4689:
	add wa,bc
	ld (xsp+44),wa
	ld wa,(xsp+44)
	ld c,(_road_bottom__30)
	extz bc
	cp wa,bc
	jr ule,L4690
	ld a,(_road_bottom__30)
	extz wa
	ld (xsp+44),wa
L4690:
	ld xwa,(_id_bandcol__30)
	ld c,(_band_first__30)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+48),xwa
	ld xwa,(_id_bandcol__30)
	ld bc,(xsp+44)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+52),xwa
	jr L4693
L4691:
	ld wa,(xsp+46)
	ld xbc,(xsp+48)
	inc 2,xbc
	ld (xsp+48),xbc
	dec 2,xbc
	ld (xbc),wa
L4693:
	ld xwa,(xsp+48)
	cp xwa,(xsp+52)
	jr ult,L4691
L4692:
L4686:
	ld a,(_band_first__30)
	extz wa
	ld c,(_road_top__30)
	extz bc
	sub wa,bc
	ld (_band_shift__30),wa
	ld a,(_road_bottom__30)
	ld c,(_band_first__30)
	sub a,c
	add a,1
	ld (_band_count__30),a
	ld wa,(_band_col__30+6)
	ld (xsp+12),wa
	ld a,(_id_buf__30)
	ld (xsp+14),a
	ld xwa,_bc_rest__30
	ld c,(xsp+14)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,(xsp+12)
	jr z,L4694
	ld wa,(xsp+12)
	ld xbc,_bc_rest__30
	ld e,(xsp+14)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,0
	ld xbc,_bc_top__30
	ld e,(xsp+14)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(_id_bandcol__30)
	ld bc,152
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+16),xwa
	ld xwa,(_id_bandcol__30)
	ld bc,152
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+20),xwa
	jr L4697
L4695:
	ld wa,(xsp+12)
	ld xbc,(xsp+16)
	inc 2,xbc
	ld (xsp+16),xbc
	dec 2,xbc
	ld (xbc),wa
L4697:
	ld xwa,(xsp+16)
	cp xwa,(xsp+20)
	jr ult,L4695
L4696:
L4694:
	ld xwa,_bc_top__30
	ld c,(xsp+14)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_band_first__30)
	jr uge,L4698
	ld xwa,(_id_bandcol__30)
	ld xbc,_bc_top__30
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
	ld xwa,(_id_bandcol__30)
	ld c,(_band_first__30)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+20),xwa
	jr L4701
L4699:
	ld wa,(xsp+12)
	ld xbc,(xsp+16)
	inc 2,xbc
	ld (xsp+16),xbc
	dec 2,xbc
	ld (xbc),wa
L4701:
	ld xwa,(xsp+16)
	cp xwa,(xsp+20)
	jr ult,L4699
L4700:
L4698:
	ld a,(_band_first__30)
	ld xbc,_bc_top__30
	ld e,(xsp+14)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(_id_xy__30)
	ld c,(_road_bottom__30)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(_id_xy__30)
	ld (xbc+304),wa
	ld xwa,(_id_bandcol__30)
	ld c,(_road_bottom__30)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(_id_bandcol__30)
	ld (xbc+304),wa
	ld bc,(_band_shift__30)
	cp bc,0
	jr le,L4702
	ld wa,(_band_shift__30)
	jr L4703
L4702:
	ld wa,0
L4703:
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
	call _uses_akina__30
	pop xiy
	pop xix
	cp a,0
	jp nz,L4704
	ld a,(_road_base_x__30)
	extz wa
	ld e,(_pan_fine__30)
	cp e,0
	jr z,L4705
	ld bc,(_pan_head__30)
	exts xbc
	divs xbc,2
	neg bc
	exts xbc
	divs xbc,16
	jr L4706
L4705:
	ld bc,(xsp+94)
	sra 1,bc
	neg bc
	ld de,(xsp+90)
	sra 4,de
	add bc,de
L4706:
	add wa,bc
	extz wa
	ld (xsp+12),wa
	ld a,(_road_base_x__30)
	extz wa
	ld e,(_pan_fine__30)
	cp e,0
	jr z,L4707
	ld bc,(_pan_head__30)
	sll 1,bc
	neg bc
	exts xbc
	divs xbc,16
	jr L4708
L4707:
	ld bc,(xsp+94)
	sll 1,bc
	neg bc
	ld de,(xsp+90)
	sra 2,de
	add bc,de
L4708:
	add wa,bc
	extz wa
	ld (xsp+14),wa
	ld c,(_band_first__30)
	cp c,244
	jr uge,L4709
	ld a,(_band_first__30)
	extz wa
	add wa,0
	jr L4710
L4709:
	ld a,(_band_first__30)
	extz wa
L4710:
	ld (xsp+16),a
	ld c,(xsp+16)
	cp c,0
	jr ule,L4711
	ld a,(xsp+16)
	extz wa
	jr L4712
L4711:
	ld a,0
	extz wa
L4712:
	ld (xsp+17),a
	ld c,(_band_first__30)
	cp c,(xsp+17)
	jr uge,L4713
	ld a,(_band_first__30)
	extz wa
	jr L4714
L4713:
	ld a,(xsp+17)
	extz wa
L4714:
	ld (xsp+18),a
	ld a,(xsp+18)
	extz wa
	ld (xsp+20),wa
	ld wa,(xsp+12)
	ld xbc,_band_top__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L4716
	ld wa,(xsp+14)
	ld xbc,_band_mid__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L4716
	ld a,(xsp+17)
	ld xbc,_band_bg_end__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr nz,L4716
	ld wa,(xsp+10)
	ld xbc,_band_pitch__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	exts bc
	cp wa,bc
	jr nz,L4716
	ld a,(_band_first__30)
	ld xbc,_band_bg_first__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr z,L4715
L4716:
	ld wa,(xsp+12)
	ld xbc,_band_top__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+14)
	ld xbc,_band_mid__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+17)
	ld xbc,_band_bg_end__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(_band_first__30)
	ld xbc,_band_bg_first__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ldw (xsp+20),0
L4715:
	push xix
	push xiy
	call _sky_is_tall_course__30
	pop xiy
	pop xix
	ld (xsp+22),a
	ld xwa,(_id_xy__30)
	ld bc,(xsp+20)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld xix,xwa
	ld xwa,(_id_xy__30)
	ld c,(xsp+17)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+28),xwa
	ld a,(xsp+22)
	cp a,0
	jr z,L4717
	jr L4720
L4718:
	ld wa,(xsp+14)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L4720:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr ult,L4718
L4719:
	jp L4721
L4717:
	ld a,(xsp+10)
	neg a
	extz wa
	sll 8,wa
	ld (xsp+36),wa
	ld wa,(xsp+20)
	ld iy,wa
	jr L4724
L4722:
	ld bc,iy
	cp bc,0
	jr uge,L4725
	ld wa,(xsp+12)
	jr L4726
L4725:
	ld wa,(xsp+14)
L4726:
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
L4724:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr uge,L4727
	ld wa,iy
	cp wa,(xsp+10)
	jr lt,L4722
L4727:
L4723:
	ld xwa,(_id_xy__30)
	ld bc,0
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+32),xwa
	ld xwa,(xsp+32)
	cp xwa,(xsp+28)
	jr ule,L4728
	ld xwa,(xsp+28)
	ld (xsp+32),xwa
L4728:
	jr L4731
L4729:
	ld wa,(xsp+12)
	or wa,(xsp+36)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L4731:
	ld xwa,xix
	cp xwa,(xsp+32)
	jr ult,L4729
L4730:
	jr L4734
L4732:
	ld wa,(xsp+14)
	or wa,(xsp+36)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L4734:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr ult,L4732
L4733:
L4721:
	ld a,(xsp+10)
	ld xbc,_band_pitch__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+14)
	ld (xsp+8),wa
	jp L4735
L4704:
	ld a,(_road_base_x__30)
	add a,(xsp+2)
	extz wa
	ld (xsp+12),wa
	ld a,(_road_base_x__30)
	add a,(xsp+4)
	extz wa
	ld (xsp+14),wa
	ld a,(_road_base_x__30)
	add a,(xsp+6)
	extz wa
	ld (xsp+16),wa
	ld wa,(xsp+16)
	ld xbc,_band_tree__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L4737
	ld wa,(xsp+10)
	ld xbc,_band_pitch__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	exts bc
	cp wa,bc
	jr nz,L4737
	ld a,(_band_first__30)
	ld xbc,_band_bg_end__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp z,L4736
L4737:
	ld a,(xsp+10)
	ld xbc,_band_pitch__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(_band_first__30)
	ld xbc,_band_bg_end__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+16)
	ld xbc,_band_mid__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+16)
	ld xbc,_band_tree__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld iy,0
	jr L4741
L4738:
	push xwa
	push xix
	push xiy
	call _sky_is_tall_course__30
	ld xbc,xwa
	pop xiy
	pop xix
	pop xwa
	cp c,0
	jr z,L4742
	ld wa,0
	jr L4743
L4742:
	ld wa,(xsp+10)
	neg wa
L4743:
	ld (xsp+18),wa
	ld wa,iy
	add wa,(xsp+18)
	cp wa,0
	jr ge,L4744
	ld wa,iy
	neg wa
	ld (xsp+18),wa
L4744:
	ld wa,(xsp+16)
	ld c,(xsp+18)
	extz bc
	sll 8,bc
	or wa,bc
	ld xbc,(_id_xy__30)
	ld de,iy
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4740:
	inc 1,iy
L4741:
	ld wa,iy
	ld c,(_band_first__30)
	extz bc
	cp wa,bc
	jr ult,L4738
L4739:
L4736:
	ld wa,(xsp+16)
	ld (xsp+8),wa
L4735:
L4646:
	lda xsp,(xsp+82)
	pop xiz
	ret

; function id_road_ready
_id_road_ready:
	ld xwa,(_id_xy__30)
	ld (_id_xy_done__30),xwa
	ld xwa,(_id_bandcol__30)
	ld (_id_bandcol_done__30),xwa
L4746:
	ret

; function id_road_pan
_id_road_pan:
	ld wa,(xsp+4)
	ld (_pan_head__30),wa
	ld wa,(xsp+8)
	ld (_pan_lat__30),wa
	ldb (_pan_fine__30),1
L4748:
	ret

; function id_road_begin
_id_road_begin:
	ld xwa,(_id_xy_live__30)
	cp xwa,_id_xy_a__30
	jr nz,L4755
	ld xwa,_id_xy_b__30
	ld (_id_xy__30),xwa
	ld xwa,_id_bandcol_b__30
	ld (_id_bandcol__30),xwa
	jr L4756
L4755:
	ld xwa,_id_xy_a__30
	ld (_id_xy__30),xwa
	ld xwa,_id_bandcol_a__30
	ld (_id_bandcol__30),xwa
L4756:
	ld xbc,(_id_xy__30)
	cp xbc,_id_xy_a__30
	jr nz,L4757
	ld wa,0
	jr L4758
L4757:
	ld wa,1
L4758:
	ld (_id_buf__30),a
L4754:
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
	jr L4768
L4765:
	ld wa,ix
	ld xbc,_id_w_curve__30
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	mul xwa,bc
	sra 8,wa
	ld xbc,_id_curve_dx__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4767:
	inc 1,izl
L4768:
	ld a,izl
	cp a,(_road_lines__30)
	jr ult,L4765
L4766:
	push xix
	ld wa,(xsp+22)
	push xwa
	ld wa,(xsp+18)
	push xwa
	call _id_road_write__30
	lda xsp,(xsp+8)
	pop xix
	push xix
	call _id_road_ready
	pop xix
L4764:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_ahead
_id_road_ahead:
	ld xwa,_id_ahead__30
	jr L4770
L4770:
	ret

; function id_road_lines
_id_road_lines:
	ld a,(_road_lines__30)
	jr L4772
L4772:
	ret

; function id_road_frame_ahead
_id_road_frame_ahead:
	push xiz
	lda xsp,(xsp-18)
	ld a,(_road_lines__30)
	ld izl,a
	ld wa,0
	ld (xsp+2),wa
	ld wa,0
	ld (xsp+4),wa
	call _id_road_begin
	ld a,izl
	cp a,0
	jr z,L4776
	ld xwa,(xsp+30)
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+6),xwa
	ld xwa,_id_curve_dx__30
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+10),xwa
	ld wa,(_id_curve_cm__30)
	ld (xsp+14),wa
	ld a,izl
	extz wa
	ld (xsp+16),wa
	lda xwa,(xsp+6)
	push xwa
	call _id_road_curve_asm
	lda xsp,(xsp+4)
L4776:
	ld wa,(xsp+34)
	push xwa
	ld wa,(xsp+30)
	push xwa
	call _id_road_write__30
	lda xsp,(xsp+8)
L4775:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_fill_hud_band
_id_fill_hud_band__30:
	push xiz
	lda xsp,(xsp-2)
	ld iz,152
	jr L4786
L4783:
	ld wa,2048
	ld c,(_road_base_x__30)
	extz bc
	or wa,bc
	ld xbc,_id_xy_a__30
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_id_xy_a__30
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_id_xy_b__30
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4785:
	inc 1,iz
L4786:
	ld wa,iz
	cp wa,152
	jr ult,L4783
L4784:
L4782:
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
	cp a,(_road_top__30)
	jr uge,L4792
	ld a,(_road_top__30)
	ld izl,a
	jr L4793
L4792:
	ld a,izl
	cp a,(_road_bottom__30)
	jr ule,L4794
	ld a,(_road_bottom__30)
	ld izl,a
L4794:
L4793:
	ld a,izl
	sub a,(_road_top__30)
	ld ixl,a
	ld wa,80
	ld xbc,_id_shear__30
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
	ld xbc,_id_sl__30
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
	ld xwa,_id_half__30
	ld c,ixl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xiy+4),a
L4791:
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
	cp a,(_road_top__30)
	jr uge,L4800
	ld a,(_road_top__30)
	ld izl,a
	jr L4801
L4800:
	ld a,izl
	cp a,(_road_bottom__30)
	jr ule,L4802
	ld a,(_road_bottom__30)
	ld izl,a
L4802:
L4801:
	ld a,izl
	sub a,(_road_top__30)
	ld (xsp+0),a
	ld wa,80
	ld xbc,_id_shear__30
	ld e,(xsp+0)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	sub wa,bc
	jr L4799
L4799:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_band_phase
_id_road_band_phase:
	ld wa,(xsp+4)
	ld (_band_phase__30),wa
L4804:
	ret

; function id_road_join
_id_road_join:
	ld c,(xsp+4)
	cp c,1
	jr uge,L4809
	ld a,(xsp+4)
	extz wa
	jr L4810
L4809:
	ld wa,0
L4810:
	ld (_road_course__30),a
	call _id_load_palettes__30
	ld wa,0
	push xwa
	call _id_road_join_white
	lda xsp,(xsp+4)
L4808:
	ret

; function id_road_join_white
_id_road_join_white:
	push xiz
	lda xsp,(xsp-10)
	ld izl,0
	jp L4820
L4817:
	ld xwa,_course_sol__30
	ld c,(_road_course__30)
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
	ld xbc,_band_col__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4819:
	inc 1,izl
L4820:
	ld a,izl
	cp a,4
	jp ult,L4817
L4818:
	ld wa,65535
	ld (_band_top__30+2),wa
	ld (_band_top__30),wa
	ld wa,65535
	ld (_band_mid__30+2),wa
	ld (_band_mid__30),wa
	ld wa,65535
	ld (_band_tree__30+2),wa
	ld (_band_tree__30),wa
L4816:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function id_road_hill_ahead
_id_road_hill_ahead:
	push xiz
	lda xsp,(xsp-12)
	ld xwa,(xsp+20)
	ld (xsp+0),xwa
	ld xwa,_id_sl__30+64
	ld xiy,xwa
	ld a,(_grade_hi__30)
	ld (xsp+8),a
	ld a,(_grade_lo__30)
	ld (xsp+9),a
	ld a,(_road_lines__30)
	ld ixl,a
	ld xwa,(xsp+0)
	cp xwa,xiy
	jr nz,L4830
	ld ixl,0
L4830:
	jr L4833
L4831:
	ld xwa,(xsp+0)
	inc 1,xwa
	ld (xsp+0),xwa
	dec 1,xwa
	ld a,(xwa)
	ld izl,a
	ld a,izl
	cp a,(xsp+8)
	jr le,L4834
	ld a,(xsp+8)
	ld izl,a
	jr L4835
L4834:
	ld a,izl
	cp a,(xsp+9)
	jr ge,L4836
	ld a,(xsp+9)
	ld izl,a
L4836:
L4835:
	ld a,izl
	ld xbc,xiy
	inc 1,xbc
	ld xiy,xbc
	dec 1,xbc
	ld (xbc),a
	dec 1,ixl
L4833:
	ld a,ixl
	cp a,0
	jr nz,L4831
L4832:
	ld xwa,_id_sl__30+64
	ld c,(_road_lines__30)
	extz bc
	sub bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_road_grade__30),a
L4829:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function id_road_grade_buf
_id_road_grade_buf:
	ld xwa,_id_sl__30+64
	jr L4838
L4838:
	ret

; function id_road_band_first
_id_road_band_first:
	ld a,(_band_first__30)
	jr L4840
L4840:
	ret

; function id_road_visible_top
_id_road_visible_top:
	push xiz
	lda xsp,(xsp-2)
	ld c,(_band_first__30)
	cp c,244
	jr uge,L4848
	ld a,(_band_first__30)
	add a,0
	extz wa
	jr L4849
L4848:
	ld a,(_band_first__30)
	extz wa
L4849:
	ld izl,a
	ld a,izl
	cp a,0
	jr uge,L4850
	ld izl,0
L4850:
	ld c,izl
	cp c,(_road_bottom__30)
	jr ule,L4851
	ld a,(_road_bottom__30)
	extz wa
	jr L4852
L4851:
	ld a,izl
	extz wa
L4852:
	jr L4847
L4847:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_grade_hi
_id_road_grade_hi:
	ld a,(_grade_hi__30)
	jr L4854
L4854:
	ret

; function id_road_grade_lo
_id_road_grade_lo:
	ld a,(_grade_lo__30)
	jr L4856
L4856:
	ret

; function id_road_set_hill
_id_road_set_hill:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld ixl,a
	ld a,ixl
	cp a,(_grade_hi__30)
	jr le,L4866
	ld a,(_grade_hi__30)
	ld ixl,a
	jr L4867
L4866:
	ld a,ixl
	cp a,(_grade_lo__30)
	jr ge,L4868
	ld a,(_grade_lo__30)
	ld ixl,a
L4868:
L4867:
	ld a,ixl
	ld (_road_grade__30),a
	ld izl,0
	jr L4872
L4869:
	ld a,ixl
	ld xbc,_id_sl__30+64
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L4871:
	inc 1,izl
L4872:
	ld a,izl
	cp a,(_road_lines__30)
	jr ult,L4869
L4870:
L4865:
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
	cp a,(_road_top__30)
	jr ult,L4879
	ld a,ixl
	cp a,(_road_bottom__30)
	jr ule,L4878
L4879:
	ld wa,0
	jr L4877
L4878:
	ld a,ixl
	extz wa
	ld c,(_road_top__30)
	extz bc
	sub wa,bc
	ld iz,wa
	ld wa,iz
	ld c,(_road_lines__30)
	extz bc
	cp wa,bc
	jr lt,L4880
	ld a,(_road_lines__30)
	extz wa
	sub wa,1
	ld iz,wa
L4880:
	ld xwa,_id_sl__30
	ld bc,iz
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	ld iy,wa
	ld a,iyl
	ld c,ixl
	sub a,c
	jr L4877
L4877:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function id_road_car_lift
_id_road_car_lift:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_road_bottom__30)
	sub a,(_car_stand__30)
	push xwa
	call _id_road_line_shift
	lda xsp,(xsp+4)
	exts wa
	neg wa
	ld iz,wa
	ld wa,iz
	cp wa,8
	jr le,L4886
	ld iz,8
	jr L4887
L4886:
	ld wa,iz
	cp wa,65531
	jr ge,L4888
	ld iz,65531
L4888:
L4887:
	ld a,izl
	jr L4885
L4885:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_half_at
_id_road_half_at:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,(_road_top__30)
	jr uge,L4894
	ld a,(_road_top__30)
	ld izl,a
	jr L4895
L4894:
	ld a,izl
	cp a,(_road_bottom__30)
	jr ule,L4896
	ld a,(_road_bottom__30)
	ld izl,a
L4896:
L4895:
	ld xwa,_id_half__30
	ld c,izl
	sub c,(_road_top__30)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	jr L4893
L4893:
	pop xiz
	ret

; function id_road_line_at_distance
_id_road_line_at_distance:
	push xiz
	lda xsp,(xsp-4)
	ld wa,0
	ld izl,a
	ld a,(_road_lines__30)
	sub a,1
	ld iyl,a
	ld wa,(xsp+12)
	cp wa,(_id_ahead__30)
	jr ule,L4905
	ld wa,255
	jr L4904
L4905:
	jr L4908
L4906:
	ld a,izl
	extz wa
	ld c,iyl
	extz bc
	add wa,bc
	add wa,1
	srl 1,wa
	ld ixl,a
	ld xwa,_id_ahead__30
	ld c,ixl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,(xsp+12)
	jr ult,L4909
	ld a,ixl
	ld izl,a
	jr L4910
L4909:
	ld a,ixl
	sub a,1
	ld iyl,a
L4910:
L4908:
	ld a,izl
	cp a,iyl
	jr ult,L4906
L4907:
	ld a,(_road_top__30)
	add a,izl
	jr L4904
L4904:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function id_road_distance_at_line
_id_road_distance_at_line:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,(_road_top__30)
	jr uge,L4916
	ld a,(_road_top__30)
	ld izl,a
	jr L4917
L4916:
	ld a,izl
	cp a,(_road_bottom__30)
	jr ule,L4918
	ld a,(_road_bottom__30)
	ld izl,a
L4918:
L4917:
	ld xwa,_id_ahead__30
	ld c,izl
	sub c,(_road_top__30)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L4915
L4915:
	pop xiz
	ret

; function id_scenery_char_count
_id_scenery_char_count:
	ld wa,0
	jr L4920
L4920:
	ret

; function id_scenery_init
_id_scenery_init:
	ldb (_scn_phase__31),0
	ldw (_scn_frac__31),0
	ldb (_scn_passed__31),0
	ldb (_scn_mode__31),0
	ld a,64
	push xwa
	ld a,50
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L4922:
	ret

; function scenery_mode
_scenery_mode:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld c,izl
	cp c,5
	jr nz,L4933
	ld wa,1
	jr L4934
L4933:
	ld wa,0
L4934:
	ld e,(_scn_mode__31)
	cp e,5
	jr nz,L4935
	ld bc,1
	jr L4936
L4935:
	ld bc,0
L4936:
	cp wa,bc
	jr z,L4932
	ld c,izl
	cp c,5
	jr nz,L4937
	ld wa,1
	jr L4938
L4937:
	ld wa,0
L4938:
	push xwa
	call _theme_crowd_colours
	lda xsp,(xsp+4)
L4932:
	ld a,izl
	ld (_scn_mode__31),a
L4931:
	pop xiz
	ret

; function id_scenery_passed
_id_scenery_passed:
	ld a,(_scn_passed__31)
	jr L4940
L4940:
	ret

; function kind_of
_kind_of__31:
	ld a,(_scn_mode__31)
	cp a,5
	jr nz,L4949
	ld wa,14
	jr L4948
L4949:
	ld a,(_scn_mode__31)
	cp a,1
	jr nz,L4950
	ld wa,12
	jr L4948
L4950:
	ld a,(_scn_mode__31)
	cp a,3
	jr ult,L4951
	ld wa,11
	jr L4948
L4951:
	ld a,(_scn_mode__31)
	cp a,2
	jr nz,L4952
	ld wa,13
	jr L4948
L4952:
	ld c,(xsp+4)
	cp c,0
	jr z,L4953
	call _theme_obj_kind_right
	extz wa
	jr L4954
L4953:
	call _theme_obj_kind_left
	extz wa
L4954:
	jr L4948
L4948:
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
	jp L4971
L4968:
	ld a,(_scn_passed__31)
	extz wa
	ld bc,1
	ld e,izl
	cp e,0
	jr z,L4974
L4973:
	sll 1,bc
	djnz e,L4973
L4974:
	extz bc
	and wa,bc
	cp wa,0
	jr nz,L4972
	jp L4970
L4972:
	ld xwa,_gfx_obj_frames
	push xwa
	push xix
	push xiy
	ld a,izl
	push xwa
	call _kind_of__31
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
	jr nz,L4975
	ld wa,iy
	neg wa
	add wa,12
	cp wa,(xsp+12)
	jr lt,L4976
	ld wa,iy
	neg wa
	sub wa,12
	cp wa,(xsp+14)
	jr gt,L4976
	ld wa,1
	jr L4967
L4976:
	jr L4977
L4975:
	ld wa,iy
	add wa,12
	cp wa,(xsp+12)
	jr lt,L4978
	ld wa,iy
	sub wa,12
	cp wa,(xsp+14)
	jr gt,L4978
	ld wa,1
	jr L4967
L4978:
L4977:
L4970:
	inc 1,izl
L4971:
	ld a,izl
	cp a,2
	jp ult,L4968
L4969:
	ld wa,0
	jr L4967
L4967:
	lda xsp,(xsp+16)
	pop xiz
	ret

; function obj_phase
_obj_phase__31:
	ld a,(_scn_phase__31)
	extz wa
	ld c,(xsp+4)
	extz bc
	mul xbc,43
	extz bc
	add wa,bc
	jr L4980
L4980:
	ret

; function id_scenery_advance
_id_scenery_advance:
	push xiz
	lda xsp,(xsp-6)
	ld wa,(_scn_frac__31)
	ld c,(xsp+14)
	extz bc
	mul xbc,158
	add wa,bc
	ld (xsp+0),wa
	ld wa,(xsp+0)
	and wa,2047
	ld (_scn_frac__31),wa
	ld wa,(xsp+0)
	srl 11,wa
	ld (xsp+0),wa
	ld a,(_scn_phase__31)
	ld iyl,a
	ld a,(_scn_phase__31)
	ld c,(xsp+0)
	add a,c
	ld (_scn_phase__31),a
	ldb (_scn_passed__31),0
	ld izl,0
	jr L4993
L4990:
	ld a,izl
	extz wa
	mul xwa,43
	ld ixl,a
	ld a,(_scn_phase__31)
	add a,ixl
	ld c,iyl
	add c,ixl
	cp a,c
	jr uge,L4994
	ld a,(_scn_passed__31)
	extz wa
	ld e,izl
	extz de
	and de,1
	cp de,0
	jr z,L4995
	ld bc,2
	jr L4996
L4995:
	ld bc,1
L4996:
	extz bc
	or wa,bc
	ld (_scn_passed__31),a
L4994:
L4992:
	inc 1,izl
L4993:
	ld a,izl
	cp a,6
	jr ult,L4990
L4991:
L4989:
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
L4998:
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
	jr z,L5051
	ld wa,58
	jr L5052
L5051:
	ld wa,64
L5052:
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
	jr L5056
L5053:
	ld a,(xsp+0)
	push xwa
	call _obj_phase__31
	lda xsp,(xsp+4)
	push xwa
	ld a,(xsp+5)
	push xwa
	call _obj_phase__31
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp a,c
	jr ule,L5057
	ld a,(xsp+0)
	ld (xsp+1),a
L5057:
L5055:
	incb 1,(xsp+0)
L5056:
	ld a,(xsp+0)
	cp a,6
	jr ult,L5053
L5054:
	ldb (xsp+0),0
	jp L5061
L5058:
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
	call _obj_phase__31
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
	jr ule,L5062
	ld wa,(xsp+10)
	ld iz,wa
L5062:
	ld a,(xsp+4)
	add a,izl
	ld (xsp+18),a
	ld wa,iz
	cp wa,6
	jr uge,L5063
	ldb (xsp+17),4
	jr L5064
L5063:
	ld wa,iz
	cp wa,10
	jr uge,L5065
	ldb (xsp+17),3
	jr L5066
L5065:
	ld wa,iz
	cp wa,15
	jr uge,L5067
	ldb (xsp+17),2
	jr L5068
L5067:
	ld wa,iz
	cp wa,22
	jr uge,L5069
	ldb (xsp+17),1
	jr L5070
L5069:
	ldb (xsp+17),0
L5070:
L5068:
L5066:
L5064:
	ld c,(xsp+12)
	extz bc
	and bc,1
	cp bc,0
	jr z,L5071
	ld wa,1
	jr L5072
L5071:
	ld wa,0
L5072:
	ld (xsp+14),a
	ld a,(_scn_mode__31)
	cp a,5
	jr nz,L5073
	ldb (xsp+15),14
	ld xwa,_crowd_pal__31_L5074
	ld c,(xsp+12)
	extz bc
	extz xbc
	div xbc,3
	ld bc,qbc
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+16),a
	jr L5075
L5073:
	ld a,(_scn_mode__31)
	cp a,1
	jr nz,L5076
	ldb (xsp+15),12
	ldb (xsp+16),4
	jr L5077
L5076:
	ld a,(_scn_mode__31)
	cp a,3
	jr ult,L5078
	ldb (xsp+15),11
	ldb (xsp+16),9
	jr L5079
L5078:
	ld a,(_scn_mode__31)
	cp a,2
	jr nz,L5080
	ldb (xsp+15),13
	ldb (xsp+16),10
	jr L5081
L5080:
	ld a,(xsp+14)
	cp a,0
	jr z,L5082
	call _theme_obj_kind_right
	ld (xsp+15),a
	ldb (xsp+16),2
	jr L5083
L5082:
	call _theme_obj_kind_left
	ld (xsp+15),a
	ldb (xsp+16),1
L5083:
L5081:
L5079:
L5077:
L5075:
	ld c,(xsp+14)
	cp c,0
	jr z,L5084
	ld c,(xsp+15)
	cp c,11
	jr ult,L5084
	ld wa,1
	jr L5085
L5084:
	ld wa,0
L5085:
	ld (xsp+20),a
	ld a,(_scn_mode__31)
	cp a,5
	jr nz,L5086
	ld a,(_g_vb_counter)
	extz wa
	sra 3,wa
	ld c,(xsp+12)
	extz bc
	add wa,bc
	and wa,1
	ld (xsp+20),a
	jr L5087
L5086:
	ld a,(_scn_mode__31)
	cp a,3
	jr nz,L5088
	ldb (xsp+20),0
	jr L5089
L5088:
	ld a,(_scn_mode__31)
	cp a,4
	jr nz,L5090
	ldb (xsp+20),1
L5090:
L5089:
L5087:
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
	jr ge,L5091
	jp L5060
L5091:
	ld wa,(xsp+38)
	cp wa,(xsp+6)
	jr le,L5092
	ld wa,(xsp+6)
	ld (xsp+38),wa
L5092:
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
	jr z,L5093
	ld wa,(xsp+40)
	add wa,(xsp+42)
	ld (xsp+26),wa
	jr L5094
L5093:
	ld wa,(xsp+40)
	sub wa,(xsp+42)
	ld xbc,(xsp+34)
	ld c,(xbc+6)
	extz bc
	sub wa,bc
	add wa,1
	ld (xsp+26),wa
L5094:
	ld wa,(xsp+26)
	cp wa,65504
	jr lt,L5096
	ld wa,(xsp+26)
	cp wa,168
	jr le,L5095
L5096:
	jp L5060
L5095:
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
	jr z,L5097
	ld wa,128
	jr L5098
L5097:
	ld wa,0
L5098:
	ld e,(_bridge_line)
	cp e,0
	jr z,L5099
	ld e,(xsp+19)
	cp e,(_bridge_line)
	jr uge,L5099
	ld bc,16
	jr L5100
L5099:
	ld c,(_id_spr_priority)
	extz bc
L5100:
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
L5060:
	incb 1,(xsp+0)
L5061:
	ld a,(xsp+0)
	cp a,6
	jp ult,L5058
L5059:
	ld a,(xsp+3)
	push xwa
	ld a,(xsp+6)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L5050:
	lda xsp,(xsp+60)
	pop xiz
	ret

; function ovl_clear
_ovl_clear:
	push xiz
	lda xsp,(xsp-6)
	ld a,(xsp+14)
	ld ixl,a
	jr L5114
L5111:
	ld xwa,_ovl_grid
	ld c,ixl
	sub c,2
	extz bc
	mul xbc,20
	ld e,(xsp+22)
	extz de
	add bc,de
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld xiy,xwa
	ld a,(xsp+22)
	ld izl,a
	jr L5118
L5115:
	ld wa,0
	ld xbc,xiy
	inc 2,xbc
	ld xiy,xbc
	dec 2,xbc
	ld (xbc),wa
L5117:
	inc 1,izl
L5118:
	ld a,izl
	cp a,(xsp+26)
	jr ule,L5115
L5116:
L5113:
	inc 1,ixl
L5114:
	ld a,ixl
	cp a,(xsp+18)
	jr ule,L5111
L5112:
L5110:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ovl_mark
_ovl_mark:
	push xiz
	ld a,(xsp+8)
	ld iyl,a
	ld a,(xsp+12)
	ld ixl,a
	ld a,(xsp+20)
	ld izl,a
	ld a,iyl
	cp a,2
	jr uge,L5131
	ld iyl,2
L5131:
	ld a,ixl
	cp a,18
	jr ule,L5132
	ld ixl,18
L5132:
	ld a,izl
	cp a,20
	jr ult,L5133
	ld izl,19
L5133:
	ld a,ixl
	cp a,iyl
	jr ult,L5135
	ld a,izl
	cp a,(xsp+16)
	jr uge,L5134
L5135:
	jr L5130
L5134:
	ld a,(_m_r0__32)
	cp a,255
	jr nz,L5136
	ld a,iyl
	ld (_m_r0__32),a
	ld a,ixl
	ld (_m_r1__32),a
	ld a,(xsp+16)
	ld (_m_c0__32),a
	ld a,izl
	ld (_m_c1__32),a
	jr L5130
L5136:
	ld a,iyl
	cp a,(_m_r0__32)
	jr uge,L5137
	ld a,iyl
	ld (_m_r0__32),a
L5137:
	ld a,ixl
	cp a,(_m_r1__32)
	jr ule,L5138
	ld a,ixl
	ld (_m_r1__32),a
L5138:
	ld a,(xsp+16)
	cp a,(_m_c0__32)
	jr uge,L5139
	ld a,(xsp+16)
	ld (_m_c0__32),a
L5139:
	ld a,izl
	cp a,(_m_c1__32)
	jr ule,L5140
	ld a,izl
	ld (_m_c1__32),a
L5140:
L5130:
	pop xiz
	ret

; function ovl_touch
_ovl_touch:
	push xiz
	lda xsp,(xsp-6)
	push xix
	push xiy
	ld a,(xsp+34)
	push xwa
	ld a,(xsp+34)
	push xwa
	ld a,(xsp+34)
	push xwa
	ld a,(xsp+34)
	push xwa
	call _ovl_mark
	lda xsp,(xsp+16)
	pop xiy
	pop xix
	ld a,(xsp+14)
	cp a,2
	jr uge,L5155
	ldb (xsp+14),2
L5155:
	ld a,(xsp+18)
	cp a,18
	jr ule,L5156
	ldb (xsp+18),18
L5156:
	ld a,(xsp+26)
	cp a,20
	jr ult,L5157
	ldb (xsp+26),19
L5157:
	ld a,(xsp+14)
	ld ixl,a
	jr L5161
L5158:
	ld xwa,_ovl_prev__32
	ld c,ixl
	extz bc
	sub bc,2
	mul xbc,20
	ld e,(xsp+22)
	extz de
	add bc,de
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld xiy,xwa
	ld a,(xsp+22)
	ld izl,a
	jr L5165
L5162:
	ld wa,65535
	ld xbc,xiy
	inc 2,xbc
	ld xiy,xbc
	dec 2,xbc
	ld (xbc),wa
L5164:
	inc 1,izl
L5165:
	ld a,izl
	cp a,(xsp+26)
	jr ule,L5162
L5163:
L5160:
	inc 1,ixl
L5161:
	ld a,ixl
	cp a,(xsp+18)
	jr ugt,L5166
	ld a,(xsp+18)
	cp a,(xsp+14)
	jr uge,L5158
L5166:
L5159:
L5154:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ovl_commit
_ovl_commit:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_m_r0__32)
	cp a,255
	jr nz,L5170
	jp L5169
L5170:
	ld a,(_m_r0__32)
	extz wa
	sub wa,2
	mul xwa,20
	ld c,(_m_c0__32)
	extz bc
	add wa,bc
	ld iz,wa
	ld xwa,_ovl_grid
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (_fl__32),xwa
	ld xwa,_ovl_prev__32
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (_fl__32+4),xwa
	ld xwa,36864
	ld c,(_m_r0__32)
	extz bc
	sll 5,bc
	ld e,(_m_c0__32)
	extz de
	add bc,de
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (_fl__32+8),xwa
	ld a,(_m_r1__32)
	sub a,(_m_r0__32)
	add a,1
	ld (_fl__32+12),a
	ld a,(_m_c1__32)
	sub a,(_m_c0__32)
	add a,1
	ld (_fl__32+13),a
	ldb (_m_r0__32),255
	ldb (_fl_ready__32),1
L5169:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ovl_vblank
_ovl_vblank:
	ld a,(_fl_ready__32)
	cp a,0
	jr z,L5174
	ld xwa,_fl__32
	push xwa
	call _ovl_flush_asm
	lda xsp,(xsp+4)
	ldb (_fl_ready__32),0
L5174:
L5173:
	ret

; function ovl_forget
_ovl_forget:
	push xiz
	lda xsp,(xsp-2)
	ldb (_fl_ready__32),0
	ldb (_m_r0__32),255
	ld iz,0
	jr L5185
L5182:
	ld xwa,_ovl_prev__32
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,0
	jr z,L5186
	ld wa,0
	ld xbc,36864
	ld de,iz
	extz xde
	div xde,20
	add de,2
	sll 5,de
	ld hl,iz
	extz xhl
	div xhl,20
	ld hl,qhl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5186:
	ld wa,0
	ld xbc,_ovl_prev__32
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,0
	ld xbc,_ovl_grid
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5184:
	inc 1,iz
L5185:
	ld wa,iz
	cp wa,340
	jr ult,L5182
L5183:
L5181:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function theme_init_tiles
_theme_init_tiles:
	ld wa,(xsp+4)
	ld (_pano_base__33),wa
	ld wa,(xsp+8)
	ld (_obj_base__33),wa
	ld wa,(xsp+12)
	ld (_obj_end__33),wa
L5188:
	ret

; function theme_obj_map
_theme_obj_map:
	ld xwa,_objmap__33
	jr L5190
L5190:
	ret

; function theme_obj_tile
_theme_obj_tile:
	ld xwa,_objmap__33
	ld c,(xsp+4)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L5192
L5192:
	ret

; function theme_obj_kind_left
_theme_obj_kind_left:
	ld a,(_kind_l__33)
	jr L5194
L5194:
	ret

; function theme_obj_kind_right
_theme_obj_kind_right:
	ld a,(_kind_r__33)
	jr L5196
L5196:
	ret

; function load_tile
_load_tile__33:
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
	jr L5206
L5203:
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
L5205:
	inc 1,izl
L5206:
	ld a,izl
	cp a,8
	jr ult,L5203
L5204:
L5202:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function alloc_slot
_alloc_slot__33:
	push xiz
	lda xsp,(xsp-4)
	ld wa,(_next_slot__33)
	ld iz,wa
	ld wa,(_pano_base__33)
	add wa,111
	ld (xsp+2),wa
	ld wa,iz
	cp wa,32
	jr ult,L5214
	ld wa,iz
	cp wa,101
	jr uge,L5214
	ld iz,101
	jr L5215
L5214:
	ld wa,iz
	cp wa,125
	jr ult,L5216
	ld wa,iz
	cp wa,(_pano_base__33)
	jr uge,L5216
	ld wa,(_obj_base__33)
	ld iz,wa
L5216:
L5215:
	ld wa,iz
	cp wa,(_obj_end__33)
	jr ult,L5217
	ld wa,(_pano_end__33)
	ld iz,wa
L5217:
	ld wa,iz
	cp wa,(xsp+2)
	jr ult,L5218
	ld wa,iz
	cp wa,(_obj_base__33)
	jr uge,L5218
	ld wa,0
	jr L5213
L5218:
	ld wa,iz
	add wa,1
	ld (_next_slot__33),wa
	ld wa,iz
	jr L5213
L5213:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function load_kind
_load_kind__33:
	push xiz
	lda xsp,(xsp-10)
	ldb (xsp+0),0
	jp L5234
L5231:
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
	jp L5238
L5235:
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
	ld xwa,_objmap__33
	ld c,(xsp+7)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65535
	jr nz,L5239
	call _alloc_slot__33
	ld (xsp+8),wa
	ld wa,(xsp+8)
	ld xbc,_objmap__33
	ld e,(xsp+7)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+8)
	cp wa,0
	jr z,L5240
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
	call _load_tile__33
	lda xsp,(xsp+8)
L5240:
L5239:
L5237:
	inc 1,izl
L5238:
	ld a,izl
	ld xbc,(xsp+2)
	ld c,(xbc+2)
	cp a,c
	jp ult,L5235
L5236:
L5233:
	incb 1,(xsp+0)
L5234:
	ld a,(xsp+0)
	cp a,5
	jp ult,L5231
L5232:
L5230:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function set_spr_pal
_set_spr_pal__33:
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
	jr L5250
L5247:
	ld xwa,xix
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_cur_spr__33
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
L5249:
	inc 1,izl
L5250:
	ld a,izl
	cp a,4
	jr ult,L5247
L5248:
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
L5246:
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
	jr L5289
L5286:
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
	ld wa,(_pano_base__33)
	add wa,iz
	push xwa
	call _load_tile__33
	lda xsp,(xsp+8)
	pop xiy
	pop xix
L5288:
	inc 1,iz
L5289:
	ld wa,iz
	cp wa,(xiy+4)
	jr ult,L5286
L5287:
	ld iz,0
	jr L5293
L5290:
	ld xwa,(xiy+14)
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_cur_pals__33
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5292:
	inc 1,iz
L5293:
	ld wa,iz
	cp wa,52
	jr ult,L5290
L5291:
	ldb (xsp+11),0
	jr L5297
L5294:
	ld ixl,0
	jr L5301
L5298:
	ld a,(xsp+11)
	extz wa
	sll 5,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld (xsp+12),wa
	ld wa,(_pano_base__33)
	ld xbc,(xiy+6)
	ld de,(xsp+12)
	extz xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	ld xbc,_pano_slot__33
	ld xde,(xiy+10)
	ld hl,(xsp+12)
	extz xhl
	add xde,xhl
	ld e,(xde)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	sll 9,bc
	add wa,bc
	ld xbc,38912
	ld de,(xsp+12)
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5300:
	inc 1,ixl
L5301:
	ld a,ixl
	cp a,32
	jr ult,L5298
L5299:
L5296:
	incb 1,(xsp+11)
L5297:
	ld a,(xsp+11)
	cp a,11
	jr ult,L5294
L5295:
	ld wa,(_pano_base__33)
	add wa,(xiy+4)
	ld (_pano_end__33),wa
	ld wa,(xiy+18)
	ld (_cur_backdrop__33),wa
	ld wa,(xiy+18)
	ld (_cur_road__33),wa
	ld xwa,(xsp+0)
	ld wa,(xwa+4)
	ld (_cur_road__33+2),wa
	ld xwa,(xsp+0)
	lda xwa,(xwa+8)
	ld wa,(xwa)
	ld (_cur_road__33+4),wa
	ld xwa,(xsp+0)
	ld wa,(xwa+6)
	ld (_cur_road__33+6),wa
	ld iz,0
	jr L5305
L5302:
	ld xwa,(xsp+0)
	lda xwa,(xwa+8)
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_cur_band__33
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5304:
	inc 1,iz
L5305:
	ld wa,iz
	cp wa,4
	jr ult,L5302
L5303:
	ld iz,0
	jr L5309
L5306:
	ld wa,65535
	ld xbc,_objmap__33
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5308:
	inc 1,iz
L5309:
	ld wa,iz
	cp wa,256
	jr ult,L5306
L5307:
	ldw (_next_slot__33),2
	ld xwa,(xsp+0)
	ld a,(xwa+1)
	ld (_kind_l__33),a
	ld xwa,(xsp+0)
	ld a,(xwa+2)
	ld (_kind_r__33),a
	push xix
	push xiy
	ld a,(_kind_l__33)
	push xwa
	call _load_kind__33
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld a,(_kind_r__33)
	cp a,(_kind_l__33)
	jr z,L5310
	push xix
	push xiy
	ld a,(_kind_r__33)
	push xwa
	call _load_kind__33
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L5310:
	push xix
	push xiy
	ld wa,11
	push xwa
	call _load_kind__33
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld a,(xsp+22)
	cp a,10
	jr uge,L5311
	push xix
	push xiy
	ld wa,12
	push xwa
	call _load_kind__33
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L5311:
	push xix
	push xiy
	ld wa,13
	push xwa
	call _load_kind__33
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld a,(xsp+22)
	cp a,0
	jr z,L5313
	ld a,(xsp+22)
	cp a,10
	jr ult,L5312
L5313:
	push xix
	push xiy
	ld wa,14
	push xwa
	call _load_kind__33
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L5312:
	ld iz,0
	jr L5317
L5314:
	ld xwa,_objmap__33
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65535
	jr nz,L5318
	ld wa,0
	ld xbc,_objmap__33
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5318:
L5316:
	inc 1,iz
L5317:
	ld wa,iz
	cp wa,256
	jr ult,L5314
L5315:
	push xix
	push xiy
	ld wa,0
	push xwa
	ld a,(_kind_l__33)
	push xwa
	ld wa,1
	push xwa
	call _set_spr_pal__33
	lda xsp,(xsp+12)
	pop xiy
	pop xix
	push xix
	push xiy
	ld wa,1
	push xwa
	ld a,(_kind_r__33)
	push xwa
	ld wa,2
	push xwa
	call _set_spr_pal__33
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
	call _set_spr_pal__33
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
	call _set_spr_pal__33
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
	call _set_spr_pal__33
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
	call _set_spr_pal__33
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
L5285:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function theme_crowd_colours
_theme_crowd_colours:
	lda xsp,(xsp-4)
	ld xwa,_gfx_obj_pals+112
	ld (xsp+0),xwa
	ld a,(xsp+8)
	cp a,0
	jr z,L5323
	ld xwa,(xsp+0)
	ld wa,(xwa+6)
	push xwa
	ld wa,3683
	push xwa
	ld wa,1197
	push xwa
	ld wa,0
	push xwa
	ld wa,8
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	ld xwa,(xsp+0)
	ld wa,(xwa+6)
	push xwa
	ld wa,1202
	push xwa
	ld wa,274
	push xwa
	ld wa,0
	push xwa
	ld a,10
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	jr L5324
L5323:
	ld wa,(_cur_spr__33+24+6)
	push xwa
	ld wa,(_cur_spr__33+24+4)
	push xwa
	ld wa,(_cur_spr__33+24+2)
	push xwa
	ld wa,(_cur_spr__33+24)
	push xwa
	ld a,10
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
L5324:
L5322:
	lda xsp,(xsp+4)
	ret

; function to_white
_to_white__33:
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
	jr ult,L5328
	ld wa,4095
	jr L5327
L5328:
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
	jr L5327
L5327:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function theme_flash
_theme_flash:
	push xiz
	lda xsp,(xsp-10)
	ld izl,0
	jp L5342
L5339:
	ld a,(xsp+18)
	push xwa
	ld xwa,_cur_pals__33
	ld c,izl
	extz bc
	sll 2,bc
	add bc,3
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__33
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+22)
	push xwa
	ld xwa,_cur_pals__33
	ld c,izl
	extz bc
	sll 2,bc
	add bc,2
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__33
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+26)
	push xwa
	ld xwa,_cur_pals__33
	ld c,izl
	extz bc
	sll 2,bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__33
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+30)
	push xwa
	ld xwa,_cur_pals__33
	ld c,izl
	extz bc
	sll 2,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__33
	lda xsp,(xsp+8)
	push xwa
	ld xwa,_pano_slot__33
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld wa,1
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
L5341:
	inc 1,izl
L5342:
	ld a,izl
	cp a,13
	jp ult,L5339
L5340:
	ldb (xsp+1),0
	jr L5346
L5343:
	ld a,(xsp+18)
	push xwa
	ld xwa,_cur_band__33
	ld c,(xsp+5)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__33
	lda xsp,(xsp+8)
	lda xbc,(xsp+2)
	ld e,(xsp+1)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5345:
	incb 1,(xsp+1)
L5346:
	ld a,(xsp+1)
	cp a,4
	jr ult,L5343
L5344:
	lda xwa,(xsp+2)
	push xwa
	ld a,(xsp+22)
	push xwa
	ld wa,(_cur_road__33+6)
	push xwa
	call _to_white__33
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+26)
	push xwa
	ld wa,(_cur_road__33+2)
	push xwa
	call _to_white__33
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+30)
	push xwa
	ld wa,(_cur_backdrop__33)
	push xwa
	call _to_white__33
	lda xsp,(xsp+8)
	push xwa
	call _id_road_set_colors
	lda xsp,(xsp+16)
L5338:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function traffic_set_hard
_traffic_set_hard:
	ld a,(xsp+4)
	ld (_hard__34),a
	ld c,(xsp+4)
	cp c,0
	jr z,L5351
	ld wa,7
	jr L5352
L5351:
	ld wa,6
L5352:
	ld (_trf_cap__34),a
L5350:
	ret

; function rnd8
_rnd8__34:
	ld wa,(_rng__34)
	mul xwa,25173
	add wa,13849
	ld (_rng__34),wa
	ld wa,(_rng__34)
	srl 8,wa
	jr L5354
L5354:
	ret

; function traffic_init
_traffic_init:
	push xiz
	lda xsp,(xsp-2)
	ld wa,(xsp+10)
	ld (_trf_tiles__34),wa
	ld iz,0
	jr L5368
L5365:
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
L5367:
	inc 1,iz
L5368:
	ld wa,iz
	ld bc,(_gfx_traffic_tiles_count)
	sll 3,bc
	cp wa,bc
	jr ult,L5365
L5366:
	ld iz,0
	jr L5372
L5369:
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
L5371:
	inc 1,iz
L5372:
	ld wa,iz
	cp wa,5
	jr ult,L5369
L5370:
	call _traffic_clear
L5364:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function traffic_set_car_line
_traffic_set_car_line:
	ld a,(xsp+4)
	push xwa
	call _id_road_distance_at_line
	lda xsp,(xsp+4)
	ld (_car_d__34),wa
	ld a,(xsp+4)
	push xwa
	call _id_road_half_at
	lda xsp,(xsp+4)
	ld (_half_wheel__34),a
	ld a,(_half_wheel__34)
	cp a,0
	jr nz,L5376
	ldb (_half_wheel__34),1
L5376:
L5375:
	ret

; function traffic_clear
_traffic_clear:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L5386
L5383:
	ld a,0
	ld xbc,_cars__34
	ld e,izl
	extz de
	muls xde,14
	add xbc,xde
	ld (xbc),a
L5385:
	inc 1,izl
L5386:
	ld a,izl
	cp a,7
	jr ult,L5383
L5384:
	ld a,50
	push xwa
	ld a,28
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L5382:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function traffic_reset
_traffic_reset:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,(_trf_cap__34)
	jr ule,L5392
	ld a,(_trf_cap__34)
	ld izl,a
L5392:
	ld a,izl
	ld (_dens_min__34),a
	ld c,(xsp+12)
	cp c,(_trf_cap__34)
	jr ule,L5393
	ld a,(_trf_cap__34)
	extz wa
	jr L5394
L5393:
	ld a,(xsp+12)
	extz wa
L5394:
	ld (_dens_max__34),a
	ld a,(_dens_min__34)
	ld (_target__34),a
	ldb (_cooldown__34),30
L5391:
	pop xiz
	ret

; function lane_lat
_lane_lat__34:
	lda xsp,(xsp-2)
	ld a,(_half_wheel__34)
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
	jr L5396
L5396:
	lda xsp,(xsp+2)
	ret

; function lane_of
_lane_of__34:
	push xiz
	lda xsp,(xsp-4)
	ld a,(_half_wheel__34)
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
	jr ge,L5401
	ld iz,0
L5401:
	ld wa,iz
	cp wa,3
	jr le,L5402
	ld iz,3
L5402:
	ld a,izl
	jr L5400
L5400:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function spawn
_spawn__34:
	push xiz
	lda xsp,(xsp-10)
	ld wa,0
	exts xwa
	ld (xsp+4),xwa
	ld izl,0
	jr L5428
L5425:
	ld xwa,_cars__34
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L5429
	ld xwa,_cars__34
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+4),xwa
	jr L5426
L5429:
L5427:
	inc 1,izl
L5428:
	ld a,izl
	cp a,7
	jr ult,L5425
L5426:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L5430
	jp L5424
L5430:
	ldb (xsp+2),0
	jp L5434
L5431:
	ld wa,0
	ld (xsp+8),a
	call _rnd8__34
	extz wa
	and wa,3
	ld (xsp+1),a
	ld izl,0
	jr L5438
L5435:
	ld xwa,_cars__34
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L5439
	ld xwa,_cars__34
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+4)
	push xwa
	ld a,(xsp+5)
	push xwa
	call _lane_lat__34
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp wa,bc
	jr nz,L5439
	ld xwa,_cars__34
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	ld bc,1450
	ld de,(_car_d__34)
	sub bc,de
	sub bc,400
	sll 4,bc
	cp wa,bc
	jr le,L5439
	ldb (xsp+8),1
L5439:
L5437:
	inc 1,izl
L5438:
	ld a,izl
	cp a,7
	jr ult,L5435
L5436:
	ld a,(xsp+8)
	cp a,0
	jr nz,L5440
	jr L5432
L5440:
L5433:
	incb 1,(xsp+2)
L5434:
	ld a,(xsp+2)
	cp a,3
	jp ult,L5431
L5432:
	ld a,(xsp+2)
	cp a,3
	jr nz,L5441
	jp L5424
L5441:
	ld a,1
	ld xbc,(xsp+4)
	ld (xbc),a
	call _rnd8__34
	extz wa
	exts xwa
	divs xwa,3
	ld wa,qwa
	ld xbc,(xsp+4)
	ld (xbc+1),a
	ld wa,11
	push xwa
	call _rnd8__34
	ld xbc,xwa
	pop xwa
	extz bc
	exts xbc
	divs xbc,5
	ld bc,qbc
	add wa,bc
	ld xbc,(xsp+4)
	ld (xbc+2),a
	ld c,(_hard__34)
	cp c,0
	jr z,L5442
	ld wa,42
	jr L5443
L5442:
	ld wa,55
L5443:
	push xwa
	call _rnd8__34
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
	jr nz,L5444
	ld xwa,(xsp+4)
	ld a,(xwa+3)
	sub a,15
	ld xbc,(xsp+4)
	ld (xbc+3),a
L5444:
	ld a,(xsp+1)
	push xwa
	call _lane_lat__34
	lda xsp,(xsp+4)
	ld xbc,(xsp+4)
	ld (xbc+4),wa
	ld xwa,(xsp+4)
	ld wa,(xwa+4)
	ld xbc,(xsp+4)
	ld (xbc+10),wa
	ld wa,1450
	ld bc,(_car_d__34)
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
L5424:
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
	jp L5477
L5474:
	ld xwa,_cars__34
	ld c,(xsp+0)
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld xiz,xwa
	ld a,(xiz)
	cp a,0
	jr nz,L5478
	jp L5476
L5478:
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
	jr z,L5479
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr ge,L5480
	ld wa,(xiz+4)
	add wa,8
	ld (xiz+4),wa
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr le,L5481
	ld wa,(xiz+10)
	ld (xiz+4),wa
L5481:
	jr L5482
L5480:
	ld wa,(xiz+4)
	sub wa,8
	ld (xiz+4),wa
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr ge,L5483
	ld wa,(xiz+10)
	ld (xiz+4),wa
L5483:
L5482:
	jr L5484
L5479:
	call _rnd8__34
	ld e,(_hard__34)
	cp e,0
	jr z,L5486
	ld bc,6
	jr L5487
L5486:
	ld bc,2
L5487:
	cp a,c
	jr uge,L5485
	ld wa,(xiz+4)
	push xwa
	call _lane_of__34
	lda xsp,(xsp+4)
	ld (xsp+8),a
	ld a,(xsp+8)
	cp a,0
	jr nz,L5488
	ldb (xsp+8),1
	jr L5489
L5488:
	ld a,(xsp+8)
	cp a,3
	jr nz,L5490
	ldb (xsp+8),2
	jr L5491
L5490:
	push xwa
	call _rnd8__34
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,1
	cp bc,0
	jr z,L5492
	ld a,(xsp+8)
	add a,1
	extz wa
	jr L5493
L5492:
	ld a,(xsp+8)
	sub a,1
	extz wa
L5493:
	ld (xsp+8),a
L5491:
L5489:
	ld a,(xsp+8)
	push xwa
	call _lane_lat__34
	lda xsp,(xsp+4)
	ld (xiz+10),wa
L5485:
L5484:
	ld wa,(xiz+6)
	ld bc,(_car_d__34)
	neg bc
	sll 4,bc
	sub bc,64
	cp wa,bc
	jr lt,L5495
	ld wa,(xiz+6)
	ld bc,1600
	ld de,(_car_d__34)
	sub bc,de
	sll 4,bc
	cp wa,bc
	jr le,L5494
L5495:
	ldb (xiz),0
	jr L5476
L5494:
	incb 1,(xsp+1)
L5476:
	incb 1,(xsp+0)
L5477:
	ld a,(xsp+0)
	cp a,7
	jp ult,L5474
L5475:
	ld a,(_cooldown__34)
	cp a,0
	jr z,L5496
	decb 1,(_cooldown__34)
L5496:
	ld a,(xsp+22)
	cp a,0
	jr z,L5497
	ld a,(xsp+1)
	cp a,(_target__34)
	jr uge,L5497
	ld a,(_cooldown__34)
	cp a,0
	jr nz,L5497
	ld a,(xsp+18)
	cp a,50
	jr ule,L5497
	call _spawn__34
	ld c,(_hard__34)
	cp c,0
	jr z,L5498
	ld wa,16
	jr L5499
L5498:
	ld wa,25
L5499:
	push xwa
	call _rnd8__34
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,31
	add wa,bc
	ld (_cooldown__34),a
	ld a,(_dens_max__34)
	cp a,(_dens_min__34)
	jr ule,L5500
	ld a,(_dens_min__34)
	extz wa
	push xwa
	call _rnd8__34
	ld xbc,xwa
	pop xwa
	extz bc
	exts xbc
	ld e,(_dens_max__34)
	sub e,(_dens_min__34)
	add e,1
	extz de
	divs xbc,de
	ld bc,qbc
	add wa,bc
	ld (_target__34),a
L5500:
L5497:
L5473:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function traffic_collide
_traffic_collide:
	push xiz
	lda xsp,(xsp-12)
	ld iyl,0
	jp L5521
L5518:
	ld xwa,_cars__34
	ld c,iyl
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld xiz,xwa
	ld a,(xiz)
	cp a,0
	jr nz,L5522
	jp L5520
L5522:
	ld bc,(xiz+12)
	cp bc,(xiz+6)
	jr ge,L5523
	ld wa,(xiz+12)
	jr L5524
L5523:
	ld wa,(xiz+6)
L5524:
	ld (xsp+8),wa
	ld bc,(xiz+12)
	cp bc,(xiz+6)
	jr ge,L5525
	ld wa,(xiz+6)
	jr L5526
L5525:
	ld wa,(xiz+12)
L5526:
	ld (xsp+10),wa
	ld wa,(xsp+8)
	cp wa,224
	jr gt,L5528
	ld wa,(xsp+10)
	cp wa,65440
	jr ge,L5527
L5528:
	jr L5520
L5527:
	ld wa,(xiz+4)
	sub wa,(xsp+20)
	ld ix,wa
	ld wa,ix
	cp wa,0
	jr ge,L5529
	ld wa,ix
	neg wa
	ld ix,wa
L5529:
	ld wa,ix
	cp wa,416
	jr ge,L5530
	ld wa,(xiz+6)
	add wa,960
	ld (xiz+6),wa
	ld wa,(xiz+6)
	ld (xiz+12),wa
	ld a,(xiz+3)
	add a,30
	ld (xiz+3),a
	ld bc,(xiz+4)
	cp bc,(xsp+20)
	jr ge,L5531
	ld wa,1
	jr L5532
L5531:
	ld wa,2
L5532:
	jr L5517
L5530:
L5520:
	inc 1,iyl
L5521:
	ld a,iyl
	cp a,7
	jp ult,L5518
L5519:
	ld wa,0
	jr L5517
L5517:
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
	jr L5569
L5566:
	ld xwa,_cars__34
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L5570
	ld a,izl
	lda xbc,(xsp+0)
	ld e,(xsp+7)
	incb 1,(xsp+7)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L5570:
L5568:
	inc 1,izl
L5569:
	ld a,izl
	cp a,7
	jr ult,L5566
L5567:
	ld izl,1
	jp L5574
L5571:
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+14),a
	ld a,izl
	ld ixl,a
	jr L5577
L5575:
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
L5577:
	ld a,ixl
	cp a,0
	jr ule,L5578
	ld xwa,_cars__34
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
	ld xbc,_cars__34
	ld e,(xsp+14)
	extz de
	muls xde,14
	add xbc,xde
	ld bc,(xbc+6)
	cp wa,bc
	jr gt,L5575
L5578:
L5576:
	ld a,(xsp+14)
	lda xbc,(xsp+0)
	ld e,ixl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L5573:
	inc 1,izl
L5574:
	ld a,izl
	cp a,(xsp+7)
	jp ult,L5571
L5572:
	ld izl,0
	jp L5582
L5579:
	ld xwa,_cars__34
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
	ld wa,(_car_d__34)
	ld xbc,(xsp+14)
	ld bc,(xbc+6)
	exts xbc
	divs xbc,16
	add wa,bc
	ld (xsp+18),wa
	ld wa,(xsp+18)
	cp wa,0
	jr ge,L5583
	jp L5581
L5583:
	push xix
	ld wa,(xsp+22)
	push xwa
	call _id_road_line_at_distance
	lda xsp,(xsp+4)
	pop xix
	ld (xsp+20),a
	ld a,(xsp+20)
	cp a,255
	jr nz,L5584
	jp L5581
L5584:
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
	jr ge,L5585
	jp L5581
L5585:
	ld a,(xsp+28)
	extz wa
	sll 5,wa
	extz xwa
	ld c,(_half_wheel__34)
	extz bc
	div xwa,bc
	ld (xsp+22),a
	ld a,(xsp+22)
	cp a,28
	jr ult,L5586
	ldb (xsp+21),0
	jr L5587
L5586:
	ld a,(xsp+22)
	cp a,20
	jr ult,L5588
	ldb (xsp+21),1
	jr L5589
L5588:
	ld a,(xsp+22)
	cp a,13
	jr ult,L5590
	ldb (xsp+21),2
	jr L5591
L5590:
	ld a,(xsp+22)
	cp a,9
	jr ult,L5592
	ldb (xsp+21),3
	jr L5593
L5592:
	ldb (xsp+21),4
L5593:
L5591:
L5589:
L5587:
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
	ld e,(_half_wheel__34)
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
	jr le,L5594
	jp L5581
L5594:
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
	ld wa,(_trf_tiles__34)
	ld (xsp+52),wa
	ld wa,(xsp+38)
	ld (xsp+54),wa
	ld a,(xsp+42)
	ld (xsp+56),a
	ld xwa,(xsp+30)
	ld a,(xwa+2)
	ld (xsp+57),a
	ldb (xsp+58),0
	ld c,(_bridge_line)
	cp c,0
	jr z,L5595
	ld bc,(xsp+26)
	ld e,(_bridge_line)
	extz de
	cp bc,de
	jr ge,L5595
	ld wa,16
	jr L5596
L5595:
	ld a,(_id_spr_priority)
	extz wa
L5596:
	ld (xsp+59),a
	ld xwa,(xsp+14)
	ld a,(xwa+2)
	ld (xsp+60),a
	ld a,(xsp+10)
	ld (xsp+61),a
	ld a,(_trf_spr_end)
	ld (xsp+62),a
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
L5581:
	inc 1,izl
L5582:
	ld a,izl
	cp a,(xsp+7)
	jp ult,L5579
L5580:
	push xix
	ld a,(_trf_spr_end)
	push xwa
	ld a,(xsp+18)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xix
L5565:
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
	jp L5619
L5616:
	push xix
	push xiy
	ld a,iyl
	push xwa
	call _lane_lat__34
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (xsp+6),wa
	ld wa,32767
	ld (xsp+8),wa
	ld izl,0
	jp L5623
L5620:
	ld xwa,_cars__34
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L5625
	ld xwa,_cars__34
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	cp wa,65280
	jr ge,L5624
L5625:
	jr L5622
L5624:
	ld xwa,_cars__34
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+4)
	sub wa,(xsp+6)
	ld ix,wa
	ld wa,ix
	cp wa,0
	jr ge,L5626
	ld wa,ix
	neg wa
	ld ix,wa
L5626:
	ld wa,ix
	cp wa,480
	jr ge,L5627
	ld xwa,_cars__34
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	cp wa,(xsp+8)
	jr ge,L5627
	ld xwa,_cars__34
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	ld (xsp+8),wa
L5627:
L5622:
	inc 1,izl
L5623:
	ld a,izl
	cp a,7
	jp ult,L5620
L5621:
	ld wa,(xsp+8)
	cp wa,(xsp+4)
	jr gt,L5629
	ld wa,(xsp+8)
	cp wa,(xsp+4)
	jr nz,L5628
	ld wa,(xsp+24)
	cp wa,0
	jr ge,L5631
	ld a,iyl
	cp a,0
	jr z,L5630
L5631:
	ld wa,(xsp+24)
	cp wa,0
	jr le,L5628
	ld a,iyl
	cp a,3
	jr nz,L5628
L5630:
L5629:
	ld wa,(xsp+8)
	ld (xsp+4),wa
	ld a,iyl
	ld (xsp+2),a
L5628:
L5618:
	inc 1,iyl
L5619:
	ld a,iyl
	cp a,4
	jp ult,L5616
L5617:
	ld wa,(xsp+4)
	cp wa,14400
	jr le,L5632
	ld wa,(xsp+24)
	cp wa,0
	jr z,L5632
	ld wa,(xsp+24)
	jr L5615
L5632:
	push xix
	push xiy
	ld a,(xsp+10)
	push xwa
	call _lane_lat__34
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	jr L5615
L5615:
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


; ================================================================
; void id_road_wide_asm(RoadWide *w);   (SUNSET RUN)
;
; wide_rows() of id_road.c: from the bottom row up, the near rows whose plain
; copy would wrap around the 256 px map take the copy stored VSHIFT px to
; that side instead.  Stops at the first row outside the wide source rows.
;
;   XIX = &xy[scr] (descend de 2)   XIY = id_route_lim0
;   C = scr - plane0 (descend)      B = rows left
;   D = threshold of the negative side (0x90, 0x71 if lateral < 0)
;   E = base_x                      W = lim of the row
W_XY     equ 0      ; u16 *    &xy[road_bottom]
W_LIM    equ 4      ; const u8 * id_route_lim0
W_K      equ 8      ; u8 road_bottom - plane0
W_N      equ 9      ; u8 rows (> 0)
W_T      equ 10     ; u8 0x90 / 0x71
W_BX     equ 11     ; u8 base_x
WIDE0    equ 48
WIDE_END equ 88
VROWS    equ 40
VSHIFT   equ 96


_id_road_wide_asm:
        ld      xwa,(xsp+0x4)
        ld      xix,(xwa+W_XY)
        ld      xiy,(xwa+W_LIM)
        ld      bc,(xwa+W_K)            ; C = k, B = n
        ld      de,(xwa+W_T)            ; E = threshold, D = base_x
        ld      a,e
        ld      e,d
        ld      d,a                     ; D = threshold, E = base_x
wd_loop:
        ld      hl,(xix)                ; H = y, L = x
        ld      a,h
        add     a,c                     ; j = y + scr - plane0
        cp      a,WIDE0
        jr      c,wd_out
        cp      a,WIDE_END
        jr      nc,wd_out
        extz    wa
        ld      a,(xiy+wa)
        ld      w,a                     ; lim
        ld      a,l
        sub     a,e                     ; d = x - base_x
        cp      a,d
        jr      nc,wd_neg
        cp      a,w
        jr      c,wd_next
        add     h,VROWS
        sub     l,VSHIFT
        ld      (xix),hl
        jr      wd_next
wd_neg:
        neg     a                       ; |dx|
        cp      a,w
        jr      c,wd_next
        add     h,2*VROWS
        add     l,VSHIFT
        ld      (xix),hl
wd_next:
        dec     0x2,xix
        dec     0x1,c
        dec     0x1,b
        jr      nz,wd_loop
wd_out:
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
        add     hl,_spr_shadow          ; RAM copy, sent to 0x8800 in VBlank
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
        add     hl,_spr_pal_shadow      ; RAM copy of 0x8C00
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


; ================================================================
; void ovl_flush_asm(OvlFlush *f);   (SUNSET RUN, ovl.c, in VBlank)
;
; Writes to SCR1 the overlay cells of a box that differ from what is on
; screen.  XIX = grid, XIY = prev (both 20 cells a row), XHL = SCR1 (32).
F_GRID   equ 0
F_PREV   equ 4
F_VRAM   equ 8
F_ROWS   equ 12
F_COLS   equ 13


_ovl_flush_asm:
        push    xiz
        ld      xwa,(xsp+0x8)
        ld      xix,(xwa+F_GRID)
        ld      xiy,(xwa+F_PREV)
        ld      xhl,(xwa+F_VRAM)
        ld      bc,(xwa+F_ROWS)         ; C = rows, B = cols
        push    bc
        ld      a,b
        extz    wa
        add     wa,wa
        neg     wa                      ; -2 * cols
        ld      de,wa
        add     de,0x28                 ; 40 - 2 cols: next row of the grids
        extz    xde
        ld      iz,wa
        add     iz,0x40                 ; 64 - 2 cols: next SCR1 row
        extz    xiz
of_row:
        ld      b,(xsp+0x1)
of_col:
        ld      wa,(xix+)
        cp      wa,(xiy)
        jr      z,of_same
        ld      (xiy),wa
        ld      (xhl),wa
of_same:
        inc     0x2,xiy
        inc     0x2,xhl
        dec     0x1,b
        jr      nz,of_col
        add     xix,xde
        add     xiy,xde
        add     xhl,xiz
        dec     0x1,c
        jr      nz,of_row
        pop     bc
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
	db 84,72,69,32,69,78,84,69,82,84,65,73,78,69,82,0
_S0_1:
	db 77,65,80,76,69,32,76,69,65,70,32,82,65,71,0
_S0_2:
	db 80,73,78,69,32,65,80,80,76,69,32,82,65,71,0
_S0_3:
	db 80,69,65,67,72,69,82,73,78,69,32,82,65,71,0
_S0_4:
	db 83,73,76,69,78,67,73,79,0
	align 2
_station_name__0:
	dd _S0_0
	dd _S0_1
	dd _S0_2
	dd _S0_3
	dd _S0_4
_S0_5:
	db 69,65,83,89,0
_S0_6:
	db 78,79,82,77,65,76,0
_S0_7:
	db 72,65,82,68,0
_S0_8:
	db 70,82,69,69,0
	align 2
_diff_name__0:
	dd _S0_5
	dd _S0_6
	dd _S0_7
	dd _S0_8
_diff_pal__0:
	db 8,0,2,15
_S0_9:
	db 67,79,78,71,82,65,84,85,76,65,84,73,79,78,83,0
_S0_10:
	db 71,79,65,76,33,0
_S0_11:
	db 69,88,84,69,78,68,69,68,32,80,76,65,89,0
_S0_12:
	db 67,72,69,67,75,80,79,73,78,84,33,0
_lv__0_L363:
	db 1,2,3,4,4,4,4,3,3,2,1,0
_emblem_pal_slot__0:
	db 2,3,4,5,6,8,9,10,11,12,13,14,15
_over_pal_slot__0:
	db 4,5,6,10,11,12,13,14
_S0_13:
	db 72,73,0
_S0_14:
	db 66,58,78,69,87,0
_tsm__0_L595:
	db 1,125,126,127
_S0_15:
	db 80,82,69,83,83,32,65,32,84,79,32,83,84,65,82,84
	db 0
_S0_16:
	db 67,79,85,82,83,69,32,77,65,80,0
_S0_17:
	db 89,79,85,32,77,65,68,69,32,73,84,33,0
_S0_18:
	db 71,65,77,69,32,79,86,69,82,0
_S0_19:
	db 83,67,79,82,69,0
_S0_20:
	db 82,79,85,84,69,0
_S0_21:
	db 78,69,87,32,72,73,71,72,32,83,67,79,82,69,33,0
	align 2
_smoke_tiles__0:
	db 90,0,175,6,255,26,255,107,255,107,255,26,170,5,85,0
	db 0,148,0,233,64,250,144,254,165,255,164,254,80,170,0,85
	db 5,0,107,1,255,6,255,27,255,111,255,107,170,22,85,1
	db 0,148,0,229,64,250,144,255,144,255,149,254,80,170,0,85
_smoke_slot__0:
	db 1,125,126,127
_roll_lift__0:
	db 0,7,14,20,25,30,33,35,36,35,33,30,25,20,14,7
	db 0
_S0_22:
	db 80,65,85,83,69,0
_S0_23:
	db 84,73,77,69,32,85,80,0
_S0_24:
	db 98,32,76,69,70,84,32,32,32,32,82,73,71,72,84,32
	db 99,0
_S0_25:
	db 82,73,71,72,84,32,99,0
_S0_26:
	db 98,32,76,69,70,84,0
_S0_27:
	db 71,79,65,76,32,65,72,69,65,68,0
_S0_28:
	db 51,0
_S0_29:
	db 50,0
_S0_30:
	db 49,0
_S0_31:
	db 71,79,33,0
	align 2
_cd__0_L1189:
	dd _S0_28
	dd _S0_29
	dd _S0_30
	dd _S0_31
_S0_32:
	db 83,84,65,82,84,0
_S0_33:
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
	db 242,3,0,0,0,0,98,2,0,0,253,0,108,2,0,0
	db 3,0,218,2,230,255,0,0,144,1,232,255,0,0,244,1
	db 0,0,0,0,94,1,198,255,0,0,32,3,238,255,255,0
	db 88,2,237,255,0,0,244,1,18,0,0,0,188,2,232,255
	db 0,0,144,1,0,0,254,0,144,1,190,255,0,0,96,9
	db 0,0,0,0
	align 2
_leg6_seg__1:
	db 132,3,0,0,0,0,32,3,220,255,255,0,88,2,41,0
	db 2,0,244,1,0,0,0,0,144,1,187,255,0,0,144,1
	db 0,0,0,0,144,1,0,0,254,0,144,1,195,255,0,0
	db 32,3,23,0,253,0,242,3,0,0,0,0,98,2,0,0
	db 253,0,108,2,0,0,3,0,218,2,26,0,0,0,144,1
	db 41,0,0,0,244,1,23,0,3,0,144,1,227,255,254,0
	db 144,1,0,0,253,0,144,1,55,0,0,0,88,2,238,255
	db 1,0,244,1,0,0,3,0,144,1,55,0,0,0,96,9
	db 0,0,0,0
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
	db 0,0,244,1,189,255,0,0,242,3,0,0,0,0,98,2
	db 0,0,253,0,108,2,0,0,3,0,218,2,230,255,0,0
	db 244,1,0,0,0,0,244,1,53,0,0,0,144,1,0,0
	db 0,0,144,1,197,255,0,0,188,2,18,0,0,0,144,1
	db 0,0,0,0,144,1,59,0,0,0,96,9,0,0,0,0
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
	db 0,0,242,3,0,0,0,0,98,2,0,0,253,0,108,2
	db 0,0,3,0,218,2,26,0,0,0,144,1,0,0,255,0
	db 94,1,69,0,0,0,94,1,201,255,0,0,244,1,0,0
	db 0,0,144,1,69,0,0,0,144,1,0,0,0,0,244,1
	db 195,255,0,0,188,2,18,0,0,0,96,9,0,0,0,0
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
	db 0,0,94,1,56,0,0,0,94,1,194,255,0,0,242,3
	db 0,0,0,0,98,2,0,0,253,0,108,2,0,0,3,0
	db 218,2,230,255,0,0,244,1,0,0,0,0,144,1,70,0
	db 0,0,244,1,0,0,0,0,244,1,186,255,0,0,188,2
	db 236,255,1,0,32,3,224,255,254,0,96,9,0,0,0,0
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
	db 22,5
	dd _leg6_seg__1
	db 22,6
	dd _leg7_seg__1
	db 31,7
	dd _leg8_seg__1
	db 27,8
	dd _leg9_seg__1
	db 24,9
	dd _leg10_seg__1
	db 31,10
	dd _leg11_seg__1
	db 32,11
	dd _leg12_seg__1
	db 24,12
	dd _leg13_seg__1
	db 30,13
	dd _leg14_seg__1
	db 24,14
	align 2
_gfx_themes:
	db 0,0,0,0,153,10,255,15,153,10,170,11,204,13,255,15
	db 7,1,35,0,1,3,5,0,136,9,255,15,136,9,153,10
	db 187,12,255,15,10,2,25,0,5,2,3,0,152,10,255,15
	db 152,10,169,11,203,13,255,15,11,4,15,0,6,4,4,0
	db 104,9,223,10,104,9,121,10,155,11,223,11,8,1,30,0
	db 3,1,3,0,154,8,255,14,154,8,171,9,205,11,255,14
	db 5,1,45,0,2,7,6,0,152,8,255,15,152,8,169,9
	db 203,11,255,15,6,2,35,1,4,8,10,0,137,8,255,15
	db 137,8,154,9,188,11,255,15,9,3,20,1,9,3,2,0
	db 120,7,255,15,120,7,137,8,171,10,255,15,10,3,20,0
	db 10,2,2,0,153,11,255,15,153,11,170,12,204,14,255,15
	db 10,3,20,0,11,7,5,0,153,8,255,15,153,8,170,9
	db 204,11,255,15,7,2,35,1,12,9,9,0,119,8,255,15
	db 119,8,136,9,170,11,255,15,5,1,50,0,8,3,3,0
	db 137,7,255,14,137,7,154,8,188,10,255,14,11,3,15,0
	db 7,9,7,0,136,10,238,15,136,10,153,11,187,13,238,15
	db 9,2,25,1,13,0,6,0,153,10,255,15,153,10,170,11
	db 204,13,255,15,9,2,25,0,14,4,5,0,153,8,255,14
	db 153,8,170,9,204,11,255,14,10,2,20,1
	align 2
_gfx_leg_ref_cost:
	db 212,3,30,4,211,3,247,3,31,4
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
_gfx_bridge_tiles:
	db 255,255,255,255,85,85,169,171,173,186,169,170,85,85,174,166
	db 85,85,169,171,173,186,169,170,85,85,174,166,170,234,170,166
	db 85,85,169,171,173,186,169,170,85,85,106,154,85,85,85,85
	db 106,170,110,186,106,170,85,85,154,106,155,110,154,106,85,85
	db 106,250,110,250,106,250,85,245,154,250,155,254,154,250,85,245
	db 101,170,101,186,101,170,85,85,149,106,149,110,149,106,85,85
	db 0,0,0,0,0,0,0,0,0,0,255,255,170,171,85,85
	db 0,0,0,0,0,0,255,255,169,171,173,186,169,170,85,85
	db 53,0,57,0,57,0,57,0,53,0,57,0,57,0,57,0
	db 0,92,0,108,0,108,0,108,0,92,0,108,0,108,0,108
	db 85,3,169,3,169,3,169,3,85,3,169,3,169,3,169,3
	db 192,85,192,106,192,106,192,106,192,85,192,106,192,106,192,106
	align 2
_gfx_roll_frames:
	db 0,0,12,0,0,0,12,0,12,0,15,0,12,0,15,0
	db 27,0,16,0,27,0,16,0,43,0,12,0,43,0,12,1
	db 55,0,15,0,55,0,15,1,70,0,15,0,70,0,15,1
	db 85,0,12,0,85,0,12,1,97,0,16,0,97,0,16,1
	db 113,0,15,0,113,0,15,1,128,0,12,0,128,0,12,1
	db 140,0,15,0,140,0,15,0,155,0,15,0,155,0,15,0
	db 170,0,12,0,170,0,12,0,182,0,20,0,182,0,19,1
	db 202,0,24,0,201,0,21,1,226,0,20,0,222,0,18,1
	db 246,0,24,0,240,0,23,1,14,1,20,0,7,1,20,1
	db 34,1,12,0,27,1,12,0,46,1,24,0,39,1,23,0
	db 70,1,24,0,62,1,23,0,94,1,20,0,85,1,17,0
	db 114,1,24,0,102,1,21,0,138,1,22,0,123,1,21,0
_gfx_roll_cells:
	db 240,245,0,248,245,1,0,245,2,8,245,3,240,253,4,248
	db 253,5,0,253,6,8,253,7,240,5,8,248,5,9,0,5
	db 10,8,5,11,237,244,0,245,244,1,253,244,2,5,244,3
	db 237,252,4,245,252,5,253,252,6,5,252,7,13,252,8,237
	db 4,9,245,4,10,253,4,11,5,4,12,253,12,13,5,12
	db 14,238,242,0,246,242,1,254,242,2,6,242,3,238,250,4
	db 246,250,5,254,250,6,6,250,7,246,2,8,254,2,9,6
	db 2,10,246,10,11,254,10,12,6,10,13,246,18,14,254,18
	db 15,244,240,0,252,240,1,4,240,2,244,248,3,252,248,4
	db 4,248,5,244,0,6,252,0,7,4,0,8,244,8,9,252
	db 8,10,4,8,11,246,237,0,254,237,1,6,237,2,246,245
	db 3,254,245,4,6,245,5,238,253,6,246,253,7,254,253,8
	db 6,253,9,238,5,10,246,5,11,254,5,12,6,5,13,254
	db 13,14,253,238,0,5,238,1,237,246,2,245,246,3,253,246
	db 4,5,246,5,237,254,6,245,254,7,253,254,8,5,254,9
	db 13,254,10,237,6,11,245,6,12,253,6,13,5,6,14,240
	db 244,0,248,244,1,0,244,2,8,244,3,240,252,4,248,252
	db 5,0,252,6,8,252,7,240,4,8,248,4,9,0,4,10
	db 8,4,11,242,238,0,250,238,1,242,246,2,250,246,3,2
	db 246,4,10,246,5,18,246,6,242,254,7,250,254,8,2,254
	db 9,10,254,10,18,254,11,242,6,12,250,6,13,2,6,14
	db 10,6,15,244,237,0,252,237,1,4,237,2,244,245,3,252
	db 245,4,4,245,5,244,253,6,252,253,7,4,253,8,12,253
	db 9,244,5,10,252,5,11,4,5,12,12,5,13,252,13,14
	db 245,240,0,253,240,1,5,240,2,245,248,3,253,248,4,5
	db 248,5,245,0,6,253,0,7,5,0,8,245,8,9,253,8
	db 10,5,8,11,244,242,0,252,242,1,4,242,2,12,242,3
	db 244,250,4,252,250,5,4,250,6,12,250,7,244,2,8,252
	db 2,9,4,2,10,244,10,11,252,10,12,4,10,13,252,18
	db 14,242,244,0,250,244,1,2,244,2,10,244,3,242,252,4
	db 250,252,5,2,252,6,10,252,7,18,252,8,242,4,9,250
	db 4,10,2,4,11,10,4,12,242,12,13,250,12,14,240,245
	db 0,248,245,1,0,245,2,8,245,3,240,253,4,248,253,5
	db 0,253,6,8,253,7,240,5,8,248,5,9,0,5,10,8
	db 5,11,240,238,0,248,238,1,0,238,2,8,238,3,240,246
	db 4,248,246,5,0,246,6,8,246,7,240,254,8,248,254,9
	db 0,254,10,8,254,11,240,6,12,248,6,13,0,6,14,8
	db 6,15,240,14,16,248,14,17,0,14,17,8,14,18,240,239
	db 0,248,239,1,0,239,2,8,239,3,240,247,4,248,247,5
	db 0,247,6,8,247,7,240,255,8,248,255,9,0,255,9,8
	db 255,10,240,7,11,248,7,12,0,7,13,8,7,14,240,15
	db 15,248,15,16,0,15,16,8,15,17,240,23,18,248,23,19
	db 0,23,19,8,23,20,240,248,0,248,248,1,0,248,2,8
	db 248,3,240,0,4,248,0,5,0,0,6,8,0,7,240,8
	db 8,248,8,9,0,8,10,8,8,11,240,16,12,248,16,13
	db 0,16,13,8,16,14,240,24,15,248,24,16,0,24,16,8
	db 24,17,240,251,0,248,251,1,0,251,2,8,251,3,240,3
	db 4,248,3,5,0,3,6,8,3,7,240,11,8,248,11,9
	db 0,11,10,8,11,11,240,19,12,248,19,13,0,19,13,8
	db 19,14,240,27,15,248,27,16,0,27,17,8,27,18,240,35
	db 19,248,35,20,0,35,21,8,35,22,240,2,0,248,2,1
	db 0,2,2,8,2,3,240,10,4,248,10,5,0,10,6,8
	db 10,7,240,18,8,248,18,9,0,18,10,8,18,11,240,26
	db 12,248,26,13,0,26,14,8,26,15,240,34,16,248,34,17
	db 0,34,18,8,34,19,240,12,0,248,12,1,0,12,2,8
	db 12,3,240,20,4,248,20,5,0,20,6,8,20,7,240,28
	db 8,248,28,9,0,28,10,8,28,11,240,2,0,248,2,1
	db 0,2,2,8,2,3,240,10,4,248,10,5,0,10,6,8
	db 10,7,240,18,8,248,18,9,0,18,10,8,18,11,240,26
	db 12,248,26,13,0,26,14,8,26,15,240,34,16,248,34,17
	db 0,34,18,8,34,19,240,42,20,248,42,21,0,42,21,8
	db 42,22,240,251,0,248,251,1,0,251,2,8,251,3,240,3
	db 4,248,3,5,0,3,6,8,3,7,240,11,8,248,11,9
	db 0,11,9,8,11,10,240,19,11,248,19,12,0,19,13,8
	db 19,14,240,27,15,248,27,16,0,27,17,8,27,18,240,35
	db 19,248,35,20,0,35,21,8,35,22,240,248,0,248,248,1
	db 0,248,1,8,248,2,240,0,3,248,0,4,0,0,4,8
	db 0,5,240,8,6,248,8,7,0,8,8,8,8,9,240,16
	db 10,248,16,11,0,16,11,8,16,12,240,24,13,248,24,14
	db 0,24,15,8,24,16,240,239,0,248,239,1,0,239,1,8
	db 239,2,240,247,3,248,247,4,0,247,4,8,247,5,240,255
	db 6,248,255,7,0,255,8,8,255,9,240,7,10,248,7,11
	db 0,7,11,8,7,12,240,15,13,248,15,14,0,15,15,8
	db 15,16,240,23,17,248,23,18,0,23,19,8,23,20,240,237
	db 0,248,237,1,0,237,1,8,237,2,240,245,3,248,245,4
	db 0,245,5,8,245,6,240,253,7,248,253,8,0,253,9,8
	db 253,10,240,5,11,248,5,12,0,5,13,8,5,14,240,13
	db 15,248,13,16,0,13,17,8,13,18,240,21,19,8,21,20
	align 2
_gfx_roll_tiles:
	db 0,0,0,0,0,0,0,0,0,0,243,3,6,0,26,0
	db 64,5,80,21,80,21,80,21,80,21,95,213,170,170,153,169
	db 0,0,252,3,255,15,255,15,255,15,85,245,170,170,170,153
	db 0,0,0,0,0,192,0,240,0,252,192,255,0,144,0,164
	db 106,0,170,1,85,6,170,26,85,101,170,106,85,101,170,106
	db 153,169,170,170,85,85,170,170,255,85,213,170,215,85,255,170
	db 170,153,170,170,85,85,170,170,85,255,170,87,85,87,170,255
	db 0,169,64,170,144,85,164,170,89,85,169,170,89,85,169,170
	db 85,85,255,63,87,85,84,85,84,117,84,85,80,21,0,0
	db 85,85,255,255,255,255,0,60,0,0,0,0,0,0,0,0
	db 85,85,255,255,255,255,60,0,0,0,0,0,0,0,0,0
	db 85,85,252,255,85,213,85,21,93,21,85,21,84,5,0,0
	db 0,0,0,0,0,0,0,0,1,0,102,0,102,0,169,1
	db 0,0,192,3,12,0,95,1,170,102,170,154,170,150,106,105
	db 64,5,80,21,80,85,80,85,64,85,0,165,192,105,188,102
	db 0,0,0,0,0,0,0,0,0,0,0,63,192,255,240,255
	db 150,1,105,1,90,19,245,21,95,117,85,85,87,85,84,21
	db 150,150,105,105,90,90,167,165,93,90,173,245,125,253,215,63
	db 105,166,166,105,153,90,169,165,90,250,165,95,233,215,246,213
	db 252,127,252,151,252,165,127,170,159,170,160,170,144,106,164,150
	db 0,0,0,0,0,0,0,0,0,0,0,192,0,0,0,0
	db 80,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 253,63,63,0,15,0,0,0,0,0,0,0,0,0,0,0
	db 233,125,150,215,165,245,90,255,245,15,253,3,255,3,1,0
	db 100,105,152,150,164,165,89,90,169,165,105,105,164,214,100,125
	db 5,0,5,0,5,0,5,0,0,0,0,0,0,0,0,0
	db 208,87,192,85,64,85,64,93,0,85,0,16,0,0,0,0
	db 0,0,0,0,5,0,26,0,246,5,118,21,93,29,93,85
	db 0,0,0,84,148,169,105,166,154,102,154,89,102,153,102,166
	db 0,192,0,48,0,48,4,156,85,172,85,169,85,169,85,170
	db 0,0,0,0,0,0,0,64,0,64,0,80,0,64,0,64
	db 87,21,87,5,83,5,3,0,3,0,3,0,0,0,0,0
	db 153,102,153,89,102,217,110,246,191,246,215,253,117,61,125,15
	db 149,166,144,106,172,101,108,154,107,153,153,230,170,230,150,121
	db 0,0,0,0,0,0,0,12,192,63,192,127,240,127,192,159
	db 221,15,221,3,247,3,247,0,61,0,61,0,63,0,63,0
	db 106,121,106,94,154,246,154,153,102,153,102,102,153,102,153,217
	db 240,159,240,167,240,175,192,167,192,164,192,164,0,144,0,96
	db 3,0,3,0,5,0,21,0,21,0,21,0,5,0,5,0
	db 102,217,102,118,153,118,154,93,105,93,84,87,0,84,0,117
	db 0,144,0,144,0,64,0,128,0,64,0,0,0,0,0,0
	db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,80,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 74,21,109,93,125,85,125,85,125,85,125,85,125,21,189,0
	db 0,168,0,254,128,255,224,255,248,255,246,255,247,255,247,255
	db 0,0,0,0,0,0,0,32,0,32,0,32,0,128,0,224
	db 149,0,253,2,253,2,189,0,189,0,189,0,189,0,189,0
	db 85,85,247,255,247,255,247,255,247,255,247,95,247,95,247,223
	db 0,96,160,214,248,223,248,223,248,223,160,214,0,224,0,224
	db 189,0,189,0,189,0,189,0,189,0,253,2,253,2,149,0
	db 247,95,247,95,247,95,247,255,247,255,247,255,247,255,85,85
	db 0,224,0,224,128,218,224,223,224,223,224,223,224,223,128,85
	db 189,0,125,21,125,85,125,85,125,85,125,85,109,93,74,21
	db 247,255,247,255,246,255,248,255,224,255,128,255,0,254,0,168
	db 128,255,0,190,0,40,0,32,0,32,0,0,0,0,0,0
	db 1,0,5,0,5,0,21,0,21,0,21,0,5,0,2,0
	db 0,80,0,117,0,84,232,86,222,95,127,95,127,125,255,125
	db 0,0,0,0,0,0,0,0,0,128,0,192,0,128,0,224
	db 2,0,47,0,47,0,47,0,47,0,189,0,189,2,245,2
	db 255,247,255,87,255,215,127,221,215,127,245,127,253,255,247,95
	db 0,224,0,240,0,224,128,216,128,120,0,120,0,90,0,248
	db 0,0,0,0,0,0,2,0,2,0,2,0,82,5,87,5
	db 247,11,213,11,213,47,87,239,127,253,255,253,255,87,255,245
	db 247,127,223,127,223,255,125,255,126,253,248,253,248,247,208,247
	db 0,213,128,222,224,127,224,127,224,43,128,10,0,0,0,0
	db 87,21,95,85,95,29,125,21,173,5,39,0,10,0,0,0
	db 95,223,215,95,253,127,253,255,253,255,246,255,232,254,0,168
	db 218,223,126,223,127,125,254,85,254,245,104,239,224,46,0,40
	db 0,0,0,128,0,128,0,128,0,0,0,0,0,0,0,0
	db 0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,5,0,5,0,5,0,5,0,1,0,171,2
	db 0,16,0,85,64,93,64,85,128,85,160,87,216,127,120,253
	db 0,0,0,0,0,0,0,0,0,0,80,1,84,21,86,85
	db 0,0,0,0,0,0,10,0,43,0,191,42,253,63,213,191
	db 247,3,247,10,245,175,93,255,127,253,255,213,255,117,255,87
	db 254,215,254,95,254,255,248,255,252,127,248,95,216,223,96,245
	db 85,85,95,117,255,21,245,18,215,3,127,2,255,2,191,0
	db 93,223,253,213,255,87,255,253,255,253,127,255,93,255,215,255
	db 255,95,255,255,245,255,95,255,127,253,253,215,232,127,128,253
	db 240,245,234,93,160,253,0,245,64,213,128,127,224,127,192,175
	db 0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 187,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 87,255,247,185,173,2,61,0,175,2,10,0,0,0,0,0
	db 0,245,128,95,160,255,192,255,128,126,0,136,0,0,0,0
	db 160,47,0,2,0,0,0,0,0,0,0,0,0,0,0,0
	db 80,21,84,85,84,117,84,85,86,85,255,47,255,191,85,149
	db 0,0,0,0,0,0,0,40,170,190,255,127,255,127,85,85
	db 0,0,0,0,0,0,40,0,190,170,253,255,253,255,85,85
	db 84,5,85,21,93,21,85,21,85,149,248,255,254,255,86,85
	db 255,191,255,191,255,191,255,47,255,11,255,2,149,0,47,0
	db 213,127,213,127,255,127,255,127,255,127,255,127,85,85,255,127
	db 253,215,253,87,253,255,253,255,253,255,253,255,85,85,253,255
	db 254,255,254,255,254,255,248,255,224,255,128,255,0,86,0,248
	db 11,0,175,2,47,0,11,0,2,0,0,0,0,0,0,0
	db 255,127,90,85,224,127,224,127,224,191,128,42,0,0,0,0
	db 253,255,86,165,244,7,248,11,248,11,248,11,160,2,0,0
	db 0,224,128,138,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,0,21,0,93,0,85,0,149,0,181,2,255,9,95,11
	db 0,0,0,64,0,84,0,84,0,84,0,84,0,80,160,250
	db 245,47,253,47,255,47,255,11,255,15,253,11,253,9,87,2
	db 240,247,232,119,254,215,127,221,95,127,213,127,213,255,245,255
	db 0,0,0,0,0,128,0,232,0,250,170,255,255,95,255,213
	db 0,0,0,0,0,0,0,0,0,0,80,1,85,5,85,165
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64
	db 215,131,221,42,95,47,87,11,245,13,255,10,255,2,174,0
	db 253,255,255,127,255,215,127,253,95,255,245,95,255,138,159,128
	db 125,93,213,223,245,255,223,255,223,255,127,255,127,93,255,245
	db 85,213,87,253,213,127,225,215,240,245,96,255,224,255,128,255
	db 0,64,0,64,0,0,0,0,0,0,0,0,0,0,0,0
	db 42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 23,0,189,0,191,2,254,2,254,2,168,0,0,0,0,0
	db 127,245,219,119,160,106,0,72,160,0,0,0,0,0,0,0
	db 128,251,0,160,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,2,0,43,0,63,0,47,0,191,0
	db 84,0,213,5,85,1,85,185,85,127,85,223,213,215,216,247
	db 0,0,0,0,0,0,0,64,0,64,0,64,0,0,0,0
	db 191,0,255,0,191,0,127,34,221,34,213,46,87,191,253,181
	db 248,253,95,253,127,253,127,215,223,127,215,255,247,255,85,255
	db 0,0,0,128,0,128,0,128,0,128,0,224,0,232,0,248
	db 125,159,127,63,223,191,215,47,139,46,2,2,2,0,0,0
	db 213,255,215,127,245,127,253,223,255,215,255,247,255,253,255,125
	db 0,254,0,126,128,127,184,95,248,215,248,247,88,253,253,245
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,85,0,85
	db 9,0,43,0,63,0,191,0,47,0,34,0,0,0,0,0
	db 127,127,125,223,215,215,87,213,247,146,185,2,130,0,128,0
	db 125,95,95,127,223,255,247,255,247,255,253,255,250,187,160,2
	db 64,85,80,85,64,87,64,213,0,165,0,128,0,0,0,0
	db 32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,32,0,32,0,162,0,251,2,255,11
	db 170,0,253,2,253,11,253,47,253,191,253,127,253,127,253,127
	db 80,133,212,229,84,245,84,245,84,245,84,245,80,245,0,248
	db 85,9,223,47,223,47,223,47,223,47,159,10,47,0,47,0
	db 85,85,253,127,253,127,253,127,253,127,213,127,213,127,213,127
	db 0,88,0,254,0,254,0,248,0,248,0,248,0,248,0,248
	db 47,0,47,0,95,42,223,191,223,191,223,191,95,42,37,0
	db 221,127,213,127,213,127,253,127,253,127,253,127,253,127,85,85
	db 0,248,0,248,0,248,0,248,0,248,0,254,0,254,0,88
	db 47,0,11,0,34,0,32,0,32,0,0,0,0,0,0,0
	db 253,127,253,127,253,127,253,191,253,47,253,11,253,2,170,0
	db 0,248,80,245,84,245,84,245,84,245,84,245,212,229,80,133
	db 0,0,0,0,0,0,3,0,15,0,63,0,63,0,63,0
	db 48,0,192,3,193,255,102,255,170,253,170,246,169,214,169,218
	db 0,0,80,1,165,102,170,153,153,105,89,102,103,150,167,153
	db 0,0,0,0,0,0,0,64,0,245,64,213,64,87,80,85
	db 15,0,0,0,3,0,3,21,78,85,86,85,89,85,106,21
	db 166,106,150,101,153,154,107,166,111,106,189,153,181,105,213,166
	db 157,105,93,102,124,150,252,153,252,233,252,119,192,215,0,223
	db 64,85,0,85,0,85,0,0,0,0,0,0,0,0,0,0
	db 101,5,170,3,170,15,170,1,169,49,169,49,102,0,150,0
	db 223,150,87,155,253,105,109,102,103,150,151,153,159,105,127,102
	db 0,127,0,124,0,252,0,240,0,192,0,192,0,192,0,192
	db 105,0,105,0,22,0,42,0,22,0,1,0,0,0,0,0
	db 124,150,220,153,213,105,85,103,85,151,85,93,85,1,213,5
	db 0,0,0,0,0,0,0,64,0,64,0,64,0,0,0,0
	db 84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,16,0,85,1,85,0,85,1
	db 12,0,255,0,255,0,255,3,253,0,22,0,218,64,169,79
	db 0,252,240,255,0,255,80,221,166,106,169,170,165,170,90,170
	db 0,0,0,0,0,0,0,0,0,80,64,166,64,166,144,90
	db 85,0,85,0,22,0,234,3,170,61,170,194,170,1,165,6
	db 153,90,106,169,105,166,150,102,107,169,189,150,245,90,215,167
	db 165,165,90,90,105,105,150,182,105,221,151,94,95,95,255,245
	db 144,165,80,90,113,105,213,151,87,125,85,213,85,245,85,5
	db 0,0,0,0,0,0,0,0,0,64,0,64,0,64,0,0
	db 90,6,165,9,150,6,105,25,150,26,90,26,165,6,95,6
	db 223,90,181,165,151,150,127,105,252,151,240,95,240,255,0,80
	db 255,95,0,255,0,252,0,192,0,0,0,0,0,0,0,0
	db 80,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 245,1,213,0,85,0,93,0,21,0,1,0,0,0,0,0
	db 0,84,0,84,0,84,0,84,0,64,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,243,3,6,0,26,0
	db 64,5,80,21,80,21,80,21,80,21,95,213,170,170,153,169
	db 0,0,252,3,255,15,255,15,255,15,85,245,170,170,170,153
	db 0,0,0,0,0,192,0,240,0,252,192,255,0,144,0,164
	db 106,0,170,1,85,6,170,26,85,101,170,106,85,101,170,106
	db 153,169,170,170,85,85,170,170,255,85,213,170,215,85,255,170
	db 170,153,170,170,85,85,170,170,85,255,170,87,85,87,170,255
	db 0,169,64,170,144,85,164,170,89,85,169,170,89,85,169,170
	db 85,85,255,63,87,85,84,85,84,117,84,85,80,21,0,0
	db 85,85,255,255,255,255,0,60,0,0,0,0,0,0,0,0
	db 85,85,255,255,255,255,60,0,0,0,0,0,0,0,0,0
	db 85,85,252,255,85,213,85,21,93,21,85,21,84,5,0,0
	db 0,0,0,0,0,0,0,0,243,3,6,0,26,0,106,0
	db 64,5,80,21,80,21,80,21,95,213,170,170,153,169,153,169
	db 0,0,252,3,255,15,255,15,85,245,170,170,170,153,170,153
	db 0,0,0,0,0,192,0,252,192,255,0,144,0,164,0,169
	db 170,1,85,6,85,101,170,106,85,101,170,106,85,85,255,63
	db 170,170,85,85,255,85,213,170,215,85,255,170,85,85,255,255
	db 170,170,85,85,85,255,170,87,85,87,170,255,85,85,255,255
	db 64,170,144,85,89,85,169,170,89,85,169,170,85,85,252,255
	db 87,85,84,117,84,85,80,21,191,0,127,85,127,85,85,85
	db 255,255,0,0,0,0,0,0,255,95,255,95,255,255,85,85
	db 255,255,0,0,0,0,0,0,245,255,245,255,255,255,85,85
	db 85,213,93,21,85,21,84,5,0,254,85,253,85,253,85,85
	db 127,85,255,11,255,11,255,11,255,11,255,11,255,11,255,11
	db 255,255,255,255,255,255,255,247,255,247,255,247,85,245,255,255
	db 255,255,255,255,255,255,223,255,223,255,223,255,95,85,255,255
	db 85,253,224,255,224,255,224,255,224,255,224,255,224,255,224,255
	db 255,11,255,11,127,85,127,85,85,85,127,85,255,11,170,0
	db 255,255,255,255,255,255,255,255,85,85,255,255,255,255,170,170
	db 224,255,224,255,85,253,85,253,85,85,85,253,224,255,0,170
	db 0,0,0,0,0,0,6,0,106,0,85,6,85,101,85,101
	db 64,5,80,21,80,21,170,170,153,169,85,85,255,85,215,85
	db 0,0,255,15,255,15,170,170,170,153,85,85,85,255,85,87
	db 0,0,0,192,0,252,0,144,0,169,144,85,89,85,89,85
	db 85,85,87,85,84,117,80,21,170,0,191,0,255,11,127,85
	db 85,85,255,255,0,0,0,0,170,170,255,95,255,95,255,95
	db 85,85,255,255,0,0,0,0,170,170,245,255,245,255,245,255
	db 85,85,85,213,93,21,84,5,0,170,0,254,224,255,85,253
	db 127,85,85,85,85,85,127,85,127,85,127,85,255,11,255,11
	db 255,255,85,85,85,85,255,255,255,255,255,255,255,255,255,255
	db 85,253,85,85,85,85,85,253,85,253,85,253,224,255,224,255
	db 255,11,255,11,255,11,255,11,255,11,255,11,255,11,255,11
	db 85,245,255,247,255,247,255,247,255,247,255,247,85,245,255,255
	db 95,85,223,255,223,255,223,255,223,255,223,255,95,85,255,255
	db 224,255,224,255,224,255,224,255,224,255,224,255,224,255,224,255
	db 255,11,255,11,255,11,255,11,255,11,127,85,127,85,127,85
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 224,255,224,255,224,255,224,255,224,255,85,253,85,253,85,253
	db 85,85,85,85,127,85,127,85,255,11,191,0,170,0,0,0
	db 85,85,85,85,255,255,255,255,255,255,255,255,170,170,0,0
	db 85,85,85,85,85,253,85,253,224,255,0,254,0,170,0,0
	db 170,0,191,0,255,11,127,85,127,85,127,85,85,85,85,85
	db 170,170,255,95,255,95,255,95,255,255,255,255,85,85,85,85
	db 170,170,245,255,245,255,245,255,255,255,255,255,85,85,85,85
	db 0,170,0,254,224,255,85,253,85,253,85,253,85,85,85,85
	db 127,85,127,85,127,85,255,11,255,11,255,11,255,11,255,11
	db 255,255,255,255,255,255,255,255,255,255,255,255,85,245,255,247
	db 255,255,255,255,255,255,255,255,255,255,255,255,95,85,223,255
	db 85,253,85,253,85,253,224,255,224,255,224,255,224,255,224,255
	db 255,11,255,11,255,11,255,11,255,11,255,11,255,11,255,11
	db 255,247,255,247,255,247,255,247,255,247,85,245,255,255,255,255
	db 223,255,223,255,223,255,223,255,223,255,95,85,255,255,255,255
	db 224,255,224,255,224,255,224,255,224,255,224,255,224,255,224,255
	db 255,11,255,11,255,11,255,11,255,11,127,85,127,85,127,85
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 224,255,224,255,224,255,224,255,224,255,85,253,85,253,85,253
	db 85,85,85,85,127,85,127,85,127,85,255,11,191,0,170,0
	db 85,85,85,85,255,255,255,255,255,255,255,255,255,255,170,170
	db 85,85,85,85,85,253,85,253,85,253,224,255,0,254,0,170
	db 170,0,191,0,255,11,127,85,127,85,85,85,85,85,127,85
	db 170,170,255,95,255,95,255,95,255,255,85,85,85,85,255,255
	db 170,170,245,255,245,255,245,255,255,255,85,85,85,85,255,255
	db 0,170,0,254,224,255,85,253,85,253,85,85,85,85,85,253
	db 127,85,127,85,255,11,255,11,255,11,255,11,255,11,255,11
	db 255,255,255,255,255,255,255,255,85,245,255,247,255,247,255,247
	db 255,255,255,255,255,255,255,255,95,85,223,255,223,255,223,255
	db 85,253,85,253,224,255,224,255,224,255,224,255,224,255,224,255
	db 255,11,255,11,255,11,255,11,255,11,255,11,255,11,255,11
	db 255,247,255,247,85,245,255,255,255,255,255,255,255,255,255,255
	db 223,255,223,255,95,85,255,255,255,255,255,255,255,255,255,255
	db 224,255,224,255,224,255,224,255,224,255,224,255,224,255,224,255
	db 255,11,127,85,127,85,127,85,85,85,85,85,127,85,127,85
	db 255,255,255,255,255,255,255,255,85,85,85,85,255,255,255,255
	db 224,255,85,253,85,253,85,253,85,85,85,85,85,253,85,253
	db 255,11,191,0,170,0,84,85,255,63,170,106,170,106,170,26
	db 255,255,255,255,170,170,0,60,255,255,255,170,213,170,170,170
	db 255,255,255,255,170,170,60,0,255,255,170,255,170,87,170,170
	db 224,255,0,254,0,170,85,21,252,255,169,170,169,170,164,170
	db 170,1,26,0,243,3,0,0,0,0,0,0,0,0,0,0
	db 170,170,153,169,95,213,80,21,80,21,0,0,0,0,0,0
	db 170,170,170,153,85,245,255,15,252,3,0,0,0,0,0,0
	db 64,170,0,164,192,255,0,240,0,0,0,0,0,0,0,0
	db 191,0,127,85,127,85,85,85,127,85,255,11,255,11,255,11
	db 255,95,255,95,255,255,85,85,255,255,255,255,255,255,255,247
	db 245,255,245,255,255,255,85,85,255,255,255,255,255,255,223,255
	db 0,254,85,253,85,253,85,85,85,253,224,255,224,255,224,255
	db 255,11,255,11,255,11,255,11,255,11,255,11,127,85,127,85
	db 255,247,255,247,85,245,255,255,255,255,255,255,255,255,255,255
	db 223,255,223,255,95,85,255,255,255,255,255,255,255,255,255,255
	db 224,255,224,255,224,255,224,255,224,255,224,255,85,253,85,253
	db 85,85,127,85,255,11,170,0,80,21,84,85,84,117,84,85
	db 85,85,255,255,255,255,170,170,0,0,0,0,0,0,0,60
	db 85,85,255,255,255,255,170,170,0,0,0,0,0,0,60,0
	db 85,85,85,253,224,255,0,170,84,5,85,21,93,21,85,21
	db 255,63,85,85,170,106,85,101,170,106,85,101,170,26,170,1
	db 255,255,85,85,255,170,215,85,213,170,255,85,170,170,170,170
	db 255,255,85,85,170,255,85,87,170,87,85,255,170,170,170,170
	db 252,255,85,85,169,170,89,85,169,170,89,85,164,170,64,170
	db 106,0,26,0,6,0,243,3,0,0,0,0,0,0,0,0
	db 153,169,153,169,170,170,95,213,80,21,80,21,80,21,64,5
	db 170,153,170,153,170,170,85,245,255,15,255,15,252,3,0,0
	db 0,169,0,164,0,144,192,255,0,252,0,240,0,0,0,0
	db 80,21,84,85,84,117,84,85,87,85,255,63,85,85,170,106
	db 0,0,0,0,0,0,0,60,255,255,255,255,85,85,255,170
	db 0,0,0,0,0,0,60,0,255,255,255,255,85,85,170,255
	db 84,5,85,21,93,21,85,21,85,213,252,255,85,85,169,170
	db 85,101,170,106,85,101,170,26,85,6,170,1,106,0,26,0
	db 215,85,213,170,255,85,170,170,85,85,170,170,153,169,153,169
	db 85,87,170,87,85,255,170,170,85,85,170,170,170,153,170,153
	db 89,85,169,170,89,85,164,170,144,85,64,170,0,169,0,164
	db 6,0,243,3,0,0,0,0,0,0,0,0,0,0,0,0
	db 170,170,95,213,80,21,80,21,80,21,80,21,64,5,0,0
	db 170,170,85,245,255,15,255,15,255,15,252,3,0,0,0,0
	db 0,144,192,255,0,252,0,240,0,192,0,0,0,0,0,0
	db 80,21,84,85,84,117,84,85,255,63,85,85,170,106,85,101
	db 0,0,0,0,0,0,0,60,255,255,85,85,255,170,215,85
	db 0,0,0,0,0,0,60,0,255,255,85,85,170,255,85,87
	db 84,5,85,21,93,21,85,21,252,255,85,85,169,170,89,85
	db 170,106,85,101,170,26,170,1,106,0,26,0,6,0,243,3
	db 213,170,255,85,170,170,170,170,153,169,153,169,170,170,95,213
	db 170,87,85,255,170,170,170,170,170,153,170,153,170,170,85,245
	db 169,170,89,85,164,170,64,170,0,169,0,164,0,144,192,255
	db 0,0,0,0,0,0,0,0,0,0,42,0,170,6,170,86
	db 80,21,80,21,80,21,64,5,0,0,170,170,170,170,170,170
	db 255,15,255,15,252,3,0,0,0,0,170,170,170,170,170,170
	db 0,252,0,240,0,0,0,0,0,0,0,168,144,170,149,170
	db 170,86,170,86,170,86,191,6,191,6,154,6,153,6,153,6
	db 170,170,170,170,170,170,255,255,255,255,170,170,106,85,106,85
	db 170,170,170,170,170,170,255,255,255,255,170,170,255,171,255,171
	db 149,170,149,170,149,170,144,254,144,254,144,166,144,246,144,246
	db 154,6,154,6,170,6,170,86,170,86,170,86,170,6,255,6
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,250
	db 255,171,170,170,170,170,170,170,170,170,170,170,170,170,175,170
	db 144,246,144,166,144,170,149,170,149,170,149,170,144,170,144,255
	db 21,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 85,85,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 84,85,84,85,255,63,170,106,170,106,170,26,170,1,26,0
	db 0,0,0,60,255,255,255,170,213,170,170,170,170,170,153,169
	db 0,0,60,0,255,255,170,255,170,87,170,170,170,170,170,153
	db 85,21,85,21,252,255,169,170,169,170,164,170,64,170,0,164
	db 243,3,0,0,0,0,0,0,21,0,42,0,42,0,170,6
	db 95,213,80,21,80,21,0,0,85,85,170,170,170,170,170,170
	db 85,245,255,15,252,3,0,0,85,85,170,170,170,170,170,170
	db 192,255,0,240,0,0,0,0,0,84,0,168,0,168,144,170
	db 170,86,170,86,170,86,170,86,170,86,170,86,170,86,191,6
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,255,255
	db 149,170,149,170,149,170,149,170,149,170,149,170,149,170,144,254
	db 191,6,191,6,149,6,154,6,153,6,153,6,153,6,153,6
	db 255,255,255,255,85,85,170,170,106,85,106,85,106,85,106,85
	db 255,255,255,255,85,85,170,170,255,171,255,171,255,171,255,171
	db 144,254,144,254,144,86,144,166,144,246,144,246,144,246,144,246
	db 154,6,154,6,154,6,149,6,170,6,170,86,170,86,170,86
	db 170,170,170,170,170,170,85,85,170,170,170,170,170,170,170,170
	db 255,171,170,170,170,170,85,85,170,170,170,170,170,170,170,170
	db 144,246,144,166,144,166,144,86,144,170,149,170,149,170,149,170
	db 170,86,170,86,170,86,170,6,255,6,63,0,21,0,0,0
	db 170,170,170,170,170,170,170,170,170,250,170,250,85,85,0,0
	db 170,170,170,170,170,170,170,170,175,170,175,170,85,85,0,0
	db 149,170,149,170,149,170,144,170,144,255,0,252,0,84,0,0
	db 21,0,42,0,42,0,170,6,170,6,170,86,170,86,170,86
	db 85,85,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 0,84,0,168,0,168,144,170,144,170,149,170,149,170,149,170
	db 170,86,170,86,170,86,170,86,170,6,191,6,191,6,191,6
	db 170,170,170,170,170,170,170,170,170,170,255,255,255,255,255,255
	db 149,170,149,170,149,170,149,170,144,170,144,254,144,254,144,254
	db 149,6,154,6,153,6,153,6,153,6,153,6,153,6,154,6
	db 85,85,170,170,106,85,106,85,106,85,106,85,106,85,170,170
	db 85,85,170,170,255,171,255,171,255,171,255,171,255,171,255,171
	db 144,86,144,166,144,246,144,246,144,246,144,246,144,246,144,246
	db 154,6,154,6,149,6,170,6,170,86,170,86,170,86,170,86
	db 170,170,170,170,85,85,170,170,170,170,170,170,170,170,170,170
	db 144,166,144,166,144,86,144,170,149,170,149,170,149,170,149,170
	db 170,86,170,86,170,86,170,6,170,6,255,6,63,0,21,0
	db 170,170,170,170,170,170,170,170,170,170,170,250,170,250,85,85
	db 170,170,170,170,170,170,170,170,170,170,175,170,175,170,85,85
	db 149,170,149,170,149,170,144,170,144,170,144,255,0,252,0,84
	db 21,0,42,0,42,0,170,6,170,86,170,86,170,86,170,86
	db 85,85,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 0,84,0,168,0,168,144,170,149,170,149,170,149,170,149,170
	db 170,86,170,86,170,86,191,6,191,6,191,6,149,6,154,6
	db 170,170,170,170,170,170,255,255,255,255,255,255,85,85,170,170
	db 149,170,149,170,149,170,144,254,144,254,144,254,144,86,144,166
	db 153,6,153,6,153,6,153,6,154,6,154,6,154,6,149,6
	db 106,85,106,85,106,85,106,85,170,170,170,170,170,170,85,85
	db 255,171,255,171,255,171,255,171,255,171,170,170,170,170,85,85
	db 144,246,144,246,144,246,144,246,144,246,144,166,144,166,144,86
	db 170,6,170,86,170,86,170,86,170,86,170,86,170,86,170,6
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 144,170,149,170,149,170,149,170,149,170,149,170,149,170,144,170
	db 255,6,63,0,21,0,0,0,0,0,6,0,106,0,85,6
	db 170,250,170,250,85,85,80,21,80,21,170,170,153,169,85,85
	db 175,170,175,170,85,85,255,15,255,15,170,170,170,153,85,85
	db 144,255,0,252,0,84,0,192,0,252,0,144,0,169,144,85
	db 85,101,85,101,85,85,87,85,84,117,80,21,0,0,0,0
	db 255,85,215,85,85,85,255,255,0,0,0,0,0,0,0,0
	db 85,255,85,87,85,85,255,255,0,0,0,0,0,0,0,0
	db 89,85,89,85,85,85,85,213,93,21,84,5,0,0,0,0
	db 42,0,170,6,170,86,170,86,170,86,170,86,191,6,191,6
	db 170,170,170,170,170,170,170,170,170,170,170,170,255,255,255,255
	db 0,168,144,170,149,170,149,170,149,170,149,170,144,254,144,254
	db 154,6,153,6,153,6,154,6,154,6,170,6,170,86,170,86
	db 170,170,106,85,106,85,170,170,170,170,170,170,170,170,170,170
	db 170,170,255,171,255,171,255,171,170,170,170,170,170,170,170,170
	db 144,166,144,246,144,246,144,246,144,166,144,170,149,170,149,170
	db 170,86,170,6,255,6,21,0,0,0,0,0,0,0,0,0
	db 170,170,170,170,170,250,85,85,0,0,64,5,80,21,80,21
	db 170,170,170,170,175,170,85,85,0,0,0,0,252,3,255,15
	db 149,170,144,170,144,255,0,84,0,0,0,0,0,0,0,192
	db 0,0,243,3,6,0,26,0,106,0,170,1,85,6,85,101
	db 80,21,95,213,170,170,153,169,153,169,170,170,85,85,255,85
	db 255,15,85,245,170,170,170,153,170,153,170,170,85,85,85,255
	db 0,252,192,255,0,144,0,164,0,169,64,170,144,85,89,85
	db 170,106,85,101,170,106,85,85,255,63,87,85,84,117,84,85
	db 213,170,215,85,255,170,85,85,255,255,255,255,0,0,0,0
	db 170,87,85,87,170,255,85,85,255,255,255,255,0,0,0,0
	db 169,170,89,85,169,170,85,85,252,255,85,213,93,21,85,21
	db 80,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 84,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	align 2
_gfx_roll_pal:
	db 0,0,4,0,46,1,221,14,0,0,17,1,46,1,133,11
	align 2
_gfx_map_tiles:
	db 85,213,85,85,85,87,85,85,93,85,85,85,85,85,85,85
	db 85,85,117,85,85,85,85,85,85,85,85,117,85,117,85,85
	db 87,87,85,85,85,85,85,213,85,85,85,87,85,85,93,85
	db 85,85,85,85,85,93,85,85,117,85,213,85,85,85,85,85
	db 93,85,213,85,85,85,87,85,85,85,85,85,85,213,85,85
	db 89,85,86,85,90,85,107,85,175,85,191,90,252,90,240,91
	db 80,85,96,85,160,101,176,86,240,90,240,107,192,175,0,191
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 85,85,85,93,85,85,117,85,85,85,85,85,85,85,85,85
	db 213,85,85,85,87,85,85,85,85,85,85,213,85,85,85,215
	db 85,85,85,85,85,93,85,85,85,93,85,85,117,85,85,85
	db 85,85,85,117,85,85,213,85,85,85,87,85,85,85,85,87
	db 85,87,85,85,125,85,85,85,85,85,85,85,85,86,85,90
	db 192,95,0,95,0,92,0,92,0,96,0,80,0,96,0,160
	db 0,252,0,240,0,192,0,192,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,16
	db 85,117,85,85,213,85,85,85,87,85,85,85,85,85,85,213
	db 85,85,93,85,85,85,85,85,85,85,85,85,85,93,85,85
	db 85,85,85,85,85,85,85,117,85,117,213,85,85,85,87,85
	db 85,149,85,85,86,86,90,85,90,85,91,85,95,85,95,85
	db 86,107,106,175,107,191,175,252,175,240,191,240,252,192,240,0
	db 0,176,0,240,0,240,0,192,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,1,0,42,0,170,0,170,2,170,0
	db 0,0,0,0,0,0,0,4,0,170,128,170,160,170,128,170
	db 2,0,10,0,42,0,10,0,2,0,0,0,0,0,0,0
	db 160,170,168,170,170,170,168,170,160,170,0,0,0,0,0,0
	db 85,85,87,87,85,85,93,85,85,85,85,85,85,85,85,85
	db 117,85,85,85,85,85,85,85,85,85,85,117,85,85,213,85
	db 85,85,85,85,85,149,86,85,90,86,107,85,107,149,175,85
	db 92,85,80,89,80,85,96,85,160,85,176,86,176,86,240,90
	db 192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,170,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,63,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255
	db 85,93,85,85,117,85,93,85,85,85,85,85,85,85,85,117
	db 85,85,87,85,85,85,85,85,85,213,85,85,85,87,85,85
	db 191,86,252,90,240,91,192,95,0,95,0,92,0,80,0,80
	db 240,107,192,175,0,191,0,252,0,240,0,192,0,0,0,0
	db 0,0,0,0,0,0,85,0,85,0,85,1,95,5,85,21
	db 0,0,0,0,0,0,85,85,85,85,85,85,95,95,85,85
	db 0,0,0,0,0,0,85,85,85,85,85,85,85,95,85,85
	db 58,0,58,0,58,0,122,85,122,85,122,85,122,85,122,85
	db 171,170,171,170,171,191,235,234,235,234,235,255,235,234,235,234
	db 85,85,213,85,85,85,87,85,85,85,118,85,90,213,91,85
	db 90,85,85,86,85,90,86,107,90,175,107,191,175,252,191,240
	db 0,80,0,96,0,160,0,176,0,240,0,240,0,192,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,85,85
	db 1,0,5,0,21,0,85,0,85,1,85,5,85,85,85,85
	db 85,85,85,85,80,85,0,85,0,84,0,80,0,64,0,0
	db 85,85,85,85,0,0,0,0,0,0,0,0,0,0,0,0
	db 122,85,122,85,58,0,63,0,0,0,0,0,0,0,0,0
	db 235,234,171,170,171,170,255,255,0,0,0,0,0,0,0,0
	db 95,86,95,85,92,85,92,85,80,85,80,85,96,85,160,89
	db 252,192,240,0,192,0,192,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,1,0,5,0
	db 5,0,21,0,85,0,85,1,85,21,85,85,85,85,80,85
	db 85,85,85,85,245,245,85,85,85,85,85,85,0,0,0,0
	db 84,85,64,85,64,85,80,85,85,85,85,85,85,21,85,1
	db 0,0,0,0,0,0,0,0,0,0,0,64,0,80,0,84
	db 176,86,240,90,240,107,192,175,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,1,0,5,0,21,0
	db 21,0,85,0,85,5,85,85,85,85,84,85,84,85,85,85
	db 64,85,0,85,0,84,0,80,0,64,0,0,0,0,0,0
	db 85,0,21,0,5,0,1,0,0,0,0,0,0,0,0,0
	db 0,85,64,85,84,85,85,85,85,85,85,5,95,5,85,21
	db 171,170,171,170,171,255,235,234,171,255,235,234,235,234,235,234
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,85,5
	db 0,0,0,0,0,0,0,0,1,0,5,0,85,0,85,85
	db 85,1,85,5,85,21,85,85,84,85,80,85,64,85,0,85
	db 85,85,85,85,0,80,0,0,0,0,0,0,0,0,0,0
	db 85,85,85,85,85,1,21,0,5,0,1,0,0,0,0,0
	db 0,80,0,84,0,85,64,85,80,85,84,85,85,85,85,21
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,64,85,85
	db 171,255,171,170,171,170,255,255,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,1,0,21,0,85,0,85,1,85,5
	db 85,5,85,21,245,85,85,85,85,85,85,85,0,85,0,80
	db 85,85,85,85,85,245,85,85,85,85,85,85,21,0,1,0
	db 0,84,0,64,0,64,0,80,0,85,64,85,80,85,84,85
	db 85,5,85,0,85,0,85,1,85,21,85,85,85,85,80,85
	db 0,0,0,0,0,0,85,85,85,85,85,85,247,245,85,85
	db 0,0,0,0,5,0,85,85,85,85,85,85,85,95,85,85
	db 85,21,85,85,84,85,80,85,64,85,0,84,0,84,0,85
	db 0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 85,85,85,21,85,5,85,1,85,0,5,0,5,0,21,0
	db 0,0,0,64,0,84,85,85,85,85,85,85,95,95,85,85
	db 171,170,171,170,235,191,171,234,171,234,171,234,171,234,171,234
	db 85,85,85,85,1,0,0,0,0,0,0,0,0,0,0,0
	db 80,85,84,85,85,85,85,21,85,5,85,1,85,0,21,0
	db 0,0,0,0,0,0,0,64,0,80,0,84,64,85,85,85
	db 235,191,171,170,171,170,255,255,0,0,0,0,0,0,0,0
	db 5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 85,85,85,85,245,21,85,5,85,5,85,5,0,0,0,0
	db 85,85,85,21,85,5,85,1,85,0,5,0,1,0,0,0
	db 171,170,171,170,171,255,235,234,235,234,235,234,235,234,235,234
	db 85,5,85,0,21,0,5,0,5,0,5,0,0,0,0,0
	db 0,85,64,85,84,85,85,85,85,85,85,5,95,1,85,0
	db 171,170,171,170,235,255,171,234,171,255,171,234,171,234,171,234
	db 0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0
	db 0,0,4,1,170,42,170,170,170,170,170,170,170,42,0,0
	db 0,0,0,0,0,0,0,128,0,160,0,128,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4
	db 85,0,85,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 122,85,122,85,186,2,191,10,170,42,170,10,170,2,0,0
	db 235,255,171,170,171,170,255,255,0,85,0,84,0,80,0,0
	db 42,0,170,0,170,2,170,0,42,0,0,0,0,0,0,0
	db 0,170,128,170,160,170,128,170,0,170,0,0,0,0,0,0
	db 85,85,190,106,170,106,171,106,175,106,175,106,175,106,191,106
	db 85,85,169,190,169,255,233,255,233,255,233,255,249,255,249,255
	db 191,106,86,106,85,85,255,127,255,127,255,127,255,127,85,85
	db 249,255,153,170,85,153,253,255,253,255,253,255,253,255,85,85
	db 85,85,170,106,170,122,170,106,170,106,175,105,111,89,175,85
	db 85,85,189,170,173,250,169,170,169,170,173,217,109,217,173,149
	db 106,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 105,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,170,110,170,127,254,127,255,107,239,107,238,107,170,106
	db 85,85,169,174,169,191,253,255,253,235,237,235,237,171,169,170
	db 170,106,105,90,85,85,170,106,170,106,170,106,170,106,85,85
	db 169,170,153,166,85,85,169,170,169,170,169,170,169,170,85,85
	db 85,85,170,106,170,106,170,106,170,106,255,127,255,126,251,110
	db 85,85,169,170,169,170,169,170,169,170,253,255,173,255,173,255
	db 230,90,102,90,86,90,170,106,170,106,170,106,170,106,85,85
	db 169,191,169,105,169,85,169,170,169,170,169,170,169,170,85,85
	db 85,85,170,106,170,106,255,127,255,127,127,125,95,117,95,117
	db 85,85,169,170,169,170,253,255,253,255,253,255,253,255,253,213
	db 95,117,95,117,85,85,255,127,255,127,255,127,255,127,85,85
	db 213,213,85,85,85,85,253,255,253,255,253,255,253,255,85,85
	db 85,85,255,127,255,127,255,127,255,127,255,127,255,127,191,90
	db 85,85,253,255,253,255,253,255,253,255,253,255,253,255,253,255
	db 165,85,170,106,170,106,170,106,170,106,170,106,170,106,85,85
	db 253,111,169,170,169,170,169,170,169,170,169,170,169,170,85,85
	db 85,85,255,127,255,127,255,127,255,127,255,127,254,127,105,106
	db 85,85,253,255,253,255,253,255,253,234,173,170,173,106,169,170
	db 150,105,85,85,85,85,170,106,170,106,170,106,170,106,85,85
	db 165,170,85,154,85,154,169,170,169,170,169,170,169,170,85,85
	db 85,85,175,110,254,126,255,126,175,126,175,126,190,126,190,126
	db 85,85,233,170,237,175,233,175,233,175,233,175,233,171,233,171
	db 191,126,174,109,85,85,255,127,255,127,255,127,255,127,85,85
	db 233,175,169,106,85,85,253,255,253,255,253,255,253,255,85,85
	db 85,85,170,106,170,106,255,127,255,127,255,127,255,127,250,127
	db 85,85,169,170,169,170,249,255,249,255,169,255,189,254,253,250
	db 251,127,153,89,85,85,255,127,255,127,255,127,255,127,85,85
	db 253,250,153,153,85,85,253,255,253,255,253,255,253,255,85,85
	db 85,85,255,127,255,127,255,127,255,127,255,127,255,127,111,107
	db 85,85,253,255,253,255,253,255,253,255,253,255,253,255,109,235
	db 174,106,170,106,170,106,170,106,170,106,170,106,170,106,85,85
	db 173,170,169,170,169,170,169,170,169,170,169,170,169,170,85,85
	db 85,85,255,127,255,127,255,127,255,127,255,127,255,127,255,127
	db 85,85,253,255,253,255,253,255,253,255,253,255,253,255,253,255
	db 255,111,85,85,85,85,170,106,170,106,170,106,170,106,85,85
	db 253,255,85,85,85,85,169,170,169,170,169,170,169,170,85,85
	db 85,85,255,127,255,127,255,111,254,111,181,110,181,106,165,106
	db 85,85,253,255,253,255,253,239,253,239,181,174,181,106,165,106
	db 165,106,170,106,149,106,170,106,170,106,170,106,170,106,85,85
	db 165,106,169,170,149,106,169,170,169,170,169,170,169,170,85,85
	db 85,85,255,127,255,127,255,127,255,127,255,127,223,127,87,86
	db 85,85,253,255,253,255,253,255,253,255,253,255,253,255,245,255
	db 86,86,85,90,85,85,170,106,170,106,170,106,170,106,85,85
	db 149,191,89,89,85,85,169,170,169,170,169,170,169,170,85,85
	db 85,85,170,106,255,127,255,127,255,127,255,127,255,117,215,93
	db 85,85,189,170,253,255,253,255,253,255,253,255,253,255,253,223
	db 85,85,85,85,170,106,255,127,255,127,255,127,255,127,85,85
	db 253,95,221,85,169,170,253,255,253,255,253,255,253,255,85,85
	db 85,85,255,111,255,127,255,127,255,127,191,127,191,107,175,86
	db 85,85,253,234,253,255,253,255,253,255,253,255,165,250,165,246
	db 171,86,170,86,85,85,170,106,170,106,170,106,170,106,85,85
	db 165,214,169,86,85,85,169,170,169,170,169,170,169,170,85,85
	db 0,5,170,42,250,171,250,171,250,171,250,171,170,42,0,5
	db 0,20,160,170,168,175,170,175,170,175,168,175,160,170,0,20
	align 2
_gfx_map_map:
	db 0,0,1,0,2,0,3,0,4,0,5,0,6,0,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,8,0,9,0,10,0,11,0
	db 12,0,13,0,14,0,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,15,0,255,255,255,255,255,255
	db 16,0,17,0,18,0,19,0,20,0,21,0,255,255,255,255
	db 255,255,255,255,255,255,22,0,23,0,255,255,255,255,24,0
	db 25,0,255,255,255,255,255,255,26,0,27,0,28,0,29,0
	db 30,0,255,255,255,255,255,255,255,255,255,255,255,255,31,0
	db 32,0,255,255,255,255,255,255,255,255,255,255,33,0,34,0
	db 35,0,36,0,37,0,38,0,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,39,0
	db 40,0,41,0,42,0,43,0,44,0,45,0,46,0,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,47,0
	db 48,0,48,0,49,0,50,0,51,0,51,0,52,0,53,0
	db 54,0,55,0,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,56,0,57,0,58,0,58,0,59,0,60,0
	db 255,255,255,255,33,0,34,0,61,0,255,255,255,255,255,255
	db 255,255,255,255,255,255,62,0,40,0,40,0,63,0,64,0
	db 255,255,255,255,65,0,66,0,40,0,41,0,42,0,67,0
	db 255,255,255,255,255,255,255,255,68,0,48,0,69,0,70,0
	db 71,0,51,0,72,0,73,0,74,0,48,0,49,0,50,0
	db 51,0,51,0,52,0,75,0,255,255,255,255,255,255,76,0
	db 77,0,58,0,78,0,79,0,255,255,255,255,56,0,80,0
	db 58,0,58,0,59,0,60,0,255,255,255,255,33,0,34,0
	db 81,0,40,0,82,0,83,0,84,0,255,255,255,255,85,0
	db 86,0,40,0,63,0,64,0,255,255,255,255,65,0,66,0
	db 40,0,41,0,42,0,87,0,51,0,51,0,88,0,89,0
	db 90,0,48,0,69,0,70,0,71,0,51,0,72,0,73,0
	db 74,0,48,0,49,0,50,0,51,0,51,0,52,0,91,0
	db 255,255,255,255,255,255,92,0,93,0,58,0,78,0,79,0
	db 255,255,255,255,56,0,80,0,58,0,58,0,59,0,60,0
	db 255,255,255,255,33,0,34,0,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,94,0,86,0,40,0,63,0,64,0
	db 255,255,255,255,65,0,66,0,40,0,41,0,42,0,95,0
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 51,0,51,0,72,0,73,0,74,0,48,0,49,0,50,0
	db 51,0,51,0,52,0,75,0,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,96,0
	db 58,0,58,0,59,0,60,0,255,255,255,255,33,0,34,0
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,65,0,97,0
	db 40,0,41,0,42,0,98,0,255,255,99,0,100,0,101,0
	db 255,255,255,255,255,255,102,0,103,0,255,255,255,255,255,255
	db 255,255,102,0,103,0,104,0,51,0,51,0,105,0,106,0
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,107,0
	db 108,0,255,255,255,255,255,255,255,255,107,0,108,0,255,255
	db 255,255,255,255,255,255,255,255
_gfx_map_pal:
	db 1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0
	db 0,0,0,0,2,0,0,0,1,1,1,0,0,0,0,0
	db 0,0,0,2,2,0,0,2,2,0,0,0,1,1,0,0
	db 0,0,0,0,0,0,0,2,2,0,0,0,0,0,0,0
	db 1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,3
	db 3,3,3,3,1,0,0,0,0,0,0,0,0,0,0,3
	db 3,3,3,3,3,3,3,3,0,0,0,0,0,0,0,0
	db 0,0,3,3,3,3,3,3,0,0,0,0,0,0,0,0
	db 0,0,0,3,3,3,3,3,0,0,3,3,3,3,3,3
	db 0,0,0,0,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,0,0,0,3,3,3,3,3,0,0,3,3
	db 3,3,3,3,0,0,0,0,3,3,3,3,3,0,0,3
	db 3,3,3,3,0,0,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 0,0,0,3,3,3,3,3,0,0,3,3,3,3,3,3
	db 0,0,0,0,0,0,0,0,0,0,0,3,3,3,3,3
	db 0,0,3,3,3,3,3,3,0,0,0,0,0,0,0,0
	db 3,3,3,3,3,3,3,3,3,3,3,3,0,0,0,0
	db 0,0,0,0,0,0,0,3,3,3,3,3,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3
	db 3,3,3,3,0,2,2,2,0,0,0,2,2,0,0,0
	db 0,2,2,3,3,3,4,5,0,0,0,0,0,0,0,2
	db 2,0,0,0,0,2,2,0,0,0,0,0
	align 2
_gfx_map_pals:
	db 174,6,98,12,200,15,255,15,174,6,98,12,200,15,235,15
	db 174,6,166,3,173,5,0,0,174,6,36,4,62,7,255,15
	db 174,6,36,4,173,5,255,15,174,6,173,5,62,7,255,15
	db 174,6,0,0,0,0,0,0,174,6,0,0,0,0,0,0
	align 2
_gfx_map_thumb_pals:
	db 0,0,146,7,198,15,255,15,0,0,162,6,147,15,220,15
	db 0,0,97,3,133,13,255,15,0,0,36,6,138,7,239,9
	db 0,0,173,7,185,13,223,10,0,0,149,4,204,6,223,13
	db 0,0,93,1,190,6,189,14,0,0,81,3,86,7,141,6
	db 0,0,67,4,168,9,254,15,0,0,41,2,189,3,239,12
	db 0,0,82,3,166,5,220,13,0,0,69,5,154,9,223,10
	db 0,0,69,9,202,8,205,14,0,0,166,4,130,12,235,15
	db 0,0,98,2,153,7,236,12
	align 2
_gfx_map_car_pal:
	db 0,0,17,1,46,1,235,15
	align 2
_pano_beach_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,89,89,149,149,102,102,170,170,170,170,170,170,170,170
	db 87,85,125,89,255,149,102,102,170,170,170,170,170,170,170,170
	db 119,119,253,253,255,255,102,102,170,170,170,170,170,170,170,170
	db 85,117,89,253,213,255,102,102,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,87,85
	db 85,85,85,85,85,85,245,87,255,127,255,255,255,255,255,255
	db 85,85,85,85,85,85,85,85,85,85,85,213,85,213,87,245
	db 85,85,85,85,85,85,95,85,127,85,255,95,255,255,255,255
	db 85,85,93,85,255,247,255,255,255,255,255,255,255,255,255,255
	db 85,85,85,85,213,247,253,255,255,255,255,255,255,255,255,255
	db 85,85,85,85,85,85,85,85,85,85,85,253,213,255,245,255
	db 85,85,85,85,85,85,85,85,85,85,85,213,85,213,85,245
	db 85,85,85,85,85,85,85,85,85,85,89,89,149,149,102,102
	db 87,85,87,85,87,85,255,87,255,95,89,89,149,149,102,102
	db 187,187,238,238,170,170,170,170,170,170,85,85,85,85,85,85
	db 255,255,255,255,255,255,255,255,255,255,89,89,149,149,102,102
	db 95,181,95,229,255,166,175,170,171,170,255,127,255,127,255,127
	db 255,255,255,255,255,255,254,255,255,255,255,255,254,255,171,191
	db 255,255,255,255,255,255,255,255,255,255,255,254,175,251,170,254
	db 255,255,255,255,255,255,255,255,255,255,254,239,171,170,239,255
	db 253,255,253,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 85,85,85,85,85,213,85,245,85,253,85,253,85,253,85,253
	db 85,245,85,245,85,247,245,255,253,255,89,89,151,149,111,102
	db 85,85,85,85,85,85,255,85,255,87,255,95,255,255,255,255
	db 85,85,85,85,255,127,255,255,255,255,255,255,255,255,255,255
	db 85,85,85,85,85,85,213,255,245,255,249,255,255,255,255,255
	db 85,85,85,85,85,85,85,85,85,85,89,89,149,245,102,255
	db 85,213,85,253,85,187,85,238,149,170,165,170,169,170,85,85
	db 171,170,191,170,191,170,255,170,255,170,255,170,255,170,255,170
	db 255,255,255,255,255,255,255,255,255,255,255,255,254,191,171,234
	db 191,234,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 250,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,171,191,255,234,255,255,255,255,255,255,255,255,255,255,255
	db 250,255,255,191,255,255,255,255,255,255,255,255,255,255,254,191
	db 170,170,170,170,170,170,170,234,170,234,170,234,170,234,170,170
	db 85,85,95,85,123,85,110,85,170,85,170,86,170,90,85,85
	db 255,255,255,255,187,187,238,238,170,170,170,170,170,170,85,85
	db 85,85,85,85,85,85,85,85,85,85,87,85,87,85,95,85
	db 191,170,191,170,255,170,255,175,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,254,250,234,170,170,170
	db 255,255,255,255,250,255,235,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,191,255,255,255,255,254,254,171,254
	db 234,255,234,255,234,255,254,255,255,255,255,255,255,255,255,255
	db 170,170,170,170,170,170,170,170,170,234,170,234,170,250,170,250
	db 85,85,85,85,87,85,95,85,95,85,95,85,95,85,95,85
	db 191,170,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,191,254,235,171,254,255,255,255,255,255,255,255,255
	db 255,255,255,239,255,191,255,255,255,255,255,255,255,255,255,255
	db 234,235,191,254,255,255,255,255,255,255,255,255,255,255,254,255
	db 170,170,170,255,234,255,250,255,250,255,250,255,234,255,170,255
	db 95,85,95,85,95,85,255,87,255,95,255,127,255,127,255,127
	db 191,255,234,255,255,255,255,255,254,191,171,234,255,255,255,255
	db 255,250,191,174,234,255,255,255,255,255,255,255,255,255,255,255
	db 255,254,255,171,255,255,255,255,255,255,255,255,255,255,255,255
	db 191,255,255,255,255,255,255,255,251,255,254,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,239,255,191,190,255,235,255,255
	db 170,250,170,250,170,238,250,255,254,255,255,255,255,255,255,255
	db 95,85,90,89,149,149,126,102,255,171,255,175,255,175,255,191
	db 255,255,254,255,235,191,191,234,255,255,255,255,255,255,255,255
	db 170,255,170,255,234,255,239,255,255,255,255,255,255,255,255,255
	db 85,85,89,89,149,149,102,102,170,250,170,254,170,255,170,255
	db 85,85,89,89,149,149,102,102,170,170,175,170,191,170,255,170
	db 255,191,255,191,255,191,255,171,191,250,234,255,255,255,255,255
	db 255,255,255,255,255,255,255,251,255,175,255,255,255,255,255,255
	db 255,255,255,255,255,255,251,255,254,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,250,255,171,191,255,234,255,255,255,255
	db 85,85,89,89,149,149,102,102,170,234,170,254,170,255,170,255
	db 250,127,170,95,170,90,105,85,150,85,170,86,170,86,170,86
	db 255,255,255,255,255,255,255,191,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,254,175,255,250,255,255,255,255,255
	db 85,255,85,255,85,255,85,249,85,165,85,245,85,245,85,245
	db 255,85,255,87,255,87,254,85,234,85,90,85,85,85,90,85
	db 255,255,255,255,255,255,255,255,255,255,191,255,255,250,255,175
	db 255,255,255,255,255,255,239,255,250,255,255,255,255,255,255,255
	db 85,255,85,255,85,255,85,249,85,165,85,245,85,253,85,253
	db 170,170,170,170,170,170,170,170,165,170,85,169,85,149,85,85
	db 255,175,255,175,255,175,110,174,85,85,85,85,85,85,85,85
	db 255,255,255,255,255,255,238,238,187,87,90,85,85,85,85,85
	db 255,255,255,255,255,255,238,238,187,187,170,170,170,170,170,170
	db 255,255,255,255,255,255,238,238,187,187,170,170,170,170,170,171
	db 255,255,255,255,255,255,238,238,187,187,170,170,170,170,170,174
	db 255,255,255,255,255,255,238,238,187,187,170,170,165,170,85,170
	db 255,255,255,255,255,255,238,238,187,187,170,166,86,85,85,85
	db 85,253,85,253,85,253,85,237,85,187,149,170,169,170,170,106
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,121,85
	db 175,170,191,170,191,170,110,170,85,85,85,85,85,85,85,85
	db 170,254,170,255,170,255,170,238,170,187,170,166,86,85,85,85
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,234,170,122
	db 85,93,117,85,93,85,85,85,85,85,85,85,85,85,0,0
	db 85,85,85,85,85,213,85,87,93,85,85,85,85,85,0,0
	db 149,87,165,87,165,215,169,87,169,87,85,85,85,85,0,0
	db 85,94,149,94,149,222,165,94,173,94,85,85,85,85,0,0
	db 121,93,122,85,122,85,122,85,122,85,85,85,85,85,0,0
	db 85,85,85,85,85,213,85,151,93,149,85,85,85,85,0,0
_pano_beach_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,1,1,1,1,2,3,3,4,1,1,1,1
	db 1,1,1,1,1,1,1,1,2,3,3,4,1,1,1,1
	db 5,5,5,6,7,7,8,9,10,11,12,5,5,5,5,5
	db 5,5,5,6,7,7,13,5,5,5,5,5,5,5,5,5
	db 14,14,14,15,16,17,18,19,20,21,22,23,14,14,14,14
	db 14,14,14,15,16,17,24,25,26,27,28,14,14,14,14,14
	db 29,5,5,5,5,30,31,32,5,33,34,35,36,5,37,38
	db 29,5,5,5,5,39,40,41,42,43,44,45,5,5,37,38
	db 5,5,5,5,46,47,48,49,5,5,5,50,51,5,5,5
	db 5,5,5,5,5,52,53,54,55,56,57,58,5,5,5,5
	db 1,1,1,1,59,60,5,5,5,5,5,5,61,62,1,1
	db 1,1,1,1,63,64,65,5,5,5,66,67,68,1,1,1
	db 5,5,5,5,69,70,5,5,5,5,5,5,71,72,5,5
	db 5,5,5,5,73,74,5,5,5,5,5,75,76,5,5,5
	db 5,5,5,77,78,79,80,81,80,82,80,83,84,85,86,5
	db 5,5,5,77,87,79,80,81,80,82,80,83,88,89,86,5
	db 90,91,90,91,90,91,90,92,90,93,90,91,90,91,94,95
	db 90,91,90,91,90,91,90,92,90,93,90,91,90,91,94,95
_pano_beach_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,10,10,10,10,10,10,10,10,0,0,0,0,0
	db 0,0,0,10,10,10,10,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,10,1,10,4,4,4,10,10,1,1,1,1
	db 1,1,1,1,10,1,1,10,10,11,11,1,1,1,1,1
	db 12,1,1,1,1,11,4,4,3,4,4,4,11,1,12,12
	db 12,1,1,1,1,2,11,3,4,4,11,11,1,1,12,12
	db 1,1,1,1,2,11,4,4,3,3,3,4,11,1,1,1
	db 1,1,1,1,1,2,4,4,4,4,4,11,1,1,1,1
	db 2,2,2,2,2,4,3,3,3,3,3,3,11,2,2,2
	db 2,2,2,2,2,4,4,3,3,3,4,4,2,2,2,2
	db 2,2,2,2,3,4,3,3,3,3,3,3,4,4,2,2
	db 2,2,2,2,3,4,3,3,3,3,3,4,4,2,2,2
	db 2,2,2,5,5,6,4,4,4,4,4,6,6,4,7,2
	db 2,2,2,5,5,6,4,4,4,4,4,6,5,8,7,2
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	align 2
_pano_beach_pals:
	db 223,11,129,14,162,15,202,14,223,11,162,15,180,15,202,14
	db 223,11,180,15,199,15,255,15,223,11,199,15,237,15,255,15
	db 223,11,199,15,202,14,237,15,223,11,162,5,199,15,237,15
	db 223,11,162,5,202,14,237,15,223,11,199,15,79,10,255,15
	db 223,11,162,5,199,15,202,14,223,11,112,11,79,10,255,15
	db 223,11,162,15,202,14,237,15,223,11,162,15,180,15,237,15
	db 223,11,180,15,202,14,237,15
	align 2
_pano_coast_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,169,169,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,169,169,170,170,170,170,170,170,170,170,170,170,191,170
	db 85,85,169,169,170,170,170,170,170,170,254,171,255,175,255,255
	db 85,85,169,169,170,170,170,171,234,175,255,191,255,255,255,255
	db 85,85,169,169,170,170,170,191,171,255,255,255,255,255,255,255
	db 85,85,169,169,170,170,170,250,170,254,175,255,255,255,255,255
	db 85,85,169,169,170,170,170,170,170,170,170,250,170,254,255,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 191,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,255,170,170,255,170,255,170,170,170,170,170,170,170,170,170
	db 250,175,255,127,170,170,170,170,85,85,85,85,85,85,85,85
	db 255,255,255,255,170,170,170,170,85,85,85,85,85,85,85,85
	db 175,255,255,255,170,170,170,170,85,85,85,85,85,85,85,85
	db 170,250,117,253,170,170,170,170,85,85,85,85,85,85,95,213
	db 170,170,170,170,170,234,170,234,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,191,170,191,170
	db 85,85,85,85,85,85,87,85,223,127,255,255,170,170,170,170
	db 85,85,85,85,87,253,95,253,255,255,255,255,170,170,170,170
	db 85,85,85,85,85,213,85,245,85,253,255,255,170,170,175,170
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,165,125,229
	db 85,85,245,215,255,255,170,170,170,170,170,170,85,85,85,85
	db 149,149,89,89,153,153,170,255,170,255,170,170,170,170,170,170
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 151,149,95,89,191,153,255,175,255,175,170,170,170,170,170,170
	db 127,245,255,255,255,255,170,170,170,170,85,85,85,85,85,85
	db 149,213,89,249,217,255,254,255,254,255,170,170,170,170,170,170
	db 149,149,89,89,153,153,171,170,171,170,170,170,170,170,170,170
	db 151,149,95,89,191,191,255,255,255,255,191,170,170,170,170,170
	db 127,245,255,253,255,255,170,170,170,170,170,170,85,85,85,85
	db 255,213,255,255,255,255,170,170,170,170,170,170,85,85,85,85
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
	db 223,255,95,255,127,253,127,181,253,170,173,106,170,85,90,85
	db 253,255,213,191,213,191,85,170,85,234,85,234,85,234,85,254
	db 86,85,106,85,102,85,102,85,106,85,170,85,171,85,159,85
	db 89,85,85,245,255,255,255,175,170,170,170,170,170,170,170,170
	db 255,85,255,85,189,170,170,170,106,85,85,85,85,85,85,85
	db 127,245,253,85,253,87,245,159,247,170,167,106,170,85,90,85
	db 253,255,213,255,213,255,85,234,85,234,85,234,85,234,85,254
	db 245,85,213,85,215,255,255,255,191,170,170,170,170,170,170,170
	db 247,95,247,255,215,255,223,191,95,170,175,106,170,85,90,85
	db 253,255,213,255,213,255,85,234,85,170,85,170,85,170,85,254
	db 245,255,255,171,175,170,170,170,170,170,170,170,170,170,170,170
	db 254,87,250,255,170,254,170,170,170,170,170,170,170,170,170,170
_pano_coast_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,2,3,4,5,6,7,1,1,1,1,1,1,1,1
	db 1,1,2,3,4,5,6,7,1,1,1,1,1,1,1,1
	db 8,8,9,10,11,12,13,14,15,8,8,16,17,18,19,20
	db 8,8,9,10,11,12,13,14,15,8,8,16,17,18,19,20
	db 21,22,23,23,23,23,24,25,26,23,23,23,27,28,29,30
	db 21,22,23,23,23,23,24,25,26,23,23,23,27,28,29,30
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 31,32,33,34,35,36,36,36,37,38,39,40,41,36,36,36
	db 42,43,44,45,46,36,36,36,31,32,33,34,35,36,36,36
	db 47,48,49,50,51,52,52,53,54,55,56,57,58,52,52,53
	db 59,60,61,62,63,64,52,53,47,48,49,50,51,52,52,53
	db 65,66,67,68,69,70,52,71,72,73,74,75,76,77,52,71
	db 72,78,79,80,81,82,52,71,65,66,67,68,69,70,52,71
	db 83,84,85,86,87,88,89,90,83,84,85,91,92,93,94,90
	db 83,84,85,86,95,96,97,90,83,84,85,86,87,88,89,90
	db 8,8,8,8,8,8,98,99,8,8,8,8,8,8,98,99
	db 8,8,8,8,8,8,98,99,8,8,8,8,8,8,98,99
_pano_coast_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0
	db 0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,2,2,2,2,0,0,0,0,2,2,2,2
	db 0,0,0,0,2,2,2,2,0,0,0,0,2,2,2,2
	db 3,4,4,4,4,4,4,3,4,4,4,4,4,4,3,3
	db 3,4,4,4,4,4,4,3,4,4,4,4,4,4,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 10,11,12,10,10,10,10,10,10,11,12,10,10,10,10,10
	db 10,11,12,10,10,10,10,10,10,11,12,10,10,10,10,10
	db 12,12,12,12,11,10,10,10,12,12,12,12,11,10,10,10
	db 12,12,12,12,11,11,10,10,12,12,12,12,11,10,10,10
	db 7,12,12,12,8,11,10,12,12,12,12,12,8,11,10,12
	db 12,12,12,12,8,11,10,12,7,12,12,12,8,11,10,12
	db 5,5,5,5,5,6,12,7,5,5,5,5,6,8,12,7
	db 5,5,5,5,5,6,12,7,5,5,5,5,5,6,12,7
	db 5,5,5,5,5,5,9,9,5,5,5,5,5,5,9,9
	db 5,5,5,5,5,5,9,9,5,5,5,5,5,5,9,9
	align 2
_pano_coast_pals:
	db 201,6,114,14,147,15,219,15,201,6,114,14,147,15,255,15
	db 201,6,147,15,219,15,255,15,201,6,181,15,219,15,255,15
	db 201,6,147,15,181,15,219,15,201,6,177,10,162,6,214,9
	db 201,6,162,6,214,9,231,14,201,6,128,8,177,10,214,9
	db 201,6,177,10,214,9,231,14,201,6,128,8,162,6,214,9
	db 201,6,128,8,181,15,217,15,201,6,177,10,181,15,217,15
	db 201,6,128,8,177,10,217,15
	align 2
_pano_fields_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 119,85,253,109,255,255,255,255,170,170,170,170,170,170,170,170
	db 187,187,254,254,255,255,255,255,170,170,170,170,170,170,170,170
	db 186,187,254,254,255,255,255,255,170,170,170,170,170,170,170,170
	db 85,85,101,229,234,255,234,255,170,170,170,170,170,170,170,170
	db 85,85,101,101,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,253,101,255,255,255,255,170,170,170,170,170,170,170,170
	db 171,187,254,254,255,255,255,255,170,170,170,170,170,170,170,170
	db 85,117,101,253,255,255,255,255,170,170,170,170,170,170,170,170
	db 85,85,101,101,170,234,170,234,170,170,170,170,170,170,170,170
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
	db 213,255,85,253,85,245,85,85,85,85,85,85,85,85,86,85
	db 239,251,239,251,231,235,182,239,182,239,182,191,246,190,246,190
	db 213,255,255,170,175,170,175,85,111,85,111,85,111,85,111,85
	db 255,255,255,255,255,255,255,255,255,255,255,111,170,106,170,106
	db 255,255,255,255,255,255,255,255,171,234,170,106,86,85,86,85
	db 255,255,255,255,255,255,255,255,255,255,255,107,191,105,167,105
	db 106,89,106,153,106,153,106,153,106,153,106,153,255,255,255,255
	db 234,235,186,239,186,239,186,191,234,190,234,174,255,255,255,255
	db 170,169,170,169,170,169,170,169,170,169,170,169,255,255,255,255
	db 95,85,95,85,95,85,95,85,95,85,85,85,170,170,170,170
	db 251,254,251,251,239,251,239,251,239,255,191,239,255,255,255,255
	db 86,234,86,238,86,238,86,190,86,190,86,190,255,255,255,255
	db 85,169,85,169,85,169,85,169,85,169,85,169,255,255,255,255
	db 154,90,154,90,154,90,154,90,154,90,154,90,255,255,255,255
	db 239,239,175,239,191,239,190,191,254,190,250,190,255,255,255,255
	db 255,191,255,175,255,170,171,170,170,170,170,170,170,170,170,170
	db 255,255,255,255,255,255,255,255,255,95,85,85,170,170,170,170
	db 255,255,255,255,255,255,255,255,255,255,170,170,170,170,170,170
	db 255,255,255,255,253,255,213,255,85,245,85,149,170,170,170,170
	db 85,245,85,213,85,85,85,85,85,85,85,85,170,170,170,170
	db 86,85,101,85,101,85,102,101,102,101,102,101,255,255,255,255
	db 250,254,234,251,234,251,234,235,170,239,170,239,255,255,255,255
	db 190,255,190,254,250,254,251,254,251,251,239,251,255,255,255,255
	db 86,254,86,250,86,250,86,234,86,238,86,238,255,255,255,255
	db 251,250,251,251,239,251,239,239,175,239,191,239,255,255,255,255
	db 85,85,85,85,170,170,170,170,170,170,170,170,85,85,85,85
	db 170,170,170,170,85,85,85,85,85,85,85,85,170,170,170,170
_pano_fields_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,2,3,4,5,5,5,5,5,5,6,2,2,7,8,9
	db 1,2,3,4,5,5,5,5,5,5,6,2,2,7,8,9
	db 10,11,12,12,12,12,12,12,12,12,12,12,12,12,12,13
	db 10,11,12,12,12,12,12,12,12,12,12,12,12,12,12,13
	db 14,14,14,15,16,17,18,12,19,14,14,14,14,14,14,14
	db 14,14,14,15,16,17,18,12,19,14,14,14,14,14,14,14
	db 12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
	db 12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
	db 20,20,20,21,20,20,20,20,20,20,20,22,20,20,20,20
	db 20,20,20,21,20,20,20,20,20,20,20,22,20,20,20,20
	db 23,24,25,26,27,25,25,25,25,25,25,28,29,25,25,30
	db 23,31,25,26,27,25,25,25,25,25,25,28,29,25,25,30
	db 32,33,34,35,36,37,38,39,40,25,41,42,43,25,44,45
	db 32,46,34,47,36,48,38,49,50,25,41,42,43,25,44,45
	db 51,52,53,54,55,56,57,58,59,60,61,62,62,63,64,65
	db 51,66,53,54,67,68,57,58,69,60,61,62,62,63,64,65
	db 70,70,71,71,70,70,71,71,70,70,71,71,70,70,71,71
	db 70,70,71,71,70,70,71,71,70,70,71,71,70,70,71,71
_pano_fields_map_pal:
	db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
	db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
	db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
	db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
	db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
	db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
	db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
	db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
	db 10,10,10,10,10,10,10,9,10,10,10,10,10,10,10,10
	db 10,10,10,10,10,10,10,9,10,10,10,10,10,10,10,10
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 6,7,0,9,9,0,0,0,0,0,0,9,9,0,0,0
	db 6,2,0,9,9,0,0,0,0,0,0,9,9,0,0,0
	db 11,11,7,7,2,7,6,7,7,0,9,9,9,0,0,0
	db 11,11,7,7,2,7,6,7,7,0,9,9,9,0,0,0
	db 11,11,1,8,11,11,1,1,11,3,2,2,3,3,4,1
	db 11,11,1,8,11,11,1,1,11,3,2,2,3,3,4,1
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	align 2
_pano_fields_pals:
	db 218,7,132,3,166,5,207,12,218,7,132,3,166,5,222,8
	db 218,7,201,7,222,8,207,12,218,7,132,3,203,5,207,12
	db 218,7,132,3,222,8,207,12,218,7,203,5,222,8,0,0
	db 218,7,132,3,201,7,207,12,218,7,166,5,201,7,207,12
	db 218,7,166,5,222,8,207,12,218,7,104,4,221,12,207,12
	db 218,7,179,13,216,13,221,12,218,7,132,3,166,5,203,5
	db 218,7,166,5,203,5,207,12
	align 2
_pano_desert_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,89,89,153,153,170,170,170,170,170,170,170,170,170,170
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
	db 221,95,221,95,221,95,221,95,221,95,221,95,221,95,221,95
	db 95,215,95,215,95,215,95,215,95,215,95,215,95,215,95,215
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
	db 255,253,255,253,255,253,255,253,255,253,255,253,255,253,255,253
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
	db 247,255,247,255,247,255,247,255,247,255,247,255,247,255,247,255
	db 255,213,255,85,223,85,223,85,223,213,127,213,125,213,125,213
	db 255,255,255,255,255,255,255,127,255,127,255,127,85,253,85,245
	db 255,255,255,255,255,255,213,255,85,255,85,255,85,215,85,215
	db 119,125,119,125,119,125,119,125,119,125,119,125,247,125,251,125
	db 170,169,170,169,170,169,170,169,170,169,170,169,170,169,255,255
	db 189,90,173,90,173,90,173,90,173,90,169,90,255,95,255,95
	db 255,127,255,127,255,127,223,119,223,119,221,87,245,255,245,255
	db 119,255,119,255,119,255,127,255,175,254,170,170,170,170,170,170
	db 170,169,170,169,170,169,170,249,255,255,255,95,117,85,117,85
	db 255,90,255,90,217,90,153,91,153,91,217,251,237,251,239,251
	db 251,255,251,255,91,150,95,150,95,150,95,150,95,150,94,150
	db 255,255,255,255,255,223,127,223,127,223,127,127,253,125,245,125
	db 255,213,255,213,255,213,247,213,247,85,215,85,223,85,223,213
	db 255,255,255,255,255,255,255,223,255,223,255,223,85,125,85,125
	db 185,90,169,90,173,90,173,90,173,90,173,90,255,95,255,95
	db 255,95,255,95,255,127,255,125,247,125,245,125,245,255,245,255
	db 170,169,170,169,170,169,170,249,223,255,223,95,85,85,117,85
	db 255,91,255,91,217,91,217,90,217,90,153,170,169,170,170,170
	db 255,255,254,255,94,150,90,150,91,150,91,150,95,150,95,150
	db 221,215,125,223,170,170,170,170,85,85,85,85,85,85,85,85
	db 150,153,150,153,170,217,255,255,255,127,85,85,85,85,85,85
	db 153,90,153,90,153,90,255,255,255,255,170,106,170,106,170,106
	db 95,215,95,215,95,215,94,215,250,255,250,255,170,191,170,191
	db 247,255,170,255,170,250,170,170,170,170,170,170,170,170,170,170
	db 255,255,255,255,85,85,85,85,85,85,85,85,85,85,85,85
	db 255,255,255,255,171,106,171,106,171,106,171,106,170,106,170,106
	db 85,150,255,239,255,239,90,239,90,190,90,190,90,190,90,251
	db 87,253,86,85,86,85,86,85,86,85,86,85,86,85,150,85
	db 255,255,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 170,90,170,90,170,90,170,90,170,90,170,90,170,90,170,90
	db 85,106,85,106,85,106,85,106,85,106,85,106,85,106,85,106
	db 90,85,90,85,90,85,154,85,90,85,90,85,154,85,154,85
	db 117,85,117,85,85,85,85,85,85,85,117,85,117,85,117,85
	db 95,223,127,223,125,223,253,125,245,125,247,125,247,247,223,247
	db 94,126,218,125,247,253,247,245,245,247,221,247,221,223,93,223
	db 245,253,213,247,170,170,170,170,85,85,85,85,85,85,85,85
	db 254,255,254,255,170,106,171,106,171,106,171,106,171,106,171,106
	db 85,150,255,251,255,251,90,251,90,239,90,239,90,239,90,190
	db 117,85,117,85,117,85,117,85,117,85,85,85,85,85,85,85
	db 247,247,223,247,223,247,95,223,127,223,125,223,253,125,245,125
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
	db 51,38,13,14,39,52,53,42,43,44,54,55,47,56,57,58
	db 59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74
	db 75,60,61,62,63,64,76,77,67,68,69,70,71,78,79,80
_pano_desert_map_pal:
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 9,9,9,10,10,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,10,10,9,9,9,9,9,9,9,9,9,9,9
	db 9,11,0,0,11,10,9,9,9,10,10,9,9,9,9,9
	db 9,11,0,0,11,10,9,9,9,10,10,9,9,9,9,9
	db 9,11,0,0,11,10,9,9,11,0,11,10,11,10,9,9
	db 9,11,0,0,11,10,9,9,11,0,11,10,11,10,9,9
	db 10,11,0,0,0,10,10,9,0,1,1,10,12,2,1,11
	db 10,11,0,0,0,10,10,9,0,1,1,10,12,2,3,11
	db 4,2,5,0,0,2,6,6,7,2,6,6,6,2,2,2
	db 4,2,5,0,0,2,6,6,7,2,6,6,6,2,2,4
	align 2
_pano_desert_pals:
	db 206,10,106,8,139,7,189,8,206,10,106,8,189,8,206,9
	db 206,10,173,7,189,8,206,9,206,10,106,8,206,9,223,11
	db 206,10,173,7,206,9,223,11,206,10,106,8,173,7,206,9
	db 206,10,139,7,173,7,206,9,206,10,139,7,173,7,189,8
	db 206,10,165,14,185,13,206,11,206,10,106,8,206,11,223,10
	db 206,10,189,8,206,11,223,10,206,10,106,8,189,8,223,10
	db 206,10,106,8,139,7,223,10
	align 2
_pano_autumn_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,101,101,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,101,101,170,170,170,170,170,170,170,170,171,170,171,170
	db 85,85,101,101,170,170,170,170,250,170,255,171,255,255,255,255
	db 85,85,85,85,85,87,213,95,255,127,255,255,170,170,170,170
	db 85,85,85,85,85,127,87,255,255,255,255,255,255,255,255,255
	db 85,85,85,85,85,245,85,253,95,255,255,255,170,170,170,170
	db 85,85,101,101,170,170,170,170,170,234,170,250,250,255,250,255
	db 85,85,101,101,170,170,170,170,170,170,170,170,170,170,191,170
	db 85,85,101,101,170,170,170,170,170,170,170,170,170,170,250,170
	db 85,85,101,101,170,170,170,170,255,170,255,170,170,170,170,170
	db 85,85,213,93,247,127,255,255,170,170,170,170,85,85,85,85
	db 85,119,85,253,215,255,255,255,170,170,170,170,85,85,85,85
	db 85,85,101,245,170,254,170,255,254,255,254,255,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,95,85,127,85,170,90,170,90,85,85,85,85,85,85
	db 255,85,255,245,255,255,170,170,170,170,85,85,85,85,85,85
	db 253,87,255,255,255,255,170,170,170,170,85,85,85,85,85,85
	db 85,85,85,85,213,255,169,170,169,170,85,85,85,85,245,85
	db 85,85,85,85,85,85,85,85,85,85,85,87,213,95,247,127
	db 85,85,85,85,85,85,85,85,85,85,85,127,87,255,223,255
	db 85,85,85,85,85,85,85,85,85,85,85,245,85,253,95,255
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,213
	db 170,170,174,174,234,234,187,187,255,255,255,255,255,255,255,255
	db 170,170,175,174,235,234,187,187,255,255,255,255,255,255,255,255
	db 255,175,255,255,255,255,187,187,255,255,255,255,255,255,255,255
	db 255,255,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,250,254,255,250,255,187,187,255,255,255,255,255,255,255,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,218,159,223,95
	db 170,170,170,170,170,170,170,170,170,170,170,170,167,170,87,253
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,255,181,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,250,159,247,95
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,251,229,251
	db 170,170,170,170,170,170,174,174,234,234,187,187,255,255,255,255
	db 169,170,165,170,149,170,149,174,85,234,85,185,85,253,85,245
	db 239,89,191,89,190,89,190,89,254,89,251,89,251,89,235,105
	db 86,253,86,101,86,101,86,101,86,101,86,101,90,101,90,102
	db 125,95,125,93,253,93,247,93,247,87,215,87,223,87,223,95
	db 255,255,255,255,111,90,111,90,110,90,110,90,106,90,107,90
	db 85,85,85,213,85,245,89,253,149,253,102,255,234,255,234,255
	db 251,89,235,89,239,89,239,89,191,89,190,89,190,89,254,105
	db 223,87,223,95,127,95,125,95,125,93,253,93,247,93,247,87
	db 251,255,251,255,107,90,111,90,111,90,111,90,111,90,110,90
	db 170,170,170,170,170,170,170,170,170,170,170,253,234,253,246,93
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 170,170,170,170,170,170,170,170,170,170,167,170,87,170,85,165
	db 170,170,170,170,170,170,170,170,170,170,170,218,170,223,106,95
	db 255,255,255,255,253,255,245,255,213,255,85,253,85,213,85,85
	db 85,213,85,85,85,85,85,85,86,85,86,85,150,85,150,85
	db 239,105,239,105,191,169,186,169,186,153,250,153,251,169,235,105
	db 90,102,90,101,86,101,150,102,154,102,154,102,154,102,90,102
	db 127,95,125,95,93,93,221,93,215,93,215,87,215,87,223,87
	db 107,90,111,90,111,90,111,90,111,90,110,90,110,90,106,90
	db 250,215,250,223,246,95,215,127,87,127,95,255,127,253,255,213
	db 170,170,170,170,170,170,170,170,170,234,170,234,170,222,170,95
	db 255,255,255,255,255,255,255,255,255,255,245,255,213,255,85,255
	db 170,170,170,170,170,170,170,170,170,170,170,255,106,255,126,95
	db 170,170,170,170,170,170,170,170,170,170,170,250,170,247,234,119
	db 251,105,251,105,235,169,235,169,235,153,187,153,186,169,170,105
	db 215,87,223,87,223,95,95,95,93,95,93,93,221,93,215,93
	db 110,90,106,90,107,90,107,90,111,90,111,90,111,90,111,90
	db 122,253,250,245,254,245,253,215,253,223,245,95,215,127,87,95
	db 170,170,170,170,170,170,170,170,170,234,170,234,170,246,170,247
	db 251,155,251,155,239,155,239,159,175,159,191,159,190,158,254,158
	db 245,255,213,239,213,239,149,165,149,181,149,181,149,245,149,229
	db 255,255,255,255,154,170,154,170,154,170,154,170,154,170,150,169
	db 86,85,86,85,86,85,86,85,86,85,86,85,86,170,166,170
	db 127,127,125,125,253,125,253,125,247,119,247,119,85,85,85,85
	db 245,255,213,255,85,253,85,253,85,229,85,229,170,169,106,149
	db 85,85,85,85,85,85,85,85,101,85,101,85,102,165,102,170
	db 154,101,154,101,169,105,169,165,106,165,102,169,166,153,170,153
	db 235,105,235,169,171,169,170,169,170,153,170,153,170,169,170,105
	db 90,102,170,101,166,101,166,102,170,102,154,102,154,102,106,102
	db 221,93,93,93,93,93,93,85,221,85,213,85,213,85,213,85
	db 107,90,107,90,110,90,110,90,110,90,110,90,106,90,106,90
	db 255,213,253,85,253,93,245,93,215,93,87,93,87,93,119,93
	db 190,175,190,191,190,254,251,254,251,250,251,251,106,251,90,165
	db 170,170,170,247,253,247,253,247,213,223,85,223,85,87,85,85
	db 85,245,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 190,158,254,158,250,158,251,155,251,155,239,155,239,159,175,159
	db 245,255,213,255,213,255,149,245,149,229,149,229,149,165,149,165
	db 223,87,223,95,95,95,127,127,125,125,253,125,85,85,85,85
	db 245,255,213,255,85,189,85,189,85,165,85,229,170,169,106,149
	db 234,105,235,169,171,169,170,169,170,153,170,153,170,169,170,105
	db 213,85,213,85,221,85,221,85,93,85,93,85,93,85,221,85
	db 110,90,110,90,106,90,106,90,106,90,110,90,106,90,106,90
	db 95,223,127,93,255,85,255,85,253,85,253,93,245,93,215,93
	db 239,251,239,239,239,175,190,175,190,191,190,254,106,254,90,181
	db 170,170,170,125,253,125,253,125,213,247,213,247,213,87,85,85
	db 250,239,234,239,170,239,170,239,170,254,170,255,170,191,170,174
	db 238,255,255,191,170,175,170,170,170,170,170,170,170,170,170,170
	db 255,235,255,170,191,170,175,170,171,170,170,170,170,170,170,170
	db 255,255,255,255,255,255,255,255,255,255,255,251,255,186,187,174
	db 175,170,171,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,255,255,255,255,255,255,191,255,175,255,171,255,170,191,170
	db 154,169,154,106,169,106,169,166,106,166,102,170,166,154,170,153
	db 255,125,255,253,255,253,255,253,175,222,171,222,170,250,170,126
	db 106,102,170,101,166,101,166,102,170,166,154,166,154,170,106,102
	db 221,85,221,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 127,95,126,95,106,95,170,95,170,95,170,94,170,95,170,94
	db 171,90,170,86,170,85,106,85,90,85,86,85,85,85,85,85
	db 171,234,171,234,170,234,170,234,170,250,170,234,170,234,170,186
	db 255,250,191,250,175,255,235,191,234,175,250,171,234,170,186,170
	db 85,213,215,245,215,253,223,253,171,255,170,189,170,174,170,171
	db 213,85,213,85,213,85,85,85,85,85,85,85,85,85,85,85
	db 170,171,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 174,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 167,170,175,170,175,170,175,170,173,170,173,170,175,170,167,170
	db 170,122,170,250,170,250,170,250,170,218,170,218,170,250,170,122
	db 127,175,255,169,247,169,247,171,255,171,223,171,223,171,127,171
	db 170,86,170,86,170,86,170,86,170,86,170,86,170,86,170,86
_pano_autumn_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,2,3,4,5,6,7,8,9,10,11,12,13,1,1
	db 1,1,2,3,4,5,6,7,8,9,10,11,12,13,1,1
	db 14,14,14,14,14,14,14,15,16,17,18,19,20,21,22,14
	db 14,14,14,14,14,14,14,15,16,17,18,19,20,21,22,14
	db 23,23,23,23,23,23,23,23,23,24,25,26,26,26,27,23
	db 23,23,23,23,23,23,23,23,23,24,25,26,26,26,27,23
	db 14,14,14,14,14,14,14,14,28,29,30,14,14,14,14,14
	db 14,14,14,14,14,14,14,14,31,29,32,14,14,14,14,14
	db 33,33,33,33,33,33,33,34,35,36,37,38,39,33,33,33
	db 33,33,33,33,33,33,33,34,40,36,41,42,39,33,33,33
	db 43,44,44,45,46,44,47,48,49,50,51,52,53,54,44,55
	db 56,44,44,45,57,44,47,48,58,50,59,60,61,62,44,55
	db 63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78
	db 79,80,65,66,81,82,69,70,83,72,84,85,86,87,88,78
	db 89,90,91,92,14,93,94,95,96,97,98,99,100,101,102,103
	db 89,90,91,92,14,93,94,95,96,97,104,99,100,101,102,103
	db 105,14,14,106,14,14,107,95,108,109,0,110,14,14,14,14
	db 105,14,14,106,14,14,107,95,108,109,0,110,14,14,14,14
_pano_autumn_map_pal:
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,12,12,10,12,10,12,12,12,12,10,10,12,9,9
	db 9,9,12,12,10,12,10,12,12,12,12,10,10,12,9,9
	db 9,9,9,9,9,9,9,10,10,10,10,10,10,10,10,9
	db 9,9,9,9,9,9,9,10,10,10,10,10,10,10,10,9
	db 9,9,9,9,9,9,9,9,9,9,9,10,10,10,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,10,10,10,9,9
	db 0,0,0,0,0,0,0,0,0,0,5,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,5,0,0,0,0,0
	db 1,1,1,1,1,1,1,1,6,6,3,6,2,1,1,1
	db 1,1,1,1,1,1,1,1,6,6,3,6,2,1,1,1
	db 3,1,1,4,3,1,1,7,6,6,3,6,3,3,1,1
	db 3,1,1,4,3,1,1,7,6,6,3,6,3,3,1,1
	db 6,6,6,6,3,7,6,6,6,6,3,6,3,11,3,1
	db 6,6,6,6,3,7,6,6,6,6,3,6,3,11,3,1
	db 8,8,8,8,8,8,8,6,8,6,3,8,11,8,8,8
	db 8,8,8,8,8,8,8,6,8,6,3,8,11,8,8,8
	db 8,8,8,8,8,8,8,6,8,8,3,8,8,8,8,8
	db 8,8,8,8,8,8,8,6,8,8,3,8,8,8,8,8
	align 2
_pano_autumn_pals:
	db 172,6,122,4,172,14,223,8,172,6,122,4,172,14,222,13
	db 172,6,172,14,222,13,223,8,172,6,173,5,222,13,223,8
	db 172,6,122,4,222,13,223,8,172,6,172,14,173,5,223,8
	db 172,6,122,4,173,5,223,8,172,6,122,4,173,5,222,13
	db 172,6,122,4,93,1,173,5,172,6,104,13,138,14,172,14
	db 172,6,138,14,172,14,239,15,172,6,93,1,173,5,223,8
	db 172,6,104,13,138,14,205,14
	align 2
_pano_alps_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 119,119,253,253,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,117,169,249,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,169,169,170,170,170,170,170,170,170,170,170,170,170,170
	db 119,87,253,169,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,85,85,85,85,85,85,85,85,87,85,95,85,127,85
	db 213,85,245,87,253,95,255,127,255,255,255,255,255,255,255,255
	db 85,85,85,85,85,85,85,85,85,213,85,245,85,253,85,255
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
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,2,3,3,3,3,3,3,3,3,3,3,4,1,1,1
	db 1,2,3,3,3,3,3,3,3,3,3,3,4,1,1,1
	db 5,6,7,8,8,8,8,8,5,6,7,8,8,8,8,8
	db 5,6,7,8,8,8,8,8,5,6,7,8,8,8,8,8
	db 9,10,11,12,13,14,15,16,9,10,11,12,13,14,15,16
	db 9,17,11,12,13,14,15,16,9,10,11,12,13,14,15,16
	db 18,19,20,21,22,23,24,25,18,26,27,21,22,28,24,25
	db 18,29,30,21,22,31,24,25,18,19,20,21,22,23,24,25
	db 32,33,34,35,36,37,38,39,32,40,41,42,36,43,44,39
	db 32,45,46,47,36,48,49,39,32,33,34,35,36,37,38,39
	db 50,51,52,53,54,55,56,57,50,51,58,59,54,60,61,57
	db 50,51,62,63,54,64,65,57,50,51,52,53,54,55,56,57
	db 50,51,8,66,67,8,68,57,50,51,8,66,67,8,69,57
	db 50,51,8,66,67,8,70,57,50,51,8,66,67,8,68,57
	db 71,72,73,74,75,76,77,78,79,80,76,81,82,76,83,84
	db 79,72,74,81,75,85,83,78,71,72,86,87,75,88,77,78
	db 89,90,91,92,93,94,95,91,96,97,94,90,98,96,93,89
	db 90,91,92,93,94,95,91,96,97,94,90,98,96,93,89,90
_pano_alps_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,0,0,0,0,0,1,1,1,0,0,0,0,0
	db 1,1,1,0,0,0,0,0,1,1,1,0,0,0,0,0
	db 1,2,1,1,1,1,1,1,1,2,1,1,1,1,1,1
	db 1,2,1,1,1,1,1,1,1,2,1,1,1,1,1,1
	db 2,2,2,1,2,2,1,1,2,2,2,1,2,2,1,1
	db 2,2,2,1,2,2,1,1,2,2,2,1,2,2,1,1
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 3,4,5,5,3,3,3,3,3,3,3,4,3,3,3,3
	db 4,3,5,3,3,5,3,3,3,3,5,3,3,5,3,4
	db 5,5,5,5,6,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,6,5,5,5,5,5,5,5,6,5,5,5
	align 2
_pano_alps_pals:
	db 201,8,81,12,98,13,220,15,201,8,98,13,131,14,255,15
	db 201,8,149,11,201,14,255,15,201,8,97,3,149,11,201,14
	db 201,8,114,4,149,11,201,14,201,8,97,3,114,4,201,14
	db 201,8,97,3,114,4,149,11,201,8,0,0,0,0,0,0
	db 201,8,0,0,0,0,0,0,201,8,0,0,0,0,0,0
	db 201,8,0,0,0,0,0,0,201,8,0,0,0,0,0,0
	db 201,8,0,0,0,0,0,0
	align 2
_pano_city_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 102,102,169,169,170,170,170,170,170,170,170,170,170,170,170,170
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
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 4,4,4,4,4,4,4,5,6,7,8,4,4,4,4,4
	db 4,4,4,4,4,4,4,5,6,7,8,4,4,4,4,4
	db 9,10,11,9,9,9,12,13,13,13,14,15,16,9,9,9
	db 9,10,11,9,9,9,12,13,13,13,14,15,16,9,9,9
	db 17,18,19,20,21,22,23,24,24,24,25,26,27,28,17,29
	db 17,18,19,20,21,22,23,24,24,24,25,26,27,28,17,29
	db 30,31,32,33,34,0,35,36,37,38,39,40,41,42,43,44
	db 43,45,46,47,34,48,49,50,51,52,53,54,55,42,30,31
	db 56,57,58,59,60,0,61,62,63,64,65,66,67,42,68,58
	db 69,58,70,71,72,73,74,75,0,76,0,66,67,77,56,57
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
	db 155,7,0,0,0,0,0,0,155,7,0,0,0,0,0,0
	db 155,7,0,0,0,0,0,0,155,7,0,0,0,0,0,0
	db 155,7,0,0,0,0,0,0
	align 2
_pano_lake_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 119,119,253,253,170,170,170,170,170,170,170,170,170,170,170,170
	db 117,119,253,253,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,169,169,170,170,170,170,170,170,170,170,170,170,170,170
	db 119,119,253,253,170,170,170,170,170,170,170,170,171,170,255,171
	db 102,102,169,169,85,85,85,85,85,253,95,253,255,255,255,255
	db 117,119,253,253,170,170,170,170,170,170,170,234,170,250,170,254
	db 85,85,169,169,170,170,170,170,170,170,170,170,191,170,255,170
	db 85,85,169,169,170,170,170,170,254,170,254,170,255,235,255,255
	db 85,85,169,169,170,170,170,170,250,171,250,175,254,255,255,255
	db 85,85,169,169,170,170,170,170,170,170,234,191,234,255,255,255
	db 85,85,169,169,170,170,170,170,170,170,170,170,170,170,170,254
	db 87,85,173,169,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,191,255,191,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,255,255,255,170,170,170,170,170,170,170,170,170,170,170,170
	db 251,255,251,255,170,170,170,170,170,170,170,170,170,170,170,170
	db 250,255,250,255,170,170,170,170,170,170,170,170,170,170,170,170
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 170,170,174,174,234,234,187,187,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,106,253,106,85
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,175,169,166
	db 255,255,255,255,255,255,245,255,85,255,85,253,85,213,85,85
	db 255,255,255,255,170,90,170,90,85,85,85,85,85,85,85,85
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
	db 255,255,213,255,85,253,85,149,85,149,85,85,85,85,85,85
	db 253,190,233,254,233,251,233,251,233,235,169,239,169,239,169,191
	db 175,166,191,166,190,166,254,166,250,166,251,166,251,166,239,166
	db 255,90,127,106,111,106,107,169,169,169,169,165,165,166,166,150
	db 255,255,255,255,255,255,255,255,255,175,171,166,170,166,90,149
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,111,191,105
	db 127,255,127,213,107,85,106,85,106,85,106,85,107,85,107,85
	db 255,255,255,111,255,105,166,105,166,169,165,166,153,166,153,150
	db 102,102,102,102,170,170,170,170,170,170,170,170,170,170,170,170
	db 105,89,105,89,170,170,170,170,171,170,191,170,255,170,255,171
	db 170,170,170,170,170,170,255,175,255,255,85,245,85,85,85,85
	db 251,170,255,250,170,106,86,85,85,85,85,85,85,85,85,85
	db 190,235,190,235,170,186,234,170,171,90,170,85,106,85,90,85
	db 125,85,253,85,85,85,85,85,85,85,85,93,117,85,85,85
	db 127,127,127,253,85,117,213,85,87,85,85,85,85,85,85,85
	db 85,125,87,125,85,85,85,85,85,85,85,93,117,85,85,85
	db 223,247,223,215,85,117,213,85,87,85,86,85,106,85,170,85
	db 255,255,251,255,170,170,170,170,106,170,85,85,85,85,85,85
	db 255,255,255,255,170,186,234,170,171,170,170,90,170,85,106,85
	db 85,255,85,253,170,170,170,170,170,170,170,174,186,170,170,170
	db 85,85,85,85,170,186,234,170,171,170,170,170,170,170,170,170
	db 106,89,106,89,170,170,170,170,170,170,234,170,255,191,255,255
	db 125,125,245,125,85,117,213,85,87,85,85,85,85,85,85,85
	db 85,85,101,85,170,170,170,170,170,170,170,174,186,170,170,170
	db 223,85,93,85,85,85,85,85,85,85,85,93,117,85,85,85
	db 215,223,223,95,85,117,213,85,87,85,85,85,85,85,85,85
	db 95,221,93,221,85,85,85,85,85,85,85,93,117,85,85,85
	db 247,125,247,253,85,117,213,85,87,85,86,85,106,85,170,85
	db 255,255,254,255,170,170,170,170,106,170,85,85,85,85,85,85
	db 221,223,125,223,85,117,213,85,87,85,85,85,85,85,85,85
	db 85,93,117,85,85,85,85,85,85,85,85,213,85,87,93,85
	db 170,170,102,170,170,234,170,171,174,170,170,170,170,170,170,170
	db 170,174,118,102,170,170,170,170,170,170,170,234,170,171,174,170
	db 170,170,102,102,170,234,170,171,174,170,170,170,170,170,170,170
	db 170,174,122,102,170,170,170,170,170,170,170,234,170,171,174,170
	db 85,85,85,85,85,213,85,87,93,85,85,85,85,85,85,85
	db 170,174,153,170,170,170,170,170,170,170,170,234,170,171,174,170
	db 170,170,153,153,170,234,170,171,174,170,170,170,170,170,170,170
	db 170,174,186,153,170,170,170,170,170,170,170,234,170,171,174,170
	db 170,174,186,106,170,170,170,170,170,170,170,234,170,171,174,170
_pano_lake_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,2,3,3,3,4,5,6,7,8,9,10,11,3,12,1
	db 1,2,3,3,3,4,5,6,7,8,9,10,11,3,12,1
	db 13,13,13,13,13,14,15,16,15,15,15,15,17,13,13,13
	db 13,13,13,13,13,14,15,16,15,15,15,15,17,13,13,13
	db 18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18
	db 18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18
	db 13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13
	db 13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13
	db 19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19
	db 19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19
	db 20,21,22,23,24,25,26,20,20,20,20,20,20,20,20,20
	db 20,21,27,23,24,28,29,20,20,20,20,20,20,20,20,20
	db 30,31,32,33,34,35,36,37,38,20,20,39,40,41,42,43
	db 30,31,44,33,34,45,46,47,48,20,20,39,40,49,50,43
	db 51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66
	db 51,52,53,54,55,67,68,69,70,71,61,62,63,64,72,66
	db 73,74,75,76,77,78,73,78,79,80,81,78,73,76,82,78
	db 73,74,75,76,77,78,73,78,79,80,81,78,73,76,82,78
_pano_lake_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,10,0,1,1,1,1,1,0,0,0
	db 0,0,0,0,0,0,10,0,1,1,1,1,1,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
	db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
	db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
	db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
	db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
	db 10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
	db 2,2,11,2,2,11,11,2,2,2,2,2,2,2,2,2
	db 2,2,11,2,2,11,11,2,2,2,2,2,2,2,2,2
	db 12,3,12,3,3,12,11,11,11,2,2,2,2,12,11,2
	db 12,3,12,3,3,12,11,11,11,2,2,2,2,12,11,2
	db 3,3,4,5,5,6,6,6,6,8,7,9,12,3,6,12
	db 3,3,4,5,5,6,6,6,6,8,7,9,12,3,6,12
	db 6,8,8,8,8,6,6,6,8,8,8,6,6,8,8,6
	db 6,8,8,8,8,6,6,6,8,8,8,6,6,8,8,6
	align 2
_pano_lake_pals:
	db 202,8,103,13,137,14,188,14,202,8,103,13,137,14,239,15
	db 202,8,69,9,171,13,205,14,202,8,69,9,134,11,216,6
	db 202,8,163,4,134,11,216,6,202,8,163,4,134,11,120,11
	db 202,8,134,11,216,6,171,13,202,8,163,4,134,11,205,14
	db 202,8,163,4,134,11,171,13,202,8,69,9,134,11,205,14
	db 202,8,137,14,171,14,205,14,202,8,134,11,171,13,205,14
	db 202,8,69,9,134,11,171,13
	align 2
_pano_canyon_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,101,101,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,234,234,174,174,238,238,255,255,255,255,255,255
	db 255,127,255,107,255,105,175,105,167,101,166,102,150,102,154,90
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,254,255,214,255
	db 255,127,255,103,255,102,159,102,155,90,154,90,106,90,106,106
	db 255,127,255,91,255,90,111,90,107,106,105,105,169,105,165,101
	db 239,111,191,111,191,127,190,126,254,126,250,186,251,187,235,187
	db 170,170,170,170,170,170,170,170,234,234,174,174,238,238,255,127
	db 255,255,255,255,255,111,255,102,155,102,154,86,154,90,106,90
	db 170,170,170,170,170,170,170,170,234,234,174,86,85,85,85,85
	db 170,170,170,170,170,170,170,170,234,234,174,174,238,238,255,255
	db 170,170,170,170,169,170,149,170,85,229,85,85,85,85,85,85
	db 86,253,86,213,86,85,86,85,86,85,86,85,86,85,102,85
	db 170,170,170,170,170,170,165,170,213,234,85,173,85,229,85,149
	db 190,126,254,126,250,122,251,123,235,123,239,175,239,175,191,175
	db 255,255,255,255,255,95,255,90,107,90,105,106,105,105,165,105
	db 170,170,170,170,170,170,165,170,213,234,85,173,85,229,85,85
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
	db 85,149,85,253,255,171,170,170,170,170,170,170,170,170,170,170
	db 117,117,117,85,255,255,170,170,170,170,170,170,170,170,170,170
	db 85,85,85,85,255,255,170,170,170,170,170,170,170,170,170,170
	db 254,213,170,255,170,170,170,170,170,170,170,170,170,170,170,170
	db 175,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 93,85,93,85,255,255,170,170,170,170,170,170,170,170,170,170
	db 125,117,125,85,255,255,170,170,170,170,170,170,170,170,170,170
	db 254,85,170,255,170,170,170,170,170,170,170,170,170,170,170,170
_pano_canyon_map:
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
	db 4,5,5,5,5,5,6,5,7,5,5,5,5,5,6,5
	db 8,5,5,5,5,5,6,5,4,5,5,5,5,5,6,5
	db 9,10,11,12,13,14,15,16,17,10,18,12,13,14,15,19
	db 20,10,21,22,13,14,15,16,9,10,11,12,13,14,15,16
	db 23,24,25,26,27,28,29,30,31,32,33,34,27,28,29,35
	db 36,37,38,39,27,28,40,41,23,24,25,26,27,28,29,30
	db 42,43,44,45,46,47,48,49,50,51,52,53,54,47,48,55
	db 56,57,58,59,60,47,48,61,42,43,44,45,46,47,48,49
	db 62,63,64,65,66,67,68,69,62,70,71,72,73,67,68,69
	db 62,74,75,76,77,67,68,69,62,63,64,65,66,67,68,69
	db 78,79,80,80,81,5,5,82,78,83,80,80,81,5,5,82
	db 78,84,80,80,85,5,5,82,78,79,80,80,81,5,5,82
_pano_canyon_map_pal:
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0
	db 0,0,0,0,0,0,2,0,0,0,0,0,0,0,1,0
	db 3,4,0,4,4,5,1,5,3,6,0,4,4,5,1,5
	db 3,4,0,0,4,5,1,5,3,4,0,4,4,5,1,5
	db 3,7,3,0,5,2,3,3,3,7,3,0,5,2,3,3
	db 3,7,3,0,5,2,2,3,3,7,3,0,5,2,3,3
	db 3,3,3,0,3,2,2,3,3,3,3,0,3,2,2,3
	db 3,3,3,0,3,2,2,3,3,3,3,0,3,2,2,3
	db 2,3,3,0,3,8,8,9,2,3,3,0,3,8,8,9
	db 2,3,3,0,3,8,8,9,2,3,3,0,3,8,8,9
	db 10,10,10,10,10,8,8,10,10,10,10,10,10,8,8,10
	db 10,10,10,10,10,8,8,10,10,10,10,10,10,8,8,10
	align 2
_pano_canyon_pals:
	db 156,7,120,8,171,10,191,8,156,7,69,5,171,10,191,8
	db 156,7,69,5,120,8,191,8,156,7,69,5,120,8,171,10
	db 156,7,171,10,191,8,223,10,156,7,69,5,191,8,223,10
	db 156,7,120,8,191,8,223,10,156,7,120,8,171,10,223,10
	db 156,7,69,5,120,8,105,6,156,7,69,5,120,8,139,8
	db 156,7,120,8,105,6,139,8,156,7,142,5,159,6,191,8
	db 156,7,0,0,0,0,0,0
	align 2
_pano_caves_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 102,102,169,169,170,170,170,170,170,170,174,174,234,234,187,187
	db 102,102,173,169,174,170,173,170,253,171,253,175,253,175,253,175
	db 102,102,169,169,170,234,170,234,170,106,174,126,234,122,187,91
	db 102,102,169,169,170,170,170,170,170,170,174,174,254,234,191,187
	db 102,102,169,169,170,170,170,170,170,170,174,174,234,238,251,255
	db 102,102,169,169,170,170,255,175,170,170,174,174,234,234,187,187
	db 85,85,85,85,85,85,255,255,85,85,89,89,149,149,102,102
	db 102,102,169,169,170,170,170,250,170,170,174,174,234,234,187,187
	db 117,85,121,85,122,85,122,85,250,85,250,95,250,159,250,106
	db 153,153,86,90,85,89,85,169,85,169,153,170,149,170,166,170
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 169,89,169,89,169,89,169,105,169,105,169,105,169,169,169,169
	db 255,175,255,171,255,171,255,170,255,170,255,170,255,170,191,170
	db 166,85,166,85,166,85,166,85,166,86,166,86,166,86,166,90
	db 234,251,234,251,234,250,234,250,234,250,234,250,234,250,234,250
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,251,255,251
	db 250,170,250,170,250,170,250,186,254,186,254,186,254,186,254,250
	db 191,169,175,169,171,169,171,169,167,169,167,169,167,169,166,169
	db 170,170,170,170,170,170,85,85,85,85,255,255,170,170,170,170
	db 170,170,170,170,170,170,106,85,85,85,234,255,234,170,234,170
	db 86,85,94,93,218,213,122,119,122,255,106,255,106,255,170,255
	db 254,254,254,254,254,254,254,254,254,255,254,255,254,255,254,255
	db 85,85,85,85,85,85,87,85,87,85,87,85,87,85,85,85
	db 170,170,85,85,85,85,255,255,255,255,255,255,255,255,255,255
	db 85,85,93,85,85,169,119,171,255,107,251,107,251,107,250,107
	db 166,90,166,90,166,170,166,106,166,170,166,170,170,170,170,170
	db 234,250,234,250,234,250,234,250,234,250,234,250,234,254,234,254
	db 165,170,165,174,229,170,117,123,117,123,85,121,85,101,85,101
	db 170,102,110,101,106,85,123,85,127,85,127,85,127,85,95,85
	db 170,170,174,174,234,234,187,187,255,255,255,255,255,255,255,255
	db 85,85,93,93,213,213,119,119,254,255,254,255,254,255,190,255
	db 254,250,254,250,254,250,254,250,254,250,254,251,254,251,254,251
	db 166,169,166,169,166,169,166,169,166,169,166,169,166,169,166,169
	db 170,106,174,110,234,106,187,91,255,95,255,95,255,87,255,87
	db 106,170,110,174,106,234,91,187,95,255,95,255,95,253,95,253
	db 170,253,170,245,170,229,170,229,170,234,170,234,170,106,170,170
	db 254,255,254,255,254,255,254,255,254,255,254,255,254,255,254,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,255,255,223,253,223,253,95,125,95,125,95,125,85,125,85
	db 191,190,190,190,190,190,174,190,174,190,174,190,174,190,174,190
	db 234,254,234,254,234,254,234,254,234,254,234,254,234,254,234,254
	db 85,169,85,170,85,170,89,170,90,170,170,170,170,170,170,170
	db 95,85,95,85,95,85,95,85,87,85,87,85,87,85,87,85
	db 223,255,223,255,221,255,221,255,213,255,213,255,213,253,213,253
	db 186,254,106,254,106,253,106,253,106,237,106,109,106,105,106,105
	db 254,251,254,251,254,251,254,251,254,251,254,255,254,255,254,255
	db 166,169,166,169,170,169,170,169,170,169,170,170,170,170,170,170
	db 223,87,223,85,95,85,95,85,93,85,85,85,85,85,85,85
	db 175,250,171,250,171,186,171,186,171,170,170,170,170,170,170,170
	db 255,254,255,254,255,254,255,254,255,254,255,254,255,254,255,254
	db 170,169,170,169,106,170,106,170,154,170,154,170,166,170,166,170
	db 190,106,174,106,174,106,174,106,174,106,174,106,174,106,174,106
	db 174,190,174,190,174,190,174,190,174,190,174,190,174,190,175,190
	db 255,255,255,255,255,255,255,191,255,191,255,239,255,239,255,251
	db 234,255,234,255,234,255,234,255,234,255,234,255,234,255,234,255
	db 170,154,170,154,170,154,170,154,170,154,170,154,170,170,170,170
	db 85,165,85,165,85,165,85,165,85,165,85,169,85,169,85,169
	db 149,253,149,253,149,249,149,249,149,249,149,121,149,105,149,169
	db 191,190,191,190,191,190,191,190,191,190,191,190,191,190,191,190
	db 170,255,170,255,170,255,170,255,170,255,170,255,234,255,234,255
	db 255,191,255,191,255,191,255,191,250,191,250,175,250,175,250,171
	db 169,170,169,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 174,106,174,106,174,106,174,106,174,106,174,106,174,106,174,106
	db 175,190,175,190,175,254,175,254,175,254,175,254,175,254,175,254
	db 255,251,255,254,255,254,191,255,191,255,239,255,239,255,255,255
	db 234,255,234,255,234,239,234,239,234,251,234,251,234,254,234,254
	db 86,85,86,85,89,85,89,85,89,85,105,85,105,85,105,85
	db 234,254,234,190,234,190,234,190,234,190,234,190,234,190,234,190
	db 191,190,191,190,191,190,191,190,191,190,191,190,191,190,255,190
	db 186,171,186,171,186,171,186,171,186,171,186,171,186,171,186,171
	db 255,254,255,254,255,254,255,254,255,255,255,255,255,255,255,255
	db 175,106,175,106,175,106,175,170,175,170,175,170,175,170,175,170
	db 175,254,175,254,175,254,175,254,175,254,175,254,175,254,175,254
	db 170,255,170,255,218,255,218,255,230,255,230,255,234,255,234,255
	db 190,170,174,170,190,170,190,170,190,170,190,170,190,170,190,170
	db 234,190,234,190,234,190,234,190,234,191,234,191,234,191,234,255
	db 255,191,255,191,255,191,255,191,255,191,255,191,255,191,255,191
	db 186,171,186,171,190,171,190,171,190,171,190,171,190,171,190,171
	db 255,255,255,255,255,255,255,255,255,247,255,119,255,85,255,85
	db 254,255,254,255,254,255,254,255,254,255,254,255,254,255,126,255
	db 170,170,170,170,170,170,166,170,166,170,149,154,149,154,149,86
	db 175,170,175,170,175,170,175,170,175,170,175,170,175,170,175,170
	db 175,254,175,254,175,254,175,254,159,254,159,254,87,126,87,126
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,253,255
	db 234,255,234,255,234,255,234,255,234,255,106,255,106,255,90,253
	db 170,170,170,170,170,170,170,154,170,154,170,86,170,86,170,86
	db 191,170,191,170,191,170,191,170,191,170,191,170,190,170,190,170
	db 234,255,234,255,234,255,234,255,234,191,234,191,234,175,234,175
	db 255,191,255,191,255,191,255,191,255,191,253,191,253,191,245,183
	db 254,255,254,255,254,255,126,255,126,255,94,253,94,253,94,125
	db 170,170,170,170,170,170,170,170,170,170,170,170,166,170,166,170
	db 170,170,170,170,170,170,170,170,170,169,170,169,106,165,106,165
	db 234,255,234,255,234,255,234,255,234,255,234,255,234,255,218,255
	db 190,171,190,171,191,171,189,171,189,171,181,167,245,167,245,149
	db 255,85,125,85,125,85,117,85,117,85,85,85,85,85,85,85
	db 126,255,94,253,93,253,93,125,85,117,85,117,85,85,85,85
	db 85,86,85,86,85,85,85,85,85,85,85,85,85,85,85,85
	db 173,105,173,105,109,101,101,101,101,85,85,85,85,85,85,85
	db 87,94,85,93,85,93,85,85,85,85,85,85,85,85,85,85
	db 253,255,245,247,245,247,245,213,213,213,213,85,85,85,85,85
	db 89,253,89,125,85,117,85,117,85,85,85,85,85,85,85,85
	db 166,85,166,85,149,85,149,85,85,85,85,85,85,85,85,85
	db 125,165,117,165,117,165,85,149,85,149,85,85,85,85,85,85
	db 234,95,218,87,218,87,86,87,86,87,86,85,85,85,85,85
	db 245,183,245,149,213,149,213,149,85,85,85,85,85,85,85,85
	db 86,117,86,117,86,85,86,85,85,85,85,85,85,85,85,85
	db 149,154,149,154,149,86,85,86,85,86,85,85,85,85,85,85
	db 106,165,90,149,90,149,89,85,89,85,85,85,85,85,85,85
	db 218,255,86,127,86,127,86,95,85,93,85,93,85,85,85,85
	db 213,149,213,149,85,85,85,85,85,85,85,85,85,85,85,85
_pano_caves_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,2,3,1,1,4,5,1,6,7,8,9,10,1,1,1
	db 1,2,3,1,1,4,5,1,6,7,8,9,10,1,1,1
	db 11,12,13,11,11,14,15,11,16,11,11,17,18,19,20,11
	db 11,12,13,11,11,14,15,11,16,11,11,17,18,19,20,11
	db 21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,30
	db 21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,30
	db 36,37,38,39,40,11,41,42,43,44,45,46,47,48,49,11
	db 36,37,38,39,40,11,41,42,43,44,45,46,47,48,49,11
	db 50,37,51,52,53,54,55,56,57,58,59,37,38,38,60,61
	db 50,37,51,52,53,54,55,56,57,58,59,37,38,38,60,61
	db 50,37,62,63,64,65,66,38,67,68,69,37,38,38,55,70
	db 50,37,62,63,64,65,66,38,67,68,69,37,38,38,55,70
	db 71,37,38,72,73,11,74,38,75,76,77,37,38,38,55,78
	db 71,37,38,72,73,11,74,38,75,76,77,37,38,38,55,78
	db 79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94
	db 79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94
	db 95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110
	db 95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110
_pano_caves_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,1,0,0,0,0,0,0,0,5,0,6,2,0,0,0
	db 0,1,0,0,0,0,0,0,0,5,0,6,2,0,0,0
	db 0,10,2,0,0,10,8,0,0,0,0,6,3,5,5,0
	db 0,10,2,0,0,10,8,0,0,0,0,6,3,5,5,0
	db 10,8,4,5,10,10,8,5,5,4,10,6,3,4,4,4
	db 10,8,4,5,10,10,8,5,5,4,10,6,3,4,4,4
	db 7,8,2,4,8,1,8,2,7,4,10,8,3,4,7,4
	db 7,8,2,4,8,1,8,2,7,4,10,8,3,4,7,4
	db 6,8,3,8,8,8,8,3,2,11,8,8,2,2,8,6
	db 6,8,3,8,8,8,8,3,2,11,8,8,2,2,8,6
	db 6,8,3,8,8,8,8,2,12,8,8,8,2,2,8,8
	db 6,8,3,8,8,8,8,2,12,8,8,8,2,2,8,8
	db 6,8,2,8,8,1,8,2,8,8,8,8,2,2,8,8
	db 6,8,2,8,8,1,8,2,8,8,8,8,2,2,8,8
	db 9,9,9,8,9,9,9,9,8,8,9,9,9,9,9,9
	db 9,9,9,8,9,9,9,9,8,8,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	align 2
_pano_caves_pals:
	db 168,5,53,5,71,8,90,7,168,5,53,5,71,8,155,7
	db 168,5,71,8,87,4,90,7,168,5,53,5,87,4,90,7
	db 168,5,87,4,90,7,126,5,168,5,71,8,90,7,126,5
	db 168,5,71,8,121,5,155,7,168,5,86,8,155,7,126,5
	db 168,5,53,5,87,4,155,7,168,5,81,3,87,4,155,7
	db 168,5,90,7,155,7,126,5,168,5,87,4,155,7,126,5
	db 168,5,87,4,189,9,126,5
	align 2
_pano_snow_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,101,101,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,253,101,255,171,255,255,255,255,170,170,170,170,170,170
	db 117,87,253,125,255,255,170,170,170,170,85,85,85,85,85,85
	db 85,119,213,253,255,255,170,170,170,170,85,85,85,85,85,85
	db 85,85,101,101,170,234,170,254,170,254,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,93,93,213,213,119,119,255,255,255,255,255,255,255,255
	db 85,85,93,93,213,213,119,119,255,255,255,255,255,255,234,255
	db 85,85,89,89,149,149,102,102,170,170,170,170,170,127,234,127
	db 85,85,85,85,85,85,85,85,85,149,85,149,85,181,85,245
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,171,170,151,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,165,250,213,255
	db 254,255,234,255,170,254,170,250,170,234,170,170,170,170,170,170
	db 85,255,85,255,85,170,85,170,85,170,85,170,85,170,85,170
	db 250,90,250,91,251,91,235,91,239,91,175,91,191,91,191,90
	db 85,85,85,85,85,85,85,85,85,213,85,213,85,229,85,165
	db 186,91,190,90,254,90,254,90,250,91,251,91,235,91,239,91
	db 85,253,85,254,85,254,217,250,245,235,246,171,250,175,235,191
	db 85,85,85,85,85,85,89,89,149,149,102,102,170,170,170,234
	db 85,85,85,85,85,85,89,89,149,149,102,102,170,170,170,170
	db 170,170,170,170,170,170,174,174,234,234,187,187,253,255,253,255
	db 87,170,87,169,87,165,87,149,87,213,87,85,87,85,87,85
	db 213,159,149,153,149,153,149,153,149,153,149,153,149,153,165,153
	db 85,85,85,85,85,85,105,85,106,85,102,89,102,90,90,86
	db 85,170,89,170,89,170,85,170,86,170,90,170,90,170,106,170
	db 254,90,254,90,250,155,251,155,235,155,239,155,175,91,191,90
	db 85,173,85,191,85,255,153,255,181,254,182,254,254,250,254,235
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
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,2,3,4,5,1,1,1,1,1,1,1,1,1
	db 1,1,1,2,3,4,5,1,1,1,1,1,1,1,1,1
	db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	db 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,8,9
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,8,9
	db 10,11,11,11,11,11,11,11,11,11,11,12,13,14,15,16
	db 17,11,11,11,11,11,11,11,11,11,11,12,13,14,15,18
	db 19,20,21,21,21,21,21,21,21,21,22,23,24,25,26,27
	db 28,20,21,21,21,21,21,21,21,21,22,23,24,25,26,29
	db 30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45
	db 46,47,48,49,50,35,36,51,52,39,40,41,42,43,44,53
	db 54,55,56,57,58,59,60,61,62,6,63,64,65,66,67,68
	db 69,70,71,72,73,59,60,74,75,6,63,64,65,66,67,76
	db 77,78,79,80,81,82,83,84,85,86,87,88,83,89,83,90
	db 91,92,93,94,95,82,83,96,97,86,87,88,83,89,83,90
	db 98,99,98,99,98,99,98,99,98,99,98,99,98,99,98,99
	db 98,99,98,99,98,99,98,99,98,99,98,99,98,99,98,99
_pano_snow_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3
	db 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3
	db 4,2,2,2,2,2,2,2,2,2,2,5,5,2,6,6
	db 4,2,2,2,2,2,2,2,2,2,2,5,5,2,6,6
	db 4,4,4,4,4,4,4,4,4,4,7,7,6,6,6,6
	db 4,4,4,4,4,4,4,4,4,4,7,7,6,6,6,6
	db 4,4,6,6,4,6,6,6,4,6,6,6,6,6,6,6
	db 4,4,6,6,4,6,6,6,4,6,6,6,6,6,6,6
	db 4,4,6,6,4,6,6,6,4,2,6,6,6,6,6,6
	db 4,4,6,6,4,6,6,6,4,2,6,6,6,6,6,6
	db 8,8,8,8,8,9,8,8,8,9,10,9,8,9,8,9
	db 8,8,8,8,8,9,8,8,8,9,10,9,8,9,8,9
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	align 2
_pano_snow_pals:
	db 238,15,149,13,183,14,220,15,238,15,183,14,220,15,255,15
	db 238,15,183,14,169,12,218,15,238,15,183,14,218,15,255,15
	db 238,15,218,15,237,15,255,15,238,15,169,12,218,15,255,15
	db 238,15,169,12,237,15,255,15,238,15,169,12,218,15,237,15
	db 238,15,66,3,237,15,255,15,238,15,66,3,169,12,237,15
	db 238,15,66,3,169,12,255,15,238,15,0,0,0,0,0,0
	db 238,15,0,0,0,0,0,0
	align 2
_pano_farm_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,101,101,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,101,101,170,170,170,170,170,170,171,170,255,175,255,175
	db 102,85,85,85,85,85,87,85,95,255,255,255,170,170,170,170
	db 102,102,85,85,95,213,127,245,255,253,255,255,170,170,170,170
	db 102,102,85,85,125,213,255,213,255,255,255,255,170,170,170,170
	db 102,102,85,85,85,85,85,85,253,215,255,255,170,170,170,170
	db 119,119,101,101,170,170,170,170,170,170,170,170,234,255,234,255
	db 119,119,245,101,255,191,255,191,255,171,170,170,170,170,170,170
	db 87,119,253,253,170,170,170,170,170,170,85,85,85,85,85,85
	db 119,119,253,253,170,170,170,170,170,170,85,85,85,85,85,85
	db 119,117,253,253,170,170,170,170,170,170,85,85,85,85,85,85
	db 85,85,101,245,250,255,250,255,170,250,170,170,170,170,170,170
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
	db 255,255,255,255,255,255,253,255,86,255,90,253,90,213,170,85
	db 255,255,255,255,170,254,170,85,106,85,85,85,85,85,85,85
	db 85,85,85,85,86,85,170,170,170,170,169,170,85,85,85,85
	db 170,170,170,170,86,85,85,85,85,85,169,170,170,170,170,170
	db 169,90,170,85,106,85,86,165,85,170,149,170,169,90,170,85
	db 255,85,255,85,255,85,255,85,170,170,170,170,170,170,170,170
	db 255,85,255,85,255,85,255,85,255,255,250,175,170,170,170,170
	db 250,255,233,255,165,255,165,250,149,234,85,170,89,165,106,149
	db 250,170,190,170,165,170,165,170,167,170,175,170,191,170,253,170
	db 175,170,191,170,255,170,85,253,85,85,85,85,255,87,255,255
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
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,1,2,3,4,5,6,7,8,9,10,11,12
	db 1,1,1,1,1,2,3,4,5,6,7,8,9,10,11,12
	db 13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13
	db 13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13
	db 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	db 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
	db 13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13
	db 13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13
	db 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
	db 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
	db 16,16,16,17,18,16,16,16,16,16,16,17,18,16,16,16
	db 16,16,16,17,18,16,16,16,16,16,16,17,18,16,16,16
	db 19,20,21,22,23,16,24,25,19,20,21,22,23,16,24,25
	db 19,20,21,22,23,16,24,25,19,20,21,22,23,16,24,25
	db 26,27,28,29,30,31,32,33,26,27,28,29,30,31,32,33
	db 26,27,28,29,30,31,32,33,26,27,28,29,30,31,32,33
	db 34,35,36,37,38,39,40,41,34,35,36,37,38,39,40,41
	db 34,35,36,37,38,39,40,41,34,35,36,37,38,39,40,41
_pano_farm_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,1,1,2,1,0,0,1,1,1,0
	db 0,0,0,0,0,0,1,1,2,1,0,0,1,1,1,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
	db 3,3,3,5,5,3,3,3,3,3,3,5,5,3,3,3
	db 3,3,3,5,5,3,3,3,3,3,3,5,5,3,3,3
	db 3,3,3,4,5,3,6,7,3,3,3,4,5,3,6,7
	db 3,3,3,4,5,3,6,7,3,3,3,4,5,3,6,7
	db 3,3,3,8,9,3,10,10,3,3,3,8,9,3,10,10
	db 3,3,3,8,9,3,10,10,3,3,3,8,9,3,10,10
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
	align 2
_pano_farm_pals:
	db 203,6,164,14,199,14,222,10,203,6,199,14,222,10,255,14
	db 203,6,164,14,222,10,255,14,203,6,172,3,206,4,239,12
	db 203,6,23,1,43,2,255,15,203,6,23,1,43,2,239,12
	db 203,6,172,3,173,4,239,12,203,6,173,4,206,4,239,12
	db 203,6,43,2,172,3,255,15,203,6,43,2,172,3,239,12
	db 203,6,172,3,173,4,206,4,203,6,199,14,219,13,239,12
	db 203,6,0,0,0,0,0,0
	align 2
_pano_autobahn_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 119,119,253,253,170,170,170,170,85,85,85,85,85,85,85,85
	db 117,117,253,253,255,255,255,255,170,170,170,170,170,170,170,170
	db 85,85,89,89,153,153,170,170,170,170,170,170,186,170,254,170
	db 85,85,89,89,153,153,170,170,170,170,170,170,250,171,250,175
	db 85,85,89,89,153,153,170,170,170,170,170,170,170,170,170,175
	db 85,85,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 87,85,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 119,119,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 117,119,89,89,153,153,170,170,170,170,170,170,170,170,170,170
	db 85,85,89,89,153,153,170,170,170,170,170,170,170,170,171,191
	db 85,85,89,89,153,153,170,170,170,170,170,170,170,254,175,254
	db 85,85,89,89,153,153,170,170,170,170,170,170,170,170,170,234
	db 87,85,125,89,255,159,255,175,170,170,170,170,170,170,170,170
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
	db 85,85,85,85,85,85,89,89,149,149,102,230,234,255,254,255
	db 85,85,85,85,85,85,89,89,149,149,102,102,170,170,170,170
	db 255,85,85,85,85,85,89,89,149,149,102,102,170,170,170,170
	db 255,255,85,85,85,85,89,89,149,149,102,102,170,170,170,170
	db 85,253,85,85,85,85,89,89,149,149,102,102,170,170,170,170
	db 255,255,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 254,255,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
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
	db 255,255,255,255,95,253,86,229,89,149,101,85,149,85,85,86
	db 175,122,175,122,175,122,175,122,95,121,85,213,85,85,85,85
	db 255,255,255,255,159,253,85,214,85,89,86,101,89,149,101,85
	db 255,170,255,170,255,170,255,170,95,169,85,149,85,85,85,85
	db 255,255,255,255,95,253,101,213,149,85,85,86,85,89,86,101
	db 170,254,170,254,170,254,170,254,90,253,85,213,85,85,85,85
	db 170,126,170,126,170,126,170,126,90,125,85,213,85,85,85,85
	db 255,255,255,255,255,255,255,255,95,253,86,229,89,149,101,85
	db 255,255,255,255,255,255,255,255,95,253,101,213,149,85,85,86
	db 149,85,85,86,85,89,86,101,89,149,101,85,149,85,85,86
	db 85,89,86,101,89,149,101,85,149,85,85,86,85,89,86,101
	db 89,149,101,85,149,85,85,86,85,89,86,101,89,149,101,85
_pano_autobahn_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,2,3,4,5,6,7,8,8,8,8,9,10,11,12,13
	db 1,2,3,4,5,6,7,8,8,8,8,9,10,11,12,13
	db 0,14,15,16,17,18,19,20,21,0,0,22,23,24,25,0
	db 0,14,15,16,17,18,19,20,21,0,0,22,23,24,25,0
	db 26,27,28,29,30,31,31,31,32,29,29,29,29,29,29,29
	db 26,27,28,29,30,31,31,31,32,29,29,29,29,29,29,29
	db 33,33,34,35,35,35,35,35,35,35,35,35,35,35,35,35
	db 33,33,34,35,35,35,35,35,35,35,35,35,35,35,35,35
	db 36,36,36,36,37,38,36,36,36,36,36,36,37,38,36,36
	db 36,36,36,36,37,38,36,36,36,36,36,36,37,38,36,36
	db 39,40,41,39,42,43,39,39,39,39,39,39,42,43,39,44
	db 39,40,41,39,42,43,39,39,39,39,39,39,42,43,39,44
	db 45,46,47,48,49,50,51,52,49,53,54,55,49,56,57,0
	db 45,46,47,48,49,50,51,52,49,53,54,55,49,56,57,0
	db 58,59,60,61,62,63,64,65,66,67,60,67,64,68,66,69
	db 58,59,64,61,66,63,62,65,64,67,60,67,62,68,64,70
	db 71,72,73,71,72,73,71,72,73,71,72,73,71,72,73,71
	db 72,73,71,72,73,71,72,73,71,72,73,71,72,73,71,72
_pano_autobahn_map_pal:
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 0,1,2,2,2,1,1,1,1,1,1,1,2,2,2,1
	db 0,1,2,2,2,1,1,1,1,1,1,1,2,2,2,1
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 3,0,4,3,4,4,4,4,4,3,3,3,3,3,3,3
	db 3,0,4,3,4,4,4,4,4,3,3,3,3,3,3,3
	db 4,4,4,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 4,4,4,3,3,3,3,3,3,3,3,3,3,3,3,3
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,6,6,5,5,5,5,5,5,5,5,5,5,5,5,6
	db 5,6,6,5,5,5,5,5,5,5,5,5,5,5,5,6
	db 6,6,6,6,5,7,6,6,5,6,6,6,5,7,6,6
	db 6,6,6,6,5,7,6,6,5,6,6,6,5,7,6,6
	db 8,8,8,8,9,8,9,8,9,8,8,8,9,8,9,10
	db 8,8,9,8,9,8,9,8,9,8,8,8,9,8,9,10
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	align 2
_pano_autobahn_pals:
	db 166,5,168,11,187,12,238,15,166,5,118,9,168,11,187,12
	db 166,5,118,9,168,11,238,15,166,5,168,11,186,12,238,15
	db 166,5,168,11,186,12,187,12,166,5,85,6,186,12,220,13
	db 166,5,152,10,186,12,220,13,166,5,85,6,152,10,220,13
	db 166,5,82,3,152,10,220,13,166,5,82,3,99,4,220,13
	db 166,5,82,3,99,4,152,10,166,5,0,0,0,0,0,0
	db 166,5,0,0,0,0,0,0
	align 2
_pano_seaside_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,169,169,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,169,169,170,170,170,170,170,170,191,170,191,170,170,170
	db 85,85,169,169,170,170,254,171,255,175,255,255,255,255,170,170
	db 85,85,85,85,213,95,255,127,255,255,170,171,250,175,255,127
	db 85,85,169,189,171,255,255,255,255,255,255,255,255,255,255,255
	db 85,85,169,249,170,254,175,255,255,255,255,255,255,255,255,255
	db 85,85,85,85,85,85,85,245,85,253,170,234,170,250,117,253
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,170,255,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,255,255,255,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,234,170,234,170,170,170,170,170,170,170,170,170,170,170,170
	db 170,170,170,170,170,170,170,170,191,170,191,170,170,170,170,170
	db 85,85,87,85,223,127,255,255,170,170,170,170,85,85,85,85
	db 87,253,95,253,255,255,255,255,170,170,170,170,85,85,85,85
	db 85,213,85,245,85,253,255,255,170,170,170,170,85,85,85,85
	db 170,170,170,170,170,170,170,170,170,250,170,250,170,170,170,170
	db 149,149,89,89,153,153,170,170,170,170,170,170,170,170,170,170
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
	db 254,255,254,255,254,223,254,255,254,255,250,255,250,255,170,170
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
	db 254,255,254,127,254,255,254,255,170,170,170,170,170,170,170,170
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
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,2,3,4,5,6,7,1,1,1,1,1,1,1,1
	db 1,1,2,3,4,5,6,7,1,1,1,1,1,1,1,1
	db 8,8,8,9,10,10,10,10,11,8,8,12,13,14,15,16
	db 8,8,8,9,10,10,10,10,11,8,8,12,13,14,15,16
	db 17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17
	db 17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18
	db 18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18
	db 19,20,21,22,23,24,25,26,27,28,8,8,8,8,8,8
	db 19,20,21,22,23,24,25,26,27,28,8,8,8,8,8,8
	db 0,29,0,30,31,32,33,34,35,36,37,38,39,8,40,41
	db 42,29,0,30,31,32,33,34,35,36,37,38,39,8,40,41
	db 0,0,0,0,0,43,44,0,0,45,46,47,48,49,50,51
	db 52,0,0,0,0,43,44,0,0,45,46,47,48,49,50,51
	db 53,54,53,54,53,54,53,54,53,54,53,54,53,54,53,54
	db 53,54,53,54,53,54,53,54,53,54,53,54,53,54,53,54
_pano_seaside_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,1,2,2,1,0,0,0,0,0,0,0,0
	db 0,0,0,0,1,2,2,1,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9
	db 3,3,3,4,5,3,4,3,3,4,3,3,3,3,3,3
	db 3,3,3,4,5,3,4,3,3,4,3,3,3,3,3,3
	db 3,5,3,6,5,6,6,7,6,6,4,3,3,3,3,4
	db 6,5,3,6,5,6,6,7,6,6,4,3,3,3,3,4
	db 3,3,3,3,3,5,5,3,3,5,7,6,5,4,4,6
	db 5,3,3,3,3,5,5,3,3,5,7,6,5,4,4,6
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	align 2
_pano_seaside_pals:
	db 205,10,146,14,180,15,219,15,205,10,180,15,219,15,255,15
	db 205,10,146,14,180,15,255,15,205,10,166,4,235,15,109,3
	db 205,10,235,15,109,3,255,15,205,10,166,4,235,15,255,15
	db 205,10,166,4,109,3,255,15,205,10,132,12,166,4,255,15
	db 205,10,113,12,198,15,255,15,205,10,180,15,216,15,235,15
	db 205,10,0,0,0,0,0,0,205,10,0,0,0,0,0,0
	db 205,10,0,0,0,0,0,0
	align 2
_pano_ruins_tiles:
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,85
	db 85,85,101,101,170,170,170,170,170,170,170,170,170,170,170,170
	db 119,87,101,101,170,170,170,170,170,170,170,170,170,170,170,170
	db 119,119,101,101,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,119,101,101,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,85,85,85,85,85,85,85,85,85,85,95,85,127,85
	db 85,85,85,85,85,85,85,85,253,85,255,85,255,215,255,255
	db 85,85,85,85,85,85,85,85,213,87,245,95,255,255,255,255
	db 85,85,85,85,85,85,85,87,213,95,247,127,255,255,170,186
	db 85,85,85,85,85,85,85,127,215,255,255,255,255,255,170,170
	db 85,85,85,85,85,85,85,245,85,253,95,255,255,255,170,170
	db 85,85,85,85,85,85,85,85,85,85,85,245,85,253,170,170
	db 85,85,85,85,85,85,85,85,90,85,90,85,85,85,85,85
	db 85,85,213,87,247,95,255,127,170,170,170,170,85,85,85,85
	db 85,127,85,255,223,255,255,255,170,170,170,170,85,85,85,85
	db 85,85,85,245,85,253,85,255,169,170,169,170,85,85,85,85
	db 170,170,174,174,234,234,187,187,255,255,255,255,255,255,255,255
	db 255,171,255,175,234,234,187,187,255,255,255,255,255,255,255,255
	db 255,255,255,255,234,234,187,187,255,255,255,255,255,255,255,255
	db 255,255,174,255,234,234,187,187,255,255,255,255,255,255,255,255
	db 255,255,174,174,234,234,187,187,255,255,255,255,255,255,255,255
	db 85,85,85,85,85,85,93,93,213,213,119,119,255,255,255,255
	db 85,85,85,85,85,85,93,93,170,214,170,118,170,254,170,254
	db 85,85,85,85,85,85,93,93,213,165,119,167,255,175,255,175
	db 255,255,255,255,255,255,255,255,249,255,169,86,165,86,85,85
	db 255,255,255,255,218,255,90,245,85,85,85,85,85,85,85,85
	db 255,255,255,255,255,191,255,175,255,166,191,166,159,150,155,154
	db 85,253,85,253,170,254,170,254,170,254,170,254,85,213,85,213
	db 255,95,255,95,255,175,255,175,255,175,255,175,255,85,255,85
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,245,255,213,255,85,255,85,253,85,245
	db 255,255,255,255,127,106,107,106,105,86,169,85,165,85,166,85
	db 255,255,234,255,234,255,234,255,170,170,170,170,170,170,170,170
	db 255,255,255,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 255,255,250,255,106,165,105,165,105,101,105,101,105,101,105,101
	db 255,255,255,255,255,175,255,166,191,166,159,150,154,154,90,154
	db 255,255,255,255,255,255,255,255,255,255,255,255,245,255,85,106
	db 255,255,255,255,255,127,255,111,255,105,191,169,175,169,167,166
	db 255,255,255,255,191,106,155,106,154,86,90,86,106,86,105,86
	db 255,255,213,255,213,255,213,255,85,85,85,85,85,85,85,85
	db 255,255,255,255,255,111,255,105,191,105,175,169,166,166,166,166
	db 255,255,255,255,255,255,255,255,255,255,255,255,245,255,85,154
	db 101,86,101,86,101,86,101,86,101,86,101,86,101,90,101,90
	db 89,85,89,85,89,85,89,85,89,85,89,85,89,149,89,149
	db 90,90,106,106,106,105,175,169,175,169,175,166,175,166,159,150
	db 170,234,170,106,170,106,85,213,255,255,255,255,255,255,255,255
	db 255,85,255,85,255,85,171,85,171,170,171,170,171,170,169,170
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,170,191
	db 255,255,255,255,253,255,245,255,85,255,85,253,85,213,85,85
	db 85,213,85,85,85,85,86,85,86,85,85,85,85,85,86,85
	db 251,107,239,107,239,107,175,107,191,107,190,107,254,106,250,106
	db 170,150,170,150,170,86,85,253,255,255,255,255,255,255,255,255
	db 165,170,165,170,165,170,95,85,255,255,255,255,255,255,255,255
	db 105,101,105,101,105,101,105,229,105,229,105,229,105,229,169,229
	db 106,106,105,105,169,105,169,169,166,166,166,166,150,150,154,154
	db 85,191,85,186,85,250,85,250,85,250,85,234,85,234,85,234
	db 166,166,150,150,154,154,95,90,111,106,111,105,175,169,175,169
	db 170,234,170,170,170,170,85,213,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,170,127
	db 254,106,250,106,251,106,251,107,239,107,239,107,175,107,187,107
	db 170,150,170,150,170,150,85,253,255,255,255,255,255,255,255,255
	db 150,150,154,154,90,154,106,106,105,105,169,105,169,169,166,166
	db 85,239,85,234,85,186,85,186,85,186,85,250,85,250,85,250
	db 101,90,101,86,101,86,101,90,101,90,102,90,101,90,101,170
	db 153,149,153,149,153,149,89,149,89,106,169,105,169,169,169,166
	db 170,85,170,85,170,85,170,85,170,85,170,127,255,127,255,127
	db 85,85,170,170,170,170,170,170,170,170,85,85,255,255,245,255
	db 86,85,170,170,170,170,170,170,170,170,85,85,255,255,127,85
	db 170,234,85,234,85,213,85,213,85,213,85,127,85,255,85,255
	db 255,111,255,105,175,105,166,169,166,166,150,166,154,150,154,154
	db 253,255,245,255,213,255,85,253,85,165,85,165,85,85,85,85
	db 85,85,85,85,85,85,89,85,89,85,89,85,153,85,149,89
	db 86,85,86,85,150,85,150,149,150,149,85,149,85,149,166,150
	db 170,85,170,86,90,86,90,86,90,85,250,87,255,87,255,87
	db 85,85,170,170,170,170,170,170,170,170,85,85,255,255,127,85
	db 85,169,85,169,85,169,85,169,85,169,245,171,245,255,245,255
	db 90,154,106,106,101,105,165,105,101,169,102,165,102,101,86,85
	db 85,186,85,186,85,186,101,250,101,234,149,234,149,234,101,234
	db 255,159,255,154,111,154,105,106,105,105,169,105,166,169,166,166
	db 106,86,170,85,106,85,106,85,106,85,250,87,255,87,255,87
	db 166,166,150,150,150,154,86,154,102,106,101,105,101,105,101,105
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
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,1,2,3,3,4,1,1,1,1,1,1,1
	db 1,1,1,1,1,2,3,3,4,1,1,1,1,1,1,1
	db 0,5,6,7,8,9,10,11,0,0,12,13,14,15,0,0
	db 0,5,6,7,8,9,10,11,0,0,12,13,14,15,0,0
	db 16,17,18,18,19,20,20,20,16,16,16,16,16,16,16,16
	db 16,17,18,18,19,20,20,20,16,16,16,16,16,16,16,16
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 21,21,21,22,23,21,21,21,21,21,21,21,21,21,21,21
	db 21,21,21,22,23,21,21,21,21,21,21,21,21,21,21,21
	db 24,25,26,27,28,29,29,29,29,30,31,32,33,34,35,36
	db 24,25,37,27,28,29,29,29,29,30,38,39,33,34,40,41
	db 42,43,44,45,46,47,29,29,48,49,50,51,52,53,54,55
	db 42,43,56,57,46,58,29,29,48,49,59,60,52,53,61,62
	db 63,64,65,66,67,68,69,70,71,72,73,66,74,75,76,77
	db 63,64,65,66,67,68,78,70,71,72,79,66,74,75,80,81
	db 82,83,84,85,86,87,88,89,90,91,92,85,86,93,94,95
	db 82,83,84,85,86,87,96,89,90,91,92,85,86,93,97,95
_pano_ruins_map_pal:
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
	db 12,12,1,2,2,1,1,1,1,12,1,1,1,9,1,12
	db 12,12,1,2,2,1,1,1,1,12,1,2,1,9,1,12
	db 9,9,3,4,2,1,1,1,12,9,10,4,4,11,1,10
	db 9,9,3,4,2,1,1,1,12,9,10,4,4,11,1,10
	db 9,9,5,4,4,3,1,12,9,9,6,4,4,6,1,10
	db 9,9,5,4,4,3,1,12,9,9,6,4,4,6,1,10
	db 9,9,11,11,9,9,10,9,9,9,11,11,9,11,10,9
	db 9,9,11,11,9,9,10,9,9,9,11,11,9,11,10,9
	align 2
_pano_ruins_pals:
	db 183,5,197,11,202,11,254,14,183,5,147,4,199,6,236,12
	db 183,5,154,7,188,9,236,12,183,5,147,4,199,6,188,9
	db 183,5,103,5,154,7,188,9,183,5,199,6,154,7,188,9
	db 183,5,147,4,154,7,188,9,183,5,217,12,154,7,236,12
	db 183,5,162,10,197,11,217,12,183,5,98,3,147,4,236,12
	db 183,5,98,3,147,4,199,6,183,5,98,3,147,4,188,9
	db 183,5,82,2,199,6,236,12
	align 2
_gfx_pano:
	dd _pano_beach_tiles
	db 96,0
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
	db 72,0
	dd _pano_fields_map
	dd _pano_fields_map_pal
	dd _pano_fields_pals
	db 218,7
	dd _pano_desert_tiles
	db 81,0
	dd _pano_desert_map
	dd _pano_desert_map_pal
	dd _pano_desert_pals
	db 206,10
	dd _pano_autumn_tiles
	db 111,0
	dd _pano_autumn_map
	dd _pano_autumn_map_pal
	dd _pano_autumn_pals
	db 172,6
	dd _pano_alps_tiles
	db 99,0
	dd _pano_alps_map
	dd _pano_alps_map_pal
	dd _pano_alps_pals
	db 201,8
	dd _pano_city_tiles
	db 78,0
	dd _pano_city_map
	dd _pano_city_map_pal
	dd _pano_city_pals
	db 155,7
	dd _pano_lake_tiles
	db 83,0
	dd _pano_lake_map
	dd _pano_lake_map_pal
	dd _pano_lake_pals
	db 202,8
	dd _pano_canyon_tiles
	db 86,0
	dd _pano_canyon_map
	dd _pano_canyon_map_pal
	dd _pano_canyon_pals
	db 156,7
	dd _pano_caves_tiles
	db 111,0
	dd _pano_caves_map
	dd _pano_caves_map_pal
	dd _pano_caves_pals
	db 168,5
	dd _pano_snow_tiles
	db 100,0
	dd _pano_snow_map
	dd _pano_snow_map_pal
	dd _pano_snow_pals
	db 238,15
	dd _pano_farm_tiles
	db 42,0
	dd _pano_farm_map
	dd _pano_farm_map_pal
	dd _pano_farm_pals
	db 203,6
	dd _pano_autobahn_tiles
	db 74,0
	dd _pano_autobahn_map
	dd _pano_autobahn_map_pal
	dd _pano_autobahn_pals
	db 166,5
	dd _pano_seaside_tiles
	db 55,0
	dd _pano_seaside_map
	dd _pano_seaside_map_pal
	dd _pano_seaside_pals
	db 205,10
	dd _pano_ruins_tiles
	db 98,0
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
_song0_v0__9:
	db 244,10,240,5,20,9,22,9,18,9,15,18,17,9,25,18
	db 20,9,22,9,18,9,15,18,17,9,25,18,20,9,22,9
	db 18,9,15,18,17,9,15,9,26,9,25,18,255,18,25,18
	db 20,9,21,9,22,9,18,18,22,9,18,18,22,9,18,54
	db 18,9,20,9,21,9,22,9,18,9,20,9,22,18,17,9
	db 20,18,18,54,20,9,21,9,22,9,18,18,22,9,18,18
	db 22,9,18,63,15,9,25,9,24,9,15,9,18,9,22,18
	db 20,9,18,9,15,9,20,54,20,9,21,9,22,9,18,18
	db 22,9,18,18,22,9,18,54,18,9,20,9,21,9,22,9
	db 18,9,20,9,22,18,17,9,20,18,18,54,18,9,20,9
	db 22,9,18,9,20,9,22,18,18,9,20,9,18,9,22,9
	db 18,9,20,9,22,18,18,9,20,9,18,9,22,9,18,9
	db 20,9,22,18,17,9,20,18,18,54,20,9,21,9,22,9
	db 18,18,22,9,18,18,22,9,18,54,18,9,20,9,21,9
	db 22,9,18,9,20,9,22,18,17,9,20,18,18,54,20,9
	db 21,9,22,9,18,18,22,9,18,18,22,9,18,63,15,9
	db 25,9,24,9,15,9,18,9,22,18,20,9,18,9,15,9
	db 20,54,20,9,21,9,22,9,18,18,22,9,18,18,22,9
	db 18,54,18,9,20,9,21,9,22,9,18,9,20,9,22,18
	db 17,9,20,18,18,54,18,9,20,9,22,9,18,9,20,9
	db 22,18,18,9,20,9,18,9,22,9,18,9,20,9,22,18
	db 18,9,20,9,18,9,22,9,18,9,20,9,22,18,17,9
	db 20,18,42,45,34,9,35,9,36,9,37,18,39,9,37,18
	db 34,9,35,9,36,9,37,18,39,9,37,18,34,9,30,9
	db 25,9,27,9,29,9,30,9,32,9,34,9,32,9,30,9
	db 32,9,25,9,34,9,35,9,37,9,39,9,37,9,34,9
	db 35,9,37,18,39,9,37,18,34,9,35,9,36,9,37,18
	db 39,9,37,18,37,9,39,9,40,9,41,9,41,18,41,18
	db 39,9,36,9,32,9,37,45,34,9,35,9,36,9,37,18
	db 39,9,37,18,34,9,35,9,36,9,37,18,39,9,37,18
	db 34,9,30,9,25,9,27,9,29,9,30,9,32,9,34,9
	db 32,9,30,9,32,9,30,45,25,9,24,9,25,9,30,18
	db 27,9,30,18,27,9,30,9,27,9,25,9,30,9,34,9
	db 37,18,34,9,30,9,25,9,27,18,30,18,34,9,32,18
	db 30,54,46,9,47,9,48,9,49,18,51,9,49,18,46,9
	db 47,9,48,9,49,18,51,9,49,18,46,9,42,9,37,9
	db 39,9,41,9,42,9,44,9,46,9,44,9,42,9,44,9
	db 37,9,46,9,47,9,49,9,51,9,49,9,46,9,47,9
	db 49,18,51,9,49,18,46,9,47,9,48,9,49,18,51,9
	db 49,18,49,9,51,9,40,9,41,9,41,18,41,18,51,9
	db 48,9,44,9,49,45,46,9,47,9,48,9,49,18,51,9
	db 49,18,46,9,47,9,48,9,49,18,51,9,49,18,46,9
	db 42,9,37,9,39,9,41,9,42,9,44,9,46,9,44,9
	db 42,9,44,9,42,45,37,9,36,9,37,9,42,18,39,9
	db 42,18,39,9,42,9,39,9,37,9,42,9,46,9,49,18
	db 46,9,42,9,37,9,39,18,42,18,46,9,44,18,42,18
	db 255,27,30,18,20,9,21,9,22,9,30,18,22,9,30,18
	db 22,9,30,54,30,9,44,9,45,9,46,9,42,9,44,9
	db 46,18,41,9,44,18,42,54,20,9,21,9,22,9,30,18
	db 22,9,30,18,22,9,30,63,39,9,37,9,36,9,39,9
	db 42,9,46,18,44,9,42,9,39,9,44,54,20,9,21,9
	db 22,9,30,18,22,9,30,18,22,9,30,54,42,9,44,9
	db 45,9,46,9,42,9,44,9,46,18,41,9,44,18,42,54
	db 42,9,44,9,46,9,42,9,44,9,46,18,42,9,44,9
	db 42,9,46,9,42,9,44,9,46,18,42,9,44,9,42,9
	db 46,9,42,9,44,9,46,18,41,9,44,18,42,36,42,18
	db 255,18,39,9,38,9,39,36,42,18,44,72,35,9,34,9
	db 35,36,39,18,40,63,37,9,32,18,37,9,32,18,37,9
	db 32,18,30,36,35,36,34,9,38,9,41,9,46,18,44,9
	db 41,9,42,9,39,36,40,36,39,9,38,9,39,36,42,18
	db 44,72,35,9,34,9,35,36,39,18,40,63,37,9,32,18
	db 37,9,32,18,37,9,32,18,30,36,35,27,35,9,39,9
	db 42,18,40,27,40,18,47,18,41,9,42,9,44,9,46,9
	db 47,9,49,9,51,9,50,9,51,36,42,18,44,72,47,9
	db 46,9,47,36,51,18,40,63,49,9,44,18,49,9,44,18
	db 49,9,44,18,42,36,47,36,46,9,50,9,41,9,46,18
	db 44,9,41,9,42,9,51,36,40,36,51,9,50,9,51,36
	db 42,18,44,72,47,9,46,9,47,36,51,18,40,63,49,9
	db 44,18,49,9,44,18,49,9,44,18,42,36,47,27,47,9
	db 51,9,42,18,40,27,40,18,47,18,255,18,47,18,255,18
	db 42,18,39,9,42,18,39,9,42,9,39,9,37,9,42,9
	db 46,9,49,18,46,9,42,9,37,9,39,18,42,18,46,9
	db 44,18,42,45,42,18,255,18,35,18,34,9,35,18,34,9
	db 35,18,255,9,39,9,44,9,39,9,42,9,44,9,42,9
	db 39,9,37,18,36,9,37,18,36,9,37,18,255,9,42,9
	db 46,9,42,9,44,9,46,9,44,9,42,9,44,18,43,9
	db 44,18,43,9,44,18,255,9,47,9,51,9,47,9,49,9
	db 51,9,49,9,47,9,42,9,42,9,42,36,51,18,49,18
	db 37,9,37,9,37,18,37,18,35,18,34,9,35,18,34,9
	db 35,18,255,9,39,9,44,9,39,9,42,9,44,9,42,9
	db 39,9,37,18,36,9,37,18,36,9,37,18,255,9,42,9
	db 46,9,42,9,44,9,46,9,44,9,42,9,39,9,38,9
	db 39,9,49,18,47,18,42,9,46,9,45,9,46,9,51,18
	db 42,9,49,9,46,9,42,18,42,18,46,9,44,18,42,27
	db 37,9,37,9,37,18,37,18,23,18,22,9,23,18,22,9
	db 23,18,255,9,15,9,20,9,15,9,18,9,20,9,18,9
	db 15,9,25,18,24,9,25,18,24,9,25,18,255,9,18,9
	db 22,9,18,9,20,9,22,9,20,9,18,9,20,18,19,9
	db 20,18,19,9,20,18,255,9,23,9,27,9,23,9,25,9
	db 27,9,25,9,23,9,30,9,30,9,30,36,27,18,25,18
	db 25,9,25,9,25,18,25,18,23,18,22,9,23,18,22,9
	db 23,18,255,9,15,9,20,9,15,9,18,9,20,9,18,9
	db 15,9,25,18,24,9,25,18,24,9,25,18,255,9,18,9
	db 22,9,18,9,20,9,22,9,20,9,18,9,15,9,26,9
	db 15,9,25,18,23,18,18,9,22,9,21,9,22,9,27,18
	db 30,9,25,9,22,9,18,18,18,18,22,9,20,18,18,45
	db 30,18,255,240,255,240,255,240,255,234,0
_song0_v1__9:
	db 244,6,240,6,20,9,22,9,18,9,15,18,17,9,13,18
	db 20,9,22,9,18,9,15,18,17,9,13,18,8,9,10,9
	db 6,9,3,18,5,9,3,9,2,9,1,18,255,18,1,18
	db 13,18,6,18,10,18,1,18,13,18,11,18,15,18,10,18
	db 13,18,1,18,10,18,1,18,11,18,6,18,10,18,10,18
	db 13,18,6,18,10,18,1,18,13,18,11,18,15,18,10,18
	db 9,18,8,18,8,18,8,18,12,18,13,18,1,18,3,18
	db 5,18,6,18,10,18,1,18,13,18,11,18,15,18,10,18
	db 13,18,1,18,10,18,1,18,11,18,6,18,10,18,13,18
	db 255,18,6,18,13,18,4,18,13,18,3,18,15,18,2,18
	db 14,18,1,18,13,18,1,18,13,18,6,18,1,18,3,18
	db 5,18,6,18,10,18,1,18,13,18,11,18,15,18,10,18
	db 13,18,1,18,10,18,1,18,11,18,6,18,10,18,10,18
	db 13,18,6,18,10,18,1,18,13,18,11,18,15,18,10,18
	db 9,18,8,18,8,18,8,18,12,18,13,18,1,18,3,18
	db 5,18,6,18,10,18,1,18,13,18,11,18,15,18,10,18
	db 13,18,1,18,10,18,1,18,11,18,6,18,10,18,13,18
	db 255,18,6,18,13,18,4,18,13,18,3,18,15,18,2,18
	db 14,18,1,18,13,18,1,18,13,18,6,18,1,18,6,18
	db 255,18,6,18,13,18,1,18,13,18,6,18,13,18,1,18
	db 13,18,11,18,15,18,11,18,14,18,10,18,13,18,1,18
	db 13,18,6,18,13,18,1,18,13,18,6,18,13,18,10,18
	db 9,18,8,18,13,18,8,18,15,18,13,18,11,18,10,18
	db 8,18,6,18,13,18,1,18,13,18,6,18,13,18,1,18
	db 13,18,11,18,15,18,11,18,14,18,10,18,13,18,6,18
	db 16,18,11,18,11,18,12,18,12,18,13,18,13,18,13,18
	db 13,18,8,18,8,18,13,18,13,18,6,18,1,18,10,18
	db 8,18,6,18,13,18,1,18,13,18,6,18,13,18,1,18
	db 13,18,11,18,15,18,11,18,14,18,10,18,13,18,1,18
	db 13,18,6,18,13,18,1,18,13,18,6,18,13,18,10,18
	db 9,18,8,18,13,18,8,18,15,18,13,18,11,18,10,18
	db 8,18,6,18,13,18,1,18,13,18,6,18,13,18,1,18
	db 13,18,11,18,15,18,11,18,14,18,10,18,13,18,6,18
	db 16,18,11,18,11,18,12,18,12,18,13,18,13,18,13,18
	db 13,18,8,18,8,18,13,18,13,18,18,18,13,18,6,18
	db 255,18,18,18,22,18,13,18,13,18,11,18,15,18,10,18
	db 13,18,13,18,22,18,13,18,11,18,18,18,22,18,22,18
	db 13,18,18,18,22,18,13,18,13,18,11,18,15,18,10,18
	db 9,18,8,18,20,18,20,18,12,18,13,18,13,18,15,18
	db 17,18,18,18,22,18,13,18,13,18,11,18,15,18,10,18
	db 13,18,13,18,22,18,13,18,11,18,18,18,22,18,13,18
	db 255,18,18,18,13,18,16,18,13,18,15,18,15,18,14,18
	db 14,18,13,18,13,18,13,18,13,18,18,18,13,18,6,18
	db 255,18,11,18,15,18,18,18,15,18,16,18,16,18,11,18
	db 16,18,8,18,15,18,15,18,15,18,13,18,16,18,20,18
	db 16,18,16,18,16,18,13,18,14,18,15,18,15,18,20,18
	db 15,18,22,18,17,18,14,18,17,18,15,36,13,18,18,18
	db 11,18,15,18,18,18,15,18,16,18,16,18,11,18,16,18
	db 8,18,15,18,15,18,15,18,13,18,16,18,20,18,16,18
	db 16,18,16,18,13,18,14,18,15,9,11,9,10,9,8,9
	db 7,36,6,18,15,18,18,18,6,18,11,18,255,54,11,36
	db 15,36,18,36,15,36,16,36,16,36,11,36,16,36,8,36
	db 15,36,15,36,15,36,13,36,16,36,20,36,16,36,16,36
	db 16,36,13,36,14,36,15,36,15,36,20,36,15,36,22,36
	db 17,36,14,36,17,36,15,36,13,18,18,18,11,18,15,18
	db 18,18,15,18,16,18,16,18,11,18,16,18,8,18,15,18
	db 15,18,15,18,13,18,16,18,20,18,16,18,16,18,16,18
	db 13,18,14,18,15,9,11,9,10,9,8,9,7,36,6,18
	db 15,18,18,18,6,18,11,18,255,18,11,18,255,18,11,18
	db 11,18,12,18,12,18,13,18,13,18,13,18,13,18,20,18
	db 20,18,13,18,13,18,18,36,6,18,255,18,11,18,11,18
	db 15,18,11,18,11,18,11,18,15,18,11,18,18,18,22,18
	db 13,18,22,18,18,18,22,18,13,18,22,18,13,18,11,18
	db 17,18,11,18,13,18,11,18,20,18,11,18,21,18,21,36
	db 21,18,22,18,255,54,11,18,11,18,15,18,11,18,11,18
	db 11,18,15,18,11,18,18,18,22,18,13,18,22,18,18,18
	db 22,18,13,18,22,18,11,18,8,18,10,18,11,18,13,18
	db 13,18,12,18,13,18,15,18,8,18,13,18,17,18,18,18
	db 255,54,11,36,11,36,15,36,11,36,11,36,11,36,15,36
	db 11,36,18,36,22,36,13,36,22,36,18,36,22,36,13,36
	db 22,36,13,36,11,36,17,36,11,36,13,36,11,36,20,36
	db 11,36,21,36,21,36,21,18,22,18,255,54,11,18,11,18
	db 15,18,11,18,11,18,11,18,15,18,11,18,18,18,22,18
	db 13,18,22,18,18,18,22,18,13,18,22,18,11,18,20,18
	db 22,18,11,18,13,18,13,18,12,18,13,18,15,18,20,18
	db 13,18,17,18,18,18,13,18,18,18,0
_song0_v2__9:
	db 244,6,240,8,255,240,255,12,13,18,17,18,255,18,18,18
	db 13,18,18,18,23,18,18,18,22,18,18,18,255,18,18,18
	db 255,18,17,18,255,18,18,18,18,18,17,18,255,18,18,18
	db 13,18,18,18,23,18,18,18,22,18,21,18,20,18,18,18
	db 255,18,18,18,17,18,13,18,15,18,17,18,255,18,18,18
	db 13,18,18,18,23,18,18,18,22,18,18,18,255,18,18,18
	db 255,18,17,18,255,18,18,18,22,18,255,18,18,18,22,18
	db 16,18,22,18,15,18,23,18,14,18,23,18,13,18,22,18
	db 255,18,17,18,18,18,13,18,15,18,17,18,255,18,18,18
	db 13,18,18,18,23,18,18,18,22,18,18,18,255,18,18,18
	db 255,18,17,18,255,18,18,18,18,18,17,18,255,18,18,18
	db 13,18,18,18,23,18,18,18,22,18,21,18,20,18,18,18
	db 255,18,18,18,17,18,13,18,15,18,17,18,255,18,18,18
	db 13,18,18,18,23,18,18,18,22,18,18,18,255,18,18,18
	db 255,18,17,18,255,18,18,18,22,18,255,18,18,18,22,18
	db 16,18,22,18,15,18,23,18,14,18,23,18,13,18,22,18
	db 255,18,17,18,18,18,13,18,18,18,255,18,18,18,22,18
	db 255,18,22,18,255,18,22,18,255,18,22,18,255,18,23,18
	db 255,18,23,18,255,18,22,18,255,18,22,18,255,18,22,18
	db 255,18,22,18,255,18,22,18,255,54,20,18,255,18,20,18
	db 20,18,23,18,22,18,20,18,18,18,22,18,255,18,22,18
	db 255,18,22,18,255,18,22,18,255,18,23,18,255,18,23,18
	db 255,18,22,18,255,18,22,18,23,18,23,18,21,18,21,18
	db 22,18,22,18,22,18,22,18,18,18,15,18,17,18,17,18
	db 18,18,13,18,22,18,20,18,18,18,22,18,255,18,22,18
	db 255,18,22,18,255,18,22,18,255,18,23,18,255,18,23,18
	db 255,18,22,18,255,18,22,18,255,18,22,18,255,18,22,18
	db 255,18,22,18,255,54,20,18,255,18,20,18,20,18,23,18
	db 22,18,20,18,18,18,22,18,255,18,22,18,255,18,22,18
	db 255,18,22,18,255,18,23,18,255,18,23,18,255,18,22,18
	db 255,18,22,18,23,18,23,18,21,18,21,18,22,18,22,18
	db 22,18,22,18,18,18,15,18,17,18,17,18,30,18,25,18
	db 18,18,255,36,30,18,25,18,30,18,23,18,30,18,22,18
	db 30,18,255,18,30,18,255,18,29,18,255,18,30,18,30,18
	db 29,18,255,18,30,18,25,18,30,18,23,18,30,18,22,18
	db 21,18,20,18,30,18,255,18,30,18,29,18,25,18,27,18
	db 29,18,255,18,30,18,25,18,30,18,23,18,30,18,22,18
	db 30,18,255,18,30,18,255,18,29,18,255,18,30,18,34,18
	db 255,18,30,18,34,18,28,18,34,18,27,18,35,18,26,18
	db 35,18,25,18,34,18,255,18,29,18,30,18,25,18,18,18
	db 255,36,35,18,255,18,35,18,255,18,35,18,255,18,35,18
	db 255,18,35,18,255,18,35,18,255,18,32,18,255,18,32,18
	db 28,18,32,18,25,18,26,18,27,18,35,18,255,18,35,18
	db 255,18,34,18,255,18,34,18,34,36,34,36,255,18,35,18
	db 255,18,35,18,255,18,35,18,255,18,35,18,255,18,35,18
	db 255,18,35,18,255,18,32,18,255,18,32,18,28,18,32,18
	db 25,18,26,18,27,9,23,9,22,9,20,9,19,36,18,18
	db 35,18,30,18,18,18,23,18,255,90,35,36,255,36,35,36
	db 255,36,35,36,255,36,35,36,255,36,35,36,255,36,35,36
	db 255,36,32,36,255,36,32,36,28,36,32,36,25,36,26,36
	db 27,36,35,36,255,36,35,36,255,36,34,36,255,36,34,36
	db 34,36,34,36,255,18,35,18,255,18,35,18,255,18,35,18
	db 255,18,35,18,255,18,35,18,255,18,35,18,255,18,32,18
	db 255,18,32,18,28,18,32,18,25,18,26,18,27,9,23,9
	db 22,9,20,9,19,36,18,18,35,18,30,18,18,18,23,18
	db 255,18,23,18,255,18,35,18,35,18,33,18,33,18,34,18
	db 34,18,34,18,34,18,30,18,27,18,29,18,29,18,30,36
	db 18,18,255,36,27,18,255,18,27,18,255,18,27,18,255,18
	db 27,18,255,18,30,18,255,18,30,18,255,18,30,18,255,18
	db 30,18,255,18,29,18,255,18,29,18,255,18,29,18,255,18
	db 29,18,30,18,30,36,30,18,30,18,255,72,27,18,255,18
	db 27,18,255,18,27,18,255,18,27,18,255,18,30,18,255,18
	db 30,18,255,18,30,18,255,18,30,18,23,18,20,18,22,18
	db 23,18,25,18,34,18,33,18,34,18,27,18,20,18,25,18
	db 29,18,30,18,255,90,39,36,255,36,39,36,255,36,39,36
	db 255,36,39,36,255,36,30,36,255,36,30,36,255,36,30,36
	db 255,36,30,36,255,36,29,36,255,36,29,36,255,36,29,36
	db 255,36,29,36,30,36,30,36,30,18,30,18,255,72,39,18
	db 255,18,39,18,255,18,39,18,255,18,39,18,255,18,30,18
	db 255,18,30,18,255,18,30,18,255,18,30,18,35,18,32,18
	db 34,18,35,18,37,18,34,18,33,18,34,18,39,18,32,18
	db 37,18,29,18,30,18,37,18,30,18,0
_song0_v3__9:
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,3,240,7
	db 6,18,6,9,6,9,6,9,6,9,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,3,240,7,6,18,6,9,6,9
	db 6,9,6,9,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,3,240,7,6,18,6,9,6,9,6,9,6,9,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,3,240,7,6,18
	db 6,9,6,9,6,9,6,9,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,3,240,7,6,18,6,9,6,9,6,9
	db 6,9,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,3
	db 240,7,6,18,6,9,6,9,6,9,6,9,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,3,240,7,6,18,6,9
	db 6,9,6,9,6,9,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,3,240,7,6,18,6,9,6,9,6,9,6,9
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,3,240,7
	db 6,18,6,9,6,9,6,9,6,9,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,3,240,7,6,18,6,9,6,9
	db 6,9,6,9,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,3,240,7,6,18,6,9,6,9,6,9,6,9,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,3,240,7,6,18
	db 6,9,6,9,6,9,6,9,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,3,240,7,6,18,6,9,6,9,6,9
	db 6,9,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,3
	db 240,7,6,18,6,9,6,9,6,9,6,9,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,3,240,7,6,18,6,9
	db 6,9,6,9,6,9,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,3,240,7,6,18,6,9,6,9,6,9,6,9
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,3,240,7
	db 6,18,6,9,6,9,6,9,6,9,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,3,240,7,6,18,6,9,6,9
	db 6,9,6,9,244,1,240,5,3,18,244,2,240,12,5,18
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,18,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,3,240,7,6,18,6,9,6,9,6,9,6,9,244,1
	db 240,5,3,18,244,2,240,12,5,18,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,18,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,244,1,240,5,3,18
	db 244,2,240,12,5,18,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,18,244,1,240,5,3,18,244,3,240,7,6,18
	db 6,9,6,9,6,9,6,9,244,1,240,5,3,18,244,2
	db 240,12,5,18,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,18,244,1,240,5,3,18,244,2,240,12,5,18,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,18,244,1,240,5
	db 3,18,244,2,240,12,5,18,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,18,244,1,240,5,3,18,244,2,240,12
	db 5,18,244,3,240,7,6,9,244,2,240,12,5,9,5,18
	db 244,1,240,5,3,18,244,2,240,12,5,18,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,18,0
_song1_v0__9:
	db 244,10,240,5,255,28,26,10,33,9,26,10,30,9,33,19
	db 25,10,33,9,25,10,28,9,33,48,255,9,26,9,33,10
	db 26,9,30,10,33,19,25,9,33,10,25,9,28,10,33,28
	db 255,10,33,9,255,10,26,9,29,10,34,9,255,9,33,10
	db 255,9,33,10,255,9,26,10,29,9,34,10,255,9,33,10
	db 255,28,26,10,17,9,26,10,255,9,26,10,17,9,26,9
	db 255,10,26,9,29,10,38,9,255,10,38,9,41,10,50,9
	db 50,19,50,19,50,19,50,10,50,19,45,9,47,9,42,10
	db 45,9,47,19,38,19,40,10,41,9,38,10,40,9,42,19
	db 38,10,42,9,38,10,40,19,38,18,255,10,38,28,38,19
	db 38,19,38,10,38,19,33,9,35,10,30,9,33,10,35,19
	db 26,18,28,10,29,9,26,10,28,9,30,19,26,10,30,9
	db 26,10,28,19,26,19,255,28,38,10,45,9,38,9,42,10
	db 45,19,37,9,45,10,37,9,40,10,45,47,255,10,38,9
	db 45,10,38,9,42,10,45,18,37,10,45,9,37,10,40,9
	db 45,29,255,9,45,10,255,9,38,10,41,9,46,10,255,9
	db 45,10,255,9,45,10,255,9,38,9,41,10,46,9,255,10
	db 45,9,255,29,26,9,17,10,26,9,255,10,26,9,29,10
	db 38,9,255,10,38,9,41,10,50,9,255,9,50,10,41,9
	db 50,10,50,19,50,19,50,19,50,9,50,19,45,10,47,9
	db 42,10,45,9,47,19,50,19,40,9,41,10,50,9,40,10
	db 42,19,50,9,42,10,50,9,40,19,50,19,255,10,50,28
	db 50,19,50,19,50,9,50,19,45,10,47,9,42,10,45,9
	db 47,19,38,19,40,10,41,9,38,10,40,9,42,19,38,9
	db 42,10,38,9,40,19,38,19,255,29,49,9,45,10,49,9
	db 40,10,44,19,49,9,43,9,49,10,40,9,42,19,45,10
	db 40,9,45,10,255,9,42,10,50,9,42,10,45,9,47,19
	db 42,10,50,9,42,10,45,9,47,19,42,9,47,19,255,10
	db 45,9,49,10,40,9,43,10,47,19,45,9,49,10,40,9
	db 43,10,47,19,43,9,47,19,255,9,42,10,50,9,42,10
	db 45,9,47,19,42,10,50,9,42,10,45,9,47,19,42,10
	db 47,19,255,9,49,9,45,10,49,9,40,10,44,19,49,9
	db 43,10,49,9,40,10,42,19,45,9,40,10,45,9,255,10
	db 42,9,50,10,42,9,45,9,47,19,42,10,50,19,50,19
	db 49,19,48,19,255,9,35,10,39,9,42,10,47,9,42,10
	db 39,9,35,9,255,10,35,9,40,10,43,9,47,19,43,19
	db 42,19,255,10,42,9,255,10,40,19,33,9,38,19,45,19
	db 45,19,45,19,255,9,49,10,45,9,49,10,40,9,44,19
	db 49,10,43,9,49,10,40,9,42,19,45,9,40,10,45,9
	db 255,10,42,9,50,10,42,9,45,10,47,19,42,9,50,10
	db 42,9,45,10,47,19,42,9,47,19,255,9,45,10,49,9
	db 40,10,43,9,47,19,45,10,49,9,40,10,43,9,47,19
	db 43,10,47,19,255,9,42,10,50,9,42,9,45,10,47,19
	db 42,9,50,10,42,9,45,10,47,19,42,9,47,19,255,10
	db 49,9,45,10,49,9,40,10,44,18,49,10,43,9,49,10
	db 40,9,42,19,45,10,40,9,45,10,255,9,42,10,50,9
	db 42,10,45,9,47,19,42,10,50,18,50,19,49,19,48,19
	db 255,10,47,9,51,10,42,9,47,10,42,9,51,10,47,9
	db 255,10,47,9,40,10,43,9,47,19,43,19,42,19,255,9
	db 42,10,255,9,40,19,45,10,255,9,38,10,42,9,45,10
	db 50,19,255,28,38,9,45,10,38,9,42,10,45,19,37,9
	db 45,10,37,9,40,10,45,47,255,10,38,9,45,9,38,10
	db 42,9,45,19,37,10,45,9,37,10,40,9,45,29,255,9
	db 45,10,255,9,38,10,41,9,46,10,255,9,45,9,255,10
	db 45,9,255,10,38,9,41,10,46,9,255,10,45,9,255,29
	db 26,9,17,10,26,9,255,10,26,9,29,10,38,9,255,9
	db 38,10,41,9,50,10,255,9,50,10,41,9,50,10,50,19
	db 50,19,50,19,50,9,50,19,45,10,47,9,42,9,45,10
	db 47,19,50,19,40,9,41,10,50,9,40,10,42,19,50,9
	db 42,10,50,9,40,19,50,19,255,9,50,29,50,19,50,19
	db 50,9,50,19,45,10,47,9,42,10,45,9,47,19,38,19
	db 40,9,41,10,38,9,40,10,42,19,38,9,42,10,38,9
	db 40,19,38,19,50,19,50,29,50,18,45,10,40,19,50,28
	db 50,19,45,10,40,9,45,10,38,9,43,10,40,9,43,10
	db 47,9,38,10,43,9,47,9,40,10,43,9,47,10,38,19
	db 47,9,40,10,47,9,50,29,50,19,45,9,40,19,50,28
	db 50,19,45,10,40,9,45,10,38,9,43,10,40,9,43,10
	db 47,9,38,10,43,9,47,10,40,9,43,10,47,9,38,19
	db 47,9,39,10,47,9,40,29,40,19,47,9,42,19,40,29
	db 40,19,47,9,42,10,47,9,255,9,45,10,40,9,45,10
	db 48,9,42,19,45,10,40,9,45,10,48,9,42,19,45,10
	db 40,19,43,19,43,18,42,19,40,19,47,10,43,9,45,10
	db 48,19,40,9,47,19,47,10,43,9,45,10,47,19,42,9
	db 45,9,43,19,50,19,47,10,50,9,47,10,50,9,47,10
	db 50,28,50,19,45,10,40,19,50,28,50,19,45,9,40,10
	db 45,9,38,10,43,9,40,10,43,9,47,10,38,9,43,10
	db 47,9,40,10,43,9,47,10,38,18,47,10,40,9,47,10
	db 50,28,50,19,45,10,40,19,50,28,50,19,45,10,40,9
	db 45,9,38,10,43,9,40,10,43,9,47,10,38,9,43,10
	db 47,9,40,10,43,9,47,10,38,19,47,9,39,10,47,9
	db 40,28,40,19,47,10,42,19,40,28,40,19,47,10,42,9
	db 47,10,255,9,45,10,40,9,45,10,48,9,42,19,45,9
	db 40,10,45,9,48,10,42,19,45,9,40,19,43,19,43,19
	db 42,19,40,19,47,9,43,10,45,9,48,19,40,10,47,19
	db 47,9,43,10,45,9,47,19,42,10,45,9,43,19,43,10
	db 47,9,50,9,43,19,255,19,50,19,47,19,50,19,47,19
	db 50,19,40,10,42,19,40,9,50,9,47,10,45,9,47,19
	db 42,48,255,9,45,10,47,9,42,10,45,9,47,19,42,10
	db 45,18,47,10,40,47,255,10,43,9,47,10,40,9,43,10
	db 47,19,42,19,45,9,47,10,42,9,45,9,47,19,42,19
	db 45,10,47,9,42,10,45,9,47,19,45,10,50,19,47,19
	db 50,19,47,18,50,19,40,10,42,19,40,9,50,10,47,9
	db 50,19,47,19,45,10,50,19,42,19,45,9,47,9,42,10
	db 45,9,47,19,38,19,40,10,38,19,38,19,40,9,38,19
	db 40,10,42,9,38,10,40,9,42,19,38,19,40,9,42,10
	db 38,9,255,10,40,19,33,9,38,19,45,19,45,19,45,19
	db 50,19,47,19,50,19,47,19,50,19,40,9,42,19,40,10
	db 50,9,47,10,45,9,47,19,42,47,255,10,45,9,47,10
	db 42,9,45,10,47,19,42,9,45,19,47,10,40,47,255,9
	db 43,10,47,9,40,10,43,9,47,19,42,19,45,10,47,9
	db 42,10,45,9,47,19,42,19,45,9,47,10,42,9,45,10
	db 47,19,45,9,50,19,47,19,50,19,47,19,50,19,40,10
	db 42,18,40,10,50,9,47,10,50,19,47,19,45,9,50,19
	db 42,19,45,10,47,9,42,10,45,9,47,19,38,19,40,9
	db 38,19,38,19,40,10,38,19,40,9,42,10,38,9,40,10
	db 42,19,38,19,40,9,42,9,38,10,255,9,40,19,33,10
	db 26,9,33,10,38,9,255,29,0
_song1_v1__9:
	db 244,6,240,6,9,19,2,19,9,19,9,19,3,19,4,19
	db 9,19,9,19,9,19,2,18,9,19,9,19,3,19,4,19
	db 9,19,9,19,9,19,10,38,9,19,9,19,10,38,9,19
	db 255,19,2,19,255,19,2,19,255,18,14,19,255,19,14,19
	db 255,19,20,19,20,19,20,19,20,19,21,19,21,19,21,19
	db 21,19,22,19,22,19,21,19,21,19,21,19,21,19,14,18
	db 255,19,8,19,8,19,8,19,8,19,9,19,9,19,9,19
	db 9,19,10,19,10,19,9,19,9,19,9,19,9,19,14,19
	db 9,19,2,19,9,18,9,19,3,19,4,19,9,19,9,19
	db 9,19,2,19,9,19,9,19,3,19,4,19,9,19,9,19
	db 9,19,10,38,9,19,9,19,10,37,9,19,255,19,2,19
	db 255,19,2,19,255,19,14,19,255,19,14,19,255,19,20,19
	db 20,19,20,19,20,19,21,19,21,19,21,19,21,18,22,19
	db 22,19,21,19,21,19,21,19,21,19,14,19,255,19,8,19
	db 8,19,8,19,8,19,9,19,9,19,9,19,9,19,10,19
	db 10,19,9,18,9,19,21,19,21,19,14,19,15,19,16,19
	db 21,19,9,19,21,19,16,19,21,19,9,19,13,19,14,19
	db 21,19,9,19,21,19,14,19,21,18,14,19,15,19,16,19
	db 21,19,9,19,21,19,16,19,21,19,16,19,17,19,18,19
	db 21,19,9,19,21,19,14,19,21,19,14,19,15,19,16,18
	db 21,19,9,19,21,19,16,19,21,19,9,19,13,19,14,19
	db 21,19,9,19,21,19,14,19,14,19,13,19,12,19,11,19
	db 11,19,15,19,15,18,16,19,11,19,11,19,11,19,16,19
	db 16,19,9,19,13,19,14,19,21,19,21,19,15,19,16,19
	db 21,19,9,19,21,19,16,19,21,19,9,18,13,19,14,19
	db 21,19,9,19,21,19,14,19,21,19,14,19,15,19,16,19
	db 21,19,9,19,21,19,16,19,21,19,16,19,17,19,18,19
	db 21,18,9,19,21,19,14,19,21,19,14,19,15,19,16,19
	db 21,19,9,19,21,19,16,19,21,19,9,19,13,19,14,19
	db 21,19,9,19,21,19,14,18,14,19,13,19,12,19,11,19
	db 11,19,15,19,15,19,16,19,11,19,11,19,11,19,16,19
	db 16,19,9,19,13,19,14,19,14,19,14,19,9,18,14,19
	db 21,19,21,19,15,19,16,19,21,19,21,19,9,19,14,19
	db 21,19,21,19,15,19,16,19,21,19,21,19,9,19,10,38
	db 9,18,9,19,10,38,9,19,255,19,2,19,255,19,14,19
	db 255,19,14,19,255,19,14,19,255,19,20,19,20,19,20,19
	db 20,19,21,19,21,18,21,19,21,19,22,19,22,19,21,19
	db 21,19,21,19,21,19,14,19,255,19,20,19,20,19,20,19
	db 20,19,21,19,21,19,21,19,21,19,22,18,22,19,21,19
	db 21,19,21,19,21,19,14,19,255,19,9,19,14,19,12,19
	db 14,19,11,19,14,19,9,19,6,19,7,19,14,19,14,19
	db 14,18,11,19,14,19,7,19,8,19,9,19,14,19,12,19
	db 14,19,11,19,14,19,9,19,6,19,7,19,14,19,14,19
	db 14,19,11,19,14,19,7,18,6,19,4,19,16,19,8,19
	db 16,19,11,19,16,19,16,19,16,19,9,19,16,19,12,19
	db 16,19,9,19,16,19,12,19,16,19,13,9,16,19,19,9
	db 22,10,19,9,16,10,13,9,14,19,14,19,16,19,14,19
	db 21,19,21,19,14,19,14,19,19,19,14,19,14,19,8,19
	db 9,19,14,19,12,19,14,19,11,18,14,19,9,19,6,19
	db 7,19,14,19,2,19,14,19,11,19,14,19,7,19,8,19
	db 9,19,14,19,12,19,14,19,11,19,14,19,9,19,6,18
	db 7,19,14,19,2,19,14,19,11,19,14,19,7,19,6,19
	db 4,19,16,19,8,19,16,19,11,19,16,19,4,19,16,19
	db 9,19,16,19,12,18,16,19,9,19,16,19,12,19,16,19
	db 13,10,16,19,19,9,22,10,19,9,16,10,13,9,2,19
	db 14,19,4,19,14,19,9,19,9,19,14,19,14,19,19,19
	db 14,18,7,19,18,19,19,19,14,19,14,19,18,19,19,19
	db 14,19,16,19,17,19,18,19,14,19,14,19,9,19,14,19
	db 21,19,9,19,15,19,16,18,21,19,9,19,15,19,16,19
	db 21,19,9,19,13,19,14,19,21,19,9,19,21,19,14,19
	db 21,19,16,19,18,19,19,19,14,19,14,19,18,18,19,19
	db 14,19,16,19,17,19,18,19,14,19,14,19,9,19,14,19
	db 21,19,9,19,21,19,7,19,7,19,4,19,8,19,9,19
	db 21,19,9,18,10,19,11,19,11,19,13,19,13,19,14,19
	db 21,19,16,19,18,19,19,19,14,19,14,19,18,19,19,19
	db 14,19,16,19,17,19,18,19,14,18,14,19,9,19,14,19
	db 21,19,9,19,15,19,16,19,21,19,9,19,15,19,16,19
	db 21,19,9,19,13,19,14,19,21,19,9,19,21,19,14,18
	db 21,19,16,19,18,19,19,19,14,19,14,19,18,19,19,19
	db 14,19,16,19,17,19,18,19,14,19,14,19,9,19,14,19
	db 21,19,9,19,21,18,7,19,7,19,4,19,8,19,9,19
	db 21,19,9,19,10,19,11,19,11,19,13,19,13,19,14,19
	db 9,19,2,19,0
_song1_v2__9:
	db 244,6,240,8,21,19,14,19,18,19,18,19,15,19,16,19
	db 19,19,19,19,21,19,14,18,18,19,18,19,15,19,16,19
	db 19,19,19,19,21,19,22,38,21,19,21,19,22,38,21,19
	db 255,170,29,19,29,19,29,19,29,19,30,19,30,19,30,19
	db 30,19,29,19,29,19,30,19,30,19,30,19,31,19,30,18
	db 255,19,17,19,17,19,17,19,17,19,18,19,18,19,18,19
	db 18,19,17,19,17,19,18,19,18,19,18,19,19,19,18,19
	db 21,19,14,19,18,18,18,19,15,19,16,19,19,19,19,19
	db 21,19,14,19,18,19,18,19,15,19,16,19,19,19,19,19
	db 21,19,22,38,21,19,21,19,22,37,21,19,255,171,29,19
	db 29,19,29,19,29,19,30,19,30,19,30,19,30,18,29,19
	db 29,19,30,19,30,19,30,19,31,19,30,19,255,19,17,19
	db 17,19,17,19,17,19,18,19,18,19,18,19,18,19,17,19
	db 17,19,18,18,18,19,30,19,31,19,30,19,27,19,28,19
	db 31,19,21,19,31,19,28,19,31,19,21,19,25,19,26,19
	db 30,19,21,19,30,19,26,19,30,18,26,19,27,19,28,19
	db 31,19,21,19,31,19,28,19,31,19,28,19,29,19,30,19
	db 30,19,21,19,30,19,26,19,30,19,26,19,27,19,28,18
	db 31,19,21,19,31,19,28,19,31,19,21,19,25,19,26,19
	db 30,19,21,19,30,19,26,19,26,19,25,19,24,19,23,19
	db 23,19,27,19,27,18,28,19,31,19,31,19,31,19,28,19
	db 28,19,21,19,25,19,26,19,30,19,30,19,27,19,28,19
	db 31,19,21,19,31,19,28,19,31,19,21,18,25,19,26,19
	db 30,19,21,19,30,19,26,19,30,19,26,19,27,19,28,19
	db 31,19,21,19,31,19,28,19,31,19,28,19,29,19,30,19
	db 30,18,21,19,30,19,26,19,30,19,26,19,27,19,28,19
	db 31,19,21,19,31,19,28,19,31,19,21,19,25,19,26,19
	db 30,19,21,19,30,19,26,18,26,19,25,19,24,19,23,19
	db 23,19,27,19,27,19,28,19,31,19,31,19,31,19,28,19
	db 28,19,21,19,25,19,26,19,33,19,33,19,21,18,26,19
	db 30,19,30,19,27,19,28,19,31,19,31,19,21,19,26,19
	db 30,19,30,19,27,19,28,19,31,19,31,19,21,19,22,38
	db 21,18,21,19,22,38,21,19,255,171,29,19,29,19,29,19
	db 29,19,30,19,30,18,30,19,30,19,29,19,29,19,30,19
	db 30,19,30,19,31,19,30,19,255,19,29,19,29,19,29,19
	db 29,19,30,19,30,19,30,19,30,19,29,18,29,19,30,19
	db 30,19,30,19,31,19,30,19,255,19,21,19,36,19,24,19
	db 36,19,23,19,36,19,21,19,18,19,19,19,35,19,26,19
	db 35,18,23,19,35,19,19,19,20,19,21,19,36,19,24,19
	db 36,19,23,19,36,19,21,19,18,19,19,19,35,19,26,19
	db 35,19,23,19,35,19,19,18,18,19,16,19,38,19,20,19
	db 38,19,23,19,38,19,28,19,38,19,21,19,36,19,24,19
	db 36,19,21,19,36,19,24,19,36,19,255,75,26,19,35,19
	db 255,19,32,19,31,19,31,19,30,19,30,19,31,19,35,19
	db 35,19,20,19,21,19,24,19,24,19,24,19,23,18,24,19
	db 21,19,18,19,19,19,23,19,14,19,23,19,23,19,23,19
	db 19,19,20,19,21,19,24,19,24,19,24,19,23,19,24,19
	db 21,19,18,18,19,19,23,19,14,19,23,19,23,19,23,19
	db 19,19,18,19,16,19,26,19,20,19,26,19,23,19,26,19
	db 16,19,26,19,21,19,24,19,24,18,24,19,21,19,24,19
	db 24,19,24,19,255,76,14,19,23,19,255,19,20,19,19,19
	db 19,19,18,19,18,19,31,19,26,18,19,19,30,19,31,19
	db 35,19,35,19,30,19,31,19,35,19,28,19,29,19,30,19
	db 33,19,33,19,21,19,26,19,30,19,21,19,27,19,28,18
	db 31,19,21,19,27,19,28,19,31,19,21,19,25,19,26,19
	db 30,19,21,19,30,19,26,19,30,19,28,19,30,19,31,19
	db 35,19,35,19,30,18,31,19,35,19,28,19,29,19,30,19
	db 33,19,33,19,21,19,26,19,30,19,21,19,30,19,19,19
	db 19,19,16,19,20,19,21,19,30,19,21,18,22,19,23,19
	db 23,19,25,19,25,19,26,19,30,19,28,19,30,19,31,19
	db 35,19,35,19,30,19,31,19,35,19,28,19,29,19,30,19
	db 33,18,33,19,21,19,26,19,30,19,21,19,27,19,28,19
	db 31,19,21,19,27,19,28,19,31,19,21,19,25,19,26,19
	db 30,19,21,19,30,19,26,18,30,19,28,19,30,19,31,19
	db 35,19,35,19,30,19,31,19,35,19,28,19,29,19,30,19
	db 33,19,33,19,21,19,26,19,30,19,21,19,30,18,19,19
	db 19,19,16,19,20,19,21,19,30,19,21,19,22,19,23,19
	db 23,19,25,19,25,19,26,19,21,19,14,19,0
_song1_v3__9:
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,10,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,10,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,10,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,10,5,19,244,1,240,5,3,18,244,3,240,7
	db 6,19,6,10,6,9,6,10,6,9,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,10,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,10,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,10
	db 5,18,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,10,5,19
	db 244,1,240,5,3,19,244,3,240,7,6,19,6,9,6,10
	db 6,9,6,10,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,10,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,10,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,18,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,3,240,7,6,19,6,10,6,9,6,9,6,10,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,10,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,10
	db 5,19,244,1,240,5,3,18,244,2,240,12,5,19,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,10,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,10,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,10,5,18,244,1,240,5,3,19,244,3,240,7,6,19
	db 6,10,6,9,6,10,6,9,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,10,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,10,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,10,5,19,244,1
	db 240,5,3,19,244,3,240,7,6,19,6,9,6,10,6,9
	db 6,10,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,10,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,10,5,19,244,1,240,5,3,18,244,2,240,12,5,19
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,3
	db 240,7,6,19,6,9,6,10,6,9,6,10,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,10,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,10,5,18
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,10,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,10,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,3,240,7,6,19,6,10
	db 6,9,6,10,6,9,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,10,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,10,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,10,5,19,244,1,240,5
	db 3,19,244,3,240,7,6,19,6,9,6,10,6,9,6,10
	db 244,1,240,5,3,18,244,2,240,12,5,19,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,10,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,10,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,10
	db 5,18,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,3,240,7
	db 6,19,6,9,6,10,6,9,6,10,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,10,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,10,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,10,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,18,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,3,240,7,6,19,6,10,6,9
	db 6,10,6,9,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,10,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,10
	db 5,19,244,1,240,5,3,18,244,2,240,12,5,19,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,10,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,10,5,19,244,1,240,5,3,19
	db 244,3,240,7,6,19,6,9,6,10,6,9,6,9,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,10,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,10,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,3,240,7,6,19
	db 6,9,6,10,6,9,6,10,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,10
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,10,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,10,5,19,244,1,240,5,3,18,244,2,240,12,5,19
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,3,240,7,6,19,6,10,6,9,6,10
	db 6,9,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,10,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,10,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,10,5,18
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,10,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,10,5,19,244,1,240,5,3,19,244,3
	db 240,7,6,19,6,9,6,9,6,10,6,9,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,10,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,10,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,3,240,7,6,19,6,9
	db 6,10,6,9,6,10,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,10,5,19
	db 244,1,240,5,3,18,244,2,240,12,5,19,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,10,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,10,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,10
	db 5,18,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,3,240,7,6,19,6,10,6,9,6,10,6,9
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,10,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,10,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,10,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,10,5,19,244,1,240,5,3,19,244,3,240,7
	db 6,18,6,10,6,9,6,10,6,9,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,10,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,10
	db 5,19,244,1,240,5,3,18,244,2,240,12,5,19,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,10,5,19
	db 244,1,240,5,3,19,244,3,240,7,6,19,6,9,6,10
	db 6,9,6,10,0
_song2_v0__9:
	db 244,10,240,5,25,9,23,19,21,10,20,9,19,9,20,10
	db 18,9,16,9,18,10,20,9,23,47,25,9,25,19,24,10
	db 25,9,15,9,16,19,18,19,23,37,23,19,25,9,23,19
	db 21,10,20,9,19,9,20,10,18,9,16,9,18,10,20,9
	db 23,19,16,9,20,19,25,9,23,19,21,10,20,9,19,9
	db 20,10,21,9,23,19,23,9,20,9,23,10,20,9,23,19
	db 16,9,16,19,16,10,16,18,16,10,16,18,20,10,16,9
	db 20,9,23,10,22,9,23,10,25,9,15,9,23,19,15,10
	db 25,18,15,10,23,28,15,9,16,9,18,10,20,9,21,10
	db 23,9,25,9,23,19,21,10,20,9,19,9,20,10,18,9
	db 16,9,18,10,20,9,23,19,16,9,20,19,25,9,23,19
	db 21,10,20,9,19,9,20,10,21,9,23,19,23,9,20,9
	db 23,10,20,9,23,19,16,9,16,19,16,10,16,18,16,10
	db 16,18,20,10,16,9,23,9,20,10,23,9,25,10,16,9
	db 22,19,21,19,15,28,20,46,20,10,21,9,23,19,25,9
	db 23,19,21,10,20,9,19,9,20,10,18,9,16,9,18,10
	db 20,9,23,19,16,9,20,19,25,9,23,19,21,10,20,9
	db 19,9,20,10,21,9,23,19,23,9,20,9,23,10,20,9
	db 23,19,16,9,16,19,16,10,16,18,16,10,16,18,20,10
	db 16,9,20,9,23,10,22,9,23,10,25,9,15,9,23,19
	db 15,10,25,18,15,10,23,28,15,9,16,9,18,10,20,9
	db 21,10,23,9,25,9,23,19,21,10,20,9,19,9,20,10
	db 18,9,16,9,18,10,20,9,23,19,16,9,20,19,25,9
	db 23,19,21,10,20,9,19,9,20,10,21,9,23,19,23,9
	db 20,9,23,10,20,9,23,19,16,9,16,19,16,10,16,18
	db 16,10,16,18,20,10,16,9,23,9,20,10,23,9,25,10
	db 16,9,16,38,18,9,20,19,16,28,23,9,22,9,23,10
	db 24,9,25,10,26,9,15,9,27,19,25,10,25,18,15,10
	db 27,18,25,10,25,18,27,19,25,19,25,9,25,19,23,10
	db 23,18,25,10,25,18,23,10,23,18,25,19,23,19,23,9
	db 35,19,21,10,33,18,20,10,32,18,21,10,33,18,32,19
	db 30,19,18,9,30,19,16,10,28,18,25,19,23,19,23,9
	db 22,9,23,10,24,9,25,10,26,9,15,9,27,19,25,10
	db 25,18,15,10,27,18,25,10,25,18,27,19,25,19,25,9
	db 25,19,23,10,23,18,25,10,25,18,23,10,23,18,25,19
	db 23,19,24,9,24,19,16,10,28,18,24,19,23,9,23,19
	db 22,9,22,19,23,19,21,9,30,19,23,10,32,18,30,19
	db 28,19,23,9,22,9,23,10,24,9,25,10,26,9,27,9
	db 39,19,25,10,37,18,27,10,39,18,25,10,37,18,39,19
	db 37,19,25,9,37,19,23,10,35,18,25,10,37,18,23,10
	db 35,18,37,19,35,19,35,9,47,19,33,10,45,18,32,10
	db 44,18,33,10,45,18,44,19,42,19,30,9,42,19,28,10
	db 40,18,37,19,35,19,23,9,22,9,23,10,24,9,25,10
	db 26,9,27,9,39,19,25,10,37,18,27,10,39,18,25,10
	db 37,18,39,19,37,19,25,9,37,19,23,10,35,18,25,10
	db 37,18,23,10,35,18,37,19,35,19,24,9,36,19,28,10
	db 40,18,36,19,23,9,35,19,22,9,34,19,35,19,33,9
	db 42,19,35,10,44,18,42,19,40,19,40,9,42,9,44,10
	db 45,9,47,19,49,9,47,19,45,10,44,9,43,9,44,10
	db 42,9,40,9,42,10,44,9,47,19,40,9,44,19,49,9
	db 47,19,45,10,44,9,43,9,44,10,45,9,47,19,47,9
	db 44,9,47,10,44,9,47,19,40,9,40,19,40,10,40,18
	db 40,10,40,18,44,10,40,9,44,9,47,10,46,9,47,10
	db 49,9,39,9,35,19,39,10,37,18,39,10,35,28,27,9
	db 28,9,30,10,32,9,33,10,35,9,37,9,35,19,33,10
	db 32,9,31,9,32,10,30,9,28,9,30,10,32,9,35,19
	db 40,9,44,19,37,9,35,19,33,10,32,9,31,9,32,10
	db 33,9,35,19,35,9,32,9,35,10,32,9,35,19,28,9
	db 40,19,28,10,40,18,28,10,40,18,44,10,40,9,35,9
	db 32,10,35,9,37,10,40,9,46,19,45,19,51,28,44,84
	db 49,9,48,19,49,47,49,9,48,19,49,47,45,9,47,19
	db 48,19,47,9,45,19,49,37,50,10,42,9,40,10,50,9
	db 49,9,48,19,49,28,45,19,45,9,44,19,44,28,40,19
	db 48,28,48,10,48,18,48,19,49,37,44,38,49,9,48,19
	db 49,47,49,9,48,19,49,47,45,9,47,19,48,19,47,9
	db 45,19,49,56,40,19,40,9,50,19,42,19,41,9,42,19
	db 42,9,40,19,49,19,45,9,49,19,49,9,47,19,42,19
	db 40,9,49,19,45,19,40,9,42,9,44,10,45,9,47,10
	db 48,9,49,9,48,19,49,47,49,9,48,19,49,47,45,9
	db 47,19,48,19,47,9,45,19,49,37,50,10,42,9,40,10
	db 50,9,49,9,48,19,49,28,45,19,45,9,44,19,44,28
	db 40,19,48,28,48,10,48,18,48,19,49,37,44,38,49,9
	db 48,19,49,47,49,9,48,19,49,47,45,9,47,19,48,19
	db 47,9,45,19,49,56,40,19,40,9,50,19,42,19,41,9
	db 42,19,42,9,40,19,49,19,45,9,49,19,49,9,47,19
	db 42,19,40,9,49,19,45,47,44,9,45,10,47,9,48,9
	db 48,19,48,56,45,10,48,9,41,9,45,10,48,19,45,9
	db 49,9,49,19,49,56,49,10,40,9,45,9,47,10,49,28
	db 42,9,40,19,50,19,49,9,47,19,46,9,47,19,47,19
	db 49,9,50,19,42,9,40,19,49,19,47,9,45,19,48,9
	db 49,19,49,19,44,9,45,10,47,9,48,9,48,19,48,56
	db 45,10,48,9,41,9,45,10,48,19,45,9,49,9,49,19
	db 49,56,49,10,40,9,45,9,47,10,49,28,49,9,49,19
	db 47,10,47,9,45,9,47,19,49,9,49,19,40,9,40,10
	db 45,9,49,19,40,9,50,19,49,19,47,9,49,19,45,47
	db 44,9,45,10,47,9,48,9,48,19,48,56,45,10,48,9
	db 41,9,45,10,48,19,45,9,49,9,49,19,49,56,49,10
	db 40,9,45,9,47,10,49,28,42,9,40,19,50,19,49,9
	db 47,19,46,9,47,19,47,19,49,9,50,19,42,9,40,19
	db 49,19,47,9,45,19,48,9,49,19,49,19,44,9,45,10
	db 47,9,48,9,48,19,48,56,45,10,48,9,41,9,45,10
	db 48,19,45,9,49,9,49,19,49,56,49,10,40,9,45,9
	db 47,10,49,28,37,9,37,19,35,10,47,9,45,9,47,19
	db 37,9,37,19,40,9,40,10,45,9,49,19,40,9,50,19
	db 49,19,47,9,49,19,33,37,45,19,0
_song2_v1__9:
	db 244,6,240,6,13,9,11,19,21,10,20,9,19,9,20,10
	db 18,9,16,9,18,10,20,9,11,47,13,9,13,19,12,10
	db 13,9,15,9,16,19,18,19,11,37,11,19,16,19,11,19
	db 11,18,11,19,16,19,11,18,11,19,11,19,16,19,11,19
	db 11,18,11,19,16,19,20,18,11,19,14,19,13,38,12,37
	db 11,19,11,18,8,19,7,19,6,19,15,19,6,18,16,19
	db 11,19,18,18,15,19,11,19,16,19,11,19,11,18,11,19
	db 16,19,11,18,11,19,11,19,16,19,11,19,11,18,11,19
	db 16,19,20,18,11,19,14,19,13,38,12,37,11,19,11,18
	db 11,19,11,19,13,19,12,19,11,37,16,19,255,37,11,19
	db 4,19,11,19,11,18,11,19,4,19,11,18,11,19,11,19
	db 4,19,11,19,11,18,11,19,4,19,8,18,11,19,14,19
	db 1,38,12,37,11,19,11,18,8,19,7,19,6,19,15,19
	db 6,18,16,19,11,19,6,18,3,19,11,19,4,19,11,19
	db 11,18,11,19,4,19,11,18,11,19,11,19,4,19,11,19
	db 11,18,11,19,4,19,8,18,11,19,14,19,1,38,12,37
	db 11,19,11,18,11,19,11,19,13,19,12,19,11,37,16,19
	db 255,37,17,19,18,19,11,19,11,18,11,19,18,19,11,18
	db 11,19,11,19,16,19,11,19,11,18,11,19,16,19,11,18
	db 11,19,11,19,15,19,11,19,11,18,11,19,15,19,11,18
	db 11,19,11,19,16,19,11,19,16,18,22,19,11,19,255,37
	db 17,19,18,19,11,19,11,18,11,19,18,19,11,18,11,19
	db 11,19,16,19,11,19,11,18,11,19,16,19,11,18,11,19
	db 11,19,9,19,12,19,12,18,9,19,8,19,11,18,7,19
	db 8,19,11,19,11,19,11,18,11,19,16,19,255,37,17,19
	db 18,19,11,19,11,18,11,19,18,19,11,18,11,19,11,19
	db 16,19,11,19,11,18,11,19,16,19,11,18,11,19,11,19
	db 15,19,11,19,11,18,11,19,15,19,11,18,11,19,11,19
	db 16,19,11,19,16,18,22,19,11,19,255,37,17,19,18,19
	db 11,19,11,18,11,19,18,19,11,18,11,19,11,19,16,19
	db 11,19,11,18,11,19,16,19,11,18,11,19,11,19,9,19
	db 12,19,12,18,9,19,8,19,11,18,7,19,8,19,11,19
	db 11,19,11,18,11,19,16,19,255,37,11,19,16,19,11,19
	db 11,18,11,19,16,19,11,18,11,19,11,19,16,19,11,19
	db 11,18,11,19,16,19,20,18,11,19,14,19,13,38,12,37
	db 11,19,11,18,20,19,19,19,18,19,15,19,18,18,16,19
	db 11,19,18,18,15,19,11,19,16,19,11,19,11,18,11,19
	db 16,19,11,18,11,19,11,19,16,19,11,19,11,18,11,19
	db 16,19,20,18,11,19,14,19,13,38,12,37,11,19,11,18
	db 11,19,11,19,13,19,12,19,11,37,16,19,11,18,16,38
	db 9,19,18,19,16,9,21,9,16,10,13,9,9,19,18,18
	db 16,10,21,9,16,10,13,9,2,38,2,37,9,37,16,38
	db 9,19,6,19,4,9,9,9,6,19,8,19,13,18,16,10
	db 13,9,8,19,8,38,8,37,1,19,8,9,1,9,4,38
	db 9,19,6,19,4,9,9,9,4,10,1,9,9,19,6,18
	db 4,10,9,9,4,10,1,9,2,38,2,37,9,9,1,10
	db 4,9,9,9,4,19,1,19,2,38,2,18,3,19,4,37
	db 4,38,4,19,4,19,4,18,4,19,9,19,255,18,4,38
	db 9,19,6,19,4,9,9,9,4,10,1,9,9,19,6,18
	db 4,10,9,9,4,10,1,9,2,38,2,37,9,37,4,38
	db 9,19,6,19,4,9,9,9,6,19,8,19,1,18,4,10
	db 1,9,8,19,8,38,8,37,1,19,8,9,1,9,4,38
	db 9,19,6,19,4,9,9,9,4,10,1,9,9,19,6,18
	db 4,10,9,9,4,10,1,9,2,38,2,37,9,9,1,10
	db 4,9,9,9,4,19,1,19,2,38,2,18,3,19,4,37
	db 4,38,4,19,4,19,4,18,4,19,9,19,1,18,4,19
	db 9,19,5,19,7,19,9,18,12,19,5,19,12,18,9,19
	db 5,19,4,19,9,19,11,18,1,19,4,19,1,18,9,19
	db 4,19,8,19,2,19,4,18,2,19,4,19,2,18,4,19
	db 2,19,9,19,1,19,4,18,1,19,9,19,1,18,1,19
	db 255,19,5,19,7,19,9,18,12,19,5,19,12,18,9,19
	db 5,19,4,19,9,19,11,18,1,19,4,19,1,18,9,19
	db 4,19,2,19,6,19,9,18,2,19,4,19,9,18,1,19
	db 4,19,11,19,2,19,4,18,2,19,9,19,1,18,4,19
	db 9,19,5,19,7,19,9,18,12,19,5,19,12,18,9,19
	db 5,19,4,19,9,19,11,18,1,19,4,19,1,18,9,19
	db 4,19,8,19,2,19,4,18,2,19,4,19,2,18,4,19
	db 2,19,9,19,1,19,4,18,1,19,9,19,1,18,1,19
	db 255,19,5,19,7,19,9,18,12,19,5,19,12,18,9,19
	db 5,19,4,19,9,19,11,18,1,19,4,19,1,18,9,19
	db 4,19,2,19,6,19,9,18,2,19,4,19,9,18,1,19
	db 4,19,11,19,2,19,4,18,2,19,9,19,4,18,9,19
	db 0
_song2_v2__9:
	db 244,6,240,8,255,240,255,79,32,19,255,18,32,19,255,19
	db 32,18,255,19,32,19,255,19,32,19,255,18,32,19,255,75
	db 37,19,33,19,36,18,33,19,35,19,32,18,32,19,31,19
	db 30,19,35,19,30,18,34,19,35,19,255,75,32,19,255,18
	db 32,19,255,19,32,18,255,19,32,19,255,19,32,19,255,18
	db 32,19,255,75,37,19,33,19,36,18,33,19,35,19,32,18
	db 35,19,32,19,37,19,36,19,35,37,28,19,255,37,35,19
	db 255,19,32,19,255,18,32,19,255,19,32,18,255,19,32,19
	db 255,19,32,19,255,18,32,19,255,75,25,19,33,19,24,18
	db 33,19,23,19,32,18,20,19,19,19,18,19,35,19,18,18
	db 34,19,23,19,255,75,32,19,255,18,32,19,255,19,32,18
	db 255,19,32,19,255,19,32,19,255,18,32,19,255,75,25,19
	db 33,19,24,18,33,19,23,19,32,18,23,19,32,19,37,19
	db 36,19,35,37,28,19,255,37,29,19,30,19,33,19,35,18
	db 33,19,30,19,33,18,35,19,33,19,28,19,32,19,35,18
	db 32,19,28,19,32,18,35,19,32,19,39,19,33,19,35,18
	db 33,19,39,19,33,18,35,19,33,19,28,19,32,19,28,18
	db 31,19,32,19,255,37,29,19,30,19,33,19,35,18,33,19
	db 30,19,33,18,35,19,33,19,28,19,32,19,35,18,32,19
	db 28,19,32,18,35,19,32,19,33,19,33,19,36,18,33,19
	db 32,19,32,18,31,19,32,19,35,19,33,19,35,18,33,19
	db 28,19,255,37,29,19,30,19,33,19,35,18,33,19,30,19
	db 33,18,35,19,33,19,28,19,32,19,35,18,32,19,28,19
	db 32,18,35,19,32,19,39,19,33,19,35,18,33,19,39,19
	db 33,18,35,19,33,19,28,19,32,19,28,18,31,19,32,19
	db 255,37,29,19,30,19,33,19,35,18,33,19,30,19,33,18
	db 35,19,33,19,28,19,32,19,35,18,32,19,28,19,32,18
	db 35,19,32,19,33,19,33,19,36,18,33,19,32,19,32,18
	db 31,19,32,19,35,19,33,19,35,18,33,19,28,19,255,37
	db 35,19,255,19,32,19,255,18,32,19,255,19,32,18,255,19
	db 32,19,255,19,32,19,255,18,32,19,255,75,37,19,33,19
	db 36,18,33,19,35,19,32,18,32,19,31,19,30,19,35,19
	db 30,18,34,19,35,19,255,75,32,19,255,18,32,19,255,19
	db 32,18,255,19,32,19,255,19,32,19,255,18,32,19,255,75
	db 37,19,33,19,36,18,33,19,35,19,32,18,35,19,32,19
	db 37,19,36,19,35,37,28,75,255,150,26,19,33,19,26,18
	db 33,19,21,9,28,10,33,9,37,9,255,188,20,19,32,19
	db 20,18,32,19,32,37,255,188,14,19,21,19,14,18,21,19
	db 255,75,14,19,21,19,255,37,16,19,16,18,16,19,16,19
	db 255,75,21,19,255,18,14,38,255,150,14,19,21,19,14,18
	db 21,19,21,9,16,10,21,9,13,9,255,188,20,19,20,19
	db 20,18,20,19,20,37,255,188,14,19,21,19,14,18,21,19
	db 255,75,14,19,21,19,255,37,16,19,16,18,16,19,16,19
	db 255,75,21,19,255,240,255,116,20,19,20,19,16,18,20,19
	db 16,19,20,18,16,19,20,19,21,19,21,19,16,18,21,19
	db 21,19,21,18,16,19,255,240,255,229,23,19,20,19,16,18
	db 20,19,21,19,255,240,255,116,20,19,20,19,16,18,20,19
	db 16,19,20,18,16,19,20,19,21,19,21,19,16,18,21,19
	db 21,19,21,18,16,19,255,240,255,229,23,19,20,19,16,18
	db 20,19,21,19,255,37,0
_song2_v3__9:
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,18,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,3,240,7
	db 6,18,6,10,6,9,6,10,6,9,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,18,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,18,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,3,240,7,6,18,6,10,6,9
	db 6,10,6,9,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,18,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,3,240,7,6,18,6,10,6,9,6,10,6,9,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,18,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,18,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,18,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,3,240,7,6,18
	db 6,10,6,9,6,10,6,9,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,18,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,18,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,3,240,7,6,18,6,10,6,9,6,10
	db 6,9,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,18,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,18,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,3
	db 240,7,6,18,6,10,6,9,6,10,6,9,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,18,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,18,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,3,240,7,6,18,6,10
	db 6,9,6,10,6,9,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,18,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,18,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,3,240,7,6,18,6,10,6,9,6,10,6,9
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,18,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,3,240,7
	db 6,18,6,10,6,9,6,10,6,9,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,18,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,18,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,3,240,7,6,18,6,10,6,9
	db 6,10,6,9,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,18,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,3,240,7,6,18,6,10,6,9,6,10,6,9,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,18,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,18,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,18,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,3,240,7,6,18
	db 6,10,6,9,6,10,6,9,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,18,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,18,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,3,240,7,6,18,6,10,6,9,6,10
	db 6,9,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,18,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,18,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,3
	db 240,7,6,18,6,10,6,9,6,10,6,9,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,18,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,18,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,3,240,7,6,18,6,10
	db 6,9,6,10,6,9,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,18,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,18,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,3,240,7,6,18,6,10,6,9,6,10,6,9
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,18,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,3,240,7
	db 6,18,6,10,6,9,6,10,6,9,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,18,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,18,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,3,240,7,6,18,6,10,6,9
	db 6,10,6,9,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,0
_song3_v0__9:
	db 244,10,240,5,45,9,47,10,49,9,47,28,40,19,47,9
	db 49,10,50,9,49,28,40,19,42,9,42,19,41,10,42,9
	db 44,9,45,19,40,19,40,28,49,9,50,10,51,9,40,19
	db 45,19,44,18,42,19,40,9,45,19,44,19,42,9,40,10
	db 49,9,40,19,45,19,44,18,42,19,40,9,44,19,42,19
	db 40,9,47,10,49,9,50,19,44,19,42,18,40,19,50,9
	db 44,19,42,19,40,9,44,10,47,9,50,19,50,37,51,19
	db 40,47,49,9,50,10,51,9,40,19,45,19,44,18,42,19
	db 40,9,45,19,44,19,42,9,40,10,49,9,49,19,49,37
	db 47,19,45,19,42,9,44,9,45,10,255,9,42,19,47,19
	db 47,19,48,18,48,19,49,9,49,19,40,9,50,19,49,19
	db 49,9,49,19,45,10,47,9,45,9,47,19,45,47,49,9
	db 50,10,51,9,40,19,45,19,44,18,42,19,40,9,45,19
	db 44,19,42,9,40,10,49,9,40,19,45,19,44,18,42,19
	db 40,9,44,19,42,19,40,9,47,10,49,9,50,19,44,19
	db 42,18,40,19,50,9,44,19,42,19,40,9,44,10,47,9
	db 50,19,50,37,51,19,40,47,49,9,50,10,51,9,40,19
	db 45,19,44,18,42,19,40,9,45,19,44,19,42,9,40,10
	db 49,9,49,19,49,37,47,19,45,19,42,9,44,9,45,10
	db 255,9,42,19,47,19,47,19,48,18,48,19,49,9,49,19
	db 40,9,50,19,49,19,49,9,49,19,45,10,47,9,45,9
	db 47,19,45,56,255,38,47,19,49,18,47,19,255,19,42,18
	db 44,19,42,19,255,19,40,19,51,18,49,19,49,9,47,10
	db 46,9,47,19,49,9,47,19,255,19,45,19,45,18,44,19
	db 44,9,42,10,41,9,42,19,47,9,47,19,255,19,44,19
	db 44,18,42,19,42,9,40,10,51,9,40,19,47,9,47,19
	db 255,19,47,19,49,18,47,19,255,19,42,18,44,19,42,19
	db 255,19,40,19,51,18,49,19,49,9,47,10,46,9,47,19
	db 44,9,45,10,47,9,49,9,45,10,49,9,51,19,49,19
	db 45,9,47,9,44,10,47,9,49,19,47,19,40,9,44,9
	db 44,19,44,10,42,9,40,9,42,19,40,56,255,38,47,19
	db 49,18,47,19,255,19,42,18,44,19,42,19,255,19,40,19
	db 51,18,49,19,49,9,47,10,46,9,47,19,49,9,47,19
	db 255,19,45,19,45,18,44,19,44,9,42,10,41,9,42,19
	db 47,9,47,19,255,19,44,19,44,18,42,19,42,9,40,10
	db 51,9,40,19,47,9,47,19,255,19,47,19,49,18,47,19
	db 255,19,42,18,44,19,42,19,255,19,40,19,51,18,49,19
	db 49,9,47,10,46,9,47,19,44,9,45,10,47,9,49,9
	db 45,10,49,9,51,19,49,19,45,9,47,9,44,10,47,9
	db 49,19,47,19,40,9,44,9,44,19,44,10,42,9,40,9
	db 42,19,40,37,40,38,40,19,45,19,44,18,42,19,40,9
	db 45,19,44,19,42,9,40,10,37,9,40,19,45,19,44,18
	db 42,19,40,9,44,19,42,19,40,9,35,10,37,9,38,19
	db 44,19,42,18,40,19,38,9,44,19,42,19,40,9,44,10
	db 47,9,50,19,50,37,51,19,40,47,37,9,38,10,39,9
	db 16,19,21,19,20,18,18,19,16,9,21,19,20,19,18,9
	db 16,10,25,9,25,19,25,37,23,19,21,19,30,9,32,9
	db 33,10,255,9,18,19,23,19,23,19,24,18,24,19,25,9
	db 25,19,28,9,26,19,25,19,25,9,25,19,21,10,23,9
	db 21,9,23,19,21,37,21,19,255,19,21,9,18,10,21,9
	db 26,10,18,9,21,19,26,9,18,9,15,10,18,9,19,19
	db 18,19,15,9,18,19,16,9,18,19,16,9,26,10,23,9
	db 18,19,16,9,18,19,16,9,26,10,23,9,19,38,16,9
	db 19,19,25,9,19,37,16,10,19,19,23,9,18,19,18,9
	db 18,19,18,19,18,9,18,19,18,9,18,38,26,4,18,5
	db 21,9,18,10,21,9,26,10,18,9,21,19,26,9,18,9
	db 15,10,18,9,19,19,18,19,15,9,18,19,16,9,18,19
	db 16,9,26,10,23,9,18,19,16,9,18,19,16,9,26,10
	db 23,9,19,38,16,9,19,19,25,9,21,9,25,10,23,9
	db 25,9,19,10,25,19,26,103,21,18,21,19,26,10,18,9
	db 33,9,30,10,33,9,26,10,30,9,33,19,26,9,30,9
	db 27,10,30,9,31,19,30,19,27,9,30,19,28,9,30,19
	db 28,9,26,10,23,9,30,19,28,9,30,19,28,9,26,10
	db 23,9,31,38,28,9,31,19,25,9,31,37,28,10,31,19
	db 23,9,30,19,30,9,30,19,30,19,30,9,30,19,30,9
	db 30,38,26,4,30,5,33,9,30,10,33,9,26,10,30,9
	db 33,19,26,9,30,9,27,10,30,9,31,19,30,19,27,9
	db 30,19,28,9,30,19,28,9,26,10,23,9,30,19,28,9
	db 30,19,28,9,26,10,23,9,31,38,28,9,31,19,25,9
	db 21,9,25,10,23,9,25,9,31,10,25,19,26,9,26,94
	db 255,18,26,19,21,19,25,9,16,19,18,10,19,18,25,10
	db 23,9,21,19,21,37,21,19,26,9,18,19,19,10,21,18
	db 26,10,23,9,21,19,21,37,21,19,23,9,23,19,23,19
	db 26,9,28,10,26,9,30,19,30,28,33,9,32,10,30,9
	db 28,9,25,10,30,9,28,10,26,9,20,19,28,9,21,19
	db 255,18,33,19,21,19,25,9,16,19,18,10,19,18,25,10
	db 23,9,21,19,21,37,21,19,26,9,18,19,19,10,21,18
	db 26,10,23,9,21,19,21,37,21,19,23,9,23,19,35,19
	db 38,9,37,10,35,9,33,19,33,28,33,9,30,10,28,9
	db 26,19,26,19,28,9,28,19,21,9,26,19,33,9,33,9
	db 33,19,21,19,25,9,28,19,30,10,31,18,37,10,35,9
	db 33,19,33,37,21,19,26,9,30,19,31,10,33,18,38,10
	db 35,9,33,19,33,37,33,19,35,9,35,19,35,19,38,9
	db 40,10,38,9,42,19,42,28,45,9,44,10,42,9,40,9
	db 37,10,42,9,40,10,38,9,32,19,40,9,33,19,255,18
	db 45,19,21,19,25,9,28,19,30,10,31,18,37,10,35,9
	db 33,19,33,37,21,19,26,9,30,19,31,10,33,18,38,10
	db 35,9,33,19,33,37,33,19,35,9,35,19,47,19,50,9
	db 49,10,47,9,45,19,45,28,45,9,42,10,40,9,38,19
	db 38,19,40,9,40,19,33,9,38,37,50,19,0
_song3_v1__9:
	db 244,6,240,6,9,9,11,10,13,9,11,28,4,19,11,9
	db 13,10,14,9,13,28,4,19,6,9,6,19,5,10,6,9
	db 8,9,9,19,4,19,4,37,255,19,9,19,13,19,4,18
	db 13,19,9,19,13,18,4,19,13,19,9,19,13,19,4,18
	db 13,19,11,19,14,18,4,19,14,19,11,19,14,19,4,18
	db 14,19,11,19,14,18,4,19,14,19,11,19,16,19,12,18
	db 12,19,13,19,16,18,16,19,255,19,9,19,13,19,4,18
	db 13,19,9,19,13,18,4,19,13,19,5,19,13,19,1,18
	db 13,19,6,19,13,18,13,19,255,19,2,38,3,37,4,19
	db 13,18,6,19,13,19,11,19,11,19,16,18,16,19,9,19
	db 13,18,13,19,255,19,9,19,13,19,4,18,13,19,9,19
	db 13,18,4,19,13,19,9,19,13,19,4,18,13,19,11,19
	db 14,18,4,19,14,19,11,19,14,19,4,18,14,19,11,19
	db 14,18,4,19,14,19,11,19,16,19,12,18,12,19,13,19
	db 16,18,16,19,255,19,9,19,13,19,4,18,13,19,9,19
	db 13,18,4,19,13,19,5,19,13,19,1,18,13,19,6,19
	db 13,18,13,19,255,19,2,38,3,37,4,19,13,18,6,19
	db 13,19,11,19,11,19,16,18,16,19,21,19,16,18,9,19
	db 11,19,18,19,11,19,11,18,11,19,18,19,11,18,11,19
	db 11,19,16,19,11,19,11,18,11,19,16,19,11,18,11,19
	db 11,19,18,19,11,19,11,18,11,19,18,19,11,18,11,19
	db 11,19,16,19,11,19,11,18,11,19,16,19,11,18,11,19
	db 11,19,18,19,11,19,11,18,11,19,18,19,11,18,11,19
	db 11,19,16,19,11,19,11,18,11,19,16,19,11,18,20,19
	db 11,19,9,19,9,19,11,18,11,19,8,19,8,18,9,19
	db 8,19,6,19,6,19,11,18,11,19,16,19,11,18,11,19
	db 11,19,18,19,11,19,11,18,11,19,18,19,11,18,11,19
	db 11,19,16,19,11,19,11,18,11,19,16,19,11,18,11,19
	db 11,19,18,19,11,19,11,18,11,19,18,19,11,18,11,19
	db 11,19,16,19,11,19,11,18,11,19,16,19,11,18,11,19
	db 11,19,18,19,11,19,11,18,11,19,18,19,11,18,11,19
	db 11,19,16,19,11,19,11,18,11,19,16,19,11,18,20,19
	db 11,19,9,19,9,19,11,18,11,19,8,19,8,18,9,19
	db 8,19,6,19,6,19,11,18,11,19,16,19,11,18,4,38
	db 21,19,13,19,16,18,13,19,21,19,13,18,16,19,13,19
	db 21,19,13,19,16,18,13,19,11,19,14,18,16,19,14,19
	db 11,19,14,19,16,18,14,19,11,19,14,18,16,19,14,19
	db 11,19,16,19,12,18,12,19,13,19,16,18,16,19,255,19
	db 21,19,13,19,16,18,13,19,21,19,13,18,16,19,13,19
	db 17,19,13,19,13,18,13,19,18,19,13,18,13,19,255,19
	db 14,38,15,37,16,19,13,18,18,19,13,19,11,19,11,19
	db 16,18,16,19,21,19,16,18,9,19,255,19,14,19,21,19
	db 9,18,21,19,15,19,15,18,11,19,11,19,8,19,8,19
	db 4,18,4,19,11,19,11,18,4,19,4,19,9,19,21,19
	db 13,18,21,19,16,19,21,18,9,19,21,19,14,19,21,19
	db 9,18,21,19,14,19,21,18,9,19,21,19,14,19,21,19
	db 9,18,21,19,15,19,15,18,11,19,11,19,8,19,8,19
	db 4,18,4,19,11,19,11,18,4,19,4,19,9,19,21,19
	db 13,18,21,19,16,19,21,18,9,19,21,19,14,19,9,9
	db 11,19,9,9,11,10,13,9,14,19,255,56,14,19,21,19
	db 9,18,21,19,15,19,15,18,11,19,11,19,8,19,8,19
	db 4,18,4,19,11,19,11,18,4,19,4,19,9,19,21,19
	db 13,18,21,19,16,19,21,18,9,19,21,19,14,19,21,19
	db 9,18,21,19,14,19,21,18,9,19,21,19,14,19,21,19
	db 9,18,21,19,15,19,15,18,11,19,11,19,8,19,8,19
	db 4,18,4,19,11,19,11,18,4,19,4,19,9,19,21,19
	db 13,18,21,19,16,19,21,18,9,19,21,19,14,19,21,19
	db 11,9,21,19,18,9,14,19,255,18,14,19,255,19,16,19
	db 21,19,21,18,21,19,13,19,21,18,21,19,21,19,14,19
	db 21,19,21,18,21,19,14,19,21,18,18,19,21,19,19,19
	db 11,19,19,18,22,19,14,19,21,18,15,19,12,19,16,19
	db 13,19,16,18,11,19,21,19,13,9,16,9,21,19,255,19
	db 16,19,21,19,21,18,21,19,13,19,21,18,21,19,21,19
	db 14,19,21,19,21,18,21,19,14,19,21,18,18,19,21,19
	db 19,19,11,19,20,18,11,19,21,19,21,18,21,19,22,19
	db 11,19,11,19,21,18,13,19,14,19,255,56,16,19,21,19
	db 21,18,21,19,13,19,21,18,21,19,21,19,14,19,21,19
	db 21,18,21,19,14,19,21,18,18,19,21,19,19,19,11,19
	db 19,18,22,19,14,19,21,18,15,19,12,19,16,19,13,19
	db 16,18,11,19,21,19,13,9,16,9,21,19,255,19,16,19
	db 21,19,21,18,21,19,13,19,21,18,21,19,21,19,14,19
	db 21,19,21,18,21,19,14,19,21,18,18,19,21,19,19,19
	db 11,19,20,18,11,19,21,19,21,18,21,19,22,19,11,19
	db 11,19,21,18,13,19,14,19,21,18,14,19,0
_song3_v2__9:
	db 244,6,240,8,255,240,255,79,21,19,255,18,21,19,255,19
	db 21,18,255,19,21,19,255,19,21,19,255,18,21,19,255,19
	db 20,18,255,19,20,19,255,19,20,19,255,18,20,19,255,19
	db 20,18,255,19,20,19,255,19,20,19,255,18,21,19,255,19
	db 21,18,21,19,255,38,21,19,255,18,21,19,255,19,21,18
	db 255,19,21,19,255,19,23,19,255,18,23,19,255,19,21,18
	db 21,19,255,19,14,38,15,37,16,19,21,18,255,19,22,19
	db 21,19,21,19,20,18,20,19,21,19,21,18,21,19,255,38
	db 21,19,255,18,21,19,255,19,21,18,255,19,21,19,255,19
	db 21,19,255,18,21,19,255,19,20,18,255,19,20,19,255,19
	db 20,19,255,18,20,19,255,19,20,18,255,19,20,19,255,19
	db 20,19,255,18,21,19,255,19,21,18,21,19,255,38,21,19
	db 255,18,21,19,255,19,21,18,255,19,21,19,255,19,23,19
	db 255,18,23,19,255,19,21,18,21,19,255,19,14,38,15,37
	db 16,19,21,18,255,19,22,19,21,19,21,19,20,18,20,19
	db 33,19,28,18,21,19,255,38,33,19,255,18,33,19,255,19
	db 33,18,255,19,33,19,255,19,32,19,255,18,32,19,255,19
	db 32,18,255,19,32,19,255,19,33,19,255,18,33,19,255,19
	db 33,18,255,19,33,19,255,19,32,19,255,18,32,19,255,19
	db 32,18,255,19,32,19,255,19,33,19,255,18,33,19,255,19
	db 33,18,255,19,33,19,255,19,32,19,255,18,32,19,255,19
	db 32,18,255,19,32,19,21,19,21,19,23,18,23,19,20,19
	db 20,18,21,19,20,19,18,19,18,19,23,18,23,19,28,19
	db 28,18,28,19,255,38,33,19,255,18,33,19,255,19,33,18
	db 255,19,33,19,255,19,32,19,255,18,32,19,255,19,32,18
	db 255,19,32,19,255,19,33,19,255,18,33,19,255,19,33,18
	db 255,19,33,19,255,19,32,19,255,18,32,19,255,19,32,18
	db 255,19,32,19,255,19,33,19,255,18,33,19,255,19,33,18
	db 255,19,33,19,255,19,32,19,255,18,32,19,255,19,32,18
	db 255,19,32,19,21,19,21,19,23,18,23,19,20,19,20,18
	db 21,19,20,19,18,19,18,19,23,18,23,19,28,19,23,18
	db 16,38,255,19,33,19,255,18,33,19,255,19,33,18,255,19
	db 33,19,255,19,33,19,255,18,33,19,255,19,32,18,255,19
	db 32,19,255,19,32,19,255,18,32,19,255,19,32,18,255,19
	db 32,19,255,19,32,19,255,18,33,19,255,19,33,18,33,19
	db 255,38,33,19,255,18,33,19,255,19,33,18,255,19,33,19
	db 255,19,35,19,255,18,35,19,255,19,33,18,33,19,255,19
	db 26,38,27,37,28,19,33,18,255,19,34,19,33,19,33,19
	db 32,18,32,19,33,19,28,18,21,19,255,19,26,19,30,19
	db 21,18,30,19,27,19,27,18,23,19,23,19,20,19,20,19
	db 16,18,16,19,23,19,23,18,16,19,16,19,21,19,31,19
	db 25,18,31,19,28,19,31,18,21,19,31,19,26,19,30,19
	db 21,18,30,19,26,19,30,18,21,19,30,19,26,19,30,19
	db 21,18,30,19,27,19,27,18,23,19,23,19,20,19,20,19
	db 16,18,16,19,23,19,23,18,16,19,16,19,21,19,31,19
	db 25,18,31,19,28,19,31,18,21,19,28,19,26,19,21,9
	db 23,19,21,9,23,10,25,9,26,19,255,56,26,19,30,19
	db 21,18,30,19,27,19,27,18,23,19,23,19,20,19,20,19
	db 16,18,16,19,23,19,23,18,16,19,16,19,21,19,31,19
	db 25,18,31,19,28,19,31,18,21,19,31,19,26,19,30,19
	db 21,18,30,19,26,19,30,18,21,19,30,19,26,19,30,19
	db 21,18,30,19,27,19,27,18,23,19,23,19,20,19,20,19
	db 16,18,16,19,23,19,23,18,16,19,16,19,21,19,31,19
	db 25,18,31,19,28,19,31,18,21,19,28,19,38,19,33,19
	db 35,9,33,19,30,9,26,19,255,18,26,19,255,19,28,19
	db 31,19,33,18,31,19,37,19,31,18,33,19,31,19,38,19
	db 30,19,33,18,30,19,255,19,30,18,255,19,30,19,255,19
	db 31,19,255,18,31,19,255,19,30,18,255,19,33,19,255,19
	db 33,19,255,18,32,19,33,19,37,9,28,9,33,19,255,19
	db 28,19,31,19,33,18,31,19,37,19,31,18,33,19,31,19
	db 38,19,30,19,33,18,30,19,255,19,30,18,255,19,30,19
	db 255,19,31,19,255,18,29,19,255,19,30,18,33,19,34,19
	db 35,19,35,19,33,18,37,19,38,19,255,56,28,19,31,19
	db 33,18,31,19,37,19,31,18,33,19,31,19,38,19,30,19
	db 33,18,30,19,255,19,30,18,255,19,30,19,255,19,31,19
	db 255,18,31,19,255,19,30,18,255,19,33,19,255,19,33,19
	db 255,18,32,19,33,19,37,9,28,9,33,19,255,19,28,19
	db 31,19,33,18,31,19,37,19,31,18,33,19,31,19,38,19
	db 30,19,33,18,30,19,255,19,30,18,255,19,30,19,255,19
	db 31,19,255,18,29,19,255,19,30,18,33,19,34,19,35,19
	db 35,19,33,18,37,19,38,19,33,18,38,19,0
_song3_v3__9:
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,18,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,3,240,7
	db 6,18,6,10,6,9,6,10,6,9,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,18,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,18,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,3,240,7,6,18,6,10,6,9
	db 6,10,6,9,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,18,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,3,240,7,6,18,6,10,6,9,6,10,6,9,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,18,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,18,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,18,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,3,240,7,6,18
	db 6,10,6,9,6,10,6,9,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,18,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,18,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,3,240,7,6,18,6,10,6,9,6,10
	db 6,9,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,18,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,18,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,3
	db 240,7,6,18,6,10,6,9,6,10,6,9,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,18,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,18,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,3,240,7,6,18,6,10
	db 6,9,6,10,6,9,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,18,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,18,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,3,240,7,6,18,6,10,6,9,6,10,6,9
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,18,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,3,240,7
	db 6,18,6,10,6,9,6,10,6,9,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,18,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,18,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,3,240,7,6,18,6,10,6,9
	db 6,10,6,9,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,18,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,3,240,7,6,18,6,10,6,9,6,10,6,9,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,18,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,18,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,18,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,3,240,7,6,18
	db 6,10,6,9,6,10,6,9,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,18,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,18,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,3,240,7,6,18,6,10,6,9,6,10
	db 6,9,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,18,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,18,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,3
	db 240,7,6,18,6,10,6,9,6,10,6,9,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,18,244,3,240,7,6,10,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,18,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,3,240,7,6,18,6,10
	db 6,9,6,10,6,9,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,2,240,12,5,18,244,3,240,7
	db 6,10,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,18,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,3,240,7,6,18,6,10,6,9,6,10,6,9
	db 244,1,240,5,3,19,244,2,240,12,5,19,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,19,244,1,240,5,3,19
	db 244,2,240,12,5,18,244,3,240,7,6,10,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,19,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,3,240,7
	db 6,18,6,10,6,9,6,10,6,9,244,1,240,5,3,19
	db 244,2,240,12,5,19,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,19,244,1,240,5,3,19,244,2,240,12,5,18
	db 244,3,240,7,6,10,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,19,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,18,244,3,240,7,6,10,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,19,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,19,244,1,240,5
	db 3,19,244,2,240,12,5,18,244,3,240,7,6,10,244,2
	db 240,12,5,9,5,19,244,1,240,5,3,19,244,2,240,12
	db 5,19,244,3,240,7,6,9,244,2,240,12,5,9,5,19
	db 244,1,240,5,3,19,244,3,240,7,6,18,6,10,6,9
	db 6,10,6,9,244,1,240,5,3,19,244,2,240,12,5,19
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,19,244,1
	db 240,5,3,19,244,2,240,12,5,18,244,3,240,7,6,10
	db 244,2,240,12,5,9,5,19,244,1,240,5,3,19,244,2
	db 240,12,5,19,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,19,244,1,240,5,3,19,244,2,240,12,5,18,244,3
	db 240,7,6,10,244,2,240,12,5,9,0
_song4_v0__9:
	db 255,240,0
_song4_v1__9:
	db 255,240,0
_song4_v2__9:
	db 255,240,0
_song4_v3__9:
	db 255,240,0
_song5_v0__9:
	db 244,10,240,4,37,14,42,14,46,28,44,14,42,14,37,28
	db 39,14,42,14,47,28,46,14,42,14,39,28,41,14,44,14
	db 49,28,47,14,44,14,41,28,42,56,37,28,42,28,46,14
	db 42,14,39,28,42,14,46,14,51,28,47,14,46,14,44,14
	db 42,14,39,28,42,28,44,14,41,14,37,14,41,14,44,28
	db 47,28,46,56,42,56,0
_song5_v1__9:
	db 244,6,240,6,6,14,18,14,6,14,18,14,6,14,18,14
	db 6,14,18,14,11,14,23,14,11,14,23,14,11,14,23,14
	db 11,14,23,14,1,14,13,14,1,14,13,14,1,14,13,14
	db 1,14,13,14,6,14,18,14,6,14,18,14,6,14,18,14
	db 6,14,18,14,3,14,15,14,3,14,15,14,3,14,15,14
	db 3,14,15,14,11,14,23,14,11,14,23,14,11,14,23,14
	db 11,14,23,14,1,14,13,14,1,14,13,14,1,14,13,14
	db 1,14,13,14,6,14,18,14,6,14,18,14,6,14,18,14
	db 6,14,18,14,0
_song5_v2__9:
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
_song5_v3__9:
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
_song6_v0__9:
	db 244,13,240,5,42,36,44,13,46,12,45,12,46,24,49,37
	db 51,12,49,24,51,12,41,13,42,36,45,12,46,12,38,13
	db 39,24,39,24,37,49,42,24,41,12,40,13,39,12,37,24
	db 38,12,39,12,40,12,41,13,47,12,49,12,47,24,49,12
	db 47,13,41,12,42,12,41,12,39,12,37,25,38,12,39,12
	db 41,12,42,12,49,12,51,13,49,24,51,12,49,12,43,12
	db 44,13,47,12,51,12,44,24,47,12,46,13,44,24,38,24
	db 37,37,44,24,42,12,46,12,49,12,42,25,46,12,44,12
	db 42,24,36,25,37,36,42,25,41,12,40,12,39,12,37,24
	db 38,13,39,12,40,12,41,12,47,12,49,12,47,25,49,12
	db 47,12,41,12,42,12,41,12,39,13,37,24,38,12,39,12
	db 41,12,42,13,49,12,51,12,49,24,51,12,49,13,40,12
	db 39,12,51,24,42,25,41,12,42,12,44,12,45,97,49,61
	db 44,24,46,13,42,48,46,12,44,13,42,24,41,12,40,12
	db 39,12,37,25,38,12,39,12,40,12,41,12,47,13,49,12
	db 47,24,49,12,47,12,41,13,42,12,41,12,39,12,37,24
	db 38,13,39,12,41,12,42,12,49,12,51,12,49,25,51,12
	db 49,12,43,12,44,12,47,12,51,13,44,24,47,12,46,12
	db 44,25,38,24,37,36,44,25,42,12,46,12,49,12,42,25
	db 46,12,44,12,42,24,36,25,37,36,42,24,41,12,40,13
	db 39,12,37,24,38,12,39,12,40,13,41,12,47,12,49,12
	db 47,24,49,13,47,12,41,12,42,12,41,12,39,12,37,25
	db 38,12,39,12,41,12,42,12,49,13,51,12,49,24,51,12
	db 49,12,40,13,39,12,51,24,42,24,41,12,42,13,44,12
	db 42,48,44,25,50,24,49,61,44,24,46,12,42,13,51,24
	db 42,6,44,6,46,6,47,6,49,12,47,25,47,4,49,4
	db 47,4,47,12,46,12,46,12,45,37,44,24,43,49,44,24
	db 46,24,46,25,46,12,47,12,49,24,50,25,51,24,42,6
	db 44,6,46,6,47,6,49,13,47,24,47,4,49,4,47,4
	db 47,12,46,12,46,13,46,36,46,24,46,13,44,12,46,12
	db 41,24,44,12,39,25,39,24,37,49,49,24,49,12,47,24
	db 46,13,47,12,49,12,51,12,40,12,41,73,49,25,49,12
	db 47,24,46,12,47,12,49,13,51,12,40,12,41,73,41,24
	db 42,61,42,12,44,12,46,12,46,25,44,48,47,25,47,24
	db 49,37,37,12,46,24,42,24,46,13,47,12,49,24,50,24
	db 51,25,42,6,44,6,46,6,47,6,49,12,47,24,47,5
	db 49,4,47,4,47,12,46,12,46,12,45,37,44,24,43,49
	db 44,24,46,24,46,25,46,12,47,12,49,24,50,25,51,24
	db 42,6,44,6,46,6,47,6,49,12,47,25,47,4,49,4
	db 47,4,47,12,46,12,46,12,46,37,46,24,46,12,44,12
	db 46,13,41,24,44,12,39,24,39,25,37,48,49,25,49,12
	db 47,24,46,12,47,13,49,12,51,12,40,12,41,73,49,24
	db 49,12,47,25,46,12,47,12,49,12,51,12,40,13,41,73
	db 41,24,42,61,42,12,44,12,46,12,46,25,44,48,47,24
	db 47,25,49,36,37,12,46,25,42,24,41,12,40,12,39,13
	db 37,24,38,12,39,12,40,12,41,13,47,12,49,12,47,24
	db 49,12,47,13,41,12,42,12,41,12,39,12,37,25,38,12
	db 39,12,41,12,42,12,49,12,51,12,49,25,51,12,49,12
	db 43,12,44,12,47,13,51,12,44,24,47,12,46,12,44,25
	db 38,24,37,37,44,24,42,12,46,12,49,12,42,25,46,12
	db 44,12,42,24,36,25,37,36,42,24,41,13,40,12,39,12
	db 37,24,38,12,39,13,40,12,41,12,47,12,49,12,47,25
	db 49,12,47,12,41,12,42,12,41,12,39,13,37,24,38,12
	db 39,12,41,12,42,13,49,12,51,12,49,24,51,12,49,13
	db 40,12,39,12,51,24,42,24,41,13,42,12,44,12,45,49
	db 44,24,50,24,49,61,44,24,46,13,42,73,34,24,35,61
	db 39,12,47,24,23,37,40,24,40,12,47,24,23,37,22,24
	db 21,12,22,25,15,36,15,37,22,24,23,49,23,12,15,12
	db 18,12,20,12,22,61,21,12,22,25,22,60,21,13,22,24
	db 22,73,22,24,23,49,23,12,15,12,23,25,23,36,16,24
	db 16,13,23,24,23,36,22,25,21,12,22,24,15,37,15,36
	db 15,24,16,37,16,24,18,12,16,25,15,12,15,24,26,37
	db 20,24,20,12,18,25,16,36,15,24,23,73,22,25,23,60
	db 15,13,23,24,23,36,16,25,16,12,23,24,23,37,22,24
	db 21,12,22,25,15,36,15,36,22,25,23,48,23,13,15,12
	db 18,12,20,12,22,61,21,12,22,24,22,61,21,12,22,25
	db 22,73,22,24,23,49,23,12,15,12,23,24,23,37,16,24
	db 16,12,23,25,23,36,22,24,21,13,22,24,15,36,15,37
	db 15,24,16,37,16,24,18,12,16,24,15,13,15,24,26,36
	db 20,25,20,12,18,24,16,37,15,24,23,73,20,12,23,12
	db 40,13,40,12,40,12,40,24,40,25,40,12,40,12,40,12
	db 40,12,40,24,40,25,40,12,51,12,51,12,51,12,51,122
	db 44,24,42,13,42,12,40,12,39,12,40,24,39,25,40,12
	db 42,12,40,12,39,12,40,25,39,24,40,12,40,12,39,12
	db 40,13,42,133,44,13,47,12,40,12,40,12,40,12,40,25
	db 40,24,40,12,40,12,40,12,40,13,40,24,40,24,40,12
	db 51,13,51,12,51,12,51,121,51,13,47,12,45,12,44,12
	db 47,12,44,12,47,25,47,24,44,12,44,12,47,13,44,12
	db 42,24,47,24,49,13,39,12,38,12,39,12,30,24,27,25
	db 25,12,23,73,32,12,35,12,40,12,40,12,40,13,40,24
	db 40,24,40,12,40,13,40,12,40,12,40,24,40,25,40,12
	db 39,12,39,12,39,12,39,122,32,24,27,12,30,12,28,13
	db 27,12,28,24,27,24,28,13,30,12,28,12,27,12,28,24
	db 27,25,28,12,28,12,27,12,28,12,30,134,32,12,35,13
	db 40,12,40,12,40,12,40,24,40,25,40,12,40,12,40,12
	db 40,12,40,25,40,24,40,12,39,12,39,12,39,13,39,121
	db 39,12,35,13,33,12,32,12,35,12,32,12,35,25,35,24
	db 32,12,32,12,35,12,32,12,30,25,35,24,37,12,27,12
	db 26,13,27,12,18,12,15,12,15,24,25,13,23,48,23,25
	db 255,12,0
_song6_v1__9:
	db 244,6,240,6,18,36,20,13,22,12,21,12,22,24,13,37
	db 15,12,13,24,15,12,17,13,18,36,21,12,22,12,14,13
	db 15,24,11,24,10,49,10,12,9,12,8,37,13,12,17,24
	db 8,24,1,37,13,12,17,24,9,25,10,36,13,12,18,25
	db 13,24,6,37,13,12,18,24,10,24,8,73,15,25,11,24
	db 11,24,8,12,10,13,11,24,10,36,13,13,18,24,13,24
	db 9,25,10,24,6,12,8,12,10,12,9,13,8,36,13,12
	db 17,25,8,24,1,36,13,13,17,24,9,24,10,37,13,12
	db 18,24,13,24,6,37,13,12,18,24,6,25,11,36,15,12
	db 18,25,15,24,12,49,11,48,255,13,22,12,11,12,12,12
	db 13,12,17,12,13,25,6,12,10,12,11,12,12,12,13,12
	db 11,13,10,12,9,12,8,36,13,13,17,24,8,24,1,37
	db 13,12,17,24,9,25,10,36,13,12,18,25,13,24,6,36
	db 13,12,18,25,10,24,8,73,15,24,11,25,11,24,8,12
	db 10,12,11,25,10,36,13,12,18,25,13,24,9,24,10,25
	db 6,12,8,12,10,12,9,12,8,37,13,12,17,24,8,25
	db 1,36,13,12,17,25,9,24,10,36,13,13,18,24,13,24
	db 6,37,13,12,18,24,6,25,11,36,15,12,18,24,15,25
	db 12,48,11,49,255,12,22,12,11,13,12,12,13,12,17,12
	db 13,24,18,25,11,36,15,12,18,25,11,24,6,73,2,24
	db 1,37,1,12,1,24,2,25,3,73,6,24,11,36,3,13
	db 6,24,11,24,6,37,3,12,6,24,7,25,8,36,1,12
	db 5,24,8,25,1,36,1,12,5,25,1,24,8,73,8,24
	db 2,37,2,12,5,24,1,25,8,73,8,24,2,36,2,13
	db 5,24,2,24,3,37,3,12,6,24,3,25,11,73,2,24
	db 1,73,1,24,6,25,255,48,6,24,11,37,15,12,18,24
	db 11,25,6,73,14,24,13,37,13,12,1,24,2,24,3,73
	db 6,25,11,36,3,12,6,25,11,24,6,36,15,13,18,24
	db 7,24,8,37,13,12,17,24,8,25,1,36,13,12,17,25
	db 1,24,8,73,8,24,2,37,14,12,17,24,1,24,8,73
	db 8,25,2,36,2,12,5,25,2,24,3,37,15,12,18,24
	db 3,24,11,73,2,25,1,73,1,24,6,24,8,37,13,12
	db 17,24,8,25,1,36,13,12,17,25,9,24,10,36,13,13
	db 18,24,13,24,6,37,13,12,18,24,10,24,8,73,15,25
	db 11,24,11,24,8,13,10,12,11,24,10,37,13,12,18,24
	db 13,24,9,25,10,24,6,12,8,12,10,12,9,13,8,36
	db 13,12,17,25,8,24,1,36,13,13,17,24,9,24,10,37
	db 13,12,18,24,13,25,6,36,13,12,18,25,6,24,11,36
	db 15,12,18,25,15,24,12,49,11,48,255,13,22,12,11,12
	db 12,12,13,12,17,12,13,25,18,24,13,12,18,37,18,24
	db 11,12,13,12,14,13,15,24,11,12,8,12,6,12,4,12
	db 16,13,18,12,20,36,4,25,6,12,13,12,15,12,16,37
	db 6,24,11,73,6,24,11,12,13,13,14,12,15,36,11,25
	db 10,60,3,12,10,13,6,12,10,73,10,24,6,37,3,36
	db 6,24,11,13,1,12,2,12,3,24,11,12,8,13,6,12
	db 4,12,4,12,6,12,8,37,4,24,6,12,1,12,3,12
	db 4,37,6,24,11,73,9,25,8,12,11,12,4,12,8,37
	db 7,24,6,12,6,24,5,37,5,24,6,37,6,60,11,37
	db 6,12,11,24,6,25,11,12,1,12,2,12,3,25,11,12
	db 8,12,6,12,4,12,4,12,6,13,8,36,4,24,6,13
	db 1,12,3,12,4,36,6,25,11,73,6,24,11,12,1,12
	db 2,12,3,37,11,24,10,61,3,12,10,12,6,13,10,73
	db 10,24,6,36,3,37,6,24,11,12,1,12,2,13,3,24
	db 11,12,8,12,6,12,4,13,4,12,6,12,8,36,4,25
	db 6,12,1,12,3,12,4,37,6,24,11,73,9,24,8,13
	db 11,12,4,12,8,36,7,25,6,12,6,24,5,37,5,24
	db 6,36,6,61,11,37,6,12,11,24,2,25,1,36,13,12
	db 16,25,6,24,13,36,13,12,16,25,6,24,11,37,15,12
	db 18,24,6,24,11,73,12,25,1,36,1,12,4,25,6,24
	db 1,37,13,12,16,24,6,24,11,37,15,12,18,24,6,25
	db 11,12,14,12,15,12,18,37,2,24,1,36,13,13,16,24
	db 6,24,13,37,13,12,16,24,6,25,11,36,15,12,18,24
	db 6,25,11,73,3,24,4,37,11,24,11,36,6,37,9,12
	db 255,12,8,25,7,12,18,36,11,25,6,24,4,12,11,36
	db 6,13,11,24,2,24,1,37,13,12,16,24,6,25,13,36
	db 13,12,16,25,6,24,11,36,15,13,18,24,6,24,11,73
	db 12,24,1,37,1,12,4,24,6,25,1,36,13,12,16,25
	db 6,24,11,37,15,12,18,24,6,24,11,13,14,12,15,12
	db 18,36,2,25,1,36,13,12,16,25,6,24,13,36,13,13
	db 16,24,6,24,11,37,15,12,18,24,6,25,11,73,3,24
	db 4,36,11,25,11,36,6,37,9,12,255,12,8,24,7,12
	db 18,37,11,24,6,25,4,12,11,36,6,12,11,25,0
_song6_v2__9:
	db 244,6,240,8,255,240,255,198,35,24,255,73,35,24,255,73
	db 34,25,255,24,30,49,34,24,34,24,32,37,35,12,35,24
	db 39,25,255,146,34,24,255,170,35,25,255,73,35,24,255,73
	db 34,24,255,24,30,49,34,24,30,25,255,48,35,25,255,219
	db 30,12,255,134,35,24,255,73,35,24,255,73,34,25,255,24
	db 30,48,34,25,34,24,32,37,35,12,35,24,39,24,255,146
	db 34,25,255,170,35,24,255,73,35,25,255,73,34,24,255,24
	db 30,49,34,24,30,25,255,48,35,24,255,240,255,52,35,25
	db 255,24,18,37,27,12,33,24,26,24,255,98,15,36,15,12
	db 22,25,16,24,23,49,23,24,23,24,255,49,22,24,255,73
	db 20,24,255,25,13,48,23,25,13,24,20,37,23,12,32,24
	db 20,24,255,49,23,24,13,25,20,36,23,12,20,25,20,24
	db 14,49,23,24,14,24,255,49,22,24,255,25,23,36,15,12
	db 23,25,14,24,13,36,13,13,23,24,13,24,25,25,255,48
	db 28,24,255,49,35,24,255,25,30,36,39,12,33,25,38,24
	db 255,97,15,37,27,12,34,24,28,25,23,48,23,25,23,24
	db 255,49,34,24,255,73,32,24,255,25,25,48,35,25,25,24
	db 32,36,35,13,32,24,32,24,255,49,35,24,25,24,20,37
	db 23,12,32,24,20,25,14,48,23,25,14,24,255,49,34,24
	db 255,24,23,37,27,12,35,24,26,25,13,36,13,12,23,25
	db 13,24,255,73,35,24,255,73,35,25,255,73,34,24,255,24
	db 30,49,34,24,34,24,32,37,35,12,35,24,39,25,255,146
	db 34,24,255,170,35,25,255,73,35,24,255,73,34,24,255,25
	db 30,48,34,25,30,24,255,48,35,25,255,219,30,24,255,240
	db 255,28,30,73,18,24,23,12,38,12,39,12,30,37,30,24
	db 255,110,34,12,32,12,30,61,255,12,20,12,18,12,17,37
	db 17,24,15,24,22,13,255,36,18,24,255,195,18,73,18,24
	db 23,12,26,13,27,12,30,36,21,25,255,240,255,240,255,103
	db 18,73,18,25,23,12,26,12,27,12,30,37,18,24,255,109
	db 22,13,20,12,18,61,255,12,20,12,18,12,17,37,17,24
	db 15,24,22,12,255,37,18,24,255,195,18,73,18,24,23,12
	db 14,12,15,13,18,36,21,24,255,240,255,150,25,48,34,25
	db 18,24,255,48,34,25,255,73,35,24,255,24,23,13,38,12
	db 39,12,32,61,13,48,22,25,18,24,255,49,34,24,255,73
	db 35,24,255,122,25,49,34,24,18,24,255,49,34,24,255,73
	db 35,24,255,25,23,12,38,12,39,12,32,37,35,24,23,37
	db 17,24,17,36,23,37,23,24,23,37,35,36,35,12,255,49
	db 27,73,255,24,25,49,34,24,18,25,255,48,34,25,255,73
	db 35,24,255,24,23,12,38,13,39,12,32,60,13,49,22,24
	db 18,25,255,48,34,25,255,73,35,24,255,122,25,48,34,25
	db 18,24,255,49,34,24,255,73,35,24,255,25,23,12,38,12
	db 39,12,32,37,35,24,23,36,17,25,17,36,23,37,23,24
	db 23,36,35,37,35,12,255,49,27,73,0
_song6_v3__9:
	db 244,1,240,5,3,36,244,2,240,12,5,13,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,36,244,2
	db 240,12,5,13,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,36,244,2,240,12,5,13,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,36,244,2
	db 240,12,5,13,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,36,244,2,240,12,5,13,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,36,244,2,240,12,5,13,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,36,244,2
	db 240,12,5,13,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,36,244,2,240,12,5,13,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,36,244,2
	db 240,12,5,13,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,36,244,2,240,12,5,13,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,36,244,2
	db 240,12,5,13,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,36,244,2
	db 240,12,5,13,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,36,244,2,240,12,5,13,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,36,244,2
	db 240,12,5,13,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,36,244,2,240,12,5,13,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,36,244,2
	db 240,12,5,13,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,36,244,2,240,12,5,13,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,36,244,2,240,12,5,13,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,36,244,2
	db 240,12,5,13,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,36,244,2,240,12,5,13,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,36,244,2
	db 240,12,5,13,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,36,244,2,240,12,5,13,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,36,244,2
	db 240,12,5,13,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,25,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,36,244,2
	db 240,12,5,13,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,37,244,2,240,12,5,12,244,1,240,5
	db 3,24,244,2,240,12,5,25,244,1,240,5,3,36,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,25
	db 244,1,240,5,3,36,244,2,240,12,5,12,244,1,240,5
	db 3,25,244,2,240,12,5,24,244,1,240,5,3,37,244,2
	db 240,12,5,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,1,240,5,3,25,0
	align 2
_music_songs:
	dd _song0_v0__9
	dd _song0_v1__9
	dd _song0_v2__9
	dd _song0_v3__9
	db 1,0
	dd _song1_v0__9
	dd _song1_v1__9
	dd _song1_v2__9
	dd _song1_v3__9
	db 1,0
	dd _song2_v0__9
	dd _song2_v1__9
	dd _song2_v2__9
	dd _song2_v3__9
	db 1,0
	dd _song3_v0__9
	dd _song3_v1__9
	dd _song3_v2__9
	dd _song3_v3__9
	db 1,0
	dd _song4_v0__9
	dd _song4_v1__9
	dd _song4_v2__9
	dd _song4_v3__9
	db 1,0
	dd _song5_v0__9
	dd _song5_v1__9
	dd _song5_v2__9
	dd _song5_v3__9
	db 1,0
	dd _song6_v0__9
	dd _song6_v1__9
	dd _song6_v2__9
	dd _song6_v3__9
	db 1,0
_z80drv__10:
	db 195,19,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,243,49,0,16,58,3,0,183,40,250,71,33,4
	db 0,126,50,1,64,50,0,64,35,126,50,1,64,50,0,64
	db 35,126,50,1,64,50,0,64,35,16,230,175,50,3,0,24
	db 214
_inst_tab__10:
	db 6,4,1,15,1,15,2,15,7,3,5,3,2,9,6,4
	db 3,8,2,12,8,3,8,3,5,5,3,6,5,5,2,12
	db 2,12,6,4
	align 2
_b_edge__11:
	db 49,1,68,4,18,1,16,4
	align 2
_b_band__11:
	db 179,3,255,15,45,2,82,14
	align 2
_b_text__11:
	db 255,15,46,2,255,15,255,15
	align 2
_b_shad__11:
	db 0,0,6,0,0,0,0,0
_slim__12_L1728:
	db 34,39,59,61,62,63
	align 2
_overrev_dash_tiles__15:
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
_easy_bends__18:
	db 20,0,26,0,32,0,40,0,46,0
	align 2
_sharp_bends__18:
	db 56,0,62,0,70,0
	align 2
_sp_sharp__18:
	db 94,1,144,1,244,1
	align 2
_sp_s__18:
	db 44,1,94,1,144,1
	align 2
_sp_gap__18:
	db 0,0,100,0,150,0
	align 2
_sp_straight__18:
	db 144,1,244,1,88,2,32,3
	align 2
_sp_bend__18:
	db 144,1,244,1,88,2,188,2,32,3
_slopes__18:
	db 0,255,1,0,254,2
	align 2
_bridge_run__18:
	db 242,3,0,0,0,0,98,2,0,0,253,0,108,2,0,0
	db 3,0,218,2,26,0,0,0
_S19_0:
	db 65,85,84,79,66,65,72,78,32,65,67,69,0
_S19_1:
	db 84,79,80,32,83,80,69,69,68,44,32,84,79,80,32,82
	db 65,78,75,33,0
_S19_2:
	db 67,65,78,89,79,78,32,67,79,78,81,85,69,82,79,82
	db 0
_S19_3:
	db 78,79,84,72,73,78,71,32,83,84,79,80,83,32,89,79
	db 85,33,0
_S19_4:
	db 76,65,75,69,83,73,68,69,32,68,82,69,65,77,0
_S19_5:
	db 65,32,80,69,82,70,69,67,84,32,83,85,78,83,69,84
	db 32,82,85,78,0
_S19_6:
	db 83,69,65,83,73,68,69,32,80,65,82,84,89,0
_S19_7:
	db 84,72,69,32,84,79,87,78,32,67,72,69,69,82,83,32
	db 89,79,85,33,0
_S19_8:
	db 76,69,71,69,78,68,32,79,70,32,84,72,69,32,82,85
	db 73,78,0
_S19_9:
	db 84,72,69,32,65,78,67,73,69,78,84,32,67,85,80,33
	db 0
_S19_10:
	db 74,79,85,82,78,69,89,32,67,79,77,80,76,69,84,69
	db 0
_S19_11:
	db 65,32,82,79,65,68,32,78,79,66,79,68,89,32,75,78
	db 69,87,0
	align 2
_endings__19:
	dd _S19_0
	dd _S19_1
	db 68,4,170,10,255,15,2,0
	dd _S19_2
	dd _S19_3
	db 36,0,123,3,207,8,1,0
	dd _S19_4
	dd _S19_5
	db 66,9,199,15,254,15,3,0
	dd _S19_6
	dd _S19_7
	db 70,0,189,2,255,9,4,0
	dd _S19_8
	dd _S19_9
	db 4,1,61,3,175,10,1,0
	dd _S19_10
	dd _S19_11
	db 85,0,207,0,255,10,1,0
_dir_x__19:
	db 16,11,0,245,240,245,0,11
_dir_y__19:
	db 0,245,240,245,0,11,16,11
_pals__19_L2732:
	db 1,2,9,10
	align 2
_gfx_font_tiles__26:
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
_S26_0:
	db 84,73,77,69,0
_S26_1:
	db 83,84,65,71,69,0
_S26_2:
	db 75,77,47,72,0
_S26_3:
	db 72,73,71,72,0
_S26_4:
	db 32,76,79,87,0
_hill_rate__30:
	db 64,65,67,69,71,73,75,77,80,82,85,88,91,94,98,102
	db 106,111,116,121,128,134,140,147,153,160,166,172,179,185,192,198
	db 204,211,217,224,230,236,243,249,255
	align 2
_course_sol__30:
	db 82,0,51,3,85,5,255,15,255,255,51,3,51,3,102,6
	db 153,9
_course_horizon__30:
	db 0
_band_lut__30:
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
_crowd_pal__31_L5074:
	db 6,8,10
_pano_slot__33:
	db 8,9,10,11,12,13,14,15,2,3,4,5,6
	align 2
__DataROM_START:
	db 46,92,119,159,224,2,0,6,80,130,0,0,0,0
	db 255
	db 0
	db 64,66,15,0,64,66,15,0,64,66,15,0,64,66,15,0
	db 15
	db 255
	db 255,255
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
	db 0
	dd _buf__18
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
	dd _id_xy_a__30
	dd _id_xy_b__30
	dd _id_bandcol_a__30
	db 2
	db 0
	db 255,255,255,255
	db 255
	db 0
	db 43,29
	db 6
	db 50
__DataROM_END:
__Bss_START equ 04000h
__Bss_END equ 05E0Ch
__DataRAM_START equ 05E0Ch
__RAM_END equ 05E76h
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
_roll_t__0 equ 040B3h
_roll_dir__0 equ 040B4h
_roll_kind__0 equ 040B5h
_knock_v__0 equ 040B6h
_knock_t__0 equ 040B8h
_verge_spd__0 equ 040B9h
_was_offroad__0 equ 040BAh
_dbg_bumps equ 040BBh
_dbg_rolls equ 040BCh
_dbg_flips equ 040BDh
_dbg_cspd equ 040BEh
_dbg_flip_at equ 040CEh
_dbg_knock_at equ 040D0h
_msg_timer__0 equ 040D2h
_flash_step__0 equ 040D3h
_station__0 equ 040D4h
_last_fork_zone__0 equ 040D5h
_goal_reached__0 equ 040D6h
_title_frames__0 equ 040D8h
_pano_tiles_at__0 equ 040DAh
_trf_tiles_at__0 equ 040DCh
_dbg_updates equ 040DEh
_dbg_cp equ 040E0h
_dbg_roll_at equ 040E6h
_dbg_crashes equ 040E8h
_dbg_scn equ 040E9h
_dbg_off equ 040EAh
_grade_tab__0 equ 040EBh
_frame_vb__0 equ 040F8h
_save_buf__0 equ 040F9h
_save_dirty__0 equ 041F9h
_map_px__0 equ 041FAh
_map_py__0 equ 04206h
_map_n__0 equ 04212h
_map_seg__0 equ 04213h
_map_t__0 equ 04214h
_map_along__0 equ 04216h
_map_done__0 equ 04218h
_bal_x__0 equ 0421Ah
_bal_y__0 equ 0422Ah
_bal_v__0 equ 0423Ah
_bal_wait__0 equ 04242h
_bal_live__0 equ 0424Ah
_smoke_t__0 equ 0424Bh
_eng_phase__0 equ 0424Ch
_voice__10 equ 0424Eh
_playing__10 equ 04296h
_last_vbl__10 equ 04297h
_want_div__10 equ 04298h
_want_attn__10 equ 042A0h
_sent_div__10 equ 042A4h
_sent_attn__10 equ 042ACh
_noise_trig__10 equ 042B0h
_sfx_frames__10 equ 042B1h
_sfx_div__10 equ 042B6h
_sfx_step__10 equ 042BEh
_sfx_attn__10 equ 042C2h
_sfx_decay__10 equ 042C6h
_sfx_age__10 equ 042CAh
_eng_div__10 equ 042CEh
_eng_on__10 equ 042D0h
_b_on__11 equ 042D1h
_b_r0__11 equ 042D2h
_b_r1__11 equ 042D3h
_b_c0__11 equ 042D4h
_b_c1__11 equ 042D5h
_b_foot__11 equ 042D6h
_b_spr__11 equ 042D7h
_car_d__11 equ 042D8h
_br_at__12 equ 042DAh
_br_n__12 equ 042F2h
_car_d__12 equ 042F4h
_bridge_line equ 042F6h
_bb_r1__12 equ 042F7h
_bb_c0__12 equ 042F8h
_bb_c1__12 equ 042F9h
_s_offset__13 equ 042FAh
_s_sequence__13 equ 042FEh
_s_repeat_timer__14 equ 04302h
_g_vb_hook__15 equ 0430Ah
_s_cmd_type__17 equ 0430Eh
_s_cmd_dst__17 equ 0431Eh
_s_cmd_len__17 equ 0433Eh
_s_cmd_src__17 equ 0435Eh
_s_cmd_fill__17 equ 0439Eh
_s_cmd_count__17 equ 043BEh
_s_drop_count__17 equ 043BFh
_s_lock__17 equ 043C0h
_buf__18 equ 043C2h
_track_len equ 04572h
_cur_stage equ 04573h
_cur_branch equ 04574h
_cur_leg equ 04575h
_leg_len equ 04576h
_fork_choice equ 04578h
_route_hist equ 04579h
_difficulty equ 0457Eh
_leg_theme equ 0457Fh
_next_leg_cost equ 0458Eh
_n_cur__18 equ 04590h
_n_next__18 equ 04591h
_rs__18 equ 04592h
_gp__18 equ 04594h
_gn__18 equ 04598h
_px__19 equ 0459Ah
_py__19 equ 045B6h
_vx__19 equ 045D2h
_vy__19 equ 045EEh
_life__19 equ 0460Ah
_ptile__19 equ 04618h
_ppal__19 equ 04626h
_fx__19 equ 04634h
_timer__19 equ 04635h
_s_done_cb__20 equ 04636h
_s_done_flag__20 equ 04646h
_s_was_active__20 equ 0464Ah
_s_rearm_enabled__20 equ 0464Eh
_s_rearm_elem__20 equ 04652h
_s_rearm_vector__20 equ 04656h
_s_rearm_count__20 equ 0465Ah
_s_rearm_dst__20 equ 04662h
_s_rearm_src__20 equ 04672h
_h_score__26 equ 04682h
_h_score_ok__26 equ 04689h
_s_dig__26 equ 0468Ah
_spr_shadow equ 04692h
_spr_pal_shadow equ 04792h
_spr_ready equ 047D2h
_body__29 equ 047D4h
_car_variant__29 equ 047F4h
_car_wheel_dx__29 equ 047F5h
_car_tile_base__29 equ 047F6h
_lean_hold__29 equ 047F8h
_lean_side__29 equ 047F9h
_lean_wait__29 equ 047FAh
_bump_phase__29 equ 047FBh
_car_last_x__29 equ 047FCh
_car_last_top__29 equ 047FEh
_art__30 equ 04800h
_road_course__30 equ 04818h
_road_grade__30 equ 04819h
_band_pitch__30 equ 0481Ah
_climb_room__30 equ 0481Ch
_descent_room__30 equ 0481Dh
_band_shift__30 equ 0481Eh
_id_xy_a__30 equ 04820h
_id_xy_b__30 equ 04952h
_id_xy_done__30 equ 04A84h
_id_xy_last__30 equ 04A88h
_id_raster__30 equ 04A8Ch
_id_shear__30 equ 04AA0h
_id_sl__30 equ 04B20h
_id_bandcol_a__30 equ 04BE0h
_id_bandcol_b__30 equ 04D12h
_bc_top__30 equ 04E44h
_id_bandcol_done__30 equ 04E46h
_id_bandstream__30 equ 04E4Ah
_band_phase__30 equ 04E58h
_id_dxc__30 equ 04E5Ah
_id_w_lat__30 equ 04F5Ah
_id_w_curve__30 equ 04F9Ah
_id_half__30 equ 04FDAh
_id_src__30 equ 0501Ah
_band_top__30 equ 0505Ah
_band_mid__30 equ 0505Eh
_band_tree__30 equ 05062h
_band_bg_first__30 equ 05066h
_id_buf__30 equ 05068h
_pan_head__30 equ 0506Ah
_pan_lat__30 equ 0506Ch
_pan_fine__30 equ 0506Eh
_band_held__30 equ 0506Fh
_band_wait__30 equ 05070h
_id_ahead__30 equ 05072h
_id_curve_cm__30 equ 050F2h
_wide_k0__30 equ 050F4h
_rally_of__30 equ 050F5h
_rally_src__30 equ 052F6h
_rally_used__30 equ 054F4h
_rally_scanned__30 equ 054F5h
_band_col__30 equ 054F6h
_road_dma_live__30 equ 054FEh
_road_dma_depth__30 equ 054FFh
_id_curve_dx__30 equ 05500h
_scn_phase__31 equ 05580h
_scn_frac__31 equ 05582h
_scn_passed__31 equ 05584h
_scn_mode__31 equ 05585h
_ovl_grid equ 05586h
_ovl_prev__32 equ 0582Eh
_m_r1__32 equ 05AD6h
_m_c0__32 equ 05AD7h
_m_c1__32 equ 05AD8h
_fl__32 equ 05ADAh
_fl_ready__32 equ 05AE8h
_pano_base__33 equ 05AEAh
_obj_base__33 equ 05AECh
_obj_end__33 equ 05AEEh
_pano_end__33 equ 05AF0h
_objmap__33 equ 05AF2h
_kind_l__33 equ 05CF2h
_kind_r__33 equ 05CF3h
_cur_pals__33 equ 05CF4h
_cur_backdrop__33 equ 05D5Ch
_cur_road__33 equ 05D5Eh
_cur_band__33 equ 05D66h
_cur_spr__33 equ 05D6Eh
_next_slot__33 equ 05D9Eh
_cars__34 equ 05DA0h
_trf_tiles__34 equ 05E02h
_car_d__34 equ 05E04h
_half_wheel__34 equ 05E06h
_dens_min__34 equ 05E07h
_dens_max__34 equ 05E08h
_target__34 equ 05E09h
_cooldown__34 equ 05E0Ah
_hard__34 equ 05E0Bh
_car_tuned__0 equ 05E0Ch
_roll_loaded__0 equ 05E1Ah
_hiscore__0 equ 05E1Ch
_eng_attn__10 equ 05E2Ch
_bb_r0__12 equ 05E2Dh
_sig_prev__12 equ 05E2Eh
_s_current__13 equ 05E30h
_s_last_slot__13 equ 05E31h
_ngpc_pad_held equ 05E32h
_ngpc_pad_pressed equ 05E33h
_ngpc_pad_released equ 05E34h
_ngpc_pad_repeat equ 05E35h
_s_pad_prev__14 equ 05E36h
_s_repeat_delay__14 equ 05E37h
_s_repeat_rate__14 equ 05E38h
_s_vbl_down__14 equ 05E39h
_s_vbl_prev__14 equ 05E3Ah
_g_vb_counter equ 05E3Bh
_s_is_color__15 equ 05E3Ch
_s_language__15 equ 05E3Dh
_s_power_hold__16_L2382 equ 05E3Eh
_track_seg equ 05E40h
_free_seed equ 05E44h
_seed__19 equ 05E46h
_cur_song__22 equ 05E48h
_h_time__26 equ 05E49h
_h_kmh__26 equ 05E4Ah
_h_gear__26 equ 05E4Bh
_h_prog__26 equ 05E4Ch
_h_stage__26 equ 05E4Dh
_id_spr_priority equ 05E4Eh
_car_at_x__29 equ 05E50h
_car_stand__30 equ 05E52h
_grade_hi__30 equ 05E53h
_grade_lo__30 equ 05E54h
_band_first__30 equ 05E55h
_band_count__30 equ 05E56h
_band_bg_end__30 equ 05E57h
_road_top__30 equ 05E59h
_road_plane0__30 equ 05E5Ah
_road_bottom__30 equ 05E5Bh
_road_lines__30 equ 05E5Ch
_road_base_x__30 equ 05E5Dh
_id_xy__30 equ 05E5Eh
_id_xy_live__30 equ 05E62h
_id_bandcol__30 equ 05E66h
_road_band_pal__30 equ 05E6Ah
_bc_rest__30 equ 05E6Ch
_m_r0__32 equ 05E70h
_rng__34 equ 05E72h
_trf_cap__34 equ 05E74h
_trf_spr_end equ 05E75h

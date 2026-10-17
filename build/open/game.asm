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
L320:
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
	jr z,L325
	ld xwa,(xsp+4)
	push xwa
	ld wa,5
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L325:
	ld xwa,(xsp+8)
	cp xwa,0
	jr z,L326
	ld xwa,(xsp+8)
	push xwa
	ld wa,7
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L326:
	ld a,(xsp+12)
	ld (_msg_timer__0),a
	call _banner_dirty
L324:
	ret

; function count_message
_count_message__0:
	ld wa,12
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld xwa,(xsp+4)
	cp xwa,0
	jr z,L330
	ld xwa,(xsp+4)
	push xwa
	ld wa,12
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L330:
	ld a,(xsp+8)
	ld (_cnt_timer__0),a
L329:
	ret

; function tick_message
_tick_message__0:
	ld a,(_msg_timer__0)
	cp a,0
	jr z,L337
	decb 1,(_msg_timer__0)
	ld a,(_msg_timer__0)
	cp a,0
	jr nz,L338
	ld wa,5
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld wa,7
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	call _banner_dirty
L338:
L337:
	ld a,(_cnt_timer__0)
	cp a,0
	jr z,L339
	decb 1,(_cnt_timer__0)
	ld a,(_cnt_timer__0)
	cp a,0
	jr nz,L340
	ld wa,12
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
L340:
L339:
L336:
	ret

; function leg_end
_leg_end__0:
	lda xsp,(xsp-4)
	call _course_is_last_stage
	cp a,0
	jr z,L346
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
	jp L345
L346:
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
	jr ule,L347
	ld wa,99
	jr L348
L347:
	ld wa,(xsp+2)
L348:
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
L345:
	lda xsp,(xsp+4)
	ret

; function tick_flash
_tick_flash__0:
	ld a,(_flash_step__0)
	cp a,0
	jr nz,L356
	jr L354
L356:
	ld a,(_flash_step__0)
	cp a,5
	jr nz,L357
	ld a,(_cur_leg)
	push xwa
	call _theme_apply
	lda xsp,(xsp+4)
	call _stage_traffic__0
L357:
	ld xwa,_lv__0_L355
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
	jr ule,L358
	ldb (_flash_step__0),0
L358:
L354:
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
L360:
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
	jr L372
L369:
	ld xwa,xix
	ld c,izl
	extz bc
	sll 3,bc
	cp c,0
	jr z,L374
L373:
	srl 1,xwa
	djnz c,L373
L374:
	ld xbc,_save_buf__0
	ld e,iyl
	add e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L371:
	inc 1,izl
L372:
	ld a,izl
	cp a,4
	jr ult,L369
L370:
L368:
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
	jr L376
L376:
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
	jr nz,L388
	jp L387
L388:
	push xix
	ld xwa,_save_buf__0
	push xwa
	call _ngpc_flash_load
	lda xsp,(xsp+4)
	pop xix
	ld a,(_save_buf__0+4)
	cp a,1
	jr z,L389
	jp L387
L389:
	ld a,(_save_buf__0+5)
	cp a,4
	jr uge,L390
	ld a,(_save_buf__0+5)
	ld (_station__0),a
L390:
	ld a,(_save_buf__0+6)
	cp a,4
	jr uge,L391
	ld a,(_save_buf__0+6)
	ld (_difficulty),a
L391:
	ld izl,0
	jr L395
L392:
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
	jr z,L396
	ld xwa,xix
	cp xwa,10000000
	jr uge,L396
	ld xwa,xix
	ld xbc,_hiscore__0
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L396:
L394:
	inc 1,izl
L395:
	ld a,izl
	cp a,4
	jr ult,L392
L393:
	ld a,(_save_buf__0+24)
	extz wa
	ld c,(_save_buf__0+25)
	extz bc
	sll 8,bc
	or wa,bc
	ld (_free_seed),wa
L387:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function save_commit
_save_commit__0:
	push xiz
	lda xsp,(xsp-4)
	ld a,(_save_dirty__0)
	cp a,0
	jr nz,L409
	jp L408
L409:
	ld ix,0
	jr L413
L410:
	ld a,0
	ld xbc,_save_buf__0
	ld de,ix
	extz xde
	add xbc,xde
	ld (xbc),a
L412:
	inc 1,ix
L413:
	ld wa,ix
	cp wa,256
	jr ult,L410
L411:
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
	jr L417
L414:
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
L416:
	inc 1,izl
L417:
	ld a,izl
	cp a,4
	jr ult,L414
L415:
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
	jr z,L418
	ldb (_save_dirty__0),0
L418:
L408:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function title_slot
_title_slot__0:
	push xiz
	ld iz,(xsp+8)
	ld wa,iz
	cp wa,111
	jr uge,L424
	ld wa,(_pano_tiles_at__0)
	add wa,iz
	jr L423
L424:
	ld wa,iz
	sub wa,111
	ld iz,wa
	ld wa,iz
	cp wa,(_gfx_traffic_tiles_count)
	jr uge,L425
	ld wa,(_trf_tiles_at__0)
	add wa,iz
	jr L423
L425:
	ld wa,iz
	sub wa,(_gfx_traffic_tiles_count)
	ld iz,wa
	ld wa,iz
	cp wa,30
	jr uge,L426
	ld wa,2
	add wa,iz
	jr L423
L426:
	ld wa,iz
	sub wa,30
	ld iz,wa
	ld wa,101
	add wa,iz
	jr L423
L423:
	pop xiz
	ret

; function title_option
_title_option__0:
	push xiz
	lda xsp,(xsp-2)
	ld wa,0
	ld izl,a
	jr L435
L433:
	inc 1,izl
L435:
	ld xwa,(xsp+14)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L436
	ld a,izl
	cp a,16
	jr ult,L433
L436:
L434:
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
L432:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function hex4
_hex4__0:
	push xiz
	lda xsp,(xsp-2)
	ld xiy,(xsp+10)
	ld izl,0
	jr L450
L447:
	ld wa,(xsp+14)
	ld bc,12
	ld e,izl
	extz de
	sll 2,de
	sub bc,de
	cp c,0
	jr z,L452
L451:
	srl 1,wa
	djnz c,L451
L452:
	and wa,15
	ld ixl,a
	ld c,ixl
	cp c,10
	jr uge,L453
	ld wa,48
	ld c,ixl
	extz bc
	add wa,bc
	jr L454
L453:
	ld wa,65
	ld c,ixl
	extz bc
	add wa,bc
	sub wa,10
L454:
	ld xbc,xiy
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L449:
	inc 1,izl
L450:
	ld a,izl
	cp a,4
	jr ult,L447
L448:
	ldb (xiy+4),0
L446:
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
	jr nz,L458
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
L458:
L457:
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
	jr z,L463
	ld wa,(xsp+0)
	jr L464
L463:
	ld wa,24301
L464:
	ld (_free_seed),wa
L462:
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
	jr L510
L507:
	ld wa,0
	ld xbc,38912
	ld de,(xsp+2)
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L509:
	incw 1,(xsp+2)
L510:
	ld wa,(xsp+2)
	cp wa,1024
	jr ult,L507
L508:
	push xix
	ld wa,2642
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
	pop xix
	ldw (xsp+0),0
	jr L514
L511:
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
	jr L518
L515:
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
L517:
	incb 1,(xsp+14)
L518:
	ld a,(xsp+14)
	cp a,8
	jr ult,L515
L516:
L513:
	incw 1,(xsp+0)
L514:
	ld wa,(xsp+0)
	cp wa,210
	jr ult,L511
L512:
	ldw (xsp+0),0
	jr L522
L519:
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
L521:
	incw 1,(xsp+0)
L522:
	ld wa,(xsp+0)
	cp wa,13
	jr ult,L519
L520:
	ldw (xsp+0),0
	jr L526
L523:
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
L525:
	incw 1,(xsp+0)
L526:
	ld wa,(xsp+0)
	cp wa,8
	jr ult,L523
L524:
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
	jp L530
L527:
	ld izl,0
	jp L534
L531:
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
	jr nz,L535
	ld wa,0
	jr L536
L535:
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
L536:
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
L533:
	inc 1,izl
L534:
	ld a,izl
	cp a,18
	jp ult,L531
L532:
L529:
	inc 1,ixl
L530:
	ld a,ixl
	cp a,11
	jp ult,L527
L528:
	ld ixl,0
	jp L540
L537:
	ld izl,0
	jp L544
L541:
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
	jr nz,L545
	ld wa,0
	jr L546
L545:
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
L546:
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
L543:
	inc 1,izl
L544:
	ld a,izl
	cp a,20
	jp ult,L541
L542:
L539:
	inc 1,ixl
L540:
	ld a,ixl
	cp a,11
	jp ult,L537
L538:
	push xix
	call _title_texts__0
	pop xix
L506:
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
	jr L556
L553:
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
L555:
	inc 1,iz
L556:
	ld wa,iz
	ld bc,(_gfx_traffic_tiles_count)
	sll 3,bc
	cp wa,bc
	jr ult,L553
L554:
	call _id_road_dma_resume
L552:
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
	jp L580
L577:
	ld wa,24
	ld c,ixl
	extz bc
	sll 1,bc
	add wa,bc
	ld (xsp+6),a
	ld c,ixl
	cp c,0
	jr nz,L581
	ld wa,(xsp+2)
	sub wa,13
	ld c,(xsp+5)
	extz bc
	sub wa,bc
	jr L582
L581:
	ld wa,(xsp+2)
	add wa,29
	ld c,(xsp+5)
	extz bc
	add wa,bc
L582:
	ld (xsp+8),wa
	ld izl,0
	jp L586
L583:
	ld c,ixl
	cp c,0
	jr z,L588
	ld a,1
	sub a,izl
	extz wa
	jr L589
L588:
	ld a,izl
	extz wa
L589:
	ld (xsp+11),a
L590:
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
	ld xwa,_tsm__0_L587
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
	jr z,L593
	ld wa,128
	jr L594
L593:
	ld wa,0
L594:
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
L592:
L591:
L585:
	inc 1,izl
L586:
	ld a,izl
	cp a,2
	jp ult,L583
L584:
L579:
	inc 1,ixl
L580:
	ld a,ixl
	cp a,2
	jp ult,L577
L578:
L576:
	lda xsp,(xsp+24)
	pop xiz
	ret

; function title_blink
_title_blink__0:
	ld a,(xsp+4)
	extz wa
	and wa,31
	cp wa,0
	jr nz,L600
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
	jr L601
L600:
	ld a,(xsp+4)
	extz wa
	and wa,31
	cp wa,20
	jr nz,L602
	ld a,(xsp+8)
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
L602:
L601:
L599:
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
L604:
	ret

; function map_screen
_map_screen__0:
	push xiz
	lda xsp,(xsp-26)
	call _id_road_dma_pause
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
	jr L662
L659:
	ld wa,0
	ld xbc,38912
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L661:
	inc 1,iz
L662:
	ld wa,iz
	cp wa,1024
	jr ult,L659
L660:
	ld wa,1710
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
	ldw (xsp+0),0
	jr L666
L663:
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
	jr L670
L667:
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
L669:
	incb 1,(xsp+16)
L670:
	ld a,(xsp+16)
	cp a,8
	jr ult,L667
L668:
L665:
	incw 1,(xsp+0)
L666:
	ld wa,(xsp+0)
	cp wa,171
	jr ult,L663
L664:
	ldw (xsp+0),0
	jr L674
L671:
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
L673:
	incw 1,(xsp+0)
L674:
	ld wa,(xsp+0)
	cp wa,8
	jr ult,L671
L672:
	ldb (xsp+5),0
	jp L678
L675:
	ldb (xsp+4),0
	jp L682
L679:
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
	jr nz,L683
	ld wa,0
	jr L684
L683:
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
L684:
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
L681:
	incb 1,(xsp+4)
L682:
	ld a,(xsp+4)
	cp a,20
	jp ult,L679
L680:
L677:
	incb 1,(xsp+5)
L678:
	ld a,(xsp+5)
	cp a,19
	jp ult,L675
L676:
	ld xwa,_S0_15
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
	jp L688
L685:
	ldb (xsp+7),0
	jp L692
L689:
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
	jp L696
L693:
L697:
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
	ld wa,34816
	ld c,(xsp+15)
	extz bc
	sll 2,bc
	add wa,bc
	extz xwa
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
	ld bc,35840
	ld e,(xsp+15)
	extz de
	add bc,de
	extz xbc
	ld (xbc),a
L699:
L698:
L695:
	incb 1,(xsp+14)
L696:
	ld a,(xsp+14)
	cp a,4
	jp ult,L693
L694:
	inc 1,iz
L691:
	incb 1,(xsp+7)
L692:
	ld a,(xsp+7)
	cp a,(xsp+6)
	jp ule,L689
L690:
L687:
	incb 1,(xsp+6)
L688:
	ld a,(xsp+6)
	cp a,5
	jp ult,L685
L686:
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
	jp L703
L700:
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
	jr ult,L705
	ld a,(_goal_reached__0)
	cp a,0
	jr z,L704
L705:
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
	jr L706
L704:
	ld wa,(_course_pos__0)
	mul xwa,16
	push xwa
	ld bc,(_leg_len)
	cp bc,0
	jr z,L707
	ld wa,(_leg_len)
	jr L708
L707:
	ld wa,1
L708:
	extz xwa
	ld xbc,xwa
	pop xwa
	call __div32u
	ld (xsp+8),wa
	ld wa,(xsp+8)
	cp wa,16
	jr ule,L709
	ldw (xsp+8),16
L709:
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
L706:
L702:
	incb 1,(xsp+6)
L703:
	ld a,(xsp+6)
	cp a,(_cur_stage)
	jp ule,L700
L701:
	ld a,(_goal_reached__0)
	cp a,0
	jr z,L710
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
L710:
	ldb (_map_seg__0),0
	ldw (_map_along__0),0
	ldw (_map_t__0),0
	ldw (_map_done__0),0
L658:
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
	jp uge,L732
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
	jr le,L733
	ld wa,(xsp+2)
	jr L734
L733:
	ld wa,(xsp+2)
	neg wa
L734:
	ld (xsp+6),wa
	ld bc,(xsp+4)
	cp bc,0
	jr le,L736
	ld wa,(xsp+4)
	jr L737
L736:
	ld wa,(xsp+4)
	neg wa
L737:
	cp wa,(xsp+6)
	jr le,L735
	ld bc,(xsp+4)
	cp bc,0
	jr le,L738
	ld wa,(xsp+4)
	jr L739
L738:
	ld wa,(xsp+4)
	neg wa
L739:
	ld (xsp+6),wa
L735:
	ld wa,(xsp+6)
	cp wa,0
	jr nz,L740
	ldw (xsp+6),1
L740:
	ld wa,(_map_along__0)
	cp wa,(xsp+6)
	jr lt,L741
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
	jr L742
L741:
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
L742:
	jr L743
L732:
	ld wa,(_map_done__0)
	cp wa,0
	jr nz,L744
	ld wa,(_map_t__0)
	ld (_map_done__0),wa
	ld wa,2
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L744:
L743:
L745:
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
	ld bc,35840
	ld e,(xsp+2)
	extz de
	add bc,de
	extz xbc
	ld (xbc),a
L747:
L746:
L748:
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
	ld wa,34816
	ld c,(xsp+2)
	extz bc
	sll 2,bc
	add wa,bc
	extz xwa
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
	ld bc,35840
	ld e,(xsp+2)
	extz de
	add bc,de
	extz xbc
	ld (xbc),a
L750:
L749:
L731:
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
L752:
	ret

; function trophy_load
_trophy_load__0:
	push xiz
	lda xsp,(xsp-2)
	ld iz,0
	jr L762
L759:
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
L761:
	inc 1,iz
L762:
	ld wa,iz
	cp wa,48
	jr ult,L759
L760:
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
L758:
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
	jr nz,L774
	ld wa,1
	jr L775
L774:
	ld wa,0
L775:
	ld (xsp+1),a
	ld ixl,0
	jp L779
L776:
	ld xwa,_gfx_trophy_cells
	ld c,ixl
	extz bc
	mul xbc,3
	extz xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+2),xwa
L780:
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
L782:
L781:
L778:
	inc 1,ixl
L779:
	ld a,ixl
	cp a,6
	jp ult,L776
L777:
L773:
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
	jr z,L803
	ld xwa,_S0_16
	jr L804
L803:
	ld xwa,_S0_17
L804:
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
	jr L807
L805:
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
L807:
	ld xwa,(xsp+14)
	ld c,(xsp+18)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L805
L806:
	ld a,(_difficulty)
	cp a,3
	jr nz,L808
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
	jr L809
L808:
	ld a,0
	lda xbc,(xsp+1)
	ld e,(xsp+18)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L809:
	lda xwa,(xsp+1)
	push xwa
	ld wa,4
	push xwa
	ld wa,20
	ld c,(xsp+26)
	extz bc
	ld l,(_difficulty)
	cp l,3
	jr nz,L810
	ld de,4
	jr L811
L810:
	ld de,0
L811:
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
	ld xwa,_S0_18
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
	ld xwa,_S0_19
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
	jr L815
L812:
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
	jr uge,L816
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
L816:
L814:
	inc 1,izl
L815:
	ld a,izl
	cp a,(_cur_stage)
	jr ule,L812
L813:
	ld xwa,(_score__0)
	ld xbc,_hiscore__0
	ld e,(_difficulty)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld xbc,(xbc)
	cp xwa,xbc
	jr ule,L817
	ld xwa,(_score__0)
	ld xbc,_hiscore__0
	ld e,(_difficulty)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ldb (_save_dirty__0),1
	ld xwa,_S0_20
	push xwa
	ld wa,9
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L817:
	call _banner_hide
	ld a,64
	push xwa
	ld a,28
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	ld a,(_goal_reached__0)
	cp a,0
	jr z,L818
	call _trophy_load__0
	ld c,(_difficulty)
	cp c,3
	jr nz,L819
	ld wa,5
	jr L820
L819:
	ld xwa,_route_hist
	ld c,(_cur_stage)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
L820:
	push xwa
	call _ending_start
	lda xsp,(xsp+4)
L818:
L802:
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
	jr L830
L827:
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
L829:
	inc 1,izl
L830:
	ld a,izl
	cp a,8
	jr ult,L827
L828:
L826:
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
L832:
	ret

; function balloons_launch
_balloons_launch__0:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jp L844
L841:
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
	jr z,L845
	ld wa,118
	ld c,ixl
	extz bc
	and bc,31
	add wa,bc
	jr L846
L845:
	ld wa,6
	ld c,ixl
	extz bc
	and bc,31
	add wa,bc
L846:
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
L843:
	inc 1,izl
L844:
	ld a,izl
	cp a,8
	jp ult,L841
L842:
	ldb (_bal_live__0),1
	ldb (_trf_spr_end),42
L840:
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
	jr nz,L862
	jp L861
L862:
	ld izl,0
	jp L866
L863:
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
	jr z,L867
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
	jp L865
L867:
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
	jr ge,L868
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
	jp L865
L868:
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
	jr z,L869
	ld bc,1
	jr L870
L869:
	ld bc,0
L870:
	add wa,bc
	ld (xsp+4),wa
L871:
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
	ld wa,34816
	ld c,(xsp+6)
	extz bc
	sll 2,bc
	add wa,bc
	extz xwa
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
	ld bc,35840
	ld e,(xsp+6)
	extz de
	add bc,de
	extz xbc
	ld (xbc),a
L873:
L872:
L865:
	inc 1,izl
L866:
	ld a,izl
	cp a,8
	jp ult,L863
L864:
	ld a,(xsp+1)
	cp a,0
	jr nz,L874
	ldb (_bal_live__0),0
	ldb (_trf_spr_end),50
L874:
L861:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function smoke_init
_smoke_init__0:
	push xiz
	lda xsp,(xsp-2)
	ld ixl,0
	jr L888
L885:
	ld izl,0
	jr L892
L889:
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
L891:
	inc 1,izl
L892:
	ld a,izl
	cp a,8
	jr ult,L889
L890:
L887:
	inc 1,ixl
L888:
	ld a,ixl
	cp a,4
	jr ult,L885
L886:
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
L884:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function smoke_draw
_smoke_draw__0:
	push xiz
	lda xsp,(xsp-24)
	ld a,(xsp+32)
	cp a,0
	jr nz,L916
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
	jp L915
L916:
	ld a,(_smoke_t__0)
	extz wa
	and wa,7
	cp wa,0
	jr nz,L917
	ld a,(xsp+36)
	cp a,0
	jr nz,L917
	push xix
	push xiy
	ld wa,7
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L917:
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
	jp L921
L918:
	ld c,ixl
	cp c,0
	jr nz,L922
	ld wa,(xsp+0)
	sub wa,11
	ld c,(_smoke_t__0)
	extz bc
	sra 2,bc
	and bc,1
	sub wa,bc
	jr L923
L922:
	ld wa,(xsp+0)
	add wa,27
	ld c,(_smoke_t__0)
	extz bc
	sra 2,bc
	and bc,1
	add wa,bc
L923:
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
	jp L927
L924:
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
	jr z,L928
	ld a,1
	sub a,izl
	extz wa
	jr L929
L928:
	ld a,izl
	extz wa
L929:
	ld (xsp+9),a
	ld wa,(xsp+6)
	ld c,izl
	extz bc
	sll 3,bc
	add wa,bc
	ld (xsp+10),wa
	ld wa,(xsp+10)
	cp wa,65529
	jr lt,L931
	ld wa,(xsp+10)
	cp wa,159
	jr le,L930
L931:
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
	jp L926
L930:
L932:
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
	jr z,L935
	ld wa,128
	jr L936
L935:
	ld wa,0
L936:
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
L934:
L933:
L926:
	inc 1,izl
L927:
	ld a,izl
	cp a,2
	jp ult,L924
L925:
L920:
	inc 1,ixl
L921:
	ld a,ixl
	cp a,2
	jp ult,L918
L919:
L915:
	lda xsp,(xsp+24)
	pop xiz
	ret

; function engine_sound
_engine_sound__0:
	push xiz
	lda xsp,(xsp-10)
	ld c,(_gear__0)
	cp c,0
	jr nz,L952
	ld wa,137
	jr L953
L952:
	ld wa,224
L953:
	ld (xsp+0),wa
	ld a,(_speed__0)
	extz wa
	mul xwa,255
	extz xwa
	div xwa,(xsp+0)
	ld ix,wa
	ld wa,ix
	cp wa,255
	jr ule,L954
	ld ix,255
L954:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L955
	ld ix,0
L955:
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
	jr z,L956
	ld wa,iz
	ld bc,iz
	ld l,(_offroad__0)
	cp l,0
	jr z,L957
	ld l,(_speed__0)
	cp l,20
	jr ule,L957
	ld de,3
	jr L958
L957:
	ld de,5
L958:
	cp e,0
	jr z,L960
L959:
	srl 1,bc
	djnz e,L959
L960:
	add wa,bc
	ld iz,wa
L956:
	ld c,(_ngpc_pad_held)
	extz bc
	and bc,16
	cp bc,0
	jr z,L961
	ld wa,4
	jr L962
L961:
	ld wa,6
L962:
	ld iyl,a
	ld a,(_state__0)
	cp a,4
	jr z,L964
	ld a,(_state__0)
	cp a,3
	jr nz,L963
L964:
	ld iyl,9
L963:
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
L951:
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
	jr ult,L986
	ldb (xsp+0),11
L986:
	ld a,(_roll_kind__0)
	cp a,0
	jr z,L987
	ld a,(xsp+0)
	add a,12
	ld (xsp+0),a
	jr L988
L987:
	ld a,(_roll_dir__0)
	cp a,0
	jr nz,L989
	ld wa,12
	ld c,(xsp+0)
	extz bc
	sub wa,bc
	exts xwa
	divs xwa,12
	ld wa,qwa
	ld (xsp+0),a
L989:
L988:
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
	jp z,L990
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
	jr L994
L991:
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
L993:
	incw 1,(xsp+16)
L994:
	ld wa,(xsp+16)
	cp wa,(xsp+14)
	jr ult,L991
L992:
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
L990:
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
	jr z,L995
	ld a,(xsp+1)
	extz wa
	ld c,(xsp+1)
	extz bc
	sra 1,bc
	add wa,bc
	ld (xsp+1),a
L995:
	ld wa,136
	ld c,(xsp+1)
	extz bc
	sub wa,bc
	ld (xsp+10),wa
	ld izl,0
	jp L999
L996:
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
	jr lt,L1001
	ld wa,(xsp+18)
	cp wa,159
	jr gt,L1001
	ld wa,iy
	cp wa,65529
	jr lt,L1001
	ld wa,iy
	cp wa,151
	jr le,L1000
L1001:
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
	jp L998
L1000:
L1002:
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
	ld wa,34816
	ld c,(xsp+22)
	extz bc
	sll 2,bc
	add wa,bc
	extz xwa
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
	ld bc,35840
	ld e,(xsp+22)
	extz de
	add bc,de
	extz xbc
	ld (xbc),a
L1004:
L1003:
L998:
	inc 1,izl
L999:
	ld a,izl
	ld xbc,(xsp+2)
	ld c,(xbc+2)
	cp a,c
	jp ult,L996
L997:
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
L985:
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
	jr ge,L1021
	ld wa,ix
	cp wa,65484
	jr gt,L1020
L1021:
	ld wa,0
	jp L1019
L1020:
	ldb (xsp+1),0
	jr L1025
L1022:
	inc 1,izl
	ld a,izl
	cp a,(_track_len)
	jr ult,L1026
	ld izl,0
L1026:
	ld xwa,(_track_seg)
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld wa,(xwa+2)
	ld ix,wa
	ld wa,ix
	cp wa,52
	jr ge,L1028
	ld wa,ix
	cp wa,65484
	jr gt,L1027
L1028:
	ld wa,iy
	cp wa,150
	jr uge,L1029
	ld wa,0
	jr L1019
L1029:
	ld bc,ix
	cp bc,0
	jr le,L1030
	ld wa,1
	jr L1031
L1030:
	ld wa,65535
L1031:
	jr L1019
L1027:
	ld wa,iy
	ld xbc,(_track_seg)
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld iy,wa
L1024:
	incb 1,(xsp+1)
L1025:
	ld a,(xsp+1)
	cp a,6
	jr uge,L1032
	ld wa,iy
	cp wa,1300
	jr ult,L1022
L1032:
L1023:
	ld wa,0
	jr L1019
L1019:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function game_tick
_game_tick__0:
	push xiz
	lda xsp,(xsp-8)
	ld a,(_state__0)
	cp a,0
	jp nz,L1153
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
	jr z,L1154
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,8
	cp wa,0
	jr z,L1155
	ld a,(_station__0)
	extz wa
	add wa,1
	and wa,3
	ld (_station__0),a
	jr L1156
L1155:
	ld a,(_station__0)
	extz wa
	add wa,4
	sub wa,1
	and wa,3
	ld (_station__0),a
L1156:
	ldb (_save_dirty__0),1
	call _title_texts__0
	ld a,(_station__0)
	push xwa
	call _music_play
	lda xsp,(xsp+4)
L1154:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,3
	cp wa,0
	jr z,L1157
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,2
	cp wa,0
	jr z,L1158
	ld a,(_difficulty)
	extz wa
	add wa,1
	and wa,3
	ld (_difficulty),a
	jr L1159
L1158:
	ld a,(_difficulty)
	extz wa
	add wa,4
	sub wa,1
	and wa,3
	ld (_difficulty),a
L1159:
	ld a,(_difficulty)
	cp a,3
	jr nz,L1160
	call _new_seed__0
L1160:
	ldb (_save_dirty__0),1
	ld wa,0
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	call _title_texts__0
L1157:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,32
	cp wa,0
	jr z,L1161
	ld a,(_difficulty)
	cp a,3
	jr nz,L1161
	call _new_seed__0
	ldb (_save_dirty__0),1
	ld wa,0
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	call _title_texts__0
L1161:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,16
	cp wa,0
	jr z,L1162
	call _title_leave__0
	call _new_game__0
	ldb (_state__0),1
	ldb (_state_timer__0),0
L1162:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
	jp L1163
L1153:
	ld a,(_state__0)
	cp a,6
	jr nz,L1164
	incw 1,(_map_t__0)
	ld wa,(_map_along__0)
	add wa,2
	ld (_map_along__0),wa
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,16
	cp wa,0
	jr z,L1167
	ld wa,(_map_t__0)
	cp wa,20
	jr ugt,L1166
L1167:
	ld wa,(_map_done__0)
	cp wa,0
	jr z,L1165
	ld wa,(_map_t__0)
	ld bc,(_map_done__0)
	add bc,75
	cp wa,bc
	jr ule,L1165
L1166:
	call _map_leave__0
	ldb (_state__0),5
	ldb (_state_timer__0),0
	call _result_screen__0
L1165:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
	jp L1168
L1164:
	ld a,(_state__0)
	cp a,5
	jr nz,L1169
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,16
	cp wa,0
	jr z,L1170
	ld a,(_state_timer__0)
	cp a,30
	jr ule,L1170
	ldb (_state__0),0
	ldb (_state_timer__0),0
	call _new_game__0
	call _title_screen__0
	ld a,(_station__0)
	push xwa
	call _music_play
	lda xsp,(xsp+4)
L1170:
	ld a,(_state_timer__0)
	cp a,255
	jr uge,L1171
	incb 1,(_state_timer__0)
L1171:
	ld a,(_state_timer__0)
	cp a,30
	jr ule,L1172
	ld wa,13
	push xwa
	ld a,(_state_timer__0)
	push xwa
	call _title_blink__0
	lda xsp,(xsp+8)
L1172:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
	jr L1173
L1169:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,64
	cp wa,0
	jr z,L1174
	ld c,(_paused__0)
	cp c,0
	jr nz,L1175
	ld wa,1
	jr L1176
L1175:
	ld wa,0
L1176:
	ld (_paused__0),a
	ld a,(_paused__0)
	cp a,0
	jr z,L1177
	ld wa,0
	push xwa
	ld wa,0
	exts xwa
	push xwa
	ld xwa,_S0_21
	push xwa
	call _message__0
	lda xsp,(xsp+12)
	jr L1178
L1177:
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
L1178:
L1174:
L1173:
L1168:
L1163:
	ld a,(_paused__0)
	cp a,0
	jr z,L1179
	jp L1152
L1179:
	ld a,(_state__0)
	cp a,1
	jp nz,L1180
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
	jr nz,L1182
	ld a,(xsp+0)
	cp a,4
	jr uge,L1182
	ld wa,0
	push xwa
	ld xwa,_cd__0_L1181
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
L1182:
	incb 1,(_state_timer__0)
	ld a,(_state_timer__0)
	cp a,90
	jr ult,L1183
	ldb (_state__0),2
	ld a,(_cur_stage)
	cp a,0
	jr nz,L1184
	call _balloons_launch__0
L1184:
	ld wa,30
	push xwa
	ld xwa,(_cd__0_L1181+12)
	push xwa
	call _count_message__0
	lda xsp,(xsp+8)
	ld wa,1
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L1183:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
L1180:
	ld a,(_state__0)
	cp a,2
	jr z,L1186
	ld a,(_state__0)
	cp a,3
	jr z,L1186
	ld a,(_state__0)
	cp a,4
	jp nz,L1185
L1186:
	ld a,(_state__0)
	cp a,2
	jr nz,L1188
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L1187
L1188:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
L1187:
	ld wa,(_course_pos__0)
	ld (xsp+2),wa
	ld a,(_speed__0)
	ld (xsp+4),a
	call _drive__0
	ld a,(_offroad__0)
	cp a,0
	jr z,L1189
	ld a,(_was_offroad__0)
	cp a,0
	jr nz,L1189
	ld a,(xsp+4)
	ld (_verge_spd__0),a
	jr L1190
L1189:
	ld a,(_offroad__0)
	cp a,0
	jr z,L1191
	ld c,(_verge_spd__0)
	cp c,4
	jr ule,L1192
	ld a,(_verge_spd__0)
	sub a,4
	extz wa
	jr L1193
L1192:
	ld wa,0
L1193:
	ld (_verge_spd__0),a
	jr L1194
L1191:
	ldb (_verge_spd__0),0
L1194:
L1190:
	ld a,(_offroad__0)
	ld (_was_offroad__0),a
	call _advance__0
	ld a,(_state__0)
	cp a,2
	jp nz,L1195
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
	jr L1198
L1196:
	ld a,(_sec_acc__0)
	sub a,60
	ld (_sec_acc__0),a
	ld a,(_time_left__0)
	cp a,0
	jr z,L1199
	decb 1,(_time_left__0)
L1199:
	ld a,(_time_left__0)
	cp a,0
	jr z,L1200
	ld a,(_time_left__0)
	cp a,10
	jr ugt,L1200
	ld wa,5
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L1200:
L1198:
	ld a,(_sec_acc__0)
	cp a,60
	jr uge,L1196
L1197:
	ld a,(_time_left__0)
	cp a,0
	jr nz,L1201
	ldb (_state__0),3
	ldb (_state_timer__0),0
	ld wa,0
	push xwa
	ld wa,0
	exts xwa
	push xwa
	ld xwa,_S0_22
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
L1201:
L1195:
	ld wa,(_course_pos__0)
	push xwa
	call _course_fork_zone
	lda xsp,(xsp+4)
	ld (xsp+0),a
	ld a,(xsp+0)
	cp a,0
	jp z,L1202
	call _course_is_last_stage
	cp a,0
	jp nz,L1202
	ld a,(_last_fork_zone__0)
	cp a,0
	jr nz,L1203
	ld wa,1
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	ld xwa,_S0_23
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
L1203:
	ld a,(_fork_choice)
	cp a,0
	jr nz,L1204
	ld wa,(_course_pos__0)
	add wa,850
	cp wa,(_leg_len)
	jr ult,L1204
	ld bc,(_car_lat__0)
	cp bc,0
	jr le,L1205
	ld wa,1
	jr L1206
L1205:
	ld wa,0
L1206:
	push xwa
	call _course_decide
	lda xsp,(xsp+4)
	ld wa,3
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld a,(_fork_choice)
	cp a,2
	jr nz,L1207
	ld xwa,_S0_24
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
	jr L1208
L1207:
	ld xwa,_S0_25
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
L1208:
L1204:
	jp L1209
L1202:
	ld a,(xsp+0)
	cp a,0
	jr z,L1210
	call _course_is_last_stage
	cp a,0
	jr z,L1210
	ld a,(_last_fork_zone__0)
	cp a,0
	jr nz,L1211
	ld xwa,_S0_26
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
L1211:
	ld wa,5
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L1212
L1210:
	ld a,(_cur_stage)
	cp a,0
	jr nz,L1213
	ld wa,(_course_pos__0)
	cp wa,900
	jr uge,L1213
	ld wa,5
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L1214
L1213:
	ld wa,(_course_pos__0)
	push xwa
	call _course_start_zone
	lda xsp,(xsp+4)
	cp a,0
	jr z,L1215
	ld wa,2
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L1216
L1215:
	call _sharp_ahead__0
	ld (xsp+4),a
	ld c,(xsp+4)
	cp c,0
	jr le,L1217
	ld wa,3
	jr L1218
L1217:
	ld c,(xsp+4)
	cp c,0
	jr ge,L1219
	ld wa,4
	jr L1220
L1219:
	ld wa,0
L1220:
L1218:
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
L1216:
L1214:
L1212:
L1209:
	ld a,(xsp+0)
	ld (_last_fork_zone__0),a
	ld a,(_goal_reached__0)
	cp a,0
	jr nz,L1221
	ld wa,(_course_pos__0)
	cp wa,(_leg_len)
	jr ult,L1221
	ldb (_last_fork_zone__0),0
	call _leg_end__0
L1221:
	ld a,(_speed__0)
	push xwa
	call _id_scenery_advance
	lda xsp,(xsp+4)
	ld a,(_state__0)
	cp a,2
	jp nz,L1222
	ld a,(_crash_timer__0)
	cp a,0
	jp nz,L1222
	ld a,(_speed__0)
	push xwa
	ld wa,(_car_lat__0)
	push xwa
	call _traffic_collide
	lda xsp,(xsp+8)
	ld (xsp+4),a
	ld a,(xsp+4)
	cp a,0
	jr z,L1223
	ld a,(_speed__0)
	extz wa
	mul xwa,15
	srl 4,wa
	add wa,6
	ld (xsp+6),wa
	ld c,(xsp+4)
	cp c,1
	jr nz,L1224
	ld wa,(xsp+6)
	jr L1225
L1224:
	ld wa,(xsp+6)
	neg wa
L1225:
	ld (_knock_v__0),wa
	ldb (_knock_t__0),1
	ld wa,(_dbg_knock_at)
	cp wa,0
	jr nz,L1226
	ld a,(_speed__0)
	cp a,100
	jr ule,L1226
	ld wa,(_dbg_updates)
	ld (_dbg_knock_at),wa
L1226:
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
	jp L1227
L1223:
	ld wa,147
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_scenery_hit
	lda xsp,(xsp+8)
	cp a,0
	jr nz,L1229
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
	jp z,L1228
L1229:
	ld c,(_verge_spd__0)
	cp c,(_speed__0)
	jr ule,L1230
	ld a,(_verge_spd__0)
	extz wa
	jr L1231
L1230:
	ld a,(_speed__0)
	extz wa
L1231:
	ld (xsp+5),a
	ld a,(xsp+5)
	cp a,110
	jp ule,L1232
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
	jr ult,L1233
	ldb (_roll_t__0),1
	ld c,(xsp+5)
	cp c,214
	jr ult,L1234
	ld wa,1
	jr L1235
L1234:
	ld wa,0
L1235:
	ld (_roll_kind__0),a
	ld a,(_roll_kind__0)
	cp a,0
	jr z,L1236
	incb 1,(_dbg_flips)
	ld wa,(_dbg_flip_at)
	cp wa,0
	jr nz,L1237
	ld wa,(_dbg_updates)
	ld (_dbg_flip_at),wa
L1237:
	jr L1238
L1236:
	incb 1,(_dbg_rolls)
L1238:
	ld wa,(_dbg_roll_at)
	cp wa,0
	jr nz,L1239
	ld wa,(_dbg_updates)
	ld (_dbg_roll_at),wa
L1239:
	ld bc,(_car_lat__0)
	cp bc,0
	jr gt,L1242
	ld bc,(_car_lat__0)
	cp bc,0
	jr nz,L1240
	ld c,(_g_vb_counter)
	extz bc
	and bc,1
	cp bc,0
	jr z,L1240
L1242:
	ld wa,1
	jr L1241
L1240:
	ld wa,0
L1241:
	ld (_roll_dir__0),a
L1233:
	incb 1,(_dbg_crashes)
	ld wa,3
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	jr L1243
L1232:
	ld wa,48
	ld (xsp+6),a
	ld a,(_speed__0)
	extz wa
	sra 1,wa
	ld (xsp+7),a
	ld a,(xsp+6)
	cp a,(xsp+7)
	jr ule,L1244
	ld a,(xsp+7)
	ld (xsp+6),a
L1244:
	ld c,(_speed__0)
	cp c,(xsp+6)
	jr ule,L1245
	ld a,(_speed__0)
	sub a,(xsp+6)
	extz wa
	jr L1246
L1245:
	ld wa,0
L1246:
	ld (_speed__0),a
	ld wa,4
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L1243:
L1228:
L1227:
L1222:
	ld wa,(_knock_v__0)
	cp wa,0
	jr z,L1247
	ld wa,(_car_lat__0)
	add wa,(_knock_v__0)
	ld (_car_lat__0),wa
	ld wa,(_car_lat__0)
	cp wa,(_lat_limit__0)
	jr le,L1248
	ld wa,(_lat_limit__0)
	ld (_car_lat__0),wa
L1248:
	ld wa,(_car_lat__0)
	ld bc,(_lat_limit__0)
	neg bc
	cp wa,bc
	jr ge,L1249
	ld wa,(_lat_limit__0)
	neg wa
	ld (_car_lat__0),wa
L1249:
	ld wa,(_knock_v__0)
	mul xwa,7
	exts xwa
	divs xwa,8
	ld (_knock_v__0),wa
	ld wa,(_knock_v__0)
	cp wa,65524
	jr le,L1250
	ld wa,(_knock_v__0)
	cp wa,12
	jr ge,L1250
	ldw (_knock_v__0),0
L1250:
L1247:
	ld a,(_knock_t__0)
	cp a,0
	jr z,L1251
	incb 1,(_knock_t__0)
	ld a,(_knock_t__0)
	cp a,26
	jr ule,L1252
	ldb (_knock_t__0),0
L1252:
L1251:
	ld a,(_roll_t__0)
	cp a,0
	jr z,L1253
	incb 1,(_roll_t__0)
	ld a,(_roll_t__0)
	cp a,36
	jr ule,L1254
	ldb (_roll_t__0),0
	ldb (_roll_loaded__0),255
	call _id_car_restore
L1254:
L1253:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L1255
	decb 1,(_crash_timer__0)
	ld c,(_speed__0)
	cp c,12
	jr ule,L1256
	ld a,(_speed__0)
	sub a,12
	extz wa
	jr L1257
L1256:
	ld wa,0
L1257:
	ld (_speed__0),a
	ld a,(_crash_timer__0)
	cp a,0
	jr nz,L1258
	ld wa,(_car_lat__0)
	exts xwa
	divs xwa,2
	ld (_car_lat__0),wa
	ldb (_speed__0),0
	ldb (_gear__0),0
L1258:
L1255:
	ld c,(_state__0)
	cp c,2
	jr nz,L1259
	push xwa
	ld wa,(_course_pos__0)
	push xwa
	call _course_fork_zone
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp c,0
	jr nz,L1259
	ld wa,1
	jr L1260
L1259:
	ld wa,0
L1260:
	push xwa
	ld a,(_speed__0)
	push xwa
	call _traffic_update
	lda xsp,(xsp+8)
	ld a,(_state__0)
	cp a,3
	jr nz,L1261
	incb 1,(_state_timer__0)
	ld a,(_speed__0)
	cp a,0
	jr nz,L1262
	ld a,(_state_timer__0)
	cp a,60
	jr ule,L1262
	ldb (_state__0),6
	ldb (_state_timer__0),0
	call _map_screen__0
L1262:
	jr L1263
L1261:
	ld a,(_state__0)
	cp a,4
	jr nz,L1264
	incb 1,(_state_timer__0)
	ld a,(_state_timer__0)
	cp a,1
	jr nz,L1265
	ld xwa,(_score__0)
	ld c,(_time_left__0)
	extz bc
	muls xbc,20000
	add xwa,xbc
	ld (_score__0),xwa
	ld izl,0
	jr L1269
L1266:
	ld wa,20000
	push xwa
	call _hud_score_add
	lda xsp,(xsp+4)
L1268:
	inc 1,izl
L1269:
	ld a,izl
	cp a,(_time_left__0)
	jr ult,L1266
L1267:
L1265:
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
L1264:
L1263:
L1185:
L1152:
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
	jr L1335
L1332:
	ld bc,(xsp+2)
	cp bc,0
	jr le,L1336
	call _id_road_grade_hi
	exts wa
	jr L1337
L1336:
	call _id_road_grade_lo
	exts wa
	neg wa
L1337:
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
L1334:
	incw 1,(xsp+2)
L1335:
	ld wa,(xsp+2)
	cp wa,6
	jr le,L1332
L1333:
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
L1338:
	jr L1344
L1342:
	call _ngpc_vsync
L1344:
	ld a,(_g_vb_counter)
	sub a,(_pace_prev__0)
	cp a,2
	jr ult,L1342
L1343:
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
	jr ule,L1345
	ldb (xsp+10),3
	ld a,(xsp+8)
	ld c,(xsp+9)
	and c,1
	sub a,c
	ld (_pace_prev__0),a
	jr L1346
L1345:
	ld a,(_pace_prev__0)
	extz wa
	ld c,(xsp+10)
	extz bc
	sll 1,bc
	extz bc
	add wa,bc
	ld (_pace_prev__0),a
L1346:
	call _ngpc_input_update
	call _audio_update
	incw 1,(_dbg_updates)
	ld a,(xsp+8)
	ld (_clock_prev__0),a
	ld izl,0
	jr L1350
L1347:
	ld wa,2
	push xwa
	call _game_tick__0
	lda xsp,(xsp+4)
	ld a,izl
	cp a,0
	jr nz,L1351
	ldb (_ngpc_pad_pressed),0
L1351:
L1349:
	inc 1,izl
L1350:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L1347
L1348:
	ld a,(_state__0)
	cp a,0
	jr nz,L1352
	ld a,(_state_timer__0)
	push xwa
	call _title_car__0
	lda xsp,(xsp+4)
	call _player_engine_off
	jp L1340
L1352:
	ld a,(_state__0)
	cp a,6
	jr nz,L1353
	call _map_car__0
	call _player_engine_off
	jp L1340
L1353:
	call _render_road__0
	call _tick_flash__0
	call _tick_message__0
	ld a,(_state__0)
	cp a,0
	jr z,L1354
	ld a,(_state__0)
	cp a,5
	jr z,L1354
	ld wa,(_course_pos__0)
	push xwa
	call _bridge_draw
	lda xsp,(xsp+4)
	call _id_scenery_draw
	call _traffic_draw
	call _balloons_draw__0
L1354:
	ld a,(_state__0)
	cp a,1
	jr z,L1356
	ld a,(_state__0)
	cp a,2
	jr nz,L1355
	ld a,(_cur_stage)
	cp a,0
	jr nz,L1355
	ld wa,(_course_pos__0)
	cp wa,220
	jr uge,L1355
L1356:
	ld xwa,_S0_31
	push xwa
	ld wa,0
	push xwa
	ld wa,120
	ld bc,(_course_pos__0)
	sub wa,bc
	push xwa
	call _banner_show
	lda xsp,(xsp+12)
	jr L1357
L1355:
	ld a,(_state__0)
	cp a,2
	jr z,L1359
	ld a,(_state__0)
	cp a,4
	jr z,L1359
	ld a,(_state__0)
	cp a,3
	jr nz,L1358
L1359:
	call _course_is_last_stage
	cp a,0
	jr z,L1358
	ld wa,(_course_pos__0)
	ld bc,(_leg_len)
	sub bc,1400
	cp wa,bc
	jr le,L1358
	ld xwa,_S0_32
	push xwa
	ld wa,1
	push xwa
	ld wa,(_leg_len)
	ld bc,(_course_pos__0)
	sub wa,bc
	push xwa
	call _banner_show
	lda xsp,(xsp+12)
	jr L1360
L1358:
	call _banner_hide
L1360:
L1357:
	ld a,(_state__0)
	cp a,5
	jr nz,L1361
	ld a,(_goal_reached__0)
	cp a,0
	jr z,L1361
	call _trophy_draw__0
	call _ending_tick
L1361:
	ld a,(_state__0)
	cp a,2
	jr z,L1363
	ld a,(_state__0)
	cp a,1
	jr z,L1363
	ld a,(_state__0)
	cp a,3
	jr z,L1363
	ld a,(_state__0)
	cp a,4
	jr nz,L1362
L1363:
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
	jr nz,L1364
	ld c,(_speed__0)
	cp c,123
	jr ult,L1364
	ld c,(_g_vb_counter)
	extz bc
	and bc,8
	cp bc,0
	jr z,L1364
	ld wa,2
	jr L1365
L1364:
	ld a,(_gear__0)
	extz wa
L1365:
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
L1362:
	ld a,(_roll_t__0)
	cp a,0
	jr z,L1366
	call _roll_draw__0
	jp L1367
L1366:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L1368
	ld a,(_crash_timer__0)
	extz wa
	and wa,2
	cp wa,0
	jr z,L1368
	ld wa,2
	push xwa
	ld c,(_crash_timer__0)
	extz bc
	and bc,4
	cp bc,0
	jr z,L1369
	ld wa,1
	jr L1370
L1369:
	ld wa,65535
L1370:
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_car_draw
	lda xsp,(xsp+12)
	jp L1371
L1368:
	ld a,(_knock_t__0)
	cp a,0
	jr z,L1372
	ld c,(_knock_t__0)
	extz bc
	sra 2,bc
	and bc,1
	cp bc,0
	jr z,L1373
	ld wa,1
	jr L1374
L1373:
	ld wa,65535
L1374:
	ld (xsp+12),a
	ld c,(_knock_t__0)
	cp c,18
	jr uge,L1375
	ld a,(xsp+12)
	exts wa
	sll 1,wa
	jr L1376
L1375:
	ld wa,0
L1376:
	ld (xsp+14),wa
	ld c,(_offroad__0)
	cp c,0
	jr z,L1377
	ld c,(_speed__0)
	cp c,20
	jr ule,L1377
	ld wa,1
	jr L1378
L1377:
	ld wa,0
L1378:
	push xwa
	ld a,(xsp+16)
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	add wa,(xsp+22)
	push xwa
	call _id_car_draw
	lda xsp,(xsp+12)
	jr L1379
L1372:
	ld c,(_offroad__0)
	cp c,0
	jr z,L1380
	ld c,(_speed__0)
	cp c,20
	jr ule,L1380
	ld wa,1
	jr L1381
L1380:
	ld wa,0
L1381:
	push xwa
	ld a,(_car_lean__0)
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_car_draw
	lda xsp,(xsp+12)
L1379:
L1371:
L1367:
	ld c,(_knock_t__0)
	cp c,0
	jr z,L1382
	ld c,(_knock_t__0)
	cp c,5
	jr uge,L1382
	ld wa,1
	jr L1383
L1382:
	ld wa,0
L1383:
	push xwa
	ld c,(_skid__0)
	cp c,0
	jr nz,L1386
	ld c,(_knock_t__0)
	cp c,0
	jr z,L1384
	ld c,(_knock_t__0)
	cp c,20
	jr uge,L1384
	ld c,(_speed__0)
	cp c,30
	jr ule,L1384
L1386:
	ld c,(_crash_timer__0)
	cp c,0
	jr nz,L1384
	ld c,(_state__0)
	cp c,2
	jr nz,L1384
	ld wa,1
	jr L1385
L1384:
	ld wa,0
L1385:
	push xwa
	call _smoke_draw__0
	lda xsp,(xsp+8)
	ld a,(_offroad__0)
	cp a,0
	jr z,L1387
	ld a,(_state__0)
	cp a,2
	jr nz,L1387
	incb 1,(_dbg_off)
L1387:
	ld a,(_state__0)
	cp a,2
	jr z,L1389
	ld a,(_state__0)
	cp a,1
	jr z,L1389
	ld a,(_state__0)
	cp a,3
	jr z,L1389
	ld a,(_state__0)
	cp a,4
	jr nz,L1388
L1389:
	call _engine_sound__0
	jr L1390
L1388:
	call _player_engine_off
L1390:
L1340:
L1341:
	jp L1338
L1339:
L1331:
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
L1392:
	ret

; function player_engine_off
_player_engine_off:
	ldb (_eng_on__10),0
L1394:
	ret

; function player_init
_player_init:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,28672
	ld xix,xwa
	ldw (0B8h),43690
	ld izl,0
	jr L1408
L1405:
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
L1407:
	inc 1,izl
L1408:
	ld a,izl
	cp a,65
	jr ult,L1405
L1406:
	ldw (0B8h),21845
	ld izl,0
	jr L1412
L1409:
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
L1411:
	inc 1,izl
L1412:
	ld a,izl
	cp a,4
	jr ult,L1409
L1410:
	ldb (_playing__10),0
	ld a,(_g_vb_counter)
	ld (_last_vbl__10),a
L1404:
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
	jp L1422
L1419:
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
L1421:
	inc 1,izl
L1422:
	ld a,izl
	cp a,4
	jp ult,L1419
L1420:
	ldb (_playing__10),1
	ld a,(_g_vb_counter)
	ld (_last_vbl__10),a
L1418:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function player_stop
_player_stop:
	push xiz
	lda xsp,(xsp-2)
	ldb (_playing__10),0
	ld izl,0
	jr L1432
L1429:
	ld a,0
	ld xbc,_voice__10
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+15),a
L1431:
	inc 1,izl
L1432:
	ld a,izl
	cp a,4
	jr ult,L1429
L1430:
L1428:
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
	jp L1449
L1447:
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld ixl,a
	incb 1,(xsp+0)
	ld a,ixl
	cp a,0
	jr nz,L1450
	ld xwa,(xiz+4)
	ld (xiz),xwa
	jp L1449
L1450:
	ld a,ixl
	cp a,240
	jr nz,L1451
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld (xiz+13),a
	jp L1449
L1451:
	ld a,ixl
	cp a,244
	jr nz,L1452
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld (xiz+14),a
	ld a,(xiz+14)
	cp a,17
	jr ule,L1453
	ldb (xiz+14),0
L1453:
	jr L1449
L1452:
	ld a,ixl
	cp a,255
	jr nz,L1454
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	extz wa
	ld (xiz+8),wa
	ldb (xiz+15),0
	jr L1449
L1454:
	ld a,ixl
	cp a,240
	jr ult,L1455
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	jr L1449
L1455:
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
	jr nz,L1456
	ld a,ixl
	extz wa
	sub wa,1
	and wa,7
	ld (xiz+10),wa
	ldb (xiz+16),1
	jr L1457
L1456:
	push xix
	ld a,ixl
	push xwa
	call _note_div
	lda xsp,(xsp+4)
	pop xix
	ld (xiz+10),wa
L1457:
L1449:
	ld wa,(xiz+8)
	cp wa,0
	jr nz,L1458
	ld a,(xsp+0)
	cp a,32
	jp ult,L1447
L1458:
L1448:
L1446:
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
	jr ule,L1462
	ld izl,50
L1462:
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
	jr L1461
L1461:
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
	jr z,L1479
	jp L1478
L1479:
	ld izl,0
	jp L1483
L1480:
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
	jr uge,L1484
	ld wa,ix
	ld xbc,_sent_div__10
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L1485
	ld a,(xsp+8)
	ld xbc,_sent_attn__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr nz,L1485
	jp L1482
L1485:
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
	jr L1486
L1484:
	ld a,(_noise_trig__10)
	cp a,0
	jr nz,L1487
	ld wa,ix
	cp wa,(_sent_div__10+6)
	jr nz,L1487
	ld a,(xsp+8)
	cp a,(_sent_attn__10+3)
	jr nz,L1487
	jp L1482
L1487:
	ld a,(_noise_trig__10)
	cp a,0
	jr nz,L1489
	ld wa,ix
	cp wa,(_sent_div__10+6)
	jr z,L1488
L1489:
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
	jr L1490
L1488:
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
L1490:
	ld a,240
	ld c,(xsp+8)
	and c,15
	or a,c
	ld (xiy+2),a
	ldb (_noise_trig__10),0
L1486:
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
L1482:
	inc 1,izl
L1483:
	ld a,izl
	cp a,4
	jr uge,L1491
	ld a,(xsp+0)
	cp a,5
	jp ult,L1480
L1491:
L1481:
	ld a,(xsp+0)
	cp a,0
	jr z,L1492
	ld a,(xsp+0)
	ld (07003h),a
L1492:
L1478:
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
	jr ule,L1515
	ld iyl,8
L1515:
	ld izl,0
	jp L1519
L1516:
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
	jp z,L1520
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
	jr ule,L1521
	ld wa,(xix+8)
	ld c,iyl
	extz bc
	sub wa,bc
	ld (xix+8),wa
	jr L1522
L1521:
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
L1522:
	ld a,(xix+12)
	cp a,250
	jr uge,L1523
	ld a,(xix+12)
	add a,iyl
	ld (xix+12),a
L1523:
	ld a,(xix+15)
	cp a,0
	jr z,L1524
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
	jr ule,L1525
	ld xwa,(xsp+10)
	ld a,(xwa+1)
	ld (xsp+14),a
L1525:
	ld a,(xix+13)
	add a,(xsp+14)
	ld (xsp+3),a
	ld a,(xsp+3)
	cp a,15
	jr ule,L1526
	ldb (xsp+3),15
L1526:
	ld wa,(xix+10)
	ld (xsp+4),wa
	ld a,izl
	cp a,3
	jr nz,L1527
	ld a,(xix+16)
	cp a,0
	jr z,L1527
	ldb (xix+16),0
	ldb (_noise_trig__10),1
L1527:
L1524:
L1520:
	ld a,izl
	cp a,2
	jr nz,L1528
	ld a,(_eng_on__10)
	cp a,0
	jr z,L1528
	ld wa,(_eng_div__10)
	ld (xsp+4),wa
	ld a,(_eng_attn__10)
	ld (xsp+3),a
L1528:
	ld xwa,_sfx_frames__10
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L1529
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
	jr z,L1530
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
	jr ule,L1531
	ldb (xsp+6),15
L1531:
L1530:
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
	jr uge,L1532
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
L1532:
	ld xbc,_sfx_frames__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp c,iyl
	jr ule,L1533
	ld xwa,_sfx_frames__10
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	sub a,iyl
	extz wa
	jr L1534
L1533:
	ld wa,0
L1534:
	ld xbc,_sfx_frames__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1529:
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
L1518:
	inc 1,izl
L1519:
	ld a,izl
	cp a,4
	jp ult,L1516
L1517:
	push xix
	push xiy
	call _flush__10
	pop xiy
	pop xix
L1514:
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
L1536:
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
L1538:
	ret

; function banner_init
_banner_init:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,41520
	ld xix,xwa
	ld izl,0
	jr L1548
L1545:
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
L1547:
	inc 1,izl
L1548:
	ld a,izl
	cp a,40
	jr ult,L1545
L1546:
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
L1544:
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
	jr ult,L1552
	ld izl,0
L1552:
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
L1551:
	pop xiz
	ret

; function erase
_erase__11:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_b_on__11)
	cp a,0
	jr nz,L1564
	jr L1563
L1564:
	ld a,(_b_r0__11)
	ld ixl,a
	jr L1568
L1565:
	ld a,(_b_c0__11)
	ld izl,a
	jr L1572
L1569:
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
L1571:
	inc 1,izl
L1572:
	ld a,izl
	cp a,(_b_c1__11)
	jr ule,L1569
L1570:
L1567:
	inc 1,ixl
L1568:
	ld a,ixl
	cp a,(_b_foot__11)
	jr ule,L1565
L1566:
	ldb (_b_on__11),0
L1563:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function banner_hide
_banner_hide:
	call _erase__11
	ld a,(_b_spr__11)
	cp a,0
	jr z,L1576
	ld a,64
	push xwa
	ld a,58
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	ldb (_b_spr__11),0
L1576:
L1575:
	ret

; function banner_dirty
_banner_dirty:
	ldb (_b_r0__11),255
L1578:
	ret

; function banner_active
_banner_active:
	ld a,(_b_on__11)
	jr L1580
L1580:
	ret

; function banner_show
_banner_show:
	push xiz
	lda xsp,(xsp-46)
	ld wa,(xsp+54)
	cp wa,0
	jr lt,L1635
	ld wa,(xsp+54)
	cp wa,1400
	jr le,L1634
L1635:
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1633
L1634:
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
	jr nz,L1636
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1633
L1636:
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
	jr lt,L1638
	ld wa,(xsp+18)
	cp wa,151
	jr le,L1637
L1638:
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1633
L1637:
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
	jr uge,L1639
	ld a,(xsp+7)
	ld iyl,a
L1639:
	ld wa,(xsp+2)
	sra 3,wa
	ld (xsp+11),a
	ld a,(xsp+11)
	cp a,18
	jr ule,L1640
	ldb (xsp+11),18
L1640:
	ld bc,(xsp+20)
	cp bc,0
	jr ge,L1641
	ld wa,0
	jr L1642
L1641:
	ld bc,(xsp+20)
	sra 3,bc
	cp bc,19
	jr le,L1643
	ld wa,19
	jr L1644
L1643:
	ld wa,(xsp+20)
	sra 3,wa
L1644:
L1642:
	ld (xsp+9),a
	ld bc,(xsp+22)
	cp bc,0
	jr ge,L1645
	ld wa,0
	jr L1646
L1645:
	ld bc,(xsp+22)
	sra 3,bc
	cp bc,19
	jr le,L1647
	ld wa,19
	jr L1648
L1647:
	ld wa,(xsp+22)
	sra 3,wa
L1648:
L1646:
	ld (xsp+10),a
	ld a,(_b_on__11)
	cp a,0
	jr z,L1650
	ld a,(xsp+7)
	cp a,(_b_r0__11)
	jr nz,L1650
	ld a,iyl
	cp a,(_b_r1__11)
	jr nz,L1650
	ld a,(xsp+9)
	cp a,(_b_c0__11)
	jr nz,L1650
	ld a,(xsp+10)
	cp a,(_b_c1__11)
	jr nz,L1650
	ld a,(xsp+11)
	cp a,(_b_foot__11)
	jp z,L1649
L1650:
	push xix
	push xiy
	call _erase__11
	pop xiy
	pop xix
	ld a,(xsp+7)
	ld izl,a
	jp L1654
L1651:
	ld a,(xsp+9)
	ld ixl,a
	jr L1658
L1655:
	ld wa,36
	ld (xsp+26),wa
	ld a,(xsp+58)
	cp a,0
	jr z,L1659
	ld a,ixl
	cp a,(xsp+9)
	jr z,L1660
	ld a,ixl
	cp a,(xsp+10)
	jr nz,L1659
L1660:
	ldw (xsp+26),42
	jr L1661
L1659:
	ld a,izl
	cp a,(xsp+7)
	jr nz,L1662
	ld a,iyl
	cp a,(xsp+7)
	jr ule,L1662
	ldw (xsp+26),35
	jr L1663
L1662:
	ld a,izl
	cp a,iyl
	jr nz,L1664
	ld a,iyl
	cp a,(xsp+7)
	jr ule,L1664
	ldw (xsp+26),37
L1664:
L1663:
L1661:
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
L1657:
	inc 1,ixl
L1658:
	ld a,ixl
	cp a,(xsp+10)
	jr ule,L1655
L1656:
L1653:
	inc 1,izl
L1654:
	ld a,izl
	cp a,iyl
	jp ule,L1651
L1652:
	ld a,iyl
	add a,1
	ld izl,a
	jr L1668
L1665:
	ld wa,(xsp+20)
	cp wa,0
	jr lt,L1669
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
L1669:
	ld wa,(xsp+22)
	cp wa,160
	jr ge,L1670
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
L1670:
L1667:
	inc 1,izl
L1668:
	ld a,izl
	cp a,(xsp+11)
	jr ule,L1665
L1666:
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
L1649:
	ldb (xsp+14),0
	jr L1673
L1671:
	incb 1,(xsp+14)
L1673:
	ld xwa,(xsp+62)
	ld c,(xsp+14)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L1674
	ld a,(xsp+14)
	cp a,6
	jr ult,L1671
L1674:
L1672:
	ld wa,2
	mul xwa,(xsp+24)
	add wa,8
	ld c,(xsp+14)
	extz bc
	sll 3,bc
	cp wa,bc
	jr ge,L1675
	ldb (xsp+14),0
L1675:
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
	jp L1679
L1676:
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
	jr lt,L1681
	ld wa,(xsp+32)
	cp wa,159
	jr le,L1680
L1681:
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
	jp L1678
L1680:
L1682:
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
L1684:
L1683:
L1678:
	incb 1,(xsp+15)
L1679:
	ld a,(xsp+15)
	cp a,(xsp+14)
	jp ult,L1676
L1677:
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
L1633:
	lda xsp,(xsp+46)
	pop xiz
	ret

; function bridge_init
_bridge_init:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,41984
	ld xix,xwa
	ld izl,0
	jr L1698
L1695:
	ld xwa,_gfx_bridge_tiles
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
L1697:
	inc 1,izl
L1698:
	ld a,izl
	cp a,8
	jr ult,L1695
L1696:
	ld xwa,42416
	ld xix,xwa
	ld izl,0
	jr L1702
L1699:
	ld xwa,_gfx_bridge_tiles
	ld bc,8
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
L1701:
	inc 1,izl
L1702:
	ld a,izl
	cp a,40
	jr ult,L1699
L1700:
	push xix
	ld wa,147
	push xwa
	call _id_road_distance_at_line
	lda xsp,(xsp+4)
	pop xix
	ld (_car_d__12),wa
L1694:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function clear_box
_clear_box__12:
	push xiz
	lda xsp,(xsp-6)
	ld a,(_bb_r0__12)
	cp a,255
	jr nz,L1714
	jr L1713
L1714:
	ld a,(_bb_r0__12)
	ld ixl,a
	jr L1718
L1715:
	ld xwa,36864
	ld c,ixl
	extz bc
	sll 5,bc
	ld e,(_bb_c0__12)
	extz de
	add bc,de
	extz xbc
	sll 1,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld xiy,xwa
	ld a,(_bb_c0__12)
	ld izl,a
	jr L1722
L1719:
	ld wa,0
	ld xbc,xiy
	inc 2,xbc
	ld xiy,xbc
	dec 2,xbc
	ld (xbc),wa
L1721:
	inc 1,izl
L1722:
	ld a,izl
	cp a,(_bb_c1__12)
	jr ule,L1719
L1720:
L1717:
	inc 1,ixl
L1718:
	ld a,ixl
	cp a,(_bb_r1__12)
	jr ule,L1715
L1716:
	ldb (_bb_r0__12),255
L1713:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function bridge_hide
_bridge_hide:
	call _clear_box__12
	ldw (_sig_prev__12),65535
	ldb (_bridge_line),0
L1724:
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
	jr nz,L1745
	jp L1744
L1745:
	ld iyl,0
	jr L1749
L1746:
	ld xwa,(_track_seg)
	ld c,iyl
	extz bc
	muls xbc,6
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+8),xwa
	ld a,(xsp+7)
	cp a,0
	jr nz,L1750
	ld xwa,(xsp+8)
	ld wa,(xwa)
	cp wa,1010
	jr nz,L1750
	ldb (xsp+7),1
	ld wa,ix
	ld (xsp+2),wa
	ld izl,0
	jr L1754
L1751:
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
L1753:
	inc 1,izl
L1754:
	ld a,izl
	cp a,4
	jr uge,L1755
	ld a,iyl
	add a,izl
	cp a,(_track_len)
	jr ult,L1751
L1755:
L1752:
L1750:
	ld wa,ix
	ld xbc,(xsp+8)
	ld bc,(xbc)
	add wa,bc
	ld ix,wa
L1748:
	inc 1,iyl
L1749:
	ld a,iyl
	cp a,(_track_len)
	jr uge,L1756
	ld wa,ix
	cp wa,(_leg_len)
	jp ult,L1746
L1756:
L1747:
	ld a,(xsp+7)
	cp a,0
	jr nz,L1757
	jr L1744
L1757:
	ld wa,(xsp+2)
	add wa,150
	ld ix,wa
	jr L1761
L1758:
	ld wa,ix
	ld xbc,_br_at__12
	ld e,(_br_n__12)
	incb 1,(_br_n__12)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1760:
	ld wa,ix
	add wa,260
	ld ix,wa
L1761:
	ld wa,ix
	add wa,100
	ld bc,(xsp+2)
	add bc,(xsp+4)
	cp wa,bc
	jr uge,L1762
	ld a,(_br_n__12)
	cp a,12
	jr ult,L1758
L1762:
L1759:
L1744:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function clamp_col
_clamp_col__12:
	push xiz
	ld iz,(xsp+8)
	ld wa,iz
	cp wa,0
	jr ge,L1767
	ld wa,0
	jr L1766
L1767:
	ld wa,iz
	cp wa,159
	jr le,L1768
	ld wa,19
	jr L1766
L1768:
	ld wa,iz
	sra 3,wa
	jr L1766
L1766:
	pop xiz
	ret

; function bridge_draw
_bridge_draw:
	push xiz
	lda xsp,(xsp-136)
	ld wa,0
	ld (xsp+2),wa
	ld wa,0
	ld iyl,a
	ldb (_bridge_line),0
	ld a,(_br_n__12)
	cp a,0
	jr nz,L1837
	jp L1836
L1837:
	ldb (xsp+0),0
	jp L1841
L1838:
	ld xwa,_br_at__12
	ld c,(xsp+0)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	sub wa,(xsp+144)
	ld (xsp+114),wa
	ld wa,(xsp+114)
	cp wa,0
	jr le,L1843
	ld wa,(xsp+114)
	cp wa,1450
	jr le,L1842
L1843:
	jp L1840
L1842:
	push xix
	push xiy
	ld wa,(xsp+122)
	add wa,(_car_d__12)
	push xwa
	call _id_road_line_at_distance
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (xsp+122),a
	ld a,(xsp+122)
	cp a,255
	jr nz,L1844
	jp L1840
L1844:
	push xix
	push xiy
	lda xwa,(xsp+124)
	push xwa
	ld a,(xsp+134)
	push xwa
	call _id_road_sprite_sample
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	ld a,(xsp+120)
	extz wa
	ld (xsp+124),wa
	ld a,(xsp+120)
	extz wa
	ld c,(xsp+120)
	extz bc
	extz xbc
	div xbc,6
	add wa,bc
	add wa,3
	ld (xsp+126),wa
	ld a,(xsp+120)
	extz wa
	extz xwa
	div xwa,3
	add wa,3
	ld (xsp+128),wa
	ld wa,(xsp+118)
	ld (xsp+134),wa
	ld wa,(xsp+134)
	cp wa,151
	jr le,L1845
	ldw (xsp+134),151
L1845:
	ld wa,(xsp+134)
	sub wa,(xsp+124)
	ld bc,(xsp+124)
	sra 3,bc
	sub wa,bc
	ld (xsp+132),wa
	ld wa,(xsp+132)
	sub wa,(xsp+128)
	ld (xsp+130),wa
	ld wa,(xsp+132)
	cp wa,20
	jr ge,L1846
	jp L1840
L1846:
	ld a,(_bridge_line)
	cp a,0
	jr nz,L1847
	ld a,(xsp+134)
	ld (_bridge_line),a
L1847:
	ld bc,(xsp+130)
	cp bc,16
	jr ge,L1848
	ld wa,2
	jr L1849
L1848:
	ld wa,(xsp+130)
	sra 3,wa
	extz wa
L1849:
	lda xbc,(xsp+5)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+132)
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
	jr uge,L1850
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
L1850:
	ld wa,(xsp+134)
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
	jr ule,L1851
	ld a,18
	lda xbc,(xsp+29)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1851:
	ld bc,(xsp+116)
	sub bc,(xsp+126)
	sub bc,1
	cp bc,0
	jr lt,L1852
	ld wa,1
	jr L1853
L1852:
	ld wa,0
L1853:
	lda xbc,(xsp+89)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld bc,(xsp+116)
	add bc,(xsp+126)
	cp bc,159
	jr gt,L1854
	ld wa,1
	jr L1855
L1854:
	ld wa,0
L1855:
	lda xbc,(xsp+101)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	push xix
	push xiy
	ld wa,(xsp+124)
	sub wa,(xsp+134)
	sub wa,(xsp+136)
	push xwa
	call _clamp_col__12
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	lda xbc,(xsp+41)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	push xix
	push xiy
	ld wa,(xsp+124)
	sub wa,(xsp+134)
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
	ld wa,(xsp+124)
	add wa,(xsp+134)
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
	push xix
	push xiy
	ld wa,(xsp+124)
	add wa,(xsp+134)
	add wa,(xsp+136)
	push xwa
	call _clamp_col__12
	lda xsp,(xsp+4)
	pop xiy
	pop xix
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
	ld (xsp+2),wa
	inc 1,iyl
L1840:
	incb 1,(xsp+0)
L1841:
	ld a,(xsp+0)
	ld c,(_br_n__12)
	cp a,c
	jp lt,L1838
L1839:
	ld a,iyl
	cp a,0
	jr nz,L1856
	ld a,(_bb_r0__12)
	cp a,255
	jr z,L1857
	push xix
	push xiy
	call _bridge_hide
	pop xiy
	pop xix
L1857:
	jp L1836
L1856:
	ld wa,(xsp+2)
	ld c,iyl
	extz bc
	add wa,bc
	ld (xsp+2),wa
	ld wa,(xsp+2)
	cp wa,(_sig_prev__12)
	jr nz,L1858
	jp L1836
L1858:
	ld wa,(xsp+2)
	ld (_sig_prev__12),wa
	push xix
	push xiy
	call _clear_box__12
	pop xiy
	pop xix
	jp L1861
L1859:
	ld a,iyl
	sub a,1
	ld izl,a
	dec 1,iyl
	lda xwa,(xsp+5)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+115),a
	jp L1865
L1862:
	ld c,(xsp+115)
	lda xde,(xsp+17)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1866
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
	jr ule,L1866
	ld wa,92
	jr L1867
L1866:
	ld c,(xsp+115)
	lda xde,(xsp+5)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1868
	ld wa,64
	jr L1869
L1868:
	ld wa,91
L1869:
L1867:
	ld (xsp+116),wa
	ld xwa,36864
	ld c,(xsp+115)
	extz bc
	sll 5,bc
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
	ld (xsp+118),xwa
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
	jr nz,L1870
	ldw (xsp+116),92
L1870:
	lda xwa,(xsp+41)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld ixl,a
	jr L1874
L1871:
	ld wa,(xsp+116)
	or wa,5632
	ld xbc,(xsp+118)
	inc 2,xbc
	ld (xsp+118),xbc
	dec 2,xbc
	ld (xbc),wa
L1873:
	inc 1,ixl
L1874:
	ld a,ixl
	lda xbc,(xsp+77)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr ule,L1871
L1872:
L1864:
	incb 1,(xsp+115)
L1865:
	ld a,(xsp+115)
	lda xbc,(xsp+17)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp ule,L1862
L1863:
	lda xwa,(xsp+17)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	add a,1
	ld (xsp+115),a
	jp L1878
L1875:
	lda xwa,(xsp+89)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L1879
	lda xwa,(xsp+41)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld ixl,a
	jp L1883
L1880:
	ld c,ixl
	lda xde,(xsp+53)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1884
	ld wa,95
	jr L1885
L1884:
	ld c,ixl
	lda xde,(xsp+41)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1886
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
	jr ule,L1886
	ld wa,94
	jr L1887
L1886:
	ld wa,93
L1887:
L1885:
	ld (xsp+116),wa
	ld wa,(xsp+116)
	or wa,5632
	ld xbc,36864
	ld e,(xsp+115)
	extz de
	sll 5,de
	ld l,ixl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1882:
	inc 1,ixl
L1883:
	ld a,ixl
	lda xbc,(xsp+53)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp ule,L1880
L1881:
L1879:
	lda xwa,(xsp+101)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L1888
	lda xwa,(xsp+65)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld ixl,a
	jp L1892
L1889:
	ld c,ixl
	lda xde,(xsp+65)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1893
	ld wa,94
	jr L1894
L1893:
	ld c,ixl
	lda xde,(xsp+77)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1895
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
	jr ule,L1895
	ld wa,95
	jr L1896
L1895:
	ld wa,93
L1896:
L1894:
	ld (xsp+116),wa
	ld wa,(xsp+116)
	or wa,5632
	ld xbc,36864
	ld e,(xsp+115)
	extz de
	sll 5,de
	ld l,ixl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1891:
	inc 1,ixl
L1892:
	ld a,ixl
	lda xbc,(xsp+77)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp ule,L1889
L1890:
L1888:
L1877:
	incb 1,(xsp+115)
L1878:
	ld a,(xsp+115)
	lda xbc,(xsp+29)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp ule,L1875
L1876:
	ld a,(_bb_r0__12)
	cp a,255
	jr nz,L1897
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
	jp L1898
L1897:
	lda xwa,(xsp+5)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_bb_r0__12)
	jr uge,L1899
	lda xwa,(xsp+5)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_r0__12),a
L1899:
	lda xwa,(xsp+29)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_bb_r1__12)
	jr ule,L1900
	lda xwa,(xsp+29)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_r1__12),a
L1900:
	lda xwa,(xsp+41)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_bb_c0__12)
	jr uge,L1901
	lda xwa,(xsp+41)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_c0__12),a
L1901:
	lda xwa,(xsp+77)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_bb_c1__12)
	jr ule,L1902
	lda xwa,(xsp+77)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_c1__12),a
L1902:
L1898:
L1861:
	ld a,iyl
	cp a,0
	jp ugt,L1859
L1860:
L1836:
	lda xsp,(xsp+136)
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
	jr ge,L1911
	ld wa,ix
	neg wa
	ld ix,wa
L1911:
	ld izl,0
	jr L1915
L1912:
	ld wa,(xsp+12)
	ld xbc,_br_at__12
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr uge,L1916
	ld wa,(xsp+16)
	ld xbc,_br_at__12
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr ult,L1916
	ld wa,ix
	add wa,14
	cp wa,iy
	jr le,L1916
	ld wa,1
	jr L1910
L1916:
L1914:
	inc 1,izl
L1915:
	ld a,izl
	cp a,(_br_n__12)
	jr ult,L1912
L1913:
	ld wa,0
	jr L1910
L1910:
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
	jr ult,L1920
	ld xwa,(xsp+0)
	sub xwa,8192
	ld (xsp+0),xwa
	ld a,izl
	sub a,32
	ld izl,a
L1920:
	ld xwa,(xsp+0)
	ld c,izl
	extz bc
	extz xbc
	sll 8,xbc
	add xwa,xbc
	jr L1919
L1919:
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
	jr L1922
L1922:
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
	jr L1934
L1931:
	ld bc,iz
	and bc,32768
	cp bc,0
	jr z,L1935
	ld wa,iz
	sll 1,wa
	xor wa,4129
	jr L1936
L1935:
	ld wa,iz
	sll 1,wa
L1936:
	ld iz,wa
L1933:
	inc 1,ixl
L1934:
	ld a,ixl
	cp a,8
	jr ult,L1931
L1932:
	ld wa,iz
	jr L1930
L1930:
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
	jr L1947
L1944:
	ld xwa,xix
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,255
	jr z,L1948
	ld wa,0
	jr L1943
L1948:
L1946:
	inc 1,iz
L1947:
	ld wa,iz
	cp wa,256
	jr ult,L1944
L1945:
	ld wa,1
	jr L1943
L1943:
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
	jr nz,L1953
	ld c,(xiz+1)
	cp c,254
	jr nz,L1953
	ld c,(xiz+2)
	cp c,32
	jr nz,L1953
	ld c,(xiz+3)
	cp c,38
	jr nz,L1953
	ld c,(xiz+254)
	cp c,74
	jr nz,L1953
	ld c,(xiz+255)
	cp c,0
	jr nz,L1953
	ld wa,1
	jr L1954
L1953:
	ld wa,0
L1954:
	jr L1952
L1952:
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
	jr L1966
L1963:
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
L1965:
	inc 1,iz
L1966:
	ld wa,iz
	cp wa,252
	jr ult,L1963
L1964:
	ld xbc,(xsp+0)
	ld c,(xbc+252)
	ld e,ixl
	cp c,e
	jr nz,L1967
	ld xbc,(xsp+0)
	ld c,(xbc+253)
	ld de,ix
	srl 8,de
	cp c,e
	jr nz,L1967
	ld wa,1
	jr L1968
L1967:
	ld wa,0
L1968:
	jr L1962
L1962:
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
	jr L1970
L1970:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function bank_of
_bank_of__13:
	ld c,(xsp+4)
	cp c,32
	jr ult,L1975
	ld a,32
	extz wa
	jr L1976
L1975:
	ld wa,0
L1976:
	jr L1974
L1974:
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
	jr z,L1996
	cp wa,2
	jr z,L1997
	cp wa,3
	jr z,L1998
	jr L1999
L1996:
	ld xwa,499712
	ld (_s_offset__13),xwa
	jr L1995
L1997:
	ld xwa,1024000
	ld (_s_offset__13),xwa
	jr L1995
L1998:
	ld xwa,2072576
	ld (_s_offset__13),xwa
	jr L1995
L1999:
	ld xwa,0
	ld (_s_offset__13),xwa
	jr L1995
L1995:
	ld xwa,(_s_offset__13)
	cp xwa,0
	jr nz,L2000
	jp L1994
L2000:
	ld xwa,__DataROM_END
	ld xbc,2097152
	add xbc,(_s_offset__13)
	sub xbc,8192
	cp xwa,xbc
	jr ule,L2001
	ld xwa,0
	ld (_s_offset__13),xwa
	jr L1994
L2001:
	ld izl,0
	jr L2005
L2002:
	ld a,izl
	push xwa
	call _slot_looks_valid__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2006
	jr L2004
L2006:
	ld a,izl
	push xwa
	call _slot_sequence__13
	lda xsp,(xsp+4)
	ld (xsp+2),xwa
	ld a,(_s_current__13)
	cp a,255
	jr z,L2007
	ld xwa,(xsp+2)
	sub xwa,(_s_sequence__13)
	ld (xsp+6),xwa
	ld xwa,(xsp+6)
	cp xwa,0
	jr z,L2009
	ld xwa,(xsp+6)
	cp xwa,2147483648
	jr ult,L2008
L2009:
	jr L2004
L2008:
L2007:
	ld a,izl
	push xwa
	call _slot_crc_ok__13
	lda xsp,(xsp+4)
	cp a,0
	jr z,L2010
	ld a,izl
	ld (_s_current__13),a
	ld xwa,(xsp+2)
	ld (_s_sequence__13),xwa
L2010:
L2004:
	inc 1,izl
L2005:
	ld a,izl
	cp a,64
	jr ult,L2002
L2003:
L1994:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_flash_ready
_ngpc_flash_ready:
	ld xbc,(_s_offset__13)
	cp xbc,0
	jr z,L2015
	ld wa,1
	jr L2016
L2015:
	ld wa,0
L2016:
	jr L2014
L2014:
	ret

; function ngpc_flash_cart_size
_ngpc_flash_cart_size:
	ld a,(06C58h)
	jr L2018
L2018:
	ret

; function ngpc_flash_exists
_ngpc_flash_exists:
	ld c,(_s_current__13)
	cp c,255
	jr z,L2023
	ld wa,1
	jr L2024
L2023:
	ld wa,0
L2024:
	jr L2022
L2022:
	ret

; function ngpc_flash_load
_ngpc_flash_load:
	push xiz
	lda xsp,(xsp-10)
	ld xwa,(xsp+18)
	ld xiy,xwa
	ld a,(_s_current__13)
	cp a,255
	jr nz,L2032
	jr L2031
L2032:
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
	jr L2036
L2033:
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
L2035:
	inc 1,iz
L2036:
	ld wa,iz
	cp wa,256
	jr ult,L2033
L2034:
L2031:
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
	jr nz,L2050
	ld wa,0
	jp L2049
L2050:
	ldb (xsp+8),32
	jr L2053
L2051:
	push xix
	ld a,(xsp+12)
	push xwa
	call _slot_ptr__13
	lda xsp,(xsp+4)
	pop xix
	ld xix,xwa
	ld a,(xix)
	cp a,202
	jr nz,L2055
	ld a,(xix+1)
	cp a,254
	jr nz,L2055
	ld a,(xix+2)
	cp a,32
	jr nz,L2055
	ld a,(xix+3)
	cp a,38
	jr z,L2054
L2055:
	jr L2053
L2054:
	push xix
	ld a,(xsp+12)
	push xwa
	call _slot_looks_valid__13
	lda xsp,(xsp+4)
	pop xix
	cp a,0
	jr z,L2056
	push xix
	ld a,(xsp+12)
	push xwa
	call _slot_crc_ok__13
	lda xsp,(xsp+4)
	pop xix
	cp a,0
	jr z,L2056
	jr L2053
L2056:
	ld iz,0
	jr L2060
L2057:
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
L2059:
	inc 1,iz
L2060:
	ld wa,iz
	cp wa,256
	jr ult,L2057
L2058:
	ld wa,1
	jr L2049
L2053:
	ld a,(xsp+8)
	decb 1,(xsp+8)
	cp a,0
	jp ugt,L2051
L2052:
	ld wa,0
	jr L2049
L2049:
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
	jr z,L2071
	ld a,(_s_last_slot__13)
	cp a,255
	jr nz,L2070
L2071:
	ld wa,65535
	jr L2069
L2070:
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
	jr L2075
L2072:
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
	jr z,L2076
	inc 1,ix
L2076:
L2074:
	inc 1,iz
L2075:
	ld wa,iz
	cp wa,256
	jr ult,L2072
L2073:
	ld wa,ix
	jr L2069
L2069:
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
	jr nz,L2087
	ld wa,0
	jr L2088
L2087:
	ld a,(_s_current__13)
	push xwa
	call _bank_of__13
	lda xsp,(xsp+4)
	extz wa
L2088:
	ld (xsp+2),a
	ld xwa,(_s_offset__13)
	cp xwa,0
	jr nz,L2089
	ld wa,0
	jr L2086
L2089:
	ld a,(xsp+2)
	ld izl,a
	jr L2093
L2090:
	ld a,izl
	push xwa
	call _slot_erased__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2094
	incb 1,(xsp+1)
L2094:
L2092:
	inc 1,izl
L2093:
	ld a,izl
	ld c,(xsp+2)
	add c,32
	cp a,c
	jr ult,L2090
L2091:
	ld a,(xsp+1)
	jr L2086
L2086:
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
	jr L2105
L2102:
	ld a,izl
	push xwa
	call _slot_erased__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2106
	ld wa,0
	jr L2101
L2106:
L2104:
	inc 1,izl
L2105:
	ld a,izl
	ld c,(xsp+10)
	add c,32
	cp a,c
	jr ult,L2102
L2103:
	ld wa,1
	jr L2101
L2101:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_flash_erase
_ngpc_flash_erase:
	ld xwa,(_s_offset__13)
	cp xwa,0
	jr nz,L2112
	ld wa,0
	jr L2111
L2112:
	ld wa,0
	push xwa
	call _erase_bank__13
	lda xsp,(xsp+4)
	cp a,0
	jr z,L2114
	ld a,32
	push xwa
	call _erase_bank__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2113
L2114:
	call _ngpc_flash_init
	ld wa,0
	jr L2111
L2113:
	ldb (_s_current__13),255
	ldb (_s_last_slot__13),255
	ld xwa,0
	ld (_s_sequence__13),xwa
	ld wa,1
	jr L2111
L2111:
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
	jr nz,L2146
	ld wa,0
	jp L2145
L2146:
	ld xwa,(xsp+0)
	ld a,(xwa)
	cp a,202
	jr nz,L2148
	ld xwa,(xsp+0)
	ld a,(xwa+1)
	cp a,254
	jr nz,L2148
	ld xwa,(xsp+0)
	ld a,(xwa+2)
	cp a,32
	jr nz,L2148
	ld xwa,(xsp+0)
	ld a,(xwa+3)
	cp a,38
	jr z,L2147
L2148:
	ld wa,0
	jp L2145
L2147:
	ld c,(_s_current__13)
	cp c,255
	jr nz,L2149
	ld wa,0
	jr L2150
L2149:
	ld a,(_s_current__13)
	push xwa
	call _bank_of__13
	lda xsp,(xsp+4)
	extz wa
L2150:
	ld (xsp+5),a
	ld c,(_s_current__13)
	cp c,255
	jr nz,L2151
	ld a,(xsp+5)
	extz wa
	jr L2152
L2151:
	ld a,(_s_current__13)
	add a,1
	extz wa
L2152:
	ld (xsp+4),a
	jr L2155
L2153:
	incb 1,(xsp+4)
L2155:
	ld a,(xsp+4)
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr uge,L2156
	ld a,(xsp+4)
	push xwa
	call _slot_erased__13
	lda xsp,(xsp+4)
	cp a,0
	jr z,L2153
L2156:
L2154:
	ld a,(xsp+4)
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr ult,L2157
	ld a,(xsp+5)
	xor a,32
	ld (xsp+5),a
	ld a,(xsp+5)
	ld izl,a
	jr L2161
L2158:
	ld a,izl
	push xwa
	call _slot_erased__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2162
	jr L2159
L2162:
L2160:
	inc 1,izl
L2161:
	ld a,izl
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr ult,L2158
L2159:
	ld a,izl
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr z,L2163
	ld a,(xsp+5)
	push xwa
	call _erase_bank__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2163
	ld wa,0
	jp L2145
L2163:
	ld a,(xsp+5)
	ld (xsp+4),a
L2157:
	ld xwa,(_s_sequence__13)
	add xwa,1
	ld (xsp+12),xwa
	ld izl,0
	jr L2167
L2164:
	ld xwa,(xsp+12)
	ld c,izl
	extz bc
	sll 3,bc
	cp c,0
	jr z,L2169
L2168:
	srl 1,xwa
	djnz c,L2168
L2169:
	ld xbc,(xsp+0)
	ld de,248
	ld l,izl
	extz hl
	add de,hl
	extz xde
	add xbc,xde
	ld (xbc),a
L2166:
	inc 1,izl
L2167:
	ld a,izl
	cp a,4
	jr ult,L2164
L2165:
	ldw (xsp+8),0
	jr L2173
L2170:
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
L2172:
	incw 1,(xsp+8)
L2173:
	ld wa,(xsp+8)
	cp wa,252
	jr ult,L2170
L2171:
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
	jr z,L2174
	ld wa,0
	jr L2145
L2174:
	ld a,(xsp+4)
	ld (_s_current__13),a
	ld xwa,(xsp+12)
	ld (_s_sequence__13),xwa
	ld wa,1
	jr L2145
L2145:
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
L2176:
	lda xsp,(xsp+2)
	ret

; function ngpc_input_set_repeat
_ngpc_input_set_repeat:
	ld a,(xsp+4)
	ld (_s_repeat_delay__14),a
	ld a,(xsp+8)
	ld (_s_repeat_rate__14),a
L2178:
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
	jp L2194
L2191:
	ld a,(xsp+2)
	extz wa
	ld c,(xsp+1)
	extz bc
	and wa,bc
	cp wa,0
	jr z,L2195
	ld a,(_ngpc_pad_pressed)
	extz wa
	ld c,(xsp+1)
	extz bc
	and wa,bc
	cp wa,0
	jr z,L2196
	ld a,(_s_repeat_delay__14)
	ld xbc,_s_repeat_timer__14
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	jr L2197
L2196:
	ld xwa,_s_repeat_timer__14
	ld c,(xsp+0)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr ule,L2198
	ld xbc,_s_repeat_timer__14
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld a,(xbc)
	dec 1,a
	ld (xbc),a
	jr L2199
L2198:
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
L2199:
L2197:
	jr L2200
L2195:
	ld a,0
	ld xbc,_s_repeat_timer__14
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2200:
	ld a,(xsp+1)
	extz wa
	sll 1,wa
	ld (xsp+1),a
L2193:
	incb 1,(xsp+0)
L2194:
	ld a,(xsp+0)
	cp a,8
	jp ult,L2191
L2192:
	ld a,(xsp+2)
	ld (_s_pad_prev__14),a
L2190:
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
	jr L2211
L2209:
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
L2211:
	ld xwa,xix
	cp xwa,(xsp+4)
	jr ult,L2209
L2210:
	jr L2214
L2212:
	ld a,0
	ld xbc,xiz
	inc 1,xbc
	ld xiz,xbc
	dec 1,xbc
	ld (xbc),a
L2214:
	ld xwa,xiz
	cp xwa,(xsp+16)
	jr ult,L2212
L2213:
L2208:
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
L2216:
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
L2218:
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
	ld xwa,(_g_vb_hook__15)
	cp xwa,0
	jr z,L2222
	ld xwa,(_g_vb_hook__15)
	ld xhl,xwa
	call (xhl)
L2222:
	call _ngpc_vramq_flush
	incb 1,(_g_vb_counter)
	call _ngpc_input_vblank
L2221:
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
	jr z,L2231
	ld wa,1
	jr L2232
L2231:
	ld wa,0
L2232:
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
	jr L2236
L2233:
	ld wa,0
	ld xbc,40960
	ld e,(xsp+0)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2235:
	incb 1,(xsp+0)
L2236:
	ld a,(xsp+0)
	cp a,8
	jr ult,L2233
L2234:
	ei
L2230:
	lda xsp,(xsp+2)
	ret

; function ngpc_is_color
_ngpc_is_color:
	ld a,(_s_is_color__15)
	jr L2238
L2238:
	ret

; function ngpc_get_language
_ngpc_get_language:
	ld a,(_s_language__15)
	jr L2240
L2240:
	ret

; function ngpc_shutdown_reason
_ngpc_shutdown_reason:
	push xiz
	lda xsp,(xsp-6)
	ld a,(xsp+14)
	extz wa
	and wa,32
	cp wa,0
	jr z,L2256
	ld iy,15
	jr L2257
L2256:
	ld a,(xsp+14)
	extz wa
	and wa,128
	cp wa,0
	jr z,L2258
	ld iy,4095
	jr L2259
L2258:
	ld a,(xsp+14)
	extz wa
	and wa,64
	cp wa,0
	jr z,L2260
	ld iy,240
	jr L2261
L2260:
	ld iy,3840
L2261:
L2259:
L2257:
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
	jr L2265
L2262:
	ld a,(_g_vb_counter)
	ld ixl,a
	jr L2268
L2266:
L2268:
	ld a,(_g_vb_counter)
	cp a,ixl
	jr z,L2266
L2267:
L2264:
	inc 1,iz
L2265:
	ld wa,iz
	cp wa,180
	jr ult,L2262
L2263:
	push xix
	push xiy
	call _ngpc_shutdown
	pop xiy
	pop xix
L2255:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_shutdown
_ngpc_shutdown:
	ldb ra3, 3
	ldb rw3, 0
	swi 1
L2270:
	ret

; function ngpc_load_sysfont
_ngpc_load_sysfont:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,41472
	ld xix,xwa
	ld iz,0
	jr L2280
L2277:
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
L2279:
	inc 1,iz
L2280:
	ld wa,iz
	cp wa,768
	jr ult,L2277
L2278:
L2276:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_memcpy
_ngpc_memcpy:
	push xiz
	ld xix,(xsp+8)
	ld xiz,(xsp+12)
	ld iy,(xsp+16)
	jr L2288
L2286:
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
L2288:
	ld wa,iy
	dec 1,iy
	cp wa,0
	jr nz,L2286
L2287:
L2285:
	pop xiz
	ret

; function ngpc_memset
_ngpc_memset:
	push xiz
	ld xiz,(xsp+8)
	ld a,(xsp+12)
	ld iyl,a
	ld ix,(xsp+16)
	jr L2296
L2294:
	ld a,iyl
	ld xbc,xiz
	inc 1,xbc
	ld xiz,xbc
	dec 1,xbc
	ld (xbc),a
L2296:
	ld wa,ix
	dec 1,ix
	cp wa,0
	jr nz,L2294
L2295:
L2293:
	pop xiz
	ret

; function ngpc_vsync
_ngpc_vsync:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_g_vb_counter)
	ld izl,a
	jr L2307
L2305:
L2307:
	ld a,(_g_vb_counter)
	cp a,izl
	jr z,L2305
L2306:
	ld a,(06F85h)
	cp a,0
	jr z,L2308
	ld a,(06F85h)
	push xwa
	call _ngpc_shutdown_reason
	lda xsp,(xsp+4)
L2308:
L2303:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_in_vblank
_ngpc_in_vblank:
	ld c,(08010h)
	extz bc
	and bc,64
	cp bc,0
	jr z,L2313
	ld wa,1
	jr L2314
L2313:
	ld wa,0
L2314:
	jr L2312
L2312:
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
	jr L2324
L2321:
	call _ngpc_vsync
L2323:
	inc 1,izl
L2324:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L2321
L2322:
	ld wa,0
	push xwa
	call _ngpc_cpu_speed
	lda xsp,(xsp+4)
L2320:
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
L2326:
	ret

; function dst_range_ok
_dst_range_ok__17:
	push xiz
	lda xsp,(xsp-12)
	ld xwa,(xsp+20)
	cp xwa,0
	jr z,L2334
	ld wa,(xsp+24)
	cp wa,0
	jr nz,L2333
L2334:
	ld wa,0
	jr L2332
L2333:
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
	jr uge,L2335
	ld wa,0
	jr L2332
L2335:
	ld xwa,(xsp+8)
	cp xwa,49151
	jr ule,L2336
	ld wa,0
	jr L2332
L2336:
	ld wa,1
	jr L2332
L2332:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function ngpc_vramq_init
_ngpc_vramq_init:
	ldb (_s_cmd_count__17),0
	ldb (_s_drop_count__17),0
	ldb (_s_lock__17),0
L2338:
	ret

; function ngpc_vramq_copy
_ngpc_vramq_copy:
	push xiz
	lda xsp,(xsp-2)
	ld xwa,(xsp+14)
	cp xwa,0
	jr z,L2345
	ld wa,(xsp+18)
	push xwa
	ld xwa,(xsp+14)
	push xwa
	call _dst_range_ok__17
	lda xsp,(xsp+8)
	cp a,0
	jr nz,L2344
L2345:
	ld wa,0
	jp L2343
L2344:
	ldb (_s_lock__17),1
	ld a,(_s_cmd_count__17)
	ld izl,a
	ld a,izl
	cp a,16
	jr ult,L2346
	incb 1,(_s_drop_count__17)
	ldb (_s_lock__17),0
	ld wa,0
	jr L2343
L2346:
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
	jr L2343
L2343:
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
	jr nz,L2351
	ld wa,0
	jp L2350
L2351:
	ldb (_s_lock__17),1
	ld a,(_s_cmd_count__17)
	ld izl,a
	ld a,izl
	cp a,16
	jr ult,L2352
	incb 1,(_s_drop_count__17)
	ldb (_s_lock__17),0
	ld wa,0
	jr L2350
L2352:
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
	jr L2350
L2350:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_vramq_flush
_ngpc_vramq_flush:
	push xiz
	lda xsp,(xsp-10)
	ld a,(_s_lock__17)
	cp a,0
	jr z,L2367
	jp L2366
L2367:
	ld a,(_s_cmd_count__17)
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,0
	jr nz,L2368
	jp L2366
L2368:
	ldb (_s_lock__17),1
	ld izl,0
	jp L2372
L2369:
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
	jr nz,L2373
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
	jr L2374
L2373:
	ld xwa,_s_cmd_type__17
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,2
	jr nz,L2375
	ld xwa,_s_cmd_fill__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+8),wa
	jr L2378
L2376:
	ld wa,(xsp+8)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L2378:
	ld wa,iy
	dec 1,iy
	cp wa,0
	jr nz,L2376
L2377:
L2375:
L2374:
L2371:
	inc 1,izl
L2372:
	ld a,izl
	cp a,(xsp+1)
	jp ult,L2369
L2370:
	ldb (_s_cmd_count__17),0
	ldb (_s_lock__17),0
L2366:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_vramq_clear
_ngpc_vramq_clear:
	ld a,(_s_lock__17)
	cp a,0
	jr z,L2382
	jr L2381
L2382:
	ldb (_s_cmd_count__17),0
L2381:
	ret

; function ngpc_vramq_pending
_ngpc_vramq_pending:
	ld a,(_s_cmd_count__17)
	jr L2384
L2384:
	ret

; function ngpc_vramq_dropped
_ngpc_vramq_dropped:
	ld a,(_s_drop_count__17)
	jr L2386
L2386:
	ret

; function ngpc_vramq_clear_dropped
_ngpc_vramq_clear_dropped:
	ldb (_s_drop_count__17),0
L2388:
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
	jr L2390
L2390:
	ret

; function rndn
_rndn__18:
	call _rnd16__18
	extz xwa
	div xwa,(xsp+4)
	ld wa,qwa
	jr L2392
L2392:
	ret

; function stage_of
_stage_of__18:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld ixl,a
	ld wa,0
	ld izl,a
	jr L2401
L2399:
	inc 1,izl
L2401:
	ld a,izl
	extz wa
	add wa,1
	cp wa,5
	jr uge,L2402
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
	jr ule,L2399
L2402:
L2400:
	ld a,izl
	jr L2398
L2398:
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
L2404:
	ret

; function slope_for
_slope_for__18:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	cp a,0
	jr z,L2412
	ld wa,100
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld bc,18
	ld e,(xsp+10)
	extz de
	mul xbc,de
	cp wa,bc
	jr uge,L2412
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
	jr nz,L2413
	ld a,(xsp+10)
	neg a
	ld izl,a
L2413:
	ld a,(xsp+0)
	cp a,3
	jr nz,L2414
	ld a,(xsp+10)
	ld izl,a
L2414:
	ld a,izl
	cp a,252
	jr ge,L2415
	ld izl,252
L2415:
	ld a,izl
	cp a,3
	jr le,L2416
	ld izl,3
L2416:
	ld a,izl
	jr L2411
L2412:
	ld wa,0
	jr L2411
L2411:
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
	jr uge,L2421
	ld iz,52
L2421:
	ld wa,iz
	cp wa,72
	jr ule,L2422
	ld iz,72
L2422:
	ld wa,iz
	jr L2420
L2420:
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
	jr nz,L2454
	ldw (_rs__18),44257
L2454:
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
	jr nz,L2455
	ld wa,1
	jr L2456
L2455:
	ld wa,0
L2456:
	ld (xsp+18),a
	jp L2459
L2457:
	ld a,(xsp+18)
	cp a,0
	jp nz,L2460
	ld wa,iz
	cp wa,4680
	jr ult,L2460
	ldb (xsp+18),1
	ldb (xsp+22),0
	jr L2464
L2461:
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
L2463:
	incb 1,(xsp+22)
L2464:
	ld a,(xsp+22)
	cp a,4
	jr ult,L2461
L2462:
	jp L2459
L2460:
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
	jr uge,L2465
	ld wa,(xsp+16)
	neg wa
	jr L2466
L2465:
	ld wa,(xsp+16)
L2466:
	ld (xsp+22),wa
	ld wa,(xsp+20)
	cp wa,(xsp+8)
	jp uge,L2467
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
	jr z,L2468
	ld wa,500
	jr L2469
L2468:
	ld wa,400
L2469:
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
	jr z,L2470
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,(xsp+38)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
L2470:
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
	jp L2471
L2467:
	ld wa,(xsp+20)
	ld bc,(xsp+8)
	add bc,(xsp+6)
	cp wa,bc
	jp uge,L2472
	push xwa
	ld wa,2
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp bc,0
	jr z,L2473
	ld wa,500
	jr L2474
L2473:
	ld wa,400
L2474:
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
	jp L2475
L2472:
	ld wa,100
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,(xsp+0)
	ld c,(xbc+18)
	extz bc
	cp wa,bc
	jr uge,L2476
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
	jp L2477
L2476:
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
	jr ult,L2478
	ld wa,5
	jr L2479
L2478:
	ld wa,3
L2479:
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
	jr uge,L2480
	ldw (xsp+26),18
L2480:
	ld wa,(xsp+26)
	cp wa,48
	jr ule,L2481
	ldw (xsp+26),48
L2481:
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
L2477:
L2475:
L2471:
L2459:
	ld wa,iz
	cp wa,11700
	jr uge,L2482
	ld a,(_gn__18)
	cp a,30
	jp ule,L2457
L2482:
L2458:
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,2400
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld a,(_gn__18)
	jr L2453
L2453:
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
	jr L2497
L2494:
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
	jr ge,L2498
	ld wa,iy
	neg wa
	ld iy,wa
L2498:
	jr L2501
L2499:
	dec 1,iz
L2501:
	ld wa,iz
	cp wa,6
	jr ule,L2502
	ld wa,iz
	mul xwa,iz
	ld bc,iy
	mul xwa,bc
	cp wa,6000
	jr ugt,L2499
L2502:
L2500:
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
L2496:
	inc 1,ixl
L2497:
	ld a,ixl
	cp a,(xsp+22)
	jr ult,L2494
L2495:
	ld xwa,(xsp+0)
	srl 4,xwa
	jr L2493
L2493:
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
L2504:
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
	jr nz,L2514
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
	jr L2515
L2514:
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
	jr ule,L2516
	ld a,71
	sub a,iyl
	ld ixl,a
L2516:
	ld izl,0
	jr L2520
L2517:
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
L2519:
	inc 1,izl
L2520:
	ld a,izl
	cp a,ixl
	jr ult,L2517
L2518:
L2515:
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
	jr L2513
L2513:
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
	jr L2530
L2527:
	ld wa,(_leg_len)
	ld xbc,_buf__18
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld (_leg_len),wa
L2529:
	inc 1,izl
L2530:
	ld a,izl
	cp a,(_n_cur__18)
	jr ult,L2527
L2528:
	ldb (_fork_choice),0
L2526:
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
	jr L2551
L2548:
	ld a,0
	ld xbc,_route_hist
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2550:
	inc 1,izl
L2551:
	ld a,izl
	cp a,5
	jr ult,L2548
L2549:
	ld izl,0
	jr L2555
L2552:
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
L2554:
	inc 1,izl
L2555:
	ld a,izl
	cp a,15
	jr ult,L2552
L2553:
	ld a,(_difficulty)
	cp a,3
	jp nz,L2556
	ld wa,(_free_seed)
	cp wa,0
	jr nz,L2557
	ldw (_free_seed),24301
L2557:
	ld wa,(_free_seed)
	xor wa,15450
	ld (_rs__18),wa
	ld wa,(_rs__18)
	cp wa,0
	jr nz,L2558
	ldw (_rs__18),44257
L2558:
	ld izl,14
	jr L2562
L2559:
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
L2561:
	dec 1,izl
L2562:
	ld a,izl
	cp a,0
	jr ugt,L2559
L2560:
L2556:
	call _load_current__18
L2547:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function course_is_last_stage
_course_is_last_stage:
	ld c,(_cur_stage)
	extz bc
	add bc,1
	cp bc,5
	jr ult,L2567
	ld wa,1
	jr L2568
L2567:
	ld wa,0
L2568:
	jr L2566
L2566:
	ret

; function course_fork_zone
_course_fork_zone:
	ld bc,(xsp+4)
	add bc,2400
	cp bc,(_leg_len)
	jr ult,L2573
	ld wa,1
	jr L2574
L2573:
	ld wa,0
L2574:
	jr L2572
L2572:
	ret

; function course_start_zone
_course_start_zone:
	ld c,(_cur_stage)
	cp c,0
	jr z,L2579
	ld bc,(xsp+4)
	cp bc,900
	jr uge,L2579
	ld wa,1
	jr L2580
L2579:
	ld wa,0
L2580:
	jr L2578
L2578:
	ret

; function course_decide
_course_decide:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_fork_choice)
	cp a,0
	jr nz,L2593
	call _course_is_last_stage
	cp a,0
	jr z,L2592
L2593:
	jp L2591
L2592:
	ld c,(xsp+10)
	cp c,0
	jr z,L2594
	ld wa,2
	jr L2595
L2594:
	ld wa,1
L2595:
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
	jr z,L2596
	ld de,1
	jr L2597
L2596:
	ld de,0
L2597:
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
	jr z,L2598
	ld c,(xsp+10)
	cp c,0
	jr z,L2599
	ld wa,65486
	jr L2600
L2599:
	ld wa,50
L2600:
	ld xbc,_buf__18
	ld e,(_n_cur__18)
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+2),wa
L2598:
	ld a,(_n_cur__18)
	add a,izl
	push xwa
	call _put_placeholder__18
	lda xsp,(xsp+4)
	ld a,(_n_cur__18)
	add a,izl
	add a,1
	ld (_track_len),a
L2591:
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
	jr z,L2615
	ld wa,0
	jp L2614
L2615:
	ld a,(_fork_choice)
	cp a,0
	jr nz,L2616
	push xix
	ld wa,0
	push xwa
	call _course_decide
	lda xsp,(xsp+4)
	pop xix
L2616:
	ld a,(_n_cur__18)
	ld ixl,a
	ld izl,0
	jr L2620
L2617:
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
L2619:
	inc 1,izl
L2620:
	ld a,izl
	add a,ixl
	cp a,(_track_len)
	jr ult,L2617
L2618:
	ld a,(_track_len)
	sub a,ixl
	ld (_track_len),a
	ld a,(_fork_choice)
	cp a,2
	jr nz,L2621
	incb 1,(_cur_branch)
L2621:
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
	jr ult,L2622
	ld a,(_track_len)
	sub a,1
	ld (_n_cur__18),a
L2622:
	ldw (_leg_len),0
	ld izl,0
	jr L2626
L2623:
	ld wa,(_leg_len)
	ld xbc,_buf__18
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld (_leg_len),wa
L2625:
	inc 1,izl
L2626:
	ld a,izl
	cp a,(_n_cur__18)
	jr ult,L2623
L2624:
	ldb (_fork_choice),0
	ld a,ixl
	jr L2614
L2614:
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
L2628:
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
	jr L2630
L2630:
	ret

; function ending_start
_ending_start:
	push xiz
	lda xsp,(xsp-8)
	ld a,(xsp+16)
	cp a,5
	jr ule,L2642
	ldb (xsp+16),5
L2642:
	ld xwa,_endings__19
	ld c,(xsp+16)
	extz bc
	exts xbc
	sll 4,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+0),xwa
	ldw (xsp+4),0
	jr L2646
L2643:
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
L2645:
	incw 1,(xsp+4)
L2646:
	ld wa,(xsp+4)
	cp wa,24
	jr ult,L2643
L2644:
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
	jr L2650
L2647:
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
L2649:
	inc 1,izl
L2650:
	ld a,izl
	cp a,14
	jr ult,L2647
L2648:
L2641:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function pal_of
_pal_of__19:
	ld xwa,_pals__19_L2654
	ld c,(xsp+4)
	extz bc
	and bc,3
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	jr L2653
L2653:
	ret

; function ending_tick
_ending_tick:
	push xiz
	lda xsp,(xsp-14)
	incb 1,(_timer__19)
	ld a,(_fx__19)
	cp a,1
	jp nz,L2692
	ld a,(_timer__19)
	extz wa
	extz xwa
	div xwa,40
	ld wa,qwa
	cp wa,1
	jp nz,L2692
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
	jp L2696
L2693:
	ld a,izl
	and a,7
	ld (xsp+7),a
	ld c,izl
	cp c,8
	jr uge,L2697
	ld wa,2
	jr L2698
L2697:
	ld wa,1
L2698:
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
L2695:
	inc 1,izl
L2696:
	ld a,izl
	cp a,14
	jp ult,L2693
L2694:
L2692:
	ld izl,0
	jp L2702
L2699:
	ld a,56
	add a,izl
	ld (xsp+1),a
	ld a,(_fx__19)
	extz wa
	cp wa,1
	jr z,L2704
	cp wa,2
	jp z,L2705
	cp wa,3
	jp z,L2706
	cp wa,4
	jp z,L2707
	jp L2708
L2704:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L2709
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
L2709:
	jp L2703
L2705:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L2711
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2400
	jp le,L2710
L2711:
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
L2710:
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
	jr z,L2712
	ld bc,6
	jr L2713
L2712:
	ld bc,65530
L2713:
	add wa,bc
	ld xbc,_px__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jp L2703
L2706:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L2715
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65408
	jp ge,L2714
L2715:
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
L2714:
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
	jr z,L2716
	ld bc,3
	jr L2717
L2716:
	ld bc,65533
L2717:
	add wa,bc
	ld xbc,_px__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jp L2703
L2707:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp nz,L2718
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
	jr z,L2719
	ld wa,2
	jr L2720
L2719:
	ld wa,9
L2720:
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
	jr L2721
L2718:
	ld xbc,_life__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld a,(xbc)
	dec 1,a
	ld (xbc),a
L2721:
	jr L2703
L2708:
	jr L2703
L2703:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L2723
	ld xwa,_px__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65424
	jr lt,L2723
	ld xwa,_px__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2544
	jr gt,L2723
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65424
	jr lt,L2723
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2416
	jr gt,L2723
	ld a,(_fx__19)
	cp a,4
	jr nz,L2722
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	and wa,4
	cp wa,0
	jr z,L2722
L2723:
	ld a,(xsp+1)
	add a,1
	push xwa
	ld a,(xsp+5)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	jp L2701
L2722:
L2724:
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
L2726:
L2725:
L2701:
	inc 1,izl
L2702:
	ld a,izl
	cp a,14
	jp ult,L2699
L2700:
L2691:
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
L2728:
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
L2730:
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
L2732:
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
L2734:
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
L2736:
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
L2738:
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
L2740:
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
L2742:
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
L2744:
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
L2746:
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
L2748:
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
L2750:
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
L2752:
	ret

; function dma0_clear
_dma0_clear__20:
	ld wa,0
	ldc dmac0,wa
	ld a,0
	ldc dmam0,a
L2754:
	ret

; function dma1_clear
_dma1_clear__20:
	ld wa,0
	ldc dmac1,wa
	ld a,0
	ldc dmam1,a
L2756:
	ret

; function dma2_clear
_dma2_clear__20:
	ld wa,0
	ldc dmac2,wa
	ld a,0
	ldc dmam2,a
L2758:
	ret

; function dma3_clear
_dma3_clear__20:
	ld wa,0
	ldc dmac3,wa
	ld a,0
	ldc dmam3,a
L2760:
	ret

; function dma_set_start_vector
_dma_set_start_vector__20:
	push xiz
	ld a,(xsp+12)
	ld izl,a
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2769
	cp wa,1
	jr z,L2770
	cp wa,2
	jr z,L2771
	cp wa,3
	jr z,L2772
	jr L2768
L2769:
	ld a,izl
	ld (07Ch),a
	jr L2768
L2770:
	ld a,izl
	ld (07Dh),a
	jr L2768
L2771:
	ld a,izl
	ld (07Eh),a
	jr L2768
L2772:
	ld a,izl
	ld (07Fh),a
	jr L2768
L2768:
L2767:
	pop xiz
	ret

; function dma_rearm_in_isr
_dma_rearm_in_isr__20:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	jr L2798
	jp L2797
L2798:
	ld a,izl
	cp a,3
	jr ule,L2799
	jp L2797
L2799:
	ld xwa,_s_rearm_enabled__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L2800
	jp L2797
L2800:
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
	jr z,L2803
	cp wa,1
	jp z,L2804
	cp wa,2
	jp z,L2805
	jr L2802
L2802:
L2803:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L2807
	cp wa,1
	jr z,L2808
	cp wa,2
	jp z,L2809
	cp wa,3
	jp z,L2810
	jp L2806
L2807:
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
	jp L2806
L2808:
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
	jp L2806
L2809:
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
	jr L2806
L2810:
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
	jr L2806
L2806:
	jp L2801
L2804:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L2812
	cp wa,1
	jr z,L2813
	cp wa,2
	jp z,L2814
	cp wa,3
	jp z,L2815
	jp L2811
L2812:
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
	jp L2811
L2813:
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
	jp L2811
L2814:
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
	jr L2811
L2815:
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
	jr L2811
L2811:
	jp L2801
L2805:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L2817
	cp wa,1
	jr z,L2818
	cp wa,2
	jp z,L2819
	cp wa,3
	jp z,L2820
	jp L2816
L2817:
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
	jp L2816
L2818:
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
	jp L2816
L2819:
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
	jr L2816
L2820:
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
	jr L2816
L2816:
	jr L2801
L2801:
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
L2797:
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
	jr L2826
	ldb (_s_done_flag__20),1
L2826:
	ld wa,0
	push xwa
	call _dma_rearm_in_isr__20
	lda xsp,(xsp+4)
	jr L2827
	ld xwa,(_s_done_cb__20)
	cp xwa,0
	jr z,L2828
	ld xwa,(_s_done_cb__20)
	ld xhl,xwa
	call (xhl)
L2828:
L2827:
L2825:
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
	jr L2834
	ldb (_s_done_flag__20+1),1
L2834:
	ld wa,1
	push xwa
	call _dma_rearm_in_isr__20
	lda xsp,(xsp+4)
	jr L2835
	ld xwa,(_s_done_cb__20+4)
	cp xwa,0
	jr z,L2836
	ld xwa,(_s_done_cb__20+4)
	ld xhl,xwa
	call (xhl)
L2836:
L2835:
L2833:
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
	jr L2842
	ldb (_s_done_flag__20+2),1
L2842:
	ld wa,2
	push xwa
	call _dma_rearm_in_isr__20
	lda xsp,(xsp+4)
	jr L2843
	ld xwa,(_s_done_cb__20+8)
	cp xwa,0
	jr z,L2844
	ld xwa,(_s_done_cb__20+8)
	ld xhl,xwa
	call (xhl)
L2844:
L2843:
L2841:
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
	jr L2850
	ldb (_s_done_flag__20+3),1
L2850:
	ld wa,3
	push xwa
	call _dma_rearm_in_isr__20
	lda xsp,(xsp+4)
	jr L2851
	ld xwa,(_s_done_cb__20+12)
	cp xwa,0
	jr z,L2852
	ld xwa,(_s_done_cb__20+12)
	ld xhl,xwa
	call (xhl)
L2852:
L2851:
L2849:
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
	jr ule,L2879
	jp L2878
L2879:
	ld xwa,(xsp+12)
	cp xwa,0
	jr z,L2881
	ld xwa,(xsp+16)
	cp xwa,0
	jr nz,L2880
L2881:
	jp L2878
L2880:
	ld wa,iz
	cp wa,0
	jr nz,L2882
	jp L2878
L2882:
	ld a,(xsp+24)
	cp a,11
	jr nz,L2883
	jp L2878
L2883:
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
	jr z,L2885
	cp wa,1
	jr z,L2886
	cp wa,2
	jp z,L2887
	jp L2884
L2885:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2889
	cp wa,1
	jr z,L2890
	cp wa,2
	jr z,L2891
	cp wa,3
	jr z,L2892
	jr L2888
L2889:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program__20
	lda xsp,(xsp+12)
	jr L2888
L2890:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program__20
	lda xsp,(xsp+12)
	jr L2888
L2891:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program__20
	lda xsp,(xsp+12)
	jr L2888
L2892:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program__20
	lda xsp,(xsp+12)
	jr L2888
L2888:
	jp L2884
L2886:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2894
	cp wa,1
	jr z,L2895
	cp wa,2
	jr z,L2896
	cp wa,3
	jr z,L2897
	jr L2893
L2894:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program_u16__20
	lda xsp,(xsp+12)
	jr L2893
L2895:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program_u16__20
	lda xsp,(xsp+12)
	jr L2893
L2896:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program_u16__20
	lda xsp,(xsp+12)
	jr L2893
L2897:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program_u16__20
	lda xsp,(xsp+12)
	jr L2893
L2893:
	jr L2884
L2887:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2899
	cp wa,1
	jr z,L2900
	cp wa,2
	jr z,L2901
	cp wa,3
	jr z,L2902
	jr L2898
L2899:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program_u32__20
	lda xsp,(xsp+12)
	jr L2898
L2900:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program_u32__20
	lda xsp,(xsp+12)
	jr L2898
L2901:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program_u32__20
	lda xsp,(xsp+12)
	jr L2898
L2902:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program_u32__20
	lda xsp,(xsp+12)
	jr L2898
L2898:
	jr L2884
L2884:
	ld a,(xsp+24)
	push xwa
	ld a,(xsp+12)
	push xwa
	call _dma_set_start_vector__20
	lda xsp,(xsp+8)
L2878:
	pop xiz
	ret

; function ngpc_dma_init
_ngpc_dma_init:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jp L2913
L2910:
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
L2912:
	inc 1,izl
L2913:
	ld a,izl
	cp a,4
	jp ult,L2910
L2911:
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
L2914:
L2909:
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
L2916:
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
L2918:
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
L2920:
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
L2922:
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
L2924:
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
L2926:
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
L2928:
	ret

; function ngpc_dma_timer0_hblank_enable
_ngpc_dma_timer0_hblank_enable:
	ld wa,1
	push xwa
	call _ngpc_dma_timer0_hblank_enable_treg0
	lda xsp,(xsp+4)
L2930:
	ret

; function ngpc_dma_timer0_hblank_enable_treg0
_ngpc_dma_timer0_hblank_enable_treg0:
	andb (024h),60
	ld a,(xsp+4)
	ld (022h),a
	orb (020h),1
L2932:
	ret

; function ngpc_dma_timer0_hblank_disable
_ngpc_dma_timer0_hblank_disable:
	andb (020h),254
L2934:
	ret

; function ngpc_dma_timer01_hblank_enable
_ngpc_dma_timer01_hblank_enable:
	andb (024h),48
	ldb (022h),1
	ldb (023h),1
	orb (020h),3
L2936:
	ret

; function ngpc_dma_timer01_hblank_disable
_ngpc_dma_timer01_hblank_disable:
	andb (020h),252
L2938:
	ret

; function ngpc_dma_timer1_from_timer0_enable
_ngpc_dma_timer1_from_timer0_enable:
	ld wa,1
	push xwa
	call _ngpc_dma_timer1_from_timer0_enable_treg1
	lda xsp,(xsp+4)
L2940:
	ret

; function ngpc_dma_timer1_from_timer0_enable_treg1
_ngpc_dma_timer1_from_timer0_enable_treg1:
	andb (024h),243
	ld a,(xsp+4)
	ld (023h),a
	orb (020h),2
L2942:
	ret

; function ngpc_dma_timer1_disable
_ngpc_dma_timer1_disable:
	andb (020h),253
L2944:
	ret

; function ngpc_dma_hblank_stream_begin
_ngpc_dma_hblank_stream_begin:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2948
	jr L2947
L2948:
	ld a,(xsp+12)
	ld (xiz),a
	ld xwa,(xsp+16)
	ld (xiz+2),xwa
	ld xwa,(xsp+20)
	ld (xiz+6),xwa
	ld wa,(xsp+24)
	ld (xiz+10),wa
L2947:
	pop xiz
	ret

; function ngpc_dma_hblank_stream_rearm
_ngpc_dma_hblank_stream_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2952
	jr L2951
L2952:
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
L2951:
	pop xiz
	ret

; function ngpc_dma_hblank_stream_end
_ngpc_dma_hblank_stream_end:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L2956
	jr L2955
L2956:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L2955:
	ret

; function ngpc_dma_stream_begin_u8
_ngpc_dma_stream_begin_u8:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2960
	jr L2959
L2960:
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
L2959:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u8
_ngpc_dma_stream_rearm_u8:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2964
	jr L2963
L2964:
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
L2963:
	pop xiz
	ret

; function ngpc_dma_stream_end_u8
_ngpc_dma_stream_end_u8:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L2968
	jr L2967
L2968:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L2967:
	ret

; function ngpc_dma_stream_begin_u16
_ngpc_dma_stream_begin_u16:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2972
	jr L2971
L2972:
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
L2971:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u16
_ngpc_dma_stream_rearm_u16:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2976
	jr L2975
L2976:
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
L2975:
	pop xiz
	ret

; function ngpc_dma_stream_end_u16
_ngpc_dma_stream_end_u16:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L2980
	jr L2979
L2980:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L2979:
	ret

; function ngpc_dma_stream_begin_u32
_ngpc_dma_stream_begin_u32:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2984
	jr L2983
L2984:
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
L2983:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u32
_ngpc_dma_stream_rearm_u32:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2988
	jr L2987
L2988:
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
L2987:
	pop xiz
	ret

; function ngpc_dma_stream_end_u32
_ngpc_dma_stream_end_u32:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L2992
	jr L2991
L2992:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L2991:
	ret

; function ngpc_dma_stop
_ngpc_dma_stop:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L3001
	jr L3000
L3001:
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
	jr z,L3003
	cp wa,1
	jr z,L3004
	cp wa,2
	jr z,L3005
	cp wa,3
	jr z,L3006
	jr L3002
L3003:
	call _dma0_clear__20
	jr L3002
L3004:
	call _dma1_clear__20
	jr L3002
L3005:
	call _dma2_clear__20
	jr L3002
L3006:
	call _dma3_clear__20
	jr L3002
L3002:
L3000:
	pop xiz
	ret

; function ngpc_dma_remaining
_ngpc_dma_remaining:
	ld a,(xsp+4)
	extz wa
	cp wa,0
	jr z,L3016
	cp wa,1
	jr z,L3017
	cp wa,2
	jr z,L3018
	cp wa,3
	jr z,L3019
	jr L3020
L3016:
	ldc wa,dmac0
	jr L3014
L3017:
	ldc wa,dmac1
	jr L3014
L3018:
	ldc wa,dmac2
	jr L3014
L3019:
	ldc wa,dmac3
	jr L3014
L3020:
	ld wa,0
	jr L3014
L3015:
L3014:
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
	jr z,L3025
	ld wa,1
	jr L3026
L3025:
	ld wa,0
L3026:
	jr L3024
L3024:
	ret

; function ngpc_dma_set_done_handler
_ngpc_dma_set_done_handler:
	ld a,(xsp+4)
	cp a,3
	jr ule,L3030
	jr L3029
L3030:
	ld xwa,(xsp+8)
	ld xbc,_s_done_cb__20
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L3029:
	ret

; function ngpc_dma_poll_done
_ngpc_dma_poll_done:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L3036
	ld wa,0
	jr L3035
L3036:
	ld xwa,_s_done_flag__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+0),a
	ld a,(xsp+0)
	cp a,0
	jr z,L3037
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
	jr L3035
L3037:
	ld xwa,_s_was_active__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L3038
	ld a,izl
	push xwa
	call _ngpc_dma_remaining
	lda xsp,(xsp+4)
	cp wa,0
	jr nz,L3038
	ld a,0
	ld xbc,_s_was_active__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,1
	jr L3035
L3038:
	ld wa,0
	jr L3035
L3035:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_dma_pp_init
_ngpc_dma_pp_init:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3042
	jr L3041
L3042:
	ld xwa,(xsp+12)
	ld (xiz),xwa
	ld wa,(xsp+16)
	ld (xiz+4),wa
	ldw (xiz+6),0
L3041:
	pop xiz
	ret

; function ngpc_dma_pp_front
_ngpc_dma_pp_front:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr z,L3048
	ld xwa,(xiz)
	cp xwa,0
	jr nz,L3047
L3048:
	ld xwa,0
	jr L3046
L3047:
	ld xwa,(xiz)
	ld bc,(xiz+6)
	extz xbc
	add xwa,xbc
	jr L3046
L3046:
	pop xiz
	ret

; function ngpc_dma_pp_back
_ngpc_dma_pp_back:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr z,L3054
	ld xwa,(xiz)
	cp xwa,0
	jr nz,L3053
L3054:
	ld xwa,0
	jr L3052
L3053:
	ld xwa,(xiz)
	ld bc,(xiz+6)
	xor bc,(xiz+4)
	extz xbc
	add xwa,xbc
	jr L3052
L3052:
	pop xiz
	ret

; function ngpc_dma_pp_swap
_ngpc_dma_pp_swap:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3058
	jr L3057
L3058:
	ld wa,(xiz+6)
	xor wa,(xiz+4)
	ld (xiz+6),wa
L3057:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u8
_ngpc_dma_autorearm_begin_u8:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L3062
	jr L3061
L3062:
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
L3061:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u16
_ngpc_dma_autorearm_begin_u16:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L3066
	jr L3065
L3066:
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
L3065:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u32
_ngpc_dma_autorearm_begin_u32:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L3070
	jr L3069
L3070:
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
L3069:
	pop xiz
	ret

; function ngpc_dma_autorearm_set_src_u8
_ngpc_dma_autorearm_set_src_u8:
	ld a,(xsp+4)
	cp a,3
	jr ule,L3074
	jr L3073
L3074:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__20
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L3073:
	ret

; function ngpc_dma_autorearm_set_src_u16
_ngpc_dma_autorearm_set_src_u16:
	ld a,(xsp+4)
	cp a,3
	jr ule,L3078
	jr L3077
L3078:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__20
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L3077:
	ret

; function ngpc_dma_autorearm_set_src_u32
_ngpc_dma_autorearm_set_src_u32:
	ld a,(xsp+4)
	cp a,3
	jr ule,L3082
	jr L3081
L3082:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__20
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L3081:
	ret

; function ngpc_dma_autorearm_enable
_ngpc_dma_autorearm_enable:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L3092
	jp L3091
L3092:
	jr L3093
	jp L3091
L3093:
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
	jr z,L3096
	cp wa,1
	jr z,L3097
	cp wa,2
	jp z,L3098
	jr L3095
L3095:
L3096:
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
	jp L3094
L3097:
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
	jr L3094
L3098:
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
	jr L3094
L3094:
L3091:
	pop xiz
	ret

; function ngpc_dma_autorearm_disable
_ngpc_dma_autorearm_disable:
	ld a,(xsp+4)
	cp a,3
	jr ule,L3102
	jr L3101
L3102:
	ld a,0
	ld xbc,_s_rearm_enabled__20
	ld e,(xsp+4)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3101:
	ret

; function plane_reg_x
_plane_reg_x__21:
	ld a,(xsp+4)
	cp a,1
	jr nz,L3106
	ld xwa,08034h
	jr L3105
L3106:
	ld xwa,08032h
	jr L3105
L3105:
	ret

; function plane_reg_y
_plane_reg_y__21:
	ld a,(xsp+4)
	cp a,1
	jr nz,L3110
	ld xwa,08035h
	jr L3109
L3110:
	ld xwa,08033h
	jr L3109
L3109:
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
L3112:
	ret

; function ngpc_dma_raster_begin_ex
_ngpc_dma_raster_begin_ex:
	push xiz
	lda xsp,(xsp-8)
	ld xiz,(xsp+16)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3122
	jp L3121
L3122:
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
	jr z,L3123
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
	jr L3124
L3123:
	ld xwa,(xsp+36)
	cp xwa,0
	jr z,L3125
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
	jr L3126
L3125:
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
L3126:
L3124:
	ld xwa,(xsp+28)
	cp xwa,0
	jr z,L3127
	ld xwa,(xsp+36)
	cp xwa,0
	jr z,L3127
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
	jr L3128
L3127:
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
L3128:
L3121:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function ngpc_dma_raster_enable
_ngpc_dma_raster_enable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3135
	jr L3134
L3135:
	ldb (xiz+1),0
	ld xwa,(xiz+2)
	cp xwa,0
	jr nz,L3136
	ld xwa,(xiz+6)
	cp xwa,0
	jr nz,L3136
	jr L3134
L3136:
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L3137
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L3137
	call _ngpc_dma_timer01_hblank_enable
	jr L3138
L3137:
	call _ngpc_dma_timer0_hblank_enable
L3138:
	ldb (xiz+1),1
L3134:
	pop xiz
	ret

; function ngpc_dma_raster_rearm
_ngpc_dma_raster_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3147
	jr L3146
L3147:
	ld a,(xiz+1)
	cp a,0
	jr nz,L3148
	jr L3146
L3148:
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L3149
	lda xwa,(xiz+10)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L3150
	lda xwa,(xiz+24)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
L3150:
	jr L3151
L3149:
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L3152
	lda xwa,(xiz+10)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
L3152:
L3151:
L3146:
	pop xiz
	ret

; function ngpc_dma_raster_disable
_ngpc_dma_raster_disable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3159
	jr L3158
L3159:
	ld a,(xiz+1)
	cp a,0
	jr z,L3160
	ld a,(xiz+10)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L3161
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L3161
	ld a,(xiz+24)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	call _ngpc_dma_timer01_hblank_disable
	jr L3162
L3161:
	call _ngpc_dma_timer0_hblank_disable
L3162:
L3160:
	ldb (xiz+1),0
L3158:
	pop xiz
	ret

; function ngpc_dma_raster_build_parallax_table
_ngpc_dma_raster_build_parallax_table:
	push xiz
	lda xsp,(xsp-6)
	ld xiy,(xsp+18)
	ld xwa,(xsp+14)
	cp xwa,0
	jr nz,L3182
	jp L3181
L3182:
	ld xwa,xiy
	cp xwa,0
	jr z,L3184
	ld a,(xsp+22)
	cp a,0
	jr nz,L3183
L3184:
	ld izl,0
	jr L3188
L3185:
	ld a,0
	ld xbc,(xsp+14)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3187:
	inc 1,izl
L3188:
	ld a,izl
	cp a,152
	jr ult,L3185
L3186:
	jp L3181
L3183:
	ld ixl,0
	jp L3192
L3189:
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
	jr ge,L3193
	ld xwa,xiy
	ld c,ixl
	extz bc
	add bc,1
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L3194
L3193:
	ld a,152
	extz wa
L3194:
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
	jr L3198
L3195:
	ld a,(xsp+4)
	ld xbc,(xsp+14)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3197:
	inc 1,izl
L3198:
	ld a,izl
	cp a,(xsp+3)
	jr ult,L3195
L3196:
L3191:
	inc 1,ixl
L3192:
	ld a,ixl
	cp a,(xsp+22)
	jp ult,L3189
L3190:
L3181:
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
L3200:
	ret

; function ngpc_dma_raster_xy_begin_ex
_ngpc_dma_raster_xy_begin_ex:
	push xiz
	lda xsp,(xsp-4)
	ld xiz,(xsp+12)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3206
	jr L3205
L3206:
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
	jr z,L3207
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
	jr L3208
L3207:
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
L3208:
L3205:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function ngpc_dma_raster_xy_enable
_ngpc_dma_raster_xy_enable:
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
	jr L3212
L3214:
	call _ngpc_dma_timer0_hblank_enable
	ldb (xiz+1),1
L3212:
	pop xiz
	ret

; function ngpc_dma_raster_xy_rearm
_ngpc_dma_raster_xy_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3219
	jr L3218
L3219:
	ld a,(xiz+1)
	cp a,0
	jr nz,L3220
	jr L3218
L3220:
	lda xwa,(xiz+6)
	push xwa
	call _ngpc_dma_stream_rearm_u16
	lda xsp,(xsp+4)
L3218:
	pop xiz
	ret

; function ngpc_dma_raster_xy_disable
_ngpc_dma_raster_xy_disable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3225
	jr L3224
L3225:
	ld a,(xiz+1)
	cp a,0
	jr z,L3226
	ld a,(xiz+6)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	call _ngpc_dma_timer0_hblank_disable
L3226:
	ldb (xiz+1),0
L3224:
	pop xiz
	ret

; function ngpc_dma_raster_build_parallax_table_xy
_ngpc_dma_raster_build_parallax_table_xy:
	push xiz
	lda xsp,(xsp-8)
	ld xiy,(xsp+20)
	ld xwa,(xsp+16)
	cp xwa,0
	jr nz,L3246
	jp L3245
L3246:
	ld xwa,xiy
	cp xwa,0
	jr z,L3248
	ld a,(xsp+24)
	cp a,0
	jr nz,L3247
L3248:
	ld izl,0
	jr L3252
L3249:
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
L3251:
	inc 1,izl
L3252:
	ld a,izl
	cp a,152
	jr ult,L3249
L3250:
	jp L3245
L3247:
	ld ixl,0
	jp L3256
L3253:
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
	jr ge,L3257
	ld xwa,xiy
	ld c,ixl
	extz bc
	add bc,1
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L3258
L3257:
	ld a,152
	extz wa
L3258:
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
	jr L3262
L3259:
	ld wa,(xsp+6)
	ld xbc,(xsp+16)
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3261:
	inc 1,izl
L3262:
	ld a,izl
	cp a,(xsp+3)
	jr ult,L3259
L3260:
L3255:
	inc 1,ixl
L3256:
	ld a,ixl
	cp a,(xsp+24)
	jp ult,L3253
L3254:
L3245:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function audio_init
_audio_init:
	call _player_init
L3264:
	ret

; function audio_update
_audio_update:
	call _player_update
L3266:
	ret

; function music_play
_music_play:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	cp a,6
	jr ult,L3270
	call _music_stop
	jr L3269
L3270:
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
L3269:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function music_stop
_music_stop:
	call _player_stop
	ldb (_cur_song__22),255
L3272:
	ret

; function music_fade
_music_fade:
	call _player_stop
L3274:
	ret

; function music_current
_music_current:
	ld a,(_cur_song__22)
	jr L3276
L3276:
	ret

; function sfx
_sfx:
	ld a,(xsp+4)
	extz wa
	cp wa,0
	jr z,L3290
	cp wa,1
	jr z,L3291
	cp wa,2
	jr z,L3292
	cp wa,3
	jp z,L3293
	cp wa,4
	jp z,L3294
	cp wa,5
	jp z,L3295
	cp wa,7
	jp z,L3296
	cp wa,6
	jp z,L3297
	jp L3298
L3290:
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
	jp L3289
L3291:
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
	jp L3289
L3292:
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
	jp L3289
L3293:
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
	jr L3289
L3294:
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
	jr L3289
L3295:
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
	jr L3289
L3296:
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
	jr L3289
L3297:
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
	jr L3289
L3298:
	jr L3289
L3289:
L3288:
	ret

; function scr_map
_scr_map__23:
	ld c,(xsp+4)
	cp c,0
	jr nz,L3303
	ld xwa,36864
	jr L3304
L3303:
	ld xwa,38912
L3304:
	jr L3302
L3302:
	ret

; function pal_base
_pal_base__23:
	ld a,(xsp+4)
	cp a,2
	jr nz,L3309
	ld xwa,33280
	jr L3308
L3309:
	ld a,(xsp+4)
	cp a,0
	jr nz,L3310
	ld xwa,33408
	jr L3308
L3310:
	ld xwa,33536
	jr L3308
L3308:
	ret

; function ngpc_gfx_load_tiles
_ngpc_gfx_load_tiles:
	push xiz
	lda xsp,(xsp-8)
	ld xwa,40960
	ld xiy,xwa
	ld iz,0
	jr L3320
L3317:
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
L3319:
	inc 1,iz
L3320:
	ld wa,iz
	cp wa,(xsp+20)
	jr ult,L3317
L3318:
L3316:
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
	jr L3330
L3327:
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
L3329:
	inc 1,iz
L3330:
	ld wa,iz
	cp wa,(xsp+20)
	jr ult,L3327
L3328:
L3326:
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
	jr L3340
L3337:
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
L3339:
	inc 1,iz
L3340:
	ld wa,iz
	cp wa,ix
	jr ult,L3337
L3338:
L3336:
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
	jr L3350
L3347:
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
L3349:
	inc 1,iz
L3350:
	ld wa,iz
	cp wa,ix
	jr ult,L3347
L3348:
L3346:
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
	jr L3352
L3352:
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
L3354:
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
L3356:
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
L3358:
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
	jr L3368
L3365:
	ld wa,0
	ld xbc,xix
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3367:
	inc 1,iz
L3368:
	ld wa,iz
	cp wa,1024
	jr ult,L3365
L3366:
L3364:
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
	jr L3378
L3375:
	ld wa,ix
	ld xbc,xiy
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3377:
	inc 1,iz
L3378:
	ld wa,iz
	cp wa,1024
	jr ult,L3375
L3376:
L3374:
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
	jr L3392
L3389:
	ld a,(xsp+28)
	add a,ixl
	and a,31
	ld (xsp+8),a
	ld a,(xsp+8)
	extz wa
	sll 5,wa
	ld (xsp+10),wa
	ld izl,0
	jr L3396
L3393:
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
L3395:
	inc 1,izl
L3396:
	ld a,izl
	cp a,(xsp+32)
	jr ult,L3393
L3394:
L3391:
	inc 1,ixl
L3392:
	ld a,ixl
	cp a,(xsp+36)
	jr ult,L3389
L3390:
L3388:
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
	jr L3410
L3407:
	ld a,(xsp+30)
	add a,(xsp+6)
	and a,31
	ld (xsp+8),a
	ld a,(xsp+8)
	extz wa
	sll 5,wa
	ld (xsp+10),wa
	ld ixl,0
	jr L3414
L3411:
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
L3413:
	inc 1,ixl
L3414:
	ld a,ixl
	cp a,(xsp+34)
	jr ult,L3411
L3412:
L3409:
	incb 1,(xsp+6)
L3410:
	ld a,(xsp+6)
	cp a,(xsp+38)
	jr ult,L3407
L3408:
L3406:
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
L3416:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_gfx_set_bg_color
_ngpc_gfx_set_bg_color:
	ld wa,(xsp+4)
	ld xbc,33760
	ld (xbc),wa
	ldb (08118h),128
L3418:
	ret

; function ngpc_gfx_scroll
_ngpc_gfx_scroll:
	ld a,(xsp+4)
	cp a,0
	jr nz,L3423
	ld a,(xsp+8)
	ld (08032h),a
	ld a,(xsp+12)
	ld (08033h),a
	jr L3424
L3423:
	ld a,(xsp+8)
	ld (08034h),a
	ld a,(xsp+12)
	ld (08035h),a
L3424:
L3422:
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
	jr nz,L3439
	ldb (08032h),0
	ldb (08033h),0
	jr L3440
L3439:
	ld a,(xsp+8)
	extz wa
	ld c,ixl
	cp c,0
	jr z,L3442
L3441:
	sra 1,wa
	djnz c,L3441
L3442:
	ld (08032h),a
	ld a,(xsp+12)
	extz wa
	ld c,ixl
	cp c,0
	jr z,L3444
L3443:
	sra 1,wa
	djnz c,L3443
L3444:
	ld (08033h),a
L3440:
	ld a,izl
	cp a,255
	jr nz,L3445
	ldb (08034h),0
	ldb (08035h),0
	jr L3446
L3445:
	ld a,(xsp+8)
	extz wa
	ld c,izl
	cp c,0
	jr z,L3448
L3447:
	sra 1,wa
	djnz c,L3447
L3448:
	ld (08034h),a
	ld a,(xsp+12)
	extz wa
	ld c,izl
	cp c,0
	jr z,L3450
L3449:
	sra 1,wa
	djnz c,L3449
L3450:
	ld (08035h),a
L3446:
L3438:
	pop xiz
	ret

; function ngpc_gfx_swap_planes
_ngpc_gfx_swap_planes:
	xorb (08030h),128
L3452:
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
L3454:
	ret

; function ngpc_gfx_sprite_offset
_ngpc_gfx_sprite_offset:
	ld a,(xsp+4)
	ld (08020h),a
	ld a,(xsp+8)
	ld (08021h),a
L3456:
	ret

; function ngpc_gfx_lcd_invert
_ngpc_gfx_lcd_invert:
	ld a,(xsp+4)
	cp a,0
	jr z,L3461
	orb (08012h),128
	jr L3462
L3461:
	andb (08012h),127
L3462:
L3460:
	ret

; function ngpc_gfx_set_outside_color
_ngpc_gfx_set_outside_color:
	ld a,(08012h)
	and a,248
	ld c,(xsp+4)
	and c,7
	or a,c
	ld (08012h),a
L3464:
	ret

; function ngpc_gfx_char_over
_ngpc_gfx_char_over:
	ld c,(08010h)
	extz bc
	and bc,128
	cp bc,0
	jr z,L3469
	ld wa,1
	jr L3470
L3469:
	ld wa,0
L3470:
	jr L3468
L3468:
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
L3472:
	lda xsp,(xsp+4)
	ret

; function ngpc_tile_rotate90
_ngpc_tile_rotate90:
	push xiz
	lda xsp,(xsp-6)
	ld ixl,0
	jr L3490
L3487:
	ld iy,0
	ld izl,0
	jr L3494
L3491:
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
	jr z,L3496
L3495:
	srl 1,wa
	djnz c,L3495
L3496:
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
	jr z,L3498
L3497:
	sll 1,bc
	djnz e,L3497
L3498:
	or wa,bc
	ld iy,wa
L3493:
	inc 1,izl
L3494:
	ld a,izl
	cp a,8
	jr ult,L3491
L3492:
	ld wa,iy
	ld xbc,(xsp+18)
	ld e,ixl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3489:
	inc 1,ixl
L3490:
	ld a,ixl
	cp a,8
	jp ult,L3487
L3488:
L3486:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_tile_rotate270
_ngpc_tile_rotate270:
	push xiz
	lda xsp,(xsp-6)
	ld ixl,0
	jr L3516
L3513:
	ld iy,0
	ld izl,0
	jr L3520
L3517:
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
	jr z,L3522
L3521:
	srl 1,wa
	djnz c,L3521
L3522:
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
	jr z,L3524
L3523:
	sll 1,bc
	djnz e,L3523
L3524:
	or wa,bc
	ld iy,wa
L3519:
	inc 1,izl
L3520:
	ld a,izl
	cp a,8
	jr ult,L3517
L3518:
	ld wa,iy
	ld xbc,(xsp+18)
	ld e,ixl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3515:
	inc 1,ixl
L3516:
	ld a,ixl
	cp a,8
	jp ult,L3513
L3514:
L3512:
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
L3526:
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
L3528:
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
L3530:
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
L3532:
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
L3534:
	lda xsp,(xsp+4)
	ret

; function ngpc_sprite_hide_all
_ngpc_sprite_hide_all:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L3544
L3541:
	ld a,izl
	push xwa
	call _ngpc_sprite_hide
	lda xsp,(xsp+4)
L3543:
	inc 1,izl
L3544:
	ld a,izl
	cp a,64
	jr ult,L3541
L3542:
L3540:
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
L3546:
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
L3548:
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
	jr L3550
L3550:
	ret

; function ngpc_text_print
_ngpc_text_print:
	push xiz
	lda xsp,(xsp-2)
	ld xiz,(xsp+26)
	ld a,(xsp+18)
	ld iyl,a
	jr L3560
L3558:
	ld a,(xiz)
	ld ixl,a
	ld a,ixl
	cp a,32
	jr ult,L3561
	ld a,ixl
	cp a,128
	jr uge,L3561
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
L3561:
	inc 1,iyl
	ld a,iyl
	cp a,20
	jr ult,L3562
	jr L3559
L3562:
	ld xwa,xiz
	inc 1,xwa
	ld xiz,xwa
L3560:
	ld a,(xiz)
	cp a,0
	jr nz,L3558
L3559:
L3557:
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
	jr L3576
L3573:
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
L3575:
	inc 1,izl
L3576:
	ld a,izl
	cp a,5
	jr ult,L3573
L3574:
	ld a,5
	sub a,(xsp+38)
	ld izl,a
	jr L3580
L3577:
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
L3579:
	inc 1,izl
L3580:
	ld a,izl
	cp a,5
	jr ult,L3577
L3578:
L3572:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_text_print_hex
_ngpc_text_print_hex:
	push xiz
	lda xsp,(xsp-8)
	ld izl,0
	jr L3594
L3591:
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
	jr z,L3596
L3595:
	srl 1,wa
	djnz c,L3595
L3596:
	and wa,15
	ld ixl,a
	ld a,ixl
	cp a,10
	jr uge,L3597
	ld a,ixl
	extz wa
	add wa,48
	ld iy,wa
	jr L3598
L3597:
	ld a,ixl
	extz wa
	sub wa,10
	add wa,65
	ld iy,wa
L3598:
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
L3593:
	inc 1,izl
L3594:
	ld a,izl
	cp a,(xsp+36)
	jp ult,L3591
L3592:
L3590:
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
	jr L3614
L3611:
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
L3613:
	inc 1,izl
L3614:
	ld a,izl
	cp a,5
	jr ult,L3611
L3612:
	ld a,5
	sub a,(xsp+40)
	ld izl,a
	jr L3618
L3615:
	ld a,(xsp+8)
	cp a,0
	jr z,L3619
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L3619
	ld a,izl
	cp a,4
	jr uge,L3619
	ld ix,32
	jr L3620
L3619:
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
L3620:
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
L3617:
	inc 1,izl
L3618:
	ld a,izl
	cp a,5
	jr ult,L3615
L3616:
L3610:
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
L3622:
	ret

; function ngpc_text_tile_screen
_ngpc_text_tile_screen:
	push xiz
	lda xsp,(xsp-4)
	ld wa,0
	ld (xsp+2),wa
	ld ixl,0
	jr L3636
L3633:
	ld izl,0
	jr L3640
L3637:
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
L3639:
	inc 1,izl
L3640:
	ld a,izl
	cp a,20
	jr ult,L3637
L3638:
L3635:
	inc 1,ixl
L3636:
	ld a,ixl
	cp a,19
	jr ult,L3633
L3634:
L3632:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function hud_score_reset
_hud_score_reset:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L3650
L3647:
	ld a,0
	ld xbc,_s_dig__26
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3649:
	inc 1,izl
L3650:
	ld a,izl
	cp a,7
	jr ult,L3647
L3648:
L3646:
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
	jr L3659
L3657:
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
L3659:
	ld wa,iy
	cp wa,0
	jr z,L3660
	ld a,izl
	cp a,0
	jr ugt,L3657
L3660:
L3658:
L3656:
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
	jr L3670
L3667:
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
L3669:
	inc 1,iz
L3670:
	ld wa,iz
	cp wa,552
	jr ult,L3667
L3668:
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
L3666:
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
L3672:
	ret

; function hud_clear_top
_hud_clear_top:
	push xiz
	lda xsp,(xsp-2)
	ld ixl,0
	jr L3686
L3683:
	ld izl,0
	jr L3690
L3687:
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
L3689:
	inc 1,izl
L3690:
	ld a,izl
	cp a,20
	jr ult,L3687
L3688:
L3685:
	inc 1,ixl
L3686:
	ld a,ixl
	cp a,15
	jr ult,L3683
L3684:
L3682:
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
	jr L3698
L3696:
	inc 1,izl
L3698:
	ld xwa,xix
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L3696
L3697:
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
L3695:
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
	jr L3708
L3705:
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
L3707:
	inc 1,izl
L3708:
	ld a,izl
	cp a,20
	jr ult,L3705
L3706:
L3704:
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
L3710:
	ret

; function hud_race
_hud_race:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	cp a,(_h_time__26)
	jr z,L3736
	ld a,(_h_time__26)
	cp a,255
	jr nz,L3737
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
L3737:
	ld c,(xsp+12)
	cp c,10
	jr uge,L3738
	ld wa,2
	jr L3739
L3738:
	ld wa,1
L3739:
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
	jr uge,L3740
	ld wa,2
	jr L3741
L3740:
	ld wa,1
L3741:
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
L3736:
	ld a,(xsp+28)
	cp a,(_h_stage__26)
	jr z,L3742
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
L3742:
	ld wa,(xsp+24)
	mul xwa,3
	add wa,9
	extz xwa
	div xwa,10
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,(_h_prog__26)
	jr z,L3743
	ld izl,0
	jr L3747
L3744:
	ld wa,0
	push xwa
	ld c,izl
	cp c,(xsp+5)
	jr uge,L3748
	ld wa,97
	jr L3749
L3748:
	ld wa,96
L3749:
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
L3746:
	inc 1,izl
L3747:
	ld a,izl
	cp a,3
	jr ult,L3744
L3745:
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
L3743:
	ld a,(xsp+16)
	cp a,(_h_kmh__26)
	jp z,L3750
	ld a,(xsp+16)
	extz wa
	sll 1,wa
	ld (xsp+2),wa
	ld a,(_h_kmh__26)
	cp a,255
	jr nz,L3751
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
L3751:
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
L3750:
	ld a,(xsp+20)
	cp a,(_h_gear__26)
	jr z,L3752
	ld c,(xsp+20)
	cp c,1
	jr nz,L3753
	ld xwa,_S26_3
	jr L3754
L3753:
	ld xwa,_S26_4
L3754:
	push xwa
	ld wa,1
	push xwa
	ld wa,16
	push xwa
	ld c,(xsp+32)
	cp c,1
	jr nz,L3755
	ld wa,1
	jr L3756
L3755:
	ld c,(xsp+32)
	cp c,2
	jr nz,L3757
	ld wa,2
	jr L3758
L3757:
	ld wa,0
L3758:
L3756:
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	ld a,(xsp+20)
	ld (_h_gear__26),a
L3752:
L3735:
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
	jr uge,L3763
	ld a,izl
	extz wa
	mul xwa,7
	extz xwa
	div xwa,6
	jr L3764
L3763:
	ld wa,112
	ld c,izl
	extz bc
	sub bc,96
	srl 3,bc
	sub wa,bc
L3764:
	ld (xsp+0),wa
	ld a,(xsp+14)
	extz wa
	mul xwa,(xsp+0)
	srl 7,wa
	jr L3762
L3762:
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
L3766:
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
L3768:
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
	jr ult,L3775
	jr L3774
L3775:
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
L3776:
	ld a,(xiz)
	and a,231
	ld (xiz),a
	ld bc,4
	exts xbc
	ld xwa,xiz
	add xwa,xbc
	ld xiz,xwa
L3778:
	dec 1,ixl
	ld a,ixl
	cp a,0
	jr nz,L3776
L3777:
L3774:
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
	jp L3810
L3807:
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
	jp L3814
L3811:
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
	jp L3818
L3815:
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
	jp L3822
L3819:
	ld wa,(xsp+16)
	ld bc,14
	ld de,2
	ld l,izl
	extz hl
	mul xde,hl
	sub bc,de
	cp c,0
	jr z,L3825
L3824:
	srl 1,wa
	djnz c,L3824
L3825:
	and wa,3
	cp wa,0
	jr nz,L3823
	jp L3821
L3823:
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	cp a,(xsp+2)
	jr ule,L3826
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld (xsp+2),a
	ldb (xsp+5),0
L3826:
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	cp a,(xsp+2)
	jr nz,L3827
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+5)
	jr ule,L3827
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+5),a
L3827:
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+3)
	jr ule,L3828
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+3),a
L3828:
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+4)
	jr uge,L3829
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+4),a
L3829:
L3821:
	inc 1,izl
L3822:
	ld a,izl
	cp a,8
	jp ult,L3819
L3820:
L3817:
	inc 1,ixl
L3818:
	ld a,ixl
	cp a,8
	jp ult,L3815
L3816:
L3813:
	incb 1,(xsp+1)
L3814:
	ld a,(xsp+1)
	cp a,(xsp+8)
	jp ult,L3811
L3812:
L3809:
	incb 1,(xsp+0)
L3810:
	ld a,(xsp+0)
	cp a,(_body__29+28)
	jp ult,L3807
L3808:
	ld a,(xsp+4)
	cp a,(xsp+3)
	jr ule,L3830
	ld xwa,(_body__29+18)
	ld a,(xwa)
	extz wa
	sll 2,wa
	ld (_car_wheel_dx__29),a
	jr L3806
L3830:
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
	jr ule,L3831
	ld wa,(xsp+6)
	sub wa,(xsp+8)
	srl 1,wa
	extz wa
	jr L3832
L3831:
	ld wa,0
L3832:
	ld (_car_wheel_dx__29),a
L3806:
	lda xsp,(xsp+20)
	pop xiz
	ret

; function id_car_select
_id_car_select:
	ld c,(xsp+4)
	cp c,1
	jr uge,L3837
	ld a,(xsp+4)
	extz wa
	jr L3838
L3837:
	ld a,0
	extz wa
L3838:
	ld (_car_variant__29),a
	ld xwa,_body__29
	push xwa
	ld a,(_car_variant__29)
	push xwa
	call _id_fleet_body
	lda xsp,(xsp+8)
	call _mesure_roues__29
L3836:
	ret

; function id_car_char_count
_id_car_char_count:
	ld c,(xsp+4)
	cp c,0
	jr z,L3843
	ld wa,(_body__29+4)
	jr L3844
L3843:
	ld wa,(_body__29+26)
L3844:
	srl 3,wa
	jr L3842
L3842:
	ret

; function id_car_half_width
_id_car_half_width:
	ld xwa,(_body__29+18)
	ld a,(xwa)
	extz wa
	sll 2,wa
	jr L3846
L3846:
	ret

; function id_car_wheel_dx
_id_car_wheel_dx:
	ld a,(_car_wheel_dx__29)
	jr L3848
L3848:
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
	jr L3864
L3861:
	ld wa,40960
	extz xwa
	ld bc,(xsp+24)
	add bc,ix
	mul xbc,16
	add xwa,xbc
	ld (xsp+8),xwa
	ld iz,0
	jr L3868
L3865:
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
L3867:
	inc 1,iz
L3868:
	ld wa,iz
	cp wa,8
	jr ult,L3865
L3866:
L3863:
	inc 1,ix
L3864:
	ld wa,ix
	cp wa,(xsp+2)
	jr ult,L3861
L3862:
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
	jr ule,L3869
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
	jr L3870
L3869:
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
L3870:
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
L3860:
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
	jr uge,L3903
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
	jp L3902
L3903:
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
	jr uge,L3904
	ld a,(xsp+50)
	ld (xsp+4),a
	ldb (xsp+5),0
	jr L3905
L3904:
	ld a,(xsp+3)
	sub a,(xsp+50)
	ld (xsp+4),a
	ldb (xsp+5),1
L3905:
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
	jr L3909
L3906:
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
	jr z,L3910
	ld a,(xsp+11)
	sub a,1
	sub a,(xsp+12)
	extz wa
	jr L3911
L3910:
	ld a,(xsp+12)
	extz wa
L3911:
	ld (xsp+13),a
	ld a,(xsp+13)
	cp a,(xsp+6)
	jr uge,L3912
	ld a,(xsp+13)
	ld (xsp+6),a
L3912:
	ld a,(xsp+13)
	cp a,(xsp+7)
	jr ule,L3913
	ld a,(xsp+13)
	ld (xsp+7),a
L3913:
L3908:
	inc 1,izl
L3909:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L3906
L3907:
	ld a,(xsp+6)
	cp a,(xsp+7)
	jr ule,L3914
	ldb (xsp+6),0
	ldb (xsp+7),0
L3914:
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
	jp L3918
L3915:
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
	jr nz,L3919
	ld wa,0
	jr L3920
L3919:
	ld wa,5
L3920:
	ld (xsp+13),a
	ld izl,0
	jp L3924
L3921:
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
	jr z,L3925
	ld a,(xsp+12)
	sub a,1
	sub a,(xiy)
	extz wa
	jr L3926
L3925:
	ld a,(xiy)
	extz wa
L3926:
	ld (xsp+18),a
L3927:
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
	jr z,L3930
	ld wa,128
	jr L3931
L3930:
	ld wa,0
L3931:
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
L3929:
L3928:
	incb 1,(xsp+2)
L3923:
	inc 1,izl
L3924:
	ld a,izl
	cp a,(xsp+11)
	jr uge,L3932
	ld a,(xsp+2)
	cp a,64
	jp ult,L3921
L3932:
L3922:
L3917:
	incb 1,(xsp+1)
L3918:
	ld a,(xsp+1)
	cp a,(_body__29+28)
	jp ult,L3915
L3916:
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
L3902:
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
	jp L3952
L3949:
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
	jr nz,L3953
	ld wa,0
	jr L3954
L3953:
	ld wa,5
L3954:
	ld (xsp+6),a
	ldb (xsp+0),0
	jp L3958
L3955:
	ld xwa,(_body__29+22)
	ld c,(xsp+4)
	add c,(xsp+0)
	extz bc
	muls xbc,3
	add xwa,xbc
	lda xwa,(xwa)
	ld xiy,xwa
L3959:
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
L3961:
L3960:
	incb 1,(xsp+2)
L3957:
	incb 1,(xsp+0)
L3958:
	ld a,(xsp+0)
	cp a,(xsp+5)
	jr uge,L3962
	ld a,(xsp+2)
	cp a,64
	jp ult,L3955
L3962:
L3956:
L3951:
	incb 1,(xsp+1)
L3952:
	ld a,(xsp+1)
	cp a,(_body__29+28)
	jp ult,L3949
L3950:
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
L3948:
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
	jr z,L3968
	ld wa,(_car_at_x__29)
	ld (xsp+10),wa
L3968:
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
	jr z,L3969
	ld wa,128
	jr L3970
L3969:
	ld wa,0
L3970:
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
L3967:
	lda xsp,(xsp+22)
	ret

; function lean_last
_lean_last__29:
	push xiz
	lda xsp,(xsp-2)
	ld c,(_body__29+29)
	cp c,0
	jr ule,L3976
	ld a,(_body__29+29)
	extz wa
	sub wa,1
	jr L3977
L3976:
	ld wa,0
L3977:
	ld izl,a
	ld a,izl
	cp a,2
	jr ule,L3978
	ld izl,2
L3978:
	ld a,izl
	jr L3975
L3975:
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
	jr nz,L3988
	ld wa,0
	jr L3987
L3988:
	ld c,(_lean_hold__29)
	cp c,12
	jr ult,L3989
	ld wa,3
	jr L3990
L3989:
	ld c,(_lean_hold__29)
	cp c,5
	jr ult,L3991
	ld wa,2
	jr L3992
L3991:
	ld wa,1
L3992:
L3990:
	ld izl,a
	ld c,izl
	cp c,(xsp+0)
	jr ule,L3993
	ld a,(xsp+0)
	extz wa
	jr L3994
L3993:
	ld a,izl
	extz wa
L3994:
	jr L3987
L3987:
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
	jr z,L4003
	ld a,(xsp+0)
	cp a,0
	jr nz,L4002
L4003:
	ld wa,0
	jr L4001
L4002:
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
	jr le,L4004
	ld iz,16
L4004:
	ld c,(_lean_side__29)
	cp c,0
	jr ge,L4005
	ld wa,iz
	neg wa
	jr L4006
L4005:
	ld wa,iz
L4006:
	jr L4001
L4001:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function id_car_last_x
_id_car_last_x:
	ld wa,(_car_last_x__29)
	jr L4008
L4008:
	ret

; function id_car_last_top
_id_car_last_top:
	ld a,(_car_last_top__29)
	jr L4010
L4010:
	ret

; function id_car_draw
_id_car_draw:
	push xiz
	lda xsp,(xsp-8)
	ld a,(xsp+20)
	cp a,0
	jr z,L4039
	ld a,(_lean_side__29)
	cp a,(xsp+20)
	jr z,L4040
	ld a,(xsp+20)
	ld (_lean_side__29),a
	ldb (_lean_hold__29),0
L4040:
	ld a,(_lean_hold__29)
	cp a,255
	jr uge,L4041
	incb 1,(_lean_hold__29)
L4041:
	ldb (_lean_wait__29),2
	jr L4042
L4039:
	ld a,(_lean_hold__29)
	cp a,0
	jr z,L4043
	ld a,(_lean_wait__29)
	cp a,0
	jr z,L4044
	decb 1,(_lean_wait__29)
	jr L4045
L4044:
	ldb (_lean_wait__29),2
	ld a,(_lean_hold__29)
	cp a,12
	jr ult,L4046
	ldb (_lean_hold__29),11
	jr L4047
L4046:
	ld a,(_lean_hold__29)
	cp a,5
	jr ult,L4048
	ldb (_lean_hold__29),4
	jr L4049
L4048:
	ldb (_lean_hold__29),0
L4049:
L4047:
L4045:
L4043:
L4042:
	ld a,(xsp+24)
	cp a,0
	jr nz,L4050
	ldb (_bump_phase__29),0
	ldb (xsp+2),0
	jr L4051
L4050:
	incb 1,(_bump_phase__29)
	ld c,(_bump_phase__29)
	extz bc
	and bc,2
	cp bc,0
	jr z,L4052
	ld a,(xsp+24)
	extz wa
	jr L4053
L4052:
	ld wa,0
L4053:
	ld (xsp+2),a
L4051:
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
	jr ge,L4054
	ld wa,0
	jr L4055
L4054:
	ld wa,(xsp+6)
L4055:
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
	jp ule,L4056
	call _lean_pose__29
	ld (xsp+0),a
	ldb (xsp+1),0
	ld c,(xsp+0)
	cp c,0
	jr nz,L4057
	ld wa,0
	jr L4058
L4057:
	ld c,(_lean_side__29)
	cp c,0
	jr ge,L4059
	ld wa,2
	jr L4060
L4059:
	ld wa,1
L4060:
L4058:
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
	jp L4038
L4056:
	ld c,(_lean_hold__29)
	cp c,0
	jr nz,L4061
	ld wa,0
	jr L4062
L4061:
	ld wa,1
L4062:
	ld (xsp+0),a
	ld c,(_lean_side__29)
	cp c,0
	jr le,L4063
	ld wa,1
	jr L4064
L4063:
	ld wa,0
L4064:
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
L4038:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function id_car_draw_at
_id_car_draw_at:
	ld wa,(xsp+4)
	ld (_car_at_x__29),wa
	ld a,(_body__29+28)
	cp a,1
	jr ule,L4068
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
L4068:
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
L4067:
	ret

; function id_car_height
_id_car_height:
	ld a,(_body__29+30)
	jr L4070
L4070:
	ret

; function id_car_tile_base
_id_car_tile_base:
	ld wa,(_car_tile_base__29)
	jr L4072
L4072:
	ret

; function id_car_restore
_id_car_restore:
	ld wa,0
	push xwa
	ld wa,(_car_tile_base__29)
	push xwa
	call _id_car_init
	lda xsp,(xsp+8)
L4074:
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
L4076:
	pop xiz
	ret

; function uses_akina
_uses_akina__30:
	ld wa,0
	jr L4078
L4078:
	ret

; function id_road_horizon
_id_road_horizon:
	ld xwa,_course_horizon__30
	ld c,(_road_course__30)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	jr L4080
L4080:
	ret

; function sky_is_tall_course
_sky_is_tall_course__30:
	ld wa,0
	jr L4082
L4082:
	ret

; function road_is_tarmac
_road_is_tarmac__30:
	ld wa,1
	jr L4084
L4084:
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
	jp L4119
L4116:
	push xix
	push xiy
	call _uses_akina__30
	pop xiy
	pop xix
	cp a,0
	jp nz,L4120
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
	jr ule,L4121
	ld wa,(xsp+6)
	ld (xsp+8),wa
L4121:
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
	jr L4122
L4120:
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
L4122:
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
	jr nz,L4123
	ld wa,1600
	ld xbc,_id_ahead__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jr L4124
L4123:
	ld wa,60
	mul xwa,(xsp+6)
	extz xwa
	div xwa,iy
	ld (xsp+8),wa
	ld bc,(xsp+8)
	cp bc,1600
	jr ule,L4125
	ld wa,1600
	jr L4126
L4125:
	ld wa,(xsp+8)
L4126:
	ld xbc,_id_ahead__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4124:
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
	jr ule,L4127
	ld wa,47
	jr L4128
L4127:
	ld wa,(xsp+12)
L4128:
	ld xbc,_id_sl__30+128
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L4118:
	inc 1,izl
L4119:
	ld a,izl
	cp a,(_road_lines__30)
	jp ult,L4116
L4117:
	ld a,(_road_lines__30)
	sub a,1
	ld (_wide_k0__30),a
	jr L4131
L4129:
	decb 1,(_wide_k0__30)
L4131:
	ld a,(_wide_k0__30)
	cp a,0
	jr ule,L4132
	ld xwa,_id_src__30
	ld c,(_wide_k0__30)
	sub c,1
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,48
	jr uge,L4129
L4132:
L4130:
	ld a,(_road_top__30)
	sub a,8
	ld (_climb_room__30),a
	push xix
	push xiy
	call _uses_akina__30
	pop xiy
	pop xix
	cp a,0
	jr z,L4133
	ld a,(_road_lines__30)
	extz wa
	extz xwa
	div xwa,10
	ld (_descent_room__30),a
	jr L4134
L4133:
	ld a,(_road_lines__30)
	extz wa
	srl 1,wa
	ld (_descent_room__30),a
L4134:
	ldb (_grade_hi__30),0
	ldb (_grade_lo__30),0
	ld ix,1
	jr L4138
L4135:
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
	jr ugt,L4139
	ld a,ixl
	ld (_grade_hi__30),a
L4139:
L4137:
	inc 1,ix
L4138:
	ld wa,ix
	cp wa,20
	jr le,L4135
L4136:
	ld ix,1
	jr L4143
L4140:
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
	jr ult,L4144
	ld a,ixl
	neg a
	ld (_grade_lo__30),a
L4144:
L4142:
	inc 1,ix
L4143:
	ld wa,ix
	cp wa,20
	jr le,L4140
L4141:
L4115:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function rally_scan
_rally_scan__30:
	push xiz
	lda xsp,(xsp-6)
	ld a,(_rally_scanned__30)
	cp a,0
	jr z,L4163
	jp L4162
L4163:
	ldw (xsp+0),0
	jr L4167
L4164:
	ld a,255
	ld xbc,_rally_of__30
	ld de,(xsp+0)
	extz xde
	add xbc,xde
	ld (xbc),a
L4166:
	incw 1,(xsp+0)
L4167:
	ld wa,(xsp+0)
	cp wa,512
	jr ult,L4164
L4165:
	ldb (_rally_used__30),0
	ld a,(_art__30+21)
	extz wa
	srl 3,wa
	ld iyl,a
	jp L4171
L4168:
	ld ixl,0
	jr L4175
L4172:
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
	jr uge,L4177
	ld xwa,_rally_of__30
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,255
	jr z,L4176
L4177:
	jr L4174
L4176:
	ld a,(_rally_used__30)
	cp a,255
	jr ult,L4178
	jr L4174
L4178:
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
L4174:
	inc 1,ixl
L4175:
	ld a,ixl
	cp a,(_art__30+20)
	jp ult,L4172
L4173:
L4170:
	inc 1,iyl
L4171:
	ld a,iyl
	cp a,29
	jp ult,L4168
L4169:
	ldb (_rally_scanned__30),1
L4162:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function id_road_char_count
_id_road_char_count:
	call _rally_scan__30
	ld a,(_rally_used__30)
	extz wa
	jr L4180
L4180:
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
	jp L4196
L4193:
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
	jr nz,L4197
	ld xwa,_rally_src__30
	ld bc,ix
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L4198
L4197:
	ld wa,ix
L4198:
	ld (xsp+12),wa
	ld iz,0
	jr L4202
L4199:
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
L4201:
	inc 1,iz
L4202:
	ld wa,iz
	cp wa,8
	jr ult,L4199
L4200:
L4195:
	inc 1,ix
L4196:
	ld wa,ix
	cp wa,(xsp+2)
	jp ult,L4193
L4194:
L4192:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_load_palettes
_id_load_palettes__30:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L4212
L4209:
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
L4211:
	inc 1,izl
L4212:
	ld a,izl
	cp a,8
	jp ult,L4209
L4210:
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
L4208:
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
L4214:
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
	jr L4224
L4221:
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
L4223:
	inc 1,izl
L4224:
	ld a,izl
	cp a,4
	jr ult,L4221
L4222:
	ldw (_bc_rest__30),65535
	ldw (_bc_rest__30+2),65535
L4220:
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
	jp L4246
L4243:
	ld a,iyl
	ld c,(xsp+2)
	sub a,c
	ld (xsp+3),a
	ld a,(xsp+3)
	cp a,28
	jr ule,L4247
	ldb (xsp+3),28
L4247:
	ld izl,0
	jp L4251
L4248:
	ld wa,0
	ld (xsp+4),a
	ld a,(xsp+3)
	ld (xsp+5),a
	ld a,izl
	cp a,0
	jr uge,L4252
	ld a,(_art__30+21)
	extz wa
	srl 3,wa
	ld (xsp+5),a
	jr L4253
L4252:
	ld a,izl
	ld c,0
	add c,(_art__30+20)
	cp a,c
	jr ult,L4254
	ld a,(_art__30+20)
	sub a,1
	ld (xsp+4),a
	ld a,(_art__30+21)
	extz wa
	srl 3,wa
	ld (xsp+5),a
	jr L4255
L4254:
	ld a,izl
	sub a,0
	ld (xsp+4),a
L4255:
L4253:
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
	jr uge,L4256
	ld xwa,_rally_of__30
	ld bc,(xsp+8)
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L4257
L4256:
	ld wa,255
L4257:
	ld ixl,a
	ld a,ixl
	cp a,255
	jr nz,L4258
	ld ixl,0
L4258:
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
L4250:
	inc 1,izl
L4251:
	ld a,izl
	cp a,32
	jp ult,L4248
L4249:
L4245:
	inc 1,iyl
L4246:
	ld a,iyl
	cp a,32
	jp ult,L4243
L4244:
L4242:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function id_load_maps
_id_load_maps__30:
	call _id_load_maps_rally__30
L4260:
	ret

; function id_road_reload_maps
_id_road_reload_maps:
	call _id_load_palettes__30
	call _id_load_maps_rally__30
L4262:
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
	jp nz,L4294
	ld izl,0
	jr L4298
L4295:
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
	jr uge,L4299
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
	jr ge,L4300
	ld wa,(xsp+4)
	ld (xsp+2),wa
L4300:
L4299:
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
L4297:
	inc 1,izl
L4298:
	ld a,izl
	cp a,(_road_lines__30)
	jp ult,L4295
L4296:
	jp L4293
L4294:
	ld izl,0
	jp L4304
L4301:
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
	jr L4308
L4305:
	ld wa,0
	ld (xsp+10),wa
	ld wa,0
	ld (xsp+12),wa
	ld wa,(xsp+12)
	cp wa,0
	jr nz,L4309
	jr L4307
L4309:
	ld ixl,0
	jr L4313
L4310:
	ld wa,(xsp+12)
	ld bc,14
	ld de,2
	ld l,ixl
	extz hl
	mul xde,hl
	sub bc,de
	cp c,0
	jr z,L4316
L4315:
	srl 1,wa
	djnz c,L4315
L4316:
	and wa,3
	cp wa,0
	jr z,L4314
	ld a,(xsp+4)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld iy,wa
	ld wa,iy
	cp wa,(xsp+6)
	jr uge,L4317
	ld wa,iy
	ld (xsp+6),wa
L4317:
	ld wa,iy
	cp wa,(xsp+8)
	jr ule,L4318
	ld wa,iy
	ld (xsp+8),wa
L4318:
L4314:
L4312:
	inc 1,ixl
L4313:
	ld a,ixl
	cp a,8
	jr ult,L4310
L4311:
L4307:
	incb 1,(xsp+4)
L4308:
	ld a,(xsp+4)
	cp a,32
	jr ult,L4305
L4306:
	ld wa,(xsp+6)
	cp wa,(xsp+8)
	jr ule,L4319
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
	jr L4320
L4319:
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
L4320:
	ld xwa,_id_dxc__30+128
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,88
	jr le,L4321
	ld wa,88
	ld xbc,_id_dxc__30+128
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4321:
	ld xwa,_id_dxc__30
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65448
	jr ge,L4322
	ld wa,65448
	ld xbc,_id_dxc__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4322:
L4303:
	inc 1,izl
L4304:
	ld a,izl
	cp a,(_road_lines__30)
	jp ult,L4301
L4302:
L4293:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_road_course
_id_road_course:
	ld a,(_road_course__30)
	jr L4324
L4324:
	ret

; function id_road_top
_id_road_top:
	ld a,(_road_top__30)
	jr L4326
L4326:
	ret

; function id_road_bottom
_id_road_bottom:
	ld a,(_road_bottom__30)
	jr L4328
L4328:
	ret

; function id_road_select
_id_road_select:
	push xiz
	lda xsp,(xsp-14)
	ld c,(xsp+22)
	cp c,1
	jr uge,L4368
	ld a,(xsp+22)
	extz wa
	jr L4369
L4368:
	ld wa,0
L4369:
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
	jr nz,L4370
	push xix
	ld xwa,_art__30
	push xwa
	ld a,(_road_course__30)
	push xwa
	call _course_art__30
	lda xsp,(xsp+8)
	pop xix
	ldb (_rally_scanned__30),0
L4370:
	push xix
	call _uses_akina__30
	pop xix
	cp a,0
	jr nz,L4371
	ldb (_road_base_x__30),48
	ldb (_road_top__30),88
	push xwa
	push xix
	call _sky_is_tall_course__30
	ld xbc,xwa
	pop xix
	pop xwa
	cp c,0
	jr z,L4372
	ld a,88
	extz wa
	jr L4373
L4372:
	ld a,88
	extz wa
L4373:
	ld (_road_plane0__30),a
	ldb (_road_lines__30),64
	jr L4374
L4371:
	ldb (_road_base_x__30),7
	ldb (_road_top__30),72
	ldb (_road_plane0__30),72
	ldb (_road_lines__30),40
L4374:
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
	jr ult,L4375
	ld a,(_road_lines__30)
	sub a,1
	ld (_car_stand__30),a
L4375:
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
	jr nz,L4376
	push xix
	call _id_load_maps_rally__30
	pop xix
	jr L4377
L4376:
	push xix
	call _id_load_maps__30
	pop xix
L4377:
	ldb (xsp+0),0
	jr L4381
L4378:
	ld wa,0
	ld xbc,_id_shear__30
	ld e,(xsp+0)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4380:
	incb 1,(xsp+0)
L4381:
	ld a,(xsp+0)
	cp a,(_road_lines__30)
	jr ult,L4378
L4379:
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
	jr z,L4382
	ld wa,3
	jr L4383
L4382:
	ld wa,0
L4383:
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
	jp L4387
L4384:
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
	jr ule,L4388
	ld wa,(xsp+8)
	sub wa,ix
	jr L4389
L4388:
	ld wa,0
L4389:
	ld (xsp+8),wa
	ld bc,(xsp+10)
	cp bc,ix
	jr ule,L4390
	ld wa,(xsp+10)
	sub wa,ix
	jr L4391
L4390:
	ld wa,0
L4391:
	ld (xsp+10),wa
	ld bc,(xsp+12)
	cp bc,ix
	jr ule,L4392
	ld wa,(xsp+12)
	sub wa,ix
	jr L4393
L4392:
	ld wa,0
L4393:
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
L4386:
	inc 1,izl
L4387:
	ld a,izl
	cp a,4
	jp ult,L4384
L4385:
	push xix
	call _road_is_tarmac__30
	pop xix
	cp a,0
	jr z,L4394
	ld izl,0
	jr L4398
L4395:
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
L4397:
	inc 1,izl
L4398:
	ld a,izl
	cp a,4
	jr ult,L4395
L4396:
	jr L4399
L4394:
	push xix
	call _uses_akina__30
	pop xix
	cp a,0
	jr nz,L4400
	ld izl,0
	jr L4404
L4401:
	ld wa,(xsp+2)
	ld xbc,_band_col__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4403:
	inc 1,izl
L4404:
	ld a,izl
	cp a,4
	jr ult,L4401
L4402:
L4400:
L4399:
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
L4367:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function id_road_dma_pause
_id_road_dma_pause:
	ld a,(_road_dma_depth__30)
	cp a,255
	jr uge,L4409
	incb 1,(_road_dma_depth__30)
L4409:
	ld a,(_road_dma_live__30)
	cp a,0
	jr z,L4410
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
L4410:
L4408:
	ret

; function id_road_dma_resume
_id_road_dma_resume:
	ld a,(_road_dma_depth__30)
	cp a,0
	jr z,L4417
	decb 1,(_road_dma_depth__30)
L4417:
	ld a,(_road_dma_depth__30)
	cp a,0
	jr z,L4418
	jp L4416
L4418:
	ld a,(_road_dma_live__30)
	cp a,0
	jp nz,L4419
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
	jr nz,L4420
	call _road_is_tarmac__30
	cp a,0
	jr nz,L4420
	ldw (_id_bandstream__30+10),0
	ldb (_road_dma_live__30),1
	ld xwa,_id_road_rearm
	push xwa
	call _ngpc_set_vblank_hook
	lda xsp,(xsp+4)
	jr L4416
L4420:
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
L4419:
L4416:
	ret

; function id_road_init
_id_road_init:
	ld wa,0
	push xwa
	call _id_road_select
	lda xsp,(xsp+4)
	call _ngpc_dma_init
	call _id_road_dma_resume
L4422:
	ret

; function id_road_flat
_id_road_flat:
	push xiz
	lda xsp,(xsp-2)
	ld iz,0
	jr L4432
L4429:
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
L4431:
	inc 1,iz
L4432:
	ld wa,iz
	cp wa,152
	jr ult,L4429
L4430:
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
L4428:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_rearm
_id_road_rearm:
	ld xwa,(_id_xy_done__30)
	cp xwa,0
	jr z,L4437
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
L4437:
	ld xwa,_id_raster__30
	push xwa
	call _ngpc_dma_raster_xy_rearm
	lda xsp,(xsp+4)
	ld wa,(_id_bandstream__30+10)
	cp wa,0
	jr z,L4438
	ld xwa,_id_bandstream__30
	push xwa
	call _ngpc_dma_stream_rearm_u16
	lda xsp,(xsp+4)
L4438:
L4436:
	ret

; function id_road_dma_state
_id_road_dma_state:
	ld a,(_id_raster__30+1)
	extz wa
	ld xde,(_id_raster__30+2)
	cp xde,0
	jr z,L4443
	ld bc,2
	jr L4444
L4443:
	ld bc,0
L4444:
	or wa,bc
	jr L4442
L4442:
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
	jr L4446
L4446:
	ret

; function id_road_restore_map
_id_road_restore_map:
	call _uses_akina__30
	cp a,0
	jr nz,L4451
	call _id_load_maps_rally__30
	jr L4452
L4451:
	call _id_load_maps__30
L4452:
L4450:
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
	jr nz,L4457
	call _id_load_maps_rally__30
	jr L4458
L4457:
	call _id_load_maps__30
L4458:
L4456:
	ret

; function wide_rows
_wide_rows__30:
	push xiz
	lda xsp,(xsp-12)
	ld a,(_road_bottom__30)
	ld ixl,a
L4478:
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
	jr ult,L4483
	ld a,(xsp+6)
	cp a,88
	jr ult,L4482
L4483:
	jp L4479
L4482:
	ld a,(xsp+5)
	sub a,(xsp+24)
	ld izl,a
	ld wa,(xsp+36)
	cp wa,0
	jr lt,L4484
	ld c,izl
	cp c,144
	jr ult,L4485
	ld a,izl
	extz wa
	sub wa,256
	jr L4486
L4485:
	ld a,izl
	extz wa
L4486:
	ld iy,wa
	jr L4487
L4484:
	ld c,izl
	cp c,112
	jr ule,L4488
	ld a,izl
	extz wa
	sub wa,256
	jr L4489
L4488:
	ld a,izl
	extz wa
L4489:
	ld iy,wa
L4487:
	ld xwa,_id_route_lim0
	ld c,(xsp+6)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+10),a
	ld wa,iy
	cp wa,0
	jr lt,L4490
	ld wa,iy
	ld c,(xsp+10)
	extz bc
	cp wa,bc
	jr ult,L4491
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
L4491:
	jr L4492
L4490:
	ld wa,iy
	neg wa
	ld c,(xsp+10)
	extz bc
	cp wa,bc
	jr ult,L4493
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
L4493:
L4492:
	ld a,ixl
	extz wa
	ld bc,(xsp+32)
	add bc,1
	cp wa,bc
	jr gt,L4494
	jr L4479
L4494:
	dec 1,ixl
L4480:
L4481:
	jp L4478
L4479:
L4477:
	lda xsp,(xsp+12)
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
	jr z,L4595
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
L4595:
	ld a,(_road_lines__30)
	cp a,0
	jp z,L4596
	ld wa,(xsp+22)
	cp wa,2
	jp lt,L4596
	ld wa,(xsp+22)
	cp wa,255
	jp gt,L4596
	ld a,(_road_lines__30)
	extz wa
	sub wa,1
	ld (xsp+24),wa
	ld wa,iz
	cp wa,(xsp+22)
	jp lt,L4597
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
L4597:
	jp L4598
L4596:
	ld a,(_road_lines__30)
	extz wa
	sub wa,1
	ld (xsp+24),wa
	jp L4602
L4599:
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
	jr ge,L4603
	ld wa,(xsp+22)
	jr L4604
L4603:
	ld wa,iz
L4604:
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
	jr ult,L4605
	ld wa,iz
	cp wa,(xsp+22)
	jr lt,L4605
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
L4605:
	ld a,(xsp+43)
	cp a,2
	jr nz,L4606
	ld wa,iz
	cp wa,(xsp+22)
	jr lt,L4606
	ld a,izl
	ld (xsp+48),a
	ld wa,(xsp+18)
	srl 1,wa
	ld (xsp+50),wa
	ld bc,(xsp+16)
	cp bc,(xsp+50)
	jr ule,L4607
	ld wa,(xsp+16)
	sub wa,(xsp+50)
	jr L4608
L4607:
	ld wa,(xsp+16)
L4608:
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
L4606:
	ld wa,(xsp+16)
	ld bc,(xsp+18)
	sub wa,bc
	ld (xsp+16),wa
	ld wa,iz
	cp wa,(xsp+22)
	jr ge,L4609
	jr L4600
L4609:
L4601:
	decw 1,(xsp+24)
L4602:
	ld wa,(xsp+24)
	cp wa,0
	jp ge,L4599
L4600:
L4598:
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
	jr ge,L4610
	ld wa,(xsp+42)
	neg wa
	ld (xsp+42),wa
L4610:
	ld wa,(xsp+44)
	cp wa,0
	jr ge,L4611
	ld wa,(xsp+44)
	neg wa
	ld (xsp+44),wa
L4611:
	ld wa,(xsp+42)
	cp wa,46
	jr ge,L4613
	ld wa,(xsp+44)
	cp wa,46
	jr lt,L4612
L4613:
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
L4612:
	ld bc,(xsp+24)
	cp bc,0
	jr ge,L4614
	ld wa,1
	jr L4615
L4614:
	ld wa,0
L4615:
	ld (xsp+26),a
	jr L4618
L4616:
	ld a,(xsp+22)
	ld xbc,_id_sl__30
	ld de,(xsp+24)
	exts xde
	add xbc,xde
	ld (xbc),a
	decw 1,(xsp+24)
L4618:
	ld wa,(xsp+24)
	cp wa,0
	jr ge,L4616
L4617:
	ld a,izl
	add a,1
	ld (_band_first__30),a
	ld a,(_band_first__30)
	cp a,(_band_held__30)
	jp ule,L4619
	ld a,(_band_first__30)
	sub a,(_band_held__30)
	cp a,2
	jr uge,L4621
	ld a,(_band_wait__30)
	cp a,16
	jr ult,L4620
L4621:
	ldb (_band_wait__30),0
	jr L4622
L4620:
	incb 1,(_band_wait__30)
	jr L4625
L4623:
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
L4625:
	ld a,(_band_first__30)
	cp a,(_band_held__30)
	jr ugt,L4623
L4624:
L4622:
	jr L4626
L4619:
	ldb (_band_wait__30),0
L4626:
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
	jp z,L4627
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
	jr ule,L4628
	ld a,(_road_bottom__30)
	extz wa
	ld (xsp+44),wa
L4628:
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
	jr L4631
L4629:
	ld c,(xsp+58)
	incb 1,(xsp+58)
	extz bc
	and bc,2
	cp bc,0
	jr z,L4632
	ld wa,(xsp+46)
	jr L4633
L4632:
	ld wa,(xsp+56)
L4633:
	ld xbc,(xsp+48)
	inc 2,xbc
	ld (xsp+48),xbc
	dec 2,xbc
	ld (xbc),wa
L4631:
	ld xwa,(xsp+48)
	cp xwa,(xsp+52)
	jr ult,L4629
L4630:
	jr L4634
L4627:
	ld wa,(xsp+42)
	cp wa,24
	jr le,L4635
	ldw (xsp+42),24
L4635:
	ld a,(_band_first__30)
	extz wa
	ld de,(xsp+42)
	cp de,0
	jr le,L4636
	ld bc,(xsp+42)
	jr L4637
L4636:
	ld bc,0
L4637:
	add wa,bc
	ld (xsp+44),wa
	ld wa,(xsp+44)
	ld c,(_road_bottom__30)
	extz bc
	cp wa,bc
	jr ule,L4638
	ld a,(_road_bottom__30)
	extz wa
	ld (xsp+44),wa
L4638:
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
	jr L4641
L4639:
	ld wa,(xsp+46)
	ld xbc,(xsp+48)
	inc 2,xbc
	ld (xsp+48),xbc
	dec 2,xbc
	ld (xbc),wa
L4641:
	ld xwa,(xsp+48)
	cp xwa,(xsp+52)
	jr ult,L4639
L4640:
L4634:
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
	jr z,L4642
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
	jr L4645
L4643:
	ld wa,(xsp+12)
	ld xbc,(xsp+16)
	inc 2,xbc
	ld (xsp+16),xbc
	dec 2,xbc
	ld (xbc),wa
L4645:
	ld xwa,(xsp+16)
	cp xwa,(xsp+20)
	jr ult,L4643
L4644:
L4642:
	ld xwa,_bc_top__30
	ld c,(xsp+14)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_band_first__30)
	jr uge,L4646
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
	jr L4649
L4647:
	ld wa,(xsp+12)
	ld xbc,(xsp+16)
	inc 2,xbc
	ld (xsp+16),xbc
	dec 2,xbc
	ld (xbc),wa
L4649:
	ld xwa,(xsp+16)
	cp xwa,(xsp+20)
	jr ult,L4647
L4648:
L4646:
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
	jr le,L4650
	ld wa,(_band_shift__30)
	jr L4651
L4650:
	ld wa,0
L4651:
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
	jp nz,L4652
	ld a,(_road_base_x__30)
	extz wa
	ld e,(_pan_fine__30)
	cp e,0
	jr z,L4653
	ld bc,(_pan_head__30)
	exts xbc
	divs xbc,2
	neg bc
	exts xbc
	divs xbc,16
	jr L4654
L4653:
	ld bc,(xsp+94)
	sra 1,bc
	neg bc
	ld de,(xsp+90)
	sra 4,de
	add bc,de
L4654:
	add wa,bc
	extz wa
	ld (xsp+12),wa
	ld a,(_road_base_x__30)
	extz wa
	ld e,(_pan_fine__30)
	cp e,0
	jr z,L4655
	ld bc,(_pan_head__30)
	sll 1,bc
	neg bc
	exts xbc
	divs xbc,16
	jr L4656
L4655:
	ld bc,(xsp+94)
	sll 1,bc
	neg bc
	ld de,(xsp+90)
	sra 2,de
	add bc,de
L4656:
	add wa,bc
	extz wa
	ld (xsp+14),wa
	ld c,(_band_first__30)
	cp c,244
	jr uge,L4657
	ld a,(_band_first__30)
	extz wa
	add wa,0
	jr L4658
L4657:
	ld a,(_band_first__30)
	extz wa
L4658:
	ld (xsp+16),a
	ld c,(xsp+16)
	cp c,0
	jr ule,L4659
	ld a,(xsp+16)
	extz wa
	jr L4660
L4659:
	ld a,0
	extz wa
L4660:
	ld (xsp+17),a
	ld c,(_band_first__30)
	cp c,(xsp+17)
	jr uge,L4661
	ld a,(_band_first__30)
	extz wa
	jr L4662
L4661:
	ld a,(xsp+17)
	extz wa
L4662:
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
	jr nz,L4664
	ld wa,(xsp+14)
	ld xbc,_band_mid__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L4664
	ld a,(xsp+17)
	ld xbc,_band_bg_end__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr nz,L4664
	ld wa,(xsp+10)
	ld xbc,_band_pitch__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	exts bc
	cp wa,bc
	jr nz,L4664
	ld a,(_band_first__30)
	ld xbc,_band_bg_first__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr z,L4663
L4664:
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
L4663:
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
	jr z,L4665
	jr L4668
L4666:
	ld wa,(xsp+14)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L4668:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr ult,L4666
L4667:
	jp L4669
L4665:
	ld a,(xsp+10)
	neg a
	extz wa
	sll 8,wa
	ld (xsp+36),wa
	ld wa,(xsp+20)
	ld iy,wa
	jr L4672
L4670:
	ld bc,iy
	cp bc,0
	jr uge,L4673
	ld wa,(xsp+12)
	jr L4674
L4673:
	ld wa,(xsp+14)
L4674:
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
L4672:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr uge,L4675
	ld wa,iy
	cp wa,(xsp+10)
	jr lt,L4670
L4675:
L4671:
	ld xwa,(_id_xy__30)
	ld bc,0
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+32),xwa
	ld xwa,(xsp+32)
	cp xwa,(xsp+28)
	jr ule,L4676
	ld xwa,(xsp+28)
	ld (xsp+32),xwa
L4676:
	jr L4679
L4677:
	ld wa,(xsp+12)
	or wa,(xsp+36)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L4679:
	ld xwa,xix
	cp xwa,(xsp+32)
	jr ult,L4677
L4678:
	jr L4682
L4680:
	ld wa,(xsp+14)
	or wa,(xsp+36)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L4682:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr ult,L4680
L4681:
L4669:
	ld a,(xsp+10)
	ld xbc,_band_pitch__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+14)
	ld (xsp+8),wa
	jp L4683
L4652:
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
	jr nz,L4685
	ld wa,(xsp+10)
	ld xbc,_band_pitch__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	exts bc
	cp wa,bc
	jr nz,L4685
	ld a,(_band_first__30)
	ld xbc,_band_bg_end__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp z,L4684
L4685:
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
	jr L4689
L4686:
	push xwa
	push xix
	push xiy
	call _sky_is_tall_course__30
	ld xbc,xwa
	pop xiy
	pop xix
	pop xwa
	cp c,0
	jr z,L4690
	ld wa,0
	jr L4691
L4690:
	ld wa,(xsp+10)
	neg wa
L4691:
	ld (xsp+18),wa
	ld wa,iy
	add wa,(xsp+18)
	cp wa,0
	jr ge,L4692
	ld wa,iy
	neg wa
	ld (xsp+18),wa
L4692:
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
L4688:
	inc 1,iy
L4689:
	ld wa,iy
	ld c,(_band_first__30)
	extz bc
	cp wa,bc
	jr ult,L4686
L4687:
L4684:
	ld wa,(xsp+16)
	ld (xsp+8),wa
L4683:
L4594:
	lda xsp,(xsp+82)
	pop xiz
	ret

; function id_road_ready
_id_road_ready:
	ld xwa,(_id_xy__30)
	ld (_id_xy_done__30),xwa
	ld xwa,(_id_bandcol__30)
	ld (_id_bandcol_done__30),xwa
L4694:
	ret

; function id_road_pan
_id_road_pan:
	ld wa,(xsp+4)
	ld (_pan_head__30),wa
	ld wa,(xsp+8)
	ld (_pan_lat__30),wa
	ldb (_pan_fine__30),1
L4696:
	ret

; function id_road_begin
_id_road_begin:
	ld xwa,(_id_xy_live__30)
	cp xwa,_id_xy_a__30
	jr nz,L4703
	ld xwa,_id_xy_b__30
	ld (_id_xy__30),xwa
	ld xwa,_id_bandcol_b__30
	ld (_id_bandcol__30),xwa
	jr L4704
L4703:
	ld xwa,_id_xy_a__30
	ld (_id_xy__30),xwa
	ld xwa,_id_bandcol_a__30
	ld (_id_bandcol__30),xwa
L4704:
	ld xbc,(_id_xy__30)
	cp xbc,_id_xy_a__30
	jr nz,L4705
	ld wa,0
	jr L4706
L4705:
	ld wa,1
L4706:
	ld (_id_buf__30),a
L4702:
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
	jr L4716
L4713:
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
L4715:
	inc 1,izl
L4716:
	ld a,izl
	cp a,(_road_lines__30)
	jr ult,L4713
L4714:
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
L4712:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_ahead
_id_road_ahead:
	ld xwa,_id_ahead__30
	jr L4718
L4718:
	ret

; function id_road_lines
_id_road_lines:
	ld a,(_road_lines__30)
	jr L4720
L4720:
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
	jr z,L4724
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
L4724:
	ld wa,(xsp+34)
	push xwa
	ld wa,(xsp+30)
	push xwa
	call _id_road_write__30
	lda xsp,(xsp+8)
	call _id_road_ready
L4723:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_fill_hud_band
_id_fill_hud_band__30:
	push xiz
	lda xsp,(xsp-2)
	ld iz,152
	jr L4734
L4731:
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
L4733:
	inc 1,iz
L4734:
	ld wa,iz
	cp wa,152
	jr ult,L4731
L4732:
L4730:
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
	jr uge,L4740
	ld a,(_road_top__30)
	ld izl,a
	jr L4741
L4740:
	ld a,izl
	cp a,(_road_bottom__30)
	jr ule,L4742
	ld a,(_road_bottom__30)
	ld izl,a
L4742:
L4741:
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
L4739:
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
	jr uge,L4748
	ld a,(_road_top__30)
	ld izl,a
	jr L4749
L4748:
	ld a,izl
	cp a,(_road_bottom__30)
	jr ule,L4750
	ld a,(_road_bottom__30)
	ld izl,a
L4750:
L4749:
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
	jr L4747
L4747:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_band_phase
_id_road_band_phase:
	ld wa,(xsp+4)
	ld (_band_phase__30),wa
L4752:
	ret

; function id_road_join
_id_road_join:
	ld c,(xsp+4)
	cp c,1
	jr uge,L4757
	ld a,(xsp+4)
	extz wa
	jr L4758
L4757:
	ld wa,0
L4758:
	ld (_road_course__30),a
	call _id_load_palettes__30
	ld wa,0
	push xwa
	call _id_road_join_white
	lda xsp,(xsp+4)
L4756:
	ret

; function id_road_join_white
_id_road_join_white:
	push xiz
	lda xsp,(xsp-10)
	ld izl,0
	jp L4768
L4765:
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
L4767:
	inc 1,izl
L4768:
	ld a,izl
	cp a,4
	jp ult,L4765
L4766:
	ld wa,65535
	ld (_band_top__30+2),wa
	ld (_band_top__30),wa
	ld wa,65535
	ld (_band_mid__30+2),wa
	ld (_band_mid__30),wa
	ld wa,65535
	ld (_band_tree__30+2),wa
	ld (_band_tree__30),wa
L4764:
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
	jr nz,L4778
	ld ixl,0
L4778:
	jr L4781
L4779:
	ld xwa,(xsp+0)
	inc 1,xwa
	ld (xsp+0),xwa
	dec 1,xwa
	ld a,(xwa)
	ld izl,a
	ld a,izl
	cp a,(xsp+8)
	jr le,L4782
	ld a,(xsp+8)
	ld izl,a
	jr L4783
L4782:
	ld a,izl
	cp a,(xsp+9)
	jr ge,L4784
	ld a,(xsp+9)
	ld izl,a
L4784:
L4783:
	ld a,izl
	ld xbc,xiy
	inc 1,xbc
	ld xiy,xbc
	dec 1,xbc
	ld (xbc),a
	dec 1,ixl
L4781:
	ld a,ixl
	cp a,0
	jr nz,L4779
L4780:
	ld xwa,_id_sl__30+64
	ld c,(_road_lines__30)
	extz bc
	sub bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_road_grade__30),a
L4777:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function id_road_grade_buf
_id_road_grade_buf:
	ld xwa,_id_sl__30+64
	jr L4786
L4786:
	ret

; function id_road_band_first
_id_road_band_first:
	ld a,(_band_first__30)
	jr L4788
L4788:
	ret

; function id_road_visible_top
_id_road_visible_top:
	push xiz
	lda xsp,(xsp-2)
	ld c,(_band_first__30)
	cp c,244
	jr uge,L4796
	ld a,(_band_first__30)
	add a,0
	extz wa
	jr L4797
L4796:
	ld a,(_band_first__30)
	extz wa
L4797:
	ld izl,a
	ld a,izl
	cp a,0
	jr uge,L4798
	ld izl,0
L4798:
	ld c,izl
	cp c,(_road_bottom__30)
	jr ule,L4799
	ld a,(_road_bottom__30)
	extz wa
	jr L4800
L4799:
	ld a,izl
	extz wa
L4800:
	jr L4795
L4795:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_grade_hi
_id_road_grade_hi:
	ld a,(_grade_hi__30)
	jr L4802
L4802:
	ret

; function id_road_grade_lo
_id_road_grade_lo:
	ld a,(_grade_lo__30)
	jr L4804
L4804:
	ret

; function id_road_set_hill
_id_road_set_hill:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld ixl,a
	ld a,ixl
	cp a,(_grade_hi__30)
	jr le,L4814
	ld a,(_grade_hi__30)
	ld ixl,a
	jr L4815
L4814:
	ld a,ixl
	cp a,(_grade_lo__30)
	jr ge,L4816
	ld a,(_grade_lo__30)
	ld ixl,a
L4816:
L4815:
	ld a,ixl
	ld (_road_grade__30),a
	ld izl,0
	jr L4820
L4817:
	ld a,ixl
	ld xbc,_id_sl__30+64
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L4819:
	inc 1,izl
L4820:
	ld a,izl
	cp a,(_road_lines__30)
	jr ult,L4817
L4818:
L4813:
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
	jr ult,L4827
	ld a,ixl
	cp a,(_road_bottom__30)
	jr ule,L4826
L4827:
	ld wa,0
	jr L4825
L4826:
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
	jr lt,L4828
	ld a,(_road_lines__30)
	extz wa
	sub wa,1
	ld iz,wa
L4828:
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
	jr L4825
L4825:
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
	jr le,L4834
	ld iz,8
	jr L4835
L4834:
	ld wa,iz
	cp wa,65531
	jr ge,L4836
	ld iz,65531
L4836:
L4835:
	ld a,izl
	jr L4833
L4833:
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
	jr uge,L4842
	ld a,(_road_top__30)
	ld izl,a
	jr L4843
L4842:
	ld a,izl
	cp a,(_road_bottom__30)
	jr ule,L4844
	ld a,(_road_bottom__30)
	ld izl,a
L4844:
L4843:
	ld xwa,_id_half__30
	ld c,izl
	sub c,(_road_top__30)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	jr L4841
L4841:
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
	jr ule,L4853
	ld wa,255
	jr L4852
L4853:
	jr L4856
L4854:
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
	jr ult,L4857
	ld a,ixl
	ld izl,a
	jr L4858
L4857:
	ld a,ixl
	sub a,1
	ld iyl,a
L4858:
L4856:
	ld a,izl
	cp a,iyl
	jr ult,L4854
L4855:
	ld a,(_road_top__30)
	add a,izl
	jr L4852
L4852:
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
	jr uge,L4864
	ld a,(_road_top__30)
	ld izl,a
	jr L4865
L4864:
	ld a,izl
	cp a,(_road_bottom__30)
	jr ule,L4866
	ld a,(_road_bottom__30)
	ld izl,a
L4866:
L4865:
	ld xwa,_id_ahead__30
	ld c,izl
	sub c,(_road_top__30)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L4863
L4863:
	pop xiz
	ret

; function id_scenery_char_count
_id_scenery_char_count:
	ld wa,0
	jr L4868
L4868:
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
L4870:
	ret

; function scenery_mode
_scenery_mode:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld c,izl
	cp c,5
	jr nz,L4881
	ld wa,1
	jr L4882
L4881:
	ld wa,0
L4882:
	ld e,(_scn_mode__31)
	cp e,5
	jr nz,L4883
	ld bc,1
	jr L4884
L4883:
	ld bc,0
L4884:
	cp wa,bc
	jr z,L4880
	ld c,izl
	cp c,5
	jr nz,L4885
	ld wa,1
	jr L4886
L4885:
	ld wa,0
L4886:
	push xwa
	call _theme_crowd_colours
	lda xsp,(xsp+4)
L4880:
	ld a,izl
	ld (_scn_mode__31),a
L4879:
	pop xiz
	ret

; function id_scenery_passed
_id_scenery_passed:
	ld a,(_scn_passed__31)
	jr L4888
L4888:
	ret

; function kind_of
_kind_of__31:
	ld a,(_scn_mode__31)
	cp a,5
	jr nz,L4897
	ld wa,14
	jr L4896
L4897:
	ld a,(_scn_mode__31)
	cp a,1
	jr nz,L4898
	ld wa,12
	jr L4896
L4898:
	ld a,(_scn_mode__31)
	cp a,3
	jr ult,L4899
	ld wa,11
	jr L4896
L4899:
	ld a,(_scn_mode__31)
	cp a,2
	jr nz,L4900
	ld wa,13
	jr L4896
L4900:
	ld c,(xsp+4)
	cp c,0
	jr z,L4901
	call _theme_obj_kind_right
	extz wa
	jr L4902
L4901:
	call _theme_obj_kind_left
	extz wa
L4902:
	jr L4896
L4896:
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
	jp L4919
L4916:
	ld a,(_scn_passed__31)
	extz wa
	ld bc,1
	ld e,izl
	cp e,0
	jr z,L4922
L4921:
	sll 1,bc
	djnz e,L4921
L4922:
	extz bc
	and wa,bc
	cp wa,0
	jr nz,L4920
	jp L4918
L4920:
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
	jr nz,L4923
	ld wa,iy
	neg wa
	add wa,12
	cp wa,(xsp+12)
	jr lt,L4924
	ld wa,iy
	neg wa
	sub wa,12
	cp wa,(xsp+14)
	jr gt,L4924
	ld wa,1
	jr L4915
L4924:
	jr L4925
L4923:
	ld wa,iy
	add wa,12
	cp wa,(xsp+12)
	jr lt,L4926
	ld wa,iy
	sub wa,12
	cp wa,(xsp+14)
	jr gt,L4926
	ld wa,1
	jr L4915
L4926:
L4925:
L4918:
	inc 1,izl
L4919:
	ld a,izl
	cp a,2
	jp ult,L4916
L4917:
	ld wa,0
	jr L4915
L4915:
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
	jr L4928
L4928:
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
	jr L4941
L4938:
	ld a,izl
	extz wa
	mul xwa,43
	ld ixl,a
	ld a,(_scn_phase__31)
	add a,ixl
	ld c,iyl
	add c,ixl
	cp a,c
	jr uge,L4942
	ld a,(_scn_passed__31)
	extz wa
	ld e,izl
	extz de
	and de,1
	cp de,0
	jr z,L4943
	ld bc,2
	jr L4944
L4943:
	ld bc,1
L4944:
	extz bc
	or wa,bc
	ld (_scn_passed__31),a
L4942:
L4940:
	inc 1,izl
L4941:
	ld a,izl
	cp a,6
	jr ult,L4938
L4939:
L4937:
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
L4946:
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
	jr z,L4999
	ld wa,58
	jr L5000
L4999:
	ld wa,64
L5000:
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
	jr L5004
L5001:
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
	jr ule,L5005
	ld a,(xsp+0)
	ld (xsp+1),a
L5005:
L5003:
	incb 1,(xsp+0)
L5004:
	ld a,(xsp+0)
	cp a,6
	jr ult,L5001
L5002:
	ldb (xsp+0),0
	jp L5009
L5006:
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
	jr ule,L5010
	ld wa,(xsp+10)
	ld iz,wa
L5010:
	ld a,(xsp+4)
	add a,izl
	ld (xsp+18),a
	ld wa,iz
	cp wa,6
	jr uge,L5011
	ldb (xsp+17),4
	jr L5012
L5011:
	ld wa,iz
	cp wa,10
	jr uge,L5013
	ldb (xsp+17),3
	jr L5014
L5013:
	ld wa,iz
	cp wa,15
	jr uge,L5015
	ldb (xsp+17),2
	jr L5016
L5015:
	ld wa,iz
	cp wa,22
	jr uge,L5017
	ldb (xsp+17),1
	jr L5018
L5017:
	ldb (xsp+17),0
L5018:
L5016:
L5014:
L5012:
	ld c,(xsp+12)
	extz bc
	and bc,1
	cp bc,0
	jr z,L5019
	ld wa,1
	jr L5020
L5019:
	ld wa,0
L5020:
	ld (xsp+14),a
	ld a,(_scn_mode__31)
	cp a,5
	jr nz,L5021
	ldb (xsp+15),14
	ld xwa,_crowd_pal__31_L5022
	ld c,(xsp+12)
	extz bc
	extz xbc
	div xbc,3
	ld bc,qbc
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+16),a
	jr L5023
L5021:
	ld a,(_scn_mode__31)
	cp a,1
	jr nz,L5024
	ldb (xsp+15),12
	ldb (xsp+16),4
	jr L5025
L5024:
	ld a,(_scn_mode__31)
	cp a,3
	jr ult,L5026
	ldb (xsp+15),11
	ldb (xsp+16),9
	jr L5027
L5026:
	ld a,(_scn_mode__31)
	cp a,2
	jr nz,L5028
	ldb (xsp+15),13
	ldb (xsp+16),10
	jr L5029
L5028:
	ld a,(xsp+14)
	cp a,0
	jr z,L5030
	call _theme_obj_kind_right
	ld (xsp+15),a
	ldb (xsp+16),2
	jr L5031
L5030:
	call _theme_obj_kind_left
	ld (xsp+15),a
	ldb (xsp+16),1
L5031:
L5029:
L5027:
L5025:
L5023:
	ld c,(xsp+14)
	cp c,0
	jr z,L5032
	ld c,(xsp+15)
	cp c,11
	jr ult,L5032
	ld wa,1
	jr L5033
L5032:
	ld wa,0
L5033:
	ld (xsp+20),a
	ld a,(_scn_mode__31)
	cp a,5
	jr nz,L5034
	ld a,(_g_vb_counter)
	extz wa
	sra 3,wa
	ld c,(xsp+12)
	extz bc
	add wa,bc
	and wa,1
	ld (xsp+20),a
	jr L5035
L5034:
	ld a,(_scn_mode__31)
	cp a,3
	jr nz,L5036
	ldb (xsp+20),0
	jr L5037
L5036:
	ld a,(_scn_mode__31)
	cp a,4
	jr nz,L5038
	ldb (xsp+20),1
L5038:
L5037:
L5035:
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
	jr ge,L5039
	jp L5008
L5039:
	ld wa,(xsp+38)
	cp wa,(xsp+6)
	jr le,L5040
	ld wa,(xsp+6)
	ld (xsp+38),wa
L5040:
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
	jr z,L5041
	ld wa,(xsp+40)
	add wa,(xsp+42)
	ld (xsp+26),wa
	jr L5042
L5041:
	ld wa,(xsp+40)
	sub wa,(xsp+42)
	ld xbc,(xsp+34)
	ld c,(xbc+6)
	extz bc
	sub wa,bc
	add wa,1
	ld (xsp+26),wa
L5042:
	ld wa,(xsp+26)
	cp wa,65504
	jr lt,L5044
	ld wa,(xsp+26)
	cp wa,168
	jr le,L5043
L5044:
	jp L5008
L5043:
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
	jr z,L5045
	ld wa,128
	jr L5046
L5045:
	ld wa,0
L5046:
	ld e,(_bridge_line)
	cp e,0
	jr z,L5047
	ld e,(xsp+19)
	cp e,(_bridge_line)
	jr uge,L5047
	ld bc,16
	jr L5048
L5047:
	ld c,(_id_spr_priority)
	extz bc
L5048:
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
L5008:
	incb 1,(xsp+0)
L5009:
	ld a,(xsp+0)
	cp a,6
	jp ult,L5006
L5007:
	ld a,(xsp+3)
	push xwa
	ld a,(xsp+6)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L4998:
	lda xsp,(xsp+60)
	pop xiz
	ret

; function theme_init_tiles
_theme_init_tiles:
	ld wa,(xsp+4)
	ld (_pano_base__32),wa
	ld wa,(xsp+8)
	ld (_obj_base__32),wa
	ld wa,(xsp+12)
	ld (_obj_end__32),wa
L5050:
	ret

; function theme_obj_map
_theme_obj_map:
	ld xwa,_objmap__32
	jr L5052
L5052:
	ret

; function theme_obj_tile
_theme_obj_tile:
	ld xwa,_objmap__32
	ld c,(xsp+4)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L5054
L5054:
	ret

; function theme_obj_kind_left
_theme_obj_kind_left:
	ld a,(_kind_l__32)
	jr L5056
L5056:
	ret

; function theme_obj_kind_right
_theme_obj_kind_right:
	ld a,(_kind_r__32)
	jr L5058
L5058:
	ret

; function load_tile
_load_tile__32:
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
	jr L5068
L5065:
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
L5067:
	inc 1,izl
L5068:
	ld a,izl
	cp a,8
	jr ult,L5065
L5066:
L5064:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function alloc_slot
_alloc_slot__32:
	push xiz
	lda xsp,(xsp-4)
	ld wa,(_next_slot__32)
	ld iz,wa
	ld wa,(_pano_base__32)
	add wa,111
	ld (xsp+2),wa
	ld wa,iz
	cp wa,32
	jr ult,L5076
	ld wa,iz
	cp wa,101
	jr uge,L5076
	ld iz,101
	jr L5077
L5076:
	ld wa,iz
	cp wa,125
	jr ult,L5078
	ld wa,iz
	cp wa,(_pano_base__32)
	jr uge,L5078
	ld wa,(_obj_base__32)
	ld iz,wa
L5078:
L5077:
	ld wa,iz
	cp wa,(_obj_end__32)
	jr ult,L5079
	ld wa,(_pano_end__32)
	ld iz,wa
L5079:
	ld wa,iz
	cp wa,(xsp+2)
	jr ult,L5080
	ld wa,iz
	cp wa,(_obj_base__32)
	jr uge,L5080
	ld wa,0
	jr L5075
L5080:
	ld wa,iz
	add wa,1
	ld (_next_slot__32),wa
	ld wa,iz
	jr L5075
L5075:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function load_kind
_load_kind__32:
	push xiz
	lda xsp,(xsp-10)
	ldb (xsp+0),0
	jp L5096
L5093:
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
	jp L5100
L5097:
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
	ld xwa,_objmap__32
	ld c,(xsp+7)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65535
	jr nz,L5101
	call _alloc_slot__32
	ld (xsp+8),wa
	ld wa,(xsp+8)
	ld xbc,_objmap__32
	ld e,(xsp+7)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+8)
	cp wa,0
	jr z,L5102
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
	call _load_tile__32
	lda xsp,(xsp+8)
L5102:
L5101:
L5099:
	inc 1,izl
L5100:
	ld a,izl
	ld xbc,(xsp+2)
	ld c,(xbc+2)
	cp a,c
	jp ult,L5097
L5098:
L5095:
	incb 1,(xsp+0)
L5096:
	ld a,(xsp+0)
	cp a,5
	jp ult,L5093
L5094:
L5092:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function set_spr_pal
_set_spr_pal__32:
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
	jr L5112
L5109:
	ld xwa,xix
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_cur_spr__32
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
L5111:
	inc 1,izl
L5112:
	ld a,izl
	cp a,4
	jr ult,L5109
L5110:
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
L5108:
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
	jr L5151
L5148:
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
	ld wa,(_pano_base__32)
	add wa,iz
	push xwa
	call _load_tile__32
	lda xsp,(xsp+8)
	pop xiy
	pop xix
L5150:
	inc 1,iz
L5151:
	ld wa,iz
	cp wa,(xiy+4)
	jr ult,L5148
L5149:
	ld iz,0
	jr L5155
L5152:
	ld xwa,(xiy+14)
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_cur_pals__32
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5154:
	inc 1,iz
L5155:
	ld wa,iz
	cp wa,52
	jr ult,L5152
L5153:
	ldb (xsp+11),0
	jr L5159
L5156:
	ld ixl,0
	jr L5163
L5160:
	ld a,(xsp+11)
	extz wa
	sll 5,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld (xsp+12),wa
	ld wa,(_pano_base__32)
	ld xbc,(xiy+6)
	ld de,(xsp+12)
	extz xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	ld xbc,_pano_slot__32
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
L5162:
	inc 1,ixl
L5163:
	ld a,ixl
	cp a,32
	jr ult,L5160
L5161:
L5158:
	incb 1,(xsp+11)
L5159:
	ld a,(xsp+11)
	cp a,11
	jr ult,L5156
L5157:
	ld wa,(_pano_base__32)
	add wa,(xiy+4)
	ld (_pano_end__32),wa
	ld wa,(xiy+18)
	ld (_cur_backdrop__32),wa
	ld wa,(xiy+18)
	ld (_cur_road__32),wa
	ld xwa,(xsp+0)
	ld wa,(xwa+4)
	ld (_cur_road__32+2),wa
	ld xwa,(xsp+0)
	lda xwa,(xwa+8)
	ld wa,(xwa)
	ld (_cur_road__32+4),wa
	ld xwa,(xsp+0)
	ld wa,(xwa+6)
	ld (_cur_road__32+6),wa
	ld iz,0
	jr L5167
L5164:
	ld xwa,(xsp+0)
	lda xwa,(xwa+8)
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_cur_band__32
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5166:
	inc 1,iz
L5167:
	ld wa,iz
	cp wa,4
	jr ult,L5164
L5165:
	ld iz,0
	jr L5171
L5168:
	ld wa,65535
	ld xbc,_objmap__32
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5170:
	inc 1,iz
L5171:
	ld wa,iz
	cp wa,256
	jr ult,L5168
L5169:
	ldw (_next_slot__32),2
	ld xwa,(xsp+0)
	ld a,(xwa+1)
	ld (_kind_l__32),a
	ld xwa,(xsp+0)
	ld a,(xwa+2)
	ld (_kind_r__32),a
	push xix
	push xiy
	ld a,(_kind_l__32)
	push xwa
	call _load_kind__32
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld a,(_kind_r__32)
	cp a,(_kind_l__32)
	jr z,L5172
	push xix
	push xiy
	ld a,(_kind_r__32)
	push xwa
	call _load_kind__32
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L5172:
	push xix
	push xiy
	ld wa,11
	push xwa
	call _load_kind__32
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld a,(xsp+22)
	cp a,10
	jr uge,L5173
	push xix
	push xiy
	ld wa,12
	push xwa
	call _load_kind__32
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L5173:
	push xix
	push xiy
	ld wa,13
	push xwa
	call _load_kind__32
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld a,(xsp+22)
	cp a,0
	jr z,L5175
	ld a,(xsp+22)
	cp a,10
	jr ult,L5174
L5175:
	push xix
	push xiy
	ld wa,14
	push xwa
	call _load_kind__32
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L5174:
	ld iz,0
	jr L5179
L5176:
	ld xwa,_objmap__32
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65535
	jr nz,L5180
	ld wa,0
	ld xbc,_objmap__32
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5180:
L5178:
	inc 1,iz
L5179:
	ld wa,iz
	cp wa,256
	jr ult,L5176
L5177:
	push xix
	push xiy
	ld wa,0
	push xwa
	ld a,(_kind_l__32)
	push xwa
	ld wa,1
	push xwa
	call _set_spr_pal__32
	lda xsp,(xsp+12)
	pop xiy
	pop xix
	push xix
	push xiy
	ld wa,1
	push xwa
	ld a,(_kind_r__32)
	push xwa
	ld wa,2
	push xwa
	call _set_spr_pal__32
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
	call _set_spr_pal__32
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
	call _set_spr_pal__32
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
	call _set_spr_pal__32
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
	call _set_spr_pal__32
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
L5147:
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
	jr z,L5185
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
	jr L5186
L5185:
	ld wa,(_cur_spr__32+24+6)
	push xwa
	ld wa,(_cur_spr__32+24+4)
	push xwa
	ld wa,(_cur_spr__32+24+2)
	push xwa
	ld wa,(_cur_spr__32+24)
	push xwa
	ld a,10
	push xwa
	ld a,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
L5186:
L5184:
	lda xsp,(xsp+4)
	ret

; function to_white
_to_white__32:
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
	jr ult,L5190
	ld wa,4095
	jr L5189
L5190:
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
	jr L5189
L5189:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function theme_flash
_theme_flash:
	push xiz
	lda xsp,(xsp-10)
	ld izl,0
	jp L5204
L5201:
	ld a,(xsp+18)
	push xwa
	ld xwa,_cur_pals__32
	ld c,izl
	extz bc
	sll 2,bc
	add bc,3
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__32
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+22)
	push xwa
	ld xwa,_cur_pals__32
	ld c,izl
	extz bc
	sll 2,bc
	add bc,2
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__32
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+26)
	push xwa
	ld xwa,_cur_pals__32
	ld c,izl
	extz bc
	sll 2,bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__32
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+30)
	push xwa
	ld xwa,_cur_pals__32
	ld c,izl
	extz bc
	sll 2,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__32
	lda xsp,(xsp+8)
	push xwa
	ld xwa,_pano_slot__32
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
L5203:
	inc 1,izl
L5204:
	ld a,izl
	cp a,13
	jp ult,L5201
L5202:
	ldb (xsp+1),0
	jr L5208
L5205:
	ld a,(xsp+18)
	push xwa
	ld xwa,_cur_band__32
	ld c,(xsp+5)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__32
	lda xsp,(xsp+8)
	lda xbc,(xsp+2)
	ld e,(xsp+1)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5207:
	incb 1,(xsp+1)
L5208:
	ld a,(xsp+1)
	cp a,4
	jr ult,L5205
L5206:
	lda xwa,(xsp+2)
	push xwa
	ld a,(xsp+22)
	push xwa
	ld wa,(_cur_road__32+6)
	push xwa
	call _to_white__32
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+26)
	push xwa
	ld wa,(_cur_road__32+2)
	push xwa
	call _to_white__32
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+30)
	push xwa
	ld wa,(_cur_backdrop__32)
	push xwa
	call _to_white__32
	lda xsp,(xsp+8)
	push xwa
	call _id_road_set_colors
	lda xsp,(xsp+16)
L5200:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function traffic_set_hard
_traffic_set_hard:
	ld a,(xsp+4)
	ld (_hard__33),a
	ld c,(xsp+4)
	cp c,0
	jr z,L5213
	ld wa,7
	jr L5214
L5213:
	ld wa,6
L5214:
	ld (_trf_cap__33),a
L5212:
	ret

; function rnd8
_rnd8__33:
	ld wa,(_rng__33)
	mul xwa,25173
	add wa,13849
	ld (_rng__33),wa
	ld wa,(_rng__33)
	srl 8,wa
	jr L5216
L5216:
	ret

; function traffic_init
_traffic_init:
	push xiz
	lda xsp,(xsp-2)
	ld wa,(xsp+10)
	ld (_trf_tiles__33),wa
	ld iz,0
	jr L5230
L5227:
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
L5229:
	inc 1,iz
L5230:
	ld wa,iz
	ld bc,(_gfx_traffic_tiles_count)
	sll 3,bc
	cp wa,bc
	jr ult,L5227
L5228:
	ld iz,0
	jr L5234
L5231:
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
L5233:
	inc 1,iz
L5234:
	ld wa,iz
	cp wa,5
	jr ult,L5231
L5232:
	call _traffic_clear
L5226:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function traffic_set_car_line
_traffic_set_car_line:
	ld a,(xsp+4)
	push xwa
	call _id_road_distance_at_line
	lda xsp,(xsp+4)
	ld (_car_d__33),wa
	ld a,(xsp+4)
	push xwa
	call _id_road_half_at
	lda xsp,(xsp+4)
	ld (_half_wheel__33),a
	ld a,(_half_wheel__33)
	cp a,0
	jr nz,L5238
	ldb (_half_wheel__33),1
L5238:
L5237:
	ret

; function traffic_clear
_traffic_clear:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L5248
L5245:
	ld a,0
	ld xbc,_cars__33
	ld e,izl
	extz de
	muls xde,14
	add xbc,xde
	ld (xbc),a
L5247:
	inc 1,izl
L5248:
	ld a,izl
	cp a,7
	jr ult,L5245
L5246:
	ld a,50
	push xwa
	ld a,28
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L5244:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function traffic_reset
_traffic_reset:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,(_trf_cap__33)
	jr ule,L5254
	ld a,(_trf_cap__33)
	ld izl,a
L5254:
	ld a,izl
	ld (_dens_min__33),a
	ld c,(xsp+12)
	cp c,(_trf_cap__33)
	jr ule,L5255
	ld a,(_trf_cap__33)
	extz wa
	jr L5256
L5255:
	ld a,(xsp+12)
	extz wa
L5256:
	ld (_dens_max__33),a
	ld a,(_dens_min__33)
	ld (_target__33),a
	ldb (_cooldown__33),30
L5253:
	pop xiz
	ret

; function lane_lat
_lane_lat__33:
	lda xsp,(xsp-2)
	ld a,(_half_wheel__33)
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
	jr L5258
L5258:
	lda xsp,(xsp+2)
	ret

; function lane_of
_lane_of__33:
	push xiz
	lda xsp,(xsp-4)
	ld a,(_half_wheel__33)
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
	jr ge,L5263
	ld iz,0
L5263:
	ld wa,iz
	cp wa,3
	jr le,L5264
	ld iz,3
L5264:
	ld a,izl
	jr L5262
L5262:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function spawn
_spawn__33:
	push xiz
	lda xsp,(xsp-10)
	ld wa,0
	exts xwa
	ld (xsp+4),xwa
	ld izl,0
	jr L5290
L5287:
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L5291
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+4),xwa
	jr L5288
L5291:
L5289:
	inc 1,izl
L5290:
	ld a,izl
	cp a,7
	jr ult,L5287
L5288:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L5292
	jp L5286
L5292:
	ldb (xsp+2),0
	jp L5296
L5293:
	ld wa,0
	ld (xsp+8),a
	call _rnd8__33
	extz wa
	and wa,3
	ld (xsp+1),a
	ld izl,0
	jr L5300
L5297:
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L5301
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+4)
	push xwa
	ld a,(xsp+5)
	push xwa
	call _lane_lat__33
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp wa,bc
	jr nz,L5301
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	ld bc,1450
	ld de,(_car_d__33)
	sub bc,de
	sub bc,400
	sll 4,bc
	cp wa,bc
	jr le,L5301
	ldb (xsp+8),1
L5301:
L5299:
	inc 1,izl
L5300:
	ld a,izl
	cp a,7
	jr ult,L5297
L5298:
	ld a,(xsp+8)
	cp a,0
	jr nz,L5302
	jr L5294
L5302:
L5295:
	incb 1,(xsp+2)
L5296:
	ld a,(xsp+2)
	cp a,3
	jp ult,L5293
L5294:
	ld a,(xsp+2)
	cp a,3
	jr nz,L5303
	jp L5286
L5303:
	ld a,1
	ld xbc,(xsp+4)
	ld (xbc),a
	call _rnd8__33
	extz wa
	exts xwa
	divs xwa,3
	ld wa,qwa
	ld xbc,(xsp+4)
	ld (xbc+1),a
	ld wa,11
	push xwa
	call _rnd8__33
	ld xbc,xwa
	pop xwa
	extz bc
	exts xbc
	divs xbc,5
	ld bc,qbc
	add wa,bc
	ld xbc,(xsp+4)
	ld (xbc+2),a
	ld c,(_hard__33)
	cp c,0
	jr z,L5304
	ld wa,42
	jr L5305
L5304:
	ld wa,55
L5305:
	push xwa
	call _rnd8__33
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
	jr nz,L5306
	ld xwa,(xsp+4)
	ld a,(xwa+3)
	sub a,15
	ld xbc,(xsp+4)
	ld (xbc+3),a
L5306:
	ld a,(xsp+1)
	push xwa
	call _lane_lat__33
	lda xsp,(xsp+4)
	ld xbc,(xsp+4)
	ld (xbc+4),wa
	ld xwa,(xsp+4)
	ld wa,(xwa+4)
	ld xbc,(xsp+4)
	ld (xbc+10),wa
	ld wa,1450
	ld bc,(_car_d__33)
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
L5286:
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
	jp L5339
L5336:
	ld xwa,_cars__33
	ld c,(xsp+0)
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld xiz,xwa
	ld a,(xiz)
	cp a,0
	jr nz,L5340
	jp L5338
L5340:
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
	jr z,L5341
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr ge,L5342
	ld wa,(xiz+4)
	add wa,8
	ld (xiz+4),wa
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr le,L5343
	ld wa,(xiz+10)
	ld (xiz+4),wa
L5343:
	jr L5344
L5342:
	ld wa,(xiz+4)
	sub wa,8
	ld (xiz+4),wa
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr ge,L5345
	ld wa,(xiz+10)
	ld (xiz+4),wa
L5345:
L5344:
	jr L5346
L5341:
	call _rnd8__33
	ld e,(_hard__33)
	cp e,0
	jr z,L5348
	ld bc,6
	jr L5349
L5348:
	ld bc,2
L5349:
	cp a,c
	jr uge,L5347
	ld wa,(xiz+4)
	push xwa
	call _lane_of__33
	lda xsp,(xsp+4)
	ld (xsp+8),a
	ld a,(xsp+8)
	cp a,0
	jr nz,L5350
	ldb (xsp+8),1
	jr L5351
L5350:
	ld a,(xsp+8)
	cp a,3
	jr nz,L5352
	ldb (xsp+8),2
	jr L5353
L5352:
	push xwa
	call _rnd8__33
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,1
	cp bc,0
	jr z,L5354
	ld a,(xsp+8)
	add a,1
	extz wa
	jr L5355
L5354:
	ld a,(xsp+8)
	sub a,1
	extz wa
L5355:
	ld (xsp+8),a
L5353:
L5351:
	ld a,(xsp+8)
	push xwa
	call _lane_lat__33
	lda xsp,(xsp+4)
	ld (xiz+10),wa
L5347:
L5346:
	ld wa,(xiz+6)
	ld bc,(_car_d__33)
	neg bc
	sll 4,bc
	sub bc,64
	cp wa,bc
	jr lt,L5357
	ld wa,(xiz+6)
	ld bc,1600
	ld de,(_car_d__33)
	sub bc,de
	sll 4,bc
	cp wa,bc
	jr le,L5356
L5357:
	ldb (xiz),0
	jr L5338
L5356:
	incb 1,(xsp+1)
L5338:
	incb 1,(xsp+0)
L5339:
	ld a,(xsp+0)
	cp a,7
	jp ult,L5336
L5337:
	ld a,(_cooldown__33)
	cp a,0
	jr z,L5358
	decb 1,(_cooldown__33)
L5358:
	ld a,(xsp+22)
	cp a,0
	jr z,L5359
	ld a,(xsp+1)
	cp a,(_target__33)
	jr uge,L5359
	ld a,(_cooldown__33)
	cp a,0
	jr nz,L5359
	ld a,(xsp+18)
	cp a,50
	jr ule,L5359
	call _spawn__33
	ld c,(_hard__33)
	cp c,0
	jr z,L5360
	ld wa,16
	jr L5361
L5360:
	ld wa,25
L5361:
	push xwa
	call _rnd8__33
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,31
	add wa,bc
	ld (_cooldown__33),a
	ld a,(_dens_max__33)
	cp a,(_dens_min__33)
	jr ule,L5362
	ld a,(_dens_min__33)
	extz wa
	push xwa
	call _rnd8__33
	ld xbc,xwa
	pop xwa
	extz bc
	exts xbc
	ld e,(_dens_max__33)
	sub e,(_dens_min__33)
	add e,1
	extz de
	divs xbc,de
	ld bc,qbc
	add wa,bc
	ld (_target__33),a
L5362:
L5359:
L5335:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function traffic_collide
_traffic_collide:
	push xiz
	lda xsp,(xsp-12)
	ld iyl,0
	jp L5383
L5380:
	ld xwa,_cars__33
	ld c,iyl
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld xiz,xwa
	ld a,(xiz)
	cp a,0
	jr nz,L5384
	jp L5382
L5384:
	ld bc,(xiz+12)
	cp bc,(xiz+6)
	jr ge,L5385
	ld wa,(xiz+12)
	jr L5386
L5385:
	ld wa,(xiz+6)
L5386:
	ld (xsp+8),wa
	ld bc,(xiz+12)
	cp bc,(xiz+6)
	jr ge,L5387
	ld wa,(xiz+6)
	jr L5388
L5387:
	ld wa,(xiz+12)
L5388:
	ld (xsp+10),wa
	ld wa,(xsp+8)
	cp wa,224
	jr gt,L5390
	ld wa,(xsp+10)
	cp wa,65440
	jr ge,L5389
L5390:
	jr L5382
L5389:
	ld wa,(xiz+4)
	sub wa,(xsp+20)
	ld ix,wa
	ld wa,ix
	cp wa,0
	jr ge,L5391
	ld wa,ix
	neg wa
	ld ix,wa
L5391:
	ld wa,ix
	cp wa,416
	jr ge,L5392
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
	jr ge,L5393
	ld wa,1
	jr L5394
L5393:
	ld wa,2
L5394:
	jr L5379
L5392:
L5382:
	inc 1,iyl
L5383:
	ld a,iyl
	cp a,7
	jp ult,L5380
L5381:
	ld wa,0
	jr L5379
L5379:
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
	jr L5431
L5428:
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L5432
	ld a,izl
	lda xbc,(xsp+0)
	ld e,(xsp+7)
	incb 1,(xsp+7)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L5432:
L5430:
	inc 1,izl
L5431:
	ld a,izl
	cp a,7
	jr ult,L5428
L5429:
	ld izl,1
	jp L5436
L5433:
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+14),a
	ld a,izl
	ld ixl,a
	jr L5439
L5437:
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
L5439:
	ld a,ixl
	cp a,0
	jr ule,L5440
	ld xwa,_cars__33
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
	ld xbc,_cars__33
	ld e,(xsp+14)
	extz de
	muls xde,14
	add xbc,xde
	ld bc,(xbc+6)
	cp wa,bc
	jr gt,L5437
L5440:
L5438:
	ld a,(xsp+14)
	lda xbc,(xsp+0)
	ld e,ixl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L5435:
	inc 1,izl
L5436:
	ld a,izl
	cp a,(xsp+7)
	jp ult,L5433
L5434:
	ld izl,0
	jp L5444
L5441:
	ld xwa,_cars__33
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
	ld wa,(_car_d__33)
	ld xbc,(xsp+14)
	ld bc,(xbc+6)
	exts xbc
	divs xbc,16
	add wa,bc
	ld (xsp+18),wa
	ld wa,(xsp+18)
	cp wa,0
	jr ge,L5445
	jp L5443
L5445:
	push xix
	ld wa,(xsp+22)
	push xwa
	call _id_road_line_at_distance
	lda xsp,(xsp+4)
	pop xix
	ld (xsp+20),a
	ld a,(xsp+20)
	cp a,255
	jr nz,L5446
	jp L5443
L5446:
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
	jr ge,L5447
	jp L5443
L5447:
	ld a,(xsp+28)
	extz wa
	sll 5,wa
	extz xwa
	ld c,(_half_wheel__33)
	extz bc
	div xwa,bc
	ld (xsp+22),a
	ld a,(xsp+22)
	cp a,28
	jr ult,L5448
	ldb (xsp+21),0
	jr L5449
L5448:
	ld a,(xsp+22)
	cp a,20
	jr ult,L5450
	ldb (xsp+21),1
	jr L5451
L5450:
	ld a,(xsp+22)
	cp a,13
	jr ult,L5452
	ldb (xsp+21),2
	jr L5453
L5452:
	ld a,(xsp+22)
	cp a,9
	jr ult,L5454
	ldb (xsp+21),3
	jr L5455
L5454:
	ldb (xsp+21),4
L5455:
L5453:
L5451:
L5449:
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
	ld e,(_half_wheel__33)
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
	jr le,L5456
	jp L5443
L5456:
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
	ld wa,(_trf_tiles__33)
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
	jr z,L5457
	ld bc,(xsp+26)
	ld e,(_bridge_line)
	extz de
	cp bc,de
	jr ge,L5457
	ld wa,16
	jr L5458
L5457:
	ld a,(_id_spr_priority)
	extz wa
L5458:
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
L5443:
	inc 1,izl
L5444:
	ld a,izl
	cp a,(xsp+7)
	jp ult,L5441
L5442:
	push xix
	ld a,(_trf_spr_end)
	push xwa
	ld a,(xsp+18)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xix
L5427:
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
	jp L5481
L5478:
	push xix
	push xiy
	ld a,iyl
	push xwa
	call _lane_lat__33
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (xsp+6),wa
	ld wa,32767
	ld (xsp+8),wa
	ld izl,0
	jp L5485
L5482:
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L5487
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	cp wa,65280
	jr ge,L5486
L5487:
	jr L5484
L5486:
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+4)
	sub wa,(xsp+6)
	ld ix,wa
	ld wa,ix
	cp wa,0
	jr ge,L5488
	ld wa,ix
	neg wa
	ld ix,wa
L5488:
	ld wa,ix
	cp wa,480
	jr ge,L5489
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	cp wa,(xsp+8)
	jr ge,L5489
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	ld (xsp+8),wa
L5489:
L5484:
	inc 1,izl
L5485:
	ld a,izl
	cp a,7
	jp ult,L5482
L5483:
	ld wa,(xsp+8)
	cp wa,(xsp+4)
	jr gt,L5491
	ld wa,(xsp+8)
	cp wa,(xsp+4)
	jr nz,L5490
	ld wa,(xsp+24)
	cp wa,0
	jr ge,L5493
	ld a,iyl
	cp a,0
	jr z,L5492
L5493:
	ld wa,(xsp+24)
	cp wa,0
	jr le,L5490
	ld a,iyl
	cp a,3
	jr nz,L5490
L5492:
L5491:
	ld wa,(xsp+8)
	ld (xsp+4),wa
	ld a,iyl
	ld (xsp+2),a
L5490:
L5480:
	inc 1,iyl
L5481:
	ld a,iyl
	cp a,4
	jp ult,L5478
L5479:
	ld wa,(xsp+4)
	cp wa,14400
	jr le,L5494
	ld wa,(xsp+24)
	cp wa,0
	jr z,L5494
	ld wa,(xsp+24)
	jr L5477
L5494:
	push xix
	push xiy
	ld a,(xsp+10)
	push xwa
	call _lane_lat__33
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	jr L5477
L5477:
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
	db 84,72,85,78,68,69,82,32,80,79,76,75,65,0
_S0_1:
	db 82,65,71,84,73,77,69,0
_S0_2:
	db 77,79,85,78,84,65,73,78,32,75,73,78,71,0
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
_lv__0_L355:
	db 1,2,3,4,4,4,4,3,3,2,1,0
_emblem_pal_slot__0:
	db 2,3,4,5,6,8,9,10,11,12,13,14,15
_over_pal_slot__0:
	db 4,5,6,10,11,12,13,14
_S0_12:
	db 72,73,0
_S0_13:
	db 66,58,78,69,87,0
_tsm__0_L587:
	db 1,125,126,127
_S0_14:
	db 80,82,69,83,83,32,65,32,84,79,32,83,84,65,82,84
	db 0
_S0_15:
	db 67,79,85,82,83,69,32,77,65,80,0
_S0_16:
	db 89,79,85,32,77,65,68,69,32,73,84,33,0
_S0_17:
	db 71,65,77,69,32,79,86,69,82,0
_S0_18:
	db 83,67,79,82,69,0
_S0_19:
	db 82,79,85,84,69,0
_S0_20:
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
_S0_21:
	db 80,65,85,83,69,0
_S0_22:
	db 84,73,77,69,32,85,80,0
_S0_23:
	db 98,32,76,69,70,84,32,32,32,32,82,73,71,72,84,32
	db 99,0
_S0_24:
	db 82,73,71,72,84,32,99,0
_S0_25:
	db 98,32,76,69,70,84,0
_S0_26:
	db 71,79,65,76,32,65,72,69,65,68,0
_S0_27:
	db 51,0
_S0_28:
	db 50,0
_S0_29:
	db 49,0
_S0_30:
	db 71,79,33,0
	align 2
_cd__0_L1181:
	dd _S0_27
	dd _S0_28
	dd _S0_29
	dd _S0_30
_S0_31:
	db 83,84,65,82,84,0
_S0_32:
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
	db 244,10,240,5,44,12,255,12,44,12,255,11,44,12,255,12
	db 44,12,255,12,44,12,255,11,44,12,255,12,44,12,255,12
	db 36,12,48,6,46,5,42,24,36,24,42,24,36,23,46,12
	db 255,6,46,6,46,12,255,6,46,6,46,35,48,6,46,6
	db 41,24,37,23,41,24,37,24,46,12,255,5,46,6,46,12
	db 255,6,46,6,46,36,48,5,46,6,42,24,48,24,48,23
	db 42,24,48,12,255,6,48,6,48,12,255,6,48,6,48,29
	db 46,6,44,6,42,6,41,24,49,23,49,24,41,24,49,11
	db 255,6,49,6,49,12,255,6,49,6,49,36,48,5,46,6
	db 42,24,36,24,42,23,36,24,46,12,255,6,46,6,46,12
	db 255,6,46,5,46,36,48,6,46,6,41,24,37,23,41,24
	db 37,24,46,11,255,6,46,6,46,12,255,6,46,6,46,35
	db 46,6,44,6,43,24,49,24,49,23,41,24,51,18,51,6
	db 51,17,51,6,51,24,41,6,51,6,50,6,51,6,41,12
	db 49,11,46,12,48,12,49,12,51,12,41,12,43,12,44,11
	db 44,12,44,12,44,12,45,12,44,12,46,11,44,12,47,36
	db 44,12,45,11,44,12,46,12,44,12,48,36,44,11,50,12
	db 255,12,44,12,255,12,50,12,255,11,44,12,255,12,51,12
	db 255,24,46,11,44,12,42,12,41,12,51,12,42,12,44,12
	db 41,11,44,12,51,12,44,12,49,12,44,12,48,11,255,12
	db 46,12,255,12,45,12,255,12,46,11,255,12,44,24,42,18
	db 48,6,48,47,44,24,41,17,49,6,49,12,44,12,46,12
	db 44,12,42,12,44,11,41,12,44,12,51,12,44,12,49,12
	db 44,12,48,11,255,12,46,12,255,12,45,12,255,12,46,11
	db 255,12,44,24,41,18,49,6,44,23,44,18,41,6,46,12
	db 44,12,51,12,41,11,49,12,44,12,46,12,44,12,42,12
	db 32,11,41,12,32,12,39,12,32,12,37,12,32,11,36,12
	db 255,12,34,12,255,12,33,12,255,12,34,11,255,12,32,24
	db 42,18,36,6,36,47,32,24,41,17,37,6,37,12,44,12
	db 46,12,44,12,42,12,32,11,41,12,32,12,39,12,32,12
	db 37,12,32,11,36,12,255,12,34,12,255,12,33,12,255,11
	db 34,12,255,12,32,24,41,18,37,6,32,23,44,18,41,6
	db 46,12,44,12,39,11,41,12,25,12,25,12,25,12,255,12
	db 39,6,37,5,35,6,34,6,32,12,255,12,35,6,34,6
	db 32,6,30,6,29,12,255,11,37,12,35,12,32,12,29,12
	db 25,12,255,23,25,12,18,24,22,23,27,42,25,6,23,24
	db 17,11,25,12,25,48,23,23,17,12,25,12,25,47,22,24
	db 18,18,15,6,25,23,255,12,25,12,18,24,22,23,27,42
	db 25,6,23,23,17,12,25,12,25,48,26,11,255,12,27,12
	db 255,12,28,12,255,12,29,11,255,12,32,12,34,12,35,12
	db 36,12,37,11,255,24,25,12,18,24,22,23,27,42,25,6
	db 23,23,17,12,25,12,25,47,23,24,17,12,25,12,25,47
	db 22,24,18,18,15,6,25,23,255,12,25,12,18,24,22,23
	db 27,42,25,6,23,23,17,12,25,12,25,47,26,12,255,12
	db 27,12,255,12,28,12,255,11,29,12,255,12,32,12,34,12
	db 35,12,36,12,49,11,255,36,51,12,255,12,49,11,255,12
	db 44,18,42,6,49,12,255,12,51,11,255,12,49,12,255,12
	db 42,18,41,6,49,12,255,11,51,12,255,12,49,12,255,12
	db 49,23,49,12,255,12,51,12,255,12,49,12,255,11,49,24
	db 49,12,255,12,51,12,255,12,49,11,255,12,44,18,42,6
	db 49,12,255,12,51,11,255,12,49,12,255,12,42,18,41,6
	db 49,11,255,12,41,12,255,12,44,12,255,12,46,23,46,12
	db 255,12,48,24,48,12,255,11,49,24,49,12,255,12,51,12
	db 255,11,49,12,255,12,44,18,42,6,49,12,255,12,51,11
	db 255,12,49,12,255,12,42,18,41,6,49,11,255,12,51,12
	db 255,12,49,12,255,12,49,23,49,12,255,12,51,12,255,12
	db 49,12,255,11,49,24,49,12,255,12,51,12,255,11,49,12
	db 255,12,44,18,42,6,49,12,255,11,51,12,255,12,49,12
	db 255,12,42,18,41,6,49,11,255,12,41,12,255,12,44,12
	db 255,12,46,23,46,12,255,12,48,24,48,11,255,12,49,12
	db 255,12,42,24,41,12,255,11,51,24,49,12,255,12,51,12
	db 255,11,49,12,255,12,47,12,37,12,42,23,46,24,51,42
	db 49,6,47,23,41,12,37,12,49,47,47,24,41,12,37,12
	db 49,47,46,24,42,17,39,6,37,24,255,12,37,12,42,23
	db 46,24,51,42,49,5,47,24,46,12,44,12,41,35,51,12
	db 51,12,255,12,49,12,255,12,48,11,49,12,42,12,46,12
	db 46,24,44,23,42,12,42,12,42,12,255,12,44,12,255,11
	db 44,12,255,12,44,12,255,12,44,12,255,11,44,12,255,12
	db 44,12,255,12,44,12,255,11,36,12,48,6,46,6,42,24
	db 36,24,42,23,36,24,46,12,255,6,46,6,46,11,255,6
	db 46,6,46,36,48,6,46,6,41,23,37,24,41,24,37,23
	db 46,12,255,6,46,6,46,12,255,6,46,6,46,35,48,6
	db 46,6,42,24,48,23,48,24,42,24,48,12,255,6,48,6
	db 48,11,255,6,48,6,48,30,46,6,44,6,42,6,41,23
	db 49,24,49,24,41,23,49,12,255,6,49,6,49,12,255,6
	db 49,6,49,35,48,6,46,6,42,24,36,23,42,24,36,24
	db 46,12,255,6,46,5,46,12,255,6,46,6,46,36,48,6
	db 46,6,41,23,37,24,41,24,37,23,46,12,255,6,46,6
	db 46,12,255,6,46,6,46,35,46,6,44,6,43,24,49,23
	db 49,24,41,24,51,18,51,5,51,18,51,6,51,24,41,6
	db 51,6,50,6,51,5,41,12,49,12,46,12,48,12,49,12
	db 51,12,41,11,43,12,44,12,44,12,44,12,44,12,45,11
	db 44,12,46,12,44,12,47,35,44,12,45,12,44,12,46,12
	db 44,12,48,35,44,12,50,12,255,12,44,12,255,11,50,12
	db 255,12,44,12,255,12,51,12,255,23,46,12,44,12,42,12
	db 41,12,51,12,42,11,44,12,41,12,44,12,51,12,44,12
	db 49,11,44,12,48,12,255,12,46,12,255,12,45,11,255,12
	db 46,12,255,12,44,24,42,17,48,6,48,48,44,23,41,18
	db 49,6,49,12,44,12,46,12,44,11,42,12,44,12,41,12
	db 44,12,51,12,44,12,49,11,44,12,48,12,255,12,46,12
	db 255,12,45,11,255,12,46,12,255,12,44,24,41,17,49,6
	db 44,24,44,18,41,6,46,12,44,11,51,12,41,12,49,12
	db 44,12,46,12,44,11,42,12,32,12,41,12,32,12,39,12
	db 32,11,37,12,32,12,36,12,255,12,34,12,255,12,33,11
	db 255,12,34,12,255,12,32,24,42,17,36,6,36,48,32,23
	db 41,18,37,6,37,12,44,12,46,12,44,11,42,12,32,12
	db 41,12,32,12,39,12,32,11,37,12,32,12,36,12,255,12
	db 34,12,255,11,33,12,255,12,34,12,255,12,32,24,41,17
	db 37,6,32,24,44,18,41,6,46,11,44,12,39,12,41,12
	db 37,12,37,12,37,11,255,12,25,48,25,47,27,24,28,23
	db 29,12,25,12,20,12,255,12,25,47,25,48,29,23,27,24
	db 25,12,255,12,19,11,255,12,25,12,255,12,19,12,255,12
	db 20,6,22,5,24,6,25,6,15,6,17,6,18,6,20,6
	db 18,6,17,6,15,6,17,6,18,6,20,6,22,5,24,6
	db 25,12,24,12,25,12,24,12,25,12,24,11,25,12,24,12
	db 25,12,255,35,29,12,255,36,25,47,0
_song0_v1__9:
	db 244,6,240,6,8,47,8,3,8,3,8,3,8,3,8,3
	db 8,3,8,3,8,3,8,3,8,3,8,3,8,3,8,3
	db 8,3,8,3,8,3,8,3,8,3,8,3,8,3,8,3
	db 8,3,8,2,8,3,8,3,8,3,8,3,8,3,8,3
	db 8,3,8,3,8,3,8,3,8,3,8,3,8,3,8,3
	db 8,3,8,3,8,3,8,3,8,3,8,3,8,3,8,3
	db 8,3,8,3,8,2,3,12,8,12,8,12,8,12,3,12
	db 8,12,8,11,8,12,12,12,8,12,8,12,8,12,12,11
	db 8,12,8,12,8,12,1,12,8,12,5,11,8,12,1,12
	db 8,12,5,12,8,12,1,12,8,11,5,12,8,12,1,12
	db 8,12,8,12,8,11,3,12,8,12,8,12,8,12,3,12
	db 8,11,8,12,8,12,3,12,8,12,8,12,8,12,3,11
	db 8,12,8,12,8,12,1,12,8,12,8,11,8,12,1,12
	db 8,12,8,12,8,12,1,11,8,12,8,12,8,12,1,12
	db 8,12,8,12,8,11,3,12,8,12,8,12,8,12,3,12
	db 8,11,8,12,8,12,12,12,8,12,8,12,8,11,12,12
	db 8,12,8,12,8,12,1,12,8,12,5,11,8,12,1,12
	db 8,12,5,12,8,12,1,11,8,12,5,12,8,12,1,12
	db 8,12,8,11,8,12,10,12,15,12,3,12,15,12,10,12
	db 15,11,3,12,15,12,8,12,15,12,8,12,15,11,8,12
	db 15,12,15,12,15,12,13,12,17,11,13,12,17,12,3,12
	db 15,12,3,12,15,12,20,11,8,12,8,12,8,12,21,12
	db 20,12,22,11,20,12,8,12,8,12,8,12,20,12,21,11
	db 20,12,22,12,20,12,8,12,8,12,8,12,20,11,255,24
	db 8,12,255,35,8,12,255,12,8,12,8,12,8,12,255,11
	db 10,48,1,12,5,12,1,11,5,12,1,12,5,12,1,12
	db 5,12,6,11,10,12,6,12,10,12,6,12,10,12,6,11
	db 10,12,8,12,12,12,8,12,12,12,8,12,3,11,12,12
	db 8,12,1,12,5,12,1,12,5,11,1,12,8,12,8,12
	db 8,12,1,12,5,11,1,12,5,12,1,12,5,12,1,12
	db 5,12,6,11,10,12,6,12,10,12,6,12,10,12,6,11
	db 10,12,8,12,255,36,8,11,255,36,8,12,8,12,8,12
	db 8,11,13,12,255,36,13,12,13,11,13,12,255,12,1,12
	db 255,35,1,12,255,36,1,12,255,35,10,48,6,11,13,12
	db 6,12,13,12,6,12,13,12,13,11,13,12,8,12,13,12
	db 1,12,13,12,8,12,13,11,13,12,13,12,8,12,13,12
	db 1,12,13,11,8,12,13,12,13,12,13,12,6,12,13,11
	db 1,12,13,12,6,12,13,12,13,12,13,12,6,11,13,12
	db 6,12,13,12,6,12,13,12,13,11,13,12,8,12,13,12
	db 1,12,13,12,8,11,13,12,13,12,13,12,13,12,255,12
	db 13,12,255,11,13,12,255,12,13,12,255,12,1,12,1,11
	db 1,12,1,12,1,12,255,35,1,12,255,12,1,24,10,47
	db 6,12,13,12,10,12,13,12,6,11,13,12,10,12,13,12
	db 8,12,13,12,1,11,13,12,8,12,13,12,1,12,13,12
	db 13,12,17,11,13,12,17,12,13,12,17,12,13,12,17,11
	db 6,12,13,12,13,12,255,12,6,12,13,11,10,12,13,12
	db 6,12,13,12,10,12,13,12,6,11,13,12,10,12,13,12
	db 13,12,17,12,13,11,17,12,13,12,17,12,13,12,17,12
	db 6,23,255,24,8,24,255,23,13,12,1,12,1,12,255,12
	db 13,12,255,11,15,24,13,12,255,12,13,23,13,12,255,36
	db 10,47,6,12,13,12,6,12,13,12,6,11,13,12,13,12
	db 13,12,8,12,13,12,1,11,13,12,8,12,13,12,13,12
	db 13,12,8,12,13,11,1,12,13,12,8,12,13,12,13,12
	db 13,11,6,12,13,12,1,12,13,12,6,12,13,11,13,12
	db 13,12,6,12,13,12,6,12,13,12,6,11,13,12,13,12
	db 13,12,11,12,15,12,11,11,15,12,11,12,15,12,15,12
	db 15,12,13,11,18,12,13,12,18,12,13,12,18,12,18,12
	db 18,11,1,24,1,24,6,12,10,11,6,12,255,12,8,12
	db 255,35,8,3,8,3,8,3,8,3,8,3,8,3,8,3
	db 8,3,8,3,8,3,8,3,8,3,8,3,8,3,8,3
	db 8,3,8,3,8,3,8,3,8,3,8,3,8,3,8,3
	db 8,3,8,2,8,3,8,3,8,3,8,3,8,3,8,3
	db 8,3,8,3,8,3,8,3,8,3,8,3,8,3,8,3
	db 8,3,8,3,8,3,8,3,8,3,8,3,8,3,8,3
	db 8,3,3,11,8,12,8,12,8,12,3,12,8,12,8,11
	db 8,12,12,12,8,12,8,12,8,12,12,12,8,11,8,12
	db 8,12,1,12,8,12,5,12,8,11,1,12,8,12,5,12
	db 8,12,1,12,8,11,5,12,8,12,1,12,8,12,8,12
	db 8,12,3,11,8,12,8,12,8,12,3,12,8,12,8,11
	db 8,12,3,12,8,12,8,12,8,12,3,11,8,12,8,12
	db 8,12,1,12,8,12,8,12,8,11,1,12,8,12,8,12
	db 8,12,1,12,8,11,8,12,8,12,1,12,8,12,8,12
	db 8,11,3,12,8,12,8,12,8,12,3,12,8,12,8,11
	db 8,12,12,12,8,12,8,12,8,12,12,11,8,12,8,12
	db 8,12,1,12,8,12,5,11,8,12,1,12,8,12,5,12
	db 8,12,1,12,8,11,5,12,8,12,1,12,8,12,8,12
	db 8,11,10,12,15,12,3,12,15,12,10,12,15,11,3,12
	db 15,12,8,12,15,12,8,12,15,12,8,11,15,12,15,12
	db 15,12,13,12,17,12,13,11,17,12,3,12,15,12,3,12
	db 15,12,20,11,8,12,8,12,8,12,21,12,20,12,22,12
	db 20,11,8,12,8,12,8,12,20,12,21,12,20,11,22,12
	db 20,12,8,12,8,12,8,12,20,11,255,24,8,12,255,36
	db 8,11,255,12,8,12,8,12,8,12,255,12,10,47,1,12
	db 5,12,1,11,5,12,1,12,5,12,1,12,5,12,6,12
	db 10,11,6,12,10,12,6,12,10,12,6,12,10,11,8,12
	db 12,12,8,12,12,12,8,12,3,11,12,12,8,12,1,12
	db 5,12,1,12,5,12,1,11,8,12,8,12,8,12,1,12
	db 5,12,1,11,5,12,1,12,5,12,1,12,5,12,6,11
	db 10,12,6,12,10,12,6,12,10,12,6,12,10,11,8,12
	db 255,36,8,12,255,35,8,12,8,12,8,12,8,11,13,12
	db 255,36,13,12,13,12,13,11,255,12,11,24,11,24,22,11
	db 13,12,13,12,255,12,8,24,8,23,1,12,13,12,13,12
	db 255,12,11,23,11,24,22,12,13,12,13,12,255,11,8,24
	db 8,24,255,23,1,12,255,36,1,12,255,12,8,59,8,12
	db 8,11,8,12,1,12,8,12,1,12,8,12,1,11,8,12
	db 1,12,8,12,1,3,1,3,1,3,1,3,1,3,1,3
	db 1,3,1,3,1,3,1,3,1,3,1,3,1,2,1,3
	db 1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3
	db 1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3
	db 1,3,1,3,1,3,1,3,1,3,1,3,1,3,1,3
	db 1,2,1,3,1,24,255,240,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,202,0
_song0_v2__9:
	db 244,6,240,8,255,47,20,3,255,151,30,12,255,12,30,12
	db 255,12,30,12,255,11,30,12,255,12,30,12,255,12,30,12
	db 255,11,30,12,30,12,30,12,255,12,29,12,255,11,29,12
	db 255,12,29,12,255,12,29,12,255,12,29,11,255,12,29,12
	db 255,12,29,12,29,12,29,11,255,12,30,12,255,12,30,12
	db 255,12,30,11,255,12,30,12,255,12,30,12,255,12,30,12
	db 255,11,30,12,30,12,30,12,255,12,29,12,255,11,29,12
	db 255,12,29,12,255,12,29,12,255,11,29,12,255,12,29,12
	db 255,12,29,12,29,12,29,11,255,12,30,12,255,12,30,12
	db 255,12,30,11,255,12,30,12,255,12,30,12,255,12,30,11
	db 255,12,30,12,30,12,30,12,255,12,29,12,255,11,29,12
	db 255,12,29,12,255,12,29,12,255,11,29,12,255,12,29,12
	db 255,12,29,12,29,11,29,12,255,12,37,12,255,12,37,12
	db 255,12,37,11,255,12,37,12,255,12,36,12,255,12,36,11
	db 255,12,36,12,36,12,36,12,255,12,37,11,255,12,37,12
	db 255,12,37,12,255,12,37,12,36,11,32,12,32,12,32,12
	db 255,47,32,12,32,12,32,12,255,59,32,12,32,12,32,12
	db 255,35,29,12,255,35,29,12,255,12,30,12,255,95,25,12
	db 255,11,25,12,255,12,25,12,255,12,25,12,255,11,30,12
	db 255,12,30,12,255,12,30,12,255,11,30,12,255,12,32,12
	db 255,12,32,12,255,12,27,11,24,12,20,12,255,12,25,12
	db 255,12,25,11,255,12,29,12,29,12,29,12,255,12,25,11
	db 255,12,25,12,255,12,25,12,255,12,25,12,255,11,30,12
	db 255,12,30,12,255,12,30,12,255,11,30,12,32,12,255,36
	db 32,11,255,48,30,12,255,12,30,11,29,12,255,36,29,12
	db 29,11,29,12,255,12,23,12,255,35,23,12,255,36,23,12
	db 255,94,34,12,255,12,34,12,255,12,34,12,34,11,34,12
	db 255,12,35,12,255,12,35,12,255,12,35,11,35,12,35,12
	db 255,12,35,12,255,12,35,11,255,12,35,12,35,12,35,12
	db 255,12,34,11,255,12,34,12,255,12,34,12,34,12,34,12
	db 255,11,34,12,255,12,34,12,255,12,34,12,34,11,34,12
	db 255,12,35,12,255,12,35,12,255,11,35,12,35,12,35,12
	db 35,12,255,12,35,12,255,11,35,12,255,12,35,12,255,12
	db 23,12,23,11,23,12,23,12,23,12,255,35,23,12,255,95
	db 34,12,255,12,34,12,255,11,34,12,255,12,34,12,255,12
	db 35,12,255,11,35,12,255,12,35,12,255,12,35,12,255,12
	db 35,11,255,12,35,12,255,12,35,12,255,12,35,11,255,12
	db 34,12,34,12,255,24,34,11,255,12,34,12,255,12,34,12
	db 255,12,34,12,255,11,34,12,255,12,34,12,255,12,32,12
	db 255,11,32,12,255,12,32,12,255,12,32,12,30,23,255,24
	db 30,24,255,23,29,12,25,12,25,12,255,12,29,12,255,11
	db 33,24,32,12,255,12,36,23,37,12,255,95,34,12,255,12
	db 34,12,255,11,34,12,34,12,34,12,255,12,35,12,255,11
	db 35,12,255,12,35,12,35,12,35,12,255,12,35,11,255,12
	db 35,12,255,12,35,12,35,12,35,11,255,12,34,12,255,12
	db 34,12,255,12,34,11,34,12,34,12,255,12,34,12,255,12
	db 34,12,255,11,34,12,34,12,34,12,255,12,32,12,255,11
	db 32,12,255,12,35,12,35,12,35,12,255,11,34,12,255,12
	db 34,12,255,12,34,12,34,12,34,11,13,24,13,24,18,12
	db 22,11,18,12,255,12,20,47,20,3,255,151,30,12,255,12
	db 30,12,255,12,30,12,255,11,30,12,255,12,30,12,255,12
	db 30,12,255,12,30,11,30,12,30,12,255,12,29,12,255,12
	db 29,11,255,12,29,12,255,12,29,12,255,12,29,11,255,12
	db 29,12,255,12,29,12,29,12,29,12,255,11,30,12,255,12
	db 30,12,255,12,30,12,255,11,30,12,255,12,30,12,255,12
	db 30,12,255,11,30,12,30,12,30,12,255,12,29,12,255,12
	db 29,11,255,12,29,12,255,12,29,12,255,12,29,11,255,12
	db 29,12,255,12,29,12,29,12,29,11,255,12,30,12,255,12
	db 30,12,255,12,30,12,255,11,30,12,255,12,30,12,255,12
	db 30,12,255,11,30,12,30,12,30,12,255,12,29,12,255,11
	db 29,12,255,12,29,12,255,12,29,12,255,12,29,11,255,12
	db 29,12,255,12,29,12,29,12,29,11,255,12,37,12,255,12
	db 37,12,255,12,37,11,255,12,37,12,255,12,36,12,255,12
	db 36,12,255,11,36,12,36,12,36,12,255,12,37,12,255,11
	db 37,12,255,12,37,12,255,12,37,12,36,11,32,12,32,12
	db 32,12,255,47,32,12,32,12,32,12,255,59,32,12,32,12
	db 32,12,255,35,29,12,255,36,29,11,255,12,30,12,255,95
	db 25,12,255,11,25,12,255,12,25,12,255,12,25,12,255,12
	db 30,11,255,12,30,12,255,12,30,12,255,12,30,11,255,12
	db 32,12,255,12,32,12,255,12,27,11,24,12,20,12,255,12
	db 25,12,255,12,25,12,255,11,29,12,29,12,29,12,255,12
	db 25,12,255,11,25,12,255,12,25,12,255,12,25,12,255,11
	db 30,12,255,12,30,12,255,12,30,12,255,12,30,11,32,12
	db 255,36,32,12,255,47,30,12,255,12,30,11,29,12,255,36
	db 29,12,29,12,29,11,255,12,29,24,29,24,30,11,32,12
	db 34,12,255,12,20,24,20,23,25,12,37,12,37,12,255,12
	db 29,23,29,24,30,12,32,12,34,12,255,11,20,24,20,24
	db 255,95,20,59,20,12,20,11,20,12,20,12,20,12,20,12
	db 20,12,20,11,20,12,20,12,20,12,255,118,13,24,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,202,0
_song0_v3__9:
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,11,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,11,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,11
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,11,244,3
	db 240,7,6,12,6,6,6,6,6,6,6,6,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,11,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,11,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,11
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,11,244,3,240,7,6,12
	db 6,6,6,6,6,6,6,6,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,11,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,11,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,11,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,11
	db 244,1,240,5,3,12,244,3,240,7,6,12,6,6,6,6
	db 6,6,6,6,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,11,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,11,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,11,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,11,244,1,240,5
	db 3,12,244,3,240,7,6,12,6,6,6,6,6,6,6,6
	db 244,1,240,5,3,12,244,2,240,12,5,11,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,11,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,11,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,11,244,1,240,5,3,12,244,3
	db 240,7,6,12,6,6,6,6,6,6,6,6,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,11,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,11,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,11,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,11,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,3,240,7,6,12
	db 6,6,6,6,6,6,6,6,244,1,240,5,3,12,244,2
	db 240,12,5,11,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,11,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,11,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,11,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,3,240,7,6,12,6,6,6,6
	db 6,6,6,6,244,1,240,5,3,11,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,11,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,11,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,11,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,3,240,7,6,12,6,6,6,6,6,6,6,6
	db 244,1,240,5,3,11,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,11,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,11,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,11,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,3
	db 240,7,6,12,6,6,6,6,6,6,6,6,244,1,240,5
	db 3,11,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,11,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,11,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,11,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,3,240,7,6,12
	db 6,6,6,6,6,6,6,5,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,11,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,11,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,11,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,3,240,7,6,12,6,6,6,6
	db 6,5,6,6,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,11,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,11,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,11,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,3,240,7,6,12,6,6,6,6,6,5,6,6
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,11,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,11,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,11,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,11,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,3
	db 240,7,6,12,6,6,6,5,6,6,6,6,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,11
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,11,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,11,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,3,240,7,6,12
	db 6,6,6,5,6,6,6,6,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,11,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,11
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,11,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,11,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,3,240,7,6,12,6,5,6,6
	db 6,6,6,6,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,11,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,11,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,11
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,11,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,3,240,7,6,11,6,6,6,6,6,6,6,6
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,11,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,11,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,11,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,11
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,3
	db 240,7,6,11,6,6,6,6,6,6,6,6,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,11,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,11,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,11,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,11,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,3,240,7,6,11
	db 6,6,6,6,6,6,6,6,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,11
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,11,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,11,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,11,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,11,244,3,240,7,6,12,6,6,6,6
	db 6,6,6,6,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,11,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,11
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,11,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,11,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,11,244,3,240,7,6,12,6,6,6,6,6,6,6,6
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,11,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,11,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,11
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,11,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,11,244,3
	db 240,7,6,12,6,6,6,6,6,6,6,6,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,11,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,11,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,11,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,11
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,11,244,1,240,5,3,12,244,3,240,7,6,12
	db 6,6,6,6,6,6,6,6,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,11,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,11,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,11,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,11
	db 244,1,240,5,3,12,244,3,240,7,6,12,6,6,6,6
	db 6,6,6,6,244,1,240,5,3,12,244,2,240,12,5,11
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,11,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,11,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,11,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,11,244,1,240,5
	db 3,12,244,3,240,7,6,12,6,6,6,6,6,6,6,6
	db 244,1,240,5,3,12,244,2,240,12,5,11,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,11
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,11,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,11,244,2,240,12,5,12,244,1,240,5,3,12,244,3
	db 240,7,6,12,6,6,6,6,6,6,6,6,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,11,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,11
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,11,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,11,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,3,240,7,6,12
	db 6,6,6,6,6,6,6,6,244,1,240,5,3,11,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,11,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,11,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,11
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,3,240,7,6,12,6,6,6,6
	db 6,6,6,6,244,1,240,5,3,11,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,11,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,11,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,11
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,3,240,7,6,12,6,6,6,6,6,6,6,6
	db 244,1,240,5,3,11,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,11,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,11,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,11,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,3
	db 240,7,6,12,6,6,6,6,6,6,6,5,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,11,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,11,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,11,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,3,240,7,6,12
	db 6,6,6,6,6,6,6,5,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,11,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,11,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,11,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,3,240,7,6,12,6,6,6,6
	db 6,5,6,6,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,11,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,11,244,2,240,12,5,12,0
_song1_v0__9:
	db 244,10,240,5,255,27,26,9,33,9,26,9,30,9,33,18
	db 25,9,33,9,25,9,28,9,33,45,255,9,26,9,33,9
	db 26,9,30,9,33,18,25,9,33,9,25,9,28,9,33,27
	db 255,9,33,9,255,9,26,9,29,9,34,9,255,9,33,9
	db 255,9,33,9,255,9,26,9,29,9,34,9,255,9,33,9
	db 255,27,26,9,17,9,26,9,255,9,26,9,17,9,26,9
	db 255,9,26,9,29,9,38,9,255,9,38,9,41,9,50,9
	db 50,18,50,18,50,18,50,9,50,18,45,9,47,9,42,9
	db 45,9,47,18,38,18,40,9,41,9,38,9,40,9,42,18
	db 38,9,42,9,38,9,40,18,38,18,255,9,38,27,38,18
	db 38,18,38,9,38,18,33,9,35,9,30,9,33,9,35,18
	db 26,18,28,9,29,9,26,9,28,9,30,18,26,9,30,9
	db 26,9,28,18,26,18,255,27,38,9,45,9,38,9,42,9
	db 45,18,37,9,45,9,37,9,40,9,45,45,255,9,38,9
	db 45,9,38,9,42,9,45,18,37,9,45,9,37,9,40,9
	db 45,27,255,9,45,9,255,9,38,9,41,9,46,9,255,9
	db 45,9,255,9,45,9,255,9,38,9,41,9,46,9,255,9
	db 45,9,255,27,26,9,17,9,26,9,255,9,26,9,29,9
	db 38,9,255,9,38,9,41,9,50,9,255,9,50,9,41,9
	db 50,9,50,18,50,18,50,18,50,9,50,18,45,9,47,9
	db 42,9,45,9,47,18,50,18,40,9,41,9,50,9,40,9
	db 42,18,50,9,42,9,50,9,40,18,50,18,255,9,50,27
	db 50,18,50,18,50,9,50,18,45,9,47,9,42,9,45,9
	db 47,18,38,18,40,9,41,9,38,9,40,9,42,18,38,9
	db 42,9,38,9,40,18,38,18,255,27,49,9,45,9,49,9
	db 40,9,44,18,49,9,43,9,49,9,40,9,42,18,45,9
	db 40,9,45,9,255,9,42,9,50,9,42,9,45,9,47,18
	db 42,9,50,9,42,9,45,9,47,18,42,9,47,18,255,9
	db 45,9,49,9,40,9,43,9,47,18,45,9,49,9,40,9
	db 43,9,47,18,43,9,47,18,255,9,42,9,50,9,42,9
	db 45,9,47,18,42,9,50,9,42,9,45,9,47,18,42,9
	db 47,18,255,9,49,9,45,9,49,9,40,9,44,18,49,9
	db 43,9,49,9,40,9,42,18,45,9,40,9,45,9,255,9
	db 42,9,50,9,42,9,45,9,47,18,42,9,50,18,50,18
	db 49,18,48,18,255,9,35,9,39,9,42,9,47,9,42,9
	db 39,9,35,9,255,9,35,9,40,9,43,9,47,18,43,18
	db 42,18,255,9,42,9,255,9,40,18,33,9,38,18,45,18
	db 45,18,45,18,255,9,49,9,45,9,49,9,40,9,44,18
	db 49,9,43,9,49,9,40,9,42,18,45,9,40,9,45,9
	db 255,9,42,9,50,9,42,9,45,9,47,18,42,9,50,9
	db 42,9,45,9,47,18,42,9,47,18,255,9,45,9,49,9
	db 40,9,43,9,47,18,45,9,49,9,40,9,43,9,47,18
	db 43,9,47,18,255,9,42,9,50,9,42,9,45,9,47,18
	db 42,9,50,9,42,9,45,9,47,18,42,9,47,18,255,9
	db 49,9,45,9,49,9,40,9,44,18,49,9,43,9,49,9
	db 40,9,42,18,45,9,40,9,45,9,255,9,42,9,50,9
	db 42,9,45,9,47,18,42,9,50,18,50,18,49,18,48,18
	db 255,9,47,9,51,9,42,9,47,9,42,9,51,9,47,9
	db 255,9,47,9,40,9,43,9,47,18,43,18,42,18,255,9
	db 42,9,255,9,40,18,45,9,255,9,38,9,42,9,45,9
	db 50,18,255,27,38,9,45,9,38,9,42,9,45,18,37,9
	db 45,9,37,9,40,9,45,45,255,9,38,9,45,9,38,9
	db 42,9,45,18,37,9,45,9,37,9,40,9,45,27,255,9
	db 45,9,255,9,38,9,41,9,46,9,255,9,45,9,255,9
	db 45,9,255,9,38,9,41,9,46,9,255,9,45,9,255,27
	db 26,9,17,9,26,9,255,9,26,9,29,9,38,9,255,9
	db 38,9,41,9,50,9,255,9,50,9,41,9,50,9,50,18
	db 50,18,50,18,50,9,50,18,45,9,47,9,42,9,45,9
	db 47,18,50,18,40,9,41,9,50,9,40,9,42,18,50,9
	db 42,9,50,9,40,18,50,18,255,9,50,27,50,18,50,18
	db 50,9,50,18,45,9,47,9,42,9,45,9,47,18,38,18
	db 40,9,41,9,38,9,40,9,42,18,38,9,42,9,38,9
	db 40,18,38,18,50,18,50,27,50,18,45,9,40,18,50,27
	db 50,18,45,9,40,9,45,9,38,9,43,9,40,9,43,9
	db 47,9,38,9,43,9,47,9,40,9,43,9,47,9,38,18
	db 47,9,40,9,47,9,50,27,50,18,45,9,40,18,50,27
	db 50,18,45,9,40,9,45,9,38,9,43,9,40,9,43,9
	db 47,9,38,9,43,9,47,9,40,9,43,9,47,9,38,18
	db 47,9,39,9,47,9,40,27,40,18,47,9,42,18,40,27
	db 40,18,47,9,42,9,47,9,255,9,45,9,40,9,45,9
	db 48,9,42,18,45,9,40,9,45,9,48,9,42,18,45,9
	db 40,18,43,18,43,18,42,18,40,18,47,9,43,9,45,9
	db 48,18,40,9,47,18,47,9,43,9,45,9,47,18,42,9
	db 45,9,43,18,50,18,47,9,50,9,47,9,50,9,47,9
	db 50,27,50,18,45,9,40,18,50,27,50,18,45,9,40,9
	db 45,9,38,9,43,9,40,9,43,9,47,9,38,9,43,9
	db 47,9,40,9,43,9,47,9,38,18,47,9,40,9,47,9
	db 50,27,50,18,45,9,40,18,50,27,50,18,45,9,40,9
	db 45,9,38,9,43,9,40,9,43,9,47,9,38,9,43,9
	db 47,9,40,9,43,9,47,9,38,18,47,9,39,9,47,9
	db 40,27,40,18,47,9,42,18,40,27,40,18,47,9,42,9
	db 47,9,255,9,45,9,40,9,45,9,48,9,42,18,45,9
	db 40,9,45,9,48,9,42,18,45,9,40,18,43,18,43,18
	db 42,18,40,18,47,9,43,9,45,9,48,18,40,9,47,18
	db 47,9,43,9,45,9,47,18,42,9,45,9,43,18,43,9
	db 47,9,50,9,43,18,255,18,50,18,47,18,50,18,47,18
	db 50,18,40,9,42,18,40,9,50,9,47,9,45,9,47,18
	db 42,45,255,9,45,9,47,9,42,9,45,9,47,18,42,9
	db 45,18,47,9,40,45,255,9,43,9,47,9,40,9,43,9
	db 47,18,42,18,45,9,47,9,42,9,45,9,47,18,42,18
	db 45,9,47,9,42,9,45,9,47,18,45,9,50,18,47,18
	db 50,18,47,18,50,18,40,9,42,18,40,9,50,9,47,9
	db 50,18,47,18,45,9,50,18,42,18,45,9,47,9,42,9
	db 45,9,47,18,38,18,40,9,38,18,38,18,40,9,38,18
	db 40,9,42,9,38,9,40,9,42,18,38,18,40,9,42,9
	db 38,9,255,9,40,18,33,9,38,18,45,18,45,18,45,18
	db 50,18,47,18,50,18,47,18,50,18,40,9,42,18,40,9
	db 50,9,47,9,45,9,47,18,42,45,255,9,45,9,47,9
	db 42,9,45,9,47,18,42,9,45,18,47,9,40,45,255,9
	db 43,9,47,9,40,9,43,9,47,18,42,18,45,9,47,9
	db 42,9,45,9,47,18,42,18,45,9,47,9,42,9,45,9
	db 47,18,45,9,50,18,47,18,50,18,47,18,50,18,40,9
	db 42,18,40,9,50,9,47,9,50,18,47,18,45,9,50,18
	db 42,18,45,9,47,9,42,9,45,9,47,18,38,18,40,9
	db 38,18,38,18,40,9,38,18,40,9,42,9,38,9,40,9
	db 42,18,38,18,40,9,42,9,38,9,255,9,40,18,33,9
	db 26,9,33,9,38,9,255,27,244,10,240,5,20,9,22,8
	db 18,9,15,17,17,9,25,17,20,9,22,9,18,8,15,17
	db 17,9,25,17,20,9,22,9,18,8,15,18,17,8,15,9
	db 26,9,25,17,255,17,25,18,20,8,21,9,22,9,18,17
	db 22,9,18,17,22,9,18,51,18,9,20,9,21,8,22,9
	db 18,9,20,8,22,18,17,8,20,18,18,52,20,8,21,9
	db 22,9,18,17,22,8,18,18,22,8,18,61,15,9,25,8
	db 24,9,15,9,18,8,22,18,20,8,18,9,15,9,20,51
	db 20,9,21,9,22,8,18,18,22,8,18,18,22,8,18,52
	db 18,9,20,9,21,8,22,9,18,9,20,8,22,18,17,8
	db 20,17,18,52,18,9,20,9,22,8,18,9,20,9,22,17
	db 18,9,20,8,18,9,22,9,18,8,20,9,22,17,18,9
	db 20,8,18,9,22,9,18,8,20,9,22,17,17,9,20,17
	db 18,52,20,9,21,9,22,8,18,18,22,8,18,18,22,8
	db 18,52,18,9,20,8,21,9,22,9,18,8,20,9,22,17
	db 17,9,20,17,18,52,20,9,21,9,22,8,18,17,22,9
	db 18,17,22,9,18,61,15,8,25,9,24,9,15,8,18,9
	db 22,17,20,9,18,9,15,8,20,52,20,9,21,8,22,9
	db 18,17,22,9,18,17,22,9,18,52,18,9,20,8,21,9
	db 22,9,18,8,20,9,22,17,17,9,20,17,18,52,18,9
	db 20,8,22,9,18,9,20,8,22,18,18,8,20,9,18,9
	db 22,8,18,9,20,9,22,17,18,9,20,8,18,9,22,8
	db 18,9,20,9,22,17,17,9,20,17,42,43,34,9,35,9
	db 36,8,37,18,39,8,37,18,34,8,35,9,36,9,37,17
	db 39,8,37,18,34,8,30,9,25,9,27,8,29,9,30,9
	db 32,8,34,9,32,9,30,8,32,9,25,9,34,8,35,9
	db 37,9,39,8,37,9,34,9,35,8,37,18,39,8,37,17
	db 34,9,35,9,36,8,37,18,39,8,37,18,37,8,39,9
	db 40,9,41,8,41,18,41,17,39,9,36,8,32,9,37,43
	db 34,9,35,8,36,9,37,17,39,9,37,17,34,9,35,9
	db 36,8,37,18,39,8,37,18,34,8,30,9,25,9,27,8
	db 29,9,30,9,32,8,34,9,32,9,30,8,32,9,30,43
	db 25,9,24,8,25,9,30,17,27,9,30,17,27,9,30,9
	db 27,8,25,9,30,9,34,8,37,18,34,8,30,9,25,9
	db 27,17,30,17,34,9,32,17,30,52,46,9,47,8,48,9
	db 49,17,51,9,49,17,46,9,47,9,48,8,49,18,51,8
	db 49,17,46,9,42,9,37,8,39,9,41,9,42,8,44,9
	db 46,9,44,8,42,9,44,9,37,8,46,9,47,9,49,8
	db 51,9,49,9,46,8,47,9,49,17,51,9,49,17,46,9
	db 47,8,48,9,49,17,51,9,49,17,49,9,51,9,40,8
	db 41,9,41,17,41,18,51,8,48,9,44,9,49,43,46,9
	db 47,8,48,9,49,17,51,9,49,17,46,9,47,8,48,9
	db 49,17,51,9,49,17,46,9,42,9,37,8,39,9,41,9
	db 42,8,44,9,46,9,44,8,42,9,44,9,42,43,37,8
	db 36,9,37,9,42,17,39,9,42,17,39,9,42,8,39,9
	db 37,9,42,8,46,9,49,17,46,9,42,9,37,8,39,18
	db 42,17,46,8,44,18,42,17,255,26,30,17,20,9,21,9
	db 22,8,30,18,22,8,30,18,22,8,30,52,30,9,44,8
	db 45,9,46,9,42,8,44,9,46,17,41,9,44,17,42,52
	db 20,9,21,9,22,8,30,18,22,8,30,18,22,8,30,61
	db 39,8,37,9,36,9,39,8,42,9,46,17,44,9,42,9
	db 39,8,44,52,20,9,21,9,22,8,30,18,22,8,30,17
	db 22,9,30,52,42,9,44,8,45,9,46,9,42,8,44,9
	db 46,17,41,9,44,17,42,52,42,9,44,8,46,9,42,9
	db 44,8,46,18,42,8,44,9,42,9,46,8,42,9,44,9
	db 46,17,42,9,44,8,42,9,46,9,42,8,44,9,46,17
	db 41,9,44,17,42,35,42,17,255,17,39,9,38,9,39,34
	db 42,18,44,69,35,9,34,8,35,35,39,17,40,61,37,8
	db 32,18,37,8,32,18,37,8,32,18,30,34,35,35,34,8
	db 38,9,41,9,46,17,44,9,41,8,42,9,39,35,40,34
	db 39,9,38,9,39,34,42,17,44,70,35,8,34,9,35,35
	db 39,17,40,61,37,8,32,17,37,9,32,17,37,9,32,17
	db 30,35,35,26,35,9,39,8,42,18,40,26,40,17,47,17
	db 41,9,42,8,44,9,46,9,47,8,49,9,51,9,50,8
	db 51,35,42,17,44,70,47,8,46,9,47,34,51,18,40,60
	db 49,9,44,17,49,9,44,17,49,9,44,17,42,35,47,34
	db 46,9,50,9,41,8,46,18,44,8,41,9,42,9,51,34
	db 40,35,51,9,50,8,51,35,42,17,44,69,47,9,46,9
	db 47,34,51,18,40,60,49,9,44,17,49,9,44,17,49,9
	db 44,17,42,35,47,26,47,8,51,9,42,17,40,26,40,18
	db 47,17,255,17,47,17,255,18,42,17,39,9,42,17,39,9
	db 42,8,39,9,37,9,42,8,46,9,49,17,46,9,42,9
	db 37,8,39,18,42,17,46,9,44,17,42,43,42,17,255,18
	db 35,17,34,9,35,17,34,9,35,17,255,9,39,8,44,9
	db 39,9,42,8,44,9,42,9,39,8,37,17,36,9,37,17
	db 36,9,37,17,255,9,42,9,46,8,42,9,44,9,46,8
	db 44,9,42,9,44,17,43,9,44,17,43,9,44,17,255,9
	db 47,8,51,9,47,8,49,9,51,9,49,8,47,9,42,9
	db 42,8,42,35,51,17,49,18,37,8,37,9,37,17,37,18
	db 35,17,34,9,35,17,34,8,35,18,255,8,39,9,44,9
	db 39,8,42,9,44,9,42,8,39,9,37,17,36,9,37,17
	db 36,9,37,17,255,9,42,9,46,8,42,9,44,9,46,8
	db 44,9,42,8,39,9,38,9,39,8,49,18,47,17,42,9
	db 46,8,45,9,46,9,51,17,42,9,49,8,46,9,42,17
	db 42,18,46,8,44,18,42,25,37,9,37,9,37,17,37,17
	db 23,18,22,8,23,18,22,8,23,18,255,8,15,9,20,9
	db 15,8,18,9,20,9,18,8,15,9,25,17,24,9,25,17
	db 24,9,25,17,255,9,18,8,22,9,18,9,20,8,22,9
	db 20,9,18,8,20,18,19,8,20,18,19,8,20,18,255,8
	db 23,9,27,9,23,8,25,9,27,8,25,9,23,9,30,8
	db 30,9,30,35,27,17,25,17,25,9,25,9,25,17,25,17
	db 23,18,22,8,23,18,22,8,23,17,255,9,15,9,20,8
	db 15,9,18,9,20,8,18,9,15,9,25,17,24,9,25,17
	db 24,9,25,17,255,9,18,8,22,9,18,9,20,8,22,9
	db 20,8,18,9,15,9,26,8,15,9,25,17,23,18,18,8
	db 22,9,21,9,22,8,27,18,30,8,25,9,22,9,18,17
	db 18,17,22,9,20,17,18,43,30,18,255,240,255,240,255,240
	db 255,197,0
_song1_v1__9:
	db 244,6,240,6,9,18,2,18,9,18,9,18,3,18,4,18
	db 9,18,9,18,9,18,2,18,9,18,9,18,3,18,4,18
	db 9,18,9,18,9,18,10,36,9,18,9,18,10,36,9,18
	db 255,18,2,18,255,18,2,18,255,18,14,18,255,18,14,18
	db 255,18,20,18,20,18,20,18,20,18,21,18,21,18,21,18
	db 21,18,22,18,22,18,21,18,21,18,21,18,21,18,14,18
	db 255,18,8,18,8,18,8,18,8,18,9,18,9,18,9,18
	db 9,18,10,18,10,18,9,18,9,18,9,18,9,18,14,18
	db 9,18,2,18,9,18,9,18,3,18,4,18,9,18,9,18
	db 9,18,2,18,9,18,9,18,3,18,4,18,9,18,9,18
	db 9,18,10,36,9,18,9,18,10,36,9,18,255,18,2,18
	db 255,18,2,18,255,18,14,18,255,18,14,18,255,18,20,18
	db 20,18,20,18,20,18,21,18,21,18,21,18,21,18,22,18
	db 22,18,21,18,21,18,21,18,21,18,14,18,255,18,8,18
	db 8,18,8,18,8,18,9,18,9,18,9,18,9,18,10,18
	db 10,18,9,18,9,18,21,18,21,18,14,18,15,18,16,18
	db 21,18,9,18,21,18,16,18,21,18,9,18,13,18,14,18
	db 21,18,9,18,21,18,14,18,21,18,14,18,15,18,16,18
	db 21,18,9,18,21,18,16,18,21,18,16,18,17,18,18,18
	db 21,18,9,18,21,18,14,18,21,18,14,18,15,18,16,18
	db 21,18,9,18,21,18,16,18,21,18,9,18,13,18,14,18
	db 21,18,9,18,21,18,14,18,14,18,13,18,12,18,11,18
	db 11,18,15,18,15,18,16,18,11,18,11,18,11,18,16,18
	db 16,18,9,18,13,18,14,18,21,18,21,18,15,18,16,18
	db 21,18,9,18,21,18,16,18,21,18,9,18,13,18,14,18
	db 21,18,9,18,21,18,14,18,21,18,14,18,15,18,16,18
	db 21,18,9,18,21,18,16,18,21,18,16,18,17,18,18,18
	db 21,18,9,18,21,18,14,18,21,18,14,18,15,18,16,18
	db 21,18,9,18,21,18,16,18,21,18,9,18,13,18,14,18
	db 21,18,9,18,21,18,14,18,14,18,13,18,12,18,11,18
	db 11,18,15,18,15,18,16,18,11,18,11,18,11,18,16,18
	db 16,18,9,18,13,18,14,18,14,18,14,18,9,18,14,18
	db 21,18,21,18,15,18,16,18,21,18,21,18,9,18,14,18
	db 21,18,21,18,15,18,16,18,21,18,21,18,9,18,10,36
	db 9,18,9,18,10,36,9,18,255,18,2,18,255,18,14,18
	db 255,18,14,18,255,18,14,18,255,18,20,18,20,18,20,18
	db 20,18,21,18,21,18,21,18,21,18,22,18,22,18,21,18
	db 21,18,21,18,21,18,14,18,255,18,20,18,20,18,20,18
	db 20,18,21,18,21,18,21,18,21,18,22,18,22,18,21,18
	db 21,18,21,18,21,18,14,18,255,18,9,18,14,18,12,18
	db 14,18,11,18,14,18,9,18,6,18,7,18,14,18,14,18
	db 14,18,11,18,14,18,7,18,8,18,9,18,14,18,12,18
	db 14,18,11,18,14,18,9,18,6,18,7,18,14,18,14,18
	db 14,18,11,18,14,18,7,18,6,18,4,18,16,18,8,18
	db 16,18,11,18,16,18,16,18,16,18,9,18,16,18,12,18
	db 16,18,9,18,16,18,12,18,16,18,13,9,16,18,19,9
	db 22,9,19,9,16,9,13,9,14,18,14,18,16,18,14,18
	db 21,18,21,18,14,18,14,18,19,18,14,18,14,18,8,18
	db 9,18,14,18,12,18,14,18,11,18,14,18,9,18,6,18
	db 7,18,14,18,2,18,14,18,11,18,14,18,7,18,8,18
	db 9,18,14,18,12,18,14,18,11,18,14,18,9,18,6,18
	db 7,18,14,18,2,18,14,18,11,18,14,18,7,18,6,18
	db 4,18,16,18,8,18,16,18,11,18,16,18,4,18,16,18
	db 9,18,16,18,12,18,16,18,9,18,16,18,12,18,16,18
	db 13,9,16,18,19,9,22,9,19,9,16,9,13,9,2,18
	db 14,18,4,18,14,18,9,18,9,18,14,18,14,18,19,18
	db 14,18,7,18,18,18,19,18,14,18,14,18,18,18,19,18
	db 14,18,16,18,17,18,18,18,14,18,14,18,9,18,14,18
	db 21,18,9,18,15,18,16,18,21,18,9,18,15,18,16,18
	db 21,18,9,18,13,18,14,18,21,18,9,18,21,18,14,18
	db 21,18,16,18,18,18,19,18,14,18,14,18,18,18,19,18
	db 14,18,16,18,17,18,18,18,14,18,14,18,9,18,14,18
	db 21,18,9,18,21,18,7,18,7,18,4,18,8,18,9,18
	db 21,18,9,18,10,18,11,18,11,18,13,18,13,18,14,18
	db 21,18,16,18,18,18,19,18,14,18,14,18,18,18,19,18
	db 14,18,16,18,17,18,18,18,14,18,14,18,9,18,14,18
	db 21,18,9,18,15,18,16,18,21,18,9,18,15,18,16,18
	db 21,18,9,18,13,18,14,18,21,18,9,18,21,18,14,18
	db 21,18,16,18,18,18,19,18,14,18,14,18,18,18,19,18
	db 14,18,16,18,17,18,18,18,14,18,14,18,9,18,14,18
	db 21,18,9,18,21,18,7,18,7,18,4,18,8,18,9,18
	db 21,18,9,18,10,18,11,18,11,18,13,18,13,18,14,18
	db 9,18,2,18,244,6,240,6,20,9,22,8,18,9,15,17
	db 17,9,13,17,20,9,22,9,18,8,15,17,17,9,13,17
	db 8,9,10,9,6,8,3,18,5,8,3,9,2,9,1,17
	db 255,17,1,18,13,17,6,17,10,18,1,17,13,17,11,17
	db 15,18,10,17,13,17,1,18,10,17,1,17,11,18,6,17
	db 10,17,10,18,13,17,6,17,10,17,1,18,13,17,11,17
	db 15,18,10,17,9,17,8,18,8,17,8,17,12,18,13,17
	db 1,17,3,17,5,18,6,17,10,17,1,18,13,17,11,17
	db 15,18,10,17,13,17,1,18,10,17,1,17,11,17,6,18
	db 10,17,13,17,255,18,6,17,13,17,4,18,13,17,3,17
	db 15,18,2,17,14,17,1,17,13,18,1,17,13,17,6,18
	db 1,17,3,17,5,18,6,17,10,17,1,18,13,17,11,17
	db 15,17,10,18,13,17,1,17,10,18,1,17,11,17,6,18
	db 10,17,10,17,13,18,6,17,10,17,1,17,13,18,11,17
	db 15,17,10,18,9,17,8,17,8,18,8,17,12,17,13,18
	db 1,17,3,17,5,17,6,18,10,17,1,17,13,18,11,17
	db 15,17,10,18,13,17,1,17,10,18,1,17,11,17,6,17
	db 10,18,13,17,255,17,6,18,13,17,4,17,13,18,3,17
	db 15,17,2,18,14,17,1,17,13,17,1,18,13,17,6,17
	db 1,18,6,17,255,17,6,18,13,17,1,17,13,18,6,17
	db 13,17,1,17,13,18,11,17,15,17,11,18,14,17,10,17
	db 13,18,1,17,13,17,6,18,13,17,1,17,13,17,6,18
	db 13,17,10,17,9,18,8,17,13,17,8,18,15,17,13,17
	db 11,18,10,17,8,17,6,17,13,18,1,17,13,17,6,18
	db 13,17,1,17,13,18,11,17,15,17,11,18,14,17,10,17
	db 13,17,6,18,16,17,11,17,11,18,12,17,12,17,13,18
	db 13,17,13,17,13,18,8,17,8,17,13,17,13,18,6,17
	db 1,17,10,18,8,17,6,17,13,18,1,17,13,17,6,18
	db 13,17,1,17,13,17,11,18,15,17,11,17,14,18,10,17
	db 13,17,1,18,13,17,6,17,13,18,1,17,13,17,6,17
	db 13,18,10,17,9,17,8,18,13,17,8,17,15,18,13,17
	db 11,17,10,18,8,17,6,17,13,17,1,18,13,17,6,17
	db 13,18,1,17,13,17,11,18,15,17,11,17,14,18,10,17
	db 13,17,6,17,16,18,11,17,11,17,12,18,12,17,13,17
	db 13,18,13,17,13,17,8,18,8,17,13,17,13,17,18,18
	db 13,17,6,17,255,18,18,17,22,17,13,18,13,17,11,17
	db 15,18,10,17,13,17,13,17,22,18,13,17,11,17,18,18
	db 22,17,22,17,13,18,18,17,22,17,13,18,13,17,11,17
	db 15,17,10,18,9,17,8,17,20,18,20,17,12,17,13,18
	db 13,17,15,17,17,18,18,17,22,17,13,17,13,18,11,17
	db 15,17,10,18,13,17,13,17,22,18,13,17,11,17,18,18
	db 22,17,13,17,255,17,18,18,13,17,16,17,13,18,15,17
	db 15,17,14,18,14,17,13,17,13,18,13,17,13,17,18,17
	db 13,18,6,17,255,17,11,18,15,17,18,17,15,18,16,17
	db 16,17,11,18,16,17,8,17,15,17,15,18,15,17,13,17
	db 16,18,20,17,16,17,16,18,16,17,13,17,14,18,15,17
	db 15,17,20,17,15,18,22,17,17,17,14,18,17,17,15,35
	db 13,17,18,17,11,18,15,17,18,17,15,17,16,18,16,17
	db 11,17,16,18,8,17,15,17,15,18,15,17,13,17,16,18
	db 20,17,16,17,16,17,16,18,13,17,14,17,15,9,11,9
	db 10,8,8,9,7,35,6,17,15,17,18,18,6,17,11,17
	db 255,52,11,35,15,34,18,35,15,35,16,34,16,35,11,34
	db 16,35,8,35,15,34,15,35,15,34,13,35,16,35,20,34
	db 16,35,16,35,16,34,13,35,14,34,15,35,15,35,20,34
	db 15,35,22,34,17,35,14,35,17,34,15,35,13,17,18,18
	db 11,17,15,17,18,17,15,18,16,17,16,17,11,18,16,17
	db 8,17,15,18,15,17,15,17,13,18,16,17,20,17,16,17
	db 16,18,16,17,13,17,14,18,15,8,11,9,10,9,8,8
	db 7,35,6,17,15,18,18,17,6,17,11,17,255,18,11,17
	db 255,17,11,18,11,17,12,17,12,18,13,17,13,17,13,18
	db 13,17,20,17,20,17,13,18,13,17,18,35,6,17,255,17
	db 11,18,11,17,15,17,11,18,11,17,11,17,15,17,11,18
	db 18,17,22,17,13,18,22,17,18,17,22,18,13,17,22,17
	db 13,18,11,17,17,17,11,17,13,18,11,17,20,17,11,18
	db 21,17,21,35,21,17,22,17,255,52,11,17,11,18,15,17
	db 11,17,11,18,11,17,15,17,11,18,18,17,22,17,13,18
	db 22,17,18,17,22,17,13,18,22,17,11,17,8,18,10,17
	db 11,17,13,18,13,17,12,17,13,18,15,17,8,17,13,17
	db 17,18,18,17,255,52,11,35,11,34,15,35,11,34,11,35
	db 11,35,15,34,11,35,18,35,22,34,13,35,22,34,18,35
	db 22,35,13,34,22,35,13,34,11,35,17,35,11,34,13,35
	db 11,35,20,34,11,35,21,34,21,35,21,17,22,18,255,52
	db 11,17,11,17,15,17,11,18,11,17,11,17,15,18,11,17
	db 18,17,22,18,13,17,22,17,18,18,22,17,13,17,22,17
	db 11,18,20,17,22,17,11,18,13,17,13,17,12,18,13,17
	db 15,17,20,18,13,17,17,17,18,17,13,18,18,17,0
_song1_v2__9:
	db 244,6,240,8,21,18,14,18,18,18,18,18,15,18,16,18
	db 19,18,19,18,21,18,14,18,18,18,18,18,15,18,16,18
	db 19,18,19,18,21,18,22,36,21,18,21,18,22,36,21,18
	db 255,162,29,18,29,18,29,18,29,18,30,18,30,18,30,18
	db 30,18,29,18,29,18,30,18,30,18,30,18,31,18,30,18
	db 255,18,17,18,17,18,17,18,17,18,18,18,18,18,18,18
	db 18,18,17,18,17,18,18,18,18,18,18,18,19,18,18,18
	db 21,18,14,18,18,18,18,18,15,18,16,18,19,18,19,18
	db 21,18,14,18,18,18,18,18,15,18,16,18,19,18,19,18
	db 21,18,22,36,21,18,21,18,22,36,21,18,255,162,29,18
	db 29,18,29,18,29,18,30,18,30,18,30,18,30,18,29,18
	db 29,18,30,18,30,18,30,18,31,18,30,18,255,18,17,18
	db 17,18,17,18,17,18,18,18,18,18,18,18,18,18,17,18
	db 17,18,18,18,18,18,30,18,31,18,30,18,27,18,28,18
	db 31,18,21,18,31,18,28,18,31,18,21,18,25,18,26,18
	db 30,18,21,18,30,18,26,18,30,18,26,18,27,18,28,18
	db 31,18,21,18,31,18,28,18,31,18,28,18,29,18,30,18
	db 30,18,21,18,30,18,26,18,30,18,26,18,27,18,28,18
	db 31,18,21,18,31,18,28,18,31,18,21,18,25,18,26,18
	db 30,18,21,18,30,18,26,18,26,18,25,18,24,18,23,18
	db 23,18,27,18,27,18,28,18,31,18,31,18,31,18,28,18
	db 28,18,21,18,25,18,26,18,30,18,30,18,27,18,28,18
	db 31,18,21,18,31,18,28,18,31,18,21,18,25,18,26,18
	db 30,18,21,18,30,18,26,18,30,18,26,18,27,18,28,18
	db 31,18,21,18,31,18,28,18,31,18,28,18,29,18,30,18
	db 30,18,21,18,30,18,26,18,30,18,26,18,27,18,28,18
	db 31,18,21,18,31,18,28,18,31,18,21,18,25,18,26,18
	db 30,18,21,18,30,18,26,18,26,18,25,18,24,18,23,18
	db 23,18,27,18,27,18,28,18,31,18,31,18,31,18,28,18
	db 28,18,21,18,25,18,26,18,33,18,33,18,21,18,26,18
	db 30,18,30,18,27,18,28,18,31,18,31,18,21,18,26,18
	db 30,18,30,18,27,18,28,18,31,18,31,18,21,18,22,36
	db 21,18,21,18,22,36,21,18,255,162,29,18,29,18,29,18
	db 29,18,30,18,30,18,30,18,30,18,29,18,29,18,30,18
	db 30,18,30,18,31,18,30,18,255,18,29,18,29,18,29,18
	db 29,18,30,18,30,18,30,18,30,18,29,18,29,18,30,18
	db 30,18,30,18,31,18,30,18,255,18,21,18,36,18,24,18
	db 36,18,23,18,36,18,21,18,18,18,19,18,35,18,26,18
	db 35,18,23,18,35,18,19,18,20,18,21,18,36,18,24,18
	db 36,18,23,18,36,18,21,18,18,18,19,18,35,18,26,18
	db 35,18,23,18,35,18,19,18,18,18,16,18,38,18,20,18
	db 38,18,23,18,38,18,28,18,38,18,21,18,36,18,24,18
	db 36,18,21,18,36,18,24,18,36,18,255,72,26,18,35,18
	db 255,18,32,18,31,18,31,18,30,18,30,18,31,18,35,18
	db 35,18,20,18,21,18,24,18,24,18,24,18,23,18,24,18
	db 21,18,18,18,19,18,23,18,14,18,23,18,23,18,23,18
	db 19,18,20,18,21,18,24,18,24,18,24,18,23,18,24,18
	db 21,18,18,18,19,18,23,18,14,18,23,18,23,18,23,18
	db 19,18,18,18,16,18,26,18,20,18,26,18,23,18,26,18
	db 16,18,26,18,21,18,24,18,24,18,24,18,21,18,24,18
	db 24,18,24,18,255,72,14,18,23,18,255,18,20,18,19,18
	db 19,18,18,18,18,18,31,18,26,18,19,18,30,18,31,18
	db 35,18,35,18,30,18,31,18,35,18,28,18,29,18,30,18
	db 33,18,33,18,21,18,26,18,30,18,21,18,27,18,28,18
	db 31,18,21,18,27,18,28,18,31,18,21,18,25,18,26,18
	db 30,18,21,18,30,18,26,18,30,18,28,18,30,18,31,18
	db 35,18,35,18,30,18,31,18,35,18,28,18,29,18,30,18
	db 33,18,33,18,21,18,26,18,30,18,21,18,30,18,19,18
	db 19,18,16,18,20,18,21,18,30,18,21,18,22,18,23,18
	db 23,18,25,18,25,18,26,18,30,18,28,18,30,18,31,18
	db 35,18,35,18,30,18,31,18,35,18,28,18,29,18,30,18
	db 33,18,33,18,21,18,26,18,30,18,21,18,27,18,28,18
	db 31,18,21,18,27,18,28,18,31,18,21,18,25,18,26,18
	db 30,18,21,18,30,18,26,18,30,18,28,18,30,18,31,18
	db 35,18,35,18,30,18,31,18,35,18,28,18,29,18,30,18
	db 33,18,33,18,21,18,26,18,30,18,21,18,30,18,19,18
	db 19,18,16,18,20,18,21,18,30,18,21,18,22,18,23,18
	db 23,18,25,18,25,18,26,18,21,18,14,18,244,6,240,8
	db 255,240,255,2,13,18,17,17,255,17,18,18,13,17,18,17
	db 23,17,18,18,22,17,18,17,255,18,18,17,255,17,17,18
	db 255,17,18,17,18,18,17,17,255,17,18,17,13,18,18,17
	db 23,17,18,18,22,17,21,17,20,18,18,17,255,17,18,18
	db 17,17,13,17,15,17,17,18,255,17,18,17,13,18,18,17
	db 23,17,18,18,22,17,18,17,255,18,18,17,255,17,17,17
	db 255,18,18,17,22,17,255,18,18,17,22,17,16,18,22,17
	db 15,17,23,18,14,17,23,17,13,17,22,18,255,17,17,17
	db 18,18,13,17,15,17,17,18,255,17,18,17,13,18,18,17
	db 23,17,18,17,22,18,18,17,255,17,18,18,255,17,17,17
	db 255,18,18,17,18,17,17,18,255,17,18,17,13,17,18,18
	db 23,17,18,17,22,18,21,17,20,17,18,18,255,17,18,17
	db 17,18,13,17,15,17,17,17,255,18,18,17,13,17,18,18
	db 23,17,18,17,22,18,18,17,255,17,18,18,255,17,17,17
	db 255,17,18,18,22,17,255,17,18,18,22,17,16,17,22,18
	db 15,17,23,17,14,18,23,17,13,17,22,17,255,18,17,17
	db 18,17,13,18,18,17,255,17,18,18,22,17,255,17,22,18
	db 255,17,22,17,255,17,22,18,255,17,23,17,255,18,23,17
	db 255,17,22,18,255,17,22,17,255,18,22,17,255,17,22,17
	db 255,18,22,17,255,52,20,17,255,18,20,17,20,17,23,18
	db 22,17,20,17,18,17,22,18,255,17,22,17,255,18,22,17
	db 255,17,22,18,255,17,23,17,255,18,23,17,255,17,22,17
	db 255,18,22,17,23,17,23,18,21,17,21,17,22,18,22,17
	db 22,17,22,18,18,17,15,17,17,17,17,18,18,17,13,17
	db 22,18,20,17,18,17,22,18,255,17,22,17,255,18,22,17
	db 255,17,22,17,255,18,23,17,255,17,23,18,255,17,22,17
	db 255,18,22,17,255,17,22,18,255,17,22,17,255,17,22,18
	db 255,52,20,17,255,17,20,18,20,17,23,17,22,18,20,17
	db 18,17,22,17,255,18,22,17,255,17,22,18,255,17,22,17
	db 255,18,23,17,255,17,23,18,255,17,22,17,255,17,22,18
	db 23,17,23,17,21,18,21,17,22,17,22,18,22,17,22,17
	db 18,18,15,17,17,17,17,17,30,18,25,17,18,17,255,35
	db 30,17,25,18,30,17,23,17,30,18,22,17,30,17,255,17
	db 30,18,255,17,29,17,255,18,30,17,30,17,29,18,255,17
	db 30,17,25,18,30,17,23,17,30,17,22,18,21,17,20,17
	db 30,18,255,17,30,17,29,18,25,17,27,17,29,18,255,17
	db 30,17,25,17,30,18,23,17,30,17,22,18,30,17,255,17
	db 30,18,255,17,29,17,255,18,30,17,34,17,255,17,30,18
	db 34,17,28,17,34,18,27,17,35,17,26,18,35,17,25,17
	db 34,18,255,17,29,17,30,17,25,18,18,17,255,35,35,17
	db 255,17,35,18,255,17,35,17,255,18,35,17,255,17,35,17
	db 255,18,35,17,255,17,32,18,255,17,32,17,28,18,32,17
	db 25,17,26,18,27,17,35,17,255,17,35,18,255,17,34,17
	db 255,18,34,17,34,35,34,34,255,18,35,17,255,17,35,17
	db 255,18,35,17,255,17,35,18,255,17,35,17,255,18,35,17
	db 255,17,32,18,255,17,32,17,28,17,32,18,25,17,26,17
	db 27,9,23,9,22,8,20,9,19,35,18,17,35,17,30,18
	db 18,17,23,17,255,87,35,34,255,35,35,35,255,34,35,35
	db 255,34,35,35,255,35,35,34,255,35,35,34,255,35,32,35
	db 255,34,32,35,28,35,32,34,25,35,26,34,27,35,35,35
	db 255,34,35,35,255,34,34,35,255,35,34,34,34,35,34,35
	db 255,17,35,17,255,17,35,18,255,17,35,17,255,18,35,17
	db 255,17,35,18,255,17,35,17,255,18,32,17,255,17,32,17
	db 28,18,32,17,25,17,26,18,27,8,23,9,22,9,20,8
	db 19,35,18,17,35,18,30,17,18,17,23,17,255,18,23,17
	db 255,17,35,18,35,17,33,17,33,18,34,17,34,17,34,18
	db 34,17,30,17,27,17,29,18,29,17,30,35,18,17,255,35
	db 27,17,255,17,27,18,255,17,27,17,255,17,27,18,255,17
	db 30,17,255,18,30,17,255,17,30,18,255,17,30,17,255,18
	db 29,17,255,17,29,17,255,18,29,17,255,17,29,18,30,17
	db 30,35,30,17,30,17,255,69,27,18,255,17,27,17,255,18
	db 27,17,255,17,27,18,255,17,30,17,255,18,30,17,255,17
	db 30,17,255,18,30,17,23,17,20,18,22,17,23,17,25,18
	db 34,17,33,17,34,18,27,17,20,17,25,17,29,18,30,17
	db 255,87,39,34,255,35,39,34,255,35,39,35,255,34,39,35
	db 255,35,30,34,255,35,30,34,255,35,30,35,255,34,30,35
	db 255,34,29,35,255,35,29,34,255,35,29,35,255,34,29,35
	db 30,34,30,35,30,17,30,18,255,69,39,17,255,17,39,18
	db 255,17,39,17,255,18,39,17,255,17,30,18,255,17,30,17
	db 255,18,30,17,255,17,30,17,35,18,32,17,34,17,35,18
	db 37,17,34,17,33,18,34,17,39,17,32,18,37,17,29,17
	db 30,17,37,18,30,17,0
_song1_v3__9:
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
	db 6,9,6,9,244,1,240,5,3,17,244,2,240,12,5,18
	db 244,3,240,7,6,8,244,2,240,12,5,9,5,17,244,1
	db 240,5,3,18,244,2,240,12,5,17,244,3,240,7,6,8
	db 244,2,240,12,5,9,5,17,244,1,240,5,3,18,244,2
	db 240,12,5,17,244,3,240,7,6,9,244,2,240,12,5,8
	db 5,18,244,1,240,5,3,17,244,2,240,12,5,17,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,17,244,1,240,5
	db 3,17,244,2,240,12,5,18,244,3,240,7,6,8,244,2
	db 240,12,5,9,5,17,244,1,240,5,3,17,244,2,240,12
	db 5,18,244,3,240,7,6,8,244,2,240,12,5,9,5,17
	db 244,1,240,5,3,18,244,2,240,12,5,17,244,3,240,7
	db 6,9,244,2,240,12,5,8,5,18,244,1,240,5,3,17
	db 244,3,240,7,6,17,6,9,6,9,6,8,6,9,244,1
	db 240,5,3,17,244,2,240,12,5,17,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,17,244,1,240,5,3,17,244,2
	db 240,12,5,18,244,3,240,7,6,8,244,2,240,12,5,9
	db 5,17,244,1,240,5,3,18,244,2,240,12,5,17,244,3
	db 240,7,6,9,244,2,240,12,5,8,5,18,244,1,240,5
	db 3,17,244,2,240,12,5,17,244,3,240,7,6,9,244,2
	db 240,12,5,8,5,18,244,1,240,5,3,17,244,2,240,12
	db 5,17,244,3,240,7,6,9,244,2,240,12,5,9,5,17
	db 244,1,240,5,3,17,244,2,240,12,5,18,244,3,240,7
	db 6,8,244,2,240,12,5,9,5,17,244,1,240,5,3,18
	db 244,2,240,12,5,17,244,3,240,7,6,9,244,2,240,12
	db 5,8,5,17,244,1,240,5,3,18,244,3,240,7,6,17
	db 6,9,6,8,6,9,6,9,244,1,240,5,3,17,244,2
	db 240,12,5,17,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,17,244,1,240,5,3,17,244,2,240,12,5,18,244,3
	db 240,7,6,8,244,2,240,12,5,9,5,17,244,1,240,5
	db 3,17,244,2,240,12,5,18,244,3,240,7,6,8,244,2
	db 240,12,5,9,5,17,244,1,240,5,3,18,244,2,240,12
	db 5,17,244,3,240,7,6,9,244,2,240,12,5,8,5,18
	db 244,1,240,5,3,17,244,2,240,12,5,17,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,17,244,1,240,5,3,17
	db 244,2,240,12,5,17,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,17,244,1,240,5,3,17,244,2,240,12,5,18
	db 244,3,240,7,6,8,244,2,240,12,5,9,5,17,244,1
	db 240,5,3,18,244,3,240,7,6,17,6,9,6,8,6,9
	db 6,9,244,1,240,5,3,17,244,2,240,12,5,17,244,3
	db 240,7,6,9,244,2,240,12,5,8,5,18,244,1,240,5
	db 3,17,244,2,240,12,5,17,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,17,244,1,240,5,3,17,244,2,240,12
	db 5,18,244,3,240,7,6,8,244,2,240,12,5,9,5,17
	db 244,1,240,5,3,18,244,2,240,12,5,17,244,3,240,7
	db 6,8,244,2,240,12,5,9,5,17,244,1,240,5,3,18
	db 244,2,240,12,5,17,244,3,240,7,6,9,244,2,240,12
	db 5,8,5,18,244,1,240,5,3,17,244,2,240,12,5,17
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,17,244,1
	db 240,5,3,17,244,2,240,12,5,18,244,3,240,7,6,8
	db 244,2,240,12,5,9,5,17,244,1,240,5,3,17,244,3
	db 240,7,6,18,6,8,6,9,6,9,6,8,244,1,240,5
	db 3,18,244,2,240,12,5,17,244,3,240,7,6,9,244,2
	db 240,12,5,8,5,18,244,1,240,5,3,17,244,2,240,12
	db 5,17,244,3,240,7,6,9,244,2,240,12,5,9,5,17
	db 244,1,240,5,3,17,244,2,240,12,5,17,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,17,244,1,240,5,3,17
	db 244,2,240,12,5,18,244,3,240,7,6,8,244,2,240,12
	db 5,9,5,17,244,1,240,5,3,18,244,2,240,12,5,17
	db 244,3,240,7,6,9,244,2,240,12,5,8,5,18,244,1
	db 240,5,3,17,244,2,240,12,5,17,244,3,240,7,6,9
	db 244,2,240,12,5,8,5,18,244,1,240,5,3,17,244,2
	db 240,12,5,17,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,17,244,1,240,5,3,17,244,3,240,7,6,18,6,8
	db 6,9,6,9,6,8,244,1,240,5,3,18,244,2,240,12
	db 5,17,244,3,240,7,6,8,244,2,240,12,5,9,5,17
	db 244,1,240,5,3,18,244,2,240,12,5,17,244,3,240,7
	db 6,9,244,2,240,12,5,8,5,18,244,1,240,5,3,17
	db 244,2,240,12,5,17,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,17,244,1,240,5,3,17,244,2,240,12,5,18
	db 244,3,240,7,6,8,244,2,240,12,5,9,5,17,244,1
	db 240,5,3,17,244,2,240,12,5,18,244,3,240,7,6,8
	db 244,2,240,12,5,9,5,17,244,1,240,5,3,18,244,2
	db 240,12,5,17,244,3,240,7,6,9,244,2,240,12,5,8
	db 5,18,244,1,240,5,3,17,244,2,240,12,5,17,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,17,244,1,240,5
	db 3,17,244,3,240,7,6,17,6,9,6,9,6,8,6,9
	db 244,1,240,5,3,17,244,2,240,12,5,18,244,3,240,7
	db 6,8,244,2,240,12,5,9,5,17,244,1,240,5,3,18
	db 244,2,240,12,5,17,244,3,240,7,6,9,244,2,240,12
	db 5,8,5,18,244,1,240,5,3,17,244,2,240,12,5,17
	db 244,3,240,7,6,9,244,2,240,12,5,8,5,18,244,1
	db 240,5,3,17,244,2,240,12,5,17,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,17,244,1,240,5,3,17,244,2
	db 240,12,5,18,244,3,240,7,6,8,244,2,240,12,5,9
	db 5,17,244,1,240,5,3,18,244,2,240,12,5,17,244,3
	db 240,7,6,8,244,2,240,12,5,9,5,17,244,1,240,5
	db 3,18,244,2,240,12,5,17,244,3,240,7,6,9,244,2
	db 240,12,5,8,5,18,244,1,240,5,3,17,244,3,240,7
	db 6,17,6,9,6,9,6,8,6,9,244,1,240,5,3,17
	db 244,2,240,12,5,18,244,3,240,7,6,8,244,2,240,12
	db 5,9,5,17,244,1,240,5,3,17,244,2,240,12,5,18
	db 244,3,240,7,6,8,244,2,240,12,5,9,5,17,244,1
	db 240,5,3,18,244,2,240,12,5,17,244,3,240,7,6,9
	db 244,2,240,12,5,8,5,18,244,1,240,5,3,17,244,2
	db 240,12,5,17,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,17,244,1,240,5,3,17,244,2,240,12,5,17,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,17,244,1,240,5
	db 3,17,244,2,240,12,5,18,244,3,240,7,6,8,244,2
	db 240,12,5,9,5,17,244,1,240,5,3,18,244,2,240,12
	db 5,17,244,3,240,7,6,9,244,2,240,12,5,8,5,18
	db 244,1,240,5,3,17,244,3,240,7,6,17,6,9,6,8
	db 6,9,6,9,244,1,240,5,3,17,244,2,240,12,5,17
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,17,244,1
	db 240,5,3,17,244,2,240,12,5,18,244,3,240,7,6,8
	db 244,2,240,12,5,9,5,17,244,1,240,5,3,18,244,2
	db 240,12,5,17,244,3,240,7,6,8,244,2,240,12,5,9
	db 5,17,244,1,240,5,3,18,244,2,240,12,5,17,244,3
	db 240,7,6,9,244,2,240,12,5,8,5,18,244,1,240,5
	db 3,17,244,2,240,12,5,17,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,17,244,1,240,5,3,17,244,2,240,12
	db 5,18,244,3,240,7,6,8,244,2,240,12,5,9,5,17
	db 244,1,240,5,3,17,244,2,240,12,5,18,244,3,240,7
	db 6,8,244,2,240,12,5,9,5,17,244,1,240,5,3,18
	db 244,3,240,7,6,17,6,9,6,8,6,9,6,9,244,1
	db 240,5,3,17,244,2,240,12,5,17,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,17,244,1,240,5,3,17,244,2
	db 240,12,5,17,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,17,244,1,240,5,3,17,244,2,240,12,5,18,244,3
	db 240,7,6,8,244,2,240,12,5,9,5,17,244,1,240,5
	db 3,18,244,2,240,12,5,17,244,3,240,7,6,9,244,2
	db 240,12,5,8,5,18,244,1,240,5,3,17,244,2,240,12
	db 5,17,244,3,240,7,6,9,244,2,240,12,5,8,5,18
	db 244,1,240,5,3,17,244,2,240,12,5,17,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,17,244,1,240,5,3,17
	db 244,2,240,12,5,18,244,3,240,7,6,8,244,2,240,12
	db 5,9,5,17,244,1,240,5,3,18,244,3,240,7,6,17
	db 6,9,6,8,6,9,6,8,244,1,240,5,3,18,244,2
	db 240,12,5,17,244,3,240,7,6,9,244,2,240,12,5,8
	db 5,18,244,1,240,5,3,17,244,2,240,12,5,17,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,17,244,1,240,5
	db 3,17,244,2,240,12,5,18,244,3,240,7,6,8,244,2
	db 240,12,5,9,5,17,244,1,240,5,3,17,244,2,240,12
	db 5,18,244,3,240,7,6,8,244,2,240,12,5,9,5,17
	db 244,1,240,5,3,18,244,2,240,12,5,17,244,3,240,7
	db 6,9,244,2,240,12,5,8,5,18,244,1,240,5,3,17
	db 244,2,240,12,5,17,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,17,244,1,240,5,3,17,244,2,240,12,5,17
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,17,244,1
	db 240,5,3,17,244,3,240,7,6,18,6,8,6,9,6,9
	db 6,8,244,1,240,5,3,18,244,2,240,12,5,17,244,3
	db 240,7,6,9,244,2,240,12,5,8,5,18,244,1,240,5
	db 3,17,244,2,240,12,5,17,244,3,240,7,6,9,244,2
	db 240,12,5,8,5,18,244,1,240,5,3,17,244,2,240,12
	db 5,17,244,3,240,7,6,9,244,2,240,12,5,9,5,17
	db 244,1,240,5,3,17,244,2,240,12,5,18,244,3,240,7
	db 6,8,244,2,240,12,5,9,5,17,244,1,240,5,3,18
	db 244,2,240,12,5,17,244,3,240,7,6,9,244,2,240,12
	db 5,8,5,17,244,1,240,5,3,18,244,2,240,12,5,17
	db 244,3,240,7,6,9,244,2,240,12,5,8,5,18,244,1
	db 240,5,3,17,244,2,240,12,5,17,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,17,244,1,240,5,3,17,244,3
	db 240,7,6,18,6,8,6,9,6,9,6,8,244,1,240,5
	db 3,17,244,2,240,12,5,18,244,3,240,7,6,8,244,2
	db 240,12,5,9,5,17,244,1,240,5,3,18,244,2,240,12
	db 5,17,244,3,240,7,6,9,244,2,240,12,5,8,5,18
	db 244,1,240,5,3,17,244,2,240,12,5,17,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,17,244,1,240,5,3,17
	db 244,2,240,12,5,17,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,17,244,1,240,5,3,17,244,2,240,12,5,18
	db 244,3,240,7,6,8,244,2,240,12,5,9,5,17,244,1
	db 240,5,3,18,244,2,240,12,5,17,244,3,240,7,6,9
	db 244,2,240,12,5,8,5,18,244,1,240,5,3,17,244,2
	db 240,12,5,17,244,3,240,7,6,9,244,2,240,12,5,8
	db 5,18,244,1,240,5,3,17,244,3,240,7,6,17,6,9
	db 6,9,6,8,6,9,244,1,240,5,3,17,244,2,240,12
	db 5,18,244,3,240,7,6,8,244,2,240,12,5,9,5,17
	db 244,1,240,5,3,18,244,2,240,12,5,17,244,3,240,7
	db 6,9,244,2,240,12,5,8,5,17,244,1,240,5,3,18
	db 244,2,240,12,5,17,244,3,240,7,6,9,244,2,240,12
	db 5,8,5,18,244,1,240,5,3,17,244,2,240,12,5,17
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,17,244,1
	db 240,5,3,17,244,2,240,12,5,18,244,3,240,7,6,8
	db 244,2,240,12,5,9,5,17,244,1,240,5,3,17,244,2
	db 240,12,5,18,244,3,240,7,6,8,244,2,240,12,5,9
	db 5,17,244,1,240,5,3,18,244,2,240,12,5,17,244,3
	db 240,7,6,9,244,2,240,12,5,8,5,18,244,1,240,5
	db 3,17,244,3,240,7,6,17,6,9,6,9,6,8,6,9
	db 244,1,240,5,3,17,244,2,240,12,5,17,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,17,244,1,240,5,3,17
	db 244,2,240,12,5,18,244,3,240,7,6,8,244,2,240,12
	db 5,9,5,17,244,1,240,5,3,18,244,2,240,12,5,17
	db 244,3,240,7,6,9,244,2,240,12,5,8,5,18,244,1
	db 240,5,3,17,244,2,240,12,5,17,244,3,240,7,6,9
	db 244,2,240,12,5,8,5,18,244,1,240,5,3,17,244,2
	db 240,12,5,17,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,17,244,1,240,5,3,17,244,2,240,12,5,18,244,3
	db 240,7,6,8,244,2,240,12,5,9,5,17,244,1,240,5
	db 3,18,244,2,240,12,5,17,244,3,240,7,6,9,244,2
	db 240,12,5,8,5,17,244,1,240,5,3,18,244,3,240,7
	db 6,17,6,9,6,8,6,9,6,9,244,1,240,5,3,17
	db 244,2,240,12,5,17,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,17,244,1,240,5,3,17,244,2,240,12,5,18
	db 244,3,240,7,6,8,244,2,240,12,5,9,5,17,244,1
	db 240,5,3,17,244,2,240,12,5,18,244,3,240,7,6,8
	db 244,2,240,12,5,9,5,17,244,1,240,5,3,18,244,2
	db 240,12,5,17,244,3,240,7,6,9,244,2,240,12,5,8
	db 5,18,244,1,240,5,3,17,244,2,240,12,5,17,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,17,244,1,240,5
	db 3,17,244,2,240,12,5,17,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,17,244,1,240,5,3,17,244,2,240,12
	db 5,18,244,3,240,7,6,8,244,2,240,12,5,9,5,17
	db 244,1,240,5,3,18,244,3,240,7,6,17,6,9,6,8
	db 6,9,6,9,244,1,240,5,3,17,244,2,240,12,5,17
	db 244,3,240,7,6,9,244,2,240,12,5,8,5,18,244,1
	db 240,5,3,17,244,2,240,12,5,17,244,3,240,7,6,9
	db 244,2,240,12,5,9,5,17,244,1,240,5,3,17,244,2
	db 240,12,5,18,244,3,240,7,6,8,244,2,240,12,5,9
	db 5,17,244,1,240,5,3,18,244,2,240,12,5,17,244,3
	db 240,7,6,9,244,2,240,12,5,8,5,17,244,1,240,5
	db 3,18,244,2,240,12,5,17,244,3,240,7,6,9,244,2
	db 240,12,5,8,5,18,244,1,240,5,3,17,244,2,240,12
	db 5,17,244,3,240,7,6,9,244,2,240,12,5,9,5,17
	db 244,1,240,5,3,17,244,2,240,12,5,18,244,3,240,7
	db 6,8,244,2,240,12,5,9,5,17,244,1,240,5,3,17
	db 244,3,240,7,6,18,6,8,6,9,6,9,6,8,244,1
	db 240,5,3,18,244,2,240,12,5,17,244,3,240,7,6,9
	db 244,2,240,12,5,8,5,18,244,1,240,5,3,17,244,2
	db 240,12,5,17,244,3,240,7,6,9,244,2,240,12,5,9
	db 5,17,244,1,240,5,3,17,244,2,240,12,5,17,244,3
	db 240,7,6,9,244,2,240,12,5,9,5,17,244,1,240,5
	db 3,17,244,2,240,12,5,18,244,3,240,7,6,8,244,2
	db 240,12,5,9,5,17,244,1,240,5,3,18,244,2,240,12
	db 5,17,244,3,240,7,6,9,244,2,240,12,5,8,5,18
	db 244,1,240,5,3,17,244,2,240,12,5,17,244,3,240,7
	db 6,9,244,2,240,12,5,8,5,18,244,1,240,5,3,17
	db 244,2,240,12,5,17,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,17,244,1,240,5,3,17,244,3,240,7,6,18
	db 6,8,6,9,6,9,6,8,244,1,240,5,3,18,244,2
	db 240,12,5,17,244,3,240,7,6,9,244,2,240,12,5,8
	db 5,17,244,1,240,5,3,18,244,2,240,12,5,17,244,3
	db 240,7,6,9,244,2,240,12,5,8,5,18,244,1,240,5
	db 3,17,244,2,240,12,5,17,244,3,240,7,6,9,244,2
	db 240,12,5,9,5,17,244,1,240,5,3,17,244,2,240,12
	db 5,18,244,3,240,7,6,8,244,2,240,12,5,9,5,17
	db 244,1,240,5,3,17,244,2,240,12,5,18,244,3,240,7
	db 6,8,244,2,240,12,5,9,5,17,244,1,240,5,3,18
	db 244,2,240,12,5,17,244,3,240,7,6,9,244,2,240,12
	db 5,8,5,18,244,1,240,5,3,17,244,2,240,12,5,17
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,17,244,1
	db 240,5,3,17,244,3,240,7,6,17,6,9,6,9,6,8
	db 6,9,244,1,240,5,3,17,244,2,240,12,5,18,244,3
	db 240,7,6,8,244,2,240,12,5,9,5,17,244,1,240,5
	db 3,18,244,2,240,12,5,17,244,3,240,7,6,9,244,2
	db 240,12,5,8,5,18,244,1,240,5,3,17,244,2,240,12
	db 5,17,244,3,240,7,6,9,244,2,240,12,5,8,5,18
	db 244,1,240,5,3,17,244,2,240,12,5,17,244,3,240,7
	db 6,9,244,2,240,12,5,9,5,17,244,1,240,5,3,17
	db 244,2,240,12,5,18,244,3,240,7,6,8,244,2,240,12
	db 5,9,5,17,244,1,240,5,3,18,244,2,240,12,5,17
	db 244,3,240,7,6,8,244,2,240,12,5,9,5,17,244,1
	db 240,5,3,18,244,2,240,12,5,17,244,3,240,7,6,9
	db 244,2,240,12,5,8,5,18,244,1,240,5,3,17,244,3
	db 240,7,6,17,6,9,6,9,6,8,6,9,244,1,240,5
	db 3,17,244,2,240,12,5,18,244,3,240,7,6,8,244,2
	db 240,12,5,9,5,17,244,1,240,5,3,17,244,2,240,12
	db 5,18,244,3,240,7,6,8,244,2,240,12,5,9,5,17
	db 244,1,240,5,3,18,244,2,240,12,5,17,244,3,240,7
	db 6,9,244,2,240,12,5,8,5,18,244,1,240,5,3,17
	db 244,2,240,12,5,17,244,3,240,7,6,9,244,2,240,12
	db 5,9,5,17,244,1,240,5,3,17,244,2,240,12,5,17
	db 244,3,240,7,6,9,244,2,240,12,5,9,5,17,0
_song2_v0__9:
	db 244,10,240,5,36,124,17,15,19,15,20,16,22,15,24,16
	db 20,15,24,30,23,16,19,15,23,31,22,15,18,15,22,30
	db 17,16,19,15,20,15,22,15,24,15,20,15,24,15,17,15
	db 15,15,24,16,20,15,24,15,15,60,17,15,19,15,20,14
	db 22,15,24,15,20,15,24,30,23,15,19,15,23,29,22,15
	db 18,15,22,29,17,15,19,15,20,15,22,14,24,15,20,15
	db 24,14,29,15,27,15,24,14,20,15,24,15,27,58,24,14
	db 26,15,16,15,17,14,19,15,16,14,19,29,20,14,16,15
	db 20,29,19,14,16,15,19,28,24,15,26,14,16,14,17,15
	db 19,14,16,14,19,29,20,14,16,14,20,29,19,56,24,15
	db 26,14,28,14,29,14,31,14,28,14,31,28,32,15,28,14
	db 32,28,31,14,28,14,31,28,24,14,26,14,28,14,29,13
	db 31,14,28,14,31,28,32,14,28,14,32,28,31,55,17,14
	db 19,13,20,14,22,14,24,14,20,13,24,28,23,14,19,13
	db 23,28,22,13,18,14,22,27,17,14,19,13,20,14,22,14
	db 24,13,20,14,24,13,17,14,15,13,24,14,20,13,24,14
	db 15,54,17,13,19,14,20,13,22,13,24,14,20,13,24,27
	db 23,13,19,14,23,26,22,14,18,13,22,27,17,13,19,13
	db 20,13,22,14,24,13,20,13,24,13,29,13,27,14,24,13
	db 20,13,24,13,27,53,29,13,31,13,32,13,34,13,36,13
	db 32,13,36,26,35,13,31,13,35,26,34,13,30,13,34,26
	db 29,13,31,13,32,13,34,13,36,13,32,13,36,13,41,13
	db 39,12,36,13,32,13,36,13,39,51,41,13,43,13,44,13
	db 46,12,48,13,44,13,48,25,47,13,43,13,47,25,46,13
	db 42,13,46,25,41,12,43,13,44,13,46,12,48,13,44,13
	db 48,12,41,13,51,12,48,13,44,12,48,13,51,50,36,12
	db 38,13,40,12,41,13,43,12,40,13,43,25,44,12,40,12
	db 44,25,43,13,40,12,43,25,36,12,38,12,40,13,41,12
	db 43,12,40,13,43,24,44,13,40,12,44,24,43,49,48,12
	db 50,13,40,12,41,12,43,12,40,12,43,25,44,12,40,12
	db 44,24,43,12,40,12,43,24,48,12,50,12,40,13,41,12
	db 43,12,40,12,43,24,44,12,40,12,44,24,43,47,29,12
	db 31,12,32,12,34,11,36,12,32,12,36,24,35,11,31,12
	db 35,23,34,12,30,12,35,23,29,12,31,11,32,12,34,11
	db 36,12,32,11,36,12,41,11,39,12,36,11,34,12,36,11
	db 39,46,41,11,43,11,44,12,46,11,48,11,44,12,48,22
	db 47,12,43,11,47,22,46,11,42,11,46,23,41,11,43,11
	db 44,11,46,11,48,11,44,11,48,11,41,11,48,11,44,11
	db 48,11,41,11,41,44,41,11,43,11,44,11,46,11,48,11
	db 44,10,48,22,47,11,43,11,47,21,46,11,42,11,46,21
	db 41,11,43,10,44,11,46,11,48,10,44,11,48,10,41,11
	db 51,11,48,10,44,11,48,10,51,42,41,11,43,10,44,11
	db 46,10,48,11,44,10,48,21,47,10,43,11,47,20,46,11
	db 42,10,46,21,41,10,43,10,44,10,46,11,48,10,44,10
	db 48,10,41,10,51,11,48,10,44,10,48,10,51,41,48,10
	db 50,10,40,10,41,10,43,10,40,10,43,20,44,10,40,10
	db 44,20,43,10,40,10,43,20,48,9,49,10,40,10,41,10
	db 43,10,40,10,43,19,44,10,40,10,44,20,43,39,48,9
	db 50,10,40,10,41,9,43,10,40,10,43,19,45,10,40,9
	db 45,20,43,9,40,10,43,19,48,9,49,10,40,10,41,9
	db 43,10,40,9,43,19,44,10,40,9,44,19,43,38,41,9
	db 43,9,44,10,46,9,48,9,44,10,48,18,47,10,43,9
	db 47,18,46,10,42,9,46,18,41,10,43,9,44,9,46,9
	db 48,10,41,9,48,9,41,9,51,9,48,9,44,9,48,10
	db 51,36,41,9,43,9,44,9,46,9,48,9,44,9,48,18
	db 47,9,43,9,47,18,46,9,42,9,46,18,41,9,43,9
	db 44,9,46,9,48,8,44,9,48,9,41,9,48,9,44,9
	db 48,9,41,8,41,36,255,17,41,18,255,52,41,17,255,35
	db 41,9,43,8,44,9,46,8,48,9,44,9,48,8,41,9
	db 40,8,48,9,40,8,43,9,41,34,255,17,41,17,255,51
	db 41,17,255,33,41,8,43,9,44,8,46,8,48,9,44,8
	db 48,8,41,9,40,8,48,8,40,9,43,8,41,33,255,16
	db 41,17,255,49,41,16,255,49,41,16,41,16,41,17,41,16
	db 41,16,41,16,41,16,255,143,41,15,244,11,240,4,36,96
	db 17,12,19,12,20,11,22,12,24,12,20,12,24,24,23,12
	db 19,11,23,24,22,12,18,12,22,23,17,12,19,12,20,11
	db 22,12,24,12,20,12,24,11,17,12,15,12,24,11,20,12
	db 24,12,15,46,17,12,19,11,20,12,22,12,24,11,20,12
	db 24,23,23,11,19,12,23,23,22,11,18,12,22,23,17,11
	db 19,12,20,11,22,12,24,11,20,11,24,12,29,11,27,12
	db 24,11,20,11,24,12,27,45,24,11,26,12,16,11,17,11
	db 19,12,16,11,19,22,20,12,16,11,20,22,19,11,16,12
	db 19,22,24,11,26,11,16,12,17,11,19,11,16,11,19,22
	db 20,11,16,11,20,23,19,44,24,11,26,11,28,11,29,11
	db 31,11,28,11,31,22,32,11,28,11,32,22,31,11,28,11
	db 31,21,24,11,26,11,28,11,29,11,31,11,28,11,31,21
	db 32,11,28,11,32,22,31,43,17,11,19,11,20,10,22,11
	db 24,11,20,10,24,22,23,11,19,10,23,22,22,10,18,11
	db 22,21,17,11,19,11,20,10,22,11,24,11,20,10,24,11
	db 17,10,15,11,24,11,20,10,24,11,15,42,17,10,19,11
	db 20,10,22,11,24,10,20,11,24,21,23,10,19,11,23,21
	db 22,10,18,10,22,21,17,11,19,10,20,10,22,11,24,10
	db 20,11,24,10,29,10,27,11,24,10,20,10,24,11,27,41
	db 29,10,31,10,32,11,34,10,36,10,32,10,36,21,35,10
	db 31,10,35,21,34,10,30,10,34,20,29,11,31,10,32,10
	db 34,10,36,10,32,10,36,10,41,11,39,10,36,10,32,10
	db 36,10,39,40,41,10,43,10,44,10,46,10,48,10,44,10
	db 48,20,47,10,43,10,47,20,46,10,42,10,46,20,41,10
	db 43,10,44,10,46,10,48,10,44,10,48,10,41,10,51,9
	db 48,10,44,10,48,10,51,39,36,10,38,10,40,10,41,10
	db 43,10,40,9,43,20,44,10,40,9,44,20,43,10,40,10
	db 43,19,36,10,38,9,40,10,41,10,43,10,40,9,43,20
	db 44,9,40,10,44,19,43,39,48,9,50,10,40,10,41,9
	db 43,10,40,9,43,20,44,9,40,10,44,19,43,9,40,10
	db 43,19,48,10,50,9,40,10,41,9,43,10,40,9,43,19
	db 44,9,40,10,44,19,43,37,29,10,31,9,32,10,34,9
	db 36,9,32,10,36,18,35,10,31,9,35,19,34,9,30,9
	db 35,19,29,9,31,9,32,10,34,9,36,9,32,9,36,9
	db 41,10,39,9,36,9,34,9,36,9,39,37,41,9,43,9
	db 44,9,46,9,48,9,44,9,48,19,47,9,43,9,47,18
	db 46,9,42,9,46,18,41,9,43,9,44,9,46,9,48,9
	db 44,9,48,8,41,9,48,9,44,9,48,9,41,9,41,36
	db 41,8,43,9,44,9,46,9,48,9,44,9,48,17,47,9
	db 43,9,47,17,46,9,42,9,46,17,41,9,43,9,44,9
	db 46,8,48,9,44,9,48,8,41,9,51,9,48,8,44,9
	db 48,9,51,34,41,9,43,8,44,9,46,9,48,8,44,9
	db 48,17,47,8,43,9,47,17,46,9,42,8,46,17,41,9
	db 43,8,44,8,46,9,48,8,44,9,48,8,41,9,51,8
	db 48,9,44,8,48,8,51,34,48,8,50,9,40,8,41,8
	db 43,9,40,8,43,17,44,8,40,8,44,17,43,8,40,9
	db 43,16,48,8,49,9,40,8,41,8,43,8,40,9,43,16
	db 44,8,40,9,44,16,43,33,48,8,50,8,40,8,41,8
	db 43,8,40,8,43,17,45,8,40,8,45,16,43,8,40,8
	db 43,16,48,8,49,8,40,8,41,8,43,8,40,8,43,17
	db 44,8,40,7,44,16,43,32,41,8,43,8,44,8,46,8
	db 48,8,44,8,48,16,47,8,43,7,47,16,46,8,42,8
	db 46,16,41,8,43,7,44,8,46,8,48,8,41,8,48,7
	db 41,8,51,8,48,8,44,8,48,7,51,31,41,8,43,8
	db 44,8,46,7,48,8,44,8,48,15,47,8,43,8,47,15
	db 46,8,42,7,46,16,41,7,43,8,44,8,46,7,48,8
	db 44,7,48,8,41,8,48,7,44,8,48,7,41,8,41,30
	db 255,15,41,16,255,45,41,15,255,30,41,7,43,7,44,8
	db 46,7,48,8,44,7,48,8,41,7,40,8,48,7,40,7
	db 43,8,41,29,255,15,41,15,255,44,41,14,255,30,41,7
	db 43,7,44,8,46,7,48,7,44,7,48,8,41,7,40,7
	db 48,7,40,8,43,7,41,29,255,14,41,14,255,43,41,15
	db 255,42,41,15,41,14,41,14,41,14,41,14,41,14,41,15
	db 255,126,41,13,0
_song2_v1__9:
	db 244,6,240,6,255,124,5,30,12,31,5,31,12,30,5,31
	db 12,31,5,30,12,30,5,31,12,30,5,30,12,30,8,31
	db 3,30,8,30,3,30,5,30,12,29,5,30,12,30,5,30
	db 12,29,5,30,12,29,5,30,12,29,5,30,12,29,8,29
	db 3,30,8,29,3,29,12,29,7,29,12,29,7,29,8,29
	db 4,29,12,29,7,28,12,29,7,29,12,28,7,29,8,28
	db 4,29,12,28,7,28,12,29,7,28,12,28,7,28,8,29
	db 4,28,12,28,7,28,12,28,7,27,12,28,7,28,8,28
	db 4,28,12,27,7,28,5,27,12,28,5,27,12,28,5,27
	db 12,28,5,27,12,27,5,27,12,28,5,27,12,27,8,27
	db 3,27,8,27,3,27,5,27,12,26,5,27,12,27,5,27
	db 12,26,5,27,12,27,5,26,5,27,3,26,1,26,12,27
	db 10,26,7,26,5,27,5,26,12,6,11,7,12,13,5,26
	db 12,7,11,6,12,13,5,26,12,7,11,6,12,13,5,26
	db 12,7,11,6,12,13,5,26,12,7,11,6,12,13,5,26
	db 12,6,11,7,12,13,8,25,15,7,14,6,15,13,8,26
	db 15,6,14,6,15,13,5,26,12,6,11,7,12,12,5,26
	db 12,6,11,7,12,12,5,26,12,6,11,6,12,13,5,26
	db 12,6,11,6,12,13,5,25,12,6,11,7,12,12,5,26
	db 12,6,11,6,12,13,8,25,15,6,14,6,15,13,8,25
	db 15,6,14,6,15,13,12,25,19,6,18,6,19,13,12,25
	db 19,6,18,6,19,13,8,24,20,7,19,6,20,12,12,25
	db 19,6,18,6,19,13,12,24,19,7,18,6,19,12,12,25
	db 19,6,18,6,19,12,8,25,20,6,19,6,20,12,12,25
	db 19,6,18,6,19,12,12,25,19,6,18,6,19,12,12,24
	db 19,6,18,6,19,13,8,24,20,6,19,6,20,12,12,24
	db 19,6,18,6,19,12,12,24,19,7,18,6,19,12,12,24
	db 19,6,18,6,19,12,8,24,20,6,19,6,20,12,12,23
	db 19,6,18,6,19,12,5,8,11,8,12,8,20,8,11,8
	db 12,7,5,8,11,8,12,8,20,8,11,8,12,8,5,7
	db 11,8,12,8,19,8,11,8,12,7,5,8,11,8,12,8
	db 18,7,11,8,12,8,5,8,11,7,12,8,20,8,11,8
	db 12,7,5,8,11,8,12,7,20,8,11,8,12,7,8,8
	db 14,8,15,7,12,8,14,8,15,7,8,8,14,7,15,8
	db 12,8,14,7,15,8,5,7,11,8,12,7,20,8,11,8
	db 12,7,5,8,11,7,12,8,20,7,11,8,12,7,5,8
	db 11,7,12,8,20,7,11,8,12,7,5,8,11,7,12,7
	db 20,8,11,7,12,8,5,7,11,8,12,7,17,22,15,22
	db 13,22,12,22,10,22,8,22,7,22,5,11,15,11,13,11
	db 12,11,5,11,15,10,13,11,12,11,5,11,15,11,13,10
	db 12,11,5,11,15,11,13,10,12,11,5,11,15,10,13,11
	db 12,11,5,10,15,11,13,10,12,11,8,11,19,10,17,11
	db 15,10,8,11,19,10,17,11,15,10,5,11,15,10,13,11
	db 12,10,5,11,15,10,13,10,12,11,5,10,15,11,13,10
	db 12,10,5,11,15,10,13,10,12,11,5,10,15,10,13,10
	db 12,11,5,10,15,10,13,10,12,10,5,11,15,10,13,10
	db 12,10,5,10,15,10,13,10,12,11,12,10,22,10,20,10
	db 19,10,12,10,22,10,20,10,19,10,8,10,19,10,20,10
	db 22,10,12,10,22,10,20,10,19,10,12,9,22,10,20,10
	db 19,10,12,10,22,10,20,10,19,9,8,10,19,10,20,10
	db 22,10,12,9,22,10,20,10,19,10,12,9,11,10,21,10
	db 19,9,12,10,11,10,21,9,19,10,9,10,19,9,21,10
	db 11,10,12,9,11,10,21,9,19,10,12,9,11,10,21,10
	db 19,9,12,10,11,9,21,10,19,9,9,10,19,9,21,9
	db 11,10,12,9,11,10,21,9,19,10,5,9,15,9,13,10
	db 12,9,5,9,15,10,13,9,12,9,5,10,15,9,13,9
	db 12,9,5,10,15,9,13,9,12,9,5,10,15,9,13,9
	db 12,9,5,10,15,9,13,9,12,9,8,9,19,9,15,9
	db 13,10,8,9,19,9,15,9,13,9,5,9,15,9,13,9
	db 12,9,5,9,15,9,13,9,12,9,5,9,15,9,13,9
	db 12,9,5,9,15,9,13,9,12,9,5,9,15,9,13,9
	db 12,9,5,8,15,9,13,9,12,9,5,9,15,9,13,9
	db 12,8,5,9,15,9,13,9,12,9,5,17,20,18,255,35
	db 5,17,20,17,255,35,13,17,20,17,12,18,20,17,12,17
	db 19,17,5,17,20,17,5,17,20,17,255,34,5,17,20,17
	db 255,33,13,17,20,16,12,17,20,17,12,16,19,17,5,16
	db 20,17,5,16,20,17,255,33,5,16,20,16,255,33,5,16
	db 20,16,20,16,20,17,20,16,20,16,20,16,20,16,255,32
	db 5,4,17,4,5,4,17,4,5,4,17,4,5,4,17,4
	db 5,4,17,4,5,4,17,3,5,4,17,4,5,4,17,4
	db 5,4,17,4,5,4,17,4,5,4,17,4,5,4,17,4
	db 5,16,17,15,244,6,240,6,255,96,5,24,12,23,5,24
	db 12,24,5,23,12,24,5,24,12,23,5,24,12,23,5,24
	db 12,23,8,23,3,24,8,23,3,23,5,23,12,24,5,23
	db 12,23,5,23,12,23,5,23,12,23,5,23,12,23,5,22
	db 12,23,8,23,3,23,8,22,3,23,12,23,7,22,12,23
	db 7,22,8,23,4,22,12,23,7,22,12,22,7,23,12,22
	db 7,22,8,22,4,23,12,22,7,22,12,22,7,22,12,22
	db 7,22,8,22,4,22,12,22,7,21,12,22,7,22,12,22
	db 7,21,8,22,4,22,12,21,7,22,5,22,12,21,5,21
	db 12,22,5,21,12,22,5,21,12,21,5,22,12,21,5,21
	db 12,21,8,22,3,21,8,21,3,21,5,21,12,21,5,21
	db 12,21,5,21,12,21,5,20,12,21,5,21,5,21,3,21
	db 1,20,12,21,10,21,7,20,5,21,5,20,12,5,11,6
	db 12,10,5,20,12,5,11,6,12,10,5,20,12,5,11,5
	db 12,11,5,20,12,5,11,5,12,10,5,21,12,5,11,5
	db 12,10,5,20,12,5,11,5,12,11,8,20,15,5,14,5
	db 15,10,8,20,15,5,14,5,15,10,5,20,12,5,11,5
	db 12,10,5,20,12,5,11,5,12,10,5,20,12,5,11,5
	db 12,10,5,20,12,5,11,5,12,10,5,20,12,5,11,5
	db 12,10,5,20,12,5,11,5,12,10,8,19,15,5,14,5
	db 15,10,8,20,15,5,14,5,15,9,12,20,19,5,18,5
	db 19,10,12,19,19,5,18,5,19,10,8,19,20,5,19,5
	db 20,10,12,20,19,4,18,5,19,10,12,19,19,5,18,5
	db 19,10,12,19,19,5,18,5,19,10,8,19,20,5,19,5
	db 20,9,12,20,19,4,18,5,19,10,12,19,19,5,18,5
	db 19,9,12,19,19,5,18,5,19,10,8,19,20,5,19,4
	db 20,10,12,19,19,5,18,4,19,10,12,19,19,5,18,5
	db 19,9,12,19,19,5,18,5,19,9,8,19,20,5,19,4
	db 20,10,12,19,19,4,18,5,19,9,5,7,11,6,12,6
	db 20,7,11,6,12,6,5,6,11,7,12,6,20,6,11,6
	db 12,6,5,7,11,6,12,6,19,6,11,6,12,7,5,6
	db 11,6,12,6,18,6,11,7,12,6,5,6,11,6,12,6
	db 20,6,11,7,12,6,5,6,11,6,12,6,20,6,11,6
	db 12,7,8,6,14,6,15,6,12,6,14,6,15,6,8,6
	db 14,6,15,7,12,6,14,6,15,6,5,6,11,6,12,6
	db 20,6,11,6,12,6,5,6,11,6,12,6,20,6,11,7
	db 12,6,5,6,11,6,12,6,20,6,11,6,12,6,5,6
	db 11,6,12,6,20,6,11,6,12,6,5,6,11,6,12,6
	db 17,18,15,18,13,17,12,18,10,18,8,18,7,18,5,8
	db 15,9,13,9,12,9,5,9,15,9,13,8,12,9,5,9
	db 15,9,13,9,12,8,5,9,15,9,13,9,12,8,5,9
	db 15,9,13,9,12,8,5,9,15,9,13,8,12,9,8,9
	db 19,8,17,9,15,9,8,8,19,9,17,9,15,8,5,9
	db 15,8,13,9,12,9,5,8,15,9,13,8,12,9,5,8
	db 15,9,13,8,12,9,5,9,15,8,13,9,12,8,5,9
	db 15,8,13,8,12,9,5,8,15,9,13,8,12,9,5,8
	db 15,9,13,8,12,8,5,9,15,8,13,9,12,8,12,8
	db 22,9,20,8,19,8,12,9,22,8,20,9,19,8,8,8
	db 19,8,20,9,22,8,12,8,22,9,20,8,19,8,12,8
	db 22,9,20,8,19,8,12,8,22,9,20,8,19,8,8,8
	db 19,9,20,8,22,8,12,8,22,8,20,8,19,9,12,8
	db 11,8,21,8,19,8,12,8,11,8,21,9,19,8,9,8
	db 19,8,21,8,11,8,12,8,11,8,21,8,19,8,12,8
	db 11,8,21,8,19,8,12,8,11,8,21,9,19,8,9,8
	db 19,7,21,8,11,8,12,8,11,8,21,8,19,8,5,8
	db 15,8,13,8,12,8,5,8,15,8,13,8,12,8,5,8
	db 15,7,13,8,12,8,5,8,15,8,13,8,12,8,5,8
	db 15,7,13,8,12,8,5,8,15,8,13,7,12,8,8,8
	db 19,8,15,8,13,7,8,8,19,8,15,8,13,7,5,8
	db 15,8,13,8,12,7,5,8,15,8,13,8,12,7,5,8
	db 15,8,13,7,12,8,5,8,15,7,13,8,12,8,5,7
	db 15,8,13,8,12,7,5,8,15,7,13,8,12,8,5,7
	db 15,8,13,7,12,8,5,8,15,7,13,8,12,7,5,15
	db 20,16,255,30,5,15,20,15,255,30,13,14,20,15,12,15
	db 20,15,12,15,19,15,5,15,20,14,5,15,20,15,255,29
	db 5,15,20,14,255,30,13,14,20,15,12,14,20,15,12,14
	db 19,15,5,14,20,15,5,14,20,14,255,29,5,14,20,15
	db 255,28,5,14,20,15,20,14,20,14,20,14,20,14,20,14
	db 20,15,255,28,5,3,17,4,5,3,17,4,5,3,17,4
	db 5,3,17,4,5,3,17,4,5,3,17,4,5,3,17,4
	db 5,3,17,4,5,3,17,4,5,3,17,4,5,3,17,4
	db 5,3,17,4,5,14,17,13,0
_song2_v2__9:
	db 244,6,240,8,255,240,255,240,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,236,32,6,255,46
	db 32,7,255,45,31,7,255,45,30,7,255,45,32,7,255,45
	db 32,6,255,45,36,7,255,45,36,6,255,45,32,6,255,45
	db 32,6,255,45,31,6,255,45,32,6,255,44,32,6,255,45
	db 32,6,255,44,36,6,255,44,36,6,255,44,28,6,255,44
	db 28,6,255,43,28,7,255,43,28,6,255,43,28,7,255,43
	db 28,6,255,43,28,6,255,43,28,6,255,43,28,6,255,42
	db 28,6,255,43,28,6,255,42,28,6,255,42,28,7,255,42
	db 28,6,255,42,28,6,255,41,28,6,255,240,255,240,255,112
	db 29,22,39,22,37,22,36,22,34,22,32,22,31,22,29,11
	db 255,33,29,11,255,32,29,11,255,32,29,11,255,32,29,11
	db 255,32,29,10,255,32,32,11,255,31,32,11,255,31,29,11
	db 255,31,29,11,255,31,29,10,255,31,29,11,255,31,29,10
	db 255,31,29,10,255,30,29,11,255,30,29,10,255,31,36,10
	db 255,30,36,10,255,30,32,10,255,30,36,10,255,30,36,9
	db 255,30,36,10,255,29,32,10,255,30,36,9,255,30,36,9
	db 255,29,36,10,255,29,33,10,255,29,36,9,255,29,36,9
	db 255,29,36,10,255,28,33,10,255,28,36,9,255,29,29,9
	db 255,28,29,9,255,28,29,10,255,27,29,10,255,27,29,10
	db 255,27,29,10,255,27,32,9,255,28,32,9,255,27,29,9
	db 255,27,29,9,255,27,29,9,255,27,29,9,255,27,29,9
	db 255,27,29,8,255,27,29,9,255,26,29,9,255,27,29,17
	db 29,18,255,35,29,17,29,17,255,35,37,17,29,17,36,18
	db 29,17,24,17,28,17,29,17,29,17,29,17,29,17,255,34
	db 29,17,29,17,255,33,37,17,29,16,36,17,29,17,24,16
	db 28,17,29,16,29,17,29,16,29,17,255,33,29,16,29,16
	db 255,33,29,16,29,16,29,16,29,17,29,16,29,16,29,16
	db 29,16,255,127,17,16,29,15,244,6,240,8,255,240,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,240,255,80
	db 32,5,255,36,32,5,255,36,31,5,255,36,30,5,255,36
	db 32,5,255,35,32,5,255,36,36,5,255,35,36,5,255,35
	db 32,5,255,35,32,5,255,35,31,5,255,35,32,5,255,35
	db 32,5,255,35,32,5,255,34,36,5,255,35,36,5,255,34
	db 28,5,255,34,28,5,255,34,28,5,255,35,28,4,255,34
	db 28,5,255,34,28,5,255,34,28,5,255,34,28,4,255,34
	db 28,5,255,33,28,5,255,34,28,5,255,33,28,5,255,33
	db 28,5,255,33,28,5,255,33,28,5,255,33,28,4,255,240
	db 255,234,29,18,39,18,37,17,36,18,34,18,32,18,31,18
	db 29,8,255,27,29,9,255,26,29,9,255,26,29,9,255,26
	db 29,9,255,26,29,9,255,26,32,9,255,26,32,8,255,26
	db 29,9,255,26,29,8,255,26,29,8,255,26,29,9,255,25
	db 29,9,255,25,29,8,255,26,29,8,255,25,29,9,255,25
	db 36,8,255,25,36,9,255,25,32,8,255,25,36,8,255,25
	db 36,8,255,25,36,8,255,25,32,8,255,25,36,8,255,25
	db 36,8,255,24,36,8,255,25,33,8,255,24,36,8,255,24
	db 36,8,255,24,36,8,255,25,33,8,255,23,36,8,255,24
	db 29,8,255,24,29,8,255,24,29,8,255,23,29,8,255,24
	db 29,8,255,23,29,8,255,23,32,8,255,23,32,8,255,23
	db 29,8,255,23,29,8,255,23,29,8,255,23,29,8,255,23
	db 29,7,255,23,29,8,255,23,29,7,255,23,29,8,255,22
	db 29,15,29,16,255,30,29,15,29,15,255,30,37,14,29,15
	db 36,15,29,15,24,15,28,15,29,15,29,14,29,15,29,15
	db 255,29,29,15,29,14,255,30,37,14,29,15,36,14,29,15
	db 24,14,28,15,29,14,29,15,29,14,29,14,255,29,29,14
	db 29,15,255,28,29,14,29,15,29,14,29,14,29,14,29,14
	db 29,14,29,15,255,112,17,14,29,13,0
_song2_v3__9:
	db 244,1,240,5,3,16,244,2,240,12,5,15,244,3,240,7
	db 6,15,244,2,240,12,5,16,244,1,240,5,3,15,244,2
	db 240,12,5,16,244,3,240,7,6,15,244,2,240,12,5,16
	db 244,1,240,5,3,15,244,2,240,12,5,15,244,3,240,7
	db 6,16,244,2,240,12,5,15,244,1,240,5,3,16,244,2
	db 240,12,5,15,244,3,240,7,6,15,244,2,240,12,5,15
	db 244,1,240,5,3,16,244,2,240,12,5,15,244,3,240,7
	db 6,15,244,2,240,12,5,16,244,1,240,5,3,15,244,2
	db 240,12,5,15,244,3,240,7,6,15,244,2,240,12,5,15
	db 244,1,240,5,3,16,244,2,240,12,5,15,244,3,240,7
	db 6,15,244,2,240,12,5,15,244,1,240,5,3,15,244,2
	db 240,12,5,15,244,3,240,7,6,15,244,2,240,12,5,15
	db 244,1,240,5,3,15,244,2,240,12,5,16,244,3,240,7
	db 6,15,244,2,240,12,5,15,244,1,240,5,3,15,244,2
	db 240,12,5,15,244,3,240,7,6,15,244,2,240,12,5,15
	db 244,1,240,5,3,15,244,2,240,12,5,15,244,3,240,7
	db 6,14,244,2,240,12,5,15,244,1,240,5,3,15,244,2
	db 240,12,5,15,244,3,240,7,6,15,244,2,240,12,5,15
	db 244,1,240,5,3,15,244,2,240,12,5,15,244,3,240,7
	db 6,14,244,2,240,12,5,15,244,1,240,5,3,15,244,2
	db 240,12,5,15,244,3,240,7,6,15,244,2,240,12,5,14
	db 244,1,240,5,3,15,244,2,240,12,5,15,244,3,240,7
	db 6,15,244,2,240,12,5,14,244,1,240,5,3,15,244,3
	db 240,7,6,15,6,7,6,7,6,8,6,7,244,1,240,5
	db 3,15,244,2,240,12,5,14,244,3,240,7,6,15,244,2
	db 240,12,5,15,244,1,240,5,3,14,244,2,240,12,5,15
	db 244,3,240,7,6,14,244,2,240,12,5,15,244,1,240,5
	db 3,14,244,2,240,12,5,15,244,3,240,7,6,15,244,2
	db 240,12,5,14,244,1,240,5,3,15,244,2,240,12,5,14
	db 244,3,240,7,6,15,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,12,5,15,244,3,240,7,6,14,244,2
	db 240,12,5,15,244,1,240,5,3,14,244,2,240,12,5,15
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,15,244,2,240,12,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,15,244,1,240,5,3,14,244,2,240,12,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,15,244,1,240,5
	db 3,14,244,2,240,12,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,15,244,1,240,5,3,14,244,2,240,12,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,15,244,2,240,12,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,12,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,15,244,2,240,12,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,12,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,12,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,13,244,1,240,5,3,14,244,3,240,7,6,14
	db 6,7,6,7,6,7,6,7,244,1,240,5,3,14,244,2
	db 240,12,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,13,244,2,240,12,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,244,2
	db 240,12,5,13,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,244,2,240,12,5,13,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,244,2
	db 240,12,5,13,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,13,244,2,240,12,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,13,244,1,240,5,3,14,244,2
	db 240,12,5,13,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,13,244,2,240,12,5,14,244,3,240,7
	db 6,13,244,2,240,12,5,14,244,1,240,5,3,13,244,2
	db 240,12,5,14,244,3,240,7,6,13,244,2,240,12,5,14
	db 244,1,240,5,3,13,244,2,240,12,5,14,244,3,240,7
	db 6,13,244,2,240,12,5,14,244,1,240,5,3,13,244,2
	db 240,12,5,14,244,3,240,7,6,13,244,2,240,12,5,13
	db 244,1,240,5,3,14,244,2,240,12,5,13,244,3,240,7
	db 6,14,244,2,240,12,5,13,244,1,240,5,3,13,244,2
	db 240,12,5,14,244,3,240,7,6,13,244,2,240,12,5,13
	db 244,1,240,5,3,14,244,2,240,12,5,13,244,3,240,7
	db 6,13,244,2,240,12,5,14,244,1,240,5,3,13,244,2
	db 240,12,5,13,244,3,240,7,6,13,244,2,240,12,5,14
	db 244,1,240,5,3,13,244,3,240,7,6,13,6,7,6,6
	db 6,7,6,6,244,1,240,5,3,14,244,2,240,12,5,13
	db 244,3,240,7,6,13,244,2,240,12,5,13,244,1,240,5
	db 3,13,244,2,240,12,5,13,244,3,240,7,6,14,244,2
	db 240,12,5,13,244,1,240,5,3,13,244,2,240,12,5,13
	db 244,3,240,7,6,13,244,2,240,12,5,13,244,1,240,5
	db 3,13,244,2,240,12,5,13,244,3,240,7,6,13,244,2
	db 240,12,5,13,244,1,240,5,3,13,244,2,240,12,5,13
	db 244,3,240,7,6,13,244,2,240,12,5,13,244,1,240,5
	db 3,13,244,2,240,12,5,13,244,3,240,7,6,13,244,2
	db 240,12,5,13,244,1,240,5,3,13,244,2,240,12,5,13
	db 244,3,240,7,6,13,244,2,240,12,5,13,244,1,240,5
	db 3,13,244,2,240,12,5,13,244,3,240,7,6,13,244,2
	db 240,12,5,13,244,1,240,5,3,12,244,2,240,12,5,13
	db 244,3,240,7,6,13,244,2,240,12,5,13,244,1,240,5
	db 3,13,244,2,240,12,5,13,244,3,240,7,6,12,244,2
	db 240,12,5,13,244,1,240,5,3,13,244,2,240,12,5,13
	db 244,3,240,7,6,13,244,2,240,12,5,12,244,1,240,5
	db 3,13,244,2,240,12,5,13,244,3,240,7,6,13,244,2
	db 240,12,5,12,244,1,240,5,3,13,244,2,240,12,5,13
	db 244,3,240,7,6,12,244,2,240,12,5,13,244,1,240,5
	db 3,13,244,2,240,12,5,13,244,3,240,7,6,12,244,2
	db 240,12,5,13,244,1,240,5,3,12,244,2,240,12,5,13
	db 244,3,240,7,6,13,244,2,240,12,5,12,244,1,240,5
	db 3,13,244,3,240,7,6,13,6,6,6,6,6,6,6,7
	db 244,1,240,5,3,12,244,2,240,12,5,13,244,3,240,7
	db 6,12,244,2,240,12,5,13,244,1,240,5,3,12,244,2
	db 240,12,5,13,244,3,240,7,6,12,244,2,240,12,5,13
	db 244,1,240,5,3,12,244,2,240,12,5,13,244,3,240,7
	db 6,12,244,2,240,12,5,13,244,1,240,5,3,12,244,2
	db 240,12,5,13,244,3,240,7,6,12,244,2,240,12,5,13
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,13,244,2,240,12,5,12,244,1,240,5,3,13,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,13
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,13,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,13,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,13,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,13,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,13,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,13
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,13,244,2,240,12,5,12,244,1,240,5,3,12,244,3
	db 240,7,6,12,6,6,6,6,6,6,6,6,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,11,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,11,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,11,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,11,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,11,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,11,244,1,240,5,3,12,244,2,240,12,5,11
	db 244,3,240,7,6,12,244,2,240,12,5,11,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,11,244,1,240,5,3,12,244,2,240,12,5,11
	db 244,3,240,7,6,11,244,2,240,12,5,12,244,1,240,5
	db 3,11,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,11,244,1,240,5,3,11,244,2,240,12,5,12
	db 244,3,240,7,6,11,244,2,240,12,5,11,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,11,244,2
	db 240,12,5,11,244,1,240,5,3,11,244,2,240,12,5,11
	db 244,3,240,7,6,12,244,2,240,12,5,11,244,1,240,5
	db 3,11,244,2,240,12,5,11,244,3,240,7,6,11,244,2
	db 240,12,5,11,244,1,240,5,3,11,244,3,240,7,6,11
	db 6,6,6,5,6,6,6,5,244,1,240,5,3,11,244,2
	db 240,12,5,11,244,3,240,7,6,11,244,2,240,12,5,11
	db 244,1,240,5,3,11,244,2,240,12,5,11,244,3,240,7
	db 6,11,244,2,240,12,5,11,244,1,240,5,3,11,244,2
	db 240,12,5,11,244,3,240,7,6,11,244,2,240,12,5,11
	db 244,1,240,5,3,11,244,2,240,12,5,10,244,3,240,7
	db 6,11,244,2,240,12,5,11,244,1,240,5,3,11,244,2
	db 240,12,5,11,244,3,240,7,6,10,244,2,240,12,5,11
	db 244,1,240,5,3,11,244,2,240,12,5,11,244,3,240,7
	db 6,10,244,2,240,12,5,11,244,1,240,5,3,11,244,2
	db 240,12,5,10,244,3,240,7,6,11,244,2,240,12,5,11
	db 244,1,240,5,3,10,244,2,240,12,5,11,244,3,240,7
	db 6,10,244,2,240,12,5,11,244,1,240,5,3,11,244,2
	db 240,12,5,10,244,3,240,7,6,11,244,2,240,12,5,10
	db 244,1,240,5,3,11,244,2,240,12,5,10,244,3,240,7
	db 6,11,244,2,240,12,5,10,244,1,240,5,3,11,244,2
	db 240,12,5,10,244,3,240,7,6,11,244,2,240,12,5,10
	db 244,1,240,5,3,11,244,2,240,12,5,10,244,3,240,7
	db 6,10,244,2,240,12,5,11,244,1,240,5,3,10,244,2
	db 240,12,5,11,244,3,240,7,6,10,244,2,240,12,5,10
	db 244,1,240,5,3,11,244,2,240,12,5,10,244,3,240,7
	db 6,10,244,2,240,12,5,11,244,1,240,5,3,10,244,2
	db 240,12,5,10,244,3,240,7,6,10,244,2,240,12,5,11
	db 244,1,240,5,3,10,244,3,240,7,6,10,6,5,6,5
	db 6,5,6,5,244,1,240,5,3,11,244,2,240,12,5,10
	db 244,3,240,7,6,10,244,2,240,12,5,10,244,1,240,5
	db 3,10,244,2,240,12,5,10,244,3,240,7,6,10,244,2
	db 240,12,5,11,244,1,240,5,3,10,244,2,240,12,5,10
	db 244,3,240,7,6,10,244,2,240,12,5,10,244,1,240,5
	db 3,10,244,2,240,12,5,10,244,3,240,7,6,10,244,2
	db 240,12,5,10,244,1,240,5,3,10,244,2,240,12,5,10
	db 244,3,240,7,6,10,244,2,240,12,5,10,244,1,240,5
	db 3,10,244,2,240,12,5,10,244,3,240,7,6,10,244,2
	db 240,12,5,10,244,1,240,5,3,9,244,2,240,12,5,10
	db 244,3,240,7,6,10,244,2,240,12,5,10,244,1,240,5
	db 3,10,244,2,240,12,5,10,244,3,240,7,6,10,244,2
	db 240,12,5,9,244,1,240,5,3,10,244,2,240,12,5,10
	db 244,3,240,7,6,10,244,2,240,12,5,10,244,1,240,5
	db 3,9,244,2,240,12,5,10,244,3,240,7,6,10,244,2
	db 240,12,5,10,244,1,240,5,3,9,244,2,240,12,5,10
	db 244,3,240,7,6,10,244,2,240,12,5,9,244,1,240,5
	db 3,10,244,2,240,12,5,10,244,3,240,7,6,9,244,2
	db 240,12,5,10,244,1,240,5,3,10,244,2,240,12,5,9
	db 244,3,240,7,6,10,244,2,240,12,5,10,244,1,240,5
	db 3,9,244,2,240,12,5,10,244,3,240,7,6,9,244,2
	db 240,12,5,10,244,1,240,5,3,9,244,2,240,12,5,10
	db 244,3,240,7,6,10,244,2,240,12,5,9,244,1,240,5
	db 3,10,244,3,240,7,6,9,6,5,6,5,6,4,6,5
	db 244,1,240,5,3,10,244,2,240,12,5,9,244,3,240,7
	db 6,9,244,2,240,12,5,10,244,1,240,5,3,9,244,2
	db 240,12,5,10,244,3,240,7,6,9,244,2,240,12,5,10
	db 244,1,240,5,3,9,244,2,240,12,5,9,244,3,240,7
	db 6,10,244,2,240,12,5,9,244,1,240,5,3,9,244,2
	db 240,12,5,10,244,3,240,7,6,9,244,2,240,12,5,9
	db 244,1,240,5,3,10,244,2,240,12,5,9,244,3,240,7
	db 6,9,244,2,240,12,5,9,244,1,240,5,3,10,244,2
	db 240,12,5,9,244,3,240,7,6,9,244,2,240,12,5,9
	db 244,1,240,5,3,10,244,2,240,12,5,9,244,3,240,7
	db 6,9,244,2,240,12,5,9,244,1,240,5,3,10,244,2
	db 240,12,5,9,244,3,240,7,6,9,244,2,240,12,5,9
	db 244,1,240,5,3,9,244,2,240,12,5,9,244,3,240,7
	db 6,9,244,2,240,12,5,10,244,1,240,5,3,9,244,2
	db 240,12,5,9,244,3,240,7,6,9,244,2,240,12,5,9
	db 244,1,240,5,3,9,244,2,240,12,5,9,244,3,240,7
	db 6,9,244,2,240,12,5,9,244,1,240,5,3,9,244,2
	db 240,12,5,9,244,3,240,7,6,9,244,2,240,12,5,9
	db 244,1,240,5,3,9,244,2,240,12,5,9,244,3,240,7
	db 6,9,244,2,240,12,5,9,244,1,240,5,3,9,244,2
	db 240,12,5,9,244,3,240,7,6,9,244,2,240,12,5,9
	db 244,1,240,5,3,9,244,2,240,12,5,9,244,3,240,7
	db 6,9,244,2,240,12,5,9,244,1,240,5,3,8,244,3
	db 240,7,6,9,6,5,6,4,6,5,6,4,244,1,240,5
	db 3,9,244,2,240,12,5,9,244,3,240,7,6,9,244,2
	db 240,12,5,8,244,1,240,5,3,9,244,2,240,12,5,9
	db 244,3,240,7,6,9,244,2,240,12,5,9,244,1,240,5
	db 3,8,244,2,240,12,5,9,244,3,240,7,6,9,244,2
	db 240,12,5,9,244,1,240,5,3,8,244,2,240,12,5,9
	db 244,3,240,7,6,9,244,2,240,12,5,9,244,1,240,5
	db 3,8,244,2,240,12,5,9,244,3,240,7,6,9,244,2
	db 240,12,5,8,244,1,240,5,3,9,244,2,240,12,5,9
	db 244,3,240,7,6,8,244,2,240,12,5,9,244,1,240,5
	db 3,9,244,2,240,12,5,8,244,3,240,7,6,9,244,2
	db 240,12,5,8,244,1,240,5,3,9,244,2,240,12,5,9
	db 244,3,240,7,6,8,244,2,240,12,5,9,244,1,240,5
	db 3,8,244,2,240,12,5,9,244,3,240,7,6,8,244,2
	db 240,12,5,9,244,1,240,5,3,9,244,2,240,12,5,8
	db 244,3,240,7,6,9,244,2,240,12,5,8,244,1,240,5
	db 3,9,244,2,240,12,5,8,244,3,240,7,6,9,244,2
	db 240,12,5,8,244,1,240,5,3,8,244,2,240,12,5,9
	db 244,3,240,7,6,8,244,2,240,12,5,9,244,1,240,5
	db 3,8,244,2,240,12,5,9,244,3,240,7,6,8,244,2
	db 240,12,5,9,244,1,240,5,3,8,244,2,240,12,5,8
	db 244,3,240,7,6,9,244,2,240,12,5,8,244,1,240,5
	db 3,8,244,2,240,12,5,9,244,3,240,7,6,8,244,2
	db 240,12,5,8,244,1,240,5,3,9,244,3,240,7,6,8
	db 6,4,6,4,6,5,6,4,244,1,240,5,3,8,244,2
	db 240,12,5,8,244,3,240,7,6,9,244,2,240,12,5,8
	db 244,1,240,5,3,8,244,2,240,12,5,8,244,3,240,7
	db 6,9,244,2,240,12,5,8,244,1,240,5,3,8,244,2
	db 240,12,5,8,244,3,240,7,6,9,244,2,240,12,5,8
	db 244,1,240,5,3,8,244,2,240,12,5,8,244,3,240,7
	db 6,9,244,2,240,12,5,8,244,1,240,5,3,8,244,2
	db 240,12,5,8,244,3,240,7,6,8,244,2,240,12,5,8
	db 244,1,240,5,3,9,244,2,240,12,5,8,244,3,240,7
	db 6,8,244,2,240,12,5,8,244,1,240,5,3,8,244,2
	db 240,12,5,8,244,3,240,7,6,8,244,2,240,12,5,8
	db 244,1,240,5,3,8,244,2,240,12,5,8,244,3,240,7
	db 6,9,244,2,240,12,5,8,244,1,240,5,3,8,244,2
	db 240,12,5,8,244,3,240,7,6,8,244,2,240,12,5,8
	db 244,1,240,5,3,8,244,2,240,12,5,8,244,3,240,7
	db 6,8,244,2,240,12,5,8,244,1,240,5,3,8,244,2
	db 240,12,5,8,244,3,240,7,6,8,244,2,240,12,5,8
	db 244,1,240,5,3,8,244,2,240,12,5,8,244,3,240,7
	db 6,8,244,2,240,12,5,8,244,1,240,5,3,8,244,2
	db 240,12,5,7,244,3,240,7,6,8,244,2,240,12,5,8
	db 244,1,240,5,3,8,244,2,240,12,5,8,244,3,240,7
	db 6,8,244,2,240,12,5,8,244,1,240,5,3,8,244,2
	db 240,12,5,8,244,3,240,7,6,8,244,2,240,12,5,7
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,11,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,11,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,11,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,11,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,11,244,2
	db 240,12,5,12,244,3,240,7,6,12,244,2,240,12,5,11
	db 244,1,240,5,3,12,244,2,240,12,5,11,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,11,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,11,244,2,240,12,5,12,244,3,240,7
	db 6,11,244,2,240,12,5,12,244,1,240,5,3,11,244,2
	db 240,12,5,12,244,3,240,7,6,11,244,2,240,12,5,12
	db 244,1,240,5,3,11,244,2,240,12,5,12,244,3,240,7
	db 6,11,244,2,240,12,5,12,244,1,240,5,3,11,244,3
	db 240,7,6,11,6,6,6,6,6,6,6,5,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,11,244,2
	db 240,12,5,12,244,1,240,5,3,11,244,2,240,12,5,11
	db 244,3,240,7,6,12,244,2,240,12,5,11,244,1,240,5
	db 3,11,244,2,240,12,5,12,244,3,240,7,6,11,244,2
	db 240,12,5,11,244,1,240,5,3,12,244,2,240,12,5,11
	db 244,3,240,7,6,11,244,2,240,12,5,11,244,1,240,5
	db 3,12,244,2,240,12,5,11,244,3,240,7,6,11,244,2
	db 240,12,5,11,244,1,240,5,3,11,244,2,240,12,5,12
	db 244,3,240,7,6,11,244,2,240,12,5,11,244,1,240,5
	db 3,11,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,11,244,1,240,5,3,11,244,2,240,12,5,11
	db 244,3,240,7,6,11,244,2,240,12,5,11,244,1,240,5
	db 3,11,244,2,240,12,5,11,244,3,240,7,6,12,244,2
	db 240,12,5,11,244,1,240,5,3,11,244,2,240,12,5,11
	db 244,3,240,7,6,11,244,2,240,12,5,11,244,1,240,5
	db 3,11,244,2,240,12,5,11,244,3,240,7,6,11,244,2
	db 240,12,5,11,244,1,240,5,3,11,244,2,240,12,5,11
	db 244,3,240,7,6,11,244,2,240,12,5,11,244,1,240,5
	db 3,11,244,2,240,12,5,11,244,3,240,7,6,11,244,2
	db 240,12,5,11,244,1,240,5,3,11,244,2,240,12,5,11
	db 244,3,240,7,6,11,244,2,240,12,5,10,244,1,240,5
	db 3,11,244,2,240,12,5,11,244,3,240,7,6,11,244,2
	db 240,12,5,11,244,1,240,5,3,11,244,3,240,7,6,11
	db 6,5,6,6,6,5,6,5,244,1,240,5,3,11,244,2
	db 240,12,5,11,244,3,240,7,6,11,244,2,240,12,5,11
	db 244,1,240,5,3,11,244,2,240,12,5,10,244,3,240,7
	db 6,11,244,2,240,12,5,11,244,1,240,5,3,11,244,2
	db 240,12,5,11,244,3,240,7,6,10,244,2,240,12,5,11
	db 244,1,240,5,3,11,244,2,240,12,5,10,244,3,240,7
	db 6,11,244,2,240,12,5,11,244,1,240,5,3,11,244,2
	db 240,12,5,10,244,3,240,7,6,11,244,2,240,12,5,11
	db 244,1,240,5,3,10,244,2,240,12,5,11,244,3,240,7
	db 6,11,244,2,240,12,5,10,244,1,240,5,3,11,244,2
	db 240,12,5,11,244,3,240,7,6,10,244,2,240,12,5,11
	db 244,1,240,5,3,11,244,2,240,12,5,10,244,3,240,7
	db 6,11,244,2,240,12,5,10,244,1,240,5,3,11,244,2
	db 240,12,5,11,244,3,240,7,6,10,244,2,240,12,5,11
	db 244,1,240,5,3,10,244,2,240,12,5,11,244,3,240,7
	db 6,10,244,2,240,12,5,11,244,1,240,5,3,10,244,2
	db 240,12,5,11,244,3,240,7,6,10,244,2,240,12,5,11
	db 244,1,240,5,3,10,244,2,240,12,5,11,244,3,240,7
	db 6,10,244,2,240,12,5,11,244,1,240,5,3,10,244,2
	db 240,12,5,11,244,3,240,7,6,10,244,2,240,12,5,11
	db 244,1,240,5,3,10,244,2,240,12,5,10,244,3,240,7
	db 6,11,244,2,240,12,5,10,244,1,240,5,3,11,244,2
	db 240,12,5,10,244,3,240,7,6,10,244,2,240,12,5,11
	db 244,1,240,5,3,10,244,3,240,7,6,11,6,5,6,5
	db 6,5,6,5,244,1,240,5,3,11,244,2,240,12,5,10
	db 244,3,240,7,6,10,244,2,240,12,5,11,244,1,240,5
	db 3,10,244,2,240,12,5,10,244,3,240,7,6,10,244,2
	db 240,12,5,11,244,1,240,5,3,10,244,2,240,12,5,10
	db 244,3,240,7,6,11,244,2,240,12,5,10,244,1,240,5
	db 3,10,244,2,240,12,5,10,244,3,240,7,6,11,244,2
	db 240,12,5,10,244,1,240,5,3,10,244,2,240,12,5,10
	db 244,3,240,7,6,10,244,2,240,12,5,11,244,1,240,5
	db 3,10,244,2,240,12,5,10,244,3,240,7,6,10,244,2
	db 240,12,5,10,244,1,240,5,3,11,244,2,240,12,5,10
	db 244,3,240,7,6,10,244,2,240,12,5,10,244,1,240,5
	db 3,10,244,2,240,12,5,10,244,3,240,7,6,10,244,2
	db 240,12,5,11,244,1,240,5,3,10,244,2,240,12,5,10
	db 244,3,240,7,6,10,244,2,240,12,5,10,244,1,240,5
	db 3,10,244,2,240,12,5,10,244,3,240,7,6,10,244,2
	db 240,12,5,10,244,1,240,5,3,10,244,2,240,12,5,10
	db 244,3,240,7,6,10,244,2,240,12,5,10,244,1,240,5
	db 3,10,244,2,240,12,5,10,244,3,240,7,6,10,244,2
	db 240,12,5,10,244,1,240,5,3,10,244,2,240,12,5,10
	db 244,3,240,7,6,10,244,2,240,12,5,10,244,1,240,5
	db 3,10,244,2,240,12,5,10,244,3,240,7,6,10,244,2
	db 240,12,5,10,244,1,240,5,3,10,244,2,240,12,5,10
	db 244,3,240,7,6,10,244,2,240,12,5,10,244,1,240,5
	db 3,10,244,3,240,7,6,10,6,5,6,5,6,5,6,5
	db 244,1,240,5,3,9,244,2,240,12,5,10,244,3,240,7
	db 6,10,244,2,240,12,5,10,244,1,240,5,3,10,244,2
	db 240,12,5,10,244,3,240,7,6,10,244,2,240,12,5,9
	db 244,1,240,5,3,10,244,2,240,12,5,10,244,3,240,7
	db 6,10,244,2,240,12,5,10,244,1,240,5,3,10,244,2
	db 240,12,5,9,244,3,240,7,6,10,244,2,240,12,5,10
	db 244,1,240,5,3,10,244,2,240,12,5,9,244,3,240,7
	db 6,10,244,2,240,12,5,10,244,1,240,5,3,10,244,2
	db 240,12,5,10,244,3,240,7,6,9,244,2,240,12,5,10
	db 244,1,240,5,3,10,244,2,240,12,5,9,244,3,240,7
	db 6,10,244,2,240,12,5,10,244,1,240,5,3,10,244,2
	db 240,12,5,9,244,3,240,7,6,10,244,2,240,12,5,10
	db 244,1,240,5,3,9,244,2,240,12,5,10,244,3,240,7
	db 6,10,244,2,240,12,5,9,244,1,240,5,3,10,244,2
	db 240,12,5,10,244,3,240,7,6,9,244,2,240,12,5,10
	db 244,1,240,5,3,9,244,2,240,12,5,10,244,3,240,7
	db 6,10,244,2,240,12,5,9,244,1,240,5,3,10,244,2
	db 240,12,5,9,244,3,240,7,6,10,244,2,240,12,5,10
	db 244,1,240,5,3,9,244,2,240,12,5,10,244,3,240,7
	db 6,9,244,2,240,12,5,10,244,1,240,5,3,9,244,2
	db 240,12,5,10,244,3,240,7,6,9,244,2,240,12,5,10
	db 244,1,240,5,3,10,244,2,240,12,5,9,244,3,240,7
	db 6,10,244,2,240,12,5,9,244,1,240,5,3,10,244,3
	db 240,7,6,9,6,5,6,5,6,4,6,5,244,1,240,5
	db 3,9,244,2,240,12,5,10,244,3,240,7,6,9,244,2
	db 240,12,5,10,244,1,240,5,3,9,244,2,240,12,5,10
	db 244,3,240,7,6,9,244,2,240,12,5,9,244,1,240,5
	db 3,10,244,2,240,12,5,9,244,3,240,7,6,10,244,2
	db 240,12,5,9,244,1,240,5,3,9,244,2,240,12,5,10
	db 244,3,240,7,6,9,244,2,240,12,5,9,244,1,240,5
	db 3,10,244,2,240,12,5,9,244,3,240,7,6,9,244,2
	db 240,12,5,10,244,1,240,5,3,9,244,2,240,12,5,9
	db 244,3,240,7,6,10,244,2,240,12,5,9,244,1,240,5
	db 3,9,244,2,240,12,5,9,244,3,240,7,6,10,244,2
	db 240,12,5,9,244,1,240,5,3,9,244,2,240,12,5,9
	db 244,3,240,7,6,9,244,2,240,12,5,10,244,1,240,5
	db 3,9,244,2,240,12,5,9,244,3,240,7,6,9,244,2
	db 240,12,5,9,244,1,240,5,3,9,244,2,240,12,5,10
	db 244,3,240,7,6,9,244,2,240,12,5,9,244,1,240,5
	db 3,9,244,2,240,12,5,9,244,3,240,7,6,9,244,2
	db 240,12,5,9,244,1,240,5,3,9,244,2,240,12,5,9
	db 244,3,240,7,6,10,244,2,240,12,5,9,244,1,240,5
	db 3,9,244,2,240,12,5,9,244,3,240,7,6,9,244,2
	db 240,12,5,9,244,1,240,5,3,9,244,2,240,12,5,9
	db 244,3,240,7,6,9,244,2,240,12,5,9,244,1,240,5
	db 3,9,244,2,240,12,5,9,244,3,240,7,6,9,244,2
	db 240,12,5,9,244,1,240,5,3,9,244,3,240,7,6,9
	db 6,4,6,4,6,5,6,4,244,1,240,5,3,9,244,2
	db 240,12,5,9,244,3,240,7,6,9,244,2,240,12,5,9
	db 244,1,240,5,3,9,244,2,240,12,5,9,244,3,240,7
	db 6,9,244,2,240,12,5,9,244,1,240,5,3,8,244,2
	db 240,12,5,9,244,3,240,7,6,9,244,2,240,12,5,9
	db 244,1,240,5,3,9,244,2,240,12,5,9,244,3,240,7
	db 6,8,244,2,240,12,5,9,244,1,240,5,3,9,244,2
	db 240,12,5,9,244,3,240,7,6,9,244,2,240,12,5,8
	db 244,1,240,5,3,9,244,2,240,12,5,9,244,3,240,7
	db 6,9,244,2,240,12,5,8,244,1,240,5,3,9,244,2
	db 240,12,5,9,244,3,240,7,6,9,244,2,240,12,5,8
	db 244,1,240,5,3,9,244,2,240,12,5,9,244,3,240,7
	db 6,8,244,2,240,12,5,9,244,1,240,5,3,9,244,2
	db 240,12,5,8,244,3,240,7,6,9,244,2,240,12,5,9
	db 244,1,240,5,3,8,244,2,240,12,5,9,244,3,240,7
	db 6,9,244,2,240,12,5,8,244,1,240,5,3,9,244,2
	db 240,12,5,8,244,3,240,7,6,9,244,2,240,12,5,9
	db 244,1,240,5,3,8,244,2,240,12,5,9,244,3,240,7
	db 6,8,244,2,240,12,5,9,244,1,240,5,3,8,244,2
	db 240,12,5,9,244,3,240,7,6,8,244,2,240,12,5,9
	db 244,1,240,5,3,9,244,2,240,12,5,8,244,3,240,7
	db 6,9,244,2,240,12,5,8,244,1,240,5,3,9,244,2
	db 240,12,5,8,244,3,240,7,6,8,244,2,240,12,5,9
	db 244,1,240,5,3,8,244,3,240,7,6,9,6,4,6,4
	db 6,5,6,4,244,1,240,5,3,8,244,2,240,12,5,9
	db 244,3,240,7,6,8,244,2,240,12,5,8,244,1,240,5
	db 3,9,244,2,240,12,5,8,244,3,240,7,6,9,244,2
	db 240,12,5,8,244,1,240,5,3,8,244,2,240,12,5,9
	db 244,3,240,7,6,8,244,2,240,12,5,8,244,1,240,5
	db 3,9,244,2,240,12,5,8,244,3,240,7,6,9,244,2
	db 240,12,5,8,244,1,240,5,3,8,244,2,240,12,5,8
	db 244,3,240,7,6,9,244,2,240,12,5,8,244,1,240,5
	db 3,8,244,2,240,12,5,9,244,3,240,7,6,8,244,2
	db 240,12,5,8,244,1,240,5,3,8,244,2,240,12,5,9
	db 244,3,240,7,6,8,244,2,240,12,5,8,244,1,240,5
	db 3,8,244,2,240,12,5,9,244,3,240,7,6,8,244,2
	db 240,12,5,8,244,1,240,5,3,8,244,2,240,12,5,9
	db 244,3,240,7,6,8,244,2,240,12,5,8,244,1,240,5
	db 3,8,244,2,240,12,5,8,244,3,240,7,6,8,244,2
	db 240,12,5,9,244,1,240,5,3,8,244,2,240,12,5,8
	db 244,3,240,7,6,8,244,2,240,12,5,8,244,1,240,5
	db 3,8,244,2,240,12,5,8,244,3,240,7,6,9,244,2
	db 240,12,5,8,244,1,240,5,3,8,244,2,240,12,5,8
	db 244,3,240,7,6,8,244,2,240,12,5,8,244,1,240,5
	db 3,8,244,2,240,12,5,8,244,3,240,7,6,8,244,2
	db 240,12,5,8,244,1,240,5,3,8,244,2,240,12,5,8
	db 244,3,240,7,6,8,244,2,240,12,5,8,244,1,240,5
	db 3,8,244,3,240,7,6,8,6,4,6,5,6,4,6,4
	db 244,1,240,5,3,8,244,2,240,12,5,7,244,3,240,7
	db 6,8,244,2,240,12,5,8,244,1,240,5,3,8,244,2
	db 240,12,5,8,244,3,240,7,6,8,244,2,240,12,5,8
	db 244,1,240,5,3,8,244,2,240,12,5,8,244,3,240,7
	db 6,8,244,2,240,12,5,8,244,1,240,5,3,8,244,2
	db 240,12,5,8,244,3,240,7,6,8,244,2,240,12,5,8
	db 244,1,240,5,3,8,244,2,240,12,5,7,244,3,240,7
	db 6,8,244,2,240,12,5,8,244,1,240,5,3,8,244,2
	db 240,12,5,8,244,3,240,7,6,8,244,2,240,12,5,8
	db 244,1,240,5,3,8,244,2,240,12,5,7,244,3,240,7
	db 6,8,244,2,240,12,5,8,244,1,240,5,3,8,244,2
	db 240,12,5,8,244,3,240,7,6,7,244,2,240,12,5,8
	db 244,1,240,5,3,8,244,2,240,12,5,8,244,3,240,7
	db 6,8,244,2,240,12,5,7,244,1,240,5,3,8,244,2
	db 240,12,5,8,244,3,240,7,6,8,244,2,240,12,5,7
	db 244,1,240,5,3,8,244,2,240,12,5,8,244,3,240,7
	db 6,8,244,2,240,12,5,7,244,1,240,5,3,8,244,2
	db 240,12,5,8,244,3,240,7,6,8,244,2,240,12,5,7
	db 244,1,240,5,3,8,244,2,240,12,5,8,244,3,240,7
	db 6,7,244,2,240,12,5,8,244,1,240,5,3,8,244,2
	db 240,12,5,7,244,3,240,7,6,8,244,2,240,12,5,8
	db 244,1,240,5,3,7,244,2,240,12,5,8,244,3,240,7
	db 6,8,244,2,240,12,5,7,244,1,240,5,3,8,244,3
	db 240,7,6,7,6,4,6,4,6,4,6,4,244,1,240,5
	db 3,7,244,2,240,12,5,8,244,3,240,7,6,7,244,2
	db 240,12,5,8,244,1,240,5,3,8,244,2,240,12,5,7
	db 244,3,240,7,6,8,244,2,240,12,5,7,244,1,240,5
	db 3,8,244,2,240,12,5,7,244,3,240,7,6,8,244,2
	db 240,12,5,8,244,1,240,5,3,7,244,2,240,12,5,8
	db 244,3,240,7,6,7,244,2,240,12,5,8,244,1,240,5
	db 3,7,244,2,240,12,5,8,244,3,240,7,6,7,244,2
	db 240,12,5,8,244,1,240,5,3,7,244,2,240,12,5,8
	db 244,3,240,7,6,7,244,2,240,12,5,8,244,1,240,5
	db 3,7,244,2,240,12,5,7,244,3,240,7,6,8,244,2
	db 240,12,5,7,244,1,240,5,3,8,244,2,240,12,5,7
	db 244,3,240,7,6,8,244,2,240,12,5,7,244,1,240,5
	db 3,8,244,2,240,12,5,7,244,3,240,7,6,7,244,2
	db 240,12,5,8,244,1,240,5,3,7,244,2,240,12,5,8
	db 244,3,240,7,6,7,244,2,240,12,5,7,244,1,240,5
	db 3,8,244,2,240,12,5,7,244,3,240,7,6,7,244,2
	db 240,12,5,8,244,1,240,5,3,7,244,2,240,12,5,7
	db 244,3,240,7,6,8,244,2,240,12,5,7,244,1,240,5
	db 3,7,244,2,240,12,5,8,244,3,240,7,6,7,244,2
	db 240,12,5,7,244,1,240,5,3,8,244,2,240,12,5,7
	db 244,3,240,7,6,7,244,2,240,12,5,8,244,1,240,5
	db 3,7,244,2,240,12,5,7,244,3,240,7,6,8,244,2
	db 240,12,5,7,244,1,240,5,3,7,244,3,240,7,6,7
	db 6,4,6,4,6,3,6,4,244,1,240,5,3,7,244,2
	db 240,12,5,7,244,3,240,7,6,8,244,2,240,12,5,7
	db 244,1,240,5,3,7,244,2,240,12,5,7,244,3,240,7
	db 6,7,244,2,240,12,5,8,244,1,240,5,3,7,244,2
	db 240,12,5,7,244,3,240,7,6,7,244,2,240,12,5,7
	db 244,1,240,5,3,8,244,2,240,12,5,7,244,3,240,7
	db 6,7,244,2,240,12,5,7,244,1,240,5,3,7,244,2
	db 240,12,5,7,244,3,240,7,6,8,244,2,240,12,5,7
	db 244,1,240,5,3,7,244,2,240,12,5,7,244,3,240,7
	db 6,7,244,2,240,12,5,7,244,1,240,5,3,7,244,2
	db 240,12,5,7,244,3,240,7,6,8,244,2,240,12,5,7
	db 244,1,240,5,3,7,244,2,240,12,5,7,244,3,240,7
	db 6,7,244,2,240,12,5,7,244,1,240,5,3,7,244,2
	db 240,12,5,7,244,3,240,7,6,7,244,2,240,12,5,7
	db 244,1,240,5,3,7,244,2,240,12,5,7,244,3,240,7
	db 6,8,244,2,240,12,5,7,244,1,240,5,3,7,244,2
	db 240,12,5,7,244,3,240,7,6,7,244,2,240,12,5,7
	db 244,1,240,5,3,7,244,2,240,12,5,7,244,3,240,7
	db 6,7,244,2,240,12,5,7,244,1,240,5,3,7,244,2
	db 240,12,5,7,244,3,240,7,6,7,244,2,240,12,5,7
	db 244,1,240,5,3,7,244,2,240,12,5,7,244,3,240,7
	db 6,7,244,2,240,12,5,7,244,1,240,5,3,7,244,2
	db 240,12,5,7,244,3,240,7,6,6,244,2,240,12,5,7
	db 0
_song3_v0__9:
	db 255,240,0
_song3_v1__9:
	db 255,240,0
_song3_v2__9:
	db 255,240,0
_song3_v3__9:
	db 255,240,0
_song4_v0__9:
	db 244,10,240,4,37,14,42,14,46,28,44,14,42,14,37,28
	db 39,14,42,14,47,28,46,14,42,14,39,28,41,14,44,14
	db 49,28,47,14,44,14,41,28,42,56,37,28,42,28,46,14
	db 42,14,39,28,42,14,46,14,51,28,47,14,46,14,44,14
	db 42,14,39,28,42,28,44,14,41,14,37,14,41,14,44,28
	db 47,28,46,56,42,56,0
_song4_v1__9:
	db 244,6,240,6,6,14,18,14,6,14,18,14,6,14,18,14
	db 6,14,18,14,11,14,23,14,11,14,23,14,11,14,23,14
	db 11,14,23,14,1,14,13,14,1,14,13,14,1,14,13,14
	db 1,14,13,14,6,14,18,14,6,14,18,14,6,14,18,14
	db 6,14,18,14,3,14,15,14,3,14,15,14,3,14,15,14
	db 3,14,15,14,11,14,23,14,11,14,23,14,11,14,23,14
	db 11,14,23,14,1,14,13,14,1,14,13,14,1,14,13,14
	db 1,14,13,14,6,14,18,14,6,14,18,14,6,14,18,14
	db 6,14,18,14,0
_song4_v2__9:
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
_song4_v3__9:
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
_song5_v0__9:
	db 244,10,240,4,34,32,33,32,32,32,31,32,30,128,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,240,0
_song5_v1__9:
	db 244,6,240,6,3,128,3,128,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,240,255,240
	db 0
_song5_v2__9:
	db 244,13,240,8,18,128,15,128,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,240,255,240
	db 0
_song5_v3__9:
	db 244,1,240,5,3,128,255,128,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,240,255,240
	db 0
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
	db 0,0
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
_pals__19_L2654:
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
_crowd_pal__31_L5022:
	db 6,8,10
_pano_slot__32:
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
	db 43,29
	db 6
	db 50
__DataROM_END:
__Bss_START equ 04000h
__Bss_END equ 05766h
__DataRAM_START equ 05766h
__RAM_END equ 057CEh
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
_save_buf__0 equ 040F8h
_save_dirty__0 equ 041F8h
_map_px__0 equ 041F9h
_map_py__0 equ 04205h
_map_n__0 equ 04211h
_map_seg__0 equ 04212h
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
_body__29 equ 04692h
_car_variant__29 equ 046B2h
_car_wheel_dx__29 equ 046B3h
_car_tile_base__29 equ 046B4h
_lean_hold__29 equ 046B6h
_lean_side__29 equ 046B7h
_lean_wait__29 equ 046B8h
_bump_phase__29 equ 046B9h
_car_last_x__29 equ 046BAh
_car_last_top__29 equ 046BCh
_art__30 equ 046BEh
_road_course__30 equ 046D6h
_road_grade__30 equ 046D7h
_band_pitch__30 equ 046D8h
_climb_room__30 equ 046DAh
_descent_room__30 equ 046DBh
_band_shift__30 equ 046DCh
_id_xy_a__30 equ 046DEh
_id_xy_b__30 equ 04810h
_id_xy_done__30 equ 04942h
_id_xy_last__30 equ 04946h
_id_raster__30 equ 0494Ah
_id_shear__30 equ 0495Eh
_id_sl__30 equ 049DEh
_id_bandcol_a__30 equ 04A9Eh
_id_bandcol_b__30 equ 04BD0h
_bc_top__30 equ 04D02h
_id_bandcol_done__30 equ 04D04h
_id_bandstream__30 equ 04D08h
_band_phase__30 equ 04D16h
_id_dxc__30 equ 04D18h
_id_w_lat__30 equ 04E18h
_id_w_curve__30 equ 04E58h
_id_half__30 equ 04E98h
_id_src__30 equ 04ED8h
_band_top__30 equ 04F18h
_band_mid__30 equ 04F1Ch
_band_tree__30 equ 04F20h
_band_bg_first__30 equ 04F24h
_id_buf__30 equ 04F26h
_pan_head__30 equ 04F28h
_pan_lat__30 equ 04F2Ah
_pan_fine__30 equ 04F2Ch
_band_held__30 equ 04F2Dh
_band_wait__30 equ 04F2Eh
_id_ahead__30 equ 04F30h
_id_curve_cm__30 equ 04FB0h
_wide_k0__30 equ 04FB2h
_rally_of__30 equ 04FB3h
_rally_src__30 equ 051B4h
_rally_used__30 equ 053B2h
_rally_scanned__30 equ 053B3h
_band_col__30 equ 053B4h
_road_dma_live__30 equ 053BCh
_road_dma_depth__30 equ 053BDh
_id_curve_dx__30 equ 053BEh
_scn_phase__31 equ 0543Eh
_scn_frac__31 equ 05440h
_scn_passed__31 equ 05442h
_scn_mode__31 equ 05443h
_pano_base__32 equ 05444h
_obj_base__32 equ 05446h
_obj_end__32 equ 05448h
_pano_end__32 equ 0544Ah
_objmap__32 equ 0544Ch
_kind_l__32 equ 0564Ch
_kind_r__32 equ 0564Dh
_cur_pals__32 equ 0564Eh
_cur_backdrop__32 equ 056B6h
_cur_road__32 equ 056B8h
_cur_band__32 equ 056C0h
_cur_spr__32 equ 056C8h
_next_slot__32 equ 056F8h
_cars__33 equ 056FAh
_trf_tiles__33 equ 0575Ch
_car_d__33 equ 0575Eh
_half_wheel__33 equ 05760h
_dens_min__33 equ 05761h
_dens_max__33 equ 05762h
_target__33 equ 05763h
_cooldown__33 equ 05764h
_hard__33 equ 05765h
_car_tuned__0 equ 05766h
_roll_loaded__0 equ 05774h
_hiscore__0 equ 05776h
_eng_attn__10 equ 05786h
_bb_r0__12 equ 05787h
_sig_prev__12 equ 05788h
_s_current__13 equ 0578Ah
_s_last_slot__13 equ 0578Bh
_ngpc_pad_held equ 0578Ch
_ngpc_pad_pressed equ 0578Dh
_ngpc_pad_released equ 0578Eh
_ngpc_pad_repeat equ 0578Fh
_s_pad_prev__14 equ 05790h
_s_repeat_delay__14 equ 05791h
_s_repeat_rate__14 equ 05792h
_s_vbl_down__14 equ 05793h
_s_vbl_prev__14 equ 05794h
_g_vb_counter equ 05795h
_s_is_color__15 equ 05796h
_s_language__15 equ 05797h
_s_power_hold__16_L2304 equ 05798h
_track_seg equ 0579Ah
_free_seed equ 0579Eh
_seed__19 equ 057A0h
_cur_song__22 equ 057A2h
_h_time__26 equ 057A3h
_h_kmh__26 equ 057A4h
_h_gear__26 equ 057A5h
_h_prog__26 equ 057A6h
_h_stage__26 equ 057A7h
_id_spr_priority equ 057A8h
_car_at_x__29 equ 057AAh
_car_stand__30 equ 057ACh
_grade_hi__30 equ 057ADh
_grade_lo__30 equ 057AEh
_band_first__30 equ 057AFh
_band_count__30 equ 057B0h
_band_bg_end__30 equ 057B1h
_road_top__30 equ 057B3h
_road_plane0__30 equ 057B4h
_road_bottom__30 equ 057B5h
_road_lines__30 equ 057B6h
_road_base_x__30 equ 057B7h
_id_xy__30 equ 057B8h
_id_xy_live__30 equ 057BCh
_id_bandcol__30 equ 057C0h
_road_band_pal__30 equ 057C4h
_bc_rest__30 equ 057C6h
_rng__33 equ 057CAh
_trf_cap__33 equ 057CCh
_trf_spr_end equ 057CDh

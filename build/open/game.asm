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
	ld xwa,_gfx_legs
	ld c,(_cur_leg)
	extz bc
	muls xbc,22
	add xwa,xbc
	ld a,(xwa+21)
	push xwa
	ld xwa,_gfx_legs
	ld c,(_cur_leg)
	extz bc
	muls xbc,22
	add xwa,xbc
	ld a,(xwa+20)
	push xwa
	call _traffic_reset
	lda xsp,(xsp+8)
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
	ldb (_time_left__0),74
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
L270:
	ret

; function advance
_advance__0:
	push xiz
	lda xsp,(xsp-10)
	ld c,(_speed__0)
	cp c,16
	jr uge,L284
	ld a,(_speed__0)
	extz wa
	mul xwa,3502
	srl 4,wa
	jr L285
L284:
	ld wa,3502
L285:
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
	jr nz,L286
	ld wa,(_track_frac__0)
	ld iy,wa
L286:
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
	jr L289
L287:
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
	jr ult,L290
	ldb (_seg_index__0),0
L290:
L289:
	ld wa,(_seg_pos__0)
	ld xbc,(_track_seg)
	ld e,(_seg_index__0)
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr uge,L287
L288:
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
	jr ge,L291
	incw 6,(_bend_now__0)
	jr L292
L291:
	ld wa,(_bend_now__0)
	ld bc,(xsp+8)
	add bc,6
	cp wa,bc
	jr le,L293
	decw 6,(_bend_now__0)
	jr L294
L293:
	ld wa,(xsp+8)
	ld (_bend_now__0),wa
L294:
L292:
	ld wa,ix
	jr L283
L283:
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
L296:
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
	jr z,L301
	ld xwa,(xsp+4)
	push xwa
	ld wa,5
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L301:
	ld xwa,(xsp+8)
	cp xwa,0
	jr z,L302
	ld xwa,(xsp+8)
	push xwa
	ld wa,7
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L302:
	ld a,(xsp+12)
	ld (_msg_timer__0),a
	call _banner_dirty
L300:
	ret

; function count_message
_count_message__0:
	ld wa,12
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld xwa,(xsp+4)
	cp xwa,0
	jr z,L306
	ld xwa,(xsp+4)
	push xwa
	ld wa,12
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L306:
	ld a,(xsp+8)
	ld (_cnt_timer__0),a
L305:
	ret

; function tick_message
_tick_message__0:
	ld a,(_msg_timer__0)
	cp a,0
	jr z,L313
	decb 1,(_msg_timer__0)
	ld a,(_msg_timer__0)
	cp a,0
	jr nz,L314
	ld wa,5
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld wa,7
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	call _banner_dirty
L314:
L313:
	ld a,(_cnt_timer__0)
	cp a,0
	jr z,L315
	decb 1,(_cnt_timer__0)
	ld a,(_cnt_timer__0)
	cp a,0
	jr nz,L316
	ld wa,12
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
L316:
L315:
L312:
	ret

; function leg_end
_leg_end__0:
	lda xsp,(xsp-4)
	call _course_is_last_stage
	cp a,0
	jr z,L322
	ldb (_state__0),4
	ldb (_state_timer__0),0
	ldb (_goal_reached__0),1
	ld wa,0
	push xwa
	ld xwa,_S0_4
	push xwa
	ld xwa,_S0_5
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
	jp L321
L322:
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
	ld xbc,_extend_time__0
	ld e,(_cur_stage)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	ld (xsp+2),wa
	ld bc,(xsp+2)
	cp bc,99
	jr ule,L323
	ld wa,99
	jr L324
L323:
	ld wa,(xsp+2)
L324:
	ld (_time_left__0),a
	ldb (_flash_step__0),1
	ld wa,75
	push xwa
	ld xwa,_S0_6
	push xwa
	ld xwa,_S0_7
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
L321:
	lda xsp,(xsp+4)
	ret

; function tick_flash
_tick_flash__0:
	ld a,(_flash_step__0)
	cp a,0
	jr nz,L332
	jr L330
L332:
	ld a,(_flash_step__0)
	cp a,5
	jr nz,L333
	ld a,(_cur_leg)
	push xwa
	call _theme_apply
	lda xsp,(xsp+4)
	ld xwa,_gfx_legs
	ld c,(_cur_leg)
	extz bc
	muls xbc,22
	add xwa,xbc
	ld a,(xwa+21)
	push xwa
	ld xwa,_gfx_legs
	ld c,(_cur_leg)
	extz bc
	muls xbc,22
	add xwa,xbc
	ld a,(xwa+20)
	push xwa
	call _traffic_reset
	lda xsp,(xsp+8)
L333:
	ld xwa,_lv__0_L331
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
	jr ule,L334
	ldb (_flash_step__0),0
L334:
L330:
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
L336:
	lda xsp,(xsp+4)
	ret

; function title_option
_title_option__0:
	push xiz
	lda xsp,(xsp-2)
	ld wa,0
	ld izl,a
	jr L344
L342:
	inc 1,izl
L344:
	ld xwa,(xsp+14)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L342
L343:
	ld a,(xsp+10)
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld wa,0
	push xwa
	ld wa,98
	push xwa
	ld a,(xsp+18)
	push xwa
	ld wa,1
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_put_tile
	lda xsp,(xsp+20)
	ld wa,0
	push xwa
	ld wa,99
	push xwa
	ld a,(xsp+18)
	push xwa
	ld wa,18
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_put_tile
	lda xsp,(xsp+20)
	ld xwa,(xsp+14)
	push xwa
	ld a,(xsp+14)
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
L341:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function title_station_text
_title_station_text__0:
	ld xwa,_station_name__0
	ld c,(_station__0)
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld wa,9
	push xwa
	call _title_option__0
	lda xsp,(xsp+8)
L346:
	ret

; function title_gear_text
_title_gear_text__0:
	ld xwa,_S0_8
	push xwa
	ld wa,10
	push xwa
	ld wa,2
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
L348:
	ret

; function title_screen
_title_screen__0:
	push xiz
	lda xsp,(xsp-6)
	push xix
	push xiy
	call _hud_clear_top
	pop xiy
	pop xix
	push xix
	push xiy
	ld wa,18
	push xwa
	ld wa,15
	push xwa
	call _clear_hud_rows__0
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	ld iy,0
	jr L368
L365:
	ld xwa,_gfx_logo_tiles__0
	ld bc,iy
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,40992
	ld de,iy
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L367:
	inc 1,iy
L368:
	ld wa,iy
	cp wa,224
	jr ult,L365
L366:
	push xix
	push xiy
	ld wa,4095
	push xwa
	ld wa,255
	push xwa
	ld wa,771
	push xwa
	ld wa,0
	push xwa
	ld wa,4
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xiy
	pop xix
	push xix
	push xiy
	ld wa,255
	push xwa
	ld wa,143
	push xwa
	ld wa,771
	push xwa
	ld wa,0
	push xwa
	ld wa,5
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xiy
	pop xix
	push xix
	push xiy
	ld wa,143
	push xwa
	ld wa,2127
	push xwa
	ld wa,771
	push xwa
	ld wa,0
	push xwa
	ld wa,6
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xiy
	pop xix
	ld ixl,0
	jr L372
L369:
	ld izl,0
	jr L376
L373:
	ld xwa,_gfx_logo_map__0
	ld c,ixl
	extz bc
	mul xbc,20
	ld e,izl
	extz de
	add bc,de
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+4),a
	ld c,(xsp+4)
	cp c,0
	jr z,L377
	ld wa,2
	ld c,(xsp+4)
	extz bc
	add wa,bc
	ld bc,4
	ld e,ixl
	extz de
	add bc,de
	sll 9,bc
	or wa,bc
	jr L378
L377:
	ld wa,0
L378:
	ld xbc,36864
	ld e,ixl
	extz de
	add de,2
	sll 5,de
	ld l,izl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L375:
	inc 1,izl
L376:
	ld a,izl
	cp a,20
	jr ult,L373
L374:
L371:
	inc 1,ixl
L372:
	ld a,ixl
	cp a,3
	jr ult,L369
L370:
	push xix
	push xiy
	ld xwa,_S0_9
	push xwa
	ld wa,5
	push xwa
	ld wa,2
	push xwa
	ld wa,3
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	pop xiy
	pop xix
	push xix
	push xiy
	call _title_station_text__0
	pop xiy
	pop xix
	push xix
	push xiy
	call _title_gear_text__0
	pop xiy
	pop xix
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	push xix
	push xiy
	ld xwa,_S0_10
	push xwa
	ld wa,11
	push xwa
	ld wa,4
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	pop xiy
	pop xix
	push xix
	push xiy
	ld wa,1
	push xwa
	ld xwa,(_hiscore__0)
	push xwa
	ld wa,11
	push xwa
	ld wa,7
	push xwa
	call _print_score7__0
	lda xsp,(xsp+16)
	pop xiy
	pop xix
	push xix
	push xiy
	ld a,64
	push xwa
	ld a,28
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xiy
	pop xix
L364:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function title_blink
_title_blink__0:
	ld a,(xsp+4)
	extz wa
	and wa,31
	cp wa,0
	jr nz,L384
	ld xwa,_S0_11
	push xwa
	ld wa,13
	push xwa
	ld wa,2
	push xwa
	ld wa,1
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	jr L385
L384:
	ld a,(xsp+4)
	extz wa
	and wa,31
	cp wa,20
	jr nz,L386
	ld wa,13
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
L386:
L385:
L383:
	ret

; function trophy_load
_trophy_load__0:
	push xiz
	lda xsp,(xsp-2)
	ld iz,0
	jr L396
L393:
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
L395:
	inc 1,iz
L396:
	ld wa,iz
	cp wa,48
	jr ult,L393
L394:
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
L392:
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
	jr nz,L408
	ld wa,1
	jr L409
L408:
	ld wa,0
L409:
	ld (xsp+1),a
	ld ixl,0
	jp L413
L410:
	ld xwa,_gfx_trophy_cells
	ld c,ixl
	extz bc
	mul xbc,3
	extz xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+2),xwa
L414:
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
L416:
L415:
L412:
	inc 1,ixl
L413:
	ld a,ixl
	cp a,6
	jp ult,L410
L411:
L407:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function result_screen
_result_screen__0:
	push xiz
	lda xsp,(xsp-2)
	call _hud_clear_top
	ld wa,18
	push xwa
	ld wa,15
	push xwa
	call _clear_hud_rows__0
	lda xsp,(xsp+8)
	ld c,(_goal_reached__0)
	cp c,0
	jr z,L428
	ld xwa,_S0_12
	jr L429
L428:
	ld xwa,_S0_13
L429:
	push xwa
	ld wa,2
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
	ld xwa,_S0_14
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
	ld xwa,_S0_15
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
	jr L433
L430:
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
	jr uge,L434
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
L434:
L432:
	inc 1,izl
L433:
	ld a,izl
	cp a,(_cur_stage)
	jr ule,L430
L431:
	ld xwa,(_score__0)
	cp xwa,(_hiscore__0)
	jr ule,L435
	ld xwa,(_score__0)
	ld (_hiscore__0),xwa
	ld xwa,_S0_16
	push xwa
	ld wa,9
	push xwa
	call _hud_message
	lda xsp,(xsp+8)
L435:
	call _banner_hide
	ld a,64
	push xwa
	ld a,28
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	ld a,(_goal_reached__0)
	cp a,0
	jr z,L436
	call _trophy_load__0
	ld xwa,_route_hist
	ld c,(_cur_stage)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	call _ending_start
	lda xsp,(xsp+4)
L436:
L427:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function smoke_init
_smoke_init__0:
	push xiz
	lda xsp,(xsp-2)
	ld ixl,0
	jr L450
L447:
	ld izl,0
	jr L454
L451:
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
L453:
	inc 1,izl
L454:
	ld a,izl
	cp a,8
	jr ult,L451
L452:
L449:
	inc 1,ixl
L450:
	ld a,ixl
	cp a,4
	jr ult,L447
L448:
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
L446:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function smoke_draw
_smoke_draw__0:
	push xiz
	lda xsp,(xsp-24)
	ld a,(xsp+32)
	cp a,0
	jr nz,L478
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
	jp L477
L478:
	ld a,(_smoke_t__0)
	extz wa
	and wa,7
	cp wa,0
	jr nz,L479
	push xix
	push xiy
	ld wa,7
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L479:
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
	jp L483
L480:
	ld c,ixl
	cp c,0
	jr nz,L484
	ld wa,(xsp+0)
	sub wa,11
	ld c,(_smoke_t__0)
	extz bc
	sra 2,bc
	and bc,1
	sub wa,bc
	jr L485
L484:
	ld wa,(xsp+0)
	add wa,27
	ld c,(_smoke_t__0)
	extz bc
	sra 2,bc
	and bc,1
	add wa,bc
L485:
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
	jp L489
L486:
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
	jr z,L490
	ld a,1
	sub a,izl
	extz wa
	jr L491
L490:
	ld a,izl
	extz wa
L491:
	ld (xsp+9),a
	ld wa,(xsp+6)
	ld c,izl
	extz bc
	sll 3,bc
	add wa,bc
	ld (xsp+10),wa
	ld wa,(xsp+10)
	cp wa,65529
	jr lt,L493
	ld wa,(xsp+10)
	cp wa,159
	jr le,L492
L493:
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
	jp L488
L492:
L494:
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
	jr z,L497
	ld wa,128
	jr L498
L497:
	ld wa,0
L498:
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
L496:
L495:
L488:
	inc 1,izl
L489:
	ld a,izl
	cp a,2
	jp ult,L486
L487:
L482:
	inc 1,ixl
L483:
	ld a,ixl
	cp a,2
	jp ult,L480
L481:
L477:
	lda xsp,(xsp+24)
	pop xiz
	ret

; function engine_sound
_engine_sound__0:
	push xiz
	lda xsp,(xsp-10)
	ld c,(_gear__0)
	cp c,0
	jr nz,L514
	ld wa,137
	jr L515
L514:
	ld wa,224
L515:
	ld (xsp+0),wa
	ld a,(_speed__0)
	extz wa
	mul xwa,255
	extz xwa
	div xwa,(xsp+0)
	ld ix,wa
	ld wa,ix
	cp wa,255
	jr ule,L516
	ld ix,255
L516:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L517
	ld ix,0
L517:
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
	jr z,L518
	ld wa,iz
	ld bc,iz
	ld l,(_offroad__0)
	cp l,0
	jr z,L519
	ld l,(_speed__0)
	cp l,20
	jr ule,L519
	ld de,3
	jr L520
L519:
	ld de,5
L520:
	cp e,0
	jr z,L522
L521:
	srl 1,bc
	djnz e,L521
L522:
	add wa,bc
	ld iz,wa
L518:
	ld c,(_ngpc_pad_held)
	extz bc
	and bc,16
	cp bc,0
	jr z,L523
	ld wa,4
	jr L524
L523:
	ld wa,6
L524:
	ld iyl,a
	ld a,(_state__0)
	cp a,4
	jr z,L526
	ld a,(_state__0)
	cp a,3
	jr nz,L525
L526:
	ld iyl,9
L525:
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
L513:
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
	jr ge,L543
	ld wa,ix
	cp wa,65484
	jr gt,L542
L543:
	ld wa,0
	jp L541
L542:
	ldb (xsp+1),0
	jr L547
L544:
	inc 1,izl
	ld a,izl
	cp a,(_track_len)
	jr ult,L548
	ld izl,0
L548:
	ld xwa,(_track_seg)
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld wa,(xwa+2)
	ld ix,wa
	ld wa,ix
	cp wa,52
	jr ge,L550
	ld wa,ix
	cp wa,65484
	jr gt,L549
L550:
	ld wa,iy
	cp wa,150
	jr uge,L551
	ld wa,0
	jr L541
L551:
	ld bc,ix
	cp bc,0
	jr le,L552
	ld wa,1
	jr L553
L552:
	ld wa,65535
L553:
	jr L541
L549:
	ld wa,iy
	ld xbc,(_track_seg)
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld iy,wa
L546:
	incb 1,(xsp+1)
L547:
	ld a,(xsp+1)
	cp a,6
	jr uge,L554
	ld wa,iy
	cp wa,1300
	jr ult,L544
L554:
L545:
	ld wa,0
	jr L541
L541:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function game_tick
_game_tick__0:
	push xiz
	lda xsp,(xsp-4)
	ld a,(_state__0)
	cp a,0
	jp nz,L636
	ld a,(_state_timer__0)
	push xwa
	call _title_blink__0
	lda xsp,(xsp+4)
	incb 1,(_state_timer__0)
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,12
	cp wa,0
	jr z,L637
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,8
	cp wa,0
	jr z,L638
	ld a,(_station__0)
	extz wa
	add wa,1
	and wa,3
	ld (_station__0),a
	jr L639
L638:
	ld a,(_station__0)
	extz wa
	add wa,4
	sub wa,1
	and wa,3
	ld (_station__0),a
L639:
	call _title_station_text__0
	ld a,(_station__0)
	push xwa
	call _music_play
	lda xsp,(xsp+4)
L637:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,16
	cp wa,0
	jr z,L640
	call _new_game__0
	ldb (_state__0),1
	ldb (_state_timer__0),0
L640:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
	jp L641
L636:
	ld a,(_state__0)
	cp a,5
	jr nz,L642
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,16
	cp wa,0
	jr z,L643
	ld a,(_state_timer__0)
	cp a,30
	jr ule,L643
	ldb (_state__0),0
	call _new_game__0
	call _title_screen__0
	ld a,(_station__0)
	push xwa
	call _music_play
	lda xsp,(xsp+4)
L643:
	ld a,(_state_timer__0)
	cp a,255
	jr uge,L644
	incb 1,(_state_timer__0)
L644:
	ld a,(_state_timer__0)
	cp a,30
	jr ule,L645
	ld a,(_state_timer__0)
	push xwa
	call _title_blink__0
	lda xsp,(xsp+4)
L645:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
	jr L646
L642:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,64
	cp wa,0
	jr z,L647
	ld c,(_paused__0)
	cp c,0
	jr nz,L648
	ld wa,1
	jr L649
L648:
	ld wa,0
L649:
	ld (_paused__0),a
	ld a,(_paused__0)
	cp a,0
	jr z,L650
	ld wa,0
	push xwa
	ld wa,0
	exts xwa
	push xwa
	ld xwa,_S0_17
	push xwa
	call _message__0
	lda xsp,(xsp+12)
	jr L651
L650:
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
L651:
L647:
L646:
L641:
	ld a,(_paused__0)
	cp a,0
	jr z,L652
	jp L635
L652:
	ld a,(_state__0)
	cp a,1
	jp nz,L653
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
	jr nz,L655
	ld a,(xsp+0)
	cp a,4
	jr uge,L655
	ld wa,0
	push xwa
	ld xwa,_cd__0_L654
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
L655:
	incb 1,(_state_timer__0)
	ld a,(_state_timer__0)
	cp a,90
	jr ult,L656
	ldb (_state__0),2
	ld wa,30
	push xwa
	ld xwa,(_cd__0_L654+12)
	push xwa
	call _count_message__0
	lda xsp,(xsp+8)
	ld wa,1
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L656:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
L653:
	ld a,(_state__0)
	cp a,2
	jr z,L658
	ld a,(_state__0)
	cp a,3
	jr z,L658
	ld a,(_state__0)
	cp a,4
	jp nz,L657
L658:
	ld a,(_state__0)
	cp a,2
	jr nz,L660
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L659
L660:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
L659:
	call _drive__0
	call _advance__0
	ld a,(_state__0)
	cp a,2
	jp nz,L661
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
	jr L664
L662:
	ld a,(_sec_acc__0)
	sub a,60
	ld (_sec_acc__0),a
	ld a,(_time_left__0)
	cp a,0
	jr z,L665
	decb 1,(_time_left__0)
L665:
	ld a,(_time_left__0)
	cp a,0
	jr z,L666
	ld a,(_time_left__0)
	cp a,10
	jr ugt,L666
	ld wa,5
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L666:
L664:
	ld a,(_sec_acc__0)
	cp a,60
	jr uge,L662
L663:
	ld a,(_time_left__0)
	cp a,0
	jr nz,L667
	ldb (_state__0),3
	ldb (_state_timer__0),0
	ld wa,0
	push xwa
	ld wa,0
	exts xwa
	push xwa
	ld xwa,_S0_18
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
L667:
L661:
	ld wa,(_course_pos__0)
	push xwa
	call _course_fork_zone
	lda xsp,(xsp+4)
	ld (xsp+0),a
	ld a,(xsp+0)
	cp a,0
	jp z,L668
	call _course_is_last_stage
	cp a,0
	jp nz,L668
	ld a,(_last_fork_zone__0)
	cp a,0
	jr nz,L669
	ld wa,1
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	ld xwa,_S0_19
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
L669:
	ld a,(_fork_choice)
	cp a,0
	jr nz,L670
	ld wa,(_course_pos__0)
	add wa,850
	cp wa,(_leg_len)
	jr ult,L670
	ld bc,(_car_lat__0)
	cp bc,0
	jr le,L671
	ld wa,1
	jr L672
L671:
	ld wa,0
L672:
	push xwa
	call _course_decide
	lda xsp,(xsp+4)
	ld wa,3
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld a,(_fork_choice)
	cp a,2
	jr nz,L673
	ld xwa,_S0_20
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
	jr L674
L673:
	ld xwa,_S0_21
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
L674:
L670:
	jp L675
L668:
	ld a,(xsp+0)
	cp a,0
	jr z,L676
	call _course_is_last_stage
	cp a,0
	jr z,L676
	ld a,(_last_fork_zone__0)
	cp a,0
	jr nz,L677
	ld xwa,_S0_22
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
L677:
	ld wa,5
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L678
L676:
	ld a,(_cur_stage)
	cp a,0
	jr nz,L679
	ld wa,(_course_pos__0)
	cp wa,900
	jr uge,L679
	ld wa,5
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L680
L679:
	ld wa,(_course_pos__0)
	push xwa
	call _course_start_zone
	lda xsp,(xsp+4)
	cp a,0
	jr z,L681
	ld wa,2
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L682
L681:
	call _sharp_ahead__0
	ld (xsp+1),a
	ld c,(xsp+1)
	cp c,0
	jr le,L683
	ld wa,3
	jr L684
L683:
	ld c,(xsp+1)
	cp c,0
	jr ge,L685
	ld wa,4
	jr L686
L685:
	ld wa,0
L686:
L684:
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
L682:
L680:
L678:
L675:
	ld a,(xsp+0)
	ld (_last_fork_zone__0),a
	ld a,(_goal_reached__0)
	cp a,0
	jr nz,L687
	ld wa,(_course_pos__0)
	cp wa,(_leg_len)
	jr ult,L687
	ldb (_last_fork_zone__0),0
	call _leg_end__0
L687:
	ld a,(_speed__0)
	push xwa
	call _id_scenery_advance
	lda xsp,(xsp+4)
	ld a,(_state__0)
	cp a,2
	jp nz,L688
	ld a,(_crash_timer__0)
	cp a,0
	jp nz,L688
	ld a,(_speed__0)
	push xwa
	ld wa,(_car_lat__0)
	push xwa
	call _traffic_collide
	lda xsp,(xsp+8)
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,0
	jr nz,L689
	ld wa,147
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_scenery_hit
	lda xsp,(xsp+8)
	cp a,0
	jr z,L690
	ld a,(_speed__0)
	cp a,110
	jr ule,L691
	incb 1,(_dbg_scn)
	ldb (xsp+1),1
	jr L692
L691:
	ld wa,48
	ld (xsp+2),a
	ld a,(_speed__0)
	extz wa
	sra 1,wa
	ld (xsp+3),a
	ld a,(xsp+2)
	cp a,(xsp+3)
	jr ule,L693
	ld a,(xsp+3)
	ld (xsp+2),a
L693:
	ld c,(_speed__0)
	cp c,(xsp+2)
	jr ule,L694
	ld a,(_speed__0)
	sub a,(xsp+2)
	extz wa
	jr L695
L694:
	ld wa,0
L695:
	ld (_speed__0),a
	ld wa,4
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L692:
L690:
L689:
	ld a,(xsp+1)
	cp a,0
	jr z,L696
	ld a,(_speed__0)
	cp a,110
	jr ule,L697
	ldb (_crash_timer__0),90
	incb 1,(_dbg_crashes)
	ld wa,3
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	jr L698
L697:
	ld a,(_speed__0)
	extz wa
	sra 1,wa
	ld (_speed__0),a
	ld wa,4
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L698:
L696:
L688:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L699
	decb 1,(_crash_timer__0)
	ld c,(_speed__0)
	cp c,12
	jr ule,L700
	ld a,(_speed__0)
	sub a,12
	extz wa
	jr L701
L700:
	ld wa,0
L701:
	ld (_speed__0),a
	ld a,(_crash_timer__0)
	cp a,0
	jr nz,L702
	ld wa,(_car_lat__0)
	exts xwa
	divs xwa,2
	ld (_car_lat__0),wa
	ldb (_speed__0),0
	ldb (_gear__0),0
L702:
L699:
	ld c,(_state__0)
	cp c,2
	jr nz,L703
	push xwa
	ld wa,(_course_pos__0)
	push xwa
	call _course_fork_zone
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp c,0
	jr nz,L703
	ld wa,1
	jr L704
L703:
	ld wa,0
L704:
	push xwa
	ld a,(_speed__0)
	push xwa
	call _traffic_update
	lda xsp,(xsp+8)
	ld a,(_state__0)
	cp a,3
	jr nz,L705
	incb 1,(_state_timer__0)
	ld a,(_speed__0)
	cp a,0
	jr nz,L706
	ld a,(_state_timer__0)
	cp a,60
	jr ule,L706
	ldb (_state__0),5
	ldb (_state_timer__0),0
	call _result_screen__0
L706:
	jr L707
L705:
	ld a,(_state__0)
	cp a,4
	jr nz,L708
	incb 1,(_state_timer__0)
	ld a,(_state_timer__0)
	cp a,1
	jr nz,L709
	ld xwa,(_score__0)
	ld c,(_time_left__0)
	extz bc
	muls xbc,20000
	add xwa,xbc
	ld (_score__0),xwa
	ld izl,0
	jr L713
L710:
	ld wa,20000
	push xwa
	call _hud_score_add
	lda xsp,(xsp+4)
L712:
	inc 1,izl
L713:
	ld a,izl
	cp a,(_time_left__0)
	jr ult,L710
L711:
L709:
	ld a,(_speed__0)
	cp a,0
	jr nz,L714
	ld a,(_state_timer__0)
	cp a,60
	jr ule,L714
	ldb (_state__0),5
	ldb (_state_timer__0),0
	call _result_screen__0
L714:
L708:
L707:
L657:
L635:
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
	jr L764
L761:
	ld bc,(xsp+2)
	cp bc,0
	jr le,L765
	call _id_road_grade_hi
	exts wa
	jr L766
L765:
	call _id_road_grade_lo
	exts wa
	neg wa
L766:
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
L763:
	incw 1,(xsp+2)
L764:
	ld wa,(xsp+2)
	cp wa,6
	jr le,L761
L762:
	ld wa,147
	push xwa
	call _traffic_set_car_line
	lda xsp,(xsp+4)
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
L767:
	jr L773
L771:
	call _ngpc_vsync
L773:
	ld a,(_g_vb_counter)
	sub a,(_pace_prev__0)
	cp a,2
	jr ult,L771
L772:
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
	jr ule,L774
	ldb (xsp+10),3
	ld a,(xsp+8)
	ld c,(xsp+9)
	and c,1
	sub a,c
	ld (_pace_prev__0),a
	jr L775
L774:
	ld a,(_pace_prev__0)
	extz wa
	ld c,(xsp+10)
	extz bc
	sll 1,bc
	extz bc
	add wa,bc
	ld (_pace_prev__0),a
L775:
	call _ngpc_input_update
	call _audio_update
	incw 1,(_dbg_updates)
	ld a,(xsp+8)
	ld (_clock_prev__0),a
	ld izl,0
	jr L779
L776:
	ld wa,2
	push xwa
	call _game_tick__0
	lda xsp,(xsp+4)
	ld a,izl
	cp a,0
	jr nz,L780
	ldb (_ngpc_pad_pressed),0
L780:
L778:
	inc 1,izl
L779:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L776
L777:
	call _render_road__0
	call _tick_flash__0
	call _tick_message__0
	ld a,(_state__0)
	cp a,0
	jr z,L781
	ld a,(_state__0)
	cp a,5
	jr z,L781
	call _id_scenery_draw
	call _traffic_draw
L781:
	ld a,(_state__0)
	cp a,1
	jr z,L783
	ld a,(_state__0)
	cp a,2
	jr nz,L782
	ld a,(_cur_stage)
	cp a,0
	jr nz,L782
	ld wa,(_course_pos__0)
	cp wa,220
	jr uge,L782
L783:
	ld xwa,_S0_27
	push xwa
	ld wa,0
	push xwa
	ld wa,120
	ld bc,(_course_pos__0)
	sub wa,bc
	push xwa
	call _banner_show
	lda xsp,(xsp+12)
	jr L784
L782:
	ld a,(_state__0)
	cp a,2
	jr z,L786
	ld a,(_state__0)
	cp a,4
	jr z,L786
	ld a,(_state__0)
	cp a,3
	jr nz,L785
L786:
	call _course_is_last_stage
	cp a,0
	jr z,L785
	ld wa,(_course_pos__0)
	ld bc,(_leg_len)
	sub bc,1400
	cp wa,bc
	jr le,L785
	ld xwa,_S0_28
	push xwa
	ld wa,1
	push xwa
	ld wa,(_leg_len)
	ld bc,(_course_pos__0)
	sub wa,bc
	push xwa
	call _banner_show
	lda xsp,(xsp+12)
	jr L787
L785:
	call _banner_hide
L787:
L784:
	ld a,(_state__0)
	cp a,5
	jr nz,L788
	ld a,(_goal_reached__0)
	cp a,0
	jr z,L788
	call _trophy_draw__0
	call _ending_tick
L788:
	ld a,(_state__0)
	cp a,2
	jr z,L790
	ld a,(_state__0)
	cp a,1
	jr z,L790
	ld a,(_state__0)
	cp a,3
	jr z,L790
	ld a,(_state__0)
	cp a,4
	jr nz,L789
L790:
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
	jr nz,L791
	ld c,(_speed__0)
	cp c,123
	jr ult,L791
	ld c,(_g_vb_counter)
	extz bc
	and bc,8
	cp bc,0
	jr z,L791
	ld wa,2
	jr L792
L791:
	ld a,(_gear__0)
	extz wa
L792:
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
L789:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L793
	ld a,(_crash_timer__0)
	extz wa
	and wa,2
	cp wa,0
	jr z,L793
	ld wa,2
	push xwa
	ld c,(_crash_timer__0)
	extz bc
	and bc,4
	cp bc,0
	jr z,L794
	ld wa,1
	jr L795
L794:
	ld wa,65535
L795:
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_car_draw
	lda xsp,(xsp+12)
	jr L796
L793:
	ld c,(_offroad__0)
	cp c,0
	jr z,L797
	ld c,(_speed__0)
	cp c,20
	jr ule,L797
	ld wa,1
	jr L798
L797:
	ld wa,0
L798:
	push xwa
	ld a,(_car_lean__0)
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_car_draw
	lda xsp,(xsp+12)
L796:
	ld c,(_skid__0)
	cp c,0
	jr z,L799
	ld c,(_crash_timer__0)
	cp c,0
	jr nz,L799
	ld c,(_state__0)
	cp c,2
	jr nz,L799
	ld wa,1
	jr L800
L799:
	ld wa,0
L800:
	push xwa
	call _smoke_draw__0
	lda xsp,(xsp+4)
	ld a,(_offroad__0)
	cp a,0
	jr z,L801
	ld a,(_state__0)
	cp a,2
	jr nz,L801
	incb 1,(_dbg_off)
L801:
	ld a,(_state__0)
	cp a,2
	jr z,L803
	ld a,(_state__0)
	cp a,1
	jr z,L803
	ld a,(_state__0)
	cp a,3
	jr z,L803
	ld a,(_state__0)
	cp a,4
	jr nz,L802
L803:
	call _engine_sound__0
	jr L804
L802:
	call _player_engine_off
L804:
L769:
L770:
	jp L767
L768:
L760:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function player_engine
_player_engine:
	ld wa,(xsp+4)
	ld (_eng_div__8),wa
	ld a,(xsp+8)
	ld (_eng_attn__8),a
	ldb (_eng_on__8),1
L806:
	ret

; function player_engine_off
_player_engine_off:
	ldb (_eng_on__8),0
L808:
	ret

; function player_init
_player_init:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,28672
	ld xix,xwa
	ldw (0B8h),43690
	ld izl,0
	jr L822
L819:
	ld xwa,_z80drv__8
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
L821:
	inc 1,izl
L822:
	ld a,izl
	cp a,65
	jr ult,L819
L820:
	ldw (0B8h),21845
	ld izl,0
	jr L826
L823:
	ld wa,0
	ld xbc,_want_div__8
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,15
	ld xbc,_want_attn__8
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,65535
	ld xbc,_sent_div__8
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,255
	ld xbc,_sent_attn__8
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_sfx_frames__8
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_voice__8
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+15),a
L825:
	inc 1,izl
L826:
	ld a,izl
	cp a,4
	jr ult,L823
L824:
	ldb (_playing__8),0
	ld a,(_g_vb_counter)
	ld (_last_vbl__8),a
L818:
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
	jp L836
L833:
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	ld xbc,_voice__8
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
	ld xbc,_voice__8
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+4),xwa
	ld wa,0
	ld xbc,_voice__8
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+8),wa
	ld a,2
	ld xbc,_voice__8
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+13),a
	ld a,0
	ld xbc,_voice__8
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+14),a
	ld a,0
	ld xbc,_voice__8
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+15),a
	ld a,0
	ld xbc,_voice__8
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+12),a
	ld a,0
	ld xbc,_voice__8
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+16),a
L835:
	inc 1,izl
L836:
	ld a,izl
	cp a,4
	jp ult,L833
L834:
	ldb (_playing__8),1
	ld a,(_g_vb_counter)
	ld (_last_vbl__8),a
L832:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function player_stop
_player_stop:
	push xiz
	lda xsp,(xsp-2)
	ldb (_playing__8),0
	ld izl,0
	jr L846
L843:
	ld a,0
	ld xbc,_voice__8
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+15),a
L845:
	inc 1,izl
L846:
	ld a,izl
	cp a,4
	jr ult,L843
L844:
L842:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function voice_events
_voice_events__8:
	push xiz
	lda xsp,(xsp-2)
	ld xiz,(xsp+10)
	ld wa,0
	ld (xsp+0),a
	jp L863
L861:
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld ixl,a
	incb 1,(xsp+0)
	ld a,ixl
	cp a,0
	jr nz,L864
	ld xwa,(xiz+4)
	ld (xiz),xwa
	jp L863
L864:
	ld a,ixl
	cp a,240
	jr nz,L865
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld (xiz+13),a
	jp L863
L865:
	ld a,ixl
	cp a,244
	jr nz,L866
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld (xiz+14),a
	ld a,(xiz+14)
	cp a,17
	jr ule,L867
	ldb (xiz+14),0
L867:
	jr L863
L866:
	ld a,ixl
	cp a,255
	jr nz,L868
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	extz wa
	ld (xiz+8),wa
	ldb (xiz+15),0
	jr L863
L868:
	ld a,ixl
	cp a,240
	jr ult,L869
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	jr L863
L869:
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
	jr nz,L870
	ld a,ixl
	extz wa
	sub wa,1
	and wa,7
	ld (xiz+10),wa
	ldb (xiz+16),1
	jr L871
L870:
	push xix
	ld a,ixl
	push xwa
	call _note_div
	lda xsp,(xsp+4)
	pop xix
	ld (xiz+10),wa
L871:
L863:
	ld wa,(xiz+8)
	cp wa,0
	jr nz,L872
	ld a,(xsp+0)
	cp a,32
	jp ult,L861
L872:
L862:
L860:
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
	jr ule,L876
	ld izl,50
L876:
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
	jr L875
L875:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function flush
_flush__8:
	push xiz
	lda xsp,(xsp-10)
	ld wa,0
	ld (xsp+0),a
	ld xwa,28676
	ld xiy,xwa
	ld a,(07003h)
	cp a,0
	jr z,L893
	jp L892
L893:
	ld izl,0
	jp L897
L894:
	ld xwa,_want_div__8
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld ix,wa
	ld xwa,_want_attn__8
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+8),a
	ld a,izl
	cp a,3
	jr uge,L898
	ld wa,ix
	ld xbc,_sent_div__8
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L899
	ld a,(xsp+8)
	ld xbc,_sent_attn__8
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr nz,L899
	jp L896
L899:
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
	jr L900
L898:
	ld a,(_noise_trig__8)
	cp a,0
	jr nz,L901
	ld wa,ix
	cp wa,(_sent_div__8+6)
	jr nz,L901
	ld a,(xsp+8)
	cp a,(_sent_attn__8+3)
	jr nz,L901
	jp L896
L901:
	ld a,(_noise_trig__8)
	cp a,0
	jr nz,L903
	ld wa,ix
	cp wa,(_sent_div__8+6)
	jr z,L902
L903:
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
	jr L904
L902:
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
L904:
	ld a,240
	ld c,(xsp+8)
	and c,15
	or a,c
	ld (xiy+2),a
	ldb (_noise_trig__8),0
L900:
	ld wa,ix
	ld xbc,_sent_div__8
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+8)
	ld xbc,_sent_attn__8
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
L896:
	inc 1,izl
L897:
	ld a,izl
	cp a,4
	jr uge,L905
	ld a,(xsp+0)
	cp a,5
	jp ult,L894
L905:
L895:
	ld a,(xsp+0)
	cp a,0
	jr z,L906
	ld a,(xsp+0)
	ld (07003h),a
L906:
L892:
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
	sub a,(_last_vbl__8)
	ld iyl,a
	ld a,(xsp+0)
	ld (_last_vbl__8),a
	ld a,iyl
	cp a,8
	jr ule,L929
	ld iyl,8
L929:
	ld izl,0
	jp L933
L930:
	ld wa,15
	ld (xsp+3),a
	ld xwa,_want_div__8
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+4),wa
	ld a,(_playing__8)
	cp a,0
	jp z,L934
	ld xwa,_voice__8
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
	jr ule,L935
	ld wa,(xix+8)
	ld c,iyl
	extz bc
	sub wa,bc
	ld (xix+8),wa
	jr L936
L935:
	ldw (xix+8),0
	push xix
	push xiy
	ld a,izl
	push xwa
	ld xwa,xix
	push xwa
	call _voice_events__8
	lda xsp,(xsp+8)
	pop xiy
	pop xix
L936:
	ld a,(xix+12)
	cp a,250
	jr uge,L937
	ld a,(xix+12)
	add a,iyl
	ld (xix+12),a
L937:
	ld a,(xix+15)
	cp a,0
	jr z,L938
	ld xwa,_inst_tab__8
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
	jr ule,L939
	ld xwa,(xsp+10)
	ld a,(xwa+1)
	ld (xsp+14),a
L939:
	ld a,(xix+13)
	add a,(xsp+14)
	ld (xsp+3),a
	ld a,(xsp+3)
	cp a,15
	jr ule,L940
	ldb (xsp+3),15
L940:
	ld wa,(xix+10)
	ld (xsp+4),wa
	ld a,izl
	cp a,3
	jr nz,L941
	ld a,(xix+16)
	cp a,0
	jr z,L941
	ldb (xix+16),0
	ldb (_noise_trig__8),1
L941:
L938:
L934:
	ld a,izl
	cp a,2
	jr nz,L942
	ld a,(_eng_on__8)
	cp a,0
	jr z,L942
	ld wa,(_eng_div__8)
	ld (xsp+4),wa
	ld a,(_eng_attn__8)
	ld (xsp+3),a
L942:
	ld xwa,_sfx_frames__8
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L943
	ld xwa,_sfx_attn__8
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+6),a
	ld xwa,_sfx_decay__8
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L944
	ld xwa,_sfx_age__8
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	exts xwa
	ld xbc,_sfx_decay__8
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
	jr ule,L945
	ldb (xsp+6),15
L945:
L944:
	ld a,(xsp+6)
	ld (xsp+3),a
	ld xwa,_sfx_div__8
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+4),wa
	ld xwa,_sfx_div__8
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_sfx_step__8
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
	ld xbc,_sfx_div__8
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_sfx_age__8
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,250
	jr uge,L946
	ld xwa,_sfx_age__8
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	add a,iyl
	ld xbc,_sfx_age__8
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L946:
	ld xbc,_sfx_frames__8
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp c,iyl
	jr ule,L947
	ld xwa,_sfx_frames__8
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	sub a,iyl
	extz wa
	jr L948
L947:
	ld wa,0
L948:
	ld xbc,_sfx_frames__8
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L943:
	ld wa,(xsp+4)
	ld xbc,_want_div__8
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+3)
	ld xbc,_want_attn__8
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L932:
	inc 1,izl
L933:
	ld a,izl
	cp a,4
	jp ult,L930
L931:
	push xix
	push xiy
	call _flush__8
	pop xiy
	pop xix
L928:
	lda xsp,(xsp+16)
	pop xiz
	ret

; function player_sfx_tone
_player_sfx_tone:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld wa,(xsp+12)
	ld xbc,_sfx_div__8
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+16)
	ld xbc,_sfx_step__8
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+20)
	ld xbc,_sfx_attn__8
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+24)
	ld xbc,_sfx_frames__8
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+28)
	ld xbc,_sfx_decay__8
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_sfx_age__8
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L950:
	pop xiz
	ret

; function player_sfx_noise
_player_sfx_noise:
	ld a,(xsp+4)
	extz wa
	ld (_sfx_div__8+6),wa
	ldb (_sfx_step__8+3),0
	ld a,(xsp+8)
	ld (_sfx_attn__8+3),a
	ld a,(xsp+12)
	ld (_sfx_frames__8+3),a
	ld a,(xsp+16)
	ld (_sfx_decay__8+3),a
	ldb (_sfx_age__8+3),0
	ldb (_noise_trig__8),1
L952:
	ret

; function banner_init
_banner_init:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,41520
	ld xix,xwa
	ld izl,0
	jr L962
L959:
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
L961:
	inc 1,izl
L962:
	ld a,izl
	cp a,40
	jr ult,L959
L960:
	push xix
	ld wa,4095
	push xwa
	ld wa,557
	push xwa
	ld wa,274
	push xwa
	ld wa,0
	push xwa
	ld wa,10
	push xwa
	ld wa,0
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xix
	push xix
	ld wa,4095
	push xwa
	ld wa,2730
	push xwa
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,7
	push xwa
	ld wa,2
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
	pop xix
	push xix
	ld wa,147
	push xwa
	call _id_road_distance_at_line
	lda xsp,(xsp+4)
	pop xix
	ld (_car_d__9),wa
	ldb (_b_on__9),0
L958:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function erase
_erase__9:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_b_on__9)
	cp a,0
	jr nz,L974
	jr L973
L974:
	ld a,(_b_r0__9)
	ld ixl,a
	jr L978
L975:
	ld a,(_b_c0__9)
	ld izl,a
	jr L982
L979:
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
L981:
	inc 1,izl
L982:
	ld a,izl
	cp a,(_b_c1__9)
	jr ule,L979
L980:
L977:
	inc 1,ixl
L978:
	ld a,ixl
	cp a,(_b_foot__9)
	jr ule,L975
L976:
	ldb (_b_on__9),0
L973:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function banner_hide
_banner_hide:
	call _erase__9
	ld a,(_b_spr__9)
	cp a,0
	jr z,L986
	ld a,64
	push xwa
	ld a,58
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	ldb (_b_spr__9),0
L986:
L985:
	ret

; function banner_dirty
_banner_dirty:
	ldb (_b_r0__9),255
L988:
	ret

; function banner_active
_banner_active:
	ld a,(_b_on__9)
	jr L990
L990:
	ret

; function banner_show
_banner_show:
	push xiz
	lda xsp,(xsp-46)
	ld wa,(xsp+54)
	cp wa,0
	jr lt,L1045
	ld wa,(xsp+54)
	cp wa,1400
	jr le,L1044
L1045:
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1043
L1044:
	push xix
	push xiy
	ld wa,(xsp+62)
	add wa,(_car_d__9)
	push xwa
	call _id_road_line_at_distance
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (xsp+6),a
	ld a,(xsp+6)
	cp a,255
	jr nz,L1046
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1043
L1046:
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
	jr lt,L1048
	ld wa,(xsp+18)
	cp wa,151
	jr le,L1047
L1048:
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1043
L1047:
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
	jr uge,L1049
	ld a,(xsp+7)
	ld iyl,a
L1049:
	ld wa,(xsp+2)
	sra 3,wa
	ld (xsp+11),a
	ld a,(xsp+11)
	cp a,18
	jr ule,L1050
	ldb (xsp+11),18
L1050:
	ld bc,(xsp+20)
	cp bc,0
	jr ge,L1051
	ld wa,0
	jr L1052
L1051:
	ld bc,(xsp+20)
	sra 3,bc
	cp bc,19
	jr le,L1053
	ld wa,19
	jr L1054
L1053:
	ld wa,(xsp+20)
	sra 3,wa
L1054:
L1052:
	ld (xsp+9),a
	ld bc,(xsp+22)
	cp bc,0
	jr ge,L1055
	ld wa,0
	jr L1056
L1055:
	ld bc,(xsp+22)
	sra 3,bc
	cp bc,19
	jr le,L1057
	ld wa,19
	jr L1058
L1057:
	ld wa,(xsp+22)
	sra 3,wa
L1058:
L1056:
	ld (xsp+10),a
	ld a,(_b_on__9)
	cp a,0
	jr z,L1060
	ld a,(xsp+7)
	cp a,(_b_r0__9)
	jr nz,L1060
	ld a,iyl
	cp a,(_b_r1__9)
	jr nz,L1060
	ld a,(xsp+9)
	cp a,(_b_c0__9)
	jr nz,L1060
	ld a,(xsp+10)
	cp a,(_b_c1__9)
	jr nz,L1060
	ld a,(xsp+11)
	cp a,(_b_foot__9)
	jp z,L1059
L1060:
	push xix
	push xiy
	call _erase__9
	pop xiy
	pop xix
	ld a,(xsp+7)
	ld izl,a
	jp L1064
L1061:
	ld a,(xsp+9)
	ld ixl,a
	jr L1068
L1065:
	ld wa,36
	ld (xsp+26),wa
	ld a,(xsp+58)
	cp a,0
	jr z,L1069
	ld a,ixl
	cp a,(xsp+9)
	jr z,L1070
	ld a,ixl
	cp a,(xsp+10)
	jr nz,L1069
L1070:
	ldw (xsp+26),42
	jr L1071
L1069:
	ld a,izl
	cp a,(xsp+7)
	jr nz,L1072
	ld a,iyl
	cp a,(xsp+7)
	jr ule,L1072
	ldw (xsp+26),35
	jr L1073
L1072:
	ld a,izl
	cp a,iyl
	jr nz,L1074
	ld a,iyl
	cp a,(xsp+7)
	jr ule,L1074
	ldw (xsp+26),37
L1074:
L1073:
L1071:
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
L1067:
	inc 1,ixl
L1068:
	ld a,ixl
	cp a,(xsp+10)
	jr ule,L1065
L1066:
L1063:
	inc 1,izl
L1064:
	ld a,izl
	cp a,iyl
	jp ule,L1061
L1062:
	ld a,iyl
	add a,1
	ld izl,a
	jr L1078
L1075:
	ld wa,(xsp+20)
	cp wa,0
	jr lt,L1079
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
L1079:
	ld wa,(xsp+22)
	cp wa,160
	jr ge,L1080
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
L1080:
L1077:
	inc 1,izl
L1078:
	ld a,izl
	cp a,(xsp+11)
	jr ule,L1075
L1076:
	ldb (_b_on__9),1
	ld a,(xsp+7)
	ld (_b_r0__9),a
	ld a,iyl
	ld (_b_r1__9),a
	ld a,(xsp+9)
	ld (_b_c0__9),a
	ld a,(xsp+10)
	ld (_b_c1__9),a
	ld a,(xsp+11)
	ld (_b_foot__9),a
L1059:
	ldb (xsp+14),0
	jr L1083
L1081:
	incb 1,(xsp+14)
L1083:
	ld xwa,(xsp+62)
	ld c,(xsp+14)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L1084
	ld a,(xsp+14)
	cp a,6
	jr ult,L1081
L1084:
L1082:
	ld wa,2
	mul xwa,(xsp+24)
	add wa,8
	ld c,(xsp+14)
	extz bc
	sll 3,bc
	cp wa,bc
	jr ge,L1085
	ldb (xsp+14),0
L1085:
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
	jp L1089
L1086:
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
	jr lt,L1091
	ld wa,(xsp+32)
	cp wa,159
	jr le,L1090
L1091:
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
	jp L1088
L1090:
L1092:
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
L1094:
L1093:
L1088:
	incb 1,(xsp+15)
L1089:
	ld a,(xsp+15)
	cp a,(xsp+14)
	jp ult,L1086
L1087:
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
	ldb (_b_spr__9),1
L1043:
	lda xsp,(xsp+46)
	pop xiz
	ret

; function ngpc_input_vblank
_ngpc_input_vblank:
	lda xsp,(xsp-2)
	ld a,(06F82h)
	ld (xsp+0),a
	ld a,(_s_vbl_down__10)
	ld c,(xsp+0)
	ld e,(_s_vbl_prev__10)
	cpl e
	and c,e
	or a,c
	ld (_s_vbl_down__10),a
	ld a,(xsp+0)
	ld (_s_vbl_prev__10),a
L1096:
	lda xsp,(xsp+2)
	ret

; function ngpc_input_set_repeat
_ngpc_input_set_repeat:
	ld a,(xsp+4)
	ld (_s_repeat_delay__10),a
	ld a,(xsp+8)
	ld (_s_repeat_rate__10),a
L1098:
	ret

; function ngpc_input_update
_ngpc_input_update:
	lda xsp,(xsp-4)
	di
	ld a,(06F82h)
	ld (xsp+2),a
	ld a,(_s_vbl_down__10)
	ld (xsp+3),a
	ldb (_s_vbl_down__10),0
	ld a,(xsp+2)
	ld (_s_vbl_prev__10),a
	ei 0
	ld a,(xsp+2)
	ld (_ngpc_pad_held),a
	ld a,(xsp+2)
	ld c,(_s_pad_prev__10)
	cpl c
	and a,c
	or a,(xsp+3)
	ld (_ngpc_pad_pressed),a
	ld a,(xsp+2)
	cpl a
	and a,(_s_pad_prev__10)
	ld (_ngpc_pad_released),a
	ldb (_ngpc_pad_repeat),0
	ldb (xsp+1),1
	ldb (xsp+0),0
	jp L1114
L1111:
	ld a,(xsp+2)
	extz wa
	ld c,(xsp+1)
	extz bc
	and wa,bc
	cp wa,0
	jr z,L1115
	ld a,(_ngpc_pad_pressed)
	extz wa
	ld c,(xsp+1)
	extz bc
	and wa,bc
	cp wa,0
	jr z,L1116
	ld a,(_s_repeat_delay__10)
	ld xbc,_s_repeat_timer__10
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	jr L1117
L1116:
	ld xwa,_s_repeat_timer__10
	ld c,(xsp+0)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr ule,L1118
	ld xbc,_s_repeat_timer__10
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld a,(xbc)
	dec 1,a
	ld (xbc),a
	jr L1119
L1118:
	ld a,(_ngpc_pad_repeat)
	extz wa
	ld c,(xsp+1)
	extz bc
	or wa,bc
	ld (_ngpc_pad_repeat),a
	ld a,(_s_repeat_rate__10)
	ld xbc,_s_repeat_timer__10
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1119:
L1117:
	jr L1120
L1115:
	ld a,0
	ld xbc,_s_repeat_timer__10
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1120:
	ld a,(xsp+1)
	extz wa
	sll 1,wa
	ld (xsp+1),a
L1113:
	incb 1,(xsp+0)
L1114:
	ld a,(xsp+0)
	cp a,8
	jp ult,L1111
L1112:
	ld a,(xsp+2)
	ld (_s_pad_prev__10),a
L1110:
	lda xsp,(xsp+4)
	ret

; function runtime_bootstrap
_runtime_bootstrap__11:
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
	jr L1131
L1129:
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
L1131:
	ld xwa,xix
	cp xwa,(xsp+4)
	jr ult,L1129
L1130:
	jr L1134
L1132:
	ld a,0
	ld xbc,xiz
	inc 1,xbc
	ld xiz,xbc
	dec 1,xbc
	ld (xbc),a
L1134:
	ld xwa,xiz
	cp xwa,(xsp+16)
	jr ult,L1132
L1133:
L1128:
	lda xsp,(xsp+20)
	pop xiz
	ret

; function isr_dummy
_isr_dummy__11:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
L1136:
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
	ld (_g_vb_hook__11),xwa
L1138:
	ret

; function isr_vblank
_isr_vblank__11:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	ldb (06Fh),78
	ld xwa,(_g_vb_hook__11)
	cp xwa,0
	jr z,L1142
	ld xwa,(_g_vb_hook__11)
	ld xhl,xwa
	call (xhl)
L1142:
	call _ngpc_vramq_flush
	incb 1,(_g_vb_counter)
	call _ngpc_input_vblank
L1141:
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
	call _runtime_bootstrap__11
	ld c,(06F91h)
	cp c,0
	jr z,L1151
	ld wa,1
	jr L1152
L1151:
	ld wa,0
L1152:
	ld (_s_is_color__11),a
	ld a,(06F87h)
	ld (_s_language__11),a
	andb (06F86h),223
	orb (06F86h),64
	call _ngpc_vramq_init
	ld xwa,_isr_dummy__11
	ld (06FB8h),xwa
	ld xwa,_isr_dummy__11
	ld (06FBCh),xwa
	ld xwa,_isr_dummy__11
	ld (06FC0h),xwa
	ld xwa,_isr_dummy__11
	ld (06FC4h),xwa
	ld xwa,_isr_dummy__11
	ld (06FC8h),xwa
	ld xwa,_isr_vblank__11
	ld (06FCCh),xwa
	ld xwa,_isr_dummy__11
	ld (06FD0h),xwa
	ld xwa,_isr_dummy__11
	ld (06FD4h),xwa
	ld xwa,_isr_dummy__11
	ld (06FD8h),xwa
	ld xwa,_isr_dummy__11
	ld (06FDCh),xwa
	ld xwa,_isr_dummy__11
	ld (06FE0h),xwa
	ld xwa,_isr_dummy__11
	ld (06FE4h),xwa
	ld xwa,_isr_dummy__11
	ld (06FE8h),xwa
	ld xwa,_isr_dummy__11
	ld (06FF0h),xwa
	ld xwa,_isr_dummy__11
	ld (06FF4h),xwa
	ld xwa,_isr_dummy__11
	ld (06FF8h),xwa
	ld xwa,_isr_dummy__11
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
	jr L1156
L1153:
	ld wa,0
	ld xbc,40960
	ld e,(xsp+0)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1155:
	incb 1,(xsp+0)
L1156:
	ld a,(xsp+0)
	cp a,8
	jr ult,L1153
L1154:
	ei
L1150:
	lda xsp,(xsp+2)
	ret

; function ngpc_is_color
_ngpc_is_color:
	ld a,(_s_is_color__11)
	jr L1158
L1158:
	ret

; function ngpc_get_language
_ngpc_get_language:
	ld a,(_s_language__11)
	jr L1160
L1160:
	ret

; function ngpc_shutdown_reason
_ngpc_shutdown_reason:
	push xiz
	lda xsp,(xsp-6)
	ld a,(xsp+14)
	extz wa
	and wa,32
	cp wa,0
	jr z,L1176
	ld iy,15
	jr L1177
L1176:
	ld a,(xsp+14)
	extz wa
	and wa,128
	cp wa,0
	jr z,L1178
	ld iy,4095
	jr L1179
L1178:
	ld a,(xsp+14)
	extz wa
	and wa,64
	cp wa,0
	jr z,L1180
	ld iy,240
	jr L1181
L1180:
	ld iy,3840
L1181:
L1179:
L1177:
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
	jr L1185
L1182:
	ld a,(_g_vb_counter)
	ld ixl,a
	jr L1188
L1186:
L1188:
	ld a,(_g_vb_counter)
	cp a,ixl
	jr z,L1186
L1187:
L1184:
	inc 1,iz
L1185:
	ld wa,iz
	cp wa,180
	jr ult,L1182
L1183:
	push xix
	push xiy
	call _ngpc_shutdown
	pop xiy
	pop xix
L1175:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_shutdown
_ngpc_shutdown:
	ldb ra3, 3
	ldb rw3, 0
	swi 1
L1190:
	ret

; function ngpc_load_sysfont
_ngpc_load_sysfont:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,41472
	ld xix,xwa
	ld iz,0
	jr L1200
L1197:
	ld xwa,_overrev_dash_tiles__11
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
L1199:
	inc 1,iz
L1200:
	ld wa,iz
	cp wa,768
	jr ult,L1197
L1198:
L1196:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_memcpy
_ngpc_memcpy:
	push xiz
	ld xix,(xsp+8)
	ld xiz,(xsp+12)
	ld iy,(xsp+16)
	jr L1208
L1206:
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
L1208:
	ld wa,iy
	dec 1,iy
	cp wa,0
	jr nz,L1206
L1207:
L1205:
	pop xiz
	ret

; function ngpc_memset
_ngpc_memset:
	push xiz
	ld xiz,(xsp+8)
	ld a,(xsp+12)
	ld iyl,a
	ld ix,(xsp+16)
	jr L1216
L1214:
	ld a,iyl
	ld xbc,xiz
	inc 1,xbc
	ld xiz,xbc
	dec 1,xbc
	ld (xbc),a
L1216:
	ld wa,ix
	dec 1,ix
	cp wa,0
	jr nz,L1214
L1215:
L1213:
	pop xiz
	ret

; function ngpc_vsync
_ngpc_vsync:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_g_vb_counter)
	ld izl,a
	jr L1227
L1225:
L1227:
	ld a,(_g_vb_counter)
	cp a,izl
	jr z,L1225
L1226:
	ld a,(06F85h)
	cp a,0
	jr z,L1228
	ld a,(06F85h)
	push xwa
	call _ngpc_shutdown_reason
	lda xsp,(xsp+4)
L1228:
L1223:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_in_vblank
_ngpc_in_vblank:
	ld c,(08010h)
	extz bc
	and bc,64
	cp bc,0
	jr z,L1233
	ld wa,1
	jr L1234
L1233:
	ld wa,0
L1234:
	jr L1232
L1232:
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
	jr L1244
L1241:
	call _ngpc_vsync
L1243:
	inc 1,izl
L1244:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L1241
L1242:
	ld wa,0
	push xwa
	call _ngpc_cpu_speed
	lda xsp,(xsp+4)
L1240:
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
L1246:
	ret

; function dst_range_ok
_dst_range_ok__13:
	push xiz
	lda xsp,(xsp-12)
	ld xwa,(xsp+20)
	cp xwa,0
	jr z,L1254
	ld wa,(xsp+24)
	cp wa,0
	jr nz,L1253
L1254:
	ld wa,0
	jr L1252
L1253:
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
	jr uge,L1255
	ld wa,0
	jr L1252
L1255:
	ld xwa,(xsp+8)
	cp xwa,49151
	jr ule,L1256
	ld wa,0
	jr L1252
L1256:
	ld wa,1
	jr L1252
L1252:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function ngpc_vramq_init
_ngpc_vramq_init:
	ldb (_s_cmd_count__13),0
	ldb (_s_drop_count__13),0
	ldb (_s_lock__13),0
L1258:
	ret

; function ngpc_vramq_copy
_ngpc_vramq_copy:
	push xiz
	lda xsp,(xsp-2)
	ld xwa,(xsp+14)
	cp xwa,0
	jr z,L1265
	ld wa,(xsp+18)
	push xwa
	ld xwa,(xsp+14)
	push xwa
	call _dst_range_ok__13
	lda xsp,(xsp+8)
	cp a,0
	jr nz,L1264
L1265:
	ld wa,0
	jp L1263
L1264:
	ldb (_s_lock__13),1
	ld a,(_s_cmd_count__13)
	ld izl,a
	ld a,izl
	cp a,16
	jr ult,L1266
	incb 1,(_s_drop_count__13)
	ldb (_s_lock__13),0
	ld wa,0
	jr L1263
L1266:
	ld xwa,(xsp+10)
	ld xbc,_s_cmd_dst__13
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+18)
	ld xbc,_s_cmd_len__13
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,(xsp+14)
	ld xbc,_s_cmd_src__13
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,0
	ld xbc,_s_cmd_fill__13
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,1
	ld xbc,_s_cmd_type__13
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,izl
	add a,1
	ld (_s_cmd_count__13),a
	ldb (_s_lock__13),0
	ld wa,1
	jr L1263
L1263:
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
	call _dst_range_ok__13
	lda xsp,(xsp+8)
	cp a,0
	jr nz,L1271
	ld wa,0
	jp L1270
L1271:
	ldb (_s_lock__13),1
	ld a,(_s_cmd_count__13)
	ld izl,a
	ld a,izl
	cp a,16
	jr ult,L1272
	incb 1,(_s_drop_count__13)
	ldb (_s_lock__13),0
	ld wa,0
	jr L1270
L1272:
	ld xwa,(xsp+10)
	ld xbc,_s_cmd_dst__13
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+18)
	ld xbc,_s_cmd_len__13
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,0
	ld xbc,_s_cmd_src__13
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,(xsp+14)
	ld xbc,_s_cmd_fill__13
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,2
	ld xbc,_s_cmd_type__13
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,izl
	add a,1
	ld (_s_cmd_count__13),a
	ldb (_s_lock__13),0
	ld wa,1
	jr L1270
L1270:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_vramq_flush
_ngpc_vramq_flush:
	push xiz
	lda xsp,(xsp-10)
	ld a,(_s_lock__13)
	cp a,0
	jr z,L1287
	jp L1286
L1287:
	ld a,(_s_cmd_count__13)
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,0
	jr nz,L1288
	jp L1286
L1288:
	ldb (_s_lock__13),1
	ld izl,0
	jp L1292
L1289:
	ld xwa,_s_cmd_dst__13
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	extz xwa
	ld xix,xwa
	ld xwa,_s_cmd_len__13
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld iy,wa
	ld xwa,_s_cmd_type__13
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,1
	jr nz,L1293
	push xix
	push xiy
	ld wa,iy
	extz xwa
	push xwa
	ld xwa,_s_cmd_src__13
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_cmd_dst__13
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
	jr L1294
L1293:
	ld xwa,_s_cmd_type__13
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,2
	jr nz,L1295
	ld xwa,_s_cmd_fill__13
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+8),wa
	jr L1298
L1296:
	ld wa,(xsp+8)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L1298:
	ld wa,iy
	dec 1,iy
	cp wa,0
	jr nz,L1296
L1297:
L1295:
L1294:
L1291:
	inc 1,izl
L1292:
	ld a,izl
	cp a,(xsp+1)
	jp ult,L1289
L1290:
	ldb (_s_cmd_count__13),0
	ldb (_s_lock__13),0
L1286:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_vramq_clear
_ngpc_vramq_clear:
	ld a,(_s_lock__13)
	cp a,0
	jr z,L1302
	jr L1301
L1302:
	ldb (_s_cmd_count__13),0
L1301:
	ret

; function ngpc_vramq_pending
_ngpc_vramq_pending:
	ld a,(_s_cmd_count__13)
	jr L1304
L1304:
	ret

; function ngpc_vramq_dropped
_ngpc_vramq_dropped:
	ld a,(_s_drop_count__13)
	jr L1306
L1306:
	ret

; function ngpc_vramq_clear_dropped
_ngpc_vramq_clear_dropped:
	ldb (_s_drop_count__13),0
L1308:
	ret

; function put_placeholder
_put_placeholder__14:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld wa,4000
	ld xbc,_buf__14
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc),wa
	ld wa,0
	ld xbc,_buf__14
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+2),wa
	ld a,0
	ld xbc,_buf__14
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+4),a
L1310:
	pop xiz
	ret

; function copy_leg
_copy_leg__14:
	push xiz
	lda xsp,(xsp-6)
	ld a,(xsp+18)
	ld iyl,a
	ld xwa,_gfx_legs
	ld c,(xsp+14)
	extz bc
	muls xbc,22
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+0),xwa
	ld xwa,(xsp+0)
	ld a,(xwa+4)
	ld ixl,a
	ld a,iyl
	extz wa
	ld c,ixl
	extz bc
	add wa,bc
	add wa,1
	cp wa,72
	jr ule,L1318
	ld a,71
	sub a,iyl
	ld ixl,a
L1318:
	ld izl,0
	jr L1322
L1319:
	push xwa
	ld xwa,(xsp+4)
	ld xwa,(xwa)
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	push xwa
	ld xwa,_buf__14
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
L1321:
	inc 1,izl
L1322:
	ld a,izl
	cp a,ixl
	jr ult,L1319
L1320:
	ld a,ixl
	jr L1317
L1317:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function load_current
_load_current__14:
	push xiz
	lda xsp,(xsp-2)
	ld wa,0
	push xwa
	ld a,(_cur_leg)
	push xwa
	call _copy_leg__14
	lda xsp,(xsp+8)
	ld (_n_cur__14),a
	ld a,(_n_cur__14)
	push xwa
	call _put_placeholder__14
	lda xsp,(xsp+4)
	ld a,(_n_cur__14)
	add a,1
	ld (_track_len),a
	ldw (_leg_len),0
	ld izl,0
	jr L1332
L1329:
	ld wa,(_leg_len)
	ld xbc,_buf__14
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld (_leg_len),wa
L1331:
	inc 1,izl
L1332:
	ld a,izl
	cp a,(_n_cur__14)
	jr ult,L1329
L1330:
	ldb (_fork_choice),0
L1328:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function course_start
_course_start:
	push xiz
	lda xsp,(xsp-2)
	ldb (_cur_stage),0
	ldb (_cur_branch),0
	ldb (_cur_leg),0
	ld izl,0
	jr L1342
L1339:
	ld a,0
	ld xbc,_route_hist
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1341:
	inc 1,izl
L1342:
	ld a,izl
	cp a,5
	jr ult,L1339
L1340:
	call _load_current__14
L1338:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function course_is_last_stage
_course_is_last_stage:
	ld c,(_cur_stage)
	extz bc
	add bc,1
	cp bc,5
	jr ult,L1347
	ld wa,1
	jr L1348
L1347:
	ld wa,0
L1348:
	jr L1346
L1346:
	ret

; function course_fork_zone
_course_fork_zone:
	ld bc,(xsp+4)
	add bc,2400
	cp bc,(_leg_len)
	jr ult,L1353
	ld wa,1
	jr L1354
L1353:
	ld wa,0
L1354:
	jr L1352
L1352:
	ret

; function course_start_zone
_course_start_zone:
	ld c,(_cur_stage)
	cp c,0
	jr z,L1359
	ld bc,(xsp+4)
	cp bc,900
	jr uge,L1359
	ld wa,1
	jr L1360
L1359:
	ld wa,0
L1360:
	jr L1358
L1358:
	ret

; function course_decide
_course_decide:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_fork_choice)
	cp a,0
	jr nz,L1373
	call _course_is_last_stage
	cp a,0
	jr z,L1372
L1373:
	jp L1371
L1372:
	ld c,(xsp+10)
	cp c,0
	jr z,L1374
	ld wa,2
	jr L1375
L1374:
	ld wa,1
L1375:
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
	jr z,L1376
	ld de,1
	jr L1377
L1376:
	ld de,0
L1377:
	add bc,de
	add wa,bc
	ld (xsp+0),a
	ld a,(_n_cur__14)
	push xwa
	ld a,(xsp+4)
	push xwa
	call _copy_leg__14
	lda xsp,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,0
	jr z,L1378
	ld c,(xsp+10)
	cp c,0
	jr z,L1379
	ld wa,65486
	jr L1380
L1379:
	ld wa,50
L1380:
	ld xbc,_buf__14
	ld e,(_n_cur__14)
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+2),wa
L1378:
	ld a,(_n_cur__14)
	add a,izl
	push xwa
	call _put_placeholder__14
	lda xsp,(xsp+4)
	ld a,(_n_cur__14)
	add a,izl
	add a,1
	ld (_track_len),a
L1371:
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
	jr z,L1395
	ld wa,0
	jp L1394
L1395:
	ld a,(_fork_choice)
	cp a,0
	jr nz,L1396
	push xix
	ld wa,0
	push xwa
	call _course_decide
	lda xsp,(xsp+4)
	pop xix
L1396:
	ld a,(_n_cur__14)
	ld ixl,a
	ld izl,0
	jr L1400
L1397:
	push xwa
	ld xwa,_buf__14
	ld c,izl
	add c,ixl
	extz bc
	muls xbc,6
	add xwa,xbc
	push xwa
	ld xwa,_buf__14
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld xde,xwa
	pop xhl
	ld bc,6
	ldirb
	pop xwa
L1399:
	inc 1,izl
L1400:
	ld a,izl
	add a,ixl
	cp a,(_track_len)
	jr ult,L1397
L1398:
	ld a,(_track_len)
	sub a,ixl
	ld (_track_len),a
	ld a,(_fork_choice)
	cp a,2
	jr nz,L1401
	incb 1,(_cur_branch)
L1401:
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
	ld xwa,_gfx_legs
	ld c,(_cur_leg)
	extz bc
	muls xbc,22
	add xwa,xbc
	ld a,(xwa+4)
	ld (_n_cur__14),a
	ld a,(_n_cur__14)
	cp a,(_track_len)
	jr ult,L1402
	ld a,(_track_len)
	sub a,1
	ld (_n_cur__14),a
L1402:
	ldw (_leg_len),0
	ld izl,0
	jr L1406
L1403:
	ld wa,(_leg_len)
	ld xbc,_buf__14
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld (_leg_len),wa
L1405:
	inc 1,izl
L1406:
	ld a,izl
	cp a,(_n_cur__14)
	jr ult,L1403
L1404:
	ldb (_fork_choice),0
	ld a,ixl
	jr L1394
L1394:
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
	call _load_current__14
	pop xix
L1408:
	pop xiz
	ret

; function rnd
_rnd__15:
	ld wa,(_seed__15)
	mul xwa,25173
	add wa,13849
	ld (_seed__15),wa
	ld wa,(_seed__15)
	srl 8,wa
	jr L1410
L1410:
	ret

; function ending_start
_ending_start:
	push xiz
	lda xsp,(xsp-8)
	ld a,(xsp+16)
	cp a,4
	jr ule,L1422
	ldb (xsp+16),4
L1422:
	ld xwa,_endings__15
	ld c,(xsp+16)
	extz bc
	exts xbc
	sll 4,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+0),xwa
	ldw (xsp+4),0
	jr L1426
L1423:
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
L1425:
	incw 1,(xsp+4)
L1426:
	ld wa,(xsp+4)
	cp wa,24
	jr ult,L1423
L1424:
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
	ld (_fx__15),a
	ldb (_timer__15),0
	ld izl,0
	jr L1430
L1427:
	ld a,0
	ld xbc,_life__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	call _rnd__15
	extz wa
	extz xwa
	div xwa,152
	ld wa,qwa
	sll 4,wa
	ld xbc,_px__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__15
	extz wa
	extz xwa
	div xwa,140
	ld wa,qwa
	sll 4,wa
	ld xbc,_py__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1429:
	inc 1,izl
L1430:
	ld a,izl
	cp a,14
	jr ult,L1427
L1428:
L1421:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function pal_of
_pal_of__15:
	ld xwa,_pals__15_L1434
	ld c,(xsp+4)
	extz bc
	and bc,3
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	jr L1433
L1433:
	ret

; function ending_tick
_ending_tick:
	push xiz
	lda xsp,(xsp-14)
	incb 1,(_timer__15)
	ld a,(_fx__15)
	cp a,1
	jp nz,L1472
	ld a,(_timer__15)
	extz wa
	extz xwa
	div xwa,40
	ld wa,qwa
	cp wa,1
	jp nz,L1472
	ld wa,24
	push xwa
	call _rnd__15
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
	call _rnd__15
	ld xbc,xwa
	pop xwa
	extz bc
	extz xbc
	div xbc,40
	ld bc,qbc
	add wa,bc
	sll 4,wa
	ld (xsp+4),wa
	call _rnd__15
	push xwa
	call _pal_of__15
	lda xsp,(xsp+4)
	ld (xsp+6),a
	ld izl,0
	jp L1476
L1473:
	ld a,izl
	and a,7
	ld (xsp+7),a
	ld c,izl
	cp c,8
	jr uge,L1477
	ld wa,2
	jr L1478
L1477:
	ld wa,1
L1478:
	ld (xsp+8),wa
	ld wa,(xsp+2)
	ld xbc,_px__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+4)
	ld xbc,_py__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_dir_x__15
	ld c,(xsp+7)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	exts wa
	mul xwa,(xsp+8)
	ld xbc,_vx__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_dir_y__15
	ld c,(xsp+7)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	exts wa
	mul xwa,(xsp+8)
	ld xbc,_vy__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,34
	ld xbc,_life__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_ptile__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(xsp+6)
	ld xbc,_ppal__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1475:
	inc 1,izl
L1476:
	ld a,izl
	cp a,14
	jp ult,L1473
L1474:
L1472:
	ld izl,0
	jp L1482
L1479:
	ld a,56
	add a,izl
	ld (xsp+1),a
	ld a,(_fx__15)
	extz wa
	cp wa,1
	jr z,L1484
	cp wa,2
	jp z,L1485
	cp wa,3
	jp z,L1486
	cp wa,4
	jp z,L1487
	jp L1488
L1484:
	ld xwa,_life__15
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L1489
	ld xbc,_life__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld a,(xbc)
	dec 1,a
	ld (xbc),a
	ld xwa,_px__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_vx__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld xbc,_px__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_py__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_vy__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld xbc,_py__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_vy__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	add wa,1
	ld xbc,_vy__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1489:
	jp L1483
L1485:
	ld xwa,_life__15
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L1491
	ld xwa,_py__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2400
	jp le,L1490
L1491:
	call _rnd__15
	extz wa
	extz xwa
	div xwa,152
	ld wa,qwa
	sll 4,wa
	ld xbc,_px__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__15
	extz wa
	and wa,63
	neg wa
	sll 4,wa
	ld xbc,_py__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,12
	push xwa
	call _rnd__15
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,15
	add wa,bc
	ld xbc,_vy__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__15
	push xwa
	call _pal_of__15
	lda xsp,(xsp+4)
	ld xbc,_ppal__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,1
	ld xbc,_ptile__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,1
	ld xbc,_life__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1490:
	ld xwa,_py__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_vy__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld xbc,_py__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_px__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld e,(_timer__15)
	extz de
	ld l,izl
	extz hl
	mul xhl,9
	add de,hl
	and de,32
	cp de,0
	jr z,L1492
	ld bc,6
	jr L1493
L1492:
	ld bc,65530
L1493:
	add wa,bc
	ld xbc,_px__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jp L1483
L1486:
	ld xwa,_life__15
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L1495
	ld xwa,_py__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65408
	jp ge,L1494
L1495:
	ld wa,8
	push xwa
	call _rnd__15
	ld xbc,xwa
	pop xwa
	extz bc
	extz xbc
	div xbc,144
	ld bc,qbc
	add wa,bc
	sll 4,wa
	ld xbc,_px__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,152
	push xwa
	call _rnd__15
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,63
	add wa,bc
	sll 4,wa
	ld xbc,_py__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,8
	push xwa
	call _rnd__15
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,7
	add wa,bc
	neg wa
	ld xbc,_vy__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__15
	push xwa
	call _pal_of__15
	lda xsp,(xsp+4)
	ld xbc,_ppal__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,2
	ld xbc,_ptile__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,1
	ld xbc,_life__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1494:
	ld xwa,_py__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_vy__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld xbc,_py__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_px__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld e,(_timer__15)
	extz de
	ld l,izl
	extz hl
	mul xhl,13
	add de,hl
	and de,64
	cp de,0
	jr z,L1496
	ld bc,3
	jr L1497
L1496:
	ld bc,65533
L1497:
	add wa,bc
	ld xbc,_px__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jp L1483
L1487:
	ld xwa,_life__15
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp nz,L1498
	call _rnd__15
	extz wa
	extz xwa
	div xwa,152
	ld wa,qwa
	sll 4,wa
	ld xbc,_px__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	call _rnd__15
	extz wa
	extz xwa
	div xwa,100
	ld wa,qwa
	sll 4,wa
	ld xbc,_py__15
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,10
	push xwa
	call _rnd__15
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,31
	add wa,bc
	ld xbc,_life__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld c,izl
	extz bc
	and bc,1
	cp bc,0
	jr z,L1499
	ld wa,2
	jr L1500
L1499:
	ld wa,9
L1500:
	ld xbc,_ppal__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_ptile__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	jr L1501
L1498:
	ld xbc,_life__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld a,(xbc)
	dec 1,a
	ld (xbc),a
L1501:
	jr L1483
L1488:
	jr L1483
L1483:
	ld xwa,_life__15
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L1503
	ld xwa,_px__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65424
	jr lt,L1503
	ld xwa,_px__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2544
	jr gt,L1503
	ld xwa,_py__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65424
	jr lt,L1503
	ld xwa,_py__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2416
	jr gt,L1503
	ld a,(_fx__15)
	cp a,4
	jr nz,L1502
	ld xwa,_life__15
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	and wa,4
	cp wa,0
	jr z,L1502
L1503:
	ld a,(xsp+1)
	add a,1
	push xwa
	ld a,(xsp+5)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	jp L1481
L1502:
L1504:
	ld a,(xsp+1)
	ld (xsp+2),a
	ld xwa,_px__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	sra 4,wa
	ld (xsp+3),a
	ld xwa,_py__15
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	sra 4,wa
	ld (xsp+4),a
	ld wa,107
	ld xbc,_ptile__15
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	ld (xsp+6),wa
	ld xwa,_ppal__15
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
L1506:
L1505:
L1481:
	inc 1,izl
L1482:
	ld a,izl
	cp a,14
	jp ult,L1479
L1480:
L1471:
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
	ldb (_fx__15),0
L1508:
	ret

; function dma0_program
_dma0_program__16:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma0_program_asm
	lda xsp,(xsp+12)
L1510:
	ret

; function dma1_program
_dma1_program__16:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma1_program_asm
	lda xsp,(xsp+12)
L1512:
	ret

; function dma2_program
_dma2_program__16:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma2_program_asm
	lda xsp,(xsp+12)
L1514:
	ret

; function dma3_program
_dma3_program__16:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma3_program_asm
	lda xsp,(xsp+12)
L1516:
	ret

; function dma0_program_u16
_dma0_program_u16__16:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma0_program_u16_asm
	lda xsp,(xsp+12)
L1518:
	ret

; function dma1_program_u16
_dma1_program_u16__16:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma1_program_u16_asm
	lda xsp,(xsp+12)
L1520:
	ret

; function dma2_program_u16
_dma2_program_u16__16:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma2_program_u16_asm
	lda xsp,(xsp+12)
L1522:
	ret

; function dma3_program_u16
_dma3_program_u16__16:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma3_program_u16_asm
	lda xsp,(xsp+12)
L1524:
	ret

; function dma0_program_u32
_dma0_program_u32__16:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma0_program_u32_asm
	lda xsp,(xsp+12)
L1526:
	ret

; function dma1_program_u32
_dma1_program_u32__16:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma1_program_u32_asm
	lda xsp,(xsp+12)
L1528:
	ret

; function dma2_program_u32
_dma2_program_u32__16:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma2_program_u32_asm
	lda xsp,(xsp+12)
L1530:
	ret

; function dma3_program_u32
_dma3_program_u32__16:
	ld wa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	ld xwa,(xsp+12)
	push xwa
	call _dma3_program_u32_asm
	lda xsp,(xsp+12)
L1532:
	ret

; function dma0_clear
_dma0_clear__16:
	ld wa,0
	ldc dmac0,wa
	ld a,0
	ldc dmam0,a
L1534:
	ret

; function dma1_clear
_dma1_clear__16:
	ld wa,0
	ldc dmac1,wa
	ld a,0
	ldc dmam1,a
L1536:
	ret

; function dma2_clear
_dma2_clear__16:
	ld wa,0
	ldc dmac2,wa
	ld a,0
	ldc dmam2,a
L1538:
	ret

; function dma3_clear
_dma3_clear__16:
	ld wa,0
	ldc dmac3,wa
	ld a,0
	ldc dmam3,a
L1540:
	ret

; function dma_set_start_vector
_dma_set_start_vector__16:
	push xiz
	ld a,(xsp+12)
	ld izl,a
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L1549
	cp wa,1
	jr z,L1550
	cp wa,2
	jr z,L1551
	cp wa,3
	jr z,L1552
	jr L1548
L1549:
	ld a,izl
	ld (07Ch),a
	jr L1548
L1550:
	ld a,izl
	ld (07Dh),a
	jr L1548
L1551:
	ld a,izl
	ld (07Eh),a
	jr L1548
L1552:
	ld a,izl
	ld (07Fh),a
	jr L1548
L1548:
L1547:
	pop xiz
	ret

; function dma_rearm_in_isr
_dma_rearm_in_isr__16:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	jr L1578
	jp L1577
L1578:
	ld a,izl
	cp a,3
	jr ule,L1579
	jp L1577
L1579:
	ld xwa,_s_rearm_enabled__16
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L1580
	jp L1577
L1580:
	ld wa,0
	push xwa
	ld a,izl
	push xwa
	call _dma_set_start_vector__16
	lda xsp,(xsp+8)
	ld xwa,_s_rearm_elem__16
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	cp wa,0
	jr z,L1583
	cp wa,1
	jp z,L1584
	cp wa,2
	jp z,L1585
	jr L1582
L1582:
L1583:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L1587
	cp wa,1
	jr z,L1588
	cp wa,2
	jp z,L1589
	cp wa,3
	jp z,L1590
	jp L1586
L1587:
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma0_program__16
	lda xsp,(xsp+12)
	jp L1586
L1588:
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma1_program__16
	lda xsp,(xsp+12)
	jp L1586
L1589:
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma2_program__16
	lda xsp,(xsp+12)
	jr L1586
L1590:
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma3_program__16
	lda xsp,(xsp+12)
	jr L1586
L1586:
	jp L1581
L1584:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L1592
	cp wa,1
	jr z,L1593
	cp wa,2
	jp z,L1594
	cp wa,3
	jp z,L1595
	jp L1591
L1592:
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma0_program_u16__16
	lda xsp,(xsp+12)
	jp L1591
L1593:
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma1_program_u16__16
	lda xsp,(xsp+12)
	jp L1591
L1594:
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma2_program_u16__16
	lda xsp,(xsp+12)
	jr L1591
L1595:
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma3_program_u16__16
	lda xsp,(xsp+12)
	jr L1591
L1591:
	jp L1581
L1585:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L1597
	cp wa,1
	jr z,L1598
	cp wa,2
	jp z,L1599
	cp wa,3
	jp z,L1600
	jp L1596
L1597:
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma0_program_u32__16
	lda xsp,(xsp+12)
	jp L1596
L1598:
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma1_program_u32__16
	lda xsp,(xsp+12)
	jp L1596
L1599:
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma2_program_u32__16
	lda xsp,(xsp+12)
	jr L1596
L1600:
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	call _dma3_program_u32__16
	lda xsp,(xsp+12)
	jr L1596
L1596:
	jr L1581
L1581:
	ld xwa,_s_rearm_vector__16
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld a,izl
	push xwa
	call _dma_set_start_vector__16
	lda xsp,(xsp+8)
L1577:
	pop xiz
	ret

; function isr_dma0_inttc
_isr_dma0_inttc__16:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	jr L1606
	ldb (_s_done_flag__16),1
L1606:
	ld wa,0
	push xwa
	call _dma_rearm_in_isr__16
	lda xsp,(xsp+4)
	jr L1607
	ld xwa,(_s_done_cb__16)
	cp xwa,0
	jr z,L1608
	ld xwa,(_s_done_cb__16)
	ld xhl,xwa
	call (xhl)
L1608:
L1607:
L1605:
	pop xiz
	pop xiy
	pop xix
	pop xhl
	pop xde
	pop xbc
	pop xwa
	reti

; function isr_dma1_inttc
_isr_dma1_inttc__16:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	jr L1614
	ldb (_s_done_flag__16+1),1
L1614:
	ld wa,1
	push xwa
	call _dma_rearm_in_isr__16
	lda xsp,(xsp+4)
	jr L1615
	ld xwa,(_s_done_cb__16+4)
	cp xwa,0
	jr z,L1616
	ld xwa,(_s_done_cb__16+4)
	ld xhl,xwa
	call (xhl)
L1616:
L1615:
L1613:
	pop xiz
	pop xiy
	pop xix
	pop xhl
	pop xde
	pop xbc
	pop xwa
	reti

; function isr_dma2_inttc
_isr_dma2_inttc__16:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	jr L1622
	ldb (_s_done_flag__16+2),1
L1622:
	ld wa,2
	push xwa
	call _dma_rearm_in_isr__16
	lda xsp,(xsp+4)
	jr L1623
	ld xwa,(_s_done_cb__16+8)
	cp xwa,0
	jr z,L1624
	ld xwa,(_s_done_cb__16+8)
	ld xhl,xwa
	call (xhl)
L1624:
L1623:
L1621:
	pop xiz
	pop xiy
	pop xix
	pop xhl
	pop xde
	pop xbc
	pop xwa
	reti

; function isr_dma3_inttc
_isr_dma3_inttc__16:
	push xwa
	push xbc
	push xde
	push xhl
	push xix
	push xiy
	push xiz
	jr L1630
	ldb (_s_done_flag__16+3),1
L1630:
	ld wa,3
	push xwa
	call _dma_rearm_in_isr__16
	lda xsp,(xsp+4)
	jr L1631
	ld xwa,(_s_done_cb__16+12)
	cp xwa,0
	jr z,L1632
	ld xwa,(_s_done_cb__16+12)
	ld xhl,xwa
	call (xhl)
L1632:
L1631:
L1629:
	pop xiz
	pop xiy
	pop xix
	pop xhl
	pop xde
	pop xbc
	pop xwa
	reti

; function dma_start_common
_dma_start_common__16:
	push xiz
	ld iz,(xsp+20)
	ld a,(xsp+8)
	cp a,3
	jr ule,L1659
	jp L1658
L1659:
	ld xwa,(xsp+12)
	cp xwa,0
	jr z,L1661
	ld xwa,(xsp+16)
	cp xwa,0
	jr nz,L1660
L1661:
	jp L1658
L1660:
	ld wa,iz
	cp wa,0
	jr nz,L1662
	jp L1658
L1662:
	ld a,(xsp+24)
	cp a,11
	jr nz,L1663
	jp L1658
L1663:
	ld a,0
	ld xbc,_s_done_flag__16
	ld e,(xsp+8)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,1
	ld xbc,_s_was_active__16
	ld e,(xsp+8)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,0
	push xwa
	ld a,(xsp+12)
	push xwa
	call _dma_set_start_vector__16
	lda xsp,(xsp+8)
	ld wa,(xsp+28)
	cp wa,0
	jr z,L1665
	cp wa,1
	jr z,L1666
	cp wa,2
	jp z,L1667
	jp L1664
L1665:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L1669
	cp wa,1
	jr z,L1670
	cp wa,2
	jr z,L1671
	cp wa,3
	jr z,L1672
	jr L1668
L1669:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program__16
	lda xsp,(xsp+12)
	jr L1668
L1670:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program__16
	lda xsp,(xsp+12)
	jr L1668
L1671:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program__16
	lda xsp,(xsp+12)
	jr L1668
L1672:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program__16
	lda xsp,(xsp+12)
	jr L1668
L1668:
	jp L1664
L1666:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L1674
	cp wa,1
	jr z,L1675
	cp wa,2
	jr z,L1676
	cp wa,3
	jr z,L1677
	jr L1673
L1674:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program_u16__16
	lda xsp,(xsp+12)
	jr L1673
L1675:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program_u16__16
	lda xsp,(xsp+12)
	jr L1673
L1676:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program_u16__16
	lda xsp,(xsp+12)
	jr L1673
L1677:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program_u16__16
	lda xsp,(xsp+12)
	jr L1673
L1673:
	jr L1664
L1667:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L1679
	cp wa,1
	jr z,L1680
	cp wa,2
	jr z,L1681
	cp wa,3
	jr z,L1682
	jr L1678
L1679:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program_u32__16
	lda xsp,(xsp+12)
	jr L1678
L1680:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program_u32__16
	lda xsp,(xsp+12)
	jr L1678
L1681:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program_u32__16
	lda xsp,(xsp+12)
	jr L1678
L1682:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program_u32__16
	lda xsp,(xsp+12)
	jr L1678
L1678:
	jr L1664
L1664:
	ld a,(xsp+24)
	push xwa
	ld a,(xsp+12)
	push xwa
	call _dma_set_start_vector__16
	lda xsp,(xsp+8)
L1658:
	pop xiz
	ret

; function ngpc_dma_init
_ngpc_dma_init:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jp L1693
L1690:
	ld xwa,0
	ld xbc,_s_done_cb__16
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld a,0
	ld xbc,_s_done_flag__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_was_active__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_rearm_enabled__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_rearm_elem__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_rearm_vector__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,0
	ld xbc,_s_rearm_count__16
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,0
	ld xbc,_s_rearm_dst__16
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld xwa,0
	ld xbc,_s_rearm_src__16
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L1692:
	inc 1,izl
L1693:
	ld a,izl
	cp a,4
	jp ult,L1690
L1691:
	ld xwa,_isr_dma0_inttc__16
	ld (06FF0h),xwa
	ld xwa,_isr_dma1_inttc__16
	ld (06FF4h),xwa
	ld xwa,_isr_dma2_inttc__16
	ld (06FF8h),xwa
	ld xwa,_isr_dma3_inttc__16
	ld (06FFCh),xwa
	ldb (079h),153
	ldb (07Ah),153
L1694:
L1689:
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
	call _dma_start_common__16
	lda xsp,(xsp+24)
L1696:
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
	call _dma_start_common__16
	lda xsp,(xsp+24)
L1698:
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
	call _dma_start_common__16
	lda xsp,(xsp+24)
L1700:
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
L1702:
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
L1704:
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
L1706:
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
L1708:
	ret

; function ngpc_dma_timer0_hblank_enable
_ngpc_dma_timer0_hblank_enable:
	ld wa,1
	push xwa
	call _ngpc_dma_timer0_hblank_enable_treg0
	lda xsp,(xsp+4)
L1710:
	ret

; function ngpc_dma_timer0_hblank_enable_treg0
_ngpc_dma_timer0_hblank_enable_treg0:
	andb (024h),60
	ld a,(xsp+4)
	ld (022h),a
	orb (020h),1
L1712:
	ret

; function ngpc_dma_timer0_hblank_disable
_ngpc_dma_timer0_hblank_disable:
	andb (020h),254
L1714:
	ret

; function ngpc_dma_timer01_hblank_enable
_ngpc_dma_timer01_hblank_enable:
	andb (024h),48
	ldb (022h),1
	ldb (023h),1
	orb (020h),3
L1716:
	ret

; function ngpc_dma_timer01_hblank_disable
_ngpc_dma_timer01_hblank_disable:
	andb (020h),252
L1718:
	ret

; function ngpc_dma_timer1_from_timer0_enable
_ngpc_dma_timer1_from_timer0_enable:
	ld wa,1
	push xwa
	call _ngpc_dma_timer1_from_timer0_enable_treg1
	lda xsp,(xsp+4)
L1720:
	ret

; function ngpc_dma_timer1_from_timer0_enable_treg1
_ngpc_dma_timer1_from_timer0_enable_treg1:
	andb (024h),243
	ld a,(xsp+4)
	ld (023h),a
	orb (020h),2
L1722:
	ret

; function ngpc_dma_timer1_disable
_ngpc_dma_timer1_disable:
	andb (020h),253
L1724:
	ret

; function ngpc_dma_hblank_stream_begin
_ngpc_dma_hblank_stream_begin:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1728
	jr L1727
L1728:
	ld a,(xsp+12)
	ld (xiz),a
	ld xwa,(xsp+16)
	ld (xiz+2),xwa
	ld xwa,(xsp+20)
	ld (xiz+6),xwa
	ld wa,(xsp+24)
	ld (xiz+10),wa
L1727:
	pop xiz
	ret

; function ngpc_dma_hblank_stream_rearm
_ngpc_dma_hblank_stream_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1732
	jr L1731
L1732:
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
L1731:
	pop xiz
	ret

; function ngpc_dma_hblank_stream_end
_ngpc_dma_hblank_stream_end:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L1736
	jr L1735
L1736:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L1735:
	ret

; function ngpc_dma_stream_begin_u8
_ngpc_dma_stream_begin_u8:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1740
	jr L1739
L1740:
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
L1739:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u8
_ngpc_dma_stream_rearm_u8:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1744
	jr L1743
L1744:
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
L1743:
	pop xiz
	ret

; function ngpc_dma_stream_end_u8
_ngpc_dma_stream_end_u8:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L1748
	jr L1747
L1748:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L1747:
	ret

; function ngpc_dma_stream_begin_u16
_ngpc_dma_stream_begin_u16:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1752
	jr L1751
L1752:
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
L1751:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u16
_ngpc_dma_stream_rearm_u16:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1756
	jr L1755
L1756:
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
L1755:
	pop xiz
	ret

; function ngpc_dma_stream_end_u16
_ngpc_dma_stream_end_u16:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L1760
	jr L1759
L1760:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L1759:
	ret

; function ngpc_dma_stream_begin_u32
_ngpc_dma_stream_begin_u32:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1764
	jr L1763
L1764:
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
L1763:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u32
_ngpc_dma_stream_rearm_u32:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1768
	jr L1767
L1768:
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
L1767:
	pop xiz
	ret

; function ngpc_dma_stream_end_u32
_ngpc_dma_stream_end_u32:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L1772
	jr L1771
L1772:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L1771:
	ret

; function ngpc_dma_stop
_ngpc_dma_stop:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L1781
	jr L1780
L1781:
	ld wa,0
	push xwa
	ld a,izl
	push xwa
	call _dma_set_start_vector__16
	lda xsp,(xsp+8)
	ld a,0
	ld xbc,_s_was_active__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_done_flag__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,izl
	extz wa
	cp wa,0
	jr z,L1783
	cp wa,1
	jr z,L1784
	cp wa,2
	jr z,L1785
	cp wa,3
	jr z,L1786
	jr L1782
L1783:
	call _dma0_clear__16
	jr L1782
L1784:
	call _dma1_clear__16
	jr L1782
L1785:
	call _dma2_clear__16
	jr L1782
L1786:
	call _dma3_clear__16
	jr L1782
L1782:
L1780:
	pop xiz
	ret

; function ngpc_dma_remaining
_ngpc_dma_remaining:
	ld a,(xsp+4)
	extz wa
	cp wa,0
	jr z,L1796
	cp wa,1
	jr z,L1797
	cp wa,2
	jr z,L1798
	cp wa,3
	jr z,L1799
	jr L1800
L1796:
	ldc wa,dmac0
	jr L1794
L1797:
	ldc wa,dmac1
	jr L1794
L1798:
	ldc wa,dmac2
	jr L1794
L1799:
	ldc wa,dmac3
	jr L1794
L1800:
	ld wa,0
	jr L1794
L1795:
L1794:
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
	jr z,L1805
	ld wa,1
	jr L1806
L1805:
	ld wa,0
L1806:
	jr L1804
L1804:
	ret

; function ngpc_dma_set_done_handler
_ngpc_dma_set_done_handler:
	ld a,(xsp+4)
	cp a,3
	jr ule,L1810
	jr L1809
L1810:
	ld xwa,(xsp+8)
	ld xbc,_s_done_cb__16
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L1809:
	ret

; function ngpc_dma_poll_done
_ngpc_dma_poll_done:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L1816
	ld wa,0
	jr L1815
L1816:
	ld xwa,_s_done_flag__16
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+0),a
	ld a,(xsp+0)
	cp a,0
	jr z,L1817
	ld a,0
	ld xbc,_s_done_flag__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,0
	ld xbc,_s_was_active__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,1
	jr L1815
L1817:
	ld xwa,_s_was_active__16
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L1818
	ld a,izl
	push xwa
	call _ngpc_dma_remaining
	lda xsp,(xsp+4)
	cp wa,0
	jr nz,L1818
	ld a,0
	ld xbc,_s_was_active__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,1
	jr L1815
L1818:
	ld wa,0
	jr L1815
L1815:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_dma_pp_init
_ngpc_dma_pp_init:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1822
	jr L1821
L1822:
	ld xwa,(xsp+12)
	ld (xiz),xwa
	ld wa,(xsp+16)
	ld (xiz+4),wa
	ldw (xiz+6),0
L1821:
	pop xiz
	ret

; function ngpc_dma_pp_front
_ngpc_dma_pp_front:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr z,L1828
	ld xwa,(xiz)
	cp xwa,0
	jr nz,L1827
L1828:
	ld xwa,0
	jr L1826
L1827:
	ld xwa,(xiz)
	ld bc,(xiz+6)
	extz xbc
	add xwa,xbc
	jr L1826
L1826:
	pop xiz
	ret

; function ngpc_dma_pp_back
_ngpc_dma_pp_back:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr z,L1834
	ld xwa,(xiz)
	cp xwa,0
	jr nz,L1833
L1834:
	ld xwa,0
	jr L1832
L1833:
	ld xwa,(xiz)
	ld bc,(xiz+6)
	xor bc,(xiz+4)
	extz xbc
	add xwa,xbc
	jr L1832
L1832:
	pop xiz
	ret

; function ngpc_dma_pp_swap
_ngpc_dma_pp_swap:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1838
	jr L1837
L1838:
	ld wa,(xiz+6)
	xor wa,(xiz+4)
	ld (xiz+6),wa
L1837:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u8
_ngpc_dma_autorearm_begin_u8:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L1842
	jr L1841
L1842:
	ld a,0
	ld xbc,_s_rearm_elem__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(xsp+12)
	ld xbc,_s_rearm_dst__16
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld xwa,(xsp+16)
	ld xbc,_s_rearm_src__16
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,(xsp+20)
	ld xbc,_s_rearm_count__16
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+24)
	ld xbc,_s_rearm_vector__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1841:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u16
_ngpc_dma_autorearm_begin_u16:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L1846
	jr L1845
L1846:
	ld a,1
	ld xbc,_s_rearm_elem__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(xsp+12)
	ld xbc,_s_rearm_dst__16
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld xwa,(xsp+16)
	ld xbc,_s_rearm_src__16
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,(xsp+20)
	ld xbc,_s_rearm_count__16
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+24)
	ld xbc,_s_rearm_vector__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1845:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u32
_ngpc_dma_autorearm_begin_u32:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L1850
	jr L1849
L1850:
	ld a,2
	ld xbc,_s_rearm_elem__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(xsp+12)
	ld xbc,_s_rearm_dst__16
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld xwa,(xsp+16)
	ld xbc,_s_rearm_src__16
	ld e,izl
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
	ld wa,(xsp+20)
	ld xbc,_s_rearm_count__16
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+24)
	ld xbc,_s_rearm_vector__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1849:
	pop xiz
	ret

; function ngpc_dma_autorearm_set_src_u8
_ngpc_dma_autorearm_set_src_u8:
	ld a,(xsp+4)
	cp a,3
	jr ule,L1854
	jr L1853
L1854:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__16
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L1853:
	ret

; function ngpc_dma_autorearm_set_src_u16
_ngpc_dma_autorearm_set_src_u16:
	ld a,(xsp+4)
	cp a,3
	jr ule,L1858
	jr L1857
L1858:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__16
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L1857:
	ret

; function ngpc_dma_autorearm_set_src_u32
_ngpc_dma_autorearm_set_src_u32:
	ld a,(xsp+4)
	cp a,3
	jr ule,L1862
	jr L1861
L1862:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__16
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L1861:
	ret

; function ngpc_dma_autorearm_enable
_ngpc_dma_autorearm_enable:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L1872
	jp L1871
L1872:
	jr L1873
	jp L1871
L1873:
	ld a,1
	ld xbc,_s_rearm_enabled__16
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,_s_rearm_elem__16
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	cp wa,0
	jr z,L1876
	cp wa,1
	jr z,L1877
	cp wa,2
	jp z,L1878
	jr L1875
L1875:
L1876:
	ld xwa,_s_rearm_vector__16
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
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
	jp L1874
L1877:
	ld xwa,_s_rearm_vector__16
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
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
	jr L1874
L1878:
	ld xwa,_s_rearm_vector__16
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,_s_rearm_count__16
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,_s_rearm_src__16
	ld c,izl
	extz bc
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld xwa,(xwa)
	push xwa
	ld xwa,_s_rearm_dst__16
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
	jr L1874
L1874:
L1871:
	pop xiz
	ret

; function ngpc_dma_autorearm_disable
_ngpc_dma_autorearm_disable:
	ld a,(xsp+4)
	cp a,3
	jr ule,L1882
	jr L1881
L1882:
	ld a,0
	ld xbc,_s_rearm_enabled__16
	ld e,(xsp+4)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1881:
	ret

; function plane_reg_x
_plane_reg_x__17:
	ld a,(xsp+4)
	cp a,1
	jr nz,L1886
	ld xwa,08034h
	jr L1885
L1886:
	ld xwa,08032h
	jr L1885
L1885:
	ret

; function plane_reg_y
_plane_reg_y__17:
	ld a,(xsp+4)
	cp a,1
	jr nz,L1890
	ld xwa,08035h
	jr L1889
L1890:
	ld xwa,08033h
	jr L1889
L1889:
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
L1892:
	ret

; function ngpc_dma_raster_begin_ex
_ngpc_dma_raster_begin_ex:
	push xiz
	lda xsp,(xsp-8)
	ld xiz,(xsp+16)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1902
	jp L1901
L1902:
	ld a,(xsp+20)
	ld (xiz),a
	ldb (xiz+1),0
	ld xwa,(xsp+28)
	ld (xiz+2),xwa
	ld xwa,(xsp+36)
	ld (xiz+6),xwa
	ld a,(xsp+20)
	push xwa
	call _plane_reg_x__17
	lda xsp,(xsp+4)
	ld (xsp+0),xwa
	ld a,(xsp+20)
	push xwa
	call _plane_reg_y__17
	lda xsp,(xsp+4)
	ld (xsp+4),xwa
	ld xwa,(xsp+28)
	cp xwa,0
	jr z,L1903
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
	jr L1904
L1903:
	ld xwa,(xsp+36)
	cp xwa,0
	jr z,L1905
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
	jr L1906
L1905:
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
L1906:
L1904:
	ld xwa,(xsp+28)
	cp xwa,0
	jr z,L1907
	ld xwa,(xsp+36)
	cp xwa,0
	jr z,L1907
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
	jr L1908
L1907:
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
L1908:
L1901:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function ngpc_dma_raster_enable
_ngpc_dma_raster_enable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1915
	jr L1914
L1915:
	ldb (xiz+1),0
	ld xwa,(xiz+2)
	cp xwa,0
	jr nz,L1916
	ld xwa,(xiz+6)
	cp xwa,0
	jr nz,L1916
	jr L1914
L1916:
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L1917
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L1917
	call _ngpc_dma_timer01_hblank_enable
	jr L1918
L1917:
	call _ngpc_dma_timer0_hblank_enable
L1918:
	ldb (xiz+1),1
L1914:
	pop xiz
	ret

; function ngpc_dma_raster_rearm
_ngpc_dma_raster_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1927
	jr L1926
L1927:
	ld a,(xiz+1)
	cp a,0
	jr nz,L1928
	jr L1926
L1928:
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L1929
	lda xwa,(xiz+10)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L1930
	lda xwa,(xiz+24)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
L1930:
	jr L1931
L1929:
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L1932
	lda xwa,(xiz+10)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
L1932:
L1931:
L1926:
	pop xiz
	ret

; function ngpc_dma_raster_disable
_ngpc_dma_raster_disable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1939
	jr L1938
L1939:
	ld a,(xiz+1)
	cp a,0
	jr z,L1940
	ld a,(xiz+10)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L1941
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L1941
	ld a,(xiz+24)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	call _ngpc_dma_timer01_hblank_disable
	jr L1942
L1941:
	call _ngpc_dma_timer0_hblank_disable
L1942:
L1940:
	ldb (xiz+1),0
L1938:
	pop xiz
	ret

; function ngpc_dma_raster_build_parallax_table
_ngpc_dma_raster_build_parallax_table:
	push xiz
	lda xsp,(xsp-6)
	ld xiy,(xsp+18)
	ld xwa,(xsp+14)
	cp xwa,0
	jr nz,L1962
	jp L1961
L1962:
	ld xwa,xiy
	cp xwa,0
	jr z,L1964
	ld a,(xsp+22)
	cp a,0
	jr nz,L1963
L1964:
	ld izl,0
	jr L1968
L1965:
	ld a,0
	ld xbc,(xsp+14)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1967:
	inc 1,izl
L1968:
	ld a,izl
	cp a,152
	jr ult,L1965
L1966:
	jp L1961
L1963:
	ld ixl,0
	jp L1972
L1969:
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
	jr ge,L1973
	ld xwa,xiy
	ld c,ixl
	extz bc
	add bc,1
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L1974
L1973:
	ld a,152
	extz wa
L1974:
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
	jr L1978
L1975:
	ld a,(xsp+4)
	ld xbc,(xsp+14)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1977:
	inc 1,izl
L1978:
	ld a,izl
	cp a,(xsp+3)
	jr ult,L1975
L1976:
L1971:
	inc 1,ixl
L1972:
	ld a,ixl
	cp a,(xsp+22)
	jp ult,L1969
L1970:
L1961:
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
L1980:
	ret

; function ngpc_dma_raster_xy_begin_ex
_ngpc_dma_raster_xy_begin_ex:
	push xiz
	lda xsp,(xsp-4)
	ld xiz,(xsp+12)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1986
	jr L1985
L1986:
	ld a,(xsp+16)
	ld (xiz),a
	ldb (xiz+1),0
	ld xwa,(xsp+24)
	ld (xiz+2),xwa
	ld a,(xsp+16)
	push xwa
	call _plane_reg_x__17
	lda xsp,(xsp+4)
	ld (xsp+0),xwa
	ld xwa,(xsp+24)
	cp xwa,0
	jr z,L1987
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
	jr L1988
L1987:
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
L1988:
L1985:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function ngpc_dma_raster_xy_enable
_ngpc_dma_raster_xy_enable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1993
	jr L1992
L1993:
	ldb (xiz+1),0
	ld xwa,(xiz+2)
	cp xwa,0
	jr nz,L1994
	jr L1992
L1994:
	call _ngpc_dma_timer0_hblank_enable
	ldb (xiz+1),1
L1992:
	pop xiz
	ret

; function ngpc_dma_raster_xy_rearm
_ngpc_dma_raster_xy_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L1999
	jr L1998
L1999:
	ld a,(xiz+1)
	cp a,0
	jr nz,L2000
	jr L1998
L2000:
	lda xwa,(xiz+6)
	push xwa
	call _ngpc_dma_stream_rearm_u16
	lda xsp,(xsp+4)
L1998:
	pop xiz
	ret

; function ngpc_dma_raster_xy_disable
_ngpc_dma_raster_xy_disable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2005
	jr L2004
L2005:
	ld a,(xiz+1)
	cp a,0
	jr z,L2006
	ld a,(xiz+6)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	call _ngpc_dma_timer0_hblank_disable
L2006:
	ldb (xiz+1),0
L2004:
	pop xiz
	ret

; function ngpc_dma_raster_build_parallax_table_xy
_ngpc_dma_raster_build_parallax_table_xy:
	push xiz
	lda xsp,(xsp-8)
	ld xiy,(xsp+20)
	ld xwa,(xsp+16)
	cp xwa,0
	jr nz,L2026
	jp L2025
L2026:
	ld xwa,xiy
	cp xwa,0
	jr z,L2028
	ld a,(xsp+24)
	cp a,0
	jr nz,L2027
L2028:
	ld izl,0
	jr L2032
L2029:
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
L2031:
	inc 1,izl
L2032:
	ld a,izl
	cp a,152
	jr ult,L2029
L2030:
	jp L2025
L2027:
	ld ixl,0
	jp L2036
L2033:
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
	jr ge,L2037
	ld xwa,xiy
	ld c,ixl
	extz bc
	add bc,1
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L2038
L2037:
	ld a,152
	extz wa
L2038:
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
	jr L2042
L2039:
	ld wa,(xsp+6)
	ld xbc,(xsp+16)
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2041:
	inc 1,izl
L2042:
	ld a,izl
	cp a,(xsp+3)
	jr ult,L2039
L2040:
L2035:
	inc 1,ixl
L2036:
	ld a,ixl
	cp a,(xsp+24)
	jp ult,L2033
L2034:
L2025:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function audio_init
_audio_init:
	call _player_init
L2044:
	ret

; function audio_update
_audio_update:
	call _player_update
L2046:
	ret

; function music_play
_music_play:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	cp a,6
	jr ult,L2050
	call _music_stop
	jr L2049
L2050:
	ld xwa,_music_songs
	ld c,(xsp+12)
	extz bc
	muls xbc,18
	add xwa,xbc
	lda xwa,(xwa)
	ld xiz,xwa
	ld a,(xsp+12)
	ld (_cur_song__18),a
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
L2049:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function music_stop
_music_stop:
	call _player_stop
	ldb (_cur_song__18),255
L2052:
	ret

; function music_fade
_music_fade:
	call _player_stop
L2054:
	ret

; function music_current
_music_current:
	ld a,(_cur_song__18)
	jr L2056
L2056:
	ret

; function sfx
_sfx:
	ld a,(xsp+4)
	extz wa
	cp wa,0
	jr z,L2070
	cp wa,1
	jr z,L2071
	cp wa,2
	jr z,L2072
	cp wa,3
	jp z,L2073
	cp wa,4
	jp z,L2074
	cp wa,5
	jp z,L2075
	cp wa,7
	jp z,L2076
	cp wa,6
	jp z,L2077
	jp L2078
L2070:
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
	jp L2069
L2071:
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
	jp L2069
L2072:
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
	jp L2069
L2073:
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
	jr L2069
L2074:
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
	jr L2069
L2075:
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
	jr L2069
L2076:
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
	jr L2069
L2077:
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
	jr L2069
L2078:
	jr L2069
L2069:
L2068:
	ret

; function scr_map
_scr_map__19:
	ld c,(xsp+4)
	cp c,0
	jr nz,L2083
	ld xwa,36864
	jr L2084
L2083:
	ld xwa,38912
L2084:
	jr L2082
L2082:
	ret

; function pal_base
_pal_base__19:
	ld a,(xsp+4)
	cp a,2
	jr nz,L2089
	ld xwa,33280
	jr L2088
L2089:
	ld a,(xsp+4)
	cp a,0
	jr nz,L2090
	ld xwa,33408
	jr L2088
L2090:
	ld xwa,33536
	jr L2088
L2088:
	ret

; function ngpc_gfx_load_tiles
_ngpc_gfx_load_tiles:
	push xiz
	lda xsp,(xsp-8)
	ld xwa,40960
	ld xiy,xwa
	ld iz,0
	jr L2100
L2097:
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
L2099:
	inc 1,iz
L2100:
	ld wa,iz
	cp wa,(xsp+20)
	jr ult,L2097
L2098:
L2096:
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
	jr L2110
L2107:
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
L2109:
	inc 1,iz
L2110:
	ld wa,iz
	cp wa,(xsp+20)
	jr ult,L2107
L2108:
L2106:
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
	jr L2120
L2117:
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
L2119:
	inc 1,iz
L2120:
	ld wa,iz
	cp wa,ix
	jr ult,L2117
L2118:
L2116:
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
	jr L2130
L2127:
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
L2129:
	inc 1,iz
L2130:
	ld wa,iz
	cp wa,ix
	jr ult,L2127
L2128:
L2126:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function make_entry
_make_entry__19:
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
	jr L2132
L2132:
	ret

; function ngpc_gfx_put_tile
_ngpc_gfx_put_tile:
	lda xsp,(xsp-4)
	ld a,(xsp+8)
	push xwa
	call _scr_map__19
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
	call _make_entry__19
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
L2134:
	lda xsp,(xsp+4)
	ret

; function ngpc_gfx_put_tile_ex
_ngpc_gfx_put_tile_ex:
	lda xsp,(xsp-4)
	ld a,(xsp+8)
	push xwa
	call _scr_map__19
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
	call _make_entry__19
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
L2136:
	lda xsp,(xsp+4)
	ret

; function ngpc_gfx_get_tile
_ngpc_gfx_get_tile:
	push xiz
	lda xsp,(xsp-6)
	ld a,(xsp+14)
	push xwa
	call _scr_map__19
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
L2138:
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
	call _scr_map__19
	lda xsp,(xsp+4)
	pop xix
	ld xix,xwa
	ld iz,0
	jr L2148
L2145:
	ld wa,0
	ld xbc,xix
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2147:
	inc 1,iz
L2148:
	ld wa,iz
	cp wa,1024
	jr ult,L2145
L2146:
L2144:
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
	call _scr_map__19
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
	call _make_entry__19
	lda xsp,(xsp+16)
	pop xiy
	pop xix
	ld ix,wa
	ld iz,0
	jr L2158
L2155:
	ld wa,ix
	ld xbc,xiy
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2157:
	inc 1,iz
L2158:
	ld wa,iz
	cp wa,1024
	jr ult,L2155
L2156:
L2154:
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
	call _scr_map__19
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
	call _make_entry__19
	lda xsp,(xsp+16)
	pop xiy
	pop xix
	ld (xsp+4),wa
	ld ixl,0
	jr L2172
L2169:
	ld a,(xsp+28)
	add a,ixl
	and a,31
	ld (xsp+8),a
	ld a,(xsp+8)
	extz wa
	sll 5,wa
	ld (xsp+10),wa
	ld izl,0
	jr L2176
L2173:
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
L2175:
	inc 1,izl
L2176:
	ld a,izl
	cp a,(xsp+32)
	jr ult,L2173
L2174:
L2171:
	inc 1,ixl
L2172:
	ld a,ixl
	cp a,(xsp+36)
	jr ult,L2169
L2170:
L2168:
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
	call _scr_map__19
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
	jr L2190
L2187:
	ld a,(xsp+30)
	add a,(xsp+6)
	and a,31
	ld (xsp+8),a
	ld a,(xsp+8)
	extz wa
	sll 5,wa
	ld (xsp+10),wa
	ld ixl,0
	jr L2194
L2191:
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
L2193:
	inc 1,ixl
L2194:
	ld a,ixl
	cp a,(xsp+34)
	jr ult,L2191
L2192:
L2189:
	incb 1,(xsp+6)
L2190:
	ld a,(xsp+6)
	cp a,(xsp+38)
	jr ult,L2187
L2188:
L2186:
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
	call _pal_base__19
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
L2196:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_gfx_set_bg_color
_ngpc_gfx_set_bg_color:
	ld wa,(xsp+4)
	ld xbc,33760
	ld (xbc),wa
	ldb (08118h),128
L2198:
	ret

; function ngpc_gfx_scroll
_ngpc_gfx_scroll:
	ld a,(xsp+4)
	cp a,0
	jr nz,L2203
	ld a,(xsp+8)
	ld (08032h),a
	ld a,(xsp+12)
	ld (08033h),a
	jr L2204
L2203:
	ld a,(xsp+8)
	ld (08034h),a
	ld a,(xsp+12)
	ld (08035h),a
L2204:
L2202:
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
	jr nz,L2219
	ldb (08032h),0
	ldb (08033h),0
	jr L2220
L2219:
	ld a,(xsp+8)
	extz wa
	ld c,ixl
	cp c,0
	jr z,L2222
L2221:
	sra 1,wa
	djnz c,L2221
L2222:
	ld (08032h),a
	ld a,(xsp+12)
	extz wa
	ld c,ixl
	cp c,0
	jr z,L2224
L2223:
	sra 1,wa
	djnz c,L2223
L2224:
	ld (08033h),a
L2220:
	ld a,izl
	cp a,255
	jr nz,L2225
	ldb (08034h),0
	ldb (08035h),0
	jr L2226
L2225:
	ld a,(xsp+8)
	extz wa
	ld c,izl
	cp c,0
	jr z,L2228
L2227:
	sra 1,wa
	djnz c,L2227
L2228:
	ld (08034h),a
	ld a,(xsp+12)
	extz wa
	ld c,izl
	cp c,0
	jr z,L2230
L2229:
	sra 1,wa
	djnz c,L2229
L2230:
	ld (08035h),a
L2226:
L2218:
	pop xiz
	ret

; function ngpc_gfx_swap_planes
_ngpc_gfx_swap_planes:
	xorb (08030h),128
L2232:
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
L2234:
	ret

; function ngpc_gfx_sprite_offset
_ngpc_gfx_sprite_offset:
	ld a,(xsp+4)
	ld (08020h),a
	ld a,(xsp+8)
	ld (08021h),a
L2236:
	ret

; function ngpc_gfx_lcd_invert
_ngpc_gfx_lcd_invert:
	ld a,(xsp+4)
	cp a,0
	jr z,L2241
	orb (08012h),128
	jr L2242
L2241:
	andb (08012h),127
L2242:
L2240:
	ret

; function ngpc_gfx_set_outside_color
_ngpc_gfx_set_outside_color:
	ld a,(08012h)
	and a,248
	ld c,(xsp+4)
	and c,7
	or a,c
	ld (08012h),a
L2244:
	ret

; function ngpc_gfx_char_over
_ngpc_gfx_char_over:
	ld c,(08010h)
	extz bc
	and bc,128
	cp bc,0
	jr z,L2249
	ld wa,1
	jr L2250
L2249:
	ld wa,0
L2250:
	jr L2248
L2248:
	ret

; function ngpc_gfx_set_color_direct
_ngpc_gfx_set_color_direct:
	lda xsp,(xsp-4)
	ld a,(xsp+8)
	push xwa
	call _pal_base__19
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
L2252:
	lda xsp,(xsp+4)
	ret

; function ngpc_tile_rotate90
_ngpc_tile_rotate90:
	push xiz
	lda xsp,(xsp-6)
	ld ixl,0
	jr L2270
L2267:
	ld iy,0
	ld izl,0
	jr L2274
L2271:
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
	jr z,L2276
L2275:
	srl 1,wa
	djnz c,L2275
L2276:
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
	jr z,L2278
L2277:
	sll 1,bc
	djnz e,L2277
L2278:
	or wa,bc
	ld iy,wa
L2273:
	inc 1,izl
L2274:
	ld a,izl
	cp a,8
	jr ult,L2271
L2272:
	ld wa,iy
	ld xbc,(xsp+18)
	ld e,ixl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2269:
	inc 1,ixl
L2270:
	ld a,ixl
	cp a,8
	jp ult,L2267
L2268:
L2266:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_tile_rotate270
_ngpc_tile_rotate270:
	push xiz
	lda xsp,(xsp-6)
	ld ixl,0
	jr L2296
L2293:
	ld iy,0
	ld izl,0
	jr L2300
L2297:
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
	jr z,L2302
L2301:
	srl 1,wa
	djnz c,L2301
L2302:
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
	jr z,L2304
L2303:
	sll 1,bc
	djnz e,L2303
L2304:
	or wa,bc
	ld iy,wa
L2299:
	inc 1,izl
L2300:
	ld a,izl
	cp a,8
	jr ult,L2297
L2298:
	ld wa,iy
	ld xbc,(xsp+18)
	ld e,ixl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2295:
	inc 1,ixl
L2296:
	ld a,ixl
	cp a,8
	jp ult,L2293
L2294:
L2292:
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
L2306:
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
L2308:
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
L2310:
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
L2312:
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
L2314:
	lda xsp,(xsp+4)
	ret

; function ngpc_sprite_hide_all
_ngpc_sprite_hide_all:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L2324
L2321:
	ld a,izl
	push xwa
	call _ngpc_sprite_hide
	lda xsp,(xsp+4)
L2323:
	inc 1,izl
L2324:
	ld a,izl
	cp a,64
	jr ult,L2321
L2322:
L2320:
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
L2326:
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
L2328:
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
	jr L2330
L2330:
	ret

; function ngpc_text_print
_ngpc_text_print:
	push xiz
	lda xsp,(xsp-2)
	ld xiz,(xsp+26)
	ld a,(xsp+18)
	ld iyl,a
	jr L2340
L2338:
	ld a,(xiz)
	ld ixl,a
	ld a,ixl
	cp a,32
	jr ult,L2341
	ld a,ixl
	cp a,128
	jr uge,L2341
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
L2341:
	inc 1,iyl
	ld a,iyl
	cp a,20
	jr ult,L2342
	jr L2339
L2342:
	ld xwa,xiz
	inc 1,xwa
	ld xiz,xwa
L2340:
	ld a,(xiz)
	cp a,0
	jr nz,L2338
L2339:
L2337:
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
	jr L2356
L2353:
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
L2355:
	inc 1,izl
L2356:
	ld a,izl
	cp a,5
	jr ult,L2353
L2354:
	ld a,5
	sub a,(xsp+38)
	ld izl,a
	jr L2360
L2357:
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
L2359:
	inc 1,izl
L2360:
	ld a,izl
	cp a,5
	jr ult,L2357
L2358:
L2352:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_text_print_hex
_ngpc_text_print_hex:
	push xiz
	lda xsp,(xsp-8)
	ld izl,0
	jr L2374
L2371:
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
	jr z,L2376
L2375:
	srl 1,wa
	djnz c,L2375
L2376:
	and wa,15
	ld ixl,a
	ld a,ixl
	cp a,10
	jr uge,L2377
	ld a,ixl
	extz wa
	add wa,48
	ld iy,wa
	jr L2378
L2377:
	ld a,ixl
	extz wa
	sub wa,10
	add wa,65
	ld iy,wa
L2378:
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
L2373:
	inc 1,izl
L2374:
	ld a,izl
	cp a,(xsp+36)
	jp ult,L2371
L2372:
L2370:
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
	jr L2394
L2391:
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
L2393:
	inc 1,izl
L2394:
	ld a,izl
	cp a,5
	jr ult,L2391
L2392:
	ld a,5
	sub a,(xsp+40)
	ld izl,a
	jr L2398
L2395:
	ld a,(xsp+8)
	cp a,0
	jr z,L2399
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L2399
	ld a,izl
	cp a,4
	jr uge,L2399
	ld ix,32
	jr L2400
L2399:
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
L2400:
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
L2397:
	inc 1,izl
L2398:
	ld a,izl
	cp a,5
	jr ult,L2395
L2396:
L2390:
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
L2402:
	ret

; function ngpc_text_tile_screen
_ngpc_text_tile_screen:
	push xiz
	lda xsp,(xsp-4)
	ld wa,0
	ld (xsp+2),wa
	ld ixl,0
	jr L2416
L2413:
	ld izl,0
	jr L2420
L2417:
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
L2419:
	inc 1,izl
L2420:
	ld a,izl
	cp a,20
	jr ult,L2417
L2418:
L2415:
	inc 1,ixl
L2416:
	ld a,ixl
	cp a,19
	jr ult,L2413
L2414:
L2412:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function hud_score_reset
_hud_score_reset:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L2430
L2427:
	ld a,0
	ld xbc,_s_dig__22
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2429:
	inc 1,izl
L2430:
	ld a,izl
	cp a,7
	jr ult,L2427
L2428:
L2426:
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
	jr L2439
L2437:
	dec 1,izl
	ld xwa,_s_dig__22
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
	ld xbc,_s_dig__22
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,ix
	extz xwa
	div xwa,10
	ld iy,wa
L2439:
	ld wa,iy
	cp wa,0
	jr z,L2440
	ld a,izl
	cp a,0
	jr ugt,L2437
L2440:
L2438:
L2436:
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
	jr L2450
L2447:
	ld xwa,_gfx_font_tiles__22
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
L2449:
	inc 1,iz
L2450:
	ld wa,iz
	cp wa,552
	jr ult,L2447
L2448:
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
L2446:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function hud_reset
_hud_reset:
	ld a,255
	ld (_h_stage__22),a
	ld (_h_prog__22),a
	ld (_h_gear__22),a
	ld (_h_kmh__22),a
	ld (_h_time__22),a
	ldb (_h_score_ok__22),0
L2452:
	ret

; function hud_clear_top
_hud_clear_top:
	push xiz
	lda xsp,(xsp-2)
	ld ixl,0
	jr L2466
L2463:
	ld izl,0
	jr L2470
L2467:
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
L2469:
	inc 1,izl
L2470:
	ld a,izl
	cp a,20
	jr ult,L2467
L2468:
L2465:
	inc 1,ixl
L2466:
	ld a,ixl
	cp a,15
	jr ult,L2463
L2464:
L2462:
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
	jr L2478
L2476:
	inc 1,izl
L2478:
	ld xwa,xix
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L2476
L2477:
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
L2475:
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
	jr L2488
L2485:
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
L2487:
	inc 1,izl
L2488:
	ld a,izl
	cp a,20
	jr ult,L2485
L2486:
L2484:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function put_digit
_put_digit__22:
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
L2490:
	ret

; function hud_race
_hud_race:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	cp a,(_h_time__22)
	jr z,L2516
	ld a,(_h_time__22)
	cp a,255
	jr nz,L2517
	ld xwa,_S22_0
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
L2517:
	ld c,(xsp+12)
	cp c,10
	jr uge,L2518
	ld wa,2
	jr L2519
L2518:
	ld wa,1
L2519:
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
	call _put_digit__22
	lda xsp,(xsp+16)
	ld c,(xsp+12)
	cp c,10
	jr uge,L2520
	ld wa,2
	jr L2521
L2520:
	ld wa,1
L2521:
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
	call _put_digit__22
	lda xsp,(xsp+16)
	ld a,(xsp+12)
	ld (_h_time__22),a
L2516:
	ld a,(xsp+28)
	cp a,(_h_stage__22)
	jr z,L2522
	ld xwa,_S22_1
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
	call _put_digit__22
	lda xsp,(xsp+16)
	ld a,(xsp+28)
	ld (_h_stage__22),a
	ldb (_h_prog__22),255
L2522:
	ld wa,(xsp+24)
	mul xwa,3
	add wa,9
	extz xwa
	div xwa,10
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,(_h_prog__22)
	jr z,L2523
	ld izl,0
	jr L2527
L2524:
	ld wa,0
	push xwa
	ld c,izl
	cp c,(xsp+5)
	jr uge,L2528
	ld wa,97
	jr L2529
L2528:
	ld wa,96
L2529:
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
L2526:
	inc 1,izl
L2527:
	ld a,izl
	cp a,3
	jr ult,L2524
L2525:
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
	ld (_h_prog__22),a
L2523:
	ld a,(xsp+16)
	cp a,(_h_kmh__22)
	jp z,L2530
	ld a,(xsp+16)
	extz wa
	sll 1,wa
	ld (xsp+2),wa
	ld a,(_h_kmh__22)
	cp a,255
	jr nz,L2531
	ld xwa,_S22_2
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
L2531:
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
	call _put_digit__22
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
	call _put_digit__22
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
	call _put_digit__22
	lda xsp,(xsp+16)
	ld a,(xsp+16)
	ld (_h_kmh__22),a
L2530:
	ld a,(xsp+20)
	cp a,(_h_gear__22)
	jr z,L2532
	ld c,(xsp+20)
	cp c,1
	jr nz,L2533
	ld xwa,_S22_3
	jr L2534
L2533:
	ld xwa,_S22_4
L2534:
	push xwa
	ld wa,1
	push xwa
	ld wa,16
	push xwa
	ld c,(xsp+32)
	cp c,1
	jr nz,L2535
	ld wa,1
	jr L2536
L2535:
	ld c,(xsp+32)
	cp c,2
	jr nz,L2537
	ld wa,2
	jr L2538
L2537:
	ld wa,0
L2538:
L2536:
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	ld a,(xsp+20)
	ld (_h_gear__22),a
L2532:
L2515:
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
	jr uge,L2543
	ld a,izl
	extz wa
	mul xwa,7
	extz xwa
	div xwa,6
	jr L2544
L2543:
	ld wa,112
	ld c,izl
	extz bc
	sub bc,96
	srl 3,bc
	sub wa,bc
L2544:
	ld (xsp+0),wa
	ld a,(xsp+14)
	extz wa
	mul xwa,(xsp+0)
	srl 7,wa
	jr L2542
L2542:
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
L2546:
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
L2548:
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
	jr ult,L2555
	jr L2554
L2555:
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
L2556:
	ld a,(xiz)
	and a,231
	ld (xiz),a
	ld bc,4
	exts xbc
	ld xwa,xiz
	add xwa,xbc
	ld xiz,xwa
L2558:
	dec 1,ixl
	ld a,ixl
	cp a,0
	jr nz,L2556
L2557:
L2554:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function mesure_roues
_mesure_roues__25:
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
	jp L2590
L2587:
	ld a,(xsp+0)
	extz wa
	ld c,(_body__25+29)
	extz bc
	mul xwa,bc
	ld (xsp+6),a
	ld xwa,(_body__25+14)
	ld c,(xsp+6)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+7),a
	ld xwa,(_body__25+10)
	ld c,(xsp+6)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+8),a
	ldb (xsp+1),0
	jp L2594
L2591:
	ld xwa,(_body__25+22)
	ld c,(xsp+7)
	add c,(xsp+1)
	extz bc
	muls xbc,3
	add xwa,xbc
	ld a,(xwa)
	ld iyl,a
	ld xwa,(_body__25+22)
	ld c,(xsp+7)
	add c,(xsp+1)
	extz bc
	muls xbc,3
	add xwa,xbc
	ld a,(xwa+1)
	ld (xsp+10),a
	ld xwa,(_body__25+22)
	ld c,(xsp+7)
	add c,(xsp+1)
	extz bc
	muls xbc,3
	add xwa,xbc
	ld a,(xwa+2)
	extz wa
	ld (xsp+12),wa
	ld ixl,0
	jp L2598
L2595:
	ld xwa,(_body__25)
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
	jp L2602
L2599:
	ld wa,(xsp+16)
	ld bc,14
	ld de,2
	ld l,izl
	extz hl
	mul xde,hl
	sub bc,de
	cp c,0
	jr z,L2605
L2604:
	srl 1,wa
	djnz c,L2604
L2605:
	and wa,3
	cp wa,0
	jr nz,L2603
	jp L2601
L2603:
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	cp a,(xsp+2)
	jr ule,L2606
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld (xsp+2),a
	ldb (xsp+5),0
L2606:
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	cp a,(xsp+2)
	jr nz,L2607
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+5)
	jr ule,L2607
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+5),a
L2607:
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+3)
	jr ule,L2608
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+3),a
L2608:
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+4)
	jr uge,L2609
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+4),a
L2609:
L2601:
	inc 1,izl
L2602:
	ld a,izl
	cp a,8
	jp ult,L2599
L2600:
L2597:
	inc 1,ixl
L2598:
	ld a,ixl
	cp a,8
	jp ult,L2595
L2596:
L2593:
	incb 1,(xsp+1)
L2594:
	ld a,(xsp+1)
	cp a,(xsp+8)
	jp ult,L2591
L2592:
L2589:
	incb 1,(xsp+0)
L2590:
	ld a,(xsp+0)
	cp a,(_body__25+28)
	jp ult,L2587
L2588:
	ld a,(xsp+4)
	cp a,(xsp+3)
	jr ule,L2610
	ld xwa,(_body__25+18)
	ld a,(xwa)
	extz wa
	sll 2,wa
	ld (_car_wheel_dx__25),a
	jr L2586
L2610:
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
	jr ule,L2611
	ld wa,(xsp+6)
	sub wa,(xsp+8)
	srl 1,wa
	extz wa
	jr L2612
L2611:
	ld wa,0
L2612:
	ld (_car_wheel_dx__25),a
L2586:
	lda xsp,(xsp+20)
	pop xiz
	ret

; function id_car_select
_id_car_select:
	ld c,(xsp+4)
	cp c,1
	jr uge,L2617
	ld a,(xsp+4)
	extz wa
	jr L2618
L2617:
	ld a,0
	extz wa
L2618:
	ld (_car_variant__25),a
	ld xwa,_body__25
	push xwa
	ld a,(_car_variant__25)
	push xwa
	call _id_fleet_body
	lda xsp,(xsp+8)
	call _mesure_roues__25
L2616:
	ret

; function id_car_char_count
_id_car_char_count:
	ld c,(xsp+4)
	cp c,0
	jr z,L2623
	ld wa,(_body__25+4)
	jr L2624
L2623:
	ld wa,(_body__25+26)
L2624:
	srl 3,wa
	jr L2622
L2622:
	ret

; function id_car_half_width
_id_car_half_width:
	ld xwa,(_body__25+18)
	ld a,(xwa)
	extz wa
	sll 2,wa
	jr L2626
L2626:
	ret

; function id_car_wheel_dx
_id_car_wheel_dx:
	ld a,(_car_wheel_dx__25)
	jr L2628
L2628:
	ret

; function id_car_height
_id_car_height:
	ld a,(_body__25+30)
	jr L2630
L2630:
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
	ld xwa,(_body__25)
	ld (xsp+4),xwa
	ld wa,(xsp+24)
	ld (_car_tile_base__25),wa
	ld ix,0
	jr L2646
L2643:
	ld wa,40960
	extz xwa
	ld bc,(xsp+24)
	add bc,ix
	mul xbc,16
	add xwa,xbc
	ld (xsp+8),xwa
	ld iz,0
	jr L2650
L2647:
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
L2649:
	inc 1,iz
L2650:
	ld wa,iz
	cp wa,8
	jr ult,L2647
L2648:
L2645:
	inc 1,ix
L2646:
	ld wa,ix
	cp wa,(xsp+2)
	jr ult,L2643
L2644:
	push xix
	push xiy
	ld xwa,(_body__25+6)
	ld wa,(xwa+6)
	push xwa
	ld xwa,(_body__25+6)
	ld wa,(xwa+4)
	push xwa
	ld xwa,(_body__25+6)
	ld wa,(xwa+2)
	push xwa
	ld xwa,(_body__25+6)
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
	ld a,(_body__25+28)
	cp a,1
	jr ule,L2651
	push xix
	push xiy
	ld xwa,(_body__25+6)
	ld wa,(xwa+14)
	push xwa
	ld xwa,(_body__25+6)
	ld wa,(xwa+12)
	push xwa
	ld xwa,(_body__25+6)
	ld wa,(xwa+10)
	push xwa
	ld xwa,(_body__25+6)
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
	jr L2652
L2651:
	push xix
	push xiy
	ld xwa,(_body__25+6)
	ld wa,(xwa+6)
	push xwa
	ld xwa,(_body__25+6)
	ld wa,(xwa+4)
	push xwa
	ld xwa,(_body__25+6)
	ld wa,(xwa+2)
	push xwa
	ld xwa,(_body__25+6)
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
L2652:
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
L2642:
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
	ld c,(_body__25+29)
	extz bc
	mul xwa,bc
	sub wa,2
	ld (xsp+3),a
	ld a,(_body__25+29)
	cp a,2
	jr uge,L2685
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
	jp L2684
L2685:
	ld a,(xsp+50)
	extz wa
	exts xwa
	ld c,(xsp+3)
	extz bc
	divs xwa,bc
	ld wa,qwa
	ld (xsp+50),a
	ld a,(xsp+50)
	cp a,(_body__25+29)
	jr uge,L2686
	ld a,(xsp+50)
	ld (xsp+4),a
	ldb (xsp+5),0
	jr L2687
L2686:
	ld a,(xsp+3)
	sub a,(xsp+50)
	ld (xsp+4),a
	ldb (xsp+5),1
L2687:
	ld xwa,(_body__25+14)
	ld c,(xsp+4)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+9),a
	ld xwa,(_body__25+10)
	ld c,(xsp+4)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+10),a
	ld xwa,(_body__25+18)
	ld c,(xsp+4)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+11),a
	ldb (xsp+6),255
	ldb (xsp+7),0
	ld izl,0
	jr L2691
L2688:
	ld xwa,(_body__25+22)
	ld c,(xsp+9)
	add c,izl
	extz bc
	muls xbc,3
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+12),a
	ld c,(xsp+5)
	cp c,0
	jr z,L2692
	ld a,(xsp+11)
	sub a,1
	sub a,(xsp+12)
	extz wa
	jr L2693
L2692:
	ld a,(xsp+12)
	extz wa
L2693:
	ld (xsp+13),a
	ld a,(xsp+13)
	cp a,(xsp+6)
	jr uge,L2694
	ld a,(xsp+13)
	ld (xsp+6),a
L2694:
	ld a,(xsp+13)
	cp a,(xsp+7)
	jr ule,L2695
	ld a,(xsp+13)
	ld (xsp+7),a
L2695:
L2690:
	inc 1,izl
L2691:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L2688
L2689:
	ld a,(xsp+6)
	cp a,(xsp+7)
	jr ule,L2696
	ldb (xsp+6),0
	ldb (xsp+7),0
L2696:
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
	jp L2700
L2697:
	ld a,(_body__25+28)
	sub a,1
	sub a,(xsp+1)
	ld (xsp+9),a
	ld xwa,(_body__25+14)
	ld c,(xsp+9)
	extz bc
	ld e,(_body__25+29)
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
	ld xwa,(_body__25+10)
	ld c,(xsp+9)
	extz bc
	ld e,(_body__25+29)
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
	ld xwa,(_body__25+18)
	ld c,(xsp+9)
	extz bc
	ld e,(_body__25+29)
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
	jr nz,L2701
	ld wa,0
	jr L2702
L2701:
	ld wa,5
L2702:
	ld (xsp+13),a
	ld izl,0
	jp L2706
L2703:
	ld xwa,(_body__25+22)
	ld c,(xsp+10)
	add c,izl
	extz bc
	muls xbc,3
	add xwa,xbc
	lda xwa,(xwa)
	ld xiy,xwa
	ld c,(xsp+5)
	cp c,0
	jr z,L2707
	ld a,(xsp+12)
	sub a,1
	sub a,(xiy)
	extz wa
	jr L2708
L2707:
	ld a,(xiy)
	extz wa
L2708:
	ld (xsp+18),a
L2709:
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
	ld wa,(_car_tile_base__25)
	ld c,(xiy+2)
	extz bc
	add wa,bc
	ld (xsp+22),wa
	ld a,(xsp+13)
	ld (xsp+24),a
	ld c,(xsp+5)
	cp c,0
	jr z,L2712
	ld wa,128
	jr L2713
L2712:
	ld wa,0
L2713:
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
L2711:
L2710:
	incb 1,(xsp+2)
L2705:
	inc 1,izl
L2706:
	ld a,izl
	cp a,(xsp+11)
	jr uge,L2714
	ld a,(xsp+2)
	cp a,64
	jp ult,L2703
L2714:
L2704:
L2699:
	incb 1,(xsp+1)
L2700:
	ld a,(xsp+1)
	cp a,(_body__25+28)
	jp ult,L2697
L2698:
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
L2684:
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
	jp L2734
L2731:
	ld a,(_body__25+28)
	sub a,1
	sub a,(xsp+1)
	ld (xsp+3),a
	ld xwa,(_body__25+14)
	ld c,(xsp+3)
	extz bc
	ld e,(_body__25+29)
	extz de
	mul xbc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+4),a
	ld xwa,(_body__25+10)
	ld c,(xsp+3)
	extz bc
	ld e,(_body__25+29)
	extz de
	mul xbc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+5),a
	ld c,(xsp+3)
	cp c,0
	jr nz,L2735
	ld wa,0
	jr L2736
L2735:
	ld wa,5
L2736:
	ld (xsp+6),a
	ldb (xsp+0),0
	jp L2740
L2737:
	ld xwa,(_body__25+22)
	ld c,(xsp+4)
	add c,(xsp+0)
	extz bc
	muls xbc,3
	add xwa,xbc
	lda xwa,(xwa)
	ld xiy,xwa
L2741:
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
	ld wa,(_car_tile_base__25)
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
L2743:
L2742:
	incb 1,(xsp+2)
L2739:
	incb 1,(xsp+0)
L2740:
	ld a,(xsp+0)
	cp a,(xsp+5)
	jr uge,L2744
	ld a,(xsp+2)
	cp a,64
	jp ult,L2737
L2744:
L2738:
L2733:
	incb 1,(xsp+1)
L2734:
	ld a,(xsp+1)
	cp a,(_body__25+28)
	jp ult,L2731
L2732:
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
L2730:
	lda xsp,(xsp+24)
	pop xiz
	ret

; function car_layer
_car_layer__25:
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
	ld wa,(_car_tile_base__25)
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
	jr z,L2749
	ld wa,128
	jr L2750
L2749:
	ld wa,0
L2750:
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
L2748:
	lda xsp,(xsp+22)
	ret

; function lean_last
_lean_last__25:
	push xiz
	lda xsp,(xsp-2)
	ld c,(_body__25+29)
	cp c,0
	jr ule,L2756
	ld a,(_body__25+29)
	extz wa
	sub wa,1
	jr L2757
L2756:
	ld wa,0
L2757:
	ld izl,a
	ld a,izl
	cp a,2
	jr ule,L2758
	ld izl,2
L2758:
	ld a,izl
	jr L2755
L2755:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function lean_pose
_lean_pose__25:
	push xiz
	lda xsp,(xsp-2)
	call _lean_last__25
	ld (xsp+0),a
	ld a,(_lean_hold__25)
	cp a,0
	jr nz,L2768
	ld wa,0
	jr L2767
L2768:
	ld c,(_lean_hold__25)
	cp c,12
	jr ult,L2769
	ld wa,3
	jr L2770
L2769:
	ld c,(_lean_hold__25)
	cp c,5
	jr ult,L2771
	ld wa,2
	jr L2772
L2771:
	ld wa,1
L2772:
L2770:
	ld izl,a
	ld c,izl
	cp c,(xsp+0)
	jr ule,L2773
	ld a,(xsp+0)
	extz wa
	jr L2774
L2773:
	ld a,izl
	extz wa
L2774:
	jr L2767
L2767:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_car_lean_share
_id_car_lean_share:
	push xiz
	lda xsp,(xsp-4)
	call _lean_last__25
	ld (xsp+0),a
	call _lean_pose__25
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,0
	jr z,L2783
	ld a,(xsp+0)
	cp a,0
	jr nz,L2782
L2783:
	ld wa,0
	jr L2781
L2782:
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
	jr le,L2784
	ld iz,16
L2784:
	ld c,(_lean_side__25)
	cp c,0
	jr ge,L2785
	ld wa,iz
	neg wa
	jr L2786
L2785:
	ld wa,iz
L2786:
	jr L2781
L2781:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function id_car_last_x
_id_car_last_x:
	ld wa,(_car_last_x__25)
	jr L2788
L2788:
	ret

; function id_car_last_top
_id_car_last_top:
	ld a,(_car_last_top__25)
	jr L2790
L2790:
	ret

; function id_car_draw
_id_car_draw:
	push xiz
	lda xsp,(xsp-8)
	ld a,(xsp+20)
	cp a,0
	jr z,L2819
	ld a,(_lean_side__25)
	cp a,(xsp+20)
	jr z,L2820
	ld a,(xsp+20)
	ld (_lean_side__25),a
	ldb (_lean_hold__25),0
L2820:
	ld a,(_lean_hold__25)
	cp a,255
	jr uge,L2821
	incb 1,(_lean_hold__25)
L2821:
	ldb (_lean_wait__25),2
	jr L2822
L2819:
	ld a,(_lean_hold__25)
	cp a,0
	jr z,L2823
	ld a,(_lean_wait__25)
	cp a,0
	jr z,L2824
	decb 1,(_lean_wait__25)
	jr L2825
L2824:
	ldb (_lean_wait__25),2
	ld a,(_lean_hold__25)
	cp a,12
	jr ult,L2826
	ldb (_lean_hold__25),11
	jr L2827
L2826:
	ld a,(_lean_hold__25)
	cp a,5
	jr ult,L2828
	ldb (_lean_hold__25),4
	jr L2829
L2828:
	ldb (_lean_hold__25),0
L2829:
L2827:
L2825:
L2823:
L2822:
	ld a,(xsp+24)
	cp a,0
	jr nz,L2830
	ldb (_bump_phase__25),0
	ldb (xsp+2),0
	jr L2831
L2830:
	incb 1,(_bump_phase__25)
	ld c,(_bump_phase__25)
	extz bc
	and bc,2
	cp bc,0
	jr z,L2832
	ld a,(xsp+24)
	extz wa
	jr L2833
L2832:
	ld wa,0
L2833:
	ld (xsp+2),a
L2831:
	ld a,148
	ld c,(_body__25+30)
	sub a,c
	add a,(_body__25+30)
	sub a,1
	ld (xsp+4),a
	ld a,148
	ld c,(_body__25+30)
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
	jr ge,L2834
	ld wa,0
	jr L2835
L2834:
	ld wa,(xsp+6)
L2835:
	ld (xsp+3),a
	ld a,(xsp+4)
	push xwa
	call _id_road_centre_at
	lda xsp,(xsp+4)
	ld xbc,(_body__25+18)
	ld c,(xbc)
	extz bc
	sll 2,bc
	sub wa,bc
	add wa,(xsp+16)
	ld (_car_last_x__25),wa
	ld a,(xsp+3)
	sub a,(xsp+2)
	ld (_car_last_top__25),a
	ld a,(_body__25+28)
	cp a,1
	jp ule,L2836
	call _lean_pose__25
	ld (xsp+0),a
	ldb (xsp+1),0
	ld c,(xsp+0)
	cp c,0
	jr nz,L2837
	ld wa,0
	jr L2838
L2837:
	ld c,(_lean_side__25)
	cp c,0
	jr ge,L2839
	ld wa,2
	jr L2840
L2839:
	ld wa,1
L2840:
L2838:
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
	ld xwa,(_body__25+18)
	ld c,(_body__25+29)
	extz bc
	ld e,izl
	extz de
	add bc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__25+10)
	ld c,(_body__25+29)
	extz bc
	ld e,izl
	extz de
	add bc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__25+14)
	ld c,(_body__25+29)
	extz bc
	ld e,izl
	extz de
	add bc,de
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__25+22)
	push xwa
	call _car_layer__25
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
	ld xwa,(_body__25+18)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__25+10)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__25+14)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__25+22)
	push xwa
	call _car_layer__25
	lda xsp,(xsp+48)
	jp L2818
L2836:
	ld c,(_lean_hold__25)
	cp c,0
	jr nz,L2841
	ld wa,0
	jr L2842
L2841:
	ld wa,1
L2842:
	ld (xsp+0),a
	ld c,(_lean_side__25)
	cp c,0
	jr le,L2843
	ld wa,1
	jr L2844
L2843:
	ld wa,0
L2844:
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
	ld xwa,(_body__25+18)
	ld c,(xsp+32)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__25+10)
	ld c,(xsp+36)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__25+14)
	ld c,(xsp+40)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	push xwa
	ld xwa,(_body__25+22)
	push xwa
	call _car_layer__25
	lda xsp,(xsp+48)
	ld a,24
	push xwa
	ld a,12
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L2818:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function course_art
_course_art__26:
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
L2846:
	pop xiz
	ret

; function uses_akina
_uses_akina__26:
	ld wa,0
	jr L2848
L2848:
	ret

; function id_road_horizon
_id_road_horizon:
	ld xwa,_course_horizon__26
	ld c,(_road_course__26)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	jr L2850
L2850:
	ret

; function sky_is_tall_course
_sky_is_tall_course__26:
	ld wa,0
	jr L2852
L2852:
	ret

; function road_is_tarmac
_road_is_tarmac__26:
	ld wa,1
	jr L2854
L2854:
	ret

; function id_build_weights
_id_build_weights__26:
	push xiz
	lda xsp,(xsp-14)
	ld a,(_road_lines__26)
	extz wa
	sub wa,1
	ld (xsp+2),wa
	ld a,(_road_lines__26)
	extz wa
	ld c,(_road_lines__26)
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
	ld (_id_curve_cm__26),wa
	ld izl,0
	jp L2889
L2886:
	push xix
	push xiy
	call _uses_akina__26
	pop xiy
	pop xix
	cp a,0
	jp nz,L2890
	ld a,(_art__26+22)
	extz wa
	srl 3,wa
	extz wa
	add wa,1
	sll 3,wa
	sub wa,1
	ld c,(_art__26+21)
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
	jr ule,L2891
	ld wa,(xsp+6)
	ld (xsp+8),wa
L2891:
	ld a,(xsp+8)
	ld xbc,_id_src__26
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(_art__26+16)
	ld bc,(xsp+8)
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld xbc,_id_half__26
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
	jr L2892
L2890:
	ld a,izl
	ld xbc,_id_src__26
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(_art__26+16)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld xbc,_id_half__26
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
L2892:
	ld wa,255
	sub wa,iy
	ld (xsp+6),wa
	ld a,(_road_top__26)
	add a,izl
	ld xbc,_id_sl__26
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,iyl
	ld xbc,_id_w_lat__26
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+6)
	mul xwa,(xsp+6)
	srl 8,wa
	ld xbc,_id_w_curve__26
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,iy
	cp wa,0
	jr nz,L2893
	ld wa,1600
	ld xbc,_id_ahead__26
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jr L2894
L2893:
	ld wa,60
	mul xwa,(xsp+6)
	extz xwa
	div xwa,iy
	ld (xsp+8),wa
	ld bc,(xsp+8)
	cp bc,1600
	jr ule,L2895
	ld wa,1600
	jr L2896
L2895:
	ld wa,(xsp+8)
L2896:
	ld xbc,_id_ahead__26
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2894:
	ld a,izl
	extz wa
	mul xwa,47
	extz xwa
	ld c,(_road_lines__26)
	extz bc
	sub bc,1
	div xwa,bc
	ld (xsp+8),wa
	ld wa,47
	ld xbc,_id_ahead__26
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
	jr ule,L2897
	ld wa,47
	jr L2898
L2897:
	ld wa,(xsp+12)
L2898:
	ld xbc,_id_sl__26+128
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2888:
	inc 1,izl
L2889:
	ld a,izl
	cp a,(_road_lines__26)
	jp ult,L2886
L2887:
	ld a,(_road_lines__26)
	sub a,1
	ld (_wide_k0__26),a
	jr L2901
L2899:
	decb 1,(_wide_k0__26)
L2901:
	ld a,(_wide_k0__26)
	cp a,0
	jr ule,L2902
	ld xwa,_id_src__26
	ld c,(_wide_k0__26)
	sub c,1
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,48
	jr uge,L2899
L2902:
L2900:
	ld a,(_road_top__26)
	sub a,8
	ld (_climb_room__26),a
	push xix
	push xiy
	call _uses_akina__26
	pop xiy
	pop xix
	cp a,0
	jr z,L2903
	ld a,(_road_lines__26)
	extz wa
	extz xwa
	div xwa,10
	ld (_descent_room__26),a
	jr L2904
L2903:
	ld a,(_road_lines__26)
	extz wa
	srl 1,wa
	ld (_descent_room__26),a
L2904:
	ldb (_grade_hi__26),0
	ldb (_grade_lo__26),0
	ld ix,1
	jr L2908
L2905:
	ld a,(_road_lines__26)
	extz wa
	ld xbc,_hill_rate__26
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
	ld c,(_road_lines__26)
	extz bc
	ld e,(_climb_room__26)
	extz de
	add bc,de
	cp wa,bc
	jr ugt,L2909
	ld a,ixl
	ld (_grade_hi__26),a
L2909:
L2907:
	inc 1,ix
L2908:
	ld wa,ix
	cp wa,20
	jr le,L2905
L2906:
	ld ix,1
	jr L2913
L2910:
	ld a,(_road_lines__26)
	extz wa
	ld xbc,_hill_rate__26
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
	ld c,(_descent_room__26)
	extz bc
	add wa,bc
	ld c,(_road_lines__26)
	extz bc
	cp wa,bc
	jr ult,L2914
	ld a,ixl
	neg a
	ld (_grade_lo__26),a
L2914:
L2912:
	inc 1,ix
L2913:
	ld wa,ix
	cp wa,20
	jr le,L2910
L2911:
L2885:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function rally_scan
_rally_scan__26:
	push xiz
	lda xsp,(xsp-6)
	ld a,(_rally_scanned__26)
	cp a,0
	jr z,L2933
	jp L2932
L2933:
	ldw (xsp+0),0
	jr L2937
L2934:
	ld a,255
	ld xbc,_rally_of__26
	ld de,(xsp+0)
	extz xde
	add xbc,xde
	ld (xbc),a
L2936:
	incw 1,(xsp+0)
L2937:
	ld wa,(xsp+0)
	cp wa,512
	jr ult,L2934
L2935:
	ldb (_rally_used__26),0
	ld a,(_art__26+21)
	extz wa
	srl 3,wa
	ld iyl,a
	jp L2941
L2938:
	ld ixl,0
	jr L2945
L2942:
	ld xwa,(_art__26+4)
	ld c,iyl
	extz bc
	ld e,(_art__26+20)
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
	jr uge,L2947
	ld xwa,_rally_of__26
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,255
	jr z,L2946
L2947:
	jr L2944
L2946:
	ld a,(_rally_used__26)
	cp a,255
	jr ult,L2948
	jr L2944
L2948:
	ld a,(_rally_used__26)
	ld xbc,_rally_of__26
	ld de,iz
	extz xde
	add xbc,xde
	ld (xbc),a
	ld wa,iz
	ld xbc,_rally_src__26
	ld e,(_rally_used__26)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	incb 1,(_rally_used__26)
L2944:
	inc 1,ixl
L2945:
	ld a,ixl
	cp a,(_art__26+20)
	jp ult,L2942
L2943:
L2940:
	inc 1,iyl
L2941:
	ld a,iyl
	cp a,29
	jp ult,L2938
L2939:
	ldb (_rally_scanned__26),1
L2932:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function id_road_char_count
_id_road_char_count:
	call _rally_scan__26
	ld a,(_rally_used__26)
	extz wa
	jr L2950
L2950:
	ret

; function id_load_chars
_id_load_chars__26:
	push xiz
	lda xsp,(xsp-18)
	push xix
	push xiy
	call _id_road_char_count
	pop xiy
	pop xix
	ld (xsp+2),wa
	ld xwa,(_art__26)
	ld (xsp+4),xwa
	ld ix,0
	jp L2966
L2963:
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
	call _uses_akina__26
	ld xbc,xwa
	pop xiy
	pop xix
	pop xwa
	cp c,0
	jr nz,L2967
	ld xwa,_rally_src__26
	ld bc,ix
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L2968
L2967:
	ld wa,ix
L2968:
	ld (xsp+12),wa
	ld iz,0
	jr L2972
L2969:
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
L2971:
	inc 1,iz
L2972:
	ld wa,iz
	cp wa,8
	jr ult,L2969
L2970:
L2965:
	inc 1,ix
L2966:
	ld wa,ix
	cp wa,(xsp+2)
	jp ult,L2963
L2964:
L2962:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_load_palettes
_id_load_palettes__26:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L2982
L2979:
	ld xwa,(_art__26+12)
	ld c,izl
	extz bc
	sll 2,bc
	add bc,3
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,(_art__26+12)
	ld c,izl
	extz bc
	sll 2,bc
	add bc,2
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,(_art__26+12)
	ld c,izl
	extz bc
	sll 2,bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	ld xwa,(_art__26+12)
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
L2981:
	inc 1,izl
L2982:
	ld a,izl
	cp a,8
	jp ult,L2979
L2980:
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
	ld xwa,(_art__26+12)
	ld wa,(xwa)
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
L2978:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_reload_backdrop
_id_road_reload_backdrop:
	ld xwa,(_art__26+12)
	ld wa,(xwa)
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
L2984:
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
	jr L2994
L2991:
	ld xwa,xix
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_band_col__26
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2993:
	inc 1,izl
L2994:
	ld a,izl
	cp a,4
	jr ult,L2991
L2992:
	ldw (_bc_rest__26),65535
	ldw (_bc_rest__26+2),65535
L2990:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_load_maps_rally
_id_load_maps_rally__26:
	push xiz
	lda xsp,(xsp-12)
	ld a,(_road_plane0__26)
	extz wa
	srl 3,wa
	exts wa
	ld c,(_art__26+21)
	extz bc
	srl 3,bc
	exts bc
	sub wa,bc
	ld (xsp+2),a
	push xix
	push xiy
	call _rally_scan__26
	pop xiy
	pop xix
	ld a,(_road_plane0__26)
	extz wa
	srl 3,wa
	ld iyl,a
	jp L3016
L3013:
	ld a,iyl
	ld c,(xsp+2)
	sub a,c
	ld (xsp+3),a
	ld a,(xsp+3)
	cp a,28
	jr ule,L3017
	ldb (xsp+3),28
L3017:
	ld izl,0
	jp L3021
L3018:
	ld wa,0
	ld (xsp+4),a
	ld a,(xsp+3)
	ld (xsp+5),a
	ld a,izl
	cp a,0
	jr uge,L3022
	ld a,(_art__26+21)
	extz wa
	srl 3,wa
	ld (xsp+5),a
	jr L3023
L3022:
	ld a,izl
	ld c,0
	add c,(_art__26+20)
	cp a,c
	jr ult,L3024
	ld a,(_art__26+20)
	sub a,1
	ld (xsp+4),a
	ld a,(_art__26+21)
	extz wa
	srl 3,wa
	ld (xsp+5),a
	jr L3025
L3024:
	ld a,izl
	sub a,0
	ld (xsp+4),a
L3025:
L3023:
	ld a,(xsp+5)
	extz wa
	ld c,(_art__26+20)
	extz bc
	mul xwa,bc
	ld c,(xsp+4)
	extz bc
	add wa,bc
	ld (xsp+6),wa
	ld xwa,(_art__26+4)
	ld bc,(xsp+6)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+8),wa
	ld bc,(xsp+8)
	cp bc,512
	jr uge,L3026
	ld xwa,_rally_of__26
	ld bc,(xsp+8)
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L3027
L3026:
	ld wa,255
L3027:
	ld ixl,a
	ld a,ixl
	cp a,255
	jr nz,L3028
	ld ixl,0
L3028:
	ld wa,128
	ld c,ixl
	extz bc
	add wa,bc
	ld xbc,(_art__26+8)
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
L3020:
	inc 1,izl
L3021:
	ld a,izl
	cp a,32
	jp ult,L3018
L3019:
L3015:
	inc 1,iyl
L3016:
	ld a,iyl
	cp a,32
	jp ult,L3013
L3014:
L3012:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function id_load_maps
_id_load_maps__26:
	call _id_load_maps_rally__26
L3030:
	ret

; function id_build_shear_limits
_id_build_shear_limits__26:
	push xiz
	lda xsp,(xsp-18)
	push xix
	push xiy
	call _uses_akina__26
	pop xiy
	pop xix
	cp a,0
	jp nz,L3062
	ld izl,0
	jr L3066
L3063:
	ld xwa,_id_src__26
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
	jr uge,L3067
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
	jr ge,L3068
	ld wa,(xsp+4)
	ld (xsp+2),wa
L3068:
L3067:
	ld wa,(xsp+2)
	neg wa
	ld xbc,_id_dxc__26
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+2)
	ld xbc,_id_dxc__26+128
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3065:
	inc 1,izl
L3066:
	ld a,izl
	cp a,(_road_lines__26)
	jp ult,L3063
L3064:
	jp L3061
L3062:
	ld izl,0
	jp L3072
L3069:
	ld a,(_road_top__26)
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
	jr L3076
L3073:
	ld wa,0
	ld (xsp+10),wa
	ld wa,0
	ld (xsp+12),wa
	ld wa,(xsp+12)
	cp wa,0
	jr nz,L3077
	jr L3075
L3077:
	ld ixl,0
	jr L3081
L3078:
	ld wa,(xsp+12)
	ld bc,14
	ld de,2
	ld l,ixl
	extz hl
	mul xde,hl
	sub bc,de
	cp c,0
	jr z,L3084
L3083:
	srl 1,wa
	djnz c,L3083
L3084:
	and wa,3
	cp wa,0
	jr z,L3082
	ld a,(xsp+4)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld iy,wa
	ld wa,iy
	cp wa,(xsp+6)
	jr uge,L3085
	ld wa,iy
	ld (xsp+6),wa
L3085:
	ld wa,iy
	cp wa,(xsp+8)
	jr ule,L3086
	ld wa,iy
	ld (xsp+8),wa
L3086:
L3082:
L3080:
	inc 1,ixl
L3081:
	ld a,ixl
	cp a,8
	jr ult,L3078
L3079:
L3075:
	incb 1,(xsp+4)
L3076:
	ld a,(xsp+4)
	cp a,32
	jr ult,L3073
L3074:
	ld wa,(xsp+6)
	cp wa,(xsp+8)
	jr ule,L3087
	ld wa,65409
	ld xbc,_id_dxc__26
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,127
	ld xbc,_id_dxc__26+128
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jr L3088
L3087:
	ld wa,(xsp+8)
	sub wa,255
	sub wa,7
	ld xbc,_id_dxc__26
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+6)
	add wa,97
	sub wa,7
	ld xbc,_id_dxc__26+128
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3088:
	ld xwa,_id_dxc__26+128
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,88
	jr le,L3089
	ld wa,88
	ld xbc,_id_dxc__26+128
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3089:
	ld xwa,_id_dxc__26
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65448
	jr ge,L3090
	ld wa,65448
	ld xbc,_id_dxc__26
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3090:
L3071:
	inc 1,izl
L3072:
	ld a,izl
	cp a,(_road_lines__26)
	jp ult,L3069
L3070:
L3061:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_road_course
_id_road_course:
	ld a,(_road_course__26)
	jr L3092
L3092:
	ret

; function id_road_top
_id_road_top:
	ld a,(_road_top__26)
	jr L3094
L3094:
	ret

; function id_road_bottom
_id_road_bottom:
	ld a,(_road_bottom__26)
	jr L3096
L3096:
	ret

; function id_road_select
_id_road_select:
	push xiz
	lda xsp,(xsp-14)
	ld c,(xsp+22)
	cp c,1
	jr uge,L3136
	ld a,(xsp+22)
	extz wa
	jr L3137
L3136:
	ld wa,0
L3137:
	ld (_road_course__26),a
	push xix
	ld wa,0
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
	pop xix
	push xix
	call _uses_akina__26
	pop xix
	cp a,0
	jr nz,L3138
	push xix
	ld xwa,_art__26
	push xwa
	ld a,(_road_course__26)
	push xwa
	call _course_art__26
	lda xsp,(xsp+8)
	pop xix
	ldb (_rally_scanned__26),0
L3138:
	push xix
	call _uses_akina__26
	pop xix
	cp a,0
	jr nz,L3139
	ldb (_road_base_x__26),48
	ldb (_road_top__26),88
	push xwa
	push xix
	call _sky_is_tall_course__26
	ld xbc,xwa
	pop xix
	pop xwa
	cp c,0
	jr z,L3140
	ld a,88
	extz wa
	jr L3141
L3140:
	ld a,88
	extz wa
L3141:
	ld (_road_plane0__26),a
	ldb (_road_lines__26),64
	jr L3142
L3139:
	ldb (_road_base_x__26),7
	ldb (_road_top__26),72
	ldb (_road_plane0__26),72
	ldb (_road_lines__26),40
L3142:
	ld a,(_road_top__26)
	add a,(_road_lines__26)
	sub a,1
	ld (_road_bottom__26),a
	ld a,(_road_lines__26)
	extz wa
	extz xwa
	div xwa,6
	ld (_car_stand__26),a
	ld a,(_car_stand__26)
	cp a,(_road_lines__26)
	jr ult,L3143
	ld a,(_road_lines__26)
	sub a,1
	ld (_car_stand__26),a
L3143:
	push xix
	call _id_load_chars__26
	pop xix
	push xix
	call _id_load_palettes__26
	pop xix
	push xix
	call _uses_akina__26
	pop xix
	cp a,0
	jr nz,L3144
	push xix
	call _id_load_maps_rally__26
	pop xix
	jr L3145
L3144:
	push xix
	call _id_load_maps__26
	pop xix
L3145:
	ldb (xsp+0),0
	jr L3149
L3146:
	ld wa,0
	ld xbc,_id_shear__26
	ld e,(xsp+0)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3148:
	incb 1,(xsp+0)
L3149:
	ld a,(xsp+0)
	cp a,(_road_lines__26)
	jr ult,L3146
L3147:
	ldw (_band_top__26),65535
	ldw (_band_top__26+2),65535
	ldw (_band_mid__26),65535
	ldw (_band_mid__26+2),65535
	ldw (_band_tree__26),65535
	ldw (_band_tree__26+2),65535
	ldb (_band_bg_first__26),255
	ldb (_band_bg_first__26+1),255
	push xwa
	push xix
	call _uses_akina__26
	ld xbc,xwa
	pop xix
	pop xwa
	cp c,0
	jr z,L3150
	ld wa,3
	jr L3151
L3150:
	ld wa,0
L3151:
	ld (_road_band_pal__26),a
	ld xwa,33536
	ld c,(_road_band_pal__26)
	extz bc
	sll 2,bc
	add bc,2
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+2),wa
	ld izl,0
	jp L3155
L3152:
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
	jr ule,L3156
	ld wa,(xsp+8)
	sub wa,ix
	jr L3157
L3156:
	ld wa,0
L3157:
	ld (xsp+8),wa
	ld bc,(xsp+10)
	cp bc,ix
	jr ule,L3158
	ld wa,(xsp+10)
	sub wa,ix
	jr L3159
L3158:
	ld wa,0
L3159:
	ld (xsp+10),wa
	ld bc,(xsp+12)
	cp bc,ix
	jr ule,L3160
	ld wa,(xsp+12)
	sub wa,ix
	jr L3161
L3160:
	ld wa,0
L3161:
	ld (xsp+12),wa
	ld wa,(xsp+8)
	sll 8,wa
	ld bc,(xsp+10)
	sll 4,bc
	or wa,bc
	or wa,(xsp+12)
	ld xbc,_band_col__26
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3154:
	inc 1,izl
L3155:
	ld a,izl
	cp a,4
	jp ult,L3152
L3153:
	push xix
	call _road_is_tarmac__26
	pop xix
	cp a,0
	jr z,L3162
	ld izl,0
	jr L3166
L3163:
	ld xwa,_course_sol__26
	ld c,(_road_course__26)
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
	ld xbc,_band_col__26
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3165:
	inc 1,izl
L3166:
	ld a,izl
	cp a,4
	jr ult,L3163
L3164:
	jr L3167
L3162:
	push xix
	call _uses_akina__26
	pop xix
	cp a,0
	jr nz,L3168
	ld izl,0
	jr L3172
L3169:
	ld wa,(xsp+2)
	ld xbc,_band_col__26
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3171:
	inc 1,izl
L3172:
	ld a,izl
	cp a,4
	jr ult,L3169
L3170:
L3168:
L3167:
	push xix
	call _id_build_weights__26
	pop xix
	push xix
	call _id_build_shear_limits__26
	pop xix
	push xix
	call _id_fill_hud_band__26
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
L3135:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function id_road_dma_pause
_id_road_dma_pause:
	ld a,(_road_dma_depth__26)
	cp a,255
	jr uge,L3177
	incb 1,(_road_dma_depth__26)
L3177:
	ld a,(_road_dma_live__26)
	cp a,0
	jr z,L3178
	ld xwa,0
	push xwa
	call _ngpc_set_vblank_hook
	lda xsp,(xsp+4)
	ld xwa,_id_raster__26
	push xwa
	call _ngpc_dma_raster_xy_disable
	lda xsp,(xsp+4)
	ld xwa,_id_bandstream__26
	push xwa
	call _ngpc_dma_stream_end_u16
	lda xsp,(xsp+4)
	ldb (_road_dma_live__26),0
L3178:
L3176:
	ret

; function id_road_dma_resume
_id_road_dma_resume:
	ld a,(_road_dma_depth__26)
	cp a,0
	jr z,L3185
	decb 1,(_road_dma_depth__26)
L3185:
	ld a,(_road_dma_depth__26)
	cp a,0
	jr z,L3186
	jp L3184
L3186:
	ld a,(_road_dma_live__26)
	cp a,0
	jp nz,L3187
	ld xwa,(_id_xy_live__26)
	push xwa
	ld wa,1
	push xwa
	ld xwa,_id_raster__26
	push xwa
	call _ngpc_dma_raster_xy_begin
	lda xsp,(xsp+12)
	ld xwa,_id_raster__26
	push xwa
	call _ngpc_dma_raster_xy_enable
	lda xsp,(xsp+4)
	call _uses_akina__26
	cp a,0
	jr nz,L3188
	call _road_is_tarmac__26
	cp a,0
	jr nz,L3188
	ldw (_id_bandstream__26+10),0
	ldb (_road_dma_live__26),1
	ld xwa,_id_road_rearm
	push xwa
	call _ngpc_set_vblank_hook
	lda xsp,(xsp+4)
	jr L3184
L3188:
	call _ngpc_dma_timer01_hblank_enable
	ld wa,17
	push xwa
	ld wa,152
	push xwa
	ld xwa,(_id_bandcol__26)
	push xwa
	ld xwa,33536
	ld c,(_road_band_pal__26)
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
	ld xwa,_id_bandstream__26
	push xwa
	call _ngpc_dma_stream_begin_u16
	lda xsp,(xsp+24)
	ld xwa,_id_bandstream__26
	push xwa
	call _ngpc_dma_stream_rearm_u16
	lda xsp,(xsp+4)
	ldb (_road_dma_live__26),1
	ld xwa,_id_road_rearm
	push xwa
	call _ngpc_set_vblank_hook
	lda xsp,(xsp+4)
L3187:
L3184:
	ret

; function id_road_init
_id_road_init:
	ld wa,0
	push xwa
	call _id_road_select
	lda xsp,(xsp+4)
	call _ngpc_dma_init
	call _id_road_dma_resume
L3190:
	ret

; function id_road_flat
_id_road_flat:
	push xiz
	lda xsp,(xsp-2)
	ld iz,0
	jr L3200
L3197:
	ld wa,0
	ld xbc,_id_xy_a__26
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,0
	ld xbc,_id_xy_b__26
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(_band_col__26+6)
	ld xbc,_id_bandcol_a__26
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(_band_col__26+6)
	ld xbc,_id_bandcol_b__26
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3199:
	inc 1,iz
L3200:
	ld wa,iz
	cp wa,152
	jr ult,L3197
L3198:
	ldw (_bc_rest__26),65535
	ldw (_bc_rest__26+2),65535
	ld wa,0
	exts xwa
	ld (_id_xy_done__26),xwa
	ld wa,0
	exts xwa
	ld (_id_bandcol_done__26),xwa
	ldw (_band_top__26),65535
	ldw (_band_top__26+2),65535
	ldw (_band_mid__26),65535
	ldw (_band_mid__26+2),65535
	ldw (_band_tree__26),65535
	ldw (_band_tree__26+2),65535
	ldb (08034h),0
	ldb (08035h),0
L3196:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_rearm
_id_road_rearm:
	ld xwa,(_id_xy_done__26)
	cp xwa,0
	jr z,L3205
	ld xwa,(_id_xy_done__26)
	ld (_id_xy_live__26),xwa
	ld xwa,(_id_xy_done__26)
	ld (_id_raster__26+2),xwa
	ld xwa,(_id_xy_done__26)
	ld (_id_raster__26+6+6),xwa
	ld xwa,(_id_bandcol_done__26)
	ld (_id_bandstream__26+6),xwa
	ld wa,0
	exts xwa
	ld (_id_xy_done__26),xwa
	ld wa,0
	exts xwa
	ld (_id_bandcol_done__26),xwa
L3205:
	ld xwa,_id_raster__26
	push xwa
	call _ngpc_dma_raster_xy_rearm
	lda xsp,(xsp+4)
	ld wa,(_id_bandstream__26+10)
	cp wa,0
	jr z,L3206
	ld xwa,_id_bandstream__26
	push xwa
	call _ngpc_dma_stream_rearm_u16
	lda xsp,(xsp+4)
L3206:
L3204:
	ret

; function id_road_dma_state
_id_road_dma_state:
	ld a,(_id_raster__26+1)
	extz wa
	ld xde,(_id_raster__26+2)
	cp xde,0
	jr z,L3211
	ld bc,2
	jr L3212
L3211:
	ld bc,0
L3212:
	or wa,bc
	jr L3210
L3210:
	ret

; function id_road_xy_at
_id_road_xy_at:
	ld xwa,(_id_xy__26)
	ld c,(xsp+4)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L3214
L3214:
	ret

; function id_road_restore_map
_id_road_restore_map:
	call _uses_akina__26
	cp a,0
	jr nz,L3219
	call _id_load_maps_rally__26
	jr L3220
L3219:
	call _id_load_maps__26
L3220:
L3218:
	ret

; function id_road_reload
_id_road_reload:
	call _id_fill_hud_band__26
	ld wa,0
	push xwa
	call _ngpc_gfx_set_bg_color
	lda xsp,(xsp+4)
	call _id_load_palettes__26
	call _uses_akina__26
	cp a,0
	jr nz,L3225
	call _id_load_maps_rally__26
	jr L3226
L3225:
	call _id_load_maps__26
L3226:
L3224:
	ret

; function wide_rows
_wide_rows__26:
	push xiz
	lda xsp,(xsp-12)
	ld a,(_road_bottom__26)
	ld ixl,a
L3246:
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
	jr ult,L3251
	ld a,(xsp+6)
	cp a,88
	jr ult,L3250
L3251:
	jp L3247
L3250:
	ld a,(xsp+5)
	sub a,(xsp+24)
	ld izl,a
	ld wa,(xsp+36)
	cp wa,0
	jr lt,L3252
	ld c,izl
	cp c,144
	jr ult,L3253
	ld a,izl
	extz wa
	sub wa,256
	jr L3254
L3253:
	ld a,izl
	extz wa
L3254:
	ld iy,wa
	jr L3255
L3252:
	ld c,izl
	cp c,112
	jr ule,L3256
	ld a,izl
	extz wa
	sub wa,256
	jr L3257
L3256:
	ld a,izl
	extz wa
L3257:
	ld iy,wa
L3255:
	ld xwa,_id_route_lim0
	ld c,(xsp+6)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+10),a
	ld wa,iy
	cp wa,0
	jr lt,L3258
	ld wa,iy
	ld c,(xsp+10)
	extz bc
	cp wa,bc
	jr ult,L3259
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
L3259:
	jr L3260
L3258:
	ld wa,iy
	neg wa
	ld c,(xsp+10)
	extz bc
	cp wa,bc
	jr ult,L3261
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
L3261:
L3260:
	ld a,ixl
	extz wa
	ld bc,(xsp+32)
	add bc,1
	cp wa,bc
	jr gt,L3262
	jr L3247
L3262:
	dec 1,ixl
L3248:
L3249:
	jp L3246
L3247:
L3245:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function id_road_write
_id_road_write__26:
	push xiz
	lda xsp,(xsp-82)
	ld wa,0
	ld (xsp+12),a
	ld wa,(_band_col__26+6)
	ld (xsp+14),wa
	ld a,(_road_bottom__26)
	extz wa
	ld iz,wa
	ld a,(_road_top__26)
	extz wa
	ld c,(_climb_room__26)
	extz bc
	sub wa,bc
	ld (xsp+22),wa
	ld xwa,_band_lut__26
	ld bc,(_band_phase__26)
	srl 1,bc
	and bc,15
	mul xbc,48
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+28),xwa
	ld xwa,(_id_xy__26)
	ld (xsp+32),xwa
	ld xwa,(_id_bandcol__26)
	ld (xsp+36),xwa
	ld a,(_road_base_x__26)
	ld (xsp+40),a
	ld a,(_road_plane0__26)
	ld (xsp+41),a
	ld xwa,_id_src__26
	ld c,(_road_lines__26)
	extz bc
	sub bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	sll 8,wa
	ld (xsp+16),wa
	ld xwa,_id_src__26
	ld c,(_road_lines__26)
	extz bc
	sub bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	ld c,(_id_src__26)
	extz bc
	sub wa,bc
	sll 8,wa
	exts xwa
	ld c,(_road_lines__26)
	extz bc
	sub bc,1
	divs xwa,bc
	ld (xsp+18),wa
	ld a,(_road_lines__26)
	cp a,0
	jr z,L3363
	ld xwa,_id_w_lat__26
	ld (xsp+42),xwa
	ld xwa,_id_curve_dx__26
	ld (xsp+46),xwa
	ld xwa,_id_dxc__26+128
	ld (xsp+50),xwa
	ld xwa,_id_shear__26
	ld (xsp+54),xwa
	ld wa,(xsp+90)
	ld (xsp+58),wa
	ld a,(_road_lines__26)
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
L3363:
	ld a,(_road_lines__26)
	cp a,0
	jp z,L3364
	ld wa,(xsp+22)
	cp wa,2
	jp lt,L3364
	ld wa,(xsp+22)
	cp wa,255
	jp gt,L3364
	ld a,(_road_lines__26)
	extz wa
	sub wa,1
	ld (xsp+24),wa
	ld wa,iz
	cp wa,(xsp+22)
	jp lt,L3365
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
	ld xwa,_id_sl__26
	ld c,(_road_lines__26)
	extz bc
	exts xbc
	add xwa,xbc
	ld (xsp+50),xwa
	ld xwa,_id_shear__26
	ld c,(_road_lines__26)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+54),xwa
	ld xwa,_hill_rate__26+20
	ld (xsp+58),xwa
	ld xwa,(xsp+28)
	ld (xsp+62),xwa
	ld xwa,_band_col__26
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
	ld a,(_road_lines__26)
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
L3365:
	jp L3366
L3364:
	ld a,(_road_lines__26)
	extz wa
	sub wa,1
	ld (xsp+24),wa
	jp L3370
L3367:
	ld xwa,_hill_rate__26
	ld bc,20
	ld xde,_id_sl__26+64
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
	ld xwa,_id_shear__26
	ld bc,(xsp+24)
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+46),wa
	ld bc,iz
	cp bc,(xsp+22)
	jr ge,L3371
	ld wa,(xsp+22)
	jr L3372
L3371:
	ld wa,iz
L3372:
	ld xbc,_id_sl__26
	ld de,(xsp+24)
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,_band_col__26
	ld xbc,(xsp+28)
	ld xde,_id_sl__26+128
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
	jr ult,L3373
	ld wa,iz
	cp wa,(xsp+22)
	jr lt,L3373
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
L3373:
	ld a,(xsp+43)
	cp a,2
	jr nz,L3374
	ld wa,iz
	cp wa,(xsp+22)
	jr lt,L3374
	ld a,izl
	ld (xsp+48),a
	ld wa,(xsp+18)
	srl 1,wa
	ld (xsp+50),wa
	ld bc,(xsp+16)
	cp bc,(xsp+50)
	jr ule,L3375
	ld wa,(xsp+16)
	sub wa,(xsp+50)
	jr L3376
L3375:
	ld wa,(xsp+16)
L3376:
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
L3374:
	ld wa,(xsp+16)
	ld bc,(xsp+18)
	sub wa,bc
	ld (xsp+16),wa
	ld wa,iz
	cp wa,(xsp+22)
	jr ge,L3377
	jr L3368
L3377:
L3369:
	decw 1,(xsp+24)
L3370:
	ld wa,(xsp+24)
	cp wa,0
	jp ge,L3367
L3368:
L3366:
	ld xwa,_id_shear__26
	ld c,(_wide_k0__26)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+42),wa
	ld xwa,_id_shear__26
	ld c,(_road_lines__26)
	extz bc
	sub bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+44),wa
	ld wa,(xsp+42)
	cp wa,0
	jr ge,L3378
	ld wa,(xsp+42)
	neg wa
	ld (xsp+42),wa
L3378:
	ld wa,(xsp+44)
	cp wa,0
	jr ge,L3379
	ld wa,(xsp+44)
	neg wa
	ld (xsp+44),wa
L3379:
	ld wa,(xsp+42)
	cp wa,46
	jr ge,L3381
	ld wa,(xsp+44)
	cp wa,46
	jr lt,L3380
L3381:
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
	call _wide_rows__26
	lda xsp,(xsp+20)
	pop xiy
	pop xix
L3380:
	ld bc,(xsp+24)
	cp bc,0
	jr ge,L3382
	ld wa,1
	jr L3383
L3382:
	ld wa,0
L3383:
	ld (xsp+26),a
	jr L3386
L3384:
	ld a,(xsp+22)
	ld xbc,_id_sl__26
	ld de,(xsp+24)
	exts xde
	add xbc,xde
	ld (xbc),a
	decw 1,(xsp+24)
L3386:
	ld wa,(xsp+24)
	cp wa,0
	jr ge,L3384
L3385:
	ld a,izl
	add a,1
	ld (_band_first__26),a
	ld a,(_band_first__26)
	cp a,(_band_held__26)
	jp ule,L3387
	ld a,(_band_first__26)
	sub a,(_band_held__26)
	cp a,2
	jr uge,L3389
	ld a,(_band_wait__26)
	cp a,16
	jr ult,L3388
L3389:
	ldb (_band_wait__26),0
	jr L3390
L3388:
	incb 1,(_band_wait__26)
	jr L3393
L3391:
	decb 1,(_band_first__26)
	ld xwa,(_id_xy__26)
	ld c,(_band_first__26)
	extz bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(_id_xy__26)
	ld e,(_band_first__26)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,(_id_bandcol__26)
	ld c,(_band_first__26)
	extz bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(_id_bandcol__26)
	ld e,(_band_first__26)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3393:
	ld a,(_band_first__26)
	cp a,(_band_held__26)
	jr ugt,L3391
L3392:
L3390:
	jr L3394
L3387:
	ldb (_band_wait__26),0
L3394:
	ld a,(_band_first__26)
	ld (_band_held__26),a
	ld a,(_road_top__26)
	extz wa
	ld c,(_band_first__26)
	extz bc
	sub wa,bc
	ld (xsp+42),wa
	ld wa,(_band_col__26+6)
	ld (xsp+46),wa
	push xix
	push xiy
	call _road_is_tarmac__26
	pop xiy
	pop xix
	cp a,0
	jp z,L3395
	ld wa,(_band_col__26)
	ld (xsp+56),wa
	ld wa,0
	ld bc,(_band_phase__26)
	srl 5,bc
	sub wa,bc
	ld (xsp+58),a
	ld a,(_road_top__26)
	extz wa
	ld (xsp+44),wa
	ld wa,(xsp+44)
	ld c,(_road_bottom__26)
	extz bc
	cp wa,bc
	jr ule,L3396
	ld a,(_road_bottom__26)
	extz wa
	ld (xsp+44),wa
L3396:
	ld xwa,(_id_bandcol__26)
	ld c,(_band_first__26)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+48),xwa
	ld xwa,(_id_bandcol__26)
	ld bc,(xsp+44)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+52),xwa
	jr L3399
L3397:
	ld c,(xsp+58)
	incb 1,(xsp+58)
	extz bc
	and bc,2
	cp bc,0
	jr z,L3400
	ld wa,(xsp+46)
	jr L3401
L3400:
	ld wa,(xsp+56)
L3401:
	ld xbc,(xsp+48)
	inc 2,xbc
	ld (xsp+48),xbc
	dec 2,xbc
	ld (xbc),wa
L3399:
	ld xwa,(xsp+48)
	cp xwa,(xsp+52)
	jr ult,L3397
L3398:
	jr L3402
L3395:
	ld wa,(xsp+42)
	cp wa,24
	jr le,L3403
	ldw (xsp+42),24
L3403:
	ld a,(_band_first__26)
	extz wa
	ld de,(xsp+42)
	cp de,0
	jr le,L3404
	ld bc,(xsp+42)
	jr L3405
L3404:
	ld bc,0
L3405:
	add wa,bc
	ld (xsp+44),wa
	ld wa,(xsp+44)
	ld c,(_road_bottom__26)
	extz bc
	cp wa,bc
	jr ule,L3406
	ld a,(_road_bottom__26)
	extz wa
	ld (xsp+44),wa
L3406:
	ld xwa,(_id_bandcol__26)
	ld c,(_band_first__26)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+48),xwa
	ld xwa,(_id_bandcol__26)
	ld bc,(xsp+44)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+52),xwa
	jr L3409
L3407:
	ld wa,(xsp+46)
	ld xbc,(xsp+48)
	inc 2,xbc
	ld (xsp+48),xbc
	dec 2,xbc
	ld (xbc),wa
L3409:
	ld xwa,(xsp+48)
	cp xwa,(xsp+52)
	jr ult,L3407
L3408:
L3402:
	ld a,(_band_first__26)
	extz wa
	ld c,(_road_top__26)
	extz bc
	sub wa,bc
	ld (_band_shift__26),wa
	ld a,(_road_bottom__26)
	ld c,(_band_first__26)
	sub a,c
	add a,1
	ld (_band_count__26),a
	ld wa,(_band_col__26+6)
	ld (xsp+12),wa
	ld a,(_id_buf__26)
	ld (xsp+14),a
	ld xwa,_bc_rest__26
	ld c,(xsp+14)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,(xsp+12)
	jr z,L3410
	ld wa,(xsp+12)
	ld xbc,_bc_rest__26
	ld e,(xsp+14)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,0
	ld xbc,_bc_top__26
	ld e,(xsp+14)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(_id_bandcol__26)
	ld bc,152
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+16),xwa
	ld xwa,(_id_bandcol__26)
	ld bc,152
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+20),xwa
	jr L3413
L3411:
	ld wa,(xsp+12)
	ld xbc,(xsp+16)
	inc 2,xbc
	ld (xsp+16),xbc
	dec 2,xbc
	ld (xbc),wa
L3413:
	ld xwa,(xsp+16)
	cp xwa,(xsp+20)
	jr ult,L3411
L3412:
L3410:
	ld xwa,_bc_top__26
	ld c,(xsp+14)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_band_first__26)
	jr uge,L3414
	ld xwa,(_id_bandcol__26)
	ld xbc,_bc_top__26
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
	ld xwa,(_id_bandcol__26)
	ld c,(_band_first__26)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+20),xwa
	jr L3417
L3415:
	ld wa,(xsp+12)
	ld xbc,(xsp+16)
	inc 2,xbc
	ld (xsp+16),xbc
	dec 2,xbc
	ld (xbc),wa
L3417:
	ld xwa,(xsp+16)
	cp xwa,(xsp+20)
	jr ult,L3415
L3416:
L3414:
	ld a,(_band_first__26)
	ld xbc,_bc_top__26
	ld e,(xsp+14)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld xwa,(_id_xy__26)
	ld c,(_road_bottom__26)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(_id_xy__26)
	ld (xbc+304),wa
	ld xwa,(_id_bandcol__26)
	ld c,(_road_bottom__26)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,(_id_bandcol__26)
	ld (xbc+304),wa
	ld bc,(_band_shift__26)
	cp bc,0
	jr le,L3418
	ld wa,(_band_shift__26)
	jr L3419
L3418:
	ld wa,0
L3419:
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
	call _uses_akina__26
	pop xiy
	pop xix
	cp a,0
	jp nz,L3420
	ld a,(_road_base_x__26)
	extz wa
	ld e,(_pan_fine__26)
	cp e,0
	jr z,L3421
	ld bc,(_pan_head__26)
	exts xbc
	divs xbc,2
	neg bc
	exts xbc
	divs xbc,16
	jr L3422
L3421:
	ld bc,(xsp+94)
	sra 1,bc
	neg bc
	ld de,(xsp+90)
	sra 4,de
	add bc,de
L3422:
	add wa,bc
	extz wa
	ld (xsp+12),wa
	ld a,(_road_base_x__26)
	extz wa
	ld e,(_pan_fine__26)
	cp e,0
	jr z,L3423
	ld bc,(_pan_head__26)
	sll 1,bc
	neg bc
	exts xbc
	divs xbc,16
	jr L3424
L3423:
	ld bc,(xsp+94)
	sll 1,bc
	neg bc
	ld de,(xsp+90)
	sra 2,de
	add bc,de
L3424:
	add wa,bc
	extz wa
	ld (xsp+14),wa
	ld c,(_band_first__26)
	cp c,244
	jr uge,L3425
	ld a,(_band_first__26)
	extz wa
	add wa,0
	jr L3426
L3425:
	ld a,(_band_first__26)
	extz wa
L3426:
	ld (xsp+16),a
	ld c,(xsp+16)
	cp c,40
	jr ule,L3427
	ld a,(xsp+16)
	extz wa
	jr L3428
L3427:
	ld a,40
	extz wa
L3428:
	ld (xsp+17),a
	ld c,(_band_first__26)
	cp c,(xsp+17)
	jr uge,L3429
	ld a,(_band_first__26)
	extz wa
	jr L3430
L3429:
	ld a,(xsp+17)
	extz wa
L3430:
	ld (xsp+18),a
	ld a,(xsp+18)
	extz wa
	ld (xsp+20),wa
	ld wa,(xsp+12)
	ld xbc,_band_top__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L3432
	ld wa,(xsp+14)
	ld xbc,_band_mid__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L3432
	ld a,(xsp+17)
	ld xbc,_band_bg_end__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr nz,L3432
	ld wa,(xsp+10)
	ld xbc,_band_pitch__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	exts bc
	cp wa,bc
	jr nz,L3432
	ld a,(_band_first__26)
	ld xbc,_band_bg_first__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr z,L3431
L3432:
	ld wa,(xsp+12)
	ld xbc,_band_top__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+14)
	ld xbc,_band_mid__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld a,(xsp+17)
	ld xbc,_band_bg_end__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(_band_first__26)
	ld xbc,_band_bg_first__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ldw (xsp+20),0
L3431:
	push xix
	push xiy
	call _sky_is_tall_course__26
	pop xiy
	pop xix
	ld (xsp+22),a
	ld xwa,(_id_xy__26)
	ld bc,(xsp+20)
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld xix,xwa
	ld xwa,(_id_xy__26)
	ld c,(xsp+17)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+28),xwa
	ld a,(xsp+22)
	cp a,0
	jr z,L3433
	jr L3436
L3434:
	ld wa,(xsp+14)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L3436:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr ult,L3434
L3435:
	jp L3437
L3433:
	ld a,(xsp+10)
	neg a
	extz wa
	sll 8,wa
	ld (xsp+36),wa
	ld wa,(xsp+20)
	ld iy,wa
	jr L3440
L3438:
	ld bc,iy
	cp bc,40
	jr uge,L3441
	ld wa,(xsp+12)
	jr L3442
L3441:
	ld wa,(xsp+14)
L3442:
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
L3440:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr uge,L3443
	ld wa,iy
	cp wa,(xsp+10)
	jr lt,L3438
L3443:
L3439:
	ld xwa,(_id_xy__26)
	ld bc,40
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+32),xwa
	ld xwa,(xsp+32)
	cp xwa,(xsp+28)
	jr ule,L3444
	ld xwa,(xsp+28)
	ld (xsp+32),xwa
L3444:
	jr L3447
L3445:
	ld wa,(xsp+12)
	or wa,(xsp+36)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L3447:
	ld xwa,xix
	cp xwa,(xsp+32)
	jr ult,L3445
L3446:
	jr L3450
L3448:
	ld wa,(xsp+14)
	or wa,(xsp+36)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L3450:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr ult,L3448
L3449:
L3437:
	ld a,(xsp+10)
	ld xbc,_band_pitch__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+14)
	ld (xsp+8),wa
	jp L3451
L3420:
	ld a,(_road_base_x__26)
	add a,(xsp+2)
	extz wa
	ld (xsp+12),wa
	ld a,(_road_base_x__26)
	add a,(xsp+4)
	extz wa
	ld (xsp+14),wa
	ld a,(_road_base_x__26)
	add a,(xsp+6)
	extz wa
	ld (xsp+16),wa
	ld wa,(xsp+16)
	ld xbc,_band_tree__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L3453
	ld wa,(xsp+10)
	ld xbc,_band_pitch__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	exts bc
	cp wa,bc
	jr nz,L3453
	ld a,(_band_first__26)
	ld xbc,_band_bg_end__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp z,L3452
L3453:
	ld a,(xsp+10)
	ld xbc,_band_pitch__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld a,(_band_first__26)
	ld xbc,_band_bg_end__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+16)
	ld xbc,_band_mid__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+16)
	ld xbc,_band_tree__26
	ld e,(_id_buf__26)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld iy,0
	jr L3457
L3454:
	push xwa
	push xix
	push xiy
	call _sky_is_tall_course__26
	ld xbc,xwa
	pop xiy
	pop xix
	pop xwa
	cp c,0
	jr z,L3458
	ld wa,0
	jr L3459
L3458:
	ld wa,(xsp+10)
	neg wa
L3459:
	ld (xsp+18),wa
	ld wa,iy
	add wa,(xsp+18)
	cp wa,0
	jr ge,L3460
	ld wa,iy
	neg wa
	ld (xsp+18),wa
L3460:
	ld wa,(xsp+16)
	ld c,(xsp+18)
	extz bc
	sll 8,bc
	or wa,bc
	ld xbc,(_id_xy__26)
	ld de,iy
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3456:
	inc 1,iy
L3457:
	ld wa,iy
	ld c,(_band_first__26)
	extz bc
	cp wa,bc
	jr ult,L3454
L3455:
L3452:
	ld wa,(xsp+16)
	ld (xsp+8),wa
L3451:
L3362:
	lda xsp,(xsp+82)
	pop xiz
	ret

; function id_road_ready
_id_road_ready:
	ld xwa,(_id_xy__26)
	ld (_id_xy_done__26),xwa
	ld xwa,(_id_bandcol__26)
	ld (_id_bandcol_done__26),xwa
L3462:
	ret

; function id_road_pan
_id_road_pan:
	ld wa,(xsp+4)
	ld (_pan_head__26),wa
	ld wa,(xsp+8)
	ld (_pan_lat__26),wa
	ldb (_pan_fine__26),1
L3464:
	ret

; function id_road_begin
_id_road_begin:
	ld xwa,(_id_xy_live__26)
	cp xwa,_id_xy_a__26
	jr nz,L3471
	ld xwa,_id_xy_b__26
	ld (_id_xy__26),xwa
	ld xwa,_id_bandcol_b__26
	ld (_id_bandcol__26),xwa
	jr L3472
L3471:
	ld xwa,_id_xy_a__26
	ld (_id_xy__26),xwa
	ld xwa,_id_bandcol_a__26
	ld (_id_bandcol__26),xwa
L3472:
	ld xbc,(_id_xy__26)
	cp xbc,_id_xy_a__26
	jr nz,L3473
	ld wa,0
	jr L3474
L3473:
	ld wa,1
L3474:
	ld (_id_buf__26),a
L3470:
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
	jr L3484
L3481:
	ld wa,ix
	ld xbc,_id_w_curve__26
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	mul xwa,bc
	sra 8,wa
	ld xbc,_id_curve_dx__26
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3483:
	inc 1,izl
L3484:
	ld a,izl
	cp a,(_road_lines__26)
	jr ult,L3481
L3482:
	push xix
	ld wa,(xsp+22)
	push xwa
	ld wa,(xsp+18)
	push xwa
	call _id_road_write__26
	lda xsp,(xsp+8)
	pop xix
	push xix
	call _id_road_ready
	pop xix
L3480:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_ahead
_id_road_ahead:
	ld xwa,_id_ahead__26
	jr L3486
L3486:
	ret

; function id_road_lines
_id_road_lines:
	ld a,(_road_lines__26)
	jr L3488
L3488:
	ret

; function id_road_frame_ahead
_id_road_frame_ahead:
	push xiz
	lda xsp,(xsp-18)
	ld a,(_road_lines__26)
	ld izl,a
	ld wa,0
	ld (xsp+2),wa
	ld wa,0
	ld (xsp+4),wa
	call _id_road_begin
	ld a,izl
	cp a,0
	jr z,L3492
	ld xwa,(xsp+30)
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+6),xwa
	ld xwa,_id_curve_dx__26
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+10),xwa
	ld wa,(_id_curve_cm__26)
	ld (xsp+14),wa
	ld a,izl
	extz wa
	ld (xsp+16),wa
	lda xwa,(xsp+6)
	push xwa
	call _id_road_curve_asm
	lda xsp,(xsp+4)
L3492:
	ld wa,(xsp+34)
	push xwa
	ld wa,(xsp+30)
	push xwa
	call _id_road_write__26
	lda xsp,(xsp+8)
	call _id_road_ready
L3491:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_fill_hud_band
_id_fill_hud_band__26:
	push xiz
	lda xsp,(xsp-2)
	ld iz,152
	jr L3502
L3499:
	ld wa,2048
	ld c,(_road_base_x__26)
	extz bc
	or wa,bc
	ld xbc,_id_xy_a__26
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld xwa,_id_xy_a__26
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_id_xy_b__26
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3501:
	inc 1,iz
L3502:
	ld wa,iz
	cp wa,152
	jr ult,L3499
L3500:
L3498:
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
	cp a,(_road_top__26)
	jr uge,L3508
	ld a,(_road_top__26)
	ld izl,a
	jr L3509
L3508:
	ld a,izl
	cp a,(_road_bottom__26)
	jr ule,L3510
	ld a,(_road_bottom__26)
	ld izl,a
L3510:
L3509:
	ld a,izl
	sub a,(_road_top__26)
	ld ixl,a
	ld wa,80
	ld xbc,_id_shear__26
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
	ld xbc,_id_sl__26
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
	ld xwa,_id_half__26
	ld c,ixl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xiy+4),a
L3507:
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
	cp a,(_road_top__26)
	jr uge,L3516
	ld a,(_road_top__26)
	ld izl,a
	jr L3517
L3516:
	ld a,izl
	cp a,(_road_bottom__26)
	jr ule,L3518
	ld a,(_road_bottom__26)
	ld izl,a
L3518:
L3517:
	ld a,izl
	sub a,(_road_top__26)
	ld (xsp+0),a
	ld wa,80
	ld xbc,_id_shear__26
	ld e,(xsp+0)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	sub wa,bc
	jr L3515
L3515:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_band_phase
_id_road_band_phase:
	ld wa,(xsp+4)
	ld (_band_phase__26),wa
L3520:
	ret

; function id_road_join
_id_road_join:
	ld c,(xsp+4)
	cp c,1
	jr uge,L3525
	ld a,(xsp+4)
	extz wa
	jr L3526
L3525:
	ld wa,0
L3526:
	ld (_road_course__26),a
	call _id_load_palettes__26
	ld wa,0
	push xwa
	call _id_road_join_white
	lda xsp,(xsp+4)
L3524:
	ret

; function id_road_join_white
_id_road_join_white:
	push xiz
	lda xsp,(xsp-10)
	ld izl,0
	jp L3536
L3533:
	ld xwa,_course_sol__26
	ld c,(_road_course__26)
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
	ld xbc,_band_col__26
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3535:
	inc 1,izl
L3536:
	ld a,izl
	cp a,4
	jp ult,L3533
L3534:
	ld wa,65535
	ld (_band_top__26+2),wa
	ld (_band_top__26),wa
	ld wa,65535
	ld (_band_mid__26+2),wa
	ld (_band_mid__26),wa
	ld wa,65535
	ld (_band_tree__26+2),wa
	ld (_band_tree__26),wa
L3532:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function id_road_hill_ahead
_id_road_hill_ahead:
	push xiz
	lda xsp,(xsp-12)
	ld xwa,(xsp+20)
	ld (xsp+0),xwa
	ld xwa,_id_sl__26+64
	ld xiy,xwa
	ld a,(_grade_hi__26)
	ld (xsp+8),a
	ld a,(_grade_lo__26)
	ld (xsp+9),a
	ld a,(_road_lines__26)
	ld ixl,a
	ld xwa,(xsp+0)
	cp xwa,xiy
	jr nz,L3546
	ld ixl,0
L3546:
	jr L3549
L3547:
	ld xwa,(xsp+0)
	inc 1,xwa
	ld (xsp+0),xwa
	dec 1,xwa
	ld a,(xwa)
	ld izl,a
	ld a,izl
	cp a,(xsp+8)
	jr le,L3550
	ld a,(xsp+8)
	ld izl,a
	jr L3551
L3550:
	ld a,izl
	cp a,(xsp+9)
	jr ge,L3552
	ld a,(xsp+9)
	ld izl,a
L3552:
L3551:
	ld a,izl
	ld xbc,xiy
	inc 1,xbc
	ld xiy,xbc
	dec 1,xbc
	ld (xbc),a
	dec 1,ixl
L3549:
	ld a,ixl
	cp a,0
	jr nz,L3547
L3548:
	ld xwa,_id_sl__26+64
	ld c,(_road_lines__26)
	extz bc
	sub bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_road_grade__26),a
L3545:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function id_road_grade_buf
_id_road_grade_buf:
	ld xwa,_id_sl__26+64
	jr L3554
L3554:
	ret

; function id_road_band_first
_id_road_band_first:
	ld a,(_band_first__26)
	jr L3556
L3556:
	ret

; function id_road_visible_top
_id_road_visible_top:
	push xiz
	lda xsp,(xsp-2)
	ld c,(_band_first__26)
	cp c,244
	jr uge,L3564
	ld a,(_band_first__26)
	add a,0
	extz wa
	jr L3565
L3564:
	ld a,(_band_first__26)
	extz wa
L3565:
	ld izl,a
	ld a,izl
	cp a,40
	jr uge,L3566
	ld izl,40
L3566:
	ld c,izl
	cp c,(_road_bottom__26)
	jr ule,L3567
	ld a,(_road_bottom__26)
	extz wa
	jr L3568
L3567:
	ld a,izl
	extz wa
L3568:
	jr L3563
L3563:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_grade_hi
_id_road_grade_hi:
	ld a,(_grade_hi__26)
	jr L3570
L3570:
	ret

; function id_road_grade_lo
_id_road_grade_lo:
	ld a,(_grade_lo__26)
	jr L3572
L3572:
	ret

; function id_road_set_hill
_id_road_set_hill:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld ixl,a
	ld a,ixl
	cp a,(_grade_hi__26)
	jr le,L3582
	ld a,(_grade_hi__26)
	ld ixl,a
	jr L3583
L3582:
	ld a,ixl
	cp a,(_grade_lo__26)
	jr ge,L3584
	ld a,(_grade_lo__26)
	ld ixl,a
L3584:
L3583:
	ld a,ixl
	ld (_road_grade__26),a
	ld izl,0
	jr L3588
L3585:
	ld a,ixl
	ld xbc,_id_sl__26+64
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3587:
	inc 1,izl
L3588:
	ld a,izl
	cp a,(_road_lines__26)
	jr ult,L3585
L3586:
L3581:
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
	cp a,(_road_top__26)
	jr ult,L3595
	ld a,ixl
	cp a,(_road_bottom__26)
	jr ule,L3594
L3595:
	ld wa,0
	jr L3593
L3594:
	ld a,ixl
	extz wa
	ld c,(_road_top__26)
	extz bc
	sub wa,bc
	ld iz,wa
	ld wa,iz
	ld c,(_road_lines__26)
	extz bc
	cp wa,bc
	jr lt,L3596
	ld a,(_road_lines__26)
	extz wa
	sub wa,1
	ld iz,wa
L3596:
	ld xwa,_id_sl__26
	ld bc,iz
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	ld iy,wa
	ld a,iyl
	ld c,ixl
	sub a,c
	jr L3593
L3593:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function id_road_car_lift
_id_road_car_lift:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_road_bottom__26)
	sub a,(_car_stand__26)
	push xwa
	call _id_road_line_shift
	lda xsp,(xsp+4)
	exts wa
	neg wa
	ld iz,wa
	ld wa,iz
	cp wa,8
	jr le,L3602
	ld iz,8
	jr L3603
L3602:
	ld wa,iz
	cp wa,65531
	jr ge,L3604
	ld iz,65531
L3604:
L3603:
	ld a,izl
	jr L3601
L3601:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_half_at
_id_road_half_at:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,(_road_top__26)
	jr uge,L3610
	ld a,(_road_top__26)
	ld izl,a
	jr L3611
L3610:
	ld a,izl
	cp a,(_road_bottom__26)
	jr ule,L3612
	ld a,(_road_bottom__26)
	ld izl,a
L3612:
L3611:
	ld xwa,_id_half__26
	ld c,izl
	sub c,(_road_top__26)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	jr L3609
L3609:
	pop xiz
	ret

; function id_road_line_at_distance
_id_road_line_at_distance:
	push xiz
	lda xsp,(xsp-4)
	ld wa,0
	ld izl,a
	ld a,(_road_lines__26)
	sub a,1
	ld iyl,a
	ld wa,(xsp+12)
	cp wa,(_id_ahead__26)
	jr ule,L3621
	ld wa,255
	jr L3620
L3621:
	jr L3624
L3622:
	ld a,izl
	extz wa
	ld c,iyl
	extz bc
	add wa,bc
	add wa,1
	srl 1,wa
	ld ixl,a
	ld xwa,_id_ahead__26
	ld c,ixl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,(xsp+12)
	jr ult,L3625
	ld a,ixl
	ld izl,a
	jr L3626
L3625:
	ld a,ixl
	sub a,1
	ld iyl,a
L3626:
L3624:
	ld a,izl
	cp a,iyl
	jr ult,L3622
L3623:
	ld a,(_road_top__26)
	add a,izl
	jr L3620
L3620:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function id_road_distance_at_line
_id_road_distance_at_line:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,(_road_top__26)
	jr uge,L3632
	ld a,(_road_top__26)
	ld izl,a
	jr L3633
L3632:
	ld a,izl
	cp a,(_road_bottom__26)
	jr ule,L3634
	ld a,(_road_bottom__26)
	ld izl,a
L3634:
L3633:
	ld xwa,_id_ahead__26
	ld c,izl
	sub c,(_road_top__26)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L3631
L3631:
	pop xiz
	ret

; function id_scenery_char_count
_id_scenery_char_count:
	ld wa,0
	jr L3636
L3636:
	ret

; function id_scenery_init
_id_scenery_init:
	ldb (_scn_phase__27),0
	ldw (_scn_frac__27),0
	ldb (_scn_passed__27),0
	ldb (_scn_mode__27),0
	ld a,64
	push xwa
	ld a,50
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L3638:
	ret

; function scenery_mode
_scenery_mode:
	ld a,(xsp+4)
	ld (_scn_mode__27),a
L3640:
	ret

; function id_scenery_passed
_id_scenery_passed:
	ld a,(_scn_passed__27)
	jr L3642
L3642:
	ret

; function kind_of
_kind_of__27:
	ld a,(_scn_mode__27)
	cp a,5
	jr nz,L3651
	ld wa,14
	jr L3650
L3651:
	ld a,(_scn_mode__27)
	cp a,1
	jr nz,L3652
	ld wa,12
	jr L3650
L3652:
	ld a,(_scn_mode__27)
	cp a,3
	jr ult,L3653
	ld wa,11
	jr L3650
L3653:
	ld a,(_scn_mode__27)
	cp a,2
	jr nz,L3654
	ld wa,13
	jr L3650
L3654:
	ld c,(xsp+4)
	cp c,0
	jr z,L3655
	call _theme_obj_kind_right
	extz wa
	jr L3656
L3655:
	call _theme_obj_kind_left
	extz wa
L3656:
	jr L3650
L3650:
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
	jp L3673
L3670:
	ld a,(_scn_passed__27)
	extz wa
	ld bc,1
	ld e,izl
	cp e,0
	jr z,L3676
L3675:
	sll 1,bc
	djnz e,L3675
L3676:
	extz bc
	and wa,bc
	cp wa,0
	jr nz,L3674
	jp L3672
L3674:
	ld xwa,_gfx_obj_frames
	push xwa
	push xix
	push xiy
	ld a,izl
	push xwa
	call _kind_of__27
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
	jr nz,L3677
	ld wa,iy
	neg wa
	add wa,12
	cp wa,(xsp+12)
	jr lt,L3678
	ld wa,iy
	neg wa
	sub wa,12
	cp wa,(xsp+14)
	jr gt,L3678
	ld wa,1
	jr L3669
L3678:
	jr L3679
L3677:
	ld wa,iy
	add wa,12
	cp wa,(xsp+12)
	jr lt,L3680
	ld wa,iy
	sub wa,12
	cp wa,(xsp+14)
	jr gt,L3680
	ld wa,1
	jr L3669
L3680:
L3679:
L3672:
	inc 1,izl
L3673:
	ld a,izl
	cp a,2
	jp ult,L3670
L3671:
	ld wa,0
	jr L3669
L3669:
	lda xsp,(xsp+16)
	pop xiz
	ret

; function obj_phase
_obj_phase__27:
	ld a,(_scn_phase__27)
	extz wa
	ld c,(xsp+4)
	extz bc
	mul xbc,43
	extz bc
	add wa,bc
	jr L3682
L3682:
	ret

; function id_scenery_advance
_id_scenery_advance:
	push xiz
	lda xsp,(xsp-6)
	ld wa,(_scn_frac__27)
	ld c,(xsp+14)
	extz bc
	mul xbc,158
	add wa,bc
	ld (xsp+0),wa
	ld wa,(xsp+0)
	and wa,2047
	ld (_scn_frac__27),wa
	ld wa,(xsp+0)
	srl 11,wa
	ld (xsp+0),wa
	ld a,(_scn_phase__27)
	ld iyl,a
	ld a,(_scn_phase__27)
	ld c,(xsp+0)
	add a,c
	ld (_scn_phase__27),a
	ldb (_scn_passed__27),0
	ld izl,0
	jr L3695
L3692:
	ld a,izl
	extz wa
	mul xwa,43
	ld ixl,a
	ld a,(_scn_phase__27)
	add a,ixl
	ld c,iyl
	add c,ixl
	cp a,c
	jr uge,L3696
	ld a,(_scn_passed__27)
	extz wa
	ld e,izl
	extz de
	and de,1
	cp de,0
	jr z,L3697
	ld bc,2
	jr L3698
L3697:
	ld bc,1
L3698:
	extz bc
	or wa,bc
	ld (_scn_passed__27),a
L3696:
L3694:
	inc 1,izl
L3695:
	ld a,izl
	cp a,6
	jr ult,L3692
L3693:
L3691:
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
L3700:
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
	jr z,L3750
	ld wa,58
	jr L3751
L3750:
	ld wa,64
L3751:
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
	jr L3755
L3752:
	ld a,(xsp+0)
	push xwa
	call _obj_phase__27
	lda xsp,(xsp+4)
	push xwa
	ld a,(xsp+5)
	push xwa
	call _obj_phase__27
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp a,c
	jr ule,L3756
	ld a,(xsp+0)
	ld (xsp+1),a
L3756:
L3754:
	incb 1,(xsp+0)
L3755:
	ld a,(xsp+0)
	cp a,6
	jr ult,L3752
L3753:
	ldb (xsp+0),0
	jp L3760
L3757:
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
	call _obj_phase__27
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
	jr ule,L3761
	ld wa,(xsp+10)
	ld iz,wa
L3761:
	ld a,(xsp+4)
	add a,izl
	ld (xsp+18),a
	ld wa,iz
	cp wa,6
	jr uge,L3762
	ldb (xsp+17),4
	jr L3763
L3762:
	ld wa,iz
	cp wa,10
	jr uge,L3764
	ldb (xsp+17),3
	jr L3765
L3764:
	ld wa,iz
	cp wa,15
	jr uge,L3766
	ldb (xsp+17),2
	jr L3767
L3766:
	ld wa,iz
	cp wa,22
	jr uge,L3768
	ldb (xsp+17),1
	jr L3769
L3768:
	ldb (xsp+17),0
L3769:
L3767:
L3765:
L3763:
	ld c,(xsp+12)
	extz bc
	and bc,1
	cp bc,0
	jr z,L3770
	ld wa,1
	jr L3771
L3770:
	ld wa,0
L3771:
	ld (xsp+14),a
	ld a,(_scn_mode__27)
	cp a,5
	jr nz,L3772
	ldb (xsp+15),14
	ldb (xsp+16),6
	jr L3773
L3772:
	ld a,(_scn_mode__27)
	cp a,1
	jr nz,L3774
	ldb (xsp+15),12
	ldb (xsp+16),4
	jr L3775
L3774:
	ld a,(_scn_mode__27)
	cp a,3
	jr ult,L3776
	ldb (xsp+15),11
	ldb (xsp+16),9
	jr L3777
L3776:
	ld a,(_scn_mode__27)
	cp a,2
	jr nz,L3778
	ldb (xsp+15),13
	ldb (xsp+16),10
	jr L3779
L3778:
	ld a,(xsp+14)
	cp a,0
	jr z,L3780
	call _theme_obj_kind_right
	ld (xsp+15),a
	ldb (xsp+16),2
	jr L3781
L3780:
	call _theme_obj_kind_left
	ld (xsp+15),a
	ldb (xsp+16),1
L3781:
L3779:
L3777:
L3775:
L3773:
	ld c,(xsp+14)
	cp c,0
	jr z,L3782
	ld c,(xsp+15)
	cp c,11
	jr ult,L3782
	ld wa,1
	jr L3783
L3782:
	ld wa,0
L3783:
	ld (xsp+20),a
	ld a,(_scn_mode__27)
	cp a,5
	jr nz,L3784
	ld a,(_g_vb_counter)
	extz wa
	sra 3,wa
	ld c,(xsp+12)
	extz bc
	add wa,bc
	and wa,1
	ld (xsp+20),a
	jr L3785
L3784:
	ld a,(_scn_mode__27)
	cp a,3
	jr nz,L3786
	ldb (xsp+20),0
	jr L3787
L3786:
	ld a,(_scn_mode__27)
	cp a,4
	jr nz,L3788
	ldb (xsp+20),1
L3788:
L3787:
L3785:
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
	jr ge,L3789
	jp L3759
L3789:
	ld wa,(xsp+38)
	cp wa,(xsp+6)
	jr le,L3790
	ld wa,(xsp+6)
	ld (xsp+38),wa
L3790:
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
	jr z,L3791
	ld wa,(xsp+40)
	add wa,(xsp+42)
	ld (xsp+26),wa
	jr L3792
L3791:
	ld wa,(xsp+40)
	sub wa,(xsp+42)
	ld xbc,(xsp+34)
	ld c,(xbc+6)
	extz bc
	sub wa,bc
	add wa,1
	ld (xsp+26),wa
L3792:
	ld wa,(xsp+26)
	cp wa,65504
	jr lt,L3794
	ld wa,(xsp+26)
	cp wa,168
	jr le,L3793
L3794:
	jp L3759
L3793:
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
	jr z,L3795
	ld wa,128
	jr L3796
L3795:
	ld wa,0
L3796:
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
L3759:
	incb 1,(xsp+0)
L3760:
	ld a,(xsp+0)
	cp a,6
	jp ult,L3757
L3758:
	ld a,(xsp+3)
	push xwa
	ld a,(xsp+6)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L3749:
	lda xsp,(xsp+60)
	pop xiz
	ret

; function theme_init_tiles
_theme_init_tiles:
	ld wa,(xsp+4)
	ld (_pano_base__28),wa
	ld wa,(xsp+8)
	ld (_obj_base__28),wa
	ld wa,(xsp+12)
	ld (_obj_end__28),wa
L3798:
	ret

; function theme_obj_map
_theme_obj_map:
	ld xwa,_objmap__28
	jr L3800
L3800:
	ret

; function theme_obj_tile
_theme_obj_tile:
	ld xwa,_objmap__28
	ld c,(xsp+4)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L3802
L3802:
	ret

; function theme_obj_kind_left
_theme_obj_kind_left:
	ld a,(_kind_l__28)
	jr L3804
L3804:
	ret

; function theme_obj_kind_right
_theme_obj_kind_right:
	ld a,(_kind_r__28)
	jr L3806
L3806:
	ret

; function load_tile
_load_tile__28:
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
	jr L3816
L3813:
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
L3815:
	inc 1,izl
L3816:
	ld a,izl
	cp a,8
	jr ult,L3813
L3814:
L3812:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function alloc_slot
_alloc_slot__28:
	push xiz
	lda xsp,(xsp-4)
	ld wa,(_next_slot__28)
	ld iz,wa
	ld wa,(_pano_base__28)
	add wa,114
	ld (xsp+2),wa
	ld wa,iz
	cp wa,32
	jr ult,L3824
	ld wa,iz
	cp wa,101
	jr uge,L3824
	ld iz,101
	jr L3825
L3824:
	ld wa,iz
	cp wa,125
	jr ult,L3826
	ld wa,iz
	cp wa,(_pano_base__28)
	jr uge,L3826
	ld wa,(_obj_base__28)
	ld iz,wa
L3826:
L3825:
	ld wa,iz
	cp wa,(_obj_end__28)
	jr ult,L3827
	ld wa,(_pano_end__28)
	ld iz,wa
L3827:
	ld wa,iz
	cp wa,(xsp+2)
	jr ult,L3828
	ld wa,iz
	cp wa,(_obj_base__28)
	jr uge,L3828
	ld wa,0
	jr L3823
L3828:
	ld wa,iz
	add wa,1
	ld (_next_slot__28),wa
	ld wa,iz
	jr L3823
L3823:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function load_kind
_load_kind__28:
	push xiz
	lda xsp,(xsp-10)
	ldb (xsp+0),0
	jp L3844
L3841:
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
	jp L3848
L3845:
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
	ld xwa,_objmap__28
	ld c,(xsp+7)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65535
	jr nz,L3849
	call _alloc_slot__28
	ld (xsp+8),wa
	ld wa,(xsp+8)
	ld xbc,_objmap__28
	ld e,(xsp+7)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	ld wa,(xsp+8)
	cp wa,0
	jr z,L3850
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
	call _load_tile__28
	lda xsp,(xsp+8)
L3850:
L3849:
L3847:
	inc 1,izl
L3848:
	ld a,izl
	ld xbc,(xsp+2)
	ld c,(xbc+2)
	cp a,c
	jp ult,L3845
L3846:
L3843:
	incb 1,(xsp+0)
L3844:
	ld a,(xsp+0)
	cp a,5
	jp ult,L3841
L3842:
L3840:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function set_spr_pal
_set_spr_pal__28:
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
	jr L3860
L3857:
	ld xwa,xix
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_cur_spr__28
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
L3859:
	inc 1,izl
L3860:
	ld a,izl
	cp a,4
	jr ult,L3857
L3858:
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
L3856:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function theme_apply
_theme_apply:
	push xiz
	lda xsp,(xsp-14)
	ld xwa,_gfx_legs
	ld c,(xsp+22)
	extz bc
	muls xbc,22
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+0),xwa
	ld xwa,_gfx_pano
	ld xbc,(xsp+0)
	ld c,(xbc+5)
	extz bc
	muls xbc,20
	add xwa,xbc
	lda xwa,(xwa)
	ld xiy,xwa
	ld iz,0
	jr L3899
L3896:
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
	ld wa,(_pano_base__28)
	add wa,iz
	push xwa
	call _load_tile__28
	lda xsp,(xsp+8)
	pop xiy
	pop xix
L3898:
	inc 1,iz
L3899:
	ld wa,iz
	cp wa,(xiy+4)
	jr ult,L3896
L3897:
	ld iz,0
	jr L3903
L3900:
	ld xwa,(xiy+14)
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_cur_pals__28
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3902:
	inc 1,iz
L3903:
	ld wa,iz
	cp wa,32
	jr ult,L3900
L3901:
	ldb (xsp+11),0
	jr L3907
L3904:
	ld ixl,0
	jr L3911
L3908:
	ld a,(xsp+11)
	extz wa
	sll 5,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld (xsp+12),wa
	ld wa,(_pano_base__28)
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
L3910:
	inc 1,ixl
L3911:
	ld a,ixl
	cp a,32
	jr ult,L3908
L3909:
L3906:
	incb 1,(xsp+11)
L3907:
	ld a,(xsp+11)
	cp a,11
	jr ult,L3904
L3905:
	ld wa,(_pano_base__28)
	add wa,(xiy+4)
	ld (_pano_end__28),wa
	ld wa,(xiy+18)
	ld (_cur_backdrop__28),wa
	ld wa,(xiy+18)
	ld (_cur_road__28),wa
	ld xwa,(xsp+0)
	ld wa,(xwa+8)
	ld (_cur_road__28+2),wa
	ld xwa,(xsp+0)
	lda xwa,(xwa+12)
	ld wa,(xwa)
	ld (_cur_road__28+4),wa
	ld xwa,(xsp+0)
	ld wa,(xwa+10)
	ld (_cur_road__28+6),wa
	ld iz,0
	jr L3915
L3912:
	ld xwa,(xsp+0)
	lda xwa,(xwa+12)
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld xbc,_cur_band__28
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3914:
	inc 1,iz
L3915:
	ld wa,iz
	cp wa,4
	jr ult,L3912
L3913:
	ld iz,0
	jr L3919
L3916:
	ld wa,65535
	ld xbc,_objmap__28
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3918:
	inc 1,iz
L3919:
	ld wa,iz
	cp wa,256
	jr ult,L3916
L3917:
	ldw (_next_slot__28),2
	ld xwa,(xsp+0)
	ld a,(xwa+6)
	ld (_kind_l__28),a
	ld xwa,(xsp+0)
	ld a,(xwa+7)
	ld (_kind_r__28),a
	push xix
	push xiy
	ld a,(_kind_l__28)
	push xwa
	call _load_kind__28
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld a,(_kind_r__28)
	cp a,(_kind_l__28)
	jr z,L3920
	push xix
	push xiy
	ld a,(_kind_r__28)
	push xwa
	call _load_kind__28
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L3920:
	push xix
	push xiy
	ld wa,11
	push xwa
	call _load_kind__28
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld a,(xsp+22)
	cp a,10
	jr uge,L3921
	push xix
	push xiy
	ld wa,12
	push xwa
	call _load_kind__28
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L3921:
	push xix
	push xiy
	ld wa,13
	push xwa
	call _load_kind__28
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld a,(xsp+22)
	cp a,0
	jr z,L3923
	ld a,(xsp+22)
	cp a,10
	jr ult,L3922
L3923:
	push xix
	push xiy
	ld wa,14
	push xwa
	call _load_kind__28
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L3922:
	ld iz,0
	jr L3927
L3924:
	ld xwa,_objmap__28
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65535
	jr nz,L3928
	ld wa,0
	ld xbc,_objmap__28
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3928:
L3926:
	inc 1,iz
L3927:
	ld wa,iz
	cp wa,256
	jr ult,L3924
L3925:
	push xix
	push xiy
	ld wa,0
	push xwa
	ld a,(_kind_l__28)
	push xwa
	ld wa,1
	push xwa
	call _set_spr_pal__28
	lda xsp,(xsp+12)
	pop xiy
	pop xix
	push xix
	push xiy
	ld wa,1
	push xwa
	ld a,(_kind_r__28)
	push xwa
	ld wa,2
	push xwa
	call _set_spr_pal__28
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
	call _set_spr_pal__28
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
	call _set_spr_pal__28
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
	call _set_spr_pal__28
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
	call _set_spr_pal__28
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
L3895:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function to_white
_to_white__28:
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
	jr ult,L3932
	ld wa,4095
	jr L3931
L3932:
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
	jr L3931
L3931:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function theme_flash
_theme_flash:
	push xiz
	lda xsp,(xsp-10)
	ld izl,0
	jp L3946
L3943:
	ld a,(xsp+18)
	push xwa
	ld xwa,_cur_pals__28
	ld c,izl
	extz bc
	sll 2,bc
	add bc,3
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__28
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+22)
	push xwa
	ld xwa,_cur_pals__28
	ld c,izl
	extz bc
	sll 2,bc
	add bc,2
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__28
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+26)
	push xwa
	ld xwa,_cur_pals__28
	ld c,izl
	extz bc
	sll 2,bc
	add bc,1
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__28
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+30)
	push xwa
	ld xwa,_cur_pals__28
	ld c,izl
	extz bc
	sll 2,bc
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__28
	lda xsp,(xsp+8)
	push xwa
	ld a,8
	add a,izl
	push xwa
	ld wa,1
	push xwa
	call _ngpc_gfx_set_palette
	lda xsp,(xsp+24)
L3945:
	inc 1,izl
L3946:
	ld a,izl
	cp a,8
	jp ult,L3943
L3944:
	ldb (xsp+1),0
	jr L3950
L3947:
	ld a,(xsp+18)
	push xwa
	ld xwa,_cur_band__28
	ld c,(xsp+5)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	push xwa
	call _to_white__28
	lda xsp,(xsp+8)
	lda xbc,(xsp+2)
	ld e,(xsp+1)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3949:
	incb 1,(xsp+1)
L3950:
	ld a,(xsp+1)
	cp a,4
	jr ult,L3947
L3948:
	lda xwa,(xsp+2)
	push xwa
	ld a,(xsp+22)
	push xwa
	ld wa,(_cur_road__28+6)
	push xwa
	call _to_white__28
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+26)
	push xwa
	ld wa,(_cur_road__28+2)
	push xwa
	call _to_white__28
	lda xsp,(xsp+8)
	push xwa
	ld a,(xsp+30)
	push xwa
	ld wa,(_cur_backdrop__28)
	push xwa
	call _to_white__28
	lda xsp,(xsp+8)
	push xwa
	call _id_road_set_colors
	lda xsp,(xsp+16)
L3942:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function rnd8
_rnd8__29:
	ld wa,(_rng__29)
	mul xwa,25173
	add wa,13849
	ld (_rng__29),wa
	ld wa,(_rng__29)
	srl 8,wa
	jr L3952
L3952:
	ret

; function traffic_init
_traffic_init:
	push xiz
	lda xsp,(xsp-2)
	ld wa,(xsp+10)
	ld (_trf_tiles__29),wa
	ld iz,0
	jr L3966
L3963:
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
L3965:
	inc 1,iz
L3966:
	ld wa,iz
	ld bc,(_gfx_traffic_tiles_count)
	sll 3,bc
	cp wa,bc
	jr ult,L3963
L3964:
	ld iz,0
	jr L3970
L3967:
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
L3969:
	inc 1,iz
L3970:
	ld wa,iz
	cp wa,5
	jr ult,L3967
L3968:
	call _traffic_clear
L3962:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function traffic_set_car_line
_traffic_set_car_line:
	ld a,(xsp+4)
	push xwa
	call _id_road_distance_at_line
	lda xsp,(xsp+4)
	ld (_car_d__29),wa
	ld a,(xsp+4)
	push xwa
	call _id_road_half_at
	lda xsp,(xsp+4)
	ld (_half_wheel__29),a
	ld a,(_half_wheel__29)
	cp a,0
	jr nz,L3974
	ldb (_half_wheel__29),1
L3974:
L3973:
	ret

; function traffic_clear
_traffic_clear:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L3984
L3981:
	ld a,0
	ld xbc,_cars__29
	ld e,izl
	extz de
	muls xde,14
	add xbc,xde
	ld (xbc),a
L3983:
	inc 1,izl
L3984:
	ld a,izl
	cp a,6
	jr ult,L3981
L3982:
	ld a,50
	push xwa
	ld a,28
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L3980:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function traffic_reset
_traffic_reset:
	ld a,(xsp+4)
	ld (_dens_min__29),a
	ld c,(xsp+8)
	cp c,6
	jr ule,L3989
	ld a,6
	extz wa
	jr L3990
L3989:
	ld a,(xsp+8)
	extz wa
L3990:
	ld (_dens_max__29),a
	ld a,(_dens_min__29)
	ld (_target__29),a
	ldb (_cooldown__29),30
L3988:
	ret

; function lane_lat
_lane_lat__29:
	lda xsp,(xsp-2)
	ld a,(_half_wheel__29)
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
	jr L3992
L3992:
	lda xsp,(xsp+2)
	ret

; function lane_of
_lane_of__29:
	push xiz
	lda xsp,(xsp-4)
	ld a,(_half_wheel__29)
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
	jr ge,L3997
	ld iz,0
L3997:
	ld wa,iz
	cp wa,3
	jr le,L3998
	ld iz,3
L3998:
	ld a,izl
	jr L3996
L3996:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function spawn
_spawn__29:
	push xiz
	lda xsp,(xsp-10)
	ld wa,0
	exts xwa
	ld (xsp+4),xwa
	ld izl,0
	jr L4022
L4019:
	ld xwa,_cars__29
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L4023
	ld xwa,_cars__29
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+4),xwa
	jr L4020
L4023:
L4021:
	inc 1,izl
L4022:
	ld a,izl
	cp a,6
	jr ult,L4019
L4020:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L4024
	jp L4018
L4024:
	ldb (xsp+2),0
	jp L4028
L4025:
	ld wa,0
	ld (xsp+8),a
	call _rnd8__29
	extz wa
	and wa,3
	ld (xsp+1),a
	ld izl,0
	jr L4032
L4029:
	ld xwa,_cars__29
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L4033
	ld xwa,_cars__29
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+4)
	push xwa
	ld a,(xsp+5)
	push xwa
	call _lane_lat__29
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp wa,bc
	jr nz,L4033
	ld xwa,_cars__29
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	ld bc,1450
	ld de,(_car_d__29)
	sub bc,de
	sub bc,400
	sll 4,bc
	cp wa,bc
	jr le,L4033
	ldb (xsp+8),1
L4033:
L4031:
	inc 1,izl
L4032:
	ld a,izl
	cp a,6
	jr ult,L4029
L4030:
	ld a,(xsp+8)
	cp a,0
	jr nz,L4034
	jr L4026
L4034:
L4027:
	incb 1,(xsp+2)
L4028:
	ld a,(xsp+2)
	cp a,3
	jp ult,L4025
L4026:
	ld a,(xsp+2)
	cp a,3
	jr nz,L4035
	jp L4018
L4035:
	ld a,1
	ld xbc,(xsp+4)
	ld (xbc),a
	call _rnd8__29
	extz wa
	exts xwa
	divs xwa,3
	ld wa,qwa
	ld xbc,(xsp+4)
	ld (xbc+1),a
	ld wa,11
	push xwa
	call _rnd8__29
	ld xbc,xwa
	pop xwa
	extz bc
	exts xbc
	divs xbc,5
	ld bc,qbc
	add wa,bc
	ld xbc,(xsp+4)
	ld (xbc+2),a
	ld wa,55
	push xwa
	call _rnd8__29
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
	jr nz,L4036
	ld xwa,(xsp+4)
	ld a,(xwa+3)
	sub a,15
	ld xbc,(xsp+4)
	ld (xbc+3),a
L4036:
	ld a,(xsp+1)
	push xwa
	call _lane_lat__29
	lda xsp,(xsp+4)
	ld xbc,(xsp+4)
	ld (xbc+4),wa
	ld xwa,(xsp+4)
	ld wa,(xwa+4)
	ld xbc,(xsp+4)
	ld (xbc+10),wa
	ld wa,1450
	ld bc,(_car_d__29)
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
L4018:
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
	jp L4065
L4062:
	ld xwa,_cars__29
	ld c,(xsp+0)
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld xiz,xwa
	ld a,(xiz)
	cp a,0
	jr nz,L4066
	jp L4064
L4066:
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
	jr z,L4067
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr ge,L4068
	ld wa,(xiz+4)
	add wa,8
	ld (xiz+4),wa
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr le,L4069
	ld wa,(xiz+10)
	ld (xiz+4),wa
L4069:
	jr L4070
L4068:
	ld wa,(xiz+4)
	sub wa,8
	ld (xiz+4),wa
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr ge,L4071
	ld wa,(xiz+10)
	ld (xiz+4),wa
L4071:
L4070:
	jr L4072
L4067:
	call _rnd8__29
	cp a,2
	jr uge,L4073
	ld wa,(xiz+4)
	push xwa
	call _lane_of__29
	lda xsp,(xsp+4)
	ld (xsp+8),a
	ld a,(xsp+8)
	cp a,0
	jr nz,L4074
	ldb (xsp+8),1
	jr L4075
L4074:
	ld a,(xsp+8)
	cp a,3
	jr nz,L4076
	ldb (xsp+8),2
	jr L4077
L4076:
	push xwa
	call _rnd8__29
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,1
	cp bc,0
	jr z,L4078
	ld a,(xsp+8)
	add a,1
	extz wa
	jr L4079
L4078:
	ld a,(xsp+8)
	sub a,1
	extz wa
L4079:
	ld (xsp+8),a
L4077:
L4075:
	ld a,(xsp+8)
	push xwa
	call _lane_lat__29
	lda xsp,(xsp+4)
	ld (xiz+10),wa
L4073:
L4072:
	ld wa,(xiz+6)
	ld bc,(_car_d__29)
	neg bc
	sll 4,bc
	sub bc,64
	cp wa,bc
	jr lt,L4081
	ld wa,(xiz+6)
	ld bc,1600
	ld de,(_car_d__29)
	sub bc,de
	sll 4,bc
	cp wa,bc
	jr le,L4080
L4081:
	ldb (xiz),0
	jr L4064
L4080:
	incb 1,(xsp+1)
L4064:
	incb 1,(xsp+0)
L4065:
	ld a,(xsp+0)
	cp a,6
	jp ult,L4062
L4063:
	ld a,(_cooldown__29)
	cp a,0
	jr z,L4082
	decb 1,(_cooldown__29)
L4082:
	ld a,(xsp+22)
	cp a,0
	jr z,L4083
	ld a,(xsp+1)
	cp a,(_target__29)
	jr uge,L4083
	ld a,(_cooldown__29)
	cp a,0
	jr nz,L4083
	ld a,(xsp+18)
	cp a,50
	jr ule,L4083
	call _spawn__29
	ld wa,25
	push xwa
	call _rnd8__29
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,31
	add wa,bc
	ld (_cooldown__29),a
	ld a,(_dens_max__29)
	cp a,(_dens_min__29)
	jr ule,L4084
	ld a,(_dens_min__29)
	extz wa
	push xwa
	call _rnd8__29
	ld xbc,xwa
	pop xwa
	extz bc
	exts xbc
	ld e,(_dens_max__29)
	sub e,(_dens_min__29)
	add e,1
	extz de
	divs xbc,de
	ld bc,qbc
	add wa,bc
	ld (_target__29),a
L4084:
L4083:
L4061:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function traffic_collide
_traffic_collide:
	push xiz
	lda xsp,(xsp-12)
	ld iyl,0
	jp L4103
L4100:
	ld xwa,_cars__29
	ld c,iyl
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld xiz,xwa
	ld a,(xiz)
	cp a,0
	jr nz,L4104
	jr L4102
L4104:
	ld bc,(xiz+12)
	cp bc,(xiz+6)
	jr ge,L4105
	ld wa,(xiz+12)
	jr L4106
L4105:
	ld wa,(xiz+6)
L4106:
	ld (xsp+8),wa
	ld bc,(xiz+12)
	cp bc,(xiz+6)
	jr ge,L4107
	ld wa,(xiz+6)
	jr L4108
L4107:
	ld wa,(xiz+12)
L4108:
	ld (xsp+10),wa
	ld wa,(xsp+8)
	cp wa,224
	jr gt,L4110
	ld wa,(xsp+10)
	cp wa,65440
	jr ge,L4109
L4110:
	jr L4102
L4109:
	ld wa,(xiz+4)
	sub wa,(xsp+20)
	ld ix,wa
	ld wa,ix
	cp wa,0
	jr ge,L4111
	ld wa,ix
	neg wa
	ld ix,wa
L4111:
	ld wa,ix
	cp wa,416
	jr ge,L4112
	ld wa,(xiz+6)
	add wa,960
	ld (xiz+6),wa
	ld wa,(xiz+6)
	ld (xiz+12),wa
	ld a,(xiz+3)
	add a,30
	ld (xiz+3),a
	ld wa,1
	jr L4099
L4112:
L4102:
	inc 1,iyl
L4103:
	ld a,iyl
	cp a,6
	jp ult,L4100
L4101:
	ld wa,0
	jr L4099
L4099:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function traffic_draw
_traffic_draw:
	push xiz
	lda xsp,(xsp-64)
	ld wa,0
	ld (xsp+6),a
	ld wa,28
	ld (xsp+9),a
	push xix
	call _id_road_visible_top
	pop xix
	extz wa
	ld (xsp+10),wa
	ld izl,0
	jr L4147
L4144:
	ld xwa,_cars__29
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L4148
	ld a,izl
	lda xbc,(xsp+0)
	ld e,(xsp+6)
	incb 1,(xsp+6)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L4148:
L4146:
	inc 1,izl
L4147:
	ld a,izl
	cp a,6
	jr ult,L4144
L4145:
	ld izl,1
	jp L4152
L4149:
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+12),a
	ld a,izl
	ld ixl,a
	jr L4155
L4153:
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
L4155:
	ld a,ixl
	cp a,0
	jr ule,L4156
	ld xwa,_cars__29
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
	ld xbc,_cars__29
	ld e,(xsp+12)
	extz de
	muls xde,14
	add xbc,xde
	ld bc,(xbc+6)
	cp wa,bc
	jr gt,L4153
L4156:
L4154:
	ld a,(xsp+12)
	lda xbc,(xsp+0)
	ld e,ixl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L4151:
	inc 1,izl
L4152:
	ld a,izl
	cp a,(xsp+6)
	jp ult,L4149
L4150:
	ld izl,0
	jp L4160
L4157:
	ld xwa,_cars__29
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
	ld (xsp+12),xwa
	ld wa,(_car_d__29)
	ld xbc,(xsp+12)
	ld bc,(xbc+6)
	exts xbc
	divs xbc,16
	add wa,bc
	ld (xsp+16),wa
	ld wa,(xsp+16)
	cp wa,0
	jr ge,L4161
	jp L4159
L4161:
	push xix
	ld wa,(xsp+20)
	push xwa
	call _id_road_line_at_distance
	lda xsp,(xsp+4)
	pop xix
	ld (xsp+18),a
	ld a,(xsp+18)
	cp a,255
	jr nz,L4162
	jp L4159
L4162:
	push xix
	lda xwa,(xsp+26)
	push xwa
	ld a,(xsp+26)
	push xwa
	call _id_road_sprite_sample
	lda xsp,(xsp+8)
	pop xix
	ld wa,(xsp+24)
	cp wa,(xsp+10)
	jr ge,L4163
	jp L4159
L4163:
	ld a,(xsp+26)
	extz wa
	sll 5,wa
	extz xwa
	ld c,(_half_wheel__29)
	extz bc
	div xwa,bc
	ld (xsp+20),a
	ld a,(xsp+20)
	cp a,28
	jr ult,L4164
	ldb (xsp+19),0
	jr L4165
L4164:
	ld a,(xsp+20)
	cp a,20
	jr ult,L4166
	ldb (xsp+19),1
	jr L4167
L4166:
	ld a,(xsp+20)
	cp a,13
	jr ult,L4168
	ldb (xsp+19),2
	jr L4169
L4168:
	ld a,(xsp+20)
	cp a,9
	jr ult,L4170
	ldb (xsp+19),3
	jr L4171
L4170:
	ldb (xsp+19),4
L4171:
L4169:
L4167:
L4165:
	ld xwa,_gfx_traffic_frames
	ld xbc,(xsp+12)
	ld c,(xbc+1)
	extz bc
	mul xbc,5
	ld e,(xsp+19)
	extz de
	add bc,de
	extz bc
	exts xbc
	sll 3,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+28),xwa
	ld wa,(xsp+22)
	ld xbc,(xsp+12)
	ld bc,(xbc+4)
	sra 4,bc
	ld e,(xsp+26)
	extz de
	mul xbc,de
	exts xbc
	ld e,(_half_wheel__29)
	extz de
	divs xbc,de
	add wa,bc
	ld (xsp+38),wa
	ld wa,(xsp+38)
	ld xbc,(xsp+28)
	ld c,(xbc+6)
	extz bc
	srl 1,bc
	sub wa,bc
	ld (xsp+36),wa
	ld wa,(xsp+24)
	cp wa,151
	jr le,L4172
	jp L4159
L4172:
	ld wa,(xsp+24)
	add wa,1
	ld xbc,(xsp+28)
	ld c,(xbc+1)
	extz bc
	sll 3,bc
	sub wa,bc
	ld (xsp+40),a
	ld xwa,_gfx_traffic_cells
	ld xbc,(xsp+28)
	ld bc,(xbc+4)
	mul xbc,3
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+42),xwa
	ld wa,0
	exts xwa
	ld (xsp+46),xwa
	ld wa,(_trf_tiles__29)
	ld (xsp+50),wa
	ld wa,(xsp+36)
	ld (xsp+52),wa
	ld a,(xsp+40)
	ld (xsp+54),a
	ld xwa,(xsp+28)
	ld a,(xwa+2)
	ld (xsp+55),a
	ldb (xsp+56),0
	ld a,(_id_spr_priority)
	ld (xsp+57),a
	ld xwa,(xsp+12)
	ld a,(xwa+2)
	ld (xsp+58),a
	ld a,(xsp+9)
	ld (xsp+59),a
	ldb (xsp+60),50
	ldb (xsp+61),0
	ldb (xsp+62),0
	push xix
	lda xwa,(xsp+46)
	push xwa
	call _spr_cells_asm
	lda xsp,(xsp+4)
	pop xix
	ld a,(xsp+59)
	ld (xsp+9),a
L4159:
	inc 1,izl
L4160:
	ld a,izl
	cp a,(xsp+6)
	jp ult,L4157
L4158:
	push xix
	ld a,50
	push xwa
	ld a,(xsp+17)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xix
L4143:
	lda xsp,(xsp+64)
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
	jp L4195
L4192:
	push xix
	push xiy
	ld a,iyl
	push xwa
	call _lane_lat__29
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (xsp+6),wa
	ld wa,32767
	ld (xsp+8),wa
	ld izl,0
	jp L4199
L4196:
	ld xwa,_cars__29
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L4201
	ld xwa,_cars__29
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	cp wa,65280
	jr ge,L4200
L4201:
	jr L4198
L4200:
	ld xwa,_cars__29
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+4)
	sub wa,(xsp+6)
	ld ix,wa
	ld wa,ix
	cp wa,0
	jr ge,L4202
	ld wa,ix
	neg wa
	ld ix,wa
L4202:
	ld wa,ix
	cp wa,480
	jr ge,L4203
	ld xwa,_cars__29
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	cp wa,(xsp+8)
	jr ge,L4203
	ld xwa,_cars__29
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	ld (xsp+8),wa
L4203:
L4198:
	inc 1,izl
L4199:
	ld a,izl
	cp a,6
	jp ult,L4196
L4197:
	ld wa,(xsp+8)
	cp wa,(xsp+4)
	jr gt,L4205
	ld wa,(xsp+8)
	cp wa,(xsp+4)
	jr nz,L4204
	ld wa,(xsp+24)
	cp wa,0
	jr ge,L4207
	ld a,iyl
	cp a,0
	jr z,L4206
L4207:
	ld wa,(xsp+24)
	cp wa,0
	jr le,L4204
	ld a,iyl
	cp a,3
	jr nz,L4204
L4206:
L4205:
	ld wa,(xsp+8)
	ld (xsp+4),wa
	ld a,iyl
	ld (xsp+2),a
L4204:
L4194:
	inc 1,iyl
L4195:
	ld a,iyl
	cp a,4
	jp ult,L4192
L4193:
	ld wa,(xsp+4)
	cp wa,14400
	jr le,L4208
	ld wa,(xsp+24)
	cp wa,0
	jr z,L4208
	ld wa,(xsp+24)
	jr L4191
L4208:
	push xix
	push xiy
	ld a,(xsp+10)
	push xwa
	call _lane_lat__29
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	jr L4191
L4191:
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
_extend_time__0:
	db 70,58,56,54,52
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
	db 67,79,78,71,82,65,84,85,76,65,84,73,79,78,83,0
_S0_5:
	db 71,79,65,76,33,0
_S0_6:
	db 69,88,84,69,78,68,69,68,32,80,76,65,89,0
_S0_7:
	db 67,72,69,67,75,80,79,73,78,84,33,0
_lv__0_L331:
	db 1,2,3,4,4,4,4,3,3,2,1,0
_S0_8:
	db 85,80,58,76,79,87,32,32,68,79,87,78,58,72,73,71
	db 72,0
_S0_9:
	db 79,78,32,84,72,69,32,82,79,65,68,32,65,71,65,73
	db 78,0
_S0_10:
	db 72,73,0
_S0_11:
	db 80,82,69,83,83,32,65,32,84,79,32,83,84,65,82,84
	db 0
_S0_12:
	db 89,79,85,32,77,65,68,69,32,73,84,33,0
_S0_13:
	db 71,65,77,69,32,79,86,69,82,0
_S0_14:
	db 83,67,79,82,69,0
_S0_15:
	db 82,79,85,84,69,0
_S0_16:
	db 78,69,87,32,72,73,71,72,32,83,67,79,82,69,33,0
	align 2
_smoke_tiles__0:
	db 90,0,175,6,255,26,255,107,255,107,255,26,170,5,85,0
	db 0,148,0,233,64,250,144,254,165,255,164,254,80,170,0,85
	db 5,0,107,1,255,6,255,27,255,111,255,107,170,22,85,1
	db 0,148,0,229,64,250,144,255,144,255,149,254,80,170,0,85
_smoke_slot__0:
	db 1,125,126,127
_S0_17:
	db 80,65,85,83,69,0
_S0_18:
	db 84,73,77,69,32,85,80,0
_S0_19:
	db 98,32,76,69,70,84,32,32,32,32,82,73,71,72,84,32
	db 99,0
_S0_20:
	db 82,73,71,72,84,32,99,0
_S0_21:
	db 98,32,76,69,70,84,0
_S0_22:
	db 71,79,65,76,32,65,72,69,65,68,0
_S0_23:
	db 51,0
_S0_24:
	db 50,0
_S0_25:
	db 49,0
_S0_26:
	db 71,79,33,0
	align 2
_cd__0_L654:
	dd _S0_23
	dd _S0_24
	dd _S0_25
	dd _S0_26
_S0_27:
	db 83,84,65,82,84,0
_S0_28:
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
	db 25,0,0,0,153,10,255,15,153,10,170,11,204,13,255,15
	db 2,3
	dd _leg1_seg__1
	db 26,1,3,5,136,9,255,15,136,9,153,10,187,12,255,15
	db 3,4
	dd _leg2_seg__1
	db 27,5,2,3,152,10,255,15,152,10,169,11,203,13,255,15
	db 3,4
	dd _leg3_seg__1
	db 28,6,4,4,104,9,223,10,104,9,121,10,155,11,223,11
	db 4,5
	dd _leg4_seg__1
	db 25,3,1,3,154,8,255,14,154,8,171,9,205,11,255,14
	db 4,5
	dd _leg5_seg__1
	db 25,2,7,6,152,8,255,15,152,8,169,9,203,11,255,15
	db 4,5
	dd _leg6_seg__1
	db 28,4,8,10,137,8,255,15,137,8,154,9,188,11,255,15
	db 5,6
	dd _leg7_seg__1
	db 31,9,3,5,120,7,255,15,120,7,137,8,171,10,255,15
	db 5,6
	dd _leg8_seg__1
	db 27,10,2,2,153,11,255,15,153,11,170,12,204,14,255,15
	db 5,6
	dd _leg9_seg__1
	db 28,11,7,5,153,8,255,15,153,8,170,9,204,11,255,15
	db 5,6
	dd _leg10_seg__1
	db 31,12,9,9,119,8,255,15,119,8,136,9,170,11,255,15
	db 6,7
	dd _leg11_seg__1
	db 32,8,3,3,137,7,255,14,137,7,154,8,188,10,255,14
	db 6,7
	dd _leg12_seg__1
	db 28,7,9,7,136,10,238,15,136,10,153,11,187,13,238,15
	db 6,7
	dd _leg13_seg__1
	db 30,13,0,6,153,10,255,15,153,10,170,11,204,13,255,15
	db 6,7
	dd _leg14_seg__1
	db 26,14,4,5,153,8,255,14,153,8,170,9,204,11,255,14
	db 6,7
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
	db 85,85,85,85,85,85,85,85,85,85,245,85,253,215,255,255
	db 85,85,85,85,85,85,85,85,85,85,85,85,85,85,85,93
	db 85,85,85,85,125,85,255,85,170,106,170,106,85,85,85,85
	db 213,85,245,87,255,95,255,255,170,170,170,170,85,85,85,85
	db 213,95,213,127,247,255,255,255,170,170,170,170,85,85,85,85
	db 85,85,85,125,85,255,213,255,170,170,170,170,85,85,85,85
	db 85,85,85,85,85,85,85,85,85,165,87,165,95,85,255,255
	db 85,85,85,85,85,85,85,85,95,85,127,245,255,253,255,255
	db 85,85,85,85,85,85,85,85,125,213,255,213,255,255,255,255
	db 191,254,255,255,255,255,170,170,170,170,85,85,85,85,85,85
	db 165,234,253,250,255,255,170,170,170,170,85,85,85,85,85,85
	db 85,85,89,89,149,213,102,255,170,255,170,170,170,170,170,170
	db 85,85,89,89,149,149,102,102,170,170,170,170,170,170,170,170
	db 127,85,127,89,149,149,102,102,170,170,170,170,170,170,170,170
	db 255,255,255,255,149,149,102,102,170,170,170,170,170,170,170,170
	db 255,255,255,255,223,149,255,127,255,191,170,170,170,170,170,170
	db 171,190,175,255,255,255,170,170,170,170,85,85,85,85,85,85
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,170,170,170
	db 85,85,85,85,85,85,85,85,85,85,89,89,149,149,102,102
	db 85,85,85,85,85,85,85,85,85,85,89,89,181,149,255,111
	db 85,85,85,85,85,85,85,85,85,85,89,89,149,149,102,230
	db 170,170,170,170,170,170,175,170,255,170,255,171,255,175,255,175
	db 175,170,255,170,255,175,255,255,255,255,255,255,255,255,255,255
	db 170,254,235,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,254,255
	db 85,253,85,255,85,251,85,250,85,250,85,250,85,250,85,170
	db 170,170,170,170,170,170,170,170,170,170,170,170,191,170,255,171
	db 170,170,170,170,170,170,170,170,170,170,254,255,255,255,255,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,171,250,175,255
	db 170,170,170,170,170,170,170,170,255,170,255,191,255,255,255,255
	db 170,170,170,170,170,170,170,170,234,255,255,255,255,255,255,255
	db 170,170,170,170,170,170,170,170,170,170,170,170,170,250,170,254
	db 170,170,170,170,191,170,255,171,255,175,255,191,255,255,255,255
	db 170,170,170,170,255,255,255,255,255,255,255,255,255,255,255,255
	db 170,170,170,170,255,191,255,255,255,255,255,255,255,255,255,255
	db 85,85,85,85,85,245,85,255,245,255,253,255,239,255,251,255
	db 255,95,255,91,255,90,191,90,170,86,171,85,111,85,85,213
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 255,255,255,255,253,255,234,255,255,255,255,255,255,255,255,255
	db 85,233,85,229,85,85,87,149,87,253,223,255,255,255,255,255
	db 255,175,255,191,255,255,255,255,255,255,255,255,255,255,255,255
	db 213,239,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 85,85,85,213,85,255,213,255,245,254,189,255,239,255,255,255
	db 254,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
	db 87,245,95,181,127,173,127,237,255,233,255,237,255,237,255,237
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,239,255
	db 255,255,255,255,255,255,255,255,175,255,170,254,170,250,90,250
	db 255,255,255,255,255,255,255,255,255,255,255,175,255,175,255,175
	db 255,255,255,255,255,255,255,255,255,255,254,255,250,255,234,255
	db 255,233,255,233,191,233,191,165,175,149,111,149,107,85,90,85
	db 255,255,255,255,255,255,255,255,255,255,254,255,254,255,254,255
	db 170,254,170,234,154,234,85,233,85,213,85,149,85,149,85,149
	db 255,255,255,175,191,170,170,170,170,90,106,85,85,85,85,85
	db 255,255,255,255,255,255,255,191,255,175,255,171,191,106,175,90
	db 85,249,85,229,85,165,85,165,85,165,85,149,85,85,85,85
	db 255,95,255,95,255,95,170,90,170,90,170,90,170,86,170,85
	db 255,255,255,255,254,255,170,170,170,170,169,170,165,170,149,170
	db 254,255,250,255,234,255,170,255,165,250,85,169,85,149,85,85
	db 175,170,171,170,170,170,106,170,85,85,85,85,85,85,85,85
	db 255,175,255,170,171,170,170,170,170,86,90,85,85,85,85,85
	db 255,255,255,255,250,255,170,170,170,170,165,170,85,85,85,85
	db 255,255,171,234,170,170,170,170,86,149,85,85,85,85,149,87
	db 255,255,255,255,255,255,170,170,170,170,170,170,170,106,170,90
	db 255,255,255,255,255,255,170,170,170,170,170,170,170,170,170,174
	db 254,255,254,255,254,255,170,170,170,170,169,170,165,170,149,170
	db 170,234,170,234,170,234,170,170,170,170,170,170,165,170,85,170
	db 170,170,170,170,170,170,170,170,170,170,170,166,86,85,85,85
	db 171,86,106,85,90,85,86,85,85,85,85,85,85,85,85,85
	db 255,255,255,191,255,175,170,170,170,106,170,90,170,86,122,85
	db 255,255,255,255,255,255,170,170,170,170,170,170,170,170,165,170
	db 85,93,117,85,93,85,85,85,85,85,85,85,85,85,0,0
	db 85,85,85,85,85,213,85,87,93,85,85,85,85,85,0,0
	db 149,87,165,87,165,215,169,87,169,87,85,85,85,85,0,0
	db 85,94,149,94,149,222,165,94,173,94,85,85,85,85,0,0
	db 121,93,122,85,122,85,122,85,122,85,85,85,85,85,0,0
	db 85,85,85,85,85,213,85,151,93,149,85,85,85,85,0,0
_pano_beach_map:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,2,0,0,0,0,0,0,0,3,4,5,6,7,8,9
	db 1,2,0,0,0,0,0,0,0,3,4,5,6,7,8,9
	db 10,11,12,13,13,13,13,13,13,13,13,13,14,15,16,17
	db 10,11,12,13,13,13,13,13,13,13,13,13,14,15,16,17
	db 18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18
	db 18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18
	db 19,19,19,19,19,19,19,20,21,19,19,19,19,19,19,19
	db 19,19,19,19,19,19,19,20,21,19,19,19,19,19,19,19
	db 18,18,18,18,22,23,24,25,26,27,28,29,30,31,32,18
	db 18,18,18,18,22,23,24,25,26,27,28,29,30,31,32,18
	db 33,34,35,36,37,38,38,39,40,41,38,38,38,38,42,43
	db 33,34,35,36,37,38,38,39,40,41,38,38,38,38,42,43
	db 38,38,38,44,45,38,38,38,38,38,38,46,38,38,38,38
	db 38,38,38,44,45,38,38,38,38,38,38,46,38,38,38,38
	db 47,48,38,49,50,38,38,38,38,38,51,52,53,54,38,38
	db 47,48,38,49,50,38,38,38,38,38,51,52,53,54,38,38
	db 55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70
	db 55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70
	db 71,72,71,72,71,72,71,73,71,74,71,72,71,72,75,76
	db 71,72,71,72,71,72,71,73,71,74,71,72,71,72,75,76
_pano_beach_map_pal:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 6,6,0,0,0,0,0,0,0,6,6,6,6,6,6,6
	db 6,6,0,0,0,0,0,0,0,6,6,6,6,6,6,6
	db 7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,7
	db 7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,7
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,2,2,1,1,1,1,1,1,1
	db 1,1,1,1,1,1,1,2,2,1,1,1,1,1,1,1
	db 1,1,1,2,2,1,1,2,2,1,1,1,1,1,2,2
	db 1,1,1,2,2,1,1,2,2,1,1,1,1,1,2,2
	db 1,1,1,2,2,1,1,1,1,1,1,2,1,1,1,1
	db 1,1,1,2,2,1,1,1,1,1,1,2,1,1,1,1
	db 2,2,1,2,2,1,1,1,1,1,2,2,2,2,1,1
	db 2,2,1,2,2,1,1,1,1,1,2,2,2,2,1,1
	db 2,2,2,3,3,4,2,2,2,2,2,3,3,2,2,2
	db 2,2,2,3,3,4,2,2,2,2,2,3,3,2,2,2
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	db 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	align 2
_pano_beach_pals:
	db 223,11,129,14,162,15,202,14,223,11,162,15,180,15,255,15
	db 223,11,180,15,202,14,255,15,223,11,162,5,199,15,202,14
	db 223,11,162,5,202,14,255,15,223,11,112,11,79,10,255,15
	db 223,11,129,14,202,14,255,15,223,11,162,15,202,14,255,15
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
	db 77,0
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
_song0_v0__7:
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
_song0_v1__7:
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
_song0_v2__7:
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
_song0_v3__7:
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
_song1_v0__7:
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
_song1_v1__7:
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
_song1_v2__7:
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
_song1_v3__7:
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
_song2_v0__7:
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
_song2_v1__7:
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
_song2_v2__7:
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
_song2_v3__7:
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
_song3_v0__7:
	db 255,240,0
_song3_v1__7:
	db 255,240,0
_song3_v2__7:
	db 255,240,0
_song3_v3__7:
	db 255,240,0
_song4_v0__7:
	db 244,10,240,4,37,14,42,14,46,28,44,14,42,14,37,28
	db 39,14,42,14,47,28,46,14,42,14,39,28,41,14,44,14
	db 49,28,47,14,44,14,41,28,42,56,37,28,42,28,46,14
	db 42,14,39,28,42,14,46,14,51,28,47,14,46,14,44,14
	db 42,14,39,28,42,28,44,14,41,14,37,14,41,14,44,28
	db 47,28,46,56,42,56,0
_song4_v1__7:
	db 244,6,240,6,6,14,18,14,6,14,18,14,6,14,18,14
	db 6,14,18,14,11,14,23,14,11,14,23,14,11,14,23,14
	db 11,14,23,14,1,14,13,14,1,14,13,14,1,14,13,14
	db 1,14,13,14,6,14,18,14,6,14,18,14,6,14,18,14
	db 6,14,18,14,3,14,15,14,3,14,15,14,3,14,15,14
	db 3,14,15,14,11,14,23,14,11,14,23,14,11,14,23,14
	db 11,14,23,14,1,14,13,14,1,14,13,14,1,14,13,14
	db 1,14,13,14,6,14,18,14,6,14,18,14,6,14,18,14
	db 6,14,18,14,0
_song4_v2__7:
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
_song4_v3__7:
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
_song5_v0__7:
	db 244,10,240,4,34,32,33,32,32,32,31,32,30,128,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,240,0
_song5_v1__7:
	db 244,6,240,6,3,128,3,128,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,240,255,240
	db 0
_song5_v2__7:
	db 244,13,240,8,18,128,15,128,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,240,255,240
	db 0
_song5_v3__7:
	db 244,1,240,5,3,128,255,128,255,240,255,240,255,240,255,240
	db 255,240,255,240,255,240,255,240,255,240,255,240,255,240,255,240
	db 0
	align 2
_music_songs:
	dd _song0_v0__7
	dd _song0_v1__7
	dd _song0_v2__7
	dd _song0_v3__7
	db 1,0
	dd _song1_v0__7
	dd _song1_v1__7
	dd _song1_v2__7
	dd _song1_v3__7
	db 1,0
	dd _song2_v0__7
	dd _song2_v1__7
	dd _song2_v2__7
	dd _song2_v3__7
	db 1,0
	dd _song3_v0__7
	dd _song3_v1__7
	dd _song3_v2__7
	dd _song3_v3__7
	db 1,0
	dd _song4_v0__7
	dd _song4_v1__7
	dd _song4_v2__7
	dd _song4_v3__7
	db 1,0
	dd _song5_v0__7
	dd _song5_v1__7
	dd _song5_v2__7
	dd _song5_v3__7
	db 0,0
_z80drv__8:
	db 195,19,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,243,49,0,16,58,3,0,183,40,250,71,33,4
	db 0,126,50,1,64,50,0,64,35,126,50,1,64,50,0,64
	db 35,126,50,1,64,50,0,64,35,16,230,175,50,3,0,24
	db 214
_inst_tab__8:
	db 6,4,1,15,1,15,2,15,7,3,5,3,2,9,6,4
	db 3,8,2,12,8,3,8,3,5,5,3,6,5,5,2,12
	db 2,12,6,4
	align 2
_overrev_dash_tiles__11:
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
_S15_0:
	db 65,85,84,79,66,65,72,78,32,65,67,69,0
_S15_1:
	db 84,79,80,32,83,80,69,69,68,44,32,84,79,80,32,82
	db 65,78,75,33,0
_S15_2:
	db 67,65,78,89,79,78,32,67,79,78,81,85,69,82,79,82
	db 0
_S15_3:
	db 78,79,84,72,73,78,71,32,83,84,79,80,83,32,89,79
	db 85,33,0
_S15_4:
	db 76,65,75,69,83,73,68,69,32,68,82,69,65,77,0
_S15_5:
	db 65,32,80,69,82,70,69,67,84,32,83,85,78,83,69,84
	db 32,82,85,78,0
_S15_6:
	db 83,69,65,83,73,68,69,32,80,65,82,84,89,0
_S15_7:
	db 84,72,69,32,84,79,87,78,32,67,72,69,69,82,83,32
	db 89,79,85,33,0
_S15_8:
	db 76,69,71,69,78,68,32,79,70,32,84,72,69,32,82,85
	db 73,78,0
_S15_9:
	db 84,72,69,32,65,78,67,73,69,78,84,32,67,85,80,33
	db 0
	align 2
_endings__15:
	dd _S15_0
	dd _S15_1
	db 68,4,170,10,255,15,2,0
	dd _S15_2
	dd _S15_3
	db 36,0,123,3,207,8,1,0
	dd _S15_4
	dd _S15_5
	db 66,9,199,15,254,15,3,0
	dd _S15_6
	dd _S15_7
	db 70,0,189,2,255,9,4,0
	dd _S15_8
	dd _S15_9
	db 4,1,61,3,175,10,1,0
_dir_x__15:
	db 16,11,0,245,240,245,0,11
_dir_y__15:
	db 0,245,240,245,0,11,16,11
_pals__15_L1434:
	db 1,2,9,10
	align 2
_gfx_font_tiles__22:
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
_S22_0:
	db 84,73,77,69,0
_S22_1:
	db 83,84,65,71,69,0
_S22_2:
	db 75,77,47,72,0
_S22_3:
	db 72,73,71,72,0
_S22_4:
	db 32,76,79,87,0
_hill_rate__26:
	db 64,65,67,69,71,73,75,77,80,82,85,88,91,94,98,102
	db 106,111,116,121,128,134,140,147,153,160,166,172,179,185,192,198
	db 204,211,217,224,230,236,243,249,255
	align 2
_course_sol__26:
	db 82,0,51,3,85,5,255,15,255,255,51,3,51,3,102,6
	db 153,9
_course_horizon__26:
	db 0
_band_lut__26:
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
	db 64,66,15,0
	db 15
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
	dd _buf__14
	db 23,90
	db 255
	db 255
	db 255
	db 255
	db 255
	db 255
	db 24
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
	db 0
	dd _id_xy_a__26
	dd _id_xy_b__26
	dd _id_bandcol_a__26
	db 2
	db 0
	db 255,255,255,255
	db 43,29
__DataROM_END:
__Bss_START equ 04000h
__Bss_END equ 0556Bh
__DataRAM_START equ 0556Ch
__RAM_END equ 055BAh
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
_dbg_updates equ 040B8h
_dbg_crashes equ 040BAh
_dbg_scn equ 040BBh
_dbg_off equ 040BCh
_grade_tab__0 equ 040BDh
_smoke_t__0 equ 040CAh
_eng_phase__0 equ 040CBh
_voice__8 equ 040CCh
_playing__8 equ 04114h
_last_vbl__8 equ 04115h
_want_div__8 equ 04116h
_want_attn__8 equ 0411Eh
_sent_div__8 equ 04122h
_sent_attn__8 equ 0412Ah
_noise_trig__8 equ 0412Eh
_sfx_frames__8 equ 0412Fh
_sfx_div__8 equ 04134h
_sfx_step__8 equ 0413Ch
_sfx_attn__8 equ 04140h
_sfx_decay__8 equ 04144h
_sfx_age__8 equ 04148h
_eng_div__8 equ 0414Ch
_eng_on__8 equ 0414Eh
_b_on__9 equ 0414Fh
_b_r0__9 equ 04150h
_b_r1__9 equ 04151h
_b_c0__9 equ 04152h
_b_c1__9 equ 04153h
_b_foot__9 equ 04154h
_b_spr__9 equ 04155h
_car_d__9 equ 04156h
_s_repeat_timer__10 equ 04158h
_g_vb_hook__11 equ 04160h
_s_cmd_type__13 equ 04164h
_s_cmd_dst__13 equ 04174h
_s_cmd_len__13 equ 04194h
_s_cmd_src__13 equ 041B4h
_s_cmd_fill__13 equ 041F4h
_s_cmd_count__13 equ 04214h
_s_drop_count__13 equ 04215h
_s_lock__13 equ 04216h
_buf__14 equ 04218h
_track_len equ 043C8h
_cur_stage equ 043C9h
_cur_branch equ 043CAh
_cur_leg equ 043CBh
_leg_len equ 043CCh
_fork_choice equ 043CEh
_route_hist equ 043CFh
_n_cur__14 equ 043D4h
_px__15 equ 043D6h
_py__15 equ 043F2h
_vx__15 equ 0440Eh
_vy__15 equ 0442Ah
_life__15 equ 04446h
_ptile__15 equ 04454h
_ppal__15 equ 04462h
_fx__15 equ 04470h
_timer__15 equ 04471h
_s_done_cb__16 equ 04472h
_s_done_flag__16 equ 04482h
_s_was_active__16 equ 04486h
_s_rearm_enabled__16 equ 0448Ah
_s_rearm_elem__16 equ 0448Eh
_s_rearm_vector__16 equ 04492h
_s_rearm_count__16 equ 04496h
_s_rearm_dst__16 equ 0449Eh
_s_rearm_src__16 equ 044AEh
_h_score__22 equ 044BEh
_h_score_ok__22 equ 044C5h
_s_dig__22 equ 044C6h
_body__25 equ 044CEh
_car_variant__25 equ 044EEh
_car_wheel_dx__25 equ 044EFh
_car_tile_base__25 equ 044F0h
_lean_hold__25 equ 044F2h
_lean_side__25 equ 044F3h
_lean_wait__25 equ 044F4h
_bump_phase__25 equ 044F5h
_car_last_x__25 equ 044F6h
_car_last_top__25 equ 044F8h
_art__26 equ 044FAh
_road_course__26 equ 04512h
_road_grade__26 equ 04513h
_band_pitch__26 equ 04514h
_climb_room__26 equ 04516h
_descent_room__26 equ 04517h
_band_shift__26 equ 04518h
_id_xy_a__26 equ 0451Ah
_id_xy_b__26 equ 0464Ch
_id_xy_done__26 equ 0477Eh
_id_xy_last__26 equ 04782h
_id_raster__26 equ 04786h
_id_shear__26 equ 0479Ah
_id_sl__26 equ 0481Ah
_id_bandcol_a__26 equ 048DAh
_id_bandcol_b__26 equ 04A0Ch
_bc_top__26 equ 04B3Eh
_id_bandcol_done__26 equ 04B40h
_id_bandstream__26 equ 04B44h
_band_phase__26 equ 04B52h
_id_dxc__26 equ 04B54h
_id_w_lat__26 equ 04C54h
_id_w_curve__26 equ 04C94h
_id_half__26 equ 04CD4h
_id_src__26 equ 04D14h
_band_top__26 equ 04D54h
_band_mid__26 equ 04D58h
_band_tree__26 equ 04D5Ch
_band_bg_first__26 equ 04D60h
_id_buf__26 equ 04D62h
_pan_head__26 equ 04D64h
_pan_lat__26 equ 04D66h
_pan_fine__26 equ 04D68h
_band_held__26 equ 04D69h
_band_wait__26 equ 04D6Ah
_id_ahead__26 equ 04D6Ch
_id_curve_cm__26 equ 04DECh
_wide_k0__26 equ 04DEEh
_rally_of__26 equ 04DEFh
_rally_src__26 equ 04FF0h
_rally_used__26 equ 051EEh
_rally_scanned__26 equ 051EFh
_band_col__26 equ 051F0h
_road_dma_live__26 equ 051F8h
_road_dma_depth__26 equ 051F9h
_id_curve_dx__26 equ 051FAh
_scn_phase__27 equ 0527Ah
_scn_frac__27 equ 0527Ch
_scn_passed__27 equ 0527Eh
_scn_mode__27 equ 0527Fh
_pano_base__28 equ 05280h
_obj_base__28 equ 05282h
_obj_end__28 equ 05284h
_pano_end__28 equ 05286h
_objmap__28 equ 05288h
_kind_l__28 equ 05488h
_kind_r__28 equ 05489h
_cur_pals__28 equ 0548Ah
_cur_backdrop__28 equ 054CAh
_cur_road__28 equ 054CCh
_cur_band__28 equ 054D4h
_cur_spr__28 equ 054DCh
_next_slot__28 equ 0550Ch
_cars__29 equ 0550Eh
_trf_tiles__29 equ 05562h
_car_d__29 equ 05564h
_half_wheel__29 equ 05566h
_dens_min__29 equ 05567h
_dens_max__29 equ 05568h
_target__29 equ 05569h
_cooldown__29 equ 0556Ah
_car_tuned__0 equ 0556Ch
_hiscore__0 equ 0557Ah
_eng_attn__8 equ 0557Eh
_ngpc_pad_held equ 0557Fh
_ngpc_pad_pressed equ 05580h
_ngpc_pad_released equ 05581h
_ngpc_pad_repeat equ 05582h
_s_pad_prev__10 equ 05583h
_s_repeat_delay__10 equ 05584h
_s_repeat_rate__10 equ 05585h
_s_vbl_down__10 equ 05586h
_s_vbl_prev__10 equ 05587h
_g_vb_counter equ 05588h
_s_is_color__11 equ 05589h
_s_language__11 equ 0558Ah
_s_power_hold__12_L1224 equ 0558Bh
_track_seg equ 0558Ch
_seed__15 equ 05590h
_cur_song__18 equ 05592h
_h_time__22 equ 05593h
_h_kmh__22 equ 05594h
_h_gear__22 equ 05595h
_h_prog__22 equ 05596h
_h_stage__22 equ 05597h
_id_spr_priority equ 05598h
_car_stand__26 equ 05599h
_grade_hi__26 equ 0559Ah
_grade_lo__26 equ 0559Bh
_band_first__26 equ 0559Ch
_band_count__26 equ 0559Dh
_band_bg_end__26 equ 0559Eh
_road_top__26 equ 055A0h
_road_plane0__26 equ 055A1h
_road_bottom__26 equ 055A2h
_road_lines__26 equ 055A3h
_road_base_x__26 equ 055A4h
_id_xy__26 equ 055A6h
_id_xy_live__26 equ 055AAh
_id_bandcol__26 equ 055AEh
_road_band_pal__26 equ 055B2h
_bc_rest__26 equ 055B4h
_rng__29 equ 055B8h

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

; function smoke_init
_smoke_init__0:
	push xiz
	lda xsp,(xsp-2)
	ld ixl,0
	jr L834
L831:
	ld izl,0
	jr L838
L835:
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
L837:
	inc 1,izl
L838:
	ld a,izl
	cp a,8
	jr ult,L835
L836:
L833:
	inc 1,ixl
L834:
	ld a,ixl
	cp a,4
	jr ult,L831
L832:
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
L830:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function smoke_draw
_smoke_draw__0:
	push xiz
	lda xsp,(xsp-24)
	ld a,(xsp+32)
	cp a,0
	jr nz,L862
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
	jp L861
L862:
	ld a,(_smoke_t__0)
	extz wa
	and wa,7
	cp wa,0
	jr nz,L863
	ld a,(xsp+36)
	cp a,0
	jr nz,L863
	push xix
	push xiy
	ld wa,7
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L863:
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
	jp L867
L864:
	ld c,ixl
	cp c,0
	jr nz,L868
	ld wa,(xsp+0)
	sub wa,11
	ld c,(_smoke_t__0)
	extz bc
	sra 2,bc
	and bc,1
	sub wa,bc
	jr L869
L868:
	ld wa,(xsp+0)
	add wa,27
	ld c,(_smoke_t__0)
	extz bc
	sra 2,bc
	and bc,1
	add wa,bc
L869:
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
	jp L873
L870:
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
	jr z,L874
	ld a,1
	sub a,izl
	extz wa
	jr L875
L874:
	ld a,izl
	extz wa
L875:
	ld (xsp+9),a
	ld wa,(xsp+6)
	ld c,izl
	extz bc
	sll 3,bc
	add wa,bc
	ld (xsp+10),wa
	ld wa,(xsp+10)
	cp wa,65529
	jr lt,L877
	ld wa,(xsp+10)
	cp wa,159
	jr le,L876
L877:
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
	jp L872
L876:
L878:
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
	jr z,L881
	ld wa,128
	jr L882
L881:
	ld wa,0
L882:
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
L880:
L879:
L872:
	inc 1,izl
L873:
	ld a,izl
	cp a,2
	jp ult,L870
L871:
L866:
	inc 1,ixl
L867:
	ld a,ixl
	cp a,2
	jp ult,L864
L865:
L861:
	lda xsp,(xsp+24)
	pop xiz
	ret

; function engine_sound
_engine_sound__0:
	push xiz
	lda xsp,(xsp-10)
	ld c,(_gear__0)
	cp c,0
	jr nz,L898
	ld wa,137
	jr L899
L898:
	ld wa,224
L899:
	ld (xsp+0),wa
	ld a,(_speed__0)
	extz wa
	mul xwa,255
	extz xwa
	div xwa,(xsp+0)
	ld ix,wa
	ld wa,ix
	cp wa,255
	jr ule,L900
	ld ix,255
L900:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L901
	ld ix,0
L901:
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
	jr z,L902
	ld wa,iz
	ld bc,iz
	ld l,(_offroad__0)
	cp l,0
	jr z,L903
	ld l,(_speed__0)
	cp l,20
	jr ule,L903
	ld de,3
	jr L904
L903:
	ld de,5
L904:
	cp e,0
	jr z,L906
L905:
	srl 1,bc
	djnz e,L905
L906:
	add wa,bc
	ld iz,wa
L902:
	ld c,(_ngpc_pad_held)
	extz bc
	and bc,16
	cp bc,0
	jr z,L907
	ld wa,4
	jr L908
L907:
	ld wa,6
L908:
	ld iyl,a
	ld a,(_state__0)
	cp a,4
	jr z,L910
	ld a,(_state__0)
	cp a,3
	jr nz,L909
L910:
	ld iyl,9
L909:
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
L897:
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
	jr ult,L932
	ldb (xsp+0),11
L932:
	ld a,(_roll_kind__0)
	cp a,0
	jr z,L933
	ld a,(xsp+0)
	add a,12
	ld (xsp+0),a
	jr L934
L933:
	ld a,(_roll_dir__0)
	cp a,0
	jr nz,L935
	ld wa,12
	ld c,(xsp+0)
	extz bc
	sub wa,bc
	exts xwa
	divs xwa,12
	ld wa,qwa
	ld (xsp+0),a
L935:
L934:
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
	jp z,L936
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
	jr L940
L937:
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
L939:
	incw 1,(xsp+16)
L940:
	ld wa,(xsp+16)
	cp wa,(xsp+14)
	jr ult,L937
L938:
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
L936:
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
	jr z,L941
	ld a,(xsp+1)
	extz wa
	ld c,(xsp+1)
	extz bc
	sra 1,bc
	add wa,bc
	ld (xsp+1),a
L941:
	ld wa,136
	ld c,(xsp+1)
	extz bc
	sub wa,bc
	ld (xsp+10),wa
	ld izl,0
	jp L945
L942:
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
	jr lt,L947
	ld wa,(xsp+18)
	cp wa,159
	jr gt,L947
	ld wa,iy
	cp wa,65529
	jr lt,L947
	ld wa,iy
	cp wa,151
	jr le,L946
L947:
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
	jp L944
L946:
L948:
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
L950:
L949:
L944:
	inc 1,izl
L945:
	ld a,izl
	ld xbc,(xsp+2)
	ld c,(xbc+2)
	cp a,c
	jp ult,L942
L943:
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
L931:
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
	jr ge,L967
	ld wa,ix
	cp wa,65484
	jr gt,L966
L967:
	ld wa,0
	jp L965
L966:
	ldb (xsp+1),0
	jr L971
L968:
	inc 1,izl
	ld a,izl
	cp a,(_track_len)
	jr ult,L972
	ld izl,0
L972:
	ld xwa,(_track_seg)
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	ld wa,(xwa+2)
	ld ix,wa
	ld wa,ix
	cp wa,52
	jr ge,L974
	ld wa,ix
	cp wa,65484
	jr gt,L973
L974:
	ld wa,iy
	cp wa,150
	jr uge,L975
	ld wa,0
	jr L965
L975:
	ld bc,ix
	cp bc,0
	jr le,L976
	ld wa,1
	jr L977
L976:
	ld wa,65535
L977:
	jr L965
L973:
	ld wa,iy
	ld xbc,(_track_seg)
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld iy,wa
L970:
	incb 1,(xsp+1)
L971:
	ld a,(xsp+1)
	cp a,6
	jr uge,L978
	ld wa,iy
	cp wa,1300
	jr ult,L968
L978:
L969:
	ld wa,0
	jr L965
L965:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function game_tick
_game_tick__0:
	push xiz
	lda xsp,(xsp-8)
	ld a,(_state__0)
	cp a,0
	jp nz,L1098
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
	jr z,L1099
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,8
	cp wa,0
	jr z,L1100
	ld a,(_station__0)
	extz wa
	add wa,1
	and wa,3
	ld (_station__0),a
	jr L1101
L1100:
	ld a,(_station__0)
	extz wa
	add wa,4
	sub wa,1
	and wa,3
	ld (_station__0),a
L1101:
	ldb (_save_dirty__0),1
	call _title_texts__0
	ld a,(_station__0)
	push xwa
	call _music_play
	lda xsp,(xsp+4)
L1099:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,3
	cp wa,0
	jr z,L1102
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,2
	cp wa,0
	jr z,L1103
	ld a,(_difficulty)
	extz wa
	add wa,1
	and wa,3
	ld (_difficulty),a
	jr L1104
L1103:
	ld a,(_difficulty)
	extz wa
	add wa,4
	sub wa,1
	and wa,3
	ld (_difficulty),a
L1104:
	ld a,(_difficulty)
	cp a,3
	jr nz,L1105
	call _new_seed__0
L1105:
	ldb (_save_dirty__0),1
	ld wa,0
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	call _title_texts__0
L1102:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,32
	cp wa,0
	jr z,L1106
	ld a,(_difficulty)
	cp a,3
	jr nz,L1106
	call _new_seed__0
	ldb (_save_dirty__0),1
	ld wa,0
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	call _title_texts__0
L1106:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,16
	cp wa,0
	jr z,L1107
	call _title_leave__0
	call _new_game__0
	ldb (_state__0),1
	ldb (_state_timer__0),0
L1107:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
	jp L1108
L1098:
	ld a,(_state__0)
	cp a,6
	jr nz,L1109
	incw 1,(_map_t__0)
	ld wa,(_map_along__0)
	add wa,2
	ld (_map_along__0),wa
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,16
	cp wa,0
	jr z,L1112
	ld wa,(_map_t__0)
	cp wa,20
	jr ugt,L1111
L1112:
	ld wa,(_map_done__0)
	cp wa,0
	jr z,L1110
	ld wa,(_map_t__0)
	ld bc,(_map_done__0)
	add bc,75
	cp wa,bc
	jr ule,L1110
L1111:
	call _map_leave__0
	ldb (_state__0),5
	ldb (_state_timer__0),0
	call _result_screen__0
L1110:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
	jp L1113
L1109:
	ld a,(_state__0)
	cp a,5
	jr nz,L1114
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,16
	cp wa,0
	jr z,L1115
	ld a,(_state_timer__0)
	cp a,30
	jr ule,L1115
	ldb (_state__0),0
	ldb (_state_timer__0),0
	call _new_game__0
	call _title_screen__0
	ld a,(_station__0)
	push xwa
	call _music_play
	lda xsp,(xsp+4)
L1115:
	ld a,(_state_timer__0)
	cp a,255
	jr uge,L1116
	incb 1,(_state_timer__0)
L1116:
	ld a,(_state_timer__0)
	cp a,30
	jr ule,L1117
	ld wa,13
	push xwa
	ld a,(_state_timer__0)
	push xwa
	call _title_blink__0
	lda xsp,(xsp+8)
L1117:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
	jr L1118
L1114:
	ld a,(_ngpc_pad_pressed)
	extz wa
	and wa,64
	cp wa,0
	jr z,L1119
	ld c,(_paused__0)
	cp c,0
	jr nz,L1120
	ld wa,1
	jr L1121
L1120:
	ld wa,0
L1121:
	ld (_paused__0),a
	ld a,(_paused__0)
	cp a,0
	jr z,L1122
	ld wa,0
	push xwa
	ld wa,0
	exts xwa
	push xwa
	ld xwa,_S0_21
	push xwa
	call _message__0
	lda xsp,(xsp+12)
	jr L1123
L1122:
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
L1123:
L1119:
L1118:
L1113:
L1108:
	ld a,(_paused__0)
	cp a,0
	jr z,L1124
	jp L1097
L1124:
	ld a,(_state__0)
	cp a,1
	jp nz,L1125
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
	jr nz,L1127
	ld a,(xsp+0)
	cp a,4
	jr uge,L1127
	ld wa,0
	push xwa
	ld xwa,_cd__0_L1126
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
L1127:
	incb 1,(_state_timer__0)
	ld a,(_state_timer__0)
	cp a,90
	jr ult,L1128
	ldb (_state__0),2
	ld wa,30
	push xwa
	ld xwa,(_cd__0_L1126+12)
	push xwa
	call _count_message__0
	lda xsp,(xsp+8)
	ld wa,1
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L1128:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
L1125:
	ld a,(_state__0)
	cp a,2
	jr z,L1130
	ld a,(_state__0)
	cp a,3
	jr z,L1130
	ld a,(_state__0)
	cp a,4
	jp nz,L1129
L1130:
	ld a,(_state__0)
	cp a,2
	jr nz,L1132
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L1131
L1132:
	ldb (_ngpc_pad_held),0
	ldb (_ngpc_pad_pressed),0
L1131:
	ld wa,(_course_pos__0)
	ld (xsp+2),wa
	ld a,(_speed__0)
	ld (xsp+4),a
	call _drive__0
	ld a,(_offroad__0)
	cp a,0
	jr z,L1133
	ld a,(_was_offroad__0)
	cp a,0
	jr nz,L1133
	ld a,(xsp+4)
	ld (_verge_spd__0),a
	jr L1134
L1133:
	ld a,(_offroad__0)
	cp a,0
	jr z,L1135
	ld c,(_verge_spd__0)
	cp c,4
	jr ule,L1136
	ld a,(_verge_spd__0)
	sub a,4
	extz wa
	jr L1137
L1136:
	ld wa,0
L1137:
	ld (_verge_spd__0),a
	jr L1138
L1135:
	ldb (_verge_spd__0),0
L1138:
L1134:
	ld a,(_offroad__0)
	ld (_was_offroad__0),a
	call _advance__0
	ld a,(_state__0)
	cp a,2
	jp nz,L1139
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
	jr L1142
L1140:
	ld a,(_sec_acc__0)
	sub a,60
	ld (_sec_acc__0),a
	ld a,(_time_left__0)
	cp a,0
	jr z,L1143
	decb 1,(_time_left__0)
L1143:
	ld a,(_time_left__0)
	cp a,0
	jr z,L1144
	ld a,(_time_left__0)
	cp a,10
	jr ugt,L1144
	ld wa,5
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L1144:
L1142:
	ld a,(_sec_acc__0)
	cp a,60
	jr uge,L1140
L1141:
	ld a,(_time_left__0)
	cp a,0
	jr nz,L1145
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
L1145:
L1139:
	ld wa,(_course_pos__0)
	push xwa
	call _course_fork_zone
	lda xsp,(xsp+4)
	ld (xsp+0),a
	ld a,(xsp+0)
	cp a,0
	jp z,L1146
	call _course_is_last_stage
	cp a,0
	jp nz,L1146
	ld a,(_last_fork_zone__0)
	cp a,0
	jr nz,L1147
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
L1147:
	ld a,(_fork_choice)
	cp a,0
	jr nz,L1148
	ld wa,(_course_pos__0)
	add wa,850
	cp wa,(_leg_len)
	jr ult,L1148
	ld bc,(_car_lat__0)
	cp bc,0
	jr le,L1149
	ld wa,1
	jr L1150
L1149:
	ld wa,0
L1150:
	push xwa
	call _course_decide
	lda xsp,(xsp+4)
	ld wa,3
	push xwa
	call _hud_clear_message
	lda xsp,(xsp+4)
	ld a,(_fork_choice)
	cp a,2
	jr nz,L1151
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
	jr L1152
L1151:
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
L1152:
L1148:
	jp L1153
L1146:
	ld a,(xsp+0)
	cp a,0
	jr z,L1154
	call _course_is_last_stage
	cp a,0
	jr z,L1154
	ld a,(_last_fork_zone__0)
	cp a,0
	jr nz,L1155
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
L1155:
	ld wa,5
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L1156
L1154:
	ld a,(_cur_stage)
	cp a,0
	jr nz,L1157
	ld wa,(_course_pos__0)
	cp wa,900
	jr uge,L1157
	ld wa,5
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L1158
L1157:
	ld wa,(_course_pos__0)
	push xwa
	call _course_start_zone
	lda xsp,(xsp+4)
	cp a,0
	jr z,L1159
	ld wa,2
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
	jr L1160
L1159:
	call _sharp_ahead__0
	ld (xsp+4),a
	ld c,(xsp+4)
	cp c,0
	jr le,L1161
	ld wa,3
	jr L1162
L1161:
	ld c,(xsp+4)
	cp c,0
	jr ge,L1163
	ld wa,4
	jr L1164
L1163:
	ld wa,0
L1164:
L1162:
	push xwa
	call _scenery_mode
	lda xsp,(xsp+4)
L1160:
L1158:
L1156:
L1153:
	ld a,(xsp+0)
	ld (_last_fork_zone__0),a
	ld a,(_goal_reached__0)
	cp a,0
	jr nz,L1165
	ld wa,(_course_pos__0)
	cp wa,(_leg_len)
	jr ult,L1165
	ldb (_last_fork_zone__0),0
	call _leg_end__0
L1165:
	ld a,(_speed__0)
	push xwa
	call _id_scenery_advance
	lda xsp,(xsp+4)
	ld a,(_state__0)
	cp a,2
	jp nz,L1166
	ld a,(_crash_timer__0)
	cp a,0
	jp nz,L1166
	ld a,(_speed__0)
	push xwa
	ld wa,(_car_lat__0)
	push xwa
	call _traffic_collide
	lda xsp,(xsp+8)
	ld (xsp+4),a
	ld a,(xsp+4)
	cp a,0
	jr z,L1167
	ld a,(_speed__0)
	extz wa
	mul xwa,5
	srl 3,wa
	add wa,4
	ld (xsp+6),wa
	ld c,(xsp+4)
	cp c,1
	jr nz,L1168
	ld wa,(xsp+6)
	jr L1169
L1168:
	ld wa,(xsp+6)
	neg wa
L1169:
	ld (_knock_v__0),wa
	ldb (_knock_t__0),1
	ld wa,(_dbg_knock_at)
	cp wa,0
	jr nz,L1170
	ld a,(_speed__0)
	cp a,100
	jr ule,L1170
	ld wa,(_dbg_updates)
	ld (_dbg_knock_at),wa
L1170:
	ld a,(_speed__0)
	extz wa
	mul xwa,5
	srl 3,wa
	ld (_speed__0),a
	incb 1,(_dbg_bumps)
	ld wa,4
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	jp L1171
L1167:
	ld wa,147
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_scenery_hit
	lda xsp,(xsp+8)
	cp a,0
	jr nz,L1173
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
	jp z,L1172
L1173:
	ld c,(_verge_spd__0)
	cp c,(_speed__0)
	jr ule,L1174
	ld a,(_verge_spd__0)
	extz wa
	jr L1175
L1174:
	ld a,(_speed__0)
	extz wa
L1175:
	ld (xsp+5),a
	ld a,(xsp+5)
	cp a,110
	jp ule,L1176
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
	jr ult,L1177
	ldb (_roll_t__0),1
	ld c,(xsp+5)
	cp c,214
	jr ult,L1178
	ld wa,1
	jr L1179
L1178:
	ld wa,0
L1179:
	ld (_roll_kind__0),a
	ld a,(_roll_kind__0)
	cp a,0
	jr z,L1180
	incb 1,(_dbg_flips)
	ld wa,(_dbg_flip_at)
	cp wa,0
	jr nz,L1181
	ld wa,(_dbg_updates)
	ld (_dbg_flip_at),wa
L1181:
	jr L1182
L1180:
	incb 1,(_dbg_rolls)
L1182:
	ld wa,(_dbg_roll_at)
	cp wa,0
	jr nz,L1183
	ld wa,(_dbg_updates)
	ld (_dbg_roll_at),wa
L1183:
	ld bc,(_car_lat__0)
	cp bc,0
	jr gt,L1186
	ld bc,(_car_lat__0)
	cp bc,0
	jr nz,L1184
	ld c,(_g_vb_counter)
	extz bc
	and bc,1
	cp bc,0
	jr z,L1184
L1186:
	ld wa,1
	jr L1185
L1184:
	ld wa,0
L1185:
	ld (_roll_dir__0),a
L1177:
	incb 1,(_dbg_crashes)
	ld wa,3
	push xwa
	call _sfx
	lda xsp,(xsp+4)
	jr L1187
L1176:
	ld wa,48
	ld (xsp+6),a
	ld a,(_speed__0)
	extz wa
	sra 1,wa
	ld (xsp+7),a
	ld a,(xsp+6)
	cp a,(xsp+7)
	jr ule,L1188
	ld a,(xsp+7)
	ld (xsp+6),a
L1188:
	ld c,(_speed__0)
	cp c,(xsp+6)
	jr ule,L1189
	ld a,(_speed__0)
	sub a,(xsp+6)
	extz wa
	jr L1190
L1189:
	ld wa,0
L1190:
	ld (_speed__0),a
	ld wa,4
	push xwa
	call _sfx
	lda xsp,(xsp+4)
L1187:
L1172:
L1171:
L1166:
	ld wa,(_knock_v__0)
	cp wa,0
	jr z,L1191
	ld wa,(_car_lat__0)
	add wa,(_knock_v__0)
	ld (_car_lat__0),wa
	ld wa,(_car_lat__0)
	cp wa,(_lat_limit__0)
	jr le,L1192
	ld wa,(_lat_limit__0)
	ld (_car_lat__0),wa
L1192:
	ld wa,(_car_lat__0)
	ld bc,(_lat_limit__0)
	neg bc
	cp wa,bc
	jr ge,L1193
	ld wa,(_lat_limit__0)
	neg wa
	ld (_car_lat__0),wa
L1193:
	ld wa,(_knock_v__0)
	mul xwa,7
	exts xwa
	divs xwa,8
	ld (_knock_v__0),wa
	ld wa,(_knock_v__0)
	cp wa,65524
	jr le,L1194
	ld wa,(_knock_v__0)
	cp wa,12
	jr ge,L1194
	ldw (_knock_v__0),0
L1194:
L1191:
	ld a,(_knock_t__0)
	cp a,0
	jr z,L1195
	incb 1,(_knock_t__0)
	ld a,(_knock_t__0)
	cp a,26
	jr ule,L1196
	ldb (_knock_t__0),0
L1196:
L1195:
	ld a,(_roll_t__0)
	cp a,0
	jr z,L1197
	incb 1,(_roll_t__0)
	ld a,(_roll_t__0)
	cp a,36
	jr ule,L1198
	ldb (_roll_t__0),0
	ldb (_roll_loaded__0),255
	call _id_car_restore
L1198:
L1197:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L1199
	decb 1,(_crash_timer__0)
	ld c,(_speed__0)
	cp c,12
	jr ule,L1200
	ld a,(_speed__0)
	sub a,12
	extz wa
	jr L1201
L1200:
	ld wa,0
L1201:
	ld (_speed__0),a
	ld a,(_crash_timer__0)
	cp a,0
	jr nz,L1202
	ld wa,(_car_lat__0)
	exts xwa
	divs xwa,2
	ld (_car_lat__0),wa
	ldb (_speed__0),0
	ldb (_gear__0),0
L1202:
L1199:
	ld c,(_state__0)
	cp c,2
	jr nz,L1203
	push xwa
	ld wa,(_course_pos__0)
	push xwa
	call _course_fork_zone
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp c,0
	jr nz,L1203
	ld wa,1
	jr L1204
L1203:
	ld wa,0
L1204:
	push xwa
	ld a,(_speed__0)
	push xwa
	call _traffic_update
	lda xsp,(xsp+8)
	ld a,(_state__0)
	cp a,3
	jr nz,L1205
	incb 1,(_state_timer__0)
	ld a,(_speed__0)
	cp a,0
	jr nz,L1206
	ld a,(_state_timer__0)
	cp a,60
	jr ule,L1206
	ldb (_state__0),6
	ldb (_state_timer__0),0
	call _map_screen__0
L1206:
	jr L1207
L1205:
	ld a,(_state__0)
	cp a,4
	jr nz,L1208
	incb 1,(_state_timer__0)
	ld a,(_state_timer__0)
	cp a,1
	jr nz,L1209
	ld xwa,(_score__0)
	ld c,(_time_left__0)
	extz bc
	muls xbc,20000
	add xwa,xbc
	ld (_score__0),xwa
	ld izl,0
	jr L1213
L1210:
	ld wa,20000
	push xwa
	call _hud_score_add
	lda xsp,(xsp+4)
L1212:
	inc 1,izl
L1213:
	ld a,izl
	cp a,(_time_left__0)
	jr ult,L1210
L1211:
L1209:
	ld a,(_speed__0)
	cp a,0
	jr nz,L1214
	ld a,(_state_timer__0)
	cp a,60
	jr ule,L1214
	ldb (_state__0),6
	ldb (_state_timer__0),0
	call _map_screen__0
L1214:
L1208:
L1207:
L1129:
L1097:
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
	jr L1279
L1276:
	ld bc,(xsp+2)
	cp bc,0
	jr le,L1280
	call _id_road_grade_hi
	exts wa
	jr L1281
L1280:
	call _id_road_grade_lo
	exts wa
	neg wa
L1281:
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
L1278:
	incw 1,(xsp+2)
L1279:
	ld wa,(xsp+2)
	cp wa,6
	jr le,L1276
L1277:
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
L1282:
	jr L1288
L1286:
	call _ngpc_vsync
L1288:
	ld a,(_g_vb_counter)
	sub a,(_pace_prev__0)
	cp a,2
	jr ult,L1286
L1287:
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
	jr ule,L1289
	ldb (xsp+10),3
	ld a,(xsp+8)
	ld c,(xsp+9)
	and c,1
	sub a,c
	ld (_pace_prev__0),a
	jr L1290
L1289:
	ld a,(_pace_prev__0)
	extz wa
	ld c,(xsp+10)
	extz bc
	sll 1,bc
	extz bc
	add wa,bc
	ld (_pace_prev__0),a
L1290:
	call _ngpc_input_update
	call _audio_update
	incw 1,(_dbg_updates)
	ld a,(xsp+8)
	ld (_clock_prev__0),a
	ld izl,0
	jr L1294
L1291:
	ld wa,2
	push xwa
	call _game_tick__0
	lda xsp,(xsp+4)
	ld a,izl
	cp a,0
	jr nz,L1295
	ldb (_ngpc_pad_pressed),0
L1295:
L1293:
	inc 1,izl
L1294:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L1291
L1292:
	ld a,(_state__0)
	cp a,0
	jr nz,L1296
	ld a,(_state_timer__0)
	push xwa
	call _title_car__0
	lda xsp,(xsp+4)
	call _player_engine_off
	jp L1284
L1296:
	ld a,(_state__0)
	cp a,6
	jr nz,L1297
	call _map_car__0
	call _player_engine_off
	jp L1284
L1297:
	call _render_road__0
	call _tick_flash__0
	call _tick_message__0
	ld a,(_state__0)
	cp a,0
	jr z,L1298
	ld a,(_state__0)
	cp a,5
	jr z,L1298
	ld wa,(_course_pos__0)
	push xwa
	call _bridge_draw
	lda xsp,(xsp+4)
	call _id_scenery_draw
	call _traffic_draw
L1298:
	ld a,(_state__0)
	cp a,1
	jr z,L1300
	ld a,(_state__0)
	cp a,2
	jr nz,L1299
	ld a,(_cur_stage)
	cp a,0
	jr nz,L1299
	ld wa,(_course_pos__0)
	cp wa,220
	jr uge,L1299
L1300:
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
	jr L1301
L1299:
	ld a,(_state__0)
	cp a,2
	jr z,L1303
	ld a,(_state__0)
	cp a,4
	jr z,L1303
	ld a,(_state__0)
	cp a,3
	jr nz,L1302
L1303:
	call _course_is_last_stage
	cp a,0
	jr z,L1302
	ld wa,(_course_pos__0)
	ld bc,(_leg_len)
	sub bc,1400
	cp wa,bc
	jr le,L1302
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
	jr L1304
L1302:
	call _banner_hide
L1304:
L1301:
	ld a,(_state__0)
	cp a,5
	jr nz,L1305
	ld a,(_goal_reached__0)
	cp a,0
	jr z,L1305
	call _trophy_draw__0
	call _ending_tick
L1305:
	ld a,(_state__0)
	cp a,2
	jr z,L1307
	ld a,(_state__0)
	cp a,1
	jr z,L1307
	ld a,(_state__0)
	cp a,3
	jr z,L1307
	ld a,(_state__0)
	cp a,4
	jr nz,L1306
L1307:
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
	jr nz,L1308
	ld c,(_speed__0)
	cp c,123
	jr ult,L1308
	ld c,(_g_vb_counter)
	extz bc
	and bc,8
	cp bc,0
	jr z,L1308
	ld wa,2
	jr L1309
L1308:
	ld a,(_gear__0)
	extz wa
L1309:
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
L1306:
	ld a,(_roll_t__0)
	cp a,0
	jr z,L1310
	call _roll_draw__0
	jp L1311
L1310:
	ld a,(_crash_timer__0)
	cp a,0
	jr z,L1312
	ld a,(_crash_timer__0)
	extz wa
	and wa,2
	cp wa,0
	jr z,L1312
	ld wa,2
	push xwa
	ld c,(_crash_timer__0)
	extz bc
	and bc,4
	cp bc,0
	jr z,L1313
	ld wa,1
	jr L1314
L1313:
	ld wa,65535
L1314:
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_car_draw
	lda xsp,(xsp+12)
	jp L1315
L1312:
	ld a,(_knock_t__0)
	cp a,0
	jr z,L1316
	ld c,(_knock_t__0)
	extz bc
	sra 2,bc
	and bc,1
	cp bc,0
	jr z,L1317
	ld wa,1
	jr L1318
L1317:
	ld wa,65535
L1318:
	ld (xsp+12),a
	ld c,(_knock_t__0)
	cp c,18
	jr uge,L1319
	ld a,(xsp+12)
	exts wa
	sll 1,wa
	jr L1320
L1319:
	ld wa,0
L1320:
	ld (xsp+14),wa
	ld c,(_offroad__0)
	cp c,0
	jr z,L1321
	ld c,(_speed__0)
	cp c,20
	jr ule,L1321
	ld wa,1
	jr L1322
L1321:
	ld wa,0
L1322:
	push xwa
	ld a,(xsp+16)
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	add wa,(xsp+22)
	push xwa
	call _id_car_draw
	lda xsp,(xsp+12)
	jr L1323
L1316:
	ld c,(_offroad__0)
	cp c,0
	jr z,L1324
	ld c,(_speed__0)
	cp c,20
	jr ule,L1324
	ld wa,1
	jr L1325
L1324:
	ld wa,0
L1325:
	push xwa
	ld a,(_car_lean__0)
	push xwa
	ld wa,(_car_lat__0)
	sra 4,wa
	push xwa
	call _id_car_draw
	lda xsp,(xsp+12)
L1323:
L1315:
L1311:
	ld c,(_knock_t__0)
	cp c,0
	jr z,L1326
	ld c,(_knock_t__0)
	cp c,5
	jr uge,L1326
	ld wa,1
	jr L1327
L1326:
	ld wa,0
L1327:
	push xwa
	ld c,(_skid__0)
	cp c,0
	jr nz,L1330
	ld c,(_knock_t__0)
	cp c,0
	jr z,L1328
	ld c,(_knock_t__0)
	cp c,20
	jr uge,L1328
	ld c,(_speed__0)
	cp c,30
	jr ule,L1328
L1330:
	ld c,(_crash_timer__0)
	cp c,0
	jr nz,L1328
	ld c,(_state__0)
	cp c,2
	jr nz,L1328
	ld wa,1
	jr L1329
L1328:
	ld wa,0
L1329:
	push xwa
	call _smoke_draw__0
	lda xsp,(xsp+8)
	ld a,(_offroad__0)
	cp a,0
	jr z,L1331
	ld a,(_state__0)
	cp a,2
	jr nz,L1331
	incb 1,(_dbg_off)
L1331:
	ld a,(_state__0)
	cp a,2
	jr z,L1333
	ld a,(_state__0)
	cp a,1
	jr z,L1333
	ld a,(_state__0)
	cp a,3
	jr z,L1333
	ld a,(_state__0)
	cp a,4
	jr nz,L1332
L1333:
	call _engine_sound__0
	jr L1334
L1332:
	call _player_engine_off
L1334:
L1284:
L1285:
	jp L1282
L1283:
L1275:
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
L1336:
	ret

; function player_engine_off
_player_engine_off:
	ldb (_eng_on__10),0
L1338:
	ret

; function player_init
_player_init:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,28672
	ld xix,xwa
	ldw (0B8h),43690
	ld izl,0
	jr L1352
L1349:
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
L1351:
	inc 1,izl
L1352:
	ld a,izl
	cp a,65
	jr ult,L1349
L1350:
	ldw (0B8h),21845
	ld izl,0
	jr L1356
L1353:
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
L1355:
	inc 1,izl
L1356:
	ld a,izl
	cp a,4
	jr ult,L1353
L1354:
	ldb (_playing__10),0
	ld a,(_g_vb_counter)
	ld (_last_vbl__10),a
L1348:
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
	jp L1366
L1363:
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
L1365:
	inc 1,izl
L1366:
	ld a,izl
	cp a,4
	jp ult,L1363
L1364:
	ldb (_playing__10),1
	ld a,(_g_vb_counter)
	ld (_last_vbl__10),a
L1362:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function player_stop
_player_stop:
	push xiz
	lda xsp,(xsp-2)
	ldb (_playing__10),0
	ld izl,0
	jr L1376
L1373:
	ld a,0
	ld xbc,_voice__10
	ld e,izl
	extz de
	muls xde,18
	add xbc,xde
	ld (xbc+15),a
L1375:
	inc 1,izl
L1376:
	ld a,izl
	cp a,4
	jr ult,L1373
L1374:
L1372:
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
	jp L1393
L1391:
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld ixl,a
	incb 1,(xsp+0)
	ld a,ixl
	cp a,0
	jr nz,L1394
	ld xwa,(xiz+4)
	ld (xiz),xwa
	jp L1393
L1394:
	ld a,ixl
	cp a,240
	jr nz,L1395
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld (xiz+13),a
	jp L1393
L1395:
	ld a,ixl
	cp a,244
	jr nz,L1396
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	ld (xiz+14),a
	ld a,(xiz+14)
	cp a,17
	jr ule,L1397
	ldb (xiz+14),0
L1397:
	jr L1393
L1396:
	ld a,ixl
	cp a,255
	jr nz,L1398
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	dec 1,xwa
	ld a,(xwa)
	extz wa
	ld (xiz+8),wa
	ldb (xiz+15),0
	jr L1393
L1398:
	ld a,ixl
	cp a,240
	jr ult,L1399
	ld xwa,(xiz)
	inc 1,xwa
	ld (xiz),xwa
	jr L1393
L1399:
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
	jr nz,L1400
	ld a,ixl
	extz wa
	sub wa,1
	and wa,7
	ld (xiz+10),wa
	ldb (xiz+16),1
	jr L1401
L1400:
	push xix
	ld a,ixl
	push xwa
	call _note_div
	lda xsp,(xsp+4)
	pop xix
	ld (xiz+10),wa
L1401:
L1393:
	ld wa,(xiz+8)
	cp wa,0
	jr nz,L1402
	ld a,(xsp+0)
	cp a,32
	jp ult,L1391
L1402:
L1392:
L1390:
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
	jr ule,L1406
	ld izl,50
L1406:
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
	jr L1405
L1405:
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
	jr z,L1423
	jp L1422
L1423:
	ld izl,0
	jp L1427
L1424:
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
	jr uge,L1428
	ld wa,ix
	ld xbc,_sent_div__10
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L1429
	ld a,(xsp+8)
	ld xbc,_sent_attn__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr nz,L1429
	jp L1426
L1429:
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
	jr L1430
L1428:
	ld a,(_noise_trig__10)
	cp a,0
	jr nz,L1431
	ld wa,ix
	cp wa,(_sent_div__10+6)
	jr nz,L1431
	ld a,(xsp+8)
	cp a,(_sent_attn__10+3)
	jr nz,L1431
	jp L1426
L1431:
	ld a,(_noise_trig__10)
	cp a,0
	jr nz,L1433
	ld wa,ix
	cp wa,(_sent_div__10+6)
	jr z,L1432
L1433:
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
	jr L1434
L1432:
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
L1434:
	ld a,240
	ld c,(xsp+8)
	and c,15
	or a,c
	ld (xiy+2),a
	ldb (_noise_trig__10),0
L1430:
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
L1426:
	inc 1,izl
L1427:
	ld a,izl
	cp a,4
	jr uge,L1435
	ld a,(xsp+0)
	cp a,5
	jp ult,L1424
L1435:
L1425:
	ld a,(xsp+0)
	cp a,0
	jr z,L1436
	ld a,(xsp+0)
	ld (07003h),a
L1436:
L1422:
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
	jr ule,L1459
	ld iyl,8
L1459:
	ld izl,0
	jp L1463
L1460:
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
	jp z,L1464
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
	jr ule,L1465
	ld wa,(xix+8)
	ld c,iyl
	extz bc
	sub wa,bc
	ld (xix+8),wa
	jr L1466
L1465:
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
L1466:
	ld a,(xix+12)
	cp a,250
	jr uge,L1467
	ld a,(xix+12)
	add a,iyl
	ld (xix+12),a
L1467:
	ld a,(xix+15)
	cp a,0
	jr z,L1468
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
	jr ule,L1469
	ld xwa,(xsp+10)
	ld a,(xwa+1)
	ld (xsp+14),a
L1469:
	ld a,(xix+13)
	add a,(xsp+14)
	ld (xsp+3),a
	ld a,(xsp+3)
	cp a,15
	jr ule,L1470
	ldb (xsp+3),15
L1470:
	ld wa,(xix+10)
	ld (xsp+4),wa
	ld a,izl
	cp a,3
	jr nz,L1471
	ld a,(xix+16)
	cp a,0
	jr z,L1471
	ldb (xix+16),0
	ldb (_noise_trig__10),1
L1471:
L1468:
L1464:
	ld a,izl
	cp a,2
	jr nz,L1472
	ld a,(_eng_on__10)
	cp a,0
	jr z,L1472
	ld wa,(_eng_div__10)
	ld (xsp+4),wa
	ld a,(_eng_attn__10)
	ld (xsp+3),a
L1472:
	ld xwa,_sfx_frames__10
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L1473
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
	jr z,L1474
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
	jr ule,L1475
	ldb (xsp+6),15
L1475:
L1474:
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
	jr uge,L1476
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
L1476:
	ld xbc,_sfx_frames__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp c,iyl
	jr ule,L1477
	ld xwa,_sfx_frames__10
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	sub a,iyl
	extz wa
	jr L1478
L1477:
	ld wa,0
L1478:
	ld xbc,_sfx_frames__10
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1473:
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
L1462:
	inc 1,izl
L1463:
	ld a,izl
	cp a,4
	jp ult,L1460
L1461:
	push xix
	push xiy
	call _flush__10
	pop xiy
	pop xix
L1458:
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
L1480:
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
L1482:
	ret

; function banner_init
_banner_init:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,41520
	ld xix,xwa
	ld izl,0
	jr L1492
L1489:
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
L1491:
	inc 1,izl
L1492:
	ld a,izl
	cp a,40
	jr ult,L1489
L1490:
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
L1488:
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
	jr ult,L1496
	ld izl,0
L1496:
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
L1495:
	pop xiz
	ret

; function erase
_erase__11:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_b_on__11)
	cp a,0
	jr nz,L1508
	jr L1507
L1508:
	ld a,(_b_r0__11)
	ld ixl,a
	jr L1512
L1509:
	ld a,(_b_c0__11)
	ld izl,a
	jr L1516
L1513:
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
L1515:
	inc 1,izl
L1516:
	ld a,izl
	cp a,(_b_c1__11)
	jr ule,L1513
L1514:
L1511:
	inc 1,ixl
L1512:
	ld a,ixl
	cp a,(_b_foot__11)
	jr ule,L1509
L1510:
	ldb (_b_on__11),0
L1507:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function banner_hide
_banner_hide:
	call _erase__11
	ld a,(_b_spr__11)
	cp a,0
	jr z,L1520
	ld a,64
	push xwa
	ld a,58
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	ldb (_b_spr__11),0
L1520:
L1519:
	ret

; function banner_dirty
_banner_dirty:
	ldb (_b_r0__11),255
L1522:
	ret

; function banner_active
_banner_active:
	ld a,(_b_on__11)
	jr L1524
L1524:
	ret

; function banner_show
_banner_show:
	push xiz
	lda xsp,(xsp-46)
	ld wa,(xsp+54)
	cp wa,0
	jr lt,L1579
	ld wa,(xsp+54)
	cp wa,1400
	jr le,L1578
L1579:
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1577
L1578:
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
	jr nz,L1580
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1577
L1580:
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
	jr lt,L1582
	ld wa,(xsp+18)
	cp wa,151
	jr le,L1581
L1582:
	push xix
	push xiy
	call _banner_hide
	pop xiy
	pop xix
	jp L1577
L1581:
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
	jr uge,L1583
	ld a,(xsp+7)
	ld iyl,a
L1583:
	ld wa,(xsp+2)
	sra 3,wa
	ld (xsp+11),a
	ld a,(xsp+11)
	cp a,18
	jr ule,L1584
	ldb (xsp+11),18
L1584:
	ld bc,(xsp+20)
	cp bc,0
	jr ge,L1585
	ld wa,0
	jr L1586
L1585:
	ld bc,(xsp+20)
	sra 3,bc
	cp bc,19
	jr le,L1587
	ld wa,19
	jr L1588
L1587:
	ld wa,(xsp+20)
	sra 3,wa
L1588:
L1586:
	ld (xsp+9),a
	ld bc,(xsp+22)
	cp bc,0
	jr ge,L1589
	ld wa,0
	jr L1590
L1589:
	ld bc,(xsp+22)
	sra 3,bc
	cp bc,19
	jr le,L1591
	ld wa,19
	jr L1592
L1591:
	ld wa,(xsp+22)
	sra 3,wa
L1592:
L1590:
	ld (xsp+10),a
	ld a,(_b_on__11)
	cp a,0
	jr z,L1594
	ld a,(xsp+7)
	cp a,(_b_r0__11)
	jr nz,L1594
	ld a,iyl
	cp a,(_b_r1__11)
	jr nz,L1594
	ld a,(xsp+9)
	cp a,(_b_c0__11)
	jr nz,L1594
	ld a,(xsp+10)
	cp a,(_b_c1__11)
	jr nz,L1594
	ld a,(xsp+11)
	cp a,(_b_foot__11)
	jp z,L1593
L1594:
	push xix
	push xiy
	call _erase__11
	pop xiy
	pop xix
	ld a,(xsp+7)
	ld izl,a
	jp L1598
L1595:
	ld a,(xsp+9)
	ld ixl,a
	jr L1602
L1599:
	ld wa,36
	ld (xsp+26),wa
	ld a,(xsp+58)
	cp a,0
	jr z,L1603
	ld a,ixl
	cp a,(xsp+9)
	jr z,L1604
	ld a,ixl
	cp a,(xsp+10)
	jr nz,L1603
L1604:
	ldw (xsp+26),42
	jr L1605
L1603:
	ld a,izl
	cp a,(xsp+7)
	jr nz,L1606
	ld a,iyl
	cp a,(xsp+7)
	jr ule,L1606
	ldw (xsp+26),35
	jr L1607
L1606:
	ld a,izl
	cp a,iyl
	jr nz,L1608
	ld a,iyl
	cp a,(xsp+7)
	jr ule,L1608
	ldw (xsp+26),37
L1608:
L1607:
L1605:
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
L1601:
	inc 1,ixl
L1602:
	ld a,ixl
	cp a,(xsp+10)
	jr ule,L1599
L1600:
L1597:
	inc 1,izl
L1598:
	ld a,izl
	cp a,iyl
	jp ule,L1595
L1596:
	ld a,iyl
	add a,1
	ld izl,a
	jr L1612
L1609:
	ld wa,(xsp+20)
	cp wa,0
	jr lt,L1613
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
L1613:
	ld wa,(xsp+22)
	cp wa,160
	jr ge,L1614
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
L1614:
L1611:
	inc 1,izl
L1612:
	ld a,izl
	cp a,(xsp+11)
	jr ule,L1609
L1610:
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
L1593:
	ldb (xsp+14),0
	jr L1617
L1615:
	incb 1,(xsp+14)
L1617:
	ld xwa,(xsp+62)
	ld c,(xsp+14)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L1618
	ld a,(xsp+14)
	cp a,6
	jr ult,L1615
L1618:
L1616:
	ld wa,2
	mul xwa,(xsp+24)
	add wa,8
	ld c,(xsp+14)
	extz bc
	sll 3,bc
	cp wa,bc
	jr ge,L1619
	ldb (xsp+14),0
L1619:
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
	jp L1623
L1620:
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
	jr lt,L1625
	ld wa,(xsp+32)
	cp wa,159
	jr le,L1624
L1625:
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
	jp L1622
L1624:
L1626:
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
L1628:
L1627:
L1622:
	incb 1,(xsp+15)
L1623:
	ld a,(xsp+15)
	cp a,(xsp+14)
	jp ult,L1620
L1621:
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
L1577:
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
	jr L1642
L1639:
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
L1641:
	inc 1,izl
L1642:
	ld a,izl
	cp a,8
	jr ult,L1639
L1640:
	ld xwa,42416
	ld xix,xwa
	ld izl,0
	jr L1646
L1643:
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
L1645:
	inc 1,izl
L1646:
	ld a,izl
	cp a,40
	jr ult,L1643
L1644:
	push xix
	ld wa,147
	push xwa
	call _id_road_distance_at_line
	lda xsp,(xsp+4)
	pop xix
	ld (_car_d__12),wa
L1638:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function clear_box
_clear_box__12:
	push xiz
	lda xsp,(xsp-6)
	ld a,(_bb_r0__12)
	cp a,255
	jr nz,L1658
	jr L1657
L1658:
	ld a,(_bb_r0__12)
	ld ixl,a
	jr L1662
L1659:
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
	jr L1666
L1663:
	ld wa,0
	ld xbc,xiy
	inc 2,xbc
	ld xiy,xbc
	dec 2,xbc
	ld (xbc),wa
L1665:
	inc 1,izl
L1666:
	ld a,izl
	cp a,(_bb_c1__12)
	jr ule,L1663
L1664:
L1661:
	inc 1,ixl
L1662:
	ld a,ixl
	cp a,(_bb_r1__12)
	jr ule,L1659
L1660:
	ldb (_bb_r0__12),255
L1657:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function bridge_hide
_bridge_hide:
	call _clear_box__12
	ldw (_sig_prev__12),65535
	ldb (_bridge_line),0
L1668:
	ret

; function bridge_setup
_bridge_setup:
	push xiz
	lda xsp,(xsp-22)
	ld wa,0
	ld (xsp+0),wa
	ld wa,0
	ld (xsp+2),wa
	ld wa,0
	ld ix,wa
	ld wa,0
	ld (xsp+6),wa
	ld wa,0
	ld (xsp+8),wa
	ld wa,1200
	ld (xsp+10),wa
	ld wa,(_leg_len)
	sub wa,2400
	sub wa,300
	ld (xsp+12),wa
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
	jr nz,L1690
	jp L1689
L1690:
	ld izl,0
	jp L1694
L1691:
	ld xwa,(_track_seg)
	ld c,izl
	extz bc
	muls xbc,6
	add xwa,xbc
	lda xwa,(xwa)
	ld xiy,xwa
	ld bc,(xiy+2)
	cp bc,0
	jr ge,L1695
	ld wa,(xiy+2)
	neg wa
	jr L1696
L1695:
	ld wa,(xiy+2)
L1696:
	ld (xsp+20),wa
	ld wa,(xsp+20)
	cp wa,32
	jr gt,L1697
	ld a,(xiy+4)
	cp a,0
	jr nz,L1697
	ld wa,(xsp+0)
	cp wa,(xsp+10)
	jr ult,L1697
	ld wa,ix
	cp wa,0
	jr nz,L1698
	ld wa,(xsp+0)
	ld (xsp+2),wa
L1698:
	ld wa,ix
	add wa,(xiy)
	ld ix,wa
	ld wa,(xsp+2)
	add wa,ix
	cp wa,(xsp+12)
	jr ule,L1699
	ld wa,(xsp+12)
	sub wa,(xsp+2)
	ld ix,wa
L1699:
	ld wa,ix
	cp wa,(xsp+8)
	jr ule,L1700
	ld wa,ix
	ld (xsp+8),wa
	ld wa,(xsp+2)
	ld (xsp+6),wa
L1700:
	jr L1701
L1697:
	ld ix,0
L1701:
	ld wa,(xsp+0)
	add wa,(xiy)
	ld (xsp+0),wa
L1693:
	inc 1,izl
L1694:
	ld a,izl
	cp a,(_track_len)
	jr uge,L1702
	ld wa,(xsp+0)
	cp wa,(xsp+12)
	jp ult,L1691
L1702:
L1692:
	ld wa,(xsp+8)
	cp wa,700
	jr uge,L1703
	jr L1689
L1703:
	ld wa,(xsp+8)
	sub wa,300
	extz xwa
	div xwa,280
	add wa,1
	ld (_br_n__12),a
	ld a,(_br_n__12)
	cp a,4
	jr ule,L1704
	ldb (_br_n__12),4
L1704:
	ld izl,0
	jr L1708
L1705:
	ld wa,(xsp+6)
	add wa,200
	ld c,izl
	extz bc
	mul xbc,280
	add wa,bc
	ld xbc,_br_at__12
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1707:
	inc 1,izl
L1708:
	ld a,izl
	cp a,(_br_n__12)
	jr ult,L1705
L1706:
L1689:
	lda xsp,(xsp+22)
	pop xiz
	ret

; function clamp_col
_clamp_col__12:
	push xiz
	ld iz,(xsp+8)
	ld wa,iz
	cp wa,0
	jr ge,L1713
	ld wa,0
	jr L1712
L1713:
	ld wa,iz
	cp wa,159
	jr le,L1714
	ld wa,19
	jr L1712
L1714:
	ld wa,iz
	sra 3,wa
	jr L1712
L1712:
	pop xiz
	ret

; function bridge_draw
_bridge_draw:
	push xiz
	lda xsp,(xsp-64)
	ld wa,0
	ld (xsp+2),wa
	ld wa,0
	ld iyl,a
	ldb (_bridge_line),0
	ld a,(_br_n__12)
	cp a,0
	jr nz,L1783
	jp L1782
L1783:
	ldb (xsp+0),0
	jp L1787
L1784:
	ld xwa,_br_at__12
	ld c,(xsp+0)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	sub wa,(xsp+72)
	ld (xsp+42),wa
	ld wa,(xsp+42)
	cp wa,0
	jr le,L1789
	ld wa,(xsp+42)
	cp wa,1450
	jr le,L1788
L1789:
	jp L1786
L1788:
	push xix
	push xiy
	ld wa,(xsp+50)
	add wa,(_car_d__12)
	push xwa
	call _id_road_line_at_distance
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	ld (xsp+50),a
	ld a,(xsp+50)
	cp a,255
	jr nz,L1790
	jp L1786
L1790:
	push xix
	push xiy
	lda xwa,(xsp+52)
	push xwa
	ld a,(xsp+62)
	push xwa
	call _id_road_sprite_sample
	lda xsp,(xsp+8)
	pop xiy
	pop xix
	ld a,(xsp+48)
	extz wa
	ld (xsp+52),wa
	ld a,(xsp+48)
	extz wa
	ld c,(xsp+48)
	extz bc
	extz xbc
	div xbc,6
	add wa,bc
	add wa,3
	ld (xsp+54),wa
	ld a,(xsp+48)
	extz wa
	extz xwa
	div xwa,3
	add wa,3
	ld (xsp+56),wa
	ld wa,(xsp+46)
	ld (xsp+62),wa
	ld wa,(xsp+62)
	cp wa,151
	jr le,L1791
	ldw (xsp+62),151
L1791:
	ld wa,(xsp+62)
	sub wa,(xsp+52)
	ld bc,(xsp+52)
	sra 3,bc
	sub wa,bc
	ld (xsp+60),wa
	ld wa,(xsp+60)
	sub wa,(xsp+56)
	ld (xsp+58),wa
	ld wa,(xsp+60)
	cp wa,20
	jr ge,L1792
	jp L1786
L1792:
	ld a,(_bridge_line)
	cp a,0
	jr nz,L1793
	ld a,(xsp+62)
	ld (_bridge_line),a
L1793:
	ld bc,(xsp+58)
	cp bc,16
	jr ge,L1794
	ld wa,2
	jr L1795
L1794:
	ld wa,(xsp+58)
	sra 3,wa
	extz wa
L1795:
	lda xbc,(xsp+5)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+60)
	sra 3,wa
	lda xbc,(xsp+9)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	lda xwa,(xsp+9)
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
	jr uge,L1796
	lda xwa,(xsp+5)
	ld c,iyl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	lda xbc,(xsp+9)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1796:
	ld wa,(xsp+62)
	sra 3,wa
	lda xbc,(xsp+13)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	lda xwa,(xsp+13)
	ld c,iyl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,18
	jr ule,L1797
	ld a,18
	lda xbc,(xsp+13)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L1797:
	ld bc,(xsp+44)
	sub bc,(xsp+54)
	sub bc,1
	cp bc,0
	jr lt,L1798
	ld wa,1
	jr L1799
L1798:
	ld wa,0
L1799:
	lda xbc,(xsp+33)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld bc,(xsp+44)
	add bc,(xsp+54)
	cp bc,159
	jr gt,L1800
	ld wa,1
	jr L1801
L1800:
	ld wa,0
L1801:
	lda xbc,(xsp+37)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	push xix
	push xiy
	ld wa,(xsp+52)
	sub wa,(xsp+62)
	sub wa,(xsp+64)
	push xwa
	call _clamp_col__12
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	lda xbc,(xsp+17)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	push xix
	push xiy
	ld wa,(xsp+52)
	sub wa,(xsp+62)
	sub wa,1
	push xwa
	call _clamp_col__12
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	lda xbc,(xsp+21)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	push xix
	push xiy
	ld wa,(xsp+52)
	add wa,(xsp+62)
	push xwa
	call _clamp_col__12
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	lda xbc,(xsp+25)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	push xix
	push xiy
	ld wa,(xsp+52)
	add wa,(xsp+62)
	add wa,(xsp+64)
	push xwa
	call _clamp_col__12
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	lda xbc,(xsp+29)
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
	lda xbc,(xsp+9)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	sll 5,bc
	add wa,bc
	lda xbc,(xsp+17)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	sll 9,bc
	add wa,bc
	lda xbc,(xsp+29)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	sll 3,bc
	add wa,bc
	lda xbc,(xsp+13)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	lda xbc,(xsp+21)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	lda xbc,(xsp+25)
	ld e,iyl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	extz bc
	add wa,bc
	ld (xsp+2),wa
	inc 1,iyl
L1786:
	incb 1,(xsp+0)
L1787:
	ld a,(xsp+0)
	ld c,(_br_n__12)
	cp a,c
	jp lt,L1784
L1785:
	ld a,iyl
	cp a,0
	jr nz,L1802
	ld a,(_bb_r0__12)
	cp a,255
	jr z,L1803
	push xix
	push xiy
	call _bridge_hide
	pop xiy
	pop xix
L1803:
	jp L1782
L1802:
	ld wa,(xsp+2)
	ld c,iyl
	extz bc
	add wa,bc
	ld (xsp+2),wa
	ld wa,(xsp+2)
	cp wa,(_sig_prev__12)
	jr nz,L1804
	jp L1782
L1804:
	ld wa,(xsp+2)
	ld (_sig_prev__12),wa
	push xix
	push xiy
	call _clear_box__12
	pop xiy
	pop xix
	jp L1807
L1805:
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
	ld (xsp+43),a
	jp L1811
L1808:
	ld c,(xsp+43)
	lda xde,(xsp+9)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1812
	lda xbc,(xsp+9)
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
	jr ule,L1812
	ld wa,92
	jr L1813
L1812:
	ld c,(xsp+43)
	lda xde,(xsp+5)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1814
	ld wa,64
	jr L1815
L1814:
	ld wa,91
L1815:
L1813:
	ld (xsp+44),wa
	ld xwa,36864
	ld c,(xsp+43)
	extz bc
	sll 5,bc
	lda xde,(xsp+17)
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
	ld (xsp+46),xwa
	lda xwa,(xsp+9)
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
	jr nz,L1816
	ldw (xsp+44),92
L1816:
	lda xwa,(xsp+17)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld ixl,a
	jr L1820
L1817:
	ld wa,(xsp+44)
	or wa,5632
	ld xbc,(xsp+46)
	inc 2,xbc
	ld (xsp+46),xbc
	dec 2,xbc
	ld (xbc),wa
L1819:
	inc 1,ixl
L1820:
	ld a,ixl
	lda xbc,(xsp+29)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr ule,L1817
L1818:
L1810:
	incb 1,(xsp+43)
L1811:
	ld a,(xsp+43)
	lda xbc,(xsp+9)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp ule,L1808
L1809:
	lda xwa,(xsp+9)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	add a,1
	ld (xsp+43),a
	jp L1824
L1821:
	lda xwa,(xsp+33)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L1825
	lda xwa,(xsp+17)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld ixl,a
	jp L1829
L1826:
	ld c,ixl
	lda xde,(xsp+21)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1830
	ld wa,95
	jr L1831
L1830:
	ld c,ixl
	lda xde,(xsp+17)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1832
	lda xbc,(xsp+21)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	lda xde,(xsp+17)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr ule,L1832
	ld wa,94
	jr L1833
L1832:
	ld wa,93
L1833:
L1831:
	ld (xsp+44),wa
	ld wa,(xsp+44)
	or wa,5632
	ld xbc,36864
	ld e,(xsp+43)
	extz de
	sll 5,de
	ld l,ixl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1828:
	inc 1,ixl
L1829:
	ld a,ixl
	lda xbc,(xsp+21)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp ule,L1826
L1827:
L1825:
	lda xwa,(xsp+37)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L1834
	lda xwa,(xsp+25)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld ixl,a
	jp L1838
L1835:
	ld c,ixl
	lda xde,(xsp+25)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1839
	ld wa,94
	jr L1840
L1839:
	ld c,ixl
	lda xde,(xsp+29)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr nz,L1841
	lda xbc,(xsp+29)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	lda xde,(xsp+25)
	ld l,izl
	extz hl
	exts xhl
	add xde,xhl
	ld e,(xde)
	cp c,e
	jr ule,L1841
	ld wa,95
	jr L1842
L1841:
	ld wa,93
L1842:
L1840:
	ld (xsp+44),wa
	ld wa,(xsp+44)
	or wa,5632
	ld xbc,36864
	ld e,(xsp+43)
	extz de
	sll 5,de
	ld l,ixl
	extz hl
	add de,hl
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L1837:
	inc 1,ixl
L1838:
	ld a,ixl
	lda xbc,(xsp+29)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp ule,L1835
L1836:
L1834:
L1823:
	incb 1,(xsp+43)
L1824:
	ld a,(xsp+43)
	lda xbc,(xsp+13)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp ule,L1821
L1822:
	ld a,(_bb_r0__12)
	cp a,255
	jr nz,L1843
	lda xwa,(xsp+5)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_r0__12),a
	lda xwa,(xsp+13)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_r1__12),a
	lda xwa,(xsp+17)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_c0__12),a
	lda xwa,(xsp+29)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_c1__12),a
	jp L1844
L1843:
	lda xwa,(xsp+5)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_bb_r0__12)
	jr uge,L1845
	lda xwa,(xsp+5)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_r0__12),a
L1845:
	lda xwa,(xsp+13)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_bb_r1__12)
	jr ule,L1846
	lda xwa,(xsp+13)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_r1__12),a
L1846:
	lda xwa,(xsp+17)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_bb_c0__12)
	jr uge,L1847
	lda xwa,(xsp+17)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_c0__12),a
L1847:
	lda xwa,(xsp+29)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_bb_c1__12)
	jr ule,L1848
	lda xwa,(xsp+29)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_bb_c1__12),a
L1848:
L1844:
L1807:
	ld a,iyl
	cp a,0
	jp ugt,L1805
L1806:
L1782:
	lda xsp,(xsp+64)
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
	jr ge,L1857
	ld wa,ix
	neg wa
	ld ix,wa
L1857:
	ld izl,0
	jr L1861
L1858:
	ld wa,(xsp+12)
	ld xbc,_br_at__12
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr uge,L1862
	ld wa,(xsp+16)
	ld xbc,_br_at__12
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr ult,L1862
	ld wa,ix
	add wa,14
	cp wa,iy
	jr le,L1862
	ld wa,1
	jr L1856
L1862:
L1860:
	inc 1,izl
L1861:
	ld a,izl
	cp a,(_br_n__12)
	jr ult,L1858
L1859:
	ld wa,0
	jr L1856
L1856:
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
	jr ult,L1866
	ld xwa,(xsp+0)
	sub xwa,8192
	ld (xsp+0),xwa
	ld a,izl
	sub a,32
	ld izl,a
L1866:
	ld xwa,(xsp+0)
	ld c,izl
	extz bc
	extz xbc
	sll 8,xbc
	add xwa,xbc
	jr L1865
L1865:
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
	jr L1868
L1868:
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
	jr L1880
L1877:
	ld bc,iz
	and bc,32768
	cp bc,0
	jr z,L1881
	ld wa,iz
	sll 1,wa
	xor wa,4129
	jr L1882
L1881:
	ld wa,iz
	sll 1,wa
L1882:
	ld iz,wa
L1879:
	inc 1,ixl
L1880:
	ld a,ixl
	cp a,8
	jr ult,L1877
L1878:
	ld wa,iz
	jr L1876
L1876:
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
	jr L1893
L1890:
	ld xwa,xix
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,255
	jr z,L1894
	ld wa,0
	jr L1889
L1894:
L1892:
	inc 1,iz
L1893:
	ld wa,iz
	cp wa,256
	jr ult,L1890
L1891:
	ld wa,1
	jr L1889
L1889:
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
	jr nz,L1899
	ld c,(xiz+1)
	cp c,254
	jr nz,L1899
	ld c,(xiz+2)
	cp c,32
	jr nz,L1899
	ld c,(xiz+3)
	cp c,38
	jr nz,L1899
	ld c,(xiz+254)
	cp c,74
	jr nz,L1899
	ld c,(xiz+255)
	cp c,0
	jr nz,L1899
	ld wa,1
	jr L1900
L1899:
	ld wa,0
L1900:
	jr L1898
L1898:
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
	jr L1912
L1909:
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
L1911:
	inc 1,iz
L1912:
	ld wa,iz
	cp wa,252
	jr ult,L1909
L1910:
	ld xbc,(xsp+0)
	ld c,(xbc+252)
	ld e,ixl
	cp c,e
	jr nz,L1913
	ld xbc,(xsp+0)
	ld c,(xbc+253)
	ld de,ix
	srl 8,de
	cp c,e
	jr nz,L1913
	ld wa,1
	jr L1914
L1913:
	ld wa,0
L1914:
	jr L1908
L1908:
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
	jr L1916
L1916:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function bank_of
_bank_of__13:
	ld c,(xsp+4)
	cp c,32
	jr ult,L1921
	ld a,32
	extz wa
	jr L1922
L1921:
	ld wa,0
L1922:
	jr L1920
L1920:
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
	jr z,L1942
	cp wa,2
	jr z,L1943
	cp wa,3
	jr z,L1944
	jr L1945
L1942:
	ld xwa,499712
	ld (_s_offset__13),xwa
	jr L1941
L1943:
	ld xwa,1024000
	ld (_s_offset__13),xwa
	jr L1941
L1944:
	ld xwa,2072576
	ld (_s_offset__13),xwa
	jr L1941
L1945:
	ld xwa,0
	ld (_s_offset__13),xwa
	jr L1941
L1941:
	ld xwa,(_s_offset__13)
	cp xwa,0
	jr nz,L1946
	jp L1940
L1946:
	ld xwa,__DataROM_END
	ld xbc,2097152
	add xbc,(_s_offset__13)
	sub xbc,8192
	cp xwa,xbc
	jr ule,L1947
	ld xwa,0
	ld (_s_offset__13),xwa
	jr L1940
L1947:
	ld izl,0
	jr L1951
L1948:
	ld a,izl
	push xwa
	call _slot_looks_valid__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L1952
	jr L1950
L1952:
	ld a,izl
	push xwa
	call _slot_sequence__13
	lda xsp,(xsp+4)
	ld (xsp+2),xwa
	ld a,(_s_current__13)
	cp a,255
	jr z,L1953
	ld xwa,(xsp+2)
	sub xwa,(_s_sequence__13)
	ld (xsp+6),xwa
	ld xwa,(xsp+6)
	cp xwa,0
	jr z,L1955
	ld xwa,(xsp+6)
	cp xwa,2147483648
	jr ult,L1954
L1955:
	jr L1950
L1954:
L1953:
	ld a,izl
	push xwa
	call _slot_crc_ok__13
	lda xsp,(xsp+4)
	cp a,0
	jr z,L1956
	ld a,izl
	ld (_s_current__13),a
	ld xwa,(xsp+2)
	ld (_s_sequence__13),xwa
L1956:
L1950:
	inc 1,izl
L1951:
	ld a,izl
	cp a,64
	jr ult,L1948
L1949:
L1940:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_flash_ready
_ngpc_flash_ready:
	ld xbc,(_s_offset__13)
	cp xbc,0
	jr z,L1961
	ld wa,1
	jr L1962
L1961:
	ld wa,0
L1962:
	jr L1960
L1960:
	ret

; function ngpc_flash_cart_size
_ngpc_flash_cart_size:
	ld a,(06C58h)
	jr L1964
L1964:
	ret

; function ngpc_flash_exists
_ngpc_flash_exists:
	ld c,(_s_current__13)
	cp c,255
	jr z,L1969
	ld wa,1
	jr L1970
L1969:
	ld wa,0
L1970:
	jr L1968
L1968:
	ret

; function ngpc_flash_load
_ngpc_flash_load:
	push xiz
	lda xsp,(xsp-10)
	ld xwa,(xsp+18)
	ld xiy,xwa
	ld a,(_s_current__13)
	cp a,255
	jr nz,L1978
	jr L1977
L1978:
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
	jr L1982
L1979:
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
L1981:
	inc 1,iz
L1982:
	ld wa,iz
	cp wa,256
	jr ult,L1979
L1980:
L1977:
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
	jr nz,L1996
	ld wa,0
	jp L1995
L1996:
	ldb (xsp+8),32
	jr L1999
L1997:
	push xix
	ld a,(xsp+12)
	push xwa
	call _slot_ptr__13
	lda xsp,(xsp+4)
	pop xix
	ld xix,xwa
	ld a,(xix)
	cp a,202
	jr nz,L2001
	ld a,(xix+1)
	cp a,254
	jr nz,L2001
	ld a,(xix+2)
	cp a,32
	jr nz,L2001
	ld a,(xix+3)
	cp a,38
	jr z,L2000
L2001:
	jr L1999
L2000:
	push xix
	ld a,(xsp+12)
	push xwa
	call _slot_looks_valid__13
	lda xsp,(xsp+4)
	pop xix
	cp a,0
	jr z,L2002
	push xix
	ld a,(xsp+12)
	push xwa
	call _slot_crc_ok__13
	lda xsp,(xsp+4)
	pop xix
	cp a,0
	jr z,L2002
	jr L1999
L2002:
	ld iz,0
	jr L2006
L2003:
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
L2005:
	inc 1,iz
L2006:
	ld wa,iz
	cp wa,256
	jr ult,L2003
L2004:
	ld wa,1
	jr L1995
L1999:
	ld a,(xsp+8)
	decb 1,(xsp+8)
	cp a,0
	jp ugt,L1997
L1998:
	ld wa,0
	jr L1995
L1995:
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
	jr z,L2017
	ld a,(_s_last_slot__13)
	cp a,255
	jr nz,L2016
L2017:
	ld wa,65535
	jr L2015
L2016:
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
	jr L2021
L2018:
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
	jr z,L2022
	inc 1,ix
L2022:
L2020:
	inc 1,iz
L2021:
	ld wa,iz
	cp wa,256
	jr ult,L2018
L2019:
	ld wa,ix
	jr L2015
L2015:
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
	jr nz,L2033
	ld wa,0
	jr L2034
L2033:
	ld a,(_s_current__13)
	push xwa
	call _bank_of__13
	lda xsp,(xsp+4)
	extz wa
L2034:
	ld (xsp+2),a
	ld xwa,(_s_offset__13)
	cp xwa,0
	jr nz,L2035
	ld wa,0
	jr L2032
L2035:
	ld a,(xsp+2)
	ld izl,a
	jr L2039
L2036:
	ld a,izl
	push xwa
	call _slot_erased__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2040
	incb 1,(xsp+1)
L2040:
L2038:
	inc 1,izl
L2039:
	ld a,izl
	ld c,(xsp+2)
	add c,32
	cp a,c
	jr ult,L2036
L2037:
	ld a,(xsp+1)
	jr L2032
L2032:
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
	jr L2051
L2048:
	ld a,izl
	push xwa
	call _slot_erased__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2052
	ld wa,0
	jr L2047
L2052:
L2050:
	inc 1,izl
L2051:
	ld a,izl
	ld c,(xsp+10)
	add c,32
	cp a,c
	jr ult,L2048
L2049:
	ld wa,1
	jr L2047
L2047:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_flash_erase
_ngpc_flash_erase:
	ld xwa,(_s_offset__13)
	cp xwa,0
	jr nz,L2058
	ld wa,0
	jr L2057
L2058:
	ld wa,0
	push xwa
	call _erase_bank__13
	lda xsp,(xsp+4)
	cp a,0
	jr z,L2060
	ld a,32
	push xwa
	call _erase_bank__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2059
L2060:
	call _ngpc_flash_init
	ld wa,0
	jr L2057
L2059:
	ldb (_s_current__13),255
	ldb (_s_last_slot__13),255
	ld xwa,0
	ld (_s_sequence__13),xwa
	ld wa,1
	jr L2057
L2057:
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
	jr nz,L2092
	ld wa,0
	jp L2091
L2092:
	ld xwa,(xsp+0)
	ld a,(xwa)
	cp a,202
	jr nz,L2094
	ld xwa,(xsp+0)
	ld a,(xwa+1)
	cp a,254
	jr nz,L2094
	ld xwa,(xsp+0)
	ld a,(xwa+2)
	cp a,32
	jr nz,L2094
	ld xwa,(xsp+0)
	ld a,(xwa+3)
	cp a,38
	jr z,L2093
L2094:
	ld wa,0
	jp L2091
L2093:
	ld c,(_s_current__13)
	cp c,255
	jr nz,L2095
	ld wa,0
	jr L2096
L2095:
	ld a,(_s_current__13)
	push xwa
	call _bank_of__13
	lda xsp,(xsp+4)
	extz wa
L2096:
	ld (xsp+5),a
	ld c,(_s_current__13)
	cp c,255
	jr nz,L2097
	ld a,(xsp+5)
	extz wa
	jr L2098
L2097:
	ld a,(_s_current__13)
	add a,1
	extz wa
L2098:
	ld (xsp+4),a
	jr L2101
L2099:
	incb 1,(xsp+4)
L2101:
	ld a,(xsp+4)
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr uge,L2102
	ld a,(xsp+4)
	push xwa
	call _slot_erased__13
	lda xsp,(xsp+4)
	cp a,0
	jr z,L2099
L2102:
L2100:
	ld a,(xsp+4)
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr ult,L2103
	ld a,(xsp+5)
	xor a,32
	ld (xsp+5),a
	ld a,(xsp+5)
	ld izl,a
	jr L2107
L2104:
	ld a,izl
	push xwa
	call _slot_erased__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2108
	jr L2105
L2108:
L2106:
	inc 1,izl
L2107:
	ld a,izl
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr ult,L2104
L2105:
	ld a,izl
	ld c,(xsp+5)
	add c,32
	cp a,c
	jr z,L2109
	ld a,(xsp+5)
	push xwa
	call _erase_bank__13
	lda xsp,(xsp+4)
	cp a,0
	jr nz,L2109
	ld wa,0
	jp L2091
L2109:
	ld a,(xsp+5)
	ld (xsp+4),a
L2103:
	ld xwa,(_s_sequence__13)
	add xwa,1
	ld (xsp+12),xwa
	ld izl,0
	jr L2113
L2110:
	ld xwa,(xsp+12)
	ld c,izl
	extz bc
	sll 3,bc
	cp c,0
	jr z,L2115
L2114:
	srl 1,xwa
	djnz c,L2114
L2115:
	ld xbc,(xsp+0)
	ld de,248
	ld l,izl
	extz hl
	add de,hl
	extz xde
	add xbc,xde
	ld (xbc),a
L2112:
	inc 1,izl
L2113:
	ld a,izl
	cp a,4
	jr ult,L2110
L2111:
	ldw (xsp+8),0
	jr L2119
L2116:
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
L2118:
	incw 1,(xsp+8)
L2119:
	ld wa,(xsp+8)
	cp wa,252
	jr ult,L2116
L2117:
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
	jr z,L2120
	ld wa,0
	jr L2091
L2120:
	ld a,(xsp+4)
	ld (_s_current__13),a
	ld xwa,(xsp+12)
	ld (_s_sequence__13),xwa
	ld wa,1
	jr L2091
L2091:
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
L2122:
	lda xsp,(xsp+2)
	ret

; function ngpc_input_set_repeat
_ngpc_input_set_repeat:
	ld a,(xsp+4)
	ld (_s_repeat_delay__14),a
	ld a,(xsp+8)
	ld (_s_repeat_rate__14),a
L2124:
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
	jp L2140
L2137:
	ld a,(xsp+2)
	extz wa
	ld c,(xsp+1)
	extz bc
	and wa,bc
	cp wa,0
	jr z,L2141
	ld a,(_ngpc_pad_pressed)
	extz wa
	ld c,(xsp+1)
	extz bc
	and wa,bc
	cp wa,0
	jr z,L2142
	ld a,(_s_repeat_delay__14)
	ld xbc,_s_repeat_timer__14
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	jr L2143
L2142:
	ld xwa,_s_repeat_timer__14
	ld c,(xsp+0)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr ule,L2144
	ld xbc,_s_repeat_timer__14
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld a,(xbc)
	dec 1,a
	ld (xbc),a
	jr L2145
L2144:
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
L2145:
L2143:
	jr L2146
L2141:
	ld a,0
	ld xbc,_s_repeat_timer__14
	ld e,(xsp+0)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2146:
	ld a,(xsp+1)
	extz wa
	sll 1,wa
	ld (xsp+1),a
L2139:
	incb 1,(xsp+0)
L2140:
	ld a,(xsp+0)
	cp a,8
	jp ult,L2137
L2138:
	ld a,(xsp+2)
	ld (_s_pad_prev__14),a
L2136:
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
	jr L2157
L2155:
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
L2157:
	ld xwa,xix
	cp xwa,(xsp+4)
	jr ult,L2155
L2156:
	jr L2160
L2158:
	ld a,0
	ld xbc,xiz
	inc 1,xbc
	ld xiz,xbc
	dec 1,xbc
	ld (xbc),a
L2160:
	ld xwa,xiz
	cp xwa,(xsp+16)
	jr ult,L2158
L2159:
L2154:
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
L2162:
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
L2164:
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
	jr z,L2168
	ld xwa,(_g_vb_hook__15)
	ld xhl,xwa
	call (xhl)
L2168:
	call _ngpc_vramq_flush
	incb 1,(_g_vb_counter)
	call _ngpc_input_vblank
L2167:
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
	jr z,L2177
	ld wa,1
	jr L2178
L2177:
	ld wa,0
L2178:
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
	jr L2182
L2179:
	ld wa,0
	ld xbc,40960
	ld e,(xsp+0)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L2181:
	incb 1,(xsp+0)
L2182:
	ld a,(xsp+0)
	cp a,8
	jr ult,L2179
L2180:
	ei
L2176:
	lda xsp,(xsp+2)
	ret

; function ngpc_is_color
_ngpc_is_color:
	ld a,(_s_is_color__15)
	jr L2184
L2184:
	ret

; function ngpc_get_language
_ngpc_get_language:
	ld a,(_s_language__15)
	jr L2186
L2186:
	ret

; function ngpc_shutdown_reason
_ngpc_shutdown_reason:
	push xiz
	lda xsp,(xsp-6)
	ld a,(xsp+14)
	extz wa
	and wa,32
	cp wa,0
	jr z,L2202
	ld iy,15
	jr L2203
L2202:
	ld a,(xsp+14)
	extz wa
	and wa,128
	cp wa,0
	jr z,L2204
	ld iy,4095
	jr L2205
L2204:
	ld a,(xsp+14)
	extz wa
	and wa,64
	cp wa,0
	jr z,L2206
	ld iy,240
	jr L2207
L2206:
	ld iy,3840
L2207:
L2205:
L2203:
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
	jr L2211
L2208:
	ld a,(_g_vb_counter)
	ld ixl,a
	jr L2214
L2212:
L2214:
	ld a,(_g_vb_counter)
	cp a,ixl
	jr z,L2212
L2213:
L2210:
	inc 1,iz
L2211:
	ld wa,iz
	cp wa,180
	jr ult,L2208
L2209:
	push xix
	push xiy
	call _ngpc_shutdown
	pop xiy
	pop xix
L2201:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_shutdown
_ngpc_shutdown:
	ldb ra3, 3
	ldb rw3, 0
	swi 1
L2216:
	ret

; function ngpc_load_sysfont
_ngpc_load_sysfont:
	push xiz
	lda xsp,(xsp-6)
	ld xwa,41472
	ld xix,xwa
	ld iz,0
	jr L2226
L2223:
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
L2225:
	inc 1,iz
L2226:
	ld wa,iz
	cp wa,768
	jr ult,L2223
L2224:
L2222:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_memcpy
_ngpc_memcpy:
	push xiz
	ld xix,(xsp+8)
	ld xiz,(xsp+12)
	ld iy,(xsp+16)
	jr L2234
L2232:
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
L2234:
	ld wa,iy
	dec 1,iy
	cp wa,0
	jr nz,L2232
L2233:
L2231:
	pop xiz
	ret

; function ngpc_memset
_ngpc_memset:
	push xiz
	ld xiz,(xsp+8)
	ld a,(xsp+12)
	ld iyl,a
	ld ix,(xsp+16)
	jr L2242
L2240:
	ld a,iyl
	ld xbc,xiz
	inc 1,xbc
	ld xiz,xbc
	dec 1,xbc
	ld (xbc),a
L2242:
	ld wa,ix
	dec 1,ix
	cp wa,0
	jr nz,L2240
L2241:
L2239:
	pop xiz
	ret

; function ngpc_vsync
_ngpc_vsync:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_g_vb_counter)
	ld izl,a
	jr L2253
L2251:
L2253:
	ld a,(_g_vb_counter)
	cp a,izl
	jr z,L2251
L2252:
	ld a,(06F85h)
	cp a,0
	jr z,L2254
	ld a,(06F85h)
	push xwa
	call _ngpc_shutdown_reason
	lda xsp,(xsp+4)
L2254:
L2249:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_in_vblank
_ngpc_in_vblank:
	ld c,(08010h)
	extz bc
	and bc,64
	cp bc,0
	jr z,L2259
	ld wa,1
	jr L2260
L2259:
	ld wa,0
L2260:
	jr L2258
L2258:
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
	jr L2270
L2267:
	call _ngpc_vsync
L2269:
	inc 1,izl
L2270:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L2267
L2268:
	ld wa,0
	push xwa
	call _ngpc_cpu_speed
	lda xsp,(xsp+4)
L2266:
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
L2272:
	ret

; function dst_range_ok
_dst_range_ok__17:
	push xiz
	lda xsp,(xsp-12)
	ld xwa,(xsp+20)
	cp xwa,0
	jr z,L2280
	ld wa,(xsp+24)
	cp wa,0
	jr nz,L2279
L2280:
	ld wa,0
	jr L2278
L2279:
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
	jr uge,L2281
	ld wa,0
	jr L2278
L2281:
	ld xwa,(xsp+8)
	cp xwa,49151
	jr ule,L2282
	ld wa,0
	jr L2278
L2282:
	ld wa,1
	jr L2278
L2278:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function ngpc_vramq_init
_ngpc_vramq_init:
	ldb (_s_cmd_count__17),0
	ldb (_s_drop_count__17),0
	ldb (_s_lock__17),0
L2284:
	ret

; function ngpc_vramq_copy
_ngpc_vramq_copy:
	push xiz
	lda xsp,(xsp-2)
	ld xwa,(xsp+14)
	cp xwa,0
	jr z,L2291
	ld wa,(xsp+18)
	push xwa
	ld xwa,(xsp+14)
	push xwa
	call _dst_range_ok__17
	lda xsp,(xsp+8)
	cp a,0
	jr nz,L2290
L2291:
	ld wa,0
	jp L2289
L2290:
	ldb (_s_lock__17),1
	ld a,(_s_cmd_count__17)
	ld izl,a
	ld a,izl
	cp a,16
	jr ult,L2292
	incb 1,(_s_drop_count__17)
	ldb (_s_lock__17),0
	ld wa,0
	jr L2289
L2292:
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
	jr L2289
L2289:
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
	jr nz,L2297
	ld wa,0
	jp L2296
L2297:
	ldb (_s_lock__17),1
	ld a,(_s_cmd_count__17)
	ld izl,a
	ld a,izl
	cp a,16
	jr ult,L2298
	incb 1,(_s_drop_count__17)
	ldb (_s_lock__17),0
	ld wa,0
	jr L2296
L2298:
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
	jr L2296
L2296:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_vramq_flush
_ngpc_vramq_flush:
	push xiz
	lda xsp,(xsp-10)
	ld a,(_s_lock__17)
	cp a,0
	jr z,L2313
	jp L2312
L2313:
	ld a,(_s_cmd_count__17)
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,0
	jr nz,L2314
	jp L2312
L2314:
	ldb (_s_lock__17),1
	ld izl,0
	jp L2318
L2315:
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
	jr nz,L2319
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
	jr L2320
L2319:
	ld xwa,_s_cmd_type__17
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,2
	jr nz,L2321
	ld xwa,_s_cmd_fill__17
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	ld (xsp+8),wa
	jr L2324
L2322:
	ld wa,(xsp+8)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L2324:
	ld wa,iy
	dec 1,iy
	cp wa,0
	jr nz,L2322
L2323:
L2321:
L2320:
L2317:
	inc 1,izl
L2318:
	ld a,izl
	cp a,(xsp+1)
	jp ult,L2315
L2316:
	ldb (_s_cmd_count__17),0
	ldb (_s_lock__17),0
L2312:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_vramq_clear
_ngpc_vramq_clear:
	ld a,(_s_lock__17)
	cp a,0
	jr z,L2328
	jr L2327
L2328:
	ldb (_s_cmd_count__17),0
L2327:
	ret

; function ngpc_vramq_pending
_ngpc_vramq_pending:
	ld a,(_s_cmd_count__17)
	jr L2330
L2330:
	ret

; function ngpc_vramq_dropped
_ngpc_vramq_dropped:
	ld a,(_s_drop_count__17)
	jr L2332
L2332:
	ret

; function ngpc_vramq_clear_dropped
_ngpc_vramq_clear_dropped:
	ldb (_s_drop_count__17),0
L2334:
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
	jr L2336
L2336:
	ret

; function rndn
_rndn__18:
	call _rnd16__18
	extz xwa
	div xwa,(xsp+4)
	ld wa,qwa
	jr L2338
L2338:
	ret

; function stage_of
_stage_of__18:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld ixl,a
	ld wa,0
	ld izl,a
	jr L2347
L2345:
	inc 1,izl
L2347:
	ld a,izl
	extz wa
	add wa,1
	cp wa,5
	jr uge,L2348
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
	jr ule,L2345
L2348:
L2346:
	ld a,izl
	jr L2344
L2344:
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
L2350:
	ret

; function slope_for
_slope_for__18:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	cp a,0
	jr z,L2358
	ld wa,100
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld bc,18
	ld e,(xsp+10)
	extz de
	mul xbc,de
	cp wa,bc
	jr uge,L2358
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
	jr nz,L2359
	ld a,(xsp+10)
	neg a
	ld izl,a
L2359:
	ld a,(xsp+0)
	cp a,3
	jr nz,L2360
	ld a,(xsp+10)
	ld izl,a
L2360:
	ld a,izl
	cp a,252
	jr ge,L2361
	ld izl,252
L2361:
	ld a,izl
	cp a,3
	jr le,L2362
	ld izl,3
L2362:
	ld a,izl
	jr L2357
L2358:
	ld wa,0
	jr L2357
L2357:
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
	jr uge,L2367
	ld iz,52
L2367:
	ld wa,iz
	cp wa,72
	jr ule,L2368
	ld iz,72
L2368:
	ld wa,iz
	jr L2366
L2366:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function gen_leg
_gen_leg__18:
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
	ld xwa,(xsp+42)
	ld (_gp__18),xwa
	ldb (_gn__18),0
	ld wa,(_free_seed)
	ld c,(xsp+38)
	extz bc
	add bc,1
	mul xbc,40503
	xor wa,bc
	ld (_rs__18),wa
	ld wa,(_rs__18)
	cp wa,0
	jr nz,L2393
	ldw (_rs__18),44257
L2393:
	call _rnd16__18
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,900
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	jp L2396
L2394:
	ld wa,1000
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld (xsp+18),wa
	push xwa
	ld wa,1000
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp bc,600
	jr uge,L2397
	ld wa,(xsp+16)
	neg wa
	jr L2398
L2397:
	ld wa,(xsp+16)
L2398:
	ld (xsp+20),wa
	ld wa,(xsp+18)
	cp wa,(xsp+8)
	jp uge,L2399
	ld xwa,(xsp+0)
	ld a,(xwa+16)
	push xwa
	call _sharp__18
	lda xsp,(xsp+4)
	ld (xsp+22),wa
	ld xwa,(xsp+0)
	ld a,(xwa+16)
	push xwa
	call _sharp__18
	lda xsp,(xsp+4)
	ld (xsp+24),wa
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
	ld (xsp+26),wa
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
	ld (xsp+28),wa
	push xwa
	ld wa,2
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp bc,0
	jr z,L2400
	ld wa,500
	jr L2401
L2400:
	ld wa,400
L2401:
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
	ld wa,(xsp+24)
	mul xwa,(xsp+26)
	push xwa
	ld wa,(xsp+34)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld wa,(xsp+28)
	cp wa,0
	jr z,L2402
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,(xsp+36)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
L2402:
	ld wa,0
	push xwa
	ld wa,(xsp+24)
	neg wa
	mul xwa,(xsp+28)
	push xwa
	ld wa,(xsp+34)
	push xwa
	call _put__18
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
	jp L2403
L2399:
	ld wa,(xsp+18)
	ld bc,(xsp+8)
	add bc,(xsp+6)
	cp wa,bc
	jp uge,L2404
	push xwa
	ld wa,2
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,xwa
	pop xwa
	cp bc,0
	jr z,L2405
	ld wa,500
	jr L2406
L2405:
	ld wa,400
L2406:
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
	ld (xsp+22),wa
	ld wa,0
	push xwa
	ld wa,(xsp+24)
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
	ld wa,(xsp+30)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld wa,iz
	add wa,450
	add wa,(xsp+22)
	ld iz,wa
	ld wa,(xsp+20)
	ld (xsp+16),wa
	jp L2407
L2404:
	ld wa,100
	push xwa
	call _rndn__18
	lda xsp,(xsp+4)
	ld xbc,(xsp+0)
	ld c,(xbc+18)
	extz bc
	cp wa,bc
	jr uge,L2408
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
	ld (xsp+22),wa
	ld xwa,(xsp+0)
	ld a,(xwa+17)
	push xwa
	call _slope_for__18
	lda xsp,(xsp+4)
	push xwa
	ld wa,0
	push xwa
	ld wa,(xsp+30)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld wa,iz
	add wa,(xsp+22)
	ld iz,wa
	jp L2409
L2408:
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
	ld (xsp+22),wa
	ld xwa,_easy_bends__18
	push xwa
	ld c,(xsp+8)
	cp c,1
	jr ult,L2410
	ld wa,5
	jr L2411
L2410:
	ld wa,3
L2411:
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
	jr uge,L2412
	ldw (xsp+24),18
L2412:
	ld wa,(xsp+24)
	cp wa,48
	jr ule,L2413
	ldw (xsp+24),48
L2413:
	ld xwa,(xsp+0)
	ld a,(xwa+17)
	push xwa
	call _slope_for__18
	lda xsp,(xsp+4)
	push xwa
	ld wa,(xsp+24)
	ld bc,(xsp+28)
	mul xwa,bc
	push xwa
	ld wa,(xsp+30)
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld wa,iz
	add wa,(xsp+22)
	ld iz,wa
	ld wa,(xsp+20)
	ld (xsp+16),wa
L2409:
L2407:
L2403:
L2396:
	ld wa,iz
	cp wa,11700
	jr uge,L2414
	ld a,(_gn__18)
	cp a,30
	jp ule,L2394
L2414:
L2395:
	ld wa,0
	push xwa
	ld wa,0
	push xwa
	ld wa,2400
	push xwa
	call _put__18
	lda xsp,(xsp+12)
	ld a,(_gn__18)
	jr L2392
L2392:
	lda xsp,(xsp+30)
	pop xiz
	ret

; function cost_of
_cost_of__18:
	push xiz
	lda xsp,(xsp-10)
	ld xwa,0
	ld (xsp+0),xwa
	ld ixl,0
	jr L2429
L2426:
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
	jr ge,L2430
	ld wa,iy
	neg wa
	ld iy,wa
L2430:
	jr L2433
L2431:
	dec 1,iz
L2433:
	ld wa,iz
	cp wa,6
	jr ule,L2434
	ld wa,iz
	mul xwa,iz
	ld bc,iy
	mul xwa,bc
	cp wa,6000
	jr ugt,L2431
L2434:
L2432:
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
L2428:
	inc 1,ixl
L2429:
	ld a,ixl
	cp a,(xsp+22)
	jr ult,L2426
L2427:
	ld xwa,(xsp+0)
	srl 4,xwa
	jr L2425
L2425:
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
L2436:
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
	jr nz,L2446
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
	jr L2447
L2446:
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
	jr ule,L2448
	ld a,71
	sub a,iyl
	ld ixl,a
L2448:
	ld izl,0
	jr L2452
L2449:
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
L2451:
	inc 1,izl
L2452:
	ld a,izl
	cp a,ixl
	jr ult,L2449
L2450:
L2447:
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
	jr L2445
L2445:
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
	jr L2462
L2459:
	ld wa,(_leg_len)
	ld xbc,_buf__18
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld (_leg_len),wa
L2461:
	inc 1,izl
L2462:
	ld a,izl
	cp a,(_n_cur__18)
	jr ult,L2459
L2460:
	ldb (_fork_choice),0
L2458:
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
	jr L2483
L2480:
	ld a,0
	ld xbc,_route_hist
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L2482:
	inc 1,izl
L2483:
	ld a,izl
	cp a,5
	jr ult,L2480
L2481:
	ld izl,0
	jr L2487
L2484:
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
L2486:
	inc 1,izl
L2487:
	ld a,izl
	cp a,15
	jr ult,L2484
L2485:
	ld a,(_difficulty)
	cp a,3
	jp nz,L2488
	ld wa,(_free_seed)
	cp wa,0
	jr nz,L2489
	ldw (_free_seed),24301
L2489:
	ld wa,(_free_seed)
	xor wa,15450
	ld (_rs__18),wa
	ld wa,(_rs__18)
	cp wa,0
	jr nz,L2490
	ldw (_rs__18),44257
L2490:
	ld izl,14
	jr L2494
L2491:
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
L2493:
	dec 1,izl
L2494:
	ld a,izl
	cp a,0
	jr ugt,L2491
L2492:
L2488:
	call _load_current__18
L2479:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function course_is_last_stage
_course_is_last_stage:
	ld c,(_cur_stage)
	extz bc
	add bc,1
	cp bc,5
	jr ult,L2499
	ld wa,1
	jr L2500
L2499:
	ld wa,0
L2500:
	jr L2498
L2498:
	ret

; function course_fork_zone
_course_fork_zone:
	ld bc,(xsp+4)
	add bc,2400
	cp bc,(_leg_len)
	jr ult,L2505
	ld wa,1
	jr L2506
L2505:
	ld wa,0
L2506:
	jr L2504
L2504:
	ret

; function course_start_zone
_course_start_zone:
	ld c,(_cur_stage)
	cp c,0
	jr z,L2511
	ld bc,(xsp+4)
	cp bc,900
	jr uge,L2511
	ld wa,1
	jr L2512
L2511:
	ld wa,0
L2512:
	jr L2510
L2510:
	ret

; function course_decide
_course_decide:
	push xiz
	lda xsp,(xsp-2)
	ld a,(_fork_choice)
	cp a,0
	jr nz,L2525
	call _course_is_last_stage
	cp a,0
	jr z,L2524
L2525:
	jp L2523
L2524:
	ld c,(xsp+10)
	cp c,0
	jr z,L2526
	ld wa,2
	jr L2527
L2526:
	ld wa,1
L2527:
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
	jr z,L2528
	ld de,1
	jr L2529
L2528:
	ld de,0
L2529:
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
	jr z,L2530
	ld c,(xsp+10)
	cp c,0
	jr z,L2531
	ld wa,65486
	jr L2532
L2531:
	ld wa,50
L2532:
	ld xbc,_buf__18
	ld e,(_n_cur__18)
	extz de
	muls xde,6
	add xbc,xde
	ld (xbc+2),wa
L2530:
	ld a,(_n_cur__18)
	add a,izl
	push xwa
	call _put_placeholder__18
	lda xsp,(xsp+4)
	ld a,(_n_cur__18)
	add a,izl
	add a,1
	ld (_track_len),a
L2523:
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
	jr z,L2547
	ld wa,0
	jp L2546
L2547:
	ld a,(_fork_choice)
	cp a,0
	jr nz,L2548
	push xix
	ld wa,0
	push xwa
	call _course_decide
	lda xsp,(xsp+4)
	pop xix
L2548:
	ld a,(_n_cur__18)
	ld ixl,a
	ld izl,0
	jr L2552
L2549:
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
L2551:
	inc 1,izl
L2552:
	ld a,izl
	add a,ixl
	cp a,(_track_len)
	jr ult,L2549
L2550:
	ld a,(_track_len)
	sub a,ixl
	ld (_track_len),a
	ld a,(_fork_choice)
	cp a,2
	jr nz,L2553
	incb 1,(_cur_branch)
L2553:
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
	jr ult,L2554
	ld a,(_track_len)
	sub a,1
	ld (_n_cur__18),a
L2554:
	ldw (_leg_len),0
	ld izl,0
	jr L2558
L2555:
	ld wa,(_leg_len)
	ld xbc,_buf__18
	ld e,izl
	extz de
	muls xde,6
	add xbc,xde
	ld bc,(xbc)
	add wa,bc
	ld (_leg_len),wa
L2557:
	inc 1,izl
L2558:
	ld a,izl
	cp a,(_n_cur__18)
	jr ult,L2555
L2556:
	ldb (_fork_choice),0
	ld a,ixl
	jr L2546
L2546:
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
L2560:
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
	jr L2562
L2562:
	ret

; function ending_start
_ending_start:
	push xiz
	lda xsp,(xsp-8)
	ld a,(xsp+16)
	cp a,5
	jr ule,L2574
	ldb (xsp+16),5
L2574:
	ld xwa,_endings__19
	ld c,(xsp+16)
	extz bc
	exts xbc
	sll 4,xbc
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+0),xwa
	ldw (xsp+4),0
	jr L2578
L2575:
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
L2577:
	incw 1,(xsp+4)
L2578:
	ld wa,(xsp+4)
	cp wa,24
	jr ult,L2575
L2576:
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
	jr L2582
L2579:
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
L2581:
	inc 1,izl
L2582:
	ld a,izl
	cp a,14
	jr ult,L2579
L2580:
L2573:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function pal_of
_pal_of__19:
	ld xwa,_pals__19_L2586
	ld c,(xsp+4)
	extz bc
	and bc,3
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	jr L2585
L2585:
	ret

; function ending_tick
_ending_tick:
	push xiz
	lda xsp,(xsp-14)
	incb 1,(_timer__19)
	ld a,(_fx__19)
	cp a,1
	jp nz,L2624
	ld a,(_timer__19)
	extz wa
	extz xwa
	div xwa,40
	ld wa,qwa
	cp wa,1
	jp nz,L2624
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
	jp L2628
L2625:
	ld a,izl
	and a,7
	ld (xsp+7),a
	ld c,izl
	cp c,8
	jr uge,L2629
	ld wa,2
	jr L2630
L2629:
	ld wa,1
L2630:
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
L2627:
	inc 1,izl
L2628:
	ld a,izl
	cp a,14
	jp ult,L2625
L2626:
L2624:
	ld izl,0
	jp L2634
L2631:
	ld a,56
	add a,izl
	ld (xsp+1),a
	ld a,(_fx__19)
	extz wa
	cp wa,1
	jr z,L2636
	cp wa,2
	jp z,L2637
	cp wa,3
	jp z,L2638
	cp wa,4
	jp z,L2639
	jp L2640
L2636:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L2641
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
L2641:
	jp L2635
L2637:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L2643
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2400
	jp le,L2642
L2643:
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
L2642:
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
	jr z,L2644
	ld bc,6
	jr L2645
L2644:
	ld bc,65530
L2645:
	add wa,bc
	ld xbc,_px__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jp L2635
L2638:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L2647
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65408
	jp ge,L2646
L2647:
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
L2646:
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
	jr z,L2648
	ld bc,3
	jr L2649
L2648:
	ld bc,65533
L2649:
	add wa,bc
	ld xbc,_px__19
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jp L2635
L2639:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp nz,L2650
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
	jr z,L2651
	ld wa,2
	jr L2652
L2651:
	ld wa,9
L2652:
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
	jr L2653
L2650:
	ld xbc,_life__19
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld a,(xbc)
	dec 1,a
	ld (xbc),a
L2653:
	jr L2635
L2640:
	jr L2635
L2635:
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jp z,L2655
	ld xwa,_px__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65424
	jr lt,L2655
	ld xwa,_px__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2544
	jr gt,L2655
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65424
	jr lt,L2655
	ld xwa,_py__19
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,2416
	jr gt,L2655
	ld a,(_fx__19)
	cp a,4
	jr nz,L2654
	ld xwa,_life__19
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	and wa,4
	cp wa,0
	jr z,L2654
L2655:
	ld a,(xsp+1)
	add a,1
	push xwa
	ld a,(xsp+5)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	jp L2633
L2654:
L2656:
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
L2658:
L2657:
L2633:
	inc 1,izl
L2634:
	ld a,izl
	cp a,14
	jp ult,L2631
L2632:
L2623:
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
L2660:
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
L2662:
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
L2664:
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
L2666:
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
L2668:
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
L2670:
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
L2672:
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
L2674:
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
L2676:
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
L2678:
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
L2680:
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
L2682:
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
L2684:
	ret

; function dma0_clear
_dma0_clear__20:
	ld wa,0
	ldc dmac0,wa
	ld a,0
	ldc dmam0,a
L2686:
	ret

; function dma1_clear
_dma1_clear__20:
	ld wa,0
	ldc dmac1,wa
	ld a,0
	ldc dmam1,a
L2688:
	ret

; function dma2_clear
_dma2_clear__20:
	ld wa,0
	ldc dmac2,wa
	ld a,0
	ldc dmam2,a
L2690:
	ret

; function dma3_clear
_dma3_clear__20:
	ld wa,0
	ldc dmac3,wa
	ld a,0
	ldc dmam3,a
L2692:
	ret

; function dma_set_start_vector
_dma_set_start_vector__20:
	push xiz
	ld a,(xsp+12)
	ld izl,a
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2701
	cp wa,1
	jr z,L2702
	cp wa,2
	jr z,L2703
	cp wa,3
	jr z,L2704
	jr L2700
L2701:
	ld a,izl
	ld (07Ch),a
	jr L2700
L2702:
	ld a,izl
	ld (07Dh),a
	jr L2700
L2703:
	ld a,izl
	ld (07Eh),a
	jr L2700
L2704:
	ld a,izl
	ld (07Fh),a
	jr L2700
L2700:
L2699:
	pop xiz
	ret

; function dma_rearm_in_isr
_dma_rearm_in_isr__20:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	jr L2730
	jp L2729
L2730:
	ld a,izl
	cp a,3
	jr ule,L2731
	jp L2729
L2731:
	ld xwa,_s_rearm_enabled__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L2732
	jp L2729
L2732:
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
	jr z,L2735
	cp wa,1
	jp z,L2736
	cp wa,2
	jp z,L2737
	jr L2734
L2734:
L2735:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L2739
	cp wa,1
	jr z,L2740
	cp wa,2
	jp z,L2741
	cp wa,3
	jp z,L2742
	jp L2738
L2739:
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
	jp L2738
L2740:
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
	jp L2738
L2741:
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
	jr L2738
L2742:
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
	jr L2738
L2738:
	jp L2733
L2736:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L2744
	cp wa,1
	jr z,L2745
	cp wa,2
	jp z,L2746
	cp wa,3
	jp z,L2747
	jp L2743
L2744:
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
	jp L2743
L2745:
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
	jp L2743
L2746:
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
	jr L2743
L2747:
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
	jr L2743
L2743:
	jp L2733
L2737:
	ld a,izl
	extz wa
	cp wa,0
	jr z,L2749
	cp wa,1
	jr z,L2750
	cp wa,2
	jp z,L2751
	cp wa,3
	jp z,L2752
	jp L2748
L2749:
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
	jp L2748
L2750:
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
	jp L2748
L2751:
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
	jr L2748
L2752:
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
	jr L2748
L2748:
	jr L2733
L2733:
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
L2729:
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
	jr L2758
	ldb (_s_done_flag__20),1
L2758:
	ld wa,0
	push xwa
	call _dma_rearm_in_isr__20
	lda xsp,(xsp+4)
	jr L2759
	ld xwa,(_s_done_cb__20)
	cp xwa,0
	jr z,L2760
	ld xwa,(_s_done_cb__20)
	ld xhl,xwa
	call (xhl)
L2760:
L2759:
L2757:
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
	jr L2766
	ldb (_s_done_flag__20+1),1
L2766:
	ld wa,1
	push xwa
	call _dma_rearm_in_isr__20
	lda xsp,(xsp+4)
	jr L2767
	ld xwa,(_s_done_cb__20+4)
	cp xwa,0
	jr z,L2768
	ld xwa,(_s_done_cb__20+4)
	ld xhl,xwa
	call (xhl)
L2768:
L2767:
L2765:
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
	jr L2774
	ldb (_s_done_flag__20+2),1
L2774:
	ld wa,2
	push xwa
	call _dma_rearm_in_isr__20
	lda xsp,(xsp+4)
	jr L2775
	ld xwa,(_s_done_cb__20+8)
	cp xwa,0
	jr z,L2776
	ld xwa,(_s_done_cb__20+8)
	ld xhl,xwa
	call (xhl)
L2776:
L2775:
L2773:
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
	jr L2782
	ldb (_s_done_flag__20+3),1
L2782:
	ld wa,3
	push xwa
	call _dma_rearm_in_isr__20
	lda xsp,(xsp+4)
	jr L2783
	ld xwa,(_s_done_cb__20+12)
	cp xwa,0
	jr z,L2784
	ld xwa,(_s_done_cb__20+12)
	ld xhl,xwa
	call (xhl)
L2784:
L2783:
L2781:
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
	jr ule,L2811
	jp L2810
L2811:
	ld xwa,(xsp+12)
	cp xwa,0
	jr z,L2813
	ld xwa,(xsp+16)
	cp xwa,0
	jr nz,L2812
L2813:
	jp L2810
L2812:
	ld wa,iz
	cp wa,0
	jr nz,L2814
	jp L2810
L2814:
	ld a,(xsp+24)
	cp a,11
	jr nz,L2815
	jp L2810
L2815:
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
	jr z,L2817
	cp wa,1
	jr z,L2818
	cp wa,2
	jp z,L2819
	jp L2816
L2817:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2821
	cp wa,1
	jr z,L2822
	cp wa,2
	jr z,L2823
	cp wa,3
	jr z,L2824
	jr L2820
L2821:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program__20
	lda xsp,(xsp+12)
	jr L2820
L2822:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program__20
	lda xsp,(xsp+12)
	jr L2820
L2823:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program__20
	lda xsp,(xsp+12)
	jr L2820
L2824:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program__20
	lda xsp,(xsp+12)
	jr L2820
L2820:
	jp L2816
L2818:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2826
	cp wa,1
	jr z,L2827
	cp wa,2
	jr z,L2828
	cp wa,3
	jr z,L2829
	jr L2825
L2826:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program_u16__20
	lda xsp,(xsp+12)
	jr L2825
L2827:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program_u16__20
	lda xsp,(xsp+12)
	jr L2825
L2828:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program_u16__20
	lda xsp,(xsp+12)
	jr L2825
L2829:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program_u16__20
	lda xsp,(xsp+12)
	jr L2825
L2825:
	jr L2816
L2819:
	ld a,(xsp+8)
	extz wa
	cp wa,0
	jr z,L2831
	cp wa,1
	jr z,L2832
	cp wa,2
	jr z,L2833
	cp wa,3
	jr z,L2834
	jr L2830
L2831:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma0_program_u32__20
	lda xsp,(xsp+12)
	jr L2830
L2832:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma1_program_u32__20
	lda xsp,(xsp+12)
	jr L2830
L2833:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma2_program_u32__20
	lda xsp,(xsp+12)
	jr L2830
L2834:
	ld wa,iz
	push xwa
	ld xwa,(xsp+16)
	push xwa
	ld xwa,(xsp+24)
	push xwa
	call _dma3_program_u32__20
	lda xsp,(xsp+12)
	jr L2830
L2830:
	jr L2816
L2816:
	ld a,(xsp+24)
	push xwa
	ld a,(xsp+12)
	push xwa
	call _dma_set_start_vector__20
	lda xsp,(xsp+8)
L2810:
	pop xiz
	ret

; function ngpc_dma_init
_ngpc_dma_init:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jp L2845
L2842:
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
L2844:
	inc 1,izl
L2845:
	ld a,izl
	cp a,4
	jp ult,L2842
L2843:
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
L2846:
L2841:
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
L2848:
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
L2850:
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
L2852:
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
L2854:
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
L2856:
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
L2858:
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
L2860:
	ret

; function ngpc_dma_timer0_hblank_enable
_ngpc_dma_timer0_hblank_enable:
	ld wa,1
	push xwa
	call _ngpc_dma_timer0_hblank_enable_treg0
	lda xsp,(xsp+4)
L2862:
	ret

; function ngpc_dma_timer0_hblank_enable_treg0
_ngpc_dma_timer0_hblank_enable_treg0:
	andb (024h),60
	ld a,(xsp+4)
	ld (022h),a
	orb (020h),1
L2864:
	ret

; function ngpc_dma_timer0_hblank_disable
_ngpc_dma_timer0_hblank_disable:
	andb (020h),254
L2866:
	ret

; function ngpc_dma_timer01_hblank_enable
_ngpc_dma_timer01_hblank_enable:
	andb (024h),48
	ldb (022h),1
	ldb (023h),1
	orb (020h),3
L2868:
	ret

; function ngpc_dma_timer01_hblank_disable
_ngpc_dma_timer01_hblank_disable:
	andb (020h),252
L2870:
	ret

; function ngpc_dma_timer1_from_timer0_enable
_ngpc_dma_timer1_from_timer0_enable:
	ld wa,1
	push xwa
	call _ngpc_dma_timer1_from_timer0_enable_treg1
	lda xsp,(xsp+4)
L2872:
	ret

; function ngpc_dma_timer1_from_timer0_enable_treg1
_ngpc_dma_timer1_from_timer0_enable_treg1:
	andb (024h),243
	ld a,(xsp+4)
	ld (023h),a
	orb (020h),2
L2874:
	ret

; function ngpc_dma_timer1_disable
_ngpc_dma_timer1_disable:
	andb (020h),253
L2876:
	ret

; function ngpc_dma_hblank_stream_begin
_ngpc_dma_hblank_stream_begin:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2880
	jr L2879
L2880:
	ld a,(xsp+12)
	ld (xiz),a
	ld xwa,(xsp+16)
	ld (xiz+2),xwa
	ld xwa,(xsp+20)
	ld (xiz+6),xwa
	ld wa,(xsp+24)
	ld (xiz+10),wa
L2879:
	pop xiz
	ret

; function ngpc_dma_hblank_stream_rearm
_ngpc_dma_hblank_stream_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2884
	jr L2883
L2884:
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
L2883:
	pop xiz
	ret

; function ngpc_dma_hblank_stream_end
_ngpc_dma_hblank_stream_end:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L2888
	jr L2887
L2888:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L2887:
	ret

; function ngpc_dma_stream_begin_u8
_ngpc_dma_stream_begin_u8:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2892
	jr L2891
L2892:
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
L2891:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u8
_ngpc_dma_stream_rearm_u8:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2896
	jr L2895
L2896:
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
L2895:
	pop xiz
	ret

; function ngpc_dma_stream_end_u8
_ngpc_dma_stream_end_u8:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L2900
	jr L2899
L2900:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L2899:
	ret

; function ngpc_dma_stream_begin_u16
_ngpc_dma_stream_begin_u16:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2904
	jr L2903
L2904:
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
L2903:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u16
_ngpc_dma_stream_rearm_u16:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2908
	jr L2907
L2908:
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
L2907:
	pop xiz
	ret

; function ngpc_dma_stream_end_u16
_ngpc_dma_stream_end_u16:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L2912
	jr L2911
L2912:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L2911:
	ret

; function ngpc_dma_stream_begin_u32
_ngpc_dma_stream_begin_u32:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2916
	jr L2915
L2916:
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
L2915:
	pop xiz
	ret

; function ngpc_dma_stream_rearm_u32
_ngpc_dma_stream_rearm_u32:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2920
	jr L2919
L2920:
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
L2919:
	pop xiz
	ret

; function ngpc_dma_stream_end_u32
_ngpc_dma_stream_end_u32:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L2924
	jr L2923
L2924:
	ld xwa,(xsp+4)
	ld a,(xwa)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
L2923:
	ret

; function ngpc_dma_stop
_ngpc_dma_stop:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L2933
	jr L2932
L2933:
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
	jr z,L2935
	cp wa,1
	jr z,L2936
	cp wa,2
	jr z,L2937
	cp wa,3
	jr z,L2938
	jr L2934
L2935:
	call _dma0_clear__20
	jr L2934
L2936:
	call _dma1_clear__20
	jr L2934
L2937:
	call _dma2_clear__20
	jr L2934
L2938:
	call _dma3_clear__20
	jr L2934
L2934:
L2932:
	pop xiz
	ret

; function ngpc_dma_remaining
_ngpc_dma_remaining:
	ld a,(xsp+4)
	extz wa
	cp wa,0
	jr z,L2948
	cp wa,1
	jr z,L2949
	cp wa,2
	jr z,L2950
	cp wa,3
	jr z,L2951
	jr L2952
L2948:
	ldc wa,dmac0
	jr L2946
L2949:
	ldc wa,dmac1
	jr L2946
L2950:
	ldc wa,dmac2
	jr L2946
L2951:
	ldc wa,dmac3
	jr L2946
L2952:
	ld wa,0
	jr L2946
L2947:
L2946:
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
	jr z,L2957
	ld wa,1
	jr L2958
L2957:
	ld wa,0
L2958:
	jr L2956
L2956:
	ret

; function ngpc_dma_set_done_handler
_ngpc_dma_set_done_handler:
	ld a,(xsp+4)
	cp a,3
	jr ule,L2962
	jr L2961
L2962:
	ld xwa,(xsp+8)
	ld xbc,_s_done_cb__20
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L2961:
	ret

; function ngpc_dma_poll_done
_ngpc_dma_poll_done:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L2968
	ld wa,0
	jr L2967
L2968:
	ld xwa,_s_done_flag__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+0),a
	ld a,(xsp+0)
	cp a,0
	jr z,L2969
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
	jr L2967
L2969:
	ld xwa,_s_was_active__20
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L2970
	ld a,izl
	push xwa
	call _ngpc_dma_remaining
	lda xsp,(xsp+4)
	cp wa,0
	jr nz,L2970
	ld a,0
	ld xbc,_s_was_active__20
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,1
	jr L2967
L2970:
	ld wa,0
	jr L2967
L2967:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function ngpc_dma_pp_init
_ngpc_dma_pp_init:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2974
	jr L2973
L2974:
	ld xwa,(xsp+12)
	ld (xiz),xwa
	ld wa,(xsp+16)
	ld (xiz+4),wa
	ldw (xiz+6),0
L2973:
	pop xiz
	ret

; function ngpc_dma_pp_front
_ngpc_dma_pp_front:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr z,L2980
	ld xwa,(xiz)
	cp xwa,0
	jr nz,L2979
L2980:
	ld xwa,0
	jr L2978
L2979:
	ld xwa,(xiz)
	ld bc,(xiz+6)
	extz xbc
	add xwa,xbc
	jr L2978
L2978:
	pop xiz
	ret

; function ngpc_dma_pp_back
_ngpc_dma_pp_back:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr z,L2986
	ld xwa,(xiz)
	cp xwa,0
	jr nz,L2985
L2986:
	ld xwa,0
	jr L2984
L2985:
	ld xwa,(xiz)
	ld bc,(xiz+6)
	xor bc,(xiz+4)
	extz xbc
	add xwa,xbc
	jr L2984
L2984:
	pop xiz
	ret

; function ngpc_dma_pp_swap
_ngpc_dma_pp_swap:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L2990
	jr L2989
L2990:
	ld wa,(xiz+6)
	xor wa,(xiz+4)
	ld (xiz+6),wa
L2989:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u8
_ngpc_dma_autorearm_begin_u8:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L2994
	jr L2993
L2994:
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
L2993:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u16
_ngpc_dma_autorearm_begin_u16:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L2998
	jr L2997
L2998:
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
L2997:
	pop xiz
	ret

; function ngpc_dma_autorearm_begin_u32
_ngpc_dma_autorearm_begin_u32:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L3002
	jr L3001
L3002:
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
L3001:
	pop xiz
	ret

; function ngpc_dma_autorearm_set_src_u8
_ngpc_dma_autorearm_set_src_u8:
	ld a,(xsp+4)
	cp a,3
	jr ule,L3006
	jr L3005
L3006:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__20
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L3005:
	ret

; function ngpc_dma_autorearm_set_src_u16
_ngpc_dma_autorearm_set_src_u16:
	ld a,(xsp+4)
	cp a,3
	jr ule,L3010
	jr L3009
L3010:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__20
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L3009:
	ret

; function ngpc_dma_autorearm_set_src_u32
_ngpc_dma_autorearm_set_src_u32:
	ld a,(xsp+4)
	cp a,3
	jr ule,L3014
	jr L3013
L3014:
	ld xwa,(xsp+8)
	ld xbc,_s_rearm_src__20
	ld e,(xsp+4)
	extz de
	exts xde
	sll 2,xde
	add xbc,xde
	ld (xbc),xwa
L3013:
	ret

; function ngpc_dma_autorearm_enable
_ngpc_dma_autorearm_enable:
	push xiz
	ld a,(xsp+8)
	ld izl,a
	ld a,izl
	cp a,3
	jr ule,L3024
	jp L3023
L3024:
	jr L3025
	jp L3023
L3025:
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
	jr z,L3028
	cp wa,1
	jr z,L3029
	cp wa,2
	jp z,L3030
	jr L3027
L3027:
L3028:
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
	jp L3026
L3029:
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
	jr L3026
L3030:
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
	jr L3026
L3026:
L3023:
	pop xiz
	ret

; function ngpc_dma_autorearm_disable
_ngpc_dma_autorearm_disable:
	ld a,(xsp+4)
	cp a,3
	jr ule,L3034
	jr L3033
L3034:
	ld a,0
	ld xbc,_s_rearm_enabled__20
	ld e,(xsp+4)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3033:
	ret

; function plane_reg_x
_plane_reg_x__21:
	ld a,(xsp+4)
	cp a,1
	jr nz,L3038
	ld xwa,08034h
	jr L3037
L3038:
	ld xwa,08032h
	jr L3037
L3037:
	ret

; function plane_reg_y
_plane_reg_y__21:
	ld a,(xsp+4)
	cp a,1
	jr nz,L3042
	ld xwa,08035h
	jr L3041
L3042:
	ld xwa,08033h
	jr L3041
L3041:
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
L3044:
	ret

; function ngpc_dma_raster_begin_ex
_ngpc_dma_raster_begin_ex:
	push xiz
	lda xsp,(xsp-8)
	ld xiz,(xsp+16)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3054
	jp L3053
L3054:
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
	jr z,L3055
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
	jr L3056
L3055:
	ld xwa,(xsp+36)
	cp xwa,0
	jr z,L3057
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
	jr L3058
L3057:
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
L3058:
L3056:
	ld xwa,(xsp+28)
	cp xwa,0
	jr z,L3059
	ld xwa,(xsp+36)
	cp xwa,0
	jr z,L3059
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
	jr L3060
L3059:
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
L3060:
L3053:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function ngpc_dma_raster_enable
_ngpc_dma_raster_enable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3067
	jr L3066
L3067:
	ldb (xiz+1),0
	ld xwa,(xiz+2)
	cp xwa,0
	jr nz,L3068
	ld xwa,(xiz+6)
	cp xwa,0
	jr nz,L3068
	jr L3066
L3068:
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L3069
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L3069
	call _ngpc_dma_timer01_hblank_enable
	jr L3070
L3069:
	call _ngpc_dma_timer0_hblank_enable
L3070:
	ldb (xiz+1),1
L3066:
	pop xiz
	ret

; function ngpc_dma_raster_rearm
_ngpc_dma_raster_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3079
	jr L3078
L3079:
	ld a,(xiz+1)
	cp a,0
	jr nz,L3080
	jr L3078
L3080:
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L3081
	lda xwa,(xiz+10)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L3082
	lda xwa,(xiz+24)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
L3082:
	jr L3083
L3081:
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L3084
	lda xwa,(xiz+10)
	push xwa
	call _ngpc_dma_stream_rearm_u8
	lda xsp,(xsp+4)
L3084:
L3083:
L3078:
	pop xiz
	ret

; function ngpc_dma_raster_disable
_ngpc_dma_raster_disable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3091
	jr L3090
L3091:
	ld a,(xiz+1)
	cp a,0
	jr z,L3092
	ld a,(xiz+10)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	ld xwa,(xiz+2)
	cp xwa,0
	jr z,L3093
	ld xwa,(xiz+6)
	cp xwa,0
	jr z,L3093
	ld a,(xiz+24)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	call _ngpc_dma_timer01_hblank_disable
	jr L3094
L3093:
	call _ngpc_dma_timer0_hblank_disable
L3094:
L3092:
	ldb (xiz+1),0
L3090:
	pop xiz
	ret

; function ngpc_dma_raster_build_parallax_table
_ngpc_dma_raster_build_parallax_table:
	push xiz
	lda xsp,(xsp-6)
	ld xiy,(xsp+18)
	ld xwa,(xsp+14)
	cp xwa,0
	jr nz,L3114
	jp L3113
L3114:
	ld xwa,xiy
	cp xwa,0
	jr z,L3116
	ld a,(xsp+22)
	cp a,0
	jr nz,L3115
L3116:
	ld izl,0
	jr L3120
L3117:
	ld a,0
	ld xbc,(xsp+14)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3119:
	inc 1,izl
L3120:
	ld a,izl
	cp a,152
	jr ult,L3117
L3118:
	jp L3113
L3115:
	ld ixl,0
	jp L3124
L3121:
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
	jr ge,L3125
	ld xwa,xiy
	ld c,ixl
	extz bc
	add bc,1
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L3126
L3125:
	ld a,152
	extz wa
L3126:
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
	jr L3130
L3127:
	ld a,(xsp+4)
	ld xbc,(xsp+14)
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3129:
	inc 1,izl
L3130:
	ld a,izl
	cp a,(xsp+3)
	jr ult,L3127
L3128:
L3123:
	inc 1,ixl
L3124:
	ld a,ixl
	cp a,(xsp+22)
	jp ult,L3121
L3122:
L3113:
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
L3132:
	ret

; function ngpc_dma_raster_xy_begin_ex
_ngpc_dma_raster_xy_begin_ex:
	push xiz
	lda xsp,(xsp-4)
	ld xiz,(xsp+12)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3138
	jr L3137
L3138:
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
	jr z,L3139
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
	jr L3140
L3139:
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
L3140:
L3137:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function ngpc_dma_raster_xy_enable
_ngpc_dma_raster_xy_enable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3145
	jr L3144
L3145:
	ldb (xiz+1),0
	ld xwa,(xiz+2)
	cp xwa,0
	jr nz,L3146
	jr L3144
L3146:
	call _ngpc_dma_timer0_hblank_enable
	ldb (xiz+1),1
L3144:
	pop xiz
	ret

; function ngpc_dma_raster_xy_rearm
_ngpc_dma_raster_xy_rearm:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3151
	jr L3150
L3151:
	ld a,(xiz+1)
	cp a,0
	jr nz,L3152
	jr L3150
L3152:
	lda xwa,(xiz+6)
	push xwa
	call _ngpc_dma_stream_rearm_u16
	lda xsp,(xsp+4)
L3150:
	pop xiz
	ret

; function ngpc_dma_raster_xy_disable
_ngpc_dma_raster_xy_disable:
	push xiz
	ld xiz,(xsp+8)
	ld xwa,xiz
	cp xwa,0
	jr nz,L3157
	jr L3156
L3157:
	ld a,(xiz+1)
	cp a,0
	jr z,L3158
	ld a,(xiz+6)
	push xwa
	call _ngpc_dma_stop
	lda xsp,(xsp+4)
	call _ngpc_dma_timer0_hblank_disable
L3158:
	ldb (xiz+1),0
L3156:
	pop xiz
	ret

; function ngpc_dma_raster_build_parallax_table_xy
_ngpc_dma_raster_build_parallax_table_xy:
	push xiz
	lda xsp,(xsp-8)
	ld xiy,(xsp+20)
	ld xwa,(xsp+16)
	cp xwa,0
	jr nz,L3178
	jp L3177
L3178:
	ld xwa,xiy
	cp xwa,0
	jr z,L3180
	ld a,(xsp+24)
	cp a,0
	jr nz,L3179
L3180:
	ld izl,0
	jr L3184
L3181:
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
L3183:
	inc 1,izl
L3184:
	ld a,izl
	cp a,152
	jr ult,L3181
L3182:
	jp L3177
L3179:
	ld ixl,0
	jp L3188
L3185:
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
	jr ge,L3189
	ld xwa,xiy
	ld c,ixl
	extz bc
	add bc,1
	exts xbc
	sll 2,xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L3190
L3189:
	ld a,152
	extz wa
L3190:
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
	jr L3194
L3191:
	ld wa,(xsp+6)
	ld xbc,(xsp+16)
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3193:
	inc 1,izl
L3194:
	ld a,izl
	cp a,(xsp+3)
	jr ult,L3191
L3192:
L3187:
	inc 1,ixl
L3188:
	ld a,ixl
	cp a,(xsp+24)
	jp ult,L3185
L3186:
L3177:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function audio_init
_audio_init:
	call _player_init
L3196:
	ret

; function audio_update
_audio_update:
	call _player_update
L3198:
	ret

; function music_play
_music_play:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	cp a,6
	jr ult,L3202
	call _music_stop
	jr L3201
L3202:
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
L3201:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function music_stop
_music_stop:
	call _player_stop
	ldb (_cur_song__22),255
L3204:
	ret

; function music_fade
_music_fade:
	call _player_stop
L3206:
	ret

; function music_current
_music_current:
	ld a,(_cur_song__22)
	jr L3208
L3208:
	ret

; function sfx
_sfx:
	ld a,(xsp+4)
	extz wa
	cp wa,0
	jr z,L3222
	cp wa,1
	jr z,L3223
	cp wa,2
	jr z,L3224
	cp wa,3
	jp z,L3225
	cp wa,4
	jp z,L3226
	cp wa,5
	jp z,L3227
	cp wa,7
	jp z,L3228
	cp wa,6
	jp z,L3229
	jp L3230
L3222:
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
	jp L3221
L3223:
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
	jp L3221
L3224:
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
	jp L3221
L3225:
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
	jr L3221
L3226:
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
	jr L3221
L3227:
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
	jr L3221
L3228:
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
	jr L3221
L3229:
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
	jr L3221
L3230:
	jr L3221
L3221:
L3220:
	ret

; function scr_map
_scr_map__23:
	ld c,(xsp+4)
	cp c,0
	jr nz,L3235
	ld xwa,36864
	jr L3236
L3235:
	ld xwa,38912
L3236:
	jr L3234
L3234:
	ret

; function pal_base
_pal_base__23:
	ld a,(xsp+4)
	cp a,2
	jr nz,L3241
	ld xwa,33280
	jr L3240
L3241:
	ld a,(xsp+4)
	cp a,0
	jr nz,L3242
	ld xwa,33408
	jr L3240
L3242:
	ld xwa,33536
	jr L3240
L3240:
	ret

; function ngpc_gfx_load_tiles
_ngpc_gfx_load_tiles:
	push xiz
	lda xsp,(xsp-8)
	ld xwa,40960
	ld xiy,xwa
	ld iz,0
	jr L3252
L3249:
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
L3251:
	inc 1,iz
L3252:
	ld wa,iz
	cp wa,(xsp+20)
	jr ult,L3249
L3250:
L3248:
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
	jr L3262
L3259:
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
L3261:
	inc 1,iz
L3262:
	ld wa,iz
	cp wa,(xsp+20)
	jr ult,L3259
L3260:
L3258:
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
	jr L3272
L3269:
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
L3271:
	inc 1,iz
L3272:
	ld wa,iz
	cp wa,ix
	jr ult,L3269
L3270:
L3268:
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
	jr L3282
L3279:
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
L3281:
	inc 1,iz
L3282:
	ld wa,iz
	cp wa,ix
	jr ult,L3279
L3280:
L3278:
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
	jr L3284
L3284:
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
L3286:
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
L3288:
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
L3290:
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
	jr L3300
L3297:
	ld wa,0
	ld xbc,xix
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3299:
	inc 1,iz
L3300:
	ld wa,iz
	cp wa,1024
	jr ult,L3297
L3298:
L3296:
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
	jr L3310
L3307:
	ld wa,ix
	ld xbc,xiy
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3309:
	inc 1,iz
L3310:
	ld wa,iz
	cp wa,1024
	jr ult,L3307
L3308:
L3306:
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
	jr L3324
L3321:
	ld a,(xsp+28)
	add a,ixl
	and a,31
	ld (xsp+8),a
	ld a,(xsp+8)
	extz wa
	sll 5,wa
	ld (xsp+10),wa
	ld izl,0
	jr L3328
L3325:
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
L3327:
	inc 1,izl
L3328:
	ld a,izl
	cp a,(xsp+32)
	jr ult,L3325
L3326:
L3323:
	inc 1,ixl
L3324:
	ld a,ixl
	cp a,(xsp+36)
	jr ult,L3321
L3322:
L3320:
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
	jr L3342
L3339:
	ld a,(xsp+30)
	add a,(xsp+6)
	and a,31
	ld (xsp+8),a
	ld a,(xsp+8)
	extz wa
	sll 5,wa
	ld (xsp+10),wa
	ld ixl,0
	jr L3346
L3343:
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
L3345:
	inc 1,ixl
L3346:
	ld a,ixl
	cp a,(xsp+34)
	jr ult,L3343
L3344:
L3341:
	incb 1,(xsp+6)
L3342:
	ld a,(xsp+6)
	cp a,(xsp+38)
	jr ult,L3339
L3340:
L3338:
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
L3348:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_gfx_set_bg_color
_ngpc_gfx_set_bg_color:
	ld wa,(xsp+4)
	ld xbc,33760
	ld (xbc),wa
	ldb (08118h),128
L3350:
	ret

; function ngpc_gfx_scroll
_ngpc_gfx_scroll:
	ld a,(xsp+4)
	cp a,0
	jr nz,L3355
	ld a,(xsp+8)
	ld (08032h),a
	ld a,(xsp+12)
	ld (08033h),a
	jr L3356
L3355:
	ld a,(xsp+8)
	ld (08034h),a
	ld a,(xsp+12)
	ld (08035h),a
L3356:
L3354:
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
	jr nz,L3371
	ldb (08032h),0
	ldb (08033h),0
	jr L3372
L3371:
	ld a,(xsp+8)
	extz wa
	ld c,ixl
	cp c,0
	jr z,L3374
L3373:
	sra 1,wa
	djnz c,L3373
L3374:
	ld (08032h),a
	ld a,(xsp+12)
	extz wa
	ld c,ixl
	cp c,0
	jr z,L3376
L3375:
	sra 1,wa
	djnz c,L3375
L3376:
	ld (08033h),a
L3372:
	ld a,izl
	cp a,255
	jr nz,L3377
	ldb (08034h),0
	ldb (08035h),0
	jr L3378
L3377:
	ld a,(xsp+8)
	extz wa
	ld c,izl
	cp c,0
	jr z,L3380
L3379:
	sra 1,wa
	djnz c,L3379
L3380:
	ld (08034h),a
	ld a,(xsp+12)
	extz wa
	ld c,izl
	cp c,0
	jr z,L3382
L3381:
	sra 1,wa
	djnz c,L3381
L3382:
	ld (08035h),a
L3378:
L3370:
	pop xiz
	ret

; function ngpc_gfx_swap_planes
_ngpc_gfx_swap_planes:
	xorb (08030h),128
L3384:
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
L3386:
	ret

; function ngpc_gfx_sprite_offset
_ngpc_gfx_sprite_offset:
	ld a,(xsp+4)
	ld (08020h),a
	ld a,(xsp+8)
	ld (08021h),a
L3388:
	ret

; function ngpc_gfx_lcd_invert
_ngpc_gfx_lcd_invert:
	ld a,(xsp+4)
	cp a,0
	jr z,L3393
	orb (08012h),128
	jr L3394
L3393:
	andb (08012h),127
L3394:
L3392:
	ret

; function ngpc_gfx_set_outside_color
_ngpc_gfx_set_outside_color:
	ld a,(08012h)
	and a,248
	ld c,(xsp+4)
	and c,7
	or a,c
	ld (08012h),a
L3396:
	ret

; function ngpc_gfx_char_over
_ngpc_gfx_char_over:
	ld c,(08010h)
	extz bc
	and bc,128
	cp bc,0
	jr z,L3401
	ld wa,1
	jr L3402
L3401:
	ld wa,0
L3402:
	jr L3400
L3400:
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
L3404:
	lda xsp,(xsp+4)
	ret

; function ngpc_tile_rotate90
_ngpc_tile_rotate90:
	push xiz
	lda xsp,(xsp-6)
	ld ixl,0
	jr L3422
L3419:
	ld iy,0
	ld izl,0
	jr L3426
L3423:
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
	jr z,L3428
L3427:
	srl 1,wa
	djnz c,L3427
L3428:
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
	jr z,L3430
L3429:
	sll 1,bc
	djnz e,L3429
L3430:
	or wa,bc
	ld iy,wa
L3425:
	inc 1,izl
L3426:
	ld a,izl
	cp a,8
	jr ult,L3423
L3424:
	ld wa,iy
	ld xbc,(xsp+18)
	ld e,ixl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3421:
	inc 1,ixl
L3422:
	ld a,ixl
	cp a,8
	jp ult,L3419
L3420:
L3418:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function ngpc_tile_rotate270
_ngpc_tile_rotate270:
	push xiz
	lda xsp,(xsp-6)
	ld ixl,0
	jr L3448
L3445:
	ld iy,0
	ld izl,0
	jr L3452
L3449:
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
	jr z,L3454
L3453:
	srl 1,wa
	djnz c,L3453
L3454:
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
	jr z,L3456
L3455:
	sll 1,bc
	djnz e,L3455
L3456:
	or wa,bc
	ld iy,wa
L3451:
	inc 1,izl
L3452:
	ld a,izl
	cp a,8
	jr ult,L3449
L3450:
	ld wa,iy
	ld xbc,(xsp+18)
	ld e,ixl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L3447:
	inc 1,ixl
L3448:
	ld a,ixl
	cp a,8
	jp ult,L3445
L3446:
L3444:
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
L3458:
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
L3460:
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
L3462:
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
L3464:
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
L3466:
	lda xsp,(xsp+4)
	ret

; function ngpc_sprite_hide_all
_ngpc_sprite_hide_all:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L3476
L3473:
	ld a,izl
	push xwa
	call _ngpc_sprite_hide
	lda xsp,(xsp+4)
L3475:
	inc 1,izl
L3476:
	ld a,izl
	cp a,64
	jr ult,L3473
L3474:
L3472:
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
L3478:
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
L3480:
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
	jr L3482
L3482:
	ret

; function ngpc_text_print
_ngpc_text_print:
	push xiz
	lda xsp,(xsp-2)
	ld xiz,(xsp+26)
	ld a,(xsp+18)
	ld iyl,a
	jr L3492
L3490:
	ld a,(xiz)
	ld ixl,a
	ld a,ixl
	cp a,32
	jr ult,L3493
	ld a,ixl
	cp a,128
	jr uge,L3493
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
L3493:
	inc 1,iyl
	ld a,iyl
	cp a,20
	jr ult,L3494
	jr L3491
L3494:
	ld xwa,xiz
	inc 1,xwa
	ld xiz,xwa
L3492:
	ld a,(xiz)
	cp a,0
	jr nz,L3490
L3491:
L3489:
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
	jr L3508
L3505:
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
L3507:
	inc 1,izl
L3508:
	ld a,izl
	cp a,5
	jr ult,L3505
L3506:
	ld a,5
	sub a,(xsp+38)
	ld izl,a
	jr L3512
L3509:
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
L3511:
	inc 1,izl
L3512:
	ld a,izl
	cp a,5
	jr ult,L3509
L3510:
L3504:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function ngpc_text_print_hex
_ngpc_text_print_hex:
	push xiz
	lda xsp,(xsp-8)
	ld izl,0
	jr L3526
L3523:
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
	jr z,L3528
L3527:
	srl 1,wa
	djnz c,L3527
L3528:
	and wa,15
	ld ixl,a
	ld a,ixl
	cp a,10
	jr uge,L3529
	ld a,ixl
	extz wa
	add wa,48
	ld iy,wa
	jr L3530
L3529:
	ld a,ixl
	extz wa
	sub wa,10
	add wa,65
	ld iy,wa
L3530:
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
L3525:
	inc 1,izl
L3526:
	ld a,izl
	cp a,(xsp+36)
	jp ult,L3523
L3524:
L3522:
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
	jr L3546
L3543:
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
L3545:
	inc 1,izl
L3546:
	ld a,izl
	cp a,5
	jr ult,L3543
L3544:
	ld a,5
	sub a,(xsp+40)
	ld izl,a
	jr L3550
L3547:
	ld a,(xsp+8)
	cp a,0
	jr z,L3551
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L3551
	ld a,izl
	cp a,4
	jr uge,L3551
	ld ix,32
	jr L3552
L3551:
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
L3552:
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
L3549:
	inc 1,izl
L3550:
	ld a,izl
	cp a,5
	jr ult,L3547
L3548:
L3542:
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
L3554:
	ret

; function ngpc_text_tile_screen
_ngpc_text_tile_screen:
	push xiz
	lda xsp,(xsp-4)
	ld wa,0
	ld (xsp+2),wa
	ld ixl,0
	jr L3568
L3565:
	ld izl,0
	jr L3572
L3569:
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
L3571:
	inc 1,izl
L3572:
	ld a,izl
	cp a,20
	jr ult,L3569
L3570:
L3567:
	inc 1,ixl
L3568:
	ld a,ixl
	cp a,19
	jr ult,L3565
L3566:
L3564:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function hud_score_reset
_hud_score_reset:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L3582
L3579:
	ld a,0
	ld xbc,_s_dig__26
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L3581:
	inc 1,izl
L3582:
	ld a,izl
	cp a,7
	jr ult,L3579
L3580:
L3578:
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
	jr L3591
L3589:
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
L3591:
	ld wa,iy
	cp wa,0
	jr z,L3592
	ld a,izl
	cp a,0
	jr ugt,L3589
L3592:
L3590:
L3588:
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
	jr L3602
L3599:
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
L3601:
	inc 1,iz
L3602:
	ld wa,iz
	cp wa,552
	jr ult,L3599
L3600:
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
L3598:
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
L3604:
	ret

; function hud_clear_top
_hud_clear_top:
	push xiz
	lda xsp,(xsp-2)
	ld ixl,0
	jr L3618
L3615:
	ld izl,0
	jr L3622
L3619:
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
L3621:
	inc 1,izl
L3622:
	ld a,izl
	cp a,20
	jr ult,L3619
L3620:
L3617:
	inc 1,ixl
L3618:
	ld a,ixl
	cp a,15
	jr ult,L3615
L3616:
L3614:
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
	jr L3630
L3628:
	inc 1,izl
L3630:
	ld xwa,xix
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L3628
L3629:
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
L3627:
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
	jr L3640
L3637:
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
L3639:
	inc 1,izl
L3640:
	ld a,izl
	cp a,20
	jr ult,L3637
L3638:
L3636:
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
L3642:
	ret

; function hud_race
_hud_race:
	push xiz
	lda xsp,(xsp-4)
	ld a,(xsp+12)
	cp a,(_h_time__26)
	jr z,L3668
	ld a,(_h_time__26)
	cp a,255
	jr nz,L3669
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
L3669:
	ld c,(xsp+12)
	cp c,10
	jr uge,L3670
	ld wa,2
	jr L3671
L3670:
	ld wa,1
L3671:
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
	jr uge,L3672
	ld wa,2
	jr L3673
L3672:
	ld wa,1
L3673:
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
L3668:
	ld a,(xsp+28)
	cp a,(_h_stage__26)
	jr z,L3674
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
L3674:
	ld wa,(xsp+24)
	mul xwa,3
	add wa,9
	extz xwa
	div xwa,10
	ld (xsp+1),a
	ld a,(xsp+1)
	cp a,(_h_prog__26)
	jr z,L3675
	ld izl,0
	jr L3679
L3676:
	ld wa,0
	push xwa
	ld c,izl
	cp c,(xsp+5)
	jr uge,L3680
	ld wa,97
	jr L3681
L3680:
	ld wa,96
L3681:
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
L3678:
	inc 1,izl
L3679:
	ld a,izl
	cp a,3
	jr ult,L3676
L3677:
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
L3675:
	ld a,(xsp+16)
	cp a,(_h_kmh__26)
	jp z,L3682
	ld a,(xsp+16)
	extz wa
	sll 1,wa
	ld (xsp+2),wa
	ld a,(_h_kmh__26)
	cp a,255
	jr nz,L3683
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
L3683:
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
L3682:
	ld a,(xsp+20)
	cp a,(_h_gear__26)
	jr z,L3684
	ld c,(xsp+20)
	cp c,1
	jr nz,L3685
	ld xwa,_S26_3
	jr L3686
L3685:
	ld xwa,_S26_4
L3686:
	push xwa
	ld wa,1
	push xwa
	ld wa,16
	push xwa
	ld c,(xsp+32)
	cp c,1
	jr nz,L3687
	ld wa,1
	jr L3688
L3687:
	ld c,(xsp+32)
	cp c,2
	jr nz,L3689
	ld wa,2
	jr L3690
L3689:
	ld wa,0
L3690:
L3688:
	push xwa
	ld wa,0
	push xwa
	call _ngpc_text_print
	lda xsp,(xsp+20)
	ld a,(xsp+20)
	ld (_h_gear__26),a
L3684:
L3667:
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
	jr uge,L3695
	ld a,izl
	extz wa
	mul xwa,7
	extz xwa
	div xwa,6
	jr L3696
L3695:
	ld wa,112
	ld c,izl
	extz bc
	sub bc,96
	srl 3,bc
	sub wa,bc
L3696:
	ld (xsp+0),wa
	ld a,(xsp+14)
	extz wa
	mul xwa,(xsp+0)
	srl 7,wa
	jr L3694
L3694:
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
L3698:
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
L3700:
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
	jr ult,L3707
	jr L3706
L3707:
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
L3708:
	ld a,(xiz)
	and a,231
	ld (xiz),a
	ld bc,4
	exts xbc
	ld xwa,xiz
	add xwa,xbc
	ld xiz,xwa
L3710:
	dec 1,ixl
	ld a,ixl
	cp a,0
	jr nz,L3708
L3709:
L3706:
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
	jp L3742
L3739:
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
	jp L3746
L3743:
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
	jp L3750
L3747:
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
	jp L3754
L3751:
	ld wa,(xsp+16)
	ld bc,14
	ld de,2
	ld l,izl
	extz hl
	mul xde,hl
	sub bc,de
	cp c,0
	jr z,L3757
L3756:
	srl 1,wa
	djnz c,L3756
L3757:
	and wa,3
	cp wa,0
	jr nz,L3755
	jp L3753
L3755:
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	cp a,(xsp+2)
	jr ule,L3758
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld (xsp+2),a
	ldb (xsp+5),0
L3758:
	ld a,(xsp+10)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	cp a,(xsp+2)
	jr nz,L3759
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+5)
	jr ule,L3759
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+5),a
L3759:
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+3)
	jr ule,L3760
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+3),a
L3760:
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	cp a,(xsp+4)
	jr uge,L3761
	ld a,iyl
	extz wa
	sll 3,wa
	ld c,izl
	extz bc
	add wa,bc
	ld (xsp+4),a
L3761:
L3753:
	inc 1,izl
L3754:
	ld a,izl
	cp a,8
	jp ult,L3751
L3752:
L3749:
	inc 1,ixl
L3750:
	ld a,ixl
	cp a,8
	jp ult,L3747
L3748:
L3745:
	incb 1,(xsp+1)
L3746:
	ld a,(xsp+1)
	cp a,(xsp+8)
	jp ult,L3743
L3744:
L3741:
	incb 1,(xsp+0)
L3742:
	ld a,(xsp+0)
	cp a,(_body__29+28)
	jp ult,L3739
L3740:
	ld a,(xsp+4)
	cp a,(xsp+3)
	jr ule,L3762
	ld xwa,(_body__29+18)
	ld a,(xwa)
	extz wa
	sll 2,wa
	ld (_car_wheel_dx__29),a
	jr L3738
L3762:
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
	jr ule,L3763
	ld wa,(xsp+6)
	sub wa,(xsp+8)
	srl 1,wa
	extz wa
	jr L3764
L3763:
	ld wa,0
L3764:
	ld (_car_wheel_dx__29),a
L3738:
	lda xsp,(xsp+20)
	pop xiz
	ret

; function id_car_select
_id_car_select:
	ld c,(xsp+4)
	cp c,1
	jr uge,L3769
	ld a,(xsp+4)
	extz wa
	jr L3770
L3769:
	ld a,0
	extz wa
L3770:
	ld (_car_variant__29),a
	ld xwa,_body__29
	push xwa
	ld a,(_car_variant__29)
	push xwa
	call _id_fleet_body
	lda xsp,(xsp+8)
	call _mesure_roues__29
L3768:
	ret

; function id_car_char_count
_id_car_char_count:
	ld c,(xsp+4)
	cp c,0
	jr z,L3775
	ld wa,(_body__29+4)
	jr L3776
L3775:
	ld wa,(_body__29+26)
L3776:
	srl 3,wa
	jr L3774
L3774:
	ret

; function id_car_half_width
_id_car_half_width:
	ld xwa,(_body__29+18)
	ld a,(xwa)
	extz wa
	sll 2,wa
	jr L3778
L3778:
	ret

; function id_car_wheel_dx
_id_car_wheel_dx:
	ld a,(_car_wheel_dx__29)
	jr L3780
L3780:
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
	jr L3796
L3793:
	ld wa,40960
	extz xwa
	ld bc,(xsp+24)
	add bc,ix
	mul xbc,16
	add xwa,xbc
	ld (xsp+8),xwa
	ld iz,0
	jr L3800
L3797:
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
L3799:
	inc 1,iz
L3800:
	ld wa,iz
	cp wa,8
	jr ult,L3797
L3798:
L3795:
	inc 1,ix
L3796:
	ld wa,ix
	cp wa,(xsp+2)
	jr ult,L3793
L3794:
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
	jr ule,L3801
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
	jr L3802
L3801:
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
L3802:
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
L3792:
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
	jr uge,L3835
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
	jp L3834
L3835:
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
	jr uge,L3836
	ld a,(xsp+50)
	ld (xsp+4),a
	ldb (xsp+5),0
	jr L3837
L3836:
	ld a,(xsp+3)
	sub a,(xsp+50)
	ld (xsp+4),a
	ldb (xsp+5),1
L3837:
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
	jr L3841
L3838:
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
	jr z,L3842
	ld a,(xsp+11)
	sub a,1
	sub a,(xsp+12)
	extz wa
	jr L3843
L3842:
	ld a,(xsp+12)
	extz wa
L3843:
	ld (xsp+13),a
	ld a,(xsp+13)
	cp a,(xsp+6)
	jr uge,L3844
	ld a,(xsp+13)
	ld (xsp+6),a
L3844:
	ld a,(xsp+13)
	cp a,(xsp+7)
	jr ule,L3845
	ld a,(xsp+13)
	ld (xsp+7),a
L3845:
L3840:
	inc 1,izl
L3841:
	ld a,izl
	cp a,(xsp+10)
	jr ult,L3838
L3839:
	ld a,(xsp+6)
	cp a,(xsp+7)
	jr ule,L3846
	ldb (xsp+6),0
	ldb (xsp+7),0
L3846:
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
	jp L3850
L3847:
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
	jr nz,L3851
	ld wa,0
	jr L3852
L3851:
	ld wa,5
L3852:
	ld (xsp+13),a
	ld izl,0
	jp L3856
L3853:
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
	jr z,L3857
	ld a,(xsp+12)
	sub a,1
	sub a,(xiy)
	extz wa
	jr L3858
L3857:
	ld a,(xiy)
	extz wa
L3858:
	ld (xsp+18),a
L3859:
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
	jr z,L3862
	ld wa,128
	jr L3863
L3862:
	ld wa,0
L3863:
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
L3861:
L3860:
	incb 1,(xsp+2)
L3855:
	inc 1,izl
L3856:
	ld a,izl
	cp a,(xsp+11)
	jr uge,L3864
	ld a,(xsp+2)
	cp a,64
	jp ult,L3853
L3864:
L3854:
L3849:
	incb 1,(xsp+1)
L3850:
	ld a,(xsp+1)
	cp a,(_body__29+28)
	jp ult,L3847
L3848:
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
L3834:
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
	jp L3884
L3881:
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
	jr nz,L3885
	ld wa,0
	jr L3886
L3885:
	ld wa,5
L3886:
	ld (xsp+6),a
	ldb (xsp+0),0
	jp L3890
L3887:
	ld xwa,(_body__29+22)
	ld c,(xsp+4)
	add c,(xsp+0)
	extz bc
	muls xbc,3
	add xwa,xbc
	lda xwa,(xwa)
	ld xiy,xwa
L3891:
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
L3893:
L3892:
	incb 1,(xsp+2)
L3889:
	incb 1,(xsp+0)
L3890:
	ld a,(xsp+0)
	cp a,(xsp+5)
	jr uge,L3894
	ld a,(xsp+2)
	cp a,64
	jp ult,L3887
L3894:
L3888:
L3883:
	incb 1,(xsp+1)
L3884:
	ld a,(xsp+1)
	cp a,(_body__29+28)
	jp ult,L3881
L3882:
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
L3880:
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
	jr z,L3900
	ld wa,(_car_at_x__29)
	ld (xsp+10),wa
L3900:
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
	jr z,L3901
	ld wa,128
	jr L3902
L3901:
	ld wa,0
L3902:
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
L3899:
	lda xsp,(xsp+22)
	ret

; function lean_last
_lean_last__29:
	push xiz
	lda xsp,(xsp-2)
	ld c,(_body__29+29)
	cp c,0
	jr ule,L3908
	ld a,(_body__29+29)
	extz wa
	sub wa,1
	jr L3909
L3908:
	ld wa,0
L3909:
	ld izl,a
	ld a,izl
	cp a,2
	jr ule,L3910
	ld izl,2
L3910:
	ld a,izl
	jr L3907
L3907:
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
	jr nz,L3920
	ld wa,0
	jr L3919
L3920:
	ld c,(_lean_hold__29)
	cp c,12
	jr ult,L3921
	ld wa,3
	jr L3922
L3921:
	ld c,(_lean_hold__29)
	cp c,5
	jr ult,L3923
	ld wa,2
	jr L3924
L3923:
	ld wa,1
L3924:
L3922:
	ld izl,a
	ld c,izl
	cp c,(xsp+0)
	jr ule,L3925
	ld a,(xsp+0)
	extz wa
	jr L3926
L3925:
	ld a,izl
	extz wa
L3926:
	jr L3919
L3919:
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
	jr z,L3935
	ld a,(xsp+0)
	cp a,0
	jr nz,L3934
L3935:
	ld wa,0
	jr L3933
L3934:
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
	jr le,L3936
	ld iz,16
L3936:
	ld c,(_lean_side__29)
	cp c,0
	jr ge,L3937
	ld wa,iz
	neg wa
	jr L3938
L3937:
	ld wa,iz
L3938:
	jr L3933
L3933:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function id_car_last_x
_id_car_last_x:
	ld wa,(_car_last_x__29)
	jr L3940
L3940:
	ret

; function id_car_last_top
_id_car_last_top:
	ld a,(_car_last_top__29)
	jr L3942
L3942:
	ret

; function id_car_draw
_id_car_draw:
	push xiz
	lda xsp,(xsp-8)
	ld a,(xsp+20)
	cp a,0
	jr z,L3971
	ld a,(_lean_side__29)
	cp a,(xsp+20)
	jr z,L3972
	ld a,(xsp+20)
	ld (_lean_side__29),a
	ldb (_lean_hold__29),0
L3972:
	ld a,(_lean_hold__29)
	cp a,255
	jr uge,L3973
	incb 1,(_lean_hold__29)
L3973:
	ldb (_lean_wait__29),2
	jr L3974
L3971:
	ld a,(_lean_hold__29)
	cp a,0
	jr z,L3975
	ld a,(_lean_wait__29)
	cp a,0
	jr z,L3976
	decb 1,(_lean_wait__29)
	jr L3977
L3976:
	ldb (_lean_wait__29),2
	ld a,(_lean_hold__29)
	cp a,12
	jr ult,L3978
	ldb (_lean_hold__29),11
	jr L3979
L3978:
	ld a,(_lean_hold__29)
	cp a,5
	jr ult,L3980
	ldb (_lean_hold__29),4
	jr L3981
L3980:
	ldb (_lean_hold__29),0
L3981:
L3979:
L3977:
L3975:
L3974:
	ld a,(xsp+24)
	cp a,0
	jr nz,L3982
	ldb (_bump_phase__29),0
	ldb (xsp+2),0
	jr L3983
L3982:
	incb 1,(_bump_phase__29)
	ld c,(_bump_phase__29)
	extz bc
	and bc,2
	cp bc,0
	jr z,L3984
	ld a,(xsp+24)
	extz wa
	jr L3985
L3984:
	ld wa,0
L3985:
	ld (xsp+2),a
L3983:
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
	jr ge,L3986
	ld wa,0
	jr L3987
L3986:
	ld wa,(xsp+6)
L3987:
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
	jp ule,L3988
	call _lean_pose__29
	ld (xsp+0),a
	ldb (xsp+1),0
	ld c,(xsp+0)
	cp c,0
	jr nz,L3989
	ld wa,0
	jr L3990
L3989:
	ld c,(_lean_side__29)
	cp c,0
	jr ge,L3991
	ld wa,2
	jr L3992
L3991:
	ld wa,1
L3992:
L3990:
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
	jp L3970
L3988:
	ld c,(_lean_hold__29)
	cp c,0
	jr nz,L3993
	ld wa,0
	jr L3994
L3993:
	ld wa,1
L3994:
	ld (xsp+0),a
	ld c,(_lean_side__29)
	cp c,0
	jr le,L3995
	ld wa,1
	jr L3996
L3995:
	ld wa,0
L3996:
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
L3970:
	lda xsp,(xsp+8)
	pop xiz
	ret

; function id_car_draw_at
_id_car_draw_at:
	ld wa,(xsp+4)
	ld (_car_at_x__29),wa
	ld a,(_body__29+28)
	cp a,1
	jr ule,L4000
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
L4000:
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
L3999:
	ret

; function id_car_height
_id_car_height:
	ld a,(_body__29+30)
	jr L4002
L4002:
	ret

; function id_car_tile_base
_id_car_tile_base:
	ld wa,(_car_tile_base__29)
	jr L4004
L4004:
	ret

; function id_car_restore
_id_car_restore:
	ld wa,0
	push xwa
	ld wa,(_car_tile_base__29)
	push xwa
	call _id_car_init
	lda xsp,(xsp+8)
L4006:
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
L4008:
	pop xiz
	ret

; function uses_akina
_uses_akina__30:
	ld wa,0
	jr L4010
L4010:
	ret

; function id_road_horizon
_id_road_horizon:
	ld xwa,_course_horizon__30
	ld c,(_road_course__30)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	jr L4012
L4012:
	ret

; function sky_is_tall_course
_sky_is_tall_course__30:
	ld wa,0
	jr L4014
L4014:
	ret

; function road_is_tarmac
_road_is_tarmac__30:
	ld wa,1
	jr L4016
L4016:
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
	jp L4051
L4048:
	push xix
	push xiy
	call _uses_akina__30
	pop xiy
	pop xix
	cp a,0
	jp nz,L4052
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
	jr ule,L4053
	ld wa,(xsp+6)
	ld (xsp+8),wa
L4053:
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
	jr L4054
L4052:
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
L4054:
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
	jr nz,L4055
	ld wa,1600
	ld xbc,_id_ahead__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
	jr L4056
L4055:
	ld wa,60
	mul xwa,(xsp+6)
	extz xwa
	div xwa,iy
	ld (xsp+8),wa
	ld bc,(xsp+8)
	cp bc,1600
	jr ule,L4057
	ld wa,1600
	jr L4058
L4057:
	ld wa,(xsp+8)
L4058:
	ld xbc,_id_ahead__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4056:
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
	jr ule,L4059
	ld wa,47
	jr L4060
L4059:
	ld wa,(xsp+12)
L4060:
	ld xbc,_id_sl__30+128
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L4050:
	inc 1,izl
L4051:
	ld a,izl
	cp a,(_road_lines__30)
	jp ult,L4048
L4049:
	ld a,(_road_lines__30)
	sub a,1
	ld (_wide_k0__30),a
	jr L4063
L4061:
	decb 1,(_wide_k0__30)
L4063:
	ld a,(_wide_k0__30)
	cp a,0
	jr ule,L4064
	ld xwa,_id_src__30
	ld c,(_wide_k0__30)
	sub c,1
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,48
	jr uge,L4061
L4064:
L4062:
	ld a,(_road_top__30)
	sub a,8
	ld (_climb_room__30),a
	push xix
	push xiy
	call _uses_akina__30
	pop xiy
	pop xix
	cp a,0
	jr z,L4065
	ld a,(_road_lines__30)
	extz wa
	extz xwa
	div xwa,10
	ld (_descent_room__30),a
	jr L4066
L4065:
	ld a,(_road_lines__30)
	extz wa
	srl 1,wa
	ld (_descent_room__30),a
L4066:
	ldb (_grade_hi__30),0
	ldb (_grade_lo__30),0
	ld ix,1
	jr L4070
L4067:
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
	jr ugt,L4071
	ld a,ixl
	ld (_grade_hi__30),a
L4071:
L4069:
	inc 1,ix
L4070:
	ld wa,ix
	cp wa,20
	jr le,L4067
L4068:
	ld ix,1
	jr L4075
L4072:
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
	jr ult,L4076
	ld a,ixl
	neg a
	ld (_grade_lo__30),a
L4076:
L4074:
	inc 1,ix
L4075:
	ld wa,ix
	cp wa,20
	jr le,L4072
L4073:
L4047:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function rally_scan
_rally_scan__30:
	push xiz
	lda xsp,(xsp-6)
	ld a,(_rally_scanned__30)
	cp a,0
	jr z,L4095
	jp L4094
L4095:
	ldw (xsp+0),0
	jr L4099
L4096:
	ld a,255
	ld xbc,_rally_of__30
	ld de,(xsp+0)
	extz xde
	add xbc,xde
	ld (xbc),a
L4098:
	incw 1,(xsp+0)
L4099:
	ld wa,(xsp+0)
	cp wa,512
	jr ult,L4096
L4097:
	ldb (_rally_used__30),0
	ld a,(_art__30+21)
	extz wa
	srl 3,wa
	ld iyl,a
	jp L4103
L4100:
	ld ixl,0
	jr L4107
L4104:
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
	jr uge,L4109
	ld xwa,_rally_of__30
	ld bc,iz
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,255
	jr z,L4108
L4109:
	jr L4106
L4108:
	ld a,(_rally_used__30)
	cp a,255
	jr ult,L4110
	jr L4106
L4110:
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
L4106:
	inc 1,ixl
L4107:
	ld a,ixl
	cp a,(_art__30+20)
	jp ult,L4104
L4105:
L4102:
	inc 1,iyl
L4103:
	ld a,iyl
	cp a,29
	jp ult,L4100
L4101:
	ldb (_rally_scanned__30),1
L4094:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function id_road_char_count
_id_road_char_count:
	call _rally_scan__30
	ld a,(_rally_used__30)
	extz wa
	jr L4112
L4112:
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
	jp L4128
L4125:
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
	jr nz,L4129
	ld xwa,_rally_src__30
	ld bc,ix
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L4130
L4129:
	ld wa,ix
L4130:
	ld (xsp+12),wa
	ld iz,0
	jr L4134
L4131:
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
L4133:
	inc 1,iz
L4134:
	ld wa,iz
	cp wa,8
	jr ult,L4131
L4132:
L4127:
	inc 1,ix
L4128:
	ld wa,ix
	cp wa,(xsp+2)
	jp ult,L4125
L4126:
L4124:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_load_palettes
_id_load_palettes__30:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L4144
L4141:
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
L4143:
	inc 1,izl
L4144:
	ld a,izl
	cp a,8
	jp ult,L4141
L4142:
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
L4140:
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
L4146:
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
	jr L4156
L4153:
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
L4155:
	inc 1,izl
L4156:
	ld a,izl
	cp a,4
	jr ult,L4153
L4154:
	ldw (_bc_rest__30),65535
	ldw (_bc_rest__30+2),65535
L4152:
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
	jp L4178
L4175:
	ld a,iyl
	ld c,(xsp+2)
	sub a,c
	ld (xsp+3),a
	ld a,(xsp+3)
	cp a,28
	jr ule,L4179
	ldb (xsp+3),28
L4179:
	ld izl,0
	jp L4183
L4180:
	ld wa,0
	ld (xsp+4),a
	ld a,(xsp+3)
	ld (xsp+5),a
	ld a,izl
	cp a,0
	jr uge,L4184
	ld a,(_art__30+21)
	extz wa
	srl 3,wa
	ld (xsp+5),a
	jr L4185
L4184:
	ld a,izl
	ld c,0
	add c,(_art__30+20)
	cp a,c
	jr ult,L4186
	ld a,(_art__30+20)
	sub a,1
	ld (xsp+4),a
	ld a,(_art__30+21)
	extz wa
	srl 3,wa
	ld (xsp+5),a
	jr L4187
L4186:
	ld a,izl
	sub a,0
	ld (xsp+4),a
L4187:
L4185:
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
	jr uge,L4188
	ld xwa,_rally_of__30
	ld bc,(xsp+8)
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	extz wa
	jr L4189
L4188:
	ld wa,255
L4189:
	ld ixl,a
	ld a,ixl
	cp a,255
	jr nz,L4190
	ld ixl,0
L4190:
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
L4182:
	inc 1,izl
L4183:
	ld a,izl
	cp a,32
	jp ult,L4180
L4181:
L4177:
	inc 1,iyl
L4178:
	ld a,iyl
	cp a,32
	jp ult,L4175
L4176:
L4174:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function id_load_maps
_id_load_maps__30:
	call _id_load_maps_rally__30
L4192:
	ret

; function id_road_reload_maps
_id_road_reload_maps:
	call _id_load_palettes__30
	call _id_load_maps_rally__30
L4194:
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
	jp nz,L4226
	ld izl,0
	jr L4230
L4227:
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
	jr uge,L4231
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
	jr ge,L4232
	ld wa,(xsp+4)
	ld (xsp+2),wa
L4232:
L4231:
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
L4229:
	inc 1,izl
L4230:
	ld a,izl
	cp a,(_road_lines__30)
	jp ult,L4227
L4228:
	jp L4225
L4226:
	ld izl,0
	jp L4236
L4233:
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
	jr L4240
L4237:
	ld wa,0
	ld (xsp+10),wa
	ld wa,0
	ld (xsp+12),wa
	ld wa,(xsp+12)
	cp wa,0
	jr nz,L4241
	jr L4239
L4241:
	ld ixl,0
	jr L4245
L4242:
	ld wa,(xsp+12)
	ld bc,14
	ld de,2
	ld l,ixl
	extz hl
	mul xde,hl
	sub bc,de
	cp c,0
	jr z,L4248
L4247:
	srl 1,wa
	djnz c,L4247
L4248:
	and wa,3
	cp wa,0
	jr z,L4246
	ld a,(xsp+4)
	extz wa
	sll 3,wa
	ld c,ixl
	extz bc
	add wa,bc
	ld iy,wa
	ld wa,iy
	cp wa,(xsp+6)
	jr uge,L4249
	ld wa,iy
	ld (xsp+6),wa
L4249:
	ld wa,iy
	cp wa,(xsp+8)
	jr ule,L4250
	ld wa,iy
	ld (xsp+8),wa
L4250:
L4246:
L4244:
	inc 1,ixl
L4245:
	ld a,ixl
	cp a,8
	jr ult,L4242
L4243:
L4239:
	incb 1,(xsp+4)
L4240:
	ld a,(xsp+4)
	cp a,32
	jr ult,L4237
L4238:
	ld wa,(xsp+6)
	cp wa,(xsp+8)
	jr ule,L4251
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
	jr L4252
L4251:
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
L4252:
	ld xwa,_id_dxc__30+128
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,88
	jr le,L4253
	ld wa,88
	ld xbc,_id_dxc__30+128
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4253:
	ld xwa,_id_dxc__30
	ld c,izl
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65448
	jr ge,L4254
	ld wa,65448
	ld xbc,_id_dxc__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4254:
L4235:
	inc 1,izl
L4236:
	ld a,izl
	cp a,(_road_lines__30)
	jp ult,L4233
L4234:
L4225:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_road_course
_id_road_course:
	ld a,(_road_course__30)
	jr L4256
L4256:
	ret

; function id_road_top
_id_road_top:
	ld a,(_road_top__30)
	jr L4258
L4258:
	ret

; function id_road_bottom
_id_road_bottom:
	ld a,(_road_bottom__30)
	jr L4260
L4260:
	ret

; function id_road_select
_id_road_select:
	push xiz
	lda xsp,(xsp-14)
	ld c,(xsp+22)
	cp c,1
	jr uge,L4300
	ld a,(xsp+22)
	extz wa
	jr L4301
L4300:
	ld wa,0
L4301:
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
	jr nz,L4302
	push xix
	ld xwa,_art__30
	push xwa
	ld a,(_road_course__30)
	push xwa
	call _course_art__30
	lda xsp,(xsp+8)
	pop xix
	ldb (_rally_scanned__30),0
L4302:
	push xix
	call _uses_akina__30
	pop xix
	cp a,0
	jr nz,L4303
	ldb (_road_base_x__30),48
	ldb (_road_top__30),88
	push xwa
	push xix
	call _sky_is_tall_course__30
	ld xbc,xwa
	pop xix
	pop xwa
	cp c,0
	jr z,L4304
	ld a,88
	extz wa
	jr L4305
L4304:
	ld a,88
	extz wa
L4305:
	ld (_road_plane0__30),a
	ldb (_road_lines__30),64
	jr L4306
L4303:
	ldb (_road_base_x__30),7
	ldb (_road_top__30),72
	ldb (_road_plane0__30),72
	ldb (_road_lines__30),40
L4306:
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
	jr ult,L4307
	ld a,(_road_lines__30)
	sub a,1
	ld (_car_stand__30),a
L4307:
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
	jr nz,L4308
	push xix
	call _id_load_maps_rally__30
	pop xix
	jr L4309
L4308:
	push xix
	call _id_load_maps__30
	pop xix
L4309:
	ldb (xsp+0),0
	jr L4313
L4310:
	ld wa,0
	ld xbc,_id_shear__30
	ld e,(xsp+0)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4312:
	incb 1,(xsp+0)
L4313:
	ld a,(xsp+0)
	cp a,(_road_lines__30)
	jr ult,L4310
L4311:
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
	jr z,L4314
	ld wa,3
	jr L4315
L4314:
	ld wa,0
L4315:
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
	jp L4319
L4316:
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
	jr ule,L4320
	ld wa,(xsp+8)
	sub wa,ix
	jr L4321
L4320:
	ld wa,0
L4321:
	ld (xsp+8),wa
	ld bc,(xsp+10)
	cp bc,ix
	jr ule,L4322
	ld wa,(xsp+10)
	sub wa,ix
	jr L4323
L4322:
	ld wa,0
L4323:
	ld (xsp+10),wa
	ld bc,(xsp+12)
	cp bc,ix
	jr ule,L4324
	ld wa,(xsp+12)
	sub wa,ix
	jr L4325
L4324:
	ld wa,0
L4325:
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
L4318:
	inc 1,izl
L4319:
	ld a,izl
	cp a,4
	jp ult,L4316
L4317:
	push xix
	call _road_is_tarmac__30
	pop xix
	cp a,0
	jr z,L4326
	ld izl,0
	jr L4330
L4327:
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
L4329:
	inc 1,izl
L4330:
	ld a,izl
	cp a,4
	jr ult,L4327
L4328:
	jr L4331
L4326:
	push xix
	call _uses_akina__30
	pop xix
	cp a,0
	jr nz,L4332
	ld izl,0
	jr L4336
L4333:
	ld wa,(xsp+2)
	ld xbc,_band_col__30
	ld e,izl
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L4335:
	inc 1,izl
L4336:
	ld a,izl
	cp a,4
	jr ult,L4333
L4334:
L4332:
L4331:
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
L4299:
	lda xsp,(xsp+14)
	pop xiz
	ret

; function id_road_dma_pause
_id_road_dma_pause:
	ld a,(_road_dma_depth__30)
	cp a,255
	jr uge,L4341
	incb 1,(_road_dma_depth__30)
L4341:
	ld a,(_road_dma_live__30)
	cp a,0
	jr z,L4342
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
L4342:
L4340:
	ret

; function id_road_dma_resume
_id_road_dma_resume:
	ld a,(_road_dma_depth__30)
	cp a,0
	jr z,L4349
	decb 1,(_road_dma_depth__30)
L4349:
	ld a,(_road_dma_depth__30)
	cp a,0
	jr z,L4350
	jp L4348
L4350:
	ld a,(_road_dma_live__30)
	cp a,0
	jp nz,L4351
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
	jr nz,L4352
	call _road_is_tarmac__30
	cp a,0
	jr nz,L4352
	ldw (_id_bandstream__30+10),0
	ldb (_road_dma_live__30),1
	ld xwa,_id_road_rearm
	push xwa
	call _ngpc_set_vblank_hook
	lda xsp,(xsp+4)
	jr L4348
L4352:
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
L4351:
L4348:
	ret

; function id_road_init
_id_road_init:
	ld wa,0
	push xwa
	call _id_road_select
	lda xsp,(xsp+4)
	call _ngpc_dma_init
	call _id_road_dma_resume
L4354:
	ret

; function id_road_flat
_id_road_flat:
	push xiz
	lda xsp,(xsp-2)
	ld iz,0
	jr L4364
L4361:
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
L4363:
	inc 1,iz
L4364:
	ld wa,iz
	cp wa,152
	jr ult,L4361
L4362:
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
L4360:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_rearm
_id_road_rearm:
	ld xwa,(_id_xy_done__30)
	cp xwa,0
	jr z,L4369
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
L4369:
	ld xwa,_id_raster__30
	push xwa
	call _ngpc_dma_raster_xy_rearm
	lda xsp,(xsp+4)
	ld wa,(_id_bandstream__30+10)
	cp wa,0
	jr z,L4370
	ld xwa,_id_bandstream__30
	push xwa
	call _ngpc_dma_stream_rearm_u16
	lda xsp,(xsp+4)
L4370:
L4368:
	ret

; function id_road_dma_state
_id_road_dma_state:
	ld a,(_id_raster__30+1)
	extz wa
	ld xde,(_id_raster__30+2)
	cp xde,0
	jr z,L4375
	ld bc,2
	jr L4376
L4375:
	ld bc,0
L4376:
	or wa,bc
	jr L4374
L4374:
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
	jr L4378
L4378:
	ret

; function id_road_restore_map
_id_road_restore_map:
	call _uses_akina__30
	cp a,0
	jr nz,L4383
	call _id_load_maps_rally__30
	jr L4384
L4383:
	call _id_load_maps__30
L4384:
L4382:
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
	jr nz,L4389
	call _id_load_maps_rally__30
	jr L4390
L4389:
	call _id_load_maps__30
L4390:
L4388:
	ret

; function wide_rows
_wide_rows__30:
	push xiz
	lda xsp,(xsp-12)
	ld a,(_road_bottom__30)
	ld ixl,a
L4410:
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
	jr ult,L4415
	ld a,(xsp+6)
	cp a,88
	jr ult,L4414
L4415:
	jp L4411
L4414:
	ld a,(xsp+5)
	sub a,(xsp+24)
	ld izl,a
	ld wa,(xsp+36)
	cp wa,0
	jr lt,L4416
	ld c,izl
	cp c,144
	jr ult,L4417
	ld a,izl
	extz wa
	sub wa,256
	jr L4418
L4417:
	ld a,izl
	extz wa
L4418:
	ld iy,wa
	jr L4419
L4416:
	ld c,izl
	cp c,112
	jr ule,L4420
	ld a,izl
	extz wa
	sub wa,256
	jr L4421
L4420:
	ld a,izl
	extz wa
L4421:
	ld iy,wa
L4419:
	ld xwa,_id_route_lim0
	ld c,(xsp+6)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+10),a
	ld wa,iy
	cp wa,0
	jr lt,L4422
	ld wa,iy
	ld c,(xsp+10)
	extz bc
	cp wa,bc
	jr ult,L4423
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
L4423:
	jr L4424
L4422:
	ld wa,iy
	neg wa
	ld c,(xsp+10)
	extz bc
	cp wa,bc
	jr ult,L4425
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
L4425:
L4424:
	ld a,ixl
	extz wa
	ld bc,(xsp+32)
	add bc,1
	cp wa,bc
	jr gt,L4426
	jr L4411
L4426:
	dec 1,ixl
L4412:
L4413:
	jp L4410
L4411:
L4409:
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
	jr z,L4527
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
L4527:
	ld a,(_road_lines__30)
	cp a,0
	jp z,L4528
	ld wa,(xsp+22)
	cp wa,2
	jp lt,L4528
	ld wa,(xsp+22)
	cp wa,255
	jp gt,L4528
	ld a,(_road_lines__30)
	extz wa
	sub wa,1
	ld (xsp+24),wa
	ld wa,iz
	cp wa,(xsp+22)
	jp lt,L4529
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
L4529:
	jp L4530
L4528:
	ld a,(_road_lines__30)
	extz wa
	sub wa,1
	ld (xsp+24),wa
	jp L4534
L4531:
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
	jr ge,L4535
	ld wa,(xsp+22)
	jr L4536
L4535:
	ld wa,iz
L4536:
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
	jr ult,L4537
	ld wa,iz
	cp wa,(xsp+22)
	jr lt,L4537
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
L4537:
	ld a,(xsp+43)
	cp a,2
	jr nz,L4538
	ld wa,iz
	cp wa,(xsp+22)
	jr lt,L4538
	ld a,izl
	ld (xsp+48),a
	ld wa,(xsp+18)
	srl 1,wa
	ld (xsp+50),wa
	ld bc,(xsp+16)
	cp bc,(xsp+50)
	jr ule,L4539
	ld wa,(xsp+16)
	sub wa,(xsp+50)
	jr L4540
L4539:
	ld wa,(xsp+16)
L4540:
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
L4538:
	ld wa,(xsp+16)
	ld bc,(xsp+18)
	sub wa,bc
	ld (xsp+16),wa
	ld wa,iz
	cp wa,(xsp+22)
	jr ge,L4541
	jr L4532
L4541:
L4533:
	decw 1,(xsp+24)
L4534:
	ld wa,(xsp+24)
	cp wa,0
	jp ge,L4531
L4532:
L4530:
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
	jr ge,L4542
	ld wa,(xsp+42)
	neg wa
	ld (xsp+42),wa
L4542:
	ld wa,(xsp+44)
	cp wa,0
	jr ge,L4543
	ld wa,(xsp+44)
	neg wa
	ld (xsp+44),wa
L4543:
	ld wa,(xsp+42)
	cp wa,46
	jr ge,L4545
	ld wa,(xsp+44)
	cp wa,46
	jr lt,L4544
L4545:
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
L4544:
	ld bc,(xsp+24)
	cp bc,0
	jr ge,L4546
	ld wa,1
	jr L4547
L4546:
	ld wa,0
L4547:
	ld (xsp+26),a
	jr L4550
L4548:
	ld a,(xsp+22)
	ld xbc,_id_sl__30
	ld de,(xsp+24)
	exts xde
	add xbc,xde
	ld (xbc),a
	decw 1,(xsp+24)
L4550:
	ld wa,(xsp+24)
	cp wa,0
	jr ge,L4548
L4549:
	ld a,izl
	add a,1
	ld (_band_first__30),a
	ld a,(_band_first__30)
	cp a,(_band_held__30)
	jp ule,L4551
	ld a,(_band_first__30)
	sub a,(_band_held__30)
	cp a,2
	jr uge,L4553
	ld a,(_band_wait__30)
	cp a,16
	jr ult,L4552
L4553:
	ldb (_band_wait__30),0
	jr L4554
L4552:
	incb 1,(_band_wait__30)
	jr L4557
L4555:
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
L4557:
	ld a,(_band_first__30)
	cp a,(_band_held__30)
	jr ugt,L4555
L4556:
L4554:
	jr L4558
L4551:
	ldb (_band_wait__30),0
L4558:
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
	jp z,L4559
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
	jr ule,L4560
	ld a,(_road_bottom__30)
	extz wa
	ld (xsp+44),wa
L4560:
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
	jr L4563
L4561:
	ld c,(xsp+58)
	incb 1,(xsp+58)
	extz bc
	and bc,2
	cp bc,0
	jr z,L4564
	ld wa,(xsp+46)
	jr L4565
L4564:
	ld wa,(xsp+56)
L4565:
	ld xbc,(xsp+48)
	inc 2,xbc
	ld (xsp+48),xbc
	dec 2,xbc
	ld (xbc),wa
L4563:
	ld xwa,(xsp+48)
	cp xwa,(xsp+52)
	jr ult,L4561
L4562:
	jr L4566
L4559:
	ld wa,(xsp+42)
	cp wa,24
	jr le,L4567
	ldw (xsp+42),24
L4567:
	ld a,(_band_first__30)
	extz wa
	ld de,(xsp+42)
	cp de,0
	jr le,L4568
	ld bc,(xsp+42)
	jr L4569
L4568:
	ld bc,0
L4569:
	add wa,bc
	ld (xsp+44),wa
	ld wa,(xsp+44)
	ld c,(_road_bottom__30)
	extz bc
	cp wa,bc
	jr ule,L4570
	ld a,(_road_bottom__30)
	extz wa
	ld (xsp+44),wa
L4570:
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
	jr L4573
L4571:
	ld wa,(xsp+46)
	ld xbc,(xsp+48)
	inc 2,xbc
	ld (xsp+48),xbc
	dec 2,xbc
	ld (xbc),wa
L4573:
	ld xwa,(xsp+48)
	cp xwa,(xsp+52)
	jr ult,L4571
L4572:
L4566:
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
	jr z,L4574
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
	jr L4577
L4575:
	ld wa,(xsp+12)
	ld xbc,(xsp+16)
	inc 2,xbc
	ld (xsp+16),xbc
	dec 2,xbc
	ld (xbc),wa
L4577:
	ld xwa,(xsp+16)
	cp xwa,(xsp+20)
	jr ult,L4575
L4576:
L4574:
	ld xwa,_bc_top__30
	ld c,(xsp+14)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	cp a,(_band_first__30)
	jr uge,L4578
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
	jr L4581
L4579:
	ld wa,(xsp+12)
	ld xbc,(xsp+16)
	inc 2,xbc
	ld (xsp+16),xbc
	dec 2,xbc
	ld (xbc),wa
L4581:
	ld xwa,(xsp+16)
	cp xwa,(xsp+20)
	jr ult,L4579
L4580:
L4578:
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
	jr le,L4582
	ld wa,(_band_shift__30)
	jr L4583
L4582:
	ld wa,0
L4583:
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
	jp nz,L4584
	ld a,(_road_base_x__30)
	extz wa
	ld e,(_pan_fine__30)
	cp e,0
	jr z,L4585
	ld bc,(_pan_head__30)
	exts xbc
	divs xbc,2
	neg bc
	exts xbc
	divs xbc,16
	jr L4586
L4585:
	ld bc,(xsp+94)
	sra 1,bc
	neg bc
	ld de,(xsp+90)
	sra 4,de
	add bc,de
L4586:
	add wa,bc
	extz wa
	ld (xsp+12),wa
	ld a,(_road_base_x__30)
	extz wa
	ld e,(_pan_fine__30)
	cp e,0
	jr z,L4587
	ld bc,(_pan_head__30)
	sll 1,bc
	neg bc
	exts xbc
	divs xbc,16
	jr L4588
L4587:
	ld bc,(xsp+94)
	sll 1,bc
	neg bc
	ld de,(xsp+90)
	sra 2,de
	add bc,de
L4588:
	add wa,bc
	extz wa
	ld (xsp+14),wa
	ld c,(_band_first__30)
	cp c,244
	jr uge,L4589
	ld a,(_band_first__30)
	extz wa
	add wa,0
	jr L4590
L4589:
	ld a,(_band_first__30)
	extz wa
L4590:
	ld (xsp+16),a
	ld c,(xsp+16)
	cp c,0
	jr ule,L4591
	ld a,(xsp+16)
	extz wa
	jr L4592
L4591:
	ld a,0
	extz wa
L4592:
	ld (xsp+17),a
	ld c,(_band_first__30)
	cp c,(xsp+17)
	jr uge,L4593
	ld a,(_band_first__30)
	extz wa
	jr L4594
L4593:
	ld a,(xsp+17)
	extz wa
L4594:
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
	jr nz,L4596
	ld wa,(xsp+14)
	ld xbc,_band_mid__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	sll 1,xde
	add xbc,xde
	ld bc,(xbc)
	cp wa,bc
	jr nz,L4596
	ld a,(xsp+17)
	ld xbc,_band_bg_end__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr nz,L4596
	ld wa,(xsp+10)
	ld xbc,_band_pitch__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	exts bc
	cp wa,bc
	jr nz,L4596
	ld a,(_band_first__30)
	ld xbc,_band_bg_first__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jr z,L4595
L4596:
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
L4595:
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
	jr z,L4597
	jr L4600
L4598:
	ld wa,(xsp+14)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L4600:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr ult,L4598
L4599:
	jp L4601
L4597:
	ld a,(xsp+10)
	neg a
	extz wa
	sll 8,wa
	ld (xsp+36),wa
	ld wa,(xsp+20)
	ld iy,wa
	jr L4604
L4602:
	ld bc,iy
	cp bc,0
	jr uge,L4605
	ld wa,(xsp+12)
	jr L4606
L4605:
	ld wa,(xsp+14)
L4606:
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
L4604:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr uge,L4607
	ld wa,iy
	cp wa,(xsp+10)
	jr lt,L4602
L4607:
L4603:
	ld xwa,(_id_xy__30)
	ld bc,0
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld (xsp+32),xwa
	ld xwa,(xsp+32)
	cp xwa,(xsp+28)
	jr ule,L4608
	ld xwa,(xsp+28)
	ld (xsp+32),xwa
L4608:
	jr L4611
L4609:
	ld wa,(xsp+12)
	or wa,(xsp+36)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L4611:
	ld xwa,xix
	cp xwa,(xsp+32)
	jr ult,L4609
L4610:
	jr L4614
L4612:
	ld wa,(xsp+14)
	or wa,(xsp+36)
	ld xbc,xix
	inc 2,xbc
	ld xix,xbc
	dec 2,xbc
	ld (xbc),wa
L4614:
	ld xwa,xix
	cp xwa,(xsp+28)
	jr ult,L4612
L4613:
L4601:
	ld a,(xsp+10)
	ld xbc,_band_pitch__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
	ld wa,(xsp+14)
	ld (xsp+8),wa
	jp L4615
L4584:
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
	jr nz,L4617
	ld wa,(xsp+10)
	ld xbc,_band_pitch__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	exts bc
	cp wa,bc
	jr nz,L4617
	ld a,(_band_first__30)
	ld xbc,_band_bg_end__30
	ld e,(_id_buf__30)
	extz de
	exts xde
	add xbc,xde
	ld c,(xbc)
	cp a,c
	jp z,L4616
L4617:
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
	jr L4621
L4618:
	push xwa
	push xix
	push xiy
	call _sky_is_tall_course__30
	ld xbc,xwa
	pop xiy
	pop xix
	pop xwa
	cp c,0
	jr z,L4622
	ld wa,0
	jr L4623
L4622:
	ld wa,(xsp+10)
	neg wa
L4623:
	ld (xsp+18),wa
	ld wa,iy
	add wa,(xsp+18)
	cp wa,0
	jr ge,L4624
	ld wa,iy
	neg wa
	ld (xsp+18),wa
L4624:
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
L4620:
	inc 1,iy
L4621:
	ld wa,iy
	ld c,(_band_first__30)
	extz bc
	cp wa,bc
	jr ult,L4618
L4619:
L4616:
	ld wa,(xsp+16)
	ld (xsp+8),wa
L4615:
L4526:
	lda xsp,(xsp+82)
	pop xiz
	ret

; function id_road_ready
_id_road_ready:
	ld xwa,(_id_xy__30)
	ld (_id_xy_done__30),xwa
	ld xwa,(_id_bandcol__30)
	ld (_id_bandcol_done__30),xwa
L4626:
	ret

; function id_road_pan
_id_road_pan:
	ld wa,(xsp+4)
	ld (_pan_head__30),wa
	ld wa,(xsp+8)
	ld (_pan_lat__30),wa
	ldb (_pan_fine__30),1
L4628:
	ret

; function id_road_begin
_id_road_begin:
	ld xwa,(_id_xy_live__30)
	cp xwa,_id_xy_a__30
	jr nz,L4635
	ld xwa,_id_xy_b__30
	ld (_id_xy__30),xwa
	ld xwa,_id_bandcol_b__30
	ld (_id_bandcol__30),xwa
	jr L4636
L4635:
	ld xwa,_id_xy_a__30
	ld (_id_xy__30),xwa
	ld xwa,_id_bandcol_a__30
	ld (_id_bandcol__30),xwa
L4636:
	ld xbc,(_id_xy__30)
	cp xbc,_id_xy_a__30
	jr nz,L4637
	ld wa,0
	jr L4638
L4637:
	ld wa,1
L4638:
	ld (_id_buf__30),a
L4634:
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
	jr L4648
L4645:
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
L4647:
	inc 1,izl
L4648:
	ld a,izl
	cp a,(_road_lines__30)
	jr ult,L4645
L4646:
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
L4644:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_ahead
_id_road_ahead:
	ld xwa,_id_ahead__30
	jr L4650
L4650:
	ret

; function id_road_lines
_id_road_lines:
	ld a,(_road_lines__30)
	jr L4652
L4652:
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
	jr z,L4656
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
L4656:
	ld wa,(xsp+34)
	push xwa
	ld wa,(xsp+30)
	push xwa
	call _id_road_write__30
	lda xsp,(xsp+8)
	call _id_road_ready
L4655:
	lda xsp,(xsp+18)
	pop xiz
	ret

; function id_fill_hud_band
_id_fill_hud_band__30:
	push xiz
	lda xsp,(xsp-2)
	ld iz,152
	jr L4666
L4663:
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
L4665:
	inc 1,iz
L4666:
	ld wa,iz
	cp wa,152
	jr ult,L4663
L4664:
L4662:
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
	jr uge,L4672
	ld a,(_road_top__30)
	ld izl,a
	jr L4673
L4672:
	ld a,izl
	cp a,(_road_bottom__30)
	jr ule,L4674
	ld a,(_road_bottom__30)
	ld izl,a
L4674:
L4673:
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
L4671:
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
	jr uge,L4680
	ld a,(_road_top__30)
	ld izl,a
	jr L4681
L4680:
	ld a,izl
	cp a,(_road_bottom__30)
	jr ule,L4682
	ld a,(_road_bottom__30)
	ld izl,a
L4682:
L4681:
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
	jr L4679
L4679:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_band_phase
_id_road_band_phase:
	ld wa,(xsp+4)
	ld (_band_phase__30),wa
L4684:
	ret

; function id_road_join
_id_road_join:
	ld c,(xsp+4)
	cp c,1
	jr uge,L4689
	ld a,(xsp+4)
	extz wa
	jr L4690
L4689:
	ld wa,0
L4690:
	ld (_road_course__30),a
	call _id_load_palettes__30
	ld wa,0
	push xwa
	call _id_road_join_white
	lda xsp,(xsp+4)
L4688:
	ret

; function id_road_join_white
_id_road_join_white:
	push xiz
	lda xsp,(xsp-10)
	ld izl,0
	jp L4700
L4697:
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
L4699:
	inc 1,izl
L4700:
	ld a,izl
	cp a,4
	jp ult,L4697
L4698:
	ld wa,65535
	ld (_band_top__30+2),wa
	ld (_band_top__30),wa
	ld wa,65535
	ld (_band_mid__30+2),wa
	ld (_band_mid__30),wa
	ld wa,65535
	ld (_band_tree__30+2),wa
	ld (_band_tree__30),wa
L4696:
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
	jr nz,L4710
	ld ixl,0
L4710:
	jr L4713
L4711:
	ld xwa,(xsp+0)
	inc 1,xwa
	ld (xsp+0),xwa
	dec 1,xwa
	ld a,(xwa)
	ld izl,a
	ld a,izl
	cp a,(xsp+8)
	jr le,L4714
	ld a,(xsp+8)
	ld izl,a
	jr L4715
L4714:
	ld a,izl
	cp a,(xsp+9)
	jr ge,L4716
	ld a,(xsp+9)
	ld izl,a
L4716:
L4715:
	ld a,izl
	ld xbc,xiy
	inc 1,xbc
	ld xiy,xbc
	dec 1,xbc
	ld (xbc),a
	dec 1,ixl
L4713:
	ld a,ixl
	cp a,0
	jr nz,L4711
L4712:
	ld xwa,_id_sl__30+64
	ld c,(_road_lines__30)
	extz bc
	sub bc,1
	extz xbc
	add xwa,xbc
	ld a,(xwa)
	ld (_road_grade__30),a
L4709:
	lda xsp,(xsp+12)
	pop xiz
	ret

; function id_road_grade_buf
_id_road_grade_buf:
	ld xwa,_id_sl__30+64
	jr L4718
L4718:
	ret

; function id_road_band_first
_id_road_band_first:
	ld a,(_band_first__30)
	jr L4720
L4720:
	ret

; function id_road_visible_top
_id_road_visible_top:
	push xiz
	lda xsp,(xsp-2)
	ld c,(_band_first__30)
	cp c,244
	jr uge,L4728
	ld a,(_band_first__30)
	add a,0
	extz wa
	jr L4729
L4728:
	ld a,(_band_first__30)
	extz wa
L4729:
	ld izl,a
	ld a,izl
	cp a,0
	jr uge,L4730
	ld izl,0
L4730:
	ld c,izl
	cp c,(_road_bottom__30)
	jr ule,L4731
	ld a,(_road_bottom__30)
	extz wa
	jr L4732
L4731:
	ld a,izl
	extz wa
L4732:
	jr L4727
L4727:
	lda xsp,(xsp+2)
	pop xiz
	ret

; function id_road_grade_hi
_id_road_grade_hi:
	ld a,(_grade_hi__30)
	jr L4734
L4734:
	ret

; function id_road_grade_lo
_id_road_grade_lo:
	ld a,(_grade_lo__30)
	jr L4736
L4736:
	ret

; function id_road_set_hill
_id_road_set_hill:
	push xiz
	lda xsp,(xsp-2)
	ld a,(xsp+10)
	ld ixl,a
	ld a,ixl
	cp a,(_grade_hi__30)
	jr le,L4746
	ld a,(_grade_hi__30)
	ld ixl,a
	jr L4747
L4746:
	ld a,ixl
	cp a,(_grade_lo__30)
	jr ge,L4748
	ld a,(_grade_lo__30)
	ld ixl,a
L4748:
L4747:
	ld a,ixl
	ld (_road_grade__30),a
	ld izl,0
	jr L4752
L4749:
	ld a,ixl
	ld xbc,_id_sl__30+64
	ld e,izl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L4751:
	inc 1,izl
L4752:
	ld a,izl
	cp a,(_road_lines__30)
	jr ult,L4749
L4750:
L4745:
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
	jr ult,L4759
	ld a,ixl
	cp a,(_road_bottom__30)
	jr ule,L4758
L4759:
	ld wa,0
	jr L4757
L4758:
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
	jr lt,L4760
	ld a,(_road_lines__30)
	extz wa
	sub wa,1
	ld iz,wa
L4760:
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
	jr L4757
L4757:
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
	jr le,L4766
	ld iz,8
	jr L4767
L4766:
	ld wa,iz
	cp wa,65531
	jr ge,L4768
	ld iz,65531
L4768:
L4767:
	ld a,izl
	jr L4765
L4765:
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
	jr uge,L4774
	ld a,(_road_top__30)
	ld izl,a
	jr L4775
L4774:
	ld a,izl
	cp a,(_road_bottom__30)
	jr ule,L4776
	ld a,(_road_bottom__30)
	ld izl,a
L4776:
L4775:
	ld xwa,_id_half__30
	ld c,izl
	sub c,(_road_top__30)
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	jr L4773
L4773:
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
	jr ule,L4785
	ld wa,255
	jr L4784
L4785:
	jr L4788
L4786:
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
	jr ult,L4789
	ld a,ixl
	ld izl,a
	jr L4790
L4789:
	ld a,ixl
	sub a,1
	ld iyl,a
L4790:
L4788:
	ld a,izl
	cp a,iyl
	jr ult,L4786
L4787:
	ld a,(_road_top__30)
	add a,izl
	jr L4784
L4784:
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
	jr uge,L4796
	ld a,(_road_top__30)
	ld izl,a
	jr L4797
L4796:
	ld a,izl
	cp a,(_road_bottom__30)
	jr ule,L4798
	ld a,(_road_bottom__30)
	ld izl,a
L4798:
L4797:
	ld xwa,_id_ahead__30
	ld c,izl
	sub c,(_road_top__30)
	extz bc
	exts xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	jr L4795
L4795:
	pop xiz
	ret

; function id_scenery_char_count
_id_scenery_char_count:
	ld wa,0
	jr L4800
L4800:
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
L4802:
	ret

; function scenery_mode
_scenery_mode:
	ld a,(xsp+4)
	ld (_scn_mode__31),a
L4804:
	ret

; function id_scenery_passed
_id_scenery_passed:
	ld a,(_scn_passed__31)
	jr L4806
L4806:
	ret

; function kind_of
_kind_of__31:
	ld a,(_scn_mode__31)
	cp a,5
	jr nz,L4815
	ld wa,14
	jr L4814
L4815:
	ld a,(_scn_mode__31)
	cp a,1
	jr nz,L4816
	ld wa,12
	jr L4814
L4816:
	ld a,(_scn_mode__31)
	cp a,3
	jr ult,L4817
	ld wa,11
	jr L4814
L4817:
	ld a,(_scn_mode__31)
	cp a,2
	jr nz,L4818
	ld wa,13
	jr L4814
L4818:
	ld c,(xsp+4)
	cp c,0
	jr z,L4819
	call _theme_obj_kind_right
	extz wa
	jr L4820
L4819:
	call _theme_obj_kind_left
	extz wa
L4820:
	jr L4814
L4814:
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
	jp L4837
L4834:
	ld a,(_scn_passed__31)
	extz wa
	ld bc,1
	ld e,izl
	cp e,0
	jr z,L4840
L4839:
	sll 1,bc
	djnz e,L4839
L4840:
	extz bc
	and wa,bc
	cp wa,0
	jr nz,L4838
	jp L4836
L4838:
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
	jr nz,L4841
	ld wa,iy
	neg wa
	add wa,12
	cp wa,(xsp+12)
	jr lt,L4842
	ld wa,iy
	neg wa
	sub wa,12
	cp wa,(xsp+14)
	jr gt,L4842
	ld wa,1
	jr L4833
L4842:
	jr L4843
L4841:
	ld wa,iy
	add wa,12
	cp wa,(xsp+12)
	jr lt,L4844
	ld wa,iy
	sub wa,12
	cp wa,(xsp+14)
	jr gt,L4844
	ld wa,1
	jr L4833
L4844:
L4843:
L4836:
	inc 1,izl
L4837:
	ld a,izl
	cp a,2
	jp ult,L4834
L4835:
	ld wa,0
	jr L4833
L4833:
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
	jr L4846
L4846:
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
	jr L4859
L4856:
	ld a,izl
	extz wa
	mul xwa,43
	ld ixl,a
	ld a,(_scn_phase__31)
	add a,ixl
	ld c,iyl
	add c,ixl
	cp a,c
	jr uge,L4860
	ld a,(_scn_passed__31)
	extz wa
	ld e,izl
	extz de
	and de,1
	cp de,0
	jr z,L4861
	ld bc,2
	jr L4862
L4861:
	ld bc,1
L4862:
	extz bc
	or wa,bc
	ld (_scn_passed__31),a
L4860:
L4858:
	inc 1,izl
L4859:
	ld a,izl
	cp a,6
	jr ult,L4856
L4857:
L4855:
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
L4864:
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
	jr z,L4916
	ld wa,58
	jr L4917
L4916:
	ld wa,64
L4917:
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
	jr L4921
L4918:
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
	jr ule,L4922
	ld a,(xsp+0)
	ld (xsp+1),a
L4922:
L4920:
	incb 1,(xsp+0)
L4921:
	ld a,(xsp+0)
	cp a,6
	jr ult,L4918
L4919:
	ldb (xsp+0),0
	jp L4926
L4923:
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
	jr ule,L4927
	ld wa,(xsp+10)
	ld iz,wa
L4927:
	ld a,(xsp+4)
	add a,izl
	ld (xsp+18),a
	ld wa,iz
	cp wa,6
	jr uge,L4928
	ldb (xsp+17),4
	jr L4929
L4928:
	ld wa,iz
	cp wa,10
	jr uge,L4930
	ldb (xsp+17),3
	jr L4931
L4930:
	ld wa,iz
	cp wa,15
	jr uge,L4932
	ldb (xsp+17),2
	jr L4933
L4932:
	ld wa,iz
	cp wa,22
	jr uge,L4934
	ldb (xsp+17),1
	jr L4935
L4934:
	ldb (xsp+17),0
L4935:
L4933:
L4931:
L4929:
	ld c,(xsp+12)
	extz bc
	and bc,1
	cp bc,0
	jr z,L4936
	ld wa,1
	jr L4937
L4936:
	ld wa,0
L4937:
	ld (xsp+14),a
	ld a,(_scn_mode__31)
	cp a,5
	jr nz,L4938
	ldb (xsp+15),14
	ldb (xsp+16),6
	jr L4939
L4938:
	ld a,(_scn_mode__31)
	cp a,1
	jr nz,L4940
	ldb (xsp+15),12
	ldb (xsp+16),4
	jr L4941
L4940:
	ld a,(_scn_mode__31)
	cp a,3
	jr ult,L4942
	ldb (xsp+15),11
	ldb (xsp+16),9
	jr L4943
L4942:
	ld a,(_scn_mode__31)
	cp a,2
	jr nz,L4944
	ldb (xsp+15),13
	ldb (xsp+16),10
	jr L4945
L4944:
	ld a,(xsp+14)
	cp a,0
	jr z,L4946
	call _theme_obj_kind_right
	ld (xsp+15),a
	ldb (xsp+16),2
	jr L4947
L4946:
	call _theme_obj_kind_left
	ld (xsp+15),a
	ldb (xsp+16),1
L4947:
L4945:
L4943:
L4941:
L4939:
	ld c,(xsp+14)
	cp c,0
	jr z,L4948
	ld c,(xsp+15)
	cp c,11
	jr ult,L4948
	ld wa,1
	jr L4949
L4948:
	ld wa,0
L4949:
	ld (xsp+20),a
	ld a,(_scn_mode__31)
	cp a,5
	jr nz,L4950
	ld a,(_g_vb_counter)
	extz wa
	sra 3,wa
	ld c,(xsp+12)
	extz bc
	add wa,bc
	and wa,1
	ld (xsp+20),a
	jr L4951
L4950:
	ld a,(_scn_mode__31)
	cp a,3
	jr nz,L4952
	ldb (xsp+20),0
	jr L4953
L4952:
	ld a,(_scn_mode__31)
	cp a,4
	jr nz,L4954
	ldb (xsp+20),1
L4954:
L4953:
L4951:
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
	jr ge,L4955
	jp L4925
L4955:
	ld wa,(xsp+38)
	cp wa,(xsp+6)
	jr le,L4956
	ld wa,(xsp+6)
	ld (xsp+38),wa
L4956:
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
	jr z,L4957
	ld wa,(xsp+40)
	add wa,(xsp+42)
	ld (xsp+26),wa
	jr L4958
L4957:
	ld wa,(xsp+40)
	sub wa,(xsp+42)
	ld xbc,(xsp+34)
	ld c,(xbc+6)
	extz bc
	sub wa,bc
	add wa,1
	ld (xsp+26),wa
L4958:
	ld wa,(xsp+26)
	cp wa,65504
	jr lt,L4960
	ld wa,(xsp+26)
	cp wa,168
	jr le,L4959
L4960:
	jp L4925
L4959:
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
	jr z,L4961
	ld wa,128
	jr L4962
L4961:
	ld wa,0
L4962:
	ld e,(_bridge_line)
	cp e,0
	jr z,L4963
	ld e,(xsp+19)
	cp e,(_bridge_line)
	jr uge,L4963
	ld bc,16
	jr L4964
L4963:
	ld c,(_id_spr_priority)
	extz bc
L4964:
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
L4925:
	incb 1,(xsp+0)
L4926:
	ld a,(xsp+0)
	cp a,6
	jp ult,L4923
L4924:
	ld a,(xsp+3)
	push xwa
	ld a,(xsp+6)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L4915:
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
L4966:
	ret

; function theme_obj_map
_theme_obj_map:
	ld xwa,_objmap__32
	jr L4968
L4968:
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
	jr L4970
L4970:
	ret

; function theme_obj_kind_left
_theme_obj_kind_left:
	ld a,(_kind_l__32)
	jr L4972
L4972:
	ret

; function theme_obj_kind_right
_theme_obj_kind_right:
	ld a,(_kind_r__32)
	jr L4974
L4974:
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
	jr L4984
L4981:
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
L4983:
	inc 1,izl
L4984:
	ld a,izl
	cp a,8
	jr ult,L4981
L4982:
L4980:
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
	jr ult,L4992
	ld wa,iz
	cp wa,101
	jr uge,L4992
	ld iz,101
	jr L4993
L4992:
	ld wa,iz
	cp wa,125
	jr ult,L4994
	ld wa,iz
	cp wa,(_pano_base__32)
	jr uge,L4994
	ld wa,(_obj_base__32)
	ld iz,wa
L4994:
L4993:
	ld wa,iz
	cp wa,(_obj_end__32)
	jr ult,L4995
	ld wa,(_pano_end__32)
	ld iz,wa
L4995:
	ld wa,iz
	cp wa,(xsp+2)
	jr ult,L4996
	ld wa,iz
	cp wa,(_obj_base__32)
	jr uge,L4996
	ld wa,0
	jr L4991
L4996:
	ld wa,iz
	add wa,1
	ld (_next_slot__32),wa
	ld wa,iz
	jr L4991
L4991:
	lda xsp,(xsp+4)
	pop xiz
	ret

; function load_kind
_load_kind__32:
	push xiz
	lda xsp,(xsp-10)
	ldb (xsp+0),0
	jp L5012
L5009:
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
	jp L5016
L5013:
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
	jr nz,L5017
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
	jr z,L5018
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
L5018:
L5017:
L5015:
	inc 1,izl
L5016:
	ld a,izl
	ld xbc,(xsp+2)
	ld c,(xbc+2)
	cp a,c
	jp ult,L5013
L5014:
L5011:
	incb 1,(xsp+0)
L5012:
	ld a,(xsp+0)
	cp a,5
	jp ult,L5009
L5010:
L5008:
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
	jr L5028
L5025:
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
L5027:
	inc 1,izl
L5028:
	ld a,izl
	cp a,4
	jr ult,L5025
L5026:
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
L5024:
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
	jr L5067
L5064:
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
L5066:
	inc 1,iz
L5067:
	ld wa,iz
	cp wa,(xiy+4)
	jr ult,L5064
L5065:
	ld iz,0
	jr L5071
L5068:
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
L5070:
	inc 1,iz
L5071:
	ld wa,iz
	cp wa,52
	jr ult,L5068
L5069:
	ldb (xsp+11),0
	jr L5075
L5072:
	ld ixl,0
	jr L5079
L5076:
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
L5078:
	inc 1,ixl
L5079:
	ld a,ixl
	cp a,32
	jr ult,L5076
L5077:
L5074:
	incb 1,(xsp+11)
L5075:
	ld a,(xsp+11)
	cp a,11
	jr ult,L5072
L5073:
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
	jr L5083
L5080:
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
L5082:
	inc 1,iz
L5083:
	ld wa,iz
	cp wa,4
	jr ult,L5080
L5081:
	ld iz,0
	jr L5087
L5084:
	ld wa,65535
	ld xbc,_objmap__32
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5086:
	inc 1,iz
L5087:
	ld wa,iz
	cp wa,256
	jr ult,L5084
L5085:
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
	jr z,L5088
	push xix
	push xiy
	ld a,(_kind_r__32)
	push xwa
	call _load_kind__32
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L5088:
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
	jr uge,L5089
	push xix
	push xiy
	ld wa,12
	push xwa
	call _load_kind__32
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L5089:
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
	jr z,L5091
	ld a,(xsp+22)
	cp a,10
	jr ult,L5090
L5091:
	push xix
	push xiy
	ld wa,14
	push xwa
	call _load_kind__32
	lda xsp,(xsp+4)
	pop xiy
	pop xix
L5090:
	ld iz,0
	jr L5095
L5092:
	ld xwa,_objmap__32
	ld bc,iz
	extz xbc
	sll 1,xbc
	add xwa,xbc
	ld wa,(xwa)
	cp wa,65535
	jr nz,L5096
	ld wa,0
	ld xbc,_objmap__32
	ld de,iz
	extz xde
	sll 1,xde
	add xbc,xde
	ld (xbc),wa
L5096:
L5094:
	inc 1,iz
L5095:
	ld wa,iz
	cp wa,256
	jr ult,L5092
L5093:
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
L5063:
	lda xsp,(xsp+14)
	pop xiz
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
	jr ult,L5100
	ld wa,4095
	jr L5099
L5100:
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
	jr L5099
L5099:
	lda xsp,(xsp+6)
	pop xiz
	ret

; function theme_flash
_theme_flash:
	push xiz
	lda xsp,(xsp-10)
	ld izl,0
	jp L5114
L5111:
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
L5113:
	inc 1,izl
L5114:
	ld a,izl
	cp a,13
	jp ult,L5111
L5112:
	ldb (xsp+1),0
	jr L5118
L5115:
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
L5117:
	incb 1,(xsp+1)
L5118:
	ld a,(xsp+1)
	cp a,4
	jr ult,L5115
L5116:
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
L5110:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function traffic_set_hard
_traffic_set_hard:
	ld a,(xsp+4)
	ld (_hard__33),a
	ld c,(xsp+4)
	cp c,0
	jr z,L5123
	ld wa,7
	jr L5124
L5123:
	ld wa,6
L5124:
	ld (_trf_cap__33),a
L5122:
	ret

; function rnd8
_rnd8__33:
	ld wa,(_rng__33)
	mul xwa,25173
	add wa,13849
	ld (_rng__33),wa
	ld wa,(_rng__33)
	srl 8,wa
	jr L5126
L5126:
	ret

; function traffic_init
_traffic_init:
	push xiz
	lda xsp,(xsp-2)
	ld wa,(xsp+10)
	ld (_trf_tiles__33),wa
	ld iz,0
	jr L5140
L5137:
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
L5139:
	inc 1,iz
L5140:
	ld wa,iz
	ld bc,(_gfx_traffic_tiles_count)
	sll 3,bc
	cp wa,bc
	jr ult,L5137
L5138:
	ld iz,0
	jr L5144
L5141:
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
L5143:
	inc 1,iz
L5144:
	ld wa,iz
	cp wa,5
	jr ult,L5141
L5142:
	call _traffic_clear
L5136:
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
	jr nz,L5148
	ldb (_half_wheel__33),1
L5148:
L5147:
	ret

; function traffic_clear
_traffic_clear:
	push xiz
	lda xsp,(xsp-2)
	ld izl,0
	jr L5158
L5155:
	ld a,0
	ld xbc,_cars__33
	ld e,izl
	extz de
	muls xde,14
	add xbc,xde
	ld (xbc),a
L5157:
	inc 1,izl
L5158:
	ld a,izl
	cp a,7
	jr ult,L5155
L5156:
	ld a,50
	push xwa
	ld a,28
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
L5154:
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
	jr ule,L5164
	ld a,(_trf_cap__33)
	ld izl,a
L5164:
	ld a,izl
	ld (_dens_min__33),a
	ld c,(xsp+12)
	cp c,(_trf_cap__33)
	jr ule,L5165
	ld a,(_trf_cap__33)
	extz wa
	jr L5166
L5165:
	ld a,(xsp+12)
	extz wa
L5166:
	ld (_dens_max__33),a
	ld a,(_dens_min__33)
	ld (_target__33),a
	ldb (_cooldown__33),30
L5163:
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
	jr L5168
L5168:
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
	jr ge,L5173
	ld iz,0
L5173:
	ld wa,iz
	cp wa,3
	jr le,L5174
	ld iz,3
L5174:
	ld a,izl
	jr L5172
L5172:
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
	jr L5200
L5197:
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr nz,L5201
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld (xsp+4),xwa
	jr L5198
L5201:
L5199:
	inc 1,izl
L5200:
	ld a,izl
	cp a,7
	jr ult,L5197
L5198:
	ld xwa,(xsp+4)
	cp xwa,0
	jr nz,L5202
	jp L5196
L5202:
	ldb (xsp+2),0
	jp L5206
L5203:
	ld wa,0
	ld (xsp+8),a
	call _rnd8__33
	extz wa
	and wa,3
	ld (xsp+1),a
	ld izl,0
	jr L5210
L5207:
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L5211
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
	jr nz,L5211
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
	jr le,L5211
	ldb (xsp+8),1
L5211:
L5209:
	inc 1,izl
L5210:
	ld a,izl
	cp a,7
	jr ult,L5207
L5208:
	ld a,(xsp+8)
	cp a,0
	jr nz,L5212
	jr L5204
L5212:
L5205:
	incb 1,(xsp+2)
L5206:
	ld a,(xsp+2)
	cp a,3
	jp ult,L5203
L5204:
	ld a,(xsp+2)
	cp a,3
	jr nz,L5213
	jp L5196
L5213:
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
	jr z,L5214
	ld wa,42
	jr L5215
L5214:
	ld wa,55
L5215:
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
	jr nz,L5216
	ld xwa,(xsp+4)
	ld a,(xwa+3)
	sub a,15
	ld xbc,(xsp+4)
	ld (xbc+3),a
L5216:
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
L5196:
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
	jp L5249
L5246:
	ld xwa,_cars__33
	ld c,(xsp+0)
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld xiz,xwa
	ld a,(xiz)
	cp a,0
	jr nz,L5250
	jp L5248
L5250:
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
	jr z,L5251
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr ge,L5252
	ld wa,(xiz+4)
	add wa,8
	ld (xiz+4),wa
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr le,L5253
	ld wa,(xiz+10)
	ld (xiz+4),wa
L5253:
	jr L5254
L5252:
	ld wa,(xiz+4)
	sub wa,8
	ld (xiz+4),wa
	ld wa,(xiz+4)
	cp wa,(xiz+10)
	jr ge,L5255
	ld wa,(xiz+10)
	ld (xiz+4),wa
L5255:
L5254:
	jr L5256
L5251:
	call _rnd8__33
	ld e,(_hard__33)
	cp e,0
	jr z,L5258
	ld bc,6
	jr L5259
L5258:
	ld bc,2
L5259:
	cp a,c
	jr uge,L5257
	ld wa,(xiz+4)
	push xwa
	call _lane_of__33
	lda xsp,(xsp+4)
	ld (xsp+8),a
	ld a,(xsp+8)
	cp a,0
	jr nz,L5260
	ldb (xsp+8),1
	jr L5261
L5260:
	ld a,(xsp+8)
	cp a,3
	jr nz,L5262
	ldb (xsp+8),2
	jr L5263
L5262:
	push xwa
	call _rnd8__33
	ld xbc,xwa
	pop xwa
	extz bc
	and bc,1
	cp bc,0
	jr z,L5264
	ld a,(xsp+8)
	add a,1
	extz wa
	jr L5265
L5264:
	ld a,(xsp+8)
	sub a,1
	extz wa
L5265:
	ld (xsp+8),a
L5263:
L5261:
	ld a,(xsp+8)
	push xwa
	call _lane_lat__33
	lda xsp,(xsp+4)
	ld (xiz+10),wa
L5257:
L5256:
	ld wa,(xiz+6)
	ld bc,(_car_d__33)
	neg bc
	sll 4,bc
	sub bc,64
	cp wa,bc
	jr lt,L5267
	ld wa,(xiz+6)
	ld bc,1600
	ld de,(_car_d__33)
	sub bc,de
	sll 4,bc
	cp wa,bc
	jr le,L5266
L5267:
	ldb (xiz),0
	jr L5248
L5266:
	incb 1,(xsp+1)
L5248:
	incb 1,(xsp+0)
L5249:
	ld a,(xsp+0)
	cp a,7
	jp ult,L5246
L5247:
	ld a,(_cooldown__33)
	cp a,0
	jr z,L5268
	decb 1,(_cooldown__33)
L5268:
	ld a,(xsp+22)
	cp a,0
	jr z,L5269
	ld a,(xsp+1)
	cp a,(_target__33)
	jr uge,L5269
	ld a,(_cooldown__33)
	cp a,0
	jr nz,L5269
	ld a,(xsp+18)
	cp a,50
	jr ule,L5269
	call _spawn__33
	ld c,(_hard__33)
	cp c,0
	jr z,L5270
	ld wa,16
	jr L5271
L5270:
	ld wa,25
L5271:
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
	jr ule,L5272
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
L5272:
L5269:
L5245:
	lda xsp,(xsp+10)
	pop xiz
	ret

; function traffic_collide
_traffic_collide:
	push xiz
	lda xsp,(xsp-12)
	ld iyl,0
	jp L5293
L5290:
	ld xwa,_cars__33
	ld c,iyl
	extz bc
	muls xbc,14
	add xwa,xbc
	lda xwa,(xwa)
	ld xiz,xwa
	ld a,(xiz)
	cp a,0
	jr nz,L5294
	jp L5292
L5294:
	ld bc,(xiz+12)
	cp bc,(xiz+6)
	jr ge,L5295
	ld wa,(xiz+12)
	jr L5296
L5295:
	ld wa,(xiz+6)
L5296:
	ld (xsp+8),wa
	ld bc,(xiz+12)
	cp bc,(xiz+6)
	jr ge,L5297
	ld wa,(xiz+6)
	jr L5298
L5297:
	ld wa,(xiz+12)
L5298:
	ld (xsp+10),wa
	ld wa,(xsp+8)
	cp wa,224
	jr gt,L5300
	ld wa,(xsp+10)
	cp wa,65440
	jr ge,L5299
L5300:
	jr L5292
L5299:
	ld wa,(xiz+4)
	sub wa,(xsp+20)
	ld ix,wa
	ld wa,ix
	cp wa,0
	jr ge,L5301
	ld wa,ix
	neg wa
	ld ix,wa
L5301:
	ld wa,ix
	cp wa,416
	jr ge,L5302
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
	jr ge,L5303
	ld wa,1
	jr L5304
L5303:
	ld wa,2
L5304:
	jr L5289
L5302:
L5292:
	inc 1,iyl
L5293:
	ld a,iyl
	cp a,7
	jp ult,L5290
L5291:
	ld wa,0
	jr L5289
L5289:
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
	jr L5341
L5338:
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L5342
	ld a,izl
	lda xbc,(xsp+0)
	ld e,(xsp+7)
	incb 1,(xsp+7)
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L5342:
L5340:
	inc 1,izl
L5341:
	ld a,izl
	cp a,7
	jr ult,L5338
L5339:
	ld izl,1
	jp L5346
L5343:
	lda xwa,(xsp+0)
	ld c,izl
	extz bc
	exts xbc
	add xwa,xbc
	ld a,(xwa)
	ld (xsp+14),a
	ld a,izl
	ld ixl,a
	jr L5349
L5347:
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
L5349:
	ld a,ixl
	cp a,0
	jr ule,L5350
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
	jr gt,L5347
L5350:
L5348:
	ld a,(xsp+14)
	lda xbc,(xsp+0)
	ld e,ixl
	extz de
	exts xde
	add xbc,xde
	ld (xbc),a
L5345:
	inc 1,izl
L5346:
	ld a,izl
	cp a,(xsp+7)
	jp ult,L5343
L5344:
	ld izl,0
	jp L5354
L5351:
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
	jr ge,L5355
	jp L5353
L5355:
	push xix
	ld wa,(xsp+22)
	push xwa
	call _id_road_line_at_distance
	lda xsp,(xsp+4)
	pop xix
	ld (xsp+20),a
	ld a,(xsp+20)
	cp a,255
	jr nz,L5356
	jp L5353
L5356:
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
	jr ge,L5357
	jp L5353
L5357:
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
	jr ult,L5358
	ldb (xsp+21),0
	jr L5359
L5358:
	ld a,(xsp+22)
	cp a,20
	jr ult,L5360
	ldb (xsp+21),1
	jr L5361
L5360:
	ld a,(xsp+22)
	cp a,13
	jr ult,L5362
	ldb (xsp+21),2
	jr L5363
L5362:
	ld a,(xsp+22)
	cp a,9
	jr ult,L5364
	ldb (xsp+21),3
	jr L5365
L5364:
	ldb (xsp+21),4
L5365:
L5363:
L5361:
L5359:
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
	jr le,L5366
	jp L5353
L5366:
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
	jr z,L5367
	ld bc,(xsp+26)
	ld e,(_bridge_line)
	extz de
	cp bc,de
	jr ge,L5367
	ld wa,16
	jr L5368
L5367:
	ld a,(_id_spr_priority)
	extz wa
L5368:
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
L5353:
	inc 1,izl
L5354:
	ld a,izl
	cp a,(xsp+7)
	jp ult,L5351
L5352:
	push xix
	ld a,50
	push xwa
	ld a,(xsp+18)
	push xwa
	call _id_spr_hide_range
	lda xsp,(xsp+8)
	pop xix
L5337:
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
	jp L5391
L5388:
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
	jp L5395
L5392:
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld a,(xwa)
	cp a,0
	jr z,L5397
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	cp wa,65280
	jr ge,L5396
L5397:
	jr L5394
L5396:
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
	jr ge,L5398
	ld wa,ix
	neg wa
	ld ix,wa
L5398:
	ld wa,ix
	cp wa,480
	jr ge,L5399
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	cp wa,(xsp+8)
	jr ge,L5399
	ld xwa,_cars__33
	ld c,izl
	extz bc
	muls xbc,14
	add xwa,xbc
	ld wa,(xwa+6)
	ld (xsp+8),wa
L5399:
L5394:
	inc 1,izl
L5395:
	ld a,izl
	cp a,7
	jp ult,L5392
L5393:
	ld wa,(xsp+8)
	cp wa,(xsp+4)
	jr gt,L5401
	ld wa,(xsp+8)
	cp wa,(xsp+4)
	jr nz,L5400
	ld wa,(xsp+24)
	cp wa,0
	jr ge,L5403
	ld a,iyl
	cp a,0
	jr z,L5402
L5403:
	ld wa,(xsp+24)
	cp wa,0
	jr le,L5400
	ld a,iyl
	cp a,3
	jr nz,L5400
L5402:
L5401:
	ld wa,(xsp+8)
	ld (xsp+4),wa
	ld a,iyl
	ld (xsp+2),a
L5400:
L5390:
	inc 1,iyl
L5391:
	ld a,iyl
	cp a,4
	jp ult,L5388
L5389:
	ld wa,(xsp+4)
	cp wa,14400
	jr le,L5404
	ld wa,(xsp+24)
	cp wa,0
	jr z,L5404
	ld wa,(xsp+24)
	jr L5387
L5404:
	push xix
	push xiy
	ld a,(xsp+10)
	push xwa
	call _lane_lat__33
	lda xsp,(xsp+4)
	pop xiy
	pop xix
	jr L5387
L5387:
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
	db 83,85,77,77,69,82,32,79,86,69,82,68,82,73,86,69
	db 0
_S0_1:
	db 77,73,68,78,73,71,72,84,32,67,79,65,83,84,0
_S0_2:
	db 80,65,76,77,32,66,79,85,76,69,86,65,82,68,0
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
_cd__0_L1126:
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
	db 244,10,240,5,255,96,255,96,255,96,255,48,39,12,41,12
	db 43,12,46,12,244,10,240,5,36,12,39,12,255,12,39,12
	db 41,12,39,12,36,24,34,12,36,12,255,12,34,12,31,24
	db 27,24,32,12,36,12,255,12,36,12,39,12,41,12,44,24
	db 41,36,39,12,37,24,255,24,36,12,39,12,255,12,39,12
	db 41,12,39,12,44,24,46,12,44,12,43,12,39,12,255,12
	db 39,12,41,24,44,18,41,18,37,12,41,24,44,24,43,36
	db 41,12,39,24,34,24,244,10,240,5,36,12,39,12,255,12
	db 39,12,41,12,39,12,36,24,34,12,36,12,255,12,34,12
	db 31,24,27,24,32,12,36,12,255,12,36,12,39,12,41,12
	db 44,24,41,36,39,12,37,24,255,24,36,12,39,12,255,12
	db 39,12,41,12,39,12,44,24,46,12,44,12,43,12,39,12
	db 255,12,39,12,41,24,44,12,43,12,41,12,37,12,41,12
	db 44,12,46,24,46,48,255,24,39,12,41,12,244,10,240,5
	db 37,12,37,12,41,12,37,12,34,24,37,24,39,12,39,12
	db 43,12,39,12,36,24,39,24,41,12,41,12,44,12,41,12
	db 37,12,41,12,44,24,43,24,46,24,43,24,39,24,37,12
	db 41,12,46,12,41,12,37,12,41,12,46,24,39,12,43,12
	db 48,12,43,12,39,12,43,12,48,24,49,24,48,24,46,24
	db 44,24,43,12,46,12,49,12,46,12,43,12,39,12,255,24
	db 244,11,240,4,39,12,44,12,255,12,44,12,46,12,48,24
	db 44,12,46,24,43,12,39,36,255,24,39,12,44,12,255,12
	db 44,12,46,12,48,24,51,12,48,24,46,12,43,36,255,24
	db 41,12,44,12,255,12,44,12,49,12,48,12,46,12,44,12
	db 48,24,46,12,44,12,39,24,36,24,37,12,41,12,46,12
	db 49,12,48,12,46,12,44,12,46,12,46,48,43,24,39,24
	db 244,11,240,4,39,12,44,12,255,12,44,12,46,12,48,24
	db 44,12,46,24,43,12,39,36,255,24,39,12,44,12,255,12
	db 44,12,46,12,48,24,51,12,48,24,46,12,43,36,255,24
	db 41,12,44,12,255,12,44,12,49,12,48,12,46,12,44,12
	db 48,24,46,12,44,12,39,24,36,24,37,12,41,12,46,12
	db 49,12,48,24,46,24,44,72,255,24,244,4,240,5,27,12
	db 32,12,255,12,32,12,34,12,36,24,32,12,34,24,31,12
	db 27,36,255,24,27,12,32,12,255,12,32,12,34,12,36,24
	db 39,12,36,24,34,12,31,36,255,24,39,12,44,12,255,12
	db 44,12,46,12,48,24,44,12,46,24,43,12,39,36,255,24
	db 39,12,44,12,255,12,44,12,46,12,48,24,51,12,48,24
	db 46,12,43,36,255,24,244,10,240,5,36,12,39,12,255,12
	db 39,12,41,12,39,12,36,24,34,12,36,12,255,12,34,12
	db 31,24,27,24,32,12,36,12,255,12,36,12,39,12,41,12
	db 44,24,41,36,39,12,37,24,255,24,36,12,39,12,255,12
	db 39,12,41,12,39,12,44,24,46,12,44,12,43,12,39,12
	db 255,12,39,12,41,24,44,18,41,18,37,12,41,24,44,24
	db 43,36,41,12,39,24,34,24,244,10,240,5,37,12,37,12
	db 41,12,37,12,34,24,37,24,39,12,39,12,43,12,39,12
	db 36,24,39,24,41,12,41,12,44,12,41,12,37,12,41,12
	db 44,24,43,24,46,24,43,24,39,24,37,12,41,12,46,12
	db 41,12,37,12,41,12,46,24,39,12,43,12,48,12,43,12
	db 39,12,43,12,48,24,49,24,48,24,46,24,44,24,43,12
	db 46,12,49,12,46,12,43,12,39,12,255,24,244,11,240,4
	db 39,12,44,12,255,12,44,12,46,12,48,24,44,12,46,24
	db 43,12,39,36,255,24,39,12,44,12,255,12,44,12,46,12
	db 48,24,51,12,48,24,46,12,43,36,255,24,41,12,44,12
	db 255,12,44,12,49,12,48,12,46,12,44,12,48,24,46,12
	db 44,12,39,24,36,24,37,12,41,12,46,12,49,12,48,12
	db 46,12,44,12,46,12,46,48,43,24,39,24,244,11,240,4
	db 39,12,44,12,255,12,44,12,46,12,48,24,44,12,46,24
	db 43,12,39,36,255,24,39,12,44,12,255,12,44,12,46,12
	db 48,24,51,12,48,24,46,12,43,36,255,24,41,12,44,12
	db 255,12,44,12,49,12,48,12,46,12,44,12,48,24,46,12
	db 44,12,39,24,36,24,37,12,41,12,46,12,49,12,48,24
	db 46,24,44,72,255,24,244,10,240,5,48,36,46,12,44,48
	db 41,36,44,12,49,48,48,24,46,24,44,24,39,24,43,48
	db 46,48,44,36,43,12,41,48,37,24,41,24,44,24,49,24
	db 49,24,48,24,46,24,44,24,46,24,43,24,39,24,34,24
	db 244,4,240,5,27,6,32,6,36,6,39,6,27,6,32,6
	db 36,6,39,6,27,6,32,6,36,6,39,6,27,6,32,6
	db 36,6,39,6,39,12,34,12,31,12,27,12,31,12,34,12
	db 39,24,29,18,36,18,41,12,36,24,32,24,27,6,31,6
	db 36,6,39,6,43,6,48,6,43,6,39,6,36,48,37,12
	db 41,12,255,12,41,12,44,12,41,12,37,24,44,36,39,12
	db 36,24,27,24,29,6,34,6,37,6,41,6,29,6,34,6
	db 37,6,41,6,29,6,34,6,37,6,41,6,29,6,34,6
	db 37,6,41,6,39,12,34,12,31,12,27,12,31,12,34,12
	db 39,24,244,4,240,5,27,6,32,6,36,6,39,6,44,6
	db 48,6,44,6,39,6,36,48,34,12,39,12,255,12,39,12
	db 43,12,39,12,34,24,44,36,41,12,36,24,29,24,29,6
	db 32,6,37,6,41,6,29,6,32,6,37,6,41,6,29,6
	db 32,6,37,6,41,6,29,6,32,6,37,6,41,6,39,12
	db 36,12,32,12,27,12,32,12,36,12,39,24,27,18,34,18
	db 39,12,34,24,31,24,29,6,32,6,37,6,41,6,44,6
	db 49,6,44,6,41,6,37,48,34,12,39,12,255,12,39,12
	db 43,12,39,12,34,24,244,10,240,5,37,12,37,12,41,12
	db 37,12,34,24,37,24,39,12,39,12,43,12,39,12,36,24
	db 39,24,41,12,41,12,44,12,41,12,37,12,41,12,44,24
	db 43,24,46,24,43,24,39,24,37,12,41,12,46,12,41,12
	db 37,12,41,12,46,24,39,12,43,12,48,12,43,12,39,12
	db 43,12,48,24,49,24,48,24,46,24,44,24,43,12,46,12
	db 49,12,46,12,43,12,39,12,255,24,244,11,240,4,39,12
	db 44,12,255,12,44,12,46,12,48,24,44,12,46,24,43,12
	db 39,36,255,24,39,12,44,12,255,12,44,12,46,12,48,24
	db 51,12,48,24,46,12,43,36,255,24,41,12,44,12,255,12
	db 44,12,49,12,48,12,46,12,44,12,48,24,46,12,44,12
	db 39,24,36,24,37,12,41,12,46,12,49,12,48,12,46,12
	db 44,12,46,12,46,48,43,24,39,24,244,11,240,4,39,12
	db 44,12,255,12,44,12,46,12,48,24,44,12,46,24,43,12
	db 39,36,255,24,39,12,44,12,255,12,44,12,46,12,48,24
	db 51,12,48,24,46,12,43,36,255,24,41,12,44,12,255,12
	db 44,12,49,12,48,12,46,12,44,12,48,24,46,12,44,12
	db 39,24,36,24,37,12,41,12,46,12,49,12,48,24,46,24
	db 44,72,255,24,244,10,240,5,44,96,43,96,41,96,39,48
	db 255,48,0
_song0_v1__9:
	db 244,6,240,6,10,12,10,12,10,12,10,12,10,12,17,12
	db 22,12,10,12,5,12,5,12,5,12,5,12,5,12,12,12
	db 17,12,5,12,3,12,3,12,3,12,3,12,3,12,10,12
	db 15,12,3,12,5,12,5,12,5,12,5,12,5,12,12,12
	db 17,12,5,12,244,6,240,6,10,12,22,12,10,12,22,12
	db 10,12,22,12,10,12,22,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,7,12,19,12,7,12,19,12
	db 7,12,19,12,7,12,19,12,3,12,15,12,3,12,15,12
	db 3,12,15,12,3,12,15,12,10,12,22,12,10,12,22,12
	db 10,12,22,12,10,12,22,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,3,12,15,12,3,12,15,12
	db 3,12,15,12,3,12,15,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,244,6,240,6,10,12,22,12
	db 10,12,22,12,10,12,22,12,10,12,22,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,7,12,19,12
	db 7,12,19,12,7,12,19,12,7,12,19,12,3,12,15,12
	db 3,12,15,12,3,12,15,12,3,12,15,12,10,12,22,12
	db 10,12,22,12,10,12,22,12,10,12,22,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,3,12,15,12
	db 3,12,15,12,3,12,15,12,3,12,15,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,244,6,240,6
	db 12,12,12,12,12,12,12,12,12,12,19,12,24,12,12,12
	db 2,12,2,12,2,12,2,12,2,12,9,12,14,12,2,12
	db 3,12,3,12,3,12,3,12,3,12,10,12,15,12,3,12
	db 5,12,5,12,5,12,5,12,5,12,12,12,17,12,5,12
	db 12,12,12,12,12,12,12,12,12,12,19,12,24,12,12,12
	db 2,12,2,12,2,12,2,12,2,12,9,12,14,12,2,12
	db 3,12,3,12,3,12,3,12,3,12,10,12,15,12,3,12
	db 5,12,5,12,5,12,5,12,5,12,12,12,17,12,5,12
	db 244,6,240,6,10,12,22,12,10,12,22,12,10,12,22,12
	db 10,12,22,12,5,12,17,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,7,12,19,12,7,12,19,12,7,12,19,12
	db 7,12,19,12,2,12,14,12,2,12,14,12,2,12,14,12
	db 2,12,14,12,3,12,15,12,3,12,15,12,3,12,15,12
	db 3,12,15,12,10,12,22,12,10,12,22,12,10,12,22,12
	db 10,12,22,12,12,12,24,12,12,12,24,12,12,12,24,12
	db 12,12,24,12,5,12,17,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,244,6,240,6,10,12,22,12,10,12,22,12
	db 10,12,22,12,10,12,22,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,7,12,19,12,7,12,19,12
	db 7,12,19,12,7,12,19,12,2,12,14,12,2,12,14,12
	db 2,12,14,12,2,12,14,12,3,12,15,12,3,12,15,12
	db 3,12,15,12,3,12,15,12,10,12,22,12,10,12,22,12
	db 10,12,22,12,10,12,22,12,12,12,24,12,12,12,24,12
	db 12,12,24,12,12,12,24,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,244,6,240,6,10,12,22,12
	db 10,12,22,12,10,12,22,12,10,12,22,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,7,12,19,12
	db 7,12,19,12,7,12,19,12,7,12,19,12,2,12,14,12
	db 2,12,14,12,2,12,14,12,2,12,14,12,3,12,15,12
	db 3,12,15,12,3,12,15,12,3,12,15,12,10,12,22,12
	db 10,12,22,12,10,12,22,12,10,12,22,12,12,12,24,12
	db 12,12,24,12,12,12,24,12,12,12,24,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,244,6,240,6
	db 10,12,22,12,10,12,22,12,10,12,22,12,10,12,22,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,5,12,17,12
	db 7,12,19,12,7,12,19,12,7,12,19,12,7,12,19,12
	db 3,12,15,12,3,12,15,12,3,12,15,12,3,12,15,12
	db 10,12,22,12,10,12,22,12,10,12,22,12,10,12,22,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,5,12,17,12
	db 3,12,15,12,3,12,15,12,3,12,15,12,3,12,15,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,5,12,17,12
	db 244,6,240,6,12,12,12,12,12,12,12,12,12,12,19,12
	db 24,12,12,12,2,12,2,12,2,12,2,12,2,12,9,12
	db 14,12,2,12,3,12,3,12,3,12,3,12,3,12,10,12
	db 15,12,3,12,5,12,5,12,5,12,5,12,5,12,12,12
	db 17,12,5,12,12,12,12,12,12,12,12,12,12,12,19,12
	db 24,12,12,12,2,12,2,12,2,12,2,12,2,12,9,12
	db 14,12,2,12,3,12,3,12,3,12,3,12,3,12,10,12
	db 15,12,3,12,5,12,5,12,5,12,5,12,5,12,12,12
	db 17,12,5,12,244,6,240,6,10,12,22,12,10,12,22,12
	db 10,12,22,12,10,12,22,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,7,12,19,12,7,12,19,12
	db 7,12,19,12,7,12,19,12,2,12,14,12,2,12,14,12
	db 2,12,14,12,2,12,14,12,3,12,15,12,3,12,15,12
	db 3,12,15,12,3,12,15,12,10,12,22,12,10,12,22,12
	db 10,12,22,12,10,12,22,12,12,12,24,12,12,12,24,12
	db 12,12,24,12,12,12,24,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,244,6,240,6,10,12,22,12
	db 10,12,22,12,10,12,22,12,10,12,22,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,7,12,19,12
	db 7,12,19,12,7,12,19,12,7,12,19,12,2,12,14,12
	db 2,12,14,12,2,12,14,12,2,12,14,12,3,12,15,12
	db 3,12,15,12,3,12,15,12,3,12,15,12,10,12,22,12
	db 10,12,22,12,10,12,22,12,10,12,22,12,12,12,24,12
	db 12,12,24,12,12,12,24,12,12,12,24,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,244,6,240,6
	db 7,24,10,24,14,24,19,24,3,24,7,24,10,24,15,24
	db 10,24,14,24,17,24,22,24,5,24,9,24,12,24,17,24
	db 7,24,10,24,14,24,19,24,3,24,7,24,10,24,15,24
	db 12,24,15,24,19,24,24,24,5,24,9,24,12,24,17,24
	db 244,6,240,6,10,12,22,12,10,12,22,12,10,12,22,12
	db 10,12,22,12,5,12,17,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,7,12,19,12,7,12,19,12,7,12,19,12
	db 7,12,19,12,2,12,14,12,2,12,14,12,2,12,14,12
	db 2,12,14,12,3,12,15,12,3,12,15,12,3,12,15,12
	db 3,12,15,12,10,12,22,12,10,12,22,12,10,12,22,12
	db 10,12,22,12,12,12,24,12,12,12,24,12,12,12,24,12
	db 12,12,24,12,5,12,17,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,244,6,240,6,10,12,22,12,10,12,22,12
	db 10,12,22,12,10,12,22,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,7,12,19,12,7,12,19,12
	db 7,12,19,12,7,12,19,12,3,12,15,12,3,12,15,12
	db 3,12,15,12,3,12,15,12,10,12,22,12,10,12,22,12
	db 10,12,22,12,10,12,22,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,3,12,15,12,3,12,15,12
	db 3,12,15,12,3,12,15,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,244,6,240,6,12,12,12,12
	db 12,12,12,12,12,12,19,12,24,12,12,12,2,12,2,12
	db 2,12,2,12,2,12,9,12,14,12,2,12,3,12,3,12
	db 3,12,3,12,3,12,10,12,15,12,3,12,5,12,5,12
	db 5,12,5,12,5,12,12,12,17,12,5,12,12,12,12,12
	db 12,12,12,12,12,12,19,12,24,12,12,12,2,12,2,12
	db 2,12,2,12,2,12,9,12,14,12,2,12,3,12,3,12
	db 3,12,3,12,3,12,10,12,15,12,3,12,5,12,5,12
	db 5,12,5,12,5,12,12,12,17,12,5,12,244,6,240,6
	db 10,12,22,12,10,12,22,12,10,12,22,12,10,12,22,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,5,12,17,12
	db 7,12,19,12,7,12,19,12,7,12,19,12,7,12,19,12
	db 2,12,14,12,2,12,14,12,2,12,14,12,2,12,14,12
	db 3,12,15,12,3,12,15,12,3,12,15,12,3,12,15,12
	db 10,12,22,12,10,12,22,12,10,12,22,12,10,12,22,12
	db 12,12,24,12,12,12,24,12,12,12,24,12,12,12,24,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,5,12,17,12
	db 244,6,240,6,10,12,22,12,10,12,22,12,10,12,22,12
	db 10,12,22,12,5,12,17,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,7,12,19,12,7,12,19,12,7,12,19,12
	db 7,12,19,12,2,12,14,12,2,12,14,12,2,12,14,12
	db 2,12,14,12,3,12,15,12,3,12,15,12,3,12,15,12
	db 3,12,15,12,10,12,22,12,10,12,22,12,10,12,22,12
	db 10,12,22,12,12,12,24,12,12,12,24,12,12,12,24,12
	db 12,12,24,12,5,12,17,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,244,6,240,6,10,24,14,24,17,24,22,24
	db 5,24,9,24,12,24,17,24,3,24,7,24,10,24,15,24
	db 5,24,9,24,12,24,17,24,0
_song0_v2__9:
	db 244,6,240,8,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,29,6
	db 26,6,22,6,29,6,33,6,36,6,29,6,36,6,33,6
	db 29,6,33,6,36,6,29,6,36,6,33,6,29,6,36,6
	db 33,6,29,6,27,6,31,6,34,6,27,6,34,6,31,6
	db 27,6,31,6,34,6,27,6,34,6,31,6,27,6,34,6
	db 31,6,27,6,29,6,33,6,36,6,29,6,36,6,33,6
	db 29,6,33,6,36,6,29,6,36,6,33,6,29,6,36,6
	db 33,6,29,6,244,6,240,8,255,12,26,12,255,12,29,12
	db 255,12,26,6,22,6,255,12,29,12,255,12,33,12,255,12
	db 36,12,255,12,33,6,29,6,255,12,36,12,255,12,34,12
	db 255,12,38,12,255,12,34,6,31,6,255,12,38,12,255,12
	db 31,12,255,12,34,12,255,12,31,6,27,6,255,12,34,12
	db 255,12,26,12,255,12,29,12,255,12,26,6,22,6,255,12
	db 29,12,255,12,33,12,255,12,36,12,255,12,33,6,29,6
	db 255,12,36,12,255,12,31,12,255,12,34,12,255,12,31,6
	db 27,6,255,12,34,12,255,12,33,12,255,12,36,12,255,12
	db 33,6,29,6,255,12,36,12,244,6,240,8,255,12,26,12
	db 255,12,29,12,255,12,26,6,22,6,255,12,29,12,255,12
	db 33,12,255,12,36,12,255,12,33,6,29,6,255,12,36,12
	db 255,12,34,12,255,12,38,12,255,12,34,6,31,6,255,12
	db 38,12,255,12,31,12,255,12,34,12,255,12,31,6,27,6
	db 255,12,34,12,255,12,26,12,255,12,29,12,255,12,26,6
	db 22,6,255,12,29,12,255,12,33,12,255,12,36,12,255,12
	db 33,6,29,6,255,12,36,12,255,12,31,12,255,12,34,12
	db 255,12,31,6,27,6,255,12,34,12,255,12,33,12,255,12
	db 36,12,255,12,33,6,29,6,255,12,36,12,244,6,240,8
	db 24,6,27,6,31,6,24,6,31,6,27,6,24,6,27,6
	db 31,6,24,6,31,6,27,6,24,6,31,6,27,6,24,6
	db 26,6,29,6,33,6,26,6,33,6,29,6,26,6,29,6
	db 33,6,26,6,33,6,29,6,26,6,33,6,29,6,26,6
	db 27,6,31,6,34,6,27,6,34,6,31,6,27,6,31,6
	db 34,6,27,6,34,6,31,6,27,6,34,6,31,6,27,6
	db 29,6,33,6,36,6,29,6,36,6,33,6,29,6,33,6
	db 36,6,29,6,36,6,33,6,29,6,36,6,33,6,29,6
	db 24,6,27,6,31,6,24,6,31,6,27,6,24,6,27,6
	db 31,6,24,6,31,6,27,6,24,6,31,6,27,6,24,6
	db 26,6,29,6,33,6,26,6,33,6,29,6,26,6,29,6
	db 33,6,26,6,33,6,29,6,26,6,33,6,29,6,26,6
	db 27,6,31,6,34,6,27,6,34,6,31,6,27,6,31,6
	db 34,6,27,6,34,6,31,6,27,6,34,6,31,6,27,6
	db 29,6,33,6,36,6,39,6,36,6,33,6,29,6,33,6
	db 36,6,39,6,36,6,33,6,29,6,36,6,33,6,39,6
	db 244,6,240,8,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,29,6
	db 26,6,22,6,29,6,33,6,36,6,29,6,36,6,33,6
	db 29,6,33,6,36,6,29,6,36,6,33,6,29,6,36,6
	db 33,6,29,6,31,6,34,6,38,6,31,6,38,6,34,6
	db 31,6,34,6,38,6,31,6,38,6,34,6,31,6,38,6
	db 34,6,31,6,26,6,29,6,33,6,26,6,33,6,29,6
	db 26,6,29,6,33,6,26,6,33,6,29,6,26,6,33,6
	db 29,6,26,6,27,6,31,6,34,6,27,6,34,6,31,6
	db 27,6,31,6,34,6,27,6,34,6,31,6,27,6,34,6
	db 31,6,27,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,29,6
	db 26,6,22,6,24,6,27,6,31,6,24,6,31,6,27,6
	db 24,6,27,6,31,6,24,6,31,6,27,6,24,6,31,6
	db 27,6,24,6,29,6,33,6,36,6,29,6,36,6,33,6
	db 29,6,33,6,36,6,29,6,36,6,33,6,29,6,36,6
	db 33,6,29,6,244,6,240,8,22,6,26,6,29,6,22,6
	db 29,6,26,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,29,6,26,6,22,6,29,6,33,6,36,6,29,6
	db 36,6,33,6,29,6,33,6,36,6,29,6,36,6,33,6
	db 29,6,36,6,33,6,29,6,31,6,34,6,38,6,31,6
	db 38,6,34,6,31,6,34,6,38,6,31,6,38,6,34,6
	db 31,6,38,6,34,6,31,6,26,6,29,6,33,6,26,6
	db 33,6,29,6,26,6,29,6,33,6,26,6,33,6,29,6
	db 26,6,33,6,29,6,26,6,27,6,31,6,34,6,27,6
	db 34,6,31,6,27,6,31,6,34,6,27,6,34,6,31,6
	db 27,6,34,6,31,6,27,6,22,6,26,6,29,6,22,6
	db 29,6,26,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,29,6,26,6,22,6,24,6,27,6,31,6,24,6
	db 31,6,27,6,24,6,27,6,31,6,24,6,31,6,27,6
	db 24,6,31,6,27,6,24,6,29,6,33,6,36,6,29,6
	db 36,6,33,6,29,6,33,6,36,6,29,6,36,6,33,6
	db 29,6,36,6,33,6,29,6,244,6,240,8,255,12,26,12
	db 255,12,29,12,255,12,26,6,22,6,255,12,29,12,255,12
	db 33,12,255,12,36,12,255,12,33,6,29,6,255,12,36,12
	db 255,12,34,12,255,12,38,12,255,12,34,6,31,6,255,12
	db 38,12,255,12,29,12,255,12,33,12,255,12,29,6,26,6
	db 255,12,33,12,255,12,31,12,255,12,34,12,255,12,31,6
	db 27,6,255,12,34,12,255,12,26,12,255,12,29,12,255,12
	db 26,6,22,6,255,12,29,12,255,12,27,12,255,12,31,12
	db 255,12,27,6,24,6,255,12,31,12,255,12,33,12,255,12
	db 36,12,255,12,33,6,29,6,255,12,36,12,244,6,240,8
	db 255,12,26,12,255,12,29,12,255,12,26,6,22,6,255,12
	db 29,12,255,12,33,12,255,12,36,12,255,12,33,6,29,6
	db 255,12,36,12,255,12,34,12,255,12,38,12,255,12,34,6
	db 31,6,255,12,38,12,255,12,31,12,255,12,34,12,255,12
	db 31,6,27,6,255,12,34,12,255,12,26,12,255,12,29,12
	db 255,12,26,6,22,6,255,12,29,12,255,12,33,12,255,12
	db 36,12,255,12,33,6,29,6,255,12,36,12,255,12,31,12
	db 255,12,34,12,255,12,31,6,27,6,255,12,34,12,255,12
	db 33,12,255,12,36,12,255,12,33,6,29,6,255,12,36,12
	db 244,6,240,8,24,6,27,6,31,6,24,6,31,6,27,6
	db 24,6,27,6,31,6,24,6,31,6,27,6,24,6,31,6
	db 27,6,24,6,26,6,29,6,33,6,26,6,33,6,29,6
	db 26,6,29,6,33,6,26,6,33,6,29,6,26,6,33,6
	db 29,6,26,6,27,6,31,6,34,6,27,6,34,6,31,6
	db 27,6,31,6,34,6,27,6,34,6,31,6,27,6,34,6
	db 31,6,27,6,29,6,33,6,36,6,29,6,36,6,33,6
	db 29,6,33,6,36,6,29,6,36,6,33,6,29,6,36,6
	db 33,6,29,6,24,6,27,6,31,6,24,6,31,6,27,6
	db 24,6,27,6,31,6,24,6,31,6,27,6,24,6,31,6
	db 27,6,24,6,26,6,29,6,33,6,26,6,33,6,29,6
	db 26,6,29,6,33,6,26,6,33,6,29,6,26,6,33,6
	db 29,6,26,6,27,6,31,6,34,6,27,6,34,6,31,6
	db 27,6,31,6,34,6,27,6,34,6,31,6,27,6,34,6
	db 31,6,27,6,29,6,33,6,36,6,39,6,36,6,33,6
	db 29,6,33,6,36,6,39,6,36,6,33,6,29,6,36,6
	db 33,6,39,6,244,6,240,8,22,6,26,6,29,6,22,6
	db 29,6,26,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,29,6,26,6,22,6,29,6,33,6,36,6,29,6
	db 36,6,33,6,29,6,33,6,36,6,29,6,36,6,33,6
	db 29,6,36,6,33,6,29,6,31,6,34,6,38,6,31,6
	db 38,6,34,6,31,6,34,6,38,6,31,6,38,6,34,6
	db 31,6,38,6,34,6,31,6,26,6,29,6,33,6,26,6
	db 33,6,29,6,26,6,29,6,33,6,26,6,33,6,29,6
	db 26,6,33,6,29,6,26,6,27,6,31,6,34,6,27,6
	db 34,6,31,6,27,6,31,6,34,6,27,6,34,6,31,6
	db 27,6,34,6,31,6,27,6,22,6,26,6,29,6,22,6
	db 29,6,26,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,29,6,26,6,22,6,24,6,27,6,31,6,24,6
	db 31,6,27,6,24,6,27,6,31,6,24,6,31,6,27,6
	db 24,6,31,6,27,6,24,6,29,6,33,6,36,6,29,6
	db 36,6,33,6,29,6,33,6,36,6,29,6,36,6,33,6
	db 29,6,36,6,33,6,29,6,244,6,240,8,22,6,26,6
	db 29,6,22,6,29,6,26,6,22,6,26,6,29,6,22,6
	db 29,6,26,6,22,6,29,6,26,6,22,6,29,6,33,6
	db 36,6,29,6,36,6,33,6,29,6,33,6,36,6,29,6
	db 36,6,33,6,29,6,36,6,33,6,29,6,31,6,34,6
	db 38,6,31,6,38,6,34,6,31,6,34,6,38,6,31,6
	db 38,6,34,6,31,6,38,6,34,6,31,6,26,6,29,6
	db 33,6,26,6,33,6,29,6,26,6,29,6,33,6,26,6
	db 33,6,29,6,26,6,33,6,29,6,26,6,27,6,31,6
	db 34,6,27,6,34,6,31,6,27,6,31,6,34,6,27,6
	db 34,6,31,6,27,6,34,6,31,6,27,6,22,6,26,6
	db 29,6,22,6,29,6,26,6,22,6,26,6,29,6,22,6
	db 29,6,26,6,22,6,29,6,26,6,22,6,24,6,27,6
	db 31,6,24,6,31,6,27,6,24,6,27,6,31,6,24,6
	db 31,6,27,6,24,6,31,6,27,6,24,6,29,6,33,6
	db 36,6,29,6,36,6,33,6,29,6,33,6,36,6,29,6
	db 36,6,33,6,29,6,36,6,33,6,29,6,244,6,240,8
	db 34,48,38,48,31,48,34,48,26,48,29,48,33,48,36,48
	db 34,48,38,48,31,48,34,48,27,48,31,48,33,48,36,48
	db 244,6,240,8,255,12,26,12,255,12,29,12,255,12,26,6
	db 22,6,255,12,29,12,255,12,33,12,255,12,36,12,255,12
	db 33,6,29,6,255,12,36,12,255,12,34,12,255,12,38,12
	db 255,12,34,6,31,6,255,12,38,12,255,12,29,12,255,12
	db 33,12,255,12,29,6,26,6,255,12,33,12,255,12,31,12
	db 255,12,34,12,255,12,31,6,27,6,255,12,34,12,255,12
	db 26,12,255,12,29,12,255,12,26,6,22,6,255,12,29,12
	db 255,12,27,12,255,12,31,12,255,12,27,6,24,6,255,12
	db 31,12,255,12,33,12,255,12,36,12,255,12,33,6,29,6
	db 255,12,36,12,244,6,240,8,255,12,26,12,255,12,29,12
	db 255,12,26,6,22,6,255,12,29,12,255,12,33,12,255,12
	db 36,12,255,12,33,6,29,6,255,12,36,12,255,12,34,12
	db 255,12,38,12,255,12,34,6,31,6,255,12,38,12,255,12
	db 31,12,255,12,34,12,255,12,31,6,27,6,255,12,34,12
	db 255,12,26,12,255,12,29,12,255,12,26,6,22,6,255,12
	db 29,12,255,12,33,12,255,12,36,12,255,12,33,6,29,6
	db 255,12,36,12,255,12,31,12,255,12,34,12,255,12,31,6
	db 27,6,255,12,34,12,255,12,33,12,255,12,36,12,255,12
	db 33,6,29,6,255,12,36,12,244,6,240,8,24,6,27,6
	db 31,6,24,6,31,6,27,6,24,6,27,6,31,6,24,6
	db 31,6,27,6,24,6,31,6,27,6,24,6,26,6,29,6
	db 33,6,26,6,33,6,29,6,26,6,29,6,33,6,26,6
	db 33,6,29,6,26,6,33,6,29,6,26,6,27,6,31,6
	db 34,6,27,6,34,6,31,6,27,6,31,6,34,6,27,6
	db 34,6,31,6,27,6,34,6,31,6,27,6,29,6,33,6
	db 36,6,29,6,36,6,33,6,29,6,33,6,36,6,29,6
	db 36,6,33,6,29,6,36,6,33,6,29,6,24,6,27,6
	db 31,6,24,6,31,6,27,6,24,6,27,6,31,6,24,6
	db 31,6,27,6,24,6,31,6,27,6,24,6,26,6,29,6
	db 33,6,26,6,33,6,29,6,26,6,29,6,33,6,26,6
	db 33,6,29,6,26,6,33,6,29,6,26,6,27,6,31,6
	db 34,6,27,6,34,6,31,6,27,6,31,6,34,6,27,6
	db 34,6,31,6,27,6,34,6,31,6,27,6,29,6,33,6
	db 36,6,39,6,36,6,33,6,29,6,33,6,36,6,39,6
	db 36,6,33,6,29,6,36,6,33,6,39,6,244,6,240,8
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,26,6
	db 29,6,22,6,29,6,26,6,22,6,29,6,26,6,22,6
	db 29,6,33,6,36,6,29,6,36,6,33,6,29,6,33,6
	db 36,6,29,6,36,6,33,6,29,6,36,6,33,6,29,6
	db 31,6,34,6,38,6,31,6,38,6,34,6,31,6,34,6
	db 38,6,31,6,38,6,34,6,31,6,38,6,34,6,31,6
	db 26,6,29,6,33,6,26,6,33,6,29,6,26,6,29,6
	db 33,6,26,6,33,6,29,6,26,6,33,6,29,6,26,6
	db 27,6,31,6,34,6,27,6,34,6,31,6,27,6,31,6
	db 34,6,27,6,34,6,31,6,27,6,34,6,31,6,27,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,26,6
	db 29,6,22,6,29,6,26,6,22,6,29,6,26,6,22,6
	db 24,6,27,6,31,6,24,6,31,6,27,6,24,6,27,6
	db 31,6,24,6,31,6,27,6,24,6,31,6,27,6,24,6
	db 29,6,33,6,36,6,29,6,36,6,33,6,29,6,33,6
	db 36,6,29,6,36,6,33,6,29,6,36,6,33,6,29,6
	db 244,6,240,8,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,29,6
	db 26,6,22,6,29,6,33,6,36,6,29,6,36,6,33,6
	db 29,6,33,6,36,6,29,6,36,6,33,6,29,6,36,6
	db 33,6,29,6,31,6,34,6,38,6,31,6,38,6,34,6
	db 31,6,34,6,38,6,31,6,38,6,34,6,31,6,38,6
	db 34,6,31,6,26,6,29,6,33,6,26,6,33,6,29,6
	db 26,6,29,6,33,6,26,6,33,6,29,6,26,6,33,6
	db 29,6,26,6,27,6,31,6,34,6,27,6,34,6,31,6
	db 27,6,31,6,34,6,27,6,34,6,31,6,27,6,34,6
	db 31,6,27,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,29,6
	db 26,6,22,6,24,6,27,6,31,6,24,6,31,6,27,6
	db 24,6,27,6,31,6,24,6,31,6,27,6,24,6,31,6
	db 27,6,24,6,29,6,33,6,36,6,29,6,36,6,33,6
	db 29,6,33,6,36,6,29,6,36,6,33,6,29,6,36,6
	db 33,6,29,6,244,6,240,8,26,48,29,48,33,48,36,48
	db 31,48,34,48,33,48,36,48,0
_song0_v3__9:
	db 244,1,240,5,3,24,244,2,240,12,5,24,244,3,240,7
	db 6,24,244,2,240,12,5,24,244,1,240,5,3,24,244,2
	db 240,12,5,24,244,3,240,7,6,24,244,2,240,12,5,24
	db 244,1,240,5,3,24,244,2,240,12,5,24,244,3,240,7
	db 6,24,244,2,240,12,5,24,244,3,240,7,6,6,6,6
	db 6,12,6,6,6,6,6,12,244,1,240,5,3,12,244,3
	db 240,7,6,12,6,6,6,6,6,12,244,1,240,5,3,12
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
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,12,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,3,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,12
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,3,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,244,2,240,12,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 3,12,244,3,240,7,6,12,244,2,240,12,5,12,244,3
	db 240,7,6,6,6,6,6,12,6,6,6,6,6,12,244,1
	db 240,5,3,12,244,3,240,7,6,12,6,6,6,6,6,12
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
	db 6,6,6,6,6,12,244,1,240,5,3,12,244,2,240,11
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,6,5,6
	db 244,1,240,5,3,12,244,2,240,11,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,11,5,12,244,3,240,7,6,12,244,2,240,12,5,6
	db 5,6,244,1,240,5,3,12,244,2,240,11,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,11,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,6,5,6,244,1,240,5,3,12,244,2,240,11,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,6,5,6,244,1,240,5,3,12,244,2,240,11
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,244,2,240,11,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,6,5,6,244,1,240,5,3,12,244,2
	db 240,11,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,11,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,6,5,6,244,1,240,5,3,12
	db 244,2,240,11,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,244,2,240,11,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,6,5,6,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
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
	db 244,3,240,7,6,12,6,6,6,6,6,12,244,1,240,5
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
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,3,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,3,240,7,6,6,6,6,6,12,6,6,6,6,6,12
	db 244,1,240,5,3,12,244,3,240,7,6,12,6,6,6,6
	db 6,12,244,1,240,5,3,12,244,2,240,11,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,6,5,6,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,11,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,6,5,6,244,1
	db 240,5,3,12,244,2,240,11,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,11
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,6,5,6
	db 244,1,240,5,3,12,244,2,240,11,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,11,5,12,244,3,240,7,6,12,244,2,240,12,5,6
	db 5,6,244,1,240,5,3,12,244,2,240,11,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,11,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,6,5,6,244,1,240,5,3,12,244,2,240,11,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,6,5,6,244,1,240,5,3,12,244,2,240,11
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,244,2,240,11,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,6,5,6,244,1,240,5,3,12,244,2
	db 240,11,5,12,244,3,240,7,6,12,244,2,240,12,5,12
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
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,12
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
	db 244,2,240,12,5,12,244,3,240,7,6,6,6,6,6,12
	db 6,6,6,6,6,12,244,1,240,5,3,12,244,3,240,7
	db 6,12,6,6,6,6,6,12,244,1,240,5,3,12,244,2
	db 240,11,5,12,244,3,240,7,6,12,244,2,240,12,5,6
	db 5,6,244,1,240,5,3,12,244,2,240,11,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,11,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,6,5,6,244,1,240,5,3,12,244,2,240,11,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,6,5,6,244,1,240,5,3,12,244,2,240,11
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,244,2,240,11,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,6,5,6,244,1,240,5,3,12,244,2
	db 240,11,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,11,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,6,5,6,244,1,240,5,3,12
	db 244,2,240,11,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,244,2,240,11,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,6,5,6,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,11,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,6,5,6,244,1
	db 240,5,3,12,244,2,240,11,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,3,240,7,6,6,6,6,6,12
	db 6,6,6,6,6,12,244,1,240,5,3,12,244,3,240,7
	db 6,12,6,6,6,6,6,12,244,1,240,5,3,12,244,2
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
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,3,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,3,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,3,240,7
	db 6,6,6,6,6,12,6,6,6,6,6,12,244,1,240,5
	db 3,12,244,3,240,7,6,12,6,6,6,6,6,12,244,1
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
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,12,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,3,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,12
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,3,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,3,240,7,6,6,6,6,6,12,6,6,6,6
	db 6,12,244,1,240,5,3,12,244,3,240,7,6,12,6,6
	db 6,6,6,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,3,240,7,6,24,244,2,240,12,5,24,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,3,240,7,6,24,244,2
	db 240,12,5,24,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,3,240,7,6,24,244,2,240,12,5,24,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,3,240,7,6,24,244,2
	db 240,12,5,24,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,3,240,7,6,24,244,2,240,12,5,24,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,3,240,7,6,24,244,2
	db 240,12,5,24,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,3,240,7,6,24,244,2,240,12,5,24,244,3,240,7
	db 6,6,6,6,6,12,6,6,6,6,6,12,244,1,240,5
	db 3,12,244,3,240,7,6,12,6,6,6,6,6,12,244,1
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
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,12,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,3,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,12
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,3,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,3,240,7,6,6,6,6,6,12,6,6,6,6
	db 6,12,244,1,240,5,3,12,244,3,240,7,6,12,6,6
	db 6,6,6,12,244,1,240,5,3,12,244,2,240,12,5,12
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
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,3,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,3,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,3,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,3,240,7,6,6,6,6
	db 6,12,6,6,6,6,6,12,244,1,240,5,3,12,244,3
	db 240,7,6,12,6,6,6,6,6,12,244,1,240,5,3,12
	db 244,2,240,11,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,6,5,6,244,1,240,5,3,12,244,2,240,11,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,6,5,6,244,1,240,5,3,12,244,2,240,11
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,244,2,240,11,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,6,5,6,244,1,240,5,3,12,244,2
	db 240,11,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,11,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,6,5,6,244,1,240,5,3,12
	db 244,2,240,11,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,244,2,240,11,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,6,5,6,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,11,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,6,5,6,244,1
	db 240,5,3,12,244,2,240,11,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,11
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,6,5,6
	db 244,1,240,5,3,12,244,2,240,11,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,3,240,7,6,6,6,6
	db 6,12,6,6,6,6,6,12,244,1,240,5,3,12,244,3
	db 240,7,6,12,6,6,6,6,6,12,244,1,240,5,3,12
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
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,12,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,3,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,12
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,3,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,244,2,240,12,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 3,12,244,3,240,7,6,12,244,2,240,12,5,12,244,3
	db 240,7,6,6,6,6,6,12,6,6,6,6,6,12,244,1
	db 240,5,3,12,244,3,240,7,6,12,6,6,6,6,6,12
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
	db 6,6,6,6,6,12,244,1,240,5,3,24,244,2,240,12
	db 5,24,244,3,240,7,6,24,244,2,240,12,5,24,244,1
	db 240,5,3,24,244,2,240,12,5,24,244,3,240,7,6,24
	db 244,2,240,12,5,24,244,1,240,5,3,24,244,2,240,12
	db 5,24,244,3,240,7,6,24,244,2,240,12,5,24,244,3
	db 240,7,6,6,6,6,6,12,6,6,6,6,6,12,244,1
	db 240,5,3,12,244,3,240,7,6,12,6,6,6,6,6,12
	db 0
_song1_v0__9:
	db 244,10,240,5,255,96,255,96,255,96,255,48,34,12,38,12
	db 41,12,44,12,244,10,240,5,39,12,255,12,39,12,42,12
	db 46,12,44,12,42,12,41,12,42,24,39,12,35,36,255,24
	db 37,12,255,12,37,12,42,12,46,12,44,12,42,12,44,12
	db 41,24,37,12,32,36,255,24,39,12,255,12,39,12,42,12
	db 46,12,49,12,46,12,42,12,47,24,46,12,42,36,39,24
	db 44,12,42,12,41,12,37,12,41,12,42,12,44,24,41,48
	db 38,48,244,10,240,5,39,12,255,12,39,12,42,12,46,12
	db 44,12,42,12,41,12,42,24,39,12,35,36,255,24,37,12
	db 255,12,37,12,42,12,46,12,44,12,42,12,44,12,41,24
	db 37,12,32,36,255,24,39,12,255,12,39,12,42,12,46,12
	db 49,12,46,12,42,12,47,24,46,12,42,36,39,24,49,12
	db 47,12,46,12,44,12,41,12,37,12,41,12,44,12,46,24
	db 44,24,41,24,38,24,244,10,240,5,35,12,39,12,44,12
	db 39,12,47,24,46,24,46,12,42,12,39,12,42,12,46,24
	db 255,24,35,12,39,12,42,12,47,12,46,12,42,12,39,24
	db 41,12,44,12,49,24,47,12,44,12,41,24,44,24,47,24
	db 51,24,47,24,46,24,51,24,46,24,42,24,44,24,47,24
	db 51,24,47,24,50,24,46,24,41,24,38,24,244,11,240,4
	db 42,18,42,18,39,12,42,24,47,24,46,18,44,18,41,12
	db 37,24,44,24,42,18,41,18,39,12,46,48,255,24,39,12
	db 41,12,42,12,44,12,46,24,47,18,46,18,42,12,39,24
	db 47,24,49,18,47,18,44,12,41,24,49,24,46,24,49,24
	db 42,24,46,24,44,24,41,24,38,24,41,24,244,11,240,4
	db 42,18,42,18,39,12,42,24,47,24,46,18,44,18,41,12
	db 37,24,44,24,42,18,41,18,39,12,46,48,255,24,39,12
	db 41,12,42,12,44,12,46,24,47,18,46,18,42,12,39,24
	db 47,24,49,18,47,18,44,12,41,24,49,24,46,12,47,12
	db 49,12,46,12,42,24,37,24,38,24,41,24,46,48,244,4
	db 240,5,30,18,30,18,27,12,30,24,35,24,34,18,32,18
	db 29,12,25,24,32,24,30,18,29,18,27,12,34,48,255,24
	db 27,12,29,12,30,12,32,12,34,24,42,18,42,18,39,12
	db 42,24,47,24,46,18,44,18,41,12,37,24,44,24,42,18
	db 41,18,39,12,46,48,255,24,39,12,41,12,42,12,44,12
	db 46,24,244,10,240,5,39,12,255,12,39,12,42,12,46,12
	db 44,12,42,12,41,12,42,24,39,12,35,36,255,24,37,12
	db 255,12,37,12,42,12,46,12,44,12,42,12,44,12,41,24
	db 37,12,32,36,255,24,39,12,255,12,39,12,42,12,46,12
	db 49,12,46,12,42,12,47,24,46,12,42,36,39,24,44,12
	db 42,12,41,12,37,12,41,12,42,12,44,24,41,48,38,48
	db 244,10,240,5,35,12,39,12,44,12,39,12,47,24,46,24
	db 46,12,42,12,39,12,42,12,46,24,255,24,35,12,39,12
	db 42,12,47,12,46,12,42,12,39,24,41,12,44,12,49,24
	db 47,12,44,12,41,24,44,24,47,24,51,24,47,24,46,24
	db 51,24,46,24,42,24,44,24,47,24,51,24,47,24,50,24
	db 46,24,41,24,38,24,244,11,240,4,42,18,42,18,39,12
	db 42,24,47,24,46,18,44,18,41,12,37,24,44,24,42,18
	db 41,18,39,12,46,48,255,24,39,12,41,12,42,12,44,12
	db 46,24,47,18,46,18,42,12,39,24,47,24,49,18,47,18
	db 44,12,41,24,49,24,46,24,49,24,42,24,46,24,44,24
	db 41,24,38,24,41,24,244,11,240,4,42,18,42,18,39,12
	db 42,24,47,24,46,18,44,18,41,12,37,24,44,24,42,18
	db 41,18,39,12,46,48,255,24,39,12,41,12,42,12,44,12
	db 46,24,47,18,46,18,42,12,39,24,47,24,49,18,47,18
	db 44,12,41,24,49,24,46,12,47,12,49,12,46,12,42,24
	db 37,24,38,24,41,24,46,48,244,10,240,5,39,48,44,48
	db 41,48,46,48,42,24,47,24,51,48,49,36,47,12,44,48
	db 47,36,46,12,44,48,46,36,44,12,41,48,42,24,39,24
	db 35,24,39,24,41,24,38,24,34,48,244,4,240,5,27,6
	db 30,6,35,6,39,6,27,6,30,6,35,6,39,6,27,6
	db 30,6,35,6,39,6,27,6,30,6,35,6,39,6,41,12
	db 37,12,32,12,29,12,32,12,37,12,41,24,27,18,34,18
	db 39,12,34,24,30,24,27,6,30,6,34,6,39,6,42,6
	db 46,6,42,6,39,6,34,48,35,12,39,12,255,12,39,12
	db 42,12,39,12,35,24,44,36,41,12,37,24,29,24,30,6
	db 34,6,37,6,42,6,30,6,34,6,37,6,42,6,30,6
	db 34,6,37,6,42,6,30,6,34,6,37,6,42,6,38,12
	db 34,12,29,12,26,12,29,12,34,12,38,24,244,4,240,5
	db 27,6,30,6,34,6,39,6,42,6,46,6,42,6,39,6
	db 34,48,35,12,39,12,255,12,39,12,42,12,39,12,35,24
	db 46,36,42,12,37,24,30,24,29,6,32,6,37,6,41,6
	db 29,6,32,6,37,6,41,6,29,6,32,6,37,6,41,6
	db 29,6,32,6,37,6,41,6,39,12,34,12,30,12,27,12
	db 30,12,34,12,39,24,27,18,35,18,39,12,35,24,30,24
	db 29,6,32,6,37,6,41,6,44,6,49,6,44,6,41,6
	db 37,48,34,12,38,12,255,12,38,12,41,12,38,12,34,24
	db 244,10,240,5,35,12,39,12,44,12,39,12,47,24,46,24
	db 46,12,42,12,39,12,42,12,46,24,255,24,35,12,39,12
	db 42,12,47,12,46,12,42,12,39,24,41,12,44,12,49,24
	db 47,12,44,12,41,24,44,24,47,24,51,24,47,24,46,24
	db 51,24,46,24,42,24,44,24,47,24,51,24,47,24,50,24
	db 46,24,41,24,38,24,244,11,240,4,42,18,42,18,39,12
	db 42,24,47,24,46,18,44,18,41,12,37,24,44,24,42,18
	db 41,18,39,12,46,48,255,24,39,12,41,12,42,12,44,12
	db 46,24,47,18,46,18,42,12,39,24,47,24,49,18,47,18
	db 44,12,41,24,49,24,46,24,49,24,42,24,46,24,44,24
	db 41,24,38,24,41,24,244,11,240,4,42,18,42,18,39,12
	db 42,24,47,24,46,18,44,18,41,12,37,24,44,24,42,18
	db 41,18,39,12,46,48,255,24,39,12,41,12,42,12,44,12
	db 46,24,47,18,46,18,42,12,39,24,47,24,49,18,47,18
	db 44,12,41,24,49,24,46,12,47,12,49,12,46,12,42,24
	db 37,24,38,24,41,24,46,48,244,10,240,5,39,96,42,96
	db 44,96,41,48,255,48,0
_song1_v1__9:
	db 244,6,240,6,12,12,12,12,12,12,12,12,12,12,19,12
	db 24,12,12,12,8,12,8,12,8,12,8,12,8,12,15,12
	db 20,12,8,12,10,12,10,12,10,12,10,12,10,12,17,12
	db 22,12,10,12,7,12,7,12,7,12,7,12,7,12,14,12
	db 19,12,7,12,244,6,240,6,12,12,12,12,12,12,12,12
	db 12,12,19,12,24,12,12,12,8,12,8,12,8,12,8,12
	db 8,12,15,12,20,12,8,12,3,12,3,12,3,12,3,12
	db 3,12,10,12,15,12,3,12,10,12,10,12,10,12,10,12
	db 10,12,17,12,22,12,10,12,12,12,12,12,12,12,12,12
	db 12,12,19,12,24,12,12,12,8,12,8,12,8,12,8,12
	db 8,12,15,12,20,12,8,12,10,12,10,12,10,12,10,12
	db 10,12,17,12,22,12,10,12,7,12,7,12,7,12,7,12
	db 7,12,14,12,19,12,7,12,244,6,240,6,12,12,12,12
	db 12,12,12,12,12,12,19,12,24,12,12,12,8,12,8,12
	db 8,12,8,12,8,12,15,12,20,12,8,12,3,12,3,12
	db 3,12,3,12,3,12,10,12,15,12,3,12,10,12,10,12
	db 10,12,10,12,10,12,17,12,22,12,10,12,12,12,12,12
	db 12,12,12,12,12,12,19,12,24,12,12,12,8,12,8,12
	db 8,12,8,12,8,12,15,12,20,12,8,12,10,12,10,12
	db 10,12,10,12,10,12,17,12,22,12,10,12,7,12,7,12
	db 7,12,7,12,7,12,14,12,19,12,7,12,244,6,240,6
	db 5,12,17,12,5,12,17,12,5,12,17,12,5,12,17,12
	db 12,12,24,12,12,12,24,12,12,12,24,12,12,12,24,12
	db 8,12,20,12,8,12,20,12,8,12,20,12,8,12,20,12
	db 10,12,22,12,10,12,22,12,10,12,22,12,10,12,22,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,5,12,17,12
	db 12,12,24,12,12,12,24,12,12,12,24,12,12,12,24,12
	db 1,12,13,12,1,12,13,12,1,12,13,12,1,12,13,12
	db 7,12,19,12,7,12,19,12,7,12,19,12,7,12,19,12
	db 244,6,240,6,8,12,8,6,8,6,15,12,8,6,8,6
	db 20,12,8,6,8,6,15,12,8,12,10,12,10,6,10,6
	db 17,12,10,6,10,6,22,12,10,6,10,6,17,12,10,12
	db 12,12,12,6,12,6,19,12,12,6,12,6,24,12,12,6
	db 12,6,19,12,12,12,12,12,12,6,12,6,19,12,12,6
	db 12,6,24,12,12,6,12,6,19,12,12,12,8,12,8,6
	db 8,6,15,12,8,6,8,6,20,12,8,6,8,6,15,12
	db 8,12,10,12,10,6,10,6,17,12,10,6,10,6,22,12
	db 10,6,10,6,17,12,10,12,3,12,3,6,3,6,10,12
	db 3,6,3,6,15,12,3,6,3,6,10,12,3,12,7,12
	db 7,6,7,6,14,12,7,6,7,6,19,12,7,6,7,6
	db 14,12,7,12,244,6,240,6,8,12,8,6,8,6,15,12
	db 8,6,8,6,20,12,8,6,8,6,15,12,8,12,10,12
	db 10,6,10,6,17,12,10,6,10,6,22,12,10,6,10,6
	db 17,12,10,12,12,12,12,6,12,6,19,12,12,6,12,6
	db 24,12,12,6,12,6,19,12,12,12,12,12,12,6,12,6
	db 19,12,12,6,12,6,24,12,12,6,12,6,19,12,12,12
	db 8,12,8,6,8,6,15,12,8,6,8,6,20,12,8,6
	db 8,6,15,12,8,12,10,12,10,6,10,6,17,12,10,6
	db 10,6,22,12,10,6,10,6,17,12,10,12,3,12,3,6
	db 3,6,10,12,3,6,3,6,15,12,3,6,3,6,10,12
	db 3,12,7,12,7,6,7,6,14,12,7,6,7,6,19,12
	db 7,6,7,6,14,12,7,12,244,6,240,6,8,12,8,6
	db 8,6,15,12,8,6,8,6,20,12,8,6,8,6,15,12
	db 8,12,10,12,10,6,10,6,17,12,10,6,10,6,22,12
	db 10,6,10,6,17,12,10,12,12,12,12,6,12,6,19,12
	db 12,6,12,6,24,12,12,6,12,6,19,12,12,12,12,12
	db 12,6,12,6,19,12,12,6,12,6,24,12,12,6,12,6
	db 19,12,12,12,8,12,8,6,8,6,15,12,8,6,8,6
	db 20,12,8,6,8,6,15,12,8,12,10,12,10,6,10,6
	db 17,12,10,6,10,6,22,12,10,6,10,6,17,12,10,12
	db 3,12,3,6,3,6,10,12,3,6,3,6,15,12,3,6
	db 3,6,10,12,3,12,7,12,7,6,7,6,14,12,7,6
	db 7,6,19,12,7,6,7,6,14,12,7,12,244,6,240,6
	db 12,12,12,12,12,12,12,12,12,12,19,12,24,12,12,12
	db 8,12,8,12,8,12,8,12,8,12,15,12,20,12,8,12
	db 3,12,3,12,3,12,3,12,3,12,10,12,15,12,3,12
	db 10,12,10,12,10,12,10,12,10,12,17,12,22,12,10,12
	db 12,12,12,12,12,12,12,12,12,12,19,12,24,12,12,12
	db 8,12,8,12,8,12,8,12,8,12,15,12,20,12,8,12
	db 10,12,10,12,10,12,10,12,10,12,17,12,22,12,10,12
	db 7,12,7,12,7,12,7,12,7,12,14,12,19,12,7,12
	db 244,6,240,6,5,12,17,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,12,12,24,12,12,12,24,12,12,12,24,12
	db 12,12,24,12,8,12,20,12,8,12,20,12,8,12,20,12
	db 8,12,20,12,10,12,22,12,10,12,22,12,10,12,22,12
	db 10,12,22,12,5,12,17,12,5,12,17,12,5,12,17,12
	db 5,12,17,12,12,12,24,12,12,12,24,12,12,12,24,12
	db 12,12,24,12,1,12,13,12,1,12,13,12,1,12,13,12
	db 1,12,13,12,7,12,19,12,7,12,19,12,7,12,19,12
	db 7,12,19,12,244,6,240,6,8,12,8,6,8,6,15,12
	db 8,6,8,6,20,12,8,6,8,6,15,12,8,12,10,12
	db 10,6,10,6,17,12,10,6,10,6,22,12,10,6,10,6
	db 17,12,10,12,12,12,12,6,12,6,19,12,12,6,12,6
	db 24,12,12,6,12,6,19,12,12,12,12,12,12,6,12,6
	db 19,12,12,6,12,6,24,12,12,6,12,6,19,12,12,12
	db 8,12,8,6,8,6,15,12,8,6,8,6,20,12,8,6
	db 8,6,15,12,8,12,10,12,10,6,10,6,17,12,10,6
	db 10,6,22,12,10,6,10,6,17,12,10,12,3,12,3,6
	db 3,6,10,12,3,6,3,6,15,12,3,6,3,6,10,12
	db 3,12,7,12,7,6,7,6,14,12,7,6,7,6,19,12
	db 7,6,7,6,14,12,7,12,244,6,240,6,8,12,8,6
	db 8,6,15,12,8,6,8,6,20,12,8,6,8,6,15,12
	db 8,12,10,12,10,6,10,6,17,12,10,6,10,6,22,12
	db 10,6,10,6,17,12,10,12,12,12,12,6,12,6,19,12
	db 12,6,12,6,24,12,12,6,12,6,19,12,12,12,12,12
	db 12,6,12,6,19,12,12,6,12,6,24,12,12,6,12,6
	db 19,12,12,12,8,12,8,6,8,6,15,12,8,6,8,6
	db 20,12,8,6,8,6,15,12,8,12,10,12,10,6,10,6
	db 17,12,10,6,10,6,22,12,10,6,10,6,17,12,10,12
	db 3,12,3,6,3,6,10,12,3,6,3,6,15,12,3,6
	db 3,6,10,12,3,12,7,12,7,6,7,6,14,12,7,6
	db 7,6,19,12,7,6,7,6,14,12,7,12,244,6,240,6
	db 5,24,8,24,12,24,17,24,7,24,10,24,14,24,19,24
	db 8,24,12,24,15,24,20,24,10,24,14,24,17,24,22,24
	db 5,24,8,24,12,24,17,24,7,24,10,24,14,24,19,24
	db 8,24,12,24,15,24,20,24,7,24,11,24,14,24,19,24
	db 244,6,240,6,8,12,8,6,8,6,15,12,8,6,8,6
	db 20,12,8,6,8,6,15,12,8,12,10,12,10,6,10,6
	db 17,12,10,6,10,6,22,12,10,6,10,6,17,12,10,12
	db 12,12,12,6,12,6,19,12,12,6,12,6,24,12,12,6
	db 12,6,19,12,12,12,12,12,12,6,12,6,19,12,12,6
	db 12,6,24,12,12,6,12,6,19,12,12,12,8,12,8,6
	db 8,6,15,12,8,6,8,6,20,12,8,6,8,6,15,12
	db 8,12,10,12,10,6,10,6,17,12,10,6,10,6,22,12
	db 10,6,10,6,17,12,10,12,3,12,3,6,3,6,10,12
	db 3,6,3,6,15,12,3,6,3,6,10,12,3,12,7,12
	db 7,6,7,6,14,12,7,6,7,6,19,12,7,6,7,6
	db 14,12,7,12,244,6,240,6,12,12,12,12,12,12,12,12
	db 12,12,19,12,24,12,12,12,8,12,8,12,8,12,8,12
	db 8,12,15,12,20,12,8,12,3,12,3,12,3,12,3,12
	db 3,12,10,12,15,12,3,12,10,12,10,12,10,12,10,12
	db 10,12,17,12,22,12,10,12,12,12,12,12,12,12,12,12
	db 12,12,19,12,24,12,12,12,8,12,8,12,8,12,8,12
	db 8,12,15,12,20,12,8,12,10,12,10,12,10,12,10,12
	db 10,12,17,12,22,12,10,12,7,12,7,12,7,12,7,12
	db 7,12,14,12,19,12,7,12,244,6,240,6,5,12,17,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,12,12,24,12
	db 12,12,24,12,12,12,24,12,12,12,24,12,8,12,20,12
	db 8,12,20,12,8,12,20,12,8,12,20,12,10,12,22,12
	db 10,12,22,12,10,12,22,12,10,12,22,12,5,12,17,12
	db 5,12,17,12,5,12,17,12,5,12,17,12,12,12,24,12
	db 12,12,24,12,12,12,24,12,12,12,24,12,1,12,13,12
	db 1,12,13,12,1,12,13,12,1,12,13,12,7,12,19,12
	db 7,12,19,12,7,12,19,12,7,12,19,12,244,6,240,6
	db 8,12,8,6,8,6,15,12,8,6,8,6,20,12,8,6
	db 8,6,15,12,8,12,10,12,10,6,10,6,17,12,10,6
	db 10,6,22,12,10,6,10,6,17,12,10,12,12,12,12,6
	db 12,6,19,12,12,6,12,6,24,12,12,6,12,6,19,12
	db 12,12,12,12,12,6,12,6,19,12,12,6,12,6,24,12
	db 12,6,12,6,19,12,12,12,8,12,8,6,8,6,15,12
	db 8,6,8,6,20,12,8,6,8,6,15,12,8,12,10,12
	db 10,6,10,6,17,12,10,6,10,6,22,12,10,6,10,6
	db 17,12,10,12,3,12,3,6,3,6,10,12,3,6,3,6
	db 15,12,3,6,3,6,10,12,3,12,7,12,7,6,7,6
	db 14,12,7,6,7,6,19,12,7,6,7,6,14,12,7,12
	db 244,6,240,6,8,12,8,6,8,6,15,12,8,6,8,6
	db 20,12,8,6,8,6,15,12,8,12,10,12,10,6,10,6
	db 17,12,10,6,10,6,22,12,10,6,10,6,17,12,10,12
	db 12,12,12,6,12,6,19,12,12,6,12,6,24,12,12,6
	db 12,6,19,12,12,12,12,12,12,6,12,6,19,12,12,6
	db 12,6,24,12,12,6,12,6,19,12,12,12,8,12,8,6
	db 8,6,15,12,8,6,8,6,20,12,8,6,8,6,15,12
	db 8,12,10,12,10,6,10,6,17,12,10,6,10,6,22,12
	db 10,6,10,6,17,12,10,12,3,12,3,6,3,6,10,12
	db 3,6,3,6,15,12,3,6,3,6,10,12,3,12,7,12
	db 7,6,7,6,14,12,7,6,7,6,19,12,7,6,7,6
	db 14,12,7,12,244,6,240,6,12,24,15,24,19,24,24,24
	db 8,24,12,24,15,24,20,24,10,24,14,24,17,24,22,24
	db 7,24,11,24,14,24,19,24,0
_song1_v2__9:
	db 244,6,240,8,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,34,6
	db 30,6,27,6,23,6,27,6,30,6,23,6,30,6,27,6
	db 23,6,27,6,30,6,23,6,30,6,27,6,23,6,30,6
	db 27,6,23,6,25,6,29,6,32,6,25,6,32,6,29,6
	db 25,6,29,6,32,6,25,6,32,6,29,6,25,6,32,6
	db 29,6,25,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,29,6
	db 26,6,22,6,244,6,240,8,255,12,30,12,255,12,34,12
	db 255,12,30,6,27,6,255,12,34,12,255,12,27,12,255,12
	db 30,12,255,12,27,6,23,6,255,12,30,12,255,12,22,12
	db 255,12,25,12,255,12,22,6,18,6,255,12,25,12,255,12
	db 29,12,255,12,32,12,255,12,29,6,25,6,255,12,32,12
	db 255,12,30,12,255,12,34,12,255,12,30,6,27,6,255,12
	db 34,12,255,12,27,12,255,12,30,12,255,12,27,6,23,6
	db 255,12,30,12,255,12,29,12,255,12,32,12,255,12,29,6
	db 25,6,255,12,32,12,255,12,26,12,255,12,29,12,255,12
	db 26,6,22,6,255,12,29,12,244,6,240,8,255,12,30,12
	db 255,12,34,12,255,12,30,6,27,6,255,12,34,12,255,12
	db 27,12,255,12,30,12,255,12,27,6,23,6,255,12,30,12
	db 255,12,22,12,255,12,25,12,255,12,22,6,18,6,255,12
	db 25,12,255,12,29,12,255,12,32,12,255,12,29,6,25,6
	db 255,12,32,12,255,12,30,12,255,12,34,12,255,12,30,6
	db 27,6,255,12,34,12,255,12,27,12,255,12,30,12,255,12
	db 27,6,23,6,255,12,30,12,255,12,29,12,255,12,32,12
	db 255,12,29,6,25,6,255,12,32,12,255,12,26,12,255,12
	db 29,12,255,12,26,6,22,6,255,12,29,12,244,6,240,8
	db 20,6,23,6,27,6,20,6,27,6,23,6,20,6,23,6
	db 27,6,20,6,27,6,23,6,20,6,27,6,23,6,20,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,30,6
	db 34,6,27,6,34,6,30,6,27,6,34,6,30,6,27,6
	db 23,6,27,6,30,6,23,6,30,6,27,6,23,6,27,6
	db 30,6,23,6,30,6,27,6,23,6,30,6,27,6,23,6
	db 25,6,29,6,32,6,25,6,32,6,29,6,25,6,29,6
	db 32,6,25,6,32,6,29,6,25,6,32,6,29,6,25,6
	db 20,6,23,6,27,6,20,6,27,6,23,6,20,6,23,6
	db 27,6,20,6,27,6,23,6,20,6,27,6,23,6,20,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,30,6
	db 34,6,27,6,34,6,30,6,27,6,34,6,30,6,27,6
	db 28,6,32,6,35,6,39,6,35,6,32,6,28,6,32,6
	db 35,6,39,6,35,6,32,6,28,6,35,6,32,6,39,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,26,6
	db 29,6,22,6,29,6,26,6,22,6,29,6,26,6,22,6
	db 244,6,240,8,23,6,27,6,30,6,23,6,30,6,27,6
	db 23,6,27,6,30,6,23,6,30,6,27,6,23,6,30,6
	db 27,6,23,6,25,6,29,6,32,6,25,6,32,6,29,6
	db 25,6,29,6,32,6,25,6,32,6,29,6,25,6,32,6
	db 29,6,25,6,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,34,6
	db 30,6,27,6,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,34,6
	db 30,6,27,6,23,6,27,6,30,6,23,6,30,6,27,6
	db 23,6,27,6,30,6,23,6,30,6,27,6,23,6,30,6
	db 27,6,23,6,25,6,29,6,32,6,25,6,32,6,29,6
	db 25,6,29,6,32,6,25,6,32,6,29,6,25,6,32,6
	db 29,6,25,6,18,6,22,6,25,6,18,6,25,6,22,6
	db 18,6,22,6,25,6,18,6,25,6,22,6,18,6,25,6
	db 22,6,18,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,29,6
	db 26,6,22,6,244,6,240,8,23,6,27,6,30,6,23,6
	db 30,6,27,6,23,6,27,6,30,6,23,6,30,6,27,6
	db 23,6,30,6,27,6,23,6,25,6,29,6,32,6,25,6
	db 32,6,29,6,25,6,29,6,32,6,25,6,32,6,29,6
	db 25,6,32,6,29,6,25,6,27,6,30,6,34,6,27,6
	db 34,6,30,6,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,34,6,30,6,27,6,27,6,30,6,34,6,27,6
	db 34,6,30,6,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,34,6,30,6,27,6,23,6,27,6,30,6,23,6
	db 30,6,27,6,23,6,27,6,30,6,23,6,30,6,27,6
	db 23,6,30,6,27,6,23,6,25,6,29,6,32,6,25,6
	db 32,6,29,6,25,6,29,6,32,6,25,6,32,6,29,6
	db 25,6,32,6,29,6,25,6,18,6,22,6,25,6,18,6
	db 25,6,22,6,18,6,22,6,25,6,18,6,25,6,22,6
	db 18,6,25,6,22,6,18,6,22,6,26,6,29,6,22,6
	db 29,6,26,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,29,6,26,6,22,6,244,6,240,8,255,12,27,12
	db 255,12,30,12,255,12,27,6,23,6,255,12,30,12,255,12
	db 29,12,255,12,32,12,255,12,29,6,25,6,255,12,32,12
	db 255,12,30,12,255,12,34,12,255,12,30,6,27,6,255,12
	db 34,12,255,12,30,12,255,12,34,12,255,12,30,6,27,6
	db 255,12,34,12,255,12,27,12,255,12,30,12,255,12,27,6
	db 23,6,255,12,30,12,255,12,29,12,255,12,32,12,255,12
	db 29,6,25,6,255,12,32,12,255,12,22,12,255,12,25,12
	db 255,12,22,6,18,6,255,12,25,12,255,12,26,12,255,12
	db 29,12,255,12,26,6,22,6,255,12,29,12,244,6,240,8
	db 255,12,30,12,255,12,34,12,255,12,30,6,27,6,255,12
	db 34,12,255,12,27,12,255,12,30,12,255,12,27,6,23,6
	db 255,12,30,12,255,12,22,12,255,12,25,12,255,12,22,6
	db 18,6,255,12,25,12,255,12,29,12,255,12,32,12,255,12
	db 29,6,25,6,255,12,32,12,255,12,30,12,255,12,34,12
	db 255,12,30,6,27,6,255,12,34,12,255,12,27,12,255,12
	db 30,12,255,12,27,6,23,6,255,12,30,12,255,12,29,12
	db 255,12,32,12,255,12,29,6,25,6,255,12,32,12,255,12
	db 26,12,255,12,29,12,255,12,26,6,22,6,255,12,29,12
	db 244,6,240,8,20,6,23,6,27,6,20,6,27,6,23,6
	db 20,6,23,6,27,6,20,6,27,6,23,6,20,6,27,6
	db 23,6,20,6,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,34,6
	db 30,6,27,6,23,6,27,6,30,6,23,6,30,6,27,6
	db 23,6,27,6,30,6,23,6,30,6,27,6,23,6,30,6
	db 27,6,23,6,25,6,29,6,32,6,25,6,32,6,29,6
	db 25,6,29,6,32,6,25,6,32,6,29,6,25,6,32,6
	db 29,6,25,6,20,6,23,6,27,6,20,6,27,6,23,6
	db 20,6,23,6,27,6,20,6,27,6,23,6,20,6,27,6
	db 23,6,20,6,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,34,6
	db 30,6,27,6,28,6,32,6,35,6,39,6,35,6,32,6
	db 28,6,32,6,35,6,39,6,35,6,32,6,28,6,35,6
	db 32,6,39,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,29,6
	db 26,6,22,6,244,6,240,8,23,6,27,6,30,6,23,6
	db 30,6,27,6,23,6,27,6,30,6,23,6,30,6,27,6
	db 23,6,30,6,27,6,23,6,25,6,29,6,32,6,25,6
	db 32,6,29,6,25,6,29,6,32,6,25,6,32,6,29,6
	db 25,6,32,6,29,6,25,6,27,6,30,6,34,6,27,6
	db 34,6,30,6,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,34,6,30,6,27,6,27,6,30,6,34,6,27,6
	db 34,6,30,6,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,34,6,30,6,27,6,23,6,27,6,30,6,23,6
	db 30,6,27,6,23,6,27,6,30,6,23,6,30,6,27,6
	db 23,6,30,6,27,6,23,6,25,6,29,6,32,6,25,6
	db 32,6,29,6,25,6,29,6,32,6,25,6,32,6,29,6
	db 25,6,32,6,29,6,25,6,18,6,22,6,25,6,18,6
	db 25,6,22,6,18,6,22,6,25,6,18,6,25,6,22,6
	db 18,6,25,6,22,6,18,6,22,6,26,6,29,6,22,6
	db 29,6,26,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,29,6,26,6,22,6,244,6,240,8,23,6,27,6
	db 30,6,23,6,30,6,27,6,23,6,27,6,30,6,23,6
	db 30,6,27,6,23,6,30,6,27,6,23,6,25,6,29,6
	db 32,6,25,6,32,6,29,6,25,6,29,6,32,6,25,6
	db 32,6,29,6,25,6,32,6,29,6,25,6,27,6,30,6
	db 34,6,27,6,34,6,30,6,27,6,30,6,34,6,27,6
	db 34,6,30,6,27,6,34,6,30,6,27,6,27,6,30,6
	db 34,6,27,6,34,6,30,6,27,6,30,6,34,6,27,6
	db 34,6,30,6,27,6,34,6,30,6,27,6,23,6,27,6
	db 30,6,23,6,30,6,27,6,23,6,27,6,30,6,23,6
	db 30,6,27,6,23,6,30,6,27,6,23,6,25,6,29,6
	db 32,6,25,6,32,6,29,6,25,6,29,6,32,6,25,6
	db 32,6,29,6,25,6,32,6,29,6,25,6,18,6,22,6
	db 25,6,18,6,25,6,22,6,18,6,22,6,25,6,18,6
	db 25,6,22,6,18,6,25,6,22,6,18,6,22,6,26,6
	db 29,6,22,6,29,6,26,6,22,6,26,6,29,6,22,6
	db 29,6,26,6,22,6,29,6,26,6,22,6,244,6,240,8
	db 23,48,27,48,25,48,29,48,27,48,30,48,29,48,32,48
	db 23,48,27,48,25,48,29,48,27,48,30,48,26,48,29,48
	db 244,6,240,8,255,12,27,12,255,12,30,12,255,12,27,6
	db 23,6,255,12,30,12,255,12,29,12,255,12,32,12,255,12
	db 29,6,25,6,255,12,32,12,255,12,30,12,255,12,34,12
	db 255,12,30,6,27,6,255,12,34,12,255,12,30,12,255,12
	db 34,12,255,12,30,6,27,6,255,12,34,12,255,12,27,12
	db 255,12,30,12,255,12,27,6,23,6,255,12,30,12,255,12
	db 29,12,255,12,32,12,255,12,29,6,25,6,255,12,32,12
	db 255,12,22,12,255,12,25,12,255,12,22,6,18,6,255,12
	db 25,12,255,12,26,12,255,12,29,12,255,12,26,6,22,6
	db 255,12,29,12,244,6,240,8,255,12,30,12,255,12,34,12
	db 255,12,30,6,27,6,255,12,34,12,255,12,27,12,255,12
	db 30,12,255,12,27,6,23,6,255,12,30,12,255,12,22,12
	db 255,12,25,12,255,12,22,6,18,6,255,12,25,12,255,12
	db 29,12,255,12,32,12,255,12,29,6,25,6,255,12,32,12
	db 255,12,30,12,255,12,34,12,255,12,30,6,27,6,255,12
	db 34,12,255,12,27,12,255,12,30,12,255,12,27,6,23,6
	db 255,12,30,12,255,12,29,12,255,12,32,12,255,12,29,6
	db 25,6,255,12,32,12,255,12,26,12,255,12,29,12,255,12
	db 26,6,22,6,255,12,29,12,244,6,240,8,20,6,23,6
	db 27,6,20,6,27,6,23,6,20,6,23,6,27,6,20,6
	db 27,6,23,6,20,6,27,6,23,6,20,6,27,6,30,6
	db 34,6,27,6,34,6,30,6,27,6,30,6,34,6,27,6
	db 34,6,30,6,27,6,34,6,30,6,27,6,23,6,27,6
	db 30,6,23,6,30,6,27,6,23,6,27,6,30,6,23,6
	db 30,6,27,6,23,6,30,6,27,6,23,6,25,6,29,6
	db 32,6,25,6,32,6,29,6,25,6,29,6,32,6,25,6
	db 32,6,29,6,25,6,32,6,29,6,25,6,20,6,23,6
	db 27,6,20,6,27,6,23,6,20,6,23,6,27,6,20,6
	db 27,6,23,6,20,6,27,6,23,6,20,6,27,6,30,6
	db 34,6,27,6,34,6,30,6,27,6,30,6,34,6,27,6
	db 34,6,30,6,27,6,34,6,30,6,27,6,28,6,32,6
	db 35,6,39,6,35,6,32,6,28,6,32,6,35,6,39,6
	db 35,6,32,6,28,6,35,6,32,6,39,6,22,6,26,6
	db 29,6,22,6,29,6,26,6,22,6,26,6,29,6,22,6
	db 29,6,26,6,22,6,29,6,26,6,22,6,244,6,240,8
	db 23,6,27,6,30,6,23,6,30,6,27,6,23,6,27,6
	db 30,6,23,6,30,6,27,6,23,6,30,6,27,6,23,6
	db 25,6,29,6,32,6,25,6,32,6,29,6,25,6,29,6
	db 32,6,25,6,32,6,29,6,25,6,32,6,29,6,25,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,30,6
	db 34,6,27,6,34,6,30,6,27,6,34,6,30,6,27,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,30,6
	db 34,6,27,6,34,6,30,6,27,6,34,6,30,6,27,6
	db 23,6,27,6,30,6,23,6,30,6,27,6,23,6,27,6
	db 30,6,23,6,30,6,27,6,23,6,30,6,27,6,23,6
	db 25,6,29,6,32,6,25,6,32,6,29,6,25,6,29,6
	db 32,6,25,6,32,6,29,6,25,6,32,6,29,6,25,6
	db 18,6,22,6,25,6,18,6,25,6,22,6,18,6,22,6
	db 25,6,18,6,25,6,22,6,18,6,25,6,22,6,18,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,26,6
	db 29,6,22,6,29,6,26,6,22,6,29,6,26,6,22,6
	db 244,6,240,8,23,6,27,6,30,6,23,6,30,6,27,6
	db 23,6,27,6,30,6,23,6,30,6,27,6,23,6,30,6
	db 27,6,23,6,25,6,29,6,32,6,25,6,32,6,29,6
	db 25,6,29,6,32,6,25,6,32,6,29,6,25,6,32,6
	db 29,6,25,6,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,34,6
	db 30,6,27,6,27,6,30,6,34,6,27,6,34,6,30,6
	db 27,6,30,6,34,6,27,6,34,6,30,6,27,6,34,6
	db 30,6,27,6,23,6,27,6,30,6,23,6,30,6,27,6
	db 23,6,27,6,30,6,23,6,30,6,27,6,23,6,30,6
	db 27,6,23,6,25,6,29,6,32,6,25,6,32,6,29,6
	db 25,6,29,6,32,6,25,6,32,6,29,6,25,6,32,6
	db 29,6,25,6,18,6,22,6,25,6,18,6,25,6,22,6
	db 18,6,22,6,25,6,18,6,25,6,22,6,18,6,25,6
	db 22,6,18,6,22,6,26,6,29,6,22,6,29,6,26,6
	db 22,6,26,6,29,6,22,6,29,6,26,6,22,6,29,6
	db 26,6,22,6,244,6,240,8,30,48,34,48,27,48,30,48
	db 29,48,32,48,26,48,29,48,0
_song1_v3__9:
	db 244,1,240,5,3,24,244,2,240,12,5,24,244,3,240,7
	db 6,24,244,2,240,12,5,24,244,1,240,5,3,24,244,2
	db 240,12,5,24,244,3,240,7,6,24,244,2,240,12,5,24
	db 244,1,240,5,3,24,244,2,240,12,5,24,244,3,240,7
	db 6,24,244,2,240,12,5,24,244,3,240,7,6,6,6,6
	db 6,12,6,6,6,6,6,12,244,1,240,5,3,12,244,3
	db 240,7,6,12,6,6,6,6,6,12,244,1,240,5,3,12
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
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,12,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,3,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,12
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,3,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,244,2,240,12,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 3,12,244,3,240,7,6,12,244,2,240,12,5,12,244,3
	db 240,7,6,6,6,6,6,12,6,6,6,6,6,12,244,1
	db 240,5,3,12,244,3,240,7,6,12,6,6,6,6,6,12
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
	db 6,6,6,6,6,12,244,1,240,5,3,12,244,2,240,11
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,6,5,6
	db 244,1,240,5,3,12,244,2,240,11,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,11,5,12,244,3,240,7,6,12,244,2,240,12,5,6
	db 5,6,244,1,240,5,3,12,244,2,240,11,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,11,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,6,5,6,244,1,240,5,3,12,244,2,240,11,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,6,5,6,244,1,240,5,3,12,244,2,240,11
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,244,2,240,11,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,6,5,6,244,1,240,5,3,12,244,2
	db 240,11,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,11,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,6,5,6,244,1,240,5,3,12
	db 244,2,240,11,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,244,2,240,11,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,6,5,6,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
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
	db 244,3,240,7,6,12,6,6,6,6,6,12,244,1,240,5
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
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,3,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,3,240,7,6,6,6,6,6,12,6,6,6,6,6,12
	db 244,1,240,5,3,12,244,3,240,7,6,12,6,6,6,6
	db 6,12,244,1,240,5,3,12,244,2,240,11,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,6,5,6,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,11,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,6,5,6,244,1
	db 240,5,3,12,244,2,240,11,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,11
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,6,5,6
	db 244,1,240,5,3,12,244,2,240,11,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,244,2
	db 240,11,5,12,244,3,240,7,6,12,244,2,240,12,5,6
	db 5,6,244,1,240,5,3,12,244,2,240,11,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,11,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,6,5,6,244,1,240,5,3,12,244,2,240,11,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,6,5,6,244,1,240,5,3,12,244,2,240,11
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,244,2,240,11,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,6,5,6,244,1,240,5,3,12,244,2
	db 240,11,5,12,244,3,240,7,6,12,244,2,240,12,5,12
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
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,12
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
	db 244,2,240,12,5,12,244,3,240,7,6,6,6,6,6,12
	db 6,6,6,6,6,12,244,1,240,5,3,12,244,3,240,7
	db 6,12,6,6,6,6,6,12,244,1,240,5,3,12,244,2
	db 240,11,5,12,244,3,240,7,6,12,244,2,240,12,5,6
	db 5,6,244,1,240,5,3,12,244,2,240,11,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,11,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,6,5,6,244,1,240,5,3,12,244,2,240,11,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,6,5,6,244,1,240,5,3,12,244,2,240,11
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,244,2,240,11,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,6,5,6,244,1,240,5,3,12,244,2
	db 240,11,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,11,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,6,5,6,244,1,240,5,3,12
	db 244,2,240,11,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,244,2,240,11,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,6,5,6,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,11,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,6,5,6,244,1
	db 240,5,3,12,244,2,240,11,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,3,240,7,6,6,6,6,6,12
	db 6,6,6,6,6,12,244,1,240,5,3,12,244,3,240,7
	db 6,12,6,6,6,6,6,12,244,1,240,5,3,12,244,2
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
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,3,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,3,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,3,240,7
	db 6,6,6,6,6,12,6,6,6,6,6,12,244,1,240,5
	db 3,12,244,3,240,7,6,12,6,6,6,6,6,12,244,1
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
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,12,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,3,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,12
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,3,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,3,240,7,6,6,6,6,6,12,6,6,6,6
	db 6,12,244,1,240,5,3,12,244,3,240,7,6,12,6,6
	db 6,6,6,12,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,3,240,7,6,24,244,2,240,12,5,24,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,3,240,7,6,24,244,2
	db 240,12,5,24,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,3,240,7,6,24,244,2,240,12,5,24,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,3,240,7,6,24,244,2
	db 240,12,5,24,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,3,240,7,6,24,244,2,240,12,5,24,244,1,240,5
	db 3,24,244,2,240,12,5,24,244,3,240,7,6,24,244,2
	db 240,12,5,24,244,1,240,5,3,24,244,2,240,12,5,24
	db 244,3,240,7,6,24,244,2,240,12,5,24,244,3,240,7
	db 6,6,6,6,6,12,6,6,6,6,6,12,244,1,240,5
	db 3,12,244,3,240,7,6,12,6,6,6,6,6,12,244,1
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
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,12,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,3,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,12
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,3,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,3,240,7,6,6,6,6,6,12,6,6,6,6
	db 6,12,244,1,240,5,3,12,244,3,240,7,6,12,6,6
	db 6,6,6,12,244,1,240,5,3,12,244,2,240,12,5,12
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
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,12,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,3,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,12,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,1,240,5,3,12,3,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,12,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,3,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,3,240,7,6,6,6,6
	db 6,12,6,6,6,6,6,12,244,1,240,5,3,12,244,3
	db 240,7,6,12,6,6,6,6,6,12,244,1,240,5,3,12
	db 244,2,240,11,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,6,5,6,244,1,240,5,3,12,244,2,240,11,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,12,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,6,5,6,244,1,240,5,3,12,244,2,240,11
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,244,2,240,11,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,6,5,6,244,1,240,5,3,12,244,2
	db 240,11,5,12,244,3,240,7,6,12,244,2,240,12,5,12
	db 244,1,240,5,3,12,244,2,240,11,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,6,5,6,244,1,240,5,3,12
	db 244,2,240,11,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,244,2,240,11,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,6,5,6,244,1,240,5
	db 3,12,244,2,240,11,5,12,244,3,240,7,6,12,244,2
	db 240,12,5,12,244,1,240,5,3,12,244,2,240,11,5,12
	db 244,3,240,7,6,12,244,2,240,12,5,6,5,6,244,1
	db 240,5,3,12,244,2,240,11,5,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,11
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,6,5,6
	db 244,1,240,5,3,12,244,2,240,11,5,12,244,3,240,7
	db 6,12,244,2,240,12,5,12,244,3,240,7,6,6,6,6
	db 6,12,6,6,6,6,6,12,244,1,240,5,3,12,244,3
	db 240,7,6,12,6,6,6,6,6,12,244,1,240,5,3,12
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
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 244,2,240,12,5,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,3,12,244,3,240,7,6,12
	db 244,2,240,12,5,12,244,1,240,5,3,12,244,2,240,12
	db 5,12,244,3,240,7,6,12,244,2,240,12,5,12,244,1
	db 240,5,3,12,3,12,244,3,240,7,6,12,244,2,240,12
	db 5,12,244,1,240,5,3,12,244,2,240,12,5,12,244,3
	db 240,7,6,12,244,2,240,12,5,12,244,1,240,5,3,12
	db 3,12,244,3,240,7,6,12,244,2,240,12,5,12,244,3
	db 240,7,6,6,6,6,6,12,6,6,6,6,6,12,244,1
	db 240,5,3,12,244,3,240,7,6,12,6,6,6,6,6,12
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
	db 6,6,6,6,6,12,244,1,240,5,3,24,244,2,240,12
	db 5,24,244,3,240,7,6,24,244,2,240,12,5,24,244,1
	db 240,5,3,24,244,2,240,12,5,24,244,3,240,7,6,24
	db 244,2,240,12,5,24,244,1,240,5,3,24,244,2,240,12
	db 5,24,244,3,240,7,6,24,244,2,240,12,5,24,244,3
	db 240,7,6,6,6,6,6,12,6,6,6,6,6,12,244,1
	db 240,5,3,12,244,3,240,7,6,12,6,6,6,6,6,12
	db 0
_song2_v0__9:
	db 244,10,240,5,255,112,255,112,255,112,255,56,42,14,44,14
	db 46,14,49,14,244,10,240,5,42,21,39,21,42,14,255,14
	db 39,14,37,14,35,14,37,21,40,21,44,14,255,28,44,14
	db 42,14,39,21,42,21,46,14,255,14,44,14,42,14,39,14
	db 40,42,39,14,37,28,255,28,42,21,39,21,42,14,255,14
	db 47,14,46,14,42,14,44,21,40,21,37,14,255,14,40,14
	db 42,14,44,14,47,28,44,28,40,28,39,28,37,56,255,28
	db 42,14,44,14,244,10,240,5,42,21,39,21,42,14,255,14
	db 39,14,37,14,35,14,37,21,40,21,44,14,255,28,44,14
	db 42,14,39,21,42,21,46,14,255,14,44,14,42,14,39,14
	db 40,42,39,14,37,28,255,28,42,21,39,21,42,14,255,14
	db 47,14,46,14,42,14,44,21,40,21,37,14,255,14,40,14
	db 42,14,44,14,44,14,47,14,51,28,49,14,47,14,44,28
	db 46,56,255,56,244,10,240,5,47,14,46,14,44,14,39,14
	db 255,14,44,14,47,28,49,28,47,14,44,14,40,56,46,14
	db 44,14,42,14,37,14,255,14,42,14,46,28,47,28,46,14
	db 42,14,39,56,39,14,44,14,47,14,51,14,49,14,47,14
	db 44,28,40,14,44,14,49,14,47,14,44,14,40,14,37,28
	db 39,28,40,28,44,28,47,28,46,28,49,28,46,28,42,28
	db 244,11,240,4,44,14,47,14,255,14,47,14,49,14,47,14
	db 44,28,46,14,49,14,255,14,49,14,51,14,49,14,46,28
	db 42,28,46,14,51,42,49,28,47,28,46,14,44,42,255,28
	db 44,14,49,14,255,14,49,14,47,14,44,14,40,28,42,14
	db 46,14,255,14,49,14,47,14,46,14,42,28,39,28,42,28
	db 47,28,46,28,44,28,46,28,49,56,244,11,240,4,44,14
	db 47,14,255,14,47,14,49,14,47,14,44,28,46,14,49,14
	db 255,14,49,14,51,14,49,14,46,28,42,28,46,14,51,42
	db 49,28,47,28,46,14,44,42,255,28,44,14,49,14,255,14
	db 49,14,47,14,44,14,40,28,42,14,46,14,255,14,49,14
	db 47,14,46,14,42,28,51,28,49,28,47,28,42,28,47,84
	db 255,28,244,4,240,5,32,14,35,14,255,14,35,14,37,14
	db 35,14,32,28,34,14,37,14,255,14,37,14,39,14,37,14
	db 34,28,30,28,34,14,39,42,37,28,35,28,34,14,32,42
	db 255,28,44,14,47,14,255,14,47,14,49,14,47,14,44,28
	db 46,14,49,14,255,14,49,14,51,14,49,14,46,28,42,28
	db 46,14,51,42,49,28,47,28,46,14,44,42,255,28,244,10
	db 240,5,42,21,39,21,42,14,255,14,39,14,37,14,35,14
	db 37,21,40,21,44,14,255,28,44,14,42,14,39,21,42,21
	db 46,14,255,14,44,14,42,14,39,14,40,42,39,14,37,28
	db 255,28,42,21,39,21,42,14,255,14,47,14,46,14,42,14
	db 44,21,40,21,37,14,255,14,40,14,42,14,44,14,47,28
	db 44,28,40,28,39,28,37,56,255,28,42,14,44,14,244,10
	db 240,5,47,14,46,14,44,14,39,14,255,14,44,14,47,28
	db 49,28,47,14,44,14,40,56,46,14,44,14,42,14,37,14
	db 255,14,42,14,46,28,47,28,46,14,42,14,39,56,39,14
	db 44,14,47,14,51,14,49,14,47,14,44,28,40,14,44,14
	db 49,14,47,14,44,14,40,14,37,28,39,28,40,28,44,28
	db 47,28,46,28,49,28,46,28,42,28,244,11,240,4,44,14
	db 47,14,255,14,47,14,49,14,47,14,44,28,46,14,49,14
	db 255,14,49,14,51,14,49,14,46,28,42,28,46,14,51,42
	db 49,28,47,28,46,14,44,42,255,28,44,14,49,14,255,14
	db 49,14,47,14,44,14,40,28,42,14,46,14,255,14,49,14
	db 47,14,46,14,42,28,39,28,42,28,47,28,46,28,44,28
	db 46,28,49,56,244,11,240,4,44,14,47,14,255,14,47,14
	db 49,14,47,14,44,28,46,14,49,14,255,14,49,14,51,14
	db 49,14,46,28,42,28,46,14,51,42,49,28,47,28,46,14
	db 44,42,255,28,44,14,49,14,255,14,49,14,47,14,44,14
	db 40,28,42,14,46,14,255,14,49,14,47,14,46,14,42,28
	db 51,28,49,28,47,28,42,28,47,84,255,28,244,10,240,5
	db 44,42,47,14,51,56,49,42,46,14,42,56,44,42,42,14
	db 40,56,39,28,42,28,47,56,40,42,44,14,49,56,51,42
	db 49,14,46,56,47,28,44,28,40,28,44,28,46,28,49,28
	db 42,56,244,4,240,5,27,7,28,7,32,7,35,7,27,7
	db 28,7,32,7,35,7,27,7,28,7,32,7,35,7,27,7
	db 28,7,32,7,35,7,37,14,34,14,30,14,28,14,30,14
	db 34,14,37,28,27,21,34,21,37,14,34,28,30,28,27,7
	db 30,7,32,7,35,7,39,7,42,7,39,7,35,7,32,56
	db 35,14,37,14,255,14,37,14,40,14,37,14,35,28,40,42
	db 37,14,34,28,28,28,27,7,30,7,34,7,35,7,27,7
	db 30,7,34,7,35,7,27,7,30,7,34,7,35,7,27,7
	db 30,7,34,7,35,7,37,14,34,14,30,14,28,14,30,14
	db 34,14,37,28,244,4,240,5,27,7,30,7,34,7,35,7
	db 39,7,42,7,39,7,35,7,34,56,35,14,37,14,255,14
	db 37,14,40,14,37,14,35,28,39,42,37,14,34,28,27,28
	db 28,7,32,7,35,7,37,7,28,7,32,7,35,7,37,7
	db 28,7,32,7,35,7,37,7,28,7,32,7,35,7,37,7
	db 35,14,34,14,30,14,27,14,30,14,34,14,35,28,28,21
	db 35,21,37,14,35,28,32,28,27,7,28,7,32,7,35,7
	db 39,7,40,7,39,7,35,7,32,56,34,14,37,14,255,14
	db 37,14,40,14,37,14,34,28,244,10,240,5,47,14,46,14
	db 44,14,39,14,255,14,44,14,47,28,49,28,47,14,44,14
	db 40,56,46,14,44,14,42,14,37,14,255,14,42,14,46,28
	db 47,28,46,14,42,14,39,56,39,14,44,14,47,14,51,14
	db 49,14,47,14,44,28,40,14,44,14,49,14,47,14,44,14
	db 40,14,37,28,39,28,40,28,44,28,47,28,46,28,49,28
	db 46,28,42,28,244,11,240,4,44,14,47,14,255,14,47,14
	db 49,14,47,14,44,28,46,14,49,14,255,14,49,14,51,14
	db 49,14,46,28,42,28,46,14,51,42,49,28,47,28,46,14
	db 44,42,255,28,44,14,49,14,255,14,49,14,47,14,44,14
	db 40,28,42,14,46,14,255,14,49,14,47,14,46,14,42,28
	db 39,28,42,28,47,28,46,28,44,28,46,28,49,56,244,11
	db 240,4,44,14,47,14,255,14,47,14,49,14,47,14,44,28
	db 46,14,49,14,255,14,49,14,51,14,49,14,46,28,42,28
	db 46,14,51,42,49,28,47,28,46,14,44,42,255,28,44,14
	db 49,14,255,14,49,14,47,14,44,14,40,28,42,14,46,14
	db 255,14,49,14,47,14,46,14,42,28,51,28,49,28,47,28
	db 42,28,47,84,255,28,244,10,240,5,39,112,40,112,44,112
	db 46,56,255,56,0
_song2_v1__9:
	db 244,6,240,6,4,14,4,14,4,14,4,14,4,14,11,14
	db 16,14,4,14,6,14,6,14,6,14,6,14,6,14,13,14
	db 18,14,6,14,9,14,9,14,9,14,9,14,9,14,16,14
	db 21,14,9,14,11,14,11,14,11,14,11,14,11,14,18,14
	db 23,14,11,14,244,6,240,6,255,21,11,21,16,14,255,21
	db 11,21,4,14,255,21,13,21,18,14,255,21,13,21,6,14
	db 255,21,15,21,20,14,255,21,15,21,8,14,255,21,13,21
	db 18,14,255,21,13,21,6,14,255,21,11,21,16,14,255,21
	db 11,21,4,14,255,21,13,21,18,14,255,21,13,21,6,14
	db 255,21,16,21,21,14,255,21,16,21,9,14,255,21,18,21
	db 23,14,255,21,18,21,11,14,244,6,240,6,255,21,11,21
	db 16,14,255,21,11,21,4,14,255,21,13,21,18,14,255,21
	db 13,21,6,14,255,21,15,21,20,14,255,21,15,21,8,14
	db 255,21,13,21,18,14,255,21,13,21,6,14,255,21,11,21
	db 16,14,255,21,11,21,4,14,255,21,13,21,18,14,255,21
	db 13,21,6,14,255,21,16,21,21,14,255,21,16,21,9,14
	db 255,21,18,21,23,14,255,21,18,21,11,14,244,6,240,6
	db 1,21,1,7,8,21,8,7,1,21,1,7,8,21,8,7
	db 6,21,6,7,1,21,1,7,6,21,6,7,1,21,1,7
	db 11,21,11,7,6,21,6,7,11,21,11,7,6,21,6,7
	db 4,21,4,7,11,21,11,7,4,21,4,7,11,21,11,7
	db 1,21,1,7,8,21,8,7,1,21,1,7,8,21,8,7
	db 6,21,6,7,1,21,1,7,6,21,6,7,1,21,1,7
	db 9,21,9,7,4,21,4,7,9,21,9,7,4,21,4,7
	db 11,21,11,7,6,21,6,7,11,21,11,7,6,21,6,7
	db 244,6,240,6,9,21,9,7,255,14,21,14,9,14,255,14
	db 16,14,19,14,11,21,11,7,255,14,23,14,11,14,255,14
	db 18,14,21,14,8,21,8,7,255,14,20,14,8,14,255,14
	db 15,14,18,14,1,21,1,7,255,14,13,14,1,14,255,14
	db 8,14,11,14,6,21,6,7,255,14,18,14,6,14,255,14
	db 13,14,16,14,11,21,11,7,255,14,23,14,11,14,255,14
	db 18,14,21,14,4,21,4,7,255,14,16,14,4,14,255,14
	db 11,14,14,14,11,21,11,7,255,14,23,14,11,14,255,14
	db 18,14,21,14,244,6,240,6,9,21,9,7,255,14,21,14
	db 9,14,255,14,16,14,19,14,11,21,11,7,255,14,23,14
	db 11,14,255,14,18,14,21,14,8,21,8,7,255,14,20,14
	db 8,14,255,14,15,14,18,14,1,21,1,7,255,14,13,14
	db 1,14,255,14,8,14,11,14,6,21,6,7,255,14,18,14
	db 6,14,255,14,13,14,16,14,11,21,11,7,255,14,23,14
	db 11,14,255,14,18,14,21,14,4,21,4,7,255,14,16,14
	db 4,14,255,14,11,14,14,14,11,21,11,7,255,14,23,14
	db 11,14,255,14,18,14,21,14,244,6,240,6,9,21,9,7
	db 255,14,21,14,9,14,255,14,16,14,19,14,11,21,11,7
	db 255,14,23,14,11,14,255,14,18,14,21,14,8,21,8,7
	db 255,14,20,14,8,14,255,14,15,14,18,14,1,21,1,7
	db 255,14,13,14,1,14,255,14,8,14,11,14,6,21,6,7
	db 255,14,18,14,6,14,255,14,13,14,16,14,11,21,11,7
	db 255,14,23,14,11,14,255,14,18,14,21,14,4,21,4,7
	db 255,14,16,14,4,14,255,14,11,14,14,14,11,21,11,7
	db 255,14,23,14,11,14,255,14,18,14,21,14,244,6,240,6
	db 255,21,11,21,16,14,255,21,11,21,4,14,255,21,13,21
	db 18,14,255,21,13,21,6,14,255,21,15,21,20,14,255,21
	db 15,21,8,14,255,21,13,21,18,14,255,21,13,21,6,14
	db 255,21,11,21,16,14,255,21,11,21,4,14,255,21,13,21
	db 18,14,255,21,13,21,6,14,255,21,16,21,21,14,255,21
	db 16,21,9,14,255,21,18,21,23,14,255,21,18,21,11,14
	db 244,6,240,6,1,21,1,7,8,21,8,7,1,21,1,7
	db 8,21,8,7,6,21,6,7,1,21,1,7,6,21,6,7
	db 1,21,1,7,11,21,11,7,6,21,6,7,11,21,11,7
	db 6,21,6,7,4,21,4,7,11,21,11,7,4,21,4,7
	db 11,21,11,7,1,21,1,7,8,21,8,7,1,21,1,7
	db 8,21,8,7,6,21,6,7,1,21,1,7,6,21,6,7
	db 1,21,1,7,9,21,9,7,4,21,4,7,9,21,9,7
	db 4,21,4,7,11,21,11,7,6,21,6,7,11,21,11,7
	db 6,21,6,7,244,6,240,6,9,21,9,7,255,14,21,14
	db 9,14,255,14,16,14,19,14,11,21,11,7,255,14,23,14
	db 11,14,255,14,18,14,21,14,8,21,8,7,255,14,20,14
	db 8,14,255,14,15,14,18,14,1,21,1,7,255,14,13,14
	db 1,14,255,14,8,14,11,14,6,21,6,7,255,14,18,14
	db 6,14,255,14,13,14,16,14,11,21,11,7,255,14,23,14
	db 11,14,255,14,18,14,21,14,4,21,4,7,255,14,16,14
	db 4,14,255,14,11,14,14,14,11,21,11,7,255,14,23,14
	db 11,14,255,14,18,14,21,14,244,6,240,6,9,21,9,7
	db 255,14,21,14,9,14,255,14,16,14,19,14,11,21,11,7
	db 255,14,23,14,11,14,255,14,18,14,21,14,8,21,8,7
	db 255,14,20,14,8,14,255,14,15,14,18,14,1,21,1,7
	db 255,14,13,14,1,14,255,14,8,14,11,14,6,21,6,7
	db 255,14,18,14,6,14,255,14,13,14,16,14,11,21,11,7
	db 255,14,23,14,11,14,255,14,18,14,21,14,4,21,4,7
	db 255,14,16,14,4,14,255,14,11,14,14,14,11,21,11,7
	db 255,14,23,14,11,14,255,14,18,14,21,14,244,6,240,6
	db 1,28,4,28,8,28,13,28,8,28,11,28,15,28,20,28
	db 9,28,13,28,16,28,21,28,4,28,8,28,11,28,16,28
	db 6,28,9,28,13,28,18,28,8,28,11,28,15,28,20,28
	db 9,28,13,28,16,28,21,28,11,28,15,28,18,28,23,28
	db 244,6,240,6,9,21,9,7,255,14,21,14,9,14,255,14
	db 16,14,19,14,11,21,11,7,255,14,23,14,11,14,255,14
	db 18,14,21,14,8,21,8,7,255,14,20,14,8,14,255,14
	db 15,14,18,14,1,21,1,7,255,14,13,14,1,14,255,14
	db 8,14,11,14,6,21,6,7,255,14,18,14,6,14,255,14
	db 13,14,16,14,11,21,11,7,255,14,23,14,11,14,255,14
	db 18,14,21,14,4,21,4,7,255,14,16,14,4,14,255,14
	db 11,14,14,14,11,21,11,7,255,14,23,14,11,14,255,14
	db 18,14,21,14,244,6,240,6,255,21,11,21,16,14,255,21
	db 11,21,4,14,255,21,13,21,18,14,255,21,13,21,6,14
	db 255,21,15,21,20,14,255,21,15,21,8,14,255,21,13,21
	db 18,14,255,21,13,21,6,14,255,21,11,21,16,14,255,21
	db 11,21,4,14,255,21,13,21,18,14,255,21,13,21,6,14
	db 255,21,16,21,21,14,255,21,16,21,9,14,255,21,18,21
	db 23,14,255,21,18,21,11,14,244,6,240,6,1,21,1,7
	db 8,21,8,7,1,21,1,7,8,21,8,7,6,21,6,7
	db 1,21,1,7,6,21,6,7,1,21,1,7,11,21,11,7
	db 6,21,6,7,11,21,11,7,6,21,6,7,4,21,4,7
	db 11,21,11,7,4,21,4,7,11,21,11,7,1,21,1,7
	db 8,21,8,7,1,21,1,7,8,21,8,7,6,21,6,7
	db 1,21,1,7,6,21,6,7,1,21,1,7,9,21,9,7
	db 4,21,4,7,9,21,9,7,4,21,4,7,11,21,11,7
	db 6,21,6,7,11,21,11,7,6,21,6,7,244,6,240,6
	db 9,21,9,7,255,14,21,14,9,14,255,14,16,14,19,14
	db 11,21,11,7,255,14,23,14,11,14,255,14,18,14,21,14
	db 8,21,8,7,255,14,20,14,8,14,255,14,15,14,18,14
	db 1,21,1,7,255,14,13,14,1,14,255,14,8,14,11,14
	db 6,21,6,7,255,14,18,14,6,14,255,14,13,14,16,14
	db 11,21,11,7,255,14,23,14,11,14,255,14,18,14,21,14
	db 4,21,4,7,255,14,16,14,4,14,255,14,11,14,14,14
	db 11,21,11,7,255,14,23,14,11,14,255,14,18,14,21,14
	db 244,6,240,6,9,21,9,7,255,14,21,14,9,14,255,14
	db 16,14,19,14,11,21,11,7,255,14,23,14,11,14,255,14
	db 18,14,21,14,8,21,8,7,255,14,20,14,8,14,255,14
	db 15,14,18,14,1,21,1,7,255,14,13,14,1,14,255,14
	db 8,14,11,14,6,21,6,7,255,14,18,14,6,14,255,14
	db 13,14,16,14,11,21,11,7,255,14,23,14,11,14,255,14
	db 18,14,21,14,4,21,4,7,255,14,16,14,4,14,255,14
	db 11,14,14,14,11,21,11,7,255,14,23,14,11,14,255,14
	db 18,14,21,14,244,6,240,6,4,28,8,28,11,28,16,28
	db 6,28,9,28,13,28,18,28,9,28,13,28,16,28,21,28
	db 11,28,15,28,18,28,23,28,0
_song2_v2__9:
	db 244,6,240,8,23,7,27,7,30,7,34,7,30,7,27,7
	db 23,7,27,7,30,7,34,7,30,7,27,7,23,7,30,7
	db 27,7,34,7,25,7,28,7,32,7,35,7,32,7,28,7
	db 25,7,28,7,32,7,35,7,32,7,28,7,25,7,32,7
	db 28,7,35,7,28,7,32,7,35,7,39,7,35,7,32,7
	db 28,7,32,7,35,7,39,7,35,7,32,7,28,7,35,7
	db 32,7,39,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,22,7,25,7,28,7,25,7,22,7,18,7,25,7
	db 22,7,28,7,244,6,240,8,255,14,27,14,255,14,30,14
	db 255,14,27,7,23,7,255,14,30,14,255,14,28,14,255,14
	db 32,14,255,14,28,7,25,7,255,14,32,14,255,14,30,14
	db 255,14,34,14,255,14,30,7,27,7,255,14,34,14,255,14
	db 28,14,255,14,32,14,255,14,28,7,25,7,255,14,32,14
	db 255,14,27,14,255,14,30,14,255,14,27,7,23,7,255,14
	db 30,14,255,14,28,14,255,14,32,14,255,14,28,7,25,7
	db 255,14,32,14,255,14,32,14,255,14,35,14,255,14,32,7
	db 28,7,255,14,35,14,255,14,22,14,255,14,25,14,255,14
	db 22,7,18,7,255,14,25,14,244,6,240,8,255,14,27,14
	db 255,14,30,14,255,14,27,7,23,7,255,14,30,14,255,14
	db 28,14,255,14,32,14,255,14,28,7,25,7,255,14,32,14
	db 255,14,30,14,255,14,34,14,255,14,30,7,27,7,255,14
	db 34,14,255,14,28,14,255,14,32,14,255,14,28,7,25,7
	db 255,14,32,14,255,14,27,14,255,14,30,14,255,14,27,7
	db 23,7,255,14,30,14,255,14,28,14,255,14,32,14,255,14
	db 28,7,25,7,255,14,32,14,255,14,32,14,255,14,35,14
	db 255,14,32,7,28,7,255,14,35,14,255,14,22,14,255,14
	db 25,14,255,14,22,7,18,7,255,14,25,14,244,6,240,8
	db 20,7,23,7,27,7,30,7,27,7,23,7,20,7,23,7
	db 27,7,30,7,27,7,23,7,20,7,27,7,23,7,30,7
	db 25,7,28,7,32,7,35,7,32,7,28,7,25,7,28,7
	db 32,7,35,7,32,7,28,7,25,7,32,7,28,7,35,7
	db 18,7,22,7,25,7,28,7,25,7,22,7,18,7,22,7
	db 25,7,28,7,25,7,22,7,18,7,25,7,22,7,28,7
	db 23,7,27,7,30,7,34,7,30,7,27,7,23,7,27,7
	db 30,7,34,7,30,7,27,7,23,7,30,7,27,7,34,7
	db 20,7,23,7,27,7,30,7,27,7,23,7,20,7,23,7
	db 27,7,30,7,27,7,23,7,20,7,27,7,23,7,30,7
	db 25,7,28,7,32,7,35,7,32,7,28,7,25,7,28,7
	db 32,7,35,7,32,7,28,7,25,7,32,7,28,7,35,7
	db 28,7,32,7,35,7,39,7,35,7,32,7,28,7,32,7
	db 35,7,39,7,35,7,32,7,28,7,35,7,32,7,39,7
	db 18,7,22,7,25,7,28,7,25,7,22,7,18,7,22,7
	db 25,7,28,7,25,7,22,7,18,7,25,7,22,7,28,7
	db 244,6,240,8,28,7,32,7,35,7,39,7,35,7,32,7
	db 28,7,32,7,35,7,39,7,35,7,32,7,28,7,35,7
	db 32,7,39,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,22,7,25,7,28,7,25,7,22,7,18,7,25,7
	db 22,7,28,7,27,7,30,7,34,7,37,7,34,7,30,7
	db 27,7,30,7,34,7,37,7,34,7,30,7,27,7,34,7
	db 30,7,37,7,20,7,23,7,27,7,30,7,27,7,23,7
	db 20,7,23,7,27,7,30,7,27,7,23,7,20,7,27,7
	db 23,7,30,7,25,7,28,7,32,7,35,7,32,7,28,7
	db 25,7,28,7,32,7,35,7,32,7,28,7,25,7,32,7
	db 28,7,35,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,22,7,25,7,28,7,25,7,22,7,18,7,25,7
	db 22,7,28,7,23,7,27,7,30,7,34,7,30,7,27,7
	db 23,7,27,7,30,7,34,7,30,7,27,7,23,7,30,7
	db 27,7,34,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,22,7,25,7,28,7,25,7,22,7,18,7,25,7
	db 22,7,28,7,244,6,240,8,28,7,32,7,35,7,39,7
	db 35,7,32,7,28,7,32,7,35,7,39,7,35,7,32,7
	db 28,7,35,7,32,7,39,7,18,7,22,7,25,7,28,7
	db 25,7,22,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,25,7,22,7,28,7,27,7,30,7,34,7,37,7
	db 34,7,30,7,27,7,30,7,34,7,37,7,34,7,30,7
	db 27,7,34,7,30,7,37,7,20,7,23,7,27,7,30,7
	db 27,7,23,7,20,7,23,7,27,7,30,7,27,7,23,7
	db 20,7,27,7,23,7,30,7,25,7,28,7,32,7,35,7
	db 32,7,28,7,25,7,28,7,32,7,35,7,32,7,28,7
	db 25,7,32,7,28,7,35,7,18,7,22,7,25,7,28,7
	db 25,7,22,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,25,7,22,7,28,7,23,7,27,7,30,7,34,7
	db 30,7,27,7,23,7,27,7,30,7,34,7,30,7,27,7
	db 23,7,30,7,27,7,34,7,18,7,22,7,25,7,28,7
	db 25,7,22,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,25,7,22,7,28,7,244,6,240,8,255,14,32,14
	db 255,14,35,14,255,14,32,7,28,7,255,14,35,14,255,14
	db 22,14,255,14,25,14,255,14,22,7,18,7,255,14,25,14
	db 255,14,30,14,255,14,34,14,255,14,30,7,27,7,255,14
	db 34,14,255,14,23,14,255,14,27,14,255,14,23,7,20,7
	db 255,14,27,14,255,14,28,14,255,14,32,14,255,14,28,7
	db 25,7,255,14,32,14,255,14,22,14,255,14,25,14,255,14
	db 22,7,18,7,255,14,25,14,255,14,27,14,255,14,30,14
	db 255,14,27,7,23,7,255,14,30,14,255,14,22,14,255,14
	db 25,14,255,14,22,7,18,7,255,14,25,14,244,6,240,8
	db 255,14,27,14,255,14,30,14,255,14,27,7,23,7,255,14
	db 30,14,255,14,28,14,255,14,32,14,255,14,28,7,25,7
	db 255,14,32,14,255,14,30,14,255,14,34,14,255,14,30,7
	db 27,7,255,14,34,14,255,14,28,14,255,14,32,14,255,14
	db 28,7,25,7,255,14,32,14,255,14,27,14,255,14,30,14
	db 255,14,27,7,23,7,255,14,30,14,255,14,28,14,255,14
	db 32,14,255,14,28,7,25,7,255,14,32,14,255,14,32,14
	db 255,14,35,14,255,14,32,7,28,7,255,14,35,14,255,14
	db 22,14,255,14,25,14,255,14,22,7,18,7,255,14,25,14
	db 244,6,240,8,20,7,23,7,27,7,30,7,27,7,23,7
	db 20,7,23,7,27,7,30,7,27,7,23,7,20,7,27,7
	db 23,7,30,7,25,7,28,7,32,7,35,7,32,7,28,7
	db 25,7,28,7,32,7,35,7,32,7,28,7,25,7,32,7
	db 28,7,35,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,22,7,25,7,28,7,25,7,22,7,18,7,25,7
	db 22,7,28,7,23,7,27,7,30,7,34,7,30,7,27,7
	db 23,7,27,7,30,7,34,7,30,7,27,7,23,7,30,7
	db 27,7,34,7,20,7,23,7,27,7,30,7,27,7,23,7
	db 20,7,23,7,27,7,30,7,27,7,23,7,20,7,27,7
	db 23,7,30,7,25,7,28,7,32,7,35,7,32,7,28,7
	db 25,7,28,7,32,7,35,7,32,7,28,7,25,7,32,7
	db 28,7,35,7,28,7,32,7,35,7,39,7,35,7,32,7
	db 28,7,32,7,35,7,39,7,35,7,32,7,28,7,35,7
	db 32,7,39,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,22,7,25,7,28,7,25,7,22,7,18,7,25,7
	db 22,7,28,7,244,6,240,8,28,7,32,7,35,7,39,7
	db 35,7,32,7,28,7,32,7,35,7,39,7,35,7,32,7
	db 28,7,35,7,32,7,39,7,18,7,22,7,25,7,28,7
	db 25,7,22,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,25,7,22,7,28,7,27,7,30,7,34,7,37,7
	db 34,7,30,7,27,7,30,7,34,7,37,7,34,7,30,7
	db 27,7,34,7,30,7,37,7,20,7,23,7,27,7,30,7
	db 27,7,23,7,20,7,23,7,27,7,30,7,27,7,23,7
	db 20,7,27,7,23,7,30,7,25,7,28,7,32,7,35,7
	db 32,7,28,7,25,7,28,7,32,7,35,7,32,7,28,7
	db 25,7,32,7,28,7,35,7,18,7,22,7,25,7,28,7
	db 25,7,22,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,25,7,22,7,28,7,23,7,27,7,30,7,34,7
	db 30,7,27,7,23,7,27,7,30,7,34,7,30,7,27,7
	db 23,7,30,7,27,7,34,7,18,7,22,7,25,7,28,7
	db 25,7,22,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,25,7,22,7,28,7,244,6,240,8,28,7,32,7
	db 35,7,39,7,35,7,32,7,28,7,32,7,35,7,39,7
	db 35,7,32,7,28,7,35,7,32,7,39,7,18,7,22,7
	db 25,7,28,7,25,7,22,7,18,7,22,7,25,7,28,7
	db 25,7,22,7,18,7,25,7,22,7,28,7,27,7,30,7
	db 34,7,37,7,34,7,30,7,27,7,30,7,34,7,37,7
	db 34,7,30,7,27,7,34,7,30,7,37,7,20,7,23,7
	db 27,7,30,7,27,7,23,7,20,7,23,7,27,7,30,7
	db 27,7,23,7,20,7,27,7,23,7,30,7,25,7,28,7
	db 32,7,35,7,32,7,28,7,25,7,28,7,32,7,35,7
	db 32,7,28,7,25,7,32,7,28,7,35,7,18,7,22,7
	db 25,7,28,7,25,7,22,7,18,7,22,7,25,7,28,7
	db 25,7,22,7,18,7,25,7,22,7,28,7,23,7,27,7
	db 30,7,34,7,30,7,27,7,23,7,27,7,30,7,34,7
	db 30,7,27,7,23,7,30,7,27,7,34,7,18,7,22,7
	db 25,7,28,7,25,7,22,7,18,7,22,7,25,7,28,7
	db 25,7,22,7,18,7,25,7,22,7,28,7,244,6,240,8
	db 23,56,27,56,30,56,34,56,32,56,35,56,27,56,30,56
	db 28,56,32,56,30,56,34,56,32,56,35,56,22,56,25,56
	db 244,6,240,8,255,14,32,14,255,14,35,14,255,14,32,7
	db 28,7,255,14,35,14,255,14,22,14,255,14,25,14,255,14
	db 22,7,18,7,255,14,25,14,255,14,30,14,255,14,34,14
	db 255,14,30,7,27,7,255,14,34,14,255,14,23,14,255,14
	db 27,14,255,14,23,7,20,7,255,14,27,14,255,14,28,14
	db 255,14,32,14,255,14,28,7,25,7,255,14,32,14,255,14
	db 22,14,255,14,25,14,255,14,22,7,18,7,255,14,25,14
	db 255,14,27,14,255,14,30,14,255,14,27,7,23,7,255,14
	db 30,14,255,14,22,14,255,14,25,14,255,14,22,7,18,7
	db 255,14,25,14,244,6,240,8,255,14,27,14,255,14,30,14
	db 255,14,27,7,23,7,255,14,30,14,255,14,28,14,255,14
	db 32,14,255,14,28,7,25,7,255,14,32,14,255,14,30,14
	db 255,14,34,14,255,14,30,7,27,7,255,14,34,14,255,14
	db 28,14,255,14,32,14,255,14,28,7,25,7,255,14,32,14
	db 255,14,27,14,255,14,30,14,255,14,27,7,23,7,255,14
	db 30,14,255,14,28,14,255,14,32,14,255,14,28,7,25,7
	db 255,14,32,14,255,14,32,14,255,14,35,14,255,14,32,7
	db 28,7,255,14,35,14,255,14,22,14,255,14,25,14,255,14
	db 22,7,18,7,255,14,25,14,244,6,240,8,20,7,23,7
	db 27,7,30,7,27,7,23,7,20,7,23,7,27,7,30,7
	db 27,7,23,7,20,7,27,7,23,7,30,7,25,7,28,7
	db 32,7,35,7,32,7,28,7,25,7,28,7,32,7,35,7
	db 32,7,28,7,25,7,32,7,28,7,35,7,18,7,22,7
	db 25,7,28,7,25,7,22,7,18,7,22,7,25,7,28,7
	db 25,7,22,7,18,7,25,7,22,7,28,7,23,7,27,7
	db 30,7,34,7,30,7,27,7,23,7,27,7,30,7,34,7
	db 30,7,27,7,23,7,30,7,27,7,34,7,20,7,23,7
	db 27,7,30,7,27,7,23,7,20,7,23,7,27,7,30,7
	db 27,7,23,7,20,7,27,7,23,7,30,7,25,7,28,7
	db 32,7,35,7,32,7,28,7,25,7,28,7,32,7,35,7
	db 32,7,28,7,25,7,32,7,28,7,35,7,28,7,32,7
	db 35,7,39,7,35,7,32,7,28,7,32,7,35,7,39,7
	db 35,7,32,7,28,7,35,7,32,7,39,7,18,7,22,7
	db 25,7,28,7,25,7,22,7,18,7,22,7,25,7,28,7
	db 25,7,22,7,18,7,25,7,22,7,28,7,244,6,240,8
	db 28,7,32,7,35,7,39,7,35,7,32,7,28,7,32,7
	db 35,7,39,7,35,7,32,7,28,7,35,7,32,7,39,7
	db 18,7,22,7,25,7,28,7,25,7,22,7,18,7,22,7
	db 25,7,28,7,25,7,22,7,18,7,25,7,22,7,28,7
	db 27,7,30,7,34,7,37,7,34,7,30,7,27,7,30,7
	db 34,7,37,7,34,7,30,7,27,7,34,7,30,7,37,7
	db 20,7,23,7,27,7,30,7,27,7,23,7,20,7,23,7
	db 27,7,30,7,27,7,23,7,20,7,27,7,23,7,30,7
	db 25,7,28,7,32,7,35,7,32,7,28,7,25,7,28,7
	db 32,7,35,7,32,7,28,7,25,7,32,7,28,7,35,7
	db 18,7,22,7,25,7,28,7,25,7,22,7,18,7,22,7
	db 25,7,28,7,25,7,22,7,18,7,25,7,22,7,28,7
	db 23,7,27,7,30,7,34,7,30,7,27,7,23,7,27,7
	db 30,7,34,7,30,7,27,7,23,7,30,7,27,7,34,7
	db 18,7,22,7,25,7,28,7,25,7,22,7,18,7,22,7
	db 25,7,28,7,25,7,22,7,18,7,25,7,22,7,28,7
	db 244,6,240,8,28,7,32,7,35,7,39,7,35,7,32,7
	db 28,7,32,7,35,7,39,7,35,7,32,7,28,7,35,7
	db 32,7,39,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,22,7,25,7,28,7,25,7,22,7,18,7,25,7
	db 22,7,28,7,27,7,30,7,34,7,37,7,34,7,30,7
	db 27,7,30,7,34,7,37,7,34,7,30,7,27,7,34,7
	db 30,7,37,7,20,7,23,7,27,7,30,7,27,7,23,7
	db 20,7,23,7,27,7,30,7,27,7,23,7,20,7,27,7
	db 23,7,30,7,25,7,28,7,32,7,35,7,32,7,28,7
	db 25,7,28,7,32,7,35,7,32,7,28,7,25,7,32,7
	db 28,7,35,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,22,7,25,7,28,7,25,7,22,7,18,7,25,7
	db 22,7,28,7,23,7,27,7,30,7,34,7,30,7,27,7
	db 23,7,27,7,30,7,34,7,30,7,27,7,23,7,30,7
	db 27,7,34,7,18,7,22,7,25,7,28,7,25,7,22,7
	db 18,7,22,7,25,7,28,7,25,7,22,7,18,7,25,7
	db 22,7,28,7,244,6,240,8,27,56,30,56,28,56,32,56
	db 32,56,35,56,22,56,25,56,0
_song2_v3__9:
	db 244,1,240,5,3,28,244,2,240,12,5,28,244,3,240,7
	db 6,28,244,2,240,12,5,28,244,1,240,5,3,28,244,2
	db 240,12,5,28,244,3,240,7,6,28,244,2,240,12,5,28
	db 244,1,240,5,3,28,244,2,240,12,5,28,244,3,240,7
	db 6,28,244,2,240,12,5,28,244,3,240,7,6,7,6,7
	db 6,14,6,7,6,7,6,14,244,1,240,5,3,14,244,3
	db 240,7,6,14,6,7,6,7,6,14,244,1,240,5,3,14
	db 244,2,240,12,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,14,244,1,240,5,3,14,244,2,240,12,5,7,244,1
	db 240,5,3,7,244,3,240,7,6,14,244,2,240,11,5,14
	db 244,1,240,5,3,14,244,2,240,12,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,244,2
	db 240,12,5,7,244,1,240,5,3,7,244,3,240,7,6,14
	db 244,2,240,11,5,14,244,1,240,5,3,14,244,2,240,12
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,14,244,1
	db 240,5,3,14,244,2,240,12,5,7,244,1,240,5,3,7
	db 244,3,240,7,6,14,244,2,240,11,5,14,244,1,240,5
	db 3,14,244,2,240,12,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,12,5,7
	db 244,1,240,5,3,7,244,3,240,7,6,14,244,2,240,11
	db 5,14,244,1,240,5,3,14,244,2,240,12,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,12,5,7,244,1,240,5,3,7,244,3,240,7
	db 6,14,244,2,240,11,5,14,244,1,240,5,3,14,244,2
	db 240,12,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,244,2,240,12,5,7,244,1,240,5
	db 3,7,244,3,240,7,6,14,244,2,240,11,5,14,244,1
	db 240,5,3,14,244,2,240,12,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,1,240,5,3,14,244,2,240,12
	db 5,7,244,1,240,5,3,7,244,3,240,7,6,14,244,2
	db 240,11,5,14,244,3,240,7,6,7,6,7,6,14,6,7
	db 6,7,6,14,244,1,240,5,3,14,244,3,240,7,6,14
	db 6,7,6,7,6,14,244,1,240,5,3,14,244,2,240,12
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,14,244,1
	db 240,5,3,14,244,2,240,12,5,7,244,1,240,5,3,7
	db 244,3,240,7,6,14,244,2,240,11,5,14,244,1,240,5
	db 3,14,244,2,240,12,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,12,5,7
	db 244,1,240,5,3,7,244,3,240,7,6,14,244,2,240,11
	db 5,14,244,1,240,5,3,14,244,2,240,12,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,12,5,7,244,1,240,5,3,7,244,3,240,7
	db 6,14,244,2,240,11,5,14,244,1,240,5,3,14,244,2
	db 240,12,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,244,2,240,12,5,7,244,1,240,5
	db 3,7,244,3,240,7,6,14,244,2,240,11,5,14,244,1
	db 240,5,3,14,244,2,240,12,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,1,240,5,3,14,244,2,240,12
	db 5,7,244,1,240,5,3,7,244,3,240,7,6,14,244,2
	db 240,11,5,14,244,1,240,5,3,14,244,2,240,12,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,12,5,7,244,1,240,5,3,7,244,3
	db 240,7,6,14,244,2,240,11,5,14,244,1,240,5,3,14
	db 244,2,240,12,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,14,244,1,240,5,3,14,244,2,240,12,5,7,244,1
	db 240,5,3,7,244,3,240,7,6,14,244,2,240,11,5,14
	db 244,3,240,7,6,7,6,7,6,14,6,7,6,7,6,14
	db 244,1,240,5,3,14,244,3,240,7,6,14,6,7,6,7
	db 6,14,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,7,5,7,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,7,5,7,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,7,5,7
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,7
	db 5,7,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,7,5,7,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,7,5,7,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,14,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,7,5,7,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,3,240,7,6,7,6,7,6,14,6,7,6,7,6,14
	db 244,1,240,5,3,14,244,3,240,7,6,14,6,7,6,7
	db 6,14,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,7,5,7,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,7,5,7,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,7,5,7
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,7
	db 5,7,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,7,5,7,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,7,5,7,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,14,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,7,5,7,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,3,240,7,6,7,6,7,6,14,6,7,6,7,6,14
	db 244,1,240,5,3,14,244,3,240,7,6,14,6,7,6,7
	db 6,14,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,7,5,7,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,7,5,7,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,7,5,7
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,7
	db 5,7,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,7,5,7,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,7,5,7,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,14,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,7,5,7,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,3,240,7,6,7,6,7,6,14,6,7,6,7,6,14
	db 244,1,240,5,3,14,244,3,240,7,6,14,6,7,6,7
	db 6,14,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,7,5,7,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,7,5,7,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,7,5,7
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,7
	db 5,7,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,7,5,7,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,7,5,7,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,14,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,7,5,7,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,3,240,7,6,7,6,7,6,14,6,7,6,7,6,14
	db 244,1,240,5,3,14,244,3,240,7,6,14,6,7,6,7
	db 6,14,244,1,240,5,3,14,244,2,240,12,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,12,5,7,244,1,240,5,3,7,244,3,240,7
	db 6,14,244,2,240,11,5,14,244,1,240,5,3,14,244,2
	db 240,12,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,244,2,240,12,5,7,244,1,240,5
	db 3,7,244,3,240,7,6,14,244,2,240,11,5,14,244,1
	db 240,5,3,14,244,2,240,12,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,1,240,5,3,14,244,2,240,12
	db 5,7,244,1,240,5,3,7,244,3,240,7,6,14,244,2
	db 240,11,5,14,244,1,240,5,3,14,244,2,240,12,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,12,5,7,244,1,240,5,3,7,244,3
	db 240,7,6,14,244,2,240,11,5,14,244,1,240,5,3,14
	db 244,2,240,12,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,14,244,1,240,5,3,14,244,2,240,12,5,7,244,1
	db 240,5,3,7,244,3,240,7,6,14,244,2,240,11,5,14
	db 244,1,240,5,3,14,244,2,240,12,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,244,2
	db 240,12,5,7,244,1,240,5,3,7,244,3,240,7,6,14
	db 244,2,240,11,5,14,244,1,240,5,3,14,244,2,240,12
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,14,244,1
	db 240,5,3,14,244,2,240,12,5,7,244,1,240,5,3,7
	db 244,3,240,7,6,14,244,2,240,11,5,14,244,3,240,7
	db 6,7,6,7,6,14,6,7,6,7,6,14,244,1,240,5
	db 3,14,244,3,240,7,6,14,6,7,6,7,6,14,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,7,5,7,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,7,5,7,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,14,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,7,5,7,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,7,5,7,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,7,5,7
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,7
	db 5,7,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,7,5,7,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,3,240,7
	db 6,7,6,7,6,14,6,7,6,7,6,14,244,1,240,5
	db 3,14,244,3,240,7,6,14,6,7,6,7,6,14,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,7,5,7,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,7,5,7,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,14,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,7,5,7,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,7,5,7,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,7,5,7
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,7
	db 5,7,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,7,5,7,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,3,240,7
	db 6,7,6,7,6,14,6,7,6,7,6,14,244,1,240,5
	db 3,14,244,3,240,7,6,14,6,7,6,7,6,14,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,7,5,7,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,7,5,7,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,14,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,7,5,7,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,7,5,7,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,7,5,7
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,14,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,7
	db 5,7,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,7,5,7,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,3,240,7
	db 6,7,6,7,6,14,6,7,6,7,6,14,244,1,240,5
	db 3,14,244,3,240,7,6,14,6,7,6,7,6,14,244,1
	db 240,5,3,28,244,2,240,12,5,28,244,3,240,7,6,28
	db 244,2,240,12,5,28,244,1,240,5,3,28,244,2,240,12
	db 5,28,244,3,240,7,6,28,244,2,240,12,5,28,244,1
	db 240,5,3,28,244,2,240,12,5,28,244,3,240,7,6,28
	db 244,2,240,12,5,28,244,1,240,5,3,28,244,2,240,12
	db 5,28,244,3,240,7,6,28,244,2,240,12,5,28,244,1
	db 240,5,3,28,244,2,240,12,5,28,244,3,240,7,6,28
	db 244,2,240,12,5,28,244,1,240,5,3,28,244,2,240,12
	db 5,28,244,3,240,7,6,28,244,2,240,12,5,28,244,1
	db 240,5,3,28,244,2,240,12,5,28,244,3,240,7,6,28
	db 244,2,240,12,5,28,244,3,240,7,6,7,6,7,6,14
	db 6,7,6,7,6,14,244,1,240,5,3,14,244,3,240,7
	db 6,14,6,7,6,7,6,14,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,7
	db 5,7,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,7,5,7,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,7,5,7,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,14,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,7,5,7,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,7,5,7,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,14,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,7,5,7,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,7,5,7,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,3,240,7,6,7,6,7,6,14
	db 6,7,6,7,6,14,244,1,240,5,3,14,244,3,240,7
	db 6,14,6,7,6,7,6,14,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,7
	db 5,7,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,7,5,7,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,7,5,7,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,14,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,7,5,7,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,7,5,7,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,14,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,7,5,7,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,7,5,7,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,3,240,7,6,7,6,7,6,14
	db 6,7,6,7,6,14,244,1,240,5,3,14,244,3,240,7
	db 6,14,6,7,6,7,6,14,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,7
	db 5,7,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,7,5,7,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,7,5,7,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,14,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,7,5,7,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,7,5,7,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,14,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,7,5,7,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,7,5,7,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,3,240,7,6,7,6,7,6,14
	db 6,7,6,7,6,14,244,1,240,5,3,14,244,3,240,7
	db 6,14,6,7,6,7,6,14,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,7
	db 5,7,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,7,5,7,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,7,5,7,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,14,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,7,5,7,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,7,5,7,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,14,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,7,5,7,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,7,5,7,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,3,240,7,6,7,6,7,6,14
	db 6,7,6,7,6,14,244,1,240,5,3,14,244,3,240,7
	db 6,14,6,7,6,7,6,14,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,7
	db 5,7,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,14,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,7,5,7,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,14,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,7,5,7,244,1,240,5,3,14,244,2,240,11
	db 5,14,244,3,240,7,6,14,244,2,240,12,5,14,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,7,5,7,244,1,240,5,3,14,244,2
	db 240,11,5,14,244,3,240,7,6,14,244,2,240,12,5,14
	db 244,1,240,5,3,14,244,2,240,11,5,14,244,3,240,7
	db 6,14,244,2,240,12,5,7,5,7,244,1,240,5,3,14
	db 244,2,240,11,5,14,244,3,240,7,6,14,244,2,240,12
	db 5,14,244,1,240,5,3,14,244,2,240,11,5,14,244,3
	db 240,7,6,14,244,2,240,12,5,7,5,7,244,1,240,5
	db 3,14,244,2,240,11,5,14,244,3,240,7,6,14,244,2
	db 240,12,5,14,244,1,240,5,3,14,244,2,240,11,5,14
	db 244,3,240,7,6,14,244,2,240,12,5,7,5,7,244,1
	db 240,5,3,14,244,2,240,11,5,14,244,3,240,7,6,14
	db 244,2,240,12,5,14,244,3,240,7,6,7,6,7,6,14
	db 6,7,6,7,6,14,244,1,240,5,3,14,244,3,240,7
	db 6,14,6,7,6,7,6,14,244,1,240,5,3,28,244,2
	db 240,12,5,28,244,3,240,7,6,28,244,2,240,12,5,28
	db 244,1,240,5,3,28,244,2,240,12,5,28,244,3,240,7
	db 6,28,244,2,240,12,5,28,244,1,240,5,3,28,244,2
	db 240,12,5,28,244,3,240,7,6,28,244,2,240,12,5,28
	db 244,3,240,7,6,7,6,7,6,14,6,7,6,7,6,14
	db 244,1,240,5,3,14,244,3,240,7,6,14,6,7,6,7
	db 6,14,0
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
_pals__19_L2586:
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
__DataROM_END:
__Bss_START equ 04000h
__Bss_END equ 05724h
__DataRAM_START equ 05724h
__RAM_END equ 0578Bh
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
_smoke_t__0 equ 0421Ah
_eng_phase__0 equ 0421Bh
_voice__10 equ 0421Ch
_playing__10 equ 04264h
_last_vbl__10 equ 04265h
_want_div__10 equ 04266h
_want_attn__10 equ 0426Eh
_sent_div__10 equ 04272h
_sent_attn__10 equ 0427Ah
_noise_trig__10 equ 0427Eh
_sfx_frames__10 equ 0427Fh
_sfx_div__10 equ 04284h
_sfx_step__10 equ 0428Ch
_sfx_attn__10 equ 04290h
_sfx_decay__10 equ 04294h
_sfx_age__10 equ 04298h
_eng_div__10 equ 0429Ch
_eng_on__10 equ 0429Eh
_b_on__11 equ 0429Fh
_b_r0__11 equ 042A0h
_b_r1__11 equ 042A1h
_b_c0__11 equ 042A2h
_b_c1__11 equ 042A3h
_b_foot__11 equ 042A4h
_b_spr__11 equ 042A5h
_car_d__11 equ 042A6h
_br_at__12 equ 042A8h
_br_n__12 equ 042B0h
_car_d__12 equ 042B2h
_bridge_line equ 042B4h
_bb_r1__12 equ 042B5h
_bb_c0__12 equ 042B6h
_bb_c1__12 equ 042B7h
_s_offset__13 equ 042B8h
_s_sequence__13 equ 042BCh
_s_repeat_timer__14 equ 042C0h
_g_vb_hook__15 equ 042C8h
_s_cmd_type__17 equ 042CCh
_s_cmd_dst__17 equ 042DCh
_s_cmd_len__17 equ 042FCh
_s_cmd_src__17 equ 0431Ch
_s_cmd_fill__17 equ 0435Ch
_s_cmd_count__17 equ 0437Ch
_s_drop_count__17 equ 0437Dh
_s_lock__17 equ 0437Eh
_buf__18 equ 04380h
_track_len equ 04530h
_cur_stage equ 04531h
_cur_branch equ 04532h
_cur_leg equ 04533h
_leg_len equ 04534h
_fork_choice equ 04536h
_route_hist equ 04537h
_difficulty equ 0453Ch
_leg_theme equ 0453Dh
_next_leg_cost equ 0454Ch
_n_cur__18 equ 0454Eh
_n_next__18 equ 0454Fh
_rs__18 equ 04550h
_gp__18 equ 04552h
_gn__18 equ 04556h
_px__19 equ 04558h
_py__19 equ 04574h
_vx__19 equ 04590h
_vy__19 equ 045ACh
_life__19 equ 045C8h
_ptile__19 equ 045D6h
_ppal__19 equ 045E4h
_fx__19 equ 045F2h
_timer__19 equ 045F3h
_s_done_cb__20 equ 045F4h
_s_done_flag__20 equ 04604h
_s_was_active__20 equ 04608h
_s_rearm_enabled__20 equ 0460Ch
_s_rearm_elem__20 equ 04610h
_s_rearm_vector__20 equ 04614h
_s_rearm_count__20 equ 04618h
_s_rearm_dst__20 equ 04620h
_s_rearm_src__20 equ 04630h
_h_score__26 equ 04640h
_h_score_ok__26 equ 04647h
_s_dig__26 equ 04648h
_body__29 equ 04650h
_car_variant__29 equ 04670h
_car_wheel_dx__29 equ 04671h
_car_tile_base__29 equ 04672h
_lean_hold__29 equ 04674h
_lean_side__29 equ 04675h
_lean_wait__29 equ 04676h
_bump_phase__29 equ 04677h
_car_last_x__29 equ 04678h
_car_last_top__29 equ 0467Ah
_art__30 equ 0467Ch
_road_course__30 equ 04694h
_road_grade__30 equ 04695h
_band_pitch__30 equ 04696h
_climb_room__30 equ 04698h
_descent_room__30 equ 04699h
_band_shift__30 equ 0469Ah
_id_xy_a__30 equ 0469Ch
_id_xy_b__30 equ 047CEh
_id_xy_done__30 equ 04900h
_id_xy_last__30 equ 04904h
_id_raster__30 equ 04908h
_id_shear__30 equ 0491Ch
_id_sl__30 equ 0499Ch
_id_bandcol_a__30 equ 04A5Ch
_id_bandcol_b__30 equ 04B8Eh
_bc_top__30 equ 04CC0h
_id_bandcol_done__30 equ 04CC2h
_id_bandstream__30 equ 04CC6h
_band_phase__30 equ 04CD4h
_id_dxc__30 equ 04CD6h
_id_w_lat__30 equ 04DD6h
_id_w_curve__30 equ 04E16h
_id_half__30 equ 04E56h
_id_src__30 equ 04E96h
_band_top__30 equ 04ED6h
_band_mid__30 equ 04EDAh
_band_tree__30 equ 04EDEh
_band_bg_first__30 equ 04EE2h
_id_buf__30 equ 04EE4h
_pan_head__30 equ 04EE6h
_pan_lat__30 equ 04EE8h
_pan_fine__30 equ 04EEAh
_band_held__30 equ 04EEBh
_band_wait__30 equ 04EECh
_id_ahead__30 equ 04EEEh
_id_curve_cm__30 equ 04F6Eh
_wide_k0__30 equ 04F70h
_rally_of__30 equ 04F71h
_rally_src__30 equ 05172h
_rally_used__30 equ 05370h
_rally_scanned__30 equ 05371h
_band_col__30 equ 05372h
_road_dma_live__30 equ 0537Ah
_road_dma_depth__30 equ 0537Bh
_id_curve_dx__30 equ 0537Ch
_scn_phase__31 equ 053FCh
_scn_frac__31 equ 053FEh
_scn_passed__31 equ 05400h
_scn_mode__31 equ 05401h
_pano_base__32 equ 05402h
_obj_base__32 equ 05404h
_obj_end__32 equ 05406h
_pano_end__32 equ 05408h
_objmap__32 equ 0540Ah
_kind_l__32 equ 0560Ah
_kind_r__32 equ 0560Bh
_cur_pals__32 equ 0560Ch
_cur_backdrop__32 equ 05674h
_cur_road__32 equ 05676h
_cur_band__32 equ 0567Eh
_cur_spr__32 equ 05686h
_next_slot__32 equ 056B6h
_cars__33 equ 056B8h
_trf_tiles__33 equ 0571Ah
_car_d__33 equ 0571Ch
_half_wheel__33 equ 0571Eh
_dens_min__33 equ 0571Fh
_dens_max__33 equ 05720h
_target__33 equ 05721h
_cooldown__33 equ 05722h
_hard__33 equ 05723h
_car_tuned__0 equ 05724h
_roll_loaded__0 equ 05732h
_hiscore__0 equ 05734h
_eng_attn__10 equ 05744h
_bb_r0__12 equ 05745h
_sig_prev__12 equ 05746h
_s_current__13 equ 05748h
_s_last_slot__13 equ 05749h
_ngpc_pad_held equ 0574Ah
_ngpc_pad_pressed equ 0574Bh
_ngpc_pad_released equ 0574Ch
_ngpc_pad_repeat equ 0574Dh
_s_pad_prev__14 equ 0574Eh
_s_repeat_delay__14 equ 0574Fh
_s_repeat_rate__14 equ 05750h
_s_vbl_down__14 equ 05751h
_s_vbl_prev__14 equ 05752h
_g_vb_counter equ 05753h
_s_is_color__15 equ 05754h
_s_language__15 equ 05755h
_s_power_hold__16_L2250 equ 05756h
_track_seg equ 05758h
_free_seed equ 0575Ch
_seed__19 equ 0575Eh
_cur_song__22 equ 05760h
_h_time__26 equ 05761h
_h_kmh__26 equ 05762h
_h_gear__26 equ 05763h
_h_prog__26 equ 05764h
_h_stage__26 equ 05765h
_id_spr_priority equ 05766h
_car_at_x__29 equ 05768h
_car_stand__30 equ 0576Ah
_grade_hi__30 equ 0576Bh
_grade_lo__30 equ 0576Ch
_band_first__30 equ 0576Dh
_band_count__30 equ 0576Eh
_band_bg_end__30 equ 0576Fh
_road_top__30 equ 05771h
_road_plane0__30 equ 05772h
_road_bottom__30 equ 05773h
_road_lines__30 equ 05774h
_road_base_x__30 equ 05775h
_id_xy__30 equ 05776h
_id_xy_live__30 equ 0577Ah
_id_bandcol__30 equ 0577Eh
_road_band_pal__30 equ 05782h
_bc_rest__30 equ 05784h
_rng__33 equ 05788h
_trf_cap__33 equ 0578Ah

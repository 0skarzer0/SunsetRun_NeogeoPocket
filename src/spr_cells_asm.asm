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
$MAXIMUM

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

        module  spr_cells_asm

        public  _spr_cells_asm

SPRCELLS section code large

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

        end

		 output sprites.bin
	db   #fe
	dw   INICIO 
	dw   FINAL
	dw   INICIO 
	org  #d000 
INICIO: 
; Setup video mode
	ld a,5
	call #005F ; CHGMOD equ #005F, change mode video to screen 5
; Setup sprite size
; Sprites no ampliados de 16x16
	ld b,#e2
	ld c,1
	call #0047;WRTVDP equ #0047, b data to write, c number register, escribe en los registros del VDP
	ld hl, sprites_definition
	ld de, 30720 ;&h7800, base(29) en sc5
	ld bc, 32*48
	call  #005C; #005C=LDIRVM 
	ld hl, sprites_colors
	ld de, 29696 ;&h7400, en sc5
	ld bc, 16*48
	call  #005C; #005C=LDIRVM 
	ld hl, sprites_atributes
	ld de, 30208 ;&h7600, base(28) en sc5
	ld bc, 4*48
	call  #005C; #005C=LDIRVM 
.bucle: 
	jr .bucle
sprites_definition:
;Definition sprite 0, name: Sprite-2
	db 1,3,7,3,6,7,3,1
	db 1,3,2,2,3,1,1,1
	db 240,240,224,224,208,240,176,224
	db 224,240,208,208,240,224,32,176
;Definition sprite 1, name: Sprite-3
	db 1,1,1,1,3,3,1,0
	db 0,1,1,1,1,0,0,0
	db 240,240,240,240,104,248,232,240
	db 240,248,168,208,248,240,160,112
;Definition sprite 2, name: Sprite-0
	db 15,15,7,7,11,15,13,7
	db 7,15,11,11,15,7,4,13
	db 128,192,224,192,96,224,192,128
	db 128,192,64,64,192,128,128,128
;Definition sprite 3, name: Sprite-1
	db 15,15,15,15,22,31,23,15
	db 15,31,21,11,31,15,5,14
	db 128,128,128,128,192,192,128,0
	db 0,128,128,128,128,0,0,0
;Definition sprite 4, name: Sprite-4
	db 7,7,7,7,15,15,7,3
	db 7,15,11,9,15,7,2,6
	db 192,192,192,192,224,224,192,128
	db 192,224,160,32,224,224,64,96
;Definition sprite 5, name: Sprite-4
	db 3,7,7,7,15,15,7,3
	db 7,15,13,9,15,7,2,2
	db 128,192,192,192,224,224,192,128
	db 192,224,96,32,224,224,96,0
;Definition sprite 6, name: Sprite-4
	db 7,7,7,7,13,15,6,3
	db 7,15,11,13,7,3,2,6
	db 192,192,192,192,96,224,192,128
	db 192,224,160,96,192,192,64,96
;Definition sprite 7, name: Sprite-4
	db 7,7,7,7,13,15,6,3
	db 7,15,13,11,7,7,2,2
	db 192,192,192,192,96,224,192,128
	db 192,224,96,160,192,192,96,0
;Definition sprite 8, name: Sprite-2
	db 24,24,15,7,7,6,7,3
	db 1,1,2,2,3,3,1,1
	db 0,0,192,192,224,160,224,96
	db 192,224,160,160,224,224,192,64
;Definition sprite 9, name: Sprite-2
	db 0,24,31,3,3,3,3,1
	db 0,0,1,1,1,1,0,0
	db 0,0,224,224,240,80,240,176
	db 224,240,208,184,240,240,248,64
;Definition sprite 10, name: Sprite-2
	db 0,0,7,7,15,10,15,13
	db 7,15,11,29,15,15,31,2
	db 0,24,248,192,192,192,192,128
	db 0,0,128,128,128,128,0,0
;Definition sprite 11, name: Sprite-2
	db 0,0,3,3,7,5,7,6
	db 3,7,5,5,7,7,3,2
	db 24,24,240,224,224,96,224,192
	db 128,128,64,64,192,192,128,128
;Definition sprite 12, name: Sprite-4
	db 0,7,7,7,7,7,7,1
	db 7,14,14,15,15,7,2,3
	db 0,224,240,240,176,224,224,128
	db 224,240,56,248,240,224,64,96
;Definition sprite 13, name: Sprite-4
	db 0,7,7,7,7,7,7,1
	db 3,7,6,5,7,3,0,0
	db 0,224,240,240,176,224,224,192
	db 240,120,252,252,248,240,160,144
;Definition sprite 14, name: Sprite-4
	db 0,7,15,15,13,7,7,1
	db 7,15,28,31,15,7,2,6
	db 0,224,224,224,224,224,224,128
	db 224,112,112,240,240,224,64,192
;Definition sprite 15, name: Sprite-4
	db 0,7,15,15,13,7,7,3
	db 15,30,63,63,31,15,5,9
	db 0,224,224,224,224,224,224,128
	db 192,224,96,160,224,192,0,0
;Definition sprite 16, name: Sprite_name10
	db 0,7,15,15,15,7,7,31
	db 23,31,31,3,7,7,6,7
	db 0,240,248,168,240,96,192,192
	db 224,176,192,224,224,96,112,56
;Definition sprite 17, name: Sprite_name10
	db 0,3,7,7,7,3,3,3
	db 6,11,3,1,3,6,14,8
	db 0,248,252,212,248,176,224,224
	db 96,64,224,192,224,96,32,48
;Definition sprite 18, name: Sprite_name10
	db 0,15,31,21,15,6,3,3
	db 7,13,3,7,7,6,14,28
	db 0,224,240,240,240,224,224,248
	db 232,248,248,192,224,224,96,224
;Definition sprite 19, name: Sprite_name10
	db 0,31,63,43,31,13,7,7
	db 6,2,7,3,7,6,4,12
	db 0,192,224,224,224,192,192,192
	db 96,208,192,128,192,96,112,16
;Definition sprite 20, name: Sprite-4
	db 31,31,31,31,31,31,3,15
	db 23,39,23,15,7,3,3,3
	db 248,248,80,224,224,96,192,128
	db 224,240,240,240,224,192,64,224
;Definition sprite 21, name: Sprite-4
	db 15,15,15,15,15,15,7,1
	db 3,3,3,3,3,1,7,4
	db 240,248,80,240,240,176,224,192
	db 224,96,184,160,224,224,192,192
;Definition sprite 22, name: Sprite-4
	db 31,31,10,7,7,6,3,1
	db 7,15,15,15,7,3,2,7
	db 248,248,248,248,248,248,192,240
	db 232,228,232,240,224,192,192,192
;Definition sprite 23, name: Sprite-4
	db 15,31,10,15,15,13,7,3
	db 7,6,29,5,7,7,3,3
	db 240,240,240,240,240,240,224,128
	db 192,192,192,192,192,128,224,32
;Definition sprite 24, name: Sprite-34
	db 0,3,7,7,7,7,3,1
	db 3,5,5,6,3,1,3,3
	db 0,192,224,240,160,192,192,128
	db 192,224,208,192,192,192,96,176
;Definition sprite 25, name: Sprite-34
	db 0,7,15,15,15,15,7,3
	db 7,28,15,15,7,15,26,19
	db 0,128,192,224,64,128,128,0
	db 128,128,128,128,128,128,0,0
;Definition sprite 26, name: Sprite-34
	db 0,3,7,15,5,3,3,1
	db 3,7,11,3,3,3,6,13
	db 0,192,224,224,224,224,192,128
	db 192,160,160,96,192,128,192,192
;Definition sprite 27, name: Sprite-34
	db 0,1,3,7,2,1,1,0
	db 1,1,1,1,1,1,0,0
	db 0,224,240,240,240,240,224,192
	db 224,56,240,240,224,240,88,200
;Definition sprite 28, name: Sprite-4
	db 0,0,0,3,3,7,7,6
	db 7,7,3,7,7,3,2,3
	db 0,0,0,192,192,224,224,160
	db 224,96,192,224,224,192,64,96
;Definition sprite 29, name: Sprite-4
	db 0,0,0,0,0,7,7,7
	db 7,7,3,7,11,3,2,3
	db 0,0,0,0,96,224,224,96
	db 224,128,192,240,192,192,96,0
;Definition sprite 30, name: Sprite-4
	db 0,0,0,3,3,7,7,5
	db 7,6,3,7,7,3,2,6
	db 0,0,0,192,192,224,224,96
	db 224,224,192,224,224,192,64,192
;Definition sprite 31, name: Sprite-4
	db 0,0,0,0,6,7,7,6
	db 7,1,3,15,3,3,6,0
	db 0,0,0,0,0,224,224,224
	db 224,224,192,224,208,192,64,192
;Definition sprite 32, name: Sprite-22
	db 1,3,3,7,7,7,7,7
	db 39,23,15,7,15,23,7,6
	db 128,192,224,240,136,168,248,248
	db 248,168,0,80,248,248,108,36
;Definition sprite 33, name: Sprite-22
	db 0,0,1,3,3,7,7,7
	db 7,7,7,7,7,39,31,6
	db 0,0,128,192,224,240,248,136
	db 168,248,248,248,0,122,252,216
;Definition sprite 34, name: Sprite-22
	db 1,3,7,15,17,21,31,31
	db 31,21,0,10,31,31,54,36
	db 128,192,192,224,224,224,224,224
	db 228,232,240,224,240,232,224,96
;Definition sprite 35, name: Sprite-22
	db 0,0,1,3,7,15,31,17
	db 21,31,31,31,0,94,63,27
	db 0,0,128,192,192,224,224,224
	db 224,224,224,224,224,228,248,96
;Definition sprite 36, name: Sprite-20
	db 0,0,0,0,4,2,1,3
	db 7,13,15,14,11,13,1,1
	db 0,0,0,0,32,64,128,192
	db 224,176,240,176,208,152,64,160
;Definition sprite 37, name: Sprite-20
	db 0,0,0,0,0,0,28,3
	db 5,15,14,14,11,9,2,2
	db 0,0,0,0,0,0,56,192
	db 160,240,240,48,208,144,128,192
;Definition sprite 38, name: Sprite-20
	db 0,0,0,0,4,2,1,3
	db 7,13,15,13,11,25,2,5
	db 0,0,0,0,32,64,128,192
	db 224,176,240,112,208,176,128,128
;Definition sprite 39, name: Sprite-20
	db 0,0,0,0,0,0,28,3
	db 5,15,15,12,11,9,1,3
	db 0,0,0,0,0,0,56,192
	db 160,240,112,112,208,144,64,64
;Definition sprite 40, name: Sprite-21
	db 0,3,7,15,14,30,28,28
	db 30,15,15,31,18,18,18,27
	db 0,128,192,192,0,0,0,0
	db 0,12,208,224,240,40,64,0
;Definition sprite 41, name: Sprite-21
	db 0,0,30,31,7,3,7,7
	db 7,7,3,3,7,4,13,17
	db 0,0,0,128,128,128,128,0
	db 0,144,200,244,216,160,56,0
;Definition sprite 42, name: Sprite-21
	db 0,1,3,3,0,0,0,0
	db 0,48,11,7,15,20,2,0
	db 0,192,224,240,112,120,56,56
	db 120,240,240,248,72,72,72,216
;Definition sprite 43, name: Sprite-21
	db 0,0,0,1,1,1,1,0
	db 0,9,19,47,27,5,28,0
	db 0,0,120,248,224,192,224,224
	db 224,224,192,192,224,32,176,136
;Definition sprite 44, name: Sprite-22
	db 0,3,15,29,31,31,15,15
	db 15,19,35,7,7,14,14,15
	db 0,224,224,160,240,152,104,240
	db 224,144,136,192,224,96,96,112
;Definition sprite 45, name: Sprite-22
	db 0,7,31,59,63,63,30,31
	db 31,39,71,15,30,18,34,51
	db 0,224,192,64,224,240,16,224
	db 192,128,0,0,0,0,0,128
;Definition sprite 46, name: Sprite-22
	db 0,7,7,5,15,25,22,15
	db 7,9,17,3,7,6,6,14
	db 0,192,240,184,248,248,240,240
	db 240,200,196,224,224,112,112,240
;Definition sprite 47, name: Sprite-22
	db 0,7,3,2,7,15,8,7
	db 3,1,0,0,0,0,0,1
	db 0,224,248,220,252,252,120,248
	db 248,228,226,240,120,72,68,204
sprites_colors: 
;Data colors sprite 0, name: Sprite-2
	db 6,6,6,9,9,9,9,9,12,12,12,12,12,12,13,13
;Data colors sprite 1, name: Sprite-3
	db 6,6,6,9,9,9,9,9,12,12,12,12,12,12,13,13
;Data colors sprite 2, name: Sprite-0
	db 6,6,6,9,9,9,9,9,12,12,12,12,12,12,13,13
;Data colors sprite 3, name: Sprite-1
	db 6,6,6,9,9,9,9,9,12,12,12,12,12,12,13,13
;Data colors sprite 4, name: Sprite-4
	db 6,6,6,9,9,9,9,9,12,12,12,12,12,12,13,13
;Data colors sprite 5, name: Sprite-4
	db 6,6,6,9,9,9,9,9,12,12,12,12,12,12,13,13
;Data colors sprite 6, name: Sprite-4
	db 6,6,6,9,9,9,9,9,12,12,12,12,12,12,13,13
;Data colors sprite 7, name: Sprite-4
	db 6,6,6,9,9,9,9,9,12,12,12,12,12,12,13,13
;Data colors sprite 8, name: Sprite-2
	db 1,1,1,1,11,11,11,11,5,5,5,5,5,5,6,6
;Data colors sprite 9, name: Sprite-2
	db 0,1,1,1,11,11,11,11,5,5,5,5,5,5,6,6
;Data colors sprite 10, name: Sprite-2
	db 0,1,1,1,11,11,11,11,5,5,5,5,5,5,6,6
;Data colors sprite 11, name: Sprite-2
	db 1,1,1,1,11,11,11,11,5,5,5,5,5,5,6,6
;Data colors sprite 12, name: Sprite-4
	db 0,1,1,1,9,9,9,6,6,6,6,6,6,6,9,9
;Data colors sprite 13, name: Sprite-4
	db 0,1,1,1,9,9,9,6,6,6,6,6,6,6,9,9
;Data colors sprite 14, name: Sprite-4
	db 0,1,1,1,9,9,9,6,6,6,6,6,6,6,9,9
;Data colors sprite 15, name: Sprite-4
	db 0,1,1,1,9,9,9,6,6,6,6,6,6,6,9,9
;Data colors sprite 16, name: Sprite_name10
	db 0,1,1,9,9,9,7,7,7,7,7,6,6,6,1,1
;Data colors sprite 17, name: Sprite_name10
	db 0,1,1,9,9,9,7,7,7,7,7,6,6,6,1,1
;Data colors sprite 18, name: Sprite_name10
	db 0,1,1,9,9,9,7,7,7,7,7,6,6,6,1,1
;Data colors sprite 19, name: Sprite_name10
	db 0,1,1,9,9,9,7,7,7,7,7,6,6,6,1,1
;Data colors sprite 20, name: Sprite-4
	db 1,1,9,9,9,9,9,5,5,5,5,5,5,13,13,14
;Data colors sprite 21, name: Sprite-4
	db 1,1,9,9,9,9,9,5,5,5,5,5,5,13,13,14
;Data colors sprite 22, name: Sprite-4
	db 1,1,9,9,9,9,9,5,5,5,5,5,5,13,13,14
;Data colors sprite 23, name: Sprite-4
	db 1,1,9,9,9,9,9,5,5,5,5,5,5,13,13,14
;Data colors sprite 24, name: Sprite-34
	db 0,1,1,1,9,9,9,8,8,8,8,8,8,6,6,1
;Data colors sprite 25, name: Sprite-34
	db 0,1,1,1,9,9,9,8,8,8,8,8,8,6,6,1
;Data colors sprite 26, name: Sprite-34
	db 0,1,1,1,9,9,9,8,8,8,8,8,8,6,6,1
;Data colors sprite 27, name: Sprite-34
	db 0,1,1,1,9,9,9,8,8,8,8,8,8,6,6,1
;Data colors sprite 28, name: Sprite-4
	db 0,0,0,11,11,11,9,9,9,9,9,12,12,12,14,14
;Data colors sprite 29, name: Sprite-4
	db 0,0,0,0,11,11,11,9,9,9,9,12,12,12,14,14
;Data colors sprite 30, name: Sprite-4
	db 0,0,0,11,11,11,9,9,9,9,9,12,12,12,14,14
;Data colors sprite 31, name: Sprite-4
	db 0,0,0,0,11,11,11,9,9,9,9,12,12,12,14,14
;Data colors sprite 32, name: Sprite-22
	db 6,1,1,1,9,9,9,6,6,6,6,6,6,6,9,9
;Data colors sprite 33, name: Sprite-22
	db 0,0,1,1,1,1,9,9,9,6,6,6,6,6,6,6
;Data colors sprite 34, name: Sprite-22
	db 6,1,1,1,9,9,9,6,6,6,6,6,6,6,9,9
;Data colors sprite 35, name: Sprite-22
	db 0,0,1,1,1,1,9,9,9,6,6,6,6,6,6,6
;Data colors sprite 36, name: Sprite-20
	db 0,0,0,0,3,3,3,3,12,12,12,12,3,3,3,3
;Data colors sprite 37, name: Sprite-20
	db 0,0,0,0,0,0,3,3,12,12,12,12,3,3,3,3
;Data colors sprite 38, name: Sprite-20
	db 0,0,0,0,3,3,3,3,12,12,12,12,3,3,3,3
;Data colors sprite 39, name: Sprite-20
	db 0,0,0,0,0,0,3,3,12,12,12,12,3,3,3,3
;Data colors sprite 40, name: Sprite-21
	db 0,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
;Data colors sprite 41, name: Sprite-21
	db 0,0,12,12,12,12,12,12,12,12,12,12,12,12,12,12
;Data colors sprite 42, name: Sprite-21
	db 0,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
;Data colors sprite 43, name: Sprite-21
	db 0,0,12,12,12,12,12,12,12,12,12,12,12,12,12,12
;Data colors sprite 44, name: Sprite-22
	db 0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
;Data colors sprite 45, name: Sprite-22
	db 0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
;Data colors sprite 46, name: Sprite-22
	db 0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
;Data colors sprite 47, name: Sprite-22
	db 0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
sprites_atributes: 
;Data atributes sprite (y,x,patron,color) 0, name: Sprite-2
	db 0,0,0, " "
;Data atributes sprite (y,x,patron,color) 1, name: Sprite-3
	db 0,33,4, " "
;Data atributes sprite (y,x,patron,color) 2, name: Sprite-0
	db 0,66,8, " "
;Data atributes sprite (y,x,patron,color) 3, name: Sprite-1
	db 0,99,12, " "
;Data atributes sprite (y,x,patron,color) 4, name: Sprite-4
	db 0,132,16, " "
;Data atributes sprite (y,x,patron,color) 5, name: Sprite-4
	db 0,165,20, " "
;Data atributes sprite (y,x,patron,color) 6, name: Sprite-4
	db 0,198,24, " "
;Data atributes sprite (y,x,patron,color) 7, name: Sprite-4
	db 0,231,28, " "
;Data atributes sprite (y,x,patron,color) 8, name: Sprite-2
	db 33,0,32, " "
;Data atributes sprite (y,x,patron,color) 9, name: Sprite-2
	db 33,33,36, " "
;Data atributes sprite (y,x,patron,color) 10, name: Sprite-2
	db 33,66,40, " "
;Data atributes sprite (y,x,patron,color) 11, name: Sprite-2
	db 33,99,44, " "
;Data atributes sprite (y,x,patron,color) 12, name: Sprite-4
	db 33,132,48, " "
;Data atributes sprite (y,x,patron,color) 13, name: Sprite-4
	db 33,165,52, " "
;Data atributes sprite (y,x,patron,color) 14, name: Sprite-4
	db 33,198,56, " "
;Data atributes sprite (y,x,patron,color) 15, name: Sprite-4
	db 33,231,60, " "
;Data atributes sprite (y,x,patron,color) 16, name: Sprite_name10
	db 66,0,64, " "
;Data atributes sprite (y,x,patron,color) 17, name: Sprite_name10
	db 66,33,68, " "
;Data atributes sprite (y,x,patron,color) 18, name: Sprite_name10
	db 66,66,72, " "
;Data atributes sprite (y,x,patron,color) 19, name: Sprite_name10
	db 66,99,76, " "
;Data atributes sprite (y,x,patron,color) 20, name: Sprite-4
	db 66,132,80, " "
;Data atributes sprite (y,x,patron,color) 21, name: Sprite-4
	db 66,165,84, " "
;Data atributes sprite (y,x,patron,color) 22, name: Sprite-4
	db 66,198,88, " "
;Data atributes sprite (y,x,patron,color) 23, name: Sprite-4
	db 66,231,92, " "
;Data atributes sprite (y,x,patron,color) 24, name: Sprite-34
	db 99,0,96, " "
;Data atributes sprite (y,x,patron,color) 25, name: Sprite-34
	db 99,33,100, " "
;Data atributes sprite (y,x,patron,color) 26, name: Sprite-34
	db 99,66,104, " "
;Data atributes sprite (y,x,patron,color) 27, name: Sprite-34
	db 99,99,108, " "
;Data atributes sprite (y,x,patron,color) 28, name: Sprite-4
	db 99,132,112, " "
;Data atributes sprite (y,x,patron,color) 29, name: Sprite-4
	db 99,165,116, " "
;Data atributes sprite (y,x,patron,color) 30, name: Sprite-4
	db 99,198,120, " "
;Data atributes sprite (y,x,patron,color) 31, name: Sprite-4
	db 99,231,124, " "
;Data atributes sprite (y,x,patron,color) 32, name: Sprite-22
	db 132,0,128, " "
;Data atributes sprite (y,x,patron,color) 33, name: Sprite-22
	db 132,33,132, " "
;Data atributes sprite (y,x,patron,color) 34, name: Sprite-22
	db 132,66,136, " "
;Data atributes sprite (y,x,patron,color) 35, name: Sprite-22
	db 132,99,140, " "
;Data atributes sprite (y,x,patron,color) 36, name: Sprite-20
	db 132,132,144, " "
;Data atributes sprite (y,x,patron,color) 37, name: Sprite-20
	db 132,165,148, " "
;Data atributes sprite (y,x,patron,color) 38, name: Sprite-20
	db 132,198,152, " "
;Data atributes sprite (y,x,patron,color) 39, name: Sprite-20
	db 132,231,156, " "
;Data atributes sprite (y,x,patron,color) 40, name: Sprite-21
	db 165,0,160, " "
;Data atributes sprite (y,x,patron,color) 41, name: Sprite-21
	db 165,33,164, " "
;Data atributes sprite (y,x,patron,color) 42, name: Sprite-21
	db 165,66,168, " "
;Data atributes sprite (y,x,patron,color) 43, name: Sprite-21
	db 165,99,172, " "
;Data atributes sprite (y,x,patron,color) 44, name: Sprite-22
	db 165,132,176, " "
;Data atributes sprite (y,x,patron,color) 45, name: Sprite-22
	db 165,165,180, " "
;Data atributes sprite (y,x,patron,color) 46, name: Sprite-22
	db 165,198,184, " "
;Data atributes sprite (y,x,patron,color) 47, name: Sprite-22
	db 165,231,188, " "
FINAL: 

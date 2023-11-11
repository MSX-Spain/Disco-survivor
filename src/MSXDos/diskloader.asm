    ;https://www.msx.org/forum/msx-talk/development/how-can-we-load-files-from-floppies-in-assembly?page=2
;	output "diskloader.bin"
;
CALL_DISK_BASIC equ #F37D
SET_BUFFER equ #1A
FH_CREATE equ #44
FH_OPEN equ #43
FH_CLOSE equ #45
FH_READ equ #48
;	db #fe
;	dw START
;	dw END-1
;	dw START
;
;	org #8100

;************************************************************************************
; INICIO PROGRAMA ;
;************************************************************************************
;START:
;	call Crear ;Si ya existe no lo crea y da un error
;
;	call Abrir
;	call Leer
;	call Cerrar
;	ret

Seek:
	ld A,(FH)
	ld B,A
	ld de,#00
	ld hl,#00
	xor a
	ld C,#4A
	call CALL_DISK_BASIC
	ret

Leer:
	call Seek
Lee_Bytes: ;Lee bytes hasta terminar
	ld A,(FH) ;el archivo con error en A
	ld B,A
	ld C,FH_READ
	ld DE,Buffer
	ld hl,704 ;Numero de Bytes A Leer
	call CALL_DISK_BASIC ;en cada iteracion del bucle
	or A
	jp NZ,Error

	call Lee_Bytes
	ret

Abrir:
	ld DE,File
	LD A,00000000b
	ld C,FH_OPEN
	call CALL_DISK_BASIC
	or A
	jp NZ,Error
	ld A,B
	ld (FH),A

	ret

Crear:
	ld DE,File
	LD A,00000000b
	ld B,10100000b
	ld c,FH_CREATE
	call CALL_DISK_BASIC
	or A
	jp NZ,Error_al_Crear
	ld A,B
	ld (FH),A

	ret

Cerrar:
	ld C, FH_CLOSE
	ld A,(FH)
	ld B,A
	call CALL_DISK_BASIC
	ret

Error_al_Crear:
	ret
Error:
	ret
;File:
;	db "maps/map-screen5.asm",0
FH:
	ds 1
Buffer:
	ds 768

END:
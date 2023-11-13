
HKEYI equ #FD9A
HTIMI equ #FD9F ;Vblank
MAX_CONTADOR equ 50

inicilizar_tracker:
    ;Deactivamos las interrupciones
    di	
	ld		hl,SONG-99		; hl vale la direccion donde se encuentra la cancion - 99
	call	PT3_INIT			; Inicia el reproductor de PT3
    
    ;Salvamos la rutina ISR(Interrupt service routine) si hubiese alguna.Son 5 bytes
    ld hl,HTIMI
    ld de,rutina_previa
    ld bc,5
    ldir


    ;instalamos nuestra rutina
    ld a,#c3
    ld hl, reproducir_bloque_musica
    ld (HTIMI),a
    ld (HTIMI+1), hl
    ;Activamos las interrupciones
	ei 
    ;Volvemos al basic
    ret

reproducir_bloque_musica:
    ;------------------Reproducir Bloque de múscia--------
    ;halt						;sincronizacion
	di
	call	PT3_ROUT			;Borrar el valor anterior
	call	PT3_PLAY			;Reproduce el siguiente trozo de canción
    ei
    ;--------------Fin de reproducir bloque de música-----
    ;lanzamos la rutina que había
    jp rutina_previa
    ;Volvemos al basic
    ret
para_cancion:
    ;volvemos a poner los 5 bytes que tenía
    di
    ld hl,rutina_previa
    ld de,HTIMI
    ld bc,5
    ldir
    call PT3_MUTE
    ld a,0
    LD		(PT3_SETUP), a
    ei
    ret

tracker:
	include	"./src/PT3_player.asm"					;replayer de PT3
SONG:
	incbin "./src/musicdisc.pt3"			;musica de ejemplo


;definición de variables
;contador: db 0
                            ;bytes
;contador_vblanks equ #f200    ;1
;contador_de_segundos equ #f201;1
rutina_previa equ #f202       ;5

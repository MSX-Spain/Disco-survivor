
HKEYI equ #FD9A
HTIMI equ #FD9F ;Vblank
MAX_CONTADOR equ 50
rutina_previa equ #f202      
;rutina_previa: ds 5      
musica_activa: equ #8504

inicilizar_tracker:
    ;Deactivamos las interrupciones
    di	

    LD		 A, (PT3_SETUP)
    AND		11111110b
    LD		(PT3_SETUP), A


    ld a,(musica_activa)
    cp 1;Si es 1 es la música del menu
    jr z,.musica_menu
    cp 2
    jr z,.musica_ingame
    jr .inicializa_cancion
.musica_menu
    ld hl, menu-99
    jr .inicializa_cancion
.musica_ingame
	ld hl, ingame-99		; hl vale la direccion donde se encuentra la cancion - 99
.inicializa_cancion
	call PT3_INIT			; Inicia el reproductor de PT3
    
    ;Salvamos la rutina ISR(Interrupt service routine) si hubiese alguna.Son 5 bytes
    ld hl,HTIMI
    ld de,rutina_previa
    ld bc,5
    ldir


    ;instalamos nuestra rutina
    ld a,#c3
    ld (HTIMI),a
    ld hl, reproducir_bloque_musica
    ld (HTIMI+1), hl
    ;Activamos las interrupciones
	ei 
    ;Volvemos al basic
    ret

reproducir_bloque_musica:
    ;------------------Reproducir Bloque de múscia--------
    ;halt						;sincronizacion
	;di
    ld a,(musica_activa)
    or a
    jp z,.end_reproducir_bloque_musica
	call	PT3_ROUT			;Borrar el valor anterior
	call	PT3_PLAY			;Reproduce el siguiente trozo de canción
    ;ei
    ;--------------Fin de reproducir bloque de música-----
    ;lanzamos la rutina que había
    ;jp rutina_previa
    ;Volvemos al basic
    ret
.end_reproducir_bloque_musica:
    call PT3_MUTE
    ret
para_cancion:
    ;volvemos a poner los 5 bytes que tenía
    di
    ld hl,rutina_previa
    ld de,HTIMI
    ld bc,5
    ldir
    ;call PT3_MUTE
    xor a
    ld (musica_activa),a
    ;ei
    ret

sigue_musica:
    ld a,1
    ld (musica_activa),a
    ret



tracker:
	include	"./src/PT3_player.asm"					;replayer de PT3
ingame:
	incbin "./src/musicdisc.pt3"			
menu:
	incbin "./src/menu.pt3"			




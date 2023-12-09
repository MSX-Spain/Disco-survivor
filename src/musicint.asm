
HKEYI equ #FD9A
HTIMI equ #FD9F ;Vblank
MAX_CONTADOR equ 50
rutina_previa equ #f202      
;rutina_previa: ds 5      
musica_activa: equ #8504
efecto_activo: equ #8505
inicilizar_tracker:
    push ix
    ;Deactivamos las interrupciones
    di	
    ; hemos puesto a mano a 1 para que siempre se repita la canción en la variable PT3_SETUP
    ;LD		 A, (PT3_SETUP)
    ;AND		11111110b
    ;LD		(PT3_SETUP), A

    ld a,(musica_activa)
    cp 1;Si es 1 es la música del menu
    jr z,.musica_menu
    cp 2
    jr z,.musica_ingame
    cp 3
    jr z,.musica_final
    jr .inicializa_cancion
.musica_menu:;https://zxart.ee/spa/autores/c/cj-echo/wild-quaker3/
    ld hl, menu-99
    jr .inicializa_cancion
.musica_final:
	ld hl, final-99	
    jr .inicializa_cancion
.musica_ingame:
	ld hl, ingame-99		; hl vale la direccion donde se encuentra la cancion - 99


.inicializa_cancion:
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
    
    ;inicializacion del reproductor de efectos sonoros
    ;ld a,(efecto_activo)
    ;or a ; si el efecto está activo nos activará el flag z
    ;jp z, reproducir_bloque_musica
    LD		HL, sfx_bank
    CALL	ayFX_SETUP
    ;Volvemos al basic
    pop ix
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

    ld a,(efecto_activo)
    or a  ; si el efecto está activo nos activará el flag z
    jp z,.end_reproducir_bloque_musica
    JP		ayFX_PLAY	
    ;ei
    ;--------------Fin de reproducir bloque de música-----
    ;lanzamos la rutina que había
    ;jp rutina_previa
    ;Volvemos al basic
    ret
.end_reproducir_bloque_musica:
    ;call PT3_MUTE
    ld a ,1
    ld (efecto_activo),a
    ret
para_cancion:
    ;volvemos a poner los 5 bytes que tenía
    di
    ;ld hl,rutina_previa
    ;ld de,HTIMI
    ;ld bc,5
    ;ldir
    call PT3_MUTE
    ;xor a
    ;ld (musica_activa),a
    ei
    ret

sigue_musica:
    ld a,1
    ld (musica_activa),a
    ret
efecto_toque:
    LD			A, 0; 
    LD			C, 1
    CALL		ayFX_INIT
    ret
efecto_golpe:
    ld a,0
    ld (efecto_activo),a
    LD			A, 1; 
    LD			C, 1
    CALL		ayFX_INIT
    ret
efecto_romper:
    LD			A, 6; 
    LD			C, 1
    CALL		ayFX_INIT
    ret

efecto_coge_botella:
    LD			A, 10; 
    LD			C, 1
    CALL		ayFX_INIT
    ret
efecto_mata_player:
    LD			A, 13; 
    LD			C, 1
    CALL		ayFX_INIT
    ret

;includes para sjasmplus
;tracker:
;	include	"./src/PT3_player.asm"					
;ingame:
;	incbin "./src/dd.pt3"	
;menu:
;    incbin "./src/musicdisc.pt3"		
;fx_player:
;    include	"./src/ayFX_player.asm"	
;sfx_bank:
;	incbin "./src/sfx.afb"

tracker:
	include	"PT3_player.asm"			
ingame:
	incbin "dd.pt3"	
menu:
    incbin "musicdisc.pt3"	
final:
    incbin "final.pt3"		
fx_player:
    include	"ayFX_player.asm"	;efectos de https://github.com/Threetwosevensixseven/ayfxedit-improved
sfx_bank:
	incbin "sfx.afb"

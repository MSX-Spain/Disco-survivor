    output "main.bin"

    db   0FEh               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO             ; dirección de inicio
    dw   FINAL - 1          ; dirección final
    dw   MAIN               ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)
    
     
 
    org #8600             ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200
        
INICIO:

screen: equ #8500
game_over: equ #8501
lives: equ #8502
score: equ #8503
in_game: equ #8504



MAIN:   

	call create_player
	call create_enemy
    
 
.in_game:
    call para_cancion
    ld a,1; le ponemos la música del menú
    ld (musica_activa),a
    call inicilizar_tracker
    
    call clear_screen
    call ENASCR; encendemos la pantalla
    call KILBUF
    call show_menu


;.repetir_menu:
;    ld a,0
;    call GTTRIG
;    cp 0
;    jr z,.repetir_menu
    call CHGET

    call para_cancion
    ld a,2; le ponemos la música ingame
    ld (musica_activa),a
    call inicilizar_tracker

    ld a,0
    ld (screen),a
    xor a
    ld (game_over),a
    xor a
    ld (score),a
    ld a,7
    ld (lives),a
    call increase_screen

    call main_loop
    jp .in_game
	ret

main_loop:
    halt
    call update_player
    call render_player
    ld a, (game_over)
    cp 1
    jr z,.end_main_loop

    call update_enemies
    call render_enemies


    
	jr main_loop
.end_main_loop:
    call sacar_sprites_de_pantalla
    ld a,212
    ld (ix+player.y),a
    call render_player
    call render_enemies
    ret
  


kill_player
    ld a,(lives)
    sub 1
    ld (lives),a
    cp 0
    jr z,.end_kill_player
    call recolocate_player
    call efecto_mata_player
    call hud
    ret
.end_kill_player
    ld a,1
    ld (game_over),a
    ret








;;----------------------------------
;;   GETBLOCK=Hace esta formula (y/8)*32+(x/8)
;;      Input:
;;          D=con la posición x
;;          E=con la posición y
;;      Output
;;          B=el tile sobre el que está laentidad
get_block:
    ld a,e
    ;ld a,(ix+player.y) ;a=posicion y en pixeles
    add 16
    ;con srl estas dividiendo entre 2,ya que corre a la derecha los bits. 
    ;al hacerlo 3 veces es como dividir entre 8,a=y/8: 1.01001100, 2.00100110, 3.00010011
    srl a  
    srl a  
    srl a  
    ld h,0 ; en h le ponemos un 0 
    ld l,a ;y en los 8 bytes de "l" le ponemos el valor que contiene a

    ;-----------------
    ;Buscando la fila
    add hl, hl ;x32, sumar algo por si mismo es como multiplizarlo por 2, si lo repetivos 5 es como si o multiplixaramos por 32
    add hl, hl 
    add hl, hl 
    add hl, hl 
    add hl, hl 

    ;-----------------
    ;Esta es la parte +(x/8)
    ld a,d
    ;ld a,(ix+player.x) ;a=x
    add 8
    srl a 
    srl a 
    srl a 
    ld d,0
    ld e,a ;e=x
    add hl,de ;hl=(y/8)*32+(x/8)

    ld de, map_buffer; dirección buffer colisiones
    add hl,de ;hl=buffer_colisiones + (y/8)*32+(x/8)

    ld b,(hl) ;metemos en a el tile que nos pide
    ;ld (tile0),a
    ret




hud:
    ;------------------------Level--------------------------
    ;ld a,0
    ;ld (GRPACX),a ;GRPACX contiene la posición X del cursor en modo gráfico
    ;ld a,184
    ;ld (GRPACY),a
    ;ld hl, message_level
    ;call graphics_print
    ld a, 122
    ld hl,6851
    call WRTVRM
    ld a, 123
    ld hl,6852
    call WRTVRM
    ld a, 154
    ld hl,6883
    call WRTVRM
    ld a, 155
    ld hl,6884
    call WRTVRM
    ;1 nos estudiamos donde está la dirección de la tabla de nombres en VRAM
    ;2.obtenemos el número de tile que keremos poner
    ld a,(screen)
    ld b, COMIENZO_TILE_NUMEROS
    add b
    ld hl, 6886 ;aki va la dirección de la tabla de nombres que keremos cambiar;6912(final de la tabla de nombres)-32(-1 fila)=6880+7
    call WRTVRM
   ;---------------------Fin Level--------------------------


    ;------------------------Score--------------------------
    ;ld a,90; posicionamos el cursor en la posición x ..
    ;ld (GRPACX),a
    ;ld hl, message_score
    ;call graphics_print
    
    ;*******CON EL GRPPT SLAEN LOS NÚMERO MACHADOS***/
    ;ld a,140; posicionamos el cursor en la posición x ..
    ;ld (GRPACX),a
    ;ld b,48;metemos en b el valor correspondiente al 0 en la tabla ascii
    ;ld a,(score)
    ;add b
    ;cp 56
    ;jr nc, .a_es_mayor_de_56
    ;call GRPPRT 
;.a_es_mayor_de_56:
;    ld a,48
;    call GRPPRT
    ;**************************************************
    ;pintamos los 4 tiles del score (el dibujo)
    ld a, 124
    ld hl,6862
    call WRTVRM
    ld a, 125
    ld hl,6863
    call WRTVRM
    ld a, 156
    ld hl,6894
    call WRTVRM
    ld a, 157
    ld hl,6895
    call WRTVRM



    ld a,(score)
    ld b, COMIENZO_TILE_NUMEROS
    add b
    ld b,0; Ponemos b a 0 ya que será nuestro contador de decenas
.repetir:
    ;si score es mayor que 10
    cp COMIENZO_TILE_NUMEROS+10 ;no dará carry si score es mayor que 10
    jr nc, .es_mayor_que_10
    ld hl, 6898
    call WRTVRM
    jr .next
.es_mayor_que_10:
    inc b ; aumentamos el contador de decenas
    sub 10
    jr .repetir
.next:
    ;aki imprimimos las decenas almacenadas en b
    ld hl, 6897
    ld a,b
    cp #a ;si el valor de b es 10 sumamos una vida y ponemos el score a 0
    jr z, .sumar_vida_y_reiniciar_score
    ld b, COMIENZO_TILE_NUMEROS
    add b
    call WRTVRM
    jr .fin
.sumar_vida_y_reiniciar_score:
    xor a
    ld (score),a
    ld a,(lives)
    inc a
    ld (lives),a
    call efecto_toque
.fin:    
    ;---------------------Fin score--------------------------

    ;------------------------Lives--------------------------
    ;ld a,190
    ;ld (GRPACX),a
    ;ld hl, message_lives
    ;call graphics_print
    ;ld a,240
    ;ld (GRPACX),a

    ;ld b,47    ;metemos en b el valor correspondiente al 0 en la tabla ascii
    ;ld a,(lives)    ;para sumar a y b tendremos que echar mano de ld a
    ;add b
    ;call GRPPRT 

    ld a, 126
    ld hl,6873
    call WRTVRM
    ld a, 127
    ld hl,6874
    call WRTVRM
    ld a, 158
    ld hl,6905
    call WRTVRM
    ld a, 159
    ld hl,6906
    call WRTVRM


    ld a,(lives)
    ld b, COMIENZO_TILE_NUMEROS
    add b
    ld hl, 6910 
    call WRTVRM
    ;----------------------Fin lives-------------------------
    ret

graphics_print:
    ld  a,(hl)          
    and a               
    ret z               
    call GRPPRT         
    inc hl              
    jr graphics_print 
    ret     
graphics_print_sc2:
    ;ld de, message_msx_spain ; la dirección donde empiezan los bytes del texto
    ;ld b, 1;    posicón y
    ;ld c, 5;    posicón x
    ld hl, 6144 +256
    sla b           ;b x2
    sla b           ;b x4
    sla b           ;b x8
    sla b           ;b x16
    sla b           ;b x32
    ld a,b
    ld b,0
    add hl, bc; c ya lo teníamos, se lo sumamos a hl
    ld c,a
    add hl, bc
    call print_cs2
    ret

print_cs2:
    ld a,(de)          
    and a               
    ret z  ;si ha llegado a 0 salimos    
    add 31
    call WRTVRM;en hl la dirección y en a el valor
    ;call GRPPRT         
    inc de    
    inc hl          
    jr print_cs2   
    ret

show_menu:
    ;pintamos la imagen de arriba
    ld b,20
    ld a, 39
    ld hl, 6188
.repeat1:
    call WRTVRM;en hl la dirección y en a el valor
    dec b
    inc a
    inc hl
    djnz .repeat1

    ld b,20
    ld a, 71
    ld hl, 6220
.repeat2:
    call WRTVRM;en hl la dirección y en a el valor
    dec b
    inc a
    inc hl
    djnz .repeat2

    ld de, message_msx_spain_presents ; la dirección donde empiezan los bytes del texto
    ld b, 1;    posicón y
    ld c, 7;    posicón x
    call graphics_print_sc2

    ld de, message_disco 
    ld b, 4;    posicón y
    ld c, 13;    posicón x
    call graphics_print_sc2

    ld de, message_press_any_key_to_start 
    ld b, 7;    posicón y
    ld c, 2;    posicón x
    call graphics_print_sc2
    ret


clear_screen:
    ld a,0
    ld bc, 768
    ld hl, 6144
    call FILVRM
    ret




increase_screen:
    call para_cancion
    ld a,2; le ponemos la música ingame
    ld (musica_activa),a
    call inicilizar_tracker

    call sacar_sprites_de_pantalla
    call recolocate_player 
    ;call DISSCR ;Apagamos la pantalla
    ld a,(screen)
    add 1
    ld (screen),a ; aumentamos en contador de pantallas
    call hud
    ;call ENASCR
    ;posicinamos los enemigos
    ld a,(screen)
    cp 1
    jp z, recolocate_and_level_screen_1
    cp 2
    jp z, recolocate_and_level_screen_2
    cp 3
    jp z, recolocate_and_level_screen_3
    cp 4
    jp z, recolocate_and_level_screen_4
    cp 5
    jp z, recolocate_and_level_screen_5
    cp 6
    jp z, recolocate_and_level_screen_6
    cp 7
    jp z, recolocate_and_level_screen_7
    cp 8
    jp z, recolocate_and_level_screen_8
    cp 9
    jp z, recolocate_and_level_screen_9
    cp 10
    jp z, recolocate_and_level_screen_10
    cp 11
    jp z, recolocate_and_level_screen_11
    cp 12
    jp z, recolocate_and_level_screen_12
    cp 13
    jp z, is_final_screen


    ret

is_final_screen:
    ;sacamos de la pantalla al player
    ld a,212
    ld (ix+player.y),a
    call render_player
    ;Sacamos a los enemigos
    call sacar_sprites_de_pantalla
    call render_enemies
    ;ponemos el juego en game over
    ld a,1
    ld (game_over),a

    call para_cancion
    ld a,3; le ponemos la música del final
    ld (musica_activa),a
    call inicilizar_tracker
    call clear_screen

    ld de, message_congratulations 
    ld b, 1;    posicón y
    ld c, 0;    posicón x
    call graphics_print_sc2

    ld de, message_developer
    ld b, 4;    posicón y
    ld c, 4;    posicón x
    call graphics_print_sc2

    ld de, message_music
    ld b, 5;    posicón y
    ld c, 4;    posicón x
    call graphics_print_sc2

    ld de, message_graphics
    ld b, 6;    posicón y
    ld c, 4;    posicón x
    call graphics_print_sc2

    ld de, message_press_any_key_to_start 
    ld b, 15;    posicón y
    ld c, 2;    posicón x
    call graphics_print_sc2


;.repetir_menu:
;    ld a,0
;    call GTTRIG
;    cp 0
;    jr z,.repetir_menu
;hacemos una pekeña pausa
    ld de,#100
.wait:    
    halt
    dec de
    ld a,d
    or e
    jp nz,.wait
    call KILBUF
    ;esperamos a que se pulse una tecla
    call CHGET
    call sacar_sprites_de_pantalla
    ret




message_level: db "Level",0
message_lives: db "Lives",0
message_score: db "Score",0
message_msx_spain_presents: db "MSXñSPAINñPRESENTS",0
message_disco: db "DISCO",0
message_start_game: db "1.start game",0
message_press_any_key_to_start: db "PRESSñSPACEñKEYñTOñSTART",0
message_congratulations: db "CONGRATULATIONS¡YOU¡FINISHED¡THE¡GAME",0
message_music: db "MUSIC¡BY¡CLEMENTE",0
message_developer: db "DEVELOPER¡MSX¡SPAIN",0
message_graphics: db "GRAPHICS¡KIKE¡MADRIGAL",0

change_screen: db 0

map_buffer: ds 704 ;768-64 es el mapa o tabla de nombres de VRAM copiada aquí
MAPS_DIRECTION: equ #c001
MAP_SIZE: equ 704 ;son 22 líneas de 32 bytes cada línea
;Store_Sprite_Collision: db 0
COMIENZO_TILE_NUMEROS: equ 86

buffer_numeros: ds 8
TILE_DOOR: equ 55
TILE_SOLID: equ 32
TILE_BOTTLE1: equ 56
TILE_BOTTLE2: equ 57
tile_negro: db 0

UP: equ 1
DOWN: equ 5
LEFT: equ 7
RIGHT: equ 3 




;Includes para sjasmplus
	include "src/vars_msxBios.asm"    
	include "src/vars_msxSystem.asm"    
	include "src/MSXBasic/player.asm"    
	include "src/MSXBasic/enemies.asm"    
	include "src/MSXBasic/recolocate_and_level.asm"    
    include "src/musicint.asm"
depack_RAM:
    include "src/dzx0_fast.asm" ;cuando crees los archivos ponle que salte 8 bits (la cabcerea + el ret): zx0.exe +8  map-screen1.bin 
maps_tiled1:
    incbin "./assets/tiled/map-screen1.bin.zx0"
maps_tiled2:
    incbin "./assets/tiled/map-screen2.bin.zx0"
maps_tiled3:
    incbin "./assets/tiled/map-screen3.bin.zx0"
maps_tiled4:
    incbin "./assets/tiled/map-screen4.bin.zx0"
maps_tiled5:
    incbin "./assets/tiled/map-screen5.bin.zx0"
maps_tiled6:
    incbin "./assets/tiled/map-screen6.bin.zx0"
maps_tiled7:
    incbin "./assets/tiled/map-screen7.bin.zx0"
maps_tiled8:
    incbin "./assets/tiled/map-screen8.bin.zx0"
maps_tiled9:
    incbin "./assets/tiled/map-screen9.bin.zx0"
maps_tiled10:
    incbin "./assets/tiled/map-screen10.bin.zx0"
maps_tiled11:
    incbin "./assets/tiled/map-screen11.bin.zx0"
maps_tiled12:
    incbin "./assets/tiled/map-screen12.bin.zx0"




FINAL:
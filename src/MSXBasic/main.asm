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
    call show_menu
    call KILBUF
    ;call CHGET
.repetir_menu:
    ld a,0
    call GTTRIG
    cp 0
    jr z,.repetir_menu


    call para_cancion
    ld a,2; le ponemos la música ingame
    ld (musica_activa),a
    call inicilizar_tracker

    ld a,0
    ld (screen),a
    ld a,7
    ld (lives),a
    ld a,0
    ld (game_over),a
    call increase_screen

    call main_loop
    jp .in_game
	ret

main_loop:
    halt
   
	call update_player
    call update_enemies
    call render_player
    call render_enemies
    ld a, (game_over)
    cp 1
    jr z,.end_main_loop
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
    ld a,0
    ld (GRPACX),a ;GRPACX contiene la posición X del cursor en modo gráfico
    ld a,184
    ld (GRPACY),a
    ld hl, message_level
    call graphics_print
    ;1 nos estudiamos donde está la dirección de la tabla de nombres en VRAM
    ;2.obtenemos el número de tile que keremos poner
    ld a,(screen)
    ld b, COMIENZO_TILE_NUMEROS
    add b
    ld hl, 6886 ;aki va la dirección de la tabla de nombres que keremos cambiar;6912(final de la tabla de nombres)-32(-1 fila)=6880+7
    call WRTVRM
   ;---------------------Fin Level--------------------------


    ;------------------------Score--------------------------
    ld a,90; posicionamos el cursor en la posición x ..
    ld (GRPACX),a
    ld hl, message_score
    call graphics_print
    
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
    ld hl, 6898
    ld a,(score)
    ld b, COMIENZO_TILE_NUMEROS
    add b
.repetir_por_ser_mayor_que_9:
    cp COMIENZO_TILE_NUMEROS+9
    jr z,.es_mayor_que_COMIEZO_TILES_NUMEROS_mas_9
    jr .next
.es_mayor_que_COMIEZO_TILES_NUMEROS_mas_9:
    inc hl
    ld a,COMIENZO_TILE_NUMEROS
    call WRTVRM ;ponemos un 0
    jr .repetir_por_ser_mayor_que_9

.next:
    call WRTVRM
    ;---------------------Fin score--------------------------

    ;------------------------Lives--------------------------
    ld a,190
    ld (GRPACX),a
    ld hl, message_lives
    call graphics_print
    ld a,240
    ld (GRPACX),a

    ;ld b,47    ;metemos en b el valor correspondiente al 0 en la tabla ascii
    ;ld a,(lives)    ;para sumar a y b tendremos que echar mano de ld a
    ;add b
    ;call GRPPRT 

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
    ld c, 8;    posicón x
    call graphics_print_sc2

    ld de, message_disco 
    ld b, 4;    posicón y
    ld c, 13;    posicón x
    call graphics_print_sc2

    ld de, message_press_any_key_to_start 
    ld b, 7;    posicón y
    ld c, 5;    posicón x
    call graphics_print_sc2
    ret


clear_screen:
    ld a,0
    ld bc, MAP_SIZE+64
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
    call load_screens
    call hud
    call ENASCR
    ;posicinamos los enemigos
    ld a,(screen)
    cp 1
    jp z, recolocate_enemies_screen_1
    cp 2
    jp z, recolocate_enemies_screen_2
    cp 3
    jp z, recolocate_enemies_screen_3
    cp 4
    jp z, recolocate_enemies_screen_4
    cp 5
    jr z, is_final_screen

    ret
load_screens:
    ld hl, MAPS_DIRECTION
    ld bc, MAP_SIZE
    ld a,(screen)
.loop_load_screens:
    cp 1
    jr z, .es_cero
    sub 1
    add hl, bc
    jr .loop_load_screens
.es_cero:
    ld de, map_buffer 
    ld bc, MAP_SIZE
    LDIR
    ;ponemos el mapa en la VRAM
    ld hl, map_buffer
    ld de, 6144 
	;Le quitamos 64 ya que keremos pintar el HUD en las últimas 2 líneas de la pantalla
    ld bc, MAP_SIZE
    call  LDIRVM
    ret
is_final_screen:
    ld a,1
    ld (screen),a
    call load_screens
    ret




message_level: db "Level",0
message_lives: db "Lives",0
message_score: db "Score",0
message_msx_spain_presents: db "MSXzSPAINzPRESENTS",0
message_disco: db "DISCO",0
message_start_game: db "1.start game",0
message_press_any_key_to_start: db "PRESSzSPACEzKEYzTOzSTART",0


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

COLOR_TRASPARENTE: equ 0
COLOR_NEGRO: equ 1
COLOR_VERDE_MEDIO: equ 2
COLOR_VERDE_CLARO: equ 3
COLOR_AZUL_OSCURO: equ 4
COLOR_AZUL_MEDIO: equ 5
COLOR_ROJO_OSCURO: equ 6
COLOR_AZUL_CLARO:equ 7
COLOR_ROJO_MEDIO: equ 8
COLOR_ROSA: equ 9
COLOR_AMARILLO: equ 10
COLOR_AMBAR: equ 11
COLOR_VERDE_OSCURO: equ 12
COLOR_LILA: equ 13
COLOR_GRIS: equ 14
COLOR_BLANCO: equ 15


    
	include "src/vars_msxBios.asm"    
	include "src/vars_msxSystem.asm"    

	include "src/MSXBasic/player.asm"    
	include "src/MSXBasic/enemies.asm"    

    include "./src/musicint.asm"

FINAL:
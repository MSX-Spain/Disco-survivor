    output "main.bin"

    db   0FEh               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO             ; dirección de inicio
    dw   FINAL - 1          ; dirección final
    dw   MAIN               ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)
    
     
 
    org #8600             ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200
        
INICIO:

screen: equ #8500
in_game: equ #8501
lives: equ #8502
score: equ #8503


MAIN:   
    ;call inicilizar_tracker
    call ENASCR; encendemos la pantalla
    ld a,1
    ld (in_game),a;ponemos el valor de ingame a 1 para que no se salga a la siguiente pantalla

	call create_player
	call create_enemy
    call hud
    call load_screens ; cargamos las 5 pantallas
	call main_loop
    

	ret

main_loop:
    halt
	call update_player
    call update_enemies
    call render_player
    call draw_enemies
    ld a, (in_game)
    cp 0
    jp z, .end_game
	jr main_loop
.end_game:
    ;call REPLAYER_STOP
    ret


kill_player
    call BEEP
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
    ld hl, 6885 ;aki va la dirección de la tabla de nombres que keremos cambiar;6912(final de la tabla de nombres)-32(-1 fila)=6880+7
    call WRTVRM
   ;---------------------Fin Level--------------------------


    ;------------------------Score--------------------------
    ld a,58; posicionamos el cursor en la posición x 58
    ld (GRPACX),a
    ld hl, message_score
    call graphics_print
    ld a,100; posicionamos el cursor en la posición x 58
    ld (GRPACX),a
    ;metemos en b el valor correspondiente al 0 en la tabla ascii
    ld b,47
    ;para sumar a y b tendremos que echar mano de ld a
    ld a,(score)
    add b
    call GRPPRT 
    ;---------------------Fin score--------------------------

    ;------------------------Lives--------------------------
    ld a,150
    ld (GRPACX),a
    ld hl, message_lives
    call graphics_print
    ld a,200
    ld (GRPACX),a
    ;metemos en b el valor correspondiente al 0 en la tabla ascii
    ld b,47
    ;para sumar a y b tendremos que echar mano de ld a
    ld a,(lives)
    add b
    call GRPPRT 
    ;----------------------Fin lives-------------------------
    ret

graphics_print:
    ld  a,(hl)          
    and a               
    ret z               
    call GRPPRT         
    inc hl              
    jr graphics_print      







increase_screen:
    ;call para_cancion
    call recolocate_player
    ;call BCLS   ;Apagamos la pantalla
    ld a,(screen)
    add 1
    ld (screen),a ; aumentamos en contador de pantallas
    ld a,0
    ld (in_game),a ; ponemos para que finalice la pantalla y carguemos con el basic la siguiente
    ret
load_screens:
    ld hl, #d101
    ld de, map_buffer 
    ld bc, 768-64
    LDIR
    ;ponemos el mapa en la VRAM
    ld hl, map_buffer
    ld de, 6144 
	;Le quitamos 64 ya que keremos pintar el HUD en las últimas 2 líneas de la pantalla
    ld bc, 768-64
    call  LDIRVM
    call hud
    ret




message_level: db "Level",0
message_lives: db "Lives",0
message_score: db "Score",0

map_buffer: ds 704 ;768-64 es el mapa o tabla de nombres de VRAM copiada aquí
Store_Sprite_Collision: db 0
COMIENZO_TILE_NUMEROS equ 86
buffer_numeros: ds 8
TILE_DOOR equ 55
TILE_SOLID equ 32

REPLAYER_INIT equ #bf00;inicializa el reproductor
REPLAYER_STOP equ #BF3B;Parar canción
REPLAYER_NOT_REPEAT equ #BF4A;    
    
	include "src/vars_msxBios.asm"    
	include "src/vars_msxSystem.asm"    

	include "src/MSXBasic/player.asm"    
	include "src/MSXBasic/enemies.asm"    

    ;include "./src/musicint.asm"

FINAL:
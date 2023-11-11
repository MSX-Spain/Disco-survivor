    output "main.bin"

    db   0FEh               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO             ; dirección de inicio
    dw   FINAL - 1          ; dirección final
    dw   MAIN               ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)
    
     
 
    org #8500             ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200
        
INICIO:


screen: db 1
message_level: db "Level",0
message_lives: db "Lives",0
message_score: db "Score",0
message_msx_spain: db "MSX spain",0 
message_game_completed: db "Felicidades, te has pasado el juego!!!",0 
map_buffer: ds 704 ;768-64 es el mapa o tabla de nombres de VRAM copiada aquí

Store_Sprite_Collision: db 0
IN_GAME_DIRECTION equ #ef00
COMIENZO_TILE_NUMEROS equ 86
buffer_numeros: ds 8

TILE_DOOR equ 55
TILE_SOLID equ 32




MAIN:

    ld a,1
    ld (IN_GAME_DIRECTION),a
	call create_player
	call create_enemy
    call hud
    call load_screen
    call ENASCR; encendemos la pantalla
	call main_loop
	ret

main_loop:
	halt
	call update_player
    call update_enemies
    call render_player
    call draw_enemies
    ld a, (IN_GAME_DIRECTION)
    cp 2
    jr z, .end_game
	jr main_loop
.end_game:
    ret

;devolver_valor_screen_a_basic:
;    ld a,(screen)
;    ld h,0
;    ld l,a
;    ld d,0
;    ld e,a
;    ld ix,screen
;    ret


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
    ;Esto crea un  line (0,170)-(256,190),9,BF
    ;ld a,1
    ;call SETATR ;establece el atributo rojo claro
    ;ld hl,0
    ;ld (gxpos),hl
    ;ld hl,170
    ;ld (gypos),hl
    ;ld bc,256
    ;ld de,190
    ;ld ix,bios_line
    ;call CALBAS

    ;1 nos estudiamos donde está la dirección de la tabla de nombres en VRAM
    ;2.obtenemos el número de tile que keremos poner
    ld a,(screen)
    ld b, COMIENZO_TILE_NUMEROS
    add b
    ld hl, 6887 ;aki va la dirección de la tabla de nombres que keremos cambiar;6912(final de la tabla de nombres)-32(-1 fila)=6880+7
    call WRTVRM


    ld a,0
    ld (GRPACX),a ;GRPACX contiene la posición X del cursor en modo gráfico
    ld a,184
    ld (GRPACY),a
    ld hl, message_level
    call print

    ld a,58; posicionamos el cursor en la posición x 58
    ld (GRPACX),a
    ;metemos en b el valor correspondiente al 0 en la tabla ascii
    ld b,48
    ;para sumar a y b tendremos que echar mano de ld a
    ld a,(screen)
    add b
    call GRPPRT 

    ld a,80
    ld (GRPACX),a
    ld hl, message_score
    call print


    ld a,180
    ld (GRPACX),a
    ld hl, message_msx_spain
    call print

    ret

print:
    ld  a,(hl)          ; Lee el 1 byte de la dirección de la memoria indicada y lo almacena en el registro a del z80.
    and a               ; Actualiza la bandera z del registro F del z80 y la pone en 0 si no hay valor, and a también actualiza el flag c, p, v y s.
    ret z               ; Devuelve el cotrol al Main si la bandera z del registro F del z80 es 0
    call GRPPRT         ; Llama a la subrutina 0042h de la Bios la cual imprime el caracter almacenado en el registro a del z80
    inc hl              ; incrementa el puntero de los registros hl para que señale al siguiente byte
    jr print            ; Llama al métdo print para que lo vuelva a ejecutar
     








increase_screen:
    call BEEP
    call recolocate_player
    ld a,(IN_GAME_DIRECTION)
    add 1
    ld (IN_GAME_DIRECTION),a
    call BCLS   ;Apagamos la pantalla
    ld a,(screen)
    add 1
    ld (screen),a
    call hud
    ;cp 0
	;jr z, load_screen_0
    ;cp 1
	;jr z, load_screen_1
    ret
load_screen:
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




    
	include "src/vars_msxBios.asm"    
	include "src/vars_msxSystem.asm"    
	include "src/MSXBasic/player.asm"    
	include "src/MSXBasic/enemies.asm"    
;			mapas
;-----------------------------

FINAL:
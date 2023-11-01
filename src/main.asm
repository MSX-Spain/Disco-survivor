    output "main.bin"

    db   0FEh               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO             ; dirección de inicio
    dw   FINAL - 1          ; dirección final
    dw   MAIN               ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)
    
     
 
    org #c000              ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200
        
INICIO:


screen: db 0
message_level: db "Level",0
message_lives: db "Lives",0
message_score: db "Score",0
message_msx_spain: db "MSX spain",0 
map_buffer: ds 704 ;768-64 es el mapa o tabla de nombres de VRAM copiada aquí
Store_Sprite_Collision: db 0

MAIN:
	call create_player
	call create_enemy
    call hud
    call load_screen_0
	call main_loop
	ret

main_loop:
	halt
	call cursors
    call update_enemies
    call render_player
    call draw_enemies

	jr main_loop





kill_player
    call BEEP
    ret


cursors:
    ld a,0
    call GTSTCK
    
    cp 1
    jp z, move_player_up
    ;cp 2
    ;jp z, move_player_up_right
    cp 3
    jp z, move_player_right
    ;cp 4
    ;jp z, move_player_down_right
    cp 5
    jp z, move_player_down
    ;cp 6
    ;jp z, move_player_down_left
    cp 7
    jp z, move_player_left
    ;cp 8
    ;jp z, move_player_up_left
    ret


hud:
    ld a,10
    ld (GRPACX),a ;GRPACX contiene la posición X del cursor en modo gráfico
    ld a,180
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
    ld a,150
    ld (ix+player.y),a
    ld a,0
    ld (ix+player.x),a
    ld a,(screen)
    add 1
    ld (screen),a
    call BCLS   ;borramos la pantalla
    cp 0
	jp z, load_screen_0
    cp 1
	jp z, load_screen_1

       
    ret
load_screen_0:
    ;ponemos el mapa en el byffer para hacer las colisiones
    ld hl, map_screen0
    ld de, map_buffer 
    ld bc, 768-64
    LDIR
    ;ponemos el mapa en la VRAM
    ld hl, map_buffer
    ld de, 6144 
	;Le quitamos 64 ya que keremos pintar el HUD en las últimas 2 líneas de la pantalla
    ld bc, 768-64
    call  LDIRVM
    ret
load_screen_1:
    ld hl, map_screen1
    ld de, map_buffer 
    ld bc, 768-64
    LDIR
    ld hl, map_buffer
    ld de, 6144 
    ld bc, 768-64
    call  LDIRVM
    call hud
    ret



 




    
	include "src/vars_msxBios.asm"    
	include "src/vars_msxSystem.asm"    
	include "src/player.asm"    
	include "src/enemies.asm"    
;			mapas
;-----------------------------
map_screen0:
	include "src/maps/map-screen0.asm"
map_screen1:
	include "src/maps/map-screen1.asm"
 
FINAL:
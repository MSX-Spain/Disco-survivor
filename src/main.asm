    output "main.bin"

    db   0FEh               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO             ; dirección de inicio
    dw   FINAL - 1          ; dirección final
    dw   MAIN               ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)
    
     
 
    org #c000              ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200
        
INICIO:


screen: db 0
message_lives: db "Lives",0
message_score: db "Score",0
message_msx_spain: db "MSX spain",0

MAIN:
	call initialize_player
	call initialize_enemy
    call hud
	call main_loop
	ret

main_loop:
	halt
	call cursors
	call update_player
    push ix
    call update_enemy
    pop ix
	jr main_loop


load_screen:
    ld a,(screen)
    cp 1
	jp z, load_screen_1
    ret
load_screen_1:
    ld hl, map_screen1
    ld de, 6144 
    ld bc, 768
    call  LDIRVM
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
    ld hl, message_lives
    call print
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
     















    
	include "src/vars_msxBios.asm"    
	include "src/vars_msxSystem.asm"    
	include "src/player.asm"    
	include "src/enemies.asm"    
tileset_definition:
	include "src/tileset-definition.asm"
tileset_color:
	include "src/tileset-color.asm"
sprites_definition:
	include "src/spriteset.asm"

;			mapas
;-----------------------------
map_screen1:
	include "src/map-screen1.asm"
 
FINAL:
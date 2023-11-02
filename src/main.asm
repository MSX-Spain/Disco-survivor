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
    call ENASCR; encendemos la pantalla
	call main_loop
	ret

main_loop:
	halt
	call update_player
    call update_enemies
    call render_player
    call draw_enemies

	jr main_loop





kill_player
    call BEEP
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

    ;y       db      0
    ;x       db      0
    ;sprite  db      0
    ;color   db      0
    ;plane   db      0
    ;type    db      0

    ld iy, template_enemy0
    ld a,100;y
    ld (iy+enemy.y),a
    ld a,8;x
    ld (iy+enemy.x),a

    ld iy, template_enemy0+(size_of_enemy*1)
    ld a,100;y
    ld (iy+enemy.y),a
    ld a,40;x
    ld (iy+enemy.x),a

    ld iy, template_enemy0+(size_of_enemy*2)
    ld a,110;y
    ld (iy+enemy.y),a
    ld a,200;x
    ld (iy+enemy.x),a

    
    ld iy, template_enemy0+(size_of_enemy*3)
    ld a,100;y
    ld (iy+enemy.y),a
    ld a,0;x
    ld (iy+enemy.x),a
    ld a,2;x
    ld (iy+enemy.type),a
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
    output	"main.com"
	
	; la cabecera de los archivos com siempre es la misma, por favor ver https://www.faq.msxnet.org/suffix.html
	org		#100

    include "src/MSXDos/data.sym"

    LD			HL, inicializacion_tileset_definition+7
	LD			DE, #c000
	LD			BC, fin_inicializacion_tileset_definition - inicializacion_tileset_definition
	LDIR
	LD			HL, inicializacion_tileset_color+7
	LD			DE, #c500
	LD			BC, fin_inicializacion_tileset_color - inicializacion_tileset_color
	LDIR
	LD			HL, inicializacion_sprites+7
	LD			DE, #d000
	LD			BC, fin_inicializacion_sprites - inicializacion_sprites
	LDIR
    ;
	call set_screen2x16
	call load_sprites	
	call load_tileset




    LD			HL, inicializacion_variables
	LD			DE, #c000
	LD			BC, fin_inicializacion_variables - inicializacion_variables
	LDIR
    call load_screen1
    ld a,1
    ld (IN_GAME_DIRECTION),a
	call create_player
	call create_enemy
    call hud

    ;call ENASCR; encendemos la pantalla
	

	

main_loop:
	halt
	call update_player
    call update_enemies
    call render_player
    call draw_enemies
    ;ld a, (IN_GAME_DIRECTION)
    ;cp 2
    ;jr z, .end_game
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
    ld ix, BEEP
	ld iy, (SLOT0)	    
	call CALSLT	
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
    ;call WRTVRM
    ld ix, WRTVRM	  
    ld iy, (SLOT0)	  
	call CALSLT	


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
    ;call GRPPRT 
    ld ix, GRPPRT	  
    ld iy, (SLOT0)	  
	call CALSLT	

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
    ;call GRPPRT         ; Llama a la subrutina 0042h de la Bios la cual imprime el caracter almacenado en el registro a del z80
    ld ix, GRPPRT	  
    ld iy, (SLOT0)	  
	call CALSLT	
    inc hl              ; incrementa el puntero de los registros hl para que señale al siguiente byte
    jr print            ; Llama al métdo print para que lo vuelva a ejecutar
     






increase_screen:
    ;call BEEP
    ld ix, BEEP	  
    ld iy, (SLOT0)	  
	call CALSLT	
    call recolocate_player

    
    ;call BCLS   ;Apagamos la pantalla
    ld ix, BCLS	  
    ld iy, (SLOT0)	  
	call CALSLT	
    ld a,(screen)
    add 1
    ld (screen),a
    
    cp 1
	call z, load_screen_1
    cp 2
	call z, load_screen_2
    cp 3
	call z, load_screen_3
    cp 4
	call z, load_screen_4
    cp 5
	call z, load_screen_5
    ret


load_screen_1:
    ld hl, map_screen1
    call load_screen
    ret
load_screen_2:
    ld hl, map_screen2
    call load_screen
    ret
load_screen_3:
    ld hl, map_screen3
    call load_screen
    ret
load_screen_4:
    ld hl, map_screen4
    call load_screen
    ret
load_screen_5:
    ld a,0
    ld (GRPACX),a ;GRPACX contiene la posición X del cursor en modo gráfico
    ld a,100
    ld (GRPACY),a
    ld hl, message_game_completed
    call print
    ld a,1
    ld (screen),a
    ;call show_menu
    ret
load_screen:
    ld de, map_buffer 
    ld bc, 768-64
    ldir

    ld hl, map_buffer
    ld de, 6144 
    ld bc, 768-64
    ;call  LDIRVM
    ld ix, LDIRVM	  
    ld iy, (SLOT0)	  
	call CALSLT	
    call hud
    ret


    


    include "src/MSXDos/loader.asm"
	include "src/MSXDos/player.asm"    
	include "src/MSXDos/enemies.asm"    

inicializacion_variables:
	incbin	"src/ROM32/data.dat"
fin_inicializacion_variables:



	include "src/MSXDos/spriteset.sym" 
	include "src/MSXDos/tileset-definition.sym" 
	include "src/MSXDos/tileset-color.sym" 
inicializacion_sprites:
	incbin	"src/MSXDos/spriteset.bin"
fin_inicializacion_sprites:
inicializacion_tileset_definition:
	incbin	"src/MSXDos/tileset-definition.bin"
fin_inicializacion_tileset_definition:
inicializacion_tileset_color:
	incbin	"src/MSXDos/tileset-color.bin"
fin_inicializacion_tileset_color:

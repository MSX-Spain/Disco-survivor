    output	"main.rom"
  
	org		#4000
			
		;Cabecera
		db "AB"
		word MAIN
		word 0,0,0,0,0,0
    
MAIN:
	;Rollo necesario para utilizar 32K
	di	;desactivamos las interrupciones
	im 1; vamos a utilizar el modo de interrupción 1
	ld sp, #F380
   

    ;El valor de #a8 (en MSXBasic) con un disco metido es:00F0h, 240u, 240i, '.', 00000000 1111 0000
    ;El valor de #a8 (en MSXDos) con un disco metido es:   00FFh, 255u, 255i, '.', 00000000 1111 1111   
    ;El valor de #a8 (en ROM) con un cartucho metido es:   00F4h, 244u, 244i, '.', 00000000 1111 0100
    ;Tenemos qe hacer esto:
    ;Page	
    ;	---------			---------------------------------           	---------			---------------------------------   
    ;	|	1	|			|		|		|		|		|           	|	1	|			|		|		|		|		|
    ;3	|	1	|			|		|		|		|	X	|            3	|	1	|			|		|		|		|	X	|
    ;	---------			---------------------------------           	---------			---------------------------------
    ;	|	1	|			|		|		|		|		|           	|	0	|			|		|		|		|		|
    ;2	|	1	|			|		|		|		|	X	| queremos esto |   1	|		    |		|	X	|		|		|		    
    ;	---------			--------------------------------- -------->    	---------			---------------------------------
    ;	|	0	|			|		|		|		|		|            	|	0	|			|		|		|		|		|
    ;1	|	1	|			|		|	X	|		|	 	|            1	|	1	|			|		|	X	|		|	 	|
    ;	---------			---------------------------------               ---------			---------------------------------
    ;	|	0 	|			|		|		|		|		|           	|	0 	|			|		|		|		|		|
    ;0	|	0	|			|	X	|		|		|	 	|            0	|	0	|			|	X	|		|		|	 	|
    ;	---------			---------------------------------               ---------            --------------------------------- 
    ;					 Slot   0        1		2		3


	call RSLREG;#0138;leemos el puerto a8 que es el que contiene la configuración de los slots con un cartucho conectado
	rrca 
	rrca ; lo movemos 2 veces de forma circular a la derecha 1111 0100->0111 1010->0011 1101, en el bit 0 y 1 tenemos el valor 01 que es donde está nuestro cartucho
	and #03 ; al hacer 0011 1101 and 0000 0011 tenemos 0000 0001

	; Vamos a ver si tiene la memoria expandida el cartucho
	ld 	    c, a; conservamos el valor 01 en el registro c
	ld 	    hl, (SLOT0); en #fcc1 se guarda la información que te dice se el slot 0 tiene la memoria expandida (o que tiene sublots)
	add     a, l
	ld 	    l, a;
	ld 	    a, (hl);Obtenemos si nuestro cartucho tiene la meoria expandida o no
	and     #80 ; al hacerle a nuestro valor (el valor del slot del cartucho) un and 1000 0000 obtenemos si está expandido (un 1) o no (un 0)
	or 	    c
	ld 	    c, a
	inc     l
	inc     l
	inc     l
	inc     l
	ld 	    a, (hl)

    ;ENASLT cambia el slot a la pagina indicada para siempre, pero necesita tener en H los bits 6  7 configurados y en A una configuración de bits rara
	;Input    : A - Slot ID
    ;           A - ExxxSSPP  Slot-ID
    ;               |   ││└┴─ Primary slot number (00-11), 00 para la página 0, 01 página 1 ,10 página 2 y 11 página 3
    ;               |   └┴─── Secondary slot number (00-11), si está expandido cual de los 4 subslots es
    ;               |________ Expanded slot (0 = no, 1 = yes), te dice si el slot está expandido o no
    ;           H - Bit 6 and 7 must contain the page number 
    ;               01 será para la página 1, 10 para la página 2, 11 para la página 3  
	AND 		#0C; 0c=0000 1100
	OR 			 C ;al hacer or c le añadimos al registro A el valor de 0001 1001
	LD 			 H, #80; en H le ponemos la page que nos interesa mover en nuestro (10 que es la página 2)
	CALL 		ENASLT;#0024 
	EI

    call DISSCR ;apagamos la pantalla
    call carga_valores_iniciales_variables
	call set_screen2x16
	call load_sprites	
	call load_tileset
	call create_player
	call create_enemy
    call hud
    call load_screen_1
    call ENASCR; encendemos la pantalla
    ld a,1
    ld (IN_GAME),a;controla que esté en juego
	call main_loop
	ret
;;=====================================================
;;Cargar variables
;;=====================================================	
; función: 	subrutina para poder usar la página 2 de memoria
; entrada: 	
; salida: 	
carga_valores_iniciales_variables:
		LD			HL, inicializacion_variables
		LD			DE, #C000
		LD			BC, fin_inicializacion_variables - inicializacion_variables
		LDIR
fin_carga_valores_iniciales_variables:
		RET


main_loop:
	halt
	call update_player
    call update_enemies
    call render_player
    call draw_enemies
    ;ld a, (screen) ; controla que se haya llegado al final
    ;cp NUMERO_PANTALLAS_JUEGO
    ;jr z, .end_game
	jr main_loop
.end_game:
    ;ld a,1
    ;ld (screen),a
    ret


kill_player
    call BEEP
    ret








;;=====================================================
;;   GETBLOCK=Hace esta formula (y/8)*32+(x/8)
;;=====================================================
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

    
    call BCLS   ;Apagamos la pantalla
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
    call  LDIRVM
    call hud
    ret





    ;como queremos utilizar la page 2 (a partir de la dirección #c000 tenemos que cargarlo así)
	include "src/ROM32/data.sym"
    include "src/ROM32/loader.asm"  
	include "src/ROM32/player.asm"    
	include "src/ROM32/enemies.asm"  

tileset_definition:
	include "./src/tileset-definition.asm"    
tileset_color:
	include "./src/tileset-color.asm"
sprites_definition:
	include "./src/spriteset.asm" 



inicializacion_variables:
	incbin	"src/ROM32/data.dat"
fin_inicializacion_variables:



relleno_de_bytes:
		ds	#c000-$		;desde 4000 hasta c000 rellena los bytes con datos;32k
		;ds	#8000-$		;desde 4000 hasta 8000 rellena los bytes con datos;16kb
		;ds	#6000-$ 	;para una ROM de 8KB

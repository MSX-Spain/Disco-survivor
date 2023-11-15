    output "loader.bin"

    db   0FEh               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO             ; dirección de inicio
    dw   FINAL - 1          ; dirección final
    dw   MAIN               ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)
    
     
 
    org #8500              ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200
        
INICIO:
screen: db 1
in_game: db 0
lives: db 8
score: db 1,0

;esta es la entrada principal
MAIN:
 	call KILBUF ; limpiamos el buffer, por si vlvemos a empezar
 	call ERAFNK ; kitamos las letras de las teclas función
    ld a,1
    ld (#fcaa),a; borramos el cursor

    ld a,1      ;cambiamos a screen 1 ya que para cargar la pantalla de carga hemos tenido que poner el 2
    call CHGMOD

    call show_menu ; mostramos el menu
    ld a,1
    ld (in_game),a ; ponemos la variable que le dice al juego que está en marcha a 1
	;CALL inicilizar_tracker
loop:	
	xor a
	call GTTRIG
	;GTTRIG devuelve 255 si está presionada y 0 sino lo está
	cp 0
	jp z, loop
	
		
	call set_screen2_16x16
    call DISSCR ;apagamos la pantalla, la encendermos en el main.asm
	call load_sprites
	call load_tileset


	;call para_cancion


	ret





	
load_tileset:
	;banco 0
	;la rutina LDIRVM necesita haber cargado previamente con de la dirección de inicio de la VRAM.https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png,así es como está formado el VDP en screen 2          
	ld hl, tileset_definition
	ld de, 0 ; aquí es posible utilizar la variable del sistema GRPCGP
	ld bc, 1024  ; son los 8 bytes por 128 tiles que hemos dibujado=1024 bytes
	call  LDIRVM 
	;banco 1
	ld hl, tileset_definition
	ld de, 2048
	ld bc, 1024 
	call  LDIRVM 
	;banco 2
	ld hl, tileset_definition
	ld de, 4096
	ld bc, 1024  
	call  LDIRVM 

	;banco 0
	ld hl, tileset_color
    ld de, 8192 ; aquí es posible utilizar la variable del sistema GRPCOL
    ld bc, 1024  
    call  LDIRVM 
	;banco 1
	ld hl, tileset_color
    ld de, 10240  
    ld bc, 1024  
    call  LDIRVM 
	;banco 2
	ld hl, tileset_color
    ld de, 12288  
    ld bc, 1024  
    call  LDIRVM 
	ret



set_screen2_16x16:
    ;poner los colores de tinta, fondo y borde
	ld      hl,FORCLR
	ld      [hl],15 ;le poneos el 15 en tinta que es el blanco
	inc     hl
	ld      [hl],1 ;le metemos 1 en fondo que es el negro
	inc		hl
	ld		[hl],1 ;en borde también el negro
	call    CHGCLR

	;click off	
	xor	a		
	ld	[CLIKSW],a
		
	;screen 2
	ld a,2
	call CHGMOD ;rutina de la bios que cambia el modo de screen

	;sprites no ampliados de 16x16
	ld b,0xe2
	ld c,1
	call WRTVDP

	ret

load_sprites:
    ;hemos dibujado 20 sprites
    ld hl, sprites_definition
    ld de, 14336; #3800, aquí es posible utilizar la variable del sistema GRPPAT
    ld bc, 32*22; 32 bytes por 22 sprites dibujados
    call  LDIRVM 
	ret

show_menu:
    ld h,10 ;x coordinate
    ld l,2  ;y coordinate
    call POSIT
    ld hl, message_msx_spain
    call text_mode_print

    ld h,12 ;x coordinate
    ld l,5  ;y coordinate
    call POSIT
    ld hl, message_disco
    call text_mode_print

    ld h,8  ;x coordinate
    ld l,12  ;y coordinate
    call POSIT
    ld hl, message_start_game
    call text_mode_print

    ld h,3  ;x coordinate
    ld l,19 ;y coordinate
    call POSIT
    ld hl, message_press_any_key_to_start
    call text_mode_print

    ret
text_mode_print:
    ld  a,(hl)          
    and a               
    ret z               
    call CHPUT         
    inc hl              
    jr text_mode_print   


message_msx_spain_presents: db "MSX spain presents",0
message_disco: db "Disco",0
message_start_game: db "1.Start game",0
message_press_any_key_to_start: db "Press any key to start",0
message_msx_spain: db "MSX spain",0 


    
	include "src/vars_msxBios.asm"    
	include "src/vars_msxSystem.asm"    

	include "src/tileset-definition.asm"
	include "src/tileset-color.asm"
	include "src/spriteset.asm"


 
FINAL:
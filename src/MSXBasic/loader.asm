    output "loader.bin"

    db   0FEh               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO             ; dirección de inicio
    dw   FINAL - 1          ; dirección final
    dw   MAIN               ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)
    
     
 
    org #8500              ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200
        
INICIO:
screen: db 0
game_over: db 0
lives: db 0
score: db 0,0
in_game: db 0
;esta es la entrada principal
MAIN:
    call load_screen_loader_full
    ;le ponemos un pequeño retraso
    ld de,#70
wait:    
    halt
    dec de
    ld a,d
    or e
    jp nz,wait



 	call KILBUF ; limpiamos el buffer, por si vlvemos a empezar
 	call ERAFNK ; kitamos las letras de las teclas función
    ld a,1
    ld (#fcaa),a; borramos el cursor

    ld a,1      ;cambiamos a screen 1 ya que para cargar la pantalla de carga hemos tenido que poner el 2
    call CHGMOD

    call show_menu ; mostramos el menu
	;CALL para_cancion
loop_menu:	
	xor a
	call GTTRIG
	;GTTRIG devuelve 255 si está presionada y 0 sino lo está
	cp 0
	jp z, loop_menu
	call set_screen2_16x16
    call DISSCR ;apagamos la pantalla, la encendermos en el main.asm
	call load_sprites
	call load_tileset
	ret

load_screen_loader_full:
    ;ld hl,loader_screen+7;sumamos +7 sin comprensión
    ld hl,loader_screen;saltamos los 7 primeros bytes de la cabecera del bin
    ld de,0
    ld bc, #3807
    call depack_VRAM
    ;call LDIRVM
    ret
	
load_tileset:
	;banco 0
	;la rutina LDIRVM necesita haber cargado previamente con de la dirección de inicio de la VRAM.https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png,así es como está formado el VDP en screen 2          
	ld hl, tileset_definition
	ld de, 0 ; aquí es posible utilizar la variable del sistema GRPCGP
	ld bc, 1280  ; son los 8 bytes por 160 tiles que hemos dibujado=1280 bytes
	call  LDIRVM 
	;banco 1
	ld hl, tileset_definition
	ld de, 2048
	ld bc, 1280 
	call  LDIRVM 
	;banco 2
	ld hl, tileset_definition
	ld de, 4096
	ld bc, 1280  
	call  LDIRVM 

	;banco 0
	ld hl, tileset_color
    ld de, 8192 ; aquí es posible utilizar la variable del sistema GRPCOL
    ld bc, 1280  
    call  LDIRVM 
	;banco 1
	ld hl, tileset_color
    ld de, 10240  
    ld bc, 1280  
    call  LDIRVM 
	;banco 2
	ld hl, tileset_color
    ld de, 12288  
    ld bc, 1280  
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
    ld bc, 32*47; 32 bytes por 47 sprites dibujados
    call  LDIRVM 
	ret

show_menu:
    ld h,5 ;x coordinate
    ld l,2  ;y coordinate
    call POSIT
    ld hl, message_msx_spain_presents
    call text_mode_print

    ld h,12 ;x coordinate
    ld l,5  ;y coordinate
    call POSIT
    ld hl, message_disco
    call text_mode_print

    ld h,1  ;x coordinate
    ld l,7  ;y coordinate
    call POSIT
    ld hl, message_description
    call text_mode_print

    ld h,1  ;x coordinate
    ld l,13  ;y coordinate
    call POSIT
    ld hl, message_description_english
    call text_mode_print

    ld h,3  ;x coordinate
    ld l,20 ;y coordinate
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
message_description: db "Deberas de recoger todas las botellas, 100 botellas suman 1 vida y ligarte a las chicas que veas, despues escapa por la salida",0
message_description_english: db "You must collect all the bottles, 100 bottles add up to 1 life and flirt with the girls you see, then escape through the exit",0
message_press_any_key_to_start: db "Press any key to start",0



;includes para sjasmplus
	include "src/vars_msxBios.asm"    
	include "src/vars_msxSystem.asm"    
	include "src/tileset-definition.asm"
	include "src/tileset-color.asm"
	include "src/spriteset.asm"
    include "./src/musicint.asm"
depack_VRAM:
    include "src/PL_VRAM_Depack.asm"
loader_screen:
    incbin "./assets/DISCOIM.S02.plet5";creado con pletter5b.exe


FINAL:
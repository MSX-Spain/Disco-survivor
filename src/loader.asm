    output "loader.bin"

    db   0FEh               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO             ; dirección de inicio
    dw   FINAL - 1          ; dirección final
    dw   MAIN               ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)
    
     
 
    org #c000              ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200
        
INICIO:

;esta es la entrada principal
MAIN:
 	call set_screen2x16
	call load_sprites
	call load_tileset
	;call load_screen_0
	ret






	
load_tileset:
	;banco 0
	ld hl, tileset_definition 
	ld de, 0  ; la rutina LDIRVM necesita haber cargado previamente con de la dirección de inicio de la VRAM.https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png,así es como está formado el VDP en screen 2          
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
    ld de, 8192  
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

;load_screen_0:
;    ld hl, map_screen0
;    ld de, 6144 
;	;Le quitamos 64 ya que keremos pintar el HUD en las últimas 2 líneas de la pantalla
;    ld bc, 768-64
;    call  LDIRVM
;    ret

set_screen2x16:
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
    ld de, 14336; #3800
    ld bc, 32*20
    call  LDIRVM 
	ret



    
    
	include "src/vars_msxBios.asm"    
tileset_definition:
	include "src/tileset-definition.asm"
tileset_color:
	include "src/tileset-color.asm"
sprites_definition:
	include "src/spriteset.asm"

;			mapas
;-----------------------------
;map_screen0:
;	include "src/map-screen0.asm"
 
FINAL:
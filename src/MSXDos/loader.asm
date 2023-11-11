    output	"loader.com"
	
	; la cabecera de los archivos com siempre es la misma, por favor ver https://www.faq.msxnet.org/suffix.html
	org		#100

;esta es la entrada principal
main:
	call set_screen2x16
	call load_sprites	
	call load_tileset
	ret





	
load_tileset:

	
	ld hl, tileset_definition
	ld de, 0 ; aquí es posible utilizar la variable del sistema GRPCGP
	ld bc, 1024  ; son los 8 bytes por 128 tiles que hemos dibujado=1024 bytes
	ld ix, LDIRVM	
	ld iy, (SLOT0)	    
	call CALSLT	
	;call LDIRVM	

	;banco 1
	ld hl, tileset_definition
	ld de, 2048
	ld bc, 1024 
	ld ix, LDIRVM	  
	ld iy, (SLOT0)	  
	call CALSLT		

	;banco 2
	ld hl, tileset_definition
	ld de, 4096
	ld bc, 1024  
	ld ix, LDIRVM	   
	ld iy, (SLOT0)	 
	call CALSLT		

	;banco 0
	ld hl, tileset_color
    ld de, 8192 ; aquí es posible utilizar la variable del sistema GRPCOL
    ld bc, 1024  
	ld ix, LDIRVM	 
    ld iy, (SLOT0)	   
	call CALSLT		
	;banco 1
	ld hl, tileset_color
    ld de, 10240  
    ld bc, 1024  
	ld ix, LDIRVM	  
    ld iy, (SLOT0)	  
	call CALSLT		
	;banco 2
	ld hl, tileset_color
    ld de, 12288  
    ld bc, 1024  
	ld ix, LDIRVM
    ld iy, (SLOT0)	
	call CALSLT	


	ret


set_screen2x16:
    ;poner los colores de tinta, fondo y borde
	ld      hl,FORCLR ;FORCLR es una variable del sistema
	ld      [hl],15 ;le poneos el 15 en tinta que es el blanco
	inc     hl
	ld      [hl],1 ;le metemos 1 en fondo que es el negro
	inc		hl
	ld		[hl],1 ;en borde también el negro
	ld ix, CHGCLR	; Vamos a https://map.grauw.nl/resources/msxbios.php y ponemos en ix la instrucción de la bios
	ld iy, (SLOT0)	; ponemos para que el MSX vea el slot donde está la bios
	call CALSLT		; Ejecutamos una llamada intersolt

	;click off	
	xor	a		
	ld	[CLIKSW],a  ;CLIKSW es una variable del sistema

	ld a,2
	ld ix, CHGMOD	   
	ld iy, (SLOT0)	
	call CALSLT		


	;sprites no ampliados de 16x16
	ld b,0xe2
	ld c,1
	ld ix, WRTVDP	   
	ld iy, (SLOT0)	
	call CALSLT	


	ret

load_sprites:
	;ENASLT cambia el slot a la pagina indicada para siempre
	;Input    : A - Slot ID, see RDSLT
    ;           H - Bit 6 and 7 must contain the page number (00-11)
	;A  - ExxxSSPP  Slot-ID
    ;     |   ││└┴─ Primary slot number (00-11)
    ;     |   └┴─── Secondary slot number (00-11)
    ;     |──────── Expanded slot (0 = no, 1 = yes)

    ld hl, sprites_definition
    ld de, 14336; #3800, aquí es posible utilizar la variable del sistema GRPPAT
    ld bc, 32*22; 32 bytes por 22 sprites dibujados
	ld ix, LDIRVM	    
	ld iy, (SLOT0)	
	call CALSLT		
	

	ret









	include "src/vars_msxBios.asm"    
	include "src/vars_msxSystem.asm"    
	include "src/vars_msxDos.asm"    



tileset_definition:
	include "src/tileset-definition.asm"
tileset_color:
	include "src/tileset-color.asm"
sprites_definition:
	include "src/spriteset.asm"




 
FINAL:
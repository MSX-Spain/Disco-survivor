load_tileset:	
	ld hl, tileset_definition
	ld de, 0 ; aquí es posible utilizar la variable del sistema GRPCGP
	ld bc, 1024  ; son los 8 bytes por 128 tiles que hemos dibujado=1024 bytes
	call LDIRVM	

	;banco 1
	ld hl, tileset_definition
	ld de, 2048
	ld bc, 1024 
	call LDIRVM	

	;banco 2
	ld hl, tileset_definition
	ld de, 4096
	ld bc, 1024  
	call LDIRVM		

	;banco 0
	ld hl, tileset_color
    ld de, 8192 ; aquí es posible utilizar la variable del sistema GRPCOL
    ld bc, 1024  
	call LDIRVM		

	;banco 1
	ld hl, tileset_color
    ld de, 10240  
    ld bc, 1024  
	call LDIRVM	

	;banco 2
	ld hl, tileset_color
    ld de, 12288  
    ld bc, 1024  
	call LDIRVM	

	ret


set_screen2x16:
    ;poner los colores de tinta, fondo y borde
	ld      hl,FORCLR ;FORCLR es una variable del sistema
	ld      [hl],15 ;le poneos el 15 en tinta que es el blanco
	inc     hl
	ld      [hl],1 ;le metemos 1 en fondo que es el negro
	inc		hl
	ld		[hl],1 ;en borde también el negro
	call CHGCLR

	;click off	
	xor	a		
	ld	[CLIKSW],a  ;CLIKSW es una variable del sistema

	ld a,2
	call CHGMOD

	;sprites no ampliados de 16x16
	ld b,0xe2
	ld c,1
	call WRTVDP
	ret

load_sprites:
    ld hl, sprites_definition
    ld de, 14336; #3800, aquí es posible utilizar la variable del sistema GRPPAT
    ld bc, 32*22; 32 bytes por 22 sprites dibujados
	call LDIRVM
	ret







 


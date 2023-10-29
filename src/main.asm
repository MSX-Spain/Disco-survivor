    output "main.bin"
	include "src/vars_msxBios.asm"   
    db   0FEh               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO             ; dirección de inicio
    dw   FINAL - 1          ; dirección final
    dw   MAIN               ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)
    
     
 
    org #c000              ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200
        
INICIO:

MAIN:
	call mensaje
	call bucle
	ret

mensaje:
	ld a,'h'
	call CHPUT 
	ld a,'o'
	call CHPUT 
	ld a,'l'
	call CHPUT 
	ld a,'a'
	call CHPUT 
	ret

bucle:
	jr bucle


    
    
    
   
     
 
FINAL:
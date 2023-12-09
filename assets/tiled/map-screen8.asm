    output "map-screen8.bin"

    db   0FEh               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO            ; dirección de inicio
    dw   FINAL - 1          ; dirección final
    dw   MAIN              ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)
    
     
 
    org #c000            ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200
        
INICIO:
MAIN:
	ret


SCREEN_8:
	db 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	db 65,65,65,65,32,32,32,65,65,65,65,32,32,32,32,65,65,65,65,32,32,65,65,65,65,32,32,32,32,65,65,65
	db 32,32,32,32,32,32,32,32,0,0,0,0,55,55,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	db 0,0,0,0,0,0,0,0,0,0,0,0,55,55,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	db 0,0,0,150,150,0,0,0,0,0,150,150,150,150,150,0,0,0,0,0,0,150,150,150,150,150,0,0,0,0,0,0
	db 0,0,150,150,150,150,0,45,46,150,150,150,150,150,150,150,0,57,0,0,150,150,150,150,150,150,150,0,0,0,57,0
	db 0,0,150,150,150,150,150,77,78,150,150,150,150,150,150,150,150,56,0,150,150,150,150,150,150,150,150,150,0,0,56,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,142,142,142,142,0,0,0,0,0,0,0,150,150,150,150,150,0,0,0,0,0,0,0,0,0,0,142,142,142,0
	db 142,142,142,142,142,142,43,44,0,0,0,150,150,150,150,150,150,150,150,150,0,0,0,0,0,0,142,142,142,142,142,142
	db 0,0,0,0,0,0,75,76,142,150,150,150,150,150,150,150,150,150,150,150,150,150,0,0,0,142,142,142,142,142,142,142
	db 0,57,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,39,40,0
	db 0,56,0,0,0,153,153,153,153,153,153,0,0,0,0,0,0,0,0,0,0,0,153,153,153,153,153,0,0,71,72,0
	db 0,0,0,153,153,153,153,153,153,153,153,153,153,0,0,0,0,0,0,0,153,153,153,153,153,153,153,153,153,0,0,0
	db 49,50,153,153,153,153,153,153,153,153,153,153,153,153,0,0,0,0,153,153,153,153,153,153,153,153,153,153,153,153,153,0
	db 81,82,0,0,0,0,0,39,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,71,72,0,0,0,0,0,0,0,0,0,0,45,46,0,0,0,0,0,0,0,0,0,57,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,131,131,0,0,0,0,0,77,78,0,0,0,0,131,131,0,0,0,56,0
	db 0,0,0,0,0,0,0,0,0,0,131,131,131,131,131,131,0,0,0,0,0,0,0,0,131,131,131,131,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,131,131,131,131,131,131,131,131,0,0,0,0,0,131,131,131,131,131,131,131,131,131,0
	db 0,0,0,0,0,0,0,131,131,131,131,131,131,131,131,131,131,131,131,0,0,131,131,131,131,131,131,131,131,131,131,131
	db 153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153,153


	
FINAL:
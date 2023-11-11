    output "screen11.bin"

    db   0FEh               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO             ; dirección de inicio
    dw   FINAL - 1          ; dirección final
    dw   MAIN               ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)
    
     
 
    org #d100            ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200
        
INICIO:
MAIN:
	ret
SCREEN_11:
	db 38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38
	db 38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38
	db 38,38,38,38,38,38,38,38,38,38,38,38,38,38,100,119,104,115,38,38,38,38,38,38,38,38,38,38,38,38,38,38
	db 38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38
	db 38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,54,54,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38
	db 38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,54,55,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38
	db 38,38,38,38,38,38,38,38,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,38,38,38,38,38,38,38,38
	db 38,38,38,38,38,38,38,3,0,3,0,3,0,3,0,3,0,3,0,3,0,3,0,3,0,38,38,38,38,38,38,38
	db 38,38,38,38,38,38,3,0,3,0,3,0,36,36,36,36,36,36,36,0,3,0,3,0,3,0,38,38,38,38,38,38
	db 38,38,38,38,38,3,0,3,0,3,0,3,36,36,36,36,36,36,36,0,3,0,0,3,0,3,0,38,38,38,38,38
	db 38,38,38,38,2,0,2,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,2,0,2,0,38,38,38,38
	db 38,38,38,2,0,2,0,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,0,2,0,2,0,38,38,38
	db 38,38,2,0,2,0,2,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,2,0,2,0,2,0,38,38
	db 38,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,38
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,47,48,0,0,0,0,0,0,59,58,0,0,0,57,0,1,0,1,0,1,0,0,41,42,0,0,0,0,0,0,0
	db 0,79,80,0,0,0,0,0,59,53,53,0,0,1,56,1,0,1,0,1,0,1,0,73,74,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,58,58,53,53,0,0,1,0,1,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,58,6,53,53,0,0,1,0,1,49,50,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,6,53,53,0,0,1,0,1,0,81,82,1,0,1,45,46,47,48,0,1,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,1,0,77,78,79,80,1,0,1,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,0,0,0,0
	;db 0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,0,0,0
	;db 0,0,0,0,0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,0,0

FINAL:
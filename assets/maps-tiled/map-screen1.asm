    output "screen1.bin"

    db   0FEh               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO             ; dirección de inicio
    dw   FINAL - 1          ; dirección final
    dw   MAIN               ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)
    
     
 
    org #c000            ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200
        
INICIO:
MAIN:
	ret


SCREEN_0_0:
	db 38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38
	db 38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38
	db 38,38,108,114,119,38,38,38,38,38,38,38,38,38,100,119,104,115,38,38,38,38,38,38,38,38,38,38,38,38,38,38
	db 38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38
	db 38,99,104,114,98,110,38,38,38,38,38,38,38,38,38,54,54,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38
	db 38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,54,55,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38
	db 38,38,38,38,38,38,38,38,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,38,38,38,38,38,38,38,38
	db 38,38,38,38,38,38,38,3,0,3,0,3,0,3,0,3,0,3,0,3,0,3,0,3,0,38,38,38,38,38,38,38
	db 38,38,38,38,38,38,3,0,3,0,3,0,35,35,35,35,35,35,35,0,3,0,3,0,3,0,38,38,38,38,38,38
	db 38,38,38,38,38,3,0,3,0,3,36,36,36,36,36,36,36,36,36,36,3,0,0,3,0,3,0,38,38,38,38,38
	db 38,38,38,38,2,0,2,0,2,36,36,36,36,36,36,36,36,36,36,36,36,0,2,0,2,0,2,0,38,38,38,38
	db 38,38,38,2,0,2,0,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,64,2,0,2,0,2,0,38,38,38
	db 38,38,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,64,2,0,2,0,2,0,38,38
	db 38,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,2,0,36,36,36,64,2,0,2,0,2,0,38
	db 55,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,36,36,36,0,0,0,0,0,0,0
	db 55,47,48,0,0,0,0,0,0,59,58,0,0,0,1,0,1,0,1,0,1,0,0,36,36,36,0,0,0,0,0,0
	db 0,79,80,0,0,0,0,0,59,53,53,0,0,1,0,1,0,1,0,1,0,1,0,0,36,36,36,0,0,0,0,0
	db 0,0,0,0,0,0,0,58,53,53,0,0,1,0,1,0,1,0,1,0,1,0,1,0,0,36,36,36,0,0,0,0
	db 0,0,0,0,0,0,59,53,53,0,0,1,0,1,49,50,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0
	db 0,0,0,0,57,0,53,53,0,0,1,0,1,0,81,82,1,0,1,45,46,47,48,0,1,0,0,0,0,0,0,0
	db 0,0,0,0,56,53,53,0,0,1,0,1,0,1,0,1,0,1,0,77,78,79,80,1,0,1,0,0,0,0,0,0
	db 0,0,0,59,53,53,0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,0,0,0,0
	;db0,0,0,53,53,0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,0,0,0
	;db0,0,53,53,0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,0,0
SCREEN_2:
	db 35,35,35,6,35,35,35,35,6,35,35,35,35,35,6,35,35,35,35,6,35,35,35,35,35,6,35,35,35,35,35,54
	db 35,35,35,6,35,35,35,35,6,35,35,35,35,35,6,35,35,35,35,6,35,35,35,35,35,6,35,35,35,35,35,54
	db 11,11,11,6,11,11,11,11,6,11,11,11,11,11,6,11,11,11,11,6,11,11,11,11,11,6,11,11,11,11,11,54
	db 11,11,11,6,11,11,11,11,6,11,11,11,11,11,6,11,11,11,11,6,11,11,11,11,11,6,11,11,11,11,11,54
	db 35,35,35,6,35,35,35,35,6,35,35,35,35,35,6,35,35,35,35,6,35,35,35,35,35,6,35,35,35,35,35,54
	db 35,35,35,6,35,53,53,35,6,35,35,54,54,35,6,35,35,35,35,6,35,54,54,35,35,6,35,35,53,53,35,54
	db 35,35,35,6,35,53,53,35,6,35,35,54,54,35,6,35,35,35,35,6,35,54,54,35,35,6,35,35,53,53,35,54
	db 34,34,34,6,34,53,55,34,6,34,34,54,55,34,6,34,34,34,34,6,34,54,55,34,34,6,34,34,53,55,34,54
	db 35,35,35,35,35,35,35,35,35,35,26,26,26,26,26,26,35,35,35,35,35,35,35,35,35,35,26,26,26,26,26,26
	db 26,35,35,35,35,35,35,35,35,35,35,26,26,26,26,26,26,35,35,35,35,35,35,35,35,35,35,26,26,26,26,26
	db 26,26,35,35,35,35,35,35,35,35,35,35,26,26,26,26,26,26,35,35,35,35,35,35,35,35,35,35,26,26,26,26
	db 26,26,26,35,35,35,35,35,35,35,35,35,35,26,26,26,26,26,26,35,35,35,35,35,35,35,35,35,26,26,26,26
	db 26,26,26,26,35,35,35,35,35,35,35,35,35,35,26,26,26,26,26,26,35,35,35,35,35,35,35,35,35,26,26,26
	db 26,26,26,26,26,35,35,35,35,35,35,35,35,35,35,26,26,26,26,26,26,35,35,35,35,35,35,35,35,35,26,26
	db 26,26,26,26,26,26,35,35,35,35,35,35,35,35,35,35,26,26,26,26,26,26,35,35,35,35,35,35,35,35,35,26
	db 35,26,55,26,26,26,26,35,35,35,35,35,35,35,35,35,35,26,49,50,26,26,26,35,35,35,35,35,35,35,35,35
	db 35,35,55,26,26,26,26,35,35,35,35,35,35,35,35,35,35,35,81,82,26,26,26,26,35,35,35,35,35,35,35,35
	db 35,35,35,26,26,26,26,26,35,35,35,26,26,26,35,35,35,35,35,26,26,26,26,26,26,35,35,26,26,26,35,35
	db 26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26
	db 26,26,26,26,26,41,42,26,26,26,26,26,26,26,26,26,26,26,26,26,26,39,40,26,26,26,26,26,26,26,26,26
	db 26,26,26,26,26,73,74,26,26,26,26,26,26,26,26,26,26,26,26,26,26,71,72,26,26,26,26,26,26,26,26,26
	db 35,35,35,35,35,35,35,35,35,35,35,26,26,26,35,35,35,35,35,35,35,35,35,35,35,35,35,26,26,26,35,35
	;db35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35
	;db35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35
SCREEN_3:
	db 34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,47,48,0,0,0,0,0,55,55,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,79,80,0,0,0,0,0,55,55,0,0,0,0,0
	db 0,34,34,34,34,34,34,34,34,34,0,0,34,34,34,34,34,34,34,34,0,0,34,34,34,34,34,34,34,0,0,0
	db 0,34,34,34,34,34,34,34,34,34,0,0,34,34,34,34,34,34,34,34,0,0,34,34,34,34,34,34,34,0,0,0
	db 0,34,34,34,34,34,34,34,34,34,47,48,34,34,34,34,34,34,34,34,0,0,34,34,34,34,34,34,34,0,0,0
	db 0,0,0,0,0,0,0,0,34,34,79,80,0,0,0,0,0,0,0,0,0,0,34,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,34,34,0,0,0,0,0,0,0,0,0,0,41,42,34,0,0,0,0,0,0,0,0,0
	db 53,34,34,20,0,0,0,0,34,34,0,0,0,0,0,0,0,0,0,0,73,74,34,0,0,0,0,0,0,19,53,53
	db 0,53,34,34,20,0,0,0,34,34,0,0,0,0,0,0,0,0,0,0,0,0,34,0,0,0,0,0,19,53,0,0
	db 0,0,53,34,34,20,0,0,0,0,0,0,0,0,0,0,0,0,0,39,40,0,0,0,0,0,0,19,53,0,0,0
	db 0,0,0,53,34,34,20,0,0,0,0,0,0,0,0,0,0,0,0,71,72,0,0,0,0,0,0,53,0,0,0,0
	db 0,0,0,0,53,34,34,34,34,34,34,34,34,34,34,34,0,0,34,34,34,34,34,34,34,34,34,53,0,0,0,0
	db 0,0,0,0,0,53,53,53,53,53,53,53,53,53,53,53,0,0,53,53,53,53,53,53,53,53,53,53,0,0,0,0
	db 55,0,0,0,0,0,0,0,0,0,0,0,0,0,0,41,42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 55,0,0,0,0,0,0,53,53,51,52,0,0,0,0,73,74,0,0,0,0,0,0,0,0,0,58,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,83,84,0,0,0,0,0,0,0,0,53,53,57,0,0,0,53,53,0,0,0,0,0
	db 0,0,59,0,0,0,0,0,0,58,0,0,0,0,0,59,0,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0
	db 0,0,53,0,0,0,0,0,0,53,53,0,0,0,53,53,0,0,0,0,0,53,53,0,0,0,0,53,53,53,0,0
	db 0,0,0,41,42,0,0,0,0,0,47,48,0,0,0,49,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,73,74,0,0,0,0,0,79,80,0,0,0,81,82,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
	;db26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26
	;db26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26
SCREEN_4:
	db 64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,51,52,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
	db 64,64,64,64,64,64,64,64,64,64,64,64,36,36,36,36,36,36,36,36,64,64,64,64,64,64,64,64,64,64,64,64
	db 64,64,64,64,64,64,64,64,64,64,64,36,36,36,36,36,36,36,36,36,36,64,64,64,64,64,64,64,64,64,64,64
	db 64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
	db 64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
	db 64,64,64,64,64,64,64,64,64,64,64,64,64,64,47,55,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
	db 64,64,64,64,64,64,64,64,64,64,64,64,64,64,79,55,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
	db 64,64,64,64,64,64,14,11,11,11,11,11,51,52,11,11,11,11,11,11,11,11,11,11,11,15,64,64,64,64,64,64
	db 64,64,64,64,64,14,11,11,43,44,11,11,83,84,11,11,11,11,51,52,11,11,11,11,11,11,15,64,64,64,64,64
	db 64,64,64,64,14,11,11,11,75,76,11,11,11,11,11,11,11,11,83,84,11,11,41,42,11,11,11,15,64,64,64,64
	db 64,64,64,64,11,11,11,11,11,11,11,49,50,11,11,41,42,11,11,49,50,11,73,74,11,11,11,11,64,64,64,64
	db 64,64,64,64,64,11,11,11,49,50,11,81,82,11,11,73,74,11,11,81,82,11,11,11,11,11,11,64,64,64,64,64
	db 64,64,64,64,64,64,11,11,81,82,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,64,64,64,64,64,64
	db 64,64,64,64,64,64,64,11,11,11,11,11,11,11,11,51,52,11,11,11,11,11,11,11,11,64,64,64,64,64,64,64
	db 64,64,64,64,64,64,64,64,11,11,11,11,11,11,11,83,84,11,43,44,11,11,11,11,64,64,64,64,64,64,64,64
	db 64,64,64,64,64,64,64,64,64,11,11,11,41,42,11,11,11,11,75,76,11,11,11,64,64,64,64,64,64,64,64,64
	db 64,64,64,64,64,64,64,64,64,64,11,11,73,74,11,49,50,11,11,11,11,11,64,64,64,64,64,64,64,64,64,64
	db 64,64,64,64,64,64,64,64,64,64,64,11,11,11,11,81,82,11,11,11,11,64,64,64,64,64,64,64,64,64,64,64
	db 64,64,64,64,64,64,64,64,64,64,64,64,11,11,11,11,11,11,11,11,64,64,64,64,64,64,64,64,64,64,64,64
	db 64,64,64,64,64,64,64,64,64,64,64,64,64,11,11,11,11,11,11,64,64,64,64,64,64,64,64,64,64,64,64,64
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,64,64,64,64,64,64,64,64,64,64,64,64,64
	db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,64,64,64,64,64,64,64,64,64,64,64,64,64
	;db64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
	;db64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
FINAL:
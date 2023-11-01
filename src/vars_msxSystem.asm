;variables del sistema


;Interruptions
;-------------------
;Contiene el valor del reloj del software, cada interrupción del VDP se incrementa en 1
;El contenido se puede leer o cambiar mediante la función 'TIME' o la instrucción 'TIME'
JIFFY  equ 0xFC9E
; Graphic variables  
;------------------- 
; posicionar cursor en modo gráfico              
GRPACX equ 0xFCB7  
GRPACY equ 0xFCB9
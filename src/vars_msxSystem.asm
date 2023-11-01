;variables del sistema
;https://www.msx.org/wiki/System_variables_and_work_area

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
;VDP registers
RG0SAV equ 0xF3DF   ;System saves here the byte written to the register R#00, Used by VDP(0)
RG1SAV equ 0xF3E0   ;System saves here the byte written to the register R#01, Used by VDP(1)
RG2SAV equ 0xF3E1   ;System saves here the byte written to the register R#02, Used by VDP(2)
RG3SAV equ 0xF3E2   ;System saves here the byte written to the register R#03, Used by VDP(3)
RG4SAV equ 0xF3E3   ;System saves here the byte written to the register R#04, Used by VDP(4)
RG5SAV equ 0xF3E4   ;System saves here the byte written to the register R#05, Used by VDP(5)
RG6SAV equ 0xF3E5   ;System saves here the byte written to the register R#06, Used by VDP(6)
RG7SAV equ 0xF3E6   ;System saves here the byte written to the register R#07.at start, Used by VDP(7)
STATFL equ 0xF3E7   ;System saves here the byte read from the status register R#00, Used by VDP(0)

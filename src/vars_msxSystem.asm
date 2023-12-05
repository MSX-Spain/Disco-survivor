;ver las instrucciones del z80
;ver las instruciones del z80: http://clrhome.org/table/
;variables del sistema
;https://www.msx.org/wiki/System_variables_and_work_area

;TRANSPARENT  equ  0
;BLACK        equ  1
;GREEN        equ  2
;LIGHT_GREEN  equ  3
;DARK_BLUE    equ  4
;LIGHT_BLUE   equ  5
;DARK_RED     equ  6
;CYAN         equ  7
;RED          equ  8
;LIGHT_RED    equ  9
;DARK_YELLOW  equ 10
;LIGHT_YELLOW equ 11
;DARK_GREEN   equ 12
;MAGENTA      equ 13
;GRAY         equ 14
;GREY         equ 14
;WHITE        equ 15

COLOR_TRASPARENTE: equ 0
COLOR_NEGRO: equ 1
COLOR_VERDE_MEDIO: equ 2
COLOR_VERDE_CLARO: equ 3
COLOR_AZUL_OSCURO: equ 4
COLOR_AZUL_MEDIO: equ 5
COLOR_ROJO_OSCURO: equ 6
COLOR_AZUL_CLARO:equ 7
COLOR_ROJO_MEDIO: equ 8
COLOR_ROSA: equ 9
COLOR_AMARILLO: equ 10
COLOR_AMBAR: equ 11
COLOR_VERDE_OSCURO: equ 12
COLOR_LILA: equ 13
COLOR_GRIS: equ 14
COLOR_BLANCO: equ 15

;Slots
;---------

;SLOTs
SLOT0 equ #FCC1
SLOT1 equ #FCC2
SLOT2 equ #FCC3
SLOT3 equ #FCC4

;Interruptions
;-------------------
;Contiene el valor del reloj del software, cada interrupción del VDP se incrementa en 1
;El contenido se puede leer o cambiar mediante la función 'TIME' o la instrucción 'TIME'
JIFFY  equ 0xFC9E

;Graphics
;-------------------
gxpos equ 0xfcb3
gypos equ 0xfcb5
bios_line equ 0x58C1


;VDP registers
;------------------- 
RG0SAV equ 0xF3DF   ;System saves here the byte written to the register R#00, Used by VDP(0)
RG1SAV equ 0xF3E0   ;System saves here the byte written to the register R#01, Used by VDP(1)
RG2SAV equ 0xF3E1   ;System saves here the byte written to the register R#02, Used by VDP(2)
RG3SAV equ 0xF3E2   ;System saves here the byte written to the register R#03, Used by VDP(3)
RG4SAV equ 0xF3E3   ;System saves here the byte written to the register R#04, Used by VDP(4)
RG5SAV equ 0xF3E4   ;System saves here the byte written to the register R#05, Used by VDP(5)
RG6SAV equ 0xF3E5   ;System saves here the byte written to the register R#06, Used by VDP(6)
RG7SAV equ 0xF3E6   ;System saves here the byte written to the register R#07.at start, Used by VDP(7)
STATFL equ 0xF3E7   ;System saves here the byte read from the status register R#00, Used by VDP(0)

;Screen Parameters
FORCLR equ 0xF3E9     ;Foreground colour
BAKCLR equ 0xF3EA     ;Background colour
BDRCLR equ 0xF3EB     ;Border colour
LINL40 equ 0xF3AE     ;Screen width per line in SCREEN 0 (Default 39)
LINL32 equ 0xF3AF     ;Screen width per line in SCREEN 1 (Default 29)
LINLEN equ 0xF3B0     ;Current screen width per line
CRTCNT equ 0xF3B1     ;Number of lines of current screen (default 24)
CLMLST equ 0xF3B2     ;X-location in the case that items are divided by commas in PRINT. (LINLEN-(LINLEN MOD 14)-14)
TXTNAM equ 0xF3B3     ;SCREEN 0 pattern name tabte address
TXTCOL equ 0xF3B5     ;SCREEN 0 color table address
TXTCGP equ 0xF3B7     ;SCREEN 0 Pattern generator table address
TXTATR equ 0xF3B9     ;Unused
TXTPAT equ 0xF3BB     ;Unused
T32NAM equ 0xF3BD     ;SCREEN 1 pattern name table address
T32COL equ 0xF3BF     ;SCREEN 1 color table address
T32CGP equ 0xF3C1     ;SCREEN 1 pattern ganarator table address
T32ATR equ 0xF3C3     ;SCREEN 1 sprite attribute table address
T32PAT equ 0xF3C5     ;SCREEN 1 sprite generator table address
GRPNAM equ 0xF3C7     ;SCREEN 2 pattern name table address
GRPCOL equ 0xF3C9     ;SCREEN 2 color table address
GRPCGP equ 0xF3CB     ;SCREEN 2 pattern generator table address
GRPATR equ 0xF3CD     ;SCREEN 2 sprite attribute table address
GRPPAT equ 0xF3CF     ;SCREEN 2 sprite generator table address
MLTNAM equ 0xF3D1     ;SCREEN 3 pattern name tabte address
MLTCOL equ 0xF3D3     ;SCREEN 3 color table address
MLTCGP equ 0xF3D5     ;SCREEN 3 pattern generator table address
MLTATR equ 0xF3D7     ;SCREEN 3 sprite attribute table address
MLTPAT equ 0xF3D9     ;SCREEN 3 sprite generator table address
TRCFLG equ 0xF7C4     ;Tracing flag. 0 = No tracing; Other = Tracing in progress
CGPNT  equ 0xF91F     ;Location of the character font used to initialise screen 
                      ;CGPNT = Slot ID
                      ;CGPNT+1 = Address
NAMBAS	equ 0xF922    ;Current pattern name table address
CGPBAS	equ 0xF924    ;Current pattern generator table address
PATBAS	equ 0xF926    ;Current sprite generator table address
ATRBAS	equ 0xF928    ;Current sprite attribute table address
CLOC	equ 0xF92A    ;Graphic cursor location
CMASK	equ 0xF92C    ;Graphic cursor mask (SCREEN 2 to 4) or ordinate (SCREEN 5 to 12)
DPPAGE	equ 0xFAF5    ;Displayed page number. (MSX2~)Modified by SETPAGE X
ACPAGE	equ 0xFAF6    ;Destination page number. (MSX2~)Modified by SETPAGE ,X
MODE	equ 0xFAFC    ;Flag for screen mode
                    ;bit 7: 1 = conversion to Katakana; 0 = conversion to Hiragana. (MSX2+~)
                    ;bit 6: 1 if Kanji ROM level 2. (MSX2+~)
                    ;bit 5: 0/1 to draw in RGB / YJK mode SCREEN 10 or 11. (MSX2+~)
                    ;bit 4: 0/1 to limit the Y coordinate to 211/255. (MSX2+~)
                    ;bit 3: 1 to apply the mask in SCREEN 0~3
                    ;bits 1-2: VRAM size
                    ;	   00 for 16kB
                    ;	   01 for 64kB
                    ;	   10 for 128kB
                    ;	   11 for 192kB
                    ;bit 0: 1 if the conversion of Romaji to Kana is possible. (MSX2~)
LINWRK	equ 0xFC18    ;40	Work area for screen management
PATWRK	equ 0xFC40    ;8	Returned character pattern by the routine GETPAT
GRPHED	equ 0xFCA6    ;1	Heading for the output of graphic characters
SCRMOD	equ 0xFCAF    ;1	Screen mode
OLDSCR	equ 0xFCB0    ;1	Old screen mode
NORUSE	equ 0xFAFD    ;1	Used by KANJI-ROM for rendering KANJI fonts in graphic modes. (MSX2~)
                    ;bit 7 Don't return to textmode
                    ;bit 6 if 1 and F7F4h (DECCNT)=0, read SHIFT status ???
                    ;bit 5 Disable some functinality
                    ;bit 4 Not in use	
                    ;bit 3 color 0 = Transparent
                    ;bit 0-2: Logical operation on kanji font draw
                    ;	  0 for PSET
                    ;	  1 for AND
                    ;	  2 for OR
                    ;	  3 for XOR
                    ;	  4 for NOT
LOGOPR  equ 0xFB02        ;1	Logical operation code. (MSX2~)
GXPOS	equ 0xFCB3        ;2	X-position of graphic cursor
GYPOS	equ 0xFCB5        ;2	Y-position of graphic cursor
GRPACX  equ 0xFCB7        ;2	X Graphics Accumulator, posicionar cursor en modo gráfico    
GRPACY  equ 0xFCB9        ;2	Y Graphics Accumulator, posicionar cursor en modo gráfico    



musica_activa:				DB		0
H.KEYI				equ     	#FD9A
H.TIMI	 			equ     	#FD9F

inicializa_replayer_efectos_interrupciones:
		DI
		
		LD		 A, (PT3_SETUP)
		AND		11111110b
		LD		(PT3_SETUP), A

		;inicializacion de replayer musical
		LD		HL, song-99			; hl <- initial address of module - 99
		CALL	PT3_INIT			; Inits PT3 player
		

		;Engancha nuestra rutina de servicio al gancho que deja preparado la BIOS cuando se termina de pintar la pantalla (50 o 60 veces por segundo)
		LD		A, #C3
		LD		[H.TIMI], A
		LD		HL, subrutina_isr
		LD		[H.TIMI+1], HL
	
		EI		;optimizacion:
				;piensa que las dos ultimas lineas podrian haber sido: 
				;ei						;primero ei
				;ld		[H.TIMI+1],hl	;luego este ld
										;PENSAR (y consultar ) PORQUE!!!!
;fin_inicializa_replayer_efectos_interrupciones:
	RET

;;=====================================================
;;NUESTRA_ISR
;;=====================================================	
; función: 	envía datos al PSG + toca un trozo de música + toca trozo de 
; entrada: 	-
; salida: 	-
; toca: 	HL, A
; nota importante: esta parte de código es del curso de ensamblador
;;por D. Fernando García (@BitVision) (al que siempre le estaré agradecido)
;;su difusión depende de su consentimiento o por lo menos de su mención como autor
subrutina_isr:
		CALL	PT3_ROUT			;envia los datos a los registros del PSG		
		
		CALL	PT3_PLAY		;calcula el siguiente 'trocito' de musica que sera enviado al proxima vez

ret
	
;;=====================================================
;;PLAY_MUSICA
;;=====================================================	
; función: 	toca la música que se le idique
; entrada: 	A
			;A=0 musica off
			;A=2 musica jefe
			;A=3 musica gameover
play_musica:
		LD			(musica_activa), A
		OR			 A
		JP			NZ, .mira_musica_normal
		CALL		PT3_MUTE
		RET
.mira_musica_normal:
		LD			HL, song-99			; hl <- initial address of module - 99
		JP			.fin_mira_posibles_musicas
.fin_mira_posibles_musicas:
		JP			inicializa_replayer_efectos_interrupciones
tracker:
	include	"./src/PT3_player.asm"					;replayer de PT3
song:
	incbin "./src/musicdisc.pt3"			;musica de ejemplo




FINAL:
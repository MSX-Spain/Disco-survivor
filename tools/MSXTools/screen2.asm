		 output screen2.bin
	db   #fe
	dw   INICIO 
	dw   FINAL
	dw   INICIO 
	org  #d000 
INICIO: 
	db 16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,47,48,0,0,0,0,0,55,55,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,79,80,0,0,0,0,0,55,55,0,0,0,0,0
	db 0,16,16,16,16,16,16,16,16,16,0,0,16,16,16,16,16,16,16,16,0,0,16,16,16,16,16,16,16,0,0,0
	db 0,16,16,16,16,16,16,16,16,16,0,0,16,16,16,16,16,16,16,16,0,0,16,16,16,16,16,16,16,0,0,0
	db 0,16,16,16,16,16,16,16,16,16,0,0,16,16,16,16,16,16,16,16,0,0,16,16,16,16,16,16,16,0,0,0
	db 0,0,0,0,0,0,0,0,16,16,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,16,16,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0
	db 53,16,16,20,0,0,0,0,16,16,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,19,53,53
	db 0,53,16,16,20,0,0,0,16,16,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,19,53,0,0
	db 0,0,53,16,16,20,0,0,0,0,0,0,0,0,0,0,0,0,0,39,40,0,0,0,0,0,0,19,53,0,0,0
	db 0,0,0,53,16,16,20,0,0,0,0,0,0,0,0,0,0,0,0,71,72,0,0,0,0,0,0,53,0,0,0,0
	db 0,0,0,0,53,16,16,16,16,16,16,16,16,16,16,16,0,0,16,16,16,16,16,16,16,16,16,53,0,0,0,0
	db 0,0,0,0,0,53,53,53,53,53,53,53,53,53,53,53,0,0,53,53,53,53,53,53,53,53,53,53,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,0,0,0,0,53,53,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,58,0,0,0,0,0
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,53,53,57,0,0,0,53,53,0,0,0,0,0
	db 0,0,59,0,0,0,0,0,0,58,0,0,0,0,0,59,0,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0
	db 0,0,53,0,0,0,0,0,0,53,53,0,0,0,53,53,0,0,0,0,0,53,53,0,0,0,0,53,53,53,0,0
	db 0,0,0,41,42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 0,0,0,73,74,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db 16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16
	db 26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26
	db 26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26
FINAL: 

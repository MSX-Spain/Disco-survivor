		 output screen3.bin
	db   #fe
	dw   INICIO 
	dw   FINAL
	dw   INICIO 
	org  #d000 
INICIO: 
	db 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	db 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,0,0,0,0,0,0,0,0,32,32,32,32,32
	db 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,0,0,0,0,0,0,0,0,32,32,32,32,32
	db 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,0,0,0,0,0,0,0,0,32,32,32,32,32
	db 32,32,32,32,32,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,32,32,32,32
	db 32,32,32,32,32,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,32,32,32,32,32
	db 32,32,32,32,32,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,32,32,32,32,32
	db 32,32,32,32,32,32,0,0,0,0,0,32,32,32,32,32,32,32,32,32,32,32,32,32,0,0,0,32,32,32,32,32
	db 32,32,32,32,32,32,0,0,0,0,0,32,32,32,32,32,32,32,32,32,32,32,32,32,0,0,0,32,32,32,32,32
	db 32,32,32,32,32,32,0,0,0,0,0,32,32,32,32,32,32,32,32,32,32,32,32,0,0,0,0,32,32,32,32,32
	db 32,32,32,32,32,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,32,0,0,0,0,32,32,32,32,32
	db 32,32,32,32,32,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,32,0,0,0,32,32,32,32,32,32
	db 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,0,0,0,32,32,0,0,0,32,32,32,32,32,32
	db 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,0,0,0,32,32,0,0,0,32,32,32,32,32,32
	db 32,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,32,0,0,0,32,32,32,32,32,32
	db 32,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,32,0,0,0,32,32,32,32,32,32
	db 32,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,32,0,0,0,32,32,32,32,32,32
	db 32,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,32,0,0,0,32,32,32,32,32,32
	db 32,32,0,0,0,0,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,0,0,0,32,32,32,32,32,32
	db 32,32,0,0,0,0,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,0,0,0,0,0,0,0,0,0
	db 32,32,0,0,0,0,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,0,0,0,0,0,0,0,54,54
	db 32,32,0,0,0,0,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,0,0,0,0,0,0,0,55,55
	db 32,32,0,0,0,0,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
	db 32,32,0,0,0,0,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
FINAL: 
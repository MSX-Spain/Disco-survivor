	output 	"data.dat"

;se posiciona el siguiente codigo (variables en la página 3)
	ORG		#C000

    include "./src/vars_msxBios.asm"    
	include "./src/vars_msxSystem.asm"    

;==============================================
;               Game
;==============================================

IN_GAME equ #ef00
NUMERO_PANTALLAS_JUEGO equ 4
COMIENZO_TILE_NUMEROS equ 86
TILE_DOOR equ 55
TILE_SOLID equ 32

screen: db 1
message_level: db "Level",0
message_lives: db "Lives",0
message_score: db "Score",0
message_msx_spain: db "MSX spain",0 
message_game_completed: db "Felicidades, te has pasado el juego!!!",0 
map_buffer: ds 704 ;768-64 es el mapa o tabla de nombres de VRAM copiada aquí
buffer_numeros: ds 8
Store_Sprite_Collision: db 0



map_screen1:
    include "assets/maps-tiled-data/map-screen1.asm"
map_screen2:
    include "assets/maps-tiled-data/map-screen2.asm"
map_screen3:
    include "assets/maps-tiled-data/map-screen3.asm"
map_screen4:
    include "assets/maps-tiled-data/map-screen4.asm"



;==============================================
;                   Player
;==============================================

;player_atributes:
    struct player 
y           db    0
x           db    0
plane       db    0
color       db    0
direction   db    0
collision   db    0
    ends
tile0: db 0

template_player:
    db 0
    db 0
    db 0;sprite 8 por 4 sprites, 32 dividido entre 4=8
    db 0;color azul oscuro
    db 0; plano 1*4 bytes
    db 0;move0_enemigo_corre_de_izquierda_a_derecha
    db 0
    db 0

;==============================================
;                   Enemies
;==============================================

MAX_RETARDO equ 60

    struct enemy 
y           db      0
x           db      0
sprite      db      0
color       db      0
plane       db      0
type        db      0
counter     db      0
frame    db      0
    ends


template_enemy1:
    db 130
    db 220
    db 32;sprite 8 por 4 sprites, 32 dividido entre 4=8
    db 4;color azul oscuro
    db 4; plano 1*4 bytes
    db 0;move0_enemigo_corre_de_izquierda_a_derecha
    db 0
    db 0
template_enemy2:
    db 100
    db 200
    db 44;44/4=11 sprite
    db 15;color azul oscuro
    db 8; plano 2*4 bytes
    db 1;move1_enemigo_corre_de_derecha_a_izquierda
    db 0
    db 0
template_enemy3:
    db 120
    db 80
    db 56;52/4 sprite 12 por 4 sprites
    db 3;verde claro
    db 12; plano 3*4 bytes
    db 3;
    db 0
    db 0
template_enemy4:
    db 144
    db 190
    db 64;52/4=13 sprite 8 por 4 sprites
    db 15;color azul oscuro
    db 16; plano 4*4 bytes
    db 3;move3_enemigo_baila
    db 0
    db 0
SIZE_OF_ENEMY equ 8
MAX_ENEMIES equ 4
enemy_active: db 0
;los tipos son: 
;   1.El enemigo va de derecha a izquierda corriendo
;   2.El enemigo está bailando

;reservamos espacio para 10 enemigos
;max_enemies equ 10
;array_enimies: ds enemy*max_enemies ;son 7 bytes * 10 entidades de enemigos=70 bytes, si te fijas enemy vale el tamaño del struct
counter_enemy: db 0
;randData solo es utilizada por la rutina random
randData: db 0,0
retardo_dibujo: db 0




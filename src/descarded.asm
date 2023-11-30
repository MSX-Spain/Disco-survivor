;quizás aquí se ve mejor el dibujado de los enemigos:

draw_enemies:
    ;6912 o #1b00 dirección tabla de atributos en VRAM donde están los atributos de y,x,sprite_definition, color
    ;el patron 0 es el del player, el enemigo 1 tendrá el 1 plano y como son 4 bytes cada plano(así está configurado el MSX)=6912+4
    ;como no podemos sumarle a de el patrón, lo hacemos a través de hl,
    
    ld iy, template_enemy1
    ld hl, 6912; aquí se podría poner la variable del sistema GRPATR
    ld l,(iy+enemy.plane)
    ;intercambiamos los valores para que tengamos en el registro "de" la dirección de la memoria que necesita LDIRVM
    ex hl,de
    ld hl, template_enemy1
    ld bc, 4; 4 bytes para copiar
    call  LDIRVM; ldirvm necesita en hl la dirección de memoria a copiar, en de la dirección de destino y en bc la cantidad ed bytes a copiar


    ld iy, template_enemy1+(SIZE_OF_ENEMY*1)
    ld hl, 6912
    ;ld l(ix+enemy.plane) hace la suma
    ld l,(iy+enemy.plane)
    ;intercambiamos los valores para que tengamos en el registro "de" la dirección de la memoria que necesita LDIRVM
    ex hl,de
    ld hl, template_enemy1+(SIZE_OF_ENEMY*1)
    ld bc, 4; 4 bytes para copiar
    call  LDIRVM 


    ld iy, template_enemy1+(SIZE_OF_ENEMY*2)
    ld hl, 6912
    ;ld l(ix+enemy.plane) hace la suma
    ld l,(iy+enemy.plane)
    ;intercambiamos los valores para que tengamos en el registro "de" la dirección de la memoria que necesita LDIRVM
    ex hl,de
    ld hl, template_enemy1+(SIZE_OF_ENEMY*2)
    ld bc, 4; 4 bytes para copiar
    call  LDIRVM 



    ld iy, template_enemy1+(SIZE_OF_ENEMY*3)
    ld hl, 6912
    ;ld l(ix+enemy.plane) hace la suma
    ld l,(iy+enemy.plane)
    ;intercambiamos los valores para que tengamos en el registro "de" la dirección de la memoria que necesita LDIRVM
    ex hl,de
    ld hl, template_enemy1+(SIZE_OF_ENEMY*3)
    ld bc, 4; 4 bytes para copiar
    call  LDIRVM 

    ret
    ;----------------------------------------------------------------------------------------------
recolocate_enemies:
    ld iy, template_enemy1
    ld a,7*8;y
    ld (iy+enemy.y),a
    ld a,20*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_ROBOT
    ld (iy+enemy.pattern_def),a
    ld a,COLOR_AZUL_MEDIO
    ld (iy+enemmy.color),a
    ld a, UP
    ld (iy+enemy.direction),a
    ld a, COMPORTAMIENTO_REBOTA_VERTICAL
    ld (iy+enemy.type),a


    ld iy, template_enemy2
    ld a,12*8;y
    ld (iy+enemy.y),a
    ld a,25*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a,COLOR_AZUL_OSCURO
    ld (iy+enemmy.color),a
    ld a, RIGHT
    ld (iy+enemy.direction),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    

    ld iy, template_enemy3
    ld a,13*8;y
    ld (iy+enemy.y),a
    ld a,28*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_COLETA
    ld (iy+enemy.pattern_def),a
    ld a,COLOR_ROJO_OSCURO
    ld (iy+enemmy.color),a
    ld a, RIGHT
    ld (iy+enemy.direction),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a


    ld iy, template_enemy4
    ld a,18*8;y
    ld (iy+enemy.y),a
    ld a,23*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_ENANO
    ld (iy+enemy.pattern_def),a
    ld a,COLOR_AMARILLO
    ld (iy+enemmy.color),a
    ld a, RIGHT
    ld (iy+enemy.direction),a
    ld a, COMPORTAMIENTO_CORRE_DE_IZQUIERDA_A_DERCHA
    ld (iy+enemy.type),a



    ld iy, template_enemy5
    ld a,16*8;y
    ld (iy+enemy.y),a
    ld a,30*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a,COLOR_VERDE_OSCURO
    ld (iy+enemmy.color),a
    ld a, RIGHT
    ld (iy+enemy.direction),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a


    ld iy, template_enemy6
    ld a,15*8;y
    ld (iy+enemy.y),a
    ld a,15*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_ENANO
    ld (iy+enemy.pattern_def),a
    ld a,COLOR_ROJO_MEDIO
    ld (iy+enemmy.color),a
    ld a, RIGHT
    ld (iy+enemy.direction),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    
    ret

    
;lEYENDO MAPAS
;------------------------  
load_screens:
    ld hl, MAPS_DIRECTION
    ld bc, MAP_SIZE
    ld a,(screen)
.loop_load_screens:
    cp 1
    jr z, .es_cero
    sub 1
    add hl, bc
    jr .loop_load_screens
.es_cero:
    ld de, map_buffer 
    ld bc, MAP_SIZE
    LDIR
    ;ponemos el mapa en la VRAM
    ld hl, map_buffer
    ld de, 6144 
	;Le quitamos 64 ya que keremos pintar el HUD en las últimas 2 líneas de la pantalla
    ld bc, MAP_SIZE
    call  LDIRVM
    ret
is_final_screen:
    ld a,1
    ld (screen),a
    call load_screens
    ret


;COMPRIMIENDO PANTALLAS
;------------------------
load_screen_loader:
    ;Tileset
    ld hl, loader_screen_BANK_PATTERN_0 
    ld de, #0000     
    ld bc, #1800
    ;call  LDIRVM 
    call depack_VRAM   
    ;Colores
    ld hl, loader_screen_BANK_COLOR_0
    ld de, #2000 
    ld bc, #1800 
    ;call  LDIRVM
    call depack_VRAM
    ;-Mapa o tabla de nombres
    ld hl, loader_screen_SCREEN_0_0
    ld de, #1800 
    ld bc, #300
    ;call  LDIRVM
    call depack_VRAM 
    ret
depack_VRAM:
    include "src/PL_VRAM_Depack.asm"
loader_screen:
    incbin "./assets/DISCOIM.S02.plet5";creado con pletter5b.exe

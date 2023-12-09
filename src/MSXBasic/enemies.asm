    struct enemy 
y           db      0
x           db      0
pattern_def db      0; los patrones definicidos será el 0 para el player, el 4 para el player 2, el 8 para el enemy 1,etc
color       db      0
plane       db      0; como con 4 bytes se define un plano en la tabla de atributos de sprites, el player tiene el plano 0, el player 2 el plano 4, el enemy 1 el plano 8
direction   db      0; la dirección puede cambiar su el comportamiento dice que cambie
type        db      0; según el tipo le aplicaemos un comportamiento u otro
counter     db      0; nos ayuda con las animaciones
frame       db      0; nos auyda con las animaciones
    ends

template_enemy1:
    db 60
    db 160
    db ENEMIGO_COLETA
    db COLOR_AZUL_MEDIO
    db 6*4; plano 4*4 bytes
    db UP;direction
    db COMPORTAMIENTO_REBOTA_VERTICAL
    db 0
    db 0

template_enemy2:
    db 100
    db 140
    db ENEMIGO_ENANO_DERECHA
    db COLOR_AZUL_OSCURO;color azul oscuro
    db 3*4; plano 2*4 bytes
    db RIGHT;;direction
    db COMPORTAMIENTO_REBOTA_HORIZONTAL
    db 0
    db 0
template_enemy3:
    db 144
    db 230
    db ENEMIGO_CABEZON
    db COLOR_ROJO_OSCURO
    db 4*4; plano 3*4 bytes
    db RIGHT;;direction
    db COMPORTAMIENTO_REBOTA_HORIZONTAL
    db 0
    db 0
template_enemy4:
    db 152
    db 190
    db ENEMIGO_PANZON+8
    db COLOR_AMARILLO
    db 5*4; plano 4*4 bytes
    db RIGHT;direction
    db COMPORTAMIENTO_CORRE_DE_IZQUIERDA_A_DERCHA
    db 0
    db 0
template_enemy5:
    db 130
    db 239; en la 1 pantalla empezará en la posición x 230, el límite derecho es 240
    db ENEMIGO_PANZON
    db COLOR_VERDE_OSCURO
    db 2*4; plano 1*4 bytes
    db RIGHT;direction
    db COMPORTAMIENTO_REBOTA_HORIZONTAL;type
    db 0
    db 0
template_enemy6:
    db 120
    db 120
    db ENEMIGO_GORDO
    db COLOR_ROJO_MEDIO
    db 7*4; plano 4*4 bytes
    db RIGHT;direction
    db COMPORTAMIENTO_REBOTA_HORIZONTAL
    db 0
    db 0
SIZE_OF_ENEMY equ 9
MAX_ENEMIES equ 6
enemy_active: db 0; nos permite hacer el loop y en update_enemies y cuando llegue a MAX_EMIES salimos del update_enemies


;reservamos espacio para 10 enemigos
;max_enemies equ 10
;array_enimies: ds enemy*max_enemies ;son 7 bytes * 10 entidades de enemigos=70 bytes, si te fijas enemy vale el tamaño del struct
counter_enemy: db 0
;randData solo es utilizada por la rutina random
randData: db 0,0
MAX_RETARDO_REDIBUJADO equ 30



ENEMIGO_COLETA:     equ 32;8 ,9,10 y 11*4 el octavo sprite
ENEMIGO_GORDO:      equ 48;el sprute 12, 13,14 y 15*4
ENEMIGO_CABEZON:    equ 64;sprite 16*4
ENEMIGO_PANZON:     equ 80;sprite 20*4
ENEMIGO_GORRA:      equ 96;sprite 24*4
ENEMIGO_ENANO_DERECHA:      equ 112;sprite 28*4
ENEMIGO_ENANO_DIZQUIERDA:      equ 120;sprite 28*4
ENEMIGO_VIRUS1:     equ 128;sprite 32*4
ENEMIGO_VIRUS2:     equ 144;sprite 36*4
ENEMIGO_VIRUS3:     equ 160;sprite 40*4
ENEMIGO_VIRUS4:     equ 176;sprite 44*4

COMPORTAMIENTO_CORRE_DE_IZQUIERDA_A_DERCHA: equ 0
COMPORTAMIENTO_CORRE_DE_DERECHA_A_IZQUIERDA: equ 1
COMPORTAMIENTO_REBOTA_HORIZONTAL: equ 3
COMPORTAMIENTO_REBOTA_VERTICAL: equ 2
COMPORTAMIENTO_PERSIGUE: equ 5
COMPORTAMIENTO_STATICO: equ 6
COMPORTAMIENTO_BAILA: equ 7



initialize_enemy: 
    ;ld hl, template_enemy
    ;ld de, array_enimies*counter_enemy
    ;ld bc, (counter_enemy*enemy)
    ;ldir
    ret

create_enemy:
    ;ld iy, template_enemy0
    ;ld a,(counter_enemy)
    ;add SIZE_OF_ENEMY
    ;ld (counter_enemy),a    
    ret


update_enemies:
    ;inicializamos la posición de la memoria donde empiezan nuestras entidades
    ld iy,template_enemy1
    ;ponemos a 0 la entidad activa
    xor a
    ld (enemy_active),a
;blucle FOR:recorre las entidades desde 0 a MAX_ENTITIES-1
.loop:
    ;Obtenemos la entidad activa
    ld a,(enemy_active)
    ;si ha llegado al final salimos
    cp MAX_ENEMIES
    jr z,.update_enemies_end
    ;Si no ha llegado al final incrementamos el contador de la entidad activa
    inc a
    ld (enemy_active),a
    ;Obtenemos su tipo con el puntero iy
    ld a,(iy+enemy.type)

    ;Según el tipo le aplicamos un comportamiento
    cp COMPORTAMIENTO_CORRE_DE_IZQUIERDA_A_DERCHA
        call z, move3_enemigo_corre_de_izquierda_a_derecha
    cp COMPORTAMIENTO_CORRE_DE_DERECHA_A_IZQUIERDA
        call z, move1_enemigo_corre_de_derecha_a_izquierda
    cp COMPORTAMIENTO_REBOTA_VERTICAL
        call z, move2_enemigo_rebota_vertical
    cp COMPORTAMIENTO_BAILA
        call z, move0_enemigo_baila
    cp COMPORTAMIENTO_PERSIGUE
        call z, move4_enemigo_te_persigue
    cp COMPORTAMIENTO_REBOTA_HORIZONTAL
        call z, move5_enemigo_rebota_izquierda_derecha
    cp COMPORTAMIENTO_STATICO
        call z, move6_enemigo_estatico
    ;comprobamos las colisiones
    call check_collision_enemy
    call check_colision_with_player
    ;aumentamos en la dirección el tamaña del enemigo, el bloque siguiente hace lo mismo que esto pero según el tamaño del enemigo:
    xor a
.loop_iy:
    inc iy
    inc a
    cp SIZE_OF_ENEMY
    jr z,.loop
    jr .loop_iy

    jr .loop
.update_enemies_end:
    ret

move0_enemigo_baila:
    ld a,(iy+enemy.counter)
    add 1
    ld (iy+enemy.counter),a
    cp MAX_RETARDO_REDIBUJADO
    jp nz,.move0_end

    ld a,(iy+enemy.frame); 
    and 1;si el frame es 1
         ;al hacer 0000 0000 (0) and 0000 0001 da 0 y se activa el flag Z. 
         ;al hacer 0000 0001 (1) and 0000 0001 da 1 y no se activa el flag Z. 
    jp z, .move0_change_sprite
    jr .move0_dibujar
.move0_dibujar:
    ld a, (iy+enemy.pattern_def)
    sub 4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ld (iy+enemy.pattern_def),a 
    ld a,0
    ld (iy+enemy.frame),a;le ponemos el frame 0
    jr .reseteo
.move0_change_sprite:
    ld a, (iy+enemy.pattern_def);
    add 4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ld (iy+enemy.pattern_def),a ;será el byte 13*4=52-48=4
    ld a,1;le ponemos el frame 1
    ld (iy+enemy.frame),1
.reseteo:
    ld a,0
    ld (iy+enemy.counter),a
.move0_end:
    ret





move3_enemigo_corre_de_izquierda_a_derecha:
    call move_enemy_left
    ;chequeo límite izquiedo
    ld a,(iy+enemy.x)
    ;si la posición x es 8
    cp 8
    ;si al restar entre 8 no es igual a cero saltamos
    jp nz, .end_move3_llega_al_borde_izquierdo
    ;recolocar_enemy:
    call random
    ld a,(randData)
    ld (iy+enemy.y),a
    ld a,250
    ld (iy+enemy.x),a

.end_move3_llega_al_borde_izquierdo:
    ret



move1_enemigo_corre_de_derecha_a_izquierda:
    call move_enemy_right
    ;Chekeo de límite derecho
    ;obtenemos la posición x
    ld a,(iy+enemy.x)
    ;si la posición x es 248
    cp 248
    ;si al restar entre 248 no es igual a cero saltamos
    jp nz, .end_move1
    ;Si es igual a 248 recolocamos el enemigo:
    call random
    ld a,(randData)
    ld (iy+enemy.y),a
    ld a,8
    ld (iy+enemy.x),a

.end_move1:

    ret



move2_enemigo_rebota_vertical:
    ld a, (iy+enemy.direction)
    cp 1
    call z, move_enemy_up
    cp 5
    call z, move_enemy_down
    ld a,(iy+enemy.y)
    cp 160
    jp z, .es_1
    cp 0     
    jp z, .es_5
    jp .end_move2
.es_1:
    ld a,1
    ld (iy+enemy.direction),a
    ;call BEEP
    jr .end_move2
.es_5:
    ld a,5
    ld (iy+enemy.direction),a
    ;call BEEP
.end_move2:
    ret




move4_enemigo_te_persigue:
    ld a,(iy+enemy.counter)
    add 1
    ld (iy+enemy.counter),a
    cp MAX_RETARDO_REDIBUJADO
    jp nc,.end_move4_enemigo_te_persigue

    ;actuializamos el sprite según la dirección
    ld a,(iy+enemy.direction)
    cp LEFT
    jr z,.asignar_sprite_mirando_izquierda
    ld a,ENEMIGO_ENANO_DERECHA
    ld (iy+enemy.pattern_def),a
    jr .next
.asignar_sprite_mirando_izquierda:
    ld a,ENEMIGO_ENANO_DIZQUIERDA
    ld (iy+enemy.pattern_def),a
.next:

    ld a,(ix+player.x)
    ld b,(iy+enemy.x)
    sub b
    jr c, .el_player_esta_a_la_izquierda
    ld a, (iy+enemy.x)
    add 1
    ld (iy+enemy.x),a
    jr .next2
.el_player_esta_a_la_izquierda:
    ld a, (iy+enemy.x)
    sub 1
    ld (iy+enemy.x),a
.next2
    ld a, (ix+player.y)
    ld b, (iy+enemy.y)
    sub b
    jr c, .el_player_esta_encima
    ld a, (iy+enemy.y)
    add 1
    ld (iy+enemy.y),a
    jr .reseteo
.el_player_esta_encima:
    ld a, (iy+enemy.y)
    sub 1
    ld (iy+enemy.y),a

.reseteo:
    ;ld a,0
    ;ld (iy+enemy.counter),a
.end_move4_enemigo_te_persigue:
    ret

move5_enemigo_rebota_izquierda_derecha:
    ld a, (iy+enemy.direction)
    cp 3
    call z, move_enemy_right
    cp 7
    call z, move_enemy_left
    ld a,(iy+enemy.x)
    cp 240
    jp z, .es_3
    cp 0     
    jp z, .es_7
    jp .end_move5
.es_7:
    ld a,3
    ld (iy+enemy.direction),a
    call change_sprite
    jr .end_move5
.es_3:
    ld a,7
    ld (iy+enemy.direction),a
    call change_sprite
.end_move5:
    ret

move6_enemigo_estatico:
    ret



move_enemy_right:
    ld a,(iy+enemy.x); 
    add 1  
    ld (iy+enemy.x), a 
    and 1
    jp z, enemy_right_es_impar
    ld a, (iy+enemy.pattern_def);
    add 4
    ld (iy+enemy.pattern_def),a 
    ret
enemy_right_es_impar:
    ld a, (iy+enemy.pattern_def);el aprite 12*4=es el byte 48 
    sub 4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ld (iy+enemy.pattern_def),a 
    ret


move_enemy_left:
    ld a,(iy+enemy.x); 
    sub 1  
    ld (iy+enemy.x), a 
    and 1
    jp z, enemy_left_es_impar
    ld a, (iy+enemy.pattern_def);
    add 4
    ld (iy+enemy.pattern_def),a 
    ret
enemy_left_es_impar:
    ld a, (iy+enemy.pattern_def);el aprite 12*4=es el byte 48 
    sub 4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ld (iy+enemy.pattern_def),a 
    ret


move_enemy_up:
    ld a,(iy+enemy.y); 
    sub 1  
    ld (iy+enemy.y), a 
    and 1
    jp z, enemy_up_es_impar
    ld a, (iy+enemy.pattern_def);
    add 4
    ld (iy+enemy.pattern_def),a 
    ret
enemy_up_es_impar:
    ld a, (iy+enemy.pattern_def);el aprite 12*4=es el byte 48 
    sub 4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ld (iy+enemy.pattern_def),a 
    ret


move_enemy_down:
    ld a,(iy+enemy.y); 
    add 1  
    ld (iy+enemy.y), a 
    and 1
    jp z, enemy_down_es_impar
    ld a, (iy+enemy.pattern_def);
    add 4
    ld (iy+enemy.pattern_def),a 
    ret
enemy_down_es_impar:
    ld a, (iy+enemy.pattern_def);el aprite 12*4=es el byte 48 
    sub 4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ld (iy+enemy.pattern_def),a 
    ret

change_sprite:
    ld a,(iy+enemy.direction)
    cp LEFT
    jr z,.change_to_left
    ld a, (iy+enemy.pattern_def)
    sub 4
    ld (iy+enemy.pattern_def),a 
    jr .end_change_sprite
.change_to_left:
    ld a, (iy+enemy.pattern_def)
    add 4
    ld (iy+enemy.pattern_def),a 
.end_change_sprite:
    ret

;;--------------------------------------
;;  CHECKCOLISION
;;        Input:
;;              iy=con la dirección del enemigo
;;                  ld iy, enemigo0+SIZE_OF_ENEMY*3
;;                  call check_collision_enemy

check_collision_enemy:
    ld a,(iy+enemy.y)
    ld e,a;y
    ld a,(iy+enemy.x)
    ld d,a;x


    ld a,(iy+enemy.direction)
    cp RIGHT
    jr z,.get_block_right
    cp LEFT
    jr z,.get_block_left
    cp UP
    jr z,.get_block_up
    cp DOWN
    jr z,.get_block_down



    jr .next
.get_block_right:
    ld a,d
    add 4
    ld d,a
    jp .next
.get_block_left:
    ld a,d
    sub 4
    ld d,a
    jp .next
.get_block_up:
    ld a,e
    sub 8
    ld e,a
    jp .next
.get_block_down:
    ld a,e
    add 1
    ld e,a


.next:
    ;get_block necesita en el registro e la posición x y en d la posición y, devuelve el resultado en b
    call get_block
    ld a,b
    cp TILE_SOLID ;Si al restalo entre 32 da negatico se activará el flag de carry
    jr nc, colision_enemy 
    ret

colision_enemy:
    ld a,(iy+enemy.direction)
    cp LEFT
    jr z, .is_LEFT
    cp RIGHT
    jr z, .is_RIGHT
    cp UP
    jr z, .is_UP
    cp DOWN
    jr z, .is_DOWN
.is_LEFT:
    ld a,RIGHT
    jr .next
.is_RIGHT:
    ld a,LEFT
    jr .next
.is_UP:
    ld a,DOWN
    jr .next
.is_DOWN:
    ld a,UP
    jr .next


.next:
    ld (iy+enemy.direction),a
    ld a,(iy+enemy.type)
    cp COMPORTAMIENTO_CORRE_DE_IZQUIERDA_A_DERCHA
    jr z,.add_8_to_y
    cp COMPORTAMIENTO_CORRE_DE_DERECHA_A_IZQUIERDA
    jr z,.add_8_to_y
    cp COMPORTAMIENTO_PERSIGUE
    jr z,.add_8_to_y
    cp COMPORTAMIENTO_REBOTA_VERTICAL
    jr z, .end_colision_enemy
    jr z,.add_8_to_y
    call change_sprite
    jr .end_colision_enemy
.add_8_to_y:
    ld a,(iy+enemy.y)
    add 8
    ld (iy+enemy.y),a
.end_colision_enemy:
    ret

check_colision_with_player:
    ;if (enemy->x < player->x + player->w &&
    ;enemy->x + enemy->w > player->x && 
    ;enemy->y < player->y + player->h && 
    ;enemy->h + enemy->y > player->y

    ld a,(ix+player.x)
    ld b, 16
    add b
    ld b, (iy+enemy.x)
    cp b ; le restamos la posición del enemigo en x al player para saber si el enemigo está denro del cuadrado del player
    jr c, .end_check_colision_with_player; el_enemigo_no esta_dentro_del_ cuadrodpplayer
    ld a,(iy+enemy.x)
    ld b,16
    ld b,(ix+player.x)
    cp b
    jr c, .end_check_colision_with_player; el enemigo no está en el cuadrado del player


    ld a,(ix+player.y)
    ld b, 16
    add b
    ld b, (iy+enemy.y)
    cp b ; le restamos la posición del enemigo en x al player para saber si el enemigo está denro del cuadrado del player
    jr c, .end_check_colision_with_player; el_enemigo_no esta_dentro_del_ cuadrodpplayer
    ld a,(iy+enemy.y)
    ld b,16
    ld b,(ix+player.y)
    cp b
    jr c, .end_check_colision_with_player; el enemigo no está en el cuadrado del player

    call kill_player;matamos al player
    call kill_enemy;recolocamos a los enemigos

.end_check_colision_with_player:
    ret




render_enemies:
    ld iy, template_enemy1
    ld hl, 6912; aquí se podría poner la variable del sistema GRPATR
    ld l,(iy+enemy.plane)
    ;intercambiamos los valores para que tengamos en el registro "de" la dirección de la memoria que necesita LDIRVM
    ex de,hl
    ld hl, template_enemy1
    ld bc, 4; 4 bytes para copiar
    push de
    push hl
    call  LDIRVM; ldirvm necesita en hl la dirección de memoria a copiar, en de la dirección de destino y en bc la cantidad ed bytes a copiar
    pop hl
    pop de
    ld a, MAX_ENEMIES
.loop:
    sub 1
    cp 0
    jr z, .end_render_enemies
    inc de
    inc de
    inc de
    inc de;6924,6928,etc
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl;8b3c
    ld bc, 4; 4 bytes para copiar
    push af
    push de
    push hl
    call  LDIRVM; ldirvm necesita en hl la dirección de memoria a copiar, en de la dirección de destino y en bc la cantidad ed bytes a copiar
    pop hl
    pop de
    pop af
    jr .loop
.end_render_enemies
    ret







;https://gist.github.com/JohnConnolly0/25c65425cf4f84954585
; El registro de refresco (R) en el Z80 es muy impredecible ya que se incrementa en cada ciclo.
; Debido a que puede tener cualquier valor cuando se llama a esta rutina, es muy bueno para números aleatorios.
; Esta rutina aumenta la aleatoriedad del número ya que forma una dirección basada en el
; actualiza el estado actual del contador y accede a la memoria en esa dirección.
random:
    LD A,R			; Cargo el registro A con el registro r
    LD L,A			; Copia el valor del registro a en l
    AND %00111111	; 63,#3f,Este enmascaramiento impide que la dirección que estamos formando acceda a la RAM
    LD H,A			; Copy register A into register H
    LD A,(HL)		; Load the pseudo-random value into A
    cp 80           ;le hacemos la resta con 100 si el resultado es menor que 0 se activará el flag de carry
    jr c, random    
    cp 160          ;si el resultado es menor de 160 no se acivará el flag de carry
    jr nc, random
    ld (randData),a
    ret

sacar_sprites_de_pantalla:
    ld iy, template_enemy1
    xor a
    ld (enemy_active),a

.loop:
    ld a,(enemy_active)
    cp MAX_ENEMIES
    jr z,.end_sacar_sprites_de_pantalla
    inc a
    ld (enemy_active),a
    ld a,212;y
    ld (iy+enemy.y),a
    ld a,0;x
    ld (iy+enemy.x),a
    ;ld a, COMPORTAMIENTO_STATICO
    ;ld (iy+enemy.type),a
    xor a
    ;call update_enemies
.loop_iy:
    inc iy
    inc a
    cp SIZE_OF_ENEMY
    jr z,.loop
    jr .loop_iy

    jr .loop
.end_sacar_sprites_de_pantalla:

    ret



kill_enemy:
    ld a,24*8
    ld (iy+enemy.y),a
    ld a,0
    ld (iy+enemy.x),a
    ld a,COMPORTAMIENTO_STATICO
    ld (iy+enemy.type),a
    ret




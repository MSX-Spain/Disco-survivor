



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
    cp 0
        call z, move0_enemigo_corre_de_izquierda_a_derecha
    cp 1
        call z, move1_enemigo_corre_de_derecha_a_izquierda
    cp 2
        call z, move2_enemigo_corre_de_arriba_a_abajo
    cp 3
        call z, move3_enemigo_baila
    cp 4
        call z, move4_enemigo_te_persigue

    call check_collision_enemy
;aumentamos en la dirección el tamaña del enemigo, el bloque siguiente hace lo mismo que esto pero según el tamaño del enemigo:
;inc iy
;inc iy
;inc iy
;inc iy
;inc iy
;inc iy
    xor a
.loop_iy:
    inc iy
    cp SIZE_OF_ENEMY-1
    jr z,.loop
    inc a
    jr .loop_iy



    jr .loop
.update_enemies_end:
    ret



move0_enemigo_corre_de_izquierda_a_derecha:
    ;chequeo límite izquiedo
        ;obtenemos la posición x
        ld a,(iy+enemy.x)
        ;si la posición x es 8
        cp 8
        ;si al restar entre 8 no es igual a cero saltamos
        jp nz, .end_move0_llega_al_borde_izquierdo
        ;recolocar_enemy:
        call random
        ld a,(randData)
        ld (iy+enemy.y),a
        ld a,250
        ld (iy+enemy.x),a
.end_move0_llega_al_borde_izquierdo:
    call move_enemy_left
    ret

move1_enemigo_corre_de_derecha_a_izquierda:
    call move_enemy_right
    ;---------------------
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

move2_enemigo_corre_de_arriba_a_abajo:

.end_move2:
    ret

move3_enemigo_baila:
    ld a,(iy+enemy.counter)
    add 1
    ld (iy+enemy.counter),a
    cp MAX_RETARDO
    ;solo dibujaremos cuando la Z esté actiavda, es decir cuando se MAX_RETARDO
    jr z,.move3_dibujar
    jr .move3_end

.move3_dibujar:
    ld a,(iy+enemy.frame); comprobamos el frame para cambiarle sprite
    and 1;al hacer 0000 0000 (0) and 0000 0001 da 0 y se activa el flag Z. 
         ;al hacer 0000 0001 (1) and 0000 0001 da 1 y no se activa el flag Z. 
    jp z, .move3_change_sprite
    ld a, (iy+enemy.sprite)
    sub 4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ld (iy+enemy.sprite),a 
    ld a,0
    ld (iy+enemy.frame),a;le ponemos el frame 0
    jr .move3_reset_counter
.move3_change_sprite:
    ld a, (iy+enemy.sprite);
    add 4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ld (iy+enemy.sprite),a ;será el byte 13*4=52-48=4
    ld a,1;le ponemos el frame 1
    ld (iy+enemy.frame),1

.move3_reset_counter:;cada vez que se dibuja e cntador se resetea
    ld a,0
    ld (iy+enemy.counter),a
.move3_end;
    ret



move4_enemigo_te_persigue:

    ret





move_enemy_right:
    ld a,(iy+enemy.x); 
    add 1  
    ld (iy+enemy.x), a 
    and 1
    jp z, enemy_right_es_impar
    ld a, (iy+enemy.sprite);
    sub 4
    ld (iy+enemy.sprite),a 
    ret
enemy_right_es_impar:
    ld a, (iy+enemy.sprite);el aprite 12*4=es el byte 48 
    add 4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ld (iy+enemy.sprite),a 
    ret
move_enemy_left:
    ld a,(iy+enemy.x); 
    sub 1  
    ld (iy+enemy.x), a 
    and 1
    jp z, enemy_left_es_impar
    ld a, (iy+enemy.sprite);
    sub 4
    ld (iy+enemy.sprite),a 
    ret
enemy_left_es_impar:
    ld a, (iy+enemy.sprite);el aprite 12*4=es el byte 48 
    add 4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ld (iy+enemy.sprite),a 
    ret




;;--------------------------------------
;;  CHECKCOLISION
;;        Input:
;;              iy=con la dirección del enemigo
;;                  ld iy, enemigo0+SIZE_OF_ENEMY*3
;;                  call check_collision_enemy

check_collision_enemy:
    ;push hl
    ld a,(iy+enemy.y)
    ld e,a;y
    ;inc hl
    ld a,(iy+enemy.x)
    ld d,a;x
    ;get_block necesita en el registro e la posición x y en d la posición y, devuelve el resultado en b
    call get_block
    ld a,b
    cp 32 ;Si al restalo entre 32 da negatico se activará el flag de carry
    jr nc, colision_enemy 
    ;pop hl
    ret
colision_enemy:
    ;call BEEP
    ld a,(iy+enemy.y)
    add 8
    ld (iy+enemy.y),a
    ;pop hl
    ret








;draw_enemies:
;    ld iy,template_enemy1
;    ld hl, 6912
;    xor a
;    ld (enemy_active),a
;;blucle FOR:recorre las entidades desde 0 a MAX_ENTITIES-1
;.loop_draw_enemies:
;    ;Obtenemos la entidad activa
;    ld a,(enemy_active)
;    ;si ha llegado al final salimos
;    cp MAX_ENEMIES
;    jr z,.draw_enemies_end
;    ;Si no ha llegado al final incrementamos el contador de la entidad activa
;    inc a
;    ld (enemy_active),a
;
;
;    ;1.6916,2.6920,3.6924,4.6928
;    ;ld hl, 6912
;    ld l,(iy+enemy.plane)
;    ;intercambiamos los valores para que tengamos en el registro "de" la dirección de la memoria que necesita LDIRVM
;    ex hl,de
;    ld bc, 4; 4 bytes para copiar, cada plano son 4 bytes
;    call  LDIRVM; ldirvm necesita en hl la dirección de memoria a copiar, en de la dirección de destino y en bc la cantidad ed bytes a copiar
;
;  xor a
;.loop_iy_draw_enemy:
;    inc iy
;    inc hl
;    cp SIZE_OF_ENEMY-1
;    jr z,.loop_draw_enemies
;    inc a
;    jr .loop_iy_draw_enemy
;
;
;
;    jr .loop_draw_enemies
;.draw_enemies_end:
;    ret


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

recolocate_enemies_screen_2:
    ;y       db      0
    ;x       db      0
    ;sprite  db      0
    ;color   db      0
    ;plane   db      0
    ;type    db      0

    ld iy, template_enemy1
    ld a,100;y
    ld (iy+enemy.y),a
    ld a,8;x
    ld (iy+enemy.x),a

    ld iy, template_enemy1+(SIZE_OF_ENEMY*1)
    ld a,100;y
    ld (iy+enemy.y),a
    ld a,40;x
    ld (iy+enemy.x),a

    ld iy, template_enemy1+(SIZE_OF_ENEMY*2)
    ld a,110;y
    ld (iy+enemy.y),a
    ld a,200;x
    ld (iy+enemy.x),a

    
    ld iy, template_enemy1+(SIZE_OF_ENEMY*3)
    ld a,100;y
    ld (iy+enemy.y),a
    ld a,0;x
    ld (iy+enemy.x),a
    ld a,2;x
    ld (iy+enemy.type),a
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




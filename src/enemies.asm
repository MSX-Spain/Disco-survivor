enemy_atributes:
    struct enemy 
y       db      0
x       db      0
sprite  db      0
color   db      0
plane   db      0
type    db      0
;ptr_e   db      0
    ends


template_enemy0:
    db 130
    db 220
    db 32;sprite 8 por 4 bytes
    db 4;color azul oscuro
    db 4; plano 1*4 bytes
    db 0
template_enemy1:
    db 100
    db 200
    db 60;15 sprite
    db 15;color azul oscuro
    db 8; plano 2*4 bytes
    db 1
template_enemy2:
    db 120
    db 80
    db 52;sprite 13 por 4 bytes
    db 3;verde claro
    db 12; plano 3*4 bytes
    db 1
template_enemy3:
    db 130
    db 8
    db 44;sprite 8 por 4 bytes
    db 15;color azul oscuro
    db 16; plano 4*4 bytes
    db 0
size_of_enemy equ 6

;los tipos son: 
;   1.El enemigo va de derecha a izquierda corriendo
;   2.El enemigo está bailando

;reservamos espacio para 10 enemigos
;max_enemies equ 10
;array_enimies: ds enemy*max_enemies ;son 7 bytes * 10 entidades de enemigos=70 bytes, si te fijas enemy vale el tamaño del struct
counter_enemy: db 0


;randData solo es utilizada por la rutina random
randData: db 0,0


initialize_enemy:
    ;ld hl, template_enemy
    ;ld de, array_enimies*counter_enemy
    ;ld bc, (counter_enemy*enemy)
    ;ldir
    ret

create_enemy:
    ld iy, template_enemy0
    ld a,(counter_enemy)
    add 1
    ld (counter_enemy),a
    ret


update_enemies:
    ;1.vemos los creados
    ;ld a, (counter_enemy)
    ;ld b,a
    ;cp 0
    ;jr z,update_enemies_end

    ld iy, template_enemy0
    call move1_enemigo_corre_de_izquierda_a_derecha
    call check_colision
    
    ld iy, template_enemy0+(size_of_enemy*1)
    call move2_enemigo_baila

    ld iy, template_enemy0+(size_of_enemy*2)
    call move2_enemigo_baila

    ld iy, template_enemy0+(size_of_enemy*3)
    call move3_enemigo_corre_de_derecha_a_izquierda


    ;djnz update_enemies

update_enemies_end:
    ret  


move1_enemigo_corre_de_izquierda_a_derecha
    call move_enemy_left
    ;obtenemos la posición x
    ld a,(iy+enemy.x)
    ;si la posición x es 8
    cp 8
    ;si al restar entre 8 no es igual a cero saltamos
    jp nz, .end_move1
    ;recolocar_enemy:
    call random
    ld a,(randData)
    ld (iy+enemy.y),a
    ld a,250
    ld (iy+enemy.x),a
.end_move1:
    ret

move3_enemigo_corre_de_derecha_a_izquierda
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

move2_enemigo_baila
    ;halt
    ;halt
    ld a,(JIFFY)
    and 1
    jp z, .move2_change_sprite
    ld a, (iy+enemy.sprite);el aprite 12*4=es el byte 48 
    sub 4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ld (iy+enemy.sprite),a 
    jp nz, .move2_end
.move2_change_sprite:
    ld a, (iy+enemy.sprite);
    add 4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ld (iy+enemy.sprite),a ;será el byte 13*4=52-48=4

.move2_end
    ret

move3_desplazar_enemigo_2_derecha_2_izquierda:

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

check_colision:
    ;        enemy->x + enemy->w > player->x  
    ;        && enemy->x < player->x + player->w 
    ;        && enemy->h + enemy->y > player->y 
    ;        &&  enemy->y < player->y + player->h) 
    ;------------------x-----------------------   
    ;si el enemigo+32 está por debajo dará carry
    ld h,0
    ld l,(iy+enemy.x)
    ;lo almacenamos en b el valor de enemy.x+16
    ld a,l
    add 16
    ld b,a
    ld a,(ix+player.x)
    ; comparamos el valor de b con a
    cp b
    ;comprobamos si d carry
    jr c, check_colision_end
    ;si el enemigo.x es mayor que play.x no da carry y podemos seguir
    ld a,(ix+player.x)
    add 16
    ; si enemy.x es mayor que player.x+32, no dará carry
    cp b
    jr c, check_colision_end:
    ; ---------------y------------------------
    ;y podemos seguir
    ld h,0
    ld l,(iy+enemy.y)
    ;lo almacenamos en b el valor de enemy.x+16
    ld a,l
    add 16
    ld b,a
    ld a,(ix+player.y)
    ; comparamos el valor de b con a
    cp b
    ;comprobamos si d carry
    jr c, check_colision_end
    ;si el enemigo.y es mayor que play.y no da carry y podemos seguir
    ld a,(ix+player.y)
    add 16
    ; si enemy.x es mayor que player.x+32, no dará carry
    cp b
    jr nc, check_colision_end
    call BEEP
check_colision_end:
    ret









draw_enemies:
    ;6912 o #1b00 dirección tabla de atributos en VRAM donde están los atributos de y,x,sprite_definition, color
    ;el patron 0 es el del player, el enemigo 1 tendrá el 1 plano y como son 4 bytes cada plano(así está configurado el MSX)=6912+4
    ;como no podemos sumarle a de el patrón, lo hacemos a través de hl,
    
    ld iy, template_enemy0
    ld hl, 6912
    ;ld l(ix+enemy.plane) hace la suma
    ld l,(iy+enemy.plane)
    ;intercambiamos los valores para que tengamos en el registro "de" la dirección de la memoria que necesita LDIRVM
    ex hl,de
    ld hl, template_enemy0 
    ld bc, 4; 4 bytes para copiar
    call  LDIRVM 


    ld iy, template_enemy0+(size_of_enemy*1)
    ld hl, 6912
    ;ld l(ix+enemy.plane) hace la suma
    ld l,(iy+enemy.plane)
    ;intercambiamos los valores para que tengamos en el registro "de" la dirección de la memoria que necesita LDIRVM
    ex hl,de
    ld hl, template_enemy0+(size_of_enemy*1)
    ld bc, 4; 4 bytes para copiar
    call  LDIRVM 


    ld iy, template_enemy0+(size_of_enemy*2)
    ld hl, 6912
    ;ld l(ix+enemy.plane) hace la suma
    ld l,(iy+enemy.plane)
    ;intercambiamos los valores para que tengamos en el registro "de" la dirección de la memoria que necesita LDIRVM
    ex hl,de
    ld hl, template_enemy0+(size_of_enemy*2)
    ld bc, 4; 4 bytes para copiar
    call  LDIRVM 



    ld iy, template_enemy0+(size_of_enemy*3)
    ld hl, 6912
    ;ld l(ix+enemy.plane) hace la suma
    ld l,(iy+enemy.plane)
    ;intercambiamos los valores para que tengamos en el registro "de" la dirección de la memoria que necesita LDIRVM
    ex hl,de
    ld hl, template_enemy0+(size_of_enemy*3)
    ld bc, 4; 4 bytes para copiar
    call  LDIRVM 
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




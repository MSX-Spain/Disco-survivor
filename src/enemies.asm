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
    db 6
    db 4; plano 1*4 bytes
    db 0

template_enemy1:
    db 100
    db 200
    db 48;sprite 12 por 4 bytes
    db 15;color azul oscuro
    db 8; plano 2*4 bytes
    db 1
template_enemy2:
    db 120
    db 80
    db 56;sprite 16 por 4 bytes
    db 3;verde claro
    db 12; plano 3*4 bytes
    db 1


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
    ;ld a,130
    ;ld (iy+enemy.y),a ;le ponemos a la posición y un 130
    ;ld a,255
    ;ld (iy+enemy.x),a ;le ponemos a la posición x 255
    ;ld a,8*4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ;ld (iy+enemy.sprite),a ;Le ponemos el patrón 8
    ;ld a,4 ; el 4 es el color azul oscuro
    ;ld (iy+enemy.color),a 
    ;ld a,1*4
    ;ld (iy+enemy.plane),a
    ;ld a,0;será el enemigo que va de izquierda a derecha corriendo
    ;ld(iy+enemy.type),a
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
    ld iy, template_enemy0+6
    call move2_enemigo_baila
    ld iy, template_enemy0+12
    call move2_enemigo_baila
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

move2_enemigo_baila
    ld a,(JIFFY)
    and 1
    jp z, .move2_change_sprite
    ld a,12*4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ld (iy+enemy.sprite),a ;Le ponemos el patrón 8
    jp nz, .move2_end
.move2_change_sprite:
    ld a,13*4;hay que multiplicar por 4 ya que son sprites de 16x16 pixeles, es decir 4 sprites realmente
    ld (iy+enemy.sprite),a ;Le ponemos el patrón 8
.move2_end
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


    ld iy, template_enemy0+6
    ld hl, 6912
    ;ld l(ix+enemy.plane) hace la suma
    ld l,(iy+enemy.plane)
    ;intercambiamos los valores para que tengamos en el registro "de" la dirección de la memoria que necesita LDIRVM
    ex hl,de
    ld hl, template_enemy0+6
    ld bc, 4; 4 bytes para copiar
    call  LDIRVM 


    ld iy, template_enemy0+12
    ld hl, 6912
    ;ld l(ix+enemy.plane) hace la suma
    ld l,(iy+enemy.plane)
    ;intercambiamos los valores para que tengamos en el registro "de" la dirección de la memoria que necesita LDIRVM
    ex hl,de
    ld hl, template_enemy0+12 
    ld bc, 4; 4 bytes para copiar
    call  LDIRVM 
    ret


move_enemy_right:
    ld a,(iy+enemy.x); obetenemos el valor actual de la posicion x y lo almacenamos en el a-cumulador
    add 1; incrementamos el valor que hay en a en 1
    ld (iy+enemy.x), a ; se lo metemos al atributo posicion X
    and 1 ;con 0000 0001 obtenemos en a un 0 si es par ...00,...10 o un 1 si es ...01,...11, es decir, activa el flag z con los impares
    jp z, enemy_right_es_impar
    ld a, 8*4
    ld (iy+enemy.sprite),a ;le metemos el sprite que mira hacia la derecha 2
    ret
enemy_right_es_impar:
    ld a, 9*4
    ld (iy+enemy.sprite),a ;le metemos el sprite que mira hacia la derecha 2
    ret
move_enemy_left:
    ld a,(iy+enemy.x); 
    sub 1  
    ld (iy+enemy.x), a 
    and 1
    jp z, enemy_left_es_impar
    ld a, 10*4 
    ld (iy+enemy.sprite),a
    ret
enemy_left_es_impar:
    ld a, 11*4
    ld (iy+enemy.sprite),a ;le metemos el sprite que mira hacia la derecha 2
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




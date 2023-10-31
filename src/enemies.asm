enemy_atributes:
    struct enemy 
y       db      0
x       db      0
plane   db      0
color   db      0
    ends
randData: db 14,10


initialize_enemy:
    push ix
    ld ix, enemy_atributes
    ld a,130
    ld (ix+enemy.y),a ;le ponemos a la posición y un 130
    ld a,255
    ld (ix+enemy.x),a ;le ponemos a la posición x 255
    ld a,8*4
    ld (ix+enemy.plane),a ;Le ponemos el patrón 8
    ld a,4 ; el 4 es el color azul oscuro
    ld (ix+enemy.color),a 
    pop ix
    ret
update_enemy:
    ld ix, enemy_atributes
    ;obtenemos la posición x
    ld a,(ix+enemy.x)
    ;si la posición x es 0
    cp 8
    jp z, recolocar_enemy
    jp nz, pintar_enemy
recolocar_enemy:
    ;call rand16
    call random
    ;ld a,(SEED)
    ld a,(randData)
    ld (ix+enemy.y),a
    ld a,250
    ld (ix+enemy.x),a
pintar_enemy:
    call move_enemy_left
    ld hl, enemy_atributes 
    ;#1b00 dirección tabla de atributos en VRAM  
    ld de, 6912+4  ; el patron 0 es el del player, el enemigo 1 tendrá el 2 plano y como son 4 bytes=6912+4
    ld bc, 4; 4 bytes para copiar
    call  LDIRVM 
    ;pop ix
    ret


move_enemy_right:
    ld a,(ix+enemy.x); obetenemos el valor actual de la posicion x y lo almacenamos en el a-cumulador
    add 1; incrementamos el valor que hay en a en 1
    ld (ix+enemy.x), a ; se lo metemos al atributo posicion X
    and 1 ;con 0000 0001 obtenemos en a un 0 si es par ...00,...10 o un 1 si es ...01,...11, es decir, activa el flag z con los impares
    jp z, enemy_right_es_impar
    ld a, 8*4
    ld (ix+enemy.plane),a ;le metemos el sprite que mira hacia la derecha 2
    ret
enemy_right_es_impar:
    ld a, 9*4
    ld (ix+enemy.plane),a ;le metemos el sprite que mira hacia la derecha 2
    ret
move_enemy_left:
    ld a,(ix+enemy.x); 
    sub 1  
    ld (ix+enemy.x), a 
    and 1
    jp z, enemy_left_es_impar
    ld a, 10*4 
    ld (ix+enemy.plane),a
    ret
enemy_left_es_impar:
    ld a, 11*4
    ld (ix+enemy.plane),a ;le metemos el sprite que mira hacia la derecha 2
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
    ;and %01111111  ; al hacer el 7 bit a 0 no puede tomar valores mayor de 127
    cp 80           ;le hacemos la resta con 100 si el resultado es menor que 0 se activará el flag de carry
    jr c, random    
    cp 160
    jr nc, random
    ld (randData),a
    ret




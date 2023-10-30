enemy_atributes:
    struct enemy 
y       db      0
x       db      0
plane   db      0
color   db      0
    ends
;enmey_y_positions: db 100,50,150,40,70,170,60,30
SEED: equ rand16 + 1

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
    call rand16
    ld a,(SEED)
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
    ld a,(ix+enemy.x); obetenemos el valor actual de la posicion x
    add 1; incrementamos en 1 el valor
    ld (ix+enemy.x), a ; se lo metemos al atributo posicion X
    and 1
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

rand16:
   ld	BC,0
   ld	HL,253
   xor A
   sbc HL,BC
   sbc A,B
   sbc HL,BC
   sbc A,B
   ld	C,A
   sbc HL,BC
   jr	nc,.end
   inc HL
.end
   ld	(SEED),HL ; self modifying code (seed is hardcoded in opcode)
   ret

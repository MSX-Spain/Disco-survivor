;player_atributes: ds 4,0
player_atributes:
    struct player 
y       db      0
x       db      0
plane   db      0
color   db      0
    ends



initialize_player:
    ld ix, player_atributes
    ld a,160
    ld (ix+player.y),a ;le ponemos a la posición y un 160
    ld a,120 
    ld (ix+player.x),a ;le ponemos a la posición x 120
    ld a,0
    ld (ix+player.plane),a ;Le ponemos el patrón 0
    ld a,11 ; el 11 es el color amarillo
    ld (ix+player.color),a 
    ret
update_player:
    ld hl, player_atributes 
    ld de, 6912 ;#1b00 dirección tabla de atributos en VRAM    
    ld bc, 4; 4 bytes para copiar
    call  LDIRVM 
    ret


move_player_right:
    ld a,(ix+player.x); obetenemos el valor actual de la posicion x
    add 1; incrementamos en 1 el valor
    ld (ix+player.x), a ; se lo metemos al atributo posicion X
    and 1
    jp z, right_es_impar
    ld a, 0
    ld (ix+player.plane),a ;le metemos el sprite que mira hacia la derecha 2
    ret
right_es_impar:
    ld a, 1*4
    ld (ix+player.plane),a ;le metemos el sprite que mira hacia la derecha 2
    ret
move_player_left:
    ld a,(ix+player.x); 
    sub 1  
    ld (ix+player.x), a 
    and 1
    jp z, left_es_impar
    ld a, 2*4 
    ld (ix+player.plane),a
    ret
left_es_impar:
    ld a, 3*4
    ld (ix+player.plane),a ;le metemos el sprite que mira hacia la derecha 2
    ret
move_player_up:
    ld a,(ix+player.y)
    sub 1 
    ld (ix+player.y), a 
    and 1
    jp z, up_es_impar
    ld a, 4*4
    ld (ix+player.plane),a
    ret
up_es_impar:
    ld a, 5*4
    ld (ix+player.plane),a ;le metemos el sprite que mira hacia la derecha 2
    ret
move_player_down:
    ld a,(ix+player.y)
    add 1 
    ld (ix+player.y), a 
    and 1
    jp z, down_es_impar
    ld a, 6*4
    ld (ix+player.plane),a
    ret
down_es_impar:
    ld a, 7*4
    ld (ix+player.plane),a ;le metemos el sprite que mira hacia la derecha 2
    ret
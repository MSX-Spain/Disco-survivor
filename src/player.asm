;player_atributes: ds 4,0
player_atributes:
    struct player 
y       db      0
x       db      0
plane   db      0
color   db      0
    ends
tile0: db 0


initialize_player:
    ld ix, player_atributes
    ld a,160
    ld (ix+player.y),a ;le ponemos a la posición y un 160
    ld a,0 
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
    ld a,(ix+player.x); obtenemos el valor actual de la posicion x
    add 1; incrementamos en 1 el valor
    ld (ix+player.x), a ; se lo metemos al atributo posicion X
    and 1
    jp z, right_es_impar
    ld a, 0
    ld (ix+player.plane),a ;le metemos el sprite que mira hacia la derecha 2
    call checkColision
    ret
right_es_impar:
    ld a, 1*4
    ld (ix+player.plane),a ;le metemos el sprite que mira hacia la derecha 2
    call checkColision
    ret
move_player_left:
    ld a,(ix+player.x); 
    sub 1  
    ld (ix+player.x), a 
    and 1
    jp z, left_es_impar
    ld a, 2*4 
    ld (ix+player.plane),a
    call checkColision
    ret
left_es_impar:
    ld a, 3*4
    ld (ix+player.plane),a 
    call checkColision
    ret
move_player_up:
    ld a,(ix+player.y)
    sub 1 
    ld (ix+player.y), a 
    and 1
    jp z, up_es_impar
    ld a, 4*4
    ld (ix+player.plane),a
    call checkColision
    ret
up_es_impar:
    ld a, 5*4
    ld (ix+player.plane),a 
    call checkColision
    ret
move_player_down:
    ld a,(ix+player.y)
    add 1 
    ld (ix+player.y), a 
    and 1
    jp z, down_es_impar
    ld a, 6*4
    ld (ix+player.plane),a
    call checkColision
    ret
down_es_impar:
    ld a, 7*4
    ld (ix+player.plane),a 
    call checkColision
    ret


checkColision:
    xor b
    call dame_el_tile_que_hay_en_x_e_y
    ld a,b
    cp 43
    jp z,increase_screen
    cp 32 ;Si al restalo entre 32 da negatico se activará el flag de carry
    jr nc, colision_player ; si al restarlo  es negativo y dará carry, si no hay está bien
    ret

colision_player:
    call BEEP

    ret

;----------------------------------
;Vamos a hacer esta formula (y/8)*32+(x/8)
;esta es la parte (y/8)*32
;d tiene la posicion de x
;e tiene la posicion de y
dame_el_tile_que_hay_en_x_e_y:
    xor a
    ld a,(ix+player.y) ;a=posicion y en pixeles
    add 16
    ;con srl estas dividiendo entre 2,ya que corre a la derecha los bits. 
    ;al hacerlo 3 veces es como dividir entre 8,a=y/8: 1.01001100, 2.00100110, 3.00010011
    srl a  
    srl a  
    srl a  
    ld h,0 ; en h le ponemos un 0 
    ld l,a ;y en los 8 bytes de "l" le ponemos el valor que contiene a

    ;-----------------
    ;Buscando la fila
    add hl, hl ;x32, sumar algo por si mismo es como multiplizarlo por 2, si lo repetivos 5 es como si o multiplixaramos por 32
    add hl, hl 
    add hl, hl 
    add hl, hl 
    add hl, hl 

    ;-----------------
    ;Esta es la parte +(x/8)
    ld a,(ix+player.x) ;a=x
    add 8
    srl a 
    srl a 
    srl a 
    ld d,0
    ld e,a ;e=x
    add hl,de ;hl=(y/8)*32+(x/8)

    ld de, map_buffer; dirección buffer colisiones
    add hl,de ;hl=buffer_colisiones + (y/8)*32+(x/8)

    ld b,(hl) ;metemos en a el tile que nos pide
    ;ld (tile0),a
    ret

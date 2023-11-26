;player_atributes: ds 4,0
player_atributes:
    struct player 
y           db    0
x           db    0
pattern_def db    0; el player tendrá el patrón 0, el player 2*4=8, el enemy 1 el 3*12=12, estos patrones deben de coincidi con los dibujos de sprites que hemos dibujado
color       db    0
direction   db    0
collision   db    0
    ends
tile0: db 0


create_player:
    ld ix, player_atributes
    ld a,150
    ld (ix+player.y),a ;le ponemos a la posición y un 160
    ld a,8
    ld (ix+player.x),a ;le ponemos a la posición x 120
    ld a,0
    ld (ix+player.pattern_def),a ;Le ponemos el patrón 0
    ld a,11 ; el 11 es el color amarillo
    ld (ix+player.color),a 
    ret
render_player:
    ld hl, player_atributes 
    ld de, 6912 ;#1b00 dirección tabla de atributos en VRAM    
    ld bc, 4; 4 bytes para copiar
    call  LDIRVM 
    ret
update_player:
    xor a
    call GTSTCK
    ;call Readjoystick
    cp 1
    jp z, move_player_up
    ;cp 2
    ;jp z, move_player_up_right
    cp 3
    jp z, move_player_right
    ;cp 4
    ;jp z, move_player_down_right
    cp 5
    jp z, move_player_down
    ;cp 6
    ;jp z, move_player_down_left
    cp 7
    jp z, move_player_left
    ;cp 8
    ;jp z, move_player_up_left
    ;ld a,(player.collision)
    ;cp 1
    ;jp z,HUD
.update_player_end:
    ret


move_player_right:
    ;Le metemos la dirección al player
    ld a,RIGHT
    ld (ix+player.direction),a

    ;comprobamos los límites de la pantalla
    ld a,(ix+player.x)
    cp 240
    jr z,.move_player_right_end

    ;Comprobamos las colisones
    call check_collision_player
    ld a,(ix+player.collision)
    cp 1
    jr z, .move_player_right_end; si hay colisón saltamos la parte siguiente  hacemos que vaya al final

    ld a,(ix+player.x); obtenemos el valor actual de la posicion x
    add 1; incrementamos en 1 el valor
    ld (ix+player.x), a ; se lo metemos al atributo posicion X
    and 1
    jp z, right_es_impar
    ld a, 0
    ld (ix+player.pattern_def),a ;le metemos el sprite que mira hacia la derecha 2
.move_player_right_end:
    ld a,0
    ld (ix+player.collision),a
    ret

    
right_es_impar:
    ld a, 1*4
    ld (ix+player.pattern_def),a ;le metemos el sprite que mira hacia la derecha 2

    ret
move_player_left:
    ;le ponemos la dirección
    ld a,LEFT
    ld (ix+player.direction),a

    ;comprobamos los límites de la pantalla
    ld a,(ix+player.x)
    cp 0
    jr z,.move_player_left_end

    ;comprobamos las colisiones
    call check_collision_player
    ;su hubo uno colisión saltamos y vamos a la parte final
    ld a,(ix+player.collision)
    cp 1
    jr z, .move_player_left_end
    ld a,(ix+player.x)
    sub 1  
    ld (ix+player.x), a 
    and 1
    jp z, left_es_impar
    ld a, 2*4 
    ld (ix+player.pattern_def),a
.move_player_left_end:
    ld a,0
    ld (ix+player.collision),a
    ret
left_es_impar:
    ld a, 3*4
    ld (ix+player.pattern_def),a 
    ret
move_player_up:
    ;le ponemos la dirección
    ld a,UP
    ld (ix+player.direction),a

    ;comprobamos los límites de la pantalla
    ld a,(ix+player.y)
    cp 0; 
    jr z,.move_player_up_end

    ;comprobamos las colisiones
    call check_collision_player
    ;si hubo uno colisión saltamos y vamos a la parte final
    ld a,(ix+player.collision)
    cp 1
    jr z, .move_player_up_end
    
    ;actualizamos el player
    ld a,(ix+player.y)
    sub 1 
    ld (ix+player.y), a 
    ;Ponemos el sprite correspondiente
    and 1
    jp z, up_es_impar
    ld a, 4*4
    ld (ix+player.pattern_def),a
.move_player_up_end:
    ld a,0
    ld (ix+player.collision),a
    ret
up_es_impar:
    ld a, 5*4
    ld (ix+player.pattern_def),a 
    ret
move_player_down:
    ;le ponemos la dirección
    ld a,DOWN
    ld (ix+player.direction),a

    ;comprobamos los límites de la pantalla
    ld a,(ix+player.y)
    cp 159; 192-8-8-16-2
    jr z,.move_player_down_end


    call check_collision_player
    ;si hubo uno colisión saltamos y vamos a la parte final
    ld a,(ix+player.collision)
    cp 1
    jr z, .move_player_down_end

    ld a,(ix+player.y)
    add 1 
    ld (ix+player.y), a 
    and 1
    jp z, down_es_impar
    ld a, 6*4
    ld (ix+player.pattern_def),a
.move_player_down_end:
    ld a,0
    ld (ix+player.collision),a
    ret
down_es_impar:
    ld a, 7*4
    ld (ix+player.pattern_def),a 
    ret


;;--------------------------------------
;;  CHECKCOLISION
;;      Output: si hay colsión mete en la variable player.colision=1
check_collision_player:
    ld hl, player_atributes
    ld a,(hl)
    ld e,a;y
    inc hl
    ld a,(hl)
    ld d,a;x

    ld a,(ix+player.direction)
    cp RIGHT
    jr z,.get_block_right
    cp LEFT
    jr z,.get_block_left
    cp UP
    jr z,.get_block_up
    cp DOWN
    jr z,.get_block_down

    jr .not_direction_found
.get_block_right:
    ld a,d
    add 4
    ld d,a
    jp .not_direction_found
.get_block_left:
    ld a,d
    sub 4
    ld d,a
    jp .not_direction_found
.get_block_up:
    ld a,e
    sub 8
    ld e,a
    jp .not_direction_found
.get_block_down:
    ld a,e
    add 1
    ld e,a


.not_direction_found:
    ;get_block necesita en el registro e la posición x y en d la posición y, devuelve el resultado en b
    call get_block
    ld a,b
    cp TILE_DOOR
    jp z,increase_screen
    cp TILE_BOTTLE1 ;Si al restalo entre 32 da negatico se activará el flag de carry
    jr Z, botella_cogida ; si al restarlo  es negativo y dará carry, si no hay está bien
    cp TILE_BOTTLE2 ;Si al restalo entre 32 da negatico se activará el flag de carry
    jr Z, botella_cogida ; si al restarlo  es negativo y dará carry, si no hay está bien
    cp TILE_SOLID ;Si al restalo entre 32 da negatico se activará el flag de carry
    jr nc, colision_player ; si al restarlo  es negativo y dará carry, si no hay está bien

    ret

colision_player:
    call efecto_golpe
    ld a,1
    ld (ix+player.collision),a
    ret
    
recolocate_player:
    ld a,150
    ld (ix+player.y),a
    ld a,8
    ld (ix+player.x),a
    ;call update_player
    ret
botella_cogida:
    call efecto_coge_botella
    ;ponemos en ese tile un tile negro
    ld a,(ix+player.y) ;a=posicion y en pixeles
    add 16
    ;con srl estas dividiendo entre 2,ya que corre a la derecha los bits. 
    ;al hacerlo 3 veces es como dividir entre 8,a=y/8: 1.01001100, 2.00100110, 3.00010011
    srl a  
    srl a  
    srl a  
    ld h,0 ; en h le ponemos un 0 
    ld l,a ;y en los 8 bytes de "l" le ponemos el valor que contiene a
    ;;-----------------
    ;Buscando la fila
    add hl, hl ;x32, sumar algo por si mismo es como multiplizarlo por 2, si lo repetivos 5 es como si o multiplixaramos por 32
    add hl, hl 
    add hl, hl 
    add hl, hl 
    add hl, hl 


    ld a,(ix+player.x)
    add 8
    srl a 
    srl a 
    srl a 
    ld d,0
    ld e,a ;e=x
    add hl,de ;hl=(y/8)*32+(x/8)

    ;actualizamos el buffer
    push hl
    ld de, map_buffer
    add hl,de
    ex de,hl
    ld hl, tile_negro
    ld bc, 1
    ldir
    pop hl

    ld de, 6144
    add hl, de
    ex de,hl
    

    ld hl, tile_negro
    ld bc, 1
    call LDIRVM

    ;actualizamos el score
    ld a,(score)
    add 1
    ld (score),a
    call hud

    ret
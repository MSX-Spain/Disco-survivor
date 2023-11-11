create_player:
    ld ix, template_player
    ld a,150
    ld (ix+player.y),a ;le ponemos a la posición y un 160
    ld a,8
    ld (ix+player.x),a ;le ponemos a la posición x 120
    ld a,0
    ld (ix+player.plane),a ;Le ponemos el patrón 0
    ld a,11 ; el 11 es el color amarillo
    ld (ix+player.color),a 
    ret
recolocate_player:
    ld a,150
    ld (ix+player.y),a
    ld a,0
    ld (ix+player.x),a
    ld a,1
    ld (IN_GAME),a;controla que esté en juego
    ret
render_player:
    ld hl, template_player 
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
.update_player_end:
    ret


move_player_right:
    ;Le metemos la dirección al player
    ld a,3
    ld (ix+player.direction),a

    ;comprobamos los límites de la pantalla
    ld a,(ix+player.x)
    cp 240
    jr z,.move_player_right_end

    ;Comprobamos las colisones
    call check_collision_player
  
    ld a,(ix+player.x); obtenemos el valor actual de la posicion x
    add 1; incrementamos en 1 el valor
    ld (ix+player.x), a ; se lo metemos al atributo posicion X
    and 1
    jp z, right_es_impar
    ld a, 0
    ld (ix+player.plane),a ;le metemos el sprite que mira hacia la derecha 2
.move_player_right_end:
    ld a,0
    ld (ix+player.collision),a
    ret
right_es_impar:
    ld a, 1*4
    ld (ix+player.plane),a ;le metemos el sprite que mira hacia la derecha 2

    ret
move_player_left:
    ;le ponemos la dirección
    ld a,7
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

    ;cp 1
    ld a,(ix+player.x)
    sub 1  
    ld (ix+player.x), a 
    and 1
    jp z, left_es_impar
    ld a, 2*4 
    ld (ix+player.plane),a
.move_player_left_end:
    ld a,0
    ld (ix+player.collision),a
    ret
left_es_impar:
    ld a, 3*4
    ld (ix+player.plane),a 
    ret
move_player_up:
    ;le ponemos la dirección
    ld a,1
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
    ld (ix+player.plane),a
.move_player_up_end:
    ld a,0
    ld (ix+player.collision),a
    ret
up_es_impar:
    ld a, 5*4
    ld (ix+player.plane),a 
    ret
move_player_down:
    ;le ponemos la dirección
    ld a,5
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
    ld (ix+player.plane),a
.move_player_down_end:
    ld a,0
    ld (ix+player.collision),a
    ret
down_es_impar:
    ld a, 7*4
    ld (ix+player.plane),a 
    ret


;;--------------------------------------
;;  CHECKCOLISION
;;      Output: si hay colsión mete en la variable player.colision=1
check_collision_player:
    ld hl, template_player
    ld a,(hl)
    ld e,a;y
    inc hl
    ld a,(hl)
    ld d,a;x

    ld a,(ix+player.direction)
    cp 3
    jr z,.get_block_right
    cp 7
    jr z,.get_block_left
    cp 1
    jr z,.get_block_up
    cp 5
    jr z,.get_block_down

    jr .not_direction_found
.get_block_right:
    ld a,d
    add 8
    ld d,a
    jp .not_direction_found
.get_block_left:
    ld a,d
    sub 8
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
    call z,increase_screen

    cp TILE_SOLID ;Si al restalo entre 32 da negatico se activará el flag de carry  
    call nc, colision_player ; si al restarlo  es negativo y dará carry, si no hay está bien
    ret

colision_player:
    ;call BEEP
    ld a,1
    ld (ix+player.collision),a
    ld a,(IN_GAME)
    add 1
    ld (IN_GAME),a
    ret

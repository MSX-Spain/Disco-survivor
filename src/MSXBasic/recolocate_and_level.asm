load_screens:

    ld de, map_buffer 
    ld bc, MAP_SIZE
    push ix
    push hl
    call depack_RAM
    pop hl
    pop ix  
    ;ponemos el mapa en la VRAM
    ld hl, map_buffer
    ld de, 6144 
	;Le quitamos 64 ya que keremos pintar el HUD en las últimas 2 líneas de la pantalla
    ld bc, MAP_SIZE
    call  LDIRVM
    ret





recolocate_and_level_screen_1:
    ld hl, maps_tiled1
    call load_screens


    ld iy, template_enemy1
    ld a,7*8;y
    ld (iy+enemy.y),a
    ld a,20*8;x
    ld (iy+enemy.x),a
    ld a,COMPORTAMIENTO_REBOTA_VERTICAL
    ld (iy+enemy.type),a

    ld iy, template_enemy2
    ld a,16*8;y
    ld (iy+enemy.y),a
    ld a,25*8;x
    ld (iy+enemy.x),a
    ld a,COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a

    ld iy, template_enemy3
    ld a,18*8;y
    ld (iy+enemy.y),a
    ld a,28*8;x
    ld (iy+enemy.x),a
    ld a,COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy4
    ld a,20*8;y
    ld (iy+enemy.y),a
    ld a,23*8;x
    ld (iy+enemy.x),a

    ld iy, template_enemy5
    ld a,16*8;y
    ld (iy+enemy.y),a
    ld a,25*8;x
    ld (iy+enemy.x),a

    ld iy, template_enemy6
    ld a,15*8;y
    ld (iy+enemy.y),a
    ld a,15*8;x
    ld (iy+enemy.x),a

    ret
;en la pantalla 2 pondremos 2 que reboten horizonales junto a la puerta y otros 2 que eboten en el pasillo grande
recolocate_and_level_screen_2:
    ld hl, maps_tiled2
    call load_screens

    ld iy, template_enemy1
    ld a,18*8;y
    ld (iy+enemy.y),a
    ld a,11*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_COLETA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_VERTICAL
    ld (iy+enemy.type),a

    ld iy, template_enemy2
    ld a,18*8;y
    ld (iy+enemy.y),a
    ld a,20*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy3
    ld a,10*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    
    ld iy, template_enemy4
    ld a,12*8;y
    ld (iy+enemy.y),a
    ld a,16*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy5
    ld a,12*8;y
    ld (iy+enemy.y),a
    ld a,30*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a

    ret
recolocate_and_level_screen_3:
    ld hl, maps_tiled3
    call load_screens

    ld iy, template_enemy1
    ld a,18*8;y
    ld (iy+enemy.y),a
    ld a,11*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_COLETA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a

    ld iy, template_enemy2
    ld a,9*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_ENANO_DERECHA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a

    ld iy, template_enemy3
    ld a,7*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORRA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    
    ld iy, template_enemy4
    ld a,13*8;y
    ld (iy+enemy.y),a
    ld a,16*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ret

recolocate_and_level_screen_4:
    ld hl, maps_tiled4
    call load_screens
    
    ld iy, template_enemy1
    ld a,12*8;y
    ld (iy+enemy.y),a
    ld a,8*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_COLETA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_VERTICAL
    ld (iy+enemy.type),a

    ld iy, template_enemy2
    ld a,9*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_ENANO_DERECHA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a

    ld iy, template_enemy3
    ld a,7*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORRA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    
    ld iy, template_enemy4
    ld a,1*8;y
    ld (iy+enemy.y),a
    ld a,8*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS1
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy5
    ld a,1*8;y
    ld (iy+enemy.y),a
    ld a,24*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy6
    ld a,12*8;y
    ld (iy+enemy.y),a
    ld a,24*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, UP
    ld (iy+enemy.direction),a
    ld a, COMPORTAMIENTO_REBOTA_VERTICAL
    ld (iy+enemy.type),a

    ret
;-------------------------------------------------------------------------
;-------------------------------------------------------------------------
;------------------------- Screen 5 --------------------------------------
;-------------------------------------------------------------------------
;-------------------------------------------------------------------------
recolocate_and_level_screen_5:
    ld hl, maps_tiled5
    call load_screens

    
    ld iy, template_enemy1
    ld a,14*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_COLETA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_VERTICAL
    ld (iy+enemy.type),a

    ld iy, template_enemy2
    ld a,9*8;y
    ld (iy+enemy.y),a
    ld a,12*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_ENANO_DERECHA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a

    ld iy, template_enemy3
    ld a,7*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS2
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a
    
    ld iy, template_enemy4
    ld a,13*8;y
    ld (iy+enemy.y),a
    ld a,16*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy4
    ld a,12*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy5
    ld a,7*8;y
    ld (iy+enemy.y),a
    ld a,18*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy6
    ld a,20*8;y
    ld (iy+enemy.y),a
    ld a,10*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, LEFT
    ld (iy+enemy.direction),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    ret
;-------------------------------------------------------------------------
;-------------------------------------------------------------------------
;------------------------- Screen 6 --------------------------------------
;-------------------------------------------------------------------------
;-------------------------------------------------------------------------
recolocate_and_level_screen_6:
    ld hl, maps_tiled6
    call load_screens

    ld iy, template_enemy1
    ld a,2*8;y
    ld (iy+enemy.y),a
    ld a,4*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_COLETA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a

    ld iy, template_enemy2
    ld a,1*8;y
    ld (iy+enemy.y),a
    ld a,2*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_ENANO_DERECHA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a

    ld iy, template_enemy3
    ld a,6*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORRA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    
    ld iy, template_enemy4
    ld a,13*8;y
    ld (iy+enemy.y),a
    ld a,16*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy5
    ld a,3*8;y
    ld (iy+enemy.y),a
    ld a,16*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS3
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy6
    ld a,18*8;y
    ld (iy+enemy.y),a
    ld a,16*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS1
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    ret

;-------------------------------------------------------------------------
;-------------------------------------------------------------------------
;------------------------- Screen 7 --------------------------------------
;-------------------------------------------------------------------------
;-------------------------------------------------------------------------   
recolocate_and_level_screen_7:
    ld hl, maps_tiled7
    call load_screens

    ld iy, template_enemy1
    ld a,14*8;y
    ld (iy+enemy.y),a
    ld a,20*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_COLETA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_VERTICAL
    ld (iy+enemy.type),a

    ld iy, template_enemy2
    ld a,9*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_ENANO_DERECHA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a

    ld iy, template_enemy3
    ld a,7*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORRA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    
    ld iy, template_enemy4
    ld a,4*8;y
    ld (iy+enemy.y),a
    ld a,3*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS1
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy5
    ld a,14*8;y
    ld (iy+enemy.y),a
    ld a,6*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS2
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy6
    ld a,6*8;y
    ld (iy+enemy.y),a
    ld a,25*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS3
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    ret

;-------------------------------------------------------------------------
;-------------------------------------------------------------------------
;------------------------- Screen 8 --------------------------------------
;-------------------------------------------------------------------------
;-------------------------------------------------------------------------   
recolocate_and_level_screen_8:
    ld hl, maps_tiled8
    call load_screens

    ld iy, template_enemy1
    ld a,10*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_COLETA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_VERTICAL
    ld (iy+enemy.type),a

    ld iy, template_enemy2
    ld a,9*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_ENANO_DERECHA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a

    ld iy, template_enemy3
    ld a,5*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORRA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    
    ld iy, template_enemy4
    ld a,13*8;y
    ld (iy+enemy.y),a
    ld a,17*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_ENANO_DERECHA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy5
    ld a,16*8;y
    ld (iy+enemy.y),a
    ld a,16*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS4
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy6
    ld a,16*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS3
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a
    ret


;-------------------------------------------------------------------------
;-------------------------------------------------------------------------
;------------------------- Screen 9 --------------------------------------
;-------------------------------------------------------------------------
;-------------------------------------------------------------------------   

recolocate_and_level_screen_9:
    ld hl, maps_tiled9
    call load_screens

    ld iy, template_enemy1
    ld a,14*8;y
    ld (iy+enemy.y),a
    ld a,23*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_COLETA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_VERTICAL
    ld (iy+enemy.type),a

    ld iy, template_enemy2
    ld a,1*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_ENANO_DERECHA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a

    ld iy, template_enemy3
    ld a,5*8;y
    ld (iy+enemy.y),a
    ld a,18*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORRA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    
    ld iy, template_enemy4
    ld a,11*8;y
    ld (iy+enemy.y),a
    ld a,20*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a


    ld iy, template_enemy5
    ld a,17*8;y
    ld (iy+enemy.y),a
    ld a,16*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS4
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy6
    ld a,2*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS3
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a
    ret

;-------------------------------------------------------------------------
;-------------------------------------------------------------------------
;------------------------- Screen 10 --------------------------------------
;-------------------------------------------------------------------------
;-------------------------------------------------------------------------   

recolocate_and_level_screen_10:
    ld hl, maps_tiled10
    call load_screens

    ld iy, template_enemy1
    ld a,14*8;y
    ld (iy+enemy.y),a
    ld a,20*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_COLETA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_VERTICAL
    ld (iy+enemy.type),a

    ld iy, template_enemy2
    ld a,9*8;y
    ld (iy+enemy.y),a
    ld a,11*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_ENANO_DERECHA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a

    ld iy, template_enemy3
    ld a,11*8;y
    ld (iy+enemy.y),a
    ld a,9*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORRA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    
    ld iy, template_enemy4
    ld a,5*8;y
    ld (iy+enemy.y),a
    ld a,13*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy5
    ld a,6*8;y
    ld (iy+enemy.y),a
    ld a,24*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS2
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy6
    ld a,18*8;y
    ld (iy+enemy.y),a
    ld a,15*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS3
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    ret



recolocate_and_level_screen_11:
    ld hl, maps_tiled11
    call load_screens

    ld iy, template_enemy1
    ld a,6*8;y
    ld (iy+enemy.y),a
    ld a,15*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS2
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_VERTICAL
    ld (iy+enemy.type),a

    ld iy, template_enemy2
    ld a,5*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_ENANO_DERECHA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_PERSIGUE
    ld (iy+enemy.type),a

    ld iy, template_enemy3
    ld a,3*8;y
    ld (iy+enemy.y),a
    ld a,16*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORRA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    
    ld iy, template_enemy4
    ld a,4*8;y
    ld (iy+enemy.y),a
    ld a,12*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy5
    ld a,14*8;y
    ld (iy+enemy.y),a
    ld a,21*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS4
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a


    ld iy, template_enemy6
    ld a,17*8;y
    ld (iy+enemy.y),a
    ld a,16*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS2
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    ret
recolocate_and_level_screen_12:
    ld hl, maps_tiled12
    call load_screens

    ld iy, template_enemy1
    ld a,14*8;y
    ld (iy+enemy.y),a
    ld a,26*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_COLETA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_VERTICAL
    ld (iy+enemy.type),a

    ld iy, template_enemy2
    ld a,5*8;y
    ld (iy+enemy.y),a
    ld a,10*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_ENANO_DERECHA
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a

    ld iy, template_enemy3
    ld a,2*8;y
    ld (iy+enemy.y),a
    ld a,14*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS3
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    
    ld iy, template_enemy4
    ld a,11*8;y
    ld (iy+enemy.y),a
    ld a,16*8;x
    ld (iy+enemy.x),a
    ld a,UP
    ld (iy+enemy.direction),a
    ld a,ENEMIGO_GORDO
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_VERTICAL
    ld (iy+enemy.type),a

    ld iy, template_enemy5
    ld a,7*8;y
    ld (iy+enemy.y),a
    ld a,4*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS1
    ld (iy+enemy.pattern_def),a
    ld a,UP
    ld (iy+enemy.direction),a
    ld a, COMPORTAMIENTO_REBOTA_VERTICAL
    ld (iy+enemy.type),a

    ld iy, template_enemy6
    ld a,17*8;y
    ld (iy+enemy.y),a
    ld a,19*8;x
    ld (iy+enemy.x),a
    ld a,ENEMIGO_VIRUS2
    ld (iy+enemy.pattern_def),a
    ld a, COMPORTAMIENTO_REBOTA_HORIZONTAL
    ld (iy+enemy.type),a
    ret
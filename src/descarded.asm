;quizás aquí se ve mejor el dibujado de los enemigos:

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
    ;----------------------------------------------------------------------------------------------

    
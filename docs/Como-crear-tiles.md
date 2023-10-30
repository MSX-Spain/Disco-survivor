1.Comprendemos como se estructura la VRAM y donde van los bytes para definir los tiles, el color de los tiles y la posición de los tiles:

---------------------------------------------------------------------------------------------------
14336 / h3800 -> 16383 / 3fff
(tamaño 2048 / h800)
Tabla de patrones de sprites
En vasic base(14)
Aquí es donde se ponen los 8 bytes que componen tu sprite para definir su dibujo, con la
ayuda de la “tabla atributos de sprites” llamaremos a este bloque y le podremos su
posición en pantalla.



---------------------------------------------------------------------------------------------------
12288 / h3000 -> 14335 / h37ff
Tamaño: 2048 / h0800
Tabla color tiles banco 2
Aquí se definen los bloques de 8 bytes que definen el color de los tiles definidos en la
“tabla tiles banco 2” la tabla que representa a la parte superior de la pantalla

-------------------------------------

10240 / h2800 -> 12287 / h2fff
Tamaño: 2048 / h0800
Tabla color tiles banco 1
Aquí se definen los bloques de 8 bytes que definen el color de lostiles definidos en la
“tabla tiles banco 1” la tabla que representa a la parte central de la pantalla

-------------------------------------

8192 / h2000 ->10239 / h27ff
Tamaño: 2048/ h0800
Tabla color tiles banco 0
En basic base (11)
Aquí se definen los bloques de 8 bytes que definen el color de los tiles definidos en la
“tabla tiles banco 0” la tabla que representa a la parte inferior de la pantalla
h1800 vacía



---------------------------------------------------------------------------------------------------
6912 /h1b00 -> 7039 / h1b7f
Tamaño 128 /h0080
Tabla de atributos de Sprite (AOM)
En basic base(13)
Cada “atributo de Sprite” son 8 bytes que definen su bloque de 32 bits de la tabla
“patrones de sprite”,su posición x, y, color (los colores del sprite no tienen nada que ver
con los tiles)



---------------------------------------------------------------------------------------------------
6144 / h1800 -> 6911 / h1aff
Tamaño 768 / h0300
Tabla mapa o nombres de tiles
En basic base(10)
Aquí es donde se pone el bloque de bytes que corresponde con el tile definido en la tabla
“tiles banco 0,1,2”



---------------------------------------------------------------------------------------------------
4096 / h1000 -> 6148 /h17ff
Tamaño: 2048 / h0800
Tabla tiles banco 2
Lo mismo que banco 0 y banco 1 pero para el banco 2

-------------------------------------

2048 / h0800 -> 4095 / h0fff
Tamaño: 2048 /h0800
Tabla tiles banco 1
Lo mismo que el tiles banco 0 pero para el banco 1

-------------------------------------

0 / h0000 -> 2047 / h07ff
Tamaño: 2048/h0800
Tabla tiles banco 0
En basic base(12)
Aquíse definen los bloques de 8 bytes que definen 1 tile para la parte superior de la
pantalla de las 3 partes que tiene la pantalla (ejemplo 1) Este tile estará relacionado con
los 8 bytes del “Color tiles banco 0” y con la “tabla mapa” 
---------------------------------------------------------------------------------------------------


1. Nos descargamos el programa nMSXTiles de aquí: https://github.com/pipagerardo/nMSXtiles
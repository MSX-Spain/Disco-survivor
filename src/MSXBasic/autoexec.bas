1 'De la dirección #8000 a #8500 se la reservamos a las líneas basic de este autoexec'
10 color 15,1,1:screen2,2
1 'De la dirección #c000 en adelante keremos meter los mapas'
1 '15 clear 200, &hc000
1 'primero cargamos la pantalla de carga'
1 '20 bload "discoim.s02",s
1 'hacemos una pekeña àusa'
1 '30 for i=0 to 1000:next
1 'ponemos el reproductor de música en bf00
1 '35 bload"musicint.bin"
1 '2. Cargamos el lodaer en la dirección #8000 el cual tendrá las variables de screen (#8001), ingame(#8002), vidas(#8003) y puntuación(#8004-#8005)'
40 bload"loader.bin",r
1 'La dirección don se almacenan los mapas es a partir de #c000'
1 '50 bload "screen1.bin",r
60 bload "main.bin",r 
1 '100 bload "screen2.bin",r
1 '110 bload "main.bin",r 
1 '120 bload "screen3.bin",r
1 '130 bload "main.bin",r 
1 '140 bload "screen4.bin",r
1 '150 bload "main.bin",r 
1 '160 open "grp:" as #1:preset (0,180):print #1,"Final":close:goto 40


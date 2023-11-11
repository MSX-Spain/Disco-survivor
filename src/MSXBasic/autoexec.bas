10 cls:color 15,1,1 
1 '15 clear 200, &hd100
20 bload"loader.bin",r
1 '30 open "grp:" as #1  
1 '40 preset (0,180):print #1,"Loading level..."
50 bload "screen1.bin",r
60 bload "main.bin",r 
1 '70 line (0,170)-(256,190),9,BF
1 '80 asm=peek(&h8100)
1 '90 preset (0,180):print #1,"Loading level..."asm
100 bload "screen2.bin",r
110 bload "main.bin",r 
120 bload "screen3.bin",r
130 bload "main.bin",r 
140 bload "screen4.bin",r
150 bload "main.bin",r 
160 preset (0,180):print #1,"Final"

1000 goto 1000
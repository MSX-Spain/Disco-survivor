#!/bin/bash

#El makefile es una aplicación que viene por defecto en sistemas unix y que permite construir proyectos o en mingw o gitbash windows
#Definiendo una regla
#objetivo: dependencias
all: emulator main.bin 
	#Instrucciones para conseguir el objetivo
	mv obj/main.bin dsk/main.bin

main.bin: src/main.asm
	java -jar  tools/assemblers/glass/glass-0.5.jar src/main.asm obj/main.bin obj/main.lst

emulator:
	./tools/emulators/openmsx/mac/openMSX.app/Contents/MacOS/openmsx -script ./tools/emulators/openmsx/emul_start_config.txt

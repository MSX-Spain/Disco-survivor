#!/bin/bash
#1.Poner owemiao sw ejecución con: chmod +x make.sh
#2.Para compilar escribe ./make.sh

# ver las instruciones del z80: http://clrhome.org/table/
# ver las instrucciones de la bios: https://map.grauw.nl/resources/msxbios.php
# https://github.com/S0urceror/DeZog/releases

# /********Instalación debugger***********************************/
# Instalar: code --install-extension tools\dezog\dezog-2.0.1.vsix --force 
# Instalar: code --install-extension tools\dezog\dezog-1.3.5.vsix --force
# desistalar:  code --uninstall-extension tools\dezog\dezog-1.3.5.vsix
# Ver extensiones instaladas: code --list-extensions --show-versions





function clean() {
   echo "Objetos borrados"
   rm -rf ./obj/*.*
   #rm -rf ./bin/*.*
   rm -rf ./dsk/*.*
}


function prepareFiles() {
     #Creamos el autoexec.bas
     echo 10 cls:color 15,1,1 > dsk/autoexec.bas
     echo : bload \"loader.bin\",r >> dsk/autoexec.bas
     echo : bload \"main.bin\",r >> dsk/autoexec.bas
     # glass compiler: http://www.grauw.nl/projects/glass/
     #java -jar  tools/assemblers/glass/glass-0.5.jar src/main.asm main.bin main.lst
     #sjasmplus: https://github.com/z00m128/sjasmplus
     #Documentation: https://z00m128.github.io/sjasmplus/documentation.html
     #----------------------MAC chip intel--------------------------
     chmod +x ./tools/assemblers/sjasmplus/mac/sjasmplus
     ./tools/assemblers/sjasmplus/mac/sjasmplus --sym=obj/loader.sym --lst=loader.lst src/loader.asm 
     ./tools/assemblers/sjasmplus/mac/sjasmplus --sym=obj/main.sym --lst=main.lst src/main.asm 
     #---------------------------------------------------------------
     #----------------------MINGW windows----------------------------
     #./tools/assemblers/sjasmplus/windows/sjasmplus.exe --sym=obj/loader.sym --lst=obj/loader.lst src/loader.asm 
     #./tools/assemblers/sjasmplus/windows/sjasmplus.exe --sym=obj/main.sym --lst=obj/main.lst src/main.asm 
     #---------------------------------------------------------------
     #sjasm: https://www.xl2s.tk/sjasm42c.zip
     #Documentation: https://www.xl2s.tk/sjasmmanual.html
     #./tools/assemblers/sjasm/sjasm src/main.asm obj/main.list
     mv loader.bin obj/loader.bin
     mv loader.lst obj/loader.lst
     mv main.bin obj/main.bin
     mv main.lst obj/main.lst
     #mv main.bin dsk/main.bin
     #mv main.lst obj/main.lst
     #mv obj/main.sym obj/main.sym
     FILES=$(find "./obj" -iname *.bin -type f)
     for FILE in ${FILES[*]}; do
          cp "${FILE}" dsk/
     done
}

function openEmulator() {   
     #------------------------Windows---------------------------------
     #./tools/emulators/openmsx/mac/openMSX.app/Contents/MacOS/openmsx -script ./tools/emulators/openmsx/emul_start_config.txt
     #./tools/emulators/openmsx/openmsx.exe -machine Philips_NMS_8255 -diska dsk/
     #./tools/emulators/openmsx/openmsx.exe -control stdio -machine Philips_NMS_8255 -diska dsk/
     #---------------------------------------------------------------
     #-------------------------MAC-------------------------------
     /Applications/openMSX.app/Contents/MacOS/openMSX -machine Philips_NMS_8255 -script ./tools/emulators/openmsx/emul_start_config.txt &
     #---------------------------------------------------------------
}

function workWithDirAsDisk(){
    echo Escogiste trabajar con dir as disk
    clean
    prepareFiles
    openEmulator
}

# Check parameter number
if (( $# < 1 )); then
   workWithDirAsDisk
fi

## Check parameter
PARAM=$1   
case "$PARAM" in
   "-h") 
        #help
   ;;
   "all") 
        #echo "vamos a crear un dir as disk, dsk, rom y cas"
   ;;
   "dsk")
        #echo "Vamos a crear un dsk"
   ;;
   "rom")
        #echo "Vamos a crear un rom"
   ;;
   "cass")
        #echo "Vamos a crear un cass"
   ;;
   "clean")
      clean
   ;;
   #*) echo "ERROR: Parameter '${PARAM}' not valid"
   #help
   #;;
esac
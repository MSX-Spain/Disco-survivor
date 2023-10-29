#!/bin/bash
#https://github.com/S0urceror/DeZog/releases
#Instalar: code --install-extension tools\dezog\dezog-1.3.5.vsix
#desistalar:  code --uninstall-extension tools/dezog/dezog-1.3.5.vsix
#Ver extensiones instaladas: code --list-extensions --show-versions
#Escribe: netstat -a -o -n -b
#En Windows, -b es para mostrar el ejecutable involucrado en la creación de cada conexión o puerto de escucha.
#Complemento vscode DeZog
function clean() {
   echo "Objetos borrados"
   rm -rf ./obj/*.*
   #rm -rf ./bin/*.*
   rm -rf ./dsk/*.*
}


function prepareFiles() {
    #Creamos el autoexec.bas
    echo "10 bload\"main.bin\",r"> dsk/autoexec.bas
    # glass compiler: http://www.grauw.nl/projects/glass/
    #java -jar  tools/assemblers/glass/glass-0.5.jar src/main.asm main.bin main.lst
    #sjasmplus: https://github.com/z00m128/sjasmplus
    #Documentation: https://z00m128.github.io/sjasmplus/documentation.html
    #./tools/assemblers/sjasmplus/mac/sjasmplus --raw=obj/main.bin  --sym=obj/main.sym --lst=main.lst src/main.asm 
    ./tools/assemblers/sjasmplus/windows/sjasmplus.exe --raw=dsk/main.bin  --sym=obj/main.sym --lst=obj/main.lst src/main.asm 
    #sjasm: https://www.xl2s.tk/sjasm42c.zip
    #Documentation: https://www.xl2s.tk/sjasmmanual.html
    #./tools/assemblers/sjasm/sjasm src/main.asm obj/main.list
    # mv main.com obj/main.com
    #mv main.bin dsk/main.bin
    #mv main.lst obj/main.lst
    #mv obj/main.sym obj/main.sym
}

function openEmulator() {   
    #./tools/emulators/openmsx/mac/openMSX.app/Contents/MacOS/openmsx -script ./tools/emulators/openmsx/emul_start_config.txt
    ./tools/emulators/openmsx/openmsx.exe -machine Philips_NMS_8255 -diska dsk/
    # ./tools/emulators/openmsx/openmsx.exe -control stdio -machine Philips_NMS_8255 -diska dsk/

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
      cleanObjects
   ;;
   #*) echo "ERROR: Parameter '${PARAM}' not valid"
   #help
   #;;
esac
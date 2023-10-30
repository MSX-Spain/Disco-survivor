@echo off&cls&call:main %1&goto:EOF

rem ver las instruciones del z80: http://clrhome.org/table/
rem ver las instrucciones de la bios: https://map.grauw.nl/resources/msxbios.php
rem https://github.com/S0urceror/DeZog/releases

rem /********Instalación debugger***********************************/
rem Instalar: code --install-extension tools\dezog\dezog-2.0.1.vsix --force 
rem Instalar: code --install-extension tools\dezog\dezog-1.3.5.vsix --force
rem desistalar:  code --uninstall-extension tools\dezog\dezog-1.3.5.vsix
rem Ver extensiones instaladas: code --list-extensions --show-versions
rem Escribe: netstat -a -o -n -b
rem En Windows, -b es para mostrar el ejecutable involucrado en la creación de cada conexión o puerto de escucha.
rem Complemento vscode DeZog

rem /********Estructura proyecto***********************************/
rem src=archivos .bas y .asm con el código fuente
rem obj=archivos generados por los archivos del código fuente y programas
rem tools=herramientas o programas de ayuda
rem dsk=simula una unidad de disco

rem /********git***********************************/
rem he creado otra rama para meter cargadores con 
rem git branch loader -> para crear una nueva rama
rem git branch -a  -> para ver todos las ramas
rem git branch  -> para ver en la rama donde estás
rem git checkout loader -> para cambiar de rama
rem git branch -d loader  -> Elimina la rama loader, (situate en la pricipal)

:main
    echo MSX Spain 2023
    rem Ckequeando parámetros
    if [%1]==[] (call :create)
    if [%1]==[all] (call :createAll)
    if [%1]==[dsk] (call :createDsk)
    if [%1]==[rom] (call :createRom)
    if [%1]==[cas] (call :createCas)
    if [%1]==[clean] (call :clean)
    rem Si el argumento no está vacío, ni es dsk, ni es cas, etc
    rem If the argument is not empty, neither is it dsk, nor is it cas, etc.
    if [%1] NEQ [] (
        if [%1] NEQ [all] (
            if [%1] NEQ [rom] (
                if [%1] NEQ [dsk] (
                    if [%1] NEQ [cas] ( 
                        if [%1] NEQ [clean] (call :help) 
                    )
                )
            )
        }
    )    
goto:eof

:create
    echo Spanish: Escogiste crear dir as disk
    echo English: You chose to create dir as disk
    call :clean
    call :preparedFiles
    call :openEmulator
goto:eof
:createAll
        echo Spanish: Escogiste crear dsk, rom y cas
        echo English: You chose to create dsk,rom, cas
goto:eof

:createDSK
        echo Spanish: Escogiste crear dsk
        echo English: You chose to create dsk
        call :createMainDSK
goto:eof


:createRom
        echo Spanish: Escogiste crear rom
        echo English: You chose to create rom
goto:eof



:createCas
        echo Spanish: Escogiste crear cas
        echo English: You chose to create cas
goto:eof

:clean
    echo Spanish: escogiste borrar objetos
    echo English: You chose to delete objects
    if exist obj del /F /Q obj\*.*
    if exist dsk del /F /Q dsk\*.*
goto:eof

:help
     echo Spanish: No reconozco la sintaxis, escribe:
     echo English: I don't recognize the syntax, write:
     echo .
     echo make [dsk|rom|cas|clean]
goto:eof



:preparedFiles
        echo 10 cls:color 15,1,1 > dsk/autoexec.bas
        echo 20 bload"loader.bin",r >> dsk/autoexec.bas
        echo 30 bload "main.bin",r >> dsk/autoexec.bas
        rem /************Compilando a ensamblador******************/
        rem glass compiler (http://www.grauw.nl/projects/glass/) es un compilador de ensamblador z80 que puedo convertir tu código ensamblador en los archivos binarios.rom y .bin
        rem java -jar  tools\assemblers\glass\glass-0.5.jar src\main.asm obj\main.bin obj\main.sym

        rem sjasmplus: https://github.com/z00m128/sjasmplus
        rem Documentation: https://z00m128.github.io/sjasmplus/documentation.html
        tools\assemblers\sjasmplus\windows\sjasmplus.exe --sym=obj\loader.sym --lst=obj\loader.lst src\loader.asm 
        rem tools\assemblers\sjasmplus\windows\sjasmplus.exe --raw=obj\main.bin --sym=obj\main.sym --lst=obj\main.lst src\main.asm 
        tools\assemblers\sjasmplus\windows\sjasmplus.exe --sym=obj\main.sym --lst=obj\main.lst src\main.asm 

        rem sjasm
        rem tools\assemblers\sjasm\sjasm.exe src/main.asm 

        rem asMSX: https://github.com/Fubukimaru/asMSX
        rem tools\assemblers\asMSX\win32\asmsx.exe main.asm


        rem /************Preparando archivos******************/
        move /Y main.bin ./obj
        move /Y loader.bin ./obj
        rem move /Y src\main.lst ./obj
        rem move /Y main.sym ./obj
        rem del /F src/main.lst

        rem /************creando carpeta dsk******************/
        if not exist dsk mkdir dsk
        for /R obj/ %%a in (*.bin) do (
                copy "%%a" dsk)   
goto:eof

:createMainDSK
        rem /************Creando el .dsk******************/
        if not exist main.dsk copy tools\Disk-Manager\main.dsk
        for /R dsk/ %%a in (*.*) do (
           start /wait tools\Disk-Manager\DISKMGR.exe -A -F -C main.dsk "%%a" )   
        move /Y main.dsk ./docs
goto:eof


:openEmulator
        rem /***********Abriendo el emulador***********/

        rem/************openMSX******************/
        rem presiona f9 al arrancar para que vaya rápido
        start /wait tools\emulators\openmsx\openmsx.exe -script tools/emulators/openmsx/emul_start_config.txt
        rem Abriendo con FMSX https://fms.komkon.org/fMSX/fMSX.html
        rem start /wait emulators/fMSX/fMSX.exe -diska main.dsk
goto:eof
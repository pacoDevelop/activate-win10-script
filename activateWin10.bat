@echo off



REM Comprobar si se está ejecutando con privilegios elevados
>nul 2>&1 net session
if %errorlevel% equ 0 (
    color 2
    echo El script se esta ejecutando con privilegios elevados - administrador.
) else (
    color 4
    echo El script NO se esta ejecutando con privilegios elevados - usuario estandar.
    pause
    exit /b 1
)

REM Define los arrays de claves por sistema operativo
set "Windows10Home=4CPRK-NM3K3-X6XXQ-RXX86-WXCHW KTNPV-KTRK4-3RRR8-39X6W-W44T3 YTMG3-N6DKC-DKB77-7M9GH-8HVX7 TX9XD-98N7V-6WMQ6-BX7FG-H8Q99"
set "Windows10HomeN=3KHY7-WNT83-DGQKR-F7HPR-844BM"
set "Windows10HomeSingleLanguage=NKJFK-GPHP7-G8C3J-P6JXR-HQRJR BT79Q-G7N6G-PGBYW-4YWX6-6F4BT"
set "Windows10HomeCountrySpecific=PVMJN-6DFY6-9CCP6-7BKTT-D3WVR"
set "Windows10Pro=W269N-WFGWX-YVC9B-4J6C9-T83GX 8N67H-M3CY9-QT7C4-2TR7M-TXYCV WYPNQ-8C467-V2W6J-TX4WX-WT2RQ"
set "Windows10ProN=MH37W-N47XK-V7XM9-C7227-GCQG9 2B87N-8KFHP-DKV6R-Y2C8J-PKCKT"
set "Windows10ProforWorkstation=DXG7C-N36C4-C4HTG-X4T3X-2YV77"
set "Windows10Enterprise=XGVPP-NMH47-7TTHJ-W3FW7-8HV2C CKFK9-QNGF2-D34FM-99QX2-8XC4K RW7WN-FMT44-KRGBK-G44WK-QV7YK WNMTR-4C88C-JK8YV-HQ7T2-76DF9 2F77B-TNFGY-69QQF-B8YKP-D69TJ"
set "Windows10EnterpriseN=DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4 WGGHN-J84D6-QYCPR-T7PJ7-X766F"
set "Windows10EnterpriseLTSB2016=RW7WN-FMT44-KRGBK-G44WK-QV7YK"
set "Windows10EnterpriseLTSC2019=M7XTQ-FN8P6-TTKYV-9D4CC-J462D"
set "Windows10Education=YNMGQ-8RYV3-4PGQ3-C8XTP-7CFBY 8PTT6-RNW4C-6V7J2-C2D3X-MHBPB 84NGF-MHBT6-FXBX8-QWJK7-DRR8H NW6C2-QMPVW-D7KKK-3GKT6-VCFB2 GJTYN-HDMQY-FRR76-HVGC7-QPF8P"
set "Windows10EducationN=2WH4N-8QGBV-H22JP-CT43Q-MDWWJ"
set "Windows10S=3NF4D-GF9GY-63VKH-QRC3V-7QW8P"

@REM REM Obtener el tipo de sistema operativo
for /f "delims=" %%a in ('wmic os get Caption ^| findstr "^Microsoft Windows 10"') do set "OS=%%a"

rem Definir la cadena con espacios al principio y al final
set "cadena=   %OS%   "

rem Eliminar los espacios en blanco al principio de la cadena
:trim_start
if "%cadena:~0,1%"==" " (
    set "cadena=%cadena:~1%"
    goto :trim_start
)

rem Eliminar los espacios en blanco al final de la cadena
:trim_end
if "%cadena:~-1%"==" " (
    set "cadena=%cadena:~0,-1%"
    goto :trim_end
)
set "OS=%cadena%"
echo Selected OS: %OS%
REM Seleccionar el array correspondiente al sistema operativo
if "%OS%"=="Microsoft Windows 10 Home" (
    set "SelectedArray=%Windows10Home%"
) else if "%OS%"=="Microsoft Windows 10 Home N" (
    set "SelectedArray=%Windows10HomeN%"
) else if "%OS%"=="Microsoft Windows 10 Home Single Language" (
    set "SelectedArray=%Windows10HomeSingleLanguage%"
) else if "%OS%"=="Microsoft Windows 10 Home Country Specific" (
    set "SelectedArray=%Windows10HomeCountrySpecific%"
) else if "%OS%"=="Microsoft Windows 10 Pro" (
    set "SelectedArray=%Windows10Pro%"
) else if "%OS%"=="Microsoft Windows 10 Pro N" (
    set "SelectedArray=%Windows10ProN%"
) else if "%OS%"=="Microsoft Windows 10 Pro for Workstation" (
    set "SelectedArray=%Windows10ProforWorkstation%"
) else if "%OS%"=="Microsoft Windows 10 Enterprise" (
    set "SelectedArray=%Windows10Enterprise%"
) else if "%OS%"=="Microsoft Windows 10 Enterprise N" (
    set "SelectedArray=%Windows10EnterpriseN%"
) else if "%OS%"=="Microsoft Windows 10 Enterprise LTSB 2016" (
    set "SelectedArray=%Windows10EnterpriseLTSB2016%"
) else if "%OS%"=="Microsoft Windows 10 Enterprise LTSC 2019" (
    set "SelectedArray=%Windows10EnterpriseLTSC2019%"
) else if "%OS%"=="Microsoft Windows 10 Education" (
    set "SelectedArray=%Windows10Education%"
) else if "%OS%"=="Microsoft Windows 10 Education N" (
    set "SelectedArray=%Windows10EducationN%"
) else if "%OS%"=="Microsoft Windows 10 S" (
    set "SelectedArray=%Windows10S%"
) else (
    echo Sistema operativo no detectado
    pause
    goto :eof
   
)

:newKey

REM Obtener una clave aleatoria del array seleccionado
setlocal enabledelayedexpansion

REM Contar el número de elementos en el array
set "count=0"
for %%a in (!SelectedArray!) do (
    set /a count+=1
)

REM Generar un número aleatorio entre 0 y count-1
set /a "random_number=!random! %% count"

REM Seleccionar la clave correspondiente al número aleatorio
set "SelectedKey="
set "index=0"
for %%a in (!SelectedArray!) do (
    if !index! equ !random_number! (
        set "SelectedKey=%%a"
        goto :end_loop
    )
    set /a index+=1
)
:end_loop

echo Selected Key: !SelectedKey!

REM Ejecutar los comandos utilizando la clave aleatoria seleccionada
slmgr /ipk %SelectedKey%
if %errorlevel% neq 0 (
    echo Probando nueva clave
    goto :newKey
)
echo Espere...
timeout /t 1 >nul
slmgr /skms kms.digiboy.ir
if %errorlevel% neq 0 (
    echo Probando nueva clave
    goto :newKey
)
echo Espere...
timeout /t 1 >nul
slmgr /ato
if %errorlevel% neq 0 (
    echo Probando nueva clave
    goto :newKey
)
@echo off
rem SUNSET RUN - compilar en Windows (doble clic o "build.bat" en una consola).
rem Necesita Python 3 (python.org). El ensamblador AS se descarga solo la
rem primera vez en tools\win\ (o descomprimelo ahi a mano, ver tools\win\LEEME.txt).
setlocal
cd /d "%~dp0"
set PY=
where py >nul 2>nul && set PY=py -3
if "%PY%"=="" where python >nul 2>nul && set PY=python
if "%PY%"=="" (
  echo No encuentro Python 3. Instalalo desde https://www.python.org/downloads/
  echo y marca la casilla "Add python.exe to PATH".
  pause
  exit /b 1
)
%PY% -c "import pycparser, PIL" >nul 2>nul
if errorlevel 1 (
  echo Instalando pycparser y pillow...
  %PY% -m pip install --user pycparser pillow
)

rem --- el ensamblador AS (asw.exe + p2bin.exe) ---------------------------
set ASFOUND=
for /r "tools\win" %%f in (asw.exe asl.exe) do if exist "%%f" set ASFOUND=1
if not defined ASFOUND (
  echo Descargando el ensamblador AS para Windows...
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; try { Invoke-WebRequest -UseBasicParsing -Uri 'http://john.ccac.rwth-aachen.de:8000/ftp/as/precompiled/i386-unknown-win32/aswcurr.zip' -OutFile 'tools\win\aswcurr.zip'; Expand-Archive -Force 'tools\win\aswcurr.zip' 'tools\win'; exit 0 } catch { Write-Host $_; exit 1 }"
  if errorlevel 1 (
    echo.
    echo No se ha podido descargar. Descarga a mano este fichero:
    echo   http://john.ccac.rwth-aachen.de:8000/ftp/as/precompiled/i386-unknown-win32/aswcurr.zip
    echo y descomprimelo dentro de la carpeta tools\win\ de este proyecto.
    pause
    exit /b 1
  )
)

set PYTHONUTF8=1
%PY% tools\build.py %*
if errorlevel 1 (
  echo.
  echo *** La compilacion ha fallado ***
  pause
  exit /b 1
)
echo.
echo Listo: bin\sunsetrun.ngc
pause

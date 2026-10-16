@echo off
rem SUNSET RUN - compilar en Windows (doble clic o "build.bat" en una consola).
rem Necesita Python 3 (python.org) y el ensamblador AS descomprimido en tools\win\
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

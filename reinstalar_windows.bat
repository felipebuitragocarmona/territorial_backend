@echo off
setlocal

REM Uso:
REM   reinstalar_windows.bat <REPO_URL> [DESTINO]
REM Ejemplo:
REM   reinstalar_windows.bat https://github.com/usuario/repositorio.git "Valoracion Territorial"

set "REPO_URL=%~1"
set "TARGET_DIR=%~2"

if "%REPO_URL%"=="" (
  echo [ERROR] Falta la URL del repositorio.
  echo Uso: %~nx0 ^<REPO_URL^> [DESTINO]
  exit /b 1
)

if "%TARGET_DIR%"=="" set "TARGET_DIR=Valoracion Territorial"

where git >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Git no esta instalado o no esta en PATH.
  exit /b 1
)

echo [INFO] Clonando repositorio en "%TARGET_DIR%"...
if exist "%TARGET_DIR%" (
  echo [INFO] La carpeta ya existe. Se actualizara con git pull.
  pushd "%TARGET_DIR%"
  git pull
  if errorlevel 1 (
    echo [ERROR] Fallo git pull.
    popd
    exit /b 1
  )
  popd
) else (
  git clone "%REPO_URL%" "%TARGET_DIR%"
  if errorlevel 1 (
    echo [ERROR] Fallo git clone.
    exit /b 1
  )
)

set "BACKEND_DIR=%TARGET_DIR%\territorial_backend_flask"
if not exist "%BACKEND_DIR%\requirements.txt" (
  echo [ERROR] No se encontro requirements.txt en "%BACKEND_DIR%".
  exit /b 1
)

pushd "%BACKEND_DIR%"

echo [INFO] Reinstalando entorno virtual...
if exist ".venv" rmdir /s /q ".venv"

py -3 -m venv .venv >nul 2>&1
if errorlevel 1 (
  python -m venv .venv
  if errorlevel 1 (
    echo [ERROR] No se pudo crear el entorno virtual.
    popd
    exit /b 1
  )
)

call ".venv\Scripts\activate.bat"
if errorlevel 1 (
  echo [ERROR] No se pudo activar el entorno virtual.
  popd
  exit /b 1
)

python -m pip install --upgrade pip
if errorlevel 1 (
  echo [ERROR] Fallo al actualizar pip.
  popd
  exit /b 1
)

pip install -r requirements.txt
if errorlevel 1 (
  echo [ERROR] Fallo instalando dependencias.
  popd
  exit /b 1
)

echo [OK] Clonado y reinstalacion completados.
popd
exit /b 0

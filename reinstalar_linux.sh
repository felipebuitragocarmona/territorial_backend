#!/usr/bin/env bash
set -euo pipefail

# Uso:
#   ./reinstalar_linux.sh <REPO_URL> [DESTINO]
# Ejemplo:
#   ./reinstalar_linux.sh https://github.com/usuario/repositorio.git "Valoracion Territorial"

REPO_URL="${1:-}"
TARGET_DIR="${2:-Valoracion Territorial}"

if [[ -z "$REPO_URL" ]]; then
  echo "[ERROR] Falta la URL del repositorio."
  echo "Uso: $(basename "$0") <REPO_URL> [DESTINO]"
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "[ERROR] Git no esta instalado o no esta en PATH."
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "[ERROR] python3 no esta instalado o no esta en PATH."
  exit 1
fi

echo "[INFO] Clonando repositorio en '$TARGET_DIR'..."
if [[ -d "$TARGET_DIR/.git" ]]; then
  echo "[INFO] La carpeta ya existe. Se actualizara con git pull."
  git -C "$TARGET_DIR" pull
else
  git clone "$REPO_URL" "$TARGET_DIR"
fi

BACKEND_DIR="$TARGET_DIR/territorial_backend_flask"
if [[ ! -f "$BACKEND_DIR/requirements.txt" ]]; then
  echo "[ERROR] No se encontro requirements.txt en '$BACKEND_DIR'."
  exit 1
fi

cd "$BACKEND_DIR"

echo "[INFO] Reinstalando entorno virtual..."
rm -rf .venv
python3 -m venv .venv

# shellcheck disable=SC1091
source .venv/bin/activate

python -m pip install --upgrade pip
pip install -r requirements.txt

echo "[OK] Clonado y reinstalacion completados."

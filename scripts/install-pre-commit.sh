#!/bin/bash

# Colores para la salida
GREEN='\033[0;32m'
NC='\033[0m' # No Color
YELLOW='\033[1;33m'
RED='\033[0;31m'

# Asegurar que estamos en la raíz del proyecto
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT" || exit 1

echo -e "${YELLOW}Configurando pre-commit...${NC}"

# Verificar si pre-commit está instalado
if ! command -v pre-commit &> /dev/null; then
    echo -e "${YELLOW}pre-commit no detectado.${NC}"

    if command -v uv &> /dev/null; then
        echo -e "${YELLOW}Intentando instalar pre-commit con uv tool...${NC}"
        uv tool install pre-commit --force

        # Agregar directorio de tools de uv al PATH temporalmente si es necesario
        # (Esto asume la ubicación estándar, pero puede variar)
        export PATH="$HOME/.local/bin:$PATH"
    else
        echo -e "${RED}Error: pre-commit no está instalado y no se encontró 'uv' para instalarlo.${NC}"
        echo -e "${YELLOW}Por favor instala pre-commit manualmente (ej: sudo pacman -S pre-commit, brew install pre-commit, o pipx install pre-commit)${NC}"
        exit 1
    fi
fi

# Verificar nuevamente
if ! command -v pre-commit &> /dev/null; then
    echo -e "${RED}No se pudo ejecutar pre-commit incluso después de intentar instalarlo.${NC}"
    echo -e "${YELLOW}Asegurate de que '$HOME/.local/bin' esté en tu PATH o reinicia tu terminal.${NC}"
    exit 1
fi

# Instalar los hooks
echo -e "${YELLOW}Instalando hooks de git...${NC}"
pre-commit install
pre-commit install --hook-type commit-msg

echo -e "${GREEN}✅ pre-commit configurado correctamente.${NC}"

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
if ! command -v pre-commit &> /dev/null
then
    echo -e "${RED}pre-commit no está instalado. Intentando instalar con pip...${NC}"
    pip install pre-commit
fi

# Instalar los hooks
echo -e "${YELLOW}Instalando hooks de git...${NC}"
pre-commit install
pre-commit install --hook-type commit-msg

echo -e "${GREEN}✅ pre-commit configurado correctamente.${NC}"

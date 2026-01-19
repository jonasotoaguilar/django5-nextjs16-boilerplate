#!/bin/bash

# Colores para la salida
GREEN='\033[0;32m'
NC='\033[0m' # No Color
YELLOW='\033[1;33m'

# Asegurar que estamos en la raíz del proyecto
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT" || exit 1

echo -e "${YELLOW}Configurando archivos .env...${NC}"

# Backend env
if [ ! -f .env.backend ]; then
    echo -e "Creando .env.backend desde template..."
    cp .env.backend.template .env.backend
else
    echo -e ".env.backend ya existe, omitiendo."
fi

# Frontend env
if [ ! -f .env.frontend ]; then
    echo -e "Creando .env.frontend desde template..."
    cp .env.frontend.template .env.frontend
else
    echo -e ".env.frontend ya existe, omitiendo."
fi

echo -e "${GREEN}✅ Archivos .env configurados.${NC}"

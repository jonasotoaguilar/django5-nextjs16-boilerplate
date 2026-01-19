#!/bin/bash
set -e

# Colores
GREEN='\033[0;32m'
NC='\033[0m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'

# Asegurar que estamos en la raíz del proyecto
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT" || exit 1

echo -e "${BOLD}${YELLOW}🚀 Iniciando configuración del entorno de desarrollo...${NC}"

# 1. Verificar prerrequisitos
echo -e "\n${BOLD}1. Verificando herramientas...${NC}"

# PNPM
if ! command -v pnpm &> /dev/null; then
    echo -e "${RED}❌ pnpm no está instalado. Por favor instalalo primero.${NC}"
    exit 1
fi
echo -e "${GREEN}✅ pnpm detectado.${NC}"

# UV
if ! command -v uv &> /dev/null; then
    echo -e "${RED}❌ uv (python) no está instalado. Por favor instalalo primero.${NC}"
    exit 1
fi
echo -e "${GREEN}✅ uv detectado.${NC}"

# 2. Configurar ENVs
echo -e "\n${BOLD}2. Configurando variables de entorno...${NC}"
bash "$PROJECT_ROOT/scripts/setup-envs.sh"

# 3. Instalar dependencias Frontend
echo -e "\n${BOLD}3. Instalando dependencias del Frontend (pnpm)...${NC}"
if [ -d "frontend/node_modules" ] && [ "$(stat -c '%U' frontend/node_modules)" = "root" ]; then
    echo -e "${RED}❌ Error de permisos: frontend/node_modules pertenece a root.${NC}"
    echo -e "${YELLOW}Corré esto para arreglarlo: sudo chown -R \$USER:\$USER frontend${NC}"
    exit 1
fi
(cd frontend && pnpm install)

# 4. Instalar dependencias Backend
echo -e "\n${BOLD}4. Instalando dependencias del Backend (uv)...${NC}"
(cd backend && uv sync --python 3.13)

# 5. Configurar Git Hooks
echo -e "\n${BOLD}5. Configurando Git Hooks (pre-commit)...${NC}"
bash "$PROJECT_ROOT/scripts/install-pre-commit.sh"

# 6. Construir contenedores de Docker
echo -e "\n${BOLD}6. Construyendo contenedores de Docker...${NC}"
docker compose build

echo -e "\n${BOLD}${GREEN}✨ ¡Todo listo! El entorno está configurado.${NC}"
echo -e "${YELLOW}IDE: Dependencias instaladas localmente para autocompletado.${NC}"
echo -e "${YELLOW}Runtime: Levanta el proyecto con 'docker compose up'.${NC}"

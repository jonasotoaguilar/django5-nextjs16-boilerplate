#!/bin/bash

# Colores
GREEN='\033[0;32m'
NC='\033[0m'
YELLOW='\033[1;33m'
BOLD='\033[1m'

# Asegurar que estamos en la raíz del proyecto
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT" || exit 1

echo -e "${BOLD}${YELLOW}🔍 Ejecutando linting en todo el proyecto...${NC}"

# Frontend
echo -e "\n${BOLD}Frontend (Biome):${NC}"
(cd frontend && pnpm exec biome check .)

# Backend
echo -e "\n${BOLD}Backend (Ruff):${NC}"
(cd backend && uv run ruff check . && uv run ruff format --check .)

echo -e "\n${GREEN}✅ Linting finalizado.${NC}"

# 🚀 Django + Next.js Boilerplate

A modern, full-stack monorepo template designed for speed and scalability. Featuring a **Django** backend powered by `uv` and a **Next.js** frontend with `pnpm`.

---

## 🛠️ Tech Stack

### 🔹 Backend (Django)

- **Framework**: Django 5.x
- **API**: Django REST Framework + SimpleJWT
- **Package Manager**: [uv](https://github.com/astral-sh/uv)
- **Documentation**: OpenAPI (Swagger/Redoc) via `drf-spectacular`
- **Database**: PostgreSQL

### 🔹 Frontend (Next.js)

- **Framework**: Next.js 14+ (App Router)
- **Styling**: Tailwind CSS
- **Package Manager**: [pnpm](https://pnpm.io/)
- **Validation**: Zod + React Hook Form
- **Auth**: NextAuth.js

### 🔹 Infrastructure

- **Containerization**: Docker + Docker Compose
- **Linting/Formatting**: [Biome](https://biomejs.dev/)

---

## 🏁 Getting Started

### 1️⃣ Quick Start

The easiest way to get the environment ready (both local and Docker) is using our setup script:

```bash
./scripts/setup.sh
```

This script will:

- Verify prerequisites (`pnpm`, `uv`).
- Setup `.env` files from templates.
- Install local dependencies for IDE support.
- Configure **pre-commit** hooks.
- Build the **Docker** containers.

### 2️⃣ Running the project

Once the setup is complete, just fire up the containers:

```bash
docker compose up
```

- **Frontend**: [http://localhost:3000](http://localhost:3000)
- **Backend API**: [http://localhost:8001](http://localhost:8001)
- **Admin Panel**: [http://localhost:8001/admin](http://localhost:8001/admin)

---

## 📂 Project Structure

```text
.
├── backend/            # Django project root
│   ├── api/            # Main application logic
│   ├── manage.py       # Django CLI
│   └── pyproject.toml  # Python dependencies (uv)
├── frontend/           # Next.js project root
│   ├── apps/           # Frontend applications (Next.js)
│   ├── packages/       # Shared UI components and types
│   └── package.json    # Frontend dependencies (pnpm)
└── compose.yaml        # Docker orchestration
```

---

## 💻 Development Commands

### 🐍 Backend (Django)

```bash
# Register a superuser
docker compose exec api uv run -- python manage.py createsuperuser

# Run migrations
docker compose exec api uv run -- python manage.py migrate

# Add a package
docker compose exec api uv add <package-name>
```

### ⚛️ Frontend (Next.js)

```bash
# Add a package to the web app
docker compose exec web pnpm --filter web add <package-name>

# Generate TypeScript types from API schema
docker compose exec web pnpm openapi:generate
```

---

## �️ Utility Scripts (scripts/)

We maintain several scripts to streamline development:

- `setup.sh`: Full environment initialization.
- `lint.sh`: Runs linting on both Frontend (Biome) and Backend (Ruff).
- `install-pre-commit.sh`: Configures Git hooks for clean commits.
- `setup-envs.sh`: Initializes `.env` files.

---

## 🛡️ Linting & Quality

We prioritize code quality with **Biome** (Frontend) and **Ruff** (Backend).

```bash
# Run linting everywhere
./scripts/lint.sh
```

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

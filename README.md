# 🚀 Django 5 + Next.js 16 Boilerplate

A modern, full-stack monorepo template designed for speed and scalability. Featuring a **Django** backend powered by `uv` and a **Next.js** frontend with `pnpm`.

![License](https://img.shields.io/badge/license-MIT-green)
![Python](https://img.shields.io/badge/python-3.13-blue)
![Django](https://img.shields.io/badge/django-5.1-green)
![Next.js](https://img.shields.io/badge/next.js-16-black)
![React](https://img.shields.io/badge/react-19-blue)

---

## 🛠️ Tech Stack

### 🔹 Backend (Django)

- **Framework**: Django 5.1
- **API**: Django REST Framework + SimpleJWT
- **Package Manager**: [uv](https://github.com/astral-sh/uv)
- **Documentation**: OpenAPI (Swagger/Redoc) via `drf-spectacular`
- **Database**: PostgreSQL
- **Testing**: Pytest

### 🔹 Frontend (Next.js)

- **Framework**: Next.js 16 (App Router)
- **Library**: React 19
- **Styling**: Tailwind CSS 3.4
- **Package Manager**: [pnpm](https://pnpm.io/)
- **Validation**: Zod + React Hook Form
- **Auth**: NextAuth.js

### 🔹 Infrastructure

- **Containerization**: Docker + Docker Compose
- **Linting/Formatting**: [Biome](https://biomejs.dev/) (JS/TS), [Ruff](https://docs.astral.sh/ruff/) (Python)

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
- **API Docs**: [http://localhost:8001/api/schema/swagger-ui/](http://localhost:8001/api/schema/swagger-ui/)

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
├── skills/             # AI Agent Skills references
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

## 🛠️ Utility Scripts (scripts/)

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

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

# Repository Guidelines

## How to Use This Guide

- Start here for cross-project norms. **Turbo** is a monorepo with a Django backend and a Next.js frontend.
- Each component has an `AGENTS.md` file with specific guidelines (e.g., `backend/AGENTS.md`, `frontend/AGENTS.md`).
- Component docs override this file when guidance conflicts.

## Available Skills

Use these skills for detailed patterns on-demand:

### Generic Skills (Any Project)

| Skill               | Description                                            | URL                                           |
| ------------------- | ------------------------------------------------------ | --------------------------------------------- |
| `typescript`        | Const types, flat interfaces, utility types            | [SKILL.md](skills/typescript/SKILL.md)        |
| `react-19`          | No useMemo/useCallback, React Compiler                 | [SKILL.md](skills/react-19/SKILL.md)          |
| `nextjs-16`         | Async dynamic APIs, cacheLife/cacheTag, Form component | [SKILL.md](skills/nextjs-16/SKILL.md)         |
| `tailwind-4`        | cn() utility, no var() in className                    | [SKILL.md](skills/tailwind-4/SKILL.md)        |
| `pytest`            | Fixtures, mocking, markers, parametrize                | [SKILL.md](skills/pytest/SKILL.md)            |
| `django-drf`        | ViewSets, Serializers, Filters                         | [SKILL.md](skills/django-drf/SKILL.md)        |
| `zod-4`             | New API (z.email(), z.uuid())                          | [SKILL.md](skills/zod-4/SKILL.md)             |
| `zustand-5`         | Persist, selectors, slices                             | [SKILL.md](skills/zustand-5/SKILL.md)         |
| `ai-sdk-5`          | UIMessage, streaming, LangChain                        | [SKILL.md](skills/ai-sdk-5/SKILL.md)          |
| `python-stack-libs` | Pydantic, Polars, etc.                                 | [SKILL.md](skills/python-stack-libs/SKILL.md) |

### Turbo-Specific Skills

| Skill           | Description                | URL                                       |
| --------------- | -------------------------- | ----------------------------------------- |
| `skill-creator` | Create new AI agent skills | [SKILL.md](skills/skill-creator/SKILL.md) |
| `skill-sync`    | Sync auto-invoke tables    | [SKILL.md](skills/skill-sync/SKILL.md)    |

### Auto-invoke Skills

When performing these actions, ALWAYS invoke the corresponding skill FIRST:

| Action | Skill |
|--------|-------|
| -- | `skill-sync` |
| Adding ai-sdk-5 support | `ai-sdk-5` |
| Adding css support | `css` |
| Adding django-drf support | `django-drf` |
| Adding html-5 support | `html-5` |
| Adding pytest support | `pytest` |
| Adding python support | `python-stack-libs` |
| Adding react support | `react-19` |
| Adding react support | `react-stack-libs` |
| Adding shadcn-ui support | `shadcn-ui` |
| Adding sonner support | `sonner` |
| Adding tailwind support | `tailwind-4` |
| Adding typescript support | `typescript` |
| Adding vitest support | `vitest` |
| Adding zod support | `zod-4` |
| Adding zustand support | `zustand-5` |
| After creating/modifying a skill | `skill-sync` |
| App Router / Server Actions | `nextjs-16` |
| Creating new skills | `skill-creator` |
| Optimizing Python performance | `pyo3-rust` |
| Regenerate AGENTS.md Auto-invoke tables (sync.sh) | `skill-sync` |
| Troubleshoot why a skill is missing from AGENTS.md auto-invoke | `skill-sync` |

---

## Project Overview

Turbo is a modern full-stack boilerplate using Django (uv) and Next.js (pnpm).

| Component | Location    | Tech Stack                             |
| --------- | ----------- | -------------------------------------- |
| Backend   | `backend/`  | Python 3.13, Django 5.1, DRF, uv       |
| Frontend  | `frontend/` | Next.js 16, React 19, Tailwind 4, pnpm |

---

## Development Environment

### Setup

```bash
# Run the automated setup script
./scripts/setup.sh
```

### Running the App

```bash
# Start all services with Docker
docker compose up
```

---

## Commit & Pull Request Guidelines

Follow conventional-commit style: `<type>[scope]: <description>`

**Types:** `feat`, `fix`, `docs`, `chore`, `perf`, `refactor`, `style`, `test`

Example: `feat(api): add auth endpoint`

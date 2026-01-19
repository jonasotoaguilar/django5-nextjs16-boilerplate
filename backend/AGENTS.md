# Turbo Backend - AI Agent Ruleset

> **Skills Reference**: For detailed patterns, use these skills:
>
> - [`django-drf`](../skills/django-drf/SKILL.md) - ViewSets, Serializers, Filters
> - [`pytest`](../skills/pytest/SKILL.md) - Python testing patterns
> - [`python-stack-libs`](../skills/python-stack-libs/SKILL.md) - Pydantic, types
> - [`typescript`](../skills/typescript/SKILL.md) - (If generating types for frontend)

### Auto-invoke Skills

When performing these actions, ALWAYS invoke the corresponding skill FIRST:

| Action | Skill |
|--------|-------|
| Adding ai-sdk-5 support | `ai-sdk-5` |
| Adding django-drf support | `django-drf` |
| Adding pytest support | `pytest` |
| Adding python support | `python-stack-libs` |
| Optimizing Python performance | `pyo3-rust` |

---

## CRITICAL RULES - NON-NEGOTIABLE

### Python & Django

- ALWAYS: Use `uv` for dependency management (`uv add`, `uv run`).
- ALWAYS: Use type hints for all function signatures.
- ALWAYS: Use `drf-spectacular` for API documentation.
- NEVER: Use `pip` directly.
- NEVER: Commit secrets or `.env` files.

### API Patterns

- ALWAYS: Use Serializers for data validation and transformation.
- ALWAYS: Use ViewSets for standard CRUD operations.
- ALWAYS: Return consistent JSON responses.

---

## PROJECT STRUCTURE

```
backend/
├── api/
│   ├── settings.py      # Django settings
│   ├── urls.py          # Root URL config
│   ├── wsgi.py / asgi.py
│   └── (apps)/          # Django applications
├── manage.py            # Django CLI
├── pyproject.toml       # Dependencies (uv)
└── uv.lock              # Lockfile
```

---

## COMMANDS

```bash
# Run migrations
uv run python manage.py migrate

# Create a superuser
uv run python manage.py createsuperuser

# Run development server (locally)
uv run python manage.py runserver

# Run tests
uv run pytest

# Add a dependency
uv add <package>
```

---

## QA CHECKLIST BEFORE COMMIT

- [ ] `uv run ruff check .` passes
- [ ] `uv run pytest` passes
- [ ] Type hints are complete and correct
- [ ] API schema is updated (if endpoints changed)
- [ ] Migrations are created and tested
- [ ] No hardcoded configuration (use `env` vars)

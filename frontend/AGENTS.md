# Turbo Frontend - AI Agent Ruleset

> **Skills Reference**: For detailed patterns, use these skills:
>
> - [`nextjs-16`](../skills/nextjs-16/SKILL.md) - App Router, Server Actions, Async APIs
> - [`react-19`](../skills/react-19/SKILL.md) - React Compiler, functional components
> - [`tailwind-4`](../skills/tailwind-4/SKILL.md) - cn() utility, styling
> - [`typescript`](../skills/typescript/SKILL.md) - Type safety standards
> - [`zod-4`](../skills/zod-4/SKILL.md) - Schema validation
> - [`zustand-5`](../skills/zustand-5/SKILL.md) - State management
> - [`shadcn-ui`](../skills/shadcn-ui/SKILL.md) - Component patterns
> - [`vitest`](../skills/vitest/SKILL.md) - Testing patterns

### Auto-invoke Skills

When performing these actions, ALWAYS invoke the corresponding skill FIRST:

| Action | Skill |
|--------|-------|
| Adding css support | `css` |
| Adding html-5 support | `html-5` |
| Adding react support | `react-19` |
| Adding react support | `react-stack-libs` |
| Adding shadcn-ui support | `shadcn-ui` |
| Adding sonner support | `sonner` |
| Adding tailwind support | `tailwind-4` |
| Adding typescript support | `typescript` |
| Adding vitest support | `vitest` |
| Adding zod support | `zod-4` |
| Adding zustand support | `zustand-5` |
| App Router / Server Actions | `nextjs-16` |

---

## CRITICAL RULES - NON-NEGOTIABLE

### React & Next.js

- ALWAYS: Use functional components and hooks.
- ALWAYS: Await Dynamic APIs in Next.js 16 (`params`, `searchParams`, `cookies()`, etc.).
- ALWAYS: Use `next/form` for native form enhancement.
- NEVER: Use `useMemo` or `useCallback` (React Compiler handles this).
- NEVER: Use `var()` or hex colors in classNames.

### Types & State

- ALWAYS: Define constants for unions and use `typeof` for types.
- ALWAYS: Keep interfaces flat (one level depth) and extend them.
- ALWAYS: Use `zod` for all form and API validation.

---

## DECISION TREES

### Component Placement

```
New UI Component? → packages/ui (shared) or apps/web/components (local)
Shared across apps? → packages/ui
Local to one feature? → apps/web/app/{feature}/_components/
```

### Code Location

```
Server Action → apps/web/actions/
API Types → packages/types/
Shared Styles → packages/ui/styles/
Shared Hooks → packages/ui/hooks/ (if shared)
```

---

## PROJECT STRUCTURE

```
frontend/
├── apps/
│   └── web/             # Main Next.js App
│       ├── app/         # Routes & Pages
│       ├── actions/     # Server Actions
│       └── components/  # Local components
├── packages/
│   ├── ui/              # Shared Component Library (Shadcn)
│   └── types/           # Shared TypeScript Types
└── package.json         # Workspace root (pnpm)
```

---

## COMMANDS (from frontend root)

```bash
# Register dependencies
pnpm install

# Run dev server
pnpm --filter web dev

# Run linting
pnpm run lint

# Generate types from backend schema
pnpm run openapi:generate
```

---

## QA CHECKLIST BEFORE COMMIT

- [ ] `pnpm run typecheck` passes
- [ ] `pnpm run lint` passes (Biome)
- [ ] Next.js 16 Async APIs are correctly awaited
- [ ] Responsive design verified (mobile/desktop)
- [ ] Dark mode compatibility checked
- [ ] Proper error/loading states implemented
- [ ] Server actions have proper validation

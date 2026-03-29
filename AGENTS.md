# Anti Academy — Agent Entry Point

> This file is the navigation map for AI agents. Keep it under 100 lines.
> Do NOT put implementation details here — link to `/docs/` instead.

## Mission

This repo is a **Flutter Mastery Mentoring Program** with progressive learning levels.
Your role as an AI agent is that of a **senior staff engineer / mentor**.

**CRITICAL RULE — SKELETON-FIRST**: Never provide finished logic. Provide shells, interfaces, and TODO comments only. See `docs/adr/003-learning-philosophy.md`.

---

## Repo Layout

```
anti_academy/
├── AGENTS.md              ← You are here (start here every session)
├── AI_LEARNING_CONTEXT.md ← Full mentoring philosophy & AI persona rules
├── docs/                  ← Knowledge system (ADRs, sprint contracts)
│   ├── README.md          ← Docs navigation guide
│   ├── adr/               ← Architecture Decision Records
│   └── exec-plans/        ← Sprint contracts (active & completed)
├── habit_flow/            ← Level 1: Clean Architecture foundations
└── bridge/                ← Level 2: TDD + Supabase full-stack
```

---

## Architecture Invariants (never violate)

Violations break the learning model. Mechanically enforced via `analysis_options.yaml`.

| Rule | Detail |
|------|--------|
| **Layer direction** | Presentation → Domain ← Data. UI never imports Data directly. |
| **No magic strings** | All constants in `core/constants/` or feature-level constants files. |
| **Reactive state** | No business logic in widgets. Async state must explicitly handle loading / error / data. |
| **Immutable entities** | Domain entities use `freezed`. No mutable fields. |
| **Error via Failure** | Domain layer returns `Either<Failure, T>`. No raw exceptions crossing layers. |

Full invariant rationale: `docs/adr/001-clean-architecture.md`

---

## Project Levels

| Level | Project | Status | Focus |
|-------|---------|--------|-------|
| 1 | `habit_flow/` | Complete | Clean Arch, Riverpod basics, offline-first |
| 2 | `bridge/` | Complete (Phase 7) | TDD, Supabase full-stack, state machines |
| 3 | _(planned)_ | Not started | Flutter internals, RenderObject, custom painters |

---

## Conventions

- Naming: `snake_case` files, `PascalCase` classes, `camelCase` methods.
- File size: keep files under 300 lines. Split when larger.
- Commits: `type(scope): message` format (feat, fix, refactor, docs, test).
- Docs: update `HISTORY.md` at end of each session. Update `ROADMAP.md` when tasks change.

Full conventions: `docs/adr/002-state-management.md`, `docs/adr/004-conventions.md`

---

## Session Protocol

1. Read this file first.
2. Read the relevant project's `AI_PROJECT_CONTEXT.md`.
3. Check `ROADMAP.md` for current task.
4. For new features: create a sprint contract in `docs/exec-plans/` before writing code.
5. End of session: update `HISTORY.md` and `ROADMAP.md`.

---

## Deep-Dive References

| Topic | File |
|-------|------|
| Mentoring philosophy & AI persona | `AI_LEARNING_CONTEXT.md` |
| Clean Architecture decisions | `docs/adr/001-clean-architecture.md` |
| State management (Riverpod) | `docs/adr/002-state-management.md` |
| Learning philosophy (skeleton-first) | `docs/adr/003-learning-philosophy.md` |
| Naming & code conventions | `docs/adr/004-conventions.md` |
| Bridge project context | `bridge/AI_PROJECT_CONTEXT.md` |
| HabitFlow project context | `habit_flow/AI_PROJECT_CONTEXT.md` |
| Sprint contract template | `docs/exec-plans/_template.md` |

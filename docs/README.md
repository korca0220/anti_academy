# Docs — Knowledge System

This directory is the **system of record** for all architectural decisions and sprint plans.
Agents: start from `AGENTS.md` at the repo root, then navigate here as needed.

## Structure

```
docs/
├── README.md              ← This file (navigation guide)
├── adr/                   ← Architecture Decision Records
│   ├── 001-clean-architecture.md
│   ├── 002-state-management.md
│   ├── 003-learning-philosophy.md
│   └── 004-conventions.md
└── exec-plans/            ← Sprint contracts
    └── _template.md       ← Template for new sprint contracts
```

## ADR Index

| ID | Title | Status |
|----|-------|--------|
| 001 | Clean Architecture layer rules & invariants | Active |
| 002 | State management — Riverpod patterns | Active |
| 003 | Learning philosophy — skeleton-first approach | Active |
| 004 | Naming, file, and commit conventions | Active |

## Exec Plans Index

| File | Sprint | Status |
|------|--------|--------|
| `_template.md` | Template | — |

## Rules

- ADRs are append-only. Mark superseded decisions as `[SUPERSEDED by ADR-NNN]`.
- Sprint contracts move to `exec-plans/archive/` when completed.
- When you update the code in a way that contradicts an ADR, update the ADR first.

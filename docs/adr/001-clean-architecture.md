# ADR-001: Clean Architecture Layer Rules & Invariants

**Status**: Active
**Applies to**: All projects (`habit_flow/`, `bridge/`, future levels)

---

## Decision

All projects in this repo follow **Clean Architecture** with strict unidirectional dependency flow.

## Layer Structure

```
Presentation Layer (UI)
    ↓  depends on
Domain Layer (Business Logic)  ← core of the app
    ↑  depends on (via interface inversion)
Data Layer (Infrastructure)
```

**Rule**: The dependency arrows NEVER reverse. UI never imports from Data directly.

## Layer Responsibilities

### Presentation
- `pages/` — full screens, assembled from widgets
- `widgets/` — reusable UI components, no business logic
- `riverpod/` — Notifiers that hold and transform state
- **Allowed imports**: Domain entities, Domain use cases, Core utilities
- **Forbidden imports**: Data sources, Repository implementations, Supabase client

### Domain
- `entities/` — immutable business objects (`freezed` required)
- `repositories/` — abstract interfaces (no implementation)
- `usecases/` — single-responsibility business operations
- **Allowed imports**: Core utilities, `fpdart` types
- **Forbidden imports**: Flutter widgets, Riverpod, Supabase, any Data layer file

### Data
- `datasources/` — Supabase/local API clients
- `models/` — DTOs with serialization, `fromJson`/`toJson`
- `repositories/` — implementations of Domain interfaces
- **Allowed imports**: Domain interfaces, Core utilities, Supabase client
- **Forbidden imports**: Presentation widgets, Riverpod Notifiers

## Invariants

These are mechanically enforced via `analysis_options.yaml` linting:

1. **No circular imports** — enforced by Dart analyzer
2. **Entities are immutable** — `freezed` + no mutable fields
3. **Errors cross layers as `Failure`** — `Either<Failure, T>` from `fpdart`; raw exceptions don't escape a layer
4. **No `print()` in production code** — use structured logging or remove
5. **No magic strings** — string constants are defined in `core/constants/` or feature constants files

## Why This Architecture

- **Testability**: Domain layer has zero Flutter/Supabase dependencies → unit-testable in isolation
- **Replaceability**: Swapping Supabase for another backend only touches the Data layer
- **AI-agent safety**: Strict boundaries prevent agents from accidentally coupling layers, which would cause cascading breakage
- **Learning goal**: Students understand *why* each layer exists, not just where to put files

## How to Apply

When an agent or developer is unsure where code belongs, ask:
- "Does this talk to a backend or file system?" → Data layer
- "Does this express a business rule?" → Domain layer
- "Does this render UI or respond to user input?" → Presentation layer

When in doubt, lean toward Domain — keep business rules framework-agnostic.

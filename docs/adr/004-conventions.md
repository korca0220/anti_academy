# ADR-004: Naming, File, and Commit Conventions

**Status**: Active
**Applies to**: All projects

---

## File & Directory Naming

- All file names: `snake_case.dart`
- Directories: `snake_case/`
- Test files: mirror the source path, suffix with `_test.dart`

```
lib/features/feed/presentation/pages/feed_page.dart
test/features/feed/presentation/pages/feed_page_test.dart
```

## Dart Naming

| Element | Convention | Example |
|---------|-----------|---------|
| Classes | `PascalCase` | `PostRepository` |
| Methods & variables | `camelCase` | `fetchPosts()` |
| Constants | `camelCase` (Dart style) | `maxRetryCount` |
| Private members | `_camelCase` | `_supabaseClient` |
| Enums | `PascalCase`, values `camelCase` | `TransactionStatus.inProgress` |

## File Size Limit

- **Target**: under 200 lines
- **Hard limit**: 300 lines — split the file if exceeded
- Exception: generated files (`*.g.dart`, `*.freezed.dart`)

## Constants — No Magic Strings

String constants, route names, Supabase table names, and storage bucket names
must be defined in a constants file. Never inline them in business logic.

```dart
// Correct
supabase.from(SupabaseTables.posts).select()

// Wrong
supabase.from('posts').select()
```

Location: `lib/core/constants/` for shared constants, or
`lib/features/{feature}/domain/constants/` for feature-specific constants.

## Commit Convention

Format: `type(scope): short description`

| Type | Use |
|------|-----|
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Code restructure, no behavior change |
| `test` | Adding or updating tests |
| `docs` | Documentation only |
| `chore` | Build system, CI, dependencies |

Example: `feat(feed): add realtime subscription to posts list`

## Import Order

Follow Dart/Flutter convention enforced by `import_ordering` lint:

1. `dart:` imports
2. `package:` imports (Flutter, then third-party)
3. Relative project imports

Use `part` and `part of` only for generated files (`freezed`, `riverpod_annotation`).

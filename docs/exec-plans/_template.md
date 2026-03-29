# Sprint Contract: [Feature Name]

**Date**: YYYY-MM-DD
**Project**: bridge / habit_flow
**Sprint**: Phase X — [Phase Name]
**Status**: draft / active / completed

---

## Objective

One paragraph describing what this sprint delivers and why it matters to the user.

---

## Scope

### In Scope
- [ ] Specific deliverable 1
- [ ] Specific deliverable 2

### Out of Scope
- Things explicitly excluded to prevent scope creep

---

## Done Criteria

A sprint is DONE when ALL of the following are verifiable:

- [ ] **Testable behavior 1**: e.g., "User can tap 'Create Post' and see the new post appear in the feed without reload"
- [ ] **Testable behavior 2**: e.g., "If the API call fails, an error snackbar is shown and the form is not cleared"
- [ ] **Testable behavior 3**: e.g., "Unit test for PostRepository.createPost() passes with a mocked data source"
- [ ] **No regressions**: Existing features still work
- [ ] **Linter passes**: `flutter analyze` reports zero errors

> Done criteria must be testable by a human clicking through the app OR by a passing test.
> Vague criteria like "UI looks good" are not acceptable — replace with specific behaviors.

---

## Architecture Notes

- Which layers are touched: Presentation / Domain / Data
- New providers/notifiers introduced
- New domain entities or use cases
- DB schema changes (if any)

---

## Skeleton Plan

Files to create (shells only, no logic):

```
lib/features/{feature}/
├── domain/
│   ├── entities/   new_entity.dart         # TODO: define fields
│   └── usecases/   create_thing_usecase.dart # TODO: implement
├── data/
│   ├── models/     new_entity_model.dart   # TODO: fromJson/toJson
│   └── datasources/ new_datasource.dart   # TODO: Supabase calls
└── presentation/
    ├── riverpod/   new_notifier.dart       # TODO: state + methods
    └── pages/      new_page.dart           # TODO: wire up UI
```

---

## Decision Log

| Decision | Rationale |
|----------|-----------|
| e.g., Used `AsyncNotifier` instead of `Notifier` | Feature is async-first |

---

## Known Technical Debt

- Any shortcuts taken and why (document to address later)

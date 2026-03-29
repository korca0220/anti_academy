# ADR-002: State Management Principles

**Status**: Active

---

## Decision

State management must follow reactive, unidirectional data flow.
Business logic must not live in widgets. Async state must always represent three states: loading, error, and data.

The reference implementation in this repo uses **Riverpod** (code-gen variant with `@riverpod` annotations), but the underlying principles apply regardless of the chosen package.

## Patterns

### AsyncValue for all async state

```dart
// Correct
AsyncValue<List<Post>> postsState = const AsyncValue.loading();

// Wrong — do not use raw nullable + bool pattern
List<Post>? posts;
bool isLoading = false;
```

`AsyncValue` provides a unified `.when(data, loading, error)` API that forces
handling all three states in UI, preventing missed error/loading states.

### Notifier pattern (not StateNotifier)

Use `@riverpod` code-gen with `Notifier` or `AsyncNotifier`.
`StateNotifier` is the legacy API — avoid in new code.

```dart
// Correct
@riverpod
class PostsNotifier extends _$PostsNotifier { ... }

// Wrong
class PostsNotifier extends StateNotifier<PostsState> { ... }
```

### Provider scope

- `@riverpod` (auto-dispose) for feature-scoped state
- `@Riverpod(keepAlive: true)` only for app-global state (auth, theme)

### No business logic in widgets

Widgets call Notifier methods. They do not contain `if/else` business logic.

```dart
// Correct
onTap: () => ref.read(postNotifierProvider.notifier).createPost(content),

// Wrong
onTap: () {
  if (content.isNotEmpty && user != null) {
    supabase.from('posts').insert({...});
  }
},
```

## Why Riverpod

- Compile-safe — missing providers are caught at compile time
- No `BuildContext` required to read providers
- Works well with code-gen and `freezed` immutable models
- Testable — providers can be overridden in tests

## How to Apply

When an agent proposes a `StatefulWidget` for state that persists beyond the widget,
redirect to a Riverpod Notifier. Keep `StatefulWidget` only for ephemeral local UI state
(e.g., `FocusNode`, `AnimationController`, `TextEditingController`).

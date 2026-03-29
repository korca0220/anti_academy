# ADR-002: 상태 관리 원칙

**상태**: Active

---

## 의사결정

상태 관리는 반응형(reactive), 단방향 데이터 흐름을 따라야 합니다.
비즈니스 로직은 위젯 안에 있어서는 안 됩니다. 비동기 상태는 항상 loading, error, data 세 가지 상태를 표현해야 합니다.

이 저장소의 참조 구현은 **Riverpod** (코드 생성 방식, `@riverpod` 어노테이션)을 사용하지만, 기본 원칙은 선택한 패키지에 관계없이 적용됩니다.

## 패턴

### 모든 비동기 상태에 AsyncValue 사용

```dart
// 올바른 방식
AsyncValue<List<Post>> postsState = const AsyncValue.loading();

// 잘못된 방식 — raw nullable + bool 패턴 사용 금지
List<Post>? posts;
bool isLoading = false;
```

`AsyncValue`는 통합된 `.when(data, loading, error)` API를 제공하여 UI에서 세 가지 상태를 모두 처리하도록 강제합니다. 이를 통해 에러/로딩 상태를 놓치는 것을 방지합니다.

### Notifier 패턴 사용 (StateNotifier 사용 금지)

`Notifier` 또는 `AsyncNotifier`와 함께 `@riverpod` 코드 생성 방식을 사용하세요.
`StateNotifier`는 레거시 API입니다 — 새 코드에서는 사용하지 마세요.

```dart
// 올바른 방식
@riverpod
class PostsNotifier extends _$PostsNotifier { ... }

// 잘못된 방식
class PostsNotifier extends StateNotifier<PostsState> { ... }
```

### Provider 범위

- `@riverpod` (auto-dispose): 기능 범위 상태
- `@Riverpod(keepAlive: true)`: 앱 전역 상태에만 사용 (auth, theme)

### 위젯에 비즈니스 로직 금지

위젯은 Notifier 메서드를 호출합니다. `if/else` 비즈니스 로직을 포함하지 않습니다.

```dart
// 올바른 방식
onTap: () => ref.read(postNotifierProvider.notifier).createPost(content),

// 잘못된 방식
onTap: () {
  if (content.isNotEmpty && user != null) {
    supabase.from('posts').insert({...});
  }
},
```

## Riverpod을 선택한 이유

- 컴파일 안전성 — 누락된 provider는 컴파일 타임에 감지됨
- Provider를 읽기 위해 `BuildContext` 불필요
- 코드 생성 및 `freezed` 불변 모델과 잘 연동됨
- 테스트 가능 — 테스트에서 provider 오버라이드 가능

## 적용 방법

에이전트가 위젯을 넘어 지속되는 상태에 `StatefulWidget`을 제안할 경우,
Riverpod Notifier로 유도하세요. `StatefulWidget`은 일시적인 로컬 UI 상태
(예: `FocusNode`, `AnimationController`, `TextEditingController`)에만 사용하세요.

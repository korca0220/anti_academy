# ADR-004: 네이밍, 파일, 커밋 컨벤션

**상태**: Active
**적용 범위**: 모든 프로젝트

---

## 파일 & 디렉토리 네이밍

- 모든 파일 이름: `snake_case.dart`
- 디렉토리: `snake_case/`
- 테스트 파일: 소스 경로를 그대로 미러링하고, `_test.dart` 접미사 추가

```
lib/features/feed/presentation/pages/feed_page.dart
test/features/feed/presentation/pages/feed_page_test.dart
```

## Dart 네이밍

| 요소 | 컨벤션 | 예시 |
|---------|-----------|---------|
| 클래스 | `PascalCase` | `PostRepository` |
| 메서드 & 변수 | `camelCase` | `fetchPosts()` |
| 상수 | `camelCase` (Dart 스타일) | `maxRetryCount` |
| 프라이빗 멤버 | `_camelCase` | `_supabaseClient` |
| Enum | `PascalCase`, 값은 `camelCase` | `TransactionStatus.inProgress` |

## 파일 크기 제한

- **목표**: 200줄 이내
- **하드 리밋**: 300줄 — 초과 시 파일 분리
- 예외: 생성된 파일 (`*.g.dart`, `*.freezed.dart`)

## 상수 — 매직 스트링 금지

문자열 상수, 라우트 이름, Supabase 테이블 이름, 스토리지 버킷 이름은
반드시 상수 파일에 정의해야 합니다. 비즈니스 로직에 인라인으로 넣지 마세요.

```dart
// 올바른 방식
supabase.from(SupabaseTables.posts).select()

// 잘못된 방식
supabase.from('posts').select()
```

위치: 공유 상수는 `lib/core/constants/`, 기능별 상수는
`lib/features/{feature}/domain/constants/`.

## 커밋 컨벤션

형식: `type(scope): 짧은 설명`

| 타입 | 사용 |
|------|-----|
| `feat` | 새 기능 |
| `fix` | 버그 수정 |
| `refactor` | 동작 변경 없는 코드 재구성 |
| `test` | 테스트 추가 또는 수정 |
| `docs` | 문서만 변경 |
| `chore` | 빌드 시스템, CI, 의존성 |

예시: `feat(feed): 게시글 목록에 실시간 구독 추가`

## Import 순서

`import_ordering` 린트로 강제되는 Dart/Flutter 컨벤션을 따릅니다:

1. `dart:` imports
2. `package:` imports (Flutter, 그 다음 서드파티)
3. 상대 경로 프로젝트 imports

`part`와 `part of`는 생성된 파일(`freezed`, `riverpod_annotation`)에만 사용합니다.

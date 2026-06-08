# 스프린트 계약서: My Activity (내 활동 내역)

**날짜**: 2026-06-07
**프로젝트**: bridge
**스프린트**: Phase 5 — My Activity
**상태**: completed

---

## 목표 (Objective)

사용자가 자신이 쓴 게시글과 자신이 참여한 거래 내역을 한 곳에서 확인할 수 있는 화면을 구현한다.
현재 앱에는 피드(전체 글)와 채팅(개별 거래)은 있지만, "내 것만 모아보는" 진입점이 없다.
이 화면은 프로필 화면에서 접근 가능하며, 기존 `PostRepository`와 `TransactionRepository`를 재활용한다.

---

## 범위 (Scope)

### 포함 범위 (In Scope)
- [ ] `PostRepository`에 `getByUserId(String userId)` 메서드 추가 (인터페이스 + 구현체)
- [ ] `TransactionRepository`에 `getByUserId(String userId)` 메서드 추가 (인터페이스 + 구현체)
- [ ] `MyActivityScreen` — 내 게시글 / 거래 내역 탭 UI
- [ ] `myPostsProvider`, `myTransactionsProvider` — 읽기 전용 function provider
- [ ] 프로필 화면(`ProfileScreen`)에서 My Activity 진입 버튼 연결
- [ ] 라우트 `/activity` 추가

### 제외 범위 (Out of Scope)
- 내 게시글 편집/삭제 (Feed에 이미 있거나 별도 스프린트)
- 거래 상태 변경 (Chat 화면의 역할)
- 페이지네이션 (이번 스프린트는 단순 목록)

---

## 완료 기준 (Done Criteria)

- [ ] **내 게시글 탭**: 로그인한 사용자가 작성한 게시글만 목록에 표시된다
- [ ] **거래 내역 탭**: 로그인한 사용자가 요청자 또는 제공자로 참여한 거래 목록이 표시된다
- [ ] **빈 상태**: 게시글/거래가 없을 때 Empty State가 표시된다
- [ ] **진입점**: 프로필 화면에서 My Activity 화면으로 이동할 수 있다
- [ ] **회귀 없음**: 기존 Feed, Chat, Profile 화면 정상 동작
- [ ] **린터 통과**: `flutter analyze` 에러 0개

---

## 아키텍처 노트 (Architecture Notes)

- 수정 레이어: Domain (Repository 인터페이스), Data (Supabase 구현), Presentation (화면 + provider)
- **새 feature 디렉토리 없음** — 화면은 `profile/presentation/screens/`, provider는 `profile/presentation/providers/`에 위치
  - 근거: My Activity는 "내 프로필의 확장"이며 새 도메인 엔티티가 없음. 별도 feature를 만들면 오버엔지니어링.
- **신규 provider**: function-based `@riverpod`
  - `myPostsProvider` — 변경 메서드 없음, 읽기 전용 Future
  - `myTransactionsProvider` — 변경 메서드 없음, 읽기 전용 Future
- DB 변경 없음 (기존 `posts`, `transactions` 테이블 쿼리만 추가)

---

## 스켈레톤 계획 (Skeleton Plan)

```
# 1. Domain — 인터페이스 확장
features/feed/domain/repositories/
  post_repository.dart          # getByUserId(String userId) 추가

features/transaction/domain/repositories/
  transaction_repository.dart   # getByUserId(String userId) 추가

# 2. Data — 구현체 확장
features/feed/data/repositories/
  supabase_post_repository.dart # getByUserId Supabase 쿼리 구현

features/transaction/data/repositories/
  supabase_transaction_repository.dart # getByUserId Supabase 쿼리 구현

# 3. Presentation — 신규 화면 + provider
features/profile/presentation/providers/
  my_activity_providers.dart    # myPostsProvider, myTransactionsProvider

features/profile/presentation/screens/
  my_activity_screen.dart       # TabBar (내 게시글 / 거래 내역)
```

---

## 의사결정 로그 (Decision Log)

| 의사결정 | 근거 |
|----------|------|
| `profile` feature 안에 화면 배치 | 새 도메인 없음, 사용자 중심 화면이라 profile의 자연스러운 확장 |
| `Notifier` 아닌 function provider | 상태 변경 메서드 없음, 읽기 전용 |
| `getByUserId`를 Repository에 추가 | Presentation에서 필터링하면 불필요한 전체 데이터 fetch 발생 |

---

## 알려진 기술 부채 (Known Technical Debt)

- 목록이 길어지면 페이지네이션 필요 (현재 단순 fetch)

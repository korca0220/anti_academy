# 스프린트 계약서: Bridge 상대방 프로필 보기

**날짜**: 2026-06-07
**프로젝트**: bridge
**스프린트**: Phase 5 — Discover / Profile View
**상태**: completed

---

## 목표 (Objective)

게시글 작성자 또는 채팅 상대의 프로필을 확인할 수 있는 화면을 만든다. 사용자는 거래를 시작하기 전에 상대방의 기본 정보와 받은 리뷰 흐름을 확인할 수 있고, 학습자는 여러 도메인 데이터(`Profile`, `Review`)를 하나의 화면 상태로 조합하는 패턴을 익힌다.

---

## 범위 (Scope)

### 포함 범위 (In Scope)
- [x] `/users/:userId` 라우트 추가
- [x] `ProfileViewScreen` 화면 생성
- [x] 프로필 + 받은 리뷰를 조합하는 provider/view state 생성
- [x] 게시글 상세 화면에서 작성자 프로필로 이동하는 진입점 추가
- [x] 채팅방에서 상대방 프로필로 이동하는 진입점 추가
- [x] 평균 별점/최근 리뷰 표시 구현

### 제외 범위 (Out of Scope)
- 매너온도 계산 알고리즘 완성
- 리뷰/프로필 DB 스키마 변경
- 내 활동 모아보기
- 검색 기능
- 프로필 편집 화면 리팩터링

---

## 완료 기준 (Done Criteria)

다음 항목이 **모두** 검증 가능할 때 스프린트는 완료됩니다:

- [x] **라우팅**: 게시글 상세 화면에서 작성자를 탭하면 `/users/:userId`로 이동한다.
- [x] **프로필 로딩**: `ProfileRepository.getProfile(userId)` 결과가 화면에 표시된다.
- [x] **리뷰 로딩**: `ReviewRepository.getReviewsByReviewee(userId)` 결과가 화면 상태에 포함된다.
- [x] **비동기 상태**: 화면에서 loading / error / data 상태가 모두 처리된다.
- [x] **빈 상태**: 받은 리뷰가 없을 때 명확한 빈 상태가 표시된다.
- [ ] **회귀 없음**: 게시글 상세, 채팅, 기존 내 프로필 화면이 정상 동작한다.
- [x] **린터 통과**: Profile View 관련 파일 단위 `flutter analyze` 통과

---

## 아키텍처 노트 (Architecture Notes)

- 수정되는 레이어: Presentation 중심
- Domain/Data 변경 없음: 기존 `ProfileRepository`, `ReviewRepository` 계약을 재사용
- 새 provider:
  - `profileViewProvider(userId)`
  - `ProfileViewState`
- DB 스키마 변경 없음
- UI는 repository 구현체 또는 Supabase client를 직접 import하지 않는다.
- 새 위젯 컨벤션에 따라 보조 위젯은 `presentation/widgets/`로 분리한다.

---

## 스켈레톤 계획 (Skeleton Plan)

생성/수정할 파일:

```
bridge/lib/features/profile/
└── presentation/
    ├── providers/profile_view_providers.dart # profile + reviews 조합
    ├── screens/profile_view_screen.dart      # 화면 조립
    └── widgets/                              # 보조 위젯 분리

bridge/lib/app/router/app_router.dart         # /users/:userId 라우트 추가
bridge/lib/features/feed/presentation/screens/post_detail_screen.dart
                                                # 작성자 프로필 진입점 추가
bridge/lib/features/chat/presentation/screens/chat_screen.dart
                                                # 상대방 프로필 진입점 추가
```

---

## 의사결정 로그 (Decision Log)

| 의사결정 | 근거 |
|----------|------|
| 새 도메인 엔티티 대신 `ProfileViewState` 사용 | 이번 기능은 새 비즈니스 개념보다 화면 조합 상태에 가깝다. |
| `ProfileRepository`와 `ReviewRepository` 재사용 | 기존 계약으로 필요한 데이터를 가져올 수 있어 Domain/Data 변경을 피한다. |
| 평균 별점/최근 리뷰 계산은 `ProfileViewState`에 둠 | 화면은 렌더링에 집중하고, 표시용 파생 상태는 view state에서 계산한다. |
| 상대방 프로필 라우트는 `/users/:userId` 사용 | 기존 `/profile` 내 프로필 화면과 충돌하지 않는다. |
| 보조 위젯은 1파일 1클래스로 분리 | ADR-004의 위젯 파일 구성 컨벤션을 적용한다. |

---

## 알려진 기술 부채 (Known Technical Debt)

- `bridge`는 `@riverpod` 코드 생성 provider와 수동 `Provider`가 섞여 있다. 이번 스프린트에서는 기존 혼합 상태를 유지하고, 별도 리팩터링 스프린트에서 정리한다.
- 채팅방의 상대방 판별 로직은 `participants` 구조에 의존한다. 현재 사용자 제외 규칙은 구현했지만, participants가 비정상적으로 비어 있는 서버 상태는 별도 Edge Case 스프린트에서 다룬다.
- 전체 앱 수동 회귀 검증은 별도 QA 패스로 남긴다.

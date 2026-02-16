📜 History Log: Bridge

2026-02-08: Project Initiation & Phase 1 Completion

✅ Accomplishments

1.  **Project Setup**:
    - `bridge` Flutter 프로젝트 생성.
    - Level 2 목표 설정 (Advanced Supabase, TDD, Complex State).
    - `AI_PROJECT_CONTEXT.md` 및 `ROADMAP.md` 작성.
2.  **Phase 1: Foundation & Auth**:
    - **Tech Stack**: Riverpod (State), GoRouter (Nav), Supabase (Backend).
    - **Architecture**: Clean Architecture (Presentation - Domain - Data).
    - **Implementation**: - `SupabaseConfig` 및 `main.dart` 초기화. - `AuthRepository` (Interface & Supabase Implementation). - `SignInController` & `SignUpController` (AsyncNotifier Pattern). - `AppRouter` Redirect Logic (Auth State 연동). - `SignInScreen`, `SignUpScreen` 구현. - **Supabase Database**: `profiles` 테이블 생성 및 `handle_new_user` 트리거 적용 (회원가입 시 닉네임 동기화).
      🔑 Key Learnings

- **No Pre-Implementation Rule**: AI가 코드를 미리 제공하는 대신 스캐폴딩/테스트로 학습 주도.
- **Controller vs ViewModel**: Riverpod AsyncNotifier가 UI 상태 책임을 깔끔히 분리.
- **Auth Redirection**: GoRouter redirect 조건 조합의 예외 처리 중요성.
- **Server-side 규칙**: DB 트리거로 인증/프로필 생성 자동화.

2026-02-10: Phase 2 - Feed & Posts Initiation
✅ Accomplishments

1.  **Database Design**:
    - `posts` 테이블 설계 (Request/Offer 타입, 상태 관리, `image_urls`).
    - RLS 정책 설정 (읽기 전용 / 본인만 쓰기).
    - Realtime Replication 활성화.
2.  **Domain Layer (Feed)**:
    - `Post` Entity (Immutable with `freezed`).
    - `PostRepository` Interface & `SupabasePostRepository` Implementation.
3.  **UI Implementation**:
    - `HomeScreen` 기초 구현 (Riverpod StreamProvider 연동).
    - `createPost` 플로우와 관련 화면 연동.
    - `build_runner` 기반 JSON 직렬화 정합성 해결.
4.  **Create Post Feature**:
    - **TDD Cycle**: Feed 아이템/폼 테스트 기반 작성.
      🔜 Next Steps

- Phase 2 심화: filtering 정교화 + 상세 화면 최적화

2026-02-11: Feed Filtering & Post Detail View
✅ Accomplishments

1.  **Feed Filtering**:
    - `SegmentedButton` in `HomeScreen` for `request` vs `offer`.
    - `feedFilterProvider` 상태 분리.
    - Supabase 조회 필터링 쿼리 분기 정리.
2.  **Post Detail View**:
    - Route 통과 구조(`/post/:postId`) 완성.
    - 게시글 상세 페이지에서 작성자 조회/날짜/제목/본문 렌더링 구현.
3.  **Chat Start**: - 게시글 상세에서 상대방 채팅방 생성/이동 플로우 연결.

2026-02-17: Transaction Domain Test Foundation (Phase 4 Step 2)
✅ Accomplishments

1.  **Transaction Domain Modeling**:
    - `Transaction` 엔티티 생성.
    - `TransactionStatus` 상태 집합 및 `canTransition` 규칙 정리.
2.  **TDD Delivery**:
    - `transaction_status_transition_test.dart` 복구 및 커버리지 확정.
    - `transaction_entity_test.dart`에서 동등성/필수 필드/nullable/`copyWith` 검증.
3.  **Repository Contract Stability**:
    - `TransactionRepository` 인터페이스 확정:
      - `getByRoomId`
      - `watchByRoomId`
      - `upsert`
      - `updateStatus` (cancel reason 포함)
    - `transaction_repository_contract_test.dart`로 계약 검증 완료.
4.  **Cleanup & Consistency**:
    - 테스트 폴더의 `transation` 오타 경로 정리 → `transaction`.
    - 테스트 실행 기준점 2-2 완료 상태로 정리.

🔜 Next Steps

- Step 3: 거래 데이터 저장소 구현 + Chat UI에서 거래 상태 반영.

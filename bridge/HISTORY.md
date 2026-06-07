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

2026-02-18: Phase 5~7 Completion (Transactions, Profile, Polish)
✅ Accomplishments

1.  **Transaction Feature (Phase 5)**:
    - **Realtime State Sync**: `SupabaseTransactionRepository`와 `StreamProvider`를 통해 채팅방 내 거래 상태 실시간 동기화.
    - **Database Logic**: `validate_transaction_status_transition` 트리거로 상태 전이 규칙(Proposed -> Accepted -> In Progress -> Completed)을 DB 레벨에서 검증.
    - **UI Integration**: `TransactionStatusWidget`을 채팅 화면 상단에 배치하여 상태별 액션(수락, 완료, 취소 등) 처리.
2.  **Profile Image Upload (Phase 6)**:
    - **Supabase Storage**: `avatars` 버킷 생성 및 RLS 정책(`(storage.foldername(name))[1] = auth.uid()::text`) 적용으로 보안 강화.
    - **Image Picker**: 갤러리 연동 및 `clean_architecture` 패턴에 맞춘 `updateAvatar` 로직 구현.
3.  **UI/UX Polish (Phase 7)**:
    - **Skeleton Loading**: `SkeletonFeedItem` 구현 및 Shimmer 효과 적용으로 로딩 경험 개선.
    - **Empty States**: `EmptyStateWidget` 공통 컴포넌트화 및 적용.

🔑 Key Learnings

- **Logic Placement**: 상태 전이 규칙 같은 핵심 비즈니스 로직은 앱(Repository)과 DB(Trigger) 양쪽에 이중으로 두어, UX 반응성과 데이터 무결성을 모두 잡음.
- **Storage RLS**: 파일명/경로 기반의 정교한 권한 제어 패턴 습득.
- **Skeleton Pattern**: 단순 인디케이터보다 스켈레톤 UI가 체감 속도를 높이는 효과 확인.

2026-06-07: Review System Completion & Cross-user Flow Hardening
✅ Accomplishments

1. **Review Feature End-to-End 연결**:
   - `review` feature 계층(Domain/Data/Presentation) 스캐폴딩 완료 후 저장 로직 구현.
   - `ReviewBottomSheet`를 `Riverpod @riverpod` 기반 submit 흐름에 연결.
   - 중복 작성(UNIQUE 제약) 실패 시 사용자 피드백을 시트 내부 에러 메시지로 처리.
2. **Completed 거래 UX 보강**:
   - 거래 완료 카드에서 리뷰 요약(최근 리뷰 별점/코멘트) 표시.
   - 현재 로그인 사용자가 이미 리뷰를 작성한 경우 `리뷰 남기기` 버튼 숨김 + `리뷰 작성 완료` 배지 노출.
3. **Post-Chat-Transaction 연결 안정화**:
   - 채팅방을 `post_id` 컨텍스트로 생성하도록 RPC 시그니처/호출부 정합성 강화.
   - `transactions.post_id` 누락 시 상태 동기화가 깨지는 문제를 방어 로직으로 차단.
4. **멀티 유저 검증 대응**:
   - 계정 전환 후에도 `currentUserId`가 즉시 반영되도록 provider 반응성 수정.
   - 프로필 화면에 로그아웃 UX 추가하여 교차 유저 테스트 경로 확보.

🔑 Key Learnings

- **Context Binding 중요성**: 메시지/거래 흐름은 사용자뿐 아니라 `post_id` 맥락까지 함께 묶어야 도메인 정합성이 유지됨.
- **DB 제약 + UI 가드 이중 방어**: 중복 리뷰는 DB 제약으로 막고, UI에서는 CTA를 숨겨 사용자의 불필요한 재시도를 줄이는 것이 효과적임.
- **세션 전환 신뢰성**: 인증 상태 스트림을 provider에 연결하지 않으면 계정 전환 UX가 쉽게 어긋남.

2026-06-07: Profile View Sprint Kickoff
✅ Accomplishments

1. **Sprint Contract 작성**:
   - `docs/exec-plans/bridge-profile-view.md` 생성.
   - 상대방 프로필 보기의 범위, 완료 기준, 제외 범위, 스켈레톤 계획을 확정.
2. **Profile View 스켈레톤 생성**:
   - `/users/:userId` 라우트 추가.
   - `ProfileViewScreen` 화면 스켈레톤 생성.
   - `ProfileViewState`와 `profileViewProvider(userId)` 스켈레톤 생성.
3. **진입점 연결**:
   - 게시글 상세 화면의 작성자 영역에서 상대방 프로필 화면으로 이동하도록 연결.
   - 채팅 화면 AppBar에 상대방 프로필 진입 TODO 버튼 추가.

🔑 Key Learnings

- **View State Composition**: 새 도메인 엔티티를 만들기 전에, 기존 `ProfileRepository`와 `ReviewRepository`를 조합하는 화면 상태로 충분한지 먼저 검증한다.
- **Skeleton First 유지**: 평균 별점 계산, 최근 리뷰 정렬, 채팅 상대 판별 로직은 TODO로 남겨 사용자가 직접 구현하도록 했다.

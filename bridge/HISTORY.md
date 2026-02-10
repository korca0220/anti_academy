# 📜 History Log: Bridge

## 2026-02-08: Project Initiation & Phase 1 Completion

### ✅ Accomplishments

1.  **Project Setup**:
    - `bridge` Flutter 프로젝트 생성.
    - Level 2 목표 설정 (Advanced Supabase, TDD, Complex State).
    - `AI_PROJECT_CONTEXT.md` 및 `ROADMAP.md` 작성.

2.  **Phase 1: Foundation & Auth**:
    - **Tech Stack**: Riverpod (State), GoRouter (Nav), Supabase (Backend).
    - **Architecture**: Clean Architecture (Presentation - Domain - Data).
    - **Implementation**:
      - `SupabaseConfig` 및 `main.dart` 초기화.
      - `AuthRepository` (Interface & Supabase Implementation).
      - `SignInController` & `SignUpController` (AsyncNotifier Pattern).
      - `AppRouter` Redirect Logic (Auth State 연동).
      - `SignInScreen`, `SignUpScreen` 구현.
      - **Supabase Database**: `profiles` 테이블 생성 및 `handle_new_user` 트리거 적용 (회원가입 시 닉네임 자동 동기화).

### 🔑 Key Learnings

- **No Pre-Implementation Rule**: AI가 코드를 미리 짜주는 대신 스캐폴딩(Shell)만 제공하여 학습 효율을 높임.
- **Controller vs ViewModel**: Riverpod의 Notifier는 MVVM의 ViewModel과 동일한 역할을 수행함.
- **Auth Redirection**: `GoRouter`의 `redirect`에서 로그인 상태와 현재 경로를 정교하게 체크해야 무한 루프나 잘못된 이동을 방지할 수 있음.
- **Supabase Triggers**: Auth(회원가입)와 DB(프로필 생성)를 서버 사이드(SQL)에서 원자적으로 연결하는 패턴 학습.
- **Supabase Triggers**: Auth(회원가입)와 DB(프로필 생성)를 서버 사이드(SQL)에서 원자적으로 연결하는 패턴 학습.

## 2026-02-10: Phase 2 - Feed & Posts Initiation

### ✅ Accomplishments

1.  **Database Design**:
    - `posts` 테이블 설계 (Request/Offer 타입, 상태 관리, `image_urls`).
    - RLS 정책 설정 (읽기 전용 / 본인만 쓰기).
    - Realtime Replication 활성화.

2.  **Domain Layer (Feed)**:
    - `Post` Entity (Immutable with `freezed`).
    - `PostRepository` Interface & `SupabasePostRepository` Implementation.
    - **Tech Debt Fixed**: `Map.remove()`가 값을 리턴하는 문제 -> Cascade Operator (`..remove`)로 해결.

3.  **UI Implementation**:
    - `HomeScreen` 기초 구현 (Riverpod StreamProvider 연동).
    - `build_runner`를 통한 JSON Mapping 에러 해결 (@JsonKey).

    - `build_runner`를 통한 JSON Mapping 에러 해결 (@JsonKey).

4.  **Create Post Feature**:
    - **TDD Cycle**: `FeedItem` (Red -> Green) & `CreatePostScreen` (Red -> Green) 테스트 주도 개발.
    - **Controller Pattern**: `AsyncNotifier`를 사용한 로딩/에러 상태 관리 및 UI 분리.
    - **UX Polish**: SnackBar 피드백 및 로딩 인디케이터 적용.

### 🔜 Next Steps

- **Phase 2: Feed & Posts** (Filtering, Post Detail)

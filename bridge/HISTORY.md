# 📜 History Log: Bridge

## 2026-02-08: Project Initiation & Phase 1 Completion

### ✅ Accomplishments
1.  **Project Setup**:
    -   `bridge` Flutter 프로젝트 생성.
    -   Level 2 목표 설정 (Advanced Supabase, TDD, Complex State).
    -   `AI_PROJECT_CONTEXT.md` 및 `ROADMAP.md` 작성.

2.  **Phase 1: Foundation & Auth**:
    -   **Tech Stack**: Riverpod (State), GoRouter (Nav), Supabase (Backend).
    -   **Architecture**: Clean Architecture (Presentation - Domain - Data).
    -   **Implementation**:
        -   `SupabaseConfig` 및 `main.dart` 초기화.
        -   `AuthRepository` (Interface & Supabase Implementation).
        -   `SignInController` & `SignUpController` (AsyncNotifier Pattern).
        -   `AppRouter` Redirect Logic (Auth State 연동).
        -   `SignInScreen`, `SignUpScreen` 구현.
        -   **Supabase Database**: `profiles` 테이블 생성 및 `handle_new_user` 트리거 적용 (회원가입 시 닉네임 자동 동기화).

### 🔑 Key Learnings
-   **No Pre-Implementation Rule**: AI가 코드를 미리 짜주는 대신 스캐폴딩(Shell)만 제공하여 학습 효율을 높임.
-   **Controller vs ViewModel**: Riverpod의 Notifier는 MVVM의 ViewModel과 동일한 역할을 수행함.
-   **Auth Redirection**: `GoRouter`의 `redirect`에서 로그인 상태와 현재 경로를 정교하게 체크해야 무한 루프나 잘못된 이동을 방지할 수 있음.
-   **Supabase Triggers**: Auth(회원가입)와 DB(프로필 생성)를 서버 사이드(SQL)에서 원자적으로 연결하는 패턴 학습.

### 🔜 Next Steps
-   **Phase 2: Feed & Posts** (Supabase Database & Realtime)

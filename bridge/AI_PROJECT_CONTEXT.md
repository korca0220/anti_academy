🌉 Project Context: Bridge (Level 2)

📝 Project Overview

**Bridge**는 이웃 간에 재능과 시간을 교환하는 **Time Bank (시간 화폐) & Skill Share (재능 공유)** 플랫폼입니다.
"돈"이 아닌 "시간"을 화폐로 사용하여, 서로 돕고 연결되는 따뜻한 커뮤니티를 지향합니다.
🎯 Learning Objectives (Level 2)

1.  **Supabase Deep Dive**: 단순 CRUD를 넘어 **Realtime**, **Relational Queries**, **RLS (Security Hierarchy)** 학습.
2.  **Advanced State Management**: 상태 머신 기반 비즈니스 로직(`요청 -> 수락 -> 진행 -> 완료 -> 취소`) 설계.
3.  **TDD & Testing**: 구현 전 테스트 작성 습관 (Widget/Domain/Repository Contract 중심).
4.  **Complex UI**: 채팅, 상태 반영, 동작형 인터랙션을 다루는 고난도 UI 패턴 실습.
    🛠 Tech Stack
    | Category | Technology | Usage |
    | :--- | :--- | :--- |
    | **Framework** | Flutter | Cross-platform implementation |
    | **Language** | Dart | 100% Null Safety |
    | **State** | **Riverpod (Notifier)** | Immutable State Management |
    | **Router** | **GoRouter** | Deep linking & Type-safe routes |
    | **Backend** | **Supabase** | Auth, PostgresDB, Realtime, Storage |
    | **Architecture** | **Clean Architecture** | Presentation / Domain / Data |
    | **Styling** | **Design System** | Theme, Google Fonts, Tailwind-inspired colors |
    🏗 System Architecture (Clean Architecture)
    graph TD
    UI[Presentation Layer] -->|Riverpod| Domain[Domain Layer]
    Domain -->|Interface| Data[Data Layer]
    Data -->|Implementation| Remote[Supabase]
5.  Presentation Layer (UI)

- Widgets: UI 렌더링 담당, 비즈니스 로직 최소화.
- ViewModels (Notifiers/Controllers): 입력/로딩/에러 상태 관리.

2. Domain Layer (Business Logic)

- Entities: Immutable Dart 객체 (freezed 권장).
- UseCases: 단일 비즈니스 동작 단위.
- Repositories (Interface): 데이터 접근 인터페이스 정의.

3. Data Layer

- Repositories (Impl): API 호출 및 매핑.
- Data Sources: Supabase Client, Remote 저장소.
- DTO: 필요시 수동 매핑.

🗂 Folder Structure
lib/
├── app/ # App-wide configurations (Theme, Routes, Constants)
├── core/ # Shared utilities & extensions
├── features/ # Feature-based modules
│ ├── auth/
│ ├── feed/
│ ├── chat/
│ ├── profile/
│ └── transaction/ # Exchange Logic
└── main.dart

📜 Key Conventions

1.  Strict Linting: 가능한 엄격한 규칙 유지.
2.  No Magic Strings: 문자열/색상/상수는 중앙 관리.
3.  Controller Pattern: UI 입출력은 Notifier/Controller에서 처리.
4.  State Through Riverpod: AsyncValue 기반 상태 일관성.

📌 Current Checkpoint (Phase 4 / Step 2-2)

- 완료된 학습 단위: TransactionStatus 전이 규칙 테스트, 엔티티 계약 테스트, Repository 계약 테스트.
- 강점:
  - 도메인 규칙을 코드화 후 테스트로 먼저 잠그고 진행.
  - 인터페이스-구현 분리를 통해 DB/구현 없이도 회귀 위험 낮춤.
  - room_id 기준 거래 1:1 규칙과 상태 전이 규칙을 동일 스펙으로 다루는 기반 완성.
- 다음 포인트: Step 3에서 Supabase Repository 구현 및 chat UI에 상태 반영.

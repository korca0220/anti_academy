# 📱 Project Context: HabitFlow

## 📝 개요 (Overview)

**HabitFlow**는 엔터프라이즈급 Flutter 아키텍처를 시연하기 위해 설계된 습관 추적 애플리케이션입니다.
심플함, 몰입(Flow), 그리고 아름다운 인터랙션에 초점을 맞춥니다.

## 🛠 기술 스택 (Tech Stack)

- **Framework**: Flutter
- **Language**: Dart
- **Architecture**: Clean Architecture (Feature-first or Layer-first)
- **State Management**: Riverpod (현재 선택된 도구, Bloc 등으로 대체 가능)
- **Navigation**: GoRouter (Implemented)
- **UI/Design**:
  - Font: Google Fonts (Outfit)
  - Components: Custom Premium Widgets (`HabitCard`, `PrimaryButton`, `CustomTextField`)
- **Functional Programming**: fpdart (Either, Option, TaskEither)
- **Data Class**: Freezed (Manual implementation for Models)
- **Local DB**: SharedPreferences (MVP) -> Hive/Isar (Planned)
- **Remote DB**: Supabase (Planned)

## 📂 아키텍처 구조 (Architecture Structure)

```
lib/
├── core/           # 공유 커널, 에러 핸들링, 유틸리티
├── features/       # 기능 기반 모듈
│   └── habit/
│       ├── data/
│       │   ├── datasources/  # 로컬/리모트 API
│       │   ├── models/       # DTO (Entity 상속 X, Mapper 사용)
│       │   └── repositories/ # Repository 구현체
│       ├── domain/
│       │   ├── entities/     # 순수 Dart 클래스 (Freezed)
│       │   ├── repositories/ # 인터페이스 (계약)
│       │   └── usecases/     # 비즈니스 로직 (단일 책임)
│       └── presentation/
│           ├── riverpod/     # 상태 관리 (Notifiers)
│           ├── pages/        # 화면 (Screens)
│           └── widgets/      # 재사용 컴포넌트
└── main.dart
```

## 🧩 적용된 핵심 패턴 (Key Patterns)

1.  **Mapper Pattern**: `Entity`(Domain)와 `Model`(Data)을 분리하고 `toEntity()`/`fromEntity()`로 변환.
2.  **Repository Pattern**: 도메인은 인터페이스만 정의, 데이터 계층이 구현 (의존성 역전).
3.  **Result Object Pattern**: `fpdart::Either<Failure, T>`를 사용하여 명시적인 에러 처리.

## 📏 프로젝트 규칙 (Project Rules)

### 1. 협업 방식 (Collaboration)
-   **Scaffolding First**: AI는 정답 코드를 바로 주는 대신, `TODO`가 포함된 스캐폴딩(뼈대) 파일을 제공하여 사용자가 직접 빈칸을 채우도록 유도한다. (학습 효과 극대화)
-   **Context Update**: 매 세션이 끝날 때마다 변경 사항을 `AI_PROJECT_CONTEXT.md`, `HISTORY.md`에 반영하여 컨텍스트를 최신화한다.
-   **Session Wrap-up Protocol**: 세션을 마칠 때는 반드시 다음 절차를 따른다.
    1.  **Rule Update**: 이번 세션에서 새로 생긴 규칙이나 AI 행동 지침을 `AI_PROJECT_CONTEXT.md`에 기록한다.
    2.  **History Log**: 작업 내용과 Key Learnings를 `HISTORY.md`에 남긴다.
    3.  **Next Planning**: `task.md`와 `ROADMAP.md`를 업데이트하여 다음 작업을 명시한다.

### 2. UI/UX 가이드라인 (Design Specs)
-   **Explicit Specs**: "예쁘게 해주세요" 대신 구체적인 수치(Radius: 16, Blur: 10, Color: Primary with 0.1 opacity)를 제시한다.
-   **Premium Feel**: 단순한 기능 구현을 넘어, Hero Animation, Scale Button 등 Micro-interaction을 적극 도입한다.

### 3. 개발 원칙 (Development Principles)
-   **Full Stack Vertical Slice**: 기능 추가 시 화면만 수정하는 것이 아니라, Domain(Entity) -> Data(Model) -> Repository -> Presentation(Screen) 순으로 전 계층을 수직적으로 통합 구현한다.
-   **State Management**: 상태 관리는 Riverpod을 사용하며, UI 로직과 비즈니스 로직을 철저히 분리한다.

### 4. 보안 규칙 (Security)
-   **Environment Variables**: API Key 등 민감 정보는 절대 소스 코드에 하드코딩하지 않는다. `.env` 파일을 사용하고 `.gitignore`에 추가한다.

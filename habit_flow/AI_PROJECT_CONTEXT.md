# 📱 Project Context: HabitFlow

## 📝 개요 (Overview)
**HabitFlow**는 엔터프라이즈급 Flutter 아키텍처를 시연하기 위해 설계된 습관 추적 애플리케이션입니다.
심플함, 몰입(Flow), 그리고 아름다운 인터랙션에 초점을 맞춥니다.

## 🛠 기술 스택 (Tech Stack)
*   **Framework**: Flutter
*   **Language**: Dart
*   **Architecture**: Clean Architecture (Feature-first or Layer-first)
*   **State Management**: Riverpod (현재 선택된 도구, Bloc 등으로 대체 가능)
*   **Navigation**: GoRouter
*   **Functional Programming**: fpdart (Either, Option, TaskEither)
*   **Data Class**: Freezed (Manual implementation for Models)
*   **Local DB**: SharedPreferences (MVP) -> Hive/Isar (Planned)
*   **Remote DB**: Supabase (Planned)

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

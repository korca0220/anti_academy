# 📱 HabitFlow

> **습관 추적 앱 — Clean Architecture 기초**
> "좋은 코드는 좋은 습관에서 시작됩니다."

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=flutter&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-Clean_Arch-blue)
![State](https://img.shields.io/badge/State-Riverpod-purple)

---

## 📖 프로젝트 개요

**HabitFlow**는 엔터프라이즈급 Flutter 아키텍처를 시연하기 위해 설계된 습관 추적 애플리케이션입니다.
단순한 기능 구현을 넘어, **유지보수 가능하고 확장 가능한** 소프트웨어 구조를 학습하는 데 초점을 맞춥니다.

### 핵심 학습 목표
1.  **Clean Architecture**: Presentation → Domain ← Data 단방향 의존성
2.  **Riverpod 상태 관리**: Notifier 패턴, AsyncValue 기반 상태 처리
3.  **오프라인 우선 설계**: 로컬 스토리지 우선, 백엔드 동기화
4.  **프리미엄 UI/UX**: 애니메이션, 인터랙션, 디자인 시스템

---

## ✨ 주요 기능

- **습관 CRUD**: 습관 생성, 수정, 삭제 및 목록 관리
- **완료 체크**: 일일 습관 체크 및 스트릭(연속 달성) 추적
- **우선순위 정렬**: 드래그 앤 드롭으로 습관 순서 변경
- **통계 시각화**: Custom Painter로 구현한 진행률 차트
- **다크/라이트 모드**: 영구 저장되는 테마 시스템
- **오프라인 지원**: Supabase와 로컬 DB 동기화 전략

---

## 🛠 기술 스택

| 카테고리 | 기술 | 용도 |
| :--- | :--- | :--- |
| **Framework** | Flutter | 크로스 플랫폼 구현 |
| **Language** | Dart | 100% Null Safety |
| **State** | Riverpod (Notifier) | 불변 상태 관리 |
| **Router** | GoRouter | 딥링크 지원, 타입 안전 라우팅 |
| **Backend** | Supabase | Auth, PostgresDB |
| **Local DB** | SharedPreferences → Hive | 오프라인 우선 스토리지 |
| **FP** | fpdart | Either, Option 기반 에러 처리 |
| **Codegen** | freezed | 불변 데이터 클래스 |

---

## 🏗 아키텍처 구조

```
lib/
├── core/           # 공유 커널, 에러 핸들링, 유틸리티
├── features/
│   └── habit/
│       ├── data/
│       │   ├── datasources/  # 로컬/리모트 API
│       │   ├── models/       # DTO (Mapper 패턴)
│       │   └── repositories/ # Repository 구현체
│       ├── domain/
│       │   ├── entities/     # 순수 Dart 클래스 (Freezed)
│       │   ├── repositories/ # 인터페이스 (계약)
│       │   └── usecases/     # 단일 책임 비즈니스 로직
│       └── presentation/
│           ├── riverpod/     # 상태 관리 (Notifiers)
│           ├── pages/        # 화면 (Screens)
│           └── widgets/      # 재사용 컴포넌트
└── main.dart
```

---

## 🚀 시작하기

### 사전 요구사항
- Flutter SDK (^3.x)
- Dart SDK

### 설치

1. **의존성 설치**
    ```bash
    flutter pub get
    ```

2. **코드 생성**
    ```bash
    dart run build_runner build
    ```

3. **앱 실행**
    ```bash
    flutter run
    ```

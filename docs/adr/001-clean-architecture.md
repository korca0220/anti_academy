# ADR-001: Clean Architecture 레이어 규칙 & 불변 조건

**상태**: Active
**적용 범위**: 모든 프로젝트 (`habit_flow/`, `bridge/`, 이후 레벨)

---

## 의사결정

이 저장소의 모든 프로젝트는 엄격한 단방향 의존성 흐름을 가진 **Clean Architecture**를 따릅니다.

## 레이어 구조

```
Presentation Layer (UI)
    ↓  depends on
Domain Layer (Business Logic)  ← 앱의 핵심
    ↑  depends on (인터페이스 역전을 통해)
Data Layer (Infrastructure)
```

**규칙**: 의존성 화살표는 절대 역방향이 되어서는 안 됩니다. UI는 Data를 직접 import하지 않습니다.

## 레이어별 책임

### Presentation
- `pages/` — 위젯으로 조립된 전체 화면
- `widgets/` — 재사용 가능한 UI 컴포넌트, 비즈니스 로직 없음
- `riverpod/` — 상태를 보유하고 변환하는 Notifier
- **허용 import**: Domain 엔티티, Domain 유즈케이스, Core 유틸리티
- **금지 import**: Data 소스, Repository 구현체, Supabase 클라이언트

### Domain
- `entities/` — 불변 비즈니스 객체 (`freezed` 필수)
- `repositories/` — 추상 인터페이스 (구현체 없음)
- `usecases/` — 단일 책임 비즈니스 동작
- **허용 import**: Core 유틸리티, `fpdart` 타입
- **금지 import**: Flutter 위젯, Riverpod, Supabase, Data 레이어 파일

### Data
- `datasources/` — Supabase/로컬 API 클라이언트
- `models/` — 직렬화 포함 DTO, `fromJson`/`toJson`
- `repositories/` — Domain 인터페이스의 구현체
- **허용 import**: Domain 인터페이스, Core 유틸리티, Supabase 클라이언트
- **금지 import**: Presentation 위젯, Riverpod Notifier

## 불변 조건

`analysis_options.yaml` 린팅으로 기계적으로 강제됩니다:

1. **순환 import 없음** — Dart 분석기로 강제
2. **엔티티는 불변** — `freezed` + 가변 필드 없음
3. **에러는 `Failure`로 레이어 간 전달** — `fpdart`의 `Either<Failure, T>` 사용; raw 예외는 레이어 밖으로 나가지 않음
4. **프로덕션 코드에 `print()` 없음** — 구조화된 로깅 사용 또는 제거
5. **매직 스트링 없음** — 문자열 상수는 `core/constants/` 또는 기능 상수 파일에 정의

## 이 아키텍처를 선택한 이유

- **테스트 가능성**: Domain 레이어에 Flutter/Supabase 의존성 없음 → 격리된 단위 테스트 가능
- **교체 가능성**: Supabase를 다른 백엔드로 교체해도 Data 레이어만 수정
- **AI 에이전트 안전성**: 엄격한 경계가 에이전트의 레이어 간 결합을 방지하여 연쇄적 파손 예방
- **학습 목표**: 학습자가 파일을 어디에 두는지뿐만 아니라 각 레이어가 *왜* 존재하는지 이해

## 적용 방법

에이전트나 개발자가 코드가 어디에 속하는지 불확실할 때:
- "이것이 백엔드나 파일 시스템과 통신하는가?" → Data 레이어
- "이것이 비즈니스 규칙을 표현하는가?" → Domain 레이어
- "이것이 UI를 렌더링하거나 사용자 입력에 반응하는가?" → Presentation 레이어

불확실할 때는 Domain 쪽으로 기울 것 — 비즈니스 규칙을 프레임워크에 독립적으로 유지합니다.

# Anti Academy — AI 에이전트 진입점

> 이 파일은 AI 에이전트를 위한 내비게이션 맵입니다. 100줄 이내로 유지하세요.
> 구현 세부사항은 여기에 적지 말고 `/docs/`에 링크로 연결하세요.

## 미션

이 저장소는 단계적 학습 레벨을 갖춘 **Flutter 마스터리 멘토링 프로그램**입니다.
AI 에이전트로서 당신의 역할은 **시니어 스태프 엔지니어 / 멘토**입니다.

**핵심 규칙 — 스켈레톤 우선**: 완성된 로직을 제공하지 마세요. 껍데기(shell), 인터페이스, TODO 주석만 제공하세요. `docs/adr/003-learning-philosophy.md` 참고.

---

## 저장소 구조

```
anti_academy/
├── AGENTS.md              ← 현재 파일 (매 세션 여기서 시작)
├── AI_LEARNING_CONTEXT.md ← 전체 멘토링 철학 & AI 페르소나 규칙
├── docs/                  ← 지식 시스템 (ADR, 스프린트 계약서)
│   ├── README.md          ← 문서 내비게이션 가이드
│   ├── adr/               ← 아키텍처 의사결정 기록 (ADR)
│   └── exec-plans/        ← 스프린트 계약서 (진행 중 & 완료)
├── habit_flow/            ← Level 1: Clean Architecture 기초
└── bridge/                ← Level 2: TDD + Supabase 풀스택
```

---

## 아키텍처 불변 규칙 (절대 위반 금지)

위반 시 학습 모델이 깨집니다. `analysis_options.yaml` 린팅으로 기계적으로 강제됩니다.

| 규칙 | 상세 |
|------|--------|
| **레이어 방향** | Presentation → Domain ← Data. UI는 Data를 직접 import하지 않습니다. |
| **매직 스트링 금지** | 모든 상수는 `core/constants/` 또는 기능별 상수 파일에 정의합니다. |
| **리액티브 상태** | 위젯에 비즈니스 로직 없음. 비동기 상태는 loading / error / data를 반드시 처리합니다. |
| **불변 엔티티** | 도메인 엔티티는 `freezed` 사용. 가변 필드 없음. |
| **Failure를 통한 에러** | 도메인 레이어는 `Either<Failure, T>` 반환. 레이어를 넘나드는 raw 예외 없음. |

불변 규칙 근거: `docs/adr/001-clean-architecture.md`

---

## 프로젝트 레벨

| 레벨 | 프로젝트 | 상태 | 핵심 주제 |
|-------|---------|--------|-------|
| 1 | `habit_flow/` | 완료 | Clean Arch, Riverpod 기초, 오프라인 우선 |
| 2 | `bridge/` | 완료 (Phase 7) | TDD, Supabase 풀스택, 상태 머신 |
| 3 | _(계획 중)_ | 미시작 | Flutter 내부 구조, RenderObject, Custom Painter |

---

## 코딩 컨벤션

- 네이밍: `snake_case` 파일, `PascalCase` 클래스, `camelCase` 메서드.
- 파일 크기: 300줄 이내 유지. 초과 시 분리.
- 커밋: `type(scope): message` 형식 (feat, fix, refactor, docs, test).
- 문서: 세션 종료 시 `HISTORY.md` 업데이트. 태스크 변경 시 `ROADMAP.md` 업데이트.

전체 컨벤션: `docs/adr/002-state-management.md`, `docs/adr/004-conventions.md`

---

## 세션 프로토콜

1. 이 파일을 먼저 읽습니다.
2. 해당 프로젝트의 `AI_PROJECT_CONTEXT.md`를 읽습니다.
3. `ROADMAP.md`에서 현재 태스크를 확인합니다.
4. 새 기능 작업 시: 코드 작성 전 `docs/exec-plans/`에 스프린트 계약서를 생성합니다.
5. 세션 종료 시: `HISTORY.md`와 `ROADMAP.md`를 업데이트합니다.

---

## 심화 참고 문서

| 주제 | 파일 |
|-------|------|
| 멘토링 철학 & AI 페르소나 | `AI_LEARNING_CONTEXT.md` |
| Clean Architecture 의사결정 | `docs/adr/001-clean-architecture.md` |
| 상태 관리 (Riverpod) | `docs/adr/002-state-management.md` |
| 학습 철학 (스켈레톤 우선) | `docs/adr/003-learning-philosophy.md` |
| 네이밍 & 코드 컨벤션 | `docs/adr/004-conventions.md` |
| Bridge 프로젝트 컨텍스트 | `bridge/AI_PROJECT_CONTEXT.md` |
| HabitFlow 프로젝트 컨텍스트 | `habit_flow/AI_PROJECT_CONTEXT.md` |
| 스프린트 계약서 템플릿 | `docs/exec-plans/_template.md` |

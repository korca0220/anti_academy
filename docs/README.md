# Docs — 지식 시스템

이 디렉토리는 모든 아키텍처 의사결정과 스프린트 계획의 **공식 기록**입니다.
에이전트: 저장소 루트의 `AGENTS.md`에서 시작한 후, 필요에 따라 이 디렉토리를 탐색하세요.

## 구조

```
docs/
├── README.md              ← 현재 파일 (내비게이션 가이드)
├── adr/                   ← 아키텍처 의사결정 기록 (ADR)
│   ├── 001-clean-architecture.md
│   ├── 002-state-management.md
│   ├── 003-learning-philosophy.md
│   └── 004-conventions.md
└── exec-plans/            ← 스프린트 계약서
    └── _template.md       ← 새 스프린트 계약서 템플릿
```

## ADR 인덱스

| ID | 제목 | 상태 |
|----|-------|--------|
| 001 | Clean Architecture 레이어 규칙 & 불변 조건 | Active |
| 002 | 상태 관리 — Riverpod 패턴 | Active |
| 003 | 학습 철학 — 스켈레톤 우선 접근법 | Active |
| 004 | 네이밍, 파일, 커밋 컨벤션 | Active |

## Exec Plans 인덱스

| 파일 | 스프린트 | 상태 |
|------|--------|--------|
| `_template.md` | 템플릿 | — |

## 규칙

- ADR은 추가만 가능합니다. 대체된 의사결정은 `[SUPERSEDED by ADR-NNN]`으로 표기합니다.
- 완료된 스프린트 계약서는 `exec-plans/archive/`로 이동합니다.
- ADR과 상충하는 방식으로 코드를 수정할 경우, ADR을 먼저 업데이트합니다.

# 스프린트 계약서: [기능 이름]

**날짜**: YYYY-MM-DD
**프로젝트**: bridge / habit_flow
**스프린트**: Phase X — [Phase 이름]
**상태**: draft / active / completed

---

## 목표 (Objective)

이 스프린트가 무엇을 완성하며, 왜 사용자에게 중요한지 한 문단으로 설명합니다.

---

## 범위 (Scope)

### 포함 범위 (In Scope)
- [ ] 구체적인 산출물 1
- [ ] 구체적인 산출물 2

### 제외 범위 (Out of Scope)
- 범위 확장을 방지하기 위해 명시적으로 제외하는 항목들

---

## 완료 기준 (Done Criteria)

다음 항목이 **모두** 검증 가능할 때 스프린트는 완료됩니다:

- [ ] **검증 가능한 동작 1**: 예: "사용자가 '게시글 작성'을 탭하면 새 게시글이 새로고침 없이 피드에 나타난다"
- [ ] **검증 가능한 동작 2**: 예: "API 호출 실패 시 에러 스낵바가 표시되고 폼은 초기화되지 않는다"
- [ ] **검증 가능한 동작 3**: 예: "모의 데이터 소스를 사용한 PostRepository.createPost() 단위 테스트가 통과한다"
- [ ] **회귀 없음**: 기존 기능이 정상 동작함
- [ ] **린터 통과**: `flutter analyze`에서 에러 0개

> 완료 기준은 사람이 앱을 클릭하거나 테스트를 통해 검증 가능해야 합니다.
> "UI가 보기 좋다"처럼 모호한 기준은 허용되지 않습니다 — 구체적인 동작으로 대체하세요.

---

## 아키텍처 노트 (Architecture Notes)

- 수정되는 레이어: Presentation / Domain / Data
- 새로 도입되는 provider/notifier
- 새로운 domain 엔티티 또는 유즈케이스
- DB 스키마 변경 사항 (있는 경우)

---

## 스켈레톤 계획 (Skeleton Plan)

생성할 파일 (껍데기만, 로직 없음):

```
lib/features/{feature}/
├── domain/
│   ├── entities/   new_entity.dart         # TODO: 필드 정의
│   └── usecases/   create_thing_usecase.dart # TODO: 구현
├── data/
│   ├── models/     new_entity_model.dart   # TODO: fromJson/toJson
│   └── datasources/ new_datasource.dart   # TODO: Supabase 호출
└── presentation/
    ├── riverpod/   new_notifier.dart       # TODO: 상태 + 메서드
    └── pages/      new_page.dart           # TODO: UI 연결
```

---

## 의사결정 로그 (Decision Log)

| 의사결정 | 근거 |
|----------|-----------|
| 예: `AsyncNotifier` 대신 `Notifier` 사용 | 기능이 비동기 우선으로 설계됨 |

---

## 알려진 기술 부채 (Known Technical Debt)

- 취한 단축키와 그 이유 (나중에 해결하기 위해 기록)

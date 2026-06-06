# 스프린트 계약서: Review System

**날짜**: 2026-06-06
**프로젝트**: bridge
**스프린트**: Phase 4 — Transactions (Review 확장)
**상태**: active

---

## 목표 (Objective)

거래가 완료된 이후 참여자 간 상호 리뷰(별점/코멘트)를 남길 수 있는 최소 흐름을 구축합니다.  
이 스프린트의 핵심은 신뢰 지표의 기초를 만들고, 이후 평판(매너온도) 기능으로 확장 가능한 구조를 마련하는 것입니다.

---

## 범위 (Scope)

### 포함 범위 (In Scope)
- [x] 리뷰 기능 스캐폴딩 생성 (Domain/Data/Presentation)
- [x] 거래 완료 상태에서 리뷰 입력 UI 진입점 연결
- [x] Supabase `reviews` 스키마 초안 추가
- [ ] 리뷰 저장 로직 구현
- [ ] 리뷰 중복 작성 방지 규칙 구현 (작성자 기준 거래당 1회)
- [ ] 리뷰 조회/노출 로직 구현

### 제외 범위 (Out of Scope)
- 리뷰 수정/삭제
- 평판 점수 집계 알고리즘 (매너온도 계산식)
- 리뷰 신고/블라인드 처리

---

## 완료 기준 (Done Criteria)

다음 항목이 **모두** 검증 가능할 때 스프린트는 완료됩니다:

- [ ] 거래 완료 상태에서 `리뷰 남기기` 액션을 통해 입력 UI에 진입할 수 있다
- [ ] 리뷰 입력 후 저장 시 DB에 1건 생성된다
- [ ] 동일 작성자가 동일 거래에 중복 리뷰를 시도하면 실패한다
- [ ] 작성한 리뷰가 앱에서 다시 조회된다
- [ ] **회귀 없음**: 기존 거래 상태 전이 기능이 정상 동작한다
- [ ] **린터 통과**: `flutter analyze`에서 에러 0개

---

## 아키텍처 노트 (Architecture Notes)

- 수정되는 레이어: Presentation / Domain / Data
- 새 feature: `lib/features/review/`
- DB 변경: `supabase/11_reviews.sql` (신규)
- 기존 연동 지점: `transaction_status_widget.dart` (`completed` 상태 액션)

---

## 스켈레톤 계획 (Skeleton Plan)

생성/수정 파일 (껍데기 + TODO 중심):

```
lib/features/review/
├── domain/
│   ├── entities/review.dart
│   └── repositories/review_repository.dart
├── data/
│   └── repositories/supabase_review_repository.dart
└── presentation/
    ├── providers/review_providers.dart
    └── widgets/review_bottom_sheet.dart
```

```
supabase/11_reviews.sql
lib/features/transaction/presentation/widgets/transaction_status_widget.dart
```

---

## 의사결정 로그 (Decision Log)

| 의사결정 | 근거 |
|----------|-----------|
| 리뷰 기능을 `review` feature로 분리 | Transaction과 관심사를 분리하여 확장성 확보 |
| 완료 상태에서만 리뷰 진입 허용 | 도메인 규칙 단순화 + UX 명확성 |
| 먼저 UI 진입/스키마/계층 스캐폴딩부터 구축 | 스켈레톤 우선 학습 원칙 준수 |

---

## 알려진 기술 부채 (Known Technical Debt)

- 현재 스키마는 평판 집계 컬럼/뷰를 포함하지 않음 (후속 스프린트에서 확장)
- 리뷰 입력 검증(욕설 필터, 길이 정책 등)은 미적용 상태

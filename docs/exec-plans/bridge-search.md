# 스프린트 계약서: Search (키워드 검색)

**날짜**: 2026-06-08
**프로젝트**: bridge
**스프린트**: Phase 5 — Search
**상태**: active

---

## 목표 (Objective)

사용자가 키워드로 게시글을 검색할 수 있는 화면을 구현한다.
현재 피드는 전체 목록만 보여주는데, 원하는 재능/서비스를 빠르게 찾을 수 있는 탐색 경로가 없다.
Supabase의 `ilike` 쿼리를 활용해 제목+내용 부분 일치 검색을 구현한다.

> **왜 FTS 대신 `ilike`?** Supabase Full Text Search는 영문에 최적화되어 있고 한국어는 별도 사전 설정이 필요하다. `ilike`는 설정 없이 한국어 부분 일치를 지원하므로 이 단계에서 더 실용적이다.

---

## 범위 (Scope)

### 포함 범위 (In Scope)
- [ ] `PostRepository`에 `search(String query)` 메서드 추가 (인터페이스 + 구현체)
- [ ] `searchPostsProvider(String query)` — family function provider
- [ ] `SearchScreen` — 검색 바 + 결과 목록
- [ ] 라우트 `/search` 추가
- [ ] HomeScreen AppBar에 검색 진입 아이콘 추가

### 제외 범위 (Out of Scope)
- 검색 히스토리 저장
- 사용자(닉네임) 검색
- 필터(Request/Offer) 조합 검색

---

## 완료 기준 (Done Criteria)

- [ ] 검색어 입력 시 제목 또는 내용에 해당 키워드가 포함된 게시글 목록이 표시된다
- [ ] 검색 결과가 없으면 Empty State가 표시된다
- [ ] 검색어가 비어있으면 결과를 표시하지 않는다 (빈 리스트)
- [ ] HomeScreen AppBar에서 검색 화면으로 진입할 수 있다
- [ ] 회귀 없음: 기존 Feed, Chat, Profile 화면 정상 동작
- [ ] `flutter analyze` 에러 0개

---

## 아키텍처 노트 (Architecture Notes)

- 수정 레이어: Domain (인터페이스), Data (Supabase), Presentation (화면 + provider)
- `SearchScreen`은 `feed` feature 안에 위치 — 게시글 검색이므로 feed의 자연스러운 확장
- **provider 선택**: `@riverpod` family function provider
  - 검색 결과는 읽기 전용, mutation 없음 → Notifier 불필요
  - query 파라미터는 family로 전달
- **query 상태**: `SearchScreen` 내부 `TextEditingController` + `useState` 수준으로 관리
  - 전역 provider로 올릴 이유 없음 (화면 외부에서 query를 읽을 일 없음)

---

## 스켈레톤 계획 (Skeleton Plan)

```
# 1. Domain
features/feed/domain/repositories/
  post_repository.dart              # search(String query) 추가

# 2. Data
features/feed/data/repositories/
  supabase_post_repository.dart     # search ilike 쿼리 구현

# 3. Presentation
features/feed/presentation/providers/
  post_providers.dart               # searchPostsProvider 추가

features/feed/presentation/screens/
  search_screen.dart                # SearchScreen
```

---

## 의사결정 로그 (Decision Log)

| 의사결정 | 근거 |
|----------|------|
| `ilike` 사용 | 한국어 FTS 설정 없이 부분 일치 지원 |
| query 상태를 위젯 로컬로 관리 | 화면 외부에서 참조할 필요 없음, 전역 provider 오버엔지니어링 |
| `feed` feature에 SearchScreen 배치 | 게시글 검색 = feed 도메인의 확장 |

---

## 알려진 기술 부채 (Known Technical Debt)

- `ilike`는 인덱스 없이 풀 스캔 → 데이터 증가 시 성능 이슈. 추후 FTS 인덱스 도입 검토.

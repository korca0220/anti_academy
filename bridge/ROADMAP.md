🌉 로드맵: Bridge (Time Bank Platform)
**목표**: Supabase의 기능을 120% 활용한 **Realtime Social Platform** 구축.
🏁 Phase 1: 기반 구축 (Setup & Auth)

- [x] **Project Setup**: 기본 구조 세팅 (Riverpod, GoRouter, Theme)
- [x] **Supabase Init**: 프로젝트 연동 및 Config 설정
- [x] **Auth Domain**: Entity & Repository Interface
- [x] **Auth Implementation**: Supabase Auth (Sign In/Up/Out)
- [x] **Auth UI**: Login/SignUp Screens
- [x] **Auth State**: Splash Screen & Auto-Redirect Logic
- [x] **Profile Setup (DB)**: `profiles` Table Schema & Auto-create Trigger
      📡 Phase 2: 게시글 & 피드 (Feed & Posts)
- [x] **Database Schema**: `posts` 테이블 설계 (Request/Offer 타입 구분)
- [x] **Domain Layer**: Post Entity & Repository 구현
- [x] **Feed UI**: 메인 리스트 구현 (Basic List 완료)
- [x] **Create Post**: 글쓰기 화면 및 로직 (Floating Action Button + TDD)
- [x] **Filtering**: 요청(Help) vs 제공(Offer) 필터링
- [x] **Post Detail**: 상세 화면 구현
      💬 Phase 3: 실시간 채팅 (Realtime Chat) - **CORE**
- [x] **Database Schema**: `rooms`, `messages` 테이블 설계
- [x] **RLS Policies**: 내 채팅방만 볼 수 있도록 보안 설정
- [x] **Chat List**: 나의 채팅방 목록 (Realtime stream)
- [x] **Chat Room**: 1:1 채팅 화면 구현
- [x] **Realtime Messaging**: 메시지 전송 및 즉시 수신 (Optimistic UI)
      🤝 Phase 4: 거래 시스템 (Transactions)
- [x] **State Machine 설계**: `proposed -> accepted -> in_progress -> completed` + `canceled`
- [x] **Domain Test**: `TransactionStatus` 전이 규칙 테스트
- [x] **Entity Test**: 거래 엔티티 불변성/복사/nullable 동작 검증
- [x] **Repository Contract**: `getByRoomId`, `watchByRoomId`, `upsert`, `updateStatus` 계약 테스트 완료
- [x] **Transaction UI**: 채팅방 내 거래 상태 표시 (System Message)
- [x] **Transaction Actions**: 버튼 기반 상태 전이 액션 (수락/진행/완료/취소)
- [x] **Review System**: 거래 완료 후 상호 평가 및 별점
      🔍 Phase 5: 탐색 및 프로필 (Discover)
- [ ] **Profile View**: 상대방 프로필 및 매너온도(Reputation) 확인 — 진행 중
- [ ] **My Activity**: 내가 쓴 글, 나의 거래 내역 모아보기
- [ ] **Search**: 키워드 검색 (Supabase Full Text Search)
   - [x] **UI/UX Polish**: 스켈레톤 UI, Empty States 적용
      🎨 Phase 6: 완성도 향상 (Polish)
- [ ] **Onboarding**: 앱 최초 실행 시 안내 가이드
- [ ] **Animations**: 리스트 진입, 버튼 클릭, 좋아요 인터랙션
- [ ] **Edge Cases**: 에러 처리, 네트워크 연결 끊김 처리

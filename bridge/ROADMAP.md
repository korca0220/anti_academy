# 🌉 로드맵: Bridge (Time Bank Platform)

**목표**: Supabase의 기능을 120% 활용한 **Realtime Social Platform** 구축.

## 🏁 Phase 1: 기반 구축 (Setup & Auth)
- [ ] **Project Setup**: 기본 구조 세팅 (Riverpod, GoRouter, Freezed)
- [ ] **Design System**: 컬러 팔레트, 타이포그래피, 기본 위젯(Button, Input) 구현
- [ ] **Supabase Init**: 프로젝트 생성 및 연결
- [ ] **Auth Feature**:
    - [ ] Sign Up / Sign In (Email & Password)
    - [ ] **Profile Setup**: 닉네임, 관심사, 위치 설정 (users 테이블 연동)
    - [ ] Auth State 관리 (Splash Screen 분기 처리)

## 📡 Phase 2: 게시글 & 피드 (Feed & Posts)
- [ ] **Database Schema**: `posts` 테이블 설계 (Request/Offer 타입 구분)
- [ ] **Feed UI**: 메인 리스트 화면 (SliverScrollView)
- [ ] **Create Post**: 글쓰기 화면 및 로직 (Floating Action Button)
- [ ] **Filtering**: 요청(Help) vs 제공(Offer) 필터링
- [ ] **Post Detail**: 상세 화면 구현

## 💬 Phase 3: 실시간 채팅 (Realtime Chat) - **CORE**
- [ ] **Database Schema**: `rooms`, `messages` 테이블 설계
- [ ] **RLS Policies**: 내 채팅방만 볼 수 있도록 보안 설정
- [ ] **Chat List**: 나의 채팅방 목록 (Realtime stream)
- [ ] **Chat Room**: 1:1 채팅 화면 구현
- [ ] **Realtime Messaging**: 메시지 전송 및 즉시 수신 (Optimistic UI)

## 🤝 Phase 4: 거래 시스템 (Transactions)
- [ ] **State Machine**: 거래 상태 설계 (Proposed -> Accepted -> Completed -> Canceled)
- [ ] **Transaction UI**: 채팅방 내 거래 상태 표시 (System Message)
- [ ] **Review System**: 거래 완료 후 상호 평가 및 별점

## 🔍 Phase 5: 탐색 및 프로필 (Discover)
- [ ] **Profile View**: 상대방 프로필 및 매너온도(Reputation) 확인
- [ ] **My Activity**: 내가 쓴 글, 나의 거래 내역 모아보기
- [ ] **Search**: 키워드 검색 (Supabase Full Text Search)

## 🎨 Phase 6: 완성도 향상 (Polish)
- [ ] **Onboarding**: 앱 최초 실행 시 안내 가이드
- [ ] **Animations**: 리스트 진입, 버튼 클릭, 좋아요 인터랙션
- [ ] **Edge Cases**: 에러 처리, 네트워크 연결 끊김 처리
- [ ] **Deploy**: 스토어 출시 준비 (아이콘, 스플래시)

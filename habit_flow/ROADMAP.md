# 🗓️ 로드맵: HabitFlow (마스터리 에디션)

**목표**: 고급 패턴을 적용한 **상용 수준(Production-Grade)** 의 플러터 앱 구축.

## 🏁 Phase 1-3: 핵심 코어 (완료)
- [x] Clean Architecture 셋업
- [x] 도메인 계층 규칙 정의 (Entities, UseCases)
- [x] 프레젠테이션 계층 골격 (Riverpod Notifiers)
- [x] 수동 DTO 구현 (CodeGen 의존성 제거 및 아키텍처 분리)

## 💾 Phase 4: 데이터 계층 심화 (현재 진행 중)
- [x] **Mapper 패턴**: Model과 Entity 분리
- [ ] **Data Source**: 견고한 `SharedPreferences` 핸들링 구현
- [ ] **Repository**: `runCatching` 패턴과 `Either`를 활용한 에러 핸들링
- [ ] **Testing**: Repository 계층에 대한 유닛 테스트 (Unit Tests)

## 📱 Phase 5: UI 구현 및 연결 (Local MVP)
- [ ] **Routing**: 화면 이동 구조 잡기
- [ ] **Screen**: 실제 동작하는 리스트 화면 구현
- [ ] **Integration**: Notifier - Repository - View 연결 (완전한 오프라인 앱 완성)

## 🎨 Phase 6: 고급 UI/UX (Visual Polish)
- [ ] **Micro-Interactions**: 히어로 애니메이션, 폭죽 효과 등
- [ ] **Custom Painters**: 라이브러리 없이 직접 그리는 차트/그래프
- [ ] **Reordering**: 드래그 앤 드롭으로 우선순위 변경
- [ ] **Theme System**: 다크/라이트 모드 영구 저장 시스템

## ☁️ Phase 7: 백엔드 & 오프라인 퍼스트 (Architecture)
- [ ] **Supabase Integration**: 인증(Auth) & 데이터베이스
- [ ] **Optimistic UI**: 서버 응답 전 UI 즉시 업데이트
- [ ] **Sync Strategy**: 오프라인 상태에서의 변경 사항 동기화 전략

## 🛡️ Phase 8: 품질 보증 및 최적화 (Engineering)
- [ ] **Riverpod Observer**: 상태 변경 로깅
- [ ] **Environment Config**: 개발(Dev) / 운영(Prod) 환경 분리
- [ ] **Widget Tests**: UI 흐름 자동화 테스트

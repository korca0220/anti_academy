# 📜 Anti Academy Session History

이 문서는 사용자와 AI 멘토(AntiGravity) 간의 협업 세션 기록입니다.
프로젝트의 진행 상황, 주요 의사결정, 그리고 학습한 내용을 기록하여 다음 세션의 컨텍스트로 활용합니다.

---

## 📅 Session 1: Phase 5 & 6 (2026-02-01)

### 🎯 목표 (Goal)
- **Phase 5 (UI Implementation)**: GoRouter 도입 및 화면 연결.
- **Phase 6 (Visual Polish)**: 디자인 시스템 기초 수립 및 커스텀 컴포넌트 제작.

### ✅ 달성한 작업 (Accomplishments)
1.  **Navigation (`GoRouter`)**
    -   `go_router` 의존성 추가 및 `AppRouter` 프로바이더 구현.
    -   `main.dart`에 `MaterialApp.router` 주입 (User manually refactored).
    -   `/` (Home) 및 `/add` (Add Habit) 라우트 정의.
    -   `context.push('/add')` 및 `context.pop()`을 이용한 네비게이션 구현.

2.  **Screens & Logic**
    -   `AddHabitScreen`: `ConsumerStatefulWidget`으로 변환.
    -   `TextEditingController`를 사용한 폼 입력 및 `Riverpod` 연동.

3.  **Design System (Phase 6 Start)**
    -   **Typography**: `Google Fonts (Outfit)` 적용.
    -   **Color**: `ThemeData` seedColor 변경 (`Colors.lightGreen`).

4.  **Custom Components (Premium Widgets)**
    -   `HabitCard`: `BoxShadow`, `BorderRadius`가 적용된 카드 위젯.
    -   `PrimaryButton`: `InkWell` + `Container` 기반의 스타일리시한 버튼.
    -   `CustomTextField`: `InputDecoration`을 커스텀한 박스형 입력 필드.

5.  **Micro-Interactions & UX**
    -   **Hero Animation**: `HabitCard`와 `HabitDetailScreen` 간의 자연스러운 화면 전환.
    -   **ScaleButton**: 터치 시 쫀득한 반응을 주는 래퍼 위젯 구현.
    -   **Reordering**: `ReorderableListView`와 `orderIndex` 필드를 이용한 드래그 앤 드롭 정렬.
    -   **Custom Painters**: `CustomPainter` API를 사용하여 외부 라이브러리 없이 원형 차트 구현.
    -   **Completion Logic**: `Checkbox`와 `toggle` 메서드를 통해 습관 완료 상태 관리 및 시각화.

### 📝 주요 의사결정 및 배운 점 (Key Learnings)
-   **Scaffolding First**: AI는 정답 코드를 주는 대신, `TODO`가 포함된 스캐폴딩 파일을 제공하여 사용자가 직접 빈칸을 채우도록 유도함.
-   **Design Specs**: "예쁘게"라는 모호한 요청 대신, 구체적인 디자인 스펙(Radius 16, Shadow Blur 10 등)을 제공하여 퀄리티를 확보함.
-   **State Management**: `TextField`와 `Controller` 사용 시 `onChanged`에서의 중복 할당 문제 해결.
-   **Full Stack Feature**: Reordering 구현 시 Presentation 뿐만 아니라 Domain(Entity), Data(Model), Repository까지 전 계층을 수정해야 함을 학습.

### 🚀 다음 단계 (Next Steps)
-   **Phase 6 (Visual Polish)** 계속:
    -   **Micro-Interactions**: Hero Animation, AnimatedContainer 등 적용.
    -   **Reordering**: `ReorderableListView` 구현.
-   **Phase 7 (Backend)**: Supabase 연동 준비.

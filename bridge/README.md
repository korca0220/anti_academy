# 🌉 Bridge

> **Time Bank & Skill Share Platform**
> "돈"이 아닌 "시간"을 화폐로 사용하여, 이웃과 서로 돕고 연결되는 따뜻한 커뮤니티.

![Flutter](https://img.shields.io/badge/Flutter-3.5.0+-02569B?style=flat&logo=flutter&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-Full_Stack-3ECF8E?style=flat&logo=supabase&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-Clean_Arch_+_Riverpod-blue)

---

## 📖 Project Overview

**Bridge**는 지역 기반의 재능 공유 플랫폼입니다.
누군가에게는 사소한 도움이, 다른 누군가에게는 큰 가치가 됩니다.
이웃과 연결되어 신뢰를 쌓고, 서로의 시간을 가치 있게 교환하세요.

### Core Philosophy
1.  **Time as Currency**: 모든 사람의 1시간은 평등합니다.
2.  **Trust & Safety**: 실명 인증과 매너 온도로 신뢰할 수 있는 커뮤니티를 만듭니다.
3.  **Hyper-Local**: 내가 사는 동네의 이웃들과 연결됩니다.

---

## ✨ Key Features

### 1. **Smart Feed (게시글)**
*   **Request & Offer**: '도움 요청'과 '재능 기부'를 명확히 구분하여 작성.
*   **Realtime Updates**: 새 글이 올라오면 새로고침 없이 즉시 피드에 반영.
*   **Filters**: 원하는 타입(Request/Offer)만 골라보기.

### 2. **Realtime Chat & Negotiation (채팅 & 거래)**
*   **1:1 Messaging**: 게시글 작성자와 즉시 대화 시작.
*   **Transaction State Machine**: 채팅방 내에서 거래 상태를 관리.
    *   `Proposed` (제안) -> `Accepted` (수락) -> `In Progress` (진행) -> `Completed` (완료)
    *   **Safety First**: DB Trigger로 엄격한 상태 전이 규칙 검증.

### 3. **Profile & Reputation (프로필)**
*   **Avatar Upload**: 갤러리 연동 및 Supabase Storage 프로필 이미지 업로드.
*   **Secure Storage**: RLS(Row Level Security)로 본인만 수정 가능한 안전한 저장소.

---

## 🛠 Tech Stack & Architecture

### **Frontend (Flutter)**
*   **State Management**: `flutter_riverpod` (Notifier & AsyncNotifier)
*   **Navigation**: `go_router` (Deep Link support)
*   **Architecture**: **Clean Architecture** (Presentation - Domain - Data)
    *   **Domain Layer**: Pure Dart, Business Rules, TDD Focus.
    *   **Data Layer**: Repository Implementation, DTOs.
    *   **Presentation Layer**: UI Logic, State Consumption.
*   **Code Generation**: `freezed`, `json_serializable`

### **Backend (Supabase)**
*   **Database**: PostgreSQL (Relational Data Models)
*   **Realtime**: Postgres Changes (Live Chat & Feed)
*   **Storage**: Image Buckets with Policies
*   **Edge Functions / Triggers**:
    *   `handle_new_user`: 회원가입 시 프로필 자동 생성
    *   `validate_transaction_status`: 거래 상태 무결성 보장

---

## 🚀 Getting Started

### Prerequisites
*   Flutter SDK (^3.5.0)
*   Supabase Account

### Setup

1.  **Clone the repository**
    ```bash
    git clone https://github.com/your-username/bridge.git
    cd bridge
    ```

2.  **Install dependencies**
    ```bash
    flutter pub get
    ```

3.  **Supabase Setup**
    *   Create a new project in Supabase.
    *   Run SQL scripts from `supabase/` directory to create tables and triggers.
    *   Create `lib/supabase_config.dart` (ignored in git):
        ```dart
        const supabaseUrl = 'YOUR_SUPABASE_URL';
        const supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
        ```

4.  **Run the app**
    ```bash
    flutter run
    ```

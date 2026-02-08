# 🌉 Tech Spec: Bridge (Architecture & Schema)

## 🏗️ 1. Domain Entities (Core Business Objects)

### 👤 User (사용자)
*   **ID**: `String` (UUID via Supabase Auth)
*   **Properties**:
    *   `email`: String
    *   `nickname`: String
    *   `avatarUrl`: String?
    *   `introduction`: String? (자기소개)
    *   `location`: Location? (GeoJSON - 구현 복잡도에 따라 String으로 단순화 가능)
    *   `mannerTemperature`: Double (36.5 start)
    *   `createdAt`: DateTime

### 📝 Post (게시글 - 요청/제안)
*   **ID**: `String` (UUID)
*   **Types**: `Request` (도움 요청), `Offer` (재능 제공)
*   **Properties**:
    *   `authorId`: String (User ID)
    *   `title`: String
    *   `content`: String
    *   `category`: String (e.g., 'Moving', 'Edu', 'Repair')
    *   `price`: Int (0이면 무료 나눔/봉사, 그 외는 'Time Credit' 또는 현금)
    *   `status`: PostStatus (Open, Reserved, Closed)
    *   `createdAt`: DateTime

### 💬 ChatRoom (채팅방)
*   **ID**: `String` (UUID)
*   **Properties**:
    *   `postId`: String? (어떤 게시글을 통한 채팅인지)
    *   `participants`: List<String> (User IDs)
    *   `lastMessage`: String?
    *   `lastMessageAt`: DateTime?
    *   `unreadCounts`: Map<String, Int>

### ✉️ Message (메시지)
*   **ID**: `String` (UUID)
*   **Properties**:
    *   `roomId`: String
    *   `senderId`: String
    *   `content`: String
    *   `type`: MessageType (Text, Image, System - 거래 상태 알림 등)
    *   `createdAt`: DateTime
    *   `isRead`: Boolean

---

## 💾 2. Database Schema (Supabase)

### `profiles` (Public Profile)
Supabase Auth의 `users` 테이블과 1:1 매핑. Trigger로 자동 생성.
```sql
create table profiles (
  id uuid references auth.users not null primary key,
  nickname text,
  avatar_url text,
  manner_temp float default 36.5,
  created_at timestamptz default now()
);
```

### `posts`
```sql
create table posts (
  id uuid default uuid_generate_v4() primary key,
  author_id uuid references profiles(id) not null,
  title text not null,
  content text,
  type text check (type in ('request', 'offer')),
  status text default 'open',
  created_at timestamptz default now()
);
```

### `chat_rooms`
```sql
create table chat_rooms (
  id uuid default uuid_generate_v4() primary key,
  post_id uuid references posts(id),
  created_at timestamptz default now()
);
```

### `room_participants` (Many-to-Many for Rooms <-> Users)
채팅방 참여자 관리.
```sql
create table room_participants (
  room_id uuid references chat_rooms(id),
  user_id uuid references profiles(id),
  primary key (room_id, user_id)
);
```

### `messages`
```sql
create table messages (
  id uuid default uuid_generate_v4() primary key,
  room_id uuid references chat_rooms(id) not null,
  sender_id uuid references profiles(id) not null,
  content text not null,
  created_at timestamptz default now()
);
```

---

## 🔐 3. Security (RLS Policies) - *Concept First!*
> **RLS (Row Level Security)**란?
> DB 레벨에서 "누가 이 데이터를 볼 수 있는가?"를 검사하는 문지기입니다.
> 서버 코드에서 `if (user.id == post.authorId)` 하는 실수를 원천 차단합니다.

*   `profiles`: `SELECT` (All), `UPDATE` (Self only).
*   `posts`: `SELECT` (All), `INSERT/UPDATE` (Authenticated User).
*   `chat_rooms`: `SELECT` (내가 `room_participants`에 포함된 방만).
*   `messages`: `SELECT` (내가 참여한 방의 메시지만), `INSERT` (내가 참여한 방에만).

---

## 🧪 4. Testing Strategy
*   **Entities**: 순수 Dart 객체이므로 Unit Test 100% 커버.
*   **Repositories**: Supabase Mocking을 통해 Edge Case(네트워크 에러 등) 테스트.
*   **UI**: Widget Test로 렌더링 검증, Integration Test로 전체 흐름(가입 -> 글쓰기 -> 채팅) 검증.

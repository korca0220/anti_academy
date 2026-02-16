```markdown
# 🌉 Tech Spec: Bridge (Architecture & Schema)

## 🏗️ 1. Domain Entities (Core Business Objects)

### 👤 User (사용자)

- **ID**: `String` (UUID via Supabase Auth)
- **Properties**:
  - `email`: String
  - `nickname`: String
  - `avatarUrl`: String?
  - `introduction`: String?
  - `location`: Location? (GeoJSON - 구현 복잡도에 따라 String 가능)
  - `mannerTemperature`: Double (36.5 start)
  - `createdAt`: DateTime

### 📝 Post (게시글 - 요청/제안)

- **ID**: `String` (UUID)
- **Types**: `Request`, `Offer`
- **Properties**:
  - `authorId`: `String` (User ID)
  - `title`: `String`
  - `content`: `String`
  - `category`: `String`
  - `price`: `int` (0: 무료/봉사)
  - `status`: `PostStatus` (Open, Reserved, Completed 대체 정책)
  - `createdAt`: `DateTime`

### 💬 ChatRoom (채팅방)

- **ID**: `String` (UUID)
- **Properties**:
  - `postId`: `String?` (연동 게시글)
  - `participants`: `List<String>` (User IDs)
  - `lastMessage`: `String?`
  - `lastMessageAt`: `DateTime?`
  - `unreadCounts`: `Map<String, Int>`

### ✉️ Message (메시지)

- **ID**: `String` (UUID)
- **Properties**:
  - `roomId`: `String`
  - `senderId`: `String`
  - `content`: `String`
  - `type`: `MessageType` (Text / Image / System)
  - `createdAt`: `DateTime`
  - `isRead`: `Boolean`

### 🤝 Transaction (거래)

- **ID**: `String` (UUID)
- **Properties**:
  - `roomId`: `String` (채팅방 1:1 거래 식별자)
  - `postId`: `String?`
  - `requesterId`: `String`
  - `providerId`: `String?`
  - `status`: `TransactionStatus` (`proposed`, `accepted`, `in_progress`, `completed`, `canceled`)
  - `updatedBy`: `String`
  - `cancelReason`: `String?`
  - `createdAt`: `DateTime`
  - `updatedAt`: `DateTime`
  - `closedAt`: `DateTime?`

## 🧪 2. Testing Strategy

- **Entities**: Freezed 값 동등성/불변성/nullable 동작 중심.
- **Transitions**: 허용 상태 전이 규칙 테스트로 비즈니스 상태 머신 검증.
- **Repositories**: 인터페이스 계약 테스트로 구현 전 API를 고정.
- **UI**: 메시지/거래 상태 반영 시나리오 위주 위젯 테스트.

## 🛢 3. Database Schema (Supabase)

### `profiles`

- auth 사용자와 1:1 매핑.
- `handle_new_user` 트리거로 가입 시 생성.

### `posts`

- `type`: `request`, `offer`
- `status`: `open`, `in_progress`, `completed`
- Realtime 공개/쓰기 정책 분리.

### `chat_rooms` / `chat_participants` / `chat_messages`

- 1:1 룸 생성 및 참여자 기반 접근 제어.

### `transactions`

- `room_id` UNIQUE 제약: 채팅방당 1개 거래
- `status` enum: `proposed`, `accepted`, `in_progress`, `completed`, `canceled`
- `updated_at` 트리거 및 전이 제약
- `posts.status` 동기화 규칙:
  - 거래 `in_progress` → 게시글 `in_progress`
  - 거래 `completed` → 게시글 `completed`
  - 거래 `proposed`/`accepted`/`canceled` → 게시글 `open` (post enum 대응)

## 🔐 4. Security (RLS Principles)

- `profiles`: select 전체, update 본인 제한.
- `posts`: read 공개, write 본인.
- `chat_*`: 참여자만 조회/생성/쓰기.
- `transactions`: 참여자만 조회/갱신, 요청자만 생성(요건별로 정책 조정).

## 🧩 5. Repository Contracts (Domain)

- `TransactionRepository`
  - `Future<Transaction?> getByRoomId(String roomId)`
  - `Stream<Transaction?> watchByRoomId(String roomId)`
  - `Future<void> upsert(Transaction transaction)`
  - `Future<void> updateStatus({required String roomId, required TransactionStatus status, required String actorId, String? cancelReason})`
```

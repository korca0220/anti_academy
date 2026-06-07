import '../entities/chat_message.dart';
import '../entities/chat_room.dart';

abstract interface class ChatRepository {
  /// 내 채팅방 목록을 가져옵니다.
  Future<List<ChatRoom>> getChatRooms();

  /// 특정 채팅방의 메시지 스트림을 가져옵니다.
  /// (Realtime 기능을 위해 Stream으로 반환)
  Stream<List<ChatMessage>> getMessages(String roomId);

  /// 메시지를 전송합니다.
  Future<void> sendMessage(String roomId, String content);

  /// 게시글 컨텍스트 기준으로 상대방과의 채팅방을 생성하거나 기존 방을 가져옵니다.
  /// (RPC 함수 create_or_get_chat_room 사용)
  Future<String> createOrGetChatRoom({
    required String otherUserId,
    required String postId,
  });
}

import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../profile/domain/entities/profile.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/chat_room.dart';
import '../../domain/repositories/chat_repository.dart';

class SupabaseChatRepository implements ChatRepository {
  SupabaseChatRepository(this._supabase);

  final SupabaseClient _supabase;

  @override
  Future<List<ChatRoom>> getChatRooms() async {
    final myUserId = _supabase.auth.currentUser?.id ?? '';
    if (myUserId.isEmpty) return [];

    try {
      // 1. 내가 속한 방 ID 찾기
      final myRoomsResponse = await _supabase.from('chat_participants').select('room_id').eq('user_id', myUserId);

      final myRoomIds = List<String>.from(myRoomsResponse.map((e) => e['room_id']));

      if (myRoomIds.isEmpty) return [];

      // 2. 방 정보 + 참여자 + 프로필 가져오기
      // .in_ 대신 .filter 사용
      final data = await _supabase
          .from('chat_rooms')
          .select('*, chat_participants(*, profiles(*))')
          .filter('id', 'in', myRoomIds)
          .order('created_at', ascending: false);

      // 3. 매핑 (ChatRoom + List<Profile>)
      return (data as List).map((e) {
        final participantsData = e['chat_participants'] as List<dynamic>;

        final profiles = participantsData
            .map((p) => p['profiles']) // profiles 객체 추출
            .where((p) => p != null) // null 체크
            .map((p) => Profile.fromJson(p as Map<String, dynamic>))
            .toList();

        // ChatRoom 생성 (fromJson 사용 후 participants 교체 or copyWith)
        // copyWith가 없거나 participants가 생성자에 포함되어 있다면:
        return ChatRoom.fromJson(e).copyWith(participants: profiles);
      }).toList();
    } catch (e) {
      log('Failed to get chat rooms: $e');

      return [];
    }
  }

  @override
  Stream<List<ChatMessage>> getMessages(String roomId) {
    // TODO: Implement getMessages
    // 1. Use _supabase.from('chat_messages').stream(primaryKey: ['id'])
    // 2. Filter .eq('room_id', roomId)
    // 3. Order by created_at
    // 4. Map to List<ChatMessage>
    try {
      final response = _supabase
          .from('chat_messages')
          .stream(primaryKey: ['id'])
          .eq('room_id', roomId)
          .order('created_at', ascending: true)
          .map(
            (event) => event
                .map(
                  (e) => ChatMessage.fromJson(e),
                )
                .toList(),
          );

      return response;
    } catch (e) {
      log('Failed to get chat messages: $e');

      throw Exception('Failed to get chat messages: $e');
    }
  }

  @override
  Future<void> sendMessage(String roomId, String content) async {
    // TODO: Implement sendMessage
    // 1. Insert into 'chat_messages'
    //    (sender_id is handled by RLS/Trigger or must be sent explicitly depends on policy)
    //    Better to send 'sender_id': _supabase.auth.currentUser!.id

    try {
      final myUserId = _supabase.auth.currentUser?.id ?? '';

      if (myUserId.isEmpty) throw Exception('User not authenticated');

      final newMessage = ChatMessage(
        id: const Uuid().v4(),
        roomId: roomId,
        senderId: myUserId,
        content: content,
        createdAt: DateTime.now(),
      );

      await _supabase.from('chat_messages').insert(newMessage.toJson());
    } catch (e) {
      log('Failed to send message: $e');

      throw Exception('Failed to send message: $e');
    }
  }

  @override
  Future<String> createOrGetChatRoom(String otherUserId) async {
    // TODO: Implement createOrGetChatRoom
    // 1. Call RPC 'create_or_get_chat_room'
    //    params: {'other_user_id': otherUserId}

    try {
      final response = await _supabase.rpc(
        'create_or_get_chat_room',
        params: {'other_user_id': otherUserId},
      );

      return response as String;
    } catch (e) {
      log('Failed to create or get chat room: $e');

      throw Exception('Failed to create or get chat room: $e');
    }
  }
}

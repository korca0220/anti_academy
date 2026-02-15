import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/entities/chat_room.dart';
import '../../domain/repositories/chat_repository.dart';
import '../entities/chat_message.dart';
import '../entities/chat_room.dart';

class SupabaseChatRepository implements ChatRepository {
  SupabaseChatRepository(this._supabase);

  final SupabaseClient _supabase;

  @override
  Future<List<ChatRoom>> getChatRooms() async {
    // TODO: Implement getChatRooms
    // 1. Query 'chat_rooms'
    // 2. You might need to join 'chat_participants' to filter only my rooms if RLS isn't enough or for UI display
    //    (But RLS 'Users can view chat rooms they are in' handles visibility)
    throw UnimplementedError();
  }

  @override
  Stream<List<ChatMessage>> getMessages(String roomId) {
    // TODO: Implement getMessages
    // 1. Use _supabase.from('chat_messages').stream(primaryKey: ['id'])
    // 2. Filter .eq('room_id', roomId)
    // 3. Order by created_at
    // 4. Map to List<ChatMessage>
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage(String roomId, String content) async {
    // TODO: Implement sendMessage
    // 1. Insert into 'chat_messages'
    //    (sender_id is handled by RLS/Trigger or must be sent explicitly depends on policy)
    //    Better to send 'sender_id': _supabase.auth.currentUser!.id
    throw UnimplementedError();
  }

  @override
  Future<String> createOrGetChatRoom(String otherUserId) async {
    // TODO: Implement createOrGetChatRoom
    // 1. Call RPC 'create_or_get_chat_room'
    //    params: {'other_user_id': otherUserId}
    throw UnimplementedError();
  }
}

import 'package:bridge/core/di/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/supabase_chat_repository.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/chat_room.dart';
import '../../domain/repositories/chat_repository.dart';

// Repository Provider
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return SupabaseChatRepository(supabase);
});

// Chat Rooms Future Provider
final chatRoomsFutureProvider = FutureProvider<List<ChatRoom>>((ref) async {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getChatRooms();
});

// Chat Messages Stream Provider (Family by Room ID)
final chatMessagesStreamProvider =
    StreamProvider.autoDispose.family<List<ChatMessage>, String>((ref, roomId) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getMessages(roomId);
});

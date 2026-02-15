import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/chat_room.dart';
import '../providers/chat_providers.dart';

class ChatRoomListScreen extends ConsumerWidget {
  const ChatRoomListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoomsAsync = ref.watch(chatRoomsFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: chatRoomsAsync.when(
        data: (rooms) {
          if (rooms.isEmpty) {
            return const Center(
              child: Text('No active chats'),
            );
          }
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              // TODO: Logic to find 'other' participant
              // For now, just show ID or first participant
              return _ChatRoomItem(room: room);
            },
          );
        },
        error: (err, stack) => Center(child: Text('Error: $err')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _ChatRoomItem extends StatelessWidget {
  const _ChatRoomItem({required this.room});

  final ChatRoom room;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(room.id), // Placeholder
      subtitle: Text('Last message placeholder'),
      onTap: () {
        // TODO: Navigate to ChatScreen
        // context.push('/chat/${room.id}');
      },
    );
  }
}

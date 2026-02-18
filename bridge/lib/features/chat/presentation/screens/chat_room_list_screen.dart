import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../app/widgets/empty_state_widget.dart';
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
            return const EmptyStateWidget(
              title: '대화가 없어요',
              subtitle: '이웃과 거래를 시작해보세요',
              iconData: Icons.chat_bubble_outline,
            );
          }
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];

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
    final myUserId = Supabase.instance.client.auth.currentUser?.id;

    // 상대방 찾기: 내 ID가 아닌 첫 번째 참가자
    final partner = room.participants.firstWhere(
      (p) => p.id != myUserId,
      orElse: () => room.participants.first, // Fallback (나와 나와의 채팅?)
    );

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: partner.avatarUrl != null ? NetworkImage(partner.avatarUrl!) : null,
        child: partner.avatarUrl == null ? Text(partner.nickname[0]) : null,
      ),
      title: Text(partner.nickname),
      subtitle: Text('Last message placeholder'), // 나중에 '마지막 메시지'도 가져와야 함
      onTap: () {
        context.push('/chats/${room.id}', extra: room);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

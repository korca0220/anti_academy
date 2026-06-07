import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/entities/chat_room.dart';

class ChatRoomItem extends StatelessWidget {
  const ChatRoomItem({super.key, required this.room});

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
        backgroundImage:
            partner.avatarUrl != null ? NetworkImage(partner.avatarUrl!) : null,
        child: partner.avatarUrl == null ? Text(partner.nickname[0]) : null,
      ),
      title: Text(partner.nickname),
      subtitle: const Text('Last message placeholder'), // 나중에 '마지막 메시지'도 가져와야 함
      onTap: () {
        context.push('/chats/${room.id}', extra: room);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

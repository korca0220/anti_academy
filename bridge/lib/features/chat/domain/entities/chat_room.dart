import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../profile/domain/entities/profile.dart';

part 'chat_room.freezed.dart';
part 'chat_room.g.dart';

@freezed
class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String id,
    required DateTime createdAt,
    @Default([]) List<Profile> participants,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
}

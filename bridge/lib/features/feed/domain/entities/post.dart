import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

enum PostType {
  request,
  offer,
}

enum PostStatus {
  open,
  // ignore: constant_identifier_names
  in_progress,
  completed,
}

@freezed
class Post with _$Post {
  const factory Post({
    required String id,
    required String authorId,
    required PostType type,
    required String title,
    required String content,
    required PostStatus status,
    required List<String> imageUrls,
    required DateTime createdAt,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

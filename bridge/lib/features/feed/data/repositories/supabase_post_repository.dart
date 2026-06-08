import 'package:bridge/features/feed/domain/entities/post.dart';
import 'package:bridge/features/feed/domain/repositories/post_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePostRepository implements PostRepository {
  SupabasePostRepository({
    required SupabaseClient supabaseClient,
  }) : _supabase = supabaseClient;

  final SupabaseClient _supabase;

  @override
  Stream<List<Post>> getPosts({PostType? type}) {
    final builder = _supabase.from('posts').stream(primaryKey: ['id']);

    if (type != null) {
      return builder
          .eq('type', type.name)
          .order('created_at', ascending: false)
          .map(
            (event) => event.map(Post.fromJson).toList(),
          );
    }

    return builder.order('created_at', ascending: false).map(
          (event) => event.map(Post.fromJson).toList(),
        );
  }

  @override
  Future<void> createPost(Post post) async {
    final postJson = post.toJson()..remove('id');

    await _supabase.from('posts').insert(postJson);
  }

  @override
  Future<List<Post>> getByUserId(String userId) async {
    final result = await _supabase
        .from('posts')
        .select()
        .eq('author_id', userId)
        .order('created_at', ascending: false);

    return result.map(Post.fromJson).toList();
  }

  @override
  Future<List<Post>> search(String query) async {
    // TODO: query가 비어있으면 빈 리스트를 즉시 반환하세요.
    // TODO: Supabase 'posts' 테이블에서 title 또는 content에 query가 포함된 게시글을 조회하세요.
    // 힌트: .or('title.ilike.%$query%,content.ilike.%$query%').order('created_at', ascending: false)
    throw UnimplementedError();
  }

  @override
  Future<void> updatePost(Post post) async {
    final postJson = post.toJson()..remove('id');

    await _supabase.from('posts').update(postJson).eq('id', post.id);
  }
}

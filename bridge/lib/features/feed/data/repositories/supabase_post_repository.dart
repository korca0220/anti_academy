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
    // TODO: Implement filtering logic
    // If [type] is provided, filter by that type.
    // Otherwise, return all posts.

    // Create query
    final builder = _supabase.from('posts').stream(primaryKey: ['id']);

    if (type != null) {
      return builder.eq('type', type.name).order('created_at', ascending: false).map(
            (event) => event.map((e) => Post.fromJson(e)).toList(),
          );
    }

    return builder.order('created_at', ascending: false).map(
          (event) => event.map((e) => Post.fromJson(e)).toList(),
        );
  }

  @override
  Future<void> createPost(Post post) async {
    final postJson = post.toJson()..remove('id');

    await _supabase.from('posts').insert(postJson);
  }

  @override
  Future<void> updatePost(Post post) async {
    final postJson = post.toJson()..remove('id');

    await _supabase.from('posts').update(postJson).eq('id', post.id);
  }
}

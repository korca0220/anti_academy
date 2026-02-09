import 'package:bridge/features/feed/domain/entities/post.dart';
import 'package:bridge/features/feed/domain/repositories/post_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePostRepository implements PostRepository {
  SupabasePostRepository({
    required SupabaseClient supabaseClient,
  }) : _supabase = supabaseClient;

  final SupabaseClient _supabase;

  @override
  Stream<List<Post>> getPosts() {
    // TODO: Implement getPosts
    // Tip: use _supabase.from('posts').stream(primaryKey: ['id'])
    // Don't forget to order by created_at desc

    final posts = _supabase.from('posts').stream(primaryKey: ['id']).order('created_at');

    final result = posts.map(
      (event) => event.map((e) {
        return Post.fromJson(e);
      }).toList(),
    );

    return result;
  }

  @override
  Future<void> createPost(Post post) async {
    // TODO: Implement createPost
    // Tip: use _supabase.from('posts').insert(post.toJson())
    final result = await _supabase.from('posts').insert(post.toJson()..remove('id'));

    if (result.error != null) {
      throw Exception(result.error?.message);
    }
  }

  @override
  Future<void> updatePost(Post post) async {
    final result = await _supabase.from('posts').update(post.toJson()..remove('id')).eq('id', post.id);

    if (result.error != null) {
      throw Exception(result.error?.message);
    }
  }
}

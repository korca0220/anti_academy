import 'package:bridge/features/feed/domain/entities/post.dart';

abstract class PostRepository {
  Stream<List<Post>> getPosts({PostType? type});
  Future<void> createPost(Post post);
  Future<void> updatePost(Post post);
  Future<List<Post>> getByUserId(String userId);
  Future<List<Post>> search(String query);
}

import 'package:bridge/features/feed/domain/entities/post.dart';

abstract class PostRepository {
  // TODO: Define methods
  // 1. Fetch posts (Stream or Future?)
  // 2. Create post
  // 3. Update status (optional for now)

  Stream<List<Post>> getPosts({PostType? type});
  Future<void> createPost(Post post);
  Future<void> updatePost(Post post);
}

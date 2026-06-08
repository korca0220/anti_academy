import 'package:bridge/core/di/dependency_injection.dart';
import 'package:bridge/features/feed/data/repositories/supabase_post_repository.dart';
import 'package:bridge/features/feed/domain/repositories/post_repository.dart';
import 'package:bridge/features/feed/presentation/providers/feed_filter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/post.dart';

part 'post_providers.g.dart';

// 1. Repository Provider
final postRepositoryProvider = Provider<PostRepository>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return SupabasePostRepository(supabaseClient: supabase);
});

// 2. Feed Stream Provider (UI에서 구독할 것)
final postsStreamProvider = StreamProvider.autoDispose<List<Post>>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  final filter = ref.watch(feedFilterProvider);

  return repository.getPosts(type: filter.toPostType);
});

// TODO: searchPostsProvider를 구현하세요.
// query가 비어있으면 빈 리스트를 반환하고, 아니면 repository.search(query)를 호출하세요.
@riverpod
Future<List<Post>> searchPosts(Ref ref, String query) async {
  throw UnimplementedError();
}

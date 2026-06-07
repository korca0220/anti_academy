import 'package:bridge/core/di/dependency_injection.dart';
import 'package:bridge/features/feed/data/repositories/supabase_post_repository.dart';
import 'package:bridge/features/feed/domain/repositories/post_repository.dart';
import 'package:bridge/features/feed/presentation/providers/feed_filter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
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

@riverpod
Future<List<Post>> myPosts(Ref ref) async {
  final userId = ref.watch(currentUserIdProvider);

  if (userId == null) {
    return [];
  }

  return ref.watch(postRepositoryProvider).getByUserId(userId);
}

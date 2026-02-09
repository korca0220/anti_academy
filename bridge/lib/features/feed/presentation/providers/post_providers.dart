import 'package:bridge/core/di/dependency_injection.dart';
import 'package:bridge/features/feed/data/repositories/supabase_post_repository.dart';
import 'package:bridge/features/feed/domain/entities/post.dart';
import 'package:bridge/features/feed/domain/repositories/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Repository Provider
final postRepositoryProvider = Provider<PostRepository>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return SupabasePostRepository(supabaseClient: supabase);
});

// 2. Feed Stream Provider (UI에서 구독할 것)
final postsStreamProvider = StreamProvider.autoDispose<List<Post>>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return repository.getPosts();
});

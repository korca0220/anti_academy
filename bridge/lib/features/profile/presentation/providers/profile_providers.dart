import 'package:bridge/core/di/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/supabase_profile_repository.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';

// 1. Repository Provider
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return SupabaseProfileRepository(supabaseClient: supabase);
});

// 2. Profile Future Provider (Family)
// UI에서 ref.watch(profileFutureProvider(userId))로 쉽게 사용 가능
final profileFutureProvider = FutureProvider.family<Profile?, String>((ref, userId) async {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.getProfile(userId);
});

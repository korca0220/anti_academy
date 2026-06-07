import 'package:bridge/core/di/dependency_injection.dart';
import 'package:bridge/features/auth/data/repositories/supabase_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final supabase = ref.watch(supabaseClientProvider);

  return SupabaseAuthRepository(supabaseClient: supabase);
});

final authStateChangesProvider = StreamProvider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});

final currentUserIdProvider = Provider<String?>((ref) {
  // auth state stream을 watch해 로그인/로그아웃/계정 전환 시 재계산되도록 합니다.
  ref.watch(authStateChangesProvider);
  final supabase = ref.watch(supabaseClientProvider);

  return supabase.auth.currentUser?.id;
});

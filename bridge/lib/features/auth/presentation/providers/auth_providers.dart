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
  final supabase = ref.watch(supabaseClientProvider);

  return supabase.auth.currentUser?.id;
});

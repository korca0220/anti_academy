import 'package:bridge/features/auth/domain/entities/user.dart' as entity;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository({
    required SupabaseClient supabaseClient,
  }) : _supabase = supabaseClient;

  final SupabaseClient _supabase;

  @override
  Future<entity.User?> get currentUser async {
    final user = _supabase.auth.currentUser;

    if (user == null) return null;

    return _mapSupabaseUserToEntity(user);
  }

  @override
  Stream<entity.User?> get authStateChanges {
    return _supabase.auth.onAuthStateChange.map((event) {
      final user = event.session?.user;
      if (user == null) return null;

      return _mapSupabaseUserToEntity(user);
    });
  }

  @override
  Future<void> signInWithEmail({required String email, required String password}) async {
    await _supabase.auth.signInWithPassword(
      password: password,
      email: email,
    );
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String nickname,
  }) async {
    await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'nickname': nickname,
      },
    );
  }

  entity.User _mapSupabaseUserToEntity(User user) {
    return entity.User(
      id: user.id,
      email: user.email ?? '',
      nickname: user.userMetadata?['nickname'] ?? 'User',
      createdAt: DateTime.parse(user.createdAt),
    );
  }
}

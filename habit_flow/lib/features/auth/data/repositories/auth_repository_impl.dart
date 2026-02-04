import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../../../core/error/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final supabase.SupabaseClient _supabaseClient;

  AuthRepositoryImpl(this._supabaseClient);

  @override
  Future<Either<Failure, User>> signIn({required String email, required String password}) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        return left(const AuthFailure('User not found after sign in'));
      }

      return right(User(id: user.id, email: user.email ?? ''));
    } on supabase.AuthException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({required String email, required String password}) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        return left(const AuthFailure('User not found after sign up'));
      }

      return right(User(id: user.id, email: user.email ?? ''));
    } on supabase.AuthException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
      return right(null);
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Option<User>> getCurrentUser() async {
    final user = _supabaseClient.auth.currentUser;
    if (user != null) {
      return some(User(id: user.id, email: user.email ?? ''));
    }
    return none();
  }

  @override
  Stream<User?> get authStateChanges {
    return _supabaseClient.auth.onAuthStateChange.map((event) {
      final user = event.session?.user;
      if (user != null) {
        return User(id: user.id, email: user.email ?? '');
      }
      return null;
    });
  }
}

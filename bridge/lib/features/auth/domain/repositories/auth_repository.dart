import 'package:bridge/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User?> get currentUser;
  Stream<User?> get authStateChanges;
  Future<void> signInWithEmail({required String email, required String password});
  Future<void> signUpWithEmail({required String email, required String password, required String nickname});
  Future<void> signOut();
}

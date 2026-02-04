import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signIn({required String email, required String password});
  Future<Either<Failure, User>> signUp({required String email, required String password});
  Future<Either<Failure, void>> signOut();
  Future<Option<User>> getCurrentUser();
  Stream<User?> get authStateChanges;
}

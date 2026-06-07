import 'dart:async';

import 'package:bridge/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpControllerProvider =
    AsyncNotifierProvider.autoDispose<SignUpController, void>(
  () => SignUpController(),
);

class SignUpController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String nickname,
  }) async {
    state = AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signUpWithEmail(
            email: email,
            password: password,
            nickname: nickname,
          );
    });
  }
}

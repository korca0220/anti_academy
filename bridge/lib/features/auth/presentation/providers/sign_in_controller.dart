import 'dart:async';

import 'package:bridge/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInControllerProvider = AsyncNotifierProvider.autoDispose<SignInController, void>(
  () => SignInController(),
);

// 1. AsyncNotifier를 사용하여 로딩/에러/성공 상태를 관리합니다.
// <void>는 "성공했을 때 특별한 데이터가 필요 없음"을 의미합니다.
class SignInController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // 초기 상태는 아무것도 아님 (Idle)
    return null;
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    // 2. 로딩 상태로 변경
    state = const AsyncValue.loading();

    // 3. 비동기 작업 실행 (Repository 호출)
    // guard는 try-catch를 내장하여 에러 발생 시 자동으로 state를 error로 만듭니다.
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signInWithEmail(
            email: email,
            password: password,
          );
    });
  }
}

// 프로바이더 정의

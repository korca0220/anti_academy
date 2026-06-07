import 'dart:async';

import 'package:bridge/features/feed/domain/entities/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'post_providers.dart';

// AsyncNotifier를 사용하여 로딩/에러/성공 상태를 관리하는 Controller입니다.
class CreatePostController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // 초기 상태: 아무것도 안 함 (null / Idle)
    return null;
  }

  /// 게시글 생성 요청
  Future<void> createPost({
    required Post post,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() {
      return ref.read(postRepositoryProvider).createPost(post);
    });
  }
}

final createPostControllerProvider =
    AsyncNotifierProvider.autoDispose<CreatePostController, void>(
  CreatePostController.new,
);

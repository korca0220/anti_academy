import 'package:bridge/features/review/data/repositories/supabase_review_repository.dart';
import 'package:bridge/features/review/domain/entities/review.dart';
import 'package:bridge/features/review/domain/repositories/review_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

part 'review_providers.g.dart';

@riverpod
ReviewRepository reviewRepository(Ref ref) {
  return SupabaseReviewRepository(supabaseClient: Supabase.instance.client);
}

// TODO: 작성/조회 상태를 관리할 AsyncNotifier 또는 Notifier provider 추가

@riverpod
class ReviewSubmitController extends _$ReviewSubmitController {
  @override
  FutureOr<void> build() => null;

  Future<void> submit({
    required String transactionId,
    required String roomId,
    required String reviewerId,
    required String revieweeId,
    required int rating,
    String? comment,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final review = Review(
        id: const Uuid().v4(),
        transactionId: transactionId,
        roomId: roomId,
        reviewerId: reviewerId,
        revieweeId: revieweeId,
        rating: rating,
        comment: comment,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await ref.read(reviewRepositoryProvider).createReview(review);
    });
  }
}

@riverpod
Future<List<Review>> reviewsByTransaction(Ref ref, String transactionId) async {
  final repo = ref.watch(reviewRepositoryProvider);

  return repo.getReviewsByTransaction(transactionId);
}

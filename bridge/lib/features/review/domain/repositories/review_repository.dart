import 'package:bridge/features/review/domain/entities/review.dart';

abstract interface class ReviewRepository {
  Future<void> createReview(Review review);

  Future<List<Review>> getReviewsByTransaction(String transactionId);

  Future<List<Review>> getReviewsByReviewee(String revieweeId);

  // TODO: 중복 리뷰 방지 체크를 DB 제약 + 사전 조회 중 어떤 방식으로 처리할지 확정
}

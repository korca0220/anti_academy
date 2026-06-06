import 'package:bridge/features/review/domain/entities/review.dart';
import 'package:bridge/features/review/domain/repositories/review_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseReviewRepository implements ReviewRepository {
  SupabaseReviewRepository(this._supabase);

  // ignore: unused_field
  final SupabaseClient _supabase;

  @override
  Future<void> createReview(Review review) async {
    // TODO: reviews insert 구현
    // 참고: reviewer_id는 auth.uid()와 일치해야 RLS 통과
    throw UnimplementedError();
  }

  @override
  Future<List<Review>> getReviewsByTransaction(String transactionId) async {
    // TODO: transaction_id 기준 조회 구현
    throw UnimplementedError();
  }

  @override
  Future<List<Review>> getReviewsByReviewee(String revieweeId) async {
    // TODO: reviewee_id 기준 조회 구현
    throw UnimplementedError();
  }
}

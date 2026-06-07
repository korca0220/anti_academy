import 'dart:developer';

import 'package:bridge/features/review/domain/entities/review.dart';
import 'package:bridge/features/review/domain/repositories/review_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseReviewRepository implements ReviewRepository {
  SupabaseReviewRepository({
    required SupabaseClient supabaseClient,
  }) : _supabase = supabaseClient;

  final SupabaseClient _supabase;

  @override
  Future<void> createReview(Review review) async {
    final reviewJson = review.toJson()..remove('id');

    await _supabase.from('reviews').insert(reviewJson);
  }

  @override
  Future<List<Review>> getReviewsByTransaction(String transactionId) async {
    try {
      final result = await _supabase
          .from('reviews')
          .select()
          .eq('transaction_id', transactionId);

      return result.map(Review.fromJson).toList();
    } catch (e) {
      log('Failed to get reviews by transaction: $e');

      throw Exception('Failed to get reviews by transaction: $e');
    }
  }

  @override
  Future<List<Review>> getReviewsByReviewee(String revieweeId) async {
    try {
      final result = await _supabase
          .from('reviews')
          .select()
          .eq('reviewee_id', revieweeId);

      return result.map(Review.fromJson).toList();
    } catch (e) {
      log('Failed to get reviews by reviewee: $e');

      throw Exception('Failed to get reviews by reviewee: $e');
    }
  }
}

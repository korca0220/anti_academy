import 'package:bridge/features/profile/domain/entities/profile.dart';
import 'package:bridge/features/profile/presentation/providers/profile_providers.dart';
import 'package:bridge/features/review/domain/entities/review.dart';
import 'package:bridge/features/review/presentation/providers/review_providers.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileViewState {
  const ProfileViewState({
    required this.profile,
    required this.receivedReviews,
  });

  final Profile? profile;
  final List<Review> receivedReviews;

  double? get averageRating {
    if (receivedReviews.isEmpty) {
      return null;
    }

    final totalRating =
        receivedReviews.fold(0, (sum, review) => sum + review.rating);

    return totalRating / receivedReviews.length;
  }

  List<Review> get recentReviews {
    return receivedReviews
        .sorted((a, b) => b.createdAt.compareTo(a.createdAt))
        .take(10)
        .toList();
  }
}

final profileViewProvider =
    FutureProvider.family<ProfileViewState, String>((ref, userId) async {
  final profileRepository = ref.watch(profileRepositoryProvider);
  final reviewRepository = ref.watch(reviewRepositoryProvider);

  final profile = await profileRepository.getProfile(userId);
  final reviews = await reviewRepository.getReviewsByReviewee(userId);

  return ProfileViewState(
    profile: profile,
    receivedReviews: reviews,
  );
});

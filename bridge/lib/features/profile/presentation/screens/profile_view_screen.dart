import 'package:bridge/features/profile/presentation/providers/profile_view_providers.dart';
import 'package:bridge/features/profile/presentation/widgets/no_reviews_yet.dart';
import 'package:bridge/features/profile/presentation/widgets/profile_header.dart';
import 'package:bridge/features/profile/presentation/widgets/profile_view_empty.dart';
import 'package:bridge/features/profile/presentation/widgets/profile_view_error.dart';
import 'package:bridge/features/profile/presentation/widgets/recent_review_item.dart';
import 'package:bridge/features/profile/presentation/widgets/reputation_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileViewScreen extends ConsumerWidget {
  const ProfileViewScreen({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileViewProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ProfileViewError(error: error),
        data: (profileView) {
          final profile = profileView.profile;

          if (profile == null) {
            return const ProfileViewEmpty();
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ProfileHeader(profile: profile),
              const SizedBox(height: 24),
              ReputationSummary(
                averageRating: profileView.averageRating,
                reviewCount: profileView.receivedReviews.length,
              ),
              const SizedBox(height: 24),
              Text(
                'Recent Reviews',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              if (profileView.receivedReviews.isEmpty)
                const NoReviewsYet()
              else
                ...profileView.recentReviews
                    .map((review) => RecentReviewItem(review: review)),
            ],
          );
        },
      ),
    );
  }
}

import 'package:bridge/app/theme/app_colors.dart';
import 'package:bridge/features/profile/presentation/providers/profile_view_providers.dart';
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
        error: (error, _) => _ProfileViewError(error: error),
        data: (profileView) {
          final profile = profileView.profile;

          if (profile == null) {
            return const _ProfileViewEmpty();
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: profile.avatarUrl != null
                        ? NetworkImage(profile.avatarUrl!)
                        : null,
                    child: profile.avatarUrl == null
                        ? const Icon(Icons.person, size: 32)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.nickname,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          profile.bio ?? 'No bio yet',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _ReputationSummary(
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
                const _NoReviewsYet()
              else
                const _RecentReviewsPlaceholder(),
            ],
          );
        },
      ),
    );
  }
}

class _ReputationSummary extends StatelessWidget {
  const _ReputationSummary({
    required this.averageRating,
    required this.reviewCount,
  });

  final double? averageRating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.star, color: AppColors.accent),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                averageRating == null
                    ? 'Reputation not ready yet'
                    : 'TODO: show formatted rating',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text('$reviewCount reviews'),
          ],
        ),
      ),
    );
  }
}

class _NoReviewsYet extends StatelessWidget {
  const _NoReviewsYet();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(child: Text('No reviews yet')),
    );
  }
}

class _RecentReviewsPlaceholder extends StatelessWidget {
  const _RecentReviewsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text('TODO: render recent review items'),
      ),
    );
  }
}

class _ProfileViewEmpty extends StatelessWidget {
  const _ProfileViewEmpty();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile not found'));
  }
}

class _ProfileViewError extends StatelessWidget {
  const _ProfileViewError({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Error: $error'));
  }
}

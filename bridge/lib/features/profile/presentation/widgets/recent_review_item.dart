import 'package:bridge/app/theme/app_colors.dart';
import 'package:bridge/features/review/domain/entities/review.dart';
import 'package:flutter/material.dart';

class RecentReviewItem extends StatelessWidget {
  const RecentReviewItem({
    super.key,
    required this.review,
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${review.rating} / 5.0',
              style: Theme.of(context).textTheme.titleMedium),
          Text(review.comment ?? 'No comment',
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

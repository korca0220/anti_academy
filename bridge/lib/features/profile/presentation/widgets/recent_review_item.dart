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
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Text('${review.rating} / 5.0'),
          Text(review.comment ?? 'No comment'),
        ],
      ),
    );
  }
}

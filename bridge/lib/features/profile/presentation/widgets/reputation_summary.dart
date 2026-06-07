import 'package:bridge/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ReputationSummary extends StatelessWidget {
  const ReputationSummary({
    super.key,
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
                    ? '리뷰가 아직 없습니다'
                    : '${averageRating!.toStringAsFixed(1)} / 5.0',
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

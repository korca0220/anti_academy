import 'package:flutter/material.dart';

import 'circular_progress_painter.dart';

class HabitProgressCard extends StatelessWidget {
  const HabitProgressCard({
    super.key,
    required this.totalHabits,
    required this.completedHabits,
  });

  final int totalHabits;
  final int completedHabits;

  @override
  Widget build(BuildContext context) {
    // Avoid division by zero
    final percentage = totalHabits == 0 ? 0.0 : completedHabits / totalHabits;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Text Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Progress',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$completedHabits / $totalHabits Habits',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
          // Circular Chart using CustomPainter
          SizedBox(
            width: 80,
            height: 80,
            child: CustomPaint(
              painter: CircularProgressPainter(
                percentage: percentage,
                backgroundColor: Colors.grey[200]!,
                progressColor: Theme.of(context).primaryColor,
                strokeWidth: 8,
              ),
              child: Center(
                child: Text(
                  '${(percentage * 100).toInt()}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

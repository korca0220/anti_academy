import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_flow/features/habit/presentation/widgets/scale_button.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({
    super.key,
    required this.id,
    required this.title,
    this.isHeroEnabled = true,
  });

  final String id;
  final String title;
  final bool isHeroEnabled;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onPressed: () {
        context.push('/habit/$id', extra: title);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (isHeroEnabled) ...{
                Hero(
                  tag: 'habit_title_$id',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(title),
                  ),
                ),
              } else
                Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

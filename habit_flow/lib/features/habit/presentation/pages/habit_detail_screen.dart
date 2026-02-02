import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HabitDetailScreen extends ConsumerWidget {
  const HabitDetailScreen({
    super.key,
    required this.habitId,
    required this.habitTitle,
  });

  final String habitId;
  final String habitTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: Wrap this Text with a Hero widget
            // The tag MUST match the tag used in HabitCard (e.g., 'habit_title_$habitId')
            Hero(
              tag: 'habit_title_$habitId',
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  habitTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Statistic & Charts will be here'),
          ],
        ),
      ),
    );
  }
}

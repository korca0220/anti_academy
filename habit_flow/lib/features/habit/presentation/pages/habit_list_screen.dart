import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/habit_list.dart';

class HabitListScreen extends ConsumerWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => TextField(
              decoration: const InputDecoration(
                hintText: 'Add a new habit',
              ),
              onSubmitted: (value) async {
                await ref.read(habitListProvider.notifier).addHabit(value);

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          );
        },
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final habits = ref.watch(habitListProvider);

          return habits.when(
            loading: () => const CircularProgressIndicator(),
            error: (err, stackTrace) => Text(err.toString()),
            data: (habits) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final habit = habits[index];

                  return ListTile(
                    title: Text(habit.title),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

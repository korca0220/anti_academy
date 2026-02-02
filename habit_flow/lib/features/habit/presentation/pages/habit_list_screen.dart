import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_flow/features/habit/presentation/widgets/habit_card.dart';

import '../riverpod/habit_list.dart';

class HabitListScreen extends ConsumerWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.push('/add');
        },
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final habits = ref.watch(habitListProvider);

          return habits.when(
            loading: () => const CircularProgressIndicator(),
            error: (err, stackTrace) => Text(err.toString()),
            data: (habits) {
              return ListView.separated(
                itemCount: habits.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final habit = habits[index];

                  return HabitCard(id: habit.id, title: habit.title);
                },
              );
            },
          );
        },
      ),
    );
  }
}

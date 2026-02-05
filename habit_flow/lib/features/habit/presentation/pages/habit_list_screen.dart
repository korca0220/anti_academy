import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_flow/features/habit/presentation/widgets/habit_card.dart';

import '../../../../core/theme/theme_provider.dart';
import '../riverpod/habit_list.dart';
import '../widgets/habit_progress_card.dart';

class HabitListScreen extends ConsumerWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // TODO: 6. AppBar를 추가하고, actions에 테마 토글 버튼(IconButton)을 추가하세요.
      // 아이콘: light일 땐 dark_mode, dark일 땐 light_mode
      // 동작: ref.read(themeNotifierProvider.notifier).toggleTheme()
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => ref.read(themeNotifierProvider.notifier).toggleTheme(),
            icon: ref.watch(themeNotifierProvider) == ThemeMode.dark
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.push('/add');
        },
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final habits = ref.watch(habitListProvider);

            return habits.when(
              loading: () => const CircularProgressIndicator(),
              error: (err, stackTrace) => Text(err.toString()),
              data: (habits) {
                final totalHabits = habits.length;
                final completedHabits = habits.where((habit) => habit.isCompleted).length;

                return ReorderableListView.builder(
                  header: Padding(
                    padding: const EdgeInsets.all(16),
                    child: HabitProgressCard(
                      totalHabits: totalHabits,
                      completedHabits: completedHabits,
                    ),
                  ),
                  onReorder: (oldIndex, newIndex) {
                    ref.read(habitListProvider.notifier).reorder(oldIndex, newIndex);
                  },
                  proxyDecorator: (child, index, animation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return HabitCard(
                          id: habits[index].id,
                          title: habits[index].title,
                          isCompleted: habits[index].isCompleted,
                          isHeroEnabled: false,
                        );
                      },
                    );
                  },
                  itemCount: habits.length,
                  itemBuilder: (context, index) {
                    final habit = habits[index];

                    return HabitCard(
                      key: ValueKey(habit.id),
                      id: habit.id,
                      title: habit.title,
                      isCompleted: habit.isCompleted,
                      onToggle: (id) {
                        ref.read(habitListProvider.notifier).toggleHabit(id);
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

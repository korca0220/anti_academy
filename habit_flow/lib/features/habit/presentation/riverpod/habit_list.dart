import 'package:habit_flow/features/habit/domain/usecases/add_habit_usecase.dart';
import 'package:habit_flow/features/habit/domain/usecases/get_habits_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/habit.dart';
import 'habit_providers.dart';

part 'habit_list.g.dart';

// TODO: Define the Providers for UseCases here temporarily so we can use them
// In a real app, these might come from a dependency injection container or a separate provider file.
// For now, assume you can access them via ref.watch if they were providers,
// OR just instantiate them manually for this exercise since we don't have the Data Layer yet.

@riverpod
class HabitList extends _$HabitList {
  @override
  FutureOr<List<Habit>> build() async {
    /// 의존하는 값이 바뀌면 다시 실행된다. (watch)

    final repository = ref.watch(habitRepositoryProvider);
    final useCase = GetHabitsUseCase(repository);

    final result = await useCase.execute();

    return result.fold((failure) => throw failure, (habits) => habits);
  }

  Future<void> addHabit(String title) async {
    state = const AsyncValue.loading();

    /// 일회성 호출 (read)
    final repository = ref.read(habitRepositoryProvider);
    final useCase = AddHabitUseCase(repository);

    final result = await useCase.execute(title);

    result.fold((failure) => state = AsyncValue.error(failure, StackTrace.current), (habit) {
      // Optimistic update or refetch
      // Here we just append to the current state for efficiency
      final previousState = state.valueOrNull ?? [];
      state = AsyncValue.data([...previousState, habit]);
    });
  }
}

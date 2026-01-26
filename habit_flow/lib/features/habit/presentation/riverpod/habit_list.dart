import 'package:fpdart/src/either.dart';
import 'package:habit_flow/core/error/failure.dart';
import 'package:habit_flow/features/habit/domain/usecases/add_habit_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/habit.dart';
import '../../domain/repositories/habit_repository.dart';

part 'habit_list.g.dart';

// TODO: Define the Providers for UseCases here temporarily so we can use them
// In a real app, these might come from a dependency injection container or a separate provider file.
// For now, assume you can access them via ref.watch if they were providers,
// OR just instantiate them manually for this exercise since we don't have the Data Layer yet.

@riverpod
class HabitList extends _$HabitList {
  @override
  FutureOr<List<Habit>> build() async {
    // TODO: 1. Instantiate GetHabitsUseCase (You will need a Repository, but for now functionality is not waiting on Data Layer)
    // Wait... We need a Repository implementation to run this.
    // For this Step, just return an empty list or throw UnimplementedError.
    // We will hook up the implementation in Phase 4.

    // Ideally:
    // final useCase = ref.watch(getHabitsUseCaseProvider);
    // final result = await useCase.execute();
    // return result.fold(
    //   (failure) => throw failure,
    //   (habits) => habits,
    // );

    return []; // Placeholder
  }

  Future<void> addHabit(String title) async {
    // TODO: 2. Implement addHabit logic
    // 1. Set state to loading: state = const AsyncValue.loading();
    // 2. Instantiate AddHabitUseCase (again, assuming we have it)
    // 3. Call execute(title)
    // 4. If success, refresh the list or add the item to current state manually
    // 5. If failure, set state to error

    state = const AsyncValue.loading();

    final useCase = AddHabitUseCase(FakeHabitRepository());

    final result = await useCase.execute(title);

    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (habit) => state = AsyncValue.data([...state.valueOrNull ?? [], habit]),
    );
  }
}

final class FakeHabitRepository implements HabitRepository {
  @override
  Future<Either<Failure, Habit>> addHabit(Habit habit) {
    // TODO: implement addHabit
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteHabit(String id) {
    // TODO: implement deleteHabit
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Habit>>> getHabits() {
    // TODO: implement getHabits
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Habit>> updateHabit(Habit habit) {
    // TODO: implement updateHabit
    throw UnimplementedError();
  }
}

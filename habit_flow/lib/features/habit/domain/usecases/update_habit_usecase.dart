import 'package:fpdart/fpdart.dart';
import 'package:habit_flow/core/error/failure.dart';

import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

class UpdateHabitUseCase {
  final HabitRepository _repository;

  UpdateHabitUseCase(this._repository);

  Future<Either<Failure, Habit>> execute(Habit habit) {
    return _repository.updateHabit(habit);
  }
}

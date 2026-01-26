import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

class GetHabitsUseCase {
  final HabitRepository _repository;

  GetHabitsUseCase(this._repository);

  Future<Either<Failure, List<Habit>>> execute() {
    return _repository.getHabits();
  }
}

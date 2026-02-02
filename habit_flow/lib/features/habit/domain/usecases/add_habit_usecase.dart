import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';
import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

class AddHabitUseCase {
  AddHabitUseCase(this._repository);

  final HabitRepository _repository;

  Future<Either<Failure, Habit>> execute(String title) async {
    if (title.isEmpty) return left(const ValidationFailure('Title cannot be empty'));

    final habit = Habit(
      id: const Uuid().v4(),
      title: title,
      createdAt: DateTime.now(),
      isCompleted: false,
    );

    return _repository.addHabit(habit);
  }
}

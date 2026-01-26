import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';
import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

class AddHabitUseCase {
  AddHabitUseCase(this._repository);

  final HabitRepository _repository;

  Future<Either<Failure, Habit>> execute(String title) async {
    // TODO: 1. Validate that the title is not empty. If empty, return Left(ValidationFailure('Title cannot be empty')).
    if (title.isEmpty) return left(const ValidationFailure('Title cannot be empty'));

    // TODO: 2. Create a specific Habit object.
    // - id: use Uuid().v4()
    // - title: the validated title
    // - createdAt: DateTime.now()
    // - isCompleted: false

    final habit = Habit(
      id: const Uuid().v4(),
      title: title,
      createdAt: DateTime.now(),
      isCompleted: false,
    );

    return _repository.addHabit(habit);
  }
}

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/habit.dart';

abstract interface class HabitRepository {
  Future<Either<Failure, List<Habit>>> getHabits();
  Future<Either<Failure, Habit>> addHabit(Habit habit);
  Future<Either<Failure, Habit>> updateHabit(Habit habit);
  Future<Either<Failure, void>> updateHabitOrder(List<Habit> habits);
  Future<Either<Failure, void>> deleteHabit(String id);
}

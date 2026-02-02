import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/habit.dart';
import '../../domain/repositories/habit_repository.dart';
import '../datasources/habit_local_datasource.dart';
import '../models/habit_model.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDataSource _localDataSource;

  HabitRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, Habit>> addHabit(Habit habit) async {
    try {
      final habitModel = HabitModel.fromEntity(habit);

      await _localDataSource.cacheHabit(habitModel);

      return right(habit);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHabit(String id) async {
    try {
      await _localDataSource.deleteHabit(id);

      return right(null);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Habit>>> getHabits() async {
    try {
      final habits = await _localDataSource.getHabits();

      final habits$Entity = habits.map((e) => e.toEntity()).toList();

      // Sort by orderIndex
      habits$Entity.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

      return right(habits$Entity);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Habit>> updateHabit(Habit habit) async {
    final habitModel = HabitModel.fromEntity(habit);

    try {
      await _localDataSource.cacheHabit(habitModel);

      return right(habit);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateHabitOrder(List<Habit> habits) async {
    try {
      for (final habit in habits) {
        final habitModel = HabitModel.fromEntity(habit);

        await _localDataSource.cacheHabit(habitModel);
      }
      return right(null);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }
}

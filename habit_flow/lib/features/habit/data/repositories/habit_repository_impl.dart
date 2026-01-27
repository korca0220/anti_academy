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
    // TODO: Implement getHabits using _localDataSource
    // 1. Call getHabits() from datasource
    // 2. Map List<HabitModel> to List<Habit> using .toEntity()
    // 3. Return Right(list)
    // 4. Wrap in try-catch to return Left(CacheFailure) on error
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Habit>> updateHabit(Habit habit) {
    // TODO: Implement updateHabit if you want
    throw UnimplementedError();
  }
}

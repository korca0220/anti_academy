import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/habit.dart';
import '../../domain/repositories/habit_repository.dart';
import '../datasources/habit_local_datasource.dart';
import '../datasources/habit_remote_datasource.dart';
import '../models/habit_model.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDataSource _localDataSource;
  final HabitRemoteDataSource _remoteDataSource;

  HabitRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<Either<Failure, Habit>> addHabit(Habit habit) async {
    try {
      final habitModel = HabitModel.fromEntity(habit);

      // 1. Local Cache (Optimistic UI)
      await _localDataSource.cacheHabit(habitModel);

      // TODO: 1. Remote 저장 (Fire and Forget or Await?)
      // 안정성을 위해 await를 사용하고, 실패 시 에러를 반환하는 것이 좋습니다.
      // 코드를 작성해서 _remoteDataSource.createHabit()을 호출하세요.

      await _remoteDataSource.createHabit(habitModel);

      return right(habit);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHabit(String id) async {
    try {
      await _localDataSource.deleteHabit(id);

      // TODO: 2. Remote 삭제
      // _remoteDataSource.deleteHabit()을 호출하세요.

      await _remoteDataSource.deleteHabit(id);

      return right(null);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Habit>>> getHabits() async {
    try {
      // TODO: 3. Sync Strategy (One way: Remote -> Local)
      // 1) Remote에서 최신 데이터를 가져온다. (_remoteDataSource.getHabits())
      // 2) 가져온 데이터를 Local에 캐싱한다. (Loop & _localDataSource.cacheHabit())
      // 3) Local에서 다시 읽어서 반환한다. (이미 구현됨)

      final remoteHabits = await _remoteDataSource.getHabits();

      await Future.wait(
        remoteHabits.map((e) => _localDataSource.cacheHabit(e)),
      );

      // 지금은 Local만 읽고 있습니다. 위 로직을 추가해보세요.
      final habits = await _localDataSource.getHabits();

      final habits$Entity = habits.map((e) => e.toEntity()).toList();

      // Sort by orderIndex
      habits$Entity.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

      return right(habits$Entity);
    } catch (e) {
      // Offline Flow: Remote 실패 시 Local 데이터라도 반환해야 합니다.
      // (나중에 구현할 부분이지만, 염두에 두세요)
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Habit>> updateHabit(Habit habit) async {
    final habitModel = HabitModel.fromEntity(habit);

    try {
      await _localDataSource.cacheHabit(habitModel);

      // TODO: 4. Remote 업데이트
      // _remoteDataSource.updateHabit()을 호출하세요.

      await _remoteDataSource.updateHabit(habitModel);

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

        // TODO: 5. (Advanced) Remote 순서 업데이트
        // 성능 이슈로 인해 개별 업데이트보다는 Batch Update가 좋지만,
        // 일단은 반복문 안에서 _remoteDataSource.updateHabit()을 호출해도 됩니다.

        await _remoteDataSource.updateHabit(habitModel);
      }

      return right(null);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }
}

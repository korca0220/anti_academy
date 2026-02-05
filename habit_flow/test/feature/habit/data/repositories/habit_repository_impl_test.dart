import 'package:flutter_test/flutter_test.dart';
import 'package:habit_flow/features/habit/data/datasources/habit_local_datasource.dart';
import 'package:habit_flow/features/habit/data/datasources/habit_remote_datasource.dart';
import 'package:habit_flow/features/habit/data/models/habit_model.dart';
import 'package:habit_flow/features/habit/data/repositories/habit_repository_impl.dart';
import 'package:habit_flow/features/habit/domain/repositories/habit_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDataSource extends Mock implements HabitLocalDataSource {}

class MockRemoteDataSource extends Mock implements HabitRemoteDataSource {}

class FakeHabitModel extends Fake implements HabitModel {}

void main() {
  late HabitRepository repository;
  late HabitLocalDataSource mockLocalDataSource;
  late HabitRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    registerFallbackValue(FakeHabitModel());
  });

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();

    repository = HabitRepositoryImpl(mockLocalDataSource, mockRemoteDataSource);
  });

  test('getHabits should fetch from remote, cache to local, and return local data', () async {
    final habitModel = HabitModel(
      id: '1',
      title: 'Test Habit',
      isCompleted: false,
      orderIndex: 0,
      createdAt: DateTime.now(),
    );

    final habits = [habitModel];

    // Stub the remote data source to return the habits
    when(() => mockRemoteDataSource.getHabits()).thenAnswer((_) async => habits);

    // Stub the local data source to return the habits
    when(() => mockLocalDataSource.getHabits()).thenAnswer((_) async => habits);

    // Stub the local data source to cache the habits
    // Any에 대한 값을 넣어줘야 하는데, 이를 위해서는 registerFallbackValue를 사용해야 한다. (가짜 모델 필요)
    when(() => mockLocalDataSource.cacheHabit(any())).thenAnswer((_) async => Future.value());

    final result = await repository.getHabits();

    expect(result.isRight(), true);

    verify(() => mockRemoteDataSource.getHabits()).called(1);

    verify(() => mockLocalDataSource.cacheHabit(habitModel)).called(1);

    verify(() => mockLocalDataSource.getHabits()).called(1);
  });
}

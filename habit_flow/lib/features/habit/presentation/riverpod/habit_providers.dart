import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/habit_local_datasource.dart';
import '../../data/datasources/habit_local_datasource_impl.dart';
import '../../data/repositories/habit_repository_impl.dart';
import '../../domain/repositories/habit_repository.dart';

part 'habit_providers.g.dart';

// 1. SharedPreferences Instance Provider
// We need to override this in main.dart because SharedPreferences is async.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError();
}

// 2. LocalDataSource Provider
@riverpod
HabitLocalDataSource habitLocalDataSource(HabitLocalDataSourceRef ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return HabitLocalDataSourceImpl(prefs);
}

// 3. Repository Provider
@riverpod
HabitRepository habitRepository(HabitRepositoryRef ref) {
  final localDataSource = ref.watch(habitLocalDataSourceProvider);
  return HabitRepositoryImpl(localDataSource);
}

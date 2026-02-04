import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasources/habit_local_datasource.dart';
import '../../data/datasources/habit_local_datasource_impl.dart';
import '../../data/datasources/habit_remote_datasource.dart';
import '../../data/repositories/habit_repository_impl.dart';
import '../../domain/repositories/habit_repository.dart';

part 'habit_providers.g.dart';

// 1. SharedPreferences Instance Provider
// We need to override this in main.dart because SharedPreferences is async.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError();
}

// 2. LocalDataSource Provider
@riverpod
HabitLocalDataSource habitLocalDataSource(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);

  return HabitLocalDataSourceImpl(prefs);
}

// 3. RemoteDataSource Provider
@riverpod
HabitRemoteDataSource habitRemoteDataSource(Ref ref) {
  return HabitRemoteDataSourceImpl(Supabase.instance.client);
}

// 3. Repository Provider
@riverpod
HabitRepository habitRepository(Ref ref) {
  final localDataSource = ref.watch(habitLocalDataSourceProvider);
  final remoteDataSource = ref.watch(habitRemoteDataSourceProvider);

  return HabitRepositoryImpl(localDataSource, remoteDataSource);
}

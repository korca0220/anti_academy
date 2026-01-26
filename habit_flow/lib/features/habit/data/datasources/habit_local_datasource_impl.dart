import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failure.dart';
import '../models/habit_model.dart';
import 'habit_local_datasource.dart';

class HabitLocalDataSourceImpl implements HabitLocalDataSource {
  final SharedPreferences _sharedPreferences;

  HabitLocalDataSourceImpl(this._sharedPreferences);

  static const cachedHabitsKey = 'CACHED_HABITS';

  @override
  Future<void> cacheHabit(HabitModel habit) async {
    // TODO: 1. Get existing habits from SharedPreferences
    // TODO: 2. Add the new habit to the list
    // TODO: 3. Encode the List<HabitModel> to JSON String
    // TODO: 4. Save to SharedPreferences using _sharedPreferences.setString

    throw UnimplementedError();
  }

  @override
  Future<void> deleteHabit(String id) {
    // TODO: Optional Assignment
    throw UnimplementedError();
  }

  @override
  Future<List<HabitModel>> getHabits() async {
    // TODO: 1. Get the JSON String from SharedPreferences
    // TODO: 2. If null, return empty list
    // TODO: 3. content decoding: List<dynamic> jsonList = json.decode(jsonString);
    // TODO: 4. map to HabitModel: jsonList.map((j) => HabitModel.fromJson(j)).toList();

    throw UnimplementedError();
  }
}

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/habit_model.dart';
import 'habit_local_datasource.dart';

class HabitLocalDataSourceImpl implements HabitLocalDataSource {
  final SharedPreferences _sharedPreferences;

  HabitLocalDataSourceImpl(this._sharedPreferences);

  static const cachedHabitsKey = 'CACHED_HABITS';

  @override
  Future<void> cacheHabit(HabitModel habit) async {
    // TODO: 1. Get existing habits from SharedPreferences
    final habits = await getHabits();
    // TODO: 2. Add the new habit to the list
    habits.add(habit);
    // TODO: 3. Encode the List<HabitModel> to JSON String
    final jsonString = json.encode(habits);

    // TODO: 4. Save to SharedPreferences using _sharedPreferences.setString
    await _sharedPreferences.setString(cachedHabitsKey, jsonString);
  }

  @override
  Future<void> deleteHabit(String id) async {
    // TODO: Optional Assignment
    final habits = await getHabits();

    final habit = habits.firstWhere((e) => e.id == id);

    habits.remove(habit);

    final jsonString = json.encode(habits);

    await _sharedPreferences.setString(cachedHabitsKey, jsonString);
  }

  @override
  Future<List<HabitModel>> getHabits() async {
    // TODO: 1. Get the JSON String from SharedPreferences
    final habitString = _sharedPreferences.getString(cachedHabitsKey);
    // TODO: 2. If null, return empty list
    if (habitString == null || habitString.isEmpty) return [];

    // TODO: 3. content decoding: List<dynamic> jsonList = json.decode(jsonString);
    final jsonList = json.decode(habitString) as List<dynamic>;
    // TODO: 4. map to HabitModel: jsonList.map((j) => HabitModel.fromJson(j)).toList();

    final habits = jsonList.map((e) => HabitModel.fromJson(e)).toList();

    return habits;
  }
}

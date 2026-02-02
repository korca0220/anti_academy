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
    final habits = await getHabits();

    final index = habits.indexWhere((element) => element.id == habit.id);

    if (index >= 0) {
      habits[index] = habit;
    } else {
      habits.add(habit);
    }

    final jsonString = json.encode(habits);

    await _sharedPreferences.setString(cachedHabitsKey, jsonString);
  }

  @override
  Future<void> deleteHabit(String id) async {
    final habits = await getHabits();

    final habit = habits.firstWhere((e) => e.id == id);

    habits.remove(habit);

    final jsonString = json.encode(habits);

    await _sharedPreferences.setString(cachedHabitsKey, jsonString);
  }

  @override
  Future<List<HabitModel>> getHabits() async {
    final habitString = _sharedPreferences.getString(cachedHabitsKey);
    if (habitString == null || habitString.isEmpty) return [];

    final jsonList = json.decode(habitString) as List<dynamic>;

    final habits = jsonList.map((e) => HabitModel.fromJson(e)).toList();

    return habits;
  }
}

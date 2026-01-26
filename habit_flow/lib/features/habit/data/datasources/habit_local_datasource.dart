import '../models/habit_model.dart';

abstract interface class HabitLocalDataSource {
  Future<List<HabitModel>> getHabits();
  Future<void> cacheHabit(HabitModel habit);
  Future<void> deleteHabit(String id);
}

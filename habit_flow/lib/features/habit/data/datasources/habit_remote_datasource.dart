import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/habit_model.dart';

abstract interface class HabitRemoteDataSource {
  Future<HabitModel> createHabit(HabitModel habit);
  Future<List<HabitModel>> getHabits();
  Future<HabitModel> updateHabit(HabitModel habit);
  Future<void> deleteHabit(String habitId);
}

class HabitRemoteDataSourceImpl implements HabitRemoteDataSource {
  final SupabaseClient _supabase;

  HabitRemoteDataSourceImpl(this._supabase);

  @override
  Future<HabitModel> createHabit(HabitModel habit) async {
    final json = habit.toJson();

    json['user_id'] = _supabase.auth.currentUser!.id;

    final result = await _supabase.from('habits').insert(json).select().single();

    return HabitModel.fromJson(result);
  }

  @override
  Future<void> deleteHabit(String habitId) async {
    await _supabase.from('habits').delete().eq('id', habitId);
  }

  @override
  Future<List<HabitModel>> getHabits() async {
    final result = await _supabase.from('habits').select().order('order_index');

    return result.map((e) => HabitModel.fromJson(e)).toList();
  }

  @override
  Future<HabitModel> updateHabit(HabitModel habit) async {
    final result = await _supabase.from('habits').upsert(habit.toJson()).eq('id', habit.id).select().single();

    return HabitModel.fromJson(result);
  }
}

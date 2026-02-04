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
    // TODO: 1. `habits` 테이블에 데이터를 추가(insert)하고, 추가된 데이터를 반환(select)하는 쿼리를 작성하세요.
    // Tip: _supabase.from('habits').insert(habit.toJson()).select().single();
    final result = await _supabase.from('habits').insert(habit.toJson()).select().single();

    return HabitModel.fromJson(result);
  }

  @override
  Future<void> deleteHabit(String habitId) async {
    // TODO: 2. `habits` 테이블에서 habitId와 일치하는 행을 삭제(delete)하세요.
    // Tip: _supabase.from('habits').delete().eq('id', habitId);
    await _supabase.from('habits').delete().eq('id', habitId);
  }

  @override
  Future<List<HabitModel>> getHabits() async {
    // TODO: 3. `habits` 테이블의 모든 데이터를 조회(select)하여 List<HabitModel>로 변환하세요.
    // Tip: order_index 기준으로 정렬(order)하는 것을 잊지 마세요.
    final result = await _supabase.from('habits').select().order('order_index');

    return result.map((e) => HabitModel.fromJson(e)).toList();
  }

  @override
  Future<HabitModel> updateHabit(HabitModel habit) async {
    // TODO: 4. `habits` 테이블에서 habit.id와 일치하는 행을 업데이트(update)하고, 변경된 데이터를 반환하세요.
    final result = await _supabase.from('habits').update(habit.toJson()).eq('id', habit.id).select().single();

    return HabitModel.fromJson(result);
  }
}

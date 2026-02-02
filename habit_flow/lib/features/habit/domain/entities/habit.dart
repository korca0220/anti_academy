import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit.freezed.dart';
part 'habit.g.dart';

@freezed
abstract class Habit with _$Habit {
  const factory Habit({
    required String id,
    required String title,
    @Default(false) bool isCompleted,
    @Default(0) int orderIndex,
    required DateTime createdAt,
  }) = _Habit;

  const Habit._();

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);
}

import '../../domain/entities/habit.dart';

class HabitModel {
  final String id;
  final String title;
  final bool isCompleted;
  final int orderIndex;
  final DateTime createdAt;

  const HabitModel({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.orderIndex,
    required this.createdAt,
  });

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['id'] as String,
      title: json['title'] as String,
      isCompleted: json['is_completed'] as bool? ?? false,
      orderIndex: json['order_index'] as int? ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'is_completed': isCompleted,
      'order_index': orderIndex,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory HabitModel.fromEntity(Habit habit) {
    return HabitModel(
      id: habit.id,
      title: habit.title,
      isCompleted: habit.isCompleted,
      orderIndex: habit.orderIndex,
      createdAt: habit.createdAt,
    );
  }

  Habit toEntity() {
    return Habit(
      id: id,
      title: title,
      isCompleted: isCompleted,
      orderIndex: orderIndex,
      createdAt: createdAt,
    );
  }
}

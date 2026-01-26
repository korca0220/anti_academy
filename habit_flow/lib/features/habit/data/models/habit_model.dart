import '../../domain/entities/habit.dart';

class HabitModel {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;

  const HabitModel({required this.id, required this.title, required this.isCompleted, required this.createdAt});

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['id'] as String,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted, 'createdAt': createdAt.toIso8601String()};
  }

  factory HabitModel.fromEntity(Habit habit) {
    return HabitModel(id: habit.id, title: habit.title, isCompleted: habit.isCompleted, createdAt: habit.createdAt);
  }

  Habit toEntity() {
    return Habit(id: id, title: title, isCompleted: isCompleted, createdAt: createdAt);
  }
}

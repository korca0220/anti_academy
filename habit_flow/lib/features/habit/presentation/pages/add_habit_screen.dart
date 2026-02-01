import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddHabitScreen extends ConsumerWidget {
  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Habit'),
      ),
      body: const Center(
        child: Text('TODO: Implement Add Habit Form'),
      ),
    );
  }
}

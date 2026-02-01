import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_flow/features/habit/presentation/riverpod/habit_list.dart';
import 'package:habit_flow/features/habit/presentation/widgets/primary_button.dart';

import '../widgets/custom_text_field.dart';

class AddHabitScreen extends ConsumerStatefulWidget {
  const AddHabitScreen({super.key});

  @override
  ConsumerState<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends ConsumerState<AddHabitScreen> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CustomTextField(
              controller: _titleController,
              hintText: 'Enter a new habit',
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Save',
              onPressed: () {
                ref.read(habitListProvider.notifier).addHabit(_titleController.text);

                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

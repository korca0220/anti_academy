import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_flow/features/habit/presentation/pages/habit_list_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/habit/presentation/pages/add_habit_screen.dart';
import '../../features/habit/presentation/pages/habit_detail_screen.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      // TODO: 1. Define the root route ('/')
      // Path should be '/'
      // Builder should return HabitListScreen
      GoRoute(
        path: '/',
        builder: (context, state) => const HabitListScreen(),
      ),

      // TODO: 2. (Optional) Think about how to add a second route for 'Add Habit'

      GoRoute(
        path: '/add',
        builder: (context, state) => const AddHabitScreen(),
      ),

      GoRoute(
        path: '/habit/:id',
        builder: (context, state) => HabitDetailScreen(
          habitId: state.pathParameters['id']!,
          habitTitle: state.extra as String,
        ),
      ),
    ],
  );
}

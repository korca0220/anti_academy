import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_flow/core/observer/app_observer.dart';
import 'package:habit_flow/core/router/app_router.dart';
import 'package:habit_flow/core/theme/theme_provider.dart';
import 'package:habit_flow/features/habit/presentation/riverpod/habit_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      observers: [AppObserver()],
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const HabitFlowApp(),
    ),
  );
}

class HabitFlowApp extends ConsumerWidget {
  const HabitFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeNotifierProvider);
    // TODO: 4. 여기서 themeNotifierProvider를 watch하세요.

    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'Habit Flow',
      debugShowCheckedModeBanner: false,
      // TODO: 5. 여기에 themeMode: ... 를 추가하세요.
      theme: ThemeData(
        textTheme: GoogleFonts.outfitTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreen,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD0BCFF), brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: themeMode,
    );
  }
}

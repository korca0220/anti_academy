import 'package:bridge/app/router/app_router.dart';
import 'package:bridge/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// TODO: 1. Import AppRouter
// import 'package:bridge/app/router/app_router.dart';
// TODO: 2. Import AppTheme
// import 'package:bridge/app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Initialize Supabase (Next Step!)

  // TODO: 3. Wrap the app with ProviderScope
  runApp(
    const ProviderScope(child: BridgeApp()),
  );
}

class BridgeApp extends ConsumerWidget {
  const BridgeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Bridge',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

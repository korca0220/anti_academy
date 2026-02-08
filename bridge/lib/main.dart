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
  runApp(const ProviderScope(child: BridgeApp()));
}

class BridgeApp extends ConsumerWidget {
  const BridgeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: 4. Watch the router provider
    // final router = ref.watch(routerProvider);

    // TODO: 5. Return MaterialApp.router
    return MaterialApp.router(
      title: 'Bridge',
      // routerConfig: router,
      // theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
    );
  }
}

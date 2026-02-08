import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// TODO: 1. Create a provider for the router
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      // TODO: 2. Define the route for Splash Screen ('/splash')

      // TODO: 3. Define the route for Sign In Screen ('/signin')

      // TODO: 4. Define the route for Home Screen ('/')
    ],
    // TODO: 5. Add redirect logic (Optional for now, but good to think about)
    // redirect: (context, state) { ... }
  );
});

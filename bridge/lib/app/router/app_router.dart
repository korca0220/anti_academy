import 'package:bridge/features/auth/presentation/providers/auth_providers.dart';
import 'package:bridge/features/auth/presentation/screens/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/feed/presentation/screens/create_post_screen.dart';
import '../../features/feed/presentation/screens/home_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/create-post',
        builder: (context, state) => CreatePostScreen(),
      ),
    ],
    redirect: (context, state) {
      if (authState.isLoading) return '/splash';

      final isAuthenticated = authState.valueOrNull != null;

      final isSplash = state.uri.toString() == '/splash';
      final isLoggingIn = state.uri.toString() == '/signin';
      final isSigningUp = state.uri.toString() == '/signup';

      // 로그인 안했는데 로그인/회원가입 페이지가 아니면 -> 로그인 페이지로
      if (!isAuthenticated && !isLoggingIn && !isSigningUp) return '/signin';

      // 로그인 했는데 로그인/회원가입/스플래쉬면 -> 홈으로
      if (isAuthenticated && (isLoggingIn || isSigningUp || isSplash)) return '/';

      return null;
    },
  );
});

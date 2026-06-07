import 'package:bridge/features/auth/presentation/providers/auth_providers.dart';
import 'package:bridge/features/auth/presentation/screens/splash_screen.dart';
import 'package:bridge/features/chat/domain/entities/chat_room.dart';
import 'package:bridge/features/chat/presentation/providers/chat_providers.dart';
import 'package:bridge/features/chat/presentation/screens/chat_room_list_screen.dart';
import 'package:bridge/features/chat/presentation/screens/chat_screen.dart';
import 'package:bridge/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/feed/domain/entities/post.dart';
import '../../features/feed/presentation/screens/create_post_screen.dart';
import '../../features/feed/presentation/screens/home_screen.dart';
import '../../features/feed/presentation/screens/post_detail_screen.dart';

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
        routes: [
          GoRoute(
            path: 'create',
            builder: (context, state) => const CreatePostScreen(),
          ),
          GoRoute(
            path: 'post/:postId',
            builder: (context, state) {
              final post = state.extra;
              if (post is! Post) {
                return const HomeScreen();
              }

              return PostDetailScreen(post: post);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/chats',
        builder: (context, state) => const ChatRoomListScreen(),
        routes: [
          GoRoute(
              path: ':roomId',
              builder: (context, state) {
                final room = state.extra;
                final roomId = state.pathParameters['roomId'] ?? '';
                if (room is ChatRoom) {
                  return ChatScreen(room: room);
                }

                return _ChatRoomRouteLoader(
                  roomId: roomId,
                );
              }),
        ],
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
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
      if (isAuthenticated && (isLoggingIn || isSigningUp || isSplash))
        return '/';

      return null;
    },
  );
});

class _ChatRoomRouteLoader extends ConsumerWidget {
  const _ChatRoomRouteLoader({required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomsAsync = ref.watch(chatRoomsFutureProvider);

    return roomsAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => const ChatRoomListScreen(),
      data: (rooms) {
        ChatRoom? matchedRoom;
        for (final room in rooms) {
          if (room.id == roomId) {
            matchedRoom = room;
            break;
          }
        }

        if (matchedRoom == null) {
          return const ChatRoomListScreen();
        }

        return ChatScreen(room: matchedRoom);
      },
    );
  }
}

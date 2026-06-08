import 'package:bridge/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/widgets/empty_state_widget.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/feed_filter_provider.dart';
import '../providers/post_providers.dart';
import '../widgets/feed_item.dart';
import '../widgets/skeleton_feed_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsStreamProvider);
    final feedFilter = ref.watch(feedFilterProvider);
    final userId = ref.watch(currentUserIdProvider);
    final avatar = ref.watch(profileFutureProvider(userId ?? ''));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bridge'),
        actions: [
          IconButton(
            onPressed: () => context.push('/search'),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => context.push('/chats'),
            icon: const Icon(Icons.mail_outline_rounded),
          ),
          IconButton(
            onPressed: () => context.push('/profile'),
            icon: avatar.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => const Icon(Icons.error),
              data: (avatar) => CircleAvatar(
                radius: 14,
                backgroundImage: avatar?.avatarUrl != null //
                    ? NetworkImage(avatar?.avatarUrl ?? '')
                    : null,
                child: avatar?.avatarUrl != null
                    ? null //
                    : const Icon(Icons.person, size: 18),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          SegmentedButton(
            expandedInsets: const EdgeInsets.symmetric(horizontal: 16),
            selected: {feedFilter},
            segments: const [
              ButtonSegment(value: FeedFilter.all, label: Text('All')),
              ButtonSegment(value: FeedFilter.request, label: Text('Request')),
              ButtonSegment(value: FeedFilter.offer, label: Text('Offer')),
            ],
            onSelectionChanged: (value) {
              ref.read(feedFilterProvider.notifier).state =
                  value.firstOrNull ?? FeedFilter.all;
            },
          ),
          Expanded(
            child: posts.when(
              loading: () => ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => const SkeletonFeedItem(),
              ),
              error: (error, stackTrace) {
                return Center(child: Text('Error : $error'));
              },
              data: (posts) {
                if (posts.isEmpty) {
                  return EmptyStateWidget(
                    title: '게시글이 없어요',
                    subtitle: '첫 번째 글을 작성해보세요!',
                    iconData: Icons.feed_outlined,
                    onActionPressed: () => context.push('/create'),
                    actionLabel: '글쓰기',
                  );
                }
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];

                    return FeedItem(post: post);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

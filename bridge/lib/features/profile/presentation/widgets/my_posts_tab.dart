import 'package:bridge/app/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/my_activity_providers.dart';

class MyPostsTab extends ConsumerWidget {
  const MyPostsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(myPostsProvider);

    return postsAsync.when(
      error: (err, __) => Center(child: Text('Error: $err')),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (posts) {
        if (posts.isEmpty) {
          return const EmptyStateWidget(
              title: '게시글이 없어요',
              subtitle: '첫 번째 게시글을 작성해보세요!',
              iconData: Icons.feed_outlined);
        }

        return ListView.separated(
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];

            return ListTile(
              title: Text(post.title),
              subtitle: Text(post.content),
              leading: Badge(label: Text(post.type.name)),
            );
          },
        );
      },
    );
  }
}

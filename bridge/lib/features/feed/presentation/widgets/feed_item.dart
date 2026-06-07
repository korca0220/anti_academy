import 'package:bridge/features/feed/domain/entities/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../profile/presentation/providers/profile_providers.dart';

class FeedItem extends ConsumerWidget {
  const FeedItem({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileFutureProvider(post.authorId));

    return ListTile(
      onTap: () {
        context.push('/post/${post.id}', extra: post);
      },
      title: Text(
        post.title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.content),
          SizedBox(height: 4),
          profile.when(
            error: (_, __) => SizedBox.shrink(),
            loading: () => SizedBox.shrink(),
            data: (profile) => Text(
              'By ${profile?.nickname ?? 'Unknown'}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
      leading: switch (post.type) {
        PostType.request =>
          Badge(label: Text('Request'), backgroundColor: Colors.blue),
        PostType.offer =>
          Badge(label: Text('Offer'), backgroundColor: Colors.green),
      },
    );
  }
}

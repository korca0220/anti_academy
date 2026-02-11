import 'package:bridge/features/feed/domain/entities/post.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push('/post-detail', extra: post);
      },
      title: Text(post.title),
      subtitle: Text(post.content),
      leading: switch (post.type) {
        PostType.request => Badge(label: Text('Request'), backgroundColor: Colors.blue),
        PostType.offer => Badge(label: Text('Offer'), backgroundColor: Colors.green),
      },
    );
  }
}

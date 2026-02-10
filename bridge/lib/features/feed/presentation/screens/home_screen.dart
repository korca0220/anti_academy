import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/post_providers.dart';
import '../widgets/feed_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
      ),
      body: posts.when(
        loading: () => Center(
          child: const CircularProgressIndicator(),
        ),
        error: (error, stackTrace) {
          return Text('Error : $error');
        },
        data: (posts) {
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return FeedItem(post: post);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/create-post'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

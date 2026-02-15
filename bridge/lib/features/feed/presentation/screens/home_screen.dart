import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/feed_filter_provider.dart';
import '../providers/post_providers.dart';
import '../widgets/feed_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsStreamProvider);
    final feedFilter = ref.watch(feedFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              size: 24,
            ),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: Column(
        children: [
          SegmentedButton(
            expandedInsets: const EdgeInsets.symmetric(horizontal: 16),
            selected: {feedFilter},
            segments: [
              ButtonSegment(value: FeedFilter.all, label: Text('All')),
              ButtonSegment(value: FeedFilter.request, label: Text('Request')),
              ButtonSegment(value: FeedFilter.offer, label: Text('Offer')),
            ],
            onSelectionChanged: (value) {
              ref.read(feedFilterProvider.notifier).state = value.firstOrNull ?? FeedFilter.all;
            },
          ),
          Expanded(
            child: posts.when(
              loading: () => Center(
                child: const CircularProgressIndicator(),
              ),
              error: (error, stackTrace) {
                return Center(child: Text('Error : $error'));
              },
              data: (posts) {
                if (posts.isEmpty) {
                  return const Center(child: Text('No posts found'));
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
        onPressed: () => context.push('/create-post'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

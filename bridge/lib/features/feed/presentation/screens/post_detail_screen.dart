import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../profile/presentation/providers/profile_providers.dart';
import '../../domain/entities/post.dart';

class PostDetailScreen extends ConsumerWidget {
  const PostDetailScreen({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateStr = post.createdAt.toLocal().toString().split('.')[0];
    final profile = ref.watch(profileFutureProvider(post.authorId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  profile.when(
                    data: (profile) => CircleAvatar(
                      backgroundImage: profile?.avatarUrl != null //
                          ? NetworkImage(profile?.avatarUrl ?? '')
                          : null,
                      child: profile?.avatarUrl != null //
                          ? null
                          : Icon(Icons.person),
                    ),
                    error: (_, __) => SizedBox.shrink(),
                    loading: () => SizedBox.shrink(),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        profile.when(
                          data: (profile) => Text(
                            'By ${profile?.nickname ?? 'Unknown'}',
                            style: Theme.of(context).textTheme.labelLarge,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          error: (_, __) => SizedBox.shrink(),
                          loading: () => SizedBox.shrink(),
                        ),
                        Text(
                          dateStr,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                height: 48,
              ),
              Text(
                post.content,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    // TODO: Chat Feature
                  },
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('Contact Author'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

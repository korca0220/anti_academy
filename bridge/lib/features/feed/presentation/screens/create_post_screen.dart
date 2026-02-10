import 'package:bridge/features/feed/presentation/providers/post_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/post.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  // TODO: Add controllers
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Column(
        children: [
          TextFormField(
            key: const Key('titleField'),
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextFormField(
            key: const Key('contentField'),
            controller: contentController,
            decoration: InputDecoration(labelText: 'Content'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newPost = Post(
                id: const Uuid().v4(),
                authorId: ref.read(currentUserIdProvider) ?? '',
                type: PostType.request,
                title: titleController.text,
                content: contentController.text,
                status: PostStatus.open,
                imageUrls: [],
                createdAt: DateTime.now(),
              );

              try {
                await ref.read(postRepositoryProvider).createPost(newPost);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Post created successfully')),
                  );

                  context.pop();
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to create post'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

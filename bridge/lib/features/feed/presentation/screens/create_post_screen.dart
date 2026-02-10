import 'package:bridge/features/feed/presentation/providers/post_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            onPressed: () {
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

              ref.read(postRepositoryProvider).createPost(newPost);
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

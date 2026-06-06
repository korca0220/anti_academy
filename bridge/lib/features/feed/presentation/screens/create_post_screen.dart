import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/post.dart';
import '../providers/create_post_controller.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
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
        mainAxisSize: MainAxisSize.min,
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
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
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
                  await ref.read(createPostControllerProvider.notifier).createPost(post: newPost);

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
              child: SizedBox(
                height: 30,
                child: Center(
                  child: ref.watch(createPostControllerProvider).when(
                        loading: () => CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        error: (error, stackTrace) => SizedBox.shrink(),
                        data: (data) => const Text('Submit'),
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

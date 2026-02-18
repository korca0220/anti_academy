import 'dart:io';

import 'package:bridge/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class AvatarPickerWidget extends ConsumerStatefulWidget {
  const AvatarPickerWidget({super.key});

  @override
  ConsumerState<AvatarPickerWidget> createState() => _AvatarPickerWidgetState();
}

class _AvatarPickerWidgetState extends ConsumerState<AvatarPickerWidget> {
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final userId = ref.read(currentUserIdProvider);

    if (userId == null) return;

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() => _isLoading = true);

      try {
        await ref.read(profileRepositoryProvider).updateAvatar(File(image.path), userId);

        ref.invalidate(profileFutureProvider(userId));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Avatar updated successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update avatar')),
          );
        }
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(currentUserIdProvider);
    final avatarUrl = ref.watch(profileFutureProvider(userId ?? ''));

    const personIcon = Icon(
      Icons.person,
      size: 50,
    );

    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: avatarUrl.when(
              data: (profile) => profile?.avatarUrl != null //
                  ? NetworkImage(profile?.avatarUrl ?? '')
                  : null,
              error: (_, __) => null,
              loading: () => null,
            ),
            child: avatarUrl.when(
              data: (profile) => profile?.avatarUrl != null //
                  ? null
                  : personIcon,
              error: (_, __) => personIcon,
              loading: () => personIcon,
            ),
          ),
          if (_isLoading)
            Positioned.fill(
              child: CircularProgressIndicator(
                color: AppColors.secondary,
              ),
            ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

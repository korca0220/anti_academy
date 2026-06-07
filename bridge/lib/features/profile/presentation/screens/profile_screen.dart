import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/profile.dart';
import '../providers/profile_providers.dart';
import '../widgets/avatar_picker_widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _bioController = TextEditingController();

  // TODO: Add state for loading handling if needed

  @override
  void initState() {
    super.initState();
    // 초기 데이터 로딩은 build나 provider listen에서 처리 가능
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(currentUserIdProvider);
    final profileAsync = ref.watch(profileFutureProvider(userId ?? ''));

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            onPressed: _signOut,
            tooltip: '로그아웃',
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (profile) {
          // 데이터가 로드되면 컨트롤러에 초기값 설정 (한 번만 실행되도록 주의 필요)
          if (_nicknameController.text.isEmpty && profile?.nickname != null) {
            _nicknameController.text = profile!.nickname;
          }

          if (_bioController.text.isEmpty && profile?.bio != null) {
            _bioController.text = profile!.bio ?? '';
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const AvatarPickerWidget(),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nicknameController,
                    decoration: const InputDecoration(labelText: 'Nickname'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _bioController,
                    decoration: const InputDecoration(labelText: 'Bio'),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final updatedProfile = profile?.copyWith(
                          nickname: _nicknameController.text,
                          bio: _bioController.text,
                        );

                        if (updatedProfile != null) {
                          _saveProfile(updatedProfile);
                        }
                      }
                    },
                    child: const Text('Save Profile'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveProfile(Profile updatedProfile) async {
    try {
      await ref.read(profileRepositoryProvider).updateProfile(updatedProfile);

      ref.invalidate(profileFutureProvider(updatedProfile.id));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }

  Future<void> _signOut() async {
    try {
      await ref.read(authRepositoryProvider).signOut();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그아웃에 실패했습니다.')),
      );
    }
  }
}

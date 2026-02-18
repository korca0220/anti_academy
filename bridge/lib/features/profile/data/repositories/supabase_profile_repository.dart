import 'dart:developer' show log;
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';

class SupabaseProfileRepository implements ProfileRepository {
  SupabaseProfileRepository({required this.supabaseClient});

  final SupabaseClient supabaseClient;

  @override
  Future<Profile?> getProfile(String userId) async {
    try {
      final data = await supabaseClient.from('profiles').select().eq('id', userId).maybeSingle();

      if (data == null) return null;

      return Profile.fromJson(data);
    } catch (e) {
      log('Failed to get profile: $e');

      throw Exception('Failed to get profile: $e');
    }
  }

  @override
  Future<void> updateProfile(Profile profile) async {
    try {
      await supabaseClient.from('profiles').update(profile.toJson()).eq('id', profile.id);
    } catch (e) {
      log('Failed to update profile: $e');

      throw Exception('Failed to update profile: $e');
    }
  }

  @override
  Future<void> updateAvatar(File imageFile, String userId) async {
    try {
      final path = '$userId/avatar.png';

      await supabaseClient.storage.from('avatars').uploadBinary(
            path,
            imageFile.readAsBytesSync(),
            fileOptions: FileOptions(
              upsert: true,
            ),
          );

      final avatarUrl = supabaseClient.storage.from('avatars').getPublicUrl(path);

      await supabaseClient.from('profiles').update({
        'avatar_url': avatarUrl,
      }).eq('id', userId);
    } catch (e) {
      log('Failed to update avatar: $e');

      rethrow;
    }
  }
}

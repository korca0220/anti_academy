import 'dart:developer' show log;

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
    // TODO: Implement updating profile to Supabase
    // 1. Use .from('profiles').upsert(...) or .update(...)
    // 2. Match by 'id'

    try {
      final profileJson = profile.toJson();

      await supabaseClient.from('profiles').update(profileJson).eq('id', profile.id);
    } catch (e) {
      log('Failed to update profile: $e');

      throw Exception('Failed to update profile: $e');
    }
  }
}

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
}

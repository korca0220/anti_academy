import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/Supabase_flutter.dart';

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

import 'package:bridge/features/review/data/repositories/supabase_review_repository.dart';
import 'package:bridge/features/review/domain/repositories/review_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return SupabaseReviewRepository(Supabase.instance.client);
});

// TODO: 작성/조회 상태를 관리할 AsyncNotifier 또는 Notifier provider 추가

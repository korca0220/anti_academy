import 'package:bridge/features/auth/presentation/providers/auth_providers.dart';
import 'package:bridge/features/feed/domain/entities/post.dart';
import 'package:bridge/features/feed/presentation/providers/post_providers.dart';
import 'package:bridge/features/transaction/domain/entities/transaction.dart';
import 'package:bridge/features/transaction/presentation/providers/transaction_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_activity_providers.g.dart';

@riverpod
Future<List<Post>> myPosts(Ref ref) async {
  final userId = ref.watch(currentUserIdProvider);

  if (userId == null) {
    return [];
  }

  return ref.watch(postRepositoryProvider).getByUserId(userId);
}

@riverpod
Future<List<Transaction>> myTransactions(Ref ref) async {
  final userId = ref.watch(currentUserIdProvider);

  if (userId == null) {
    return [];
  }

  return ref.watch(transactionRepositoryProvider).getByUserId(userId);
}

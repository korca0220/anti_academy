import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/supabase_transaction_repository.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';

part 'transaction_providers.g.dart';

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return SupabaseTransactionRepository(Supabase.instance.client);
});

final transactionStreamProvider =
    StreamProvider.family<Transaction?, String>((ref, roomId) {
  final repository = ref.watch(transactionRepositoryProvider);
  return repository.watchByRoomId(roomId);
});

@riverpod
Future<List<Transaction>> myTransactions(Ref ref) async {
  final userId = ref.watch(currentUserIdProvider);

  if (userId == null) {
    return [];
  }

  return ref.watch(transactionRepositoryProvider).getByUserId(userId);
}

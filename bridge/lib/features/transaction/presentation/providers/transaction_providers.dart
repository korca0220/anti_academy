import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repositories/supabase_transaction_repository.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return SupabaseTransactionRepository(Supabase.instance.client);
});

final transactionStreamProvider =
    StreamProvider.family<Transaction?, String>((ref, roomId) {
  final repository = ref.watch(transactionRepositoryProvider);
  return repository.watchByRoomId(roomId);
});

import 'package:bridge/features/transaction/domain/entities/transaction.dart';

abstract interface class TransactionRepository {
  Future<Transaction?> getByRoomId(String roomId);
  Stream<Transaction?> watchByRoomId(String roomId);
  Future<void> upsert(Transaction transaction);
  Future<void> updateStatus({
    required String roomId,
    required TransactionStatus status,
    required String actorId,
    String? cancelReason,
  });
}

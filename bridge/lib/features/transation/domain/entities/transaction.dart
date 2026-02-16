import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

enum TransactionStatus {
  proposed,
  accepted,
  in_progress,
  completed,
  canceled,
}

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required String roomId,
    String? postId,
    required String requesterId,
    String? providerId,
    required TransactionStatus status,
    required String updatedBy,
    String? cancelReason,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? closedAt,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
}

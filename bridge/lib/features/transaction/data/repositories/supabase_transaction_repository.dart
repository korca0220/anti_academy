import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';

class SupabaseTransactionRepository implements TransactionRepository {
  final SupabaseClient _supabase;

  SupabaseTransactionRepository(this._supabase);

  @override
  Future<Transaction?> getByRoomId(String roomId) async {
    try {
      final result = await _supabase.from('transactions').select().eq('room_id', roomId).maybeSingle();

      if (result == null) return null;

      return Transaction.fromJson(result);
    } catch (e) {
      log('Failed to get transaction by room id: $e');

      throw Exception('Failed to get transaction by room id: $e');
    }
  }

  @override
  Stream<Transaction?> watchByRoomId(String roomId) {
    try {
      final response = _supabase.from('transactions').stream(primaryKey: ['id']).eq('room_id', roomId);

      return response.map((event) {
        if (event.isEmpty) return null;

        return Transaction.fromJson(event.first);
      });
    } catch (e) {
      log('Failed to watch transaction by room id: $e');

      throw Exception('Failed to watch transaction by room id: $e');
    }
  }

  @override
  Future<void> upsert(Transaction transaction) async {
    try {
      final transactionJson = transaction.toJson();

      await _supabase.from('transactions').upsert(transactionJson);
    } catch (e) {
      log('Failed to upsert transaction: $e');

      throw Exception('Failed to upsert transaction: $e');
    }
  }

  @override
  Future<void> updateStatus({
    required String roomId,
    required TransactionStatus status,
    required String actorId,
    String? cancelReason,
  }) async {
    try {
      await _supabase.from('transactions').update({
        'status': status.name,
        'updated_by': actorId,
        'cancel_reason': cancelReason,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('room_id', roomId);
    } catch (e) {
      log('Failed to update transaction status: $e');

      throw Exception('Failed to update transaction status: $e');
    }
  }
}

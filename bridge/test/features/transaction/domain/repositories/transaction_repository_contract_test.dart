import 'package:bridge/features/transaction/domain/entities/transaction.dart';
import 'package:bridge/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'transaction_repository_contract_test.mocks.dart';

@GenerateMocks([TransactionRepository])
void main() {
  group('TransactionRepository contract', () {
    late MockTransactionRepository repository;

    setUp(() {
      repository = MockTransactionRepository();
    });

    const roomId = 'room-001';
    const actorId = 'user-actor-001';

    test('getByRoomId() should be callable with roomId', () async {
      when(repository.getByRoomId(roomId)).thenAnswer((_) async => null);

      final result = repository.getByRoomId(roomId);

      expect(await result, isNull);

      verify(repository.getByRoomId(roomId)).called(1);
    });

    test('watchByRoomId() should be callable with roomId', () async {
      final tx = Transaction(
        id: 'tx-001',
        roomId: roomId,
        postId: 'post-001',
        requesterId: 'user-req-001',
        providerId: null,
        status: TransactionStatus.proposed,
        updatedBy: actorId,
        cancelReason: null,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
        closedAt: null,
      );

      when(repository.watchByRoomId(roomId)).thenAnswer((_) => Stream.value(tx));
      final result = repository.watchByRoomId(roomId);
      expect(await result.first, equals(tx));
      verify(repository.watchByRoomId(roomId)).called(1);
    });
    test('upsert() should accept Transaction entity', () async {
      final tx = Transaction(
        id: 'tx-002',
        roomId: roomId,
        postId: null,
        requesterId: actorId,
        providerId: null,
        status: TransactionStatus.proposed,
        updatedBy: actorId,
        cancelReason: null,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
        closedAt: null,
      );
      when(repository.upsert(tx)).thenAnswer((_) async {});
      await repository.upsert(tx);
      verify(repository.upsert(tx)).called(1);
    });
    test('updateStatus() should pass roomId/status/actorId (and optional reason)', () async {
      when(repository.updateStatus(
              roomId: roomId, status: TransactionStatus.in_progress, actorId: actorId, cancelReason: null))
          .thenAnswer((_) async {});

      await repository.updateStatus(
          roomId: roomId, status: TransactionStatus.in_progress, actorId: actorId, cancelReason: null);

      verify(
        repository.updateStatus(
            roomId: roomId, status: TransactionStatus.in_progress, actorId: actorId, cancelReason: null),
      ).called(1);
    });
    test('updateStatus() with canceled should carry cancel reason parameter', () async {
      when(repository.updateStatus(
              roomId: roomId, status: TransactionStatus.canceled, actorId: actorId, cancelReason: 'cancel reason'))
          .thenAnswer((_) async {});
      await repository.updateStatus(
          roomId: roomId, status: TransactionStatus.canceled, actorId: actorId, cancelReason: 'cancel reason');
      verify(
        repository.updateStatus(
            roomId: roomId, status: TransactionStatus.canceled, actorId: actorId, cancelReason: 'cancel reason'),
      ).called(1);
    });
  });
}

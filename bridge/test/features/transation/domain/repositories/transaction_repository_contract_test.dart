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
      // TODO: repository = MockTransactionRepository();
      repository = MockTransactionRepository();
    });

    const roomId = 'room-001';
    const actorId = 'user-actor-001';

    test('watchTransactionByRoom() should be callable with roomId', () async {
      // TODO: create sample transaction and a fake stream
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
      // TODO: when(repository.watchTransactionByRoom(roomId)).thenAnswer((_) => Stream.value(tx));
      when(repository.watchByRoomId(roomId)).thenAnswer((_) => Stream.value(tx));
      // TODO: final result = repository.watchTransactionByRoom(roomId);
      final result = repository.watchByRoomId(roomId);
      // TODO: expect(await result.first, equals(tx));
      expect(await result.first, equals(tx));

      // TODO: verify(repository.watchTransactionByRoom(roomId)).called(1);
      verify(repository.watchByRoomId(roomId)).called(1);
    });
    test('createTransaction() should accept Transaction entity', () async {
      // TODO: create tx fixture
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
      // TODO: when(repository.createTransaction(any)).thenAnswer((_) async {});
      when(repository.upsert(tx)).thenAnswer((_) async {});
      // TODO: await repository.createTransaction(tx);
      await repository.upsert(tx);
      // TODO: verify(repository.createTransaction(tx)).called(1);
      verify(repository.upsert(tx)).called(1);
    });
    test('transitionStatus() should pass roomId/status/actorId (and optional reason)', () async {
      // TODO: define newStatus/cancelReason

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
    test('transitionStatus() with canceled should carry cancel reason parameter', () async {
      // TODO: stub updateStatus(...) as async {}
      when(repository.updateStatus(
              roomId: roomId, status: TransactionStatus.canceled, actorId: actorId, cancelReason: 'cancel reason'))
          .thenAnswer((_) async {});
      // TODO: call with TransactionStatus.canceled + reason text
      await repository.updateStatus(
          roomId: roomId, status: TransactionStatus.canceled, actorId: actorId, cancelReason: 'cancel reason');
      // TODO: verify cancel reason passed correctly
      verify(
        repository.updateStatus(
            roomId: roomId, status: TransactionStatus.canceled, actorId: actorId, cancelReason: 'cancel reason'),
      ).called(1);
    });
  });
}

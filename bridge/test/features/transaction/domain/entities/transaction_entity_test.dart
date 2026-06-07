import 'package:bridge/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Transaction entity', () {
    Transaction fixture({
      String? id,
      String? roomId,
      String? postId,
      String? requesterId,
      String? providerId,
      TransactionStatus status = TransactionStatus.proposed,
      String? updatedBy,
      String? cancelReason,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? closedAt,
    }) {
      return Transaction(
        id: id ?? 'tx-001',
        roomId: roomId ?? 'room-001',
        postId: postId,
        requesterId: requesterId ?? 'user-req-001',
        providerId: providerId,
        status: status,
        updatedBy: updatedBy ?? 'user-actor-001',
        cancelReason: cancelReason,
        createdAt: createdAt ?? DateTime(2026, 1, 1, 10, 0, 0),
        updatedAt: updatedAt ?? DateTime(2026, 1, 1, 10, 0, 0),
        closedAt: closedAt,
      );
    }

    test('동일한 값이면 값 동등성은 같다', () {
      // TODO: 두 객체를 만든 뒤 equals가 true인지 검증
      final first = fixture();
      final second = fixture();

      expect(first, equals(second));
    });
    test('필수 필드가 유지되는지 검증', () {
      // TODO: id/roomId/requesterId/status/updatedBy가 기대값과 같은지 검증
      final tx = fixture(
        id: 'tx-002',
        roomId: 'room-002',
        requesterId: 'requester-002',
        status: TransactionStatus.accepted,
        updatedBy: 'actor-002',
      );
      expect(tx.id, equals('tx-002'));
      expect(tx.roomId, equals('room-002'));
      expect(tx.requesterId, equals('requester-002'));
      expect(tx.status, equals(TransactionStatus.accepted));
      expect(tx.updatedBy, equals('actor-002'));
    });
    test('copyWith로 일부 값만 변경 가능해야 한다', () {
      // TODO: copyWith 전/후 값 비교
      final original = fixture(roomId: 'room-origin');
      final updated = original.copyWith(status: TransactionStatus.in_progress);

      expect(updated.id, equals(original.id));
      expect(updated.roomId, equals(original.roomId));
      expect(updated.status, equals(TransactionStatus.in_progress));
    });
    test('nullable 필드를 nullable 상태로 보관할 수 있어야 한다', () {
      // TODO: nullable 필드 null/값 케이스를 분리해서 검증
      final withoutOptionals =
          fixture(providerId: null, cancelReason: null, closedAt: null);
      final withOptionals = fixture(
        providerId: 'provider-001',
        cancelReason: 'User canceled',
        closedAt: DateTime(2026, 1, 2),
      );
      expect(withoutOptionals.providerId, isNull);
      expect(withoutOptionals.cancelReason, isNull);
      expect(withoutOptionals.closedAt, isNull);
      expect(withOptionals.providerId, equals('provider-001'));
      expect(withOptionals.cancelReason, equals('User canceled'));
      expect(withOptionals.closedAt, isNotNull);
    });
    test('status enum은 제약 없이 타입 안정적으로 들어가야 한다', () {
      // TODO: Enum 값이 원하는 값으로 설정되는지 검증
      final tx = fixture(status: TransactionStatus.completed);
      expect(tx.status, equals(TransactionStatus.completed));
    });
  });
}

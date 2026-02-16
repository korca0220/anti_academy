import 'package:bridge/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TransactionStatus transition policy', () {
    test('proposed -> accepted is allowed', () {
      // TODO: implement assertion
      expect(canTransition(TransactionStatus.proposed, TransactionStatus.accepted), true);
    });
    test('accepted -> in_progress is allowed', () {
      // TODO: implement assertion
      expect(canTransition(TransactionStatus.accepted, TransactionStatus.in_progress), true);
    });
    test('in_progress -> completed is allowed', () {
      // TODO: implement assertion
      expect(canTransition(TransactionStatus.in_progress, TransactionStatus.completed), true);
    });
    test('completed -> in_progress is not allowed', () {
      // TODO: implement assertion
      expect(canTransition(TransactionStatus.completed, TransactionStatus.in_progress), false);
    });
    test('any -> completed cannot go back', () {
      expect(
        canTransition(TransactionStatus.completed, TransactionStatus.proposed),
        false,
      );
      expect(
        canTransition(TransactionStatus.completed, TransactionStatus.accepted),
        false,
      );
      expect(
        canTransition(TransactionStatus.completed, TransactionStatus.in_progress),
        false,
      );
      expect(
        canTransition(TransactionStatus.completed, TransactionStatus.canceled),
        false,
      );
    });
    test('canceled is terminal state', () {
      expect(
        canTransition(TransactionStatus.canceled, TransactionStatus.proposed),
        false,
      );
      expect(
        canTransition(TransactionStatus.canceled, TransactionStatus.accepted),
        false,
      );
      expect(
        canTransition(TransactionStatus.canceled, TransactionStatus.in_progress),
        false,
      );
      expect(
        canTransition(TransactionStatus.canceled, TransactionStatus.completed),
        false,
      );
    });
    test('invalid middle-state transitions are blocked', () {
      expect(
        canTransition(TransactionStatus.in_progress, TransactionStatus.accepted),
        false,
      );
      expect(
        canTransition(TransactionStatus.accepted, TransactionStatus.proposed),
        false,
      );
      expect(
        canTransition(TransactionStatus.accepted, TransactionStatus.canceled),
        true, // 비정상은 아님. 중간 단계에서 취소는 허용
      );
    });
  });
}

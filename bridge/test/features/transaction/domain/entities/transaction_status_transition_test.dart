import 'package:bridge/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TransactionStatus transition policy', () {
    test('proposed -> accepted is allowed', () {
      expect(
        canTransition(TransactionStatus.proposed, TransactionStatus.accepted),
        isTrue,
      );
    });
    test('proposed -> canceled is allowed', () {
      expect(
        canTransition(TransactionStatus.proposed, TransactionStatus.canceled),
        isTrue,
      );
    });
    test('accepted -> in_progress is allowed', () {
      expect(
        canTransition(
            TransactionStatus.accepted, TransactionStatus.in_progress),
        isTrue,
      );
    });
    test('accepted -> canceled is allowed', () {
      expect(
        canTransition(TransactionStatus.accepted, TransactionStatus.canceled),
        isTrue,
      );
    });
    test('in_progress -> completed is allowed', () {
      expect(
        canTransition(
            TransactionStatus.in_progress, TransactionStatus.completed),
        isTrue,
      );
    });
    test('in_progress -> canceled is allowed', () {
      expect(
        canTransition(
            TransactionStatus.in_progress, TransactionStatus.canceled),
        isTrue,
      );
    });
    test('completed is terminal state', () {
      expect(
          canTransition(
              TransactionStatus.completed, TransactionStatus.proposed),
          isFalse);
      expect(
          canTransition(
              TransactionStatus.completed, TransactionStatus.accepted),
          isFalse);
      expect(
          canTransition(
              TransactionStatus.completed, TransactionStatus.in_progress),
          isFalse);
      expect(
          canTransition(
              TransactionStatus.completed, TransactionStatus.canceled),
          isFalse);
    });
    test('canceled is terminal state', () {
      expect(
          canTransition(TransactionStatus.canceled, TransactionStatus.proposed),
          isFalse);
      expect(
          canTransition(TransactionStatus.canceled, TransactionStatus.accepted),
          isFalse);
      expect(
          canTransition(
              TransactionStatus.canceled, TransactionStatus.in_progress),
          isFalse);
      expect(
          canTransition(
              TransactionStatus.canceled, TransactionStatus.completed),
          isFalse);
    });
    test('invalid middle-state transitions are blocked', () {
      expect(
          canTransition(
              TransactionStatus.in_progress, TransactionStatus.accepted),
          isFalse);
      expect(
          canTransition(TransactionStatus.accepted, TransactionStatus.proposed),
          isFalse);
    });
  });
}

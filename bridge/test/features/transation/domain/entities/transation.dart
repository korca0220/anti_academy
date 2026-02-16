import 'package:bridge/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

// TODO: 실제 경로/클래스명이 다르면 import 경로만 맞춰줘
void main() {
  group('TransactionStatus transition policy', () {
    test('proposed -> accepted should be allowed', () {
      // TODO: implement: expect(canTransition(TransactionStatus.proposed, TransactionStatus.accepted), true)
    });
    test('accepted -> in_progress should be allowed', () {
      // TODO: implement
    });
    test('in_progress -> completed should be allowed', () {
      // TODO: implement
    });
    test('completed -> in_progress should be rejected', () {
      // TODO: implement: expect(..., false) 또는 throwsA(...)
    });
    test('canceled -> any status should be rejected', () {
      // TODO: implement
    });
  });
}

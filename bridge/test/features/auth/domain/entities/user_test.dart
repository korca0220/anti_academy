import 'package:bridge/features/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User Entity', () {
    test('should support value equality', () {
      // 1. Arrange
      final user1 = User(
        id: '1',
        email: 'test@t.com',
        nickname: 'tester',
        createdAt: DateTime(2024, 1, 1),
      );
      final user2 = User(
        id: '1',
        email: 'test@t.com',
        nickname: 'tester',
        createdAt: DateTime(2024, 1, 1),
      );

      // 3. Assert
      expect(user1, equals(user2));
    });
  });
}

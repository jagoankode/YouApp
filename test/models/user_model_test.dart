import 'package:flutter_test/flutter_test.dart';
import 'package:you_app/models/user_model.dart';

void main() {
  group('UserModel Tests', () {
    test('UserModel creation with valid data', () {
      final user = UserModel(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
        interest: 'Technology',
      );

      expect(user.email, 'test@example.com');
      expect(user.username, 'testuser');
      expect(user.password, 'password123');
      expect(user.interest, 'Technology');
    });

    test('UserModel creation with empty interest', () {
      final user = UserModel(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
      );

      expect(user.email, 'test@example.com');
      expect(user.username, 'testuser');
      expect(user.password, 'password123');
      expect(user.interest, isNull);
    });
  });
}
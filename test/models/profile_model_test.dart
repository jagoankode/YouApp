import 'package:flutter_test/flutter_test.dart';
import 'package:you_app/models/profile_model.dart';

void main() {
  group('ProfileModel Tests', () {
    test('ProfileModel creation with valid data', () {
      final profile = ProfileModel(
        displayName: 'John Doe',
        birthday: '1990-01-01',
        horoscope: 'capricorn',
        zodiac: 'goat',
        height: 180,
        weight: 75,
        userId: 'user123',
      );

      expect(profile.displayName, 'John Doe');
      expect(profile.birthday, '1990-01-01');
      expect(profile.horoscope, 'capricorn');
      expect(profile.zodiac, 'goat');
      expect(profile.height, 180);
      expect(profile.weight, 75);
      expect(profile.userId, 'user123');
    });

    test('ProfileModel fromJson and toJson methods', () {
      final json = {
        'display_name': 'Jane Doe',
        'birthday': '1995-05-15',
        'horoscope': 'leo',
        'zodiac': 'lion',
        'height': 165,
        'weight': 60,
        'id_user': 'user456',
      };

      final profile = ProfileModel.fromJson(json);
      expect(profile.displayName, 'Jane Doe');
      expect(profile.birthday, '1995-05-15');
      expect(profile.horoscope, 'leo');
      expect(profile.zodiac, 'lion');
      expect(profile.height, 165);
      expect(profile.weight, 60);
      expect(profile.userId, 'user456');

      final outputJson = profile.toJson();
      expect(outputJson['display_name'], 'Jane Doe');
      expect(outputJson['birthday'], '1995-05-15');
      expect(outputJson['horoscope'], 'leo');
      expect(outputJson['zodiac'], 'lion');
      expect(outputJson['height'], 165);
      expect(outputJson['weight'], 60);
      expect(outputJson['id_user'], 'user456');
    });

    test('ProfileModel with null values', () {
      final profile = ProfileModel();

      expect(profile.displayName, isNull);
      expect(profile.birthday, isNull);
      expect(profile.horoscope, isNull);
      expect(profile.zodiac, isNull);
      expect(profile.height, isNull);
      expect(profile.weight, isNull);
      expect(profile.userId, isNull);
    });
  });
}
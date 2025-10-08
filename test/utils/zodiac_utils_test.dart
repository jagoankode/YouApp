import 'package:flutter_test/flutter_test.dart';
import 'package:you_app/utils/zodiac_utils.dart';

void main() {
  group('ZodiacUtils Tests', () {
    test('Zodiac calculation for Aries', () {
      String zodiac = ZodiacUtils.getZodiacSign('1990-04-01');
      expect(zodiac, 'aries');
    });

    test('Zodiac calculation for Taurus', () {
      String zodiac = ZodiacUtils.getZodiacSign('1990-05-01');
      expect(zodiac, 'taurus');
    });

    test('Zodiac calculation for Gemini', () {
      String zodiac = ZodiacUtils.getZodiacSign('1990-06-01');
      expect(zodiac, 'gemini');
    });

    test('Zodiac calculation for Cancer', () {
      String zodiac = ZodiacUtils.getZodiacSign('1990-07-01');
      expect(zodiac, 'cancer');
    });

    test('Zodiac calculation for Leo', () {
      String zodiac = ZodiacUtils.getZodiacSign('1990-08-01');
      expect(zodiac, 'leo');
    });

    test('Zodiac calculation for Virgo', () {
      String zodiac = ZodiacUtils.getZodiacSign('1990-09-01');
      expect(zodiac, 'virgo');
    });

    test('Zodiac calculation for Libra', () {
      String zodiac = ZodiacUtils.getZodiacSign('1990-10-01');
      expect(zodiac, 'libra');
    });

    test('Zodiac calculation for Scorpio', () {
      String zodiac = ZodiacUtils.getZodiacSign('1990-11-01');
      expect(zodiac, 'scorpio');
    });

    test('Zodiac calculation for Sagittarius', () {
      String zodiac = ZodiacUtils.getZodiacSign('1990-12-01');
      expect(zodiac, 'sagittarius');
    });

    test('Zodiac calculation for Capricorn (end of year)', () {
      String zodiac = ZodiacUtils.getZodiacSign('1990-12-25');
      expect(zodiac, 'capricorn');
    });

    test('Zodiac calculation for Capricorn (beginning of year)', () {
      String zodiac = ZodiacUtils.getZodiacSign('1990-01-10');
      expect(zodiac, 'capricorn');
    });

    test('Zodiac calculation for Aquarius', () {
      String zodiac = ZodiacUtils.getZodiacSign('1990-02-01');
      expect(zodiac, 'aquarius');
    });

    test('Zodiac calculation for Pisces', () {
      String zodiac = ZodiacUtils.getZodiacSign('1990-03-01');
      expect(zodiac, 'pisces');
    });

    test('Invalid date format returns empty string', () {
      String zodiac = ZodiacUtils.getZodiacSign('invalid-date');
      expect(zodiac, '');
    });

    test('Horoscope calculation matches zodiac', () {
      String birthday = '1990-04-01';
      String zodiac = ZodiacUtils.getZodiacSign(birthday);
      String horoscope = ZodiacUtils.getHoroscope(birthday);
      expect(zodiac, horoscope);
    });
  });
}
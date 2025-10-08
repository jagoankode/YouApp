class ZodiacUtils {
  // Define zodiac signs with their date ranges
  static const List<Map<String, dynamic>> zodiacSigns = [
    {
      'name': 'aries',
      'symbol': '♈',
      'startDate': {'month': 3, 'day': 21},
      'endDate': {'month': 4, 'day': 19},
    },
    {
      'name': 'taurus',
      'symbol': '♉',
      'startDate': {'month': 4, 'day': 20},
      'endDate': {'month': 5, 'day': 20},
    },
    {
      'name': 'gemini',
      'symbol': '♊',
      'startDate': {'month': 5, 'day': 21},
      'endDate': {'month': 6, 'day': 21},
    },
    {
      'name': 'cancer',
      'symbol': '♋',
      'startDate': {'month': 6, 'day': 22},
      'endDate': {'month': 7, 'day': 22},
    },
    {
      'name': 'leo',
      'symbol': '♌',
      'startDate': {'month': 7, 'day': 23},
      'endDate': {'month': 8, 'day': 22},
    },
    {
      'name': 'virgo',
      'symbol': '♍',
      'startDate': {'month': 8, 'day': 23},
      'endDate': {'month': 9, 'day': 22},
    },
    {
      'name': 'libra',
      'symbol': '♎',
      'startDate': {'month': 9, 'day': 23},
      'endDate': {'month': 10, 'day': 23},
    },
    {
      'name': 'scorpio',
      'symbol': '♏',
      'startDate': {'month': 10, 'day': 24},
      'endDate': {'month': 11, 'day': 21},
    },
    {
      'name': 'sagittarius',
      'symbol': '♐',
      'startDate': {'month': 11, 'day': 22},
      'endDate': {'month': 12, 'day': 21},
    },
    {
      'name': 'capricorn',
      'symbol': '♑',
      'startDate': {'month': 12, 'day': 22},
      'endDate': {'month': 1, 'day': 19}, // Spans to next year
    },
    {
      'name': 'aquarius',
      'symbol': '♒',
      'startDate': {'month': 1, 'day': 20},
      'endDate': {'month': 2, 'day': 18},
    },
    {
      'name': 'pisces',
      'symbol': '♓',
      'startDate': {'month': 2, 'day': 19},
      'endDate': {'month': 3, 'day': 20},
    },
  ];

  // Calculate zodiac sign based on birthday
  static String getZodiacSign(String birthday) {
    try {
      // Parse the birthday string
      List<String> dateParts = birthday.split('-');
      if (dateParts.length != 3) {
        return '';
      }
      
      //int year = int.parse(dateParts[0]); // Not used in zodiac calculation
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2]);
      
      // Find the matching zodiac sign
      for (var sign in zodiacSigns) {
        var startDate = sign['startDate'];
        var endDate = sign['endDate'];
        
        // Special case for Capricorn which spans across years
        if (sign['name'] == 'capricorn') {
          if ((month == 12 && day >= startDate['day']) || (month == 1 && day <= endDate['day'])) {
            return sign['name'];
          }
        } else {
          // Regular case for signs within the same year
          if (month == startDate['month'] && day >= startDate['day']) {
            return sign['name'];
          }
          if (month == endDate['month'] && day <= endDate['day']) {
            return sign['name'];
          }
          if (month > startDate['month'] && month < endDate['month']) {
            return sign['name'];
          }
        }
      }
      
      return ''; // Return empty string if no match found
    } catch (e) {
      return '';
    }
  }

  // Calculate horoscope based on birthday (similar to zodiac)
  static String getHoroscope(String birthday) {
    return getZodiacSign(birthday);
  }
}
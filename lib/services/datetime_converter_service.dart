import 'package:intl/intl.dart';

class DateTimeConverterService {
  String convertStringToDateTime(String time) {
    DateTime _tempDate = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
    String formattedTime = DateFormat("HH:mm").format(_tempDate);
    return formattedTime;
  }

  String timeRightNow() {
    final DateTime now = new DateTime.now();
    String formattedTime = DateFormat("HH:mm").format(now);
    return formattedTime;
  }

  String todaysDay() {
    final DateTime now = new DateTime.now();
    final int d = int.parse(DateFormat('d').format(now));
    return DateFormat('MMMMd').format(now) + _getDayOfMonthSuffix(d);
  }

  String _getDayOfMonthSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }

    switch (dayNum % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}

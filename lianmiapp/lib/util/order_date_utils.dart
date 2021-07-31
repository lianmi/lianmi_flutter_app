import 'package:date_format/date_format.dart';

class OrderDateUtils {
  ///订单Flag显示的时间
  static String orderTimeFromTimeMillis(int timeMillis) {
    DateTime _dateTime = DateTime.fromMillisecondsSinceEpoch(timeMillis);
    String _r = formatDate(_dateTime, [yyyy, '年', m, '月', d, '日']);
    return _r;
  }

  ///订单完整的时间
  static String orderTimeFullFromTimeMillis(int timeMillis) {
    DateTime _dateTime = DateTime.fromMillisecondsSinceEpoch(timeMillis);
    String _r = formatDate(_dateTime, [yyyy, '-', m, '-', d]);
    _r = "${numberUtils(_dateTime.year)}-${numberUtils(_dateTime.month)}-${numberUtils(_dateTime.day)} ";
    _r += " ${_dateTime.hour}:${numberUtils(_dateTime.minute)}";
    return _r;
  }

  static numberUtils(int number) {
    if (number < 10) {
      return "0${number.toString()}";
    }
    return number.toString();
  }
}
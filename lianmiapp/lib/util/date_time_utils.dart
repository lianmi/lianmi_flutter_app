import 'package:common_utils/common_utils.dart';
import 'package:date_format/date_format.dart';

class DateTimeUtils {
  ///获取当前时间戳
  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  ///从时间戳转换成需要的时间
  static String currentTargetTimeFromTimeMillis(int timeMillis) {
    DateTime _dateTime = DateTime.fromMillisecondsSinceEpoch(timeMillis);
    String _r = formatDate(_dateTime, [yyyy, '-', mm, '-', dd]);
    _r =
        "$_r ${numberUtils(_dateTime.hour)}:${numberUtils(_dateTime.minute)}:${numberUtils(_dateTime.second)}";
    return currentTargetTimeFromDateTimeText(_r);
  }

  ///转换成需要的时间
  static String currentTargetTimeFromDateTimeText(String dateTimeText) {
    if (dateTimeText != null &&
        dateTimeText.runtimeType != Null &&
        dateTimeText != "") {
      ///字符串类型转换成时间戳
      int _maturityTim = DateTime.parse(dateTimeText).millisecondsSinceEpoch;

      ///创建时间戳 转换为 DateTime对象
      DateTime _dateTime = DateTime.fromMillisecondsSinceEpoch(_maturityTim);

      ///超出一年
      if (_dateTime.year != DateTime.now().year) {
        String _r = formatDate(_dateTime, [yyyy, '年', m, '月', d, '日']);
        return "$_r ${_dateTime.hour}:${numberUtils(_dateTime.minute)}";
      } else {
        ///间隔时间 = 当前时间 - 创建时间   单位：分钟
        int _m = DateTime.now().difference(_dateTime).inMinutes.abs();

        ///一小时以内
        if (_m < 1) {
          return "刚刚";
        } else if (_m < 60) {
          return "${_m}分钟前";
        }

        ///当天
        if (DateUtil.isToday(_maturityTim)) {
          ///12点之前 上午
          return "${_dateTime.hour}:${numberUtils(_dateTime.minute)}";
        }

        ///前一天
        if ((DateTime.now().day - _dateTime.day) == 1) {
          return "昨天 ${_dateTime.hour}:${numberUtils(_dateTime.minute)}";
        }

        ///一周以内 不建议用 时间信息不够明确
        if ((DateTime.now().day - _dateTime.day) <= 7) {
          String _x = DateUtil.getWeekday(
              DateTime.fromMillisecondsSinceEpoch(
                  _dateTime.millisecondsSinceEpoch),
              languageCode: "zh");

          List<String> weeks = ['一', '二', '三', '四', '五', '六', '日'];
          String targetWeek = _x.substring(2);
          String todayWeek =
              DateUtil.getWeekday(DateTime.now(), languageCode: "zh")
                  .substring(2);

          if (weeks.indexOf(targetWeek) < weeks.indexOf(todayWeek)) {
            return "$_x ${_dateTime.hour}:${numberUtils(_dateTime.minute)}";
          }
        }

        ///其他样式 6月01日 下午17:54
        ///12点之前 上午
        return "${_dateTime.month}月${_dateTime.day}日 ${_dateTime.hour}:${numberUtils(_dateTime.minute)}";
      }
    }
    return "";
  }

  ///转换成动态聊天室头部标题的时间
  static String currentDynamicChatoomTitleTimeFromTimeSecond(int timeSecond) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeSecond);
    return '${dateTime.month}.${dateTime.day}';
    // String _r = formatDate(_dateTime, [yyyy, '-', mm, '-', dd]);
    // _r = "$_r ${numberUtils(_dateTime.hour)}:${numberUtils(_dateTime.minute)}:${numberUtils(_dateTime.second)}";
    // return currentTargetTimeFromDateTimeText(_r);
  }

  static String convertToTargetCallTime(int seconds) {
    var d = Duration(seconds: seconds);
    List<String> parts = d.toString().split(':');
    String targetText = '';
    if (int.parse(parts[0]) > 0) {
      targetText += '${parts[0]}:';
    }
    String second = parts[2].split('.').first;
    targetText += '${parts[1]}:$second';
    return targetText;
  }

  static String orderTimeFromTimestamp(int timestamp) {
    DateTime _dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String _r = formatDate(
        _dateTime, [yyyy, '/', mm, '/', dd, ' ', H, ':', nn, ':', ss]);
    return _r;
  }

  ///时间值转换
  ///2:1  => 02 : 01
  static numberUtils(int number) {
    if (number < 10) {
      return "0${number.toString()}";
    }
    return number.toString();
  }
}
